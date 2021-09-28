using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PrintSalesTaxReport : Attune_BasePage
{
    public InventoryReports_PrintSalesTaxReport()
        : base("InventoryReports_PrintSalesTaxReport_aspx")
    {
    }
    DateTime fromDate;
    DateTime toDate;
    Int32 LocId = 0;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    List<FinalBill> lstSalesReport = new List<FinalBill>();
    List<FinalBill> lstSalesDetail = new List<FinalBill>();
    InventoryCommon_BL inventoryBL ;
    long returnCode = -1;
    string strSalesFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_01 == null ? "Sales Tax Report From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_01;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_02 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_02;
    string strSReport = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_03 == null ? "SALES TAX REPORT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_03;
    string strBillDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_04 == null ? "Bill Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_04;
    string strBillNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_05 == null ? "Bill No" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_05;
    string strGrossTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_06 == null ? "Gross Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_06;
    string strNetTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_07 == null ? "Net Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_07;
    string strTax4 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_08 == null ? "4% Taxable" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_08;
    string strVat4 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_09 == null ? "Vat (4%)" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_09;
    string strTax12 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_10 == null ? "12.5% Taxable" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_10;
    string strVat12 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_11 == null ? "Vat (12.5%)" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_11;
    string strTax0 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_12 == null ? "0% Taxable" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_12;
    string strVat0 = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_13 == null ? "Vat (0%)" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_13;
    string strGrandTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_14 == null ? "Grand Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintSalesTaxReport_aspx_14;

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



                fromToStockReport.Text = strSalesFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");

                new InventoryReports_BL(this.ContextInfo).GetSalesTaxReport(fromDate, toDate, LocId, OrgID, ILocationID, out lstSalesReport, out lstSalesDetail);

                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderStockReport.Text = strSReport;
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                LoadSalesTaxReportHeaders(lstSalesReport);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Print SalesTaxReport.aspx", ex);
            }
        }
    }

    private void LoadSalesTaxReportHeaders(List<FinalBill> lstSalesReport)
    {
        decimal net = 0;
        decimal grand = 0;
        decimal Taxable4 = 0;
        decimal vat4 = 0;
        decimal Taxable12 = 0;
        decimal vat12 = 0;
        decimal Taxable0 = 0;
        decimal vat0 = 0;  
        long returncode = -1;


        if (lstSalesReport.Count() > 0)
        {
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();

            TableCell hBillDate = new TableCell();
            TableCell hBillNo = new TableCell();
            TableCell hGrand = new TableCell();
            TableCell hNetValue = new TableCell();
            TableCell hTaxable4 = new TableCell();
            TableCell hvat4 = new TableCell();
            TableCell hTaxable12 = new TableCell();
            TableCell hvat12 = new TableCell();
            TableCell hTaxable0 = new TableCell();
            TableCell hvat0 = new TableCell();

            hBillDate.Attributes.Add("align", "right");
            hBillDate.Text = strBillDate;
            hBillDate.Width = Unit.Percentage(8);

            hBillNo.Attributes.Add("align", "right");
            hBillNo.Text = strBillNo;
            hBillNo.Width = Unit.Percentage(8);

            hGrand.Attributes.Add("align", "right");
            hGrand.Text = strGrossTotal;
            hGrand.Width = Unit.Percentage(8);

            hNetValue.Attributes.Add("align", "right");
            hNetValue.Text = strNetTotal;
            hNetValue.Width = Unit.Percentage(8);

            hTaxable4.Attributes.Add("align", "right");
            hTaxable4.Text = strTax4;
            hTaxable4.Width = Unit.Percentage(8);

            hvat4.Attributes.Add("align", "right");
            hvat4.Text = strVat4;
            hvat4.Width = Unit.Percentage(8);


            hTaxable12.Attributes.Add("align", "right");
            hTaxable12.Text = strTax12;
            hTaxable12.Width = Unit.Percentage(8);

            hvat12.Attributes.Add("align", "right");
            hvat12.Text = strVat12;
            hvat12.Width = Unit.Percentage(8);

            hTaxable0.Attributes.Add("align", "right");
            hTaxable0.Text = strTax0;
            hTaxable0.Width = Unit.Percentage(8);

            hvat0.Attributes.Add("align", "right");
            hvat0.Text = strVat0;
            hvat0.Width = Unit.Percentage(8);

            headRow.Cells.Add(hBillDate);
            headRow.Cells.Add(hBillNo);
            headRow.Cells.Add(hGrand);
            headRow.Cells.Add(hNetValue);
            headRow.Cells.Add(hTaxable4);
            headRow.Cells.Add(hvat4);
            headRow.Cells.Add(hTaxable12);
            headRow.Cells.Add(hvat12);
            headRow.Cells.Add(hTaxable0);
            headRow.Cells.Add(hvat0);
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 11;
            headLineCell2.Text = "<hr/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);


            foreach (FinalBill item in lstSalesReport)
            {
                //nrr
                VisitClientMapping VisitClientMapping = new VisitClientMapping();
                TableRow deadRow = new TableRow();

                TableCell dBillDate = new TableCell();
                TableCell dBillNo = new TableCell();
                TableCell dGrand = new TableCell();
                TableCell dNetValue = new TableCell();

                TableCell dTaxable4 = new TableCell();
                TableCell dvat4 = new TableCell();
                TableCell dTaxable12 = new TableCell();
                TableCell dvat12 = new TableCell();
                TableCell dTaxable0 = new TableCell();
                TableCell dvat0 = new TableCell();


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

                dTaxable4.Attributes.Add("align", "right");

                dTaxable4.Text = VisitClientMapping.PreAuthAmount.ToString();
                dTaxable4.Width = Unit.Percentage(8);
                Taxable4 += VisitClientMapping.PreAuthAmount;

                dvat4.Attributes.Add("align", "right");
                dvat4.Text = item.AdvanceRecieved.ToString();
                dvat4.Width = Unit.Percentage(8);
                vat4 += item.AdvanceRecieved;

                dTaxable12.Attributes.Add("align", "right");
                dTaxable12.Text = item.TPAAmount.ToString();
                dTaxable12.Width = Unit.Percentage(8);
                Taxable12 += item.TPAAmount;

                dvat12.Attributes.Add("align", "right");
                dvat12.Text = item.AmountReceived.ToString();
                dvat12.Width = Unit.Percentage(8);
                vat12 += item.AmountReceived;

                dTaxable0.Attributes.Add("align", "right");
                dTaxable0.Text = item.DueStamp.ToString();
                dTaxable0.Width = Unit.Percentage(8);
                Taxable0 += item.DueStamp;

                dvat0.Attributes.Add("align", "right");
                dvat0.Text = item.AmountRefund.ToString();
                dvat0.Width = Unit.Percentage(8);
                vat0 += item.AmountRefund;


                deadRow.Cells.Add(dBillDate);
                deadRow.Cells.Add(dBillNo);
                deadRow.Cells.Add(dGrand);
                deadRow.Cells.Add(dNetValue);
                deadRow.Cells.Add(dTaxable4);
                deadRow.Cells.Add(dvat4);
                deadRow.Cells.Add(dTaxable12);
                deadRow.Cells.Add(dvat12);
                deadRow.Cells.Add(dTaxable0);
                deadRow.Cells.Add(dvat0);
                DataHeaders.Rows.Add(deadRow);

            }


            TableCell fBillDate = new TableCell();
            TableCell fBillNo = new TableCell();
            TableCell fGrand = new TableCell();
            TableCell fNetValue = new TableCell();


            TableCell fTaxable4 = new TableCell();
            TableCell fvat4 = new TableCell();
            TableCell fTaxable12 = new TableCell();
            TableCell fvat12 = new TableCell();
            TableCell fTaxable0 = new TableCell();
            TableCell fvat0 = new TableCell();

            TableRow footLineRow = new TableRow();
            TableCell footLineCell = new TableCell();
            footLineCell.ColumnSpan = 11;
            footLineCell.Text = "<hr/>";
            footLineRow.Cells.Add(footLineCell);
            DataHeaders.Rows.Add(footLineRow);

            fBillDate.Attributes.Add("align", "right");
            fBillDate.Text = "";
            fBillDate.Width = Unit.Percentage(8);



            fBillNo.Attributes.Add("align", "right");
            fBillNo.Text = strGrandTotal;
            fBillNo.Width = Unit.Percentage(8);


            fGrand.Attributes.Add("align", "right");
            //fGrand.Text = grand.ToString();
            fGrand.Text = String.Format("{0:f}", grand);
            fGrand.Width = Unit.Percentage(8);

            fNetValue.Attributes.Add("align", "right");
            fNetValue.Text = String.Format("{0:f}", net);
            fNetValue.Width = Unit.Percentage(8);

            fTaxable4.Attributes.Add("align", "right");
            fTaxable4.Text = String.Format("{0:f}", Taxable4);
            fTaxable4.Width = Unit.Percentage(8);

            fvat4.Attributes.Add("align", "right");
            fvat4.Text = String.Format("{0:f}", vat4);
            fvat4.Width = Unit.Percentage(8);

            fTaxable12.Attributes.Add("align", "right");
            fTaxable12.Text = String.Format("{0:f}", Taxable12);
            fTaxable12.Width = Unit.Percentage(8);

            fvat12.Attributes.Add("align", "right");
            fvat12.Text = String.Format("{0:f}", vat12);
            fvat12.Width = Unit.Percentage(8);

            fTaxable0.Attributes.Add("align", "right");
            fTaxable0.Text = String.Format("{0:f}", Taxable0);
            fTaxable0.Width = Unit.Percentage(8);

            fvat0.Attributes.Add("align", "right");
            fvat0.Text = String.Format("{0:f}", vat0);
            fvat0.Width = Unit.Percentage(8);



            footRow.Cells.Add(fBillDate);
            footRow.Cells.Add(fBillNo);
            footRow.Cells.Add(fGrand);
            footRow.Cells.Add(fNetValue);
            footRow.Cells.Add(fTaxable4);
            footRow.Cells.Add(fvat4);
            footRow.Cells.Add(fTaxable12);
            footRow.Cells.Add(fvat12);
            footRow.Cells.Add(fTaxable0);
            footRow.Cells.Add(fvat0);
            
            DataHeaders.Rows.Add(footRow);
        }
    }
}
