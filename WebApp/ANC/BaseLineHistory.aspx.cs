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
public partial class ANC_BaseLineHistory : BasePage
{
    public string BtnMessage_Save = Resources.ClientSideDisplayTexts.ANC_BaseLineHistory_cs_btnSave_update;
    public ANC_BaseLineHistory()
        : base("ANC\\BaseLineHistory.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

   
    int VisitType = -1;
    string sexofchild = string.Empty;
    string modeofdelivery = string.Empty;
    string birthmaturity = string.Empty;
    long visitID = 0;
    long createdBy = 0;
    long patientid = 0;
    int specialityid = 0;
    int followUP = 0;
    long returnCode = -1;
    long taskID = 0;
    int complaintID = 534;
    string proName = string.Empty;
    string ddlName, age, ddlDeliveryName, weight, gnormal, grate, ddlBMaturity, ddlDeliveryNameID, ddlBMaturityID, pastComplication, bgpName, bgpDesc;
    string gUID = string.Empty;
    
    //for PatientPastVaccination
    string ddlVaccination, Year, ddlMonth, Doses, Booster, ddlVaccinationid;

    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<ANCPatientObservation> lstANCPatientObservation = new List<ANCPatientObservation>();

    protected void Page_Load(object sender, EventArgs e)
    {
        tLMP.Attributes.Add("onchange", "addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
        tLMP.Attributes.Add("onchange", "ExcedDate('" + tLMP.ClientID.ToString() + "','',0,0); addDaysToDateanc('" + tLMP.ClientID.ToString() + "','txtCalculatedEDD');");
        txtGravida.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtPara.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtAbortUs.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtLive.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtAge.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtBwt.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtGrowthRate.Attributes.Add("onkeydown", "return validatenumber(event);");
        TVH.Attributes.Add("onClick", "OnTreeClick(event)");
        txtYear.Attributes.Add("onkeydown", "return validatenumber(event);");
        txtDoses.Attributes.Add("onkeydown", "return validatenumber(event);");
        //btnSave.Attributes.Add("onClientClick", "javascript:getAssociatedDiseasesANC();");
        
        if (!IsPostBack)
        {
            try
            {
                string mode = string.Empty;
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientid);
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                //mode = Request.QueryString["mode"].ToString();

                patientHeader.PatientVisitID = visitID;

                ANC_BL ancBL = new ANC_BL(base.ContextInfo);

                //Get No. of Visist for the Single ANC Patient for redirect to Followup Page

                //Get Speciality Id
                ancBL.GetANCSpecilaityID(visitID, out specialityid, out followUP);

                if ((Request.QueryString["mode"] == null || Request.QueryString["mode"] == "e"))
                {

                    //To load mode of delivery
                    loadmodeofdelivery();

                    //To load Birth Maturity
                    loadbirthmaturity();

                    //To load all ANC Complication
                    loadPreviousComplicatedPregnancies();

                    //To load all ANC Specilaity complaint 
                    if (Request.QueryString["mode"] != "e")
                    {
                        if (followUP <= 1)
                        {
                            loadANCComplaint();
                        }
                    }

                    //To load Vaccination
                    loadpriorvaccination();

                    //To load Placental position
                    loadplacentalpositions();

                    //To load Investigations()
                    loadInvestigation();

                    //Load Data's to investigation Control
                    List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                    List<PatientVisit> lPatientVisit = new List<PatientVisit>();
                    int clientID = 0;
                    new PatientVisit_BL(base.ContextInfo).GetCorporateClientByVisit(visitID, out lPatientVisit);
                    if (lPatientVisit.Count > 0)
                    {
                        clientID = Convert.ToInt32(lPatientVisit[0].ClientMappingDetailsID);
                    }

                    new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), complaintID, clientID, out lstgroups, out lstInvestigations);
                    int orgBased = OrgID;
                    InvestigationControl1.OrgSpecific = orgBased;
                    InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);

                    List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                    //List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
                    List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                    List<PatientUltraSoundData> lstPatientUltraSoundData = new List<PatientUltraSoundData>();
                    List<PatientPastComplication> lstPatientPastComplication = new List<PatientPastComplication>();
                    List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
                    List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 

                    ANC_BL ancdetails = new ANC_BL(base.ContextInfo);

                    ancdetails.GetANCDetailsbyPVIDCommand(patientid, visitID, complaintID, out lstANCPatientDetails, out lstBackgroundProblem, out lstGPALDetails, out lstPatientUltraSoundData, out lstPatientPastComplication, out lstPatientPastVaccinationHistory, out lstPatientInvestigationHL, out proName, out lstANCPatientObservation);

                    if (lstANCPatientObservation.Count > 0)
                    {
                        txtObservation.Text = lstANCPatientObservation[0].Observation;
                    }

                    if (Request.QueryString["mode"] == null && lstANCPatientDetails.Count <= 0)
                    {
                        PatientVitalsControl.FindControl("txtTemp").Focus();
                        PatientVitalsControl.VisitID = visitID;
                        PatientVitalsControl.LoadControls("I", patientid);
                        //txtDateOfUltraSound.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                        btnSave.Visible = true;
                        btnCancel.Visible = true;
                    }
                    else
                    {
                        List<Role> lstUserRole1 = new List<Role>();
                        string path1 = string.Empty;
                        Role role1 = new Role();
                        role1.RoleID = RoleID;
                        lstUserRole1.Add(role1);
                        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                        string strValues = path1.Split('/')[1];

                        if (strValues == "Nurse")
                        {
                            if (Request.QueryString["mode"] == "e")
                            {
                                btnSave.Visible = true;
                                
                                btnSave.Text = BtnMessage_Save;
                                btnCancel.Visible = true;
                            }
                            else
                            {
                                //if (lstANCPatientDetails[0].CreatedBy == LID)
                                {
                                    btnSave.Visible = true;
                                    btnCancel.Visible = true;
                                }
                                //else
                                //{
                                    //btnCancel.Text = "Close";
                                    //btnCancel.Visible = true;
                                //}
                            }
                        }
                        else
                        {
                            if (Request.QueryString["mode"] == "e")
                            {
                                btnPatientDiagnose.Visible = true;
                                btnSave.Visible = true;
                                btnSave.Text = BtnMessage_Save;
                            }
                            else
                            {
                                if (lstANCPatientDetails[0].CreatedBy == LID)
                                {
                                    btnSave.Visible = true;
                                    btnCancel.Visible = true;
                                }
                                else
                                {
                                    btnPatientDiagnose.Visible = true;
                                    btnSave.Visible = true;
                                }
                            }
                        }

                        PatientVitalsControl.FindControl("txtTemp").Focus();
                        PatientVitalsControl.VisitID = visitID;
                        PatientVitalsControl.LoadControls("U", patientid);

                        if (lstANCPatientDetails.Count > 0)
                        {
                            #region Retrive ANCPatientDetails If exists

                            if (lstANCPatientDetails[0].PregnancyStatus == "1")
                            {
                                drpPregnancy.SelectedValue = "1";
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:toggleDropDownDiv('drpPregnancy','tblPregnancy');", true);
                                if (lstANCPatientDetails[0].IsPrimipara == "1")
                                {
                                    chkIsPrimipara.Checked = true;
                                }
                                if (lstANCPatientDetails[0].IsBadObstretic == "1")
                                {
                                    chkIsBad.Checked = true;
                                }
                            }
                            else if (lstANCPatientDetails[0].PregnancyStatus == "2")
                            {
                                drpPregnancy.SelectedValue = "2";
                            }
                            else if (lstANCPatientDetails[0].PregnancyStatus == "3")
                            {
                                drpPregnancy.SelectedValue = "3";
                            }
                            tLMP.Text = Convert.ToDateTime(lstANCPatientDetails[0].LMPDate).ToShortDateString();
                            txtCalculatedEDD.Text = Convert.ToDateTime(lstANCPatientDetails[0].EDD).ToShortDateString();

                            txtGravida.Text = lstANCPatientDetails[0].Gravida.ToString();
                            txtPara.Text = lstANCPatientDetails[0].Para.ToString();
                            txtAbortUs.Text = lstANCPatientDetails[0].Abortus.ToString();
                            txtLive.Text = lstANCPatientDetails[0].Live.ToString();

                            if (lstANCPatientDetails[0].GPLAOthers != null)
                            {
                                txtGPALOthers.Text = lstANCPatientDetails[0].GPLAOthers.ToString();
                            }
                            if ((lstANCPatientDetails[0].BloodGroup != null) || (lstANCPatientDetails[0].BloodGroup != ""))
                            {
                                txtBloodGroup.SelectedValue = lstANCPatientDetails[0].BloodGroup.ToString();
                            }

                            #endregion

                            #region Retrive GPAL Details if Exists
                            int ccount = 1;
                            string retrivegpal = string.Empty;
                            for (int i = 0; i < lstGPALDetails.Count; i++)
                            {


                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tGPAL", "javascript:toggleDiv('divBaseLine');", true);


                                //foreach (GPALDetails gpal in lstGPALDetails)
                                //{
                                ccount = ccount + 1;

                                if (lstGPALDetails[i].SexOfChild == "M")
                                {
                                    ddlName = "Male";
                                }
                                else
                                {
                                    ddlName = "Female";
                                }
                                age = lstGPALDetails[i].Age.ToString();

                                if (lstGPALDetails[i].ModeOfDeliveryID == 1)
                                {
                                    ddlDeliveryNameID = "1";
                                    ddlDeliveryName = "Caesarean";
                                }
                                else if (lstGPALDetails[i].ModeOfDeliveryID == 2)
                                {
                                    ddlDeliveryNameID = "2";
                                    ddlDeliveryName = "ForcepsDelivery";
                                }
                                else if (lstGPALDetails[i].ModeOfDeliveryID == 3)
                                {
                                    ddlDeliveryNameID = "3";
                                    ddlDeliveryName = "VaccumExtraction";
                                }
                                else if (lstGPALDetails[i].ModeOfDeliveryID == 4)
                                {
                                    ddlDeliveryNameID = "4";
                                    ddlDeliveryName = "NormalVaginalDelivery";
                                }
                                else
                                {

                                }
                                weight = lstGPALDetails[i].BirthWeight.ToString();

                                if (lstGPALDetails[i].IsGrowthNormal == "N")
                                {
                                    gnormal = "Normal";
                                }
                                else if (lstGPALDetails[i].IsGrowthNormal == "A")
                                {
                                    gnormal = "Abnormal";
                                }
                                else
                                {
                                }

                                grate = lstGPALDetails[i].GrowthRate.ToString();

                                if (lstGPALDetails[0].BirthMaturityID == 1)
                                {
                                    ddlBMaturityID = "1";
                                    ddlBMaturity = "FullTerm";
                                }
                                else if (lstGPALDetails[i].BirthMaturityID == 2)
                                {
                                    ddlBMaturityID = "2";
                                    ddlBMaturity = "PreTerm";
                                }
                                else if (lstGPALDetails[i].BirthMaturityID == 3)
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
                            #endregion

                            #region Retrive Previous Complicated Pregnencies

                            string retrivePCP = string.Empty;
                            for (int j = 0; j < lstPatientPastComplication.Count; j++)
                            {
                                foreach (ListItem li in PCP.Items)
                                {
                                    if (li.Value == lstPatientPastComplication[j].ComplicationID.ToString())
                                    {
                                        li.Selected = true;
                                    }
                                }

                                if (lstPatientPastComplication[j].ComplicationID == 0)
                                {
                                    pastComplication = lstPatientPastComplication[j].ComplicationName;
                                    retrivePCP += pastComplication + "^";
                                }

                            }
                            HdnPreviousComplicate.Value = retrivePCP;
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "pcpTable", "javascript:LoadPreviousComplicateItems();", true);

                            #endregion

                            //if (followUP <= 1)
                            //{
                                #region Retrive Background Problem if Exists

                                string retriveBGP = string.Empty;


                                int asociateDiseaseCount = 1;
                                for (int k = 0; k < lstBackgroundProblem.Count; k++)
                                {


                                    if (lstBackgroundProblem[k].ComplaintID == 0)
                                    {
                                        asociateDiseaseCount = asociateDiseaseCount + 1;
                                        bgpName = lstBackgroundProblem[k].ComplaintName;
                                        bgpDesc = lstBackgroundProblem[k].Description;

                                        retriveBGP += asociateDiseaseCount + "~" + bgpName + "~" + bgpDesc + "^";
                                    }


                                }
                                HdnAssociate.Value = retriveBGP;
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTable", "javascript:LoadAssociateDieasesItems();", true);

                                //if (Request.QueryString["mode"] == "e")
                                //{
                                    loadANCComplaint();
                                //}
                                #endregion

                                #region Retrive Patient Past Vaccination

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

                                #endregion
                            //}

                            #region Patient Ultra Sound If Exists

                            drpweeks.SelectedValue = lstPatientUltraSoundData[0].GestationalWeek.ToString();
                            drpDays.SelectedValue = lstPatientUltraSoundData[0].GestationalDays.ToString();
                            drpPlacental.SelectedValue = lstPatientUltraSoundData[0].PlacentalPositionID.ToString();
                            drpMultiGest.SelectedValue = lstPatientUltraSoundData[0].MultipleGestation.ToString();
                            txtOther1.Text = lstPatientUltraSoundData[0].PlacentalPositionName;
                            if (Convert.ToString(lstPatientUltraSoundData[0].DateOfUltraSound.ToShortDateString()) != "01/01/0001")
                            {
                                txtDateOfUltraSound.Text = lstPatientUltraSoundData[0].DateOfUltraSound.ToShortDateString();
                            }
                            else
                            {

                            }

                            #endregion

                            #region Retrive Patient Investigation if Exists

                            if (lstPatientInvestigationHL.Count > 0)
                            {
                                //String orderedList = string.Empty;

                                //bool investigationAvailableInMapping = false;
                                //bool groupAvailableInMapping = false;
                                if (Request.QueryString["VDT"] != "Y")
                                {
                                    for (int z = 0; z < lstPatientInvestigationHL.Count; z++)
                                    {
                                        foreach (ListItem li in chkInvestigation.Items)
                                        {
                                            if (li.Value == lstPatientInvestigationHL[z].InvestigationID.ToString() && lstPatientInvestigationHL[z].Status!="Completed")
                                            {
                                                li.Selected = true;
                                                //investigationAvailableInMapping = true;
                                                //groupAvailableInMapping = true;
                                            }
                                        }

                                        //    if (!groupAvailableInMapping && !investigationAvailableInMapping)
                                        //    {
                                        //        if (lstPatientInvestigation[z].GroupID > 0)
                                        //        {
                                        //            if (!orderedList.Contains(lstPatientInvestigation[z].GroupName))
                                        //            {
                                        //                orderedList += lstPatientInvestigation[z].GroupID + "~" + lstPatientInvestigation[z].GroupName + "~GRP^";
                                        //            }
                                        //        }
                                        //        else
                                        //        {
                                        //            if (!orderedList.Contains(lstPatientInvestigation[z].InvestigationName))
                                        //            {
                                        //                orderedList += lstPatientInvestigation[z].InvestigationID + "~" + lstPatientInvestigation[z].InvestigationName + "~INV^";
                                        //            }
                                        //        }

                                        //        continue;

                                        //    }

                                        //    if (!investigationAvailableInMapping && lstPatientInvestigation[z].GroupID < 1)
                                        //    {
                                        //        if (!orderedList.Contains(lstPatientInvestigation[z].InvestigationName))
                                        //        {
                                        //            orderedList += lstPatientInvestigation[z].InvestigationID + "~" + lstPatientInvestigation[z].InvestigationName + "~INV^";
                                        //        }

                                        //    }

                                        //    if (!groupAvailableInMapping)
                                        //    {
                                        //        if (lstPatientInvestigation[z].GroupID > 0)
                                        //        {
                                        //            if (!orderedList.Contains(lstPatientInvestigation[z].GroupName))
                                        //            {
                                        //                orderedList += lstPatientInvestigation[z].GroupID + "~" + lstPatientInvestigation[z].GroupName + "~GRP^";
                                        //            }
                                        //        }
                                        //    }

                                    }
                                }

                                //InvestigationControl1.setOrderedList(orderedList);
                                //if (Request.QueryString["VDT"] == "Y")
                                //{
                                    dlInvName.DataSource = lstPatientInvestigationHL;
                                    dlInvName.DataBind();
                               // }
                            }

                            #endregion

                            #region Physiotheraphy if Exists

                            if ((Request.QueryString["VDT"] != "Y") && (Request.QueryString["mode"] != "e"))
                            {
                                if (proName != "")
                                {
                                    chkPHYSIOTHERAPY.Checked = true;
                                    //lblPhyOrdered.Text = proName.ToString() + " Ordered already";
                                }
                                else
                                {
                                    lblPhyOrdered.Text = string.Empty;
                                }
                            }
                            if ((Request.QueryString["VDT"] == "Y") || (Request.QueryString["mode"] == "e"))
                            {
                                if (proName != "")
                                {
                                    //chkPHYSIOTHERAPY.Checked = true;
                                    string Ordered = Resources.ClientSideDisplayTexts.ANC_BaseLineHistory_aspx_cs_AlreadyOrdered;
                                    lblPhyOrdered.Text = proName.ToString() + Ordered;
                                }
                                else
                                {
                                    lblPhyOrdered.Text = string.Empty;
                                }
                            }

                            #endregion
                        }
                    }
                }
                else if (followUP >= 1 && Request.QueryString["mode"] != null)
                {
                    Response.Redirect(@"../ANC/BaseLineHistoryFollowup.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&sid=" + specialityid + "&role=" + "D" + "&mode=" + "rm" + "", true);
                }
                else if (followUP >= 1 && Request.QueryString["role"] != null)
                {
                    Response.Redirect(@"../ANC/BaseLineHistoryFollowup.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&sid=" + specialityid + "&role=" + "D" + "", true);
                }
                else
                {
                    Response.Redirect(@"../ANC/BaseLineHistoryFollowup.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&sid=" + specialityid + "", true);
                }
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error on pageload", ex);
            }
        }
    }

    #region Methods to be called during PageLoad

    #region Load Mode of Delivery
    //get mode of delivery
    protected void loadmodeofdelivery()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<ModeOfDelivery> lstMod = new List<ModeOfDelivery>();
            returnCode = ancBL.GetModeOfDelivery(out lstMod);
            loadGRD_modeofdelivery(lstMod);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    //load of mode of delivery to drop down
    protected void loadGRD_modeofdelivery(List<ModeOfDelivery> lstMod)
    {
        if (lstMod.Count > 0)
        {
            drpMOD.DataSource = lstMod;
            drpMOD.DataTextField = "ModeOfDeliveryDesc";
            drpMOD.DataValueField = "ModeOfDeliveryId";
            drpMOD.DataBind();
        }
    }
    #endregion

    #region Load Birth Maturity
    //To load birth maturity in dropdown
    protected void loadbirthmaturity()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<BirthMaturity> lstBirthMaturity = new List<BirthMaturity>();
            returnCode = ancBL.GetBirthMaturity(out lstBirthMaturity);
            loadGRD_birthmaturity(lstBirthMaturity);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    protected void loadGRD_birthmaturity(List<BirthMaturity> lstBirthMaturity)
    {
        if (lstBirthMaturity.Count > 0)
        {
            drpBMaturity.DataSource = lstBirthMaturity;
            drpBMaturity.DataTextField = "BirthMaturityDesc";
            drpBMaturity.DataValueField = "BirthMaturityID";
            drpBMaturity.DataBind();
        }
    }
    #endregion

    #region Load Previous Complicated Pregnancies

    protected void loadPreviousComplicatedPregnancies()
    {
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<Complication> lstComplication = new List<Complication>();
            //To get complication   
            ancBL.GetPregnancyComplication(specialityid, out lstComplication);
            loadComplication(lstComplication);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    //To load complication in check box list
    public void loadComplication(List<Complication> lstComplication)
    {
        if (lstComplication.Count > 0)
        {
            PCP.Items.Clear();

            foreach (Complication com in lstComplication)
            {
                PCP.Items.Add(new ListItem(com.ComplicationName, Convert.ToString(com.ComplicationID)));
            }
        }
    }

    #endregion

    #region Load ANC Complaint in TREE Control

    protected void loadANCComplaint()
    {

        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<Complaint> lstComplaint = new List<Complaint>();
            //Get all ANC complaint
            ancBL.GetANCComplaint(specialityid, out lstComplaint);
            SetANCComplaint(lstComplaint);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    //Load Complaint in Tree view
    void SetANCComplaint(List<Complaint> complaint)
    {
        try
        {
            string Complaint=Resources.ClientSideDisplayTexts.ANC_BaseLineHistory_aspx_cs_Complaint;
            TVH.NodeStyle.CssClass = "defaultfontcolor";
            TVH.NodeIndent = 0;
            TVH.Nodes[0].Text = "Complaints";

            AddHistChildNode(TVH.Nodes[0], complaint);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetHistory", ex);
        }
    }

    void AddHistChildNode(TreeNode parent, List<Complaint> complaint)
    {
        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryHistories = from ex in complaint
                             where ex.ParentID == parentID
                             select ex;
        string treeNodeText = string.Empty;
        foreach (var ex in queryHistories)
        {

            treeNodeText = ex.ParentID == 0 ? "<a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" +
                                               ex.ComplaintId.ToString() + "','tCA" + ex.ComplaintId.ToString() +
                                               "');\">" + ex.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + ex.ComplaintId.ToString() + "'>"
                                               : ex.ComplaintName;
            //treeNodeText = ex.ParentID != 0 ? "<a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" +
            //                                   ex.ComplaintId.ToString() + "','tCA" + ex.ComplaintId.ToString() +
            //                                   "');\">" + ex.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + ex.ComplaintId.ToString() + "'>"
            //                                   : "<input id='tCA" + ex.ComplaintId.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tA" + ex.ComplaintId.ToString() + "','tCA" + ex.ComplaintId.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" + ex.ComplaintId.ToString() + "','tCA" + ex.ComplaintId.ToString() + "');\">" + ex.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + ex.ComplaintId.ToString() + "'>";
            
            
            TreeNode tn = new TreeNode();
            tn.SelectAction = TreeNodeSelectAction.None;
            tn.Text = treeNodeText;
            tn.Value = ex.ComplaintId.ToString();
            tn.Collapse();
            tn.PopulateOnDemand = false;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
        }

        for (int i = 0; i < parent.ChildNodes.Count; i++)
        {

            var queryHistories1 = from exc in complaint
                                  where exc.ParentID == Convert.ToInt32(parent.ChildNodes[i].Value)
                                  select exc;
            if (queryHistories1.Count() > 0)
            {
                foreach (var exc in queryHistories1)
                {
                    treeNodeText=exc.ParentID != 0 ? "<input id='tCA" 
                                    + exc.ComplaintId.ToString() 
                                    + "' type='checkbox' value='' onclick=javascript:Showtext('tA" 
                                    + exc.ComplaintId.ToString() 
                                    + "','tCA" + exc.ComplaintId.ToString() 
                                    + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" 
                                    + exc.ComplaintId.ToString() + "','tCA"
                                    + exc.ComplaintId.ToString() + "');\">" 
                                    + exc.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA"
                                    + exc.ComplaintId.ToString() + "'>" : exc.ComplaintName;

                    
                    if (lstBackgroundProblem.Count > 0)
                    {
                        foreach (BackgroundProblem bgkProblem in lstBackgroundProblem)
                        {
                            if (exc.ComplaintId == bgkProblem.ComplaintID)
                            {
                                treeNodeText = exc.ParentID != 0 ? "<input id='tCA" 
                                               + exc.ComplaintId.ToString() 
                                               + "' type='checkbox' checked='true' value='' onclick=javascript:Showtext('tA" 
                                               + exc.ComplaintId.ToString() + "','tCA" 
                                               + exc.ComplaintId.ToString() 
                                               + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" 
                                               + exc.ComplaintId.ToString() 
                                               + "','tCA" 
                                               + exc.ComplaintId.ToString() 
                                               + "');\">" + exc.ComplaintName 
                                               + "</a>&nbsp;<input type='text' value='"+ bgkProblem.Description
                                               +"' class='textbox_hemat' style='visibility:block;width:50px' id='tA" 
                                               + exc.ComplaintId.ToString() + "'>" : exc.ComplaintName;
                            }
                        }
                    }
                    TreeNode tn = new TreeNode(treeNodeText);
                    tn.SelectAction = TreeNodeSelectAction.None;
                    parent.ChildNodes[i].ChildNodes.Add(tn);
                    //treeNodeText = exc.ParentID == 0 ? "<input id='tCA" + exc.ComplaintId.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" + exc.ComplaintId.ToString() + "','tCA" + exc.ComplaintId.ToString() + "');\">" + exc.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + exc.ComplaintId.ToString() + "'>" : exc.ComplaintName;
                    
                }
            }
        }

    }


    

    #endregion

    #region Load Placental Positions

    //get Placental position from DB
    protected void loadplacentalpositions()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<PlacentalPositions> lstPlacentalPositions = new List<PlacentalPositions>();
            returnCode = ancBL.GetPlacentalPositions(out lstPlacentalPositions);
            loadGRD_placentalpositions(lstPlacentalPositions);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    //Load Placental Position to drop down
    protected void loadGRD_placentalpositions(List<PlacentalPositions> lstPlacentalPositions)
    {
        if (lstPlacentalPositions.Count > 0)
        {
            drpPlacental.DataSource = lstPlacentalPositions;
            drpPlacental.DataTextField = "PlacentalPositionName";
            drpPlacental.DataValueField = "PlacentalPositionID";
            drpPlacental.DataBind();
            drpPlacental.Items.Insert(0, "Select");
            drpPlacental.Items[0].Value = "0";
        }
    }

    #endregion

    #region Load Prior Vaccination

    //get Vaccination from DB
    protected void loadpriorvaccination()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<Vaccination> lstVaccination = new List<Vaccination>();
            returnCode = ancBL.GetPriorVaccination(out lstVaccination);
            loadGRD_priorvaccination(lstVaccination);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    //Load vaccination to dropdown

    protected void loadGRD_priorvaccination(List<Vaccination> lstVaccination)
    {
        if (lstVaccination.Count > 0)
        {
            //int temp = lstVaccination.Count();
            //lstVaccination[temp - 1].VaccinationName = "Other Vaccination";
            drpVaccination.DataSource = lstVaccination;
            drpVaccination.DataTextField = "VaccinationName";
            drpVaccination.DataValueField = "VaccinationID";
            drpVaccination.DataBind();
        }
    }

    #endregion

    #region Load Investigations

    protected void loadInvestigation()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();
            returnCode = ancBL.GetANCInvestigation(complaintID, out lstInvestigationMaster);
            loadGRD_InvestigationMaster(lstInvestigationMaster);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }
    protected void loadGRD_InvestigationMaster(List<InvestigationMaster>lstInvestigationMaster)
    {
        chkInvestigation.DataSource = lstInvestigationMaster;
        chkInvestigation.DataTextField = "InvestigationName";
        chkInvestigation.DataValueField = "InvestigationID";
        chkInvestigation.DataBind();
    }

    #endregion

    #endregion

    protected void drdSOC_SelectedIndexChanged(object sender, EventArgs e)
    {
        sexofchild = drdSOC.SelectedItem.Text;
    }

    protected void drpBMaturity_SelectedIndexChanged(object sender, EventArgs e)
    {
        birthmaturity = drpBMaturity.SelectedItem.Text;
    }

    protected void drpMOD_SelectedIndexChanged(object sender, EventArgs e)
    {
        modeofdelivery = drpMOD.SelectedItem.Text;
    }

    protected void TVH_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        if (TVH.Nodes[0].Checked)
        {
            for (int i = 0; i < TVH.Nodes[0].ChildNodes.Count; i++)
            {
                TVH.Nodes[0].ChildNodes[i].Checked = true;

            }
        }
    }

    protected void TVH_SelectedNodeChanged(object sender, EventArgs e)
    {
        if (TVH.Nodes[0].Checked)
        {
            for (int i = 0; i < TVH.Nodes[0].ChildNodes.Count; i++)
            {
                TVH.Nodes[0].ChildNodes[i].Checked = true;
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        savedata();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (btnCancel.Text != "Close")
        {
            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath + path1, true);
        }
        else
        {
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);

            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath + path1, true);
        }

    }

    protected void btnPatientDiagnose_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["pid"], out patientid);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);

        Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "", true);
    }

    protected void savedata()
    {
        btnSave.Visible = false;

        string role = string.Empty;
        Int64.TryParse(Request.QueryString["pid"], out patientid);
        Int64.TryParse(Request.QueryString["vid"], out visitID);

        if (Request.QueryString["mode"] != "e")
        {
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
        }
        
        ANC_BL ancBL = new ANC_BL(base.ContextInfo);

        List<GPALDetails> pGPALDetails = new List<GPALDetails>();
        List<BackgroundProblem> pComplaint = new List<BackgroundProblem>();
        List<PatientPastVaccinationHistory> pVaccinationDetails = new List<PatientPastVaccinationHistory>();
        List<PatientPastComplication> lstPComplication = new List<PatientPastComplication>();

        List<GPALDetails> savegpaldetails = new List<GPALDetails>();
        List<PatientPastComplication> lstSavePreComp = new List<PatientPastComplication>();
        List<Complaint> lstSaveAssociateDis = new List<Complaint>();
        List<PatientPastVaccinationHistory> lstSavePriorVacc = new List<PatientPastVaccinationHistory>();
        List<PatientInvestigation> pInvestigations = new List<PatientInvestigation>(); List<OrderedInvestigations> pInvestigationsHL = new List<OrderedInvestigations>();

        savegpaldetails = getBaseLineHistroy();
        lstSavePreComp = getPreviousComplicate();
        lstSaveAssociateDis = getAssociateDiseases();
        lstSavePriorVacc = getPriorVaccinations();

        try
        {
            int NoOfVitalsEntered = 0;
            List<PatientVitals> lstPatientVitals = new List<PatientVitals>();

            if (PatientVitalsControl.GetPageValues(visitID, false, out NoOfVitalsEntered, out lstPatientVitals))
            {
                if (NoOfVitalsEntered <= 0)
                    lstPatientVitals.Clear();

                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                PatientVisit_BL oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
                returnCode = oPatientVisit_BL.GetVisitDetails(visitID, out lstPatientVisit);
                foreach (var opatieentVistDetails in lstPatientVisit)
                {
                    VisitType = opatieentVistDetails.VisitType;
                }
                foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
                {
                    if (VisitType == 0)
                    {

                        patientVitals.VitalsSetID = 0;
                    }
                }

                #region Observation
                ANCPatientObservation objANCPatientObservation = new ANCPatientObservation();
                if (txtObservation.Text != "")
                {
                    objANCPatientObservation.Observation = txtObservation.Text;
                    objANCPatientObservation.CreatedBy = LID;
                    objANCPatientObservation.OrgAddressID = ILocationID;

                }

                

                #endregion


                #region GPALDetails

                //Save GPALDetails

                for (int i = 0; i < savegpaldetails.Count; i++)
                {
                    GPALDetails gdetails = new GPALDetails();
                    gdetails.PatientID = patientid;
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

                    //string mod = string.Empty;
                    //mod = savegpaldetails[i].ModeOfDelivery;

                    //if (mod == TaskHelper.modeofDelivery.Caesarean.ToString())
                    //{
                    //    gdetails.ModeOfDeliveryID = Convert.ToInt32(TaskHelper.modeofDelivery.Caesarean);
                    //}
                    //else if (mod == TaskHelper.modeofDelivery.ForcepsDelivery.ToString())
                    //{
                    //    gdetails.ModeOfDeliveryID = Convert.ToInt32(TaskHelper.modeofDelivery.ForcepsDelivery);
                    //}
                    //else if (mod == TaskHelper.modeofDelivery.NormalVaginalDelivery.ToString())
                    //{
                    //    gdetails.ModeOfDeliveryID = Convert.ToInt32(TaskHelper.modeofDelivery.NormalVaginalDelivery);
                    //}
                    //else if (mod == TaskHelper.modeofDelivery.VaccumExtraction.ToString())
                    //{
                    //    gdetails.ModeOfDeliveryID = Convert.ToInt32(TaskHelper.modeofDelivery.VaccumExtraction);
                    //}
                    //else
                    //{
                    //}

                    //gdetails.ModeOfDeliveryID = savegpaldetails[i].ModeOfDeliveryID;

                    gdetails.BirthWeight = savegpaldetails[i].BirthWeight;

                    //string bm = string.Empty;
                    //bm = savegpaldetails[i].BirthMaturity;

                    //if (bm == TaskHelper.birthMaturity.FullTerm.ToString())
                    //{
                    //    gdetails.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.FullTerm);
                    //}
                    //else if (bm == TaskHelper.birthMaturity.PreTerm.ToString())
                    //{
                    //    gdetails.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.PreTerm);
                    //}
                    //else if (bm == TaskHelper.birthMaturity.PostTerm.ToString())
                    //{
                    //    gdetails.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.PostTerm);
                    //}
                    //else
                    //{
                    //}

                    gdetails.BirthMaturityID = savegpaldetails[i].BirthMaturityID;

                    gdetails.IsGrowthNormal = strGrowth;
                    gdetails.GrowthRate = savegpaldetails[i].GrowthRate;
                    gdetails.PatientVisitID = visitID;
                    gdetails.CreatedBy = LID;
                    pGPALDetails.Add(gdetails);
                }

                #endregion

                #region SaveComplaint

                //Save Complaint

                foreach (string desc in hdComplaint.Value.Split('^'))
                {
                    if (desc.Split('~').Length > 1)
                    {
                        BackgroundProblem pex = new BackgroundProblem();
                        pex.ComplaintID = Convert.ToInt32(desc.Split('~')[0]);
                        pex.PatientID = patientid;
                        pex.PatientVisitID = visitID;
                        pex.Description = desc.Split('~')[1];
                        pex.CreatedBy = LID;

                        //pex.ComplaintId = complaintID;
                        pComplaint.Add(pex);
                    }
                }


                foreach (string desc in HdnAssociate.Value.Split('^'))
                {
                    if (desc.Split('~').Length > 1)
                    {
                        BackgroundProblem pex = new BackgroundProblem();
                        pex.ComplaintName = desc.Split('~')[0];
                        pex.PatientID = patientid;
                        pex.PatientVisitID = visitID;
                        pex.Description = desc.Split('~')[1];
                        pex.CreatedBy = LID;
                        pex.Status = "Y";
                        pex.Priority = 1;
                        pComplaint.Add(pex);
                    }
                }

                #endregion

                #region ANCPatientDetails

                //ANCPatientDetails

                DateTime LMP = new DateTime();
                DateTime EDD = new DateTime();
                string pregnancystatus = string.Empty;
                string isprimipara = string.Empty;
                string isbad = string.Empty;
                ANCPatientDetails ancpatientdetails = new ANCPatientDetails();
                ancpatientdetails.PatientID = patientid;
                ancpatientdetails.PatientVisitID = visitID;
                if (tLMP.Text.Trim().Length > 0)
                {
                    if (!DateTime.TryParse(tLMP.Text, out LMP))
                        LMP = new DateTime(1800, 1, 1);
                }
                else
                {
                    // Min. default date.DateTime cannot be null and cannot be less that 1701
                    LMP = new DateTime(1800, 1, 1);
                }
                ancpatientdetails.LMPDate = LMP;
                if (txtCalculatedEDD.Text.Trim().Length > 0)
                {
                    if (!DateTime.TryParse(txtCalculatedEDD.Text, out EDD))
                        EDD = new DateTime(1800, 1, 1);
                }
                else
                {
                    // Min. default date.DateTime cannot be null and cannot be less that 1701
                    EDD = new DateTime(1800, 1, 1);
                }
                ancpatientdetails.EDD = EDD;
                if (txtGravida.Text != "")
                    ancpatientdetails.Gravida = Convert.ToByte(txtGravida.Text);
                if (txtPara.Text != "")
                    ancpatientdetails.Para = Convert.ToByte(txtPara.Text);
                if (txtLive.Text != "")
                    ancpatientdetails.Live = Convert.ToByte(txtLive.Text);
                if (txtAbortUs.Text != "")
                    ancpatientdetails.Abortus = Convert.ToByte(txtAbortUs.Text);

                if (drpPregnancy.SelectedItem.Text == "Confirmed")
                    pregnancystatus = "1";
                else if (drpPregnancy.SelectedItem.Text == "To re-confirm")
                    pregnancystatus = "2";
                else if (drpPregnancy.SelectedItem.Text == "Yet to confirm")
                    pregnancystatus = "3";

                ancpatientdetails.PregnancyStatus = pregnancystatus;

                if (chkIsPrimipara.Checked == true)
                    isprimipara = "1";
                else
                    isprimipara = "2";
                ancpatientdetails.IsPrimipara = isprimipara;

                if (chkIsBad.Checked == true)
                    isbad = "1";
                else
                    isbad = "2";
                ancpatientdetails.IsBadObstretic = isbad;
                if (drpMultiGest.SelectedItem.Text != "Select")
                {
                    ancpatientdetails.MultipleGestation = Convert.ToInt32(drpMultiGest.SelectedItem.Value);
                }
                else
                {
                    if (drpPregnancy.SelectedItem.Text == "Confirmed")
                    {
                        ancpatientdetails.MultipleGestation = 1;
                    }
                    else
                    {
                        ancpatientdetails.MultipleGestation = 0;
                    }
                }
                ancpatientdetails.CreatedBy = LID;
                ancpatientdetails.GPLAOthers = txtGPALOthers.Text;
                ancpatientdetails.BloodGroup = txtBloodGroup.SelectedItem.Text;

                #endregion

                #region UltraSound

                //Ultrasound data

                DateTime DateOfUS = new DateTime();
                PatientUltraSoundData ultrasounddata = new PatientUltraSoundData();
                ultrasounddata.PatientID = patientid;
                ultrasounddata.PatientVisitID = visitID;
                if (drpweeks.Text == "Select")
                {
                    ultrasounddata.GestationalWeek = 0;
                }
                else
                {
                    ultrasounddata.GestationalWeek = Convert.ToInt32(drpweeks.Text);
                }
                ultrasounddata.GestationalDays = Convert.ToInt32(drpDays.Text);
                if (drpPlacental.SelectedItem.Text != "Select")
                {
                    ultrasounddata.PlacentalPositionID = Convert.ToInt64(drpPlacental.SelectedItem.Value);
                }
                else
                {
                    ultrasounddata.PlacentalPositionID = 0;
                }
                ultrasounddata.PlacentalPositionName = txtOther1.Text;
                if (drpMultiGest.SelectedItem.Text != "Select")
                {
                    ultrasounddata.MultipleGestation = Convert.ToInt32(drpMultiGest.SelectedItem.Value);
                }
                else
                {
                    if (drpPregnancy.SelectedItem.Text == "Confirmed")
                    {
                        ultrasounddata.MultipleGestation = 1;
                    }
                    else
                    {
                        ultrasounddata.MultipleGestation = 0;
                    }
                }
                if (txtDateOfUltraSound.Text.Trim().Length > 0)
                {
                    if (!DateTime.TryParse(txtDateOfUltraSound.Text, out DateOfUS))
                        DateOfUS = new DateTime(1800, 1, 1);
                }
                else
                {
                    // Min. default date.DateTime cannot be null and cannot be less that 1701
                    DateOfUS = new DateTime(1800, 1, 1);
                }

                ultrasounddata.DateOfUltraSound = DateOfUS;
                ultrasounddata.CreatedBy = LID;

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
                    pvh.PatientID = patientid;
                    pvh.PatientVisitID = visitID;
                    pvh.CreatedBy = LID;
                    pVaccinationDetails.Add(pvh);
                }

                #endregion

                #region SaveComplication

                foreach (ListItem li in PCP.Items)
                {
                    if (li.Selected)
                    {
                        PatientPastComplication lstComplication = new PatientPastComplication();
                        lstComplication.ComplicationID = Convert.ToInt32(li.Value);
                        lstComplication.ComplicationName = li.Text;
                        lstComplication.PatientVisitID = visitID;
                        lstComplication.CreatedBy = LID;
                        lstComplication.PatientID = patientid;
                        lstPComplication.Add(lstComplication);
                    }
                }

                //List<PatientPastComplication> comp = new List<PatientPastComplication>();

                //List<PatientPastComplication> Finalcomp = new List<PatientPastComplication>();
                for (int i = 0; i < lstSavePreComp.Count; i++)
                {
                    PatientPastComplication samp = new PatientPastComplication();
                    samp.ComplicationName = lstSavePreComp[i].ComplicationName;
                    samp.PatientVisitID = visitID;
                    samp.CreatedBy = LID;
                    samp.PatientID = patientid;
                    lstPComplication.Add(samp);
                }

                #endregion

                #region Save Investigation

                List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>(); List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
                lstPatientInvest = InvestigationControl1.GetOrderedList(); lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB();
                if (lstPatientInvest.Count > 0)
                {
                    foreach (PatientInvestigation inves in lstPatientInvest)
                    {
                        PatientInvestigation objInvest = new PatientInvestigation();
                        objInvest.InvestigationID = inves.InvestigationID;
                        objInvest.InvestigationName = inves.InvestigationName;
                        objInvest.PatientVisitID = visitID;
                        objInvest.GroupID = inves.GroupID;
                        objInvest.GroupName = inves.GroupName;
                        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objInvest.Status = "Ordered";
                        objInvest.CreatedBy = LID;
                        objInvest.ComplaintId = complaintID;
                        objInvest.Type = inves.Type;
                        pInvestigations.Add(objInvest);
                    }
                }

                foreach (ListItem li in chkInvestigation.Items)
                {
                    PatientInvestigation objInvest = new PatientInvestigation();
                    if (li.Selected)
                    {
                        objInvest.InvestigationID = Convert.ToInt32(li.Value);
                        objInvest.InvestigationName = li.Text;
                        objInvest.PatientVisitID = visitID;
                        objInvest.GroupID = 0;
                        objInvest.GroupName = "";
                        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objInvest.Status = "Ordered";
                        objInvest.CreatedBy = LID;
                        objInvest.ComplaintId = complaintID;
                        objInvest.Type = "INV";
                        pInvestigations.Add(objInvest);
                    }
                }

                if (lstPatientInvestHL.Count > 0)
                {
                    foreach (OrderedInvestigations inves in lstPatientInvestHL)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        objInvest.ID = inves.ID;
                        objInvest.Name = inves.Name;
                        objInvest.VisitID = visitID;
                        objInvest.OrgID = OrgID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        objInvest.Status = "Ordered";
                        objInvest.ComplaintId = complaintID;
                        objInvest.CreatedBy = LID;
                        objInvest.Type = inves.Type;
                        pInvestigationsHL.Add(objInvest);
                    }
                }

                foreach (ListItem li in chkInvestigation.Items)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    if (li.Selected)
                    {
                        objInvest.ID = Convert.ToInt32(li.Value);
                        objInvest.Name = li.Text;
                        objInvest.VisitID = visitID;
                        objInvest.OrgID = OrgID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        objInvest.Status = "Ordered";
                        objInvest.CreatedBy = LID;
                        objInvest.ComplaintId = complaintID;
                        objInvest.Type = "INV";
                        pInvestigationsHL.Add(objInvest);
                    }
                }

                #endregion

                #region Physiotheraphy
                List<PatientTreatmentProcedure> lstPTT = new List<PatientTreatmentProcedure>();
                string flag = string.Empty;
                List<ProcedureFee> lstProcedureFee = new List<ProcedureFee>();
                if (chkPHYSIOTHERAPY.Checked == true)
                {
                    flag = "Y";
                    PatientTreatmentProcedure ptt = new PatientTreatmentProcedure();
                    long rCode = -1;

                    rCode = new ANC_BL(base.ContextInfo).GetPhysiotheraphyID(visitID, chkPHYSIOTHERAPY.Text, OrgID, out lstProcedureFee);
                    if (lstProcedureFee.Count > 0)
                    {
                        ptt.PatientVisitID = visitID;
                        ptt.ProcedureID = lstProcedureFee[0].ProcedureID;
                        ptt.ProcedureFID = lstProcedureFee[0].ProcedureFeeID;
                        ptt.ProcedureDesc = chkPHYSIOTHERAPY.Text.Trim();
                        ptt.CreatedBy = LID;
                    }

                    lstPTT.Add(ptt);
                }
                else
                {
                    flag = "N";
                }

                #endregion

                int pOrderedInvCnt;
                int referedCount, orderedCount;
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                long createTaskID;
                long createTaskIDPRO;

                gUID = Guid.NewGuid().ToString();

                if (Request.QueryString["role"] != null)
                {

                    //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(pInvestigations, OrgID, out pOrderedInvCnt);

                    //if (returnCode == 0)
                    //{
                   
                    returnCode = ancBL.SaveANC(patientid, visitID, ancpatientdetails, pComplaint, pGPALDetails, ultrasounddata, lstPComplication, pVaccinationDetails, lstPatientVitals, pInvestigationsHL, flag, lstPTT, OrgID, gUID, out pOrderedInvCnt, objANCPatientObservation);
                    //}

                    #region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);

                    if (orderedCount > 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientid,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "",
                        0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,gUID);
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientid;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;

                        //Create task               
                        returnCode = taskBL.CreateTaskAllowDuplicate(task, out createTaskID);
                    }

                    if (chkPHYSIOTHERAPY.Checked == true)
                    {
                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
                            patientid, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", lstProcedureFee[0].ProcedureID, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,""); // Other Id meand Procedure ID

                        task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientid;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out createTaskIDPRO);
                    }

                    #endregion

                    //if (returnCode == 0)
                    //{
                    //    returnCode = ancBL.SaveANC(ancpatientdetails, pComplaint, pGPALDetails, ultrasounddata, lstPComplication, pVaccinationDetails, lstPatientVitals, OrgID);
                    //}
                    HidBaseLine.Value = null;
                    HdnPreviousComplicate.Value = null;
                    HdnAssociate.Value = null;
                    HdnVaccination.Value = null;

                    Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                    if (Request.QueryString["mode"] == "e")
                    {
                        if (Request.QueryString["VDT"] == "Y")
                        {
                            Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&mode=eV" + "&VDT=Y", true);
                        }
                        else
                        {
                            Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&mode=eV", true);
                        }
                    }
                    else
                    {
                        if (Request.QueryString["VDT"] == "Y")
                        {
                            Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "&VDT=Y", true);
                        }
                        else
                        {
                            Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "", true);
                        }
                    }
                }
                else
                {
                    //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(pInvestigations, OrgID, out pOrderedInvCnt);

                    //if (returnCode == 0)
                    //{
                    returnCode = ancBL.SaveANC(patientid, visitID, ancpatientdetails, pComplaint, pGPALDetails, ultrasounddata, lstPComplication, pVaccinationDetails, lstPatientVitals, pInvestigationsHL, flag, lstPTT, OrgID, gUID, out pOrderedInvCnt, objANCPatientObservation);
                    if (Request.QueryString["mode"] != "e")
                    {
                        returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                    }
                    //}

                    #region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);

                    if (orderedCount > 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientid,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 
                        0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,gUID);
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientid;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;

                        //Create task    
                        returnCode = taskBL.CreateTaskAllowDuplicate(task, out createTaskID);
                       // returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                    if (chkPHYSIOTHERAPY.Checked == true)
                    {
                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
                            patientid, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName,
                            "", lstProcedureFee[0].ProcedureID, "", 0, "", 0, "PRO", out dText, out urlVal, 0, 
                            lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,""); // Other Id meand Procedure ID

                        task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientid;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out createTaskIDPRO);
                    }

                    #endregion

                    //if (returnCode == 0)
                    //{
                    //    returnCode = ancBL.SaveANC(ancpatientdetails, pComplaint, pGPALDetails, ultrasounddata, lstPComplication, pVaccinationDetails, lstPatientVitals, OrgID);
                    //}

                    HidBaseLine.Value = null;
                    HdnPreviousComplicate.Value = null;
                    HdnAssociate.Value = null;
                    HdnVaccination.Value = null;

                    //if (returnCode == 0)
                    //{
                    //    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                    //}
                    List<Role> lstUserRole1 = new List<Role>();
                    string path1 = string.Empty;
                    Role role1 = new Role();
                    role1.RoleID = RoleID;
                    lstUserRole1.Add(role1);
                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                    Response.Redirect(Request.ApplicationPath + path1, false);
                }
            }
        }
        catch (System.Threading.ThreadAbortException exThreadAbort)
        {
            string str = exThreadAbort.ToString();
            btnSave.Visible = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BaseLineHistory", ex);
            btnSave.Visible = true;
        }

    }

    #region To Get Data from Corresponding Method to save

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


                    //string bm = string.Empty;
                    //bm = lineItems[7];

                    //if (bm == TaskHelper.birthMaturity.FullTerm.ToString())
                    //{
                    //    objBaseLine.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.FullTerm);
                    //}
                    //else if (bm == TaskHelper.birthMaturity.PreTerm.ToString())
                    //{
                    //    objBaseLine.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.PreTerm);
                    //}
                    //else if (bm == TaskHelper.birthMaturity.PostTerm.ToString())
                    //{
                    //    objBaseLine.BirthMaturityID = Convert.ToInt32(TaskHelper.birthMaturity.PostTerm);
                    //}
                    //else
                    //{
                    //}

                    //objBaseLine.BirthMaturityID = Convert.ToInt32(lineItems[7]);
                    
                    lstBaseline.Add(objBaseLine);
                }
            }
        }
        return lstBaseline;
    }

    #endregion

    #region getPreviousComplicate javascript table
    // PreviousComplicate javascript table list

    public List<PatientPastComplication> getPreviousComplicate()
    {
        List<PatientPastComplication> lstPreviousComplicate = new List<PatientPastComplication>();
        string HidPreviousLine = HdnPreviousComplicate.Value;
        foreach (string splitString in HidPreviousLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientPastComplication objPreComplicate = new PatientPastComplication();
                    objPreComplicate.ComplicationName = lineItems[0];
                    lstPreviousComplicate.Add(objPreComplicate);

                    ////lineItems[0].Replace('_', ' ');
                    //string[] cn = lineItems[0].Split('_');

                    //if (cn.Length > 0)
                    //{
                    //    objPreComplicate.ComplicationName += cn[0] + ' ';
                    //}
                    ////objPreComplicate.ComplicationName = lineItems[0];

                }
            }
        }
        return lstPreviousComplicate;
    }
    #endregion

    #region getAssociateDiseases() javascript table
    // AssociateDiseases javascript table list

    public List<Complaint> getAssociateDiseases()
    {
        List<Complaint> lstAssDiseas = new List<Complaint>();
        string HidAssLine = HdnAssociate.Value;
        foreach (string splitString in HidAssLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    Complaint objComp = new Complaint();
                    objComp.ComplaintName = lineItems[0];
                    objComp.ComplaintDesc = lineItems[1];
                    lstAssDiseas.Add(objComp);
                }
            }
        }
        return lstAssDiseas;
    }
    #endregion

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
                    objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
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
    
    #endregion

    void AddHistChildNodeEdit(TreeNode parent, List<BackgroundProblem> complaint)
    {
        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryHistories = from ex in complaint
                             where ex.ComplaintID == parentID
                             select ex;
        string treeNodeText = string.Empty;
        foreach (var ex in queryHistories)
        {

            //treeNodeText = ex.ParentID == 0 ? "<a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" +
            //                                   ex.ComplaintID.ToString() + "','tCA" + ex.ComplaintID.ToString() +
            //                                   "');\">" + ex.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" + ex.ComplaintID.ToString() + "'>"
            //                                   : ex.ComplaintName;
            TreeNode tn = new TreeNode();
            tn.SelectAction = TreeNodeSelectAction.None;
            tn.Text = treeNodeText;
            tn.Value = ex.ComplaintID.ToString();
            tn.Collapse();
            tn.PopulateOnDemand = false;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
        }

        for (int i = 0; i < parent.ChildNodes.Count; i++)
        {

            var queryHistories1 = from exc in complaint
                                  where exc.ComplaintID == Convert.ToInt32(complaint[i].ComplaintID)
                                  select exc;
            if (queryHistories1.Count() > 0)
            {
                foreach (var exc in queryHistories1)
                {
                    if (exc.ComplaintID != 0)
                    {
                        if (exc.ComplaintID == complaint[i].ComplaintID)
                        {
                            TreeNode tn = new TreeNode(exc.ComplaintID != 0 ? "<input id='tCA" + exc.ComplaintID.ToString() + "' type='checkbox' checked='true' value='' onclick=javascript:Showtext('tA" 
                                    + exc.ComplaintID.ToString() + "','tCA" 
                                    + exc.ComplaintID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" 
                                    + exc.ComplaintID.ToString() + "','tCA" 
                                    + exc.ComplaintID.ToString() + "');\">" 
                                    + exc.ComplaintName 
                                    + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA" 
                                    + exc.ComplaintID.ToString() + " value= '" + exc.ComplaintName + "'>" : exc.ComplaintName);

                            tn.SelectAction = TreeNodeSelectAction.None;
                            //tn.SelectAction = TreeNodeSelectAction.None;
                            parent.ChildNodes[i].ChildNodes.Add(tn);
                            treeNodeText = exc.ComplaintID == 0 ? "<input id='tCA" 
                                + exc.ComplaintID.ToString() + "' type='checkbox' cheked='true' value='' onclick=javascript:Showtext('tA" 
                                + exc.ComplaintID.ToString() + "','tCA" 
                                + exc.ComplaintID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tA" 
                                + exc.ComplaintID.ToString() + "','tCA" 
                                + exc.ComplaintID.ToString() + "');\">" 
                                + exc.ComplaintName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tA"
                                + exc.ComplaintID.ToString() + " value= '" + exc.ComplaintName + "'>" : exc.ComplaintName;
                        }
                    }
                }
            }
        }
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
}
