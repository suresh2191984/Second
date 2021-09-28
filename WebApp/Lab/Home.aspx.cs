using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;



using System.IO;
using Attune.Podium.BillingEngine;

using System.Text;
using System.Security.Cryptography;

using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using System.Web.Script.Serialization;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;
public partial class Lab_Home : BasePage
{
    public Lab_Home()
        : base("Lab_Home_aspx")
    {
    }
    string lab = Resources.Lab_ClientDisplay.Lab_Home_aspx_lab == null ? "Lab Number" : Resources.Lab_ClientDisplay.Lab_Home_aspx_lab;
    string visit = Resources.Lab_ClientDisplay.Lab_Home_aspx_visit == null ? "Visit Number" : Resources.Lab_ClientDisplay.Lab_Home_aspx_visit;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;

    int currentPageNo = 1;

    int PageSize = 0;
    int totalRows = 0;
    int totalpage = 0;
    static bool PatientSearch = false;
    long returncode = -1;
    string Visitnumber = string.Empty;
    string Patnumber = string.Empty;
    String SampleID = string.Empty;
    string InvID = string.Empty;
    string Type = string.Empty;
    string Fromdate = string.Empty;
    string Todate = string.Empty;
    long deptID = -1;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string IsTimed = string.Empty;
    long ProtocalGroupID = -1;
    string IsSetDefault = string.Empty;
    string jqueryTask = string.Empty;
    string SavePageNo = string.Empty;
	string WatersChk = string.Empty;
    string IsHospitalLab = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        WatersChk = GetConfigValue("WatersMode", OrgID);
        if (WatersChk == "Y")
        {
            CommonToAll.Visible = false;
            Waters.Visible = true;
            DeptFilter.ContextKey = OrgID.ToString();
            GridView1.Columns[1].Visible = false;
            txtFromWaters.Attributes.Add("onchange", "ExcedDate('" + txtFromWaters.ClientID.ToString() + "','',0,0);");
            txtTowaters.Attributes.Add("onchange", "ExcedDate('" + txtTowaters.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTowaters.ClientID.ToString() + "','txtFromWaters',1,1);");

        }
        IsHospitalLab = GetConfigValue("IsHospitalLab", OrgID);
        if (IsHospitalLab == "Y")
        {
            lblLocation.Visible = true;
            ddlLocation.Visible = true;
        }
        else
        {
            ddlLocation.Visible = false;
            lblLocation.Visible = false;
        }
        if ((Request.QueryString["TkCnt"] != null) && (Request.QueryString["TkCnt"] != ""))
        {
            currentPageNo = Convert.ToInt32(Request.QueryString["TkCnt"].ToString());
        }
        //uctlTaskList. onTaskSelectFailed += new EventHandler(uctlTaskList_onTaskSelectFailed);
        if (RoleName == RoleHelper.LabTech || RoleName == "Physician Assistant")
        {
            uctlTaskList.Visible = false;
        }
        else
        {
            uctlTaskList.onTaskLoadComplete += new EventHandler(uctlTaskList_onTaskLoadComplete);
        }

        //DropDownList objDropDownList = (DropDownList)uctlTaskList.FindControl("ddCat");         // ((CommonControls_TasksNew)(uctlTaskList)).ddCat.
        //objDropDownList.Attributes.Add("onchange", "ddlValuesCheck(this)");
        //uctlTaskList.o

