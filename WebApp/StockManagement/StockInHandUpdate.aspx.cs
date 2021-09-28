using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.PlatForm.Common;

public partial class StockManagement_StockInHandUpdate : Attune_BasePage
{
    public StockManagement_StockInHandUpdate()
        : base("StockManagement_StockInHandUpdate_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    InventoryCommon_BL inventoryBL;
    Products objProducts = new Products();
    DataTable objDataTable;
    string strSuccess = Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_01 == null ? "Stock Received Details Updated sucessfully" : Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_01;
    string strFail = Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_02 == null ? "Stock Received Details Updated Failed" : Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_02;
    string strAlert = Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_03 == null ? "There was a problem. Please contact system administrator" : Resources.StockManagement_ClientDisplay.StockManagement_StockInHandUpdate_aspx_03;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            new InventoryCommon_BL(base.ContextInfo).GetProductCategories(OrgID, ILocationID, out lstProductCategories);
            if (lstProductCategories.Count > 0)
            {
                ddlCategory.DataSource = lstProductCategories;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();

            }
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlCategory.Items.Insert(0, ddlselect);

            //ddlCategory.Items.Insert(0, "--Select Category--");
            //ddlCategory.Items[0].Value = "0";
            
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        new StockManagement_BL(base.ContextInfo).GetInHandProductList(OrgID, int.Parse(ddlCategory.SelectedValue), out lstInventoryItemsBasket);
        grdResult.DataSource = lstInventoryItemsBasket;
        grdResult.DataBind();
        lblmsg.Text = "";
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            objDataTable = new DataTable();
            objDataTable = BindProductList(getTable());
            StockManagement_BL inventoryBL1 = new StockManagement_BL(base.ContextInfo);
            returnCode = inventoryBL1.UpdateBulkLoadReceived(objDataTable, OrgID, LID, InventoryLocationID, ILocationID);
            if (returnCode != -1)
            {
                lblmsg.Text = strSuccess;
            }
            else
            {
                lblmsg.Text = strFail;
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updateing Reorder level.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = strAlert;
        }
    }

    private DataTable BindProductList(DataTable objdataTable)
    {
        DataRow dr;
        foreach (GridViewRow row in grdResult.Rows)
        {
            dr = objdataTable.NewRow();
            dr["Quantity"] = ((TextBox)row.FindControl("txtQuantity")).Text;
            dr["ProductID"] = ((HiddenField)row.FindControl("hdnProductId")).Value;
            dr["CategoryID"] = ddlCategory.SelectedValue;
            dr["CategoryName"] = 0;
            dr["ProductName"] = 0;
            dr["ComplimentQTY"] = 0;
            dr["Tax"] = 0;
            dr["Discount"] = 0;
            dr["Rate"] = ((TextBox)row.FindControl("txtSellingPrice")).Text;
            dr["UOMID"] = 0;
            dr["Unit"] = ((DropDownList)row.FindControl("ddlUnit")).SelectedItem.Text;
            dr["UnitPrice"] = ((TextBox)row.FindControl("txtUnitPrice")).Text;
            dr["LSUnit"] = 0;
            dr["Description"] = 0;
            dr["ExpiryDate"] = ((TextBox)row.FindControl("txtExpiryDate")).Text;
            dr["Manufacture"] = ((TextBox)row.FindControl("txtManufacture")).Text;
            dr["BatchNo"] = ((TextBox)row.FindControl("txtBatchNo")).Text;
            dr["Providedby"] = ((HiddenField)row.FindControl("hdnprovidedby")).Value;
            dr["Type"] = 0;
            dr["Amount"] = 0;
            dr["ID"] = ((HiddenField)row.FindControl("hdnRid")).Value;
            dr["POQuantity"] = 0;
            dr["POUnit"] = 0;
            dr["RECQuantity"] = ((TextBox)row.FindControl("txtQuantity")).Text;
            dr["RECUnit"] = ((DropDownList)row.FindControl("ddlUnit")).SelectedItem.Text;
            dr["SellingUnit"] = 0;
            dr["InvoiceQty"] = 0;
            dr["RcvdLSUQty"] = 0;
            dr["AttributeDetail"] = "";
            dr["HasExpiryDate"] = "";
            dr["HasBatchNo"] = "";
            dr["HasUsage"] = "";
            dr["UsageCount"] = "";
            dr["RakNo"] = "";
            dr["MRP"] = "";
            dr["InHandQuantity"] = 0;
            dr["ExciseTax"] = 0;
            dr["DiscOrEnhancePercent"] = 0;
            dr["DiscOrEnhanceType"] = "";
            dr["Remarks"] = "";
            dr["ProductKey"] = "";
            dr["UnitSellingPrice"] = 0;
            dr["UnitCostPrice"] = 0;
            dr["ReceivedOrgID"] = 0;
            dr["ParentProductID"] = 0;
            dr["ReceivedOrgAddID"] = 0;
            dr["ParentProductKey"] = "";
            dr["PrescriptionNO"] = "0";
            objdataTable.Rows.Add(dr);

        }
        return objdataTable;
    }

