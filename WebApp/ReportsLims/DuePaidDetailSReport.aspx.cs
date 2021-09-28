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
using Attune.Podium.ExcelExportManager;

public partial class Reports_DuePaidDetailSReport : BasePage
{
    List<DuePaidDetail> lstDuePaidDetail;
    Report_BL objReport_BL;
    DataSet ds = new DataSet();
    Dictionary<string, decimal> dicpagetotal = new Dictionary<string, decimal>();
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        try
        {
            List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
            masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            if (!IsPostBack)
            {
                BindDuePaidReport();
                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
                masterBL.GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
                if (lstCurrOrgMapp.Count > 0)
                {
                    ddlCurrency.DataSource = lstCurrOrgMapp;
                    ddlCurrency.DataTextField = "CurrencyName";
                    ddlCurrency.DataValueField = "CurrencyID";
                    ddlCurrency.DataBind();
                    ddlCurrency.Items.Insert(0, "-----All-----");
                    ddlCurrency.Items[0].Value = "0";
                    ddlCurrency.SelectedValue = BaseCurrencyID.ToString();
                    if (lstCurrOrgMapp.Count > 1)
                    {
                        tabCurrency.Style.Add("display", "block");
                    }
                    else
                    {
                        tabCurrency.Style.Add("display", "none");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Page_Load", ex);
        }
    }
    public DataTable loaddata(List<DuePaidDetail> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("DueBillNo");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("Age");
        DataColumn dcol2 = new DataColumn("BillAmount");
        DataColumn dcol5 = new DataColumn("PaidAmount");
        DataColumn dcol6 = new DataColumn("PaidBillNo");
        DataColumn dcol7 = new DataColumn("PaidDate");
        DataColumn dcol8 = new DataColumn("DueCollectedBy");
        DataColumn dcol9 = new DataColumn("ReceivedBy");
        DataColumn dcol10 = new DataColumn("Address");
        DataColumn dcol11 = new DataColumn("ContactNo");
        DataColumn dcol12 = new DataColumn("DueBillDate");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);

        foreach (DuePaidDetail item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["DueBillNo"] = item.DueBillNo;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["BillAmount"] = item.BillAmount;
            dr["PaidAmount"] = item.PaidAmount;
            dr["PaidBillNo"] = item.PaidBillNo;
            dr["PaidDate"] = item.PaidDate;
            dr["DueCollectedBy"] = item.DueCollectedBy;
            dr["ReceivedBy"] = item.ReceivedBy;
            dr["Address"] = item.Address;
            dr["ContactNo"] = item.ContactNo;
            dr["DueBillDate"] = item.DueBillDate;
            dt.Rows.Add(dr);
        }
        return dt;
    }
    private void BindDuePaidReport()
    {
        try
        {
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            string PaymentMode = string.Empty;
            StringBuilder sb = new StringBuilder();
            StringBuilder sbs = new StringBuilder();
            lstDuePaidDetail = new List<DuePaidDetail>();
            objReport_BL = new Report_BL(base.ContextInfo);
            int pLocationID = 0;
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            objReport_BL.GetDuePaidDetailsReport(Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), OrgID, currencyID, pLocationID, PaymentMode, out lstDuePaidDetail);



            if (lstDuePaidDetail.Count > 0)
            {
                dicpagetotal.Add("PaidAmount", 0);
                gvDuepaidReport.DataSource = lstDuePaidDetail;
                gvDuepaidReport.DataBind();
                sb.Append("<b>");
                sb.Append("Total Due Amount:");
                sb.Append("</b>");
                sb.Append("<b>");
                sb.Append("" + lstDuePaidDetail.FindAll(p => p.BillAmount != 0).Sum(p => p.BillAmount).ToString() + "");
                sb.Append("</b>");
                sbs.Append("<b>");
                sbs.Append("<font color='blue'>Page wise Total Paid:</font>");
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.AppendFormat("<font color='blue'>" + dicpagetotal["PaidAmount"].ToString() + "</font> <br/>");
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.Append("Total Paid Amount:");
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.Append("" + lstDuePaidDetail.FindAll(p => p.BillAmount != 0).Sum(p => p.PaidAmount).ToString() + "");
                sbs.Append("</b>");
                // gvDuepaidReport.FooterRow.Cells[3].Text = sb.ToString();
                gvDuepaidReport.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Right;
                gvDuepaidReport.FooterRow.Cells[7].HorizontalAlign = HorizontalAlign.Left;
                gvDuepaidReport.FooterRow.Cells[8].Font.Bold = true;
                gvDuepaidReport.FooterRow.Cells[7].Font.Bold = true;
                    if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
                    {
                        gvDuepaidReport.FooterRow.Cells[8].Text = pPaidCurrencyTotal.ToString();
                        gvDuepaidReport.FooterRow.Cells[7].Text = pPaidCurrencyCode;
                    }
                    else
                    {
                        gvDuepaidReport.FooterRow.Cells[7].Text = "Multiple Currencies";
                        gvDuepaidReport.FooterRow.Cells[8].Text = "--";
                    }
             
                gvDuepaidReport.FooterRow.Cells[5].Text = sbs.ToString();
                divPrint.Attributes.Add("Style", "Display:block");
                DataTable dt = loaddata(lstDuePaidDetail);
                ds.Tables.Add(dt);
                ViewState["report"] = ds;
            }
            else
            {
                gvDuepaidReport.DataSource = null;
                gvDuepaidReport.DataBind();
                divPrint.Attributes.Add("Style", "Display:none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BindDuePaidReport", ex);
        }
    }
    protected void gvDuepaidReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            TableCell cell;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    cell = e.Row.Cells[i];
                    if (gvDuepaidReport.HeaderRow.Cells[i].Text == "Paid Amount")
                    {
                        Label lbl = (Label)e.Row.FindControl("lblPaidAmount");
                        dicpagetotal["PaidAmount"] += Decimal.Parse(lbl.Text);
                        cell.HorizontalAlign = HorizontalAlign.Right;
                    }
                }
                pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[8].Text);
                if (e.Row.Cells[7].Text != "" && e.Row.Cells[7].Text != "&nbsp;")
                {
                    pPaidCurrencyCode = e.Row.Cells[7].Text;
                }
                if (e.Row.Cells[7].Text != "" && e.Row.Cells[7].Text != "&nbsp;" && e.Row.Cells[7].Text != BaseCurrencyCode)
                {
                    showPaidCurrency = 1;
                }
                if (e.Row.Cells[7].Text != "" && e.Row.Cells[7].Text != "&nbsp;")
                {
                    showPaidCurrency1 += 1;
                }
                
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DueReport, gvDuepaidReport_RowDataBound", ex);
        }
    }
    protected void gvDuepaidReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvDuepaidReport.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvDuepaidReport_PageIndexChanging", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindDuePaidReport();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetDuepaid Report, btnSearch_Click", ex);
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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "DuePaidDetails_Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First You have to click d Get report');", true);
            }
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
}
