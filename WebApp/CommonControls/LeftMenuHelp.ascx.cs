using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_LeftMenuHelp : BaseControl
{
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    List<Alacarte> dtItems = new List<Alacarte>();
    public string AppName = string.Empty;
    public int roleID = 0;
    public int orgID = 0;
    public int parentIDOP;
    public int parentIDIP;
	public CommonControls_LeftMenuHelp()
        : base("CommonControls_LeftMenuHelp_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        leftDiv.Attributes.Add("Class", CSSStyle);
        #region The call to SP to get the menu items have been added to LeftMenu.ascx.xs. Hence the below block is commented
        /*
        parentIDOP = Convert.ToInt32(TaskHelper.SearchType.Help);
        // AppName = Request.ApplicationPath;
        // mid.Attributes.Add("Class",styleMidClass);
        long retCode = -1;
        RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);
        List<Alacarte> lstMenuItems = new List<Alacarte>();
        retCode = rBL.GetMenuItems(RoleID, OrgID, parentIDOP, out lstMenuItems);
        if (lstMenuItems.Count > 0)
        {
            dtItems = lstMenuItems;
        }
        else
        {
            this.Visible = false;
        }

        foreach (Alacarte item in dtItems)
        {
            item.MenuURL = Request.ApplicationPath + item.MenuURL;
        }
        rptHelp.DataSource = dtItems;
        rptHelp.DataBind();
         */
        #endregion
    }

    /// <summary>
    /// This will get Called from LeftMenu.ascx.cs as part of loading the menu items.
    /// </summary>
    /// <param name="menuItems"></param>
    public void LoadMenuItems(List<Alacarte> menuItems)
    {
        if (menuItems != null && menuItems.Count > 0)
        {
            rptHelp.DataSource = menuItems;
            rptHelp.DataBind();
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
