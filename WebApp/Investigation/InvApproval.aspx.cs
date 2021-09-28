using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.IO;
using ReportingService;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using Attune.Podium.BillingEngine;
using Attune.Podium.PerformingNextAction;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Threading;

public partial class Investigation_InvApproval : BasePage
{

    public Investigation_InvApproval() 
        : base("Investigation_InvApproval_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long vid = 0;
    string gUID = string.Empty;
    string InvIDs = "";
    long taskID = -1;
    long DeptID = -1;
    string IsTrustedDetails = string.Empty;
    string status = string.Empty;
    Investigation_BL InvestigationBL;
    List<InvestigationStatus> lstStatus;
    string chkStatus = string.Empty;
    //bool isValidate = false;
    //bool isSecondOpinion = false;
    //bool isReceivedOpinion = false;
    string chktempStatus = string.Empty;
    string RId = string.Empty;
    bool isCompleted = false;
    List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();
    List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
    List<PatientVisit> lstVisit = new List<PatientVisit>();
    Patient_BL objPatientBL;
    string autoComments = string.Empty;
    int PageSize = 1;
    int totalRows = 0;
    int totalpage = 0;
    int RowNo = 0;
    int totrowno = 0;
    string redirectURL = string.Empty;
    string strStatus=string.Empty;
    int ClientID = 0;
    #region "Common Resource Property"
    #endregion

    #region "Initial"

    
    protected void Page_Load(object sender, EventArgs e)
        {
        try
        {            
            //LoadRangeColor();
            if (Request.QueryString["RNo"] != null)
            {
                RId = Request.QueryString["RNo"].ToString();
            }
            if (Request.QueryString["POrgID"] != null)
            {
                int orgid = 0;
                Int32.TryParse(Request.QueryString["POrgID"].ToString(), out orgid);
                hdnOrgID.Value = orgid.ToString();
            }
            else
            {
                hdnOrgID.Value = Convert.ToString(OrgID);
            }
            hdnRoleID.Value = RoleID.ToString();
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
                hdnVID.Value = vid.ToString();
                Image1.Attributes.Add("onclick", "fnGetPreviousReport();return false;");
            }
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
                hdnGuid.Value = Request.QueryString["gUID"].ToString();
            }
            //if (vid != 0)
            //{
            //    vid = Convert.ToInt64(hdnVID.Value);
            //}
            //hdnVID.Value = vid.ToString();


            if (Session["DeptID"] != null && Session["DeptID"].ToString() != "")
            {
                DeptID = Convert.ToInt64(Session["DeptID"].ToString());
            }
            else if (Request.QueryString["DeptID"] != null)
            {
                Int64.TryParse(Request.QueryString["deptId"], out DeptID);
            }

            if (Convert.ToInt32(hdnOrgID.Value) != OrgID)
            {
                IsTrustedDetails = "Y";
            }
            else
            {
                IsTrustedDetails = "N";
            }
            status = "Approve";


            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                tbl.isTaskAlreadyPicked(taskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID);
            }
            if (Request.QueryString["RowIndex"] != null)
            {

                Int32.TryParse(Request.QueryString["RowIndex"], out RowNo);
            }
            if (Request.QueryString["otRows"] != null)
            {

                Int32.TryParse(Request.QueryString["otRows"], out totrowno);
            }
            if (!IsPostBack)
            {
                InvestigationBL = new Investigation_BL(base.ContextInfo);
                lstStatus = new List<InvestigationStatus>();
                //single db call
                InvestigationBL.GetStatusForApproval(gUID, vid, OrgID, status, taskID, out lstStatus, out lstInvReasonMaster, out lstReferenceRangeType, out lstVisit);
                //InvestigationBL.GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);

                loadStatus(lstStatus);
                loadReason(lstInvReasonMaster);
                LoadRangeColor(lstReferenceRangeType);

                //objPatientBL = new Patient_BL(base.ContextInfo);
                //objPatientBL.GetLabVisitDetails(vid, Convert.ToInt32(hdnOrgID.Value), out lstVisit);
                if (lstVisit.Count > 0)
                {
                    hdnPatientGender.Value = lstVisit[0].Sex.ToString();
                    hdnpagearraw.Value = lstVisit[0].PatientAge.ToString();
                }

                //------------- Config for AutoMedicalComments-------//

                autoComments = GetConfigValues("AutoMedicalComments", OrgID);

                if (autoComments != "")
                {
                    hdnAutoMedicalComments.Value = autoComments;
                }
                //---------- Ends----------//

                //------------- Config for EditComputationIsNotNeeded-------//
                string isEditComputationIsNotNeeded = GetConfigValues("EditComputationIsNotNeeded", OrgID);
                if (!string.IsNullOrEmpty(isEditComputationIsNotNeeded))
                {
                    hdnEditComputation.Value = isEditComputationIsNotNeeded;
                }
                //---------- Ends----------//

                acedivupMedRem.ContextKey = OrgID.ToString();
                acedivupFishPatternAutoComments.ContextKey = OrgID.ToString();
                
                //hdnPatternId.Value = TaskHelper.Pattern;
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetpatientInvestigationForVisit", "fnGetpatientInvestigationForVisit();", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetInvestigatonResultsCapture", "fnGetInvestigatonResultsCapture('" + vid + "','" + OrgID + "','" + RoleID + "','" + gUID + "','" + DeptID + "','" + InvIDs + "','" + ILocationID + "','" + taskID + "','" + IsTrustedDetails + "','" + status + "','" + LID + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvApproval on page_load", ex);
        }
    }

   

    public void LoadRangeColor(List<ReferenceRangeType> lstReferenceRangeType)
    {
        try
        {
            long returnCode;
            //List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            //returnCode = new Investigation_BL().getReferencerangetype(OrgID, LanguageCode, out lstReferenceRangeType);
            if (lstReferenceRangeType.Count > 0)
            {
                txtAuto.Attributes.Add("style", "background-color:" + lstReferenceRangeType[1].Color + ";");
                txtPanic.Attributes.Add("style", "background-color:" + lstReferenceRangeType[2].Color + ";");
                txtReference.Attributes.Add("style", "background-color:white;");
                txtLower.Attributes.Add("style", "background-color:" + lstReferenceRangeType[3].Color + ";");
                txtHigher.Attributes.Add("style", "background-color:" + lstReferenceRangeType[4].Color + ";");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvApproval on Load RangeColor", ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            TaskOpen();
            Response.Redirect("~/Phlebotomist/Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            long returnCode = -1;
            int returnStatus = -1;
            long pSCMID = -1;
            int deptID = 0;
            //List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
            List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
            List<PatientInvestigation> lstFinalReflexPatientinvestigation = new List<PatientInvestigation>();
            Investigation_BL objInvBL = new Investigation_BL(base.ContextInfo);
            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
            List<PatientInvestigation> lstPatientInvestigation = serializer1.Deserialize<List<PatientInvestigation>>(hdnLstPatientInvestigation.Value);
            List<InvestigationValues> LstOfBio1 = serializer1.Deserialize<List<InvestigationValues>>(hdnLstInvestigationValues.Value);
            List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
            List<long> lstSelectedOpinionUser = new List<long>();
            List<PatientInvestigation> lstGrpRem = new List<PatientInvestigation>();
            //lstGrpRem = serializer1.Deserialize<List<PatientInvestigation>>(hdnLstGrpRem.Value);
            if (hdnLstGrpRem.Value != "")
            {
                lstGrpRem = serializer1.Deserialize<List<PatientInvestigation>>(hdnLstGrpRem.Value);
            }           
        lstPatientInv = lstPatientInvestigation.FindAll(o => o.InvestigationID != 0);        

        string AllowAutoApproveTask = string.Empty;
        AllowAutoApproveTask = "No";
        int PendingCount = 0;
        string ConReferenceRange = string.Empty;
        string[] ConvReferenceRange;      
       

        foreach (var O in lstPatientInv)
        {
            O.PatientVisitID = vid;
            O.OrgID = OrgID;
            O.UID = gUID;
            O.LoginID = LID;
            ConReferenceRange = O.ConvReferenceRange;
                try
                {
                    if (string.IsNullOrEmpty(ConReferenceRange) && O.ReferenceRange.Contains('-') && O.CONV_Factor != null && O.CONVFactorDecimalPt != null)
            {
                ConvReferenceRange = O.ReferenceRange.Split('-');
                if (O.CONV_Factor > 0)
                {
                    if (ConvReferenceRange != null)
                    {
                        ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[0]) * O.CONV_Factor), O.CONVFactorDecimalPt));
                    }
                    if (ConvReferenceRange.Count() > 0)
                    {
                        ConReferenceRange += "-" + Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[1]) * O.CONV_Factor), O.CONVFactorDecimalPt));
                    }
                }
            }
                    else if (!string.IsNullOrEmpty(ConReferenceRange) && O.CONV_Factor != null && O.CONVFactorDecimalPt != null)
            {
                string[] strArray = { "<=", "<", ">=", ">", "=" };
                if (!string.IsNullOrEmpty(O.ReferenceRange))
                {
                    ConvReferenceRange = O.ReferenceRange.ToString().Split(strArray, StringSplitOptions.None);

                    string RefRangeSymbol = string.Empty;
                    foreach (string ObjStr in strArray)
                    {
                        if ((O.ReferenceRange.Contains(ObjStr) == true))
                        {
                            RefRangeSymbol = ObjStr;
                            break;
                        }
                    }
                    if (O.CONV_Factor > 0)
                    {
                        if (ConvReferenceRange != null)
                        {
                            ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[1]) * O.CONV_Factor), O.CONVFactorDecimalPt));

                            if (ConReferenceRange != "0")
                            {
                                ConReferenceRange = RefRangeSymbol + " " + ConReferenceRange;
                            }
                        }
                    }
                }
            }
                }
                catch (Exception ex1)
                {

                }

            O.ConvReferenceRange = ConReferenceRange;

            if ((O.Status == InvStatus.Completed) || (O.Status == InvStatus.Approved))
            {
                chkStatus = InvStatus.Completed;
            }
                if ((O.Status == InvStatus.Completed))
                {
                    chktempStatus = InvStatus.Completed;
                }
                O.ValidatedBy = 0;
            if (O.Status == InvStatus.Approved || O.Status == InvStatus.SecondOpinion)
            {
                O.ApprovedBy = LID;
                    O.AuthorizedBy = 0;
            }
            else
            {
                O.ApprovedBy = 0;
                O.AuthorizedBy = 0;
            }

                //if ((O.Status == InvStatus.Completed || O.Status == InvStatus.Validate) && (O.IsAbnormal == "N" || O.IsAbnormal == "") && O.AutoApproveLoginID > 0 && O.IsAutoAuthorize == "Y")
                //{
                //    O.Status = "Approve";
                //    O.IsAutoAuthorize = "Y";
                //    O.ApprovedBy = O.AutoApproveLoginID;
                //}
                //else if (O.Status != "Validate" || O.IsAbnormal == "A" || O.IsAbnormal == "L" || O.IsAbnormal == "P")//|| O.AutoApproveLoginID != LID)
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}
                //else if (O.Status == "Validate")
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}                
        }

        foreach (var p in LstOfBio1)
        {
            p.PatientVisitID = vid;
            p.Orgid = OrgID;
            p.UID = gUID;
            p.CreatedBy = LID;

            string Str = Convert.ToString(p.Value);
            double Num;
                try
                {
                    bool isNum = double.TryParse(Str, out Num);
            if (isNum)
            {
                if (p.Value != "Infinity")
                {
                    p.ConvValue = Convert.ToString(Math.Round((Convert.ToDecimal(p.Value) * p.CONV_Factor), p.CONVFactorDecimalPt));
                }
            }
            else
            {
                p.ConvValue = "0";
            }
			 }
                catch
                {
                    p.ConvValue = "0";
                }
        }

        LstOfBio.Add(LstOfBio1);

            //Patinvestasks = lstPatientInv;

            //returnCode = objInvBL.SaveGroupComments(lstGrpRem, gUID);
            if (lstGrpRem.Count > 0)
            {
                returnCode = objInvBL.SaveGroupComments(lstGrpRem, gUID);
            }

        string isFromDevice = "N";
        //returnCode = saveResults.SaveInvestigationResults(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, Convert.ToInt32(hdnOrgID.Value), deptID, LID, gUID, PageContextDetails, out returnStatus, isFromDevice);
        returnCode = objInvBL.SaveInvResults(pSCMID, LstOfBio, lstPatientInv, lPFiles, vid, Convert.ToInt32(hdnOrgID.Value), deptID, LID, gUID, PageContextDetails, out returnStatus, isFromDevice, lstFinalReflexPatientinvestigation);
            int cont = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
            if (cont > 0)
            {
                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.ID = Convert.ToInt64(ILocationID);
                PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PatientVisitID = vid;
                PC.PageID = Convert.ToInt64(PageID);
                PC.ButtonName = "Save";
                PC.ButtonValue = "Save";
                PC.ContextType = "CV";
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
            }
            int cnt = 0;
            int cntPA = 0;
            int cntWH = 0;
            int cntRJ = 0;
            //cnt = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
            cntPA = lstPatientInv.FindAll(p => p.Status == "PartiallyApproved").Count();
            //cntWH = lstPatientInv.FindAll(p => p.Status == "With Held").Count();
            //cntRJ = lstPatientInv.FindAll(p => p.Status == "Reject").Count();
            //if (cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
            if (cont > 0 || cntPA > 0)
            {
                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.ID = Convert.ToInt64(ILocationID);
                PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PatientVisitID = vid;
                PC.PageID = Convert.ToInt64(PageID);
                PC.ButtonName = PageContextDetails.ButtonName;
                PC.ButtonValue = PageContextDetails.ButtonValue;
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
            }

        if (returnCode == 0)
        {
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            long taskID = -1;
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            oTasksBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);// will be changed
            List<OrderedInvestigations> _InvestigationList = new List<OrderedInvestigations>();
            List<OrderedInvestigations> _NonapprovedInvestigations = new List<OrderedInvestigations>();
                //List<OrderedInvestigations> lstSecondOpinionInvestigations = new List<OrderedInvestigations>();
                //List<OrderedInvestigations> SecondOpinionInvestigations = new List<OrderedInvestigations>();
            objInvBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out _InvestigationList);
            string tempstatus = string.Empty;
            int taskActionID = 0;
                if (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SectionHeadsLab || RoleName == RoleHelper.Doctor)
            {
                tempstatus = InvStatus.Completed;
            }
                //else if (chkStatus == InvStatus.SecondOpinion)
                //{
                //    tempstatus = InvStatus.SecondOpinion;
                //    lstSecondOpinionInvestigations = _InvestigationList.FindAll(o => o.Status == tempstatus);
                //    List<Tasks> lstTasks = new List<Tasks>();
                //    oTasksBL.GetTaskID(taskID, out lstTasks);
                //    if (lstTasks != null && lstTasks.Count > 0)
                //    {
                //        taskActionID = lstTasks[0].TaskActionID;
                //    }
                //}
                //else if (RoleName == RoleHelper.Doctor || RoleName == RoleHelper.Pathologist || RoleName == RoleHelper.SeniorDoctor || RoleName == RoleHelper.JuniorDoctor)
                //{
                //    tempstatus = InvStatus.Validate;
                //}
                //else if (chkStatus == InvStatus.ReceivedOpinion)
                //{
                //    tempstatus = InvStatus.ReceivedOpinion;
                //    SecondOpinionInvestigations = _InvestigationList.FindAll(o => o.Status == InvStatus.SecondOpinion);
                //}

                //if (lstSecondOpinionInvestigations.Count > 0)
                //{
                //    if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.SecondOpinion))
                //    {
                //        oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                //    }
                //}
                //else if (chkStatus == InvStatus.ReceivedOpinion)
                //{
                //    if (SecondOpinionInvestigations.Count == 0)
                //    {
                //        oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.SecondOpinion));
                //    }
                //}
                //else
                //{
                //    _NonapprovedInvestigations = _InvestigationList.FindAll(o => o.Status == tempstatus);
                //    if (_NonapprovedInvestigations.Count == 0)
                //    {
                //        oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                //    }
                //}

                _NonapprovedInvestigations = _InvestigationList.FindAll(o => o.Status == tempstatus);
                if (_NonapprovedInvestigations.Count == 0)
                {
                    oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                }

            List<PatientInvestigation> pattasks = new List<PatientInvestigation>();
            string STATUS = string.Empty;
            STATUS = GetConfigValues("SampleStatusAllValidate", OrgID);

                //if (chkStatus != InvStatus.Pending)
                //{
                long refPhysicianID = -1;
                long PatientID = -1;
                Tasks task = new Tasks();
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();

                Int64.TryParse(Request.QueryString["pid"], out PatientID);
                long createTaskID = -1;
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);


                //if (!string.IsNullOrEmpty(STATUS) && STATUS == "Y")
                //{
                    if (Request.QueryString["gUID"] != null)
                    {
                        gUID = Request.QueryString["gUID"].ToString();
                    }
                    if (chkStatus == InvStatus.Validate && (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SectionHeadsLab))
                    {
                        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                        task.PatientVisitID = vid;
                        task.PatientID = PatientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = RId;
                        //Create task               
                        returnCode = oTasksBL.CreateTask(task, out createTaskID);
                }
                //}
                //if (chkStatus == InvStatus.SecondOpinion)
                //{
                //    if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.SecondOpinion))
                //    {
                //        List<Tasks> lstGroupTask = new List<Tasks>();
                //        foreach (long oLoginID in lstSelectedOpinionUser)
                //        {
                //            task = new Tasks();
                //            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.SecondOpinion),
                //                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                //                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                //                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                //                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber);
                //            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.SecondOpinion);
                //            task.DispTextFiller = dText;
                //            task.URLFiller = urlVal;
                //            task.RoleID = RoleID;
                //            task.AssignedTo = oLoginID;
                //            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                //            task.PatientVisitID = vid;
                //            task.PatientID = PatientID;
                //            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //            task.CreatedBy = LID;
                //            task.RefernceID = RId;

                //            lstGroupTask.Add(task);
                //        }
                //        if (lstGroupTask != null && lstGroupTask.Count > 0)
                //        {
                //            //Create task               
                //            returnCode = oTasksBL.CreateGroupTask(lstGroupTask, out createTaskID);
                //            if (returnCode == 0)
                //            {
                //                isCompleted = false;
                //            }
                //        }
                //    }
                //    else
                //    {
                //        isCompleted = true;
                //    }
                //}
                //else if (chkStatus == InvStatus.ReceivedOpinion)
                //{
                //    BillingEngine oBillingEngine = new BillingEngine(base.ContextInfo);
                //    List<TaskDetails> lstTaskDetails = new List<TaskDetails>();
                //    List<TaskDetails> lstCompletedApproveTaskDetails = new List<TaskDetails>();
                //    oBillingEngine.PgetTaskDetailsforvisit(vid, Convert.ToInt32(hdnOrgID.Value), out lstTaskDetails);
                //    bool isApproveTaskOpen = false;
                //    bool isApproveTaskCompleted = false;
                //    List<int> lstTaskStatus = new List<int>();
                //    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Pending));
                //    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.InProgress));
                //    List<int> lstCompletedApproveTaskStatus = new List<int>();
                //    lstCompletedApproveTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Completed));
                //    if (lstTaskDetails != null && lstTaskDetails.Count > 0)
                //    {
                //        lstCompletedApproveTaskDetails = (from TD in lstTaskDetails
                //                                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Validate) && lstCompletedApproveTaskStatus.Contains(TD.TaskStatusID)
                //                                          select TD).ToList<TaskDetails>();

                //        lstTaskDetails = (from TD in lstTaskDetails
                //                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Validate) && lstTaskStatus.Contains(TD.TaskStatusID)
                //                          select TD).ToList<TaskDetails>();

                //        if (lstCompletedApproveTaskDetails != null && lstCompletedApproveTaskDetails.Count > 0)
                //        {
                //            isApproveTaskCompleted = true;
                //        }
                //        if (lstTaskDetails != null && lstTaskDetails.Count > 0 && !isApproveTaskCompleted)
                //        {
                //            isApproveTaskOpen = true;
                //        }
                //    }
                //    if (SecondOpinionInvestigations.Count == 0)
                //    {
                //        if (!isApproveTaskOpen)
                //        {
                //            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                //                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                //                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                //                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                //                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber);
                //            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                //            task.DispTextFiller = dText;
                //            task.URLFiller = urlVal;
                //            task.RoleID = RoleID;
                //            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                //            task.PatientVisitID = vid;
                //            task.PatientID = PatientID;
                //            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //            task.CreatedBy = LID;
                //            task.RefernceID = RId;
                //            //Create task               
                //            returnCode = oTasksBL.CreateTask(task, out createTaskID);
                //        }
                //        isCompleted = false;
                //    }
                //    else
                //    {
                //        isCompleted = true;
                //    }
                //}
                //else
                //{
                    if (lstPatientVisitDetails.Count > 0)
                    {
                        refPhysicianID = lstPatientVisitDetails[0].ReferingPhysicianID;
                    }
                    List<ReferingPhysician> lstRefPhy = new List<ReferingPhysician>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetRefPhyDetails(refPhysicianID, Convert.ToInt32(hdnOrgID.Value), out lstRefPhy);
                    if (lstRefPhy.Count > 0)
                    {
                        if (lstRefPhy[0].LoginID != 0)
                        {
                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ViewInvestigationResult),
                                         vid, lstRefPhy[0].LoginID, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                         , out dText, out urlVal, 0, "", 0, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ViewInvestigationResult);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.AssignedTo = lstRefPhy[0].LoginID;
                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                            task.PatientVisitID = vid;
                            task.PatientID = PatientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            //Create task               
                            returnCode = oTasksBL.CreateTask(task, out createTaskID);
                    }
                }
                //if (isValidate)
                //{
                //    isCompleted = true;
                //}
                //if (isCompleted == true)
                //{
                //    TaskOpen();
                //    // CLogger.LogWarning("Task Open Comp");
                //}
                //else 
                if (_NonapprovedInvestigations.Count > 0)
                { TaskOpen(); }
                //}


            String StoreReportSnapshot = GetConfigValues("StoreReportSnapshot", OrgID);
            if (StoreReportSnapshot == "Y")
            {
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(InvStatus.Approved);
                ReportUtil objReportUtil = new ReportUtil();
                objReportUtil.SaveReportSnapshot(Convert.ToInt32(hdnOrgID.Value), ILocationID, vid, LID, lstInvStatus, true);
            }

                //if (chkStatus != InvStatus.Pending)
                //{
                long retval = -1;
                Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);
                    if (hdnSaveandNext.Value == "Y")
                    {
                        string TaskDate = "-1";
                        string category = "-1";
                        int specId = -1;
                        int DeptID = -1;
                        string PatientNumber = "-1";
                        int InvLocationID = 0;
                        string Preference = "ALL";
                        //string chktempStatus = string.Empty;
                        LoginDetail objLoginDetail = new LoginDetail();
                        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
                        TrustedOrgActions objTrustedOrgActions = new TrustedOrgActions();
                        int SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                        string SearchType = "TASK";
                        objLoginDetail.LoginID = LID;
                        objLoginDetail.RoleID = RoleID;
                        objLoginDetail.Orgid = OrgID;
                    if (Request.QueryString["CLID"] != null && Request.QueryString["CLID"] != "0")
                    {
                        ClientID = Convert.ToInt32(Request.QueryString["CLID"]);
                        ILocationID = ClientID;
                    }
                    else
                    {
                        ILocationID = 0;
                    }
                        objTrustedOrgActions.LoggedOrgID = OrgID;
                        objTrustedOrgActions.SharingOrgID = 0;
                        objTrustedOrgActions.IdentifyingType = SearchType;
                        objTrustedOrgActions.IdentifyingActionID = SerachTypeID;
                        objTrustedOrgActions.RoleID = RoleID;
                        List<TaskDetails> lstTasks = new List<TaskDetails>();


                        lstTrustedOrgActions.Add(objTrustedOrgActions);
                        objTrustedOrgActions = new TrustedOrgActions();
                        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                        List<Speciality> lstSpeciality = new List<Speciality>();
                        List<TaskActions> lstCategory = new List<TaskActions>();
                        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
                        TaskProfile taskProfile = new TaskProfile();
                        List<ClientMaster> lstClient = new List<ClientMaster>();
                        List<MetaData> lstProtocal = new List<MetaData>();
                        taskProfile.Type = "Task";
                        //long retval = -1;
                        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient, out lstProtocal);
                        //LoadDept(lstDept, taskProfile, deptID);


                        SetTasksFilter(lstLocation, lstSpeciality, lstCategory, taskProfile, lstDept);

                        TaskDate = hdnTaskDate.Value;
                        category = hdncategory.Value;
                        Int32.TryParse(hdnspecId.Value, out specId);
                        Int32.TryParse(hdnInvLocationID.Value, out InvLocationID);
                        int currentPageNo = -1;
                        if (Request.QueryString["PageNo"] != null)
                        {
                            currentPageNo = Convert.ToInt32(Convert.ToInt32(Request.QueryString["PageNo"].ToString()));
                        }
                        else
                        {
                            currentPageNo = 1;
                        }
                        //if (RowNo == 0 && chktempStatus == "Completed")
                        //{
                        //    currentPageNo = 1;
                        //}TotalRowCount
                    //if (RowNo == 0)
                    //{
                    //    RowNo = 0;
                    //}
                    //else 
                        
                    if (Request.QueryString["PageNo"] == null)
                        {
                            RowNo = RowNo + 1;
                        }

                        if (RowNo == totrowno || RowNo > totrowno || RowNo == 0)
                        {
                            currentPageNo = 1;
                        RowNo = 1;
                        }
                        else
                        {
                            if (chktempStatus == "Completed")
                            {
                                currentPageNo = RowNo + 1;
                            RowNo = RowNo + 1;
                            }
                            else
                            {
                                currentPageNo = RowNo;
                            }
                        }
                    if (Request.QueryString["RowIndex"] == null)
                    {
                        currentPageNo = Convert.ToInt32(Request.QueryString["RowIndex"]);

                    }
                        retval = tasksBL.GetAllTasksStatForSavendNext(RoleID, OrgID, LID, TaskDate,
                            category, InvLocationID, specId, PatientNumber, out lstTasks, ILocationID,
                            currentPageNo, PageSize, out totalRows, DeptID, objLoginDetail, lstTrustedOrgActions, Preference);

                        if (totalRows == RowNo)
                        {
                            RowNo = 0;
                        }

                        if (lstTasks.Count > 0)
                        {
                        strStatus = lstTasks[0].URLStatus;
                        if (strStatus == "Y")
                            redirectURL = lstTasks[0].RedirectURL.Replace("InvestigationApprovel", "InvApproval");
                        else
                            redirectURL = lstTasks[0].RedirectURL;
                        Response.Redirect(redirectURL + "&ClID=" + ClientID + "&PageNo=" + currentPageNo + "&RowIndex=" + RowNo + "&otRows=" + totalRows);
                        }
                        else
                        {
                            Response.Redirect("~/Phlebotomist/Home.aspx");
                        }
                    }
                if (hdnSaveToDispatch.Value == "1")
                {
                    if (Request.QueryString["CLID"] != null && Request.QueryString["CLID"] != "0")
                    {
                        string ClID = Request.QueryString["CLID"].ToString();
                        string ClName = Request.QueryString["ClName"].ToString();

                        Response.Redirect("~/Phlebotomist/Home.aspx?CLID=" + ClID + "&CLName=" + ClName);
                    }
                    else
                    {
                    Response.Redirect("~/Phlebotomist/Home.aspx");
                    }
                }
                //else
                //{
                //    if (Request.QueryString["pid"] != null)
                //    {
                //        Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
                //    }
                //    String ShowSummaryReport = GetConfigValues("ShowSummaryReport", OrgID);
                //    if (ShowSummaryReport == "Y")
                //    {
                //        Response.Redirect("~/Investigation/SummaryReport.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUIDTemp + "&Invid=" + InvIDs + "&ShwBtn=N" + "&RNo=" + RId + "&pid=" + pid);
                //    }
                //    else
                //    {
                //        Response.Redirect("~/Investigation/InvReportsForApproval.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUIDTemp + "&Invid=" + InvIDs + "&ShwBtn=N" + "&RNo=" + RId + "&pid=" + pid);
                //    }
                //}
                //}
                //else
                //{
                //    string path = string.Empty;
                //    List<Attune.Podium.BusinessEntities.Role> role = new List<Attune.Podium.BusinessEntities.Role>();
                //    Attune.Podium.BusinessEntities.Role roleid = new Attune.Podium.BusinessEntities.Role();
                //    roleid.RoleID = RoleID;
                //    role.Add(roleid);
                //    new Navigation().GetLandingPage(role, out path);
                //    if (path != string.Empty)
                //    {
                //        Response.Redirect(Request.ApplicationPath + path);
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            modal.Attributes.Add("display", "none");
            CLogger.LogError("Error in InvApproval on Save", ex);
        }
        hdnSaveandNext.Value = "N";
    }

    private void TaskOpen()
    {
        try
        {
            //if (OrgID == 72 || OrgID == 92 || OrgID == 69)
            //{
            //CLogger.LogWarning("Open Task "+hdnClickCheck.Value.ToString());
            long visitID = 0;
            long returncode = -1;
            Int64.TryParse(Request.QueryString["vid"].ToString(), out visitID);
            long taskID = -1;
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            List<Tasks> lstTasks = new List<Tasks>();
            Tasks t = new Tasks();
            t.TaskID = taskID;
            t.PatientVisitID = visitID;
            lstTasks.Add(t);
            int UpdatetaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Pending);
            returncode = new Tasks_BL(base.ContextInfo).ReAssiginingTask(0, 0, LID, UpdatetaskStatusID, lstTasks);
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error InvApproval on Task Open", ex);
        }
    }

    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        try
        {
            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            if (lstStatus.Count > 0)
            {
                ddldivupstatus.DataSource = lstStatus;
                ddldivupstatus.DataTextField = "DisplayText";
                ddldivupstatus.DataValueField = "StatuswithID";
                ddldivupstatus.DataBind();
                string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
                string DisplayStatus = lstStatus.Find(O => O.StatuswithID.Contains("_1")).DisplayText;
                //if (ddldivupstatus.Items.FindByValue(SelString) != null)
                //{
                //    ddldivupstatus.SelectedValue = SelString;
                //}
                hdnStatus.Value = SelString.Split('_').Length > 0 ? SelString.Split('_')[0] : "0";
                hdnDisplayStatus.Value = DisplayStatus != "" ? DisplayStatus : "0";
                hdnLstStatus.Value = serializer1.Serialize(lstStatus);
            }
            else
            {
                ddldivupstatus.DataSource = null;
                ddldivupstatus.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in invApproval on loadStatus", ex);
        }
    }

    public void loadReason(List<InvReasonMasters> lstInvReasonMater)    
    {
        try
        {
            if (lstInvReasonMater.Count > 0)
            {
                ddldivupReason.DataSource = lstInvReasonMater;
                ddldivupReason.DataTextField = "ReasonDesc";
                ddldivupReason.DataValueField = "ReasonID";
                ddldivupReason.DataBind();                
            }
            else
            {
                ddldivupReason.DataSource = null;
                ddldivupReason.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in invApproval on loadReason ", ex);
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;    


        try
        {
            Int32 orgId = 0;
            if (!String.IsNullOrEmpty(hdnOrgID.Value))
            {
                Int32.TryParse(hdnOrgID.Value, out orgId);
            }
            else
            {
                orgId = OrgID;
            }
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, orgId, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void SetTasksFilter(List<OrganizationAddress> lstLocation, List<Speciality> lstSpeciality,
    List<TaskActions> lstCategory,
    TaskProfile taskProfile, List<InvDeptMaster> lstDept)
    {
        try
        {
            /* DEFAULT DATE*/
            if (taskProfile.TaskDate != "" && taskProfile.TaskDate == "ToDay")
            {
                hdnTaskDate.Value = OrgTimeZone;
            }
            else if (taskProfile.TaskDate != "" && taskProfile.TaskDate == "ALL")
            {
                hdnTaskDate.Value = "-1";
            }
            else if (taskProfile.TaskDate != "")
            {
                hdnTaskDate.Value = taskProfile.TaskDate;
            }
            else
            {
                hdnTaskDate.Value = "-1";
            }
            /*DEFAULT CATEGORY*/
            if (taskProfile.Category != "0")
            {
                hdncategory.Value = taskProfile.Category;
            }
            else
            {
                hdncategory.Value = "-1";
            }
            /*DEFAULT SPECALITY*/
            if (taskProfile.SpecialityID != 0)
            {
                hdnspecId.Value = taskProfile.SpecialityID.ToString();
            }
            else
            {
                hdnspecId.Value = "-1";
            }
            /*DEFAULT LOCATION*/
            if (taskProfile.Location != "0")
            {
                //Int32.TryParse(taskProfile.Location, out InvLocationID);
                hdnInvLocationID.Value = taskProfile.Location;
            }
            else
            {
                hdnInvLocationID.Value = "-1";
            }
            /*DEFAULT DEPRTMENT*/

            if (taskProfile.DeptID != 0)
            {
                hdnDeptID.Value = taskProfile.DeptID.ToString();
            }
            else
            {
                hdnDeptID.Value = "-1";
            }

        }
        catch (Exception e)
        {
            CLogger.LogError("Error in QuickApproval Load Default Task Items", e);
        }
    }

    public void ShowCulture(object sender, EventArgs e)
    {
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<PatientInvestigation> lstInve = new List<PatientInvestigation>();
        string retur = string.Empty;
        Investigation_BL InvestigationBL;
        string status = "Approve";
        List<InvestigationValues> DemoBulk, lstPendingValue, lstValue = new List<InvestigationValues>();
        List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        List<InvestigationStatus> header = new List<InvestigationStatus>();
        if (hdnLstPatientInvestigationCulture.Value != "" && hdnLstPatientInvestigationCulture.Value != null)
        {
            lstInve = serializer1.Deserialize<List<PatientInvestigation>>(hdnLstPatientInvestigationCulture.Value);
        }
        List<PerformingPhysician> lPerformingPhysicain = new List<PerformingPhysician>();
        InvestigationValues invvalue = new InvestigationValues();
        invvalue.Value = lstInve[0].Value;
        invvalue.MedicalRemarks = lstInve[0].MedicalRemarks;
        invvalue.Reason = lstInve[0].Reason;
        lstValue.Add(invvalue);
        //string PatternName = "~/Investigation/CultureandSensitivityReportV2.ascx";
        //Investigation_CultureandSensitivityReportV2 Culture;
        //Culture = (Investigation_CultureandSensitivityReportV2)LoadControl(PatternName);

        ucCultureandSensitivityReportV2.POrgid = Convert.ToInt32(OrgID);
        long InvestigationID = lstInve[0].InvestigationID;
        int GroupID = lstInve[0].GroupID;

        List<InvPackageMapping> lstInvPackageMapping = new List<InvPackageMapping>();
        InvPackageMapping IPM = new InvPackageMapping();
        IPM.ID = lstInve[0].InvestigationID;
        IPM.PackageID = lstInve[0].GroupID;
        IPM.Type = "";
        lstInvPackageMapping.Add(IPM);

        InvestigationBL = new Investigation_BL();
        InvestigationBL.GetDrawPatternInvBulkData(gUID, lstInvPackageMapping, vid, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom, out lPerformingPhysicain);
        ucCultureandSensitivityReportV2.LoadData(DemoBulk);
        ucCultureandSensitivityReportV2.LoadOrganism(Convert.ToInt32(OrgID), lstInve[0].InvestigationID, "OrganismName", "XMLDrugList");
        ucCultureandSensitivityReportV2.Name = lstInve[0].InvestigationName;
        //ucCultureandSensitivityReportV2.ID = (Convert.ToString(lstInve[0].InvestigationID) + "~" + lstInve[0].GroupID + "~" + lstInve[0].RootGroupID);
        ucCultureandSensitivityReportV2.ControlID = Convert.ToString(lstInve[0].InvestigationID);
        ucCultureandSensitivityReportV2.setContextkey(Convert.ToString(lstInve[0].InvestigationID), lstInve[0].InvestigationName);
        ucCultureandSensitivityReportV2.GroupID = lstInve[0].GroupID;
        ucCultureandSensitivityReportV2.GroupName = lstInve[0].GroupName;
        ucCultureandSensitivityReportV2.PackageID = lstInve[0].PackageID;
        ucCultureandSensitivityReportV2.PackageName = lstInve[0].PackageName;
        ucCultureandSensitivityReportV2.CurrentRoleName = "";
        //ucCultureandSensitivityReportV2.LabTechEditMedRem = strLabTechToEditMedRem;
        ucCultureandSensitivityReportV2.Reason = lstInve[0].Reason;
        ucCultureandSensitivityReportV2.loadStatus(header);
        ucCultureandSensitivityReportV2.TID = ucCultureandSensitivityReportV2.ID;
        //ucCultureandSensitivityReportV2.MakeReadOnly(ucCultureandSensitivityReportV2.ID);
        if (lstPendingValue.Count > 0)
        {
            ucCultureandSensitivityReportV2.SetInvestigationValueForEdit(lstValue);
        }
        tdCulturename.InnerHtml = lstInve[0].InvestigationName;
        //pnlUCCulture.Controls.Add(ucCultureandSensitivityReportV2);
        StringBuilder sb = new StringBuilder();
        sb.Append("SaveCultureSensitivityV2Details('" + lstInve[0].InvestigationID + "','" + ucCultureandSensitivityReportV2.ClientID + "');");
        ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveOrganisumXMLData", "function CallingSaveCultureSensitiveV2(){" + sb.ToString() + "}", true);
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "SaveCultureSensitivityV2Details", "SaveCultureSensitivityV2Details('" + lstInve[0].InvestigationID + "','" + ucCultureandSensitivityReportV2.ClientID + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "fnGetInvestigatonResultsCapture", "fnGetInvestigatonResultsCapture('" + vid + "','" + OrgID + "','" + RoleID + "','" + gUID + "','" + DeptID + "','" + InvIDs + "','" + ILocationID + "','" + taskID + "','" + IsTrustedDetails + "','" + status + "','" + LID + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "fnGetInvestigatonResultsCapture", "SaveCultureSensitivityV2Details('" + lstInve[0].InvestigationID + "','" + ucCultureandSensitivityReportV2.ClientID + "');", true);
        mpeShowCulture.Show();
    }

    public void GetCultureResult(object sender, EventArgs e)
    {
        try
        {
            //ShowCulture(sender, e);
            List<InvestigationValues> lstHPP = new List<InvestigationValues>();
            string cultureValueXML = string.Empty;
            string MedicalRemarks = string.Empty;
            string Status = string.Empty;
            string DisplayStatus = string.Empty;
            //PatientInvestigation CultureTestV2 = ucCultureandSensitivityReportV2.GetInvestigations(vid);
            cultureValueXML = ucCultureandSensitivityReportV2.CreateXML();
            HiddenField hdnMedicalRemarks = (HiddenField)ucCultureandSensitivityReportV2.FindControl("hdnMedicalRemarks");
            MedicalRemarks = hdnMedicalRemarks.Value;
            HiddenField hdnStaus = (HiddenField)ucCultureandSensitivityReportV2.FindControl("hdnStaus");
            Status = hdnStaus.Value;
            HiddenField hdnDisplaystatus = (HiddenField)ucCultureandSensitivityReportV2.FindControl("hdnDisplaystatus");
            DisplayStatus = hdnDisplaystatus.Value;
            //GetStatus = ucCultureandSensitivityReportV2.GetStatus();
            //LstOfBio.Add(lstHPP);

            //List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
            //lstPatientInv.Add(CultureTestV2);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "UpdateCultureValue", "UpdateCultureValue('" + cultureValueXML + "','" + MedicalRemarks + "','" + Status + "','" + DisplayStatus + "')", true);
            mpeShowCulture.Hide();
        }
        catch
        {

        }
    }
    //[WebMethod]  
    //public static string LoadUserControl(string lstpatientinvestigation, string gUID, int OrgID, long VisitID)
    //public static string LoadUserControl(string lstpatientinvestigation, string gUID, string OrgID)
    //{
    //    string retur = string.Empty;
    //    Investigation_BL InvestigationBL;
    //    string status = "Approve";
    //    List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //    List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //    List<InvestigationStatus> header = new List<InvestigationStatus>();
    //    try
    //    {
    //        Page page = new Investigation_CultureandSensitivityReportV2.PageOverride();
    //        //Page page = new Investigation_InvApproval.PageOverride();
    //        string PatternName = "~/Investigation/CultureandSensitivityReportV2.ascx";
    //        ScriptManager s = new ScriptManager();
    //        page.Controls.Add(s);
    //        Investigation_CultureandSensitivityReportV2 Culture;
    //        Culture = (Investigation_CultureandSensitivityReportV2)page.LoadControl(PatternName);
    //        //PatientInvestigation lstInve = new PatientInvestigation();
    //        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
    //        List<PatientInvestigation> lstInve = serializer1.Deserialize<List<PatientInvestigation>>(lstpatientinvestigation);
    //        List<PerformingPhysician> lPerformingPhysicain = new List<PerformingPhysician>();
    //        page.Controls.Add(Culture);
    //        StringWriter writer = new StringWriter();
    //        Culture.POrgid = Convert.ToInt32(OrgID);
    //        long InvestigationID = lstInve[0].InvestigationID;
    //        int GroupID = lstInve[0].GroupID;

    //        List<InvPackageMapping> lstInvPackageMapping = new List<InvPackageMapping>();
    //        InvPackageMapping IPM = new InvPackageMapping();
    //        IPM.ID = lstInve[0].InvestigationID;
    //        IPM.PackageID = lstInve[0].GroupID;
    //        IPM.Type = "";
    //        lstInvPackageMapping.Add(IPM);

    //        InvestigationBL = new Investigation_BL();
    //        InvestigationBL.GetDrawPatternInvBulkData(gUID, lstInvPackageMapping, VisitID, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom, out lPerformingPhysicain);
    //        Culture.LoadData(DemoBulk);
    //        Culture.LoadOrganism(Convert.ToInt32(OrgID), lstInve[0].InvestigationID, "OrganismName", "XMLDrugList");
    //        Culture.Name = lstInve[0].InvestigationName;
    //        Culture.ID = (Convert.ToString(lstInve[0].InvestigationID) + "~" + lstInve[0].GroupID + "~" + lstInve[0].RootGroupID);
    //        Culture.ControlID = Convert.ToString(lstInve[0].InvestigationID);
    //        Culture.GroupID = lstInve[0].GroupID;
    //        Culture.GroupName = lstInve[0].GroupName;
    //        Culture.PackageID = lstInve[0].PackageID;
    //        Culture.PackageName = lstInve[0].PackageName;
    //        Culture.CurrentRoleName = "";
    //        //Culture.LabTechEditMedRem = strLabTechToEditMedRem;
    //        Culture.Reason = lstInve[0].Reason; 
    //        Culture.loadStatus(header);
    //        Culture.TID = Culture.ID;
    //        Culture.MakeReadOnly(Culture.ID);
    //        if (lstPendingValue.Count > 0)
    //        {
    //            Culture.SetInvestigationValueForEdit(lstPendingValue);
    //        }
    //        //page.Controls.Add(Culture);
    //        HtmlForm form = new HtmlForm();
    //        form.Controls.Add(Culture);
    //        page.Controls.Add(form);
    //        page.Controls.Remove(s);
    //        HttpContext.Current.Server.Execute(page, writer, false);
    //        return writer.ToString();

    //    }
    //    catch (Exception ex)
    //    {
    //        return retur;
    //    }
    //}

    //[WebMethod]
    //public static List<InvestigationValues> GetCultSensResult(long VisitID)
    //{
    //    List<InvestigationValues> lstResult = new List<InvestigationValues>();
    //    try
    //    {

    //        //(Convert.ToString(lstInve[0].InvestigationID) + "~" + lstInve[0].GroupID + "~" + lstInve[0].RootGroupID);
    //        Investigation_CultureandSensitivityReportV2 cultureV2 = new Investigation_CultureandSensitivityReportV2();
    //        //Investigation_CultureandSensitivityReportV2 cultureV21 = (Investigation_CultureandSensitivityReportV2)this.Page.FindControl("4623~0~0");
    //        cultureV2.GetResult(VisitID);
    //        //
    //        //cultureV2 = (Investigation_CultureandSensitivityReportV2).FindControl("4623~0~0");
    //        //cultureV2 = 
    //        //lstResult = cultureV2.GetResult(vid);
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //    return lstResult;
    //}

    //public class PageOverride : System.Web.UI.Page
    //{
    //    public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
    //    {

    //    }
    //}
    //protected void btnUpdate_Click(object sender, EventArgs e)
    //{
    //    List<InvestigationValues> lstResult = new List<InvestigationValues>();
    //    try
    //    {

    //        // (Convert.ToString(lstInve[0].InvestigationID) + "~" + lstInve[0].GroupID + "~" + lstInve[0].RootGroupID);
    //        //Investigation_CultureandSensitivityReportV2 cultureV2 = (Investigation_CultureandSensitivityReportV2)this.Page.FindControl("4623~0~0");
    //        //cultureV2 = (Investigation_CultureandSensitivityReportV2).FindControl("4623~0~0");
    //        //cultureV2 =
    //        //lstResult = cultureV2.GetResult(vid);
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //    //return lstResult;
    //}
    protected void btnbtmskipnnext_Click(object sender, EventArgs e)
    {
        //hdnSkipandNext.Value = "Y";
        long retval = -1;
        Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);
        if (hdnSaveandNext.Value == "N")
        {
         TaskOpen();
        string TaskDate = "-1";
        string category = "-1";
        int specId = -1;
        int DeptID = -1;
        string PatientNumber = "-1";
        int InvLocationID = 0;
        string Preference = "ALL";
        //string chktempStatus = string.Empty;
        LoginDetail objLoginDetail = new LoginDetail();
        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
        TrustedOrgActions objTrustedOrgActions = new TrustedOrgActions();
        int SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
        string SearchType = "TASK";
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        objTrustedOrgActions.LoggedOrgID = OrgID;
        objTrustedOrgActions.SharingOrgID = 0;
        objTrustedOrgActions.IdentifyingType = SearchType;
        objTrustedOrgActions.IdentifyingActionID = SerachTypeID;
        objTrustedOrgActions.RoleID = RoleID;
        List<TaskDetails> lstTasks = new List<TaskDetails>();


        lstTrustedOrgActions.Add(objTrustedOrgActions);
        objTrustedOrgActions = new TrustedOrgActions();
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<TaskActions> lstCategory = new List<TaskActions>();
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        List<ClientMaster> lstClient = new List<ClientMaster>();
        List<MetaData> lstProtocal = new List<MetaData>();
        TaskProfile taskProfile = new TaskProfile();
        taskProfile.Type = "Task";
        //long retval = -1;
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient, out lstProtocal);
        //LoadDept(lstDept, taskProfile, deptID);


        SetTasksFilter(lstLocation, lstSpeciality, lstCategory, taskProfile, lstDept);

        TaskDate = hdnTaskDate.Value;
        category = hdncategory.Value;
        Int32.TryParse(hdnspecId.Value, out specId);
        Int32.TryParse(hdnInvLocationID.Value, out InvLocationID);
        int currentPageNo = -1;
        if (Request.QueryString["PageNo"] != null)
        {
                currentPageNo = Convert.ToInt32(Convert.ToInt32(Request.QueryString["PageNo"].ToString())) ;
        }
        else
        {
            currentPageNo = 1;
        }
        //if (RowNo == 0 && chktempStatus == "Completed")
        //{
        //    currentPageNo = 1;
        //}TotalRowCount
        //if (RowNo == 0)
        //{
        //    RowNo = 0;
        //}
        //else 
        chktempStatus = "";
        if (Request.QueryString["PageNo"] == null)
        {
                RowNo = RowNo + 1;
                chktempStatus = "N";
        }

        if (RowNo == totrowno || RowNo > totrowno || RowNo == 0)
        {
            currentPageNo = 1;
            RowNo = 1;
        }
        else
        {
                if (chktempStatus == "")
                {
                    currentPageNo = RowNo + 1;
                    RowNo = RowNo + 1;
                }
                else
                {
                    currentPageNo = RowNo;
                }
                //currentPageNo = RowNo;
            }
        if (Request.QueryString["CLID"] != null && Request.QueryString["CLID"] != "0")
        {
            ClientID = Convert.ToInt32(Request.QueryString["CLID"]);
            ILocationID = ClientID;
        }
        else 
        {
            ILocationID = 0;
        }
            if (Request.QueryString["RowIndex"] != null)
            {
                currentPageNo = Convert.ToInt32(Request.QueryString["RowIndex"]);

            }
     	Preference = "N";
        retval = tasksBL.GetAllTasksStatForSavendNext(RoleID, OrgID, LID, TaskDate,
            category, InvLocationID, specId, PatientNumber, out lstTasks, ILocationID,
            currentPageNo, PageSize, out totalRows, DeptID, objLoginDetail, lstTrustedOrgActions, Preference);
        //TaskOpen();

        //if (RowNo != 0 )
        //    {
        //        currentPageNo = RowNo;
        //    }
		
        if (totalRows == RowNo)
        {
            RowNo = 0;
        }
        if (lstTasks.Count > 0)
        {
                strStatus = lstTasks[0].URLStatus;
                if (strStatus == "Y")
                    redirectURL = lstTasks[0].RedirectURL.Replace("InvestigationApprovel", "InvApproval");
                else
                    redirectURL = lstTasks[0].RedirectURL;
                Response.Redirect(redirectURL + "&ClID=" + ClientID + "&PageNo=" + currentPageNo + "&RowIndex=" + RowNo + "&otRows=" + totalRows);
            }
            else
            {

                Response.Redirect("~/Phlebotomist/Home.aspx");
            }
            if (hdnSaveToDispatch.Value == "1")
            {
                if (Request.QueryString["CLID"] != null && Request.QueryString["CLID"] != "0")
                {
                    string ClID = Request.QueryString["CLID"].ToString();
                    string ClName = Request.QueryString["ClName"].ToString();

                    Response.Redirect("~/Phlebotomist/Home.aspx?CLID=" + ClID + "&CLName=" + ClName);
                }
                else
                {
                    Response.Redirect("~/Phlebotomist/Home.aspx");
                }
            }
        }
    }
    #endregion
}

