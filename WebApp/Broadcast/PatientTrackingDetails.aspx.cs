using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using Attune.Utilitie.Helper;
using Attune.Podium.PerformingNextAction;
using System.Globalization;

public partial class Reception_PatientsCurrDateVist : BasePage
{

    public Reception_PatientsCurrDateVist()
        : base("Reception\\PatientsCurrDateVist.aspx")
    {
    }
    ActionManager ObjActionManager;
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtVisitNumber.Focus();
            if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["VisitNumber"];
                menu.Attributes.Add("style", "display:none");
                header.Attributes.Add("style", "display:none");
                TopHeader1.Attributes.Add("style", "display:none");
                showmenu.Attributes.Add("style", "display:none");
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");
                
            }
           
            hdnBaseOrgId.Value = OrgID.ToString();
        }
        modalpopupsendemail.Hide();
        modalPopUp.Hide();
        if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
        {
            btncancel.Attributes.Add("style", "display:none");

        }
        ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:DisableTRFCtrls();", true); 
        tdCommunication.Style.Add("display", "none");
        li3.Attributes.Remove("class");
        if (CID > 0)
        {
            li2.Attributes.Add("style", "display:none");
        }
        else
        {
            li2.Attributes.Add("style", "display:block");
        }
        if (hdnflag.Value == "2")
        {
            li1.Attributes.Remove("class");
            li2.Attributes.Remove("class");
            tdCommunication.Style.Add("display", "table-cell");
            li3.Attributes.Add("class", "active");
        }
    }
    public void PatientDetails()
    {
        try
        {


            trPatDetails.Style.Add("display", "block");
            Patient_BL patbl = new Patient_BL(base.ContextInfo);
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<WorklistMaster> lstWLMaster = new List<WorklistMaster>();
            List<Notifications> lstNotifications = new List<Notifications>();
            string Name = string.Empty;
            string VisitNumber = string.Empty;
            string BarcodeNumber = string.Empty;
            string CaseNumber = string.Empty;
            long VisitID = -1;
            string PatientNumber = string.Empty;
            string gUID = string.Empty;
            long ClientID = -1;
            if ( rdbType.SelectedValue== "1")
            { 
            if (txtVisitNumber.Text != "")
            {
                VisitNumber = txtVisitNumber.Text;
                }
            }
            if(rdbType.SelectedValue=="2")
            { 
                if (txtVisitNumber.Text != "")
                {
                    BarcodeNumber = txtVisitNumber.Text;
                }
            }
             if(rdbType.SelectedValue=="3")
            { 
                if (txtVisitNumber.Text != "")
                {
                    CaseNumber = txtVisitNumber.Text;
                }
            }
            if (CID > 0)
            {
                ClientID = CID;
            }
            patbl.GetPatientTrackingDetails(OrgID, Name, VisitNumber, BarcodeNumber,CaseNumber, VisitID, PatientNumber, ClientID, out lstPatientVisitDetails,
                out lstPatientInvSample, out lstPatientInvestigation, out lstWLMaster, out lstNotifications);
            if (lstPatientVisitDetails.Count > 0)
            {
                hdnPatOrgID.Value = lstPatientVisitDetails[0].OrgID.ToString();
                int PatOrgID = 0;
                Int32.TryParse(hdnPatOrgID.Value, out PatOrgID);
                tdViewRegistration.Style.Add("display", "block");
                li1.Attributes.Add("class", "active");
                tdEpisodeHistory.Style.Add("display", "none");
                li2.Attributes.Remove("class");
                tdsamplefloating.Style.Add("display", "none");
                lblPatientName.Text = lstPatientVisitDetails[0].PatientName.ToString();
                lblAge.Text = lstPatientVisitDetails[0].Age.ToString();
                lblGender.Text = lstPatientVisitDetails[0].Sex.ToString();
                hdnPatientID.Value = lstPatientVisitDetails[0].PatientID.ToString();
                hdnVisitID.Value = lstPatientVisitDetails[0].PatientVisitID.ToString();
                foreach(PatientInvestigation lstpat in lstPatientInvestigation)
                {
                    if (lstpat.DisplayStatus != "Approve")
                    {
                        btnSendMailReport.Enabled = false;
                        btnViewReport.Enabled = false;
                    }
                    else
                    {
                        btnSendMailReport.Enabled = true;
                        btnViewReport.Enabled = true;
                        break;
                    }
                }
                if (lstPatientVisitDetails[0].VisitDate.ToString() == "01-01-1800")
                {
                    lblDOB.Text = "";
                }
                else
                {
                    lblDOB.Text = lstPatientVisitDetails[0].VisitDate.ToString("dd-MM-yyyy");
                    //lblDOB.Text = lstPatientVisitDetails[0].VisitDate.ToString("dd/MMM/yy");
                }
                //lblDOB.Text = lstPatientVisitDetails[0].VisitDate.ToString("dd/MMM/yy hh:mm tt");

                if (lstPatientVisitDetails[0].Status == "S")
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.Orange; 
                }
                else if (lstPatientVisitDetails[0].Status == "T")
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    lblClientName.BackColor = System.Drawing.Color.WhiteSmoke;
                }
                lblClientCode.Text = lstPatientVisitDetails[0].AccompaniedBy.ToString();
                if (lstPatientVisitDetails[0].Country != null)
                {
                    lblClientZone.Text = lstPatientVisitDetails[0].Country.ToString();
                }

                lblClientAddress.Text = lstPatientVisitDetails[0].Address.ToString();
                if (lstPatientVisitDetails[0].MobileNumber != null && lstPatientVisitDetails[0].MobileNumber != "")
                {
                    lblphoneno.Text = lstPatientVisitDetails[0].MobileNumber.ToString();
                }

                lblClientPhNo.Text = lstPatientVisitDetails[0].ComplaintDesc;
                lblClientEmail.Text = lstPatientVisitDetails[0].Param3;
                hdnClientEmail.Value = lstPatientVisitDetails[0].Param3;
                lblEmailID.Text = lstPatientVisitDetails[0].Param4;
                hdnPatientEmail.Value = lstPatientVisitDetails[0].Param4;
                lblRefDr.Text = lstPatientVisitDetails[0].Param6;
                lblSampleCollectedBy.Text = lstPatientVisitDetails[0].Param1.ToString();
                lblCollTime.Text = lstPatientVisitDetails[0].Param5.ToString();
                //lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                if (lstPatientVisitDetails[0].VisitState == "Y")
                {
                    tdb2b.Style.Add("background", "lightGreen");
                    tramt.Style.Add("display", "none");
                    trdue.Style.Add("display", "none");
                    trtotamt.Style.Add("display", "none");
                }
                else
                {
                    tdb2b.Style.Remove("background");
                }
                if (lstPatientVisitDetails[0].VisitState == "N")
                {
                    tdb2c.Style.Add("background", "lightGreen");
                    tramt.Style.Add("display", "none");
                    trdue.Style.Add("display", "none");
                    trtotamt.Style.Add("display", "none");
                    lblAmtPaid.Text = String.Format("{0:0.00}", Convert.ToDecimal(lstPatientVisitDetails[0].AmountReceived).ToString());

                    lblDueAmt.Text = String.Format("{0:0.00}", Convert.ToDecimal(lstPatientVisitDetails[0].DueAmount).ToString());

                    lbltotAmount.Text = String.Format("{0:0.00}", Convert.ToDecimal(lstPatientVisitDetails[0].NetAmount).ToString());
                }
                else
                {
                    tdb2c.Style.Remove("background");
                }
                if (lstPatientVisitDetails[0].ComplaintName == "Paid")
                {
                    tdaccession.Style.Add("background", "lightGreen");
                }
                else
                {
                    tdaccession.Style.Remove("background");
                }
                

                if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
                {
                    List<PatientVisitDetails> groupByResult = new List<PatientVisitDetails>();

                    groupByResult = (from lst in lstPatientVisitDetails
                                     group lst by
                                     new
                                     {
                                         lst.History,
                                         lst.Remarks,
                                         lst.EmergencyPatientTrackerID
                                     } into grp

                                     select new PatientVisitDetails
                                     {
                                         History = grp.Key.History,
                                         Remarks = grp.Key.Remarks,
                                         EmergencyPatientTrackerID = grp.Key.EmergencyPatientTrackerID
                                     }).Distinct().ToList();

                    Bckgrd.DataSource = groupByResult;
                    Bckgrd.DataBind();
                    history.Visible = true;
                }
                else
                {
                    history.Visible = false;
                }
                if (RoleName == "Client")
                {
                    trBillingDetails.Style.Add("display", "none");
                   
                }
                else
                {
                    PatientBillingDetails();
                }

                Investigation_BL DemoBL;
                DemoBL = new Investigation_BL(base.ContextInfo);
                List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();

                DemoBL.pGetpatientInvestigationForVisit(Convert.ToInt64(hdnVisitID.Value), PatOrgID, ILocationID, gUID, out lstorderInvforVisit);

                if (lstorderInvforVisit.Count > 0)
                {

                    GrdInv.DataSource = lstorderInvforVisit;
                    GrdInv.DataBind();
                    CheakInv.Style.Add("display", "block");

                }

                if (hdnPatientID.Value !="" && hdnVisitID.Value !="") 
                {
                    //if (Request.QueryString["IsPopup"] == "Y")
                    //{
                    //    ViewTRF.Style.Add("display", "none");
                    //}
                    //else
                    //{
                    String FileName = String.Empty;
                    int patientid = Convert.ToInt32(hdnPatientID.Value);
                    int visitid = Convert.ToInt32(hdnVisitID.Value);
                    long returncode = -1;
                    List<Patient> lstpat = new List<Patient>();
                    List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
                    List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
                    List<TRFfilemanager> lstOutSourceDoc = new List<TRFfilemanager>();
                    string Type = "";
                    returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID, Type, out lstFiles);
                    returncode = new Patient_BL(base.ContextInfo).Viewpatientphoto(patientid, out lstpat);
                    if (lstFiles.Count > 0)
                    {
                        lstOutSourceDoc = lstFiles.FindAll(P => P.IdentifyingType == "Outsource_Docs");
                    }
                    if (lstFiles.Count > 0)
                    {
                        lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "TRF_Upload");
                    }
                    if (lstpat.Count > 0)
                    {
                        FileName = lstpat[0].PictureName;
                    }
                    if (lstTRF.Count > 0 || lstOutSourceDoc.Count > 0 || (FileName != "" && FileName != null))
                    {

                        TRFUC.Dispose();

                        ViewTRF.Style.Add("display", "block");
                        TRFUC.loadphoto(Convert.ToInt32(hdnPatientID.Value));
                        TRFUC.loadimage(Convert.ToInt32(hdnPatientID.Value), Convert.ToInt32(hdnVisitID.Value));
                        TRFUC.loadOutSourceDoc(Convert.ToInt32(hdnPatientID.Value), Convert.ToInt32(hdnVisitID.Value));
                        TRFUC.LoadUcHistory(Convert.ToInt32(hdnVisitID.Value));
                    }
                    else { ViewTRF.Style.Add("display", "none"); }
                    //}
                }
            }
            else
            {
                lblPatientName.Text = "";
                lblAge.Text = "";
                lblGender.Text = "";
                lblDOB.Text = "";
                lblClientName.Text = "";
                lblClientCode.Text = "";
                lblRefDr.Text = "";
                lblSampleCollectedBy.Text = "";
                lblCollTime.Text = "";
                tdaccession.Style.Remove("background");
                tdb2b.Style.Remove("background");
                trPatDetails.Style.Add("display", "none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('No Matching Records found!');", true);
            }
            if (lstPatientInvSample.Count > 0)
            {

                if (lstPatientInvSample[0].CreatedAt.ToString("dd/MM/yyyy") != "01/01/1753")
                {
                    lblsampckuptime.Text = lstPatientInvSample[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    lblsampckuptime.Text = "";
                }
                lblSampleRegTime.Text = lstPatientInvSample[0].ModifiedAt.ToString("dd/MMM/yy hh:mm tt");
                if (lstPatientInvSample[0].RecSampleLocID == ILocationID)
                {

                }
                else
                {
                    // tdtransist.Style.Add("background", "lightGreen");
                }
                if (lstPatientInvSample[0].InvSampleStatusDesc == "SampleCollected" || lstPatientInvSample[0].InvSampleStatusDesc == "Paid")
                {

                    tdaccession.Style.Add("background", "lightGreen");
                }
                else
                {
                    tdaccession.Style.Remove("background");
                }
                if (lstPatientInvSample[0].InvSampleStatusDesc == "Approve" && lstPatientInvestigation[0].OrderedAt.ToString() == "01/01/0001 00:00:00")
                {
                    tdrepauth.Style.Add("background", "lightGreen");
                }
                else
                {
                    tdrepauth.Style.Remove("background");
                }
                if (lstPatientInvSample[0].InvSampleStatusDesc == "SampleReceived" || lstPatientInvSample[0].InvSampleStatusDesc == "Completed"
                    || lstPatientInvSample[0].InvSampleStatusDesc == "Validate" || lstPatientInvSample[0].InvSampleStatusDesc == "Co-authorize")
                {
                    tdtesting.Style.Add("background", "lightGreen");
                }
                else
                {
                    tdtesting.Style.Remove("background");
                }
                if (lstPatientInvestigation.Count > 0)
                {
                    if (lstPatientInvestigation[0].OrderedAt.ToString() != null && lstPatientInvestigation[0].OrderedAt.ToString() != "01/01/0001 00:00:00")
                    {
                        tdreppdf.Style.Add("background", "lightGreen");
                    }
                    else
                    {
                        tdreppdf.Style.Remove("background");
                    }

                }
                else
                {
                    tdreppdf.Style.Remove("background");
                }
                if (lstPatientInvSample.Count > 0)
                {
                    GrdSample.DataSource = lstPatientInvSample;
                    GrdSample.DataBind();

                }
                else
                {
                    GrdSample.DataSource = null;
                    GrdSample.DataBind();
                }

            }
            else
            {
                tdrepauth.Style.Remove("background");
                tdtesting.Style.Remove("background");
                tdreppdf.Style.Remove("background");
                tdaccession.Style.Remove("background");
                
                lblsampckuptime.Text = "";
                lblSampleRegTime.Text = "";
                GrdSample.DataSource = null;
                GrdSample.DataBind();

            }
            if (lstPatientInvestigation.Count > 0)
            {


                GrdReport.DataSource = lstPatientInvestigation;
                GrdReport.DataBind();
            }
            else
            {
                GrdReport.DataSource = null;
                GrdReport.DataBind();
            }

            if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
            {
                List<PatientVisitDetails> groupByResult = new List<PatientVisitDetails>();

                groupByResult = (from lst in lstPatientVisitDetails
                                 group lst by
                                 new
                                 {
                                     lst.History,
                                     lst.Remarks,
                                     lst.EmergencyPatientTrackerID
                                 } into grp

                                 select new PatientVisitDetails
                                 {
                                     History = grp.Key.History,
                                     Remarks = grp.Key.Remarks,
                                     EmergencyPatientTrackerID = grp.Key.EmergencyPatientTrackerID
                                 }).Distinct().ToList();

                Bckgrd.DataSource = groupByResult;
                Bckgrd.DataBind();
                history.Visible = true;
            }
            else
            {
                history.Visible = false;
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Contact System Amdminstrator", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        PatientDetails();
        modalpopupsendemail.Hide();
        modalPopUp.Hide();

    }
    protected void GrdSample_Databound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToDateTime(e.Row.Cells[5].Text).ToString("H:mm") == "0:00")
            {
                e.Row.Cells[5].Text = Convert.ToDateTime(e.Row.Cells[5].Text).ToString("dd-MM-yyyy");
            }
            else
            {
                e.Row.Cells[5].Text = Convert.ToDateTime(e.Row.Cells[5].Text).ToString("dd-MM-yyyy hh:mm:tt");
            }
            if (e.Row.Cells[7].Text == "01-01-0001 12:00 AM")
            {
                e.Row.Cells[7].Text = "";
            }
            if (e.Row.Cells[9].Text == "01-01-0001 12:00 AM")
            {
                e.Row.Cells[9].Text = "";
            }
        }
    }

    protected void GrdReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientInvestigation lstpatInv = (PatientInvestigation)e.Row.DataItem;
            if (e.Row.Cells[3].Text == "01-01-0001 12:00 AM")
            {
                e.Row.Cells[3].Text = "";
            }

            if (e.Row.Cells[4].Text == "01-01-0001 12:00 AM")
            {
                e.Row.Cells[4].Text = "";
            }

            if (e.Row.Cells[5].Text == "01-01-0001 12:00 AM")
            {
                e.Row.Cells[5].Text = "";
            }
            if (lstpatInv.IsSTAT == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;
            }
            if (lstpatInv.DisplayStatus == "ReCollect")
            {
                e.Row.BackColor = System.Drawing.Color.Orange;
            }
            if (lstpatInv.ReferredType == "Retest" && (lstpatInv.DisplayStatus == "Reflexwithsamesample" || lstpatInv.DisplayStatus == "Reflexwithnewsample"))
            {
                e.Row.BackColor = System.Drawing.Color.Orange;
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("../Reception/PatientTrackingDetails.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            hdnSelectedMailButton.Value = "reportviewer";
            if (!string.IsNullOrEmpty(hdnClientEmail.Value))
            {
                txtMailAddress.Text = hdnClientEmail.Value;
            }
            else
            {
                txtMailAddress.Text = hdnPatientEmail.Value;
            }
            modalpopupsendemail.Show();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
    }
    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {
        try
        {
            string SnapshotType = string.Empty;
            SnapshotType = hdnSnapshotType.Value;
            
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = Convert.ToInt64(hdnPatientID.Value);
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PatientVisitID = Convert.ToInt64(hdnVisitID.Value);
            PC.PageID = Convert.ToInt64(PageID);
            if (SnapshotType == "Report")
            {
                PC.ButtonName = "Send";
                PC.ButtonValue = "Send Mail";
            }
            else if (SnapshotType == "Bill")
            {
                long pFinalBillID = -1;
                Int64.TryParse(hdnFinalBillID.Value, out pFinalBillID);
                PC.FinalBillID = pFinalBillID;
                PC.BillNumber = pFinalBillID.ToString();
                PC.ButtonName = "SendMail";
                PC.ButtonValue = "BillMail";
            }
            PC.Description = txtMailAddress.Text;
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC, "", "");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('"+SnapshotType+" Mail Send Successfully');", true);
            modalpopupsendemail.Hide();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }

    }

    protected void grdAudit_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
    }
    protected void grdAudit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdAudit.PageIndex = e.NewPageIndex;
        }
        btnShow_OnClick(sender, e);
    }

    protected void GrdReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            GrdReport.PageIndex = e.NewPageIndex;
        }
        btnGo_Click(sender, e);
    }

    public void PatientBillingDetails()
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<BillSearch> billSearch = new List<BillSearch>();
        int totalRows = 0;
        string VisitNumber = string.Empty;
        string BarcodeNumber = string.Empty;
        string CaseNumber = string.Empty;
        int PatOrgID = 0;
        Int32.TryParse(hdnPatOrgID.Value, out PatOrgID);

        if (rdbType.SelectedValue == "1")
        {
        if (txtVisitNumber.Text != "")
        {
            VisitNumber = txtVisitNumber.Text;
            }
        }
        if (rdbType.SelectedValue == "2")
        {
            if (txtVisitNumber.Text != "")
            {
                BarcodeNumber = txtVisitNumber.Text;
            }
        }
        if (rdbType.SelectedValue == "3")
        {
            if (txtVisitNumber.Text != "")
            {
                CaseNumber = txtVisitNumber.Text;
            }
        }
        string pOrgDateTime = OrgDateTimeZone;
       // DateTime DT = Convert.ToDateTime(pOrgDateTime);

        returnCode = patientBL.SearchBillOptionDetails("", "01/10/2013", (Convert.ToDateTime(new BasePage().OrgDateTimeZone).Day + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year).ToString(), "", -1, PatOrgID,
            "", "", VisitNumber,BarcodeNumber,CaseNumber, out billSearch, 10, 1, out totalRows, 0);
        if (returnCode == 0 && billSearch.Count > 0)
        {
            grdResult.Visible = true; 
            grdResult.DataSource = billSearch;
            grdResult.DataBind();
            
                trBillingDetails.Attributes.Add("display", "block");
            
        }
        else
        {
            trBillingDetails.Attributes.Add("display", "none");
        }
    }
    protected void btnViewreport_Click(object sender, EventArgs e)
    {
        try
        {
                modalPopUp.Show();
                long pVisitID = -1;
                long returnCode = -1;
                long PatientID = -1;
                string dPatientID = string.Empty;
                dPatientID = hdnPatientID.Value;
                pVisitID = Convert.ToInt64(hdnVisitID.Value);
                Int64.TryParse(dPatientID, out PatientID);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:DisplayTab('VREG');", true);
                Report_BL objReportBL = new Report_BL(base.ContextInfo); 
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                string PDFPath = string.Empty;
                string Status = string.Empty;
                string SnapshotType = string.Empty;
                SnapshotType = hdnSnapshotType.Value;

                ContextInfo.AdditionalInfo = SnapshotType;
                if (SnapshotType == "Bill")
                {
                    Int64.TryParse(hdnFinalBillID.Value,out pVisitID);
                }
                returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true,"",out lstReportSnapshot);
                if (lstReportSnapshot.Count > 0)
                {
                        if (System.IO.File.Exists(lstReportSnapshot[0].ReportPath))
                        {
                            PDFPath = lstReportSnapshot[0].ReportPath;
                        }                
                }
                if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
                {
                   
                        string CurrentOrgID = OrgID.ToString();
                        string filePath = PDFPath;
                        modalPopUp.Show();
                        ifPDF.Attributes["src"] = "ReportPdf1.aspx?pdf=" + filePath;
                }
               
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Getting Report, PDF", ex);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillSearch bs = (BillSearch)e.Row.DataItem;

                if (bs.IsCreditBill == "Y")
                {

                    e.Row.CssClass = "grdrows";
                    e.Row.Cells[1].ToolTip = "Credit Patient";
                    e.Row.Cells[2].ToolTip = "Credit Patient";
                    e.Row.Cells[3].ToolTip = "Credit Patient";
                    e.Row.Cells[4].ToolTip = "Credit Patient";
                    e.Row.Cells[5].ToolTip = "Credit Patient";
                    e.Row.Cells[6].ToolTip = "Credit Patient";
                    e.Row.Cells[7].ToolTip = "Credit Patient";
                }
                if (bs.Refundstatus == "CANCELLED")
                    bs.Status = "CANCELLED";
                string strScript = "javascript:SelectedBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.Name + "','" + bs.PatientNumber + "','" + bs.BillID + "', '" + bs.Status + "','" + bs.BillNumber + "');javascript:SelectBillNo('" + bs.BillNumber + "', '" + bs.Refundstatus + "','" + bs.VisitType + "','" + bs.IsCreditBill + "','" + bs.VisitState + "','" + bs.CollectionType + "','" + bs.AmountReceived + "','" + Convert.ToDecimal(bs.ClientName) + "','" + Convert.ToDecimal(bs.Amount) + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", "SelectBillNo('','1');");

                if (bs.Status == "CANCELLED" || bs.Refundstatus == "CANCELLED")
                {
                    //e.Row.BackColor = System.Drawing.Color.LimeGreen;
                    e.Row.CssClass = "grdrows";

                    e.Row.Cells[1].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[2].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[3].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[4].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[5].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[6].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[7].ToolTip = "This bill has been cancelled";
                }
                if (bs.RefOrgName != "" && bs.RefOrgName != null)
                {
                    e.Row.BackColor = System.Drawing.Color.LimeGreen;
                }
                Label btnViewBillRowCommand = (Label)e.Row.FindControl("lblViewBill");
                Label btnMailBillRowCommand = (Label)e.Row.FindControl("lblMailBill");
                Label btnViewBillB2CCommand = (Label)e.Row.FindControl("lblViewBillB2C");
                Label btnViewCompleteBillB2CCommand = (Label)e.Row.FindControl("lblViewCompleteBillB2C");
                Label btnSplit1Command = (Label)e.Row.FindControl("lblSplit1");
                Label btnSplit2Command = (Label)e.Row.FindControl("lblSplit2");
                
                //  btnRowCommand.Attributes.Add("onclick", "ChangePaymentModes('" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.PatientNumber + "','" + bs.BillNumber + "','" + OrgID + "','" + bs.ClientID + "','" + bs.Name + "','" + bs.AmountReceived + "');");
                if (bs.IsCoPaymentBill == "Y")
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFDDAA");
                }
                if (bs.IsCreditBill == "Y" && bs.IsCoPaymentBill != "Y")
                {
                    e.Row.Cells[15].Visible = false;
                    btnViewBillRowCommand.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "ViewBill$" + e.Row.RowIndex));
                    btnMailBillRowCommand.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "MailBill$" + e.Row.RowIndex));
                }
                else
                {
                   // if (bs.Amount > bs.AmountReceived)
                    if ((bs.Amount > bs.AmountReceived)&&(bs.IsCoPaymentBill != "Y"))
                    {
                        e.Row.BackColor = System.Drawing.Color.IndianRed;
                    }
                    e.Row.Cells[14].Visible = false;
                    btnViewBillB2CCommand.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "ViewB2CBill$" + e.Row.RowIndex));
                    
                    if (bs.Status == "Closed")
                    {
                    btnViewCompleteBillB2CCommand.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "ViewB2CCompleteBill$" + e.Row.RowIndex));
                    }
                    else { btnViewCompleteBillB2CCommand.Attributes.Add("style", "display:none"); }

                    Panel dvDuePaidBill = (Panel)e.Row.FindControl("dvDuePaidBill");
                    if (bs.VisitType == 1)
                    {
                        dvDuePaidBill.Attributes.Add("style", "display:block");
                    }
                    else
                    {
                        dvDuePaidBill.Attributes.Add("style", "display:none");
                    }
                }

            }
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            long returncode = -1;
            long FinalBillID = -1;
            int rowIndex = -1;
                rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow grow = grdResult.Rows[rowIndex];
                FinalBillID = Convert.ToInt64(grdResult.DataKeys[rowIndex][0].ToString());
                hdnFinalBillID.Value = FinalBillID.ToString();
            if (e.CommandName == "ViewBill")
            {
                
                hdnSnapshotType.Value = "Bill";
                btnViewreport_Click(sender, e);
                
            }
            else if (e.CommandName == "MailBill")
            {
                hdnSnapshotType.Value = "Bill";
                btnSendMail_Click(sender, e);
            }
            else if (e.CommandName == "ViewB2CBill")
            {
                modalPopUp.Show();
                ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid="+hdnVisitID.Value+"&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid="+ hdnFinalBillID.Value+"&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y";
            }
            else if (e.CommandName == "ViewB2CCompleteBill")
            {
                modalPopUp.Show();
                ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid=" + hdnVisitID.Value + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + hdnFinalBillID.Value + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y&isFB=Y&isDbill=Y";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Client Attributes.", ex);
        }
    }
    public void btnShow_OnClick(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string ExternalVisitID = string.Empty;
            string ExternalBarcode = string.Empty;
            int Orgid = OrgID;
            if (rdbType.SelectedValue == "1")
            {
                if (txtVisitNumber.Text != "")
                {       
                    ExternalVisitID = txtVisitNumber.Text;
                }
            }
            if (rdbType.SelectedValue == "2")
            {
                if (txtVisitNumber.Text != "")
                {
                    ExternalBarcode = txtVisitNumber.Text;
                }
            }
            List<AuditTrailReport> lstAuditTrailReport = new List<AuditTrailReport>();
            NewReports_BL objBL = new NewReports_BL(base.ContextInfo);
            returnCode = objBL.GetAuditTrailReport(ExternalVisitID,ExternalBarcode,Orgid, out lstAuditTrailReport);
            if (lstAuditTrailReport.Count > 0)
            {
                grdAudit.DataSource = lstAuditTrailReport;
                grdAudit.DataBind();
                tdViewRegistration.Style.Add("display", "none");
                li1.Attributes.Remove("class");
                tdEpisodeHistory.Style.Add("display", "block");
                li2.Attributes.Add("class", "active");
            }
            else
            {
                grdAudit.DataSource = null;
                grdAudit.DataBind();
                tdViewRegistration.Style.Add("display", "none");
                li1.Attributes.Remove("class");
                tdEpisodeHistory.Style.Add("display", "block");
                li2.Attributes.Add("class", "active");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While get Values on btnSearch_OnClick", ex);
        }

    }

    protected void GrdInv_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");

            if (lblStatus.Text == "Recheck")
            {
                lblStatus.Text = "RR";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "Retest")
            {
                lblStatus.Text = "RC";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "ReflexTest")
            {
                lblStatus.Text = "RF";
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lblStatus.Visible = false;
            }
        }
    }

  
    protected void grdCommunication_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            
            grdCommunication.PageIndex = e.NewPageIndex;
        }
        btnShow_OnClick(sender, e);
        btnCommunication_Click(sender, e);
    }
    protected void btnCommunication_Click(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string ExternalVisitID = string.Empty;
            string ExternalBarcode = string.Empty;
            int Orgid = OrgID;
            if (rdbType.SelectedValue == "1")
            {
                if (txtVisitNumber.Text != "")
                {
                    ExternalVisitID = txtVisitNumber.Text;
                }
            }
            if (rdbType.SelectedValue == "2")
            {
                if (txtVisitNumber.Text != "")
                {
                    ExternalBarcode = txtVisitNumber.Text;
                }
            }

            List<NBCommunicationMaster> listCommunication = new List<NBCommunicationMaster>();
            Communication_BL comBL = new Communication_BL(base.ContextInfo);
            returnCode = comBL.GetCommuicationvisitDetails(ExternalVisitID, ExternalBarcode, Orgid, out listCommunication);
            if (listCommunication.Count > 0)
            {
                grdCommunication.DataSource = listCommunication;
                grdCommunication.DataBind();
                tdViewRegistration.Style.Add("display", "none");
                tdEpisodeHistory.Style.Add("display", "none");
                li1.Attributes.Remove("class");
                tdCommunication.Style.Add("display", "block");
               
                li3.Attributes.Add("class", "active");
            }
            else
            {
                grdCommunication.DataSource = null;
                grdCommunication.DataBind();
                tdViewRegistration.Style.Add("display", "none");
                li1.Attributes.Remove("class");
                tdEpisodeHistory.Style.Add("display", "none");
                tdCommunication.Style.Add("display", "block");
                li3.Attributes.Add("class", "active");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While get Values on btnSearch_OnClick", ex);
        }


    }
}
