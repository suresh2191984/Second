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

public partial class Reports_CreditLimitReport : BasePage
{
    long returnCode = -1;
    Report_BL reportBL;
    List<Patient> lstResult = new List<Patient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        reportBL = new Report_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        reportBL.GetCreditLimitReport(txtFromDate.Text, txtToDate.Text, OrgID, "", out lstResult);
        if (lstResult.Count > 0)
        {

            grdResult.Visible = true;
            grdResult.DataSource = lstResult;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = "";
            grdResult.DataBind();
            grdResult.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('No Datas Found');", true);
        }
    }
    protected string UpperBillableCalc(object AdvanceAmount, object PreAuthAmount, object CreditLimit)
    {
        decimal ubc = 0;
        ubc = ((decimal)AdvanceAmount + (decimal)PreAuthAmount + (decimal)CreditLimit);
        return ubc.ToString("0.00");
    }
    protected string Burnt(object BillAmount,object AdvanceAmount, object PreAuthAmount, object CreditLimit)
    {
        decimal bnt = 0;
        if (((decimal)AdvanceAmount + (decimal)PreAuthAmount + (decimal)CreditLimit) > 0)
        {
            bnt = ((decimal)BillAmount / ((decimal)AdvanceAmount + (decimal)PreAuthAmount + (decimal)CreditLimit));
        }
        return bnt.ToString("0.00");
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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "CreditLimitReport.xls"));
        HttpContext.Current.Response.ContentType = "application/ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                btnGo_Click(sender, e);
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
