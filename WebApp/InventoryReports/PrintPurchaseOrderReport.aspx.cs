using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PrintPurchaseOrderReport : Attune_BasePage
{
    public InventoryReports_PrintPurchaseOrderReport()
        : base("InventoryReports_PrintPurchaseOrderReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    Int32 LocId = 0;
    string SupName="";
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    PurchaseOrders objPurchaseOrders = new PurchaseOrders();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    InventoryCommon_BL inventoryBL;
    long returnCode = -1;
    string strPurFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_01 == null ? "Purchase Order Report From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_01;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_02 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_02;
    string strPREPORT = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_03 == null ? "PURCHASE ORDER REPORT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_03;
    string strSupName = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_04 == null ? "Supplier Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_04;
    string strPurDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_05 == null ? "Purchase Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_05;
    string strInvoiceNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_06 == null ? "Invoice/DC No" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_06;
    string strTINNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_07 == null ? "TIN No" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_07;
    string strGrossTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_08 == null ? "Gross Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_08;
    string strGrandTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_09 == null ? "Grand Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_09;
    string strVAT = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_10 == null ? "VAT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintPurchaseOrderReport_aspx_10;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!Page.IsPostBack)
        {
            try
            {
                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                Int32.TryParse(Request.QueryString["Loc"], out LocId);
                SupName= Convert.ToString(Request.QueryString["Sup"]);

                objPurchaseOrders.BranchID = LocId;
                objPurchaseOrders.OrgID = OrgID;
                objPurchaseOrders.OrgAddressID = ILocationID;
                fromToStockReport.Text = strPurFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                new InventoryReports_BL(this.ContextInfo).GetPurchaseOrderReport(fromDate,toDate, objPurchaseOrders.BranchID, objPurchaseOrders.OrgID, objPurchaseOrders.OrgAddressID,"N",SupName, out lstPurchaseOrders);
                
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderStockReport.Text = strPREPORT;
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                LoadDispensingReportHeaders(lstPurchaseOrders);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Print PurchaseOrderReport.aspx", ex);
            }
        }
    }

    private void LoadDispensingReportHeaders(List<PurchaseOrders> lstPurchaseOrders)
    {
        double gross = 0;
        double grand = 0;
        double vat = 0;

        if (lstPurchaseOrders.Count() > 0)
        {
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();
            
            TableCell hSupplierName = new TableCell();
            TableCell hPurchaseDate = new TableCell();
            TableCell hInvoice = new TableCell();
            TableCell hTin = new TableCell();
            TableCell hGross = new TableCell();
            TableCell hGrand = new TableCell();
            TableCell hVat = new TableCell();
            
       
            hSupplierName.Attributes.Add("align", "left");
            hSupplierName.Text = strSupName;
            hSupplierName.Width = Unit.Percentage(20);
            
        
        
            hPurchaseDate.Attributes.Add("align", "left");
            hPurchaseDate.Text = strPurDate;
            hPurchaseDate.Width = Unit.Percentage(10);
            
            
            hInvoice.Attributes.Add("align", "left");
            hInvoice.Text = strInvoiceNo;
            hInvoice.Width = Unit.Percentage(8);

            hTin.Attributes.Add("align", "left");
            hTin.Text = strTINNo;
            hTin.Width = Unit.Percentage(8);

            hGross.Attributes.Add("align", "left");
            hGross.Text = strGrossTotal;
            hGross.Width = Unit.Percentage(8);

            hGrand.Attributes.Add("align", "left");
            hGrand.Text = strGrandTotal;
            hGrand.Width = Unit.Percentage(8);

            hVat.Attributes.Add("align", "left");
            hVat.Text = strVAT;
            hVat.Width = Unit.Percentage(8);

            headRow.Cells.Add(hPurchaseDate);
            headRow.Cells.Add(hSupplierName);
            headRow.Cells.Add(hInvoice);
            headRow.Cells.Add(hTin);
            headRow.Cells.Add(hGross);
            headRow.Cells.Add(hGrand);
            headRow.Cells.Add(hVat);
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 11;
            headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);


            foreach (PurchaseOrders item in lstPurchaseOrders)
            {
                TableRow deadRow = new TableRow();

                TableCell dSupplierName = new TableCell();
                TableCell dPurchaseDate = new TableCell();
                TableCell dInvoice = new TableCell();
                TableCell dTin = new TableCell();
                TableCell dGross = new TableCell();
                TableCell dGrand = new TableCell();
                TableCell dVat4 = new TableCell();
                TableCell dVat12 = new TableCell();
                TableCell dVat0 = new TableCell();
                TableCell dVatots = new TableCell();
                

                dSupplierName.Attributes.Add("align", "left");
                dSupplierName.Text = item.SupplierName;
                dSupplierName.Width = Unit.Percentage(8);
                deadRow.Cells.Add(dSupplierName);
            
                dPurchaseDate.Attributes.Add("align", "left");
                dPurchaseDate.Text = item.PurchaseOrderDate.ToString("dd/MMM/yyyy");
                dPurchaseDate.Width = Unit.Percentage(10);
                deadRow.Cells.Add(dPurchaseDate);
           
                dInvoice.Attributes.Add("align", "left");
                dInvoice.Text =  item.InvoiceNo.ToString();
                dInvoice.Width = Unit.Percentage(8);

                dTin.Attributes.Add("align", "left");
                if (item.TinNo==null)
                {
                    dTin.Text = "--";
                }
                else
                {
                    dTin.Text = item.TinNo;
                }
                dTin.Width = Unit.Percentage(8);

                dGross.Attributes.Add("align", "left");
                dGross.Text = item.NetValue.ToString();
                dGross.Width = Unit.Percentage(8);
                gross += (double)item.NetValue;

                dGrand.Attributes.Add("align", "left");
                dGrand.Text = item.GrandTotal.ToString();
                dGrand.Width = Unit.Percentage(8);
                grand += (double)item.GrandTotal;

                dVat4.Attributes.Add("align", "left");
                dVat4.Text = item.TaxAmount4.ToString();
                dVat4.Width = Unit.Percentage(8);
                vat += (double)item.TaxAmount4;

                dVat12.Attributes.Add("align", "left");
                dVat12.Text = item.TaxAmount12.ToString();
                dVat12.Width = Unit.Percentage(8);
                vat += (double)item.TaxAmount12;

                dVatots.Attributes.Add("align", "left");
                dVatots.Text = item.TaxAmount0.ToString();
                dVatots.Width = Unit.Percentage(8);
                vat += (double)item.TaxAmount0;

                dVatots.Attributes.Add("align", "left");
                dVatots.Text = item.TaxAmount4.ToString();
                dVatots.Width = Unit.Percentage(8);
                vat += (double)item.TaxAmount4;

                deadRow.Cells.Add(dPurchaseDate);
                deadRow.Cells.Add(dSupplierName);
                deadRow.Cells.Add(dInvoice);
                deadRow.Cells.Add(dTin);
                deadRow.Cells.Add(dGross);
                deadRow.Cells.Add(dGrand);
                deadRow.Cells.Add(dVat4);
                DataHeaders.Rows.Add(deadRow);

            }


            TableCell fSupplierName = new TableCell();
            TableCell fPurchaseDate = new TableCell();
            TableCell fInvoice = new TableCell();
            TableCell fTin = new TableCell();
            TableCell fGross = new TableCell();
            TableCell fGrand = new TableCell();
            TableCell fVat = new TableCell();

            TableRow footLineRow = new TableRow();
            TableCell footLineCell = new TableCell();
            footLineCell.ColumnSpan = 11;
            footLineCell.Text = "<hr/>";
            footLineRow.Cells.Add(footLineCell);
            DataHeaders.Rows.Add(footLineRow);

            fSupplierName.Attributes.Add("align", "left");
            fSupplierName.Text = strGrandTotal;
            fSupplierName.Width = Unit.Percentage(20);



            fPurchaseDate.Attributes.Add("align", "left");
            fPurchaseDate.Text = "";
            fPurchaseDate.Width = Unit.Percentage(10);


            fInvoice.Attributes.Add("align", "left");
            fInvoice.Text = "";
            fInvoice.Width = Unit.Percentage(8);

            fTin.Attributes.Add("align", "left");
            fTin.Text = "";
            fTin.Width = Unit.Percentage(8);

            fGross.Attributes.Add("align", "left");
            fGross.Text =  gross.ToString();
            fGross.Width = Unit.Percentage(8);

            fGrand.Attributes.Add("align", "left");
            fGrand.Text =  grand.ToString();
            fGrand.Width = Unit.Percentage(8);

            fVat.Attributes.Add("align", "left");
            fVat.Text =  vat.ToString();
            fVat.Width = Unit.Percentage(8);

            footRow.Cells.Add(fPurchaseDate);
            footRow.Cells.Add(fSupplierName);
            footRow.Cells.Add(fInvoice);
            footRow.Cells.Add(fTin);
            footRow.Cells.Add(fGross);
            footRow.Cells.Add(fGrand);
            footRow.Cells.Add(fVat);
            DataHeaders.Rows.Add(footRow);

            

        }
    }
}
