using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
public partial class Nurse_PrintPatientBMI : BasePage
{

    public Nurse_PrintPatientBMI()
        : base("Nurse\\PrintPatientBMI.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
   long iPatientID = -1;
    string type = "I";
    int NewVitalsSetID = -1;
    long visitID = -1;
    long visitid = -1;
    long returnCode = -1;
    long patientID = -1;
    int VisitType = -1;
    long vType = -1;
    long VitalsCount = -1;
    string pid;
    protected void Page_Load(object sender, EventArgs e)
    {
        bool hasError = false;
        if (!Page.IsPostBack)
        {
            try
            {
                iPatientID = Convert.ToInt64(Request.QueryString["PID"]);
                patientID = iPatientID;
                returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);             
                if (visitID > 0)
                {
                    type = "U";
                    patientvitals.VisitID = visitID;
                    patientvitals.LoadControls(type, iPatientID);
                }
                else
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There is No visit for this patient.";
                }

                //type = "I";
                //patientvitals.VisitID = visitID;
                //patientvitals.LoadControls(type, patientID);
            }
            catch (SqlException sx)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(SqlException)", sx);
            }
            catch (ArithmeticException ax)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(ArithmeticException)", ax);
            }
            catch (Exception ex)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(Exception)", ex);
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}