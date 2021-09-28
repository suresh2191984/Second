using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;

public partial class Investigation_PopupReport : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.QueryString["InvID"] != null) &&
           (Request.QueryString["PVID"] != null) &&
           (Request.QueryString["Path"] != null) &&
           (Request.QueryString["TemplateID"] != null))
        {
            string reportPath = Request.QueryString["Path"].ToString();
            long visitID = Convert.ToInt64(Request.QueryString["PVID"]);
            string path = Request.QueryString["Path"];
            string TemplateID = Request.QueryString["TemplateID"];
            long invID = Convert.ToInt64(Request.QueryString["InvID"]);
            ShowReport(path, visitID, TemplateID, invID);
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void ShowReport(string reportPath, long visitID, string templateID, long InvID)
    {
        try
        {
            ReportViewer.Visible = true;
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            ReportViewer.Attributes.Add("style", "width:100%; height:400px");
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            ReportViewer.ServerReport.ReportPath = reportPath;
            ReportViewer.ShowParameterPrompts = false;
            ReportViewer.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            ReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }

    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }

}

