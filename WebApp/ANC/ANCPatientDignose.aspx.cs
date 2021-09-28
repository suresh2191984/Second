using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Text;
using System.Security.Cryptography;
public partial class ANC_ANCPatientDignose : BasePage
{
    int complaintID, Invid, noofFetals, pCountBaseLine;
    int ExaminationId;
    string Yes = "Y";
    string No = "N";
    string CN1, CN2;

    long patientVisitID = 0;
    long patientID = 0;
    long returnCode = -1;
    decimal pWeightGained = -1;
    DataSet ds1 = new DataSet();
    //long createdBy = 0;
    string InvDrugData = string.Empty;
    //int OrgID = 0;
    int vacccount = 1;
    string ddlVaccination, ddlVaccinationid, Doses, Booster;
    string PatientObservation = string.Empty;
    PatientVaccinationHistory vacc = null;

    List<History> lstHistory = new List<History>();
    List<Complication> lstCompNamee = new List<Complication>();
    List<Complication> lstComplication = new List<Complication>();

    List<Examination> lstExamination = new List<Examination>();
    List<Examination> lstExamination1 = new List<Examination>();

    List<FetalPresentations> lstFetalPresentations = new List<FetalPresentations>();
    List<FetalPosition> lstFetalPosition = new List<FetalPosition>();
    List<FetalMovements> lstFetalMovements = new List<FetalMovements>();
    List<FetalFHS> lstFetalFHS = new List<FetalFHS>();
    
    //List<PatientInvestigation> pInvestigations = new List<PatientInvestigation>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
    List<DrugDetails> pAdvices = new List<DrugDetails>();
    List<PatientComplaint> pComplaint = new List<PatientComplaint>();

    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();

    List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<PatientPastVaccinationHistory> lstPatientVaccinationHistory = new List<PatientPastVaccinationHistory>();

    
    
    List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();



    List<Vaccination> lstVaccination = new List<Vaccination>();
    List<PatientVaccinationHistory> pVaccinationDetails = new List<PatientVaccinationHistory>();
    List<PatientVaccinationHistory> lstvacc = new List<PatientVaccinationHistory>();
    List<PatientVaccinationHistory> savevacc = new List<PatientVaccinationHistory>();
    List<PatientVaccinationHistory> finalpv = new List<PatientVaccinationHistory>();

    List<ANCPatientObservation> lstANCPatientObservation = new List<ANCPatientObservation>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtNextReviewDate.Attributes.Add("onChange", "ExcedDate('" + txtNextReviewDate.ClientID.ToString() + "','',0,1);");

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            complaintID = 534;
            //Invid = 837;
            //ExaminationId = 837;
            CN1 = "Maternal";
            CN2 = "Foetus";

            //txtYear.Attributes.Add("onkeydown", "return validatenumber(event);");
            txtDoses.Attributes.Add("onkeydown", "return validatenumber(event);");

            ANCVitalInformation_BL ancblFUP = new ANCVitalInformation_BL(base.ContextInfo);

            ancblFUP.getANCFollowUP(patientVisitID, patientID, complaintID, CN1, CN2, out lstHistory, out lstCompNamee, out lstComplication, out lstFetalPresentations, out lstFetalPosition, out lstFetalMovements, out lstFetalFHS, out lstInvestigationMaster, out noofFetals, out pCountBaseLine);

            ucANCFollowup.LoadANCFollowups(noofFetals, lstHistory, lstCompNamee, lstComplication, lstFetalPresentations, lstFetalPosition, lstFetalMovements, lstFetalFHS);


            if (!IsPostBack)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideAllDiv", "javascript:validExam();", true);

                List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
                List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
                List<PatientInvestigation> listPInvs = new List<PatientInvestigation>(); List<OrderedInvestigations> listPInvsHL = new List<OrderedInvestigations>();
                List<PatientUltraSoundData> lstUSD = new List<PatientUltraSoundData>();

