using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Microsoft.Reporting.WebForms;

public partial class Waters_QuotationFormat : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        long QuotationId = -1;
        int Orgid=0;
       // string Quotationid = Session["Qid"].ToString();

        Int64.TryParse(Request.QueryString["Qid"], out QuotationId);
        Int32.TryParse(Request.QueryString["OrgID"], out Orgid);
       long loginID =  Convert.ToInt64(LID);
       int AddressID = Convert.ToInt32(ILocationID);
       ShowReport(QuotationId, Orgid, loginID, AddressID);
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

    public void ShowReport(long visitID,int pOrgid,long loginID,int AddressID)
    {
        try
        {



            rReportViewer.Visible = false;
            int PatientId = -1;
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = "/Waters/Equinox Q format report";
            rReportViewer.ShowParameterPrompts = false;
            //if (hdnPrintbtnInReportViewer.Value == "Y")
            //{
            //    rReportViewer.ShowPrintButton = false;
            //}
            //else
            {
                rReportViewer.ShowPrintButton = true;
            }



            connectionString = Utilities.GetConnectionString();

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[8];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(pOrgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("orgAddressID",Convert.ToString(AddressID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("pLoginID", Convert.ToString(loginID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            //reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            //reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            //reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = rReportViewer.ServerReport.GetParameters();

            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();
            rReportViewer.ServerReport.SetParameters(lstParameter);
            //rReportViewer.ServerReport.SetParameters(reportParameterList);

            rReportViewer.ServerReport.Refresh();
            rReportViewer.Visible = true;

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
            //else
            //    CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
}
