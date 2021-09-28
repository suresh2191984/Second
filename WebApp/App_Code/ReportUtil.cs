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
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
/// <summary>
/// Summary description for ReportUtil
/// </summary>
public class ReportUtil
{
    ContextDetails globalContextDetails;
       
        
    public ReportUtil()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public ReportUtil(ContextDetails localContextDetails)
        {
            globalContextDetails = localContextDetails;
        }
    
   string IsServiceRqst="";
            string IsReprintNeeded ="";
            Patient_BL Pat_BL = new Patient_BL(new BaseClass().ContextInfo);
            List<ReprintMergeRDLSize> lstRDLSise = new List<ReprintMergeRDLSize>();
   public ReportParameter[] GetInvestigationReportParameter(long visitID, int templateID, string InvID, int orgID, string IsPageNumberVisible, string ShowReportHeader, string ShowReportFooter, string IsEndOfReportTextVisible, string IsServiceRequest, string ReportType)
    {
        ReportParameter[] lstReportParameter = new ReportParameter[11];
        try
        {
            string connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            lstReportParameter[0] = new ReportParameter("pVisitID", Convert.ToString(visitID));
            lstReportParameter[1] = new ReportParameter("OrgID", Convert.ToString(orgID));
            lstReportParameter[2] = new ReportParameter("TemplateID", Convert.ToString(templateID));
            lstReportParameter[3] = new ReportParameter("InvestigationID", Convert.ToString(InvID));
            lstReportParameter[4] = new ReportParameter("ConnectionString", connectionString);
            lstReportParameter[5] = new ReportParameter("ShowReportHeader", ShowReportHeader);
            lstReportParameter[6] = new ReportParameter("ShowReportFooter", ShowReportFooter);
            lstReportParameter[7] = new ReportParameter("IsEndOfReportTextVisible", IsEndOfReportTextVisible);
            lstReportParameter[8] = new ReportParameter("IsPageNumberVisible", IsPageNumberVisible);
            lstReportParameter[9] = new ReportParameter("IsServiceRequest", IsServiceRequest);            
            lstReportParameter[10] = new ReportParameter("ReportType", ReportType);   
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return lstReportParameter;
    }

    public ReportParameter[] GetInvoiceReportParameter(long InvID, string reportPath, int orgID, int OrgAddressID)
    {
        ReportParameter[] reportParameterList = new ReportParameter[5];
        try
        {
            string connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pInvoiceID", Convert.ToString(InvID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("reportPath", reportPath);
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(orgID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(OrgAddressID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return reportParameterList;
    }

    public long GetInvoiceReports(Int64 InvID, string reportPath, Int32 OrgID, Int32 OrgAddressID, out List<ReportSnapshot> lstReportSnapshot)
    {
        long returnCode = -1;
        lstReportSnapshot = new List<ReportSnapshot>();
        ReportSnapshot objReportSnapshot;
        ReportParameter[] lstReports;
        List<byte[]> lstSourceByte = new List<byte[]>();
        byte[] ReportByteArr;
        try
        {
            lstReports = this.GetInvoiceReportParameter(InvID, reportPath, OrgID, OrgAddressID);



            string deviceInfo = null;// "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>A4</PageSize><PageWidth>8.5in</PageWidth><PageHeight>11in</PageHeight></DeviceInfo>";
            returnCode = this.RenderReport(lstReports, OrgID, reportPath, "PDF", deviceInfo, out ReportByteArr);
            if (returnCode == 0)
            {
                lstSourceByte.Add(ReportByteArr);
            }
            if (lstSourceByte.Count > 0)
            {
                byte[] destByte;
                IsReprintNeeded = GetConfigValues("IsReprintNeeded",OrgID);
                if (IsReprintNeeded == "Y")
                {
                    
                     Pat_BL.GetReprintRDLSize(OrgID, out lstRDLSise);
                    if (lstSourceByte.Count > 1)
                    {
                        destByte = Attune.PdfMerger.ReprintMergeFiles(lstSourceByte, true,lstRDLSise[0].MoveX,lstRDLSise[0].MoveY,lstRDLSise[0].LineX,lstRDLSise[0].LineY,lstRDLSise[0].FontSize,"");
                    }
                    else
                    {
                        destByte = lstSourceByte[0];

                    }
                }
                else
                {
                    if (lstSourceByte.Count > 1)
                    {
                        destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, true, OrgID);
                    }
                    else
                    {
                        destByte = lstSourceByte[0];

                    }
                }
                objReportSnapshot = new ReportSnapshot();
                objReportSnapshot.TemplateID = "";
                objReportSnapshot.Content = destByte;
                lstReportSnapshot.Add(objReportSnapshot);
                lstReportSnapshot.Add(objReportSnapshot);
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Reports", ex);
        }
        return returnCode;
    }

    public long GenerateReport(ReportViewer reportViewer, ReportParameter[] lstReportParameter, Int32 orgID, String reportPath)
    {
        long returnCode = -1;
        string reportServerUrl;
        try
        {
            reportServerUrl = this.GetConfigValues("ReportServerURL", orgID);

            ServerReport serverReport = reportViewer.ServerReport;
            serverReport.ReportServerCredentials = new CustomReportCredentials();
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

		if (orgID == 98)
                {
                    iTextSharp.text.pdf.PdfReader pdfReader = new iTextSharp.text.pdf.PdfReader(reportBytes);
                    iTextSharp.text.pdf.parser.SimpleTextExtractionStrategy Obj = new iTextSharp.text.pdf.parser.SimpleTextExtractionStrategy();

                    string _findString = iTextSharp.text.pdf.parser.PdfTextExtractor.GetTextFromPage(pdfReader, 1, Obj); 
                    bool _ErrorPdf = _findString.Contains("Error: Subreport could not be shown.");
                    if (_ErrorPdf)
                    {
                        reportBytes = new byte[0];
                    }

                }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Rendering Report", ex);
        }
        return returnCode;
    }
    public long ShowReportByservice(string reportPath, long InvID, long Orgid, long OrgAddressID, long LID, out byte[] results)
    {
        long returnCode = -1;
        results = new byte[byte.MaxValue];
        try
        {
            string deviceInfo = null;
            string format = "PDF";
            results = new byte[byte.MaxValue];
            string encoding = String.Empty;
            string mimeType = String.Empty;
            string extension = String.Empty;
            string[] streamIDs = null;
            Warning[] warnings;
            ReportViewer reportViewer;
            reportViewer = new ReportViewer();
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            reportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //strURL = "http://attune4-pc/ReportServer";
            strURL = GetConfigValues("ReportServerURL", Convert.ToInt32(Orgid));
            reportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            reportViewer.ServerReport.ReportPath = reportPath;
            reportViewer.ShowParameterPrompts = false;
            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[6];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pInvoiceID", Convert.ToString(InvID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(Orgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(OrgAddressID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("LoginID", Convert.ToString(LID));
           // reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("pClientID", Convert.ToString(0));
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("InvoiceType", "Orginal");
            reportViewer.ServerReport.SetParameters(reportParameterList);
            results = reportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
        return returnCode;
    }
    //added by prabakar for client bill generation by auto email service*******-29-09-2013//
    public long GenerateBillReceiptByservice(string reportPath, long visitID, string PhysicianName, long FinalBillID, string SplitStatus, long Orgid, long OrgAddressID, long LID, out byte[] results)
    {
        long returnCode = -1;
        results = new byte[byte.MaxValue];
        try
        {
            //Added by Thamilselvan...for Full Bill
            string[] lstpath = reportPath.Split(':');
            string IsFullBill = string.Empty;
            if (lstpath != null)
            {
                if (lstpath.Length > 1)
                {
                    IsFullBill = reportPath.Split(':')[1].Length > 0 ? reportPath.Split(':')[1] : null;
                    reportPath =reportPath.Split(':')[0];
                }
                else
                {
                    reportPath = reportPath.Split(':')[0];
                }
            }
            //------
             
            CLogger.LogWarning(reportPath+ " SYED");

            string deviceInfo = null;
            string format = "PDF";
            string encoding = String.Empty;
            string mimeType = String.Empty;
            string extension = String.Empty;
            string[] streamIDs = null;
            Warning[] warnings;
            ReportViewer reportViewer;
            reportViewer = new ReportViewer();
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            reportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //strURL = "http://attune4-pc/ReportServer";
            strURL = GetConfigValues("ReportServerURL", Convert.ToInt32(Orgid));
            reportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            reportViewer.ServerReport.ReportPath = reportPath;
            reportViewer.ShowParameterPrompts = false;
            if (string.IsNullOrEmpty(IsFullBill))
            {
                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[8];//Added by Thamilselvan...for Full Bill
                reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
                reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pPhysicianName", "Name");
                reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("pBillID", Convert.ToString(FinalBillID));
                reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("SplitStatus", "status");
                reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(Orgid));
                reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(OrgAddressID));
                reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
                reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("LoginID", Convert.ToString(LID));
                reportViewer.ServerReport.SetParameters(reportParameterList);
            }
            else
            {
                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[9];//Added by Thamilselvan...for Full Bill
                reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
                reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pPhysicianName", "Name");
                reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("pBillID", Convert.ToString(FinalBillID));
                reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("SplitStatus", "status");
                reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(Orgid));
                reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(OrgAddressID));
                reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
                reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("LoginID", Convert.ToString(LID));
                //Added by Thamilselvan...for Full Bill
                reportParameterList[8] = new Microsoft.Reporting.WebForms.ReportParameter("IsFullBill", IsFullBill);
                //------
                reportViewer.ServerReport.SetParameters(reportParameterList);
            }
            results = reportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
        return returnCode;
    }
    //**************************************************ENd*******************************************/

    //*********************Added By prabakar for Silent Service*******************************************/
    public void GetReportSnapshotListForPrintPdf(List<InvReportMaster> lstReports, Int64 VisitID, Int32 OrgID, string lstTemplateID, out List<ReportSnapshot> lstReportSnapshot, out List<ReportSnapshot> lstNewReportSnapshot, bool isCustomPageNumberRequired, string actType, string IsServiceRequest, string ReportType)
    {
        long OrginOrgVisitID = -1;
        int OrginOrgID = 0;
        OrginOrgID = OrgID;
        OrginOrgVisitID = VisitID;
        byte[] results = new byte[byte.MaxValue];
        long returnCode = -1;
        int i = 0;
        long StationaryID = 0;
        string IsSeperatePrint = string.Empty;
        string IsEndOfReportTextVisible = "N";
        string ShowReportHeader = string.Empty;
        string ShowReportFooter = string.Empty;
        ReportSnapshot objReportSnapshot;
        string AccessionNo, TemplateName, deviceInfo;
        AccessionNo = string.Empty;
        lstReportSnapshot = new List<ReportSnapshot>();
        lstNewReportSnapshot = new List<ReportSnapshot>();
        List<byte[]> lstSourceByte = new List<byte[]>();
        StringBuilder rsTemplateID = new StringBuilder();
        NotesPatternReport objNotesReport = new NotesPatternReport();
        string Actiontype = actType;
        byte[] ReportByteArr;
        int IsOutSourceTest = 0;
        //string[] ReportAccession = new string[30];
        var ReportAccession = (from child in lstReports
                               select child.ReportAccessionNumber);
        List<ReportSnapshot> lstStatReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstRotBatReportSnapshot = new List<ReportSnapshot>();
        try
        {
            List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
            returnCode = objReportBL.GetPath(OrgID, VisitID, "", out ReportPath);

            deviceInfo = null;// "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>A4</PageSize><PageWidth>8.27in</PageWidth><PageHeight>11.69in</PageHeight></DeviceInfo>";
            string ISSTATPDF = "";
            if (actType.ToUpper() == "ISSTATPDF")
            {
                ISSTATPDF = "Y";
            }
            else
            {
                ISSTATPDF = "N";
            }

            //var lstReportName = (from child in lstReports
            //                     where !lstTemplateID.Contains(child.TemplateID.ToString()) 
            //                     group child by new { child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint }
            //                         into grp
            //                         select grp);
            var lstReportName = (from child in lstReports
                                 where !lstTemplateID.Contains(child.TemplateID.ToString())
                                 group child by new { child.TransVisitID, child.TransOrgID, child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint }
                                     into grp
                                     select grp);
            var GroupOrgIDs = string.Join(",", ((from r in lstReports
                                                 select r.TransOrgID.ToString()).Distinct()).ToArray());

            int ReportTemplateCount = lstReportName.Count();
            ReportParameter[] lstReportParameter;
            foreach (var objReportName in lstReportName)
            {
                i = i + 1;
                //if (i == ReportTemplateCount)
                //{
                //    IsEndOfReportTextVisible = "Y";
                //    //N-->End Of Report Text will be show
                //}
                //else
                //{
                //    IsEndOfReportTextVisible = "N";
                //    //Y-->End Of Report Text will not be show
                //}

                TemplateName = string.Empty;
                ReportByteArr = new byte[byte.MaxValue];
                TemplateName = objReportName.Key.ReportTemplateName;
                StationaryID = objReportName.Key.StationaryID;
                IsSeperatePrint = objReportName.Key.IsSeperatePrint;
                /* For Org to Org Report Generation */
                if (objReportName.Key.TransVisitID != 0)
                {
                    VisitID = objReportName.Key.TransVisitID;
                }
                if (objReportName.Key.TransOrgID != 0)
                {
                    OrgID = objReportName.Key.TransOrgID;
                }
                if (StationaryID == 0)
                {
                    ShowReportHeader = "Y";
                    ShowReportFooter = "Y";
                }
                else
                {
                    ShowReportHeader = "Y";
                    ShowReportFooter = "Y";
                }
                if (objReportName.Key.TemplateID != 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
                {
                    TemplateName = objReportName.Key.ReportTemplateName;

                    ////AccessionNo = string.Join(",", ((from p in lstReports
                    ////                                 where p.TemplateID == objReportName.Key.TemplateID &&  !ReportAccession.Contains(p.AccessionNumber.ToString())
                    ////                                 && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                    ////                                 select p.AccessionNumber.ToString()).Distinct()).ToArray());
                    if (objReportName.Key.TemplateID != 0)
                    {
                        AccessionNo = string.Join(",", ((from p in lstReports
                                                         where p.TemplateID == objReportName.Key.TemplateID && !ReportAccession.Contains(p.AccessionNumber.ToString())
                                                         && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                                                         && p.TransVisitID == objReportName.Key.TransVisitID
                                                         && p.TransOrgID == objReportName.Key.TransOrgID
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());
                    }
                    else
                    {

                        AccessionNo = "0";
                    }
                    string[] SepAccessionNum;
                    if (IsSeperatePrint.Trim() == "Y")
                    {
                        SepAccessionNum = AccessionNo.Split(',');
                    }
                    else
                    {
                        SepAccessionNum = AccessionNo.Split('N');// N for No Split
                    }
                    int Acccnt = SepAccessionNum.Count();
                    int j = 0;
                    for (int s = 0; s < Acccnt; s++)
                    {
                        j = j + 1;
                        AccessionNo = SepAccessionNum[s].ToString();

                        if (i == ReportTemplateCount && j == Acccnt)
                        {
                            IsEndOfReportTextVisible = "Y";
                            //N-->End Of Report Text will be show
                        }
                        else
                        {
                            IsEndOfReportTextVisible = "N";
                            //Y-->End Of Report Text will not be show
                        }
                        if (ReportTemplateCount > 1 || Acccnt > 1)
                        {
                            lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "N", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest, ReportType);
                        }
                        else
                        {
                            lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "Y", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest, ReportType);
                        }
                        returnCode = this.RenderReport(lstReportParameter, OrgID, TemplateName, "PDF", deviceInfo, out ReportByteArr);
                        if (returnCode == 0 && ReportByteArr.Length > 255)
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
                else if (objReportName.Key.TemplateID == 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
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
                else if (objReportName.Key.ReportTemplateName == "PDF")
                {
                    long[] lstInvestigationID = ((from p in lstReports
                                                  where p.TemplateID == objReportName.Key.TemplateID
                                                  select p.InvestigationID).Distinct()).ToArray();

                    Investigation_BL InvestigationBL = new Investigation_BL();
                    List<PatientInvestigationFiles> lstPDF = null;
                    string pdfPath = string.Empty;
                    string pdfFilePath = string.Empty;
                    foreach (long InvestigationID in lstInvestigationID)
                    {
                        lstPDF = new List<PatientInvestigationFiles>();
                        returnCode = InvestigationBL.ProbeImagesForPatientVisits(VisitID, InvestigationID, OrgID, out lstPDF);
                        if (returnCode == 0 && lstPDF.Count > 0)
                        {
                            foreach (PatientInvestigationFiles objPDF in lstPDF)
                            {
                                pdfPath = GetConfigValues("TRF_UploadPath", OrgID);
                                pdfFilePath = pdfPath + objPDF.FilePath;
                                byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                lstSourceByte.Add(byteArray1);
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
                // OutsourceFilesMerge | VEL |
                else if (objReportName.Key.ReportTemplateName == "OUTSOURCE")
                {
                    long[] AccessionNumber = ((from p in lstReports
                                               where p.TemplateID == objReportName.Key.TemplateID
                                               select p.AccessionNumber).Distinct()).ToArray();

                    Investigation_BL InvestigationBL = new Investigation_BL();
                    List<PatientInvestigationFiles> lstPDF = null;
                    string pdfPath = string.Empty;
                    string pdfFilePath = string.Empty;
                    foreach (long InvestigationID in AccessionNumber)
                    {
                        lstPDF = new List<PatientInvestigationFiles>();
                        returnCode = InvestigationBL.GetOutSourcePDFFileDetails(VisitID, InvestigationID, OrgID, out lstPDF);
                        if (returnCode == 0 && lstPDF.Count > 0)
                        {
                            foreach (PatientInvestigationFiles objPDF in lstPDF)
                            {

                                if (Actiontype.ToUpper() == objPDF.Statustype.ToUpper())
                                {
                                    if (objPDF.Statustype.ToUpper() == "PDF")
                                    {
                                        pdfPath = GetConfigValues("OutSourceReportspdffolderpath", OrgID);
                                    }
                                    if (objPDF.Statustype.ToUpper() == "ROUNDBPDF")
                                    {
                                        pdfPath = GetConfigValues("OutSourceReportRoundpdfprocessfolderpath", OrgID);
                                    }
                              

                                if (!string.IsNullOrEmpty(objPDF.FilePath))
                                {
                                    pdfFilePath = pdfPath + objPDF.FilePath;
                                    byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                    lstSourceByte.Add(byteArray1);
                                    IsOutSourceTest = 1;
                                }

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
                }
            }

            byte[] destByte = new byte[byte.MinValue];
             IsReprintNeeded = GetConfigValues("IsReprintNeeded",OrgID);
             if (IsReprintNeeded == "Y")
             {

                 Pat_BL.GetReprintRDLSize(OrgID, out lstRDLSise);
                 if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                 {
                     destByte = Attune.PdfMerger.ReprintMergeFiles(lstSourceByte, isCustomPageNumberRequired, lstRDLSise[0].MoveX, lstRDLSise[0].MoveY, lstRDLSise[0].LineX, lstRDLSise[0].LineY, lstRDLSise[0].FontSize, "");
                 }
                 else if (lstSourceByte.Count > 0)
                 {
                     destByte = lstSourceByte[0];
                 }
             }
             else
             {
                 if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                 {
                     destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, isCustomPageNumberRequired, OrgID);
                 }
                 else if (lstSourceByte.Count > 0)
                 {
                     destByte = lstSourceByte[0];
                 }
             }
            objReportSnapshot = new ReportSnapshot();
            objReportSnapshot.TemplateID = rsTemplateID.ToString();
            objReportSnapshot.Content = destByte;
            objReportSnapshot.AccessionNumber = AccessionNo;
            lstReportSnapshot.Add(objReportSnapshot);
            lstNewReportSnapshot.Add(objReportSnapshot);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report Snapshot List", ex);
        }
    }

    //*********************End By prabakar***********************************************************/
    public long GetReports(Int64 VisitID, Int32 OrgID, Int64 RoleID, Int32 OrgAddressID, List<string> lstInvStatus, Int64 CreatedBy, bool isCustomPageNumberRequired, string actionType, string deptFilter, int pDeptID, string IsServiceRequest, string ReportType, out List<ReportSnapshot> lstReportSnapshot,string Language)
    {
        long returnCode = -1;
        lstReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstExistReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
        string lstTemplateID;
        List<InvReportMaster> lstReports;
        IsServiceRqst = IsServiceRequest;
        try
        {
            lstTemplateID = string.Empty;
            lstReports = new List<InvReportMaster>();
            if (actionType.ToLower() != "confidpdf" && actionType != "confidroundbpdf"
                && actionType.ToLower() != "clientblindchildpdf" && actionType.ToLower() != "clientblindchildroundbpdf"
                && actionType.ToLower() != "clientblindparentpdf" && actionType.ToLower() != "clientblindparentroundbpdf")
            {
                lstReports = this.GetReportList(VisitID, OrgID, OrgAddressID, lstInvStatus, actionType, ReportType,Language);
            }
            else if(actionType.ToLower() == "confidpdf" || actionType.ToLower() == "confidroundbpdf")
            {
                lstReports = this.GetConfidReportList(VisitID, OrgID, OrgAddressID, lstInvStatus,Language);
            }
            else if (actionType.ToLower() == "clientblindchildpdf" || actionType.ToLower() == "clientblindchildroundbpdf")
            {
                lstReports = this.GetClientBlindChildList(VisitID, OrgID, OrgAddressID, lstInvStatus,Language);
            }
            else if (actionType.ToLower() == "clientblindparentpdf" || actionType.ToLower() == "clientblindparentroundbpdf")
            {
                lstReports = this.GetClientBlindParentList(VisitID, OrgID, OrgAddressID, lstInvStatus,Language);
            }
            lstExistReportSnapshot = this.GetReportSnapshot(OrgID, OrgAddressID, VisitID, false);

            lstTemplateID = string.Join(",", ((from rs in lstExistReportSnapshot
                                               select rs.TemplateID.ToString()).Distinct()).ToArray());

            if (actionType.ToUpper() == "ISSTATPDF" || actionType.ToUpper() == "ROUNDBPDF")
            {
                this.GetReportSnapshotListForPrintPdf(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest,ReportType);
            }
            else
            {
                if (deptFilter == "Y")
                {
                    List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
                    if (pDeptID == -1)
                    {
                        Master_BL objMasterBL = new Master_BL(new BaseClass().ContextInfo);
                        returnCode = objMasterBL.GetLoginDept(Convert.ToInt32(0), OrgID, Convert.ToInt32(RoleID), out lstDept);
                    }
                    else
                    {
                        InvDeptMaster oInvDeptMaster = new InvDeptMaster();
                        oInvDeptMaster.DeptID = pDeptID;
                        lstDept.Add(oInvDeptMaster);
                    }
                    var lstFilterReports = from item1 in lstReports
                                                             join item2 in lstDept
                                               on item1.DeptID equals item2.DeptID
                                                             select item1;
                    List<InvReportMaster> lstFilterReport = lstFilterReports.ToList();

                    this.GetReportSnapshotList(lstFilterReport, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest, ReportType);
                }
                else
                {
                    this.GetReportSnapshotList(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest, ReportType);
                }
            } lstReportSnapshot = lstReportSnapshot.Union(lstExistReportSnapshot).ToList();
            if (actionType != "showreport" && lstReportSnapshot.Count > 0)
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("AccessionNumber", typeof(System.Int64));
                dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
                dataTable.Columns.Add("Status", typeof(System.String));
                DataRow dataRow;
                List<InvReportMaster> lstFilteredReports = (from S in lstReports
                                                                   group S by new { S.AccessionNumber } into g
                                                                   select new InvReportMaster
                                                                    {
                                                                        AccessionNumber = g.Key.AccessionNumber
                                                                    }).Distinct().ToList();

                if (lstFilteredReports != null && lstFilteredReports.Count > 0)
                {
                    foreach (InvReportMaster oInvReportMaster in lstFilteredReports)
                    {
                        dataRow = dataTable.NewRow();
                        dataRow["AccessionNumber"] = oInvReportMaster.AccessionNumber;
                        dataRow["InvestigationID"] = oInvReportMaster.InvestigationID;
                        dataRow["Status"] = oInvReportMaster.Status;

                        dataTable.Rows.Add(dataRow);
                    }
                    if (dataTable.Rows.Count > 0)
                    {
                        Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                        returnCode = objReportBL.SavePrintedReport(dataTable, VisitID, OrgID, RoleID, OrgAddressID, CreatedBy, AuditManager.AuditTypeCode.Print, string.Empty, string.Empty);
                    }
                }
            }
            if (lstNewReportSnapshot.Count > 0)
            {
                this.SaveReport(OrgID, OrgAddressID, VisitID, CreatedBy, lstNewReportSnapshot);
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Reports", ex);
        }
        return returnCode;
    }
    public long GetReports(Int64 VisitID, Int32 OrgID, Int64 RoleID, Int32 OrgAddressID, List<string> lstInvStatus, Int64 CreatedBy, bool isCustomPageNumberRequired, string actionType, string deptFilter, int pDeptID, string IsServiceRequest, string AccessionNo,string ReportType,  out List<ReportSnapshot> lstReportSnapshot,string Language)
    {
        long returnCode = -1;
        lstReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstExistReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
        string lstTemplateID;
        List<InvReportMaster> lstReports;
        IsServiceRqst = IsServiceRequest;
        try
        {
            lstTemplateID = string.Empty;
            lstReports = new List<InvReportMaster>();
            if (actionType.ToLower() != "confidpdf" && actionType != "confidroundbpdf"
                && actionType.ToLower() != "clientblindchildpdf" && actionType.ToLower() != "clientblindchildroundbpdf"
                && actionType.ToLower() != "clientblindparentpdf" && actionType.ToLower() != "clientblindparentroundbpdf")
            {
                lstReports = this.GetReportList(VisitID, OrgID, OrgAddressID, lstInvStatus, actionType,ReportType,Language);
            }
            else if (actionType.ToLower() == "confidpdf" || actionType.ToLower() == "confidroundbpdf")
            {
                lstReports = this.GetConfidReportList(VisitID, OrgID, OrgAddressID, lstInvStatus, Language);
            }
            else if (actionType.ToLower() == "clientblindchildpdf" || actionType.ToLower() == "clientblindchildroundbpdf")
            {
                lstReports = this.GetClientBlindChildList(VisitID, OrgID, OrgAddressID, lstInvStatus, Language);
            }
            else if (actionType.ToLower() == "clientblindparentpdf" || actionType.ToLower() == "clientblindparentroundbpdf")
            {
                lstReports = this.GetClientBlindParentList(VisitID, OrgID, OrgAddressID, lstInvStatus, Language);
            }
            lstExistReportSnapshot = this.GetReportSnapshot(OrgID, OrgAddressID, VisitID, false);

            lstTemplateID = string.Join(",", ((from rs in lstExistReportSnapshot
                                               select rs.TemplateID.ToString()).Distinct()).ToArray());

            if (actionType.ToUpper() == "ISSTATPDF" || actionType.ToUpper() == "ROUNDBPDF")
            {
                this.GetReportSnapshotListForPrintPdf(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest, ReportType);
            }
            else
            {
                if (deptFilter == "Y" || ReportType == "")
                {
                    List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
                    if (pDeptID == -1)
                    {
                        Master_BL objMasterBL = new Master_BL(new BaseClass().ContextInfo);
                        returnCode = objMasterBL.GetLoginDept(Convert.ToInt32(0), OrgID, Convert.ToInt32(RoleID), out lstDept);
                    }
                    else
                    {
                        InvDeptMaster oInvDeptMaster = new InvDeptMaster();
                        oInvDeptMaster.DeptID = pDeptID;
                        lstDept.Add(oInvDeptMaster);
                    }
                    var lstFilterReports = from item1 in lstReports
                                           join item2 in lstDept
                             on item1.DeptID equals item2.DeptID
                                           select item1;
                    List<InvReportMaster> lstFilterReport = lstFilterReports.ToList();
                    this.GetReportSnapshotList(lstFilterReport, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest, ReportType);
                }
                else
                {
                    this.GetReportSnapshotList(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, actionType, IsServiceRequest, AccessionNo, ReportType);
                }
            } lstReportSnapshot = lstReportSnapshot.Union(lstExistReportSnapshot).ToList();
            if (actionType != "showreport" && lstReportSnapshot.Count > 0)
            {
                DataTable dataTable = new DataTable();
                dataTable.Columns.Add("AccessionNumber", typeof(System.Int64));
                dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
                dataTable.Columns.Add("Status", typeof(System.String));
                DataRow dataRow;
                List<InvReportMaster> lstFilteredReports = (from S in lstReports
                                                                   group S by new { S.AccessionNumber } into g
                                                                   select new InvReportMaster
                                                                    {
                                                                        AccessionNumber = g.Key.AccessionNumber
                                                                    }).Distinct().ToList();

                if (lstFilteredReports != null && lstFilteredReports.Count > 0)
                {
                    foreach (InvReportMaster oInvReportMaster in lstFilteredReports)
                    {
                        dataRow = dataTable.NewRow();
                        dataRow["AccessionNumber"] = oInvReportMaster.AccessionNumber;
                        dataRow["InvestigationID"] = oInvReportMaster.InvestigationID;
                        dataRow["Status"] = oInvReportMaster.Status;

                        dataTable.Rows.Add(dataRow);
                    }
                    if (dataTable.Rows.Count > 0)
                    {
                        Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                        returnCode = objReportBL.SavePrintedReport(dataTable, VisitID, OrgID, RoleID, OrgAddressID, CreatedBy, AuditManager.AuditTypeCode.Print, string.Empty, string.Empty);
                    }
                }
            }
            if (lstNewReportSnapshot.Count > 0)
            {
                this.SaveReport(OrgID, OrgAddressID, VisitID, CreatedBy, lstNewReportSnapshot);
            }
            returnCode = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Reports", ex);
        }
        return returnCode;
    }

    public void GetReportSnapshotList(List<InvReportMaster> lstReports, Int64 VisitID, Int32 OrgID, string lstTemplateID, out List<ReportSnapshot> lstReportSnapshot, out List<ReportSnapshot> lstNewReportSnapshot, bool isCustomPageNumberRequired, string actType, string IsServiceRequest, string ReportType)
    {

        long OrginOrgVisitID = -1;
        int OrginOrgID = 0;
        OrginOrgID = OrgID;
        OrginOrgVisitID = VisitID;
       // List<InvReportMaster> lstReports;
        byte[] results = new byte[byte.MaxValue];
        long returnCode = -1;
        int i = 0;
        long StationaryID = 0;
        string IsSeperatePrint = string.Empty;
        string IsEndOfReportTextVisible = "N";
        string ShowReportHeader = string.Empty;
        string ShowReportFooter = string.Empty;
        ReportSnapshot objReportSnapshot;
        string AccessionNo, TemplateName, deviceInfo;
        lstReportSnapshot = new List<ReportSnapshot>();
        lstNewReportSnapshot = new List<ReportSnapshot>();
        List<byte[]> lstSourceByte = new List<byte[]>();
        StringBuilder rsTemplateID = new StringBuilder();
        NotesPatternReport objNotesReport = new NotesPatternReport();
        string Actiontype = actType;
        byte[] ReportByteArr;
        int IsOutSourceTest = 0;
        try
        {
            List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
            returnCode = objReportBL.GetPath(OrgID, VisitID, "", out ReportPath);
            // ReportPath.Count() > 0 ||
            if (Actiontype == "showpdf" || Actiontype == "prtpdf")
            {
                FileStream fs;
                if (ReportPath.Count() > 0)
                {
                    if (System.IO.File.Exists(ReportPath[0].ReportPath))
                    {
                        fs = new FileStream(ReportPath[0].ReportPath, FileMode.Open, FileAccess.Read);
                        results = new byte[fs.Length];
                        fs.Read(results, 0, System.Convert.ToInt32(fs.Length));
                        fs.Close();
                    }
                }

            }
            else
            {
                //  deviceInfo = "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>A4</PageSize><PageWidth>8.27in</PageWidth><PageHeight>11.69in</PageHeight></DeviceInfo>";
                deviceInfo = null;// "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>Custom</PageSize><PageWidth>8.66in</PageWidth><PageHeight>11in</PageHeight><Left>0.59in</Left><Right>0in</Right><Top>0.5in</Top><Bottom>0.5in</Bottom></DeviceInfo>";
                //var lstReportName = (from child in lstReports
                //                     where !lstTemplateID.Contains(child.TemplateID.ToString())
                //                     group child by new { child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint }
                //                         into grp
                //                         select grp);
                var lstReportName = (from child in lstReports
                                     where !lstTemplateID.Contains(child.TemplateID.ToString())
                                     group child by new { child.TransVisitID, child.TransOrgID, child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint }
                                         into grp
                                         select grp);
                var GroupOrgIDs = string.Join(",", ((from r in lstReports
                                                     select r.TransOrgID.ToString()).Distinct()).ToArray());
                int ReportTemplateCount = lstReportName.Count();
                ReportParameter[] lstReportParameter;
                foreach (var objReportName in lstReportName)
                {
                    i = i + 1;
                    //if (i == ReportTemplateCount)
                    //{
                    //    IsEndOfReportTextVisible = "Y";
                    //    //N-->End Of Report Text will be show
                    //}
                    //else
                    //{
                    //    IsEndOfReportTextVisible = "N";
                    //    //Y-->End Of Report Text will not be show
                    //}
                    AccessionNo = string.Empty;
                    TemplateName = string.Empty;
                    ReportByteArr = new byte[byte.MaxValue];

                    TemplateName = objReportName.Key.ReportTemplateName;
                    StationaryID = objReportName.Key.StationaryID;
                    IsSeperatePrint = objReportName.Key.IsSeperatePrint;
                    /* For Org to Org Report Generation */
                    if (objReportName.Key.TransVisitID != 0)
                    {
                        VisitID = objReportName.Key.TransVisitID;
                    }
                    if (objReportName.Key.TransOrgID != 0)
                    {
                        OrgID = objReportName.Key.TransOrgID;
                    }
                    if (StationaryID == 0)
                    {
                        ShowReportHeader = "N";
                        ShowReportFooter = "N";
                    }
                    else
                    {
                        ShowReportHeader = "Y";
                        ShowReportFooter = "Y";
                    }
                    if (objReportName.Key.TemplateID != 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
                    {
                        TemplateName = objReportName.Key.ReportTemplateName;

                        //////AccessionNo = string.Join(",", ((from p in lstReports
                        //////                                 where p.TemplateID == objReportName.Key.TemplateID
                        //////                                 && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                        //////                                 select p.AccessionNumber.ToString()).Distinct()).ToArray());
                        //int  AccessionNocnnt = ((from p in lstReports
                        //                                   where p.IsPrintSeperate == 'Y' && 
                        //      select p.AccessionNumber.ToString().Split(',')).Count() );
                        
                         if (objReportName.Key.TemplateID != 0)
					    {
                        AccessionNo = string.Join(",", ((from p in lstReports
                                                         where p.TemplateID == objReportName.Key.TemplateID
                                                         && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                                                         && p.TransVisitID == objReportName.Key.TransVisitID
                                                         && p.TransOrgID == objReportName.Key.TransOrgID
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());
                        }
						else
						{
						AccessionNo = "0";
						}
                      
                        string[] SepAccessionNum;
                        if (IsSeperatePrint.Trim() == "Y")
                        {
                            SepAccessionNum = AccessionNo.Split(',');
                        }
                        else
                        {
                            SepAccessionNum = AccessionNo.Split('N');// N for No Split
                        }
                        int Acccnt = SepAccessionNum.Count();
                        int j = 0;
                        for (int s = 0; s < Acccnt; s++)
                        {
                            j = j + 1;
                            AccessionNo = SepAccessionNum[s].ToString();

                            if (i == ReportTemplateCount && j == Acccnt)
                            {
                                IsEndOfReportTextVisible = "Y";
                                //N-->End Of Report Text will be show
                            }
                            else
                            {
                                IsEndOfReportTextVisible = "N";
                                //Y-->End Of Report Text will not be show
                            }
                            if (ReportTemplateCount > 1 || Acccnt > 1)
                            {
                                lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "N", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest, ReportType);
                            }
                            else
                            {
                                lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "Y", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest, ReportType);
                            }
                            returnCode = this.RenderReport(lstReportParameter, OrgID, TemplateName, "PDF", deviceInfo, out ReportByteArr);
                            if (returnCode == 0 && ReportByteArr.Length > 255)
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
                    else if (objReportName.Key.TemplateID == 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
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
                    else if (objReportName.Key.ReportTemplateName == "PDF")
                    {
                        long[] lstInvestigationID = ((from p in lstReports
                                                      where p.TemplateID == objReportName.Key.TemplateID
                                                      select p.InvestigationID).Distinct()).ToArray();

                        Investigation_BL InvestigationBL = new Investigation_BL();
                        List<PatientInvestigationFiles> lstPDF = null;
                        string pdfPath = string.Empty;
                        string pdfFilePath = string.Empty;
                        foreach (long InvestigationID in lstInvestigationID)
                        {
                            lstPDF = new List<PatientInvestigationFiles>();
                            returnCode = InvestigationBL.ProbeImagesForPatientVisits(VisitID, InvestigationID, OrgID, out lstPDF);
                            if (returnCode == 0 && lstPDF.Count > 0)
                            {
                                foreach (PatientInvestigationFiles objPDF in lstPDF)
                                {
                                    pdfPath = GetConfigValues("TRF_UploadPath", OrgID);
                                    if (objPDF.ImageSource == null || objPDF.ImageSource.Length == 0)
                                    {
                                        pdfFilePath = pdfPath + objPDF.FilePath;
                                        byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                        lstSourceByte.Add(byteArray1);
                                    }
                                    else
                                    {
                                        byte[] imgbytearray = Encoding.UTF8.GetBytes(objPDF.ImageSource.ToString());
                                        lstSourceByte.Add(imgbytearray);
                                    }
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
                    // OutsourceFilesMerge | VEL |
                    else if (objReportName.Key.ReportTemplateName == "OUTSOURCE")
                    {
                        long[] AccessionNumber = ((from p in lstReports
                                                   where p.TemplateID == objReportName.Key.TemplateID
                                                   select p.AccessionNumber).Distinct()).ToArray();

                        Investigation_BL InvestigationBL = new Investigation_BL();
                        List<PatientInvestigationFiles> lstPDF = null;
                        string pdfPath = string.Empty;
                        string pdfFilePath = string.Empty;
                        foreach (long InvestigationID in AccessionNumber)
                        {
                            lstPDF = new List<PatientInvestigationFiles>();
                            returnCode = InvestigationBL.GetOutSourcePDFFileDetails(VisitID, InvestigationID, OrgID, out lstPDF);
                            if (returnCode == 0 && lstPDF.Count > 0)
                            {
                                foreach (PatientInvestigationFiles objPDF in lstPDF)
                                {
                                    if (Actiontype.ToUpper() == objPDF.Statustype.ToUpper())
                                 {
                                    if (objPDF.Statustype.ToUpper() == "PDF")
                                 {
                                    pdfPath = GetConfigValues("OutSourceReportspdffolderpath", OrgID);
                                 }
                                    if (objPDF.Statustype.ToUpper() == "ROUNDBPDF")
                                    {
                                        pdfPath = GetConfigValues("OutSourceReportRoundpdfprocessfolderpath", OrgID);
                                    }
                                    if (!string.IsNullOrEmpty(objPDF.FilePath))
                                    {
                                        pdfFilePath = pdfPath + objPDF.FilePath;
                                        byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                        lstSourceByte.Add(byteArray1);
                                        IsOutSourceTest = 1;
                                    }

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
                    }
                }
                if (lstSourceByte.Count > 0)
                {
                    String ShowSummaryReport = GetConfigValues("ShowSummaryReport", OrgID);

                    if (ShowSummaryReport == "Y")
                    {
                        Int32 RecordCount = 0;
                        bool ShowTRF = false;
                        byte[] trfImage = new byte[0];
                        List<InvReportMaster> lstInvReportMaster = new List<InvReportMaster>();
                        Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
                        objInvBL.CheckInvSummaryReport(OrgID, VisitID, out lstInvReportMaster, out RecordCount, out ShowTRF);
                        if (RecordCount > 0 && lstInvReportMaster.Count > 0)
                        {
                            InvReportMaster oSRInvReportMaster = lstInvReportMaster[0];
                            string InvIDs = string.Join(",", ((from r in lstReports
                                                               select r.InvestigationID.ToString()).Distinct()).ToArray());

                            lstReportParameter = this.GetInvestigationReportParameter(VisitID, oSRInvReportMaster.TemplateID, InvIDs, OrgID, "N", IsEndOfReportTextVisible, ShowReportHeader, ShowReportFooter, IsServiceRequest, ReportType);
                            returnCode = this.RenderReport(lstReportParameter, OrgID, oSRInvReportMaster.ReportTemplateName, "PDF", deviceInfo, out ReportByteArr);
                            if (returnCode == 0)
                            {
                                if (lstSourceByte.Count > 0)
                                {
                                    lstSourceByte.Insert(0, ReportByteArr);
                                }
                                else
                                {
                                    lstSourceByte.Add(ReportByteArr);
                                }
                                if (rsTemplateID.Length == 0)
                                {
                                    rsTemplateID.Append(oSRInvReportMaster.TemplateID);
                                }
                                else
                                {
                                    rsTemplateID.Append("," + oSRInvReportMaster.TemplateID);
                                }
                            }
                            if (ShowTRF)
                            {
                                List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
                                List<Patient> lstPatient = new List<Patient>();
                                Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
                                oPatient_BL.GetPatientDetailsPassingVisitID(VisitID, out lstPatient);
                                if (lstPatient.Count > 0)
                                {
                                    string Type = "";
                                    returnCode = oPatient_BL.GetTRFimageDetails(Convert.ToInt32(lstPatient[0].PatientID), Convert.ToInt32(VisitID), lstPatient[0].OrgID, Type, out lstTRF);
                                    if (lstTRF.Count > 0)
                                    {
                                        string pathName = GetConfigValues("TRF_UploadPath", OrgID);
                                        string PictureName = string.Empty;
                                        string fileExtension = string.Empty;
                                        string filePath = string.Empty;
                                        bool isImageAvailable = false;

                                        PdfPTable table = new PdfPTable(1);
                                        table.WidthPercentage = 100;
                                        table.DefaultCell.BorderWidth = 0;

                                        PdfPCell cell;
                                        foreach (TRFfilemanager objTRF in lstTRF)
                                        {
                                            PictureName = objTRF.FileUrl;
                                            fileExtension = Path.GetExtension(PictureName);
                                            filePath = pathName + PictureName;

                                            if (!String.IsNullOrEmpty(PictureName))
                                            {
                                                if (fileExtension.ToLower() != ".pdf")
                                                {
                                                    isImageAvailable = true;
                                                    Image img = Image.GetInstance(filePath);
                                                    cell = new PdfPCell();
                                                    cell.Image = img;
                                                    cell.BorderWidth = 0;
                                                    table.AddCell(cell);
                                                }
                                                else
                                                {
                                                    byte[] PDFByteArray = File.ReadAllBytes(filePath);

                                                    if (lstSourceByte.Count > 1)
                                                    {
                                                        lstSourceByte.Insert(1, PDFByteArray);
                                                    }
                                                    else
                                                    {
                                                        lstSourceByte.Add(PDFByteArray);
                                                    }
                                                }
                                            }
                                        }
                                        if (isImageAvailable)
                                        {
                                            Document doc = new Document(new Rectangle(612, 792));
                                            doc.SetMargins(50f, 50f, 80f, 80f);
                                            table.TotalWidth = doc.PageSize.Width - (doc.LeftMargin + doc.RightMargin);
                                            MemoryStream memoryStream = new MemoryStream();
                                            PdfWriter writer = PdfWriter.GetInstance(doc, memoryStream);
                                            doc.Open();
                                            doc.Add(table);
                                            writer.CloseStream = false;
                                            doc.Close();
                                            memoryStream.Position = 0;
                                            if (lstSourceByte.Count > 1)
                                            {
                                                lstSourceByte.Insert(1, memoryStream.ToArray());
                                            }
                                            else
                                            {
                                                lstSourceByte.Add(memoryStream.ToArray());
                                            }
                                            memoryStream.Dispose();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }
            if (Actiontype == "showpdf" || Actiontype == "prtpdf")
            {
                objReportSnapshot = new ReportSnapshot();
                objReportSnapshot.TemplateID = rsTemplateID.ToString();
                objReportSnapshot.Content = results;
                lstReportSnapshot.Add(objReportSnapshot);
                lstNewReportSnapshot.Add(objReportSnapshot);
            }
            else
            {
                byte[] destByte;
                 IsReprintNeeded = GetConfigValues("IsReprintNeeded",OrgID);
                 if (IsReprintNeeded == "Y")
                 {
                     Pat_BL.GetReprintRDLSize(OrgID, out lstRDLSise);

                    //Pati .GetPatientDetailsPassingVisitID(VisitID, out lstPatient);
                     if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                     {
                         destByte = Attune.PdfMerger.ReprintMergeFiles(lstSourceByte, isCustomPageNumberRequired, lstRDLSise[0].MoveX,lstRDLSise[0].MoveY,lstRDLSise[0].LineX,lstRDLSise[0].LineY,lstRDLSise[0].FontSize,"");
                     }
                     else
                     {
                         destByte = lstSourceByte[0];
                     }
                 }
                 else
                 {
                     if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                     {
                         destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, isCustomPageNumberRequired, OrgID);
                     }
                     else
                     {
                         destByte = lstSourceByte[0];
                     }
                 }
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
    public void GetReportSnapshotList(List<InvReportMaster> lstReports, Int64 VisitID, Int32 OrgID, string lstTemplateID, out List<ReportSnapshot> lstReportSnapshot, out List<ReportSnapshot> lstNewReportSnapshot, bool isCustomPageNumberRequired, string actType, string IsServiceRequest, string AccessionNum, string ReportType)
    {

        long OrginOrgVisitID = -1;
        int OrginOrgID = 0;
        OrginOrgID = OrgID;
        OrginOrgVisitID = VisitID;
        // List<InvReportMaster> lstReports;
        byte[] results = new byte[byte.MaxValue];
        long returnCode = -1;
        int i = 0;
        long StationaryID = 0;
        string IsSeperatePrint = string.Empty;
        string IsEndOfReportTextVisible = "N";
        string ShowReportHeader = string.Empty;
        string ShowReportFooter = string.Empty;
        ReportSnapshot objReportSnapshot;
        string AccessionNo, TemplateName, deviceInfo;
        lstReportSnapshot = new List<ReportSnapshot>();
        lstNewReportSnapshot = new List<ReportSnapshot>();
        List<byte[]> lstSourceByte = new List<byte[]>();
        StringBuilder rsTemplateID = new StringBuilder();
        NotesPatternReport objNotesReport = new NotesPatternReport();
        string Actiontype = actType;
        byte[] ReportByteArr;
        List<object> lstReportName1 = new List<object>();
        //List<InvReasonMasters> lstInvReasonMasters = new List<InvReasonMasters>();
        int IsOutSourceTest = 0;
        try
        {

            List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
            returnCode = objReportBL.GetPath(OrgID, VisitID, "", out ReportPath);
            // ReportPath.Count() > 0 ||
            if (Actiontype == "showpdf" || Actiontype == "prtpdf")
            {
                FileStream fs;
                if (ReportPath.Count() > 0)
                {
                    if (System.IO.File.Exists(ReportPath[0].ReportPath))
                    {
                        fs = new FileStream(ReportPath[0].ReportPath, FileMode.Open, FileAccess.Read);
                        results = new byte[fs.Length];
                        fs.Read(results, 0, System.Convert.ToInt32(fs.Length));
                        fs.Close();
                    }
                }

            }
            else
            {
                //  deviceInfo = "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>A4</PageSize><PageWidth>8.27in</PageWidth><PageHeight>11.69in</PageHeight></DeviceInfo>";
                deviceInfo = null;// "<DeviceInfo><OutputFormat>PDF</OutputFormat><PageSize>Custom</PageSize><PageWidth>8.66in</PageWidth><PageHeight>11in</PageHeight><Left>0.59in</Left><Right>0in</Right><Top>0.5in</Top><Bottom>0.5in</Bottom></DeviceInfo>";
                //var lstReportName = (from child in lstReports
                //                     where !lstTemplateID.Contains(child.TemplateID.ToString())
                //                     group child by new { child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint }
                //                         into grp
                //                         select grp);

                var lstReportName = (from child in lstReports
                                     where !lstTemplateID.Contains(child.TemplateID.ToString())
                                     group child by new { child.TransVisitID, child.TransOrgID, child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint, child.AccessionNumber }
                                         into grp
                                         select grp);

                //lstReportName1 = (from child in lstReports
                //                               where !lstTemplateID.Contains(child.TemplateID.ToString())
                //                               group child by new { child.TransVisitID, child.TransOrgID, child.TemplateID, child.ReportTemplateName, child.StationaryID, child.IsSeperatePrint, child.AccessionNumber }
                //                                   into grp
                //                                   select grp);

                
               
                var GroupOrgIDs = string.Join(",", ((from r in lstReports
                                                     select r.TransOrgID.ToString()).Distinct()).ToArray());
                string AllAccession = string.Empty;
                int ReportTemplateCount = lstReportName.Count();
                string[] AccCount = AccessionNum.Split(',');
                if (AccCount.Count()-1 == ReportTemplateCount)
                {
                    AllAccession = "All";
                }
                ReportParameter[] lstReportParameter;
                foreach (var objReportName in lstReportName)
                {
                    i = i + 1;
                    //if (i == ReportTemplateCount)
                    //{
                    //    IsEndOfReportTextVisible = "Y";
                    //    //N-->End Of Report Text will be show
                    //}
                    //else
                    //{
                    //    IsEndOfReportTextVisible = "N";
                    //    //Y-->End Of Report Text will not be show
                    //}
                    AccessionNo = string.Empty;
                    TemplateName = string.Empty;
                    ReportByteArr = new byte[byte.MaxValue];

                    TemplateName = objReportName.Key.ReportTemplateName;
                    StationaryID = objReportName.Key.StationaryID;
                    IsSeperatePrint = objReportName.Key.IsSeperatePrint;
                    /* For Org to Org Report Generation */
                    if (objReportName.Key.TransVisitID != 0)
                    {
                        VisitID = objReportName.Key.TransVisitID;
                    }
                    if (objReportName.Key.TransOrgID != 0)
                    {
                        OrgID = objReportName.Key.TransOrgID;
                    }
                    if (StationaryID == 0)
                    {
                        ShowReportHeader = "N";
                        ShowReportFooter = "N";
                    }
                    else
                    {
                        ShowReportHeader = "Y";
                        ShowReportFooter = "Y";
                    }
                    if (objReportName.Key.TemplateID != 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
                    {
                        TemplateName = objReportName.Key.ReportTemplateName;

                        //////AccessionNo = string.Join(",", ((from p in lstReports
                        //////                                 where p.TemplateID == objReportName.Key.TemplateID
                        //////                                 && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                        //////                                 select p.AccessionNumber.ToString()).Distinct()).ToArray());
                        //int  AccessionNocnnt = ((from p in lstReports
                        //                                   where p.IsPrintSeperate == 'Y' && 
                        //      select p.AccessionNumber.ToString().Split(',')).Count() );

                        if (objReportName.Key.TemplateID != 0)
                        {
                            if (AccessionNum == "" || AllAccession == "All")
                            {
                                AccessionNo = string.Join(",", ((from p in lstReports
                                                                 where p.TemplateID == objReportName.Key.TemplateID
                                                                 && p.ReportTemplateName.ToString().ToUpper() == objReportName.Key.ReportTemplateName.ToUpper().ToString()
                                                                 && p.TransVisitID == objReportName.Key.TransVisitID
                                                                 && p.TransOrgID == objReportName.Key.TransOrgID
                                                                 select p.AccessionNumber.ToString()).Distinct()).ToArray());
                            }
                            else
                            {
                                AccessionNo = AccessionNum;
                                string[] AcNo = AccessionNo.Split(',');
                                for (int ano = 0; ano < AcNo.Count(); ano++)
                                {
                                    long an = objReportName.Key.AccessionNumber;
                                    if (AcNo[ano] != an.ToString())
                                    {
                                        goto last;
                                    }
                                    goto nextlevel;
                                }
                            }
                        nextlevel:
                            {
                            }
                        }
                        else
                        {
                            AccessionNo = "0";
                        }

                        string[] SepAccessionNum;
                        if (IsSeperatePrint.Trim() == "Y")
                        {
                            SepAccessionNum = AccessionNo.Split(',');
                        }
                        else
                        {
                            SepAccessionNum = AccessionNo.Split('N');// N for No Split
                        }
                        int Acccnt = SepAccessionNum.Count();
                        int j = 0;
                        for (int s = 0; s < Acccnt; s++)
                        {
                            j = j + 1;
                            AccessionNo = SepAccessionNum[s].ToString();

                            if (i == ReportTemplateCount && j == Acccnt)
                            {
                                IsEndOfReportTextVisible = "Y";
                                //N-->End Of Report Text will be show
                            }
                            else
                            {
                                IsEndOfReportTextVisible = "N";
                                //Y-->End Of Report Text will not be show
                            }
                            if (ReportTemplateCount > 1 || Acccnt > 1)
                            {
                                lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "N", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest,ReportType);
                            }
                            else
                            {
                                lstReportParameter = this.GetInvestigationReportParameter(VisitID, objReportName.Key.TemplateID, AccessionNo, OrgID, "Y", ShowReportHeader, ShowReportFooter, IsEndOfReportTextVisible, IsServiceRequest, ReportType);
                            }
                            returnCode = this.RenderReport(lstReportParameter, OrgID, TemplateName, "PDF", deviceInfo, out ReportByteArr);
                            if (returnCode == 0 && ReportByteArr.Length > 255)
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
                    else if (objReportName.Key.TemplateID == 10 && objReportName.Key.ReportTemplateName != "PDF" && objReportName.Key.ReportTemplateName != "OUTSOURCE")
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
                    else if (objReportName.Key.ReportTemplateName == "PDF")
                    {
                        long[] lstInvestigationID = ((from p in lstReports
                                                      where p.TemplateID == objReportName.Key.TemplateID
                                                      select p.InvestigationID).Distinct()).ToArray();

                        Investigation_BL InvestigationBL = new Investigation_BL();
                        List<PatientInvestigationFiles> lstPDF = null;
                        string pdfPath = string.Empty;
                        string pdfFilePath = string.Empty;
                        foreach (long InvestigationID in lstInvestigationID)
                        {
                            lstPDF = new List<PatientInvestigationFiles>();
                            returnCode = InvestigationBL.ProbeImagesForPatientVisits(VisitID, InvestigationID, OrgID, out lstPDF);
                            if (returnCode == 0 && lstPDF.Count > 0)
                            {
                                foreach (PatientInvestigationFiles objPDF in lstPDF)
                                {
                                    pdfPath = GetConfigValues("TRF_UploadPath", OrgID);
                                    if (objPDF.ImageSource == null && objPDF.ImageSource.Length == 0)
                                    {
                                        pdfFilePath = pdfPath + objPDF.FilePath;
                                        byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                        lstSourceByte.Add(byteArray1);
                                    }
                                    else
                                    {
                                        byte[] imgbytearray = Encoding.UTF8.GetBytes(objPDF.ImageSource.ToString());
                                        lstSourceByte.Add(imgbytearray);
                                    }
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
                    // OutsourceFilesMerge | VEL |
                    else if (objReportName.Key.ReportTemplateName == "OUTSOURCE")
                    {
                        long[] AccessionNumber = ((from p in lstReports
                                                   where p.TemplateID == objReportName.Key.TemplateID
                                                   select p.AccessionNumber).Distinct()).ToArray();

                        Investigation_BL InvestigationBL = new Investigation_BL();
                        List<PatientInvestigationFiles> lstPDF = null;
                        string pdfPath = string.Empty;
                        string pdfFilePath = string.Empty;
                        foreach (long InvestigationID in AccessionNumber)
                        {
                            lstPDF = new List<PatientInvestigationFiles>();
                            returnCode = InvestigationBL.GetOutSourcePDFFileDetails(VisitID, InvestigationID, OrgID, out lstPDF);
                            if (returnCode == 0 && lstPDF.Count > 0)
                            {
                                foreach (PatientInvestigationFiles objPDF in lstPDF)
                                {
                                    if (Actiontype.ToUpper() == objPDF.Statustype.ToUpper())
                                    {
                                        if (objPDF.Statustype.ToUpper() == "PDF")
                                        {
                                            pdfPath = GetConfigValues("OutSourceReportspdffolderpath", OrgID);
                                        }
                                        if (objPDF.Statustype.ToUpper() == "ROUNDBPDF")
                                        {
                                            pdfPath = GetConfigValues("OutSourceReportRoundpdfprocessfolderpath", OrgID);
                                        }

                                  
                                    if (!string.IsNullOrEmpty(objPDF.FilePath))
                                    {
                                        pdfFilePath = pdfPath + objPDF.FilePath;
                                        byte[] byteArray1 = File.ReadAllBytes(pdfFilePath);

                                        lstSourceByte.Add(byteArray1);
                                        IsOutSourceTest = 1;
                                    }

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
                    }
                last:
                    {
                }
                }

                //change
                if (lstSourceByte.Count > 0)
                {
                    String ShowSummaryReport = GetConfigValues("ShowSummaryReport", OrgID);

                    if (ShowSummaryReport == "Y")
                    {
                        Int32 RecordCount = 0;
                        bool ShowTRF = false;
                        byte[] trfImage = new byte[0];
                        List<InvReportMaster> lstInvReportMaster = new List<InvReportMaster>();
                        Investigation_BL objInvBL = new Investigation_BL(new BaseClass().ContextInfo);
                        objInvBL.CheckInvSummaryReport(OrgID, VisitID, out lstInvReportMaster, out RecordCount, out ShowTRF);
                        if (RecordCount > 0 && lstInvReportMaster.Count > 0)
                        {
                            InvReportMaster oSRInvReportMaster = lstInvReportMaster[0];
                            string InvIDs = string.Join(",", ((from r in lstReports
                                                               select r.InvestigationID.ToString()).Distinct()).ToArray());

                            lstReportParameter = this.GetInvestigationReportParameter(VisitID, oSRInvReportMaster.TemplateID, InvIDs, OrgID, "N", IsEndOfReportTextVisible, ShowReportHeader, ShowReportFooter, IsServiceRequest,ReportType);
                            returnCode = this.RenderReport(lstReportParameter, OrgID, oSRInvReportMaster.ReportTemplateName, "PDF", deviceInfo, out ReportByteArr);
                            if (returnCode == 0)
                            {
                                if (lstSourceByte.Count > 0)
                                {
                                    lstSourceByte.Insert(0, ReportByteArr);
                                }
                                else
                                {
                                    lstSourceByte.Add(ReportByteArr);
                                }
                                if (rsTemplateID.Length == 0)
                                {
                                    rsTemplateID.Append(oSRInvReportMaster.TemplateID);
                                }
                                else
                                {
                                    rsTemplateID.Append("," + oSRInvReportMaster.TemplateID);
                                }
                            }
                            if (ShowTRF)
                            {
                                List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
                                List<Patient> lstPatient = new List<Patient>();
                                Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
                                oPatient_BL.GetPatientDetailsPassingVisitID(VisitID, out lstPatient);
                                if (lstPatient.Count > 0)
                                {
                                    string Type = "";
                                    returnCode = oPatient_BL.GetTRFimageDetails(Convert.ToInt32(lstPatient[0].PatientID), Convert.ToInt32(VisitID), lstPatient[0].OrgID, Type, out lstTRF);
                                    if (lstTRF.Count > 0)
                                    {
                                        string pathName = GetConfigValues("TRF_UploadPath", OrgID);
                                        string PictureName = string.Empty;
                                        string fileExtension = string.Empty;
                                        string filePath = string.Empty;
                                        bool isImageAvailable = false;

                                        PdfPTable table = new PdfPTable(1);
                                        table.WidthPercentage = 100;
                                        table.DefaultCell.BorderWidth = 0;

                                        PdfPCell cell;
                                        foreach (TRFfilemanager objTRF in lstTRF)
                                        {
                                            PictureName = objTRF.FileUrl;
                                            fileExtension = Path.GetExtension(PictureName);
                                            filePath = pathName + PictureName;

                                            if (!String.IsNullOrEmpty(PictureName))
                                            {
                                                if (fileExtension.ToLower() != ".pdf")
                                                {
                                                    isImageAvailable = true;
                                                    Image img = Image.GetInstance(filePath);
                                                    cell = new PdfPCell();
                                                    cell.Image = img;
                                                    cell.BorderWidth = 0;
                                                    table.AddCell(cell);
                                                }
                                                else
                                                {
                                                    byte[] PDFByteArray = File.ReadAllBytes(filePath);

                                                    if (lstSourceByte.Count > 1)
                                                    {
                                                        lstSourceByte.Insert(1, PDFByteArray);
                                                    }
                                                    else
                                                    {
                                                        lstSourceByte.Add(PDFByteArray);
                                                    }
                                                }
                                            }
                                        }
                                        if (isImageAvailable)
                                        {
                                            Document doc = new Document(new Rectangle(612, 792));
                                            doc.SetMargins(50f, 50f, 80f, 80f);
                                            table.TotalWidth = doc.PageSize.Width - (doc.LeftMargin + doc.RightMargin);
                                            MemoryStream memoryStream = new MemoryStream();
                                            PdfWriter writer = PdfWriter.GetInstance(doc, memoryStream);
                                            doc.Open();
                                            doc.Add(table);
                                            writer.CloseStream = false;
                                            doc.Close();
                                            memoryStream.Position = 0;
                                            if (lstSourceByte.Count > 1)
                                            {
                                                lstSourceByte.Insert(1, memoryStream.ToArray());
                                            }
                                            else
                                            {
                                                lstSourceByte.Add(memoryStream.ToArray());
                                            }
                                            memoryStream.Dispose();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }
            if (Actiontype == "showpdf" || Actiontype == "prtpdf")
            {
                objReportSnapshot = new ReportSnapshot();
                objReportSnapshot.TemplateID = rsTemplateID.ToString();
                objReportSnapshot.Content = results;
                lstReportSnapshot.Add(objReportSnapshot);
                lstNewReportSnapshot.Add(objReportSnapshot);
            }
            else
            {
                byte[] destByte;
                 IsReprintNeeded = GetConfigValues("IsReprintNeeded",OrgID);


                
                 if (IsReprintNeeded == "Y")
                 {
                     Pat_BL.GetReprintRDLSize(OrgID, out lstRDLSise);
                     if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                     {

                         destByte = Attune.PdfMerger.ReprintMergeFiles(lstSourceByte, isCustomPageNumberRequired,lstRDLSise[0].MoveX,lstRDLSise[0].MoveY,lstRDLSise[0].LineX,lstRDLSise[0].LineY,lstRDLSise[0].FontSize,"");
                     }
                     else
                     {
                         destByte = lstSourceByte[0];
                     }
                 }
                 else
                 {
                     if (lstSourceByte.Count > 1 || IsOutSourceTest == 1)
                     {

                         destByte = Attune.PdfMerger.MergeFiles(lstSourceByte, isCustomPageNumberRequired, OrgID);
                     }
                else
                     {
                         destByte = lstSourceByte[0];
                     }
                 }
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


    public List<InvReportMaster> GetReportList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, List<string> lstInvStatus,String actionType ,String ReportType,string Language)
    {
       // Patient_BL patientBL;
        List<InvDeptMaster> lstDpts;
        List<InvReportMaster> lstAllReport, lstReportName;
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        try
        {
            //patientBL = new Patient_BL(new BaseClass().ContextInfo);
            lstAllReport = new List<InvReportMaster>();
			List<InvReportMaster> lstApprovedInv = new List<InvReportMaster>();
            lstReportName = new List<InvReportMaster>();
            lstDpts = new List<InvDeptMaster>();
            Patient_BL patientBL = new Patient_BL(globalContextDetails);
            if (ReportType == "Cumulative")
            {
                globalContextDetails.AdditionalInfo = "Cumulative";
            }

            //Added By QBITZ Prakash.K
            globalContextDetails.DepartmentCode = ReportType;
			globalContextDetails.DepartmentName = actionType;

                patientBL.GetReportTemplate(VisitID, OrgID,Language, out lstAllReport, out lstReportName, out lstDpts);
            
            int TotalInvcnt = 0;
            int IsSelAuthCnt = 0;

            IsSelAuthCnt = (from grp in lstAllReport
                            where grp.IsActive == "Y" && grp.IsCopublish == "Y"
                            select grp.PkgId).Distinct().Count();

            if (IsServiceRqst == "Y" && IsSelAuthCnt == 0)
            {
                var Pkglst = (from grp in lstAllReport
                              where grp.PkgId > 0 && grp.IsCopublish == "Y"
                              select grp.PkgId).Distinct().ToList();
                foreach (var item in Pkglst)
                {
                    TotalInvcnt = (from grp in lstAllReport
                                   where grp.PkgId == item
                                   select grp).Count();
                    var lstApprovedpkgtemp = (from grp in lstAllReport
                                              where lstInvStatus.Contains(grp.Status) && grp.PkgId == item
                                              select grp).ToList();
                    if (TotalInvcnt == lstApprovedpkgtemp.Count)
                    {
                        foreach (var ApprovedInvtemp in lstApprovedpkgtemp)
                        {
                            lstApprovedInv.Add(ApprovedInvtemp);
                        }
                    }
                }
                var lstApprovedInvtemp = (from grp in lstAllReport
                                          where lstInvStatus.Contains(grp.Status) && grp.PkgId >= 0 && grp.IsCopublish != "Y"
                                          select grp).ToList();

                foreach (var ApprovedInvtemp in lstApprovedInvtemp)
                {
                    lstApprovedInv.Add(ApprovedInvtemp);
                }
                lstReports = lstApprovedInv;
            }
            else if (IsServiceRqst == "Y" && IsSelAuthCnt > 0)
            {
                //Only for Selective Auth Reports By Service with Non-Copublish
                    lstReports = (from child in lstAllReport
                                  where lstInvStatus.Contains(child.Status) && child.IsActive == "Y" 
                                  && child.IsCopublish == "Y" 
                                  select child).ToList(); 
            }

            else
            {
                if (lstInvStatus != null && lstInvStatus.Count > 0)
                {
                    lstReports = (from child in lstAllReport
                                  where lstInvStatus.Contains(child.Status)
                                  select child).ToList();
                }
                else
                {
                    lstReports = lstAllReport;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report List", ex);
        }
        return lstReports;
    }
    public List<InvReportMaster> GetConfidReportList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, List<string> lstInvStatus,string Language)
    {
        Patient_BL patientBL;
        List<InvDeptMaster> lstDpts;
        List<InvReportMaster> lstAllReport, lstReportName;
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        try
        {
            patientBL = new Patient_BL(new BaseClass().ContextInfo);
            lstAllReport = new List<InvReportMaster>();
            List<InvReportMaster> lstApprovedInv = new List<InvReportMaster>();
            lstReportName = new List<InvReportMaster>();
            lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(VisitID, OrgID,Language, out lstAllReport, out lstReportName, out lstDpts);

            int TotalInvcnt = 0;
            int IsSelAuthCnt = 0;

            IsSelAuthCnt = (from grp in lstAllReport
                            where grp.IsActive == "Y" && grp.IsCopublish == "Y" && grp.IsConfidentialTest !="Y"
                            select grp.PkgId).Distinct().Count();

            if (IsServiceRqst == "Y" && IsSelAuthCnt == 0)
            {
                //Only for Normal Approval Reports By Service with Copublish

                var Pkglst = (from grp in lstAllReport
                              where grp.PkgId > 0 && grp.IsCopublish == "Y"
                              select grp.PkgId).Distinct().ToList();
                foreach (var item in Pkglst)
                {
                    TotalInvcnt = (from grp in lstAllReport
                                   where grp.PkgId == item
                                   select grp).Count();
                    var lstApprovedpkgtemp = (from grp in lstAllReport
                                              where lstInvStatus.Contains(grp.Status) && grp.PkgId == item
                                              select grp).ToList();
                    if (TotalInvcnt == lstApprovedpkgtemp.Count)
                    {
                        foreach (var ApprovedInvtemp in lstApprovedpkgtemp)
                        {
                            if (ApprovedInvtemp.IsConfidentialTest  != "Y")
                            {
                                lstApprovedInv.Add(ApprovedInvtemp);
                            }
                        }
                    }
                }
                var lstApprovedInvtemp = (from grp in lstAllReport
                                          where lstInvStatus.Contains(grp.Status) && grp.PkgId >= 0 && grp.IsCopublish != "Y"
                                          && grp.IsConfidentialTest != "Y"
                                          select grp).ToList();

                foreach (var ApprovedInvtemp in lstApprovedInvtemp)
                {
                    lstApprovedInv.Add(ApprovedInvtemp);
                }
                lstReports = lstApprovedInv;
            }
            else if (IsServiceRqst == "Y" && IsSelAuthCnt > 0)
            {
                //Only for Selective Auth Reports By Service with Non-Copublish
                lstReports = (from child in lstAllReport
                              where lstInvStatus.Contains(child.Status) && child.IsActive == "Y"
                              && child.IsCopublish == "Y" && child.IsConfidentialTest != "Y"
                              select child).ToList();
            }

            else
            {
                //Except Service Call
                if (lstInvStatus != null && lstInvStatus.Count > 0)
                {
                    lstReports = (from child in lstAllReport
                                  where lstInvStatus.Contains(child.Status)
                                  select child).ToList();
                }
                else
                {
                    lstReports = lstAllReport;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report List", ex);
        }
        return lstReports;
    }
    public List<InvReportMaster> GetClientBlindChildList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, List<string> lstInvStatus,string Language)
    {
        Patient_BL patientBL;
        List<InvDeptMaster> lstDpts;
        List<InvReportMaster> lstAllReport, lstReportName;
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        try
        {
            patientBL = new Patient_BL(new BaseClass().ContextInfo);
            lstAllReport = new List<InvReportMaster>();
            List<InvReportMaster> lstApprovedInv = new List<InvReportMaster>();
            lstReportName = new List<InvReportMaster>();
            lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(VisitID, OrgID,Language, out lstAllReport, out lstReportName, out lstDpts);

            int TotalInvcnt = 0;
            int IsSelAuthCnt = 0;

            IsSelAuthCnt = (from grp in lstAllReport
                            where grp.IsActive == "Y" && grp.IsCopublish == "Y" && grp.IsConfidentialTest != "Y" &&
                            grp.IsBlindingClient.ToLower() != "both" && grp.IsBlindingClient.ToLower() != "bc"
                            select grp.PkgId).Distinct().Count();
            if (IsServiceRqst == "Y")
            {
                //Only for Normal Approval Reports By Service with Copublish

                var Pkglst = (from grp in lstAllReport
                              where grp.PkgId > 0 && grp.IsCopublish == "Y"
                              select grp.PkgId).Distinct().ToList();
                foreach (var item in Pkglst)
                {
                    TotalInvcnt = (from grp in lstAllReport
                                   where grp.PkgId == item
                                   select grp).Count();
                    var lstApprovedpkgtemp = (from grp in lstAllReport
                                              where lstInvStatus.Contains(grp.Status) && grp.PkgId == item
                                              select grp).ToList();
                    if (TotalInvcnt == lstApprovedpkgtemp.Count)
                    {
                        foreach (var ApprovedInvtemp in lstApprovedpkgtemp)
                        {
                            if (ApprovedInvtemp.IsConfidentialTest != "Y" && ApprovedInvtemp.IsBlindingClient.ToLower() != "both" && ApprovedInvtemp.IsBlindingClient.ToLower() != "bc")
                            {
                                lstApprovedInv.Add(ApprovedInvtemp);
                            }
                        }
                    }
                }
                var lstApprovedInvtemp = (from grp in lstAllReport
                                          where lstInvStatus.Contains(grp.Status) && grp.PkgId >= 0 && grp.IsCopublish != "Y" && grp.IsConfidentialTest != "Y" 
                                          && grp.IsBlindingClient.ToLower() != "both" && grp.IsBlindingClient.ToLower() != "bc"
                                          select grp).ToList();

                foreach (var ApprovedInvtemp in lstApprovedInvtemp)
                {
                    lstApprovedInv.Add(ApprovedInvtemp);
                }
                lstReports = lstApprovedInv;
            }
            else if (IsServiceRqst == "Y" && IsSelAuthCnt > 0)
            {
                //Only for Selective Auth Reports By Service with Non-Copublish
                lstReports = (from child in lstAllReport
                              where lstInvStatus.Contains(child.Status) && child.IsActive == "Y"
                              && child.IsCopublish == "Y" && child.IsConfidentialTest != "Y"
                              && child.IsBlindingClient.ToLower() != "both" && child.IsBlindingClient.ToLower() != "bc"
                              select child).ToList();
            }

            else
            {
                //Except Service Call
                if (lstInvStatus != null && lstInvStatus.Count > 0)
                {
                    lstReports = (from child in lstAllReport
                                  where lstInvStatus.Contains(child.Status)
                                  select child).ToList();
                }
                else
                {
                    lstReports = lstAllReport;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report List", ex);
        }
        return lstReports;
    }
    public List<InvReportMaster> GetClientBlindParentList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, List<string> lstInvStatus,string Language)
    {
        Patient_BL patientBL;
        List<InvDeptMaster> lstDpts;
        List<InvReportMaster> lstAllReport, lstReportName;
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        try
        {
            patientBL = new Patient_BL(new BaseClass().ContextInfo);
            lstAllReport = new List<InvReportMaster>();
            List<InvReportMaster> lstApprovedInv = new List<InvReportMaster>();
            lstReportName = new List<InvReportMaster>();
            lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(VisitID, OrgID,Language, out lstAllReport, out lstReportName, out lstDpts);

            int TotalInvcnt = 0;
            int IsSelAuthCnt = 0;

            IsSelAuthCnt = (from grp in lstAllReport
                            where grp.IsActive == "Y" && grp.IsCopublish == "Y" && grp.IsConfidentialTest != "Y" &&
                            grp.IsBlindingClient.ToLower() != "both" && grp.IsBlindingClient.ToLower() != "pc"
                            select grp.PkgId).Distinct().Count();

            if (IsServiceRqst == "Y" && IsSelAuthCnt == 0)
            {
                //Only for Normal Approval Reports By Service with Copublish

                var Pkglst = (from grp in lstAllReport
                              where grp.PkgId > 0 && grp.IsCopublish == "Y"
                              select grp.PkgId).Distinct().ToList();
                foreach (var item in Pkglst)
                {
                    TotalInvcnt = (from grp in lstAllReport
                                   where grp.PkgId == item
                                   select grp).Count();
                    var lstApprovedpkgtemp = (from grp in lstAllReport
                                              where lstInvStatus.Contains(grp.Status) && grp.PkgId == item
                                              select grp).ToList();
                    if (TotalInvcnt == lstApprovedpkgtemp.Count)
                    {
                        foreach (var ApprovedInvtemp in lstApprovedpkgtemp)
                        {
                            if (ApprovedInvtemp.IsConfidentialTest != "Y" && ApprovedInvtemp.IsBlindingClient.ToLower() != "both" 
                                && ApprovedInvtemp.IsBlindingClient.ToLower() != "pc")
                            {
                                lstApprovedInv.Add(ApprovedInvtemp);
                            }
                        }
                    }
                }
                var lstApprovedInvtemp = (from grp in lstAllReport
                                          where lstInvStatus.Contains(grp.Status) && grp.PkgId >= 0 && grp.IsCopublish != "Y"
                                          && grp.IsConfidentialTest != "Y" && grp.IsBlindingClient.ToLower() != "both" 
                                          && grp.IsBlindingClient.ToLower() != "pc"
                                          select grp).ToList();

                foreach (var ApprovedInvtemp in lstApprovedInvtemp)
                {
                    lstApprovedInv.Add(ApprovedInvtemp);
                }
                lstReports = lstApprovedInv;
            }
            else if (IsServiceRqst == "Y" && IsSelAuthCnt > 0)
            {
                //Only for Selective Auth Reports By Service with Non-Copublish
                lstReports = (from child in lstAllReport
                              where lstInvStatus.Contains(child.Status) && child.IsActive == "Y"
                              && child.IsCopublish == "Y" && child.IsConfidentialTest != "Y"
                              && child.IsBlindingClient.ToLower() != "both" && child.IsBlindingClient.ToLower() != "pc"
                              select child).ToList();
            }

            else
            {
                //Except Service Call
                if (lstInvStatus != null && lstInvStatus.Count > 0)
                {
                    lstReports = (from child in lstAllReport
                                  where lstInvStatus.Contains(child.Status)
                                  select child).ToList();
                }
                else
                {
                    lstReports = lstAllReport;
                }
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
            returnCode = objReportBL.GetReportSnapshot(OrgID, OrgAddressID, VisitID, UpdateStatus,"", out lstReportSnapshot);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting Report Snapshot", ex);
        }
        return lstReportSnapshot;
    }

    public long SaveReportSnapshot(Int32 OrgID, Int32 OrgAddressID, Int64 VisitID, Int64 CreatedBy, List<string> lstInvStatus, bool isCustomPageNumberRequired)
    {
        long returnCode = -1;
        List<InvReportMaster> lstReports;
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        List<ReportSnapshot> lstNewReportSnapshot = new List<ReportSnapshot>();
        try
        {
            lstReports = new List<InvReportMaster>();
            lstReports = this.GetReportList(VisitID, OrgID, OrgAddressID, lstInvStatus,"","","");
            this.GetReportSnapshotList(lstReports, VisitID, OrgID, string.Empty, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, "","","");
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
            DataRow dataRow;

            foreach (ReportSnapshot objReportSnapshot in lstReportSnapshot)
            {
                dataRow = dataTable.NewRow();
                dataRow["TemplateID"] = objReportSnapshot.TemplateID;
                dataRow["Content"] = objReportSnapshot.Content;
                dataRow["Status"] = ReportProcessStatus.Ready;

                dataTable.Rows.Add(dataRow);
            }
            DataTable dt = createDataTableForInvoiceDetails();
            if (dataTable.Rows.Count > 0)
            {
                String StoreReportSnapshot = GetConfigValues("StoreReportSnapshot", OrgID);
                if (StoreReportSnapshot == "Y")
                {
                    Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                    returnCode = objReportBL.SaveReportSnapshot(dataTable, dt, VisitID, OrgID, OrgAddressID, CreatedBy);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Report", ex);
        }
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
    public long GetPDFReports(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, string InvReportConfig, Int64 CreatedBy, List<InvReportMaster> lstInvIDs, string PrintConfig, out List<ReportSnapshot> lstReportSnapshot, bool isCustomPageNumberRequired)
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
            lstReports = this.GetPDFReportList(VisitID, OrgID, OrgAddressID, InvReportConfig, lstInvIDs);
            if (InvReportConfig.Trim() == "PrintReport")
            {
                lstExistReportSnapshot = this.GetReportSnapshot(OrgID, OrgAddressID, VisitID, false);

                lstTemplateID = string.Join(",", ((from rs in lstExistReportSnapshot
                                                   select rs.TemplateID.ToString()).Distinct()).ToArray());
            }
            this.GetReportSnapshotList(lstReports, VisitID, OrgID, lstTemplateID, out lstReportSnapshot, out lstNewReportSnapshot, isCustomPageNumberRequired, "","","");
            lstReportSnapshot = lstReportSnapshot.Union(lstExistReportSnapshot).ToList();
            if (InvReportConfig.Trim() == "PrintReport")
            {
                if (lstNewReportSnapshot.Count > 0)
                {
                    this.SavePDFReport(OrgID, OrgAddressID, VisitID, CreatedBy, lstNewReportSnapshot);
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
    public List<InvReportMaster> GetPDFReportList(Int64 VisitID, Int32 OrgID, Int32 OrgAddressID, string InvReportConfig, List<InvReportMaster> lstInvIDs)
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
    public void SavePDFReport(Int32 OrgID, Int32 OrgAddressID, Int64 VisitID, Int64 CreatedBy, List<ReportSnapshot> lstReportSnapshot)
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
                String StoreReportSnapshot = GetConfigValues("StoreReportSnapshot", OrgID);
                if (StoreReportSnapshot == "Y")
                {
                    Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
                    returnCode = objReportBL.SaveReportSnapshot(dataTable, dt, VisitID, OrgID, OrgAddressID, CreatedBy);
                }
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
    public long GenerateConsentForm(string reportPath, long visitID, int OrgID, string DeptName, out byte[] results)
    {
        long returnCode = -1;
        results = new byte[byte.MaxValue];
        try
        {
            //Added by Thamilselvan...for Full Bill
            string[] lstpath = reportPath.Split(':');
            string IsFullBill = string.Empty;
            if (lstpath != null)
            {
                if (lstpath.Length > 1)
                {
                    IsFullBill = reportPath.Split(':')[1].Length > 0 ? reportPath.Split(':')[1] : null;
                    reportPath = reportPath.Split(':')[0];
                }
                else
                {
                    reportPath = reportPath.Split(':')[0];
                }
            }

            string deviceInfo = null;
            string format = "PDF";
            string encoding = String.Empty;
            string mimeType = String.Empty;
            string extension = String.Empty;
            string[] streamIDs = null;
            Warning[] warnings;
            ReportViewer reportViewer;
            reportViewer = new ReportViewer();
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            reportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //strURL = "http://attune4-pc/ReportServer";
            strURL = GetConfigValues("ReportServerURL", Convert.ToInt32(OrgID));
            reportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            reportViewer.ServerReport.ReportPath = reportPath;
            reportViewer.ShowParameterPrompts = false;


            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[2];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("VisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            //reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("DeptName", DeptName);
            reportViewer.ServerReport.SetParameters(reportParameterList);

            results = reportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
        return returnCode;
    }
}
class CustomReportCredentials : IReportServerCredentials
{
    string userName = ConfigurationManager.AppSettings["ReportUserName"];
    string password = ConfigurationManager.AppSettings["ReportPassword"];

    public CustomReportCredentials()
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
            return new NetworkCredential(userName, password);
        }
    }

    public bool GetFormsCredentials(out Cookie authCookie, out string user, out string password, out string authority)
    {
        authCookie = null;
        user = password = authority = null;
        return false;  // Not use forms credentials to authenticate.
    }
}
