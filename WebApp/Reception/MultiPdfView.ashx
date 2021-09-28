<%@ WebHandler Language="C#" Class="MultiPdfView" %>

using System;
using System.Web;
using System.Web.UI;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Linq;
using System.Web.UI.WebControls;
using Attune.Podium.BillingEngine;

public class MultiPdfView : BasePage, IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
       
        
        
        try
            
        {

            if (context.Request.QueryString["PdfName"] != null)
            {


                string[] filename;
                string PDFNAme = context.Request.QueryString["PdfName"].ToString();
                filename = PDFNAme.Split('~');



                    byte[] mergedPdf = null;
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (Document document = new Document())
                        {
                            using (PdfCopy copy = new PdfCopy(document, ms))
                            {
                                document.Open();

                                for (int i = 0; i <= filename.Length - 1; ++i)
                                {
                                    if (filename[i] != "")
                                    {
                                        PdfReader reader = new PdfReader(filename[i]);

                                        int n = reader.NumberOfPages;
                                        for (int page = 0; page < n; )
                                        {
                                            copy.AddPage(copy.GetImportedPage(reader, ++page));
                                        }
                                    }
                                }
                            }
                        }
                        mergedPdf = ms.ToArray();
                    }

                    context.Response.Clear();
                    context.Response.ContentType = "application/pdf";
                    context.Response.BinaryWrite(mergedPdf);
                    context.Response.Flush();
                    context.Response.Close();
                    //context.Response.End();
                    context.Response.SuppressContent = true;
                
                    
            }
            else if (context.Request.QueryString["PrintBill"] == "Y")
            {
                long pVisitID = 0;//21021;
                long pfinalBillID = 0;// 21065; 
                int OrgID = 0;
                long OrgAddressID = 0;
                String actionType = string.Empty;
                Int64.TryParse(context.Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(context.Request.QueryString["finalBillID"], out pfinalBillID);
                Int32.TryParse(context.Request.QueryString["OrgID"], out OrgID);
                Int64.TryParse(context.Request.QueryString["LocationID"], out OrgAddressID);

                ReportUtil objReportUtil = new ReportUtil(base.ContextInfo);
                if (context.Request.QueryString["PageValue"] != null)
                {
                    ContextInfo.AdditionalInfo = context.Request.QueryString["PageValue"].ToString();
                }
                //Added by Thamilselvan.R for Checking the Action Type to print the SSRS Report....on 02 Feb 2015
                if (context.Request.QueryString["actionType"] != null)
                {
                    actionType = context.Request.QueryString["actionType"].ToString();
                }
                if (actionType == string.Empty)
                {
                    actionType = "DefaultPrint";
                }
                // objReportUtil.GetReports(pVisitID, Orgid, RoleID, LocationId, lstInvStatus, LID, true, actionType, deptFilter, pDeptID, "N", out lstReportSnapshot);
                string reportPath = "";
                long visitID = pVisitID;
                string PhysicianName = "1";
                long FinalBillID = pfinalBillID;
                string SplitStatus = String.Empty;
                long pOrgid = OrgID;
                long pLID = 331970;
                byte[] results;

                BillingEngine bill = new BillingEngine(base.ContextInfo);
                long ReportTemplateID = 0;
                string Type = "BillReceiptB2CHC";
                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                long returnCode = bill.GetInvoiceReportPath(OrgID, Type, FinalBillID, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                    //RefPhyName as ReportTemplateName
                }
                string isFullBill = string.Empty;//added by Thamilselvan
                if (context.Request.QueryString["isFullBill"] != null)//added by Thamilselvan
                {
                    isFullBill = Request.QueryString["isFullBill"].ToString();//added by Thamilselvan +":"+isFullBill
                }
                objReportUtil.GenerateBillReceiptByservice(reportPath + ":" + isFullBill, visitID, PhysicianName, FinalBillID, SplitStatus, pOrgid, OrgAddressID, pLID, out results);
                MemoryStream memoryStream = new MemoryStream();
                if (actionType == "DefaultPrint")
                {
                    context.Response.Clear();
                    context.Response.ContentType = "application/pdf";
                    context.Response.BinaryWrite(results);
                    context.Response.Flush();
                    context.Response.Close();
                    //context.Response.End();
                    context.Response.SuppressContent = true;
                }
                else if (actionType == "POPUP")
                {
                    //PdfReader reader = new PdfReader(results);
                    //PdfStamper stamper = new PdfStamper(reader, memoryStream);
                    //PdfWriter writer = stamper.Writer;
                    //PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                    //writer.AddJavaScript(jAction);
                    //stamper.Close();
                    //reader.Close();
                    byte[] Pdf = null;
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (Document document = new Document())
                        {
                            using (PdfCopy copy = new PdfCopy(document, ms))
                            {
                                document.Open();

                                PdfReader reader = new PdfReader(results);

                                int n = reader.NumberOfPages;
                                for (int page = 0; page < n; )
                                {
                                    copy.AddPage(copy.GetImportedPage(reader, ++page));
                                }

                            }
                        }
                        Pdf = ms.ToArray();
                    }
                    context.Response.Clear();
                    context.Response.ContentType = "application/pdf";
                    context.Response.BinaryWrite(Pdf);
                    context.Response.Flush();
                    context.Response.Close();
                    //context.Response.End();
                    context.Response.SuppressContent = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientRegistration: PatientImageHandler ", ex);
        }
    }

  
    
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}