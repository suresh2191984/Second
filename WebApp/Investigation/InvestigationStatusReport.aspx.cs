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
using System.Data;
using Attune.Podium.ExcelExportManager;
using System.IO;
using System.Web.UI.HtmlControls;



public partial class Investigation_InvestigationStatusReport : BasePage
{
public Investigation_InvestigationStatusReport()
        : base("Investigation_InvestigationStatusReport_aspx")
    {
    }
    List<InvestigationStatusReport> lstPatientInvestigationStatus = new List<InvestigationStatusReport>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();
    List<InvestigationStatus> lstInvestigationStatus = new List<InvestigationStatus>();
    List<InvestigationStatus> lstInvestigationSampleStatus = new List<InvestigationStatus>();
    List<InvestigationSampleResult> lstInvestigationSampleResult = new List<InvestigationSampleResult>();
    InvDeptSamples eInvDeptSamples = new InvDeptSamples();
    long returnCode = -1; 
    int InvestigationStatusId;  
    string patientNumber = string.Empty;
    string investigatgionID = string.Empty;
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string flagsearch;
    string select = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_02 == null ? "--Select--" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_02;
    string strall = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_03 == null ? "--ALL--" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_03;
    string strmatch = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_04 == null ? "No Matching Record Found" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_04;
    string stralrt = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_05 == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_05;
    string strsummary = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_06 == null ? "Test Statistic Report Summary" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_06;
    string strdetail = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_07 == null ? "Test Statistic Report Detail" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_07;
    string strtstatus = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_08 == null ? "Test Status" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_08;
    string strSstatus = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_09 == null ? "Sample Status" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_09;
    string strvisit = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_10 == null ? "Patient Visit Status" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_10;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string events = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_11 == null ? "Events" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_13;
    string datetime = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_12 == null ? "DateTime" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_14;
    string user = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_13 == null ? "User" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_15;
    string inv = Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_14 == null ? "INV" : Resources.Investigation_AppMsg.Investigation_InvestigationStatusReport_aspx_16;
    //Investigation_InvestigationReportPrint_aspx_033
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteProduct.ContextKey = "NameandNumber";
        AutoCompleteExtenderRefPhy.ContextKey = "RPH";
        LoadSampleStatus();
        //SetAuthentication();
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','" + txtFrom.ClientID.ToString() + "',1,1);");
        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','" + txtFromDate.ClientID.ToString() + "',1,1);");
        TextBox2.Attributes.Add("onchange", "CheckFromDate('" + TextBox2.ClientID.ToString() + "');");
        TextBox3.Attributes.Add("onchange", "CheckToDate('" + TextBox3.ClientID.ToString() + "');");
        HdnOrgZoneTime.Value = OrgDateTimeZone.Substring(0, 10) + " 12:00:00AM";
        DateTime FromOrgDateTime = Convert.ToDateTime(HdnOrgZoneTime.Value);
        String Time = "";
        Time = string.Format("{0:dd-MMM-yyyy}", FromOrgDateTime);
        TextBox2.Text = Time + " 12:00AM";
        HdnOrgZoneTime.Value = "";
        HdnOrgZoneTime.Value = OrgDateTimeZone.Substring(0, 10) + " 11:59PM";
        DateTime ToOrgDateTime = Convert.ToDateTime(HdnOrgZoneTime.Value);
        Time = "";
        Time = string.Format("{0:dd-MMM-yyyy}", ToOrgDateTime);
        TextBox3.Text = Time + " 11:59PM";
        HdnOrgZoneTime.Value = "";
        string Status = hdnSetSearchType.Value;
        if (Status == "PS")
        {
            dvtestStatus.Enabled = true;
            Label1.Enabled = false;
            ddlInvestigationStatus1.Enabled = false;
            Label2.Enabled = false;
            ddlSampleStatus.Enabled = false;
        }
        else if (Status == "TS")
        {
            dvtestStatus.Enabled = false;
            Label1.Enabled = true;
            ddlInvestigationStatus1.Enabled = true;
            Label2.Enabled = false;
            ddlSampleStatus.Enabled = false;
        }
        else if (Status == "SS")
        {
            dvtestStatus.Enabled = false;
            Label1.Enabled = false;
            ddlInvestigationStatus1.Enabled = false;
            Label2.Enabled = true;
            ddlSampleStatus.Enabled = true;
        }

