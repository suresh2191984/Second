﻿using System;
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
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;

public partial class CorporateQuickBilling : BasePage
{
    long returnCode = -1;
    string vType = string.Empty;
    long VisitID = -1, PatientID = -1, taskID = -1;
    string BillNumber = string.Empty;
    string gUID = string.Empty;
    string feeType = String.Empty;
    int RateID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        Patient lstPatient = new Patient();
        if (!IsPostBack)
        {

            #region Load FeeTypes
            List<FeeTypeMaster> lstFTM = new List<FeeTypeMaster>();
            returnCode = new BillingEngine(base.ContextInfo).GetFeeType(OrgID, vType, out lstFTM);
            if (lstFTM.Count > 0)
            {
                rblFeeTypes.DataSource = lstFTM;
                rblFeeTypes.DataTextField = "FeeTypeDesc";
                rblFeeTypes.DataValueField = "FeeType";
                rblFeeTypes.DataBind();
                //rblFeeTypes.SelectedIndex = 0;
                hdnFeeType1.Value = rblFeeTypes.SelectedValue.ToString();
            }
            Int64.TryParse(Request.QueryString["VID"], out VisitID);
            Int64.TryParse(Request.QueryString["PID"], out PatientID);
            Int32.TryParse(Request.QueryString["RateID"], out RateID);
            hdnPatientID.Value = PatientID.ToString();
            hdnRateID.Value = RateID.ToString();
            AutoCompleteExtender3.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString() + "~" + hdnRateID.Value.ToString();
            userHeader.Visible = true;
            #endregion
            LoadHospitalBranch();
            LoadSpecialityName();
            LoadVisitPurpose();
            //if (rblFeeTypes.SelectedItem.Value == "CON")
            //{
            //    trDescription.Attributes.Add("display", "none");
            //    trDocrName.Attributes.Add("display", "Block");
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "chkPros", "javascript:chkPros();", true);

