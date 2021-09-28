using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Globalization;
using System.Configuration;


public partial class CommonControls_Attune_Footer : BaseControl
{
    public CommonControls_Attune_Footer()
        : base("CommonControls_Attune_Footer_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //ContextDetails ContextDetails = new ContextDetails();
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["BuildNo"]))
        {
            string BuildNo = ConfigurationManager.AppSettings["BuildNo"];
            string Cdisplayname = Resources.CommonControls_ClientDisplay.CommonControls_Attune_Footer_ascx_01;
            LtBuildNo.Text = Cdisplayname + BuildNo;
        }
        //LtPageId.Text = RoleDescription.ToString() + "_" + PageID.ToString();
        //  string TaskNotification = GetConfigValue("Tasknotification", OrgID);
        Utilities objUtilities = new Utilities();
        string ShowKeyValue = string.Empty;
        string hideKeyValue = string.Empty;
        objUtilities.GetApplicationValue("TaskNotificationShow", out ShowKeyValue);
        objUtilities.GetApplicationValue("TaskNotificationHide", out hideKeyValue);
        if (ShowKeyValue != "")
        {
            hdnshowintervel.Value = ShowKeyValue;
        }
        else
        {
            hdnshowintervel.Value = "0";
        }
        if (hideKeyValue != "")
        {
            hdnhideintervel.Value = hideKeyValue;
        }
        else
        {
            hdnhideintervel.Value = "0";
        }
       // if (TaskNotification == "Y")
       // {
       //     hdnTaskNotification.Value = "Y";
       // }
       // else
       // {
       //     hdnTaskNotification.Value = "N";
       // }
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

    //protected void lnkLogOut_Click(object sender, EventArgs e)
    //{
    //    LogOut();
    //}
}
