using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Solution.BusinessComponent;
using Microsoft.Reporting.WebForms;
using Attune.Podium.Common;
using System.Data;
using System.Net;
using System.Configuration;

/// <summary>
/// Summary description for ReportUtil
/// </summary>
public class PDFReportUtil
{
    public PDFReportUtil()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public ReportParameter[] GetInvestigationReportParameter(long visitID, int templateID, string InvID, int orgID, string IsPageNumberVisible)
    {
        ReportParameter[] lstReportParameter = new ReportParameter[6];
        try
        {
            string connectionString = Utilities.GetConnectionString();
            lstReportParameter[0] = new ReportParameter("pVisitID", Convert.ToString(visitID));
            lstReportParameter[1] = new ReportParameter("OrgID", Convert.ToString(orgID));
            lstReportParameter[2] = new ReportParameter("TemplateID", Convert.ToString(templateID));
            lstReportParameter[3] = new ReportParameter("InvestigationID", Convert.ToString(InvID));
            lstReportParameter[4] = new ReportParameter("ConnectionString", connectionString);
            lstReportParameter[5] = new ReportParameter("IsPageNumberVisible", IsPageNumberVisible);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return lstReportParameter;
    }

    public long GenerateReport(ReportViewer reportViewer, ReportParameter[] lstReportParameter, Int32 orgID, String reportPath)
    {
        long returnCode = -1;
        string reportServerUrl;
        try
        {
            reportServerUrl = this.GetConfigValues("ReportServerURL", orgID);

            ServerReport serverReport = reportViewer.ServerReport;
            serverReport.ReportServerCredentials = new CustomReportCredentials1();
            serverReport.ReportServerUrl = new Uri(reportServerUrl);
            serverReport.ReportPath = reportPath;
            ReportParameterInfoCollection lstReportParameterCollection = serverReport.GetParameters();

            List<ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                  join RP in lstReportParameter on RPC.Name equals RP.Name
                                                  select RP).ToList();
            serverReport.SetParameters(lstParameter);
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Generating Report", ex);
        }
        return returnCode;
    }

