using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;

public partial class InventoryMaster_Controls_AddTaxDetails : Attune_BaseControl
{
    public string Text1
    {
        get
        {
            return txtAddPurchasePrice.Text;
        }
        set
        {
            txtAddPurchasePrice.Text = value;
        }

    }
     
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadSuppliers();
        }

    }


    private void LoadSuppliers()
    {
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        InventoryCommon_BL inventoryBL;
        inventoryBL = new InventoryCommon_BL();
        try
        {
         
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            ddlSupplierName.DataSource = lstSuppliers;
            ddlSupplierName.DataTextField = "SupplierName";
            ddlSupplierName.DataValueField = "SupplierID";

            ddlSupplierName.DataBind();
            //ddlSupplierName.Items.Insert(0, GetMetaData("Select", "0"));
            //ddlSupplierName.Items[0].Value = "0";
            //ddlSupplierName.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSupplierName.Items.Insert(0, ddlselect);
            
            ddlSupplierName.Items[0].Value = "0";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
        }

    }
    public List<InventoryItemsBasket> GetAttributes()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        InventoryItemsBasket objInventoryItemBasket = new InventoryItemsBasket();
        objInventoryItemBasket.UnitPrice = string.IsNullOrEmpty(txtAddPurchasePrice.Text.Trim()) == true ? 0 : Convert.ToDecimal(txtAddPurchasePrice.Text.Trim());
        objInventoryItemBasket.SupplierName = ddlSupplierName.SelectedValue == "0" ? "" : ddlSupplierName.SelectedItem.Text; 
        objInventoryItemBasket.StockStatus =string.IsNullOrEmpty(ddlSupplierName.SelectedValue) == true ? 0 : Convert.ToInt32(ddlSupplierName.SelectedValue);
        objInventoryItemBasket.Discount =string.IsNullOrEmpty(txtDiscount.Text.Trim())== true ? 0: Convert.ToDecimal(txtDiscount.Text);
        objInventoryItemBasket.InvoiceQty = string.IsNullOrEmpty(txtInverseQuantity.Text.Trim())==true ? 0:  Convert.ToDecimal(txtInverseQuantity.Text);
        lstInventoryItemsBasket.Add(objInventoryItemBasket);
        return lstInventoryItemsBasket;
    }
    public void ClearAttributes()
    {
        txtAddPurchasePrice.Text = "";
        txtDiscount.Text = "";
        //txtUomStockInhand.Text = "";
        txtInverseQuantity.Text = "";
        ddlSupplierName.SelectedValue = "0";
        
    }
    //
    


   
}
