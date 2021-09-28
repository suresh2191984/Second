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
using System.Web.UI.HtmlControls;
using Attune.Podium.SmartAccessor;
using Attune.Podium.EMR;

public partial class BloodBank_DonorScreening : BasePage
{
    byte g = 0;
    byte p = 0;
    byte l = 0;
    byte a = 0;
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    int SpecialityID = -1;
    long returnCode = -1;
    bool blDig = true;
    bool blInves = true;
    Control myControl = null;
    Control objCtrl, objCtrl1, objCtrl2, objCtrl3;
    //EMR_History oDiaCtrl;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstskin = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lsthair = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientDiagnosticsAttribute> lstPDA = new List<PatientDiagnosticsAttribute>();
    List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    ArrayList lstControl = new ArrayList();
    ArrayList lstpatternID = new ArrayList();
    ArrayList lstPatientASel = new ArrayList();
    public bool IsControlAdded
    {
        get
        {
            if (ViewState["IsControlAdded"] == null)
                ViewState["IsControlAdded"] = false;
            return (bool)ViewState["IsControlAdded"];
        }
        set
        {
            ViewState["IsControlAdded"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;

        if (Request.QueryString["sid"] != null)
        {
            Int32.TryParse(Request.QueryString["sid"], out SpecialityID);
        }
        else
        {
            Int32.TryParse(Request.QueryString["SpecialityID"], out SpecialityID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        AddUserControl();
        if (!IsPostBack)
        {
            try
            {
                if (hdnControl.Value != "")
                {
                    showHistory();
                }
                GetSystemicExaminatiom();
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
    }
    void EMR_btnSampleClk(object sender, EventArgs e)
    {
        //HealthPackageControls_DiabetesMellitus editemr = ((HealthPackageControls_DiabetesMellitus)(sender));
    }
    protected void objDiab_btnSampleClick(object sender, EventArgs e)
    {

    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
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
    public void GetSystemicExaminatiom()
    {
        PatientVitalsControl.LoadControls("U", patientID);
        long retCode = 0;
        List<Examination> lstExamination = new List<Examination>();
        List<PatientExamination> lstPatExamination = new List<PatientExamination>();
        retCode = new Neonatal_BL(base.ContextInfo).GetSystemicExaminatiom(out lstExamination);
        foreach (Examination objExam in lstExamination)
        {
            if (objExam.ExaminationName == "CVS")
            {
                txtrdoYes_vascular.Text = objExam.ExaminationDesc;
            }
            else if (objExam.ExaminationName == "RS")
            {
                txtrdoYes_Respiratory.Text = objExam.ExaminationDesc;
            }
            else if (objExam.ExaminationName == "ABD")
            {
                txtrdoYes_Abdominal.Text = objExam.ExaminationDesc;
            }
            else if (objExam.ExaminationName == "CNS")
            {
                txtrdoYes_Neurological.Text = objExam.ExaminationDesc;
            }
        }
        retCode = new Patient_BL(base.ContextInfo).GetPatientExamination(patientID, visitID, out lstPatExamination);
        foreach (PatientExamination objPatExam in lstPatExamination)
        {
            if (objPatExam.ExaminationID == 864)
            {
                if (txtrdoYes_vascular.Text == objPatExam.Description)
                {
                    rdoYes_vascular.Checked = true;
                    divrdoYes_vascular.Style.Add("display", "block");
                }
                else
                {
                    rdoNo_vascular.Checked = true;
                    txtrdoNo_vascular.Text = objPatExam.Description;
                    divrdoNo_vascular.Style.Add("display", "block");
                }
            }
            else if (objPatExam.ExaminationID == 865)
            {
                if (txtrdoYes_Respiratory.Text == objPatExam.Description)
                {
                    rdoYes_Respiratory.Checked = true;
                    divrdoYes_Respiratory.Style.Add("display", "block");
                }
                else
                {
                    rdoNo_Respiratory.Checked = true;
                    txtrdoNo_Respiratory.Text = objPatExam.Description;
                    divrdoNo_Respiratory.Style.Add("display", "block");
                }
            }
            else if (objPatExam.ExaminationID == 866)
            {
                if (txtrdoYes_Abdominal.Text == objPatExam.Description)
                {
                    rdoYes_Abdominal.Checked = true;
                    divrdoYes_Abdominal.Style.Add("display", "block");
                }
                else
                {
                    rdoNo_Abdominal.Checked = true;
                    txtrdoNo_Abdominal.Text = objPatExam.Description;
                    divrdoNo_Abdominal.Style.Add("display", "block");
                }
            }
            else if (objPatExam.ExaminationID == 867)
            {
                if (txtrdoYes_Neurological.Text == objPatExam.Description)
                {
                    rdoYes_Neurological.Checked = true;
                    divrdoYes_Neurological.Style.Add("display", "block");
                }
                else
                {
                    rdoNo_Neurological.Checked = true;
                    txtrdoNo_Neurological.Text = objPatExam.Description;
                    divrdoNo_Neurological.Style.Add("display", "block");
                }
            }
            else if (objPatExam.ExaminationID == 914)
            {
                //rdoYes_Other.Checked = true;
                //divrdoYes_Other.Style.Add("display", "block");
                txtrdoYes_Other.Text = objPatExam.Description;
            }
        }
    }
    protected void SaveData(string PS1, string PS2, string TS1, string TS2, string ES1, string ES2)
    {
        long returncode = -1;
        List<DrugDetails> pAdvices = new List<DrugDetails>();
        List<PatientPastVaccinationHistory> lstSavePriorVacc = new List<PatientPastVaccinationHistory>();
        List<PatientPastVaccinationHistory> pVaccinationDetails = new List<PatientPastVaccinationHistory>();
        List<GPALDetails> pGPALDetails = new List<GPALDetails>();
        List<GPALDetails> savegpaldetails = new List<GPALDetails>();
        List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();
        List<SurgicalDetail> lstSurgicalDetail = new List<SurgicalDetail>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        ArrayList lstPatientSel = new ArrayList();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        ArrayList result = new ArrayList();
        try
        {
            //btnSave.Enabled = false;
            if (divHistory1.Style.Value == "display: block" || divHistory2.Style.Value == "display: block")
            {
                //#region History Save
                List<PatientComplaint> attribute = new List<PatientComplaint>();
                List<PatientComplaint> attributetemp = new List<PatientComplaint>();
                List<PatientComplaintAttribute> attrValue = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> attrValuetemp = new List<PatientComplaintAttribute>();
                List<PatientHistory> attribute1 = new List<PatientHistory>();
                List<PatientHistory> attributetemp1 = new List<PatientHistory>();
                List<PatientHistoryAttribute> attrValue1 = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> attrValuetemp1 = new List<PatientHistoryAttribute>();
                List<PatientPastVaccinationHistory> attributeVaccine = new List<PatientPastVaccinationHistory>();
                List<PatientPastVaccinationHistory> attributeVaccinetemp = new List<PatientPastVaccinationHistory>();
                List<SurgicalDetail> attributeSurgical = new List<SurgicalDetail>();
                List<SurgicalDetail> attributeSurgicaltemp = new List<SurgicalDetail>();
                result = (ArrayList)ViewState["ControlID"];
                lstpatternID = (ArrayList)ViewState["PatternID"];
                lstPatientASel = (ArrayList)ViewState["Name"];

                for (int i = 0; i < result.Count; i++)
                {
                    attribute = new List<PatientComplaint>();
                    attrValue = new List<PatientComplaintAttribute>();
                    attributetemp = new List<PatientComplaint>();
                    attrValuetemp = new List<PatientComplaintAttribute>();
                    attribute1 = new List<PatientHistory>();
                    attributetemp1 = new List<PatientHistory>();
                    attrValue1 = new List<PatientHistoryAttribute>();
                    attrValuetemp1 = new List<PatientHistoryAttribute>();
                    string strControlName = result[i].ToString();
                    switch (Convert.ToInt32(lstpatternID[i]))
                    {
                        case (Int32)TaskHelper.BloodBankPattern.OneTextPattern:
                            BloodBank_DynamicUserControl DC1;
                            DC1 = (BloodBank_DynamicUserControl)this.Page.FindControl(result[i].ToString());
                            if (lstPatientASel[i] == "Complaint")
                                DC1.GetData(out attribute, out attrValue);
                            else
                                DC1.GetData(out attribute1, out attrValue1);
                            break;
                        case (Int32)TaskHelper.BloodBankPattern.OneDropdownPattern:
                            BloodBank_DynamicUserControl3 DC3;
                            DC3 = (BloodBank_DynamicUserControl3)this.Page.FindControl(result[i].ToString());
                            if (lstPatientASel[i] == "Complaint")
                                DC3.GetData(out attribute, out attrValue);
                            else
                                DC3.GetData(out attribute1, out attrValue1);
                            break;
                        case (Int32)TaskHelper.BloodBankPattern.ThreeDropdowns:
                            BloodBank_DynamicUserControl2 DC2;
                            DC2 = (BloodBank_DynamicUserControl2)this.Page.FindControl(result[i].ToString());
                            if (lstPatientASel[i] == "Complaint")
                                DC2.GetData(out attribute, out attrValue);
                            else
                                DC2.GetData(out attribute1, out attrValue1);
                            break;
                        default:
                            break;
                        //                case "ucLiver":
                        //                    HealthPackageControls_Liver objLi = (HealthPackageControls_Liver)this.FindControl("ucLiver");
                        //                    objLi.GetData(out attribute, out attrValue);
                        //                    break;

                    }
                    attributetemp = AddComplaint(attribute);
                    attrValuetemp = AddComplaintAtt(attrValue);
                    attributetemp1 = AddHistory(attribute1);
                    attrValuetemp1 = AddHistoryAtt(attrValue1);
                    attributeVaccine = AddVaccination(attributeVaccine);
                    attributeSurgicaltemp = AddSurgery(attributeSurgical);
                    lstPatientComplaint = lstPatientComplaint.Concat(attributetemp).ToList();
                    lstPatientComplaintAttribute = lstPatientComplaintAttribute.Concat(attrValuetemp).ToList();
                    lstPatientHisPKG = lstPatientHisPKG.Concat(attributetemp1).ToList();
                    lstPatientHisPKGAttributes = lstPatientHisPKGAttributes.Concat(attrValuetemp1).ToList();
                }

                pVaccinationDetails = pVaccinationDetails.Concat(attributeVaccine).ToList();
                lstSurgicalDetail = lstSurgicalDetail.Concat(attributeSurgicaltemp).ToList();
                foreach (PatientPastVaccinationHistory ppvh in pVaccinationDetails)
                {
                    ppvh.PatientVisitID = visitID;
                }
                returncode = new Patient_BL(base.ContextInfo).SaveHistoryPKG(lstPatientHisPKG, lstPatientHisPKGAttributes, pAdvices, pVaccinationDetails, pGPALDetails, g, p, l, a, "", lstPatientComplaint, lstPatientComplaintAttribute, lstSurgicalDetail, LID, visitID, patientID);
                if (returncode == 0)
                {
                    returncode = new BloodBank_BL(base.ContextInfo).InsertOrUpdateDonorStatus(visitID, PS1, PS2, TS1, TS2, ES1, ES2);
                }
                if (returncode == 0)
                {
                    //AddUserControl();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('History saved successfully.');", true);
                    hdnButton.Value += "~btnExam~";
                    showExamination();
                    lblHistoryStatus.Text = "Completed";
                }
            }

            else if (divExam.Style.Value == "display: block")
            {

                List<PatientExamination> pExamination = new List<PatientExamination>();
                if (rdoYes_Abdominal.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 866;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoYes_Abdominal.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                else if (rdoNo_Abdominal.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 866;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoNo_Abdominal.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                if (rdoYes_vascular.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 864;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoYes_vascular.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                else if (rdoNo_vascular.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 864;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoNo_vascular.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                if (rdoYes_Neurological.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 867;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoYes_Neurological.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                else if (rdoNo_Neurological.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 867;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoNo_Neurological.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                if (rdoYes_Respiratory.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 865;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoYes_Respiratory.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                else if (rdoNo_Respiratory.Checked == true)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 865;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoNo_Respiratory.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                if (txtrdoYes_Other.Text != "")
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 914;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtrdoYes_Other.Text;
                    pexOth.CreatedBy = LID;
                    pExamination.Add(pexOth);
                }
                returnCode = new Uri_BL(base.ContextInfo).SaveExamination(pExamination);
                if (returnCode == 0)
                {
                    returnCode = new BloodBank_BL(base.ContextInfo).InsertOrUpdateDonorStatus(visitID, PS1, PS2, TS1, TS2, ES1, ES2);
                }
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                List<DonorStatus> lstDonorStatus = new List<DonorStatus>();
                if (returnCode == 0 && hdnPS2.Value == "Y" && hdnES2.Value == "Y")
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    returnCode = new BloodBank_BL(base.ContextInfo).GetDonorDetailsAndStatus(visitID, out lstPatientVisitDetails, out lstDonorStatus);
                    long taskIDReffered = -1;
                    long pSpecialityID = Convert.ToInt32(TaskHelper.speciality.BloodBank);
                    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.BloodDonation), visitID, 0,
                     patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName + "", "", pSpecialityID, "", 0, "", 0, "", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.BloodDonation);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.SpecialityID = Convert.ToInt32(pSpecialityID);
                    //task.BillID = FinalBillID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    //task.RefernceID = labno.ToString();
                    //Create task               
                    returnCode = taskBL.CreateTask(task, out taskIDReffered);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Examination saved successfully.');", true);
                    hdnButton.Value += "~btnOrderInv~";
                    showInvestigation();
                    lblExamStatus.Text = "Completed";
                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                }
                //if(hdnES2.Value=="Y")
                //{
                //    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                //    Response.Redirect("Home.aspx");
                //}
                //else
                //Response.Redirect(@"../Patient/ViewEMRPackages.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&pSex=" + hdnSex.Value + "&Show=Y" + "", true);
            }
            if (hdnPS2.Value == "N" || hdnTS2.Value == "N" || hdnES2.Value=="N")
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                Response.Redirect("Home.aspx");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save PatientHistory Package", ex);
        }
        //        #endregion
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            char PS1 = ' ';
            char PS2 = ' ';
            char TS1 = ' ';
            char TS2 = ' ';
            char ES1 = ' ';
            char ES2 = ' ';
            if (divHistory1.Style.Value == "display: block" || divHistory2.Style.Value == "display: block")
            {
                PS1 = Convert.ToChar(hdnPS1.Value);
                TS1 = Convert.ToChar(hdnTS1.Value);
                PS2 = Convert.ToChar(hdnPS2.Value);
                TS2 = 'Y';
                hdnTS2.Value = "Y";
            }
            else if (divExam.Style.Value == "display: block")
            {
                ES1 = Convert.ToChar(hdnES1.Value);
                ES2 = 'Y';
                hdnES2.Value = "Y";
            }
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2), Convert.ToString(ES1), Convert.ToString(ES2));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
            btnSave.Enabled = true;
        }
    }
    public List<PatientHistory> AddHistory(List<PatientHistory> lstdetails)
    {

        List<PatientHistory> lstdet;// = lstdetails;
        lstdet = new List<PatientHistory>();
        int count = lstdetails.Count;
        PatientHistory lstitem1;
        for (int i = 0; i < count; i++)
        {
            lstitem1 = new PatientHistory();

            lstitem1.HistoryID = lstdetails[i].HistoryID;
            lstitem1.HistoryName = lstdetails[i].HistoryName;
            lstitem1.CreatedAt = lstdetails[i].CreatedAt;
            lstitem1.CreatedBy = lstdetails[i].CreatedBy;
            lstdet.Add(lstitem1);
            lstitem1 = null;
        }
        return lstdet;
    }
    public List<PatientHistoryAttribute> AddHistoryAtt(List<PatientHistoryAttribute> lstdetails)
    {

        List<PatientHistoryAttribute> lstdet = lstdetails;
        lstdet = new List<PatientHistoryAttribute>();

        int count = lstdetails.Count;
        PatientHistoryAttribute lstitem2;
        for (int i = 0; i < count; i++)
        {
            lstitem2 = new PatientHistoryAttribute();
            lstitem2.HistoryID = lstdetails[i].HistoryID;
            //lstitem2.HistoryName = lstdetails[i].ComplaintName;
            lstitem2.AttributeID = lstdetails[i].AttributeID;
            lstitem2.AttributevalueID = lstdetails[i].AttributevalueID;
            lstitem2.AttributeValueName = lstdetails[i].AttributeValueName;
            lstitem2.CreatedAt = lstdetails[i].CreatedAt;
            lstitem2.CreatedBy = lstdetails[i].CreatedBy;
            lstdet.Add(lstitem2);
            lstitem2 = null;
        }
        return lstdet;
    }
    public List<PatientComplaint> AddComplaint(List<PatientComplaint> lstdetails)
    {

        List<PatientComplaint> lstdet;// = lstdetails;
        lstdet = new List<PatientComplaint>();
        int count = lstdetails.Count;
        PatientComplaint lstitem1;
        for (int i = 0; i < count; i++)
        {
            lstitem1 = new PatientComplaint();

            lstitem1.ComplaintID = lstdetails[i].ComplaintID;
            lstitem1.ComplaintName = lstdetails[i].ComplaintName;
            lstitem1.ComplaintType = lstdetails[i].ComplaintType;
            lstitem1.CreatedAt = lstdetails[i].CreatedAt;
            lstitem1.CreatedBy = lstdetails[i].CreatedBy;
            lstdet.Add(lstitem1);
            lstitem1 = null;
        }
        return lstdet;
    }
    public List<PatientPastVaccinationHistory> AddVaccination(List<PatientPastVaccinationHistory> lstdetails)
    {

        List<PatientPastVaccinationHistory> lstdet;// = lstdetails;
        lstdet = new List<PatientPastVaccinationHistory>();
        int count = lstdetails.Count;
        PatientPastVaccinationHistory lstitem1;
        for (int i = 0; i < count; i++)
        {
            lstitem1 = new PatientPastVaccinationHistory();

            lstitem1.VaccinationID = lstdetails[i].VaccinationID;
            lstitem1.VaccinationName = lstdetails[i].VaccinationName;
            lstitem1.YearOfVaccination = lstdetails[i].YearOfVaccination;
            lstitem1.MonthOfVaccination = lstdetails[i].MonthOfVaccination;
            lstitem1.MonthName = lstdetails[i].MonthName;
            lstitem1.VaccinationDose = lstdetails[i].VaccinationDose;
            lstitem1.IsBooster = lstdetails[i].IsBooster;
            lstdet.Add(lstitem1);
            lstitem1 = null;
        }
        return lstdet;
    }
    public List<SurgicalDetail> AddSurgery(List<SurgicalDetail> lstdetails)
    {

        List<SurgicalDetail> lstdet;// = lstdetails;
        lstdet = new List<SurgicalDetail>();
        int count = lstdetails.Count;
        SurgicalDetail lstitem1;
        for (int i = 0; i < count; i++)
        {
            lstitem1 = new SurgicalDetail();

            lstitem1.SurgeryID = lstdetails[i].SurgeryID;
            lstitem1.SurgeryName = lstdetails[i].SurgeryName;
            lstitem1.TreatmentPlanDate = lstdetails[i].TreatmentPlanDate;
            lstitem1.HospitalName = lstdetails[i].HospitalName;
            lstitem1.ParentName = lstdetails[i].ParentName;
            lstdet.Add(lstitem1);
            lstitem1 = null;
        }
        return lstdet;
    }
    public List<PatientComplaintAttribute> AddComplaintAtt(List<PatientComplaintAttribute> lstdetails)
    {

        List<PatientComplaintAttribute> lstdet = lstdetails;
        lstdet = new List<PatientComplaintAttribute>();

        int count = lstdetails.Count;
        PatientComplaintAttribute lstitem2;
        for (int i = 0; i < count; i++)
        {
            lstitem2 = new PatientComplaintAttribute();
            lstitem2.ComplaintID = lstdetails[i].ComplaintID;
            //lstitem1.ComplaintName = lstdetails[i].ComplaintName;
            lstitem2.AttributeID = lstdetails[i].AttributeID;
            lstitem2.AttributevalueID = lstdetails[i].AttributevalueID;
            lstitem2.AttributeValueName = lstdetails[i].AttributeValueName;
            lstitem2.CreatedAt = lstdetails[i].CreatedAt;
            lstitem2.CreatedBy = lstdetails[i].CreatedBy;
            lstdet.Add(lstitem2);
            lstitem2 = null;
        }
        return lstdet;
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
    protected void LoadData()
    {

    }
    public List<String> LstTextBoxId
    {
        get
        {
            if (ViewState["LstTextBoxId"] == null)
                ViewState["LstTextBoxId"] = new List<String>();
            return (List<String>)ViewState["LstTextBoxId"];
        }
        set
        {
            ViewState["LstTextBoxId"] = value;
        }
    }
    public List<String> LstAjaxTextBoxId
    {
        get
        {
            if (ViewState["LstAjaxTextBoxId"] == null)
                ViewState["LstAjaxTextBoxId"] = new List<String>();
            return (List<String>)ViewState["LstAjaxTextBoxId"];
        }
        set
        {
            ViewState["LstAjaxTextBoxId"] = value;
        }
    }
    protected void showHistory()
    {
        btnHistory.Attributes.Add("style", "display: block");
        btnHistory1.Attributes.Add("style", "display: none");
        btnOrderInv.Attributes.Add("style", "display: block");
        btnExam.Attributes.Add("style", "display: none");
        btnOrderInv.Enabled = false;
        hdnButton.Value += "~btnHistory~";
        btnHistory.Enabled = true;
        btnHistory.Width = 60;
        btnHistory1.Enabled = false;
        btnHistory1.Width = 50;
        btnExam.Enabled = false;
        btnExam.Width = 50;
        btnOrderInv.Enabled = false;
        btnOrderInv.Width = 50;
        divHistory1.Attributes.Add("style", "display: block");
        drawNewHistory.Visible = true;
        divExam.Attributes.Add("style", "display: none");
        lblHistory.Font.Size = FontUnit.Large;
        lblHistory.Font.Bold = true;
        lblHistory.Font.Underline = true;
        lblExamination.Font.Size = FontUnit.Small;
        lblExamination.Font.Bold = false;
        lblExamination.Font.Underline = false;
        lblInvestigation.Font.Size = FontUnit.Small;
        lblInvestigation.Font.Bold = false;
        lblInvestigation.Font.Underline = false;
        divInvestigation.Attributes.Add("style", "display: none");
        divSave.Attributes.Add("style", "display: none");
    }
    protected void btnHistory_Click(object sender, EventArgs e)
    {
        showHistory();
    }
    protected void showExamination()
    {
        hdnButton.Value += "~btnExam~";
        btnHistory.Enabled = false;
        btnHistory.Width = 50;
        btnHistory1.Enabled = true;
        btnHistory1.Width = 60;
        btnHistory.Attributes.Add("style", "display: none");
        btnHistory1.Attributes.Add("style", "display: block");
        btnExam.Attributes.Add("style", "display: none");
        btnOrderInv.Attributes.Add("style", "display: block");
        divHistory1.Attributes.Add("style", "display: none");
        btnExam.Enabled = false;
        btnExam.Width = 50;
        btnOrderInv.Enabled = true;
        btnOrderInv.Width = 60;
        drawNewHistory.Visible = false;
        divExam.Attributes.Add("style", "display: block");
        divInvestigation.Attributes.Add("style", "display: none");
        divSave.Attributes.Add("style", "display: block");
        btnSave.Visible = true;
        lblExamination.Font.Size = FontUnit.Large;
        lblExamination.Font.Bold = true;
        lblExamination.Font.Underline = true;
        lblInvestigation.Font.Size = FontUnit.Small;
        lblInvestigation.Font.Bold = false;
        lblInvestigation.Font.Underline = false;
        lblHistory.Font.Size = FontUnit.Small;
        lblHistory.Font.Bold = false;
        lblHistory.Font.Underline = false;
    }
    protected void btnExam_Click(object sender, EventArgs e)
    {
        showExamination();
    }
    protected void showInvestigation()
    {
        btnOrderInv.Attributes.Add("style", "display: none");
        btnExam.Attributes.Add("style", "display: block");
        btnHistory1.Attributes.Add("style", "display: block");
        btnHistory1.Enabled = false;
        btnOrderInv.Enabled = false;
        btnOrderInv.Width = 50;
        btnExam.Enabled = true;
        btnExam.Width = 60;
        btnHistory.Enabled = false;
        btnHistory.Width = 50;
        btnHistory1.Enabled = false;
        btnHistory1.Width = 50;
        divHistory1.Attributes.Add("style", "display: none");
        divExam.Attributes.Add("style", "display: none");
        divInvestigation.Attributes.Add("style", "display: block");
        divSave.Attributes.Add("style", "display: none");
        lblExamination.Font.Size = FontUnit.Small;
        lblExamination.Font.Bold = false;
        lblExamination.Font.Underline = false;
        lblInvestigation.Font.Size = FontUnit.Large;
        lblInvestigation.Font.Bold = true;
        lblInvestigation.Font.Underline = true;
        lblHistory.Font.Size = FontUnit.Small;
        lblHistory.Font.Bold = false;
        lblHistory.Font.Underline = false;
    }
    protected void btnOrderInv_Click(object sender, EventArgs e)
    {
        showInvestigation();
    }
    protected void AddUserControl()
    {
        //if (hdnControl.Value == "")
        //{
        TableRow tr = null;
        TableCell tc = null;
        TableRow trhead = null;
        TableCell tchead = null;

        //tr1.Cells.Add(tc1);

        string strControl = string.Empty;
        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        tblMedicalHistory.Rows.Clear();
        //tblFamilyHistory.Rows.Clear();
        //tblPersonalHistory.Rows.Clear();
        //tblSocialHistory.Rows.Clear();
        //tblSurgicalHistory.Rows.Clear();
        tblTreatmentHistory.Rows.Clear();
        returnCode = new BloodBank_BL(base.ContextInfo).GetPatientHistoryPKGEditForBloodBank(visitID, LID, SpecialityID, OrgID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);
        long HID = 0; long CID = 0;
        string Control = string.Empty;
        string Heading = string.Empty;
        int PatternID = -1;
        #region ComplaintItems
        if (lsthisPCA.Count > 0)
        {
            hdnComplaintControl.Value = "";
            Control objCtrl = null;
            for (int i = 0; i < lsthisPCA.Count; i++)
            {
                if (lsthisPCA[i].PatternID != -1)
                {
                    strControl = lsthisPCA[i].ControlName;
                    Heading = strControl.Split('^')[0];
                    Control = strControl.Split('^')[1];
                    PatternID = lsthisPCA[i].PatternID;
                    //trhead = new TableRow();
                    //tchead = new TableCell();
                    //tchead.Text = Heading;
                    //trhead.Cells.Add(tchead);
                    //trhead.ForeColor = System.Drawing.Color.Blue;
                    //trhead.Font.Bold = true;
                    //trhead.Font.Size = 10;

                    tr = new TableRow();
                    tc = new TableCell();
                    if (Heading == "MedicalHistory")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblMedicalHistory.Rows.Add(tr);
                            tblMedicalHistory.Visible = true;
                        }
                    }
                    else if (Heading == "TreatmentHistory")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblTreatmentHistory.Rows.Add(tr);
                            tblTreatmentHistory.Visible = true;
                        }
                    }
                    else if (Heading == "Today")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblToday.Rows.Add(tr);
                            tblToday.Visible = true;
                        }
                    }
                    else if (Heading == "Past1to3days")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast1to3days.Rows.Add(tr);
                            tblPast1to3days.Visible = true;
                        }
                    }
                    else if (Heading == "Past6weeks")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast6weeks.Rows.Add(tr);
                            tblPast6weeks.Visible = true;
                        }
                    }
                    else if (Heading == "Past8weeks")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast8weeks.Rows.Add(tr);
                            tblPast8weeks.Visible = true;
                        }
                    }
                    else if (Heading == "Past3months")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast3months.Rows.Add(tr);
                            tblPast3months.Visible = true;
                        }
                    }
                    else if (Heading == "Past6monthsto1year")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast6mnthsto1year.Rows.Add(tr);
                            tblPast6mnthsto1year.Visible = true;
                        }
                    }
                    else if (Heading == "Past1year")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast1year.Rows.Add(tr);
                            tblPast1year.Visible = true;
                        }
                    }
                    else if (Heading == "Past3years")
                    {
                        if (Convert.ToString(hdnComplaintControl.Value) != Control)
                        {
                            CID = lsthisPCA[i].ComplaintID; HID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast3years.Rows.Add(tr);
                            tblPast3years.Visible = true;
                        }
                    }
                    hdnComplaintControl.Value = Control;
                }
            }
        }

        #endregion
        #region HistoryItems
        if (lsthisPHA.Count > 0)
        {
            hdnHistoryControl.Value = "";
            for (int j = 0; j < lsthisPHA.Count; j++)
            {
                if (lsthisPHA[j].PatternID != -1)
                {
                    strControl = lsthisPHA[j].ControlName;
                    Heading = strControl.Split('^')[0];
                    Control = strControl.Split('^')[1];
                    PatternID = lsthisPHA[j].PatternID;
                    //trhead = new TableRow();
                    //tchead = new TableCell();
                    //tchead.Text = Heading;
                    //trhead.Cells.Add(tchead);
                    //trhead.ForeColor = System.Drawing.Color.Blue;
                    //trhead.Font.Bold = true;
                    //trhead.Font.Size = 10;
                    Control objCtrl = null;
                    tr = new TableRow();
                    tc = new TableCell();

                    if (Heading == "MedicalHistory")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblMedicalHistory.Rows.Add(tr);
                            tblMedicalHistory.Visible = true;
                        }

                    }
                    else if (Heading == "TreatmentHistory")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblTreatmentHistory.Rows.Add(tr);
                            tblTreatmentHistory.Visible = true;
                        }
                    }
                    else if (Heading == "Today")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblToday.Rows.Add(tr);
                            tblToday.Visible = true;
                        }
                    }
                    else if (Heading == "Past1to3days")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast1to3days.Rows.Add(tr);
                            tblPast1to3days.Visible = true;
                        }
                    }
                    else if (Heading == "Past6weeks")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast6weeks.Rows.Add(tr);
                            tblPast6weeks.Visible = true;
                        }
                    }
                    else if (Heading == "Past8weeks")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast8weeks.Rows.Add(tr);
                            tblPast8weeks.Visible = true;
                        }
                    }
                    else if (Heading == "Past3months")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast3months.Rows.Add(tr);
                            tblPast3months.Visible = true;
                        }
                    }
                    else if (Heading == "Past6monthsto1year")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast6mnthsto1year.Rows.Add(tr);
                            tblPast6mnthsto1year.Visible = true;
                        }
                    }
                    else if (Heading == "Past1year")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast1year.Rows.Add(tr);
                            tblPast1year.Visible = true;
                        }
                    }
                    else if (Heading == "Past3years")
                    {
                        if (Convert.ToString(hdnHistoryControl.Value) != Control)
                        {
                            HID = lsthisPHA[j].HistoryID; CID = 0;
                            objCtrl = loadControl(Control, CID, HID, PatternID);
                            tc.Controls.Add(objCtrl);
                            tr.Cells.Add(tc);
                            tblPast3years.Rows.Add(tr);
                            tblPast3years.Visible = true;
                        }
                    }
                    hdnHistoryControl.Value = Control;
                }
                hdnControl.Value = Control;
            }
        }

        #endregion

        drawNewExam.Visible = true;
        //divHistory.Style.Add("display", "block");

    }
    # region Load User Control

    public Control loadControl(string strControl, long ComID,long HisID,int PatternID)
    {
        BloodBank_DynamicUserControl objDynamic;
        BloodBank_DynamicUserControl2 objDynamic2;
        BloodBank_DynamicUserControl3 objDynamic3;
        List<PatientHistoryAttribute> lstPHA = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        ArrayList lstPatientSel = new ArrayList();

        returnCode = new BloodBank_BL(base.ContextInfo).GetPatientHistoryPKGEditForBloodBank(visitID, LID, SpecialityID, OrgID, out lstPHA, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);
        objDynamic = null;
        if (ComID != 0 && PatternID == (Int32)TaskHelper.BloodBankPattern.OneTextPattern)
        {
            objDynamic=LoadControl("../BloodBank/DynamicUserControl.ascx") as BloodBank_DynamicUserControl;
            try
            {
                objDynamic.ControlID = "ucBDynamic"+ComID;
                objDynamic.ID = "ucBDynamic" + ComID;
                objDynamic.SetData(lsthisPCA, ComID);
                objDynamic.EditData(lstPCA, ComID);
                objDynamic.Name = "Complaint";
                objCtrl1 = (Control)objDynamic;
                lstControl.Add(objDynamic.ID);
                lstpatternID.Add(PatternID);
                ViewState["ControlID"] = lstControl;
                ViewState["PatternID"] = lstpatternID;
                lstPatientASel.Add(objDynamic.Name);
                ViewState["Name"] = lstPatientASel;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDynamic; 
        }
        if (HisID != 0 && PatternID == (Int32)TaskHelper.BloodBankPattern.OneTextPattern)
        {
            objDynamic=LoadControl("../BloodBank/DynamicUserControl.ascx") as BloodBank_DynamicUserControl;
            try
            {
                objDynamic.ControlID = "ucDynamic1" + HisID;
                objDynamic.ID = "ucDynamic1" + HisID;
                objDynamic.SetData(lsthisPHA, HisID);
                objDynamic.EditData(lstPHA, HisID);
                objDynamic.Name = "History";
                objCtrl1 = (Control)objDynamic;
                lstControl.Add(objDynamic.ID);
                lstpatternID.Add(PatternID);
                ViewState["ControlID"] = lstControl;
                ViewState["PatternID"] = lstpatternID;
                lstPatientASel.Add(objDynamic.Name);
                ViewState["Name"] = lstPatientASel;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDynamic; 
        }
        if (ComID != 0 && PatternID == (Int32)TaskHelper.BloodBankPattern.OneDropdownPattern)
        {
            objDynamic3 = LoadControl("../BloodBank/DynamicUserControl3.ascx") as BloodBank_DynamicUserControl3;
            try
            {
                objDynamic3.ControlID = "ucDynamic3";
                objDynamic3.ID = "ucDynamic3";
                objDynamic3.SetData(lsthisPCA, ComID);
                objDynamic3.EditData(lstPCA, ComID);
                objDynamic3.Name = "Complaint";
                objCtrl1 = (Control)objDynamic3;
                lstControl.Add(objDynamic3.ID);
                lstpatternID.Add(PatternID);
                ViewState["ControlID"] = lstControl;
                ViewState["PatternID"] = lstpatternID;
                lstPatientASel.Add(objDynamic3.Name);
                ViewState["Name"] = lstPatientASel;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDynamic3;
        }
        if (HisID != 0 && PatternID == (Int32)TaskHelper.BloodBankPattern.OneDropdownPattern)
        {
            objDynamic3 = LoadControl("../BloodBank/DynamicUserControl3.ascx") as BloodBank_DynamicUserControl3;
            try
            {
                objDynamic3.ControlID = "ucDynamic4";
                objDynamic3.ID = "ucDynamic4";
                objDynamic3.SetData(lsthisPHA, HisID);
                objDynamic3.EditData(lstPHA, HisID);
                objDynamic3.Name = "History";
                objCtrl1 = (Control)objDynamic3;
                lstpatternID.Add(PatternID);
                lstControl.Add(objDynamic3.ID);
                ViewState["ControlID"] = lstControl;
                ViewState["PatternID"] = lstpatternID;
                lstPatientASel.Add(objDynamic3.Name);
                ViewState["Name"] = lstPatientASel;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDynamic3;
        }
        if (ComID != 0 && PatternID == (Int32)TaskHelper.BloodBankPattern.ThreeDropdowns)
        {
            objDynamic2 = LoadControl("../BloodBank/DynamicUserControl2.ascx") as BloodBank_DynamicUserControl2;
            try
            {
                objDynamic2.ControlID = "ucDynamic2";
                objDynamic2.ID = "ucDynamic2";
                objDynamic2.SetData(lsthisPCA, ComID);
                objDynamic2.EditData(lstPCA, ComID);
                objDynamic2.Name = "Complaint";
                objCtrl1 = (Control)objDynamic2;
                lstControl.Add(objDynamic2.ID);
                lstpatternID.Add(PatternID);
                ViewState["ControlID"] = lstControl;
                ViewState["PatternID"] = lstpatternID;
                lstPatientASel.Add(objDynamic2.Name);
                ViewState["Name"] = lstPatientASel;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDynamic2;
        }
        return objDynamic;
    }

    #endregion

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../BloodBank/Home.aspx");
    }
    protected void btnCancel1_Click(object sender, EventArgs e)
    {
        Response.Redirect("../BloodBank/Home.aspx");
    }
    protected void btnTemporaryExclusion_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            char PS1 = ' ';
            char PS2 = ' ';
            char TS1 = ' ';
            char TS2 = ' ';
            char ES1 = ' ';
            char ES2 = ' ';
            PS1 = Convert.ToChar(hdnPS1.Value);
            TS1 = Convert.ToChar(hdnTS1.Value);
            PS2 = Convert.ToChar(hdnPS2.Value);
            TS2 = 'N';
            hdnTS2.Value = "N";
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2), Convert.ToString(ES1), Convert.ToString(ES2));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
            btnSave.Enabled = true;
        }
    }
    protected void btnExclusion_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            char PS1 = ' ';
            char PS2 = ' ';
            char TS1 = ' ';
            char TS2 = ' ';
            char ES1 = ' ';
            char ES2 = ' ';
            PS1 = Convert.ToChar(hdnPS1.Value);
            TS1 = ' ';
            PS2 = 'N';
            hdnPS2.Value = "N";
            TS2 = ' ';
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2), Convert.ToString(ES1), Convert.ToString(ES2));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnExclusion_Click", ex);
            btnSave.Enabled = true;
        }
    }
    protected void btnExamExclude_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            char PS1 = ' ';
            char PS2 = ' ';
            char TS1 = ' ';
            char TS2 = ' ';
            char ES1 = ' ';
            char ES2 = ' ';
            PS1 = ' ';
            TS1 = ' ';
            PS2 = ' ';
            TS2 = ' ';
            ES1 = Convert.ToChar(hdnES1.Value);
            ES2 = 'N';
            hdnES2.Value = "N";
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2), Convert.ToString(ES1), Convert.ToString(ES2));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnExclusion_Click", ex);
            btnSave.Enabled = true;
        }
    }
}
    