#region File Header Comments (to be placed before using block)
//=======================================================================================
// Copyright (C) 2007-2012 Attune Technologies, Adyar, Chennai
//========================================================================================
// Purpose: To get the Doctors' statictics
// Author: <CODER NAME>
// Date Created: <DATE>
//========================================================================================
// File Change History (to be updated everytime this file is modified)
// ---------------------------------------------------------------------------------------
//  Date            Worker                        Work Description
// ---------------------------------------------------------------------------------------
// 18-Nov-2010      Vijay TV                     1. Error handling in Convert.ToInt32
//                                               2. Proper information in logging of errors
//                                               3. Commenting out needless code block
// ---------------------------------------------------------------------------------------
#endregion

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

public partial class Reports_DayWiseBillReport : BasePage
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
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                // long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
                // ObjReportBl.GetReportPath(ReportID, out ReportName);
                // string reportPath = ReportName[0].ReportPath.ToString();
                int ReportID;
                Int32.TryParse(Request.QueryString["ReportID"], out ReportID); // TryParse done
                ObjReportBl.GetReportPath( Convert.ToInt64(ReportID), out ReportName); // ReportID type casted to long
                string reportPath = (ReportName != null && ReportName.Count > 0)? ReportName[0].ReportPath: string.Empty; // ReportName list is checked for null and then assigned
                //
                // If the reportPath is Null, then log that error and return
                if (reportPath == string.Empty)
                {
                    CLogger.LogWarning("Daywise Bill Report - Report path not configured");
                    return;
                }
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
                List<long> list = new List<long>();
                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = GetReportParameters(reportPath, list);
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
                if (reportParameterList == null || reportParameterList.Length == 0)
                {
                    CLogger.LogWarning("Daywise Bill Report - Report parameter not configured or available");
                    return;
                }
                ShowReport(reportPath, reportParameterList);
                // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
            }
        }
        catch (Exception ex)
        {
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
            // CLogger.LogError("Error while Loading SSRS", ex);
            CLogger.LogError("Error while Loading SSRS in Daywise Bill Report", ex);
            // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        }
    }

     private void ShowReport(string reportPath, Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList)
    {
        long returncode = -1;
        string strURL = string.Empty;
        ReportViewer.Attributes.Add("style", "width:100%; height:400px");
        ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredentDaywise();
        GateWay objGatewayBL = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGatewayBL.GetConfigDetails("ReportServerURL", OrgID, out lstConfig);
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        // strURL = lstConfig[0].ConfigValue;
        //if (strURL == string.Empty)
        //{
        //    CLogger.LogWarning("Report ServerURL is Null");
        //}
        strURL = (lstConfig != null && lstConfig.Count > 0) ? lstConfig[0].ConfigValue : string.Empty;
        if (strURL == string.Empty)
        {
            CLogger.LogWarning("Daywise Bill Report - Report ServerURL is Null");
            return;
        }
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
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
  
    private Microsoft.Reporting.WebForms.ReportParameter[] GetReportParameters<T> (string reportPath, List<T> list)
    {
        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList;
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 begins
        // long ReportID = Convert.ToInt32(Request.QueryString["ReportID"].ToString());
        int ReportID;
        Int32.TryParse(Request.QueryString["ReportID"], out ReportID);
        // Code modified by Vijay TV for issue (internal) on 17-Nov-2010 ends
        if (ReportID == Convert.ToInt32(ReportHelper.ReportNames.DayWiseBillReport))
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
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }
}

class MyReportServerCredentDaywise : IReportServerCredentials
{
    public MyReportServerCredentDaywise()
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
            string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
            string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];
    
            return new System.Net.NetworkCredential(CredentialuserName,CredentialpassWord);
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