        if (!IsPostBack)
        {
            grouptab.ActiveTabIndex = 2;
            txtTo.Text = DateTime.Today.ToString();
            txtFrom.Text = DateTime.Today.ToString();
            loadDept();
            LoadOrganizations();
            LoadMetaData();
            GetClientType();
            if (ddlOrganization.Items.Count > 0)
            {
                ddlOrganization.SelectedValue = OrgID.ToString();
            }
            if (ddlOrg.Items.Count > 0)
            {
                ddlOrg.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID, strall);
            loadDeptChecklist();
            DropDownlistBind();
            DropDownlistBind_Sample();
            txtFrom.Text = OrgTimeZone;
            txtTo.Text = OrgTimeZone;
            txtFromDate.Text = OrgTimeZone;
            txtToDate.Text = OrgTimeZone;
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
            AutoCompleteExtender2.ContextKey = OrgID.ToString();
            rdoSummary.Checked = true;
            rdoDetail.Checked = false;
        }
        if (hdnPrintState.Value == "1")
        {
            Btn_Search();
            hdnPrintState.Value = "0";
        }
        AutoCompleteExtender1.ContextKey = ddlOrg.SelectedValue;
        AutoCompleteExtender2.ContextKey = ddlOrganization.SelectedValue;
    }
    public void SetAuthentication()
    {
        PageAuthentication oPageAuthentication = new PageAuthentication(base.ContextInfo);
        string currentAuth = oPageAuthentication.GetCurrentAuthentication("Investigation/InvestigationStatusReport", Convert.ToString(OrgID), strall);

        if (!string.IsNullOrEmpty(currentAuth))
        {
            string[] Auth = currentAuth.Split('@');
            for (int i = 0; i < Auth.Length; i++)
            {
                string controlAction = oPageAuthentication.ToDoControl(Auth[i].Split('-')[1]);
                switch (Auth[i].Split('-')[0])
                {

                    case "HC":

                        if (controlAction.Equals("Hide"))
                        {
                            hdnhidegrid.Value = "Y";
                        }
                        else if (controlAction.Equals("ShowNDisable"))
                        {

                        }
                        else
                        {

                        }
                        break;
                    default:
                        break;
                }
            }
        }
    }

    public void DropDownlistBind()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(out lstInvestigationStatus, out lstInvestigationSampleStatus);

        ddlInvestigationStatus1.DataSource = lstInvestigationStatus;
        ddlInvestigationStatus1.DataTextField = "DisplayText";
        ddlInvestigationStatus1.DataValueField = "InvestigationStatusID";
        ddlInvestigationStatus1.DataBind();
        ddlInvestigationStatus1.Items.Insert(0, new ListItem(select));
        ddlInvestigationStatus1.Items[0].Value = "-1";
    }
    public void DropDownlistBind_Sample()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(out lstInvestigationStatus, out lstInvestigationSampleStatus);

        ddlSampleStatus.DataSource = lstInvestigationSampleStatus;
        ddlSampleStatus.DataTextField = "DisplayText";
        ddlSampleStatus.DataValueField = "InvestigationStatusID";
        ddlSampleStatus.DataBind();
        ddlSampleStatus.Items.Insert(0, new ListItem(select));
        ddlSampleStatus.Items[0].Value = "-1";
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    { 
    }
    protected void loadDeptChecklist()
    {
        foreach (ListItem Deptcheck in this.check1.Items)
        {
            Deptcheck.Selected = true;
        }
        foreach (ListItem ChkDt in chkDept.Items)
        {
            ChkDt.Selected = true;
        }
    }

    //Load Organizations
    protected void LoadOrganizations()
    {
        try
        {
            AdminReports_BL AdminReportsBL = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrganizations = new List<Organization>();
            long lngReturnCode = 0;
            lngReturnCode = AdminReportsBL.GetSharingOrganizations(OrgID, out lstOrganizations);

            ddlOrganization.DataSource = lstOrganizations;
            ddlOrganization.DataTextField = "Name";
            ddlOrganization.DataValueField = "OrgID";
            ddlOrganization.DataBind();

            ddlOrg.DataSource = lstOrganizations;
            ddlOrg.DataTextField = "Name";
            ddlOrg.DataValueField = "OrgID";
            ddlOrg.DataBind();


            ddlorgan.DataSource = lstOrganizations;
            ddlorgan.DataTextField = "Name";
            ddlorgan.DataValueField = "OrgID";
            ddlorgan.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadOrganizations", ex);
        }
    }
    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ListItem lstItem = new ListItem();
                lstItem.Text = select;
                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);

                ddlInvClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlInvClientType.DataValueField = "ClientTypeID";
                ddlInvClientType.DataTextField = "ClientTypeName";
                ddlInvClientType.DataBind();
                ListItem lstInvItem = new ListItem();
                lstInvItem.Text = select;
                lstInvItem.Value = "0";
                ddlInvClientType.Items.Insert(0, lstInvItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
        }
    }
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "Classification,TestClassification,VisitType,Labpriority";
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
                                 where child.Domain == "TestClassification"
                                 orderby child.DisplayText descending
                                 select child;
                ddlTestCategory.DataSource = childItems;
                ddlTestCategory.DataTextField = "DisplayText";
                ddlTestCategory.DataValueField = "Code";
                ddlTestCategory.DataBind();
                ddlTestCategory.Items.Insert(0, select);
                ddlTestCategory.Items[0].Value = string.Empty;
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Labpriority"
                                 orderby child.DisplayText descending
                                 select child;
                ddlSTATStatus.DataSource = childItems1;
                ddlSTATStatus.DataTextField = "DisplayText";
                ddlSTATStatus.DataValueField = "Code";
                ddlSTATStatus.DataBind();
                ddlSTATStatus.Items.Insert(0, select);
                ddlSTATStatus.Items[0].Value = "0";
                DropDownList3.DataSource = childItems1;
                DropDownList3.DataTextField = "DisplayText";
                DropDownList3.DataValueField = "Code";
                DropDownList3.DataBind();
                DropDownList3.Items.Insert(0, strall);
                DropDownList3.Items[0].Value = "0";
            }

            List<MetaValue_Common> lstGroupCategory = new List<MetaValue_Common>();
            returnCode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVESTIGATION_GROUP_FEE", out lstGroupCategory);

            if (lstGroupCategory.Count > 0)
            {
                ddlInvTestcategory.DataSource = lstGroupCategory;
                ddlInvTestcategory.DataTextField = "Value";
                ddlInvTestcategory.DataValueField = "Code";
                ddlInvTestcategory.DataBind();
            }
            ListItem item = new ListItem();
            item.Text = select;
            item.Value = "0";
            ddlInvTestcategory.Items.Insert(0, item);



            var childItems5 = from child in lstmetadataOutput
                              where child.Domain == "VisitType"
                              orderby child.DisplayText descending
                              select child;

            ddlVisitType.DataSource = childItems5;
            ddlVisitType.DataTextField = "DisplayText";
            ddlVisitType.DataValueField = "Code";
            ddlVisitType.DataBind();

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    private void LoadLocationsCall(string Type)
    {
        try
        {
            if (Type == "TSR")
            {
                if (ddlOrganization.Items.Count > 0 && ddlOrganization.SelectedItem.Value != "0")
                {
                    loadlocations(RoleID, Convert.ToInt32(ddlOrganization.SelectedItem.Value), Type);
                }
            }
            else
            {
                if (ddlOrg.Items.Count > 0 && ddlOrg.SelectedItem.Value != "0")
                {
                    loadlocations(RoleID, Convert.ToInt32(ddlOrg.SelectedItem.Value), Type);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadLocationCall", ex);
        }
    }
    //Load Organizations
    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        string Status = hdnSetSearchType.Value;
        string str = string.Empty;
        if (grouptab.ActiveTabIndex == 0)
        {
            Btn_Search(-1, -1);
            if (Status == "PS")
            {
                str = strvisit;
                ExportToExcel(gvDuplicate1, str);
            }
            else
            {
                str = Status == "TS" ? strtstatus : strtstatus;
                ExportToExcel(gvDuplicate2, str);
            }
        }
        else
        {
            if (rdoDetail.Checked == true)
            {
                str = strdetail; 
                ExportToExcel(grdLabTestStatReport, str);
            }
            else
            {
                str = strsummary;
                ExportToExcel(pnlSummary, str);
            }
        }
    }
    public void ExportToExcel(Control ctr, string str)
    {
        try
        {
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix + OrgTimeZone;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>" + str + " </span>");
            ctr.RenderControl(oHtmlTextWriter);
            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }

    protected void loadlocations(long uroleID, int intOrgID, string sType)
    {
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            if (lstLocation.Count > 0)
            {
                if (sType == "INV")
                {
                    ddlLocation.DataSource = lstLocation;
                    ddlLocation.DataTextField = "Location";
                    ddlLocation.DataValueField = "AddressID";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, strall);
                    ddlLocation.Items[0].Value = "0";
                    ddlLocation.Items[0].Selected = true;
                }
                else if (sType == "TSR")
                {
                    drpLocation.DataSource = lstLocation;
                    drpLocation.DataTextField = "Location";
                    drpLocation.DataValueField = "AddressID";
                    drpLocation.DataBind(); 
                    drpLocation.SelectedItem.Value = ILocationID.ToString();
                }
                else
                {
                    ddlLocation.DataSource = lstLocation;
                    ddlLocation.DataTextField = "Location";
                    ddlLocation.DataValueField = "AddressID";
                    ddlLocation.DataBind();
                    drpLocation.DataSource = lstLocation;
                    drpLocation.DataTextField = "Location";
                    drpLocation.DataValueField = "AddressID";
                    drpLocation.DataBind();

                    ddlloca.DataSource = lstLocation;
                    ddlloca.DataTextField = "Location";
                    ddlloca.DataValueField = "AddressID";
                    ddlloca.DataBind();
                    ddlLocation.Items.Insert(0, strall);
                    ddlLocation.Items[0].Value = "0";
                    ddlLocation.Items[0].Selected = true;
                    drpLocation.SelectedItem.Value = ILocationID.ToString(); 
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadLocation", ex);
        }
    }
    protected void loadDept()
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
        returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
        //var lstdepartment = from lst in lstDpt
        //                    where lst.Display == "Y"
        //                    select lst;
        check1.DataSource = lstDpt;
        check1.DataBind();
        chkDept.DataSource = lstDpt;
        chkDept.DataBind();
    }
    public void LoadSampleStatus()
    {
        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatus(out lstInvestigationStatus, out lstInvestigationSampleStatus);

        var lstStatus = from c in lstInvestigationStatus where c.DisplayText == "Approve" || c.DisplayText == "Pending" || c.DisplayText == "Cancel" orderby c.InvestigationStatusID select c;
        ddlVisitStatus.DataSource = lstStatus;
        ddlVisitStatus.DataTextField = "DisplayText";
        ddlVisitStatus.DataValueField = "InvestigationStatusID";
        ddlVisitStatus.DataBind();
        ddlVisitStatus.Items.Insert(0, new ListItem(strall));
        ddlVisitStatus.Items[0].Value = "0";
    }
    protected void btnSearchStat_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            InvDeptMaster eInvDeptMaster = new InvDeptMaster();
            int ClientType = Convert.ToInt32(ddlInvClientType.SelectedValue);
            int ClientID = Convert.ToInt32(hdnInvSelectedClientID.Value);
            string TestCategory = ddlTestCategory.SelectedValue;

            int RefHospitalID = Convert.ToInt32(hdnReferringHospitalID.Value);
            int RefPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);

            int PageSize = 0, currentPageNo = 0, totalRows = 0;
            int AnalyzerID = 0;

            DateTime fromDate = txtFromDate.Text != string.Empty && txtFromDate.Text != null ? Convert.ToDateTime(txtFromDate.Text) : Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime toDate = txtToDate.Text != string.Empty && txtToDate.Text != null ? Convert.ToDateTime(txtToDate.Text) : Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            int LocationID = Convert.ToInt32(drpLocation.SelectedValue) == 0 ? ILocationID : Convert.ToInt32(drpLocation.SelectedValue);
            string testName = txtTestStatName.Text == string.Empty ? string.Empty : txtTestStatName.Text;
            string reportType = rdoDetail.Checked == true ? "Detailed" : "Summary";
            foreach (ListItem item in this.chkDept.Items)
            {
                if (item.Selected)
                {
                    eInvDeptMaster = new InvDeptMaster();
                    eInvDeptMaster.DeptID = Convert.ToInt32(item.Value);
                    eInvDeptMaster.DeptName = item.Text.Trim();
                    eInvDeptMaster.OrgID = OrgID;
                    lstInvDeptMaster.Add(eInvDeptMaster);
                }
            }

            returnCode = new Report_BL(base.ContextInfo).GetLabTestCountReportDetail(fromDate, toDate, Convert.ToInt32(ddlOrganization.SelectedItem.Value), Convert.ToInt64(drpLocation.SelectedItem.Value), testName, lstInvDeptMaster, reportType, ClientType, ClientID, TestCategory, RefPhysicianID, RefHospitalID, AnalyzerID, PageSize, currentPageNo, out totalRows, out lstPatientInvestigationStatus);
            if (lstPatientInvestigationStatus.Count > 0)
            {
                //divPrintReport.Style.Add("display", "block");
                loadTestdata(lstPatientInvestigationStatus);
            }
            else
            {
                //divPrintReport.Style.Add("display", "none");
            }
            if (rdoDetail.Checked)
            {
                grdLabTestStatReport.AllowPaging = false;
                grdLabTestStatReport.DataSource = lstPatientInvestigationStatus;
                grdLabTestStatReport.DataBind();
                rptSummary.DataSource = null;
                rptSummary.DataBind();
                trLabTestStatReportDetail.Style.Add("display", "block");
                trLabTestStatReportSummary.Style.Add("display", "none");
            }
            else
            {
                grdLabTestStatReport.DataSource = null;
                grdLabTestStatReport.DataBind();
                rptSummary.DataSource = lstPatientInvestigationStatus;
                rptSummary.DataBind();
                trLabTestStatReportDetail.Style.Add("display", "none");
                trLabTestStatReportSummary.Style.Add("display", "block");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Test statistic report", ex);
        }
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            grdLabTestStatReport.AllowPaging = false;
            grdLabTestStatReport.DataSource = ViewState["TestStatreport"];
            grdLabTestStatReport.DataBind();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Print grid content", "javascript:popupprintTestStat();", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            CLogger.LogError("Error in Print Report, LabTestStatisticReport", tae);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Print Report, LabTestStatisticReport", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Btn_Search();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
    private void Btn_Search()
    {
        currentPageNo = 1;
        hdnCurrent.Value = "";
        string Status = hdnSetSearchType.Value;
        int OrgID = Convert.ToInt32(ddlOrg.SelectedValue);
        long orgaddressID = Convert.ToInt64(ddlLocation.SelectedValue);
        string PatientNo = txtPatientNo.Text;
        string PatientName = txtName.Text;
        int pVisitType = Convert.ToInt32(ddlVisitType.SelectedValue);
        string FrmDate = txtFrom.Text != "" ? txtFrom.Text : string.Empty;
        string ToDate = txtTo.Text != "" ? txtTo.Text : string.Empty;
        int SourceID = 0;
        string TestCategory = ddlTestCategory.SelectedValue;
        if (Status == "PS")
        {
            InvestigationStatusId = 0;
        }
        else if (Status == "TS")
        {
            InvestigationStatusId = Convert.ToInt32(ddlInvestigationStatus1.SelectedValue);
        }
        else if (Status == "SS")
        {
            InvestigationStatusId = Convert.ToInt32(ddlSampleStatus.SelectedValue);
        }
        string TestName = txtTestName.Text;
        long TestID = Convert.ToInt64(hdnTestID.Value);
        string TestType = hdnTestType.Value;
        int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
        long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
        string Status1 = hdnSetSearchType.Value;
        string ReportStatus = hdnSetSearchReport.Value;
        foreach (ListItem Deptcheck in this.check1.Items)
        {
            if (Deptcheck.Selected)
            {
                eInvDeptSamples = new InvDeptSamples();
                eInvDeptSamples.DeptID = Convert.ToInt32(Deptcheck.Value);
                eInvDeptSamples.OrgID = OrgID;
                lstDeptSamples.Add(eInvDeptSamples);
            }
        }
        int StatStatus = Convert.ToInt32(ddlSTATStatus.SelectedValue);
        returnCode = new Investigation_BL(base.ContextInfo).pGetPatientInvestigationStatus(PatientNo, PatientName, FrmDate, ToDate, OrgID, orgaddressID, Status1, lstDeptSamples, ReportStatus, out lstPatientInvestigationStatus, pVisitType, SourceID, TestName, TestID, TestType, TestCategory, InvestigationStatusId, ClientTypeID, ClientID, PageSize, currentPageNo, out totalRows, StatStatus);
        //Vijayalakshmi.M
        if (lstPatientInvestigationStatus.Count > 0)
        {
            for (int i = 0; i < lstPatientInvestigationStatus.Count; i++)
            {
                if (lstPatientInvestigationStatus[i].PatientName != "" && lstPatientInvestigationStatus[i].PatientName != null)
                {
                    string str = lstPatientInvestigationStatus[i].PatientName;
                    string[] strage = str.Split('-');
                    string[] strage1 = strage[1].Split(' ');
                    if (strage1[2] == "Year(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " +strage1[1]+" "+ strYear;
                    }
                    else if (strage1[2] == "Month(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strMonth;
                    }
                    else if (strage1[2] == "Day(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[i] + " - " + strage1[1] + " " + strDay;
                    }
                    else if (strage1[2] == "Week(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strWeek;
                    }
                    else
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strYear;
                    }
                }
            }
        }
        //End
        loaddata(lstPatientInvestigationStatus);

            if (Status == "PS")
            {
                if (lstPatientInvestigationStatus.Count > 0)
                {
                    tdPatientStatus.Style.Add("display", "block");
                    tdTestStatus.Style.Add("display", "none");
                    gvStatusReport.DataSource = lstPatientInvestigationStatus;
                    gvStatusReport.DataBind();
                    tdduplipat.Style.Add("display", "block");
                    tdduplitest.Style.Add("display", "none");
                    gvDuplicate1.DataSource = lstPatientInvestigationStatus;
                    gvDuplicate1.DataBind();
                }
                else
                {
                   // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                    gvStatusReport.DataSource = "";
                    gvDuplicate1.DataSource = "";
                    tdPatientStatus.Style.Add("display", "none");
                    tdTestStatus.Style.Add("display", "none");
                    GrdFooter.Style.Add("display", "none");
                    //gvDuplicate1.DataBind();
                    //gvStatusReport.DataBind();
                }

        }
        if (Status == "TS")
        {
            if (lstPatientInvestigationStatus.Count > 0)
            {
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "block");
                gvTestStatusReport.DataSource = lstPatientInvestigationStatus;
                gvTestStatusReport.DataBind();
                gvTestStatusReport.Columns[15].Visible = true;
                gvTestStatusReport.Columns[16].Visible = true;
                gvTestStatusReport.Columns[14].Visible = true;
                tdduplipat.Style.Add("display", "none");
                tdduplitest.Style.Add("display", "block");
                gvDuplicate2.DataSource = lstPatientInvestigationStatus;
                gvDuplicate2.DataBind();
                }
                else
                {  
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                gvTestStatusReport.DataSource = "";
                gvStatusReport.DataSource = "";
                gvDuplicate2.DataSource = "";
                GrdFooter.Style.Add("display", "none");
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "none");
                
                }
            }
            if (Status == "SS")
            {
                if (lstPatientInvestigationStatus.Count > 0)
                {
                    tdPatientStatus.Style.Add("display", "none");
                    tdTestStatus.Style.Add("display", "block");
                    gvTestStatusReport.DataSource = lstPatientInvestigationStatus;
                    gvTestStatusReport.DataBind();
                    tdduplipat.Style.Add("display", "none");
                    tdduplitest.Style.Add("display", "block");
                    gvDuplicate2.DataSource = lstPatientInvestigationStatus;
                    gvDuplicate2.DataBind();
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                    gvTestStatusReport.DataSource = "";
                    gvStatusReport.DataSource = "";
                    gvDuplicate2.DataSource = "";                    
                    gvStatusReport.DataSource = "";
                    gvDuplicate1.DataSource = "";                    
                    tdPatientStatus.Style.Add("display", "none");
                    tdTestStatus.Style.Add("display", "none");
                    GrdFooter.Style.Add("display", "none");
                    gvTestStatusReport.Dispose();
                    gvStatusReport.Dispose();
                }
                
            }
            
            //if (lstPatientInvestigationStatus.Count > 0)
            //{
            //    divPrint1.Attributes.Add("Style", "display:block");
                
            //}
            //if (lstPatientInvestigationStatus.Count > 0)
            //{
            //    divPrint1.Attributes.Add("Style", "display:block");
               
            //}
            if (lstPatientInvestigationStatus.Count > 0)
            {
                GrdFooter.Style.Add("display", "table-row");
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
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
       
    }
    protected void grdLabTestStatReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdLabTestStatReport.PageIndex = e.NewPageIndex;
            btnSearchStat_Click(sender, e);
        }
    }
    protected void gvStatusReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvStatusReport.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void gvTestStatusReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvTestStatusReport.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        Btn_Search(Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    private void Btn_Search(int currentPageNo, int PageSize)
    {
        int OrgID = Convert.ToInt32(ddlOrg.SelectedValue);
        long orgaddressID = Convert.ToInt64(ddlLocation.SelectedValue);
        string PatientNo = txtPatientNo.Text;
        string PatientName = txtName.Text;
        int pVisitType = Convert.ToInt32(ddlVisitType.SelectedValue);
        string FrmDate = txtFrom.Text != "" ? txtFrom.Text : string.Empty;
        string ToDate = txtTo.Text != "" ? txtTo.Text : string.Empty;
        int SourceID = 0;
        string TestCategory = ddlTestCategory.SelectedValue;
        //InvestigationStatusId = Convert.ToInt32(ddlInvestigationStatus1.SelectedValue);
        string Status = hdnSetSearchType.Value;
        if (Status == "PS")
        {
            InvestigationStatusId = 0;
        }
        else if (Status == "TS")
        {
            InvestigationStatusId = Convert.ToInt32(ddlInvestigationStatus1.SelectedValue);
        }
        else if (Status == "SS")
        {
            InvestigationStatusId = Convert.ToInt32(ddlSampleStatus.SelectedValue);
        }
        string TestName = txtTestName.Text;
        long TestID = Convert.ToInt64(hdnTestID.Value);
        string TestType = hdnTestType.Value;
        int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
        long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);        
        string ReportStatus = hdnSetSearchReport.Value;
        foreach (ListItem Deptcheck in this.check1.Items)
        {
            if (Deptcheck.Selected)
            {
                eInvDeptSamples = new InvDeptSamples();
                eInvDeptSamples.DeptID = Convert.ToInt32(Deptcheck.Value);
                eInvDeptSamples.OrgID = OrgID;
                lstDeptSamples.Add(eInvDeptSamples);
            }
        }
        returnCode = new Investigation_BL(base.ContextInfo).pGetPatientInvestigationStatus(PatientNo, PatientName, FrmDate, ToDate, OrgID, orgaddressID, Status, lstDeptSamples, ReportStatus, out lstPatientInvestigationStatus, pVisitType, SourceID, TestName, TestID, TestType, TestCategory, InvestigationStatusId, ClientTypeID, ClientID, PageSize, currentPageNo, out totalRows, Convert.ToInt32(ddlSTATStatus.SelectedValue));
        //Vijayalakshmi.M
        if (lstPatientInvestigationStatus.Count > 0)
        {
            for (int i = 0; i < lstPatientInvestigationStatus.Count; i++)
            {
                if (lstPatientInvestigationStatus[i].PatientName != "" && lstPatientInvestigationStatus[i].PatientName != null)
                {
                    string str = lstPatientInvestigationStatus[i].PatientName;
                    string[] strage = str.Split('-');
                    string[] strage1 = strage[1].Split(' ');
                    if (strage1[2] == "Year(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strYear;
                    }
                    else if (strage1[2] == "Month(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strMonth;
                    }
                    else if (strage1[2] == "Day(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strDay;
                    }
                    else if (strage1[2] == "Week(s)")
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strWeek;
                    }
                    else
                    {
                        lstPatientInvestigationStatus[i].PatientName = strage[0] + " - " + strage1[1] + " " + strYear;
                    }
                }
            }
        }
        //End
        loaddata(lstPatientInvestigationStatus);

        if (Status == "PS")
        {
            if (lstPatientInvestigationStatus.Count > 0)
            {
                tdPatientStatus.Style.Add("display", "block");
                tdTestStatus.Style.Add("display", "none");
                gvStatusReport.DataSource = lstPatientInvestigationStatus;
                gvStatusReport.DataBind();
                tdduplipat.Style.Add("display", "block");
                tdduplitest.Style.Add("display", "none");
                gvDuplicate1.DataSource = lstPatientInvestigationStatus;
                gvDuplicate1.DataBind();
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                gvStatusReport.DataSource = "";
                gvDuplicate1.DataSource = "";
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "none");
                GrdFooter.Style.Add("display", "none");
                //gvDuplicate1.DataBind();
                //gvStatusReport.DataBind();
            }

        }
        if (Status == "TS")
        {
            if (lstPatientInvestigationStatus.Count > 0)
            {
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "block");
                gvTestStatusReport.DataSource = lstPatientInvestigationStatus;
                gvTestStatusReport.DataBind();
                gvTestStatusReport.Columns[15].Visible = true;
                gvTestStatusReport.Columns[16].Visible = true;
                gvTestStatusReport.Columns[14].Visible = true;
                tdduplipat.Style.Add("display", "none");
                tdduplitest.Style.Add("display", "block");
                gvDuplicate2.DataSource = lstPatientInvestigationStatus;
                gvDuplicate2.DataBind();
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                gvTestStatusReport.DataSource = "";
                gvStatusReport.DataSource = "";
                gvDuplicate2.DataSource = "";
                GrdFooter.Style.Add("display", "none");
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "none");

            }
        }
        if (Status == "SS")
        {
            if (lstPatientInvestigationStatus.Count > 0)
            {
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "block");
                gvTestStatusReport.DataSource = lstPatientInvestigationStatus;
                gvTestStatusReport.DataBind();
                tdduplipat.Style.Add("display", "none");
                tdduplitest.Style.Add("display", "block");
                gvDuplicate2.DataSource = lstPatientInvestigationStatus;
                gvDuplicate2.DataBind();
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strmatch + "','" + stralrt + "');", true);
                gvTestStatusReport.DataSource = "";
                gvStatusReport.DataSource = "";
                gvDuplicate2.DataSource = "";
                gvStatusReport.DataSource = "";
                gvDuplicate1.DataSource = "";
                tdPatientStatus.Style.Add("display", "none");
                tdTestStatus.Style.Add("display", "none");
                GrdFooter.Style.Add("display", "none");
                gvTestStatusReport.Dispose();
                gvStatusReport.Dispose();
            }

        }
        if (lstPatientInvestigationStatus.Count > 0)
        {
            GrdFooter.Style.Add("display", "table-row");
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
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
            GrdFooter.Style.Add("display", "none");
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    public DataTable loadTestdata(List<InvestigationStatusReport> lstReport)
    {
        ViewState["report"] = null;
        DataTable dt = new DataTable();

        DataColumn dcol11 = new DataColumn("InvestigationName");
        DataColumn dcol12 = new DataColumn("DeptName");
        DataColumn dcol1 = new DataColumn("normalTestCount");
        DataColumn dcol2 = new DataColumn("abnormalTestCount");
        DataColumn dcol3 = new DataColumn("criticalTestCount");
        DataColumn dcol4 = new DataColumn("unSpecifiedTestCount");
        DataColumn dcol5 = new DataColumn("reTestCount");
        DataColumn dcol6 = new DataColumn("reflexTestCount");
        DataColumn dcol7 = new DataColumn("dilutionTestCount");
        DataColumn dcol8 = new DataColumn("qCTestCount");
        DataColumn dcol9 = new DataColumn("manualTestCount");
        DataColumn dcol10 = new DataColumn("interfacedTestCount");
        DataColumn dcol13 = new DataColumn("Location");

        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol13);
        foreach (InvestigationStatusReport item in lstReport)
        {
            DataRow dr = dt.NewRow();

            dr["InvestigationName"] = item.InvestigationName;
            dr["DeptName"] = item.DeptName;
            dr["normalTestCount"] = item.NormalTestCount;
            dr["abnormalTestCount"] = item.AbnormalTestCount;
            dr["criticalTestCount"] = item.CriticalTestCount;
            dr["unSpecifiedTestCount"] = item.UnSpecifiedTestCount;
            dr["reTestCount"] = item.ReTestCount;
            dr["reflexTestCount"] = item.ReflexTestCount;
            dr["dilutionTestCount"] = item.DilutionTestCount;
            dr["qCTestCount"] = item.QCTestCount;
            dr["manualTestCount"] = item.ManualTestCount;
            dr["interfacedTestCount"] = item.InterfacedTestCount;
            dr["Location"] = item.Location;
            dt.Rows.Add(dr);
        }
        ViewState["TestStatreport"] = dt;
        return dt;
    }
    public DataTable loaddata(List<InvestigationStatusReport> lstReport)
    {
        ViewState["TestStatreport"] = null;
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();

        DataColumn dcol1 = new DataColumn("Patient No");
        DataColumn dcol2 = new DataColumn("Patient Name");
        DataColumn dcol3 = new DataColumn("ExternalVisitID");
        DataColumn dcol4 = new DataColumn("Registration On");
        DataColumn dcol5 = new DataColumn("Test Name");
        DataColumn dcol6 = new DataColumn("Sample Collection");
        DataColumn dcol7 = new DataColumn("Result Capture");
        DataColumn dcol8 = new DataColumn("Approval");
        DataColumn dcol9 = new DataColumn("Location");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2); 
        dt.Columns.Add(dcol4);
        if (hdnSetSearchType.Value == "TS")
        {
            dt.Columns.Add(dcol5);
        }
        dt.Columns.Add(dcol6);  
        dt.Columns.Add(dcol9);
        foreach (InvestigationStatusReport item in lstReport)
        {
            DataRow dr = dt.NewRow();

            dr["Patient No"] = item.PatientNumber;
            dr["Patient Name"] = item.PatientName; 
            dr["Registration On"] = item.RegistrationDTTM;
            if (hdnSetSearchType.Value == "TS")
            {
                dr["Test Name"] = item;
            }
            dr["Sample Collection"] = item.SampleCollection; 
            dr["Location"] = item.Location;

            dt.Rows.Add(dr);

        }
        ds.Tables.Add(dt);
        ViewState["report"] = ds; 
        return dt;
    }
    protected void imgbtnExportToExcel_Click(object sender, ImageClickEventArgs e)
    { 

    } 
    public void ExportToExcel5()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=TestStatistics_Reports_" + OrgTimeZone + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            pnlSummary.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, TestStatistics_Reports", ex);
        }
    }
    public void ExportToExcelDetail()
    {
        try
        {
            ////export to excel
            DataTable dt = (DataTable)ViewState["TestStatreport"];
            string prefix = string.Empty;
            prefix = "TestStatistics_Reports_";
            string rptDate = prefix + OrgTimeZone + ".xls";
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            CLogger.LogError("Error in Convert to XL, LabTestStatisticReport", tae);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, LabTestStatisticReport", ex);
        }
    }
    
    protected void btnConverttoPrint_Click(object sender, ImageClickEventArgs e)
    {
        if (gvDuplicate2.Rows.Count > 0)
        {
            Btn_Search(-1, -1);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:popupprint();", true);
            ViewState["flag"] = "1";
        }
        else if (gvDuplicate1.Rows.Count > 0)
        {
            Btn_Search(-1, -1);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:popupprint();", true);
            ViewState["flag"] = "1";
        }
        else
        {
            tdduplitest.Style.Add("display", "none");
            tdTestStatus.Style.Add("display", "none");
            tdPatientStatus.Style.Add("display", "none");
            tdduplipat.Style.Add("display", "none");

        }

    }
    protected void gvTestStatusReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (hdnhidegrid.Value == "Y")
                {
                    e.Row.Cells[14].Style.Add("display", "none");
                    e.Row.Cells[15].Style.Add("display", "none");
                    //e.Row.Cells[16].Style.Add("display", "none");
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                if (hdnhidegrid.Value == "Y")
                {
                    e.Row.Cells[14].Style.Add("display", "none");
                    e.Row.Cells[15].Style.Add("display", "none");
                    //e.Row.Cells[16].Style.Add("display", "none");
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InvestigationStatusReport rpt = (InvestigationStatusReport)e.Row.DataItem;
                if (rpt.OrgID != 0)
                {
                    if (OrgID != rpt.OrgID)
                    {
                        e.Row.BackColor = System.Drawing.Color.Orange; 
                    }
                }
                if (hdnhidegrid.Value == "Y")
                {
                    e.Row.Cells[14].Style.Add("display", "none");
                    e.Row.Cells[15].Style.Add("display", "none");
                    //e.Row.Cells[16].Style.Add("display", "none");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in test status Report  Grid", ex);
        }
    }
    protected void Test(object sender, GridViewCommandEventArgs e)
    {
        int RowIndex = Convert.ToInt32(e.CommandArgument);
        long VisitId = Convert.ToInt64(gvTestStatusReport.DataKeys[RowIndex][0]);
        int AccessionNumber = Convert.ToInt32(gvTestStatusReport.DataKeys[RowIndex][1]);     
        InvStatusPopup.Show();
       
        
        TableRow rowHeader1 = new TableRow();
        TableCell cellHeader1 = new TableCell();
        cellHeader1.Attributes.Add("align", "center");
        cellHeader1.Text = "<b>" + events + "</b>";
        cellHeader1.Font.Bold = true;
        cellHeader1.CssClass = "Duecolor";
        cellHeader1.ColumnSpan = 2;
        rowHeader1.Cells.Add(cellHeader1);
        tblEvents.Rows.Add(rowHeader1);

        ////////////////////FOR DATETIME//////////////////////

        TableRow rowHeaderDATE1 = new TableRow();
        TableCell cellHeaderDATE1 = new TableCell();
        cellHeaderDATE1.Attributes.Add("align", "center");
        cellHeaderDATE1.Text = "<b>" + datetime + "</b>";
        cellHeaderDATE1.Font.Bold = true;
        cellHeaderDATE1.CssClass = "Duecolor";
        cellHeaderDATE1.ColumnSpan = 2;
        rowHeaderDATE1.Cells.Add(cellHeaderDATE1);
        tblDateTime.Rows.Add(rowHeaderDATE1);

        ////////////////////FOR USER//////////////////////

        TableRow rowHeaderUSER1 = new TableRow();
        TableCell cellHeaderUSER1 = new TableCell();
        cellHeaderUSER1.Attributes.Add("align", "center");
        cellHeaderUSER1.Text = "<b>" + user + "</b>";
        cellHeaderUSER1.Font.Bold = true;
        cellHeaderUSER1.CssClass = "Duecolor";
        cellHeaderUSER1.ColumnSpan = 2;
        rowHeaderUSER1.Cells.Add(cellHeaderUSER1);
        tblUser.Rows.Add(rowHeaderUSER1);


        ///////////////////INV///////////////////////////

        TableRow rowHeaderINV = new TableRow();
        TableCell cellHeaderINV = new TableCell();
        cellHeaderINV.Attributes.Add("align", "center");
        cellHeaderINV.Text = "<b>" + inv + "</b>";
        cellHeaderINV.Font.Bold = true;
        cellHeaderINV.CssClass = "Duecolor";
        cellHeaderINV.ColumnSpan = 2;
        rowHeaderINV.Cells.Add(cellHeaderINV);
        tblINV.Rows.Add(rowHeaderINV);

        returnCode = new Investigation_BL(base.ContextInfo).GetInvStatusSampleResult(VisitId, OrgID, AccessionNumber, out lstInvestigationSampleResult);


        if (lstInvestigationSampleResult.Count > 0)
            foreach (InvestigationSampleResult INVSample in lstInvestigationSampleResult)
            {

                TableRow rowINVstatus = new TableRow();
                TableCell cellINVstatus = new TableCell();
                cellINVstatus.CssClass = "colorsample";
                cellINVstatus.Text = "<b>" + INVSample.Status + "</b>";
                rowINVstatus.Cells.Add(cellINVstatus);
                tblEvents.Rows.Add(rowINVstatus);
                TableRow rowINVstatusDATE = new TableRow();
                TableCell cellINVstatusDATE = new TableCell();
                cellINVstatusDATE.CssClass = "colorsample";
                cellINVstatusDATE.Text = "<b>" + INVSample.CreatedBy + "</b>";
                rowINVstatusDATE.Cells.Add(cellINVstatusDATE);
                tblDateTime.Rows.Add(rowINVstatusDATE);
                TableRow rowINVstatusUSER = new TableRow();
                TableCell cellINVstatusUSER = new TableCell();
                cellINVstatusUSER.CssClass = "colorsample";
                cellINVstatusUSER.Text = "<b>" + INVSample.LoginName + "</b>";
                rowINVstatusUSER.Cells.Add(cellINVstatusUSER);
                tblUser.Rows.Add(rowINVstatusUSER);
                TableRow rowINVstatusINV = new TableRow();
                TableCell cellINVstatusINV = new TableCell();
                cellINVstatusINV.CssClass = "colorsample";
                cellINVstatusINV.Text = "<b>" + INVSample.InvestigationName + "</b>";
                rowINVstatusINV.Cells.Add(cellINVstatusINV);
                tblINV.Rows.Add(rowINVstatusINV);

            }

    }
    protected void ddlOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLocationsCall("INV");
    }

    protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdLabTestStatReport.DataSource = null;
        grdLabTestStatReport.DataBind();
        rptSummary.DataSource = null;
        rptSummary.DataBind();
        LoadLocationsCall("TSR");
        ClearValues();
    }
    protected void ddlOrgan_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadlocations(RoleID, Convert.ToInt16(ddlOrganization.SelectedValue));
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            if (lstLocation.Count > 0)
            {
                ddlLocation.DataSource = lstLocation;
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataBind();

                ddlLocation.Items.Insert(0, strall);
                ddlLocation.Items[0].Value = "0";
                //ddlLocation1.Items[0].Selected = true;
                //ddlLocation1.SelectedItem.Value = ILocationID.ToString();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadLocation", ex);
        }
    }
    protected void ClearValues()
    {
        hdnPhysicianID.Value = "0";
        txtReferringPhysician.Text = string.Empty;
        hdnReferringHospitalID.Value = "0";
        txtReferringHospital.Text = string.Empty;
        hdnSelectedClientID.Value = "0";
        txtClient.Text = string.Empty;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public void ddlInvClientType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        txtInvClientName.Text = string.Empty;
        hdnInvSelectedClientID.Value = "0";
    }

    protected static string GetRowTotal(object NormalTestCount, object AbnormalTestCount, object CriticalTestCount,
        object UnSpecifiedTestCount, object ReTestCount, object ReflexTestCount, object DilutionTestCount, object QCTestCount,
        object ManualTestCount, object InterfacedTestCount)
    {
        Int32 dataItemResult = Convert.ToInt32(NormalTestCount.ToString()) +
            Convert.ToInt32(AbnormalTestCount.ToString()) +
            Convert.ToInt32(CriticalTestCount.ToString()) +
            Convert.ToInt32(UnSpecifiedTestCount.ToString()) +
            Convert.ToInt32(ReTestCount.ToString()) +
            Convert.ToInt32(ReflexTestCount.ToString()) +
            Convert.ToInt32(DilutionTestCount.ToString()) +
            Convert.ToInt32(QCTestCount.ToString()) +
            Convert.ToInt32(ManualTestCount.ToString()) +
            Convert.ToInt32(InterfacedTestCount.ToString());
        return dataItemResult.ToString();
    }
    protected void grdLabTestStatReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblRowTotal = (Label)e.Row.FindControl("lblRowTotal");

                Label lblNormalTestCount = (Label)e.Row.FindControl("lblNormalTestCount");
                Label lblAbnormalTestCount = (Label)e.Row.FindControl("lblAbnormalTestCount");
                Label lblCriticalTestCount = (Label)e.Row.FindControl("lblCriticalTestCount");
                Label lblUnSpecifiedTestCount = (Label)e.Row.FindControl("lblUnSpecifiedTestCount");
                Label lblReTestCount = (Label)e.Row.FindControl("lblReTestCount");
                Label lblReflexTestCount = (Label)e.Row.FindControl("lblReflexTestCount");
                Label lblDilutionTestCount = (Label)e.Row.FindControl("lblDilutionTestCount");
                Label lblQCTestCount = (Label)e.Row.FindControl("lblQCTestCount");
                Label lblManualTestCount = (Label)e.Row.FindControl("lblManualTestCount");
                Label lblInterfacedTestCount = (Label)e.Row.FindControl("lblInterfacedTestCount");

                hdnNormalTestCount.Value = (Convert.ToInt32(hdnNormalTestCount.Value) + Convert.ToInt32(lblNormalTestCount.Text)).ToString();
                hdnAbnormalTestCount.Value = (Convert.ToInt32(hdnAbnormalTestCount.Value) + Convert.ToInt32(lblAbnormalTestCount.Text)).ToString();
                hdnCriticalTestCount.Value = (Convert.ToInt32(hdnCriticalTestCount.Value) + Convert.ToInt32(lblCriticalTestCount.Text)).ToString();
                hdnUnSpecifiedTestCount.Value = (Convert.ToInt32(hdnUnSpecifiedTestCount.Value) + Convert.ToInt32(lblUnSpecifiedTestCount.Text)).ToString();
                hdnReTestCount.Value = (Convert.ToInt32(hdnReTestCount.Value) + Convert.ToInt32(lblReTestCount.Text)).ToString();
                hdnReflexTestCount.Value = (Convert.ToInt32(hdnReflexTestCount.Value) + Convert.ToInt32(lblReflexTestCount.Text)).ToString();
                hdnDilutionTestCount.Value = (Convert.ToInt32(hdnDilutionTestCount.Value) + Convert.ToInt32(lblDilutionTestCount.Text)).ToString();
                hdnQCTestCount.Value = (Convert.ToInt32(hdnQCTestCount.Value) + Convert.ToInt32(lblQCTestCount.Text)).ToString();
                hdnManualTestCount.Value = (Convert.ToInt32(hdnManualTestCount.Value) + Convert.ToInt32(lblManualTestCount.Text)).ToString();
                hdnInterfacedTestCount.Value = (Convert.ToInt32(hdnInterfacedTestCount.Value) + Convert.ToInt32(lblInterfacedTestCount.Text)).ToString();

                string TotVal = (Convert.ToInt32(hdnGrandTot.Value) + Convert.ToInt32(lblRowTotal.Text)).ToString();
                hdnGrandTot.Value = TotVal;

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblNormalTest = (Label)e.Row.FindControl("lblNormalTest");
                Label lblAbnormalTest = (Label)e.Row.FindControl("lblAbnormalTest");
                Label lblCriticalTest = (Label)e.Row.FindControl("lblCriticalTest");
                Label lblUnSpecifiedTest = (Label)e.Row.FindControl("lblUnSpecifiedTest");
                Label lblReTest = (Label)e.Row.FindControl("lblReTest");
                Label lblReflexTest = (Label)e.Row.FindControl("lblReflexTest");
                Label lblDilutionTest = (Label)e.Row.FindControl("lblDilutionTest");
                Label lblQCTest = (Label)e.Row.FindControl("lblQCTest");
                Label lblManualTest = (Label)e.Row.FindControl("lblManualTest");
                Label lblInterfacedTest = (Label)e.Row.FindControl("lblInterfacedTest");

                lblNormalTest.Text = hdnNormalTestCount.Value;
                lblAbnormalTest.Text = hdnAbnormalTestCount.Value;
                lblCriticalTest.Text = hdnCriticalTestCount.Value;
                lblUnSpecifiedTest.Text = hdnUnSpecifiedTestCount.Value;
                lblReTest.Text = hdnReTestCount.Value;
                lblReflexTest.Text = hdnReflexTestCount.Value;
                lblDilutionTest.Text = hdnDilutionTestCount.Value;
                lblQCTest.Text = hdnQCTestCount.Value;
                lblManualTest.Text = hdnManualTestCount.Value;
                lblInterfacedTest.Text = hdnInterfacedTestCount.Value;

                Label lblGrandRowTotal = (Label)e.Row.FindControl("lblGrandRowTotal");
                lblGrandRowTotal.Text = hdnGrandTot.Value;

                hdnNormalTestCount.Value = "0";
                hdnAbnormalTestCount.Value = "0";
                hdnCriticalTestCount.Value = "0";
                hdnUnSpecifiedTestCount.Value = "0";
                hdnReTestCount.Value = "0";
                hdnReflexTestCount.Value = "0";
                hdnDilutionTestCount.Value = "0";
                hdnQCTestCount.Value = "0";
                hdnManualTestCount.Value = "0";
                hdnInterfacedTestCount.Value = "0";
                hdnGrandTot.Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in test status Report  Grid", ex);
        }
    }
    protected void grouptab_ActiveTabChanged(object sender, EventArgs e)
    {
        Export_XL.Attributes.Add("Style", "display:none");
        if (grouptab.ActiveTabIndex == 1)
        {
            gvDuplicate2.DataSource = null;
            gvDuplicate2.DataBind();
            gvDuplicate1.DataSource = null;
            gvDuplicate1.DataBind();
            gvTestStatusReport.DataSource = null;
            gvTestStatusReport.DataBind();
            GrdFooter.Style.Add("display", "none");
            divTestStatReport.Style.Add("display", "block");
            pnlSummary.Style.Add("display", "block");
            Export_XL.Attributes.Add("Style", "display:block");
        }
        else
        {
            grdLabTestStatReport.DataSource = null;
            grdLabTestStatReport.DataBind();
            divTestStatReport.Style.Add("display", "none");
            pnlSummary.Style.Add("display", "none");
            Export_XL.Attributes.Add("Style", "display:block");
        }
    }
}