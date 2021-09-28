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


public partial class ReportsLims_DailyTransactionLims : BasePage
{
    long returnCode = -1;
    decimal pTotalAmt = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            LoadOrgan();
            if (ddlTrustedOrg.Items.Count > 0)
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID);
            drpLocation.SelectedValue = ILocationID.ToString();
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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
    }
    public void ExportToExcel()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=Daily_Transaction_report_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdDailyTransReport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, Daily_Transaction_report_", ex);
        }
    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadLocationsCall();
    }
    private void LoadLocationsCall()
    {
        try
        {
            if (ddlTrustedOrg.Items.Count > 0 && ddlTrustedOrg.SelectedItem.Value != "0")
            {
                loadlocations(RoleID, Convert.ToInt32(ddlTrustedOrg.SelectedItem.Value));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadLocationsCall", ex);
        }
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        drpLocation.DataSource = lstLocation;
        drpLocation.DataTextField = "Location";
        drpLocation.DataValueField = "AddressID";
        drpLocation.DataBind();

        if (lstLocation.Count == 1)
        {
            drpLocation.Items.Insert(0, "------SELECT------");
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            drpLocation.Items.Insert(0, "------SELECT------");
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
    }
    public void CalculationPanelBlock()
    {
        tabGranTotal.Visible = true;
        lblCardTotal.InnerText = String.Format("{0:0.00}", (pTotalAmt));
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstDTR = new List<DayWiseCollectionReport>();
            string PatientName = string.Empty;
            string UserName = string.Empty;
            string ClientName = string.Empty;
            int pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int OrgAddressID = Convert.ToInt32(drpLocation.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            if (txtPatientName.Text != "")
            {
                PatientName = txtPatientName.Text;
            }
            returnCode = new Report_BL(base.ContextInfo).GetDailyTransactionDetails(fDate, tDate, pOrgID, OrgAddressID,PatientName,UserName,ClientName, out lstDTR, out pTotalAmt);
            grdDailyTransReport.DataSource = lstDTR;
            grdDailyTransReport.DataBind();
            CalculationPanelBlock();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, Daily Transaction Report", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

}
