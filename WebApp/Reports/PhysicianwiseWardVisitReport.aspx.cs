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
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Globalization;

public partial class Reports_PhysicianWiseWardVisitReport : BasePage
{
    long returnCode = -1;
    AdminReports_BL arBL;
    List<Patient> lstPatient = new List<Patient>();
    Physician_BL PhysicianBL;
    List<Physician> lstPhysician = new List<Physician>();
    protected void Page_Load(object sender, EventArgs e)
    {
        arBL = new AdminReports_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
                LoadPhysicians(lstPhysician);
                txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            }
                  }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in PhysicianWiseWardVisitReport.aspx:Page_Load", ex);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        DateTime dFromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime dToDate = Convert.ToDateTime(txtTo.Text);
        long physicianID = Convert.ToInt64(ddlDrName.SelectedValue);
//        arBL.GetPhysicianWiseCollectionSummary(OrgID, physicianID, dFromDate, dToDate, out lstCashFlowSummary, out lstCashFlowSummarySubTotal);
        arBL.GetPhysicianWiseWardVisit(dFromDate, dToDate,physicianID,ILocationID, out lstPatient);
       
     
        if (lstPatient.Count > 0)
       {
           grdResult.Visible = true;
           lblResult.Visible = false;
           grdResult.DataSource = lstPatient;
           grdResult.DataBind();
           excelTab.Style.Add("display", "block");
       }
       else
       {
           grdResult.Visible = false;
           lblResult.Visible = true;
           excelTab.Style.Add("display", "none");
           lblResult.Text = "No Matching Records Found!";
       }
        
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }

   

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void LoadPhysicians(List<Physician> phySch)
    {
        if (phySch.Count > 0)
        {
            var lstphy = (from phy in phySch select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
            ddlDrName.DataSource = lstphy;
            //ddlDrName.DataSource = phySch;
            ddlDrName.DataTextField = "PhysicianName";
            ddlDrName.DataValueField = "PhysicianID";
            ddlDrName.DataBind();
            ddlDrName.Items.Insert(0, "-----Show All-----");
            ddlDrName.Items[0].Value = "0";
        }
    }
    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=Physician_WiseWard_Report"+Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString()+".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdResult.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianWiseWardVisitReport", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
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
