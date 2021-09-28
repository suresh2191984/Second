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
using Attune.Utilitie.Helper;
using System.Data;
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;


public partial class Investigation_InvestigationReportPrint : BasePage
{
    public Investigation_InvestigationReportPrint()
        : base("Investigation_InvestigationReportPrint_aspx")
    {
    }

    List<Patient> lstPatient = new List<Patient>();
    public string lblmessage = Resources.ClientSideDisplayTexts.Investigation_InvestigationReport_aspx_cs_lblmessage;
    ActionManager ObjActionManager;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    int currentPageNo = 1;
    int _pageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
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
    string IsPrintAll = string.Empty;
    string WardName = string.Empty;
    string Status = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<PatientVisit> lstPatientVisitInv = new List<PatientVisit>();
    List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    string reportID = string.Empty;
    List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
    Investigation_BL ObjInv;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<ImageServerDetails> imgServerdetails = new List<ImageServerDetails>();
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<LocationPrintMap> lpm = new List<LocationPrintMap>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    DateTime dTIME;
    string DispatchType = string.Empty;
    string strScript = string.Empty;
    string FrmDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString(), ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    int chkcount = 0;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
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
    string gUID = string.Empty;

    //protected void rdSel_CheckedChanged(object sender, EventArgs e)
    //{
    //    RadioButton rd = (RadioButton)sender;
    //        GridViewRow row = (GridViewRow)grdResult.NamingContainer;
    //     if (rd.Checked == true)
    //        {

    //            foreach (GridViewRow row1 in grdResult.Rows)
    //            {
    //                if (row1.RowType == DataControlRowType.DataRow)
    //                {
    //                    CheckBox Chkall = (CheckBox)row1.FindControl("chkSel");
    //                    Chkall.Enabled = false;

    //                }
    //            }
    //     }
    //}

    //protected void chkSel_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox chk = (CheckBox)sender;
    //    GridViewRow row = (GridViewRow)grdResult.NamingContainer;
    //    if (chk.Checked == true)
    //    {

    //        foreach (GridViewRow row1 in grdResult.Rows)
    //        {
    //            if (row1.RowType == DataControlRowType.DataRow)
    //            {
    //                RadioButton rdall = (RadioButton)row1.FindControl("rdSel");
    //                rdall.Enabled = false;

    //            }
    //        }
    //    }
    //}    

    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_01;
    string AlertType = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;

    #endregion

    #region "Initial"


    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            ObjInv = new Investigation_BL(base.ContextInfo);
            ObjActionManager = new ActionManager(base.ContextInfo);
            AutoCompleteProduct.ContextKey = "NameOnly";
            AutoCompleteExtender1.ContextKey = "0^0";
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();
            AutoCompleteExtenderTestName.ContextKey = OrgID.ToString();
            AutoCompleteExtender6.ContextKey = "Hub";
            AutoCompleteExtender2.ContextKey = "zone" + "~" + "-1";
            tblpage.Style.Add("display", "none");
            trhide1.Style.Add("display", "none");
            trhide2.Style.Add("display", "none");
            trhide3.Style.Add("display", "none");
            string BillPrintHide = GetConfigValue("BillPrint", OrgID);
            hndBillprintHide.Value = BillPrintHide;
            //comment by venkatesh
            //if ((isCorporateOrg == "") || (isCorporateOrg == "N"))
            //{
            //    txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //}


