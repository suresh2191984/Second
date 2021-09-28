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


public partial class InventoryCommon_Controls_ProductSearch : Attune_BaseControl
{
    public InventoryCommon_Controls_ProductSearch()

        : base("InventoryCommon_Controls_ProductSearch_ascx")
    { }

    InventoryCommon_BL inventoryBL;
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    public class ProductSearchList : EventArgs
    {
        public string ProductName { get; set; }
        public int CategoryId { get; set; }
    }

    public delegate void ProductSearchHandler(object sender, ProductSearchList e);
    
    public event ProductSearchHandler OnProductSearch;

    protected virtual void ProductSearch(ProductSearchList e)
    {
        if (OnProductSearch != null)
        {
            OnProductSearch(this, e);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
           // txtCategory.Width = (int)(ddlCategory.Width.Value) - 20;
            inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
            LoadCategory(ddlCategory, lstProductCategories);
            //ddlCategory.Attributes.Add("onchange", "selectText('" + txtCategory.ClientID + "','" + ddlCategory.ClientID + "');");
            //txtCategory.Attributes.Add("onblur", "doSet('" + txtCategory.ClientID + "','" + ddlCategory.ClientID + "');");
           // ddlCategory.Attributes.Add("onclick", "getElementById('"+ txtCategory.ClientID +"').style.display='block';");
            btnSearch.Attributes.Add("onclick", "javascript:if(!checkProductValidation('" + txtProduct.ClientID + "')) return false;");
            listSearch.Attributes.Add("onclick", "javascript:SetProductItem('" + listSearch .ClientID+ "','"+txtProduct.ClientID +"');");
        }
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
        //ddl.Items.Insert(0, GetMetaData("Select", "0"));
        ddl.Items[0].Value = "0";
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (listSearch.SelectedItem != null)
        {
            txtProduct.Text = listSearch.SelectedItem.Text;
            ProductSearchList objProductSearch = new ProductSearchList();
            objProductSearch.ProductName = txtProduct.Text;
            objProductSearch.CategoryId = int.Parse(ddlCategory.SelectedValue);
            ProductSearch(objProductSearch);
        }
        else
        {
            ProductSearchList objProductSearch = new ProductSearchList();
            objProductSearch.ProductName = txtProduct.Text;
            objProductSearch.CategoryId = int.Parse(ddlCategory.SelectedValue);
            ProductSearch(objProductSearch);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "bindDDLCategory", "javascript:LoadAutoCompleteSource('" + txtCategory.ClientID + "','" + ddlCategory.ClientID + "');", true);
    }

    public void GetSearchParameters(out string searchStr, out int categoryID)
    {
        searchStr = txtProduct.Text;
        categoryID = int.Parse(ddlCategory.SelectedValue);
    }


    public void LoaderProductList(List<InventoryItemsBasket> lstInventoryItemsBasket)
    {
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
            string sPath = Resources.InventoryCommon_AppMsg.InventoryCommon_Controls_ProductSearch_ascx_01;
            string sError=Resources.InventoryCommon_AppMsg.InventoryCommon_Error;
            if(sPath==null)
            {
                sPath="The given product is not available";
            }
            if(sError==null)
            {
                sError="Alert";
            }

           // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pdt not availabe", "javascript:alert('The given product is not available');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pdt not availabe", "javascript:ValidationWindow('"+sPath +"','" + sError + "');", true);

            listSearch.Visible = false;
        }
    }
    
    
}
