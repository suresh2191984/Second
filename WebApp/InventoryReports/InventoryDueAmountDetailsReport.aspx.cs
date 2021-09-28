using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Data;
using System.Collections;
using System.IO;
using System.Text;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_InventoryDueAmountDetailsReport : Attune_BasePage
{
    /// <summary>
    /// Date:06-07-2013 
    /// Milestone:Get Inventory Summary Report
    /// </summary> 
    public InventoryReports_InventoryDueAmountDetailsReport()
        : base(" InventoryReports_InventoryDueAmountDetailsReport_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    int ReportType = 0;
    DateTime FromDate = DateTime.Today;
    DateTime ToDate = DateTime.Today;
    List<DayWiseCollectionReport> lstDayWise = new List<DayWiseCollectionReport>();
    List<ReceivedAmount> lstCollections = new List<ReceivedAmount>();
    DataSet ds = new DataSet();
    string BillType = string.Empty;
    int locationId = 0;
    string BaseCurrencyCode = string.Empty;
    string NoMatchRecrd = Resources.InventoryReports_AppMsg.InventoryReports_InventoryDueAmountDetailsReport_aspx_03 != null ? Resources.InventoryReports_AppMsg.InventoryReports_InventoryDueAmountDetailsReport_aspx_03 : "No Matching Records found for the selected dates";
    string FirstClick = Resources.InventoryReports_AppMsg.InventoryReports_InventoryDueAmountDetailsReport_aspx_04 != null ? Resources.InventoryReports_AppMsg.InventoryReports_InventoryDueAmountDetailsReport_aspx_04 : "Click the get report";
    string IP = Resources.InventoryReports_ClientDisplay.InventoryReports_InventoryDueAmountDetailsReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_InventoryDueAmountDetailsReport_aspx_01 : "IP";
    string Error = Resources.InventoryReports_AppMsg.InventoryReports_Error == null ? "Alert" : Resources.InventoryReports_AppMsg.InventoryReports_Error;
    string ReportName = Resources.InventoryReports_ClientDisplay.InventoryReports_InventoryDueAmountDetailsReport_aspx_02 == null ? "Inventory Summary and Detail Report " : Resources.InventoryReports_ClientDisplay.InventoryReports_InventoryDueAmountDetailsReport_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlTrustedOrg.Focus();
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            LoadOrgan();
            LoadReportFormat();
            LoadBillType();
        }
    }
    public void LoadReportFormat()
    {
        long returncode = -1;
        string domains = "ReportFormat,";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;

        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }

        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "ReportFormat"
                             select child;
            rblReportType.DataSource = childItems; ;
            rblReportType.DataTextField = "DisplayText";
            rblReportType.DataValueField = "Code";
            rblReportType.DataBind();
            rblReportType.SelectedValue = "1";
        }
    }
    public void LoadBillType()
    {
        long returncode = -1;
        string domains = "BillType,";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;

        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }

        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "BillType"
                             select child;
            rblBillType.DataSource = childItems; ;
            rblBillType.DataTextField = "DisplayText";
            rblBillType.DataValueField = "Code";
            rblBillType.DataBind();
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            InventoryReports_BL invReportsBL = new InventoryReports_BL(base.ContextInfo);
            new Master_BL(base.ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrganizationID";
                ddlTrustedOrg.DataBind();
                //ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                if (lstOrgList.Count(p => p.OrgID == OrgID) > 0)
                {
                    ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).OrgID.ToString();
                }
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (rblBillType.SelectedItem.Value == "0")
            {
                BillType = "0";//Optical
            }
            else if (rblBillType.SelectedItem.Value == "1")
            {
                BillType = "1"; //Pharmacy
            }
            else
            {
                BillType = "";//null
            }

            if (rblReportType.SelectedValue == "1")
            {
                ReportType = 1;//Summary
            }
            else
            {
                ReportType = 0;//Details
            }

            if (ddlTrustedOrg.Items.Count > 0)
            {
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            }
            if (txtFDate.Text != "" && txtTDate.Text != "")
            {
                FromDate = Convert.ToDateTime(txtFDate.Text);
                ToDate = Convert.ToDateTime(txtTDate.Text);
                LoadInventoryDueAmountDetails(FromDate, ToDate, OrgID, BillType, locationId, ReportType);
            }
            else
            {
                if (FromDate == DateTime.Today)
                {
                    FromDate = Convert.ToDateTime("01/01/1753");
                    ToDate = Convert.ToDateTime("01/01/9999");
                }
                LoadInventoryDueAmountDetails(FromDate, ToDate, OrgID, BillType, locationId, ReportType);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSubmit_Click - InventoryDueAmountDetailsReport.aspx", ex);

        }
    }

    public void LoadInventoryDueAmountDetails(DateTime pFDT, DateTime pTDT, int OrgId, string BillType, int locationId, int ReportType)
    {
        try
        {
            InventoryReports_BL invReportBL = new InventoryReports_BL(base.ContextInfo);
            invReportBL.GetInventoryDueAmountDetails(pFDT, pTDT, OrgId, BillType, locationId, ReportType, out lstDayWise);
            if (lstDayWise.Count > 0)
            {
                if (ReportType == 0)
                {
                    grdDueSummary.Visible = true;
                    grdDueDetails.Visible = false;
                    grdDueSummary.DataSource = lstDayWise;
                    grdDueSummary.DataBind();
                }
                else if (ReportType == 1)
                {
                    grdDueSummary.Visible = false;
                    grdDueDetails.Visible = true;
                    grdDueDetails.DataSource = lstDayWise;
                    grdDueDetails.DataBind();
                }
                else
                {
                }
            }
            else
            {
                grdDueSummary.Visible = false;
                grdDueDetails.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "PDCReport", "javascript:ValidationWindow(" + NoMatchRecrd + "," + Error + ");", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadInventoryDueAmountDetails - InventoryDueAmountDetailsReport.aspx", ex);
        }
    }
    protected void grdDueDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdDueDetails.PageIndex = e.NewPageIndex;
        }
        btnSubmit_Click(sender, e);
    }

    protected void grdDueSummary_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdDueSummary.PageIndex = e.NewPageIndex;
        }
        btnSubmit_Click(sender, e);

    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        try
        {
            grdDueDetails.AllowPaging = false;
            grdDueSummary.AllowPaging = false;
            btnSubmit_Click(sender, e);
            ExportToExcel();
            grdDueDetails.AllowPaging = true;
            grdDueSummary.AllowPaging = true;
            grdDueDetails.DataSource = lstDayWise;
            grdDueDetails.DataBind();

            grdDueSummary.DataSource = lstDayWise;
            grdDueSummary.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in imgBtnXL_Click Excel Export", ex);
        }
    }
    string strInv = Resources.InventoryReports_ClientDisplay.InventoryReports_IndentStatusReport_aspx_01 == null ? "Inventory Summary and Detail Report" : Resources.InventoryReports_ClientDisplay.InventoryReports_IndentStatusReport_aspx_01;

    public void ExportToExcel()
    {
        try
        {
            string attachment = "attachment; filename=" + ReportName + DateTimeNow.ToShortDateString() + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt;color:#538ED5;font-weight:700;'>" + strInv + " </span>");
            DivReport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Amount Approval  Report-ExportToExcel", ioe);
        }
    }

    protected void grdDueDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }

    }
    protected void grdDueSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
