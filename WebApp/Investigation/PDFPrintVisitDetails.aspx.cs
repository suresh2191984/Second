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

public partial class Investigation_PDFPrintVisitDetails : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!String.IsNullOrEmpty(Request.QueryString["vid"]))
            {
                string PDFConfigVal = Request.QueryString["PDFConfigVal"];
                string strInvStatus = InvStatus.Approved;
                long pVisitID = 0;
                long pRoleID = 0;
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["roleid"], out pRoleID);
                string InvReportConfig = Request.QueryString["ReportConfig"];
                string PrintConfig = Request.QueryString["PrintConfig"];
                string InvIDs = Request.QueryString["InvIDs"];
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(strInvStatus);
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                ReportUtil objReportUtil = new ReportUtil();
                List<InvReportMaster> lstInvIDs = new List<InvReportMaster>();
                if (InvIDs != null)
                {
                    foreach (var item in InvIDs.Split('^'))
                    {
                        if (item != "")
                        {
                            InvReportMaster invObj = new InvReportMaster();
                            invObj.InvestigationID = Convert.ToInt64(item.Split('~')[0]);
                            invObj.AccessionNumber = Convert.ToInt64(item.Split('~')[1]);
                            invObj.Status = item.Split('~')[2];
                            lstInvIDs.Add(invObj);
                        }
                    }
                }
                if (PDFConfigVal == "Y")
                {
                    objReportUtil.GetPDFReports(pVisitID, OrgID, ILocationID, InvReportConfig, LID, lstInvIDs, PrintConfig, out lstReportSnapshot, true);

                    if (InvReportConfig.Trim() == "PrintReport")
                    {
                        if (lstReportSnapshot.Count > 0)
                        {
                            byte[] Buffer = lstReportSnapshot[0].Content;
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
                            Response.BinaryWrite(Buffer);
                            Response.BinaryWrite(memoryStream.ToArray());
                            Response.Flush();
                            Response.End();
                            memoryStream.Dispose();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", "alert('There is no approved investigation for this patient to print')", true);
                        }
                    }
                    else if (InvReportConfig.Trim() == "ShowReport")
                    {
                        if (lstReportSnapshot.Count > 0)
                        {
                            byte[] Buffer = lstReportSnapshot[0].Content;
                            MemoryStream memoryStream = new MemoryStream();
                            PdfReader reader = new PdfReader(Buffer);
                            PdfStamper stamper = new PdfStamper(reader, memoryStream);
                            if (PrintConfig.Trim() == "YES")
                            {
                                PdfWriter writer = stamper.Writer;
                                PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                                writer.AddJavaScript(jAction);
                                int listCount = lstReportSnapshot.Count;

                                objReportUtil.SavePrintedReport(OrgID, pRoleID, ILocationID, pVisitID, LID, lstInvIDs);

                            }
                            else
                            {
                                System.Text.UTF8Encoding Encoding = new System.Text.UTF8Encoding();
                                stamper.SetEncryption(null, Encoding.GetBytes("12345678"), PdfWriter.AllowScreenReaders, PdfWriter.STRENGTH40BITS);
                            }
                            stamper.Close();
                            reader.Close();

                            Response.Clear();
                            Response.ContentType = "application/pdf";
                            Response.Charset = "";
                            Response.BinaryWrite(Buffer);
                            Response.BinaryWrite(memoryStream.ToArray());
                            Response.Flush();
                            Response.End();
                            memoryStream.Dispose();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", "alert('There is no investigation for this patient to print')", true);
                        }
                    }
                }
                else
                {
                    objReportUtil.GetReports(pVisitID, OrgID, pRoleID, ILocationID, lstInvStatus, LID, true, InvReportConfig,"",-1,"","", out lstReportSnapshot,LanguageCode);
                    if (lstReportSnapshot.Count > 0)
                    {
                        byte[] Buffer = lstReportSnapshot[0].Content;
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", "alert('There is no approved investigation for this patient to print')", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading report for print", ex);
        }
    }
}
