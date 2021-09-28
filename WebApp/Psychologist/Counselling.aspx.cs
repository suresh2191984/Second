using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.SmartAccessor;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Psychologist_Counselling : BasePage
{
    public int complaintID = 0;
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVisitID = 0;
    bool blDig = true;
    bool blInves = true;
    long createdBy = -1;
    long specialityID;
    Control myControl = null;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();        
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();    
    List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<DHEBAdder> lstdhebDiagnosis = new List<DHEBAdder>();

    protected void Page_Load(object sender, EventArgs e)
    {
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;
        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");
        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath;
        sPath = sPath + "/fckeditor/";
        fckCounselling.BasePath = sPath;
        fckCounselling.ToolbarSet = "Attune";
        fckCounselling.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        fckCounselling.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["sid"], out specialityID);
        ComplaintICDCode1.ComplaintHeader = "Diagnosis";        
        if (!IsPostBack)
        {
            try
            {
                //btnGridView.Style.Add("display", "none");  
                cPD.Checked = true;
                LoadCounselType();
                LoadCounsellingDetails();                                             
                patientHeader.PatientVisitID = visitID;                
                #region Load Counselling History
                Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
                List<CounsellingDetails> lstCounsellingDetails = new List<CounsellingDetails>();
                if (Request.QueryString["pvid"] != null)
                {                    
                    Int64.TryParse(Request.QueryString["vid"], out visitID);                    
                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                    CounsellingBL.GetPreviousVisitdetails(patientID, visitID, out lstCounsellingDetails);
                }
                else
                {
                    CounsellingBL.GetPreviousVisitdetails(patientID, visitID, out lstCounsellingDetails);
                }
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "show", "javascript:show();", true);
                grdView.Visible = true;
                grdView.DataSource = lstCounsellingDetails;
                grdView.DataBind();
                #endregion

                #region load Exam
                tcEMR.ActiveTab = tpHistory;
                returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin, out lstExam, out lstAttribute);
                List<Patient> lstPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                Patient patient = new Patient();
                patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                hdnSex.Value = lstPatient[0].SEX;

                if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null)
                {
                    PatientVitalsControl.VisitID = visitID;
                    if (lstVitalsUOMJoin.Count > 0)
                    {
                        PatientVitalsControl.LoadControls("U", patientID);
                    }
                    else
                    {
                        PatientVitalsControl.LoadControls("I", patientID);
                    } 
                }
                #endregion

                #region Load ICDCode
                if (Request.QueryString["pvid"] != null)
                {
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                    Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                    Int32.TryParse(Request.QueryString["id"], out complaintID);

                    new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(previousVisitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
                }
                else
                {
                    new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(visitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
                }

                if (!IsPostBack)
                {
                    if (lstPatientComplaint.Count > 0)
                    {
                        if (lstPatientComplaint[0].ComplaintName != "N/A")
                        {
                            ComplaintICDCode1.ComplaintHeader = "Diagnosis";
                            ComplaintICDCode1.SetPatientComplaint(lstPatientComplaint);
                        }
                    }
                    uGAdv.setGeneralAdvice(lstPatientAdvice);
                    if (lstPatientVisit.Count > 0)
                    {
                        uMiscellaneous.LoadAdmissionAndNextReview(visitID);
                    }
                }
                #endregion

                #region Load History
                ucHistory.LoadHistoryData(visitID);
                ucHistory.EditHistoryData(visitID);
                #endregion
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }
        }
        else
        {
            blDig = false;
            blInves = false;
        }
        //if (hdnButtonClick.Value == "1")
        //{
        //    long tVisitID = Convert.ToInt64(hdnVisitID.Value);
        //    OPCaseSheet1.LoadPatientDetails(tVisitID, 0);
        //}
        
    }
    
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnEMRExam_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientExaminationPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityID + "&emr=" + "EXM", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }
    
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }

    public void LoadCounselType()
    {
        long returnCode = -1;
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<CounsellingName> lstCounsellingName = new List<CounsellingName>();
        try
        {
            returnCode = CounsellingBL.GetCounselType(out lstCounsellingName);
            ddlCouselType.Visible = true;
            ddlCouselType.DataSource = lstCounsellingName.FindAll(P => P.SpecialityID == 51).ToList();
            ddlCouselType.DataTextField = "CounselType";
            ddlCouselType.DataValueField = "CounselID";
            ddlCouselType.DataBind();
            ddlCouselType.Items.Insert(0, "---------------Select----------------");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Counselling Type", ex);
        }
    }
    public void LoadCounsellingDetails()
    {
        long returnCode = -1;
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<CounsellingDetails> lstCounsellingDetails = new List<CounsellingDetails>();
        try
        {
            returnCode = CounsellingBL.GetCounsellingDetails(patientID, visitID, out lstCounsellingDetails);
            for (int i = 0; i < lstCounsellingDetails.Count; i++)
            {
                ddlCouselType.SelectedValue = lstCounsellingDetails[i].CounselID.ToString();
                fckCounselling.Value = lstCounsellingDetails[i].Symptoms.ToString();
                if (lstCounsellingDetails[i].IsConfidential.ToString() == "Y")
                {
                    chkHistory.Checked = true;
                }
                else
                {
                    chkHistory.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Counselling Details,Counselling.aspx.cs_LoadCounsellingDetails()", ex);
        }
    }
    
    protected void btnsave_Click(object sender, EventArgs e)
    {
        #region Counselling Save        
        try
        {
            long returnCode = -1;
            Counselling_BL objCounsellingBL = new Counselling_BL(base.ContextInfo);
            PatientCounselling objPatientCounselling = new PatientCounselling();
            objPatientCounselling.PatientID = patientID;
            objPatientCounselling.VisitID = visitID;
            objPatientCounselling.CounselID = Convert.ToInt32(ddlCouselType.SelectedValue);
            objPatientCounselling.Symptoms = fckCounselling.Value;
            string chkhstProv=string.Empty;
            if (chkHistory.Checked == true)
            {
                chkhstProv = "Y";
            }
            else
            {
                chkhstProv = "N";
            }
            objPatientCounselling.IsConfidential = chkhstProv;
            returnCode = objCounsellingBL.SavePatientCounselling(objPatientCounselling);
            if (returnCode > 0)
            {
                #region Save ICDCode 
                long returncode = -1;
                    List<PatientComplaint> lstdhebDiagnosis = new List<PatientComplaint>();
                    PatientComplaint ObjPatientComplaint = new PatientComplaint();
                    Uri_BL uriBL = new Uri_BL(base.ContextInfo);
                    List<PatientHistory> lstdhebHistory = new List<PatientHistory>();
                    List<PatientExamination> lstdhebExamination = new List<PatientExamination>();
                    List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
                    List<DrugDetails> lstdrugs = new List<DrugDetails>();
                    ComplaintICDCode1.DefaultComplaintID = "NO";
                    ComplaintICDCode1.ComplaintID = -1;
                    string chkProv = string.Empty;
                    if (cPD.Checked == true)
                    {
                        chkProv = "Y";
                    }
                    else
                    {
                        chkProv = "N";
                    }
                    lstdhebDiagnosis = ComplaintICDCode1.SavePatientComplaint("QIC", visitID, chkProv);
                    lstPatientAdvice = uGAdv.GetGeneralAdvice(visitID);
                    lstPatientVisit = uMiscellaneous.GetAdmitAndNextReview();
                    string admitSuggest = lstPatientVisit[0].AdmissionSuggested;
                    string nextReviewDate = lstPatientVisit[0].NextReviewDate;
                    string physicihancomments = string.Empty;
                    int pOrderedInvCnt = 0;
                    string gUID = Guid.NewGuid().ToString();
                    returncode = uriBL.SaveUnFoundDiagnosisData(-1, admitSuggest, patientID, nextReviewDate, visitID, lstdhebDiagnosis,
                                    lstdhebHistory, lstdhebExamination,
                                    orderedInvesHL, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt, "pending", gUID, physicihancomments);
                #endregion

                #region History Save
                ucHistory.SaveData();
                #endregion

                #region PatientVitals Save
                    PatientVitalsControl.GetPageValues(out lstPatientVitals);
                    returnCode = new SmartAccessor(base.ContextInfo).InsertExaminationPKG(visitID, patientID, LID, OrgID, lstPatientVitals);
                #endregion 
 
                #region Complete Task
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, createdBy);
                #endregion

                #region Check Referral And Redirect
                    createdBy = LID;
                    bool checkbx = uMiscellaneous.GetValue();   
                    if (taskID != null && taskID != 0)
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                        Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                        Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityID);
                        if (checkbx == true)
                        {
                            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                            Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityID);
                            Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&sid=" + specialityID + "&ftype=CON" + "&oC=COUN", true);
                        }
                        else
                        {
                            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                            Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityID);
                            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                            Response.Redirect(@"../Psychologist/PrintViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityID + "&pSex=" + hdnSex.Value + "&Show=Y" + "", true);
                        }
                    }
                    else
                    {
                        if (checkbx == true)
                        {
                            taskID = 0;
                            Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&sid=" + specialityID  + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=COUN", true);

                        }
                        else
                        {
                            taskID = 0;
                            Response.Redirect(@"../Psychologist/PrintViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityID + "&pSex=" + hdnSex.Value + "&Show=Y" + "", true);
                        }
                    }
                #endregion
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Counselling Type", ex);
        }
        #endregion 

        
    }
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        Response.Redirect("../Psychologist/Home.aspx");
    }
    protected void grdView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                taskID = 0;
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnVisitID.Value = Convert.ToString(grdView.DataKeys[RowIndex][0]);
                visitID = Convert.ToInt64(hdnVisitID.Value);
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityID);
                string strPath = "../Psychologist/ViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityID + "&IsPopup=Y" + "&pSex=" + hdnSex.Value + "&Show=Y" + "";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showCaseSheet('" + strPath + "');", true);     
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Drug Details to Update", ex);
        }
    }
    protected void grdView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdView, "Select$" + e.Row.RowIndex));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Row Bound in Counselling Visit", ex);
        }
    }

    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdView.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdView.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }

    protected void grdView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<CounsellingDetails> lstCounsellingDetails = new List<CounsellingDetails>();
        if (e.NewPageIndex != -1)
        {
            grdView.PageIndex = e.NewPageIndex;
            int pageIndex = e.NewPageIndex + 1;
            if (pageIndex == 0)
            {
                
            }
            CounsellingBL.GetPreviousVisitdetails(patientID, visitID, out lstCounsellingDetails);
            if (lstCounsellingDetails.Count > 0)
            {
                grdView.Visible = true;
                grdView.DataSource = lstCounsellingDetails;
                grdView.DataBind();
            }
        }
    } 
}
