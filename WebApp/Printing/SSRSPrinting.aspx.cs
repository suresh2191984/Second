using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;

public partial class Printing_SSRSPrinting : BasePage
{
    long pVisitID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out pVisitID);
        //ShowReport("", pVisitID, "1", 0);
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
    public void ShowReport(string reportPath, long visitID, string templateID, long InvID)
    {
        try
        {
            rReportViewer.Visible = true;
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            if (rdLabel1.Checked == true)
            {
                reportPath = GetConfigValues("LabelPrinting1", OrgID);
            }
            else if(rdLabel2.Checked == true)
            {
                reportPath = GetConfigValues("LabelPrinting2", OrgID);
            }
            else if (rdLabel3.Checked == true)
            {
                reportPath = GetConfigValues("LabelPrinting3", OrgID);
            }
            else if (rdDispatchSticker.Checked == true)
            {
                reportPath = GetConfigValues("DispatchPrintLabel4", OrgID);  
            }
            else if (rdRadiology.Checked == true)
            {
                reportPath = GetConfigValues("RadiologyorSonoPrintLabel5", OrgID);
            }
            else if (rdHealthCheckUp.Checked == true)
            {
                reportPath = GetConfigValues("HealthCheckUpPrintLabel6", OrgID);
            }
            else if (rdHomeDispatch.Checked == true)
            {
                reportPath = GetConfigValues("HomeDispatchPrintLabel7", OrgID);
            }
            else if (rdDoctorDispatch.Checked == true)
            {
                reportPath = GetConfigValues("DoctorDispatchPrintLabel8", OrgID);
            }
            else if (rdECGorStress.Checked == true)
            {
                reportPath = GetConfigValues("EcgorStressPrintLabel9", OrgID);
            }


            
            rReportViewer.Attributes.Add("style", "width:100%; height:400px");
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            rReportViewer.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[3];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            //reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            //reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            rReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
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
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
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
    protected void btnGo_Click(object sender, EventArgs e)
    {
        ShowReport("", pVisitID, "1", 0);
    }
}
