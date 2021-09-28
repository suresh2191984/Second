using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Linq;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;


public partial class InventoryReports_PrintSalesReport : Attune_BasePage
{
    public InventoryReports_PrintSalesReport()
        : base("InventoryReports_PrintSalesReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    Int32 LocId = 0;
    int vtype;
    Decimal totbill = 0;
    Decimal Duerec = 0;
    Decimal totDis = 0;
    Decimal totnet=0;
    Decimal totrec=0;
    Decimal totdue=0;
    Decimal tax=0;
    Decimal sercge = 0;
    int curid;

   
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    List<SalesTax > lstSalesReport = null;
    List<SalesTax > lstSalesDetail = null;
    List<SalesTax > lstDWCR = null;
    InventoryCommon_BL inventoryBL;
    InventoryReports_BL invReportsBL;
    string strSalesRrtFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_01 == null ? "Sales Report From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_01;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_02 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_02;
    string strSReport = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_03 == null ? "SALES REPORT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_03;
    string strBillDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_04 == null ? "Bill Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_04;
    string strBillNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_05 == null ? "Bill No" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_05;
    string strNetTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_06 == null ? "Net Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_06;
    string strGrossTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_07 == null ? "Gross Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_07;
    string strVAT0 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_08 == null ? "VAT0" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_08;
    string strVAT4 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_09 == null ? "VAT4" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_09;
    string strVAT5 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_10 == null ? "VAT5" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_10;
    string strVAT12 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_11 == null ? "VAT12.5" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_11;
    string strVAT13 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_12 == null ? "VAT13.5" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_12;
    string strOtherTax = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_13 == null ? "Other Tax%" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_13;
    string strBillAmt = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_14 == null ? "Bill Amount" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_14;
    string strDiscount = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_15 == null ? "Discount" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_15;
    string strNetAmt = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_16 == null ? "Net Amount" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_16;
    string strReceivedAmt = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_17 == null ? "Received Amount" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_17;
    string strDue = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_18 == null ? "Due" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_18;
    string strCash = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_19 == null ? "Cash" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_19;
    string strCard = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_20 == null ? "Card" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_20;
    string strCheque = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_21 == null ? "Cheque" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_21;
    string strDD = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_22 == null ? "DD" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_22;
    string strRefund = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_23 == null ? "Refund" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_23;
    string strDepositUsed = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_24 == null ? "Deposit Used" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_24;
    string strCloseBalance = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_25 == null ? "Closing Balance" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_25;
    string strGrandTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_26 == null ? "Grand Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesReport_aspx_26;

    protected void Page_Load(object sender, EventArgs e)
    {
        invReportsBL = new InventoryReports_BL(base.ContextInfo);
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
       
        if (!Page.IsPostBack)
        {
            try
            {
                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                Int32.TryParse(Request.QueryString["Loc"], out LocId);
                int.TryParse(Request.QueryString["vType"], out vtype);
                Decimal.TryParse(Request.QueryString["billamt"], out totbill);
                Decimal.TryParse(Request.QueryString["duerece"], out Duerec);
                Decimal.TryParse(Request.QueryString["tDis"], out totDis);
                Decimal.TryParse(Request.QueryString["tNet"], out totnet);
                Decimal.TryParse(Request.QueryString["tRecamt"], out totrec);
                Decimal.TryParse(Request.QueryString["tDue"], out totdue);
                Decimal.TryParse(Request.QueryString["tax"], out tax);
                Decimal.TryParse(Request.QueryString["serv"], out sercge);
                curid= Convert.ToInt16(Request .QueryString["curID"]);

                List<SalesTax> lstFinalBill = new List<SalesTax>();


                fromToStockReport.Text = strSalesRrtFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                string BillNum = string.Empty;
                int VisitType = -1;
                List<SalesTax> lstSalesGSTDetail = null;
                invReportsBL.GetSalesReport(fromDate, toDate, LocId, OrgID, ILocationID, BillNum, out lstSalesReport, out lstSalesDetail,out lstSalesGSTDetail, VisitType);
                invReportsBL.GetCollectionReportOPIPSummary(fromDate, toDate, OrgID, 0, vtype, curid, out  lstDWCR, out totbill, out totdue, out totDis, out totnet, out totrec, out totdue, out tax, out sercge);
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderStockReport.Text =strSReport;
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;

                if (lstSalesReport != null && lstSalesReport.Count > 0)
                {
                    var temp = lstSalesReport;
                    temp = lstSalesReport.FindAll(p => p.Comments != "Summary").ToList();
                    LoadDispensingReportHeaders(temp);
                }
                if (lstDWCR != null && lstDWCR.Count > 0)
                {
                    Loadsumaary(lstDWCR);
                }
               

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Print SalesReport.aspx", ex);
            }
        }
    }

    private void LoadDispensingReportHeaders(List<SalesTax> lstSalesReport)
    {
        decimal net = 0;
        decimal grand = 0;
        decimal vat = 0;
        decimal vat4 = 0;
        decimal vat5 = 0;
        decimal vat12 = 0;
        decimal vat13 = 0;
        decimal vatothers = 0;

        //long returncode = -1;
        

        if (lstSalesReport.Count() > 0)
        {
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();
            footRow.Font.Name = "calibric";
            headRow.BackColor = System.Drawing.Color.DarkGray;
            footRow.BackColor = System.Drawing.Color.DarkGray;
            footRow.Font.Size = 10;
            TableCell hBillDate = new TableCell();
            TableCell hBillNo = new TableCell();
            TableCell hGrand = new TableCell();
            TableCell hNetValue = new TableCell();
            TableCell hVat = new TableCell();
            TableCell hvat4 = new TableCell();
            TableCell hvat5 = new TableCell();
            TableCell hvat12 = new TableCell();
            TableCell hvat13 = new TableCell();
            TableCell hVat0thers = new TableCell();
            TableCell hnet = new TableCell();
           
            hBillDate.Attributes.Add("align", "right");
            hBillDate.Text = strBillDate;

            hBillDate.Width = Unit.Percentage(8);
          

            hBillNo.Attributes.Add("align", "right");
            hBillNo.Text = strBillNo;
            hBillNo.Width = Unit.Percentage(8);


            hGrand.Attributes.Add("align", "right");
            hGrand.Text = strNetTotal;
            hGrand.Width = Unit.Percentage(8);

            hNetValue.Attributes.Add("align", "right");
            hNetValue.Text = strGrossTotal;
            hNetValue.Width = Unit.Percentage(8);

            hVat.Attributes.Add("align", "right");
            hVat.Text = strVAT0;
            hVat.Width = Unit.Percentage(8);

            hvat4.Attributes.Add("align", "right");
            hvat4.Text = strVAT4;
            hvat4.Width = Unit.Percentage(8);
            hvat5.Attributes.Add("align", "right");
            hvat5.Text = strVAT5;
            hvat5.Width = Unit.Percentage(8);
            hvat12.Attributes.Add("align", "right");
            hvat12.Text = strVAT12;
            hvat12.Width = Unit.Percentage(8);
            hvat13.Attributes.Add("align", "right");
            hvat13.Text = strVAT13;
            hvat13.Width = Unit.Percentage(8);
            hVat0thers.Attributes.Add("align", "right");
            hVat0thers.Text = strOtherTax;
            hVat0thers.Width = Unit.Percentage(8);
          

            headRow.Cells.Add(hBillDate);
            headRow.Cells.Add(hBillNo);
            headRow.Cells.Add(hGrand);
            headRow.Cells.Add(hNetValue);
        
            headRow.Cells.Add(hvat4);
            headRow.Cells.Add(hvat5);
            headRow.Cells.Add(hvat12);
            headRow.Cells.Add(hvat13);
            headRow.Cells.Add(hVat);
            headRow.Cells.Add(hVat0thers);

          
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 15;
           // headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);


            foreach (SalesTax  item in lstSalesReport)
            {
                TableRow deadRow = new TableRow();

                TableCell dBillDate = new TableCell();
                TableCell dBillNo = new TableCell();
                TableCell dGrand = new TableCell();
                TableCell dNetValue = new TableCell();
              
                TableCell dVat4 = new TableCell();
                TableCell dVat5 = new TableCell();
                TableCell dVat12 = new TableCell();
                TableCell dVat13 = new TableCell();
                TableCell dVat = new TableCell();
                TableCell dVatothers = new TableCell();


                dBillDate.Attributes.Add("align", "right");
                dBillDate.Text = item.CreatedAt.ToString("dd/MMM/yyyy");
                dBillDate.Width = Unit.Percentage(8);


                dBillNo.Attributes.Add("align", "right");
              
                dBillNo.Text = item.BillNumber.ToString();
                   
                dBillNo.Width = Unit.Percentage(8);

                dGrand.Attributes.Add("align", "right");
                dGrand.Text = item.GrossBillValue.ToString();
                dGrand.Width = Unit.Percentage(8);
                grand += item.GrossBillValue;
                
                dNetValue.Attributes.Add("align", "right");
                dNetValue.Text = item.NetValue.ToString();
                dNetValue.Width = Unit.Percentage(8);
                net += item.NetValue;

               

                dVat4.Attributes.Add("align", "right");
                dVat4.Text = item.AdvanceRecieved.ToString();
                dVat4.Width = Unit.Percentage(8);
                vat4 += item.AdvanceRecieved;

                dVat5.Attributes.Add("align", "right");
                dVat5.Text = item.TaxPercent.ToString();
                dVat5.Width = Unit.Percentage(8);
                vat5 += item.TaxPercent;

                dVat12.Attributes.Add("align", "right");
                dVat12.Text = item.AmountReceived.ToString();
                dVat12.Width = Unit.Percentage(8);
                vat12 += item.AmountReceived;

                dVat13.Attributes.Add("align", "right");
                dVat13.Text = item.ServiceCharge.ToString();
                dVat13.Width = Unit.Percentage(8);
                vat13 += item.ServiceCharge;

                dVat.Attributes.Add("align", "right");
                dVat.Text = item.AmountRefund.ToString();
                dVat.Width = Unit.Percentage(8);
                vat += item.AmountRefund;

                dVatothers.Attributes.Add("align", "right");
                dVatothers.Text = item.CurrentDue.ToString();
                dVatothers.Width = Unit.Percentage(8);
                vatothers += item.CurrentDue;

                deadRow.Cells.Add(dBillDate);
                deadRow.Cells.Add(dBillNo);
                deadRow.Cells.Add(dGrand);
                deadRow.Cells.Add(dNetValue);
             
                deadRow.Cells.Add(dVat4);
                deadRow.Cells.Add(dVat5);
                deadRow.Cells.Add(dVat12);
                deadRow.Cells.Add(dVat13);
                deadRow.Cells.Add(dVat);
                deadRow.Cells.Add(dVatothers);


                DataHeaders.Rows.Add(deadRow);
               

            }


            TableCell fBillDate = new TableCell();
            TableCell fBillNo = new TableCell();
            TableCell fGrand = new TableCell();
            TableCell fNetValue = new TableCell();
           
            TableCell fVat4 = new TableCell();
            TableCell fVat5 = new TableCell();
            TableCell fVat12 = new TableCell();
            TableCell fVat13 = new TableCell();
            TableCell fVat = new TableCell();
            TableCell fVatothers = new TableCell();


            TableRow footLineRow = new TableRow();
            TableCell footLineCell = new TableCell();
            footLineCell.ColumnSpan = 15;
            footLineCell.Text = "<hr/>";
            footLineRow.Cells.Add(footLineCell);
            DataHeaders.Rows.Add(footLineRow);

            fBillDate.Attributes.Add("align", "right");
            fBillDate.Text = "";
            fBillDate.Width = Unit.Percentage(8);



            fBillNo.Attributes.Add("align", "left");
            fBillNo.Text = strGrandTotal;
            fBillNo.Width = Unit.Percentage(8);


            fGrand.Attributes.Add("align", "right");
            //fGrand.Text = grand.ToString();
            fGrand.Text = String.Format("{0:f}", grand);
            fGrand.Width = Unit.Percentage(8);

            fNetValue.Attributes.Add("align", "right");
            fNetValue.Text = String.Format("{0:f}", net);
            fNetValue.Width = Unit.Percentage(8);

           

            fVat4.Attributes.Add("align", "right");
            fVat4.Text = String.Format("{0:f}", vat4);
            fVat4.Width = Unit.Percentage(8);

            fVat5.Attributes.Add("align", "right");
            fVat5.Text = String.Format("{0:f}", vat5);
            fVat5.Width = Unit.Percentage(8);

            fVat12.Attributes.Add("align", "right");
            fVat12.Text = String.Format("{0:f}", vat12);
            fVat12.Width = Unit.Percentage(8);


            fVat13.Attributes.Add("align", "right");
            fVat13.Text = String.Format("{0:f}", vat13);
            fVat13.Width = Unit.Percentage(8);
            fVat.Attributes.Add("align", "right");
            fVat.Text = String.Format("{0:f}", vat);
            fVat.Width = Unit.Percentage(8);

            fVatothers.Attributes.Add("align", "right");
            fVatothers.Text = String.Format("{0:f}", vatothers);
            fVatothers.Width = Unit.Percentage(8);

            footRow.Cells.Add(fBillDate);
            footRow.Cells.Add(fBillNo);
            footRow.Cells.Add(fGrand);
            footRow.Cells.Add(fNetValue);
        
            footRow.Cells.Add(fVat4);
            footRow.Cells.Add(fVat5);
            footRow.Cells.Add(fVat12);
            footRow.Cells.Add(fVat13);
            footRow.Cells.Add(fVat);
            footRow.Cells.Add(fVatothers);                   
            DataHeaders.Rows.Add(footRow);
            footLineRow.Cells.Add(footLineCell);
        }
    }





    private void Loadsumaary(List<SalesTax> lstDWCR)
    {
        decimal billamt = 0;
        decimal discount = 0;
        decimal netamt = 0;
        decimal recdamt = 0;
        decimal cash = 0;
        decimal card = 0;
        decimal cheque = 0;

        decimal dd = 0;
        decimal refund = 0;
        decimal depositused = 0;
        decimal clobal = 0;
      
        decimal tDue = 0;
        


        if (lstDWCR.Count() > 0)
        {

            TableRow headLineRow = new TableRow();
            TableCell headLineCell = new TableCell();
            headLineCell.ColumnSpan = 15;
            headLineCell.Text = "<hr/>";
            headLineRow.Cells.Add(headLineCell);
            DataHeaders1.Rows.Add(headLineRow);

            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();

            TableCell hbillamt = new TableCell();
            TableCell hdiscount = new TableCell();
            TableCell hnetamt = new TableCell();
            TableCell hrecdamt = new TableCell();
            TableCell hcash = new TableCell();
            TableCell hcard = new TableCell();
            TableCell hcheque = new TableCell();
            TableCell hdd = new TableCell();
            TableCell hrefund = new TableCell();
            TableCell hdepositused = new TableCell();
            TableCell hclobal = new TableCell();
            TableCell hdue = new TableCell();

            hbillamt.Attributes.Add("align", "right");
            hbillamt.Text = strBillAmt;
            hbillamt.Width = Unit.Percentage(10);
         
            

            hdiscount.Attributes.Add("align", "right");
            hdiscount.Text = strDiscount;
            hdiscount.Width = Unit.Percentage(10);

            hnetamt.Attributes.Add("align", "right");
            hnetamt.Text = strNetAmt;
            hnetamt.Width = Unit.Percentage(10);

            hrecdamt.Attributes.Add("align", "right");
            hrecdamt.Text = strReceivedAmt;
            hrecdamt.Width = Unit.Percentage(10);


            hdue.Attributes.Add("align", "right");
            hdue.Text = strDue;
            hdue.Width = Unit.Percentage(10);


            hcash.Attributes.Add("align", "right");
            hcash.Text = strCash;
            hcash.Width = Unit.Percentage(10);

            hcard.Attributes.Add("align", "right");
            hcard.Text = strCard;
            hcard.Width = Unit.Percentage(10);
            hcheque.Attributes.Add("align", "right");
            hcheque.Text = strCheque;
            hcheque.Width = Unit.Percentage(10);

            hdd.Attributes.Add("align", "right");
            hdd.Text = strDD;
            hdd.Width = Unit.Percentage(8);
            hrefund.Attributes.Add("align", "right");
            hrefund.Text = strRefund;
            hrefund.Width = Unit.Percentage(10);
            hdepositused.Attributes.Add("align", "right");
            hdepositused.Text = strDepositUsed;
            hdepositused.Width = Unit.Percentage(10);
            hclobal.Attributes.Add("align", "right");
            hclobal.Text = strCloseBalance;
            hclobal.Width = Unit.Percentage(15);


            headRow.Cells.Add(hbillamt);
            headRow.Cells.Add(hdiscount);
            headRow.Cells.Add(hnetamt);
            headRow.Cells.Add(hrecdamt);
            headRow.Cells.Add(hdue);
            headRow.Cells.Add(hcash);
            headRow.Cells.Add(hcard);
            headRow.Cells.Add(hcheque);
            headRow.Cells.Add(hdd);
            headRow.Cells.Add(hrefund);
            headRow.Cells.Add(hdepositused);
            headRow.Cells.Add(hclobal);



            DataHeaders1.Rows.Add(headRow);
           
            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 14;
           
            //headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders1.Rows.Add(headLine2Row);


            foreach (SalesTax  day  in lstDWCR)
            {
                TableRow deadRow = new TableRow();

                TableCell dbillamt = new TableCell();
                TableCell ddiscount = new TableCell();
                TableCell dnetamt = new TableCell();
                TableCell drecdamt = new TableCell();
                TableCell dcash = new TableCell();
                TableCell dcard = new TableCell();
                TableCell dcheque = new TableCell();
                TableCell ddd = new TableCell();
                TableCell drefund = new TableCell();
                TableCell ddepositused = new TableCell();
                TableCell dclobal = new TableCell();
                TableCell ddue = new TableCell();





                dbillamt.Attributes.Add("align", "right");
                dbillamt.Text = day.BillAmount.ToString();
                    //item.BillAmount.ToString("dd/MMM/yyyy");
                dbillamt.Width = Unit.Percentage(10);
                billamt += day.BillAmount;

                ddue.Attributes.Add("align", "right");

                ddue.Text = day.Due.ToString();

                ddue.Width = Unit.Percentage(10);
                tDue += day.Due; 

                ddiscount.Attributes.Add("align", "right");

                ddiscount.Text = day.Discount.ToString();

                ddiscount.Width = Unit.Percentage(10);
                discount+=day .Discount;
                
                dnetamt.Attributes.Add("align", "right");
                dnetamt.Text = day.NetValue.ToString();

                dnetamt.Width = Unit.Percentage(10);
                netamt += day.NetValue ;

                drecdamt.Attributes.Add("align", "right");
                drecdamt.Text = day.ReceivedAmount.ToString();
                drecdamt.Width = Unit.Percentage(10);
                recdamt += day.ReceivedAmount;

                dcash.Attributes.Add("align", "right");
                dcash.Text = day.Cash.ToString();
                dcash.Width = Unit.Percentage(10);
                cash += day.Cash ;

                dcard.Attributes.Add("align", "right");
                dcard.Text = day.Cards.ToString();
                dcard.Width = Unit.Percentage(10);
                card += day.Cards;



                dcheque.Attributes.Add("align", "right");
                dcheque.Text = day.Cheque.ToString();
                dcheque.Width = Unit.Percentage(10);
                cheque += day.Cheque;
                ddd.Attributes.Add("align", "right");
                ddd.Text = day.DD.ToString();
                ddd.Width = Unit.Percentage(10);
                dd += day.DD;
                drefund.Attributes.Add("align", "right");
                drefund.Text = day.AmountRefund.ToString();
                drefund.Width = Unit.Percentage(10);
                refund += day.AmountRefund;
                ddepositused.Attributes.Add("align", "right");
                ddepositused.Text = day.DepositUsed.ToString();
                ddepositused.Width = Unit.Percentage(10);
                depositused += day.DepositUsed;
                dclobal.Attributes.Add("align", "right");
                dclobal.Text = day.CoPayment.ToString();
                dclobal.Width = Unit.Percentage(10);
                clobal += day.CoPayment;
               // vatothers += day.ServiceCharge;

                deadRow.Cells.Add(dbillamt);
                deadRow.Cells.Add(ddiscount);
                deadRow.Cells.Add(dnetamt);
                deadRow.Cells.Add(drecdamt);
                deadRow.Cells.Add(ddue);
                deadRow.Cells.Add(dcash);
                deadRow.Cells.Add(dcard);
                deadRow.Cells.Add(dcheque);
                deadRow.Cells.Add(ddd);
                deadRow.Cells.Add(drefund);
                deadRow.Cells.Add(ddepositused);
                deadRow.Cells.Add(dclobal);

            }


            TableCell fbillamt = new TableCell();
            TableCell fdiscount = new TableCell();
            TableCell fnetamt = new TableCell();
            TableCell frecdamt = new TableCell();
            TableCell fcash = new TableCell();
            TableCell fcard = new TableCell();
            TableCell fcheque = new TableCell();
            TableCell fdd = new TableCell();
            TableCell frefund = new TableCell();
            TableCell fdepositused = new TableCell();
            TableCell fclobal = new TableCell();
            TableCell fdue = new TableCell();



            TableRow footLineRow = new TableRow();
            TableCell footLineCell = new TableCell();
            footLineCell.ColumnSpan = 15;
            footLineCell.Text = "<hr/>";
            
            footLineRow.Cells.Add(footLineCell);
            DataHeaders1.Rows.Add(footLineRow);
          
            fbillamt.Attributes.Add("align", "right");
            fbillamt.Text = String.Format("{0:f}", billamt);
            fbillamt.Width = Unit.Percentage(8);

            fdue.Attributes.Add("align", "right");
            fdue.Text = String.Format("{0:f}", tDue);
            fdue.Width = Unit.Percentage(8);



            fdiscount.Attributes.Add("align", "left");
            fdiscount.Text = String.Format("{0:f}", discount);
            fdiscount.Width = Unit.Percentage(8);


            fnetamt.Attributes.Add("align", "right");
            //fGrand.Text = grand.ToString();
            fnetamt.Text = String.Format("{0:f}", netamt);
            fnetamt.Width = Unit.Percentage(8);

            frecdamt.Attributes.Add("align", "right");
            frecdamt.Text = String.Format("{0:f}", recdamt);
            frecdamt.Width = Unit.Percentage(8);

            fcash.Attributes.Add("align", "right");
            fcash.Text = String.Format("{0:f}", cash);
            fcash.Width = Unit.Percentage(8);

            fcard.Attributes.Add("align", "right");
            fcard.Text = String.Format("{0:f}", card);
            fcard.Width = Unit.Percentage(8);

            fcheque.Attributes.Add("align", "right");
            fcheque.Text = String.Format("{0:f}", cheque);
            fcheque.Width = Unit.Percentage(8);

            fdd.Attributes.Add("align", "right");
            fdd.Text = String.Format("{0:f}", dd);
            fdd.Width = Unit.Percentage(8);

            frefund.Attributes.Add("align", "right");
            frefund.Text = String.Format("{0:f}", refund);
            frefund.Width = Unit.Percentage(8);

            fdepositused.Attributes.Add("align", "right");
            fdepositused.Text = String.Format("{0:f}", depositused);
            fdepositused.Width = Unit.Percentage(8);

            fclobal.Attributes.Add("align", "right");
            fclobal.Text = String.Format("{0:f}", clobal);
            fclobal.Width = Unit.Percentage(8);


            footRow.Cells.Add(fbillamt);
            footRow.Cells.Add(fdiscount);
            footRow.Cells.Add(fnetamt);
            footRow.Cells.Add(frecdamt);
            footRow.Cells.Add(fdue);
            footRow.Cells.Add(fcash);
            footRow.Cells.Add(fcard);
            footRow.Cells.Add(fcheque);
            footRow.Cells.Add(fdd);
            footRow.Cells.Add(frefund);
            footRow.Cells.Add(fdepositused);
            footRow.Cells.Add(fclobal);
            DataHeaders1.Rows.Add(footRow);

            footLineRow.Cells.Add(footLineCell);
        }
    }
}