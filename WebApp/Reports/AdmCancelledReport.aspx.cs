using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Reports_AdmCancelledReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
     
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string add = "", tempadd = "";
            Label lblAddress = (Label)e.Row.FindControl("lblAddress");
            add = lblAddress.Text.Replace(",", " ").Trim();
            tempadd = add.ToString().Replace("    ", "");
            tempadd = tempadd.ToString().Replace("  ", ",");
            lblAddress.Text = tempadd;
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (gvIPCreditMain.Rows.Count > 0)
            {
                string attachment = "attachment; filename=AdmissionCancelled_Report" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/ms-excel";
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
                gvIPCreditMain.RenderControl(oHtmlTextWriter);
                Response.Write(oStringWriter.ToString());
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Converting to Excel.", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string requestType = rblVisitType.SelectedItem.Text;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            
            returnCode = new Report_BL(base.ContextInfo).GetAdmCancelledReport(fDate, tDate, OrgID, out lstDWCR);

            if (lstDWCR.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                lblTotal.Visible = false;
                
                gvIPCreditMain.Visible = true;
                gvIPCreditMain.DataSource = lstDWCR;
                gvIPCreditMain.DataBind();
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
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
