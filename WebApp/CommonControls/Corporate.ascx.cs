using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_Corporate : BaseControl
{
    public CommonControls_Corporate()
        : base("CommonControls_Corporate_ascx")
    {
    }
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    List<Alacarte> dtItems = new List<Alacarte>();
    public string AppName = string.Empty;
    public int roleID = 0;
    public int orgID = 0;
    public int parentIDOP;
    public int parentIDIP;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //AppName = Request.ApplicationPath;
            leftDiv.Attributes.Add("Class", CSSStyle);
            //midIP.Attributes.Add("Class", "topIP");
            //RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);

            if (IsPostBack == false)
            {
                #region The call to SP to get the menu items have been added to LeftMenu.ascx.xs. Hence the below block is commented
                /*
                parentIDIP = Convert.ToInt32(TaskHelper.SearchType.DayCare);
                long retCodeIP = -1;
                RoleMenu_BL rBLIP = new RoleMenu_BL(base.ContextInfo);
                List<Alacarte> lstMenuItemsIP = new List<Alacarte>();
                retCodeIP = rBL.GetMenuItems(RoleID, OrgID, parentIDIP, out lstMenuItemsIP);
                if (retCodeIP == 0)
                    dtItems = lstMenuItemsIP;
                foreach (Alacarte item in dtItems)
                {
                    item.MenuURL = Request.ApplicationPath + item.MenuURL;
                }
                if (dtItems.Count > 0)
                {
                    rptIP.DataSource = dtItems;
                    rptIP.DataBind();
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
        if (menuItems != null && menuItems.Count > 0)
        {
            rptIP.DataSource = menuItems;
            rptIP.DataBind();
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
}
