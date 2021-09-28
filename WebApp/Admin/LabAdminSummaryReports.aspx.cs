using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Linq;
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

public partial class Admin_LabAdminSummaryReports : BasePage
{
    public Admin_LabAdminSummaryReports()
        : base("Admin_LabAdminSummaryReports_aspx")
    {
    }

    long returnCode = 0;
    decimal GrandTotal = 0;
    decimal TotalCashAmount = 0;
    decimal TotalDiscountAmount = 0;
    decimal TotalPaidAmount = 0;
    decimal TotalDuePaidAmount = 0;
    decimal CombinedDeptAmount = 0;
    string concatenateDate = string.Empty;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    List<DailyReport> billSearch = new List<DailyReport>();
    List<BillLineItems> billItems = new List<BillLineItems>();
    List<DailyReport> lDailyReport = new List<DailyReport>();
    List<LabConsumables> lstLabConsumables = new List<LabConsumables>();

    List<DailyReport> lstDoctorWiseReport = new List<DailyReport>();
    List<DailyReport> lstDisplayName = new List<DailyReport>();

    string ddlSelectedText;
    int ReportFormatId = 0;
    string DisplayName;
    long deptID = 0;
    string select = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_01 == null ? "----select-----" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_01;
    string All = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_02 == null ? "All" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_02;
    string Doctorname = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_03 == null ? "Doctor Name : " : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_03;
    string Hospitalname = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_04 == null ? "Hospital Name : " : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_04;
    string Clientname = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_05 == null ? "Client Name : " : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_05;
    string Dr = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_06 == null ? "Dr. " : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_06;
    string Dprt = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_07 == null ? "Department Name : " : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_07;
    string Norcrd = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_08 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_08;
    string collection = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_09 == null ? "Collection Summary for -" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_09;
    string alldprt = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_10 == null ? "All Departments" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_10;   
    
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
  
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        patientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        if (txtFrom.Text == txtTo.Text)
        {
            concatenateDate = txtFrom.Text;
        }
        else
        {
            concatenateDate = " (" + txtFrom.Text + " - " + txtTo.Text+")";
        }
       
