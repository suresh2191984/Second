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
using System.Configuration;
using System.IO;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Text;


public partial class Investigation_BatchwiseWorksheet : BasePage, System.Web.UI.ICallbackEventHandler
{
    Investigation_BL objInvBL;
    Investigation_BL InvestigationBL;
    long worklistid = 0;
    List<PatientInvestigation> lstpatinvestigation = new List<PatientInvestigation>();
    string AllowAutoApproveTask = string.Empty;
    long returncode = -1;
    string VisitIDs = "0";
    string InvType = string.Empty;
    string InvName = string.Empty;
    long deviceid = 0;
    string isAbnormalResult = "0";
    long headerID = 0;
    long protocalID = 0;
    int deptID = 0;
    string isMaster = "N";
    string workListType = string.Empty;
    string IsExcludeAutoApproval;
    long pSCMID = -1;
    long vid = 0;
    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
    string gUID = string.Empty;
    string rawData;
    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        objInvBL = new Investigation_BL(base.ContextInfo);
        try
        {
            GateWay gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            hdnOrgID.Value = OrgID.ToString();
            lblResult.Visible = false;
            LoadRangeColor();
            List<Config> lstConfigs = new List<Config>();
            if (!IsPostBack)
            {
                hdnOutofrangeCount.Value = "0";
                mpeAttributeLocation.Hide();
            }
            if (Request.QueryString["worklistid"] != null)
            {
                worklistid = Convert.ToInt64(Request.QueryString["worklistid"]);
            }
            if (Request.QueryString["Action"] != null)
            {
                hdnActionName.Value = Request.QueryString["Action"];
            }
            if (hdnActionName.Value == "Validate")
            {
                //lblPageHeader.Text = "Batch Wise Validate Result";
                hdnDefaultDropDownStatus.Value = "Validate";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
        }
    }


    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {
        VisitIDs = "0";
        InvName = "";
        InvType = "";
        worklistid = 0;
        deviceid = 0;
        isAbnormalResult = "0";
        deptID = 0;
        headerID = 0;
        protocalID = 0;
        isMaster = "N";
        workListType = "0";
        try
        {
            if (txtWorkListID.Text.Trim() != "")
            {
                worklistid = Convert.ToInt64(txtWorkListID.Text);               
            }
            Response.Redirect(Request.ApplicationPath + "/Investigation/BatchwiseResultEntry.aspx?vids=" + VisitIDs + "&InvType=" + InvType + "&InvName=" + InvName + "&worklistid=" + worklistid + "&deviceid=" + deviceid + "&isabnormal=" + isAbnormalResult + "&Action=" + hdnActionName.Value + "&deptid=" + deptID + "&headerid=" + headerID + "&protocalid=" + protocalID + "&ismaster=" + isMaster + "&workListType=" + workListType, true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnBatchSearch_Click at BatchWiseEnterResult Page", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            SaveContinue();
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "BatchValidation", "javascript:BatchValidation();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
        }
    }

    protected void btnApproval_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            SaveContinue();
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "BatchValidation", "javascript:BatchValidation();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Investigation/BatchwiseWorksheet.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on Button1_Click", ex);
        }
    }

    private void SaveContinue()
    {
        try
        {
            if (Request.QueryString["pid"] != null)
            {
                PageContextDetails.PatientID = Convert.ToInt64(Request.QueryString["pid"]);
            }
            long returncode = AutoSave();

            ////List<PatientInvestigation> Patinvestasks1 = new List<PatientInvestigation>();
            PatientInvestigation lstpats;
            if (returncode == 0)
            {


                //List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();
                //foreach (var item in lstpatinvestigation)
                //{
                //    lstpats = new PatientInvestigation();
                //    lstpats.PatientVisitID = item.PatientVisitID;
                //    lstpats.PatternID = item.PatternID;
                //    lstpats.UID = item.UID;
                //    lstpats.LabNo = item.LabNo;
                //    Patinvestasks.Add(lstpats);
                //}
                List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();


                //Patinvestasks1 = lstpatinvestigation.Select(pinv => new 
                //                 {
                //                     pinv.PatientVisitID,
                //                      pinv.PatternID,
                //                      pinv.UID,
                //                     pinv.LabNo
                //                 }).Distinct().ToList();

                //var queryResults = lstpatinvestigation.Select(c => c.PatientVisitID, c.PatternID).Distinct();
                //Patinvestasks = lstpatinvestigation;
                List<PatientInvestigation> pattasks = new List<PatientInvestigation>();
                PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();
                int TaskActionID = -1;
                int VisitPurposeID = Convert.ToInt32(TaskHelper.VisitPurpose.LabInvestigation);
                int OtherID = RoleID;
                List<TaskActions> lstTaskActions = new List<TaskActions>();
                objPatientVisit_BL.GetTaskActionID(OrgID, VisitPurposeID, RoleID, out lstTaskActions);
                if (lstTaskActions.Count > 0)
                {
                    if (lstTaskActions[0].TaskActionID > 0)
                    {
                        TaskActionID = lstTaskActions[0].TaskActionID;
                    }
                    else
                    {
                        TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Approval);
                    }
                }
                else
                {
                    TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Approval);
                }
                 var Patinvestasks1 = lstpatinvestigation.Select(e => new { e.InvestigationName,e.InvestigationID,e.GroupID,e.GroupName,
                     e.PatientVisitID,e.CreatedBy,e.CreatedAt,e.Status,e.Type,e.OrgID,e.LabNo
                    ,e.PackageID,e.PackageName,e.Reason,e.ApprovedBy,e.UID,e.AccessionNumber})
                             .Distinct().ToList();

                //Patinvestasks1.ToList();
                //Patinvestasks.Select(e => new { e.PatientVisitID, e.PatternID, e.UID, e.LabNo }).Distinct().ToList();

                //Patinvestasks.Select(e => new { e.PatientVisitID, e.PatternID, e.UID, e.LabNo }).Distinct().ToList();

                if (Patinvestasks1.Count > 0)
                {
                    Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);
                    //long returnCode = -1;
                    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    PatientInvestigation lstpat;
                    for (int m = 0; m < Patinvestasks1.Count; m++)
                    {
                        lstpat = new PatientInvestigation();
                        lstpat.InvestigationName = Patinvestasks1[m].InvestigationName;
                        lstpat.InvestigationID = Patinvestasks1[m].InvestigationID;
                        lstpat.GroupID = Patinvestasks1[m].GroupID;
                        lstpat.GroupName = Patinvestasks1[m].GroupName;
                        lstpat.PatientVisitID = Patinvestasks1[m].PatientVisitID;
                        lstpat.CreatedBy = Patinvestasks1[m].CreatedBy;
                        lstpat.CreatedAt = Patinvestasks1[m].CreatedAt;
                        lstpat.Status = Patinvestasks1[m].Status;
                        lstpat.Type = Patinvestasks1[m].Type;
                        lstpat.OrgID = Patinvestasks1[m].OrgID;
                        lstpat.PackageID = Patinvestasks1[m].PackageID;
                        lstpat.PackageName = Patinvestasks1[m].PackageName;
                        lstpat.Reason = Patinvestasks1[m].Reason;
                        lstpat.ApprovedBy = Patinvestasks1[m].ApprovedBy;
                        lstpat.UID = Patinvestasks1[m].UID;
                        lstpat.AccessionNumber = Patinvestasks1[m].AccessionNumber;
                        lstpat.LabNo = Patinvestasks1[m].LabNo;
                        Patinvestasks.Add(lstpat);
                    }
                    List<PatientInvestigation> lstPatientInvestigation1;
                    foreach (PatientInvestigation item in Patinvestasks)
                    {
                        lstPatientInvestigation1 = new List<PatientInvestigation>();
                        lstPatientInvestigation1.Add(item);
                        //returnCode = DemoBL.GetPatientInvestigationStatus(item.PatientVisitID, OrgID, out lstPatientInvestigation);
                        DemoBL.GetGrouplevelvalidation(item.PatientVisitID, TaskActionID, lstPatientInvestigation1, OrgID, 0, out pattasks);
                        if (pattasks.Count > 0)
                        {
                            Tasks task = new Tasks();
                            Hashtable dText = new Hashtable();
                            Hashtable urlVal = new Hashtable();
                            long createTaskID = -1;
                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(item.PatientVisitID, out lstPatientVisitDetails);
                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                             item.PatientVisitID, 0, lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " +
                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                             , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                             item.UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = item.PatientVisitID;
                            task.PatientID = lstPatientVisitDetails[0].PatientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.RefernceID = item.LabNo;
                            returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                            string display = string.Empty;
                            //CreateTask(item, lstPatientInvestigation1);
                        }
                    }
                }
            }
            //btnBatchSearch_Click(null, null);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Checks datas", "javascript:fnHideProgress();", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private long AutoSave()
    {
        int returnStatus = -1;
        long returnCode = -1;
        try
        {
            List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
            ArrayList result = new ArrayList();

            List<InvestigationValues> lstBio1 = null;
            List<InvestigationValues> lstFishpattern1 = null;
            List<InvestigationValues> lstFishpattern2 = null;
            List<InvestigationValues> lstBio2 = new List<InvestigationValues>();
            List<InvestigationValues> lstBio3 = new List<InvestigationValues>();
            List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
            bool Flag = true;

            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            List<PatientInvestigation> lstPatientInv = serializer1.Deserialize<List<PatientInvestigation>>(hdnLstPatientInvestigation.Value);
            List<InvestigationValues> LstOfBio1 = serializer1.Deserialize<List<InvestigationValues>>(hdnLstInvestigationValues.Value);
            List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
            LstOfBio.Add(LstOfBio1);

            int deptID = Convert.ToInt32(hdnDept.Value);
            Investigation_BL saveResults = new Investigation_BL(base.ContextInfo);

            try
            {
                AllowAutoApproveTask = "No";
                int PendingCount = 0;
                foreach (var O in lstPatientInv)
                {
                    if (hdnDomainvalue.Value == "true")
                    {
                        O.Status = "Pending";
                        AllowAutoApproveTask = "No";
                        O.IsAutoAuthorize = "N";
                        PendingCount += 1;
                    }
                    else if ((O.Status == "Completed" || O.Status == "Pending") && (O.IsAbnormal == "N" || O.IsAbnormal == "") && O.AutoApproveLoginID > 0 && IsExcludeAutoApproval == "N")
                    {
                        O.Status = "Approve";
                        O.IsAutoAuthorize = "Y";
                        O.ApprovedBy = O.AutoApproveLoginID;
                    }
                    else if (O.Status != "Completed" || O.IsAbnormal == "A" || O.IsAbnormal == "L" || O.IsAbnormal == "P")//|| O.AutoApproveLoginID != LID)
                    {
                        AllowAutoApproveTask = "No";
                        O.IsAutoAuthorize = "N";
                        PendingCount += 1;
                    }
                    else if (O.Status == "Completed")
                    {
                        AllowAutoApproveTask = "No";
                        O.IsAutoAuthorize = "N";
                        PendingCount += 1;
                    }

                    if (O.Status == InvStatus.Validate)
                    {
                        O.ValidatedBy = LID;
                    }
                    else
                    {
                        O.ValidatedBy = 0;
                    }
                }
                if (PendingCount == 0)
                {
                    AllowAutoApproveTask = "Yes";
                }

                //foreach (var O in lstPatientInv)
                //{
                //    if (O.Status == InvStatus.Validate)
                //    {
                //        O.ValidatedBy = LID;
                //    }
                //    else
                //    {
                //        O.ValidatedBy = 0;
                //    }
                //}

                lstpatinvestigation = lstPatientInv;
                if (Flag == true)
                {
                    long approvedBy = hdnActionName.Value == "Validate" ? LID : 0;
                    returnCode = saveResults.BatchWiseSaveInvestigationResults_Lab(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, OrgID, deptID, approvedBy, gUID, PageContextDetails, out returnStatus);
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return returnCode;
    }

    public void CreateTask(PatientInvestigation item, List<PatientInvestigation> lstPatientInvestigation)
    {
        try
        {
            Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);
            List<OrderedInvestigations> _InvestigationList = new List<OrderedInvestigations>();
            List<OrderedInvestigations> _NonapprovedInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstCoauthorizeInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstSecondOpinionInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> SecondOpinionInvestigations = new List<OrderedInvestigations>();
            DemoBL.pGetpatientInvestigationForVisit(item.PatientVisitID, OrgID, ILocationID, item.UID, out _InvestigationList);

            int nonValidatedCount = 0;
            nonValidatedCount = (from IL in _InvestigationList
                                 where IL.Status != InvStatus.Completed && IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved
                                 && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.Cancel
                                 && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                 select IL).Count();
            if (nonValidatedCount > 0)
            {
                long returnCode = -1;
                List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
                returnCode = DemoBL.GetSampleNotGiven(OrgID, item.PatientVisitID, out lstSampleTracker);
                if (lstSampleTracker.Count > 0)
                {
                    int validatedCount = 0;
                    validatedCount = (from IL in lstPatientInvestigation
                                      where IL.Status != InvStatus.Completed && IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved
                                      && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.Cancel
                                      && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                      && IL.Status != InvStatus.Notgiven
                                      select IL).Count();
                    if (validatedCount <= 0)
                    {
                        nonValidatedCount = 0;
                    }
                }
            }
            _NonapprovedInvestigations = (from IL in _InvestigationList
                                          where IL.Status != InvStatus.Approved && IL.Status != InvStatus.SecondOpinion
                                          && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld && IL.Status != InvStatus.Cancel
                                          select IL).Distinct().ToList();
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            if (_NonapprovedInvestigations.Count == 0)
            {
                oTasksBL.UpdateTaskForaVisit(item.PatientVisitID, OrgID, LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
            }
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();

            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(item.PatientVisitID, out lstPatientVisitDetails);
            PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();

            int OtherID = RoleID;
            if (nonValidatedCount == 0)
            {
                returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                             item.PatientVisitID, 0, lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " +
                             lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                             , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                             item.UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = item.PatientVisitID;
                task.PatientID = lstPatientVisitDetails[0].PatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                task.RefernceID = item.LabNo;
                //Create task               
                returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                string display = string.Empty;
            }
            if (_InvestigationList.FindAll(P => P.Status == InvStatus.Completed).Count == 0)
            {
                List<Tasks> lstTasks = new List<Tasks>();
                oTasksBL.GetTaskByVisit(item.PatientVisitID, OrgID, Convert.ToInt32(TaskHelper.TaskAction.Approval), out lstTasks);
                foreach (Tasks oTasks in lstTasks)
                {
                    oTasksBL.UpdateTask(oTasks.TaskID, TaskHelper.TaskStatus.Completed, LID);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating task", ex);
        }
    }

    public void LoadRangeColor()
    {
        long returnCode;
        List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
        returnCode = new Investigation_BL().getReferencerangetype(OrgID, LanguageCode, out lstReferenceRangeType);
        if (lstReferenceRangeType.Count > 0)
        {
            txtAuto.Attributes.Add("style", "background-color:" + lstReferenceRangeType[1].Color + ";");
            txtPanic.Attributes.Add("style", "background-color:" + lstReferenceRangeType[2].Color + ";");
            txtReference.Attributes.Add("style", "background-color:white;");
            txtLower.Attributes.Add("style", "background-color:" + lstReferenceRangeType[3].Color + ";");
            txtHigher.Attributes.Add("style", "background-color:" + lstReferenceRangeType[4].Color + ";");
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void RaiseCallbackEvent(String eventArgument)
    {
        try
        {
            rawData = eventArgument;
            //ValidateUserResult(rawData, out textColor);
            //validateAllRange(rawData);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string GetCallbackResult()
    {
        try
        {
            // return textColor.ToString();
            return hdnGenderAge.Value.ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
