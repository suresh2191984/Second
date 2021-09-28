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
using System.Drawing;
using System.Globalization;
using ReportBusinessLogic;

public partial class Reports_EpisodeReport : BasePage
{
    public Reports_EpisodeReport() : base("Reports_EpisodeReport_aspx")
    {
    }

    long returnCode = -1;
    DataSet ds = new DataSet();
    string BaseCurrencyCode = string.Empty;
    List<EpisodeReport> lstEpisodeReportList = new List<EpisodeReport>();
    string DateFormat = "ddmmyyyy";
    string TimeFormat = "12";
    protected void Page_Load(object sender, EventArgs e)
    {
        ddlTrustedOrg.Focus();
        txtFromFormat.HRef = "javascript:NewCssCal('txtFDate'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
        txtToFormat.HRef = "javascript:NewCssCal('txtTDate'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
            DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
            string a = dt.ToString(DateTimeFormat);
            txtFDate.Text = a.Substring(0, 10) + " " + "00:00";
            txtTDate.Text = a.ToString();
            //txtFDate.Text = OrgTimeZone;
            //txtTDate.Text = OrgTimeZone;
            LoadOrgan();

            if (ddlTrustedOrg.Items.Count > 0)
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID);
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
        }
        AutoCompleteExtender1.ContextKey = ddlTrustedOrg.SelectedValue;
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
                trTrustedOrg.Style.Add("display", "table-row");
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }
            else
            {
                trTrustedOrg.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);

        }
    }

    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadlocations(RoleID, Convert.ToInt32(ddlTrustedOrg.SelectedValue));
        ClearValues();
    }

    protected void loadlocations(long uroleID, int intOrgID)
    {
        string all = Resources.Reports_ClientDisplay.Reports_EpisodeReport_aspx_02 == null ? "-----ALL-----" : Resources.Reports_ClientDisplay.Reports_EpisodeReport_aspx_02;

        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            //ddlLocation.Items.Insert(0, "-----ALL-----");     a
            ddlLocation.Items.Insert(0, all);
            ddlLocation.Items[0].Value = "0";
            ddlLocation.Items[0].Selected = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }

    protected void ClearValues()
    {
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            long result = -1;

            int trustedOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int locationID = Convert.ToInt32(ddlLocation.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string episodeNo = txtEpisodeNo.Text.Trim();
            string patientName = txtPatientName.Text.Trim();
            string testName = txtTestName.Text.Trim();
            string clientName = txtClient.Text.Trim();

            ReportBusinessLogic.ReportExcel_BL objReportExcel = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
            result = objReportExcel.GetEpisodeReport(trustedOrgID, locationID, fDate, tDate, episodeNo, patientName, testName, clientName, OrgID, out lstEpisodeReportList);
            if (lstEpisodeReportList.Count() > 0 && lstEpisodeReportList!=null)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                gvEpisodeReport.Visible = true;
                gvEpisodeReport.DataSource = lstEpisodeReportList;
                gvEpisodeReport.DataBind();
                btnExcel.Visible = true;
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                gvEpisodeReport.DataSource = null;
                gvEpisodeReport.DataBind();
                gvEpisodeReport.Visible = false;
                btnExcel.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records');", true);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }

    protected void gvEpisodeReport_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                EpisodeReport er = (EpisodeReport)e.Row.DataItem;
                string strScript = "Select_Visit('" + er.PatientVisitID + "','" + er.PatientID + "','" + er.PatientName + "','" + er.ExternalVisitID + "');";
                //List<EpisodeReport> lstTestCodes = new List<EpisodeReport>();
                //returnCode = new Investigation_BL(base.ContextInfo).GetPatientTestCodes(er.PatientVisitID, OrgID, ILocationID, out lstTestCodes);

                //if (lstTestCodes.Count > 0)
                //{
                //    GridView grdChild = (GridView)e.Row.Cells[0].FindControl("ChildGrd");
                //    grdChild.DataSource = lstTestCodes;
                //    grdChild.DataBind();

                //    //DynamicGridColumns(grdChild);
                //}
            }
        }
        catch (Exception Ex)
        {
            //report error
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void btnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "EpisodeReport.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gvEpisodeReport.AllowPaging = false;
            //Change the Header Row back to white color
            gvEpisodeReport.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < gvEpisodeReport.HeaderRow.Cells.Count; i++)
            {
                gvEpisodeReport.HeaderRow.Cells[i].Style.Add("background-color", "#507CD1");
            }
            int j = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in gvEpisodeReport.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= gvEpisodeReport.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                        }
                    }
                }
                j++;
            }
            gvEpisodeReport.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

        }
        catch(Exception ex)
        {
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
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
