using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;

public partial class Investigation_RadiologyReport : BasePage
{
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    long returnCode = -1;
    string FromVisitDate = string.Empty;
    string ToVisitDate = string.Empty;
    string PatientName = string.Empty;
    string URNo = string.Empty;
    string RefPhy = string.Empty;
    string RefHos = string.Empty;
    string Radiologist = string.Empty;
    string ReportContent = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            AutoRname.ContextKey = Convert.ToString(OrgID);
            AutoCompletePatient.ContextKey = Convert.ToString("Y");
            AutoCompleteExtender1.ContextKey = Convert.ToString("Y");
            if (!IsPostBack)
            {
                loadRadiologist();
                FromVisitDate = txtFrom.Text.Trim();
                ToVisitDate = txtTo.Text.Trim();
                PatientName = txtPatient.Text.Trim();
                URNo = txtURno.Text.Trim();
                RefPhy = txtDoctor.Text.Trim();
                RefHos = txtClinic.Text.Trim();
                if (ddlPerformingPhysician.SelectedValue != "Select")
                {
                    Radiologist = ddlPerformingPhysician.SelectedItem.Text.Trim();
                }
                ReportContent = txtReportContent.Text.Trim();
                loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Radiology Report", ex);
        }
    }


    public void loadGrid(string FromVisit, string ToVisit, string RefPhyName, string RefHosName, string ReportedBy, string URNo, string PatientName, string ReportText, int currentPageNo, int PageSize)
    {
        List<RadiologyReport> lstRadiologyReport = new List<RadiologyReport>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        returnCode = investigationBL.GetRadiologyReport(ILocationID, OrgID, FromVisit, ToVisit, RefPhyName, RefHosName, ReportedBy, URNo, PatientName, ReportText, currentPageNo, PageSize, out totalRows, out lstRadiologyReport);
        if (lstRadiologyReport.Count > 0)
        {
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
                    Btn_Next.Enabled = false;
            }

            else
            {
                Btn_Previous.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
            grdResult.DataSource = lstRadiologyReport;
            grdResult.DataBind();
            lblStatus.Visible = false;
            resultDIV.Visible = true;
        }
        else
        {
            lblStatus.Visible = true;
            resultDIV.Visible = false;
        }
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        FromVisitDate = txtFrom.Text.Trim();
        ToVisitDate = txtTo.Text.Trim();
        PatientName = txtPatient.Text.Trim();
        URNo = txtURno.Text.Trim();
        RefPhy = txtDoctor.Text.Trim();
        RefHos = txtClinic.Text.Trim();
        if (ddlPerformingPhysician.SelectedValue != "Select")
        {
            Radiologist = ddlPerformingPhysician.SelectedItem.Text.Trim();
        }
        ReportContent = txtReportContent.Text.Trim();
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);
        }

        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);
        }
    }

    protected void Btn_Next_Click(object sender, EventArgs e)
    {

        FromVisitDate = txtFrom.Text.Trim();
        ToVisitDate = txtTo.Text.Trim();
        PatientName = txtPatient.Text.Trim();
        URNo = txtURno.Text.Trim();
        RefPhy = txtDoctor.Text.Trim();
        RefHos = txtClinic.Text.Trim();
        if (ddlPerformingPhysician.SelectedValue != "Select")
        {
            Radiologist = ddlPerformingPhysician.SelectedItem.Text.Trim();
        }
        ReportContent = txtReportContent.Text.Trim();

        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);

        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);

        }

    }

    protected void btnGo_Click(object sender, EventArgs e)
    {


        hdnCurrent.Value = txtpageNo.Text;
        currentPageNo = Int32.Parse(hdnCurrent.Value);
        FromVisitDate = txtFrom.Text.Trim();
        ToVisitDate = txtTo.Text.Trim();
        PatientName = txtPatient.Text.Trim();
        URNo = txtURno.Text.Trim();
        RefPhy = txtDoctor.Text.Trim();
        RefHos = txtClinic.Text.Trim();
        if (ddlPerformingPhysician.SelectedValue != "Select")
        {
            Radiologist = ddlPerformingPhysician.SelectedItem.Text.Trim();
        }
        ReportContent = txtReportContent.Text.Trim();
        loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);



    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                ShowReport(Convert.ToString(grdResult.DataKeys[RowIndex][5]), Convert.ToInt64(grdResult.DataKeys[RowIndex][0]), Convert.ToString(grdResult.DataKeys[RowIndex][2]), Convert.ToInt64(grdResult.DataKeys[RowIndex][4]));
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                rptMdlPopup.Show();
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Radiology Report", ex);
        }
    }
    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdResult.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    cell.Text = Server.HtmlDecode(cell.Text);
                }

                e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='#2c88b1';");
                e.Row.Attributes.Add("onmouseout", "this.style.color='Black';");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Radiology Report", ex);
        }
    }

   

    public void ShowReport(string reportPath, long visitID, string templateID, long InvID)
    {
        try
        {
            ReportViewer.Visible = true;
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            ReportViewer.Attributes.Add("style", "width:100%; height:484px");
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            ReportViewer.ServerReport.ReportPath = reportPath;
            ReportViewer.ShowParameterPrompts = false;
            ReportViewer.ShowPrintButton = true;
            //ReportViewer.LocalReport.Refresh();
            //ReportViewer.AsyncRendering = false;
            //if (!ReportViewer.Enabled) ReportViewer.CurrentPage = 1;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            ReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
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

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
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

    public void loadRadiologist()
    {
        List<PerformingPhysician> lstPerformingPhysician = new List<PerformingPhysician>();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        returnCode = investigationBL.GetPerformingPhysician(OrgID, out lstPerformingPhysician);
        ddlPerformingPhysician.DataSource = lstPerformingPhysician;
        ddlPerformingPhysician.DataTextField = "physicianName";
        ddlPerformingPhysician.DataBind();
        ddlPerformingPhysician.Items.Insert(0, "Select");
        ddlPerformingPhysician.Items.FindByText("Select").Selected = true;

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            FromVisitDate = txtFrom.Text.Trim();
            ToVisitDate = txtTo.Text.Trim();
            PatientName = txtPatient.Text.Trim();
            URNo = txtURno.Text.Trim();
            RefPhy = txtDoctor.Text.Trim();
            RefHos = txtClinic.Text.Trim();
            if (ddlPerformingPhysician.SelectedValue != "Select")
            {
                Radiologist = ddlPerformingPhysician.SelectedItem.Text.Trim();
            }
            ReportContent = txtReportContent.Text.Trim();
            loadGrid(FromVisitDate, ToVisitDate, RefPhy, RefHos, Radiologist, URNo, PatientName, ReportContent, currentPageNo, PageSize);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Radiology Report", ex);
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Attune.Podium.BusinessEntities.Role> lstUserRole = new List<Attune.Podium.BusinessEntities.Role>();
            string path = string.Empty;
            Attune.Podium.BusinessEntities.Role role = new Attune.Podium.BusinessEntities.Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