                //patientID = Convert.ToInt64(Request.QueryString["pid"]);
                //patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);

                if (pCountBaseLine <= 0)
                {
                    //long taskId = 0;
                    //Int64.TryParse(Request.QueryString["tid"], out taskId);
                    //Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&role=" + "D" + "", true);
                    Panel2.Style.Add("display", "none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This Patient is Yet to Complete baseline Screening. \\n Click Add baseline Screening Button to Add necessary information \\n before entering Symptoms, Examination, Complication, etc');", true);
                    btnBaseLineAdd.Visible = true;
                    btnBaseLineAddTop.Visible = true;
                }
                else
                {
                    Panel2.Style.Add("display", "block");
                    btnSubmit.Enabled = true;
                    btnSaveContinue.Enabled = true;
                    btnBaseLineView.Visible = true;
                    btnEditBaseLine.Visible = true;
                }

                //********** Form the Advice Control ************************/
                List<Config> lstConfigDD = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                if (lstConfigDD.Count > 0)
                {
                    InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                }
                if (InvDrugData == "Y")
                {
                    uAd.Visible = false;
                    uIAdv.Visible = true;
                }
                else
                {
                    uAd.Visible = true;
                    uIAdv.Visible = false;
                }

                patientHeader.PatientVisitID = patientVisitID;

                loadInvestigation();
                loadpriorvaccination();

                ancblFUP.getVitalInformationTrend(patientVisitID, out lstPatientVitals, out lstInvestigationValues, out pWeightGained);
                ancblFUP.pGetANCVisitSummary(patientID, out lstANCPatientDetails, out lstBackgroundProblem, out lstPatientVaccinationHistory, out lstUSD);
                if (lstANCPatientDetails.Count == 0)
                {
                    ucVitalInformationTrend.loadVitalInformationTrend("0", lstPatientVitals, lstInvestigationValues, pWeightGained);
                }
                else
                {
                    ucVitalInformationTrend.loadVitalInformationTrend(lstANCPatientDetails[0].BloodGroup, lstPatientVitals, lstInvestigationValues, pWeightGained);
                }
                ucANCVitalSummary.LoadVitalSummary(lstANCPatientDetails, lstBackgroundProblem, lstPatientVaccinationHistory, lstUSD);

