using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;
using Attune.Podium.BillingEngine;
using System.Globalization;
using System.Text;
using System.Security.Cryptography;


public partial class EMR_PrintHistory : BaseControl
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    string strSHT = string.Empty;
    string strHea = string.Empty;
    string strOthe = string.Empty;
    string strDM = string.Empty;
    string strStroke = string.Empty;
    string strDyslipidemia = string.Empty;
    string strCancer = string.Empty;
    string strAsthma = string.Empty;
    string strTrait = string.Empty;
    string strHepatitis = string.Empty;
    string strTS = string.Empty;
    string strTSQt = string.Empty;
    string strAC = string.Empty;
    string strACQt = string.Empty;
    string strPhyActivity = string.Empty;
    string strDrugAllergy = string.Empty;
    string strDrugAllAllergy = string.Empty;
    string strFamilyHistory = string.Empty;
    string strFoodAllergy = string.Empty;
    string strInhalentsAllergy = string.Empty;
    string strContactAllergy =string.Empty;
    string strAllAllergy = string.Empty;
    string strDiet = string.Empty;
    string strBladder = string.Empty;
    string strBowel = string.Empty;
    string strDrug = string.Empty;
    string strThy = string.Empty;
    string strTub = string.Empty;
    string strPVD = string.Empty;
    string strRenal = string.Empty;
    string strLiver = string.Empty;
    string strMed = string.Empty;
    string strAll = string.Empty;
    string streducation = string.Empty;
    string stroccupation = string.Empty;
    string strincome = string.Empty;
    string strmarital = string.Empty;
    string strothers = string.Empty;
    StringBuilder sbTable = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void LoadHistoryData(long pVisitID)
    {
        try
        {
            string strTabl = "";
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
            List<DrugDetails> lstPatientPrescription = new List<DrugDetails>();
            List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
            List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
            List<PatientPastVaccinationHistory> lstPPVH = new List<PatientPastVaccinationHistory>();
            List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
            List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();


            returnCode = new Patient_BL(base.ContextInfo).GetPatientHistoryPackage(pVisitID, out lstPatHisAttribute, out lstPatientPrescription, out lstGPALDetails, out lstANCPatientDetails, out lstPPVH, out lstPCA, out lstSurgicalDetails);

            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            Patient patient = new Patient();
            patientBL.GetPatientDetailsPassingVisitID(pVisitID, out lstPatient);
            hdnSex.Value = lstPatient[0].SEX;
            if (lstPatient[0].SEX == "M")
            {

                tblGynacHisH.Style.Add("display", "none");
                tblGynacHisC.Style.Add("display", "none");
            }

            #region Complaint & Surgery

            if (lstPCA.Count > 0)
            {
                for (int i = 0; i < lstPCA.Count(); i++)
                {
                    #region Systemic Hypertension
                    try
                    {
                        if (lstPCA[i].ComplaintID == 402)
                        {
                            lblShNill.Visible = false;
                            if (lstPCA[i].AttributeID == 1)
                            {
                                strSHT = lstPCA[i].AttributeValueName;
                            }
                            if (lstPCA[i].AttributeID == 2)
                            {
                                if (lstPCA[i].AttributevalueID == 4)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += ", " + "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    strMed = "Medical History";
                                }
                                if (lstPCA[i].AttributevalueID == 5)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += lstPCA[i].AttributeValueName + ", ";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    strMed = "Medical History";
                                }
                                if (lstPCA[i].AttributevalueID == 6)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += lstPCA[i].AttributeValueName + ", ";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    strMed = "Medical History";
                                }
                                if (lstPCA[i].AttributevalueID == 7)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += lstPCA[i].AttributeValueName + ", ";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    strMed = "Medical History";
                                }
                                if (lstPCA[i].AttributevalueID == 8)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += lstPCA[i].AttributeValueName + ", ";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                    }
                                    strMed = "Medical History";
                                }
                                if (lstPCA[i].AttributevalueID == 9)
                                {
                                    if (strSHT != string.Empty)
                                    {
                                        strSHT += lstPCA[i].AttributeValueName + ".";
                                    }
                                    else
                                    {
                                        strSHT = "Treatment :- " + lstPCA[i].AttributeValueName + ".";
                                    }
                                    strMed = "Medical History";
                                }

                            }

                            if (lstPCA[i].AttributeID == 402)
                            {
                                lblShNill.Visible = true;
                                lblShNill.Text = "Present";
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }

                    #endregion

                    #region Heart Disease
                    try
                    {
                        if (lstPCA[i].ComplaintID == 332)
                        {
                            lblHDNil.Visible = false;
                            if (lstPCA[i].AttributeID == 3)
                            {
                                lblDiseaseTypeHDAI_3.Visible = true;
                                lblDiseaseTypeHDAVI_3.Visible = true;
                                lblDiseaseTypeHDAVI_3.Text = lstPCA[i].AttributeValueName;
                                strHea = lstPCA[i].AttributeValueName;
                                strMed = "Medical History";
                            }
                            if (lstPCA[i].AttributeID == 4)
                            {
                                lblDiseaseHDAI_4.Visible = true;
                                lblDiseaseHDAVI_4.Visible = true;
                                lblDiseaseHDAVI_4.Text = lstPCA[i].AttributeValueName;
                                strHea = lstPCA[i].AttributeValueName;
                                strMed = "Medical History";
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Diabetes Mellitus
                    try
                    {
                        if (lstPCA[i].ComplaintID == 389)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 389
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 389)
                                {

                                    lblDMNil.Visible = false;
                                    if (pca.AttributeID == 5)
                                    {
                                        strDM = pca.AttributeValueName + ", ";
                                    }
                                    if (pca.AttributeID == 6)
                                    {
                                        if (strDM != string.Empty)
                                        {
                                            strDM += pca.AttributeValueName + "; ";
                                        }
                                        else
                                        {
                                            strDM = pca.AttributeValueName + "; ";
                                        }
                                        strMed = "Medical History";
                                    }
                                    if (pca.AttributeID == 7)
                                    {
                                        if (strDM != string.Empty)
                                        {
                                            strDM += "Treatment :- " + pca.AttributeValueName + "; ";
                                        }
                                        else
                                        {
                                            strDM += "Treatment :- " + pca.AttributeValueName + "; ";
                                        }
                                        strMed = "Medical History";
                                    }

                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion


                    #region THYROID
                    try
                    {
                        if (lstPCA[i].ComplaintID == 207)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 207
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 207)
                                {

                                    lblNil_207.Visible = false;
                                    if (pca.AttributeID == 25)
                                    {
                                        strThy = pca.AttributeValueName + ", ";
                                    }
                                    if (pca.AttributeID == 26)
                                    {
                                        if (strThy != string.Empty)
                                        {
                                            strThy += pca.AttributeValueName + "; ";
                                        }
                                        else
                                        {
                                            strThy = pca.AttributeValueName + "; ";
                                        }
                                        strMed = "Medical History";
                                    }
                                    if (pca.AttributeID == 27)
                                    {
                                        if (strThy != string.Empty)
                                        {
                                            strThy += "Treatment :- " + pca.AttributeValueName + "; ";
                                        }
                                        else
                                        {
                                            strThy += "Treatment :- " + pca.AttributeValueName + "; ";
                                        }
                                        strMed = "Medical History";
                                    }

                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Tuberculosis
                    try
                    {
                        if (lstPCA[i].ComplaintID == 946)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 946
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 946)
                                {

                                    lblNil_946.Visible = false;
                                    strTub = pca.AttributeValueName + ", ";
                                    strMed = "Medical History";
                                }
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion


                    #region PVD
                    try
                    {
                        if (lstPCA[i].ComplaintID == 181)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 181
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 181)
                                {

                                    lblNil_184.Visible = false;
                                    strPVD = pca.AttributeValueName + ", ";
                                    strMed = "Medical History";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Renal Disorder
                    try
                    {
                        if (lstPCA[i].ComplaintID == 32)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 32
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 32)
                                {

                                    lblNil_32.Visible = false;
                                    strRenal = pca.AttributeValueName + ", ";
                                    strMed = "Medical History";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion


                    #region Liver Disorder
                    try
                    {
                        if (lstPCA[i].ComplaintID == 78)
                        {
                            var listDB = from Res in lstPCA
                                         where Res.ComplaintID == 78
                                         select Res;

                            foreach (PatientComplaintAttribute pca in listDB)
                            {
                                if (pca.ComplaintID == 78)
                                {

                                    lblNil_32.Visible = false;
                                    strLiver = pca.AttributeValueName + ", ";
                                    strMed = "Medical History";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion


                    #region Other Disease
                    try
                    {
                        if (lstPCA[i].ComplaintID == 945)
                        {
                            lblHDNil.Visible = false;
                            if (lstPCA[i].AttributeID == 28)
                            {
                                lblOtherDiseases.Visible = true;
                                lblOtherDiseases_945.Visible = true;
                                lblOtherDiseases_945.Text = lstPCA[i].AttributeValueName;
                                strOthe = lstPCA[i].AttributeValueName;
                                strMed = "Other Diseases";
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Stroke
                    try
                    {
                        if (lstPCA[i].ComplaintID == 438)
                        {
                            lblS_438.Visible = false;
                            if (lstPCA[i].AttributeID == 8)
                            {
                                strStroke = lstPCA[i].AttributeValueName;
                                strMed = "Medical History";
                            }
                            if (lstPCA[i].AttributeID == 9)
                            {
                                if (strStroke != string.Empty)
                                {
                                    strStroke += "(" + lstPCA[i].AttributeValueName + "), ";
                                }
                                else
                                {
                                    strStroke = "(" + lstPCA[i].AttributeValueName + "), ";
                                }
                                strMed = "Medical History";
                            }
                            if (lstPCA[i].AttributeID == 10)
                            {
                                if (strStroke != string.Empty)
                                {
                                    strStroke += "Type of CVA :- " + lstPCA[i].AttributeValueName + "; ";
                                }
                                else
                                {
                                    strStroke = "Type of CVA :- " + lstPCA[i].AttributeValueName + "; ";
                                }
                                strMed = "Medical History";
                            }

                            if (lstPCA[i].AttributeID == 11)
                            {
                                if (strStroke != string.Empty)
                                {
                                    strStroke += "Area / Lobe affected :- " + lstPCA[i].AttributeValueName;
                                }
                                else
                                {
                                    strStroke = "Area / Lobe affected :- " + lstPCA[i].AttributeValueName;
                                }
                                strMed = "Medical History";
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Dyslipidemia
                    try
                    {
                        if (lstPCA[i].ComplaintID == 409)
                        {
                            lblNil_409.Visible = false;
                            if (lstPCA[i].AttributeID == 12)
                            {
                                strDyslipidemia = lstPCA[i].AttributeValueName;
                            }


                            if (lstPCA[i].AttributeID == 409)
                            {
                                lblNil_409.Visible = true;
                                lblNil_409.Text = "Present";
                            }

                            strMed = "Medical History";


                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Cancer
                    try
                    {
                        if (lstPCA[i].ComplaintID == 372)
                        {
                            lblnil_372.Visible = false;
                            if (lstPCA[i].AttributeID == 13)
                            {
                                strCancer = lstPCA[i].AttributeValueName + " Cancer, ";
                            }
                            if (lstPCA[i].AttributeID == 14)
                            {
                                if (strCancer != string.Empty)
                                {
                                    strCancer += lstPCA[i].AttributeValueName + ", ";
                                }
                                else
                                {
                                    strCancer = lstPCA[i].AttributeValueName + ", ";
                                }
                            }
                            if (lstPCA[i].AttributeID == 15)
                            {
                                if (strCancer != string.Empty)
                                {
                                    strCancer += "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                }
                                else
                                {
                                    strCancer = lstPCA[i].AttributeValueName + ", ";
                                }
                            }
                            strMed = "Medical History";

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Asthma
                    try
                    {
                        if (lstPCA[i].ComplaintID == 246)
                        {
                            lblNil_246.Visible = false;
                            if (lstPCA[i].AttributeID == 16)
                            {
                                strAsthma = lstPCA[i].AttributeValueName + ", ";
                            }
                            if (lstPCA[i].AttributeID == 17)
                            {
                                if (strAsthma != string.Empty)
                                {
                                    strAsthma += "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                }
                                else
                                {
                                    strAsthma = "Treatment :- " + lstPCA[i].AttributeValueName + ", ";
                                }
                            }
                            if (lstPCA[i].AttributeID == 18)
                            {
                                if (strAsthma != string.Empty)
                                {
                                    strAsthma += "Exacerbations :- " + lstPCA[i].AttributeValueName;
                                }
                                else
                                {
                                    strAsthma = "Exacerbations :- " + lstPCA[i].AttributeValueName;
                                }
                            }
                            strMed = "Medical History";

                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Thalassemia Trait
                    try
                    {
                        if (lstPCA[i].ComplaintID == 536)
                        {
                            lblNil_536.Visible = false;
                            if (lstPCA[i].AttributeID == 19)
                            {
                                strTrait = lstPCA[i].AttributeValueName + "  trait present.";
                            }
                            strMed = "Medical History";
                        }

                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion

                    #region Hepatitis B Carrier
                    try
                    {
                        if (lstPCA[i].ComplaintID == 537)
                        {
                            lblNil_537.Visible = false;
                            if (lstPCA[i].AttributeID == 20)
                            {
                                strHepatitis = lstPCA[i].AttributeValueName + "; ";
                            }
                            if (lstPCA[i].AttributeID == 21)
                            {
                                if (strHepatitis != string.Empty)
                                {
                                    strHepatitis += "Treatment :- " + lstPCA[i].AttributeValueName;
                                }
                            }
                            if (lstPCA[i].AttributeID == 537)
                            {
                                lblNil_537.Visible = true;
                                lblNil_537.Text = "Present";
                            }
                            strMed = "Medical History";
                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                    }
                    #endregion
                }
                try
                {
                    if (strMed != string.Empty)
                    {
                        tblMedical.Attributes.Add("style", "display:block");
                        tblMedical1.Attributes.Add("style", "display:block");
                    }
                    if (strFamilyHistory != string.Empty)
                    {
                        tblMedical.Attributes.Add("style", "display:block");
                        tblMedical1.Attributes.Add("style", "display:block");
                    }
                    if (strSHT != string.Empty)
                    {
                        trSystemic.Attributes.Add("style", "display:block");
                        trSystemic1.Attributes.Add("style", "display:block");
                        lblDurationShAVI_1.Visible = true;
                        lblDurationShAVI_1.Text = strSHT.ToString();
                    }
                    if (strHea != string.Empty)
                    {
                        trHeart.Attributes.Add("style", "display:block");
                        trHeart1.Attributes.Add("style", "display:block");
                        tabHeart.Attributes.Add("style", "display:block");
                    }
                    if (strDM != string.Empty)
                    {
                        lblDurationDMAI_5.Visible = true;
                        lblDurationDMAI_5.Text = strDM.ToString();
                    }

                    if (strThy != string.Empty)
                    {
                        trThyroid.Attributes.Add("style", "display:block");
                        trThyroid1.Attributes.Add("style", "display:block");
                        lblDurationThyroid_207.Visible = true;
                        lblDurationThyroid_207.Text = strThy.ToString();
                    }
                    if (strTub != string.Empty)
                    {
                        trTuberculosis.Attributes.Add("style", "display:block");
                        trTuberculosis1.Attributes.Add("style", "display:block");
                        lblDurationTuberculosis_946.Visible = true;
                        lblDurationTuberculosis_946.Text = strTub.ToString();
                    }
                    if (strOthe != string.Empty)
                    {
                        trOther.Attributes.Add("style", "display:block");
                        lblOtherDiseases.Visible = true;
                        lblOtherDiseases_945.Visible = true;
                        lblOtherDiseases_945.Text = strOthe.ToString();
                        
                    }
                    if (strPVD != string.Empty)
                    {
                        trPVD.Attributes.Add("style", "display:block");
                        trPVD1.Attributes.Add("style", "display:block");
                        lblDurationPVD_184.Visible = true;
                        lblDurationPVD_184.Text = strPVD.ToString();
                    }
                    if (strRenal != string.Empty)
                    {
                        trRenal.Attributes.Add("style", "display:block");
                        trRenal1.Attributes.Add("style", "display:block");
                        lblDurationRenal_32.Visible = true;
                        lblDurationRenal_32.Text = strRenal.ToString();
                    }
                    if (strLiver != string.Empty)
                    {
                        trLiver.Attributes.Add("style", "display:block");
                        trLiver1.Attributes.Add("style", "display:block");
                        lblNil_78.Visible = false;
                        lblDurationLiver_78.Visible = true;
                        lblDurationLiver_78.Text = strLiver.ToString();
                    }
                    if (strStroke != string.Empty)
                    {
                        trStroke.Attributes.Add("style", "display:block");
                        trStroke1.Attributes.Add("style", "display:block");
                        lblDateSAI_8.Visible = true;
                        lblDateSAI_8.Text = strStroke.ToString();
                    }
                    if (strDyslipidemia != string.Empty)
                    {
                        trDyslipidemia.Attributes.Add("style", "display:block");
                        trDyslipidemia1.Attributes.Add("style", "display:block");
                        lblDurationDLAI_12.Visible = true;
                        lblDurationDLAI_12.Text = strDyslipidemia.ToString();
                    }
                    if (strCancer != string.Empty)
                    {
                        trCancer.Attributes.Add("style", "display:block");
                        trCancer1.Attributes.Add("style", "display:block");
                        lblSOCCAI_13.Visible = true;
                        lblSOCCAI_13.Text = strCancer.ToString();
                    }
                    if (strAsthma != string.Empty)
                    {
                        trAsthma.Attributes.Add("style", "display:block");
                        trAsthma1.Attributes.Add("style", "display:block");
                        lblDurationAAI_16.Visible = true;
                        lblDurationAAI_16.Text = strAsthma.ToString();
                    }
                    if (strTrait != string.Empty)
                    {
                        trThalassemia.Attributes.Add("style", "display:block");
                        trThalassemia1.Attributes.Add("style", "display:block");
                        lblTraitTTAI_19.Visible = true;
                        lblTraitTTAI_19.Text = strTrait.ToString();
                    }
                    if (strHepatitis != string.Empty)
                    {
                        trHepatitisB.Attributes.Add("style", "display:block");
                        trHepatitisB1.Attributes.Add("style", "display:block");
                        lblDurationHBCAI_20.Visible = true;
                        lblDurationHBCAI_20.Text = strHepatitis.ToString();
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                }
            }

            #endregion

            #region Histories
            try
            {
                if (lstPatHisAttribute.Count > 0)
                {
                    string strAllergy = "";
                    sbTable.Append("<Table border=1>");
                    sbTable.Append("<tr>");
                    sbTable.Append("<th align='center'>Allergies</th>");
                    sbTable.Append("<th align='center'>Duration</th>");
                    sbTable.Append("<th align='center'>Reaction</th>");
                    sbTable.Append("<th align='center'>On-Going</th>");
                    sbTable.Append("<th align='center'>Treatment</th>");
                    sbTable.Append("</tr>");
                    for (int i = 0; i < lstPatHisAttribute.Count(); i++)
                    {
                        PatientHistoryAttribute PHA = new PatientHistoryAttribute();

                        #region TobaccoSmoking

                        if (lstPatHisAttribute[i].HistoryID == 476)
                        {
                            lblTSNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 1)
                            {
                                strTS = lstPatHisAttribute[i].AttributeValueName + ", ";
                            }
                            if (lstPatHisAttribute[i].AttributeID == 2)
                            {
                                if (strTS != string.Empty)
                                {
                                    strTS += "for " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                                else
                                {
                                    strTS = "For " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 3)
                            {
                                if (strTS != string.Empty)
                                {
                                    strTS += lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                                else
                                {
                                    strTS = lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                        }

                        #endregion
                        #region TobaccoSmokingQuit
                       // strTSQt = "Countinue";
                        if (lstPatHisAttribute[i].HistoryID == 1094)
                        {
                            lblTSNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 52)
                            {
                                if (lstPatHisAttribute[i].AttributeValueName != string.Empty)
                                {
                                    strTSQt = "Quit " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 53)
                            {
                                if (strTSQt != string.Empty)
                                {
                                    strTSQt +=  lstPatHisAttribute[i].AttributeValueName + " ago ";
                                }
                               
                            }

                        }

                        #endregion

                        #region Diabetes Mellitus
                        if (lstPatHisAttribute[i].HistoryID == 1069)
                        {
                            lblTSNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 27)
                            {
                                strDM += " F/H/O DM : " + lstPatHisAttribute[i].AttributeValueName ;
                            }
                        }
                        if (lstPatHisAttribute[i].HistoryID == 1093)
                        {
                            lblTSNil.Visible = false;
                            strDM += " H/O Hypoglycemia : " + lstPatHisAttribute[i].AttributeValueName + ", ";
                        }
                        if (strDM != string.Empty)
                        {
                            trDiabetes.Attributes.Add("style", "display:block");
                            lblDurationDMAI_5.Visible = true;
                            lblDurationDMAI_5.Text = strDM.ToString();
                        }
                        #endregion


                        #region Alcohol Consumption

                        if (lstPatHisAttribute[i].HistoryID == 369)
                        {
                            lblACNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 4)
                            {
                                strAC = lstPatHisAttribute[i].AttributeValueName + ", ";
                            }
                            if (lstPatHisAttribute[i].AttributeID == 5)
                            {
                                if (strAC != string.Empty)
                                {
                                    strAC += "for " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                                else
                                {
                                    strAC = "For " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 6)
                            {
                                if (strAC != string.Empty)
                                {
                                    strAC += lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                                else
                                {
                                    strAC = lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                        }

                        #endregion

                        #region Alcohol Consumption Quit
                       // strACQt = "Countinue";
                        if (lstPatHisAttribute[i].HistoryID == 1095)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 54)
                            {
                                if (lstPatHisAttribute[i].AttributeValueName != string.Empty)
                                {
                                    strACQt = "Quit " + lstPatHisAttribute[i].AttributeValueName + " ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 55)
                            {
                                if (strACQt != string.Empty)
                                {
                                    strACQt += lstPatHisAttribute[i].AttributeValueName + " ago ";
                                }
                                
                            }
                        }

                        #endregion

                        #region Diet
                        if (lstPatHisAttribute[i].HistoryID == 1085)
                        {
                            lblDiet.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 44)
                            {
                                strDiet = lstPatHisAttribute[i].AttributeValueName;
                            }
                            strMed = "Medical History";
                        }


                        #endregion
                        if (lstPatHisAttribute[i].HistoryID == 1092)
                        {
                            lblPresent.Visible = false;
                            lblPresentComplaints.Visible = false;
                            if (lstPatHisAttribute[i].AttributeValueName.ToString() != "")
                            {
                                lblPresent.Visible = true;
                                lblPresentComplaints.Visible = true;
                                lblPresentComplaints.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                                strMed = "Medical History";
                                tblMedical1.Attributes.Add("Style", "display:block");
                                tblMedical.Attributes.Add("Style", "display:block");
                            }
                        }
                        #region Bladder
                        if (lstPatHisAttribute[i].HistoryID == 1071)
                        {
                            lblBladderNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 29)
                            {
                                strBladder = lstPatHisAttribute[i].AttributeValueName;
                            }
                        }

                        #endregion

                        //--------------------------GURUNATH.S
                        #region Personal History Attributes

                        #region Education
                        if (lstPatHisAttribute[i].HistoryID == 1087)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 45)
                            {
                                if (lstPatHisAttribute[i].AttributevalueID == 161)
                                {
                                    streducation = lstPatHisAttribute[i].AttributeValueName;
                                }
                            }
                            if (streducation != string.Empty)
                            {
                                if (lstPatHisAttribute[i].AttributeID == 46)
                                {
                                    if (lstPatHisAttribute[i].AttributevalueID == 162)
                                    {
                                        if (lstPatHisAttribute[i].AttributeValueName == "NO")
                                        {
                                            tblPersonalHistory.Attributes.Add("style", "display:block");
                                            tblPersonalHistory1.Attributes.Add("style", "display:block");
                                            trEducation.Attributes.Add("style", "display:block");
                                            trEducation1.Attributes.Add("style", "display:block");
                                            lblEducation.Visible = true;
                                            lblEducation1.Visible = true;
                                            lblEducation1.Text = streducation;
                                        }
                                        else
                                        {
                                            trEducation.Attributes.Add("style", "display:none");
                                            trEducation1.Attributes.Add("style", "display:none");
                                        }
                                    }
                                }
                            }

                        }
                        #endregion

                        #region Occupation
                        if (lstPatHisAttribute[i].HistoryID == 1088)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 47)
                            {
                                if (lstPatHisAttribute[i].AttributevalueID == 163)
                                {
                                    stroccupation = lstPatHisAttribute[i].AttributeValueName;
                                }
                            }
                            if (stroccupation != string.Empty)
                            {
                                if (lstPatHisAttribute[i].AttributeID == 48)
                                {
                                    if (lstPatHisAttribute[i].AttributevalueID == 164)
                                    {
                                        if (lstPatHisAttribute[i].AttributeValueName == "NO")
                                        {
                                            tblPersonalHistory.Attributes.Add("style", "display:block");
                                            tblPersonalHistory1.Attributes.Add("style", "display:block");
                                            trOccupation.Attributes.Add("style", "display:block");
                                            trOccupation1.Attributes.Add("style", "display:block");
                                            lblOccupation.Visible = true;
                                            lblOccupation1.Visible = true;
                                            lblOccupation1.Text = stroccupation.ToString();
                                        }
                                        else
                                        {
                                            trOccupation.Attributes.Add("style", "display:none");
                                            trOccupation1.Attributes.Add("style", "display:none");
                                        }
                                    }
                                }
                            }

                        }
                        #endregion

                        #region Income
                        if (lstPatHisAttribute[i].HistoryID == 1089)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 49)
                            {
                                if (lstPatHisAttribute[i].AttributevalueID == 165)
                                {
                                    strincome = lstPatHisAttribute[i].AttributeValueName;
                                }
                            }
                            if (strincome != string.Empty)
                            {
                                if (lstPatHisAttribute[i].AttributeID == 50)
                                {
                                    if (lstPatHisAttribute[i].AttributevalueID == 166)
                                    {
                                        if (lstPatHisAttribute[i].AttributeValueName == "NO")
                                        {
                                            tblPersonalHistory.Attributes.Add("style", "display:block");
                                            tblPersonalHistory1.Attributes.Add("style", "display:block");
                                            trIncome.Attributes.Add("style", "display:block");
                                            trIncome1.Attributes.Add("style", "display:block");
                                            lblIncome.Visible = true;
                                            lblIncome1.Visible = true;
                                            lblIncome1.Text = strincome.ToString();
                                        }
                                        else
                                        {
                                            trIncome.Attributes.Add("style", "display:none");
                                            trIncome1.Attributes.Add("style", "display:none");
                                        }
                                    }
                                }
                            }
                        }
                        #endregion

                        #region Marital
                        if (lstPatHisAttribute[i].HistoryID == 1090)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 51)
                            {
                                if (lstPatHisAttribute[i].AttributevalueID == 167)
                                {
                                    strmarital = lstPatHisAttribute[i].AttributeValueName;
                                }
                            }
                            if (strmarital != string.Empty)
                            {
                                if (lstPatHisAttribute[i].AttributeID == 52)
                                {
                                    if (lstPatHisAttribute[i].AttributevalueID == 168)
                                    {
                                        if (lstPatHisAttribute[i].AttributeValueName == "NO")
                                        {
                                            tblPersonalHistory.Attributes.Add("style", "display:block");
                                            tblPersonalHistory1.Attributes.Add("style", "display:block");
                                            trMarital.Attributes.Add("style", "display:block");
                                            trMarital1.Attributes.Add("style", "display:block");
                                            lblMarital.Visible = true;
                                            lblMarital1.Visible = true;
                                            lblMarital1.Text = strmarital.ToString();
                                        }
                                        else
                                        {
                                            trMarital.Attributes.Add("style", "display:none");
                                            trMarital1.Attributes.Add("style", "display:none");
                                        }
                                    }
                                }
                            }
                        }
                        #endregion

                        #region others
                        if (lstPatHisAttribute[i].HistoryID == 1091)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 53)
                            {
                                if (lstPatHisAttribute[i].AttributevalueID == 169)
                                {
                                    strothers = lstPatHisAttribute[i].AttributeValueName;
                                }
                            }
                            if (strothers != string.Empty)
                            {
                                if (lstPatHisAttribute[i].AttributeID == 54)
                                {
                                    if (lstPatHisAttribute[i].AttributevalueID == 170)
                                    {
                                        if (lstPatHisAttribute[i].AttributeValueName == "NO")
                                        {
                                            tblPersonalHistory.Attributes.Add("style", "display:block");
                                            tblPersonalHistory1.Attributes.Add("style", "display:block");
                                            trOthers.Attributes.Add("style", "display:block");
                                            trOthers1.Attributes.Add("style", "display:block");
                                            lblOthers.Visible = true;
                                            lblOthers1.Visible = true;
                                            lblOthers1.Text = strothers.ToString();
                                        }
                                        else
                                        {
                                            trOthers.Attributes.Add("style", "display:none");
                                            trOthers1.Attributes.Add("style", "display:none");
                                        }
                                    }
                                }
                            }
                        }
                        #endregion
                        #endregion
                        //----------------------------------------
                        #region Bowel
                        if (lstPatHisAttribute[i].HistoryID == 1085)
                        {
                            lblBladderNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 113)
                            {
                                strBowel = lstPatHisAttribute[i].AttributeValueName;
                            }
                        }

                        #endregion
                        #region DrugSubtance
                        if (lstPatHisAttribute[i].HistoryID == 1096)
                        {
                            lblDrugSubNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 120)
                            {
                                strDrug = lstPatHisAttribute[i].AttributeValueName;
                            }
                        }

                        #endregion

                        #region Physicial Activity

                        if (lstPatHisAttribute[i].HistoryID == 1059)
                        {
                            lblPhyActNil.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 7)
                            {
                                strPhyActivity = lstPatHisAttribute[i].AttributeValueName + ", ";
                            }
                            if (lstPatHisAttribute[i].AttributeID == 8)
                            {
                                if (strPhyActivity != string.Empty)
                                {
                                    strPhyActivity += "Aerobic :- " + lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                                else
                                {
                                    strPhyActivity = "Aerobic :- " + lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 9)
                            {
                                if (strPhyActivity != string.Empty)
                                {
                                    strPhyActivity += "Anaerobic :- " + lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                                else
                                {
                                    strPhyActivity = "Anaerobic :- " + lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                            }
                            if (lstPatHisAttribute[i].AttributeID == 10)
                            {
                                if (strPhyActivity != string.Empty)
                                {
                                    strPhyActivity += lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                                else
                                {
                                    strPhyActivity = lstPatHisAttribute[i].AttributeValueName + "; ";
                                }
                            }
                        }

                        #endregion

                        #region Family History
                        string strFamily = "";
                        tabAllergy1.Attributes.Add("style", "display:block");
                        if (lstPatHisAttribute[i].HistoryID == 1070)
                        {
                            if (lstPatHisAttribute[i].AttributeID == 28)
                            {
                                strFamilyHistory = lstPatHisAttribute[i].AttributeValueName;
                                hdnFamilyHistory.Value = lstPatHisAttribute[i].AttributeValueName.ToString();
                                var lstFam = lstPatHisAttribute[i].AttributeValueName.Split('^');
                                for (int j = 0; j < lstFam.Count(); j++)
                                {
                                    var lstFam1 = lstFam[j].Split('~');

                                }

                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "FamilyHist", "createFtab_new();", true);

                                strFamily = "Family History";
                            }
                        }

                        #endregion

                        if (strTabl == "")
                        {
                            if (lstPatHisAttribute[i].HistoryID > 1061 && lstPatHisAttribute[i].HistoryID < 1085)
                            {
                                if (lstPatHisAttribute[i].HistoryID == 1061 || lstPatHisAttribute[i].HistoryID == 1062 || lstPatHisAttribute[i].HistoryID > 1071)
                                {


                                    var patHIS = from HisID in lstPatHisAttribute
                                                 where ((HisID.HistoryID == 1061 || HisID.HistoryID == 1062) || (HisID.HistoryID > 1071 && HisID.HistoryID < 1085))
                                                 group HisID by
                                                     new
                                                     {
                                                         HisID.HistoryID,
                                                     }
                                                     into grp
                                                     select grp;
                                    for (int grpID = 0; grpID < patHIS.Count(); grpID++)
                                    {
                                        string strCheck = "";
                                        foreach (PatientHistoryAttribute pat in lstPatHisAttribute)
                                        {
                                            if (lstPatHisAttribute[i].HistoryID == 1061 || lstPatHisAttribute[i].HistoryID == 1062 || lstPatHisAttribute[i].HistoryID > 1071)
                                            {
                                                if (pat.HistoryID == patHIS.ElementAt(grpID).Key.HistoryID)
                                                {
                                                    if (strCheck == "")
                                                    {
                                                        sbTable.Append("<tr>");
                                                        sbTable.Append("<td>" + pat.AttributeValueName + "</td>");
                                                        strCheck = "strCheck";
                                                    }
                                                    else
                                                    {
                                                        sbTable.Append("<td>" + pat.AttributeValueName + "</td>");
                                                    }
                                                }
                                            }

                                        }
                                        sbTable.Append("</tr>");
                                        strAllergy = "Allergies";
                                        strDrugAllAllergy = "All Allergies";
                                    }
                                    sbTable.Append("</table>");
                                    strTabl = "Allergy Table";
                                }
                            }
                        }
                        #region Gyanac History

                        if (lstPatHisAttribute[i].HistoryID == 1065)
                        {
                            LblGHNil.Visible = false;

                            tblGynacHisH.Attributes.Add("Style", "display:block");
                            tblGynacHisC.Attributes.Add("Style", "display:block");
                            tblGynaecological.Attributes.Add("Style", "display:block");
                            tblGynaecological1.Attributes.Add("Style", "display:block");
                            if (lstPatHisAttribute[i].AttributeID == 13)
                            {
                                trLMPDate.Attributes.Add("Style", "display:block");
                                lblLMPDate_13.Visible = true;
                                lblLMPDate_38.Visible = true;
                                lblLMPDate_38.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 14)
                            {
                                lblMenstrualCycle_14.Visible = true;
                                lblMenstrualCyc.Visible = true;
                                lblMenstrualCyc.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 15)
                            {
                                trCycleLength.Attributes.Add("Style", "display:block");
                                lblCycleLength_15.Visible = true;
                                lblCycleLength_45.Visible = true;
                                lblCyclelengthDays.Visible = true;
                                lblCycleLength_45.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 16)
                            {
                                lblLastPapSmear.Visible = true;
                                lblLastPapSmear_46.Visible = true;
                                lblLastPapSmear_46.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 17)
                            {
                                lblContraception_17.Visible = true;
                                lblContraception.Visible = true;
                                lblContraception.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 18)
                            {
                                trAgeofMenarchy.Attributes.Add("Style", "display:block");
                                lblAgeofMenarchy_18.Visible = true;
                                lblAgeofMenarchy_47.Visible = true;
                                lblAgeofMenarchyYears_47.Visible = true;
                                lblAgeofMenarchy_47.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 19)
                            {
                                lblLastPapSmearResult_19.Visible = true;
                                lblLastPapSmearResult.Visible = true;
                                lblLastPapSmearResult.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 20)
                            {
                                trLastMamogram.Attributes.Add("Style", "display:block");
                                lblLastMamogram_20.Visible = true;
                                lblLastMamogram.Visible = true;
                                lblLastMamogram.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 21)
                            {
                                trLastMamogramResult.Attributes.Add("Style", "display:block");
                                lblLastMamogramResult_21.Visible = true;
                                lblLastMamogramResult.Visible = true;
                                lblLastMamogramResult.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                        }

                        #endregion

                        #region HRT

                        if (lstPatHisAttribute[i].HistoryID == 1066)
                        {
                            trHormone.Attributes.Add("Style", "display:block");
                            LblHRTil0.Visible = false;
                            if (lstPatHisAttribute[i].AttributeID == 22)
                            {
                                trTypeofHRT.Attributes.Add("Style", "display:block");
                                lblTypeofHRT_22.Visible = true;
                                lblTypeofHRT.Visible = true;
                                lblTypeofHRT.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                            if (lstPatHisAttribute[i].AttributeID == 23)
                            {
                                lblHRTDelivery_23.Visible = true;
                                lblHRTDelivery.Visible = true;
                                lblHRTDelivery.Text = lstPatHisAttribute[i].AttributeValueName;
                            }
                        }

                        #endregion

                    }

                    if (strTS != string.Empty)
                    {
                        trTobacco.Attributes.Add("style", "display:block");
                        trTobacco1.Attributes.Add("style", "display:block");
                        lblTypeTS_1.Visible = true;
                        lblTypeTS_1.Text = strTS.ToString();
                    }
                    if (strTSQt != string.Empty)
                    {
                        trTSQt.Attributes.Add("style", "display:block");
                        lblQuitSmk_45.Visible = true;
                        lblQuitSmk_45.Text = strTSQt.ToString();
                    }
                    if (strAC != string.Empty)
                    {
                        trAlcohol.Attributes.Add("style", "display:block");
                        trAlcohol1.Attributes.Add("style", "display:block");
                        lblTypeAC_4.Visible = true;
                        lblTypeAC_4.Text = strAC.ToString();
                    }
                    if (strACQt != string.Empty)
                    {
                        trACQt.Attributes.Add("style", "display:block");
                        lblQuitAC_46.Visible = true;
                        lblQuitAC_46.Text = strACQt.ToString();
                    }
                    if (strDiet != string.Empty)
                    {
                        trDietHabit.Attributes.Add("style", "display:block");
                        trDietHabit1.Attributes.Add("style", "display:block");
                        lblDiet.Visible = true;
                        lblDietHabit.Visible = true;
                        lblDietHabit.Text = strDiet.ToString();
                    }
                    if (strBladder != string.Empty)
                    {
                        trBladder.Attributes.Add("style", "display:block");
                        trBladder1.Attributes.Add("style", "display:block");
                        lblBladder.Visible = true;
                        lblBladderNil.Visible = false;
                        lblBladderDis.Text = strBladder.ToString();
                    }
                    if (strBowel != string.Empty)
                    {
                        trBowel.Attributes.Add("style", "display:block");
                        trBowel1.Attributes.Add("style", "display:block");
                        lblBowel.Visible = true;
                        lblBowelNil.Visible = false;
                        lblBowelDis.Text = strBowel.ToString();
                    }
                    if (strDrug != string.Empty)
                    {
                        trDrug.Attributes.Add("style", "display:block");
                        trDrug1.Attributes.Add("style", "display:block");
                        lblDrugSub.Visible = true;
                        lblDrugSubNil.Visible = false;
                        lblDrugSubDis.Text = strDrug.ToString();
                    }
                    if (strPhyActivity != string.Empty)
                    {
                        trPhysicial.Attributes.Add("style", "display:block");
                        trPhysicial1.Attributes.Add("style", "display:block");
                        lblPhyExHead.Visible = true;
                        lblPhyExHead.Text = strPhyActivity.ToString();
                    }
                    if (strAllergy == "")
                    {
                        tabAllergy1.Attributes.Add("style", "display:none");
                    }
                    if (strDrugAllAllergy != string.Empty)
                    {
                        lblAllergyTable.Text = sbTable.ToString();
                    }
                    if (strDrugAllergy != string.Empty)
                    {
                        lblDrugAllergy.Visible = true;
                        lblDrugAllergy.Text = strDrugAllergy.ToString();
                    }
                    if (strFamilyHistory == string.Empty)
                    {
                        lblFamily.Visible = false;
                    }
                    if (strFoodAllergy != string.Empty)
                    {
                    }
                    if (strInhalentsAllergy != string.Empty)
                    {
                    }
                    if (strContactAllergy != string.Empty)
                    {
                    }
                    if (strAllAllergy != string.Empty)
                    {
                    }
                }
                try
                {
                    if (lstSurgicalDetails.Count > 0)
                    {

                        for (int i = 0; i < lstSurgicalDetails.Count; i++)
                        {
                            hdnSurgeryHis.Value += lstSurgicalDetails[i].SurgeryID + "~" + lstSurgicalDetails[i].SurgeryName +"~"+lstSurgicalDetails[i].TreatmentPlanDate.ToString("dd/MM/yyyy")+  "~" + lstSurgicalDetails[i].HospitalName + "^";
                        }
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Surgery", "createFtab_new();", true);
                        lblSurgeryNil.Visible = false;
                        trSurgery.Attributes.Add("style", "display:block");
                        tblMedical1.Attributes.Add("style", "display:block");
                    }
                    else
                    {
                        trSurgery.Attributes.Add("style", "display:none");
                    }

                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                }
                if (lstPatientPrescription.Count > 0)
                {
                    lblDHNil.Visible = false;
                    lblDrugHistory_1063.Visible = true;
                    grdPrescription.DataSource = lstPatientPrescription;
                    grdPrescription.DataBind();
                }
                if (lstGPALDetails.Count > 0)
                {
                    lblObsHisNil.Visible = false;
                    trObstretic.Attributes.Add("Style", "display:block");
                    trObstretic1.Attributes.Add("Style", "display:block");
                    grdObsHistory.DataSource = lstGPALDetails;
                    grdObsHistory.DataBind();
                }
                if (lstANCPatientDetails.Count > 0)
                {

                }
                if (lstPPVH.Count > 0)
                {
                    LblVHNil.Visible = false;
                    LblVaccinationHistory_1064.Visible = true;
                    grdPPVH.DataSource = lstPPVH;
                    grdPPVH.DataBind();
                }

                if (lstANCPatientDetails.Count > 0)
                {
                    trGravida.Attributes.Add("Style", "display:block");
                    lblGravida.Visible = true;
                    lblG.Visible = true;
                    lblG.Text = Convert.ToString(lstANCPatientDetails[0].Gravida.ToString());

                    lblPara.Visible = true;
                    lblP.Visible = true;
                    lblP.Text = Convert.ToString(lstANCPatientDetails[0].Para.ToString());

                    lblLive.Visible = true;
                    lblL.Visible = true;
                    lblL.Text = Convert.ToString(lstANCPatientDetails[0].Live.ToString());

                    lblAbortus.Visible = true;
                    lblA.Visible = true;
                    lblA.Text = Convert.ToString(lstANCPatientDetails[0].Abortus.ToString());

                    lblGPLAOthers.Visible = true;
                    lblGPLAO.Visible = true;
                    lblGPLAO.Text = Convert.ToString(lstANCPatientDetails[0].GPLAOthers.ToString());
                }
                if (strTS != string.Empty || strAC != string.Empty || strDiet != string.Empty || strPhyActivity != string.Empty || strDrug != string.Empty || strBladder != string.Empty || strBowel != string.Empty)
                {
                    tblSocialHistory.Attributes.Add("style", "display:block");
                    tblSocialHistory1.Attributes.Add("style", "display:block");
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
            }
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
}
