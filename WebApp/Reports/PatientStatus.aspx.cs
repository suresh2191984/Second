using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Text;
using ReportBusinessLogic;
using System.Globalization;
public partial class Lab_PatientStatus : BasePage
{

    long returncode = -1;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string DateFormat = "ddmmyyyy";
    string TimeFormat = "12";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFromFormat.HRef = "javascript:NewCssCal('txtFrom'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
            txtToFormat.HRef = "javascript:NewCssCal('txtTo'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
            if (!IsPostBack)
            {
                LoadDataValues();
                //22-05-2014 06:29:59PM
                //string[] dt = (Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone))).Split(' ');
                //string[] Date = Convert.ToString(dt[0]).Split('/');
                //string Time = dt[1];
                //string DateTime1 = Date[0] + "-" + Date[1] + "-" + Date[2] + " " + "00:00:00";
                //string DateTime2 = Date[0] + "-" + Date[1] + "-" + Date[2] + " " + Time;
                //txtFrom.Text = DateTime1;
                //txtTo.Text = DateTime2;
                DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
                DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
                string a = dt.ToString(DateTimeFormat);
                txtFrom.Text = a.Substring(0, 10) + " " + "00:00";
                txtTo.Text = a.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientStatus on page_load", ex);
        }
        //IsNeedExternalVisitIdWaterMark = GetConfigValues("ExternalVisitIdWaterMark", OrgID);
        //if (IsNeedExternalVisitIdWaterMark != " ")
        //{
        //    defaultText = IsNeedExternalVisitIdWaterMark;
        //    if (IsNeedExternalVisitIdWaterMark.Replace(" ", String.Empty).ToLower() == "labnumber")
        //    {
        //        txtLabNumber.MaxLength = 9;
        //    }
        //}
        //else
        //{
        //    defaultText = " ";
        //}
        //txtwatermark();
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = "Lab Number";
			txtLabNumber.MaxLength = 9;

        }
        else
        {
            defaultText = "Visit Number";
        }
        txtwatermark();
    }
    public void txtwatermark()
    {
        if (txtLabNumber.Text.Trim() != defaultText.Trim())
        {
            txtLabNumber.Attributes.Add("style", "color:black");
        }
        if (txtLabNumber.Text == "")
        {
            txtLabNumber.Text = defaultText;
            txtLabNumber.Attributes.Add("style", "color:gray");
        }
        txtLabNumber.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtLabNumber.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

    }
    public void LoadDataValues()
    {
        LoadStatus();
        LoadUsers();
        LoadLocation();
    }
    private void LoadStatus()
    {
        string domains = "Status";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);
        }
        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "Status"
                             select child;
            if (childItems.Count() > 0)
            {
                ddlStatus.DataSource = childItems;
                ddlStatus.DataTextField = "DisplayText";
                ddlStatus.DataValueField = "Code";
                ddlStatus.DataBind();
            }
        }
        lblProcessedBy.Text = ddlStatus.SelectedItem.ToString() + " " + "By";
    }
    private void LoadUsers()
    {
        List<Users> lstUsersDetails = new List<Users>();
        ReportBusinessLogic.ReportExcel_BL reportBusinessLogic = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
        returncode = reportBusinessLogic.GetListOfLabUsers(OrgID, out lstUsersDetails);
        ddlProcessedBy.DataSource = lstUsersDetails;
        ddlProcessedBy.DataTextField = "Name";
        ddlProcessedBy.DataValueField = "LoginID";
        ddlProcessedBy.DataBind();
        ddlProcessedBy.Items.Insert(0, "---Select---");
        ddlProcessedBy.Items[0].Value = "0";
        ddlProcessedBy.SelectedValue = LID.ToString();
    }
    private void LoadLocation()
    {
        long returnCode = -1;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        if (lstLocation.Count > 0)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items[0].Value = "-1";
            }
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {

            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

}