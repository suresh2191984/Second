using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;   
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Globalization;
using System.Text;

public partial class Billing_InvestigationPayment : BasePage
{
    #region OLDINV
    //{
//    long patientVisitID = -1;
//    long patientID = -1;
//    long taskID = -1;
//    string PaymentLogic = string.Empty;
//    string ftype = string.Empty;
//    Hashtable dText = new Hashtable();
//    Hashtable urlVal = new Hashtable();
//    Tasks task = new Tasks();
//    protected void Page_Load(object sender, EventArgs e)
//    {
//        //btnSave.Attributes.Add("onClick", "return Amount()");
//        /* Commented for Checking Payment Status
//        //ftype = "CON";
//        //if (PaymentLogic == String.Empty)
//        //{
//        //    List<Config> lstConfig = new List<Config>();
//        //    new GateWay(base.ContextInfo).GetConfigDetails(ftype, OrgID, out lstConfig);
//        //    if (lstConfig.Count > 0)
//        //        PaymentLogic = lstConfig[0].ConfigValue.Trim();
//        //}

//        //if (PaymentLogic == "Before")
//        //{
//        //    FeesEntry1.LoadDBData = true;
//        //}
//        //else
//        //{
//        //    FeesEntry1.LoadDBData = true;
//        //}
//*/
//        FeesEntry1.LoadDBData = true;

//        if (!Page.IsPostBack)
//        {
//            btnSave.Enabled = true;
//            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

//            FeesEntry1.Investigation = true;
//            FeesEntry1.PatientVisitID = patientVisitID;
//            FeesEntry1.loadData();
//        }
//    }


//    protected void btnSave_Click(object sender, EventArgs e)
//    {
//        btnSave.Enabled = false;
//        try
//        {
//            long returnCode = -1;
//            long createTaskID = -1;
//            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
//            Int64.TryParse(Request.QueryString["pid"], out patientID);
//            Int64.TryParse(Request.QueryString["tid"], out taskID);

//            FeesEntry1.Investigation = true;
//            FeesEntry1.PatientVisitID = patientVisitID;
//            long FinalBillID = 0;
//            FeesEntry1.SaveFeesDetails(out FinalBillID);

//            // Update patient investigation status
//            List<SaveBillingDetails> lstSaveBillingDetail = new List<SaveBillingDetails>();
//            List<PatientInvestigation> lstUpdatePatientInvStatus = new List<PatientInvestigation>();
//            PatientInvestigation patientInvestigation;
//            FeesEntry1.GetSaveFeeDetail(out lstSaveBillingDetail);
//            for (int i = 0; i < lstSaveBillingDetail.Count; i++)
//            {
//                patientInvestigation = new PatientInvestigation();
//                patientInvestigation.PatientVisitID = patientVisitID;
//                if (lstSaveBillingDetail[i].IsGroup == "I")
//                {
//                    patientInvestigation.InvestigationID = Convert.ToInt32(lstSaveBillingDetail[i].ID);
//                }
//                else
//                {
//                    patientInvestigation.GroupID = Convert.ToInt32(lstSaveBillingDetail[i].ID);
//                }
//                patientInvestigation.CreatedBy = 0;
//                patientInvestigation.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
//                patientInvestigation.Status = "Paid";
//                lstUpdatePatientInvStatus.Add(patientInvestigation);
//            }
//            int count = -1;
//            returnCode = new Investigation_BL(base.ContextInfo).UpdateSampleCollected(lstUpdatePatientInvStatus, 0, out count);

//            //Update InvestigationPayment tasks
//            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);

//            //Create task for Collect investigation payment
//            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
//            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
//            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0,
//                patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, FinalBillID);
//            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
//            task.DispTextFiller = dText;
//            task.URLFiller = urlVal;
//            task.RoleID = RoleID;
//            task.OrgID = OrgID;
//            task.BillID = FinalBillID;
//            task.PatientVisitID = patientVisitID;
//            task.PatientID = patientID;
//            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
//            //Create task               
//            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

//            string redirectURL = @"..\Billing\Billing.aspx?vid=" + patientVisitID + "&tid=" + createTaskID + "&pid=" + patientID + "&ptid=0&ftype=INV&bid=" + FinalBillID + "";
//            Response.Redirect(redirectURL, true);
//        }
//        catch (System.Threading.ThreadAbortException tae)
//        {
//            string thread = tae.ToString();
//        }

            
//    }
    //}
    #endregion

     
    Investigation_BL invbl;
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL PhysicianBL ;
    List<Organization> lstorgs = new List<Organization>();
    List<BillingFeeDetails> lstInvestigationFeesDetails = new List<BillingFeeDetails>();
    Referrals_BL objReferrals_BL ;
    PatientVisit_BL patientBL ;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    long patientVisitID = 0;
    long patientID = 0;
    long returnCode = -1;
    long taskID = -1;
    long Rid = 0;
    string labno = string.Empty;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL ;
    string Url = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        patientBL = new PatientVisit_BL(base.ContextInfo);
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);

        try
        {
            btnSave.Enabled = true;
            if (Request.QueryString["Show"] != null)
            {
                if (Request.QueryString["Show"] != "Y")
                {
                    btnBack.Visible = true;
                }
            }
            else
            {
                btnBack.Visible = false;
            }

            if (!IsPostBack)
            {
                ViewState["Url"] = Request.UrlReferrer.ToString();
                

                hdnOrg.Value = OrgID.ToString();
                if (Request.QueryString["Rid"] != null)
                {
                    Int64.TryParse(Request.QueryString["Rid"], out Rid);
                    Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                    GetOrgReferralsInvestigations(Rid, patientVisitID);
                    returnCode = new Referrals_BL(base.ContextInfo).UpdateReferralDetails(Rid, LID, patientVisitID);

                }
                else
                {
                    LoadInvestigations();
                }
                
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

                List<PatientVisitDetails> lstPatientVisitDetail = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetail);
                if (lstPatientVisitDetail.Count > 0)
                {
                    List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
                    new BillingEngine(base.ContextInfo).GetFeeType(OrgID, (lstPatientVisitDetail[0].VisitType == 0 ? "OP" : "IP"), out lstFeeTypeMaster);

                    if (lstFeeTypeMaster.Count > 0)
                    {
                        ReferralsINV1.LstFeeTypeMaster = lstFeeTypeMaster;
                    }
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }

    }

    private void SaveInvestigations()
    {

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
        lstPatientInvestHL = ReferralsINV1.GetPaidPatientInvestigation(patientVisitID);
        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();

        
        // HL Ends
        long result = 0;
        int pOrderedInvCnt = 0;
        string gUID = Guid.NewGuid().ToString();

        string labno = string.Empty;
        //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
        returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(lstPatientInvestHL, OrgID, out pOrderedInvCnt, "Paid", gUID, labno);
        if (result == 0)
        {
            int count = -1;

            returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvSampleCollected(lstPatientInvestHL, 0, out count);
            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);


           

            if (pOrderedInvCnt > 0)
            {
                //Create task for Collect investigation payment
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

                patientID = lstPatientVisitDetails[0].PatientID;


                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0,
                    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,gUID);
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //create task
                returnCode = taskBL.CreateTask(task, out taskID);
                hdnTaskId.Value = taskID.ToString();
            }
        }
    }
    
    private void GetOrgReferralsInvestigations(long Rid,long patientVisitID)
    {
        try
        {
            ReferralsINV1.type = "Ref";
            returnCode=ReferralsINV1.LoadReferralsInvestigations(Rid, patientVisitID);

            if (returnCode==-1)
            {
                btnSave.Visible = false;
            }
            else
            {
                if (ReferralsINV1.strPaid == "paid")
                {
                    divPaid.Visible=true;
                    //lblOrg.Text = "test";
                }
                SaveInvestigations();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
    }

    private void LoadInvestigations()
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            long returncode = -1;
            returncode=ReferralsINV1.LoadInvestigations(patientVisitID, patientID);

            if (returncode == -1)
            {
                txtStatus.Visible = true;
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                if (Request.QueryString["Rid"] != null)
                {
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Int64.Parse(hdnTaskId.Value), TaskHelper.TaskStatus.Completed, UID);
                }
                else
                {
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        List<SaveBillingDetails> lstSaveBillingDetailHL = new List<SaveBillingDetails>();
        List<OrderedInvestigations> lstUpdatePatientInvStatusHL = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstReferralsInvestigation = new List<OrderedInvestigations>();
        List<Referral> lstReferrals = new List<Referral>();
        try
        {
            long returnCode = -1;
            long createTaskID = -1;
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            labno = Request.QueryString["LabNo"];
            long FinalBillID = -1;
            string gUID = string.Empty;
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();

            }

            #region Referrals
            if (Request.QueryString["Rid"] != null)
            {
                ReferralsINV1.type = "Referral";
                Int64.TryParse(Request.QueryString["Rid"], out Rid);
                lstUpdatePatientInvStatusHL = ReferralsINV1.GetPaidPatientInvestigation(patientVisitID);
                returnCode = new Referrals_BL(base.ContextInfo).UpdateReferralDetails(Rid, LID, patientVisitID);
            }
            else
            {
                lstUpdatePatientInvStatusHL = ReferralsINV1.GetPaidPatientInvestigation(patientVisitID);
                lstReferrals = ReferralsINV1.GetReferralsInvestigation();
            }
            #endregion
            //Check Investigation To Referred to Org
            if (lstUpdatePatientInvStatusHL.Count > 0)
            {
                returnCode = objReferrals_BL.CheckReferralsInvestigation(lstUpdatePatientInvStatusHL, out lstReferralsInvestigation);

                if (lstReferralsInvestigation.Count == 0)
                {
                    # region Billing , Referral AND Task
                    if (lstUpdatePatientInvStatusHL.Count > 0)
                    {
                        FinalBillID = ReferralsINV1.SaveFeesDetails(patientVisitID,out labno);
                        if (FinalBillID != -1)
                        {
                            // Update patient investigation status
                            if (lstReferrals.Count > 0)
                            {
                                returnCode = objReferrals_BL.SaveReferrals(lstReferrals, lstUpdatePatientInvStatusHL, LID);
                            }
                            int count = -1;
                            //Update  Paid InvestigationPayment AND Update Ordered Investigation to Refered Investigation 
                            returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvSampleCollected(lstUpdatePatientInvStatusHL, 0, out count);

                            //Update InvestigationPayment tasks
                            if (Request.QueryString["Rid"] != null)
                            {
                                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Int64.Parse(hdnTaskId.Value), TaskHelper.TaskStatus.Completed, UID);
                            }
                            else
                            {
                                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                            }

                            //Create task for Collect investigation payment
                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

                            List<Config> lstConfigValue = new List<Config>();
                            string lstValue=string.Empty;
                            new GateWay(base.ContextInfo).GetConfigDetails("COLLECTPAYMENT", OrgID, out lstConfigValue);
                            if (lstConfigValue.Count > 0)
                            {
                                lstValue = lstConfigValue[0].ConfigValue.Trim();
                            }

                            if (lstValue == "Y")
                            {
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationCollectPayment), patientVisitID, 0,
                                         patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationCollectPayment);
                            }
                            else
                            {
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0,
                                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, gUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                            }
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.BillID = FinalBillID;
                            task.PatientVisitID = patientVisitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.RefernceID = labno.ToString();
                            //Create task

                            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                            string redirectURL = @"..\Billing\Billing.aspx?vid=" + patientVisitID + "&tid=" + createTaskID + "&pid=" + patientID + "&LabNO=" + labno + "&ptid=0&ftype=INV&bid=" + FinalBillID + "&gUID=" + gUID;
                            Response.Redirect(redirectURL, true);
                            //Server.Transfer(redirectURL, true);

                        }
                        else
                        {
                            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                        }
                    }
                    else
                    {
                        if (Request.QueryString["Rid"] != null)
                        {
                            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Int64.Parse(hdnTaskId.Value), TaskHelper.TaskStatus.Completed, UID);

                            //List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                            //returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitID, 0,
                            //patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber);
                            //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                            //task.DispTextFiller = dText;
                            //task.URLFiller = urlVal;
                            //task.RoleID = RoleID;
                            //task.OrgID = OrgID;
                            //task.PatientVisitID = patientVisitID;
                            //task.PatientID = patientID;
                            //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            //task.CreatedBy = LID;
                            ////Create task    
                            //returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

                            List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                            List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                            List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                            Tasks task = new Tasks();
                            Hashtable dText = new Hashtable();
                            Hashtable urlVal = new Hashtable();
                            new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
                            foreach (var item in lstSampleDept1)
                            {
                                if (item.Display == "Y")
                                {
                                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                                    //long createTaskID = -1;
                                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                                    string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                                    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                                 patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                                 patientName, "", 0, "", 0, "", 0, "INV"
                                                 , out dText, out urlVal, 0, "", 0, gUID);
                                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                    task.DispTextFiller = dText;
                                    task.URLFiller = urlVal;
                                    task.RoleID = RoleID;
                                    task.OrgID = OrgID;
                                    task.PatientVisitID = patientVisitID;
                                    task.PatientID = patientID;
                                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                    task.CreatedBy = LID;
                                    task.RefernceID = labno.ToString();
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

                            returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);


                            Response.Redirect("../Reception/Home.aspx", true);
                        }
                        else
                        {
                            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                            Response.Redirect("../Reception/Home.aspx", true);

                        }

                    }
                    #endregion
                }
                else
                {
                    btnSave.Enabled = true;
                    # region Referred to Org
                    string tempINV = "The following Investigation are not performed in the corresponding Organizations </br></br> " +
                        "<table border='1' cellpadding='2' cellspacing='2' width='70%' style='margin-left:30px'><tr><td>";
                    returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
                    int i = 1;
                    ReferralsINV1.ReferralsInvestigation(lstReferralsInvestigation);

                    foreach (OrderedInvestigations item in lstReferralsInvestigation)
                    {
                        List<OrganizationAddress> TempLocation = new List<OrganizationAddress>();
                        TempLocation = lstLocation;
                        OrganizationAddress obj = TempLocation.Find(p => p.Comments == item.ReferedToLocation.ToString() + "~" + item.ReferedToOrgID.ToString());
                        tempINV += i.ToString() + "</td><td>" + item.Name + "</td><td>" + obj.Location + "</td></tr><tr><td>";
                        i++;
                    }
                    lblReferrals.Text = tempINV + "</td></tr></table></br>";
                    #endregion
                }
            }
            else
            {
                txttaskPending.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }


    }



    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            //Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            //Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            //string redirectURL = @"..\Investigation\InvestigationProfile.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID;
            //Response.Redirect(redirectURL, true);
            string str = Request.RawUrl;
            string u = Request.UrlReferrer.ToString();
            string u1 = Request.ServerVariables["HTTP_REFERER"].ToString();
            Url = ViewState["Url"].ToString() + "&EditMode=Y&EtskID=" + taskID;
            string redirectURL = Request.ApplicationPath + Request.Url.PathAndQuery.ToString();
            Response.Redirect(Url, true);
        }
        catch (Exception ex)
        {

        }
            
    }
}
