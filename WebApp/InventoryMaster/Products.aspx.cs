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
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.InventoryCommon.BL;
using System.Web.Script.Serialization;
using System.Linq;
//using Attune.Kernel.Shared.BL;
public partial class Inventory_Products : Attune_BasePage
{
    public Inventory_Products()
        : base("InventoryMaster_Products_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<ProductType> lstProductType = new List<ProductType>();
    public List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Attributes> lstAttributes = new List<Attributes>();
    InventoryMaster_BL inventoryBL;
    Products objProducts = new Products();
    List<ProductAttributes> lstProductAttributes = new List<ProductAttributes>();
    List<Locations> lstInvLocation = new List<Locations>();
    HiddenField GstrAttribute = new HiddenField();
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    string AutoProCode = string.Empty;
    private string _StrProductCategories = string.Empty;
    string isProdAttr;
    List<InventoryItemsBasket> lstinventoryItemsbasket = new List<InventoryItemsBasket>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string IsConsignConfig = string.Empty;
    int tdCurrentCount = 0;
    int TotaltdCount = 0;

    public string StrProductCategories
    {
        get
        {
            return _StrProductCategories;
        }
        set
        {
            _StrProductCategories = value;
        }
    }
    private string _StrLoadOrderedUnit = string.Empty;
    public string StrLoadOrderedUnit
    {
        get
        {
            return _StrLoadOrderedUnit;
        }
        set
        {
            _StrLoadOrderedUnit = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        try
        {
            lblmsg.Text = "";
            InitializeComponent();
            TaxMandatoryConfig();
            if (!IsPostBack)
            {
                TxtTax.Text = "0";
                hdnGetTax.Value = "0";
                LoadUnit();
                BindProductType();
                BindCategory();
                GetProductsAttributes();
                LoadMetaData();
                LoadTaxmaster();

                string TAX_EDITABLE = GetConfigValue("TAX_EDITABLE", OrgID);
                TAX_EDITABLE = !string.IsNullOrEmpty(TAX_EDITABLE) ? TAX_EDITABLE : "N";

                if (TAX_EDITABLE == "Y")
                {
                    TxtTax.Attributes.Add("readonly", "readonly");
                }

                //Tax Column hiding for Vasan
                string TAX_COLUMNHIDE = GetConfigValue("IsMiddleEast", OrgID);
                TAX_COLUMNHIDE = !string.IsNullOrEmpty(TAX_COLUMNHIDE) ? TAX_COLUMNHIDE : "N";
                if (TAX_COLUMNHIDE == "Y")
                {
                    tdlbltax.Attributes.Add("class", "hide");
                    tdtxttax.Attributes.Add("class", "hide");
                }
                //Tax Column hiding for Vasan

				
                string isVATNotReq = GetConfigValue("IsVATNotApplicable", OrgID);
                if (isVATNotReq == "Y")
                {
                   ddlTaxtype.Visible = false;
                    lblTax.Visible = false;

                    lblTaxPercentage.Attributes.Add("class", "show");
                    TxtTax.Attributes.Add("class", "show");
                }
                
				
                ddlType.Attributes.Add("onChange", "return ddlTypeOnSelectedIndexChange();");
                ddlCategory.Attributes.Add("onChange", "return ddlCategoryOnSelectedIndexChange();");
                IsConsignConfig = GetConfigValue("Is Consignment Product", OrgID);
                ChkIsConsign.Attributes.Add("onChange", "return setcontextKey();");
                if (IsConsignConfig == "Y") 
                {
                    divConsign.Attributes.Remove("class");
                    divConsign.Attributes.Add("class","show");
                }
                
                hdnOrgId.Value = OrgID.ToString();
                txtOrgName.Text = OrgName;
                hdnLocationList.Value = InventoryLocationID.ToString() + "~" + DepartmentName + "~" + "0" + "~" + OrgID.ToString() + "~" + OrgName + "~" + "0" + "~" + "Daily" + "~" + "N" + "~" + "0" + "^";

                #region getConfigValue for Manufactures validation
                List<Config> isManufactures = new List<Config>();
                new Configuration_BL(base.ContextInfo).GetConfigDetails("IsManufacturesFreeText", OrgID, out isManufactures);
                if (isManufactures != null && isManufactures.Count > 0)
                {
                    hdnIsMfgFeeText.Value = isManufactures[0].ConfigValue;
                }        

                txtMfgCode.Enabled = hdnIsMfgFeeText.Value == "Y" ? true : false;

                #endregion


                string strHideHistory = GetConfigValue("HideProductHistory", OrgID);
                if (strHideHistory == "Y")
                {
                    gvProduct.Columns[10].Visible = false;
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "DepartmentGroup", "DepartmentGroupBasedHideShow();", true);
            }
            if (hdnLocationList.Value != "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadLocation", "tableLocationList();", true);
            }
            AutoOrgName.ContextKey = "Org~" + hdnOrgId.Value;
            AutoCompleteExtenderLocation.ContextKey = "Location~" + hdnOrgId.Value;

            #region ProductEdit
            new TrustedOrg_BL(base.ContextInfo).GetSharingOrgList(OrgID, out lstorgn, out lstloc);
            if (lstorgn != null && lstorgn.Count > 0 && !string.IsNullOrEmpty(lstorgn[0].ParentOrgID.ToString()))
            {
                var s = lstorgn.FindAll(p => p.OrgID == OrgID);
                if (OrgID == s[0].ParentOrgID)
                {
                    gvProduct.Columns[9].Visible = true;
                }
                else
                {
                    gvProduct.Columns[9].Visible = false;
                }
            }
            #endregion

            //#region OrderedUnitHideForVasan
            //string hideOrdUnit = GetConfigValue("IsMiddleEast", OrgID);

            //if (hideOrdUnit == "Y")
            //{
            //    tdddlOrdUnit.Attributes.Add("class", "hide");
            //    tdOrderedUnit.Attributes.Add("class", "hide");
            //}

            //#endregion

            #region
            /*Sathish--Add Button show for Vasan*/
            string hideAddbtn = GetConfigValue("IsMiddleEast", OrgID);
            if (hideAddbtn == "Y")
            {
                btnpopupClick.Attributes.Add("class", "show");
            }
            else
            {
                btnpopupClick.Attributes.Add("class", "hide");
            }
            #endregion
            #region
            /*Sathish-ConfigBasedProductcode to be kept in ReadOnly*/

            List<InventoryConfig> lstInventoryConfig_PCode;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_ProductCode_Validation", OrgID, ILocationID, out lstInventoryConfig_PCode);
            string ReadOnlyProCode = string.Empty;
            if (lstInventoryConfig_PCode.Count > 0)
            {
                ReadOnlyProCode = lstInventoryConfig_PCode[0].ConfigValue;
                if (ReadOnlyProCode == "Y")
                {
                    txtProductCode.Attributes.Add("readonly", "readonly");
                    
                }
            }
            #endregion
            List<InventoryConfig> lstInventoryConfig_a = new List<InventoryConfig>();
            inventoryBL = new InventoryMaster_BL(base.ContextInfo);
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedtoAddProductAttributes", OrgID, ILocationID, out lstInventoryConfig_a);
            if (lstInventoryConfig_a.Count > 0)
            {
                isProdAttr = lstInventoryConfig_a[0].ConfigValue;
                string check = !string.IsNullOrEmpty(isProdAttr) ? isProdAttr : "N";
                if (check == "Y")
                {
                        dvBody_4.Attributes.Add("class", "show");
                        lstinventoryItemsbasket = ucProductAttributes.GetAttributes();
                }
                else
                {
                    dvBody_4.Attributes.Add("class", "hide");
                    isProdAttr = "";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - Products.aspx", ex);
        }
    }

    private void BindProductType()
    {
        new InventoryCommon_BL(ContextInfo).GetProductType(OrgID, out lstProductType);
        ddlType.DataSource = lstProductType;
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "TypeID";
        ddlType.DataBind();
        ddlType.Items.Insert(0, GetMetaData("Select", "0"));
        ddlType.Items[0].Value = "0";
    }

    public void LoadUnit()
    {
        new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);
        bUnits.DataSource = lstInventoryUOM;
        bUnits.DataTextField = "UOMCode";
        bUnits.DataValueField = "UOMCode";
        bUnits.DataBind();
        JavaScriptSerializer js = new JavaScriptSerializer();
        StrLoadOrderedUnit = js.Serialize(lstInventoryUOM);
        bUnits.Items.Insert(0, GetMetaData("Select", "0"));
        bUnits.Items[0].Value = "0";
        ddlOrdUnit.DataSource = lstInventoryUOM;
        ddlOrdUnit.DataTextField = "UOMCode";
        ddlOrdUnit.DataValueField = "UOMID";
        ddlOrdUnit.DataBind();
        ddlOrdUnit.Items.Insert(0, GetMetaData("Select", "0"));
        ddlOrdUnit.Items[0].Value = "0";

    }
    private void BindCategory()
    {

        new InventoryCommon_BL(ContextInfo).GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        ddlCategory.DataSource = lstProductCategories;
        ddlCategory.DataTextField = "CategoryName";
        ddlCategory.DataValueField = "CategoryID";
        ddlCategory.DataBind();
        ddlCategory.Items.Insert(0, GetMetaData("Select", "0"));
        ddlCategory.Items[0].Value = "0";        
        JavaScriptSerializer js = new JavaScriptSerializer();
        StrProductCategories = js.Serialize(lstProductCategories);
        hdnCatTax.Value = "";
        foreach (ProductCategories item in lstProductCategories)
        {
            hdnCatTax.Value = hdnCatTax.Value + item.CategoryID.ToString() + "~" + item.Tax + "#";
        }

    }

    private void InitializeComponent()
    {
        ProductSearch1.OnProductSearch += new InventoryCommon_Controls_ProductSearch.ProductSearchHandler(ProductSearch1_OnProductSearch);
    }

    void ProductSearch1_OnProductSearch(object sender, InventoryCommon_Controls_ProductSearch.ProductSearchList e)
    {
        BindProductList(e.CategoryId, e.ProductName);
        hdnPrname.Value = e.ProductName;
        hdnCatid.Value = e.CategoryId.ToString();

    }

    private void BindProductList(int CategoryId, string ProductName)
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        inventoryBL.GetAllMasterProductDetails(OrgID, ILocationID, CategoryId, ProductName, 0, out lstInventoryItemsBasket);
        gvProduct.DataSource = lstInventoryItemsBasket;
        gvProduct.DataBind();
        ProductSearch1.LoaderProductList(lstInventoryItemsBasket);
        gvProduct.Visible = true;
    }

    protected void gvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvProduct.PageIndex = e.NewPageIndex;
            int pCatID = 0;
            Int32.TryParse(hdnCatid.Value, out pCatID);

            BindProductList(pCatID, hdnPrname.Value);

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
                Response.Redirect(Attune_Helper.GetAppName() + relPagePath, true);
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
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtConReOrderLevel.Text = "0";
        ViewState["SetAttribute"] = "";
        hdnLocationList.Value = "";
        txtProductName.Enabled = true;
        ddlCategory.Enabled = true;
        ddlOrdUnit.Enabled = true;
        bUnits.Enabled = true;
        ddlScheduleDrug.Enabled = true;
        ddlType.Enabled = true;
        btnFinish.Text = "Save";
        hdnLocationList.Value = InventoryLocationID.ToString() + "~" + DepartmentName + "~" + "0" + "~" + OrgID.ToString() + "~" + OrgName + "~" + "0" + "~" + "Daily" + "~" + "N" + "~" + "0" + "^";
        hdnProductUomList.Value = string.Empty;

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadLocation", "tableLocationList();", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "DepartmentGroup", "DepartmentGroupBasedHideShow();", true);
        
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
                objProductLocationMapping.StockFrequency = listChild[6];
                objProductLocationMapping.IsIndentLocation = string.IsNullOrEmpty(listChild[8]) == false ? Convert.ToInt32(listChild[8]) : 0;
                lstProductLocationMapping.Add(objProductLocationMapping);

            }

        }
        return lstProductLocationMapping;
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
	CLogger.LogInfo("Product btnFinish_Click RLSTestLine1 ");
        string Update = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_01 == null ? "Update" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_01;
        string userMsg1 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_10 == null ? "Product Updated Successfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_10;
        string userMsg2 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_11 == null ? "Product Created Successfully" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_11;
        string Save = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_12 == null ? "Save" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_12;
        string userMsg3 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_13 == null ? "Product Updated Failed" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_13;
        string userMsg4 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_14 == null ? "Product Already Exist" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_14;
        string userMsg5 = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_15 == null ? "Error while Saving Products" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_15;
        string Information = Resources.InventoryMaster_AppMsg.InventoryMaster_Information == null ? "Information" : Resources.InventoryMaster_AppMsg.InventoryMaster_Information;
        string sAlert = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Alert" : Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
        string VasanConfig = GetConfigValue("IsMiddleEast", OrgID);        

        long returnCode = -1;
        try
        {
            List<ProductLocationMapping> lstProductsLocationMapping = new List<ProductLocationMapping>();
            List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
            ProductLocationMapping objProductsLocationMapping = new ProductLocationMapping();

            lstProductsLocationMapping = GetCollectedItems();
            if (lstProductsLocationMapping.Count == 0)
            {
                lstProductsLocationMapping = GetLocationCollectedItems();
            }

            objProducts.ProductName = txtProductName.Text.Trim();
            //if (hdnOrdUnitConfig.Value.ToUpper() == "Y")
            //{
            //    objProducts.UsageCount = 0;
            //}
            //else
            //{
            //    objProducts.UsageCount = string.IsNullOrEmpty(txtPackSize.Text.Trim()) == true ? 1 : Convert.ToInt16(txtPackSize.Text.Trim());
            //}

            objProducts.CategoryID = Convert.ToInt32(ddlCategory.SelectedValue);
            if (lstProductAttributes.Count > 0)
            {
                objProducts.HasAttributes = "Y";
            }
            else
            {
                objProducts.Attributes = "N";
                objProducts.HasAttributes = "N";
            }

           // objProducts.ReOrderLevel = Convert.ToInt32("0");
            objProducts.Description = txtDescription.Text;
            objProducts.OrgID = OrgID;
            objProducts.OrgAddressID = ILocationID;
            objProducts.CreatedBy = LID;
            objProducts.ProductID = Int64.Parse(hdnId.Value);
            objProducts.TypeID = int.Parse(ddlType.SelectedValue);
            objProducts.IsScheduleHDrug = ddlScheduleDrug.SelectedValue;
            objProducts.HasExpiryDate = "N";
            objProducts.HasBatchNo = "N";
            objProducts.HSNCode = txtHsnCode.Text;//Vijayaraja
            objProducts.TaxID = int.Parse(ddlTaxtype.SelectedValue);
            #region ChildColor

            if (lstorgn != null && lstorgn.Count > 0 && !string.IsNullOrEmpty(lstorgn[0].ParentOrgID.ToString()))
            {
                var ChildColor = lstorgn.FindAll(p => p.OrgID == OrgID);
                if (OrgID == ChildColor[0].ParentOrgID)
                {
                    objProducts.ProductColour = "";
                }
                else
                {
                    objProducts.ProductColour = "Y";
                }
            }
           
            #endregion


            objProducts.HasSerialNo = "N";
            objProducts.IsLabAnalyzer = "N";

            objProducts.HasUsage = "N";
            objProducts.IsDeleted = "N";
            if (TxtTax.Text.Length > 0)
            {
                objProducts.TaxPercent = Convert.ToDecimal(hdnGetTax.Value);
                //objProducts.TaxPercent = Convert.ToDecimal(TxtTax.Text);
            }
            else
            {
                objProducts.TaxPercent = Convert.ToDecimal("0.00"); ;
            }
            objProducts.IsNorcotic = cheIsNorcotic.Checked == true ? "Y" : "N";                
            
            objProducts.TransactionBlock = "N";

            objProducts.LSU = bUnits.SelectedItem.Text;
            objProducts.IsDeleted = "N";

            if (chkisactive.Checked == false)
            {
                objProducts.IsDeleted = "Y";
            }
            if (ChkTransblock.Checked)
            {
                objProducts.TransactionBlock = "Y";
            }

            objProducts.MfgName = txtMfgName.Text.Trim();
            objProducts.MfgCode = txtMfgCode.Text.Trim();

            //Need Confirm
            //if (ddlType.SelectedValue == "5")
            //{
            //    objProducts.Model = txtProductModel.Text;
            //    if (txtLTofProduct.Text.Trim() != "")
            //    {
            //        objProducts.LTofProduct = Int16.Parse(txtLTofProduct.Text);
            //    }
            //}

            objProducts.ProductCode = txtProductCode.Text.Trim();
            objProducts.Make = txtMake.Text.Trim();
            objProducts.ReferenceID = Convert.ToInt32(hdnGenericID.Value);
            objProducts.ReferenceType = txtGenericName.Text;
            objProducts.IsConsign = ChkIsConsign.Checked == true ? "Y" : "N";
            objProducts.OrderedUnit = ddlOrdUnit.SelectedValue == "0" ? "" : ddlOrdUnit.SelectedItem.Text;
            objProducts.OrderedConvertUnit = string.IsNullOrEmpty(txtContainer.Text.Trim()) == true ? 1 : Convert.ToInt16(txtContainer.Text.Trim()); 
            objProducts.UsageCount = string.IsNullOrEmpty(txtPackSize.Text.Trim()) == true ? 1 : Convert.ToInt16(txtPackSize.Text.Trim());
            objProducts.PDeptGroup = ddlDeptGroup.SelectedValue;
            objProducts.ShelfPeriod = string.IsNullOrEmpty(txtshelfLife.Text) == false ? Convert.ToInt64(txtshelfLife.Text) : 0;
            objProducts.ShelfPeriodCode = ddlShelfLife.SelectedValue;
            objProducts.ReorderConsumptionlevel = string.IsNullOrEmpty(txtConReOrderLevel.Text) == false ? Convert.ToInt32(txtConReOrderLevel.Text) : 0;

            lstProductsAttributesDetails = GetProductsAttributesDetails();
            string check = !string.IsNullOrEmpty(isProdAttr) ? isProdAttr : "N";
            if (check == "Y")
            {
                lstinventoryItemsbasket = ucProductAttributes.GetAttributes();
            }
            JavaScriptSerializer JSserializer = new JavaScriptSerializer();
            List<ProductUOMMapping> lstProductUOM = new List<ProductUOMMapping>();
            lstProductUOM = JSserializer.Deserialize<List<ProductUOMMapping>>(hdnProductUomList.Value);

            returnCode = new InventoryCommon_BL(ContextInfo).SaveProducts(objProducts, InventoryLocationID, lstProductsLocationMapping, lstProductsAttributesDetails, lstinventoryItemsbasket, lstProductUOM);
            if (returnCode == 0)
            {
                
                if (btnFinish.Text == Update)
                {
                    BindProductList(Convert.ToInt32(ddlCategory.SelectedValue), txtProductName.Text.Trim());
                    if (VasanConfig=="Y")
                        userMsg1 = userMsg1+" ProductCode: " + AutoProCode + " " + " ProductName: " + txtProductName.Text.Trim();

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + userMsg1 + "','" + Information + "');$('#hdnCategoryClear').val('');", true);
                    //lblmsg.Text = userMsg1;
                    btnFinish.Text = Save;
                }
                else
                {
                    gvProduct.Visible = false;
                    if(VasanConfig == "Y")
                        userMsg2 = userMsg2 + " ProductCode: " + AutoProCode +" ProductName: " + txtProductName.Text.Trim();
                    
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + userMsg2 + "','" + Information + "');$('#hdnCategoryClear').val('');", true);
                    //lblmsg.Text = userMsg2;
                    btnFinish.Text = Save;
                }
                txtDescription.Text = "";
                TxtTax.Text = "0";
                hdnGetTax.Value = "0";
                txtProductName.Text = "";

                ddlType.SelectedValue = "0";
                ddlCategory.SelectedValue = "0";
                ddlType.SelectedValue = "0";
                bUnits.SelectedValue = "0";
                ChkTransblock.Checked = false;
                chkisactive.Checked = true;
                txtProductModel.Text = "";
                txtLTofProduct.Text = "";
                txtHsnCode.Text = "";//vijayaraja
                ddlTaxtype.SelectedValue = "0";
                hdnId.Value = "0";
                hdnStatus.Value = "";
                txtMfgName.Text = "";
                txtMfgCode.Text = "";
                tdTransblock.Attributes.Add("class", "hide");
                tddelete.Attributes.Add("class", "hide");
                txtMake.Text = "";
                txtProductCode.Text = "";
                // ddlGeneric.SelectedValue = "0";
                txtGenericName.Text = "";
                hdnGenericID.Value = "0";
                hdnLocationList.Value = "";
                hdnLocationName.Value = "";
                hdnLocationID.Value = "0";
                txtLocationName.Text = "";
                txtReOrderLevel.Text = "0";
                txtPackSize.Text = "";
                hdnLocationList.Value = "";
                hdnOrgId.Value = OrgID.ToString();
                txtOrgName.Text = OrgName;
                //txtRangeSize.Text = "";
                ddlOrdUnit.SelectedValue = "0";
                hdnOrdUnitConfig.Value = "0";
               // hdnScheduledrugValue.Value = "";
                txtContainer.Text=string.Empty;
                txtshelfLife.Text=string.Empty;
                cheIsNorcotic.Checked = false;
                ddlShelfLife.SelectedValue = "0";
                ddlScheduleDrug.SelectedValue = "N";
                hdnProductUomList.Value = string.Empty;
                txtConReOrderLevel.Text = "0";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "DepartmentGroup", "DepartmentGroupBasedHideShow();", true);
                //ddlDeptGroup.SelectedValue = "0";
                //if(rblScheduleDrug.SelectedItem!=null)
                //rblScheduleDrug.SelectedItem.Selected = false;
                ucProductAttributes.ClearAttributes();
                hdnLocationList.Value = InventoryLocationID.ToString() + "~" + DepartmentName + "~" + "0" + "~" + OrgID.ToString() + "~" + OrgName + "~" + "0" + "~" + "Daily" + "~" + "N" + "~" + "0" + "^";
                ChkIsConsign.Checked = false;
                if (hdnLocationList.Value != "")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadLocation", "tableLocationList();", true);
                }

            }
            else
            {
                if (btnFinish.Text == Update)
                {
                    BindProductList(Convert.ToInt32(hdnCatid.Value), hdnpName.Value);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + userMsg3 + "','" + sAlert + "');", true);
                    //lblmsg.Text = ;userMsg3
                }
                else
                {
                    if (returnCode != 1000)
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + userMsg4 + "','" + sAlert + "');", true);
                       // lblmsg.Text = userMsg4;
                    else
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + userMsg5 + "','" + sAlert + "');", true);
                        //lblmsg.Text = userMsg5;
                }
            }
            txtProductName.Enabled = true;
            ddlCategory.Enabled = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Products - Products.aspx", ex);
        }

    }


    protected void gvProduct_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            Int64 ProductID = Convert.ToInt64(gvProduct.DataKeys[rowIndex]["ProductID"]);
            //Editing Existing Product Details 
            if (e.CommandName == "History")
            {
                audit_History.ViewAudit_History(ProductID, OrgID, "PRDTSRCH");
                ModelPopProductSearch.Show();
            }
            if (e.CommandName == "productEdit")
            {
                hdnInHandQty.Value = Convert.ToString(gvProduct.DataKeys[rowIndex]["InHandQuantity"]);
                BindProductValues(ProductID);
                if (ddlType.SelectedItem.Text.ToUpper() == "FRAMES" || ddlType.SelectedItem.Text.ToUpper() == "LENS" || ddlType.SelectedItem.Text.ToUpper() == "SUNGLASS")
                 {
                     ScriptManager.RegisterStartupScript(Page, this.GetType(), "WebService", "GetService();", true);
                 }
            }
            if (e.CommandName == "productDelete")
            {
                inventoryBL.DeleteProduct(OrgID, ProductID, LID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:FnClear();", true);
                tdTransblock.Attributes.Add("class", "displaytd");
                tddelete.Attributes.Add("class", "displaytd");
                BindProductList(Convert.ToInt32(hdnCatid.Value), hdnpName.Value);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Product Attributes.", ex);
        }
    }

    private void BindProductValues(long pId)
    {
        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        string Update = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_01 == null ? "Update" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_01;
        hdnLocationList.Value = "";
        btnFinish.Text = Update;

        List<Products> lstProducts = null;
        List<Locations> lstLocations = null;
        List<InventoryItemsBasket> lstInventoryItemsBasket = null;
        List<ProductUOMMapping> lstProductUOM = null;
        new InventoryCommon_BL(ContextInfo).GetSelectedProductDetail(pId, 0, InventoryLocationID, OrgID, out lstProducts, out lstInventoryItemsBasket, out lstProductUOM);
        
        new InventoryCommon_BL(base.ContextInfo).pGetLocationForProduct(pId, out lstLocations);

        hdnId.Value = pId.ToString();


        if (lstLocations!=null && lstLocations.Count > 0)
        {
            foreach (Locations li in lstLocations)
            {
                hdnLocationList.Value += li.LocationID.ToString() + "~" + li.LocationName + "~" + li.ReorderQuantity.ToString() + "~" + li.OrgID + "~" + li.OrgAddressName + "~" + li.MaximumQuantity + "~" + li.StockFrequency + "~" + li.ClientName + "~" + li.IsIndentLocation + "^";

            }
        }
        if (lstProducts != null && lstProducts.Count > 0)
        {
            txtProductName.Text = lstProducts[0].ProductName;
            txtHsnCode.Text = lstProducts[0].HSNCode;//Vijayaraja
            ddlTaxtype.SelectedValue = lstProducts[0].TaxID.ToString();
            //txtProductName.Enabled = false;
            TxtTax.Text = lstProducts[0].TaxPercent.ToString();
            hdnGetTax.Value = lstProducts[0].TaxPercent.ToString();

            txtContainer.Text = lstProducts[0].OrderedConvertUnit.ToString();
            txtPackSize.Text = lstProducts[0].UsageCount.ToString();
            txtConReOrderLevel.Text = lstProducts[0].ReorderConsumptionlevel.ToString();
        
       if (lstProducts[0].Frequency == "Y")
        {
            ddlCategory.Enabled = false;
            //ddlOrdUnit.Enabled = false;
            bUnits.Enabled = false;
            ddlScheduleDrug.Enabled = false;
            ddlType.Enabled = false;
        }
       else
       {
           ddlCategory.Enabled = true;
           ddlOrdUnit.Enabled = true;
           bUnits.Enabled = true;
           ddlScheduleDrug.Enabled = true;
           ddlType.Enabled = true;
       }
        

        //-----Jayamoorthi-------------------------------

        ddlCategory.SelectedValue = lstProducts[0].CategoryID.ToString();
        ddlType.SelectedValue = lstProducts[0].TypeID.ToString();

        //-------******************----------------------
        if (ddlType.SelectedItem.Text.ToUpper() == "OPTICAL")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "WebService", "GetCategory('" + ddlType.SelectedValue + "','" + ddlCategory.SelectedValue + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "WebService", "GetService();", true);

        }
        ViewState["SetAttribute"] = lstProducts[0].Attributes;
        hdnattrip.Value = lstProducts[0].Attributes;
        hdnCatid.Value = lstProducts[0].CategoryID.ToString();
        hdnpName.Value = lstProducts[0].ProductName;
        txtDescription.Text = lstProducts[0].Description;
        ddlScheduleDrug.SelectedValue = string.IsNullOrEmpty(lstProducts[0].IsScheduleHDrug) == true ? "N" : lstProducts[0].IsScheduleHDrug;
        chkisactive.Checked = true;
        txtProductModel.Text = "";
        txtLTofProduct.Text = "";

        tdTransblock.Attributes.Add("class", "displaytd");
        tddelete.Attributes.Add("class", "displaytd");
        chkisactive.Enabled = true;
        txtProductCode.Text = "";
        txtMake.Text = "";

        if (lstProducts[0].IsDeleted == "Y")
        {
            chkisactive.Checked = false;
        }

        if (lstProducts[0].TransactionBlock == "Y")
        {
            ChkTransblock.Checked = true;
        }




        txtMfgName.Text = lstProducts[0].MfgName;
        txtMfgCode.Text = lstProducts[0].MfgCode;

        if (lstProducts[0].TypeID == 5)
        {
            trAsset1.Attributes.Add("class", "displaytr");
            txtProductModel.Text = lstProducts[0].Model;
            txtLTofProduct.Text = lstProducts[0].LTofProduct.ToString();
        }
        else
        {
            txtProductModel.Text = "";
            txtLTofProduct.Text = "";
            trAsset1.Attributes.Add("class", "hide");
        }

        bUnits.SelectedValue = lstProducts[0].LSU.ToString();
        ddlCategory.SelectedValue = lstProducts[0].CategoryID.ToString();
        ddlType.SelectedValue = lstProducts[0].TypeID.ToString();
        txtProductCode.Text = lstProducts[0].ProductCode.ToString();
        txtMake.Text = lstProducts[0].Make.ToString();
       // var ddlText = !string.IsNullOrEmpty(lstProducts[0].OrderedUnit.ToString()) ? lstProducts[0].OrderedUnit.ToString() : "0";
       // ddlOrdUnit.Items.FindByText(ddlText).Selected = true;
       
        cheIsNorcotic.Checked = lstProducts[0].IsNorcotic == "Y" ? true : false;


        hdnGenericID.Value = lstProducts[0].ParentProductID.ToString();//genericID
        txtGenericName.Text = lstProducts[0].Notes;
        ChkIsConsign.Checked = lstProducts[0].IsConsign == "Y" ? true : false;
        ChkIsConsign.Enabled = false;

        if (lstLocations.Count > 0)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadLocation", "tableLocationList();", true);
        }

        hdnProductList.Value = lstProducts[0].HasAttributes;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "POPUP", "SetProductsAttributes();", true);
        ddlDeptGroup.SelectedValue = lstProducts[0].PDeptGroup;
        txtshelfLife.Text = string.IsNullOrEmpty(lstProducts[0].ShelfPeriod.ToString()) ? string.Empty : lstProducts[0].ShelfPeriod.ToString();
        ddlShelfLife.SelectedValue = lstProducts[0].ShelfPeriodCode;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "DepartmentGroup", "DepartmentGroupBasedHideShow();", true);


        if (lstProductUOM.Count > 0)
        {

            var lst = lstProductUOM.Select(x => new {x.ProductUOMID,x.ProductID, x.UOMID, x.UOMCode, x.LSU, x.IsBaseunit, x.ConvesionQty, x.Action });
            hdnProductUomList.Value = oSerializer.Serialize(lst);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "AssignProductUOM", "AssignProductUOM();", true);
        }
        
        

        if (lstInventoryItemsBasket.Count > 0)
        {
            TextBox txtAddPurchasePrice = (TextBox)Page.FindControl("ucProductAttributes").FindControl("txtAddPurchasePrice");
            txtAddPurchasePrice.Text = lstInventoryItemsBasket[0].UnitPrice.ToString();
            TextBox txtDiscount = (TextBox)Page.FindControl("ucProductAttributes").FindControl("txtDiscount");
            txtDiscount.Text = lstInventoryItemsBasket[0].Discount.ToString();
            TextBox txtInverseQuantity = (TextBox)Page.FindControl("ucProductAttributes").FindControl("txtInverseQuantity");
            txtInverseQuantity.Text = lstInventoryItemsBasket[0].InvoiceQty.ToString();
            if (((DropDownList)Page.FindControl("ucProductAttributes").FindControl("ddlSupplierName")).Items.FindByValue(lstInventoryItemsBasket[0].SupplierId.ToString()) != null)
            {
                ((DropDownList)Page.FindControl("ucProductAttributes").FindControl("ddlSupplierName")).ClearSelection();
                ((DropDownList)Page.FindControl("ucProductAttributes").FindControl("ddlSupplierName")).Items.FindByValue(lstInventoryItemsBasket[0].SupplierId.ToString()).Selected = true;
            }
        }
    }
	}

    public bool CheckIsMandatory(object Values)
    {
        if (Values == "Y")
        {
            return true;
        }
        else
        {
            return false;
        }
    }


    protected void gvProduct_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket PQ = (InventoryItemsBasket)e.Row.DataItem;
            LinkButton lnkBtnDelete = ((LinkButton)e.Row.FindControl("btnDelete"));
            LinkButton lnkBtnEdit = ((LinkButton)e.Row.FindControl("btnEdit"));
            lnkBtnEdit.Attributes.Add("title", "Click to Edit");
            lnkBtnDelete.Enabled = false;
            lnkBtnDelete.Attributes.Remove("class");
            lnkBtnDelete.Attributes.Remove("title");
            lnkBtnDelete.Attributes.Add("title", "InActive Product");
            lnkBtnDelete.Attributes.Add("class", "ui-icon ui-icon-circle-close marginL10  pull-left");
            if (PQ.Unit == "N")
            {
                lnkBtnDelete.Enabled = true;
                lnkBtnDelete.Attributes.Remove("class");
                lnkBtnDelete.Attributes.Remove("title");
                lnkBtnDelete.Attributes.Add("title", "Click to De-Activate Product");
                lnkBtnDelete.Attributes.Add("class", "ui-icon ui-icon-circle-check marginL10 pointer pull-left");
                lnkBtnDelete.Attributes.Add("onclick", "return ProQuantityCheck ('" + PQ.ProductID + "','" + PQ.InHandQuantity + "');");
            }
        }

    }

    public List<ProductLocationMapping> GetLocationCollectedItems()
    {

        List<ProductLocationMapping> lstProductLocationMapping = new List<ProductLocationMapping>();

        ProductLocationMapping objProductLocationMapping = new ProductLocationMapping();
        objProductLocationMapping.ProductID = Int64.Parse(hdnId.Value);
        objProductLocationMapping.LocationID = Convert.ToInt32(InventoryLocationID);
        objProductLocationMapping.ReorderQuantity = Convert.ToInt32(0);
        objProductLocationMapping.OrgId = Convert.ToInt32(OrgID);
        lstProductLocationMapping.Add(objProductLocationMapping);

        return lstProductLocationMapping;
    }


    public void GetProductsAttributes()
    {
        List<ProductsAttributesMaster> lstProductsAttributesMaster = new List<ProductsAttributesMaster>();
        new InventoryCommon_BL(ContextInfo).GetProductsAttributes(out lstProductsAttributesMaster);

        divProductAttributes.InnerHtml = string.Empty;
        StringBuilder sb = new StringBuilder();
        if (lstProductsAttributesMaster.Count > 0)
        {
            sb.Append(StockRow(lstProductsAttributesMaster));
            lblAttributes.Visible = true;
        }
        else
        {
            lblAttributes.Visible = false;
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
            int checkBoxControlCount = lstProductsAttributesMaster.Where(PAM => PAM.ControlName == "checkbox").Count();
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
                        getCategories = GetChktBox(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText, checkBoxControlCount);
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
        sb.Append("<table id='tblSRRow' class='w-100p' cellpadding='4'>");
        sb.Append(sbBody);
        sb.Append("</table>");

        return sb;
    }


    protected string GetTextBox(string ID, string AttributeName, string TXTValue)
    {
        return "<TR><td>" + TXTValue + "</td><td> <input class='w-150' type='text' id='" + AttributeName + '~' + ID + "'  /></td></TR>";
    }

    protected string GetChktBox(string ID, string AttributeName, string TXTValue, int checkBoxControlCount)
    {
        string strReturn = string.Empty;
        int tdCount = 5;
      

        if (tdCurrentCount == 0)
        {
            strReturn = "<TR>";
           
        }
        if (tdCurrentCount <= tdCount)
        {
            strReturn += "<td><input class='marginL0' type='checkbox' id='" + AttributeName + '~' + ID + "'  />" + TXTValue + "</td>";
            tdCurrentCount += 1;
            TotaltdCount += 1;
        }
        if (tdCount == tdCurrentCount || TotaltdCount == checkBoxControlCount)
        {
            strReturn += "</TR>";
            tdCurrentCount = 0;
        }

        return strReturn;
    }

    protected string GetDropDownList(string ID, string AttributeName, string TXTValue)
    {
        string select = Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_16 == null ? "--select--" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Products_aspx_16;
        string strDDL = string.Empty;
        strDDL += "<TR><td>" + TXTValue + "</td><td> <select class='w-50' id='" + AttributeName + '~' + ID + "'>";
        strDDL += "<option value='--select--'>'"+select+"'</option>";
        strDDL += "</select></td></TR>";
        return strDDL;
    }

    protected List<ProductsAttributesDetails> GetProductsAttributesDetails()
    {
        List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
        ProductsAttributesDetails objInventoryAttributesMaster;        
        if (hdnAttributes.Value != "")
        {
           
            XmlDocument xml = new XmlDocument();
            string ReplaceAndSymble = string.Empty;
            ReplaceAndSymble = hdnAttributes.Value;
            if (!string.IsNullOrEmpty(ReplaceAndSymble))
            {
                ReplaceAndSymble = ReplaceAndSymble.Replace("&", "&amp;");
                xml.LoadXml(ReplaceAndSymble);
            }
            else
            {
                xml.LoadXml(hdnAttributes.Value);
            }
            XmlNodeList xnList = xml.SelectNodes("/Products/Attributes");
            
            foreach (XmlNode xn in xnList)
            {
                if (xn["AttributeKey"].InnerText != "ProductCode")
                {
                    objInventoryAttributesMaster = new ProductsAttributesDetails();
                    objInventoryAttributesMaster.AttributeID = Convert.ToInt32(xn["AttributeID"].InnerText);

                    if (!string.IsNullOrEmpty(xn["AttributeValue"].InnerText))
                    {
                        xn["AttributeValue"].InnerText = xn["AttributeValue"].InnerText.Replace("&amp;", "&");
                    }
                    else
                    {

                        xn["AttributeValue"].InnerText = xn["AttributeValue"].InnerText;
                    }
                    objInventoryAttributesMaster.AttributesValue = xn["AttributeValue"].InnerText;

                    objInventoryAttributesMaster.AttributesKey = xn["AttributeKey"].InnerText;
                    lstProductsAttributesDetails.Add(objInventoryAttributesMaster);
                }
            }
        }

        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
           
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

    protected void TaxMandatoryConfig()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ProductMand", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            hdnProductMand.Value = lstInventoryConfig[0].ConfigValue;
            if (hdnProductMand.Value == "Y")
            {
                lblTax.Text = "VAT";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Vattax", "javascript:showMandatory('Y');", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Vattax", "javascript:showMandatory('N');", true);
        }
    }

    public void LoadMetaData()
    {

        long returncode = -1;
        string LangCode = LanguageCode;

        List<MetaData> lstMetadataInput = new List<MetaData>();
        List<MetaData> lstMetadataOutput = new List<MetaData>();



        try
        {

            lstMetadataInput.Add(new MetaData() { Domain = "ScheduleHDrugItems" });
            lstMetadataInput.Add(new MetaData() { Domain = "ProductDeptGroup" });
            lstMetadataInput.Add(new MetaData() { Domain = "StockFrequency" });
            lstMetadataInput.Add(new MetaData() { Domain = "ShelfLifeDuration" });

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstMetadataInput, OrgID, LangCode, out lstMetadataOutput);

            if (lstMetadataInput.Count > 0)
            {
                var lstScheduleDrug = from child in lstMetadataOutput
                                      where child.Domain == "ScheduleHDrugItems"
                                      select child;

                ddlScheduleDrug.DataTextField = "DisplayText";
                ddlScheduleDrug.DataValueField = "Code";
                ddlScheduleDrug.DataSource = lstScheduleDrug;
                ddlScheduleDrug.DataBind();
                  ddlScheduleDrug.Items.Insert(0, GetMetaData("Select", "N"));
                  ddlScheduleDrug.Items[0].Value = "N";

                  var lstProductDeptGroup = (from child in lstMetadataOutput
                                             where child.Domain == "ProductDeptGroup"
                                             select child).ToList();
                ddlDeptGroup.DataTextField = "DisplayText";
                ddlDeptGroup.DataValueField = "Code";

                ddlDeptGroup.DataSource = lstProductDeptGroup;
                ddlDeptGroup.DataBind();

                
                
                var lstStockFrequency = from child in lstMetadataOutput
                                        where child.Domain == "StockFrequency"
                                        select child;
                rblStockTakingFrequency.DataTextField = "DisplayText";
                rblStockTakingFrequency.DataValueField = "Code";

                rblStockTakingFrequency.DataSource = lstStockFrequency;
                rblStockTakingFrequency.DataBind();
                rblStockTakingFrequency.Items[0].Selected = true;


                var lstDuration = from child in lstMetadataOutput
                                  where child.Domain == "ShelfLifeDuration"
                                  select child;
                ddlShelfLife.DataTextField = "DisplayText";
                ddlShelfLife.DataValueField = "Code";

                ddlShelfLife.DataSource = lstDuration;
                ddlShelfLife.DataBind();
           

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load the value for ScheduleHDrug Item from Metadata", ex);
        }
    }
    private void LoadTaxmaster()
    {
        long returnCode = -1;
        List<Taxmaster> lsttaxmaster = null;
        InventoryCommon_BL objGeneralMasterBL = new InventoryCommon_BL(base.ContextInfo);
        returnCode = objGeneralMasterBL.GetTaxMaster(OrgID, out lsttaxmaster);
        if (lsttaxmaster != null && lsttaxmaster.Count > 0)
        {

            var childItems1 = from child in lsttaxmaster
                              where child.TaxTypeName == "Goods" //orderby child .MetaDataID
                              select child;
            ddlTaxtype.DataSource = childItems1;
            ddlTaxtype.DataTextField = "TaxName";
            ddlTaxtype.DataValueField = "TaxID";
            ddlTaxtype.DataBind();
            ListItem liSelect1 = GetMetaData("Select", "0");
            if (liSelect1 != null)
            {
                ddlTaxtype.Items.Insert(0, liSelect1);
            }
        }
        
    }
}
