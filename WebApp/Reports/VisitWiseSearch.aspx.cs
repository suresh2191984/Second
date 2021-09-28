using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Data;

public partial class Reports_VisitWiseSearch : BasePage
{
    long returnCode = -1;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string defaultText = string.Empty;
    string defaultText1 = string.Empty;
    List<InvestigationStatus> lstInvestigationStatus = new List<InvestigationStatus>();
    List<InvestigationStatus> lstInvestigationSampleStatus = new List<InvestigationStatus>();

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteProduct.ContextKey = "NameandNumber";
        AutoCompleteExtenderRefPhy.ContextKey = "RPH";
        txtFrom.Attributes.Add("onchange", "CheckFromDate('" + txtFrom.ClientID.ToString() + "');");
        txtTo.Attributes.Add("onchange", "CheckToDate('" + txtTo.ClientID.ToString() + "');");
        HdnOrgZoneTime.Value = OrgDateTimeZone.Substring(0, 10) + " 12:00:00AM";
        DateTime FromOrgDateTime = Convert.ToDateTime(HdnOrgZoneTime.Value);
        String Time = "";
        Time = string.Format("{0:dd-MMM-yyyy}", FromOrgDateTime);
        txtFrom.Text = Time + " 12:00AM";
        HdnOrgZoneTime.Value = "";
        HdnOrgZoneTime.Value = OrgDateTimeZone.Substring(0, 10) + " 11:59PM";
        DateTime ToOrgDateTime = Convert.ToDateTime(HdnOrgZoneTime.Value);
        Time = "";
        Time = string.Format("{0:dd-MMM-yyyy}", ToOrgDateTime);
        txtTo.Text = Time + " 11:59PM";
        HdnOrgZoneTime.Value = "";



        if (txtIdentityNumber != null)
        {
            defaultText = "Mobile Number";
        }
        if (txtVisitNo != null)
        {
            defaultText1 = "Visit Number";
        }
        txtwatermark();
        if (!IsPostBack) {

            LoadOrganizations();
            if (ddlOrganization.Items.Count > 0)
            {
                ddlOrganization.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID);
            LoadSampleStatus();
        }

    }
    public void LoadSampleStatus()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(out lstInvestigationStatus, out lstInvestigationSampleStatus);

        var lstStatus = from c in lstInvestigationStatus where c.DisplayText == "Approve" || c.DisplayText == "Pending" || c.DisplayText == "Cancel" orderby c.InvestigationStatusID select c;
        ddlVisitStatus.DataSource = lstStatus;
        ddlVisitStatus.DataTextField = "DisplayText";
        ddlVisitStatus.DataValueField = "InvestigationStatusID";
        ddlVisitStatus.DataBind();
        ddlVisitStatus.Items.Insert(0, new ListItem("ALL"));
        ddlVisitStatus.Items[0].Value = "0";
    }
    protected void LoadOrganizations()
    {
        try
        {
            AdminReports_BL AdminReportsBL = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrganizations = new List<Organization>();
            long lngReturnCode = 0;
            lngReturnCode = AdminReportsBL.GetSharingOrganizations(OrgID, out lstOrganizations);

            ddlOrganization.DataSource = lstOrganizations;
            ddlOrganization.DataTextField = "Name";
            ddlOrganization.DataValueField = "OrgID";
            ddlOrganization.DataBind();
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadOrganizations", ex);
        }
    }
    protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadlocations(RoleID,Convert.ToInt16(ddlOrganization.SelectedValue));
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            if (lstLocation.Count > 0)
            {
                    ddlLocation.DataSource = lstLocation;
                    ddlLocation.DataTextField = "Location";
                    ddlLocation.DataValueField = "AddressID";
                    ddlLocation.DataBind();

                    ddlLocation.Items.Insert(0, "ALL");
                    ddlLocation.Items[0].Value = "0";
                    //ddlLocation1.Items[0].Selected = true;
                    //ddlLocation1.SelectedItem.Value = ILocationID.ToString();
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadLocation", ex);
        }
    }
    public void txtwatermark()
    {
        if (txtIdentityNumber.Text.Trim() != defaultText.Trim())
        {
            txtIdentityNumber.Attributes.Add("style", "color:black");
        }
        if (txtIdentityNumber.Text == "")
        {
            txtIdentityNumber.Text = defaultText;
            txtIdentityNumber.Attributes.Add("style", "color:gray");
        }
        txtIdentityNumber.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtIdentityNumber.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

        if (txtVisitNo.Text.Trim() != defaultText1.Trim())
        {
            txtVisitNo.Attributes.Add("style", "color:black");
        }
        if (txtVisitNo.Text == "")
        {
            txtVisitNo.Text = defaultText1;
            txtVisitNo.Attributes.Add("style", "color:gray");
        }
        txtVisitNo.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText1 + "');");
        txtVisitNo.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText1 + "');");
    }
    
}
