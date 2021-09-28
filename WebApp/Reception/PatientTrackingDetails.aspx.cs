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

public partial class Reception_PatientTrackingDetails : BasePage
{

    public Reception_PatientTrackingDetails()
        : base("Reception_PatientTrackingDetails_aspx")
    {
    }
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    ActionManager ObjActionManager;
    // added by sudha
    Investigation_BL InvestigationBL;
    int confidentialval = 0;
    // ended by sudha
    string value = string.Empty;
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    String strSsrsShowReport = string.Empty;
    int DueBill = 0;
    string cell_1_Value = string.Empty;
    string NoRec = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_06;
    string strReport = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_07;
    string strBill = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_08;
    string strsucess= Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_09;
    string alert = Resources.Reception_AppMsg.Reception_SaveLabRefOrgDetails_Alert;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059 == null ? "Female" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060 == null ? "Male" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060;
    string strStatus = Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_01 == null ? "Approve" : Resources.Investigation_ClientDisplay.Investigation_InvestigationDisplay_aspx_01;
    string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    string strVisitNo = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11 == null ? "Visit Number" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11;
    string strLabNo = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04 == null ? "Lab Number" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04;
    string strNA = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071 == null ? "NA" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071;

	protected void Page_Load(object sender, EventArgs e)
    {
        string UseWardnoAsSRFID = GetConfigValue("UseWardnoAsSRFID", OrgID);
        if (UseWardnoAsSRFID == "Y")
        {
            hdnSRFNumberSearch.Value = "Y";
            rdbType.Items[4].Attributes.Add("style", "display:block");
        }
        else
        {
            hdnSRFNumberSearch.Value = "N";
            rdbType.Items[4].Attributes.Add("style", "display:none");
        }
        if (!IsPostBack)
        {
            hdnPageID.Value = Convert.ToString(PageContextDetails.PageID);
            hdnPHCorgID.Value = OrgID.ToString();
            txtVisitNumber.Focus();
            if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["VisitNumber"];
                // menu.Attributes.Add("style", "display:none");
                // header.Attributes.Add("style", "display:none");
                // TopHeader1.Attributes.Add("style", "display:none");
                // showmenu.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");
                // added by sudha to hide cofidential reportdata
                disableCofidientialReport();

            }

            else if (Request.QueryString["LabNumber"] != null && Request.QueryString["LabNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["LabNumber"];
                // menu.Attributes.Add("style", "display:none");
                // header.Attributes.Add("style", "display:none");
                // TopHeader1.Attributes.Add("style", "display:none");
                // showmenu.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");
                // added by sudha to hide cofidential reportdata
                disableCofidientialReport();

            }
            else if (Request.QueryString["BarcodeNumber"] != null && Request.QueryString["BarcodeNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["BarcodeNumber"];
                rdbType.SelectedIndex = 1;
                // menu.Attributes.Add("style", "display:none");
                // header.Attributes.Add("style", "display:none");
                // TopHeader1.Attributes.Add("style", "display:none");
                // showmenu.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");

            }
            else if (Request.QueryString["CaseNumber"] != null && Request.QueryString["CaseNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["CaseNumber"];
                rdbType.SelectedIndex = 1;
                // menu.Attributes.Add("style", "display:none");
                // header.Attributes.Add("style", "display:none");
                // TopHeader1.Attributes.Add("style", "display:none");
                // showmenu.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");

            }

            string HIDE_CommDetails = GetConfigValue("communicationTAB_hide", OrgID);


            if (HIDE_CommDetails == "Y")
            {
                li3.Attributes.Add("style", "display:none");
            }


            
            string HideCaseNumber = GetConfigValue("ShowCaseNumber", OrgID);
            hdnCaseNumber.Value = HideCaseNumber;
            if (HideCaseNumber == "Y")
            {

                rdbType.Items[2].Attributes.Add("style", "display:block");
            }
            else
            {
                rdbType.Items[2].Attributes.Add("style", "display:none");
            
            }
            string HidePatientVID = GetConfigValue("ShowPatientVID", OrgID);

            if (HidePatientVID == "Y")
            {
                    tvid.Attributes.Add("style","display:table-cell");
                    tvid1.Attributes.Add("style", "display:table-cell");
                    tEVNo.Attributes.Add("style", "display:table-cell");
                    tEVNo1.Attributes.Add("style", "display:table-cell");
            }

            hdnBaseOrgId.Value = OrgID.ToString();
            string AllowExternalBarcode = GetConfigValue("AllowExternalBarcode", OrgID);
            if (AllowExternalBarcode == "Y")
            {
                hdnExternalBarcodeSearch.Value = "Y";
            }
            else {
                hdnExternalBarcodeSearch.Value = "N";
            }
            
            
            //Added By QBITZ Prakash.K
            LoadMetaData();

            //Added by Jegan for ManualReport button set visibility
            ManualReportStatus();
        }
        modalpopupsendemail.Hide();
        modalPopUp.Hide();
        if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
            btncancel.Attributes.Add("style", "display:none");

        }
        ScriptManager.RegisterStartupScript(Page, GetType(), "DivHide", "javascript:DisableTRFCtrls();", true);
        String RoleWiseAuditHide = GetConfigValue("HideAuditHistory", OrgID);

    


      
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
		if (!String.IsNullOrEmpty(RoleWiseAuditHide))
        {
            String[] rgr = RoleWiseAuditHide.Split(',');
           
            foreach (String item in rgr)
            {
                if (RoleName == item)
                {
                    li2.Attributes.Add("style", "display:none");
                }
            }
        }
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitSearch", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = strLabNo.Trim();
            txtVisitNumber.MaxLength = 12;
        }
        else
        {
            defaultText = strVisitNo.Trim();
        }
        txtwatermark();
    }

