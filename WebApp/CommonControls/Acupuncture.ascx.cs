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

public partial class CommonControls_Acupuncture : BaseControl 
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
        var lstAcupuncture = from s in lsthisPCA
                                   where s.ComplaintID == ID
                                   select s;
        if (lstAcupuncture.Count() > 0)
        {

        }
        rdoNo_963.Checked = true;
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
                rdoYes_963.Checked = true;
                divrdoYes_963.Style.Add("display", "block");
                txtAcupuncture.Text = lstEditData[j].AttributeValueName;
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
        if (rdoYes_963.Checked == true)
        {
            PatientComplaint objpatientcomplaint = new PatientComplaint();
            objpatientcomplaint.ComplaintID = Convert.ToInt32(963);
            objpatientcomplaint.ComplaintName = rdoYes_963.Text;
            Istpatientcomplaint.Add(objpatientcomplaint);
            attribute.Add(objpatientcomplaint);
            PatientComplaintAttribute objpatientcomplaintattribute = new PatientComplaintAttribute();
            if (txtAcupuncture.Text != "")
            {
                objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(963);
                objpatientcomplaintattribute.AttributeID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributevalueID = Convert.ToInt32(0);
                objpatientcomplaintattribute.AttributeValueName = txtAcupuncture.Text;
                Istpatientcomplaintattribute.Add(objpatientcomplaintattribute);
                attrvalue.Add(objpatientcomplaintattribute);
            }
            else
            {
                objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(963);
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
