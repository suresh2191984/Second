using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using Attune.Podium.PerformingNextAction;
public partial class Lab_HoldAndUnholdReports : BasePage
{
    public Lab_HoldAndUnholdReports()
        : base("Lab_HoldAndUnholdReports_aspx")
    {
    }
    /*Dec Part*/
    List<TaskDetails> lstTasks = new List<TaskDetails>();
    /*Dec Part Sabari*/
    private long iPatientID;
    private long PatientOrgId;
    private long iTaskID;
    private string redirectURL;
    private long patientVisitID;
    public long TaskID = -1;
    string labNo = string.Empty;
    /*For Unhold Taks Pagination*/
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string jqueryTask = string.Empty;
    


    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    int hdnSelectedClientID = 0;
    string hdnSelectedClientName = Convert.ToString(-1);
    
    /*Sabari added End*/

    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
    List<PatientVisit> lstpatientVisit = new List<PatientVisit>();
    List<MetaValue_Common> lstMetavalue = new List<MetaValue_Common>();
    Patient_BL patientBL;
    string patientnumber = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;

    #region "Common Resource Property"

    string strAlert = Resources.Lab_AppMsg.Lab_Header_Alert == null ? "Alert" : Resources.Lab_AppMsg.Lab_Header_Alert;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            divFooterNav.Visible = false;
            LoadUnholdTasks(currentPageNo, PageSize);
        }
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #endregion
    #region "Events"
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string _VisitNumber, _LabNumber, _PatientName;

        _VisitNumber = txtvisitno.Text;
        _LabNumber = txtPatientSearch.Text;
        _PatientName = txtPname.Text;

        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;

        /*New Part Added By sabari For INvestigationApprovel And Hold*/
        if (ChkUnHoldbtn.Checked == true && _VisitNumber == "" && _LabNumber == "" && _PatientName=="")
        {
            LoadUnholdTasks(currentPageNo, PageSize);
        }
        else
        {
            
            Investigation_BL obj = new Investigation_BL(base.ContextInfo);
            obj.GetInvestigatonResultsCaptureHoldOrApprovelTaskDetailsByVID(_VisitNumber, _LabNumber, _PatientName, objLoginDetail, out lstTasks);
            if (lstTasks != null && lstTasks.Count > 0)
            {
                iPatientID = lstTasks[0].PatientID;
                if (iPatientID != null && iPatientID != 0)
                {
                    iTaskID = lstTasks[0].TaskID;
                    labNo = lstTasks[0].RefernceID;
                    redirectURL = Convert.ToString(lstTasks[0].RedirectURL + "&LNo=" + labNo + "&ClID=" + hdnSelectedClientID + "&ClName=" + hdnSelectedClientName);
                    PatientOrgId = lstTasks[0].OrgID;
                    string RNo = Convert.ToString(labNo);
                    if (RNo != null && RNo != "")
                    {
                        redirectURL = redirectURL + "&RNo=" + RNo;
                    }
                    Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId, true);
                }
            }
        }
        /*End sabari added*/


    }
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
                grdTasks.Columns[16].Visible = true;
            }
            else
            {
                // grdTasks.Columns[17].Visible = false ;
                grdTasks.Columns[16].Visible = false;
            }
            if (oldapproval_hide == "Y")
            {
                //   grdTasks.Columns[17].Visible = true;
                grdTasks.Columns[15].Visible = false;
            }
            else
            {
                // grdTasks.Columns[17].Visible = false ;
                grdTasks.Columns[15].Visible = true;
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
        //if (IsNeedLabNo == "Y")
        //{
            grdTasks.Columns[13].Visible = true;
        //}
        //if (hdnActionCount.Value != "0")
        //{
            grdTasks.Columns[15].Visible = true;
       // }
    }
    protected void grdTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                //Added By Arivalagan.kk//
                ////SetDeptIDSession();
                //End Added By Arivalagan.kk//

                int RowIndex = Convert.ToInt32(e.CommandArgument);
                iPatientID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][0]);
                iTaskID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][1]);
                labNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                redirectURL = Convert.ToString(grdTasks.DataKeys[RowIndex][2]) + "&LNo=" + labNo + "&ClID=" + hdnSelectedClientID + "&ClName=" + hdnSelectedClientName;
                PatientOrgId = Convert.ToInt32(grdTasks.DataKeys[RowIndex][8]);
                string RNo = Convert.ToString(grdTasks.DataKeys[RowIndex][9]);
                

                if (RNo != null && RNo != "")
                {
                    redirectURL = redirectURL + "&RNo=" + RNo;
                }
                //if (isCashDoctor != null && isCashDoctor != "")
                //{
                    redirectURL = redirectURL + "&IsHold=Y";
                //}
                patientVisitID = Convert.ToInt32(grdTasks.DataKeys[RowIndex][3]);
                //roleName = grdTasks.DataKeys[RowIndex][4].ToString();
                GridViewRow row = (GridViewRow)grdTasks.Rows[RowIndex];
                string user = grdTasks.DataKeys[RowIndex][6].ToString();

                Response.Redirect(redirectURL + "&POrgID=" + PatientOrgId, true);
                
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
        //lblResult.Text = "";
        //if (e.NewPageIndex >= 0)
        //{
        //    grdTasks.PageIndex = e.NewPageIndex;

        //    GetTasks(currentPageNo, PageSize);
        //}
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
        LoadUnholdTasks(currentPageNo, PageSize);
        

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
        LoadUnholdTasks(currentPageNo, PageSize);

    }
    protected void btnPageGo_Click(object sender, EventArgs e)
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

            LoadUnholdTasks(Convert.ToInt32(txtpageNo.Text), PageSize);
        }

        txtpageNo.Text = "";


    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long Returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            string Showconfidential = string.Empty;
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    #endregion
    #region "Methods"
    public void LoadUnholdTasks(int currentPageNo, int PageSize)
    {
        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;

        PageSize = 10;
        int row = 0;
        Investigation_BL obj = new Investigation_BL(base.ContextInfo);
        obj.GetInvestigatonResultsCaptureUnHoldTaskDetails(currentPageNo, PageSize, out totalRows, objLoginDetail, out lstTasks);
        if (lstTasks.Count > 0)
        {
            BindData(lstTasks);
        }
        row = totalRows;
        totalpage = totalRows;
        /*For Footer Paging*/
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
        /*End*/
    }
    private void BindData(List<TaskDetails> lstTasks)
    {

        grdTasks.Visible = true;
        divFooterNav.Visible = true;
        //lblResult.Visible = true;
        //lblResult.Text = strClickHere.Trim();
        grdTasks.DataSource = lstTasks;
        grdTasks.DataBind();

    }
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
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            Int32 orgId = 0;
            if (!String.IsNullOrEmpty(hdnOrgId.Value))
            {
                Int32.TryParse(hdnOrgId.Value, out orgId);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
    #endregion






}


