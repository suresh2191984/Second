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

public partial class CommonControls_AddDiagonosis : BaseControl 
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        //lblComplaint.Text = ComplaintHeader;

    }

    

    #region Get and Set The PatientComplaint
    public List<PatientComplaint> GetPatientComplaint(string ComplaintType, long VisitID)
    {
        hdnDiagnosisItemsTemp.Value = hdnDiagnosisItems.Value + hdnCPTempValues.Value;

        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();
        foreach (string listParentDiagnosis in hdnDiagnosisItemsTemp.Value.Split('^'))
        {
            if (listParentDiagnosis != "")
            {
                PatientComplaint objPatientComplaint = new PatientComplaint();
                string[] listChildDiagnosis = listParentDiagnosis.Split('~');

                if (listChildDiagnosis[5] == "N")
                {
                    objPatientComplaint.ComplaintID =0;


                    objPatientComplaint.ComplaintName = listChildDiagnosis[1];
                    objPatientComplaint.CreatedBy = LID;
                    objPatientComplaint.PatientVisitID = VisitID;
                    objPatientComplaint.ComplaintType = ComplaintType;
                    objPatientComplaint.ICDCode = listChildDiagnosis[3];
                    if (objPatientComplaint.ICDCode == "")
                    {
                        objPatientComplaint.ICDCodeStatus = "Pending";
                    }
                    else
                    {
                        objPatientComplaint.ICDCodeStatus = "Completed";
                    }
                    objPatientComplaint.ICDDescription = listChildDiagnosis[4];
                    lstPatientComplaintTemp.Add(objPatientComplaint);
                }
            }
        }
        hdnDiagnosisItemsTemp.Value = "";
        return lstPatientComplaintTemp;
    }
    

    public void SetPatientComplaint(List<PatientComplaint> lstPatientComplaint)
    {
        //lblComplaint.Text = ComplaintHeader;

        hdnCPTempValues.Value = "";
        int i = 110;
        foreach (PatientComplaint objPC in lstPatientComplaint)
        {
            hdnCPTempValues.Value += i + "~" + objPC.ComplaintName + "~" + objPC.ComplaintID + "~" + objPC.ICDCode + "~" + objPC.ICDDescription + "~" + "N" + "^";
            i += 1;
        }


        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
    }

    #endregion

    #region Get and Set The BackgroundProblem
    public List<BackgroundProblem> GetPatientBackgroundProblem(string PreparedAt, long patientID, long patientVisitID)
    {
        List<BackgroundProblem> lstBackgroundProblemTemp = new List<BackgroundProblem>();

        hdnDiagnosisItemsTemp.Value = hdnDiagnosisItems.Value + hdnvalues.Value;
        if (hdnDiagnosisItems.Value != "")
        {
            foreach (string lstRiskFactor in hdnDiagnosisItemsTemp.Value.Split('^'))
            {

                if (lstRiskFactor != "")
                {
                    string[] listBP = lstRiskFactor.Split('~');
                    BackgroundProblem objBackgroundProblem = new BackgroundProblem();
                    if (listBP[5] == "Y")
                    {
                        objBackgroundProblem.ComplaintID = 0;
                        objBackgroundProblem.ComplaintName = listBP[1];
                        objBackgroundProblem.Description = "";
                        objBackgroundProblem.CreatedBy = LID;
                        objBackgroundProblem.PatientVisitID = patientVisitID;
                        objBackgroundProblem.PreparedAt = PreparedAt;
                        objBackgroundProblem.ICDCode = listBP[3];
                        objBackgroundProblem.ICDDescription = listBP[4];

                        if (objBackgroundProblem.ICDCode == "")
                        {
                            objBackgroundProblem.ICDCodeStatus = "Pending";
                        }
                        else
                        {
                            objBackgroundProblem.ICDCodeStatus = "Completed";
                        }
                        lstBackgroundProblemTemp.Add(objBackgroundProblem);
                    }
                }
            }
        }
        hdnDiagnosisItemsTemp.Value = "";
        return lstBackgroundProblemTemp;
    }
    
    public void SetPatientBackgroundProblem(List<PatientComplaint> lstBackgroundProblem)
    {
        //lblComplaint.Text = ComplaintHeader;

        hdnvalues.Value = "";
        int i = 110;
        foreach (PatientComplaint objPB in lstBackgroundProblem)
        {
            hdnvalues.Value += i + "~" + objPB.ComplaintName + "~" + objPB.ComplaintID + "~" + objPB.ICDCode + "~" + objPB.ICDDescription + "~" + "Y" + "^";
            i += 1;
        }


        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);
        
    }



 
    #endregion

 

    public void hdnClear()
    {
        hdnDiagnosisItems.Value = "";
    }

 




}
