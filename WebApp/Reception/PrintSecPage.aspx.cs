using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;

public partial class Reception_PrintSecPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnPrintSecA4Sheet.Value = GetConfigValue("Print Secure Page", OrgID);
        ucSPage.loadPatientSecPrintPage();
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<Role> lstUserRole1 = new List<Role>();
        string path1 = string.Empty;
        Role role1 = new Role();
        role1.RoleID = RoleID;
        lstUserRole1.Add(role1);
        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
        Response.Redirect(Request.ApplicationPath + path1, true);
    }     
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    } 
}
