using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;
using System.Net;
using System.Xml;
using System.Data;
using Attune.Podium.ExcelExportManager;
using System.IO;


public partial class Investigation_WriteOffReport : BasePage
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMetaData();
            LoadOrganizations();
            GetClientType();
            if (ddlOrganization.Items.Count > 0)
            {
                ddlOrganization.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID);
            txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            AutoCompleteExtenderPatient.ContextKey = OrgID.ToString();
        }
    }
    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ListItem lstItem = new ListItem();
                lstItem.Text = "---------Select---------";
                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
        }
    }

    protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLocationsCall();
        showHideDetails();
        AutoCompleteExtenderPatient.ContextKey = ddlOrganization.SelectedItem.Value;
    }
    private void LoadLocationsCall()
    {
        try
        {
            if (ddlOrganization.Items.Count > 0 && ddlOrganization.SelectedItem.Value != "0")
            {
                loadlocations(RoleID, Convert.ToInt32(ddlOrganization.SelectedItem.Value));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadLocationCall", ex);
        }
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
    protected void loadlocations(long uroleID, int intOrgID)
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        drpLocation.DataSource = lstLocation;
        drpLocation.DataTextField = "Location";
        drpLocation.DataValueField = "AddressID";
        drpLocation.DataBind();

        if (lstLocation.Count == 1)
        {
            drpLocation.Items.Insert(0, "------SELECT------");
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            drpLocation.Items.Insert(0, "------SELECT------");
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "WriteOffType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childProcessItems = from child in lstmetadataOutput
                                        where child.Domain == "WriteOffType" //orderby child .MetaDataID
                                        select child;

                ddlWriteOffType.DataSource = childProcessItems;
                ddlWriteOffType.DataTextField = "DisplayText";
                ddlWriteOffType.DataValueField = "Code";
                ddlWriteOffType.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);
        }
    }
    public void showHideDetails()
    {
        if (ddlWriteOffType.SelectedItem.Text == "Billing")
        {
            tblPatient.Style.Add("display", "block");
            tblPatientName.Style.Add("display", "block");
            tblClientTypeName.Style.Add("display", "none");
            tblClient.Style.Add("display", "none");
            tblClientType.Style.Add("display", "none");
            tblClientName.Style.Add("display", "none");
        }
        else
        {
            tblPatient.Style.Add("display", "none");
            tblPatientName.Style.Add("display", "none");
            tblClientTypeName.Style.Add("display", "block");
            tblClient.Style.Add("display", "block");
            tblClientType.Style.Add("display", "block");
            tblClientName.Style.Add("display", "block");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long WriteOffID = ddlWriteOffType.SelectedValue == "Billing" ? Convert.ToInt64(hdnSelectedPatientID.Value) : Convert.ToInt64(hdnSelectedClientID.Value);
            int pLocationID = Convert.ToInt32(drpLocation.SelectedValue);
            string WriteOffType = ddlWriteOffType.SelectedValue;
            int intOrgID = Convert.ToInt32(ddlOrganization.SelectedValue);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            DateTime fromDate = txtFromDate.Text.Trim() != string.Empty && Convert.ToDateTime(txtFromDate.Text.Trim()) != null ? Convert.ToDateTime(txtFromDate.Text.Trim()) : Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime toDate = txtToDate.Text.Trim() != string.Empty && Convert.ToDateTime(txtToDate.Text.Trim()) != null ? Convert.ToDateTime(txtToDate.Text.Trim()) : Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            List<PatientDueDetails> lstWriteOffDetail = new List<PatientDueDetails>();
            Report_BL ReportBL = new Report_BL(base.ContextInfo);
            returnCode = ReportBL.GetWriteOffReportDetail(fromDate, toDate, intOrgID, pLocationID, WriteOffID, WriteOffType, ClientTypeID, out lstWriteOffDetail);
            if (lstWriteOffDetail.Count > 0)
            {
                divPrintReport.Style.Add("display", "block");
            }
            else
            {
                divPrintReport.Style.Add("display", "none");
            }
            if (ddlWriteOffType.SelectedValue == "Billing")
            {
                grdWriteoffInvoiceReport.DataSource = null;
                grdWriteoffInvoiceReport.DataBind();
                grdWriteoffInvoiceReport.Style.Add("display", "none");
                grdWriteOffBillingReport.Style.Add("display", "block");
                grdWriteOffBillingReport.DataSource = lstWriteOffDetail;
                grdWriteOffBillingReport.DataBind();
            }
            else
            {
                grdWriteOffBillingReport.DataSource = null;
                grdWriteOffBillingReport.DataBind();
                grdWriteoffInvoiceReport.Style.Add("display", "block");
                grdWriteOffBillingReport.Style.Add("display", "none");
                grdWriteoffInvoiceReport.DataSource = lstWriteOffDetail;
                grdWriteoffInvoiceReport.DataBind();
            }
            showHideDetails();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
    protected void imgbtnExportToExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=WriteOff_Reports_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            if (ddlWriteOffType.SelectedValue == "Billing")
            {
                pnlWriteOffBillingReport.RenderControl(oHtmlTextWriter);
            }
            else
            {
                pnlWriteoffInvoiceReport.RenderControl(oHtmlTextWriter);
            }
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, WriteOff_Reports_", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
}