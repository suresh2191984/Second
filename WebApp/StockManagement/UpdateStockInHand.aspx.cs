using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
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
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;

public partial class StockManagement_UpdateStockInHand : Attune_BasePage
{
    public StockManagement_UpdateStockInHand()
        : base("StockManagement_UpdateStockInHand_aspx")
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

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            lblMessage.Text = string.Empty;
            inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
            if (lstProductCategories.Count > 0)
            {
                ddlCategory.DataSource = lstProductCategories;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();
                ListItem ddlselect = GetMetaData("Select", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "Select", Value = "0" };
                }
                ddlCategory.Items.Insert(0, ddlselect);
              //  ddlCategory.Items.Insert(0, "--Select category--");
                //end
                ddlCategory.Items[0].Value = "0";
            }
        }
        if (txtProduct.Text != "" && hdnUpdate.Value == "Update")
        {
            BindProductList();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (listSearch.SelectedItem != null)
        {
            txtProduct.Text = listSearch.SelectedItem.Text;
        }
        lblMessage.Text = string.Empty;
        BindProductList();
    }

    private void BindProductList()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        new InventoryCommon_BL(base.ContextInfo).GetProductListByCategory(OrgID, ILocationID, InventoryLocationID, int.Parse(ddlCategory.SelectedValue), "", txtProduct.Text.Trim(), out lstInventoryItemsBasket);
        grdResult.DataSource = lstInventoryItemsBasket;
        grdResult.DataBind();
        hdnUpdate.Value = "";


        var distinctValue = (from row in lstInventoryItemsBasket
                             select new
                             {
                                 row.ProductName,

                             }).Distinct().ToList();
        var distinctValue1 = distinctValue.Select(p => p.ProductName).Distinct().ToList();

        if (distinctValue1.Count() > 0)
        {
            listSearch.Visible = true;
            listSearch.DataSource = distinctValue1;
            listSearch.DataBind();
        }
        else
        {
            listSearch.Visible = false;
        }


    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        try
        {
            // Response.Redirect("Products.aspx", true);
            Response.Redirect("~/InventoryMaster/Products.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string strtae = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Add Product", ex);
        }
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "INVSave")
        {
            try
            {
                List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
                foreach (GridViewRow row in grdResult.Rows)
                {
                    InventoryItemsBasket item = new InventoryItemsBasket();
                    HiddenField ProductName = (HiddenField)row.FindControl("hdnProductName");
                    HiddenField ProductId = (HiddenField)row.FindControl("hdnProductId");
                    HiddenField CategoryId = (HiddenField)row.FindControl("hdnCategoryId");
                    HiddenField ID = (HiddenField)row.FindControl("hdnRid");
                    TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                    Label txtBatchNo = (Label)row.FindControl("txtBatchNo");
                    HiddenField hdnDescription = (HiddenField)row.FindControl("hdnDescription");
                    item.ProductName = ProductName.Value;
                    item.ID = Int64.Parse(ID.Value);

                    item.BatchNo = txtBatchNo.Text;
                    item.RECQuantity = decimal.Parse((txtQuantity.Text == "") ? "0" : txtQuantity.Text);
                    item.CategoryID = int.Parse(CategoryId.Value);
                    item.ProductID = Int64.Parse(ProductId.Value);
                    item.Description = hdnDescription.Value;
                    if (Convert.ToString(ID.Value) == Convert.ToString(e.CommandArgument))
                    {
                        Button btnSave = (Button)row.FindControl("btnSave");
                        TextBox txtQty = (TextBox)row.FindControl("txtQuantity");
                        HiddenField hdnIHQ = (HiddenField)row.FindControl("hdnInHandQuantity");
                        if (txtQty.Text != "")
                        {

                            lstInventory.Add(item);

                            DataTable objDataTable = new DataTable();
                            objDataTable = BindProductList(lstInventory, getTable());
                            new InventoryCommon_BL(base.ContextInfo).UpdateStockInHand(OrgID, ILocationID, InventoryLocationID, LID, objDataTable);
                            //lblMessage.Text = strSuccessfullysaved;
                            
                            string sPath = Resources.StockManagement_AppMsg.StockManagement_UpdateStockInHand_aspx_04;
                            sPath = sPath == null ? "Successfully saved" : sPath;

                            string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                            errorMsg = errorMsg == null ? "Alert" : errorMsg;
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MustEntry", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                            //end
                            txtQty.Font.Bold = false;
                            BindProductList();

                        }
                        else
                        {
                            lblMessage.Text = string.Empty;
                            
                            string sPath = Resources.StockManagement_AppMsg.StockManagement_UpdateStockInHand_aspx_01;
                            sPath = sPath == null ? "Please enter stock" : sPath;

                            string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                            errorMsg = errorMsg == null ? "Alert" : errorMsg;
                            //string sPath = "Inventory\\\\UpdateStockInHand.aspx.cs_23";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MustEntry", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "MustEntry", "javascript:alert('Please enter stock');", true);
                            txtQty.Focus();
                            txtQty.Font.Bold = true;
                        }
                    }
                }


            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string exp = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Updateing Product.", ex);
               
            }
        }
    }
    string strSuccessfullysaved = Resources.StockManagement_ClientDisplay.StockManagement_UpdateStockInHand_aspx_01;

    private List<InventoryItemsBasket> GetINVProductList()
    {
        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
        int flag = 0;
        int flagforEmptyBox = 0;
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket item = new InventoryItemsBasket();
            HiddenField ProductName = (HiddenField)row.FindControl("hdnProductName");
            HiddenField ProductId = (HiddenField)row.FindControl("hdnProductId");
            HiddenField CategoryId = (HiddenField)row.FindControl("hdnCategoryId");
            HiddenField ID = (HiddenField)row.FindControl("hdnRid");

            TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
            Label txtBatchNo = (Label)row.FindControl("txtBatchNo");

            HiddenField hdnDescription = (HiddenField)row.FindControl("hdnDescription");
            item.ProductName = ProductName.Value;
            item.ID = Int64.Parse(ID.Value);

            item.BatchNo = txtBatchNo.Text;
            item.RECQuantity = decimal.Parse((txtQuantity.Text == "") ? "0" : txtQuantity.Text);

            item.CategoryID = int.Parse(CategoryId.Value);
            item.ProductID = Int64.Parse(ProductId.Value);
            item.Description = hdnDescription.Value;

            Button btnSave = (Button)row.FindControl("btnSave");
            TextBox txtQty = (TextBox)row.FindControl("txtQuantity");
            HiddenField hdnIHQ = (HiddenField)row.FindControl("hdnInHandQuantity");
            if (txtQty.Text != "")
            {
                lstInventory.Add(item);
                txtQty.Font.Bold = false;
            }
            else
            {
                flagforEmptyBox = flagforEmptyBox - 1;
                lblMessage.Text = string.Empty;
                string sPath = Resources.StockManagement_AppMsg.StockManagement_UpdateStockInHand_aspx_01;
                sPath = sPath == null ? "Please enter stock" : sPath;

                string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                errorMsg = errorMsg == null ? "Alert" : errorMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "MustEntry", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                txtQty.Focus();
                txtQty.Font.Bold = true;
                lstInventory.Clear();
            }
            if (flagforEmptyBox != 0)
            {
                lstInventory.Clear();
            }
            else if (flag != 0)
            {
                lstInventory.Clear();
            }
        }
        return lstInventory;
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string strMon = string.Empty;
        string strYear = string.Empty;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket inv = new InventoryItemsBasket();
            inv = (InventoryItemsBasket)e.Row.DataItem;
            Button btnAddMore = (Button)e.Row.FindControl("btnAddMore");

            Button btnSave = (Button)e.Row.FindControl("btnSave");
            HiddenField hdnDescription = (HiddenField)e.Row.FindControl("hdnDescription");
            btnSave.CommandArgument = inv.ID.ToString();
            hdnDescription.Value = inv.ProductID + "~" + inv.BatchNo;
        }
    }

    private void loadInventoryUOM(DropDownList ddlBoxU, string SelectedText)
    {
        try
        {
            if (lstInventoryUOM.Count == 0)
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
          //  ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
            ddlBoxU.Items[0].Value = "0";
            if (SelectedText != "")
            {
                ddlBoxU.SelectedItem.Text = SelectedText;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Units.", ex);
           
        }

    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            btnUpdate_Click(sender, e);
            grdResult.PageIndex = e.NewPageIndex;
            BindProductList();
        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<InventoryItemsBasket> lstInventory = GetINVProductList();
            if (lstInventory.Count > 0)
            {
                DataTable objDataTable = new DataTable();
                objDataTable = BindProductList(lstInventory, getTable());
                returnCode = new InventoryCommon_BL(base.ContextInfo).UpdateStockInHand(OrgID, ILocationID, InventoryLocationID, LID, objDataTable);
                //string obj = Resources.StockManagement_ClientDisplay.StockManagement_UpdateStockInHand_aspx_01;
                //lblMessage.Text = obj;
                string sPath = Resources.StockManagement_AppMsg.StockManagement_UpdateStockInHand_aspx_04;
                sPath = sPath == null ? "Successfully saved" : sPath;

                string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                errorMsg = errorMsg == null ? "Alert" : errorMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "MustEntry", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                BindProductList();
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updateing Product.", ex);
           
        }
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
        basket.Columns.Add("ActualPrice");
        basket.Columns.Add("EligibleAmount");
        basket.Columns.Add("ClientFeeTypeRateCustID");
        basket.Columns.Add("InvoiceDate");
        basket.Columns.Add("StockStatus");
        basket.Columns.Add("DefectiveQty");
        basket.Columns.Add("Comments");
        basket.Columns.Add("Shortage");
        basket.Columns.Add("Damage");
        basket.Columns.Add("Rejected");
        basket.Columns.Add("PrepareCharges");
        basket.Columns.Add("ProductCode");
        basket.Columns.Add("CopayValue");
        basket.Columns.Add("CopayType");
        basket.Columns.Add("GenericName");




        return basket;
    }

    private DataTable BindProductList(List<InventoryItemsBasket> lstInventory, DataTable objDataTable)
    {
        DataRow dr;
        //DataTable dt = new DataTable();
        foreach (InventoryItemsBasket IIB in lstInventory)
        {
            dr = objDataTable.NewRow();
            dr["Quantity"] = IIB.RECQuantity;// ((TextBox)row.FindControl("txtQuantity")).Text;
            dr["ProductID"] = 0;
            dr["CategoryID"] = 0;
            dr["CategoryName"] = 0;
            dr["ProductName"] = 0;
            dr["ComplimentQTY"] = 0;
            dr["Tax"] = 0;
            dr["Discount"] = 0;
            dr["Rate"] = 0;
            dr["UOMID"] = 0;
            dr["Unit"] = 0;
            dr["UnitPrice"] = 0;
            dr["LSUnit"] = 0;
            dr["Description"] = 0;
            dr["ExpiryDate"] = Convert.ToDateTime("01/01/1901"); ;
            dr["Manufacture"] = Convert.ToDateTime("01/01/1901"); ;
            dr["BatchNo"] = IIB.BatchNo;// ((Label)row.FindControl("txtBatchNo")).Text;
            dr["Providedby"] = 0;
            dr["Type"] = "N";
            dr["Amount"] = 0;
            dr["ID"] = IIB.ID;// ((HiddenField)row.FindControl("hdnRid")).Value;
            dr["POQuantity"] = 0;
            dr["POUnit"] = 0;
            dr["RECQuantity"] = 0;
            dr["RECUnit"] = 0;
            dr["SellingUnit"] = 0;
            dr["InvoiceQty"] = 0;
            dr["RcvdLSUQty"] = 0;
            dr["AttributeDetail"] = "N";
            dr["HasExpiryDate"] = "";
            dr["HasBatchNo"] = "";
            dr["HasUsage"] = "";
            dr["UsageCount"] = "";
            dr["RakNo"] = "";
            dr["MRP"] = 0;
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
            dr["ActualPrice"] = 0;
            dr["EligibleAmount"] = "0";
            dr["ClientFeeTypeRateCustID"] = "0";
            dr["InvoiceDate"] = DateTime.MaxValue;
            dr["StockStatus"] = "0";
            dr["DefectiveQty"] = "0";
            dr["Comments"] = "";
            dr["Shortage"] = "0";
            dr["Damage"] = "0";
            dr["Rejected"] = "0";
            dr["PrepareCharges"] = "0";
            dr["ProductCode"] = "";
            dr["CopayValue"] = "0";
            dr["CopayType"] = "";
            dr["GenericName"] = "";
            objDataTable.Rows.Add(dr);

        }
        return objDataTable;
    }
}
