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
using Attune.Podium.EMR;

public partial class EMR_History : BaseControl
{

    string ddlName, age, ddlDeliveryName, weight, gnormal, grate, ddlBMaturity, ddlDeliveryNameID, ddlBMaturityID, pastComplication, bgpName, bgpDesc;
    string ddlVaccination, Year, ddlMonth, Doses, Booster, ddlVaccinationid;
    string InvDrugData = string.Empty;

    byte g = 0;
    byte p = 0;
    byte l = 0;
    byte a = 0;
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        //DateTime y;
        //y = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //txtDate.Text = y.ToString("yyyy"); 

        EMR2.DDL=ddlDurationt_1;

        EMR1.DDL = chkTreatment_2;

        EMR3.DDL = ddlDiseaseType_3;

        EMR4.DDL = ddlDuration_5;

        EMR5.DDL = ddlType_6;

        EMR6.DDL = ddlTreatment_7;

        EMR7.DDL = ddlRecovery_9;

        EMR8.DDL = ddlTypeOfCVA_10;

        EMR9.DDL = ddlTypeofcancer_13;

        EMR11.DDL = ddlStageofcancer_14;

        EMR10.DDL = ddlTreatment_15;

        EMR12.DDL = ddlTratment_17;

        EMR13.DDL = ddlExacerbations_18;

        EMR25.DDL = ddlTrait_19;

        EMR14.DDL = ddlDuration_20;

        EMR15.DDL = ddlTypeTS_4;

        EMR16.DDL = ddlTypesAC_12;

        EMR17.DDL = ddlDurationAC;

        EMR26.DDL = ddlPhysicialActivity_22;

        EMR20.DDL = drpVaccination;

        EMR21.DDL = ddlAnaphylacticReaction;

        EMR22.DDL = ddlMenstrualCycle;

        EMR23.DDL = ddlLastPapSmearResult;

        EMR24.DDL = ddlContraception_50;

        EMR27.DDL = ddlTypeofHRT_59;

        EMR28.DDL = ddlHRTDelivery_66;

        EMR33.DDL = ddlBladderType_92;

        EMR34.DDL = ddlDrugSubType_101;

        EMR35.DDL = ddlBowelType_100;