    public long RenderReport(ReportParameter[] lstReportParameter, int orgID, string reportPath, string renderFormat, string deviceInfo, out byte[] reportBytes)
    {
        long returnCode = -1;
        Warning[] warnings;
        string mimeType, encoding, extension;
        string[] streamIDs;
        ReportViewer reportViewer;
        reportBytes = new byte[byte.MaxValue];
        try
        {
            reportViewer = new ReportViewer();
            returnCode = GenerateReport(reportViewer, lstReportParameter, orgID, reportPath);
            if (returnCode == 0)
                reportBytes = reportViewer.ServerReport.Render(renderFormat, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Rendering Report", ex);
        }
        return returnCode;
    }

    public long GetReports(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, string InvReportConfig, Int64 CreatedBy, List<InvReportMaster> lstInvIDs, string PrintConfig, out List<ReportSnapshot> lstReportSnapshot, bool isCustomPageNumberRequired)
    {
        long returnCode = -1;
        lstReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstExistReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
        string lstTemplateID;
        List<InvReportMaster> lstReports;
        try
        {
            lstTemplateID = string.Empty;
            lstReports = new List<InvReportMaster>();
            lstReports = this.GetReportList(VisitID, OrgID, OrgAddressID, InvReportConfig, lstInvIDs);
            if (InvReportConfig.Trim() == "PrintReport")
            {
                lstExistReportSnapshot = this.GetReportSnapshot(OrgID, OrgAddressID, VisitID, false);

                lstTemplateID = string.Join(",", ((from rs in lstExistReportSnapshot
                                                   select rs.TemplateID.ToString()).Distinct()).ToArray());
            }
            this.GetReportSnapshotList(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired);
            lstReportSnapshot = lstReportSnapshot.Union(lstExistReportSnapshot).ToList();
            if (InvReportConfig.Trim() == "PrintReport")
            {
                if (lstNewReportSnapshot.Count > 0)
                {
                    this.SaveReport(OrgID, OrgAddressID, VisitID, CreatedBy, lstNewReportSnapshot);
                }
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Reports", ex);
        }
        return returnCode;
    }
    public void SavePrintedReport(Int32 OrgID, Int64 RoleID, Int32 OrgAddressID, Int64 VisitID, Int64 CreatedBy, List<InvReportMaster> lstInvReportMaster)
    {
        long returnCode = -1;
        try
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("InvestigationName", typeof(System.String));
            dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
            dataTable.Columns.Add("GroupID", typeof(System.Int32));
            dataTable.Columns.Add("GroupName", typeof(System.String));
            dataTable.Columns.Add("PatientVisitID", typeof(System.Int64));
            dataTable.Columns.Add("CreatedBy", typeof(System.Int64));
            dataTable.Columns.Add("CollectedDateTime", typeof(System.DateTime));
            dataTable.Columns.Add("Status", typeof(System.String));
            dataTable.Columns.Add("ComplaintID", typeof(System.Int32));
            dataTable.Columns.Add("Type", typeof(System.String));
            dataTable.Columns.Add("IPInvSampleCollectionMasterID", typeof(System.Int64));
            DataRow dataRow;

            foreach (InvReportMaster objInvReportMastert in lstInvReportMaster)
            {
                dataRow = dataTable.NewRow();
                dataRow["InvestigationName"] = objInvReportMastert.InvestigationName;
                dataRow["InvestigationID"] = objInvReportMastert.InvestigationID;
                dataRow["GroupID"] = 0;
                dataRow["GroupName"] = "";
                dataRow["PatientVisitID"] = 0;
                dataRow["CreatedBy"] = 0;
                dataRow["CollectedDateTime"] = DateTime.Now;
                dataRow["Status"] = objInvReportMastert.Status;
                dataRow["ComplaintID"] = 0;
                dataRow["Type"] = objInvReportMastert.Type;
                dataRow["IPInvSampleCollectionMasterID"] = objInvReportMastert.AccessionNumber;

                dataTable.Rows.Add(dataRow);
            }
            if (dataTable.Rows.Count > 0)
            {
                Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                returnCode = objReportBL.SavePrintedReport(dataTable, VisitID, OrgID, RoleID, OrgAddressID, CreatedBy, string.Empty, string.Empty, string.Empty);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Save PrintedReport", ex);
        }
    }
    public void GetReportSnapshotList(List<InvReportMaster> lstReports, Int64 VisitID, Int32 OrgID, string lstTemplateID, out List<ReportSnapshot> lstReportSnapshot, out List<ReportSnapshot> lstNewReportSnapshot, bool isCustomPageNumberRequired)
    {
        long returnCode = -1;
        ReportSnapshot objReportSnapshot;
        string AccessionNo, TemplateName, deviceInfo;
        lstReportSnapshot = new List<ReportSnapshot>();
        lstNewReportSnapshot = new List<ReportSnapshot>();
        List<byte[]> lstSourceByte = new List<byte[]>();
        StringBuilder rsTemplateID = new StringBuilder();
        NotesPatternReport objNotesReport = new NotesPatternReport();
        byte[] ReportByteArr;
        try
        {
            deviceInfo = "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>A4</PageSize><PageWidth>8.5in</PageWidth><PageHeight>11in</PageHeight></DeviceInfo>";

            var lstReportName = (from child in lstReports
                                 where !lstTemplateID.Contains(child.TemplateID.ToString())
                                 group child by new { child.TemplateID, child.ReportTemplateName }
                                     into grp
                                     select grp);
            int ReportTemplateCount = lstReportName.Count();
            ReportParameter[] lstReportParameter;
            foreach (var objReportName in lstReportName)
            {
                AccessionNo = string.Empty;
                TemplateName = string.Empty;
                ReportByteArr = new byte[byte.MaxValue];

                TemplateName = objReportName.Key.ReportTemplateName;

                if (objReportName.Key.TemplateID != 10)
                {
                    TemplateName = objReportName.Key.ReportTemplateName;

                    AccessionNo = string.Join(",", ((from p in lstReports
                                                     where p.TemplateID == objReportName.Key.TemplateID
                                                     select p.AccessionNumber.ToString()).Distinct()).ToArray());
                    if (ReportTemplateCount > 1)
                    {
                        lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "N");
                    }
                    else
                    {
                        lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "Y");
                    }
                    returnCode = this.RenderReport(lstReportParameter, OrgID, TemplateName, "PDF", deviceInfo, out ReportByteArr);
                    if (returnCode == 0)
                    {
                        lstSourceByte.Add(ReportByteArr);
                        if (rsTemplateID.Length == 0)
                        {
                            rsTemplateID.Append(objReportName.Key.TemplateID);
                        }
                        else
                        {
                            rsTemplateID.Append("," + objReportName.Key.TemplateID);
                        }
                    }
                }
                else
                {
                    long[] lstInvestigationID = ((from p in lstReports
                                                  where p.TemplateID == objReportName.Key.TemplateID
                                                  select p.InvestigationID).Distinct()).ToArray();

                    foreach (long InvestigationID in lstInvestigationID)
                    {
                        returnCode = objNotesReport.GenerateReport(OrgID, VisitID, objReportName.Key.TemplateID, InvestigationID, out ReportByteArr);
                        if (returnCode == 0)
                        {
                            lstSourceByte.Add(ReportByteArr);
                            if (rsTemplateID.Length == 0)
                            {
                                rsTemplateID.Append(objReportName.Key.TemplateID);
                            }
                            else
                            {
                                rsTemplateID.Append("," + objReportName.Key.TemplateID);
                            }
                        }
                    }
                }
            }
            if (lstSourceByte.Count > 0)
            {
                byte[] destByte;
                if (lstSourceByte.Count > 1)
                    destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, isCustomPageNumberRequired, OrgID);
                else
                    destByte = lstSourceByte[0];
                objReportSnapshot = new ReportSnapshot();
                objReportSnapshot.TemplateID = rsTemplateID.ToString();
                objReportSnapshot.Content = destByte;
                lstReportSnapshot.Add(objReportSnapshot);
                lstNewReportSnapshot.Add(objReportSnapshot);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report Snapshot List", ex);
        }
    }

