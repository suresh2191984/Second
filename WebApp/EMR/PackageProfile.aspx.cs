using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;
using Attune.Podium.BillingEngine;


public partial class EMR_PackageProfile : BasePage
{
    long visitID = -1;
    long patientID = 0;
    long taskID = 0;
    long returnCode = -1;
    string PaymentLogic = string.Empty;
    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
    List<InvGroupMaster> lstGroups = new List<InvGroupMaster>();
    List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<InvPackageMapping> lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstCollectedPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
    List<ProcedureMaster> lstCollectedProcedures = new List<ProcedureMaster>();
    List<InvPackageMapping> lstDeletedPackageMapping = new List<InvPackageMapping>();
    List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();

    List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
       // Int64.TryParse(Request.QueryString["tid"], out taskID);
        ((HiddenField)PackageProfileControl.FindControl("hdnAddSevices")).Value = "NO";
        List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
        List<OrderedInvestigations> oInvestigations  = new List<OrderedInvestigations>();
        new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, visitID, out lstOrderedInves, out oInvestigations);
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        int purpID = 1;
        long phyID = -1;
        int otherID = -1;
        long referOrgID = -1;
        int orgAddressID = -1;
        string feeType = String.Empty;
        string otherName = String.Empty;
        string physicianName = String.Empty;
        string referrerName = string.Empty;
        long taskID = -1;
        long ptaskID = -1;
        string gUID = string.Empty;


        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        int specialityID = -1;


        returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
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
                objInvest.ID = objPKG.AttGroupID;
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
             gUID = Guid.NewGuid().ToString();
            //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
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
                                              patientID, patient.TitleName + " " + patient.Name, 
                                              physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, 
                                              patient.PatientNumber, patient.TokenNumber,""); // Other Id meand Procedure ID

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
                                                  patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber,""); // Other Id meand Procedure ID
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

            //Tasks task1 = new Tasks();
            //new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
            //returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), visitID, 0,
            //    patientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber); // Other Id meand Procedure ID);
            //task1.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            //task1.DispTextFiller = dText;
            //task1.URLFiller = urlVal;
            //task1.RoleID = RoleID;
            //task1.OrgID = OrgID;
            //task1.PatientVisitID = visitID;
            //task1.PatientID = patientID;
            //task1.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //task1.CreatedBy = LID;
            ////Create task               
            //returnCode = taskBL.CreateTask(task1, out ptaskID);

            //if (ptaskID !=-1)
            //{

            #region Create Task for Samples
            //List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
            //List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
            //List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
            // new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID,gUID, out lstSampleDept1, out lstSampleDept2);

            //var lst = from lstSample in lstSampleDept1
            //          group lstSample by lstSample.Display


            //if (lstSampleDept2.Count > 0)
            //{
            //    Int64.TryParse(Request.QueryString["pid"], out patientID);
            //    long createTaskID = -1;
            //    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
            //                 visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
            //                 lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
            //                 , out dText, out urlVal, 0, 0, 0);
            //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            //    task.DispTextFiller = dText;
            //    task.URLFiller = urlVal;
            //    task.RoleID = RoleID;
            //    task.OrgID = OrgID;
            //    task.PatientVisitID = visitID;
            //    task.PatientID = patientID;
            //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //    task.CreatedBy = LID;
            //    //Create task               
            //    returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

            // }
            //foreach (var item in lstSampleDept1)
            //{
            //    if (item.Display == "Y")
            //    {
            //        Int64.TryParse(Request.QueryString["pid"], out patientID);
            //        long createTaskID = -1;
            //        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
            //                     visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
            //                     lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
            //                     , out dText, out urlVal, 0, 0, 0);
            //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            //        task.DispTextFiller = dText;
            //        task.URLFiller = urlVal;
            //        task.RoleID = RoleID;
            //        task.OrgID = OrgID;
            //        task.PatientVisitID = visitID;
            //        task.PatientID = patientID;
            //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //        task.CreatedBy = LID;
            //        //Create task               
            //        returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
            //    }
            //    else if (item.Display == "N")
            //    {
            //        InvestigationValues inValues = new InvestigationValues();
            //        inValues.InvestigationID = item.InvestigationID;
            //        lstInvResult.Add(inValues);
            //    }
            //}

            //returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);

            #endregion

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
                if (PaymentLogic == "Before")
                {
                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);


                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "Y")
                        {
                            Int64.TryParse(Request.QueryString["pid"], out patientID);
                            long createTaskID = -1;
                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                            string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;

                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                         visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                         patientName, "", 0, "", 0, "", 0, "INV"
                                         , out dText, out urlVal, 0, "", 0, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create task               
                            returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                            break;

                        }
                    }
                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "Y")
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

                    Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + otherID + "&show=Y", true);
                }
                else
                {
                    //Venkat added here 
                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);


                    foreach (var item in lstSampleDept1)
                    {
                        //if (item.Display == "Y")
                        //{
                        //    Int64.TryParse(Request.QueryString["pid"], out patientID);
                        //    long createTaskID = -1;
                        //    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                        //    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                        //    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                        //                 visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                        //                 lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                        //                 , out dText, out urlVal, 0, "", 0, gUID);
                        //    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                        //    task.DispTextFiller = dText;
                        //    task.URLFiller = urlVal;
                        //    task.RoleID = RoleID;
                        //    task.OrgID = OrgID;
                        //    task.PatientVisitID = visitID;
                        //    task.PatientID = patientID;
                        //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        //    task.CreatedBy = LID;
                        //    //Create task               
                        //    returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

                        //}
                        //else if (item.Display == "N")
                        //{
                        InvestigationValues inValues = new InvestigationValues();
                        inValues.InvestigationID = item.InvestigationID;
                        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                        inValues.PackageID = item.PackageID;
                        inValues.PackageName = item.PackageName;

                        lstInvResult.Add(inValues);
                        //}
                    }

                    returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);

                    //}

                    Navigation navigation = new Navigation();
                    Role role = new Role();
                    role.RoleID = RoleID;
                    List<Role> userRoles = new List<Role>();
                    userRoles.Add(role);
                    string relPagePath = string.Empty;
                    returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                    if (returnCode == 0)
                    {
                        Response.Redirect(Request.ApplicationPath + relPagePath, true);
                    }
                }
            }
            catch (System.Threading.ThreadAbortException tex)
            {
                string te = tex.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
            }
            //}
        }
        else
        {
            PackageProfileControl.LoadPackageData();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "count", "javascript:alert('Select Atleast one package and then Click save');", true);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
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
    protected void btnServiceFinish_Click(object sender, EventArgs e)
    {
       
    }

    public void getRefPhyandID(out string RefPhysicianName, out int RefphysicianID, out string RefspecialityName,
                                out int RefSpecialtiyID, out int pClientID,
                                out int CorporateID, out List<PatientDueChart> lstPatientConsultation)
    {
        RefPhysicianName = "";
        RefphysicianID = 0;

        int otherRefID = 0, otherSpecID = 0;

        DropDownList ddlReferPhysician = (DropDownList)PreviousPage.FindControl("Rfrdoctor").FindControl("ddlConsultingName");
        RefPhysicianName = ddlReferPhysician.SelectedItem.Text;
        Int32.TryParse(ddlReferPhysician.SelectedItem.Value, out otherRefID);
        RefphysicianID = otherRefID;
        DropDownList ddlReferSpeciality = (DropDownList)PreviousPage.FindControl("Rfrdoctor").FindControl("ddlSpeciality");
        RefspecialityName = ddlReferSpeciality.SelectedItem.Text;
        Int32.TryParse(ddlReferSpeciality.SelectedItem.Value, out otherSpecID);
        RefSpecialtiyID = otherSpecID;

        CorporateID = 0;
        Int32.TryParse(((DropDownList)PreviousPage.FindControl("ddlCorporate")).SelectedValue, out CorporateID);
        pClientID = 0;
        Int32.TryParse(((DropDownList)PreviousPage.FindControl("ddlClients")).SelectedValue, out pClientID);

        lstPatientConsultation = new List<PatientDueChart>();
        lstPatientConsultation = GetConsNProDetails();

    }
    public List<PatientDueChart> GetConsNProDetails()//string feeType)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        //long tempAdd=0;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();

        PatientDueChart objBilling;
        if (((HiddenField)PreviousPage.FindControl("hdfBillType")).Value != null)
            prescription = ((HiddenField)PreviousPage.FindControl("hdfBillType")).Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {
            objBilling = new PatientDueChart();
            if (row.Trim().Length != 0)
            {
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    switch (colName)
                    {
                        case "FeeID":
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;
                        case "OtherID":
                            objBilling.DetailsID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            objBilling.Description = colValue;
                            break;
                        case "Amount":
                            objBilling.Amount = Convert.ToDecimal(colValue);
                            break;
                        case "Quantity":
                            objBilling.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            objBilling.FeeType = colValue;
                            //if (colValue == feeType)
                            //{
                            //    tempAdd = 0;
                            //}
                            //else
                            //{
                            //    tempAdd = 1;
                            //}
                            break;
                    };
                }
                //if (tempAdd == 0)
                //{
                lstPatientDueChart.Add(objBilling);
                //}
            }
        }
        return lstPatientDueChart;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {

    }
}
