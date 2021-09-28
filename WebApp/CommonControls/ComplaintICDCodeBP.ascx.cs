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


public partial class CommonControls_ComplaintICDCodeBP : BaseControl
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }
    string  strSelect = Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_01 == null ? "Diagnosis" : Resources.CommonControls_ClientDisplay.CommonControls_ComplaintICDCodeBP_ascx_01;
    public CommonControls_ComplaintICDCodeBP()
        : base("CommonControls_ComplaintICDCodeBP_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblComplaint.Text = ComplaintHeader;
        if (lblComplaint.Text == "")
        { lblComplaint.Text = strSelect; }
    }
    


    #region Get and Set The BackgroundProblem
    public List<BackgroundProblem> GetPatientBackgroundProblem(string PreparedAt, long patientID, long patientVisitID)
    {
        List<BackgroundProblem> lstBackgroundProblemTemp = new List<BackgroundProblem>();

        if (hdnDiagnosisItems.Value != "")
        {
            foreach (string lstRiskFactor in hdnDiagnosisItems.Value.Split('^'))
            {

                if (lstRiskFactor != "")
                {
                    string[] listBP = lstRiskFactor.Split('~');
                    BackgroundProblem objBackgroundProblem = new BackgroundProblem();
                    objBackgroundProblem.ComplaintID =0;
                    objBackgroundProblem.ComplaintName = listBP[1];
                    objBackgroundProblem.Description = "";
                    objBackgroundProblem.CreatedBy = LID;
                    objBackgroundProblem.PatientVisitID = patientVisitID;
                    objBackgroundProblem.PatientID = patientID;
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
        return lstBackgroundProblemTemp;
    }


    public void SetPatientBackgroundProblem(List<BackgroundProblem> lstBackgroundProblem)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (BackgroundProblem objPB in lstBackgroundProblem)
        {
            hdnDiagnosisItems.Value += i + "~" + objPB.ComplaintName + "~" + objPB.ComplaintID + "~" + objPB.ICDCode + "~" + objPB.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItemsBP();", true);
    }
    #endregion

    public string Returnval()
    {
      return  hdnDiagnosisItems.Value.ToString();
    }

    #region Get and Set The SecondaryCauseOfDeath
    public List<CauseOfDeath> GetCauseOfDeath(string CauseOfDeathType)
    {

        List<CauseOfDeath> lstCauseOfDeathTemp = new List<CauseOfDeath>();

        foreach (string lstCOD in hdnDiagnosisItems.Value.Split('^'))
        {

            if (lstCOD != "")
            {
                CauseOfDeath objCauseOfDeath = new CauseOfDeath();
                string[] lstChildData = lstCOD.Split('~');
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = CauseOfDeathType;
                objCauseOfDeath.ComplaintID = 0;
                objCauseOfDeath.ComplaintName = lstChildData[1];
                objCauseOfDeath.ICDCode = lstChildData[3];
                objCauseOfDeath.ICDDescription = lstChildData[4];
                if (objCauseOfDeath.ICDCode == "")
                {
                    objCauseOfDeath.ICDCodeStatus = "Pending";
                }
                else
                {
                    objCauseOfDeath.ICDCodeStatus = "Completed";
                }
                lstCauseOfDeathTemp.Add(objCauseOfDeath);
            }
        }

        return lstCauseOfDeathTemp;
    }

    public void SetCauseOfDeath(List<CauseOfDeath> lstCauseOfDeath)
    {
        lblComplaint.Text = ComplaintHeader;

        hdnDiagnosisItems.Value = "";
        int i = 110;
        foreach (CauseOfDeath objItem in lstCauseOfDeath)
        {
            hdnDiagnosisItems.Value += i + "~" + objItem.ComplaintName + "~" + objItem.ComplaintID + "~" + objItem.ICDCode + "~" + objItem.ICDDescription + "^";
            i += 1;
        }


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItemsBP();", true);
    }


    #endregion
    public void LoadComplaintItems()
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItemsBP();", true);

    }

    public void hdnClear()
    {
        hdnDiagnosisItems.Value = "";
    }

    public void SetComplaint()
    {
        txtCpmlaint.Text = ComplaintName;
        hdnFlag.Value = "N";

        if (AddBtnVisible == "False")
        {
            btnHistoryAdd.Visible = false;
            txtCpmlaint.ReadOnly = true;
        }
    }

    public void SetWidth(int Width)
    {
        txtCpmlaint.Width = Width;
        txtICDCode.Width = Width;
        txtICDName.Width = Width;

        AutoCompleteExtender3.CompletionListCssClass="wordWheelC listMainC .boxC";
        AutoCompleteExtender3.CompletionListItemCssClass="wordWheelC itemsMainC";
        AutoCompleteExtender3.CompletionListHighlightedItemCssClass = "wordWheelC itemsSelectedC";

        AutoCompleteExtender1.CompletionListCssClass = "wordWheelC listMainC .boxC";
        AutoCompleteExtender1.CompletionListItemCssClass = "wordWheelC itemsMainC";
        AutoCompleteExtender1.CompletionListHighlightedItemCssClass = "wordWheelC itemsSelectedC";


        AutoCompleteExtender2.CompletionListCssClass = "wordWheelC listMainC .boxC";
        AutoCompleteExtender2.CompletionListItemCssClass = "wordWheelC itemsMainC";
        AutoCompleteExtender2.CompletionListHighlightedItemCssClass = "wordWheelC itemsSelectedC";
      
    }
    
}
