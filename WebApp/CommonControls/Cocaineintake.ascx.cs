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

public partial class CommonControls_Cocaineintake : BaseControl
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
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstCocaine = from s in lsthisPHA
                         where s.HistoryID == ID
                         select s;
        if (lstCocaine.Count() > 0)
        {
            List<EMRAttributeClass> drugs = (from t in lstCocaine
                                             where t.AttributeID == 123
                                             select new EMRAttributeClass
                                             {

                                                 AttributeName = t.AttributeName,
                                                 AttributevalueID = t.AttributevalueID,
                                                 AttributeValueName = t.AttributeValueName
                                             }).ToList();
            ddlDrugAbuse_1108.DataSource = drugs.ToList();
            ddlDrugAbuse_1108.DataTextField = "AttributeValueName";
            ddlDrugAbuse_1108.DataValueField = "AttributevalueID";
            ddlDrugAbuse_1108.DataBind();
        }
        rdoNo_1108.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                       where s.HistoryID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].HistoryID == ID)
            {
                divrdoYes_1108.Style.Add("display", "Green");
                rdoYes_1108.Checked = true;
                if (lstEditData[j].AttributeID == 123)
                {
                    ddlDrugAbuse_1108.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                    if (ddlDrugAbuse_1108.SelectedItem.Text == "Others")
                    {
                        divddlDrugAbuse_1108.Style.Add("display", "block");
                        txtDrugs.Text = lstEditData[j].AttributeValueName.ToString();
                    }
                }
            }
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();
        if (rdoYes_1108.Checked == true)
        {
            PatientHistory objPatientHistory = new PatientHistory();
            objPatientHistory.HistoryID = Convert.ToInt32(1108);
            objPatientHistory.HistoryName = rdoYes_1108.Text;
            lstPatientHistory.Add(objPatientHistory);
            attribute.Add(objPatientHistory);
            if (ddlDrugAbuse_1108.SelectedValue != "")
            {
                PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
                if (ddlDrugAbuse_1108.SelectedItem.Text == "Others")
                {
                    objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1108);
                    objPatientHistoryAttribute.AttributeID = Convert.ToInt64(123);
                    objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(ddlDrugAbuse_1108.SelectedValue);
                    objPatientHistoryAttribute.AttributeValueName = txtDrugs.Text;
                    lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                    attrValue.Add(objPatientHistoryAttribute);
                }
                else
                {
                    objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1108);
                    objPatientHistoryAttribute.AttributeID = Convert.ToInt64(123);
                    objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(ddlDrugAbuse_1108.SelectedValue);
                    objPatientHistoryAttribute.AttributeValueName = ddlDrugAbuse_1108.SelectedItem.Text;
                    lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                    attrValue.Add(objPatientHistoryAttribute);
                }
            }
        }
        return returnval;
    }

}



