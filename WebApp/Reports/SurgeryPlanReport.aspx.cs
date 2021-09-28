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

public partial class Reports_SurgeryPlanReport :BasePage 
{
    List<IPTreatmentPlanDetails> lstReportTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            //txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            //txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        long patientID = 0;

   
        List<IPTreatmentPlanDetails> lstReportTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
        IP_BL objBl = new IP_BL(base.ContextInfo);
        DateTime fromDate = Convert.ToDateTime(txtFDate.Text);
        DateTime tdate = Convert.ToDateTime(txtTDate.Text);
        objBl.GetIPTreatmentPlanDetailsReport(fromDate, tdate,0, out lstReportTreatmentPlanDetails);
        if (lstReportTreatmentPlanDetails.Count() > 0)
        {
            grdTreatementPlan.DataSource = lstReportTreatmentPlanDetails;
            grdTreatementPlan.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
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
    //protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    //{
    //    ExcelHelper.ExportToExcel(new List<Control> { grdTreatementPlan, lstReportTreatmentPlanDetails }, "Collection_ReportsOPIP_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls", Response);

    //}
}
