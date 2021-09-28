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

public partial class Patient_PatientExaminationPackage : BasePage
{
    long patientID = -1;
    long visitID = -1;
    long returnCode = -1;
    long taskID = -1;
    List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
    List<PatientExaminationAttribute> lstPEA = new List<PatientExaminationAttribute>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientExaminationAttribute> lstExam = new List<PatientExaminationAttribute>();
    List<PatientExaminationAttribute> lstAttribute = new List<PatientExaminationAttribute>();

    SmartAccessor smrtAccessor ;

    protected void Page_Load(object sender, EventArgs e)
    {
        smrtAccessor = new SmartAccessor(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        if (!IsPostBack)
        {
            returnCode = new SmartAccessor(base.ContextInfo).GetPatientExamPackage(visitID, OrgID, out lstPEA, out lstVitalsUOMJoin,out lstExam,out lstAttribute);

            //PatientVitalsControl.FindControl("txtTemp").Focus();
            PatientVitalsControl.VisitID = visitID;


            if (Request.QueryString["mode"] == "U" && lstVitalsUOMJoin.Count > 0)
            {
                PatientVitalsControl.LoadControls("U", patientID);
            }
            else
            {
                PatientVitalsControl.LoadControls("I", patientID);
            }

           ucSkin.SetData(lstPEA);

           ucHair.SetData(lstPEA);

           ucNails.SetData(lstPEA);

           ucScars.SetData(lstPEA);

           ucEye.SetData(lstPEA);

           ucEar.SetData(lstPEA);

           ucNeck.SetData(lstPEA);

           ucRS.SetData(lstPEA);

           OralCavity1.SetData(lstPEA);

           NeurologicaExamination1.SetData(lstPEA);

           GynaecologicalExam1.SetData(lstPEA);

           RectalExamination1.SetData(lstPEA);

           CardiovascularExam1.SetData(lstPEA);

           AbdominalExam1.SetData(lstPEA);       

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        try
        {
            smrtAccessor.InitForSave();

            ArrayList attList = new ArrayList();
            ArrayList attListValues = new ArrayList();

            ucSkin.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucHair.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucNails.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucScars.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucEye.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucEar.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucNeck.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            ucRS.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            OralCavity1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            NeurologicaExamination1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            GynaecologicalExam1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            RectalExamination1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            CardiovascularExam1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            AbdominalExam1.GetData(out attList, out attListValues);
            smrtAccessor.SetAll(attList, attListValues);

            PatientVitalsControl.GetPageValues(out lstPatientVitals);


            returnCode = new SmartAccessor(base.ContextInfo).InsertExaminationPKG(visitID, patientID, LID, OrgID, lstPatientVitals);

            Response.Redirect(@"../Patient/PrintExamination.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID, true);
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
    protected void btnEMRHistory_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect(@"../Patient/PatientHistoryPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&emr=" + "HIS", true);
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
