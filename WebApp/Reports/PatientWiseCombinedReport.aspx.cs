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

public partial class Reports_PatientWiseCombinedReport : BasePage
{
    long returnCode = -1;
    List<PatientWiseCombinedReport> lstPatientWiseCombinedReport = new List<PatientWiseCombinedReport>();
    List<Physician> lstPhysician;
    List<ReferingPhysician> lstRefPhysician;

    public Reports_PatientWiseCombinedReport()
        : base("Reports\\PatientWiseCombinedReport.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            LoadConsultant();
        }
    }
    public void LoadConsultant()
    {
        lstPhysician = new List<Physician>();
      

        new PatientVisit_BL(base.ContextInfo).GetInternalExternalPhysician(OrgID, out lstPhysician, out lstRefPhysician);
        if (lstPhysician.Count > 0)
        {
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
            ddlPhysician.Items.Insert(0, "-----Select-----");
            ddlPhysician.Items[0].Value = "0";
        }

       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            long physicianID = Convert.ToInt64(ddlPhysician.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetPatientWiseCombinedReport(fDate, tDate, OrgID, physicianID, out lstPatientWiseCombinedReport);
            if (lstPatientWiseCombinedReport.Count > 0)
            {
                gvReport.Visible = true;
                gvReport.DataSource = lstPatientWiseCombinedReport;
                gvReport.DataBind();
                lblMessage.Visible = false;
            }
            else
            {
                gvReport.Visible = false;
                lblMessage.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, GetPatientWiseCombinedReport", ex);
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