            //}

        }



    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<Speciality> lstSpeciality1 = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);
        hdnSpecality.Value = "";
        for (int i = 0; lstSpeciality.Count > i; i++)
        {
            hdnSpecality.Value += lstSpeciality[i].SpecialityID + "~" + lstSpeciality[i].SpecialityName + "^";
        }
        if (lstSpeciality.Count > 0)
        {
            lstSpeciality1 = (from t in lstSpeciality
                              select new Speciality
                              {
                                  SpecialityName = t.SpecialityName.Split(':')[0].ToString(),
                                  SpecialityID = t.SpecialityID,
                              }).ToList();
        }
        ddlSpeciality.DataSource = lstSpeciality1;
        ddlSpeciality.DataTextField = "SpecialityName";
        ddlSpeciality.DataValueField = "SpecialityID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, "-----Select-----");
    }
    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, out RefOrg);
            
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgNameWithAddress";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";

                foreach (ListItem lit in ddlHospital.Items)
                {
                    lit.Attributes.Add("Title", lit.Text);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
        }
    }
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {

        PatVistiRefID.Value = (ddlHospital.SelectedValue).ToString();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        saveData();
    }
    public void saveData()
    {
        string EmpNo = "";
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        Int64.TryParse(Request.QueryString["PID"], out PatientID);
        Int32.TryParse(Request.QueryString["RateID"], out RateID);
        EmpNo=Request.QueryString["EmpNo"].ToString();
        
        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();

        int RefphysicianID = -1;
        int RefSpecialtiyID = -1;
        long RefPhyID = -1;
        long phyID = -1;
        int otherID = -1;
        long referOrgID = -1;
        string feeType = String.Empty;
        string otherName = String.Empty;
        string physicianName = String.Empty;
        string RefPhysicianName = String.Empty;
        string referrerName = string.Empty;
        int ClientID = 0;
        string patientName = string.Empty;
        string PaymentLogic = string.Empty;
        long returnCode = -1;
        string sPatientName = string.Empty;
        string RefspecialityName = string.Empty;

        RefPhyID = 1;
        RefphysicianID = Convert.ToInt32(RefPhyID);
        feeType = "CON";
        phyID = 0;
        if (PatientID > 0)
        {
            pVisit.VisitPurposeID = 0;
            pVisit.PhysicianID = (int)phyID;
            pVisit.OrgID = OrgID;
            pVisit.PatientID = PatientID;
            pVisit.ReferingPhysicianID = RefphysicianID;
            pVisit.ReferingPhysicianName = RefPhysicianName;
            pVisit.ReferingSpecialityID = RefSpecialtiyID;
            pVisit.OrgAddressID = ILocationID;
            pVisit.SpecialityID = otherID;
            pVisit.ReferOrgID = referOrgID;
            
            pVisit.CreatedBy = LID;
            
            pVisit.ParentVisitId = 0;
            pVisit.PriorityID = 0;


            long enteredPatientID = 0;
            enteredPatientID = PatientID;
            int iTokenNo = 0;
            long lScheduleNo = 0;
            long lResourceTemplateNo = 0;
            string needIPNo = string.Empty;
            List<Config> lstCon = new List<Config>();
            iTokenNo = 0;
            lScheduleNo = 0;
            lResourceTemplateNo = 0;

            string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
            DateTime dtFromTime = new DateTime();
            DateTime dtToTime = new DateTime();

            if (dtFromTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            if (dtToTime.ToString("dd/MM/yyyy") == "01/01/0001")
            {
                dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            }

            int iRetTokenNumber = 0;
            List<VisitClientMapping> lst = IPClientTpaInsurance1.GetClientValues(); ;
            returnCode = pvisitBL.SaveVisit(pVisit, out VisitID, enteredPatientID,iTokenNo, lScheduleNo, lResourceTemplateNo,sPassedTime,
                out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);
        }
            
       
        long refPhyID = 0;
        int refSpecialityID = 0;
        string refPhyName = "";
        int visitpurposeID = 0;

        visitpurposeID = Convert.ToInt32(dPurpose.SelectedValue.ToString());
        lstPatientDueChart = dspData.GetConsNProDetails();

        var Specialty = from lstSP in lstPatientDueChart
                        where lstSP.FeeType == "CON"
                        orderby lstSP.FeeID descending
                        select lstSP.SpecialityID;

        long pSpecialityID = 0;

        if (Specialty.Count() > 0)
        {

            pSpecialityID = Specialty.First();
        }
        string ReferralType = string.Empty;
        refPhyID = ReferDoctor1.GetRefPhyID();
        refSpecialityID = ReferDoctor1.GetSpeciality();
        refPhyName = ReferDoctor1.GetRefPhyName();
        ReferralType = ReferDoctor1.GetReferralType();
        refPhyName = refPhyName + "~" + ReferralType;

        List<PatientReferringDetails> lstPatientRefDetails = new List<PatientReferringDetails>();
        List<PatientDueChart> lstBillingforTask = new List<PatientDueChart>();
        lstPatientRefDetails = dspData.GetPatientReferringDetails();

        string labno = string.Empty;
        int returnStatus = -1;
        decimal GrossValue = 0;
        string isCreditBill = "N";
        string IsFreeOfCost = "Y";
        GrossValue = dspData.GetGross(out GrossValue);
        BillingEngine objBE = new BillingEngine(base.ContextInfo);
        objBE.InsertCorporteBill(PatientID, VisitID, RateID, GrossValue, GrossValue, lstPatientDueChart, LID, OrgID, refPhyID, refSpecialityID,
                                pSpecialityID, refPhyName, ILocationID, lstPatientRefDetails, isCreditBill, out labno, out returnStatus, IsFreeOfCost, visitpurposeID);
        #region Tasks

        int pOrderedInvCnt = 0;
        string paymentstatus = "Paid";



        if (returnStatus == 0)
        {
            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            int specialityID = -1;
            List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
            returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(PatientID, out lstPatient);
            Patient patient;
            patient = lstPatient.Count > 0 ? lstPatient[0] : new Patient();

            #region Investigations
            lstOrderedInvestigations = dspData.GetOrderedInvestigations(VisitID, out gUID);
            if (lstOrderedInvestigations != null)
            {
                if (lstOrderedInvestigations.Count > 0)
                {
                    //gUID = Guid.NewGuid().ToString();
                    returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(lstOrderedInvestigations, OrgID, out pOrderedInvCnt, paymentstatus, gUID, labno);
                    string sVal = GetConfigValue("SampleCollect", OrgID);
                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(VisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
                    if (sVal.Trim() != "N")
                    {
                        foreach (var item in lstSampleDept1)
                        {
                            if (item.Display == "Y")
                            {
                                //long createTaskID = -1;
                                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(VisitID, out lstPatientVisitDetails);
                                patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                             VisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                             patientName, "", 0, "", 0, "", 0, "INV"
                                             , out dText, out urlVal, "0", isCorporateOrg == "Y" ? EmpNo : lstPatientVisitDetails[0].PatientNumber, 0, gUID, "", lstPatientVisitDetails[0].VisitNumber,"");
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = VisitID;
                                task.PatientID = PatientID;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                task.RefernceID = labno.ToString();
                                //Create task               
                                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out taskID);
                                foreach (var itemss in lstOrderedInvestigations)
                                {
                                    for (int i = 0; i < lstPatientDueChart.Count; i++)
                                    {
                                        if (itemss.Name == lstPatientDueChart[i].Description)
                                        {
                                            PatientDueChart inValues = new PatientDueChart();
                                            inValues.FeeID= lstPatientDueChart[i].FeeID;
                                            inValues.FeeType = lstPatientDueChart[i].FeeType;
                                            inValues.Description = lstPatientDueChart[i].Description;
                                            inValues.DetailsID = taskID;
                                            inValues.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                            inValues.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                                                                      lstBillingforTask.Add(inValues);
                                        }
                                    }
                                }
                                break;
                                
                            }
                        }
                        if (taskID > 0)
                        {
                            returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvestigation(VisitID, labno, OrgID, BillNumber, taskID);
                        }
                    }
                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "N")
                        {
                            InvestigationValues inValues = new InvestigationValues();
                            inValues.InvestigationID = item.InvestigationID;
                            inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                            inValues.PackageID = item.PackageID;
                            inValues.PackageName = item.PackageName;
                            lstInvResult.Add(inValues);
                        }
                    }
                    returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(VisitID, "SampleReceived", OrgID, lstInvResult);
                    #region Helath Package
                    //Add By Syed
                    int pkgid = 0;
                    Investigation_BL investigationBL = new Investigation_BL();
                    List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
                    List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
                    List<InvPackageMapping> lstPackageMapping = new List<InvPackageMapping>();
                    List<Speciality> lstSpeciality = new List<Speciality>();
                    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
                    List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
                    List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();

                    investigationBL.GetHealthPackageData(OrgID,pkgid, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
                    int purpID = 4;
                    //  purpID =Convert.ToInt32(QPR.GetVisitPurposeID());

                    foreach (OrderedInvestigations objItems in lstOrderedInvestigations)
                    {
                        if (objItems.Type == "PKG")
                        {
                            //Get Speciality
                            int PkgID = -1;
                            foreach (InvGroupMaster PkgMaster in lstPackages)
                            {
                                if (objItems.ID == PkgMaster.AttGroupID)
                                {
                                    PkgID = PkgMaster.GroupID;
                                }

                            }
                            var invPMList = from invPM in lstPackageMapping
                                            where invPM.PackageID == Convert.ToInt32(PkgID) && invPM.Type == "CON"
                                            select invPM;
                            List<InvPackageMapping> lstPI1 = invPMList.ToList<InvPackageMapping>();
                            foreach (InvPackageMapping objPMTTT in lstPI1)
                            {
                                Speciality objCollectedSpeciality = new Speciality();
                                objCollectedSpeciality.SpecialityID = Convert.ToInt32(objPMTTT.ID);
                                objCollectedSpeciality.SpecialityName = "";
                                lstCollectedSpeciality.Add(objCollectedSpeciality);
                            }
                            //Get HealthCheckUpMaster
                            var invGHList = from invPM in lstPackageMapping
                                            where invPM.PackageID == Convert.ToInt32(PkgID) && invPM.Type == "GHC"
                                            select invPM;
                            List<InvPackageMapping> lstPI2 = invGHList.ToList<InvPackageMapping>();

                            foreach (InvPackageMapping objGHTTT in lstPI2)
                            {
                                GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                                objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(objGHTTT.ID);
                                objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = "";
                                lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                            }

                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            // int purpID = 1;
                            phyID = -1;
                            otherID = -1;
                            returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(PatientID, out lstPatient);
                            patient = lstPatient.Count > 0 ? lstPatient[0] : new Patient();

                           feeType = String.Empty;
                            otherName = String.Empty;
                             physicianName = String.Empty;
                             referrerName = string.Empty;
                            long ptaskID = -1;
                            //  string gUID = string.Empty;
                             PaymentLogic = string.Empty;
                            long visitID = VisitID;

                            #region for HealthScreen Task
                            if (lstCollectedHealthCheckUpMaster.Count > 0)
                            {
                                long ptaskIDHC = -1;
                                feeType = "HEALTHPKG";
                                otherID = 0;
                                int visitPurposeID = 4;
                                phyID = 0;
                                if (PaymentLogic == string.Empty)
                                {
                                    List<Config> lstConfig = new List<Config>();
                                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                                    if (lstConfig.Count > 0)
                                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                                }
                                pVisit.PhysicianName = "";
                                TaskActions taskActionHC = new TaskActions();

                                returnCode = pvisitBL.GetTaskActionID(OrgID, visitPurposeID, otherID, out lstTaskAction);
                                //Perform
                                taskActionHC = lstTaskAction[0];
                                returnCode = Utilities.GetHashTable(taskActionHC.TaskActionID, visitID, phyID,
                                                              PatientID, patient.TitleName + " " + patient.Name,
                                                              physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                              isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                                task.TaskActionID = taskActionHC.TaskActionID;
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.PatientID = PatientID;
                                task.AssignedTo = phyID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = visitID;
                                task.SpecialityID = specialityID;
                                task.CreatedBy = LID;
                                returnCode = taskBL.CreateTask(task, out ptaskIDHC);
                            }
                            #endregion
                            foreach (Speciality objSpeciality in lstCollectedSpeciality)
                            {
                                purpID = 1;
                                otherID = objSpeciality.SpecialityID; //21; 
                                specialityID = objSpeciality.SpecialityID; //1;// 
                                returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);
                                TaskActions taskAction = new TaskActions();
                                taskAction = lstTaskAction[0];
                                if (returnCode == 0)
                                {
                                    //*******for Task*******************
                                    //Created by ashok to add multiple tasks
                                    //Evaluate
                                    for (int i = 0; i < lstTaskAction.Count; i++)
                                    {
                                        taskAction = lstTaskAction[i];

                                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                                  PatientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID
                                        task.TaskActionID = taskAction.TaskActionID;
                                        task.DispTextFiller = dText;
                                        task.URLFiller = urlVal;
                                        task.PatientID = PatientID;

                                        task.AssignedTo = 0;
                                        task.OrgID = OrgID;
                                        task.PatientVisitID = visitID;
                                        task.SpecialityID = specialityID;
                                        task.CreatedBy = LID;
                                        returnCode = taskBL.CreateTask(task, out ptaskID);
                                    }
                                }
                            }
                        }
                    }
                    #endregion
                }
            }

            #endregion

            #region Physiotheraphy

            List<PatientDueChart> lstTempPhysiotherapy = (from lstduetemp in lstPatientDueChart
                                                          where lstduetemp.FeeType == "PRO" && lstduetemp.Description != "Dialysis" && lstduetemp.Description != "Others"
                                                          select lstduetemp).ToList();

            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();


            if (lstTempPhysiotherapy.Count > 0)
            {


                foreach (PatientDueChart dueitem in lstTempPhysiotherapy)
                {
                    OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();
                    ptt.ProcedureID = dueitem.FeeID;
                    ptt.ProcedureName = dueitem.Description;
                    ptt.OdreredQty = dueitem.Unit;
                    ptt.Status = "Ordered";
                    ptt.PaymentStatus = "";
                    lstOrderedPhysiotherapy.Add(ptt);
                }
            }


            if (lstOrderedPhysiotherapy.Count > 0)
            {
                string Type = "Ordered";
                int Physiocount = 0;
                returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(VisitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy, out Physiocount);
                if (Physiocount > 0)
                {
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    returnCode = patientBL.GetPatientDemoandAddress(PatientID, out lstPatient);
                    patient = lstPatient[0];
                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, VisitID, 0,
                           PatientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, feeType, out dText,
                           out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, "");
                    task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = PatientID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = VisitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    returnCode = taskBL.CreateTask(task, out taskID);
                    foreach (var items in lstOrderedPhysiotherapy)
                    {
                        for (int i = 0; i < lstPatientDueChart.Count; i++)
                        {
                            if (items.ProcedureName == lstPatientDueChart[i].Description)
                            {
                                PatientDueChart inValues = new PatientDueChart();
                                            inValues.FeeID= lstPatientDueChart[i].FeeID;
                                            inValues.FeeType = lstPatientDueChart[i].FeeType;
                                            inValues.Description = lstPatientDueChart[i].Description;
                                            inValues.DetailsID = taskID;
                                            inValues.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                            inValues.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                            
                                            lstBillingforTask.Add(inValues);
                            }
                        }
                    }
                }


            }


            #endregion

            #region Dialysis

            List<PatientDueChart> lsdia = (from lstdia in lstPatientDueChart
                                           where lstdia.FeeType == "PRO" && lstdia.Description == "Dialysis"
                                           select lstdia).ToList();


            if (lsdia.Count > 0)
            {
                returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PreDialysis, VisitID, 0,
                    PatientID, patient.TitleName + " " + patient.Name, "", lsdia[0].FeeID, "", 0, "", 0,
                    feeType, out dText, out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.PatientID = PatientID;
                task.OrgID = OrgID;
                task.PatientVisitID = VisitID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                returnCode = taskBL.CreateTask(task, out taskID);

            }

            #endregion

            #region Consultation

            List<PatientDueChart> lsCon = (from lstCon in lstPatientDueChart
                                           where lstCon.FeeType == "CON" || lstCon.FeeType == "SPE"
                                           select lstCon).ToList();

            int othersID = -1;

            if (lsCon.Count > 0)
            {

                foreach (PatientDueChart pdc in lsCon)
                {
                    othersID = pdc.SpecialityID;
                    specialityID = pdc.SpecialityID;
                    if (lsCon[0].FeeType == "SPE")
                    {
                        othersID = Convert.ToInt32(pdc.FeeID);
                        specialityID = Convert.ToInt32(pdc.FeeID);
                    }
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetTaskActionID(OrgID, 1, othersID, out lstTaskAction);
                    TaskActions taskAction = new TaskActions();
                    taskAction = lstTaskAction.Count > 0 ? lstTaskAction[0] : new TaskActions();
                    if (returnCode == 0)
                    {
                        //*******for Task*******************
                        //Created by ashok to add multiple tasks
                        for (int i = 0; i < lstTaskAction.Count; i++)
                        {
                            taskAction = lstTaskAction[i];

                            returnCode = Utilities.GetHashTable(taskAction.TaskActionID, VisitID, pdc.UserID,
                                                      PatientID, patient.TitleName + " " + patient.Name,
                                                      pdc.Description, othersID, "", 0, "", 0, "", out dText,
                                                      out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                            task.TaskActionID = taskAction.TaskActionID;
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.PatientID = PatientID;
                            task.AssignedTo = pdc.UserID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = VisitID;
                            task.SpecialityID = specialityID;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out taskID);
                        }
                        for (int i = 0; i < lstPatientDueChart.Count; i++)
                        {
                            if (pdc.Description == lstPatientDueChart[i].Description)
                            {
                                PatientDueChart inValues = new PatientDueChart();
                                inValues.FeeID = lstPatientDueChart[i].FeeID;
                                inValues.FeeType = lstPatientDueChart[i].FeeType;
                                inValues.Description = lstPatientDueChart[i].Description;
                                inValues.DetailsID = taskID;
                                inValues.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                inValues.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                lstBillingforTask.Add(inValues);
                            }
                        }

                    }
                }
            }
            #endregion
            if (lstBillingforTask.Count > 0)
            {
                objBE.UpdatedTaskIDinBillingDetails(PatientID, VisitID, lstBillingforTask, LID, OrgID);
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:FnIsvalid('" + returnStatus + "');", true);
        }
        #endregion

     

    }
    public void LoadVisitPurpose()
    {
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        List<Country> lstCountries = new List<Country>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        dPurpose.DataSource = lstVisitPurpose;
        dPurpose.DataTextField = "VisitPurposeName";
        dPurpose.DataValueField = "VisitPurposeID";
        dPurpose.DataBind();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        RedirectPage();
    }
    public void RedirectPage()
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}

