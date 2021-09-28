using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using Attune.Podium.PerformingNextAction;

public partial class Investigation_InvReportsForDept : BasePage
{
    public Investigation_InvReportsForDept()
        : base("Investigation_InvReportsForDept_aspx")
    {
    }

    int deptID = -1;
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long patientVisitID = 0;
    string reportID = string.Empty;
    string investigatgionID = string.Empty;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<PatientVisit> visitList = new List<PatientVisit>();
    Patient_BL patientBL;
    string gUID = string.Empty;
    string InvIDs = string.Empty;
    string Pid = string.Empty;
    string LabNo = string.Empty;

    #region "Common Resource Property"

    string strAlert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        deptID = Convert.ToInt32(Request.QueryString["dID"]);
        patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);

        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
            hdngUid.Value = Request.QueryString["gUID"].ToString();
        }
        if (Request.QueryString["pid"] != null)
        {
            Pid = Request.QueryString["pid"];
        }
        InvIDs = Request.QueryString["Invid"];
        if ((!string.IsNullOrEmpty(Request.QueryString["LNO"])))
        {
            LabNo = Request.QueryString["LNO"].ToString();
        }
        if (!IsPostBack)
        {
            //btnGo.Attributes.Add("onClick", "return validateVisitSampleNo()");

            ReportViewer.Visible = false;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            objPatientBL.GetReportTemplateForDept(patientVisitID, InvIDs, RoleID, OrgID, gUID, out lstReport, out lstReportName);

            patientBL.GetLabVisitDetails(patientVisitID, OrgID, out visitList);

            if (visitList.Count > 0)
            {
                //if (visitList[0].ExternalVisitID != null)
                //{
                //    lblVisitNo.Text = visitList[0].ExternalVisitID.ToString();
                //}
                //else
                //{
                //    lblVisitNo.Text = patientVisitID.ToString();
                //}
                //lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
                //lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
                //lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy"));

                //if (visitList[0].Sex == "M")
                //{
                //    lblGender.Text = "[Male]";
                //}
                //else
                //{
                //    lblGender.Text = "[Female]";
                //}
                //lblAge.Text = visitList[0].PatientAge.ToString();

            }
            if (lstReport.Count() > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstReportName;
                grdResult.DataBind();
                lblStatus.Visible = false;
                bindCheckBox();
            }
            else
            {
                lblStatus.Visible = true;
                grdResult.Visible = false;
            }
        }
        if (Request.QueryString["ShwBtn"] != null)
        {
            string boolValue = Request.QueryString["ShwBtn"].ToString();
            if (boolValue == "N")
            {
                btnBack.Visible = false;
            }
        }
        if (IsPostBack)
        {
            if (hdnShowReport.Value == "true")
                rptMdlPopup.Show();
            else
                rptMdlPopup.Hide();
        }
        if (!IsPostBack)
        {
            long returnRes;
            GateWay gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returnRes = gateWay.GetConfigDetails("PrintbtnInReportViewer", OrgID, out lstConfig);
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
            {
                hdnPrintbtnInReportViewer.Value = "Y";
                btnPrint.Attributes.Add("style", "display:block");
            }
        }
    }
    #endregion

    #region "Events"

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + patientVisitID +"&dID=" + deptID+ "&gUID=" + gUID + "&Invid=" + InvIDs);
            //Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + patientVisitID + "&dID=" + deptID + "&gUID=" + gUID + "&Invid=");
            // gUID = hdngUid.Value;
            //if (Request.QueryString["pid"] != null)
            //{
            //    Pid = Request.QueryString["pid"];
            //}
            Response.Redirect(Request.ApplicationPath + "/Investigation/InvestigationResultsCapture.aspx?vid=" + patientVisitID + "&gUID=" + gUID + "&Invid=" + InvIDs + "&pid=" + Pid + "&LNo=" + LabNo);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while redirecting InvestigationResultsCapture For Edit", ex);
        }
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Attune.Podium.BusinessEntities.Role role = new Attune.Podium.BusinessEntities.Role();
            role.RoleID = RoleID;
            List<Attune.Podium.BusinessEntities.Role> userRoles = new List<Attune.Podium.BusinessEntities.Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        { CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex); }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect(Request.ApplicationPath + "/Investigation/MethodKitCapture.aspx?vid=" + patientVisitID + "&dID=" + deptID + "&gUID=" + gUID + "&Invid=" + InvIDs);
            Response.Redirect(Request.ApplicationPath + "/Investigation/MethodKitCapture.aspx?vid=" + patientVisitID + "&dID=" + deptID + "&gUID=" + gUID + "&Invid=" + InvIDs + "&pid=" + Pid + "&LNo=" + LabNo);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while redirecting MethodKitCapture For Edit", ex);
        }
    }
    protected void grdResultDate_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");

            var ReportNames =
                from InvName in lstReport
                group InvName by
                        new
                        {
                            InvName.InvestigationName,
                            InvName.TemplateID,
                            InvName.CreatedAt,
                            InvName.Status
                        }
                    into grp
                    where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
                            && grp.ElementAt(0).CreatedAt == eInvReportMaster.CreatedAt
                    select grp;


            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                invRptMaster.AccessionNumber = lstgrp.ElementAt(0).AccessionNumber;
                invRptMaster.Status = lstgrp.ElementAt(0).Status;
                lstrptMaster.Add(invRptMaster);
            }



            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }

            foreach (DataListItem rpt in dtInvName.Items)
            {
                CheckBox chkbox = (CheckBox)rpt.FindControl("ChkBox");
                Label lblStatus = (Label)rpt.FindControl("lblStatus");
                LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                if (lblStatus != null && (lblStatus.Text == "Paid" || lblStatus.Text == "SampleReceived" || lblStatus.Text == "SampleCollected"))
                {
                    chkbox.Enabled = false;
                    lnkshow.Visible = false;
                }
                string clientid = chkbox.ClientID;
                ChkID.Value += clientid + '^';
                //code added for select all checkbox - begins
                if (HdnCheckBoxId.Value == "")
                { HdnCheckBoxId.Value = chkbox.ClientID; }
                else { HdnCheckBoxId.Value += '~' + chkbox.ClientID; }
                //code added for select all checkbox - ends
            }


            if (eInvReportMaster.TemplateID == 4)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));

                    if (lbl.Text == "4")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 9)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));

                    if (lbl.Text == "9")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 14)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));

                    if (lbl.Text == "14")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 5)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "5")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 6)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "6")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 7)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "7")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }

            else if (eInvReportMaster.TemplateID == 11)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "11")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 13)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "13")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 24)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "24")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 10)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "10")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
        }
    }
    protected void grdResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("grdResultDate");

            //    var ReportNames = 
            //        from InvName in lstReport
            //        group InvName by 
            //                new {
            //                        InvName.InvestigationName,
            //                        InvName.TemplateID 
            //                    }
            //                        into grp
            //                        where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
            //                        select grp;

            //var customerOrderGroups =
            //    from c in customers
            //    select
            //        new
            //        {
            //            c.CompanyName,
            //            YearGroups =
            //                from o in c.Orders
            //                group o by o.OrderDate.Year into yg
            //                select
            //                    new
            //                    {
            //                        Year = yg.Key,
            //                        MonthGroups =
            //                            from o in yg
            //                            group o by o.OrderDate.Month into mg
            //                            select new { Month = mg.Key, Orders = mg }
            //                    }
            //        };


            //    foreach (var lstgrp in ReportNames)
            //    {
            //        InvReportMaster invRptMaster = new InvReportMaster();
            //        invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
            //        invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
            //        invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
            //        invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
            //        lstrptMaster.Add(invRptMaster);
            //    }

            //    //foreach (IGrouping<IEnumerable<string>, InvReportMaster> lstgrp in ReportNames)
            //    //{
            //    //    InvReportMaster invRptMaster = new InvReportMaster();
            //    //    invRptMaster.InvestigationName = lstgrp.Key;
            //    //    invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
            //    //    invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
            //    //    invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
            //    //    lstrptMaster.Add(invRptMaster);
            //    //}

            //    if (lstrptMaster.Count() > 0)
            //    {
            //        dtInvName.DataSource = lstrptMaster;
            //        dtInvName.DataBind();
            //    }

            //    if (eInvReportMaster.TemplateID == 4)
            //    {
            //        foreach(DataListItem rpt in dtInvName.Items)
            //        {
            //            Label lbl = ((Label)rpt.FindControl("lblReportID"));
            //            if (lbl.Text == "4")
            //            {
            //                LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
            //                lnkshow.Visible = true;
            //                ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
            //            }
            //        }
            //    }
            //    else if (eInvReportMaster.TemplateID == 5)
            //    {
            //        foreach (DataListItem rpt in dtInvName.Items)
            //        {
            //            Label lbl = ((Label)rpt.FindControl("lblReportID"));
            //            if (lbl.Text == "5")
            //            {
            //                LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
            //                lnkshow.Visible = true;
            //                ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
            //            }
            //        }
            //    }
            //    else if (eInvReportMaster.TemplateID == 6)
            //    {
            //        foreach (DataListItem rpt in dtInvName.Items)
            //        {
            //            Label lbl = ((Label)rpt.FindControl("lblReportID"));
            //            if (lbl.Text == "6")
            //            {
            //                LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
            //                lnkshow.Visible = true;
            //                ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
            //            }
            //        }
            //    }

            //    if (eInvReportMaster.TemplateID == 3)
            //    {
            //        foreach (DataListItem rpt in dtInvName.Items)
            //        {
            //            Label lbl = ((Label)rpt.FindControl("lblReportID"));
            //            if (lbl.Text == "3")
            //            {
            //                LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
            //                lnkshow.Visible = true;
            //                ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
            //            }
            //        }
            //    }
            var ReportNames =
                  from InvName in lstReport
                  group InvName by
                new
                {
                    //InvName.InvestigationName,
                    InvName.CreatedAt,
                    InvName.TemplateID
                } into grp
                  where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
                  select grp;




            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                //invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                //invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                invRptMaster.Status = lstgrp.ElementAt(0).Status;
                lstrptMaster.Add(invRptMaster);
            }



            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }
        }
    }
    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        string strInvestigationEReport = Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_04 == null ? "Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report." : Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_04;
        string strPerformed = Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_05 == null ? "This action cannot be performed. Please enable notification settings." : Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_05;
        string strSincerely = Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_06 == null ? "Sincerely," : Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_06;
        string strDear = Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_07 == null ? "Dear" : Resources.Investigation_AppMsg.Investigation_InvReportsForApproval_aspx_07;


        long returnCode = -1;
        string deviceInfo = null;
        string format = "PDF";
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        string[] streamIDs = null;
        Microsoft.Reporting.WebForms.Warning[] warnings = null;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {
            targetStream = new MemoryStream();
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay(base.ContextInfo);
            returnCode = gateWay.GetCommunicationDetails(CommunicationType.EMail, patientVisitID, LocationName, out lstCommunicationDetails);
            if (lstCommunicationDetails.Count > 0 && lstCommunicationDetails[0].IsNotify && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
            {
                results = ReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                sourceStream = new MemoryStream(results);
                PdfDocument document = PdfReader.Open(sourceStream);
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
                objMailAttachment.FileName = "Report_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                ActionManager ObjActionManager = new ActionManager(base.ContextInfo);

                ObjActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail(lstCommunicationDetails[0].To, lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Investigation Report", "<div style='font-family:Verdana;font-size:12;'><p>" + strDear.Trim() + " " + lstCommunicationDetails[0].PatientName + ",</p><p>" + strInvestigationEReport.Trim() + "</p><div><br><br>" + strSincerely.Trim() + "<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ValidationWindow(" + strPerformed.Trim() + "," + strAlert.Trim() + ");", true);
            }
        }
        catch (Exception ex)
        {
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }
    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            //reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            //reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;

            //ShowReport(reportPath, patientVisitID, reportID,0);
            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            hdnTemplateId.Value = reportID;

            patientVisitID = Convert.ToInt64(patientVisitID);
            DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
            foreach (DataListItem dt in ctr.Items)
            {
                DataList ctr1 = (DataList)dt.FindControl("dlChildInvName");
                foreach (DataListItem chk in ctr1.Items)
                {
                    chkTemp = (CheckBox)chk.FindControl("ChkBox");
                    Label lbl = (Label)chk.FindControl("lblAccessionNo");
                    if (chkTemp.Checked)
                    {
                        strSelVal += lbl.Text + ",";
                    }

                }
                //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
            }
            //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
            strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));
            //dReport.Style.Add("display", "none");
            //imgClick.Style.Add("display", "none");

            ShowReport(reportPath, patientVisitID, reportID, strSelVal);

            rptMdlPopup.Show();
        }
    }
    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
            patientVisitID = Convert.ToInt64(patientVisitID);

            if (reportID == "10")
            {
                investigatgionID = ((Label)e.Item.FindControl("lblInvID")).Text;
                FckEdit1.LoadPatientDemography(OrgID, patientVisitID);
                //FckEdit1.loadText("Notes Report");
                FckEdit1.loadText(OrgID, Convert.ToInt64(patientVisitID), Convert.ToInt32(reportID), Convert.ToInt64(investigatgionID));
                rptMdlPopup2.Show();


            }
            else
            {


                ShowReport(reportPath, patientVisitID, reportID, investigatgionID);
                rptMdlPopup.Show();
            }
        }
        else if (e.CommandName == "ViewImage")
        {
            try
            {
                string AccessionNumber = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
                string Path = System.Configuration.ConfigurationManager.AppSettings["Pellucidpath"] + "/Investigation/ImageAccess.aspx?AccessionNumber=" + AccessionNumber;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "page", "javascript:launchSessionUrl('" + Path + "');", true);
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

        long ReturnCode = -1;
        AuditTransactionDetails obj;
        List<AuditTransactionDetails> ATD = new List<AuditTransactionDetails>();
        try
        {

            long VisitID = patientVisitID;/// Convert.ToInt64(hdnVID.Value);
            long TemplateID = Convert.ToInt64(hdnTemplateId.Value);

            obj = new AuditTransactionDetails();
            obj.AttributeID = VisitID;
            obj.AttributeName = AuditManager.AuditAttribute.Visit;
            obj.CreatedBy = LID;
            ATD.Add(obj);
            obj = new AuditTransactionDetails();
            obj.AttributeID = TemplateID;
            obj.AttributeName = AuditManager.AuditAttribute.Template;
            obj.CreatedBy = LID;
            ATD.Add(obj);




            ReturnCode = new AuditManager_BL(base.ContextInfo).InsertAuditTransactions(ATD, AuditManager.AuditCategoryCode.Report, AuditManager.AuditTypeCode.Print, LID, OrgID, ILocationID);
        }

        catch (Exception s)
        {
            CLogger.LogError("Error while Saving AuditTransaction in Investigation Report ", s);
        }

    }



    #endregion

    #region "Methods"
    private void bindCheckBox()
    {
        DataList chldDataLst = new DataList();
        CheckBox chkbox = new CheckBox();

        foreach (DataListItem items in grdResult.Items)
        {
            chkbox = (CheckBox)items.FindControl("chkSelectAll");
            //chldDataLst = (DataList)items.FindControl("grdResultDate");
            chkbox.Attributes.Add("onclick", "javascript:SelectAll('" + chkbox.ClientID + "')");
        }
        //foreach (DataListItem items in chldDataLst.Items)
        //{
        //      chkbox = (CheckBox)items.FindControl("chkSelectAll");
        //}



    }
    //protected void btnGo_Click(object sender, EventArgs e)
    //{
    //    patientVisitID=Convert.ToInt64(txtVisitSampleNo.Text);
    //    ReportViewer.Visible = false;
    //    Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
    //    objPatientBL.GetReportTemplate(patientVisitID, OrgID, out lstReport, out lstReportName);
    //    if (lstReport.Count() > 0)
    //    {
    //        grdResult.Visible = true;
    //        grdResult.DataSource = lstReportName;
    //        grdResult.DataBind();
    //        lblStatus.Visible = false;
    //    }
    //    else
    //    {
    //        lblStatus.Visible = true;
    //        grdResult.Visible = false;
    //    }


    //}
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

    public void ShowReport(string reportPath, long visitID, string templateID, string InvID)
    {
        try
        {
            hdnShowReport.Value = "true";
            ReportViewer.Visible = true;
            ReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            ReportViewer.ServerReport.ReportPath = reportPath;
            ReportViewer.ShowParameterPrompts = false;
            //ReportViewer.ShowPrintButton = true;
            if (hdnPrintbtnInReportViewer.Value == "Y")
            {
                ReportViewer.ShowPrintButton = false;
            }
            else
            {
                ReportViewer.ShowPrintButton = true;
            }
            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[8];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = ReportViewer.ServerReport.GetParameters();

            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();
            ReportViewer.ServerReport.SetParameters(lstParameter);
            ReportViewer.ServerReport.Refresh();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
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


    #endregion
    
    

 


    

    

    


    
    
    
    

    
}
