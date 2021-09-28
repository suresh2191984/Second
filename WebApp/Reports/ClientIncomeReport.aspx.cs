using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;



public partial class Reports_ClientIncomeReport : BasePage
{
    long returnCode = -1;
    Report_BL reportBL;
    List<Invoice> lstResult = new List<Invoice>();
    int RowCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        reportBL = new Report_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                LoadOrganizations();
                SetContext();
            }
        }
        catch (Exception ex)
        {
           
            CLogger.LogError("Error in TPACORPOutstandingReport.aspx:Page_Load", ex);
        }
        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");
    }
    public void SetContext()
    {
        string ClientID = hdnClientID.Value;
        AutoCompleteExtenderClientCorp.ContextKey = "";
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
    protected void btnGo_Click(object sender, EventArgs e)
    {

        DateTime dFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone); // Convert.ToDateTime(txtFromDate.Text).ToShortDateString();
        DateTime.TryParse(txtFromDate.Text, out dFromDate);
        DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime.TryParse(txtToDate.Text, out ToDate); 
        Int64 drpClientID = Convert.ToInt64(hdnClientID.Value);
        DataSet ds = new DataSet();
        reportBL.getClientIncome_Report(dFromDate, ToDate, OrgID, drpClientID, txtClient.Text, out ds, out RowCount);
        if (ds.Tables[0].Rows.Count>0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = ds;
            grdResult.DataBind();
        }
        else
        {
            grdResult.Visible = false;
            string sPath = "No Matching Records found for the selected dates";
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('" + sPath + "');", true);
        }
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

     protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
     {
       if (e.NewPageIndex != -1)
       {
           grdResult.PageIndex = e.NewPageIndex;
         btnGo_Click(sender, e);
         }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");
        //DateTime dFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone); // Convert.ToDateTime(txtFromDate.Text).ToShortDateString();
        //DateTime.TryParse(txtFromDate.Text, out dFromDate);
        //DateTime dToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //DateTime.TryParse(txtToDate.Text, out dToDate);
        DataSet ds = new DataSet();
        Int64 drpClientID = Convert.ToInt64(hdnClientID.Value);

        reportBL.getClientIncome_Report(Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text + " 23:59:58"), OrgID, drpClientID, txtClient.Text, out ds, out RowCount);
        //var lstInvoice = (from fb in lstResult
        //                    select new { fb.ReceivedAmt, fb.InvoiceNumber, fb.ReceivedDate, fb.PaymentMode, fb.ReceivedBy });

        hdnClientID.Value = "0";
        txtClient.Text = string.Empty;
        if (ds.Tables.Count > 0 && RowCount > 0)
        {

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ClientIncomeReport.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    DataGrid dg = new DataGrid();
                    for (int i = 0; i < ds.Tables.Count; i++)
                    {
                        dg.DataSource = ds.Tables[i];
                        dg.DataBind();
                        dg.RenderControl(htw);
                        htw.WriteLine("<br>");
                    }
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
        else
        {
            string sPath = "No Matching Records found for the selected dates";
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('" + sPath + "');", true);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}

