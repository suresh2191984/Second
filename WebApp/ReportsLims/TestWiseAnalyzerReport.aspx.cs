using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;
using Attune.Podium.BusinessEntities.CustomEntities;
using System.Drawing;

public partial class ReportsLims_TestWiseAnalyzerReport : BasePage
{
    public ReportsLims_TestWiseAnalyzerReport()
        : base("ReportsLims_TestWiseAnalyzerReport_aspx")
    {
    }
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtToDate.Text = OrgTimeZone;
        AutoCompleteExtender3.ContextKey = OrgID.ToString();
        if (!IsPostBack)
        {
            LoadMeatData();
            LoadOrgan();
            LoadAnalyzerName();
            loadlocations(RoleID, OrgID);
            lblNofParam.Visible = false;
            lblNofParamVal.Text = "";
            lblTotProTstCount.Visible = false;
            lblTotProTstCountVal.Text = "";
        }
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {

        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        ddlLocation.DataSource = lstLocation;
        ddlLocation.DataTextField = "Location";
        ddlLocation.DataValueField = "AddressID";
        ddlLocation.DataBind();
        //ddlLocation.Items.Insert(0, "--Select--");       
    }
    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "LoadReportType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "LoadReportType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlReportType.DataSource = childItems;
                    ddlReportType.DataTextField = "DisplayText";
                    ddlReportType.DataValueField = "Code";
                    ddlReportType.DataBind();
                    //ddlReportType.Items.Insert(0, "---Select---");
                    //ddlReportType.Items[0].Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Test Wise Analyzer Reports", ex);
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
                ddlOrganization.DataSource = lstOrgList;
                ddlOrganization.DataTextField = "Name";
                ddlOrganization.DataValueField = "OrgID";
                ddlOrganization.DataBind();
                //ddlOrganization.Items.Insert(0, "--Select--");
                //ddlOrganization.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                // ddlOrganization.Focus();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details For Test Wise Analyzer Reports", ex);
        }
    }
    private void LoadAnalyzerName()
    {
        long ReturnCode = -1;
        try
        {
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<InvInstrumentMaster> lstInst = new List<InvInstrumentMaster>();
            ReturnCode = MasterBL.GetAnalyzerName(OrgID, out lstInst);
            if (lstInst.Count > 0)
            {
                ddlAnalyzerNm.DataSource = lstInst;
                ddlAnalyzerNm.DataTextField = "InstrumentName";
                ddlAnalyzerNm.DataValueField = "ProductCode";
                ddlAnalyzerNm.DataBind();
                ddlAnalyzerNm.Items.Insert(0, "--Select--");
                //ddlAnalyzerNm.Focus();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetInstrumentName From Test Wise Analyzer Report", ex);
        }
    }
    public void LoadGrid()
    {
        try
        {
            Report_BL rpt_BL = new Report_BL();
            List<TestWiseAnalyzerReport> lstdata = new List<TestWiseAnalyzerReport>();
            DateTime fDate = (txtFromDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtFromDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtFromDate.Text.Trim());
            DateTime tDate = (txtToDate.Text.Trim().ToLower() == "dd/mm/yyyy" || txtToDate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(txtToDate.Text.Trim());
            int IntOrgID = Convert.ToInt32(ddlOrganization.SelectedValue);
            int ClientLocation = Convert.ToInt32(ddlLocation.SelectedValue);
            int ReportType = Convert.ToInt32(hdnreporttype.Value);
            string AnalyzerName = ddlAnalyzerNm.SelectedValue.ToString();
            if (ReportType == 1)//1 means Summary  
            {

                int TestId = 0;
                lblVisibleSummRept();
                returnCode = rpt_BL.GetTestWiseAnalyzerReportLims(ReportType, fDate, tDate, IntOrgID, AnalyzerName, ClientLocation, TestId, out lstdata);
                var TotAnal = lstdata.Select(o => o.Analyzername).Count();
                lblTotAVal.Text = TotAnal.ToString();
                var TotProcCount = lstdata.Select(o => o.Count).Sum();
                lblProTotCountVal.Text = TotProcCount.ToString();
                var TotParam = lstdata.Select(o => o.TestName).Count();
                lblTotParamVal.Text = TotParam.ToString();
                if (lstdata.Count > 0)
                {
                    grdTestReport.DataSource = lstdata;
                    grdTestReport.DataBind();
                }
                else
                {
                    string str1 = "No data Found..";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + str1 + "','" + "Alert" + "');", true);
                }
            }
            else if (ReportType == 2)//2 means Detailed
            {               
                
                int TestId = Convert.ToInt32(hdnTestCode.Value);
                string Analyzerid = ddlAnalyzerNm.SelectedItem.Text.ToString();
                if (Analyzerid != "--Select--")
                {
                    lblVisibleDetailRept();
                    returnCode = rpt_BL.GetTestWiseAnalyzerReportLims(ReportType, fDate, tDate, IntOrgID, AnalyzerName, ClientLocation, TestId, out lstdata);
                    var TotAnal = lstdata.Select(o => o.Analyzername).Count();
                    lblNofParamVal.Text = TotAnal.ToString();

                if (lstdata.Count > 0)
                {
                    for (int i = 0; i < lstdata.Count; i++)
                    {
                        grdDetailedRpt.DataSource = lstdata;
                        grdDetailedRpt.DataBind();
                        lblTotProTstCountVal.Text = grdDetailedRpt.Rows.Count.ToString();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + "No data Found.." + "','" + "Alert" + "');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + "Provide / load AnalyzerName.." + "','" + "Alert" + "');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + "Select a Report type" + "','" + "Alert" + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Grid values From Test Wise Analyzer Report", ex);
        }
        finally
        {
           // ddlReportType.SelectedValue = "1";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.
    }
    public void lnkbtnExport_Click(object sender, EventArgs e)
    {
        ChktoExport();
    }
    public void ChktoExport()
    {
        int ReportType = Convert.ToInt32(hdnreporttype.Value);
        string SelectGrid = string.Empty;
        if (ReportType == 1)
        {
            ExportToXLSummaryReport();
        }
        else if (ReportType == 2)
        {
            ExportToXLDetailedReport();
        }
        else
        {
            string str1 = "Record Empty.. ";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + str1 + "','" + "Alert" + "');", true);
        }
    }
    public void ExportToXLSummaryReport()
    {
        try
        {
            string excel = "TestWiseAnalyzerReport";
            string attachment = "attachment; filename=" + excel + ".xls";
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadGrid();
            for (int i = 0; i < grdTestReport.HeaderRow.Cells.Count; i++)
            {
                grdTestReport.HeaderRow.Cells[i].Style.Add("background-color", "#80CCD8");
            }
            int j = 1;
            foreach (GridViewRow gvrow in grdTestReport.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= grdTestReport.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#FFFFFF");
                        }
                    }
                }
                j++;
            }
            htw.WriteLine("<span style='font-size:14.0pt; color:#E54C70;font-weight:500;font-weight: bold;'>" + excel + " </span>");
            grdTestReport.RenderControl(htw);
            Response.Write(sw.ToString());
            sw.Close();
            htw.Close();
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel From Test Wise Analyzer Report, ExporttoExcel", ex);
        }
        finally
        {
        }
    }
    public void ExportToXLDetailedReport()
    {
        try
        {
            string excel = "TestWiseAnalyzerReport";
            string attachment = "attachment; filename=" + excel + ".xls";
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadGrid();
            for (int i = 0; i < grdDetailedRpt.HeaderRow.Cells.Count; i++)
            {
                grdDetailedRpt.HeaderRow.Cells[i].Style.Add("background-color", "#80CCD8");
            }
            int j = 1;
            foreach (GridViewRow gvrow in grdDetailedRpt.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= grdDetailedRpt.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#FFFFFF");
                        }
                    }
                }
                j++;
            }
            htw.WriteLine("<span style='font-size:14.0pt; color:#E54C70;font-weight:500;font-weight: bold;'>" + excel + " </span>");
            grdDetailedRpt.RenderControl(htw);
            Response.Write(sw.ToString());
            sw.Close();
            htw.Close();
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel TestWiseAnalayzerReport, ExporttoExcel", ex);
        }
        finally
        {

        }
    }
    public void lblVisibleSummRept()
    {
        txtSearch.Visible = true;
        txtSearch1.Visible = false;
        lnkbtnExport.Enabled = true;
        lnkbtnPrint.Enabled = true;
        trgrdDetailedRpt.Visible = false;
        lblDmsg.Visible = false;
        lblmsg.Visible = true;
        trgrdTestReport.Visible = true;
        grdTestReport.Visible = true;
        grdDetailedRpt.Visible = false;
        lblTotAnalyzer.Visible = true;
        lblTotAVal.Visible = true;
        lblTotParam.Visible = true;
        lblTotParamVal.Visible = true;
        lblProTotCount.Visible = true;
        lblProTotCountVal.Visible = true;
        lblNofParam.Visible = false;
        lblNofParamVal.Visible = false;
        lblTotProTstCount.Visible = false;
        lblTotProTstCountVal.Visible = false;
    }
    public void lblVisibleDetailRept()
    {
        txtSearch.Visible = false;
        txtSearch1.Visible = true;
        lnkbtnPrint.Enabled = true;
        lnkbtnExport.Enabled = true;
        lblDmsg.Visible = true;
        lblmsg.Visible = false;
        trgrdDetailedRpt.Visible = true;
        trgrdTestReport.Visible = false;
        grdDetailedRpt.Visible = true;
        grdTestReport.Visible = false;
        lblTotAnalyzer.Visible = false;
        lblTotAVal.Visible = false;
        lblTotParam.Visible = false;
        lblTotParamVal.Visible = false;
        lblProTotCount.Visible = false;
        lblProTotCountVal.Visible = false;
        lblNofParam.Visible = true;
        lblNofParamVal.Visible = true;
        lblTotProTstCount.Visible = true;
        lblTotProTstCountVal.Visible = true;
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

}
