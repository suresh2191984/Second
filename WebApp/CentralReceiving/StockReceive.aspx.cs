using System;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.CentralReceiving.BL;
using Attune.Kernel.PlatForm.Utility;

public partial class CentralReceiving_StockReceive : Attune_BasePage
{
    public CentralReceiving_StockReceive()
        : base("CentralReceiving_StockReceive_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<ProductCategories> lstProductCategories;

    InventoryCommon_BL inventoryBL;
    long returnCode = 0;
    string FromDate = string.Empty;
    string ToDate = string.Empty;
    string SupplierID = string.Empty;
    string PurchaseOrderNo = string.Empty;
    JavaScriptSerializer _json = new JavaScriptSerializer();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {
            lstProductCategories = new List<ProductCategories>();
            inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
            LoadSupplier();
            
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);


            FromDate = DateTimeNow.ToExternalDateTime();
            ToDate = DateTimeNow.ToExternalDateTime();
            
            int OrgAddid = ILocationID;

            PurchaseOrderNo = txtpurchaseordernos.Text;
            SupplierID = ddlSupplierList.SelectedItem.Value;
            int locid = Convert.ToInt32(InventoryLocationID.ToString());
            new CentralReceiving_BL(base.ContextInfo).SearchPurchaseOrderDetails(OrgID, locid, SupplierID, FromDate, ToDate, PurchaseOrderNo, out lstOrders);


            if (lstOrders.Count > 0)
            {
                btnGo.Visible = true;
                grdResult.DataSource = lstOrders;
                grdResult.DataBind();
            }
            else
            {
                grdResult.DataSource = null;
                grdResult.DataBind();
            }
        }


    }
    public void LoadSupplier()
    {
        try
        {
            returnCode = inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            if (returnCode == 0)
            {
                ddlSupplierList.DataSource = lstSuppliers;
                ddlSupplierList.DataTextField = "SupplierName";
                ddlSupplierList.DataValueField = "SupplierID";
                ddlSupplierList.DataBind();

            }
            ListItem ddlSelect = GetMetaData("Select", "0");
            if (ddlSelect == null)
            {
                ddlSelect = new ListItem() {Text="Select",Value="0" };
            }
            ddlSupplierList.Items.Insert(0, ddlSelect);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Supplier Details.", ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        int OrgAddid = ILocationID;
        PurchaseOrderNo = txtpurchaseordernos.Text;
        int locid = Convert.ToInt32(InventoryLocationID.ToString());
        string FromDate1 = "";
        if (!string.IsNullOrEmpty(txtFrom.Text))
        {
            FromDate1 = txtFrom.Text.ToInternalDate().ToString();
        }
        string ToDate1 = "";
        if (!string.IsNullOrEmpty(txtTo.Text))
        {
            ToDate1 = txtTo.Text.ToInternalDate().ToString();
        }

        SupplierID = ddlSupplierList.SelectedItem.Value;
        new CentralReceiving_BL(base.ContextInfo).SearchPurchaseOrderDetails(OrgID, locid, SupplierID, FromDate1, ToDate1, PurchaseOrderNo, out lstOrders);

        if (lstOrders.Count > 0)
        {
            btnGo.Visible = true;
            grdResult.DataSource = lstOrders;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = null;
            grdResult.DataBind();
        }
    }
   
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryOrdersMaster IOM = (InventoryOrdersMaster)e.Row.DataItem;
                string strScript = "INVRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + IOM.CreatedBy + "','" + IOM.SupplierID + "','" + IOM.OrderNo + "','" + IOM.OrderDate.ToShortDateString() + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                Button btn = (Button)e.Row.FindControl("btnReceivedPO");
                btn.CommandArgument = IOM.OrderID.ToString();
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading Purchase Order Details.", Ex);


        }
    }
    public void GetpurchaseorderDetails()
    {
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        int OrgAddid = ILocationID;
        PurchaseOrderNo = txtpurchaseordernos.Text;
        int locid = Convert.ToInt32(InventoryLocationID.ToString());
        if (txtFrom.Text == "")
        {
            FromDate = DateTimeNow.ToExternalDateTime();
            ToDate = DateTimeNow.ToExternalDateTime();
        }
        else
        {
            FromDate = txtFrom.Text;
            ToDate = txtTo.Text;
        }
        SupplierID = ddlSupplierList.SelectedItem.Value;
        new CentralReceiving_BL(base.ContextInfo).SearchPurchaseOrderDetails(OrgID, locid, SupplierID, FromDate.ToString(), ToDate.ToString(), PurchaseOrderNo, out lstOrders);

        if (lstOrders.Count > 0)
        {
            btnGo.Visible = true;
            grdResult.DataSource = lstOrders;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = null;
            grdResult.DataBind();
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            GetpurchaseorderDetails();
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
       
             string purchaseOrderNo = HdnPOno.Value;
             string orderdate = hdnorderdate.Value;
             Response.Redirect("CentralStockReceivedByCategory.aspx?PONO=" + purchaseOrderNo + "&orderdate=" + orderdate);
       
    }
   


  
   



}
