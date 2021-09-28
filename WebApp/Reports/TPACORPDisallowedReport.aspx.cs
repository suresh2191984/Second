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
using System.Globalization;



public partial class Reports_TPACORPDisallowedReport :  BasePage
{
    public Reports_TPACORPDisallowedReport()
        : base("Reports_TPACORPDisallowedReport_aspx")
    {

    }
   
    long returnCode = -1;
    Report_BL reportBL;
    List<Patient> lstResult = new List<Patient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        reportBL = new Report_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = OrgTimeZone;
                txtToDate.Text = OrgTimeZone;
            }
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in TPACORPOutstandingReport.aspx:Page_Load", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Reports_ClientDisplay.Reports_TPACORPDisallowedReport_Alert == null ? "Alert" : Resources.Reports_ClientDisplay.Reports_TPACORPDisallowedReport_Alert;
        string UsrMsgWin = Resources.Reports_ClientDisplay.Reports_TPACORPDisallowedReport_aspx == null ? "No Matching Records found for the selected dates" : Resources.Reports_ClientDisplay.Reports_TPACORPDisallowedReport_aspx;
        DateTime dFromDate = DateTime.ParseExact(txtFromDate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture); 
        //DateTime.TryParse(txtFromDate.Text, out dFromDate);
        DateTime dToDate = DateTime.ParseExact(txtToDate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture); 
       // DateTime.TryParse(txtToDate.Text, out dToDate);

        reportBL.GetTPACORPoutstandingreport(dFromDate,dToDate,OrgID,3,out lstResult);
        if (lstResult.Count > 0)
        {
            
            grdResult.Visible = true;
            grdResult.DataSource = lstResult;
            grdResult.DataBind();
        }
        else
        {
            grdResult.Visible = false;
           // string sPath = "No Matching Records found for the selected dates";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
            //ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('"+ sPath +"');", true);
        }

    }
    protected string CalcPatientDueAmount(object NetAmount, object TPABillAmount, object ReceivedAmount)
    {

        decimal c = 0;
        c = (((decimal)NetAmount - (decimal)TPABillAmount) - (decimal)ReceivedAmount);
        //if (c < 0)
        //    c = 0;
        return c.ToString("0.00");
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
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "DaywiseAdmissionDischargereport.xls"));
        HttpContext.Current.Response.ContentType = "application/ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                grdResult.RenderControl(htw);
                //gvIPCreditMain.RenderEndTag(htw);
                HttpContext.Current.Response.Write(sw.ToString());
                HttpContext.Current.Response.End();


            }
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}

