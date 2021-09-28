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
using Attune.Podium.SmartAccessor;

public partial class Patient_PrintExamination : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    string strExam = string.Empty;
    List<PatientExaminationAttribute> lstPEA= new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    string Abnormalities = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        long returnCode = -1;
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin,out lstExam,out lstAttribute);
        if (lstPEA.Count > 0)
        {
            for (int i = 0; i < lstPEA.Count(); i++)
            {
                #region Skin

                if (lstPEA[i].ExaminationID == 928)
                {
                    lblSKNil.Visible = false;
                    if (lstPEA[i].AttributeID == 1)
                    {
                        lblSkinTypeSKAI_1.Visible = true;
                        lblSkinTypeSKAVI_1.Visible = true;
                        lblSkinTypeSKAVI_1.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 2)
                    {
                        lblSkinLesionsSKAI_2.Visible = true;
                        lblSkinLesionsSKAVI_2.Visible = true;
                        lblSkinLesionsSKAVI_2.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Hair

                if (lstPEA[i].ExaminationID == 915)
                {
                    lblHRNil.Visible = false;
                    if (lstPEA[i].AttributeID == 3)
                    {
                        lblHairTypeHRAI_3.Visible = true;
                        lblHairTypeHRAVI_3.Visible = true;
                        lblHairTypeHRAVI_3.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                }

                #endregion

                #region Nails

                if (lstPEA[i].ExaminationID == 916)
                {
                    lblNNil.Visible = false;
                    if (lstPEA[i].AttributeID == 4)
                    {
                        lblNailsTypeNAI_4.Visible = true;
                        lblNailsTypeNAVI_4.Visible = true;
                        lblNailsTypeNAVI_4.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 5)
                    {
                        lblNailsDescriptionNAI_5.Visible = true;
                        lblNailsDescriptionNAVI_5.Visible = true;
                        lblNailsDescriptionNAVI_5.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Nails

                if (lstPEA[i].ExaminationID == 917)
                {
                    lblSRNil.Visible = false;
                    if (lstPEA[i].AttributeID == 6)
                    {
                        lblScarTypeSRAI_6.Visible = true;
                        lblScarTypeSRAVI_6.Visible = true;
                        lblScarTypeSRAVI_6.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 7)
                    {
                        lblScaretiologySRAI_7.Visible = true;
                        lblScaretiologySRAVI_7.Visible = true;
                        lblScaretiologySRAVI_7.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 8)
                    {
                        lblScarLocationSRAI_8.Visible = true;
                        lblScarLocationSRAVI_8.Visible = true;
                        lblScarLocationSRAVI_8.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Ear

                #region Auditory Canal
                if (lstPEA[i].ExaminationID == 872)
                {
                    lblACNil.Visible = false;
                    if (lstPEA[i].AttributeID == 35)
                    {
                        lblRightEarACAI_35.Visible = true;
                        lblRightEarACAVI_35.Visible = true;
                        lblRightEarACAVI_35.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 36)
                    {
                        lblLeftEarACAI_36.Visible = true;
                        lblLeftEarACAVI_36.Visible = true;
                        lblLeftEarACAVI_36.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #region Ear Drum
                if (lstPEA[i].ExaminationID == 873)
                {
                    lblEDNil.Visible = false;
                    if (lstPEA[i].AttributeID == 37)
                    {
                        lblRightEarEDAI_37.Visible = true;
                        lblRightEarEDAVI_37.Visible = true;
                        lblRightEarEDAVI_37.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 38)
                    {
                        lblLeftEarEDAI_38.Visible = true;
                        lblLeftEarEDAVI_38.Visible = true;
                        lblLeftEarEDAVI_38.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #endregion

                #region Neck

                #region Thyroid Gland
                if (lstPEA[i].ExaminationID == 875)
                {
                    lblTHYNil.Visible = false;
                    if (lstPEA[i].AttributeID == 39)
                    {
                        lblTypeTHYAI_39.Visible = true;
                        lblTypeTTHYAVI_39.Visible = true;
                        lblTypeTTHYAVI_39.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 40)
                    {
                        lblAbnormalitiesTHYAI_40.Visible = true;
                        lblAbnormalitiesTHYAVI_40.Visible = true;
                        lblAbnormalitiesTHYAVI_40.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                 #endregion

                #region Lymph Nodes
                if (lstPEA[i].ExaminationID == 876)
                {
                    lblLNNil.Visible = false;
                    if (lstPEA[i].AttributeID == 41)
                    {
                        ddlTypeLNAI_41.Visible = true;
                        ddlTypeLNAVI_41.Visible = true;
                        ddlTypeLNAVI_41.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 42)
                    {
                        lblLocationLNAI_42.Visible = true;
                        lblLocationLNAVI_42.Visible = true;
                        lblLocationLNAVI_42.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion


                #endregion

                #region Respiratory System

                #region Trachea
                if (lstPEA[i].ExaminationID == 878)
                {
                    lblTRANil.Visible = false;
                    if (lstPEA[i].AttributeID == 43)
                    {
                        lblTypeTRAAI_43.Visible = true;
                        lblTypeTRAAVI_43.Visible = true;
                        lblTypeTRAAVI_43.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 44)
                    {
                       
                        lblPostTracheostomy_156.Visible = true;
                        lblPostTracheostomy_156.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #region Breath Sounds
                if (lstPEA[i].ExaminationID == 879)
                {
                    lblBSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 45)
                    {
                        ddlTypeBSAI_45.Visible = true;
                        ddlTypeBSAVI_45.Visible = true;
                        ddlTypeBSAVI_45.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 46)
                    {
                        lblAbnormalitiesBSAI_46.Visible = true;
                        lblAbnormalitiesBSAVI_46.Visible = true;
                        lblAbnormalitiesBSAVI_46.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #endregion

                #region Eye

                #region Distant Vision
                if (lstPEA[i].ExaminationID == 919)
                {
                    lblDVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 9)
                    {
                        ddlTypeDVAI_9.Visible = true;
                        ddlTypeDVAVI_9  .Visible = true;
                        ddlTypeDVAVI_9.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 10)
                    {
                        lblRightEyeDVAI_10.Visible = true;
                        lblRightEyeDVAVI_10.Visible = true;
                        lblRightEyeDVAVI_10.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 97)
                    {
                        lblLeftEyeDVAI_97.Visible = true;
                        lblLeftEyeDVAVI_97.Visible = true;
                        lblLeftEyeDVAVI_97.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region Near Vision
                if (lstPEA[i].ExaminationID == 920)
                {
                    lblNVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 11)
                    {
                        lblTypeNVAI_11.Visible = true;
                        lblTypeNVAVI_11.Visible = true;
                        lblTypeNVAVI_11.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 12)
                    {
                        lblRightEyeNVAI_12.Visible = true;
                        lblRightEyeNVAVI_12.Visible = true;
                        lblRightEyeNVAVI_12.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 99)
                    {
                        lblLeftEyeNVAI_99.Visible = true;
                        lblLeftEyeNVAVI_99.Visible = true;
                        lblLeftEyeNVAVI_99.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region Color Vision
                if (lstPEA[i].ExaminationID == 921)
                {
                    lblCVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 13)
                    {
                        lblTypeCVAI_13.Visible = true;
                        lblTypeCVAVI_13.Visible = true;
                        lblTypeCVAVI_13.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 14)
                    {
                        lblDescriptionCVAI_14.Visible = true;
                        lblDescriptionCVAVI_14.Visible = true;
                        lblDescriptionCVAVI_14.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region IOL Present
                if (lstPEA[i].ExaminationID == 922)
                {
                    lblIOLNil.Visible = false;
                    if (lstPEA[i].AttributeID == 15)
                    {
                        lblEyesIOLAI_15.Visible = true;
                        lblEyesIOLAVI_15.Visible = true;
                        lblEyesIOLAVI_15.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                }
                #endregion
                #region Pterygium
                if (lstPEA[i].ExaminationID == 923)
                {
                    lblPGNil.Visible = false;
                    if (lstPEA[i].AttributeID == 16)
                    {
                        lblTypePGAI_16.Visible = true;
                        lblTypePGAVI_16.Visible = true;
                        lblTypePGAVI_16.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 17)
                    {
                        lblDescriptionPGAI_17.Visible = true;
                        lblDescriptionPGAVI_17.Visible = true;
                        lblDescriptionPGAVI_17.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region Xanthelasma
                if (lstPEA[i].ExaminationID == 924)
                {
                    lblXNil.Visible = false;
                    if (lstPEA[i].AttributeID == 18)
                    {
                        lblTypeXAI_18.Visible = true;
                        lblTypeXAVI_18.Visible = true;
                        lblTypeXAVI_18.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 19)
                    {
                        lblAssociatedConditionsXAI_19.Visible = true;
                        lblAssociatedConditionsXAVI_19.Visible = true;
                        lblAssociatedConditionsXAVI_19.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region Eye Movements
                if (lstPEA[i].ExaminationID == 925)
                {
                    lblEMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 20)
                    {
                        lblTypeEMAI_20.Visible = true;
                        lblTypeEMAVI_20.Visible = true;
                        lblTypeEMAVI_20.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 21)
                    {
                        lblAbnormalityEMAI_21.Visible = true;
                        lblAbnormalityEMAVI_21.Visible = true;
                        lblAbnormalityEMAVI_21.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion
                #region Pupils
                if (lstPEA[i].ExaminationID == 926)
                {
                    lblPPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 23)
                    {
                        lblSizePAI_22.Visible = true;
                        lblRightEyePAI_23.Visible = true;
                        lblRightEyePAVI_23.Visible = true;
                        lblRightEyePAVI_23.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 24)
                    {
                        lblSizePAI_22.Visible = true;
                        lblLeftEyePAI_24.Visible = true;
                        lblLeftEyePAVI_24.Visible = true;
                        lblLeftEyePAVI_24.Text = lstPEA[i].AttributeValueName;
                    }


                    if (lstPEA[i].AttributeID == 26)
                    {
                        lblShapePAI_25.Visible = true;
                        lblRightEyePAI_26.Visible = true;
                        lblRightEyePAVI_26.Visible = true;
                        lblRightEyePAVI_26.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 27)
                    {
                        lblShapePAI_25.Visible = true;
                        lblLeftEyePAI_27.Visible = true;
                        lblLeftEyePAVI_27.Visible = true;
                        lblLeftEyePAVI_27.Text = lstPEA[i].AttributeValueName;
                    }


                    if (lstPEA[i].AttributeID == 29)
                    {
                        lblReactiontoLight_28.Visible = true;
                        lblRightEyePAI_29.Visible = true;
                        lblRightEyePAVI_29.Visible = true;
                        lblRightEyePAVI_29.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 30)
                    {
                        lblReactiontoLight_28.Visible = true;
                        lblLeftEyePAI_30.Visible = true;
                        lblLeftEyePAVI_30.Visible = true;
                        lblLeftEyePAVI_30.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 31)
                    {
                        lblAbnormalitiesPAI_31.Visible = true;
                        lblAbnormalitiesPAVI_31.Visible = true;
                        lblAbnormalitiesPAVI_31.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 32)
                    {

                        lblDescriptionPAI_32.Visible = true;
                        lblDescriptionPAVI_32.Visible = true;
                        lblDescriptionPAVI_32.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }
                #endregion
                #region Tonometry
                if (lstPEA[i].ExaminationID == 927)
                {
                    lblIOPNil.Visible = true;
                    if (lstPEA[i].AttributeID == 33)
                    {
                        lblIOPTAI_33.Visible = true;
                        lblRightIOPTAI_33.Visible = true;
                        lblRightIOPTAVI_33.Visible = true;
                        lblRightIOPTAVI_33.Text = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 34)
                    {
                        lblIOPTAI_33.Visible = true;
                        lblLeftIOPTAI_34.Visible = true;
                        lblLeftIOPTAVI_34.Visible = true;
                        lblLeftIOPTAVI_34.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #endregion

                #region ORAL CAVITY


                #region General Appearance
                if (lstPEA[i].ExaminationID == 895)
                {
                    lblGENill.Visible = false;
                    if (lstPEA[i].AttributeID == 66)
                    {
                        lblTypeGEAI_66.Visible = true;
                        lblTypeGEAVI_66.Visible = true;
                        lblTypeGEAVI_66.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }
                #endregion

                #region Teeth

                if (lstPEA[i].ExaminationID == 896)
                {
                    lblTHNil.Visible = false;
                    if (lstPEA[i].AttributeID == 67)
                    {
                        lblTypeTHAI_67.Visible = true;
                        lblTypeTHAVI_67.Visible = true;
                        lblTypeTHAVI_67.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 68)
                    {
                        lblAbnormalitiesTHAI_68.Visible = true;
                        lblAbnormalitiesTHAVI_68.Visible = true;
                        lblAbnormalitiesTHAVI_68.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion

                #region Tongue

                if (lstPEA[i].ExaminationID == 897)
                {
                    lblTGNil.Visible = false;
                    if (lstPEA[i].AttributeID == 69)
                    {
                        lblTypeTGAI_69.Visible = true;
                        lblTypeTGAVI_69.Visible = true;
                        lblTypeTGAVI_69.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 70)
                    {
                        lblAbnormalitiesTGAI_70.Visible = true;
                        lblAbnormalitiesTGAVI_70.Visible = true;
                        lblAbnormalitiesTGAVI_70.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Tonsils

                if (lstPEA[i].ExaminationID == 898)
                {
                    lblTSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 71)
                    {
                        lblTypeTSAI_71.Visible = true;
                        lblTypeTSAVI_71.Visible = true;
                        lblTypeTSAVI_71.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 72)
                    {
                        lblAbnormalitiesTSAI_72.Visible = true;
                        lblAbnormalitiesTSAVI_72.Visible = true;
                        lblAbnormalitiesTSAVI_72.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }


                #endregion

                #region Pharynx

                if (lstPEA[i].ExaminationID == 899)
                {
                    lblPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 73)
                    {
                        lblTypePAI_73.Visible = true;
                        lblTypePAVI_73.Visible = true;
                        lblTypePAVI_73.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 74)
                    {
                        lblAbnormalitiesPAI_74.Visible = true;
                        lblAbnormalitiesPAVI_74.Visible = true;
                        lblAbnormalitiesPAVI_74.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion


                #endregion

                #region NEUROLOGICAL EXAMINATION

                #region Cranial Nerves
                if (lstPEA[i].ExaminationID == 901)
                {
                    lblCNNil.Visible = false;
                    if (lstPEA[i].AttributeID == 75)
                    {
                        lblTypeCNAI_75.Visible = true;
                        lblTypeCNAVI_75.Visible = true;
                        lblTypeCNAVI_75.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 76)
                    {
                       
                        if (Abnormalities == string.Empty)
                        {
                            Abnormalities = lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Abnormalities += ","+lstPEA[i].AttributeValueName;
                        }
                        lblAbnormalitiesCNAI_76.Visible = true;
                        lblAbnormalitiesCNAVI_76.Visible = true;
                        lblAbnormalitiesCNAVI_76.Text = Abnormalities+".";
                    }

                    strExam = "Examination";

                }
                #endregion

                #region Sensory System

                if (lstPEA[i].ExaminationID == 902)
                {
                    lblSSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 77)
                    {
                        lblTypeSSAI_77.Visible = true;
                        lblTypeSSAVI_77.Visible = true;
                        lblTypeSSAVI_77.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 78)
                    {
                        lblAbnormalitiesSSAI_78.Visible = true;
                        lblAbnormalitiesSSAVI_78.Visible = true;
                        lblAbnormalitiesSSAVI_78.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion

                #region Reflexes

                if (lstPEA[i].ExaminationID == 903)
                {
                    lblRFNil.Visible = false;
                    if (lstPEA[i].AttributeID == 79)
                    {
                        lblTypeRFAI_79.Visible = true;
                        lblTypeRFAVI_79.Visible = true;
                        lblTypeRFAVI_79.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 80)
                    {
                        lblAbnormalitiesRFAI_80.Visible = true;
                        lblAbnormalitiesRFAVI_80.Visible = true;
                        lblAbnormalitiesRFAVI_80.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Motor System

                if (lstPEA[i].ExaminationID == 904)
                {
                    lblMSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 81)
                    {
                        lblTypeMSAI_81.Visible = true;
                        lblTypeMSAVI_81.Visible = true;
                        lblTypeMSAVI_81.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 82)
                    {
                        lblAbnormalitiesMSAI_82.Visible = true;
                        lblAbnormalitiesMSAVI_82.Visible = true;
                        lblAbnormalitiesMSAVI_82.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }


                #endregion

                #region Musculo Skeletal System

                if (lstPEA[i].ExaminationID == 905)
                {
                    lblMSSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 83)
                    {
                        lblTypeMSSAI_83.Visible = true;
                        lblTypeMSSAVI_83.Visible = true;
                        lblTypeMSSAVI_83.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 84)
                    {
                        lblAbnormalitiesMSSAI_84.Visible = true;
                        lblAbnormalitiesMSSAVI_84.Visible = true;
                        lblAbnormalitiesMSSAVI_84.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion

                #region Gait

                if (lstPEA[i].ExaminationID == 906)
                {
                    lblGTNil.Visible = false;
                    if (lstPEA[i].AttributeID == 85)
                    {
                        lblTypeGTAI_85.Visible = true;
                        lblTypeGTAVI_85.Visible = true;
                        lblTypeGTAVI_85.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 86)
                    {
                        lblAbnormalitiesGTAI_86.Visible = true;
                        lblAbnormalitiesGTAVI_86.Visible = true;
                        lblAbnormalitiesGTAVI_86.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion


                #endregion

                #region GYNAECOLOGICAL EXAMINATION

                #region Breasts

                if (lstPEA[i].ExaminationID == 908)
                {
                    lblBNil.Visible = false;
                    if (lstPEA[i].AttributeID == 87)
                    {
                        lblTypeBAI_87.Visible = true;
                        lblTypeBAVI_87.Visible = true;
                        lblTypeBAVI_87.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 88)
                    {
                        lblAbnormalitiesBAI_88.Visible = true;
                        lblAbnormalitiesBAVI_88.Visible = true;
                        lblAbnormalitiesBAVI_88.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                }

                #endregion

                #region Uterus

                if (lstPEA[i].ExaminationID == 909)
                {
                    lblUNil.Visible = false;
                    if (lstPEA[i].AttributeID == 89)
                    {
                        lblTypeUAI_89.Visible = true;
                        lblTypeUAVI_89.Visible = true;
                        lblTypeUAVI_89.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 90)
                    {
                        lblAbnormalitiesUAI_90.Visible = true;
                        lblAbnormalitiesUAVI_90.Visible = true;
                        lblAbnormalitiesUAVI_90.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion

                #region External Genetaila

                if (lstPEA[i].ExaminationID == 910)
                {
                    lblEGNil.Visible = false;
                    if (lstPEA[i].AttributeID == 91)
                    {
                        lblTypeEGAI_91.Visible = true;
                        lblTypeEGAVI_91.Visible = true;
                        lblTypeEGAVI_91.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 92)
                    {
                        lblAbnormalitiesEGAI_92.Visible = true;
                        lblAbnormalitiesEGAVI_92.Visible = true;
                        lblAbnormalitiesEGAVI_92.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion


                #endregion

                #region RECTAL EXAMINATION

                #region Rectum

                if (lstPEA[i].ExaminationID == 912)
                {
                    lblRTMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 93)
                    {
                        lblTypeRTMAI_93.Visible = true;
                        lblTypeRTMAVI_93.Visible = true;
                        lblTypeRTMAVI_93.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 94)
                    {
                        lblAbnormalitiesRTMAI_94.Visible = true;
                        lblAbnormalitiesRTMAVI_94.Visible = true;
                        lblAbnormalitiesRTMAVI_94.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion

                #region Prostate

                if (lstPEA[i].ExaminationID == 913)
                {
                    lblPRTNil.Visible = false;
                    if (lstPEA[i].AttributeID == 95)
                    {
                        lblTypePRTAI_95.Visible = true;
                        lblTypePRTAVI_95.Visible = true;
                        lblTypePRTAVI_95.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 96)
                    {
                        lblAbnormalitiesPRTAI_96.Visible = true;
                        lblAbnormalitiesPRTAVI_96.Visible = true;
                        lblAbnormalitiesPRTAVI_96.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion    


                #endregion

                #region CARDIOVASCULAR EXAMINATION

                #region Pulse Rhythm
                if (lstPEA[i].ExaminationID == 881)
                {
                    lblPRTMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 47)
                    {
                        lblFindingsPRTMAI_47.Visible = true;
                        lblFindingsPRTMAVI_47.Visible = true;
                        lblFindingsPRTMAVI_47.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }
                #endregion

                #region Pulse Volume
                if (lstPEA[i].ExaminationID == 882)
                {
                    lblPVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 48)
                    {
                        lblFindingsPVAI_48.Visible = true;
                        lblFindingsPVAVI_48.Visible = true;
                        lblFindingsPVAVI_48.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                }
              
                #endregion

                #region Pulse Character
                if (lstPEA[i].ExaminationID == 883)
                {
                    lblPCNil.Visible = false;
                    if (lstPEA[i].AttributeID == 49)
                    {
                        lblFindingsPCAI_49.Visible = true;
                        lblFindingsPCAVI_49.Visible = true;
                        lblFindingsPCAVI_49.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }
                #endregion

                #region Peripheral Pulses

                if (lstPEA[i].ExaminationID == 884)
                {
                    lblPEPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 50)
                    {
                        lblFindingsSignsPEPAI_50.Visible = true;
                        lblFindingsSignsPEPAVI_50.Visible = true;
                        lblFindingsSignsPEPAVI_50.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 51)
                    {
                        lblLocationPEPAI_51.Visible = true;
                        lblLocationPEPAVI_51.Visible = true;
                        lblLocationPEPAVI_51.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Apex Beat

                if (lstPEA[i].ExaminationID == 885)
                {
                    lblABNil.Visible = false;
                    if (lstPEA[i].AttributeID == 52)
                    {
                        lblFindingsABAI_52.Visible = true;
                        lblFindingsABAVI_52.Visible = true;
                        lblFindingsABAVI_52.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 53)
                    {
                        lblTypesofabnormalitiessABAI_53.Visible = true;
                        lblTypesofabnormalitiessABAVI_53.Visible = true;
                        lblTypesofabnormalitiessABAVI_53.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Heart Sounds

                if (lstPEA[i].ExaminationID == 886)
                {
                    lblHSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 54)
                    {
                        lblFindingsHSAI_54.Visible = true;
                        lblFindingsHSAVI_54.Visible = true;
                        lblFindingsHSAVI_54.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 55)
                    {
                        lblTypesofabnormalitiessHSAI_55.Visible = true;
                        lblTypesofabnormalitiessHSAVI_55.Visible = true;
                        lblTypesofabnormalitiessHSAVI_55.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }


                #endregion

                #region Heart Mummurs

                if (lstPEA[i].ExaminationID == 887)
                {
                    lblHMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 56)
                    {
                        lblFindingsHMAI_56.Visible = true;
                        lblFindingsHMAVI_56.Visible = true;
                        lblFindingsHMAVI_56.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 57)
                    {
                        lblTypesofabnormalitiessHMAI_57.Visible = true;
                        lblTypesofabnormalitiessHMAVI_57.Visible = true;
                        lblTypesofabnormalitiessHMAVI_57.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion


                #endregion

                #region ABDOMINAL EXAMINATION

                #region Abdominal Inspection
                if (lstPEA[i].ExaminationID == 889)
                {
                    lblAINil.Visible = false;
                    if (lstPEA[i].AttributeID == 58)
                    {
                        lblInspectionAIAI_58.Visible = true;
                        lblInspectionAIAVI_58.Visible = true;
                        lblInspectionAIAVI_58.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }
                #endregion

                #region Abdominal Palpation
                if (lstPEA[i].ExaminationID == 890)
                {
                    lblAPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 59)
                    {
                        lblPalpationAPAI_59.Visible = true;
                        lblPalpationAPAVI_59.Visible = true;
                        lblPalpationAPAVI_59.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";

                }

                #endregion    

                #region Liver

                if (lstPEA[i].ExaminationID == 891)
                {
                    lblLINil.Visible = false;
                    if (lstPEA[i].AttributeID == 60)
                    {
                        lblTypeLIAI_60.Visible = true;
                        lblTypeLIAVI_60.Visible = true;
                        lblTypeLIAVI_60.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 61)
                    {
                        lblDescriptionLIAI_61.Visible = true;
                        lblDescriptionLIAVI_61.Visible = true;
                        lblDescriptionLIAVI_61.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Spleen

                if (lstPEA[i].ExaminationID == 892)
                {
                    lblSPLNil.Visible = false;
                    if (lstPEA[i].AttributeID == 62)
                    {
                        lblTypeSPLAI_62.Visible = true;
                        lblTypeSPLAVI_62.Visible = true;
                        lblTypeSPLAVI_62.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 63)
                    {
                        lblDescriptionSPLAI_63.Visible = true;
                        lblDescriptionSPLAVI_63.Visible = true;
                        lblDescriptionSPLAVI_63.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }

                #endregion

                #region Kidneys

                if (lstPEA[i].ExaminationID == 893)
                {
                    lblKDNil.Visible = false;
                    if (lstPEA[i].AttributeID == 64)
                    {
                        lblTypeKDAI_64.Visible = true;
                        lblTypeKDAVI_64.Visible = true;
                        lblTypeKDAVI_64.Text = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 65)
                    {
                        lblDescriptionKDAI_65.Visible = true;
                        lblDescriptionKDAVI_65.Visible = true;
                        lblDescriptionKDAVI_65.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                
                #endregion

                #region Other Findings

                if (lstPEA[i].ExaminationID == 914)
                {
                    lblOFNil.Visible = false;
                    if (lstPEA[i].AttributeID == 98)
                    {
                      
                        lblOtherFindings_98.Visible = true;
                        lblOtherFindings_98.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                }
                #endregion


                #endregion              

            }
        }


        #region Vitals
        var listV = from lstV in lstVitalsUOMJoin
                   where lstV.VitalsValue > 0
                   select lstV;


        if (listV.Count() > 0)
        {
            lblVitalsNil.Visible = false;
            trAdmissionVitals.Style.Add("display", "block");

            string Vitalsname = string.Empty;
            string Vitalsvalue = string.Empty;
            string Vitalsunit = string.Empty;

            foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
            {
                if (Vitalsname == string.Empty)
                {
                    Vitalsname = oVitalsUOMJoin.VitalsName;
                }
                else
                {
                    Vitalsname += "," + oVitalsUOMJoin.VitalsName;
                }
                if (Vitalsvalue == string.Empty)
                {
                    Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
                }
                else
                {
                    Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
                }
                if (Vitalsunit == string.Empty)
                {
                    Vitalsunit = oVitalsUOMJoin.UOMCode;
                }
                else
                {
                    Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
                }
            }

            string[] resVitalsname = Vitalsname.Split(',');
            string[] resVitalsvalue = Vitalsvalue.Split(',');
            string[] resVitalsunit = Vitalsunit.Split(',');



            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            TableCell cellH6 = new TableCell();
            TableCell cellH7 = new TableCell();
            TableCell cellH8 = new TableCell();
            cellH1.Attributes.Add("align", "left");
            cellH1.Text = resVitalsname[0];
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = resVitalsname[1];
            cellH3.Attributes.Add("align", "left");
            cellH3.Text = resVitalsname[2];
            cellH4.Attributes.Add("align", "left");
            cellH4.Text = resVitalsname[3];
            cellH5.Attributes.Add("align", "left");
            cellH5.Text = resVitalsname[4];
            cellH6.Attributes.Add("align", "left");
            cellH6.Text = resVitalsname[5];
            cellH7.Attributes.Add("align", "left");
            cellH7.Text = resVitalsname[6];
            cellH8.Attributes.Add("align", "left");
            cellH8.Text = resVitalsname[7];
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Cells.Add(cellH6);
            rowH.Cells.Add(cellH7);
            rowH.Cells.Add(cellH8);
            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblAdmissionVitals.Rows.Add(rowH);


            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();
            TableCell cell4 = new TableCell();
            TableCell cell5 = new TableCell();
            TableCell cell6 = new TableCell();
            TableCell cell7 = new TableCell();
            TableCell cell8 = new TableCell();
            if (resVitalsvalue[0] != "0.00")
            {
                cell1.Attributes.Add("align", "left");
                cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
            }
            else
            {
                cell1.Text = "-";
            }
            if (resVitalsvalue[1] != "0.00")
            {
             
                cell2.Attributes.Add("align", "left");
                string SBP = resVitalsvalue[1];
                string[] resSBP = SBP.Split('.');
                cell2.Text = resSBP[0] + " " + resVitalsunit[1];
            }
            else
            {
                cell2.Text = "-";
            }
            if (resVitalsvalue[2] != "0.00")
            {
               

                cell3.Attributes.Add("align", "left");
                string DBP = resVitalsvalue[2];
                string[] resDBP = DBP.Split('.');
                cell3.Text = resDBP[0] + " " + resVitalsunit[2];
            }
            else
            {
                cell3.Text = "-";
            }
            if (resVitalsvalue[3] != "0.00")
            {
               
                cell4.Attributes.Add("align", "left");
                string Pulse = resVitalsvalue[3];
                string[] resPulse = Pulse.Split('.');
                cell4.Text = resPulse[0] + " " + resVitalsunit[3];
            }
            else
            {
                cell4.Text = "-";
            }

            if (resVitalsvalue[4] != "0.00")
            {
                cell5.Attributes.Add("align", "left");
                cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
            }
            else
            {
                cell5.Text = "-";
            }
            if (resVitalsvalue[5] != "0.00")
            {
                cell6.Attributes.Add("align", "left");
                cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
            }
            else
            {
                cell6.Text = "-";
            }

            if (resVitalsvalue[6] != "0.00")
            {
                cell7.Attributes.Add("align", "left");
                cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
            }
            else
            {
                cell7.Text = "-";
            }

            if (resVitalsvalue[7] != "0.00")
            {
              
                cell8.Attributes.Add("align", "left");
                string RR = resVitalsvalue[7];
                string[] resRR = RR.Split('.');
                cell8.Text = resRR[0] + " " + resVitalsunit[7];
            }
            else
            {
                cell8.Text = "-";
            }

            row1.Cells.Add(cell1);
            row1.Cells.Add(cell2);
            row1.Cells.Add(cell3);
            row1.Cells.Add(cell4);
            row1.Cells.Add(cell5);
            row1.Cells.Add(cell6);
            row1.Cells.Add(cell7);
            row1.Cells.Add(cell8);
            row1.Style.Add("color", "#000");
            tblAdmissionVitals.Rows.Add(row1);
            if (strExam != string.Empty)
            {
                tblExam.Attributes.Add("style", "display:block");
            }

        }
        #endregion
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Patient/PatientExaminationPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "EXM" + "&mode=" + "U", true);
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
    protected void btnEditExam_Click(object sender, EventArgs e)
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
    protected void btnEMRHistory_Click(object sender, EventArgs e)
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
            CLogger.LogError("Error in Redirect to EMR History Page", ex);
        }
    }
}
