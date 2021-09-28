using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security; 
using Attune.Utilitie.Helper; 
using System.Web.Script.Serialization;
using ReportingService; 
using Microsoft.Reporting.WebForms;
using Attune.Podium.PerformingNextAction; 
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class ClinicalTrial_ProblemDataForm : BasePage
{
    ClinicalTrail_BL CT_BL ;
    List<Patient> lstPatient;
    BillingEngine bill  ;
    ActionManager ObjActionManager ;
    protected void Page_Load(object sender, EventArgs e)
    {
          bill = new BillingEngine(base.ContextInfo);
          ObjActionManager = new ActionManager(base.ContextInfo);
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("d");
            txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("d");
        }
        
    }
    public void HTMLToPdf(string HTML, string FilePath)
    {
        HTML = "<?xml version='1.0' encoding='UTF-8' ?><!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN'><html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'><head><title></title></head><body>" + HTML + "</body></html>";
        byte[] output = new byte[byte.MaxValue];
        Document document = new Document(PageSize.A4);
        MemoryStream memoryStream = new MemoryStream();
        PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
        document.Open();

        List<IElement> parsedHtmlElements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(HTML), null);

        foreach (IElement htmlElement in parsedHtmlElements)
        {
            document.Add(htmlElement);
        }
        writer.CloseStream = false;
        document.Close();
        memoryStream.Position = 0;

        output = memoryStream.ToArray();
        memoryStream.Dispose();

        Response.Clear();
        Response.ClearContent();
        Response.ClearHeaders();
        Response.AppendHeader("Content-Disposition", "attachment; filename=testdoc.pdf");
        Response.ContentType = "application/pdf";
        Response.BinaryWrite(output);
        Response.Flush();
        Response.End();
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
    protected void btnExportPDF_Click(object sender, EventArgs e)
    {
        try
        {
            HTMLToPdf(fckProblemDataForm.Value, "TestPdf.pdf");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error ", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        lstPatient = new List<Patient>();
        DateTime FromDate = txtFromDate.Text == string.Empty ? Convert.ToDateTime(new BasePage().OrgDateTimeZone) : Convert.ToDateTime(txtFromDate.Text);
        DateTime ToDate = txtToDate.Text == string.Empty ? Convert.ToDateTime(new BasePage().OrgDateTimeZone) : Convert.ToDateTime(txtToDate.Text);
        string pType = rdPDF.Checked ? "PDF" : "PSF";
        string IsDispatch = chkDispatch.Checked ? "Y" : "N";// string.Empty;
        returnCode = CT_BL.GetProblemDataForm(FromDate, ToDate, OrgID, ILocationID, pType,IsDispatch, out lstPatient);
        grdProblemDataForm.DataSource = lstPatient;
        grdProblemDataForm.DataBind();
        int ResultID = -1;
        string ResultName = string.Empty;
        Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
        ResultID = 1;
        List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
        ResultID = 1;
        inv_BL.GetInvestigationResultTemplateByID(99, 8343, ResultName, "TextReport", out lResultTemplate);
        string st = fckProblemDataForm.Value;
        HideData();
    }
    public void HideData()
    {
        pnlPDF.Style.Add("display", "none");
        tblProblemDataForm.Style.Add("display", "none");
        pnlTask.Style.Add("display", "none"); 
        pnlPSF.Style.Add("display", "none");
        tblReportViewer.Style.Add("display", "none");
    }

    protected void grdProblemDataForm_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        long returnCode = -1;
        string reportPath = string.Empty;
        try
        {
            if (e.CommandName == "ShowReport")
            {
                string[] lstCommandArgument = e.CommandArgument.ToString().Split('^'); 
                txtMailAddress.Text = lstCommandArgument[5];
                string Ptype = string.Empty;
                Ptype = lstCommandArgument[6];
                long pVisitID = 0;
                Int64.TryParse(lstCommandArgument[0], out pVisitID);
                hdnMailType.Value = Ptype;
                if (Ptype == "PSF")
                {
                    pnlPDF.Style.Add("display", "none");
                    tblProblemDataForm.Style.Add("display", "none");
                    List<BillingDetails> lstReportPath = new List<BillingDetails>();
                    returnCode = bill.GetInvoiceReportPath(OrgID, "PSF", 0,0, out lstReportPath);
                    if (lstReportPath.Count > 0)
                    {
                        reportPath = lstReportPath[0].RefPhyName.ToString();
                    }
                    
                    ShowReport(reportPath, pVisitID, OrgID);
                    pnlPSF.Style.Add("display", "block");
                    tblReportViewer.Style.Add("display", "block");
                    pnlTask.Style.Add("display", "block");

                    pnlPDF.Style.Add("display", "none");
                    tblProblemDataForm.Style.Add("display", "none");
                    
                    //ScriptManager.RegisterStartupScript(Page, GetType(), "Get", "javascript:GetSpecialRated(" + ID + ")", true);
                }
                else if (Ptype == "PDF")
                {
                    pnlPSF.Style.Add("display", "none");
                    tblReportViewer.Style.Add("display", "none");
                    List<AddressDetails> lstAddress = new List<AddressDetails>();
                    List<EpisodeVisitDetails> lstPatientDetails = new List<EpisodeVisitDetails>();
                    returnCode = CT_BL.GetProblemDataFormContactDetails(pVisitID, OrgID, out lstAddress);
                    returnCode = CT_BL.GetProblemDataFormSampleDetails(pVisitID, OrgID, out lstPatientDetails);
                    if (lstAddress.Count > 0 && lstPatientDetails.Count > 0)
                    {
                        LoadFCKEditor(lstAddress, lstPatientDetails);
                        pnlPDF.Style.Add("display", "block");
                        tblProblemDataForm.Style.Add("display", "block");
                        pnlTask.Style.Add("display", "block");

                        pnlPSF.Style.Add("display", "none");
                        tblReportViewer.Style.Add("display", "none");
                         
 
                    }
                
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading grdProblemDataForm()", ex);
        }
    }
    public void LoadFCKEditor(List<AddressDetails> lstAddress, List<EpisodeVisitDetails> lstPatientDetails)
    {

        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");
        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath;
        sPath = sPath + "/fckeditor/";
        fckProblemDataForm.BasePath = sPath;
        fckProblemDataForm.ToolbarSet = "Attune";
        fckProblemDataForm.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        fckProblemDataForm.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        string Format = "<p><font size=\"4\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Problem Data Form</font></p>\r\n<p><font size=\"4\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date:&lt;Date1&gt;<br />\r\n<br />\r\nTo,<br />\r\n&lt;ToName&gt;,<br />\r\n&lt;ToAddress1&gt;,<br />\r\n&lt;ToAddress2&gt;,<br />\r\n&lt;ToAddress3&gt;.</font></p>\r\n<p><font size=\"4\">Dear,&lt;ToName&gt;, </font></p>\r\n<p><font size=\"4\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Specimens with below details have been received from your site.<br />\r\n&nbsp; Ref: Patient Initials&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&lt;SubjectInitial&gt;<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; Subject ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; :&lt;SubjectID&gt;<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type of Visit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; :&lt;Type of Visit&gt;<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Collection date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&lt;Collection date&gt;<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Collection time&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&lt;Collection time&gt;<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; Study Protocol&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&lt;Study Protocol&gt; </font></p>\r\n<p><font size=\"4\">Please note that the below specified mandatory PATIENT DATA has not been provided so kindly provide the below specified data to us at the earliest by Fax / Telephone or e-Mail</font></p>\r\n<p><font size=\"4\">Patient Initials&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (&nbsp; )<br />\r\nScreening Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (&nbsp; )<br />\r\nRandomization No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (&nbsp; )<br />\r\nGender&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(&nbsp; )<br />\r\nDate of Birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (&nbsp; )<br />\r\nCollection Date / Time&nbsp;(&nbsp; )<br />\r\nType of Visit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(&nbsp; )<br />\r\nTest Requisition Form&nbsp; (&nbsp; )<br />\r\nOthers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(&nbsp; )<br />\r\n<br />\r\nThanking you,</font></p>\r\n<p><br />\r\n<font size=\"4\">Yours sincerely</font></p>";
        string NewFormat = Format.Replace("&lt;ToName&gt;", lstAddress[0].Name);
        NewFormat = NewFormat.Replace("&lt;ToAddress1&gt;", lstAddress[0].Address1);
        NewFormat = NewFormat.Replace("&lt;ToAddress2&gt;", lstAddress[0].City);
        NewFormat = NewFormat.Replace("&lt;ToAddress3&gt;", lstAddress[0].Phone); 
        NewFormat = NewFormat.Replace("&lt;SubjectInitial&gt;", lstPatientDetails[0].PatientName);
        NewFormat = NewFormat.Replace("&lt;SubjectID&gt;", lstPatientDetails[0].URNO);
        NewFormat = NewFormat.Replace("&lt;Type of Visit&gt;", lstPatientDetails[0].DisplayText);
        //NewFormat = NewFormat.Replace("&lt;Collection date&gt;", lstPatientDetails[0].CreatedAt.ToString());
        //NewFormat = NewFormat.Replace("&lt;Collection time&gt;", lstPatientDetails[0].CreatedAt.ToString());
        NewFormat = NewFormat.Replace("&lt;Collection date&gt;", lstPatientDetails[0].CreatedAt.ToString("d"));
        NewFormat = NewFormat.Replace("&lt;Collection time&gt;", lstPatientDetails[0].CreatedAt.ToString("t"));

        NewFormat = NewFormat.Replace("&lt;Study Protocol&gt;", lstPatientDetails[0].EpisodeName);
        NewFormat = NewFormat.Replace("&lt;Date1&gt;", String.Format("{0:ddMMMyyyy}", lstPatientDetails[0].PrintedDate.ToString("d")));
        NewFormat = NewFormat.Replace("&lt;Date2&gt;", String.Format("{0:ddMMMyyyy}", lstPatientDetails[0].PrintedDate.ToString("d")));
    

        fckProblemDataForm.Value = NewFormat;
    }
    public void ShowReport(string reportPath, long pVisitID, long Orgid)
    {
        try
        {
            //hdnShowReport.Value = "true";
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent(); 
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[3];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(pVisitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(Orgid));  
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);

            rReportViewer.ServerReport.SetParameters(reportParameterList);
            //hdnInvID.Value = Convert.ToString(InvID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        GateWay gateWay = new GateWay(base.ContextInfo); 
        MemoryStream targetStream = null; 
        byte[] results = new byte[byte.MaxValue];
        string Type = hdnMailType.Value;
       
        try
        {
            if (Type == "PSF")
            {
                string deviceInfo = null;
                string format = "PDF";
                string encoding = String.Empty;
                string mimeType = String.Empty;
                string extension = String.Empty;
                string[] streamIDs = null;
                Microsoft.Reporting.WebForms.Warning[] warnings = null;
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                targetStream = new MemoryStream(results);
                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "ProblemSpecimenForm_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                string PatientName = string.Empty;
                MailConfig oMailConfig = new MailConfig();
                ObjActionManager.GetEMailConfig(OrgID, out oMailConfig);
                returnCode = Communication.SendMail(txtMailAddress.Text, string.Empty, string.Empty, "ProblemDataForm", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + PatientName + ",</p><p>Your problem data form e-report is now being sent to you as a pdf document.</p><div><br><br>Sincerely,<br><strong><br>" + OrgName + "<br/>" + OrgName + "</strong></div></div>", lstMailAttachment, oMailConfig);
                if (returnCode == 0)
                {
                    pnlPSF.Style.Add("display", "none");
                    tblReportViewer.Style.Add("display", "none");
                    pnlTask.Style.Add("display", "none"); 
                    btnSearch_Click(sender, e);
                    txtMailAddress.Text = string.Empty;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ProblemDataForm", "alert('ProblemDataForm dispatched successfully')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Unable to dispatch the report. please contact system administrator')", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ProblemDataForm", "javascript:CloseReportViewer();", true);
                }
            }
            else if (Type == "PDF")
            {
                string deviceInfo = null;
                string format = "PDF";
                string encoding = String.Empty;
                string mimeType = String.Empty;
                string extension = String.Empty;
                string[] streamIDs = null;
                byte[] outputValue = new byte[byte.MaxValue];
                string FileName = "ProblemDateForm_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                FCKToPdf(fckProblemDataForm.Value, FileName, out outputValue);

                targetStream = new MemoryStream(outputValue);
                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = FileName;// "ProblemDateForm_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                string PatientName = string.Empty;
                MailConfig oMailConfig = new MailConfig();
                ObjActionManager.GetEMailConfig(OrgID, out oMailConfig);
                returnCode = Communication.SendMail(txtMailAddress.Text, string.Empty, string.Empty, "ProblemDataForm", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + PatientName + ",</p><p>Your problem data form e-report is now being sent to you as a pdf document.</p><div><br><br>Sincerely,<br><strong><br>" + OrgName + "<br/>" + OrgName + "</strong></div></div>", lstMailAttachment, oMailConfig);
                if (returnCode == 0)
                {
                    pnlPDF.Style.Add("display", "none");
                    tblProblemDataForm.Style.Add("display", "none");
                    pnlTask.Style.Add("display", "none");                    
                    btnSearch_Click(sender, e);
                    txtMailAddress.Text = string.Empty;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ProblemDataForm", "alert('ProblemDataForm dispatched successfully')", true);
                }
                else
                {
                    pnlPDF.Style.Add("display", "none");
                    tblProblemDataForm.Style.Add("display", "none");
                    pnlTask.Style.Add("display", "none");    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Unable to dispatch the report. please contact system administrator')", true);
                   // ScriptManager.RegisterStartupScript(this, this.GetType(), "ProblemDataForm", "javascript:CloseReportViewer();", true);
                }
            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.Status = "Error while sending mail" + ex.Message;
        }
        finally
        {
            if (targetStream != null)
                targetStream.Dispose(); 
        }
    }

    public void FCKToPdf(string HTML, string FilePath, out  byte[] outputValue)
    {
        HTML = "<?xml version='1.0' encoding='UTF-8' ?><!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN'><html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'><head><title></title></head><body>" + HTML + "</body></html>";
        byte[] output = new byte[byte.MaxValue];
        Document document = new Document(PageSize.A4);
        MemoryStream memoryStream = new MemoryStream();
        PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
        document.Open();

        List<IElement> parsedHtmlElements = iTextSharp.text.html.simpleparser.HTMLWorker.ParseToList(new StringReader(HTML), null);

        foreach (IElement htmlElement in parsedHtmlElements)
        {
            document.Add(htmlElement);
        }
        writer.CloseStream = false;
        document.Close();
        memoryStream.Position = 0;

        output = memoryStream.ToArray();
        memoryStream.Dispose();

        //Response.Clear();
        //Response.ClearContent();
        //Response.ClearHeaders();
        //Response.AppendHeader("Content-Disposition", "attachment; filename=testdoc.pdf");
        //Response.ContentType = "application/pdf";
        //Response.BinaryWrite(output);
        //Response.Flush();
        //Response.End();
        outputValue = output;
         
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
}