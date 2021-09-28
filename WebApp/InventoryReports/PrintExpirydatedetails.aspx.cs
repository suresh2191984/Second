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

public partial class InventoryReports_PrintExpirydatedetails : Attune_BasePage
{
    public InventoryReports_PrintExpirydatedetails()
        : base("InventoryReports_PrintExpirydatedetails_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    Products objProducts = new Products();
    List<InventoryItemsBasket> lstItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();

    InventoryCommon_BL inventoryBL;
    long returnCode = -1;
    string strExpDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_01 == null ? "Expiry date Report From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_01;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_02 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_02;
    string strEReport = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_03 == null ? "EXPIRY DATE REPORT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_03;
    string strProduct = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_04 == null ? "Product" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_04;
    string strDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_05 == null ? "Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_05;
    string strBatchNo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_06 == null ? "BatchNo" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_06;
    string strStockReceived = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_07 == null ? "StockReceived" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_07;
    string strStockInhand = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_08 == null ? "StockInhand" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_08;
    string strSellingPrice = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_09 == null ? "SellingPrice" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_09;
    string strReorderLevel = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_10 == null ? "ReorderLevel" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_10;
    string strUnits = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_11 == null ? "Units" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintExpirydatedetails_aspx_11;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!Page.IsPostBack)
        {
            try
            {
                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                
                if (Request.QueryString["dFrom"] != null)
                {
                    fromToStockReport.Text = strExpDate + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                    new InventoryReports_BL(base.ContextInfo).GetExpiredatedetails(fromDate, toDate,Request.QueryString["pName"], OrgID, ILocationID, InventoryLocationID, out lstItemsBasket);
                }

                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                cHeaderStockReport.Text = strEReport;
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                LoadHeaders(lstItemsBasket);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in PrintDispensingReport.aspx", ex);
            }
        }
    }

    private void LoadHeaders(List<InventoryItemsBasket> lstInvBasket)
    {

        if (lstInvBasket.Count() > 0)
        {
            TableRow headRow = new TableRow();
            TableCell hProductName = new TableCell();
            TableCell hExpDate = new TableCell();
            TableCell hBatchNo = new TableCell();
            TableCell hStockReceived = new TableCell();
            TableCell hStockInhand = new TableCell();
            TableCell hUnits = new TableCell();
            TableCell hSellingPrice = new TableCell();
            TableCell hReorderLevel = new TableCell();
            
       
            hProductName.Attributes.Add("align", "left");
            hProductName.Text = strProduct;
            hProductName.Width = Unit.Percentage(20);
            headRow.Cells.Add(hProductName);
        
            hExpDate.Attributes.Add("align", "left");
            hExpDate.Text = strDate;
            hExpDate.Width = Unit.Percentage(10);
            headRow.Cells.Add(hExpDate);

            hBatchNo.Attributes.Add("align", "left");
            hBatchNo.Text = strBatchNo;
            hBatchNo.Width = Unit.Percentage(8);

            hStockReceived.Attributes.Add("align", "left");
            hStockReceived.Text = strStockReceived;
            hStockReceived.Width = Unit.Percentage(8);

            hStockInhand.Attributes.Add("align", "left");
            hStockInhand.Text = strStockInhand;
            hStockInhand.Width = Unit.Percentage(8);


            hSellingPrice.Attributes.Add("align", "left");
            hSellingPrice.Text = strSellingPrice;
            hSellingPrice.Width = Unit.Percentage(8);

            hReorderLevel.Attributes.Add("align", "left");
            hReorderLevel.Text = strReorderLevel;
            hReorderLevel.Width = Unit.Percentage(13);

            hUnits.Attributes.Add("align", "left");
            hUnits.Text = strUnits;
            hUnits.Width = Unit.Percentage(8);
            headRow.Cells.Add(hProductName);
            headRow.Cells.Add(hBatchNo);
            headRow.Cells.Add(hExpDate);
            headRow.Cells.Add(hStockReceived);
            headRow.Cells.Add(hStockInhand);
            headRow.Cells.Add(hSellingPrice);
            headRow.Cells.Add(hUnits);
            DataHeaders.Rows.Add(headRow);

            TableRow headLine2Row = new TableRow();
            TableCell headLineCell2 = new TableCell();
            headLineCell2.ColumnSpan = 11;
            headLineCell2.Text = "<img src='../Images/px.jpg'/>";
            headLine2Row.Cells.Add(headLineCell2);
            DataHeaders.Rows.Add(headLine2Row);
            foreach (InventoryItemsBasket item in lstInvBasket)
            {
                TableRow deadRow = new TableRow();
                TableCell cProductName = new TableCell();
                TableCell cExpDate = new TableCell();
                TableCell cBatchNo = new TableCell();
                TableCell cStockReceived = new TableCell();
                TableCell cStockInhand = new TableCell();
                TableCell cUnits = new TableCell();
                TableCell cSellingPrice = new TableCell();
                TableCell cReorderLevel = new TableCell();
                    cProductName.Attributes.Add("align", "left");
                    cProductName.Text = item.ProductName;
                    cProductName.Width = Unit.Percentage(8);
                    deadRow.Cells.Add(cProductName);
                
                    cExpDate.Attributes.Add("align", "left");
                    cExpDate.Text = item.ExpiryDate.ToString("MMM/yyyy");
                    cExpDate.Width = Unit.Percentage(10);
                    deadRow.Cells.Add(cExpDate);
                    cBatchNo.Attributes.Add("align", "left");
                    cBatchNo.Text =item.BatchNo;
                    cBatchNo.Width = Unit.Percentage(8);
                    cStockReceived.Attributes.Add("align", "left");
                    cStockReceived.Text = String.Format("{0:0}", item.RECQuantity);
                    cStockReceived.Width = Unit.Percentage(8);
                    cStockInhand.Attributes.Add("align", "left");
                    cStockInhand.Text = String.Format("{0:0}", item.InHandQuantity);
                    cStockInhand.Width = Unit.Percentage(8);
                    cSellingPrice.Attributes.Add("align", "left");
                    cSellingPrice.Text = String.Format("{0:0}", item.Rate);
                    cSellingPrice.Width = Unit.Percentage(8);
                    cReorderLevel.Attributes.Add("align", "left");
                    cReorderLevel.Text = String.Format("{0:0}", item.Quantity);
                    cReorderLevel.Width = Unit.Percentage(8);

               
                cUnits.Attributes.Add("align", "left");
                cUnits.Text = item.RECUnit;
                cUnits.Width = Unit.Percentage(8);
                deadRow.Cells.Add(cProductName);
                deadRow.Cells.Add(cBatchNo);
                deadRow.Cells.Add(cExpDate);
                deadRow.Cells.Add(cStockReceived);
                deadRow.Cells.Add(cStockInhand);
                deadRow.Cells.Add(cSellingPrice);
                deadRow.Cells.Add(cUnits);
                DataHeaders.Rows.Add(deadRow);

            }
        }
    }
}
