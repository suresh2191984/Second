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

public partial class Reports_BillWiseReportOPIP : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalBillAmt = -1;
    decimal pTotalPreDueReceived = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalNetValue = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;
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
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (!IsPostBack)
        {
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
    
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

                 
        
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                pPaidCurrencyTotal = 0;
                showPaidCurrency = 0;
                showPaidCurrency1 = 0;
                pPaidCurrencyCode = string.Empty;
                if (rblReportType.SelectedValue == "0")
                {
                    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems = from child in lstDWCR
                                     where child.VisitDate == RMaster.VisitDate
                                    // where child.VisitDate == RMaster.VisitDate && child.PatientName == "TOTAL"
                                     select child;



                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    //str = lbl.Text.ToString();
                    //dt.TableName = str;
                    ds.Tables.Add(dt); 
                }
                else
                {
                    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems = from child in lstDWCR
                                     where child.VisitDate == RMaster.VisitDate
                                     select child;

                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    //str = lbl.Text.ToString();
                    //dt.TableName = str;
                    ds.Tables.Add(dt); 
                }

               
              
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound IPCollectionReport", ex);
        }
    }
    protected void gvOPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";
                //e.Row.Cells[16].Text = "";
                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).IsDuePaidBill == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.Orange;
                e.Row.CssClass = "patientSearch";
                e.Row.ToolTip = "Due Collect from CollectDuepayment";
            }
            //Label lbl = (Label)e.Row.FindControl("lblPaidCurrency");
            pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[19].Text);
            if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;")
            {
                pPaidCurrencyCode = e.Row.Cells[18].Text;
            }
            if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;"  && e.Row.Cells[18].Text != BaseCurrencyCode)
            {
                showPaidCurrency = 1;
            }
            if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;")
            {
                showPaidCurrency1 += 1;
            }
        }

        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (visitTypeID == 0)
        {
            e.Row.Cells[7].Visible = true;
            e.Row.Cells[8].Visible = true;
            e.Row.Cells[9].Visible = true;
            e.Row.Cells[15].Visible = true;
            e.Row.Cells[16].Visible = false;
            e.Row.Cells[17].Visible = false;
        }
        if (visitTypeID == 1)
        {
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
            e.Row.Cells[15].Visible = false;
            e.Row.Cells[16].Visible = true;
            e.Row.Cells[17].Visible = false;
        }
        else if (visitTypeID == -1)
        {
            e.Row.Cells[7].Visible = true;
            e.Row.Cells[8].Visible = true;
            e.Row.Cells[9].Visible = true;
            e.Row.Cells[15].Visible = true;
            e.Row.Cells[16].Visible = true;
            if (e.Row.Cells[17].Text.ToUpper().Trim() == "IP")
            {
                e.Row.BackColor = System.Drawing.Color.YellowGreen;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";
               // e.Row.Cells[9].Text = "";
                e.Row.Cells[15].Text = "";
                e.Row.Cells[14].Text = "";
                //e.Row.Cells[16].Text = "";  

                e.Row.Cells[7].Text = "";
                if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
                {
                    e.Row.Cells[19].Text = pPaidCurrencyTotal.ToString();
                    e.Row.Cells[18].Text = pPaidCurrencyCode;
                }
                else
                {
                    e.Row.Cells[18].Text = "Multiple Currencies";
                    e.Row.Cells[19].Text = "--";
                }
                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
        if (rblReportType.SelectedValue == "0" && e.Row.Cells[1].Text != "TOTAL" && e.Row.Cells[1].Text != "Name")
        {
            e.Row.Visible = false;
        }
        
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientID");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("FinalBillID");
        DataColumn dcol5 = new DataColumn("VisitDate");
        DataColumn dcol6 = new DataColumn("BillAmount");
        DataColumn dcol7 = new DataColumn("PreviousDue");
        DataColumn dcol8 = new DataColumn("Discount");
        DataColumn dcol9 = new DataColumn("NetValue");
        DataColumn dcol10 = new DataColumn("ReceivedAmount");
        DataColumn dcol11 = new DataColumn("Cash");
        DataColumn dcol12 = new DataColumn("Cards");
        DataColumn dcol13 = new DataColumn("DD");
        DataColumn dcol14 = new DataColumn("Due");
        DataColumn dcol15 = new DataColumn("IPAdvance");
        DataColumn dcol16 = new DataColumn("VisitType");
        DataColumn dcol17 = new DataColumn("cheque");
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
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol16);
        dt.Columns.Add(dcol17);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientID"] = item.PatientID;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["FinalBillID"] = item.FinalBillID;
            dr["VisitDate"] = item.VisitDate;
            dr["BillAmount"] = item.BillAmount;
            dr["PreviousDue"] = item.PreviousDue;
            dr["Discount"] = item.Discount;
            dr["NetValue"] = item.NetValue;
            dr["ReceivedAmount"] = item.ReceivedAmount;
            dr["Cash"] = item.Cash;
            dr["Cards"] = item.Cards;
            dr["DD"] = item.DD;
            dr["Due"] = item.Due;
            dr["IPAdvance"] = item.IPAdvance;
            dr["VisitType"] = item.VisitType;
            dr["Cheque"] = item.Cheque;
            dt.Rows.Add(dr);
        }
        return dt;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int currencyID = 0;
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            tabGranTotal1.Visible = false; tabGranTotal2.Visible = false;
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetBillWiseReportOPIP(fDate, tDate, OrgID, 0, visitType, currencyID, out lstDWCR, out pTotalBillAmt, out pTotalPreDueReceived, out pTotalDiscount, out pTotalNetValue, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge);

            var dwcr = (from dw in lstDWCR
                        orderby dw.VisitDate ascending
                        select new { dw.VisitDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.VisitDate = obj.VisitDate;
                lstDayWiseRept.Add(pdc);
            }

            //lblTotalBillAmt.Text = pTotalBillAmt.ToString();
            //lblTotalPreDueReceived.Text = pTotalPreDueReceived.ToString();
            //lblTotalDiscount.Text = pTotalDiscount.ToString();
            //lblTotalNetValue.Text = pTotalNetValue.ToString();
            //lblTotalReceivedAmt.Text = pTotalReceivedAmt.ToString();
            //lblTotalDue.Text = pTotalDue.ToString();

            if (lstDWCR.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                if (visitType == 0)
                {
                    //gvOPReport.Visible = false;
                    gvIPReport.Visible = true;
                    gvIPReport.Columns[0].HeaderText = "OP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP & IP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
               
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }

    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;
        tabGranTotal2.Visible = true;

        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (visitTypeID == 0 || visitTypeID == -1)
        {
            trNetAmount.Visible = false;
        }
        else
        {
            trNetAmount.Visible = false;
        }

        lblGrandTotal.InnerText = String.Format("{0:0.00}", (pTotalBillAmt));
        lblServiceCharge.InnerText = String.Format("{0:0.00}", (pServiceCharge));
        lblTax.InnerText = String.Format("{0:0.00}", (pTax));

        lblNetAmount.InnerText = String.Format("{0:0.00}", (pTotalNetValue));

        lblDiscountAmount.InnerText = String.Format("{0:0.00}", (pTotalDiscount));

        lblDueAmount.InnerText = String.Format("{0:0.00}", ((pTotalDue > 0) ? pTotalDue : 0));
        lblReceivedAmount.InnerText = String.Format("{0:0.00}", (pTotalReceivedAmt));
    }
    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
        tabGranTotal2.Visible = false;
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
            string prefix = string.Empty;
            prefix = "BillWise_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting to Excel", ex);
        }
    }
}