            string sstatus = "";
            if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "")
            {
                sstatus = Request.QueryString["SStatus"].ToString();

            }

            long PatientID = 0;
            if (!IsPostBack)
            {
                PatientID = Convert.ToInt64(UID);
                if (PatientID > 0)
                    LoadReportDetails(OrgID, ILocationID, PatientID);
            }
            if (hdnDispatch.Value == "" && sstatus == "Dispatch")
            {
                if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "")
                {
                    hdnDispatch.Value = "1";
                    hdnCurrent.Value = "";
                    hdnPartial.Value = "";
                    hdnPending.Value = "";
                    PatientGetReports(currentPageNo, PageSize);
                }
            }

            if (hdnPartial.Value == "" && sstatus == "Partial Dispatch")
            {
                if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "")
                {
                    hdnPartial.Value = "1";
                    hdnPending.Value = "";
                    hdnDispatch.Value = "";
                    hdnCurrent.Value = "";
                    PatientGetReports(currentPageNo, PageSize);
                }
            }


            if (hdnPending.Value == "" && sstatus == "Approve")
            {
                if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "")
                {
                    hdnPending.Value = "1";
                    hdnPartial.Value = "";
                    hdnDispatch.Value = "";
                    hdnCurrent.Value = "";
                    PatientGetReports(currentPageNo, PageSize);
                }
            }
            if (!IsPostBack)
            {
                txtdispatchdate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm:ss");
                txtdispatchdate1.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm:ss");
                if (RoleHelper.DispatchController != RoleName)
                {
                    tdAberrant.Attributes.Add("style", "display:none;");
                }
                LoadDespatchMode();
                hdnrolename.Value = RoleName;
                LoadMetaData();
                LoadPriority();
                trFooter.Style.Add("display", "none");
                returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
                if (RoleName == "Client CustomerCare")
                {
                    lAddress = lAddress.FindAll(p => p.AddressID == ILocationID);
                    ddlocation.DataSource = lAddress;
                    ddlocation.DataTextField = "City";
                    ddlocation.DataValueField = "AddressID";
                    ddlocation.DataBind();
                    ddlocation.SelectedValue = ILocationID.ToString();
                }
                else
                {
                    ddlocation.DataSource = lAddress;
                    ddlocation.DataTextField = "City";
                    ddlocation.DataValueField = "AddressID";
                    //ddlocation.SelectedValue = ILocationID.ToString();
                    ddlocation.DataBind();
                    ddlocation.Items.Insert(0, strSelect.Trim());
                    ddlocation.Items[0].Value = "-1";
                    ddlocation.SelectedValue = ILocationID.ToString();
                }
                ///////////////prabakar
                lAddress = lAddress.FindAll(p => p.IsPrint == "Y");

                ddlPrintLocation.DataSource = lAddress;
                ddlPrintLocation.DataTextField = "City";
                ddlPrintLocation.DataValueField = "AddressID";
                ddlPrintLocation.DataBind();
                ddlPrintLocation.Items.Insert(0, strSelect.Trim());
                ddlPrintLocation.Items[0].Value = "-1";
                if (lAddress.Exists(p => p.AddressID == ILocationID))
                {
                    ddlPrintLocation.SelectedValue = ILocationID.ToString();
                }
                ////////////////
                TimeSpan ts = new TimeSpan(2, 0, 0, 0);
                //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Subtract(ts).ToString("dd/MM/yyyy");
                //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                returnCode = ObjInv.GetInvforDept(OrgID, out lstDpt);
                //LoadInternalExternal();
                if (lstDpt.Count > 0)
                {
                    drpdepartment.DataSource = lstDpt;
                    drpdepartment.DataTextField = "DeptName";
                    drpdepartment.DataValueField = "DeptId";
                    drpdepartment.DataBind();
                    drpdepartment.Items.Insert(0, strSelect.Trim());
                    drpdepartment.Items[0].Value = "0";
                }
                else
                {
                    drpdepartment.Items.Insert(0, strSelect.Trim());
                    drpdepartment.Items[0].Value = "0";
                }
                List<URNTypes> objURNTypes = new List<URNTypes>();
                List<URNof> objURNof = new List<URNof>();
                Patient_BL pBL = new Patient_BL(base.ContextInfo);
                if ((RoleName == RoleHelper.CustomerCare) || (RoleName == RoleHelper.DispatchController))
                {
                    ddstatus.Items.Clear();
                    ListItem item = new ListItem();
                    item.Text = "Non Printed";
                    item.Value = "Non Printed";
                    item.Selected = true;
                    ddstatus.Items.Add(item);
                    ListItem item1 = new ListItem();
                    item1.Text = "Printed";
                    item1.Value = "Printed";
                    //item.Selected = true;
                    ddstatus.Items.Add(item1);
                    //ListItem item3 = new ListItem();
                    //item3.Text = "Non Printed";
                    //item3.Value = "Non Printed";
                    ////item.Selected = true;
                    //ddstatus.Items.Add(item3);
                    ListItem item2 = new ListItem();
                    item2.Text = strSelect.Trim();
                    item2.Value = strSelect.Trim();
                    //ddstatus.Items.Add(item2);


                    ddstatus.Items.Add(item2);
                }
                //returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
                //if (returnCode == 0)
                //{
                //    ddlUrnType.DataSource = objURNTypes;
                //    ddlUrnType.DataTextField = "URNType";
                //    ddlUrnType.DataValueField = "URNTypeId";
                //    ddlUrnType.DataBind();
                //}
            }
            //chkAll.Checked = false;
            //ddlocation
            if (RoleName == RoleHelper.Physician)
            {
                if (!IsPostBack)
                {
                    PatientGetReports(currentPageNo, PageSize);
                }
                //Header2.Visible = false;
                //AdminHeader.Visible = false;
                lblPatientNo.Visible = false;
                txtPatientNo.Visible = false;
                lblMobile.Visible = false;
                txtMobile.Visible = false;
                lblName.Visible = false;
                txtName.Visible = false;
                tblPatient.Attributes.Add("style", "display:none;");
            }

            if (RoleName == RoleHelper.Patient)
            {
                if (!IsPostBack)
                {
                    PatientGetReports(currentPageNo, PageSize);
                }
                //Header2.Visible = false;
                //  AdminHeader.Visible = false;
                lblPatientNo.Visible = false;
                txtPatientNo.Visible = false;
                lblMobile.Visible = false;
                txtMobile.Visible = false;
                lblName.Visible = false;
                txtName.Visible = false;
                tblPatient.Attributes.Add("style", "display:none;");
            }
            else
            {
                //  Header1.Visible = false;
                //AdminHeader1.Visible = false;
            }
            lblMessage1.Text = string.Empty;
            //txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
            //txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            //txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucINPatientSearch_txtFromDate',1,1);");
            if (!IsPostBack)
                //LoadSourceName();

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

                                lblMessage1.Text = lblmessage;
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
                {

                    rptMdlPopup.Show();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "ShowHideReport", "ShowHideReport();", true);
                }
                else
                    rptMdlPopup.Hide();
                if (hdnShowLabelReport.Value == "true")
                {

                    ModalPopupLabelPrintExtender1.Show();
                    // ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "ShowHideReport", "ShowHideReport();", true);
                }
                else
                    ModalPopupLabelPrintExtender1.Hide();

            }
            if (!IsPostBack)
            {
                long returnRes;
                GateWay gateWay = new GateWay(base.ContextInfo);
                List<Config> lstConfig = new List<Config>();
                btnPrint.Attributes.Add("style", "display:block");
                btnSendMail.Attributes.Add("style", "display:block");
                returnRes = gateWay.GetConfigDetails("PrintbtnInReportViewer", OrgID, out lstConfig);
                if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                {
                    hdnPrintbtnInReportViewer.Value = "Y";
                    btnPrint.Enabled = false;
                    btnSendMail.Enabled = false;
                }
                Master_BL obj = new Master_BL(base.ContextInfo);
                List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
                List<EmployerDeptMaster> lsttempEmpDeptMaster = new List<EmployerDeptMaster>();
                returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
                if (lstEmpDeptMaster.Count > 0)
                {
                    lsttempEmpDeptMaster = lstEmpDeptMaster.FindAll(P => P.EmpDeptName.ToUpper() == "COURIER");
                    if (lsttempEmpDeptMaster.Count > 0)
                    {
                        tdCourier.Style.Add("display", "block");
                        drplstPerson.DataSource = lsttempEmpDeptMaster;
                        drplstPerson.DataValueField = "EmpDeptID";
                        drplstPerson.DataTextField = "EmpDeptName";
                        drplstPerson.DataBind();
                        AutoCompleteExtender3.ContextKey = lsttempEmpDeptMaster[0].Code.ToString();
                        AutoCompleteExtender4.ContextKey = lsttempEmpDeptMaster[0].Code.ToString();
                        AutoCompleteExtender5.ContextKey = lsttempEmpDeptMaster[0].Code.ToString();
                    }
                    else
                    {
                        tdCourier.Style.Add("display", "none");
                    }
                }
            }
            string strLab = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_02 == null ? "Lab Number" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_02;
            string strVisit = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_03 == null ? "Visit Number" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_03;

            IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
            if (IsNeedExternalVisitIdWaterMark == "Y")
            {
                defaultText = strLab.Trim();
            }
            else
            {
                defaultText = strVisit.Trim();
            }
            txtwatermark();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while page Loading", ex);
        }
    }

    #endregion

    #region "Events"

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        hdnCurrent.Value = "";
        hdnonoroff.Value = "Y";
        PatientGetReports(currentPageNo, PageSize);
        hdnDispatch.Value = "";
        hdnPartial.Value = "";
        hdnPending.Value = "";
        //santhosh
    }

    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GridItemCommand", ex);
        }
    }

    protected void ChildGrid_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string strAlready = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_04 == null ? "Already Published" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_04;
        string strApproved = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_05 == null ? "Approved" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_05;
        string strOutSource = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_06 == null ? "OutSource" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_06;
        string strStatus = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_07 == null ? "Status will not updated" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_07;

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                OrderedInvestigations pv = (OrderedInvestigations)e.Row.DataItem;
                CheckBox chkstatus = (CheckBox)e.Row.FindControl("Chkselectinv");
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                if (pv.Status == "Publish")
                {
                    chkstatus.Enabled = false;
                    //chkstatus.ToolTip = "Already Published";
                    e.Row.ToolTip = strAlready.Trim();
                }
                else if (pv.Status == "Approve")
                {
                    lblStatus.Text = strApproved.Trim();
                    chkstatus.Checked = true;

                }
                else if (pv.Status == "OutSource")
                {
                    lblStatus.Text = strOutSource.Trim();
                    chkstatus.Checked = true;
                    e.Row.BackColor = System.Drawing.Color.FromName("#D0FA58");
                    e.Row.ForeColor = System.Drawing.Color.FromName("#000000");

                }
                else
                {
                    chkstatus.Enabled = false;
                    //chkstatus.ToolTip = "Status will not updated";
                    e.Row.ToolTip = strStatus.Trim();
                }

                if (Convert.ToString(pv.ModifiedAt) == "01/01/0001 00:00:00")
                {
                    e.Row.Cells[4].Text = "-";
                }


            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Investigation  Search child grid view Control", Ex);
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string strPublished = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_08 == null ? "Not Yet Published Investigation" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_08;
        string strReady = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_09 == null ? "Ready To Dispatch" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_09;

        try
        {
            int sno = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                if (RoleHelper.DispatchController == RoleName)
                {
                    //tdActionse.Attributes.Add("style", "display:block");
                    HtmlTableCell td = (HtmlTableCell)e.Row.Cells[1].FindControl("tdDespatch");
                    td.Visible = true;
                    if (pv.IsSTAT == "OutSource")
                    {
                        // e.Row.BackColor = System.Drawing.Color.FromName("#D0FA58");
                        e.Row.CssClass = "OutSrce";
                    }
                    //e.Row.Cells[3].Visible = false;
                    //tdDespatch.Attributes.Add("style", "display:none");
                }



                strScript = "SelectVisit('" + ((CheckBox)e.Row.Cells[1].FindControl("chkSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "','" + pv.CreditLimit + "','" + pv.PriorityName + "','" + pv.PreAuthAmount + "','" + pv.Remarks + "','" + pv.DispatchType + "','" + pv.DispatchValue + "','" + pv.IsAllMedical + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');";
                //((CheckBox)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((CheckBox)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                long lngVisitID = pv.PatientVisitId;
                string label = "../admin/LabelPrint.aspx?visitId=" + lngVisitID + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=LabelPrint";
                //string BillPrint = "../Reception/PrintPage.aspx?pid=" + pv.PatientID + "&vid=" + lngVisitID + "&pagetype=BP&quickbill=N&bid=" + pv.PatientHistoryID + "&visitPur=-1&ClientName=&OrgID=" + OrgID + "&BKNO=&IsPopup=Y&IsNeedInv=N&RedirectPage=/Billing/LabQuickBilling.aspx";
                //lngVisitID = 1829;
                string BillPrint = "../Reception/ViewPrintPage.aspx?vid=" + lngVisitID + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + pv.PatientHistoryID + " &pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y&quickbill=Y";
                //string BillPrint ="../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y";
                //string BillPrint = "../Reception/PrintPage.aspx?pid=" + pv.PatientID + "&vid=" + lngVisitID + "&pagetype=BP&quickbill=N&bid=" + pv.PatientHistoryID + "&visitPur=-1&ClientName=&OrgID=" + OrgID + "&BKNO=&IsPopup=Y&IsNeedInv=N&RedirectPage=/Billing/LabQuickBilling.aspx";
                HtmlImage imgPrintReport = (HtmlImage)e.Row.Cells[1].FindControl("imgPrintReport");
                imgPrintReport.Attributes.Add("onclick", "PrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
                //string label = "../admin/LabelPrint.aspx?visitId=" + lngVisitID + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=LabelPrint";
                //imgPrintReport.Attributes.Add("onclick", "javascript:OpenBillPrint1('" + label + "');");
                string DespatchScript = "SelectDespatchVisit('" + ((CheckBox)e.Row.Cells[1].FindControl("chkSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "','" + pv.PatientName + "','" + pv.Remarks + "','" + pv.DispatchType + "','" + pv.DispatchValue + "','" + pv.IsAllMedical + "','" + pv.CopaymentPercent + "','" + pv.MappingClientID + "');";//IsAllMedical - Healthcheckup 
                //((CheckBox)e.Row.Cells[1].FindControl("chkSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((CheckBox)e.Row.Cells[1].FindControl("chkSel")).Attributes.Add("onclick", DespatchScript);
                btnPrint.Attributes.Add("onclick", "onPrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
                CheckBox chkstatus = (CheckBox)e.Row.FindControl("chkSel");
                if (hdndespatchClientId.Value == "")
                {
                    hdndespatchClientId.Value = chkstatus.ClientID;
                }
                else
                {
                    hdndespatchClientId.Value += "~" + chkstatus.ClientID;
                }

                CheckBox chkSel = (CheckBox)e.Row.FindControl("chkSel");
                if (chkSel.Checked)
                {
                    chkstatus.Enabled = true;
                }

                if (pv.VersionNo != "Publish" || pv.ReferralType == "Dispatch")
                {
                    chkstatus.Enabled = true;
                    chkstatus.ToolTip = strPublished.Trim();
                    chkstatus.Checked = false;
                }
                else if (pv.VersionNo == "Publish")
                {
                    // chkstatus.Checked = true;
                    chkstatus.ToolTip = strReady.Trim();
                    hdndespatchvisit.Value += pv.PatientVisitId.ToString() + "~" + pv.PatientID.ToString() + "^";
                    lbldespatchnames.Text += pv.PatientName + "<br/><br/>";
                }
                string[] splityears = pv.PatientAge.Split(' ');
                string[] splityears1 = pv.PatientAge.Split('/');
                Label lblAge = (Label)e.Row.FindControl("lblAge");
                if (splityears1[0].ToString() == "")
                {
                    string[] sp = splityears[1].ToString().Split(' ');
                    {
                        if (splityears[1].ToString() == "Year(s)")
                            lblAge.Text = "-" + splityears[0] + " y";
                        if (splityears[1].ToString() == "Month(s)")
                            lblAge.Text = "-" + splityears[0] + " m";
                        if (splityears[1].ToString() == "Day(s)")
                            lblAge.Text = "-" + splityears[0] + " d";
                    }

                }
                else
                {
                    if (splityears.Count() > 1)
                    {
                        if (splityears[1].ToString() == "Year(s)")
                        {
                            lblAge.Text = splityears[0].ToString() + " y";
                        }

                        if (splityears[1].ToString() == "Month(s)")
                        {
                            lblAge.Text = splityears[0].ToString() + " m";
                        }
                        if (splityears[1].ToString() == "Day(s)")
                        {
                            lblAge.Text = splityears[0].ToString() + " d";
                        }
                    }
                    else
                    {

                        lblAge.Text = splityears[0].ToString() + " -";
                    }
                }

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

    protected void grdPatientView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient PPD = (Patient)e.Row.DataItem;
                List<Patient> lstChildPatient = new List<Patient>();
                lstChildPatient = (from ex in lstPatient
                                   where ex.PatientVisitID == PPD.PatientVisitID
                                   group ex by new { ex.Name, ex.Status, ex.ReportStatus, ex.Priority, ex.RoundNo, ex.ExternalPatientNumber } into g
                                   select new Patient
                                   {
                                       Name = g.Key.Name,
                                       Status = g.Key.Status,
                                       ReportStatus = g.Key.ReportStatus,
                                       Priority = g.Key.Priority,
                                       RoundNo = g.Key.RoundNo,
                                       ExternalPatientNumber = g.Key.ExternalPatientNumber
                                   }).Distinct().ToList();
                GridView childGrid = (GridView)e.Row.FindControl("grdOrderedinv");
                childGrid.DataSource = lstChildPatient;
                childGrid.DataBind();
                List<Patient> lstpriority = new List<Patient>();
                List<Patient> lstNopriority = new List<Patient>();
                lstpriority = (from CP in lstChildPatient
                               where CP.Priority == 1
                               select CP).ToList();
                //lstNopriority = (from CP in lstChildPatient
                //               where CP.Priority == -1
                //               select CP).ToList();
                if (lstpriority.Count() > 0)
                {
                    hdnPriority.Value = "1";
                }
                //else if (lstNopriority.Count()>0)
                //{
                //    hdnPriority.Value = "-1";
                //}
                else
                {
                    hdnPriority.Value = "2";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Wile binding GetPreviousPhysioVisit ", ex);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {

        hdndeptid.Value = "";
        HdnCheckBoxId.Value = "";
        Hdndisablebox.Value = "";
        hdnShowReport.Value = "false";
        hdnHideReportTemplate.Value = "0";
        rptMdlPopup.Hide();
        modalpopupsendemail.Hide();
        hdnShowLabelReport.Value = "false";
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        ModalPopupLabelPrintExtender1.Hide();
        decimal DueAmount = -1;
        CLogger.LogWarning("InValid 1:" + ddlVisitActionName.SelectedValue);
        try
        {
            rReportViewer.Reset();
            // rReportViewer2.Reset();
            hdnlstInvSelected.Value = string.Empty;
            if (hdnPrintbtnInReportViewer.Value == "Y")
            {
                btnPrint.Enabled = false;
                btnSendMail.Enabled = false;
            }
            if (ddlVisitActionName.SelectedValue != "0")
            {

                //VisitIDs = VisitID;
                long ret = -1;
                int ActionCount = 0;
                string deptid = Convert.ToInt16(drpdepartment.SelectedItem.Value).ToString();

                List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();
                long PVisitID = 0;
                //pVisitID= Convert.ToInt64(hdnVID.Value);                   
                returnCode = new Investigation_BL(base.ContextInfo).GetPatientDueStatus("", 0, PVisitID, OrgID, 0, 0, out DueAmount);
                if (DueAmount.ToString() != "" && DueAmount.ToString() != "0.00" && DueAmount.ToString() != "-1")
                {
                    hdnDue.Value = DueAmount.ToString();
                    hdOrgID.Value = OrgID.ToString();
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "CheckDue();", true);
                btnPrint.Enabled = true;
                btnSendMail.Enabled = true;
                if (DueAmount.ToString() != "" && DueAmount.ToString() != "0.00" && DueAmount.ToString() != "-1" && DueAmount.ToString() != "0")
                {
                    btnPrint.Enabled = false;
                    btnSendMail.Enabled = false;
                }
                if (hdnClientID.Value != "1")
                {
                    btnPrint.Enabled = true;
                    btnSendMail.Enabled = true;
                }

                //if (ddlVisitActionName.SelectedItem.Text == "Show Report")
                if (ddlVisitActionName.SelectedValue == "Show_Report_InvestigationReport")
                {
                    frameReportPreview.Attributes.Clear();
                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    uctPatientDetail.LoadPatientDetails(VisitID, OrgID, "");
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
                        //tblReport.Visible = true;
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
                                lblMessage1.Text = lblmessage;
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
                                grdResultTemp.Visible = true;
                                grdResultTemp.Visible = true;
                                grdResultTemp.DataSource = lstReportName;
                                grdResultTemp.DataBind();
                                bindCheckBox();
                                lblMessage1.Visible = false;
                                dReport.Style.Add("display", "block");
                                lnkshwrpt.Style.Add("display", "block");
                                chdept.Style.Add("display", "block");

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
                                lblMessage1.Text = lblmessage;
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
                        if (tblReport.Visible && tblResults.Visible)
                        {
                            hdnShowReport.Value = "true";
                            rptMdlPopup.Show();
                        }
                        else
                        {
                            hdnShowReport.Value = "false";
                            rptMdlPopup.Hide();
                        }
                    }
                    else if (ActionCount == 0)
                    {
                        string sPath = "Investigation\\\\InvestigationReport.aspx_25";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ShowAlertMsg('" + sPath + " ');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('This action cannot be performed for your role in this Organisation ');", true);
                    }
                }
                else if (ddlVisitActionName.SelectedValue == "Email_Report_InvestigationReport")
                {
                    frameReportPreview.Attributes.Clear();
                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    uctPatientDetail.LoadPatientDetails(VisitID, OrgID, "");
                    hdnSelectedMailButton.Value = "dispatch";
                    tblPayments.Visible = false;
                    //tblReport.Visible = false;
                    txtMailAddress.Text = hdnEMail.Value;
                    modalpopupsendemail.Show();
                }
                else if (ddlVisitActionName.SelectedValue == "Dispatch_Report_InvestigationReport")
                {
                    frameReportPreview.Attributes.Clear();
                    foreach (GridViewRow row1 in grdResult.Rows)
                    {
                        if (row1.RowType == DataControlRowType.DataRow)
                        {
                            CheckBox Chkall = (CheckBox)row1.FindControl("chkSel");
                            if (Chkall.Checked)
                            {
                                chkcount = chkcount + 1;
                            }
                        }
                    }
                    if (DueAmount.ToString() == "" || DueAmount.ToString() == "0.00" || DueAmount.ToString() == "-1" || DueAmount.ToString() == "0")
                    {
                        modelPopExtMailReport.Show();
                    }
                    else if (hdnClientID.Value != "1")
                    {
                        modelPopExtMailReport.Show();
                    }
                    if (chkcount > 0)
                    {
                        panelDispatchType1.Visible = false;
                        panelDispatchMode1.Visible = false;
                        txtPatientMobileNo.Enabled = false;
                        txtPatientMail.Enabled = false;
                    }

                    else
                    {
                        long VisitID = Convert.ToInt64(hdnVID.Value);
                        long PatientID = Convert.ToInt64(hdnPID.Value);
                        SetPatientDispatchDetails(VisitID, PatientID, OrgID);
                    }
                    hdnSelectedMailButton.Value = "dispatch";
                }

                else if (ddlVisitActionName.SelectedValue == "Print_Label_SSRSPrinting")
                {
                    frameReportPreview.Attributes.Clear();

                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    long PatientID = Convert.ToInt64(hdnPID.Value);
                    PatientDetailsLabel.LoadPatientDetails(VisitID, OrgID, "");
                    // SetPatientDispatchDetails(VisitID, PatientID, OrgID);
                    SetPrintLabelPatientDispatchDetails(VisitID, PatientID, OrgID);

                    ModalPopupLabelPrintExtender1.Show();

                }
                //--------Added by Prabakr------
                // CreatedAt 10/09/2013
                // Feature- For Resent Report Option
                else if (ddlVisitActionName.SelectedValue == "Resend_Report")
                {
                    if ((DueAmount.ToString() == "" || DueAmount.ToString() == "0.00" || DueAmount.ToString() == "-1" || DueAmount.ToString() == "0")
                        || (hdnClientID.Value != "1"))
                    {
                        frameReportPreview.Attributes.Clear();
                        long VisitID = Convert.ToInt64(hdnVID.Value);
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.ID = Convert.ToInt64(ddlLocationPrinter.SelectedValue);
                        PC.PatientID = Convert.ToInt64(hdnPID.Value);
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PatientVisitID = VisitID;
                        PC.PageID = Convert.ToInt64(PageID);
                        PC.ButtonName = PageContextDetails.ButtonName;
                        PC.ButtonValue = PageContextDetails.ButtonValue;
                        lstpagecontextkeys.Add(PC);
                        long res = -1;
                        res = AM.PerformingNextStepNotification(PC, "", "");
                        if (res >= 0)
                        {
                            string AlertMessg = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_36 == null ? "Resent Report Generated Successfully" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_36;
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "ValidationWindow(" + AlertMessg.Trim() + "," + AlertType.Trim() + ");", true);
                        }
                    }
                }
                else if (ddlVisitActionName.SelectedValue == "Show_Print")
                {


                    //long pVisitID = Convert.ToInt64(hdnVID.Value);

                    //uctPatientDetail1.LoadPatientDetails(pVisitID, OrgID, "");
                    //string invStatus = InvStatus.Pending.ToLower() + "," + InvStatus.Completed.ToLower() + "," + InvStatus.Validate.ToLower() + "," + InvStatus.Approved.ToLower();
                    Report_BL objReportBL = new Report_BL(base.ContextInfo);
                    //List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();
                    //objReportBL.GetPath(OrgID, pVisitID, "", out ReportPath);

                    //string filePath = string.Empty;
                    //if (ReportPath.Count() > 0)
                    //{
                    //    filePath = ReportPath[0].ReportPath;
                    //}
                    //frameReportPreview.Attributes["src"] = "../Patient/ReportPdf.aspx?pdf=" + filePath + "&type=" + hdnPDFType.Value.ToString();
                    if (chkAll.Checked == true || ddlPrintType.SelectedValue == "RPTCHK")
                    {
                        PatientGetReportsPrint(-1, -1);
                    }
                    else
                    {
                        long VisitID = 0;
                        long FinalBillID = 0;
                        int flag = 0;
                        foreach (GridViewRow gvRow in grdResult.Rows)
                        {
                            if (gvRow.RowType == DataControlRowType.DataRow)
                            {
                                //CLogger.LogWarning("ddlVisitActionName.SelectedValue1 " + ddlVisitActionName.SelectedValue);
                                CheckBox chkSel = (CheckBox)gvRow.FindControl("chkSel");
                                if (chkSel.Checked == true)
                                {
                                    //CLogger.LogWarning("ddlVisitActionName.SelectedValue2 " + ddlVisitActionName.SelectedValue);
                                    //TextBox txtpatientId = (TextBox)gvRow.FindControl("PatientID");
                                    TextBox Patientvisit = (TextBox)gvRow.FindControl("txtPatientvisitId");
                                    Label FinalBill = (Label)gvRow.FindControl("FinalURN");
                                    string pSearchType = ddlPrintType.SelectedValue;
                                    CLogger.LogWarning("venkat11");
                                    if (Patientvisit != null)
                                    {
                                        VisitID = Convert.ToInt64(Patientvisit.Text);
                                    }
                                    CLogger.LogWarning("venkat12");
                                    if (FinalBill != null)
                                    {
                                        FinalBillID = Convert.ToInt64(FinalBill.Text);
                                    }
                                    CLogger.LogWarning("venkat13");
                                    ActionManager AM = new ActionManager(base.ContextInfo);
                                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                    PageContextkey PC = new PageContextkey();
                                    PC.ID = Convert.ToInt64(ddlLocationPrinter.SelectedValue);
                                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                                    PC.RoleID = Convert.ToInt64(RoleID);
                                    PC.OrgID = OrgID;
                                    PC.PatientVisitID = VisitID;
                                    PC.FinalBillID = FinalBillID;
                                    PC.BillNumber = FinalBillID.ToString();
                                    PC.PageID = Convert.ToInt64(PageID);
                                    if (ddlPrintType.SelectedValue == "RPT")
                                    {
                                        PC.ButtonName = "REPORTPRINTBTN";
                                        PC.ButtonValue = "REPORTPRINTBTN";
                                    }
                                    if (ddlPrintType.SelectedValue == "BILL")
                                    {
                                        PC.ButtonName = "BILLPRINTBTN";
                                        PC.ButtonValue = "BILLPRINTBTN";
                                    }
                                    lstpagecontextkeys.Add(PC);
                                    long res = -1;
                                    res = AM.PerformingNextStepNotification(PC, "", "");
                                }
                            }
                        }
                        CLogger.LogWarning("venkat");
                        string AlertMessg = "Print Notification Queue Sent";
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Printed Successfully');", true);
                        tblgrdview.Style.Add("display", "none");
                        trFooter.Attributes.Add("style", "display:none;");
                        tblpage.Attributes.Add("style", "display:none;");
                        divFooterNav.Attributes.Add("style", "display:none;");
                        trSelectVisit.Visible = false;
                    }
                    if (hdnPDFType.Value == "prtpdf")
                    {
                        DataTable dataTable = new DataTable();
                        dataTable.Columns.Add("AccessionNumber", typeof(System.Int64));
                        dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
                        dataTable.Columns.Add("Status", typeof(System.String));
                        DataRow dataRow;

                        lstPatient = (from PA in lstPatient
                                      where PA.ReportStatus == "Report is ready"
                                      select PA).ToList();


                        foreach (var lstgrp in lstPatient)
                        {

                            dataRow = dataTable.NewRow();
                            dataRow["AccessionNumber"] = Convert.ToInt64(lstgrp.ExternalPatientNumber);
                            dataRow["InvestigationID"] = 0;
                            dataRow["Status"] = lstgrp.Status;
                            dataTable.Rows.Add(dataRow);
                        }

                        if (lstPatient.Count > 0)
                        {


                            returnCode = objReportBL.SavePrintedReport(dataTable, pVisitID, OrgID, RoleID, ILocationID, LID, "print", "", string.Empty);

                        }
                    }
                    //mpReportPreview.Show();
                    hdnPDFType.Value = "";

                }

                else
                {
                    //Response.Redirect(Request.ApplicationPath + ddlVisitActionName.SelectedValue + "?VID=" + VisitID, true);
                    #region Get Redirect URL
                    QueryMaster objQueryMaster = new QueryMaster();

                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    uctPatientDetail.LoadPatientDetails(VisitID, OrgID, "");

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
                    AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        string sPath = "Investigation\\\\InvestigationReport.aspx_26";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ShowAlertMsg('" + sPath + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    #endregion

                }

            }

            //PatientGetReports(currentPageNo, PageSize);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport ", ex);
        }

    }

    protected void grdResultDate_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
                InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
                DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");
                //string deptids = string.Empty;

                //foreach (ListItem item in chkDept.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (item.Text != "-----Select All-----")
                //        {

                //            deptids += item.Value.ToString() + ",";
                //        }

                //    }
                //}

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
                    invRptMaster.PkgName = lstgrp.ElementAt(0).PkgName;
                    lstrptMaster.Add(invRptMaster);
                }

                if (lstrptMaster.Count() > 0)
                {
                    dtInvName.DataSource = lstrptMaster;
                    dtInvName.DataBind();
                }

                // hdndeptid.Value = "";

                foreach (DataListItem rpt in dtInvName.Items)
                {
                    CheckBox chkbox = (CheckBox)rpt.FindControl("ChkBox");
                    Label lblDeptID = (Label)rpt.FindControl("lbldeptid");
                    Label lblStatus = (Label)rpt.FindControl("lblStatus");

                    Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
                    InvReportMaster oPINV = (InvReportMaster)e.Item.DataItem;
                    if (oPINV.PkgName != null)
                    {
                        lblPackageName.Text = String.IsNullOrEmpty(oPINV.PkgName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PkgName + ")</span>";
                    }

                    Label lblcount = (Label)rpt.FindControl("lblPrintCount");

                    int count = 0;
                    if (lblcount.Text.Trim() != "")
                    {
                        count = Convert.ToInt32(lblcount.Text);
                        if (Hdndisablebox.Value == "")
                        { Hdndisablebox.Value = lblcount.Text; }
                        else { Hdndisablebox.Value += '~' + lblcount.Text; }
                    }

                    if (lblStatus != null && lblStatus.Text == "Paid" || lblStatus.Text == "SampleReceived" || lblStatus.Text == "SampleCollected" || lblStatus.Text == "With Held")
                    {
                        chkbox.Enabled = false;
                    }
                    string clientid = chkbox.ClientID;


                    //code added for select all checkbox - begins
                    if (HdnCheckBoxId.Value == "")
                    { HdnCheckBoxId.Value = chkbox.ClientID; }
                    else { HdnCheckBoxId.Value += '~' + chkbox.ClientID; }

                    //code added for select all checkbox - ends
                    hdndeptid.Value += chkbox.ClientID + '~' + lblDeptID.Text + '^';



                }

                if (eInvReportMaster.TemplateID == 4)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "4")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;

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
                            lnkshow.Visible = true;
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
                            lnkshow.Visible = true;
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
                            lnkshow.Visible = true;
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
                            lnkshow.Visible = true;
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
                            lnkshow.Visible = true;
                            ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                        }
                    }
                }
                else if (eInvReportMaster.TemplateID == 24)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "24")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
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
                            lnkshow.Visible = true;
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
                                    // MatrixViewService.mvisws ObjMV = new MatrixViewService.mvisws();
                                    //string ImageCount = ObjMV.StudyImageCount(lblPatID.Text, lblInvID.Text, lblAccessionNo.Text);
                                    //XmlDocument mvResultSet = new XmlDocument();
                                    // mvResultSet.LoadXml(ImageCount);
                                    //XmlNodeList xNode = mvResultSet.GetElementsByTagName("imagecount");
                                    string value = "1";// xNode.Item(0).InnerText;
                                    //patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername
                                    //Uri u = new Uri("http://122.165.25.103/mvisws-attune/mvisws.asmx");
                                    //WebProxy w = new WebProxy((;
                                    //w.Address = u;

                                    if (value != "0")
                                    {
                                        lnkshow.Visible = true;
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
                                lnkshow.Visible = true;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GridItemCommand", ex);
        }
    }

    protected void grdResultTemp_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("grdResultDate");

            //var ReportNames =
            //    from InvName in lstReport
            //    group InvName by
            //            new
            //            {
            //                //InvName.InvestigationName,
            //                InvName.TemplateID,
            //                InvName.CreatedAt
            //            }
            //        into grp
            //        where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
            //        select grp;

            var ReportNames =
               from InvName in lstReport
               group InvName by
             new
             {
                 //InvName.InvestigationName,
                 InvName.CreatedAt,
                 InvName.TemplateID
             } into grp
               where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
               select grp;




            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                //invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                //invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
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

        try
        {
            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            if (e.CommandName == "ShowReport")
            {
                reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
                reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
                hdnTemplateId.Value = reportID;
                if (Request.QueryString["vid"] != null)
                {
                    pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                else
                {
                    pVisitID = Convert.ToInt64(hdnVID.Value);
                }

                DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;
                foreach (DataListItem dt in ctr.Items)
                {
                    DataList ctr1 = (DataList)dt.FindControl("dlChildInvName");
                    foreach (DataListItem chk in ctr1.Items)
                    {
                        chkTemp = (CheckBox)chk.FindControl("ChkBox");
                        if (chkTemp.Checked)
                        {
                            lblInvID = (Label)chk.FindControl("lblInvID");
                            lblAccessionNo = (Label)chk.FindControl("lblAccessionNo");
                            lblStatus = (Label)chk.FindControl("lblStatus");
                            strSelVal += lblAccessionNo.Text + ",";

                            objReportPrintHistory = new ReportPrintHistory();
                            objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                            objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                            objReportPrintHistory.Status = lblStatus.Text;
                            lstReportPrintHistory.Add(objReportPrintHistory);
                        }

                    }
                    //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                }
                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));

                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                hdnHideReportTemplate.Value = "1";

                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, Convert.ToInt32(patOrgID.Value));

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, OrgID);
                }
                //rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }

    protected void grdResultDate_ItemCommand(object source, DataListCommandEventArgs e)
    {
        //if (e.CommandName == "ShowReport")
        //{
        //    reportID = ((Label)e.Item.FindControl("lblDtReportID")).Text;
        //    reportPath = ((Label)e.Item.FindControl("lbldtReportname")).Text;
        //    if (Request.QueryString["vid"] != null)
        //    {
        //        pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
        //    }
        //    else
        //    {
        //        pVisitID = Convert.ToInt64(hdnVID.Value);
        //    }

        //    ShowReport(reportPath, pVisitID, reportID, "");
        //    Control ctr = e.Item.FindControl("dlChildInvName");
        //}
        try
        {

            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            if (e.CommandName == "ShowReport")
            {
                reportID = ((Label)e.Item.FindControl("lblDtReportID")).Text;

                reportPath = ((Label)e.Item.FindControl("lbldtReportname")).Text;
                if (Request.QueryString["vid"] != null)
                {
                    pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                else
                {
                    pVisitID = Convert.ToInt64(hdnVID.Value);
                }
                //DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
                //foreach (DataListItem dt in ctr.Items)
                //{
                DataList ctr1 = (DataList)e.Item.FindControl("dlChildInvName");
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;
                foreach (DataListItem chk in ctr1.Items)
                {
                    chkTemp = (CheckBox)chk.FindControl("ChkBox");
                    if (chkTemp.Checked)
                    {
                        lblInvID = (Label)chk.FindControl("lblInvID");
                        lblAccessionNo = (Label)chk.FindControl("lblAccessionNo");
                        lblStatus = (Label)chk.FindControl("lblStatus");
                        strSelVal += lblAccessionNo.Text + ",";

                        objReportPrintHistory = new ReportPrintHistory();
                        objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                        objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                        objReportPrintHistory.Status = lblStatus.Text;
                        lstReportPrintHistory.Add(objReportPrintHistory);
                    }

                }
                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }
                //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                //}
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));
                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                hdnHideReportTemplate.Value = "1";
                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, Convert.ToInt32(patOrgID.Value));

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, OrgID);
                }
                //rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }

    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            hdnSelectedMailButton.Value = "reportviewer";
            txtMailAddress.Text = hdnEMail.Value;
            modalpopupsendemail.Show();
        }
        catch (Exception ex)
        {
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
    }

    protected void dlChildInvName_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
                InvReportMaster oPINV = (InvReportMaster)e.Item.DataItem;
                lblPackageName.Text = String.IsNullOrEmpty(oPINV.PkgName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PkgName + ")</span>";

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error packge name ", ex);
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
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;

                lblInvID = (Label)e.Item.FindControl("lblInvID");
                lblAccessionNo = (Label)e.Item.FindControl("lblAccessionNo");
                lblStatus = (Label)e.Item.FindControl("lblStatus");

                objReportPrintHistory = new ReportPrintHistory();
                objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                objReportPrintHistory.Status = lblStatus.Text;
                lstReportPrintHistory.Add(objReportPrintHistory);

                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }

                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, Convert.ToInt32(patOrgID.Value));

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, OrgID);
                }
                //rptMdlPopup.Show();
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

    protected void btndispatch_Click(object sender, EventArgs e)
    {
        try
        {
            System.Data.DataTable dt = new DataTable();
            System.Data.DataTable dt1 = new DataTable();
            DataColumn dbCol1 = new DataColumn("PatientVisitID");
            DataColumn dbCol2 = new DataColumn("BarcodeNumber");
            DataColumn dbCol3 = new DataColumn("SampleCode");
            DataColumn dbCol4 = new DataColumn("SampleDesc");
            DataColumn dbCol5 = new DataColumn("IPInvSampleCollectionMasterID");
            DataColumn dbCol6 = new DataColumn("PatientId");

            //add columns
            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            DataRow dr;

            DataColumn db1Col1 = new DataColumn("PatientVisitID");
            DataColumn db1Col2 = new DataColumn("BarcodeNumber");
            DataColumn db1Col3 = new DataColumn("SampleCode");
            DataColumn db1Col4 = new DataColumn("SampleDesc");
            DataColumn db1Col5 = new DataColumn("IPInvSampleCollectionMasterID");

            dt1.Columns.Add(db1Col1);
            dt1.Columns.Add(db1Col2);
            dt1.Columns.Add(db1Col3);
            dt1.Columns.Add(db1Col4);
            dt1.Columns.Add(db1Col5);
            DataRow dr1;

            if (Chkoutsource.Checked == true)
            {
                foreach (GridViewRow row1 in gvIndv.Rows)
                {
                    if (row1.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox Chkall = (CheckBox)row1.FindControl("chkSel1");
                        Label lbldespatchstatus = (Label)row1.FindControl("lbldespatchstatus");
                        Label visitid = (Label)row1.FindControl("txtPatientvisitId");
                        Label PatientId = (Label)row1.FindControl("txtpatientId");
                        if (Chkall.Checked)
                        {
                            chkcount = chkcount + 1;
                            dr = dt.NewRow();
                            dr["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                            dr["BarcodeNumber"] = "";
                            dr["SampleCode"] = 0;
                            dr["SampleDesc"] = "";
                            dr["IPInvSampleCollectionMasterID"] = 0;
                            dr["PatientId"] = Convert.ToInt64(PatientId.Text);
                            dt.Rows.Add(dr);

                            dr1 = dt1.NewRow();
                            dr1["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                            dr1["BarcodeNumber"] = "";
                            dr1["SampleCode"] = 0;
                            dr1["SampleDesc"] = "Approve";
                            dr1["IPInvSampleCollectionMasterID"] = 0;
                            //dr1["PatientId"] = Convert.ToInt64(PatientId.Text);
                            dt1.Rows.Add(dr1);
                        }
                    }
                }
            }
            else
            {
                foreach (GridViewRow row1 in grdResult.Rows)
                {
                    if (row1.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox Chkall = (CheckBox)row1.FindControl("chkSel");
                        Label lbldespatchstatus = (Label)row1.FindControl("lbldespatchstatus");
                        TextBox visitid = (TextBox)row1.FindControl("txtPatientvisitId");
                        TextBox PatientId = (TextBox)row1.FindControl("txtpatientId");
                        if (Chkall.Checked)
                        {
                            chkcount = chkcount + 1;
                            dr = dt.NewRow();
                            dr["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                            dr["BarcodeNumber"] = "";
                            dr["SampleCode"] = 0;
                            dr["SampleDesc"] = lbldespatchstatus.Text;
                            dr["IPInvSampleCollectionMasterID"] = 0;
                            dr["PatientId"] = Convert.ToInt64(PatientId.Text);
                            dt.Rows.Add(dr);

                            dr1 = dt1.NewRow();
                            dr1["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                            dr1["BarcodeNumber"] = "";
                            dr1["SampleCode"] = 0;
                            dr1["SampleDesc"] = lbldespatchstatus.Text;
                            dr1["IPInvSampleCollectionMasterID"] = 0;
                            dt1.Rows.Add(dr1);
                        }
                    }
                }
                if (chkcount == 0)
                {
                    foreach (GridViewRow row1 in grdResult.Rows)
                    {
                        if (row1.RowType == DataControlRowType.DataRow)
                        {
                            CheckBox Chkall = (CheckBox)row1.FindControl("chkSel");
                            Label lbldespatchstatus = (Label)row1.FindControl("lbldespatchstatus");
                            TextBox visitid = (TextBox)row1.FindControl("txtPatientvisitId");
                            TextBox PatientId = (TextBox)row1.FindControl("txtpatientId");
                            if (Chkall.Checked)
                            {
                                dr = dt.NewRow();
                                dr["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                                dr["BarcodeNumber"] = "";
                                dr["SampleCode"] = 0;
                                dr["SampleDesc"] = lbldespatchstatus.Text;
                                dr["IPInvSampleCollectionMasterID"] = 0;
                                dr["PatientId"] = Convert.ToInt64(PatientId.Text);
                                dt.Rows.Add(dr);

                                dr1 = dt1.NewRow();
                                dr1["PatientVisitID"] = Convert.ToInt64(visitid.Text);
                                dr1["BarcodeNumber"] = "";
                                dr1["SampleCode"] = 0;
                                dr1["SampleDesc"] = lbldespatchstatus.Text;
                                dr1["IPInvSampleCollectionMasterID"] = 0;
                                dt1.Rows.Add(dr1);
                            }
                        }
                    }
                }
            }

            long returnCode = -1;
            int despatchmode = 0;
            string despatchtype = string.Empty;
            string despatchdate = string.Empty;
            if (chkcount > 0)
            {

                string MobilNo = string.Empty;
                MobilNo = txtPatientMobileNo.Text.Trim();
                string Email = string.Empty;
                Email = txtPatientMail.Text.Trim();

                List<PatientDisPatchDetails> lstPatDispatchDetails = new List<PatientDisPatchDetails>();

                PatientDisPatchDetails pd = null;
                int Count = 0;

                if (Chkoutsource.Checked == true)
                {
                    foreach (GridViewRow gvRow in gvIndv.Rows)
                    {
                        if (gvRow.RowType == DataControlRowType.DataRow)
                        {
                            CheckBox Chkall = (CheckBox)gvRow.FindControl("chkSel1");

                            if (Chkall.Checked)
                            {
                                Label visitid = (Label)gvRow.FindControl("txtPatientvisitId");
                                Label PatientId = (Label)gvRow.FindControl("txtpatientId");
                                Label dispatch = (Label)gvRow.FindControl("txtDispatch");

                                if (dispatch.Text != "")
                                {
                                    string[] lstDispatchType = dispatch.Text.Split('|');
                                    if (lstDispatchType != null)
                                    {
                                        foreach (string d in lstDispatchType)
                                        {
                                            string[] sl = d.Split('^');
                                            if (sl[0] != "" && sl[0] != null)
                                            {
                                                pd = new PatientDisPatchDetails();
                                                pd.VisitID = Convert.ToInt64(visitid.Text.Trim().ToString());
                                                pd.PatientID = Convert.ToInt64(PatientId.Text.Trim().ToString());
                                                pd.DispatchType = sl[0];
                                                pd.DispatchValue = sl[1].Split('~')[0].ToString();
                                                pd.OrgID = OrgID;
                                                lstPatDispatchDetails.Add(pd);

                                            }
                                            else
                                            {

                                            }
                                        }

                                    }
                                }
                                else
                                {
                                    string[] lstDispatchType = dispatch.Text.Split('|');
                                    foreach (string d in lstDispatchType)
                                    {
                                        string[] sl = d.Split('^');
                                        if (sl[0] != null)
                                        {
                                            pd = new PatientDisPatchDetails();
                                            pd.VisitID = Convert.ToInt64(visitid.Text.Trim().ToString());
                                            pd.PatientID = Convert.ToInt64(PatientId.Text.Trim().ToString());
                                            pd.DispatchType = "T";
                                            pd.DispatchValue = "Home";
                                            pd.OrgID = OrgID;
                                            lstPatDispatchDetails.Add(pd);

                                        }
                                    }
                                }
                                Count++;
                            }

                        }
                        else if (Count == 0)
                        {
                            //ErrorDisplay1.ShowError = true;
                            //ErrorDisplay1.Status = "Please Select Atleast One Sample and Click Finish";
                        }
                    }

                }
                else
                {
                    foreach (GridViewRow gvRow in grdResult.Rows)
                    {
                        CheckBox chkBox = (CheckBox)gvRow.FindControl("chkSel");

                        if (chkBox.Checked)
                        {
                            TextBox visitid = (TextBox)gvRow.FindControl("txtPatientvisitId");
                            TextBox PatientId = (TextBox)gvRow.FindControl("txtpatientId");
                            TextBox dispatch = (TextBox)gvRow.FindControl("txtDispatch");

                            if (dispatch.Text != "")
                            {
                                string[] lstDispatchType = dispatch.Text.Split('|');
                                if (lstDispatchType != null)
                                {
                                    foreach (string d in lstDispatchType)
                                    {
                                        string[] sl = d.Split('^');
                                        if (sl[0] != "" && sl[0] != null)
                                        {
                                            pd = new PatientDisPatchDetails();
                                            pd.VisitID = Convert.ToInt64(visitid.Text.Trim().ToString());
                                            pd.PatientID = Convert.ToInt64(PatientId.Text.Trim().ToString());
                                            pd.DispatchType = sl[0];
                                            pd.DispatchValue = sl[1].Split('~')[0].ToString();
                                            pd.OrgID = OrgID;
                                            lstPatDispatchDetails.Add(pd);

                                        }
                                        else
                                        {

                                        }
                                    }

                                }

                            }
                            else
                            {
                                string[] lstDispatchType = dispatch.Text.Split('|');
                                if (lstDispatchType != null)
                                {
                                    foreach (string d in lstDispatchType)
                                    {
                                        string[] sl = d.Split('^');
                                        if (sl[0] != null)
                                        {
                                            pd = new PatientDisPatchDetails();
                                            pd.VisitID = Convert.ToInt64(visitid.Text.Trim().ToString());
                                            pd.PatientID = Convert.ToInt64(PatientId.Text.Trim().ToString());
                                            pd.DispatchType = "T";
                                            pd.DispatchValue = "Home";
                                            pd.OrgID = OrgID;
                                            lstPatDispatchDetails.Add(pd);

                                        }
                                    }
                                }
                                else
                                {
                                }
                            }
                            Count++;
                        }
                        else if (Count == 0)
                        {
                            //    ErrorDisplay1.ShowError = true;
                            //    ErrorDisplay1.Status = "Please Select Atleast One Sample and Click Finish";
                            //}
                        }
                    }
                }

                if (dt.Rows.Count > 0)
                {


                    Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                    returnCode = objPatientBL.saveDispatchInvestigationRestult(dt1, txtcoruriersname.Text, txtDRCoruriersname.Text, hdncourierboyid.Value, LID,
                                                                 txtcomments.Text, OrgID, despatchtype, despatchmode, txtdispatchdate.Text, txtdispatchdate1.Text, lstPatDispatchDetails, MobilNo, Email);
                    if (returnCode >= 0)
                    {

                        returnCode = -1;
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {

                            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();

                            PageContextkey PC = new PageContextkey();
                            PC.ID = Convert.ToInt64(ILocationID);
                            PC.PatientID = Convert.ToInt64(dt.Rows[i][5].ToString());//InvoiceID  
                            PC.RoleID = Convert.ToInt64(RoleID);
                            PC.OrgID = OrgID;
                            PC.ButtonName = ((Button)sender).ID;
                            PC.ButtonValue = ((Button)sender).Text;
                            PC.PatientVisitID = Convert.ToInt64(dt.Rows[i][0].ToString());
                            PC.PageID = Convert.ToInt64(PageID);
                            lstpagecontextkeys.Add(PC);


                            ActionManager am = new ActionManager(base.ContextInfo);
                            List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();

                            List<MailAttachment> lstMailAttachment = GetMailAttachmentfile();
                            returnCode = am.PerformingNextStepWithAttachment(PC, lstMailAttachment, txtPatientMobileNo.Text.Trim(), txtPatientMail.Text.Trim());
                            if (NotifyAudit.Count > 0)
                            {
                                Patient_BL Patsms = new Patient_BL(base.ContextInfo);
                                Patsms.insertNotificationAudit(OrgID, ILocationID, LID, NotifyAudit);

                            }
                        }

                    }

                }

                else
                {

                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    long PatientID = Convert.ToInt64(hdnPID.Value);
                    //PatientGetReports();
                    // List<PatientDisPatchDetails> lstDispatchDetails1 = new List<PatientDisPatchDetails>();
                    // lstDispatchDetails1 = CreateDespatchMode1();
                    //string MobilNo = string.Empty;
                    MobilNo = txtPatientMobileNo.Text.Trim();
                    //string Email = string.Empty;
                    Email = txtPatientMail.Text.Trim();
                    if (dt.Rows.Count > 0)
                    {
                        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                        returnCode = objPatientBL.saveDispatchInvestigationRestult(dt1, txtcoruriersname.Text, txtDRCoruriersname.Text, hdncourierboyid.Value, LID,
                                                                          txtcomments.Text, OrgID, despatchtype, despatchmode, txtdispatchdate.Text, txtdispatchdate1.Text, lstPatDispatchDetails, MobilNo, Email);
                        if (returnCode >= 0)
                        {

                            returnCode = -1;
                            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();

                            PageContextkey PC = new PageContextkey();
                            PC.ID = Convert.ToInt64(PageID);//ClientID
                            PC.PatientID = Convert.ToInt64(PatientID);//InvoiceID  
                            PC.RoleID = Convert.ToInt64(RoleID);
                            PC.OrgID = OrgID;
                            PC.ButtonName = ((Button)sender).ID;
                            PC.ButtonValue = ((Button)sender).Text;
                            PC.PatientVisitID = VisitID;
                            PC.PageID = Convert.ToInt64(PageID);
                            lstpagecontextkeys.Add(PC);


                            ActionManager am = new ActionManager(base.ContextInfo);
                            List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();

                            List<MailAttachment> lstMailAttachment = GetMailAttachmentfile();
                            returnCode = am.PerformingNextStepWithAttachment(PC, lstMailAttachment, txtPatientMobileNo.Text.Trim(), txtPatientMail.Text.Trim());
                            if (NotifyAudit.Count > 0)
                            {
                                Patient_BL Patsms = new Patient_BL(base.ContextInfo);
                                Patsms.insertNotificationAudit(OrgID, ILocationID, LID, NotifyAudit);

                            }

                        }

                    }

                }

                if (returnCode >= 0)
                {
                    rptMdlPopup.Hide();
                    string sPath = "Investigation\\\\InvestigationReport.aspx_30";
                    string AlertMessg = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_37 == null ? "Investigation Report Dispatched Successfully" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_37;
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Dispatchstatus", "ShowAlertMsg1('" + sPath + "');", true);
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "ValidationWindow(" + AlertMessg.Trim() + "," + AlertType.Trim() + ");", true);

                    hdncourierboyid.Value = "0";
                    txtcoruriersname.Text = "";
                    txtDRCoruriersname.Text = "";
                    txtcomments.Text = "";
                    PatientGetReports(currentPageNo, PageSize);
                    DespatchQueue.RefereshDespatchCount();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while dispatching Report", ex);
        }
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            hdnShowReport.Value = "false";
            rptMdlPopup.Hide();
            if (HdnID.Value != string.Empty)
            {
                if (HdnID.Value != e.CommandArgument.ToString())
                {
                    int rID = Convert.ToInt32(HdnID.Value);
                    HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                    ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                    imgBTN.ImageUrl = "~/Images/plus.png";
                    Div1.Style.Add("display", "none");
                }
            }

            if (e.CommandArgument.ToString() != "")
            {
                int A = 0;
                ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
                imgBTN.ImageUrl = "~/Images/minus.png";
                TextBox visitid = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientvisitId");
                HtmlControl Div = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
                string[] str = (Div.Attributes["style"].ToString()).Split(';');
                if (str[0] == "display:block")
                {
                    Div.Style.Add("display", "none");
                    imgBTN.ImageUrl = "~/Images/plus.png";
                }
                else
                {
                    Div.Style.Add("display", "block");
                    A = A + 2;
                }
                if (A != 0)
                {

                    int VisitID = 0;
                    GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGrid");
                    returnCode = new Patient_BL(base.ContextInfo).GetPatientVisitInvestigation(Convert.ToInt64(visitid.Text), OrgID, out lstOrderedInv);
                    if (lstOrderedInv.Count != 0)
                    {
                        if (lstOrderedInv[0].Status == "OutSource")
                        {
                            ChildGrd.BackColor = System.Drawing.Color.FromName("#D0FA58");
                            ChildGrd.Columns[4].Visible = true;

                        }

                        Button Gobtn = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        //Gobtn.Focus();
                        ChildGrd.DataSource = lstOrderedInv;
                        ChildGrd.DataBind();
                        //Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        //DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        //Gobtn1.Visible = true;
                        //DrpList.Visible = true;

                    }
                    else
                    {
                        ChildGrd.DataSource = null;
                        //Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        //DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        ////Gobtn1.Visible = false;
                        //DrpList.Visible = false;
                    }

                }
                else
                {
                    Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                    DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                    Label lblstat = (Label)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblIsstat");
                    if (lblstat.Text == "OutSource")
                    {
                        grdResult.Rows[Convert.ToInt32(e.CommandArgument)].BackColor = System.Drawing.Color.FromName("#D0FA58");
                    }

                    PatientGetReports(currentPageNo, PageSize);
                    //Gobtn1.Visible = false;
                    //DrpList.Visible = false;
                    //hdnPending.Value = "";

                }
            }
            HdnID.Value = e.CommandArgument.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
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

    protected void lnkShowRecord_Click(object sender, EventArgs e)
    {
        hdnHideReportTemplate.Value = "0";
        rReportViewer.Reset();
        hdnlstInvSelected.Value = string.Empty;
        if (hdnPrintbtnInReportViewer.Value == "Y")
        {
            btnPrint.Enabled = false;
            btnSendMail.Enabled = false;
        }
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
            lnkshwrpt.Style.Add("display", "block");
            chdept.Style.Add("display", "block");
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
            lblMessage1.Text = lblmessage;
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

        //long ReturnCode = -1;
        //AuditTransactionDetails obj;
        //List<AuditTransactionDetails> ATD = new List<AuditTransactionDetails>();
        try
        {

            //long VisitID = Convert.ToInt64(hdnVID.Value);
            //long TemplateID = Convert.ToInt64(hdnTemplateId.Value);

            //obj = new AuditTransactionDetails();
            //obj.AttributeID = VisitID;
            //obj.AttributeName = AuditManager.AuditAttribute.Visit;
            //obj.CreatedBy = LID;
            //ATD.Add(obj);
            //obj = new AuditTransactionDetails();
            //obj.AttributeID = TemplateID;
            //obj.AttributeName = AuditManager.AuditAttribute.Template;
            //obj.CreatedBy = LID;
            //ATD.Add(obj);

            //ReturnCode = new AuditManager_BL(base.ContextInfo).InsertAuditTransactions(ATD, AuditManager.AuditCategoryCode.Report, AuditManager.AuditTypeCode.Print, LID, OrgID, ILocationID);
            AuditReportAction(AuditManager.AuditTypeCode.Print, string.Empty);
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
        bool isByteAvailable = false;
        try
        {
            pVisitID = Convert.ToInt64(hdnVID.Value);
            byte[] results = new byte[byte.MaxValue];
            if (hdnSelectedMailButton.Value == "dispatch")
            {
                string strInvStatus = InvStatus.Approved;
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(strInvStatus);
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();

                ReportUtil objReportUtil = new ReportUtil();
                returnCode = objReportUtil.GetReports(pVisitID, OrgID, RoleID, ILocationID, lstInvStatus, LID, true, "printreport", "", -1, "","", out lstReportSnapshot,languageCode);
                if (lstReportSnapshot.Count > 0)
                {
                    results = lstReportSnapshot[0].Content;
                    isByteAvailable = true;
                }
            }
            else
            {
                string deviceInfo = null;
                string format = "PDF";
                string encoding = String.Empty;
                string mimeType = String.Empty;
                string extension = String.Empty;
                string[] streamIDs = null;
                Microsoft.Reporting.WebForms.Warning[] warnings = null;
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                isByteAvailable = true;
            }
            if (isByteAvailable)
            {
                sourceStream = new MemoryStream(results);

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
                    AuditReportAction(AuditManager.AuditTypeCode.Email, txtMailAddress.Text);
                    modalpopupsendemail.Hide();

                    string sPath = "Investigation\\\\InvestigationReport.aspx_27";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ShowAlertMsg('" + sPath + "')", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Report dispatched successfully')", true);
                }
                else
                {
                    string sPath = "Investigation\\\\InvestigationReport.aspx_28";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ShowAlertMsg('" + sPath + "')", true);

                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Unable to dispatch the report. please contact system administrator')", true);
                    modalpopupsendemail.Show();
                }
            }
            else
            {
                string sPath = "Investigation\\\\InvestigationReport.aspx_29";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ShowAlertMsg('" + sPath + "')", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "alert('Unable to get the report. please contact system administrator')", true);
            }

        }
        catch (Exception ex)
        {
            // ErrorDisplay2.ShowError = true;
            // ErrorDisplay2.Status = "Error while sending mail" + ex.Message;
            modalpopupsendemail.Show();
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }

    protected void lnkUserGuide_Click(object sender, EventArgs e)
    {
        //string filepath = Server.MapPath("~/Downloadsource/User Guide for Referring Physician Access.pdf");
        string filepath = Server.MapPath(hnUserGuidePath.Value);
        DownloadFile(filepath);

    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        try
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
            PatientGetReports(currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
    }

    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        try
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
            PatientGetReports(currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
    }

    protected void btnGo_Click1(object sender, EventArgs e)
    {
        try
        {
            string dispatch = "dispatch";
            if (dispatch != "dispatch")
            {
                InvStatusPopup.Show();
            }
            else
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
                    PatientGetReports(Convert.ToInt32(txtpageNo.Text), PageSize);
                }
                txtpageNo.Text = "";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
    }

    protected void btnGo_Click2(object sender, EventArgs e)
    {


        //dlstDispatchList.DataSource = lstPatientVisitInv;
        //dlstDispatchList.DataBind();
        InvStatusPopup.Show();

    }

    protected void btnGenerateReport_Click(object sender, EventArgs e)
    {
        try
        {
            pVisitID = Convert.ToInt64(hdnVID.Value);
            System.Data.DataTable dt1 = new DataTable();
            DataColumn Col1 = new DataColumn("Content");
            DataColumn col2 = new DataColumn("Status");
            DataColumn Col3 = new DataColumn("NotificationID");
            DataColumn Col4 = new DataColumn("ClientID");
            DataColumn Col5 = new DataColumn("InvoiceID");
            DataColumn Col6 = new DataColumn("Seq_Num");
            DataColumn Col7 = new DataColumn("Category");
            DataColumn Col8 = new DataColumn("FromDate");
            DataColumn Col9 = new DataColumn("TODate");
            DataColumn Col10 = new DataColumn("ReportPath");
            DataColumn Col11 = new DataColumn("OrgID");
            DataColumn Col12 = new DataColumn("OrgAddressID");
            //add columns
            dt1.Columns.Add(Col1);
            dt1.Columns.Add(col2);
            dt1.Columns.Add(Col3);
            dt1.Columns.Add(Col4);
            dt1.Columns.Add(Col5);
            dt1.Columns.Add(Col6);
            dt1.Columns.Add(Col7);
            dt1.Columns.Add(Col8);
            dt1.Columns.Add(Col9);
            dt1.Columns.Add(Col10);
            dt1.Columns.Add(Col11);
            dt1.Columns.Add(Col12);
            byte[] byte1 = new byte[byte.MinValue];
            Report_BL objReportBL = new Report_BL(base.ContextInfo);
            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("Content");
            DataColumn dbCol2 = new DataColumn("TemplateID");
            DataColumn dbCol3 = new DataColumn("Status");
            DataColumn dbCol4 = new DataColumn("ReportPath");
            DataColumn dbCol5 = new DataColumn("AccessionNumber");
            DataColumn dbCol6 = new DataColumn("NotificationID");
            DataColumn dbCol7 = new DataColumn("VisitID");
            DataColumn dbCol8 = new DataColumn("Seq_Num");
            DataColumn dbCol9 = new DataColumn("OrgID");
            DataColumn dbCol10 = new DataColumn("OrgAddressID");
            //add columns
            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            dt.Columns.Add(dbCol7);
            dt.Columns.Add(dbCol8);
            dt.Columns.Add(dbCol9);
            dt.Columns.Add(dbCol10);
            DataRow dr;
            dr = dt.NewRow();
            dr["Content"] = byte1;
            dr["TemplateID"] = 0;
            dr["Status"] = "Priority";
            dr["ReportPath"] = "";
            dr["AccessionNumber"] = "";
            dr["NotificationID"] = "";
            dr["VisitID"] = pVisitID;
            dr["Seq_Num"] = 0;
            dr["OrgID"] = OrgID;
            dr["OrgAddressID"] = OrgID;
            dt.Rows.Add(dr);
            objReportBL.UpdateNotification(dt, dt1);
            // string sPath = "Investigation\\\\InvestigationReport.aspx_30";
            string AlertMessg = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_38 == null ? "Prioritised Report Generated Successfully" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_38;
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Dispatchstatus", "ShowAlertMsg1('" + sPath + "');", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generate Prioritised Report", ex);
        }
    }

    protected void gvIndv_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                if (RoleHelper.DispatchController == RoleName)
                {
                    // tdActionse.Attributes.Add("style", "display:block");
                    //HtmlTableCell td = (HtmlTableCell)e.Row.Cells[1].FindControl("tdDespatch");
                    //td.Visible = true;
                    //if (pv.Status == "OutSource")
                    //{
                    //    e.Row.BackColor = System.Drawing.Color.FromName("#D0FA58");

                    //}
                    //e.Row.Cells[3].Visible = false;
                    //tdDespatch.Attributes.Add("style", "display:none");
                }



                strScript = "SelectVisit('" + ((CheckBox)e.Row.Cells[1].FindControl("Chkinv")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "','" + pv.CreditLimit + "','" + pv.PriorityName + "','" + pv.PreAuthAmount + "','" + pv.Remarks + "','" + pv.DispatchType + "','" + pv.DispatchValue + "','" + pv.IsAllMedical + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');";
                ((CheckBox)e.Row.Cells[0].FindControl("Chkinv")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((CheckBox)e.Row.Cells[0].FindControl("Chkinv")).Attributes.Add("onclick", strScript);

                long lngVisitID = pv.PatientVisitId;
                string label = "../admin/LabelPrint.aspx?visitId=" + lngVisitID + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=LabelPrint";
                //string BillPrint = "../Reception/PrintPage.aspx?pid=" + pv.PatientID + "&vid=" + lngVisitID + "&pagetype=BP&quickbill=N&bid=" + pv.PatientHistoryID + "&visitPur=-1&ClientName=&OrgID=" + OrgID + "&BKNO=&IsPopup=Y&IsNeedInv=N&RedirectPage=/Billing/LabQuickBilling.aspx";
                //lngVisitID = 1829;
                string BillPrint = "../Reception/ViewPrintPage.aspx?vid=" + lngVisitID + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + pv.PatientHistoryID + " &pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y&quickbill=Y";
                //string BillPrint ="../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y";
                //string BillPrint = "../Reception/PrintPage.aspx?pid=" + pv.PatientID + "&vid=" + lngVisitID + "&pagetype=BP&quickbill=N&bid=" + pv.PatientHistoryID + "&visitPur=-1&ClientName=&OrgID=" + OrgID + "&BKNO=&IsPopup=Y&IsNeedInv=N&RedirectPage=/Billing/LabQuickBilling.aspx";
                HtmlImage imgPrintReport = (HtmlImage)e.Row.Cells[1].FindControl("imgPrintReport");
                imgPrintReport.Attributes.Add("onclick", "PrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
                //string label = "../admin/LabelPrint.aspx?visitId=" + lngVisitID + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=LabelPrint";
                //imgPrintReport.Attributes.Add("onclick", "javascript:OpenBillPrint1('" + label + "');");
                // string DespatchScript = "SelectDespatchVisit('" + ((CheckBox)e.Row.Cells[1].FindControl("chkSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "','" + pv.PatientName + "','" + pv.Remarks + "','" + pv.DispatchType + "','" + pv.DispatchValue + "','" + pv.IsAllMedical + "','" + pv.CopaymentPercent + "');";//IsAllMedical - Healthcheckup 
                //((CheckBox)e.Row.Cells[1].FindControl("chkSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((CheckBox)e.Row.Cells[1].FindControl("chkSel")).Attributes.Add("onclick", DespatchScript);
                btnPrint.Attributes.Add("onclick", "onPrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
                CheckBox chkstatus = (CheckBox)e.Row.FindControl("Chkinv");
                if (hdndespatchClientId.Value == "")
                {
                    hdndespatchClientId.Value = chkstatus.ClientID;
                }
                else
                {
                    hdndespatchClientId.Value += "~" + chkstatus.ClientID;
                }


                //if (pv.VersionNo != "Publish" || pv.ReferralType == "Dispatch")
                //{
                //    chkstatus.Enabled = false;
                //    chkstatus.ToolTip = "Not Yet Published Investigation";
                //    chkstatus.Checked = false;
                //}
                //else if (pv.VersionNo == "Publish")
                //{
                //    // chkstatus.Checked = true;
                //    chkstatus.ToolTip = "Ready To Dispatch";
                //    hdndespatchvisit.Value += pv.PatientVisitId.ToString() + "~" + pv.PatientID.ToString() + "^";
                //    lbldespatchnames.Text += pv.PatientName + "<br/><br/>";
                //}

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

    protected void btnPrintLabel_Click(object sender, EventArgs e)
    {

        try
        {

            foreach (ListItem li in chkDispatchTypeLabel.Items)
            {
                if (li.Selected == true)
                {
                    DispatchType = DispatchType + Convert.ToString(li.Value);

                }

            }
            if (DispatchType == "")
            {
                DispatchType = "Home";
            }
            if (Request.QueryString["vid"] != null)
            {
                pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                pVisitID = Convert.ToInt64(hdnVID.Value);
            }
            ModalPopupLabelPrintExtender1.Show();
            ShowReport1("", pVisitID, "1", 0, DispatchType);

            // ModalPopupLabelPrintExtender1.Show();
        }
        catch (Exception ex)
        {

        }

    }

    protected void btnOutSouce_Click(object sender, EventArgs e)
    {
        HdnCheckBoxId.Value = "";
        Hdndisablebox.Value = "";
        rptMdlPopup.Hide();
        modalpopupsendemail.Hide();
        ModalPopupLabelPrintExtender1.Hide();

        try
        {
            foreach (GridViewRow row1 in gvIndv.Rows)
            {
                if (row1.RowType == DataControlRowType.DataRow)
                {
                    CheckBox Chkall = (CheckBox)row1.FindControl("chkSel1");
                    if (Chkall.Checked)
                    {
                        chkcount = chkcount + 1;
                    }
                }
            }
            modelPopExtMailReport.Show();
            if (chkcount > 0)
            {
                panelDispatchType1.Visible = false;
                panelDispatchMode1.Visible = false;
                txtPatientMobileNo.Enabled = false;
                txtPatientMail.Enabled = false;
            }

            else
            {
            }
            hdnSelectedMailButton.Value = "dispatch";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }

    }

    protected void outerRep_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = e.Item.DataItem as DataRowView;
            DataList innerDataList = e.Item.FindControl("dlstDispatchList") as DataList;
            List<PatientVisit> lstP = new List<PatientVisit>();
            //lstP = (from child in lstPatientVisit
            //        select new PatientVisit { ClientName = child.ClientName }).Distinct().ToList();
            Label ClientName = (Label)e.Item.FindControl("ClientName");
            lstP = (from child in lstPatientVisit
                    where child.ClientName.ToUpper() == ClientName.Text.ToString()
                    select child).Distinct().ToList(); ;

            innerDataList.DataSource = lstP;
            innerDataList.DataBind();
        }
    }

    #endregion

    #region "Methods"

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

    public void txtwatermark()
    {
        if (txtVisitNo.Text.Trim() != defaultText.Trim())
        {
            txtVisitNo.Attributes.Add("style", "color:black");
        }
        if (txtVisitNo.Text == "")
        {
            txtVisitNo.Text = defaultText;
            txtVisitNo.Attributes.Add("style", "color:gray");
        }
        txtVisitNo.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtVisitNo.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }

    void LoadDespatchMode()
    {
        try
        {
            long returnCode = -1;
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstactiontype.Count > 0)
            {
                var Dispatch = lstactiontype.FindAll(p => (p.Type == "DisM"));
                chkDespatchMode1.DataSource = Dispatch;
                chkDespatchMode1.DataTextField = "ActionType";
                chkDespatchMode1.DataValueField = "ActionTypeID";
                chkDespatchMode1.DataBind();


                //ddldispatchmodes.DataSource = lstactiontype;
                //ddldispatchmodes.DataTextField = "ActionType";
                //ddldispatchmodes.DataValueField = "ActionTypeID";
                //ddldispatchmodes.DataBind(); 
                ////ListItem lstItem = new ListItem();
                ////lstItem.Text = "--Select--";
                ////lstItem.Value = "0";
                ////ddlDespatchMode.Items.Insert(0, lstItem);
                //ddldispatchmodes.Items.Insert(0, lstItem);
                chkDespatchMode.DataSource = Dispatch;
                chkDespatchMode.DataTextField = "ActionType";
                chkDespatchMode.DataValueField = "ActionTypeID";
                chkDespatchMode.DataBind();


                chkDespatchModeLabel.DataSource = Dispatch;
                chkDespatchModeLabel.DataTextField = "ActionType";
                chkDespatchModeLabel.DataValueField = "ActionTypeID";
                chkDespatchModeLabel.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadDespatchMode", ex);
        }
    }

    private void bindCheckBox()
    {
        try
        {
            DataList chldDataLst = new DataList();
            CheckBox chkbox = new CheckBox();
            CheckBox chkbox1 = new CheckBox();
            foreach (DataListItem items in grdResultTemp.Items)
            {
                chkbox = (CheckBox)items.FindControl("chkSelectAll");
                chkbox.Attributes.Add("onclick", "javascript:SelectAll('" + chkbox.ClientID + "')");

                chkbox1 = (CheckBox)items.FindControl("chkEnableAll");
                chkbox1.Attributes.Add("onclick", "javascript:EnableAll('" + chkbox1.ClientID + "')");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:EnableAll('" + chkbox1.ClientID + "');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while bindCheckBox", ex);
        }

    }

    public void PatientGetReportsPrint(int currentPageNo, int PageSize)
    {
        try
        {
            long PrintLocationID = -1;
            Int64.TryParse(ddlPrintLocation.SelectedValue, out PrintLocationID);
            if (chhprintall.Checked == true || ddlPrintType.SelectedValue == "RPTCHK")
            {
                IsPrintAll = "Y";
            }
            else
            {
                IsPrintAll = "N";
            }
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            lbldespatchnames.Text = "";
            hdnShowReport.Value = "false";
            hdnHideReportTemplate.Value = "0";
            rptMdlPopup.Hide();
            modalpopupsendemail.Hide();
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

            lblpreviousdue.Text = "";
            string ReferralType = string.Empty;
            int ReferringPhyID = 0;
            long ReferringorgID = 0;
            long CourierBoyId = 0;
            long ZoneID = 0;
            long HubID = 0;
            //FrmDate = ucDateCtrl.GetFromDate().ToString();
            //ToDate = ucDateCtrl.GetToDate().ToString();
            lnkshwrpt.Style.Add("display", "none");

            chdept.Style.Add("display", "none");
            string pSearchType = ddlPrintType.SelectedValue;
            long clientid = -1;
            if (hdnClientID.Value != "" && hdnClientID.Value != null)
            {
                string CID = hdnClientID.Value.Split('|')[0];
                clientid = Convert.ToInt64(CID);
                //clientid = Convert.ToInt64(hdnClientID.Value);
                if (hdnpreviousdue.Value != "")
                {
                    string strClient = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_10 == null ? "Client has an outstanding of:" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_10;
                    lblpreviousdue.Text = "" + strClient.Trim() + "  <b> " + hdnpreviousdue.Value + "</b>";
                }
                else
                {
                    lblpreviousdue.Text = "";
                }
            }
            hdnVID.Value = string.Empty;
            rReportViewer.Visible = false;
            grdResultTemp.Visible = false;
            lblMessage1.Text = string.Empty;
            string status = ddstatus.SelectedItem.Value.ToString();
            //if (chkReferalType.Checked)
            //{
            //    hdnReferralType.Value = "I";
            //}
            //else
            //{
            //    hdnReferralType.Value = "E";
            //}
            if (status == strSelect.Trim())
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

            if (Request.QueryString["Fdate"] != null)
            {
                fromDate = Request.QueryString["Fdate"].ToString();
                ToDate = Request.QueryString["Tdate"].ToString();
            }
            else
            {
                if (ddlRegisterDate.SelectedItem.Text != strSelect.Trim())
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
                        fromDate = OrgTimeZone;
                        ToDate = OrgTimeZone;
                    }
                    else
                    {
                        fromDate = txtFromDate.Text;
                        ToDate = txtToDate.Text;

                    }
                }
                else
                {
                    if ((txtPatientNo.Text.ToString() == "") && (txtName.Text == "") && (txtMobile.Text == "") && (txtVisitNo.Text == "")
                        && (ddVisitType.Text == "-1") && (txtLabNo.Text == "")
                        && (txtClientName.Text == "") && (drpPriority.Text == "0") && (ddstatus.Text == strSelect.Trim())
                        && (ddlocation.Text == "-1") && (txtWardName.Text == "") && (drpdepartment.Text == "0") &&
                        (txtTestName.Text == "") && (txtReferringHospital.Text == "") && (txtInternalExternalPhysician.Text == "")
                        && (txtzone.Text == "") && (Chkoutsource.Checked == false) && (ddlPriority.Text == "All"))
                    {
                        string IsWeekAsdefaultdate = GetConfigValues("ReportDefaultSearchCriteria", OrgID);
                        if (IsWeekAsdefaultdate == "Y")
                        {
                            //------------ThisWeek---------------//
                            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            DateTime wkStDt = DateTime.MinValue;
                            DateTime wkEndDt = DateTime.MinValue;
                            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
                            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
                            fromDate = wkStDt.ToString("dd-MM-yyyy");
                            ToDate = wkEndDt.ToString("dd-MM-yyyy");
                            //---------------------------------//
                        }
                        else
                        {
                            fromDate = tempfrom;
                            ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                        }
                    }

                    else
                    {
                        fromDate = tempfrom;
                        ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                    }
                }
            }
            if (hdnPhysicianValue.Value != "0")
            {
                ReferringPhyID = Convert.ToInt32(hdnPhysicianValue.Value.Split('^')[0]);
            }
            ReferringorgID = Convert.ToInt64(hdfReferalHospitalID.Value);
            if (hdnEmpID.Value != "0")
            {
                CourierBoyId = Convert.ToInt64(hdnEmpID.Value);
            }
            if (hdntxtzoneID.Value != "0")
            {
                ZoneID = Convert.ToInt64(hdntxtzoneID.Value);
            }
            if (hdntxtHubID.Value != "0")
            {
                HubID = Convert.ToInt64(hdntxtHubID.Value);
            }
            string visitNo = string.Empty;
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            if (txtVisitNo.Text != null)
            {
                visitNo = txtVisitNo.Text;
            }
            List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
            lstDispatchDetails = CreateDespatchMode();
            if (Chkoutsource.Checked == false)
            {
                if (RoleName == RoleHelper.Physician)
                {
                    status = "APPROVED";
                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(txtPatientNo.Text.ToString(), txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType,
 out lstPatientVisit, txtLabNo.Text, "", clientid, int.Parse(ddVisitType.SelectedValue.ToString()), txtWardName.Text, status, int.Parse(drpPriority.SelectedValue), int.Parse(drpdepartment.SelectedValue), Convert.ToInt32(LoginName), ReferringorgID,
                        objTrustedOrgActions, visitNo, Convert.ToInt64(hdnTestID.Value), hdnTestType.Value, "", "", CourierBoyId, lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll, PrintLocationID, "","","","","");
                }
                if (RoleName == RoleHelper.Patient)
                {
                    status = "APPROVED";
                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(LoginName, txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType, out lstPatientVisit, txtLabNo.Text,
                        "", clientid, int.Parse(ddVisitType.SelectedValue.ToString()), txtWardName.Text, status, int.Parse(drpPriority.SelectedValue), int.Parse(drpdepartment.SelectedValue), ReferringPhyID, ReferringorgID, objTrustedOrgActions, visitNo,
                        Convert.ToInt64(hdnTestID.Value), hdnTestType.Value, "", "", CourierBoyId, lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll, PrintLocationID, "", "", "", "", "");
                }
                else if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "" && hdnonoroff.Value != "Y")
                {
                    string sstatus = Request.QueryString["SStatus"].ToString();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetDispatchStatusReports(fromDate, ToDate, sstatus,
                        lstTOD, OrgID, objTrustedOrgActions, out lstPatientVisit, lstDispatchDetails, currentPageNo,
                        PageSize, out totalRows);
                }
                else if ((RoleName != RoleHelper.Patient) && (RoleName != RoleHelper.Physician))
                {

                    long LocationID = -1;
                    int VisitType = 0;
                    int Priority = 0;
                    int department = 0;
                    long TestID = -1;


                    Int64.TryParse(ddlocation.SelectedValue, out LocationID);
                    Int32.TryParse(ddVisitType.SelectedValue, out VisitType);
                    Int32.TryParse(drpPriority.SelectedValue, out Priority);
                    Int32.TryParse(drpdepartment.SelectedValue, out department);
                    Int64.TryParse(hdnTestID.Value, out TestID);


                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(txtPatientNo.Text.ToString(),
                        txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType,
                        out lstPatientVisit, txtLabNo.Text, "", clientid, VisitType, txtWardName.Text, status,
                    Priority, department, ReferringPhyID, ReferringorgID, objTrustedOrgActions,
                    visitNo, TestID, hdnTestType.Value, "", "", CourierBoyId,
                    lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll, PrintLocationID, "", "", "", "", "");

                }

            }
            long VisitID = 0;
            long FinalBillID = 0;
            //string BillNumber;
            int flag = 0;
            if (ddlPrintType.SelectedValue != "RPTCHK")
            {

                foreach (PatientVisit lst in lstPatientVisit)
                {
                    VisitID = lst.PatientVisitId;
                    FinalBillID = lst.URNofId;
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ddlLocationPrinter.SelectedValue);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = VisitID;
                    PC.FinalBillID = FinalBillID;
                    PC.BillNumber = FinalBillID.ToString();
                    PC.PageID = Convert.ToInt64(PageID);
                    if (ddlPrintType.SelectedValue == "RPT")
                    {
                        PC.ButtonName = "REPORTPRINTBTN";
                        PC.ButtonValue = "REPORTPRINTBTN";
                    }
                    if (ddlPrintType.SelectedValue == "BILL")
                    {
                        PC.ButtonName = "billprintbtn";
                        PC.ButtonValue = "billprintbtn";
                    }
                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                }
                string AlertMessg = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_39 == null ? "Print Notification Queue Sent" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_39;
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "ValidationWindow(" + AlertMessg.Trim() + "," + AlertType.Trim() + ");", true);
            }
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Printed Successfully');", true);
            tblgrdview.Style.Add("display", "none");
            trFooter.Attributes.Add("style", "display:none;");
            tblpage.Attributes.Add("style", "display:none;");
            divFooterNav.Attributes.Add("style", "display:none;");
            trSelectVisit.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }

    public void LoadLocationPrinter()
    {
        returnCode = new Referrals_BL(base.ContextInfo).GetLocationPrinter(OrgID, ILocationID,"", out lpm);
        if (lpm.Count == 1)
        {
            ddlLocationPrinter.DataSource = lpm;
            ddlLocationPrinter.DataTextField = "PrinterName";
            ddlLocationPrinter.DataValueField = "Code";
            ddlLocationPrinter.DataBind();
        }
        else
        {
            ddlLocationPrinter.DataSource = lpm;
            ddlLocationPrinter.DataTextField = "PrinterName";
            ddlLocationPrinter.DataValueField = "Code";
            ddlLocationPrinter.DataBind();
            ddlLocationPrinter.Items.Insert(0, strSelect.Trim());
            ddlLocationPrinter.Items[0].Value = "-1";
        }
        /////////////////

        if (chhprintall.Checked == true)
        {
            IsPrintAll = "Y";
        }
        else
        {
            IsPrintAll = "N";
        }

    }

    public void PatientGetReports(int currentPageNo, int PageSize)
    {
        try
        {
            ///////////
            LoadLocationPrinter();
            long PrintLocationID = -1;
            Int64.TryParse(ddlPrintLocation.SelectedValue, out PrintLocationID);
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            lbldespatchnames.Text = "";
            hdnShowReport.Value = "false";
            hdnHideReportTemplate.Value = "0";
            rptMdlPopup.Hide();
            modalpopupsendemail.Hide();
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

            lblpreviousdue.Text = "";
            string ReferralType = string.Empty;
            int ReferringPhyID = 0;
            long ReferringorgID = 0;
            long CourierBoyId = 0;
            long ZoneID = 0;
            long HubID = 0;
            //FrmDate = ucDateCtrl.GetFromDate().ToString();
            //ToDate = ucDateCtrl.GetToDate().ToString();
            lnkshwrpt.Style.Add("display", "none");

            chdept.Style.Add("display", "none");

            string pSearchType = ddlPrintType.SelectedValue;
            long clientid = -1;
            if (hdnClientID.Value != "" && hdnClientID.Value != null)
            {
                string CID = hdnClientID.Value.Split('|')[0];
                clientid = Convert.ToInt64(CID);
                //clientid = Convert.ToInt64(hdnClientID.Value);
                if (hdnpreviousdue.Value != "")
                {
                    string strClient = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_10 == null ? "Client has an outstanding of:" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_10;
                    lblpreviousdue.Text = "" + strClient.Trim() + "  <b> " + hdnpreviousdue.Value + "</b>";
                }
                else
                {
                    lblpreviousdue.Text = "";
                }
            }
            hdnVID.Value = string.Empty;
            rReportViewer.Visible = false;
            grdResultTemp.Visible = false;
            lblMessage1.Text = string.Empty;
            string status = ddstatus.SelectedItem.Value.ToString();
            //if (chkReferalType.Checked)
            //{
            //    hdnReferralType.Value = "I";
            //}
            //else
            //{
            //    hdnReferralType.Value = "E";
            //}

            if (status == strSelect.Trim())
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

            if (Request.QueryString["Fdate"] != null)
            {
                fromDate = Request.QueryString["Fdate"].ToString();
                ToDate = Request.QueryString["Tdate"].ToString();
            }
            else
            {
                if (ddlRegisterDate.SelectedItem.Text != strSelect.Trim())
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
                        fromDate = OrgTimeZone;
                        ToDate = OrgTimeZone;
                    }
                    else
                    {
                        fromDate = txtFromDate.Text;
                        ToDate = txtToDate.Text;

                    }
                }
                else
                {
                    if ((txtPatientNo.Text.ToString() == "") && (txtName.Text == "") && (txtMobile.Text == "") && (txtVisitNo.Text == "")
                        && (ddVisitType.Text == "-1") && (txtLabNo.Text == "")
                        && (txtClientName.Text == "") && (drpPriority.Text == "0") && (ddstatus.Text == "---Select---")
                        && (ddlocation.Text == "-1") && (txtWardName.Text == "") && (drpdepartment.Text == "0") &&
                        (txtTestName.Text == "") && (txtReferringHospital.Text == "") && (txtInternalExternalPhysician.Text == "")
                        && (txtzone.Text == "") && (Chkoutsource.Checked == false) && (ddlPriority.Text == "All"))
                    {
                        string IsWeekAsdefaultdate = GetConfigValues("ReportDefaultSearchCriteria", OrgID);
                        if (IsWeekAsdefaultdate == "Y")
                        {
                            //------------ThisWeek---------------//
                            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            DateTime wkStDt = DateTime.MinValue;
                            DateTime wkEndDt = DateTime.MinValue;
                            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
                            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
                            fromDate = wkStDt.ToString("dd-MM-yyyy");
                            ToDate = wkEndDt.ToString("dd-MM-yyyy");
                            //---------------------------------//
                        }
                        else
                        {
                            fromDate = System.DateTime.Today.AddDays(-2).AddDays(1).ToString();
                            ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                        }
                    }

                    else
                    {
                        fromDate = System.DateTime.Today.AddDays(-2).AddDays(1).ToString();
                        ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                    }
                }
            }
            if (hdnPhysicianValue.Value != "0")
            {
                ReferringPhyID = Convert.ToInt32(hdnPhysicianValue.Value.Split('^')[1]);
            }
            ReferringorgID = Convert.ToInt64(hdfReferalHospitalID.Value);
            if (hdnEmpID.Value != "0")
            {
                CourierBoyId = Convert.ToInt64(hdnEmpID.Value);
            }
            if (hdntxtzoneID.Value != "0")
            {
                ZoneID = Convert.ToInt64(hdntxtzoneID.Value);
            }
            if (hdntxtHubID.Value != "0")
            {
                HubID = Convert.ToInt64(hdntxtHubID.Value);
            }
            string visitNo = string.Empty;
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            if (txtVisitNo.Text != null)
            {
                visitNo = txtVisitNo.Text;
            }
            List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
            lstDispatchDetails = CreateDespatchMode();
            if (Chkoutsource.Checked == false)
            {
                if (RoleName == RoleHelper.Physician)
                {
                    status = "APPROVED";
                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(txtPatientNo.Text.ToString(), txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType, out lstPatientVisit, txtLabNo.Text,
                        "", clientid, int.Parse(ddVisitType.SelectedValue.ToString()),
                        txtWardName.Text, status, int.Parse(drpPriority.SelectedValue), int.Parse(drpdepartment.SelectedValue), Convert.ToInt32(LoginName),

                       ReferringorgID, objTrustedOrgActions, visitNo, Convert.ToInt64(hdnTestID.Value), hdnTestType.Value, "", "", CourierBoyId,
                       lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll, PrintLocationID, "","","","","");
                }
                if (RoleName == RoleHelper.Patient)
                {
                    status = "APPROVED";
                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(LoginName, txtName.Text.ToString(), txtMobile.Text,
                        fromDate, ToDate, OrgID, lstTOD, pSearchType, out lstPatientVisit, txtLabNo.Text, "", clientid, int.Parse(ddVisitType.SelectedValue.ToString()), txtWardName.Text, status, int.Parse(drpPriority.SelectedValue), int.Parse(drpdepartment.SelectedValue),
                        ReferringPhyID, ReferringorgID, objTrustedOrgActions, visitNo, Convert.ToInt64(hdnTestID.Value), hdnTestType.Value, "", "",
                        CourierBoyId, lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll, PrintLocationID, "", "", "", "", "");
                }
                else if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "" && hdnonoroff.Value != "Y")
                {
                    string sstatus = Request.QueryString["SStatus"].ToString();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetDispatchStatusReports(fromDate, ToDate, sstatus,
                        lstTOD, OrgID, objTrustedOrgActions, out lstPatientVisit, lstDispatchDetails, currentPageNo,
                        PageSize, out totalRows);
                }
                else if ((RoleName != RoleHelper.Patient) && (RoleName != RoleHelper.Physician))
                {

                    long LocationID = -1;
                    int VisitType = 0;
                    int Priority = 0;
                    int department = 0;
                    long TestID = -1;

                    Int64.TryParse(ddlocation.SelectedValue, out LocationID);
                    Int32.TryParse(ddVisitType.SelectedValue, out VisitType);
                    Int32.TryParse(drpPriority.SelectedValue, out Priority);
                    Int32.TryParse(drpdepartment.SelectedValue, out department);
                    Int64.TryParse(hdnTestID.Value, out TestID);

                    returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoPrint(txtPatientNo.Text.ToString(),
                        txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType,
                        out lstPatientVisit, txtLabNo.Text, "", clientid, VisitType, txtWardName.Text, status,
                    Priority, department, ReferringPhyID, ReferringorgID, objTrustedOrgActions,
                    visitNo, TestID, hdnTestType.Value, "", "", CourierBoyId,
                    lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority.SelectedValue, IsPrintAll,
                    PrintLocationID, "", "", "", "", "");

                }
                chkAll.Checked = false;

                if (ddlPrintType.SelectedValue == "RPTCHK")
                {
                    string strPrintAt = Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_11 == null ? "Printed At" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReportPrint_aspx_11;

                    btnGo.Attributes.Add("style", "display:none;");
                    Button3.Attributes.Add("style", "display:block;");
                    lblLocationPrinter.Visible = false;
                    ddlLocationPrinter.Visible = false;
                    // grdResult.Visible = false;
                    //dlstDispatchList.Visible = true;
                    //grdDispatchList.DataSource = lstPatientVisit;
                    //grdDispatchList.DataBind();
                    grdResult.Visible = true;
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    grdResult.DataSource = lstPatientVisit;

                    grdResult.DataBind();
                    PatientGetReportsPrint(-1, -1);
                    // dlstDispatchList.DataSource = lstPatientVisit;
                    // dlstDispatchList.DataBind();
                    // outerDataList.DataSource = lstPatientVisit;
                    hdnZonetext.Value = txtzone.Text;
                    lblZOneName.Text = hdnZonetext.Value;
                    lblPrintedAt.Text = "" + strPrintAt.Trim() + " " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                    lblprintingperiod.Text = txtFromPeriod.Text.ToString() + " TO " + txtToPeriod.Text.ToString();
                    List<PatientVisit> lstP = new List<PatientVisit>();
                    lstP = (from child in lstPatientVisit
                            select new PatientVisit { ClientName = child.ClientName }).Distinct().ToList();

                    DataTable dt = new DataTable();
                    DataColumn dbCol1 = new DataColumn("ClientName");
                    DataRow dr;
                    //add columns
                    dt.Columns.Add(dbCol1);
                    for (int j = 0; j < lstP.Count; j++)
                    {
                        dr = dt.NewRow();
                        dr["ClientName"] = lstP[j].ClientName.ToString();
                        dt.Rows.Add(dr);
                    }
                    DataView dv = new DataView(dt);
                    DataTable dt1 = dt.DefaultView.ToTable(true, "ClientName");
                    outerDataList.DataSource = dt1;
                    outerDataList.DataBind();




                }

                else
                {

                    btnGo.Attributes.Add("style", "display:block;");
                    Button3.Attributes.Add("style", "display:none;");
                    lblLocationPrinter.Visible = true;
                    ddlLocationPrinter.Visible = true;
                    //dvInvstigationDetails.Visible = false;
                    //    dlstDispatchList.Visible = false;
                    grdResult.Visible = true;
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    grdResult.DataSource = lstPatientVisit;
                    grdResult.DataBind();

                }

                if (lstPatientVisit.Count > 0)
                {

                    tblpage.Attributes.Add("style", "display:block;");
                    trFooter.Attributes.Add("style", "display:block;");
                    tblgrdview.Style.Add("display", "block");
                    tblindv.Attributes.Add("style", "display:block;");
                    //tblgrdview.Style.Add("display", "none");                       
                    divFooterNav.Attributes.Add("style", "display:block;");

                    trSelectVisit.Visible = true;
                    lblMessage.Text = "";
                    //hdnpreviousdue.Value = "";
                    // hdnClientID.Value = "-1";
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
                        ddlVisitActionName.DataSource = lstActionMaster.FindAll(p => p.ActionCode == "Show_Print");
                        ddlVisitActionName.DataTextField = "ActionName";
                        //ddlVisitActionName.DataValueField = "PageURL";
                        ddlVisitActionName.DataValueField = "ActionCode";
                        ddlVisitActionName.DataBind();
                        ddlVisitActionName.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
                        ddlVisitActionName.Visible = true;
                        btnGo.Visible = true;

                        ddlVisitActionName.Items.FindByText("Print").Selected = true;
                    }
                }
                else
                {
                    tblgrdview.Style.Add("display", "none");
                    trFooter.Attributes.Add("style", "display:none;");
                    tblpage.Attributes.Add("style", "display:none;");
                    divFooterNav.Attributes.Add("style", "display:none;");
                    tblpage.Attributes.Add("style", "display:none;");
                    trSelectVisit.Visible = false;
                    lblMessage.Text = "";
                    lblMessage.Text = lblmessage;
                }
                hdnHideDetails.Value = "0";
                // hdnClientID.Value = "-1";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ReBindCollapse", "ChechVisit();", true);

            }

            else
            {
                returnCode = new PatientVisit_BL(base.ContextInfo).pGetDispatchReportInv(fromDate, ToDate, OrgID, lstTOD, "LAB", out lstPatientVisitInv, ILocationID, -1, -1, "Outsource", 0, 0, 0, objTrustedOrgActions, "", 0, "", 0, 0, lstDispatchDetails, currentPageNo, PageSize, out totalRows, "All");

                gvIndv.DataSource = null;
                gvIndv.DataBind();
                string dispatch = "dispatch";
                if (dispatch != "dispatch")
                {
                    grdDispatchList.DataSource = lstPatientVisitInv;
                    grdDispatchList.DataBind();
                    GrdHeader.Style.Add("display", "none");
                }
                else
                {
                    if (lstPatientVisitInv.Count > 0)
                    {
                        GrdHeader.Style.Add("display", "block");
                        gvIndv.DataSource = lstPatientVisitInv;
                        gvIndv.DataBind();

                        tblindv.Attributes.Add("style", "display:block;");
                        trFooter.Attributes.Add("style", "display:block;");
                        tblgrdview.Attributes.Add("style", "display:none;");
                        btnOutSouce.Visible = true;
                        trOutSource.Visible = true;
                        lblMessage.Text = "";
                        trSelectVisit.Visible = false;

                    }
                    else
                    {
                        tblgrdview.Style.Add("display", "none");
                        trSelectVisit.Visible = false;
                        lblMessage.Text = "";
                        lblMessage.Text = lblmessage;
                    }
                }
            }

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
            //if (RoleHelper.DispatchController == RoleName)
            //{
            //    lstPatientVisit.RemoveAll(p => p.ReferralType == "Dispatch");
            //}
            txtwatermark();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
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

    public void LoadReportDetails(int OrgID, int OrgAddressID, long PatientiD)
    {
        long returnCode = -1;
        try
        {
            Patient_BL objPatientBL = new Patient_BL();
            lstPatient = new List<Patient>();
            returnCode = objPatientBL.GetPatientInvestigationDetails("", "", "", 0, "", "", OrgID, OrgAddressID, PatientiD, "", out lstPatient);
            var VisitDate = (from ex in lstPatient
                             group ex by new { ex.VisitDate, ex.PatientVisitID, ex.FileNo, ex.PatientID } into g
                             select new Patient
                             {
                                 PatientID = g.Key.PatientID,
                                 PatientVisitID = g.Key.PatientVisitID,
                                 VisitDate = g.Key.VisitDate,
                                 FileNo = g.Key.FileNo,
                             }).Distinct().ToList();
            grdPatientView.DataSource = VisitDate;
            grdPatientView.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadReportDetails", ex);
        }
    }

    public void ShowReport(string reportPath, long visitID, string templateID, string InvID, int pOrgid)
    {
        try
        {
            hdnHideReportTemplate.Value = "1";
            hdnShowReport.Value = "true";
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            if (hdnPrintbtnInReportViewer.Value == "Y")
            {
                rReportViewer.ShowPrintButton = false;
            }
            else
            {
                rReportViewer.ShowPrintButton = true;
            }

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[8];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(pOrgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = rReportViewer.ServerReport.GetParameters();

            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();
            rReportViewer.ServerReport.SetParameters(lstParameter);
            //rReportViewer.ServerReport.SetParameters(reportParameterList);
            rReportViewer.ServerReport.Refresh();

            if (hdnPrintbtnInReportViewer.Value == "Y")
            {
                btnPrint.Enabled = true;
                btnSendMail.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }

    //public void LoadSourceName()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
    //        List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
    //        returnCode = objPatientBL.GetInvClientMaster(OrgID, "", out lstSourceName);
    //        if (lstSourceName.Count > 0)
    //        {
    //            ddClientName.DataSource = lstSourceName;
    //            ddClientName.DataTextField = "ClientName";
    //            ddClientName.DataValueField = "ClientID";
    //            ddClientName.DataBind();
    //            ddClientName.Items.Insert(0, "---Select---");
    //            ddClientName.Items[0].Value = "-1";
    //        }
    //    }
    //    catch (Exception e)
    //    {
    //        CLogger.LogError("Error while executing LoadSourceName() in Lab_Home_page ", e);
    //    }
    //}

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

    //public void LoadInternalExternal()
    //{
    //    lstPhysician = new List<Physician>();
    //    lstRefPhysician = new List<ReferingPhysician>();

    //    new PatientVisit_BL(base.ContextInfo).GetInternalExternalPhysician(OrgID, out lstPhysician, out lstRefPhysician);
    //    if (lstPhysician.Count > 0)
    //    {
    //        //ListItem li = new ListItem("None", "-1");
    //        //ddlPhysician.Items.Add(li);

    //        ddlPhysician.DataSource = lstPhysician;
    //        ddlPhysician.DataTextField = "PhysicianName";
    //        ddlPhysician.DataValueField = "PhysicianID";
    //        ddlPhysician.DataBind();
    //        ddlPhysician.Items.Insert(0, "-----Select-----");
    //        ddlPhysician.Items[0].Value = "0";
    //        tdchkReferalType.Style.Add("display", "block");
    //        chkReferalType.Checked = true;
    //        tdRPinternal.Style.Add("display", "block");
    //        tdRPExternal.Style.Add("display", "none");
    //    }
    //    else
    //    {
    //        chkReferalType.Checked = false;
    //        tdchkReferalType.Style.Add("display", "none");
    //        tdRPinternal.Style.Add("display", "none");
    //        tdRPExternal.Style.Add("display", "block");
    //    }

    //    if (lstRefPhysician.Count > 0)
    //    {
    //        ddlRefPhysician.DataSource = lstRefPhysician;
    //        ddlRefPhysician.DataTextField = "PhysicianName";
    //        ddlRefPhysician.DataValueField = "ReferingPhysicianID";
    //        ddlRefPhysician.DataBind();
    //        ddlRefPhysician.Items.Insert(0, "-----Select-----");
    //        ddlRefPhysician.Items[0].Value = "0";
    //    }
    //}

    private void AuditReportAction(string actionType, string recipient)
    {
        try
        {
            long VisitID = Convert.ToInt64(hdnVID.Value);
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("AccessionNumber", typeof(System.Int64));
            dataTable.Columns.Add("InvestigationID", typeof(System.Int64));
            dataTable.Columns.Add("Status", typeof(System.String));
            DataRow dataRow;
            List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
            if (hdnSelectedMailButton.Value == "dispatch")
            {
                Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value), LanguageCode, out lstReport, out lstReportName, out lstDpts);
                }
                else
                {
                    objPatientBL.GetReportTemplate(VisitID, OrgID, LanguageCode, out lstReport, out lstReportName, out lstDpts);
                }
                if (lstReport.Count > 0)
                {
                    List<InvReportMaster> lstSelectedReports = new List<InvReportMaster>();
                    lstSelectedReports = (from child in lstReport
                                          where child.Status == InvStatus.Approved
                                          select child).ToList();
                    if (lstSelectedReports != null && lstSelectedReports.Count > 0)
                    {
                        foreach (InvReportMaster oInvReportMaster in lstSelectedReports)
                        {
                            dataRow = dataTable.NewRow();
                            dataRow["AccessionNumber"] = oInvReportMaster.AccessionNumber;
                            dataRow["InvestigationID"] = oInvReportMaster.InvestigationID;
                            dataRow["Status"] = oInvReportMaster.Status;

                            dataTable.Rows.Add(dataRow);
                        }
                    }
                }
            }

            else
            {
                if (!String.IsNullOrEmpty(hdnlstInvSelected.Value))
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    lstReportPrintHistory = oSerializer.Deserialize<List<ReportPrintHistory>>(hdnlstInvSelected.Value);
                    if (lstReportPrintHistory != null && lstReportPrintHistory.Count > 0)
                    {
                        foreach (ReportPrintHistory oReportPrintHistory in lstReportPrintHistory)
                        {
                            dataRow = dataTable.NewRow();
                            dataRow["AccessionNumber"] = oReportPrintHistory.AccessionNumber;
                            dataRow["InvestigationID"] = oReportPrintHistory.InvestigationID;
                            dataRow["Status"] = oReportPrintHistory.Status;
                            dataTable.Rows.Add(dataRow);
                        }
                    }
                }
            }
            if (dataTable.Rows.Count > 0)
            {
                Report_BL objReportBL = new Report_BL(base.ContextInfo);

                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    returnCode = objReportBL.SavePrintedReport(dataTable, VisitID, Convert.ToInt32(patOrgID.Value), RoleID, ILocationID, LID, actionType, recipient, string.Empty);
                }
                else
                {
                    returnCode = objReportBL.SavePrintedReport(dataTable, VisitID, OrgID, RoleID, ILocationID, LID, actionType, recipient, string.Empty);
                }

                if (returnCode == 0 && hdnSelectedMailButton.Value != "dispatch" && actionType == AuditManager.AuditTypeCode.Print)
                {
                    Label lblAccessionNo, lblPrintCount;
                    Int32 pCount = 0;
                    foreach (DataListItem items in grdResultTemp.Items)
                    {
                        DataList dtResultDate = (DataList)items.FindControl("grdResultDate");
                        foreach (DataListItem rpt in dtResultDate.Items)
                        {
                            DataList dlChildInvName = ((DataList)rpt.FindControl("dlChildInvName"));
                            foreach (DataListItem childList in dlChildInvName.Items)
                            {
                                lblAccessionNo = (Label)childList.FindControl("lblAccessionNo");
                                List<ReportPrintHistory> lst = (from p in lstReportPrintHistory
                                                                where p.AccessionNumber == Convert.ToInt64(lblAccessionNo.Text)
                                                                select p).ToList<ReportPrintHistory>();
                                if (lst != null && lst.Count > 0)
                                {
                                    lblPrintCount = (Label)childList.FindControl("lblPrintCount");
                                    pCount = String.IsNullOrEmpty(lblPrintCount.Text) ? 0 : Convert.ToInt32(lblPrintCount.Text);
                                    lblPrintCount.Text = Convert.ToString(pCount + 1);
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in AuditReportAction:", ex);
            throw ex;
        }
    }

    //public void GetPatientandorderedInvestigation()
    //{
    //    string[] temp = hdndespatchvisit.Value.Split('^');
    //    DataTable dt = new DataTable();
    //    DataColumn col1 = new DataColumn("LoginID");
    //    dt.Columns.Add(col1);
    //    DataRow dr;
    //    for (int i = 0; i < temp.Length; i++)
    //    {
    //        dr = dt.NewRow();
    //        dr["LoginID"] = Convert.ToInt64(temp[i].Split('~')[0]); 
    //    }
    //    if (dt.Rows.Count > 0)
    //    {
    //        List<PatientVisit> lstpatientvisit = new List<PatientVisit>();
    //        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
    //        returnCode = objPatientBL.GetPatientandorderedInvestigation(dt, OrgID, out lstpatientvisit);


    //    }
    //}

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "DespatchType,PrintType,printstatus,CustomPeriodRange,VisitType,Priority,";
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


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DespatchType"
                                 orderby child.DisplayText descending
                                 select child;
                if (childItems.Count() > 0)
                {
                    chkDisPatchType.DataSource = childItems;
                    chkDisPatchType.DataTextField = "DisplayText";
                    chkDisPatchType.DataValueField = "Code";
                    chkDisPatchType.DataBind();

                    //ddldespatch.DataSource = childItems;
                    //ddldespatch.DataTextField = "DisplayText";
                    //ddldespatch.DataValueField = "Code";
                    //ddldespatch.DataBind();
                    //ddldespatch.Items.Insert(0, "--Select--");
                    //ddldespatch.Items[0].Value = "0";

                    ChckdespatchType.DataSource = childItems;
                    ChckdespatchType.DataTextField = "DisplayText";
                    ChckdespatchType.DataValueField = "Code";
                    ChckdespatchType.DataBind();

                    chkDispatchTypeLabel.DataSource = childItems;
                    chkDispatchTypeLabel.DataTextField = "DisplayText";
                    chkDispatchTypeLabel.DataValueField = "Code";
                    chkDispatchTypeLabel.DataBind();


                     var childItems2 = from child in lstmetadataOutput
                                 where child.Domain == "PrintType"
                                 orderby child.DisplayText descending
                                 select child;

                     ddlPrintType.DataSource = childItems2;
                     ddlPrintType.DataTextField = "DisplayText";
                     ddlPrintType.DataValueField = "Code";
                     ddlPrintType.DataBind();


                    var childItems3 = from child in lstmetadataOutput
                                      where child.Domain == "printstatus"
                                 orderby child.DisplayText descending
                                 select child;

                    ddstatus.DataSource = childItems3;
                    ddstatus.DataTextField = "DisplayText";
                    ddstatus.DataValueField = "Code";
                    ddstatus.DataBind();

                    
                     var childItems4 = from child in lstmetadataOutput
                                       where child.Domain == "CustomPeriodRange"
                                 orderby child.DisplayText descending
                                 select child;

                     ddlRegisterDate.DataSource = childItems4;
                     ddlRegisterDate.DataTextField = "DisplayText";
                     ddlRegisterDate.DataValueField = "Code";
                     ddlRegisterDate.DataBind();

                    var childItems5 = from child in lstmetadataOutput
                                       where child.Domain == "VisitType"
                                 orderby child.DisplayText descending
                                 select child;

                     ddVisitType.DataSource = childItems5;
                     ddVisitType.DataTextField = "DisplayText";
                     ddVisitType.DataValueField = "Code";
                     ddVisitType.DataBind();

                     var childItems6 = from child in lstmetadataOutput
                                       where child.Domain == "Priority"
                                       orderby child.DisplayText descending
                                       select child;

                     drpPriority.DataSource = childItems6;
                     drpPriority.DataTextField = "DisplayText";
                     drpPriority.DataValueField = "Code";
                     drpPriority.DataBind();


                                
                    
                }

            }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
            //edisp.Visible = true;

        }

    }

    public List<PatientDisPatchDetails> CreateDespatchMode()
    {

        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        PatientDisPatchDetails PDPD;
        try
        {
            foreach (ListItem li in chkDespatchMode.Items)
            {
                if (li.Selected == true)
                {
                    PDPD = new PatientDisPatchDetails();
                    PDPD.DispatchType = "M";
                    PDPD.DispatchValue = li.Value;
                    lstDispatchDetails.Add(PDPD);
                }
            }
            foreach (ListItem li in chkDisPatchType.Items)
            {
                if (li.Selected == true)
                {
                    PDPD = new PatientDisPatchDetails();
                    PDPD.DispatchType = "T";
                    PDPD.DispatchValue = li.Value;
                    lstDispatchDetails.Add(PDPD);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
        return lstDispatchDetails;

    }

    public List<PatientDisPatchDetails> CreateDespatchMode1()
    {

        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        try
        {
            PatientDisPatchDetails PDPD;
            foreach (ListItem li in chkDespatchMode1.Items)
            {
                if (li.Selected == true)
                {
                    PDPD = new PatientDisPatchDetails();
                    PDPD.DispatchType = "M";
                    PDPD.DispatchValue = li.Value;
                    lstDispatchDetails.Add(PDPD);
                }
            }
            foreach (ListItem li in ChckdespatchType.Items)
            {
                if (li.Selected == true)
                {
                    PDPD = new PatientDisPatchDetails();
                    PDPD.DispatchType = "T";
                    PDPD.DispatchValue = li.Value;
                    lstDispatchDetails.Add(PDPD);
                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
        return lstDispatchDetails;

    }

    public void SetPatientDispatchDetails(long vid, long pid, int orgid)
    {
        txtPatientMail.Text = "";
        txtPatientMobileNo.Text = string.Empty;
        txtcomments.Text = "";
        txtcoruriersname.Text = "";

        foreach (ListItem li in chkDespatchMode1.Items)
        {
            li.Selected = false;
        }
        foreach (ListItem li in ChckdespatchType.Items)
        {
            li.Selected = false;
        }
        try
        {
            long returncode = -1;
            List<ActionManagerType> lstPatientActiontype = new List<ActionManagerType>();
            List<PatientDisPatchDetails> lstpatientDespatchDetails = new List<PatientDisPatchDetails>();
            List<MetaData> lstpatientmetadataOutput = new List<MetaData>();
            List<PatientVisit> lstPatientVisitDespatch = new List<PatientVisit>();
            Patient_BL objPatientBL = new Patient_BL();
            returncode = objPatientBL.GetPatientDispatchDetails(vid, pid, orgid, out lstPatientActiontype, out lstpatientDespatchDetails, out lstpatientmetadataOutput, out lstPatientVisitDespatch);
            if (lstPatientActiontype.Count > 0)
            {

                foreach (ActionManagerType M in lstPatientActiontype)
                {
                    foreach (ListItem li in chkDespatchMode1.Items)




                    //  ArrayList values = StringToArrayList(sValues);    
                    {
                        if (Convert.ToString(M.ActionTypeID) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            if (lstpatientDespatchDetails.Count > 0)
            {

                foreach (PatientDisPatchDetails M in lstpatientDespatchDetails)
                {
                    foreach (ListItem li in chkDespatchMode1.Items)
                    {
                        if (Convert.ToString(M.DispatchType) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }
            if (lstpatientmetadataOutput.Count > 0)
            {
                foreach (MetaData T in lstpatientmetadataOutput)
                {
                    foreach (ListItem li in ChckdespatchType.Items)
                    {
                        if (Convert.ToString(T.Code) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }
                    }
                }
            }

            if (lstpatientDespatchDetails.Count > 0)
            {

                //  ArrayList values = StringToArrayList(sValues);    
                foreach (PatientDisPatchDetails M in lstpatientDespatchDetails)
                {
                    foreach (ListItem li in ChckdespatchType.Items)
                    {
                        if (Convert.ToString(M.DispatchType) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            foreach (ListItem li in chkDespatchMode1.Items)
            {
                // if (li.Selected == true)
                //{
                if (Convert.ToString(li.Text) == "Email")
                {

                    if (lstpatientDespatchDetails[0].PatientEmailID != "" && lstpatientDespatchDetails[0].IsCreditBill == "N")
                    {
                        txtPatientMail.Text = lstpatientDespatchDetails[0].PatientEmailID;

                    }
                    if (lstpatientDespatchDetails[0].ClientEmailID != "" && lstpatientDespatchDetails[0].IsCreditBill == "Y")
                    {
                        txtPatientMail.Text = lstpatientDespatchDetails[0].ClientEmailID;

                    }

                }
                else if (Convert.ToString(li.Text) == "Sms")
                {

                    if (lstpatientDespatchDetails[0].PatientMobileNum != "" && lstpatientDespatchDetails[0].IsCreditBill == "N")
                    {
                        txtPatientMobileNo.Text = lstpatientDespatchDetails[0].PatientMobileNum;
                    }
                    if (lstpatientDespatchDetails[0].ClientMobileNum != "" && lstpatientDespatchDetails[0].IsCreditBill == "Y")
                    {
                        txtPatientMobileNo.Text = lstpatientDespatchDetails[0].ClientMobileNum;
                    }
                }
                // }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SetPatientDispatchDetails", ex);
        }
    }

    public void dispatchmail()
    {
        string str1 = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_40 == null ? "Report dispatched successfully" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_40;
        string str2 = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_41 == null ? "Unable to dispatch the report. please contact system administrator" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_41;
        string str3 = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_42 == null ? "Unable to get the report. please contact system administrator" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_42;

        long returnCode = -1;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        bool isByteAvailable = false;
        try
        {
            pVisitID = Convert.ToInt64(hdnVID.Value);
            byte[] results = new byte[byte.MaxValue];
            if (hdnSelectedMailButton.Value == "dispatch")
            {
                string strInvStatus = InvStatus.Approved;
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add(strInvStatus);
                List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();

                ReportUtil objReportUtil = new ReportUtil();
                returnCode = objReportUtil.GetReports(pVisitID, OrgID, RoleID, ILocationID, lstInvStatus, LID, true, "printreport", "", -1, "","", out lstReportSnapshot,LanguageCode);
                if (lstReportSnapshot.Count > 0)
                {
                    results = lstReportSnapshot[0].Content;
                    isByteAvailable = true;
                }
            }
            else
            {
                string deviceInfo = null;
                string format = "PDF";
                string encoding = String.Empty;
                string mimeType = String.Empty;
                string extension = String.Empty;
                string[] streamIDs = null;
                Microsoft.Reporting.WebForms.Warning[] warnings = null;
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                isByteAvailable = true;
            }
            if (isByteAvailable)
            {
                sourceStream = new MemoryStream(results);

                List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
                GateWay gateWay = new GateWay();
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
                    AuditReportAction(AuditManager.AuditTypeCode.Email, txtMailAddress.Text);
                    // modalpopupsendemail.Hide();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ValidationWindow(" + str1.Trim() + "," + AlertType.Trim() + ");", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ValidationWindow(" + str2.Trim() + "," + AlertType.Trim() + ");", true);
                    // modalpopupsendemail.Show();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReport", "ValidationWindow(" + str3.Trim() + "," + AlertType.Trim() + ");", true);
            }

        }
        catch (Exception ex)
        {
            //ErrorDisplay2.ShowError = true;
            // ErrorDisplay2.Status = "Error while sending mail" + ex.Message;
            //modalpopupsendemail.Show();
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }


    }

    public List<MailAttachment> GetMailAttachmentfile()
    {
        long returnCode = -1;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
        bool isByteAvailable = false;
        try
        {
            targetStream = new MemoryStream();
            pVisitID = Convert.ToInt64(hdnVID.Value);
            byte[] results = new byte[byte.MaxValue];
            string strInvStatus = InvStatus.Approved;
            List<string> lstInvStatus = new List<string>();
            lstInvStatus.Add(strInvStatus);
            List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();

            ReportUtil objReportUtil = new ReportUtil();
            returnCode = objReportUtil.GetReports(pVisitID, OrgID, RoleID, ILocationID, lstInvStatus, LID, true, "printreport", "", -1, "","", out lstReportSnapshot,LanguageCode);
            if (lstReportSnapshot.Count > 0)
            {
                // results = File.ReadAllBytes("E:\\Report1.pdf");
                results = lstReportSnapshot[0].Content;
                isByteAvailable = true;
            }


            if (isByteAvailable)
            {
                List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();
                returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(Convert.ToInt64(hdnVID.Value), out pCount, out patientNumber, out lstOrderderd);
                sourceStream = new MemoryStream(results);
                //PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                //PdfSecuritySettings securitySettings = document.SecuritySettings;
                //securitySettings.UserPassword = patientNumber;
                //securitySettings.OwnerPassword = patientNumber;
                //securitySettings.PermitAccessibilityExtractContent = false;
                //securitySettings.PermitAnnotations = false;
                //securitySettings.PermitAssembleDocument = false;
                //securitySettings.PermitExtractContent = false;
                //securitySettings.PermitFormsFill = false;
                //securitySettings.PermitFullQualityPrint = true;
                //securitySettings.PermitModifyDocument = false;
                //securitySettings.PermitPrint = true;
                //document.Save(targetStream, false);
                targetStream = new MemoryStream(lstReportSnapshot[0].Content);
                MailAttachment objMailAttachment = new MailAttachment();
                //objMailAttachment.ContentStream = targetStream;
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "Report_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
            }
            else
            {
                string str2 = Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_41 == null ? "Unable to dispatch the report. please contact system administrator" : Resources.Investigation_AppMsg.Investigation_InvestigationReportPrint_aspx_41;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReportStatus", "ValidationWindow(" + str2.Trim() + "," + AlertType.Trim() + ")", true);

            }


        }
        catch (Exception ex)
        {
            // ErrorDisplay2.ShowError = true;
            //ErrorDisplay2.Status = "Error while attachment mail" + ex.Message;
            //modalpopupsendemail.Show();
        }

        return lstMailAttachment;


    }

    public void LoadPriority()
    {
        try
        {
            long returncode = -1;
            string domains = "Preference";
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


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
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
                }

            }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
            //edisp.Visible = true;

        }

    }

    public void SetPrintLabelPatientDispatchDetails(long vid, long pid, int orgid)
    {


        foreach (ListItem li in chkDespatchModeLabel.Items)
        {
            li.Selected = false;
        }
        foreach (ListItem li in chkDispatchTypeLabel.Items)
        {
            li.Selected = false;
        }
        try
        {
            long returncode = -1;
            List<ActionManagerType> lstPatientActiontype = new List<ActionManagerType>();
            List<MetaData> lstpatientmetadataOutput = new List<MetaData>();
            List<PatientDisPatchDetails> lstpatientDespatchDetails = new List<PatientDisPatchDetails>();
            List<PatientVisit> lstPatientVisitDespatch = new List<PatientVisit>();
            Patient_BL objPatientBL = new Patient_BL();
            returncode = objPatientBL.GetPatientDispatchDetails(vid, pid, orgid, out lstPatientActiontype, out lstpatientDespatchDetails, out lstpatientmetadataOutput, out lstPatientVisitDespatch);
            if (lstPatientActiontype.Count > 0)
            {

                foreach (ActionManagerType M in lstPatientActiontype)
                {
                    foreach (ListItem li in chkDespatchModeLabel.Items)
                    {
                        if (Convert.ToString(M.ActionTypeID) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            if (lstPatientActiontype.Count > 0)
            {

                //  ArrayList values = StringToArrayList(sValues);    
                foreach (ActionManagerType M in lstPatientActiontype)
                {
                    foreach (ListItem li in chkDispatchTypeLabel.Items)
                    {
                        if (Convert.ToString(M.ActionTypeID) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            if (lstpatientDespatchDetails.Count > 0)
            {

                foreach (PatientDisPatchDetails M in lstpatientDespatchDetails)
                {
                    foreach (ListItem li in chkDespatchModeLabel.Items)
                    {
                        if (Convert.ToString(M.DispatchType) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            if (lstpatientDespatchDetails.Count > 0)
            {

                //  ArrayList values = StringToArrayList(sValues);    
                foreach (PatientDisPatchDetails M in lstpatientDespatchDetails)
                {
                    foreach (ListItem li in chkDispatchTypeLabel.Items)
                    {
                        if (Convert.ToString(M.DispatchValue) == Convert.ToString(li.Value))
                        {
                            li.Selected = true;
                            break;
                        }

                    }
                }

            }

            foreach (ListItem li in chkDespatchMode1.Items)
            {
                // if (li.Selected == true)
                //{
                if (Convert.ToString(li.Text) == "Email")
                {

                    if (lstpatientDespatchDetails[0].PatientEmailID != "" && lstpatientDespatchDetails[0].IsCreditBill == "N")
                    {
                        txtPatientMail.Text = lstpatientDespatchDetails[0].PatientEmailID;

                    }
                    if (lstpatientDespatchDetails[0].ClientEmailID != "" && lstpatientDespatchDetails[0].IsCreditBill == "Y")
                    {
                        txtPatientMail.Text = lstpatientDespatchDetails[0].ClientEmailID;

                    }

                }
                else if (Convert.ToString(li.Text) == "Sms")
                {

                    if (lstpatientDespatchDetails[0].PatientMobileNum != "" && lstpatientDespatchDetails[0].IsCreditBill == "N")
                    {
                        txtPatientMobileNo.Text = lstpatientDespatchDetails[0].PatientMobileNum;
                    }
                    if (lstpatientDespatchDetails[0].ClientMobileNum != "" && lstpatientDespatchDetails[0].IsCreditBill == "Y")
                    {
                        txtPatientMobileNo.Text = lstpatientDespatchDetails[0].ClientMobileNum;
                    }
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SetPrintLabelPatientDispatchDetails", ex);
        }
    }

    public void ShowReport1(string reportPath, long visitID, string templateID, long InvID, string DispatchType)
    {
        try
        {
            // ModalPopupLabelPrintExtender1.Show();
            rReportViewer2.Visible = true;
            hdnShowLabelReport.Value = "true";
            rReportViewer2.Reset();
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            if (rdLabel1.Checked == true)
            {
                reportPath = GetConfigValues("LabelPrinting1", OrgID);
            }
            else if (rdLabel2.Checked == true)
            {
                reportPath = GetConfigValues("LabelPrinting2", OrgID);
            }
            //else if (rdLabel3.Checked == true)
            //{
            //    reportPath = GetConfigValues("LabelPrinting3", OrgID);
            //}
            //else if (rdDispatchSticker.Checked == true)
            //{
            //    reportPath = GetConfigValues("DispatchPrintLabel4", OrgID);  
            //}
            //else if (rdRadiology.Checked == true)
            //{
            //    reportPath = GetConfigValues("RadiologyorSonoPrintLabel5", OrgID);
            //}
            //else if (rdHealthCheckUp.Checked == true)
            //{
            //    reportPath = GetConfigValues("HealthCheckUpPrintLabel6", OrgID);
            //}
            //else if (rdHomeDispatch.Checked == true)
            //{
            //    reportPath = GetConfigValues("HomeDispatchPrintLabel7", OrgID);
            //}
            else if (rdDoctorDispatch.Checked == true)
            {
                reportPath = GetConfigValues("DoctorDispatchPrintLabel8", OrgID);
            }
            //else if (rdECGorStress.Checked == true)
            //{
            //    reportPath = GetConfigValues("EcgorStressPrintLabel9", OrgID);
            //}
            else
            {
                reportPath = GetConfigValues("MainPrintLabel", OrgID);
            }


            //  reportPath = GetConfigValues("MainPrintLabel", OrgID);
            //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "alert('hi');", true);
            rReportViewer2.Attributes.Add("style", "width:100%; height:400px");
            rReportViewer2.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer2.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer2.ServerReport.ReportPath = reportPath;
            rReportViewer2.ShowParameterPrompts = false;

            rReportViewer2.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[3];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            //reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            //reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            //reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("DispatchType", DispatchType);
            rReportViewer2.ServerReport.SetParameters(reportParameterList);
            // ModalPopupLabelPrintExtender1.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }

    #endregion
}


