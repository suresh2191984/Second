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


public partial class Investigation_ReportDispatch : BasePage
{
    List<Patient> lstPatient = new List<Patient>();
    public string lblmessage = Resources.ClientSideDisplayTexts.Investigation_InvestigationReport_aspx_cs_lblmessage;
    public Investigation_ReportDispatch()
        : base("Investigation_ReportDispatch_aspx")
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
    String Locationid = String.Empty;
    int VisitType = 0;
    string IsPrintAll = string.Empty;
    string IsColorPrint = string.Empty;
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
    string FrmDate;
    string ToDate;
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    int chkcount = 0;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string strselect = Resources.Investigation_ClientDisplay.Investigation_ReportDispatch_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_ReportDispatch_aspx_01;
    string strTotCount = Resources.Investigation_ClientDisplay.Investigation_ReportDispatch_aspx_05 == null ? "Total count : " : Resources.Investigation_ClientDisplay.Investigation_ReportDispatch_aspx_05;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            FrmDate = OrgDateTimeZone;
            ToDate = OrgDateTimeZone;
            ObjInv = new Investigation_BL(base.ContextInfo);
            ObjActionManager = new ActionManager(base.ContextInfo);
            AutoCompleteProduct.ContextKey = "NameOnly";
            AutoCompleteExtender1.ContextKey = "0^0";
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderTestName.ContextKey = OrgID.ToString();
            AutoCompleteExtender6.ContextKey = "Hub";
            AutoCompleteExtender2.ContextKey = "zone" + "~" + "-1";

            string BillPrintHide = GetConfigValue("BillPrint", OrgID);

            string TpaFilter = GetConfigValue("TPAPrint", OrgID);
            if (TpaFilter == "Y")
            {
                mTPAFilter.Style.Add("display", "block");
            }

            string sstatus = "";
            if (Request.QueryString["Fdate"] != null && Request.QueryString["Fdate"] != "")
            {
                sstatus = Request.QueryString["SStatus"].ToString();
            }

            long PatientID = 0;

            if (!IsPostBack)
            {
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
                    ddlocation.Items.Insert(0, strselect);
                    ddlocation.Items[0].Value = "-1";
                    ddlocation.SelectedValue = ILocationID.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MultiSelect", "LocationDetails();", true);
                }
                ///////////////prabakar
                lAddress = lAddress.FindAll(p => p.IsPrint == "Y");

