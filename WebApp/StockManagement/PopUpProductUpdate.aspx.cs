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
using System.Linq;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryCommon;

public partial class StockManagement_PopUpProductUpdate : Attune_BasePage
{
    public StockManagement_PopUpProductUpdate()
        : base("StockManagement_PopUpProductUpdate_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string values = "";
    string Cname = "";
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    public string strType { get; set; }
    ArrayList alYear = new ArrayList();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    #region
    string strtask = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_02 == null ? "Not able to perform this task" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_02;
    string strInHandQty = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_03 == null ? "Provide InHandQty" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_03;
    string strTax = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_04 == null ? "Provide Tax" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_04;
    string strCostPrice = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_05 == null ? "CostPrice cannot be Greaterthan SellingPrice" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_05;
    string strProduct = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_06 == null ? "Product batch combination already exist" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_06;
    string strBatchNo = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_07 == null ? "Please Enter Batch No., etc" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_07;
    string strAlert = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_08 == null ? "Batch numbers not entered for some of the rows. These rows will not be saved. " : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_08;
    string strDateAlert = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_09 == null ? "Please Enter The Exp Date" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_09;
    string strerror = Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_10 == null ? "Alert" : Resources.StockManagement_ClientDisplay.StockManagement_PopUpProductUpdate_aspx_10;
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadYearToArray();
        if (!IsPostBack)
        {
            values = Request.QueryString["val"];
            List<InventoryItemsBasket> lstInventory = BindProductList(values);
            // LoadInventoryItems(lstInventory);
            Cname = Request.QueryString["Cname"];
            List<InventoryItemsBasket> lstInventorywithcname = lstInventory.FindAll(P => P.CategoryName == Cname).ToList();
            AddEmptyRow(lstInventorywithcname);
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                hdnIsSellingPriceRuleApply.Value = lstInventoryConfig[0].ConfigValue;
            }
            LoadSellingPriceRule();
            
        }
    }
 
    private void LoadYearToArray()
    {
        int iYear = DateTimeNow.Year;
        int iPrevYear = 0;
        int iNxtYear = 0;
        for (int i = 1; i <= 10; i++)
        {
            iPrevYear = iYear - i;
            iNxtYear = iYear + i;
            alYear.Add(iPrevYear);
            alYear.Add(iNxtYear);
        }

        alYear.Add(iYear);

        alYear.Sort();

    }

    private void LoadInventoryItems(List<InventoryItemsBasket> lstInventory)
    {

        int CategoryID_INVBulkUpdate = Convert.ToInt32(Session["CategoryID_INVBulkUpdate"].ToString());
        if (CategoryID_INVBulkUpdate > 0)
        {
            var temp = from s in lstInventory
                       orderby s.BatchNo descending
                       where s.CategoryID == CategoryID_INVBulkUpdate
                       select s;
            grdResult.DataSource = temp;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = lstInventory;
            grdResult.DataBind();
        }
        
    }

    private List<InventoryItemsBasket> BindProductList(string values)
    {
        //long retCode = -1;

        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
        InventoryItemsBasket item = new InventoryItemsBasket();
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        if (values == "")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:ValidationWindow('" + strtask + "','" + strerror + "');", true);
        }
        else
        {
            try
            {
                inventoryBL.GetProductListByCategory(OrgID, ILocationID, InventoryLocationID, 0, "", values, out lstInventory);
                //retCode = inventoryBL.GetStockDtlsByProductName(OrgID, ILocationID, InventoryLocationID, values, out lstInventory);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error getting product details (PopUpProductUpdate.aspx)", ex);
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
            DropDownList ddlUnit = (DropDownList)e.Row.FindControl("ddlUnit");
            Button btnAddMore = (Button)e.Row.FindControl("btnAddMore");
            loadInventoryUOM(ddlUnit, inv.RECUnit);
            LinkButton lbtnDelete = (LinkButton)e.Row.FindControl("lbtnDelete");
            LinkButton lbtnAdd = (LinkButton)e.Row.FindControl("lbtnAdd");
            lbtnDelete.CommandName = inv.ProductID + "~" + inv.BatchNo + "~" + e.Row.RowIndex;
            lbtnAdd.CommandName = inv.ProductID + "~" + inv.BatchNo;

            HiddenField ID = (HiddenField)e.Row.Cells[7].FindControl("hdnRid");
            if (ID.Value != "0")
            {
                //lbtnDelete.Visible = false;
                lbtnDelete.Attributes.Add("class", "hide");

            }
            //if (inv.Manufacture.Year < 1950)
            //{
            //    //TextBox tbMftDt = (TextBox)(e.Row.Cells[2].FindControl("txtManufacture"));
            //    //tbMftDt.Text = "";

            //}
            //else
            //{
            //    strMon = inv.Manufacture.Month.ToString();
            //    strYear = inv.Manufacture.Year.ToString();

            //}
            DropDownList ddlEYear = (DropDownList)e.Row.FindControl("ddlExpYear");
            DropDownList ddlExpMon = (DropDownList)e.Row.FindControl("ddlExpMonth");
            DropDownList ddlExpYr = (DropDownList)e.Row.FindControl("ddlExpYear");
            loadYear(ddlEYear);
            List<MetaData> lstMetadata = GetMetaData("Months");
            if (lstMetadata.Count > 0)
            {

                ddlExpMon.DataSource = lstMetadata;
                ddlExpMon.DataTextField = "DisplayText";
                ddlExpMon.DataValueField = "Code";
                ddlExpMon.DataBind();
                ListItem ddlselect = GetMetaData("MMM", "-1");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "MMM", Value = "-1" };
                }
                ddlExpMon.Items.Insert(-1, ddlselect);
            }
            if (inv.ExpiryDate.Year < 1950)
            {
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
        }
    }
    protected void LoadMonths()
    {
       
    }
    private void loadYear(DropDownList ddltemp)
    {
        ListItem li;
        for (int i = 0; i < alYear.Count; i++)
        {
            li = new ListItem(alYear[i].ToString(), alYear[i].ToString());
            ddltemp.Items.Add(li);
        }
        ddltemp.Items.Insert(0, new ListItem("YYYY", "-1"));
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

    private void AddEmptyRow(List<InventoryItemsBasket> lstInventory)
    {
        GetINVList(lstInventory, "L");
        InventoryItemsBasket item = new InventoryItemsBasket();
        InventoryItemsBasket tempitem = new InventoryItemsBasket();
        item = lstInventory[0];
        if (item != null)
        {
            tempitem.ProductName = item.ProductName;
            //new
            tempitem.CategoryName = item.CategoryName;
            tempitem.RECUnit = item.RECUnit;
            tempitem.UnitPrice = item.UnitPrice;
            tempitem.Rate = item.Rate;
            tempitem.CategoryID = item.CategoryID;
            tempitem.ProductID = item.ProductID;
            lstInventory.Add(tempitem);
        }
        LoadInventoryItems(lstInventory);
        TextBox tb = (TextBox)(grdResult.Rows[grdResult.Rows.Count - 1].Cells[1].FindControl("txtBatchNo"));
        tb.Focus();
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
        if (e.CommandArgument == "INVAdd")
        {
            GetINVList(lstInventory, "A");
            InventoryItemsBasket item = new InventoryItemsBasket();
            InventoryItemsBasket tempitem = new InventoryItemsBasket();
            if (lstInventory.Count > 0)
            {
                item = lstInventory[0];
                GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                TextBox myTextBox = row.FindControl("txtQuantity") as TextBox;
                TextBox txtCPTB = row.FindControl("txtUnitPrice") as TextBox;
                TextBox txtSPTB = row.FindControl("txtSellingPrice") as TextBox;
                TextBox txtTax = row.FindControl("txtTax") as TextBox;
                double CP = double.Parse(txtCPTB.Text);
                double SP = double.Parse(txtSPTB.Text);
                double Qty = double.Parse(myTextBox.Text);
                double Tax1 = double.Parse(txtTax.Text);
                if (item != null)
                {
                    tempitem.ProductName = item.ProductName;
                    tempitem.CategoryName = item.CategoryName;
                    tempitem.ProductCode = item.ProductCode;
                    tempitem.RECQuantity = item.RECQuantity;
                    tempitem.RECUnit = item.RECUnit;
                    tempitem.UnitPrice = item.UnitPrice;
                    tempitem.Rate = item.Rate;
                    tempitem.CategoryID = item.CategoryID;
                    tempitem.ProductID = item.ProductID;
                    lstInventory.Add(tempitem);
                }
                if (Qty == 0.00)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm1", "javascript:ValidationWindow('" + strInHandQty + "','" + strerror + "');", true);
                    TextBox tQty = (TextBox)(grdResult.Rows[grdResult.Rows.Count - 1].Cells[1].FindControl("txtQuantity"));
                    tQty.Focus();
                }
                else if (Tax1 == 0.00)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm2", "javascript:ValidationWindow('" + strTax + "','" + strerror + "');", true);
                    TextBox tTax = (TextBox)(grdResult.Rows[grdResult.Rows.Count - 1].Cells[1].FindControl("txtTax"));
                    tTax.Focus();
                }

                else if (CP > SP)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Mm3", "javascript:ValidationWindow('" + strCostPrice + "','" + strerror + "');", true);
                }
                else
                {
                    LoadInventoryItems(lstInventory);
                }
            }
            TextBox tb = (TextBox)(grdResult.Rows[grdResult.Rows.Count - 1].Cells[1].FindControl("txtBatchNo"));
            tb.Focus();

        }
        if (e.CommandArgument == "INVDetete")
        {
            string[] str = e.CommandName.Split('~');

            int rowindex = Convert.ToInt16(str[2]);
            TextBox txtBatchNo = (TextBox)grdResult.Rows[rowindex].FindControl("txtBatchNo");

            GetINVListDelete(lstInventory);
            lstInventory.RemoveAll(P => P.ProductID.ToString() == str[0] && P.BatchNo == str[1]);

            lstInventory.RemoveAll(P => P.ProductID.ToString() == str[0] && P.BatchNo == txtBatchNo.Text.ToString());

            InventoryItemsBasket item = new InventoryItemsBasket();
            InventoryItemsBasket tempitem = new InventoryItemsBasket();
            if (lstInventory.Count > 0)
            {
                item = lstInventory[0];
                if (item != null)
                {
                    tempitem.ProductName = item.ProductName;
                    tempitem.RECUnit = item.RECUnit;
                    tempitem.UnitPrice = item.UnitPrice;
                    tempitem.Rate = item.Rate;
                    tempitem.CategoryID = item.CategoryID;
                    tempitem.ProductID = item.ProductID;
                    lstInventory.Add(tempitem);
                }
                LoadInventoryItems(lstInventory);
            }
            TextBox tb = (TextBox)(grdResult.Rows[grdResult.Rows.Count - 1].Cells[1].FindControl("txtBatchNo"));
            tb.Focus();

            LoadInventoryItems(lstInventory);
        }
    }

    private void GetINVList(List<InventoryItemsBasket> lstInventory, string strFlag)
    {
        string strMon = string.Empty;
        string strYear = string.Empty;

        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket item = new InventoryItemsBasket();
            HiddenField ProductName = (HiddenField)row.FindControl("hdnProductName");
            HiddenField CategoryName = (HiddenField)row.FindControl("hdnCategoryName");
            HiddenField Description = (HiddenField)row.FindControl("hdnDescription"); ;
            HiddenField ProductCode = (HiddenField)row.FindControl("hdnProductCode");
            HiddenField ProductId = (HiddenField)row.FindControl("hdnProductId");
            HiddenField CategoryId = (HiddenField)row.FindControl("hdnCategoryId");
            HiddenField ID = (HiddenField)row.FindControl("hdnRid");
            TextBox txtSellingPrice = (TextBox)row.FindControl("txtSellingPrice");
            TextBox txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
            DropDownList ddlExpMon = (DropDownList)row.FindControl("ddlExpMonth");
            DropDownList ddlExpYr = (DropDownList)row.FindControl("ddlExpYear");
            TextBox txtBatchNo = (TextBox)row.FindControl("txtBatchNo");
            DropDownList ddlUnit = (DropDownList)row.FindControl("ddlUnit");
            TextBox txtProdTax = (TextBox)row.FindControl("txtTax");
            TextBox txtRakNo = (TextBox)row.FindControl("txtRakNo");
            TextBox txtPrdtRemarks = (TextBox)row.FindControl("txtPrdtRemarks");


            if ((txtBatchNo.Text != "") && ((Convert.ToDecimal(txtUnitPrice.Text) > 0)))
            {
                item.ProductName = ProductName.Value;
                item.CategoryName = CategoryName.Value;
                item.ProductCode = ProductCode.Value;
                item.Description = Description.Value;


                item.Manufacture = Convert.ToDateTime("01/01/1753");

                if (ddlExpMon.SelectedItem.Value != "-1" && ddlExpYr.SelectedItem.Text != "0")
                {
                    strMon = ddlExpMon.SelectedItem.Text;
                    strYear = ddlExpYr.SelectedItem.Text;
                    string strDate = "01 " + strMon + " " + strYear;
                    item.ExpiryDate = DateTime.Parse(strDate);
                }
                else
                {
                    item.ExpiryDate = Convert.ToDateTime("01/01/1753");
                }

                item.RakNo = txtRakNo.Text;
                item.Remarks = txtPrdtRemarks.Text;
                item.BatchNo = txtBatchNo.Text;
                item.InHandQuantity = decimal.Parse(txtQuantity.Text);
                item.RECQuantity = decimal.Parse(txtQuantity.Text);
                item.RECUnit = ddlUnit.SelectedItem.Text;
                item.UnitPrice = decimal.Parse(txtUnitPrice.Text);
                item.Rate = decimal.Parse(txtSellingPrice.Text);
                item.CategoryID = int.Parse(CategoryId.Value);
                item.ProductID = Int64.Parse(ProductId.Value);
                item.ID = Int64.Parse(ID.Value);
                item.Tax = decimal.Parse(txtProdTax.Text);
                string ProductKey = string.Empty;
                string CurrentCulture = string.Empty;
                CurrentCulture = CultureInfo.CurrentCulture.Name;
                if (CurrentCulture != "en-GB")
                {

                    Attune_InventoryProductKey.GenerateProductKey(item.ProductID, item.BatchNo, item.ExpiryDate, item.UnitPrice, item.Rate, item.RECUnit, CurrentCulture, out ProductKey);
                    if (ProductKey != "")
                    {
                        item.ProductKey = ProductKey;
                    }
                }
                else
                {
                    item.ProductKey = item.ProductID + "@#$" + item.BatchNo + "@#$" + item.ExpiryDate.ToString("MMM/yyyy")
                                   + "@#$" + String.Format("{0:0.000000}", item.UnitPrice) + "@#$" + String.Format("{0:0.000000}", item.Rate) + "@#$" + item.RECUnit;
                }

                if ((item.BatchNo != ""))
                {
                    //lstInventory.Remove(lstInventory.Find(P => P.BatchNo == item.BatchNo));
                    //lstInventory.Add(item);
                    bool isExist = lstInventory.Exists(p => p.ProductKey == item.ProductKey && p.RcvdLSUQty == item.RcvdLSUQty);
                    if (isExist == false)
                    {
                        lstInventory.Add(item);
                    }
                    else
                    {

                        if (strFlag != "L")
                        {
                            strFlag = "X";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey44", "javascript:ValidationWindow('" + strProduct+ "','"+strerror+"');", true);
                        }

                    }
                }
            }
            else
            {
                if (strFlag == "A")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:ValidationWindow('" + strBatchNo + "','" + strerror + "');", true);
                }
                if (strFlag == "U")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey3", "javascript:ValidationWindow('" + strAlert + "','" + strerror + "');", true);
                }
            }
        }
    }

    private void GetINVListDelete(List<InventoryItemsBasket> lstInventory)
    {
        string strMon = string.Empty;
        string strYear = string.Empty;

        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket item = new InventoryItemsBasket();
            HiddenField ProductName = (HiddenField)row.FindControl("hdnProductName");
            HiddenField ProductId = (HiddenField)row.FindControl("hdnProductId");
            HiddenField CategoryId = (HiddenField)row.FindControl("hdnCategoryId");
            HiddenField ID = (HiddenField)row.FindControl("hdnRid");
            TextBox txtSellingPrice = (TextBox)row.FindControl("txtSellingPrice");
            TextBox txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
            //TextBox txtExpiryDate = (TextBox)row.FindControl("txtExpiryDate");
            DropDownList ddlExpMon = (DropDownList)row.FindControl("ddlExpMonth");
            DropDownList ddlExpYr = (DropDownList)row.FindControl("ddlExpYear");
            TextBox txtBatchNo = (TextBox)row.FindControl("txtBatchNo");
            TextBox txtProdTax = (TextBox)row.FindControl("txtTax");
            TextBox txtRakNo = (TextBox)row.FindControl("txtRakNo");
            TextBox txtPrdtRemarks = (TextBox)row.FindControl("txtPrdtRemarks");
            DropDownList ddlUnit = (DropDownList)row.FindControl("ddlUnit");

            if (txtBatchNo.Text != "")
            {
                item.ProductName = ProductName.Value;

                string strDate = "01 " + strMon + " " + strYear;
                item.Manufacture = DateTimeNow;
                strMon = ddlExpMon.SelectedItem.Text;
                strYear = ddlExpYr.SelectedItem.Text;
                strDate = "01 " + strMon + " " + strYear;
                if (strYear == "YYYY")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:ValidationWindow('" + strDateAlert + "','" + strerror + "');", true);
                    return;
                }

                item.ExpiryDate = DateTime.Parse(strDate);
                item.BatchNo = txtBatchNo.Text;
                item.InHandQuantity = decimal.Parse(txtQuantity.Text);
                item.RECUnit = ddlUnit.SelectedItem.Text;
                item.UnitPrice = decimal.Parse(txtUnitPrice.Text);
                item.Rate = decimal.Parse(txtSellingPrice.Text);
                item.CategoryID = int.Parse(CategoryId.Value);
                item.ProductID = Int64.Parse(ProductId.Value);
                item.ID = Int64.Parse(ID.Value);
                item.Tax = decimal.Parse(txtProdTax.Text);
                item.RakNo = txtRakNo.Text;
                item.Remarks = txtPrdtRemarks.Text;
                string ProductKey = string.Empty;
                string CurrentCulture = string.Empty;
                CurrentCulture = CultureInfo.CurrentCulture.Name;
                if (CurrentCulture != "en-GB")
                {

                    Attune_InventoryProductKey.GenerateProductKey(item.ProductID, item.BatchNo, item.ExpiryDate, item.UnitPrice, item.Rate, item.RECUnit, CurrentCulture, out ProductKey);
                    if (ProductKey != "")
                    {
                        item.ProductKey = ProductKey;
                    }
                }
                else
                {
                    item.ProductKey = item.ProductID + "@#$" + item.BatchNo + "@#$" + item.ExpiryDate.ToString("MMM/yyyy")
                                 + "@#$" + item.UnitPrice + "@#$" + item.Rate + "@#$" + item.RECUnit;
                }


                if (item.BatchNo != "")
                {
                    lstInventory.Remove(lstInventory.Find(P => P.BatchNo == item.BatchNo));
                    lstInventory.Add(item);
                }
            }

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            hdnValues.Value = "Y";
            List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
            GetINVList(lstInventory, "U");
            new InventoryCommon_BL(base.ContextInfo).UpdateBulkProductListDetails(lstInventory, OrgID, ILocationID, LID, InventoryLocationID, "");
            LoadInventoryItems(lstInventory);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "nameValidate", "javascript:nameValidate();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSearch_Click", ex);

        }
    }


    protected void LoadSellingPriceRule()
    {
        long returnCode = -1;
        List<SellingPriceRuleMaster> lstSellingPriceRuleMaster = new List<SellingPriceRuleMaster>();
        List<SellingPriceRuleLocationMapping> lstSellingPriceRuleLocationMapping = new List<SellingPriceRuleLocationMapping>();
        returnCode = new InventoryCommon_BL(base.ContextInfo).getSellingPriceRuleMaster(OrgID, ILocationID, InventoryLocationID, out lstSellingPriceRuleMaster, out lstSellingPriceRuleLocationMapping);
        if (lstSellingPriceRuleMaster.Count > 0)
        {

            foreach (var Item in lstSellingPriceRuleMaster)
            {
                hdnSellingPrieRuleList.Value += Item.Description + "^";
            }

        }

    }
}
