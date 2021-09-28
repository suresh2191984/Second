using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Admin_InvestigationSamplesReport : BasePage
{
    long returnCode = -1;
    DateTime fDate;
    DateTime tDate;
    int hospitalID, physicianID = 0;

    List<PatientVisit> lSamplesReport = new List<PatientVisit>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            trDoctor.Style.Add("display", "none");
            flagSetter.Value = "1";
            LoadHospital();
            LoadReferingPhysician();
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        }
        if (flagSetter.Value == "1")
        {
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "block");
        }
        else
        {
            trHospital.Style.Add("display", "none");
            trDoctor.Style.Add("display", "block");
        }
    }
    public void LoadReferingPhysician()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();
            retCode = patBL.GetReferingPhysician(OrgID,"", "D",out getReferingPhysician);
            if (retCode == 0)
            {
                ddlPhysician.DataSource = getReferingPhysician;
                ddlPhysician.DataTextField = "PhysicianName";
                ddlPhysician.DataValueField = "ReferingPhysicianID";
                ddlPhysician.DataBind();
                ddlPhysician.Items.Insert(0, "-----Select-----");
                ddlPhysician.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Physician Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void LoadHospital()
    {
        try
        {

            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            retCode = patBL.GetLabRefOrg(OrgID, 0, "",out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgName";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        fDate = Convert.ToDateTime(txtFrom.Text);
        tDate = Convert.ToDateTime(txtTo.Text);
        hospitalID=Convert.ToInt32(ddlHospital.SelectedValue);
        physicianID = Convert.ToInt32(ddlPhysician.SelectedValue);
        returnCode = new AdminReports_BL(base.ContextInfo).GetSamplesReport(hospitalID, physicianID, fDate, tDate, OrgID, out lSamplesReport);
        if (lSamplesReport.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lSamplesReport;
            grdResult.DataBind();
            lblResult.Visible = false;
        }
        else
        {
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
            grdResult.Visible = false;
            
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        fDate = Convert.ToDateTime(txtFrom.Text);
        tDate = Convert.ToDateTime(txtTo.Text);
        hospitalID = Convert.ToInt32(ddlHospital.SelectedValue);
        physicianID = Convert.ToInt32(ddlPhysician.SelectedValue);
        returnCode = new AdminReports_BL(base.ContextInfo).GetSamplesReport(hospitalID, physicianID, fDate, tDate, OrgID, out lSamplesReport);
        if (lSamplesReport.Count > 0)
        {
            grdResult.DataSource = lSamplesReport;
            grdResult.DataBind();
            lblResult.Visible = false;
        }
    }
}
