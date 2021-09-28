using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_InventoryAdmin :BaseControl
{
    public CommonControls_InventoryAdmin()
        : base("CommonControls_InventoryAdmin_ascx")
    {
    }
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    List<Alacarte> dtItems = new List<Alacarte>();
    List<Alacarte> lstLocItems = new List<Alacarte>();
    public string AppName = string.Empty;
    public int roleID = 0;
    public int orgID = 0;
    public int parentIDInventory;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //AppName = Request.ApplicationPath ;
            leftDiv.Attributes.Add("Class", CSSStyle);
            //midInventory.Attributes.Add("Class", "topInventory");
            //RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);

            if (IsPostBack == false)
            {
                #region The call to SP to get the menu items have been added to LeftMenu.ascx.xs. Hence the below block is commented
                /*
                parentIDInventory = Convert.ToInt32(TaskHelper.SearchType.InventoryAdmin);
                long retCodeIP = -1;
                long retCodeInv = -1;
                RoleMenu_BL rBLIP = new RoleMenu_BL(base.ContextInfo);
                List<Alacarte> lstMenuItemsInventory = new List<Alacarte>();
                List<Alacarte> lstLocationPageMap = new List<Alacarte>();

                retCodeIP = rBL.GetMenuItems(RoleID, OrgID, parentIDInventory, out lstMenuItemsInventory);

                retCodeInv = rBL.GetLocationPageMap(InventoryLocationID, RoleID, OrgID, parentIDInventory, out lstLocationPageMap);


                if (retCodeIP == 0)
                    dtItems = lstMenuItemsInventory;
                foreach (Alacarte item in dtItems)
                {
                    item.MenuURL = Request.ApplicationPath  + item.MenuURL;
                }
                if (dtItems.Count > 0)
                {
                    rptInventory.DataSource = dtItems;
                    rptInventory.DataBind();
                }
                else
                {
                    leftDiv.Visible = false;
                }

                if (retCodeInv == 0)
                {
                    lstLocItems = lstLocationPageMap;
                }
                foreach (Alacarte itemLoc in lstLocItems)
                {
                    itemLoc.MenuURL = Request.ApplicationPath  + itemLoc.MenuURL;
                }
                if (lstLocItems.Count > 0)
                {
                    rptInventory.DataSource = lstLocItems;
                    rptInventory.DataBind();
                }
                else
                {
                    leftDiv.Visible = false;
                }
                */
                #endregion
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Left Menu In Patient", ex);
        }
    }

    /// <summary>
    /// This will get Called from LeftMenu.ascx.cs as part of loading the menu items.
    /// </summary>
    /// <param name="menuItems"></param>
    public void LoadMenuItems(List<Alacarte> menuItems)
    {
        //dtItems = menuItems;
        if (menuItems != null && menuItems.Count > 0)
        {
            //rptInventory.DataSource = menuItems;
            //rptInventory.DataBind();
            List<Alacarte> lstLocationPageMap = new List<Alacarte>();
            RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);
            parentIDInventory = Convert.ToInt32(TaskHelper.SearchType.InventoryAdmin);
            if (rBL.GetLocationPageMap(InventoryLocationID, RoleID, OrgID, parentIDInventory, out lstLocationPageMap) == 0)
            {
                if (lstLocationPageMap.Count > 0)
                {
                    foreach (Alacarte itemLoc in lstLocationPageMap)
                    {
                        itemLoc.MenuURL = Request.ApplicationPath  + itemLoc.MenuURL;
                    }
                    rptInventory.DataSource = lstLocationPageMap;
                    rptInventory.DataBind();
                }
                else
                {
                    leftDiv.Visible = false;
                }
            }
        }
        else
        {
            leftDiv.Visible = false;
        }
    }

    public string CSSStyle
    {
        set
        {
            styleClass = value;
        }
        get
        {
            return styleClass;
        }
    }
    public string CSSMidStyle
    {
        set
        {
            styleMidClass = value;
        }
        get
        {
            return styleMidClass;
        }
    }

    public List<Alacarte> DataItems
    {
        set
        {
            dtItems = value;
        }

        get
        {
            return dtItems;
        }
    }

    public List<Alacarte> DataItemsLoc
    {
        set
        {
            lstLocItems = value;
        }

        get
        {
            return lstLocItems;
        }
    }
}

 
