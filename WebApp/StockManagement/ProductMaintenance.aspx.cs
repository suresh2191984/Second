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
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.StockManagement.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Common;

public partial class StockManagement_ProductMaintenance : Attune_BasePage
{
    public StockManagement_ProductMaintenance()
        : base("StockManagement_ProductMaintenance_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    StockManagement_BL inventoryBL ;
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new StockManagement_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            
            BindDrp();
            BindCategory();
        }
    }
    
    protected void gvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvProduct.PageIndex = e.NewPageIndex;
                Button1_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report", ex);
        }
    }
  
    public void BindDrp()
    {
        List<MetaData> lstitem = new List<MetaData>();
        lstitem = GetMetaData("Maintaintype");
        ddlMaintenanceType.DataSource = lstitem;
        ddlMaintenanceType.DataTextField = "DisplayText";
        ddlMaintenanceType.DataValueField = "Code";
        ddlMaintenanceType.DataBind();

        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlMaintenanceType.Items.Insert(0, ddlselect);
        
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

        //ddlCategory.Items.Insert(0, "--Select category--");
        //ddlCategory.Items[0].Value = "0";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        List<Products> lstInventoryProducts = new List<Products>();
        int CategoryId = 0;
        string ProductName = string.Empty;
        CategoryId =Convert.ToInt32(ddlCategory.SelectedValue);
        ProductName = txtSearch.Text;
        //inventoryBL.GetAllMaintenanceProducts(OrgID, ILocationID, CategoryId, ProductName, InventoryLocationID, out lstInventoryProducts);
         

        inventoryBL.GetAllMaintenanceProducts(OrgID, ILocationID, CategoryId, "", InventoryLocationID, "", "", -1, "Edit", out lstInventoryProducts);
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
        if (e.CommandName == "productMaintenanceDetails")
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
            
            //long returnCode = -1;
            List<Products> lstProducts = new List<Products>();
            //returnCode=inventoryBL.GetSelectedProductDetail(ProductID, 0, InventoryLocationID, OrgID, out lstProducts);
           // inventoryBL.SearchPToAssignlMaintenance(OrgID, ILocationID, CategoryId, "", InventoryLocationID, PSerialNo, "", StockReceivedDetailsId, "Edit", out lstProducts);
            inventoryBL.GetAllMaintenanceProducts(OrgID, ILocationID, CategoryId, "", InventoryLocationID, PSerialNo, "", StockReceivedDetailsId, "Edit", out lstProducts);
            if (lstProducts.Count > 0)
            {
                gvPopUpProduct.DataSource = lstProducts;
                gvPopUpProduct.DataBind();
                hdnPType.Value =Convert.ToString(lstProducts[0].TypeID);
                hdnPCategory.Value = Convert.ToString(lstProducts[0].CategoryID);
                hdnActualDOM.Value = Convert.ToString(lstProducts[0].NextMaintenanceDate);
                hdnReminderTemplateID.Value = Convert.ToString(lstProducts[0].ReminderTemplateID);
            }
            else
            {
                gvPopUpProduct.DataSource = null;
                gvPopUpProduct.DataBind();
            }
             
            MPEShowPackageContent.Show();
        }
    }
    protected void btnSaveItems_Click(object sender, EventArgs e)
    {
        long returnCode = -1; 
        ProductMaintenanceRecord objProductMaintenanceRecord = new ProductMaintenanceRecord();
        objProductMaintenanceRecord.ProductID = Convert.ToInt64(hdnProductID.Value);
        objProductMaintenanceRecord.CategoryID = Convert.ToInt32(hdnPCategory.Value);
        objProductMaintenanceRecord.TypeID = Convert.ToInt32(hdnPType.Value);
        objProductMaintenanceRecord.DateOfMaintenance =DateTimeNow;
        objProductMaintenanceRecord.ProbDetails = txtProblemIdentify.Text;
        objProductMaintenanceRecord.CorrectiveAction = txtCorrectiveActions.Text;
        objProductMaintenanceRecord.MaintenanceCost = Convert.ToDecimal(txtServiceCost.Text);
        objProductMaintenanceRecord.MaintenanceType = ddlMaintenanceType.SelectedValue;
        objProductMaintenanceRecord.Status = "Completed";
        objProductMaintenanceRecord.ActualDateOfMaintenance = Convert.ToDateTime(hdnActualDOM.Value);
        objProductMaintenanceRecord.ProductMaintenanceID =Convert.ToInt64(hdnReminderTemplateID.Value);
     
        returnCode = inventoryBL.SaveProductMaintenanceRecord(objProductMaintenanceRecord);
        ddlMaintenanceType.SelectedValue = "0";
        txtServiceCost.Text = "";
        txtCorrectiveActions.Text = "";
        txtProblemIdentify.Text = "";
        Button1_Click(sender, e);

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
