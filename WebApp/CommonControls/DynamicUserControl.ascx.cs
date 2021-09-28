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

public partial class CommonControls_DynamicUserControl : BaseControl
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
    EMR_History oDiaCtrl;
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
        HealthPackageControls_DiabetesMellitus editemr = ((HealthPackageControls_DiabetesMellitus)(sender));
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
        long retCode=0;
        List<Examination> lstExamination=new List<Examination>();
        List<PatientExamination> lstPatExamination=new List<PatientExamination>();
        retCode = new Neonatal_BL(base.ContextInfo).GetSystemicExaminatiom(out lstExamination);
        foreach(Examination objExam in lstExamination)
        {
            if(objExam.ExaminationName=="CVS")
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
    protected void SaveData(string PS1, string PS2, string TS1, string TS2,string ES1,string ES2)
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
                //objn;
                // objLiver;
                result = (ArrayList)ViewState["ControlID"];

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
                    switch (strControlName)
                    {
                        case "ucLiver":
                            HealthPackageControls_Liver objLi = (HealthPackageControls_Liver)this.FindControl("ucLiver");
                            objLi.GetData(out attribute, out attrValue);
                            break;

                        case "ucDiab":
                            HealthPackageControls_DiabetesMellitus objDM = (HealthPackageControls_DiabetesMellitus)this.FindControl(strControlName);
                            objDM.GetData(out attribute, out attrValue);
                            break;

                        case "ucOther":
                            HealthPackageControls_OtherDisease objOD = (HealthPackageControls_OtherDisease)this.FindControl(strControlName);
                            objOD.GetData(out attribute, out attrValue);
                            break;

                        case "ucRenal":
                            HealthPackageControls_RenalDisorder objRD = (HealthPackageControls_RenalDisorder)this.FindControl(strControlName);
                            objRD.GetData(out attribute, out attrValue);
                            break;

                        case "ucTuberculosis":
                            HealthPackageControls_Tuberculosis objTC = (HealthPackageControls_Tuberculosis)this.FindControl(strControlName);
                            objTC.GetData(out attribute, out attrValue);
                            break;

                        case "ucCardiac":
                            CommonControls_CardiacDiseases objCardia = (CommonControls_CardiacDiseases)this.FindControl(strControlName);
                            objCardia.GetData(out attribute, out attrValue);
                            break;

                        case "ucChronic":
                            CommonControls_ChronicNephritis objCN = (CommonControls_ChronicNephritis)this.FindControl(strControlName);
                            objCN.GetData(out attribute, out attrValue);
                            break;
                        case "ucCJD":
                            CommonControls_CJD objCJD = (CommonControls_CJD)this.FindControl(strControlName);
                            objCJD.GetData(out attribute, out attrValue);
                            break;

                        case "ucDrugs":
                            CommonControls_Drugs objdrugs = (CommonControls_Drugs)this.FindControl("ucDrugs");
                            objdrugs.GetData(out attribute1, out attrValue1);
                            break;

                        case "ucEpilepsy":
                            CommonControls_Epilepsy objepilepsy = (CommonControls_Epilepsy)this.FindControl(strControlName);
                            objepilepsy.GetData(out attribute, out attrValue);
                            break;

                        case "ucLeprosy":
                            CommonControls_Leprosy objLeprosy = (CommonControls_Leprosy)this.FindControl(strControlName);
                            objLeprosy.GetData(out attribute, out attrValue);
                            break;

                        case "ucSchizophrenia":
                            CommonControls_Schizophrenia objSchizophrenia = (CommonControls_Schizophrenia)this.FindControl(strControlName);
                            objSchizophrenia.GetData(out attribute, out attrValue);
                            break;

                        case "ucSeroPositivity":
                            CommonControls_SeroPositivity objSeroPositivity = (CommonControls_SeroPositivity)this.FindControl(strControlName);
                            objSeroPositivity.GetData(out attribute, out attrValue);
                            break;

                        case "ucSexuallyTransmitted":
                            CommonControls_SexuallyTransmittedDiseases objSex = (CommonControls_SexuallyTransmittedDiseases)this.FindControl(strControlName);
                            objSex.GetData(out attribute1, out attrValue1);
                            break;

                        case "ucSickleCellAnamia":
                            CommonControls_SickleCellAnamia objAnemia = (CommonControls_SickleCellAnamia)this.FindControl("ucSickleCellAnamia");
                            objAnemia.GetData(out attribute, out attrValue);
                            break;

                        case "ucTransplantation":
                            CommonControls_TransplantationSurgery objTransplanation = (CommonControls_TransplantationSurgery)this.FindControl(strControlName);
                            objTransplanation.GetData(out attribute1, out attrValue1);
                            break;

                        case "ucUnprotected":
                            CommonControls_UnprotectedSex objunProtected = (CommonControls_UnprotectedSex)this.FindControl(strControlName);
                            objunProtected.GetData(out attribute1, out attrValue1);
                            break;

                        case "ucHumanPituitaryHormone":
                            CommonControls_HumanPituitaryHormone objHormone = (CommonControls_HumanPituitaryHormone)this.FindControl(strControlName);
                            objHormone.GetData(out attribute1, out attrValue1);
                            break;

                        case "ucEndocrinedisorders":
                            CommonControls_Endocrinedisorders objEndocrinedisorders = (CommonControls_Endocrinedisorders)this.FindControl("ucEndocrinedisorders");
                            objEndocrinedisorders.GetData(out attribute, out attrValue);
                            break;

                        case "ucDementia":
                            CommonControls_Dementia objDementia = (CommonControls_Dementia)this.FindControl(strControlName);
                            objDementia.GetData(out attribute, out attrValue);
                            break;

                        case "ucFilariasis":
                            CommonControls_Filariasis objFilariasis = (CommonControls_Filariasis)this.FindControl(strControlName);
                            objFilariasis.GetData(out attribute, out attrValue);
                            break;

                        case "ucGout":
                            CommonControls_Gout objGout = (CommonControls_Gout)this.FindControl(strControlName);
                            objGout.GetData(out attribute, out attrValue);
                            break;

                        case "ucProstrateEnlargement":
                            CommonControls_ProstrateEnlargement objProstrate = (CommonControls_ProstrateEnlargement)this.FindControl(strControlName);
                            objProstrate.GetData(out attribute, out attrValue);
                            break;

                        case "ucCancer":
                            CommonControls_Cancer objCancer = (CommonControls_Cancer)this.FindControl(strControlName);
                            objCancer.GetData(out attribute, out attrValue);
                            break;

                        case "ucLungDiseases":
                            CommonControls_LungDiseases objlung = (CommonControls_LungDiseases)this.FindControl("ucLungDiseases");
                            objlung.GetData(out attribute, out attrValue);
                            break;

                        case "ucChickenPox":
                            CommonControls_ChickenPox objchicken = (CommonControls_ChickenPox)this.FindControl(strControlName);
                            objchicken.GetData(out attribute, out attrValue);
                            break;
                        case "ucDengue":
                            CommonControls_DengueFever objdengue = (CommonControls_DengueFever)this.FindControl(strControlName);
                            objdengue.GetData(out attribute, out attrValue);
                            break;
                        case "ucMalaria":
                            CommonControls_Malaria objmalaria = (CommonControls_Malaria)this.FindControl(strControlName);
                            objmalaria.GetData(out attribute, out attrValue);
                            break;
                        case "ucTyphoid":
                            CommonControls_Typhoid objtyphoid = (CommonControls_Typhoid)this.FindControl(strControlName);
                            objtyphoid.GetData(out attribute, out attrValue);
                            break;
                        case "ucPepticUlcerDisease":
                            CommonControls_PepticUlcerDisease objpeptic = (CommonControls_PepticUlcerDisease)this.FindControl(strControlName);
                            objpeptic.GetData(out attribute, out attrValue);
                            break;
                        case "ucBloodTransfusion":
                            CommonControls_BloodTransfusion objBloodTransfusion = (CommonControls_BloodTransfusion)this.FindControl(strControlName);
                            objBloodTransfusion.GetData(out attribute, out attrValue);
                            break;
                        case "ucChildbirth":
                            CommonControls_Childbirth objChildbirth = (CommonControls_Childbirth)this.FindControl(strControlName);
                            objChildbirth.GetData(out attribute, out attrValue);
                            break;
                        case "ucAcupuncture":
                            CommonControls_Acupuncture objAcupuncture = (CommonControls_Acupuncture)this.FindControl(strControlName);
                            objAcupuncture.GetData(out attribute, out attrValue);
                            break;
                        case "ucGonorrhoea":
                            CommonControls_Gonorrhoea objGonorrhoea = (CommonControls_Gonorrhoea)this.FindControl(strControlName);
                            objGonorrhoea.GetData(out attribute, out attrValue);
                            break;
                        case "ucSyphilis":
                            CommonControls_Syphilis objSyphilis = (CommonControls_Syphilis)this.FindControl(strControlName);
                            objSyphilis.GetData(out attribute, out attrValue);
                            break;
                        case "ucSkingrafting":
                            CommonControls_Skingrafting objSkingrafting = (CommonControls_Skingrafting)this.FindControl(strControlName);
                            objSkingrafting.GetData(out attribute, out attrValue);
                            break;
                        case "ucBonegrafting":
                            CommonControls_Bonegrafting objBonegrafting = (CommonControls_Bonegrafting)this.FindControl(strControlName);
                            objBonegrafting.GetData(out attribute, out attrValue);
                            break;
                        case "ucSkinPiercingActivity":
                            CommonControls_SkinPiercingActivity objSkinPiercingActivity = (CommonControls_SkinPiercingActivity)this.FindControl(strControlName);
                            objSkinPiercingActivity.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucAlcohol":
                            CommonControls_AlcoholConsumption objAlcoholConsumption = (CommonControls_AlcoholConsumption)this.FindControl(strControlName);
                            objAlcoholConsumption.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucStroke":
                            CommonControls_Stroke objStroke = (CommonControls_Stroke)this.FindControl(strControlName);
                            objStroke.GetData(out attribute, out attrValue);
                            break;
                        case "ucParasiticInfections":
                            CommonControls_ParasiticInfections objPara = (CommonControls_ParasiticInfections)this.FindControl(strControlName);
                            objPara.GetData(out attribute, out attrValue);
                            break;
                        case "ucCocaineintake":
                            CommonControls_Cocaineintake objCocaine = (CommonControls_Cocaineintake)this.FindControl(strControlName);
                            objCocaine.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucDentalExtraction":
                            CommonControls_DentalExtraction objDental = (CommonControls_DentalExtraction)this.FindControl(strControlName);
                            objDental.GetData(out attribute, out attrValue);
                            break;
                        case "ucBloodDonation":
                            CommonControls_BloodDonation objBloodDonate = (CommonControls_BloodDonation)this.FindControl(strControlName);
                            objBloodDonate.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucVaccination":
                            CommonControls_VaccinationHistory objVaccine = (CommonControls_VaccinationHistory)this.FindControl(strControlName);
                            objVaccine.GetData(out attribute1, out attributeVaccine);
                            break;
                        case "ucTravelHistory":
                            CommonControls_TravelHistory objTravelHistory = (CommonControls_TravelHistory)this.FindControl(strControlName);
                            objTravelHistory.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucSmallPox":
                            CommonControls_SmallPox objSmallPox = (CommonControls_SmallPox)this.FindControl(strControlName);
                            objSmallPox.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucNeedleStickInjury":
                            CommonControls_NeedleStickInjury objNeedleStickInjury = (CommonControls_NeedleStickInjury)this.FindControl(strControlName);
                            objNeedleStickInjury.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucTravelToMalarialPlace":
                            CommonControls_TravelToMalarialPlace objTravelToMalarialPlace = (CommonControls_TravelToMalarialPlace)this.FindControl(strControlName);
                            objTravelToMalarialPlace.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucLivedWithHepatitisPerson":
                            CommonControls_LivedWithHepatitisPerson objLivedWithHepatitisPerson = (CommonControls_LivedWithHepatitisPerson)this.FindControl(strControlName);
                            objLivedWithHepatitisPerson.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucUnprotectedIntercourse":
                            CommonControls_UnprotectedIntercourse objUnprotectedIntercourse = (CommonControls_UnprotectedIntercourse)this.FindControl(strControlName);
                            objUnprotectedIntercourse.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucJailOrPrison":
                            CommonControls_JailOrPrison objJailOrPrison = (CommonControls_JailOrPrison)this.FindControl(strControlName);
                            objJailOrPrison.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucSymptomatic":
                            CommonControls_SymptomaticOrAsymptomatic objSymptomatic = (CommonControls_SymptomaticOrAsymptomatic)this.FindControl(strControlName);
                            objSymptomatic.GetData(out attribute1, out attrValue1);
                            break;
                        case "ucMinorSurgery":
                            CommonControls_MinorSurgery objMinor = (CommonControls_MinorSurgery)this.FindControl(strControlName);
                            objMinor.GetData(out attributeSurgical);
                            break;
                        case "ucMajorSurgery":
                            CommonControls_MajorSurgery objMajor = (CommonControls_MajorSurgery)this.FindControl(strControlName);
                            objMajor.GetData(out attributeSurgical);
                            break;
                        default:
                            break;
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
                    returncode = new BloodBank_BL(base.ContextInfo).InsertOrUpdateDonorStatus(visitID, PS1, PS2, TS1, TS2,ES1,ES2);
                }
                if (returncode == 0)
                {
                    //AddUserControl();
                    string sPath = "CommonControls\\\\DynamicUserControl.ascx.cs_1";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "');", true);

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('History saved successfully.');", true);
                    hdnButton.Value += "~btnExam~";
                    showExamination();
                    lblHistoryStatus.Text = "<%=Resources.ClientSideDisplayTexts.CommonControls_DynamicUserControl_Completed %>";
                }
            }

            else if (divExam.Style.Value == "display: block")
            {
                #region

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
                    returnCode = new BloodBank_BL(base.ContextInfo).InsertOrUpdateDonorStatus(visitID,PS1,PS2,TS1,TS2,ES1,ES2);
                }
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                List<DonorStatus> lstDonorStatus = new List<DonorStatus>();
                if (returnCode == 0 && hdnPS2.Value=="Y" && hdnTS2.Value=="Y" && hdnES2.Value=="Y")
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
            if (hdnPS2.Value == "N" || hdnTS2.Value == "N")
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                Response.Redirect("Home.aspx");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save PatientHistory Package", ex);
        }
        #endregion
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
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2),Convert.ToString(ES1),Convert.ToString(ES2));
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
        returnCode = new BloodBank_BL(base.ContextInfo).GetPatientHistoryPKGEditForBloodBank(visitID,LID,SpecialityID,OrgID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);
        long ID = 0;
        string Control = string.Empty;
        string Heading = string.Empty;
        
        #region ComplaintItems
        if (lsthisPCA.Count > 0)
        {
            hdnComplaintControl.Value = "";
            Control objCtrl = null;
            for (int i = 0; i < lsthisPCA.Count; i++)
            {
                strControl = lsthisPCA[i].ControlName;
                Heading = strControl.Split('^')[0];
                Control = strControl.Split('^')[1];
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPCA[i].ComplaintID;
                        objCtrl = loadControl(Control, ID);
                        tc.Controls.Add(objCtrl);
                        tr.Cells.Add(tc);
                        tblPast3years.Rows.Add(tr);
                        tblPast3years.Visible = true;
                    }
                }
                hdnComplaintControl.Value = Control;
            }
        }
    
        #endregion
        #region HistoryItems
        if (lsthisPHA.Count > 0)
        {
            hdnHistoryControl.Value = "";
            for (int j = 0; j < lsthisPHA.Count; j++)
            {
                strControl = lsthisPHA[j].ControlName;
                Heading = strControl.Split('^')[0];
                Control = strControl.Split('^')[1];
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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
                        ID = lsthisPHA[j].HistoryID;
                        objCtrl = loadControl(Control, ID);
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

        #endregion

        drawNewExam.Visible = true;
        //divHistory.Style.Add("display", "block");

    }
    # region Load User Control

    public Control loadControl(string strControl,long HisOrComID)
    {
        HealthPackageControls_DiabetesMellitus objDiab;
        HealthPackageControls_Liver objLiver;
        HealthPackageControls_RenalDisorder objRenal;
        HealthPackageControls_Tuberculosis objTub;
        HealthPackageControls_PVD objPVD;
        HealthPackageControls_OtherDisease objOther;
        HealthPackageControls_Dyslipidemia objDyslipidemia;
        HealthPackageControls_SystemicHypertension objSystemicHypertension;
        CommonControls_AbnormalBleedingDisorders objAbnormalBleeding;
        CommonControls_CardiacDiseases objCardiac;
        CommonControls_SexuallyTransmittedDiseases objSexuallyTransmitted;
        CommonControls_TransplantationSurgery objTransplantation;
        CommonControls_SeroPositivity objSeroPositivity;
        CommonControls_UnprotectedSex objUnprotectedSex;
        CommonControls_SickleCellAnamia objSickleCell;
        CommonControls_PolycythemiaVera objPolycythemia;
        CommonControls_ChronicNephritis objChronicNephtris;
        CommonControls_Epilepsy objEpilepsy;
        CommonControls_Leprosy objLeprosy;
        CommonControls_Schizophrenia objSchizophrenia;
        CommonControls_CJD objCJD;
        CommonControls_HumanPituitaryHormone objHuman;
        CommonControls_Drugs objDrugs;
        CommonControls_Asthma objAsthma;
        CommonControls_Endocrinedisorders objEndocrine;
        CommonControls_Dementia objDementia;
        CommonControls_Filariasis objFilariasis;
        CommonControls_Gout objGout;
        CommonControls_ProstrateEnlargement objProstrate;
        CommonControls_Cancer objCancer;
        CommonControls_LungDiseases objLungs;
        CommonControls_PatientVitals objVital;
        CommonControls_GynecologicalAndObstetric objGynacology;
        CommonControls_AlcoholConsumption objAlcohol;
        CommonControls_ChickenPox objChickenPox;
        CommonControls_DengueFever objDengue;
        CommonControls_SymptomaticOrAsymptomatic objSymptomatic;
        CommonControls_Malaria objMalaria;
        CommonControls_Acupuncture objAcupuncture;
        CommonControls_BloodTransfusion objBloodTransfusion;
        CommonControls_Bonegrafting objBoneGrafting;
        CommonControls_Childbirth objChildBirth;
        CommonControls_Cocaineintake objCocaineintake;
        CommonControls_OrganTransplant objOrganTransplant;
        CommonControls_PepticUlcerDisease objPepticUlcer;
        CommonControls_SkinPiercingActivity objSkinPiercing;
        CommonControls_Syphilis objSyphilis;
        CommonControls_Skingrafting objSkinGrafting;
        CommonControls_Typhoid objTyphoid;
        CommonControls_Gonorrhoea objGonorrhoea;
        CommonControls_Stroke objStroke;
        CommonControls_DentalExtraction objDental;
        CommonControls_ParasiticInfections objParasiticInfections;
        CommonControls_BloodDonation objBloodDonate;
        CommonControls_VaccinationHistory objVaccinationHistory;
        CommonControls_TravelHistory objTravelHistory;
        CommonControls_SmallPox objSmallPox;
        CommonControls_NeedleStickInjury objNeedleStickInjury;
        CommonControls_TravelToMalarialPlace objTravelToMalarialPlace;
        CommonControls_LivedWithHepatitisPerson objLivedWithHepatitisPerson;
        CommonControls_UnprotectedIntercourse objUnprotectedIntercourse;
        CommonControls_JailOrPrison objJailOrPrison;
        CommonControls_MinorSurgery objMinorSurgery;
        CommonControls_MajorSurgery objMajorSurgery;
        List<PatientHistoryAttribute> lstPHA = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        ArrayList lstPatientASel = new ArrayList();
        ArrayList lstPatientSel = new ArrayList();

        returnCode = new BloodBank_BL(base.ContextInfo).GetPatientHistoryPKGEditForBloodBank(visitID, LID, SpecialityID, OrgID, out lstPHA, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);
        objDiab = null;
        if (strControl == "DiabetesMellitus")
        {
            objDiab = LoadControl("../EMR/DiabetesMellitus.ascx") as HealthPackageControls_DiabetesMellitus;
            try
            {
                objDiab.ControlID = "ucDiab";
                objDiab.ID = "ucDiab";
                objDiab.SetData(lsthisPCA,HisOrComID);
                //objDiab.LoadData(lsthisPHA,HisOrComID);
                objDiab.EditData(lstPCA,HisOrComID);
                //objDiab.visitid = visitID;
                // objDiab.btnSampleClick += new btnSample_Click(EMR_btnSampleClk);

                objCtrl1 = (Control)objDiab;
                lstControl.Add(objDiab.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDiab;
        }
        else if (strControl == "Liver")
        {
            objLiver = LoadControl("../EMR/Liver.ascx") as HealthPackageControls_Liver;
            try
            {
                objLiver.ControlID = "ucLiver";
                objLiver.ID = "ucLiver";
                //objLiver.LoadDiabData();
                objLiver.SetData(lsthisPCA,HisOrComID);
                objLiver.EditData(lstPCA,HisOrComID );

                objCtrl1 = (Control)objLiver;
                lstControl.Add(objLiver.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objLiver;
        }
        else if (strControl == "RenalDisorder")
        {
            objRenal = LoadControl("../EMR/RenalDisorder.ascx") as HealthPackageControls_RenalDisorder;
            try
            {
                objRenal.ControlID = "ucRenal";
                objRenal.ID = "ucRenal";
                //objRenal.LoadDiabData();
                objRenal.SetData(lsthisPCA,HisOrComID);
                objRenal.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objRenal;
                lstControl.Add(objRenal.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objRenal;
        }
        else if (strControl == "Tuberculosis")
        {
            objTub = LoadControl("../EMR/Tuberculosis.ascx") as HealthPackageControls_Tuberculosis;
            try
            {
                objTub.ControlID = "ucTuberculosis";
                objTub.ID = "ucTuberculosis";
                //objRenal.LoadDiabData();
                objTub.SetData(lsthisPCA,HisOrComID);
                objTub.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objTub;
                lstControl.Add(objTub.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objTub;
        }
        else if (strControl == "PVD")
        {
            objPVD = LoadControl("../EMR/PVD.ascx") as HealthPackageControls_PVD;
            try
            {
                objPVD.ControlID = "ucPVD";
                objPVD.ID = "ucPVD";
                //objRenal.LoadDiabData();
                objPVD.SetData(lsthisPCA,HisOrComID);
                objPVD.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objPVD;
                lstControl.Add(objPVD.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objPVD;
        }
        else if (strControl == "OtherDisease")
        {
            objOther = LoadControl("../EMR/OtherDisease.ascx") as HealthPackageControls_OtherDisease;
            try
            {
                objOther.ControlID = "ucOther";
                objOther.ID = "ucOther";
                //objRenal.LoadDiabData();
                objOther.SetData(lsthisPCA,HisOrComID);
                objOther.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objOther;
                lstControl.Add(objOther.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objOther;
        }
        else if (strControl == "Dyslipidemia")
        {
            objDyslipidemia = LoadControl("../EMR/Dyslipidemia.ascx") as HealthPackageControls_Dyslipidemia;
            try
            {
                objDyslipidemia.ControlID = "ucDyslipidemia";
                objDyslipidemia.ID = "ucDyslipidemia";
                //objRenal.LoadDiabData();
                objDyslipidemia.SetData(lsthisPCA,HisOrComID);
                objDyslipidemia.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objDyslipidemia;
                lstControl.Add(objDyslipidemia.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDyslipidemia;
        }
        else if (strControl == "SystemicHypertension")
        {
            objSystemicHypertension = LoadControl("../EMR/SystemicHypertension.ascx") as HealthPackageControls_SystemicHypertension;
            try
            {
                objSystemicHypertension.ControlID = "ucSystemicHypertension";
                objSystemicHypertension.ID = "ucSystemicHypertension";
                //objRenal.LoadDiabData();
                objSystemicHypertension.SetData(lsthisPCA,HisOrComID);
                objSystemicHypertension.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objSystemicHypertension;
                lstControl.Add(objSystemicHypertension.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSystemicHypertension;
        }
        //else if (strControl == "Vitals")
        //{
        //    objVital = LoadControl("../Commoncontrols/PatientVitals.ascx") as CommonControls_PatientVitals;
        //    try
        //    {
        //        objVital.ControlID = "ucLiver";
        //        objVital.ID = "ucVital";
        //        returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin, out lstExam, out lstAttribute);
        //        List<Patient> lstPatient = new List<Patient>();
        //        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        //        Patient patient = new Patient();
        //        patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
        //        if (lstPatient.Count > 0)
        //            hdnSex.Value = lstPatient[0].SEX;

        //        if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null)
        //        {
        //            objVital.VisitID = visitID;
        //            objVital.intOrgID = OrgID;
        //            if (lstVitalsUOMJoin.Count > 0)
        //            {
        //                objVital.LoadControls("U", patientID);
        //            }
        //            else
        //            {
        //                objVital.LoadControls("I", patientID);
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        CLogger.LogError("Error on loadVital", ex);
        //    }
        //    return objVital;
        //}
        else if (strControl == "AbnormalBleeding")
        {
            objAbnormalBleeding = LoadControl("../CommonControls/AbnormalBleedingDisorders.ascx") as CommonControls_AbnormalBleedingDisorders;
            try
            {
                objAbnormalBleeding.ControlID = "ucAbnormal";
                objAbnormalBleeding.ID = "ucAbnormal";
                //objRenal.LoadDiabData();
                objAbnormalBleeding.SetData(lsthisPHA,HisOrComID);
                objAbnormalBleeding.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objAbnormalBleeding;
                lstControl.Add(objAbnormalBleeding.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objAbnormalBleeding;
        }
        else if (strControl == "CardiacDiseases")
        {
            objCardiac = LoadControl("../CommonControls/CardiacDiseases.ascx") as CommonControls_CardiacDiseases;
            try
            {
                objCardiac.ControlID = "ucCardiac";
                objCardiac.ID = "ucCardiac";
                //objRenal.LoadDiabData();
                objCardiac.SetData(lsthisPCA,HisOrComID);
                objCardiac.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objCardiac;
                lstControl.Add(objCardiac.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objCardiac;
        }
        else if (strControl == "SexuallyTransmitted")
        {
            objSexuallyTransmitted = LoadControl("../CommonControls/SexuallyTransmittedDiseases.ascx") as CommonControls_SexuallyTransmittedDiseases;
            try
            {
                objSexuallyTransmitted.ControlID = "ucSexuallyTransmitted";
                objSexuallyTransmitted.ID = "ucSexuallyTransmitted";
                //objRenal.LoadDiabData();
                objSexuallyTransmitted.SetData(lsthisPHA,HisOrComID);
                objSexuallyTransmitted.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objSexuallyTransmitted;
                lstControl.Add(objSexuallyTransmitted.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSexuallyTransmitted;
        }
        else if (strControl == "TransplantationSurgery")
        {
            objTransplantation = LoadControl("../CommonControls/TransplantationSurgery.ascx") as CommonControls_TransplantationSurgery;
            try
            {
                objTransplantation.ControlID = "ucTransplantation";
                objTransplantation.ID = "ucTransplantation";
                //objRenal.LoadDiabData();
                objTransplantation.SetData(lsthisPHA,HisOrComID);
                objTransplantation.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objTransplantation;
                lstControl.Add(objTransplantation.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objTransplantation;
        }
        else if (strControl == "SeroPositivity")
        {
            objSeroPositivity = LoadControl("../CommonControls/SeroPositivity.ascx") as CommonControls_SeroPositivity;
            try
            {
                objSeroPositivity.ControlID = "ucSeroPositivity";
                objSeroPositivity.ID = "ucSeroPositivity";
                //objRenal.LoadDiabData();
                objSeroPositivity.SetData(lsthisPCA,HisOrComID);
                objSeroPositivity.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objSeroPositivity;
                lstControl.Add(objSeroPositivity.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSeroPositivity;
        }
        else if (strControl == "UnprotectedSex")
        {
            objUnprotectedSex = LoadControl("../CommonControls/UnprotectedSex.ascx") as CommonControls_UnprotectedSex;
            try
            {
                objUnprotectedSex.ControlID = "ucUnprotected";
                objUnprotectedSex.ID = "ucUnprotected";
                //objRenal.LoadDiabData();
                objUnprotectedSex.SetData(lsthisPHA,HisOrComID);
                objUnprotectedSex.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objUnprotectedSex;
                lstControl.Add(objUnprotectedSex.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objUnprotectedSex;
        }
        else if (strControl == "Anaemia")
        {
            objSickleCell = LoadControl("../CommonControls/SickleCellAnamia.ascx") as CommonControls_SickleCellAnamia;
            try
            {
                objSickleCell.ControlID = "ucSickleCellAnamia";
                objSickleCell.ID = "ucSickleCellAnamia";
                //objRenal.LoadDiabData();
                objSickleCell.SetData(lsthisPCA,HisOrComID);
                objSickleCell.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objSickleCell;
                lstControl.Add(objSickleCell.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSickleCell;
        }
        else if (strControl == "PolycythemiaVera")
        {
            objPolycythemia = LoadControl("../CommonControls/PolycythemiaVera.ascx") as CommonControls_PolycythemiaVera;
            try
            {
                objPolycythemia.ControlID = "ucPolycythemiaVera";
                objPolycythemia.ID = "ucPolycythemiaVera";
                //objRenal.LoadDiabData();
                objPolycythemia.SetData(lsthisPCA,HisOrComID);
                objPolycythemia.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objPolycythemia;
                lstControl.Add(objPolycythemia.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objPolycythemia;
        }
        else if (strControl == "ChronicNephtris")
        {
            objChronicNephtris = LoadControl("../CommonControls/ChronicNephritis.ascx") as CommonControls_ChronicNephritis;
            try
            {
                objChronicNephtris.ControlID = "ucChronic";
                objChronicNephtris.ID = "ucChronic";
                //objRenal.LoadDiabData();
                objChronicNephtris.SetData(lsthisPCA,HisOrComID);
                objChronicNephtris.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objChronicNephtris;
                lstControl.Add(objChronicNephtris.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objChronicNephtris;
        }
        else if (strControl == "Epilepsy")
        {
            objEpilepsy = LoadControl("../CommonControls/Epilepsy.ascx") as CommonControls_Epilepsy;
            try
            {
                objEpilepsy.ControlID = "ucEpilepsy";
                objEpilepsy.ID = "ucEpilepsy";
                //objRenal.LoadDiabData();
                objEpilepsy.SetData(lsthisPCA,HisOrComID);
                objEpilepsy.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objEpilepsy;
                lstControl.Add(objEpilepsy.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objEpilepsy;
        }
        else if (strControl == "Leprosy")
        {
            objLeprosy = LoadControl("../CommonControls/Leprosy.ascx") as CommonControls_Leprosy;
            try
            {
                objLeprosy.ControlID = "ucLeprosy";
                objLeprosy.ID = "ucLeprosy";
                //objRenal.LoadDiabData();
                objLeprosy.SetData(lsthisPCA,HisOrComID);
                objLeprosy.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objLeprosy;
                lstControl.Add(objLeprosy.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objLeprosy;
        }
        else if (strControl == "Schizophrenia")
        {
            objSchizophrenia = LoadControl("../CommonControls/Schizophrenia.ascx") as CommonControls_Schizophrenia;
            try
            {
                objSchizophrenia.ControlID = "ucSchizophrenia";
                objSchizophrenia.ID = "ucSchizophrenia";
                //objRenal.LoadDiabData();
                objSchizophrenia.SetData(lsthisPCA,HisOrComID);
                objSchizophrenia.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objSchizophrenia;
                lstControl.Add(objSchizophrenia.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSchizophrenia;
        }
        else if (strControl == "CJD")
        {
            objCJD = LoadControl("../CommonControls/CJD.ascx") as CommonControls_CJD;
            try
            {
                objCJD.ControlID = "ucCJD";
                objCJD.ID = "ucCJD";
                //objRenal.LoadDiabData();
                objCJD.SetData(lsthisPCA,HisOrComID);
                objCJD.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objCJD;
                lstControl.Add(objCJD.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objCJD;
        }
        else if (strControl == "HumanPituitaryHormone")
        {
            objHuman = LoadControl("../CommonControls/HumanPituitaryHormone.ascx") as CommonControls_HumanPituitaryHormone;
            try
            {
                objHuman.ControlID = "ucHumanPituitaryHormone";
                objHuman.ID = "ucHumanPituitaryHormone";
                //objRenal.LoadDiabData();
                objHuman.SetData(lsthisPHA,HisOrComID);
                objHuman.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objHuman;
                lstControl.Add(objHuman.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objHuman;
        }
        else if (strControl == "DrugHistory")
        {
            objDrugs = LoadControl("../CommonControls/Drugs.ascx") as CommonControls_Drugs;
            try
            {
                objDrugs.ControlID = "ucDrugs";
                objDrugs.ID = "ucDrugs";

                //objRenal.LoadDiabData();
                objDrugs.SetData(lsthisPHA, HisOrComID);
                objDrugs.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objDrugs;
                lstControl.Add(objDrugs.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDrugs;
        }
        else if (strControl == "Asthma")
        {
            objAsthma = LoadControl("../CommonControls/Asthma.ascx") as CommonControls_Asthma;
            try
            {
                objAsthma.ControlID = "ucAsthma";
                objAsthma.ID = "ucAsthma";
                //objRenal.LoadDiabData();
                objAsthma.SetData(lsthisPCA,HisOrComID);
                objAsthma.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objAsthma;
                lstControl.Add(objAsthma.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objAsthma;
        }
        else if (strControl == "Endocrinedisorders")
        {
            objEndocrine = LoadControl("../CommonControls/Endocrinedisorders.ascx") as CommonControls_Endocrinedisorders;
            try
            {
                objEndocrine.ControlID = "ucEndocrinedisorders";
                objEndocrine.ID = "ucEndocrinedisorders";
                //objRenal.LoadDiabData();
                objEndocrine.SetData(lsthisPCA, HisOrComID);
                objEndocrine.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objEndocrine;
                lstControl.Add(objEndocrine.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objEndocrine;
        }
        else if (strControl == "Dementia")
        {
            objDementia = LoadControl("../CommonControls/Dementia.ascx") as CommonControls_Dementia;
            try
            {
                objDementia.ControlID = "ucDementia";
                objDementia.ID = "ucDementia";
                //objRenal.LoadDiabData();
                objDementia.SetData(lsthisPCA, HisOrComID);
                objDementia.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objDementia;
                lstControl.Add(objDementia.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDementia;
        }
        else if (strControl == "Filariasis")
        {
            objFilariasis = LoadControl("../CommonControls/Filariasis.ascx") as CommonControls_Filariasis;
            try
            {
                objFilariasis.ControlID = "ucFilariasis";
                objFilariasis.ID = "ucFilariasis";
                //objRenal.LoadDiabData();
                objFilariasis.SetData(lsthisPCA,HisOrComID);
                objFilariasis.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objFilariasis;
                lstControl.Add(objFilariasis.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objFilariasis;
        }
        else if (strControl == "Gout")
        {
            objGout = LoadControl("../CommonControls/Gout.ascx") as CommonControls_Gout;
            try
            {
                objGout.ControlID = "ucGout";
                objGout.ID = "ucGout";
                //objRenal.LoadDiabData();
                objGout.SetData(lsthisPCA,HisOrComID);
                objGout.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objGout;
                lstControl.Add(objGout.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objGout;
        }
        else if (strControl == "ProstrateEnlargement")
        {
            objProstrate = LoadControl("../CommonControls/ProstrateEnlargement.ascx") as CommonControls_ProstrateEnlargement;
            try
            {
                objProstrate.ControlID = "ucProstrateEnlargement";
                objProstrate.ID = "ucProstrateEnlargement";
                //objRenal.LoadDiabData();
                objProstrate.SetData(lsthisPCA, HisOrComID);
                objProstrate.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objProstrate;
                lstControl.Add(objProstrate.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objProstrate;
        }
        else if (strControl == "Cancer")
        {
            objCancer = LoadControl("../CommonControls/Cancer.ascx") as CommonControls_Cancer;
            try
            {
                objCancer.ControlID = "ucCancer";
                objCancer.ID = "ucCancer";
                //objRenal.LoadDiabData();
                objCancer.SetData(lsthisPCA, HisOrComID);
                objCancer.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objCancer;
                lstControl.Add(objCancer.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objCancer;
        }
        else if (strControl == "LungDiseases")
        {
            objLungs = LoadControl("../CommonControls/LungDiseases.ascx") as CommonControls_LungDiseases;
            try
            {
                objLungs.ControlID = "ucLungDiseases";
                objLungs.ID = "ucLungDiseases";
                //objRenal.LoadDiabData();
                objLungs.SetData(lsthisPCA, HisOrComID);
                objLungs.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objLungs;
                lstControl.Add(objLungs.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objLungs;
        }
        else if (strControl == "GynecologicalAndObstetric")
        {
            objGynacology = LoadControl("../CommonControls/GynecologicalAndObstetric.ascx") as CommonControls_GynecologicalAndObstetric;
            try
            {
                //objGynacology.ControlID = "ucGynacology";
                objGynacology.ID = "ucGynacology";
                //objRenal.LoadDiabData();
                objGynacology.SetData(lsthisPHA,HisOrComID);
                objGynacology.EditData(lstPHA,HisOrComID);

                objCtrl2 = (Control)objGynacology;
                lstControl.Add(objGynacology.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objGynacology;
        }
        else if (strControl == "AlcoholConsumption")
        {
            objAlcohol = LoadControl("../CommonControls/AlcoholConsumption.ascx") as CommonControls_AlcoholConsumption;
            try
            {
                //objGynacology.ControlID = "ucGynacology";
                objAlcohol.ID = "ucAlcohol";
                //objRenal.LoadDiabData();
                objAlcohol.SetData(lsthisPHA, HisOrComID);
                objAlcohol.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objAlcohol;
                lstControl.Add(objAlcohol.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objAlcohol;
        }
        else if (strControl == "ChickenPox")
        {
            objChickenPox = LoadControl("../CommonControls/ChickenPox.ascx") as CommonControls_ChickenPox;
            try
            {
                //objGynacology.ControlID = "ucGynacology";
                objChickenPox.ID = "ucChickenPox";
                //objRenal.LoadDiabData();
                objChickenPox.SetData(lsthisPCA, HisOrComID);
                objChickenPox.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objChickenPox;
                lstControl.Add(objChickenPox.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objChickenPox;
        }
        else if (strControl == "DengueFever")
        {
            objDengue = LoadControl("../CommonControls/DengueFever.ascx") as CommonControls_DengueFever;
            try
            {
                //objGynacology.ControlID = "ucGynacology";
                objDengue.ID = "ucDengue";
                //objRenal.LoadDiabData();
                objDengue.SetData(lsthisPCA,HisOrComID);
                objDengue.EditData(lstPCA,HisOrComID);

                objCtrl2 = (Control)objDengue;
                lstControl.Add(objDengue.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDengue;
        }
        else if (strControl == "Symptomaitc")
        {
            objSymptomatic = LoadControl("../CommonControls/SymptomaticOrAsymptomatic.ascx") as CommonControls_SymptomaticOrAsymptomatic;
            try
            {
                objSymptomatic.ControlID = "ucSymptomatic";
                objSymptomatic.ID = "ucSymptomatic";
                //objRenal.LoadDiabData();
                objSymptomatic.SetData(lsthisPHA, HisOrComID);
                objSymptomatic.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objSymptomatic;
                lstControl.Add(objSymptomatic.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSymptomatic;
        }
        else if (strControl == "Malaria")
        {
            objMalaria = LoadControl("../CommonControls/Malaria.ascx") as CommonControls_Malaria;
            try
            {
                //objMalaria.Con = "ucMalaria";
                objMalaria.ID = "ucMalaria";
                //objRenal.LoadDiabData();
                objMalaria.SetData(lsthisPCA, HisOrComID);
                objMalaria.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objMalaria;
                lstControl.Add(objMalaria.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objMalaria;
        }
        else if (strControl == "PepticUlcer")
        {
            objPepticUlcer = LoadControl("../CommonControls/PepticUlcerDisease.ascx") as CommonControls_PepticUlcerDisease;
            try
            {
                //objPepticUlcer.ControlID = "ucPepticUlcerDisease";
                objPepticUlcer.ID = "ucPepticUlcerDisease";
                //objRenal.LoadDiabData();
                objPepticUlcer.SetData(lsthisPCA, HisOrComID);
                objPepticUlcer.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objPepticUlcer;
                lstControl.Add(objPepticUlcer.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objPepticUlcer;
        }
        else if (strControl == "Bloodtransfusion")
        {
            objBloodTransfusion = LoadControl("../CommonControls/BloodTransfusion.ascx") as CommonControls_BloodTransfusion;
            try
            {
                //objBloodTransfusion.ControlID = "ucBloodTransfusion";
                objBloodTransfusion.ID = "ucBloodTransfusion";
                //objRenal.LoadDiabData();
                objBloodTransfusion.SetData(lsthisPCA, HisOrComID);
                objBloodTransfusion.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objBloodTransfusion;
                lstControl.Add(objBloodTransfusion.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objBloodTransfusion;
        }
        else if (strControl == "Childbirth")
        {
            objChildBirth = LoadControl("../CommonControls/Childbirth.ascx") as CommonControls_Childbirth;
            try
            {
                //objChildBirth.ControlID = "ucChildbirth";
                objChildBirth.ID = "ucChildbirth";
                //objRenal.LoadDiabData();
                objChildBirth.SetData(lsthisPCA, HisOrComID);
                objChildBirth.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objChildBirth;
                lstControl.Add(objChildBirth.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objChildBirth;
        }
        else if (strControl == "Acupuncture")
        {
            objAcupuncture = LoadControl("../CommonControls/Acupuncture.ascx") as CommonControls_Acupuncture;
            try
            {
                //objAcupuncture.ControlID = "ucAcupuncture";
                objAcupuncture.ID = "ucAcupuncture";
                //objRenal.LoadDiabData();
                objAcupuncture.SetData(lsthisPCA, HisOrComID);
                objAcupuncture.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objAcupuncture;
                lstControl.Add(objAcupuncture.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objAcupuncture;
        }
        else if (strControl == "SkinPiercingActivity")
        {
            objSkinPiercing = LoadControl("../CommonControls/SkinPiercingActivity.ascx") as CommonControls_SkinPiercingActivity;
            try
            {
                //objSkinPiercing.ControlID = "ucSkinPiercingActivity";
                objSkinPiercing.ID = "ucSkinPiercingActivity";
                //objRenal.LoadDiabData();
                objSkinPiercing.SetData(lsthisPHA, HisOrComID);
                objSkinPiercing.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objSkinPiercing;
                lstControl.Add(objSkinPiercing.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSkinPiercing;
        }
        else if (strControl == "Cocaineintake")
        {
            objCocaineintake = LoadControl("../CommonControls/Cocaineintake.ascx") as CommonControls_Cocaineintake;
            try
            {
                //objCocaineintake.ControlID = "ucCocaineintake";
                objCocaineintake.ID = "ucCocaineintake";
                //objRenal.LoadDiabData();
                objCocaineintake.SetData(lsthisPHA, HisOrComID);
                objCocaineintake.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objCocaineintake;
                lstControl.Add(objCocaineintake.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objCocaineintake;
        }
        else if (strControl == "TreatedforSyphilis")
        {
            objSyphilis = LoadControl("../CommonControls/Syphilis.ascx") as CommonControls_Syphilis;
            try
            {
                //objSyphilis.ControlID = "ucSyphilis";
                objSyphilis.ID = "ucSyphilis";
                //objRenal.LoadDiabData();
                objSyphilis.SetData(lsthisPCA, HisOrComID);
                objSyphilis.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objSyphilis;
                lstControl.Add(objSyphilis.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSyphilis;
        }
        else if (strControl == "OrganTransplant")
        {
            objOrganTransplant = LoadControl("../CommonControls/OrganTransplant.ascx") as CommonControls_OrganTransplant;
            try
            {
                //objOrganTransplant.ControlID = "ucOrganTransplant";
                objOrganTransplant.ID = "ucOrganTransplant";
                //objRenal.LoadDiabData();
                objOrganTransplant.SetData(lsthisPCA, HisOrComID);
                objOrganTransplant.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objOrganTransplant;
                lstControl.Add(objOrganTransplant.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objOrganTransplant;
        }
        else if (strControl == "Bonegrafting")
        {
            objBoneGrafting = LoadControl("../CommonControls/Bonegrafting.ascx") as CommonControls_Bonegrafting;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objBoneGrafting.ID = "ucBonegrafting";
                //objRenal.LoadDiabData();
                objBoneGrafting.SetData(lsthisPCA, HisOrComID);
                objBoneGrafting.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objBoneGrafting;
                lstControl.Add(objBoneGrafting.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objBoneGrafting;
        }
        else if (strControl == "Skingrafting")
        {
            objSkinGrafting = LoadControl("../CommonControls/Skingrafting.ascx") as CommonControls_Skingrafting;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objSkinGrafting.ID = "ucSkingrafting";
                //objRenal.LoadDiabData();
                objSkinGrafting.SetData(lsthisPCA, HisOrComID);
                objSkinGrafting.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objSkinGrafting;
                lstControl.Add(objSkinGrafting.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSkinGrafting;
        }
        else if (strControl == "Typhoid")
        {
            objTyphoid = LoadControl("../CommonControls/Typhoid.ascx") as CommonControls_Typhoid;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objTyphoid.ID = "ucTyphoid";
                //objRenal.LoadDiabData();
                objTyphoid.SetData(lsthisPCA, HisOrComID);
                objTyphoid.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objTyphoid;
                lstControl.Add(objTyphoid.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objTyphoid;
        }
        else if (strControl == "TreatedforGonorrhoea")
        {
            objGonorrhoea = LoadControl("../CommonControls/Gonorrhoea.ascx") as CommonControls_Gonorrhoea;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objGonorrhoea.ID = "ucGonorrhoea";
                //objRenal.LoadDiabData();
                objGonorrhoea.SetData(lsthisPCA, HisOrComID);
                objGonorrhoea.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objGonorrhoea;
                lstControl.Add(objGonorrhoea.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objGonorrhoea;
        }
        else if (strControl == "ParasiticInfections")
        {
            objParasiticInfections = LoadControl("../CommonControls/ParasiticInfections.ascx") as CommonControls_ParasiticInfections;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objParasiticInfections.ID = "ucParasiticInfections";
                //objRenal.LoadDiabData();
                objParasiticInfections.SetData(lsthisPCA, HisOrComID);
                objParasiticInfections.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objParasiticInfections;
                lstControl.Add(objParasiticInfections.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objParasiticInfections;
        }
        else if (strControl == "Stroke")
        {
            objStroke = LoadControl("../CommonControls/Stroke.ascx") as CommonControls_Stroke;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objStroke.ID = "ucStroke";
                //objRenal.LoadDiabData();
                objStroke.SetData(lsthisPCA, HisOrComID);
                objStroke.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objStroke;
                lstControl.Add(objStroke.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objStroke;
        }
        else if (strControl == "DentalExtraction")
        {
            objDental = LoadControl("../CommonControls/DentalExtraction.ascx") as CommonControls_DentalExtraction;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objDental.ID = "ucDentalExtraction";
                //objRenal.LoadDiabData();
                objDental.SetData(lsthisPCA, HisOrComID);
                objDental.EditData(lstPCA, HisOrComID);

                objCtrl2 = (Control)objDental;
                lstControl.Add(objDental.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objDental;
        }
       
        else if (strControl == "BloodDonation")
        {
            objBloodDonate = LoadControl("../CommonControls/BloodDonation.ascx") as CommonControls_BloodDonation;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objBloodDonate.ID = "ucBloodDonation";
                //objRenal.LoadDiabData();
                objBloodDonate.SetData(lsthisPHA, HisOrComID);
                objBloodDonate.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objBloodDonate;
                lstControl.Add(objBloodDonate.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objBloodDonate;
        }
        else if (strControl == "VaccinationHistory")
        {
            objVaccinationHistory = LoadControl("../CommonControls/VaccinationHistory.ascx") as CommonControls_VaccinationHistory;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objVaccinationHistory.ID = "ucVaccination";
                //objRenal.LoadDiabData();
                objVaccinationHistory.SetData(lsthisPHA, HisOrComID);
                objVaccinationHistory.EditData(lstPatientPastVaccinationHistory, HisOrComID);

                objCtrl2 = (Control)objVaccinationHistory;
                lstControl.Add(objVaccinationHistory.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objVaccinationHistory;
        }

        else if (strControl == "TravelHistory")
        {
            objTravelHistory = LoadControl("../CommonControls/TravelHistory.ascx") as CommonControls_TravelHistory;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objTravelHistory.ID = "ucTravelHistory";
                //objRenal.LoadDiabData();
                objTravelHistory.SetData(lsthisPHA, HisOrComID);
                objTravelHistory.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objTravelHistory;
                lstControl.Add(objTravelHistory.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objTravelHistory;
        }
        else if (strControl == "SmallPox")
        {
            objSmallPox = LoadControl("../CommonControls/SmallPox.ascx") as CommonControls_SmallPox;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objSmallPox.ID = "ucSmallPox";
                //objRenal.LoadDiabData();
                objSmallPox.SetData(lsthisPHA, HisOrComID);
                objSmallPox.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objSmallPox;
                lstControl.Add(objSmallPox.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objSmallPox;
        }
        else if (strControl == "NeedleStickInjury")
        {
            objNeedleStickInjury = LoadControl("../CommonControls/NeedleStickInjury.ascx") as CommonControls_NeedleStickInjury;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objNeedleStickInjury.ID = "ucNeedleStickInjury";
                //objRenal.LoadDiabData();
                objNeedleStickInjury.SetData(lsthisPHA, HisOrComID);
                objNeedleStickInjury.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objNeedleStickInjury;
                lstControl.Add(objNeedleStickInjury.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objNeedleStickInjury;
        }
        else if (strControl == "TravelToMalarialPlace")
        {
            objTravelToMalarialPlace = LoadControl("../CommonControls/TravelToMalarialPlace.ascx") as CommonControls_TravelToMalarialPlace;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objTravelToMalarialPlace.ID = "ucTravelToMalarialPlace";
                //objRenal.LoadDiabData();
                objTravelToMalarialPlace.SetData(lsthisPHA, HisOrComID);
                objTravelToMalarialPlace.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objTravelToMalarialPlace;
                lstControl.Add(objTravelToMalarialPlace.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objTravelToMalarialPlace;
        }
        else if (strControl == "LivedWithHepatitisPerson")
        {
            objLivedWithHepatitisPerson = LoadControl("../CommonControls/LivedWithHepatitisPerson.ascx") as CommonControls_LivedWithHepatitisPerson;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objLivedWithHepatitisPerson.ID = "ucLivedWithHepatitisPerson";
                //objRenal.LoadDiabData();
                objLivedWithHepatitisPerson.SetData(lsthisPHA, HisOrComID);
                objLivedWithHepatitisPerson.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objLivedWithHepatitisPerson;
                lstControl.Add(objLivedWithHepatitisPerson.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objLivedWithHepatitisPerson;
        }
        else if (strControl == "UnprotectedIntercourse")
        {
            objUnprotectedIntercourse = LoadControl("../CommonControls/UnprotectedIntercourse.ascx") as CommonControls_UnprotectedIntercourse;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objUnprotectedIntercourse.ID = "ucUnprotectedIntercourse";
                //objRenal.LoadDiabData();
                objUnprotectedIntercourse.SetData(lsthisPHA, HisOrComID);
                objUnprotectedIntercourse.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objUnprotectedIntercourse;
                lstControl.Add(objUnprotectedIntercourse.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objUnprotectedIntercourse;
        }
        else if (strControl == "JailOrPrison")
        {
            objJailOrPrison = LoadControl("../CommonControls/JailOrPrison.ascx") as CommonControls_JailOrPrison;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objJailOrPrison.ID = "ucJailOrPrison";
                //objRenal.LoadDiabData();
                objJailOrPrison.SetData(lsthisPHA, HisOrComID);
                objJailOrPrison.EditData(lstPHA, HisOrComID);

                objCtrl2 = (Control)objJailOrPrison;
                lstControl.Add(objJailOrPrison.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objJailOrPrison;
        }
        else if (strControl == "MinorSurgery")
        {
            objMinorSurgery = LoadControl("../CommonControls/MinorSurgery.ascx") as CommonControls_MinorSurgery;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objMinorSurgery.ID = "ucMinorSurgery";
                //objRenal.LoadDiabData();
                objMinorSurgery.SetData(lstSurgicalDetails,HisOrComID);
                objMinorSurgery.EditData(lstSurgicalDetails);

                objCtrl2 = (Control)objMinorSurgery;
                lstControl.Add(objMinorSurgery.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objMinorSurgery;
        }
        else if (strControl == "MajorSurgery")
        {
            objMajorSurgery = LoadControl("../CommonControls/MajorSurgery.ascx") as CommonControls_MajorSurgery;
            try
            {
                //objBoneGrafting.ControlID = "ucBonegrafting";
                objMajorSurgery.ID = "ucMajorSurgery";
                //objRenal.LoadDiabData();
                objMajorSurgery.SetData(lstSurgicalDetails,HisOrComID);
                objMajorSurgery.EditData(lstSurgicalDetails);

                objCtrl2 = (Control)objMajorSurgery;
                lstControl.Add(objMajorSurgery.ID);
                ViewState["ControlID"] = lstControl;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on loadBioControl", ex);
            }
            return objMajorSurgery;
        }
        return objDiab;
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
            PS1=Convert.ToChar(hdnPS1.Value);
            TS1 = Convert.ToChar(hdnTS1.Value);
            PS2 = Convert.ToChar(hdnPS2.Value);
            TS2 = 'N';
            hdnTS2.Value = "N";
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2),Convert.ToString(ES1),Convert.ToString(ES2));
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
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2),Convert.ToString(ES1),Convert.ToString(ES2));
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
            SaveData(Convert.ToString(PS1), Convert.ToString(PS2), Convert.ToString(TS1), Convert.ToString(TS2),Convert.ToString(ES1),Convert.ToString(ES2));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnExclusion_Click", ex);
            btnSave.Enabled = true;
        }
    }
}