        if (!IsPostBack)
        {
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();
            List<CollectionCentreMaster> getCollectionCentre = new List<CollectionCentreMaster>();
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            List<LabSummaryReportParameter> getLabSummaryReportParameter = new List<LabSummaryReportParameter>();
            List<InvDeptMaster> lDeptmaster = new List<InvDeptMaster>();
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            trDoctor.Style.Add("display", "none");
            flagSetter.Value = "1";
            new Patient_BL(base.ContextInfo).GetSummaryReportData(OrgID, out getInvClientMaster, out getReferingPhysician,
                                                    out getCollectionCentre, out RefOrg,
                                                    out lstInvestigation, out getLabSummaryReportParameter,
                                                    out lDeptmaster);
            LoadInvClientMaster(getInvClientMaster);
            LoadReferingPhysician(getReferingPhysician);
            LoadCollectionCentre(getCollectionCentre);
            LoadHospital(RefOrg);
            LoadBranch(RefOrg);
            LoadInsurance(lstInvestigation);
            LoadSummaryReportParameter(getLabSummaryReportParameter);
            LoadInvestigationDepartment(lDeptmaster);
            LoadUserList();
            LoadOrgan();
            LoadMeatData();
        }
        if (flagSetter.Value == "1")
        {
            trDoctor.Style.Add("display", "none");
            trUsers.Style.Add("display", "none");
            trDept.Style.Add("display", "none");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "none");
        }
        else if (flagSetter.Value == "2")
        {
             
            trDoctor.Style.Add("display", "block");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "none");

        }
        else if (flagSetter.Value == "3")
        {
            
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "block");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "none");
        }
        else if (flagSetter.Value == "4")
        {
             
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "block");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "none");
        }
        else if (flagSetter.Value == "5")
        {
            
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "block");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "none");
        }
        else if (flagSetter.Value == "6")
        {
            
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "block");
            trDept.Style.Add("display", "none");
        }
        else if (flagSetter.Value == "7")
        {
             
            trDoctor.Style.Add("display", "none");
            trHospital.Style.Add("display", "none");
            trCC.Style.Add("display", "none");
            trINS.Style.Add("display", "none");
            trBranch.Style.Add("display", "none");
            trDept.Style.Add("display", "block");
        }


        if (ddlDept.SelectedValue == "0" && rblReportType.SelectedValue == "1")
        {
            tdchkSplitUp.Style.Add("display", "block");
        }
        else
        {
            tdchkSplitUp.Style.Add("display", "none");
        }

    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    public void LoadReferingPhysician(List<ReferingPhysician> getReferingPhysician)
    {
        try
        {
            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();
            //retCode = patBL.GetReferingPhysician(OrgID, "", "D", out getReferingPhysician);
            if (getReferingPhysician.Count > 0)
            {
                ddlPhysician.DataSource = getReferingPhysician;
                ddlPhysician.DataTextField = "PhysicianName";
                ddlPhysician.DataValueField = "ReferingPhysicianID";
                ddlPhysician.DataBind();
            }
            //ddlPhysician.Items.Insert(0, "-----Select-----");
            ddlPhysician.Items.Insert(0, select);
            ddlPhysician.Items[0].Value = "0";
            //ddlPhysician.Items.Insert(1, "All");
            ddlPhysician.Items.Insert(1, All);
            ddlPhysician.Items[1].Value = "1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Physician Details.", ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void LoadInvClientMaster(List<InvClientMaster> getInvClientMaster)
    {
        try
        {

            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID,"", out getInvClientMaster);
            if (getInvClientMaster.Count > 0)
            {
                ddlClient.DataSource = getInvClientMaster;
                ddlClient.DataTextField = "ClientName";
                ddlClient.DataValueField = "ClientID";
                ddlClient.DataBind();
                ddlClient.Items.Remove((ddlClient.Items.FindByText("OutPatient")));
                ddlClient.Items.Remove((ddlClient.Items.FindByText("Collection Centre")));
            }
           // ddlClient.Items.Insert(0, "-----Select-----");
            ddlClient.Items.Insert(0, select);
            ddlClient.Items[0].Value = "0";
           // ddlClient.Items.Insert(1, "All");
            ddlClient.Items.Insert(1, All);
            ddlClient.Items[1].Value = "1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvClientMaster Details.", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    public void LoadHospital(List<LabReferenceOrg> RefOrg)
    {
        try
        {
            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0,"", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (RefOrg.Count > 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgName";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();

            }
            //ddlHospital.Items.Insert(0, "-----Select-----");
            ddlHospital.Items.Insert(0, select);
            ddlHospital.Items[0].Value = "0";
            //ddlHospital.Items.Insert(1, "All");
            ddlHospital.Items.Insert(1,All );
            ddlHospital.Items[1].Value = "1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    public void LoadBranch(List<LabReferenceOrg> RefOrg)
    {
        try
        {
            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Branch = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, "",out RefOrg);
            Branch = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 2; });
            if (RefOrg.Count > 0)
            {
                ddlBranch.DataSource = Branch;
                ddlBranch.DataTextField = "RefOrgName";
                ddlBranch.DataValueField = "LabRefOrgID";
                ddlBranch.DataBind();

            } 
            //ddlBranch.Items.Insert(0, "-----Select-----");
            ddlBranch.Items.Insert(0, select);
            ddlBranch.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Branch Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    public void LoadCollectionCentre(List<CollectionCentreMaster> getCollectionCentre)
    {
        try
        {
            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<CollectionCentreMaster> getCollectionCentre = new List<CollectionCentreMaster>();
            //retCode = patBL.GetCollectionCentre(OrgID, out getCollectionCentre);
            if (getCollectionCentre.Count > 0)
            {
                ddlCollectionCentre.DataSource = getCollectionCentre;
                ddlCollectionCentre.DataTextField = "CollectionCentreName";
                ddlCollectionCentre.DataValueField = "CollectionCentreID";
                ddlCollectionCentre.DataBind();

            }
            //ddlCollectionCentre.Items.Insert(0, "-----Select-----");
            ddlCollectionCentre.Items.Insert(0, select);
            ddlCollectionCentre.Items[0].Value = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Collection Centre Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }
    public void LoadInsurance(List<PatientInvestigation> lstInvestigation)
    {
        try
        {
            //long retCode = -1;
            //Investigation_BL investigationBL = new Investigation_BL();
            //List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            //retCode = investigationBL.GetInvestigationByClientID(OrgID, 0, "INS", out lstInvestigation);
            if (lstInvestigation.Count > 0)
            {
                ddlInsurance.DataSource = lstInvestigation;
                ddlInsurance.DataTextField = "GroupName";
                ddlInsurance.DataValueField = "GroupID";
                ddlInsurance.DataBind();

            }
            //ddlInsurance.Items.Insert(0, "-----Select-----");
            ddlInsurance.Items.Insert(0, select);
            ddlInsurance.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Insurance Details", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }

    protected void ddlClient_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        deptwiseCollectionTab.Visible = false;
        TableRow tr = null;
        TableCell tc1 = null;
        TableCell tc2 = null;
        decimal miscellaneousTotal = 0;
        int clientID = -1;
        int collectionCentreID = -1;
        DateTime strBillFromDate;
        int ReferingPhysicianID = -1;
        long HospitalID = -1;
        int InsuranceID = -1;
        DateTime strBillToDate;
        long userID = -1;

        userID = Convert.ToInt64(ddlUsers.SelectedValue);
        if (ddlClient.SelectedValue != "0")
        {
            clientID = Convert.ToInt32(ddlClient.SelectedValue);
        }
        if (ddlHospital.SelectedValue != "0")
        {
            HospitalID = Convert.ToInt64(ddlHospital.SelectedValue);
        }
        if (ddlPhysician.SelectedValue != "0")
        {
            ReferingPhysicianID = Convert.ToInt32(ddlPhysician.SelectedValue);
        }
        if (ddlCollectionCentre.SelectedValue != "0")
        {
            collectionCentreID = Convert.ToInt32(ddlCollectionCentre.SelectedValue);
        }
        if (ddlInsurance.SelectedValue != "0")
        {
            InsuranceID = Convert.ToInt32(ddlInsurance.SelectedValue);
        }
        if (ddlBranch.SelectedValue != "0")
        {
            HospitalID = Convert.ToInt32(ddlBranch.SelectedValue);
        }

        if (ddlPhysician.SelectedItem.Value == "1" && rblReportType.SelectedValue == "1")
        {
            ddlSelectedText = ddlPhysician.SelectedItem.Value;
            ReportFormatId = 7;
        }

        if (ddlHospital.SelectedItem.Value == "1" && rblReportType.SelectedValue == "1")
        {
            ddlSelectedText = ddlHospital.SelectedItem.Value;
            ReportFormatId = 8;
        }
        if (ddlClient.SelectedItem.Value == "1" && rblReportType.SelectedValue == "1")
        {
            ddlSelectedText = ddlClient.SelectedItem.Value;
            ReportFormatId = 9;
        }

        if (ddlPhysician.SelectedItem.Value != "1" && rblReportType.SelectedValue == "2" && ddlPhysician.SelectedValue != "0")
        {
            ddlSelectedText = ddlPhysician.SelectedItem.Value;
            ReportFormatId = 1;
            //DisplayName = "Doctor Name : " + " Dr.";
            DisplayName = Doctorname + Dr;

        }
        if (ddlHospital.SelectedItem.Value != "1" && rblReportType.SelectedValue == "2" && ddlHospital.SelectedValue != "0")
        {
            ddlSelectedText = ddlHospital.SelectedItem.Value;
            ReportFormatId = 2;
            //DisplayName = "Hospital Name : ";
            DisplayName = Hospitalname;

        }
        if (ddlClient.SelectedItem.Value != "1" && rblReportType.SelectedValue == "2" && ddlClient.SelectedValue != "0")
        {
            ddlSelectedText = ddlClient.SelectedItem.Value;
            ReportFormatId = 3;
           // DisplayName = "Client Name : ";
            DisplayName = Clientname;

        }

        if (ddlPhysician.SelectedItem.Value == "1" && rblReportType.SelectedValue == "2" && ddlPhysician.SelectedValue == "1" && flagSetter.Value == "2")
        {
            ddlSelectedText = ddlPhysician.SelectedItem.Text;
            ReportFormatId = 1;

        }

        if (ddlHospital.SelectedItem.Value == "1" && rblReportType.SelectedValue == "2" && ddlHospital.SelectedValue != "0")
        {
            ddlSelectedText = ddlHospital.SelectedItem.Value;
            ReportFormatId = 2;

        }

        if (ddlClient.SelectedItem.Value == "1" && rblReportType.SelectedValue == "2" && ddlClient.SelectedValue != "0")
        {
            ddlSelectedText = ddlClient.SelectedItem.Value;
            ReportFormatId = 3;

        }

        if (ddlDept.SelectedItem.Value == "1" && rblReportType.SelectedValue == "2"  && ddlDept.SelectedValue != "-1")
        {
            ddlSelectedText = "1";
            ReportFormatId = 4;
        }

        if (ddlDept.SelectedItem.Value != "1" && rblReportType.SelectedValue == "2" && ddlDept.SelectedValue != "-1")
        {
            ddlSelectedText = ddlDept.SelectedItem.Value;
            ReportFormatId = 5;
            //DisplayName = "Department Name : ";
            DisplayName = Dprt;
        }
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        patientVisit_BL.GetLocation(OrgID,LID,0, out lstOrganizationAddress);
 
        if (ddlDept.SelectedValue != "-1" && rblReportType.SelectedValue == "1")
        {
            orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
            dateTextForReport.InnerHtml = collection + concatenateDate;
            strBillFromDate = Convert.ToDateTime(txtFrom.Text);
            strBillToDate = Convert.ToDateTime(txtTo.Text);
            deptID = Convert.ToInt64(ddlDept.SelectedValue);
            List<DailyReport> lDeptName = new List<DailyReport>();
            int splitUp = 1;
            if (chkSplitUp.Checked)
            {
                splitUp = 1;
            }
            else
            {
                splitUp = 0;
            }

            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            new Patient_BL(base.ContextInfo).GetDeptwiseReport(userID,deptID, strBillFromDate, strBillToDate, OrgID, splitUp, out lDailyReport, out lDeptName, out lstLabConsumables, out GrandTotal, out TotalCashAmount, out TotalDiscountAmount, out TotalPaidAmount, out TotalDuePaidAmount, out CombinedDeptAmount);
            if (lDeptName.Count > 0)
            {
                grdCollection.Visible = true;
                grdCollection.DataSource = lDeptName;
                grdCollection.DataBind();
                hypLnkPrint.Visible = true;
                deptwiseCollectionTab.Visible = true;
                btnPrint.Visible = false;
                hypLnkPrint.Enabled = true;
                lblPrintExportExcel.Visible = true;

                lblResult.Text = "";
                printText.Visible = true;
                grdResult.Visible = false;
                lblGrandTotal.InnerText = String.Format("{0:0.00}", (GrandTotal));
                tblDoctorWisereport.Style.Add("display", "none");
                gvDoctorWiseReport.Visible = false;
                grdDoctorsResult.Visible = false;
                lblName.Text = "";
                lblDoctorName.Text = "";
                lbExcel.Visible = true;
                btnConverttoXL.Visible = true;

                if (lstLabConsumables.Count > 0)
                {
                    consumableTab.Visible = true;
                    miscellaneousTotalTab.Visible = true;
                    tr = new TableRow();
                    tc1 = new TableCell();
                    tc1.Width = Unit.Percentage(80);
                    tc1.Text = "Miscellaneous";
                    tc1.Attributes.Add("align", "center");
                    tr.Cells.Add(tc1);
                    tc2 = new TableCell();
                    tc2.Width = Unit.Percentage(20);
                    tc2.Text = "Amount";
                    tc2.Attributes.Add("align", "right");
                    tr.Cells.Add(tc2);
                    tr.Height = 15;
                    tr.CssClass = "Duecolor";
                    //tr.Style.Add("background-color", "#");
                    //tr.Style.Add("color", "#ffffff");
                    tr.Style.Add("font-weight", "bold");
                    consumableTab.Rows.Add(tr);
                    foreach (LabConsumables objLC in lstLabConsumables)
                    {
                        tr = new TableRow();
                        tc1 = new TableCell();
                        tc1.Width = Unit.Percentage(80);
                        tc1.Text = objLC.ConsumableName;
                        tc1.Attributes.Add("align", "center");
                        tr.Cells.Add(tc1);
                        tc2 = new TableCell();
                        tc2.Width = Unit.Percentage(20);
                        tc2.Text = String.Format("{0:0.00}", objLC.Rate);
                        tc2.Attributes.Add("align", "right");
                        tr.Cells.Add(tc2);
                        tr.Height = 20;
                        consumableTab.Rows.Add(tr);
                        miscellaneousTotal += objLC.Rate;
                    }
                    lblMiscellaneousTotal.InnerText = String.Format("{0:0.00}", miscellaneousTotal);
                }
                else
                {
                    consumableTab.Visible = false;
                    miscellaneousTotalTab.Visible = false;
                }
                if (deptID == 1)
                {
                    combinedDeptCollectionTab.Visible = true;
                    individualDeptCollectionTab.Visible = true;
                    lblIndividualDeptCollection.InnerText = String.Format("{0:0.00}", GrandTotal);
                    lblCombinedDeptCollection.InnerText = String.Format("{0:0.00}", CombinedDeptAmount);
                    lblGrandTotal.InnerText = String.Format("{0:0.00}", (CombinedDeptAmount + GrandTotal + miscellaneousTotal));
                }
                else
                {
                    combinedDeptCollectionTab.Visible = false;
                    individualDeptCollectionTab.Visible = false;
                    consumableTab.Visible = false;
                    miscellaneousTotalTab.Visible = false;
                }

                tabGranTotal1.Visible = true;
                if (deptID == 1)
                {
                    lblCollectionAmount.InnerText = String.Format("{0:0.00}", TotalCashAmount);
                    lblDiscountAmount.InnerText = String.Format("{0:0.00}", TotalDiscountAmount);
                    lblCashAmount.InnerText = String.Format("{0:0.00}", TotalPaidAmount);
                    lblDuePaidAmount.InnerText = String.Format("{0:0.00}", TotalDuePaidAmount);
                    lblDueAmount.InnerText = String.Format("{0:0.00}", ((TotalCashAmount) - (TotalDiscountAmount + TotalPaidAmount)));
                    lblGrandTotalAmount.InnerText = String.Format("{0:0.00}", (TotalPaidAmount + TotalDuePaidAmount));
                    tabGranTotal2.Visible = false;
                }
                else
                {
                    tabGranTotal2.Visible = false;
                }

            }
            else
            {
                tabGranTotal2.Visible = false;
                tabGranTotal1.Visible = false;
                individualDeptCollectionTab.Visible = false;
                combinedDeptCollectionTab.Visible = false;
                consumableTab.Visible = false;
                miscellaneousTotalTab.Visible = false;
                grdCollection.Visible = false;
                lblResult.Visible = true;
                lblResult.Visible = true;
                btnPrint.Visible = false;
                hypLnkPrint.Visible = false;
                deptwiseCollectionTab.Visible = false;
               
                //lblResult.Text = "No Matching Records Found!";
                lblResult.Text = Norcrd;
                orgHeaderTextForReport.InnerText = "";
                dateTextForReport.InnerText = "";
                printText.Visible = false;
                tblDoctorWisereport.Style.Add("display", "none");
                gvDoctorWiseReport.Visible = false;
                grdResult.Visible = false;
                grdDoctorsResult.Visible = false;
                lblName.Text = "";
                lblDoctorName.Text = "";
            }
            hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + flagSetter + "&RepFmt=" + "DR" + "&AllDr=" + "No" + "&deptID=" + deptID + "&splitUp=" + splitUp +"&userID=" + userID;
        }
        else
        {

            int flag = Convert.ToInt16(flagSetter.Value);
            strBillFromDate = Convert.ToDateTime(txtFrom.Text);
            strBillToDate = Convert.ToDateTime(txtTo.Text);
            long returnCode = -1;

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            try
            {
                if (rblReportType.SelectedValue == "1" && ddlDept.SelectedValue == "-1")
                {
                    if (ddlTrustedOrg.Items.Count > 0)
                        OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                    returnCode = patientBL.SearchBillByParameter(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, out billSearch, out billItems, out GrandTotal);

                    //Vijayalakshmi.M
                    if (billSearch.Count > 0)
                    {
                        for (int i = 0; i < billSearch.Count; i++)
                        {
                            if (billSearch[i].Age != "" && billSearch[i].Age != null)
                            {
                                string str = billSearch[i].Age;
                                string[] strage = str.Split(' ');
                                if (strage[1] == "Year(s)")
                                {
                                    billSearch[i].Age = strage[0] + " " + strYear;
                                }
                                else if (strage[1] == "Month(s)")
                                {
                                    billSearch[i].Age = strage[0] + " " + strMonth;
                                }
                                else if (strage[2] == "Day(s)")
                                {
                                    billSearch[i].Age = strage[0] + " " + strDay;
                                }
                                else if (strage[2] == "Week(s)")
                                {
                                    billSearch[i].Age = strage[0] + " " + strWeek;
                                }
                                else
                                {
                                    billSearch[i].Age = strage[0] + " " + strYear;
                                }
                            }
                        }
                    }
                    //End
                    if (returnCode == 0 && billSearch.Count > 0)
                    {
                        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                        dateTextForReport.InnerHtml = collection + concatenateDate;
                        lblGrandTotal.InnerText = String.Format("{0:0.00}", GrandTotal);
                        tabGranTotal1.Visible = true;
                        tabGranTotal2.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdResult.Visible = true;
                        lblResult.Visible = false;
                        hypLnkPrint.Visible = true;
                        btnPrint.Visible = false;
                        btnConverttoXL.Visible = true;
                        lbExcel.Visible = true;                        
                        lblPrintExportExcel.Visible = true;
                        
                        lblResult.Text = "";
                        printText.Visible = true;
                        grdResult.DataSource = billSearch;
                        grdResult.DataBind();
                        grdCollection.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;
                        grdDoctorsResult.Visible = false;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                        hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + flag + "&RepFmt=" + "DR" + "&AllDr=" + "No" + "&deptID=" + deptID;
                    }
                    else
                    {
                        orgHeaderTextForReport.InnerText = "";
                        dateTextForReport.InnerText = "";
                        grdDoctorsResult.Visible = false;
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        printText.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = true;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                    
                        grdCollection.Visible = false;
                        orgHeaderTextForReport.InnerText = "";
                        dateTextForReport.InnerText = "";
                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;
                        //lblResult.Text = "No Matching Records Found!";
                        lblResult.Text =Norcrd;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                    }
                }

                else
                {
                    if (rblReportType.SelectedValue == "1" && ddlSelectedText == "1" && ddlDept.SelectedValue == "1")
                    {
                        flag = ReportFormatId;
                        if (ddlTrustedOrg.Items.Count > 0)
                            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                        returnCode = patientBL.SearchBillByParameter(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, flag, out billSearch, out billItems, out GrandTotal);

                        if (returnCode == 0 && billSearch.Count > 0)
                        {
                            orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                            dateTextForReport.InnerHtml = collection + concatenateDate;
                            lblGrandTotal.InnerText = String.Format("{0:0.00}", GrandTotal);
                            tabGranTotal1.Visible = true;
                            grdResult.Visible = true;
                            lblResult.Visible = false;
                            hypLnkPrint.Visible = true;
                            btnPrint.Visible = false;
                            btnConverttoXL.Visible = true;
                            lbExcel.Visible = true;
                            lblPrintExportExcel.Visible = true;

                            lblResult.Text = "";
                            printText.Visible = true;
                            grdResult.DataSource = billSearch;
                            grdResult.DataBind();
                            grdCollection.Visible = false;
                            tblDoctorWisereport.Style.Add("display", "none");
                            gvDoctorWiseReport.Visible = false;
                            grdDoctorsResult.Visible = false;
                            tabGranTotal2.Visible = false;
                            individualDeptCollectionTab.Visible = false;
                            combinedDeptCollectionTab.Visible = false;
                            consumableTab.Visible = false;
                            miscellaneousTotalTab.Visible = false;
                            lblName.Text = "";
                            lblDoctorName.Text = "";
                            hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + flag + "&RepFmt=" + "DR" + "&AllDr=" + "No" + "&deptID=" + deptID;
                        }
                        else
                        {
                            tblDoctorWisereport.Style.Add("display", "none");
                            gvDoctorWiseReport.Visible = false;
                            orgHeaderTextForReport.InnerText = "";
                            dateTextForReport.InnerText = "";
                            tabGranTotal2.Visible = false;
                            tabGranTotal1.Visible = false;
                            individualDeptCollectionTab.Visible = false;
                            combinedDeptCollectionTab.Visible = false;
                            consumableTab.Visible = false;
                            miscellaneousTotalTab.Visible = false;
                            grdDoctorsResult.Visible = false;
                            printText.Visible = false;
                            grdResult.Visible = false;
                            lblResult.Visible = true;
                            hypLnkPrint.Visible = false;
                            btnPrint.Visible = false;
                           
                            grdCollection.Visible = false;
                            lblName.Text = "";
                            lblDoctorName.Text = "";
                            //lblResult.Text = "No Matching Records Found!";
                            lblResult.Text = Norcrd;
                        }
                    }
                }

                if (rblReportType.SelectedValue == "2" && ddlSelectedText != "1" && ddlDept.SelectedValue == "-1")
                {
                    if (ddlTrustedOrg.Items.Count > 0)
                        OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, ReportFormatId, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                        dateTextForReport.InnerHtml = collection + concatenateDate;
                            

                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                        lbExcel.Visible = false;
                        btnConverttoXL.Visible = false;
                        lblPrintExportExcel.Visible = false;
                        lblResult.Text = "";
                        printText.Visible = true;
                        grdCollection.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.Visible = true;
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        if (flag == 1)
                        {
                            lblName.Text = DisplayName;
                            lblDoctorName.Text = lstDisplayName[0].ClientName;


                        }
                        if (flag == 2)
                        {
                            lblName.Text = DisplayName;
                            lblDoctorName.Text = lstDisplayName[0].ReferingPhysicianName + " " + lstDisplayName[0].Qualification;

                        }
                        if (flag == 3)
                        {
                            lblName.Text = DisplayName;
                            lblDoctorName.Text = lstDisplayName[0].HospitalName;

                        }

                        hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + ReportFormatId + "&RepFmt=" + "SR" + "&AllDr=" + "No" + "&deptID=" + deptID;
                    }
                    else
                    {
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;
                        orgHeaderTextForReport.InnerText = "";
                        dateTextForReport.InnerText = "";
                        tabGranTotal1.Visible = false;
                        printText.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = true;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                      
                        grdCollection.Visible = false;
                        //lblResult.Text = "No Matching Records Found!";
                        lblResult.Text = Norcrd;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                    }
                }



                if (ddlSelectedText == "1" && rblReportType.SelectedValue == "2" && ddlDept.SelectedValue == "-1")
                {
                    if (ddlTrustedOrg.Items.Count > 0)
                        OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                    returnCode = patientBL.GetAllDoctorReport(strBillFromDate, strBillToDate, OrgID, ReportFormatId, out lstDoctorWiseReport, out lstDisplayName);


                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                        dateTextForReport.InnerHtml = collection + concatenateDate;
                            
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;

                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;

                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        hypLnkPrint.Visible = true;
                        btnPrint.Visible = false;
                      
                        lblResult.Text = "";
                        printText.Visible = true;
                        grdCollection.Visible = false;

                        grdDoctorsResult.Visible = true;
                        grdDoctorsResult.DataSource = lstDisplayName;
                        grdDoctorsResult.DataBind();
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                        hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + ReportFormatId + "&RepFmt=" + "SR" + "&AllDr=" + "Yes" + "&deptID=" + deptID;
                       
                        btnPrint.Visible = false;
                        btnConverttoXL.Visible = false;
                        lbExcel.Visible = false;
                        lblPrintExportExcel.Visible = false;
                    }

                    else
                    {
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;
                        grdDoctorsResult.Visible = false;

                        printText.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = true;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                      
                        grdCollection.Visible = false;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                        lblResult.Text = Norcrd;
                        lbExcel.Visible = false;
                        btnConverttoXL.Visible = false;
                    }
                }


                if (ddlSelectedText == "1" && rblReportType.SelectedValue == "2" && ddlDept.SelectedValue != "-1")
                {
                    if (ddlTrustedOrg.Items.Count > 0)
                        OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                    deptID = Convert.ToInt64(ddlDept.SelectedValue);
                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, ReportFormatId, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                        dateTextForReport.InnerHtml = collection + concatenateDate;
                            
                        lblName.Text = alldprt;
                        lblDoctorName.Text = "";

                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        gvDoctorWiseReport.Visible = true;


                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                        trClient.Visible = false;
                        btnConverttoXL.Visible = false;
                        lbExcel.Visible = false;

                        lblResult.Text = "";
                        printText.Visible = true;
                        grdCollection.Visible = false;
                        grdDoctorsResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.Visible = true;
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + ReportFormatId + "&RepFmt=" + "SR" + "&AllDr=" + "Yes" + "&deptID=" + deptID;
                    }
                    else
                    {
                        tblDoctorWisereport.Style.Add("display", "none");
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        gvDoctorWiseReport.Visible = false;

                        printText.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = true;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                      
                        grdCollection.Visible = false;
                        grdDoctorsResult.Visible = false;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                        lblResult.Text = Norcrd;
                        lbExcel.Visible = false;
                        btnConverttoXL.Visible = false;
                    }
                }





                if (ddlSelectedText != "1" && rblReportType.SelectedValue == "2" && ddlDept.SelectedValue != "-1")
                {

                    deptID = Convert.ToInt64(ddlDept.SelectedValue);
                    returnCode = patientBL.GetDoctorWiseReport(strBillFromDate, strBillToDate, ReferingPhysicianID, HospitalID, clientID, collectionCentreID, InsuranceID, OrgID, ReportFormatId, deptID, out lstDoctorWiseReport, out lstDisplayName);
                    if (returnCode == 0 && lstDoctorWiseReport.Count > 0)
                    {
                        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font> <br/> " + lstOrganizationAddress[0].Location;
                        dateTextForReport.InnerHtml = collection + concatenateDate;
                            
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        gvDoctorWiseReport.Visible = true;
                        trClient.Visible = false;

                        grdResult.Visible = false;
                        lblResult.Visible = false;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                        lblPrintExportExcel.Visible = false;
                        lblResult.Text = "";
                        printText.Visible = true;
                        grdCollection.Visible = false;
                        grdDoctorsResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "Block");
                        gvDoctorWiseReport.DataSource = lstDoctorWiseReport;
                        gvDoctorWiseReport.DataBind();
                        lbExcel.Visible = false;
                        btnConverttoXL.Visible = false;
                        if (flag == 7)
                        {
                            lblName.Text = DisplayName;
                            lblDoctorName.Text = lstDisplayName[0].DeptName;

                        }
                        hypLnkPrint.NavigateUrl = "LabAdminSummaryReportsPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&refPhyID=" + ReferingPhysicianID + "&hpid=" + HospitalID + "&cid=" + clientID + "&ccid=" + collectionCentreID + "&INSid=" + InsuranceID + "&flag=" + ReportFormatId + "&RepFmt=" + "SR" + "&AllDr=" + "No" + "&deptID=" + deptID;
                    }
                    else
                    {
                        tabGranTotal2.Visible = false;
                        tabGranTotal1.Visible = false;
                        individualDeptCollectionTab.Visible = false;
                        combinedDeptCollectionTab.Visible = false;
                        consumableTab.Visible = false;
                        miscellaneousTotalTab.Visible = false;
                        grdDoctorsResult.Visible = false;
                        tblDoctorWisereport.Style.Add("display", "none");
                        gvDoctorWiseReport.Visible = false;
                        trClient.Visible = false;
                        

                        printText.Visible = false;
                        grdResult.Visible = false;
                        lblResult.Visible = true;
                        hypLnkPrint.Visible = false;
                        btnPrint.Visible = false;
                      
                        grdCollection.Visible = false;
                        grdDoctorsResult.Visible = false;
                        //lblResult.Text = "No Matching Records Found!";
                        lblResult.Text = Norcrd;
                        lblName.Text = "";
                        lblDoctorName.Text = "";
                        lbExcel.Visible = false;
                        btnConverttoXL.Visible = false;
                    }
                }

                
            }


            catch (Exception ex)
            {
                CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
              //  ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            }
        }

    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }

    protected void grdCollection_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdCollection.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DailyReport BMaster = (DailyReport)e.Row.DataItem;
                var childItems = from child in billItems
                                 where child.BillID == BMaster.BillID
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }


    protected void grdCollection_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            DailyReport eDailyReport = (DailyReport)e.Row.DataItem;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var item = from child in lDailyReport
                           //group child by child.BillDate into grp
                           where child.DeptID == eDailyReport.DeptID 
                           select child;
                GridView childGrid = (GridView)e.Row.FindControl("grdCollectionDetail");
                childGrid.DataSource = item.ToList<DailyReport>();
                childGrid.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
           // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    //protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = grdResult.SelectedRow;
    //}
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    //protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdResult.PageIndex = e.NewPageIndex;
    //        btnGo_Click(sender, e);
    //    }
    //}
    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        //export to excel
        string attachment = "attachment; filename=Reports.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

        //grdResult.RenderControl(oHtmlTextWriter);
        tdprintContent.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();

    }
    public override bool EnableEventValidation
    {
        get
        { return false; }
        set { base.EnableEventValidation = value; }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        
        
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.RawUrl, false);          

            
           // Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void LoadSummaryReportParameter(List<LabSummaryReportParameter> getLabSummaryReportParameter)
    {
        try
        {

            //long retCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<LabSummaryReportParameter> getLabSummaryReportParameter = new List<LabSummaryReportParameter>();
            //retCode = patBL.GetLabSummaryReportParameter(OrgID, out getLabSummaryReportParameter);
            if (getLabSummaryReportParameter.Count > 0)
            {
                ddlSummaryReportParameter.DataSource = getLabSummaryReportParameter;
                ddlSummaryReportParameter.DataTextField = "ParameterName";
                ddlSummaryReportParameter.DataValueField = "ParameterValue";
                ddlSummaryReportParameter.DataBind();
            }
            ddlSummaryReportParameter.Items.Insert(0, select);
            ddlSummaryReportParameter.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabSummaryReportParameter Details.", ex);
          //  ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }


    public void LoadInvestigationDepartment(List<InvDeptMaster> lDeptmaster)
    {
        try
        {
            //long returnCode = -1;
            //List<InvDeptMaster> lDeptmaster=new List<InvDeptMaster>();
            //returnCode = new Patient_BL(base.ContextInfo).GetInvDepartment(OrgID, out lDeptmaster);
            if (lDeptmaster.Count > 0)
            {
                ddlDept.DataSource = lDeptmaster;
                ddlDept.DataTextField = "DeptName";
                ddlDept.DataValueField = "DeptID";
                ddlDept.DataBind();
                ddlDept.Items.Insert(1, All);
                ddlDept.Items[1].Value = "1";
            }

            ddlDept.Items.Insert(0, select);
            ddlDept.Items[0].Value = "-1";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabSummaryReportParameter Details.", ex);
           // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }



    protected void grdDoctorsResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdDoctorsResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }

    protected void grdDoctorsResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DailyReport ReportId = (DailyReport)e.Row.DataItem;

                var childItems = from child in lstDoctorWiseReport
                                 where child.ID == ReportId.ID
                                 select child;

                GridView ChildGrd = (GridView)e.Row.FindControl("gvChildDoctorsResult");
                ChildGrd.DataSource = childItems;
                ChildGrd.DataBind();
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DoctorsReport Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    public void LoadUserList()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<Attune.Podium.BusinessEntities.Login> getUsersList = new List<Attune.Podium.BusinessEntities.Login>();
            retCode = patBL.LoadUserList(OrgID, out getUsersList);
            ddlUsers.DataSource = getUsersList;
            ddlUsers.DataTextField = "LoginName";
            ddlUsers.DataValueField = "LoginID";
            ddlUsers.DataBind();
            ddlUsers.Items.Insert(0, All);
            ddlUsers.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load User details in Summary Report", ex);
        }
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
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "summaryreport";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "summaryreport"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblReportType.DataSource = childItems;
                    rblReportType.DataTextField = "DisplayText";
                    rblReportType.DataValueField = "Code";
                    rblReportType.DataBind();




                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    
}