        hdnOrgID.Value = OrgID.ToString();
        CheckBox chk = uctlTaskList.SetChkBoxVisible;
        string chklabNo = GetConfigValue("NeedLabNo", OrgID);
        if (chklabNo == "Y")
        {
            chk.Visible = true;
        }
        else
        {
            chk.Visible = false;
        }
        uctlTaskList.OnPopLoad += new EventHandler(uctlTaskList_OnPopLoad);
        string sVal = GetConfigValue("InvNameDisplay", OrgID);
        //Added  By Arivalagan.kk//
        String NeedAberrantQ = GetConfigValue("NeedAberrantQ", OrgID);
        jqueryTask = GetConfigValue("Jquery Task", OrgID);
        //End  Addede by Arivalagan.kk//
        if (sVal == "Y")
        {
            uctlTaskList.grdview(12, true);
        }
        else
        {
            uctlTaskList.grdview(12, false);
        }
        string showtask = GetConfigValue("Allocatedtask", OrgID);
        if (showtask == "Y")
        {
            chktasks.Visible = true;
        }
        else
        {
            chktasks.Visible = false;
        }
        string Taskfilter_clientbasis = GetConfigValue("Task_Filter_for_client_basis", OrgID);
        if (Taskfilter_clientbasis == "Y")
        {
            lblSourceName.Visible = true;
            lblProtocal.Visible = false;
            ddlprotocalgroup.Visible = false;
            ddlSourceName.Visible = true;
        }
        else
        {
            lblSourceName.Visible = false;
            ddlSourceName.Visible = false;

        }
        SavePageNo = GetConfigValue("SavePageNo", OrgID);
        if (!IsPostBack)
        {
            //if (!String.IsNullOrEmpty(Request.QueryString["gUID"]) && !String.IsNullOrEmpty(Request.QueryString["vid"]) && !String.IsNullOrEmpty(Request.QueryString["sampleId"]) && !String.IsNullOrEmpty(Request.QueryString["categoryCode"]))
            //{
            //    string Guid = string.Empty;
            //    long visitId = -1;
            //    string categoryCode = string.Empty;
            //    string lstSampleId = string.Empty;
            //    Guid = Convert.ToString(Request.QueryString["gUID"]);
            //    lstSampleId = Convert.ToString(Request.QueryString["sampleId"]);
            //    Int64.TryParse(Request.QueryString["vid"], out visitId);
            //    categoryCode = Convert.ToString(Request.QueryString["categoryCode"]);
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Window", "window.open('../admin/PrintBarcode.aspx?visitId=" + visitId + "&sampleId=" + lstSampleId + "&guId=" + Guid + "&orgId=" + OrgID +"&IsPopup=Y"+ "&categoryCode=" + BarcodeCategory.ContainerRegular + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
            //}
            if (RoleName == RoleHelper.LabTech || RoleName == RoleHelper.Labtypist || RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.JuniorDoctor)
            {
                //Added  By Arivalagan.kk//
                if (NeedAberrantQ == "Y")
                {
                    tdAberrant.Style.Add("display", "none");
                }
                else { tdAberrant.Style.Add("display", "table-cell"); }
                //End Added  By Arivalagan.kk//
                // LoadSample("1");
            }
            LoadSourceName();
            LoadMetaData();
            LoadStatus();
            Loadprotocalgroup();
            lstDepartName();
            long retval = -1;
            List<TaskDefaultSearch> lsttaskProfile = new List<TaskDefaultSearch>();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            retval = taskBL.GetDefaultTaskFilter(OrgID, RoleID, LID, out lsttaskProfile);
             
            if (SavePageNo=="Y")
            {
                currentPageNo = Convert.ToInt32(Session["PageNo"]) != 0 ? Convert.ToInt32(Session["PageNo"]) : 1; 
            }
            
            //if (taskProfile.DeptID != 0)
            //{
            //    chkSetDefault.Checked = true;
            //    deptID = Convert.ToInt64(taskProfile.DeptID);
            //    txtDeptName.Text = taskProfile.DeptName;
            //}
            foreach (TaskDefaultSearch objtaskSearch in lsttaskProfile)
            {
                if (objtaskSearch.Type == "GRP" || objtaskSearch.Type == "INV")
                {
                    Type = objtaskSearch.Type;
                    hdnTestType.Value = objtaskSearch.Type;
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        InvID = objtaskSearch.Value;
                        txtinvname.Text = objtaskSearch.Value;
                    }
                }

                if (objtaskSearch.Type == "DEPT")
                {
                    hdnDeptID.Value = Convert.ToString(objtaskSearch.TypeID);
                    deptID = Convert.ToInt64(objtaskSearch.TypeID);
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        ddlDept.SelectedValue = Convert.ToString(objtaskSearch.TypeID);
                        hdnDeptName.Value = objtaskSearch.Value;
                    }
                }
                if (objtaskSearch.Type == "DATE")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        txtFrom.Text = objtaskSearch.Value.Split('&')[0];
                        txtTo.Text = objtaskSearch.Value.Split('&')[1];
                    }
                }
                if (objtaskSearch.Type == "PATNAME")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        txtPatientSearch.Text = objtaskSearch.Value;
                        hdnPatientName.Value = objtaskSearch.Value;
                    }
                }
                if (objtaskSearch.Type == "PHNNUMB")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        txtwardno.Text = objtaskSearch.Value;
                    }
                }
                if (objtaskSearch.Type == "STATUS")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        ddlStatus.SelectedIndex = objtaskSearch.TypeID;
                    }
                }
                if (objtaskSearch.Type == "CLIENT")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        //ddlSourceName.SelectedIndex = objtaskSearch.TypeID;
                        ddlSourceName.SelectedValue = Convert.ToString(objtaskSearch.TypeID);
                    }
                }
                if (objtaskSearch.Type == "LABNUMB")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        Visitnumber = Convert.ToString(objtaskSearch.Value);
                        txtvisitno.Text = Convert.ToString(objtaskSearch.Value);
                    }
                }
                if (objtaskSearch.Type == "PATNUMB")
                {
                    if (objtaskSearch.Value != "" && objtaskSearch.Value != null)
                    {
                        chkSetDefault.Checked = true;
                        Patnumber = Convert.ToString(objtaskSearch.Value);
                        txtpatno.Text = Convert.ToString(objtaskSearch.Value);
                    }
                }
            }
            string PatientName = string.Empty;
            if (hdnPatientName.Value != "" || hdnPatientName.Value != string.Empty)
            {
                PatientName = hdnPatientName.Value;
            }
            if (hdnPatientName.Value != "" || hdnPatientName.Value != string.Empty)
            {
                loadGridSearch(currentPageNo, PageSize, 0, PatientName);
            }
            else
            {
                loadGrid(currentPageNo, PageSize);
            }
            if (InventoryLocationID == -1)
            {
                Department1.LoadLocationUserMap();
            }
            txtDeptNameExtender.ContextKey = OrgID.ToString();
            AutoCompleteExtender1.ContextKey = OrgID.ToString();

        }
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = lab;
            txtvisitno.MaxLength = 9;
        }
        else
        {
            defaultText = visit;
        }
        txtwatermark();


        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        //if (!IsPostBack)
        //{
        //   // uctlPendingVitals.OrgID = 1;
        //}
        if ((Request.QueryString["alert"] != null) && (Request.QueryString["alert"] != ""))
        {
            if (Request.QueryString["alert"] == "y")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Task has been already picked by another user');", true);
            }
        }
        IsSetDefault = GetConfigValue("SetDefaultSearch", OrgID);
        if (IsSetDefault == "Y")
        {
            lblProtocal.Visible = false;
            ddlprotocalgroup.Visible = false;
            lblpendingdays.Visible = false;
            ddlprotocalgroup.Visible = false;
            txtpendingdays.Visible = false;
            txtDeptName.Visible = false;

            chkSetDefault.Visible = true;
            btnClear.Visible = true;
            lbldept.Visible = true;
            ddlDept.Visible = true;
            lblSourceName.Visible = true;
            ddlSourceName.Visible = true;

        }
    }
    public void txtwatermark()
    {

        if (txtvisitno.Text.Trim() != defaultText.Trim())
        {
            txtvisitno.Attributes.Add("style", "color:black");
        }
        if (txtvisitno.Text == "")
        {
            txtvisitno.Text = defaultText;
            txtvisitno.Attributes.Add("style", "color:gray");
        }
        txtvisitno.Attributes.Add("onblur", "WaterMarktxt(this,event,'" + defaultText + "');");
        txtvisitno.Attributes.Add("onfocus", "WaterMarktxt(this,event,'" + defaultText + "');");
    }
    protected void uctlTaskList_OnPopLoad(object sender, EventArgs e)
    {
        if (uctlTaskList.TaskCount == 0)
        {
            if ((totalRows == -1) || (totalRows == 0))
            {
                long DataCount = ucAdvanceSearch.loadList(uctlTaskList.GetPatientName(), "", "", "", "", "");
                if (DataCount != 0)
                {
                    rptMdlPopup.Show();
                }
            }
        }
    }

    protected void uctlTaskList_onTaskLoadComplete(object sender, EventArgs e)
    {

        hdnPatientName.Value = txtPatientSearch.Text.ToString();
        hdnVisitType.Value = ddlVisitType.SelectedItem.Value.ToString();

        Int64 PatientId = 0;
        string PatientName = string.Empty;
        PatientName = uctlTaskList.GetPatientName();

        if (PatientName != "-1")
        {
            //if (PatientSearch == false)
            //{
            //    hdnCurrent.Value = "";
            //    currentPageNo = 1;

            //}


            //if (Int64.TryParse(PatientName, out PatientId))
            //{
            //    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
            //}
            //else
            //{
            //    //PatientName = txtPatientSearch.Text.ToString();
            //    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
            //}
            //loadGrid(currentPageNo, PageSize);
            loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
        }
        else
        {

            PatientSearch = false;
            hdnCurrent.Value = "";
            currentPageNo = 1;
            loadGrid(1, 10);
            //txtPatientSearch.Text = "";
            divFooterNav.Visible = true;
        }





        //===========================================================
        //Int64 PatientId = 0;
        //string PatientName = string.Empty;

        //PatientName = uctlTaskList.GetPatientName();

        //if (Int64.TryParse(PatientName, out PatientId))
        //{
        //    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
        //}
        //else
        //{
        //    //PatientName = txtPatientSearch.Text.ToString();
        //    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
        //}
        //loadGrid(currentPageNo, PageSize);
        //loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
        //===========================================================



    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session["UserName"] = null;
        Response.Redirect("Home.aspx");
    }

    public void LoadSourceName()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;
        try
        {
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetInvClientMaster(OrgID, "", out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddlSourceName.DataSource = lstSourceName;
                ddlSourceName.DataTextField = "ClientName";
                ddlSourceName.DataValueField = "ClientID";
                ddlSourceName.DataBind();
            }
            //  ddlSourceName.Items.Insert(0, "------SELECT------");
            ddlSourceName.Items.Insert(0, strSelect);
            ddlSourceName.Items[0].Value = "-1";
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
        }
    }

    public void loadGrid(int currentPageNo, int PageSize)
    {
        hdnTaskCount.Value = Convert.ToString(currentPageNo);

        GetLocationAndSpeciality();
        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
        List<EnterResult> lstDetails = new List<EnterResult>();
        int OrgAddressID = ILocationID;
        string allocatedtasks = string.Empty;//kapil
        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        Int64 PatientId = 0;
        string PatientName = string.Empty;
        string BNumber = string.Empty; 
        WatersChk = GetConfigValue("WatersMode", OrgID);//Gowtham Raj

        deptID = Convert.ToInt64(ddlDept.SelectedItem.Value);

        if (ddlprotocalgroup.SelectedIndex != -1)
        {
            if (ddlprotocalgroup.Items.Count > 0)
            {
                Int64.TryParse(ddlprotocalgroup.SelectedItem.Value, out ProtocalGroupID);
            }
            if (ProtocalGroupID.ToString() == "")
            {
                ProtocalGroupID = -1;
            }
        }
        //  ----------------------ADDED BY     THILLAI  KAPIL T
        if (chktasks.Checked == true)
        {
            allocatedtasks = "Y";
        }
        else
        {
            allocatedtasks = "N";
        }
        if (txtpendingdays.Text == "" || txtpendingdays.Text == "0")
        {
            Fromdate = txtFrom.Text;
            Todate = txtTo.Text;
        }
        if (txtinvname.Text != "")
        {
            string invid1 = txtinvname.Text.Split(':')[0];
            InvID = invid1;
        }

        if (hdnTestType.Value != "")
        {
            Type = hdnTestType.Value;
        }
        if (txtBarcode.Text != "")
        {
            BNumber = txtBarcode.Text;
        }
        string reportdate = GetConfigValue("ReportDate", OrgID);
        hdnReportdateconfig.Value = reportdate;
        if ((hdnReportdateconfig.Value == "") || (hdnReportdateconfig.Value == string.Empty))
        {
            hdnReportdateconfig.Value = "N";
        }
        //  ENDED BY     THILLAI  KAPIL T
        //ddlVisitType.SelectedItem.Value = "0";
        ///-----------------------------ADDED BY Thillai kapil.T--------------------------------------------
        string Taskfilter_clientbasis = GetConfigValue("Task_Filter_for_client_basis", OrgID);
        if (Taskfilter_clientbasis == "Y")
        {
            if (jqueryTask == "Y")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetLabInvestigationPatientSearch", "fnGetLabInvestigationPatientSearch('" + ILocationID + "','" + OrgID + "','" + Convert.ToInt64(RoleID) + "','" + currentPageNo + "','" + PageSize + "','" + PatientId + "','" + PatientName + "','" + Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()) + "','" + -1 + "','" + txtwardno.Text + "','" + ddlStatus.SelectedItem.Value.ToString() + "','" + InvID + "','" + Fromdate + "','" + Todate + "','" + Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()) + "','" + Visitnumber + "','" + Patnumber + "','" + Type + "','" + deptID + "','EnterResult',0,0,'" + objLoginDetail + "','" + IsTimed + "','" + ProtocalGroupID + "','" + allocatedtasks +  "','" + SampleID + "');", true);
                dCapture.Visible = true;
                dCaption.Visible = true;
                GridView1.Visible = false;
                divFooterNav.Visible = false;
                PageSize = 0;
            }
            else
            {
                PageSize = 10;
                callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName, out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                    Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString()),
                                                         txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                        Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()), Visitnumber, Patnumber, Type, deptID, "EnterResult", 0, 0, objLoginDetail, IsTimed, ProtocalGroupID, BNumber, allocatedtasks, SampleID);
            }
        }
        else
        {
            if (jqueryTask == "Y")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "fnGetLabInvestigationPatientSearch", "fnGetLabInvestigationPatientSearch('" + ILocationID + "','" + OrgID + "','" + Convert.ToInt64(RoleID) + "','" + currentPageNo + "','" + PageSize + "','" + PatientId + "','" + PatientName + "','" + Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()) + "','" + Convert.ToInt64(-1) + "','" + txtwardno.Text + "','" + ddlStatus.SelectedItem.Value.ToString() + "','" + InvID + "','" + Fromdate + "','" + Todate + "','" + Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()) + "','" + Visitnumber + "','" + Patnumber + "','" + Type + "','" + deptID + "','EnterResult','" + Convert.ToInt64(0) + "','" + Convert.ToInt64(0) + "','" + IsTimed + "','" + ProtocalGroupID + "','" + allocatedtasks + "','" + SampleID + "');", true);
                dCapture.Visible = true;
                dCaption.Visible = true;
                GridView1.Visible = false;
                divFooterNav.Visible = false;
                PageSize = 0;
            }
            else
            {
                PageSize = 10;
                callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName, out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                    //  Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                                                      -1, txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                      Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()), Visitnumber, Patnumber, Type, deptID, "EnterResult", 0, 0,
                                                      objLoginDetail, IsTimed, ProtocalGroupID,BNumber, allocatedtasks, SampleID);
            }

        }
        //-------------------------------------------------------END  -------------------------------------------------------------
        //callBL.GetLabInvestigation(OrgAddressID, OrgID, RoleID, currentPageNo, PageSize, out lstDetails, out totalRows, Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString()), objLoginDetail);
        if (lstDetails.Count > 0)
        {
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
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }


            dCapture.Visible = true;
            dCaption.Visible = true;

            if (WatersChk == "Y")
            {
              
            }
            else
            {
                foreach (EnterResult lst in lstDetails)
                {
                    string str = lst.Age;
                    string[] strage = str.Split(' ');
                    if (strage.Length > 1)
                    {
                    if (strage[1] == "Year(s)")
                    {
                        lst.Age = strage[0] + " " + strYear;
                    }
                    else if (strage[1] == "Month(s)")
                    {
                        lst.Age = strage[0] + " " + strMonth;
                    }
                    else if (strage[1] == "Day(s)")
                    {
                        lst.Age = strage[0] + " " + strDay;
                    }
                    else if (strage[1] == "Week(s)")
                    {
                        lst.Age = strage[0] + " " + strWeek;
                    }
                    else if (strage[1] == "UnKnown")
                    {
                        lst.Age = strUnknownF;
                    }
                    else
                    {
                        lst.Age = strage[0] + " " + strYear;
                    }
                }
                }

            }
               
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
            if (reportdate == "Y")
            {
                GridView1.Columns[5].Visible = true;
            }

        }
        else
        {
            //if (GridView1.Rows.Count > 0)
            //{
            if (ProtocalGroupID != 0)
                dCapture.Visible = true;
            foreach (EnterResult lst in lstDetails)
            {
                string str = lst.Age;
                string[] strage = str.Split(' ');
                if (strage.Length > 1)
                {
                if (strage[1] == "Year(s)")
                {
                    lst.Age = strage[0] + " " + strYear;
                }
                else if (strage[1] == "Month(s)")
                {
                    lst.Age = strage[0] + " " + strMonth;
                }
                else if (strage[1] == "Day(s)")
                {
                    lst.Age = strage[0] + " " + strDay;
                }
                else if (strage[1] == "Week(s)")
                {
                    lst.Age = strage[0] + " " + strWeek;
                }
                else if (strage[1] == "UnKnown")
                {
                    lst.Age = strUnknownF;
                }
                else
                {
                    lst.Age = strage[0] + " " + strYear;
                }
            }
            }
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
            if (reportdate == "Y")
            {
                GridView1.Columns[5].Visible = true;
            }
               dCapture.Visible = true;
                divFooterNav.Visible = false;
            if (SavePageNo == "Y")
            {
               
                if (Convert.ToInt32(Session["PageNo"]) > 0)
                {
                    loadGrid(1, 0);
                    dCapture.Visible = true;
                    divFooterNav.Visible = true;
                    Session["PageNo"] = null;

                }
               
              
            }
            
            // }
        }
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


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string UID = string.Empty;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            EnterResult PVD = (EnterResult)e.Row.DataItem;
            string labb = e.Row.Cells[2].Text;
            if (labb == "0")
            {
                e.Row.Cells[2].Text = "--";
            }
            #region Commented By sami
            ////List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            ////List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            ////List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            ////List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            ////List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            ////List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            ////List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            ////List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
            ////List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            ////List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();

            //if (PVD.UID != null)
            //{
            //    UID = PVD.UID;
            //}
            //invBL.GetInvestigationSamplesCollect(PVD.PatientVisitId, OrgID, RoleID, UID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

            //if (lstPatientInvestigation.Count > 0)
            //{
            //    string strtemp = GetToolTip(lstPatientInvestigation);
            //    e.Row.Cells[0].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
            //    e.Row.Cells[0].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
            //    e.Row.Cells[0].Style.Add("color", "Blue");            //}

            #endregion
            //HtmlAnchor ctr1 = (HtmlAnchor)e.Row.FindControl("lnklist");
            //ctr1.Attributes.Add("onmouseover", "javascript:ShowStatus('" + PVD.PatientVisitId.ToString() + "');");
            //ctr1.Attributes.Add("onmouseout", "HideStatus()");
            if (PVD.PatientVisitType == Attune.Podium.Common.VisitType.InPatient)
            {
                e.Row.ForeColor = System.Drawing.Color.Brown;
                HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
                ctr.Style.Add("color", "Brown");
            }
            if ((PVD.Status == "Reject") || (PVD.Status == "Outsource"))
            {
                e.Row.ForeColor = System.Drawing.Color.Blue;
                HtmlAnchor ctr = (HtmlAnchor)e.Row.FindControl("lnklist");
                ctr.Style.Add("color", "blue");
                //e.Row.Style["text-decoration"] = "none";
                //e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Red';");
                //e.Row.Attributes.Add("onmouseout", "this.style.color='Black';");

            }
            //PatientVisitDetails PVD = (PatientVisitDetails)e.Row.DataItem;
            List<OrderedInvestigations> lstPatientInvestigation = new List<OrderedInvestigations>();
            //UID = PVD.UID;
            //if (PVD.Labno == "")
            //{
            //    PVD.Labno = "0";
            //}
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;

            invBL.GetInvestigationshowincollecttasks(PVD.PatientVisitId, OrgID, ILocationID, PVD.Labno, objLoginDetail, out lstPatientInvestigation);
            if (lstPatientInvestigation.Count > 0)
            {
                string strtemp = GetToolTip(lstPatientInvestigation);
                e.Row.Cells[0].Attributes.Add("onmouseover", "this.className='colornw';showTooltipnew(event,'" + strtemp + "');return false;");
                e.Row.Cells[0].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                e.Row.Cells[0].Style.Add("color", "Blue");
            }
            if (PVD.State == "Y")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
            }
            //if (PVD.NextReviewDate != null)
            //{
            //    string[] AgeValues;
            //    string Ageval = string.Empty;
            //    if (PVD.NextReviewDate != null)
            //    {
            //        AgeValues = PVD.NextReviewDate.Split('.');

            //        if (AgeValues[0] != "0" && AgeValues[1] != "0")
            //        {
            //            Ageval = (AgeValues[0] + "." + AgeValues[1] + "Year(s)").ToString();
            //            e.Row.Cells[1].Text = Ageval;
            //        }

            //    }
            //}
        }
    }
    //private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    //{
    //    string TableHead = "";
    //    string TableDate = "";
    //    string RoomData = "";
    //    TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
    //        //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
    //    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List</td><td>Status</td></tr>";
    //    foreach (var Item in InvestigationList)
    //    {
    //        TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>"
    //                    + "<td>" + Item.Status + "</td></tr>";
    //    }
    //    if (InvestigationList[0].StudyInstanceUId != "" && InvestigationList[0].StudyInstanceUId != null)
    //    {
    //        RoomData = "<tr style=\"font-weight: bold\"><td align=\"center\" colspan=\"2\"><u>Room No:</u>" + InvestigationList[0].StudyInstanceUId + "</td></tr>";
    //    }
    //    return TableHead + TableDate + RoomData + "</table> ";
    //}
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        string RoomData = "";
        if (InvestigationList.Count <= 20)
        {
            TableHead = "<table  border=\"0\" cellpadding=\"0\"cellspacing=\"0\" style=\"background-color:#fff;\" class=\"taskDetailstip\">"
                //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
             + "<tr style=\"font-weight: bold;\" class=\"tasktipHeader\"><td>" + Resources.ClientSideDisplayTexts.Lab_Home_InvestigationList + "</td><td>" + Resources.ClientSideDisplayTexts.Lab_Home_Status_2 + "</td><td>" + Resources.ClientSideDisplayTexts.Lab_Home_Comment + "</td></tr>";
            //<td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_InvestigationList + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Status_2 + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Comment + "</u></td>
            foreach (var Item in InvestigationList)
            {

                TableDate += "<tr style=\"font-weight: bold\">  <td>" + Item.InvestigationName + "</td>"
                            + "<td>" + Item.DisplayStatus + "</td>" + "<td>" + Item.RefPhyName + "</td> </tr>";
            }
            if (InvestigationList[0].StudyInstanceUId != "" && InvestigationList[0].StudyInstanceUId != null)
            {
                RoomData = "<tr style=\"font-weight: bold\"><td align=\"center\" colspan=\"2\"><u>" + Resources.ClientSideDisplayTexts.Lab_Home_RoomNo + "</u>" + InvestigationList[0].StudyInstanceUId + "</td></tr>";
            }
        }
        else
        {
            TableHead = "<table  border=\"0\" cellpadding=\"0\"cellspacing=\"0\" style=\"background-color:#fff;\" class=\"taskDetailstip\">"
                //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
             + "<tr style=\"font-weight: bold;\" class=\"tasktipHeader\"><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_InvestigationList + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Status_2 + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Comment + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_InvestigationList + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Status_2 + "</u></td><td><u>" + Resources.ClientSideDisplayTexts.Lab_Home_Comment + "</u></td></tr>";

            for (int i = 0; i < InvestigationList.Count(); i++)
            {
                if ((i + 1) < InvestigationList.Count())
                {
                    TableDate += "<tr style=\"font-weight: bold\">  <td>" + InvestigationList[i].InvestigationName + "</td>"
                                + "<td>" + InvestigationList[i].DisplayStatus + "</td>" + "<td>" + InvestigationList[i].RefPhyName + "</td>" +
                                "<td>" + InvestigationList[i + 1].InvestigationName + "</td>"
                                + "<td>" + InvestigationList[i + 1].DisplayStatus + "</td>" + "<td>" + InvestigationList[i + 1].RefPhyName + "</td></tr>";
                }
                else
                {
                    TableDate += "<tr style=\"font-weight: bold\">  <td>" + InvestigationList[i].InvestigationName + "</td>"
                                + "<td>" + InvestigationList[i].DisplayStatus + "</td>" + "<td>" + InvestigationList[i].RefPhyName + "</td>" +
                                "<td>" + "" + "</td>"
                                + "<td>" + "" + "</td>" + "<td>" + "" + "</td></tr>";
                }
                i = i + 1;
            }
            if (InvestigationList[0].StudyInstanceUId != "" && InvestigationList[0].StudyInstanceUId != null)
            {
                RoomData = "<tr style=\"font-weight: bold\"><td align=\"center\" colspan=\"2\"><u>" + Resources.ClientSideDisplayTexts.Lab_Home_RoomNo + "</u>" + InvestigationList[0].StudyInstanceUId + "</td><td align=\"center\" colspan=\"2\"><u>" + Resources.ClientSideDisplayTexts.Lab_Home_RoomNo + "</u>" + InvestigationList[0].StudyInstanceUId + "</td></tr>";
            }
        }
        return TableHead + TableDate + RoomData + "</table> ";
    }

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        GridView1.PageIndex = e.NewPageIndex;
    //      //  loadGrid();
    //    }
    //}

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        //if (hdnCurrent.Value != "")
        //{
        //    currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientSearch.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}

        //else
        //{
        //    currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
        //    hdnCurrent.Value = currentPageNo.ToString();

        //    if (PatientSearch == true && txtPatientSearch.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}

        if ((ddlVisitType.SelectedItem.Value != hdnVisitType.Value) || (txtPatientSearch.Text != hdnPatientName.Value))
        {
            hdnCurrent.Value = "";
            //lblCurrent.Text = "2";
        }

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
        if (SavePageNo=="Y")
        {
            Session["PageNo"] = currentPageNo;
        }
        
        if (txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1"))
        {
            loadGrid(currentPageNo, PageSize);
        }
        else
        {

            PerformPatientSearch(currentPageNo, PageSize);
        }

        hdnPatientName.Value = txtPatientSearch.Text.ToString();
        hdnVisitType.Value = ddlVisitType.SelectedItem.Value.ToString();

    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {

        //if (hdnCurrent.Value != "")
        //{
        //    currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientSearch.Text != "")
        //    { 
        //        PerformPatientSearch(currentPageNo, PageSize); 
        //    }
        //    else 
        //    { 
        //        loadGrid(currentPageNo, PageSize);
        //    }


        //}
        //else
        //{
        //    currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
        //    hdnCurrent.Value = currentPageNo.ToString();
        //    if (PatientSearch == true && txtPatientSearch.Text != "")
        //    {
        //        PerformPatientSearch(currentPageNo, PageSize);
        //    }
        //    else
        //    {
        //        loadGrid(currentPageNo, PageSize);
        //    }
        //}

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
        if (SavePageNo == "Y")
        {
            Session["PageNo"] = currentPageNo;
        }
        
        if (PatientSearch == true)
        {
            if ((ddlVisitType.SelectedItem.Value != hdnVisitType.Value) || (txtPatientSearch.Text != hdnPatientName.Value))
            {
                hdnCurrent.Value = "";
                lblCurrent.Text = "0";
            }
        }

        if (txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1"))
        {
            loadGrid(currentPageNo, PageSize);
        }
        else
        {


            PerformPatientSearch(currentPageNo, PageSize);
        }

        hdnPatientName.Value = txtPatientSearch.Text.ToString();
        hdnVisitType.Value = ddlVisitType.SelectedItem.Value.ToString();

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {


        //  hdnCurrent.Value = txtpageNo.Text;
        //  int ar = Convert.ToInt32 (txtpageNo.Text);

        //  if (ar != 0)
        //  {
        //      loadGrid(Convert.ToInt32(txtpageNo.Text), PageSize);
        //  }
        //  if (PatientSearch == true && txtPatientSearch.Text != "")
        //      if (PatientSearch == true)
        //      {
        //          PerformPatientSearch(Convert.ToInt32(txtpageNo.Text), PageSize);
        //      }

        //txtpageNo.Text = "";

        hdnCurrent.Value = txtpageNo.Text;
        int ar = Convert.ToInt32(txtpageNo.Text);
        if (SavePageNo == "Y")
        {
            Session["PageNo"] = ar;
        }
        

        if (PatientSearch == true && txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1"))
        {

            loadGrid(Convert.ToInt32(txtpageNo.Text), PageSize);
        }
        else if (ar != 0)
        {
            PerformPatientSearch(Convert.ToInt32(txtpageNo.Text), PageSize);
        }

        txtpageNo.Text = "";


    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtPatientSearch.Text = "";
        txtwardno.Text = "";
        txtvisitno.Text = "";
        txtFrom.Text = "";
        txtinvname.Text = "";
        txtTo.Text = "";
        txtpatno.Text = "";
        ddlStatus.SelectedIndex = -1;
        ddlStatus.SelectedItem.Value = "-1";
        ddlVisitType.SelectedItem.Value = "-1";
        ddlDept.SelectedItem.Value = "-1";
        ddlDept.SelectedIndex = -1;
        ddlSourceName.SelectedItem.Value = "-1";
        ddlSourceName.SelectedIndex = -1;
        chkSetDefault.Checked = true;
        btnSearch_Click(sender, e);
        chkSetDefault.Checked = false;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long retval = -1;
        Tasks_BL taskBL = new Tasks_BL();
        List<TaskDefaultSearch> lstTaskDefaultSearch = new List<TaskDefaultSearch>();
        TaskDefaultSearch taskprofile = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile1 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile2 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile3 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile4 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile5 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile6 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile7 = new TaskDefaultSearch();
        TaskDefaultSearch taskprofile8 = new TaskDefaultSearch();
        try
        {
            Session["PageNo"] = null;
            taskprofile.LoginID = LID;
            taskprofile.RoleID = Convert.ToInt64(RoleID);
            taskprofile.OrgID = Convert.ToInt64(OrgID);
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.Location = ILocationID.ToString();
            if (ddlDept.SelectedItem.Value != "")
            {
                if (ddlDept.SelectedItem.Value != "0")
                {
                    taskprofile.TypeID = Convert.ToInt32(ddlDept.SelectedItem.Value);
                }
                else
                {
                    taskprofile.TypeID = 0;
                }
                // if (ddlDept.SelectedItem.Text != "---Select---")
                if (ddlDept.SelectedItem.Value != "0")
                {
                    taskprofile.Value = ddlDept.SelectedItem.Text;
                    taskprofile.Type = "DEPT";
                }
                else
                {
                    taskprofile.Value = string.Empty;

                }
                lstTaskDefaultSearch.Add(taskprofile);
            }
            taskprofile1.LoginID = LID;
            taskprofile1.RoleID = Convert.ToInt64(RoleID);
            taskprofile1.OrgID = Convert.ToInt64(OrgID);
            taskprofile1.OrgAddressID = ILocationID;
            taskprofile1.Location = ILocationID.ToString();
            if (txtinvname.Text != "")
            {
                if (hdnTestID.Value != "")
                {
                    taskprofile1.TypeID = Convert.ToInt32(hdnTestID.Value);
                }
                else
                {
                    taskprofile1.TypeID = 0;
                }
                if (txtinvname.Text != "")
                {
                    taskprofile1.Value = txtinvname.Text;
                }
                else
                {
                    taskprofile1.Value = string.Empty;
                }
                if (hdnTestType.Value != "")
                {
                    taskprofile1.Type = hdnTestType.Value;
                }
                else
                {
                    taskprofile1.Type = string.Empty;
                }
                lstTaskDefaultSearch.Add(taskprofile1);
            }
            taskprofile2.LoginID = LID;
            taskprofile2.RoleID = Convert.ToInt64(RoleID);
            taskprofile2.OrgID = Convert.ToInt64(OrgID);
            taskprofile2.OrgAddressID = ILocationID;
            taskprofile2.Location = ILocationID.ToString();
            if (txtFrom.Text != "")
            {
                if (txtFrom.Text != "")
                {
                    taskprofile2.Value = txtFrom.Text + "&" + txtTo.Text;
                    taskprofile2.Type = "DATE";
                }
                else
                {
                    taskprofile2.Value = string.Empty;
                }
                lstTaskDefaultSearch.Add(taskprofile2);
            }
            taskprofile3.LoginID = LID;
            taskprofile3.RoleID = Convert.ToInt64(RoleID);
            taskprofile3.OrgID = Convert.ToInt64(OrgID);
            taskprofile3.OrgAddressID = ILocationID;
            taskprofile3.Location = ILocationID.ToString();
            if (txtPatientSearch.Text != "")
            {
                if (txtPatientSearch.Text != "")
                {
                    taskprofile3.Value = txtPatientSearch.Text;
                    taskprofile3.Type = "PATNAME";
                }
                else
                {
                    taskprofile3.Value = string.Empty;
                }
                lstTaskDefaultSearch.Add(taskprofile3);
            }
            taskprofile4.LoginID = LID;
            taskprofile4.RoleID = Convert.ToInt64(RoleID);
            taskprofile4.OrgID = Convert.ToInt64(OrgID);
            taskprofile4.OrgAddressID = ILocationID;
            taskprofile4.Location = ILocationID.ToString();
            if (txtwardno.Text != "")
            {
                if (txtwardno.Text != "")
                {
                    taskprofile4.Value = txtwardno.Text;
                    taskprofile4.Type = "PHNNUMB";
                }
                else
                {
                    taskprofile4.Value = string.Empty;
                }
                lstTaskDefaultSearch.Add(taskprofile4);
            }
            taskprofile5.LoginID = LID;
            taskprofile5.RoleID = Convert.ToInt64(RoleID);
            taskprofile5.OrgID = Convert.ToInt64(OrgID);
            taskprofile5.OrgAddressID = ILocationID;
            taskprofile5.Location = ILocationID.ToString();
            if (ddlStatus.SelectedItem.Value != "")
            {
                if (ddlStatus.SelectedItem.Value != "-1")
                {
                    taskprofile5.TypeID = Convert.ToInt32(ddlStatus.SelectedIndex);
                }
                else
                {
                    taskprofile5.TypeID = 0;
                }
                //if (ddlStatus.SelectedItem.Text != "--Select--")
                if (ddlStatus.SelectedItem.Value != "-1")
                {
                    taskprofile5.Value = ddlStatus.SelectedItem.Text;
                    taskprofile5.Type = "STATUS";
                }
                else
                {
                    taskprofile5.Value = string.Empty;

                }
                lstTaskDefaultSearch.Add(taskprofile5);
            }
            taskprofile6.LoginID = LID;
            taskprofile6.RoleID = Convert.ToInt64(RoleID);
            taskprofile6.OrgID = Convert.ToInt64(OrgID);
            taskprofile6.OrgAddressID = ILocationID;
            taskprofile6.Location = ILocationID.ToString();
            if (ddlSourceName.SelectedItem.Value != "")
            {
                if (ddlSourceName.SelectedItem.Value != "-1")
                {
                    taskprofile6.TypeID = Convert.ToInt32(ddlSourceName.SelectedItem.Value);
                }
                else
                {
                    taskprofile6.TypeID = 0;
                }
                //if (ddlSourceName.SelectedItem.Text != "------SELECT------")
                if (ddlSourceName.SelectedItem.Value != "-1")
                {
                    taskprofile6.Value = ddlSourceName.SelectedItem.Text;
                    taskprofile6.Type = "CLIENT";
                }
                else
                {
                    taskprofile6.Value = string.Empty;

                }
                lstTaskDefaultSearch.Add(taskprofile6);
            }
            taskprofile7.LoginID = LID;
            taskprofile7.RoleID = Convert.ToInt64(RoleID);
            taskprofile7.OrgID = Convert.ToInt64(OrgID);
            taskprofile7.OrgAddressID = ILocationID;
            taskprofile7.Location = ILocationID.ToString();
            if (txtvisitno.Text == lab || txtvisitno.Text == visit)
            {
                txtvisitno.Text = "";
            }
            if (txtvisitno.Text != "")
            {
                if (txtvisitno.Text != " ")
                {
                    taskprofile7.Value = txtvisitno.Text;
                    taskprofile7.Type = "LABNUMB";
                }
                else
                {
                    taskprofile7.Value = string.Empty;

                }
                lstTaskDefaultSearch.Add(taskprofile7);
            }
            taskprofile8.LoginID = LID;
            taskprofile8.RoleID = Convert.ToInt64(RoleID);
            taskprofile8.OrgID = Convert.ToInt64(OrgID);
            taskprofile8.OrgAddressID = ILocationID;
            taskprofile8.Location = ILocationID.ToString();
            if (txtpatno.Text != "")
            {
                if (txtpatno.Text != " ")
                {
                    taskprofile8.Value = txtpatno.Text;
                    taskprofile8.Type = "PATNUMB";
                }
                else
                {
                    taskprofile8.Value = string.Empty;
                }
                lstTaskDefaultSearch.Add(taskprofile8);
            }
            if (chkSetDefault.Checked)
            {
                retval = taskBL.InsertTaskDefault(lstTaskDefaultSearch);
            }


            //if (txtPatientSearch.Text != "")
            //{
            //    if (PatientSearch == false)
            //    {
            //        hdnCurrent.Value = "";
            //        currentPageNo = 1;
            //    }
            //    PatientSearch = true;
            //    Int64 PatientId = 0;
            //    string PatientName = string.Empty;
            //    if (Int64.TryParse(txtPatientSearch.Text, out PatientId))
            //    {
            //        long rowCount = -1;
            //        rowCount = loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
            //        if ((rowCount == -1) || (rowCount == 0))
            //        {

            //            long DataCount = ucAdvanceSearch.loadList(PatientId.ToString());
            //            if (DataCount != 0)
            //            {
            //                rptMdlPopup.Show();
            //            }
            //        }
            //    }
            //    else
            //    {
            //        PatientName = txtPatientSearch.Text.ToString();
            //        loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
            //    }
            //}
            //else
            //{

            //    PatientSearch = false;
            //    hdnCurrent.Value = "";
            //    currentPageNo = 1;
            //    loadGrid(1, 10);    
            //    txtPatientSearch.Text = "";
            //    divFooterNav.Visible = true;
            //}
            //  Tasks_BL taskBL = new Tasks_BL();
            //  long retval = -1;
            TaskProfile taskprofileNew = new TaskProfile();
            taskprofileNew.LoginID = LID;
            taskprofileNew.RoleID = RoleID;
            taskprofileNew.OrgID = OrgID;
            taskprofileNew.OrgAddressID = ILocationID;
            taskprofileNew.Type = "Enter Result";
            if (ddlprotocalgroup.SelectedValue != "0")
            {
                if (ddlprotocalgroup.Items.Count > 0)
                {
                    taskprofileNew.ProtocalGroupId = Int64.Parse(ddlprotocalgroup.SelectedValue.ToString());
                }
            }
            else
            {
                taskprofileNew.ProtocalGroupId = 0;
            }
            retval = taskBL.InsertDefault(taskprofileNew);
            if (txtvisitno.Text.Trim() == defaultText.Trim())
            {
                txtvisitno.Text = "";
            }
            if (txtvisitno.Text != "")
            {
                Visitnumber = txtvisitno.Text;
            }
            if (txtpatno.Text != "")
            {
                Patnumber = txtpatno.Text;
            }
            if (txtinvname.Text != "")
            {
                string invid1 = txtinvname.Text.Split(':')[0];
                InvID = invid1;
            }
            if (ddlDept.SelectedItem.Value != "0")
            {
                deptID = Convert.ToInt64(ddlDept.SelectedItem.Value);
            }
            if (txtDeptName.Text != "")
            {
                deptID = Convert.ToInt64(hdnDeptID.Value);
            }
            if (hdnTestType.Value != "")
            {
                Type = hdnTestType.Value;
            }
            if (txtpendingdays.Text == "" || txtpendingdays.Text == "0")
            {
                Fromdate = txtFrom.Text;
                Todate = txtTo.Text;
            }
            else
            {
                int pendingdays = Convert.ToInt16(txtpendingdays.Text);

                // Calculating the Late's date (substracting days from current date.) 
                DateTime yesterday = DateTime.Today.AddDays(-(pendingdays));
                Fromdate = yesterday.ToString("dd/MM/yyyy");
                Todate = yesterday.ToString("dd/MM/yyyy");
            }

            hdnPatientName.Value = txtPatientSearch.Text.ToString();
            hdnVisitType.Value = ddlVisitType.SelectedItem.Value.ToString();

            if (ddlprotocalgroup.Items.Count > 0)
            {
                ProtocalGroupID = Convert.ToInt64(ddlprotocalgroup.SelectedItem.Value);
            }


            //if (txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1") || ddlStatus.SelectedItem.Value != "-1" || drpPriority.SelectedItem.Value != "0" ||ddlprotocalgroup.SelectedItem.Value!="0")
            if (txtPatientSearch.Text == "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1") || ddlStatus.SelectedItem.Value != "-1" || drpPriority.SelectedItem.Value != "0" || ProtocalGroupID != -1)
            {
                hdnCurrent.Value = "";
                currentPageNo = 1;

                PatientSearch = true;
                Int64 PatientId = 0;
                string PatientName = string.Empty;
                if (Int64.TryParse(txtPatientSearch.Text, out PatientId))
                {
                    long rowCount = -1;
                    rowCount = loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                    if ((rowCount == -1) || (rowCount == 0))
                    {

                        long DataCount = ucAdvanceSearch.loadList(PatientId.ToString(), "", "", "", "", "");
                        if (DataCount != 0)
                        {
                            rptMdlPopup.Show();
                        }
                    }
                    //loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
                else
                {
                    PatientName = txtPatientSearch.Text.ToString();
                    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
            }

            else if (txtPatientSearch.Text != "" && (ddlVisitType.SelectedItem.Value == "0" || ddlVisitType.SelectedItem.Value == "1") || txtwardno.Text != "" || txtFrom.Text != "")
            {
                hdnCurrent.Value = "";
                currentPageNo = 1;

                PatientSearch = true;
                Int64 PatientId = 0;
                string PatientName = string.Empty;
                if (Int64.TryParse(txtPatientSearch.Text, out PatientId))
                {
                    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
                else
                {
                    PatientName = txtPatientSearch.Text.ToString();
                    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
            }
            else if (txtPatientSearch.Text != "" && ddlVisitType.SelectedItem.Value == "-1" || txtinvname.Text != "" || txtpatno.Text != "" || txtvisitno.Text != "" || txtDeptName.Text != "" || ddlDept.SelectedItem.Value != "0")
            {
                hdnCurrent.Value = "";
                currentPageNo = 1;

                PatientSearch = true;
                Int64 PatientId = 0;
                string PatientName = string.Empty;
                if (Int64.TryParse(txtPatientSearch.Text, out PatientId))
                {
                    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
                else
                {
                    PatientName = txtPatientSearch.Text.ToString();
                    loadGridSearch(currentPageNo, PageSize, PatientId, PatientName);
                }
            }
            else
            {

                PatientSearch = false;
                hdnCurrent.Value = "";
                currentPageNo = 1;
                loadGrid(1, 10);

                txtPatientSearch.Text = "";
                divFooterNav.Visible = true;
            }


            txtwatermark();

        }

        catch(Exception ex)
        {

        }
    }
    private void PerformPatientSearch(int CurPageNo, int PagSize)
    {

        PatientSearch = true;
        Int64 PatientId = 0;
        string PatientName = string.Empty;
        if (Int64.TryParse(txtPatientSearch.Text, out PatientId))
        {
            loadGridSearch(CurPageNo, PagSize, PatientId, PatientName);
        }
        else
        {
            PatientName = txtPatientSearch.Text.ToString();
            loadGridSearch(CurPageNo, PagSize, PatientId, PatientName);
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
    public long loadGridSearch(int currentPageNo, int PageSize, Int64 PatientId, string PatientName)
    {

        hdnTaskCount.Value = Convert.ToString(currentPageNo);
        long _dataCount = -1;
        LoginDetail objLoginDetail = new LoginDetail();
        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
        List<EnterResult> lstDetails = new List<EnterResult>();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        string allocatedtasks = string.Empty;
        string barcodeNumber = string.Empty;
        WatersChk = GetConfigValue("WatersMode", OrgID);
        if (chktasks.Checked == true)
        {
            allocatedtasks = "Y";
        }
        else
        {
            allocatedtasks = "N";
        }
        if (txtpendingdays.Text == "" || txtpendingdays.Text == "0")
        {
            Fromdate = txtFrom.Text;
            Todate = txtTo.Text;
          
            if (WatersChk == "Y")
            {
                Fromdate = txtFromWaters.Text;
                Todate = txtTowaters.Text;
            }
        }
        if (txtvisitno.Text.Trim() == defaultText.Trim())
        {
            txtvisitno.Text = "";
        }
        if (txtvisitno.Text != "" || txtVisitNumberW.Text != "")
        {
            Visitnumber = txtvisitno.Text;
            if (WatersChk == "Y")
            {
                Visitnumber = txtVisitNumberW.Text;
            }
        }
        if (txtpatno.Text != "")
        {
            Patnumber = txtpatno.Text;
        }
        if (txtinvname.Text != "")
        {
            string invid1 = txtinvname.Text.Split(':')[0];
            InvID = invid1;
        }
        if (ddlDept.SelectedItem.Value != "0")
        {
            deptID = Convert.ToInt64(ddlDept.SelectedItem.Value);
        }

        if (txtDeptName.Text != "" || txtDeptNameW.Text != "")
        {
            deptID = Convert.ToInt64(hdnDeptID.Value);
        }
        if (hdnTestType.Value != "")
        {
            Type = hdnTestType.Value;
        }
        if (txtBarcode.Text != "" || txtBarcode.Text != "")
        {
            barcodeNumber = txtBarcode.Text;
        }
        // ddlVisitType.SelectedItem.Value = "0";
        if (ddlprotocalgroup.Items.Count > 0)
        {
            Int64.TryParse(ddlprotocalgroup.SelectedItem.Value, out ProtocalGroupID);
        }
        string reportdate = GetConfigValue("ReportDate", OrgID);
        if (txtSampleID.Text != "")
        {
            SampleID = txtSampleID.Text;
        }
        // ------------------------------------------------ADDED BY Thillai  kapil.T-----------------------------------------
        string Taskfilter_clientbasis = GetConfigValue("Task_Filter_for_client_basis", OrgID);
        if (Taskfilter_clientbasis == "Y")
        {
            if (jqueryTask == "Y")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "fnGetLabInvestigationPatientSearch1",
                    "fnGetLabInvestigationPatientSearch('" + ILocationID + "','" + OrgID + "','" + Convert.ToInt64(RoleID) + "','"
                    + currentPageNo + "','" + PageSize + "','" + PatientId + "','" + PatientName + "','"
                    + Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()) + "','"
                    + Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString()) + "','" + txtwardno.Text + "','"
                    + ddlStatus.SelectedItem.Value.ToString() + "','" + InvID + "','" + Fromdate + "','" + Todate + "','"
                    + Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()) + "','" + Visitnumber + "','" + Patnumber + "','"
                    + Type + "','" + deptID + "','EnterResult',0,'" + Convert.ToInt64(ddlLocation.SelectedItem.Value.ToString()) + "','" + objLoginDetail + "','" + IsTimed + "','" + ProtocalGroupID + "','" + barcodeNumber + "','"
                    + allocatedtasks + "','" + SampleID + "');", true);
                dCapture.Visible = true;
                dCaption.Visible = true;
                GridView1.Visible = false;
                divFooterNav.Visible = false;
            }
            else
            {
                PageSize = 10;
                 
                IsHospitalLab = GetConfigValue("IsHospitalLab", OrgID);
                if (IsHospitalLab == "Y")
                {
                    callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName,
                    out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                    Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                                                         , txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                         Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()),
                                                         Visitnumber, Patnumber, Type, deptID, "EnterResult", 0, Convert.ToInt64(ddlLocation.SelectedItem.Value.ToString()),
                                                         objLoginDetail, IsTimed, ProtocalGroupID, barcodeNumber, allocatedtasks, SampleID);
                }
                else
                {

                    callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName,
                        out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                        Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                                                             , txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                             Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()),
                                                             Visitnumber, Patnumber, Type, deptID, "EnterResult", 0,0,
                                                             objLoginDetail, IsTimed, ProtocalGroupID, barcodeNumber, allocatedtasks, SampleID);
                }
            }
        }
        else
        {
            if (jqueryTask == "Y")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "fnGetLabInvestigationPatientSearch1",
                    "fnGetLabInvestigationPatientSearch('" + ILocationID + "','" + OrgID + "','" + Convert.ToInt64(RoleID) + "','"
                    + currentPageNo + "','" + PageSize + "','" + PatientId + "','" + PatientName + "','"
                    + Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()) + "','"
                    + Convert.ToInt64(Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())) + "','"
                    + txtwardno.Text + "','" + ddlStatus.SelectedItem.Value.ToString() + "','" + InvID + "','"
                    + Fromdate + "','" + Todate + "','" + Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()) + "','"
                    + Visitnumber + "','" + Patnumber + "','" + Type + "','" + deptID + "','EnterResult','" + Convert.ToInt64(0) + "','"
                    + Convert.ToInt64(ddlLocation.SelectedItem.Value.ToString()) + "','" + IsTimed + "','" + ProtocalGroupID + "','" + allocatedtasks + "','" + SampleID + "');", true);
                dCapture.Visible = true;
                dCaption.Visible = true;
                GridView1.Visible = false;
                divFooterNav.Visible = false;
            }
            else
            {
                PageSize = 10;
				IsHospitalLab = GetConfigValue("IsHospitalLab", OrgID);
                if (IsHospitalLab == "Y")
                {
					callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName
                    , out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                      Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                    //-1
                                                      , txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                      Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()),
                                                      Visitnumber, Patnumber, Type, deptID, "EnterResult", 0, Convert.ToInt64(ddlLocation.SelectedItem.Value.ToString()),
                                                      objLoginDetail, IsTimed, ProtocalGroupID,barcodeNumber, allocatedtasks, SampleID);
													                  
                }
                else
                {
				
                callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName
                    , out lstDetails, out totalRows, Convert.ToInt32(ddlVisitType.SelectedItem.Value.ToString()),
                      Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                    //-1
                                                      , txtwardno.Text, ddlStatus.SelectedItem.Value.ToString(), InvID,
                                                      Fromdate, Todate, Convert.ToInt32(drpPriority.SelectedItem.Value.ToString()),
                                                      Visitnumber, Patnumber, Type, deptID, "EnterResult", 0, 0,
                                                      objLoginDetail, IsTimed, ProtocalGroupID,barcodeNumber, allocatedtasks, SampleID);
													  
				}
													  
            }
        }
        // ------------------------------------------------End Changed By Arivalagan.kk-----------------------------------------
        if (lstDetails.Count > 0)
        {
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
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }


            dCapture.Visible = true;
            dCaption.Visible = true;
            foreach (EnterResult lst in lstDetails)
            {
                string str = lst.Age;
                string[] strage = str.Split(' ');
                if (strage.Length > 1)
                {
                if (strage[1] == "Year(s)")
                {
                    lst.Age = strage[0] + " " + strYear;
                }
                else if (strage[1] == "Month(s)")
                {
                    lst.Age = strage[0] + " " + strMonth;
                }
                else if (strage[1] == "Day(s)")
                {
                    lst.Age = strage[0] + " " + strDay;
                }
                else if (strage[1] == "Week(s)")
                {
                    lst.Age = strage[0] + " " + strWeek;
                }
                else if (strage[1] == "UnKnown")
                {
                    lst.Age = strUnknownF;
                }
                else
                {
                    lst.Age = strage[0] + " " + strYear;
                    }
                }
            }
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
            divFooterNav.Visible = true;
            if (reportdate == "Y")
            {
                GridView1.Columns[5].Visible = true;
            }

        }
        else
        {
            dCapture.Visible = true;
            string gridmsg = Resources.ClientSideDisplayTexts.Lab_Home_aspx_cs_gridmsg;
            GridView1.DataSource = null;
            GridView1.EmptyDataText = gridmsg;
            GridView1.DataBind();
            divFooterNav.Visible = false;
            if (reportdate == "Y")
            {
                GridView1.Columns[5].Visible = true;
            }
            //txtPatientSearch.Focus();
        }
        return totalRows;
        txtvisitno.Text = string.Empty;
        txtpatno.Text = string.Empty;
    }



    protected void btnCancelSearch_Click(object sender, EventArgs e)
    {
        loadGrid(1, 10);

        txtPatientSearch.Text = "";
        divFooterNav.Visible = true;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    # region Commented Because AbberantQueue Control is Created
    //private void LoadSample(string DateType)
    //{
    //    try
    //    {
    //        string FDate = string.Empty;
    //        string Tdate = string.Empty;
    //        if (DateType == "0")
    //        {
    //            FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "1")
    //        {
    //            FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "2")
    //        {
    //            FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }
    //        if (DateType == "3")
    //        {
    //            FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
    //            Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
    //        }

    //        List<CollectedSample> lstInvestigationSamples1 = new List<CollectedSample>();
    //        List<CollectedSample> lstInvestigationSamples2 = new List<CollectedSample>();
    //        List<InvestigationQueue> lstRetestInvestigationQueue = new List<InvestigationQueue>();
    //        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);


    //        invbl.GetQuickInvSamplesStatus(OrgID, FDate, Tdate, 0, ILocationID, out lstInvestigationSamples1, out lstInvestigationSamples2, out lstRetestInvestigationQueue);
    //        // if (lstInvestigationSamples1.Count > 0)
    //        // {         

    //        gvInvSamplesStatus.DataSource = lstInvestigationSamples1;
    //        gvInvSamplesStatus.DataBind();

    //        //}

    //        //if (lstInvestigationSamples2.Count > 0)
    //        // {
    //        gvInvSamplesStatus2.DataSource = lstInvestigationSamples2;
    //        gvInvSamplesStatus2.DataBind();
    //        //}

    //        #region SampleStatus Highlight Color
    //        string CurrentLocationStatus = string.Empty;
    //        string OtherLocationStatus = string.Empty;
    //        if (lstInvestigationSamples1.Count > 0)
    //        {
    //            foreach (CollectedSample lst in lstInvestigationSamples1)
    //            {
    //                CurrentLocationStatus = lst.InvSampleStatusDesc + '~' + CurrentLocationStatus;
    //            }
    //        }
    //        if (lstInvestigationSamples2.Count > 0)
    //        {
    //            foreach (CollectedSample lst1 in lstInvestigationSamples2)
    //            {
    //                OtherLocationStatus = lst1.InvSampleStatusDesc + '~' + OtherLocationStatus;
    //            }
    //        }
    //        hdnCurrentLocationStatus.Value = "";
    //        hdnOtherLocationStatus.Value = "";
    //        hdnCurrentLocationStatus.Value = CurrentLocationStatus;
    //        hdnOtherLocationStatus.Value = OtherLocationStatus;
    //        #endregion

    //        grdInvestigationQueue.DataSource = lstRetestInvestigationQueue;
    //        grdInvestigationQueue.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading sample", ex);
    //    }
    //}
    //protected void gvInvSamplesStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        e.Row.Cells[0].Text = OrgName + " - " + LocationName;
    //    }
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //DropDownList ddldept = (DropDownList)e.Row.FindControl("ddlDept");

    //        //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FAAC58'");
    //        // e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#F5D0A9'");
    //        if (hdnCurrentLocationStatus.Value != "0")
    //        {
    //            CollectedSample date = (CollectedSample)e.Row.DataItem;
    //            foreach (string Status in hdnCurrentLocationStatus.Value.Split('~'))
    //            {
    //                string[] PStatus = Status.Split('-');
    //                if (PStatus[0] != "")
    //                {
    //                    string[] CStatus = date.InvSampleStatusDesc.Split('-');
    //                    if (PStatus[1].Trim() == CStatus[1].Trim())
    //                    {
    //                        if (PStatus[0].Trim() != CStatus[0].Trim())
    //                        {
    //                            e.Row.BackColor = System.Drawing.Color.Orange;
    //                            //e.Row.ForeColor  = System.Drawing.Color.LimeGreen;
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }

    //    if (e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        e.Row.Cells[0].Text = "Aberrant Sample Queue: " + OrgName + " - " + LocationName;
    //    }

    //}
    //protected void gvInvSamplesStatus2_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        e.Row.Cells[0].Text = "Other Location";
    //    }
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //e.Row.Attributes.Add("onclick", "this.style.backgroundColor='Orange'");
    //        //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FAAC58'");
    //        //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#F5D0A9'");

    //        if (hdnOtherLocationStatus.Value != "0")
    //        {
    //            CollectedSample date = (CollectedSample)e.Row.DataItem;
    //            foreach (string Status in hdnOtherLocationStatus.Value.Split('~'))
    //            {
    //                string[] PStatus = Status.Split('-');
    //                if (PStatus[0] != "")
    //                {
    //                    string[] CStatus = date.InvSampleStatusDesc.Split('-');
    //                    if (PStatus[1].Trim() == CStatus[1].Trim())
    //                    {
    //                        if (PStatus[0].Trim() != CStatus[0].Trim())
    //                        {
    //                            e.Row.BackColor = System.Drawing.Color.Orange;
    //                            //e.Row.Cells[0].ForeColor = System.Drawing.Color.LimeGreen;
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    if (e.Row.RowType == DataControlRowType.EmptyDataRow)
    //    {
    //        e.Row.Cells[0].Text = "Aberrant Sample Queue: Other Location";
    //    }
    //}
    //protected void ddlInvSamplesStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string InvSamplesStatusDate = string.Empty;
    //    InvSamplesStatusDate = ddlInvSamplesStatus.SelectedValue;
    //    LoadSample(InvSamplesStatusDate);
    //}

    #endregion
    public void LoadStatus()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;
        long returnCode;
        try
        {
            List<InvestigationStatus> lstInvestigationStatus;
            lstInvestigationStatus = new List<InvestigationStatus>();
            returnCode = new Investigation_BL(base.ContextInfo).GetMappingStatus(63, "EnterResultStatus", OrgID, out lstInvestigationStatus);
            ddlStatus.DataSource = lstInvestigationStatus;
            ddlStatus.DataTextField = "DisplayText";
            ddlStatus.DataValueField = "Status";
            ddlStatus.DataBind();
            // ddlStatus.Items.Insert(0, "--Select--");
            ddlStatus.Items.Insert(0, strSelect);

            ddlStatus.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void LoadMetaData()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;

        try
        {
            string domains = "Priority,SampleStatus,VisitType,SampleRejectedPeriod";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Priority"
                                 select child;
                drpPriority.DataSource = childItems;
                drpPriority.DataTextField = "DisplayText";
                drpPriority.DataValueField = "Code";
                drpPriority.DataBind();
                //drpPriority.Items.Insert(0, "--Select--");
                drpPriority.Items.Insert(0, strSelect);
                drpPriority.Items[0].Value = "0";

                //var childItems1 = from child in lstmetadataOutput
                //                  where child.Domain == "SampleStatus"
                //                  select child;
                //ddlStatus.DataSource = childItems1;
                //ddlStatus.DataTextField = "DisplayText";
                //ddlStatus.DataValueField = "Code";
                //ddlStatus.DataBind();
                //ddlStatus.Items.Insert(0, "--Select--");
                //ddlStatus.Items[0].Value = "-1";

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddlVisitType.DataSource = childItems2;
                ddlVisitType.DataTextField = "DisplayText";
                ddlVisitType.DataValueField = "Code";
                ddlVisitType.DataBind();
                ddlVisitType.SelectedValue = "-1";

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "SampleRejectedPeriod"
                                  select child;
                //ddlInvSamplesStatus.DataSource = childItems3;
                //ddlInvSamplesStatus.DataTextField = "DisplayText";
                //ddlInvSamplesStatus.DataValueField = "Code";
                //ddlInvSamplesStatus.DataBind();
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void lstDepartName()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;

        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
            ObjInv.getOrgDepartName(OrgID, out ObjInvDep);
            ddlDept.DataSource = ObjInvDep;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();
            // ddlDept.Items.Insert(0, "---Select---");
            ddlDept.Items.Insert(0, strSelect);
            ddlDept.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while transform the form ", ex);
        }
    }
    public void Loadprotocalgroup()
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;

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
                    // ddlprotocalgroup.Items.Insert(0, "--Select--");
                    ddlprotocalgroup.Items.Insert(0, strSelect);
                    ddlprotocalgroup.Items[0].Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadMetaData() in Test Master", ex);
        }
    }

    private void GetLocationAndSpeciality()
    {

        long retval = -1;
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<TaskActions> lstCategory = new List<TaskActions>();
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        List<ClientMaster> lstClient = new List<ClientMaster>();
        List<MetaData> lstProtocal = new List<MetaData>();
        TaskProfile taskprofile = new TaskProfile();
        taskprofile.Type = "Enter Result";

        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID, taskprofile.Type, out lstLocation, out lstSpeciality, out lstCategory, out taskprofile, out lstDept, out lstClient, out lstProtocal);

        LoadProtocal(lstProtocal, taskprofile);
        if (lstLocation.Count > 0)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";

            ddlLocation.DataBind();
           

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

    public void LoadLocation()
    {
        returncode = -1;
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
 

        //if (lstLocation.Count > 0)
        //{
        //    LocID = lstLocation[0].AddressID;
        //    LocName = lstLocation[0].Location;
        //    foreach (OrganizationAddress lstLoc in lstLocation)
        //    {
        //        if (lstLoc.AddressID == ILocationID)
        //        {
        //            LocID = lstLoc.AddressID;
        //            LocName = lstLoc.Location;
        //        }
        //    }
        //}
        //Session.Add("LocationID", LocID);
        //Session.Add("LocationName", LocName);

        if (lstLocation.Count > 0)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";

            ddlLocation.DataBind();
          //  ddlLocation.SelectedValue = ILocationID.ToString();
        }
    }

    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
