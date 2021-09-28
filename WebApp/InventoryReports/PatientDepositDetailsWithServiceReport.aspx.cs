using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Kernel.BusinessEntities;
using System.Data;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PatientDepositDetailsWithServiceReport : Attune_BasePage
{
    public InventoryReports_PatientDepositDetailsWithServiceReport()
        : base("InventoryReports_PatientDepositDetailsWithServiceReport_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string RefType = string.Empty;
    DateTime FromDate = DateTime.Today;
    DateTime ToDate = DateTime.Today;
    List<DayWiseCollectionReport> lstDayWise = new List<DayWiseCollectionReport>();
    List<ReceivedAmount> lstCollections = new List<ReceivedAmount>();
    DataSet ds = new DataSet();
    InventoryReports_BL invReportsBL;
    string BaseCurrencyCode = string.Empty;
    string NoMatchRecrd = Resources.InventoryReports_ClientDisplay.InventoryReports_PatientDepositDetailsWithServiceReport_aspx_01;
    string FirstClick = Resources.InventoryReports_ClientDisplay.InventoryReports_PatientDepositDetailsWithServiceReport_aspx_02;
    string IP = Resources.InventoryReports_ClientDisplay.InventoryReports_PatientDepositDetailsWithServiceReport_aspx_03;
    string Error = Resources.InventoryReports_AppMsg.InventoryReports_Error;
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
            LoadReportType();
        }
    }
    public void LoadReportType()
    {
        long returncode = -1;
        string domains = "ReceiptType,";
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

        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID,LanguageCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {
            var childItems = from child in lstmetadataOutput
                             where child.Code == "DEP" & child.Code == "REF" & child.Domain == "ReceiptType"
                             select child;
            rblReportType.DataSource = childItems;
            rblReportType.DataTextField = "DisplayText";
            rblReportType.DataValueField = "Code";
            rblReportType.DataBind();
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
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
            RefType = rblReportType.SelectedValue;
            if (ddlTrustedOrg.Items.Count > 0)
            {
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            }
            if (txtFDate.Text != "" && txtTDate.Text != "")
            {
                FromDate = Convert.ToDateTime(txtFDate.Text);
                ToDate = Convert.ToDateTime(txtTDate.Text);
                LoadPatientDepositDetailsWithService(FromDate, ToDate, OrgID, RefType);
            }
            else
            {
                if (FromDate == DateTime.Today)
                {
                    FromDate = Convert.ToDateTime("01/01/1753");
                    ToDate = Convert.ToDateTime("01/01/9999");
                }
                LoadPatientDepositDetailsWithService(FromDate, ToDate, OrgID, RefType);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSubmit_Click - PatientDepositDetailsWithServiceReport.aspx", ex);

        }
    }

    public void LoadPatientDepositDetailsWithService(DateTime pFDT, DateTime pTDT, int OrgId, string RefType)
    {
        try
        {
            invReportsBL = new InventoryReports_BL(base.ContextInfo);
            invReportsBL.GetPatientDepositDetailsWithService(pFDT, pTDT, OrgId, RefType, out lstDayWise);
            if (lstDayWise.Count > 0)
            {
                RefType = rblReportType.SelectedValue;
                if (RefType == "DEP")
                {
                    grdPatientDepositDetails.Visible = true;
                    grdPatientDepositDetailss.Visible = false;
                    grdPatientDepositDetails.DataSource = lstDayWise;
                    grdPatientDepositDetails.DataBind();
                }
                else
                {
                    grdPatientDepositDetails.Visible = false;
                    grdPatientDepositDetailss.Visible = true;
                    grdPatientDepositDetailss.DataSource = lstDayWise;
                    grdPatientDepositDetailss.DataBind();

                }
            }
            else
            {
                grdPatientDepositDetails.Visible = false;
                grdPatientDepositDetailss.Visible = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "PDCReport", "javascript:ValidationWindow(" + NoMatchRecrd + ","+Error+");", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPatientDepositDetailsWithService - PatientDepositDetailsWithServiceReport.aspx", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {

        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }
    protected void btnExportToExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            grdPatientDepositDetails.AllowPaging = false;
            grdPatientDepositDetailss.AllowPaging = false;
            btnSubmit_Click(sender, e);
            ExportToExcel();
            grdPatientDepositDetails.AllowPaging = true;
            grdPatientDepositDetailss.AllowPaging = true;

            grdPatientDepositDetails.DataSource = lstDayWise;
            grdPatientDepositDetails.DataBind();

            grdPatientDepositDetailss.DataSource = lstDayWise;
            grdPatientDepositDetailss.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }
    public void ExportToExcel()
    {
        ////export to excel
        string attachment = "attachment; filename=" + Resources.InventoryReports_ClientDisplay.InventoryReports_PatientDepositDetailsWithServiceReport_aspx_04 + "" + DateTimeUtility.GetServerDate().ToShortDateString() + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        DivReport.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void grdPatientDepositDetails_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdPatientDepositDetails.PageIndex = e.NewPageIndex;
        }
        btnSubmit_Click(sender, e);

    }
    protected void grdPatientDepositDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
    }
    protected void grdPatientDepositDetailss_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
    }
}
