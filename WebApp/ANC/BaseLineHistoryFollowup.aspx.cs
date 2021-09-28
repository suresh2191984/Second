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

public partial class ANC_BaseLineHistoryFollowup : BasePage
{
    long visitID = -1;
    long patientid = -1;
    long taskID = -1;
    int specialityid = -1;
    long returnCode = -1;
    int pCount = -1;
    int complaintID = 534;

    string ddlName, age, ddlDeliveryName, weight, gnormal, grate, ddlBMaturity, ddlDeliveryNameID, ddlBMaturityID, pastComplication, bgpName, bgpDesc;
    string ddlVaccination, Year, ddlMonth, Doses, Booster, ddlVaccinationid;
    string gUId = string.Empty;                                      
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientid);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int32.TryParse(Request.QueryString["sid"], out specialityid);
        gUId = Guid.NewGuid().ToString();
        if (!IsPostBack)
        {
            try
            {
                List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
                List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                List<PatientUltraSoundData> lstPatientUltraSoundData = new List<PatientUltraSoundData>();
                List<PatientPastComplication> lstPatientPastComplication = new List<PatientPastComplication>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();

                ANC_BL ancdetails = new ANC_BL(base.ContextInfo);

                patientHeader.PatientVisitID = visitID;

                #region load Data for Followup Visists

                if (Request.QueryString["mode"] == null)
                {
                    #region Load PatientVitals Header

                    PatientVitalsControl.FindControl("txtTemp").Focus();
                    PatientVitalsControl.VisitID = visitID;
                    PatientVitalsControl.LoadControls("I", patientid);

                    #endregion

                    #region Load Data for Current Vaccination

                    loadCurrentvaccination();

                    #endregion

                    #region Load Data for Ultrasound

                    loadplacentalpositions();

                    #endregion

                    #region Load Data for Investigation

                    loadInvestigation();

                    //Load Data's to investigation Control
                    List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                    List<PatientVisit> lPatientVisit = new List<PatientVisit>();
                    int clientID = 0;
                    new PatientVisit_BL(base.ContextInfo).GetCorporateClientByVisit(visitID, out lPatientVisit);
                    if (lPatientVisit.Count > 0)
                    {
                        clientID =Convert.ToInt32(lPatientVisit[0].ClientMappingDetailsID);
                    }

                    new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), clientID, complaintID, out lstgroups, out lstInvestigations);
                    InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);

                    #endregion

                    returnCode = new ANC_BL(base.ContextInfo).GetANCCountforNurse(visitID, out pCount);

                    if (pCount == 0)
                    {
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
                            btnCancel.Text = "Close";
                            btnCancel.Visible = true;
                        }
                        else
                        {
                            btnPatientDiagnose.Visible = true;
                        }

                        PatientVitalsControl.FindControl("txtTemp").Focus();
                        PatientVitalsControl.VisitID = visitID;
                        PatientVitalsControl.LoadControls("U", patientid);
                    }

                }
                else
                {
                    //Edit ANC Followup
                    #region Load PatientVitals Header

                    PatientVitalsControl.FindControl("txtTemp").Focus();
                    PatientVitalsControl.VisitID = visitID;
                    PatientVitalsControl.LoadControls("U", patientid);

                    #endregion

                    #region Load Data for Current Vaccination

                    loadCurrentvaccination();

                    #endregion

                    #region Load Data for Ultrasound

                    loadplacentalpositions();

                    #endregion

                    btnPatientDiagnose.Visible = true;
                }
                #endregion

                ancdetails.GetANCDetailsbyPIDCommand(patientid, out lstANCPatientDetails, out lstBackgroundProblem, out lstGPALDetails, out lstPatientUltraSoundData, out lstPatientPastComplication, out lstPatientPastVaccinationHistory);

                if (lstANCPatientDetails.Count > 0)
                {
                    #region Retrive ANCPatientDetails If exists

                    if (lstANCPatientDetails[0].PregnancyStatus == "1")
                    {
                        drpPregnancy.SelectedValue = "1";

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

                    #endregion

                    #region Retrive GPAL Details if Exists
                    int ccount = 1;
                    string retrivegpal = string.Empty;
                    for (int i = 0; i < lstGPALDetails.Count; i++)
                    {





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
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "gpal1Table", "javascript:LoadBaseLineHistroyItems();", true);
                    #endregion

                    #region Retrive Previous Complicated Pregnencies

                    string retrivePCP = string.Empty;
                    for (int j = 0; j < lstPatientPastComplication.Count; j++)
                    {
                        pastComplication = lstPatientPastComplication[j].ComplicationName;
                        retrivePCP += pastComplication + "^";
                    }
                    HdnPreviousComplicate.Value = retrivePCP;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "pcpTable", "javascript:LoadPreviousComplicateItems();", true);

                    #endregion

                    #region Retrive Background Problem if Exists

                    string retriveBGP = string.Empty;

                    int asociateDiseaseCount = 1;
                    for (int k = 0; k < lstBackgroundProblem.Count; k++)
                    {
                        asociateDiseaseCount = asociateDiseaseCount + 1;
                        bgpName = lstBackgroundProblem[k].ComplaintName;
                        bgpDesc = lstBackgroundProblem[k].Description;

                        retriveBGP += asociateDiseaseCount + "~" + bgpName + "~" + bgpDesc + "^";
                    }
                    HdnAssociate.Value = retriveBGP;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "bgpTable", "javascript:LoadAssociateDieasesItems();", true);


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

                    #region Patient Ultra Sound If Exists

                    for (int i = lstPatientUltraSoundData[0].GestationalWeek; i <= 45; i++)
                    {
                        drpweeks.Items.Add(i.ToString());
                    }

                    drpweeks.SelectedValue = lstPatientUltraSoundData[0].GestationalWeek.ToString();
                    drpDays.SelectedValue = lstPatientUltraSoundData[0].GestationalDays.ToString();
                    drpPlacental.SelectedValue = lstPatientUltraSoundData[0].PlacentalPositionID.ToString();
                    drpMultiGest.SelectedValue = lstPatientUltraSoundData[0].MultipleGestation.ToString();
                    txtOther1.Text = lstPatientUltraSoundData[0].PlacentalPositionName;
                    if (lstPatientUltraSoundData[0].DateOfUltraSound == Convert.ToDateTime("01/01/1800"))
                    {
                        txtDateOfUltraSound.Text = "";
                    }
                    else
                    {
                        txtDateOfUltraSound.Text = lstPatientUltraSoundData[0].DateOfUltraSound.ToShortDateString();
                    }
                    #endregion
                

                }
                else
                {
                }

                
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in BaseLineHistory Followup", ex);
            }
        }


    }

    #region Methods to be called during PageLoad

    #region Load Current Vaccination

    //get Vaccination from DB
    protected void loadCurrentvaccination()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            List<Vaccination> lstVaccination = new List<Vaccination>();
            returnCode = ancBL.GetPriorVaccination(out lstVaccination);
            loadGRD_Currentvaccination(lstVaccination);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on pageload", ex);
        }
    }

    //Load vaccination to dropdown

    protected void loadGRD_Currentvaccination(List<Vaccination> lstVaccination)
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
    protected void loadGRD_InvestigationMaster(List<InvestigationMaster> lstInvestigationMaster)
    {
        chkInvestigation.DataSource = lstInvestigationMaster;
        chkInvestigation.DataTextField = "InvestigationName";
        chkInvestigation.DataValueField = "InvestigationID";
        chkInvestigation.DataBind();
    }

    #endregion

    #endregion

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
        List<PatientInvestigation> pInvestigations = new List<PatientInvestigation>();

        int pOrderedInvCnt;
        int referedCount, orderedCount;
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        long createTaskID;

        try
        {
            int NoOfVitalsEntered = 0;

            List<PatientVitals> lstPatientVitals = new List<PatientVitals>();

            if (PatientVitalsControl.GetPageValues(visitID, false, out NoOfVitalsEntered, out lstPatientVitals))
            {
                if (NoOfVitalsEntered <= 0)
                    lstPatientVitals.Clear();

                #region Current Vaccination

                List<PatientVaccinationHistory> pVaccinationDetails = new List<PatientVaccinationHistory>();
                List<PatientVaccinationHistory> lstvacc = new List<PatientVaccinationHistory>();
                lstvacc = getPriorVaccinations();

                //Save Vaccination

                for (int i = 0; i < lstvacc.Count(); i++)
                {
                    PatientVaccinationHistory pvh = new PatientVaccinationHistory();
                    pvh.VaccinationID = lstvacc[i].VaccinationID;
                    pvh.VaccinationName = lstvacc[i].VaccinationName;
                    pvh.YearOfVaccination = lstvacc[i].YearOfVaccination;
                    pvh.MonthOfVaccination = Convert.ToInt32(lstvacc[i].MonthName);

                    pvh.VaccinationDose = lstvacc[i].VaccinationDose;
                    string strBooster = lstvacc[i].IsBooster;
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

                #region UltraSound

                //Ultrasound data

                DateTime DateOfUS = new DateTime();
                PatientUltraSoundData ultrasounddata = new PatientUltraSoundData();
                ultrasounddata.PatientID = patientid;
                ultrasounddata.PatientVisitID = visitID;
                ultrasounddata.GestationalWeek = Convert.ToInt32(drpweeks.Text);
                ultrasounddata.GestationalDays = Convert.ToInt32(drpDays.Text);
                ultrasounddata.PlacentalPositionID = Convert.ToInt64(drpPlacental.SelectedItem.Value);
                ultrasounddata.PlacentalPositionName = txtOther1.Text;
                ultrasounddata.MultipleGestation = Convert.ToInt32(drpMultiGest.SelectedValue);
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

                #region Save Investigation

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

                #endregion
                //Venkat Changes(GUID)
                
                if (Request.QueryString["role"] != null)
                {
                    returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(pInvestigations, OrgID, gUId, out pOrderedInvCnt);

                    if (returnCode == 0)
                    {
                        returnCode = new ANC_BL(base.ContextInfo).saveANCFollowupData(pVaccinationDetails, ultrasounddata, lstPatientVitals, OrgID);
                    }

                    #region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);

                    if (orderedCount > 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientid,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                        0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
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
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }

                    #endregion

                    HdnCVaccination.Value = null;
                    HdnVaccination.Value = null;
                    HdnPreviousComplicate.Value = null;
                    HdnAssociate.Value = null;

                    Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + visitID + "&pid=" + patientid + "&tid=" + taskID + "", true);
                }
                else
                {
                    returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(pInvestigations, OrgID,gUId, out pOrderedInvCnt);
                    if (returnCode == 0)
                    {
                        returnCode = new ANC_BL(base.ContextInfo).saveANCFollowupData(pVaccinationDetails, ultrasounddata, lstPatientVitals, OrgID);

                        returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                    }

                    #region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);

                    if (orderedCount > 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientid,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "",
                        0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
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
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }

                    #endregion

                    //if (returnCode == 0)
                    //{
                        HdnCVaccination.Value = null;
                        HdnVaccination.Value = null;
                        HdnPreviousComplicate.Value = null;
                        HdnAssociate.Value = null;

                        //returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                        List<Role> lstUserRole1 = new List<Role>();
                        string path1 = string.Empty;
                        Role role1 = new Role();
                        role1.RoleID = RoleID;
                        lstUserRole1.Add(role1);
                        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                        Response.Redirect(Request.ApplicationPath + path1, true);
                    //}
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC/BasclineFollowup.aspx", ex);
        }

    }


    #region getPriorVaccinations() javascript table
    // PriorVaccinations javascript table list

    public List<PatientVaccinationHistory> getPriorVaccinations()
    {
        List<PatientVaccinationHistory> lstPriVacc = new List<PatientVaccinationHistory>();
        string HidPrivLine = HdnCVaccination.Value;
        foreach (string splitString in HidPrivLine.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientVaccinationHistory objVac = new PatientVaccinationHistory();
                    objVac.VaccinationName = lineItems[1];
                    //objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
                    objVac.YearOfVaccination = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                    objVac.MonthName = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month.ToString();
                    //objVac.MonthName = lineItems[3];
                    objVac.VaccinationDose = lineItems[2];
                    objVac.IsBooster = lineItems[3];
                    objVac.VaccinationID = Convert.ToInt32(lineItems[4]);
                    lstPriVacc.Add(objVac);
                }
            }
        }
        return lstPriVacc;
    }
    #endregion
}
