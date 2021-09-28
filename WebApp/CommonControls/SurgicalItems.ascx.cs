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

public partial class CommonControls_SurgicalItems : BaseControl
{
    public string prescription = string.Empty;
    List<DrugUseInstruction> lstDruguseInstruction = new List<DrugUseInstruction>();
    PatientPrescription_BL objPatientPrescriptionBL ;
    PatientVisit_BL objPVBL ;
    long lResult = -1;
    private ViewMode adviceType;
    public ViewMode AdviceMode
    {
        get { return adviceType; }
        set { adviceType = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        objPatientPrescriptionBL = new PatientPrescription_BL(base.ContextInfo);
        objPVBL = new PatientVisit_BL(base.ContextInfo);

        if (!IsPostBack)
        {
             
        }

      
    }
    string drugName = string.Empty;


    public List<PatientDueChart> GetSurgicalItems()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        if (hdfMedDelete.Value != null)
        {
            dtoRemove = hdfMedDelete.Value.ToString();
        }
        List<PatientDueChart> advices = new List<PatientDueChart>();

        if (hdfMedItems.Value != null)
            prescription = hdfMedItems.Value.ToString();

        string sNewDatas = "";
        bool bDeleted = false;
        foreach (string row in prescription.Split('|'))
        {
            bDeleted = false;
            foreach (string removedrow in dtoRemove.Split('|'))
            {
                if (row.Trim() == removedrow.Trim())
                {
                    bDeleted = true;
                }
            }
            if (bDeleted != true)
            {
                sNewDatas += row.ToString() + "|";
            }
        }

        did.Value = "";

        foreach (string row in sNewDatas.Split('|'))
        {
            if (row.Trim().Length != 0)
            {
                PatientDueChart pDueChart = new PatientDueChart();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    pDueChart.FeeType = "SUR";
                    switch (colName)
                    {
                        case "MEDName":
                            pDueChart.Description = colValue;
                            break;
                        case "MEDUnit":
                            pDueChart.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "MEDDesc":
                            pDueChart.Comments = colValue;
                            break;
                        case "MEDFrom":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            pDueChart.FromDate = Convert.ToDateTime(colValue);
                            break;
                        case "MEDTo":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            pDueChart.ToDate = Convert.ToDateTime(colValue);
                            break;
                        case "MEDCode":
                            pDueChart.FeeID =Convert.ToInt64(colValue);
                            break;
                    };
                }
                advices.Add(pDueChart);
            }
        }
        return advices;
    }
}