                //Load Data's to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
  
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                
                List<PatientVisit> lPatientVisit = new List<PatientVisit>();
                int clientID = 0;
                new PatientVisit_BL(base.ContextInfo).GetCorporateClientByVisit(patientVisitID, out lPatientVisit);
                if (lPatientVisit.Count > 0)
                {
                    clientID =Convert.ToInt32(lPatientVisit[0].ClientMappingDetailsID);
                }
                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), complaintID, clientID, out lstgroups, out lstInvestigations);
                InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);

                //long returnCode = -1;

                #region Get Patient Investigation & Drug Details if Exists
                List<PatientFetalFindings> pff = new List<PatientFetalFindings>();
                if (Request.QueryString["mode"] != "eV")
                {

                    new ANC_BL(base.ContextInfo).GetANCPatientVisitDetailsByVID(complaintID, patientID, patientVisitID, out listPInvsHL, out lstDrugDetails, out lstPatientAdvice,out lstANCPatientObservation);


                    if (lstANCPatientObservation.Count > 0)
                    {
                        txtObservation.Text = lstANCPatientObservation[0].Observation;
                    }


                    //DataSet ds1 = new DataSet();
                    new ANC_BL(base.ContextInfo).GetANCSnapShotView(patientVisitID, OrgID, out ds1, out pff,out lstANCPatientObservation);
                    uSSV.LoadSnapShotview(ds1, pff, lstANCPatientObservation);

                 

                    if (lstDrugDetails.Count > 0)
                    {
                        if (InvDrugData == "Y")
                        {
                            uIAdv.SetPrescription(lstDrugDetails);
                        }
                        else
                        {
                            uAd.SetPrescription(lstDrugDetails);
                        }
                    }
                    if (listPInvsHL.Count > 0)
                    {
                        //String orderedList = string.Empty;

                        //bool investigationAvailableInMapping = false;
                        //bool groupAvailableInMapping = false;

                        //for (int z = 0; z < listPInvs.Count; z++)
                        //{
                        //    foreach (ListItem li in chkInvestigation.Items)
                        //    {
                        //        if (li.Value == listPInvs[z].InvestigationID.ToString())
                        //        {
                        //            li.Selected = true;
                        //            investigationAvailableInMapping = true;
                        //            groupAvailableInMapping = true;
                        //        }
                        //    }

                        //    if (!groupAvailableInMapping && !investigationAvailableInMapping)
                        //    {
                        //        if (listPInvs[z].GroupID > 0)
                        //        {
                        //            if (!orderedList.Contains(listPInvs[z].GroupName))
                        //            {
                        //                orderedList += listPInvs[z].GroupID + "~" + listPInvs[z].GroupName + "~GRP^";
                        //            }
                        //        }
                        //        else
                        //        {
                        //            if (!orderedList.Contains(listPInvs[z].InvestigationName))
                        //            {
                        //                orderedList += listPInvs[z].InvestigationID + "~" + listPInvs[z].InvestigationName + "~INV^";
                        //            }
                        //        }

                        //        continue;

                        //    }

                        //    if (!investigationAvailableInMapping && listPInvs[z].GroupID < 1)
                        //    {
                        //        if (!orderedList.Contains(listPInvs[z].InvestigationName))
                        //        {
                        //            orderedList += listPInvs[z].InvestigationID + "~" + listPInvs[z].InvestigationName + "~INV^";
                        //        }

                        //    }

                        //    if (!groupAvailableInMapping)
                        //    {
                        //        if (listPInvs[z].GroupID > 0)
                        //        {
                        //            if (!orderedList.Contains(listPInvs[z].GroupName))
                        //            {
                        //                orderedList += listPInvs[z].GroupID + "~" + listPInvs[z].GroupName + "~GRP^";
                        //            }
                        //        }
                        //    }

                        //}

                        //InvestigationControl1.setOrderedList(orderedList);

                        dlInvName.DataSource = listPInvsHL;
                        dlInvName.DataBind();
                    }
                }

                #endregion

                string pScanStatus = string.Empty;
                string pNextReviewDate = string.Empty;

                if (Request.QueryString["mode"] == "eV")
                {

                    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
                    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
                    List<PatientFetalFindings> lstPatientFetalFindings = new List<PatientFetalFindings>();
                    List<PatientComplication> lstPatientComplication = new List<PatientComplication>();
                    List<PatientVaccinationHistory> lstPVH = new List<PatientVaccinationHistory>();


                    ANC_BL ancbl = new ANC_BL(base.ContextInfo);


                    returnCode = ancbl.GetANCPatientDiagnoseEdit(patientVisitID, patientID, LID, complaintID, out pScanStatus, out pNextReviewDate, out pComplaint, out lstPatientHistory, out lstPatientExamination, out lstPatientComplication, out lstPatientFetalFindings, out lstPatientAdvice, out lstDrugDetails, out lstPVH, out lstANCPatientDetails, out lstPatientInvestigation,out lstANCPatientObservation);


                    #region Retrieve PatientObservation
                    if (lstANCPatientObservation.Count > 0)
                    {
                        txtObservation.Text = lstANCPatientObservation[0].Observation;
                    }
                    #endregion

                    #region Retrieve PatientHistory if Exists

                    ucANCFollowup.setPatientHistory(lstPatientHistory, lstPatientExamination, lstPatientComplication, lstPatientFetalFindings);

                    #endregion

                    #region Retrieve Scan Status & Admission

                    if (lstANCPatientDetails[0].AdmissionSuggested == "Y")
                    {
                        chkAdmit.Checked = true;
                    }
                    if (pScanStatus == "Y")
                    {
                        chkScan.Checked = true;
                    }

                    #endregion

                    #region Retrieve Patient Advice if Exists

                    if (lstPatientAdvice.Count > 0)
                    {
                        uGAdv.setGeneralAdvice(lstPatientAdvice);
                    }

                    #endregion

                    #region Retrieve Drug Details if Exists

                    if (lstDrugDetails.Count > 0)
                    {
                        if (InvDrugData == "Y")
                        {
                            uIAdv.SetPrescription(lstDrugDetails);
                        }
                        else
                        {
                            uAd.SetPrescription(lstDrugDetails);
                        }
                    }

                    #endregion

                    #region Retrive Patient Investigation if Exists

                    if (lstPatientInvestigation.Count > 0)
                    {
                        //String orderedList = string.Empty;

                        //bool investigationAvailableInMapping = false;
                        //bool groupAvailableInMapping = false;
                        if ((Request.QueryString["VDT"] != "Y"))// && (Request.QueryString["mode"] != "eV"))
                        {
                            for (int z = 0; z < lstPatientInvestigation.Count; z++)
                            {
                                foreach (ListItem li in chkInvestigation.Items)
                                {
                                    //Venkat changes here
                                    if (li.Value == lstPatientInvestigation[z].InvestigationID.ToString() && lstPatientInvestigation[z].Status !="Completed")
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

                        //if ((Request.QueryString["VDT"] == "Y"))// || (Request.QueryString["mode"] == "eV"))
                        //{
                            dlInvName.DataSource = lstPatientInvestigation;
                            dlInvName.DataBind();
                       // }
                    }

                    #endregion

                    #region Retrive Patient Past Vaccination

                    string retrivePPV = string.Empty;
                    int ppvCount = 1;

                    for (int l = 0; l < lstPVH.Count; l++)
                    {
                        ppvCount = ppvCount + 1;

                        ddlVaccination = lstPVH[l].VaccinationName;
                        ddlVaccinationid = lstPVH[l].VaccinationID.ToString();

                        Doses = lstPVH[l].VaccinationDose.ToString();

                        if (lstPVH[l].IsBooster == "N")
                        {
                            Booster = "No";
                        }
                        else if (lstPVH[l].IsBooster == "Y")
                        {
                            Booster = "Yes";
                        }
                        else
                        {
                        }

                        retrivePPV += ppvCount + "~" + ddlVaccination + "~" + Doses + "~" + Booster + "~" + ddlVaccinationid + "^";

                    }
                    HdnCVaccination.Value = retrivePPV;

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ppvTable", "javascript:LoadCVaccinationsItems();", true);

                    #endregion

                    #region Retrive Next Review Date
                    if (pNextReviewDate != "")
                    {
                        if (pNextReviewDate.Contains("/"))
                        {
                            txtNextReviewDate.Text = pNextReviewDate;
                        }
                        else
                        {
                            string NextReview = string.Empty;
                            string NextReviewNos = string.Empty;
                            string NextReviewDMY = string.Empty;
                            string[] nReview;

                            NextReview = pNextReviewDate;
                            nReview = NextReview.Split('-');
                            if (nReview.Length > 0)
                            {
                                NextReviewNos = nReview[0].ToString();
                                NextReviewDMY = nReview[1].ToString();
                                ddlNos.SelectedValue = NextReviewNos;
                                ddlDMY.SelectedValue = NextReviewDMY;
                            }
                        }
                    }
                    #endregion

                    new ANC_BL(base.ContextInfo).GetANCSnapShotView(patientVisitID, OrgID, out ds1, out pff,out lstANCPatientObservation);
                    uSSV.LoadSnapShotview(ds1, pff, lstANCPatientObservation);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC Patient Diagnose", ex);
        }
    }


    //get Investigation from DB
    protected void loadInvestigation()
    {
        chkInvestigation.DataSource = lstInvestigationMaster;
        chkInvestigation.DataTextField = "InvestigationName";
        chkInvestigation.DataValueField = "InvestigationID";
        chkInvestigation.DataBind();
    }

    //get Vaccination from DB
    protected void loadpriorvaccination()
    {
        long returnCode = -1;
        try
        {
            ANC_BL ancBL = new ANC_BL(base.ContextInfo);

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
    
    //Load Patient Complaint
    private List<PatientComplaint> GetComplaint()
    {
        PatientComplaint pComplaint = new PatientComplaint();
        List<PatientComplaint> pComplaints = new List<PatientComplaint>();
        pComplaint.ComplaintID = complaintID;
        //if (cPos.Checked)
            //pComplaint.ComplaintName = "(" + cPos.Text + ")";
            pComplaint.ComplaintName = "";
        //if (cPD.Checked)
            pComplaint.Query = "Y";
        pComplaint.PatientVisitID = patientVisitID;
        pComplaint.CreatedBy = LID;
        pComplaints.Add(pComplaint);
        return pComplaints;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        long taskID, createTaskID;
        int referedCount, orderedCount;
        string PaymentLogic = string.Empty;
        btnSubmit.Enabled = false;

        try
        {
            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("CON", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }

            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }

            List<PatientHistory> lstPatientHistory = ucANCFollowup.GetPatientHistory(patientVisitID);
            List<PatientExamination> lstPatientExamination = ucANCFollowup.GetPatientExamination(patientVisitID);
            List<PatientComplication> lstPatientComplication = ucANCFollowup.GetPatientComplication(patientVisitID);
            List<PatientFetalFindings> lstPatientFetalFindings = ucANCFollowup.GetPatientFetalFindings(patientVisitID);
            List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();

            ANCVitalInformation_BL ancBL = new ANCVitalInformation_BL(base.ContextInfo);
            ANCPatientDetails apd = new ANCPatientDetails();
            PatienttoScanforANC ancSCAN = new PatienttoScanforANC();


            List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>(); List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
            lstPatientInvest = InvestigationControl1.GetOrderedList(); lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB();

            lstvacc = getPriorVaccinations();
            if (InvDrugData == "Y")
            {
                pAdvices = uIAdv.GetPrescription(patientVisitID);
            }
            else
            {
                pAdvices = uAd.GetPrescription(patientVisitID);
            }
            pComplaint = GetComplaint();
            lstPatientAdvice = uGAdv.GetGeneralAdvice(patientVisitID);

            #region Get Investigation

            if (lstPatientInvest.Count > 0)
            {
                foreach (PatientInvestigation inves in lstPatientInvest)
                {
                    PatientInvestigation objInvest = new PatientInvestigation();
                    objInvest.InvestigationID = inves.InvestigationID;
                    objInvest.InvestigationName = inves.InvestigationName;
                    objInvest.PatientVisitID = patientVisitID;
                    objInvest.GroupID = inves.GroupID;
                    objInvest.GroupName = inves.GroupName;
                    objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.ComplaintId = complaintID;
                    objInvest.Type = inves.Type;
                    lstPatientInvestigation.Add(objInvest);
                }
            }

            foreach (ListItem li in chkInvestigation.Items)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                if (li.Selected)
                {
                    objInvest.InvestigationID = Convert.ToInt32(li.Value);
                    objInvest.InvestigationName = li.Text;
                    objInvest.PatientVisitID = patientVisitID;
                    objInvest.GroupID = 0;
                    objInvest.GroupName = "";
                    objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.ComplaintId = complaintID;
                    objInvest.Type = "INV";
                    lstPatientInvestigation.Add(objInvest);
                }
            }

            if (lstPatientInvestHL.Count > 0)
            {
                foreach (OrderedInvestigations inves in lstPatientInvestHL)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    objInvest.ID = inves.ID;
                    objInvest.Name = inves.Name;
                    objInvest.VisitID = patientVisitID;
                    objInvest.OrgID = OrgID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.Status = "Ordered";
                    objInvest.ComplaintId = complaintID;
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    lstPatientInvestigationHL.Add(objInvest);
                }
            }

            foreach (ListItem li in chkInvestigation.Items)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                if (li.Selected)
                {
                    objInvest.ID = Convert.ToInt32(li.Value);
                    objInvest.Name = li.Text;
                    objInvest.VisitID = patientVisitID;
                    objInvest.OrgID = OrgID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.ComplaintId = complaintID;
                    objInvest.Type = "INV";
                    lstPatientInvestigationHL.Add(objInvest);
                }
            }

            #endregion

            #region SaveVaccination

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
                pvh.PatientID = patientID;
                pvh.PatientVisitID = patientVisitID;
                pvh.CreatedBy = LID;
                pVaccinationDetails.Add(pvh);
            }

            #endregion

            PatientVisit entPatientVisit = new PatientVisit();

            #region Check for Admission OR Scan

            if (chkAdmit.Checked == true)
            {
                apd.PatientID = patientID;
                apd.AdmissionSuggested = "Y";
                apd.AdmissionSuggestedVisitID = patientVisitID;
                entPatientVisit.AdmissionSuggested = "Y";
                entPatientVisit.PatientID = patientID;
            }
            else
            {
                apd.PatientID = patientID;
                apd.AdmissionSuggested = "N";
                apd.AdmissionSuggestedVisitID = 0;
                entPatientVisit.AdmissionSuggested = "N";
                entPatientVisit.PatientID = patientID;
            }

            if (chkScan.Checked == true)
            {
                ancSCAN.PatientVisitID = patientVisitID;
                ancSCAN.PatienID = patientID;
                ancSCAN.ScanStatus = "Y";
            }
            else
            {
                ancSCAN.PatientVisitID = patientVisitID;
                ancSCAN.PatienID = patientID;
                ancSCAN.ScanStatus = "N";
            }

            #endregion

            lstPatientAdvice = uGAdv.GetGeneralAdvice(patientVisitID);

            long returnCode = -1;
            int pOrderedInvCnt;

            //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(pInvestigations, OrgID, out pOrderedInvCnt);

            //if (returnCode == 0)
            //{


            if (txtNextReviewDate.Text == "")
            {
                entPatientVisit.NextReviewDate = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();
            }
            else
            {
                entPatientVisit.NextReviewDate = txtNextReviewDate.Text;
            }

            string flag = string.Empty;

            if (Request.QueryString["mode"] == "eV")
            {
                flag = "UPD";
            }
            else
            {
                flag = "INS";
            }
            string gUID = Guid.NewGuid().ToString();
            if (txtObservation.Text != "")
            {
                PatientObservation = txtObservation.Text;
            }

            returnCode = ancBL.saveHECFC(flag, patientID, patientVisitID, pComplaint, lstPatientHistory, lstPatientExamination, lstPatientComplication, lstPatientFetalFindings, lstPatientAdvice, pAdvices, pVaccinationDetails, apd, entPatientVisit, ancSCAN, lstPatientInvestigationHL, OrgID, out pOrderedInvCnt, gUID, PatientObservation,ILocationID,LID);

            Int64.TryParse(Request.QueryString["tid"], out taskID);
            if (returnCode == 0)
            {
                Response.Redirect(@"ANCCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + patientVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + "&gUID=" + gUID, true);
            }

            #region Commented Codes

            //#region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

            //returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out orderedCount);

            //List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            //if (orderedCount > 0)
            //{
            //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), patientVisitID, 0, patientID,
            //    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal);
            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = patientVisitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;

            //    //Create task               
            //    returnCode = taskBL.CreateTask(task, out createTaskID);

            //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverANCCaseSheet), patientVisitID, 0, patientID,
            //        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal);

            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = patientVisitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;
            //    //Create collection task
            //    returnCode = taskBL.CreateTask(task, out createTaskID);

            //}
            //else
            //{
            //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
            //        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal);

            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = patientVisitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;
            //    //Create collection task
            //    returnCode = taskBL.CreateTask(task, out createTaskID);
            //}
            //if (referedCount > 0)
            //{
            //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), patientVisitID, 0, patientID,
            //    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal);
            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = patientVisitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;

            //    //Create task               
            //    returnCode = taskBL.CreateTask(task, out createTaskID);


            //}

            //#endregion

            //Int64.TryParse(Request.QueryString["tid"], out taskID);

            //new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

            //List<Role> lstUserRole1 = new List<Role>();
            //string path1 = string.Empty;
            //Role role1 = new Role();
            //role1.RoleID = RoleID;
            //lstUserRole1.Add(role1);
            //returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            //Response.Redirect(Request.ApplicationPath + path1, true);

            #endregion
            //}
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
            btnSubmit.Visible = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC PatientDiagnose", ex);
            btnSubmit.Visible = true;
        }
    }
    protected void btnSaveContinue_Click(object sender, EventArgs e)
    {

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<Role> lstUserRole1 = new List<Role>();
        string path1 = string.Empty;
        Role role1 = new Role();
        role1.RoleID = RoleID;
        lstUserRole1.Add(role1);
        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
        Response.Redirect(Request.ApplicationPath + path1, true);
    }
    
    protected void btnBaseLineAdd_Click(object sender, EventArgs e)
    {
        long taskId = 0;
        Int64.TryParse(Request.QueryString["tid"], out taskId);

        Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID +  "&tid=" + taskId + "&role=" + "D" + "", true);
    }
    protected void btnBaseLineAddTop_Click(object sender, EventArgs e)
    {
        long taskId = 0;
        Int64.TryParse(Request.QueryString["tid"], out taskId);

        Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&role=" + "D" + "", true);
    }
    protected void btnBaseLineView_Click(object sender, EventArgs e)
    {
        long taskId = 0;
        Int64.TryParse(Request.QueryString["tid"], out taskId);
        Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&role=" + "D" + "&mode=" + "rm" + "", true);
    }
    protected void btnEditBaseLine_Click(object sender, EventArgs e)
    {
        long taskId = 0;
        Int64.TryParse(Request.QueryString["tid"], out taskId);
        //Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&role=" + "D" + "&mode=" + "rm" + "", true);
        if (Request.QueryString["VDT"] == "Y")
        {
            Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&mode=e" + "&VDT=Y" + "&role=" + "D", true);
        }
        else
        {
            Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&mode=e" + "&role=" + "D", true);
        }
    }

    #region getPriorVaccinations() javascript table
    // PriorVaccinations javascript table list

    //public List<PatientVaccinationHistory> getPriorVaccinations()
    //{
    //    List<PatientVaccinationHistory> lstPriVacc = new List<PatientVaccinationHistory>();
    //    string HidPrivLine = HdnVaccination.Value;
    //    foreach (string splitString in HidPrivLine.Split('^'))
    //    {
    //        if (splitString != string.Empty)
    //        {
    //            string[] lineItems = splitString.Split('~');
    //            if (lineItems.Length > 0)
    //            {
    //                PatientVaccinationHistory objVac = new PatientVaccinationHistory();
    //                objVac.VaccinationName = lineItems[1];
    //                objVac.YearOfVaccination = Convert.ToInt32(lineItems[2]);
    //                objVac.MonthName = lineItems[3];
    //                objVac.VaccinationDose = lineItems[4];
    //                objVac.IsBooster = lineItems[5];
    //                objVac.VaccinationID = Convert.ToInt32(lineItems[6]);
    //                lstPriVacc.Add(objVac);
    //            }
    //        }
    //    }
    //    return lstPriVacc;
    //}

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
