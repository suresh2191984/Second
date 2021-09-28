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
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.InventoryCommon;

public partial class StockManagement_INVBulkUpdate : Attune_BasePage
{
    public StockManagement_INVBulkUpdate()
        : base("StockManagement_INVBulkUpdate_aspx")
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
    // DataTable objDataTable;
    ArrayList alYear = new ArrayList();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        LoadYearToArray();

        if (!IsPostBack)
        {
            int dummyyear = 0;
            loadYear(ddlproExpYear, dummyyear);
            inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
            LoadCategory(ddlproCategory, lstProductCategories);
            LoadCategory(ddlCategory, lstProductCategories);
            loadInventoryUOM(ddlproUnit, "");
            BindProductType();
            List<Locations> lstLocation = new List<Locations>();
            inventoryBL.GetLocationTypeCheck(OrgID, ILocationID, InventoryLocationID, out lstLocation);
            if (lstLocation.Count > 0)
            {
                if (lstLocation[0].LocationTypeCode.ToString() == "CS-POS" || lstLocation[0].LocationTypeCode.ToString() == "CS")
                {
                    tdidNewProduct.Attributes.Add("class", "hide");
                }
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                hdnIsSellingPriceRuleApply.Value = lstInventoryConfig[0].ConfigValue;
            }
            LoadSellingPriceRule();

        }
        string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
        if (HideTaxOpbilling == "Y")
        {

            grdResult.Columns[10].Visible = false;
        }
        if (txtProduct.Text != "" && hdnUpdate.Value == "Update")
        {
            BindProductList();
        }
        string HideTaxpercen = GetConfigValue("IsMiddleEast", OrgID);
        if (HideTaxpercen == "Y")
        {
            hdnHideTaxpercen.Value = "Y";

        }
        else
        {
            hdnHideTaxpercen.Value = "N";
        }
       
