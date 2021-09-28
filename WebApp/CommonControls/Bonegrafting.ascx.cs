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

public partial class CommonControls_Bonegrafting : BaseControl
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


    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        var lstBonegraft = from s in lsthisPCA
                           where s.ComplaintID == ID
                           select s;
        if (lstBonegraft.Count() > 0)
        {

        }

    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].AttributeValueName!="")
            {
                rdoYes_968.Checked = true;
                txtBonegrafting.Text = lstEditData[j].AttributeValueName;
                divrdoYes_968.Style.Add("display", "block");
            }
        }
    }
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrvalue)
    {
        int returnval = -1;

        attribute = new List<PatientComplaint>();
        attrvalue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> Istpatientcomplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> Istpatientcomplaintattribute = new List<PatientComplaintAttribute>();
        if (rdoYes_968.Checked == true)
        {
            PatientComplaint objpatientcomplaint = new PatientComplaint();
            objpatientcomplaint.ComplaintID = Convert.ToInt32(968);
            objpatientcomplaint.ComplaintName = rdoYes_968.Text;
            Istpatientcomplaint.Add(objpatientcomplaint);
            attribute.Add(objpatientcomplaint);
            PatientComplaintAttribute objpatientcomplaintattribute = new PatientComplaintAttribute();
            if (txtBonegrafting.Text != "")
            {
                objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(968);
                objpatientcomplaintattribute.AttributeID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributevalueID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributeValueName = txtBonegrafting.Text;
                Istpatientcomplaintattribute.Add(objpatientcomplaintattribute);
                attrvalue.Add(objpatientcomplaintattribute);
            }
            else
            {
                objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(968);
                objpatientcomplaintattribute.AttributeID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributevalueID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributeValueName = "";
                Istpatientcomplaintattribute.Add(objpatientcomplaintattribute);
                attrvalue.Add(objpatientcomplaintattribute);
            }

        }
        return returnval;
    }
}
