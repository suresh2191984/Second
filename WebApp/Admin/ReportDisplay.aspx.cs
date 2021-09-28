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
using System.Security.Principal;
using Microsoft.Reporting.WebForms;

public partial class Admin_ReportDisplay : System.Web.UI.Page
{
    string reportName = string.Empty;
    string reportPath = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            reportPath = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["ReportServer"]);
           // reportName = Convert.ToString(Request.QueryString["rname"]);
            ReportViewer.Attributes.Add("style", "width:100%");
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            ReportViewer.ServerReport.ReportServerUrl = new Uri("http://124.153.106.30/reports");
            ReportViewer.ServerReport.ReportPath = "/AdminReports/TestReport";
            
            ReportViewer.ServerReport.Refresh();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
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

