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
using System.Text;
using System.Globalization;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.InventoryCommon.BL;

public partial class Inventory_ProductCategories : Attune_BasePage
{
    public Inventory_ProductCategories()
        : base("InventoryMaster_ProductCategories_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    ProductCategories objProductCategories = new ProductCategories();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryMaster_BL inventoryBL;
  //  string Update = Resources.ClientSideDisplayTexts.Common_Update;
    string Update = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_Update;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string Inventory_Attributes_Value = "N";

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        try
        {
            lblmsg.Text = "";
            if (!IsPostBack)
            {
               if(isCorporateOrg=="Y")
			    lblTax.Attributes.Add("class","hide");
                Session["CategoryName"] = string.Empty;
                LoadCategory(string.Empty);
                LoadAttributes();
                GetTaxType();
               // new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_CategoryBased_AttributesMapping", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    Inventory_Attributes_Value = lstInventoryConfig[0].ConfigValue;
                    hdnInventory_Attributes_Value.Value = lstInventoryConfig[0].ConfigValue;
                }
                else
                {
                    Inventory_Attributes_Value = "N";
                    hdnInventory_Attributes_Value.Value = "N";
                }
                if (Inventory_Attributes_Value == "N")
                {
                    trPSearch.Visible = false;
                    pnlPSearch.Visible = false;
                    //Panel1.Visible = false;
                    
                }
                if (isCorporateOrg == "Y")
                {
                    hdnIsCorpOrg.Value = "Y";
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - ProductCategories.aspx", ex);
            
        }
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string update=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_Update==null?"Update":
        Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_Update);
        try
        {
            if (hdnStatus.Value == "Update")
            {
                SaveProductCategories();
                string userMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_01 == null ? "Category has been updated successfully!" : Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_01;
                string informMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Information == null ? "Information" : Resources.InventoryMaster_AppMsg.InventoryMaster_Information;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey4", "javascript:ValidationWindow('" + userMsg + "','" + informMsg + "');", true);
            }
            else
            {
                long CategoryStatus;
                string categoryName = txtCategoryName.Text;
                int pOrgID = 0;
                Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
                CategoryStatus = inventoryBL.pCheckProductCategoryName(categoryName, pOrgID);
                if (CategoryStatus == 0)
                {
                    string strmsg = Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_alreadyexistsy == null?"Category Already Exist":Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_alreadyexistsy;
                    lblmsg.Text = strmsg;
                }
                else
                {
                    string strmsg = Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_CategorySuccess == null ? "Category has been added successfully" : Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_CategorySuccess;
                    var errorMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Error" :Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
                     SaveProductCategories();
                     ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey3", "javascript:ValidationWindow('" + strmsg + "','" + errorMsg + "');", true);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Product Categories - ProductCategories.aspx", ex);
          
        }

    }


    public void SaveProductCategories()
    {


        long returnCode = -1;
        string categoryName = string.Empty;
        string description = string.Empty;

        categoryName = txtCategoryName.Text.Trim();
        description = txtDescription.Text.Trim();


        objProductCategories.CategoryName = categoryName;
        objProductCategories.Description = description;
        objProductCategories.CreatedBy = LID;
        objProductCategories.OrgID = OrgID;
        objProductCategories.CategoryID = Int32.Parse(hdnId.Value);
        objProductCategories.DeptID = 0;
        objProductCategories.OrgAddressID = ILocationID;
        if (chkDelete.Checked)
        {
            objProductCategories.IsDeleted = "N";
        }
        else
        {
            objProductCategories.IsDeleted = "Y";
        }

        CategorieAttributesMapping objInventoryAttributesMaster;
        List<CategorieAttributesMapping> lstInventoryAttributesMaster = new List<CategorieAttributesMapping>();


        if (!string.IsNullOrEmpty(hdnAttributesDetails.Value))
        {


            string[] MainSplit = hdnAttributesDetails.Value.Split('^');

            for (int j = 0; j < MainSplit.Length; j++)
            {
                if (!string.IsNullOrEmpty(MainSplit[j]))
                {
                    objInventoryAttributesMaster = new CategorieAttributesMapping();
                    string[] SubSplit = MainSplit[j].Split('#');
                    objInventoryAttributesMaster.AttributeID = Convert.ToInt32(SubSplit[0]);
                    objInventoryAttributesMaster.IsMandatory = SubSplit[2] == "true" ? true : false;
                    lstInventoryAttributesMaster.Add(objInventoryAttributesMaster);
                }
            }

        }
        List<TaxCategoriesMapping> lstTaxCategoriesMapping = new List<TaxCategoriesMapping>();
        TaxCategoriesMapping objTaxCategoriesMapping;
        if (!string.IsNullOrEmpty(hdnItemDetails.Value))
        {

            string[] MainSplit = hdnItemDetails.Value.Split('$');

            for (int j = 0; j < MainSplit.Length; j++)
            {
                if (!string.IsNullOrEmpty(MainSplit[j]))
                {
                    objTaxCategoriesMapping = new TaxCategoriesMapping(); string[] SubSplit = MainSplit[j].Split('~');
                    objTaxCategoriesMapping.OrgID = OrgID;
                    objTaxCategoriesMapping.TaxTypeID = Convert.ToInt32(SubSplit[0]);
                    objTaxCategoriesMapping.StateID = Convert.ToInt32(SubSplit[1]);
                    objTaxCategoriesMapping.Tax = Convert.ToDecimal(SubSplit[3]);
                    CultureInfo provider = CultureInfo.InvariantCulture;
                    objTaxCategoriesMapping.ValidFrom = DateTime.ParseExact(SubSplit[5], "dd/mm/yyyy", provider);
                    objTaxCategoriesMapping.ValidTo = DateTime.ParseExact(SubSplit[6], "dd/mm/yyyy", provider);
                    objTaxCategoriesMapping.OutputTaxTypeID = Convert.ToInt32(SubSplit[7]);
                    objTaxCategoriesMapping.OutputTax = Convert.ToDecimal(SubSplit[9]);
                    lstTaxCategoriesMapping.Add(objTaxCategoriesMapping);
                }
            }

        }

        returnCode = inventoryBL.SaveProductCategories(objProductCategories, lstTaxCategoriesMapping, lstInventoryAttributesMaster);
        if (returnCode == 0)
        {
            string strCategoryTxt = string.Empty;
            try
            {
                strCategoryTxt = Session["CategoryName"].ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while  executing SaveProductCategories in ProductCategories", ex);
                strCategoryTxt = string.Empty;
            }
            LoadCategory(strCategoryTxt);
            Session["CategoryName"] = string.Empty;

            lblmsg.ForeColor = System.Drawing.Color.Black;

            if (hdnStatus.Value == Update)
            {
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_01;
            }
            else
            {
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_02;
            }
            clearFields();
            hdnCategoryToBeDel.Value = "";
            hdnCategorieAttributesMapping.Value = "";
            //hdnAttributesDetails.Value = "";
            hdnItemDetails.Value = "";
        }
        else
        {

            lblmsg.ForeColor = System.Drawing.Color.Red;

            if (hdnStatus.Value == Update)
            {
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_03;
            }
            else
            {
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_04;
            }
            clearFields();
            hdnCategoryToBeDel.Value = "";
            hdnCategorieAttributesMapping.Value = "";
           // hdnAttributesDetails.Value = "";
            hdnItemDetails.Value = "";

        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "javascript:FnClear();", true);


    }

    private void clearFields()
    {
        txtCategoryName.Text = "";
        txtDescription.Text = "";
        hdnId.Value = "0";
        hdnStatus.Value = "";
    }
    string ErrMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Error == null ? "Alert" : Resources.InventoryMaster_AppMsg.InventoryMaster_Error;
    string Msg = Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_02 == null ? "No Matching Records Found" : Resources.InventoryMaster_AppMsg.InventoryMaster_ProductCategories_aspx_02;
    private void LoadCategory(string str)
    {

       // new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_CategoryBased_AttributesMapping", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            Inventory_Attributes_Value = lstInventoryConfig[0].ConfigValue;
            hdnInventory_Attributes_Value.Value = lstInventoryConfig[0].ConfigValue;
        }
        else
        {
            Inventory_Attributes_Value = "N";
            hdnInventory_Attributes_Value.Value = "N";
        }
        new InventoryCommon_BL(ContextInfo).GetAllCategory(OrgID, ILocationID, str, out lstInventoryItemsBasket);
        if (lstInventoryItemsBasket.Count > 0)
        {
            gvCategory.DataSource = lstInventoryItemsBasket;
            gvCategory.DataBind();
            if (isCorporateOrg == "Y")
                gvCategory.Columns[2].Visible = false;

            if (Inventory_Attributes_Value == "N")
            {
                gvCategory.Columns[2].Visible = false;
                gvCategory.Columns[4].Visible = false;
                gvCategory.Columns[6].Visible = false;
            }
            gvCategory.Visible = true;
            tblCategoryGrid.Visible = true;

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

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string categoryName = string.Empty;
            string description = string.Empty;
            categoryName = txtCategoryName.Text;
            description = txtDescription.Text;
            objProductCategories.CategoryName = categoryName;
            objProductCategories.Description = description;
            objProductCategories.CreatedBy = LID;
            objProductCategories.OrgID = OrgID;
            objProductCategories.CategoryID = Int32.Parse(hdnId.Value);
            objProductCategories.DeptID = 0;
            objProductCategories.OrgAddressID = ILocationID;
            returnCode = inventoryBL.DeleteProductCategories(objProductCategories);
            if (returnCode == 0)
            {
                LoadCategory(string.Empty);
                lblmsg.ForeColor = System.Drawing.Color.Black;
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_05;
                txtCategoryName.Text = "";
                txtDescription.Text = "";
                hdnId.Value = "0";
                hdnStatus.Value = "";



            }
            else
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Text = Resources.InventoryMaster_ClientDisplay.InventoryMaster_ProductCategories_aspx_06;
            }
            hdnCategoryToBeDel.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Deleteing Product Categories - ProductCategories.aspx", ex);
           
        }
    }

    protected void gvCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvCategory.PageIndex = e.NewPageIndex;
            LoadCategory(string.Empty);
            txtCategoryName.Text = "";
            txtDescription.Text = "";
            hdnId.Value = "0";
        }
    }

    protected void gvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Search1")
            {
                TextBox txt = (TextBox)gvCategory.HeaderRow.Cells[1].FindControl("txtCategoryNameWiseSearch");
                Session["CategoryName"] = txt.Text.Trim();
                LoadCategory(txt.Text.Trim());
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  ", ex);
        }
    }
    protected void gvCategory_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void LoadAttributes()
    {
        List<InventoryAttributesMaster> lstInventoryAttributesMaster = new List<InventoryAttributesMaster>();
        inventoryBL.GetInventoryAttributes(out lstInventoryAttributesMaster);

        if (lstInventoryAttributesMaster.Count > 0)
        {

            lstBoxAttributes.DataSource = lstInventoryAttributesMaster;
            lstBoxAttributes.DataTextField = "AttributeName";
            lstBoxAttributes.DataValueField = "AttributeID";
            lstBoxAttributes.DataBind();
            for (int i = 0; i < lstInventoryAttributesMaster.Count; i++)
            {
                if (hdnAttributesDetails.Value == "")
                    hdnAttributesDetails.Value = lstInventoryAttributesMaster[i].AttributeID.ToString()+'#'+ lstInventoryAttributesMaster[i].AttributeName.ToString() +"#true^";
               else
                    hdnAttributesDetails.Value += lstInventoryAttributesMaster[i].AttributeID.ToString()+'#'+ lstInventoryAttributesMaster[i].AttributeName.ToString() +"#true^";
            }

        }
    }
    protected void gvCategory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputRadioButton rdSel = (HtmlInputRadioButton)e.Row.FindControl("rdSel");
            Label lblActive = (Label)e.Row.FindControl("lblActive");
            Label lblAttributes = (Label)e.Row.FindControl("lblAttributes");
            Image ImgActive = (Image)e.Row.FindControl("ImgActive");
            Image ImgDeActive = (Image)e.Row.FindControl("ImgDeActive");
            Image ImgSeqnumber = (Image)e.Row.FindControl("ImgSeqnumber");
            Image ImgAttributes = (Image)e.Row.FindControl("ImgAttributes");
            Label lblContent = (Label)e.Row.FindControl("lblContent");
            Label lblTax = (Label)e.Row.FindControl("lblTax");
            Label lblTaxDetails = (Label)e.Row.FindControl("lblTaxDetails");
            Label lblCatename = (Label)e.Row.FindControl("lblCatename");

            string[] x = lblAttributes.Text.Split('~');

            if (lblActive.Text == "Active")
            {
                ImgActive.Visible = true;
                ImgDeActive.Visible = false;
            }
            else
            {
                ImgActive.Visible = false;
                ImgDeActive.Visible = true;
            }

            rdSel.Attributes.Add("onclick", "CheckOnOff('" + rdSel.ClientID + "','gvCategory');SetValues('" + lblCatename.Text + "','" + lblTax.Text + "');");

            if (Inventory_Attributes_Value != "N")
            {
                ImgSeqnumber.Attributes.Add("onclick", "ShowSeqNumber('" + lblCatename.Text + "')");
                if (!string.IsNullOrEmpty(x[5]))
                {
                    e.Row.Cells[4].Attributes.Add("Onclick", "showTooltip('" + lblContent.ClientID + "','" + x[5] + "');");

                }

                if (!string.IsNullOrEmpty(lblTax.Text))
                {
                    e.Row.Cells[2].Attributes.Add("Onclick", "showTaxTooltip('" + lblTaxDetails.ClientID + "','" + lblTax.Text + "');");


                }
                e.Row.Cells[0].Attributes.Add("onmouseout", "showTooltipout('" + lblContent.ClientID + "');showTaxTooltipout('" + lblTaxDetails.ClientID + "');");
                e.Row.Cells[1].Attributes.Add("onmouseout", "showTooltipout('" + lblContent.ClientID + "');showTaxTooltipout('" + lblTaxDetails.ClientID + "');");
                e.Row.Cells[3].Attributes.Add("onmouseout", "showTooltipout('" + lblContent.ClientID + "');showTaxTooltipout('" + lblTaxDetails.ClientID + "');");
                e.Row.Cells[5].Attributes.Add("onmouseout", "showTooltipout('" + lblContent.ClientID + "');showTaxTooltipout('" + lblTaxDetails.ClientID + "');");
                e.Row.Cells[4].Attributes.Add("onmouseout", "showTaxTooltipout('" + lblTaxDetails.ClientID + "');");
                e.Row.Cells[2].Attributes.Add("onmouseout", "showTooltipout('" + lblContent.ClientID + "');");
            }



        }
    }

    private void GetTaxType()
    {
        List<Taxmaster> lstInventoryTaxMaster = new List<Taxmaster>();
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();

        new InventoryMaster_BL(base.ContextInfo).GetTaxType(out lstInventoryTaxMaster, out lstOrganizationAddress);
        if (lstInventoryTaxMaster != null && lstInventoryTaxMaster.Count > 0)
        {
            ddlTaxTypeId.DataSource = lstInventoryTaxMaster;
            ddlTaxTypeId.DataTextField = "TaxName";
            ddlTaxTypeId.DataValueField = "TaxID";
            ddlTaxTypeId.DataBind();

            ddlTaxType.DataSource = lstInventoryTaxMaster;
            ddlTaxType.DataTextField = "TaxName";
            ddlTaxType.DataValueField = "TaxID";
            ddlTaxType.DataBind();
        }
        else
        {
            trPSearch.Attributes.Add("class", "hide");
        }
        
        ddlTaxTypeId.Items.Insert(0, GetMetaData("Select","0"));
        ddlTaxTypeId.Items[0].Value = "0";
        ddlTaxType.Items.Insert(0, GetMetaData("Select", "0"));
        ddlTaxType.Items[0].Value = "0";
        if (lstOrganizationAddress != null && lstOrganizationAddress.Count > 0)
        {
            ddlState.DataSource = lstOrganizationAddress;
            ddlState.DataTextField = "OtherStateName";
            ddlState.DataValueField = "StateID";
            ddlState.DataBind();
        }
        ddlState.Items.Insert(0, GetMetaData("Select", "0"));
        ddlState.Items[0].Value = "0";
        ddlState.SelectedValue = StateID.ToString();

        hdnTaxDetails.Value = "";
        foreach (Taxmaster item in lstInventoryTaxMaster)
        {
            hdnTaxDetails.Value = hdnTaxDetails.Value + item.TaxID.ToString() + "~" + item.TaxName + "~" + item.TaxPercent + "#";
        }

        hdnTrustorg.Value = "";
        foreach (OrganizationAddress item in lstOrganizationAddress)
        {
            hdnTrustorg.Value = hdnTrustorg.Value + item.OrgID.ToString() + "~" + item.AddressID + "~" + item.StateID + "#";
        }
    }
    protected void btnSaveSeqNumber_Click(object sender, EventArgs e)
    {
        try
        {
            MPESeqNumber.Hide();
            long returnCode = -1;
            objProductCategories.CreatedBy = LID;
            objProductCategories.OrgID = OrgID;
            objProductCategories.CategoryID = Int32.Parse(hdnId.Value);
            CategorieAttributesMapping objInventoryAttributesMaster;
            List<CategorieAttributesMapping> lstInventoryAttributesMaster = new List<CategorieAttributesMapping>();


            int Seqno = 0;
            if (!string.IsNullOrEmpty(hdnSeqValue.Value))
            {
                foreach (var item in hdnSeqValue.Value.Split('$'))
                {
                    if (!string.IsNullOrEmpty(item))
                    {
                        Seqno = Seqno + 1;
                        objInventoryAttributesMaster = new CategorieAttributesMapping();
                        objInventoryAttributesMaster.AttributeID = Convert.ToInt32(item);
                        objInventoryAttributesMaster.CategoryID = Seqno;
                        lstInventoryAttributesMaster.Add(objInventoryAttributesMaster);

                    }
                }
            }
            List<TaxCategoriesMapping> lstTaxCategoriesMapping = new List<TaxCategoriesMapping>();
            base.ContextInfo.AdditionalInfo = "UpdateSeqNumber";
            InventoryMaster_BL inventoryObjBl = new InventoryMaster_BL(base.ContextInfo);
            returnCode = inventoryObjBl.SaveProductCategories(objProductCategories, lstTaxCategoriesMapping, lstInventoryAttributesMaster);
            LoadCategory(string.Empty);
            clearFields();
            hdnCategoryToBeDel.Value = "";
            hdnCategorieAttributesMapping.Value = "";
            hdnAttributesDetails.Value = "";
            hdnItemDetails.Value = "";
            hdnId.Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Product Categories - ProductCategories.aspx", ex);
            
        }

    }
}
