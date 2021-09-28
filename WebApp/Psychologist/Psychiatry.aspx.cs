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
using System.Xml;
using Attune.Podium.SmartAccessor;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Psychologist_Psychiatry : BasePage
{
    public int complaintID = 0;
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    long specialityid;
    long previousVisitID = 0;
    bool blDig = true;
    bool blInves = true;
    long createdBy = -1;
    Control myControl = null;
    string InvDrugData = string.Empty;
    long LastVisitID = -1;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
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
        sPath = Request.ApplicationPath ;
        sPath = sPath + "/fckeditor/";
        fckCounselling.BasePath = sPath;
        fckCounselling.ToolbarSet = "Attune";
        fckCounselling.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        fckCounselling.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        if (Request.QueryString["LastVisit"] == null || Request.QueryString["LastVisit"] == "N")
        {
            long retnCode = -1;
            Counselling_BL objCounsellingBL = new Counselling_BL(base.ContextInfo);
            retnCode = objCounsellingBL.GetLastVisitID(patientID, OrgID, out LastVisitID);
            if (LastVisitID <= 0)
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                LastVisitID = visitID;
            }
        }
        else
        {
            if (Request.QueryString["pvid"] != null)
            {
                Int64.TryParse(Request.QueryString["pvid"], out visitID);
            }
            else
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
            }
        }
        if (Request.QueryString["tid"] != null)
        {
            Int64.TryParse(Request.QueryString["tid"], out taskID);
        }
        else
        {
            taskID = 0;
        }

        ComplaintICDCode1.ComplaintHeader = "Diagnosis";
        if (!IsPostBack)
        {
            try
            {
                cPD.Checked = true;
                LoadCounselType();
                LoadReview();
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
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                    CounsellingBL.GetPreviousVisitdetails(patientID, visitID, out lstCounsellingDetails);
                }
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "show", "javascript:show();", true);
                grdView.Visible = true;
                grdView.DataSource = lstCounsellingDetails;
                grdView.DataBind();
                #endregion

                #region load Exam
                tcEMR.ActiveTab = tpHistory;
                if (Request.QueryString["LastVisit"] == null || Request.QueryString["LastVisit"] == "N")
                {
                    visitID = LastVisitID;
                }
                else
                {
                    if (Request.QueryString["pvid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["pvid"], out visitID);
                    }
                    else
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                    }
                }
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
                if (Request.QueryString["LastVisit"] == null || Request.QueryString["LastVisit"] == "N")
                {
                    visitID = LastVisitID;
                }
                else
                {
                    if (Request.QueryString["pvid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["pvid"], out visitID);
                    }
                    else
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                    }
                }
 
                new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(visitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
                

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
                if (Request.QueryString["LastVisit"] == null || Request.QueryString["LastVisit"] == "N")
                {
                    visitID = LastVisitID;
                }
                else
                {
                    if (Request.QueryString["pvid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["pvid"], out visitID);
                    }
                    else
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                    }
                }
                ucHistory.LoadHistoryData(visitID);
                ucHistory.EditHistoryData(visitID);
                #endregion
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }
        }

    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
            }
            else
            {
                taskID = 0;
            }
            Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID, true);
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
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
            }
            else
            {
                taskID = 0;
            }
            Response.Redirect(@"../Patient/PatientExaminationPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "EXM", true);
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
            Response.Redirect(Request.ApplicationPath  + path, true);

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

    public void LoadCounselType()
    {
        long returnCode = -1;
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<CounsellingName> lstCounsellingName = new List<CounsellingName>();
        try
        {
            returnCode = CounsellingBL.GetCounselType(out lstCounsellingName);
            ddlCouselType.Visible = true;
            ddlCouselType.DataSource = lstCounsellingName.FindAll(P => P.SpecialityID == 9).ToList(); ;
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
    public void LoadReview()
    {
        long returnCode = -1;
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<PsychiatricReview> lstPsychiatricReview = new List<PsychiatricReview>();
        try
        {
            returnCode = CounsellingBL.GetPsychiatricReview(out lstPsychiatricReview);
            chkreview.Visible = true;
            chkreview.DataSource = lstPsychiatricReview;
            chkreview.DataTextField = "ReviewName";
            chkreview.DataValueField = "ReviewId";
            chkreview.DataBind();
            chkreview.Text = "<table><tr>";
            foreach (ListItem item in chkreview.Items)
            {
                item.Text ="<td>" + item.Text + "</td><td><input type='text' style='font-family:Tahoma;width:250px;' name='" + item.Text + "' id='txt" +
                    item.Value + "' runat='server' /></td></tr><tr>";
            }
            chkreview.Text = "</table>";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Review", ex);
        }
    }
    public void LoadCounsellingDetails()
    {
        long returnCode = -1;
        Counselling_BL CounsellingBL = new Counselling_BL(base.ContextInfo);
        List<CounsellingDetails> lstCounsellingDetails = new List<CounsellingDetails>();
        try
        {
            string hdnReview = string.Empty;
            string hdnExam = string.Empty;            
            if (Request.QueryString["LastVisit"] == null || Request.QueryString["LastVisit"] == "N")
            {
                visitID = LastVisitID;
            }
            else
            {
                if (Request.QueryString["pvid"] != null)
                {
                    Int64.TryParse(Request.QueryString["pvid"], out visitID);
                }
                else
                {
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                }
            }
            if (visitID > 0)
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

                    string review = lstCounsellingDetails[i].ReviewOfSystem;
                    string examnation = lstCounsellingDetails[i].Examination;
                    if (review != string.Empty)
                    {
                        hdnReview = ReviewString(review);
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "loadreview('" + hdnReview + "');", true);
                    }
                    if (examnation != string.Empty)
                    {
                        hdnExam = ExaminationString(examnation);
                        #region Appearance
                        string app = hdnExam.Split('^')[0];
                        if (app != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (app.Split('~')[0] != string.Empty)
                            {
                                header = app.Split('*')[0];
                                confi = app.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkAppearance.Checked = false;
                            }
                            else
                            {
                                EchkAppearance.Checked = true;
                            }
                            value = app.Split('~')[1].Split('=')[1];
                            txtPosture.Text = value;
                            value = app.Split('~')[2].Split('=')[1];
                            txtRace.Text = value;
                            value = app.Split('~')[3].Split('=')[1];
                            txtAttitude.Text = value;
                            value = app.Split('~')[4].Split('=')[1];
                            txtEthnicity.Text = value;

                        }
                        #endregion

                        #region Attitude
                        string att = hdnExam.Split('^')[1];
                        if (att != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (app.Split('~')[0] != string.Empty)
                            {
                                header = att.Split('*')[0];
                                confi = att.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkAttitude.Checked = false;
                            }
                            else
                            {
                                EchkAttitude.Checked = true;
                            }
                            value = att.Split('~')[1].Split('=')[1];
                            txtAttitudeE.Text = value;
                        }
                        #endregion

                        #region Mood
                        string mood = hdnExam.Split('^')[2];
                        if (mood != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (mood.Split('~')[0] != string.Empty)
                            {
                                header = mood.Split('*')[0];
                                confi = mood.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkMood.Checked = false;
                            }
                            else
                            {
                                EchkMood.Checked = true;
                            }
                            value = mood.Split('~')[1].Split('=')[1];
                            EtxtMood.Value = value;
                        }
                        #endregion

                        #region Affect
                        string aff = hdnExam.Split('^')[3];
                        if (aff != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (aff.Split('~')[0] != string.Empty)
                            {
                                header = aff.Split('*')[0];
                                confi = aff.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkAffect.Checked = false;
                            }
                            else
                            {
                                EchkAffect.Checked = true;
                            }
                            value = aff.Split('~')[1].Split('=')[1];
                            EtxtAffect.Value = value;
                        }
                        #endregion

                        #region Speech
                        string spe = hdnExam.Split('^')[4];
                        if (spe != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (spe.Split('~')[0] != string.Empty)
                            {
                                header = spe.Split('*')[0];
                                confi = spe.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkSpeech.Checked = false;
                            }
                            else
                            {
                                EchkSpeech.Checked = true;
                            }
                            value = spe.Split('~')[1].Split('=')[1];
                            txtQuality.Text = value;
                            value = spe.Split('~')[2].Split('=')[1];
                            txtRate.Text = value;
                            value = spe.Split('~')[3].Split('=')[1];
                            txtVolume.Text = value;
                            value = spe.Split('~')[4].Split('=')[1];
                            txtCoOrdination.Text = value;

                        }
                        #endregion

                        #region Thought Process
                        string thp = hdnExam.Split('^')[5];
                        if (thp != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (thp.Split('~')[0] != string.Empty)
                            {
                                header = thp.Split('*')[0];
                                confi = thp.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkThought.Checked = false;
                            }
                            else
                            {
                                EchkThought.Checked = true;
                            }
                            value = thp.Split('~')[1].Split('=')[1];
                            EtxtThought.Value = value;
                        }
                        #endregion

                        #region Thought Content
                        string thc = hdnExam.Split('^')[6];
                        if (thc != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (thc.Split('~')[0] != string.Empty)
                            {
                                header = thc.Split('*')[0];
                                confi = thc.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkThoughtcontent.Checked = false;
                            }
                            else
                            {
                                EchkThoughtcontent.Checked = true;
                            }
                            value = thc.Split('~')[1].Split('=')[1];
                            txtObessions.Text = value;
                            value = thc.Split('~')[2].Split('=')[1];
                            txtPhobias.Text = value;
                            value = thc.Split('~')[3].Split('=')[1];
                            txtConsciousness.Text = value;
                            value = thc.Split('~')[4].Split('=')[1];
                            txtOrientation.Text = value;
                            value = thc.Split('~')[5].Split('=')[1];
                            txtSensorium.Text = value;
                            value = thc.Split('~')[6].Split('=')[1];
                            txtSuicidal.Text = value;
                            value = thc.Split('~')[7].Split('=')[1];
                            txtMemory.Text = value;
                            value = thc.Split('~')[8].Split('=')[1];
                            txtAbstractness.Text = value;
                        }
                        #endregion

                        #region Perceptual
                        string per = hdnExam.Split('^')[7];
                        if (per != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (per.Split('~')[0] != string.Empty)
                            {
                                header = per.Split('*')[0];
                                confi = per.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkPerceptual.Checked = false;
                            }
                            else
                            {
                                EchkPerceptual.Checked = true;
                            }
                            value = per.Split('~')[1].Split('=')[1];
                            txtHallucinations.Text = value;
                            value = per.Split('~')[2].Split('=')[1];
                            txtIllusions.Text = value;
                        }
                        #endregion

                        #region Insight
                        string ins = hdnExam.Split('^')[8];
                        if (ins != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (ins.Split('~')[0] != string.Empty)
                            {
                                header = ins.Split('*')[0];
                                confi = ins.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkInsight.Checked = false;
                            }
                            else
                            {
                                EchkInsight.Checked = true;
                            }

                            value = ins.Split('~')[1].Split('=')[1];
                            EtxtInsight.Value = value;
                        }
                        #endregion

                        #region Judgement
                        string jud = hdnExam.Split('^')[9];
                        if (jud != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (jud.Split('~')[0] != string.Empty)
                            {
                                header = jud.Split('*')[0];
                                confi = jud.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkJudgement.Checked = false;
                            }
                            else
                            {
                                EchkJudgement.Checked = true;
                            }
                            value = jud.Split('~')[1].Split('=')[1];
                            EtxtJudgement.Text = value;
                        }
                        #endregion

                        #region Impulsivity
                        string imp = hdnExam.Split('^')[10];
                        if (imp != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (imp.Split('~')[0] != string.Empty)
                            {
                                header = imp.Split('*')[0];
                                confi = imp.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkImpulsivity.Checked = false;
                            }
                            else
                            {
                                EchkImpulsivity.Checked = true;
                            }
                            value = imp.Split('~')[1].Split('=')[1];
                            EtxtImpulsivity.Text = value;
                        }
                        #endregion

                        #region Reliability
                        string rel = hdnExam.Split('^')[11];
                        if (rel != string.Empty)
                        {
                            string confi = string.Empty;
                            string header = string.Empty;
                            string name = string.Empty;
                            string value = string.Empty;

                            if (rel.Split('~')[0] != string.Empty)
                            {
                                header = rel.Split('*')[0];
                                confi = rel.Split('~')[0].Split('=')[1];
                            }
                            if (confi == "N")
                            {
                                EchkReliability.Checked = false;
                            }
                            else
                            {
                                EchkReliability.Checked = true;
                            }
                            value = rel.Split('~')[1].Split('=')[1];
                            EtxtReliability.Text = value;
                        }
                        #endregion
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Counselling Details,Counselling.aspx.cs_LoadCounsellingDetails()", ex);
        }
    }

    string ReviewString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("Review").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("Review"))
        {
            HdnText += xmNode["ReviewName"].InnerText + "~" + xmNode["Value"].InnerText + "~" + xmNode["Confi"].InnerText + "^";
        }
        return HdnText;
    }

    string ExaminationString(string XMLString)
    {
        string examstr = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        string Maintxt = string.Empty;
        string Subtxt = string.Empty;
        foreach (XmlNode x in Doc.ChildNodes)
        {
            foreach (XmlNode xs in x.ChildNodes)
            {
                string name = xs.Name;
                foreach (XmlNode xst in xs.ChildNodes)
                {
                    Subtxt += xst.Name + '=' + xst.InnerText + '~';
                }
                Maintxt += xs.Name + '*' + Subtxt + '^';
                Subtxt = string.Empty;
            }
        }
        return Maintxt;

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
            if (Request.QueryString["pvid"] != null)
            {
                Int64.TryParse(Request.QueryString["pvid"], out visitID);
            }
            else
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
            }
            objPatientCounselling.VisitID = visitID;
            objPatientCounselling.CounselID = Convert.ToInt32(ddlCouselType.SelectedValue);
            objPatientCounselling.Symptoms = fckCounselling.Value;
            objPatientCounselling.ReviewOfSystem = CreateReviewXML();
            objPatientCounselling.Examination = CreateExamXML();
            string chkhstProv = string.Empty;
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
                #region History Save
                ucHistory.SaveData();
                #endregion

                #region Save ICDCode
                long returncode = -1;
                List<PatientComplaint> lstdhebDiagnosis = new List<PatientComplaint>();
                PatientComplaint ObjPatientComplaint = new PatientComplaint();
                Uri_BL uriBL = new Uri_BL(base.ContextInfo);
                List<PatientHistory> lstdhebHistory = new List<PatientHistory>();
                List<PatientExamination> lstdhebExamination = new List<PatientExamination>();
                List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
                List<DrugDetails> lstdrugs = new List<DrugDetails>();
                List<Config> lstConfigDD = new List<Config>();
                
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
                if (Request.QueryString["pvid"] != null)
                {
                    Int64.TryParse(Request.QueryString["pvid"], out visitID);
                }
                else
                {
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                }
                lstdhebDiagnosis = ComplaintICDCode1.SavePatientComplaint("QIC", visitID, chkProv);
                lstPatientAdvice = uGAdv.GetGeneralAdvice(visitID);
                
                lstPatientVisit = uMiscellaneous.GetAdmitAndNextReview();
                string admitSuggest = lstPatientVisit[0].AdmissionSuggested;
                string nextReviewDate = lstPatientVisit[0].NextReviewDate;
                string physicihancomments = string.Empty;
                int pOrderedInvCnt = 0;
                string gUID = Guid.NewGuid().ToString();
                if (Request.QueryString["pvid"] != null)
                {
                    Int64.TryParse(Request.QueryString["pvid"], out visitID);
                }
                else
                {
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                }
                returncode = uriBL.SaveUnFoundDiagnosisData(-1, admitSuggest, patientID, nextReviewDate, visitID, lstdhebDiagnosis,
                                lstdhebHistory, lstdhebExamination,
                                orderedInvesHL, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt, "pending", gUID, physicihancomments);
                #endregion

                #region PatientVitals Save
                if (Request.QueryString["pvid"] != null)
                {
                    Int64.TryParse(Request.QueryString["pvid"], out visitID);
                }
                else
                {
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                }
                PatientVitalsControl.GetPageValues(out lstPatientVitals);
                returnCode = new SmartAccessor(base.ContextInfo).InsertExaminationPKG(visitID, patientID, LID, OrgID, lstPatientVitals);
                #endregion

                #region Check Referral And Redirect
                
                bool checkbx = uMiscellaneous.GetValue();
                if (taskID != null && taskID != 0)
                {
                    Int64.TryParse(Request.QueryString["vid"], out visitID);
                    Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                    if (checkbx == true)
                    {
                        if (Request.QueryString["tid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["tid"], out taskID);
                        }
                        else
                        {
                            taskID = 0;
                        }
                        Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                        Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityid);
                        Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&sid=" + specialityid + "&ftype=CON" + "&oC=COUN", true);
                    }
                    else
                    {
                        Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                        Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityid);
                        //taskID = 0;
                        if (Request.QueryString["tid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["tid"], out taskID);
                        }
                        else
                        {
                            taskID = 0;
                        }
                        Response.Redirect(@"../Psychologist/PrintViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityid + "&pSex=" + hdnSex.Value + "&Show=Y" + "" + "&LastVisit=Y", true);
                    }
                }
                else
                {
                    if (checkbx == true)
                    {
                        if (Request.QueryString["tid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["tid"], out taskID);
                        }
                        else
                        {
                            taskID = 0;
                        }
                        Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityid);
                        Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&sid=" + specialityid + "&ftype=CON" + "&oC=COUN", true);

                    }
                    else
                    {
                        if (Request.QueryString["tid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["tid"], out taskID);
                        }
                        else
                        {
                            taskID = 0;
                        }
                        Int64.TryParse(Request.QueryString["sid"].ToString(), out specialityid);
                        Response.Redirect(@"../Psychologist/PrintViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&sid=" + specialityid + "&pSex=" + hdnSex.Value + "&Show=Y" + "" + "&LastVisit=Y", true);
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

    string CreateReviewXML()
    {
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<ReviewOfSystem></ReviewOfSystem>");
        XmlNode xmlNode;

        foreach (string O in hdnTextValue.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string ID = string.Empty;
                string Name = string.Empty;
                string type = string.Empty;
                if (O.Split('~')[0] != string.Empty)
                {
                    ID = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    Name = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    type = O.Split('~')[2];
                }


                XmlElement xmlElement = Doc.CreateElement("Review");

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ReviewName", "");
                xmlNode.InnerText = ID;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = Name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Confi", "");
                xmlNode.InnerText = type;
                xmlElement.AppendChild(xmlNode);

                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;
    }

    string CreateExamXML()
    {
        XmlDocument DocExam = new XmlDocument();
        DocExam.LoadXml("<Examination></Examination>");
        XmlNode AppreancexmlNode;
        XmlNode AttitudexmlNode;
        XmlNode MoodNode;
        XmlNode AffectNode;
        XmlNode SpeechNode;
        XmlNode ThProcessNode;
        XmlNode ThContentNode;
        XmlNode PerceptualNode;
        XmlNode InsightNode;
        XmlNode JudgementNode;
        XmlNode ImpulsivityNode;
        XmlNode ReliabilityNode;

        foreach (string app in hdnAppearance.Value.Split('^'))
        {
            if (app != string.Empty)
            {
                string config = string.Empty;
                string posture = string.Empty;
                string race = string.Empty;
                string attitude = string.Empty;
                string Ethnicity = string.Empty;

                if (app.Split('~')[0] != string.Empty)
                {
                    config = app.Split('~')[0];
                }

                if (app.Split('~')[1] != string.Empty)
                {
                    posture = app.Split('~')[1];
                }

                if (app.Split('~')[2] != string.Empty)
                {
                    race = app.Split('~')[2];
                }

                if (app.Split('~')[3] != string.Empty)
                {
                    attitude = app.Split('~')[3];
                }

                if (app.Split('~')[4] != string.Empty)
                {
                    Ethnicity = app.Split('~')[4];
                }

                XmlElement xmlElement = DocExam.CreateElement("Appearance");

                AppreancexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                AppreancexmlNode.InnerText = config;
                xmlElement.AppendChild(AppreancexmlNode);

                AppreancexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Posture", "");
                AppreancexmlNode.InnerText = posture;
                xmlElement.AppendChild(AppreancexmlNode);

                AppreancexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Race", "");
                AppreancexmlNode.InnerText = race;
                xmlElement.AppendChild(AppreancexmlNode);

                AppreancexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Attitude", "");
                AppreancexmlNode.InnerText = attitude;
                xmlElement.AppendChild(AppreancexmlNode);

                AppreancexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Ethnicity", "");
                AppreancexmlNode.InnerText = Ethnicity;
                xmlElement.AppendChild(AppreancexmlNode);

                DocExam.DocumentElement.AppendChild(xmlElement);
            }
        }

        foreach (string att in hdnAttitude.Value.Split('^'))
        {
            if (att != string.Empty)
            {
                string attitudeconfi = string.Empty;
                string attiExam = string.Empty;

                if (att.Split('~')[0] != string.Empty)
                {
                    attitudeconfi = att.Split('~')[0];
                }

                if (att.Split('~')[1] != string.Empty)
                {
                    attiExam = att.Split('~')[1];
                }

                XmlElement AttitudeElement = DocExam.CreateElement("Attitude");

                AttitudexmlNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                AttitudexmlNode.InnerText = attitudeconfi;
                AttitudeElement.AppendChild(AttitudexmlNode);

                AttitudexmlNode = DocExam.CreateNode(XmlNodeType.Element, "AttitudeExam", "");
                AttitudexmlNode.InnerText = attiExam;
                AttitudeElement.AppendChild(AttitudexmlNode);

                DocExam.DocumentElement.AppendChild(AttitudeElement);
            }
        }
        foreach (string mood in hdnMood.Value.Split('^'))
        {
            if (mood != string.Empty)
            {
                string mdconfi = string.Empty;
                string moodexam = string.Empty;

                if (mood.Split('~')[0] != string.Empty)
                {
                    mdconfi = mood.Split('~')[0];
                }

                if (mood.Split('~')[1] != string.Empty)
                {
                    moodexam = mood.Split('~')[1];
                }

                XmlElement MoodElement = DocExam.CreateElement("Mood");

                MoodNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                MoodNode.InnerText = mdconfi;
                MoodElement.AppendChild(MoodNode);

                MoodNode = DocExam.CreateNode(XmlNodeType.Element, "MoodValue", "");
                MoodNode.InnerText = moodexam;
                MoodElement.AppendChild(MoodNode);

                DocExam.DocumentElement.AppendChild(MoodElement);
            }
        }

        foreach (string affect in hdnAffect.Value.Split('^'))
        {
            if (affect != string.Empty)
            {
                string affectconfi = string.Empty;
                string affectexam = string.Empty;

                if (affect.Split('~')[0] != string.Empty)
                {
                    affectconfi = affect.Split('~')[0];
                }

                if (affect.Split('~')[1] != string.Empty)
                {
                    affectexam = affect.Split('~')[1];
                }

                XmlElement AffectElement = DocExam.CreateElement("Affect");

                AffectNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                AffectNode.InnerText = affectconfi;
                AffectElement.AppendChild(AffectNode);

                AffectNode = DocExam.CreateNode(XmlNodeType.Element, "AffectValue", "");
                AffectNode.InnerText = affectexam;
                AffectElement.AppendChild(AffectNode);

                DocExam.DocumentElement.AppendChild(AffectElement);
            }
        }

        foreach (string speech in hdnSpeech.Value.Split('^'))
        {
            if (speech != string.Empty)
            {
                string speechconfi = string.Empty;
                string quality = string.Empty;
                string rate = string.Empty;
                string volume = string.Empty;
                string coordination = string.Empty;

                if (speech.Split('~')[0] != string.Empty)
                {
                    speechconfi = speech.Split('~')[0];
                }
                if (speech.Split('~')[1] != string.Empty)
                {
                    quality = speech.Split('~')[1];
                }
                if (speech.Split('~')[2] != string.Empty)
                {
                    rate = speech.Split('~')[2];
                }
                if (speech.Split('~')[3] != string.Empty)
                {
                    volume = speech.Split('~')[3];
                }
                if (speech.Split('~')[4] != string.Empty)
                {
                    coordination = speech.Split('~')[4];
                }

                XmlElement SpeechElement = DocExam.CreateElement("Speech");

                SpeechNode = DocExam.CreateNode(XmlNodeType.Element, "SpeechConfig", "");
                SpeechNode.InnerText = speechconfi;
                SpeechElement.AppendChild(SpeechNode);

                SpeechNode = DocExam.CreateNode(XmlNodeType.Element, "Quality", "");
                SpeechNode.InnerText = quality;
                SpeechElement.AppendChild(SpeechNode);

                SpeechNode = DocExam.CreateNode(XmlNodeType.Element, "Rate", "");
                SpeechNode.InnerText = rate;
                SpeechElement.AppendChild(SpeechNode);

                SpeechNode = DocExam.CreateNode(XmlNodeType.Element, "Volume", "");
                SpeechNode.InnerText = volume;
                SpeechElement.AppendChild(SpeechNode);

                SpeechNode = DocExam.CreateNode(XmlNodeType.Element, "Co-Ordination", "");
                SpeechNode.InnerText = coordination;
                SpeechElement.AppendChild(SpeechNode);

                DocExam.DocumentElement.AppendChild(SpeechElement);
            }
        }

        foreach (string thProcess in hdnThProcess.Value.Split('^'))
        {
            if (thProcess != string.Empty)
            {
                string thProcessconfi = string.Empty;
                string thProcessexam = string.Empty;

                if (thProcess.Split('~')[0] != string.Empty)
                {
                    thProcessconfi = thProcess.Split('~')[0];
                }

                if (thProcess.Split('~')[1] != string.Empty)
                {
                    thProcessexam = thProcess.Split('~')[1];
                }

                XmlElement ThProcessElement = DocExam.CreateElement("ThProcess");

                ThProcessNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                ThProcessNode.InnerText = thProcessconfi;
                ThProcessElement.AppendChild(ThProcessNode);

                ThProcessNode = DocExam.CreateNode(XmlNodeType.Element, "ProcessValue", "");
                ThProcessNode.InnerText = thProcessexam;
                ThProcessElement.AppendChild(ThProcessNode);

                DocExam.DocumentElement.AppendChild(ThProcessElement);
            }
        }

        foreach (string ThContents in hdnThContent.Value.Split('^'))
        {
            if (ThContents != string.Empty)
            {
                string ThContentsconfi = string.Empty;
                string Obessions = string.Empty;
                string Phobias = string.Empty;
                string Consciousness = string.Empty;
                string Orientation = string.Empty;
                string Sensorium = string.Empty;
                string Suicidal = string.Empty;
                string Memory = string.Empty;
                string Abstractness = string.Empty;

                if (ThContents.Split('~')[0] != string.Empty)
                {
                    ThContentsconfi = ThContents.Split('~')[0];
                }
                if (ThContents.Split('~')[1] != string.Empty)
                {
                    Obessions = ThContents.Split('~')[1];
                }
                if (ThContents.Split('~')[2] != string.Empty)
                {
                    Phobias = ThContents.Split('~')[2];
                }
                if (ThContents.Split('~')[3] != string.Empty)
                {
                    Consciousness = ThContents.Split('~')[3];
                }
                if (ThContents.Split('~')[4] != string.Empty)
                {
                    Orientation = ThContents.Split('~')[4];
                }
                if (ThContents.Split('~')[5] != string.Empty)
                {
                    Sensorium = ThContents.Split('~')[5];
                }
                if (ThContents.Split('~')[6] != string.Empty)
                {
                    Suicidal = ThContents.Split('~')[6];
                }
                if (ThContents.Split('~')[7] != string.Empty)
                {
                    Memory = ThContents.Split('~')[7];
                }
                if (ThContents.Split('~')[8] != string.Empty)
                {
                    Abstractness = ThContents.Split('~')[8];
                }

                XmlElement ThContentElement = DocExam.CreateElement("ThContent");

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Contentsconfi", "");
                ThContentNode.InnerText = ThContentsconfi;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Obessions", "");
                ThContentNode.InnerText = Obessions;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Phobias", "");
                ThContentNode.InnerText = Phobias;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Consciousness", "");
                ThContentNode.InnerText = Consciousness;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Orientation", "");
                ThContentNode.InnerText = Orientation;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Sensorium", "");
                ThContentNode.InnerText = Sensorium;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Suicidal", "");
                ThContentNode.InnerText = Suicidal;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Memory", "");
                ThContentNode.InnerText = Memory;
                ThContentElement.AppendChild(ThContentNode);

                ThContentNode = DocExam.CreateNode(XmlNodeType.Element, "Abstractness", "");
                ThContentNode.InnerText = Abstractness;
                ThContentElement.AppendChild(ThContentNode);

                DocExam.DocumentElement.AppendChild(ThContentElement);
            }
        }

        foreach (string Perceptual in hdnPerceptual.Value.Split('^'))
        {
            if (Perceptual != string.Empty)
            {
                string Perceptualconfig = string.Empty;
                string Hallucinations = string.Empty;
                string Illusions = string.Empty;

                if (Perceptual.Split('~')[0] != string.Empty)
                {
                    Perceptualconfig = Perceptual.Split('~')[0];
                }

                if (Perceptual.Split('~')[1] != string.Empty)
                {
                    Hallucinations = Perceptual.Split('~')[1];
                }

                if (Perceptual.Split('~')[2] != string.Empty)
                {
                    Illusions = Perceptual.Split('~')[2];
                }

                XmlElement PerceptualElement = DocExam.CreateElement("Perceptual");

                PerceptualNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                PerceptualNode.InnerText = Perceptualconfig;
                PerceptualElement.AppendChild(PerceptualNode);

                PerceptualNode = DocExam.CreateNode(XmlNodeType.Element, "Hallucinations", "");
                PerceptualNode.InnerText = Hallucinations;
                PerceptualElement.AppendChild(PerceptualNode);

                PerceptualNode = DocExam.CreateNode(XmlNodeType.Element, "Illusions", "");
                PerceptualNode.InnerText = Illusions;
                PerceptualElement.AppendChild(PerceptualNode);

                DocExam.DocumentElement.AppendChild(PerceptualElement);
            }
        }

        foreach (string Insight in hdnInsight.Value.Split('^'))
        {
            if (Insight != string.Empty)
            {
                string Insightconfi = string.Empty;
                string Insightexam = string.Empty;

                if (Insight.Split('~')[0] != string.Empty)
                {
                    Insightconfi = Insight.Split('~')[0];
                }

                if (Insight.Split('~')[1] != string.Empty)
                {
                    Insightexam = Insight.Split('~')[1];
                }

                XmlElement InsightElement = DocExam.CreateElement("Insight");

                InsightNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                InsightNode.InnerText = Insightconfi;
                InsightElement.AppendChild(InsightNode);

                InsightNode = DocExam.CreateNode(XmlNodeType.Element, "Insight", "");
                InsightNode.InnerText = Insightexam;
                InsightElement.AppendChild(InsightNode);

                DocExam.DocumentElement.AppendChild(InsightElement);
            }
        }

        foreach (string Judgement in hdnJudgement.Value.Split('^'))
        {
            if (Judgement != string.Empty)
            {
                string Judgementconfi = string.Empty;
                string Judgementexam = string.Empty;

                if (Judgement.Split('~')[0] != string.Empty)
                {
                    Judgementconfi = Judgement.Split('~')[0];
                }

                if (Judgement.Split('~')[1] != string.Empty)
                {
                    Judgementexam = Judgement.Split('~')[1];
                }

                XmlElement JudgementElement = DocExam.CreateElement("Judgement");

                JudgementNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                JudgementNode.InnerText = Judgementconfi;
                JudgementElement.AppendChild(JudgementNode);

                JudgementNode = DocExam.CreateNode(XmlNodeType.Element, "Judgement", "");
                JudgementNode.InnerText = Judgementexam;
                JudgementElement.AppendChild(JudgementNode);

                DocExam.DocumentElement.AppendChild(JudgementElement);
            }
        }

        foreach (string Impulsivity in hdnImpulsivity.Value.Split('^'))
        {
            if (Impulsivity != string.Empty)
            {
                string Impulsivityconfi = string.Empty;
                string Impulsivityexam = string.Empty;

                if (Impulsivity.Split('~')[0] != string.Empty)
                {
                    Impulsivityconfi = Impulsivity.Split('~')[0];
                }

                if (Impulsivity.Split('~')[1] != string.Empty)
                {
                    Impulsivityexam = Impulsivity.Split('~')[1];
                }

                XmlElement ImpulsivityElement = DocExam.CreateElement("Impulsivity");

                ImpulsivityNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                ImpulsivityNode.InnerText = Impulsivityconfi;
                ImpulsivityElement.AppendChild(ImpulsivityNode);

                ImpulsivityNode = DocExam.CreateNode(XmlNodeType.Element, "Impulsivity", "");
                ImpulsivityNode.InnerText = Impulsivityexam;
                ImpulsivityElement.AppendChild(ImpulsivityNode);

                DocExam.DocumentElement.AppendChild(ImpulsivityElement);
            }
        }

        foreach (string Reliability1 in hdnReliability.Value.Split('^'))
        {
            if (Reliability1 != string.Empty)
            {
                string Reliabilityconfi = string.Empty;
                string Reliabilityexam = string.Empty;

                if (Reliability1.Split('~')[0] != string.Empty)
                {
                    Reliabilityconfi = Reliability1.Split('~')[0];
                }

                if (Reliability1.Split('~')[1] != string.Empty)
                {
                    Reliabilityexam = Reliability1.Split('~')[1];
                }

                XmlElement ReliabilityElement = DocExam.CreateElement("Reliability");

                ReliabilityNode = DocExam.CreateNode(XmlNodeType.Element, "Config", "");
                ReliabilityNode.InnerText = Reliabilityconfi;
                ReliabilityElement.AppendChild(ReliabilityNode);

                ReliabilityNode = DocExam.CreateNode(XmlNodeType.Element, "ReliabilityNode", "");
                ReliabilityNode.InnerText = Reliabilityexam;
                ReliabilityElement.AppendChild(ReliabilityNode);

                DocExam.DocumentElement.AppendChild(ReliabilityElement);
            }
        }

        return DocExam.InnerXml;
    }

    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        Response.Redirect("../Psychologist/Home.aspx");
    }
    //protected void grdView_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        if (e.CommandName == "Select")
    //        {
    //            taskID = 0;
    //            int RowIndex = Convert.ToInt32(e.CommandArgument);
    //            hdnVisitID.Value = Convert.ToString(grdView.DataKeys[RowIndex][0]);
    //            visitID = Convert.ToInt64(hdnVisitID.Value);
    //            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
    //            string strPath = "../Psychologist/ViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&IsPopup=Y" + "&pSex=" + hdnSex.Value + "&Show=Y" + "";
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showCaseSheet('" + strPath + "');", true);
    //        }
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading Drug Details to Update", ex);
    //    }
    //}
    protected void grdView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblVisitID = (Label)e.Row.FindControl("lblVisitID");
                taskID = 0;
                visitID = Convert.ToInt64(lblVisitID.Text);
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                string strPath = "../Psychologist/ViewCounsellingDetails.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&IsPopup=Y" + "&pSex=" + hdnSex.Value + "&Show=Y" + "";

                e.Row.Attributes.Add("onclick", "showCaseSheet('" + strPath + "');");
                e.Row.Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
                e.Row.ToolTip = "Show Previous Visit Details";
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
