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
using Attune.Solution.DAL;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.BusinessEntities;

public partial class Investigation_LabReport : BasePage
{
    List<Patient> lstPatient = new List<Patient>();
    public string lblmessage = Resources.ClientSideDisplayTexts.Investigation_InvestigationReport_aspx_cs_lblmessage;
    public Investigation_LabReport()
        : base("Investigation\\LabReport.aspx")
    {
    }
    ActionManager ObjActionManager;

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }

    int currentPageNo = 1;
    int _pageSize = 10;
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
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    DateTime dTIME;
    string DispatchType = string.Empty;
    string strScript = string.Empty;
    string FrmDate;
    string ToDate;
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    int chkcount = 0;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    String Outsource = string.Empty;
    int GridCount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        FrmDate = OrgDateTimeZone;
        ToDate = OrgDateTimeZone;
        try
        {
            string LoginRoleName = string.Empty;
            LoginRoleName = RoleName;
            hdnloginRoleName.Value = LoginRoleName;
            if (LoginRoleName == "Client")
            {
                LoadClientRole();
            }
            ObjInv = new Investigation_BL(base.ContextInfo);
            ObjActionManager = new ActionManager(base.ContextInfo);
            AutoCompleteProduct.ContextKey = "NameOnly";
            AutoCompleteExtender1.ContextKey = "0^0";
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderReferringHospital.ContextKey = OrgID.ToString();
            AutoCompleteExtenderTestName.ContextKey = OrgID.ToString();
            AutoCompleteExtender2.ContextKey = "zone" + "~" + "-1";

            tblpage.Style.Add("display", "none");
            trhide1.Style.Add("display", "none");
            trhide3.Style.Add("display", "none");
            //Div5.Style.Add("display", "none");
            //Div6.Style.Add("display", "block");

            string BillPrintHide = GetConfigValue("BillPrint", OrgID);
            hndBillprintHide.Value = BillPrintHide;
            hdnOrgID1.Value = Convert.ToString(OrgID);
            hdnLocationID.Value = Convert.ToString(ILocationID);
            hdnTrustedOrg.Value = IsTrustedOrg;
            //comment by venkatesh
            //if ((isCorporateOrg == "") || (isCorporateOrg == "N"))
            //{
            //    txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //}





            if (!IsPostBack)
            {
                hdnrolename.Value = RoleName;
                LoadMetaData();
                trFooter.Style.Add("display", "none");
                returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
                if (Request.QueryString["ISserviceLoc"] == "Y")
                {
                    lAddress = lAddress.FindAll(p => p.AddressID == ILocationID);
                    ddlocation.DataSource = lAddress;
                    ddlocation.DataTextField = "City";
                    ddlocation.DataValueField = "AddressID";
                    ddlocation.DataBind();
                    ddstatus.Items.Clear();
                    ListItem App_item = new ListItem();
                    App_item.Text = "Approved";
                    App_item.Value = "Approve";
                    ddstatus.Items.Add(App_item);
                }
                else
                {
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
                        ddlocation.Items.Insert(0, "--Select--");
                        ddlocation.Items[0].Value = "-1";
                    }
                }
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
                    drpdepartment.Items.Insert(0, "---Select---");
                    drpdepartment.Items[0].Value = "0";
                }
                else
                {
                    drpdepartment.Items.Insert(0, "---Select---");
                    drpdepartment.Items[0].Value = "0";
                }
                List<URNTypes> objURNTypes = new List<URNTypes>();
                List<URNof> objURNof = new List<URNof>();
                Patient_BL pBL = new Patient_BL(base.ContextInfo);
                if ((RoleName == RoleHelper.CustomerCare) || (RoleName == RoleHelper.DispatchController))
                {
                    ddstatus.Items.Clear();
                    ListItem item2 = new ListItem();
                    item2.Text = "---Select---";
                    item2.Value = "---Select---";
                    item2.Selected = true;
                    ListItem item = new ListItem();
                    item.Text = "Approved";
                    item.Value = "Approve";
                    //item.Selected = true;
                    ddstatus.Items.Add(item);
                    ListItem item1 = new ListItem();
                    item1.Text = "Printed";
                    item1.Value = "Print";
                    //item.Selected = true;
                    ddstatus.Items.Add(item1);
                    ListItem item3 = new ListItem();
                    item3.Text = "Partial Printed";
                    item3.Value = "Partial Print";
                    //item.Selected = true;
                    ddstatus.Items.Add(item3);
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
            //ddlocation
            if (RoleName == RoleHelper.Physician)
            {
                if (!IsPostBack)
                {
                    PatientGetReports(currentPageNo, PageSize);
                }
                //Header2.Visible = false;
                AdminHeader.Visible = false;
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
                AdminHeader.Visible = false;
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
                Header1.Visible = false;
                //AdminHeader1.Visible = false;
            }
            lblMessage1.Text = string.Empty;
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
            if (!IsPostBack)

                if ((IntegrationName != string.Empty))
                {
                    if (!IsPostBack)
                    {
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
                                bindCheckBox();
                            }
                            else
                            {
                                lblMessage1.Visible = true;

                                lblMessage1.Text = lblmessage;
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


            DateTime OrgDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            hdnFirstDayYear.Value = "01-01-" + OrgDateTime.Year;
            hdnLastDayYear.Value = "31-12-" + OrgDateTime.Year;

            #region lastmonth
            DateTime dtlm = OrgDateTime.AddMonths(-1);
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
            }
            IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
            if (IsNeedExternalVisitIdWaterMark == "Y")
            {
                defaultText = "Lab Number";
                txtVisitNo.MaxLength = 9;
            }
            else
            {
                defaultText = "Visit Number";
            }
            txtwatermark();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while page Loading", ex);
        }

    }
    public void LoadMetaData()
    {
        try
        {
            long returncode1 = -1;
            string domains1 = "CustomPeriodRange";
            string[] Tempdata1 = domains1.Split(',');
            string LangCode1 = "en-GB";
            List<MetaData> lstmetadataInput1 = new List<MetaData>();
            List<MetaData> lstmetadataOutput1 = new List<MetaData>();

            MetaData objMeta1;

            for (int i = 0; i < Tempdata1.Length; i++)
            {
                objMeta1 = new MetaData();
                objMeta1.Domain = Tempdata1[i];
                lstmetadataInput1.Add(objMeta1);

            }
            returncode1 = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput1, OrgID, LangCode1, out lstmetadataOutput1);
            if (lstmetadataOutput1.Count > 0)
            {
                ddlRegisterDate.DataSource = lstmetadataOutput1;
                ddlRegisterDate.DataTextField = "DisplayText";
                ddlRegisterDate.DataValueField = "Code";
                ddlRegisterDate.DataBind();
                ddlRegisterDate.Items.Insert(0, "--Select--");
                ddlRegisterDate.Items[0].Value = "-1";
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);


        }

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
    public void PatientGetReports(int currentPageNo, int PageSize)
    {
        try
        {
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }

            hdnShowReport.Value = "false";
            hdnHideReportTemplate.Value = "0";
            rptMdlPopup.Hide();

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
            long ZoneID = 0;
            //FrmDate = ucDateCtrl.GetFromDate().ToString();
            //ToDate = ucDateCtrl.GetToDate().ToString();
            lnkshwrpt.Style.Add("display", "none");

            chdept.Style.Add("display", "none");
            long clientid = -1;
            if (hdnClientID.Value != "" && hdnClientID.Value != null)
            {
                string CID = hdnClientID.Value.Split('|')[0];
                clientid = Convert.ToInt64(CID);
                //clientid = Convert.ToInt64(hdnClientID.Value);
                if (hdnpreviousdue.Value != "")
                {
                    lblpreviousdue.Text = "Client has an outstanding of:  <b> " + hdnpreviousdue.Value + "</b>";
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

            if (status == "---Select---")
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
                        && (txtClientName.Text == "") && (ddstatus.Text == "---Select---")
                        && (ddlocation.Text == "-1") && (drpdepartment.Text == "0") &&
                        (txtTestName.Text == "") && (txtReferringHospital.Text == "") && (txtInternalExternalPhysician.Text == "")
                        && (txtzone.Text == ""))
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
                            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            DateTime wkStDt = DateTime.MinValue;
                            wkStDt = dt.AddDays(-2);
                            fromDate = wkStDt.ToString("dd-MM-yyyy 00:00:00");
                            ToDate = OrgDateTimeZone;
                        }
                    }

                    else
                    {
                        fromDate = tempfrom;
                        ToDate = OrgDateTimeZone;
                    }
                }
            }

            int deptId = 0;

            if (drpdepartment.SelectedValue == "" || drpdepartment.SelectedValue == null)
            {
                deptId = 0;
            }
            else
            {
                deptId = Convert.ToInt32(drpdepartment.SelectedValue);
            }

            if (hdnPhysicianValue.Value != "0")
            {
                ReferringPhyID = Convert.ToInt32(hdnPhysicianValue.Value.Split('^')[1]);
            }
            ReferringorgID = Convert.ToInt64(hdfReferalHospitalID.Value);

            if (hdntxtzoneID.Value != "0")
            {
                ZoneID = Convert.ToInt64(hdntxtzoneID.Value);
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
            if (RoleName == RoleHelper.Physician)
            {
                status = "APPROVED";
            }
            if (RoleName == RoleHelper.Patient)
            {
                status = "APPROVED";
            }

            long LocationID = -1;
            int VisitType = 0;
            int department = 0;
            long TestID = -1;
            Int64.TryParse(ddlocation.SelectedValue, out LocationID);
            Int32.TryParse(ddVisitType.SelectedValue, out VisitType);
            Int32.TryParse(drpdepartment.SelectedValue, out department);
            Int64.TryParse(hdnTestID.Value, out TestID);

            int patientID = 0;
            if (hdnPatientID.Value != "" && txtName.Text.ToString() != "")
            {
                Int32.TryParse(hdnPatientID.Value, out patientID);
            }

            returnCode = new PatientVisit_BL(base.ContextInfo).GetLabReportForInvestigation(visitNo, patientID, txtName.Text.ToString(), txtPatientNo.Text.ToString(), txtMobile.Text.ToString(), fromDate, ToDate,
                clientid, ZoneID, LocationID, ReferringPhyID, ReferringorgID, status, department, TestID, hdnTestType.Value.ToString(), OrgID, VisitType,
                out lstPatientVisit, currentPageNo, PageSize, out totalRows);
            grdResult1.DataSource = null;
            grdResult1.DataBind();
            GridCount = 0;
            if (lstPatientVisit.Count > 1)
            {
                GridCount = 1;
            }
            grdResult1.DataSource = lstPatientVisit;
            grdResult1.DataBind();


            if (lstPatientVisit.Count > 0)
            {

                //grdResult.DataSource = null;
                //grdResult.DataBind();
                //grdResult.DataSource = lstPatientVisit;
                //grdResult.DataBind();
                tblpage.Attributes.Add("style", "display:block;");
                trFooter.Attributes.Add("style", "display:block;");
                tblgrdview.Style.Add("display", "block");
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
                trFooter.Attributes.Add("style", "display:none;");
                tblpage.Attributes.Add("style", "display:none;");
                divFooterNav.Attributes.Add("style", "display:none;");
                trSelectVisit.Visible = false;
                lblMessage.Text = "";
                lblMessage.Text = lblmessage;
            }
            hdnHideDetails.Value = "0";
            // hdnClientID.Value = "-1";



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
    public void LoadClientRole()
    {
        try
        {
            LinkButton lnkRoleChanges = (LinkButton)Header2.FindControl("lnkRoleChange");
            menu.Style.Add("display", "none");
            lnkRoleChanges.Style.Add("display", "none");
            trClient.Style.Add("display", "none");
            showmenu.Style.Add("display", "none");
            trDepartment.Style.Add("display", "none");
            tdlblLabNo.Style.Add("display", "none");
            tdtxtLabNo.Style.Add("display", "none");
            tdlblddVisittype.Style.Add("display", "none");
            tdrichcombobox.Style.Add("display", "none");
            tdlblRefOrg.Style.Add("display", "none");
            tdtxtReferringHospital.Style.Add("display", "none");

        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        hdnonoroff.Value = "Y";
        PatientGetReports(currentPageNo, PageSize);
        hdnDispatch.Value = "";
        hdnPartial.Value = "";
        hdnPending.Value = "";

    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            //  grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

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
    protected void lnkShowRecord_Click(object sender, EventArgs e)
    {
    }
    protected void btnPayNow_Click(object sender, EventArgs e)
    {
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
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
        int PatOrgID = 0;
        Int32.TryParse(patOrgID.Value, out PatOrgID);

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
                string deptid = String.Empty;

                if (drpdepartment.SelectedValue == "" || drpdepartment.SelectedValue == null)
                {
                    deptid = "";
                }
                else
                {
                    deptid = drpdepartment.SelectedItem.Value;
                }

                //string deptid = Convert.ToInt16(drpdepartment.SelectedItem.Value).ToString();

                List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();
                long PVisitID = Convert.ToInt64(hdnVID.Value);
                returnCode = new Investigation_BL(base.ContextInfo).GetPatientDueStatus("", 0, PVisitID, OrgID, 0, 0, out DueAmount);
                if (DueAmount.ToString() != "" && DueAmount.ToString() != "0.00" && DueAmount.ToString() != "-1")
                {
                    hdnDue.Value = DueAmount.ToString();
                    hdOrgID.Value = PatOrgID.ToString();// OrgID.ToString();
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "CheckDue();", true);
                btnPrint.Enabled = false;
                btnSendMail.Enabled = false;
                if (DueAmount.ToString() != "" && DueAmount.ToString() != "0.00" && DueAmount.ToString() != "-1" && DueAmount.ToString() != "0")
                {
                    btnPrint.Enabled = false;
                    btnSendMail.Enabled = false;
                }
                if (hdnClientID.Value != "1")
                {
                    btnPrint.Enabled = false;
                    btnSendMail.Enabled = false;
                }

                //if (ddlVisitActionName.SelectedItem.Text == "Show Report")
                if (ddlVisitActionName.SelectedValue == "Show_Report_InvestigationReport")
                {
                    frameReportPreview.Attributes.Clear();
                    long VisitID = Convert.ToInt64(hdnVID.Value);
                    uctPatientDetail.LoadPatientDetails(VisitID, OrgID, "");     //change clientSide

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
                            if (deptid == "0" || deptid == "")
                            {
                                objPatientBL.GetReportTemplate(VisitID, PatOrgID, LanguageCode, out lstReport, out lstReportName, out lstDpts);
                            }
                            else
                            {
                                objPatientBL.GetReportTemplateByDeptID(VisitID, PatOrgID, out lstReport, out lstReportName, out lstDpts, deptid);
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
                            if (deptid == "0" || deptid == "")
                            {
                                objPatientBL.GetReportTemplate(VisitID, PatOrgID, LanguageCode, out lstReport, out lstReportName, out lstDpts);
                            }
                            else
                            {
                                objPatientBL.GetReportTemplateByDeptID(VisitID, PatOrgID, out lstReport, out lstReportName, out lstDpts, deptid);
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
                        PC.ID = Convert.ToInt64(ILocationID);
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
                            string AlertMessg = "Resent Report Generated Successfully";
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                        }
                    }
                }
                else if (ddlVisitActionName.SelectedValue == "Show_PDF")
                {
                    long pVisitID = Convert.ToInt64(hdnVID.Value);

                    uctPatientDetail1.LoadPatientDetails(pVisitID, OrgID, "");
                    string invStatus = InvStatus.Pending.ToLower() + "," + InvStatus.Completed.ToLower() + "," + InvStatus.Validate.ToLower() + "," + InvStatus.Approved.ToLower();
                    Report_BL objReportBL = new Report_BL(base.ContextInfo);
                    List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();
                    objReportBL.GetPath(OrgID, pVisitID, "", out ReportPath);

                    string filePath = string.Empty;
                    if (ReportPath.Count() > 0)
                    {
                        filePath = ReportPath[0].ReportPath;
                    }
                    frameReportPreview.Attributes["src"] = "../Patient/ReportPdf.aspx?pdf=" + filePath + "&type=" + hdnPDFType.Value.ToString();

                    foreach (RepeaterItem gvRow in grdResult1.Items)
                    {
                        if (gvRow.ItemType == ListItemType.Item)
                        {
                            RadioButton rdsel = (RadioButton)gvRow.FindControl("rdSel");
                            if (rdsel.Checked == true)
                            {
                                TextBox PatID = (TextBox)gvRow.FindControl("txtPatientId");


                                long patientID = Convert.ToInt64(PatID.Text.Trim().ToString());
                                LoadReportDetails(OrgID, ILocationID, patientID);
                            }
                        }
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
                    mpReportPreview.Show();
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
            CLogger.LogError("Error in InvestigationReport", ex);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SetPrintLabelPatientDispatchDetails", ex);
        }
    }
    protected void grdResultDate_ItemCommand(object source, DataListCommandEventArgs e)
    {

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
    protected void grdResultTemp_ItemCommand(object source, DataListCommandEventArgs e)
    {

        try
        {
            int PatOrgID = 0;
            Int32.TryParse(patOrgID.Value, out PatOrgID);
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

                if (PatOrgID != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, PatOrgID);

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
                btnSendMail.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
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
                 InvName.ReportTemplateName,
                 InvName.TemplateID
             } into grp
               where grp.ElementAt(0).ReportTemplateName == eInvReportMaster.ReportTemplateName
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
                                InvName.PrintCount,
                                InvName.ReportTemplateName,
                                InvName.PkgName
                            }
                        into grp
                        where grp.ElementAt(0).ReportTemplateName == eInvReportMaster.ReportTemplateName
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
                else if (eInvReportMaster.TemplateName == "T62")
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
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
    protected void grdResult1_ItemDataBound(Object Sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            PatientVisit pv = (PatientVisit)e.Item.DataItem;
            HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("Tr1"); 
            if (pv.UserName == "Y")
            {
                tr.Style.Add("background-color", "Orange"); 
            }
            if (pv.PatientHistoryID != 0)
            {
                tr.Style.Add("background-color", "IndianRed"); 
            }
                strScript = "SelectVisit('" + ((RadioButton)e.Item.FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId +
                "','" + pv.PatientID + "','" + pv.OrgID + "','" + (String.IsNullOrEmpty(pv.EMail) ? "" : pv.EMail) + "','" + pv.CreditLimit +
                "','" + pv.PriorityName + "','" + pv.PreAuthAmount + "','" + pv.Remarks + "','" + pv.DispatchType + "','" + pv.DispatchValue + "','" +
                pv.IsAllMedical + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');";
            ((RadioButton)e.Item.FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Item.FindControl("rdSel")).Attributes.Add("onclick", strScript);

            long lngVisitID = pv.PatientVisitId;
            string label = "../admin/LabelPrint.aspx?visitId=" + lngVisitID + "&orgId=" + OrgID + "&IsPopup=Y&categoryCode=LabelPrint";
            string BillPrint = "../Reception/ViewPrintPage.aspx?vid=" + lngVisitID + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=&bid=" + pv.PatientHistoryID + " &pdp=0&chkheader=N&Split=N&ViewSplitCheckbox=Y&quickbill=Y";
            HtmlImage imgPrintReport = (HtmlImage)e.Item.FindControl("imgPrintReport");
            imgPrintReport.Attributes.Add("onclick", "PrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
            btnPrint.Attributes.Add("onclick", "onPrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
            RadioButton rdsel = (RadioButton)e.Item.FindControl("rdSel");

            string str = string.IsNullOrEmpty(pv.EMail) ? "": pv.EMail;


            try
            {
                if (GridCount == 0)
                {
                    long VisitID = pv.PatientVisitId;
                    hdnVID.Value = Convert.ToString(pv.PatientVisitId);


                }
            }
            catch (Exception Ex)
            {
                CLogger.LogError("Error in InvestigationReport.aspx", Ex);
            }
            string[] splityears = pv.PatientAge.Split(' ');
            string[] splityears1 = pv.PatientAge.Split('/');
            Label lblAge = (Label)e.Item.FindControl("lblAge");
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
    protected void btnPrint_Click(object sender, EventArgs e)
    {

        try
        {
            AuditReportAction(AuditManager.AuditTypeCode.Print, string.Empty);
        }

        catch (Exception s)
        {
            CLogger.LogError("Error while Saving AuditTransaction in Investigation Report ", s);
        }

    }
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
            else if (rdDoctorDispatch.Checked == true)
            {
                reportPath = GetConfigValues("DoctorDispatchPrintLabel8", OrgID);
            }
            else
            {
                reportPath = GetConfigValues("MainPrintLabel", OrgID);
            }


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

                ScriptManager.RegisterStartupScript(this, this.GetType(), "DispatchReportStatus", "alert('Unable to dispatch the report. please contact system administrator')", true);

            }


        }
        catch (Exception ex)
        {
            //modalpopupsendemail.Show();
        }

        return lstMailAttachment;


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
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
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
                //FckEdit1.LoadPatientDemography(OrgID, pVisitID);
                //FckEdit1.loadText("Notes Report");
                //FckEdit1.loadText(OrgID, Convert.ToInt64(pVisitID), Convert.ToInt32(reportID), Convert.ToInt64(investigatgionID));
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
            string AlertMessg = "Prioritised Report Generated Successfully";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Dispatchstatus", "ShowAlertMsg1('" + sPath + "');", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generate Prioritised Report", ex);
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









}
