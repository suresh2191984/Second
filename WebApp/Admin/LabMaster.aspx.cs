using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;

public partial class Admin_LabMaster : BasePage
{
    public Admin_LabMaster()
        : base("Admin_LabMaster_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {


        if(Request.QueryString["IsPopUp"] =="Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
        }
        //Page.Header.DataBind();    
        try
        {
            if (!IsPostBack)
            {
                TabContainer1_ActiveTabChanged(TabContainer1, null);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lab master page load", ex);
        }
    }

    protected void TabContainer1_ActiveTabChanged(object sender, EventArgs e)
    {
        try
        {
            if (TabContainer1.ActiveTabIndex == 0)
            {
                TM.LoadTestMasterDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while changing tab", ex);
        }
    }
}
