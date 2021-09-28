using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Physician_Diagnose : BasePage
{
    long patientVisitID = -1;
    int taskID = -1;
    long patientID = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sRedirectURL = Convert.ToString(Request.QueryString["RedirectURL"]);
            string sQueryPath = Request.Url.PathAndQuery;

            if (sRedirectURL == null || sRedirectURL == "")
            {
                sRedirectURL = Request.UrlReferrer.PathAndQuery;

                if (sRedirectURL.Contains("RedirectURL"))
                {
                    sRedirectURL = sRedirectURL.Substring(0, sRedirectURL.IndexOf("RedirectURL") - 1);
                }
            }

            if (sQueryPath.Contains("RedirectURL"))
            {
                sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL") - 1);
            }

            sRedirectURL = sRedirectURL.Replace("^~", "&");
            sQueryPath = sQueryPath.Replace("&", "^~");

            if (sRedirectURL.Contains("?"))
                sRedirectURL = sRedirectURL + "&RedirectURL=" + sQueryPath;
            else
                sRedirectURL = sRedirectURL + "?RedirectURL=" + sQueryPath;

            lblRedirectURL.Text = sRedirectURL;
        }

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int32.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);

        patientHeader.PatientID = patientID;
        patientHeader.PatientVisitID = patientVisitID;
        patientHeader.ShowVitalsDetails();

        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        Patient patient = new Patient();
        patientBL.GetPatientDetailsPassingVisitID(patientVisitID, out lstPatient);
        patient = lstPatient[0];
        Session["PatientID"] = patientID;
        Session["PatientVisitID"] = patientVisitID;
        Session["TaskID"] = taskID;

        if (patient.SEX == "F")
        {
            //Page.RegisterStartupScript("x", "<script>document.getElementById('embFlsh').src='FDiagnose.swf'</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "x", "<script>document.getElementById('divFemale').style.display='block'</script>");
        }
        else if (patient.SEX == "M")
        {
            //Page.RegisterStartupScript("x", "<script>document.getElementById('embFlsh').src='MDiagnose.swf'</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "x", "<script>document.getElementById('divMale').style.display='block'</script>");
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(lblRedirectURL.Text);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnQuickDiagnose_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Physician/QuickDiagnosis.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&id=-1" + "", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
