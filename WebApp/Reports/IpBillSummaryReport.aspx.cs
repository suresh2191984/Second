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

public partial class Reports_IpBillSummaryReport : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                long visitID = 0;
                if (Request.QueryString["VID"] != null)
                {
                    visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
                }

                long patientID = 0;
                if (Request.QueryString["PID"] != null)
                {
                    patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
                }
                decimal dAdvanceAmount = 0;
                string sPaymentType = "";
                
                List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
               List<AdvancePaidDetails> lstadvancepaidDetails= new List<AdvancePaidDetails>();

               new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, sPaymentType, out dAdvanceAmount, out lstadvancepaidDetails);
                //if (lstDueChart.Count > 0)
                //{
                //    dvError.Visible = true;
                //    rptDisplay.Visible = false;
                //}
                //else
                //{
                    //dvError.Visible = false;
                    rptDisplay.Visible = true;

                    ReportHelper ReportText = new ReportHelper();
                    Report_BL ObjReportBl = new Report_BL(base.ContextInfo);
                    List<ReportMaster> ReportName = new List<ReportMaster>();
                    // long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
                    long ReportID = 3;

                    ObjReportBl.GetReportPath(ReportID, out ReportName);
                    string reportPath = ReportName[0].ReportPath.ToString();
                    List<long> list = new List<long>();
                    Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = GetReportParameters(reportPath, list);
                    ShowReport(reportPath, reportParameterList);
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }

    private void ShowReport(string reportPath, Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList)
    {
        long returncode = -1;
        string strURL = string.Empty;
        ReportViewer.Attributes.Add("style", "width:100%; height:400px");
        ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredentIPBillwise();
        GateWay objGatewayBL = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGatewayBL.GetConfigDetails("ReportServerURL", OrgID, out lstConfig);
        strURL = lstConfig[0].ConfigValue;
        if (strURL == string.Empty)
        {
            CLogger.LogWarning("Report ServerURL is Null");
        }
        ReportViewer.ShowPrintButton = false;
        ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
        ReportViewer.ServerReport.ReportPath = reportPath;
        ReportViewer.ShowParameterPrompts = false;

        //Set only when parameters are required

        if (reportParameterList != null)
        {
            ReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        ReportViewer.ServerReport.Refresh();
    }

    private Microsoft.Reporting.WebForms.ReportParameter[] GetReportParameters<T>(string reportPath, List<T> list)
    {
        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList;
        //long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
        long ReportID = 3;
        string visitID = "0";
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? "0" : Request.QueryString["VID"].ToString();
        }

        if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.IpBillSummary))
        {
            reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[1];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", visitID);
        }
        else
        {
            reportParameterList = null;
        }
        return reportParameterList;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }
}
class MyReportServerCredentIPBillwise : IReportServerCredentials
{
    public MyReportServerCredentIPBillwise()
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
            //string LoginName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
            //string Password = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];
            //
            string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
            string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];
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
