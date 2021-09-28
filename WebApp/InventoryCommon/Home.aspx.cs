using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using System.Collections;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;

public partial class InventoryCommon_Home : Attune_BasePage
{
    public InventoryCommon_Home()
        : base("InventoryCommon_Home_aspx")
    { }
   //{
   //    inventoryBL = new Inventory_BL(base.ContextInfo);
   //}
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
   
    //Inventory_BL inventoryBL;
    List<Users> lstUsers = new List<Users>();
    List<Locations> lstLocationName = new List<Locations>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //CheckBox chkBoxService = TaskControl1.ChkBoxServiceNo;
           
           BindInventoryLocation();
           new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("IsPharmacisitCashier", OrgID, ILocationID, out lstInventoryConfig);
           if (lstInventoryConfig!=null && lstInventoryConfig.Count > 0)
           {
               TaskControl1.ChkBoxServiceNo.Attributes.Add("class", "show");
           }
           else
           {
               TaskControl1.ChkBoxServiceNo.Attributes.Add("class", "hide");
           }
        }
    }

    private void BindInventoryLocation()
    {
        try
        {
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - StockIssued.aspx", ex);
            
            Attuneheader.LoadErrorMsg( "There was a problem. Please contact system administrator");
        }
    }

    
    
}