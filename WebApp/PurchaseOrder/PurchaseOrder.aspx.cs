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
using System.Xml;
using System.Xml.Linq;
using System.Linq;
using System.IO;
using System.Text;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;

public partial class PurchaseOrder_PurchaseOrder : Attune_BasePage
{
    public PurchaseOrder_PurchaseOrder()
        : base("PurchaseOrder_PurchaseOrder_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    Products objProducts = new Products();

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            try
            {

                lblmsg.Text = "";
                listProducts.Visible = false;
                divSearch.Visible = false;
                
                txtPurchaseOrderDate.Text =DateTimeNow.ToExternalDate();
                //end
                if (Request.QueryString["ID"] != null)
                {
                    string poNO = string.Empty;
                    poNO = Request.QueryString["ID"];
                    btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx?Edit=Y&ID=" + poNO;
                    if (Request.QueryString["ACN"] != null)
                    {
                        btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx?Edit=Y&ID=" + poNO + "&ACN=" + Request.QueryString["ACN"];
                    }
                }
                else
                {
                    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Display_Inhandqty", OrgID, ILocationID, out lstInventoryConfig);
                    if (lstInventoryConfig.Count > 0)
                    {
                        if (lstInventoryConfig[0].ConfigValue == "Y")
                        {
                            btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx?ID=ipo";
                        }
                        else
                        {
                            btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx";
                        }
                    }
                    else
                    {
                        btnGeneratePO.PostBackUrl = "PurchaseOrderQuantity.aspx";
                    }
                }

                LoadSuppliers();
                LoadUnit();
                BindProductType();
                BindCategory();




                if (Request.QueryString["addMore"] == "Y")
                {
                    LoadAddMore();
                }

                string TAX_EDITABLE = GetConfigValue("TAX_EDITABLE", OrgID);
                if (!string.IsNullOrEmpty(TAX_EDITABLE))
                {
                    if (TAX_EDITABLE == "Y")
                    {
                        TxtTax.Attributes.Add("readonly", "readonly");
                    }
                }               
                //Dharanesh for Vasan Hide AddnewProducts Button//
                string IsmiddleEast = GetConfigValue("IsMiddleEast", OrgID);
                if (!string.IsNullOrEmpty(IsmiddleEast))
                {
                    if (IsmiddleEast == "Y")
                    {
                        btnAddNew.Attributes.Add("class", "hide");
                    }
                    else
                    {
                        btnAddNew.Attributes.Add("class", "show");
                    }
                }
                //Dharanesh for Vasan Hide AddnewProducts Button//

                hdnOrgId.Value = OrgID.ToString();
                txtOrgName.Text = OrgName;
                hdnLocationList.Value = InventoryLocationID.ToString() + "~" + DepartmentName + "~" + "0" + "~" + OrgID.ToString() + "~" + OrgName + "~0" + "^";
                //if (hdnLocationList.Value != "")
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadLocation", "tableLocationList();", true);
                //}
                AutoOrgName.ContextKey = "Org~" + hdnOrgId.Value;
                AutoCompleteExtenderLocation.ContextKey = "Location~" + hdnOrgId.Value;
                GetProductsAttributes();
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - PurchaseOrder.aspx", ex);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }
    }
    public void LoadUnit()
    {


        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
        bUnits.DataSource = lstInventoryUOM;
        bUnits.DataTextField = "UOMCode";
        bUnits.DataValueField = "UOMCode";
        bUnits.DataBind();
        

        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        bUnits.Items.Insert(0, ddlselect);
      //  bUnits.Items.Insert(0, GetMetaData("Select", "0"));
        //end
        bUnits.Items[0].Value = "0";



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
       // ddlType.Items.Insert(0, GetMetaData("Select", "0"));
        //end
        ddlType.Items[0].Value = "0";

        //List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        //int OrgAddid = ILocationID;
        //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID,ILocationID, out lstInventoryConfig);
        //if (lstInventoryConfig.Count > 0)
        //{
        //    if (lstInventoryConfig[0].ConfigValue == "Y")
        //    {
        //        OrgAddid = 0;
        //    }
        //    else
        //    {
        //        OrgAddid = ILocationID;
        //    }
        //}       
        //List<Locations> lstInvLocation = new List<Locations>();
        //inventoryBL.GetInvLocationDetail(OrgID, OrgAddid, out lstInvLocation);
        //System.Data.DataTable dt = new DataTable();
        //string[] tname = lstInvLocation[0].TypeName.Split(',');
        //string[] tid = lstInvLocation[0].ProductTypeID.Split(',');
        //DataColumn dc1 = new DataColumn("TypeName");
        //DataColumn dc2 = new DataColumn("ProductTypeID");
        //dt.Columns.Add(dc1);
        //dt.Columns.Add(dc2);
        //for (int i = 0; i < tname.Length; i++)
        //{
        //    if (tname[i] != "")
        //    {
        //        DataRow dr1 = dt.NewRow();
        //        dr1["TypeName"] = tname[i];
        //        dr1["ProductTypeID"] = tid[i];
        //        dt.Rows.Add(dr1);
        //    }
        //}
        //ddlType.DataSource = dt;
        //ddlType.DataTextField = "TypeName";
        //ddlType.DataValueField = "ProductTypeID";
        //ddlType.DataBind();
        //ddlType.Items.Insert(0, "--Select ProductType--");
        //ddlType.Items[0].Value = "0";
        //ddlType.SelectedValue = "0";

    }

    private void BindCategory()
    {
        inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
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
        //end
       // ddlCategory.Items.Insert(0, GetMetaData("Select", "0"));
        ddlCategory.Items[0].Value = "0";

        hdnCatTax.Value = "";
        foreach (ProductCategories item in lstProductCategories)
        {
            hdnCatTax.Value = hdnCatTax.Value + item.CategoryID.ToString() + "~" + item.Tax + "#";
        }


    }

    private void LoadAddMore()
    {
        try
        {
            HiddenField hddnPoDate = (HiddenField)PreviousPage.FindControl("hdnPoDate");
            HiddenField hddnSName = (HiddenField)PreviousPage.FindControl("hdnSName");
            HiddenField hddnComments = (HiddenField)PreviousPage.FindControl("hdnComments");
            HiddenField hddnOrderedItems = (HiddenField)PreviousPage.FindControl("hdnPurchaseOrderItems");
            txtPurchaseOrderDate.Text = hddnPoDate.Value;
            ddlSupplierList.SelectedValue = hddnSName.Value;
            txtComments.Text = hddnComments.Value;
            iconHid.Value = hddnOrderedItems.Value;
            hdnvalues.Value = hddnOrderedItems.Value;
            listProducts.Visible = false;
            divSearch.Visible = true;

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading the page", Ex);
        }

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
          //  ddlSupplierList.Items.Insert(0, GetMetaData("Select", "0"));
            //end
            ddlSupplierList.Items[0].Value = "0";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
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

    protected void ddlSupplierList_SelectedIndexChanged(object sender, EventArgs e)
    {
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        var Detalis = from Supplier in lstSuppliers
                      where Supplier.SupplierID == int.Parse(ddlSupplierList.SelectedValue)
                      select Supplier;
        divSupplier.Attributes.Add("class","hide");
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

            lblVendorCity.Text = childList.City;
            lblVendorPhone.Text = childList.Phone;
            lblEmailID.Text = childList.EmailID;
           // if (iconHid.Value.Split('^').Length > 1)
            if(!string.IsNullOrEmpty(iconHid.Value))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product", "javascript:LoadOrdItems();", true);
            }

        }
        if (ddlSupplierList.SelectedIndex == 0)
        {
            divSearch.Visible = false;
        }
        else
        {
            divSearch.Visible = true;
        }

		ScriptManager.RegisterStartupScript(Page, Page.GetType(), "DatePicker", "javascript:SetDatePickterValue();", true);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Products> lstProducts = new List<Products>();

        try
        {
            inventoryBL.GetSearchProductList(OrgID, txtProduct.Text.Trim(), ILocationID, InventoryLocationID, out lstProducts);
            if (lstProducts.Count > 0)
            {
                tdProduct.Attributes.Add("class", "show");
                listProducts.Visible = true;
                string Message = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_10;
                if (Message == null)
                {
                    Message = "Product List (Double click the below list to select the Product.)";
                }
                lblmsg.Text =Message ;
                listProducts.DataSource = lstProducts;
                listProducts.DataTextField = "ProductName";
                listProducts.DataValueField = "Description";
                listProducts.DataBind();
            }
            else
            {
                string Message = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_11;
                if (Message == null)
                {
                    Message = "No matching Product found";
                }
                tdProduct.Attributes.Add("class", "hide");
                lblmsg.Text = Message;
                listProducts.Visible = false;
            }
            if (Request.QueryString["addMore"] == "Y")
            {
                //iconHid.Value = hdnvalues.Value;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product", "javascript:LoadOrdItems();", true);
            }
            //if (iconHid.Value.Split('^').Length > 1)
            if (!string.IsNullOrEmpty(iconHid.Value))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product", "javascript:LoadOrdItems();", true);
            }


        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Product  Details", Ex);
        }


    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            List<ProductLocationMapping> lstProductsLocationMapping = new List<ProductLocationMapping>();
            ProductLocationMapping objProductsLocationMapping = new ProductLocationMapping();
            lstProductsLocationMapping = GetCollectedItems();
            objProducts.ProductName = txtProductName.Text.Trim();
            objProducts.CategoryID = Convert.ToInt32(ddlCategory.SelectedValue);
            objProducts.Attributes = "N";
            objProducts.HasAttributes = "N";
            objProducts.ReOrderLevel = Convert.ToInt64(0);
            objProducts.Description = txtDescription.Text;
            objProducts.OrgID = OrgID;
            objProducts.OrgAddressID = ILocationID;
            objProducts.CreatedBy = LID;
            objProducts.ProductID = Int64.Parse(hdnId.Value);
            objProducts.TypeID = int.Parse(ddlType.SelectedValue);
            objProducts.IsScheduleHDrug = "N";
            objProducts.HasExpiryDate = "N";
            objProducts.HasBatchNo = "N";
            objProducts.HasUsage = "N";
            objProducts.IsDeleted = "N";
            if (TxtTax.Text.Length > 0)
            {
                objProducts.TaxPercent = Convert.ToDecimal(hdnGetTax.Value);
               // objProducts.TaxPercent = Convert.ToDecimal(TxtTax.Text);
            }
            else
            {
                objProducts.TaxPercent = Convert.ToDecimal("0.00"); ;
            }
            //  objProducts.TaxPercent = Convert.ToDecimal(TxtTax.Text);
            objProducts.IsNorcotic = "N";
            objProducts.TransactionBlock = "N";
            objProducts.LSU = bUnits.SelectedItem.Text;
            objProducts.IsDeleted = "N";
            objProducts.IsLabAnalyzer = "N";
            objProducts.HasSerialNo = "N";

