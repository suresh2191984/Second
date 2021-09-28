using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;

public partial class Patient_PrintEMRPackages : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            PrintHistory1.LoadHistoryData(visitID);
            PrintExam1.LoadExamData(visitID);
            PrintDiagnostics1.LoadDiagnostics(visitID);
            List<PatientRecommendationDtls> rTemplate = new List<PatientRecommendationDtls>();
            List<PhysicianSchedule> lstschedules = new List<PhysicianSchedule>();
            List<Patient> patientList = new List<Patient>();

            try
            {
                new Patient_BL(base.ContextInfo).GetPatientRecommendationDetails(OrgID, visitID, patientID, 
                    out  rTemplate, out lstschedules, out patientList); 
                grdResult.DataSource = rTemplate;
                grdResult.DataBind();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in PageLoad GetPatientRecommendationDetails", ex);
            }
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        try
        {
            Response.Redirect("../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&mode=" + "U", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        try
        {
            Response.Redirect("../Patient/PatientRecommendation.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
}
