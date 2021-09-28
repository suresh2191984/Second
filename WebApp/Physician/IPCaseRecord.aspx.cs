using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;

public partial class Physician_IPCaseRecord : BasePage
{
    #region Declaration_Region
    //sami added below lines
    int NewVitalsSetID = -1;
    //sami added lines end
    long patientVisitID = -1;
    int taskID = -1;
    long patientID = -1;
    long returnCode = -1;
    int vType = -1;
    String orderedList = string.Empty;
    public int complaintID = 0;
    long taksId = 0;
    static long OnBehalf = 0;
    static long TaskStatusID = 0;
    static string FCK = string.Empty;
    string PaidStatus = string.Empty;
    string InvDrugData = string.Empty;
    string gUID = string.Empty;
    int PhysioCount = 0;
    static List<DrugDetails> lstDrugDetails1 = new List<DrugDetails>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<PatientExamination> lstIPSystemicExamination = new List<PatientExamination>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<OrderedInvestigations> lstIPPatientPerformedInvestigation = new List<OrderedInvestigations>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<PatientVisit> lstPrevVisits = new List<PatientVisit>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    //List<InvGroupMaster> lstGroups = new List<InvGroupMaster>();
    //List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
    List<DHEBAdder> lstdhebDiagnosis = new List<DHEBAdder>();
    List<DHEBAdder> lstdhebHistory = new List<DHEBAdder>();
    List<DHEBAdder> lstdhebExamination = new List<DHEBAdder>();
    List<IPComplaint> lstIPComplaint = new List<IPComplaint>();
    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
    List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<BackgroundProblem> lstOtherBackgroundProblem = new List<BackgroundProblem>();
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<IPTreatmentPlan> lstPerformedIPTreatmentPlan = new List<IPTreatmentPlan>();
    ANCPatientDetails objANCPatientDetails = new ANCPatientDetails();
    RTAMLCDetails objRTAMLC = new RTAMLCDetails();
    Investigation_BL investigationBL;
    PatientVisit_BL patientvisitBL;
    IP_BL ipBL;

    List<PatientInvestigation> lstGroups = new List<PatientInvestigation>();
    List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
    List<OrderedInvestigations> lstGrp = new List<OrderedInvestigations>();
    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();



    #endregion

