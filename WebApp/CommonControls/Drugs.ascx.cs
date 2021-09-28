using System;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Podium.SmartAccessor;
using System.Linq;
using Attune.Podium.EMR;
using Attune.Podium.Common;
using System.Data;

public partial class CommonControls_Drugs : BaseControl
{
    private string id;
    private string attriName;
    public string AttriName
    {
        get { return attriName; }
        set
        {
            attriName = value;
        }
    }
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstCocaine = from s in lsthisPHA
                         where s.HistoryID == ID
                         select s;
        if (lstCocaine.Count() > 0)
        {
            List<EMRAttributeClass> drugs = (from t in lstCocaine
                                             where t.AttributeID == 125
                                             select new EMRAttributeClass
                                             {
                                                 AttributeName = t.AttributeName,
                                                 AttributevalueID = t.AttributevalueID,
                                                 AttributeValueName = t.AttributeValueName
                                             }).ToList();
            ddlDrugs_1063.DataSource = drugs.ToList();
            ddlDrugs_1063.DataTextField = "AttributeValueName";
            ddlDrugs_1063.DataValueField = "AttributevalueID";
            ddlDrugs_1063.DataBind();
        }

    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                     where s.HistoryID == ID
                                                     select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].AttributeID == 125)
            {
                ddlDrugs_1063.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                if (ddlDrugs_1063.SelectedItem.Text == "Others")
                {
                    divddlDrugs_1063.Style.Add("display", "block");
                    txtDrugs.Text = lstEditData[j].AttributeValueName.ToString();
                }
            }
            divrdoYes_1063.Style.Add("display", "block");
            rdoYes_1063.Checked = true;
        }

    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();
        if (rdoYes_1063.Checked == true)
        {
            PatientHistory objPatientHistory = new PatientHistory();
            objPatientHistory.HistoryID = Convert.ToInt32(1063);
            objPatientHistory.HistoryName = rdoYes_1063.Text;
            lstPatientHistory.Add(objPatientHistory);
            attribute.Add(objPatientHistory);
            PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
            if (ddlDrugs_1063.SelectedItem.Text == "Others")
            {
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1063);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(125);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(ddlDrugs_1063.SelectedValue);
                objPatientHistoryAttribute.AttributeValueName = txtDrugs.Text.ToString();
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);
            }
            else
            {
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1063);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(125);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(ddlDrugs_1063.SelectedValue);
                objPatientHistoryAttribute.AttributeValueName = ddlDrugs_1063.SelectedItem.Text.ToString();
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);
            }

        }
        return returnval;
    }
}
