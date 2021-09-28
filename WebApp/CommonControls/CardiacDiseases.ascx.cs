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

public partial class CommonControls_CardiacDiseases : BaseControl
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
        try
        {
            //lsthisPCA = new List<PatientComplaintAttribute>();

            trrdoYes_332.Attributes.Add("style", "display:block");
            trrdoYes_332.Attributes.Add("style", "display:block");
            rdoYes_332.Visible = true;
            var lstcardiac = from s in lsthisPCA
                               where s.ComplaintID == ID
                               select s;
            for (int i = 0; i < lstcardiac.Count(); i++)
            {
                List<EMRAttributeClass> Cardiac = (from d in lstcardiac
                                                               where d.AttributeID == 3
                                                               select new EMRAttributeClass
                                                               {
                                                                   AttributeName = d.AttributeName,
                                                                   AttributevalueID = d.AttributevalueID,
                                                                   AttributeValueName = d.AttributeValueName
                                                               }).ToList();
                ddlDiseaseType_3.DataSource = Cardiac.ToList();
                ddlDiseaseType_3.DataTextField = "AttributeValueName";
                ddlDiseaseType_3.DataValueField = "AttributevalueID";
                ddlDiseaseType_3.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
        rdoNo_332.Checked = true;
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
                divrdoYes_332.Style.Add("display", "block");
                rdoYes_332.Checked = true;
                rdoNo_332.Checked = false;
                if (lstEditData[j].AttributeID == 3)
                {
                    //txtDuration_5.Text = lstEditData[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlDiseaseType_3.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 4)
                {
                    txtDisease_17.Text = lstEditData[j].AttributeValueName.ToString();
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
        if (rdoYes_332.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = 332;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(332);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt64(3);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDiseaseType_3.SelectedValue);
            if (ddlDiseaseType_3.SelectedItem.Text == "Others")
            {
                objPatientComplaintAttribute.AttributeValueName = txtothers_16.Text;
            }
            else
            {
                objPatientComplaintAttribute.AttributeValueName = ddlDiseaseType_3.SelectedItem.Text;
            }
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);
            PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
            if (txtDisease_17.Text != "")
            {
                objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(332);
                objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(4);
                objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute1.AttributeValueName = txtDisease_17.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
                attrValue.Add(objPatientComplaintAttribute1);
            }
            else
            {
                objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(332);
                objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(4);
                objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute1.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
                attrValue.Add(objPatientComplaintAttribute1);
            }
        }
        return returnval;
    }
}
