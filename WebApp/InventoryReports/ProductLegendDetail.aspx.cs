using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_ProductLegendDetail : Attune_BasePage
{
    public InventoryReports_ProductLegendDetail()
        : base("InventoryReports_ProductLegendDetail_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    List<StockMovementSummary> lstProductLegend = new List<StockMovementSummary>();
    List<ProductLegendSummary> lstProductLegendDetail = new List<ProductLegendSummary>();
    InventoryCommon_BL inventoryBL ;
    //long returnCode = -1;
    long ProductId = 0;
    string ProductName = "";
    string strProductFor = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_01 == null ? "Product Legend For" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_01;
    string strFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_02 == null ? "From" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_02;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_03 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_03;
    string strPLegent = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_04 == null ? "PRODUCT LEGEND" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_04;
    string strProduct = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_05 == null ? "Product" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_05;
    string strDate = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_06 == null ? "Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_06;
    string strOpenBal = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_07 == null ? "Opening Balance" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_07;
    string strTrans = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_08 == null ? "TRANSACTIONS" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_08;
    string strStockRec = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_09 == null ? "Stock Received" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_09;
    string strStockIssued = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_10 == null ? "Stock Issued" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_10;
    string strStockDamage = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_11 == null ? "Stock Damage" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_11;
    string strStockReturn = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_12 == null ? "Stock Return" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_12;
    string strSRDNo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_13 == null ? "SRD No" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_13;
    string strRecFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_14 == null ? "Received From" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_14;
    string strIssuedTo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_15 == null ? "Issued To" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_15;
    string strBillID = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_16 == null ? "Bill ID" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_16;
    string strBillNo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_17 == null ? "Issued Refence No" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_17;
    string strPatientName = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_18 == null ? "Patient Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_18;
    string strIssueLocation = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_19 == null ? "Issue Location" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_19;
    string strReceiveLocation = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_20 == null ? "Receive Location" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_20;
    string strClosingBal = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_21 == null ? "Closing Balance" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_21;
    string strTransactionDate = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_22 == null ? "Transaction Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_22;
    string strBatchNo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_23 == null ? "Batch No" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_23;
    string strExpiryDate = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_24 == null ? "Expiry Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegendDetail_aspx_24;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!Page.IsPostBack)
        {
            try
            {
                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                Int64.TryParse(Request.QueryString["ProID"], out ProductId);

                if (Request.QueryString["ProID"] == null)
                {
                    ProductName = Request.QueryString["pName"].ToString();
                    fromToStockReport.Text = strProductFor + " " + strFrom + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                }

                if (Request.QueryString["ProID"] != null)
                {
                    new InventoryReports_BL(base.ContextInfo).GetProductLegendDetail(fromDate, toDate, OrgID, ILocationID, InventoryLocationID, ProductId, out lstProductLegend, out lstProductLegendDetail);
                    if (lstProductLegendDetail.Count > 0)
                    {
                        ProductName = lstProductLegendDetail.Find(p => p.ProductId == ProductId).ProductName;
                    }
                    fromToStockReport.Text = strProductFor + " " + ProductName.ToUpper() + strFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                }
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderStockReport.Text = strPLegent;
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                LoadProductLegendHeaders(lstProductLegend, lstProductLegendDetail);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in ProductLegendDetail.aspx", ex);
            }
        }
    }

    private void LoadProductLegendHeaders(List<StockMovementSummary> lstProductLegend, List<ProductLegendSummary> lstProductLegendDetail)
    {

        if (lstProductLegend.Count() > 0)
        {

            TableRow headRow = new TableRow();

            TableCell hProductName = new TableCell();
            TableCell hDate = new TableCell();
            TableCell hOpeningBalance = new TableCell();
            TableCell TranHead = new TableCell();

            Table tblTransactionMain = new Table();
            Table tblTransactionSub = new Table();

            TableRow trTransactionMain = new TableRow();
            TableRow trTransactionSub = new TableRow();

            TableCell hTransactionMain = new TableCell();
            TableCell hTransactionSub = new TableCell();

            TableCell hTransactionDate = new TableCell();
            TableCell hBatchNo = new TableCell();
            TableCell hExpiryDate = new TableCell();
            TableCell hStockReceived = new TableCell();
            TableCell hStockIssued = new TableCell();
            TableCell hStockDamage = new TableCell();
            TableCell hStockReturn = new TableCell();
            TableCell hSrdNo = new TableCell();
            TableCell hReceivedFrom = new TableCell();
            TableCell hIssuedTo = new TableCell();
            TableCell hBillId = new TableCell();
            TableCell hBillNo = new TableCell();
            TableCell hPatientName =new TableCell();
            TableCell hIssueLocation = new TableCell();
            TableCell hReceiveLocation = new TableCell();


            TableCell hClosingBalance = new TableCell();

            tblTransactionSub.BorderWidth = 1;

            if (Request.QueryString["ProID"] == null)
            {
                hProductName.Attributes.Add("align", "left");
                hProductName.Text = strProduct;
                hProductName.Width = Unit.Percentage(20);
                headRow.Cells.Add(hProductName);
            }
            if (Request.QueryString["ProID"] != null)
            {
                hDate.Attributes.Add("align", "left");
                hDate.Text = strDate;
                hDate.Width = Unit.Pixel(100);
                headRow.Cells.Add(hDate);
            }
            hOpeningBalance.Attributes.Add("align", "left");
            hOpeningBalance.Text = strOpenBal;
            hOpeningBalance.Width = Unit.Pixel(80);


            hTransactionMain.Attributes.Add("align", "left");
            hTransactionMain.Text = strTrans;
            hTransactionMain.Width = Unit.Pixel(1000);

            hTransactionSub.Attributes.Add("align", "left");
            hTransactionSub.Width = Unit.Pixel(1000);

            hTransactionDate.Attributes.Add("align", "left");
            hTransactionDate.Text = strTransactionDate;
            hTransactionDate.Width = Unit.Pixel(80);

            hBatchNo.Attributes.Add("align", "left");
            hBatchNo.Text = strBatchNo;
            hBatchNo.Width = Unit.Pixel(80);

            hExpiryDate.Attributes.Add("align", "left");
            hExpiryDate.Text = strExpiryDate;
            hExpiryDate.Width = Unit.Pixel(80);

            hStockReceived.Attributes.Add("align", "left");
            hStockReceived.Text = strStockRec;
            hStockReceived.Width = Unit.Pixel(80);

            hStockIssued.Attributes.Add("align", "left");
            hStockIssued.Text = strStockIssued;
            hStockIssued.Width = Unit.Pixel(80);

            hStockDamage.Attributes.Add("align", "left");
            hStockDamage.Text = strStockDamage;
            hStockDamage.Width = Unit.Pixel(80);

            hStockReturn.Attributes.Add("align", "left");
            hStockReturn.Text = strStockReturn;
            hStockReturn.Width = Unit.Pixel(80);

            hSrdNo.Attributes.Add("align", "left");
            hSrdNo.Text = strSRDNo;
            hSrdNo.Width = Unit.Pixel(120);

            hReceivedFrom.Attributes.Add("align", "left");
            hReceivedFrom.Text = strRecFrom;
            hReceivedFrom.Width = Unit.Pixel(150);

            hIssuedTo.Attributes.Add("align", "left");
            hIssuedTo.Text = strIssuedTo;
            hIssuedTo.Width = Unit.Pixel(100);

            hBillId.Attributes.Add("align", "left");
            hBillId.Text = strBillID;
            hBillId.Width = Unit.Pixel(80);
            

            hBillNo.Attributes.Add("align", "left");
            hBillNo.Text = strBillNo;
            hBillNo.Width = Unit.Pixel(120);

            hPatientName.Attributes.Add("align", "left");
            hPatientName.Text = strPatientName;
            hPatientName.Width = Unit.Pixel(120);

            hIssueLocation.Attributes.Add("align", "left");
            hIssueLocation.Text = strIssueLocation;
            hIssueLocation.Width = Unit.Pixel(120);

            hReceiveLocation.Attributes.Add("align", "left");
            hReceiveLocation.Text = strReceiveLocation;
            hReceiveLocation.Width = Unit.Pixel(120);

            hClosingBalance.Attributes.Add("align", "left");
            hClosingBalance.Text = strClosingBal;
            hClosingBalance.Width = Unit.Pixel(80);

            headRow.Cells.Add(hOpeningBalance);

            trTransactionMain.Cells.Add(hTransactionMain);
            trTransactionSub.Cells.Add(hTransactionDate);
            trTransactionSub.Cells.Add(hBatchNo);
            trTransactionSub.Cells.Add(hExpiryDate);
            trTransactionSub.Cells.Add(hStockReceived);
            trTransactionSub.Cells.Add(hStockIssued);
            trTransactionSub.Cells.Add(hStockDamage);
            trTransactionSub.Cells.Add(hStockReturn);
            trTransactionSub.Cells.Add(hSrdNo);
            trTransactionSub.Cells.Add(hReceivedFrom);
            trTransactionSub.Cells.Add(hIssuedTo);
            //trTransactionSub.Cells.Add(hBillId);
            trTransactionSub.Cells.Add(hBillNo);
            trTransactionSub.Cells.Add(hPatientName);
            trTransactionSub.Cells.Add(hIssueLocation);
            trTransactionSub.Cells.Add(hReceiveLocation); 

            tblTransactionMain.Rows.Add(trTransactionMain);
            StockReport.Rows.Add(trTransactionSub);

            trTransactionSub.Attributes.Add("class", "gridHeader");

            TranHead.Controls.Add(tblTransactionMain);
            divprnt.Controls.Add(StockReport);

            headRow.Cells.Add(TranHead);
            headRow.Cells.Add(hClosingBalance);
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 11;
            headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);

            foreach (StockMovementSummary item in lstProductLegend)
            {

                TableRow deadRow = new TableRow();
                TableCell dProductName = new TableCell();
                TableCell dDate = new TableCell();
                TableCell dOpeningBalance = new TableCell();
                TableCell dTransaction = new TableCell(); //Transaction Data Cell

                TableCell dClosingBalance = new TableCell();

                if (Request.QueryString["ProID"] == null)
                {
                    dProductName.Attributes.Add("align", "left");
                    dProductName.Text = item.ProductName;
                    dProductName.Width = Unit.Pixel(80);
                    deadRow.Cells.Add(dProductName);
                }
                if (Request.QueryString["ProID"] != null)
                {
                    dDate.Attributes.Add("align", "left");
                    dDate.Attributes.Add("valign", "top");
                    dDate.Text = item.TDate.ToString("dd/MM/yyyy");
                    dDate.Width = Unit.Pixel(100);
                    deadRow.Cells.Add(dDate);
                }
                dOpeningBalance.Attributes.Add("align", "left");
                dOpeningBalance.Attributes.Add("valign", "top");
                dOpeningBalance.Text = String.Format("{0:0}", item.OpeningBalance);
                dOpeningBalance.Width = Unit.Pixel(80);

                dTransaction.Attributes.Add("align", "left");
                dTransaction.Attributes.Add("valign", "top");
                dTransaction.Width = Unit.Pixel(1000);

                deadRow.Cells.Add(dOpeningBalance);
                var list = from rst in lstProductLegendDetail
                           where rst.TransactionDate == item.TDate
                           select rst;

                if (list.Count() > 0)
                {

                    foreach (var l in list)
                    {

                        //transations
                        Table tblTransactionData = new Table();
                        tblTransactionData.BorderWidth = 1;
                        tblTransactionData.CellSpacing = 2;
                        TableRow trTransactionData = new TableRow();

                        TableCell dTransactionDate = new TableCell();
                        TableCell dBatchNo = new TableCell();
                        TableCell dExpiryDate = new TableCell();
                        TableCell dStockReceived = new TableCell();
                        TableCell dStockIssued = new TableCell();
                        TableCell dStockDamage = new TableCell();
                        TableCell dStockReturn = new TableCell();

                        TableCell dSrdNo = new TableCell();
                        TableCell dReceivedFrom = new TableCell();
                        TableCell dIssuedTo = new TableCell();
                        TableCell dBillId = new TableCell();
                        TableCell dBillNo = new TableCell();
                        TableCell dPatientName = new TableCell();
                        TableCell dIssueLocation = new TableCell();
                        TableCell dReceiveLocation = new TableCell();

                        dTransactionDate.Attributes.Add("align", "left");
                        dTransactionDate.Text = String.Format("{0:0}", l.TransactionDate.ToString("dd/MM/yyyy"));
                        dTransactionDate.Width = Unit.Percentage(9);

                        dBatchNo.Attributes.Add("align", "left");
                        dBatchNo.Text = String.Format("{0:0}", l.BatchNo.ToString());
                        dBatchNo.Width = Unit.Percentage(9);

                        dExpiryDate.Attributes.Add("align", "left");
                        dExpiryDate.Text = String.Format("{0:0}", l.ExpiryDate.ToString());
                        dExpiryDate.Width = Unit.Percentage(10);

                        dStockReceived.Attributes.Add("align", "left");
                        dStockReceived.Text = String.Format("{0:0}", l.StockReceived);
                        dStockReceived.Width = Unit.Percentage(9);

                        dStockIssued.Attributes.Add("align", "left");
                        dStockIssued.Text = String.Format("{0:0}", l.StockIssued);
                        dStockIssued.Width = Unit.Percentage(9);

                        dStockDamage.Attributes.Add("align", "left");
                        dStockDamage.Text = String.Format("{0:0}", l.StockDamage);
                        dStockDamage.Width = Unit.Percentage(9);

                        dStockReturn.Attributes.Add("align", "left");
                        dStockReturn.Text = String.Format("{0:0}", l.StockReturn);
                        dStockReturn.Width = Unit.Percentage(9);

                        dSrdNo.Attributes.Add("align", "left");
                        dSrdNo.Text = l.SRDNo;
                        dSrdNo.Width = Unit.Percentage(9);

                        dReceivedFrom.Attributes.Add("align", "left");
                        dReceivedFrom.Text = l.ReceivedFrom;
                        dReceivedFrom.Width = Unit.Percentage(9);

                        dIssuedTo.Attributes.Add("align", "left");
                        dIssuedTo.Text = l.IssuedTo;
                        dIssuedTo.Width = Unit.Percentage(9);

                        dBillId.Attributes.Add("align", "left");
                        dBillId.Text = l.BillId.ToString();
                        dBillId.Width = Unit.Percentage(9);

                        dBillNo.Attributes.Add("align", "left");
                        dBillNo.Text = l.BillNo;
                        dBillNo.Width = Unit.Percentage(9);

                        dPatientName.Attributes.Add("align","left");
                        dPatientName.Text = l.PatientName.ToString();
                        dPatientName.Width = Unit.Percentage(9);

                        dIssueLocation.Attributes.Add("align", "left");
                        dIssueLocation.Text = l.IssueLocation.ToString();
                        dIssueLocation.Width = Unit.Percentage(9);

                        dReceiveLocation.Attributes.Add("align", "left");
                        dReceiveLocation.Text = l.ReceiveLocation.ToString();
                        //dReceiveLocation.Width = Unit.Percentage(9);
                       

                        trTransactionData.Cells.Add(dTransactionDate);
                        trTransactionData.Cells.Add(dBatchNo);
                        trTransactionData.Cells.Add(dExpiryDate);
                        trTransactionData.Cells.Add(dStockReceived);
                        trTransactionData.Cells.Add(dStockIssued);
                        trTransactionData.Cells.Add(dStockDamage);
                        trTransactionData.Cells.Add(dStockReturn);
                        trTransactionData.Cells.Add(dSrdNo);
                        trTransactionData.Cells.Add(dReceivedFrom);
                        trTransactionData.Cells.Add(dIssuedTo);
                        //trTransactionData.Cells.Add(dBillId);
                        trTransactionData.Cells.Add(dBillNo);
                        trTransactionData.Cells.Add(dPatientName);
                        trTransactionData.Cells.Add(dIssueLocation);
                        trTransactionData.Cells.Add(dReceiveLocation);

                        StockReport.Rows.Add(trTransactionData);
                        divprnt.Controls.Add(StockReport);

                    }

                }
                else
                {
                    foreach (var l in list)
                    {
                        //transations
                        Table tblTransactionData = new Table();
                        tblTransactionData.BorderWidth = 1;
                        tblTransactionData.CellSpacing = 2;
                        TableRow trTransactionData = new TableRow();

                        TableCell dTransactionDate = new TableCell();
                        TableCell dBatchNo = new TableCell();
                        TableCell dExpiryDate = new TableCell();
                        TableCell dStockReceived = new TableCell();
                        TableCell dStockIssued = new TableCell();
                        TableCell dStockDamage = new TableCell();
                        TableCell dStockReturn = new TableCell();

                        TableCell dSrdNo = new TableCell();
                        TableCell dReceivedFrom = new TableCell();
                        TableCell dIssuedTo = new TableCell();
                        TableCell dBillId = new TableCell();
                        TableCell dBillNo = new TableCell();
                        TableCell dPatientName = new TableCell();
                        TableCell dIssueLocation = new TableCell();
                        TableCell dReceiveLocation = new TableCell();

                        dTransactionDate.Attributes.Add("align", "left");
                        dTransactionDate.Text = String.Format("{0:0}", l.TransactionDate.ToString("dd/MM/yyyy"));
                        dTransactionDate.Width = Unit.Percentage(9);

                        dBatchNo.Attributes.Add("align", "left");
                        dBatchNo.Text = String.Format("{0:0}", l.BatchNo.ToString());
                        dBatchNo.Width = Unit.Percentage(9);

                        dExpiryDate.Attributes.Add("align", "left");
                        dExpiryDate.Text = String.Format("{0:0}", l.ExpiryDate.ToString());
                        dExpiryDate.Width = Unit.Percentage(10);

                        dStockReceived.Attributes.Add("align", "left");
                        dStockReceived.Text = String.Format("{0:0}", 0);
                        dStockReceived.Width = Unit.Percentage(9);

                        dStockIssued.Attributes.Add("align", "left");
                        dStockIssued.Text = String.Format("{0:0}", 0);
                        dStockIssued.Width = Unit.Percentage(9);

                        dStockDamage.Attributes.Add("align", "left");
                        dStockDamage.Text = String.Format("{0:0}", 0);
                        dStockDamage.Width = Unit.Percentage(9);

                        dStockReturn.Attributes.Add("align", "left");
                        dStockReturn.Text = String.Format("{0:0}", 0);
                        dStockReturn.Width = Unit.Percentage(9);

                        dSrdNo.Attributes.Add("align", "left");
                        dSrdNo.Text = l.SRDNo;
                        dSrdNo.Width = Unit.Percentage(9);

                        dReceivedFrom.Attributes.Add("align", "left");
                        dReceivedFrom.Text = l.ReceivedFrom;
                        dReceivedFrom.Width = Unit.Percentage(9);

                        dIssuedTo.Attributes.Add("align", "left");
                        dIssuedTo.Text = l.IssuedTo;
                        dIssuedTo.Width = Unit.Percentage(9);

                        dBillId.Attributes.Add("align", "left");
                        dBillId.Text = l.BillNo;
                        dBillId.Width = Unit.Percentage(9);

                        dBillNo.Attributes.Add("align", "left");
                        dBillNo.Text = l.BillNo;
                        dBillNo.Width = Unit.Percentage(9);

                        dPatientName.Attributes.Add("align", "left");
                        dPatientName.Text = l.PatientName.ToString();
                        dPatientName.Width = Unit.Percentage(9);


                        dIssueLocation.Attributes.Add("align", "left");
                        dIssueLocation.Text = l.IssueLocation.ToString();
                        dIssueLocation.Width = Unit.Percentage(9);

                        dReceiveLocation.Attributes.Add("align", "left");
                        dReceiveLocation.Text = l.ReceiveLocation.ToString();
                        //  dReceiveLocation.Width = Unit.Percentage(10);

                        trTransactionData.Cells.Add(dTransactionDate);
                        trTransactionData.Cells.Add(dBatchNo);
                        trTransactionData.Cells.Add(dExpiryDate);
                        trTransactionData.Cells.Add(dStockReceived);
                        trTransactionData.Cells.Add(dStockIssued);
                        trTransactionData.Cells.Add(dStockDamage);
                        trTransactionData.Cells.Add(dStockReturn);
                        trTransactionData.Cells.Add(dSrdNo);
                        trTransactionData.Cells.Add(dReceivedFrom);
                        trTransactionData.Cells.Add(dIssuedTo);
                        //trTransactionData.Cells.Add(dBillId);
                        trTransactionData.Cells.Add(dBillNo);
                        trTransactionData.Cells.Add(dPatientName);
                        trTransactionData.Cells.Add(dIssueLocation);
                        trTransactionData.Cells.Add(dReceiveLocation);

                        //tblTransactionData.Rows.Add(trTransactionData);
                        //dTransaction.Controls.Add(tblTransactionData);
                        StockReport.Rows.Add(trTransactionData);
                        divprnt.Controls.Add(StockReport);
                    }
                }

                dClosingBalance.Attributes.Add("align", "left");
                dClosingBalance.Attributes.Add("valign", "bottom");
                dClosingBalance.Text = String.Format("{0:0}", item.ClosingBalance);
                dClosingBalance.Width = Unit.Pixel(80);

                deadRow.Cells.Add(dTransaction);
                deadRow.Cells.Add(dClosingBalance);
                DataHeaders.Rows.Add(deadRow);
            }
        }
        
    }
}
