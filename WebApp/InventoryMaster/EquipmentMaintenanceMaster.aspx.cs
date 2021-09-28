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
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Common;

public partial class InventoryMaster_EquipmentMaintenanceMaster : Attune_BasePage
{
    public InventoryMaster_EquipmentMaintenanceMaster()
        : base("InventoryMaster\\EquipmentMaintenanceMaster.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryMaster_BL inventoryBL;
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    public string SearchType = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryMaster_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            BindCategory();
            BindFrequency();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Products> lstInventoryProducts = new List<Products>();
        int CategoryId = 0;
        string ProductName = string.Empty;
        string BatchNo = string.Empty;
        string PModel = string.Empty;
        long ProductID=-1;
       
        CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
        ProductName = txtSearch.Text.Trim();
        BatchNo = txtBatchNo.Text.Trim();
        PModel = txtModel.Text.Trim();
        if (rdotypes.SelectedValue == "0")
        {
            SearchType = "New";
        }
        else
        {
            SearchType = "Edit";
        }
        hdnSearchType.Value = SearchType;
        inventoryBL.SearchPToAssignlMaintenance(OrgID, ILocationID, CategoryId, ProductName, InventoryLocationID, BatchNo, PModel, ProductID,SearchType, out lstInventoryProducts);
        
        if (lstInventoryProducts.Count > 0)
        {
            gvProduct.DataSource = lstInventoryProducts;
            gvProduct.DataBind();
        }
        else
        {
            gvProduct.DataSource = null;
            gvProduct.DataBind();
        }

        // ProductSearch1.LoaderProductList(lstInventoryItemsBasket);
        gvProduct.Visible = true;
    }   
    protected void gvProduct_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "productMaintenanceProcess")
        {
            int _rowIndex = Convert.ToInt32(e.CommandArgument);
            //GridViewRow grdRow = 
            Label lblSourceID = (Label)(gvProduct.Rows[_rowIndex]).FindControl("lblSourceID");
            Label lblPSerialNo = (Label)(gvProduct.Rows[_rowIndex]).FindControl("lblPSerialNo");
            Label lblCategoryId = (Label)(gvProduct.Rows[_rowIndex]).FindControl("lblCategoryId");
            Label lblProductID = (Label)(gvProduct.Rows[_rowIndex]).FindControl("lbProductID");
            long StockReceivedDetailsId = Convert.ToInt64(lblSourceID.Text);
            string PSerialNo = lblPSerialNo.Text;
            int CategoryId = Int32.Parse(lblCategoryId.Text);
            hdnProductID.Value = lblSourceID.Text;


           // long returnCode = -1;
            List<Products> lstProducts = new List<Products>();
            List<Products> lstInventoryProducts = new List<Products>();
            ClearData();
            if (hdnSearchType.Value == "Edit")
            {
                inventoryBL.SearchPToAssignlMaintenance(OrgID, ILocationID, CategoryId, "", InventoryLocationID, PSerialNo, "", StockReceivedDetailsId, "Edit", out lstInventoryProducts);
            }
            else
            {
                inventoryBL.SearchPToAssignlMaintenance(OrgID, ILocationID, CategoryId, "", InventoryLocationID, PSerialNo, "", StockReceivedDetailsId, "", out lstInventoryProducts);
            }
          

            if (lstInventoryProducts.Count > 0)
            {
                gvPopUpProduct.DataSource = lstInventoryProducts;
                gvPopUpProduct.DataBind();
                hdnPSerialNo.Value = Convert.ToString(PSerialNo);
                hdnStockReceivedDetailsId.Value = Convert.ToString(StockReceivedDetailsId);
                hdnProductID.Value = lblProductID.Text;
                MPEShowPackageContent.Show();
                if (hdnSearchType.Value == "Edit")
                {
                    txtFrom.Text = lstInventoryProducts[0].StartDate.ToExternalDate();
                    txtTo.Text = lstInventoryProducts[0].EndDate.ToExternalDate();
                    txtAmcProvider.Text = lstInventoryProducts[0].AmcProvider;
                    txtMaintenanceNotes.Text = lstInventoryProducts[0].Notes;
                    ddlMaintenanceFrequency.SelectedValue = lstInventoryProducts[0].Frequency;
                    hdnReminderTemplateID.Value =Convert.ToString(lstInventoryProducts[0].ReminderTemplateID);
                }
            }
            else
            {
                gvPopUpProduct.DataSource = null;
                gvPopUpProduct.DataBind();
            }
           

            
        }
    }
    protected void ClearData()
    {
        ddlMaintenanceFrequency.SelectedValue = "0";
        txtFrom.Text = "";
        txtTo.Text = "";
        txtMaintenanceNotes.Text = "";
        txtAmcProvider.Text = "";
    }
    protected void gvProduct_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string strEditMaintenance = Resources.InventoryMaster_ClientDisplay.InventoryMster_EquipmentMaintenanceMaster_aspx_03 == null ? "Edit Maintenance" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_EquipmentMaintenanceMaster_aspx_03;
        if (hdnSearchType.Value == "Edit")
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnEdit = (LinkButton)e.Row.FindControl("btnEdit");
                btnEdit.Text = strEditMaintenance;
            }
        }
    }
    protected void gvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    { 
    }
    private void BindCategory()
    { 
        new InventoryCommon_BL(base.ContextInfo).GetProductCategories(OrgID, ILocationID, out lstProductCategories);
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

    }
    protected void BindFrequency()
    {
        List<MetaData> lstMetadata = GetMetaData("Months");
        if (lstMetadata.Count > 0)
        {
            ddlMaintenanceFrequency.DataSource = lstMetadata;
            ddlMaintenanceFrequency.DataTextField = "DisplayText";
            ddlMaintenanceFrequency.DataValueField = "Code";
            ddlMaintenanceFrequency.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlMaintenanceFrequency.Items.Insert(0, ddlselect);
        }
    }
    protected void btnSaveItems_Click(object sender, EventArgs e)
    {
        //long returnCode = -1;
        SetRemainder();
        btnSearch_Click(sender, e);
    }
    private void SetRemainder()
    {
        try
        {
            CultureInfo provider = CultureInfo.InvariantCulture;
            string format = "dd/MM/yyyy";
            if (hdnSearchType.Value == "New")
            {
                long returnCode = -1;
                EquipmentMaintenanceMaster lstreminderTemplate = new EquipmentMaintenanceMaster();
                lstreminderTemplate.StartDate = txtFrom.Text.ToInternalDate();
                lstreminderTemplate.Notes = hdnPSerialNo.Value + "-" + txtMaintenanceNotes.Text;
                lstreminderTemplate.Frequency = ddlMaintenanceFrequency.SelectedValue;
                lstreminderTemplate.AmcProvider = txtAmcProvider.Text;
                lstreminderTemplate.Orgid = OrgID;
                lstreminderTemplate.ProductID =Convert.ToInt64(hdnProductID.Value);
                lstreminderTemplate.StockReceivedDetailsId = Convert.ToInt64(hdnStockReceivedDetailsId.Value);
                lstreminderTemplate.EndDate = txtTo.Text.ToInternalDate();
                lstreminderTemplate.SerialNo = hdnPSerialNo.Value;
                returnCode = inventoryBL.InsertEquipmentMaintenanceMaster(lstreminderTemplate);
               // returnCode = reminderBL.SaveReminderTemplate(lstreminderTemplate);
            }
            else if (hdnSearchType.Value == "Edit")
            {
                long returnCode = -1;
                EquipmentMaintenanceMaster lstreminderTemplate = new EquipmentMaintenanceMaster();
                lstreminderTemplate.StartDate = txtFrom.Text.ToInternalDate();
                lstreminderTemplate.Notes = hdnPSerialNo.Value + "-" + txtMaintenanceNotes.Text;
                lstreminderTemplate.Frequency = ddlMaintenanceFrequency.SelectedValue;
                lstreminderTemplate.AmcProvider = txtAmcProvider.Text;
                lstreminderTemplate.Orgid = OrgID;
                lstreminderTemplate.ProductID = Convert.ToInt64(hdnProductID.Value);
                lstreminderTemplate.StockReceivedDetailsId = Convert.ToInt64(hdnStockReceivedDetailsId.Value);
                lstreminderTemplate.EndDate = txtTo.Text.ToInternalDate();
                lstreminderTemplate.ReminderTemplateID = Convert.ToInt64(hdnReminderTemplateID.Value);

                returnCode = inventoryBL.UpdateEquipmentMaintenanceMaster(lstreminderTemplate);
                //getReminderTemplateDetail(); 
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save/Update in remainder template page", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
