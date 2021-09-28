using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class StockOutFlow_ViewStockNonUsage : Attune_BasePage
{
    public StockOutFlow_ViewStockNonUsage()
        : base("StockOutFlow_ViewStockNonUsage_aspx")
   {
   }
    long returnCode = -1;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockOutFlow> lstStockDamage = new List<StockOutFlow>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    List<Users> lstUsers = new List<Users>();
    List<StockReturnDetails> lstStockReturnDetails = new List<StockReturnDetails>(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadDetails();
        }

    }
    public void LoadDetails()
    {
        long pSDNO = -1;
        string approval = string.Empty;
        string unapproved = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_11 == null ? "UnApproved" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_11;
        string Approved = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_12 == null ? "Approved" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_12;
        string Note = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_13 == null ? "Note:" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_13;
        if (Request.QueryString["ID"] != null)
        {
            if (!Request.QueryString["ID"].Contains("}"))
            {
                pSDNO = Convert.ToInt64(Request.QueryString["ID"]);
            }
        }
        approval = Request.QueryString["Approve"];
        // hypLnkPrint.NavigateUrl = "PrintStockDamage.aspx?pSDNO=" + pSDNO + "";
        try
        {
            //inventoryBL.GetStockDamageDetails(OrgID, pSDNO, out lstOrganization, out lstStockDamage, out lstProductCategories, out lstInventoryItemsBasket);
            inventoryBL.GetStockOutFlowDetails(OrgID, pSDNO, (int)StockOutFlowType.StockDamage, out lstOrganization, out lstSuppliers, out lstStockDamage, out lstProductCategories, out lstInventoryItemsBasket, out lstStockReturnDetails);

            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                //lblVendorName.Text = lstSuppliers[0].SupplierName;
                //lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                //lblVendorCity.Text = lstSuppliers[0].City;
                //lblVendorPhone.Text = lstSuppliers[0].Phone;
                lblSDDate.Text = lstStockDamage[0].CreatedAt.ToExternalDate();
                lblSDID.Text = lstStockDamage[0].StockOutFlowNo;
                hdnApproveStockDamage.Value = lstStockDamage[0].StockOutFlowID.ToString();
                LoadStockDamageItems(lstProductCategories, lstInventoryItemsBasket);
                if (lstStockDamage[0].Description != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Note<span class='marginL77 marginR8' >:</span> " + lstStockDamage[0].Description;
                }
                if (lstStockDamage[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    approvedDateTD.InnerText = lstStockDamage[0].ApprovedAt.ToExternalDate();
                }
                GateWay headBL = new GateWay(base.ContextInfo);
                if (lstStockDamage[0].ApprovedBy != 0)
                {
                    returnCode = headBL.GetUserDetail(lstStockDamage[0].ApprovedBy, out lstUsers);
                    if (lstUsers!=null && lstUsers.Count > 0)
                    {
                        approvedByTD.Attributes.Add("class", "displaytd");

                        approvedByTD.InnerText = lstUsers[0].Name;
                    }
                }

                if (lstStockDamage[0].Status == StockOutFlowStatus.Created && approval == "1")
                {
                    lblStatus.Text = unapproved;
                    trApproveBlock.Attributes.Add("class", "show");

                }
                else if (lstStockDamage[0].Status == StockOutFlowStatus.Created && approval == null)
                {
                    //lblStatus.Text = "Approved"; 
                    lblStatus.Text = unapproved;
                    trApproveBlock.Attributes.Add("class", "hide");
                }
                else
                {
                    lblStatus.Text = Approved;
                    trApproveBlock.Attributes.Add("class", "hide");
                }
               		 List<Config> lstConfig = new List<Config>();
                int iBillGroupID = 0;
                iBillGroupID = (int)ReportType.OPBill;
                new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
			
                  
                    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Replace("../../", "../");
                    if (lstConfig[0].ConfigValue.Trim() != "")
                    {
                        imgBillLogo.Attributes.Add("class", "a-center");
                    }
                    else
                    {
                        imgBillLogo.Attributes.Add("class", "hide");
                    }
                }
                else
                {
                    imgBillLogo.Attributes.Add("class", "hide");
                }
            }
            else
            {
                string Message = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_07;
                if (Message == null)
                {
                    Message="No Matching Records Found!";
                }
                lblMessage.Text = Message;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockNonUsage.aspx.cs", ex);
        }
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
    }

    public void LoadStockDamageItems(List<ProductCategories> lstPO, List<InventoryItemsBasket> lstIIB)
    {
        string ProductName = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_08;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string Quantity = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_09;
        if (Quantity == null)
        {
            Quantity = "Quantity";
        }

        string Units = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockNonUsage_aspx_10;
        if (Units == null)
        {
            Units = "Unit";
        }

        string BatchNo = Resources.StockOutFlow_ClientDisplay.StockOutFlow_Scripts_StockDamage_js_04;
        if (ProductName == null)
        {
            BatchNo = "Batch No";
        }
        string SellingPrice = Resources.StockOutFlow_ClientDisplay.StockOutFlow_Scripts_StockDamage_js_07;
        if (SellingPrice == null)
        {
            SellingPrice = "Selling Price";
        }
        string Amount = Resources.StockOutFlow_ClientDisplay.StockOutFlow_Scripts_StockDamage_js_08;
        if (Amount == null)
        {
            Amount = "Amount";
        }
        string Remarks = Resources.StockOutFlow_ClientDisplay.StockOutFlow_Scripts_StockDamage_js_12 == null ? "Remarks" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_Scripts_StockDamage_js_12;
        stockDamageDetailsTab.Rows.Clear();
        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        TableCell cellH3 = new TableCell();
        TableCell cellH4 = new TableCell();
        TableCell cellH5 = new TableCell();
        TableCell cellH6 = new TableCell();
        TableCell cellH7 = new TableCell();

        cellH1.Attributes.Add("class", "a-left");
        cellH1.Text = ProductName;
        cellH1.Width = Unit.Percentage(20);
        cellH2.Attributes.Add("class", "a-left");
        cellH2.Text = Quantity;
        cellH2.Width = Unit.Percentage(8);
        cellH3.Attributes.Add("class", "a-left");
        cellH3.Text = Units;
        cellH3.Width = Unit.Percentage(8);

        cellH4.Attributes.Add("class", "a-left");
        cellH4.Text = BatchNo;
        cellH4.Width = Unit.Percentage(20);
        cellH5.Attributes.Add("class", "a-left");
        cellH5.Text = SellingPrice;
        cellH5.Width = Unit.Percentage(8);
        cellH6.Attributes.Add("class", "a-left");
        cellH6.Text = Amount;
        cellH6.Width = Unit.Percentage(8);
        cellH7.Attributes.Add("class", "a-left");
        cellH7.Text = Remarks;
        cellH7.Width = Unit.Percentage(8);

        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH4);
        rowH.Cells.Add(cellH2);
        rowH.Cells.Add(cellH3);
        rowH.Cells.Add(cellH5);
        rowH.Cells.Add(cellH6);
        rowH.Cells.Add(cellH7);

        rowH.Font.Bold = true;
        rowH.CssClass = "gridHeader";
        //rowH.Font.Underline = true;
        //rowH.Style.Add("color", "#333");
        stockDamageDetailsTab.Rows.Add(rowH);
        foreach (ProductCategories objPC in lstProductCategories)
        {

            var list = from basket in lstInventoryItemsBasket
                       where basket.CategoryID == objPC.CategoryID
                       select basket;
            if (list.Count() > 0)
            {

                foreach (var childList in list)
                {
                    TableRow row2 = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();
                    TableCell cell7 = new TableCell();

                    cell1.Attributes.Add("class", "a-left");
                    cell1.Text = childList.ProductName;
                    cell2.Attributes.Add("class", "a-left");
                    cell2.Text = childList.Quantity.ToString();
                    cell2.Width = Unit.Percentage(8);
                    cell3.Attributes.Add("class", "a-left");
                    if (childList.Unit != "")
                    {
                        cell3.Text = childList.Unit;
                    }
                    else
                    {
                        cell3.Text = "--";
                    }
                    cell3.Width = Unit.Percentage(8);

                    cell4.Attributes.Add("class", "a-left");
                    cell4.Text = childList.BatchNo;
                    
                    cell5.Attributes.Add("class", "a-left");
                    cell5.Text = (childList.SellingPrice).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    cell5.Width = Unit.Percentage(8);

                    Decimal Amt;
                    Amt = (childList.UnitPrice * childList.Quantity);
                    Amt = Amt + (Amt) / 100 * childList.Tax;
                    cell6.Attributes.Add("class", "a-left");
                    cell6.Text = (childList.SellingPrice * childList.Quantity).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    cell6.Width = Unit.Percentage(8);

                    cell7.Attributes.Add("class", "a-left");
                    cell7.Text = childList.Remarks;

                    row2.Cells.Add(cell1);
                    row2.Cells.Add(cell4);
                    row2.Cells.Add(cell2);
                    row2.Cells.Add(cell3);
                    row2.Cells.Add(cell5);
                    row2.Cells.Add(cell6);
                    row2.Cells.Add(cell7);

                    row2.Font.Bold = false;
                    row2.Attributes.Add("class", "black");
                    stockDamageDetailsTab.Rows.Add(row2);
                }

            }
        }
    }
    protected void Back_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../InventoryCommon/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}


