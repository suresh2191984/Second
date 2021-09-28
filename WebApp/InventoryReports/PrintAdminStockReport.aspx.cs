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

public partial class InventoryReports_PrintAdminStockReport : Attune_BasePage
{
    public InventoryReports_PrintAdminStockReport()
        : base("InventoryReports_PrintAdminStockReport_aspx")
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
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<ProductCategories> lstCategories = new List<ProductCategories>();
    List<Locations> lstLocation = new List<Locations>();

    InventoryCommon_BL inventoryBL;
    long returnCode = -1;
    long ProductId = 0;
    string ProductName = "";
    int Lid = 0;
    int Cid = 0;
    string sType = "N";
    string strStock = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_01 == null ? "Stock Report For" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_01;
    string strFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_02 == null ? "From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_02;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_03 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_03;
    string strSReport = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_04 == null ? "STOCK REPORT" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_04;

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
                Int32.TryParse(Request.QueryString["Lid"], out Lid);
                Int32.TryParse(Request.QueryString["Cid"], out Cid);

                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
                lstProductCategories = Session["lstProductCategories"] as List<ProductCategories>;

                if (lstProductCategories == null)
                {
                    lstProductCategories = new List<ProductCategories>();
                }
                else if (lstProductCategories.Count > 0)
                {
                    lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID == 0);

