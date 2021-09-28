using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;

public partial class CommonControls_TasksNew : BaseControl
{
    public CommonControls_TasksNew()
        : base("CommonControls_TasksNew_ascx")
    {
    }
    string Select = Resources.CommonControls_ClientDisplay.Commoncontrols_Tasks_ascx_001 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.Commoncontrols_Tasks_ascx_001;
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
    string IsNeedNewApproval = string.Empty;
    string labNo = string.Empty;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    long ProtocalGroupID = -1;
    string jqueryTask = string.Empty;
    string IsHospitalLab = string.Empty;
       
	
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
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
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

 

    #region "Initial"
    string strLabNo = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_01 == null ? "Lab Number" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_01;
    string strVisitNo = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_02 == null ? "Visit Number" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_02;
    string strClickHere = Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_01 == null ? "Click Here to" : Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_01;
    string strActionName = Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_04 == null ? "Approval" : Resources.Phlebotomist_ClientDisplay.Phlebotomist_Home_aspx_04;
    protected void Page_Load(object sender, EventArgs e)
    {
        IsHospitalLab = GetConfigValue("IsHospitalLab", OrgID);
        if (IsHospitalLab == "Y")
        {
            tdddlVisitType.Visible = true;
            tdVisitType.Visible = true;
        }
        else
        {
            tdddlVisitType.Visible = false;
            tdVisitType.Visible = false;
        }

        lblpatientNameNO.Visible = true;
        txttext.Visible = true;
        btn_Go.Visible = true;
        if (!IsPostBack)
        {
            LoadMeatData();
            Loadprotocalgroup();
            LoadVisitType();

            if (RoleDescription == "Sr.Doctor" || RoleDescription == "Jr.Doctor")
            {
                td_lblprotocalgroup.Attributes.Add("style", "display:none");
                td_drpProtocal.Attributes.Add("style", "display:none");
            }
        }


        if (!Page.IsPostBack)
        {
            AutoCompleteExtenderClientTask.ContextKey = "0^0";
            IsNeedLabNo = GetConfigValue("NeedLabNo", OrgID);
            if (IsNeedLabNo == "Y")
            {
                if (RoleHelper.LabTech == RoleName || RoleHelper.SrLabTech == RoleName || RoleHelper.Phlebotomist == RoleName)
                {
                    IsNeedLabNo = "Y";
                }
                else
                {
                    IsNeedLabNo = "N";
                }
            }
            lblpatientNameNO.Visible = true;
            txttext.Visible = true;
            btn_Go.Visible = true;

            ddLO.SelectedValue = ILocationID.ToString();
            ddTD.SelectedValue = "ToDay";
            chkSetDefault.Checked = true;
            //lnkSetDefault_Click(lnkSetDefault, new EventArgs());
            
            // All the tasks are retrieved when the page first loads
            GetData(currentPageNo, PageSize);


            
            //ddLO.Enabled = false;
            GetTasks(currentPageNo, PageSize);
            Response.Cookies["style"].Value = "1";

            //string path = HttpContext.Current.Request.Url.AbsolutePath;

            if (Chklab == "1")
            {

                rdnLabNo.Visible = true;
            }

           // chkSetDefault.Checked = false;
        }
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = strLabNo.Trim();
                txttext.MaxLength = 9;
        }
        else
        {
            defaultText = strVisitNo.Trim();
        }
        txtwatermark();

        string style = Request.Cookies["style"].Value.ToString();