            if (chkisdelete.Checked)
            {
                objProducts.IsDeleted = "Y";
            }

            if (chkIsScheduleHDrug.Checked)
            {
                objProducts.IsScheduleHDrug = "Y";
            }

            if (chkExpDate.Checked)
            {
                objProducts.HasExpiryDate = "Y";
            }
            if (ChkTransblock.Checked)
            {
                objProducts.TransactionBlock = "Y";

            }

            if (chkBatchNo.Checked)
            {
                objProducts.HasBatchNo = "Y";
            }

            if (ChkNorcotic.Checked)
            {
                objProducts.IsNorcotic = "Y";

            }

            if (chkHasSerialNo.Checked)
            {
                objProducts.HasSerialNo = "Y";
            }

            if (chkIsLabAnalyzer.Checked)
            {
                objProducts.IsLabAnalyzer = "Y";
            }
            //if (chkIsDeleted.Checked)
            //{
            //    objProducts.IsDeleted = "Y";
            //}

            if (chkHasUsage.Checked)
            {
                objProducts.HasUsage = "Y";
                objProducts.UsageCount = int.Parse(txtUsageCount.Text);

            }

            objProducts.MfgName = txtMfgName.Text.Trim();
            objProducts.MfgCode = txtMfgCode.Text.Trim();

