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

public partial class CommonControls_Malaria : BaseControl
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
        var lstMalaria = from s in lsthisPCA
                         where s.ComplaintID == ID
                         select s;
        if (lstMalaria.Count() > 0)
        {

        }
        rdoNo_144.Checked = true;
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
                rdoYes_144.Checked = true;
                divrdoYes_144.Style.Add("display","block");
                txtMalaria.Text = lstEditData[j].AttributeValueName;
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

        if (rdoYes_144.Checked == true)
        {
            PatientComplaint objpatientcomplaint = new PatientComplaint();
            objpatientcomplaint.ComplaintID = Convert.ToInt32(144);
            objpatientcomplaint.ComplaintName = rdoNo_144.Text;
            lstpatientcomplaint.Add(objpatientcomplaint);
            attribute.Add(objpatientcomplaint);
            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            if (txtMalaria.Text != "")
            {
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(144);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtMalaria.Text;
                lstpatientcomplaintattribute.Add(objPatientComplaintAttribute);
                attrvalue.Add(objPatientComplaintAttribute);
            }
            else
            {
                objPatientComplaintAttribute.ComplaintID= Convert.ToInt32(144);
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



