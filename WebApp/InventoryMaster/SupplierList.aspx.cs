using System;
using Attune.Kernel.InventoryMaster;
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
using Attune.Kernel.PlatForm.Common;
using AjaxControlToolkit;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;

public partial class Inventory_SupplierList : Attune_BasePage 
{
    public Inventory_SupplierList()
        : base("Inventory\\SupplierList.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL    invenBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        invenBL = new InventoryCommon_BL(base.ContextInfo);
        long sID = 0;
        long pID = 0;
        Int64.TryParse(Request.QueryString["pID"].ToString(), out pID);
        Int64.TryParse(Request.QueryString["sID"].ToString(), out sID);
        
        if (pID!=0 && sID!=0)
        {
            GetLatestPriceBySupplier(pID);
        }
        
    }
    
    public void GetLatestPriceBySupplier(long pID)
    {
        invenBL.GetLatestPriceBySupplier(pID, out lstInventoryItemsBasket);
        var inv = from tempinv in lstInventoryItemsBasket
                  orderby tempinv.UnitPrice
                  select tempinv;

        grdResult.DataSource = inv;
       
        grdResult.EmptyDataText = "No matching Supplier found .";
        grdResult.DataBind();

    }
    
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            long sID = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
                Int64.TryParse(Request.QueryString["sID"].ToString(), out sID);
                if (inv.ID == sID)
                {
                    //e.Row.BackColor = System.Drawing.Color.Orange;
                    e.Row.CssClass = "patientSearch";
                }


               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - SupplierList.aspx", ex);
             
        }
    }

    
    
}
