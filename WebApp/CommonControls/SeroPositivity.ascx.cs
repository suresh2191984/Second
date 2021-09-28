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

public partial class CommonControls_SeroPositivity : BaseControl
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
    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        var lstSchizophrenia = from s in lsthisPCA
                               where s.ComplaintID == ID
                               select s;
        if (lstSchizophrenia.Count() > 0)
        {
            //List<EMRAttributeClass> cancertype = (from d in lstcancer
            //                                      where d.AttributeID == 13
            //                                      select new EMRAttributeClass
            //                                      {
            //                                          AttributeName = d.AttributeName,
            //                                          AttributevalueID = d.AttributevalueID,
            //                                          AttributeValueName = d.AttributeValueName
            //                                      }).ToList();


            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "Cancer";
            //lstEMRvalue.Attributeid = 13;
            //lstEMRvalue.Attributevaluename = cancertype[0].AttributeName;
            ////EMR9.Bind(lstEMRvalue, cancertype);


            //ddlTypeofcancer_13.DataSource = cancertype.ToList();
            //ddlTypeofcancer_13.DataTextField = "AttributeValueName";
            //ddlTypeofcancer_13.DataValueField = "AttributevalueID";
            //ddlTypeofcancer_13.DataBind();

        }
        rdoNo_949.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                if (lstEditData[j].AttributeValueName != "")
                {
                    string[] Text=lstEditData[j].AttributeValueName.Split('~');
                    divrdoYes_949.Style.Add("display", "block");
                    rdoYes_949.Checked = true;
                    rdoNo_949.Checked = false;
                    for (int i = 0; i < Text.Length; i++)
                    {
                        if (Text[i] == "HIV")
                            chkHiv.Checked = true;
                        if (Text[i] == "HepititisB")
                            chkHepititisB.Checked = true;
                        if (Text[i] == "HepititisC")
                            chkHepititisC.Checked = true;
                    }
                    //txtSchizophrenia.Text = lstEditData[j].AttributeValueName.ToString();
                }
                else
                {
                     
                }
            }
        }
    }
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        if (rdoYes_949.Checked == true)
        {
            string Text = string.Empty;
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(949);
            objPatientComplaint.ComplaintName = rdoYes_949.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);
            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(949);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt64(31);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
            if (chkHiv.Checked == true)
                Text = Text+"~" + chkHiv.Text;
            if (chkHepititisB.Checked == true)
                Text = Text+"~" + chkHepititisB.Text;
            if (chkHepititisC.Checked == true)
                Text = Text+"~" + chkHepititisC.Text;
            if (Text != "")
                objPatientComplaintAttribute.AttributeValueName = Text;
            else
                objPatientComplaintAttribute.AttributeValueName = "";
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);
        }
        return returnval;
    }
}
