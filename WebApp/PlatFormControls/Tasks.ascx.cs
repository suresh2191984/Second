using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.TrustedOrg;
using System.Globalization;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class PlatFormControls_Tasks : Attune_BaseControl
{
    public PlatFormControls_Tasks()
        : base("PlatFormControls_Tasks_ascx")
    {}
    private long iPatientID;
    private long PatientOrgId;
    private long iTaskID;
    private string redirectURL;
    private long patientVisitID;
    public long TaskID = -1;
    long returnCode = -1;
    int tStatus = -1;
    int pLabStatus = -1;
    string roleName = string.Empty;
    public string isCashDoctor { get; set; }
    protected string _Chklab = "";
    string IsNeedLabNo = string.Empty;
    string ISMIDDLEEAST = string.Empty;
    string labNo = string.Empty;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string IsNotNeedQuickDiagnosis = string.Empty;
    string SMSLinkYN = string.Empty;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    public string Chklab
    {
        get { return _Chklab; }
        set { _Chklab = value; }
    }

    public CheckBox SetChkBoxVisible
    {
        get { return rdnLabNo; }
        //set { rdnLabNo.Visible = value; }
    }
    public CheckBox ChkBoxServiceNo
    {
        get { return ChkBoxServiceNum; }

    }
    public event EventHandler onTaskLoadComplete;
    public event EventHandler OnPopLoad;
    public string PatientNumber = string.Empty;
    public string Labno = string.Empty;
    public string ServiceNo = string.Empty;

    public void grdview(int ColumnNo, bool Trueorfalse)
    {
        grdTasks.Columns[ColumnNo].Visible = Trueorfalse;
    }


    #region Constants

    private const int PATIENTID_COLUMN = 0;
    private const int TASKID_COLUMN = 1;
    private const int REDIRECTURL_COLUMN = 2;
    private const int PATIENTVISITID_COLUMN = 3;
    private const int TASKDESCRIPTION_COLUMN = 4;
    private const int TASKDATE_COLUMN = 5;
    private const int CATEGORY_COLUMN = 6;

    #endregion

    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompletePatientName.ContextKey = OrgID.ToString();
        lblpatientNameNO.Visible = true;
        txttext.Visible = true;
        btn_Go.Visible = true;
        if (!IsPostBack)
        {
            LoadMeatData();
            showLabNo();
            showSMS();
        }
            ISMIDDLEEAST = GetConfigValue("IsMiddleEast", OrgID);
            IsNeedLabNo = GetConfigValue("NeedLabNo", OrgID);
            IsNotNeedQuickDiagnosis = GetConfigValue("IsNotNeedQuickDiagnosis", OrgID);
            SMSLinkYN = GetConfigValue("NurseSMSLinkReqYN", OrgID);
            if (IsNeedLabNo == "Y")
            {
                if (RoleHelper.LabTech == RoleName || RoleHelper.SrLabTech == RoleName || RoleHelper.Phlebotomist == RoleName)
                {
                    IsNeedLabNo = "Y";
                }
                else
                {
                    IsNeedLabNo = "N";
                    lblLabNumer.Visible = false;
                    txtLabNumer.Visible = false;
                }
            }
        if (!Page.IsPostBack)
        {
            
            lblpatientNameNO.Visible = true;
            txttext.Visible = true;
            btn_Go.Visible = true;
            string value = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_09;
            if (value == null)
            {
                value = "ToDay";
            }
            
            ddTD.SelectedValue = value;
            // All the tasks are retrieved when the page first loads
            //GetData(currentPageNo, PageSize);
            GetLocationAndSpeciality();

            //ddLO.Enabled = false;
            GetTasks(currentPageNo, PageSize);
            // Response.Cookies["style"].Value = "1";

            //string path = HttpContext.Current.Request.Url.AbsolutePath;

            if (Chklab == "1")
            {

                rdnLabNo.Visible = true;
            }


        }

        // string style = Request.Cookies["style"].Value.ToString();
        string strClickHereto = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_28 == null ? "Click Here to" : Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_28;
        if (lblResult.Text.Trim() != "")
        {
            lblResult1.Visible = false;
            btnRefresh.Visible = false;
            btnRefresh1.Visible = true;            
            lblResult.Text = strClickHereto;
        }
        else
        {
            lblResult1.Text = strClickHereto;
            lblResult1.Visible = true;
            btnRefresh.Visible = true;
            btnRefresh1.Visible = false;
        }


    }

    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdTasks.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdTasks.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }

    #endregion

    #region Control Events

    protected void grdTasks_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string IsSkipTasks = "N";
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TaskDetails t = (TaskDetails)e.Row.DataItem;
            //string Physician = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_10;
            //if (Physician == null)
            //{
            //    Physician = "Physician";
            //}
            if (t.Category == "OpthalDiagnosis")
            {
                ImageButton objimg=(ImageButton)e.Row.FindControl("imgQuickDiagnosis");
                if (objimg!=null)
                {
                    objimg.Visible = false;
                }
            }
            string informMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion == null ? "Information" : Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion;
            string DeleteTask = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_13;
            if (DeleteTask == null)
            {
                DeleteTask = "Delete this Task";
            }
            string QuickDiagnosis = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_14;
            if (QuickDiagnosis == null)
            {
                QuickDiagnosis = "Perform Quick Diagnosis";
            }
			 #region coded by kumaresan
            if (t.RoleName == RoleHelper.Physiotherapist)
            {
                //if (e.Row.RowIndex >= 0)
                //{
                grdTasks.Columns[18].Visible = false;
                if (oTaskDetails != null && oTaskDetails.Count > 0)
                {
                    //string specialityname = (oTaskDetails[e.Row.RowIndex].SpecialityName);
                    //string strtemp = GetToolTipProc(t.InvestigationName);
                    //string strtemp = GetToolTipProc(oTaskDetails, specialityname);
                    //e.Row.Cells[5].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    //e.Row.Cells[5].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                }
                //}
            }
            #endregion
            if (t.TaskStatusID == Convert.ToInt32(TaskHelper.TaskStatus.InProgress) && t.ModifiedBy != LID)
            {
              //  e.Row.Visible = false;

                if (t.RoleName != "Physician" && t.RoleName != "Transcriptionist")
                {
                    grdTasks.Columns[14].Visible = false;
                    grdTasks.Columns[8].Visible = false;

                }

                string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_12;
                string Information = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_03;
                if (Information == null)
                {
                    Information = "Information";
                }
                if (sPath == null)
                {
                    sPath = "This task has already been picked by another user";
                }

                e.Row.Cells[4].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                e.Row.Cells[5].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                e.Row.Cells[6].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                     
                             
            }

            else
            {
                if (t.AssignedTo != 0 && t.AssignedTo != LID)
                {
                    //e.Row.Visible = false;
                    if (t.RoleName != "Physician")
                    {
                        grdTasks.Columns[14].Visible = false;
                        grdTasks.Columns[8].Visible = false;
                    }


                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_12;
                    string Information = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_03;
                    if (Information == null)
                    {
                        Information = "Information";
                    }
                    if (sPath == null)
                    {
                        sPath = "This task has already been picked by another user";
                    }

                    e.Row.Cells[4].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                    e.Row.Cells[5].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                    e.Row.Cells[6].Attributes.Add("onclick", "javascript:return ValidationWindow('" + sPath + "','" + Information + "');return false;");
                }


                else
                {
                    
                   
                    e.Row.ToolTip = t.DisplayText;
                    if (!string.IsNullOrEmpty(t.HighlightColor))
                    {

                        e.Row.BackColor = Attune_Helper.GetColor(t.HighlightColor);
                    }
                    if (t.RoleName != "Physician" && t.RoleName != "Transcriptionist")
                    {
                        grdTasks.Columns[14].Visible = false;
                        grdTasks.Columns[8].Visible = false;
                    }
                    if (t.RoleName == "Inventory" || t.RoleName == "Physiotherapist")
                    {
                        grdTasks.Columns[14].Visible = true;
                    }

                    #region Sami Commented the below line
                    // e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                    //e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                    #endregion
                    //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    if (t.TaskActionID != Convert.ToInt16(TaskHelper.TaskAction.CollectSample))
                    {
                        e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                        e.Row.Cells[4].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                        e.Row.Cells[5].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                        e.Row.Cells[6].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                        e.Row.Cells[14].ToolTip = DeleteTask;
                        e.Row.Cells[8].ToolTip = QuickDiagnosis;
                    }
                    e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                    #region Sami Commented the below line
                    // e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                    //e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                    #endregion
                    //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[4].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[5].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[6].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    //  e.Row.Cells[8].ToolTip = "Delete this Task";
                    //  e.Row.Cells[9].ToolTip = "Perform Quick Diagnosis";
                    e.Row.Cells[8].ToolTip = QuickDiagnosis;
                }
                //newly added for assigned task ....
                if (t.AssignedTo != 0)
                {
                    string sPath1 = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_15;
                    if (sPath1 == null)
                    {
                        sPath1 = "This  patient is specifically assigned to you";
                    }
                    e.Row.ToolTip = sPath1;
                    //e.Row.BackColor = System.Drawing.Color.BurlyWood;
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#f4f4f1");

                }
                //end ........
            }
            if (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.ANC))
            {
                if (t.RoleName == "Physician")
                {
                    returnCode = new Tasks_BL(base.ContextInfo).CheckANCNurseTaskStatus(t.PatientVisitID, t.SpecialityID, t.RoleID, out tStatus, out pLabStatus);
                    if (tStatus == 0)
                    {
                        string ToolTipMsg = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_16;
                        if (ToolTipMsg == null)
                        {
                            ToolTipMsg = "Yet to Perform BaseLine Screening";
                        }

                       // e.Row.BackColor = System.Drawing.Color.Orange;
					   e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ffcb80");
                        e.Row.Cells[4].ToolTip = ToolTipMsg;
                        e.Row.Cells[5].ToolTip = ToolTipMsg;
                        e.Row.Cells[6].ToolTip = ToolTipMsg;
                        e.Row.Cells[14].ToolTip = DeleteTask;
                        string userMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_14 == null ? "Yet to Perform BaseLine Screening. Continue?" : Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_14;
                        string okMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Ok == null ? "Ok" : Resources.PlatFormControls_AppMsg.PlatFormControls_Ok;
                        string cancelMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Cancel == null ? "Cancel" : Resources.PlatFormControls_AppMsg.PlatFormControls_Error;
                        //string informMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion == null ? "Information" : Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion;
                        e.Row.Cells[4].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                    if ((tStatus != 0) && (pLabStatus != 0))
                    {
                        string ToolTipMsg = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_17;
                        if (ToolTipMsg == null)
                        {
                            ToolTipMsg = "Yet to Perform Lab Investigations";
                        }
                        //e.Row.CssClass = "grdchecked";
                       
                        //e.Row.BackColor = System.Drawing.Color.LimeGreen;
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#99e699");
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = ToolTipMsg;
                        e.Row.Cells[5].ToolTip = ToolTipMsg;
                        e.Row.Cells[6].ToolTip = ToolTipMsg;
                        e.Row.Cells[14].ToolTip = DeleteTask;
                        string userMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_15 == null ? "Lab Investigations are yet to be completed. Continue?" : Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_15;
                        string okMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Ok == null ? "Ok" : Resources.PlatFormControls_AppMsg.PlatFormControls_Ok;
                        string cancelMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Cancel == null ? "Cancel" : Resources.PlatFormControls_AppMsg.PlatFormControls_Error;
                        //string informMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion == null ? "Information" : Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion;

                        e.Row.Cells[4].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                }
            }
            else if (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.Diabetology) || (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.Endocrinology)))
            {
                //grdTasks.Columns[8].Visible = false;
                if (t.RoleName == "Physician")
                {
                    string ToolTipMsg = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_18;
                    if (ToolTipMsg == null)
                    {
                        ToolTipMsg = "Yet to Perform Workup";
                    }
                  
                    if (tStatus == 0)
                    {

                        e.Row.BackColor = System.Drawing.Color.Orange;

                        //e.Row.CssClass = "grdcheck";
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = ToolTipMsg;
                        e.Row.Cells[5].ToolTip = ToolTipMsg;
                        e.Row.Cells[6].ToolTip = ToolTipMsg;
                        e.Row.Cells[14].ToolTip = DeleteTask;
                        string userMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_16 == null ? "Yet to Perform Workup. Continue?" : Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_16;
                        string okMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Ok == null ? "Ok" : Resources.PlatFormControls_AppMsg.PlatFormControls_Ok;
                        string cancelMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Cancel == null ? "Cancel" : Resources.PlatFormControls_AppMsg.PlatFormControls_Error;
                        //string informMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion == null ? "Information" : Resources.PlatFormControls_AppMsg.PlatFormControls_Informtion;

                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                    //if ((tStatus != 0) && (pLabStatus != 0))
                    if ((tStatus != 0) && (pLabStatus != 0))
                    {
                        //e.Row.CssClass = "grdchecked";

                        e.Row.BackColor = System.Drawing.Color.LimeGreen;
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = ToolTipMsg;
                        e.Row.Cells[5].ToolTip = ToolTipMsg;
                        e.Row.Cells[6].ToolTip = ToolTipMsg;
                        e.Row.Cells[14].ToolTip = DeleteTask;

                        string userMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_17 == null ? "Perform Workup are yet to be completed. Continue?" : Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_17;
                        string okMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Ok == null ? "Ok" : Resources.PlatFormControls_AppMsg.PlatFormControls_Ok;
                        string cancelMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Cancel == null ? "Cancel" : Resources.PlatFormControls_AppMsg.PlatFormControls_Error;


                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(ConfirmWindow('" + userMsg + "','" + informMsg + "','" + okMsg + "','" + cancelMsg + "')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                }
            }
            // else if ((t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.BloodBank)) && (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.BloodRequest)))
            // {
                // TaskDetails TaskBB = (TaskDetails)e.Row.DataItem;
                // List<BloodRequistionDetails> lstBloodRequest = new List<BloodRequistionDetails>();
                // List<Patient> lstPatient = new List<Patient>();
                // long RequestNo = 0;
                // DateTime pFDT;
                // DateTime pTDT;
                // pFDT = DateTimeNow;
                // pTDT = DateTimeNow;
              
                // TimeSpan ts = new TimeSpan();
                // DateTime CurrentDate = DateTimeNow;
                // ts = lstBloodRequest[0].TransfusionScheduledDate.Subtract(CurrentDate);
                // if (ts.Days > 3)
                // {
                    // e.Row.BackColor = System.Drawing.Color.BurlyWood;
                // }
                // string strtemp = GetToolTipBloodBank(lstBloodRequest);
                // e.Row.Cells[5].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                // e.Row.Cells[5].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
            // }
            if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.CollectSample))
            {
                TimeSpan ts = new TimeSpan();
                DateTime CurrentDate = DateTimeNow;
                ts = CurrentDate.Subtract(t.TaskDate);
                if (ts.Days > 45)
                {
                    e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;
                    e.Row.Cells[14].Visible = true;
                    e.Row.Cells[14].ToolTip = DeleteTask;
                    grdTasks.Columns[14].Visible = true;
                }
                else
                {
                    e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                    e.Row.Cells[4].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[5].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[6].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[14].ToolTip = DeleteTask;
                    e.Row.Cells[8].ToolTip = QuickDiagnosis;
                }
            }
            
            if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.CrossConsulation))
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                string strurl = t.RedirectURL;
                strurl = strurl.Replace("\\", "/");
                strurl = strurl.Replace("~/", "../");
                e.Row.Cells[4].Attributes.Add("onclick", "fnConfirm('" + strurl + "','" + t.TaskID + "')");
                e.Row.Cells[5].Attributes.Add("onclick", "fnConfirm('" + strurl + "','" + t.TaskID + "')");
                e.Row.Cells[6].Attributes.Add("onclick", "fnConfirm('" + strurl + "','" + t.TaskID + "')");
            }
			 else if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.SurgeryNotification))
            {

                string sPath = "<b>Ordered Surgeries</b>";
                sPath += "<br><br>" + t.RedirectURL.Split(new char[] { '&' }, StringSplitOptions.RemoveEmptyEntries)[0];
                ImageButton btn = e.Row.FindControl("imgDelete") as ImageButton;
                e.Row.Cells[4].Attributes.Add("onclick", "ShowNotification('" + sPath + "','" + t.TaskID + "')");
                e.Row.Cells[5].Attributes.Add("onclick", "ShowNotification('" + sPath + "','" + t.TaskID + "')");
                e.Row.Cells[6].Attributes.Add("onclick", "ShowNotification('" + sPath + "','" + t.TaskID + "')");

                // ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + informMsg + "');", true);

            }
            else if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.SurgeryPlan))
            {
                grdTasks.Columns[8].Visible = false;
            }
            if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.UpdatePerformer))
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                string strurl = t.RedirectURL;
                strurl = strurl.Replace("\\", "/");
                strurl = strurl.Replace("~/", "../");
                string[] temp = strurl.Split('?');
                long oPatientID = 0;
                if (!string.IsNullOrEmpty(temp[1].Split('&')[0].Replace("PID=", "")))
                {
                    oPatientID = int.Parse(temp[1].Split('&')[0].Replace("PID=", ""));
                }
                long oVisitID = 0;
                if (!string.IsNullOrEmpty(temp[1].Split('&')[1].Replace("VID=", "")))
                {
                    oVisitID = int.Parse(temp[1].Split('&')[1].Replace("VID=", ""));
                }
                long Packid = 0;
                if (!string.IsNullOrEmpty(temp[1].Split('&')[2].Replace("Pkid=", "")))
                {
                    Packid =Convert.ToInt64(temp[1].Split('&')[2].Replace("Pkid=", ""));
                }
                //UpdateVisitPerformer.LoadPatientVisitDetails(oVisitID, oPatientID);
                e.Row.Cells[4].Attributes.Add("onclick", "OpenFrame(" + oPatientID + "," + oVisitID+","+t.TaskID+","+Packid+ ")");
                e.Row.Cells[5].Attributes.Add("onclick", "OpenFrame(" + oPatientID + "," + oVisitID + "," + t.TaskID + "," + Packid + ")");
                e.Row.Cells[6].Attributes.Add("onclick", "OpenFrame(" + oPatientID + "," + oVisitID + "," + t.TaskID + "," + Packid + ")");
                 
            }
             
            
            if (t.ShowedTime == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;
                //trTimedSamples.Attributes.Add("style", "display:block");
            }
            else if (t.ShowedTime == "YY")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
            }

            HiddenField hdnClientname = (HiddenField)e.Row.FindControl("hdnClientname");
            // LinkButton lnkProcess = (LinkButton)e.Row.FindControl("lnkProcess");
            ImageButton lnkProcess = (ImageButton)e.Row.FindControl("imgProcess");
            HiddenField hdnPatientID = (HiddenField)e.Row.FindControl("hdnPatientID");
            HiddenField hdnPatientVisitID = (HiddenField)e.Row.FindControl("hdnPatientVisitID");
            HiddenField hdnTaskID = (HiddenField)e.Row.FindControl("hdnTaskID");
            HiddenField hdnActionName = (HiddenField)e.Row.FindControl("hdnActionName");
            HiddenField hdnRedirectURL = (HiddenField)e.Row.FindControl("hdnRedirectURL");
            HiddenField hdnSkipTaskValue = (HiddenField)e.Row.FindControl("hdnSkipTaskValue");
            HiddenField hdnTaskStatusID = (HiddenField)e.Row.FindControl("hdnTaskStatusID");
            HiddenField hdnType = (HiddenField)e.Row.FindControl("hdnType");

            if (hdnSkipTaskValue.Value == "1" || RoleHelper.Inventory == RoleName)
            {
                string Function = "SelectRow('" + hdnPatientID.ClientID + "','" + hdnPatientVisitID.ClientID + "','" +
                          hdnTaskID.ClientID + "','" + hdnActionName.ClientID + "','" + hdnRedirectURL.ClientID + "','" + lnkProcess.ClientID + "');";
                lnkProcess.Attributes.Add("Onclick", Function);
                IsSkipTasks = "Y";
            }
            else
            {
                lnkProcess.Style.Add("display", "none");
            }
            if (t.BGColour != "" && t.BGColour!=null)
            {
                if (t.BGColour.Contains("#"))
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml(t.BGColour);
                }
                else
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#" + t.BGColour);
                }
            }


        }
        if (IsNeedLabNo == "Y")
        {
            grdTasks.Columns[13].Visible = true;
        }
        if (hdnActionCount.Value != "0")
        {
            grdTasks.Columns[15].Visible = true;
        }
        if (IsNotNeedQuickDiagnosis == "Y")
        {
            grdTasks.Columns[8].Visible = false;
        }
        if (IsSkipTasks == "Y" || RoleHelper.Inventory == RoleName)
        {
            grdTasks.Columns[19].Visible = true;
        }
        if (RoleHelper.Inventory == RoleName)
        {
            grdTasks.Columns[14].Visible = false;
        }
        grdTasks.Columns[14].Visible = false;
    }
    private string GetToolTipBloodBank(List<BloodRequistionDetails> ComponentList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>" + Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_29 + "</td><td>" + Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_32 + "</td></tr>";
        foreach (var Item in ComponentList)
        {
            TableDate += "<tr>  <td>" + Item.ComponentName + "</td><td>" + Item.NoOfUnits + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>" CommonControls_Tasks_InvestigationList
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>" + Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_30 + "</td><td>" + Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_31 + "</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>"
                        + "<td>" + Item.Status + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }

    protected void grdTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
             
            if (e.CommandName == "Select")
            {
                   
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                string TasksType =Convert.ToString(grdTasks.DataKeys[RowIndex][11]);
                long TaskActionID = Convert.ToInt64(grdTasks.DataKeys[RowIndex][16]);
                TasksType = !string.IsNullOrEmpty(TasksType) ? TasksType : "";
               string StatusID = Convert.ToString(grdTasks.DataKeys[RowIndex][12]);
               int SID = 0;
               Int32.TryParse(Convert.ToString(grdTasks.DataKeys[RowIndex][13]), out SID);
               int PLID = 0;
               Int32.TryParse(Convert.ToString(grdTasks.DataKeys[RowIndex][14]), out PLID);
               StatusID = !string.IsNullOrEmpty(StatusID) ? StatusID : "";
                string Category = Convert.ToString(grdTasks.DataKeys[RowIndex][5]);
                Category = !string.IsNullOrEmpty(Category) ? Category : "";
              
                string Information = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_03;
                if (Information == null)
                {
                    Information = "Information";
                }

                 if (TasksType == "MRD" && StatusID =="-1")
                {
                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_18;
                    string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Attune_Footer_ascx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Alert";
                    }
                    if (sPath == null)
                    {
                        sPath = "MRD file process not completed";
                    }
                    //string sPath = "CommonControls\\\\Tasks.ascx.cs_1";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                    return;

                }
                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                labNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]) + "&LNo=" + labNo;
                PatientOrgId = Convert.ToInt32(grdTasks.DataKeys[RowIndex][8]);
                string RNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);

                if (Category == "Patient Admission")
                {
                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_21 == null ? "Please admit the patient from patient search" : Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_21;
                    string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Error == null ? "Alert" : Resources.PlatFormControls_AppMsg.PlatFormControls_Error;

                    new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Completed, LID);
                    string rFunction = "fnAdmitTask();";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindowResponse('" + sPath + "','" + ErrorMsg + "','" + rFunction + "');", true);
                    return;
                }
                if (RNo != null && RNo != "")
                {
                    redirectURL = redirectURL + "&RNo=" + RNo;
                }
                if (isCashDoctor != null && isCashDoctor != "")
                {
                    redirectURL = redirectURL + "&isDoc=Y";
                }
                patientVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][3]);
                List<Patient> lstPatient = null;
                long returncode = -1;
                string PatientNo = string.Empty;
                //if (patientVisitID == 0)
                //{
                    returncode = new Tasks_BL(base.ContextInfo).GetPatientDemoandAddress(iPatientID, out lstPatient);
                    if (lstPatient !=null && lstPatient.Count > 0)
                    {
                        PatientNo = lstPatient[0].PatientNumber;
                    }
                //}
                roleName = grdTasks.DataKeys[RowIndex][4].ToString();
                GridViewRow row = (GridViewRow)grdTasks.Rows[RowIndex];
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (tbl.isExpired(iTaskID) && (RoleName != RoleHelper.Physiotherapist && RoleName != RoleHelper.Counselor && roleName != RoleHelper.BloodBankTecnician))
                {
                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_11;
                    string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Attune_Footer_ascx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Alert";
                    }
                    if (sPath == null)
                    {
                        sPath = "This Prescription is expired,the task will be deleted";
                    }
                    //string sPath = "CommonControls\\\\Tasks.ascx.cs_1";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                    row.Style["color"] = "Red";
                    tbl.UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Deleted, LID);
                    GetTasks(currentPageNo, PageSize);
                }

                else if (tbl.isTaskAlreadyPicked(iTaskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
                {

                    GetTasks(currentPageNo, PageSize);
                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_12;

                    if (sPath == null)
                    {
                        sPath = "This task has already been picked by another user";
                    }
                    //string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                    row.Style["color"] = "Red";
                }
                else if (TaskActionID == Convert.ToInt64(TaskHelper.TaskAction.OpCasesheet))
                {
                    returncode = new Tasks_BL(base.ContextInfo).UpdateTask(iTaskID, TaskHelper.TaskStatus.Completed, LID);
                    Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId + "&PNO=" + PatientNo + "&ispopup=Y#!/caseSheetController", true);
                }
                else
                {
                    if (roleName ==RoleHelper.Physician|| roleName ==RoleHelper.Physiotherapist ||  (roleName ==RoleHelper.Counselor && ISMIDDLEEAST!="Y"))
                    {
                        tbl.UpdateTaskPickedBy(iTaskID, patientVisitID, LID);
                    }
			PLID = PLID == 0 ? Convert.ToInt32(LID) : PLID;
                    if (SID > 0 && roleName !=RoleHelper.Cashier)
                    {

                        Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId + "&SID=" + SID + "&PLID=" + PLID + "&PNO=" + PatientNo, true);
                    }
		           else
		            {
                        Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId + "&iPId=" + iPatientID + "&PNO=" + PatientNo, true);
                    }
                    Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId + "&iPId=" + iPatientID + "&PNO=" + PatientNo, true);
                }
            }
            if (e.CommandName == "Delete")
            {
                long returncode = -1;
                iTaskID = Convert.ToInt64(e.CommandArgument);
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Deleted, LID);

                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
                Response.Redirect(Request.ApplicationPath + path, true);

            }
            if (e.CommandName == "QuickDiagnosis")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                patientVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][3]);
                roleName = grdTasks.DataKeys[RowIndex][4].ToString();
                GridViewRow row = (GridViewRow)grdTasks.Rows[RowIndex];
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (tbl.isTaskAlreadyPicked(iTaskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
                {
                    string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_12;
                    string Information = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_03;
                    if (Information == null)
                    {
                        Information = "Information";
                    }
                    if (sPath == null)
                    {
                        sPath = "This task has already been picked by another user";
                    }

                    GetTasks(currentPageNo, PageSize);
                    //string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                        this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                    row.Style["color"] = "Red";
                }


                else
                {
                    string HealthCheckup = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_23;
                    if (HealthCheckup == null)
                    {
                        HealthCheckup = "Health Checkup";
                    }
                    if (roleName == "Physician" || roleName == "Counselor")
                    {
                        tbl.UpdateTaskPickedBy(iTaskID, patientVisitID, LID);
                    }
                    string TaskCategory = grdTasks.DataKeys[RowIndex][5].ToString();
                    if (TaskCategory == HealthCheckup)
                    {
                        Response.Redirect(@"../Diagnosis/UnfoundDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + iPatientID + "&tid=" + iTaskID + "&id=0" + "", true); // 0 Refers to Unfound Diagnose Complaint ID
                    }
                    else
                    {
                        int RowIndex1 = Convert.ToInt32(e.CommandArgument);

                        string TasksType = Convert.ToString(grdTasks.DataKeys[RowIndex1][11]);
                        TasksType = !string.IsNullOrEmpty(TasksType) ? TasksType : "";
                        string StatusID = Convert.ToString(grdTasks.DataKeys[RowIndex1][12]);
                        StatusID = !string.IsNullOrEmpty(StatusID) ? StatusID : "";
                        if (TasksType == "MRD" && StatusID == "-1")
                        {
                            string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_18;
                            string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Attune_Footer_ascx_01;
                            if (ErrorMsg == null)
                            {
                                ErrorMsg = "Alert";
                            }
                            if (sPath == null)
                            {
                                sPath = "MRD File Process Not Completed";
                            }
                            //string sPath = "CommonControls\\\\Tasks.ascx.cs_1";
                            ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                            return;

                        }
                        else
                        {
                            string VisitConsID = String.Empty;
                            redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]);
                            if (!string.IsNullOrEmpty(redirectURL))
                            {
                                List<string> urlvalues = redirectURL.Split('&').ToList();
                                foreach (var obj in urlvalues)
                                {
                                    string key = obj.Split('=')[0].Trim();
                                    if (key.ToLower() == "visitconsid")
                                    {
                                        VisitConsID = obj.Split('=')[1];
                                    }
                                }
                            }
                            Response.Redirect(@"../Diagnosis/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + iPatientID + "&tid=" + iTaskID + "&id=-1" + "&VisitConsID=" + VisitConsID + "&Vitals=Y&View=Y", true); // -1 Refers to QuickDiagnose Complaint ID
                        }
                    }
                }
            }
            //string SendSMS = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_24;
            //if (SendSMS == null)
            //{
            //    SendSMS = "SendSMS";
            //}
            //string Nurse = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_25;
            //if (Nurse == null)
            //{
            //    Nurse = "Nurse";
            //}
            if (e.CommandName == "SendSMS")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                //long returncode = -1;


                #region Notification
                string configNurse = GetConfigValue("SMSPatientForCollectVitalsInNurse", OrgID);
                string configDoctor = GetConfigValue("SMSPatientForCollectVitalsInDoctor", OrgID);
                if (configNurse.ToLower() == "y" && RoleName == "Nurse")
                {
                    ActionManager am = new ActionManager(base.ContextInfo);

                    pageContextDetails.PatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                    pageContextDetails.RoleID = RoleID;
                    pageContextDetails.AccessionNo = Convert.ToString(grdTasks.DataKeys[RowIndex][3]);//patientVisitID
                    pageContextDetails.LabNo = 0;
                    pageContextDetails.FinalBillID = 0;
                    pageContextDetails.RegPatientID = 0;
                    pageContextDetails.RateType = "0";
                    pageContextDetails.FeeID = Convert.ToString(grdTasks.DataKeys[RowIndex][1]);
                    pageContextDetails.RefundNo = "0";
                    pageContextDetails.BillNumber = "0";
                    pageContextDetails.PhoneNo = "";
                    pageContextDetails.ButtonName = "imgSendSMS";
                    pageContextDetails.ReceiptNo = "0";

                    long returnCode = am.PerformingNextStepNotification(pageContextDetails, "", "");
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "ShowSMSAlert('" + returnCode + "');", true);

                }
                else if (configDoctor.ToLower() == "y" && RoleName == "Physician")
                {
                    ActionManager am = new ActionManager(base.ContextInfo);

                    pageContextDetails.PatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]); ;
                    pageContextDetails.RoleID = RoleID;
                    pageContextDetails.AccessionNo = Convert.ToString(grdTasks.DataKeys[RowIndex][3]);//patientVisitID
                    pageContextDetails.LabNo = 0;
                    pageContextDetails.FinalBillID = 0;
                    pageContextDetails.RegPatientID = 0;
                    pageContextDetails.RateType = "0";
                    pageContextDetails.FeeID = Convert.ToString(grdTasks.DataKeys[RowIndex][1]);
                    pageContextDetails.RefundNo = "0";
                    pageContextDetails.BillNumber = "0";
                    pageContextDetails.PhoneNo = "";
                    pageContextDetails.ButtonName = "imgSendSMS";
                    pageContextDetails.ReceiptNo = "0";

                    long returnCode = am.PerformingNextStepNotification(pageContextDetails, "", "");
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "ShowSMSAlert('" + returnCode + "');", true);
                }

                #endregion

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

    protected void grdTasks_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblResult.Text = "";
        if (e.NewPageIndex >= 0)
        {
            grdTasks.PageIndex = e.NewPageIndex;

            GetTasks(currentPageNo, PageSize);
        }
    }

    protected void tmrPostback_Tick(object sender, EventArgs e)
    {
        lblResult.Text = "";
        GetTasks(currentPageNo, PageSize);
    }

    protected void ddLO_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblResult.Text = "";
        //GetTasks();
    }

    protected void ddSPE_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblResult.Text = "";
        //GetTasks();
    }

    protected void ddTD_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblResult.Text = "";
        //GetTasks();
    }
    protected void ddlDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblResult.Text = "";
        //GetTasks();
    }

    protected void ddCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblResult.Text = "";
        //GetTasks();
    }

    #endregion

    #region Custom Properties

    public long SelectedPatient
    {
        get
        {
            return iPatientID;
        }
    }

    public long SelectedTask
    {
        get
        {
            return iTaskID;
        }
    }

    public string RedirectURL
    {
        get
        {
            return redirectURL;
        }
    }

    public long PatientVisitID
    {
        get
        {
            return patientVisitID;
        }
    }

    #endregion
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    #region Custom Functions
    List<TaskDetails> lstTasks = new List<TaskDetails>();
    private void GetData(int currentPageNo, int PageSize)
    {
        long retval = -1;

        Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);

        retval = tasksBL.GetTasks(RoleID, OrgID, LID, out lstTasks, InventoryLocationID, currentPageNo, PageSize, out totalRows);

        totalpage = totalRows;
        lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        if (hdnCurrent.Value == "")
        {
            lblCurrent.Text = currentPageNo.ToString();
        }
        else
        {
            lblCurrent.Text = hdnCurrent.Value;
            currentPageNo = Convert.ToInt32(hdnCurrent.Value);
        }

        if (currentPageNo == 1)
        {
            Btn_Previous.Enabled = false;

            if (Int32.Parse(lblTotal.Text.Trim()) > 1)
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

            if (currentPageNo == Int32.Parse(lblTotal.Text.Trim()))
                Btn_Next.Enabled = false;
            else Btn_Next.Enabled = true;
        }
        if (retval == 0)
        {
            GetLocationAndSpeciality();
            if (lstTasks.Count == 0)
            {
                NoResult();
            }

        }
        else
        {
            //Hide the filter panel and show the no pending task status
            NoResult();

            //Load dummy values in the filter dropdowns
            LoadDummyValues();
        }
    }
    List<OrganizationAddress> lstLocation = null;
    List<Speciality> lstSpeciality = null;
    List<TaskActions> lstCategory = null;
    List<InvDeptMaster> lstDept = null;
    TaskProfile taskProfile = null;
    List<PatientTypeMaster> lstPatientType = null;
    private void GetLocationAndSpeciality()
    {

        long retval = -1;

        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstPatientType);
        if(taskProfile==null)
        {
            taskProfile = new TaskProfile();
        }
        LoadLocation(lstLocation, taskProfile);
        LoadSpeciality(lstSpeciality, taskProfile);
        LoadCategory(lstCategory, taskProfile);
        LoadDates(lstTasks, taskProfile);
        LoadDept(lstDept, taskProfile);
        LoadPatienttype(lstPatientType, taskProfile);

        if (taskProfile.LoginID != 0)
        {
            GetTasks(currentPageNo, PageSize);
        }
        else
        {
            BindData(lstTasks);
        }

    }

    private void LoadLocation(List<OrganizationAddress> lstLocation, TaskProfile taskProfile)
    {
        //string sLoId = taskProfile.Location == "" ?  : taskProfile.Location;
        ddLO.DataSource = lstLocation;
        ddLO.DataTextField = "Location";
        ddLO.DataValueField = "AddressID";
        ddLO.DataBind();
        ddLO.Items.Insert(0, GetMetaData("All","0"));
        
        ddLO.Items[0].Value = "0";
        if (taskProfile.Location.ToString() == "")
        {
            ddLO.SelectedValue = ILocationID.ToString();
        }
        else
        {
            ddLO.SelectedValue = taskProfile.Location.ToString();
        }
    }

    public void LoadPatienttype(List<PatientTypeMaster> lstpatienttype, TaskProfile taskprofile)
    {
        
            ddlpatienttype.DataSource = lstpatienttype;
            ddlpatienttype.DataTextField = "PatientTypeName";
            ddlpatienttype.DataValueField = "PatientTypeID";
            ddlpatienttype.DataBind();
        
        ddlpatienttype.Items.Insert(0, GetMetaData("Select", "0"));
        ddlpatienttype.Items[0].Value = "0";
        
        ddlpatienttype.SelectedValue = taskProfile.PatientTypeID.ToString();
        
           
    }
    private void LoadSpeciality(List<Speciality> lstSpeciality, TaskProfile taskProfile)
    {
        
            ddSPE.DataSource = lstSpeciality;
            ddSPE.DataTextField = "SpecialityName";
            ddSPE.DataValueField = "SpecialityID";
            ddSPE.DataBind();

        
    
            ddSPE.Items.Insert(0, GetMetaData("All", "0"));
        
        ddSPE.Items[0].Value = "0";
        ddSPE.SelectedValue = taskProfile.SpecialityID.ToString();
    }

    private DateTime dt;
    List<TaskDetails> oTaskDetails = new List<TaskDetails>();
    private void GetAllData(string strDate, string category, long orgAddrId, int specialityId, string PatientNumber, string LabNumber, int InvLocationID, int startRowIndex, int pageSize, out int totalRows, int DeptID, long strpatienttypeid)
    {
        dt = DateTime.MinValue;
        System.Data.SqlTypes.SqlDateTime getDate;
        getDate = System.Data.SqlTypes.SqlDateTime.Null;
        long retval = -1;
        long ret = -1;
        int ActionCount = 0;
        Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);
        List<TaskDetails> lstTasks = null;
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
        objTrustedOrgActions = new TrustedOrgActions();

        SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.SecondOpinion);
        SearchType = "TASK";
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        objTrustedOrgActions.LoggedOrgID = OrgID;
        objTrustedOrgActions.SharingOrgID = 0;
        objTrustedOrgActions.IdentifyingType = SearchType;
        objTrustedOrgActions.IdentifyingActionID = SerachTypeID;
        objTrustedOrgActions.RoleID = RoleID;

        lstTrustedOrgActions.Add(objTrustedOrgActions);

        ret = new TrustedOrg(base.ContextInfo).CheckActionAccess(lstTrustedOrgActions, out ActionCount);
        hdnActionCount.Value = ActionCount.ToString();
        if (hdnActionCount.Value == "0")
        {
            SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.Approval);
            objTrustedOrgActions.IdentifyingActionID = SerachTypeID;
            ret = new TrustedOrg(base.ContextInfo).CheckActionAccess(lstTrustedOrgActions, out ActionCount);
            hdnActionCount.Value = ActionCount.ToString();
        }

        if (chkTimedSamples.Checked)    
        {
            base.ContextInfo.AdditionalInfo = "Y";
        }
        base.ContextInfo.DepartmentName = DepartmentID;
        retval = tasksBL.GetAllTasks(RoleID, OrgID, LID, strDate, category, orgAddrId, specialityId, PatientNumber, LabNumber, out lstTasks, InvLocationID, startRowIndex, pageSize, out totalRows, DeptID, objLoginDetail, lstTrustedOrgActions, ddlPriority.SelectedValue,0);
        totalpage = totalRows;
        lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        //coded by kumaresan
          if (retval == 0 && lstTasks!=null && lstTasks.Count > 0)
          {
            oTaskDetails = lstTasks;
          }
        //--------
        if (hdnCurrent.Value == "")
        {
            lblCurrent.Text = currentPageNo.ToString();
        }
        else
        {
            lblCurrent.Text = hdnCurrent.Value;
            currentPageNo = Convert.ToInt32(hdnCurrent.Value);
        }

        if (currentPageNo == 1)
        {
            Btn_Previous.Enabled = false;

            if (Int32.Parse(lblTotal.Text.Trim()) > 1)
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

            if (currentPageNo == Int32.Parse(lblTotal.Text.Trim()))
                Btn_Next.Enabled = false;
            else Btn_Next.Enabled = true;
        }
        string Phlebotomist = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_26;
        if (Phlebotomist == null)
        {
            Phlebotomist = "Phlebotomist";
        }
        if (RoleName == "Phlebotomist")
        {
            trTimedSamples.Attributes.Add("style", "display:block");
        }

        if (retval == 0 && lstTasks != null&& lstTasks.Count > 0)
        {
            BindData(lstTasks);
            TaskCount = lstTasks.Count;

        }
        else
        {
            NoResult();
        }

    }
    private long _taskCount;
    public long TaskCount
    {
        get { return _taskCount; }
        set { _taskCount = value; }
    }
    private void NoResult()
    {
        grdTasks.Visible = false;
        lblResult.Visible = true;
        divFooterNav.Visible = false;
        grdTasks.DataSource = null;
        grdTasks.DataBind();
    }

    private void BindData(List<TaskDetails> lstTasks)
    {

        grdTasks.Visible = true;
        divFooterNav.Visible = true;
        lblResult.Visible = true;
        // lblResult.Text = "Click Here to ";
        grdTasks.DataSource = lstTasks;
        grdTasks.DataBind();

    }

    private void LoadDummyValues()
    {
        ddTD.Items.Clear();
        ddCat.Items.Clear();
        ddLO.Items.Clear();
        ddSPE.Items.Clear();
        
            ListItem itm = new ListItem();
            itm=GetMetaData("All", "0");            
            ddTD.Items.Add(itm);
            ddCat.Items.Add(itm);
            ddLO.Items.Add(itm);
            ddSPE.Items.Add(itm);
        
    }

    private void LoadDates(List<TaskDetails> lstTasks, TaskProfile taskProfile)
    {
        string sSelected = ddTD.Items.Count > 0 ? ddTD.SelectedValue : "0";
        ddTD.Items.Clear();
        ListItem itm;
        //if (LanguageCode == "id-ID")
        //{
        //    itm = new ListItem("(Hari ini)", "ToDay");
        //    ddTD.Items.Add(itm);
        //    ListItem itm1 = new ListItem("(SEMUA)", "ALL");
        //    ddTD.Items.Add(itm1);
        //}
        //else
        //{
        //string ToDay = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_09;
        //if (ToDay == null)
        //{
        //    ToDay = "ToDay";
        //}
        //string ALL = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_27;
        //if (ALL == null)
        //{
        //    ALL = "ALL"; 
        //}
        ListItem _today = GetMetaData("CustomPeriodRange", "4");
        itm = new ListItem(_today.Text,"ToDay");
        ddTD.Items.Add(itm);
        ListItem _all = GetMetaData("All", "0");
        ddTD.Items.Add(_all);
        // }
        foreach (TaskDetails tsk in lstTasks)
        {
            string sDate = string.Format("{0:d}", tsk.TaskDate);
            itm = new ListItem();
            itm.Text = sDate;
            itm.Value = sDate;
            if (!ddTD.Items.Contains(itm))
            {
                ddTD.Items.Add(itm);
            }
        }
        if (taskProfile.TaskDate != "")
        {
            ddTD.SelectedValue = taskProfile.TaskDate;
        }


    }

    private void LoadCategory(List<TaskActions> lstTasks, TaskProfile taskProfile)
    {
        ddCat.DataSource = lstTasks;
        ddCat.DataTextField = "CategoryText";
        ddCat.DataValueField = "Category";
        ddCat.DataBind();

        ddCat.Items.Insert(0,GetMetaData("All", "0"));
        
        ddCat.Items[0].Value = "0";

        ddCat.SelectedValue = taskProfile.Category;
    }

    public void GetTasks(int currentPageNo, int PageSize)
    {
        TaskProfile taskprofile = new TaskProfile();
        taskprofile.LoginID = LID;
        taskprofile.RoleID = Convert.ToInt64(RoleID);
        taskprofile.OrgID = Convert.ToInt32(OrgID);
        taskprofile.OrgAddressID = ILocationID;
        taskprofile.Location = ddLO.SelectedValue;
        if (ddSPE.SelectedValue != "")
        {
            taskprofile.SpecialityID = Convert.ToInt32(ddSPE.SelectedValue);
        }
        else
        {
            taskprofile.SpecialityID = -1;
        }
        taskprofile.SpecialityName = ddSPE.SelectedValue;
        taskprofile.Category = ddCat.SelectedValue;
        taskprofile.TaskDate = ddTD.SelectedValue.ToString();
        taskprofile.DeptID = Convert.ToInt32(ddlDept.SelectedValue);
        // int startRowIndex, int pageSize, out int totalRows, 
        string sDate = "";
        //;
        //string ToDay = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_09;
        //if (ToDay == null)
        //{
        //    ToDay = "ToDay";
        //}
        //string ALL = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Tasks_ascx_27;
        //if (ALL == null)
        //{
        //    ALL = "ALL";
        //}
        if (ddTD.SelectedValue == "ToDay")
        {
            sDate = DateTimeNow.ToString("dd/MM/yyyy");
        }
        if (ddTD.SelectedValue == "0")
        {
            sDate = "-1";
        }
        if (ddTD.SelectedValue != "0" && ddTD.SelectedValue != "ToDay")
        {
            sDate = ddTD.SelectedValue;
        }
        string sCat = ddCat.SelectedValue == "0" ? "-1" : ddCat.SelectedValue;
        string sLoc = ddLO.SelectedValue == "0" ? "-1" : ddLO.SelectedValue;
        string sSpec = ddSPE.SelectedValue == "0" ? "-1" : ddSPE.SelectedValue;
        if (sSpec == "")
        {
            sSpec = "-1";
        }
        string sDept = ddlDept.SelectedValue == "0" ? "-1" : ddlDept.SelectedValue;
        int inventoryLocationID = RoleHelper.Inventory == RoleName ? InventoryLocationID : 0;

        if (rdnLabNo.Checked == true & txttext.Text.Trim() != "")
        {

            Labno = "1/" + txttext.Text.Trim();
            txttext.Text = Labno;
            PatientNumber = txttext.Text.Trim() == "" ? "-1" : txttext.Text.Trim();
            hdntxttext.Value = PatientNumber;
        }
        if (ChkBoxServiceNum.Checked == true & txttext.Text.Trim() != "")
        {
            ServiceNo = "2/" + txttext.Text.Trim();
            txttext.Text = ServiceNo;
            PatientNumber = txttext.Text.Trim() == "" ? "-1" : txttext.Text.Trim();
            hdntxttext.Value = PatientNumber;
        }

        else
        {
            PatientNumber = txttext.Text.Trim() == "" ? "-1" : txttext.Text.Trim();
            hdntxttext.Value = PatientNumber;
        }
        string LabNumber = string.Empty;
        if (txtLabNumer.Text.Trim() == "")
        {
            LabNumber = "-1";
        }
        else
        {
            LabNumber = txtLabNumer.Text.Trim();
        }
        long strpatienttype = 0;
        if (ddlpatienttype.SelectedValue == "0")
        {
            strpatienttype = 0;
        }
        else
        {
            strpatienttype = Convert.ToInt64(ddlpatienttype.SelectedValue);
        }
        //string PatientNumber = txtPatientNumber.Text.Trim() == "" ? "-1" : txtPatientNumber.Text;
        GetAllData(sDate, sCat, Convert.ToInt64(sLoc), Convert.ToInt32(sSpec), PatientNumber, txtLabNumer.Text, InventoryLocationID, currentPageNo, PageSize, out totalRows, Convert.ToInt32(sDept), strpatienttype);
        OrgLocation = Convert.ToInt32(sLoc);

        //EventArgs e = new EventArgs();
        //if (onTaskLoadComplete != null)
        //{
        //    onTaskLoadComplete(this, e);
        //}

    }

    public string GetPatientName()
    {
        return PatientNumber;
    }

    int _OrgLocation = -1;

    public int OrgLocation
    {
        get { return _OrgLocation; }
        set { _OrgLocation = value; }
    }

    #endregion
    public void Check_Clicked(Object sender, EventArgs e)
    {
        lnkSetDefault_Click(sender, e);
    }
    protected void lnkSetDefault_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        Tasks_BL taskBL = new Tasks_BL();
        long retval = -1;
        TaskProfile taskprofile = new TaskProfile();
        try
        {

            taskprofile.LoginID = LID;
            taskprofile.RoleID = Convert.ToInt64(RoleID);
            taskprofile.OrgID = Convert.ToInt32(OrgID);
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.Location = ddLO.SelectedValue;
            if (ddSPE.SelectedValue != "0")
            {
                taskprofile.SpecialityID = Convert.ToInt32(ddSPE.SelectedValue);
            }
            else
            {
                taskprofile.SpecialityID = -1;
            }
            taskprofile.SpecialityName = ddSPE.SelectedValue;
            taskprofile.Category = ddCat.SelectedValue;
            taskprofile.TaskDate = ddTD.SelectedValue.ToString();
            taskprofile.DeptID = Convert.ToInt32(ddlDept.SelectedValue);
            taskprofile.PatientTypeID = Convert.ToInt32(ddlpatienttype.SelectedValue);
            taskprofile.PatientTypeName = ddlpatienttype.SelectedItem.ToString();
            if (chkSetDefault.Checked)
            {
                retval = taskBL.InsertDefault(taskprofile);
                GetTasks(currentPageNo, PageSize);
            }
            else
            {
                GetTasks(currentPageNo, PageSize);
            }
            if (chkSetDefault.Checked == true)
            {
                chkSetDefault.Checked = false;
            }
            SetDeptIDSession();

            if (grdTasks.Rows.Count == 0)
            {
                string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_13;
                string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Attune_Footer_ascx_01;
                if (ErrorMsg == null)
                {
                    ErrorMsg = "Alert";
                }
                if (sPath == null)
                {
                    sPath = "No Matching Records Found";
                }
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert1", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving task details.", ex);
            //edisp.Visible = true;
            //lblStatus.Text = "There was a problem in page load. Please contact system administrator";

        }
    }

    private void SetDeptIDSession()
    {
        if (Session["DeptID"] != null)
        {
            Session["DeptID"] = ddlDept.SelectedValue;
        }
        else
        {
            Session.Add("DeptID", ddlDept.SelectedValue);
        }

    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        lblResult.Text = "";
        GetTasks(currentPageNo, PageSize);
    }
    protected void btnRefresh1_Click(object sender, EventArgs e)
    {
        lblResult.Text = "";
        GetTasks(currentPageNo, PageSize);
    }

    //protected void lBsearch_Click(object sender, EventArgs e)
    //{
    //    lblResult.Text = "";
    //    GetTasks();

    //    txttext.Text = "";

    //}

    protected void btn_Go_Click(object sender, EventArgs e)
    {
        try
        {
            lblResult.Text = "";

            GetTasks(currentPageNo, PageSize);

            txttext.Text = "";
            if (OnPopLoad != null)
            {
                OnPopLoad(sender, e);

            }
            rdnLabNo.Checked = false;
            SetDeptIDSession();
            if (grdTasks.Rows.Count > 1)
            {
                int t = Convert.ToInt32(grdTasks.DataKeys[0][3]);
                string s = grdTasks.Rows[0].Cells[4].ClientID;
            }
            if (grdTasks.Rows.Count == 1)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Barcode", " Click();", true);
            }

            if (grdTasks.Rows.Count == 0)
            {
                string sPath = Resources.PlatFormControls_AppMsg.PlatFormControls_Tasks_ascx_13;
                string ErrorMsg = Resources.PlatFormControls_AppMsg.PlatFormControls_Attune_Footer_ascx_01;
                if (ErrorMsg == null)
                {
                    ErrorMsg = "Alert";
                }
                if (sPath == null)
                {
                    sPath = "No Matching Records Found";
                }
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert1", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
            }
        }
        catch
        {
        }


    }
    private void LoadDept(List<InvDeptMaster> lstDept, TaskProfile taskProfile)
    {
        ddlDept.DataSource = lstDept;
        ddlDept.DataTextField = "DeptName";
        ddlDept.DataValueField = "DeptID";
        ddlDept.DataBind();
    
       ddlDept.Items.Insert(0, GetMetaData("All", "0"));
       ddlDept.Items[0].Value = "0";
        if (taskProfile.DeptID.ToString() != "-1")
        {
            ddlDept.SelectedValue = taskProfile.DeptID.ToString();
        }
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



        //if (ddLO.SelectedValue != "0" && ddSPE.SelectedValue == "" && ddlDept.SelectedValue == "0" && ddCat.SelectedValue == "0" && ddTD.SelectedValue != "ALL" && ar != 0)
        //{
        //    GetData(Convert.ToInt32(txtpageNo.Text), PageSize);
        //}
        //else 
        if (ar != 0)
        {

            GetTasks(Convert.ToInt32(txtpageNo.Text), PageSize);
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
        GetTasks(currentPageNo, PageSize);

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
        GetTasks(currentPageNo, PageSize);
    }
    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "Preference";
            string[] Tempdata = domains.Split(',');
            string LangCode = "";
            if (Session["LanguageCode"] != null)
            {
                LangCode = Session["LanguageCode"].ToString();
            }
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = null;

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput !=null && lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Preference"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlPriority.DataSource = childItems;
                    ddlPriority.DataTextField = "DisplayText";
                    ddlPriority.DataValueField = "Code";
                    ddlPriority.DataBind();
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
        }
    }
    protected string DateTimeConvert(object a)
    {
        DateTime c = DateTime.MaxValue;
        c = (DateTime)a;
        return c.ToString("dd/MM/yyyy hh:mm tt", CultureInfo.InvariantCulture);
    }

    #region Show hide labNo
    public void showLabNo()
    {

        switch (RoleName)
        {
            case "LabTech":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "small";
                break;

            case "SrLabTech":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "small";
                break;
            case "BloodBank Technician":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "small";
                break;
            case "Lab Cashier":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "small";

                break;
            case "LabReception":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "show";
                break;
            case "Lab Technician":
                lblLabNumer.CssClass = "header-color";
                txtLabNumer.CssClass = "show";
                break;


            default:
                lblLabNumer.CssClass = "hide";
                txtLabNumer.CssClass = "hide";
                break;
        }

    }
    #endregion

    #region Show SMS
    public void showSMS()
    {
        grdTasks.Columns[21].Visible = false;
       /* if (SMSLinkYN!="N")
        {
        switch (RoleName)
        {
            case "Nurse":
                grdTasks.Columns[21].Visible = true;
                break;
            case "Physician":
                grdTasks.Columns[21].Visible = true;
                break;
            case "Receptionist":
                break;
            case "Lab Cashier":
                break;
            case "LabReception":
                break;
            case "Lab Technician":
                break;
            default:
                break;
        }
        }*/

    }
    #endregion 
