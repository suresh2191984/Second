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

public partial class InventoryReports_PrintPurchaseOrder : Attune_BasePage 
{
    public InventoryReports_PrintPurchaseOrder()
        : base("InventoryReports_PrintPurchaseOrder_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<PurchaseOrderMappingLocation> lstPurchaseOrder = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMap = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstPOQuantityDetails = new List<PurchaseOrderMappingLocation>();
    List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
    InventoryCommon_BL inventoryBL;
    long returnCode = -1;
    long poID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            if (Request.QueryString["POID"] != null)
            {
            }

            if (Request.QueryString["POID"] != null)
            {
                poID = long.Parse (Request.QueryString["POID"]);
                PrintDetails(poID);
            }
        }
    }
    public void PrintDetails(long poID)
    {
        List<StockReceived> lstTaxType = new List<StockReceived>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        returnCode = inventoryBL.GetPurchaseOrderProductDetailsPrint(poID, OrgID, out lstOrganization, out lstSuppliers, out lstPurchaseOrders, out  lstPurchaseOrder, out lstProductsMap, out lstQuotationMaster, out lstTaxType, out lstTaxmaster, out lstPOQuantityDetails);

        if (lstPurchaseOrder.Count > 0)
        {
            gvPurOrderDetails.Visible = true; 
            gvPurOrderDetails.DataSource = lstPurchaseOrder;
            gvPurOrderDetails.DataBind();
        }
        if (lstProductsMap.Count > 0)
        {
            gvDetails.Visible = true;
            gvDetails.DataSource = lstProductsMap;
            gvDetails.DataBind();
        }
    }


    protected void btnRedirect_Click(object sender, EventArgs e)
    {
        string poID = Request.QueryString["POID"];
        Response.Redirect("~/CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + poID); 
    }
}
