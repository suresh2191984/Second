using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.IO;
using System.Text;
using AjaxControlToolkit;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PharmacyTransactionDetailReport : Attune_BasePage
{
    long returnCode = -1;
    int index = 0;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstDWCR1 = new List<DayWiseCollectionReport>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            //txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
            txtFromDate.Text = System.DateTime.Today.ToExternalDate();
            txtToDate.Text = System.DateTime.Today.ToExternalDate();

        }
    }
    public void LoadDetils()
    {
        lblReport.Text = " Pharmacy Transaction Details " + " " + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString();
        int iBillGroupID = 0;
        List<Config> lstConfig = new List<Config>();
        iBillGroupID = (int)ReportType.IPBill;

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        //if (lstConfig.Count > 0)
        //{
        //    imgPath.Src = lstConfig[0].ConfigValue.Trim().Replace("..", System.Configuration.ConfigurationManager.AppSettings["ApplicationName"].ToString());
        //}

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

        //if (lstConfig.Count > 0)
        //{
        //    lblHosital.Text = lstConfig[0].ConfigValue.Trim();
        //}

        InventoryReports_BL objBl = new InventoryReports_BL(base.ContextInfo);
        lstDWCR = new List<DayWiseCollectionReport>();
        lstDWCR1 = new List<DayWiseCollectionReport>();
        DateTime FromDate = txtFromDate.Text.ToInternalDate();
        DateTime ToDate = txtToDate.Text.ToInternalDate();
        int Orgid = OrgID;
        string BillType = "PRM";
        int visitType = Convert.ToInt32(rbtVisitType.SelectedValue);
        
        objBl.GetTypewiseBillingDetailsReport(FromDate, ToDate, BillType, Orgid, out lstDWCR, out lstDWCR1, visitType);
        
        if (lstDWCR.Count > 0)
        {
            grdSummary.Visible = false;
            grdSummary.DataSource = null;
            grdSummary.DataBind();

            tbTotalCal.Style.Add("display", "block");
            grdResult.Visible = true;
            grdResult.DataSource = lstDWCR;
            grdResult.DataBind();

            lblCashAmounttxt.Text = lstDWCR1[0].BillAmount.ToString("0.00");
            lblCreditamounttxt.Text = lstDWCR1[1].BillAmount.ToString("0.00");  
            lblAdvaceAmttxt.Text = lstDWCR1[2].BillAmount.ToString("0.00");
            if(lstDWCR1[8].BillAmount>0)
            lbldiscountamttxt.Text = lstDWCR1[9].BillAmount.ToString("0.00");
            lblGrandTotalText.Text = lstDWCR1[3].BillAmount.ToString("0.00");
            if (lstDWCR1[4].BillAmount > 0)
            {
                lblRefundAmttxt.Text = "(-)" + lstDWCR1[4].BillAmount.ToString("0.00");
            }
            else
            {
                lblRefundAmttxt.Text = "0.00";
            }  
            lblCashInHandtxt.Text = (lstDWCR1[5].BillAmount -lstDWCR1[8].BillAmount).ToString("0.00");
            if (lstDWCR1[6].BillAmount != 0)
            {
                lblCashReturnSaletxt.Text = lstDWCR1[6].BillAmount.ToString("0.00").Replace("-", "");
            }
            if (lstDWCR1[7].BillAmount != 0)
            {
                lblRefundCrdeitReturntxt.Text = lstDWCR1[7].BillAmount.ToString("0.00").Replace("-", "");
            }
            lblGrandTotalAmounttxt.Text = lstDWCR1[8].BillAmount.ToString("0.00");
        }
        else
        {
            tbTotalCal.Style.Add("display", "none");
            grdResult.Visible = false;
            grdResult.DataSource = null;
            grdResult.DataBind();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert(' No Match Record ');", true);
        }
        //  BindInPatientSearch(lstDWCR);
    }

    public void loadSummary()
    {
        lblReport.Text = " Pharmacy Transaction Summary " + " " + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString();

        InventoryReports_BL objBL = new InventoryReports_BL(base.ContextInfo);
        lstDWCR = new List<DayWiseCollectionReport>();
        DateTime FromDate = txtFromDate.Text.ToInternalDate();
        DateTime ToDate = txtToDate.Text.ToInternalDate();
        int Orgid = OrgID;
        string BillType = "PRM";
        int visitType = Convert.ToInt32(rbtVisitType.SelectedValue);

        objBL.GetTypewiseBillingSummaryReport(FromDate, ToDate, BillType, Orgid, out lstDWCR, visitType);
        
        if (lstDWCR.Count > 0)
        {
            tbTotalCal.Style.Add("display", "none");
            grdResult.Visible = false;
            grdResult.DataSource = null;
            grdResult.DataBind();

            grdSummary.Visible = true;
            grdSummary.DataSource = lstDWCR;
            grdSummary.DataBind();
        }
        else
        {
            grdSummary.Visible = false;
            grdSummary.DataSource = null;
            grdSummary.DataBind();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert(' No Match Record ');", true);
        }
    }

    protected void BindInPatientSearch(List<DayWiseCollectionReport> lstAccountReport)
    {
        string strIPRow = string.Empty;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rdotypes.SelectedItem.Value.ToLower().Contains("details"))
        {
            LoadDetils();
        }
        else
        {
            loadSummary();
        }
    }

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        if (rdotypes.SelectedItem.Value.ToLower().Contains("details"))
        {
            ExportToExcel(prnReport);
        }
        else
        {
            ExportToExcel(prnSummary);
        }
    }
    public void ExportToExcel(Control CTRl)
    {
        try
        {

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Pharmacy Transaction Details Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    CTRl.RenderControl(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Pharmacy Transcation Details Report-ExportToExcel", ioe);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
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

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='hover'");
                e.Row.Attributes.Add("onmouseout", "this.className='hout'");
                index = e.Row.RowIndex;
                if (lstDWCR[index].BillType.Equals("Advance"))
                {
                    e.Row.BackColor = System.Drawing.Color.LightGray;
                    e.Row.ToolTip = "This is Cash Receipt";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound - RefundtoPatient.aspx", ex);
        }
    }

    protected void grdviewSummary_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='hover'");
                e.Row.Attributes.Add("onmouseout", "this.className='hout'");
                index = e.Row.RowIndex;
                if (lstDWCR[index].BillType.Equals("Advance"))
                {
                    e.Row.BackColor = System.Drawing.Color.LightGray;
                    e.Row.ToolTip = "This is Cash Receipt";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdviewSummary_RowDataBound - RefundtoPatient.aspx", ex);
        }
    }
}