        EMR36.DDL = ddlFHODM_1083;
        if (IsPostBack)
        {
            AutoAllergyName.ContextKey = "N";
            txtAllergyName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            if (chkHighBloodPressure_402.Checked == true)
            {
                divchkHighBloodPressure_402.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkHighBloodPressure_402.Attributes.Add("Style", "Display:None");
            }
            if (chkHeartDisease_332.Checked == true)
            {
                divchkHeartDisease_332.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkHeartDisease_332.Attributes.Add("Style", "Display:None");
            }
            if (chkDiabetesMellitus_389.Checked == true)
            {
                divchkDiabetesMellitus_389.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkDiabetesMellitus_389.Attributes.Add("Style", "Display:None");
            }
            if (chkStroke_438.Checked == true)
            {
                divchkStroke_438.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkStroke_438.Attributes.Add("Style", "Display:None");
            }
            if (chkRaisedCholestrol_409.Checked == true)
            {
                divchkRaisedCholestrol_409.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkRaisedCholestrol_409.Attributes.Add("Style", "Display:None");
            }
            if (chkCancer_372.Checked == true)
            {
                divchkCancer_372.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkCancer_372.Attributes.Add("Style", "Display:None");
            }
            if (chkAsthma_246.Checked == true)
            {
                divchkAsthma_246.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkAsthma_246.Attributes.Add("Style", "Display:None");
            }
            if (chkThalassemiaTrait_536.Checked == true)
            {
                divchkThalassemiaTrait_536.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkThalassemiaTrait_536.Attributes.Add("Style", "Display:None");
            }
            if (chkHepatitisBcarrier_537.Checked == true)
            {
                divchkHepatitisBcarrier_537.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkHepatitisBcarrier_537.Attributes.Add("Style", "Display:None");
            }
            if (chkSurgicalHistory_0.Checked == true)
            {
                divchkSurgicalHistory_0.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkSurgicalHistory_0.Attributes.Add("Style", "Display:None");
            }
            if (chkTS_476.Checked == true)
            {
                divchkTS_476.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkTS_476.Attributes.Add("Style", "Display:None");
            }
            if (chkAC_369.Checked == true)
            {
                divchkAC_369.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkAC_369.Attributes.Add("Style", "Display:None");
            }
            if (chkPA_1059.Checked == true)
            {
                divchkPA_1059.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkPA_1059.Attributes.Add("Style", "Display:None");
            }

            if (chkDrugsHistory_1063.Checked == true)
            {
                divchkDrugsHistory_1063.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkDrugsHistory_1063.Attributes.Add("Style", "Display:None");
            }
            if (chkVaccHis_1064.Checked == true)
            {
                divchkVaccHis_1064.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkVaccHis_1064.Attributes.Add("Style", "Display:None");
            }
            if (chkGynacHis_1065.Checked == true)
            {
                divchkGynacHis_1065.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkGynacHis_1065.Attributes.Add("Style", "Display:None");
            }
            if (chkHRT_1066.Checked == true)
            {
                divchkHRT_1066.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkHRT_1066.Attributes.Add("Style", "Display:None");
            }

            //if (chkDiet_1071.Checked == true)
            //{
            //    divchkDiet_1071.Attributes.Add("Style", "Display:Block");
            //}
            //else
            //{
            //    divchkDiet_1071.Attributes.Add("Style", "Display:None");
            //}

            if (chkBladder_1072.Checked == true)
            {
                divchkBladder_1072.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkBladder_1072.Attributes.Add("Style", "Display:None");
            }

            if (chkDrugSub_1074.Checked == true)
            {
                divchkDrugSub_1074.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkDrugSub_1074.Attributes.Add("Style", "Display:None");
            }

            if (chkBowel_1073.Checked == true)
            {
                divchkBowel_1073.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                divchkBowel_1073.Attributes.Add("Style", "Display:None");
            }
            
        }
    }

    public void EditHistoryData(long visitID)
    {
        //long visitID = -1;
        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;

        //if (Request.QueryString["pvid"] != null)
        //{
        //    Int64.TryParse(Request.QueryString["pvid"], out visitID);
        //}
        //else
        //{
        //    Int64.TryParse(Request.QueryString["vid"], out visitID);
        //}
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        long id1 = 332; long id2 = 402; long id3 = 409;
        try
        {
            if (visitID > 0 != null)
            {
                List<Patient> lstPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                Patient patient = new Patient();
                patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                hdnSex.Value = lstPatient[0].SEX;
                if (lstPatient[0].SEX == "M")
                {
                    tblGynacHis.Style.Add("display", "none");
                    divGH1.Style.Add("display","none");
                    divGH2.Style.Add("display", "none");
                }

                if (id1 == 332)
                {
                    trchkHeartDisease_332.Style.Add("display", "block");
                    tr1chkHeartDisease_332.Style.Add("display", "block");
                }
                if (id2 == 402)
                {
                    trchkHighBloodPressure_402.Style.Add("display", "block");
                    tr1chkHighBloodPressure_402.Style.Add("display", "block");
                }
                if (id3 == 4109)
                {
                    trchkRaisedCholestrol_409.Style.Add("display", "block");
                    tr1chkRaisedCholestrol_409.Style.Add("display", "block");
                }
            }


                List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
                List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
                List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
                List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();

                int rowNumber = 1;
                returnCode = new SmartAccessor(base.ContextInfo).GetPatientHistoryPKGEdit
                    (visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, 
                    out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

                if (lstDrugDetails.Count > 0)
                {
                    chkDrugsHistory_1063.Checked = true;
                    divchkDrugsHistory_1063.Style.Add("display", "block");

                    if (InvDrugData == "Y")
                    {
                        //uIAdv.SetPrescription(lstDrugDetails);
                    }
                    else
                    {
                        uAd.SetPrescription(lstDrugDetails);
                    }
                }


                if (lstPatientPastVaccinationHistory.Count > 0)
                {
                    chkVaccHis_1064.Checked = true;
                    divchkVaccHis_1064.Style.Add("display", "block");
                    string retrivePPV = string.Empty;
                    int ppvCount = 1;
                    for (int l = 0; l < lstPatientPastVaccinationHistory.Count; l++)
                    {
                        ppvCount = ppvCount + 1;

                        ddlVaccination = lstPatientPastVaccinationHistory[l].VaccinationName;
                        ddlVaccinationid = lstPatientPastVaccinationHistory[l].VaccinationID.ToString();
                        Year = lstPatientPastVaccinationHistory[l].YearOfVaccination.ToString();


                        if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 1)
                        {
                            ddlMonth = "January";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 2)
                        {
                            ddlMonth = "Febrauary";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 3)
                        {
                            ddlMonth = "March";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 4)
                        {
                            ddlMonth = "April";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 5)
                        {
                            ddlMonth = "May";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 6)
                        {
                            ddlMonth = "June";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 7)
                        {
                            ddlMonth = "July";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 8)
                        {
                            ddlMonth = "August";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 9)
                        {
                            ddlMonth = "September";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 10)
                        {
                            ddlMonth = "October";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 11)
                        {
                            ddlMonth = "November";
                        }
                        else if (lstPatientPastVaccinationHistory[l].MonthOfVaccination == 12)
                        {
                            ddlMonth = "December";
                        }
                        else
                        {

                        }

                        Doses = lstPatientPastVaccinationHistory[l].VaccinationDose.ToString();

                        if (lstPatientPastVaccinationHistory[l].IsBooster == "N")
                        {
                            Booster = "No";
                        }
                        else if (lstPatientPastVaccinationHistory[l].IsBooster == "Y")
                        {
                            Booster = "Yes";
                        }
                        else
                        {
                        }

                        retrivePPV += ppvCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";

                    }
                    HdnVaccination.Value = retrivePPV;

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ppvTable", "javascript:LoadPriorVaccinationsItems();", true);
                }

            if (lstSurgicalDetails.Count > 0)
            {
                chkSurgicalHistory_0.Checked = true;
                divchkSurgicalHistory_0.Style.Add("display", "block");
                int i = 110;
                DateTime d;
                foreach (SurgicalDetail objS in lstSurgicalDetails)
                {

                    d = Convert.ToDateTime(objS.TreatmentPlanDate);
                       
                  //  hdnSurgeryItems.Value += i + "~" + objS.SurgeryName + "~" + objS.TreatmentPlanDate + "~" + objS.HospitalName + "^";
                    hdnSurgeryItems.Value += i + "~" + objS.SurgeryName + "~" + d.ToString("yyyy")+ "~" + objS.HospitalName + "^";
                    i += 1;
                }

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "STable", "javascript:LoadSurgeryItems();", true);
            }

            for (int i = 0; i < lstPatHisAttribute.Count; i++)
            {
                if (lstPatHisAttribute[i].HistoryID == 476)
                {
                    divchkTS_476.Style.Add("display", "block");
                    chkTS_476.Checked = true;

                    if (lstPatHisAttribute[i].AttributeID == 1)
                    {
                        ddlTypeTS_4.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 4)
                        {
                            divddlTypeTS_4.Style.Add("display", "block");
                            txtOthersTypeTS.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 2)
                    {
                        txtDurationTS.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlTypeTS_4.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 3)
                    {
                        txtPacksTS_9.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                    }
                }
                if (lstPatHisAttribute[i].HistoryID == 1094)
                {
                    
                    chkQuitSmk_4.Checked = true;
                    tdchkQuitSmk_4.Attributes.Add("style", "display:block"); 
                    if (lstPatHisAttribute[i].AttributeID == 52)
                    {
                        txtQuitSmk_4.Text = lstPatHisAttribute[i].AttributeValueName.ToString();  
                    }
                    if (lstPatHisAttribute[i].AttributeID == 53)
                    {
                       
                        ddlQuitSmkDuration.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                }
                if (lstPatHisAttribute[i].HistoryID == 1095)
                {

                    chkQuitAlc_4.Checked = true;
                    tdchkQuitAlc_4.Attributes.Add("style", "display:block");
                    if (lstPatHisAttribute[i].AttributeID == 54)
                    {
                        txtQuitAlc_4.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 55)
                    {

                        ddlQuitAlcDuration.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 369)
                {
                    divchkAC_369.Style.Add("display", "block");
                    chkAC_369.Checked = true;

                    if (lstPatHisAttribute[i].AttributeID == 4)
                    {
                        ddlTypesAC_12.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 12)
                        {
                            divddlTypesAC_12.Style.Add("display", "block");
                            txtOthersTypeAC_17.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 5)
                    {
                        txtDurationAC.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlTypesAC_12.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 6)
                    {
                        txtQtyAC.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1059)
                {
                    divchkPA_1059.Style.Add("display", "block");
                    chkPA_1059.Checked = true;
                    if (lstPatHisAttribute[i].AttributeID == 7)
                    {
                        ddlPhysicialActivity_22.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 8)
                    {
                        chkAerobic.Checked = true;
                        txtAerobic_22.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 9)
                    {
                        chkAnaerobic.Checked = true;
                        txtAnaerobic_23.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 10)
                    {
                        txtNos.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                        if (lstPatHisAttribute[i].AttributeValueName.Split(' ')[1].ToString() == "Min")
                        {
                            ddlHrs.SelectedValue = "24";
                        }
                        else if (lstPatHisAttribute[i].AttributeValueName.Split(' ')[1].ToString() == "Hrs")
                        {
                            ddlHrs.SelectedValue = "25";
                        }
                        ddldays.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                }
                if (hdnAllergy.Value == "")
                {
                    if ((lstPatHisAttribute[i].HistoryID == 1061 || lstPatHisAttribute[i].HistoryID == 1062 ) || (lstPatHisAttribute[i].HistoryID > 1071 && lstPatHisAttribute[i].HistoryID < 1085))
                    {

                        var patHIS = from HisID in lstPatHisAttribute
                                     where ((HisID.HistoryID ==1061 || HisID.HistoryID ==1062) || (HisID.HistoryID > 1071 && HisID.HistoryID < 1085))
                                        group HisID by
                                            new
                                            {
                                                HisID.HistoryID,
                                            }
                                            into grp
                                            select grp;
                        
                        for(int grpID=0;grpID<patHIS.Count();grpID++)
                        {
                            string strCheck = "";
                            foreach (PatientHistoryAttribute pat in lstPatHisAttribute)
                            {
                                if ((lstPatHisAttribute[i].HistoryID == 1061 || lstPatHisAttribute[i].HistoryID == 1062 ) || (lstPatHisAttribute[i].HistoryID > 1071 && lstPatHisAttribute[i].HistoryID < 1085))
                                {
                                    if (pat.HistoryID == patHIS.ElementAt(grpID).Key.HistoryID)
                                    {
                                        if (strCheck == "")
                                        {
                                            hdnAllergy.Value += Convert.ToInt32(pat.AttributevalueID.ToString()) + Convert.ToInt32(1) + "~" + pat.HistoryID + "~" +pat.AttributeID + "~" + pat.AttributeValueName + "~" +  pat.AttributevalueID + "!";
                                            strCheck = "strCheck";
                                        }
                                        else
                                        {
                                            hdnAllergy.Value += pat.AttributeID + "~" + pat.AttributeValueName + "~" + pat.AttributevalueID + "!";
                                        }
                                    }

                                }
                            }
                            string strAller = hdnAllergy.Value.ToString();
                            strAller = strAller.Substring(0, strAller.Length - 1) + "^";
                            hdnAllergy.Value = strAller;

                        }
                    }
                }
                //---------------------GURUNATH.S------------------------
                if (lstPatHisAttribute[i].HistoryID == 1087)
                {
                    if (lstPatHisAttribute[i].AttributeID == 45)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 161)
                        {
                            txtEducation.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 46)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 162)
                        {
                            if (lstPatHisAttribute[i].AttributeValueName == "YES")
                            {
                                chkEducation.Checked = true;
                            }
                            else
                            {
                                chkEducation.Checked = false;
                            }
                        }
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1088)
                {
                    if (lstPatHisAttribute[i].AttributeID == 47)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 163)
                        {
                            txtOccupation.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 48)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 164)
                        {
                            if (lstPatHisAttribute[i].AttributeValueName == "YES")
                            {
                                chkOccupation.Checked = true;
                            }
                            else
                            {
                                chkOccupation.Checked = false;
                            }
                        }
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1089)
                {
                    if (lstPatHisAttribute[i].AttributeID == 49)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 165)
                        {
                            txtIncome.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 50)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 166)
                        {
                            if (lstPatHisAttribute[i].AttributeValueName == "YES")
                            {
                                chkIncome.Checked = true;
                            }
                            else
                            {
                                chkIncome.Checked = false;
                            }
                        }
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1090)
                {
                    if (lstPatHisAttribute[i].AttributeID == 51)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 167)
                        {
                            txtMarital.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 52)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 168)
                        {
                            if (lstPatHisAttribute[i].AttributeValueName == "YES")
                            {
                                chkMarital.Checked = true;
                            }
                            else
                            {
                                chkMarital.Checked = false;
                            }
                        }
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1091)
                {
                    if (lstPatHisAttribute[i].AttributeID == 53)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 169)
                        {
                            txtOthers.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributeID == 54)
                    {
                        if (lstPatHisAttribute[i].AttributevalueID == 170)
                        {
                            if (lstPatHisAttribute[i].AttributeValueName == "YES")
                            {
                                chkOthersDetails.Checked = true;
                            }
                            else
                            {
                                chkOthersDetails.Checked = false;
                            }
                        }
                    }
                }
                //-----------------------------------------------------------------------------------------------
                //if (lstPatHisAttribute[i].HistoryID == 1085)
                //{
                //    divchkDiet_1071.Style.Add("display", "block");
                //    chkDiet_1071.Checked = true;
                //    txtOthersTypeDiet_84.Text = lstPatHisAttribute[i].AttributeValueName.Replace("<br/>", "");
                //}
                if (lstPatHisAttribute[i].HistoryID == 1092)
                {
                    if (lstPatHisAttribute[i].AttributeValueName != "")
                    {
                        txtPresentComplaints.Text = lstPatHisAttribute[i].AttributeValueName.Replace("<br/>", ""); 
                    }
                    
                }
                if (lstPatHisAttribute[i].HistoryID == 1071)
                {
                    divchkBladder_1072.Style.Add("display", "block");
                    chkBladder_1072.Checked = true;
                    if (lstPatHisAttribute[i].AttributeID == 29)
                    {
                        ddlBladderType_92.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 95)
                        {
                            divddlBladderType_92.Style.Add("display", "block");
                            txtOthersTypeBladder_92.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                }


                if (lstPatHisAttribute[i].HistoryID == 1085)
                {
                    divchkBowel_1073.Style.Add("display", "block");
                    chkBowel_1073.Checked = true;
                    if (lstPatHisAttribute[i].AttributeID == 113)
                    {
                        ddlBowelType_100.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 222)
                        {
                            divddlBowelType_100.Style.Add("display", "block");
                            txtOthersTypeBowel_100.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                }

                if (lstPatHisAttribute[i].HistoryID == 1096)
                {
                    divchkDrugSub_1074.Style.Add("display", "block");
                    chkDrugSub_1074.Checked = true;
                    txtOthersTypeDrugSub_101.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                }

                if (lstPatHisAttribute[i].HistoryID == 1069)
                {
                    if (lstPatHisAttribute[i].AttributeID == 27)
                    {
                        
                        chkDiabetesMellitus_389.Checked = true;
                        ddlFHODM_1083.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        txtFHODM_1083.Style.Add("display", "none");
                        if (lstPatHisAttribute[i].AttributevalueID.ToString() == "84")
                        {
                            txtFHODM_1083.Style.Add("display", "block");
                            string strFHO = lstPatHisAttribute[i].AttributeValueName.ToString();
                            string strFHOPres = strFHO.Replace("Present", "");
                            strFHOPres = strFHOPres.Replace(" - ", "");
                            txtFHODM_1083.Text = strFHOPres.Replace(";","");
                        }
                        if (lstPatHisAttribute[i].AttributevalueID.ToString() == "85")
                        {
                            txtFHODM_1083.Style.Add("display", "block");
                            string strFHO = lstPatHisAttribute[i].AttributeValueName.ToString();
                            string strFHOPres = strFHO.Replace("Insignificant", "");
                            txtFHODM_1083.Text = strFHOPres;
                        }
                    }
                }
                if (lstPatHisAttribute[i].HistoryID == 1093)
                {
                    txtHOHypoglycemia_1084.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                }

                if (lstPatHisAttribute[i].HistoryID == 1070)
                {
                    hdnFamilyHistory.Value = lstPatHisAttribute[i].AttributeValueName.ToString();
                    chkFamilyHistory_1085.Checked = true;
                    ScriptManager.RegisterStartupScript(this.Page, GetType(), "", "CreateTab();", true);
                }


                if (lstPatHisAttribute[i].HistoryID == 1065)
                {
                    chkGynacHis_1065.Checked = true;
                    divchkGynacHis_1065.Style.Add("display", "block");

                    if (lstPatHisAttribute[i].AttributevalueID == 38)
                    {
                        tLMP_38.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 14)
                    {
                        ddlMenstrualCycle.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributevalueID == 45)
                    {
                        txtCycleLength_45.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributevalueID == 46)
                    {
                        txtLastPapSmearDt_46.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributevalueID == 47)
                    {
                        txtAgeofMenarchy_47.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 19)
                    {
                        ddlLastPapSmearResult.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributeID == 17)
                    {
                        ddlContraception_50.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 50)
                        {
                            divddlContraception_50.Style.Add("display", "block");
                            txtContraceptionOthers_50.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    if (lstPatHisAttribute[i].AttributevalueID == 55)
                    {
                        txtLastMammogramResultDt_55.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                    if (lstPatHisAttribute[i].AttributevalueID == 56)
                    {
                        txtLastMammogramResult_56.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                    }
                }
                if (lstPatHisAttribute[i].HistoryID == 1066)
                {
                    chkHRT_1066.Checked = true;
                    divchkHRT_1066.Style.Add("display", "block");
                    if (lstPatHisAttribute[i].AttributeID == 22)
                    {
                        ddlTypeofHRT_59.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 59)
                        {
                            divddlTypeofHRT_59.Style.Add("display", "none");
                            txtOthersTypeofHRT_59.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }

                    if (lstPatHisAttribute[i].AttributeID == 23)
                    {
                        ddlHRTDelivery_66.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        if (lstPatHisAttribute[i].AttributevalueID == 66)
                        {
                            divddlHRTDelivery_66.Style.Add("display", "none");
                            txtOthersHRTDelivery_66.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                }
                
            }
            if (hdnAllergy.Value.ToString() != string.Empty)
            {
                 ScriptManager.RegisterStartupScript(this.Page, GetType(), "ss", "javascript:fnLoadTab();", true);
            }

            if (lstPCA.Count > 0)
            {
                for (int j = 0; j < lstPCA.Count; j++)
                {
                    if (lstPCA[j].ComplaintID == 402)
                    {
                        divchkHighBloodPressure_402.Style.Add("display", "block");
                        chkHighBloodPressure_402.Checked = true;

                        if (lstPCA[j].AttributeID == 1)
                        {
                            txtDuration_1.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlDurationt_1.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 2)
                        {
                            var lstCN = from Res in lstPCA
                                        where Res.AttributeID == 2
                                        select Res;

                            foreach (ListItem liComp in chkTreatment_2.Items)
                            {
                                foreach (PatientComplaintAttribute objlstCN in lstCN)
                                {
                                    if (liComp.Value == objlstCN.AttributevalueID.ToString())
                                    {
                                        liComp.Selected = true;
                                    }
                                }
                            }
                        }

                        if (lstPCA[j].AttributevalueID == 9)
                        {
                            divchkOthers_9.Style.Add("display", "block");
                            chkOthers_9.Checked = true;
                            txtOthers_9.Text = lstPCA[j].AttributeValueName;
                        }

                    }
                    if (lstPCA[j].ComplaintID == 332)
                    {
                        divchkHeartDisease_332.Style.Add("display", "block");
                        chkHeartDisease_332.Checked = true;
                        if (lstPCA[j].AttributeID == 3)
                        {
                            ddlDiseaseType_3.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            if (lstPCA[j].AttributevalueID == 16)
                            {
                                divddlDiseaseType_3.Style.Add("display", "block");
                                txtothers_16.Text = lstPCA[j].AttributeValueName.ToString();
                            }
                        }
                        if (lstPCA[j].AttributeID == 4)
                        {
                            txtDisease_17.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                    }
                    if (lstPCA[j].ComplaintID == 389)
                    {
                        divchkDiabetesMellitus_389.Style.Add("display", "block");
                        chkDiabetesMellitus_389.Checked = true;
                        if (lstPCA[j].AttributeID == 5)
                        {
                            txtDuration_5.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlDuration_5.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 6)
                        {
                            ddlType_6.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 7)
                        {
                            ddlTreatment_7.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            if (lstPCA[j].AttributevalueID == 68)
                            {
                                divddlTreatment_7.Style.Add("display", "block");
                                txtothers_68.Text = lstPCA[j].AttributeValueName.ToString();
                            }
                        }
                    }
                    if (lstPCA[j].ComplaintID == 438)
                    {
                        divchkStroke_438.Style.Add("display", "block");
                        chkStroke_438.Checked = true;
                        if (lstPCA[j].AttributeID == 8)
                        {
                            txtDate_30.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        if (lstPCA[j].AttributeID == 9)
                        {
                            ddlRecovery_9.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 10)
                        {
                            ddlTypeOfCVA_10.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 11)
                        {
                            txtLobeaffected_36.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                    }

                    if (lstPCA[j].ComplaintID == 409)
                    {
                        divchkRaisedCholestrol_409.Style.Add("display", "block");
                        chkRaisedCholestrol_409.Checked = true;
                        if (lstPCA[j].AttributeID == 12)
                        {
                            txtduration_12.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlduration_12.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }

                    }

                    if (lstPCA[j].ComplaintID == 372)
                    {
                        divchkCancer_372.Style.Add("display", "block");
                        chkCancer_372.Checked = true;
                        if (lstPCA[j].AttributeID == 13)
                        {
                            ddlTypeofcancer_13.Text = lstPCA[j].AttributevalueID.ToString();

                            if (lstPCA[j].AttributevalueID == 72)
                            {
                                divddlTypeofcancer_13.Style.Add("display", "block");
                                txtothers_72.Text = lstPCA[j].AttributeValueName.ToString();
                            }
                        }
                        if (lstPCA[j].AttributeID == 14)
                        {
                            ddlStageofcancer_14.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 15)
                        {
                            ddlTreatment_15.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            if (lstPCA[j].AttributevalueID == 73)
                            {
                                divddlTreatment_15.Style.Add("display", "block");
                                txtothers_73.Text = lstPCA[j].AttributeValueName.ToString();
                            }
                        }
                    }

                    if (lstPCA[j].ComplaintID == 246)
                    {
                        divchkAsthma_246.Style.Add("display", "block");
                        chkAsthma_246.Checked = true;
                        if (lstPCA[j].AttributeID == 16)
                        {
                            txtDuration_16.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlDuration_16.Text = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 17)
                        {
                            ddlTratment_17.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 18)
                        {
                            chkExacerbations_18.Checked = true;
                            txtTimes_18.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlExacerbations_18.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                    }

                    if (lstPCA[j].ComplaintID == 536)
                    {
                        divchkThalassemiaTrait_536.Style.Add("display", "block");
                        chkThalassemiaTrait_536.Checked = true;
                        if (lstPCA[j].AttributeID == 19)
                        {
                            ddlTrait_19.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                    }

                    if (lstPCA[j].ComplaintID == 537)
                    {
                        divchkHepatitisBcarrier_537.Style.Add("display", "block");
                        chkHepatitisBcarrier_537.Checked = true;
                        if (lstPCA[j].AttributeID == 20)
                        {
                            txtDuration_20.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlDuration_20.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 21)
                        {
                            txtTreatment_66.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                    }
                    if (lstPCA[j].ComplaintID == 207)
                    {
                        divchkThyroid_207.Style.Add("display", "block");
                        chkThyroid_207.Checked = true;
                        if (lstPCA[j].AttributeID == 25)
                        {
                            ddlThyroid_40.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 26)
                        {
                            txtDuration_40.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                            ddlDuration_40.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                        }
                        if (lstPCA[j].AttributeID == 27)
                        {
                            ddlThyroidTreatment_40.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            if (lstPCA[j].AttributevalueID == 93)
                             {
                                 divddlThyroidTreatment_40.Style.Add("display", "block");
                                 txtThyroidTreatmentOther_40.Text = lstPCA[j].AttributeValueName.ToString();
                             }
                        }

                    }
                    if (lstPCA[j].ComplaintID == 946)
                    {
                        if (lstPCA[j].AttributeValueName.ToString() != "")
                        {
                            divchkTuberculosis_946.Style.Add("display", "block");
                            chkTuberculosis_946.Checked = true;
                            txtTuberculosis_946.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        else
                        {
                            txtTuberculosis_946.Text = "";
                        }
                    }

                    if (lstPCA[j].ComplaintID == 181)
                    {
                        if (lstPCA[j].AttributeValueName.ToString() != "")
                        {
                            divchkPVD_181.Style.Add("display", "block");
                            chkPVD_181.Checked = true;
                            txtPVD_181.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        else
                        {
                            txtPVD_181.Text = "";
                        }
                    }


                    if (lstPCA[j].ComplaintID == 32)
                    {
                        if (lstPCA[j].AttributeValueName.ToString() != "")
                        {
                            divchkRenal_32.Style.Add("display", "block");
                            chkRenal_32.Checked = true;
                            txtRenal_32.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        else
                        {
                            txtRenal_32.Text = "";
                        }
                    }


                    if (lstPCA[j].ComplaintID == 78)
                    {
                        if (lstPCA[j].AttributeValueName.ToString() != "")
                        {
                            divchkLiver_78.Style.Add("display", "block");
                            chkLiver_78.Checked = true;
                            txtLiver_78.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        else
                        {
                            txtLiver_78.Text = "";
                        }
                    }
                    if (lstPCA[j].ComplaintID == 945)
                    {
                        if (lstPCA[j].AttributeValueName.ToString() != "")
                        {
                            divchkOtherDisease_945.Style.Add("display", "block");
                            chkOtherDisease_945.Checked = true;
                            txtOtherDisease_945.Text = lstPCA[j].AttributeValueName.ToString();
                        }
                        else
                        {
                            txtOtherDisease_945.Text = "";
                        }
                    }

                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }


    }

    public void LoadHistoryData(long visitID)
    {
        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;
           
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        
        long id1 = 332; long id2 = 402; long id3 = 409;

        try
        {
            if (visitID > 0)
            {
                List<Patient> lstPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                Patient patient = new Patient();
                patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                hdnSex.Value = lstPatient[0].SEX;
                if (lstPatient[0].SEX == "M")
                {
                    tblGynacHis.Style.Add("display", "none");
                    divGH1.Style.Add("display", "none");
                    divGH2.Style.Add("display", "none");
                }
                if (id1 == 332)
                {
                    trchkHeartDisease_332.Style.Add("display", "block");
                    tr1chkHeartDisease_332.Style.Add("display", "block");
                }
                if (id2 == 402)
                {
                    trchkHighBloodPressure_402.Style.Add("display", "block");
                    tr1chkHighBloodPressure_402.Style.Add("display", "block");
                }
                if (id3 == 409)
                {
                    trchkRaisedCholestrol_409.Style.Add("display", "block");
                    tr1chkRaisedCholestrol_409.Style.Add("display", "block");
                }
            }


            List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
            List<PatientHistoryAttribute> lsthisPHA= new List<PatientHistoryAttribute>();
            List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
            List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
            List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
            List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
            List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();


            returnCode = new SmartAccessor(base.ContextInfo).GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

            if (lstANCPatientDetails.Count > 0)
            {
            }

                var lstFHO = from s in lsthisPHA
                               where s.HistoryID == 1069
                               select s;

                List<EMRAttributeClass> lstFHOtype = (from d in lstFHO
                                                        where d.AttributeID == 27
                                                        select new EMRAttributeClass
                                                        {
                                                            AttributeName = d.AttributeName,
                                                            AttributevalueID = d.AttributevalueID,
                                                            AttributeValueName = d.AttributeValueName
                                                        }).ToList();

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "F/H/O DM";
                lstEMRvalue.Attributeid = 27;
                lstEMRvalue.Attributevaluename = lstFHOtype[0].AttributeName;

                ddlFHODM_1083.DataSource = lstFHO.ToList();
                ddlFHODM_1083.DataTextField = "AttributeValueName";
                ddlFHODM_1083.DataValueField = "AttributevalueID";
                ddlFHODM_1083.DataBind();
                ddlFHODM_1083.Items.Insert (0, "---Select---");
                EMR36.Bind(lstEMRvalue,lstFHOtype);
                
                var lstBladder = from s in lsthisPHA
                             where s.HistoryID == 1071
                             select s;

                List<EMRAttributeClass> lstBladderType = (from d in lstBladder
                                                          where d.AttributeID == 29
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = d.AttributeName,
                                                              AttributevalueID = d.AttributevalueID,
                                                              AttributeValueName = d.AttributeValueName
                                                          }).ToList();

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Bladder";
                lstEMRvalue.Attributeid = 29;
                lstEMRvalue.Attributevaluename = lstBladderType[0].AttributeName;
                EMR33.Bind(lstEMRvalue, lstBladderType);

                ddlBladderType_92.DataSource = lstBladder.ToList();
                ddlBladderType_92.DataTextField = "AttributeValueName";
                ddlBladderType_92.DataValueField = "AttributevalueID";
                ddlBladderType_92.DataBind();
                ddlBladderType_92.Items.Insert(0, "---Select---");
                

                var lstBowel = from s in lsthisPHA
                             where s.HistoryID == 1085
                             select s;

                List<EMRAttributeClass> lstBowelType = (from d in lstBowel
                                                          where d.AttributeID == 113
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = d.AttributeName,
                                                              AttributevalueID = d.AttributevalueID,
                                                              AttributeValueName = d.AttributeValueName
                                                          }).ToList();

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Bowel";
                lstEMRvalue.Attributeid = 113;
                lstEMRvalue.Attributevaluename = lstBowelType[0].AttributeName;
                EMR35.Bind(lstEMRvalue, lstBowelType);

                ddlBowelType_100.DataSource = lstBowel.ToList();
                ddlBowelType_100.DataTextField = "AttributeValueName";
                ddlBowelType_100.DataValueField = "AttributevalueID";
                ddlBowelType_100.DataBind();
                ddlBowelType_100.Items.Insert(0, "---Select---");


                //var lstAllerDur = from s in lsthisPHA
                //               where s.HistoryID > 1085
                //               select s;

                //List<EMRAttributeClass> lstAllerDurType = (from d in lstAllerDur
                //                                        where d.AttributeID == 87
                //                                        select new EMRAttributeClass
                //                                        {
                //                                            AttributeName = d.AttributeName,
                //                                            AttributevalueID = d.AttributevalueID,
                //                                            AttributeValueName = d.AttributeValueName
                //                                        }).ToList();

                //lstEMRvalue.Name = "History";
                //lstEMRvalue.Attributename = "Allergy";
                //lstEMRvalue.Attributeid = 87;
                //lstEMRvalue.Attributevaluename = lstAllerDurType[0].AttributeName;
                ////EMR35.Bind(lstEMRvalue, lstAllerDurType);

                //ddlAllDuration.DataSource = lstAllerDur.ToList();
                //ddlAllDuration.DataTextField = "AttributeValueName";
                //ddlAllDuration.DataValueField = "AttributevalueID";
                //ddlAllDuration.DataBind();
                //ddlAllDuration.Items.Insert(0, "---Select---");


                var lsttobocco = from s in lsthisPHA
                          where s.HistoryID == 476
                          select s;

                List<EMRAttributeClass> lsttoboccotype = (from d in lsttobocco
                                  where d.AttributeID == 1
                                 select new EMRAttributeClass
                           {
                               AttributeName =d.AttributeName,
                               AttributevalueID = d.AttributevalueID,
                               AttributeValueName = d.AttributeValueName
                           }).ToList();

                

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Tobacco";
                lstEMRvalue.Attributeid = 1;
                lstEMRvalue.Attributevaluename = lsttoboccotype[0].AttributeName;
                EMR15.Bind(lstEMRvalue, lsttoboccotype);

                ddlTypeTS_4.DataSource = lsttoboccotype.ToList();
                ddlTypeTS_4.DataTextField = "AttributeValueName";
                ddlTypeTS_4.DataValueField = "AttributevalueID";
                ddlTypeTS_4.DataBind();
                ddlTypeTS_4.Items.Insert(0, "---Select---");

                List<EMRAttributeClass> lsttoboccoduration = (from d in lsttobocco
                                     where d.AttributeID == 2
                                     select new EMRAttributeClass
                           {
                               AttributeName =d.AttributeName,
                               AttributevalueID = d.AttributevalueID,
                               AttributeValueName = d.AttributeValueName
                           }).ToList();           
                


                ddlDurationTS.DataSource = lsttoboccoduration.ToList();
                ddlDurationTS.DataTextField = "AttributeValueName";
                ddlDurationTS.DataValueField = "AttributevalueID";
                ddlDurationTS.DataBind();

                var lstalcohol = from s in lsthisPHA
                             where s.HistoryID == 369
                             select s;

                List<EMRAttributeClass> lstalcoholduration = (from d in lstalcohol
                                         where d.AttributeID == 4
                                        select new EMRAttributeClass
                           {
                               AttributeName =d.AttributeName,
                               AttributevalueID = d.AttributevalueID,
                               AttributeValueName = d.AttributeValueName
                           }).ToList();
                            
                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Alcohol";
                lstEMRvalue.Attributeid = 4;
                lstEMRvalue.Attributevaluename = lstalcoholduration[0].AttributeName;
                EMR16.Bind(lstEMRvalue, lstalcoholduration);


                ddlTypesAC_12.DataSource = lstalcoholduration.ToList();
                ddlTypesAC_12.DataTextField = "AttributeValueName";
                ddlTypesAC_12.DataValueField = "AttributevalueID";
                ddlTypesAC_12.DataBind();
                ddlTypesAC_12.Items.Insert(0, "---Select---");

                List<EMRAttributeClass> lstalcoholtype = (from d in lstalcohol
                                         where d.AttributeID == 5
                                         select new EMRAttributeClass
                           {
                               AttributeName =d.AttributeName,
                               AttributevalueID = d.AttributevalueID,
                               AttributeValueName = d.AttributeValueName
                           }).ToList();


                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Alcohol";
                lstEMRvalue.Attributeid = 5;
                lstEMRvalue.Attributevaluename = lstalcoholtype[0].AttributeName;
                EMR17.Bind(lstEMRvalue, lstalcoholtype);

                ddlDurationAC.DataSource = lstalcoholtype.ToList();
                ddlDurationAC.DataTextField = "AttributeValueName";
                ddlDurationAC.DataValueField = "AttributevalueID";
                ddlDurationAC.DataBind();

                var lstvaccination = from s in lsthisPHA
                              where s.HistoryID == 1064
                              select s;

                List<EMRAttributeClass> vaccination = (from d in lstvaccination
                                                             where d.AttributeID == 121
                                                             select new EMRAttributeClass
                                                             {
                                                                 AttributeName = d.AttributeName,
                                                                 AttributevalueID = d.AttributevalueID,
                                                                 AttributeValueName = d.AttributeValueName
                                                             }).ToList();

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Vaccination";
                lstEMRvalue.Attributeid = 121;
                lstEMRvalue.Attributevaluename = vaccination[0].AttributeName;
                EMR20.Bind(lstEMRvalue, vaccination);
                

                drpVaccination.DataSource = vaccination.ToList();
                drpVaccination.DataTextField = "AttributeValueName";
                drpVaccination.DataValueField = "AttributevalueID";
                drpVaccination.DataBind();
                drpVaccination.Items.Insert(0, "--Select--");

                List<EMRAttributeClass> reaction = (from d in lstvaccination
                                                       where d.AttributeID == 122
                                                       select new EMRAttributeClass
                                                       {
                                                           AttributeName = d.AttributeName,
                                                           AttributevalueID = d.AttributevalueID,
                                                           AttributeValueName = d.AttributeValueName
                                                       }).ToList();

                lstEMRvalue.Name = "History";
                lstEMRvalue.Attributename = "Vaccination";
                lstEMRvalue.Attributeid = 122;
                lstEMRvalue.Attributevaluename = reaction[0].AttributeName;
                EMR21.Bind(lstEMRvalue, reaction);


                ddlAnaphylacticReaction.DataSource = reaction.ToList();
                ddlAnaphylacticReaction.DataTextField = "AttributeValueName";
                ddlAnaphylacticReaction.DataValueField = "AttributevalueID";
                ddlAnaphylacticReaction.DataBind();
                ddlAnaphylacticReaction.Items.Insert(0, "--Select--");

            var lstphysical = from s in lsthisPHA
                             where s.HistoryID == 1059
                             select s;

            List<EMRAttributeClass> physicialactivity = (from d in lstphysical
                                    where d.AttributeID == 7
                                   select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Physical Activity";
            lstEMRvalue.Attributeid = 7;
            lstEMRvalue.Attributevaluename = physicialactivity[0].AttributeName;
            EMR26.Bind(lstEMRvalue, physicialactivity);


            ddlPhysicialActivity_22.DataSource = physicialactivity.ToList();
            ddlPhysicialActivity_22.DataTextField = "AttributeValueName";
            ddlPhysicialActivity_22.DataValueField = "AttributevalueID";
            ddlPhysicialActivity_22.DataBind();

            var lstheart = from s in lsthisPCA
                              where s.ComplaintID == 332
                              select s;

            List<EMRAttributeClass> diseasetype = (from d in lstheart
                                    where d.AttributeID == 3
                                   select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Diseasetype";
            lstEMRvalue.Attributeid = 3;
            lstEMRvalue.Attributevaluename = diseasetype[0].AttributeName;
            EMR3.Bind(lstEMRvalue, diseasetype);

            ddlDiseaseType_3.DataSource = diseasetype.ToList();
            ddlDiseaseType_3.DataTextField = "AttributeValueName";
            ddlDiseaseType_3.DataValueField = "AttributevalueID";
            ddlDiseaseType_3.DataBind();

            var lstdiabetics = from s in lsthisPCA
                           where s.ComplaintID == 389
                           select s;

            List<EMRAttributeClass> diabeticsetreatment = (from d in lstdiabetics
                                      where d.AttributeID == 7
                                    select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Diabetics";
            lstEMRvalue.Attributeid = 7;
            lstEMRvalue.Attributevaluename = diabeticsetreatment[0].AttributeName;
            EMR6.Bind(lstEMRvalue, diabeticsetreatment);


            ddlTreatment_7.DataSource = diabeticsetreatment.ToList();
            ddlTreatment_7.DataTextField = "AttributeValueName";
            ddlTreatment_7.DataValueField = "AttributevalueID";
            ddlTreatment_7.DataBind();

            List<EMRAttributeClass> diabeticsduration = (from d in lstdiabetics
                              where d.AttributeID == 5
                            select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();

            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Diabetics";
            lstEMRvalue.Attributeid = 5;
            lstEMRvalue.Attributevaluename = diabeticsduration[0].AttributeName;
            EMR4.Bind(lstEMRvalue, diabeticsduration);


            ddlDuration_5.DataSource = diabeticsduration.ToList();
            ddlDuration_5.DataTextField = "AttributeValueName";
            ddlDuration_5.DataValueField = "AttributevalueID";
            ddlDuration_5.DataBind();

            List<EMRAttributeClass> diabeticsetype = (from d in lstdiabetics
                                 where d.AttributeID == 6
                                 select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Diabetics";
            lstEMRvalue.Attributeid = 6;
            lstEMRvalue.Attributevaluename = diabeticsetype[0].AttributeName;
            EMR5.Bind(lstEMRvalue, diabeticsetype);


            ddlType_6.DataSource = diabeticsetype.ToList();
            ddlType_6.DataTextField = "AttributeValueName";
            ddlType_6.DataValueField = "AttributevalueID";
            ddlType_6.DataBind();

            var lststroke = from s in lsthisPCA
                               where s.ComplaintID == 438
                               select s;

            List<EMRAttributeClass> strokerecovery = (from d in lststroke
                                      where d.AttributeID == 9
                                     select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Stroke";
            lstEMRvalue.Attributeid = 9;
            lstEMRvalue.Attributevaluename = strokerecovery[0].AttributeName;
            EMR7.Bind(lstEMRvalue, strokerecovery);


            ddlRecovery_9.DataSource = strokerecovery.ToList();
            ddlRecovery_9.DataTextField = "AttributeValueName";
            ddlRecovery_9.DataValueField = "AttributevalueID";
            ddlRecovery_9.DataBind();

            List<EMRAttributeClass> strokecva = (from d in lststroke
                                 where d.AttributeID == 10
                                select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Stroke";
            lstEMRvalue.Attributeid = 10;
            lstEMRvalue.Attributevaluename = strokecva[0].AttributeName;
            EMR8.Bind(lstEMRvalue, strokecva);


            ddlTypeOfCVA_10.DataSource = strokecva.ToList();
            ddlTypeOfCVA_10.DataTextField = "AttributeValueName";
            ddlTypeOfCVA_10.DataValueField = "AttributevalueID";
            ddlTypeOfCVA_10.DataBind();

            var lstcancer = from s in lsthisPCA
                            where s.ComplaintID == 372
                            select s;

            List<EMRAttributeClass> cancertype = (from d in lstcancer
                                 where d.AttributeID == 13
                                select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();

            
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Cancer";
            lstEMRvalue.Attributeid = 13;
            lstEMRvalue.Attributevaluename = cancertype[0].AttributeName;
            EMR9.Bind(lstEMRvalue, cancertype);


            ddlTypeofcancer_13.DataSource = cancertype.ToList();
            ddlTypeofcancer_13.DataTextField = "AttributeValueName";
            ddlTypeofcancer_13.DataValueField = "AttributevalueID";
            ddlTypeofcancer_13.DataBind();


            List<EMRAttributeClass> cancerstage = (from d in lstcancer
                            where d.AttributeID == 14
                           select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();

            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Cancer";
            lstEMRvalue.Attributeid = 13;
            lstEMRvalue.Attributevaluename = cancerstage[0].AttributeName;
            EMR11.Bind(lstEMRvalue, cancerstage);


            ddlStageofcancer_14.DataSource = cancerstage.ToList();
            ddlStageofcancer_14.DataTextField = "AttributeValueName";
            ddlStageofcancer_14.DataValueField = "AttributevalueID";
            ddlStageofcancer_14.DataBind();

            List<EMRAttributeClass> cancertreatment = (from d in lstcancer
                              where d.AttributeID == 15
                              select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();

            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Cancer";
            lstEMRvalue.Attributeid = 15;
            lstEMRvalue.Attributevaluename = cancertreatment[0].AttributeName;
            EMR10.Bind(lstEMRvalue, cancertreatment);


            ddlTreatment_15.DataSource = cancertreatment.ToList();
            ddlTreatment_15.DataTextField = "AttributeValueName";
            ddlTreatment_15.DataValueField = "AttributevalueID";
            ddlTreatment_15.DataBind();

            var lstasthma= from s in lsthisPCA
                            where s.ComplaintID == 246
                            select s;

            List<EMRAttributeClass> asthmatreatment = (from d in lstasthma
                                 where d.AttributeID == 17
                                 select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
            
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Asthma";
            lstEMRvalue.Attributeid = 17;
            lstEMRvalue.Attributevaluename = asthmatreatment[0].AttributeName;
            EMR12.Bind(lstEMRvalue, asthmatreatment);


            ddlTratment_17.DataSource = asthmatreatment.ToList();
            ddlTratment_17.DataTextField = "AttributeValueName";
            ddlTratment_17.DataValueField = "AttributevalueID";
            ddlTratment_17.DataBind();

            List<EMRAttributeClass> asthmaduration = (from d in lstasthma
                            where d.AttributeID == 16
                            select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Asthma";
            lstEMRvalue.Attributeid = 16;
            lstEMRvalue.Attributevaluename = asthmaduration[0].AttributeName;
            EMR31.Bind(lstEMRvalue, asthmaduration);


            ddlDuration_16.DataSource = asthmaduration.ToList();
            ddlDuration_16.DataTextField = "AttributeValueName";
            ddlDuration_16.DataValueField = "AttributevalueID";
            ddlDuration_16.DataBind();

            List<EMRAttributeClass> asthmaExacerbations = (from d in lstasthma
                            where d.AttributeID == 18
                           select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
            
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "asthma";
            lstEMRvalue.Attributeid = 18;
            lstEMRvalue.Attributevaluename = asthmaExacerbations[0].AttributeName;
            EMR13.Bind(lstEMRvalue, asthmaExacerbations);


            ddlExacerbations_18.DataSource = asthmaExacerbations.ToList();
            ddlExacerbations_18.DataTextField = "AttributeValueName";
            ddlExacerbations_18.DataValueField = "AttributevalueID";
            ddlExacerbations_18.DataBind();

            var lsttrait = from s in lsthisPCA
                           where s.ComplaintID == 536
                           select s;

            List<EMRAttributeClass> trait = (from d in lsttrait
                                  where d.AttributeID == 19
                                  select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Trait";
            lstEMRvalue.Attributeid = 19;
            lstEMRvalue.Attributevaluename = trait[0].AttributeName;
            EMR25.Bind(lstEMRvalue, trait);


            ddlTrait_19.DataSource = trait.ToList();
            ddlTrait_19.DataTextField = "AttributeValueName";
            ddlTrait_19.DataValueField = "AttributevalueID";
            ddlTrait_19.DataBind();
            ddlTrait_19.Items.Insert(0, "---Select---");
            var lsthepathisis = from s in lsthisPCA
                           where s.ComplaintID == 537
                           select s;

            List<EMRAttributeClass> hepathisis = (from d in lsthepathisis
                        where d.AttributeID == 20
                        select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
            
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Hepathisis";
            lstEMRvalue.Attributeid = 20;
            lstEMRvalue.Attributevaluename = hepathisis[0].AttributeName;
            EMR14.Bind(lstEMRvalue, hepathisis);


            ddlDuration_20.DataSource = hepathisis.ToList();
            ddlDuration_20.DataTextField = "AttributeValueName";
            ddlDuration_20.DataValueField = "AttributevalueID";
            ddlDuration_20.DataBind();


            var lstThyroid = from s in lsthisPCA
                            where s.ComplaintID == 207
                            select s;

            List<EMRAttributeClass> ThyroidType = (from d in lstThyroid
                                                  where d.AttributeID == 25
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeName = d.AttributeName,
                                                      AttributevalueID = d.AttributevalueID,
                                                      AttributeValueName = d.AttributeValueName
                                                  }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Thyroid";
            lstEMRvalue.Attributeid = 25;
            lstEMRvalue.Attributevaluename = ThyroidType[0].AttributeName;
            EMR9.Bind(lstEMRvalue, cancertype);


            ddlThyroid_40.DataSource = ThyroidType.ToList();
            ddlThyroid_40.DataTextField = "AttributeValueName";
            ddlThyroid_40.DataValueField = "AttributevalueID";
            ddlThyroid_40.DataBind();
            ddlThyroid_40.Items.Insert(0, "---Select---");




            var lstThyroidDuration = from s in lsthisPCA
                             where s.ComplaintID == 207
                             select s;

            List<EMRAttributeClass> lstThyroidDurationType = (from d in lstThyroidDuration
                                                   where d.AttributeID == 26
                                                   select new EMRAttributeClass
                                                   {
                                                       AttributeName = d.AttributeName,
                                                       AttributevalueID = d.AttributevalueID,
                                                       AttributeValueName = d.AttributeValueName
                                                   }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Thyroid";
            lstEMRvalue.Attributeid = 26;
            lstEMRvalue.Attributevaluename = lstThyroidDurationType[0].AttributeName;
            ddlDuration_40.DataSource = lstThyroidDurationType.ToList();
            ddlDuration_40.DataTextField = "AttributeValueName";
            ddlDuration_40.DataValueField = "AttributevalueID";
            ddlDuration_40.DataBind();
            ddlDuration_40.Items.Insert(0, "---Select---");


            var lstThyroidTreatment = from s in lsthisPCA
                                     where s.ComplaintID == 207
                                     select s;

            List<EMRAttributeClass> lstThyroidTreatmentType = (from d in lstThyroidDuration
                                                              where d.AttributeID == 27
                                                              select new EMRAttributeClass
                                                              {
                                                                  AttributeName = d.AttributeName,
                                                                  AttributevalueID = d.AttributevalueID,
                                                                  AttributeValueName = d.AttributeValueName
                                                              }).ToList();


            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Thyroid";
            lstEMRvalue.Attributeid = 27;
            lstEMRvalue.Attributevaluename = lstThyroidTreatmentType[0].AttributeName;

            ddlThyroidTreatment_40.DataSource = lstThyroidTreatmentType.ToList();
            ddlThyroidTreatment_40.DataTextField = "AttributeValueName";
            ddlThyroidTreatment_40.DataValueField = "AttributevalueID";
            ddlThyroidTreatment_40.DataBind();
            ddlThyroidTreatment_40.Items.Insert(0, "---Select---");


            

            var lsthypertension = from s in lsthisPCA
                                where s.ComplaintID == 402
                                select s;

            List<EMRAttributeClass> hypertension = (from d in lsthypertension
                             where d.AttributeID == 2 && d.AttributevalueID !=9 
                             select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
            
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Hypertension";
            lstEMRvalue.Attributeid = 2;
            lstEMRvalue.Attributevaluename = hypertension[0].AttributeName;
            EMR1.Bind(lstEMRvalue, hypertension);


            chkTreatment_2.DataSource = hypertension.ToList();
            chkTreatment_2.DataTextField = "AttributeValueName";
            chkTreatment_2.DataValueField = "AttributevalueID";
            chkTreatment_2.DataBind();

            List<EMRAttributeClass> hypertensionduration = (from d in lsthypertension
                               where d.AttributeID == 1
                               select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "Complaint";
            lstEMRvalue.Attributename = "Hypertension";
            lstEMRvalue.Attributeid = 1;
            lstEMRvalue.Attributevaluename = hypertensionduration[0].AttributeName;
            EMR2.Bind(lstEMRvalue, hypertensionduration);

            ddlDurationt_1.DataSource = hypertensionduration.ToList();
            ddlDurationt_1.DataTextField = "AttributeValueName";
            ddlDurationt_1.DataValueField = "AttributevalueID";
            ddlDurationt_1.DataBind();


            var lstgynaecology = from s in lsthisPHA
                                  where s.HistoryID == 1065
                                  select s;

            List<EMRAttributeClass> menstural = (from d in lstgynaecology
                               where d.AttributeID == 14
                               select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
           
            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Gynaecology";
            lstEMRvalue.Attributeid = 14;
            lstEMRvalue.Attributevaluename = menstural[0].AttributeName;
            EMR22.Bind(lstEMRvalue, menstural);


            ddlMenstrualCycle.DataSource = menstural.ToList();
            ddlMenstrualCycle.DataTextField = "AttributeValueName";
            ddlMenstrualCycle.DataValueField = "AttributevalueID";
            ddlMenstrualCycle.DataBind();

            List<EMRAttributeClass> result = (from d in lstgynaecology
                                       where d.AttributeID == 19
                                       select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();

           
            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Gynaecology";
            lstEMRvalue.Attributeid = 19;
            lstEMRvalue.Attributevaluename = result[0].AttributeName;
            EMR23.Bind(lstEMRvalue, result);


            ddlLastPapSmearResult.DataSource = result.ToList();
            ddlLastPapSmearResult.DataTextField = "AttributeValueName";
            ddlLastPapSmearResult.DataValueField = "AttributevalueID";
            ddlLastPapSmearResult.DataBind();

            List<EMRAttributeClass> contraception = (from d in lstgynaecology
                         where d.AttributeID == 17
                        select new EMRAttributeClass
                       {
                           AttributeName =d.AttributeName,
                           AttributevalueID = d.AttributevalueID,
                           AttributeValueName = d.AttributeValueName
                       }).ToList();
            
            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Gynaecology";
            lstEMRvalue.Attributeid = 17;
            lstEMRvalue.Attributevaluename = contraception[0].AttributeName;
            EMR24.Bind(lstEMRvalue, contraception);


            ddlContraception_50.DataSource = contraception.ToList();
            ddlContraception_50.DataTextField = "AttributeValueName";
            ddlContraception_50.DataValueField = "AttributevalueID";
            ddlContraception_50.DataBind();

            var lstHRT = from s in lsthisPHA
                                 where s.HistoryID == 1066
                                 select s;


            List<EMRAttributeClass> HRTTYPE = (from d in lstHRT
                                                     where d.AttributeID == 22
                                                     select new EMRAttributeClass
                                                     {
                                                         AttributeName = d.AttributeName,
                                                         AttributevalueID = d.AttributevalueID,
                                                         AttributeValueName = d.AttributeValueName
                                                     }).ToList();


            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Gynaecology";
            lstEMRvalue.Attributeid = 23;
            lstEMRvalue.Attributevaluename = HRTTYPE[0].AttributeName;
            EMR27.Bind(lstEMRvalue, HRTTYPE);


            ddlTypeofHRT_59.DataSource = HRTTYPE.ToList();
            ddlTypeofHRT_59.DataTextField = "AttributeValueName";
            ddlTypeofHRT_59.DataValueField = "AttributevalueID";
            ddlTypeofHRT_59.DataBind();

            List<EMRAttributeClass> HRTDelivery = (from d in lstHRT
                                               where d.AttributeID == 23
                                               select new EMRAttributeClass
                                               {
                                                   AttributeName = d.AttributeName,
                                                   AttributevalueID = d.AttributevalueID,
                                                   AttributeValueName = d.AttributeValueName
                                               }).ToList();


            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "Gynaecology";
            lstEMRvalue.Attributeid = 23;
            lstEMRvalue.Attributevaluename = HRTDelivery[0].AttributeName;
            EMR28.Bind(lstEMRvalue, HRTDelivery);

            ddlHRTDelivery_66.DataSource = HRTDelivery.ToList();
            ddlHRTDelivery_66.DataTextField = "AttributeValueName";
            ddlHRTDelivery_66.DataValueField = "AttributevalueID";
            ddlHRTDelivery_66.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }

    public void SaveData()
    {

        long visitID = -1;
        long patientID = -1;
        long taskID = -1;
        
        
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        List<SurgicalDetail> lstSurgicalDetail = new List<SurgicalDetail>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        if (chkHighBloodPressure_402.Checked == true)//High Blood Pressure
        {
            string Duration_1 = string.Empty;
            string chkTreatment = string.Empty;
            string chkOthers = string.Empty;
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(402);
            objPatientComplaint.ComplaintName = chkHighBloodPressure_402.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtDuration_1.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(1);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDurationt_1.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_1.Text + " " + ddlDurationt_1.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                Duration_1 = "Y";
            }


            foreach (ListItem li in chkTreatment_2.Items)//Treatment
            {
                if (li.Selected)
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(2);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                    objPatientComplaintAttribute.AttributeValueName = li.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    chkTreatment = "Y";
                }
            }

            if (chkOthers_9.Checked == true)//OtherStext
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(2);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(9);
                objPatientComplaintAttribute.AttributeValueName = txtOthers_9.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                chkOthers = "Y";
            }

            if (chkOthers == "" && chkTreatment == "" && Duration_1 == "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = 402;
                objPatientComplaintAttribute.AttributevalueID = 402;
                objPatientComplaintAttribute.AttributeValueName = chkHighBloodPressure_402.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
               
            }

        }

        if (chkHeartDisease_332.Checked == true)//HeartDisease
        {

            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(332);
            objPatientComplaint.ComplaintName = chkHeartDisease_332.Text;
            lstPatientComplaint.Add(objPatientComplaint);


            if (ddlDiseaseType_3.SelectedItem.Text == "Others")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(332);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(3);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(16);
                objPatientComplaintAttribute.AttributeValueName = txtothers_16.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                if (ddlDiseaseType_3.SelectedItem.Text != "--Select--")
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(332);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(3);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDiseaseType_3.SelectedValue);
                    objPatientComplaintAttribute.AttributeValueName = ddlDiseaseType_3.SelectedItem.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                }
            }


            if (txtDisease_17.Text != string.Empty && ddlDiseaseType_3.SelectedItem.Text != "--Select--")  //Disease-lblDisease_4
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(332);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(4);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(17);
                objPatientComplaintAttribute.AttributeValueName = txtDisease_17.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
        }
        
        if (chkDiabetesMellitus_389.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(389);
            objPatientComplaint.ComplaintName = chkDiabetesMellitus_389.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtDuration_5.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(5);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_5.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_5.Text + " " + ddlDuration_5.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(6);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlType_6.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlType_6.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }


            if (ddlTreatment_7.SelectedItem.Text == "Others")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(7);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(68);
                objPatientComplaintAttribute.AttributeValueName = txtothers_68.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(7);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTreatment_7.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTreatment_7.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }



        if (chkStroke_438.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(438);
            objPatientComplaint.ComplaintName = chkStroke_438.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtDate_30.Text != string.Empty)//lblDate_8
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(8);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(30);
                objPatientComplaintAttribute.AttributeValueName = txtDate_30.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(9);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlRecovery_9.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlRecovery_9.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            if (ddlTypeOfCVA_10.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(10);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeOfCVA_10.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTypeOfCVA_10.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            if (txtLobeaffected_36.Text != string.Empty && ddlTypeOfCVA_10.SelectedItem.Text != "--Select--")//lblLobeaffected_11
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(11);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(36);
                objPatientComplaintAttribute.AttributeValueName = txtLobeaffected_36.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }


        if (chkCancer_372.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(372);
            objPatientComplaint.ComplaintName = chkCancer_372.Text;
            lstPatientComplaint.Add(objPatientComplaint);


            if (ddlTypeofcancer_13.SelectedItem.Text == "Others" && txtothers_72.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(Convert.ToInt32(ddlTypeofcancer_13.SelectedValue));
                objPatientComplaintAttribute.AttributeValueName = txtothers_72.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                if (ddlTypeofcancer_13.SelectedItem.Text != "--Select--" && ddlTypeofcancer_13.SelectedItem.Text != "Others")
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeofcancer_13.SelectedValue);
                    objPatientComplaintAttribute.AttributeValueName = ddlTypeofcancer_13.SelectedItem.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                }
            }

            if (ddlStageofcancer_14.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(14);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlStageofcancer_14.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlStageofcancer_14.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            {
                if (ddlTreatment_15.SelectedItem.Text == "Others" && txtothers_73.Text != "")
                {
                    
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(15);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(Convert.ToInt32(ddlTreatment_15.SelectedValue));
                    objPatientComplaintAttribute.AttributeValueName = txtothers_73.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                }
                else
                {
                    if (ddlTreatment_15.SelectedItem.Text != "--Select--" && ddlTreatment_15.SelectedItem.Text != "Others")
                    {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(15);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTreatment_15.SelectedValue);
                    objPatientComplaintAttribute.AttributeValueName = ddlTreatment_15.SelectedItem.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    }
                }
            }
        }



        if (chkTuberculosis_946.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(946);
            objPatientComplaint.ComplaintName = chkTuberculosis_946.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtTuberculosis_946.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(946);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtTuberculosis_946.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(946);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            
        }


        if (chkPVD_181.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(181);
            objPatientComplaint.ComplaintName = chkPVD_181.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtPVD_181.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(181);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtPVD_181.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(181);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }


        if (chkRenal_32.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(32);
            objPatientComplaint.ComplaintName = chkRenal_32.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtRenal_32.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(32);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtRenal_32.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(32);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }

        if (chkLiver_78.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(78);
            objPatientComplaint.ComplaintName = chkLiver_78.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtLiver_78.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(78);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtLiver_78.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(78);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
        }

        if (chkRaisedCholestrol_409.Checked == true)
        {
            string duration_12 = "";
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(409);
            objPatientComplaint.ComplaintName = chkRaisedCholestrol_409.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtduration_12.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(409);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(12);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlduration_12.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtduration_12.Text + " " + ddlduration_12.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                duration_12 = "Y";
            }

            if (duration_12 == "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(409);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(409);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(409);
                objPatientComplaintAttribute.AttributeValueName = chkRaisedCholestrol_409.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }

        if (chkCancer_372.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(372);
            objPatientComplaint.ComplaintName = chkCancer_372.Text;
            lstPatientComplaint.Add(objPatientComplaint);


            if (ddlTypeofcancer_13.SelectedItem.Text == "Others" && txtothers_72.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(Convert.ToInt32(ddlTypeofcancer_13.SelectedValue));
                objPatientComplaintAttribute.AttributeValueName = txtothers_72.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                if (ddlTypeofcancer_13.SelectedItem.Text != "--Select--" && ddlTypeofcancer_13.SelectedItem.Text != "Others")
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeofcancer_13.SelectedValue);
                    objPatientComplaintAttribute.AttributeValueName = ddlTypeofcancer_13.SelectedItem.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                }
            }

            if (ddlStageofcancer_14.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(14);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlStageofcancer_14.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlStageofcancer_14.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            {
                if (ddlTreatment_15.SelectedItem.Text == "Others" && txtothers_73.Text != "")
                {
                    
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(15);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(Convert.ToInt32(ddlTreatment_15.SelectedValue));
                    objPatientComplaintAttribute.AttributeValueName = txtothers_73.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                }
                else
                {
                    if (ddlTreatment_15.SelectedItem.Text != "--Select--" && ddlTreatment_15.SelectedItem.Text != "Others")
                    {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(15);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTreatment_15.SelectedValue);
                    objPatientComplaintAttribute.AttributeValueName = ddlTreatment_15.SelectedItem.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    }
                }
            }
        }


        if (chkAsthma_246.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(246);
            objPatientComplaint.ComplaintName = chkAsthma_246.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtDuration_16.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(16);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_16.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_16.Text + " " + ddlDuration_16.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }


            if (ddlTratment_17.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(17);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTratment_17.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTratment_17.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

            if (chkExacerbations_18.Checked == true)
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(18);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlExacerbations_18.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtTimes_18.Text + " " + ddlExacerbations_18.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
        }

        if (chkThalassemiaTrait_536.Checked == true)
        {
            if (ddlTrait_19.SelectedValue.ToString() != "---Select---")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
                objPatientComplaint.ComplaintID = Convert.ToInt32(536);
                objPatientComplaint.ComplaintName = chkThalassemiaTrait_536.Text;
                lstPatientComplaint.Add(objPatientComplaint);

                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(536);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(19);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTrait_19.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTrait_19.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
        }


        if (chkHepatitisBcarrier_537.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(537);
            objPatientComplaint.ComplaintName = chkHepatitisBcarrier_537.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            string Treatment_66 = "";
            string Duration_20 = "";

            if (txtDuration_20.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(20);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_20.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_20.Text + " " + ddlDuration_20.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                Duration_20 = "Y";
            }

            if (txtTreatment_66.Text != string.Empty)//lblTreatment_21
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(21);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(66);
                objPatientComplaintAttribute.AttributeValueName = txtTreatment_66.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                Treatment_66 = "Y";
            }

            if (Duration_20 == "" && Treatment_66 == "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(537);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeValueName = chkHepatitisBcarrier_537.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }

        if (chkOtherDisease_945.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(945);
            objPatientComplaint.ComplaintName = chkOtherDisease_945.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            if (txtOtherDisease_945.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(945);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(28);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtOtherDisease_945.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(945);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(28);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }

        if (chkThyroid_207.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(207);
            objPatientComplaint.ComplaintName = chkThyroid_207.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            string Duration_40 = "";
            if (ddlThyroid_40.SelectedIndex >0)
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(207);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(25);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlThyroid_40.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlThyroid_40.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            if (txtDuration_40.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(207);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(26);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_40.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_40.Text + " " + ddlDuration_40.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                Duration_40 = "Y";
            }
            if (ddlThyroidTreatment_40.SelectedIndex > 0)
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(207);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(27);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlThyroidTreatment_40.SelectedValue);
                if (ddlThyroidTreatment_40.SelectedItem.Text != "Others")
                {
                    objPatientComplaintAttribute.AttributeValueName = ddlThyroidTreatment_40.SelectedItem.Text;
                }
                else
                {
                    objPatientComplaintAttribute.AttributeValueName = txtThyroidTreatmentOther_40.Text;
                }
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
        }



        if (chkSurgicalHistory_0.Checked == true)
        {
            lstSurgicalDetail = GetPatientSurgeryDetail();
        }

        List<DrugDetails> pAdvices = new List<DrugDetails>();
        List<PatientPastVaccinationHistory> lstSavePriorVacc = new List<PatientPastVaccinationHistory>();
        List<PatientPastVaccinationHistory> pVaccinationDetails = new List<PatientPastVaccinationHistory>();
        List<GPALDetails> pGPALDetails = new List<GPALDetails>();
        List<GPALDetails> savegpaldetails = new List<GPALDetails>();

        List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();

        if (chkTS_476.Checked == true)
        {
            if (ddlTypeTS_4.SelectedValue.ToString() != "---Select---" && txtPacksTS_9.Text != "" && txtDurationTS.Text != "")
            {
                PatientHistory hisPKGTS = new PatientHistory();

                hisPKGTS.HistoryID = 476;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.PatientVisitID = visitID;
                hisPKGTS.Description = "Tobacco Smoking";
                hisPKGTS.HistoryName = "Tobacco Smoking";

                lstPatientHisPKG.Add(hisPKGTS);


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    hisPKGAttTS1.PatientVisitID = visitID;
                    hisPKGAttTS1.HistoryID = 476;
                    hisPKGAttTS1.AttributeID = 1;

                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(ddlTypeTS_4.SelectedValue);
                    if (ddlTypeTS_4.SelectedItem.Text != "Others")
                    {
                        hisPKGAttTS1.AttributeValueName = ddlTypeTS_4.SelectedItem.Text;
                    }
                    else
                    {
                        hisPKGAttTS1.AttributeValueName = txtOthersTypeTS.Text;
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);
                }

                if (txtDurationTS.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttTS2 = new PatientHistoryAttribute();

                    hisPKGAttTS2.PatientVisitID = visitID;
                    hisPKGAttTS2.HistoryID = 476;
                    hisPKGAttTS2.AttributeID = 2;
                    hisPKGAttTS2.AttributevalueID = Convert.ToInt64(ddlDurationTS.SelectedValue); ;
                    hisPKGAttTS2.AttributeValueName = txtDurationTS.Text + " " + ddlDurationTS.SelectedItem.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttTS2);
                }
                if (txtPacksTS_9.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttTS3 = new PatientHistoryAttribute();

                    hisPKGAttTS3.PatientVisitID = visitID;
                    hisPKGAttTS3.HistoryID = 476;
                    hisPKGAttTS3.AttributeID = 3;
                    hisPKGAttTS3.AttributevalueID = 9;
                    hisPKGAttTS3.AttributeValueName = txtPacksTS_9.Text + " " + lblPacksTS.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttTS3);
                }


                if (chkQuitSmk_4.Checked == true)
                {

                    PatientHistory hisPKGTSQ = new PatientHistory();

                    hisPKGTSQ.HistoryID = 1094;
                    hisPKGTSQ.PatientVisitID = visitID;
                    hisPKGTSQ.Description = "Tobacco use Quit";
                    hisPKGTSQ.HistoryName = "Tobacco use Quit";

                    lstPatientHisPKG.Add(hisPKGTSQ);

                    if (txtQuitSmk_4.Text.Trim() != "")
                    {
                        PatientHistoryAttribute hisPKGAttTSQ1 = new PatientHistoryAttribute();

                        hisPKGAttTSQ1.PatientVisitID = visitID;
                        hisPKGAttTSQ1.HistoryID = 1094;
                        hisPKGAttTSQ1.AttributeID = 52;
                        hisPKGAttTSQ1.AttributevalueID = Convert.ToInt64(0);
                        hisPKGAttTSQ1.AttributeValueName = txtQuitSmk_4.Text;
                        lstPatientHisPKGAttributes.Add(hisPKGAttTSQ1);
                    }
                    if (ddlQuitSmkDuration.SelectedItem.Text != "")
                    {
                        PatientHistoryAttribute hisPKGAttTSQ2 = new PatientHistoryAttribute();

                        hisPKGAttTSQ2.PatientVisitID = visitID;
                        hisPKGAttTSQ2.HistoryID = 1094;
                        hisPKGAttTSQ2.AttributeID = 53;
                        hisPKGAttTSQ2.AttributevalueID = Convert.ToInt64(0);
                        hisPKGAttTSQ2.AttributeValueName = ddlQuitSmkDuration.SelectedItem.Text;
                        lstPatientHisPKGAttributes.Add(hisPKGAttTSQ2);
                    }
                }
                if (chkQuitAlc_4.Checked == true)
                {

                    PatientHistory hisPKGALQ = new PatientHistory();

                    hisPKGALQ.HistoryID = 1095;
                    hisPKGALQ.PatientVisitID = visitID;
                    hisPKGALQ.Description = "Alcohol use Quit";
                    hisPKGALQ.HistoryName = "Alcohol use Quit";

                    lstPatientHisPKG.Add(hisPKGALQ);

                    if (txtQuitAlc_4.Text.Trim() != "")
                    {
                        PatientHistoryAttribute hisPKGAttALQ1 = new PatientHistoryAttribute();

                        hisPKGAttALQ1.PatientVisitID = visitID;
                        hisPKGAttALQ1.HistoryID = 1095;
                        hisPKGAttALQ1.AttributeID = 54;
                        hisPKGAttALQ1.AttributevalueID = Convert.ToInt64(0);
                        hisPKGAttALQ1.AttributeValueName = txtQuitAlc_4.Text;
                        lstPatientHisPKGAttributes.Add(hisPKGAttALQ1);
                    }
                    if (ddlQuitSmkDuration.SelectedItem.Text != "")
                    {
                        PatientHistoryAttribute hisPKGAttALQ2 = new PatientHistoryAttribute();

                        hisPKGAttALQ2.PatientVisitID = visitID;
                        hisPKGAttALQ2.HistoryID = 1095;
                        hisPKGAttALQ2.AttributeID = 55;
                        hisPKGAttALQ2.AttributevalueID = Convert.ToInt64(0);
                        hisPKGAttALQ2.AttributeValueName = ddlQuitAlcDuration.SelectedItem.Text;
                        lstPatientHisPKGAttributes.Add(hisPKGAttALQ2);
                    }
                }
            }
        }

        if (chkAC_369.Checked == true)
        {
            if (ddlTypesAC_12.SelectedValue.ToString() != "---Select---" && txtDurationAC.Text != "" && txtQtyAC.Text != "")
            {
                PatientHistory hisPKGAC = new PatientHistory();

                hisPKGAC.HistoryID = 369;
                hisPKGAC.ComplaintId = 0;
                hisPKGAC.PatientVisitID = visitID;
                hisPKGAC.Description = "Alcohol Consumption";
                hisPKGAC.HistoryName = "Alcohol Consumption";
                lstPatientHisPKG.Add(hisPKGAC);


                {
                    PatientHistoryAttribute hisPKGAttAC1 = new PatientHistoryAttribute();

                    hisPKGAttAC1.PatientVisitID = visitID;
                    hisPKGAttAC1.HistoryID = 369;
                    hisPKGAttAC1.AttributeID = 4;
                    hisPKGAttAC1.AttributevalueID = Convert.ToInt64(ddlTypesAC_12.SelectedValue);
                    if (ddlTypeTS_4.SelectedItem.Text != "Others")
                    {
                        hisPKGAttAC1.AttributeValueName = ddlTypesAC_12.SelectedItem.Text;
                    }
                    else
                    {
                        hisPKGAttAC1.AttributeValueName = txtOthersTypeAC_17.Text;
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttAC1);
                }
                if (txtDurationAC.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttAC2 = new PatientHistoryAttribute();

                    hisPKGAttAC2.PatientVisitID = visitID;
                    hisPKGAttAC2.HistoryID = 369;
                    hisPKGAttAC2.AttributeID = 5;
                    hisPKGAttAC2.AttributevalueID = Convert.ToInt64(ddlDurationAC.SelectedValue);
                    hisPKGAttAC2.AttributeValueName = txtDurationAC.Text + " " + ddlDurationAC.SelectedItem.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttAC2);
                }
                if (txtQtyAC.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttAC3 = new PatientHistoryAttribute();

                    hisPKGAttAC3.PatientVisitID = visitID;
                    hisPKGAttAC3.HistoryID = 369;
                    hisPKGAttAC3.AttributeID = 6;
                    hisPKGAttAC3.AttributevalueID = 17;
                    hisPKGAttAC3.AttributeValueName = txtQtyAC.Text + " " + lblMlLtr.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttAC3);
                }
            }

        }

        if (chkPA_1059.Checked == true)
        {
            PatientHistory hisPKGPA = new PatientHistory();

            hisPKGPA.HistoryID = 1059;
            hisPKGPA.ComplaintId = 0;
            hisPKGPA.PatientVisitID = visitID;
            hisPKGPA.Description = "Physicial Activity";
            hisPKGPA.HistoryName = "Physicial Activity";
            lstPatientHisPKG.Add(hisPKGPA);


            {
                PatientHistoryAttribute hisPKGAttPA1 = new PatientHistoryAttribute();

                hisPKGAttPA1.PatientVisitID = visitID;
                hisPKGAttPA1.HistoryID = 1059;
                hisPKGAttPA1.AttributeID = 7;
                hisPKGAttPA1.AttributevalueID = Convert.ToInt64(ddlPhysicialActivity_22.SelectedValue);
                hisPKGAttPA1.AttributeValueName = ddlPhysicialActivity_22.SelectedItem.Text;

                lstPatientHisPKGAttributes.Add(hisPKGAttPA1);
            }
            if (ddlPhysicialActivity_22.SelectedValue != "18")
            {
                if (txtAerobic_22.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttPA2 = new PatientHistoryAttribute();

                    hisPKGAttPA2.PatientVisitID = visitID;
                    hisPKGAttPA2.HistoryID = 1059;
                    hisPKGAttPA2.AttributeID = 8;
                    hisPKGAttPA2.AttributevalueID = 22;
                    hisPKGAttPA2.AttributeValueName = txtAerobic_22.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttPA2);
                }

                if (txtAnaerobic_23.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttPA3 = new PatientHistoryAttribute();

                    hisPKGAttPA3.PatientVisitID = visitID;
                    hisPKGAttPA3.HistoryID = 1059;
                    hisPKGAttPA3.AttributeID = 9;
                    hisPKGAttPA3.AttributevalueID = 23;
                    hisPKGAttPA3.AttributeValueName = txtAnaerobic_23.Text;

                    lstPatientHisPKGAttributes.Add(hisPKGAttPA3);
                }
            }
            if (txtNos.Text != "")
            {
                PatientHistoryAttribute hisPKGAttPA4 = new PatientHistoryAttribute();

                hisPKGAttPA4.PatientVisitID = visitID;
                hisPKGAttPA4.HistoryID = 1059;
                hisPKGAttPA4.AttributeID = 10;
                hisPKGAttPA4.AttributevalueID = Convert.ToInt64(ddldays.SelectedValue);
                hisPKGAttPA4.AttributeValueName = txtNos.Text + " " + ddlHrs.SelectedItem.Text + " " + ddldays.SelectedItem.Text;

                lstPatientHisPKGAttributes.Add(hisPKGAttPA4);
            }
        }

        if (chkDiabetesMellitus_389.Checked == true)
        {
            PatientHistory hisPKGAH40 = new PatientHistory();
            PatientHistoryAttribute hisPKGAttAH40 = new PatientHistoryAttribute();
            if (ddlFHODM_1083.SelectedIndex > 0)
            {
                hisPKGAH40.HistoryID = 1069;
                hisPKGAH40.ComplaintId = 0;
                hisPKGAH40.PatientVisitID = visitID;
                hisPKGAH40.Description = "F/H/O DM";
                hisPKGAH40.HistoryName = "F/H/O DM";
                lstPatientHisPKG.Add(hisPKGAH40);

                {
                    hisPKGAttAH40.PatientVisitID = visitID;
                    hisPKGAttAH40.HistoryID = 1069;
                    hisPKGAttAH40.AttributeID = 27;

                    if (ddlFHODM_1083.SelectedIndex > 0)
                    {
                        hisPKGAttAH40.AttributevalueID = Convert.ToInt64(ddlFHODM_1083.SelectedItem.Value.ToString());
                        if (ddlFHODM_1083.SelectedItem.Text == "Present" || ddlFHODM_1083.SelectedItem.Text == "Insignificant")
                        {
                            hisPKGAttAH40.AttributeValueName = ddlFHODM_1083.SelectedItem.Text + " - " + txtFHODM_1083.Text + ";";
                        }

                        else
                        {
                            hisPKGAttAH40.AttributeValueName = ddlFHODM_1083.SelectedItem.Text;
                        }
                    }
                    else
                    {
                        hisPKGAttAH40.AttributevalueID = 0;
                        hisPKGAttAH40.AttributeValueName = "";
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttAH40);
                }

            }
            PatientHistory hisPKGAH41 = new PatientHistory();
            PatientHistoryAttribute hisPKGAttAH41 = new PatientHistoryAttribute();
            if (txtHOHypoglycemia_1084.Text.Trim() != "")
            {
                hisPKGAH41.HistoryID = 1093;
                hisPKGAH41.ComplaintId = 0;
                hisPKGAH41.PatientVisitID = visitID;
                hisPKGAH41.Description = "H/O Hypoglycemia";
                hisPKGAH41.HistoryName = "H/O Hypoglycemia";
                lstPatientHisPKG.Add(hisPKGAH41);
                {
                    hisPKGAttAH41.PatientVisitID = visitID;
                    hisPKGAttAH41.HistoryID = 1093;
                    hisPKGAttAH41.AttributeID = 0;

                    if (txtHOHypoglycemia_1084.Text.Trim() != "")
                    {
                        hisPKGAttAH41.AttributeValueName = txtHOHypoglycemia_1084.Text;
                    }
                    else
                    {
                        hisPKGAttAH41.AttributeValueName = "";
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttAH41);
                }
            }

        }

        if (hdnAllergy.Value.ToString() != string.Empty)
        {
            
            string[] itemArray = hdnAllergy.Value.Split('^');


            for (int i = 0; i < itemArray.Length-1; i++)
            {
                string[] itemValue = itemArray[i].Split('!');
                PatientHistory hisAllergy = new PatientHistory();
                string[] hisArray = itemValue[0].Split('~');
                hisAllergy.HistoryID = Convert.ToInt32(hisArray[1].ToString());
                hisAllergy.PatientVisitID = visitID;
                hisAllergy.Description = hisArray[3].ToString();
                hisAllergy.HistoryName = hisArray[3].ToString();
                lstPatientHisPKG.Add(hisAllergy);
                for (int j = 0; j < itemValue.Length; j++)
                {
                    PatientHistoryAttribute hisFamilyAtt = new PatientHistoryAttribute();
                    hisFamilyAtt.PatientVisitID = visitID;
                    hisFamilyAtt.HistoryID = Convert.ToInt32(hisArray[1].ToString());
                    string[] selAll = itemValue[j].Split('~');
                    if (j == 0)
                    {
                        hisFamilyAtt.AttributeID = Convert.ToInt64(selAll[2].ToString());
                        hisFamilyAtt.AttributevalueID = Convert.ToInt64(selAll[4].ToString());
                        hisFamilyAtt.AttributeValueName = selAll[3].ToString();
                    }
                    else
                    {
                        hisFamilyAtt.AttributeID = Convert.ToInt64(selAll[0].ToString());
                        hisFamilyAtt.AttributevalueID = Convert.ToInt64(selAll[2].ToString());
                        hisFamilyAtt.AttributeValueName = selAll[1].ToString();
                    }
                    lstPatientHisPKGAttributes.Add(hisFamilyAtt);
                }

            }
            hdnAllergy.Value = "";
            hdnAllergyValue.Value = "";
            
        }

        if (chkFamilyHistory_1085.Checked == true)
        {
            PatientHistory hisFamily = new PatientHistory();

            hisFamily.HistoryID = 1070;
            hisFamily.ComplaintId = 0;
            hisFamily.PatientVisitID = visitID;
            hisFamily.Description = "Family History";
            hisFamily.HistoryName = "Family History";
            lstPatientHisPKG.Add(hisFamily);

            {
                PatientHistoryAttribute hisFamilyAtt = new PatientHistoryAttribute();

                hisFamilyAtt.PatientVisitID = visitID;
                hisFamilyAtt.HistoryID = 1070;
                hisFamilyAtt.AttributeID = 28;
                hisFamilyAtt.AttributevalueID = Convert.ToInt64(87);
                if (hdnFamilyHistory.Value != "")
                {
                    hisFamilyAtt.AttributeValueName = hdnFamilyHistory.Value.ToString();
                }
                lstPatientHisPKGAttributes.Add(hisFamilyAtt);
            }

        }

        if (txtPresentComplaints.Text.Trim() != "")
        {
            PatientHistory hisFamily = new PatientHistory();

            hisFamily.HistoryID = 1092;
            hisFamily.ComplaintId = 0;
            hisFamily.PatientVisitID = visitID;
            hisFamily.Description = "Present Complaints";
            hisFamily.HistoryName = "Present Complaints";
            lstPatientHisPKG.Add(hisFamily);

            {
                PatientHistoryAttribute hisFamilyAtt = new PatientHistoryAttribute();

                hisFamilyAtt.PatientVisitID = visitID;
                hisFamilyAtt.HistoryID = 1092;
                hisFamilyAtt.AttributeID = 0;
                hisFamilyAtt.AttributevalueID = 0;
                hisFamilyAtt.AttributeValueName = Server.HtmlEncode(txtPresentComplaints.Text).Replace("\n", "<br/>");
                lstPatientHisPKGAttributes.Add(hisFamilyAtt);
            }

        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "sky1", "javascript:alert(" + hdnAllergyValue  + ");", true);
        //if (chkDiet_1071.Checked == true)
        //{
        //    PatientHistory hisPKGAH5 = new PatientHistory();
        //    PatientHistoryAttribute hisPKGAttAH5 = new PatientHistoryAttribute();

        //    hisPKGAH5.HistoryID = 1085;
        //    hisPKGAH5.ComplaintId = 0;
        //    hisPKGAH5.PatientVisitID = visitID;
        //    hisPKGAH5.Description = "Diet Habits";
        //    hisPKGAH5.HistoryName = "Diet Habits";
        //    lstPatientHisPKG.Add(hisPKGAH5);

        //    {
        //        hisPKGAttAH5.PatientVisitID = visitID;
        //        hisPKGAttAH5.HistoryID = 1085;
        //        hisPKGAttAH5.AttributeID = 44;
        //        hisPKGAttAH5.AttributeValueName = Server.HtmlEncode(txtOthersTypeDiet_84.Text).Replace("\n", "<br/>"); 
        //        lstPatientHisPKGAttributes.Add(hisPKGAttAH5);
        //    }

        //}

        if (chkBladder_1072.Checked == true)
        {
            if (ddlBladderType_92.SelectedValue.ToString() != "---Select---")
            {
                PatientHistory hisPKGAH4 = new PatientHistory();
                PatientHistoryAttribute hisPKGAttAH4 = new PatientHistoryAttribute();

                hisPKGAH4.HistoryID = 1071;
                hisPKGAH4.ComplaintId = 0;
                hisPKGAH4.PatientVisitID = visitID;
                hisPKGAH4.Description = "Bladder habits";
                hisPKGAH4.HistoryName = "Bladder habits";
                lstPatientHisPKG.Add(hisPKGAH4);

                {
                    hisPKGAttAH4.PatientVisitID = visitID;
                    hisPKGAttAH4.HistoryID = 1071;
                    hisPKGAttAH4.AttributeID = 29;
                    hisPKGAttAH4.AttributevalueID = Convert.ToInt64(ddlBladderType_92.SelectedItem.Value);
                    if (ddlBladderType_92.SelectedItem.Value != "95")
                    {
                        hisPKGAttAH4.AttributeValueName = ddlBladderType_92.SelectedItem.Text;
                    }
                    else
                    {
                        hisPKGAttAH4.AttributeValueName = txtOthersTypeBladder_92.Text;
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttAH4);
                }
            }

        }

        if (chkBowel_1073.Checked == true)
        {
            if (ddlBowelType_100.SelectedValue.ToString() != "---Select---")
            {
                PatientHistory hisPKGAH4 = new PatientHistory();
                PatientHistoryAttribute hisPKGAttAH4 = new PatientHistoryAttribute();

                hisPKGAH4.HistoryID = 1085;
                hisPKGAH4.ComplaintId = 0;
                hisPKGAH4.PatientVisitID = visitID;
                hisPKGAH4.Description = "Bowel habits";
                hisPKGAH4.HistoryName = "Bowel habits";
                lstPatientHisPKG.Add(hisPKGAH4);

                {
                    hisPKGAttAH4.PatientVisitID = visitID;
                    hisPKGAttAH4.HistoryID = 1085;
                    hisPKGAttAH4.AttributeID = 113;
                    hisPKGAttAH4.AttributevalueID = Convert.ToInt64(ddlBowelType_100.SelectedItem.Value);
                    if (ddlBowelType_100.SelectedItem.Text != "Others")
                    {
                        hisPKGAttAH4.AttributeValueName = ddlBowelType_100.SelectedItem.Text;
                    }
                    else
                    {
                        hisPKGAttAH4.AttributeValueName = txtOthersTypeBowel_100.Text;
                    }

                    lstPatientHisPKGAttributes.Add(hisPKGAttAH4);
                }
            }

        }
        if (chkDrugSub_1074.Checked == true)
        {
            PatientHistory hisPKGAH4 = new PatientHistory();
            PatientHistoryAttribute hisPKGAttAH4 = new PatientHistoryAttribute();

            hisPKGAH4.HistoryID = 1096;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Drug / Substance abuse";
            hisPKGAH4.HistoryName = "Drug / Substance abuse";
            lstPatientHisPKG.Add(hisPKGAH4);

            {
                hisPKGAttAH4.PatientVisitID = visitID;
                hisPKGAttAH4.HistoryID = 1096;
                hisPKGAttAH4.AttributeID = 120;
                hisPKGAttAH4.AttributeValueName = txtOthersTypeDrugSub_101.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttAH4);
            }

        }

        if (chkDrugsHistory_1063.Checked == true)
        {
            PatientHistory hisPKGDH1 = new PatientHistory();
            PatientHistoryAttribute hisPKGAttDH1 = new PatientHistoryAttribute();

            hisPKGDH1.HistoryID = 1063;
            hisPKGDH1.ComplaintId = 0;
            hisPKGDH1.PatientVisitID = visitID;
            hisPKGDH1.Description = "DRUG HISTORY";
            hisPKGDH1.HistoryName = "DRUG HISTORY";
            lstPatientHisPKG.Add(hisPKGDH1);

            pAdvices = uAd.GetPrescription(visitID);
        }
        PatientHistory hisPKGDVH = new PatientHistory();
        PatientHistoryAttribute hisPKGAttVH = new PatientHistoryAttribute();

        if (chkVaccHis_1064.Checked == true)
        {
            hisPKGDVH.HistoryID = 1064;
            hisPKGDVH.ComplaintId = 0;
            hisPKGDVH.PatientVisitID = visitID;
            hisPKGDVH.Description = "VACCINATION HISTORY";
            hisPKGDVH.HistoryName = "VACCINATION HISTORY";
            lstPatientHisPKG.Add(hisPKGDVH);

            lstSavePriorVacc = getPriorVaccinations();
        }
        PatientHistory hisPKGDGH = new PatientHistory();
        if (chkGynacHis_1065.Checked == true)
        {
            hisPKGDGH.HistoryID = 1065;
            hisPKGDGH.ComplaintId = 0;
            hisPKGDGH.PatientVisitID = visitID;
            hisPKGDGH.Description = "GYNAECOLOGICAL HISTORY";
            hisPKGDGH.HistoryName = "GYNAECOLOGICAL HISTORY";
            lstPatientHisPKG.Add(hisPKGDGH);

            if (tLMP_38.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH1 = new PatientHistoryAttribute();

                hisPKGAttGH1.PatientVisitID = visitID;
                hisPKGAttGH1.HistoryID = 1065;
                hisPKGAttGH1.AttributeID = 13;
                hisPKGAttGH1.AttributevalueID = 38;
                hisPKGAttGH1.AttributeValueName = tLMP_38.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH1);
            }
            if (ddlMenstrualCycle.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH2 = new PatientHistoryAttribute();

                hisPKGAttGH2.PatientVisitID = visitID;
                hisPKGAttGH2.HistoryID = 1065;
                hisPKGAttGH2.AttributeID = 14;
                hisPKGAttGH2.AttributevalueID = Convert.ToInt64(ddlMenstrualCycle.SelectedItem.Value);
                hisPKGAttGH2.AttributeValueName = ddlMenstrualCycle.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH2);
            }
            if (txtCycleLength_45.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH3 = new PatientHistoryAttribute();

                hisPKGAttGH3.PatientVisitID = visitID;
                hisPKGAttGH3.HistoryID = 1065;
                hisPKGAttGH3.AttributeID = 15;
                hisPKGAttGH3.AttributevalueID = 45;
                hisPKGAttGH3.AttributeValueName = txtCycleLength_45.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH3);
            }
            if (txtLastPapSmearDt_46.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH4 = new PatientHistoryAttribute();

                hisPKGAttGH4.PatientVisitID = visitID;
                hisPKGAttGH4.HistoryID = 1065;
                hisPKGAttGH4.AttributeID = 16;
                hisPKGAttGH4.AttributevalueID = 46;
                hisPKGAttGH4.AttributeValueName = txtLastPapSmearDt_46.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH4);
            }
            if (txtAgeofMenarchy_47.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH5 = new PatientHistoryAttribute();

                hisPKGAttGH5.PatientVisitID = visitID;
                hisPKGAttGH5.HistoryID = 1065;
                hisPKGAttGH5.AttributeID = 18;
                hisPKGAttGH5.AttributevalueID = 47;
                hisPKGAttGH5.AttributeValueName = txtAgeofMenarchy_47.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH5);
            }
            if (ddlLastPapSmearResult.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH6 = new PatientHistoryAttribute();

                hisPKGAttGH6.PatientVisitID = visitID;
                hisPKGAttGH6.HistoryID = 1065;
                hisPKGAttGH6.AttributeID = 19;
                hisPKGAttGH6.AttributevalueID = Convert.ToInt64(ddlLastPapSmearResult.SelectedItem.Value);
                hisPKGAttGH6.AttributeValueName = ddlLastPapSmearResult.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH6);
            }
            if (ddlContraception_50.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH7 = new PatientHistoryAttribute();
                hisPKGAttGH7.PatientVisitID = visitID;
                hisPKGAttGH7.HistoryID = 1065;
                hisPKGAttGH7.AttributeID = 17;
                hisPKGAttGH7.AttributevalueID = Convert.ToInt64(ddlContraception_50.SelectedItem.Value);
                if (ddlContraception_50.SelectedItem.Value != "50")
                {
                    hisPKGAttGH7.AttributeValueName = ddlContraception_50.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttGH7.AttributeValueName = txtContraceptionOthers_50.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttGH7);
            }
            if (txtLastMammogramResultDt_55.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH8 = new PatientHistoryAttribute();
                hisPKGAttGH8.PatientVisitID = visitID;
                hisPKGAttGH8.HistoryID = 1065;
                hisPKGAttGH8.AttributeID = 20;
                hisPKGAttGH8.AttributevalueID = 55;
                hisPKGAttGH8.AttributeValueName = txtLastMammogramResultDt_55.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH8);
            }
            if (txtLastMammogramResult_56.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH9 = new PatientHistoryAttribute();
                hisPKGAttGH9.PatientVisitID = visitID;
                hisPKGAttGH9.HistoryID = 1065;
                hisPKGAttGH9.AttributeID = 21;
                hisPKGAttGH9.AttributevalueID = 56;
                hisPKGAttGH9.AttributeValueName = txtLastMammogramResult_56.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH9);
            }

        }
        //------------------------------------GURUNATH.S
        //---PERSONAL HISTORY-----------------------
        //----------Education---------
        if (txtEducation.Text.Trim() != "")
        {
            PatientHistory hisPKGAH4 = new PatientHistory();

            hisPKGAH4.HistoryID = 1087;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Education";
            hisPKGAH4.HistoryName = "Education";
            lstPatientHisPKG.Add(hisPKGAH4);

            PatientHistoryAttribute hisPKGAttPH1 = new PatientHistoryAttribute();
            hisPKGAttPH1.PatientVisitID = visitID;
            hisPKGAttPH1.HistoryID = 1087;
            hisPKGAttPH1.AttributeID = 45;
            hisPKGAttPH1.AttributevalueID = 161;
            hisPKGAttPH1.AttributeValueName = txtEducation.Text;
            lstPatientHisPKGAttributes.Add(hisPKGAttPH1);

            PatientHistoryAttribute hisPKGAttPH2 = new PatientHistoryAttribute();
            hisPKGAttPH2.PatientVisitID = visitID;
            hisPKGAttPH2.HistoryID = 1087;
            hisPKGAttPH2.AttributeID = 46;
            hisPKGAttPH2.AttributevalueID = 162;
            if (txtEducation.Text.Trim() != "" && chkEducation.Checked == true)
            {
                hisPKGAttPH2.AttributeValueName = "YES";
            }
            else
            {
                hisPKGAttPH2.AttributeValueName = "NO";
            }

            lstPatientHisPKGAttributes.Add(hisPKGAttPH2);
        }
        //-----------------------
        //---------Occupation----
        if (txtOccupation.Text.Trim() != "")
        {
            PatientHistory hisPKGAH4 = new PatientHistory();

            hisPKGAH4.HistoryID = 1088;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Occupation";
            hisPKGAH4.HistoryName = "Occupation";
            lstPatientHisPKG.Add(hisPKGAH4);

            PatientHistoryAttribute hisPKGAttPH1 = new PatientHistoryAttribute();
            hisPKGAttPH1.PatientVisitID = visitID;
            hisPKGAttPH1.HistoryID = 1088;
            hisPKGAttPH1.AttributeID = 47;
            hisPKGAttPH1.AttributevalueID = 163;
            hisPKGAttPH1.AttributeValueName = txtOccupation.Text;
            lstPatientHisPKGAttributes.Add(hisPKGAttPH1);

            PatientHistoryAttribute hisPKGAttPH2 = new PatientHistoryAttribute();
            hisPKGAttPH2.PatientVisitID = visitID;
            hisPKGAttPH2.HistoryID = 1088;
            hisPKGAttPH2.AttributeID = 48;
            hisPKGAttPH2.AttributevalueID = 164;
            if (txtOccupation.Text.Trim() != "" && chkOccupation.Checked == true)
            {
                hisPKGAttPH2.AttributeValueName = "YES";
            }
            else
            {
                hisPKGAttPH2.AttributeValueName = "NO";
            }
            lstPatientHisPKGAttributes.Add(hisPKGAttPH2);
        }
        //-------------
        //---------Income----
        if (txtIncome.Text.Trim() != "")
        {
            PatientHistory hisPKGAH4 = new PatientHistory();

            hisPKGAH4.HistoryID = 1089;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Income";
            hisPKGAH4.HistoryName = "Income";
            lstPatientHisPKG.Add(hisPKGAH4);

            PatientHistoryAttribute hisPKGAttPH1 = new PatientHistoryAttribute();
            hisPKGAttPH1.PatientVisitID = visitID;
            hisPKGAttPH1.HistoryID = 1089;
            hisPKGAttPH1.AttributeID = 49;
            hisPKGAttPH1.AttributevalueID = 165;
            hisPKGAttPH1.AttributeValueName = txtIncome.Text;
            lstPatientHisPKGAttributes.Add(hisPKGAttPH1);

            PatientHistoryAttribute hisPKGAttPH2 = new PatientHistoryAttribute();
            hisPKGAttPH2.PatientVisitID = visitID;
            hisPKGAttPH2.HistoryID = 1089;
            hisPKGAttPH2.AttributeID = 50;
            hisPKGAttPH2.AttributevalueID = 166;
            if (chkIncome.Checked == true)
            {
                hisPKGAttPH2.AttributeValueName = "YES";
            }
            else
            {
                hisPKGAttPH2.AttributeValueName = "NO";
            }

            lstPatientHisPKGAttributes.Add(hisPKGAttPH2);
        }
        //-------------
        //---------Marital History----
        if (txtMarital.Text.Trim() != "")
        {
            PatientHistory hisPKGAH4 = new PatientHistory();

            hisPKGAH4.HistoryID = 1090;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Marital";
            hisPKGAH4.HistoryName = "Marital";

            lstPatientHisPKG.Add(hisPKGAH4);
            PatientHistoryAttribute hisPKGAttPH1 = new PatientHistoryAttribute();
            hisPKGAttPH1.PatientVisitID = visitID;
            hisPKGAttPH1.HistoryID = 1090;
            hisPKGAttPH1.AttributeID = 51;
            hisPKGAttPH1.AttributevalueID = 167;
            hisPKGAttPH1.AttributeValueName = txtMarital.Text;
            lstPatientHisPKGAttributes.Add(hisPKGAttPH1);

            PatientHistoryAttribute hisPKGAttPH2 = new PatientHistoryAttribute();
            hisPKGAttPH2.PatientVisitID = visitID;
            hisPKGAttPH2.HistoryID = 1090;
            hisPKGAttPH2.AttributeID = 52;
            hisPKGAttPH2.AttributevalueID = 168;
            if (chkMarital.Checked == true)
            {
                hisPKGAttPH2.AttributeValueName = "YES";
            }
            else
            {
                hisPKGAttPH2.AttributeValueName = "NO";
            }
            lstPatientHisPKGAttributes.Add(hisPKGAttPH2);
        }
        //-------------
        //---------Other Details----
        if (txtOthers.Text.Trim() != "")
        {
            PatientHistory hisPKGAH4 = new PatientHistory();

            hisPKGAH4.HistoryID = 1091;
            hisPKGAH4.ComplaintId = 0;
            hisPKGAH4.PatientVisitID = visitID;
            hisPKGAH4.Description = "Personal History Others";
            hisPKGAH4.HistoryName = "Personal History Others";

            lstPatientHisPKG.Add(hisPKGAH4);
            PatientHistoryAttribute hisPKGAttPH1 = new PatientHistoryAttribute();
            hisPKGAttPH1.PatientVisitID = visitID;
            hisPKGAttPH1.HistoryID = 1091;
            hisPKGAttPH1.AttributeID = 53;
            hisPKGAttPH1.AttributevalueID = 169;
            hisPKGAttPH1.AttributeValueName = txtOthers.Text;
            lstPatientHisPKGAttributes.Add(hisPKGAttPH1);

            PatientHistoryAttribute hisPKGAttPH2 = new PatientHistoryAttribute();
            hisPKGAttPH2.PatientVisitID = visitID;
            hisPKGAttPH2.HistoryID = 1091;
            hisPKGAttPH2.AttributeID = 54;
            hisPKGAttPH2.AttributevalueID = 170;
            if (chkOthersDetails.Checked == true)
            {
                hisPKGAttPH2.AttributeValueName = "YES";
            }
            else
            {
                hisPKGAttPH2.AttributeValueName = "NO";
            }
            lstPatientHisPKGAttributes.Add(hisPKGAttPH2);

        }
        // if (chkOthersDetails.Checked == true)
        // {

        //  }
        //-------------
        //------------------------------------------
        //

        if (chkHRT_1066.Checked == true)
        {
            PatientHistory hisPKGDHRT = new PatientHistory();

            hisPKGDHRT.HistoryID = 1066;
            hisPKGDHRT.ComplaintId = 0;
            hisPKGDHRT.PatientVisitID = visitID;
            hisPKGDHRT.Description = "Hormone Replacement Theraphy";
            hisPKGDHRT.HistoryName = "Hormone Replacement Theraphy";
            lstPatientHisPKG.Add(hisPKGDHRT);

            if (ddlTypeofHRT_59.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT1 = new PatientHistoryAttribute();

                hisPKGAttHRT1.PatientVisitID = visitID;
                hisPKGAttHRT1.HistoryID = 1066;
                hisPKGAttHRT1.AttributeID = 22;
                hisPKGAttHRT1.AttributevalueID = Convert.ToInt64(ddlTypeofHRT_59.SelectedItem.Value);
                if (ddlTypeofHRT_59.SelectedItem.Value != "59")
                {
                    hisPKGAttHRT1.AttributeValueName = ddlTypeofHRT_59.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT1.AttributeValueName = txtOthersTypeofHRT_59.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT1);
            }

            if (ddlHRTDelivery_66.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT2 = new PatientHistoryAttribute();

                hisPKGAttHRT2.PatientVisitID = visitID;
                hisPKGAttHRT2.HistoryID = 1066;
                hisPKGAttHRT2.AttributeID = 23;
                hisPKGAttHRT2.AttributevalueID = Convert.ToInt64(ddlHRTDelivery_66.SelectedValue);
                if (ddlHRTDelivery_66.SelectedValue != "66")
                {
                    hisPKGAttHRT2.AttributeValueName = ddlHRTDelivery_66.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT2.AttributeValueName = txtOthersHRTDelivery_66.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT2);
            }

        }


        //Save GPALDetails

        for (int i = 0; i < savegpaldetails.Count; i++)
        {
            GPALDetails gdetails = new GPALDetails();
            gdetails.PatientID = patientID;
            string str = savegpaldetails[i].SexOfChild.ToString();
            if (str == "Male")
            {
                str = "M";
            }
            else
            {
                str = "F";
            }
            string strGrowth = savegpaldetails[i].IsGrowthNormal;
            if (strGrowth == "Normal")
            {
                strGrowth = "N";
            }
            else
            {
                strGrowth = "A";
            }
            gdetails.SexOfChild = str;
            gdetails.Age = savegpaldetails[i].Age;

            gdetails.ModeOfDeliveryID = savegpaldetails[i].ModeOfDeliveryID;

            gdetails.BirthWeight = savegpaldetails[i].BirthWeight;

            gdetails.BirthMaturityID = savegpaldetails[i].BirthMaturityID;

            gdetails.IsGrowthNormal = strGrowth;
            gdetails.GrowthRate = savegpaldetails[i].GrowthRate;
            gdetails.PatientVisitID = visitID;
            gdetails.CreatedBy = LID;
            gdetails.ModifiedBy = 0;
            pGPALDetails.Add(gdetails);
        }



        //Save Vaccination

        for (int i = 0; i < lstSavePriorVacc.Count(); i++)
        {
            PatientPastVaccinationHistory pvh = new PatientPastVaccinationHistory();
            pvh.VaccinationID = lstSavePriorVacc[i].VaccinationID;
            pvh.VaccinationName = lstSavePriorVacc[i].VaccinationName;
            pvh.YearOfVaccination = lstSavePriorVacc[i].YearOfVaccination;

            if (lstSavePriorVacc[i].MonthName == "January")
            {
                pvh.MonthOfVaccination = 1;
            }
            else if (lstSavePriorVacc[i].MonthName == "Febrauary")
            {
                pvh.MonthOfVaccination = 2;
            }
            else if (lstSavePriorVacc[i].MonthName == "March")
            {
                pvh.MonthOfVaccination = 3;
            }
            else if (lstSavePriorVacc[i].MonthName == "April")
            {
                pvh.MonthOfVaccination = 4;
            }
            else if (lstSavePriorVacc[i].MonthName == "May")
            {
                pvh.MonthOfVaccination = 5;
            }
            else if (lstSavePriorVacc[i].MonthName == "June")
            {
                pvh.MonthOfVaccination = 6;
            }
            else if (lstSavePriorVacc[i].MonthName == "July")
            {
                pvh.MonthOfVaccination = 7;
            }
            else if (lstSavePriorVacc[i].MonthName == "August")
            {
                pvh.MonthOfVaccination = 8;
            }
            else if (lstSavePriorVacc[i].MonthName == "September")
            {
                pvh.MonthOfVaccination = 9;
            }
            else if (lstSavePriorVacc[i].MonthName == "October")
            {
                pvh.MonthOfVaccination = 10;
            }
            else if (lstSavePriorVacc[i].MonthName == "November")
            {
                pvh.MonthOfVaccination = 11;
            }
            else if (lstSavePriorVacc[i].MonthName == "December")
            {
                pvh.MonthOfVaccination = 12;
            }
            else
            {
            }
            pvh.VaccinationDose = lstSavePriorVacc[i].VaccinationDose;
            string strBooster = lstSavePriorVacc[i].IsBooster;
            if (strBooster == "Yes")
            {
                strBooster = "Y";
            }
            else
            {
                strBooster = "N";
            }
            pvh.IsBooster = strBooster;
            pvh.PatientID = patientID;
            pvh.PatientVisitID = visitID;
            pvh.CreatedBy = LID;
            pVaccinationDetails.Add(pvh);
        }

    
        Patient_BL PatientBL = new Patient_BL(base.ContextInfo);
        try
        {
            long returncode = -1;//returncode = 0;
            returncode = new Patient_BL(base.ContextInfo).SaveHistoryPKG(lstPatientHisPKG, lstPatientHisPKGAttributes, pAdvices, pVaccinationDetails, pGPALDetails, g, p, l, a, "", lstPatientComplaint, lstPatientComplaintAttribute, lstSurgicalDetail, LID, visitID, patientID);
            hdnAllergyValue.Value = "";
            hdnAllergy.Value = ""; 
            if (returncode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Changes saved successfully.');", true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ae = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save PatientHistory Package", ex);
        }
    }
    //public List<SurgicalDetail> GetPatientSurgeryDetail()
    //{
    //    List<SurgicalDetail> lstSurgicalDetailTemp = new List<SurgicalDetail>();
    //    foreach (string listSurgeryItems in hdnSurgeryItems.Value.Split('^'))
    //    {
    //        if (listSurgeryItems != "")
    //        {
    //            SurgicalDetail objSurgicalDetail = new SurgicalDetail();
    //            string[] listChild = listSurgeryItems.Split('~');
    //            objSurgicalDetail.SurgeryID = 0;
    //            objSurgicalDetail.SurgeryName = listChild[1];
    //            DateTime d ;
    //            if (listChild[2] != "")
    //            {
    //                d=Convert.ToDateTime( "01/01/"+listChild[2]);
                    
    //               // objSurgicalDetail.TreatmentPlanDate = Convert.ToDateTime(listChild[2]);
    //                objSurgicalDetail.TreatmentPlanDate = d;
    //            }

    //            objSurgicalDetail.HospitalName = listChild[3];
    //            lstSurgicalDetailTemp.Add(objSurgicalDetail);
    //        }
    //    }
    //    return lstSurgicalDetailTemp;
    //}

    public List<SurgicalDetail> GetPatientSurgeryDetail()
    {
        List<SurgicalDetail> lstSurgicalDetailTemp = new List<SurgicalDetail>();
        foreach (string listSurgeryItems in hdnSurgeryItems.Value.Split('^'))
        {
            if (listSurgeryItems != "")
            {
                SurgicalDetail objSurgicalDetail = new SurgicalDetail();
                string[] listChild = listSurgeryItems.Split('~');
                objSurgicalDetail.SurgeryID = 0;
                objSurgicalDetail.SurgeryName = listChild[1];
                DateTime d;
                string s;
                if (listChild[2] == "" || listChild[2] != "")
                {
                    if (listChild[2] == "")
                    {
                        s = listChild[2] == "" ? "1999" : listChild[2];
                        d = Convert.ToDateTime("01/01/" + s);
                    }
                    else if (listChild[2] == "-")
                    {
                        s = listChild[2] == "-" ? "1999" : listChild[2];
                        d = Convert.ToDateTime("01/01/" + s);
                    }
                    else
                    {
                        s = listChild[2] == "1999" ? "1999" : listChild[2];
                        d = Convert.ToDateTime("01/01/" + s);

                    }
                    // objSurgicalDetail.TreatmentPlanDate = Convert.ToDateTime(listChild[2]);
                    objSurgicalDetail.TreatmentPlanDate = d;
                }

                objSurgicalDetail.HospitalName = listChild[3] == "-" ? "" : listChild[3];
                lstSurgicalDetailTemp.Add(objSurgicalDetail);
            }
        }
        return lstSurgicalDetailTemp;
    }


    // PriorVaccinations javascript table list

    public List<PatientPastVaccinationHistory> getPriorVaccinations()
    {
        List<PatientPastVaccinationHistory> lstPriVacc = new List<PatientPastVaccinationHistory>();
        string HidPrivLine = HdnVaccination.Value;
        foreach (string splitString in HidPrivLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientPastVaccinationHistory objVac = new PatientPastVaccinationHistory();
                    objVac.VaccinationName = lineItems[1];
                    if (lineItems[1] != "")
                    {
                        if (lineItems[2] == "")
                        {
                            objVac.YearOfVaccination = 0;
                        }
                        else
                        {
                            objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
                        }
                    }
                    objVac.MonthName = lineItems[3];
                    objVac.VaccinationDose = lineItems[4];
                    objVac.IsBooster = lineItems[5];
                    objVac.VaccinationID = Convert.ToInt32(lineItems[6]);
                    lstPriVacc.Add(objVac);
                }
            }
        }
        return lstPriVacc;
    }
}
