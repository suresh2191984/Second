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

public partial class Corporate_ComplaintDes : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Get and Set The BackgroundProblem
    public List<PatientComplaint> GetPatientComplaint()
    {
        List<PatientComplaint> lstPatientComplaintTemp = new List<PatientComplaint>();

        if (hdnDiagnosisItems.Value != "")
        {
            foreach (string lstCmp in hdnDiagnosisItems.Value.Split('^'))
            {
                if (lstCmp != "")
                {
                    string[] listBP = lstCmp.Split('~');
                    PatientComplaint objBackgroundProblem = new PatientComplaint();
                    objBackgroundProblem.ICDCode = listBP[1];
                    objBackgroundProblem.ICDDescription = listBP[2];
                    lstPatientComplaintTemp.Add(objBackgroundProblem);
                }
            }
        }
        return lstPatientComplaintTemp;
    }
    #endregion

    public void LoadComplaintItems()
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadComplaintItems();", true);

    }
}

