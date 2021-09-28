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


public partial class CommonControls_Footer : BaseControl
{
	public CommonControls_Footer()
        : base("CommonControls_Footer_ascx")
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
        LtPageId.Text = RoleDescription.ToString() + "_" + PageID.ToString();
        if (Session["MacAddress"] != null)
        {
            string macAddress = (string)Session["MacAddress"];
            if (!String.IsNullOrEmpty(macAddress))
            {
                tdMacAddress.Visible = true;
                LtMacAddress.Text = macAddress;
            }
        }
        //if (!IsPostBack)
        //{
        //    string NeedSystemFeedback = string.Empty;
        //    NeedSystemFeedback = GetConfigValue("NeedSystemFeedback", OrgID);
        //    if (NeedSystemFeedback == "Y")
        //    {
        //        divFBFloat.Style.Add("display", "block");
        //    }
        //}
}
    //protected void lnkLogOut_Click(object sender, EventArgs e)
    //{
    //    LogOut();
    //}
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