    private DataTable getTable()
    {
        DataTable basket = new DataTable();


        basket.Columns.Add("CategoryID");
        basket.Columns.Add("ProductID");
        basket.Columns.Add("CategoryName");
        basket.Columns.Add("ProductName");
        basket.Columns.Add("Quantity");
        basket.Columns.Add("ComplimentQTY");
        basket.Columns.Add("Tax");
        basket.Columns.Add("Discount");
        basket.Columns.Add("Rate");
        basket.Columns.Add("UOMID");
        basket.Columns.Add("Unit");
        basket.Columns.Add("UnitPrice");
        basket.Columns.Add("LSUnit");
        basket.Columns.Add("Description");
        basket.Columns.Add("ExpiryDate");
        basket.Columns.Add("Manufacture");
        basket.Columns.Add("BatchNo");
        basket.Columns.Add("Providedby");
        basket.Columns.Add("Type");
        basket.Columns.Add("Amount");
        basket.Columns.Add("ID");
        basket.Columns.Add("POQuantity");
        basket.Columns.Add("POUnit");
        basket.Columns.Add("RECQuantity");
        basket.Columns.Add("RECUnit");
        basket.Columns.Add("SellingUnit");
        basket.Columns.Add("InvoiceQty");
        basket.Columns.Add("RcvdLSUQty");
        basket.Columns.Add("AttributeDetail");
        basket.Columns.Add("HasExpiryDate");
        basket.Columns.Add("HasBatchNo");
        basket.Columns.Add("HasUsage");
        basket.Columns.Add("UsageCount");
        basket.Columns.Add("RakNo");
        basket.Columns.Add("MRP");
        basket.Columns.Add("InHandQuantity");
        basket.Columns.Add("ExciseTax");
        basket.Columns.Add("DiscOrEnhancePercent");
        basket.Columns.Add("DiscOrEnhanceType");
        basket.Columns.Add("Remarks");
        basket.Columns.Add("ProductKey");
        basket.Columns.Add("UnitSellingPrice");
        basket.Columns.Add("UnitCostPrice");
        basket.Columns.Add("ReceivedOrgID");
        basket.Columns.Add("ParentProductID");
        basket.Columns.Add("ReceivedOrgAddID");
        basket.Columns.Add("ParentProductKey");
        basket.Columns.Add("PrescriptionNO");
        return basket;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket inv=new InventoryItemsBasket();
            inv=(InventoryItemsBasket)e.Row.DataItem;
            DropDownList ddlUnit = (DropDownList)e.Row.FindControl("ddlUnit");
            loadInventoryUOM(ddlUnit,inv.RECUnit);
        }
    }

    private void loadInventoryUOM(DropDownList ddlBoxU, string SelectedText)
    {
        try
        {
            if (lstInventoryUOM.Count==0)
            {
              new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);

            }
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMID";
            ddlBoxU.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlBoxU.Items.Insert(0, ddlselect);

            if (SelectedText != "")
            {
                ddlBoxU.SelectedItem.Text = SelectedText;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Units.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = strAlert;
        }
        
    }
}