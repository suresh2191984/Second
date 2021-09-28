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


public partial class EMR_PrintExam : BaseControl
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    string strExam = string.Empty;
    string strVital = string.Empty;
    string strScar = string.Empty;
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    string Abnormalities = string.Empty;

    string sign,skin, Hair, Nails, AuditoryCanal, EarDrum, ThyroidGland, LymphNodes, Trachea,
           BreathSounds, ColorVision, Pterygium, Xanthelasma, EyeMovements, Tonometry,
           Teeth, Tongue, Tonsils, Pharynx, CranialNerves, SensorySystem, Reflexes,
           MotorSystem, MusculoSkeletalsystem, Gait, Rectum, Prostate,
           PeripheraPulses, ApexBeat, HeartSounds, HeartMummurs, Liver, Spleen, Kidneys,
           Breasts, Uterus, ExternalGenetaila;

    decimal wt = 0, ht = 0, bmi = 0,whr=0;
     
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    public void LoadExamData(long pVisitID)
    {
        try
        {
        long returnCode = -1;
        //Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        Patient patient = new Patient();
        patientBL.GetPatientDetailsPassingVisitID(pVisitID, out lstPatient);
        hdnSex.Value = lstPatient[0].SEX;
        if (hdnSex.Value == "M")
        {
            tblGynae1.Style.Add("display", "none");
            tblGynae.Style.Add("display", "none");
        }

        returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(pVisitID, OrgID, out lstAttribute, out lstVitalsUOMJoin, out lstExam, out lstPEA);
        if (lstPEA.Count > 0)
        {
            for (int i = 0; i < lstPEA.Count(); i++)
            {
                if (lstPEA[i].ExaminationID == 941)
                {
                    lblSignNil.Visible = false;
                    
                }
                if (lstPEA[i].AttributeID == 114)
                {
                    //lblSkinTypeSKAI_1.Visible = true;
                    //lblSkinTypeSKAVI_1.Visible = true;
                    //lblSkinTypeSKAVI_1.Text = lstPEA[i].AttributeValueName+",";
                    sign = lstPEA[i].AttributeValueName;
                }
                strExam = "General Sign";
                if (sign == "")
                {
                    tblSign.Attributes.Add("style", "display:none");
                    tblSign1.Attributes.Add("style", "display:none");
                }
                //else
                //{
                //    tblSign.Attributes.Add("style", "display:block");
                //}
                //tblSign.Attributes.Add("style", "display:block");
                #region Skin

                if (lstPEA[i].ExaminationID == 928)
                {
                    lblSKNil.Visible = false;
                    if (lstPEA[i].AttributeID == 1)
                    {
                        //lblSkinTypeSKAI_1.Visible = true;
                        //lblSkinTypeSKAVI_1.Visible = true;
                        //lblSkinTypeSKAVI_1.Text = lstPEA[i].AttributeValueName+",";
                        skin = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 2)
                    {
                        //lblSkinLesionsSKAI_2.Visible = true;
                       // lblSkinLesionsSKAVI_2.Visible = true;
                       // lblSkinLesionsSKAVI_2.Text = lstPEA[i].AttributeValueName;
                        if (skin != null)
                        {
                            skin += ", " + lstPEA[i].AttributeValueName+"  present";
                        }
                        else
                        {
                            skin = lstPEA[i].AttributeValueName + "  present";
                        }
                    }
                    strExam = "Examination";
                    tblSkin.Attributes.Add("style", "display:block");
                    tblSkin1.Attributes.Add("style", "display:block");
                }

              

                #endregion

                #region Hair

                if (lstPEA[i].ExaminationID == 915)
                {
                    lblHRNil.Visible = false;
                    if (lstPEA[i].AttributeID == 3)
                    {
                        //lblHairTypeHRAI_3.Visible = true;
                        //lblHairTypeHRAVI_3.Visible = true;
                        //lblHairTypeHRAVI_3.Text = lstPEA[i].AttributeValueName;
                        Hair = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblHair.Attributes.Add("style", "display:block");
                    tblHair1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Nails

                if (lstPEA[i].ExaminationID == 916)
                {
                    lblNNil.Visible = false;
                    if (lstPEA[i].AttributeID == 4)
                    {
                        //lblNailsTypeNAI_4.Visible = true;
                        //lblNailsTypeNAVI_4.Visible = true;
                        //lblNailsTypeNAVI_4.Text = lstPEA[i].AttributeValueName;
                        Nails = lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 5)
                    {
                        //lblNailsDescriptionNAI_5.Visible = true;
                        //lblNailsDescriptionNAVI_5.Visible = true;
                        //lblNailsDescriptionNAVI_5.Text = lstPEA[i].AttributeValueName;
                        if (Nails != null)
                        {
                            Nails += ", " + lstPEA[i].AttributeValueName + "  present"; 
                        }
                        else
                        {
                            Nails = lstPEA[i].AttributeValueName + "  present"; 
                        }
                    }
                    strExam = "Examination";
                    tblNail.Attributes.Add("style", "display:block");
                    tblNail1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Scar

                if (lstPEA[i].ExaminationID == 917)
                {
                    lblSRNil.Visible = false;
                    if (lstPEA[i].AttributeID == 6)
                    {
                        //lblScarTypeSRAI_6.Visible = true;
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
                    tblScar.Attributes.Add("style", "display:block");
                    tblScar1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Ear

                #region Auditory Canal
                if (lstPEA[i].ExaminationID == 872)
                {
                    lblACNil.Visible = false;
                    if (lstPEA[i].AttributeID == 35)
                    {
                        
                        //lblRightEarACAI_35.Visible = true;
                        //lblRightEarACAVI_35.Visible = true;
                        //lblRightEarACAVI_35.Text = lstPEA[i].AttributeValueName;
                        AuditoryCanal = "Right Ear:" + lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 36)
                    {
                        //lblLeftEarACAI_36.Visible = true;
                        //lblLeftEarACAVI_36.Visible = true;
                        //lblLeftEarACAVI_36.Text = lstPEA[i].AttributeValueName;

                        if (AuditoryCanal != null)
                        {
                            AuditoryCanal += ", " + "Left Ear:" + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            AuditoryCanal = "Left Ear:" + lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblEar.Attributes.Add("style", "display:block");
                    tblEar1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Ear Drum
                if (lstPEA[i].ExaminationID == 873)
                {
                    lblEDNil.Visible = false;
                    if (lstPEA[i].AttributeID == 37)
                    {
                        //lblRightEarEDAI_37.Visible = true;
                        lblRightEarEDAVI_37.Visible = true;
                        lblRightEarEDAVI_37.Text = lstPEA[i].AttributeValueName;
                        EarDrum = "Right Ear:" + lstPEA[i].AttributeValueName;
                        
                    }
                    if (lstPEA[i].AttributeID == 38)
                    {
                        //lblLeftEarEDAI_38.Visible = true;
                        //lblLeftEarEDAVI_38.Visible = true;
                        //lblLeftEarEDAVI_38.Text = lstPEA[i].AttributeValueName;

                        if (EarDrum != null)
                        {
                            EarDrum += "," + "Left Ear:" + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            EarDrum = "Left Ear:" + lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblEar.Attributes.Add("style", "display:block");
                    tblEar1.Attributes.Add("style", "display:block");
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
                       
                        ThyroidGland =  lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 40)
                    {
                     
                        if (ThyroidGland != null)
                        {
                            ThyroidGland += ": " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            ThyroidGland = lstPEA[i].AttributeValueName;
                        }	

                    }
                    strExam = "Examination";
                    tblNeck.Attributes.Add("style", "display:block");
                    tblNeck1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Lymph Nodes
                if (lstPEA[i].ExaminationID == 876)
                {
                    lblLNNil.Visible = false;
                    if (lstPEA[i].AttributeID == 41)
                    {
                       
                        LymphNodes = lstPEA[i].AttributeValueName;
                       
                    }
                    if (lstPEA[i].AttributeID == 42)
                    {
                      

                        if (ThyroidGland != null)
                        {
                            LymphNodes += ": " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            LymphNodes = lstPEA[i].AttributeValueName;
                        }	

                    }
                    strExam = "Examination";
                    tblNeck.Attributes.Add("style", "display:block");
                    tblNeck1.Attributes.Add("style", "display:block");
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
                        //lblTypeTRAAI_43.Visible = true;
                        //lblTypeTRAAVI_43.Visible = true;
                        //lblTypeTRAAVI_43.Text = lstPEA[i].AttributeValueName;
                        Trachea = lstPEA[i].AttributeValueName;	

                    }
                    if (lstPEA[i].AttributeID == 44)
                    {

                        //lblPostTracheostomy_156.Visible = true;
                        //lblPostTracheostomy_156.Text = lstPEA[i].AttributeValueName;

                        if (Trachea != null)
                        {
                            Trachea += ", " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Trachea = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblRespiratory.Attributes.Add("style", "display:block");
                    tblRespiratory1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Breath Sounds
                if (lstPEA[i].ExaminationID == 879)
                {
                    lblBSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 45)
                    {
                        //ddlTypeBSAI_45.Visible = true;
                        //ddlTypeBSAVI_45.Visible = true;
                        //ddlTypeBSAVI_45.Text = lstPEA[i].AttributeValueName;
                        BreathSounds = lstPEA[i].AttributeValueName;	

                    }
                    if (lstPEA[i].AttributeID == 46)
                    {
                        //lblAbnormalitiesBSAI_46.Visible = true;
                        //lblAbnormalitiesBSAVI_46.Visible = true;
                        //lblAbnormalitiesBSAVI_46.Text = lstPEA[i].AttributeValueName;

                        if (BreathSounds != null)
                        {
                            BreathSounds += ", " + lstPEA[i].AttributeValueName + " present";
                        }
                        else
                        {
                            BreathSounds = lstPEA[i].AttributeValueName + " present";
                        }
                    }
                    strExam = "Examination";
                    tblRespiratory.Attributes.Add("style", "display:block");
                    tblRespiratory1.Attributes.Add("style", "display:block");

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
                        //ddlTypeDVAI_9.Visible = true;
                        ddlTypeDVAVI_9.Visible = true;
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
                    trDistantSpace.Attributes.Add("style", "display:block");
                    trDistant.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Near Vision
                if (lstPEA[i].ExaminationID == 920)
                {
                    lblNVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 11)
                    {
                        //lblTypeNVAI_11.Visible = true;
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
                    trNearSpace.Attributes.Add("style", "display:block");
                    trNear.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Color Vision
                if (lstPEA[i].ExaminationID == 921)
                {
                    lblCVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 13)
                    {
                        //lblTypeCVAI_13.Visible = true;
                        //lblTypeCVAVI_13.Visible = true;
                        //lblTypeCVAVI_13.Text = lstPEA[i].AttributeValueName;
                        ColorVision = lstPEA[i].AttributeValueName;	
                    }
                    if (lstPEA[i].AttributeID == 14)
                    {
                        //lblDescriptionCVAI_14.Visible = true;
                        //lblDescriptionCVAVI_14.Visible = true;
                        //lblDescriptionCVAVI_14.Text = lstPEA[i].AttributeValueName;


                        if (ColorVision != null)
                        {
                            ColorVision += "- " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            ColorVision = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    lblColorVision_921.Visible = true;
                    trColorSpace.Attributes.Add("style", "display:block");
                    trColor.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region IOL Present
                if (lstPEA[i].ExaminationID == 922)
                {
                    lblIOLNil.Visible = false;
                    if (lstPEA[i].AttributeID == 15)
                    {
                        //lblEyesIOLAI_15.Visible = true;
                        lblEyesIOLAVI_15.Visible = true;
                        lblEyesIOLAVI_15.Text = lstPEA[i].AttributeValueName +" IOL present";
                    }
                    strExam = "Examination";
                    trIOLSpace.Attributes.Add("style", "display:block");
                    trIOL.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Pterygium
                if (lstPEA[i].ExaminationID == 923)
                {
                    lblPGNil.Visible = false;
                    if (lstPEA[i].AttributeID == 16)
                    {
                        //lblTypePGAI_16.Visible = true;
                        //lblTypePGAVI_16.Visible = true;
                        //lblTypePGAVI_16.Text = lstPEA[i].AttributeValueName;
                        Pterygium = lstPEA[i].AttributeValueName;  
                    }
                    if (lstPEA[i].AttributeID == 17)
                    {
                        //lblDescriptionPGAI_17.Visible = true;
                        //lblDescriptionPGAVI_17.Visible = true;
                        //lblDescriptionPGAVI_17.Text = lstPEA[i].AttributeValueName;
                        if (Pterygium != null && lstPEA[i].AttributeValueName!="")
                        {
                            Pterygium += "- " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Pterygium = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    trPterySpace.Attributes.Add("style", "display:block");
                    trPtery.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Xanthelasma
                if (lstPEA[i].ExaminationID == 924)
                {
                    lblXNil.Visible = false;
                    if (lstPEA[i].AttributeID == 18)
                    {
                        //lblTypeXAI_18.Visible = true;
                        //lblTypeXAVI_18.Visible = true;
                        //lblTypeXAVI_18.Text = lstPEA[i].AttributeValueName;
                        Xanthelasma = lstPEA[i].AttributeValueName; 
                    }
                    if (lstPEA[i].AttributeID == 19)
                    {
                        //lblAssociatedConditionsXAI_19.Visible = true;
                        //lblAssociatedConditionsXAVI_19.Visible = true;
                        //lblAssociatedConditionsXAVI_19.Text = lstPEA[i].AttributeValueName;
                        if (Xanthelasma != null)
                        {
                            Xanthelasma += ", " +lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Xanthelasma = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    trXantheSpace.Attributes.Add("style", "display:block");
                    trXanthe.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Eye Movements
                if (lstPEA[i].ExaminationID == 925)
                {
                    lblEMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 20)
                    {
                        //lblTypeEMAI_20.Visible = true;
                        //lblTypeEMAVI_20.Visible = true;
                        //lblTypeEMAVI_20.Text = lstPEA[i].AttributeValueName;

                        EyeMovements = lstPEA[i].AttributeValueName; 
                    }
                    if (lstPEA[i].AttributeID == 21)
                    {
                        //lblAbnormalityEMAI_21.Visible = true;
                        //lblAbnormalityEMAVI_21.Visible = true;
                        //lblAbnormalityEMAVI_21.Text = lstPEA[i].AttributeValueName;

                        if (EyeMovements != null)
                        {
                            EyeMovements += ", " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            EyeMovements = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    trEyemoveSpace.Attributes.Add("style", "display:block");
                    trEyemove.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
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
                    trPupilsSpace.Attributes.Add("style", "display:block");
                    trPupils.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Tonometry
                if (lstPEA[i].ExaminationID == 927)
                {
                    lblIOPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 33)
                    {
                        //lblIOPTAI_33.Visible = true;
                        //lblRightIOPTAI_33.Visible = true;
                        //lblRightIOPTAVI_33.Visible = true;
                        //lblRightIOPTAVI_33.Text = lstPEA[i].AttributeValueName;
                        Tonometry = "Right IOP:" + lstPEA[i].AttributeValueName;
                    }
                    if (lstPEA[i].AttributeID == 34)
                    {
                        //lblIOPTAI_33.Visible = true;
                        //lblLeftIOPTAI_34.Visible = true;
                        //lblLeftIOPTAVI_34.Visible = true;
                        //lblLeftIOPTAVI_34.Text = lstPEA[i].AttributeValueName;



                        if (Tonometry != string.Empty)
                        {
                            Tonometry += ", " + "Left IOP:" + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Tonometry = "Left IOP:" + lstPEA[i].AttributeValueName;
                        }	

                    }
                    strExam = "Examination";
                    trTonometrySpace.Attributes.Add("style", "display:block");
                    trTonometry.Attributes.Add("style", "display:block");
                    tblEye.Attributes.Add("style", "display:block");
                    tblEye1.Attributes.Add("style", "display:block");
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
                        //lblTypeGEAI_66.Visible = true;
                        lblTypeGEAVI_66.Visible = true;
                        lblTypeGEAVI_66.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblOral.Attributes.Add("style", "display:block");
                    tblOral1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Teeth

                if (lstPEA[i].ExaminationID == 896)
                {
                    lblTHNil.Visible = false;
                    if (lstPEA[i].AttributeID == 67)
                    {
                        //lblTypeTHAI_67.Visible = true;
                        //lblTypeTHAVI_67.Visible = true;
                        //lblTypeTHAVI_67.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            Teeth = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 68)
                    {                        
                        //lblAbnormalitiesTHAI_68.Visible = true;
                        //lblAbnormalitiesTHAVI_68.Visible = true;
                        //lblAbnormalitiesTHAVI_68.Text = lstPEA[i].AttributeValueName;
                        Teeth = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblOral.Attributes.Add("style", "display:block");
                    tblOral1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Tongue

                if (lstPEA[i].ExaminationID == 897)
                {
                    lblTGNil.Visible = false;
                    if (lstPEA[i].AttributeID == 69)
                    {
                        //lblTypeTGAI_69.Visible = true;
                        //lblTypeTGAVI_69.Visible = true;
                        //lblTypeTGAVI_69.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            Tongue = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 70)
                    {
                        //lblAbnormalitiesTGAI_70.Visible = true;
                        //lblAbnormalitiesTGAVI_70.Visible = true;
                        //lblAbnormalitiesTGAVI_70.Text = lstPEA[i].AttributeValueName;
                        Tongue = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblOral.Attributes.Add("style", "display:block");
                    tblOral1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Tonsils

                if (lstPEA[i].ExaminationID == 898)
                {
                    lblTSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 71)
                    {
                        //lblTypeTSAI_71.Visible = true;
                        //lblTypeTSAVI_71.Visible = true;
                        //lblTypeTSAVI_71.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal" || lstPEA[i].AttributeValueName == "Absent")
                        {
                            Tonsils = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 72)
                    {
                        //lblAbnormalitiesTSAI_72.Visible = true;
                        //lblAbnormalitiesTSAVI_72.Visible = true;
                        //lblAbnormalitiesTSAVI_72.Text = lstPEA[i].AttributeValueName;
                        Tonsils = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblOral.Attributes.Add("style", "display:block");
                    tblOral1.Attributes.Add("style", "display:block");
                }


                #endregion

                #region Pharynx

                if (lstPEA[i].ExaminationID == 899)
                {
                    lblPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 73)
                    {
                        //lblTypePAI_73.Visible = true;
                        //lblTypePAVI_73.Visible = true;
                        //lblTypePAVI_73.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            Pharynx = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 74)
                    {
                        //lblAbnormalitiesPAI_74.Visible = true;
                        //lblAbnormalitiesPAVI_74.Visible = true;
                        //lblAbnormalitiesPAVI_74.Text = lstPEA[i].AttributeValueName;
                        Pharynx = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblOral.Attributes.Add("style", "display:block");
                    tblOral1.Attributes.Add("style", "display:block");
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
                        //lblTypeCNAI_75.Visible = true;
                        //lblTypeCNAVI_75.Visible = true;
                        //lblTypeCNAVI_75.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            CranialNerves = lstPEA[i].AttributeValueName;
                        }

                    }

                    if (lstPEA[i].AttributeID == 76)
                    {

                        //if (CranialNerves == string.Empty)
                        //{
                        //    Abnormalities = lstPEA[i].AttributeValueName;
                        //}
                        //else
                        //{
                        //    Abnormalities += "," + lstPEA[i].AttributeValueName;
                        //}
                        //lblAbnormalitiesCNAI_76.Visible = true;
                        //lblAbnormalitiesCNAVI_76.Visible = true;
                        //lblAbnormalitiesCNAVI_76.Text = Abnormalities + ".";

                         if (CranialNerves == null)
                        {
                            Abnormalities = lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Abnormalities += "," + lstPEA[i].AttributeValueName;
                        }
                       
                        CranialNerves = Abnormalities + ".";
                        
                    }

                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Sensory System

                if (lstPEA[i].ExaminationID == 902)
                {
                    lblSSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 77)
                    {
                        //lblTypeSSAI_77.Visible = true;
                        //lblTypeSSAVI_77.Visible = true;
                        //lblTypeSSAVI_77.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            SensorySystem = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 78)
                    {
                        //lblAbnormalitiesSSAI_78.Visible = true;
                        //lblAbnormalitiesSSAVI_78.Visible = true;
                        //lblAbnormalitiesSSAVI_78.Text = lstPEA[i].AttributeValueName;
                        SensorySystem = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");

                }

                #endregion

                #region Reflexes

                if (lstPEA[i].ExaminationID == 903)
                {
                    lblRFNil.Visible = false;
                    if (lstPEA[i].AttributeID == 79)
                    {
                        //lblTypeRFAI_79.Visible = true;
                        //lblTypeRFAVI_79.Visible = true;
                        //lblTypeRFAVI_79.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            Reflexes = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 80)
                    {
                        //lblAbnormalitiesRFAI_80.Visible = true;
                        //lblAbnormalitiesRFAVI_80.Visible = true;
                        //lblAbnormalitiesRFAVI_80.Text = lstPEA[i].AttributeValueName;
                        Reflexes = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Motor System

                if (lstPEA[i].ExaminationID == 904)
                {
                    lblMSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 81)
                    {
                        //lblTypeMSAI_81.Visible = true;
                        //lblTypeMSAVI_81.Visible = true;
                        //lblTypeMSAVI_81.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            MotorSystem = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 82)
                    {
                        //lblAbnormalitiesMSAI_82.Visible = true;
                        //lblAbnormalitiesMSAVI_82.Visible = true;
                        //lblAbnormalitiesMSAVI_82.Text = lstPEA[i].AttributeValueName;
                        MotorSystem = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");
                }


                #endregion

                #region Musculo Skeletal System

                if (lstPEA[i].ExaminationID == 905)
                {
                    lblMSSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 83)
                    {
                        //lblTypeMSSAI_83.Visible = true;
                        //lblTypeMSSAVI_83.Visible = true;
                        //lblTypeMSSAVI_83.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            MusculoSkeletalsystem = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 84)
                    {
                        //lblAbnormalitiesMSSAI_84.Visible = true;
                        //lblAbnormalitiesMSSAVI_84.Visible = true;
                        //lblAbnormalitiesMSSAVI_84.Text = lstPEA[i].AttributeValueName;
                        MusculoSkeletalsystem = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Gait

                if (lstPEA[i].ExaminationID == 906)
                {
                    lblGTNil.Visible = false;
                    if (lstPEA[i].AttributeID == 85)
                    {
                        //lblTypeGTAI_85.Visible = true;
                        //lblTypeGTAVI_85.Visible = true;
                        //lblTypeGTAVI_85.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            Gait = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 86)
                    {
                        //lblAbnormalitiesGTAI_86.Visible = true;
                        //lblAbnormalitiesGTAVI_86.Visible = true;
                        //lblAbnormalitiesGTAVI_86.Text = lstPEA[i].AttributeValueName;
                        Gait = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblNeuro.Attributes.Add("style", "display:block");
                    tblNeuro1.Attributes.Add("style", "display:block");
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
                            //lblTypeBAI_87.Visible = true;
                            //lblTypeBAVI_87.Visible = true;
                            //lblTypeBAVI_87.Text = lstPEA[i].AttributeValueName;
                            if (lstPEA[i].AttributeValueName == "Normal")
                            {
                                Breasts = lstPEA[i].AttributeValueName;
                            }
                        }

                        if (lstPEA[i].AttributeID == 88)
                        {
                            //lblAbnormalitiesBAI_88.Visible = true;
                            //lblAbnormalitiesBAVI_88.Visible = true;
                            //lblAbnormalitiesBAVI_88.Text = lstPEA[i].AttributeValueName;
                            Breasts = lstPEA[i].AttributeValueName;
                        }

                        strExam = "Examination";
                        tblGynae.Attributes.Add("style", "display:block");
                        tblGynae1.Attributes.Add("style", "display:block");
                    }

                    #endregion

                    #region Uterus

                    if (lstPEA[i].ExaminationID == 909)
                    {
                        lblUNil.Visible = false;
                        if (lstPEA[i].AttributeID == 89)
                        {
                            //lblTypeUAI_89.Visible = true;
                            //lblTypeUAVI_89.Visible = true;
                            //lblTypeUAVI_89.Text = lstPEA[i].AttributeValueName;
                            if (lstPEA[i].AttributeValueName == "Normal")
                            {
                                Uterus = lstPEA[i].AttributeValueName;
                            }
                        }

                        if (lstPEA[i].AttributeID == 90)
                        {
                            //lblAbnormalitiesUAI_90.Visible = true;
                            //lblAbnormalitiesUAVI_90.Visible = true;
                            //lblAbnormalitiesUAVI_90.Text = lstPEA[i].AttributeValueName;

                            Uterus = lstPEA[i].AttributeValueName;
                        }

                        strExam = "Examination";
                        tblGynae.Attributes.Add("style", "display:block");
                        tblGynae1.Attributes.Add("style", "display:block");
                    }

                    #endregion

                    #region External Genetaila

                    if (lstPEA[i].ExaminationID == 910)
                    {
                        lblEGNil.Visible = false;
                        if (lstPEA[i].AttributeID == 91)
                        {
                            //lblTypeEGAI_91.Visible = true;
                            //lblTypeEGAVI_91.Visible = true;
                            //lblTypeEGAVI_91.Text = lstPEA[i].AttributeValueName;

                            if (lstPEA[i].AttributeValueName == "Normal")
                            {
                                ExternalGenetaila = lstPEA[i].AttributeValueName;
                            }
                        }

                        if (lstPEA[i].AttributeID == 92)
                        {
                            //lblAbnormalitiesEGAI_92.Visible = true;
                            //lblAbnormalitiesEGAVI_92.Visible = true;
                            //lblAbnormalitiesEGAVI_92.Text = lstPEA[i].AttributeValueName;
                            ExternalGenetaila = lstPEA[i].AttributeValueName;
                        }
                        strExam = "Examination";
                        tblGynae.Attributes.Add("style", "display:block");
                        tblGynae1.Attributes.Add("style", "display:block");
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
                        //lblTypeRTMAI_93.Visible = true;
                        //lblTypeRTMAVI_93.Visible = true;
                        //lblTypeRTMAVI_93.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal") 
                        {
                            Rectum = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 94)
                    {
                        //lblAbnormalitiesRTMAI_94.Visible = true;
                        //lblAbnormalitiesRTMAVI_94.Visible = true;
                        //lblAbnormalitiesRTMAVI_94.Text = lstPEA[i].AttributeValueName;
                        if (Rectum != null && lstPEA[i].AttributeValueName != "")
                        {
                            Rectum += "- " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Rectum = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblRect.Attributes.Add("style", "display:block");
                    tblRect1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Prostate

                if (lstPEA[i].ExaminationID == 913)
                {
                    lblPRTNil.Visible = false;
                    if (lstPEA[i].AttributeID == 95)
                    {
                        //lblTypePRTAI_95.Visible = true;
                        //lblTypePRTAVI_95.Visible = true;
                        //lblTypePRTAVI_95.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal") 
                        {
                            Prostate = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 96)
                    {
                        //lblAbnormalitiesPRTAI_96.Visible = true;
                        //lblAbnormalitiesPRTAVI_96.Visible = true;
                        //lblAbnormalitiesPRTAVI_96.Text = lstPEA[i].AttributeValueName;

                        if (Prostate != null && lstPEA[i].AttributeValueName != "")
                        {
                            Prostate += "- " + lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            Prostate = lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblRect.Attributes.Add("style", "display:block");
                    tblRect1.Attributes.Add("style", "display:block");

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
                       // lblFindingsPRTMAI_47.Visible = true;
                        lblFindingsPRTMAVI_47.Visible = true;
                        lblFindingsPRTMAVI_47.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");

                }
                #endregion

                #region Pulse Volume
                if (lstPEA[i].ExaminationID == 882)
                {
                    lblPVNil.Visible = false;
                    if (lstPEA[i].AttributeID == 48)
                    {
                        //lblFindingsPVAI_48.Visible = true;
                        lblFindingsPVAVI_48.Visible = true;
                        lblFindingsPVAVI_48.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Pulse Character
                if (lstPEA[i].ExaminationID == 883)
                {
                    lblPCNil.Visible = false;
                    if (lstPEA[i].AttributeID == 49)
                    {
                        //lblFindingsPCAI_49.Visible = true;
                        lblFindingsPCAVI_49.Visible = true;
                        lblFindingsPCAVI_49.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Peripheral Pulses

                if (lstPEA[i].ExaminationID == 884)
                {
                    lblPEPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 50)
                    {
                        //lblFindingsSignsPEPAI_50.Visible = true;
                        //lblFindingsSignsPEPAVI_50.Visible = true;
                        //lblFindingsSignsPEPAVI_50.Text = lstPEA[i].AttributeValueName;
                        PeripheraPulses = lstPEA[i].AttributeValueName;  
                    }

                    if (lstPEA[i].AttributeID == 51)
                    {
                        //lblLocationPEPAI_51.Visible = true;
                        //lblLocationPEPAVI_51.Visible = true;
                        //lblLocationPEPAVI_51.Text = lstPEA[i].AttributeValueName;

                        if (PeripheraPulses != null && lstPEA[i].AttributeValueName != "")
                        {
                            PeripheraPulses += ", " +"Location:  " +lstPEA[i].AttributeValueName;
                        }
                        else
                        {
                            PeripheraPulses = lstPEA[i].AttributeValueName;
                        }

                    }
                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Apex Beat

                if (lstPEA[i].ExaminationID == 885)
                {
                    lblABNil.Visible = false;
                    if (lstPEA[i].AttributeID == 52)
                    {
                        //lblFindingsABAI_52.Visible = true;
                        //lblFindingsABAVI_52.Visible = true;
                        //lblFindingsABAVI_52.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            ApexBeat = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 53)
                    {
                        //lblTypesofabnormalitiessABAI_53.Visible = true;
                        //lblTypesofabnormalitiessABAVI_53.Visible = true;
                        //lblTypesofabnormalitiessABAVI_53.Text = lstPEA[i].AttributeValueName;
                        
                            ApexBeat = lstPEA[i].AttributeValueName;
                       


                    }
                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Heart Sounds

                if (lstPEA[i].ExaminationID == 886)
                {
                    lblHSNil.Visible = false;
                    if (lstPEA[i].AttributeID == 54)
                    {
                        //lblFindingsHSAI_54.Visible = true;
                        //lblFindingsHSAVI_54.Visible = true;
                        //lblFindingsHSAVI_54.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            HeartSounds = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 55)
                    {
                        //lblTypesofabnormalitiessHSAI_55.Visible = true;
                        //lblTypesofabnormalitiessHSAVI_55.Visible = true;
                        //lblTypesofabnormalitiessHSAVI_55.Text = lstPEA[i].AttributeValueName;
                        HeartSounds = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
                }


                #endregion

                #region Heart Mummurs

                if (lstPEA[i].ExaminationID == 887)
                {
                    lblHMNil.Visible = false;
                    if (lstPEA[i].AttributeID == 56)
                    {
                        //lblFindingsHMAI_56.Visible = true;
                        //lblFindingsHMAVI_56.Visible = true;
                        //lblFindingsHMAVI_56.Text = lstPEA[i].AttributeValueName;
                        if (lstPEA[i].AttributeValueName == "Normal")
                        {
                            HeartMummurs = lstPEA[i].AttributeValueName;
                        }
                    }

                    if (lstPEA[i].AttributeID == 57)
                    {
                        //lblTypesofabnormalitiessHMAI_57.Visible = true;
                        //lblTypesofabnormalitiessHMAVI_57.Visible = true;
                        //lblTypesofabnormalitiessHMAVI_57.Text = lstPEA[i].AttributeValueName;
                        HeartMummurs = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblCardio.Attributes.Add("style", "display:block");
                    tblCardio1.Attributes.Add("style", "display:block");
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
                      //  lblInspectionAIAI_58.Visible = true;
                        lblInspectionAIAVI_58.Visible = true;
                        lblInspectionAIAVI_58.Text = lstPEA[i].AttributeValueName;
                    }

                    strExam = "Examination";
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");
                }
                #endregion

                #region Abdominal Palpation
                if (lstPEA[i].ExaminationID == 890)
                {
                    lblAPNil.Visible = false;
                    if (lstPEA[i].AttributeID == 59)
                    {
                        //lblPalpationAPAI_59.Visible = true;
                        lblPalpationAPAVI_59.Visible = true;
                        lblPalpationAPAVI_59.Text = lstPEA[i].AttributeValueName;
                    }
                    strExam = "Examination";
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");

                }

                #endregion

                #region Liver

                if (lstPEA[i].ExaminationID == 891)
                {
                    lblLINil.Visible = false;
                    if (lstPEA[i].AttributeID == 60)
                    {
                        //lblTypeLIAI_60.Visible = true;
                        //lblTypeLIAVI_60.Visible = true;
                        //lblTypeLIAVI_60.Text = lstPEA[i].AttributeValueName;
                        Liver = lstPEA[i].AttributeValueName;

                    }

                    if (lstPEA[i].AttributeID == 61)
                    {
                        //lblDescriptionLIAI_61.Visible = true;
                        //lblDescriptionLIAVI_61.Visible = true;
                        //lblDescriptionLIAVI_61.Text = lstPEA[i].AttributeValueName;
                        if (Liver != null && lstPEA[i].AttributeValueName != "")
                        {
                            Liver += "- " + lstPEA[i].AttributeValueName;
                        }
                      

                    }
                    strExam = "Examination";
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Spleen

                if (lstPEA[i].ExaminationID == 892)
                {
                    lblSPLNil.Visible = false;
                    if (lstPEA[i].AttributeID == 62)
                    {
                        //lblTypeSPLAI_62.Visible = true;
                        //lblTypeSPLAVI_62.Visible = true;
                        //lblTypeSPLAVI_62.Text = lstPEA[i].AttributeValueName;
                        Spleen = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 63)
                    {
                        //lblDescriptionSPLAI_63.Visible = true;
                        //lblDescriptionSPLAVI_63.Visible = true;
                        //lblDescriptionSPLAVI_63.Text = lstPEA[i].AttributeValueName;
                        if (Spleen != null && lstPEA[i].AttributeValueName != "")
                        {
                            Spleen += "- " + lstPEA[i].AttributeValueName;
                        }
                      
                    }
                    strExam = "Examination";
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");
                }

                #endregion

                #region Kidneys

                if (lstPEA[i].ExaminationID == 893)
                {
                    lblKDNil.Visible = false;
                    if (lstPEA[i].AttributeID == 64)
                    {
                        //lblTypeKDAI_64.Visible = true;
                        //lblTypeKDAVI_64.Visible = true;
                        //lblTypeKDAVI_64.Text = lstPEA[i].AttributeValueName;
                        Kidneys = lstPEA[i].AttributeValueName;
                    }

                    if (lstPEA[i].AttributeID == 65)
                    {
                        //lblDescriptionKDAI_65.Visible = true;
                        //lblDescriptionKDAVI_65.Visible = true;
                        //lblDescriptionKDAVI_65.Text = lstPEA[i].AttributeValueName;
                        if (Kidneys != null && lstPEA[i].AttributeValueName != "")
                        {
                            Kidneys += "- " + lstPEA[i].AttributeValueName;
                        }
                    }
                    strExam = "Examination";
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");
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
                    tblAbdominal.Attributes.Add("style", "display:block");
                    tblAbdominal1.Attributes.Add("style", "display:block");
                }
                #endregion


                #endregion

                #region FOOT EXAMINATION
                    #region Peripheral Neuropathy
                        if (lstPEA[i].ExaminationID == 934)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributevalueID == 498)
                            {

                                lblPeripheral.Visible = true;
                                lblPeripheral.Text +=" Right Foot : " + lstPEA[i].AttributeValueName + ";";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        if (lstPEA[i].ExaminationID == 934)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributevalueID == 499)
                            {

                                lblPeripheral.Visible = true;
                                lblPeripheral.Text += " Left Foot : " + lstPEA[i].AttributeValueName + ";";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                    #endregion
                        #region Pedal Oedema
                        if (lstPEA[i].ExaminationID == 935)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 100)
                            {

                                lblPedal.Visible = true;
                                lblPedal.Text += lstPEA[i].AttributeValueName + " in  Right Foot ; ";
                            }
                            if (lstPEA[i].AttributeID == 101)
                            {

                                lblPedal.Visible = true;
                                lblPedal.Text += lstPEA[i].AttributeValueName + " in  Left Foot ; ";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                        #region Foot or Toe Deformity
                        if (lstPEA[i].ExaminationID == 936)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 102)
                            {

                                lblFootorToe.Visible = true;
                                lblFootorToe.Text += lstPEA[i].AttributeValueName + " in  Right Foot ; ";
                            }
                            if (lstPEA[i].AttributeID == 103)
                            {

                                lblFootorToe.Visible = true;
                                lblFootorToe.Text += lstPEA[i].AttributeValueName + " in  Left Foot ; ";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                        #region Foot Ulcer
                        if (lstPEA[i].ExaminationID == 937)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 109)
                            {

                                lblFootUlcer.Visible = true;
                                lblFootUlcer.Text += lstPEA[i].AttributeValueName + " in  Right Foot ; ";
                            }
                            if (lstPEA[i].AttributeID == 110)
                            {

                                lblFootUlcer.Visible = true;
                                lblFootUlcer.Text += lstPEA[i].AttributeValueName + " in  Left Foot ; ";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                        #region Infection
                        if (lstPEA[i].ExaminationID == 938)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 111)
                            {

                                lblInfection.Visible = true;
                                lblInfection.Text += lstPEA[i].AttributeValueName + " in  Right Foot ; ";
                            }
                            if (lstPEA[i].AttributeID == 112)
                            {

                                lblInfection.Visible = true;
                                lblInfection.Text += lstPEA[i].AttributeValueName + " in  Left Foot ; ";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                        #region Peripheral Pulses
                        if (lstPEA[i].ExaminationID == 939)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 104)
                            {

                                lblPeripheralPulses.Visible = true;
                                lblPeripheralPulses.Text += lstPEA[i].AttributeValueName + " in  Right Foot ; ";
                            }
                            if (lstPEA[i].AttributeID == 105)
                            {

                                lblPeripheralPulses.Visible = true;
                                lblPeripheralPulses.Text += lstPEA[i].AttributeValueName + " in  Left Foot ; ";
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                        #region Peripheral Pulses
                        if (lstPEA[i].ExaminationID == 940)
                        {
                            //lblOFNil.Visible = false;
                            if (lstPEA[i].AttributeID == 106)
                            {

                                lblFootRiskAssessment.Visible = true;
                                lblFootRiskAssessment.Text += lstPEA[i].AttributeValueName;
                            }
                            tblFoot.Attributes.Add("style", "display:block");
                            tblFoot1.Attributes.Add("style", "display:block");
                        }
                        #endregion
                #endregion
                        strExam = "Examination";
                     
                        
            }

            if (sign != null && sign != "")
            {
                tblSign.Attributes.Add("style","display:block");
                tblSign1.Attributes.Add("style", "display:block");
                lblSignValue.Visible = true;
                lblSignValue.Text = sign; 
            }
            #region Skin
            if (skin != null)
            {
                lblSkinTypeSKAVI_1.Visible = true;
                lblSkinTypeSKAVI_1.Text = skin;

            }
            #endregion

            #region Hair
            if (Hair != null)
            {
                lblHairTypeHRAVI_3.Visible = true;
                lblHairTypeHRAVI_3.Text = Hair;
            }
            #endregion

            #region Nails
            if (Nails != null)
            {
                lblNailsTypeNAVI_4.Visible = true;
                lblNailsTypeNAVI_4.Text = Nails;
            }
            #endregion
            
            #region Ear
            #region AuditoryCanal
            if (AuditoryCanal != null)
            {
                lblRightEarACAVI_35.Visible = true;
                lblRightEarACAVI_35.Text = AuditoryCanal;
            }
             #endregion


            #region EarDrum
            if (EarDrum != null)
            {
                lblRightEarEDAVI_37.Visible = true;
                lblRightEarEDAVI_37.Text = EarDrum;
                lblEarDrum_873.Visible = true;
                lblEDNil.Visible = true;
            }
            #endregion


            #endregion

            #region Neck
            #region ThyroidGland
            if (ThyroidGland != null)
            {
                lblTypeTTHYAVI_39.Visible = true;
                lblTypeTTHYAVI_39.Text = ThyroidGland;
            }
            #endregion


            #region LymphNodes
            if (LymphNodes != null)
            {
                ddlTypeLNAVI_41.Visible = true;
                ddlTypeLNAVI_41.Text = LymphNodes;
            }
            #endregion


            #endregion

            #region Respiratory System
            #region Trachea
            if (Trachea != null)
            {
                lblTypeTRAAVI_43.Visible = true;
                lblTypeTRAAVI_43.Text = Trachea;
            }
            #endregion


            #region BreathSounds
            if (BreathSounds != null)
            {
                ddlTypeBSAVI_45.Visible = true;
                ddlTypeBSAVI_45.Text = BreathSounds;
            }
            #endregion


            #endregion

            #region Eye
            #region ColorVision
            if (ColorVision != null)
            {
                lblTypeCVAVI_13.Visible = true;
                lblTypeCVAVI_13.Text = ColorVision;
            }
            #endregion

            #region Pterygium
            if (Pterygium != null)
            {
                lblTypePGAVI_16.Visible = true;
                lblTypePGAVI_16.Text = Pterygium;
            }
            #endregion

            #region Xanthelasma
            if (Xanthelasma != null)
            {
                lblTypeXAVI_18.Visible = true;
                lblTypeXAVI_18.Text = Xanthelasma;
            }
            #endregion

            #region EyeMovements
            if (EyeMovements != null)
            {
                lblTypeEMAVI_20.Visible = true;
                lblTypeEMAVI_20.Text = EyeMovements;
            }
            #endregion

            #region Tonometry
            if (Tonometry != null)
            {
                lblIOPTAI_33.Visible = true;
                lblIOPTAI_33.Text = Tonometry;
            }
            #endregion

            #endregion

            #region ORAL CAVITY
            #region Teeth
            if (Teeth != null)
            {
                lblTypeTHAVI_67.Visible = true;
                lblTypeTHAVI_67.Text = Teeth;
            }
            #endregion


            #region Tongue
            if (Tongue != null)
            {
                lblTypeTGAVI_69.Visible = true;
                lblTypeTGAVI_69.Text = Tongue;
            }
            #endregion

            #region Tonsils
            if (Tonsils != null)
            {
                lblTypeTSAVI_71.Visible = true;
                lblTypeTSAVI_71.Text = Tonsils;
            }
            #endregion

            #region Pharynx
            if (Pharynx != null)
            {
                lblTypePAVI_73.Visible = true;
                lblTypePAVI_73.Text = Pharynx;
            }
            #endregion

            #endregion           

            #region NEUROLOGICAL EXAMINATION
            #region CranialNerves
            if (CranialNerves != null)
            {
                lblTypeCNAVI_75.Visible = true;
                lblTypeCNAVI_75.Text = CranialNerves;
            }
            #endregion

            #region SensorySystem
            if (SensorySystem != null)
            {
                lblTypeSSAVI_77.Visible = true;
                lblTypeSSAVI_77.Text = SensorySystem;
            }
            #endregion

            #region Reflexes
            if (Reflexes != null)
            {
                lblTypeRFAVI_79.Visible = true;
                lblTypeRFAVI_79.Text = Reflexes;
            }
            #endregion

            #region MotorSystem
            if (MotorSystem != null)
            {
                lblTypeMSAVI_81.Visible = true;
                lblTypeMSAVI_81.Text = MotorSystem;
            }
            #endregion

            #region MusculoSkeletalsystem
            if (MusculoSkeletalsystem != null)
            {
                lblTypeMSSAVI_83.Visible = true;
                lblTypeMSSAVI_83.Text = MusculoSkeletalsystem;
            }
            #endregion

            #region Gait
            if (Gait != null)
            {
                lblTypeGTAVI_85.Visible = true;
                lblTypeGTAVI_85.Text = Gait;
            }
            #endregion

            #endregion

            #region ORAL CAVITY
            #region Rectum
            if (Rectum != null)
            {
                lblTypeRTMAVI_93.Visible = true;
                lblTypeRTMAVI_93.Text = Rectum;
            }
            #endregion


            #region Prostate
            if (Prostate != null)
            {
                lblTypePRTAVI_95.Visible = true;
                lblTypePRTAVI_95.Text = Prostate;
            }
            #endregion

            #endregion

            #region CARDIOVASCULAR EXAMINATION

            #region PeripheraPulses
            if (PeripheraPulses != null)
            {
                lblFindingsSignsPEPAVI_50.Visible = true;
                lblFindingsSignsPEPAVI_50.Text = PeripheraPulses;
            }
            #endregion

            #region ApexBeat
            if (ApexBeat != null)
            {
                lblFindingsABAVI_52.Visible = true;
                lblFindingsABAVI_52.Text = ApexBeat;
            }
            #endregion

            #region HeartSounds
            if (HeartSounds != null)
            {
                lblFindingsHSAVI_54.Visible = true;
                lblFindingsHSAVI_54.Text = HeartSounds;
            }
            #endregion

            #region HeartMummurs
            if (HeartMummurs != null)
            {
                lblFindingsHMAVI_56.Visible = true;
                lblFindingsHMAVI_56.Text = HeartMummurs;
            }
            #endregion

            #endregion

            #region ABDOMINAL EXAMINATION

            #region Liver
            if (Liver != null)
            {
                lblTypeLIAVI_60.Visible = true;
                lblTypeLIAVI_60.Text = Liver;
            }
            #endregion
            #region Spleen
            if (Spleen != null)
            {
                lblTypeSPLAVI_62.Visible = true;
                lblTypeSPLAVI_62.Text = Spleen;
            }
            #endregion
            #region Kidneys
            if (Kidneys != null)
            {
                lblTypeKDAVI_64.Visible = true;
                lblTypeKDAVI_64.Text = Kidneys;
            }
            #endregion

            #endregion

            #region GYNAECOLOGICAL EXAMINATION

            #region Breasts
            if (Breasts != null)
            {
                lblTypeBAVI_87.Visible = true;
                lblTypeBAVI_87.Text = Breasts;
            }
            #endregion

            #region Uterus
            if (Uterus != null)
            {
                lblTypeUAVI_89.Visible = true;
                lblTypeUAVI_89.Text = Uterus;
            }
            #endregion

            #region ExternalGenetaila
            if (ExternalGenetaila != null)
            {
                lblTypeEGAVI_91.Visible = true;
                lblTypeEGAVI_91.Text = ExternalGenetaila;
            }
            #endregion


            #endregion

            if (strExam != string.Empty)
            { 

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
            tblVital.Style.Add("display", "block");
            tblVital1.Style.Add("display", "block");
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
            string strBMI = string.Empty;


            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            TableCell cellH6 = new TableCell();
            TableCell cellH7 = new TableCell();
            TableCell cellH8 = new TableCell();
            TableCell cellH9 = new TableCell();
            TableCell cellH10 = new TableCell();
            TableCell cellH11 = new TableCell();
            //TableCell cellH12 = new TableCell();

            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "PR";// resVitalsname[3];
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "BP";// resVitalsname[16];
            cellH3.Attributes.Add("align", "left");
            cellH3.Text = "RR";
            cellH4.Attributes.Add("align", "left");
            cellH4.Text = "SpO2";
            cellH5.Attributes.Add("align", "left");
            cellH5.Text = "Temp";
            cellH6.Attributes.Add("align", "left");
            cellH6.Text = "Ht";
            cellH7.Attributes.Add("align", "left");
            cellH7.Text = "Wt";
            cellH8.Attributes.Add("align", "left");
            cellH8.Text = "BMI";
            cellH9.Attributes.Add("align", "left");
            cellH9.Text = "WC";
            cellH10.Attributes.Add("align", "left");
            cellH10.Text = "HC";
            cellH11.Attributes.Add("align", "left");
            cellH11.Text = "WHR";
            //cellH1.Attributes.Add("align", "left");
            //cellH1.Text = "PR";// resVitalsname[3];
            //cellH2.Attributes.Add("align", "left");
            //cellH2.Text = "BP";// resVitalsname[16];
            //cellH3.Attributes.Add("align", "left");
            //cellH3.Text = resVitalsname[8];
            //cellH4.Attributes.Add("align", "left");
            //cellH4.Text = resVitalsname[7];
            //cellH5.Attributes.Add("align", "left");
            //cellH5.Text = resVitalsname[1];
            //cellH6.Attributes.Add("align", "left");
            //cellH6.Text = resVitalsname[5];
            //cellH7.Attributes.Add("align", "left");
            //cellH7.Text = resVitalsname[6];
            //cellH8.Attributes.Add("align", "left");
            //cellH8.Text = resVitalsname[9];
            //cellH9.Attributes.Add("align", "left");

            //cellH9.Text = "WC";
            //cellH10.Attributes.Add("align", "left");
            //cellH10.Text = "HC";
            //cellH11.Attributes.Add("align", "left");
            //cellH11.Text = "WHR";
           // cellH12.Attributes.Add("align", "left");
            //cellH12.Text = "";
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Cells.Add(cellH6);
            rowH.Cells.Add(cellH7);
            rowH.Cells.Add(cellH8);
            rowH.Cells.Add(cellH9);
            rowH.Cells.Add(cellH10);
            rowH.Cells.Add(cellH11);
            //rowH.Cells.Add(cellH12);
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
            TableCell cell9 = new TableCell();
            TableCell cell10 = new TableCell();
            TableCell cell11 = new TableCell();
           // TableCell cell12 = new TableCell();


            string SBP = string.Empty;
            string DBP = string.Empty;
            string SBPUnit = string.Empty;
            double dblHet = 0;
            double dblWet = 0;
            double dblBMI = 0;
            double dblWHR = 0;
            double dblWC = 0;
            double dblHC = 0;

            for (int i = 0; i < resVitalsname.Count() - 1; i++)
            {
                if (resVitalsname[i].ToString() == "Pulse")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        cell1.Attributes.Add("align", "left");
                        string strPR = resVitalsvalue[i].Replace(".00", "");
                        //string strPR = String.Format("{0:0}", resVitalsvalue[i]);
                        cell1.Text = strPR  +" " + resVitalsunit[i];
                    }
                    else
                    {
                        cell1.Text = "-";
                    }
                }

                if (resVitalsname[i].ToString() == "SBP")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        SBP = resVitalsvalue[i];
                        SBPUnit = resVitalsunit[i];
                    }
                    else
                    {
                        SBP = "";
                    }
                }
                if (resVitalsname[i].ToString() == "DBP")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        DBP = resVitalsvalue[i];
                        SBPUnit = resVitalsunit[i];
                    }
                    else
                    {
                        DBP = "";
                    }
                }
                if (resVitalsname[i].ToString() == "RR")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        cell3.Attributes.Add("align", "left");
                        cell3.Text = resVitalsvalue[i].Replace(".00", "") +" " + resVitalsunit[i];
                    }
                    else
                    {
                        cell3.Text = "-";
                    }
                }
                if (resVitalsname[i].ToString() == "SpO2")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        cell4.Attributes.Add("align", "left");
                        cell4.Text = resVitalsvalue[i] + " " + resVitalsunit[i];
                    }
                    else
                    {
                        cell4.Text = "-";
                    }
                }
                if (resVitalsname[i].ToString() == "Temp")
                {
                    if (resVitalsvalue[i] != "0.00" && !string.IsNullOrEmpty(resVitalsvalue[i]))
                    {
                        cell5.Attributes.Add("align", "left");
                        decimal strTemp =Convert.ToDecimal(resVitalsvalue[i]);
                        cell5.Text = strTemp.ToString("0.##") + " " + resVitalsunit[i];
                    }
                    else
                    {
                        cell5.Text = "-";
                    }
                }
                if (resVitalsname[i].ToString() == "Height")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        cell6.Attributes.Add("align", "left");
                        decimal strTemp = Convert.ToDecimal(resVitalsvalue[i]);
                        cell6.Text = strTemp.ToString("0.##") + " " + resVitalsunit[i];
                        dblHet = Convert.ToDouble(resVitalsvalue[i]);
                    }
                    else
                    {
                        cell6.Text = "-";
                    }
                }
                if (resVitalsname[i].ToString() == "Weight")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        cell7.Attributes.Add("align", "left");
                        decimal strTemp = Convert.ToDecimal(resVitalsvalue[i]);
                        cell7.Text = strTemp.ToString("0.##") + " " + resVitalsunit[i];
                        dblWet = Convert.ToDouble(resVitalsvalue[i]);
                    }
                    else
                    {
                        cell7.Text = "-";
                    }
                }

                    if (dblHet != 0 && dblWet !=0)
                    {
                        double dblDiv = (dblHet * dblHet) / 10000;
                        if (dblDiv != 0)
                        {
                            dblBMI = dblWet / dblDiv;
                        }
                        dblHet = 0;
                        dblWet = 0;
                    }
                    //else
                    //{
                    //    cell8.Text = "-";
                    //}
                    if (resVitalsname[i] == "BMI")
                    {
                        if (dblBMI > 0)
                        {
                            cell8.Attributes.Add("align", "left");
                            cell8.Text = "";
                            cell8.Text = dblBMI.ToString("0.##");
                            cell8.Text = cell8.Text;
                           // cell8.Text = cell8.Text + " " + resVitalsunit[i];
                            dblBMI = 0;
                        }
                    }

                if (resVitalsname[i].ToString() == "WaistCircumference")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        dblWC = Convert.ToDouble(resVitalsvalue[i]);
                        cell9.Attributes.Add("align", "left");
                        decimal strTemp = Convert.ToDecimal(resVitalsvalue[i]);
                        cell9.Text = strTemp.ToString("0.##") + " " + resVitalsunit[i];
                    }
                    else
                    {
                        cell9.Text = "-";
                    }
                }
                if (resVitalsname[i].ToString() == "HipCircumference")
                {
                    if (resVitalsvalue[i] != "0.00")
                    {
                        dblHC = Convert.ToDouble(resVitalsvalue[i]);
                        cell10.Attributes.Add("align", "left");
                        decimal strTemp = Convert.ToDecimal(resVitalsvalue[i]);
                        cell10.Text = strTemp.ToString("0.##") + " " + resVitalsunit[i];
                    }
                    else
                    {
                        cell10.Text = "-";
                    }
                }

                if (dblWC != 0 && dblHC != 0)
                {

                    dblWHR = dblWC / dblHC;
                    cell11.Attributes.Add("align", "left");
                    cell11.Text = dblWHR.ToString("0.##");
                    dblWC = 0;
                    dblHC = 0;
                }
                //else
                //{
                //    cell11.Text = "-";
                //}
                if (resVitalsname[i].ToString() == "WHR")
                {
                    cell11.Text = cell11.Text + " " + resVitalsunit[i].ToString();
                }
                //if (resVitalsname[i].ToString() == "WHR")
                //{
                //    cell11.Text = "whr";
                //        //if (dblHC != 0)
                //        //{
                //            dblWHR = dblWC / dblHC;
                //            cell11.Attributes.Add("align", "left");
                //            cell11.Text = dblWHR.ToString() + " " + resVitalsunit[i];
                //       // }
                //        if(dblWHR ==0)
                //        {
                //            cell11.Text = "-";
                //        }
                //}
            }

            if (SBP != "" && DBP != "")
            {
                string strSBP = SBP.Replace(".00", "");
                string strDBP = DBP.Replace(".00", "");
                cell2.Text = strSBP + "/" + strDBP + SBPUnit;
            }
            else
            {
                cell2.Text = "-";
            }


            //if (resVitalsvalue[4] != "0.00")
            //{
            //    cell1.Attributes.Add("align", "left");
            //    cell1.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
            //}
            //else
            //{
            //    cell1.Text = "-";
            //}
            //string SBP = string.Empty;
            //if (resVitalsvalue[2] != "0.00")
            //{

            //    cell2.Attributes.Add("align", "left");
            //    double s1 =Convert.ToDouble(resVitalsvalue[2].ToString());

            //    double s2 = Convert.ToDouble(resVitalsvalue[3].ToString());

            //    SBP = s1.ToString("0") + "/" + s2.ToString("0");
            //    cell2.Text = SBP + " " + resVitalsunit[16];
            //}
            //else
            //{
            //    cell2.Text = "-";
            //}
            ////if (resVitalsvalue[17] != "0.00")
            ////{
            ////    cell2.Attributes.Add("align", "left");
            ////    SBP = SBP + "/" + resVitalsvalue[17];
            ////    string[] resSBP = SBP.Split('.');
            ////    cell2.Text = resSBP[0] + " " + resVitalsvalue[17];
            ////}
            //if (resVitalsvalue[8] != "0.00")
            //{


            //    cell3.Attributes.Add("align", "left");
            //    string DBP = resVitalsvalue[8];
            //    string[] resDBP = DBP.Split('.');
            //    cell3.Text = resDBP[0] + " " + resVitalsunit[8];
            //}
            //else
            //{
            //    cell3.Text = "-";
            //}
            //if (resVitalsvalue[7] != "0.00")
            //{

            //    cell4.Attributes.Add("align", "left");
            //    string Pulse = resVitalsvalue[7];
            //    string[] resPulse = Pulse.Split('.');
            //    cell4.Text = resPulse[0] + " " + resVitalsunit[7];
            //}
            //else
            //{
            //    cell4.Text = "-";
            //}

            //if (resVitalsvalue[1] != "0.00")
            //{
            //    cell5.Attributes.Add("align", "left");
            //    cell5.Text = resVitalsvalue[1] + " " + resVitalsunit[1];

            //    ht= decimal.Parse(resVitalsvalue[1]);
            //}
            //else
            //{
            //    cell5.Text = "-";
            //}
            //if (resVitalsvalue[5] != "0.00")
            //{
            //    cell6.Attributes.Add("align", "left");
            //    cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
            //    wt = decimal.Parse(resVitalsvalue[5]);
            //}
            //else
            //{
            //    cell6.Text = "-";
            //}

            //if (resVitalsvalue[6] != "0.00")
            //{
            //    cell7.Attributes.Add("align", "left");
            //    cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
            //}
            //else
            //{
            //    cell7.Text = "-";
            //}

            //if (resVitalsvalue[9] != "0.00")
            //{

            //    cell8.Attributes.Add("align", "left");
            //    string RR = resVitalsvalue[9];
            //    string[] resRR = RR.Split('.');
            //    cell8.Text = resRR[0] + " " + resVitalsunit[9];
            //}
            //else
            //{
            //    cell8.Text = "-";
            //}
            //if (resVitalsvalue[0] != "0.00")
            //{

            //    cell9.Attributes.Add("align", "left");
            //    string RR = resVitalsvalue[0];
            //    string[] resRR = RR.Split('.');
            //    cell9.Text = resRR[0] + " " + resVitalsunit[0];
            //}
            //else
            //{
            //    cell9.Text = "-";
            //}

            //if (resVitalsvalue[15] != "0.00")
            //{

            //    cell10.Attributes.Add("align", "left");
            //    string RR = resVitalsvalue[15];
            //    string[] resRR = RR.Split('.');
            //    cell10.Text = resRR[0] + " " + resVitalsunit[15];
            //}
            //else
            //{
            //    cell10.Text = "-";
            //}
            ////if (resVitalsvalue[10] != "0.00")
            ////{

            ////    cell11.Attributes.Add("align", "left");
            ////    string RR = resVitalsvalue[10];
            ////    string[] resRR = RR.Split('.');
            ////    cell11.Text = resRR[0] + " " + resVitalsunit[10];
            ////}
            ////else
            ////{
            ////    cell11.Text = "-";
            ////}
            //if (resVitalsvalue[16] != "0.00")
            //{

            //    cell11.Attributes.Add("align", "left");
            //    string RR = resVitalsvalue[16];
            //    string[] resRR = RR.Split('.');
            //    cell11.Text = resRR[0] + " " + resVitalsunit[16];
            //}
            //else
            //{
            //    cell11.Text = "-";
            //}
            //cell12.Text = "-";
            //if (resVitalsvalue[14] != "0.00")
            //{
            //    cell9.Attributes.Add("align", "left");
            //    cell9.Text = resVitalsvalue[14] + " " + resVitalsunit[14];
            //}
            //else
            //{
             //   cell9.Text = "-";
            //}

            //if (resVitalsvalue[15] != "0.00")
            //{
            //    cell10.Attributes.Add("align", "left");
            //    cell10.Text = resVitalsvalue[15] + " " + resVitalsunit[15];
            //}
            //else
            //{
             //  cell10.Text = "-";
            //}
               //if (ht > 0 && wt > 0)
               //{
               //    decimal HtInMtrs = (ht / 100);
               //    bmi = (wt / (HtInMtrs * HtInMtrs));
               //    cell11.Text = bmi.ToString("#.##");
               //}
               //else
               //{
               //    cell11.Text = "-";
               //}
               //if (resVitalsvalue[5] != "0.00" && resVitalsvalue[6] != "0.00")
               //{

               //    double dblDiv = (Convert.ToDouble(resVitalsvalue[5]) * Convert.ToDouble(resVitalsvalue[5])) / 10000;
               //    double dblBMI =(Convert.ToDouble(resVitalsvalue[6]))/dblDiv;
               //    cell11.Text = dblBMI.ToString ("0.##");
               //}
               //if (resVitalsvalue.Count() > 15)
               //{
               //    double dblWaist = Convert.ToDouble(resVitalsvalue[0]);
               //    double dblHip = Convert.ToDouble(resVitalsvalue[15]);
               //    if (dblHip > 0)
               //    {
               //        double dblWHR = dblWaist / dblHip;
               //        cell12.Text = dblWHR.ToString("0.##");
               //    }
               //}
               //else
               //{
               //    cell12.Text = "-";
               //}
            row1.Cells.Add(cell1);
            row1.Cells.Add(cell2);
            row1.Cells.Add(cell3);
            row1.Cells.Add(cell4);
            row1.Cells.Add(cell5);
            row1.Cells.Add(cell6);
            row1.Cells.Add(cell7);
            row1.Cells.Add(cell8);
            row1.Cells.Add(cell9);
            row1.Cells.Add(cell10);
            row1.Cells.Add(cell11);
            //row1.Cells.Add(cell12);
            row1.Style.Add("color", "#000");
            tblAdmissionVitals.Rows.Add(row1);

        }
        #endregion
    }
         catch (Exception ex)
                {
                    CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
                }
    }
}