                ddlPrintLocation.DataSource = lAddress;
                ddlPrintLocation.DataTextField = "City";
                ddlPrintLocation.DataValueField = "AddressID";
                ddlPrintLocation.DataBind();
                ddlPrintLocation.Items.Insert(0, strselect);
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
                    drpdepartment.Items.Insert(0, strselect);
                    drpdepartment.Items[0].Value = "0";
                }
                else
                {
                    drpdepartment.Items.Insert(0, strselect);
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
                    ListItem item3 = new ListItem();
                    item3.Text = "Error";
                    item3.Value = "Error";
                    //item.Selected = true;
                    ddstatus.Items.Add(item3);
                    ListItem item2 = new ListItem();
                    item2.Text = strselect;
                    item2.Value = "---Select---";
                    //ddstatus.Items.Add(item2);


                    //ddstatus.Items.Add(item2);
                }
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
                //  AdminHeader.Visible = false;
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
                // AdminHeader.Visible = false;
                lblMobile.Visible = false;
                txtMobile.Visible = false;
                lblName.Visible = false;
                txtName.Visible = false;
                tblPatient.Attributes.Add("style", "display:none;");
            }
            else
            {

            }

            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
            //txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            //txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucINPatientSearch_txtFromDate',1,1);");
            if (!IsPostBack)
            {

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
                hdnLastWeekFirst.Value = dt1.AddDays(-6 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
                hdnLastWeekLast.Value = dt1.AddDays( - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

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
                }

                LoadMetaData();
            }
            IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
            if (IsNeedExternalVisitIdWaterMark == "Y")
            {
                defaultText = "Lab Number";
            }
            else
            {
                defaultText = "Visit Number";
            }
            ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChangeLabel();", true);
            // txtwatermark();
            chhprintall.Checked = true;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while page Loading", ex);
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
            ddlLocationPrinter.Items.Insert(0, strselect);
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
    public void PatientGetReportsPrint(int currentPageNo, int PageSize)
    {
        try
        {
            long PrintLocationID = -1;
            Int64.TryParse(ddlPrintLocation.SelectedValue, out PrintLocationID);
            if (chhprintall.Checked == true)
            {
                IsPrintAll = "Y";
            }
            else
            {
                IsPrintAll = "N";
            }
            if (ChkColorPrint.Checked == true)
            {
                IsColorPrint = "Y";
            }
            else
            {
                IsColorPrint = "N";
            }
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }

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
            long ReferringorgID = 0;
            long CourierBoyId = 0;
            String ZoneID = string.Empty;
            String HubID = string.Empty;

            string pSearchType = ddlPrintType.SelectedValue;

            long clientid = -1;
            if (hdnClientID.Value != "" && hdnClientID.Value != null)
            {
                string CID = hdnClientID.Value.Split('|')[0];
                clientid = Convert.ToInt64(CID);

            }
            hdnVID.Value = string.Empty;

            string status = ddstatus.SelectedItem.Value.ToString();

            if (status == strselect)
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
             string DischargeFDate, DischargeTDate,IPOPNumber,PatientPayType,PatientStatus;
             DischargeFDate = String.Empty;
             DischargeTDate = String.Empty;
            IPOPNumber = String.Empty;
            PatientPayType = String.Empty;
            PatientStatus = String.Empty;

            if (Request.QueryString["Fdate"] != null)
            {
                fromDate = Request.QueryString["Fdate"].ToString();
                ToDate = Request.QueryString["Tdate"].ToString();
            }
            else
            {
                if (ddlRegisterDate.SelectedItem.Text != strselect)
                {
                    if (txtFromDate.Text != "" && txtToDate.Text != "")
                    {

                        fromDate = txtFromDate.Text;
                        ToDate = txtToDate.Text;

                    }
                    else if ((txtFromPeriod.Text != "" && txtToPeriod.Text != "") || (Txtfrom.Text != "" && TextTo.Text != ""))
                    {

                        if (ddlPrintType.SelectedValue == "BILL" || ddlPrintType.SelectedValue == "RPT")
                        {

                            fromDate = Txtfrom.Text;
                            ToDate = TextTo.Text;
                        }
                        else
                        {
                            fromDate = txtFromPeriod.Text;
                            ToDate = txtToPeriod.Text;
                        }
                    }
                    else if (ddlRegisterDate.SelectedItem.Value == "4")
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
                    if ((txtName.Text == "") && (txtMobile.Text == "") && (txtVisitNo.Text == "")

                        && (txtClientName.Text == "") && (ddstatus.Text == strselect)
                        && (ddlocation.Text == "-1") && (drpdepartment.Text == "0") &&
                        (txtTestName.Text == "") && (txtInternalExternalPhysician.Text == "")
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
                            fromDate = tempfrom;
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
             if (txtIPOPNumber.Text != "")
            {
                IPOPNumber = txtIPOPNumber.Text;
            }
            if (ddlPatientPaytype.SelectedItem.Text != "")
            {
                PatientPayType = ddlPatientPaytype.SelectedItem.Text;
                if (PatientPayType == strselect)
                    PatientPayType = "";
            }
            if (txtPatientStatus.Text != "")
            {
                PatientStatus = txtPatientStatus.Text;
            }
            if (hdnPhysicianValue.Value != "0")
            {
                ReferringPhyID = Convert.ToInt32(hdnPhysicianValue.Value.Split('^')[0]);
            }

            //if (hdntxtzoneID.Value != "0")
            //{
            //    ZoneID = Convert.ToInt64(hdntxtzoneID.Value);
            //}
            //if (hdntxtHubID.Value != "0")
            //{
            //    HubID = Convert.ToInt64(hdntxtHubID.Value);
            //}
            if (HdnZoneId.Value != "") { ZoneID = HdnZoneId.Value; }
            if (HdnHubId.Value != "") { HubID = HdnHubId.Value; }
            if (HdnlocationId.Value != "") { Locationid = HdnlocationId.Value; }

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



            String LocationID = String.Empty;
            if (HdnlocationId.Value != "") { LocationID = HdnlocationId.Value; }
            int VisitType = -1;
            int Priority = 0;
            int department = 0;
            long TestID = -1;


            //Int64.TryParse(ddlocation.SelectedValue, out LocationID);
            //Int32.TryParse(ddVisitType.SelectedValue, out VisitType);
            //Int32.TryParse(drpPriority.SelectedValue, out Priority);
            Int32.TryParse(drpdepartment.SelectedValue, out department);
            Int64.TryParse(hdnTestID.Value, out TestID);
            string ReportType = ddlReportType.SelectedValue;

            returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoRePrint("",
                txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType,
                out lstPatientVisit, "", LocationID, clientid, VisitType, "", status,
            Priority, department, ReferringPhyID, ReferringorgID, objTrustedOrgActions,
            visitNo, TestID, hdnTestType.Value, ZoneID, HubID, CourierBoyId,
            lstDispatchDetails, currentPageNo, PageSize, out totalRows, "", IsPrintAll, PrintLocationID, IsColorPrint,IPOPNumber,PatientPayType,PatientStatus,"",ReportType);


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
                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
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

                    if (ddstatus.SelectedValue == "Non Printed")
                    {
                        AM.Isreprint = false;
                    }
                    else
                    {
                        AM.Isreprint = true;
                    }

                    res = AM.PerformingNextStepNotification(PC, "", "");
                }
                if (totalRows == -1)
                {
                    totalRows = 0;
                }

                lbltotalrow.Visible = false;
                string AlertMessg = totalRows.ToString() + " Print Notification Queue Sent";
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                tblgrdview.Style.Add("display", "none");
                dvInvstigationDetails.Style.Add("display", "none");
                trFooter.Attributes.Add("style", "display:none;");
                tblpage.Attributes.Add("style", "display:none;");


                HdnZone.Value = HdnZone.Value;
                HdnHub.Value = HdnHub.Value;
                Hdnlocation.Value = Hdnlocation.Value;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "MultiSelect", "ReCallAll();", true);
            }
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Printed Successfully');", true);
            //tblgrdview.Style.Add("display", "none");
            //  trFooter.Attributes.Add("style", "display:none;");
            //tblpage.Attributes.Add("style", "display:none;");
            //divFooterNav.Attributes.Add("style", "display:none;");
            //trSelectVisit.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }
    public void PatientGetReports(int currentPageNo, int PageSize)
    {
        try
        {
            if (ChkColorPrint.Checked == true)
            {
                IsColorPrint = "Y";
            }
            else
            {
                IsColorPrint = "N";
            }
            ///////////
            tblgrdview.Style.Add("display", "table");
            trFooter.Attributes.Add("style", "display:table-row;");
            tblpage.Attributes.Add("style", "display:table;");
            divFooterNav.Attributes.Add("style", "display:block;");
            trSelectVisit.Visible = true;

            LoadLocationPrinter();
            long PrintLocationID = -1;
            Int64.TryParse(ddlPrintLocation.SelectedValue, out PrintLocationID);
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
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
            long ReferringorgID = 0;
            long CourierBoyId = 0;
            String ZoneID = string.Empty;
            String HubID = string.Empty;
            //FrmDate = ucDateCtrl.GetFromDate().ToString();
            //ToDate = ucDateCtrl.GetToDate().ToString();


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
            string DischargeFDate, DischargeTDate,IPOPNumber,PatientPayType,PatientStatus;
            DischargeFDate = String.Empty;
            DischargeTDate = String.Empty;
            IPOPNumber = String.Empty;
            PatientPayType = String.Empty;
            PatientStatus = string.Empty;

            if (Request.QueryString["Fdate"] != null)
            {
                fromDate = Request.QueryString["Fdate"].ToString();
                ToDate = Request.QueryString["Tdate"].ToString();
            }
            else
            {
                if (ddlRegisterDate.SelectedItem.Text != strselect)
                {
                    if (txtFromDate.Text != "" && txtToDate.Text != "")
                    {

                        fromDate = txtFromDate.Text;
                        ToDate = txtToDate.Text;

                    }
                    else if ((txtFromPeriod.Text != "" && txtToPeriod.Text != "") || (Txtfrom.Text != "" && TextTo.Text != ""))
                    {
                        if (ddlPrintType.SelectedValue == "BILL" || ddlPrintType.SelectedValue == "RPT")
                        {

                            fromDate = Txtfrom.Text;
                            ToDate = TextTo.Text;
                        }
                        else
                        {
                            fromDate = txtFromPeriod.Text;
                            ToDate = txtToPeriod.Text;
                        }
                    }
                    else if (ddlRegisterDate.SelectedItem.Value == "4")
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

                        ToDate = OrgDateTimeZone;
                    }

                }
            }
            if (txtIPOPNumber.Text != "")
            {
                IPOPNumber = txtIPOPNumber.Text;
            }
            if (ddlPatientPaytype.SelectedItem.Text != "")
            {
                PatientPayType = ddlPatientPaytype.SelectedItem.Text;
                if (PatientPayType == strselect)
                    PatientPayType = "";
            }
            if (txtPatientStatus.Text != "")
            {
                PatientStatus = txtPatientStatus.Text;
            }
            if (hdnPhysicianValue.Value != "0")
            {
                ReferringPhyID = Convert.ToInt32(hdnPhysicianValue.Value.Split('^')[1]);
            }
            // ReferringorgID = Convert.ToInt64(hdfReferalHospitalID.Value);

            //if (hdntxtzoneID.Value != "0")
            //{
            //    ZoneID = Convert.ToInt64(hdntxtzoneID.Value);
            //}
            //if (hdntxtHubID.Value != "0")
            //{
            //    HubID = Convert.ToInt64(hdntxtHubID.Value);
            //}
            if (HdnZoneId.Value != "") { ZoneID = HdnZoneId.Value; }
            if (HdnHubId.Value != "") { HubID = HdnHubId.Value; }
            if (HdnlocationId.Value != "") { Locationid = HdnlocationId.Value; }
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
            //lstDispatchDetails = CreateDespatchMode();
            if (ddlDispatchMode.SelectedItem.Value != "")
            {
                PatientDisPatchDetails obj = new PatientDisPatchDetails();
                obj.DispatchValue = ddlDispatchMode.SelectedItem.Value;

                lstDispatchDetails.Add(obj);
            }
            if ((RoleName != RoleHelper.Patient) && (RoleName != RoleHelper.Physician))
            {

                String LocationID = String.Empty;
                if (HdnlocationId.Value != "") { LocationID = HdnlocationId.Value; }
                int VisitType = -1;
                int Priority = 0;
                int department = 0;
                long TestID = -1;

                //Int64.TryParse(ddlocation.SelectedValue, out LocationID);
                //Int32.TryParse(ddVisitType.SelectedValue, out VisitType);
                // Int32.TryParse(drpPriority.SelectedValue, out Priority);
                Int32.TryParse(drpdepartment.SelectedValue, out department);
                Int64.TryParse(hdnTestID.Value, out TestID);


                string txtLabNo = string.Empty;
                string txtPatientNo = string.Empty;
                string txtWardName = string.Empty;
                string ddlPriority = string.Empty;
                string status = ddstatus.SelectedValue;
                long clientid = -1;
                string pSearchType = ddlPrintType.SelectedValue;
                Int64.TryParse(hdnClientID.Value, out clientid);
                if (clientid == 0) clientid = -1;
                string ReportType = ddlReportType.SelectedValue;
                returnCode = new PatientVisit_BL(base.ContextInfo).pGetVisitSearchDetailbyPNoRePrint(txtPatientNo,
                    txtName.Text.ToString(), txtMobile.Text, fromDate, ToDate, OrgID, lstTOD, pSearchType,
                    out lstPatientVisit, txtLabNo, LocationID, clientid, VisitType, txtWardName, status,
                Priority, department, ReferringPhyID, ReferringorgID, objTrustedOrgActions,
                visitNo, TestID, hdnTestType.Value, ZoneID, HubID, CourierBoyId,
                lstDispatchDetails, currentPageNo, PageSize, out totalRows, ddlPriority, IsPrintAll,
                PrintLocationID, IsColorPrint, IPOPNumber, PatientPayType, PatientStatus, "", ReportType);

            }
            HdnZone.Value = HdnZone.Value;
            HdnHub.Value = HdnHub.Value;
            Hdnlocation.Value = Hdnlocation.Value;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "MultiSelect", "ReCallAll();", true);

            chkAll.Checked = false;
            if (totalRows == -1)
            {

                lbltotalrow.Visible = false;
            }
            else
            {

                lbltotalrow.Text = strTotCount + totalRows.ToString() + " ";
                lbltotalrow.Visible = true;
            }


            if (ddlPrintType.SelectedValue == "RPTCHK")
            {

                btnGo.Attributes.Add("style", "display:none;");
                Button3.Attributes.Add("style", "display:block;");
                lblLocationPrinter.Visible = false;
                ddlLocationPrinter.Visible = false;

                grdResult.Visible = true;
                grdResult.DataSource = null;
                grdResult.DataBind();
                grdResult.DataSource = lstPatientVisit;

                grdResult.DataBind();
                if (lstPatientVisit.Count > 0)
                {
                    PatientGetReportsPrint(-1, -1);
                }

                hdnZonetext.Value = txtzone.Text;
                // lblZOneName.Text = hdnZonetext.Value;
                // lblPrintedAt.Text = "Printed At " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();

                if (txtFromPeriod.Text.ToString() == "")
                {

                    //lblprintingperiod.Text = fromDate + " TO " + ToDate;
                }
                else
                {

                    //lblprintingperiod.Text = txtFromPeriod.Text.ToString() + " TO " + txtToPeriod.Text.ToString();
                }
                List<PatientVisit> lstP = new List<PatientVisit>();
                lstP = (from child in lstPatientVisit
                        select new PatientVisit { Zone = child.Zone }).Distinct().ToList();

                DataTable dt = new DataTable();
                DataColumn dbCol1 = new DataColumn("Zone");
                DataRow dr;
                //add columns
                dt.Columns.Add(dbCol1);
                for (int j = 0; j < lstP.Count; j++)
                {
                    dr = dt.NewRow();
                    dr["Zone"] = lstP[j].Zone.ToString();
                    dt.Rows.Add(dr);
                }
                DataView dv = new DataView(dt);
                DataTable dt1 = dt.DefaultView.ToTable(true, "Zone");
                ZoneDatList.DataSource = dt1;
                ZoneDatList.DataBind();

                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChangeLabel();", true);


            }

            else
            {

                btnGo.Attributes.Add("style", "display:inline;");
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
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChangeLabel();", true);

            }

            if (lstPatientVisit.Count > 0)
            {
                tblgrdview.Style.Add("display", "table");

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
                    ddlVisitActionName.Items.Insert(0, new ListItem(strselect, "0"));
                    ddlVisitActionName.Visible = true;
                    btnGo.Visible = true;

                    ddlVisitActionName.Items.FindByText("Print").Selected = true;
                }
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChangeLabel();", true);
            }
            else
            {
                tblgrdview.Style.Add("display", "none");

                string AlertMesgNoRecord = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_12 == null ? "No Matching Records Found!" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_12;
                string Alert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
               //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMesgNoRecord + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMesgNoRecord + "','" + Alert + "');", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChangeLabel();", true);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        hdnCurrent.Value = "";
        PatientGetReports(currentPageNo, PageSize);

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
        try
        {
            if (e.CommandName == "ShowReport")
            {

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GridItemCommand", ex);
        }
    }
    string gUID = string.Empty;
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            int sno = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (IsNeedExternalVisitIdWaterMark != "Y")
                {
                    thlabnumber.Attributes.Add("style", "display:none;");
                    HtmlTableCell td = (HtmlTableCell)e.Row.Cells[1].FindControl("LabNubmer");
                    td.Visible = false;
                }
                

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

                }


                string ReportTypeShow = ddlReportType.SelectedValue;
                HtmlTableCell tdprint = (HtmlTableCell)e.Row.Cells[1].FindControl("printimage1");
               
                if (ReportTypeShow == "FAR")
                {
                    tdprint.Visible = true;
                }
                else
                {
                    tdprint.Visible = false;
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
                // btnPrint.Attributes.Add("onclick", "onPrintReport('" + lngVisitID + "','" + RoleID + "','" + pv.OrgID + "','" + label + "','" + pv.DispatchType + "','" + BillPrint + "','" + pv.MappingClientID + "','" + 1 + "','" + pv.CopaymentPercent + "','" + 1 + "');");
                CheckBox chkstatus = (CheckBox)e.Row.FindControl("chkSel");
                //if (hdndespatchClientId.Value == "")
                //{
                //    hdndespatchClientId.Value = chkstatus.ClientID;
                //}
                //else
                //{
                //    hdndespatchClientId.Value += "~" + chkstatus.ClientID;
                //}

                CheckBox chkSel = (CheckBox)e.Row.FindControl("chkSel");
                if (chkSel.Checked)
                {
                    chkstatus.Enabled = true;
                }

                if (pv.VersionNo != "Publish" || pv.ReferralType == "Dispatch")
                {
                    chkstatus.Enabled = true;
                    chkstatus.ToolTip = "Not Yet Published Investigation";
                    chkstatus.Checked = false;
                }
                else if (pv.VersionNo == "Publish")
                {
                    // chkstatus.Checked = true;
                    chkstatus.ToolTip = "Ready To Dispatch";
                    //hdndespatchvisit.Value += pv.PatientVisitId.ToString() + "~" + pv.PatientID.ToString() + "^";
                    //lbldespatchnames.Text += pv.PatientName + "<br/><br/>";
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
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlVisitActionName.SelectedValue == "Show_Print")
            {

                Report_BL objReportBL = new Report_BL(base.ContextInfo);

                if (chkAll.Checked == true || ddlPrintType.SelectedValue == "RPTCHK")
                {
                    PatientGetReportsPrint(-1, -1);
                }
                else
                {
                    long VisitID = 0;
                    long FinalBillID = 0;
                    int flag = 0;
                    int Queuecnt = 0;
                    foreach (GridViewRow gvRow in grdResult.Rows)
                    {
                        if (gvRow.RowType == DataControlRowType.DataRow)
                        {
                            //CLogger.LogWarning("ddlVisitActionName.SelectedValue1 " + ddlVisitActionName.SelectedValue);
                            CheckBox chkSel = (CheckBox)gvRow.FindControl("chkSel");
                            if (chkSel.Checked == true)
                            {
                                TextBox Patientvisit = (TextBox)gvRow.FindControl("txtPatientvisitId");
                                TextBox FinalBill = (TextBox)gvRow.FindControl("FinalURN");
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
                                PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
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

                                if (ddstatus.SelectedValue == "Non Printed")
                                {
                                    AM.Isreprint = false;
                                }
                                else
                                {
                                    AM.Isreprint = true;
                                }


                                res = AM.PerformingNextStepNotification(PC, "", "");
                                Queuecnt = Queuecnt + 1;
                            }
                        }
                    }

                    lbltotalrow.Visible = false;
                    string AlertMessg = Queuecnt.ToString() + " Print Notification Queue Sent";
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('Printed Successfully');", true);
                    tblgrdview.Style.Add("display", "none");
                    trFooter.Attributes.Add("style", "display:none;");
                    tblpage.Attributes.Add("style", "display:none;");
                    dvInvstigationDetails.Style.Add("display", "none");
                    //divFooterNav.Attributes.Add("style", "display:none;");
                    //   trSelectVisit.Visible = false;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "MultiSelect", "ReCallAll();", true);


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
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport ", ex);
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

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            try
            {
                ///////////////////////
                if (e.CommandName == "ShowWithStationary" || e.CommandName == "ShowWithoutStationary")
                {
                    TextBox visitid = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientvisitId");
                    int RowIndex = Convert.ToInt32(e.CommandArgument);
                    long pVisitID = -1;
                    long returnCode = -1;
                    long PatientID = -1;
                    string dPatientID = string.Empty;
                    //   dPatientID = Convert.ToString(grdPatientView.DataKeys[RowIndex][0]);
                    //  pVisitID = Convert.ToInt64(grdPatientView.DataKeys[RowIndex][1]);
                    pVisitID = Convert.ToInt64(visitid.Text);
                    Int64.TryParse(dPatientID, out PatientID);

                    Report_BL objReportBL = new Report_BL(base.ContextInfo);
                    string strInvStatus = InvStatus.Approved;
                    List<string> lstInvStatus = new List<string>();
                    lstInvStatus.Add(strInvStatus);
                    List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
                    List<OrderedInvestigations> _PendingInvestigations = new List<OrderedInvestigations>();
                    string PDFPath = string.Empty;
                    string Status = string.Empty;
                    //string IsDuePending = string.Empty;
                    //returnCode = objReportBL.GetCheckDueAmount(PatientID, pVisitID, OrgID, ILocationID, "P", out IsDuePending);
                    if (e.CommandName == "ShowWithStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true,"", out lstReportSnapshot);
                    }
                    if (e.CommandName == "ShowWithoutStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, false,"", out lstReportSnapshot);
                    }

                    //if (IsDuePending == "N")
                    //{
                    if (lstReportSnapshot.Count > 0)
                    {
                        //if (IsDuePending == "N")
                        //{
                        returnCode = ObjInv.GetOrderedInvStatus(pVisitID, OrgID, lstReportSnapshot[0].AccessionNumber, out lstOrderedInvestigations);
                        _PendingInvestigations = (from IL in lstOrderedInvestigations
                                                  where IL.Status != InvStatus.Approved && IL.Status != InvStatus.PartialyApproved
                                                  select IL).Distinct().ToList();
                        if (_PendingInvestigations.Count > 0)
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);
                        }
                        else if (lstReportSnapshot[0].ReportPath.Length > 0)
                        {
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready2');", true);
                            PDFPath = lstReportSnapshot[0].ReportPath;

                        }
                        //}
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);
                        }
                    }

                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);

                    }

                    if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
                    {
                        //if (IsDuePending == "N")
                        //{
                        string CurrentOrgID = OrgID.ToString();
                        string filePath = PDFPath;
                        modalPopUp.Show();
                        //   ifPDF.Attributes["src"] = "../Patient/ReportPdf.aspx?pdf=" + filePath;
                        ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report cannot be viewed without pending due clearance');", true);
                        //}
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready');", true);
                    }
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('You are having due');", true);
                    //}
                    //Request.QueryString.Clear();
                }


            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Load Child Grid", ex);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
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
    protected void btnGo_Click2(object sender, EventArgs e)
    {


    }
    protected void btnGo_ClickP(object sender, EventArgs e)
    {

        InvStatusPopup.Show();

    }
    protected void ZoneDatList_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("ClientName");
        dt.Columns.Add(dbCol1);
        DataRow dr;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {

            DataList outerDataList = e.Item.FindControl("outerDataList") as DataList;
            List<PatientVisit> lstClientDataList = new List<PatientVisit>();
            Label Zone = (Label)e.Item.FindControl("ZoneName");
            Zone.Attributes.Add("style", "align:center;");
            Label printingperiod = (Label)e.Item.FindControl("lblprintingperiod");
            Label lblPrintedAt = (Label)e.Item.FindControl("lblPrintedAt");
            if (txtFromPeriod.Text.ToString() == "")
            {

                printingperiod.Text = txtFromDate.Text.ToString() + " TO " + txtToDate.Text.ToString();
            }
            else
            {

                printingperiod.Text = txtFromPeriod.Text.ToString() + " TO " + txtToPeriod.Text.ToString();
            }

            if (ddlRegisterDate.SelectedItem.Value == "4")
            {
                printingperiod.Text = OrgTimeZone + " to " + OrgTimeZone;
            }

            lblPrintedAt.Text = "Printed At " + OrgDateTimeZone;

            lstClientDataList = (from child in lstPatientVisit
                                 where child.Zone.ToUpper() == Zone.Text.ToString()
                                 select child).Distinct().ToList(); ;

            //add columns

            for (int j = 0; j < lstClientDataList.Count; j++)
            {
                dr = dt.NewRow();
                dr["ClientName"] = lstClientDataList[j].ClientName.ToString();
                dt.Rows.Add(dr);
            }
            DataView dv = new DataView(dt);
            DataTable dt1 = dt.DefaultView.ToTable(true, "ClientName");
            outerDataList.DataSource = dt1;
            outerDataList.DataBind();


        }

    }
    protected void outerRep_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            e.Item.CssClass = "pageBreak";
            e.Item.Attributes["style"] = "page-break-after:always;";
            e.Item.Attributes["style"] = "pageBreak";
            e.Item.CssClass = "<p style='page-break-after: always'>&nbsp;</p>";
            DataRowView drv = e.Item.DataItem as DataRowView;
            DataList innerDataList = e.Item.FindControl("dlstDispatchList") as DataList;
            List<PatientVisit> lstP = new List<PatientVisit>();
            //lstP = (from child in lstPatientVisit
            //        select new PatientVisit { ClientName = child.ClientName }).Distinct().ToList();
            e.Item.CssClass = "pageBreak";
            e.Item.CssClass = "<p style='page-break-after: always'>&nbsp;</p>";
            Label ClientName = (Label)e.Item.FindControl("ClientName");
            lstP = (from child in lstPatientVisit
                    where child.ClientName.ToUpper() == ClientName.Text.ToString().ToUpper()
                    select child).Distinct().ToList(); ;

            e.Item.Attributes["style"] = "page-break-after:always;";
            e.Item.Attributes["style"] = "pageBreak";
            e.Item.CssClass = "pageBreak";
            innerDataList.DataSource = lstP;
            innerDataList.DataBind();
            e.Item.CssClass = "<p style='page-break-after: always'>&nbsp;</p>";
            e.Item.CssClass = "pageBreak";
        }
    }


    public void LoadMetaData()
    {
        try
        {
            long returncode1 = -1;
            string domains1 = "PrintType,Printstatus,CustomPeriodRange,DespatchType,PatientPayType,ReportType";
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
                var childItems2 = from child in lstmetadataOutput1
                                  where child.Domain == "PrintType"
                                  select child;
                ddlPrintType.DataSource = childItems2;
                ddlPrintType.DataTextField = "DisplayText";
                ddlPrintType.DataValueField = "Code";
                ddlPrintType.DataBind();
                //ddlPrintType.Items.Insert(0, new ListItem("-- Select --", ""));
                ddlPrintType.SelectedValue="RPT";

                var childItems1 = from child in lstmetadataOutput1
                                  where child.Domain == "Printstatus"
                                  select child;
                ddstatus.DataSource = childItems1;
                ddstatus.DataTextField = "DisplayText";
                ddstatus.DataValueField = "Code";
                ddstatus.DataBind();
                //ddstatus.Items.Insert(0, new ListItem("-- Select --", ""));
                ddstatus.SelectedValue = "Non Printed";

                var childItems3 = from child in lstmetadataOutput1
                                  where child.Domain == "CustomPeriodRange"
                                  select child;
                ddlRegisterDate.DataSource = childItems3;
                ddlRegisterDate.DataTextField = "DisplayText";
                ddlRegisterDate.DataValueField = "Code";
                ddlRegisterDate.DataBind();
                ddlRegisterDate.Items.Insert(0, new ListItem(strselect, ""));
                ddlRegisterDate.SelectedValue = "4";
                var childItems4 = from child in lstmetadataOutput1
                                  where child.Domain == "DespatchType"
                                  select child;
                int count = (from child in lstmetadataOutput1
                             where child.Domain == "DespatchType"
                             select child).Count();
                if (count > 0)
                {
                    ddlDispatchMode.DataSource = childItems4;
                    ddlDispatchMode.DataTextField = "DisplayText";
                    ddlDispatchMode.DataValueField = "Code";
                    ddlDispatchMode.DataBind();
                    ddlDispatchMode.Items.Insert(0, new ListItem(strselect, ""));
                }
                else
                {
                    ddlDispatchMode.Items.Insert(0, new ListItem(strselect, ""));
                }

                var childItems5=from child in lstmetadataOutput1
                                where child.Domain=="PatientPayType"
                                select child;
                if (childItems5.Count() > 0)
                {
                    ddlPatientPaytype.DataSource = childItems5;
                    ddlPatientPaytype.DataTextField = "DisplayText";
                    ddlPatientPaytype.DataValueField = "Code";
                    ddlPatientPaytype.DataBind();

                }
                ddlPatientPaytype.Items.Insert(0, new ListItem(strselect, ""));
                ddlPatientPaytype.SelectedValue = "0";
                var childItems6 = from child in lstmetadataOutput1
                                  where child.Domain == "ReportType"
                                  select child;
                if (childItems6.Count() > 0)
                {
                    ddlReportType.DataSource = childItems6;
                    ddlReportType.DataTextField = "DisplayText";
                    ddlReportType.DataValueField = "Code";
                    ddlReportType.DataBind();


                }
                ddlReportType.Items.Insert(0, new ListItem(strselect, ""));
                ddlReportType.SelectedValue = "0";
              
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);


        }

    }


}