#region GetToolTipProc
    private string GetToolTipProc(string ProcedureName)
    {
        string TableHead = "";
        string TableDate = "";
        string[] strProcedureDetails = null;
        /* Code Added By: Gurunath S 
         * Code Added At: 26-Oct-2013
         * Fix Details: Show No.of sitting's and Comments in Tool Tip */
        /* Code Begin */
        TableHead = "<table border=\"0\" cellpadding=\"2\"cellspacing=\"2\" rules=\"all\" frame=\"hSides\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                  + "<tr style=\"font-weight: bolder; background-color:#2c88b1; color:#FFFFFF;text-decoration:underline\"><td>Procedure</td><td>No. Of Sittings</td><td>Comments</td></tr>";
        foreach (var Item in oTaskDetails)
        {
            if (Item.InvestigationName == ProcedureName && Item.InvestigationName != null)
            {
                strProcedureDetails = Item.InvestigationName.Split(new[] { '^' }, StringSplitOptions.RemoveEmptyEntries);
                for (int i = 0; i < strProcedureDetails.Length; i++)
                {
                    string[] strEachProcDetails = null;
                    strEachProcDetails = strProcedureDetails[i].Split(new[] { '~' }, StringSplitOptions.RemoveEmptyEntries);
                    TableDate += "<tr>";
                    for (int j = 0; j < strEachProcDetails.Length; j++)
                    {
                        TableDate += "<td>" + strEachProcDetails[j].Replace("'", "") + "</td>";
                    }
                    TableDate += "</tr>";
                }

                break;
            }

        }
        return TableHead + TableDate + "</table> ";
        /* Code End */
    }
    #endregion
    protected void btnPopOk_Click(object sender, EventArgs e)
    {
        try
        {
            mdlApprovalpop.Hide();
            mdlNotification.Hide();
            long taskID = Convert.ToInt64(hdnModalTaskID.Value);
            base.ContextInfo.AdditionalInfo = txtReason.Text;
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Deleted, LID);
            btnPopCancel_Click(sender, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnPopCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(Request.ApplicationPath + LandingPage, true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}

