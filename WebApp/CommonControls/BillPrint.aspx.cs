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
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //if (!String.IsNullOrEmpty(Request.QueryString["vid"]))
            {
                long pVisitID = 0;//21021;
                long pfinalBillID = 0;// 21065; 
                
                String actionType = string.Empty;
                
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["finalBillID"], out pfinalBillID);
                
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
                byte[] results;

                BillingEngine bill = new BillingEngine(base.ContextInfo);
                 
                long ReportTemplateID = 0;
                string Type = "BillReceipt";
                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                long returnCode = bill.GetInvoiceReportPath(OrgID, Type, FinalBillID, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                    //RefPhyName as ReportTemplateName
                }


                objReportUtil.GenerateBillReceiptByservice(reportPath, visitID, PhysicianName, FinalBillID, SplitStatus, pOrgid, OrgAddressID, pLID, out results);
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
