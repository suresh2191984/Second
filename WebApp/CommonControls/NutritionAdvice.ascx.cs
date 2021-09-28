using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_NutritionAdvice : BaseControl  
{
    public string nutritAdivce = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnNuAdvice.Value = "";
        }
    }
    public void setAdvice()
    {
        hdnNuAdvice.Value = "";
    }

    public List<PatientAdvice> GetNutritionAdvice(long patientVisitID)
    {
        string nutritionadvices = string.Empty;
        string newnutritionadvices = string.Empty;
        string gadtoRemove = string.Empty;

        if (hdnNAdviceDeleted.Value != null)
        {
            gadtoRemove = hdnNAdviceDeleted.Value.ToString();
        }
        List<PatientAdvice> gAdvices = new List<PatientAdvice>();

        if (hdnNuAdvice.Value != null)
        {
            nutritionadvices = hdnNuAdvice.Value.ToString();
        }
        string gasNewDatas = "";
        bool gabDeleted = false;
        foreach (string garow in nutritionadvices.Split('|'))
        {
            gabDeleted = false;
            foreach (string garemovedrow in gadtoRemove.Split('|'))
            {
                if (garow.Trim() == garemovedrow.Trim())
                {
                    gabDeleted = true;
                }
            }
            if (gabDeleted != true)
            {
                gasNewDatas += garow.ToString() + "|";
            }
        }
        gadid.Value = "";
        foreach (string row in gasNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                PatientAdvice gAdvice = new PatientAdvice();

                gAdvice.Description = "N-" + row.ToString();
                gAdvice.PatientVisitID = patientVisitID;
                gAdvice.CreatedBy = LID;
                gAdvices.Add(gAdvice);

            }
        }


        return gAdvices;
    }
    public void setNutritionAdvice(List<PatientAdvice> lstPatientAdvice)
    {
        int garowcount = 0;
        string sgeneraladvice = "";
        foreach (PatientAdvice pa in lstPatientAdvice)
        {
            garowcount++;
            string Description = pa.Description;
            if (Description.Split('-')[0] == "N")
            {
                nutritAdivce = "Description" + Description.Split('-')[1] + "|";
                sgeneraladvice += Description.Split('-')[1] + "|";
            }
        }
        hdnNuAdvice.Value = nutritAdivce;
        hdnNAdviceNameExists.Value = sgeneraladvice;
        this.Page.RegisterStartupScript("Scrpt2", "<script>gaNAdvCreateJavaScriptTables('" + sgeneraladvice + "') </Script>");
    }
}
