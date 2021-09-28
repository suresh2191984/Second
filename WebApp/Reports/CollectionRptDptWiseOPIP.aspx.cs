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
public partial class Reports_CollectionRptDptWiseOPIP : BasePage
{
    long returnCode = -1;
    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalNetValue = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;

    decimal totalQuantity = 0;
    decimal totalBilledAmount = 0;
    decimal totalAmountReceived = 0;

    decimal gtotalQuantity = 0;
    decimal gtotalBilledAmount = 0;
    decimal gtotalAmountReceived = 0;

    decimal totalServiceCharge = 0;

    DataSet ds = new DataSet();

    //Label lbQty = new Label();
    //Label lbBilledAmount = new Label();
    //Label lbAmtReceived = new Label();

    
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    IEnumerable<DayWiseCollectionReport> lstDwcRpt;

    public Reports_CollectionRptDptWiseOPIP()
        : base("Reports_CollectionRptDptWiseOPIP_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            LoadMetaData();
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ReportFormat,VisitType1";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            if (lstmetadataOutput.Count > 0)
            {
                var ReportFormat = from child in lstmetadataOutput
                                   where child.Domain == "ReportFormat"
                                   orderby child.DisplayText
                                   select child;
                rblReportType.DataSource = ReportFormat;
                rblReportType.DataTextField = "DisplayText";
                rblReportType.DataValueField = "Code";
                rblReportType.DataBind();

                rblReportType.SelectedValue = "-1";

                var VisitType1 = from child in lstmetadataOutput
                                where child.Domain == "VisitType1"
                                orderby child.DisplayText
                                select child;
                rblVisitType.DataSource = VisitType1;
                rblVisitType.DataTextField = "DisplayText";
                rblVisitType.DataValueField = "Code";
                rblVisitType.DataBind();
                // rblVisitType.Items.Insert(0, "--Select--");
                rblVisitType.SelectedValue = "2";
            }


        }





        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

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
            dr["BillAmount"] = item.BillAmount ;
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
                //DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                //var childItems = from child in lstDwcRpt
                //                 where child.VisitDate == RMaster.VisitDate
                //                 select child;


