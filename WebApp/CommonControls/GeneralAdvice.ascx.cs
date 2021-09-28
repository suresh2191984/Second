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

public partial class CommonControls_GeneralAdvice : BaseControl
{
    public string genadvice = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdfAdvice.Value = "";
        }
    }
    public void setAdvice()
    {
        hdfAdvice.Value = "";
    }
    public List<PatientAdvice> GetGeneralAdvice(long patientVisitID)
    {
        string generaladvices = string.Empty;
        string newgeneraladvices = string.Empty;
        string gadtoRemove = string.Empty;

        if (hdnAdviceDeleted.Value != null)
        {
            gadtoRemove = hdnAdviceDeleted.Value.ToString();
        }
        List<PatientAdvice> gAdvices = new List<PatientAdvice>();

        if (hdfAdvice.Value != null)
        {
            generaladvices = hdfAdvice.Value.ToString();
        }
        string gasNewDatas = "";
        bool gabDeleted = false;
        foreach (string garow in generaladvices.Split('|'))
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

                gAdvice.Description = "G-" + row.ToString();
                gAdvice.PatientVisitID = patientVisitID;
                gAdvice.CreatedBy = LID;
                gAdvices.Add(gAdvice);

            }
        }
        if (gasNewDatas == "")
        {
            if (IsCorporateOrg == "Y")
            {
                PatientAdvice gAdvice = new PatientAdvice();
                gAdvice.PatientVisitID = patientVisitID;
                gAdvice.CreatedBy = LID;
                gAdvices.Add(gAdvice);
            }
        }
    return gAdvices;
    }

    public void setGeneralAdvice(List<PatientAdvice> lstPatientAdvice)
    {
        int garowcount = 0;
        string sgeneraladvice = "";
        foreach (PatientAdvice pa in lstPatientAdvice)
        {
            garowcount++;
            string Description = (pa.Description == "" || pa.Description == null) ? "" : pa.Description;
            if (Description.Split('-')[0] == "G")
            {
                genadvice = "Description" + Description.Split('-')[1] + "|";
                sgeneraladvice += Description.Split('-')[1] + "|";
            }
        }
        hdfAdvice.Value = genadvice;
        hdnAdviceNameExists.Value = sgeneraladvice;
        this.Page.RegisterStartupScript("Scrpt1", "<script>gaCreateJavaScriptTables('" + sgeneraladvice + "') </Script>");
    }
}
