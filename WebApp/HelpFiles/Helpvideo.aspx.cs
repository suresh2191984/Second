using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;



public partial class HelpFiles_Helpvideo : Attune_BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        hdnUserManual.Value = GetConfigValue("HelpFilePath", OrgID);
    }


 

    //protected void lnkHome_Click(object sender, EventArgs e)
    //{
    //    //try
    //    //{
    //    //    Response.Redirect("../Reception/Home.aspx", true);
    //    //}

    //    //catch (Exception ex)
    //    //{
    //    //    CLogger.LogError("Error while executing Control()", ex);
    //    //}
    //    try
    //    {
    //        Navigation navigation = new Navigation();
    //        Role role = new Role();
    //        role.RoleID = RoleID;
    //        List<Role> userRoles = new List<Role>();
    //        userRoles.Add(role);
    //        string relPagePath = string.Empty;
    //        long returnCode = -1;
    //        returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
    //        if (returnCode == 0)
    //        {
    //            Response.Redirect(Request.ApplicationPath  + relPagePath, true);
    //        }
    //    }
    //    catch (System.Threading.ThreadAbortException tex)
    //    {
    //        string te = tex.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
    //    }
    //}
}
