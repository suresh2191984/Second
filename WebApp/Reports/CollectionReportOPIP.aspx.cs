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
using System.IO;
public partial class Reports_CollectionReportOPIP : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstDWCRGrandTotal = new List<DayWiseCollectionReport>();
    DayWiseCollectionReport objDWCR = new DayWiseCollectionReport();
    //DataSet ds = new DataSet();
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
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    int count = 0;
    int totpat = 0;

    public Reports_CollectionReportOPIP()
        : base("Reports\\CollectionReportOPIP.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master_BL masterBL = new Master_BL(base.ContextInfo);
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
            masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            if (RoleName == RoleHelper.Reception)
            {
                txtFDate.Enabled = false;
                txtTDate.Enabled = false;
                ImgFDate.Visible = false;
                ImgTDate.Visible = false;
            }
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
    //public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    //{
    //    DataTable dt = new DataTable();
    //    DataColumn dcol1 = new DataColumn("PatientNo");
    //    DataColumn dcol2 = new DataColumn("PatientName");
    //    DataColumn dcol3 = new DataColumn("Age");
    //    DataColumn dcol4 = new DataColumn("BillNumber");
    //    DataColumn dcol5 = new DataColumn("VisitDate");
    //    DataColumn dcol6 = new DataColumn("BillAmount");
    //    //DataColumn dcol7 = new DataColumn("PreviousDue");
    //    //DataColumn dcol8 = new DataColumn("CreditDue");
    //    DataColumn dcol9 = new DataColumn("Discount");
    //    DataColumn dcol10 = new DataColumn("NetValue");
    //    DataColumn dcol11 = new DataColumn("ReceivedAmount");
    //    DataColumn dcol12 = new DataColumn("Cash");
    //    DataColumn dcol13 = new DataColumn("Cards");
    //    DataColumn dcol14 = new DataColumn("DD");
    //    //DataColumn dcol15 = new DataColumn("Due");
    //    DataColumn dcol16 = new DataColumn("IPAdvance");
    //    DataColumn dcol17 = new DataColumn("VisitType");
    //    DataColumn dcol18 = new DataColumn("cheque");
    //    DataColumn dcol19 = new DataColumn("Rfd Amt");
    //    DataColumn dcol20 = new DataColumn("Rfd No");
    //    DataColumn dco121 = new DataColumn("Deposit Used");

    //    dt.Columns.Add(dcol1);
    //    dt.Columns.Add(dcol2);
    //    dt.Columns.Add(dcol3);
    //    dt.Columns.Add(dcol4);
    //    dt.Columns.Add(dcol5);
    //    dt.Columns.Add(dcol6);
    //    //dt.Columns.Add(dcol7);
    //    //dt.Columns.Add(dcol8);
    //    dt.Columns.Add(dcol9);
    //    dt.Columns.Add(dcol10);
    //    dt.Columns.Add(dcol11);
    //    dt.Columns.Add(dcol19);
    //    dt.Columns.Add(dcol20);
    //    dt.Columns.Add(dcol12);
    //    dt.Columns.Add(dcol13);
    //    dt.Columns.Add(dcol14);
    //    //dt.Columns.Add(dcol15);
    //    dt.Columns.Add(dcol16);
    //    dt.Columns.Add(dcol17);
    //    dt.Columns.Add(dcol18);
    //    dt.Columns.Add(dco121);
    //    foreach (DayWiseCollectionReport item in lstDWCR)
    //    {
    //        DataRow dr = dt.NewRow();
    //        dr["PatientNo"] = item.PatientID;
    //        dr["PatientName"] = item.PatientName;
    //        dr["Age"] = item.Age;
    //        dr["BillNumber"] = item.BillNumber;
    //        dr["VisitDate"] = item.VisitDate;
    //        dr["BillAmount"] = item.BillAmount;
    //        //dr["PreviousDue"] = item.PreviousDue;
    //        //dr["CreditDue"] = item.CreditDue;
    //        dr["Discount"] = item.Discount;
    //        dr["NetValue"] = item.NetValue;
    //        dr["ReceivedAmount"] = item.ReceivedAmount;
    //        dr["Rfd Amt"] = item.AmountRefund;
    //        dr["Rfd No"] = item.RefundNo;
    //        dr["Cash"] = item.Cash;
    //        dr["Cards"] = item.Cards;
    //        dr["DD"] = item.DD;
    //        //dr["Due"] = item.Due;
    //        dr["IPAdvance"] = item.IPAdvance;
    //        dr["VisitType"] = item.VisitType;
    //        dr["Cheque"] = item.Cheque;
    //        dr["Deposit Used"] = item.DepositUsed;
           
           
    //        dt.Rows.Add(dr);
    //    }
    //    return dt;
    //}
    //protected void gvOPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //            DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
    //            var childItems = from child in lstDWCR
    //                             where child.VisitDate == RMaster.VisitDate
    //                             select child;



    //            GridView childGrid = (GridView)e.Row.FindControl("gvOPCreditMain");
    //            childGrid.DataSource = childItems;
    //            childGrid.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in gvOPReport_RowDataBound OPCollectionReport", ex);
    //    }
    //}
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
                    totpat = 0;
                    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems = from child in lstDWCR
                                     where child.VisitDate == RMaster.VisitDate && child.PatientName == "TOTAL"
                                     select child;

                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    count = childItems.Count();
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    foreach (DayWiseCollectionReport obj in lstday)
                    {
                        objDWCR.PatientName = "Grand Total";
                        objDWCR.BillAmount += obj.BillAmount;
                        objDWCR.PreviousDue += obj.PreviousDue;
                     
                        objDWCR.NetValue += obj.NetValue;
                        objDWCR.ReceivedAmount += obj.ReceivedAmount;
                        objDWCR.Cash += obj.Cash;
                        objDWCR.Cards += obj.Cards;
                        objDWCR.Cheque += obj.Cheque;
                        objDWCR.DD += obj.DD;
                        objDWCR.Due += obj.Due;
                        objDWCR.AmountRefund += obj.AmountRefund;
                        objDWCR.IPAdvance += obj.IPAdvance;
                        objDWCR.PaidCurrency = "--";
                        objDWCR.PaidCurrencyAmount = 0;
                        objDWCR.DepositUsed += obj.DepositUsed;
                        objDWCR.Discount += obj.Discount;
                    }



                    //DataTable dt = loaddata(lstday);
                    //ds.Tables.Add(dt);
                    //==============================================================
                    //========patient total count in day wise --patientID===========

                    totpat = (from child in lstDWCR
                              where child.VisitDate == RMaster.VisitDate
                              select child.PatientID).Distinct().Count();
                    int totpatient = Convert.ToInt16(totpat - 1);
                    Label LblTotvalue = (Label)e.Row.FindControl("LblTotvalue");
                    LblTotvalue.Text = totpatient.ToString();

                    if (childGrid.Columns.Count > 0)
                    {
                        childGrid.Columns[0].Visible = false;
                        childGrid.Columns[1].Visible = false;
                        childGrid.Columns[3].Visible = false;
                        childGrid.Columns[4].Visible = false;
                        childGrid.Columns[5].Visible = false;
                        childGrid.Columns[6].Visible = false;
                        childGrid.Columns[7].Visible = false;
                        childGrid.HeaderRow.Cells[0].Text = "";
                        childGrid.HeaderRow.Cells[1].Text = "";
                        childGrid.HeaderRow.Cells[2].Text = "";


                    }
                    //==============================================================

                }
                else
                {

                    totpat = 0;
                    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                    List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems = from child in lstDWCR
                                     where child.VisitDate == RMaster.VisitDate
                                     select child;

                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");


                    count = childItems.Count();
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();

                    //DataTable dt = loaddata(lstday);
                    //ds.Tables.Add(dt);
                    //==============================================================
                    //========patient total count in day wise --patientID===========
                    totpat = (from child in lstday
                              where child.VisitDate == RMaster.VisitDate
                              select child.PatientID).Distinct().Count();
                    int totpatient = Convert.ToInt16(totpat - 1);
                    Label LblTotvalue = (Label)e.Row.FindControl("LblTotvalue");
                    LblTotvalue.Text = totpatient.ToString();

                    //==============================================================


                    var childItems1 = from child1 in lstDWCR
                                      where child1.VisitDate == RMaster.VisitDate && child1.PatientName == "TOTAL"
                                      select child1;
                    lstday1 = childItems1.ToList();
                    foreach (DayWiseCollectionReport obj in lstday1)
                    {
                        objDWCR.PatientName = "Grand Total";
                        objDWCR.BillAmount += obj.BillAmount;
                        objDWCR.PreviousDue += obj.PreviousDue;
                        objDWCR.CreditDue += obj.CreditDue;
                        objDWCR.Discount += obj.Discount;
                        objDWCR.NetValue += obj.NetValue;
                        objDWCR.ReceivedAmount += obj.ReceivedAmount;
                        objDWCR.Cash += obj.Cash;
                        objDWCR.Cards += obj.Cards;
                        objDWCR.Cheque += obj.Cheque;
                        objDWCR.DD += obj.DD;
                        objDWCR.Due += obj.Due;
                        objDWCR.AmountRefund += obj.AmountRefund;
                        objDWCR.IPAdvance += obj.IPAdvance;
                        objDWCR.PaidCurrency = "--";
                        objDWCR.PaidCurrencyAmount = 0;
                        objDWCR.DepositUsed += obj.DepositUsed;
                    }



                }
            }
            //ViewState["report"] = ds;
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
    protected void gvIPCreditMainGrandTotal_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.Cells[20].Text = "--";
            e.Row.Cells[10].Text += "<br/><b style='color:green;'>" + "(-)Refund" + " " + Convert.ToDecimal(e.Row.Cells[18].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + "Total Received: " + (Convert.ToDecimal(e.Row.Cells[10].Text) - Convert.ToDecimal(e.Row.Cells[18].Text)).ToString() + "</b>";
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
            if (((DayWiseCollectionReport)e.Row.DataItem).VisitType == "IP " && (((DayWiseCollectionReport)e.Row.DataItem).Due > 0 || ((DayWiseCollectionReport)e.Row.DataItem).CreditDue > 0))
            {
                e.Row.BackColor = System.Drawing.Color.LightGray;
                e.Row.ToolTip = "IP Due Chart - Billed Item";
            }
            pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[24].Text);
            if (e.Row.Cells[23].Text != "" && e.Row.Cells[23].Text != "&nbsp;")
            {
                pPaidCurrencyCode = e.Row.Cells[23].Text;
            }
            if (e.Row.Cells[23].Text != "" && e.Row.Cells[23].Text != "&nbsp;" && e.Row.Cells[23].Text != BaseCurrencyCode)
            {
                showPaidCurrency = 1;
            }
            if (e.Row.Cells[23].Text != "" && e.Row.Cells[23].Text != "&nbsp;")
            {
                showPaidCurrency1 += 1;
            }
        }




        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (visitTypeID == 0)
        {
            e.Row.Cells[9].Visible = true;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[17].Visible = true;
            e.Row.Cells[18].Visible = true;
            e.Row.Cells[19].Visible = false;

        }
        if (visitTypeID == 1)
        {
            e.Row.Cells[9].Visible = true;
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[11].Visible = false;
            e.Row.Cells[17].Visible = true;
            e.Row.Cells[18].Visible = true;
            e.Row.Cells[19].Visible = false;
        }
        else if (visitTypeID == -1)
        {
            e.Row.Cells[9].Visible = true;
            e.Row.Cells[10].Visible = true;
            e.Row.Cells[11].Visible = true;
            e.Row.Cells[17].Visible = true;
            e.Row.Cells[18].Visible = true;
            e.Row.Cells[19].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[1].Text = "";

                if (count > 2)
                {
                    //e.Row.Cells[1].Text = "TOTAL" + "(" + (count-1 )+ ")";
                 e.Row.Cells[2].Text = "TOTAL";
                }
                e.Row.Cells[3].Text = "";
                e.Row.Cells[4].Text = "";
                e.Row.Cells[5].Text = "";
                e.Row.Cells[6].Text = "";
                e.Row.Cells[7].Text = "";
                //e.Row.Cells[14].Text = "";
                //e.Row.Cells[16].Text = "";

                //suresh added
                //e.Row.Cells[6].Text = "";
                decimal received = Convert.ToDecimal(((DayWiseCollectionReport)e.Row.DataItem).ReceivedAmount);
                decimal refund = Convert.ToDecimal(((DayWiseCollectionReport)e.Row.DataItem).AmountRefund);
                //e.Row.Cells[8].Text = (received - refund).ToString();
                if (refund <= 0)
                {
                    e.Row.Cells[14].Text = received + "<br/><b style='color:green;'>" + "(-)Refund" + " " + refund + " </b>" + "<br><b style='color:green;'>" + "Total Received:" + (received - refund).ToString() + "</b>"; 
                }
                else { e.Row.Cells[14].Text = received + "<br/><b style='color:green;'>" + "(-)Refund" + " " + refund + " </b>" + "<br><b style='color:green;'>" + "Total Received:" + (received - refund).ToString() + "</b>"; }
                //e.Row.Cells[9].Text = "<table><tr><td>" + received + "</td></tr><tr><td>" + (received - refund).ToString() + "</td></tr></table>";
                //e.Row.Cells[9].Text = "XX";

                if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
                {
                    e.Row.Cells[24].Text = pPaidCurrencyTotal.ToString();
                    e.Row.Cells[23].Text = pPaidCurrencyCode;
                    if (pPaidCurrencyTotal.ToString() == "0" && pPaidCurrencyCode == "")
                    {
                        e.Row.Cells[23].Text = "--";
                        e.Row.Cells[24].Text = "--";
                    }
                }
                else
                {
                    e.Row.Cells[23].Text = "Multiple Currencies";
                    e.Row.Cells[24].Text = "--";
                }

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
        if (rblReportType.SelectedValue == "0" && e.Row.Cells[2].Text != "TOTAL" && e.Row.Cells[2].Text != "Name")
        {
            e.Row.Visible = false;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int currencyID = 0;
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int retreiveDataBaseOnVtype = visitType;//== 3 ? -1 : visitType;
            returnCode = new Report_BL(base.ContextInfo).GetCollectionReportOPIP(fDate, tDate, OrgID, 0, retreiveDataBaseOnVtype, currencyID, out lstDWCR, out pTotalBillAmt, out pTotalPreDueReceived, out pTotalDiscount, out pTotalNetValue, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge);

            //if (rblReportType.SelectedValue == "1")
            //{
            //gvOPIPCollDaywiseSummary.Visible = false;
            var dwcr = (from dw in lstDWCR
                        select new { dw.VisitDate }).Distinct().OrderBy(x=>x.VisitDate);

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
                    IncomeFromOtherSource.Visible = false;
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                    IncomeFromOtherSource.Visible = false;
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP & IP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                    IncomeFromOtherSource.Visible = false;
                }

                else if (visitType == 2)
                {
                    long DataCount = -1;
                    IncomeFromOtherSource.LoadIncomeSourceData(fDate, tDate, 0, currencyID, out DataCount);
                    IncomeFromOtherSource.Visible = true;

                }
                else if (visitType == 3)
                {
                    long DataCount = -1;
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    IncomeFromOtherSource.LoadIncomeSourceData(fDate, tDate, 0, currencyID, out DataCount);
                    gvIPReport.Columns[0].HeaderText = "OP & IP - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                    IncomeFromOtherSource.Visible = true;
                    decimal dc = IncomeFromOtherSource.GetOtherSourceTotal;
                }
                if (visitType == 4)
                {
                    //gvOPReport.Visible = false;
                    gvIPReport.Visible = true;
                    gvIPReport.Columns[0].HeaderText = "Deposit - Collection Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                    IncomeFromOtherSource.Visible = false;
                }

                //tabGranTotal1.Visible = false; tabGranTotal2.Visible = false;


            }
            else
            {

                if ((visitType == 2) || (visitType == 3))
                {
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;
                    gvIPReport.Visible = false;
                    long DataCount = -1;
                    IncomeFromOtherSource.LoadIncomeSourceData(fDate, tDate, 0, currencyID, out DataCount);
                    IncomeFromOtherSource.Visible = true;
                    if (DataCount == 0)
                    {
                        divOPDWCR.Attributes.Add("style", "none");
                        divPrint.Attributes.Add("style", "none");
                        divOPDWCR.Visible = false;
                        divPrint.Visible = false;
                        CalculationPanelNone();
                    }
                }
                else
                {
                    divOPDWCR.Attributes.Add("style", "none");
                    divPrint.Attributes.Add("style", "none");
                    divOPDWCR.Visible = false;
                    divPrint.Visible = false;
                    CalculationPanelNone();
                    string sPath = "CommonMessages_20";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonMessages_20").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideDiv", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                    //}

                }
            }
            //}
            //else if(rblReportType.SelectedValue == "0")
            //{
            //    divOPDWCR.Attributes.Add("style", "block");
            //    divPrint.Attributes.Add("style", "block");
            //    CalculationPanelNone();
            //    divOPDWCR.Visible = true;
            //    divPrint.Visible = true;
            //    gvIPReport.Visible = false;
            //    gvOPIPCollDaywiseSummary.Visible = true;
            //    var lstDwcRpt = (from c in lstDWCR
            //                 where c.PatientName == "TOTAL"
            //                 group c by new { c.FeeType,c.PaidCurrency } into g
            //                 select new DayWiseCollectionReport
            //                 {
            //                     FeeType = g.Key.FeeType,
            //                     BillAmount = g.Sum(p => p.BillAmount),
            //                     PreviousDue = g.Sum(p => p.PreviousDue),
            //                     Discount = g.Sum(p => p.Discount),
            //                     NetValue = g.Sum(p => p.NetValue),
            //                     ReceivedAmount = g.Sum(p => p.ReceivedAmount),
            //                     Cash = g.Sum(p => p.Cash),
            //                     Cards = g.Sum(p => p.Cards),
            //                     Cheque = g.Sum(p => p.Cheque),
            //                     DD = g.Sum(p => p.DD),
            //                     AmountRefund = g.Sum(p => p.AmountRefund),
            //                     Due = g.Sum(p => p.Due),
            //                     PaidCurrency = g.Key.PaidCurrency,
            //                     PaidCurrencyAmount = g.Sum(p => p.PaidCurrencyAmount)

            //                 }).Distinct().ToList();

            //    gvOPIPCollDaywiseSummary.DataSource = lstDwcRpt;
            //    gvOPIPCollDaywiseSummary.DataBind();
            //}

            lstDWCRGrandTotal.Add(objDWCR);
            if (lstDWCRGrandTotal.Count > 0)
            {
                gvIPCreditMainGrandTotal.Visible = true;
                gvIPCreditMainGrandTotal.DataSource = lstDWCRGrandTotal;
                gvIPCreditMainGrandTotal.DataBind();
                gvIPCreditMainGrandTotal.HeaderRow.Cells[1].Text = "";
                lblFromToDate.Visible = true;
                lblFromToDate.Text = "Date: " + txtFDate.Text + " - " + txtTDate.Text;
            }
            else
            {
                gvIPCreditMainGrandTotal.Visible = true;
                lblFromToDate.Visible = true;
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

    //protected void gvOPIPCollDaywiseSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[19].Text);
    //        if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;")
    //        {
    //            pPaidCurrencyCode = e.Row.Cells[18].Text;
    //        }
    //        if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;" && e.Row.Cells[18].Text != BaseCurrencyCode)
    //        {
    //            showPaidCurrency = 1;
    //        }
    //        if (e.Row.Cells[18].Text != "" && e.Row.Cells[18].Text != "&nbsp;")
    //        {
    //            showPaidCurrency1 += 1;
    //        }
    //        //if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
    //        //{
    //        e.Row.Cells[0].Text = "";

    //        e.Row.Cells[1].Text = "TOTAL";
    //        e.Row.Cells[2].Text = "";
    //        e.Row.Cells[3].Text = "";
    //        //e.Row.Cells[16].Text = "";
    //        //e.Row.Style.Add("font-weight", "bold");
    //        if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
    //        {
    //            e.Row.Cells[19].Text = pPaidCurrencyTotal.ToString();
    //            e.Row.Cells[18].Text = pPaidCurrencyCode;
    //        }
    //        else
    //        {
    //            e.Row.Cells[18].Text = pPaidCurrencyCode;
    //            e.Row.Cells[19].Text = pPaidCurrencyTotal.ToString();
    //        }
    //        e.Row.Style.Add("color", "Black");
    //        //}
    //    }
    //    if (visitTypeID == 0 || visitTypeID == 1)
    //    {
    //        e.Row.Cells[16].Visible = false;
    //        if (visitTypeID == 0)
    //        {
    //            e.Row.Cells[15].Visible = false;
    //        }
    //    }
    //    if (rblReportType.SelectedValue == "0" && e.Row.Cells[1].Text != "TOTAL" && e.Row.Cells[1].Text != "Name")
    //    {
    //        e.Row.Visible = false;
    //    }
    //}
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        
        try
        {
            //string SingleXl = GetConfigValue("SingleXLReport", OrgID);
            //if (SingleXl == "Y")
            //{
            //    btnSubmit_Click(sender, e);
            //    ExportToExcel(gvIPReport);
            //}
            //else
            //{
            //    string prefix = string.Empty;
            //    prefix = "Collection_ReportsOPIP_";
            //    string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            //    DataSet dsrpt = (DataSet)ViewState["report"];
            //    if (dsrpt != null)
            //    {
            //        ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            //    }
            //}
            ExcelHelper.ExportToExcel(new List<Control> { gvIPCreditMainGrandTotal, gvIPReport }, "Collection_ReportsOPIP_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls", Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during exporting to Excel", ex);
        }
    }

    //public void ExportToExcel(Control CTRl)
    //{
    //    Response.Clear();
    //    Response.AddHeader("content-disposition",
    //    string.Format("attachment;filename={0}.xls", "CollectionReportOPIP"));
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.xls";
    //    StringWriter stringWrite = new StringWriter();
    //    HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

    //    gvIPCreditMainGrandTotal.RenderControl(htmlWrite);
    //    gvIPReport.RenderControl(htmlWrite);
    //    Response.Write(stringWrite.ToString());
    //    Response.End();

    //}
    //public void Export(string ID,string ExcelName)
    //{
    //    Response.Clear();
    //    Response.AddHeader("content-disposition",
    //    string.Format("attachment;filename={0}.xls", ExcelName));
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.xls";
    //    StringWriter stringWrite = new StringWriter();
    //    HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //    GridView ExcelGrid = new GridView();
    //    ExcelGrid.ID = ID;

    //    ExcelGrid.RenderControl(htmlWrite);
    //    Response.Write(stringWrite.ToString());
    //    Response.End();

    //}
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}