    // added by sudha to hide the confidential values in Grid
   // And confirm with prem to show the alert in viewReport Button 
    public void disableCofidientialReport()
    {
        try
        {
           // Convert.ToInt64(Request.QueryString["VisitNumber"])
           // long vid = Convert.ToInt64(txtVisitNumber.Text);
            //confidentialval = confidentialval + 1;
            Investigation_BL InvestigationBL = new Investigation_BL();
            
            //Based on Role, hide confidential grid-Sudha
            string RoleConfidential = Session["Showconfidential"] != null ? Session["Showconfidential"].ToString() : "";
            value = InvestigationBL.PGetConfidential(Convert.ToInt64((hdnVisitID.Value).ToString()));
            if (value == "Y" && RoleConfidential=="N")
            {
                dvAccess.Attributes["style"] = "display:none;";
            }
        }
        catch (Exception ex)
        { string s = ex.Message; }
    }
    public void txtwatermark()
    {
        if (txtVisitNumber.Text.Trim() != defaultText.Trim())
        {
            txtVisitNumber.Attributes.Add("style", "color:black");
        }
        if (txtVisitNumber.Text == "")
        {
            txtVisitNumber.Text = defaultText;
            txtVisitNumber.Attributes.Add("style", "color:gray");
        }
        txtVisitNumber.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtVisitNumber.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

    }
    public void PatientDetails()
    {
        try
        {


            trPatDetails.Style.Add("display", "table-row");
            Patient_BL patbl = new Patient_BL(base.ContextInfo);
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<WorklistMaster> lstWLMaster = new List<WorklistMaster>();
            List<Notifications> lstNotifications = new List<Notifications>();
			
			String HideClientEmailMobile = GetConfigValue("HideClientEmailMobile", OrgID);
            List<InvestigationValues> lstInvestigationValues=new List<InvestigationValues>();
            string Name = string.Empty;
            string VisitNumber = string.Empty;
            string BarcodeNumber = string.Empty;
            string CaseNumber = string.Empty;
            long VisitID = -1;
            string PatientNumber = string.Empty;
            string gUID = string.Empty;
            long ClientID = -1;
            string ExternalPatientNumber=string.Empty;
            string SpeciesName = string.Empty;
            string PreviousLabNumber = string.Empty;
            bool IsCumulative = false;
            string ReportMode = string.Empty;
            string Confidential = string.Empty;
            //long reportClientid = 0;
            string ReportingCentername = string.Empty;
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
                if (hdnExternalBarcodeSearch.Value == "Y")
                {                    
                    if (hdnVisitNumber.Value != "")
                    {
                        VisitNumber = hdnVisitNumber.Value;
                        BarcodeNumber = "";
                        ContextInfo.DepartmentName = "Barcode";
                    }
                }
            }
            if (rdbType.SelectedValue == "3")
            {
                if (txtVisitNumber.Text != "")
                {
                    CaseNumber = txtVisitNumber.Text;
                }
            }
			if (rdbType.SelectedValue == "4")
            {
                if (hdnVisitNumber.Value != "")
                {
                    VisitNumber = hdnVisitNumber.Value;
                }
            }
            if (rdbType.SelectedValue == "5" && hdnSRFNumberSearch.Value == "Y" )
            { 
                    if (hdnVisitNumber.Value != "")
                    {
                        VisitNumber = hdnVisitNumber.Value; 
                        ContextInfo.DepartmentName = "SRFNumber";
                    }
                
            }

			 if (hdnCaseNumber.Value == "Y")
            {

                rdbType.Items[2].Attributes.Add("style", "display:block");
            }
            else
            {
                rdbType.Items[2].Attributes.Add("style", "display:none");

            }
			
            if (CID > 0)
            {
                ClientID = CID;
            }
            patbl.GetPatientTrackingDetails(OrgID, Name, VisitNumber, BarcodeNumber, CaseNumber, VisitID, PatientNumber, ClientID, out lstPatientVisitDetails,
                out lstPatientInvSample, out lstPatientInvestigation, out lstWLMaster, out lstNotifications);
            //Added By QBITZ Prakash.K
			int intIsAvailableCumulative =0;
			if(lstPatientInvestigation!=null && lstPatientInvestigation.Count>0)
            intIsAvailableCumulative = lstPatientInvestigation.Where(p => p.IsAvailableCumulative == true).Count();
            if (intIsAvailableCumulative > 0)
            {
                btnViewCumulativeReport.Visible = true;
            }
            else
            {
                btnViewCumulativeReport.Visible = false;
            }
            //End By QBITZ Prakash.K
            if (lstWLMaster.Count > 0)
            {
                rptWorkList.DataSource = lstWLMaster;
                rptWorkList.DataBind();
            }
            else
            {
                rptWorkList.DataSource = null;
                rptWorkList.DataBind();
            }
            if (lstNotifications.Count > 0)
            {
                var lstEmailNotification = from c in lstNotifications
                                           where (
                                               c.ActionType != "Sms")
                                           orderby c.CompletionTime,c.ActionType
                                           select new { c.Type, c.Value, c.Status, c.CompletionTime, c.ContextType };
                var lstSmsNotification = from c in lstNotifications
                                         where
                                             (c.ActionType == "Sms")
                                         orderby c.CreatedAt
                                         select new { c.Type, c.Value, c.Template, c.Status, c.CompletionTime, c.ContextType };



                rptEmailNotification.DataSource = lstEmailNotification;
                rptEmailNotification.DataBind();

                RptSmsNotification.DataSource = lstSmsNotification;
                RptSmsNotification.DataBind();
            }
            else
            {
                rptEmailNotification.DataSource = null;
                rptEmailNotification.DataBind();
                RptSmsNotification.DataSource = null;
                RptSmsNotification.DataBind();
            }
            if (lstPatientVisitDetails !=null && lstPatientVisitDetails.Count > 0)
            {
                hdnPatOrgID.Value = lstPatientVisitDetails[0].OrgID.ToString();
                hdnOrgID.Value = lstPatientVisitDetails[0].OrgID.ToString();
                int PatOrgID = 0;
                Int32.TryParse(hdnPatOrgID.Value, out PatOrgID);
                Int32.TryParse(hdnOrgID.Value, out PatOrgID);
                tdViewRegistration.Style.Add("display", "table-cell");
                li1.Attributes.Add("class", "active");
                tdEpisodeHistory.Style.Add("display", "none");
                li2.Attributes.Remove("class");
                tdsamplefloating.Style.Add("display", "none");
                lblPatientName.Text = lstPatientVisitDetails[0].PatientName.ToString();
                lblExternalPatientNumber.Text = lstPatientVisitDetails[0].ExternalPatientNumber.ToString();     //surya
                lblSpeciesType.Text = lstPatientVisitDetails[0].SpeciesName.ToString();
                lblPreviousLabNumber.Text = lstPatientVisitDetails[0].PreviousLabNumber.ToString();
                lblIsCumulativeReport.Text = lstPatientVisitDetails[0].IsCumulative.ToString();
                lblReportDeliveryMode.Text = lstPatientVisitDetails[0].ReportMode.ToString();
                lblConfidential.Text = lstPatientVisitDetails[0].Confidential.ToString();
                lblReportingCenter.Text = lstPatientVisitDetails[0].ReportingCentername.ToString();
                lbl_Visitnumber.Text = lstPatientVisitDetails[0].VisitNumber.ToString();
                lbl_ExVisitNo.Text = lstPatientVisitDetails[0].ExternalVisitID.ToString();

                String ShowSRFIDandTRFID = GetConfigValue("UseWardnoAsSRFID", OrgID);
                if (ShowSRFIDandTRFID == "Y")
                {
                    
                    tdsrfID.Style.Add("display", "table-cell");
                    tdsrfID1.Style.Add("display", "table-cell");
                    tdtrfID.Style.Add("display", "table-cell");
                    tdtrfID1.Style.Add("display", "table-cell");
                    lblSRFId.Text = lstPatientVisitDetails[0].ResultEntryType.ToString();
                    lblTRFId.Text = lstPatientVisitDetails[0].VisitNotes.ToString();
                }


               
                if (lstPatientVisitDetails[0].Age == null)
                {
                    lstPatientVisitDetails[0].Age = "";
                }
                
                //--Added by vijayalakshmi---//
                string str = lstPatientVisitDetails[0].Age;
                string str1 = lstPatientVisitDetails[0].Sex;
                if (lstPatientVisitDetails.Count > 0)
                {
                    string[] strage = str.Split(' ');
                    if (strage.Length > 1)
                    {
                    if (strage[1] == "Year(s)")
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strYear;
                    }
                    else if (strage[1] == "Month(s)")
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strMonth;
                    }
                    else if (strage[1] == "Day(s)")
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strDay;
                    }
                    else if (strage[1] == "Week(s)")
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strWeek;
                    }
					 else if (strage[1] == "UnKnown")
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strUnknownF;
                    }
                    else
                    {
                        lstPatientVisitDetails[0].Age = strage[0] + " " + strYear;
                        }
                    }
                }
                //---- END---//
                lblAge.Text = lstPatientVisitDetails[0].Age.ToString();
                if (str1 == "Male")
                {
                    lstPatientVisitDetails[0].Sex = strMale;
                }
                else if (str1 == "Female")
                {
                    lstPatientVisitDetails[0].Sex = strFemale;
                }
				else if (str1 == "UnKnown")
                {
                    lstPatientVisitDetails[0].Sex = strUnknownF;
                }
                else if (str1 == "NA")
                {
                    lstPatientVisitDetails[0].Sex = strNA;
                }
                else if (str1 == "")
                {
                    lstPatientVisitDetails[0].Sex = "";
                }
                else
                {
                    lstPatientVisitDetails[0].Sex = strMale;
                }
                lblGender.Text = lstPatientVisitDetails[0].Sex.ToString();
                hdnPatientID.Value = lstPatientVisitDetails[0].PatientID.ToString();
                hdnVisitID.Value = lstPatientVisitDetails[0].PatientVisitID.ToString();
                foreach (PatientInvestigation lstpat in lstPatientInvestigation)
                {
                    if (lstpat.DisplayStatus.ToLower() != strStatus.ToLower ())
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

 if (lstPatientVisitDetails[0].VisitDate.ToString().Contains("1800")&&lstPatientVisitDetails[0].Age.Contains("UnKnown"))
                {
                    lblDOB.Text = strUnknownF; 
                }
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
                    if (lstPatientVisitDetails[0].NurseNotes != null)
                    {
                        lblClientName.Text = lstPatientVisitDetails[0].NurseNotes.ToString();
                    }
                    lblClientName.BackColor = System.Drawing.Color.WhiteSmoke;
                }
                if (lstPatientVisitDetails[0].AccompaniedBy != null)
                {
                    lblClientCode.Text = lstPatientVisitDetails[0].AccompaniedBy.ToString();
                }
                if (lstPatientVisitDetails[0].Country != null)
                {
                    lblClientZone.Text = lstPatientVisitDetails[0].Country.ToString();
                }
                if (lstPatientVisitDetails[0].Address != null)
                {
                    lblClientAddress.Text = lstPatientVisitDetails[0].Address.ToString();
                }
                if (lstPatientVisitDetails[0].MobileNumber != null && lstPatientVisitDetails[0].MobileNumber != "")
                {
                    lblphoneno.Text = lstPatientVisitDetails[0].MobileNumber.ToString();
                }
                if (lstPatientVisitDetails[0].ComplaintDesc != null)
                {
                    lblClientPhNo.Text = lstPatientVisitDetails[0].ComplaintDesc;
                }
                if (lstPatientVisitDetails[0].Param3 != null)
                {
                    lblClientEmail.Text = lstPatientVisitDetails[0].Param3;
                    hdnClientEmail.Value = lstPatientVisitDetails[0].Param3;
                }
                if (HideClientEmailMobile == "Y")
                {
                    if (RoleName == "Lab Manager" || RoleName == "Administrator" )
                    {
                        Rs_Clientphone.Visible = true;
                        lblClientPhNo.Visible = true;
                        Rs_EmailD.Visible = true;
                        lblClientEmail.Visible = true;
                    }
                    else 
                    {
                        Rs_Clientphone.Visible = false;
                        lblClientPhNo.Visible = false;
                        Rs_EmailD.Visible = false;
                        lblClientEmail.Visible = false;
                    }
                }
                if (lstPatientVisitDetails[0].Param4 != null)
                {
                    lblEmailID.Text = lstPatientVisitDetails[0].Param4;
                    hdnPatientEmail.Value = lstPatientVisitDetails[0].Param4;
                }
                if (lstPatientVisitDetails[0].Param6 != null)
                {
                    lblRefDr.Text = lstPatientVisitDetails[0].Param6;
                }
                if (lstPatientVisitDetails[0].Param1 != null)
                {
                    lblSampleCollectedBy.Text = lstPatientVisitDetails[0].Param1.ToString();
                }
                if (lstPatientVisitDetails[0].Param5 != null)
                {
                    lblCollTime.Text = lstPatientVisitDetails[0].Param5.ToString();
                }
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


                //if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
                //{
                //    List<PatientVisitDetails> groupByResult = new List<PatientVisitDetails>();

                //    groupByResult = (from lst in lstPatientVisitDetails
                //                     group lst by
                //                     new
                //                     {
                //                         lst.History,
                //                         lst.Remarks,
                //                         lst.EmergencyPatientTrackerID
                //                     } into grp

                //                     select new PatientVisitDetails
                //                     {
                //                         History = grp.Key.History,
                //                         Remarks = grp.Key.Remarks,
                //                         EmergencyPatientTrackerID = grp.Key.EmergencyPatientTrackerID
                //                     }).Distinct().ToList();

                //    Bckgrd.DataSource = groupByResult;
                //    Bckgrd.DataBind();
                //    history.Visible = true;
                //}
                //else
                //{

                //    string strPatientcapturehistory = GetConfigValue("IsCapturePatientHistory", OrgID);
                //    if (strPatientcapturehistory != "Y")
                //    {
                //        history.Visible = false;
                //    }
                //}
                
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
                //Added by jegan start
                int rdoSelValue = Convert.ToInt32(rdbType.SelectedValue);
                if (rdoSelValue == 2)
                {
                     if (hdnExternalBarcodeSearch.Value == "Y")
                {                    
                    if (hdnVisitNumber.Value != "")
                    {
                        VisitNumber = hdnVisitNumber.Value;
                        BarcodeNumber = "";
                        ContextInfo.AdditionalInfo = null;
                    }
                }
                else
                     {
                    ContextInfo.AdditionalInfo = txtVisitNumber.Text;
                     }
                }
                else
                    {
                    ContextInfo.AdditionalInfo = null;
                    }
                //end

                //For InvestigationValues start

                DemoBL.pGetpatientInvestigationValues(VisitNumber,BarcodeNumber, PatOrgID, ILocationID,  out lstInvestigationValues);
                if (lstInvestigationValues.Count > 0)
                {

                    //condition added by sudha
                    //  gvInvestigationValues.Visible = true;
                    dvAccess.Attributes["style"] = "display:block;";
                    gvInvestigationValues.DataSource = lstInvestigationValues;
                    gvInvestigationValues.DataBind();
			 string chckDevice = GetConfigValue("HideDeviceValue", OrgID);
                    if (!String.IsNullOrEmpty(chckDevice))
                    {
                        String[] rgr1 = chckDevice.Split(',');

                        foreach (String item in rgr1)
                        {
                            if (RoleName == item)
                            {
                                dvAccess.Attributes["style"] = "display:block;";
                            }
                            else
                            {
                                dvAccess.Attributes["style"] = "display:none;";
                            }
                        }
                    }
                }
                //end
                else {
                    dvAccess.Attributes["style"] = "display:none;";
                }

                //added by sudha-tohide the grid for cofidential report
                disableCofidientialReport();

                List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();

                DemoBL.pGetpatientInvestigationForVisit(Convert.ToInt64(hdnVisitID.Value), PatOrgID, ILocationID, gUID, out lstorderInvforVisit);

                if (lstorderInvforVisit.Count > 0)
                {
                    //Added by sudha
                    divGrdInv.Attributes["style"] = "display:block;";
                    if (lstorderInvforVisit[0].ComplaintId == 1)
                    {
                         hdnIsDueBill.Value = "1";
                        Attune.Podium.Common.CLogger.LogWarning("Isduebill111:" + DueBill);
                    }

                    GrdInv.DataSource = lstorderInvforVisit;
                    GrdInv.DataBind();
                    //CheakInv.Style.Add("display", "table");
                    CheakInv.Style.Add("display", "none");
                    if (rdbType.SelectedValue.ToString() == "3")
                    {
                        divGrdInv.Style.Add("display", "none");
                    }
                    else {
                        divGrdInv.Style.Add("display", "block");
                    
                    
                    }
                }
                    //Condition Ended by sudha
                else
                {
                    divGrdInv.Attributes["style"] = "display:none;";
                }

                if (hdnPatientID.Value != "" && hdnVisitID.Value != "")
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
                    // START Added by Jayaramanan L //
                    Patient_BL BL = new Patient_BL(new BaseClass().ContextInfo);
                    List<CapturePatientHistory> lsPatientHistory = new List<CapturePatientHistory>();
                    BL.GetEditPatientHistory(OrgID, visitid, out lsPatientHistory);
                    List<ClientAttributesKeyFields> lstCapturehistory = new List<ClientAttributesKeyFields>();
                    BL.PatientTestHistoryValues(OrgID, visitid, out lstCapturehistory);
                    // END
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
                    if (lstTRF.Count > 0 || lstOutSourceDoc.Count > 0 || (FileName != "" && FileName != null) || lsPatientHistory.Count() > 0 || lstCapturehistory.Count() > 0)
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
                //surya 
                lblExternalPatientNumber.Text = "";
                lblSpeciesType.Text = "";
                lblPreviousLabNumber.Text ="";
                lblIsCumulativeReport.Text = "";
                lblReportDeliveryMode.Text = "";
                lblConfidential.Text = "";
                lblReportingCenter.Text = "";
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('No Matching Records found!');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:ValidationWindow('" + NoRec + "','" + alert + "')", true);
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

            //if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
            //{
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
            //}
            //else
            //{
               // history.Visible = false;
            //}


                string strPatientcapturehistory = GetConfigValue("IsCapturePatientHistory", OrgID);
                if (strPatientcapturehistory != "Y")
                {

                    if ((lstPatientVisitDetails[0].Remarks != "") || (lstPatientVisitDetails[0].History != ""))
                    {
                      //  history.Visible = false;//comment by jegan
                    }
                }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Contact System Amdminstrator", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {

        if (txtVisitNumber.Text.Trim() == defaultText.Trim())
        {
            txtVisitNumber.Text = "";
        }
        PatientDetails();
        modalpopupsendemail.Hide();
        modalPopUp.Hide();
        if (hdnVisitNumber.Value!="")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:GetVisitNumbers();", true);
        }
        
            hdnVisitNumber.Value = "";
         

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

            Label lblCollectedDateTime = e.Row.FindControl("lblCollectedDateTime") as Label;
            string StrCollectedDateTime = lblCollectedDateTime.Text;

            if ((StrCollectedDateTime == "31-12-9999 11:59 PM") || (StrCollectedDateTime == "31/12/9999 23:59:59"))

            {
                lblCollectedDateTime.Text = "";
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
            /* BEGIN | NA | Sabari | 20181202 | Created | HOLD */
            if (lstpatInv.IsReportable != null)
            {
                Label lblReportStatus = e.Row.FindControl("lblReportStatus") as Label;
                //if (lstpatInv.DisplayStatus != "SampleReceived" && lstpatInv.DisplayStatus != "Completed")
                if (lstpatInv.DisplayStatus == "OnHold" || lstpatInv.DisplayStatus == "Approve")
                {
                    if (lstpatInv.IsReportable == true)
                    {
                        lblReportStatus.Text = "Hold";
                    }
                    else if (lstpatInv.IsReportable == false)
                    {
                        lblReportStatus.Text = "Released";
                    }
                }
                else
                {
                    lblReportStatus.Text = "-";
                }
            }

            /* END | NA | Sabari | 20181202 | Created | HOLD */

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

            //added by sudha -For mailsent alert
            Investigation_BL DemoBL;
            int Appval = 0;
            DemoBL = new Investigation_BL(base.ContextInfo);
            int PatOrgID = 0;
            Int32.TryParse(hdnPatOrgID.Value, out PatOrgID);
            string gUID = string.Empty;
            List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();

            DemoBL.pGetpatientInvestigationForVisit(Convert.ToInt64(hdnVisitID.Value), PatOrgID, ILocationID, gUID, out lstorderInvforVisit);



            if (lstorderInvforVisit.Count > 0)
            {
                foreach (OrderedInvestigations lstord in lstorderInvforVisit)
                {
                    if (lstord.Status == "Approve")
                    {
                         Appval = 1;
                    }

                }
            }
            if (Appval == 1)
            {
                //ended by sudha
                hdnSelectedMailButton.Value = "reportviewer";
                if (!string.IsNullOrEmpty(hdnClientEmail.Value))
                {
                    txtMailAddress.Text = hdnClientEmail.Value;
                }
                else
                {
                    txtMailAddress.Text = hdnPatientEmail.Value;
                }
                if (hdnIsDueBill.Value != "1")
                {
                    modalpopupsendemail.Show();
                }
                else
                {

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                                      "key", "alert('Patient having due amount')", true);
                }



            }
            else {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(),
                                       "key", "alert('Mail send only for Approved Tests')", true);
            
            }
        }
        catch (Exception ex)
        {
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Unable to send mail";
            // CLogger.LogError("Error while Sending Mail", ex);
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
            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
            if (SnapshotType == strReport)
            {
                PC.ButtonName = "Send";
                PC.ButtonValue = "Send Mail";
            }
            else if (SnapshotType == strBill)
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
            string Mailsucessfull = SnapshotType + strsucess;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('" + Mailsucessfull + "');", true);
            modalpopupsendemail.Hide();
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Unable to send mail";
            //CLogger.LogError("Error while Sending Mail", ex);
        }

    }

    //   protected void grdAudit_RowDataBound(Object sender, GridViewRowEventArgs e)
    //   {
    //   }
    //protected void grdAudit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdAudit.PageIndex = e.NewPageIndex;
    //    }
    //    btnShow_OnClick(sender, e);
    //}

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
        Int32.TryParse(hdnOrgID.Value, out PatOrgID);
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
            if (hdnExternalBarcodeSearch.Value == "Y")
            {
                if (hdnVisitNumber.Value != "")
                {
                    VisitNumber = hdnVisitNumber.Value;
                    BarcodeNumber = "";
                }
            }
        }
        if (rdbType.SelectedValue == "3")
        {
            if (txtVisitNumber.Text != "")
            {
                CaseNumber = txtVisitNumber.Text;
            }
        }
		if (rdbType.SelectedValue == "4")
        {
            if (hdnVisitNumber.Value != "")
            {
                VisitNumber = hdnVisitNumber.Value;
            }
        }
        if (rdbType.SelectedValue == "5")
        {
            if (hdnVisitNumber.Value != "")
            {
                VisitNumber = hdnVisitNumber.Value; 
                ContextInfo.DepartmentName = "SRFNumber";
            }

        }
        string pOrgDateTime = OrgDateTimeZone;
        // DateTime DT = Convert.ToDateTime(pOrgDateTime);

        returnCode = patientBL.SearchBillOptionDetails("", "01/10/2013", (Convert.ToDateTime(new BasePage().OrgDateTimeZone).Day + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year).ToString(), "", -1, PatOrgID,
            "", "", VisitNumber, BarcodeNumber, CaseNumber,  out billSearch, 10, 1, out totalRows, 0);
        if (returnCode == 0 && billSearch.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = billSearch;
            grdResult.DataBind();

            trBillingDetails.Attributes.Add("display", "table-row");

        }
        else
        {
            trBillingDetails.Attributes.Add("display", "none");
        }
    }
    protected void btnViewreport_Click(object sender, EventArgs e)
    {
        try
        {   //codition added by sudha to hide the report for confidential in ViewReport Button Click

            Investigation_BL InvestigationBL = new Investigation_BL();
            value = InvestigationBL.PGetConfidential(Convert.ToInt64((hdnVisitID.Value).ToString()));
            //Changs done by Alex
            //value = InvestigationBL.PGetConfidential(Convert.ToInt64((txtVisitNumber.Text).ToString()));
            string RoleConfidential = Session["Showconfidential"] != null ? Session["Showconfidential"].ToString() : "";
            if ((value == "Y" && RoleConfidential == "Y") || (value == "N"))
            {
                ShowReport("");
            }
            else
            {
                //Changed By QBITZ Prakash.K
                //  ShowReport("");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alerts", "javascript:alert('You are not allowed To view the patient Report though it has been marked as confidential.')", true);
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
            /*Modified by Arivalagan K for show  hide  header*/
           // BillSearch bs = (BillSearch)e.Row.DataItem;
            strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //         Investigation_BL InvestigationBL = new Investigation_BL();

              
                 BillSearch bs = (BillSearch)e.Row.DataItem;

                if (bs.IsCreditBill == "Y")
                {

                    e.Row.CssClass = "ClientBill";
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
                    e.Row.CssClass = "InvoiceBill";
                    //e.Row.BackColor = System.Drawing.Color.LimeGreen;
                }
                Label btnViewBillRowCommand = (Label)e.Row.FindControl("lblViewBill");
                Label btnMailBillRowCommand = (Label)e.Row.FindControl("lblMailBill");
                Label btnViewBillB2CCommand = (Label)e.Row.FindControl("lblViewBillB2C");
                Label btnViewCompleteBillB2CCommand = (Label)e.Row.FindControl("lblViewCompleteBillB2C");
                Label btnSplit1Command = (Label)e.Row.FindControl("lblSplit1");
                Label btnSplit2Command = (Label)e.Row.FindControl("lblSplit2");
                Label lblvisitnu = (Label)e.Row.FindControl("lblvisitnu");
                //cell_1_Value = lblvisitnu.Text;
                cell_1_Value = e.Row.Cells[3].Text;

                string IsBillValue = string.Empty;
                IsBillValue = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);
                if (IsBillValue == "Y")
                {

                    btnViewCompleteBillB2CCommand.Visible = false;
                }

                //  btnRowCommand.Attributes.Add("onclick", "ChangePaymentModes('" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.PatientNumber + "','" + bs.BillNumber + "','" + OrgID + "','" + bs.ClientID + "','" + bs.Name + "','" + bs.AmountReceived + "');");
                if (bs.IsCoPaymentBill == "Y")
                {
                    //Added by arivalagan.kk foe  copayment color
                    //e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFDDAA");
                    e.Row.CssClass = "CoPaymentBill";
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
                    //if ((bs.Amount > bs.AmountReceived) && (bs.IsCoPaymentBill != "Y" && bs.Status != "Closed") && Convert.ToDecimal(bs.Type) > 0)
                    if (bs.Amount > bs.AmountReceived && bs.IsCoPaymentBill != "Y" && bs.Status == "Open")
                    {
                        e.Row.CssClass = "DueBill";
                        //e.Row.BackColor = System.Drawing.Color.IndianRed;
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
          
            checlconfidential();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in Billing Details RowDataBound", Ex);
        }
    }


    public void checlconfidential()
    {
       
        Investigation_BL InvestigationBL = new Investigation_BL();
        string value = string.Empty;
        if (cell_1_Value != "")
            value = InvestigationBL.PGetConfidentialvisit(Convert.ToInt64(cell_1_Value));
        if (Session["Showconfidential"].ToString() == "N" && value == "Y")
        {
            btnViewReport.Enabled = false;
            btnSendMailReport.Enabled = false;
            btnTrendReport.Enabled = false;
        }
        else
        {
            btnViewReport.Enabled = true;
            btnSendMailReport.Enabled = true;
            btnTrendReport.Enabled = true;
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            // long returncode = -1;
            long FinalBillID = -1;
            int rowIndex = -1;
            rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow grow = grdResult.Rows[rowIndex];
            FinalBillID = Convert.ToInt64(grdResult.DataKeys[rowIndex][0].ToString());
            hdnFinalBillID.Value = FinalBillID.ToString();
            string IsBillValue = string.Empty;
            IsBillValue = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);

            //Added by Thamilselvan.....
            string MemberCardNo = "";
            try
            {
                MemberCardNo = grdResult.DataKeys[rowIndex]["MembershipCardNo"].ToString();
            }
            catch { }

            if (e.CommandName == "ViewBill")
            {
                if (strSsrsShowReport == "Y")
                {
                    hdnSnapshotType.Value = "Bill";
                    btnViewreport_Click(sender, e);
                }
                if (IsBillValue == "Y")
                {
                    modalPopUp.Show();
                    //ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid=" + hdnVisitID.Value + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + hdnFinalBillID.Value + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y";
                    ifPDF.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                }
                else
                {
                    modalPopUp.Show();
                    ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid=" + hdnVisitID.Value + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + hdnFinalBillID.Value + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y";
                }


            }
            else if (e.CommandName == "MailBill")
            {
                hdnSnapshotType.Value = "Bill";
                btnSendMail_Click(sender, e);
            }
            else if (e.CommandName == "ViewB2CBill" && strSsrsShowReport != "Y")//added by Thamilselvan R...for Changing same as Billing...)
            {
                modalPopUp.Show();   
                if(IsBillValue=="Y")
                    ifPDF.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                else
                   ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid=" + hdnVisitID.Value + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + hdnFinalBillID.Value + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y";
                   //ifPDF.Attributes["src"]="..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
            }
            else if (e.CommandName == "ViewB2CBill" && strSsrsShowReport == "Y")//added by Thamilselvan R...for Changing same as Billing...)
            {
                hdnIsCompleteBill.Value = "";//Added by Thamilselvan for Full Bill
                CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                hdnTargetCtlMailReport1.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
                modalpopupsendemails.Show();//added by Thamilselvan R...for Changing same as Billing...
            }
            //else if (e.CommandName == "ViewB2CBill" && MemberCardNo != "")
            //{
            //    hdnIsCompleteBill.Value = "";//Added by Thamilselvan for Full Bill
            //    CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
            //    hdnTargetCtlMailReport1.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
            //    modalpopupsendemails.Show();//added by Thamilselvan R...for Changing same as Billing...

             //}
            else if (e.CommandName == "ViewB2CCompleteBill" && strSsrsShowReport != "Y")
            {
                  modalPopUp.Show();
                if (IsBillValue == "Y")
                    ifPDF.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
           
                else
                    ifPDF.Attributes["src"] = "ViewPrintPage.aspx?vid=" + hdnVisitID.Value + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + hdnFinalBillID.Value + "&pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y";
            }
            else if (e.CommandName == "ViewB2CCompleteBill" && strSsrsShowReport == "Y")
            {
                CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + hdnVisitID.Value + "&finalBillID=" + hdnFinalBillID.Value + "&actionType=POPUP&type=printreport&isFullBill=Y&invstatus=approve" + "&#toolbar=0&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                hdnTargetCtlMailReport1.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
                modalpopupsendemails.Show();//added by Thamilselvan R...for Changing same as Billing...
                hdnIsCompleteBill.Value = "Y";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Client Attributes.", ex);
        }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    //public void btnShow_OnClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        string ExternalVisitID = string.Empty;
    //        string ExternalBarcode = string.Empty;
    //        int Orgid = OrgID;
    //        if (rdbType.SelectedValue == "1")
    //        {
    //            if (txtVisitNumber.Text != "")
    //            {
    //                ExternalVisitID = txtVisitNumber.Text;
    //            }
    //        }
    //        if (rdbType.SelectedValue == "2")
    //        {
    //            if (txtVisitNumber.Text != "")
    //            {
    //                ExternalBarcode = txtVisitNumber.Text;
    //            }
    //        }
    //        List<AuditTrailReport> lstAuditTrailReport = new List<AuditTrailReport>();
    //        NewReports_BL objBL = new NewReports_BL(base.ContextInfo);
    //        returnCode = objBL.GetAuditTrailReport(ExternalVisitID, ExternalBarcode, Orgid, out lstAuditTrailReport);
    //        if (lstAuditTrailReport.Count > 0)
    //        {
    //            grdAudit.DataSource = lstAuditTrailReport;
    //            grdAudit.DataBind();
    //            tdViewRegistration.Style.Add("display", "none");
    //            li1.Attributes.Remove("class");
    //            tdEpisodeHistory.Style.Add("display", "block");
    //            li2.Attributes.Add("class", "active");
    //        }
    //        else
    //        {
    //            grdAudit.DataSource = null;
    //            grdAudit.DataBind();
    //            tdViewRegistration.Style.Add("display", "none");
    //            li1.Attributes.Remove("class");
    //            tdEpisodeHistory.Style.Add("display", "block");
    //            li2.Attributes.Add("class", "active");
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While get Values on btnSearch_OnClick", ex);
    //    }

    //}

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

    protected void lnkCommContent_Click(object sender, EventArgs e)
    {

    }

    protected void btnCommunication_Click(object sender, EventArgs e)
    {

        try
        {
            bool flag = true;
            CommThread1.ViewDetailCommunicationPatientListlist(txtVisitNumber.Text.ToString(), "", out flag);
            if (flag)
            {
                tdViewRegistration.Style.Add("display", "none");
                tdEpisodeHistory.Style.Add("display", "none");
                li1.Attributes.Remove("class");
                li2.Attributes.Remove("class");
                tdCommunication.Style.Add("display", "table-cell");
                li3.Attributes.Add("class", "active");
                CID = 2;
            }
            else
            {
                li1.Attributes.Add("class", "active");
                li3.Attributes.Remove("class");
                li2.Attributes.Remove("class");
                tdViewRegistration.Style.Add("display", "table-cell");
                tdEpisodeHistory.Style.Add("display", "none");
                tdCommunication.Style.Add("display", "none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('Please enter correct Visit number.');", true);

            }



            //long returnCode = -1;
            //string ExternalVisitID = string.Empty;
            //string ExternalBarcode = string.Empty;
            //int Orgid = OrgID;
            //if (rdbType.SelectedValue == "1")
            //{
            //    if (txtVisitNumber.Text != "")
            //    {
            //        ExternalVisitID = txtVisitNumber.Text;
            //    }
            //}
            //if (rdbType.SelectedValue == "2")
            //{
            //    if (txtVisitNumber.Text != "")
            //    {
            //        ExternalBarcode = txtVisitNumber.Text;
            //    }
            //}

            //List<NBCommunicationDetails> listCommunication = new List<NBCommunicationDetails>();
            //Communication_BL comBL = new Communication_BL(base.ContextInfo);
            //returnCode = comBL.GetCommuicationvisitDetails(ExternalVisitID, ExternalBarcode, Orgid, out listCommunication);
            //if (listCommunication.Count > 0)
            //{
            //    grdViewCommunication.DataSource = listCommunication;
            //    grdViewCommunication.DataBind();
            //    tdViewRegistration.Style.Add("display", "none");
            //    tdEpisodeHistory.Style.Add("display", "none");
            //    li1.Attributes.Remove("class");
            //    tdCommunication.Style.Add("display", "block");

            //    li3.Attributes.Add("class", "active");
            //}
            //else
            //{
            //    grdViewCommunication.DataSource = null;
            //    grdViewCommunication.DataBind();
            //    tdViewRegistration.Style.Add("display", "none");
            //    li1.Attributes.Remove("class");
            //    tdEpisodeHistory.Style.Add("display", "none");
            //    tdCommunication.Style.Add("display", "block");
            //    li3.Attributes.Add("class", "active");
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While get Values on btnSearch_OnClick", ex);
        }
    }
    //Added by Thamilselvan R to disable the IFrame source....
    protected void btn_DisableIframSRC(object sender, EventArgs e)
    {
        CouponCardBillFrame.Attributes["src"] = "";
        hdnIsCompleteBill.Value = "";
    }


    //Added By QBITZ Prakash.K
    private void ShowReport(string ReportType)
    {
        try
        {
            Attune.Podium.Common.CLogger.LogWarning("Isduebill:" + DueBill);
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
                Int64.TryParse(hdnFinalBillID.Value, out pVisitID);
            }
            returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true, ReportType, out lstReportSnapshot);
            if (lstReportSnapshot.Count > 0)
            {
                if (System.IO.File.Exists(lstReportSnapshot[0].ReportPath))
                {
                    PDFPath = lstReportSnapshot[0].ReportPath;
                }
            }
            if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
            {
                string _ShowToolBar = "1";
                if (hdnIsDueBill.Value == "1")
                {
                    _ShowToolBar = "0";
                }

                string CurrentOrgID = OrgID.ToString();
                string filePath = PDFPath;
                modalPopUp.Show();
                //command by amar 02-feb-2018
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "javascript:alert('" + _ShowToolBar + "');", true);
                //command by amar 02-feb-2018
                // ifPDF.Attributes["src"] = "ReportPdf1.aspx?pdf=" + filePath + "#toolbar=" + _ShowToolBar;
                ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath + "#toolbar=" + _ShowToolBar);
            }
            else
            {
                modalPopUp.Hide();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('Report is not ready','Alert');", true);
            }
        }
            catch (Exception ex)
        {
            CLogger.LogError("Error While get ShowReport Method", ex);
        }
        }
    //Added By QBITZ Prakash.K
    protected void btnViewCumulativeReport_Click(object sender, EventArgs e)
    {
        try
        {           
            ShowReport("Cumulative");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Getting while cliecking btnViewCumulativeReport_Click - Cumulative Report, PDF", ex);
        }
    }
    //Added By QBITZ Prakash.K
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "NotificationReportType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {



                var childItemsNotificationReportType = from child in lstmetadataOutput
                                                       where child.Domain == "NotificationReportType"
                                                       orderby child.DisplayText descending
                                                       select child;
                if (childItemsNotificationReportType.Count() > 0)
                {

                    ddlReportType.DataSource = childItemsNotificationReportType;
                    ddlReportType.DataTextField = "DisplayText";
                    ddlReportType.DataValueField = "Code";
                    ddlReportType.DataBind();
                    ddlReportType.Items.Insert(0, "--Select--");
                    ddlReportType.Items[0].Value = "0";
                    ddlReportType.SelectedValue = "0";
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
            //edisp.Visible = true;

        }

    }

    //Added by Jegan start
    private void ManualReportStatus()
    {
        try
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PageContextDetails.ButtonName = "btnSaveToDispatch";
            PageContextDetails.ButtonValue = "Generate Report";           
            PC.RoleID = Convert.ToInt64(RoleID);          
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
            lstpagecontextkeys.Add(PC);
            long res = -1;         
            res = AM.GetManualReportAction(PC);
            if (res >= 0)
                btnManualReport.Visible = true;
            else
                btnManualReport.Visible = false;
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  Clicking  ManualReportStatus Method in Investigation Report", ex);

        }
    }
    //end

    //Added By QBITZ Prakash.K
    protected void btnGenerateReportManual_Click(object sender, EventArgs e)
    {
        try
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PageContextDetails.ButtonName = ((Button)sender).ID;

            PageContextDetails.ButtonValue = ((Button)sender).Text;
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            if (string.IsNullOrEmpty(hdnVisitID.Value)!=true)
                PC.PatientVisitID = Convert.ToInt64(hdnVisitID.Value);
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
            lstpagecontextkeys.Add(PC);
            long res = -1;
            string strReportType = string.Empty;
            string strAccessionNumber = string.Empty;
            strReportType = ddlReportType.SelectedItem.Text;
            strAccessionNumber = hdnAccessionNumber.Value;
            res = AM.PerformingNextStepNotificationManual(PC, "", "", strReportType, strAccessionNumber.TrimEnd(','));
            if (Request.QueryString["VisitNumber"] != null && Request.QueryString["VisitNumber"] != "")
            {
                txtVisitNumber.Text = Request.QueryString["VisitNumber"];
               
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
                btnGo_Click(sender, e);
                btncancel.Attributes.Add("style", "display:none");

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  Clicking  btnGenerateReportManual_Click Method in Investigation Report", ex);

        }
    }
    //Added By QBITZ Prakash.K
    protected void btnManualReport_Click(object sender, EventArgs e)
    {
        try
        {


            string invStatus = string.Empty;

            invStatus = InvStatus.Completed.ToLower() + "," + InvStatus.Validate.ToLower() + "," + InvStatus.Approved.ToLower() + "," + InvStatus.SecondOpinion.ToLower() + ",Co-authorize";

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ShowReportPreviewForAll('" + hdnVisitID.Value + "','" + RoleID + "','" + invStatus + "','','" + OrgID.ToString() + "',true,false);", true);
           
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Getting while clicking btnManualReport_Click - Manual Report", ex);
        }
    }
}
