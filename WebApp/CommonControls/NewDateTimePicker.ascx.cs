using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.Script.Serialization;
public partial class CommonControls_NewDateTimePicker : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMeatData();
        DateTime dt = new DateTime();
        dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        txtSampleDateCollect.Text = dt.ToShortDateString();
        string Time = dt.ToString("hh:mm:tt");
        string[] SplitTime = Time.Split(':');
        string sCollectedTimeZero = GetConfigValue("CollectedTimeZero", OrgID);
        if (sCollectedTimeZero == "Y")
        {
            txtSampleTime1.Text = "00";
            txtSampleTime2.Text = "00";
            ddlSampleTimeType.SelectedValue = "AM".ToString();
        }
        else
        {
        txtSampleTime1.Text = SplitTime[0];
        txtSampleTime2.Text = SplitTime[1];
        ddlSampleTimeType.SelectedValue = SplitTime[2].ToString();
        }
        
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "SampleTimeType";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "SampleTimeType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlSampleTimeType.DataSource = childItems;
                    ddlSampleTimeType.DataTextField = "DisplayText";
                    ddlSampleTimeType.DataValueField = "Code";
                    ddlSampleTimeType.DataBind();
                    ddlSampleTimeType.SelectedValue = "0";
                }
            }
            //Added by vijayalakshmi.M
            List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            lstNameValuePair = (from l in lstmetadataOutput
                                select new NameValuePair { Name = l.DisplayText , Value = Convert.ToString(l.Code) }).ToList<NameValuePair>();
            hdnDateTime.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);
            //End
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
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