      public Physician_IPCaseRecord()
        : base("Physician\\IPCaseRecord.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    public void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        investigationBL = new Investigation_BL(base.ContextInfo);
        patientvisitBL = new PatientVisit_BL(base.ContextInfo);

        try
        {
            if (IsCorporateOrg == "Y")
            {
                hdnIscorprateorg.Value = "Y";
                tbMainProc.Style.Add("display", "block");
                tabProc.Style.Add("display", "block");
                Grdplus.Style.Add("display", "block");                
            }
            else
            {
                hdnIscorprateorg.Value = "N";
            }

            tLMP.Attributes.Add("onchange", "addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
            tLMP.Attributes.Add("onchange", "ExcedDate('" + tLMP.ClientID.ToString() + "','',0,0); addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
            txtGravida.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtPara.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtAbortUs.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtLive.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            //uAd.RouteDisplay = "block";
            ddlNos.Attributes.Add("onchange", "setActualDay();");
            ddlDMY.Attributes.Add("onchange", "setActualDay();");
            txtActualDate.Attributes.Add("onchange", "ValidateNextRwDay();");

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int32.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

           string Isedit = Request.QueryString["Isedit"];
            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();

            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            Patient patient = new Patient();

            hdnPatientID.Value = patientID.ToString();
            hdnVisitID.Value = patientVisitID.ToString();
            pnlMiscellaneous.Visible = true;
            if (!IsPostBack)
            {
                patientBL.GetPatientDetailsPassingVisitID(patientVisitID, out lstPatient);
                if (lstPatient.Count > 0)
                    patient = lstPatient[0];
                vType = Convert.ToInt16(lstPatient[0].VisitType);

                Session["PatientID"] = patientID;
                Session["PatientVisitID"] = patientVisitID;
                Session["TaskID"] = taskID;
                Session["VisitType"] = vType;

                hdnToPreviousPage.Value = "";
                if (Request.UrlReferrer.AbsolutePath != null)
                {
                    hdnToPreviousPage.Value = Request.UrlReferrer.AbsolutePath.ToString();
                }
                ComplaintICDCode1.ComplaintHeader = "Diagnosis";
                ComplaintICDCode1.SetWidth(500);
                ComplaintICDCodeBP1.ComplaintHeader = "Other Problem";
                chkRTA.Checked = false;
                btnFinish.Enabled = true;
                GetFCKPath();
                //********** Form the Advice Control ************************/
                List<Config> lstConfigDD = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                if (lstConfigDD.Count > 0)
                {
                    InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                }
                if (InvDrugData == "Y")
                {
                    //uAd.Visible = false;
                    uIAdv.Visible = true;
                }
                else
                {
                    //uAd.Visible = true;
                    uIAdv.Visible = false;
                }
                //uAd.SetPrescription(lstDrugDetails);
                LoadIPComplaint();
                LoadModeOfDelivery();
                LoadIPTreatmentPlanMaster();
                // LoadIPTreatmentPlanChild();
                LoadAllIPTreatmentPlanChild();
                Loadphysician();
                LoadMetaData();
                LoadOrderProcedure();
                //investigationBL.GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), complaintID, out lstGroups, out lstInvestigations);
                int visitID = 0;
                if (Request.QueryString["vid"] != null)
                {
                    visitID = Request.QueryString["vid"].ToString() == "" ? 0 : Convert.ToInt32(Request.QueryString["vid"].ToString());
                }
                if (patientVisitID != 0)
                {
                    ipBL.GetIPVisitDetails(patientVisitID, out lstPatientVisit);
                    List<InvGroupMaster> lstGroups = new List<InvGroupMaster>();
                    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                    new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstGroups, out lstInvestigations);
                    InvestigationControl1.OrgSpecific = OrgID;
                    InvestigationControl1.LoadLabData(lstGroups, lstInvestigations);
                    GetIPCaseRecord(InvDrugData);
                    //LoadInvCtrl();
                    new IP_BL(base.ContextInfo).GetIPOrderedInvestigation(visitID, out lstInv, out lstGrp);
                    if (lstInv.Count > 0 || lstGrp.Count > 0)
                    {
                        InvestigationControl1.loadOrderedList(lstInv, lstGrp);
                    }
                }

                // Sami added bellow lines
                if (lstPatientVitals.Count > 0)
                {
                    string type = "CRCU";
                    uctlPatientVitals.VisitID = patientVisitID;
                    uctlPatientVitals.LoadControls(type, patientVisitID);

                }
                else
                {
                    string type = "I";
                    uctlPatientVitals.VisitID = patientVisitID;
                    uctlPatientVitals.LoadControls(type, patientID);
                }
                // Sami added lines ends

                if (lstPatientAdvice.Count > 0)
                    uGAdv.setGeneralAdvice(lstPatientAdvice);

                chkPastMedicalHistory.Checked = true;

                OrthoEMR1.GetOrthoSpecialtyDetails(OrgID);
                long Count = -1;
                Count = OrthoEMR1.SetOrthoPatientDetails(patientVisitID);
                if (Count > 0)
                {
                    trOrtho.Style.Add("display", "block");
                    tblOrtho.Style.Add("display", "block");
                }
                if (isCorporateOrg == "Y")
                {
                    btnCorOk.Visible = true;
                    btnDueChart.Visible = false;

                    if (RoleName != RoleHelper.Physician)
                    {
                        tbAssPhy.Attributes.Add("Style", "display:block");
                        hdnOnBehalfID.Value = "1";
                        Loadphysician();
                    }
                    else
                    {
                        hdnOnBehalfID.Value = "0";
                    }
                }
                else
                {
                    tblTreatmentplan.Attributes.Add("Style", "display:block");
                }
            }
            if (IsPostBack)
            {
                LoadIPComplaint();
                int visitID = 0;
                if (Request.QueryString["vid"] != null)
                {
                    visitID = Request.QueryString["vid"].ToString() == "" ? 0 : Convert.ToInt32(Request.QueryString["vid"].ToString());
                }
                
                if (chkSwollenLymphNodes.Checked)
                {
                    trSwollenLymphNodes.Style.Add("display", "block");
                }
            }
            if (lstPatient.Count > 0 && lstPatient[0].SEX == "M")
            {
                //chkSwollenLymphNodes.Style.Add("display", "none");
                obstretricHistoryTab.Style.Add("display", "none");
            }

            string strConfigKey = "IPMakePayment";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            if (configValue == "N")
            {
                btnPayment.Visible = false;
            }
            else
            {
                btnPayment.Visible = false;
            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in IPCaseRecord.aspx:Page_Load", ex);
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

    //newly added by sami

    public void LoadAllIPTreatmentPlanChild()
    {
        try
        {
            List<IPTreatmentPlanMaster> lstAllIPTreatmentPlanChild = new List<IPTreatmentPlanMaster>();

            ipBL.GetAllIPTreatmentPlanChild(OrgID, out lstAllIPTreatmentPlanChild);

            string Surgery = 0 + "~" + "Others" + "~" + 1 + "^";
            string Interventional = 0 + "~" + "Others" + "~" + 2 + "^";

            if (lstAllIPTreatmentPlanChild.Count > 0)
            {
                foreach (IPTreatmentPlanMaster objIPTreatmentPlanMaster in lstAllIPTreatmentPlanChild)
                {
                    hdnIPTreatmentPlanChild.Value += objIPTreatmentPlanMaster.TreatmentPlanID + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanName + "~" + objIPTreatmentPlanMaster.IPTreatmentPlanParentID + "^";
                }
                hdnIPTreatmentPlanChild.Value += Surgery + Interventional;
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IPTreatmentPlan in opeartion Notes.aspx", ex);
        }
    }


    public void GetIPCaseRecord(string strInvDrugData)
    {
        try
        {
            string strNextReviewDt = string.Empty;
            string Priviousvisitdrug = string.Empty;
            Priviousvisitdrug = "N";
            returnCode = ipBL.GetIPCaseRecord(patientVisitID, LID, RoleID, Priviousvisitdrug, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails,
                out lstRTAMLCDetails, out lstPatientComplaint, out lstIPTreatmentPlan, out lstBackgroundProblem, out lstPatientVitals,
                out lstANCPatientDetails, out lstPatientInvestigation, out lstIPPatientPerformedInvestigation, out lstPerformedIPTreatmentPlan,
                out lstOtherBackgroundProblem, out lstPatientHistoryExt, out lstPatientAdvice, out strNextReviewDt, out lstPrevVisits);
            if (returnCode == 0)
            {
                if (lstPatientHistory.Count > 0)
                {
                    int i = 110;
                    foreach (PatientHistory objPH in lstPatientHistory)
                    {
                        string[] str = objPH.Description.Split(' ');
                        hdnHistoryItems.Value += i + "~" + objPH.HistoryName + "~" + str[0] + "~" + str[1] + "^";
                        i += 1;
                    }
                }
                if (lstPatientComplaint.Count > 0)
                {
                    ComplaintICDCode1.SetPatientComplaint(lstPatientComplaint);
                    if (lstPatientComplaint[0].OnBehalf != null)
                        drpPhysician.SelectedValue = lstPatientComplaint[0].OnBehalf.ToString();
                }


                if (lstOtherBackgroundProblem.Count > 0)
                {
                    ComplaintICDCodeBP1.SetPatientBackgroundProblem(lstOtherBackgroundProblem);
                    //int i = 500;
                    //foreach (BackgroundProblem objOBP in lstOtherBackgroundProblem)
                    //{
                    //    hdnOBP.Value += i + "~" + objOBP.ComplaintName + "~" + objOBP.Description + "^";
                    //    i += 1;
                    //}
                }
                if (lstDrugDetails.Count > 0)
                {
                    if (strInvDrugData == "Y")
                    {
                        uIAdv.SetPrescription(lstDrugDetails);
                        lstDrugDetails1 = lstDrugDetails;
                    }
                    else
                    {
                        //uAd.SetPrescription(lstDrugDetails);
                    }

                }

                //if (lstIPPatientPerformedInvestigation.Count > 0)
                //{
                //    tblPerformedInvestigation.Style.Add("display", "block");
                //    dlInvName.DataSource = lstIPPatientPerformedInvestigation;
                //    dlInvName.DataBind();
                //}
                if (lstRTAMLCDetails.Count > 0)
                {
                    trRTABlock.Style.Add("display", "block");

                    chkRTA.Checked = true;
                    foreach (RTAMLCDetails objRTAMLC in lstRTAMLCDetails)
                    {
                        if (objRTAMLC.AlcoholDrugInfluence == "Y")
                        {
                            chkRTAInfluenceOfDrugs.Checked = true;
                        }
                        if (objRTAMLC.RTAMLCDate != null)
                        {
                            txtRTADate.Text = objRTAMLC.RTAMLCDate.ToString();
                        }
                        if (objRTAMLC.FIRDate != DateTime.MinValue)
                        {
                            txtFIRDate.Text = objRTAMLC.FIRDate.ToString();
                        }
                        txtRTAFIRNo.Text = objRTAMLC.FIRNo;
                        txtRTALocation.Text = objRTAMLC.Location;
                        txtPoliceStation.Text = objRTAMLC.PoliceStation;
                        txtPoliceContact.Text = objRTAMLC.MLCNo;
                    }
                }
                if (lstBackgroundProblem.Count > 0)
                {
                    int show = 0;
                    foreach (BackgroundProblem objBackgroundProblem in lstBackgroundProblem)
                    {
                        if (objBackgroundProblem.ComplaintName == "Stroke(CVA)")
                        {
                            chkPMHStroke.Checked = true;
                            if (objBackgroundProblem.Description != "")
                            {
                                string[] str = objBackgroundProblem.Description.Split('^');
                                txtPMHStroke.Text = str[0].Trim();
                                ddlPMHStroke.SelectedValue = str[1].Trim();
                            }
                            show = 1;
                        }
                        else
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            if (chkBox != null)
                                chkBox.Checked = true;
                            if (txtBox != null)
                                txtBox.Text = objBackgroundProblem.Description;
                            if (hdnICDCode != null)
                                hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            if (hdnICDDesc != null)
                                hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        #region Reduntant code commented
                        /*
                        if (objBackgroundProblem.ComplaintName == "Cataract")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Bronchial asthma")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "COPD")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Ischemic heart disease")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Systemic Hypertension")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Diabetes Mellitus")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            if (chkBox != null)
                                chkBox.Checked = true;
                            if (txtBox != null)
                                txtBox.Text = objBackgroundProblem.Description;
                            if (hdnICDCode != null)
                                hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            if (hdnICDDesc != null)
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Osteoarthritis")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Renal Dysfunction")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Alcohol Abuse")
                        {
                            CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + objBackgroundProblem.ComplaintID);
                            TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + objBackgroundProblem.ComplaintID);
                            HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + objBackgroundProblem.ComplaintID);
                            chkBox.Checked = true;
                            txtBox.Text = objBackgroundProblem.Description;
                            hdnICDCode.Value = objBackgroundProblem.ICDCode;
                            hdnICDDesc.Value = objBackgroundProblem.ICDDescription;
                            show = 1;
                        }
                        else if (objBackgroundProblem.ComplaintName == "Stroke(CVA)")
                        {
                            chkPMHStroke.Checked = true;
                            if (objBackgroundProblem.Description != "")
                            {
                                string[] str = objBackgroundProblem.Description.Split('^');
                                txtPMHStroke.Text = str[0].Trim();
                                ddlPMHStroke.SelectedValue = str[1].Trim();
                            }
                            show = 1;
                        } */
                        #endregion
                    }
                }
                if (lstANCPatientDetails.Count > 0)
                {
                    foreach (ANCPatientDetails objANCPD in lstANCPatientDetails)
                    {
                        txtGravida.Text = objANCPD.Gravida.ToString();
                        txtPara.Text = objANCPD.Para.ToString();
                        txtAbortUs.Text = objANCPD.Abortus.ToString();
                        txtLive.Text = objANCPD.Live.ToString();
                        tLMP.Text = objANCPD.LMPDate.ToString();
                        txtCalculatedEDD.Text = objANCPD.EDD.ToString();
                    }
                }

                if (lstPatientExamination.Count > 0)
                {
                    foreach (PatientExamination objPE in lstPatientExamination)
                    {
                        if (objPE.ExaminationName == "Pallor")
                        {
                            chkPallor.Checked = true;
                        }
                        if (objPE.ExaminationName == "Icterus")
                        {
                            chkIcterus.Checked = true;
                        }
                        if (objPE.ExaminationName == "Oedema")
                        {
                            chkOedema.Checked = true;
                        }
                        if (objPE.ExaminationName == "Febrile")
                        {
                            chkFever.Checked = true;
                        }
                        if (objPE.ExaminationName == "Unconsciousness")
                        {
                            chkUnconscious.Checked = true;
                        }
                        if (objPE.ExaminationName == "Stuporous")
                        {
                            chkStuporous.Checked = true;
                        }
                        if (objPE.ExaminationName == "Disorientation")
                        {
                            chkDisorientation.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Lymph Nodes")
                        {
                            chkSwollenLymphNodes.Checked = true;
                            trSwollenLymphNodes.Style.Add("display", "block");
                        }

                        if (objPE.ExaminationName == "Swollen Cervical Lymph Nodes")
                        {
                            chkCervical.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Inguinal Lymph Nodes")
                        {
                            chkInguinal.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Abdominal Lymph Nodes")
                        {
                            chkAbdominal.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Axillary Lymph Nodes")
                        {
                            chkAxillary.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Submandibular Lymph Nodes")
                        {
                            chkSubmandibular.Checked = true;
                        }
                        if (objPE.ExaminationName == "Swollen Auricular Lymph Nodes")
                        {
                            chkAuricular.Checked = true;
                        }



                        if (objPE.ExaminationName == "CVS")
                        {
                            chkCVS.Checked = true;
                            txtCVS.Text = objPE.Description;
                        }


                        if (objPE.ExaminationName == "RS")
                        {
                            chkRS.Checked = true;
                            txtRS.Text = objPE.Description;
                        }

                        if (objPE.ExaminationName == "ABD")
                        {
                            ChkABD.Checked = true;
                            txtABD.Text = objPE.Description;
                        }


                        if (objPE.ExaminationName == "CNS")
                        {
                            ChkCNS.Checked = true;
                            txtCNS.Text = objPE.Description;
                        }

                        if (objPE.ExaminationName == "P/R")
                        {
                            ChkPR.Checked = true;
                            txtPR.Text = objPE.Description;
                        }

                        if (objPE.ExaminationName == "Genitalia")
                        {
                            ChkGenitalia.Checked = true;
                            txtGenitalia.Text = objPE.Description;
                        }

                        if (objPE.ExaminationName == "Musculoskeletal")
                        {
                            ChkMusculoskeletal.Checked = true;
                            txtMusculoskeletal.Text = objPE.Description;
                        }

                        if (objPE.ExaminationName == "Others")
                        {
                            ChkOthers.Checked = true;
                            txtExaminationOthers.Text = objPE.Description;
                        }

                    }
                }
                //Added By Sami

                if (lstIPTreatmentPlan.Count > 0)
                {
                    string pTreatmentPlanDate;
                    int i = 1;
                    foreach (IPTreatmentPlan objIPTP in lstIPTreatmentPlan)
                    {
                        if (objIPTP.TreatmentPlanDate == DateTime.MinValue)
                        {
                            pTreatmentPlanDate = "Will be scheduled later";
                        }
                        else
                        {
                            pTreatmentPlanDate = objIPTP.TreatmentPlanDate.ToString();
                        }
                        hdnIPTreatmentPlanItems.Value += i + "~" + objIPTP.ParentID + "~" + objIPTP.IPTreatmentPlanID + "~" + objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "~" + pTreatmentPlanDate + "~" + objIPTP.Status + "^";
                        i += 1;
                    }
                }

                if (lstPerformedIPTreatmentPlan.Count > 0)
                {
                    foreach (IPTreatmentPlan objIPTP in lstPerformedIPTreatmentPlan)
                    {
                        hdnPerformedTreatment.Value += objIPTP.ParentName + "~" + objIPTP.IPTreatmentPlanName + "~" + objIPTP.Prosthesis + "~" + objIPTP.Status + "^";

                    }
                }
                #region DetailsHistory
                if (lstPatientHistoryExt.Count > 0)
                {
                    fckHospitalCourse.Value = lstPatientHistoryExt[0].DetailHistory;
                }

                #endregion

                string NextReview = string.Empty;
                string NextReviewNos = string.Empty;
                string NextReviewDMY = string.Empty;
                string[] nReview;
                if (strNextReviewDt.Length > 0)
                {
                    NextReview = strNextReviewDt;
                    nReview = NextReview.Split('-');
                    chkReview.Checked = true;
                    if (nReview.Length > 0)
                    {
                        NextReviewNos = nReview[0].ToString();
                        NextReviewDMY = nReview[1].ToString();
                        ddlNos.Text = NextReviewNos;
                        ddlDMY.SelectedValue = NextReviewDMY;
                    }
                }

                if (lstPrevVisits.Count > 0)
                {
                    trPrevVisits.Style.Add("display", "block");
                    grdResult.DataSource = lstPrevVisits;
                    grdResult.DataBind();
                }
            }
            if (lstDrugDetails.Count > 0)
            {
                Session.Add("InentoryTaskID", lstDrugDetails[0].TaskID);
                Session.Add("InentoryTaskTstatusID", lstDrugDetails[0].Sno);
                hdnInentorytaskstastusID.Value = lstDrugDetails[0].Sno.ToString();
            }
            else
            {
                Session.Add("InentoryTaskID", 0);
                Session.Add("InentoryTaskTstatusID", 0);
                hdnInentorytaskstastusID.Value = "0";
            }
            if (lstIPPatientPerformedInvestigation.Count > 0)
            {
                Session.Add("InvestigationTaskID", lstIPPatientPerformedInvestigation[0].TaskID);
                Session.Add("InvestigationTaskTstatusID", lstIPPatientPerformedInvestigation[0].ReferralID);
                hdnInvestigationtaskstastusID.Value = lstIPPatientPerformedInvestigation[0].ReferralID.ToString();
            }
            else
            {
                Session.Add("InvestigationTaskID", 0);
                Session.Add("InvestigationTaskTstatusID", 0);
                hdnInvestigationtaskstastusID.Value = "0";
            }


        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IP Case Record in IPCaseRecord.aspx", ex);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.VisitType + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            }
            foreach (GridViewRow grd in grdResult.Rows)
            {
                //grdResult.Columns[3].Visible = true;
                Label l1 = (Label)grd.FindControl("hdnVType");
                if (l1.Text == "0")
                {
                    l1.Text = "OP";
                    l1.ForeColor = System.Drawing.Color.DarkMagenta;
                    l1.Font.Size = 11;

                }
                if (l1.Text == "1")
                {
                    l1.Text = "IP";
                    l1.ForeColor = System.Drawing.Color.Brown;
                    l1.Font.Size = 11;

                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound in IPCaseRecord.aspx", Ex);
        }
    }

    protected void ddlIPTreatmentPlanMaster_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadIPTreatmentPlanChild();
    }

    protected void LoadIPTreatmentPlanMaster()
    {
        try
        {
            ipBL.GetIPTreatmentPlanMaster(OrgID, out lstIPTreatmentPlanMaster);
            var list = from IPTreatment in lstIPTreatmentPlanMaster
                       where IPTreatment.IPTreatmentPlanParentID == 0
                       select IPTreatment;
            if (list.Count() > 0)
            {
                ddlIPTreatmentPlanMaster.DataSource = lstIPTreatmentPlanMaster;
                ddlIPTreatmentPlanMaster.DataTextField = "IPTreatmentPlanName";
                ddlIPTreatmentPlanMaster.DataValueField = "TreatmentPlanID";
                ddlIPTreatmentPlanMaster.DataBind();
                ddlIPTreatmentPlanMaster.Items.Insert(lstIPTreatmentPlanMaster.Count, "Medical");
                ddlIPTreatmentPlanMaster.Items[lstIPTreatmentPlanMaster.Count].Value = "0";
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IPTreatmentPlan in IPCaseRecord.aspx", ex);
        }
    }

    protected void LoadModeOfDelivery()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<ModeOfDelivery> lstModeOfDelivery = new List<ModeOfDelivery>();
            returnCode = ancBL.GetModeOfDelivery(out lstModeOfDelivery);
            if (lstModeOfDelivery.Count > 0)
            {
                ddlModeOfDelivery.DataSource = lstModeOfDelivery;
                ddlModeOfDelivery.DataTextField = "ModeOfDeliveryDesc";
                ddlModeOfDelivery.DataValueField = "ModeOfDeliveryId";
                ddlModeOfDelivery.DataBind();
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading Mode Of Delivry in IPCaseRecord.aspx", ex);
        }
    }

    public void LoadIPComplaint()
    {
        try
        {
            returnCode = ipBL.GetIPComplaint(out lstIPComplaint);
            if (lstIPComplaint.Count > 0)
            {
                BuildPastMedicalHistoryTab(lstIPComplaint);
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading IPComplaint in IPCaseRecord.aspx", ex);
        }
    }

    public void BuildPastMedicalHistoryTab(List<IPComplaint> lstIPComplaintParam)
    {
        hdnPastMedicalHistoryItems.Value = "";
        var list = from lstIPComplaintChild in lstIPComplaintParam
                   where lstIPComplaintChild.ComplaintName != "Stroke (CVA)"
                   select lstIPComplaintChild;
        if (list.Count() > 0)
        {
            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            cellH1.Attributes.Add("align", "center");
            cellH1.Text = "";
            cellH1.Width = Unit.Percentage(5);
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "History";
            cellH2.Width = Unit.Percentage(30);
            cellH3.Attributes.Add("align", "Center");
            //cellH3.Text = "Duration";
            cellH3.Text = "Description";
            cellH3.Width = Unit.Percentage(20);
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Font.Bold = true;
            rowH.Font.Underline = true;
            rowH.Style.Add("color", "#333");
            PastMedicalHistoryTab.Rows.Add(rowH);
            foreach (IPComplaint objIPComplaint in list)
            {
                TableRow row1 = new TableRow();
                CheckBox chkBox = new CheckBox();
                TextBox txtBoxD = new TextBox();

                HiddenField hdnICDCode = new HiddenField();
                HiddenField hdnICDDesc = new HiddenField();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell5 = new TableCell();
                cell1.Attributes.Add("align", "center");
                chkBox.ID = "chkPMH" + objIPComplaint.ComplaintId.ToString();


                cell1.Controls.Add(chkBox);
                cell2.Attributes.Add("align", "left");
                cell2.Text = objIPComplaint.ComplaintName;
                cell3.Attributes.Add("align", "center");
                txtBoxD.ID = "txtBoxD" + objIPComplaint.ComplaintId.ToString();

                txtBoxD.Style.Add("width", "75px");


                cell3.Controls.Add(txtBoxD);


                hdnICDCode.ID = "hdnICDCode" + objIPComplaint.ComplaintId.ToString();
                hdnICDDesc.ID = "hdnICDDesc" + objIPComplaint.ComplaintId.ToString();

                hdnICDCode.Value = objIPComplaint.ICDCode;
                hdnICDDesc.Value = objIPComplaint.ICDDescription;

                cell4.Controls.Add(hdnICDCode);
                cell5.Controls.Add(hdnICDDesc);

                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);
                row1.Cells.Add(cell3);
                row1.Cells.Add(cell4);
                row1.Cells.Add(cell5);
                row1.Font.Bold = false;
                row1.Style.Add("color", "#000000");

                PastMedicalHistoryTab.Rows.Add(row1);
                hdnPastMedicalHistoryItems.Value += objIPComplaint.ComplaintId.ToString() + "~" + objIPComplaint.ComplaintName + "^";
            }

        }
    }

    public List<PatientHistory> GetPatientHistory()
    {
        List<PatientHistory> lstPatientHistoryTemp = new List<PatientHistory>();
        foreach (string listParentHistory in hdnHistoryItems.Value.Split('^'))
        {
            if (listParentHistory != "")
            {
                PatientHistory objPatientHistory = new PatientHistory();
                string[] listChildHistory = listParentHistory.Split('~');
                objPatientHistory.HistoryID = 0;
                objPatientHistory.HistoryName = listChildHistory[1];
                objPatientHistory.Description = listChildHistory[2] + " " + listChildHistory[3];
                objPatientHistory.CreatedBy = LID;
                objPatientHistory.PatientVisitID = patientVisitID;
                lstPatientHistoryTemp.Add(objPatientHistory);
            }
        }
        return lstPatientHistoryTemp;
    }

    public List<BackgroundProblem> GetBackgroundProblem()
    {
        List<BackgroundProblem> lstBackgroundProblemTemp = new List<BackgroundProblem>();
        foreach (string listParentBackgroundProblem in hdnPastMedicalHistoryItems.Value.Split('^'))
        {
            if (listParentBackgroundProblem != "")
            {
                BackgroundProblem objBackgroundProblem = new BackgroundProblem();
                string[] listChildHistory = listParentBackgroundProblem.Split('~');
                CheckBox chkBox = (CheckBox)PastMedicalHistoryTab.FindControl("chkPMH" + listChildHistory[0]);
                TextBox txtBox = (TextBox)PastMedicalHistoryTab.FindControl("txtBoxD" + listChildHistory[0]);
                HiddenField hdnICDCode = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDCode" + listChildHistory[0]);
                HiddenField hdnICDDesc = (HiddenField)PastMedicalHistoryTab.FindControl("hdnICDDesc" + listChildHistory[0]);
                if (chkBox.Checked)
                {
                    objBackgroundProblem.ComplaintID = Convert.ToInt32(listChildHistory[0]);
                    objBackgroundProblem.ComplaintName = listChildHistory[1];
                    objBackgroundProblem.Description = txtBox.Text;
                    objBackgroundProblem.CreatedBy = LID;
                    objBackgroundProblem.PatientVisitID = patientVisitID;
                    objBackgroundProblem.PatientID = patientID;
                    objBackgroundProblem.ICDCode = hdnICDCode.Value;
                    objBackgroundProblem.ICDDescription = hdnICDDesc.Value;
                    objBackgroundProblem.PreparedAt = "CRCB";
                    if (objBackgroundProblem.ICDCode == "")
                    {
                        objBackgroundProblem.ICDCodeStatus = "Pending";
                    }
                    else
                    {
                        objBackgroundProblem.ICDCodeStatus = "Completed";
                    }
                    lstBackgroundProblemTemp.Add(objBackgroundProblem);
                }
            }
        }

        if (chkPMHStroke.Checked)
        {
            BackgroundProblem objBackgroundProblem = new BackgroundProblem();
            objBackgroundProblem.ComplaintID = 438;
            objBackgroundProblem.ComplaintName = "Stroke(CVA)";
            if (txtPMHStroke.Text != "")
            {
                objBackgroundProblem.Description = txtPMHStroke.Text + " ^ " + ddlPMHStroke.Text;
            }
            else
            {
                objBackgroundProblem.Description = " ^ " + ddlPMHStroke.Text;
            }
            objBackgroundProblem.CreatedBy = LID;
            objBackgroundProblem.PatientVisitID = patientVisitID;
            objBackgroundProblem.PatientID = patientID;
            lstBackgroundProblemTemp.Add(objBackgroundProblem);

        }

        return lstBackgroundProblemTemp;
    }

    public ANCPatientDetails GetObstretricHistory()
    {
        ANCPatientDetails objANCPatientDetails = new ANCPatientDetails();
        if (txtAbortUs.Text != "")
        {
            objANCPatientDetails.Abortus = Convert.ToByte(txtAbortUs.Text);
        }
        objANCPatientDetails.CreatedBy = LID;
        if (txtCalculatedEDD.Text != "")
        {
            objANCPatientDetails.EDD = Convert.ToDateTime(txtCalculatedEDD.Text);
        }
        else
        {
            objANCPatientDetails.EDD = Convert.ToDateTime("01/01/1753");
        }
        if (tLMP.Text != "")
        {
            objANCPatientDetails.LMPDate = Convert.ToDateTime(tLMP.Text);
        }
        else
        {
            objANCPatientDetails.LMPDate = Convert.ToDateTime("01/01/1753");
        }
        if (txtGravida.Text != "")
        {
            objANCPatientDetails.Gravida = Convert.ToByte(txtGravida.Text);
        }
        if (txtLive.Text != "")
        {
            objANCPatientDetails.Live = Convert.ToByte(txtLive.Text);
        }
        if (txtPara.Text != "")
        {
            objANCPatientDetails.Para = Convert.ToByte(txtPara.Text);
        }
        objANCPatientDetails.PatientID = patientID;
        objANCPatientDetails.PatientVisitID = patientVisitID;

        return objANCPatientDetails;
    }


    public List<PatientExamination> GetPatientExamination()
    {
        List<PatientExamination> lstPatientExaminationTemp = new List<PatientExamination>();

        if (chkPallor.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 549;
            objPatientExamination.ExaminationName = "Pallor";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkIcterus.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 360;
            objPatientExamination.ExaminationName = "Icterus";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkOedema.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 535;
            objPatientExamination.ExaminationName = "Oedema";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkFever.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 272;
            objPatientExamination.ExaminationName = "Febrile";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkUnconscious.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 793;
            objPatientExamination.ExaminationName = "Unconsciousness";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkStuporous.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 857;
            objPatientExamination.ExaminationName = "Stuporous";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkDisorientation.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 190;
            objPatientExamination.ExaminationName = "Disorientation";
            lstPatientExaminationTemp.Add(objPatientExamination);
        }
        if (chkSwollenLymphNodes.Checked)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.PatientVisitID = patientVisitID;
            objPatientExamination.CreatedBy = LID;
            objPatientExamination.Description = "";
            objPatientExamination.ExaminationID = 853;
            objPatientExamination.ExaminationName = "Swollen Lymph Nodes";
            lstPatientExaminationTemp.Add(objPatientExamination);

            if (chkCervical.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 858;
                objPatientExamination1.ExaminationName = "Swollen Cervical Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
            if (chkInguinal.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 859;
                objPatientExamination1.ExaminationName = "Swollen Inguinal Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
            if (chkAbdominal.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 860;
                objPatientExamination1.ExaminationName = "Swollen Abdominal Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
            if (chkAxillary.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 861;
                objPatientExamination1.ExaminationName = "Swollen Axillary Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
            if (chkSubmandibular.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 862;
                objPatientExamination1.ExaminationName = "Swollen Submandibular Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
            if (chkAuricular.Checked)
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = "";
                objPatientExamination1.ExaminationID = 863;
                objPatientExamination1.ExaminationName = "Swollen Auricular Lymph Nodes";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (chkCVS.Checked == true)
        {
            if (txtCVS.Text != "" || txtCVS.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtCVS.Text;
                objPatientExamination1.ExaminationID = 864;
                objPatientExamination1.ExaminationName = "CVS";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (chkRS.Checked == true)
        {
            if (txtRS.Text != "" || txtRS.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtRS.Text;
                objPatientExamination1.ExaminationID = 865;
                objPatientExamination1.ExaminationName = "RS";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkABD.Checked == true)
        {
            if (txtABD.Text != "" || txtABD.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtABD.Text;
                objPatientExamination1.ExaminationID = 866;
                objPatientExamination1.ExaminationName = "ABD";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkCNS.Checked == true)
        {
            if (txtCNS.Text != "" || txtRS.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtCNS.Text;
                objPatientExamination1.ExaminationID = 867;
                objPatientExamination1.ExaminationName = "CNS";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkPR.Checked == true)
        {
            if (txtPR.Text != "" || txtRS.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtPR.Text;
                objPatientExamination1.ExaminationID = 868;
                objPatientExamination1.ExaminationName = "P/R";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkGenitalia.Checked == true)
        {
            if (txtGenitalia.Text != "" || txtGenitalia.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtGenitalia.Text;
                objPatientExamination1.ExaminationID = 869;
                objPatientExamination1.ExaminationName = "Genitalia";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkMusculoskeletal.Checked == true)
        {
            if (txtMusculoskeletal.Text != "" || txtMusculoskeletal.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtMusculoskeletal.Text;
                objPatientExamination1.ExaminationID = 932;
                objPatientExamination1.ExaminationName = "Musculoskeletal";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        if (ChkOthers.Checked == true)
        {
            if (txtExaminationOthers.Text != "" || txtExaminationOthers.Text == "")
            {
                PatientExamination objPatientExamination1 = new PatientExamination();
                objPatientExamination1.PatientVisitID = patientVisitID;
                objPatientExamination1.CreatedBy = LID;
                objPatientExamination1.Description = txtExaminationOthers.Text;
                objPatientExamination1.ExaminationID = 870;
                objPatientExamination1.ExaminationName = "Others";
                lstPatientExaminationTemp.Add(objPatientExamination1);
            }
        }
        return lstPatientExaminationTemp;
    }

    public RTAMLCDetails GetRTAMLCDetails()
    {
        RTAMLCDetails objRTAMLCDetails = new RTAMLCDetails();
        if (chkRTA.Checked == true)
        {
            if (chkRTAInfluenceOfDrugs.Checked)
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "Y";
            }
            else
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "N";
            }
            objRTAMLCDetails.FIRNo = txtRTAFIRNo.Text;
            objRTAMLCDetails.Location = txtRTALocation.Text;
            objRTAMLCDetails.PoliceStation = txtPoliceStation.Text;
            objRTAMLCDetails.MLCNo = txtPoliceContact.Text;

            if (txtFIRDate.Text != "")
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime(txtFIRDate.Text);
            }
            else
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
            }

            if (txtRTADate.Text != "")
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime(txtRTADate.Text);
            }
            else
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            }
        }
        else
        {
            objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
        }
        return objRTAMLCDetails;
    }

    public List<IPTreatmentPlan> GetIPTreatmentPlan()
    {
        List<IPTreatmentPlan> lstIPTreatmentPlanTemp = new List<IPTreatmentPlan>();
        foreach (string listParentTreatmentPlan in hdnIPTreatmentPlanItems.Value.Split('^'))
        {
            if (listParentTreatmentPlan != "")
            {
                IPTreatmentPlan objIPTreatmentPlan = new IPTreatmentPlan();
                string[] listChildTreatmentPlan = listParentTreatmentPlan.Split('~');


                objIPTreatmentPlan.PatientID = patientID;
                objIPTreatmentPlan.PatientVisitID = patientVisitID;
                objIPTreatmentPlan.IPTreatmentPlanID = Convert.ToInt32(listChildTreatmentPlan[2]);
                objIPTreatmentPlan.IPTreatmentPlanName = listChildTreatmentPlan[4];
                objIPTreatmentPlan.Prosthesis = listChildTreatmentPlan[5];
                objIPTreatmentPlan.ParentID = Convert.ToInt32(listChildTreatmentPlan[1]);
                objIPTreatmentPlan.ParentName = listChildTreatmentPlan[3];
                if (listChildTreatmentPlan[6] != "Will be scheduled later")
                {
                    objIPTreatmentPlan.TreatmentPlanDate = Convert.ToDateTime(listChildTreatmentPlan[6]);
                }

                objIPTreatmentPlan.Status = listChildTreatmentPlan[7];
                objIPTreatmentPlan.OrgID = OrgID;
                objIPTreatmentPlan.CreatedBy = LID;
                objIPTreatmentPlan.StagePlanned = "CRC";
                lstIPTreatmentPlanTemp.Add(objIPTreatmentPlan);
            }
        }
        return lstIPTreatmentPlanTemp;
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            #region Task inventory details
            List<DrugDetails> lstDrugDetails1 = new List<DrugDetails>();
            List<Tasks> isttaskid = new List<Tasks>();
            HiddenField hdnInvTaskID = (HiddenField)uIAdv.FindControl("hdnINVTaskID");
            new Tasks_BL(base.ContextInfo).GetTaskID(Convert.ToInt64(hdnInvTaskID.Value), out isttaskid);
            long TSTaskID = 0, flag = 0;
            if (isttaskid.Count > 0)
            {
                TSTaskID = isttaskid[0].TaskStatusID;
                if (TSTaskID == Convert.ToInt64(TaskHelper.TaskStatus.InProgress))
                {
                    flag = 1;
                }
                else if (TSTaskID == Convert.ToInt64(TaskHelper.TaskStatus.Deleted))
                {
                    flag = 2;
                }
                else
                {
                    flag = 0;
                }
            }
            #endregion
            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            btnFinish.Enabled = false;
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            lstPatientHistory = GetPatientHistory();
            //  lstPatientComplaint = GetPatientComplaint();
            long OnBehalf = -1;
            HiddenField hdnOnBehalfID = (HiddenField)uIAdv.FindControl("hdnOnBehalfID");
            if (IsCorporateOrg == "Y" && RoleName != RoleHelper.Physician)
            {
                OnBehalf = drpPhysician.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(drpPhysician.SelectedValue);
                hdnOnBehalfID.Value = OnBehalf.ToString();
            }
            else
            {
                PhysicianSchedule physician = new PhysicianSchedule();
                new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                if (RoleName == RoleHelper.Physician)
                {
                    OnBehalf = LID;
                }
                else
                {
                    OnBehalf = physician.PhysicianID;
                }
                hdnOnBehalfID.Value = "";
            }
            if (IsCorporateOrg == "Y")
            {
                List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
                ((HiddenField)InvestigationControl1.FindControl("hdnFromDate")).Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                lstPatientInvestHL = InvestigationControl1.GetNewOrderedListForHindu();
                List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();

                long returnCodeINV = -1;

                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
                if (lstPatientInvestHL.Count > 0)
                {
                    foreach (OrderedInvestigations inves in lstPatientInvestHL)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        objInvest.ID = inves.ID;
                        objInvest.Name = inves.Name;
                        objInvest.VisitID = patientVisitID;
                        objInvest.OrgID = OrgID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        objInvest.Status = "Paid";

                        //objInvest.ComplaintId = complaintID;
                        objInvest.CreatedBy = LID;
                        objInvest.Type = inves.Type;
                        objInvest.InvestigationsType = "CRC";
                        objInvest.RefPhyName = inves.GroupName; 
                        orderedInvesHL.Add(objInvest);
                    }
                }

                //int pOrderedInvCnt = 0;
                //int referedCount = -1;
                //string gUIDs = Guid.NewGuid().ToString();
                List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
                long ret = -1;
                int rets = -1;
                if (lstPatientInvestHL.Count > 0)
                {
                    #region Lab
                    string gUIDs = string.Empty;
                    if (Session["invGUID"] == null || Session["invGUID"] == "")
                    {
                        gUIDs = Guid.NewGuid().ToString();
                        string invGUID = string.Empty;
                        Session.Add("invGUID", gUIDs);
                        // gUIDs = Guid.NewGuid().ToString();
                    }
                    else
                    {
                        gUIDs = Session["invGUID"].ToString();
                    }
                    #endregion
                    returnCodeINV = ipBL.DeleteInPatientInvestigation(patientVisitID, OrgID);
                    ret = new Investigation_BL(base.ContextInfo).SaveIPOrderedInvestigation(orderedInvesHL, OrgID, out rets, gUIDs);
                }

                #region OrderPhysiotherapy                
                long returnCodePhysio = -1;
                List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
                if (hdnAddItems.Value != "")
                {
                    string comments = string.Empty;
                    
                    foreach (string physioItem in hdnAddItems.Value.Split('^'))
                    {
                        if (physioItem != "")
                        {
                            OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();
                            ptt.ProcedureID = Convert.ToInt64(physioItem.Split('~')[0]);
                            ptt.ProcedureName = physioItem.Split('~')[1].ToString();
                            ptt.OdreredQty = Convert.ToDecimal(physioItem.Split('~')[2]);
                            ptt.Status = "InProgress";
                            ptt.PaymentStatus = "";
                            ptt.PhysicianComments = physioItem.Split('~')[3].ToString();
                            lstOrderedPhysiotherapy.Add(ptt);
                        }
                    }
                }
                string orderBy = "ORDPHY";
                returnCodePhysio = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(patientVisitID, ILocationID, OrgID, LID, orderBy, lstOrderedPhysiotherapy, out PhysioCount);
                hdnAddItems.Value = "";
                hdnOrdered.Value = "";
                #endregion
            }
            lstPatientComplaint = ComplaintICDCode1.GetPatientComplaint("CRC", patientVisitID, OnBehalf);
            if (chkPastMedicalHistory.Checked)
            {
                lstBackgroundProblem = GetBackgroundProblem();
            }
            objANCPatientDetails = GetObstretricHistory();
            objRTAMLC = GetRTAMLCDetails();
            lstIPTreatmentPlan = GetIPTreatmentPlan();
            if (InvDrugData == "Y")
            {
                if (flag == 1)
                    lstDrugDetails = lstDrugDetails1;
                else
                    lstDrugDetails = uIAdv.GetPrescription(patientVisitID);
            }
            else
            {
                //lstDrugDetails = uAd.GetPrescription(patientVisitID);
            }
            //commented by sami
            // lstPatientVitals = GetPatientVitals();
            lstPatientExamination = GetPatientExamination();

            //lstOtherBackgroundProblem = GetOtherBackgroundProblem();
            lstOtherBackgroundProblem = ComplaintICDCodeBP1.GetPatientBackgroundProblem("CRCO", patientID, patientVisitID);

            //sami added below lines
            bool blnRetval = false;
            List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
            blnRetval = uctlPatientVitals.GetPageValues(out lstPatientVitals);
            long retCode = -1;
            IP_BL oIP_BL = new IP_BL(base.ContextInfo);
            List<PatientVitals> lstMaxOfVitalsSetID = new List<PatientVitals>();
            retCode = oIP_BL.GetMaxOfVitalsSetID(patientVisitID, out lstMaxOfVitalsSetID);

            foreach (var vitalsetid in lstMaxOfVitalsSetID)
            {
                NewVitalsSetID = vitalsetid.VitalsSetID;
            }

            foreach (PatientVitals patientVitals in lstPatientVitals)
            {

                patientVitals.VitalsSetID = NewVitalsSetID;
                patientVitals.PatientVisitID = patientVisitID;
                patientVitals.VitalsType = "Admission";
            }

            if (lstDrugDetails.Count > 0)
            {
                foreach (DrugDetails objDrugDetails in lstDrugDetails)
                {
                    objDrugDetails.PrescriptionType = "CRC";
                }
            }
            //sami added lines end

            lstPatientAdvice = uGAdv.GetGeneralAdvice(patientVisitID);
            string strNextReviewDate;
            if (chkReview.Checked == true)
            {
                strNextReviewDate = ddlNos.Text + "-" + ddlDMY.SelectedItem.Text;
            }
            else
            {
                strNextReviewDate = string.Empty;
            }
            string gUID = Guid.NewGuid().ToString();
            int ddDMY = -1;

            returnCode = ipBL.SaveIPCaseRecord(lstPatientHistory, lstPatientVitals, lstPatientExamination, lstPatientComplaint,
            lstIPTreatmentPlan, lstDrugDetails, objRTAMLC, lstBackgroundProblem, lstOtherBackgroundProblem, objANCPatientDetails, OrgID,
            patientVisitID, patientID, LID, fckHospitalCourse.Value, lstPatientAdvice, strNextReviewDate, DateTime.Parse(txtActualDate.Text));



            //this Blockcommented for no need of ICDCODE as mandatory .
            //if (lstPatientComplaint.Count == 0)
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Enter Patient Complaint.');", true);
            //    btnFinish.Enabled = true;
            //    return;
            //}
            //end 

            returnCode = OrthoEMR1.SaveOrthoPatientDetails(patientVisitID, patientID);
            if (returnCode == 0)
            {
                try
                {
                    if (Request.QueryString["rPage"] != null && Request.QueryString["rPage"] == "DSY")
                    {

                        Response.Redirect("../Physician/DischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);


                    }
                    else
                    {
                        string ViType="OP";
                        if (Session["VisitType"].ToString() =="1")
                        {
                            ViType="IP";
                        }
                        Response.Redirect("../Physician/IPCaseRecordSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&vType=" + Session["VisitType"] + "&PhysioCount=" + PhysioCount.ToString() + "&ViType=" + ViType, true);
                    }

                }
                catch (System.Threading.ThreadAbortException tae)
                {
                    string thread = tae.ToString();
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error while save IPCaseRecord.aspx  page", ex);
                }

            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string strTae = tae.ToString();
            btnFinish.Visible = true;
            btnFinish.Enabled = true;
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in Saving IP Case Record. Please contact system administrator";
            CLogger.LogError("Error while Saving IP Case Record in IPCaseRecord.aspx", ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (hdnToPreviousPage != null && hdnToPreviousPage.Value != null && hdnToPreviousPage.Value != "")
            {
                Response.Redirect(hdnToPreviousPage.Value, true);
                hdnToPreviousPage.Value = "";
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
            hdnToPreviousPage.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void btnPayment_Click(object sender, EventArgs e)
    {
        try
        {
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;

            long taskID = -1;


            //List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
            //lstPatientInvest = InvestigationControl1.GetNewOrderedList();
            //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
            List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
            ((HiddenField)InvestigationControl1.FindControl("hdnFromDate")).Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            lstPatientInvestHL = InvestigationControl1.GetNewOrderedListHOSLAB();
            List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();

            if (lstPatientInvestHL.Count > 0)
            {
                foreach (OrderedInvestigations inves in lstPatientInvestHL)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    objInvest.ID = inves.ID;
                    objInvest.Name = inves.Name;
                    objInvest.VisitID = patientVisitID;
                    objInvest.OrgID = OrgID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.Status = "Ordered";
                    objInvest.PaymentStatus = "Pending";
                    //objInvest.ComplaintId = complaintID;
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    objInvest.InvestigationsType = "CRC";
                    orderedInvesHL.Add(objInvest);
                }
            }

            long result = 0;
            int pOrderedInvCnt = 0;
            int referedCount = -1;
            int returnstatus = -1;

            long ret = -1;
            if (lstPatientInvestHL.Count > 0)
            {
                returnCode = ipBL.DeleteInPatientInvestigation(patientVisitID, OrgID);
                gUID = Guid.NewGuid().ToString();
                ret = new Investigation_BL(base.ContextInfo).SaveIPOrderedInvestigation(orderedInvesHL, OrgID, out returnstatus, gUID);
            }
            if (ret == 0)
            {
                returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out pOrderedInvCnt); //returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt);
            }
            if (result == 0)
            {
                if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    //Int64.TryParse(Request.QueryString["tid"], out taskID);

                    //returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

                    Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                    if (pOrderedInvCnt > 0)
                    {

                        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0,
                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //create task
                        returnCode = taskBL.CreateTaskAllowDuplicate(task, out taskID);
                    }
                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while saving investigation profile";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while saving investigation profile";
            CLogger.LogError("Error while saving Investigation Profile", ex);

        }
    }
    public void Loadphysician()
    {
        try
        {
            PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
            List<Physician> lstPhysician = new List<Physician>();
            returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysician);
            drpPhysician.DataSource = lstPhysician;
            drpPhysician.DataTextField = "PhysicianName";
            drpPhysician.DataValueField = "LoginID";
            drpPhysician.DataBind();
            drpPhysician.Items.Insert(0, "---Select---");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Physician Load", ex);
        }
    }
    //protected void btnCorOk_Click(object sender, EventArgs e)
    //{

    //List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
    //((HiddenField)InvestigationControl1.FindControl("hdnFromDate")).Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
    //lstPatientInvestHL = InvestigationControl1.GetNewOrderedListForHindu();
    //List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();

    //long returnCodeINV = -1;

    //Hashtable dText = new Hashtable();
    //Hashtable urlVal = new Hashtable();
    //Tasks task = new Tasks();
    //Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
    //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
    //if (lstPatientInvestHL.Count > 0)
    //{
    //    foreach (OrderedInvestigations inves in lstPatientInvestHL)
    //    {
    //        OrderedInvestigations objInvest = new OrderedInvestigations();
    //        objInvest.ID = inves.ID;
    //        objInvest.Name = inves.Name;
    //        objInvest.VisitID = patientVisitID;
    //        objInvest.OrgID = OrgID;
    //        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
    //        objInvest.Status = "Paid";
    //        //objInvest.ComplaintId = complaintID;
    //        objInvest.CreatedBy = LID;
    //        objInvest.Type = inves.Type;
    //        objInvest.InvestigationsType = "CRC";
    //        orderedInvesHL.Add(objInvest);
    //    }
    //}

    ////int pOrderedInvCnt = 0;
    ////int referedCount = -1;
    //gUID = Guid.NewGuid().ToString();
    //List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    //long ret = -1;
    //int rets = -1;
    //if (lstPatientInvestHL.Count > 0)
    //{
    //    returnCodeINV = ipBL.DeleteInPatientInvestigation(patientVisitID);
    //    ret = new Investigation_BL(base.ContextInfo).SaveIPOrderedInvestigation(orderedInvesHL, OrgID, out rets, gUID);
    //}
    //string invGUID = string.Empty;
    //Session.Add("invGUID", gUID);

    //if (ret == 0)
    //{
    //    returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out pOrderedInvCnt); //returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt);
    //}
    //List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
    //List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
    //List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
    //new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

    //foreach (var item in lstSampleDept1)
    //{
    //    if (item.Display == "Y")
    //    {
    //        Int64.TryParse(Request.QueryString["pid"], out patientID);
    //        //long createTaskID = -1;
    //        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
    //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
    //                     patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
    //                     lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
    //                     , out dText, out urlVal, 0, "", 0, gUID);
    //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
    //        task.DispTextFiller = dText;
    //        task.URLFiller = urlVal;
    //        task.RoleID = RoleID;
    //        task.OrgID = OrgID;
    //        task.PatientVisitID = patientVisitID;
    //        task.PatientID = patientID;
    //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
    //        task.CreatedBy = LID;
    //        //Create task               
    //        returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);

    //        break;
    //    }
    //}
    //foreach (var item in lstSampleDept1)
    //{
    //    if (item.Display == "N")
    //    {
    //        InvestigationValues inValues = new InvestigationValues();
    //        inValues.InvestigationID = item.InvestigationID;
    //        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
    //        inValues.PackageID = item.PackageID;
    //        inValues.PackageName = item.PackageName;

    //        lstInvResult.Add(inValues);
    //    }
    //}
    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:showInvestigationCtrl('');", true);
    //returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);

    //}

    protected void btnDueChart_Click(object sender, EventArgs e)
    {
        lstPatientInvestigation = InvestigationControl1.GetNewOrderedList();
        List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
        ((HiddenField)InvestigationControl1.FindControl("hdnFromDate")).Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        lstPatientInvestHL = InvestigationControl1.GetNewOrderedListHOSLAB();
        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();

        long returnCode = -1;
        long returnCodeINV = -1;
        long createTaskID = -1;

        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
        if (lstPatientInvestHL.Count > 0)
        {
            foreach (OrderedInvestigations inves in lstPatientInvestHL)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                objInvest.ID = inves.ID;
                objInvest.Name = inves.Name;
                objInvest.VisitID = patientVisitID;
                objInvest.OrgID = OrgID;
                objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                objInvest.Status = "Paid";
                //objInvest.ComplaintId = complaintID;
                objInvest.CreatedBy = LID;
                objInvest.Type = inves.Type;
                objInvest.InvestigationsType = "CRC";

                orderedInvesHL.Add(objInvest);
            }
        }

        int pOrderedInvCnt = 0;
        int referedCount = -1;
        gUID = Guid.NewGuid().ToString();

        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();

        long ret = -1;
        if (lstPatientInvestHL.Count > 0)
        {
            returnCodeINV = ipBL.DeleteInPatientInvestigation(patientVisitID, OrgID);
            string InterimBillNo = string.Empty;
            ret = new Investigation_BL(base.ContextInfo).SaveIPPaidInvestigationAndPatientIndents(orderedInvesHL, OrgID, out lstOrderedInv, patientVisitID, LID, patientID, gUID, out  InterimBillNo);
        }
        if (ret == 0)
        {
            returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out pOrderedInvCnt); //returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt);
        }
        List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
        List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
        List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

        foreach (var item in lstSampleDept1)
        {
            if (item.Display == "Y")
            {
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                //long createTaskID = -1;
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                             patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                             , out dText, out urlVal, 0, "", 0, gUID);
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create task               
                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);

                break;
            }
        }
        foreach (var item in lstSampleDept1)
        {
            if (item.Display == "N")
            {
                InvestigationValues inValues = new InvestigationValues();
                inValues.InvestigationID = item.InvestigationID;
                inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                inValues.PackageID = item.PackageID;
                inValues.PackageName = item.PackageName;

                lstInvResult.Add(inValues);
            }
        }

        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);
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

    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            fckHospitalCourse.ToolbarSet = "Attune";
            fckHospitalCourse.BasePath = sPath;
            fckHospitalCourse.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckHospitalCourse.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In DischargeSummary.aspx", ex);
        }
    }


    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
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
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void chkPriviousvisitdrug_CheckedChanged(object sender, EventArgs e)
    {
        string strNextReviewDt = string.Empty;
        string Priviousvisitdrug = string.Empty;
        if (chkPriviousvisitdrug.Checked == true)
            Priviousvisitdrug = "Y";
        else
            Priviousvisitdrug = "N";

        //Priviousvisitdrug = "Y";
        returnCode = ipBL.GetIPCaseRecord(patientVisitID, LID, RoleID, Priviousvisitdrug, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails,
            out lstRTAMLCDetails, out lstPatientComplaint, out lstIPTreatmentPlan, out lstBackgroundProblem, out lstPatientVitals,
            out lstANCPatientDetails, out lstPatientInvestigation, out lstIPPatientPerformedInvestigation, out lstPerformedIPTreatmentPlan,
            out lstOtherBackgroundProblem, out lstPatientHistoryExt, out lstPatientAdvice, out strNextReviewDt, out lstPrevVisits);
        if (returnCode == 0)
        {
            uIAdv.SetPrescription(lstDrugDetails);
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:CreateJavaScriptTables();", true);

    }

    public void LoadOrderProcedure()
    {
        try
        {
            long returnCode = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            long proTaskStatusID = -1;
            returnCode = patientBL.GetOrderedPhysio(patientID, patientVisitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);
            string Additems = string.Empty;
            if (lstOrderedPhysiotherapy.Count > 0)
            {
                for (int i = 0; i < lstOrderedPhysiotherapy.Count; i++)
                {
                    hdnOrdered.Value += lstOrderedPhysiotherapy[i].ProcedureID + "~" + lstOrderedPhysiotherapy[i].ProcedureName + "~" + String.Format("{0:0}", lstOrderedPhysiotherapy[i].OdreredQty) + "~" + lstOrderedPhysiotherapy[i].PhysicianComments + '^';
                }               
            }
            if (proTaskStatusID > 0)
            {
                Session.Add("ProTaskID", proTaskStatusID);
            }
            else
            {
                Session.Add("ProTaskID", proTaskStatusID);
            }
         }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadOrderProcedure", ex);
        }
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "HistoryDuration,DateAttributes,";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "HistoryDuration"
                                     select child;
                    ddlHistoryDuration.DataSource = childItems;
                    ddlHistoryDuration.DataTextField = "DisplayText";
                    ddlHistoryDuration.DataValueField = "Code";
                    ddlHistoryDuration.DataBind();
                    ddlHistoryDuration.Items.Insert(0, "--Select--");
                    ddlHistoryDuration.Items[0].Value = "0";

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "DateAttributes"
                                      select child;
                    //var childItems11 = from childI1 in childItems1 where childI1.DisplayText == "Day(s)" select childI1;
                    ddlDMY.DataSource = childItems1;
                    ddlDMY.DataTextField = "DisplayText";
                    ddlDMY.DataValueField = "DisplayText";
                    ddlDMY.DataBind();

                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
}