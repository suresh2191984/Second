using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Reception_PrintPatientRegistration : BasePage
{
    public Reception_PrintPatientRegistration()
        : base("Reception\\PrintPatientRegistration.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }




    protected void Page_Load(object sender, EventArgs e)
    {
        //label printing for patient admission detail 
        string strConfigKey = "LabelPrintingAD";
        string configValue = GetConfigValue(strConfigKey, OrgID);

        if(Request.QueryString["OP"] == "Y")
        {
            ucPatReg.Visible = true;
            ucPrintIP.Visible = false;
        }
        else if (Request.QueryString["IP"] == "Y")
        {
            if (configValue == "Y")
            {
                ucPatReg.Visible = false;
                ESLabelPrint.Visible = true;
                ucPrintIP.Visible = false;
            }
            else
            {
                ucPatReg.Visible = false;
                ESLabelPrint.Visible = false;
                ucPrintIP.Visible = true;
            }
            
        }
        else if (Request.QueryString["vType"] == "IP")
        {
            if (configValue == "Y")
            {
                ucPatReg.Visible = false;
                ESLabelPrint.Visible = true;
                ucPrintIP.Visible = false;
            }
            else
            {
                ucPatReg.Visible = false;
                ESLabelPrint.Visible = false;
                ucPrintIP.Visible = true;
            }
        }
     
        this.Page.RegisterStartupScript("strPrint", "<script type='text/javascript'> popupprint(); </script>");
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
