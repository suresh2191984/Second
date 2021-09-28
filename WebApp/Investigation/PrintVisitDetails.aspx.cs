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

public partial class Investigation_PrintVisitDetails : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            byte[] Buffer;
            MemoryStream memoryStream = new MemoryStream();
            if (!String.IsNullOrEmpty(Request.QueryString["vid"]))
            {
                long pVisitID = 0;
                long pRoleID = 0;
                int pDeptID = -1;
                string strReportType = string.Empty;
                string accessionnumber = string.Empty;
                string invStatus = string.Empty;
                string actionType = string.Empty;
                string deptFilter = string.Empty;
                string WSReport = string.Empty;
                List<string> lstInvStatus = new List<string>();
                Int64.TryParse(Request.QueryString["vid"], out pVisitID);
                Int64.TryParse(Request.QueryString["roleid"], out pRoleID);
                if(Request.QueryString["accessionnumber"]!=null)
                {
                    accessionnumber = Request.QueryString["accessionnumber"];
                    Session["ANO"] = accessionnumber;
                }
                if (Request.QueryString["WSReportNeed"] != null)
                {
                    WSReport = Request.QueryString["WSReportNeed"];
                    Session["WSReport"] = WSReport;
                }
                if (Request.QueryString["type"] != null)
                {
                    actionType = Request.QueryString["type"];
                }
                if (Request.QueryString["invstatus"] != null)
                {
                    invStatus = Request.QueryString["invstatus"];
                    Session["InvesStatus"] = invStatus;
                }
                if (Request.QueryString["DeptFilter"] != null)
                {
                    deptFilter = Request.QueryString["DeptFilter"];
                }
                if (String.IsNullOrEmpty(invStatus) || invStatus == "all")
                {
                    lstInvStatus = new List<string>();
                }
                else
                {
                    string[] lstStatus = invStatus.Split(',');
                    if (lstStatus != null && lstStatus.Length > 0)
                    {
                        foreach (string oInvStauts in lstStatus)
                        {
                            if (oInvStauts.ToLower() == "approve")
                            {
                                lstInvStatus.Add(InvStatus.Approved);
                            }
                            else if (oInvStauts.ToLower() == "completed")
                            {
                                lstInvStatus.Add(InvStatus.Completed);
                            }
                            else if (oInvStauts.ToLower() == "validate")
                            {
                                lstInvStatus.Add(InvStatus.Validate);
                            }
                            else if (oInvStauts.ToLower() == "pending")
                            {
                                lstInvStatus.Add(InvStatus.Pending);
                            }
                            else if (oInvStauts.ToLower() == "partiallyvalidated")
                            {
                                lstInvStatus.Add(InvStatus.PartiallyValidated);
                            }
                            else if (oInvStauts.ToLower() == "coauthorize")
                            {
                                lstInvStatus.Add(InvStatus.Coauthorize);
                            }
                            else if (oInvStauts.ToLower() == "partiallycompleted")
                            {
                                lstInvStatus.Add("PartiallyCompleted");
                            }
                        }
                    }
                }
                if (Request.QueryString["deptid"] != null)
                {
                    int.TryParse(Request.QueryString["deptid"], out pDeptID);
                }

                if (Request.QueryString["ReportType"] != null)
                {
                    strReportType = Request.QueryString["ReportType"];
                }


                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                ReportUtil objReportUtil = new ReportUtil(base.ContextInfo);
                if (Request.QueryString["PageValue"]!= null)
                {
                   ContextInfo.AdditionalInfo = Request.QueryString["PageValue"].ToString();
                }
                string Language = string.Empty;
                if (Request.QueryString["Language"] != null)
                {
                    Language = Request.QueryString["Language"].ToString();
                }
                if ((accessionnumber == "") || (accessionnumber == "0"))
                {
                    objReportUtil.GetReports(pVisitID, OrgID, pRoleID, ILocationID, lstInvStatus, LID, true, actionType, deptFilter, pDeptID, "N", "", "", out lstReportSnapshot, Language);
                    Session["AccNo"] = "";
                }
                else
                {
                    //Uncommented by Radha
                    Session["AccNo"] = accessionnumber;

                    objReportUtil.GetReports(pVisitID, OrgID, pRoleID, ILocationID, lstInvStatus, LID, true, actionType, deptFilter, pDeptID, "N", accessionnumber, strReportType, out lstReportSnapshot,Language);
                    Session["AccNo"] = accessionnumber;
                }
                if (lstReportSnapshot.Count > 0)
                {
                    //byte[] Buffer = lstReportSnapshot[0].Content;
                    //MemoryStream memoryStream = new MemoryStream();
                    //The above code  commented by arivalagan.k//


                    Buffer = lstReportSnapshot[0].Content;
                    memoryStream = new MemoryStream();
                    if (actionType == "showreport")
                    {
                        byte[] data = lstReportSnapshot[0].Content;
                        PdfReader reader = new PdfReader(data);
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
                    else
                    {
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
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", "alert('Unable to Show this Report!')", true);
                }
            }
            else
            {
                if (Session["PrintReport"] != null)
                {
                    Buffer = (byte[])Session["PrintReport"];
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
                Session.Remove("PrintReport");
            }
        }
        catch (Exception ex)
        {
            Session.Remove("PrintReport");
            CLogger.LogError("Error while loading report for print", ex);
        }
    }
}
