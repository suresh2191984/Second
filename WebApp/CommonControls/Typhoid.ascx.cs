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

public partial class CommonControls_Typhoid : BaseControl
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
        var lstTyphoid = from s in lsthisPCA
                         where s.ComplaintID == ID
                         select s;
        if (lstTyphoid.Count() > 0)
        {

        }
        rdoNo_96.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].AttributeValueName != "")
            {
                divrdoYes_96.Style.Add("display", "block");
                rdoYes_96.Checked = true;
                txtTyphoid.Text = lstEditData[j].AttributeValueName;
            }
        }
    }
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrvalue)
    {
        int returnval = -1;

        attribute = new List<PatientComplaint>();
        attrvalue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstpatientcomplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstpatientcomplaintattribute = new List<PatientComplaintAttribute>();

        if (rdoYes_96.Checked == true)
        {
            PatientComplaint objpatientcomplaint = new PatientComplaint();
            objpatientcomplaint.ComplaintID = Convert.ToInt32(96);
            objpatientcomplaint.ComplaintName = rdoNo_96.Text;
            lstpatientcomplaint.Add(objpatientcomplaint);
            attribute.Add(objpatientcomplaint);
            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            if (txtTyphoid.Text != "")
            {
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(96);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtTyphoid.Text;
                lstpatientcomplaintattribute.Add(objPatientComplaintAttribute);
                attrvalue.Add(objPatientComplaintAttribute);
            }
            else
            {
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(96);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstpatientcomplaintattribute.Add(objPatientComplaintAttribute);
                attrvalue.Add(objPatientComplaintAttribute);
            }


        }
        return returnval;
    }
}