                //RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                //LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                //lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                //string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
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
                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt); 
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
                    //string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    //lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                    GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    lstday = childItems.ToList();
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt); 

                    lbQty.Text = Convert.ToInt32(totalQuantity).ToString();
                    lbBilledAmount.Text = totalBilledAmount.ToString();
                    lbAmtReceived.Text = totalAmountReceived.ToString();

                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType + "&grdtot=" + lbAmtReceived.Text;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";

                    gtotalAmountReceived = gtotalAmountReceived + totalAmountReceived;
                    gtotalQuantity = gtotalQuantity + totalQuantity;
                    gtotalBilledAmount = gtotalBilledAmount + totalBilledAmount;

                    totalQuantity = 0;
                    totalBilledAmount = 0;
                    totalAmountReceived = 0;
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
                        fType = "PRO";
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
                    else if(dwcr.FeeType !="")
                    {
                        fType = dwcr.FeeType;
                    }
                    




                    //lbtnDwcr.ToolTip = "Click Here To view " + dwcr.FeeType + "details";
                    //lbtnDwcr.NavigateUrl = "DeptDetails.aspx?dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date

                    //Link to view day details of particular feetype
                    lnkDept.ToolTip = "Click Here To view " + dwcr.VisitDate + " details";
                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
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
            string advAmt = Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_01 == null ? "Total advance amount received during the period" : Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_01;
            string RecAmt = Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_02 == null ? "Addtional amount received during this period" : Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_02;


            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);

            returnCode = new Report_BL(base.ContextInfo).GetCollectionRptDptWiseOPIP(fDate, tDate, OrgID, 0, visitType, out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, rblReportType.SelectedValue);

            if (visitType == 0)
            {
                dvTotAdvance.Visible = false;
                dvDuechartPayments.Visible = false;
                lbltotAdv.Visible = false;
                lblDueChart.Visible = false;
            }
            else
            {
                dvTotAdvance.Visible = true;
                dvDuechartPayments.Visible = false;
                lbltotAdv.Visible = true;
                lblDueChart.Visible = false;
            }

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
            } 
            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
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
                   // pdc.BilledAmount = obj.BilledAmount;
                    //pdc.ReceivedAmount = obj.ReceivedAmount;
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

                dvTotAdvance.InnerHtml = pTotalReceivedAmt.ToString("0.00");

                tdServiceCharge.InnerHtml = pServiceCharge.ToString("0.00");
                dvDuechartPayments.InnerHtml = pTotalDue.ToString("0.00");
                dvTotalDiscounts.InnerHtml = pTotalDiscount.ToString("0.00");

                dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge - pTotalDiscount).ToString();
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
                        CalculationPanelBlock();
                        tdQuantity2.InnerText = Convert.ToInt32(gtotalQuantity).ToString();
                        tdBilledAmount2.InnerText = gtotalBilledAmount.ToString("0.00");
                        tdAmountReceived2.InnerText = gtotalAmountReceived.ToString("0.00");
                        dvTotRcvd.InnerHtml = (gtotalAmountReceived + pServiceCharge - pTotalDiscount).ToString();
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
                        CalculationPanelBlock();

                        tdQuantity2.InnerText = Convert.ToInt32(totalQuantity).ToString();
                        tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
                        tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
                        dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge - pTotalDiscount).ToString();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem + "&grdtot=" + dvTotRcvd.InnerHtml;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";
                    }
                    lblAdvRcvdText.Visible = false;
                    lblExcessAmount.Visible = false;
                    tblExcessAmount.Visible = false;

                    //lblAdvRcvdText.Text = "Additional amount received apart from billed amount";
                    //lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                }
                else if (visitType == 1)
                {
                    lblAdvRcvdText.Visible = false;
                    lblExcessAmount.Visible = false;
                    tblExcessAmount.Visible = false;

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
                        CalculationPanelBlock();

                        tdQuantity2.InnerText =Convert.ToInt32( gtotalQuantity).ToString();
                        tdBilledAmount2.InnerText = gtotalBilledAmount.ToString("0.00");
                        tdAmountReceived2.InnerText = gtotalAmountReceived.ToString("0.00");
                        dvTotRcvd.InnerHtml = (gtotalAmountReceived + pTotalReceivedAmt+ pServiceCharge - pTotalDiscount).ToString();
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
                        CalculationPanelBlock();

                        tdQuantity2.InnerText =Convert.ToInt32(totalQuantity).ToString();
                        tdBilledAmount2.InnerText = totalBilledAmount.ToString("0.00");
                        tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
                        dvTotRcvd.InnerHtml = (totalAmountReceived + pTotalReceivedAmt + pServiceCharge - pTotalDiscount).ToString();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem + "&grdtot=" + dvTotRcvd.InnerHtml;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";

                    }
                   // lblAdvRcvdText.Text = "Total advance amount received during the period";  andrews
                    lblAdvRcvdText.Text = advAmt;
                    lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                    lblAdvRcvdText.Visible = false;
                    lblExcessAmount.Visible = false;
                    tblExcessAmount.Visible = false;
                }
                else if (visitType == -1)
                {
                    lblAdvRcvdText.Visible = false;
                    lblExcessAmount.Visible = false;
                    tblExcessAmount.Visible = false;

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
                        CalculationPanelBlock();
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
                        CalculationPanelBlock();

                        lnkDateSummary.Text = txtFDate.Text + " to " + txtTDate.Text;
                        string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + rblVisitType.SelectedItem;       //DPT Refers to Department ...... VDT Refers to Visit Date
                        lnkDateSummary.OnClientClick = "ReportPopUP('" + url + "');";
                    }
                   // lblAdvRcvdText.Text = "Addtional amount received during this period"; andrews
                    lblAdvRcvdText.Text = RecAmt;
                    lblExcessAmount.Text = pTotalReceivedAmt.ToString();
                    lblAdvRcvdText.Visible = false;
                    lblExcessAmount.Visible = false;
                    tblExcessAmount.Visible = false;
                }
                tabGranTotal1.Visible = false; tabGranTotal2.Visible = false; trNetAmt.Visible = false;
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
                tblExcessAmount.Visible = false;
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                   string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonMessages_20").ToString();
                   if (sUserMsg != null)
                   {
                       ScriptManager.RegisterStartupScript(this, this.GetType(), "hideDiv", "alert('" + sUserMsg + "')", true);
                   }
                   else
                   {
                       ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                   }
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
        tabtotal.Visible = true;

        trServiceCharge.Visible = true;
        trTax.Visible = true;

        lblGrandTotal.InnerText = String.Format("{0:0.00}", (pTotalItemAmt));
        lblServiceCharge.InnerText = String.Format("{0:0.00}", ((pServiceCharge == -1 ? 0 : pServiceCharge)));
        lblTax.InnerText = String.Format("{0:0.00}", ((pTax == -1 ? 0 : pTax)));

        lblNetAmount.InnerText = String.Format("{0:0.00}", (pTotalNetValue));

        lblDiscountAmount.InnerText = String.Format("{0:0.00}", (pTotalDiscount));
        lblDueTotal.InnerText = String.Format("{0:0.00}", (pTotalItemAmt));
        lblDueAmount.InnerText = String.Format("{0:0.00}", (pTotalDue));
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
                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
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
                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + 0 + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
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
        string click = Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_03 == null ? "Click Here To view details" : Resources.Reports_ClientDisplay.Reports_CollectionRptDptWiseOPIP_aspx_03;
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
                        fType = "PRO";
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
                    //lbtnDwcr.NavigateUrl = "DeptDetails.aspx?dpt=" + fType + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date

                    //   lnkDept.ToolTip = "Click Here To view details"; andrews
                    lnkDept.ToolTip = click;
                    string url = Request.ApplicationPath + @"/Reports/DeptDetails.aspx?isPopup=Y&dpt=" + fType + "&vfdt=" + txtFDate.Text + "&vtdt=" + txtTDate.Text + "&vtype=" + visitType + "&grdtot=" + dwcr.AmountReceived.ToString();       //DPT Refers to Department ...... VDT Refers to Visit Date
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
            tdAmountReceived2.InnerText = totalAmountReceived.ToString("0.00");
            dvTotAdvance.InnerHtml = pTotalReceivedAmt.ToString("0.00");

            tdServiceCharge.InnerHtml = pServiceCharge.ToString("0.00");
            dvDuechartPayments.InnerHtml = pTotalDue.ToString("0.00");
            dvTotalDiscounts.InnerHtml = pTotalDiscount.ToString("0.00");
            dvTotRcvd.InnerHtml = (totalAmountReceived + pServiceCharge - pTotalDiscount).ToString();
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
    //protected void lnkExportXL_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        //export to excel
    //        string prefix = string.Empty;
    //        prefix = "Collection_ReportsDPTOPIP_";
    //        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
    //        DataSet dsrpt = (DataSet)ViewState["report"];
    //        if (dsrpt != null)
    //        {
    //            ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
    //        }
    //       // HttpContext.Current.ApplicationInstance.CompleteRequest();
    //    }
    //    catch (System.Threading.ThreadAbortException ex)
    //    {
    //        CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
    //    }
    //}
    #region SingleXLReport
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            string SingleXl = GetConfigValue("SingleXLReport", OrgID);
            if (SingleXl == "Y")
            {
                btnSubmit_Click(sender, e);
                ExportToExcel(gvIPReport);
            }
            else
            {
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
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during exporting to Excel", ex);
        }
    }

    public void ExportToExcel(Control CTRl)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Collection_ReportsDPTOPIP"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        gvIPCreditMainSummary.RenderControl(htmlWrite);
        gvIPReport.RenderControl(htmlWrite);
        tabTotal2.RenderControl(htmlWrite);
        tblExcessAmount.RenderControl(htmlWrite);
        tabGranTotal1.RenderControl(htmlWrite);
        tabGranTotal2.RenderControl(htmlWrite);
        tabtotal.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public void Export(string ID, string ExcelName)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", ExcelName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        GridView ExcelGrid = new GridView();
        ExcelGrid.ID = ID;

        ExcelGrid.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
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
    #endregion
}
