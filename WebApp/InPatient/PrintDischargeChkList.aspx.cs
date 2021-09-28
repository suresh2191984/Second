using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class InPatient_PrintDischargeChkList : BasePage
{
     public InPatient_PrintDischargeChkList(): base("InPatient\\PrintDischargeChkList.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }



    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            //List<Role> lstUserRole1 = new List<Role>();
            //string path1 = string.Empty;
            //Role role1 = new Role();
            //role1.RoleID = RoleID;
            //lstUserRole1.Add(role1);
            //returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            //Response.Redirect(Request.ApplicationPath  + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnPrint_Click", ex);

        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath  + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC - View Case Sheet.ascx", ex);
        }
    }
}
