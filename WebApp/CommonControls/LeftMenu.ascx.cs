using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_LeftMenu : BaseControl
{
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
        parentIDOP = Convert.ToInt32(TaskHelper.SearchType.OP);
        
        leftDiv.Attributes.Add("Class", CSSStyle);
        // mid.Attributes.Add("Class",styleMidClass);
        long retCode = -1;
        RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);

        /* Enhanced by VIjay TV for performance improvement on 30 Oct 2011 Begins...
        Call the pGetMenuItems SP with ParentID as -1. The SP has logic to pull out without ParentID filter if the value is -1. Else,
        it will pick menu items specific to the passed parent ID */
        // retCode = rBL.GetMenuItems(RoleID, OrgID, parentIDOP, out lstMenuItems);
        retCode = rBL.GetMenuItems(RoleID, OrgID, -1, out dtItems); // Parent ID passed as -1 to get all the menu items for the passed OrgID
        // Enhanced by VIjay TV for performance improvement on 30 Oct 2011 ends...
        
        foreach (Alacarte item in dtItems)
        {
            item.MenuURL = item.MenuURL;
        }
        // Comment out the current data binding. Please refer the next block of code
        //rptMenu.DataSource = dtItems;
        //rptMenu.DataBind();

        // Enhanced by VIjay TV for performance improvement on 30 Oct 2011 Begins...
        // Get only the menu items related to 'Common Tasks' and bind it to the menu control
        var OPMenuItems = from child in dtItems
                          where child.ParentID == (int)TaskHelper.SearchType.OP
                         select child;
        rptMenu.DataSource = OPMenuItems;
        rptMenu.DataBind();
        // Retrieve the menu items related to each of the Left menu category and call the LoadMenuItems of the respective User Control, which
        // in turn would bind the data to the menu control
        CommonTaskIP.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.IP select child).ToList());
        LeftMenuInventory.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.INVENTORY select child).ToList());
        LeftMenuMDM.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.MDM select child).ToList());
        LeftManageSchedules.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.ManageSchedules select child).ToList());
        LeftReferrals1.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.Referral select child).ToList());
        LeftLabSummaryReport.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.LabSummaryReport select child).ToList());
        LeftMenuHelp1.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.Help select child).ToList());
        LeftMenuMRD1.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.MRD select child).ToList());
        Daycare.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.DayCare select child).ToList());
        Corporate.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.Corporate select child).ToList());
        InvAdmin.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.InventoryAdmin select child).ToList());
        LeftMenuInventorySalesOrder.LoadMenuItems((from child in dtItems where child.ParentID == (int)TaskHelper.SearchType.SalesOrder select child).ToList());

        // Enhanced by VIjay TV for performance improvement on 30 Oct 2011 Ends...
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