        if (lblResult.Text != "")
        {
            lblResult1.Visible = false;
            btnRefresh.Visible = false;
            btnRefresh1.Visible = true;
            lblResult.Text = strClickHere.Trim();
        }
        else
        {
            lblResult1.Text = strClickHere.Trim();
            lblResult1.Visible = true;
            btnRefresh.Visible = true;
            btnRefresh1.Visible = false;
        }


    }
    public void txtwatermark()
    {
        if (txttext.Text.Trim() != defaultText.Trim())
        {
            txttext.Attributes.Add("style", "color:black");
        }
        if (txttext.Text == "")
        {
            txttext.Text = defaultText;
            txttext.Attributes.Add("style", "color:gray");
        }
        txttext.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txttext.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TaskDetails t = (TaskDetails)e.Row.DataItem;


            //Added  by Thillai  kapil.T
            string reportdate = GetConfigValue("ReportDate", OrgID);
            string oldapproval_hide = GetConfigValue("oldapproval_hide", OrgID);
            if (reportdate == "Y")
            {
             //   grdTasks.Columns[17].Visible = true;
               grdTasks.Columns[18].Visible = true;
            }
            else
            {
               // grdTasks.Columns[17].Visible = false ;
                grdTasks.Columns[18].Visible = false;
            }
            if (oldapproval_hide == "Y")
            {
                //   grdTasks.Columns[17].Visible = true;
                grdTasks.Columns[17].Visible = false;
            }
            else
            {
                // grdTasks.Columns[17].Visible = false ;
                grdTasks.Columns[17].Visible = true;
            }


            //END  
            if (t.TaskStatusID == Convert.ToInt32(TaskHelper.TaskStatus.InProgress) && t.ModifiedBy != LID)
            {
                e.Row.Visible = false;
                if (t.RoleName != "Physician")
                {
                    grdTasks.Columns[14].Visible = false;
                    grdTasks.Columns[8].Visible = false;

                }
            }

            else
            {
                if (t.AssignedTo != 0 && t.AssignedTo != LID)
                {
                    e.Row.Visible = false;
                    if (t.RoleName != "Physician")
                    {
                        grdTasks.Columns[14].Visible = false;
                        grdTasks.Columns[8].Visible = false;
                    }
                }


                else
                {
                    //-----------Added Spelling of Approval changed---------------//
                    e.Row.ToolTip = t.ActionName == "Approvel" ? "Approval" : t.ActionName;

                    // e.Row.ToolTip = t.ActionName;

                    if (!string.IsNullOrEmpty(t.HighlightColor))
                    {
                       // e.Row.BackColor = Helper.GetColor(t.HighlightColor);
                    }
                    if (t.RoleName != "Physician")
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
                        e.Row.Cells[14].ToolTip = "Delete this Task";
                        e.Row.Cells[8].ToolTip = "Perform Quick Diagnosis";
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
                    e.Row.Cells[8].ToolTip = "Delete this Task";
                    e.Row.Cells[9].ToolTip = "Perform Quick Diagnosis";
                }
                //newly added for assigned task ....
                if (t.AssignedTo != 0)
                {
                    e.Row.ToolTip = "This  patient is specifically assigned to you";
                    e.Row.BackColor = System.Drawing.Color.BurlyWood;

                }
                //end ........
            }
            if (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.ANC))
            {
                //grdTasks.Columns[8].Visible = false;
                if (t.RoleName == "Physician")
                {
                    returnCode = new ANC_BL(base.ContextInfo).CheckANCNurseTaskStatus(t.PatientVisitID, t.SpecialityID, t.RoleID, out tStatus, out pLabStatus);
                    if (tStatus == 0)
                    {

                        e.Row.BackColor = System.Drawing.Color.Orange;

                        //e.Row.CssClass = "grdcheck";
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = "Yet to Perform BaseLine Screening";
                        e.Row.Cells[5].ToolTip = "Yet to Perform BaseLine Screening";
                        e.Row.Cells[6].ToolTip = "Yet to Perform BaseLine Screening";
                        e.Row.Cells[14].ToolTip = "Delete this Task";

                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                    if ((tStatus != 0) && (pLabStatus != 0))
                    {
                        //e.Row.CssClass = "grdchecked";
                        returnCode = new ANC_BL(base.ContextInfo).CheckANCNurseTaskStatus(t.PatientVisitID, t.SpecialityID, t.RoleID, out tStatus, out pLabStatus);
                        e.Row.BackColor = System.Drawing.Color.LimeGreen;
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = "Yet to Perform Lab Investigations";
                        e.Row.Cells[5].ToolTip = "Yet to Perform Lab Investigations";
                        e.Row.Cells[6].ToolTip = "Yet to Perform Lab Investigations";
                        e.Row.Cells[14].ToolTip = "Delete this Task";

                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                }
            }
            else if (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.Diabetology) || (t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.Endocrinology)))
            {
                //grdTasks.Columns[8].Visible = false;
                if (t.RoleName == "Physician")
                {
                    returnCode = new ANC_BL(base.ContextInfo).CheckANCNurseTaskStatus(t.PatientVisitID, t.SpecialityID, t.RoleID, out tStatus, out pLabStatus);
                    if (tStatus == 0)
                    {

                        e.Row.BackColor = System.Drawing.Color.Orange;

                        //e.Row.CssClass = "grdcheck";
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform BaseLine Screening. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[5].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[6].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[14].ToolTip = "Delete this Task";

                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform Workup. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform Workup. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(confirm('Yet to Perform Workup. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                    //if ((tStatus != 0) && (pLabStatus != 0))
                    if ((tStatus != 0) && (pLabStatus != 0))
                    {
                        //e.Row.CssClass = "grdchecked";

                        e.Row.BackColor = System.Drawing.Color.LimeGreen;
                        //e.Row.ToolTip = "Yet to Perform BaseLine Screening";
                        //e.Row.Attributes.Add("onclick", "javascript:if(confirm('Lab Investigations are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) +  "}") ;

                        e.Row.Cells[4].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[5].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[6].ToolTip = "Yet to Perform Workup";
                        e.Row.Cells[14].ToolTip = "Delete this Task";

                        e.Row.Cells[4].Attributes.Add("onclick", "javascript:if(confirm('Perform Workup are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[5].Attributes.Add("onclick", "javascript:if(confirm('Perform Workup are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                        e.Row.Cells[6].Attributes.Add("onclick", "javascript:if(confirm('Perform Workup are yet to be completed. Continue?')){" + this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex) + "}");
                    }
                }
            }
            else if ((t.SpecialityID == Convert.ToInt32(TaskHelper.speciality.BloodBank)) && (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.BloodRequest)))
            {
                TaskDetails TaskBB = (TaskDetails)e.Row.DataItem;
                List<BloodRequistionDetails> lstBloodRequest = new List<BloodRequistionDetails>();
                List<Patient> lstPatient = new List<Patient>();
                long RequestNo = 0;
                DateTime pFDT;
                DateTime pTDT;
                pFDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                pTDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                returnCode = new BloodBank_BL(base.ContextInfo).GetBloodRequestDetails(TaskBB.PatientID, TaskBB.PatientVisitID, pFDT, pTDT, out RequestNo, out lstBloodRequest, out lstPatient);
                TimeSpan ts = new TimeSpan();
                DateTime CurrentDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                ts = lstBloodRequest[0].TransfusionScheduledDate.Subtract(CurrentDate);
                if (ts.Days > 3)
                {
                    e.Row.BackColor = System.Drawing.Color.BurlyWood;
                }
                string strtemp = GetToolTipBloodBank(lstBloodRequest);
                e.Row.Cells[5].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                e.Row.Cells[5].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
            }
            if (t.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.CollectSample))
            {
                TimeSpan ts = new TimeSpan();
                DateTime CurrentDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                ts = CurrentDate.Subtract(t.TaskDate);
                if (ts.Days > 45)
                {
                    e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;
                    e.Row.Cells[14].Visible = true;
                    e.Row.Cells[14].ToolTip = "Delete this Task";
                    grdTasks.Columns[14].Visible = true;
                }
                else
                {
                    e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                    e.Row.Cells[4].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[5].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[6].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdTasks, "Select$" + e.Row.RowIndex));
                    e.Row.Cells[14].ToolTip = "Delete this Task";
                    e.Row.Cells[8].ToolTip = "Perform Quick Diagnosis";
                }
            }
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            TaskDetails PVD = (TaskDetails)e.Row.DataItem;
            List<OrderedInvestigations> lstPatientInvestigation = new List<OrderedInvestigations>();

            if (RoleHelper.LabTech == RoleName || RoleHelper.SrLabTech == RoleName || RoleHelper.Phlebotomist == RoleName || RoleHelper.Pathologist == RoleName || RoleHelper.JuniorDoctor == RoleName || RoleHelper.Doctor == RoleName)
            {
                LoginDetail objLoginDetail = new LoginDetail();
                objLoginDetail.LoginID = LID;
                objLoginDetail.RoleID = RoleID;
                objLoginDetail.Orgid = OrgID;
                invBL.GetInvestigationshowincollecttasks(PVD.PatientVisitID, OrgID, ILocationID, PVD.RefernceID, objLoginDetail, out lstPatientInvestigation);
                // invBL.GetInvestigationForVisit(PVD.PatientVisitID, OrgID, ILocationID, out lstPatientInvestigation);
                if (lstPatientInvestigation.Count > 0)
                {

                    string strtemp = GetToolTip(lstPatientInvestigation);
                    e.Row.Cells[5].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[5].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                    //e.Row.Cells[5].Style.Add("color", "Blue");
                }
            }
            if (t.IsTimedTask == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;
                //trTimedSamples.Attributes.Add("style", "display:block");
            }
            else if (t.ShowedTime == "YY")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
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
    }
    private string GetToolTipBloodBank(List<BloodRequistionDetails> ComponentList)
    {
        string TableHead = "";
        string TableDate = "";

        TableHead = "<table border=\"0\" cellpadding=\"0\"cellspacing=\"0\" class=\"taskDetailstip\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                    + "<tr style=\"font-weight: bold;\" class=\"tasktipHeader\"><td>" + Resources.ClientSideDisplayTexts.CommonControls_Tasks_ComponentList + "</td><td>" + Resources.ClientSideDisplayTexts.CommonControls_Tasks_NoOfUnits + "</td></tr>";
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
        TableHead = "<table border=\"0\" cellpadding=\"0\"cellspacing=\"0\" class=\"taskDetailstip\">"
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                    + "<tr style=\"font-weight: bold;\" class=\"tasktipHeader\"><td>" + Resources.ClientSideDisplayTexts.CommonControls_Tasks_InvestigationList + "</td><td>" + Resources.ClientSideDisplayTexts.CommonControls_Tasks_Status + "</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>"
                        + "<td>" + Item.DisplayStatus + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }

    protected void grdTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                //Added By Arivalagan.kk//
                SetDeptIDSession();
                //End Added By Arivalagan.kk//

                int RowIndex = Convert.ToInt32(e.CommandArgument);
                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                labNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]) + "&LNo=" + labNo + "&ClID=" + hdnSelectedClientID.Value + "&ClName=" + hdnSelectedClientName.Value;
                PatientOrgId = Convert.ToInt32(grdTasks.DataKeys[RowIndex][8]);
                string RNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                IsNeedNewApproval = GetConfigValue("NeedNewApproval", OrgID);
                if (IsNeedNewApproval == "Y")
                {
                    redirectURL = redirectURL.Replace("InvestigationApprovel", "InvApproval");
                }                
                //if (ddlDept.Items.FindByValue("26") == null )   // 26 - Histology Department
                //{
                //    redirectURL = redirectURL.Replace("InvestigationApprovel", "InvApproval");
                //}

                if (RNo != null && RNo != "")
                {
                    redirectURL = redirectURL + "&RNo=" + RNo;
                }
                if (isCashDoctor != null && isCashDoctor != "")
                {
                    redirectURL = redirectURL + "&isDoc=Y";
                }
                patientVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][3]);
                roleName = grdTasks.DataKeys[RowIndex][4].ToString();
                GridViewRow row = (GridViewRow)grdTasks.Rows[RowIndex];
                string user = grdTasks.DataKeys[RowIndex][6].ToString();
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (tbl.isExpired(iTaskID) && (RoleName != RoleHelper.Physiotherapist && RoleName != RoleHelper.Counselor))
                {
                    string sPath = "CommonControls\\\\Tasks.ascx.cs_1";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                    // this.GetType(), "msg", "alert('This Prescription is expired,the task will be deleted!!!')", true);


                    row.Style["color"] = "Red";
                    tbl.UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Deleted, LID);
                    GetTasks(currentPageNo, PageSize);
                }

                else if (tbl.isTaskAlreadyPicked(iTaskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
                {

                    GetTasks(currentPageNo, PageSize);
                    //lblResult.Text = "This task has already been picked by another user!!!";
                    string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
               this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
                    //     ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                    //this.GetType(), "msg", "alert('This task has already been picked by " + user + " ')", true);


                    row.Style["color"] = "Red";
                }

                else
                {
                    if (roleName == "Physician" || roleName == "Counselor" || roleName == "Physiotherapist")
                    {
                        tbl.UpdateTaskPickedBy(iTaskID, patientVisitID, LID);
                    }
                    else if (RoleName == RoleHelper.ChiefPathologist)
                    {
                        redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]);
                        Response.Redirect(redirectURL, true);
                    }
                    else
                    {
                        Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId, true);
                    }
                }
            }
            if (e.CommandName == "Redirect")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                labNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);

                redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]) + "&LNo=" + labNo;
                PatientOrgId = Convert.ToInt32(grdTasks.DataKeys[RowIndex][8]);
                string RNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);

                if (RNo != null && RNo != "")
                {
                    redirectURL = redirectURL + "&RNo=" + RNo;
                }
                if (isCashDoctor != null && isCashDoctor != "")
                {
                    redirectURL = redirectURL + "&isDoc=Y";
                }

                int rowindx;
                if (!string.IsNullOrEmpty(hdnCurrent.Value) && Convert.ToInt16(hdnCurrent.Value) > 1)
                    rowindx = (Convert.ToInt16(hdnCurrent.Value) - 1) * PageSize + RowIndex;
                else
                    rowindx = RowIndex;

                redirectURL = redirectURL + "&RowIndex=" + rowindx + "&otRows=" + hdntotrows.Value;

                patientVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][3]);
                roleName = grdTasks.DataKeys[RowIndex][4].ToString();
                GridViewRow row = (GridViewRow)grdTasks.Rows[RowIndex];
                string user = grdTasks.DataKeys[RowIndex][6].ToString();
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (tbl.isExpired(iTaskID) && (RoleName != RoleHelper.Physiotherapist && RoleName != RoleHelper.Counselor))
                {
                    string sPath = "CommonControls\\\\Tasks.ascx.cs_1";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl, this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                    // this.GetType(), "msg", "alert('This Prescription is expired,the task will be deleted!!!')", true);


                    row.Style["color"] = "Red";
                    tbl.UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Deleted, LID);
                    GetTasks(currentPageNo, PageSize);
                }

                else if (tbl.isTaskAlreadyPicked(iTaskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID))
                {

                    GetTasks(currentPageNo, PageSize);
                    //lblResult.Text = "This task has already been picked by another user!!!";
                    string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
               this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
                    //     ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                    //this.GetType(), "msg", "alert('This task has already been picked by " + user + " ')", true);


                    row.Style["color"] = "Red";
                }

                else
                {
                    if (roleName == "Physician" || roleName == "Counselor" || roleName == "Physiotherapist")
                    {
                        tbl.UpdateTaskPickedBy(iTaskID, patientVisitID, LID);
                    }
                    Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId, true);
                }
            }
            if (e.CommandName == "Delete")
            {
                long returncode = -1;
                //int RowIndex = Convert.ToInt32(e.CommandArgument);

                //iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);

                iTaskID = Convert.ToInt64(e.CommandArgument);

                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                taskBL.UpdateTask(Convert.ToInt64(iTaskID), TaskHelper.TaskStatus.Deleted, LID);

                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returncode = new Navigation().GetLandingPage(lstUserRole, out path);
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

                    GetTasks(currentPageNo, PageSize);
                    string sPath = "CommonControls\\\\Tasks.ascx.cs_2";
                    ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                        this.GetType(), "msg", "ShowAlertMsg('" + sPath + "');", true);
                    // ScriptManager.RegisterStartupScript(ctlTaskUpdPnl,
                    //this.GetType(), "msg", "alert('This task has already been picked by another user!!!')", true);

                    row.Style["color"] = "Red";
                }


                else
                {
                    if (roleName == "Physician" || roleName == "Counselor")
                    {
                        tbl.UpdateTaskPickedBy(iTaskID, patientVisitID, LID);
                    }
                    string TaskCategory = grdTasks.DataKeys[RowIndex][5].ToString();
                    if (TaskCategory == "Health Checkup")
                    {
                        Response.Redirect(@"../Physician/UnfoundDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + iPatientID + "&tid=" + iTaskID + "&id=0" + "", true); // 0 Refers to Unfound Diagnose Complaint ID
                    }
                    else
                    {
                        Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + iPatientID + "&tid=" + iTaskID + "&id=-1" + "", true); // -1 Refers to QuickDiagnose Complaint ID
                    }
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

    protected void grdTasks_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblResult.Text = "";
        if (e.NewPageIndex >= 0)
        {
            grdTasks.PageIndex = e.NewPageIndex;

            GetTasks(currentPageNo, PageSize);
        }
    }

    //protected void tmrPostback_Tick(object sender, EventArgs e)
    //{
    //    lblResult.Text = "";
    //    //GetTasks(currentPageNo, PageSize);
    //}

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
        if (jqueryTask == "Y")
        {
            PageSize = 0;
        }
        else
        {
            PageSize = 10;
        }
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
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    List<Speciality> lstSpeciality = new List<Speciality>();
    List<TaskActions> lstCategory = new List<TaskActions>();
    List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
    List<ClientMaster> lstClient = new List<ClientMaster>();
    List<MetaData> lstProtocal = new List<MetaData>();
    TaskProfile taskProfile = new TaskProfile();
    private void GetLocationAndSpeciality()
    {

        long retval = -1;
        taskProfile.Type = "Task";
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID,taskProfile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept,out lstClient,out lstProtocal);
        LoadLocation(lstLocation, taskProfile);
        LoadSpeciality(lstSpeciality, taskProfile);
        LoadCategory(lstCategory, taskProfile);
        LoadDates(lstTasks, taskProfile);
        LoadDept(lstDept, taskProfile);
        LoadClient(lstClient, taskProfile);
        LoadProtocal(lstProtocal,taskProfile);
        
        
        if (taskProfile.LoginID != 0)
        {
            GetTasks(currentPageNo, PageSize);
        }
        else
        {
            BindData(lstTasks);
        }

    }

    private void LoadClient(List<ClientMaster> lstClient, TaskProfile taskProfile)
    {
        try
        {
           // txtClientName.Text = lstClient.ToString();
            if (lstClient.Count > 0)
            {
                if (lstClient[0].ClientID != null && lstClient[0].ClientName != "")
                {
                    txtClientName.Text = lstClient[0].ClientName;
                    hdnSelectedClientID.Value = lstClient[0].ClientID.ToString();
                }
                else
                {
                    txtClientName.Text = "";
                    hdnSelectedClientID.Value = "-1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ClientName", ex);
        }
    }
    string strAllItem = Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_02 == null ? "(ALL)" : Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_02;
    private void LoadLocation(List<OrganizationAddress> lstLocation, TaskProfile taskProfile)
    {
        try
        {
            //string sLoId = taskProfile.Location == "" ?  : taskProfile.Location;
            ddLO.DataSource = lstLocation;
            ddLO.DataTextField = "Location";
            ddLO.DataValueField = "AddressID";
            ddLO.DataBind();
            ddLO.Items.Insert(0, "" + strAllItem.Trim() + "");
            ddLO.Items[0].Value = "0";
            string location = string.Empty;
            if (taskProfile.Location == "")
            {
                location = ILocationID.ToString();
            }
            else
            {
                location = taskProfile.Location;
            }
            if (ddLO.Items.Count > 0)
            {
                int itemIndex = ddLO.Items.IndexOf(ddLO.Items.FindByValue(location));
                if (itemIndex >= 0)
                {
                    ddLO.SelectedIndex = itemIndex;
                }
            }
            //    string sSelected = ddLO.Items.Count > 0 ? ddLO.SelectedValue : "-1";
            //    ddLO.Items.Clear();
            //    ListItem itm;
            //    ListItem itm1 = new ListItem();

            //    if (sSelected != "-1")
            //    {
            //        if (taskProfile.LoginID != 0)
            //        {
            //            sSelected = taskProfile.OrgAddressID.ToString();
            //        }
            //    }
            //    itm = new ListItem("(All)", "-1");
            //    ddLO.Items.Add(itm);
            //    foreach (OrganizationAddress loc in lstLocation)
            //    {
            //        itm = new ListItem();
            //        if (loc.Location == "")
            //        {
            //            itm.Text = "(Blank)";
            //            itm.Value = "";
            //        }
            //        else
            //        {
            //            itm.Text = loc.Location;
            //            itm.Value = loc.AddressID.ToString();
            //        }

            //        if (!ddLO.Items.Contains(itm))
            //        {
            //            if (itm.Value == "")
            //            {
            //                ddLO.Items.Insert(1, itm);
            //            }
            //            else
            //            {
            //                ddLO.Items.Add(itm);
            //            }

            //        }
            //    }
            // ddLO.SelectedValue = sSelected;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading location", ex);
        }
    }

    private void LoadSpeciality(List<Speciality> lstSpeciality, TaskProfile taskProfile)
    {
        if (lstSpeciality.Count > 0)
        {
            ddSPE.DataSource = lstSpeciality;
            ddSPE.DataTextField = "SpecialityName";
            ddSPE.DataValueField = "SpecialityID";
            ddSPE.DataBind();
           
        }
        ddSPE.Items.Insert(0, "" + strAllItem.Trim() + "");
        ddSPE.Items[0].Value = "0";
        ddSPE.SelectedValue = taskProfile.SpecialityID.ToString();

        //string sSelected = ddSPE.Items.Count > 0 ? ddSPE.SelectedValue : "-1";
        //ddSPE.Items.Clear();
        //ListItem itm;
        //ListItem itm1 = new ListItem();
        //if (sSelected == "-1")
        //{
        //    if (taskProfile.LoginID != 0)
        //    {
        //        sSelected = taskProfile.SpecialityID.ToString();
        //    }
        //}

        //itm = new ListItem("(All)", "-1");
        //ddSPE.Items.Add(itm);

        //foreach (Speciality spe in lstSpeciality)
        //{
        //    itm = new ListItem();
        //    if (spe.SpecialityName == "")
        //    {
        //        itm.Text = "(Blank)";
        //        itm.Value = "";
        //    }
        //    else
        //    {
        //        itm.Text = spe.SpecialityName;
        //        itm.Value = spe.SpecialityID.ToString();
        //    }

        //    if (!ddSPE.Items.Contains(itm))
        //    {
        //        if (itm.Value == "")
        //        {
        //            ddSPE.Items.Insert(1, itm);
        //        }
        //        else
        //        {
        //            ddSPE.Items.Add(itm);
        //        }
        //        if (itm.Value.Equals(sSelected))
        //        {
        //            itm.Selected = true;
        //        }
        //    }
        //}

    }

    private DateTime dt;

    private void GetAllData(string strDate, string category, long orgAddrId, int specialityId, string PatientNumber, int InvLocationID, int startRowIndex, int pageSize, out int totalRows, int DeptID, long Clientid, long ProtocalGroupID,int VisitType)
    {
        int row = 0;
        dt = DateTime.MinValue;
        System.Data.SqlTypes.SqlDateTime getDate;
        getDate = System.Data.SqlTypes.SqlDateTime.Null;
        long retval = -1;
        long ret = -1;
        int ActionCount = 0;
        string BarcodeNumber = string.Empty;
         VisitType = 0;
        Tasks_BL tasksBL = new Tasks_BL(base.ContextInfo);
        List<TaskDetails> lstTasks = new List<TaskDetails>();
        LoginDetail objLoginDetail = new LoginDetail();
        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
        TrustedOrgActions objTrustedOrgActions = new TrustedOrgActions();
        int SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
        string SearchType = "TASK";
        string allocatedtasks = string.Empty;  //kapil
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        objTrustedOrgActions.LoggedOrgID = OrgID;
        objTrustedOrgActions.SharingOrgID = 0;
        objTrustedOrgActions.IdentifyingType = SearchType;
        objTrustedOrgActions.IdentifyingActionID = SerachTypeID;
        objTrustedOrgActions.RoleID = RoleID;
        if (ddlprotocalgroup.SelectedItem != null )
        {
            Int64.TryParse(ddlprotocalgroup.SelectedItem.Value, out ProtocalGroupID);
        }
       
        lstTrustedOrgActions.Add(objTrustedOrgActions);
        objTrustedOrgActions = new TrustedOrgActions();
        SerachTypeID = Convert.ToInt32(TaskHelper.TaskAction.Coauthorize);
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

        if (txtBarcode.Text != "")
        {
            BarcodeNumber = txtBarcode.Text;
        }
        if (ddlVisitType.SelectedValue != "")
        {
            VisitType = Convert.ToInt32(ddlVisitType.SelectedValue);
        }
        if(chkTimedSamples.Checked)
        {
            base.ContextInfo.AdditionalInfo = "Y";
        }
///kapil
        if (chktasks.Checked == true)
        {
            allocatedtasks = "Y";
        }
        else
        {
            allocatedtasks = "N";
        }
        jqueryTask = GetConfigValue("Jquery Task", OrgID);
        //kapil
        if (RoleName != RoleHelper.SrLabTech && RoleName != RoleHelper.Doctor && RoleName != RoleHelper.Pathologist && RoleName != RoleHelper.SeniorDoctor && RoleName != RoleHelper.JuniorDoctor)
        {
            if (jqueryTask == "Y")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetCollectSampleTask", "fnGetCollectSampleTask('" + RoleID + "','" + OrgID + "','" + LID + "','" + strDate + "','" + category + "','" + orgAddrId + "','" + specialityId + "','" + PatientNumber + "','" + InvLocationID + "','" + startRowIndex + "','" + pageSize + "','" + DeptID + "','" + Clientid + "','" + ddlPriority.SelectedValue + "','" + ProtocalGroupID + "');", true);
                grdTasks.Visible = false;
                divFooterNav.Visible = false;
                PageSize = 0;
            }
            else
            {
                PageSize = 10;
                retval = tasksBL.GetAllTasks(RoleID, OrgID, LID, strDate, category, orgAddrId, specialityId, PatientNumber, out lstTasks, InvLocationID, startRowIndex, pageSize, out totalRows, DeptID, Clientid, objLoginDetail, lstTrustedOrgActions, ddlPriority.SelectedValue, ProtocalGroupID,VisitType);
                row = totalRows;
            }
        }
        else if (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.Doctor || RoleName == RoleHelper.Pathologist || RoleName == RoleHelper.SeniorDoctor || RoleName == RoleHelper.JuniorDoctor)
        {
            if (jqueryTask == "Y")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetApprovalTask", "fnGetApprovalTask('" + RoleID + "','" + OrgID + "','" + LID + "','" + strDate + "','" + category + "','" + orgAddrId + "','" + specialityId + "','" + PatientNumber + "','" + InvLocationID + "','" + startRowIndex + "','" + pageSize + "','" + DeptID + "','" + Clientid + "','" + allocatedtasks + "','" + ddlPriority.SelectedValue + "','" + ProtocalGroupID + "');", true);
                grdTasks.Visible = false;
                divFooterNav.Visible = false;
                PageSize = 0;
            }
            else
            {
                PageSize = 10;
                retval = tasksBL.GetAllTasksStat(RoleID, OrgID, LID, strDate, category, orgAddrId, specialityId, PatientNumber, out lstTasks, InvLocationID, startRowIndex, pageSize, out totalRows, DeptID, Clientid, allocatedtasks, objLoginDetail, lstTrustedOrgActions, ddlPriority.SelectedValue, ProtocalGroupID,BarcodeNumber,VisitType);
                row = totalRows;
            }
        }
        totalRows = row;
        totalpage = totalRows;
        if (jqueryTask != "Y")
        {
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        }
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
        if (RoleName == "Phlebotomist")
        {
            trTimedSamples.Attributes.Add("style", "display:block");
            trht.Visible = true;
        }

        if (retval == 0 && lstTasks.Count > 0)
        {
            BindData(lstTasks);
            TaskCount = lstTasks.Count;
            //trTimedSamples.Attributes.Add("style", "display:block");
            
        }
        else
        {
            //trTimedSamples.Attributes.Add("style", "display:none");
            NoResult();
        }

    }
    private long _taskCount;
    public long TaskCount
    {
        get { return _taskCount; }
        set { _taskCount = value; }
    }
    string strTaskPending = Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_03 == null ? "You don't have any task pending!!! &nbsp;&nbsp;&nbsp;Click Here To" : Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_03;
    private void NoResult()
    {
        grdTasks.Visible = false;
        lblResult.Visible = true;
        divFooterNav.Visible = false;
        lblResult.Text = strTaskPending.Trim();
        //HideFilterPanel();
    }

    private void BindData(List<TaskDetails> lstTasks)
    {

        grdTasks.Visible = true;
        divFooterNav.Visible = true;
        lblResult.Visible = true;
        lblResult.Text = strClickHere.Trim();
        grdTasks.DataSource = lstTasks;
        grdTasks.DataBind();

    }

    private void LoadDummyValues()
    {
        ddTD.Items.Clear();
        ddCat.Items.Clear();
        ddLO.Items.Clear();
        ddSPE.Items.Clear();


        ListItem itm = new ListItem("" + strAllItem.Trim() + "", "-1");
        //itm.Selected = true;
        ddTD.Items.Add(itm);
        ddCat.Items.Add(itm);
        ddLO.Items.Add(itm);
        ddSPE.Items.Add(itm);
    }

    string strToday = Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_04 == null ? "(ToDay)" : Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_04;
    private void LoadDates(List<TaskDetails> lstTasks, TaskProfile taskProfile)
    {
        string sSelected = ddTD.Items.Count > 0 ? ddTD.SelectedValue : "-1";
        ddTD.Items.Clear();
        ListItem itm = new ListItem("" + strToday.Trim() + "", "ToDay");
        ddTD.Items.Add(itm);
        ListItem itm1 = new ListItem("" + strAllItem.Trim() + "", "ALL");
        ddTD.Items.Add(itm1);
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
        ddCat.DataTextField = "Category";
        ddCat.DataValueField = "Category";
        ddCat.DataBind();
        ddCat.Items.Insert(0, "" + strAllItem.Trim() + "");
        ddCat.Items[0].Value = "0";

        ddCat.SelectedValue = taskProfile.Category;


        //string sSelected = ddCat.Items.Count > 0 ? ddCat.SelectedValue : "-1";

        //ddCat.Items.Clear();
        //ListItem itm;
        //ListItem itm1=new ListItem();
        //if (sSelected == "-1")
        //{
        //    if (taskProfile.LoginID != 0)
        //    {
        //        sSelected = taskProfile.Category.ToString();
        //    }
        //}

        //itm = new ListItem("(All)", "-1");
        //ddCat.Items.Add(itm);


        //foreach (TaskActions tsk in lstTasks)
        //{
        //    itm = new ListItem();
        //    if (tsk.Category == "")
        //    {
        //        itm.Text = "(Blank)";
        //        itm.Value = "";
        //    }
        //    else
        //    {
        //        itm.Text = tsk.Category;
        //        itm.Value = tsk.;
        //    }

        //    if (!ddCat.Items.Contains(itm))
        //    {
        //        if (itm.Value == "")
        //        {
        //            ddCat.Items.Insert(1, itm);
        //        }
        //        else
        //        {
        //            ddCat.Items.Add(itm);
        //        }
        //        if (itm.Value.Equals(sSelected))
        //        {
        //            itm.Selected = true;
        //        }
        //    }

        //}s

    }

    public void GetTasks(int currentPageNo, int PageSize)
    {
        TaskProfile taskprofile = new TaskProfile();
        taskprofile.LoginID = LID;
        taskprofile.RoleID = Convert.ToInt64(RoleID);
        taskprofile.OrgID = OrgID;
        taskprofile.OrgAddressID = ILocationID;
        taskprofile.Location = ddLO.SelectedValue;
        taskprofile.Type = "Task";
        
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
        if (ddlDept.SelectedValue != "")
        {
            taskprofile.DeptID = Convert.ToInt32(ddlDept.SelectedValue);
        }
        else
        {
            taskprofile.DeptID = 0;
        }
        if (ddlprotocalgroup.SelectedValue !="")
        {
            taskprofile.ProtocalGroupId = Convert.ToInt64(ddlprotocalgroup.SelectedValue);
        }
        else
        {
            taskprofile.ProtocalGroupId = 0;
        }
        // int startRowIndex, int pageSize, out int totalRows, 
        string sDate = "";
        //;
        if (ddTD.SelectedValue == "ToDay" && txtpendingDays.Text!="")
        {
            string Fromdate = string.Empty;            
            //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            int pendingdays = Convert.ToInt16(txtpendingDays.Text);
            // Calculating the Late's date (substracting days from current date.) 
            DateTime yesterday = DateTime.Today.AddDays(-(pendingdays));
            Fromdate = yesterday.ToString("dd/MM/yyyy");
            sDate = Fromdate;
        }
        if (ddTD.SelectedValue == "ToDay" && txtpendingDays.Text == "")
        {
            //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            sDate = OrgTimeZone;
        }

        if (ddTD.SelectedValue == "ALL"  && txtpendingDays.Text=="" )
        {
            sDate = "-1";
        }
        if (ddTD.SelectedValue == "ALL" && txtpendingDays.Text != "")
        {
            string Fromdate = string.Empty;
            //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            int pendingdays = Convert.ToInt16(txtpendingDays.Text);
            // Calculating the Late's date (substracting days from current date.) 
            DateTime yesterday = DateTime.Today.AddDays(-(pendingdays));
            Fromdate = yesterday.ToString("dd/MM/yyyy");
            sDate = Fromdate;
        }

        if (ddTD.SelectedValue != "ALL" && ddTD.SelectedValue != "ToDay" && txtpendingDays.Text=="")
        {
            sDate = ddTD.SelectedValue;
        }
        if (ddTD.SelectedValue != "ALL" && ddTD.SelectedValue != "ToDay" && txtpendingDays.Text != "")
        {
            string Fromdate = string.Empty;
            int pendingdays = Convert.ToInt16(txtpendingDays.Text);           
            // Calculating the Late's date (substracting days from current date.) 
            //DateTime yesterday = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-(pendingdays));
            //DateTime sram;           

            DateTime s = Convert.ToDateTime(ddTD.SelectedValue.ToString());
            s = s.Date.AddDays(-pendingdays);
            Fromdate = s.ToString("dd/MM/yyyy");
            sDate = Fromdate; 
              
        }
        string sCat = ddCat.SelectedValue == "0" ? "-1" : ddCat.SelectedValue;
        string sLoc = ddLO.SelectedValue == "0" ? "-1" : ddLO.SelectedValue;
        if (sLoc == "")
        {
            sLoc = "-1";
        }
        string sSpec = ddSPE.SelectedValue == "0" ? "-1" : ddSPE.SelectedValue;
        if (sSpec == "")
        {
            sSpec = "-1";
        }
        string sDept = ddlDept.SelectedValue == "0" ? "-1" : ddlDept.SelectedValue;
        int inventoryLocationID = Attune.Podium.Common.RoleHelper.Inventory == RoleName ? InventoryLocationID : 0;
        if (txttext.Text.Trim() == defaultText.Trim())
        {
            txttext.Text = "";
        }
        if (rdnLabNo.Checked == true & txttext.Text != "")
        {

            Labno = "1/" + txttext.Text;
            txttext.Text = Labno;
            PatientNumber = txttext.Text == "" ? "-1" : txttext.Text;
            hdntxttext.Value = PatientNumber;
        }
        if (ChkBoxServiceNum.Checked == true & txttext.Text != "")
        {
            ServiceNo = "2/" + txttext.Text;
            txttext.Text = ServiceNo;
            PatientNumber = txttext.Text == "" ? "-1" : txttext.Text;
            hdntxttext.Value = PatientNumber;
        }

        else
        {
            PatientNumber = txttext.Text == "" ? "-1" : txttext.Text;
            hdntxttext.Value = PatientNumber;
        }
        int ClientID = 0;
        if (hdnSelectedClientID.Value != null && hdnSelectedClientID.Value != "0")
        {
            Int32.TryParse(hdnSelectedClientID.Value, out ClientID);
        }
        if (hdnSelectedClientID.Value == "0")
        {
            if (txtClientName.Text != null && txtClientName.Text != "")
            {
                if (Request.QueryString["CLID"] != null)
                {
                    Int32.TryParse(Request.QueryString["CLID"], out ClientID);
                }
            }
        }
        
        //string PatientNumber = txtPatientNumber.Text == "" ? "-1" : txtPatientNumber.Text;
        GetAllData(sDate, sCat, Convert.ToInt64(sLoc), Convert.ToInt32(sSpec), PatientNumber, inventoryLocationID, currentPageNo, PageSize, out totalRows, Convert.ToInt32(sDept), ClientID, ProtocalGroupID, Convert.ToInt32(ddlVisitType.SelectedValue));
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
            taskprofile.OrgID = OrgID;
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.Type = "Task";
            if (ddLO.SelectedValue != "")
            {
                taskprofile.Location = ddLO.SelectedValue;
            }
            else
            {
                taskprofile.Location = ILocationID.ToString();
            }

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
            if (ddlDept.SelectedValue != "")
            {
                taskprofile.DeptID = Convert.ToInt32(ddlDept.SelectedValue);
            }
            else
            {
                taskprofile.DeptID = 0;
            }
            if (ddlprotocalgroup.SelectedValue !="0")
            {
                taskprofile.ProtocalGroupId = Int64.Parse(ddlprotocalgroup.SelectedValue.ToString());
            }
            else
            {
                taskprofile.ProtocalGroupId = 0;
            }
           if(string.IsNullOrEmpty(txtClientName.Text))
              hdnSelectedClientID.Value="";

            if (hdnSelectedClientID.Value!= "")
            {
                taskprofile.ClientID= Convert.ToInt32(hdnSelectedClientID.Value);
            }
            else
            {
                taskprofile.ClientID = -1;
                hdnSelectedClientID.Value ="0";
            }

            if (chkSetDefault.Checked)
            {
                retval = taskBL.InsertDefault(taskprofile);
                GetTasks(currentPageNo, PageSize);
            }
            else
            {
                GetTasks(currentPageNo, PageSize);
            }
            //if (chkSetDefault.Checked == true)
            //{
            //    chkSetDefault.Checked = false;
            //}
            SetDeptIDSession();
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
            if (txttext.Text.Trim() == defaultText.Trim())
            {
                txttext.Text = "";
            }
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
                if (lblResult.Text != "You don't have any task pending!!! &nbsp;&nbsp;&nbsp;Click Here To")
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "Barcode", " Click();", true);
                }
            }

            txtwatermark();

        }
        catch
        {
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

    private void LoadDept(List<InvDeptMaster> lstDept, TaskProfile taskProfile)
    {
        string all = Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02 == null ? "---All---" : Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02;
        ddlDept.DataSource = lstDept;
        ddlDept.DataTextField = "DeptName";
        ddlDept.DataValueField = "DeptID";
        ddlDept.DataBind();
        ddlDept.Items.Insert(0, strAllItem);
        //ddlDept.Items.Insert(0, "(ALL)");
        ddlDept.Items[0].Value = "0";
        if (taskProfile.DeptID.ToString() != "-1")
        {
            ddlDept.SelectedValue = taskProfile.DeptID.ToString();
        }
    }
    private void LoadProtocal(List<MetaData> lstProtocal, TaskProfile taskProfile)
    {
        if (lstProtocal.Count > 0)
        {
            if (lstProtocal[0].Code.ToString() != "")
            {
                ddlprotocalgroup.SelectedValue = lstProtocal[0].Code.ToString();
            }
            else
            {
                ddlprotocalgroup.SelectedValue = "0";

            }
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
        //if (ddLO.SelectedValue != "0" && ddSPE.SelectedValue == "" && ddlDept.SelectedValue == "0" && ddCat.SelectedValue == "0" && ddTD.SelectedValue != "ALL")
        //{
        //    GetData(currentPageNo, PageSize);
        //}
        //else
        //{

        //    GetTasks(currentPageNo, PageSize);
        //}

        //  GetData(currentPageNo, PageSize);

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

        ////if (PatientSearch == true)
        ////{
        ////    if ((ddlVisitType.SelectedItem.Value != hdnVisitType.Value) || (txtPatientSearch.Text != hdnPatientName.Value))
        ////    {
        ////        lblCurrent
        ////        lblCurrent.Text = "0";
        ////    }
        ////}

        //if (txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1"))
        //{
        //    PerformPatientSearch(currentPageNo, PageSize);
        //}
        //else
        //{

        //GetData(currentPageNo, PageSize);
        // }
        GetTasks(currentPageNo, PageSize);

        //if (ddLO.SelectedValue != "0" && ddSPE.SelectedValue == "" && ddlDept.SelectedValue == "0" && ddCat.SelectedValue == "0" && ddTD.SelectedValue != "ALL" )
        //{
        //    GetData(currentPageNo, PageSize);
        //}
        //else 
        //{

        //}









    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;

            string domains = "Preference,VisitType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
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
                   ddlPriority.SelectedValue = "All";
                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  orderby child.DisplayText ascending
                                  select child;

                ddlVisitType.DataSource = childItems2;
                ddlVisitType.DataTextField = "DisplayText";
                ddlVisitType.DataValueField = "Code";
                ddlVisitType.DataBind();

               
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
        }
    }

    public void Loadprotocalgroup()
    {
        try
        {
            long returncode = -1;
            string domains = "ProtocalGroup_Based";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ProtocalGroup_Based"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlprotocalgroup.DataSource = childItems;
                    ddlprotocalgroup.DataTextField = "DisplayText";
                    ddlprotocalgroup.DataValueField = "Code";
                    ddlprotocalgroup.DataBind();
                    ddlprotocalgroup.Items.Insert(0, Select);
                    ddlprotocalgroup.Items[0].Value = "0";
                }
            }
            //if (taskProfile.ProtocalGroupId.ToString() != "-1")
            //    ddlprotocalgroup.SelectedValue = taskProfile.ProtocalGroupId.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadMetaData() in Test Master", ex);
        }
    }

    public void LoadVisitType()
    {
        try
        {
            long returncode = -1;
            string domains = "VisitType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;
				ddlVisitType.DataSource=null;
				ddlVisitType.DataBind();
                ddlVisitType.DataSource = childItems2;
                ddlVisitType.DataTextField = "DisplayText";
                ddlVisitType.DataValueField = "Code";
                ddlVisitType.DataBind();
            }
            //if (taskProfile.ProtocalGroupId.ToString() != "-1")
            //    ddlprotocalgroup.SelectedValue = taskProfile.ProtocalGroupId.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadMetaData() in Test Master", ex);
        }
    }
}