            if (ddlType.SelectedValue == "5")
            {
                objProducts.Model = txtProductModel.Text;
                if (txtLTofProduct.Text.Trim() != "")
                {
                    objProducts.LTofProduct = Int16.Parse(txtLTofProduct.Text);
                }
            }

            objProducts.ProductCode = txtProductCode.Text.Trim();
            objProducts.Make = txtMake.Text.Trim();
            if (txtGenericName.Text.Trim() != "")
            {
                objProducts.ReferenceID = Convert.ToInt16(hdnGenericID.Value);
            }
            else
            {
                objProducts.ReferenceID = 0;
            }
            objProducts.ReferenceType = txtGenericName.Text;
            List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
            lstProductsAttributesDetails = GetProductsAttributesDetails();
            List<ProductUOMMapping> lstProductUOM = new List<ProductUOMMapping>();

            returnCode = inventoryBL.SaveProducts(objProducts, InventoryLocationID, lstProductsLocationMapping, lstProductsAttributesDetails, lstInventoryItemsBasket, lstProductUOM);
            //returnCode = inventoryBL.SaveProducts(objProducts,InventoryLocationID);
            if (returnCode == 0)
            {

                //lblmsg.Text = "Product Added sucessfully";
                txtDescription.Text = "";
                TxtTax.Text = "0";
                txtProductName.Text = "";
                // txtReOrderLevel.Text = "";
                ddlType.SelectedValue = "0";
                ddlCategory.SelectedValue = "0";
                ddlType.SelectedValue = "0";
                bUnits.SelectedValue = "0";
                txtUsageCount.Text = "0";
                chkIsScheduleHDrug.Checked = false;
                chkBatchNo.Checked = false;
                chkExpDate.Checked = false;
                chkHasUsage.Checked = false;
                ChkNorcotic.Checked = false;
                ChkTransblock.Checked = false;
                chkisdelete.Checked = false;
                chkHasSerialNo.Checked = false;
                chkIsLabAnalyzer.Checked = false;
                //chkIsDeleted.Checked = false;
                divUsageCount.Attributes.Add("class", "hide");
                hdnId.Value = "0";
                hdnStatus.Value = "";
                txtMfgName.Text = "";
                txtMfgCode.Text = "";
                txtGenericName.Text = "";
                txtProductCode.Text = "";
                hdnGenericID.Value = "0";
                tdTransblock.Attributes.Add("class", "hide");
                tddelete.Attributes.Add("class", "hide");
                //foreach (ListItem li in cbxlistLocatioc.Items)
                //{
                //    li.Selected = false;
                //}
                string sPath = Resources.PurchaseOrder_AppMsg.PurchaseOrder_PurchaseOrder_aspx_01;
                if (sPath == null)
                {
                    sPath = "Product Added sucessfully";
                }
                string sInformation = Resources.PurchaseOrder_AppMsg.PurchaseOrder_Information;
                if (sInformation == null)
                {
                    sInformation = "Information";
                }
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "javascript:ValidationWindow('" + sPath + "','" + sInformation +"');", true);
                //divNewProduct.Style.Add("display", "none");
                //ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('Product Added sucessfully');", true);
            }
            else
            {
                // lblnewmsg.Text = "Product Added Failed";
                divNewProduct.Attributes.Add("class", "show");
                divProduct.Attributes.Add("class", "hide");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Products - Products.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        hdnLocationList.Value = "";
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ViewState["SetAttribute"] = "";
        hdnLocationList.Value = "";

    }

    public List<ProductLocationMapping> GetCollectedItems()
    {

        List<ProductLocationMapping> lstProductLocationMapping = new List<ProductLocationMapping>();

        string[] Locations = hdnLocationList.Value.Trim().Split('^');
        Array.Sort(Locations);

        foreach (string listParent in Locations)
        {
            if (listParent != null && listParent.Trim() != string.Empty)
            {
                string[] listChild = listParent.Split('~');
                ProductLocationMapping objProductLocationMapping = new ProductLocationMapping();

                objProductLocationMapping.ProductID = Int64.Parse(hdnId.Value);
                objProductLocationMapping.LocationID = Convert.ToInt32(listChild[0]);
                objProductLocationMapping.ReorderQuantity = Convert.ToInt32(listChild[2]);
                objProductLocationMapping.OrgId = Convert.ToInt32(listChild[3]);
                objProductLocationMapping.MaximumQuantity = Convert.ToInt32(listChild[5]);
                lstProductLocationMapping.Add(objProductLocationMapping);

            }

        }
        return lstProductLocationMapping;
    }
    public void GetProductsAttributes()
    {
        List<ProductsAttributesMaster> lstProductsAttributesMaster = new List<ProductsAttributesMaster>();
        inventoryBL.GetProductsAttributes(out lstProductsAttributesMaster);

        divProductAttributes.InnerHtml = string.Empty;
        StringBuilder sb = new StringBuilder();
        if (lstProductsAttributesMaster.Count > 0)
        {
            sb.Append(StockRow(lstProductsAttributesMaster));
        }

        divProductAttributes.InnerHtml = sb.ToString();
    }
    protected StringBuilder StockRow(List<ProductsAttributesMaster> lstProductsAttributesMaster)
    {
        StringBuilder sbHeadStart = new StringBuilder();
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        if (lstProductsAttributesMaster.Count > 0)
        {
            string getCategories = string.Empty;
            foreach (ProductsAttributesMaster childRow in lstProductsAttributesMaster)
            {
                switch (childRow.ControlName.ToLower())
                {
                    case "textbox":
                        getCategories = GetTextBox(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    case "checkbox":
                        getCategories = GetChktBox(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    case "dropdownlist":
                        getCategories = GetDropDownList(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    default:
                        break;
                }
            }
        }
        sb.Append("<table id='tblSRRow' border='0' cellpadding='4' cellspacing='0'>");
        sb.Append(sbBody);
        sb.Append("</table>");

        return sb;
    }


    protected string GetTextBox(string ID, string AttributeName, string TXTValue)
    {
        return "<TR><td>" + TXTValue + "</td><td> <input style='width:150px;' type='text' id='" + AttributeName + '~' + ID + "'  /></td></TR>";
    }

    protected string GetChktBox(string ID, string AttributeName, string TXTValue)
    {
        return "<TR><td Colspan='2'><input style='width:50px;' type='checkbox' id='" + AttributeName + '~' + ID + "'  />" + TXTValue + "</td></TR>";
    }

    protected string GetDropDownList(string ID, string AttributeName, string TXTValue)
    {
        
        string sSelect = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrder_aspx_06;
        //end
        if (sSelect == null)
        {
            sSelect = "--select--";
        }
        string strDDL = string.Empty;
        strDDL += "<TR><td>" + TXTValue + "</td><td> <select style='width:50px;' id='" + AttributeName + '~' + ID + "'>";
        strDDL += "<option value='--select--'>sSelect</option>";
        strDDL += "</select></td></TR>";
        return strDDL;
    }

    protected List<ProductsAttributesDetails> GetProductsAttributesDetails()
    {
        List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
            ProductsAttributesDetails objInventoryAttributesMaster = new ProductsAttributesDetails();
            string[] MainSplit = hdnProductList.Value.Split('#');


            for (int j = 0; j < MainSplit.Length; j++)
            {
                if (!string.IsNullOrEmpty(MainSplit[j]))
                {
                    objInventoryAttributesMaster = new ProductsAttributesDetails();
                    string[] SubSplit = MainSplit[j].Split('~');
                    objInventoryAttributesMaster.AttributeID = Convert.ToInt32(SubSplit[1]);
                    objInventoryAttributesMaster.AttributesValue = SubSplit[2];
                    objInventoryAttributesMaster.AttributesKey = SubSplit[0];
                    lstProductsAttributesDetails.Add(objInventoryAttributesMaster);
                }
            }
        }
        return lstProductsAttributesDetails;
    }

}