    public List<InvReportMaster> GetReportList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, string InvReportConfig, List<InvReportMaster> lstInvIDs)
    {
        Patient_BL patientBL;
        List<InvDeptMaster> lstDpts;
        List<InvReportMaster> lstAllReport, lstReportName;
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        try
        {
            patientBL = new Patient_BL(new BaseClass().ContextInfo);
            lstAllReport = new List<InvReportMaster>();
            lstReportName = new List<InvReportMaster>();
            lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(VisitID, OrgID,"", out lstAllReport, out lstReportName, out lstDpts);
            if (InvReportConfig.Trim() == "PrintReport")
            {
                lstReports = (from child in lstAllReport
                              where child.Status == InvStatus.Approved
                              select child).ToList();
            }
            else if (InvReportConfig.Trim() == "ShowReport")
            {
                lstReports = (from child in lstAllReport
                              join ch in lstInvIDs on child.InvestigationID equals ch.InvestigationID
                              //where child.Status == InvStatus.Approved || child.Status == InvStatus.Completed || child.Status == InvStatus.Pending
                              select child).ToList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report List", ex);
        }
        return lstReports;
    }
    public List<ReportSnapshot> GetReportSnapshot(Int32 OrgID, Int32 OrgAddressID, Int64 VisitID, bool UpdateStatus)
    {
        long returnCode = -1;
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        try
        {
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
            returnCode = objReportBL.GetReportSnapshot(OrgID, OrgAddressID, VisitID, UpdateStatus, "", out lstReportSnapshot);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report Snapshot", ex);
        }
        return lstReportSnapshot;
    }

    public long SaveReportSnapshot(Int32 OrgID, Int32 OrgAddressID, Int64 VisitID, Int64 CreatedBy, string InvestigationStatus, bool isCustomPageNumberRequired, List<InvReportMaster> InvIDs)
    {
        long returnCode = -1;
        List<InvReportMaster> lstReports;
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
        try
        {
            lstReports = new List<InvReportMaster>();
            lstReports = this.GetReportList(VisitID, OrgID, OrgAddressID, InvestigationStatus, InvIDs);
            this.GetReportSnapshotList(lstReports, VisitID, OrgID, string.Empty, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired);
            if (lstNewReportSnapshot.Count > 0)
            {
                this.SaveReport(OrgID, OrgAddressID, VisitID, CreatedBy, lstNewReportSnapshot);
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Report Snapshot", ex);
        }
        return returnCode;
    }

    public void SaveReport(Int32 OrgID, Int32 OrgAddressID, Int64 VisitID, Int64 CreatedBy, List<ReportSnapshot> lstReportSnapshot)
    {
        long returnCode = -1;
        try
        {

            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("Content", typeof(System.Byte[]));
            dataTable.Columns.Add("TemplateID", typeof(System.String));
            dataTable.Columns.Add("Status", typeof(System.String));
            dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
            dataTable.Columns.Add("VisitID", typeof(System.Int64));
            DataRow dataRow;

            foreach (ReportSnapshot objReportSnapshot in lstReportSnapshot)
            {
                dataRow = dataTable.NewRow();
                dataRow["TemplateID"] = objReportSnapshot.TemplateID;
                dataRow["Content"] = objReportSnapshot.Content;
                dataRow["Status"] = ReportProcessStatus.Ready;
                dataRow["InvestigationID"] = "";
                dataRow["VisitID"] = "";

                dataTable.Rows.Add(dataRow);
            }
            DataTable dt = createDataTableForInvoiceDetails();
            if (dataTable.Rows.Count > 0)
            {
                Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                returnCode = objReportBL.SaveReportSnapshot(dataTable, dt, VisitID, OrgID, OrgAddressID, CreatedBy);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Report", ex);
        }
    }

    private DataTable createDataTableForInvoiceDetails()
    {
        System.Data.DataTable dt1 = new DataTable();
        try
        {
            DataColumn Col1 = new DataColumn("Content");
            DataColumn Col6 = new DataColumn("NotificationID");
            DataColumn Col2 = new DataColumn("ClientID");
            DataColumn Col3 = new DataColumn("InvoiceID");
            DataColumn Col4 = new DataColumn("FromDate");
            DataColumn Col5 = new DataColumn("TODate");
            DataColumn Col7 = new DataColumn("ReportPath");
            DataColumn Col8 = new DataColumn("OrgID");
            DataColumn Col9 = new DataColumn("OrgAddressID");
            //add columns
            dt1.Columns.Add(Col1);
            dt1.Columns.Add(Col2);
            dt1.Columns.Add(Col3);
            dt1.Columns.Add(Col4);
            dt1.Columns.Add(Col5);
            dt1.Columns.Add(Col6);
            dt1.Columns.Add(Col7);
            dt1.Columns.Add(Col8);
            dt1.Columns.Add(Col9);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While createDataTableForInvoiceDetails", ex);
        }
        return dt1;
    }
    private string GetConfigValues(string strConfigKey, Int32 OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {

            GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
            List<Config> lstConfig = new List<Config>();
            long returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report ConfigValue " + strConfigKey, ex);
        }
        return strConfigValue;
    }
}
class CustomReportCredentials1 : IReportServerCredentials
{
    string userName1 = ConfigurationManager.AppSettings["ReportUserName"];
    string password1 = ConfigurationManager.AppSettings["ReportPassword"];

    public CustomReportCredentials1()
    {
    }

    public System.Security.Principal.WindowsIdentity ImpersonationUser
    {
        get
        {
            return null;  // Use default identity.
        }
    }

    public ICredentials NetworkCredentials
    {
        get
        {
            return new NetworkCredential(userName1, password1);
        }
    }

    public bool GetFormsCredentials(out Cookie authCookie, out string user, out string password, out string authority)
    {
        authCookie = null;
        user = password = authority = null;
        return false;  // Not use forms credentials to authenticate.
    }
}
