using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Xml;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using iTextSharp.text.pdf;
using iTextSharp.text;
using Microsoft.Reporting.WebForms;
using PdfSharp.Pdf.Security;
using Attune.Podium.PerformingNextAction;



    public partial class Invoice_PrintInvoiceDetails : BasePage
    {
        ActionManager objActionManager ;
    protected void Page_Load(object sender, EventArgs e)
    {
        objActionManager = new ActionManager(base.ContextInfo);
    try
    {
    if (!String.IsNullOrEmpty(Request.QueryString["InvID"]) && !String.IsNullOrEmpty(Request.QueryString["reportPath"]))
    {
    long InvID = 0;
    long returnCode=-1;
    string reporthPath = string.Empty;
    Int64.TryParse(Request.QueryString["InvID"], out InvID);
    reporthPath = Request.QueryString["reportPath"].ToString();
    List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();

    ReportUtil objReportUtil = new ReportUtil();
    objReportUtil.GetInvoiceReports(InvID,reporthPath, OrgID, ILocationID,out lstReportSnapshot); 
    if (lstReportSnapshot.Count > 0)
    {
    byte[] Buffer = lstReportSnapshot[0].Content;
    MemoryStream sourceStream = null;
    MemoryStream targetStream = null;
    targetStream = new MemoryStream();
    GateWay gateWay = new GateWay(base.ContextInfo);
    List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
    returnCode = gateWay.GetCommunicationDetails(CommunicationType.Invoice, InvID, LocationName, out lstCommunicationDetails);
    if (lstCommunicationDetails.Count > 0 && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
    {
    sourceStream = new MemoryStream(Buffer);
    PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
    PdfSecuritySettings securitySettings = document.SecuritySettings;
    securitySettings.UserPassword = lstCommunicationDetails[0].DocPassword;
    securitySettings.OwnerPassword = lstCommunicationDetails[0].DocPassword;
    securitySettings.PermitAccessibilityExtractContent = false;
    securitySettings.PermitAnnotations = false;
    securitySettings.PermitAssembleDocument = false;
    securitySettings.PermitExtractContent = false;
    securitySettings.PermitFormsFill = false;
    securitySettings.PermitFullQualityPrint = true;
    securitySettings.PermitModifyDocument = false;
    securitySettings.PermitPrint = true;
    document.Save(targetStream, false);
    List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
    MailAttachment objMailAttachment = new MailAttachment();
    objMailAttachment.ContentStream = targetStream;
    objMailAttachment.FileName = "InvoiceReport_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
    lstMailAttachment.Add(objMailAttachment);
    MailConfig oMailConfig = new MailConfig();
    objActionManager.GetEMailConfig(OrgID, out oMailConfig);
    Communication.SendMail(lstCommunicationDetails[0].To,lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your One Time Password :"+lstCommunicationDetails[0].DocPassword+", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
    // Communication.SendMail("admin@attunelive.com", "", "premanand.m@attunelive.com", "", "Invoice", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + "Venkat" + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter '123' as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + "ATTUNE" + "<br/>" + "Guindy, Chennai" + "</strong></div></div>", OrgName, lstMailAttachment);
    }
    
    MemoryStream memoryStream = new MemoryStream();
    PdfReader reader = new PdfReader(Buffer);
    PdfStamper stamper = new PdfStamper(reader, memoryStream);
    PdfWriter writer = stamper.Writer;
    PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
    writer.AddJavaScript(jAction);
    stamper.Close();
    reader.Close();
    Response.Clear();
    Response.ContentType = "application/pdf";
    Response.Charset = "";
    Response.BinaryWrite(memoryStream.ToArray());
    Response.Flush();
    Response.End();
    memoryStream.Dispose();
    }
    else
    {
    ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", "alert('There is no approved Invoice for this Client to print')", true);
    }
    // SendInvoiceEMail();
    }
    }
    catch (Exception ex)
    {
    CLogger.LogError("Error while loading report for print", ex);
    }


    }


    }