            string HideTax = GetConfigValue("IsMiddleEast", OrgID);
            if (!string.IsNullOrEmpty(HideTax))
            {
                if (HideTax == "Y")
                {

                    tdTaxperc.Attributes.Add("class", "hide");
                    tdprotax.Attributes.Add("class", "hide");
                    tdTxtRemarks.Attributes.Add("class", "hide");
                    btnAddProduct.Attributes.Add("class", "hide;"); //Dharanesh for Vasan Hide AddnewProducts Button//  
                }
                else
                {
                    btnAddProduct.Attributes.Add("style", "show;"); //Dharanesh for Vasan Hide AddnewProducts Button//  
                }
            }
            btnAddProduct.Attributes.Add("class", "hide;"); //Dharanesh for Vasan Hide AddnewProducts Button//              
     }
    private void BindProductType()
    {
        List<ProductType> lstProductType = new List<ProductType>();

        new InventoryCommon_BL(ContextInfo).GetProductType(OrgID, out lstProductType);
        ddlType.DataSource = lstProductType.FindAll(P => P.IsActive.ToUpper() == "YES").ToList();
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "TypeID";
        ddlType.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlType.Items.Insert(0, ddlselect);
       // ddlType.Items.Insert(0, "--Select Type--");
        ddlType.Items[0].Value = "0";
    }

    private void LoadCategory(DropDownList ddl, List<ProductCategories> lstProductCategories)
    {
        ddl.DataSource = lstProductCategories;
        ddl.DataTextField = "CategoryName";
        ddl.DataValueField = "CategoryID";
        ddl.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddl.Items.Insert(0, ddlselect);
      //  ddl.Items.Insert(0, "--Select category--");
        ddl.Items[0].Value = "0";
    }

    private void LoadYearToArray()
    {
        int iYear = DateTimeNow.Year;
        int iPrevYear = 0;
        int iNxtYear = 0;
        for (int i = 1; i <= 11; i++)
        {
            iPrevYear = iYear - i;
            iNxtYear = iYear + i;
            alYear.Add(iPrevYear);
            alYear.Add(iNxtYear);
        }
        alYear.Add(iYear);
        alYear.Sort();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<InventoryItemsBasket> lstInventory = GetINVProductList();
            List<InventoryItemsBasket> lst = (from S in lstInventory
                                              group S by new { S.ProductID, S.BatchNo, S.ExpiryDate, S.RECUnit, S.UnitPrice, S.Rate } into g
                                              select new InventoryItemsBasket
                                              {
                                                  ProductID = g.Key.ProductID,
                                                  BatchNo = g.Key.BatchNo,
                                                  ExpiryDate = g.Key.ExpiryDate,
                                                  SellingUnit = g.Key.RECUnit,
                                                  CostPrice = g.Key.UnitPrice,
                                                  SellingPrice = g.Key.Rate,
                                                  ID = g.Count()
                                              }).Distinct().ToList();





            //if (lst.Exists(p => p.ID > 1))
            //{
                //string sPath = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_08;
                //sPath = sPath == null ? "Product combination already exist" : sPath;

                //string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                //errorMsg = errorMsg == null ? "Alert" : errorMsg;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mmcc", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
            //}
            //else
            //{
                returnCode = new InventoryCommon_BL(base.ContextInfo).UpdateBulkProductListDetails(lstInventory, OrgID, ILocationID, LID, InventoryLocationID, txtRemarks.Text);
                
                //string sPath = "StockManagement_INVBulkUpdate_aspx_05";
                string sPath = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_05;
                sPath = sPath == null ? "Successfully Updated" : sPath;

                string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Information;
                errorMsg = errorMsg == null ? "Information" : errorMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                btnSearch_Click(sender, e);
                //btnUpdate.Style.Add("display", "block");
            //}
          
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Product.", ex);
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
            dr["Rate"] = ((TextBox)row.FindControl("txtSellingPrice")).Text.Trim();
            dr["UOMID"] = 0;
            dr["Unit"] = ((DropDownList)row.FindControl("ddlUnit")).SelectedItem.Text;
            dr["UnitPrice"] = ((TextBox)row.FindControl("txtUnitPrice")).Text;
            dr["LSUnit"] = 0;
            dr["Description"] = 0;
            dr["ExpiryDate"] = ((TextBox)row.FindControl("txtExpiryDate")).Text;
            dr["Manufacture"] = DateTimeNow;
            dr["BatchNo"] = ((TextBox)row.FindControl("txtBatchNo")).Text.Trim();
            dr["Providedby"] = ((HiddenField)row.FindControl("hdnprovidedby")).Value;
            dr["Type"] = "N";
            dr["Amount"] = 0;
            dr["ID"] = ((HiddenField)row.FindControl("hdnRid")).Value;
            dr["POQuantity"] = 0;
            dr["POUnit"] = 0;
            dr["RECQuantity"] = ((TextBox)row.FindControl("txtQuantity")).Text;
            dr["RECUnit"] = ((DropDownList)row.FindControl("ddlUnit")).SelectedItem.Text;
            dr["SellingUnit"] = 0;
            dr["InvoiceQty"] = 0;
            dr["RcvdLSUQty"] = 0;
            dr["AttributeDetail"] = "N";
            dr["HasExpiryDate"] = "";
            dr["HasBatchNo"] = "";
            dr["HasUsage"] = "";
            dr["UsageCount"] = "";
            dr["RakNo"] = ((TextBox)row.FindControl("txtRakNo")).Text.Trim();
            dr["MRP"] = 0;
            dr["InHandQuantity"] = 0;
            dr["ExciseTax"] = 0;
            dr["DiscOrEnhancePercent"] = 0;
            dr["DiscOrEnhanceType"] = "";
            dr["Remarks"] = ((TextBox)row.FindControl("txtPrdtRemarks")).Text.Trim();
            dr["ProductKey"] = "";
            dr["UnitSellingPrice"] = 0;
            dr["UnitCostPrice"] = 0;
            dr["ReceivedOrgID"] = 0;
            dr["ParentProductID"] = 0;
            dr["ReceivedOrgAddID"] = 0;
            dr["ParentProductKey"] = "";
            dr["GenericName"] = "0";
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
        basket.Columns.Add("GenericName");
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
        string strMon = string.Empty;
        string strYear = string.Empty;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket inv = new InventoryItemsBasket();
            inv = (InventoryItemsBasket)e.Row.DataItem;
            DropDownList ddlUnit = (DropDownList)e.Row.FindControl("ddlUnit");
            LinkButton btnAddMore = (LinkButton)e.Row.FindControl("btnAddMore");
            LinkButton btnSave = (LinkButton)e.Row.FindControl("btnSave");
            HiddenField hdnDescription = (HiddenField)e.Row.FindControl("hdnDescription");
            DropDownList ddlEYear = (DropDownList)e.Row.FindControl("ddlExpYear");
            DropDownList ddlExpMon = (DropDownList)e.Row.FindControl("ddlExpMonth");
            DropDownList ddlExpYr = (DropDownList)e.Row.FindControl("ddlExpYear");
            loadYear(ddlEYear, inv.ExpiryDate.Year);
            if (inv.ExpiryDate.Year < 1950  && inv.ExpiryDate.Year != 1901)
            {
                //TextBox tbExpDt = (TextBox)(e.Row.Cells[3].FindControl("txtExpiryDate"));
                //tbExpDt.Text = "";
                ddlExpMon.SelectedIndex = 0;
                ddlExpYr.SelectedIndex = 0;
            }
            else
            {
                strMon = inv.ExpiryDate.Month.ToString();
                strYear = inv.ExpiryDate.Year.ToString();
                ddlExpMon.SelectedValue = strMon;
                ddlExpYr.SelectedValue = strYear;
            }
            loadInventoryUOM(ddlUnit, inv.RECUnit);
            string strScript = "ProductsListPopup('" + inv.ProductName + "','" + inv.CategoryName + "')";
            btnAddMore.OnClientClick = "return " + strScript + ";";
            btnSave.CommandArgument = inv.ProductID + "~" + inv.ProductKey;

            string strbtnsave = "fu_save('" + btnSave.ClientID + "')";
            btnSave.OnClientClick = "return " + strbtnsave + ";";
            hdnDescription.Value = inv.ProductID + "~" + inv.ProductKey;
        }
    }

    private void loadYear(DropDownList ddltemp,int year)
    {
        ListItem li;
        for (int i = 0; i < alYear.Count; i++)
        {
            li = new ListItem(alYear[i].ToString());
            ddltemp.Items.Add(li);
        }
		 if (ddltemp.SelectedValue.ToString() != "")
        {
            ddlproExpYear.SelectedValue =Convert.ToString(alYear[0]);
        }
        ddltemp.DataSource = alYear;
        ddltemp.DataBind();
        ddltemp.Items.Insert(0, new ListItem("YYYY", "-1"));
        if (year == 1901)
        {
            ddltemp.Items.Insert(1, new ListItem("1901", "1901"));
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
        //    ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (listSearch.SelectedItem != null)
        {
            txtProduct.Text = listSearch.SelectedItem.Text;
        }
        btnUpdate.Visible = true;
        btnCancel.Visible = true;
        BindProductList();

        if (Request.QueryString["ispopup"] != null)
        {
            btnCancel.Visible = false;
        }
    }

    private void BindProductList()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        if (Convert.ToInt32(ddlCategory.SelectedValue) > 0)
        {
            Session["CategoryID_INVBulkUpdate"] = ddlCategory.SelectedValue;
        }
        else
        {
            Session["CategoryID_INVBulkUpdate"] = 0;
        }
        StockManagement_BL stockBL = new StockManagement_BL(base.ContextInfo);
        stockBL.GetProductListByCategoryGenericName(OrgID, ILocationID, InventoryLocationID, int.Parse(ddlCategory.SelectedValue), txtGenericName2.Text, txtProduct.Text.Trim(), out lstInventoryItemsBasket);
        grdResult.DataSource = lstInventoryItemsBasket;
        grdResult.DataBind();
        if (lstInventoryItemsBasket.Count > 0)
        {
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
            dvRemarks.Visible = false;
            tdExcel.Attributes.Add("class", "a-right");
        }
        else
        {
            dvRemarks.Visible = false;
            tdExcel.Attributes.Add("class", "hide");

        }
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

    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    string objTax = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_20;
    string objErr = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_02;
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "INVSave")
        {
            try
            {
                GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                TextBox myTextBox = row.FindControl("txtQuantity") as TextBox;
                TextBox txtCPTB = row.FindControl("txtUnitPrice") as TextBox;
                TextBox txtSPTB = row.FindControl("txtSellingPrice") as TextBox;
                TextBox txtTax = row.FindControl("txtTax") as TextBox;
                double CP = double.Parse(txtCPTB.Text);
                double SP = double.Parse(txtSPTB.Text);
                string hidetaxvasan = GetConfigValue("IsMiddleEast", OrgID);
                if (hidetaxvasan == "Y")
                    txtTax.Text = "0";
                double taxValue = double.Parse(txtTax.Text);
                double TxtQty = double.Parse(myTextBox.Text);

                List<InventoryItemsBasket> lstInventory = GetINVProductList();

                //if (taxValue == 0.00)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "javascript:alert('Provide Tax');", true);
                //}

                if (CP > SP)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "ValidationWindow('"+objCostPrice+"','"+objError+"');", true);
                }
                else
                {
                    lstInventory.RemoveAll(P => P.Description != e.CommandArgument.ToString());
                    new InventoryCommon_BL(base.ContextInfo).UpdateBulkProductListDetails(lstInventory, OrgID, ILocationID, LID, InventoryLocationID, txtRemarks.Text);
                    //string sPath = "StockManagement_INVBulkUpdate_aspx_06";
                    string sPath = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_06;
                    sPath = sPath == null ? "Successfully saved" : sPath;

                    string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                    errorMsg = errorMsg == null ? "Alert" : errorMsg;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                    btnSearch_Click(sender, e);

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
    string objCostPrice = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_21 == null ? "CostPrice cannot be Greaterthan SellingPrice" : Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_21;
    string objError = Resources.StockManagement_AppMsg.StockManagement_Error == null ? "Alert" : Resources.StockManagement_AppMsg.StockManagement_Error;
    private List<InventoryItemsBasket> GetINVProductList()
    {
        string strMon = string.Empty;
        string strYear = string.Empty;

        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket item = new InventoryItemsBasket();
            HiddenField ProductName = (HiddenField)row.FindControl("hdnProductName");
            HiddenField ProductId = (HiddenField)row.FindControl("hdnProductId");

            HiddenField ID = (HiddenField)row.FindControl("hdnRid");
            TextBox txtSellingPrice = (TextBox)row.FindControl("txtSellingPrice");
            TextBox txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
            HiddenField CategoryId = (HiddenField)row.FindControl("hdnCategoryId");
            //TextBox txtExpiryDate = (TextBox)row.FindControl("txtExpiryDate");
            DropDownList ddlExpMon = (DropDownList)row.FindControl("ddlExpMonth");
            DropDownList ddlExpYr = (DropDownList)row.FindControl("ddlExpYear");
            TextBox txtBatchNo = (TextBox)row.FindControl("txtBatchNo");
            DropDownList ddlUnit = (DropDownList)row.FindControl("ddlUnit");
            HiddenField hdnDescription = (HiddenField)row.FindControl("hdnDescription");
            TextBox txtProdTax = (TextBox)row.FindControl("txtTax");
            TextBox txtRakNo = (TextBox)row.FindControl("txtRakNo");
            TextBox txtPrdtRemarks = (TextBox)row.FindControl("txtPrdtRemarks");
            /*Added by petchi*/
            TextBox txtProductCode = (TextBox)row.FindControl("txtproductcode");
            HiddenField phdnPdtRcvdDtlsID = (HiddenField)row.FindControl("hdnPdtRcvdDtlsID");
            item.productCode = txtProductCode.Text.Trim();
            item.Remarks = txtPrdtRemarks.Text.Trim();
            item.RakNo = txtRakNo.Text.Trim();
            item.ProductName = ProductName.Value;
            item.ID = Int64.Parse(ID.Value);
            item.Manufacture = Convert.ToDateTime("01/01/1753");
            if (ddlExpMon.SelectedItem.Value != "-1" && ddlExpYr.SelectedItem.Value != "-1")
            {
                    //item.ExpiryDate = Convert.ToDateTime("01/01/1901");
                    strMon = ddlExpMon.SelectedItem.Text;
                    strYear = ddlExpYr.SelectedItem.Text;
                    string strDate = "01 -" + strMon + "- " + strYear;
                    item.ExpiryDate = DateTime.Parse(strDate);
            }
            else
            {
                item.ExpiryDate = Convert.ToDateTime("01/01/1753");
            }
            item.BatchNo = txtBatchNo.Text.Trim();
            item.RECQuantity = decimal.Parse(txtQuantity.Text);
            item.RECUnit = ddlUnit.SelectedItem.Text;
            item.UnitPrice = decimal.Parse(txtUnitPrice.Text);
            item.Rate = decimal.Parse(txtSellingPrice.Text);
            item.CategoryID = int.Parse(CategoryId.Value);
            item.ProductID = Int64.Parse(ProductId.Value);
            string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
            if (HideTaxOpbilling == "Y")
                txtProdTax.Text = "0";
            item.Tax = decimal.Parse(txtProdTax.Text);
            item.Description = hdnDescription.Value;
            item.MRP = 0;
            item.ProductReceivedDetailsID = Convert.ToInt64(phdnPdtRcvdDtlsID.Value);
            string ProductKey = string.Empty;
            string CurrentCulture = string.Empty;
            CurrentCulture = CultureInfo.CurrentCulture.Name;
            double CP = double.Parse(txtUnitPrice.Text);
            double SP = double.Parse(txtSellingPrice.Text);
            double Qty = double.Parse(txtQuantity.Text);
            double tTax = double.Parse(txtProdTax.Text);

            //if (CurrentCulture != "en-GB")
            //{

            //    Attune_InventoryProductKey.GenerateProductKey(item.ProductID, item.BatchNo, item.ExpiryDate, item.UnitPrice, item.Rate, item.RECUnit, CurrentCulture, out ProductKey);
            //    if (ProductKey != "")
            //    {
            //        item.ProductKey = ProductKey;
            //    }
            //}
            //else
            //{
            //    item.ProductKey = item.ProductID + "@#$" + item.BatchNo + "@#$" + item.ExpiryDate.ToString("MMM/yyyy")
            //    + "@#$" + String.Format("{0:0.000000}", item.UnitPrice) + "@#$" + String.Format("{0:0.000000}", item.Rate) + "@#$" + item.RECUnit;
            //}


            if (CP > SP)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "ValidationWindow('"+objCostPrice+"','"+objError+"');", true);
            }
            //else if (tTax == 0.00 ) {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "javascript:alert('Provide Tax');", true);
            //}
            else
            {
                lstInventory.Add(item);
            }
        }
        return lstInventory;
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Products.aspx", true);
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

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            btnUpdate_Click(sender, e);
            grdResult.PageIndex = e.NewPageIndex;
            BindProductList();
        }
    }

    private List<InventoryItemsBasket> INVbasket()
    {
        List<InventoryItemsBasket> INVProbasket = new List<InventoryItemsBasket>();
        InventoryItemsBasket basket = new InventoryItemsBasket();
        string strMon = string.Empty;
        string strYear = string.Empty;
        try
        {
            basket.CategoryID = int.Parse(ddlproCategory.SelectedValue);
            basket.ProductName = txtproProduct.Text.Trim();
            basket.Quantity = decimal.Parse(txtproQuantity.Text);
            basket.Tax = decimal.Parse(txtproTax.Text);
            basket.Rate = decimal.Parse(txtproSellingPrice.Text);
            basket.UnitPrice = decimal.Parse(txtproUnitPrice.Text);
            basket.Unit = ddlproUnit.SelectedItem.Text;
            basket.UOMID = int.Parse(ddlType.SelectedValue);
            basket.Manufacture = Convert.ToDateTime("01/01/1753");
            if (ddlproExpMonth.SelectedItem.Value != "-1" && ddlproExpYear.SelectedItem.Text != "YYYY")
            {
                strMon = ddlproExpMonth.SelectedItem.Text;
                strYear = ddlproExpYear.SelectedItem.Text;
                string strDate = "01 -" + strMon + "- " + strYear;
                basket.ExpiryDate = DateTime.Parse(strDate);
                basket.Type = "Y";
            }
            else
            {
                basket.Type = "N";
                //if (1901)
                //{ expirydate = 1901}
                basket.ExpiryDate = Convert.ToDateTime("01/01/1753");
            }
            if (txtproBatchNo.Text.Trim() != "")
            {
                basket.RECUnit = "Y";
                basket.BatchNo = txtproBatchNo.Text.Trim();
            }
            else
            {
                basket.RECUnit = "N";
                basket.BatchNo = "*";
            }
            basket.RakNo = txtRakNo.Text.Trim();
            basket.MRP = 0;
            if (txtGenericName.Text.Trim() != "")
            {
                basket.parentProductID = Convert.ToInt64(hdnGenericID.Value); //GenericID
            }
            else
            {
                basket.parentProductID = 0; // GenericID
            }
            basket.Remarks = txtPrdtRemarks.Text;
            INVProbasket.Add(basket);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL lstInventoryItemsBasket", ex);
        }

        return INVProbasket;
    }

    protected void btnAddNewProduct_Click(object sender, EventArgs e)
    {
        List<InventoryItemsBasket> INVProbasket = new List<InventoryItemsBasket>();
        StockManagement_BL stockBL = new StockManagement_BL(base.ContextInfo);
        long returnCode = -1;
        try
        {
            INVProbasket = INVbasket();
            returnCode = stockBL.SaveNewProduct(OrgID, ILocationID, InventoryLocationID, LID, INVProbasket);
            if (returnCode != -1)
            {
               // string sPath = "StockManagement_INVBulkUpdate_aspx_07";
                string sPath = Resources.StockManagement_AppMsg.StockManagement_INVBulkUpdate_aspx_07;
                sPath = sPath == null ? "Product Added Successfully" : sPath;

                string errorMsg = Resources.StockManagement_AppMsg.StockManagement_Error;
                errorMsg = errorMsg == null ? "Alert" : errorMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm", "ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
                txtproUnitPrice.Text = string.Empty;
                txtRakNo.Text = string.Empty;
                txtproBatchNo.Text = string.Empty;
                txtproProduct.Text = string.Empty;
                txtPrdtRemarks.Text = string.Empty;
            }
            else
            {
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Add Product", ex);
        }
    }

    protected void LoadSellingPriceRule()
    {
        long returnCode = -1;
        List<SellingPriceRuleMaster> lstSellingPriceRuleMaster = new List<SellingPriceRuleMaster>();
        List<SellingPriceRuleLocationMapping> lstSellingPriceRuleLocationMapping = new List<SellingPriceRuleLocationMapping>();
        returnCode = inventoryBL.getSellingPriceRuleMaster(OrgID, ILocationID, InventoryLocationID, out lstSellingPriceRuleMaster, out lstSellingPriceRuleLocationMapping);


        if (lstSellingPriceRuleMaster.Count > 0)
        {

            foreach (var Item in lstSellingPriceRuleMaster)
            {
                hdnSellingPrieRuleList.Value += Item.Description + "^";
            }

        }

    }
    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {

            BindProductList();
            ExportToExcel();

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public DataTable loadInvBasket(List<InventoryItemsBasket> lstInvItemBasket)
    {
        DataTable dt = new DataTable();

        DataColumn dcol1 = new DataColumn("Generic Name");
        DataColumn dcol2 = new DataColumn("Category Name");
        DataColumn dcol3 = new DataColumn("Product");
        DataColumn dcol4 = new DataColumn("Product Code");
        DataColumn dcol5 = new DataColumn("Batch Number");
        DataColumn dcol6 = new DataColumn("EXP Date");
        DataColumn dcol7 = new DataColumn("InHand Qty");
        DataColumn dcol8 = new DataColumn("Units(LSU)");
        DataColumn dcol9 = new DataColumn("Cost Price");
        DataColumn dcol10 = new DataColumn("Selling Price");
        DataColumn dcol11 = new DataColumn("Tax(%)");
        DataColumn dcol12 = new DataColumn("Rack Number");
        DataColumn dcol13 = new DataColumn("Remarks");
        

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        foreach (InventoryItemsBasket item in lstInvItemBasket)
        {
            DataRow dr = dt.NewRow();

            dr["Generic Name"] = item.GenericName;
            dr["Category Name"] = item.CategoryName;
            dr["Product"] = item.ProductName;
            dr["Product Code"] = item.ProductCode;
            dr["Batch Number"] = item.BatchNo;
            dr["EXP Date"] = item.ExpiryDate;
            dr["InHand Qty"] = item.InHandQuantity;
            dr["Units(LSU)"] = item.RECUnit;
            dr["Cost Price"] =String.Format("{0:0.000000}", item.UnitPrice);
            dr["Selling Price"] = String.Format("{0:0.000000}", item.Rate);
            dr["Tax(%)"] = item.Tax;
            dr["Rack Number"] = item.RakNo;
            dr["Remarks"] = item.Remarks;
            dt.Rows.Add(dr);

        }
        ViewState["report"] = dt;
        return dt;
    }
    public void ExportToExcel()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        StockManagement_BL stockBL = new StockManagement_BL(base.ContextInfo);
        stockBL.GetProductListByCategoryGenericName(OrgID, ILocationID, InventoryLocationID, int.Parse(ddlCategory.SelectedValue), txtGenericName2.Text, txtProduct.Text.Trim(), out lstInventoryItemsBasket);
        DataTable dt = new DataTable();
        dt = loadInvBasket(lstInventoryItemsBasket);
        Response.ClearContent();
        string dtDate = DateTimeNow.ToExternalDate();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Inventory_ManageMent_" + dtDate));
        this.EnableViewState = false;
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        GridView grdnew = new GridView();
        grdnew.DataSource = dt;
        grdnew.DataBind();
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        grdnew.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
}
