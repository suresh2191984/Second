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

public partial class Reports_DptWiseRevenueRpt : BasePage
{
    long returnCode = -1;
    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalNetValue = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;

    decimal pTotalBillAmt1 = -1;
    decimal pTotalPreDueReceived1 = -1;
    decimal pTotalDiscount1 = -1;
    decimal pTotalNetValue1 = -1;
    decimal pTotalReceivedAmt1 = -1;
    decimal pTotalDue1 = -1;
    decimal pTax1 = -1;
    decimal pServiceCharge1 = -1;

    decimal totalQuantity = 0;
    decimal totalBilledAmount = 0;
    decimal totalAmountReceived = 0;

    decimal gtotalQuantity = 0;
    decimal gtotalBilledAmount = 0;
    decimal gtotalAmountReceived = 0;

    decimal totalServiceCharge = 0;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    int count = 0;
    int temp = 0;
    DataSet ds = new DataSet();

    //Label lbQty = new Label();
    //Label lbBilledAmount = new Label();
    //Label lbAmtReceived = new Label();

    List<DayWiseCollectionReport> lstDWCR1 = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    IEnumerable<DayWiseCollectionReport> lstDwcRpt;
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (!IsPostBack)
        {
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

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
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("FeeType");
        DataColumn dcol2 = new DataColumn("ItemQuantity");
        DataColumn dcol3 = new DataColumn("ItemAmount");
        DataColumn dcol4 = new DataColumn("BillAmount");
        DataColumn dcol5 = new DataColumn("AmountReceived");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["FeeType"] = item.FeeType;
            dr["ItemQuantity"] = item.ItemQuantity;
            dr["ItemAmount"] = item.ItemAmount;
            dr["BillAmount"] = item.BillAmount;
            dr["AmountReceived"] = item.AmountReceived;
            dt.Rows.Add(dr);
        }
        return dt;
    }
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
            string visitType = rblVisitType.SelectedItem.Text;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                 pPaidCurrencyTotal = 0;
                showPaidCurrency = 0;
                showPaidCurrency1 = 0;
                pPaidCurrencyCode = string.Empty;
                //DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                //var childItems = from child in lstDwcRpt
                //                 where child.VisitDate == RMaster.VisitDate
                //                 select child;


                //RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                //LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                //lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                //string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                //lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                //GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                //childGrid.DataSource = childItems;
                //childGrid.DataBind();
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                if (rblReportType.SelectedValue == "0")
                {
                    var childItems = from child in lstDwcRpt
                                     where child.VisitDate == RMaster.VisitDate
                                     select child;


                    foreach (var List in childItems)
                    {
                        totalQuantity += List.ItemQuantity;
                        totalBilledAmount += List.BilledAmount;
                        totalAmountReceived += List.AmountReceived;
                    }
                    LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                    //lnkDwcr.Text = txtFDate.Text + " to " + txtTDate.Text;
                    lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt);


                    List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster1 = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems1 = from child1 in lstDWCR1
                                      where child1.VisitDate == RMaster1.VisitDate
                                      select child1;

                    GridView childGrid1 = (GridView)e.Row.FindControl("gvIPCreditMain1");
                    count = childItems1.Count();
                    childGrid1.DataSource = childItems1;
                    childGrid1.DataBind();
                    lstday1 = childItems1.ToList();

                    DataTable dt1 = loaddata(lstday1);
                    ds.Tables.Add(dt1); 
                }
                else
                {
                    var childItems = from child in lstDwcRpt
                                     where child.VisitDate == RMaster.VisitDate
                                     select child;

                    Label lbQty = (Label)e.Row.FindControl("lblQty");
                    Label lbBilledAmount = (Label)e.Row.FindControl("lblBilledAmount");
                    Label lbAmtReceived = (Label)e.Row.FindControl("lblAmtReceived");

                    LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                    //lnkDwcr.Text = txtFDate.Text + " to " + txtTDate.Text;
                    lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                    //string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    //lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt);

                    lbQty.Text =Convert.ToInt32(totalQuantity).ToString();
                    lbBilledAmount.Text = totalBilledAmount.ToString();

                    //lbAmtReceived.Text = totalAmountReceived.ToString();

                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType + "&grdtot=" + lbBilledAmount.Text;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";

                    gtotalAmountReceived = gtotalAmountReceived + totalAmountReceived;
                    gtotalQuantity = gtotalQuantity + totalQuantity;
                    gtotalBilledAmount = gtotalBilledAmount + totalBilledAmount;

                    totalQuantity = 0;
                    totalBilledAmount = 0;
                    totalAmountReceived = 0;

                    temp = 1;
                      List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport RMaster1 = (DayWiseCollectionReport)e.Row.DataItem;
                    var childItems1 = from child1 in lstDWCR1
                                    // where child1.VisitDate == RMaster1.VisitDate && child1.PatientName == "TOTAL"
                                      where child1.VisitDate == RMaster1.VisitDate
                                     select child1;

                    GridView childGrid1 = (GridView)e.Row.FindControl("gvIPCreditMain1");
                    count = childItems1.Count();
                    childGrid1.DataSource = childItems1;
                    childGrid1.DataBind();
                    lstday1 = childItems1.ToList();
                    
                    DataTable dt1 = loaddata(lstday1);                    
                    ds.Tables.Add(dt1); 
                }
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }
    protected void gvOPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string visitType = rblVisitType.SelectedItem.Text;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[4].Text = "";
                    //e.Row.Cells[5].Text = "";
                    //e.Row.Cells[15].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvOPCreditMain_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        try
        {
            string visitType = rblVisitType.SelectedItem.Text;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport dwcr = new DayWiseCollectionReport();
                dwcr = (DayWiseCollectionReport)e.Row.DataItem;

                LinkButton lnkDept = (LinkButton)e.Row.FindControl("lnkDept");
                if ((dwcr.FeeType != "") && (dwcr.FeeType != "TOTAL"))
                {
                    string fType = string.Empty;

                    totalQuantity += dwcr.ItemQuantity;
                    totalBilledAmount += dwcr.BilledAmount;
                    totalAmountReceived += dwcr.AmountReceived;

                    if (dwcr.FeeType == "Consultation")
                    {
                        fType = "CON";
                    }
                    else if (dwcr.FeeType == "Procedure")
                    {
                        fType = "Procedure";
                    }
                    else if (dwcr.FeeType == "Pharmacy")
                    {
                        fType = "PRM";
                    }
                    else if (dwcr.FeeType == "Registration")
                    {
                        fType = "REG";
                    }
                    else if (dwcr.FeeType == "Others")
                    {
                        fType = "OTH";
                    }
                    else if (dwcr.FeeType == "Packages")
                    {
                        fType = "PKG";
                    }
                    else if (dwcr.FeeType == "Casualty")
                    {
                        fType = "CAS";
                    }
                    else if (dwcr.FeeType == "Lab")
                    {
                        fType = "LAB";
                    }
                    else if (dwcr.FeeType == "Imaging")
                    {
                        fType = "IMG";
                    }
                    else if (dwcr.FeeType == "Room")
                    {
                        fType = "ROM";
                    }
                    else if (dwcr.FeeType == "Advance")
                    {
                        fType = "ADV";
                    }
                    else if (dwcr.FeeType == "Surgery Items")
                    {
                        fType = "SOI";
                    }
                    else if (dwcr.FeeType == "Surgery")
                    {
                        fType = "SUR";
                    }
                    else if (dwcr.FeeType == "Surgery Package")
                    {
                        fType = "SPKG";
                    }
                    else if (dwcr.FeeType == "General")
                    {
                        fType = "GEN";
                    }
                    else if (dwcr.FeeType == "Indents")
                    {
                        fType = "IND";
                    }
                    else if (dwcr.FeeType == "Misc" || dwcr.FeeType=="" || dwcr.FeeType=="OTH")
                    {
                        fType = "Misc";
                    }
                    else if (dwcr.FeeType == "LCON")
                    {
                        fType = "LCON";
                    }
                    else if (dwcr.FeeType == "Due")
                    {
                        fType = "DUE";
                    }
                    else if (dwcr.FeeType == "Additional")
                    {
                        fType = "ADD";
                    }
                    else if (dwcr.FeeType != "")
                    {
                        fType = dwcr.FeeType;
                    }

                    //lbtnDwcr.ToolTip = "Click Here To view " + dwcr.FeeType + "details";
                    //lbtnDwcr.NavigateUrl = "DeptRevenueDetails.aspx?dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date

                    //Link to view day details of particular feetype
                    lnkDept.ToolTip = "Click Here To view " + dwcr.VisitDate + " details";
                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDept.OnClientClick = "ReportPopUP('" + url + "');";
                }

                //if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                //{
                //    e.Row.Cells[0].Text = "";
                //    e.Row.Cells[2].Text = "";
                //    e.Row.Cells[3].Text = "";
                //    e.Row.Cells[4].Text = "";
                //    //e.Row.Cells[5].Text = "";
                //    //e.Row.Cells[15].Text = "";
                //    e.Row.Style.Add("font-weight", "bold");
                //    e.Row.Style.Add("color", "Black");
                //}
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMain_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            ShowDayWiseCollectionPanel();
            returnCode = new Report_BL(base.ContextInfo).GetDptWiseRevenueReport(fDate, tDate, OrgID, 0, visitType, out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, rblReportType.SelectedValue);

            //if (visitType == 0)
            //{
            //    dvTotAdvance.Visible = false;
            //    dvDuechartPayments.Visible = false;
            //    lbltotAdv.Visible = false;
            //    lblDueChart.Visible = false;
            //}
            //else
            //{
            //    dvTotAdvance.Visible = true;
            //    dvDuechartPayments.Visible = true;
            //    lbltotAdv.Visible = true;
            //    lblDueChart.Visible = true;
            //}

            if (rblReportType.SelectedValue == "0")
            {
                lstDwcRpt = (from c in lstDWCR
                             where c.PatientName != "TOTAL"
                             group c by new { c.FeeType } into g
                             select new DayWiseCollectionReport
                             {
                                 FeeType = g.Key.FeeType,
                                 ItemQuantity = g.Sum(p => p.ItemQuantity),
                                 ItemAmount = g.Sum(p => p.ItemAmount),
                                 BilledAmount = g.Sum(p => p.BilledAmount),
                                 AmountReceived = g.Sum(p => p.AmountReceived)

                             }).Distinct().ToList();

                var childItems1 = (from child1 in lstDWCR1
                                   // where child1.VisitDate == RMaster1.VisitDate && child1.PatientName == "TOTAL"
                                   where child1.PatientName == "TOTAL"
                                   group child1 by new { child1.PatientName, child1.PaidCurrency } into g
                                   select new DayWiseCollectionReport
                                   {


                                       Discount = g.Sum(p => p.Discount),

                                       ReceivedAmount = g.Sum(p => p.ReceivedAmount),
                                       Cash = g.Sum(p => p.Cash),
                                       Cards = g.Sum(p => p.Cards),
                                       Cheque = g.Sum(p => p.Cheque),
                                       DD = g.Sum(p => p.DD),
                                       AmountRefund = g.Sum(p => p.AmountRefund),
                                       Due = g.Sum(p => p.Due),
                                       CreditDue = g.Sum(p => p.CreditDue),
                                       //PaidCurrency = g.Key.PaidCurrency,
                                       //PaidCurrencyAmount = g.Sum(p => p.PaidCurrencyAmount)

                                   }).Distinct().ToList();

                
                count = childItems1.Count();
                gvIPCreditMainSummary1.DataSource = childItems1;
                gvIPCreditMainSummary1.DataBind();
            }
            else
            {
                lstDwcRpt = (from c in lstDWCR
                             where c.PatientName != "TOTAL"
                             group c by new { c.VisitDate, c.FeeType } into g
                             select new DayWiseCollectionReport
                             {
                                 VisitDate = g.Key.VisitDate,
                                 FeeType = g.Key.FeeType,
                                 ItemQuantity = g.Sum(p => p.ItemQuantity),
                                 ItemAmount = g.Sum(p => p.ItemAmount),
                                 BilledAmount = g.Sum(p => p.BilledAmount),
                                 AmountReceived = g.Sum(p => p.AmountReceived)
                             }).Distinct().ToList();
            } List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            if (rblReportType.SelectedValue == "0")
            {
                var dwcr = (from dw in lstDwcRpt
                            select new { dw.FeeType, dw.VisitDate }).Distinct();


                foreach (var obj in dwcr)
                {
                    DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                    pdc.FeeType = obj.FeeType;
                    lstDayWiseRept.Add(pdc);
                }
            }
            else
            {
                var dwcr = (from dw in lstDwcRpt
                            select new { dw.VisitDate }).Distinct();

                foreach (var obj in dwcr)
                {
                    DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                    pdc.VisitDate = obj.VisitDate;
                    lstDayWiseRept.Add(pdc);
                }
            }

            if (lstDwcRpt.Count() > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");

                //tdQuantity1.InnerText = totalQuantity.ToString("0.00");
                //tdBilledAmount1.InnerText = totalBilledAmount.ToString("0.00");
                //tdAmountReceived1.InnerText = totalAmountReceived.ToString("0.00");

                //tdQuantity2.InnerText = totalQuantity.ToString("0.00");
                //tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
                //tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");

                //dvTotAdvance.InnerHtml = pTotalReceivedAmt.ToString("0.00");

                //tdServiceCharge.InnerHtml = pServiceCharge.ToString("0.00");
                //dvDuechartPayments.InnerHtml = pTotalDue.ToString("0.00");
                //dvTotalDiscounts.InnerHtml = pTotalDiscount.ToString("0.00");

                //dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge + pTotalDue - pTotalDiscount).ToString();
                //dvDuechartPayments
                //    dvTotalDiscounts
                //    dvTotRcvd

                divOPDWCR.Visible = true;
                divPrint.Visible = true;

                if (visitType == 0)
                {
                    if (rblReportType.SelectedValue == "1")
                    {
                        //tabTotal1.Style.Add("display", "block");
                        tabTotal2.Style.Add("display", "block");

                        gvIPReport.Visible = true;
                        gvIPCreditMainSummary.Visible = false;
                        tblgvIPCreditMainSummary.Visible = false;
                        //gvIPReport.Columns[0].HeaderText = "OP - Deptwise Collection Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                        //CalculationPanelBlock();
                        tdQuantity2.InnerText = Convert.ToInt32(gtotalQuantity).ToString();
                        tdBilledAmount2.InnerText = gtotalBilledAmount.ToString("0.00");
                        //tdAmountReceived2.InnerText = gtotalAmountReceived.ToString("0.00");
                        //dvTotRcvd.InnerHtml = (gtotalAmountReceived + pServiceCharge + pTotalDue - pTotalDiscount).ToString();
                    }
                    else
                    {
                        //tabTotal1.Style.Add("display", "none");
                        tabTotal2.Style.Add("display", "block");

                        gvIPReport.Visible = false;
                        gvIPCreditMainSummary.Visible = true;
                        tblgvIPCreditMainSummary.Visible = true;
                        //gvIPCreditMainSummary.Columns[0].HeaderText = "OP - Deptwise Collection Report";
                        gvIPCreditMainSummary.DataSource = lstDwcRpt;
                        gvIPCreditMainSummary.DataBind();
                        //CalculationPanelBlock();

                        tdQuantity2.InnerText = Convert.ToInt32(totalQuantity).ToString();
                        tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
                        //tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
                        //dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge + pTotalDue - pTotalDiscount).ToString();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem + "&grdtot=" + tdBilledAmount2.InnerText;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";
                    }
                    //lblAdvRcvdText.Visible = false;
                    //lblExcessAmount.Visible = false;
                    //tblExcessAmount.Visible = false;

                    //lblAdvRcvdText.Text = "Additional amount received apart from billed amount";
                    //lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                }
                else if (visitType == 1)
                {
                    //lblAdvRcvdText.Visible = false;
                    //lblExcessAmount.Visible = false;
                    //tblExcessAmount.Visible = false;

                    if (rblReportType.SelectedValue == "1")
                    {
                        //tabTotal1.Style.Add("display", "block");
                        tabTotal2.Style.Add("display", "block");

                        gvIPReport.Visible = true;
                        gvIPCreditMainSummary.Visible = false;
                        tblgvIPCreditMainSummary.Visible = false;
                        //gvIPReport.Columns[0].HeaderText = "IP - Deptwise Collection Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                        //CalculationPanelBlock();

                        tdQuantity2.InnerText = Convert.ToInt32(gtotalQuantity).ToString();
                        tdBilledAmount2.InnerText = gtotalBilledAmount.ToString("0.00");
                        //tdAmountReceived2.InnerText = gtotalAmountReceived.ToString("0.00");
                        //dvTotRcvd.InnerHtml = (gtotalAmountReceived + pTotalReceivedAmt + pServiceCharge + pTotalDue - pTotalDiscount).ToString();
                    }
                    else
                    {
                        //tabTotal1.Style.Add("display", "none");
                        tabTotal2.Style.Add("display", "block");

                        gvIPReport.Visible = false;
                        gvIPCreditMainSummary.Visible = true;
                        tblgvIPCreditMainSummary.Visible = true;
                        //gvIPCreditMainSummary.Columns[0].HeaderText = "IP - Deptwise Collection Report";
                        gvIPCreditMainSummary.DataSource = lstDwcRpt;
                        gvIPCreditMainSummary.DataBind();
                        //CalculationPanelBlock();

                        tdQuantity2.InnerText = Convert.ToInt32(totalQuantity).ToString();
                        tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
                        //tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
                        //dvTotRcvd.InnerHtml = (totalAmountReceived + pTotalReceivedAmt + pServiceCharge + pTotalDue - pTotalDiscount).ToString();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem + "&grdtot=" + tdBilledAmount2.InnerText;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";

                    }
                    //lblAdvRcvdText.Text = "Total advance amount received during the period";
                    //lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                    //lblAdvRcvdText.Visible = false;
                    //lblExcessAmount.Visible = false;
                    //tblExcessAmount.Visible = false;
                }
                else if (visitType == -1)
                {
                    //lblAdvRcvdText.Visible = false;
                    //lblExcessAmount.Visible = false;
                    //tblExcessAmount.Visible = false;

                    if (rblReportType.SelectedValue == "1")
                    {
                        //tabTotal1.Style.Add("display", "block");
                        tabTotal2.Style.Add("display", "none");

                        gvIPReport.Visible = true;
                        gvIPCreditMainSummary.Visible = false;
                        tblgvIPCreditMainSummary.Visible = false;
                        //gvIPReport.Columns[0].HeaderText = "IP - Deptwise Collection Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                        //CalculationPanelBlock();
                    }
                    else
                    {
                        //tabTotal1.Style.Add("display", "none");
                        tabTotal2.Style.Add("display", "block");

                        gvIPReport.Visible = false;
                        gvIPCreditMainSummary.Visible = true;
                        tblgvIPCreditMainSummary.Visible = true;
                        //gvIPCreditMainSummary.Columns[0].HeaderText = "IP - Deptwise Collection Report";
                        gvIPCreditMainSummary.DataSource = lstDwcRpt;
                        gvIPCreditMainSummary.DataBind();
                        //CalculationPanelBlock();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";
                    }
                    //lblAdvRcvdText.Text = "Addtional amount received during this period";
                    //lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                    //lblAdvRcvdText.Visible = false;
                    //lblExcessAmount.Visible = false;
                    //tblExcessAmount.Visible = false;
                }
                //tabGranTotal1.Visible = false; tabGranTotal2.Visible = false; trNetAmt.Visible = false;
                //lblExcessAmount.Text = pTotalReceivedAmt.ToString();

                //tabGranTotal2.Visible = false;
                //trDiscount.Visible = false;

                //else if (visitType == -1)
                //{
                //    gvOPReport.Columns[0].HeaderText = "OP & IP - Deptwise Collection Report";
                //}

            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");

                //tabTotal1.Style.Add("display", "block");
                tabTotal2.Style.Add("display", "block");
                //tblExcessAmount.Visible = false;
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }

           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }

    //public void CalculationPanelBlock()
    //{
    //    tabGranTotal1.Visible = true;
    //    tabGranTotal2.Visible = true;
    //    tabtotal.Visible = true;

    //    trServiceCharge.Visible = true;
    //    trTax.Visible = true;

    //    lblGrandTotal.InnerText = String.Format("{0:0.00}", (pTotalItemAmt));
    //    lblServiceCharge.InnerText = String.Format("{0:0.00}", ((pServiceCharge == -1 ? 0 : pServiceCharge)));
    //    lblTax.InnerText = String.Format("{0:0.00}", ((pTax == -1 ? 0 : pTax)));

    //    lblNetAmount.InnerText = String.Format("{0:0.00}", (pTotalNetValue));

    //    lblDiscountAmount.InnerText = String.Format("{0:0.00}", (pTotalDiscount));
    //    lblDueTotal.InnerText = String.Format("{0:0.00}", (pTotalItemAmt));
    //    lblDueAmount.InnerText = String.Format("{0:0.00}", (pTotalDue));
    //    lblReceivedAmount.InnerText = String.Format("{0:0.00}", (pTotalReceivedAmt));
    //}
    //public void CalculationPanelNone()
    //{
    //    tabGranTotal1.Visible = false;
    //    tabGranTotal2.Visible = false;
    //}

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

    protected void gvIPCreditMain_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Consultation")
        {

        }
        else if (e.CommandName == "Procedure")
        {

        }
        else if (e.CommandName == "Pharmacy")
        {

        }
        else if (e.CommandName == "Registration")
        {

        }
        else if (e.CommandName == "Others")
        {

        }
        else if (e.CommandName == "Packages")
        {

        }
        else if (e.CommandName == "Casualty")
        {

        }
        else if (e.CommandName == "Lab")
        {

        }
        else if (e.CommandName == "Imaging")
        {

        }
    }


    #region Report Summary

    protected void gvIPReportSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string visitType = rblVisitType.SelectedItem.Text;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                RMaster = (DayWiseCollectionReport)e.Row.DataItem;
            
                //foreach (var List in childItems)
                //{
                totalQuantity += RMaster.ItemQuantity;
                totalBilledAmount += RMaster.BilledAmount;
                totalAmountReceived += RMaster.AmountReceived;
                //}

                if (rblReportType.SelectedValue == "0")
                {

                    LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDateSummary");
                    lnkDwcr.Text = txtFDate.Text + " to " + txtTDate.Text;
                    lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMainSummary");
                    childGrid.DataSource = lstDwcRpt;
                    childGrid.DataBind();
                }
                else
                {
                    var childItems = from child in lstDwcRpt
                                     where child.VisitDate == RMaster.VisitDate
                                     select child;
                    LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDateSummary");
                    lnkDwcr.Text = txtFDate.Text + " to " + txtTDate.Text;
                    lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMainSummary");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReportSummary_RowDataBound OPCollectionReport", ex);
        }
    }
    protected void gvIPCreditMainSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string visitType = rblVisitType.SelectedItem.Text;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport dwcr = new DayWiseCollectionReport();
                dwcr = (DayWiseCollectionReport)e.Row.DataItem;
                LinkButton lnkDept = (LinkButton)e.Row.FindControl("lnkDept");
                if ((dwcr.FeeType != "") && (dwcr.FeeType != "TOTAL"))
                {

                    totalQuantity += dwcr.ItemQuantity;
                    totalBilledAmount += dwcr.BilledAmount;
                    totalAmountReceived += dwcr.AmountReceived;

                    string fType = string.Empty;
                    if (dwcr.FeeType == "Consultation")
                    {
                        fType = "CON";
                    }
                    else if (dwcr.FeeType == "Procedure")
                    {
                        fType = "Procedure";
                    }
                    else if (dwcr.FeeType == "Pharmacy")
                    {
                        fType = "PRM";
                    }
                    else if (dwcr.FeeType == "Registration")
                    {
                        fType = "REG";
                    }
                    else if (dwcr.FeeType == "Others")
                    {
                        fType = "OTH";
                    }
                    else if (dwcr.FeeType == "Packages")
                    {
                        fType = "PKG";
                    }
                    else if (dwcr.FeeType == "Casualty")
                    {
                        fType = "CAS";
                    }
                    else if (dwcr.FeeType == "Lab")
                    {
                        fType = "LAB";
                    }
                    else if (dwcr.FeeType == "Imaging")
                    {
                        fType = "IMG";
                    }
                    else if (dwcr.FeeType == "Room")
                    {
                        fType = "ROM";
                    }
                    else if (dwcr.FeeType == "Advance")
                    {
                        fType = "ADV";
                    }

                    else if (dwcr.FeeType == "Surgery Items")
                    {
                        fType = "SOI";
                    }
                    else if (dwcr.FeeType == "Surgery")
                    {
                        fType = "SUR";
                    }
                    else if (dwcr.FeeType == "Surgery Package")
                    {
                        fType = "SPKG";
                    }
                    else if (dwcr.FeeType == "General")
                    {
                        fType = "GEN";
                    }
                    else if (dwcr.FeeType == "Indents")
                    {
                        fType = "IND";
                    }

                    else if (dwcr.FeeType == "Misc")
                    {
                        fType = "Misc";
                    }
                    else if (dwcr.FeeType == "LCON")
                    {
                        fType = "LCON";
                    }
                    else if (dwcr.FeeType == "Due")
                    {
                        fType = "DUE";
                    }
                    else if (dwcr.FeeType == "Additional")
                    {
                        fType = "ADD";
                    }
                    else if (dwcr.FeeType != "")
                    {
                        fType = dwcr.FeeType;
                    }

                    //lbtnDwcr.ToolTip = "Click Here To view " + dwcr.FeeType + "details";
                    //lbtnDwcr.NavigateUrl = "DeptRevenueDetails.aspx?dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date

                    lnkDept.ToolTip = "Click Here To view details";
                    string url = Request.ApplicationPath + @"/Reports/DeptRevenueDetails.aspx?isPopup=Y&dpt=" + fType + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType + "&grdtot=" + dwcr.BilledAmount.ToString();       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDept.OnClientClick = "ReportPopUP('" + url + "');";
                }

                //if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                //{
                //    e.Row.Cells[0].Text = "";
                //    e.Row.Cells[2].Text = "";
                //    e.Row.Cells[3].Text = "";
                //    e.Row.Cells[4].Text = "";
                //    //e.Row.Cells[5].Text = "";
                //    //e.Row.Cells[15].Text = "";
                //    e.Row.Style.Add("font-weight", "bold");
                //    e.Row.Style.Add("color", "Black");
                //}
            }

            tdQuantity2.InnerText = totalQuantity.ToString("0.00");
            tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
            //tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
            //dvTotAdvance.InnerHtml = pTotalReceivedAmt.ToString("0.00");

            //tdServiceCharge.InnerHtml = pServiceCharge.ToString("0.00");
            //dvDuechartPayments.InnerHtml = pTotalDue.ToString("0.00");
            //dvTotalDiscounts.InnerHtml = pTotalDiscount.ToString("0.00");
            //dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge + pTotalDue - pTotalDiscount).ToString();

        
          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMainSummary_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    protected void gvIPCreditMainSummary_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Consultation")
        {

        }
        else if (e.CommandName == "Procedure")
        {

        }
        else if (e.CommandName == "Pharmacy")
        {

        }
        else if (e.CommandName == "Registration")
        {

        }
        else if (e.CommandName == "Others")
        {

        }
        else if (e.CommandName == "Packages")
        {

        }
        else if (e.CommandName == "Casualty")
        {

        }
        else if (e.CommandName == "Lab")
        {

        }
        else if (e.CommandName == "Imaging")
        {

        }
    }
    #endregion
    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "Collection_ReportsDPTOPIP_";
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
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }

    protected void gvIPCreditMain1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).IsDuePaidBill == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.Orange;
                e.Row.CssClass = "patientSearch";
                e.Row.ToolTip = "Due Collect from CollectDuepayment";
            }
            pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[16].Text);
            if (e.Row.Cells[15].Text != "" && e.Row.Cells[15].Text != "&nbsp;")
            {
                pPaidCurrencyCode = e.Row.Cells[15].Text;
            }
            if (e.Row.Cells[15].Text != "" && e.Row.Cells[15].Text != "&nbsp;" && e.Row.Cells[15].Text != BaseCurrencyCode)
            {
                showPaidCurrency = 1;
            }
            if (e.Row.Cells[15].Text != "" && e.Row.Cells[15].Text != "&nbsp;")
            {
                showPaidCurrency1 += 1;
            }
            if (temp < count)
            {
                e.Row.Visible = false;
                temp += 1;
            }
        }


        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (visitTypeID == 0)
        {
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
           
         

        }
        if (visitTypeID == 1)
        {
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
           
           
        }
        else if (visitTypeID == -1)
        {
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
           
         
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                if (count > 2)
                {
                    e.Row.Cells[1].Text = "TOTAL" + "(" + (count - 1) + ")";
                }
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";
              

                e.Row.Cells[6].Text = "";
                decimal received = Convert.ToDecimal(((DayWiseCollectionReport)e.Row.DataItem).ReceivedAmount);
                decimal refund = Convert.ToDecimal(((DayWiseCollectionReport)e.Row.DataItem).AmountRefund);
                //e.Row.Cells[8].Text = (received - refund).ToString();
                if (refund <= 0)
                {
                    e.Row.Cells[9].Text = received.ToString();
                }
                else { e.Row.Cells[9].Text = received + "<br>" + "Closing Balance:" + (received - refund).ToString(); }
                //e.Row.Cells[9].Text = "<table><tr><td>" + received + "</td></tr><tr><td>" + (received - refund).ToString() + "</td></tr></table>";
                //e.Row.Cells[9].Text = "XX";

                if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
                {
                    e.Row.Cells[16].Text = pPaidCurrencyTotal.ToString();
                    e.Row.Cells[15].Text = pPaidCurrencyCode;
                    if (pPaidCurrencyTotal.ToString() == "0" && pPaidCurrencyCode == "")
                    {
                        e.Row.Cells[15].Text = "--";
                        e.Row.Cells[16].Text = "--";
                    }
                }
                else
                {
                    e.Row.Cells[15].Text = "Multiple Currencies";
                    e.Row.Cells[16].Text = "--";
                }

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
        if (rblReportType.SelectedValue == "0" && e.Row.Cells[1].Text != "TOTAL" && e.Row.Cells[1].Text != "Name")
        {
            e.Row.Visible = false;
        }
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
        e.Row.Cells[4].Visible = false;
        e.Row.Cells[5].Visible = false;
        e.Row.Cells[6].Visible = false;
        e.Row.Cells[7].Visible = false;
     
      
    }
    protected void gvIPCreditMainSummary1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[7].Text = "--";
            e.Row.Cells[8].Text = "--";
        }
    }
    protected void ShowDayWiseCollectionPanel()
    {
        try
        {
            int currencyID = 0;
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int retreiveDataBaseOnVtype = visitType == 3 ? -1 : visitType;
            returnCode = new Report_BL(base.ContextInfo).GetCollectionReportOPIP(fDate, tDate, OrgID, 0, visitType, currencyID, out lstDWCR1, out pTotalBillAmt1, out pTotalPreDueReceived1, out pTotalDiscount1, out pTotalNetValue1, out pTotalReceivedAmt1, out pTotalDue1, out pTax1, out pServiceCharge1);

         
            var dwcr = (from dw in lstDWCR1
                        select new { dw.VisitDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept1 = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.VisitDate = obj.VisitDate;
                lstDayWiseRept1.Add(pdc);
            }

          

            //if (lstDWCR1.Count > 0)
            //{
            //    divOPDWCR.Attributes.Add("style", "block");
            //    divPrint.Attributes.Add("style", "block");
            //    divOPDWCR.Visible = true;
            //    divPrint.Visible = true;
            //    if (visitType == 0)
            //    {
            //        //gvOPReport.Visible = false;
            //        gvIPReport.Visible = true;
            //        gvIPReport.Columns[0].HeaderText = "OP - Collection Report";
            //        gvIPReport.DataSource = lstDayWiseRept1;
            //        gvIPReport.DataBind();
                  
            //    }
            //    else if (visitType == 1)
            //    {
            //        gvIPReport.Visible = true;
            //        //gvOPReport.Visible = false;
            //        gvIPReport.Columns[0].HeaderText = "IP - Collection Report";
            //        gvIPReport.DataSource = lstDayWiseRept1;
            //        gvIPReport.DataBind();
                   
            //    }
            //    else if (visitType == -1)
            //    {
            //        gvIPReport.Visible = true;
            //        //gvOPReport.Visible = false;
            //        gvIPReport.Columns[0].HeaderText = "OP & IP - Collection Report";
            //        gvIPReport.DataSource = lstDayWiseRept1;
            //        gvIPReport.DataBind();
                  
            //  }

            
              
           // }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }
}
