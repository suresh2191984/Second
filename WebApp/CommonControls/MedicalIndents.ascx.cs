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

public partial class CommonControls_MedicalIndents : BaseControl
{
    public string prescription = string.Empty;
    List<DrugUseInstruction> lstDruguseInstruction = new List<DrugUseInstruction>();
     
    PatientVisit_BL objPVBL;
    long lResult = -1;
    private ViewMode adviceType;
    public ViewMode AdviceMode
    {
        get { return adviceType; }
        set { adviceType = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    ddlMedItem.Items.Clear();
         
        objPVBL = new PatientVisit_BL(base.ContextInfo);
        List<MedicalIndents> lstMedicalIndents = new List<MedicalIndents>();
        objPVBL.GetMedicalItems(out lstMedicalIndents, OrgID);
        ddlMedItem.Items.Clear();
        if (lstMedicalIndents.Count > 0)
        {
            ddlMedItem.DataSource = lstMedicalIndents;
            ddlMedItem.DataTextField = "ItemName";
            ddlMedItem.DataValueField = "ItemID";
            ddlMedItem.DataBind();
        }
        ddlMedItem.Items.Insert(0, new ListItem("--Select--", ""));
        //}
        MasterControl1.TableType = Attune.Podium.Common.FeeType.type.MedicalIndent;


    }
    string drugName = string.Empty;


    public List<PatientDueChart> GetIndents()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        if (hdnIndentDeleted.Value != null)
        {
            dtoRemove = hdnIndentDeleted.Value.ToString();
        }
        List<PatientDueChart> advices = new List<PatientDueChart>();

        if (hdfIndent.Value != null)
            prescription = hdfIndent.Value.ToString();

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
                    pDueChart.FeeType = "IND";
                    switch (colName)
                    {
                        case "INDName":
                            pDueChart.Description = colValue;
                            break;
                        case "INDUnit":
                            pDueChart.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "INDDesc":
                            pDueChart.Comments = colValue;
                            break;
                        case "INDFrom":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            pDueChart.FromDate = Convert.ToDateTime(colValue);
                            break;
                        case "INDTo":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            pDueChart.ToDate = Convert.ToDateTime(colValue);
                            break;
                        case "INDCode":
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
