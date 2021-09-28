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

public partial class Admin_ReportDisplay : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                ReportHelper ReportText = new ReportHelper();
                Report_BL ObjReportBl = new Report_BL(base.ContextInfo);
                List<ReportMaster> ReportName = new List<ReportMaster>();
                long  ReportID=Convert.ToInt32(Request.QueryString["ReportID"].ToString());
                ObjReportBl.GetReportPath(ReportID, out ReportName);
                string reportPath = ReportName[0].ReportPath.ToString();
                List<long> list = new List<long>();
                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = GetReportParameters(reportPath, list);
                ShowReport(reportPath, reportParameterList);
            }
         }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }

    #region ShowReport

    private void ShowReport(string reportPath, Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList)
    {
        long returncode = -1;
        string strURL = string.Empty;
        ReportViewer.Attributes.Add("style", "width:100%; height:400px");
        ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredentReport();
        GateWay objGatewayBL = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGatewayBL.GetConfigDetails("ReportServerURL", OrgID, out lstConfig);
        strURL = lstConfig[0].ConfigValue;
        if (strURL == string.Empty)
        {
            CLogger.LogWarning("Report ServerURL is Null");
        }
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
    #endregion

    #region GetReportParameters
    private Microsoft.Reporting.WebForms.ReportParameter[] GetReportParameters<T> (string reportPath, List<T> list)
    {
        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList;
        long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());

        if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.SnapshotView))
        {
            reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[1];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("orgID", OrgID.ToString());
        }
        else if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.PhysicianWiseReport))
        {
            DropDownShow();
            reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[1];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("PhysicianID", OrgID.ToString());
        }

        else if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.IpBillSummary))
        {
            reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[1];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("orgID", OrgID.ToString());
        }
        
        else
        {
            reportParameterList = null;
        }
        return reportParameterList;
    }
    #endregion
    
    public void DropDownShow()
    {
        Physician_BL ObjPhysician = new Physician_BL(base.ContextInfo);
        List<Physician> physicianList = new List<Physician>();
        ObjPhysician.GetPhysicianListByOrg(OrgID, out physicianList,0);
        ddlList.DataSource = physicianList;
        ddlList.DataTextField = "PhysicianName";
        ddlList.DataValueField = "PhysicianID";
        ddlList.DataBind();
        ddlList.Items.Insert(0, "--All--");
        ddlList.Items[0].Value = "0";
    }
  
     #region Events
     protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        string strValue = ddlList.SelectedValue;
        string reportPath = Request.QueryString["ReportPath"].ToString();
        List<Physician> objPhysician = new List<Physician>();
        long physicianID = Convert.ToInt64(strValue);
        List<long> physicianList = new List<long>();
        physicianList.Add(physicianID);
        ShowReport(reportPath, GetReportParameters(reportPath,physicianList));
    }
     #endregion
}


#region ReportServerCredentials
class MyReportServerCredentReport : IReportServerCredentials
{
    public MyReportServerCredentReport()
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
            string LoginName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
            string Password = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];
            return new System.Net.NetworkCredential(LoginName, Password);
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
#endregion
