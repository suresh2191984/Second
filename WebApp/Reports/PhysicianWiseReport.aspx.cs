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

public partial class Reports_PhysicianWiseReport : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0);");
            if (!IsPostBack)
            {
                ReportHelper ReportText = new ReportHelper();
                Report_BL ObjReportBl = new Report_BL(base.ContextInfo);
                List<ReportMaster> ReportName = new List<ReportMaster>();
                long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
                ObjReportBl.GetReportPath(ReportID, out ReportName);
                string reportPath = ReportName[0].ReportPath.ToString();
                List<long> list = new List<long>();
                DropDownShow();
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
        ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredentPhysician();
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
        if (reportParameterList != null)
        {
            ReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        ReportViewer.ServerReport.Refresh();
    }

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

    private Microsoft.Reporting.WebForms.ReportParameter[] GetReportParameters<T>(string reportPath, List<T> list)
    {
        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList;
        long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
        int PhysicianID =Convert.ToInt32(ddlList.SelectedValue);
        DateTime FromDate;
        DateTime ToDate;

        if (chkTodayDate.Checked)
        {
            FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date;
            ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date;
        }
        else
        {
            FromDate = Convert.ToDateTime(txtFromDate.Text);
            ToDate = Convert.ToDateTime(txtToDate.Text);
        }

        if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.PhysicianWiseReport))
        {
            reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[3];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("PhysicianID", PhysicianID.ToString());
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("FromDate", txtFromDate.ToString());
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("ToDate", txtToDate.ToString());

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
    protected void btnGo_Click(object sender, EventArgs e)
    {
        ReportHelper ReportText = new ReportHelper();
        Report_BL ObjReportBl = new Report_BL(base.ContextInfo);
        List<ReportMaster> ReportName = new List<ReportMaster>();
        long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
        ObjReportBl.GetReportPath(ReportID, out ReportName);
        string reportPath = ReportName[0].ReportPath.ToString();
        List<long> list = new List<long>();
        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = GetReportParameters(reportPath, list);
        ShowReport(reportPath, reportParameterList);
    }
}

class MyReportServerCredentPhysician : IReportServerCredentials
{
    public MyReportServerCredentPhysician()
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
