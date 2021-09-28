using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using Attune.Podium.PerformingNextAction;
public partial class Investigation_PDFInvestigationReport : BasePage
{
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    List<Physician> lstPhysician;
    List<ReferingPhysician> lstRefPhysician;
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long returnCode = -1;
    long pVisitID = 0;
    int menuType, pCount;
    string patientNumber = string.Empty;
    string investigatgionID = "";
    long Locationid = 0;
    int VisitType = 0;
    string WardName = string.Empty;
    string Status = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    string reportID = string.Empty;
    List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
    Investigation_BL ObjInv;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<ImageServerDetails> imgServerdetails = new List<ImageServerDetails>();
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    ActionManager ObjActionManager;
    string FrmDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString(), ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        ObjActionManager = new ActionManager(base.ContextInfo);
        ObjInv = new Investigation_BL(base.ContextInfo);
        if ((isCorporateOrg == "") || (isCorporateOrg == "N"))
        {
            txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        }
        if (!IsPostBack)
        {

            returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
            ddlocation.DataSource = lAddress;
            ddlocation.DataTextField = "City";
            ddlocation.DataValueField = "AddressID";
            //ddlocation.SelectedValue = ILocationID.ToString();
            ddlocation.DataBind();
            ddlocation.Items.Insert(0, "--Select--");
            ddlocation.Items[0].Value = "-1";
            TimeSpan ts = new TimeSpan(2, 0, 0, 0);
            //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Subtract(ts).ToString("dd/MM/yyyy");
            //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            returnCode = ObjInv.GetInvforDept(OrgID, out lstDpt);
            LoadInternalExternal();
            if (lstDpt.Count > 0)
            {
                drpdepartment.DataSource = lstDpt;
                drpdepartment.DataTextField = "DeptName";
                drpdepartment.DataValueField = "DeptId";
                drpdepartment.DataBind();
                drpdepartment.Items.Insert(0, "---Select---");
                drpdepartment.Items[0].Value = "0";
            }
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            if (RoleName == RoleHelper.CustomerCare)
            {
                ddstatus.Items.Clear();
                ListItem item = new ListItem();
                item.Text = "Approve";
                item.Value = "0";
                item.Selected = true;
                ddstatus.Items.Add(item);
            }
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();
            }
        }
        //ddlocation

        if (RoleName == RoleHelper.Patient)
        {
            //Header2.Visible = false;
            AdminHeader.Visible = false;
            lblPatientNo.Visible = false;
            txtPatientNo.Visible = false;
            lblMobile.Visible = false;
            txtMobile.Visible = false;
            lblName.Visible = false;
            txtName.Visible = false;
        }
        else
        {
            Header1.Visible = false;
            //AdminHeader1.Visible = false;
        }
        lblMessage1.Text = string.Empty;
        //txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
        //txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        //txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucINPatientSearch_txtFromDate',1,1);");
        if (!IsPostBack)
            LoadSourceName();

        if ((IntegrationName != string.Empty))
        {
            if (!IsPostBack)
            {

                //lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";


                returnCode = new IntegrationBL(base.ContextInfo).GetImageServerDetails(OrgID, ILocationID, out imgServerdetails);
                if (imgServerdetails.Count > 0)
                {
                    tblcontent.Visible = true;
                    if ((imgServerdetails[0].ExeFilePath == string.Empty) || (imgServerdetails[0].ExeFilePath == null))
                    {
                        lnkInstall.Visible = false;
                        imgInstallExe.Visible = false;
                    }
                    else
                    {
                        lnkInstall.NavigateUrl = imgServerdetails[0].ExeFilePath;
                        lnkInstall.Visible = true;
                        imgInstallExe.Visible = true;
                    }

                    if ((imgServerdetails[0].InstallationGuidePath == string.Empty) || (imgServerdetails[0].InstallationGuidePath == null))
                    {
                        lnkInsguide.Visible = false;
                        imgInsGuide.Visible = false;
                    }
                    else
                    {
                        hdnInstallationGuidePath.Value = imgServerdetails[0].InstallationGuidePath;
                        lnkInsguide.Visible = true;
                        imgInsGuide.Visible = true;

                    }

                    if ((imgServerdetails[0].UserGuidePath == string.Empty) || (imgServerdetails[0].UserGuidePath == null))
                    {
                        lnkUserGuide.Visible = false;
                        imgUserGuide.Visible = false;
                    }
                    else
                    {
                        hnUserGuidePath.Value = imgServerdetails[0].UserGuidePath;
                        lnkUserGuide.Visible = true;
                        imgUserGuide.Visible = true;
                    }
                    hdnIpaddress.Value = imgServerdetails[0].IpAddress;
                    hdnPath.Value = imgServerdetails[0].Path;
                    hdnPortNumber.Value = imgServerdetails[0].PortNumber;
                }
            }
        }

        if (Request.QueryString["vid"] != null)
        {
            rReportViewer.Visible = false;
            tblPatient.Visible = false;
            pVisitID = Convert.ToInt64(Request.QueryString["vid"]);

            if (!IsPostBack)
            {

                try
                {
                    long taskID = -1;
                    long refPhysicianID = -1;
                    Int64.TryParse(Request.QueryString["tid"], out taskID);

                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                    //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

                    if (Request.QueryString["vid"] != null)
                    {
                        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                        List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();

                        returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(pVisitID, out pCount, out patientNumber, out lstOrderderd);

                        objPatientBL.GetReportTemplate(pVisitID, OrgID, LanguageCode, out lstReport, out lstReportName, out lstDpts);
                        if (lstReport.Count() > 0)
                        {
                            grdResultTemp.DataSource = lstReportName;
                            grdResultTemp.DataBind();
                            lblMessage1.Visible = false;
                            //tblcontent.Visible = true;
                            bindCheckBox();
                        }
                        else
                        {
                            lblMessage1.Visible = true;
                            lblMessage1.Text = "No Matching Records Found";
                            // tblcontent.Visible = false;
                        }
                        txtPatientNo.Text = patientNumber.Trim().ToString();
                    }
                    else
                    {

                    }


                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error while Loading SSRS", ex);
                }
            }
        }
        else
        {
            tblPatient.Visible = true;
        }
        DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime wkStDt = DateTime.MinValue;
        DateTime wkEndDt = DateTime.MinValue;
        wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
        wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
        hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
        hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");



        DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
        hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
        dateNow = dateNow.AddMonths(1);
        hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day



        hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
        hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

        #region lastmonth
        DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
        hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
        dtlm = dtlm.AddMonths(1);
        hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
        #endregion

        #region lastweek
        DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime LwkStDt = DateTime.MinValue;
        DateTime LwkEndDt = DateTime.MinValue;
        hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
        hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

        #endregion

        #region lastYear
        DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string tempyear = dt2.AddYears(-1).ToString();
        string[] tyear = new string[5];
        tyear = tempyear.Split('/', '-');
        tyear = tyear[2].Split(' ');
        hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
        hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
        #endregion
        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
                divRegDate.Attributes.Add("display", "block");
            }
            if (hdnShowReport.Value == "true")
                rptMdlPopup.Show();
            else
                rptMdlPopup.Hide();

        }
        if (!IsPostBack)
        {
            long returnRes;
            GateWay gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returnRes = gateWay.GetConfigDetails("PrintbtnInReportViewer", OrgID, out lstConfig);
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "N")
            {
                hdnPrintbtnInReportViewer.Value = "Y";
                btnPrint.Attributes.Add("style", "display:none");
                btnPrint.Visible = false;
            }
            returnRes = gateWay.GetConfigDetails("PDFReportViewer", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                hdnReportViewerConfig.Value = lstConfig[0].ConfigValue;
            }
        }
    }
    private void bindCheckBox()
    {
        DataList chldDataLst = new DataList();
        CheckBox chkbox = new CheckBox();

        foreach (DataListItem items in grdResultTemp.Items)
        {
            chkbox = (CheckBox)items.FindControl("chkSelectAll");
            chkbox.Attributes.Add("onclick", "javascript:SelectAll('" + chkbox.ClientID + "')");
            //chldDataLst = (DataList)items.FindControl("grdResultDate");
        }
        //foreach (DataListItem items in chldDataLst.Items)
        //{
        //      chkbox = (CheckBox)items.FindControl("chkSelectAll");
        //}



    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
            TrustedOrgActions objTrustedOrgActions = new TrustedOrgActions();
            int searchtype = Convert.ToInt32(TaskHelper.SearchType.Lab);

            objTrustedOrgActions.LoggedOrgID = OrgID;
            objTrustedOrgActions.RoleID = RoleID;
            objTrustedOrgActions.IdentifyingType = "PAGE";
            objTrustedOrgActions.IdentifyingActionID = PageID;
            objTrustedOrgActions.SharingOrgID = 0;
            lstTrustedOrgActions.Add(objTrustedOrgActions);
            long ret = 0;
            int ActionCount = 0;
            ret = new TrustedOrg(base.ContextInfo).CheckActionAccess(lstTrustedOrgActions, out ActionCount);
            hdnActionCount.Value = ActionCount.ToString();


            string ReferralType = string.Empty;
            int ReferringPhyID = 0;
            string strUrno = "";
            long lngUrnTypeID = 0;
            //FrmDate = ucDateCtrl.GetFromDate().ToString();
            //ToDate = ucDateCtrl.GetToDate().ToString();
            lnkshwrpt.Style.Add("display", "none");
            List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
            chdept.Style.Add("display", "none");
            string pSearchType = "LAB";
            long clientid = 0;
            clientid = Convert.ToInt64(ddClientName.SelectedValue);
            hdnVID.Value = string.Empty;
            rReportViewer.Visible = false;
            grdResultTemp.Visible = false;
            lblMessage1.Text = string.Empty;
            string status = ddstatus.SelectedItem.ToString();
            if (chkReferalType.Checked)
            {
                hdnReferralType.Value = "I";
            }
            else
            {
                hdnReferralType.Value = "E";
            }

            if (status == "--Select--")
            {
                status = "";
            }
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            string ShareType = "Clinical View";
            if (IsTrustedOrg == "Y")
            {
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            }
            else
            {
                TrustedOrgDetails TOD = new TrustedOrgDetails();
                TOD.SharingOrgID = OrgID;
                lstTOD.Add(TOD);
            }
            string tempfrom = "01/01/2001 00:00:00";
            string fromDate, ToDate;
            if (ddlRegisterDate.SelectedItem.Text != "--Select--")
            {
                if (txtFromDate.Text != "" && txtToDate.Text != "")
                {

                    fromDate = txtFromDate.Text;
                    ToDate = txtToDate.Text;

                }
                else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
                {
                    fromDate = txtFromPeriod.Text;
                    ToDate = txtToPeriod.Text;
                }
                else if (ddlRegisterDate.SelectedItem.Text == "Today")
                {
                    fromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                    ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                }
                else
                {
                    fromDate = txtFromDate.Text;
                    ToDate = txtToDate.Text;

                }
            }
            else
            {
                fromDate = tempfrom;
                ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();

            }
            if (chkReferalType.Checked)
            {
                ReferralType = "I";
                ReferringPhyID = Convert.ToInt32(ddlPhysician.SelectedValue);
            }
            else
            {
                ReferralType = "E";
                ReferringPhyID = Convert.ToInt32(ddlRefPhysician.SelectedValue);
            }
            if (txtURNo.Text != "")
            {
                strUrno = txtURNo.Text;
                lngUrnTypeID = Convert.ToInt64(ddlUrnType.SelectedValue);
            }
            if (RoleName == RoleHelper.Patient)
            {
                returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, fromDate, ToDate, OrgID, pSearchType, out lstPatientVisit, currentPageNo, PageSize, out totalRows);
            }
            else
            {
                returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNo(txtPatientNo.Text.ToString(), txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType, out lstPatientVisit, txtLabNo.Text, Convert.ToInt64(ddlocation.SelectedValue.ToString()), Convert.ToInt64(ddClientName.SelectedValue.ToString()), int.Parse(ddVisitType.SelectedValue.ToString()), txtWardName.Text, status, int.Parse(drpPriority.SelectedValue), int.Parse(drpdepartment.SelectedValue), 0, 0, objTrustedOrgActions,"", 0, "", 0, 0, lstDispatchDetails, currentPageNo, PageSize, out totalRows,"All");
            }


            //lblPName.Text = lstPatientVisit[0].PatientName;


            //Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            //objPatientBL.GetReportTemplate(pVisitID, OrgID, out lstReport, out lstReportName);
            //if (lstReport.Count() > 0)
            //{
            //    grdResultTemp.DataSource = lstReportName;
            //    grdResultTemp.DataBind();
            //    lblMessage1.Visible = false;
            //}
            //else
            //{
            //    lblMessage1.Visible = true;
            //}

            if (lstPatientVisit.Count > 0)
            {
                grdResult.DataSource = lstPatientVisit;
                grdResult.DataBind();
                tblgrdview.Style.Add("display", "block");
                trSelectVisit.Visible = true;
                lblMessage.Text = "";

                menuType = Convert.ToInt32(TaskHelper.SearchType.Lab);

                List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, menuType, out lstVisitSearchAction);
                if (lstActionMaster.Count > 0)
                {
                    //lstActionsMaster = lstActionMaster.ToList();
                    #region Add View State ActionList
                    string temp = string.Empty;
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    ViewState.Add("ActionList", temp);
                    #endregion
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    //ddlVisitActionName.DataValueField = "PageURL";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();
                    ddlVisitActionName.Items.Insert(0, new ListItem("--Select--", "0"));
                    ddlVisitActionName.Visible = true;
                    btnGo.Visible = true;

                    ddlVisitActionName.Items.FindByText("Show Report").Selected = true;
                }
            }
            else
            {
                tblgrdview.Style.Add("display", "none");
                trSelectVisit.Visible = false;
                lblMessage.Text = "";
                lblMessage.Text = "No matching records found";
            }
            hdnHideDetails.Value = "0";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ReBindCollapse", "ChechVisit();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
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
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
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

    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }

    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            pVisitID = Convert.ToInt64(hdnVID.Value);
            if (Convert.ToInt32(patOrgID.Value) != OrgID)
            {
                ShowReport(reportPath, pVisitID, reportID, "", Convert.ToInt32(patOrgID.Value));

            }
            else
            {
                ShowReport(reportPath, pVisitID, reportID, "", OrgID);
            }

        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                long lngVisitID = pv.PatientVisitId;
                string ReportConfig = "PrintReport";
                string PrintConfig = "NO";
                string InvIDs = string.Empty;
                HtmlImage imgPrintReport = (HtmlImage)e.Row.Cells[1].FindControl("imgPrintReport");
                imgPrintReport.Attributes.Add("onclick", "PrintReport('" + lngVisitID + "','" + ReportConfig + "','" + InvIDs + "','" + PrintConfig + "');");

            }
            if (hdnActionCount.Value != "0")
            {
                grdResult.Columns[11].Visible = true;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in InvestigationReport.aspx", Ex);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdndeptid.Value = "";
        HdnCheckBoxId.Value = "";
        try
        {
            if (ddlVisitActionName.SelectedValue != "0")
            {
                long VisitID = Convert.ToInt64(hdnVID.Value);
                uctPatientDetail.LoadPatientDetails(VisitID, OrgID, "");
                //VisitIDs = VisitID;
                long ret = -1;
                int ActionCount = 0;
                string deptid = Convert.ToInt16(drpdepartment.SelectedItem.Value).ToString();

                List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();

                //if (ddlVisitActionName.SelectedItem.Text == "Show Report")
                if (ddlVisitActionName.SelectedValue == "Show_Report_InvestigationReport")
                {
                    if (Convert.ToInt32(patOrgID.Value) != OrgID)
                    {
                        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
                        TrustedOrgActions objTrustedOrgActions = new TrustedOrgActions();
                        int searchtype = Convert.ToInt32(TaskHelper.ActionMaster.Show_Report_InvestigationReport);

                        objTrustedOrgActions.LoggedOrgID = OrgID;
                        objTrustedOrgActions.SharingOrgID = Convert.ToInt32(patOrgID.Value);
                        objTrustedOrgActions.RoleID = RoleID;
                        objTrustedOrgActions.IdentifyingType = "ACTION";
                        objTrustedOrgActions.IdentifyingActionID = searchtype;
                        lstTrustedOrgActions.Add(objTrustedOrgActions);
                        ret = new TrustedOrg(base.ContextInfo).CheckActionAccess(lstTrustedOrgActions, out ActionCount);
                        hdnActionCount.Value = ActionCount.ToString();
                    }
                    if (Convert.ToInt32(patOrgID.Value) == OrgID || ActionCount > 0)
                    {
                        tblReport.Visible = true;
                        returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(Convert.ToInt64(hdnVID.Value), out pCount, out patientNumber, out lstOrderderd);
                        if (lstOrderderd.Count > 0)
                        {
                            //tblPayments.Visible = true;
                            //tblResults.Visible = false;

                            tblPayments.Visible = false;
                            tblResults.Visible = true;

                            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                            if (Convert.ToInt16(drpdepartment.SelectedItem.Value) == 0)
                            {
                                objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value), LanguageCode, out lstReport, out lstReportName, out lstDpts);
                            }
                            else
                            {
                                objPatientBL.GetReportTemplateByDeptID(VisitID, Convert.ToInt32(patOrgID.Value), out lstReport, out lstReportName, out lstDpts, deptid);
                            }
                            if (lstReport.Count() > 0)
                            {
                                grdResultTemp.Visible = true;
                                grdResultTemp.Visible = true;
                                grdResultTemp.DataSource = lstReportName;
                                grdResultTemp.DataBind();
                                bindCheckBox();
                                lblMessage1.Visible = false;
                                dReport.Style.Add("display", "block");
                                //if (RoleName == RoleHelper.ReferringPhysician)
                                //{
                                //    tblcontent.Visible = true;
                                //    lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

                                //}

                            }
                            else
                            {
                                grdResultTemp.Visible = false;
                                lblMessage1.Visible = true;
                                lblMessage1.Text = "No Matching Records Found";
                            }
                            if (lstDpts.Count() > 0)
                            {
                                chkDept.DataSource = lstDpts;
                                chkDept.DataTextField = "DeptName";
                                chkDept.DataValueField = "DeptId";
                                chkDept.DataBind();
                            }


                        }
                        else
                        {
                            tblPayments.Visible = false;
                            tblResults.Visible = true;

                            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                            if (Convert.ToInt16(drpdepartment.SelectedItem.Value) == 0)
                            {
                                objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value), LanguageCode, out lstReport, out lstReportName, out lstDpts);
                            }
                            else
                            {
                                objPatientBL.GetReportTemplateByDeptID(VisitID, Convert.ToInt32(patOrgID.Value), out lstReport, out lstReportName, out lstDpts, deptid);
                            }
                            if (lstReport.Count() > 0)
                            {
                                //uctPatientDetail.l
                                grdResultTemp.Visible = true;
                                grdResultTemp.Visible = true;
                                grdResultTemp.DataSource = lstReportName;
                                grdResultTemp.DataBind();
                                bindCheckBox();
                                lblMessage1.Visible = false;
                                dReport.Style.Add("display", "block");
                                lnkshwrpt.Style.Add("display", "none");
                                chdept.Style.Add("display", "none");

                                //if (RoleName == RoleHelper.ReferringPhysician)
                                //{
                                //    tblcontent.Visible = true;
                                //    lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

                                //}
                            }
                            else
                            {
                                grdResultTemp.Visible = false;
                                lblMessage1.Visible = true;
                                lblMessage1.Text = "No Matching Records Found";
                            }
                            //foreach (InvReportMaster inv in lstReport)
                            //{
                            //    hdndeptid.Value += inv.DeptID.ToString()+"~" ;
                            //}
                            if (lstDpts.Count() > 0)
                            {
                                chkDept.DataSource = lstDpts;
                                chkDept.DataTextField = "DeptName";
                                chkDept.DataValueField = "DeptId";
                                chkDept.DataBind();
                            }


                        }
                        hdndeptvalues.Value = "";
                        foreach (ListItem item in chkDept.Items)
                        {

                            hdndeptvalues.Value += item.Value.ToString() + "~" + item.Text.ToString() + "^";


                        }

                        //foreach (ListItem item in chkDept.Items)
                        //{

                        //    item.Attributes.Add("onclick", "showReports(" + item.Value + ");");

                        //}
                        ActionCount = 1;
                        rReportViewer.Reset();
                        chkSelectAllInv.Checked = false;
                        chkSelectAllUnPrinted.Checked = false;
                        rptMdlPopup.Show();
                    }
                    else if (ActionCount == 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('This action cannot be performed for your role in this Organisation ');", true);
                    }
                }
                else if (ddlVisitActionName.SelectedValue == "Email_Report_InvestigationReport")
                {
                    tblPayments.Visible = false;
                    tblReport.Visible = false;
                    txtMailAddress.Text = hdnEMail.Value;
                    modelPopExtMailReport.Show();
                }
                else
                {

                    //Response.Redirect(Request.ApplicationPath + ddlVisitActionName.SelectedValue + "?VID=" + VisitID, true);
                    #region Get Redirect URL
                    QueryMaster objQueryMaster = new QueryMaster();
                    Utilities objUtilities = new Utilities();
                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;
                    //if (lstActionsMaster.Exists(p => p.ActionCode == ddlVisitActionName.SelectedValue))
                    //{
                    //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlVisitActionName.SelectedValue).QueryString;
                    //}
                    #region View State Action List
                    string ActCode = ddlVisitActionName.SelectedValue;
                    string ActionList = ViewState["ActionList"].ToString();
                    foreach (string CompareList in ActionList.Split('^'))
                    {
                        if (CompareList.Split('~')[0] == ActCode)
                        {
                            QueryString = CompareList.Split('~')[1];
                            break;
                        }
                    }
                    #endregion
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientVisitID = VisitID.ToString();
                    Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    #endregion

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }
    }

    #region Formtodb Date Conversion
    protected string FormtoDb(string val)
    {
        if (val != "")
        {
            string[] dd = val.Split('/');
            val = dd[1].Trim() + "/" + dd[0].Trim() + "/" + dd[2].Trim();
        }
        return val;
    }
    #endregion


    protected void grdResultDate_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");
            var ReportNames =
                from InvName in lstReport
                group InvName by
                        new
                        {
                            InvName.InvestigationName,
                            InvName.TemplateID,
                            InvName.CreatedAt,
                            InvName.PatientID,
                            InvName.DeptID,
                            InvName.Status,
                            InvName.PrintCount
                        }
                    into grp
                    where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
                            && grp.ElementAt(0).CreatedAt == eInvReportMaster.CreatedAt
                    select grp;


            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                invRptMaster.AccessionNumber = lstgrp.ElementAt(0).AccessionNumber;
                invRptMaster.PatientID = lstgrp.ElementAt(0).PatientID;
                invRptMaster.DeptID = lstgrp.ElementAt(0).DeptID;
                invRptMaster.Status = lstgrp.ElementAt(0).Status;
                invRptMaster.PrintCount = lstgrp.ElementAt(0).PrintCount;
                lstrptMaster.Add(invRptMaster);
            }
            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }

            foreach (DataListItem rpt in dtInvName.Items)
            {
                CheckBox chkbox = (CheckBox)rpt.FindControl("ChkBox");
                Label lblDeptID = (Label)rpt.FindControl("lbldeptid");
                Label lblStatus = (Label)rpt.FindControl("lblStatus");
                Label lblInvname = (Label)rpt.FindControl("lblInvname");
                if (lblStatus != null && lblStatus.Text == "Paid" || lblStatus.Text == "SampleReceived" || lblStatus.Text == "SampleCollected" || lblStatus.Text == "Reject" || lblStatus.Text == "Pending")
                {
                    chkbox.Enabled = false;
                    chkbox.Style.Add("display", "none");
                    lblInvname.Style.Add("display", "none");
                }
                string clientid = chkbox.ClientID;


                //code added for select all checkbox - begins
                if (HdnCheckBoxId.Value == "")
                {
                    HdnCheckBoxId.Value = chkbox.ClientID;
                }
                else
                {
                    HdnCheckBoxId.Value += '~' + chkbox.ClientID;
                }

                //code added for select all checkbox - ends
                if (lblStatus.Text != "Reject")
                {
                    hdndeptid.Value += chkbox.ClientID + '~' + lblDeptID.Text + '^';
                }
            }
            if (eInvReportMaster.TemplateID == 4)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "4")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;

                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 5)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "5")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 7)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "7")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 10)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "10")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 11)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "11")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 13)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "13")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 6)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "6")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = false;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 1)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "1")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));


                        lnkshow.Text = "View Image";
                        lnkshow.CommandName = "ViewImage";
                        if (IntegrationName == EnumUtils.stringValueOf(IntegrationHelper.ViewerName.Matrixview))
                        {
                            Label lblPatID = ((Label)rpt.FindControl("lblPatientID"));
                            Label lblInvID = ((Label)rpt.FindControl("lblInvID"));
                            Label lblAccessionNo = ((Label)rpt.FindControl("lblAccessionNo"));
                            try
                            {
                                string value = "1";
                                if (value != "0")
                                {
                                    lnkshow.Visible = false;
                                    string portnumber = hdnPortNumber.Value;
                                    string ipaddress = hdnIpaddress.Value;
                                    lnkshow.Attributes.Add("onClick", "javascript:return launchexe_mv('" + lblPatID.Text + "','" + lblInvID.Text + "','" + lblAccessionNo.Text + "','" + ipaddress + "','" + portnumber + "','" + LoginName + "');");
                                }
                                else
                                {
                                    lnkshow.Visible = false;
                                }
                            }
                            catch (Exception ex)
                            {
                                CLogger.LogError("Connection not establish with Webserives", ex);
                            }
                        }
                        else if (IntegrationName != string.Empty)
                        {
                            lnkshow.Visible = false;
                        }
                    }
                }
            }
        }
    }


    protected void grdResultTemp_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("grdResultDate");

            var ReportNames =
               from InvName in lstReport
               group InvName by
             new
             {
                 InvName.CreatedAt,
                 InvName.TemplateID
             } into grp
               where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
               select grp;
            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                lstrptMaster.Add(invRptMaster);
            }
            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }
        }
    }
    protected void grdResultTemp_ItemCommand(object source, DataListCommandEventArgs e)
    {
    }
    protected void grdResultDate_ItemCommand(object source, DataListCommandEventArgs e)
    {
    }
    public void ShowReport(string reportPath, long visitID, string templateID, string InvID, int pOrgid)
    {
        string ReportConfig = "ShowReport";
        string PrintConfig = "NO";
        string InvIDs = "";
        if (hdnCheckValue.Value.Trim() == "Print")
        {
            PrintConfig = "YES";
        }
        foreach (DataListItem items in grdResultTemp.Items)
        {
            DataList dtResultDate = (DataList)items.FindControl("grdResultDate");
            foreach (DataListItem rpt in dtResultDate.Items)
            {
                DataList dlChildInvName = ((DataList)rpt.FindControl("dlChildInvName"));
                foreach (DataListItem childList in dlChildInvName.Items)
                {
                    CheckBox ChkInv = (CheckBox)childList.FindControl("ChkBox");
                    Label lbl = (Label)childList.FindControl("lblAccessionNo");
                    if (ChkInv.Checked == true)
                    {
                        Label lblInvID = (Label)childList.FindControl("lblInvID");
                        //Label lblReportID = (Label)childList.FindControl("lblReportID");
                        //Label lblAccessionNo = (Label)childList.FindControl("lblAccessionNo");
                        //Label lbldeptid = (Label)childList.FindControl("lbldeptid");
                        Label lblStatus = (Label)childList.FindControl("lblStatus");
                        InvIDs += lblInvID.Text + "~" + lbl.Text + "~" + lblStatus.Text + "^";
                    }
                }
            }
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintPDF", "ShowSelectedReport('" + visitID + "','" + ReportConfig + "','" + InvIDs + "','" + PrintConfig + "');", true);
        hdnCheckValue.Value = "";
    }

    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        string deviceInfo = null;
        string format = "PDF";
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        string[] streamIDs = null;
        Microsoft.Reporting.WebForms.Warning[] warnings = null;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {
            targetStream = new MemoryStream();
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay(base.ContextInfo);
            returnCode = gateWay.GetCommunicationDetails(CommunicationType.EMail, pVisitID, LocationName, out lstCommunicationDetails);
            if (lstCommunicationDetails.Count > 0 && lstCommunicationDetails[0].IsNotify && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
            {
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                sourceStream = new MemoryStream(results);
                PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                PdfSecuritySettings securitySettings = document.SecuritySettings;
                securitySettings.UserPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.OwnerPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.PermitAccessibilityExtractContent = false;
                securitySettings.PermitAnnotations = false;
                securitySettings.PermitAssembleDocument = false;
                securitySettings.PermitExtractContent = false;
                securitySettings.PermitFormsFill = false;
                securitySettings.PermitFullQualityPrint = true;
                securitySettings.PermitModifyDocument = false;
                securitySettings.PermitPrint = true;
                document.Save(targetStream, false);

                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "Report_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                ObjActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail(lstCommunicationDetails[0].To, lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Investigation Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed. Please enable notification settings.');", true);
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }
    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
            if (Request.QueryString["vid"] != null)
            {
                pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                pVisitID = Convert.ToInt64(hdnVID.Value);
            }

            if (reportID == "10")
            {
                investigatgionID = ((Label)e.Item.FindControl("lblInvID")).Text;
                FckEdit1.LoadPatientDemography(OrgID, pVisitID);
                //FckEdit1.loadText("Notes Report");
                FckEdit1.loadText(OrgID, Convert.ToInt64(pVisitID), Convert.ToInt32(reportID), Convert.ToInt64(investigatgionID));
                rptMdlPopup2.Show();


            }
            else
            {
                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, Convert.ToInt32(patOrgID.Value));

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, OrgID);
                }
                rptMdlPopup.Show();
            }
        }
        else if (e.CommandName == "ViewImage")
        {
            try
            {
                string AccessionNumber = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
                string PatientID = ((Label)e.Item.FindControl("lblPatientID")).Text;

                if (IntegrationName == EnumUtils.stringValueOf(IntegrationHelper.ViewerName.Pellucid))
                {
                    string Path = hdnPath.Value + "/Investigation/ImageAccess.aspx?AccessionNumber=" + AccessionNumber;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "page", "javascript:launchSessionUrl('" + Path + "');", true);
                }

            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }
    private string ReturnExtension(string fileExtension)
    {
        switch (fileExtension)
        {
            case ".htm":
            case ".html":
            case ".log":
                return "text/HTML";
            case ".txt":
                return "text/plain";
            case ".doc":
                return "application/ms-word";
            case ".tiff":
            case ".tif":
                return "image/tiff";
            case ".asf":
                return "video/x-ms-asf";
            case ".avi":
                return "video/avi";
            case ".zip":
                return "application/zip";
            case ".xls":
            case ".csv":
                return "application/vnd.ms-excel";
            case ".gif":
                return "image/gif";
            case ".jpg":
            case "jpeg":
                return "image/jpeg";
            case ".bmp":
                return "image/bmp";
            case ".wav":
                return "audio/wav";
            case ".mp3":
                return "audio/mpeg3";
            case ".mpg":
            case "mpeg":
                return "video/mpeg";
            case ".rtf":
                return "application/rtf";
            case ".asp":
                return "text/asp";
            case ".pdf":
                return "application/pdf";
            case ".fdf":
                return "application/vnd.fdf";
            case ".ppt":
                return "application/mspowerpoint";
            case ".dwg":
                return "image/vnd.dwg";
            case ".msg":
                return "application/msoutlook";
            case ".xml":
            case ".sdxl":
                return "application/xml";
            case ".xdp":
                return "application/vnd.adobe.xdp+xml";
            default:
                return "application/octet-stream";
        }
    }
    protected void btnPayNow_Click(object sender, EventArgs e)
    {
        try
        {
            if (RoleName.ToLower() != "Receptionist")
            {
                Tasks task = new Tasks();
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                long patientVisitId = Convert.ToInt64(hdnVID.Value);
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                long taskID = 0;

                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
                    lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber.ToString(), lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitId;
                task.PatientID = lstPatientVisitDetails[0].PatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //create task
                returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
                Response.Redirect("~/Lab/Home.aspx", true);
            }
            else
            {
                Response.Redirect("~/Reception/Home.aspx", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }
    }
    protected void lnkInsguide_Click(object sender, EventArgs e)
    {
        //string filepath = Server.MapPath("~/Downloadsource/Installation Guide for Referring Physician Access.pdf");
        string filepath = Server.MapPath(hdnInstallationGuidePath.Value);
        DownloadFile(filepath);

    }
    protected void lnkUserGuide_Click(object sender, EventArgs e)
    {
        //string filepath = Server.MapPath("~/Downloadsource/User Guide for Referring Physician Access.pdf");
        string filepath = Server.MapPath(hnUserGuidePath.Value);
        DownloadFile(filepath);

    }
    public void LoadSourceName()
    {
        try
        {
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetInvClientMaster(OrgID, "", out lstSourceName);
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
                ddClientName.Items.Insert(0, "------SELECT------");
                ddClientName.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
        }
    }
    protected void DownloadFile(string filepath)
    {


        System.IO.FileInfo file = new System.IO.FileInfo(filepath);

        // Checking if file exists
        if (file.Exists)
        {
            // Clear the content of the response
            Response.ClearContent();

            // LINE1: Add the file name and attachment, which will force the open/cance/save dialog to show, to the header
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

            // Add the file size into the response header
            Response.AddHeader("Content-Length", file.Length.ToString());

            // Set the ContentType
            Response.ContentType = ReturnExtension(file.Extension.ToLower());

            // Write the file into the response (TransmitFile is for ASP.NET 2.0. In ASP.NET 1.1 you have to use WriteFile instead)
            Response.TransmitFile(file.FullName);

            // End the response
            Response.End();
        }
    }
    public void LoadInternalExternal()
    {
        lstPhysician = new List<Physician>();
        lstRefPhysician = new List<ReferingPhysician>();

        new PatientVisit_BL(base.ContextInfo).GetInternalExternalPhysician(OrgID, out lstPhysician, out lstRefPhysician);
        if (lstPhysician.Count > 0)
        {
            //ListItem li = new ListItem("None", "-1");
            //ddlPhysician.Items.Add(li);

            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
            ddlPhysician.Items.Insert(0, "-----Select-----");
            ddlPhysician.Items[0].Value = "0";
            tdchkReferalType.Style.Add("display", "block");
            chkReferalType.Checked = true;
            tdRPinternal.Style.Add("display", "block");
            tdRPExternal.Style.Add("display", "none");
        }
        else
        {
            chkReferalType.Checked = false;
            tdchkReferalType.Style.Add("display", "none");
            tdRPinternal.Style.Add("display", "none");
            tdRPExternal.Style.Add("display", "block");
        }

        if (lstRefPhysician.Count > 0)
        {
            ddlRefPhysician.DataSource = lstRefPhysician;
            ddlRefPhysician.DataTextField = "PhysicianName";
            ddlRefPhysician.DataValueField = "ReferingPhysicianID";
            ddlRefPhysician.DataBind();
            ddlRefPhysician.Items.Insert(0, "-----Select-----");
            ddlRefPhysician.Items[0].Value = "0";
        }
    }
    protected void lnkShowRecord_Click(object sender, EventArgs e)
    {
        long VisitID = Convert.ToInt64(hdnVID.Value);
        string deptids = string.Empty;
        foreach (ListItem Deptcheck in this.chkDept.Items)
        {

            if (Deptcheck.Selected)
            {

                deptids += Convert.ToInt32(Deptcheck.Value).ToString() + ',';

            }
        }
        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
        if (deptids == string.Empty)
        {
            objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value), LanguageCode, out lstReport, out lstReportName, out lstDpts);
        }
        else
        {
            objPatientBL.GetReportTemplateByDeptID(VisitID, Convert.ToInt32(patOrgID.Value), out lstReport, out lstReportName, out lstDpts, deptids);
        }
        if (lstReport.Count() > 0)
        {

            grdResultTemp.DataSource = null;
            grdResultTemp.DataBind();
            grdResultTemp.Visible = true;
            grdResultTemp.Visible = true;
            grdResultTemp.DataSource = lstReportName;
            grdResultTemp.DataBind();
            bindCheckBox();
            lblMessage1.Visible = false;
            dReport.Style.Add("display", "block");
            lnkshwrpt.Style.Add("display", "none");
            chdept.Style.Add("display", "none");
            //if (RoleName == RoleHelper.ReferringPhysician)
            //{
            //    tblcontent.Visible = true;
            //    lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

            //}

        }
        else
        {
            grdResultTemp.Visible = false;
            lblMessage1.Visible = true;
            lblMessage1.Text = "No Matching Records Found";
        }
        if (lstDpts.Count() > 0)
        {
            chkDept.DataSource = lstDpts;
            chkDept.DataTextField = "DeptName";
            chkDept.DataValueField = "DeptId";
            chkDept.DataBind();
        }
        String values = "";
        for (int i = 0; i < chkDept.Items.Count; i++)
        {
            if (chkDept.Items[i].Selected)
            {
                values += chkDept.Items[i].Value + ",";
            }
        }

        foreach (ListItem item in chkDept.Items)
        {

            item.Attributes.Add("onclick", "showReports(" + item.Value + ");");

        }





    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

        long ReturnCode = -1;
        AuditTransactionDetails obj;
        List<AuditTransactionDetails> ATD = new List<AuditTransactionDetails>();
        try
        {

            long VisitID = Convert.ToInt64(hdnVID.Value);
            long TemplateID = Convert.ToInt64(hdnTemplateId.Value);

            obj = new AuditTransactionDetails();
            obj.AttributeID = VisitID;
            obj.AttributeName = AuditManager.AuditAttribute.Visit;
            obj.CreatedBy = LID;
            ATD.Add(obj);
            obj = new AuditTransactionDetails();
            obj.AttributeID = TemplateID;
            obj.AttributeName = AuditManager.AuditAttribute.Template;
            obj.CreatedBy = LID;
            ATD.Add(obj);
            ReturnCode = new AuditManager_BL(base.ContextInfo).InsertAuditTransactions(ATD, AuditManager.AuditCategoryCode.Report, AuditManager.AuditTypeCode.Print, LID, OrgID, ILocationID);
        }

        catch (Exception s)
        {
            CLogger.LogError("Error while Saving AuditTransaction in Investigation Report ", s);
        }

    }

    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {
            string PrintConfig = "NO";
            pVisitID = Convert.ToInt64(hdnVID.Value);
            string strInvStatus = InvStatus.Approved;
            List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
            List<InvReportMaster> lstInvIDs = new List<InvReportMaster>();
            PDFReportUtil objReportUtil = new PDFReportUtil();
            returnCode = objReportUtil.GetReports(pVisitID, OrgID, ILocationID, strInvStatus, LID, lstInvIDs, PrintConfig, out lstReportSnapshot, true);

            if (lstReportSnapshot.Count > 0)
            {
                byte[] Buffer = lstReportSnapshot[0].Content;
                sourceStream = new MemoryStream(Buffer);

                List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
                GateWay gateWay = new GateWay(base.ContextInfo);
                returnCode = gateWay.GetCommunicationDetails(CommunicationType.EMail, pVisitID, LocationName, out lstCommunicationDetails);

                targetStream = new MemoryStream();
                PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                PdfSecuritySettings securitySettings = document.SecuritySettings;
                securitySettings.UserPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.OwnerPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.PermitAccessibilityExtractContent = false;
                securitySettings.PermitAnnotations = false;
                securitySettings.PermitAssembleDocument = false;
                securitySettings.PermitExtractContent = false;
                securitySettings.PermitFormsFill = false;
                securitySettings.PermitFullQualityPrint = true;
                securitySettings.PermitModifyDocument = false;
                securitySettings.PermitPrint = true;
                document.Save(targetStream, false);

                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "Report_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                ObjActionManager.GetEMailConfig(OrgID, out oMailConfig);
                returnCode = Communication.SendMail(txtMailAddress.Text, string.Empty, string.Empty, "Investigation Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
                if (returnCode == 0)
                {
                    modelPopExtMailReport.Hide();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Report dispatched successfully')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Unable to dispatch the report. please contact system administrator')", true);
                    modelPopExtMailReport.Show();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('There is no approved report for this patient to dispatch')", true);
            }

        }
        catch (Exception ex)
        {
            ErrorDisplay2.ShowError = true;
            ErrorDisplay2.Status = "Error while sending mail" + ex.Message;
            modelPopExtMailReport.Show();
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }
    public string GetInvName(string InvName)
    {
        string returnString = InvName;
        int lLength = 0;
        lLength = InvName.Split('@')[0].LastIndexOf("(");
        if (lLength > 0)
        {
            returnString = InvName.Substring(0, lLength) + "( Printed @" + InvName.Split('@')[1];
        }
        return returnString;
    }
    public void btnShowReport_Click(object sender, EventArgs e)
    {
        ShowReport("", Convert.ToInt64(hdnVID.Value), "", "", OrgID);
        btnGo_Click(sender, e);
        checkAllInv();
        rptMdlPopup.Show();
    }
    public void checkAllInv()
    {
        //foreach (DataListItem items in grdResultTemp.Items)
        //{
        //    DataList dtResultDate = (DataList)items.FindControl("grdResultDate");
        //    foreach (DataListItem rpt in dtResultDate.Items)
        //    {
        //        DataList dlChildInvName = ((DataList)rpt.FindControl("dlChildInvName"));
        //        foreach (DataListItem childList in dlChildInvName.Items)
        //        {
        //            CheckBox ChkInv = (CheckBox)childList.FindControl("ChkBox");
        //            foreach (var ID in HdnCheckBoxId.Value.Split('~'))
        //            {
        //                if (ChkInv.ClientID == ID)
        //                {
        //                    ChkInv.Checked = true;
        //                }
        //            }
        //        }
        //    }
        //}
    }
}