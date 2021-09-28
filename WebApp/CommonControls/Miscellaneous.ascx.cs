using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;
using Attune.Podium.Common;

public partial class CommonControls_Miscellaneous : BaseControl 
{
    List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    string NextReview = string.Empty;
    string NextReviewNos = string.Empty;
    string NextReviewDMY = string.Empty;
    string[] nReview;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region Get CheckboxValue
    public bool GetValue()
    {
        if (chkRefer.Checked == true)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    #endregion

    #region Get Admit& Next Review
    public List<PatientVisit> GetAdmitAndNextReview()
    {
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        PatientVisit objPatientVisit = new PatientVisit();
        try
        {
            objPatientVisit.NextReviewDate = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();
            if (chkAdmit.Checked == true)
            {
                objPatientVisit.AdmissionSuggested = "Y";
            }
            else
            {
                objPatientVisit.AdmissionSuggested = "";
            }
            lstPatientVisit.Add(objPatientVisit);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Admit& Next Review() in CommonControls_Miscellaneous", ex);
        }
        return lstPatientVisit;
    }
    #endregion

    #region Load Admission And Next Review Date
    public void LoadAdmissionAndNextReview(long VisitID)
    {
        try
        {
            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(VisitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
            if ((lstPatientVisit[0].NextReviewDate != null) && (lstPatientVisit[0].NextReviewDate != ""))
            {
                NextReview = lstPatientVisit[0].NextReviewDate;
                nReview = NextReview.Split('-');
                if (nReview.Length > 0)
                {
                    NextReviewNos = nReview[0].ToString();
                    NextReviewDMY = nReview[1].ToString();
                    ddlNos.SelectedValue = NextReviewNos;
                    ddlDMY.SelectedValue = NextReviewDMY;
                }
            }
            if (lstPatientVisit[0].AdmissionSuggested == "Y")
            {
                chkAdmit.Checked = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Patient Visit In Miscallaneous", ex);
        }
    }
    #endregion
}
