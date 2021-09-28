using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.BillingEngine;

public partial class Reports_TestWiseReportForLIMS : BasePage
{
    public Reports_TestWiseReportForLIMS()
        : base("Reports_TestWiseReportForLIMS_aspx")
    {
    }

    List<InvLimsReport> lstLimsReport = new List<InvLimsReport>();
    int count = 0;
    string vType = string.Empty;
    string All = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03 == null ? "All" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03;
    string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            if (!IsPostBack)
            {
                LoadOrgan();
                loadlocations(RoleID, OrgID);
                GetClientType();
                LoadFeeType();
                txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                LoadDepartement();
                LoadInvSampleMaster();

            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading page Details LabReports/TestWiseStatReport", Ex);
        }
    }

    private void LoadFeeType()
    {
        try
        {
            long returnCode = -1;
            List<FeeTypeMaster> lstFTM = new List<FeeTypeMaster>();

            returnCode = new BillingEngine(base.ContextInfo).GetFeeType(OrgID, vType, out lstFTM);
            if (lstFTM.Count > 0)
            {
                ddlFeeType.DataSource = lstFTM.FindAll(p => p.FeeType != "COM" && p.FeeType != "PRO" && p.FeeType != "GEN");
                ddlFeeType.DataTextField = "FeeTypeDesc";
                ddlFeeType.DataValueField = "FeeType";
                ddlFeeType.DataBind();
                ddlFeeType.SelectedIndex = 1;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading FeeType", Ex);
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
    private void LoadDepartement()
    {
        ddlDepartment.Items.Clear();
        List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
        List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        long returnCode = -1;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);
        if (ObjInvDep.Count > 0)
        {
            ddlDepartment.DataTextField = "DeptName";
            ddlDepartment.DataValueField = "DeptID";
            ddlDepartment.DataSource = ObjInvDep;
            ddlDepartment.DataBind();
        }
        ddlDepartment.Items.Insert(0, All);
        ddlDepartment.Items[0].Value = "-1";
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
                lstItem.Text = DispSelect;
                lstItem.Value = "-1";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get InvClientType", ex);
        }
    }
    public void LoadInvSampleMaster()
    {
        try
        {
            long returnCode = -1;
            Investigation_BL objInvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            returnCode = objInvestigationBL.GetInvSampleMaster(OrgID, out lstInvSampleMaster);
            if (lstInvSampleMaster.Count > 0)
            {
                ddlSample.DataSource = lstInvSampleMaster;
                ddlSample.DataTextField = "SampleDesc";
                ddlSample.DataValueField = "SampleCode";
                ddlSample.DataBind();
                ddlSample.Items.Insert(0, DispSelect);
                ddlSample.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadInvSampleMaster in PendingSampleCollection_aspx_cs ", e);
        }
    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadDepartement();
        int intOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        loadlocations(RoleID, intOrgID);
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        try
        {
            long returnCode = -1;
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SearchData();

    }


    public void SearchData()
    {
        string WinAlert = Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_Alert == null ? "Alert" : Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_Alert;
        string UsrMsgWin = Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_01 == null ? "No Matching Record Found" : Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_01;
        try
        {
            Report_BL objRbl = new Report_BL(base.ContextInfo);
            long returnCode = -1;
            int OrgDetails = -1;
            long ClientID=0;
            string ClientSplitID = string.Empty;
            DateTime fromDate = txtFrom.Text.Trim() == string.Empty ? Convert.ToDateTime(new BasePage().OrgDateTimeZone) : Convert.ToDateTime(txtFrom.Text);
            DateTime toDate = txtTo.Text.Trim() == string.Empty ? Convert.ToDateTime(new BasePage().OrgDateTimeZone) : Convert.ToDateTime(txtTo.Text);
            int TrustedOrg = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int orgAddressID = Convert.ToInt32(ddlLocation.SelectedValue);
            int DeptID = Convert.ToInt16(ddlDepartment.SelectedValue);
            if (!String.IsNullOrEmpty(hdnSelectedClientID.Value) && hdnSelectedClientID.Value.Length > 0)
            {

                string[] arg = hdnSelectedClientID.Value.Split('|');
                ClientSplitID = arg[0];
            }
            ClientID = Convert.ToInt32(ClientSplitID);
            int SampleID = Convert.ToInt16(ddlSample.SelectedValue);

            string TestType = ddlFeeType.SelectedValue;
            int RefHospitalID = Convert.ToInt32(hdnReferringHospitalID.Value);
            int RefPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            returnCode = objRbl.GetLabStatisticsReportLIMS(fromDate, toDate, TrustedOrg, OrgDetails, DeptID, SampleID, ClientID, out lstLimsReport, orgAddressID, TestType, RefHospitalID, RefPhysicianID, ClientTypeID);
            if (lstLimsReport.Count > 0)
            {
                lnkExportXL.Visible = true;
                imgBtnXL.Visible = true;
                var dwcr = (from dw in lstLimsReport
                            select new { dw.DeptName }).Distinct();

                List<InvLimsReport> lstLimsReportChild = new List<InvLimsReport>();
                foreach (var obj in dwcr)
                {
                    InvLimsReport ILR = new InvLimsReport();
                    ILR.DeptName = obj.DeptName;
                    lstLimsReportChild.Add(ILR);
                }
                grdTestReport.DataSource = lstLimsReportChild;
                grdTestReport.DataBind();


            }
            else
            {
                lnkExportXL.Visible = false;
                imgBtnXL.Visible = false;
               ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Alt", "alert('No Matching Record Found');", true);
                grdTestReport.DataSource = "";
                grdTestReport.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLabStatisticsReportLIMS", ex);
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
    protected void grdTestReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<InvLimsReport> lstlims = new List<InvLimsReport>();
                InvLimsReport RMaster = (InvLimsReport)e.Row.DataItem;
                var childItems = from child in lstLimsReport
                                 where child.DeptName == RMaster.DeptName
                                 orderby child.DeptName descending
                                 select child;
                GridView childGrid = (GridView)e.Row.FindControl("grdChildGridTestReport");
                count = childItems.Count();
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstlims = childItems.ToList();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Test Wise Stat Report Row Data Bound", ex);
        }
    }
    protected void grdChildGridTestReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string sdtotal = Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_002 == null ? "TOTAL" : Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_002;
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblInvestigationName = (Label)e.Row.FindControl("lblInvestigationName");
                if (lblInvestigationName.Text == sdtotal)
                {
                    lblInvestigationName.Text = sdtotal;
                    e.Row.Style.Add("font-weight", "bold");
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

    }
    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        ExportToXL();
    }
    public void ExportToXL()
    {
        string Ssting = Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_001 == null ? "TestWiseStatisticsReport" : Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_001;
        try
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", (Ssting + ".xls")));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            SearchData();
            grdTestReport.AllowPaging = false;
            grdTestReport.DataBind();
            //Change the Header Row back to white color
            grdTestReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
            grdTestReport.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }


    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        ExportToXL();
    }
}

