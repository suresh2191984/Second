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

public partial class Reports_IPBilledVsActualReport : BasePage
{
    long returnCode = -1;
    AdminReports_BL arBL;
    List<FinalBill> lstFinalBill = new List<FinalBill>();
    protected void Page_Load(object sender, EventArgs e)
    {
        arBL = new AdminReports_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
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
        string serviceType = ddlServiceType.SelectedValue;
        DateTime dFromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime dToDate = Convert.ToDateTime(txtTo.Text);
        arBL.GetIPBilledVsActuals(OrgID, dFromDate, dToDate, serviceType, out lstFinalBill);
        if (lstFinalBill.Count > 0)
       {
           grdResult.Visible = true;
           lblResult.Visible = false;
           grdResult.DataSource = lstFinalBill;
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

    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=Reports.xls";
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
}
