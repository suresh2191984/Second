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

public partial class Patient_PrintHistory : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
        List<DrugDetails> lstPatientPrescription = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPPVH = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        if (!IsPostBack)
        {
            returnCode = new Patient_BL(base.ContextInfo).GetPatientHistoryPackage(visitID, out lstPatHisAttribute, out lstPatientPrescription, out lstGPALDetails, out lstANCPatientDetails, out lstPPVH, out lstPCA, out lstSurgicalDetails);

            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            Patient patient = new Patient();
            patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
            if (Request.QueryString["pSex"] != null)
            {

                if (Request.QueryString["pSex"] == "M")
                {

                    tblGynacHisH.Style.Add("display", "none");
                    tblGynacHisC.Style.Add("display", "none");
                }


            }

            #region Complaint & Surgery

            if (lstPCA.Count > 0)
            {
                for (int i = 0; i < lstPCA.Count(); i++)
                {
                    #region Systemic Hypertension

                    if (lstPCA[i].ComplaintID == 402)
                    {
                        lblShNill.Visible = false;
                        if (lstPCA[i].AttributeID == 1)
                        {
                            lblDurationShAI_1.Visible = true;
                            lblDurationShAVI_1.Visible = true;
                            lblDurationShAVI_1.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 2)
                        {
                            lblTreatmentShAI_2.Visible = true;
                            if (lstPCA[i].AttributevalueID == 4)
                            {
                                lblBetaBlockersShAVI_4.Visible = true;
                                lblBetaBlockersShAVI_4.Text = lstPCA[i].AttributeValueName + ",";
                            }
                            if (lstPCA[i].AttributevalueID == 5)
                            {
                                lblCCBShAVI_5.Visible = true;
                                lblCCBShAVI_5.Text = lstPCA[i].AttributeValueName + ",";
                            }
                            if (lstPCA[i].AttributevalueID == 6)
                            {
                                lblACEIARBShAVI_6.Visible = true;
                                lblACEIARBShAVI_6.Text = lstPCA[i].AttributeValueName + ",";
                            }
                            if (lstPCA[i].AttributevalueID == 7)
                            {
                                lblACEIARBdiureticShAVI_7.Visible = true;
                                lblACEIARBdiureticShAVI_7.Text = lstPCA[i].AttributeValueName + ",";
                            }
                            if (lstPCA[i].AttributevalueID == 8)
                            {
                                lblAlphaBlockersShAVI_8.Visible = true;
                                lblAlphaBlockersShAVI_8.Text = lstPCA[i].AttributeValueName + ",";
                            }
                            if (lstPCA[i].AttributevalueID == 9)
                            {
                                lblOthersShAVI_9.Visible = true;
                                lblOthersShAVI_9.Text = lstPCA[i].AttributeValueName + ",";
                            }
                        }
                    }
                    #endregion

                    #region Heart Disease
                    if (lstPCA[i].ComplaintID == 332)
                    {
                        lblHDNil.Visible = false;
                        if (lstPCA[i].AttributeID == 3)
                        {
                            lblDiseaseTypeHDAI_3.Visible = true;
                            lblDiseaseTypeHDAVI_3.Visible = true;
                            lblDiseaseTypeHDAVI_3.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 4)
                        {
                            lblDiseaseHDAI_4.Visible = true;
                            lblDiseaseHDAVI_4.Visible = true;
                            lblDiseaseHDAVI_4.Text = lstPCA[i].AttributeValueName;
                        }

                    }
                    #endregion

                    #region Diabetes Mellitus
                    if (lstPCA[i].ComplaintID == 389)
                    {
                        lblDMNil.Visible = false;
                        if (lstPCA[i].AttributeID == 5)
                        {
                            lblDurationDMAI_5.Visible = true;
                            lblDurationDMAVI_5.Visible = true;
                            lblDurationDMAVI_5.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 6)
                        {
                            lblTypeDHAI_6.Visible = true;
                            lblTypeDHAVI_6.Visible = true;
                            lblTypeDHAVI_6.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 7)
                        {
                            lblTreatmentDHAI_7.Visible = true;
                            lblTreatmentDHAVI_7.Visible = true;
                            lblTreatmentDHAVI_7.Text = lstPCA[i].AttributeValueName;
                        }

                    }
                    #endregion

                    #region Stroke
                    if (lstPCA[i].ComplaintID == 438)
                    {
                        lblS_438.Visible = false;
                        if (lstPCA[i].AttributeID == 8)
                        {
                            lblDateSAI_8.Visible = true;
                            lblDateSAVI_8.Visible = true;
                            lblDateSAVI_8.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 9)
                        {
                            lblRecoverySAI_9.Visible = true;
                            lblRecoverySAVI_9.Visible = true;
                            lblRecoverySAVI_9.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 10)
                        {
                            lblTypeOfCVASAI_10.Visible = true;
                            lblTypeOfCVASAVI_10.Visible = true;
                            lblTypeOfCVASAVI_10.Text = lstPCA[i].AttributeValueName;
                        }

                        if (lstPCA[i].AttributeID == 11)
                        {
                            lblAreaLobeaffectedSAI_11.Visible = true;
                            lblAreaLobeaffectedSAVI_11.Visible = true;
                            lblAreaLobeaffectedSAVI_11.Text = lstPCA[i].AttributeValueName;
                        }

                    }
                    #endregion

                    #region Dyslipidemia
                    if (lstPCA[i].ComplaintID == 409)
                    {
                        lblNil_409.Visible = false;
                        if (lstPCA[i].AttributeID == 12)
                        {
                            lblDurationDLAI_12.Visible = true;
                            lblDurationDLAVI_12.Visible = true;
                            lblDurationDLAVI_12.Text = lstPCA[i].AttributeValueName;
                        }


                    }
                    #endregion

                    #region Cancer
                    if (lstPCA[i].ComplaintID == 372)
                    {
                        lblnil_372.Visible = false;
                        if (lstPCA[i].AttributeID == 13)
                        {
                            lblSOCCAI_13.Visible = true;
                            lblSOCCAVI_13.Visible = true;
                            lblSOCCAVI_13.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 14)
                        {
                            lblSOCCAI_14.Visible = true;
                            lblSOCCAVI_14.Visible = true;
                            lblSOCCAVI_14.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 15)
                        {
                            lblSOCCAI_15.Visible = true;
                            lblSOCCAVI_15.Visible = true;
                            lblSOCCAVI_15.Text = lstPCA[i].AttributeValueName;
                        }


                    }
                    #endregion

                    #region Asthma
                    if (lstPCA[i].ComplaintID == 246)
                    {
                        lblNil_246.Visible = false;
                        if (lstPCA[i].AttributeID == 16)
                        {
                            lblDurationAAI_16.Visible = true;
                            lblDurationAAVI_16.Visible = true;
                            lblDurationAAVI_16.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 17)
                        {
                            lblTreatmentAAI_17.Visible = true;
                            lblTreatmentAAVI_17.Visible = true;
                            lblTreatmentAAVI_17.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 18)
                        {
                            lblExacerbationsAAI_18.Visible = true;
                            lblExacerbationsAAVI_18.Visible = true;
                            lblExacerbationsAAVI_18.Text = lstPCA[i].AttributeValueName;
                        }


                    }
                    #endregion

                    #region Thalassemia Trait

                    if (lstPCA[i].ComplaintID == 536)
                    {
                        lblNil_536.Visible = false;
                        if (lstPCA[i].AttributeID == 19)
                        {
                            lblTraitTTAI_19.Visible = true;
                            lblTraitAVI_19.Visible = true;
                            lblTraitAVI_19.Text = lstPCA[i].AttributeValueName;
                        }


                    }

                    #endregion

                    #region Hepatitis B Carrier
                    if (lstPCA[i].ComplaintID == 537)
                    {
                        lblNil_537.Visible = false;
                        if (lstPCA[i].AttributeID == 20)
                        {
                            lblDurationHBCAI_20.Visible = true;
                            lblDurationHBCAVI_20.Visible = true;
                            lblDurationHBCAVI_20.Text = lstPCA[i].AttributeValueName;
                        }
                        if (lstPCA[i].AttributeID == 21)
                        {
                            lblTreatmentHBCAI_21.Visible = true;
                            lblTreatmentHBCAVI_21.Visible = true;
                            lblTreatmentHBCAVI_21.Text = lstPCA[i].AttributeValueName;
                        }


                    }
                    #endregion

                    if (lstSurgicalDetails.Count > 0)
                    {
                        lblSurgeryNil.Visible = false;
                        grdSurgery.DataSource = lstSurgicalDetails;
                        grdSurgery.DataBind();
                    }



                }
            }

            #endregion

            #region Histories

            if (lstPatHisAttribute.Count > 0)
            {
                for (int i = 0; i < lstPatHisAttribute.Count(); i++)
                {
                    PatientHistoryAttribute PHA = new PatientHistoryAttribute();

                    #region TobaccoSmoking

                    if (lstPatHisAttribute[i].HistoryID == 476)
                    {
                        lblTSNil.Visible = false;
                        if (lstPatHisAttribute[i].AttributeID == 1)
                        {
                            lblCCB.Visible = true;
                            lblTypeTS_1.Visible = true;
                            lblCCB.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 2)
                        {
                            lblDurationTSAV_2.Visible = true;
                            lblDurationTSAVI_5.Visible = true;
                            lblDurationTSAVI_5.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 3)
                        {
                            lblPacksTSAV_3.Visible = true;
                            lblPacksTS.Visible = true;
                            lblPacksTS.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region Alcohol Consumption

                    if (lstPatHisAttribute[i].HistoryID == 369)
                    {
                        lblACNil.Visible = false;
                        if (lstPatHisAttribute[i].AttributeID == 4)
                        {
                            lblTypeAC_4.Visible = true;
                            lblTypeAC.Visible = true;
                            lblTypeAC.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 5)
                        {
                            lblDurationACAV_5.Visible = true;
                            lblDurationACAVI_13.Visible = true;
                            lblDurationACAVI_13.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 6)
                        {
                            lblQTYAC_6.Visible = true;
                            lblACQty.Visible = true;
                            lblACQty.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region Physicial Activity

                    if (lstPatHisAttribute[i].HistoryID == 1059)
                    {
                        lblPhyActNil.Visible = false;
                        if (lstPatHisAttribute[i].AttributeID == 7)
                        {
                            lblPhyExHead.Visible = true;
                            lblPhyExcersice_7.Visible = true;
                            lblPhyExcersice_7.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 8)
                        {
                            trPhyExeOccasional.Attributes.Add("display", "block");
                            lblAerobic_8.Visible = true;
                            lblAerobicText.Visible = true;
                            lblAerobicText.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 9)
                        {
                            trPhyExeOccasional.Attributes.Add("display", "block");
                            lblAnAerobic_9.Visible = true;
                            lblAnAerobicText.Visible = true;
                            lblAnAerobicText.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributevalueID == 67)
                        {
                            trPhyExeOccasional.Attributes.Add("display", "block");
                            lblPhyExeDuration_10.Visible = true;
                            lblPhyExeDuration.Visible = true;
                            lblPhyExeDuration.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region Drug Allergy
                    lblDrugAllergyValue.Text = "";
                    if (lstPatHisAttribute[i].HistoryID == 1061)
                    {
                        lblAllergicHis.Visible = true;
                        if (lstPatHisAttribute[i].AttributeID == 11)
                        {                            
                            lblDrugAllergy.Visible = true;
                            lblDrugAllergyValue.Visible = true;
                            lblDrugAllergyValue.Text += lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region Food Allergy

                    if (lstPatHisAttribute[i].HistoryID == 1062)
                    {
                        lblAllergicHis.Visible = true;
                        if (lstPatHisAttribute[i].AttributeID == 12)
                        {
                            lblFoodStuff.Visible = true;
                            lblFoodStuffValue.Visible = true;
                            lblFoodStuffValue.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region Gyanac History

                    if (lstPatHisAttribute[i].HistoryID == 1065)
                    {
                        LblGHNil.Visible = false;
                        if (lstPatHisAttribute[i].AttributeID == 13)
                        {
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
                            lblCycleLength_15.Visible = true;
                            lblCycleLength_45.Visible = true;
                            lblCyclelengthDays.Visible = true;
                            lblCycleLength_45.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 16)
                        {
                            lblLastPapSmear.Visible = true;
                            lblLastPapSmear_46.Visible = true;
                            //lblLastPapSmear_46.Visible = true;
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
                            lblLastMamogram_20.Visible = true;
                            lblLastMamogram.Visible = true;
                            lblLastMamogram.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                        if (lstPatHisAttribute[i].AttributeID == 21)
                        {
                            lblLastMamogramResult_21.Visible = true;
                            lblLastMamogramResult.Visible = true;
                            lblLastMamogramResult.Text = lstPatHisAttribute[i].AttributeValueName;
                        }
                    }

                    #endregion

                    #region HRT

                    if (lstPatHisAttribute[i].HistoryID == 1066)
                    {
                        LblHRTil0.Visible = false;
                        if (lstPatHisAttribute[i].AttributeID == 22)
                        {
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
            }
            if (lstPatientPrescription.Count > 0)
            {
                lblDHNil.Visible = false;
                grdPrescription.DataSource = lstPatientPrescription;
                grdPrescription.DataBind();
            }
            if (lstGPALDetails.Count > 0)
            {
                lblObsHisNil.Visible = false;
                grdObsHistory.DataSource = lstGPALDetails;
                grdObsHistory.DataBind();
            }
            if (lstANCPatientDetails.Count > 0)
            {

            }
            if (lstPPVH.Count > 0)
            {
                LblVHNil.Visible = false;
                grdPPVH.DataSource = lstPPVH;
                grdPPVH.DataBind();
            }

            if (lstANCPatientDetails.Count > 0)
            {
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

            #endregion
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Patient/PatientHistoryPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "HIS", true);
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
    protected void btnEditHis_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientHistoryPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "HIS", true);
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
}
