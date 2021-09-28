using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Attune.Podium.BusinessEntities;
using iTextSharp.text.pdf;
using iTextSharp.text;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Investigation_BillPrint : BasePage
{
    public Investigation_BillPrint()
        : base("Investigation_BillPrint_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //if (!String.IsNullOrEmpty(Request.QueryString["vid"]))
            {
                long pVisitID = 0;//21021;
                long pfinalBillID = 0;// 21065; 
                int pclientID = 0;
                string preferenceType = string.Empty;
                
                String actionType = string.Empty;
                
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["finalBillID"], out pfinalBillID);
                Int32.TryParse(Request.QueryString["clientID"], out pclientID);
                if (Request.QueryString["referenceType"] != null)
                {
                    preferenceType= Request.QueryString["referenceType"].ToString();
                }
                ReportUtil objReportUtil = new ReportUtil(base.ContextInfo);

                

                if (Request.QueryString["PageValue"] != null)
                {
                    ContextInfo.AdditionalInfo = Request.QueryString["PageValue"].ToString();
                }
                //Added by Thamilselvan.R for Checking the Action Type to print the SSRS Report....on 02 Feb 2015
                if (Request.QueryString["actionType"] != null)
                {
                    actionType = Request.QueryString["actionType"].ToString();
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
                long OrgAddressID = ILocationID;
                long pLID = LID;
                byte[] results = new byte[byte.MaxValue];
                long Clientid = pclientID;
                string formtype=string.Empty;
                string DeptName = string.Empty;

                BillingEngine bill = new BillingEngine(base.ContextInfo);
                 
                long ReportTemplateID = 0;
                string Type = string.Empty;
                if (preferenceType == "Y")
                {
                    Type = "BilClientB2CHC";
                }
                //else if (preferenceType == "S")
                //{
                //    Type = "BillClientwise";
                //}
                else
                {
                    Type = "BillReceiptB2CHC";
                }
                if (Request.QueryString["formtype"] != null)
                {
                    formtype = Request.QueryString["formtype"].ToString();
                }
                if (!String.IsNullOrEmpty(formtype) && formtype.ToLower().Contains("consent"))
                {
                    Type = formtype;
                }
                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                long returnCode = bill.GetInvoiceReportPath(OrgID, Type, FinalBillID, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                    //RefPhyName as ReportTemplateName
                }
               
                if (Request.QueryString["DeptName"] != null)
                {
                    DeptName = Request.QueryString["DeptName"].ToString();
                }
                string isFullBill = string.Empty;//added by Thamilselvan
                if (Request.QueryString["isFullBill"] != null)//added by Thamilselvan
                {
                    isFullBill = Request.QueryString["isFullBill"].ToString();//added by Thamilselvan +":"+isFullBill
                }
               /* if(!String.IsNullOrEmpty(formtype) && formtype.ToLower().Contains("consent"))
                {
                  objReportUtil.GenerateConsentForm(reportPath,visitID,OrgID,DeptName,out results);
                }
                if (String.IsNullOrEmpty(formtype))
                {*/
                    objReportUtil.GenerateBillReceiptByservice(reportPath + ":" + isFullBill, visitID, PhysicianName, FinalBillID, SplitStatus, pOrgid, OrgAddressID, pLID, out results);
               // }
                MemoryStream memoryStream = new MemoryStream();

                if (actionType == "DefaultPrint")
                {
                    PdfReader reader = new PdfReader(results);
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
                else if (actionType == "POPUP")
                { 
                    PdfReader reader = new PdfReader(results);
                    PdfStamper stamper = new PdfStamper(reader, memoryStream);
                    PdfWriter writer = stamper.Writer;
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
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading report for print", ex);
        }
    }
}