                    if (lstProductCategories_all.Count > 0)
                    {
                        lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID == 0);
                    }
                }

                sType = Request.QueryString["SType"].ToString();
                if (Request.QueryString["ProID"] == null)
                {
                    trstockreport.Visible = false;
                    trhr.Visible = false;
                    ProductName = Request.QueryString["pName"].ToString();

                    new InventoryReports_BL(base.ContextInfo).GetStockMovement(fromDate, toDate, OrgID, ILocationID, Lid, ProductName, 0, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);

                    if (Request.QueryString["isNil"] == "Y")
                    {
                        lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
                    }
                }

                if (Request.QueryString["ProID"] != null)
                {
                    //INT ISeXP =2   -Non-Expired,
                    int IseXP = 2;
                    trstockreport.Visible = true;
                    new InventoryReports_BL(base.ContextInfo).GetStockMovementByProduct(fromDate, toDate, OrgID, ILocationID, Lid, ProductId, out lstStockMovement, out lstCategories,
                        out lstLocation, "Details", IseXP);
                    if (lstStockMovement.Count > 0)
                    {
                        ProductName = lstStockMovement.Find(p => p.ProductID == ProductId).ProductName;
                    }
                    DefromToStockReport.Text = strStock + " " + ProductName.ToUpper() + " " + strFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");

                }



                long lresult = new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                DecHeaderStockReport.Text = strSReport;
                DeorgName.Text = lstOrganization[0].Name;
                DeorgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                LoadReportHeaders(lstStockMovement);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in PrintStockReport.aspx", ex);
            }
        }
    }
    string strSReportFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_05 == null ? "Stock Report From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_05;
    string strProduct = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_06 == null ? "Product" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_06;
    string strDate = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_07 == null ? "Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_07;
    string strOpeningBalance = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_08 == null ? "Opening Balance" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_08;
    string strStockReceived = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_09 == null ? "Stock Received" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_09;
    string strStockIssued = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_10 == null ? "Stock Issued" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_10;
    string strStockDamage = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_11 == null ? "Stock Damage" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_11;
    string strStockReturn = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_12 == null ? "Stock Return" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_12;
    string strClosingBalance = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_13 == null ? "Closing Balance" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_13;
    string strCurrentSellingPrice = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_14 == null ? "Current SellingPrice" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_14;
    string strOpenStockValue = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_15 == null ? "Opening Stock Value" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_15;
    string strCloseStockValue = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_16 == null ? "Closing Stock Value" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_16;
    string strUnits = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_17 == null ? "Units" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_17;
    string strNoMatch = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_18 == null ? "No Matching Records Found!" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_18;
    string strLocation = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_19 == null ? "Location" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintAdminStockReport_aspx_19;

    private void LoadReportHeaders(List<StockMovementSummary> lstStockMovement)
    {
        ////////////////////////////////////--Grouping--////////////////////////////////
        if (sType == "Y")
        {
            string lName = "";
            foreach (Locations item in lstLocation)
            {
                lName += item.LocationName + ",";
            }
            Locations loc = new Locations();
            loc.LocationName = lName.TrimEnd(',');
            lstLocation.RemoveAll(p => p.LocationID != 0);
            lstLocation.Add(loc);
        }
        foreach (Locations litem in lstLocation)
        {

            List<ProductCategories> lstTempCategories = new List<ProductCategories>();
            lstTempCategories = lstCategories.FindAll(p => p.DeptID == litem.LocationID);
            List<StockMovementSummary> lsttemp = new List<StockMovementSummary>();

            TableRow dRowLocation = new TableRow();
            TableCell lLocName = new TableCell();
            lLocName.ColumnSpan = 11;
            lLocName.Attributes.Add("align", "left");
            if (Request.QueryString["ProID"] == null)
            {
                lLocName.Text = litem.LocationName + strSReportFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");
                //Stock Report For " + ProductName.ToUpper() +
            }
            if (Request.QueryString["ProID"] != null)
            {
                lLocName.Text = strLocation + " " + litem.LocationName + "</br> ";// +strStock + " " + ProductName.ToUpper() + " " + strFrom + " " + fromDate.ToString("dd/MM/yyyy") + " " + strTo + " " + toDate.ToString("dd/MM/yyyy");
            }
            lLocName.Width = Unit.Percentage(20);
            dRowLocation.Cells.Add(lLocName);
            dRowLocation.Style.Add("font-weight", "bold");
            dRowLocation.Style.Add("font-size", "18px");
            DeDataHeaders.Rows.Add(dRowLocation);


            TableRow rlocLine = new TableRow();
            TableCell clocCell = new TableCell();
            clocCell.ColumnSpan = 11;
            clocCell.Text = "<hr/>";
            rlocLine.Cells.Add(clocCell);
            DeDataHeaders.Rows.Add(rlocLine);




            TableRow dheadRow = new TableRow();
            TableCell dhProductName = new TableCell();
            TableCell dhDate = new TableCell();
            TableCell dhOpeningBalance = new TableCell();
            TableCell dhStockReceived = new TableCell();
            TableCell dhStockIssued = new TableCell();
            TableCell dhStockDamage = new TableCell();
            TableCell dhStockReturn = new TableCell();
            TableCell dhClosingBalance = new TableCell();
            TableCell dhCurrentSellingPrice = new TableCell();
            TableCell dhOpeningStockValue = new TableCell();
            TableCell dhClosingStockValue = new TableCell();
            TableCell dhUnits = new TableCell();

            
            if (Request.QueryString["ProID"] == null)
            {
                dhProductName.Attributes.Add("align", "center");
                dhProductName.Text = strProduct;
                dhProductName.Width = Unit.Percentage(20);
                dheadRow.Cells.Add(dhProductName);
            }
            if (Request.QueryString["ProID"] != null)
            {
                dhDate.Attributes.Add("align", "left");
                dhDate.Text = strDate;
                dhDate.Width = Unit.Percentage(10);
                dheadRow.Cells.Add(dhDate);
            }
            dhOpeningBalance.Attributes.Add("align", "right");
            dhOpeningBalance.Text = strOpeningBalance;
            dhOpeningBalance.Width = Unit.Percentage(8);


            dhStockReceived.Attributes.Add("align", "right");
            dhStockReceived.Text = strStockReceived;
            dhStockReceived.Width = Unit.Percentage(8);

            dhStockIssued.Attributes.Add("align", "right");
            dhStockIssued.Text = strStockIssued;
            dhStockIssued.Width = Unit.Percentage(8);

            dhStockDamage.Attributes.Add("align", "right");
            dhStockDamage.Text = strStockDamage;
            dhStockDamage.Width = Unit.Percentage(8);

            dhStockReturn.Attributes.Add("align", "right");
            dhStockReturn.Text = strStockReturn;
            dhStockReturn.Width = Unit.Percentage(8);

            dhClosingBalance.Attributes.Add("align", "right");
            dhClosingBalance.Text = strClosingBalance;
            dhClosingBalance.Width = Unit.Percentage(8);

            dhCurrentSellingPrice.Attributes.Add("align", "right");
            dhCurrentSellingPrice.Text = strCurrentSellingPrice;
            dhCurrentSellingPrice.Width = Unit.Percentage(8);

            dhOpeningStockValue.Attributes.Add("align", "right");
            dhOpeningStockValue.Text = strOpenStockValue;
            dhOpeningStockValue.Width = Unit.Percentage(13);

            dhClosingStockValue.Attributes.Add("align", "right");
            dhClosingStockValue.Text = strCloseStockValue;
            dhClosingStockValue.Width = Unit.Percentage(13);

            dhUnits.Attributes.Add("align", "right");
            dhUnits.Text = "Units";
            dhUnits.Width = Unit.Percentage(8);

            dheadRow.Cells.Add(dhOpeningBalance);
            dheadRow.Cells.Add(dhOpeningStockValue);
            dheadRow.Cells.Add(dhStockReceived);
            dheadRow.Cells.Add(dhStockIssued);
            dheadRow.Cells.Add(dhStockDamage);
            dheadRow.Cells.Add(dhStockReturn);
            dheadRow.Cells.Add(dhClosingBalance);
            dheadRow.Cells.Add(dhClosingStockValue);
            dheadRow.Cells.Add(dhUnits);

            dheadRow.Style.Add("font-weight", "bold");
            dheadRow.Style.Add("font-size", "12px");

            DeDataHeaders.Rows.Add(dheadRow);

            TableRow dheadLine2Row = new TableRow();
            TableCell dheadLineCell2 = new TableCell();
            dheadLineCell2.ColumnSpan = 11;
            dheadLineCell2.Text = "<img src='../PlatForm/Images/px.jpg'/>";
            dheadLine2Row.Cells.Add(dheadLineCell2);
            DeDataHeaders.Rows.Add(dheadLine2Row);
            if (sType == "Y")
            {
                IEnumerable<ProductCategories> iChildCat = (from c in lstCategories
                                                            group c by new { c.CategoryID, c.CategoryName } into g
                                                            select new ProductCategories
                                                            {
                                                                CategoryID = g.Key.CategoryID,
                                                                CategoryName = g.Key.CategoryName,
                                                            }).Distinct().ToList();
                lstTempCategories = iChildCat.ToList();
            }
            if (lstTempCategories.Count == 0)
            {
                TableRow CatdeadRow1 = new TableRow();
                TableCell nilCell = new TableCell();
                nilCell.Attributes.Add("align", "center");
                nilCell.Text = strNoMatch;
                nilCell.ColumnSpan = 11;

                nilCell.Width = Unit.Percentage(10);
                //style=":14px;:bold;"
                nilCell.Style.Add("font-size", "14px");
                nilCell.Style.Add("font-weight", "bold");

                CatdeadRow1.Cells.Add(nilCell);
                DeDataHeaders.Rows.Add(CatdeadRow1);
            }

            foreach (ProductCategories catitem in lstTempCategories)
            {
                TableRow CatdeadRow = new TableRow();
                TableCell CatName = new TableCell();

                CatName.Attributes.Add("align", "left");
                CatName.Text = catitem.CategoryName;
                CatName.Width = Unit.Percentage(10);
                //style=":14px;:bold;"
                CatName.Style.Add("font-size", "14px");
                CatName.Style.Add("font-weight", "bold");

                CatdeadRow.Cells.Add(CatName);
                DeDataHeaders.Rows.Add(CatdeadRow);

                lsttemp = lstStockMovement.FindAll(p => p.LocationID == catitem.DeptID && p.CategoryID == catitem.CategoryID);


                if (sType == "Y")
                {
                    IEnumerable<StockMovementSummary> iChildStock = (from c in lstStockMovement
                                                                     where c.CategoryID == catitem.CategoryID
                                                                     group c by new
                                                                     {
                                                                         c.ProductID,
                                                                         c.CategoryID,
                                                                         c.CurrentSellingPrice,
                                                                         c.Units,
                                                                         c.ProductName,c.TDate
                                                                     } into g
                                                                     select new StockMovementSummary
                                                                     {
                                                                         CategoryID = g.Key.CategoryID,
                                                                         CurrentSellingPrice = g.Key.CurrentSellingPrice,
                                                                         ClosingBalance = g.Sum(p => p.ClosingBalance),
                                                                         //LocationID=g.Key.LocationID,
                                                                         ClosingStockValue = g.Sum(p => p.ClosingStockValue),
                                                                         OpeningBalance = g.Sum(p => p.OpeningBalance),
                                                                         OpeningStockValue = g.Sum(p => p.OpeningStockValue),
                                                                         ProductID = g.Key.ProductID,
                                                                         ProductName = g.Key.ProductName,
                                                                         StockReceived = g.Sum(p => p.StockReceived),
                                                                         StockIssued = g.Sum(p => p.StockIssued),
                                                                         StockReturn = g.Sum(p => p.StockReturn),
                                                                         StockDamage = g.Sum(p => p.StockDamage),
                                                                         Units = g.Key.Units,
                                                                     }).Distinct().ToList();
                    lsttemp = iChildStock.ToList();

                }
                if (Request.QueryString["NMI"] != null)
                {
                    lsttemp.RemoveAll(P => P.StockIssued > 0 || P.OpeningBalance == 0);
                }
                foreach (StockMovementSummary ditem in lsttemp)
                {

                    TableRow ddeadRow = new TableRow();
                    TableCell ddProductName = new TableCell();
                    TableCell ddDate = new TableCell();
                    TableCell ddOpeningBalance = new TableCell();
                    TableCell ddStockReceived = new TableCell();
                    TableCell ddStockIssued = new TableCell();
                    TableCell ddStockDamage = new TableCell();
                    TableCell ddStockReturn = new TableCell();
                    TableCell ddClosingBalance = new TableCell();
                    TableCell ddCurrentSellingPrice = new TableCell();
                    TableCell ddOpeningStockValue = new TableCell();
                    TableCell ddClosingStockValue = new TableCell();
                    TableCell ddUnits = new TableCell();

                    if (Request.QueryString["ProID"] == null)
                    {
                        ddProductName.Attributes.Add("align", "left");
                        ddProductName.Text = ditem.ProductName;
                        ddProductName.Width = Unit.Percentage(8);
                        ddeadRow.Cells.Add(ddProductName);
                    }
                    if (Request.QueryString["ProID"] != null)
                    {
                        ddDate.Attributes.Add("align", "left");
                        ddDate.Text = ditem.TDate.ToString("dd/MM/yyyy");
                        ddDate.Width = Unit.Percentage(10);
                        ddeadRow.Cells.Add(ddDate);
                    }


                   

                    ddOpeningBalance.Attributes.Add("align", "right");
                    ddOpeningBalance.Text = String.Format("{0:0.00}", ditem.OpeningBalance);                    
                    ddOpeningBalance.Width = Unit.Percentage(2);

                    ddStockReceived.Attributes.Add("align", "right");
                    ddStockReceived.Text = String.Format("{0:0}", ditem.StockReceived);
                    ddStockReceived.Width = Unit.Percentage(8);

                    ddStockIssued.Attributes.Add("align", "right");
                    ddStockIssued.Text = String.Format("{0:0}", ditem.StockIssued);
                    ddStockIssued.Width = Unit.Percentage(8);

                    ddStockDamage.Attributes.Add("align", "right");
                    ddStockDamage.Text = String.Format("{0:0}", ditem.StockDamage);
                    ddStockDamage.Width = Unit.Percentage(8);

                    ddStockReturn.Attributes.Add("align", "right");
                    ddStockReturn.Text = String.Format("{0:0}", ditem.StockReturn);
                    ddStockReturn.Width = Unit.Percentage(8);

                    ddClosingBalance.Attributes.Add("align", "right");
                    ddClosingBalance.Text = String.Format("{0:0.00}", ditem.ClosingBalance);
                    ddClosingBalance.Width = Unit.Percentage(8);

                    ddCurrentSellingPrice.Attributes.Add("align", "right");
                    ddCurrentSellingPrice.Text = String.Format("{0:0.00}", ditem.CurrentSellingPrice);
                    ddCurrentSellingPrice.Width = Unit.Percentage(8);

                    ddOpeningStockValue.Attributes.Add("align", "right");
                    ddOpeningStockValue.Text = String.Format("{0:0.00}", ditem.OpeningStockValue); 
                    ddOpeningStockValue.Width = Unit.Percentage(8);

                    ddClosingStockValue.Attributes.Add("align", "right");
                    ddClosingStockValue.Text = String.Format ("{0:0.00}", ditem.ClosingStockValue);                    
                    ddClosingStockValue.Width = Unit.Percentage(8);

                    ddUnits.Attributes.Add("align", "right");
                    ddUnits.Text = ditem.Units;
                    ddUnits.Width = Unit.Percentage(8);
                    ddeadRow.Cells.Add(ddOpeningBalance);
                    ddeadRow.Cells.Add(ddOpeningStockValue);
                    ddeadRow.Cells.Add(ddStockReceived);
                    ddeadRow.Cells.Add(ddStockIssued);
                    ddeadRow.Cells.Add(ddStockDamage);
                    ddeadRow.Cells.Add(ddStockReturn);
                    ddeadRow.Cells.Add(ddClosingBalance);
                    ddeadRow.Cells.Add(ddClosingStockValue);
                    ddeadRow.Cells.Add(ddUnits);
                    DeDataHeaders.Rows.Add(ddeadRow);
                    
                }
            }
            TableRow rlocLine1 = new TableRow();
            TableCell clocCell1 = new TableCell();
            clocCell1.ColumnSpan = 11;
            clocCell1.Text = "<hr/>";
            rlocLine1.Cells.Add(clocCell1);
            DeDataHeaders.Rows.Add(rlocLine1);

        }
    }
}