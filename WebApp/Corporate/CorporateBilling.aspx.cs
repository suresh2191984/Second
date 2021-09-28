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
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;

public partial class Reception_CorporateBilling : BasePage
{
    long visitID = 0;
    long patientID = 0;
    string PaidStatus = string.Empty;
    List<InvGroupMaster> lstGroups = new List<InvGroupMaster>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
    List<OrderedInvestigations> lstInvestigationsHL = new List<OrderedInvestigations>();
    Investigation_BL investigationBL ;
    IP_BL ipBL ;
    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    long taskID = 0;
    long returnCode = -1;
    string PaymentLogic = string.Empty;
    string gUID = string.Empty;
    string CollectSampleTask = "N";

  


    List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<InvPackageMapping> lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstCollectedPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
    List<ProcedureMaster> lstCollectedProcedures = new List<ProcedureMaster>();
    List<InvPackageMapping> lstDeletedPackageMapping = new List<InvPackageMapping>();
    List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        try
        {

            ((HiddenField)InvestigationControl2.FindControl("ISAddItems")).Value = "YES";

            if (!IsPostBack)
            {
                List<Patient> patientList = new List<Patient>();
                List<PatientVisit> lstPV = new List<PatientVisit>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                long pPatientID = 0;
                long visitID = 0;
                if (Request.QueryString["PID"] != null)
                {
                    pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
                }

                long returnCode = patientBL.GetPatientDemoandAddress(pPatientID, out patientList);
                lblPatientName.Text = "<h4>Order Services for " + patientList[0].TitleName + " " + patientList[0].Name + "(" + patientList[0].PatientNumber.Trim() + ")</h4>";
                hdnPName.Value = patientList[0].TitleName + "" + patientList[0].Name;
                txtBirthWeeks.Text = patientList[0].Age;
                LoadCorporateMaster();
                loadClientsName();

                if (Request.QueryString["vid"] != null)
                {
                    List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                    int clientID = 0;
                    new PatientVisit_BL(base.ContextInfo).GetVisitClientMappingDetails(OrgID, visitID, out lstVisitClientMapping);
                    if (lstVisitClientMapping.Count > 0)
                    {
                        

                        visitID = Request.QueryString["vid"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["vid"].ToString());
                        new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisit);
                        ddlClients.SelectedValue = lstVisitClientMapping[0].ClientID.ToString();
                        ddlCorporate.SelectedValue = lstVisitClientMapping[0].RateID.ToString();
                        ipConsultation.VisitRateID = (int) lstVisitClientMapping[0].RateID;
                        ddlClients.Enabled = false;
                        ddlCorporate.Enabled = false;
                    }
                }
                getAllDatas();
                
            }
            ipTreatmentBill.VisitID = 0;
            if (ddlClients.SelectedValue != "")
            {
                ipTreatmentBill.pClientID = Convert.ToInt64(ddlCorporate.SelectedValue);
            }
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }
            //btnAddHealth.PostBackUrl="~/EMR/PackageProfile.aspx?vid=" + visitID + "&pid=" + patientID + "&purpID=4&BK=Y";
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            PackageProfileControl.UseClientID = Convert.ToInt32(ddlCorporate.SelectedValue);
            ((HiddenField)PackageProfileControl.FindControl("hdnAddSevices")).Value = "";
            // Int64.TryParse(Request.QueryString["tid"], out taskID);
            List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
            List<OrderedInvestigations> oInvestigations = new List<OrderedInvestigations>();
            new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, visitID, out lstOrderedInves, out oInvestigations);



            #region ordered investigation

            PatientComplaint patientComplaint = new PatientComplaint();
            List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
            List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 
            List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
            List<PatientVisit> lstPatientVisitTemp = new List<PatientVisit>();
            string isBgP = string.Empty;
            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(0, visitID, out patientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisitTemp, out isBgP);


            var lstorderedInv = from lstInvList in lstPatientInvestigationHL
                                where lstInvList.Status == "Ordered"
                                select lstInvList;

            if (lstorderedInv.Count() > 0)
            {
                PaidInv.Style.Add("display", "block");
                dlInvName.DataSource = lstorderedInv;
                dlInvName.DataBind();

            }
            #endregion

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Investigation PageLoad", ex);
        }
    }
    public void getAllDatas()
    {
        ipBL.GetIPVisitDetails(visitID, out lstPatientVisit);
        new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), 0, Convert.ToInt32(ddlCorporate.SelectedValue), out lstGroups, out lstInvestigations);

        InvestigationControl2.LoadLabData(lstGroups, lstInvestigations);

        PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<IpPayments> IPL = new List<IpPayments>();

        if (visitID != 0)
        {
            //Load Data's for Particular visit in Investigation Control
            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstGrp = new List<OrderedInvestigations>();

            new IP_BL(base.ContextInfo).GetIPOrderedInvestigation(visitID, out lstInv, out lstGrp);
            if (lstInv.Count > 0 || lstGrp.Count > 0)
            {
                InvestigationControl2.loadOrderedList(lstInv, lstGrp);
            }
        }
    }
    public void LoadCorporateMaster()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateType = new List<RateMaster>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            string OrgType = "COrg";
            Returncode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            if (lstRateType.Count > 0)
            {
                ddlCorporate.DataSource = lstRateType;
                ddlCorporate.DataTextField = "RateName";
                ddlCorporate.DataValueField = "RateId";
                ddlCorporate.DataBind();
                ddlCorporate.Items.Insert(0, "---Select--->");
            }
            else
            {
                ddlCorporate.DataSource = null;
                ddlCorporate.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    protected void loadClientsName()
    {
        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
        List<InvClientMaster> ObjClientMas = new List<InvClientMaster>();
        ObjInv.getOrgClientName(OrgID, out ObjClientMas);
        ddlClients.DataSource = ObjClientMas;
        ddlClients.DataTextField = "ClientName";
        ddlClients.DataValueField = "ClientID";
        ddlClients.DataBind();
        //ddlClients.Items.Insert(0, "---Select---");
        //ddlClients.Items[0].Value = "0";
    }

    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            btnSave.Visible = false;
            btnClose.Visible = false;
            StoreDueChart();
        }
        catch (Exception ex)
        {
            btnSave.Visible = true;
            btnClose.Visible = true;
            CLogger.LogError("Error in OP/Save Add Bill Items", ex);
        }
    }

    public void StoreDueChart()
    {
        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        int purpID = 1;
        long phyID = -1;
        int otherID = -1;
        string feeType = String.Empty;
        string otherName = String.Empty;
        string physicianName = String.Empty;
        string referrerName = string.Empty;
        long taskID = -1;
        long ptaskID = -1;
        int CorporateID = 0;
        int pClientID = 0;
        Int32.TryParse(ddlCorporate.SelectedValue, out pClientID);

        Int32.TryParse(ddlClients.SelectedValue, out CorporateID);

        gUID = Guid.NewGuid().ToString();

        string status = "";
        status = "Pending";


        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        int specialityID = -1;


        long returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
        Patient patient = new Patient();
        patient = lstPatient[0];



        PackageProfileControl.CollectPackageContent(out lstPackagesTemp, out lstCollectedDefaultPackageMapping, out lstCollectedPackageMapping, out lstCollectedSpeciality, out lstCollectedProcedures, out lstDeletedPackageMapping, out lstCollectedHealthCheckUpMaster);
        List<AdditionalTubeMapping> lstAdditionalTubeMapping = new List<AdditionalTubeMapping>();
        if (lstCollectedDefaultPackageMapping.Count > 0)
        {
            returnCode = new Investigation_BL(base.ContextInfo).UpdatePackageContent(lstCollectedDefaultPackageMapping, lstDeletedPackageMapping, OrgID, lstAdditionalTubeMapping);
        }

        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>(); //HL
        if (lstPackagesTemp.Count > 0)
        {
            foreach (InvGroupMaster objPKG in lstPackagesTemp)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                objInvest.ID =objPKG.AttGroupID;
                objInvest.Name = objPKG.GroupName;
                objInvest.VisitID = visitID;
                objInvest.OrgID = OrgID;
                objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                objInvest.Status = "ordered";
                objInvest.CreatedBy = LID;
                objInvest.Type = objPKG.Type;
                orderedInvesHL.Add(objInvest);
            }
        }

        int pOrderedInvCnt = 0;
        string paymentstatus = "Pending";
        string labno = string.Empty;
        if (orderedInvesHL.Count > 0)
        {

            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(orderedInvesHL, OrgID, out pOrderedInvCnt, paymentstatus, gUID, labno);

            #region for HealthScreen Task
            if (lstCollectedHealthCheckUpMaster.Count > 0)
            {
                long ptaskIDHC = -1;
                feeType = "HEALTHPKG";
                otherID = 0;
                int visitPurposeID = -1;
                Int32.TryParse(Request.QueryString["purpID"], out visitPurposeID);
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

                taskActionHC = lstTaskAction[0];
                returnCode = Utilities.GetHashTable(taskActionHC.TaskActionID, visitID, phyID,
                                              patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                task.TaskActionID = taskActionHC.TaskActionID;
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.PatientID = patientID;
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
                otherID = objSpeciality.SpecialityID;
                specialityID = objSpeciality.SpecialityID;
                returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);
                TaskActions taskAction = new TaskActions();
                taskAction = lstTaskAction[0];
                if (returnCode == 0)
                {

                    //*******for Task*******************
                    //Created by ashok to add multiple tasks
                    for (int i = 0; i < lstTaskAction.Count; i++)
                    {
                        taskAction = lstTaskAction[i];

                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                  patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID
                        task.TaskActionID = taskAction.TaskActionID;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientID;

                        task.AssignedTo = 0;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.SpecialityID = specialityID;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out ptaskID);
                    }
                }
            }
            try
            {


                feeType = "HEALTHPKG";
                otherID = 0;
                phyID = 0;
                if (PaymentLogic == string.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                //if (PaymentLogic == "Before")
                //{

                #region commented by sami
                //List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                //List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                //List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                //new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID,gUID, out lstSampleDept1, out lstSampleDept2);


                //foreach (var item in lstSampleDept1)
                //{
                //    if (item.Display == "Y")
                //    {
                //        Int64.TryParse(Request.QueryString["pid"], out patientID);
                //        long createTaskID = -1;

                //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                //                     visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                //                     lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                //                     , out dText, out urlVal, 0, 0, 0, gUID);
                //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                //        task.DispTextFiller = dText;
                //        task.URLFiller = urlVal;
                //        task.RoleID = RoleID;
                //        task.OrgID = OrgID;
                //        task.AssignedTo = 0;
                //        task.PatientVisitID = visitID;
                //        task.PatientID = patientID;
                //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //        task.CreatedBy = LID;
                //        //Create task               
                //        returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);

                //        break;
                //    }
                //}
                //foreach (var item in lstSampleDept1)
                //{
                //    if (item.Display == "N")
                //    {
                //        InvestigationValues inValues = new InvestigationValues();
                //        inValues.InvestigationID = item.InvestigationID;
                //        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                //        inValues.PackageID = item.PackageID;
                //        inValues.PackageName = item.PackageName;

                //        lstInvResult.Add(inValues);
                //    }
                //}
                //returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);
                #endregion

            }
            catch (System.Threading.ThreadAbortException tex)
            {
                string te = tex.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
            }
        }


        PatientVisit_BL objPatientVisit = new PatientVisit_BL(base.ContextInfo);

        string pCreateTask = "YES";
        //if (visitID == 0)
        //{
        //    pCreateTask = "YES";
        //}
        //else
        //{
        //    pCreateTask = "";
        //}

        string RefPhysicianName = "", RefspecialityName = "";
        int RefphysicianID = 0;
        int otherRefID = 0, otherSpecID = 0, RefSpecialtiyID = 0;
        List<PatientDueChart> lstPatientConsultation = new List<PatientDueChart>();
        List<PatientDueChart> lstPatientProcedure = new List<PatientDueChart>();
        List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();


        int retstatus = 0;
        long outpVisit = 0;
        DropDownList ddlReferPhysician = (DropDownList)Rfrdoctor.FindControl("ddlConsultingName");
        RefPhysicianName = ddlReferPhysician.SelectedItem.Text;
        Int32.TryParse(ddlReferPhysician.SelectedItem.Value, out otherRefID);
        RefphysicianID = otherRefID;
        DropDownList ddlReferSpeciality = (DropDownList)Rfrdoctor.FindControl("ddlSpeciality");
        RefspecialityName = ddlReferSpeciality.SelectedItem.Text;
        Int32.TryParse(ddlReferSpeciality.SelectedItem.Value, out otherSpecID);
        RefSpecialtiyID = otherSpecID;
        List<FinalBill> lstFinal = new List<FinalBill>();

        lstPatientConsultation = dspData.GetConsNProDetails();

        //foreach (InvGroupMaster iv in lstPackagesTemp)
        //{
        //    PatientDueChart pd = new PatientDueChart();
        //    pd.FeeID = iv.GroupID;
        //    pd.FeeType = iv.Type;
        //    pd.Description = iv.DisplayText;
        //    pd.Amount = 0;
        //    lstPatientConsultation.Add(pd);
        //}

        if (lstPatientConsultation.Count > 0)
        {
            List<PatientDueChart> lstTempCount = (from lstduetemp in lstPatientConsultation
                                                  where lstduetemp.FeeType != "IMU"
                                                  select lstduetemp).ToList();

            //List<PatientDueChart> lstTempPhysiotherapy = (from lstduetemp in lstPatientConsultation
            //                                              where lstduetemp.FeeType == "PRO" && lstduetemp.Description!="Dialysis"
            //                                      select lstduetemp).ToList();

            //List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            //if (lstTempPhysiotherapy.Count > 0)
            //{             


            //    foreach (PatientDueChart dueitem in lstTempPhysiotherapy)
            //    {

            //        OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();

            //        ptt.ProcedureID = dueitem.FeeID;
            //        ptt.ProcedureName = dueitem.Description;
            //        ptt.OdreredQty = dueitem.Unit;
            //        ptt.Status = "Ordered";
            //        ptt.PaymentStatus = "";
            //        lstOrderedPhysiotherapy.Add(ptt);
            //    }


            //    string Type = "Ordered";
            //    returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(visitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy);

            //long pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());

            // returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, visitID, 0,
            //        pPatientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber, "");
            // long ptaskid = -1;
            // task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
            // task.DispTextFiller = dText;
            // task.URLFiller = urlVal;
            // task.PatientID = pPatientID;
            // task.OrgID = OrgID;
            // task.PatientVisitID = visitID;
            // task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            // task.CreatedBy = LID;
            // returnCode = taskBL.CreateTask(task, out ptaskid);

            //}




            if (lstTempCount.Count > 0)
            {

                new BillingEngine(base.ContextInfo).InsertOPBillingDetails(
                                                  OrgID, lstPatientConsultation, lstPatientProcedure,
                                                  lstPatientInvestigationHL,
                                                  out retstatus, visitID,
                                                  patientID, ILocationID,
                                                  pClientID, CorporateID,
                                                  LID, out outpVisit,
                                                  pCreateTask, RefphysicianID,
                                                  RefSpecialtiyID,
                                                  out lstFinal, gUID);
            }

            if (lstFinal.Count > 0)
            {
                visitID = lstFinal[0].VisitID;
            }

            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            lstPatient = new List<Patient>();
            returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
            patient = new Patient();
            patient = lstPatient[0];
            try
            {
                if (pCreateTask == "YES")
                {
                    List<PatientDueChart> lstDue = (from lstduetemp in lstPatientConsultation
                                                    where lstduetemp.FeeType == "CON"
                                                    select lstduetemp).ToList();

                    if (lstDue.Count > 0)
                    {
                        for (int j = 0; j < lstDue.Count; j++)
                        {
                            // Collect payment task
                            ptaskID = 0;
                            task = new Tasks();
                            dText = new Hashtable();
                            urlVal = new Hashtable();
                            TaskActions taskAction = new TaskActions();
                            lstTaskAction = new List<TaskActions>();

                            returnCode = new PatientVisit_BL(base.ContextInfo).GetTaskActionID(OrgID, 1,
                                                                lstDue[j].DetailsID,
                                                                out lstTaskAction);
                            for (int i = 0; i < lstTaskAction.Count; i++)
                            {
                                taskAction = lstTaskAction[i];

                                returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, lstDue[j].FeeID,
                                                          patientID, patient.TitleName + " " + patient.Name, lstDue[j].Description,
                                                          otherID, "", 0, "", 0, "", out dText, out urlVal, 0, patient.PatientNumber, 0, ""); // Other Id meand Procedure ID
                                task.TaskActionID = taskAction.TaskActionID;
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.PatientID = patientID;

                                task.AssignedTo = lstDue[j].FeeID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = visitID;
                                task.SpecialityID = (int)lstDue[j].DetailsID;
                                task.CreatedBy = LID;
                                returnCode = taskBL.CreateTask(task, out ptaskID);
                            }
                        }

                    }
                }
                List<PatientDueChart> lstDuePRO = (from lstduetemp in lstPatientConsultation
                                                   where lstduetemp.FeeType == "PRO"
                                                   select lstduetemp).ToList();

                if (lstDuePRO.Count > 0)
                {
                    long ptaskid = 0;
                    for (int i = 0; i < lstDuePRO.Count; i++)
                    {
                        if (lstDuePRO[i].Description.ToLower() == "dialysis")
                        {
                            returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
                                patientID, patient.TitleName + " " + patient.Name, "", lstDuePRO[i].FeeID, "", 0, "", 0, lstDuePRO[i].FeeType, out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                            task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.PatientID = patientID;
                            task.AssignedTo = 0;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out ptaskid);
                        }
                    }
                }
                List<PatientDueChart> lstDueINV = (from lstduetemp in lstPatientConsultation
                                                   where lstduetemp.FeeType == "INV" || lstduetemp.FeeType == "GRP"
                                                   select lstduetemp).ToList();

                if (lstDueINV.Count > 0 || orderedInvesHL.Count > 0)
                {

                    //taskID = 0;
                    //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    //returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), visitID, 0,
                    //    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber, gUID);
                    //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                    //task.DispTextFiller = dText;
                    //task.URLFiller = urlVal;
                    //task.RoleID = RoleID;
                    //task.OrgID = OrgID;
                    //task.AssignedTo = 0;
                    //task.PatientVisitID = visitID;
                    //task.PatientID = patientID;
                    //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //task.CreatedBy = LID;
                    //task.SpecialityID = 0;
                    ////Create task               
                    //returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out taskID);

                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

                    string sVal = GetConfigValue("SampleCollect", OrgID);

                    if (sVal.Trim() != "N")
                    {
                        foreach (var item in lstSampleDept1)
                        {
                            if (item.Display == "Y")
                            {
                                Int64.TryParse(Request.QueryString["pid"], out patientID);
                                long createTaskID = -1;

                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                             visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                             , out dText, out urlVal, 0, "", 0, gUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.AssignedTo = 0;
                                task.PatientVisitID = visitID;
                                task.PatientID = patientID;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                //Create task               
                                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);

                                break;
                            }
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
                    returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);


                }

                List<PatientDueChart> lstImmunization = (from lstduetemp in lstPatientConsultation
                                                         where lstduetemp.FeeType == "IMU"
                                                         select lstduetemp).ToList();

                if (lstImmunization.Count > 0)
                {
                    taskID = 0;

                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

                    TaskActions taskAction = new TaskActions();
                    lstTaskAction = new List<TaskActions>();

                    returnCode = new PatientVisit_BL(base.ContextInfo).GetTaskActionID(OrgID, 11, 0, out lstTaskAction);
                    taskAction = lstTaskAction[0];

                    returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, 0,
                                                  patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                  patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                    task.TaskActionID = taskAction.TaskActionID;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = lstPatientVisitDetails[0].PatientID;
                    task.AssignedTo = 0;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.SpecialityID = 0;
                    task.CreatedBy = LID;
                    //Create task               
                    returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
                }

                //-----------------------------------------hindu not bill print config
                string configbill = string.Empty;
                configbill = Session["IsCorporateOrgPaymenttype"].ToString();
                //--------------------------------------------------------------------
                if (configbill == "N")
                {
                    if (lstTempCount.Count > 0)
                    {
                        long ptaskID1 = 0;
                        task = new Tasks();
                        dText = new Hashtable();
                        urlVal = new Hashtable();
                        returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CollectPayment, visitID, 0,
                        patientID, lstPatient[0].Name, "", 0, "", 0, "", 0, "ALL", out dText, out urlVal,
                        lstFinal[0].FinalBillID, lstPatient[0].PatientNumber, 0, ""); // Other Id meand Procedure ID

                        task.TaskActionID = (int)TaskHelper.TaskAction.CollectPayment;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientID;
                        task.AssignedTo = 0;
                        task.BillID = lstFinal[0].FinalBillID;
                        //task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out ptaskID1);
                        string pConfigKey = "IsReceptionCashier";
                        string pOutStatus = string.Empty;
                        returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);
                        if (pOutStatus != "Y")
                        {
                            Response.Redirect("~/Billing/Billing.aspx?PID=" + patientID + "&VID=" + visitID + "&BID=" + lstFinal[0].FinalBillID + "&TID=" + ptaskID1);
                        }
                        else
                        {
                            List<Role> lstUserRole1 = new List<Role>();
                            string path1 = string.Empty;
                            Role role1 = new Role();
                            role1.RoleID = RoleID;
                            lstUserRole1.Add(role1);
                            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                            Response.Redirect(Request.ApplicationPath + path1, true);
                        }
                    }

                }
                else
                {
                    string path1 = string.Empty;
                    List<Role> lstUserRole1 = new List<Role>();
                    Role role1 = new Role();
                    role1.RoleID = RoleID;
                    lstUserRole1.Add(role1);
                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                    Response.Redirect(Request.ApplicationPath + path1, true);
                }
            }

            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in due chart", ex);
            }
        }

        #region tempComment


        //string RefPhysicianName = String.Empty;
        //string RefspecialityName = String.Empty;
        //int RefphysicianID = -1;
        //int RefSpecialtiyID = -1;
        //int otherID = -1;
        //int otherRefID = -1;
        //int otherSpecID = -1;

        //if (Request.QueryString["VID"] != null)
        //{
        //    visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        //}

        //if (Request.QueryString["PID"] != null)
        //{
        //    patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        //}
        //int CorporateID = 0;
        //Int32.TryParse(ddlCorporate.SelectedValue, out CorporateID);
        //int pClientID = 0;
        //Int32.TryParse(ddlClients.SelectedValue, out pClientID);

        //string status = "";
        //status = "Pending";

        //List<PatientDueChart> lstPatientConsultation = new List<PatientDueChart>();
        //List<PatientDueChart> lstPatientProcedure = new List<PatientDueChart>();
        //List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();//List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 

        //lstPatientConsultation = dspData.GetConsNProDetails();//"CON");

        //PatientVisit_BL objPatientVisit = new PatientVisit_BL(base.ContextInfo);

        //long createTaskID = -1;
        //Hashtable dText = new Hashtable();
        //Hashtable urlVal = new Hashtable();
        //Tasks task = new Tasks();
        //Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        //long returnCode = -1;
        //string pCreateTask = "YES";
        ////if (visitID == 0)
        ////{
        ////    pCreateTask = "YES";
        ////}
        ////else
        ////{
        ////    pCreateTask = "";
        ////}
        //int retstatus = 0;
        //long outpVisit = 0;
        //DropDownList ddlReferPhysician = (DropDownList)Rfrdoctor.FindControl("ddlConsultingName");
        //RefPhysicianName = ddlReferPhysician.SelectedItem.Text;
        //Int32.TryParse(ddlReferPhysician.SelectedItem.Value, out otherRefID);
        //RefphysicianID = otherRefID;
        //DropDownList ddlReferSpeciality = (DropDownList)Rfrdoctor.FindControl("ddlSpeciality");
        //RefspecialityName = ddlReferSpeciality.SelectedItem.Text;
        //Int32.TryParse(ddlReferSpeciality.SelectedItem.Value, out otherSpecID);
        //RefSpecialtiyID = otherSpecID;
        //List<FinalBill> lstFinal = new List<FinalBill>();



        //if (lstPatientConsultation.Count > 0)
        //{
        //    List<PatientDueChart> lstTempCount = (from lstduetemp in lstPatientConsultation
        //                                          where lstduetemp.FeeType != "IMU"
        //                                          select lstduetemp).ToList();
        //    if (lstTempCount.Count > 0)
        //    {
        //        new BillingEngine(base.ContextInfo).InsertOPBillingDetails(
        //                                          OrgID, lstPatientConsultation, lstPatientProcedure,
        //                                          lstPatientInvestigationHL,
        //                                          out retstatus, visitID,
        //                                          patientID, ILocationID,
        //                                          pClientID, CorporateID,
        //                                          LID, out outpVisit,
        //                                          pCreateTask, RefphysicianID,
        //                                          RefSpecialtiyID,
        //                                          out lstFinal);
        //    }

        //    if (lstFinal.Count > 0)
        //    {
        //        visitID = lstFinal[0].VisitID;
        //    }

        //    if (Request.QueryString["PID"] != null)
        //    {
        //        patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        //    }
        //    List<Patient> lstPatient = new List<Patient>();
        //    returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
        //    Patient patient = new Patient();
        //    patient = lstPatient[0];
        //    try
        //    {
        //        if (pCreateTask == "YES")
        //        {
        //            List<PatientDueChart> lstDue = (from lstduetemp in lstPatientConsultation
        //                                            where lstduetemp.FeeType == "CON"
        //                                            select lstduetemp).ToList();

        //            if (lstDue.Count > 0)
        //            {
        //                for (int j = 0; j < lstDue.Count; j++)
        //                {
        //                    // Collect payment task
        //                    long ptaskID = 0;
        //                    task = new Tasks();
        //                    dText = new Hashtable();
        //                    urlVal = new Hashtable();
        //                    TaskActions taskAction = new TaskActions();
        //                    List<TaskActions> lstTaskAction = new List<TaskActions>();

        //                    returnCode = new PatientVisit_BL(base.ContextInfo).GetTaskActionID(OrgID, 1,
        //                                                        lstDue[j].DetailsID,
        //                                                        out lstTaskAction);
        //                    for (int i = 0; i < lstTaskAction.Count; i++)
        //                    {
        //                        taskAction = lstTaskAction[i];

        //                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, lstDue[j].FeeID,
        //                                                  patientID, patient.TitleName + " " + patient.Name, lstDue[j].Description,
        //                                                  otherID, "", 0, "", 0, "", out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), 0); // Other Id meand Procedure ID
        //                        task.TaskActionID = taskAction.TaskActionID;
        //                        task.DispTextFiller = dText;
        //                        task.URLFiller = urlVal;
        //                        task.PatientID = patientID;

        //                        task.AssignedTo = lstDue[j].FeeID;
        //                        task.OrgID = OrgID;
        //                        task.PatientVisitID = visitID;
        //                        task.SpecialityID = (int)lstDue[j].DetailsID;
        //                        task.CreatedBy = LID;
        //                        returnCode = taskBL.CreateTask(task, out ptaskID);
        //                    }
        //                }

        //            }
        //        }
        //        List<PatientDueChart> lstDuePRO = (from lstduetemp in lstPatientConsultation
        //                                           where lstduetemp.FeeType == "PRO"
        //                                           select lstduetemp).ToList();

        //        if (lstDuePRO.Count > 0)
        //        {
        //            long ptaskid = 0;
        //            for (int i = 0; i < lstDuePRO.Count; i++)
        //            {
        //                if (lstDuePRO[i].Description.ToLower() == "dialysis")
        //                {
        //                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
        //                        patientID, patient.TitleName + " " + patient.Name, "", lstDuePRO[i].FeeID, "", 0, "", 0, lstDuePRO[i].FeeType, out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber); // Other Id meand Procedure ID

        //                    task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
        //                    task.DispTextFiller = dText;
        //                    task.URLFiller = urlVal;
        //                    task.PatientID = patientID;
        //                    task.AssignedTo = 0;
        //                    task.OrgID = OrgID;
        //                    task.PatientVisitID = visitID;
        //                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        //                    task.CreatedBy = LID;
        //                    returnCode = taskBL.CreateTask(task, out ptaskid);
        //                }
        //            }
        //        }
        //        List<PatientDueChart> lstDueINV = (from lstduetemp in lstPatientConsultation
        //                                           where lstduetemp.FeeType == "INV" || lstduetemp.FeeType == "GRP"
        //                                           select lstduetemp).ToList();

        //        if (lstDueINV.Count > 0)
        //        {
        //            long taskID = 0;
        //            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
        //            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), visitID, 0,
        //                patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber);
        //            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
        //            task.DispTextFiller = dText;
        //            task.URLFiller = urlVal;
        //            task.RoleID = RoleID;
        //            task.OrgID = OrgID;
        //            task.AssignedTo = 0;
        //            task.PatientVisitID = visitID;
        //            task.PatientID = patientID;
        //            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        //            task.CreatedBy = LID;
        //            task.SpecialityID = 0;
        //            //Create task               
        //            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
        //        }

        //        List<PatientDueChart> lstImmunization = (from lstduetemp in lstPatientConsultation
        //                                                 where lstduetemp.FeeType == "IMU"
        //                                                 select lstduetemp).ToList();

        //        if (lstImmunization.Count > 0)
        //        {
        //            long taskID = 0;
        //            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

        //            TaskActions taskAction = new TaskActions();
        //            List<TaskActions> lstTaskAction = new List<TaskActions>();

        //            returnCode = new PatientVisit_BL(base.ContextInfo).GetTaskActionID(OrgID, 11, 0, out lstTaskAction);
        //            taskAction = lstTaskAction[0];

        //            returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, 0,
        //                                          patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", otherID, "", 0, "", 0, "", out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber); // Other Id meand Procedure ID

        //            task.TaskActionID = taskAction.TaskActionID;
        //            task.DispTextFiller = dText;
        //            task.URLFiller = urlVal;
        //            task.PatientID = lstPatientVisitDetails[0].PatientID;
        //            task.AssignedTo = 0;
        //            task.OrgID = OrgID;
        //            task.PatientVisitID = visitID;
        //            task.SpecialityID = 0;
        //            task.CreatedBy = LID;
        //            //Create task               
        //            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
        //        }

        //        if (lstTempCount.Count > 0)
        //        {
        //            long ptaskID1 = 0;
        //            task = new Tasks();
        //            dText = new Hashtable();
        //            urlVal = new Hashtable();
        //            returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
        //            returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CollectPayment, visitID, 0,
        //            patientID, lstPatient[0].Name, "", 0, "", 0, "", 0, "ALL", out dText, out urlVal, lstFinal[0].FinalBillID, Convert.ToInt64(lstPatient[0].PatientNumber), 0); // Other Id meand Procedure ID

        //            task.TaskActionID = (int)TaskHelper.TaskAction.CollectPayment;
        //            task.DispTextFiller = dText;
        //            task.URLFiller = urlVal;
        //            task.PatientID = patientID;
        //            task.AssignedTo = 0;
        //            task.BillID = lstFinal[0].FinalBillID;
        //            //task.RoleID = RoleID;
        //            task.OrgID = OrgID;
        //            task.PatientVisitID = visitID;
        //            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        //            task.CreatedBy = LID;
        //            returnCode = taskBL.CreateTask(task, out ptaskID1);
        //            Response.Redirect("~/Billing/Billing.aspx?PID=" + patientID + "&VID=" + visitID + "&BID=" + lstFinal[0].FinalBillID + "&TID=" + ptaskID1);
        //        }
        //        else
        //        {
        //            object sender = null;
        //            EventArgs evx = null;
        //            btnClose_Click(sender, evx);
        //        }
        //    }

        //    catch (System.Threading.ThreadAbortException tae)
        //    {
        //        string thread = tae.ToString();
        //    }
        //    catch (Exception ex)
        //    {
        //    }
        //}
        #endregion
    }



    public void ClearControls()
    {
        ((HiddenField)ipConsultation.FindControl("iconHidDelete")).Value = "";
        ((HiddenField)InvestigationControl2.FindControl("iconHid")).Value = "";
        ipTreatmentBill.GetProcedureNameByProcedure();
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void grdDuechart_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
    }


    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
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
}
