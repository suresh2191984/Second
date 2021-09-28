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
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;

public partial class InventoryReports_ProductMaintenanceReport : Attune_BasePage 
{
    public InventoryReports_ProductMaintenanceReport()
        : base("InventoryReports_ProductMaintenanceReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<Products> lstInventoryProducts = new List<Products>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            BindCategory();
        }
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
        //ddlCategory.Items.Insert(0, "--Select category--");
        ddlCategory.Items[0].Value = "0";
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
    
        int CategoryId = 0;
        string ProductName = string.Empty;
        DateTime FromDate;
        DateTime ToDate;
        int SearchType = 0;
        CategoryId = Convert.ToInt32(ddlCategory.SelectedValue);
        ProductName = txtSearch.Text;
        if (txtFrom.Text != "")
        {
            FromDate = Convert.ToDateTime(txtFrom.Text);
        }
        else
        {
            FromDate = (DateTime.Today).AddYears(-1);
        }
        if (txtTo.Text != "")
        {
            ToDate = Convert.ToDateTime(txtTo.Text);
        }
        else
        {
            ToDate = ((DateTime.Today).AddDays(1)).AddMinutes(-1);
        }
        
        SearchType =Convert.ToInt32(rdotypes.SelectedValue);
        new InventoryReports_BL(base.ContextInfo).SearchProductsMaintenanceDetails(OrgID, ILocationID, CategoryId, ProductName, InventoryLocationID, FromDate, ToDate, SearchType, out lstInventoryProducts);
        if (lstInventoryProducts.Count > 0)
        {
            gvProduct.DataSource = lstInventoryProducts;
            gvProduct.DataBind();
            tdPrint.Style.Add("display", "block");
        }
        else
        {
            gvProduct.DataSource = null;
            gvProduct.DataBind();
            tdPrint.Style.Add("display", "none");
        }

        // ProductSearch1.LoaderProductList(lstInventoryItemsBasket);
        gvProduct.Visible = true;
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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
    protected void gvProduct_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
    }
    protected void gvProduct_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header)
        {
            if (rdotypes.SelectedValue == "0")
            {                
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
                e.Row.Cells[8].Visible = false;
                e.Row.Cells[9].Visible = false;
                e.Row.Cells[10].Visible = false;
            }
            if (rdotypes.SelectedValue == "1")
            {

               
                e.Row.Cells[5].Visible = false;
                
            }

        }
        
    }
    protected void gvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvProduct.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report", ex);
        }
      
    }

}
