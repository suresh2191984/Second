using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Attune.Podium.BusinessEntities;
using iTextSharp.text.pdf;
using iTextSharp.text;
using Attune.Podium.Common;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Solution.BusinessComponent;
using Microsoft.Reporting.WebForms;
using Attune.Podium.PerformingNextAction;
using System.Web.Script.Services;
using System.Web.Services;


public partial class Investigation_InvestigationQuickApprovel : BasePage
{
    public Investigation_InvestigationQuickApprovel()
        : base("Investigation_InvestigationQuickApprovel_aspx")
    {
    }

    int currentPageNo = 1;
    int PageSize = 1;
    int totalRows = 0;
    int totalpage = 0;
    long taskid = 0;
    string reportPath = string.Empty;

    /*Task Filter Variables*/
    string TaskDate = "-1";
    string category = "-1";
    int specId = -1;
    int DeptID = -1;
    string PatientNumber = "-1";
    int InvLocationID = 0;
    string Preference = "ALL";
    long retval = -1;
    Boolean CompletedFlag = false;
    Patient_BL patientBL;
    Investigation_BL InvestigationBL;
    Investigation_BL DemoBL;
    long patientID = 0;
    long visitID = 0;
    long tID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            List<InvStatusmapping> lstInvStatusmapping = new List<InvStatusmapping>();
            InvestigationBL = new Investigation_BL();
            if (!IsPostBack)
            {
                if (RoleName == RoleHelper.ChiefPathologist)
                {
                    tdCaptureRemarks.Attributes.Add("style", "display:block");
                    btnApprove.Text = "Release Report";
                    vtnEdit.Attributes.Add("style", "display:none");
                    LinkButton2.Attributes.Add("style", "display:none");
                    lnkFullReport.Attributes.Add("style", "display:none");
                }
                else
                {
                    tdCaptureRemarks.Attributes.Add("style", "display:none");
                    vtnEdit.Attributes.Add("style", "display:block");
                    LinkButton2.Attributes.Add("style", "display:block");
                    lnkFullReport.Attributes.Add("style", "display:block");
                }
                if (Request.QueryString["taskid"] != null)
                {
                    hdnTaskID.Value = Request.QueryString["taskid"].ToString();
                }
                if (Request.QueryString["QADeptId"] != null)
                {
                    int deptID = -1;
                    int.TryParse(Request.QueryString["QADeptId"].ToString(), out deptID);
                    GetDeptDetails(deptID);
                }
                else
                {
                    GetDeptDetails(-1);
                }
                if (Request.QueryString["QAPageNo"] != null)
                {
                    int pageNo = 1;
                    int.TryParse(Request.QueryString["QAPageNo"].ToString(), out pageNo);
                    retval = InvestigationBL.pGetQuickApprovelForCompletedStatus(OrgID, out lstInvStatusmapping);
                    if (lstInvStatusmapping.Count > 0)
                    {
                        CompletedFlag = true;
                    }
                    LoadGrid(pageNo, PageSize, true);
                }
                else
                {
                    retval = InvestigationBL.pGetQuickApprovelForCompletedStatus(OrgID, out lstInvStatusmapping);
                    if (lstInvStatusmapping.Count > 0)
                    {
                        CompletedFlag = true;
                    }
                    LoadGrid(currentPageNo, PageSize, false);
                }
            }
            retval = InvestigationBL.pGetQuickApprovelForCompletedStatus(OrgID, out lstInvStatusmapping);
            if (lstInvStatusmapping.Count > 0)
            {
                CompletedFlag = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading report for print", ex);
        }
    }

    protected void ddlDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            currentPageNo = 1;
            PageSize = 1;
            totalRows = 0;
            totalpage = 0;
            taskid = 0;
            hdnCurrentPage.Value = currentPageNo.ToString();
            hdnCurrent.Value = currentPageNo.ToString();
            TaskOpen();
            LoadGrid(currentPageNo, PageSize, false);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading report for print", ex);
        }
    }

    private void GetDeptDetails(int deptID)
    {
        try
        {
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            List<Speciality> lstSpeciality = new List<Speciality>();
            List<TaskActions> lstCategory = new List<TaskActions>();
            List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
            List<ClientMaster> lstClient = new List<ClientMaster>();
            List<MetaData> lstProtocal = new List<MetaData>();
            TaskProfile taskProfile = new TaskProfile();
            taskProfile.Type = "Task";
            retval = -1;
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient, out lstProtocal);
            LoadDept(lstDept, taskProfile, deptID);
            SetTasksFilter(lstLocation, lstSpeciality, lstCategory, taskProfile, lstDept, lstClient);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting department details", ex);
        }
    }

    private void LoadDept(List<InvDeptMaster> lstDept, TaskProfile taskProfile, int deptID)
    {
        try
        {
            string strAll = Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_07 == null ? "(ALL)" : Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_07;
            ddlDept.DataSource = lstDept;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();
            ddlDept.Items.Insert(0, strAll.Trim());
            ddlDept.Items[0].Value = "0";
            if (taskProfile.DeptID.ToString() != "-1")
            {
                ddlDept.SelectedValue = taskProfile.DeptID.ToString();
            }
            if (deptID != -1)
            {
                ddlDept.SelectedValue = deptID.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading department details", ex);
        }
    }

    public void SetTasksFilter(List<OrganizationAddress> lstLocation, List<Speciality> lstSpeciality,
       List<TaskActions> lstCategory,
       TaskProfile taskProfile, List<InvDeptMaster> lstDept, List<ClientMaster> lstClient)
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
            if (lstClient != null)
            {
                foreach (ClientMaster clientid in lstClient)
                {
                    if (clientid != null)
                    {
                        hdnSelectedClientID.Value = clientid.ClientID.ToString();
                    }

                }
            }


        }
        catch (Exception e)
        {
            CLogger.LogError("Error in QuickApproval Load Default Task Items", e);
        }
    }

    List<TaskDetails> lstTasks = new List<TaskDetails>();
    public void LoadGrid(int currentPageNo, int PageSize, bool fromEdit)
    {
        retval = -1;

        Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);

        TaskDate = hdnTaskDate.Value;
        category = hdncategory.Value;
        Int32.TryParse(hdnspecId.Value, out specId);
        Int32.TryParse(hdnInvLocationID.Value, out InvLocationID);


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

        lstTrustedOrgActions.Add(objTrustedOrgActions);

        base.ContextInfo.AdditionalInfo = hdnTaskID.Value == "" ? "-1" : hdnTaskID.Value;
        PageSize = hdnTaskID.Value == "" ? 1 : 2;

        string sDept = ddlDept.SelectedValue == "" || ddlDept.SelectedValue == "0" ? "-1" : ddlDept.SelectedValue;
        int ClientID = -1;
        if (hdnSelectedClientID.Value != "0")
        {
            ClientID = Convert.ToInt32(hdnSelectedClientID.Value);
            // Session["ClientID"] = ClientID;
        }
        else
        {
            ClientID = -1;
        }
        if (!int.TryParse(sDept, out DeptID))
        {
            DeptID = -1;
        }
        if (hdnInvLocationID.Value != "")
        {
            ILocationID = Convert.ToInt32(hdnInvLocationID.Value);
        }
        else
        {
            ILocationID = -1;
        }
        if (Request.QueryString["Pid"] != null)
        {
            patientID = Convert.ToInt64(Request.QueryString["Pid"]);
        }
        if (Request.QueryString["Vid"] != null)
        {
            visitID = Convert.ToInt64(Request.QueryString["Vid"]);
        }
        if (Request.QueryString["tid"] != null)
        {
            tID = Convert.ToInt64(Request.QueryString["tid"]);
        }
        if (RoleName == RoleHelper.ChiefPathologist && patientID > 0 && visitID > 0 && tID > 0)
        {
            retval = tasksBL.GetTestForApprovel(RoleID, OrgID, LID, TaskDate, category, ILocationID, specId, PatientNumber,
        out lstTasks, InvLocationID, currentPageNo, PageSize, out totalRows, DeptID, ClientID, objLoginDetail, lstTrustedOrgActions, Preference,
        patientID, visitID, tID);
        }
        else if (RoleName == RoleHelper.ChiefPathologist && patientID == 0 && visitID == 0 && tID == 0)
        {
            retval = tasksBL.GetTestForApprovel(RoleID, OrgID, LID, TaskDate, category, ILocationID, specId, PatientNumber,
        out lstTasks, InvLocationID, currentPageNo, PageSize, out totalRows, DeptID, ClientID, objLoginDetail, lstTrustedOrgActions, Preference,
        patientID, visitID, tID);
        }
        else
        {
            retval = tasksBL.GetTestForApprovel(RoleID, OrgID, LID, TaskDate, category, ILocationID, specId, PatientNumber,
            out lstTasks, InvLocationID, currentPageNo, PageSize, out totalRows, DeptID, ClientID, objLoginDetail, lstTrustedOrgActions, Preference);
        }

        if (fromEdit && currentPageNo > totalRows)
        {
            currentPageNo = 1;
            retval = tasksBL.GetTestForApprovel(RoleID, OrgID, LID, TaskDate, category, ILocationID, specId, PatientNumber,
            out lstTasks, InvLocationID, currentPageNo, PageSize, out totalRows, DeptID, ClientID, objLoginDetail, lstTrustedOrgActions, Preference);
        }

        ClearValues();
        totalpage = totalRows;
        if (totalpage > 0)
        {
            GrdInv.Visible = true;
        } 
        
        lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        hdnTotalPage.Value = lblTotal.Text;
        if (hdnCurrent.Value == "")
        {
            lblCurrent.Text = currentPageNo.ToString();
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            lblCurrent.Text = hdnCurrent.Value;
            currentPageNo = Convert.ToInt32(hdnCurrent.Value);
        }
        hdnCurrentPage.Value = lblCurrent.Text;
        if (currentPageNo == 1)
        {
            Btn_Previous.Enabled = false;

            if (Int32.Parse(lblTotal.Text) > 1)
            {
                Btn_Next.Enabled = true;
            }
            else
            {
                Btn_Next.Enabled = false;
            }
        }

        else
        {
            Btn_Previous.Enabled = true;

            if (currentPageNo == Int32.Parse(lblTotal.Text))
                Btn_Next.Enabled = false;
            else Btn_Next.Enabled = true;
        }
        if (retval == 0 && lstTasks.Count > 0)
        {
            lnkFullReport.Attributes.Add("onclick", "return ShowReportPreview('" + lstTasks[0].PatientVisitID + "','" + RoleID + "','all');return false;");
            trResult.Attributes.Add("style", "display:none");
            ACX3responses2.Attributes.Add("style", "display:table");
            BindData(lstTasks);

            //trTimedSamples.Attributes.Add("style", "display:block");

        }
        else
        {
            //trTimedSamples.Attributes.Add("style", "display:none");
            NoResult();
        }

    }
    private void NoResult()
    {
        trResult.Attributes.Add("style", "display:table");
        ACX3responses2.Attributes.Add("style", "display:none");
        grdTasks.Visible = false;
        divFooterNav.Visible = false;
        GrdInv.Visible = false;
    }
    private void BindData(List<TaskDetails> lstTasks)
    {
        grdTasks.Visible = true;
        divFooterNav.Visible = true;
        grdTasks.DataSource = lstTasks;
        grdTasks.DataBind();
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        int ar = 0;
        hdnCurrent.Value = txtpageNo.Text;
        if (txtpageNo.Text != "")
        {
            ar = Convert.ToInt32(txtpageNo.Text);
        }
        else
        {
            return;
        }

        if (ar != 0)
        {

            LoadGrid(Convert.ToInt32(txtpageNo.Text), PageSize, false);
        }

        txtpageNo.Text = "";


    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {

        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        TaskOpen();
        LoadGrid(currentPageNo, PageSize, false);

    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {

            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        TaskOpen();
        LoadGrid(currentPageNo, PageSize, false);


    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void grdTasks_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex >= 0)
        {
            grdTasks.PageIndex = e.NewPageIndex;

            LoadGrid(currentPageNo, PageSize, false);
        }
    }


    protected void GrdInv_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string strRR = Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_03 == null ? "RR" : Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_03;
        string strRC = Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_04 == null ? "RC" : Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_04;
        string strRF = "RF";
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");

            if (lblStatus.Text == "Recheck")
            {
                lblStatus.Text = strRR.Trim();
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "Retest")
            {
                lblStatus.Text = strRC.Trim();
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == "ReflexTest")
            {
                lblStatus.Text = strRF.Trim();
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lblStatus.Visible = false;
            }
        }
    }
    protected void grdTasks_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TaskDetails t = (TaskDetails)e.Row.DataItem;
            List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();
            DemoBL = new Investigation_BL(base.ContextInfo);

            long pVisitID = -1;
            long pRoleID = -1;
            string invStatus = string.Empty;
            string actionType = string.Empty;
            actionType = "showreport";
            if (CompletedFlag == true)
            {
                if (RoleName == RoleHelper.ChiefPathologist)
                {
                    invStatus = "approve";
                }
                else
                {
                    invStatus = "completed,partiallycompleted,validate,partiallyvalidated,coauthorize";
                } 
            }
            else
            {
                invStatus = "validate,partiallycompleted,partiallyvalidated,coauthorize";
            }

            //invStatus = "completed,validate,approve,Pending";
            pVisitID = t.PatientVisitID;
            pRoleID = t.RoleID;
            hdnRedirectURL.Value = t.RedirectURL;

            hdniPatientID.Value = Convert.ToString(t.PatientID);
            hdniVisitID.Value = Convert.ToString(t.PatientVisitID);
            hdniTaskID.Value = Convert.ToString(t.TaskID);
            hdniPageUrl.Value = t.RedirectURL;
            hdniName.Value = t.Name;
            hdniOrgid.Value = Convert.ToString(t.OrgID);
            hdnRNo.Value = t.RefernceID;
            hdnlabNo.Value = t.RefernceID;
            string GUID = string.Empty;
            GUID = t.SpecialityName;


            //PatientDetail.LoadPatientDetails(pVisitID, OrgID, GUID);

            DemoBL.pGetpatientInvestigationForVisit(pVisitID, OrgID, ILocationID, GUID, out lstorderInvforVisit);
            if (lstorderInvforVisit.Count > 0)
            {

                GrdInv.DataSource = lstorderInvforVisit;
                GrdInv.DataBind();
                CheakInv.Style.Add("display", "block");

                bool pIsAttachmentMandatory = false;
                bool pHasAttachment = false;
                DemoBL.CheckInvImageAttachmentMandatory(OrgID, pVisitID, out pIsAttachmentMandatory, out pHasAttachment);
                if (pIsAttachmentMandatory && !pHasAttachment)
                {
                    lblAttachmentMandatory.Style.Add("display", "block");
                }
                else
                {
                    lblAttachmentMandatory.Style.Add("display", "none");
                }
            }
            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
            if (tbl.isTaskAlreadyPicked(t.TaskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
            {
            }

            if (pVisitID > 0 && pRoleID > 0)
            {
                frameReportPreview.Attributes["src"] = "PrintVisitDetails.aspx?vid=" + Convert.ToInt64(pVisitID) + "&roleid=" + pRoleID + "&type=showreport&PageValue=QA&invstatus=" + invStatus + "&DeptFilter=Y&#toolbar=0&navpanes=0";

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "GetGUID();", true);


        }
    }
    public void LoadReport(long pVisitID, List<string> invStatus)
    {

        ReportUtil RR = new ReportUtil();
        List<InvReportMaster> lstReports = new List<InvReportMaster>();
        List<InvReportMaster> lstGroupedReports = new List<InvReportMaster>();
        List<InvReportMaster> lstFilterdReports = new List<InvReportMaster>();



        lstReports = RR.GetReportList(pVisitID, OrgID, ILocationID, invStatus,"","","");

        if (lstReports.Count > 0)
        {
            IEnumerable<InvReportMaster> FilterValue = (from list in lstReports
                                                        group list by new
                                                        {
                                                            list.PatientVisitID,
                                                            list.TemplateID,
                                                            list.ReportTemplateName

                                                        } into g1
                                                        select new InvReportMaster
                                                        {
                                                            PatientVisitID = g1.Key.PatientVisitID,
                                                            TemplateID = g1.Key.TemplateID,
                                                            ReportTemplateName = g1.Key.ReportTemplateName

                                                        }).ToList();

            foreach (InvReportMaster ob in FilterValue)
            {
                lstGroupedReports.Add(ob);

            }

            foreach (InvReportMaster Obj in lstGroupedReports)
            {
                lstFilterdReports = lstReports.FindAll(p => p.TemplateID == Obj.TemplateID && p.PatientVisitID == Obj.PatientVisitID).ToList();

            }
        }
    }

    protected void grdTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            long returnCode = -1;
            long iPatientID = -1;
            long iVisitID = -1;
            long iTaskID = -1;
            string iName = string.Empty;
            string iGuid = string.Empty;
            string iPageUrl = string.Empty;
            int iOrgid = 0;
            string RNo = string.Empty;
            string labNo = string.Empty;

            if (e.CommandName == "Approve")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][2]);
                iName = grdTasks.DataKeys[RowIndex][4].ToString();
                iGuid = hdnGuid.Value;
                List<InvOrgAuthorization> lstInvAuthorization = new List<InvOrgAuthorization>();
                int taskActionID = 0;
                returnCode = DoAction(iTaskID, iVisitID, iGuid, iName, out lstInvAuthorization, out taskActionID);
                if (returnCode == 0)
                {
                    new Tasks_BL().UpdateCurrentTask(iTaskID, TaskHelper.TaskStatus.Completed, LID, "QApprovel");
                    //string AlertMesg = "Test for the Patient '" + iName + "' has been Approved.";
                    //string PageUrl = Request.ApplicationPath + @"/Investigation/InvestigationQuickApprovel.aspx";

                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                }
                LoadGrid(currentPageNo, PageSize, false);
            }
            if (e.CommandName == "Edit")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][2]);
                iPageUrl = grdTasks.DataKeys[RowIndex][3].ToString();
                iName = grdTasks.DataKeys[RowIndex][4].ToString();
                iOrgid = Convert.ToInt32(grdTasks.DataKeys[RowIndex][9]);
                RNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                labNo = Convert.ToString(grdTasks.DataKeys[RowIndex][10]);
                iGuid = hdnGuid.Value;
                if (RNo != null && RNo != "")
                {
                    iPageUrl = iPageUrl + "&RNo=" + RNo;
                }
                //iPageUrl.Remove(0,5);

                iPageUrl = iPageUrl.Replace("~\\Investigation\\", "");
                //iframeplaceholderEdit.Attributes["src"] = iPageUrl + "&#toolbar=0&navpanes=0";
                Response.Redirect(iPageUrl + "&POrgID=" + iOrgid + "&apptype=" + "Yes"
                    + "&TaskID=" + iTaskID, true);
                //Response.Redirect(iPageUrl + "&POrgID=" + iOrgid, true);

                //iframeplaceholderEdit.Attributes["src"] = "PrintVisitDetails.aspx?vid=" + Convert.ToInt64(pVisitID) + "&roleid=" + pRoleID + "&type=showreport&invstatus=" + invStatus + "&#toolbar=0&navpanes=0";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Task", ex);
        }
    }

    public long DoAction(long TaskID, long vid, string gUID, string pName, out List<InvOrgAuthorization> lstInvAuthorization, out int taskActionID)
    {

        long returnCode = -1;
        patientBL = new Patient_BL(base.ContextInfo);
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        List<PatientVisit> visitList = new List<PatientVisit>();
        List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();
        string invStatus = "";
        if (CompletedFlag == true)
        {
            if (RoleName == RoleHelper.ChiefPathologist)
            {
                invStatus = "approve";
            }
            else
            {
                invStatus = "completed,partiallycompleted,validate,partiallyvalidated,coauthorize";
            }
        }
        else
        {
            invStatus = "partiallycompleted,validate,partiallyvalidated,coauthorize";
        }


        List<string> lstInvStatus = new List<string>();
        string[] lstStatus = invStatus.Split(',');
        if (lstStatus != null && lstStatus.Length > 0)
        {
            foreach (string oInvStauts in lstStatus)
            {
                if (oInvStauts.ToLower() == "approve")
                {
                    lstInvStatus.Add(InvStatus.Approved);
                }
                else if (oInvStauts.ToLower() == "completed")
                {
                    lstInvStatus.Add(InvStatus.Completed);
                }
                else if (oInvStauts.ToLower() == "validate")
                {
                    lstInvStatus.Add(InvStatus.Validate);
                }
                else if (oInvStauts.ToLower() == "partiallyvalidated")
                {
                    lstInvStatus.Add(InvStatus.PartiallyValidated);
                }
                else if (oInvStauts.ToLower() == "coauthorize")
                {
                    lstInvStatus.Add(InvStatus.Coauthorize);
                }
		else if (oInvStauts.ToLower() == "partiallycompleted")
                {
                    lstInvStatus.Add("PartiallyCompleted");
                }
            }
        }


        InvestigationBL.pGetpatientInvestigationForVisit(vid, OrgID, ILocationID, gUID, out lstorderInvforVisit);
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        string sDept = ddlDept.SelectedValue == "" || ddlDept.SelectedValue == "0" ? "-1" : ddlDept.SelectedValue;
        int DeptID = -1;
        if (!int.TryParse(sDept, out DeptID))
        {
            DeptID = -1;
        }
        if (DeptID == -1)
        {
            Master_BL objMasterBL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = objMasterBL.GetLoginDept(Convert.ToInt32(LID), OrgID, Convert.ToInt32(RoleID), out lstDept);
        }
        else
        {
            InvDeptMaster oInvDeptMaster = new InvDeptMaster();
            oInvDeptMaster.DeptID = DeptID;
            lstDept.Add(oInvDeptMaster);
        }
        var lstFilterReports = from item1 in lstorderInvforVisit
                               join item2 in lstDept
                 on item1.ID equals item2.DeptID
                               select item1;
        List<OrderedInvestigations> lstFilterReport = lstFilterReports.ToList();
        lstorderInvforVisit = (from child in lstFilterReport
                               where lstInvStatus.Contains(child.Status)
                               select child).ToList();
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        lstInvAuthorization = new List<InvOrgAuthorization>();
        returnCode = InvestigationBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
        returnCode = InvestigationBL.GetInvAuthorizationList(vid, OrgID, out lstInvAuthorization);

        List<PatientInvestigation> lstInvestigation;
        List<PatientInvestigation> lstAuthorization = new List<PatientInvestigation>();
        taskActionID = 0;
        Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
        List<Tasks> lstTasks = new List<Tasks>();
        oTasksBL.GetTaskID(TaskID, out lstTasks);
        if (lstTasks != null && lstTasks.Count > 0)
        {
            taskActionID = lstTasks[0].TaskActionID;
        }
        List<PatientInvestigation> lstResult = new List<PatientInvestigation>();
        foreach (OrderedInvestigations Obj in lstorderInvforVisit)
        {
            var lstCoauth = (from PI in lstInvAuthorization
                             where PI.RoleName == "N"
                             select PI).ToList();

            lstPatientInvestigation.RemoveAll(a => lstCoauth.Exists(W => W.InvestigationID == a.InvestigationID));
            if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Coauthorize))
            {
                if (CompletedFlag == true)
                {
                    if (RoleName == RoleHelper.ChiefPathologist)
                    {
                        lstInvestigation = (from PI in lstPatientInvestigation
                                            where PI.AccessionNumber == Obj.AccessionNumber &&
                                            (PI.Status == InvStatus.Approved)
                                            select PI).ToList();
                    }
                    else
                    {
                        lstInvestigation = (from PI in lstPatientInvestigation
                                            where PI.AccessionNumber == Obj.AccessionNumber &&
                                            (PI.Status == InvStatus.Completed || PI.Status == InvStatus.Validate || PI.Status == InvStatus.PartiallyValidated || PI.Status == "PartiallyCompleted")
                                            select PI).ToList();
                    }
                }
                else
                {
                    lstInvestigation = (from PI in lstPatientInvestigation
                                        where PI.AccessionNumber == Obj.AccessionNumber &&
                                        (PI.Status == InvStatus.Validate || PI.Status == InvStatus.PartiallyValidated)
                                        select PI).ToList();
                }

                if (lstInvestigation != null && lstInvestigation.Count > 0)
                {
                    lstAuthorization = (from PI in lstInvestigation
                                        join IA in lstInvAuthorization on PI.InvestigationID equals IA.InvestigationID
                                        where IA.RoleName != "N"
                                        select PI).ToList();
                }
                foreach (PatientInvestigation oPatientInvestigation in lstInvestigation)
                {
                    if (lstAuthorization.Exists(P => P.InvestigationID == oPatientInvestigation.InvestigationID && P.AccessionNumber == oPatientInvestigation.AccessionNumber))
                    {
                        oPatientInvestigation.Status = InvStatus.Coauthorize;
                    }
                    else
                    {
                        /*Added by Arivalagan.k*/
                        if (CompletedFlag == true)
                        {
                            switch (oPatientInvestigation.Status)
                            {
                                case InvStatus.Completed:
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break;
                                case "PartiallyCompleted":
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break;
                                case InvStatus.Validate:
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break;
                                    // This is only for IsSensitve Test 
                                case InvStatus.Approved:
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break; 
                                default:
                                    oPatientInvestigation.Status = InvStatus.PartialyApproved;
                                    break;
                            }
                        }
                        else
                        {

                            switch (oPatientInvestigation.Status)
                            {
                                //case InvStatus.Completed:
                                //    oPatientInvestigation.Status = InvStatus.Approved;
                                //    break;
                                case InvStatus.Validate:
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break;
                                // This is only for IsSensitve Test
                                case InvStatus.Approved:
                                    oPatientInvestigation.Status = InvStatus.Approved;
                                    break;
                                default:
                                    oPatientInvestigation.Status = InvStatus.PartialyApproved;
                                    break;
                            }
                            //if (oPatientInvestigation.Status == InvStatus.Validate)
                            //{
                            //    oPatientInvestigation.Status = InvStatus.Approved;
                            //}
                            //else
                            //{
                            //    oPatientInvestigation.Status = InvStatus.PartialyApproved;
                            //}

                        }
                        /*Added by Arivalagan.k*/
                    }
                    oPatientInvestigation.ApprovedBy = LID;
                    oPatientInvestigation.AuthorizedBy = 0;
                    lstResult.Add(oPatientInvestigation);
                }
            }
            else
            {
                lstInvestigation = (from PI in lstPatientInvestigation
                                    where PI.AccessionNumber == Obj.AccessionNumber && (PI.Status == InvStatus.Coauthorize)
                                    select PI).ToList();
                foreach (PatientInvestigation oPatientInvestigation in lstInvestigation)
                {
                    oPatientInvestigation.Status = InvStatus.Approved;
                    oPatientInvestigation.AuthorizedBy = LID;
                    oPatientInvestigation.ApprovedBy = 0;
                    lstResult.Add(oPatientInvestigation);
                }
            }
        }
        returnCode = InvestigationBL.SaveQuickApprovalInvestigationResults(lstResult);
        //-------------Added by Prabakar-----------------//
        // CreatedAt 10/09/2013 2.00
        // Feature-Auto Email Service configured for Quick approvel Action
        int cnt = 0;
        int cntPA = 0;
        int cntWH = 0;
        int cntRJ = 0;
        cnt = lstResult.FindAll(p => p.Status == "Approve").Count();
        cntPA = lstResult.FindAll(p => p.Status == "PartiallyApproved").Count();
        cntWH = lstResult.FindAll(p => p.Status == "With Held").Count();
        cntRJ = lstResult.FindAll(p => p.Status == "Reject").Count();
        InvestigationBL.pGetpatientInvestigationForVisit(vid, OrgID, ILocationID, gUID, out lstorderInvforVisit);
        //InvestigationBL.pGetpatientInvestigationForVisit(vid, OrgID, ILocationID, gUID, out lstorderInvforVisit);
        bool IsResult = false;
        var PkgId = (from grp in lstorderInvforVisit
                     where grp.IsCoPublish == "Y" && grp.PkgID != 0
                     select grp.PkgID).Distinct().ToList();

        List<string> lstInvStatusNotify = new List<string>();
        lstInvStatusNotify.Add("approve");
        lstInvStatusNotify.Add("partiallyapproved");
        int NonCoPublishTestCount = (from grp in lstorderInvforVisit
                                     where grp.IsCoPublish != "Y" && grp.PkgID >= 0 && lstInvStatusNotify.Contains(grp.Status.ToLower())
                                     select grp).Count();

        if (NonCoPublishTestCount == 0)
        {
            foreach (var item in PkgId)
            {
                int CoPublishPkgCount = (from grp in lstorderInvforVisit
                                         where grp.IsCoPublish == "Y" && grp.PkgID != 0 && grp.PkgID == item
                                         select grp).Count();
                int CoPublishPkgApprovalCount = (from grp in lstorderInvforVisit
                                                 where grp.IsCoPublish == "Y" && grp.PkgID != 0 && lstInvStatusNotify.Contains(grp.Status.ToLower()) && grp.PkgID == item
                                                 select grp).Count();
                if (CoPublishPkgCount == CoPublishPkgApprovalCount)
                {
                    IsResult = true;
                    break;
                }
            }
        }
        if (cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
        {
            if ((NonCoPublishTestCount > 0) || (IsResult == true))
            {
                ActionManager AM = new ActionManager(base.ContextInfo);
                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                PageContextkey PC = new PageContextkey();
                PC.ID = Convert.ToInt64(ILocationID);
                PC.PatientID = Convert.ToInt64(hdniPatientID.Value);
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = OrgID;
                PC.PatientVisitID = vid;
                PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                PC.ButtonName = PageContextDetails.ButtonName;
                PC.ButtonValue = PageContextDetails.ButtonValue;
                if (PC.ActionType == null)
                {
                    PC.ActionType = "";
                }
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
            }
        }
        //-------------End-----------------//
        //  SetDispatchItems(vid);
        return returnCode;
    }
    public void SetDispatchItems(long vid)
    {
        try
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PatientVisitID = vid;
            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
            if (PC.ActionType == null)
            {
                PC.ActionType = "";
            }
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC, "", "");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SetDispatchItems " + vid, ex);
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
            returncode = objGateway.GetConfigDetails(strConfigKey, Convert.ToInt32(OrgID), out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }


    protected void btnGo_ClickApprove(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            long returnCode = -1;
            long iPatientID = -1;
            long iVisitID = -1;
            long iTaskID = -1;
            string iName = string.Empty;
            string iGuid = string.Empty;
            string iPageUrl = string.Empty;
            int iOrgid = 0;
            string RNo = string.Empty;
            string labNo = string.Empty;
            string patienthistory = String.Empty;
            string remarks = String.Empty;

            iPatientID = Convert.ToInt32(hdniPatientID.Value);
            iVisitID = Convert.ToInt32(hdniVisitID.Value);
            iTaskID = Convert.ToInt32(hdniTaskID.Value);
            iName = hdniName.Value.ToString();
            iGuid = hdnGuid.Value;
            RNo = hdnRNo.Value;
            labNo = hdnlabNo.Value;
            if(!String.IsNullOrEmpty(hdnpatienthistory.Value))
            {
            patienthistory = hdnpatienthistory.Value;
            }
            if(!String.IsNullOrEmpty(hdnremarks.Value))
            {
            remarks = hdnremarks.Value;
            }
            List<InvOrgAuthorization> lstInvAuthorization = new List<InvOrgAuthorization>();
            int taskActionID = 0;
            returnCode = DoAction(iTaskID, iVisitID, iGuid, iName, out lstInvAuthorization, out taskActionID);
            if (returnCode == 0)
            {

                base.ContextInfo.AdditionalInfo = "QApprovel";
                List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();
                InvestigationBL.pGetpatientInvestigationForVisit(iVisitID, OrgID, ILocationID, iGuid, out lstorderInvforVisit);
                bool isTaskOpen = true;
                string TASKSTATUS = string.Empty;
                TASKSTATUS = GetConfigValues("DeptwiseLoginRole", OrgID);
                if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Coauthorize))
                {
                    int nonApprovedCount = (from IL in lstorderInvforVisit
                                            where
                                            IL.Status != InvStatus.Approved &&
                                            IL.Status != InvStatus.Coauthorize &&
                                            IL.Status != InvStatus.SecondOpinion &&
                                            IL.Status != InvStatus.OpinionGiven &&
                                            IL.Status != InvStatus.Coauthorized &&
                                            IL.Status != InvStatus.PartialyApproved &&
                                            IL.Status != InvStatus.WithHeld &&
                                            IL.Status != InvStatus.Cancel &&
                                            IL.Status != InvStatus.Completed && 
											IL.Status != "PartiallyCompleted"
                                            select IL).Distinct().Count();
                    
                    if (TASKSTATUS == "Y")
                    {
                        nonApprovedCount = (from IL in lstorderInvforVisit
                                            where
                                            IL.Status != InvStatus.Approved &&
                                            IL.Status != InvStatus.Coauthorize &&
                                            IL.Status != InvStatus.SecondOpinion &&
                                            IL.Status != InvStatus.OpinionGiven &&
                                            IL.Status != InvStatus.Coauthorized &&
                                            IL.Status != InvStatus.PartialyApproved &&
                                            IL.Status != InvStatus.WithHeld &&
                                            IL.Status != InvStatus.Cancel
                                            select IL).Distinct().Count();
                    }

                    if (nonApprovedCount <= 0)
                    {
                        isTaskOpen = false;
                    }
                    int CoauthorizeCount = lstorderInvforVisit.FindAll(o => o.Status == InvStatus.Coauthorize).Distinct().Count();
                    if (CoauthorizeCount > 0)
                    {
                        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(iVisitID, out lstPatientVisitDetails);
                        List<long> lstCoauthorizeUser = (from IA in lstInvAuthorization
                                                         select IA.UserID).Distinct().ToList();
                        List<Tasks> lstGroupTask = new List<Tasks>();
                        Tasks task;
                        Hashtable dText = new Hashtable();
                        Hashtable urlVal = new Hashtable();
                        long createTaskID = -1;
                        foreach (long oLoginID in lstCoauthorizeUser)
                        {
                            task = new Tasks();
                            returnCode = Attune.Podium.Common.Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Coauthorize),
                                    iVisitID, 0, iPatientID, lstPatientVisitDetails[0].TitleName + " " +
                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                    iGuid, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Coauthorize);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.AssignedTo = oLoginID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = iVisitID;
                            task.PatientID = iPatientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.RefernceID = RNo;

                            lstGroupTask.Add(task);
                        }
                        if (lstGroupTask != null && lstGroupTask.Count > 0)
                        {
                            //Create task        
                            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                            returnCode = oTasksBL.CreateGroupTask(lstGroupTask, out createTaskID);
                        }
                    }
                }
                else
                {
                    isTaskOpen = false;
                }
		if(taskActionID == Convert.ToInt16(TaskHelper.TaskAction.Release))
                {
                    isTaskOpen=false;
                }
                if (isTaskOpen)
                {
                    new Tasks_BL(base.ContextInfo).UpdateTask(iTaskID, TaskHelper.TaskStatus.Pending, LID);
                }
                else
                {
                    new Tasks_BL(base.ContextInfo).UpdateTask(iTaskID, TaskHelper.TaskStatus.Completed, LID);
                }
            }
            int totalPage = 0;
            int.TryParse(hdnTotalPage.Value, out totalPage);
            int currentPage = 0;
            int.TryParse(hdnCurrent.Value, out currentPage);
            hdnCurrent.Value = "";
            if (totalPage == currentPage)
            {
                LoadGrid(currentPageNo, PageSize, false);
            }
            else
            {
                LoadGrid(currentPage, PageSize, false);
            }
            if (RoleName == RoleHelper.ChiefPathologist)
            {
                if (!String.IsNullOrEmpty(patienthistory) || !String.IsNullOrEmpty(remarks))
                {
                    returnCode = InvestigationBL.SaveSensitiveTestRemarks(iVisitID, iPatientID, iTaskID, patienthistory, remarks);
                }

                hdnpatienthistory.Value = "";
                hdnremarks.Value = "";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('Saved Succesfully');", true);

                string path = string.Empty;
                List<Attune.Podium.BusinessEntities.Role> role = new List<Attune.Podium.BusinessEntities.Role>();
                Attune.Podium.BusinessEntities.Role roleid = new Attune.Podium.BusinessEntities.Role();
                roleid.RoleID = RoleID;
                role.Add(roleid);
                new Navigation().GetLandingPage(role, out path);
                if (path != string.Empty)
                {
                    Response.Redirect(Request.ApplicationPath + path);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Task", ex);
        }
    }
    protected void btnGo_ClickEdit(object sender, EventArgs e)
    {
        try
        {
            long iPatientID = -1;
            long iVisitID = -1;
            long iTaskID = -1;
            string iName = string.Empty;
            string iGuid = string.Empty;
            string iPageUrl = string.Empty;
            int iOrgid = 0;
            string RNo = string.Empty;
            string labNo = string.Empty;

            iPatientID = Convert.ToInt32(hdniPatientID.Value);
            iVisitID = Convert.ToInt32(hdniVisitID.Value);
            iTaskID = Convert.ToInt32(hdniTaskID.Value);
            iPageUrl = hdniPageUrl.Value.ToString();
            iName = hdniName.Value.ToString();
            iOrgid = OrgID;
            RNo = Convert.ToString(hdnRNo.Value);
            labNo = Convert.ToString(hdnlabNo.Value);
            iGuid = hdnGuid.Value;
            if (RNo != null && RNo != "")
            {
                iPageUrl = iPageUrl + "&RNo=" + RNo;
            }
            iPageUrl.Remove(0, 5);

            iPageUrl = iPageUrl.Replace("~\\Investigation\\", "");
            iframeplaceholderEdit.Attributes["src"] = iPageUrl + "&#toolbar=0&navpanes=0";
            Response.Redirect(iPageUrl + "&POrgID=" + iOrgid + "&apptype=" + "Yes"
                + "&TaskID=" + iTaskID + "&QAPageNo=" + hdnCurrent.Value + "&QADeptId=" + ddlDept.SelectedValue, true);
            Response.Redirect(iPageUrl + "&POrgID=" + iOrgid, true);

            //iframeplaceholderEdit.Attributes["src"] = "PrintVisitDetails.aspx?vid=" + Convert.ToInt64(pVisitID) + "&roleid=" + pRoleID + "&type=showreport&invstatus=" + invStatus + "&#toolbar=0&navpanes=0";

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Task", ex);
        }
    }
    public void ClearValues()
    {
        hdniPatientID.Value = "";
        hdniVisitID.Value = "";
        hdniTaskID.Value = "";
        hdniPageUrl.Value = "";
        hdniName.Value = "";
        hdniOrgid.Value = "";
        hdnRNo.Value = "";
        hdnlabNo.Value = "";
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
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
        catch (Exception ex)
        {
            CLogger.LogError("Error in redirect", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static void WebTaskOpen(long visitID, long taskID)
    {
        long returncode = -1;
        BaseClass oBaseClass = new BaseClass();
        returncode = new Tasks_BL(oBaseClass.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, oBaseClass.LID, "ReleaseTask");
    }

    private void TaskOpen()
    {
        long returncode = -1;
        long taskID = -1;
        Int64.TryParse(hdniTaskID.Value, out taskID);
        returncode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");

    }

    //public void RaiseCallbackEvent(String eventArgument)
    //{ 
    //    try
    //    { 
    //        TaskOpen(); 

    //    }
    //    catch { }
    //}

    //public string GetCallbackResult()
    //{
    //    string str = "";
    //    return str;
    //}

}
