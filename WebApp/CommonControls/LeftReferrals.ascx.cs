using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_LeftReferrals : BaseControl
{
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    List<Alacarte> dtItems = new List<Alacarte>();
    public string AppName = string.Empty;
    public int roleID = 0;
    public int orgID = 0;
    public int parentIDReferral;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //AppName = Request.ApplicationPath;
            leftDiv.Attributes.Add("Class", CSSStyle);
            //midReferral.Attributes.Add("Class", "topReferral");
            //RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);

            if (IsPostBack == false)
            {
                #region The call to SP to get the menu items have been added to LeftMenu.ascx.xs. Hence the below block is commented
                /*
                parentIDReferral = Convert.ToInt32(TaskHelper.SearchType.Referral);
                long retCodeIP = -1;
                RoleMenu_BL rBLIP = new RoleMenu_BL(base.ContextInfo);
                List<Alacarte> lstMenuItemsReferral = new List<Alacarte>();
                retCodeIP = rBL.GetMenuItems(RoleID, OrgID, parentIDReferral, out lstMenuItemsReferral);
                if (retCodeIP == 0)
                    dtItems = lstMenuItemsReferral;
                foreach (Alacarte item in dtItems)
                {
                    item.MenuURL = Request.ApplicationPath + item.MenuURL;
                }
                if (dtItems.Count > 0)
                {
                    rptReferral.DataSource = dtItems;
                    rptReferral.DataBind();
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
            rptReferral.DataSource = menuItems;
            rptReferral.DataBind();
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
