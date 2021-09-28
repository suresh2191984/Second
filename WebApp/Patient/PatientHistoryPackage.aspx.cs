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
public partial class Patient_PatientHistoryPackage : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    string ddlName, age, ddlDeliveryName, weight, gnormal, grate, ddlBMaturity, ddlDeliveryNameID, ddlBMaturityID, pastComplication, bgpName, bgpDesc;
    string ddlVaccination, Year, ddlMonth, Doses, Booster, ddlVaccinationid;
    string InvDrugData = string.Empty;

    long id1 = 332; long id2 = 402; long id3 = 409;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        if (!IsPostBack)
        {
            try
            {
                if (Request.QueryString["vid"] != null)
                {
                    List<Patient> lstPatient = new List<Patient>();
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    Patient patient = new Patient();
                    patientBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                    hdnSex.Value = lstPatient[0].SEX;
                    if (lstPatient[0].SEX == "M")
                    {
                        //chkSwollenLymphNodes.Style.Add("display", "none");
                        tblGynacHis.Style.Add("display", "none");
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

                #region Get Histories & Complaints to Edit

                Int64.TryParse(Request.QueryString["vid"], out visitID);
                List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> lstPat = new List<PatientHistoryAttribute>();
                List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
                List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
                List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();

                returnCode = new SmartAccessor(base.ContextInfo).GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails,out lsthisPCA,out lstPat);

                #region Retrieve Drug Details if Exists

                if (lstDrugDetails.Count > 0)
                {
                    chkDrugsHistory_1063.Checked = true;
                    divchkDrugsHistory_1063.Attributes.Add("display", "block");

                    if (InvDrugData == "Y")
                    {
                        //uIAdv.SetPrescription(lstDrugDetails);
                    }
                    else
                    {
                        uAd.SetPrescription(lstDrugDetails);
                    }
                }

                #endregion

                #region Retrive Patient Past Vaccination
                if (lstPatientPastVaccinationHistory.Count > 0)
                {
                    chkVaccHis_1064.Checked = true;
                    divchkVaccHis_1064.Attributes.Add("display", "block");
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
                    //vrCount + "~" + ddlVaccination + "~" + Year + "~" + ddlMonth + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^"
                    HdnVaccination.Value = retrivePPV;

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ppvTable", "javascript:LoadPriorVaccinationsItems();", true);
                }
                #endregion

                if (lstANCPatientDetails.Count > 0)
                {
                    chkObsHis_1067.Checked = true;

                    txtGravida.Text = lstANCPatientDetails[0].Gravida.ToString();
                    txtPara.Text = lstANCPatientDetails[0].Para.ToString();
                    txtAbortUs.Text = lstANCPatientDetails[0].Abortus.ToString();
                    txtLive.Text = lstANCPatientDetails[0].Live.ToString();

                    if (lstANCPatientDetails[0].GPLAOthers != null)
                    {
                        txtGPALOthers.Text = lstANCPatientDetails[0].GPLAOthers.ToString();
                    }
                }

                #region Retrive GPAL Details if Exists
                if (lstGPALDetails.Count > 0)
                {
                    if (chkObsHis_1067.Checked == false)
                    {
                        chkObsHis_1067.Checked = true;
                    }
                    //onclick="javascript:showContent(this.id);"
                    //string str = chkObsHis_1067.ID;

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "chkObsHis_1067", "javascript:showContent(" + str + ");", true);
                    divchkObsHis_1067.Attributes.Add("display", "block");
                    int ccount = 1;
                    string retrivegpal = string.Empty;
                    for (int ii = 0; ii < lstGPALDetails.Count; ii++)
                    {


                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tGPAL", "javascript:toggleDiv('divBaseLine');", true);


                        //foreach (GPALDetails gpal in lstGPALDetails)
                        //{
                        ccount = ccount + 1;

                        if (lstGPALDetails[ii].SexOfChild == "M")
                        {
                            ddlName = "Male";
                        }
                        else
                        {
                            ddlName = "Female";
                        }
                        age = lstGPALDetails[ii].Age.ToString();

                        if (lstGPALDetails[ii].ModeOfDeliveryID == 1)
                        {
                            ddlDeliveryNameID = "1";
                            ddlDeliveryName = "Caesarean";
                        }
                        else if (lstGPALDetails[ii].ModeOfDeliveryID == 2)
                        {
                            ddlDeliveryNameID = "2";
                            ddlDeliveryName = "ForcepsDelivery";
                        }
                        else if (lstGPALDetails[ii].ModeOfDeliveryID == 3)
                        {
                            ddlDeliveryNameID = "3";
                            ddlDeliveryName = "VaccumExtraction";
                        }
                        else if (lstGPALDetails[ii].ModeOfDeliveryID == 4)
                        {
                            ddlDeliveryNameID = "4";
                            ddlDeliveryName = "NormalVaginalDelivery";
                        }
                        else
                        {

                        }
                        weight = lstGPALDetails[ii].BirthWeight.ToString();

                        if (lstGPALDetails[ii].IsGrowthNormal == "N")
                        {
                            gnormal = "Normal";
                        }
                        else if (lstGPALDetails[ii].IsGrowthNormal == "A")
                        {
                            gnormal = "Abnormal";
                        }
                        else
                        {
                        }

                        grate = lstGPALDetails[ii].GrowthRate.ToString();

                        if (lstGPALDetails[0].BirthMaturityID == 1)
                        {
                            ddlBMaturityID = "1";
                            ddlBMaturity = "FullTerm";
                        }
                        else if (lstGPALDetails[ii].BirthMaturityID == 2)
                        {
                            ddlBMaturityID = "2";
                            ddlBMaturity = "PreTerm";
                        }
                        else if (lstGPALDetails[ii].BirthMaturityID == 3)
                        {
                            ddlBMaturityID = "3";
                            ddlBMaturity = "PostTerm";
                        }
                        else
                        {

                        }

                        retrivegpal += ccount + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
                        //icout + "~" + ddlName + "~" + age + "~" + ddlDeliveryName + "~" + weight + "~" + gnormal + "~" + grate + "~" + ddlBMaturity + "~" + ddlDeliveryNameID + "~" + ddlBMaturityID + "^";
                        //}
                    }
                    HidBaseLine.Value = retrivegpal;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "gpalTable", "javascript:LoadBaseLineHistroyItems();", true);
                }
                #endregion

                #region Surgical Details

                if (lstSurgicalDetails.Count > 0)
                {
                    chkSurgicalHistory_0.Checked = true;
                }

                #endregion

                #region Retrive Patient History If exists

                for (int i = 0; i < lstPatHisAttribute.Count; i++)
                {
                    #region Social History
                    if (lstPatHisAttribute[i].HistoryID == 476)
                    {
                        divchkTS_476.Attributes.Add("display", "block");
                        chkTS_476.Checked = true;

                        if (lstPatHisAttribute[i].AttributeID == 1)
                        {
                            ddlTypeTS.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 4)
                            {
                                divddlTypeTS.Attributes.Add("display", "block");
                                txtOthersTypeTS.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }
                        if (lstPatHisAttribute[i].AttributeID == 2)
                        {
                            txtDurationTS.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                            ddlTypeTS.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        }
                        if (lstPatHisAttribute[i].AttributeID == 3)
                        {
                            txtPacksTS_9.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                            //ddlTypeTS.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        }
                    }

                    if (lstPatHisAttribute[i].HistoryID == 369)
                    {
                        divchkAC_369.Attributes.Add("display", "block");
                        chkAC_369.Checked = true;

                        if (lstPatHisAttribute[i].AttributeID == 4)
                        {
                            ddlTypesAC.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 12)
                            {
                                divddlTypesAC.Attributes.Add("display", "block");
                                txtOthersTypeAC_17.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }
                        if (lstPatHisAttribute[i].AttributeID == 5)
                        {
                            txtDurationAC.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                            ddlTypesAC.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        }
                        if (lstPatHisAttribute[i].AttributeID == 6)
                        {
                            txtQtyAC.Text = lstPatHisAttribute[i].AttributeValueName.Split(' ')[0].ToString();
                            //ddlTypeTS.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                        }
                    }

                    if (lstPatHisAttribute[i].HistoryID == 1059)
                    {
                        divchkPA_1059.Attributes.Add("display", "block");
                        chkPA_1059.Checked = true;
                        if (lstPatHisAttribute[i].AttributeID == 7)
                        {
                            ddlPhysicialActivity.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
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
                            //txtAnaerobic_23.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                        }
                    }
                    #endregion

                    #region Allergic History

                    if (lstPatHisAttribute[i].HistoryID == 1061)
                    {
                        divchkDrugs_1061.Attributes.Add("display", "block");
                        chkDrugs_1061.Checked = true;
                        if (lstPatHisAttribute[i].AttributeID == 11)
                        {
                            ddlDrugs.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 34)
                            {
                                divddlDrugs.Attributes.Add("display", "block");
                                txtOthersTypeDrugs_34.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }
                    }

                    if (lstPatHisAttribute[i].HistoryID == 1062)
                    {
                        divchkFood_1062.Attributes.Add("display", "block");
                        chkFood_1062.Checked = true;
                        if (lstPatHisAttribute[i].AttributeID == 12)
                        {
                            ddlFoodType.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 37)
                            {
                                divddlFoodType.Attributes.Add("display", "block");
                                txtOthersTypeFood_37.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }
                    }

                    

                    #endregion

                    #region Gyanc History

                    if (lstPatHisAttribute[i].HistoryID == 1065)
                    {
                        chkGynacHis_1065.Checked = true;

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
                            ddlContraception.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 50)
                            {
                                divddlContraception.Attributes.Add("display", "block");
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

                        if (lstPatHisAttribute[i].AttributeID == 22)
                        {
                            ddlTypeofHRT.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 59)
                            {
                                divddlTypeofHRT.Attributes.Add("display", "none");
                                txtOthersTypeofHRT_59.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }

                        if (lstPatHisAttribute[i].AttributeID == 23)
                        {
                            ddlHRTDelivery.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            if (lstPatHisAttribute[i].AttributevalueID == 66)
                            {
                                divddlHRTDelivery.Attributes.Add("display", "none");
                                txtOthersHRTDelivery_66.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            }
                        }
                    }

                    

                    #endregion
                }

                #endregion

                #region Retrive Complaints if exists

                if (lstPCA.Count > 0)
                {
                    for (int j = 0; j < lstPCA.Count; j++)
                    {
                        if (lstPCA[j].ComplaintID == 402)
                        {
                            divchkHighBloodPressure_402.Attributes.Add("display", "block");
                            chkHighBloodPressure_402.Checked = true;

                            if (lstPCA[j].AttributeID == 1)
                            {
                                txtDuration_1.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                                ddlDurationt_1.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            }
                            if (lstPCA[j].AttributeID == 2)
                            {
                                foreach (ListItem liComp in chkTreatment_2.Items)
                                {
                                    
                                }
                            }
                        }
                        if (lstPCA[j].ComplaintID == 332)
                        {
                            divchkHeartDisease_332.Attributes.Add("display", "block");
                            chkHeartDisease_332.Checked = true;
                            if (lstPCA[j].AttributeID == 3)
                            {
                                ddlDiseaseType_3.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                                if (lstPCA[j].AttributevalueID == 16)
                                {
                                    divddlDiseaseType_3.Attributes.Add("display", "block");
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
                            divchkDiabetesMellitus_389.Attributes.Add("display", "block");
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
                                    divddlTreatment_7.Attributes.Add("display", "block");
                                    txtothers_68.Text = lstPCA[j].AttributeValueName.ToString();
                                }
                            }
                        }
                        if (lstPCA[j].ComplaintID == 438)
                        {
                            divchkStroke_438.Attributes.Add("display", "block");
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
                            divchkRaisedCholestrol_409.Attributes.Add("display", "block");
                            chkRaisedCholestrol_409.Checked = true;
                            if (lstPCA[j].AttributeID == 12)
                            {
                                txtduration_12.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                                ddlduration_12.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            }
                        }

                        if (lstPCA[j].ComplaintID == 372)
                        {
                            divchkCancer_372.Attributes.Add("display", "block");
                            chkCancer_372.Checked = true;
                            if (lstPCA[j].AttributeID == 13)
                            {
                                ddlTypeofcancer_13.Text = lstPCA[j].AttributevalueID.ToString();
                            }
                            if (lstPCA[j].AttributeID == 14)
                            {
                                ddlStageofcancer_14.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            }
                            if (lstPCA[j].AttributeID == 15)
                            {
                                ddlTreatment_15.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            }
                        }

                        if (lstPCA[j].ComplaintID == 246)
                        {
                            divchkAsthma_246.Attributes.Add("display", "block");
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
                            divchkThalassemiaTrait_536.Attributes.Add("display", "block");
                            chkThalassemiaTrait_536.Checked = true;
                            if (lstPCA[j].AttributeID == 19)
                            {
                                ddlTrait_19.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                            }
                        }

                        if (lstPCA[j].ComplaintID == 537)
                        {
                            divchkHepatitisBcarrier_537.Attributes.Add("display", "block");
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
                    }
                }

                #endregion

                #endregion

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load", ex);
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        #region Sami
        List<SurgicalDetail> lstSurgicalDetail = new List<SurgicalDetail>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        
        # region High Blood Pressure
        if (chkHighBloodPressure_402.Checked == true)//High Blood Pressure
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(402);
            objPatientComplaint.ComplaintName = chkHighBloodPressure_402.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region Duration_1
            if(txtDuration_1.Text!="")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(1);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDurationt_1.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_1.Text + " " + ddlDurationt_1.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion


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
            }

        }

        #endregion

        # region Heart Disease

        if (chkHeartDisease_332.Checked == true)//HeartDisease
        {

            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(332);
            objPatientComplaint.ComplaintName = chkHeartDisease_332.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region DiseaseType-lblDiseaseType_3

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

            #endregion

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
        #endregion

        # region DiabetesMellitus
        if (chkDiabetesMellitus_389.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(389);
            objPatientComplaint.ComplaintName = chkDiabetesMellitus_389.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region Duration_4
            if (txtDuration_5.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(5);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_5.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_5.Text + " " + ddlDuration_5.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            # region lblType_6
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(6);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlType_6.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlType_6.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            # region lblTreatment_7

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

            #endregion


        }

        #endregion

        #region Stroke

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

            # region lblRecovery_9
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(9);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlRecovery_9.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlRecovery_9.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            # region lblTypeOfCVA_10
            if (ddlTypeOfCVA_10.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(10);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeOfCVA_10.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTypeOfCVA_10.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

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

        #endregion


        #region RaisedCholestrol
        if (chkRaisedCholestrol_409.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(409);
            objPatientComplaint.ComplaintName = chkRaisedCholestrol_409.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region lblDuration_12
            if (txtduration_12.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(409);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(12);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlduration_12.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtduration_12.Text + " " + ddlduration_12.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion
        }
        #endregion

        #region Cancer
        if (chkCancer_372.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(372);
            objPatientComplaint.ComplaintName = chkCancer_372.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region lblTypeofcancer_13
            if (ddlTypeofcancer_13.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeofcancer_13.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTypeofcancer_13.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            # region lblStageofcancer_14
            if (ddlStageofcancer_14.SelectedItem.Text != "--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(14);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlStageofcancer_14.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlStageofcancer_14.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            # region lblTreatment_15
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(15);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTreatment_15.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTreatment_15.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion
        }

        #endregion


        #region Asthma
        if (chkAsthma_246.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(246);
            objPatientComplaint.ComplaintName = chkAsthma_246.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region lblDuration_16
            if (txtDuration_16.Text != "") 
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(16);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_16.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_16.Text + " " + ddlDuration_16.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion


            # region lblTreatment_17
            if(ddlTratment_17.SelectedItem.Text!="--Select--")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(17);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTratment_17.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTratment_17.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

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
        #endregion

        #region ThalassemiaTrait
        if (chkThalassemiaTrait_536.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(536);
            objPatientComplaint.ComplaintName = chkThalassemiaTrait_536.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region lblTrait_19
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(536);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(19);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTrait_19.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTrait_19.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion
        }
        #endregion

        #region HepatitisBcarrier

        if (chkHepatitisBcarrier_537.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(537);
            objPatientComplaint.ComplaintName = chkHepatitisBcarrier_537.Text;
            lstPatientComplaint.Add(objPatientComplaint);

            # region lblDuration_20
            if(txtDuration_20.Text!="")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(20);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_20.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_20.Text + " " + ddlDuration_20.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }
            #endregion

            if (txtTreatment_66.Text != string.Empty)//lblTreatment_21
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(537);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(21);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(66);
                objPatientComplaintAttribute.AttributeValueName = txtTreatment_66.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            }

        }


        #endregion

        lstSurgicalDetail = GetPatientSurgeryDetail();
        #endregion

        #region Prasanna
        List<DrugDetails> pAdvices = new List<DrugDetails>();
        List<PatientPastVaccinationHistory> lstSavePriorVacc = new List<PatientPastVaccinationHistory>();
        List<PatientPastVaccinationHistory> pVaccinationDetails = new List<PatientPastVaccinationHistory>();
        List<GPALDetails> pGPALDetails = new List<GPALDetails>();
        List<GPALDetails> savegpaldetails = new List<GPALDetails>();

        List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();

        #region Social History

        if (chkTS_476.Checked == true)
        {
            PatientHistory hisPKGTS = new PatientHistory();

            hisPKGTS.HistoryID = 476;
            hisPKGTS.ComplaintId = 0;
            hisPKGTS.PatientVisitID = visitID;
            hisPKGTS.Description = "Tobacco Smoking";
            hisPKGTS.HistoryName = "Tobacco Smoking";

            lstPatientHisPKG.Add(hisPKGTS);

            #region Tobacoo smoke

            {
                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                hisPKGAttTS1.PatientVisitID = visitID;
                hisPKGAttTS1.HistoryID = 476;
                hisPKGAttTS1.AttributeID = 1;
                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(ddlTypeTS.SelectedValue);
                if (ddlTypeTS.SelectedItem.Text != "Others")
                {
                    hisPKGAttTS1.AttributeValueName = ddlTypeTS.SelectedItem.Text;
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

            #endregion

        }

        if (chkAC_369.Checked == true)
        {
            PatientHistory hisPKGAC = new PatientHistory();

            hisPKGAC.HistoryID = 369;
            hisPKGAC.ComplaintId = 0;
            hisPKGAC.PatientVisitID = visitID;
            hisPKGAC.Description = "Alcohol Consumption";
            hisPKGAC.HistoryName = "Alcohol Consumption";
            lstPatientHisPKG.Add(hisPKGAC);

            #region Alcohol Consumption

            {
                PatientHistoryAttribute hisPKGAttAC1 = new PatientHistoryAttribute();

                hisPKGAttAC1.PatientVisitID = visitID;
                hisPKGAttAC1.HistoryID = 369;
                hisPKGAttAC1.AttributeID = 4;
                hisPKGAttAC1.AttributevalueID = Convert.ToInt64(ddlTypesAC.SelectedValue);
                if (ddlTypeTS.SelectedItem.Text != "Others")
                {
                    hisPKGAttAC1.AttributeValueName = ddlTypesAC.SelectedItem.Text;
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

            #endregion
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

            #region Physicial Activity

            {
                PatientHistoryAttribute hisPKGAttPA1 = new PatientHistoryAttribute();

                hisPKGAttPA1.PatientVisitID = visitID;
                hisPKGAttPA1.HistoryID = 1059;
                hisPKGAttPA1.AttributeID = 7;
                hisPKGAttPA1.AttributevalueID = Convert.ToInt64(ddlPhysicialActivity.SelectedValue);
                hisPKGAttPA1.AttributeValueName = ddlPhysicialActivity.SelectedItem.Text;

                lstPatientHisPKGAttributes.Add(hisPKGAttPA1);
            }
            if (ddlPhysicialActivity.SelectedValue != "18")
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

            #endregion
        }

        #endregion

        #region Allergic History

        if (chkDrugs_1061.Checked == true)
        {
            PatientHistory hisPKGAH1 = new PatientHistory();

            hisPKGAH1.HistoryID = 1061;
            hisPKGAH1.ComplaintId = 0;
            hisPKGAH1.PatientVisitID = visitID;
            hisPKGAH1.Description = "Drugs";
            hisPKGAH1.HistoryName = "Drugs";
            lstPatientHisPKG.Add(hisPKGAH1);

            #region Drugs
            {
                PatientHistoryAttribute hisPKGAttAH1 = new PatientHistoryAttribute();

                hisPKGAttAH1.PatientVisitID = visitID;
                hisPKGAttAH1.HistoryID = 1061;
                hisPKGAttAH1.AttributeID = 11;
                hisPKGAttAH1.AttributevalueID = Convert.ToInt64(ddlDrugs.SelectedValue);
                if (ddlDrugs.SelectedValue != "34")
                {
                    hisPKGAttAH1.AttributeValueName = ddlDrugs.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttAH1.AttributeValueName = txtOthersTypeDrugs_34.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttAH1);
            }

            #endregion
        }

        if (chkFood_1062.Checked == true)
        {
            PatientHistory hisPKGAH2 = new PatientHistory();
            PatientHistoryAttribute hisPKGAttAH2 = new PatientHistoryAttribute();

            hisPKGAH2.HistoryID = 1062;
            hisPKGAH2.ComplaintId = 0;
            hisPKGAH2.PatientVisitID = visitID;
            hisPKGAH2.Description = "Food Allergy";
            hisPKGAH2.HistoryName = "Food Allergy";
            lstPatientHisPKG.Add(hisPKGAH2);

            #region Food Stuffs
            {
                hisPKGAttAH2.PatientVisitID = visitID;
                hisPKGAttAH2.HistoryID = 1062;
                hisPKGAttAH2.AttributeID = 12;
                hisPKGAttAH2.AttributevalueID = Convert.ToInt64(ddlFoodType.SelectedValue);
                if (ddlFoodType.SelectedValue != "37")
                {
                    hisPKGAttAH2.AttributeValueName = ddlFoodType.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttAH2.AttributeValueName = txtOthersTypeFood_37.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttAH2);
            }

            #endregion
        }

        #endregion

        #region Drugs History

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

        #endregion

        #region Vaccination History

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

        #endregion

        #region Gynac

        PatientHistory hisPKGDGH = new PatientHistory();

        if (chkGynacHis_1065.Checked == true)
        {
            hisPKGDGH.HistoryID = 1065;
            hisPKGDGH.ComplaintId = 0;
            hisPKGDGH.PatientVisitID = visitID;
            hisPKGDGH.Description = "GYNAECOLOGICAL HISTORY";
            hisPKGDGH.HistoryName = "GYNAECOLOGICAL HISTORY";
            lstPatientHisPKG.Add(hisPKGDGH);

            #region Gynac Attributes

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
                hisPKGAttGH2.AttributevalueID = Convert.ToInt64(ddlMenstrualCycle.SelectedValue);
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
                hisPKGAttGH6.AttributevalueID = Convert.ToInt64(ddlLastPapSmearResult.SelectedValue);
                hisPKGAttGH6.AttributeValueName = ddlLastPapSmearResult.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH6);
            }
            if (ddlContraception.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH7 = new PatientHistoryAttribute();

                hisPKGAttGH7.PatientVisitID = visitID;
                hisPKGAttGH7.HistoryID = 1065;
                hisPKGAttGH7.AttributeID = 17;
                hisPKGAttGH7.AttributevalueID = Convert.ToInt64(ddlContraception.SelectedValue);
                if (ddlContraception.SelectedValue != "50")
                {
                    hisPKGAttGH7.AttributeValueName = ddlContraception.SelectedItem.Text;
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

            #endregion
        }

        if (chkHRT_1066.Checked == true)
        {
            PatientHistory hisPKGDHRT = new PatientHistory();

            hisPKGDHRT.HistoryID = 1066;
            hisPKGDHRT.ComplaintId = 0;
            hisPKGDHRT.PatientVisitID = visitID;
            hisPKGDHRT.Description = "Hormone Replacement Theraphy";
            hisPKGDHRT.HistoryName = "Hormone Replacement Theraphy";
            lstPatientHisPKG.Add(hisPKGDHRT);

            #region HRT

            if (ddlTypeofHRT.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT1 = new PatientHistoryAttribute();

                hisPKGAttHRT1.PatientVisitID = visitID;
                hisPKGAttHRT1.HistoryID = 1066;
                hisPKGAttHRT1.AttributeID = 22;
                hisPKGAttHRT1.AttributevalueID = Convert.ToInt64(ddlTypeofHRT.SelectedValue);
                if (ddlTypeofHRT.SelectedValue != "59")
                {
                    hisPKGAttHRT1.AttributeValueName = ddlTypeofHRT.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT1.AttributeValueName = txtOthersTypeofHRT_59.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT1);
            }

            if (ddlHRTDelivery.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT2 = new PatientHistoryAttribute();

                hisPKGAttHRT2.PatientVisitID = visitID;
                hisPKGAttHRT2.HistoryID = 1066;
                hisPKGAttHRT2.AttributeID = 23;
                hisPKGAttHRT2.AttributevalueID = Convert.ToInt64(ddlHRTDelivery.SelectedValue);
                if (ddlHRTDelivery.SelectedValue != "66")
                {
                    hisPKGAttHRT2.AttributeValueName = ddlHRTDelivery.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT2.AttributeValueName = txtOthersHRTDelivery_66.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT2);
            }

            #endregion
        }

        #endregion

        #region Obstratic History

        if (chkObsHis_1067.Checked == true)
        {
            PatientHistory hisPKGDOH = new PatientHistory();
            PatientHistoryAttribute hisPKGAttOH = new PatientHistoryAttribute();

            hisPKGDOH.HistoryID = 1067;
            hisPKGDOH.ComplaintId = 0;
            hisPKGDOH.PatientVisitID = visitID;
            hisPKGDOH.Description = "OBSTRETIC HISTORY";
            hisPKGDOH.HistoryName = "OBSTRETIC HISTORY";
            lstPatientHisPKG.Add(hisPKGDOH);

            savegpaldetails = getBaseLineHistroy();
        }

        #endregion

        #region Save Methods

        #region GPALDetails

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
            pGPALDetails.Add(gdetails);
        }

        #endregion

        #region SaveVaccination

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
            //pvh.MonthOfVaccination = lstSavePriorVacc[i].MonthOfVaccination;
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

        #endregion

        #endregion

        #endregion

        byte g = txtGravida.Text == "" ? (Convert.ToByte(0)) : (Convert.ToByte(txtGravida.Text));
        byte p = txtPara.Text == "" ? (Convert.ToByte(0)) : (Convert.ToByte(txtPara.Text));
        byte l = txtLive.Text == "" ? (Convert.ToByte(0)) : (Convert.ToByte(txtLive.Text));
        byte a = txtAbortUs.Text == "" ? (Convert.ToByte(0)) : (Convert.ToByte(txtAbortUs.Text));

        Patient_BL PatientBL = new Patient_BL(base.ContextInfo);
        try
        {
            long returncode = -1;//returncode = 0;
            returncode = new Patient_BL(base.ContextInfo).SaveHistoryPKG(lstPatientHisPKG, lstPatientHisPKGAttributes, pAdvices, pVaccinationDetails, pGPALDetails, g, p, l, a, txtGPALOthers.Text, lstPatientComplaint, lstPatientComplaintAttribute, lstSurgicalDetail, LID, visitID, patientID);
            if (returncode == 0)
            {
                //returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Changes saved successfully.');", true);
                //List<Role> lstUserRole1 = new List<Role>();
                //string path1 = string.Empty;
                //Role role1 = new Role();
                //role1.RoleID = RoleID;
                //lstUserRole1.Add(role1);
                //returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                //Response.Redirect(Request.ApplicationPath + path1, true);
                Response.Redirect(@"../Patient/PrintHistory.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&pSex=" + hdnSex.Value + "", true);
            }
            //Response.Redirect(@"../Patient/PrintHistory.aspx?vid=" + visitID + "", true); 

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
                if (listChild[2] != "")
                {
                    objSurgicalDetail.TreatmentPlanDate = Convert.ToDateTime(listChild[2]);
                }

                objSurgicalDetail.HospitalName = listChild[3];
                lstSurgicalDetailTemp.Add(objSurgicalDetail);
            }
        }
        return lstSurgicalDetailTemp;
    }


    #region getPriorVaccinations() javascript table
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
                        objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
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
    #endregion

    #region getBaseLineHistroy javascript table
    // BaseLineHistroy javascript table list

    public List<GPALDetails> getBaseLineHistroy()
    {
        List<GPALDetails> lstBaseline = new List<GPALDetails>();
        string HidBLine = HidBaseLine.Value;
        foreach (string splitString in HidBLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    GPALDetails objBaseLine = new GPALDetails();
                    objBaseLine.SexOfChild = lineItems[1];
                    objBaseLine.Age = lineItems[2] == "" ? "0" : lineItems[2];
                    objBaseLine.ModeOfDelivery = lineItems[3];
                    //objBaseLine.BirthWeight = Convert.ToDecimal(lineItems[4]);
                    objBaseLine.BirthWeight = lineItems[4] == "" ? 0 : Convert.ToDecimal(lineItems[4].ToString());
                    objBaseLine.IsGrowthNormal = lineItems[5];
                    objBaseLine.GrowthRate = Convert.ToInt32(lineItems[6]);
                    objBaseLine.ModeOfDeliveryID = Convert.ToInt32(lineItems[8]);
                    objBaseLine.BirthMaturityID = Convert.ToInt32(lineItems[9]);
                    lstBaseline.Add(objBaseLine);
                }
            }
        }
        return lstBaseline;
    }

    #endregion
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
}
