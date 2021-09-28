using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.ExcelExportManager;
using System.IO;
using System.Text;

public partial class Investigation_AbnormalValueReport : BasePage
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            loadlocations(RoleID);
        }

    }
    protected void loadlocations(long uroleID)
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(OrgID, LID, uroleID, out lstLocation);
       

        if (lstLocation.Count > 1)
        {
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
        }
        ddlLocation.Items.Insert(0, "--ALL--");
        ddlLocation.Items[0].Value = "0";
        ddlLocation.Items[0].Selected = true;
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            long LocationID = Convert.ToInt64(ddlLocation.SelectedItem.Value);
            long InvestigationID = Convert.ToInt64(hdnTestID.Value);
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            returnCode = invBL.GetAbnormalReport(fDate, tDate, LocationID, InvestigationID, OrgID, out lstPatientInvestigation);
            if (lstPatientInvestigation.Count > 0)
            {
                grdResult.Visible = true;
                lblMessage.Visible = false;
                grdResult.DataSource = lstPatientInvestigation;
                grdResult.DataBind();
                
            }
            else
            {
                grdResult.Visible = false;
                lblMessage.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, GetAbnormalReport", ex);
        }

    }
    protected void btn_export_Click(object sender, EventArgs e)
    {

        try
        {
            ExportToExcel(grdResult);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Abnormal Value Report Excel Export", ex);

        }

    }
    public void ExportToExcel(Control CTRl)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Abnormal Value Report _" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString()));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        grdResult.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
