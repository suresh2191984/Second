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
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PurchaseOrder.BL;
using System.Web.Script.Serialization;

public partial class PurchaseOrder_POPage : Attune_BasePage
{
    public PurchaseOrder_POPage()
        : base("PurchaseOrder_POPage_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
    InventoryCommon_BL inventoryBL;
    PurchaseOrder_BL PurchaseOrder_BL;
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstInventoryItemsBasket2 = new List<InventoryItemsBasket>();
    public string _lstSupplierDetails = string.Empty;
    public string lstSupplierDetails
    {
        get { return _lstSupplierDetails; }
        set { _lstSupplierDetails = value; }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtPurchaseOrderDate.Text = DateTimeNow.ToExternalDate();
            List<InventoryConfig> lstInventoryConfig = null;

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("POs_Display_In_Child", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    tdPORecd.Visible = true;
                    
                }

            }

            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] == null)
            {
                string poNO = string.Empty;
                poNO = Request.QueryString["ID"];
                LoadPurchaseOrder(poNO);
               
            }
            if (Request.QueryString["copo"] != null)
            {
                string poNO = string.Empty;
                poNO = Request.QueryString["copo"];
                LoadPurchaseOrder(poNO);
                

            }

            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] == "Y")
            {
               
                btnApprove.CssClass = "btn inline-block";
                btnCancelPO.CssClass = "cancel-btn inline-block";
                btnGeneratePO.CssClass = "hide";

            }
            
            LoadSuppliers();
            ddlSupplierList.SelectedValue = hdnSName.Value;
           
            SetSuppliersDEtails();
            LoadSellingUnits();
            hdnLocationId.Value = InventoryLocationID.ToString();
            hdnOrgAddressID.Value = ILocationID.ToString();
            hdnOrgId.Value = OrgID.ToString();

        }

    }
    private void LoadSellingUnits()
    {
        try
        {
            List<InventoryUOM> lstInventoryUOM = null;
            inventoryBL.GetInventoryUOM(out lstInventoryUOM);
            if (lstInventoryUOM != null && lstInventoryUOM.Count > 0)
            {
                ddlUnits.DataSource = lstInventoryUOM;
                ddlUnits.DataTextField = "UOMCode";
                ddlUnits.DataValueField = "UOMCode";
                ddlUnits.DataBind();
                ListItem ddlselect = GetMetaData("Select", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "Select", Value = "0" };
                }
                ddlUnits.Items.Insert(0, ddlselect);
                ddlUnits.Items.Insert(0, GetMetaData("Select", "0"));
                ddlUnits.Items[0].Value = "0";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading SellingUnits in PurchaseOrderQuantity.aspx", ex);
        }

    }
    

    public void LoadPurchaseOrder(string poNO)
    {
        try
        {
            string approval = string.Empty;
            approval = Request.QueryString["Approve"];
            List<PurchaseOrders> lstPurchaseOrders = null;
            List<Organization> lstOrganization = null;
            List<ProductCategories> lstProductCategories = null;
            inventoryBL.GetPurchaseOrderDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstPurchaseOrders, out lstProductCategories, out lstInventoryItemsBasket);

            List<InventoryItemsBasket> iChildCat = (from i in lstInventoryItemsBasket
                                                    group i by new
                                                    {
                                                        i.ProductID,
                                                        i.Quantity,
                                                        i.Unit,
                                                        i.ID,
                                                        i.ProductName,
                                                        i.CategoryName,
                                                        i.CategoryID,
                                                        i.LocationID,
                                                        i.LocationName,
                                                        i.Description,
                                                        i.Discount,
                                                        i.Amount,
                                                        i.Tax,
                                                        i.Rate,
                                                        i.UnitSellingPrice,
                                                        i.ComplimentQTY,
                                                        i.PurchaseTax
                                                    } into g

                                                    select new InventoryItemsBasket
                                                    {
                                                        ProductID = g.Key.ProductID,
                                                        ProductName = g.Key.ProductName,
                                                        Unit = g.Key.Unit,
                                                        ID = g.Key.ID,
                                                        Quantity = g.Key.Quantity,
                                                        CategoryID = g.Key.CategoryID,
                                                        CategoryName = g.Key.CategoryName,
                                                        LocationID = g.Key.LocationID,
                                                        LocationName = g.Key.LocationName,
                                                        Description = g.Key.Description,
                                                        Discount = g.Key.Discount,
                                                        Amount = g.Key.Amount,
                                                        Tax = g.Key.Tax,
                                                        Rate = g.Key.Rate,
                                                        UnitSellingPrice = g.Key.UnitSellingPrice,
                                                        ComplimentQTY = g.Key.ComplimentQTY,
                                                        PurchaseTax = g.Key.PurchaseTax
                                                    }).Distinct().ToList();
            lstInventoryItemsBasket = iChildCat.ToList();


            List<InventoryItemsBasket> iChildCat2 = (from i in lstInventoryItemsBasket
                                                     group i by new
                                                     {
                                                         i.ProductID,
                                                         i.Quantity,
                                                         i.Unit,
                                                         i.ID,
                                                         i.ProductName,
                                                         i.CategoryName,
                                                         i.CategoryID,
                                                         i.Discount,
                                                         i.Amount,
                                                         i.Tax,
                                                         i.Rate,
                                                         i.UnitSellingPrice,
                                                         i.ComplimentQTY,
                                                         i.PurchaseTax
                                                     } into g

                                                     select new InventoryItemsBasket
                                                     {
                                                         ProductID = g.Key.ProductID,
                                                         ProductName = g.Key.ProductName,
                                                         Unit = g.Key.Unit,
                                                         ID = g.Key.ID,
                                                         Quantity = g.Key.Quantity,
                                                         CategoryID = g.Key.CategoryID,
                                                         CategoryName = g.Key.CategoryName,
                                                         Description = Convert.ToString(g.Sum(p => Convert.ToDecimal(p.Description))),
                                                         Discount = g.Key.Discount,
                                                         Amount = g.Key.Amount,
                                                         Tax = g.Key.Tax,
                                                         Rate = g.Key.Rate,
                                                         UnitSellingPrice = g.Key.UnitSellingPrice,
                                                         ComplimentQTY = g.Key.ComplimentQTY,
                                                         PurchaseTax = g.Key.PurchaseTax
                                                     }).Distinct().ToList();
            lstInventoryItemsBasket2 = iChildCat2.ToList();
            LoadProductList(lstInventoryItemsBasket2);
            hdnPoDate.Value = lstPurchaseOrders[0].PurchaseOrderDate.ToString();
            hdnSName.Value = lstSuppliers[0].SupplierID.ToString();
            hdnComments.Value = lstPurchaseOrders[0].Comments;
            if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Pending && approval == "1")
            {
                btnApprove.CssClass = "btn inline-block";
                btnCancelPO.CssClass = "cancel-btn inline-block";
                btnGeneratePO.CssClass = "hide";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }

    }

    public class tempclass
    {
        public long ProductID { get; set; }
        public string ProductName { get; set; }
        public int CategoryID { get; set; }
        public decimal Quantity { get; set; }
        public string Description { get; set; }
        public string Unit { get; set; }
        public string CategoryName { get; set; }
        public long ID { get; set; }
        public string IsStockReceived { get; set; }
        public decimal Discount { get; set; }
        public decimal Amount { get; set; }
        public decimal Tax { get; set; }
        public decimal PurchaseTax { get; set; }
        public decimal ComplimentQTY { get; set; }
        public decimal Total { get; set; }
        public decimal UnitCostPrice { get; set; }
        public decimal Rate { get; set; }
        public decimal ProductReceivedDetailsID { get; set; }


    }
    public void LoadProductList(List<InventoryItemsBasket> lstIIB)
    {
        
        List<tempclass> lsttempclass = (from c in lstIIB
                                        select new tempclass
                                        {
                                            ProductID = c.ProductID,
                                            ProductName = c.ProductName,
                                            CategoryID = c.CategoryID,
                                            Quantity = c.Quantity,
                                            Description = c.Description,
                                            Total = (c.Quantity * c.Amount),
                                            UnitCostPrice = c.Amount,
                                            Unit = c.Unit,
                                            CategoryName = c.CategoryName,
                                            Discount = c.Discount,//(((c.Quantity * c.Amount)) * c.Discount) / 100,
                                            ID = c.ID,
                                            IsStockReceived = "N",
                                            // Amount = c.Amount,
                                            Tax = c.Tax,
                                            ComplimentQTY = c.ComplimentQTY,
                                            PurchaseTax = c.PurchaseTax,//((c.Discount * c.PurchaseTax) / 100),
                                            Rate = (c.Quantity * c.Amount) + ((c.Amount * c.Discount) / 100) + ((c.Discount * c.PurchaseTax) / 100),
                                            ProductReceivedDetailsID = c.ProductReceivedDetailsID,
                                        }).ToList();


        hdnPurchaseOrderItems.Value = new JavaScriptSerializer().Serialize(lsttempclass); //tempProductList
    }

    

    protected void btnGeneratePO_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string pPONo = string.Empty;
        try
        {
            PurchaseOrders objPO = new PurchaseOrders();
            List<InventoryItemsBasket> lstInventoryItemsBasket = null;
            objPO.PurchaseOrderDate = txtPurchaseOrderDate.Text.ToInternalDate();
            objPO.OrgID = OrgID;
            objPO.SupplierID = Convert.ToInt32(hdnSName.Value);
            objPO.CreatedBy = LID;
            objPO.PurchaseOrderNo = "N";
            objPO.OrgAddressID = ILocationID;
            objPO.LocationID = InventoryLocationID;
            objPO.Comments = hdnComments.Value;
            objPO.Status = StockOutFlowStatus.Pending;
            List<InventoryConfig> lstInventoryConfig = null;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_PO_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin == RoleName)
                        objPO.Status = StockOutFlowStatus.Approved;
                    else
                        objPO.Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    objPO.Status = StockOutFlowStatus.Approved;
                }
            }

            if (Request.QueryString["ID"] != null)
            {
                if (Request.QueryString["ID"] != "ipo")
                {
                    objPO.PurchaseOrderID = Int64.Parse(Request.QueryString["ID"]);
                }
            }
            lstInventoryItemsBasket = GetCollectedItems();
            returnCode = new PurchaseOrder_BL(base.ContextInfo).SavePurchaseOrderDetails(objPO, lstInventoryItemsBasket, out pPONo);
            if (returnCode == 0)
            {
                string status = StockOutFlowStatus.Approved;
                returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", objPO.PurchaseOrderID, status, LID, OrgID, ILocationID);

                if (returnCode == 0)
                {
                    RemoveDrafts();
                    if (Request.QueryString["ACN"] != null)
                    {
                        string strACN = Request.QueryString["ACN"];
                        Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + pPONo + "&ACN=" + strACN, true);

                    }
                    Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + pPONo + "", true);
                }
                else
                {
                    
                    return;
                }
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Purchase Order Details.", ex);
        }
    }

    public List<InventoryItemsBasket> GetCollectedItems()
    {
        List<InventoryItemsBasket> lstCollectedItemsBasket = null;
        if (!string.IsNullOrEmpty(hdnPurchaseOrderItems.Value))
        {
            
            lstCollectedItemsBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnPurchaseOrderItems.Value);
            lstCollectedItemsBasket.ForEach(p => p.ExpiryDate = DateTimeNow);
            lstCollectedItemsBasket.ForEach(p => p.Manufacture = DateTimeNow);
        }
        
        return lstCollectedItemsBasket;
    }

    

    protected void btnCancelPO_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID = 0;
            if (Request.QueryString["ID"] != null)
            {
                orderID = Int64.Parse(Request.QueryString["ID"]);
            }
            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID, ILocationID);

            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + orderID + "&ACN=" + strACN, true);

            }

            Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + orderID + "", true);


        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
        }
    }

   

    private void SetSuppliersDEtails()
    {
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        var Detalis = from Supplier in lstSuppliers
                      where Supplier.SupplierID == int.Parse(ddlSupplierList.SelectedValue)
                      select Supplier;
        divSupplier.Attributes.Add("class", "hide");
        foreach (var childList in Detalis)
        {

            divSupplier.Attributes.Add("class", "show");
            if (childList.Address2 != string.Empty)
            {
                lblVendorAddress.Text = childList.Address1 + "," + childList.Address2;
            }
            else
            {
                lblVendorAddress.Text = childList.Address1;
            }
            hdnSName.Value = childList.SupplierID.ToString();
            lblVendorCity.Text = childList.City;
            lblVendorPhone.Text = childList.Phone;
            lblEmailID.Text = childList.EmailID;


        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "DatePicker", "javascript:recallpresentdatepicker();", true);
    }

    private void LoadSuppliers()
    {
        try
        {
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);

            ddlSupplierList.DataSource = lstSuppliers;
            ddlSupplierList.DataTextField = "SupplierName";
            ddlSupplierList.DataValueField = "SupplierID";
            ddlSupplierList.DataBind();

            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSupplierList.Items.Insert(0, ddlselect);
            ddlSupplierList.Items[0].Value = "0";


            JavaScriptSerializer lstSuppinfo = new JavaScriptSerializer();
            lstSupplierDetails = lstSuppinfo.Serialize(lstSuppliers);
            lstSupplierDetails = lstSupplierDetails.Replace("\\n", "\\\\n")
                .Replace("\\\'", "\\\\'")
                .Replace("\\\"", "\\\\\"")
                .Replace("\\\\&", "\\\\&")
                .Replace("\\\r", "\\\\r")
                .Replace("\\\t", "\\\\t")
                .Replace("\\\b", "\\\\b")
                .Replace("\\\f", "\\\\f");
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
        }

    }

    protected void LoadConfig()
    {
        try
        {
            PurchaseOrder_BL = new PurchaseOrder_BL(base.ContextInfo);
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("LoadPrevProductDetails", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    //LoadPreviousDetails();
                }
            }
            else
            {
                //LoadPurchaseOrderItems(lstInventoryItemsBasket2);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
    }
    private void RemoveDrafts()
    {
        try
        {
            InventoryCommon_BL objDraft = new InventoryCommon_BL();
            string DraftValue = ddlSupplierList.SelectedValue;
            objDraft.DeleteDraft(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "PurchaseOrder", DraftValue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting the draft", ex);

        }


    }

   
}