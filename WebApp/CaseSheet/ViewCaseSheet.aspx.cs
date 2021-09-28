using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;

public partial class CaseSheet_ViewCaseSheet : BasePage 
{
    long visitID = -1;
    long patientID = -1;
    long complaintID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVID = -1;
    long createdBy = -1;
    Tasks task = new Tasks();
    Tasks_BL taskBL ;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    long createTaskID = -1;
    string feeType = String.Empty;
    string PaymentLogic = String.Empty;
    string others = string.Empty;
    string InvDrugData = string.Empty;
    int drugCount = 0;
    string gUID = "";
    long VisitType = 0;
    string AddPay = string.Empty;
    int  InvLocationID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        if (Request.QueryString["page"] != "ICD")
        {
            /* Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);*/

            if (Request.QueryString["vid"] != null)
                Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            if (Request.QueryString["tid"] != null)
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            if (Request.QueryString["id"] != null)
                Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            if (Request.QueryString["pid"] != null)
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);

            feeType = Convert.ToString(Request.QueryString["ftype"]);
            others = Convert.ToString(Request.QueryString["oC"]);
            AddPay = (Request.QueryString["AddPay"]);
        
            InvLocationID =Convert.ToInt32(Request.QueryString["InvLocID"]);
            //InvLocationID = RoleHelper.Inventory == RoleName ? InvLocationID : 0;
        }

        if (PaymentLogic == String.Empty)
        {
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                PaymentLogic = lstConfig[0].ConfigValue.Trim();
        }

        if (PaymentLogic == "After")
        {
            FeesEntry1.LoadDBData = true;
            if (AddPay == "Y")
            {
                FeesEntry1.Visible = true;
            }
            else
            {
                FeesEntry1.Visible = false; //Change to false
            }
        }
        else
        {
            FeesEntry1.LoadDBData = false;
            if (AddPay == "Y")
            {
                FeesEntry1.Visible = true;
            }
            else 
            {
                FeesEntry1.Visible = false; //Change to false
            }
          
        }

        if (!Page.IsPostBack)
        {

            if (Request.QueryString["page"] != "ICD")
            {
                PatientHeader1.PatientID = patientID;
                PatientHeader1.PatientVisitID = visitID;
                PatientHeader1.ShowVitalsDetails();
                OPCaseSheet1.LoadPatientDetails(visitID, 0);

            }

            if (Request.QueryString["page"] != "ICD")
            {
                if (PaymentLogic == "After")
                {
                    PhysicianSchedule physician = new PhysicianSchedule();
                    new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                    FeesEntry1.Procedure = false;
                    FeesEntry1.Investigation = false;
                    FeesEntry1.Consulting = true;
                    FeesEntry1.PhysicianID = LID;
                    FeesEntry1.PatientVisitID = visitID;

                    //FeesEntry1.LoadDBData = true;

                    FeesEntry1.loadData();
                }
                else if (PaymentLogic == "Before" && others == "Y")
                {
                    PhysicianSchedule physician = new PhysicianSchedule();
                    new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                    FeesEntry1.Procedure = false;
                    FeesEntry1.Investigation = false;
                    FeesEntry1.Consulting = true;
                    FeesEntry1.PhysicianID = LID;
                    FeesEntry1.PatientVisitID = visitID;

                    //FeesEntry1.LoadDBData = false;

                    FeesEntry1.loadData();
                }
            }


            if (Request.QueryString["page"] == "ICD")
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
                btnPrint.Visible = false;
                btnEdit.Visible = false;
               // LeftMenu1.Visible = false;
                MHead.Visible = false;
                btnOk.Visible = false;
                FeesEntry1.Visible = false; // change to false
                OPCaseSheet1.Visible = true;
                OPCaseSheet1.LoadPatientDetails(visitID, 0);
            }
            
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisit);
            VisitType = lstPatientVisit[0].VisitType;
            List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
            new BillingEngine(base.ContextInfo).GetFeeType(OrgID, (VisitType == 0 ? "OP" : "IP"), out lstFeeTypeMaster);

            if (lstFeeTypeMaster.Count > 0)
            {
                FeesEntry1.LstFeeTypeMaster = lstFeeTypeMaster;
            }
           
        }
        string chkheaders = GetConfigValue("PrintCaseSheetWithHeader", OrgID);
        if (chkheaders == 'Y'.ToString())
        {
            chkheader.Style.Add("display", "block");
        }
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        try
        {
            //Commented By Ramki
            //Int64.TryParse(Convert.ToString(Session["LID"]), out createdBy);
            createdBy = LID;
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            feeType = Convert.ToString(Request.QueryString["ftype"]);
            others = Convert.ToString(Request.QueryString["oC"]);

            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, createdBy);

            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }


            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            //new BillingEngine(base.ContextInfo).GetBeforeAfterPaymentMode(visitID, out lstVisitPurpose);
            long FinalBillID = 0;
            decimal dAMt = 0;
            if (PaymentLogic == "After")
            {
                FeesEntry1.PatientVisitID = visitID;
                FeesEntry1.Consulting = true;
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                FeesEntry1.PatientID = patientID;
                FeesEntry1.SaveFeesDetails(out FinalBillID);
                dAMt = FeesEntry1.ZeroAmt;
            }
            else if (PaymentLogic == "Before" && others == "Y")
            {
                FeesEntry1.PatientVisitID = visitID;
                FeesEntry1.Consulting = true;
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                FeesEntry1.PatientID = patientID;
                FeesEntry1.SaveFeesDetails(out FinalBillID);
                dAMt = FeesEntry1.ZeroAmt;
            }
            else
            {

            }
            int referedCount = -1;
            int orderedCount = -1;

            returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Convert.ToString(Request.QueryString["gUID"]);
            }
            else
            {
                gUID = "";
            }
            string IsLab = GetConfigValue("SampleCollect", OrgID);
            if (IsLab == "N")
            {
                if (referedCount > 0)
                {
                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), visitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.BillID = FinalBillID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;

                    //Create task               
                    if (IsTrustedOrg == "N")
                    {
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }

                }
                if (orderedCount > 0)
                {
                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
                    foreach (var item in lstSampleDept1)
                    {
                        //if (item.Display == "N")
                        //{
                        InvestigationValues inValues = new InvestigationValues();
                        inValues.InvestigationID = item.InvestigationID;
                        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                        inValues.PackageID = item.PackageID;
                        inValues.PackageName = item.PackageName;
                        lstInvResult.Add(inValues);
                        //}
                    }
                    foreach (var item1 in lstSampleDept2)
                    {
                        InvestigationValues inValues1 = new InvestigationValues();
                        inValues1.InvestigationID = Convert.ToInt32(item1.InvestigationID);
                        lstInvResult.Add(inValues1);
                    }
                    if (lstInvResult.Count > 0)
                    {
                        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);
                    }
                    Response.Redirect(@"../Investigation/InvestigationCapture.aspx?vid=" + visitID + "&guid=" + gUID);
                }
                // If there is no investigation task, then check collect payment task.
                else if (orderedCount == 0)
                {
                    int status = 0;
                    returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(visitID, out status);
                    if (PaymentLogic == "After")
                    {
                        if (dAMt > 0)
                        {
                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.BillID = FinalBillID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create collection task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                        }
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = FinalBillID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                        //}
                    }
                    //else if (PaymentLogic == "Before")
                    //{
                    //    if (status == 0)
                    //    {
                    //        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                    //                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0,feeType, out dText, out urlVal);

                    //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    //        task.DispTextFiller = dText;
                    //        task.URLFiller = urlVal;
                    //        task.RoleID = RoleID;
                    //        task.OrgID = OrgID;
                    //        task.PatientVisitID = visitID;
                    //        task.PatientID = patientID;
                    //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //        //Create collection task
                    //        returnCode = taskBL.CreateTask(task, out createTaskID);
                    //    }
                    //}
                    else if (PaymentLogic == "Before" && others == "Y")
                    {
                        if (dAMt > 0)
                        {
                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);

                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create collection task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                        }

                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.BillID = FinalBillID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                        //}
                        //else
                        //{
                        //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                        //            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID);

                        //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        //    task.DispTextFiller = dText;
                        //    task.URLFiller = urlVal;
                        //    task.RoleID = RoleID;
                        //    task.OrgID = OrgID;
                        //    task.BillID = FinalBillID;
                        //    task.PatientVisitID = visitID;
                        //    task.PatientID = patientID;
                        //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        //    task.CreatedBy = LID;
                        //    //Create collection task
                        //    returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                    else if (PaymentLogic == "Before" && others == "N")
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                          lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.BillID = FinalBillID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                }

                ///Task For Pharmacy From PatientPrescription 
                List<Config> lstConfigDD = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                if (lstConfigDD.Count > 0)
                {
                    InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                }
                if (InvDrugData == "Y")
                {
                    int ptaskID = 0;
                    long PhysicianID = 0;
                    DrugDetails pAdvices = new DrugDetails();
                    PhysicianSchedule physician = new PhysicianSchedule();
                    new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                    pAdvices.PhysicianID = physician.PhysicianID;
                    PhysicianID = pAdvices.PhysicianID;
                    string PrescriptionNo = "0";
                    string pTaskStatus = "";

                   // returnCode = new Inventory_BL(base.ContextInfo).getPatientPrescriptiondrugCount(visitID, out drugCount, out ptaskID, PhysicianID, out PrescriptionNo, out pTaskStatus);
                    if (ptaskID > 0 && pTaskStatus == "PENDING")
                    {
                        if (drugCount > 0)
                        {
                          //  returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", ptaskID, PrescriptionNo, OrgID, patientID, visitID);
                        }
                    }
                    else
                    {
                        if (drugCount > 0)
                        {

                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), visitID, LID, patientID,
                                  lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                                  0, "", 0, "", 0, "PRM", out dText, out urlVal, FinalBillID, "", 0, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Pharmacy);


                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.LocationID = InvLocationID;
                            //task.TaskID = taskID;
                            //Create collection task
                            returnCode = taskBL.CreatePharmacyTask(task, out createTaskID, InvLocationID);

                            //returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, patientID, visitID);


                        }
                    }
                }
                Response.Redirect(@"../Physician/Home.aspx", true);
            }
            else
            {
                if (orderedCount > 0)
                {
                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.BillID = FinalBillID;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;

                    //Create task               
                    returnCode = taskBL.CreateTaskAllowDuplicate(task, out createTaskID);

                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.BillID = FinalBillID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    //Create collection task
                    returnCode = taskBL.CreateTask(task, out createTaskID);
                }
                if (referedCount > 0)
                {
                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), visitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.BillID = FinalBillID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;

                    //Create task               
                    if (IsTrustedOrg == "N")
                    {
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }

                }



                // If there is no investigation task, then check collect payment task.
                if (orderedCount == 0)
                {
                    int status = 0;
                    returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(visitID, out status);
                    if (PaymentLogic == "After")
                    {
                        if (dAMt > 0)
                        {
                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.BillID = FinalBillID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create collection task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                        }
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = FinalBillID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                        //}
                    }
                    //else if (PaymentLogic == "Before")
                    //{
                    //    if (status == 0)
                    //    {
                    //        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                    //                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0,feeType, out dText, out urlVal);

                    //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    //        task.DispTextFiller = dText;
                    //        task.URLFiller = urlVal;
                    //        task.RoleID = RoleID;
                    //        task.OrgID = OrgID;
                    //        task.PatientVisitID = visitID;
                    //        task.PatientID = patientID;
                    //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //        //Create collection task
                    //        returnCode = taskBL.CreateTask(task, out createTaskID);
                    //    }
                    //}
                    else if (PaymentLogic == "Before" && others == "Y")
                    {
                        if (dAMt > 0)
                        {
                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);

                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create collection task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                        }

                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.BillID = FinalBillID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                        //}
                        //else
                        //{
                        //    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                        //            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID);

                        //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        //    task.DispTextFiller = dText;
                        //    task.URLFiller = urlVal;
                        //    task.RoleID = RoleID;
                        //    task.OrgID = OrgID;
                        //    task.BillID = FinalBillID;
                        //    task.PatientVisitID = visitID;
                        //    task.PatientID = patientID;
                        //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        //    task.CreatedBy = LID;
                        //    //Create collection task
                        //    returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                    else if (PaymentLogic == "Before" && others == "N")
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                          lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.BillID = FinalBillID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                }

                ///Task For Pharmacy From PatientPrescription 
                List<Config> lstConfigDD = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                if (lstConfigDD.Count > 0)
                {
                    InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                }
                if (InvDrugData == "Y")
                {
                    int ptaskID = 0;
                    long PhysicianID = 0;
                    DrugDetails pAdvices = new DrugDetails();
                    PhysicianSchedule physician = new PhysicianSchedule();
                    new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                    pAdvices.PhysicianID = physician.PhysicianID;
                    PhysicianID = pAdvices.PhysicianID;
                    string PrescriptionNo = "0";
                    string pTaskStatus = "";

                    //returnCode = new Inventory_BL(base.ContextInfo).getPatientPrescriptiondrugCount(visitID, out drugCount, out ptaskID, PhysicianID, out PrescriptionNo, out pTaskStatus);
                    if (ptaskID > 0 && pTaskStatus == "PENDING")
                    {
                        if (drugCount > 0)
                        {
                           // returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", ptaskID, PrescriptionNo, OrgID, patientID, visitID);
                        }
                    }
                    else
                    {
                        if (drugCount > 0)
                        {

                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), visitID, LID, patientID,
                                  lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                                  0, "", 0, "", 0, "PRM", out dText, out urlVal, FinalBillID, "", 0, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Pharmacy);


                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.LocationID = InvLocationID;
                            //task.TaskID = taskID;
                            //Create collection task
                            returnCode = taskBL.CreatePharmacyTask(task, out createTaskID, InvLocationID);

                            //returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, patientID, visitID);


                        }
                    }
                }
                
                //Create Task Separate Collectt Payment
                List<Config> lstConfigValue = new List<Config>();
                string lsValue=string.Empty;
                new GateWay(base.ContextInfo).GetConfigDetails("COLLECTPAYMENT", OrgID, out lstConfigValue);
                if (lstConfigValue.Count > 0)
                {
                    lsValue = lstConfigValue[0].ConfigValue.Trim();
                }


                if (orderedCount > 0 && lsValue == "Y")
                {
                    int status = 0;
                    returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(visitID, out status);
                    if (PaymentLogic == "After")
                    {
                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.BillID = FinalBillID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create collection task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                       
                    }
                }


                Response.Redirect(@"../Physician/Home.aspx", true);
            }
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
            btnOk.Visible = true;
            btnOk.Enabled = true;

        }
    }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            string sQueryPath = Request.Url.PathAndQuery;
            if (sQueryPath.Contains("RedirectURL"))
            {
                sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL"));
            }
            sQueryPath = sQueryPath.Replace("&", "^~");
            sQueryPath = "&RedirectURL=" + sQueryPath;

            /*
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);*/
            if (Request.QueryString["vid"] != null)
                Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            if (Request.QueryString["tid"] != null)
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            if (Request.QueryString["id"] != null)
                Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            if (Request.QueryString["pid"] != null)
                Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            if (Request.QueryString["pvid"] != null)
                Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);

            List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
            {
                if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                else
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(previousVID, out lstPatientComplaintDetail);
            }
            else
            {
                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            }
            if (lstPatientComplaintDetail.Count > 1)
            {
                Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + patientID + "&tid=" + taskID + "&pvid=" + previousVID + "&id=" + complaintID + sQueryPath, true);
            }
            else if (lstPatientComplaintDetail.Count == 1)
            {
                if ((lstPatientComplaintDetail[0].ComplaintID != 0) && (lstPatientComplaintDetail[0].ComplaintID != -1))
                {
                    Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                }
                //else if (lstPatientComplaintDetail[0].ComplaintID == -1)
                //{
                else if (lstPatientComplaintDetail[0].ComplaintType == "QIC")
                {
                    Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "", true);
                }
                else if (lstPatientComplaintDetail[0].ComplaintID == 0)
                {
                    Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + visitID + "&tid=" + taskID + "" + sQueryPath, true);
                }
            }
            //if (lstPatientComplaintDetail.Count == 0)
            //{
            //    Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + visitID + "&pid=" + patientID + "&id=" + "-1" + "&pvid=" + visitID + "&tid=" + taskID + "", true);
            //}
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            //Commented By Ramki
            //Int64.TryParse(Convert.ToString(Session["LID"]), out createdBy);
            createdBy = LID;
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            feeType = Convert.ToString(Request.QueryString["ftype"]);
            others = Convert.ToString(Request.QueryString["oC"]);

            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, createdBy);

            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }


            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            //new BillingEngine(base.ContextInfo).GetBeforeAfterPaymentMode(visitID, out lstVisitPurpose);
            long FinalBillID = 0;
            if (PaymentLogic == "After")
            {
                FeesEntry1.PatientVisitID = visitID;
                FeesEntry1.Consulting = true;
                FeesEntry1.SaveFeesDetails(out FinalBillID);
            }
            else if (PaymentLogic == "Before" && others == "Y")
            {
                FeesEntry1.PatientVisitID = visitID;
                FeesEntry1.Consulting = true;
                FeesEntry1.SaveFeesDetails(out FinalBillID);
            }
            else
            {

            }
            int referedCount = -1;
            int orderedCount = -1;

            returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out orderedCount);

            if (orderedCount > 0)
            {
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientID,
                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.BillID = FinalBillID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task               
                returnCode = taskBL.CreateTask(task, out createTaskID);
            }
            if (referedCount > 0)
            {
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), visitID, 0, patientID,
                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.BillID = FinalBillID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task               
                returnCode = taskBL.CreateTask(task, out createTaskID);


            }

            // If there is no investigation task, then check collect payment task.
            if (orderedCount == 0)
            {
                int status = 0;
                returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(visitID, out status);
                if (PaymentLogic == "After")
                {
                    if (status == 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = FinalBillID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                }
                //else if (PaymentLogic == "Before")
                //{
                //    if (status == 0)
                //    {
                //        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                //                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0,feeType, out dText, out urlVal);

                //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                //        task.DispTextFiller = dText;
                //        task.URLFiller = urlVal;
                //        task.RoleID = RoleID;
                //        task.OrgID = OrgID;
                //        task.PatientVisitID = visitID;
                //        task.PatientID = patientID;
                //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //        //Create collection task
                //        returnCode = taskBL.CreateTask(task, out createTaskID);
                //    }
                //}
                else if (PaymentLogic == "Before" && others == "Y")
                {
                    if (status == 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");

                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = FinalBillID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                }
               
                else
                {
                    //Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), visitID, 0, patientID,
                    //        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal);

                    //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    //task.DispTextFiller = dText;
                    //task.URLFiller = urlVal;
                    //task.RoleID = RoleID;
                    //task.OrgID = OrgID;
                    //task.PatientVisitID = visitID;
                    //task.PatientID = patientID;
                    //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //task.CreatedBy = LID;
                    ////Create collection task
                    //returnCode = taskBL.CreateTask(task, out createTaskID);
                }


            }
            ///Task For Pharmacy From PatientPrescription 
            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            if (InvDrugData == "Y")
            {
                int ptaskID = 0;
                 long PhysicianID=0;
                 DrugDetails pAdvices = new DrugDetails();
                 PhysicianSchedule physician = new PhysicianSchedule();
                 new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                 pAdvices.PhysicianID = physician.PhysicianID;
                 PhysicianID = pAdvices.PhysicianID;
              
                string PrescriptionNo="";

                string pTaskStatus = "";

                //returnCode = new Inventory_BL(base.ContextInfo).getPatientPrescriptiondrugCount(visitID, out drugCount, out ptaskID, PhysicianID, out PrescriptionNo, out pTaskStatus);

                if
                (ptaskID > 0 && (pTaskStatus == "PENDING" || pTaskStatus == ""))
                {
                    if (drugCount > 0)
                    {

                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), visitID, LID, patientID,
                              lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                              0, "", 0, "", 0, "PRM", out dText, out urlVal, FinalBillID, "", 0, "");
                        task.TaskActionID = (IsCorporateOrg == "Y" ? Convert.ToInt32(TaskHelper.TaskAction.CorporatePharmacy) : Convert.ToInt32(TaskHelper.TaskAction.Pharmacy));




                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = FinalBillID;
                        task.PatientVisitID = visitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.LocationID = InvLocationID;
                        //task.TaskID = taskID;
                        ////Create collection task
                      
                        returnCode = taskBL.CreateTask(task, out createTaskID);

                        //returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, patientID, visitID);


                    }
                    else
                    {
                        if (drugCount > 0)
                        {

                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), visitID, LID, patientID,
                                  lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                                  0, "", 0, "", 0, "PRM", out dText, out urlVal, FinalBillID, "", 0, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Pharmacy);


                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.LocationID = InvLocationID;
                            //task.TaskID =taskID ;
                            //Create collection task
                            returnCode = taskBL.CreatePharmacyTask(task, out createTaskID, InvLocationID);


                        }
                    }
            }
            }

            Response.Redirect(@"../Physician/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
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
}
