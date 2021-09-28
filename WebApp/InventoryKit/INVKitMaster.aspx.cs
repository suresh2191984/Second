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
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryKit.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;


public partial class Inventory_INVKitMaster : Attune_BasePage
{
    public Inventory_INVKitMaster()
        : base("InventoryKit_INVKitMaster_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL InventoryBL;
    List<Locations> lstInvLocation = new List<Locations>();
    List<ProductType> lstProductType = new List<ProductType>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    long CategoryID = 0;
    int TypeID = 0;
    string CategoryName = string.Empty;
    string IsTransactionBlock = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        InventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadKitDetails();
            BindCategory();
            BindProductType();
            LoadUnit();
            AutoCompleteExtender2.ContextKey = "0";
        }
    }
    public void LoadKitDetails()
    {
        long returnCode = -1;
        InventoryKit_BL InvKit = new InventoryKit_BL();
        List<InventoryItemsBasket> listproductdetails = new List<InventoryItemsBasket>();
        List<KitMaster> lstKitMaster = new List<KitMaster>();
        try
        {
            returnCode = InvKit.GetKitDetails(OrgID, out lstKitMaster);
            if (lstKitMaster.Count > 0)
            {
                foreach (KitMaster item in lstKitMaster)
                {
                    hdnSetListTable.Value += item.ProductName + "^";
                }

            }

            ddlSelectKit.DataSource = lstKitMaster;
            ddlSelectKit.DataTextField = "ProductName";
            ddlSelectKit.DataValueField = "ProductID";
            ddlSelectKit.DataBind();
            string select = Resources.InventoryKit_ClientDisplay.InventoryKit_Select;
            //select = select == null ? "--Select--" : select;
            ddlSelectKit.Items.Insert(0, GetMetaData("Select", "0"));
            ddlSelectKit.SelectedValue = "0";
            ddlSelectKit.Focus();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetKitDetails", ex);
        }
    }
    private void BindCategory()
    {
        InventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        lstProductCategories = lstProductCategories.FindAll(p => p.CategoryName == "KIT");
        ddlCategory.DataSource = lstProductCategories;
        ddlCategory.DataTextField = "CategoryName";
        ddlCategory.DataValueField = "CategoryID";
        ddlCategory.DataBind();
        ddlCategory.SelectedIndex = 0;
        //ddlCategory.Items.Insert(0, "--Select category--");
        //ddlCategory.Items[0].Value = "0";

    }



    public void LoadUnit()
    {


        InventoryBL.GetInventoryUOM(out lstInventoryUOM);
        bUnits.DataSource = lstInventoryUOM;
        bUnits.DataTextField = "UOMCode";
        bUnits.DataValueField = "UOMCode";
        bUnits.DataBind();
        string select = Resources.InventoryKit_ClientDisplay.InventoryKit_Select;
        //select =select== null ? "--Select--" : select;
        bUnits.Items.Insert(0, GetMetaData("Select", "0"));
        bUnits.Items[0].Value = "0";



    }



    private void BindProductType()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        int OrgAddid = 0;
        //int OrgAddid = ILocationID;
        //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
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
        new Master_BL(ContextInfo ).GetInvLocationDetail(OrgID, OrgAddid, out lstInvLocation);
        System.Data.DataTable dt = new DataTable();
        lstInvLocation.RemoveAll(p => p.LocationID != InventoryLocationID);
        //if (lstInvLocation.Count > 0)
        //{
        //    string[] tname = lstInvLocation[0].TypeName.Split(',');
        //    string[] tid = lstInvLocation[0].ProductTypeID.Split(',');
        //    DataColumn dc1 = new DataColumn("TypeName");
        //    DataColumn dc2 = new DataColumn("ProductTypeID");
        //    dt.Columns.Add(dc1);
        //    dt.Columns.Add(dc2);
        //    for (int i = 0; i < tname.Length; i++)
        //    {
        //        if (tname[i] != "")
        //        {
        //            if (tname[i] == "Kit")
        //            {
        //                DataRow dr1 = dt.NewRow();
        //                dr1["TypeName"] = tname[i];
        //                dr1["ProductTypeID"] = tid[i];
        //                dt.Rows.Add(dr1);
        //            }
        //        }
        //    }

        //    ddlType.DataSource = dt;
        //    ddlType.DataTextField = "TypeName";
        //    ddlType.DataValueField = "ProductTypeID";
        //    ddlType.DataBind();
        //    ddlType.SelectedIndex = 0;

           
        //}
        ListItem ddlselect;
        ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }

        List<ProductType> lstProductType = new List<ProductType>();
        new InventoryCommon_BL(ContextInfo).GetProductType(OrgID, out lstProductType);
        ddlType.DataSource = lstProductType;
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "TypeID";
        ddlType.DataBind();
        ddlType.Items.Insert(0, ddlselect);
        //ddlType.Items.Insert(0, "--Select Product Type--");
        //ddlType.Items[0].Value = "0";

    }

    protected void ddlSelectKit_SelectedIndexChanged(object sender, EventArgs e)
    {
        hdnSelectKit.Value = "";
        long MasterKitID = 0;
        Int64.TryParse(ddlSelectKit.SelectedValue, out MasterKitID);
        long returnCode = -1;
        InventoryKit_BL InventoryBL = new InventoryKit_BL(base.ContextInfo);
        List<InventoryItemsBasket> listproductdetails = new List<InventoryItemsBasket>();
        try
        {
            if (MasterKitID > 0)
            {
                returnCode = InventoryBL.pGetKitMasterDetails(OrgID, InventoryLocationID, MasterKitID, out listproductdetails);
            }
            if (listproductdetails.Count > 0)
            {
                foreach (InventoryItemsBasket item in listproductdetails)
                {

                    hdnSelectKit.Value += item.Description + "^";
                    hdnCanedit.Value = item.Type;
                }
                txtMfgName.Text = listproductdetails[0].Name;
                //if (listproductdetails[0].RECQuantity > 0)
                //{
                //    btnSave.Visible = false;
                //}
                ddlType.SelectedValue = Convert.ToString(listproductdetails[0].UsageCount);
                if (listproductdetails[0].IsTransactionBlock == "N")
                {
                    chkIsActive.Checked = true;
                    //tdIsActive.Attributes.Add("style", "block");
                }
                else
                {
                    chkIsActive.Checked = false;
                }

            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loa1dSrd", "  TbList();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetMappedProduct", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        InventoryKit_BL InventoryBL = new InventoryKit_BL(base.ContextInfo);
        List<InventoryItemsBasket> lstItemBasket = new List<InventoryItemsBasket>();
        try
        {
            foreach (string listParent in hdnKitDetails.Value.Split('^'))
            {
                if (listParent != "")
                {
                    InventoryItemsBasket ItemBasket = new InventoryItemsBasket();
                    string[] listChild = listParent.Split('~');
                    ItemBasket.CategoryName = txtNewKitName.Text.Trim();
                    ItemBasket.ProductName = listChild[0];
                    ItemBasket.Quantity = Convert.ToDecimal(listChild[1]);
                    ItemBasket.ProductID = Int32.Parse(listChild[2]);
                    ItemBasket.ID = Int32.Parse(listChild[3]);
                    ItemBasket.UOMID = Int32.Parse(ddlSelectKit.SelectedValue);
                    ItemBasket.ExpiryDate = DateTimeNow;
                    ItemBasket.Manufacture =DateTimeNow;
                    ItemBasket.Providedby = LID;
                    ItemBasket.CategoryID = ILocationID; //---OrgAddressID 
                    lstItemBasket.Add(ItemBasket);
                }
            }
            CategoryID = Convert.ToInt64(ddlCategory.SelectedValue);
            TypeID = Convert.ToInt16(ddlType.SelectedValue);
            CategoryName = ddlCategory.SelectedItem.Text;
            IsTransactionBlock = chkIsActive.Checked ? "N" : "Y";
            // , Productname, ProductID, ProductCode, CategoryID, TypeID, Make, Model, MfgName, MfgCode, Description, LSU, CategoryName);
             string Iscommon = chkCommon.Checked==true?"Y":"N";
             string IsDelete = Convert.ToString(hdnIsDelete.Value.TrimEnd(','));

            returnCode = InventoryBL.SaveKitMaster(OrgID, InventoryLocationID, lstItemBasket, txtNewKitName.Text, 0, txtProductCode.Text,
            CategoryID, TypeID, txtMake.Text, txtProductModel.Text, txtMfgName.Text, txtMfgCode.Text, txtDescription.Text, "Nos", CategoryName, InventoryLocationID, IsTransactionBlock, Iscommon,IsDelete);
            if (returnCode > 0)
            {
                txtNewKitName.Text = "";
                txtMake.Text = "";
                txtProductModel.Text = "";
                txtMfgName.Text = "";
                txtMfgCode.Text = "";
                txtDescription.Text = "";
                CategoryName = "";
                txtProductCode.Text = "";
                TypeID = 0;
                CategoryID = 0;

                string sPath = Resources.InventoryKit_AppMsg.InventoryKit_INVKitMaster_aspx_KitSave;
                string infoMsg = Resources.InventoryKit_AppMsg.InventoryKit_Information;
                sPath = sPath == null ? "Kit Definition Saved Successfully" : sPath;
                infoMsg = infoMsg == null ? "Information" : infoMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:ValidationWindow('" + sPath + "','" + infoMsg + "');", true);
                LoadKitDetails();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing SaveInventoryItem", ex);
        }
    }

}