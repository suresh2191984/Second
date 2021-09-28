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

public partial class CommonControls_Stroke : BaseControl
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
        var lststroke = from s in lsthisPCA
                        where s.ComplaintID == ID
                        select s;

        List<EMRAttributeClass> strokerecovery = (from d in lststroke
                                                  where d.AttributeID == 9
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeName = d.AttributeName,
                                                      AttributevalueID = d.AttributevalueID,
                                                      AttributeValueName = d.AttributeValueName
                                                  }).ToList();


        //lstEMRvalue.Name = "Complaint";
        //lstEMRvalue.Attributename = "Stroke";
        //lstEMRvalue.Attributeid = 9;
        //lstEMRvalue.Attributevaluename = strokerecovery[0].AttributeName;
        //EMR7.Bind(lstEMRvalue, strokerecovery);


        ddlRecovery_9.DataSource = strokerecovery.ToList();
        ddlRecovery_9.DataTextField = "AttributeValueName";
        ddlRecovery_9.DataValueField = "AttributevalueID";
        ddlRecovery_9.DataBind();

        List<EMRAttributeClass> strokecva = (from d in lststroke
                                             where d.AttributeID == 10
                                             select new EMRAttributeClass
                                             {
                                                 AttributeName = d.AttributeName,
                                                 AttributevalueID = d.AttributevalueID,
                                                 AttributeValueName = d.AttributeValueName
                                             }).ToList();


        //lstEMRvalue.Name = "Complaint";
        //lstEMRvalue.Attributename = "Stroke";
        //lstEMRvalue.Attributeid = 10;
        //lstEMRvalue.Attributevaluename = strokecva[0].AttributeName;
        //EMR8.Bind(lstEMRvalue, strokecva);


        ddlTypeOfCVA_10.DataSource = strokecva.ToList();
        ddlTypeOfCVA_10.DataTextField = "AttributeValueName";
        ddlTypeOfCVA_10.DataValueField = "AttributevalueID";
        ddlTypeOfCVA_10.DataBind();
        rdoNo_438.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA,long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                divrdoYes_438.Style.Add("display", "block");
                rdoYes_438.Checked = true;
                rdoNo_438.Checked = false;
                if (lstEditData[j].AttributeID == 8)
                {
                    txtDate_30.Text = lstEditData[j].AttributeValueName.ToString();
                }
                if (lstEditData[j].AttributeID == 9)
                {
                    ddlRecovery_9.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 10)
                {
                    ddlTypeOfCVA_10.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 11)
                {
                    txtLobeaffected_36.Text = lstEditData[j].AttributeValueName.ToString();
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

        if (rdoYes_438.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(438);    
            objPatientComplaint.ComplaintName = rdoYes_438.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);
            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            if (txtDate_30.Text != "")
            {
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(8);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(30);
                objPatientComplaintAttribute.AttributeValueName = txtDate_30.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);

            }
            else
            {
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(8);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(30);
                objPatientComplaintAttribute.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);

            }
            PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
            objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(438);
            objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(9);
            objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(ddlRecovery_9.SelectedValue);
            objPatientComplaintAttribute1.AttributeValueName = ddlTypeOfCVA_10.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
            attrValue.Add(objPatientComplaintAttribute1);

            PatientComplaintAttribute objPatientComplaintAttribute2 = new PatientComplaintAttribute();
            objPatientComplaintAttribute2.ComplaintID = Convert.ToInt32(438);
            objPatientComplaintAttribute2.AttributeID = Convert.ToInt64(10);
            objPatientComplaintAttribute2.AttributevalueID = Convert.ToInt32(ddlTypeOfCVA_10.SelectedValue);
            objPatientComplaintAttribute2.AttributeValueName = ddlTypeOfCVA_10.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute2);
            attrValue.Add(objPatientComplaintAttribute2);

            PatientComplaintAttribute objPatientComplaintAttribute3 = new PatientComplaintAttribute();
            if (txtLobeaffected_36.Text != "")
            {
                objPatientComplaintAttribute3.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute3.AttributeID = Convert.ToInt64(11);
                objPatientComplaintAttribute3.AttributevalueID = Convert.ToInt32(36);
                objPatientComplaintAttribute3.AttributeValueName = txtLobeaffected_36.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute3);
                attrValue.Add(objPatientComplaintAttribute3);

            }
            else
            {
                objPatientComplaintAttribute3.ComplaintID = Convert.ToInt32(438);
                objPatientComplaintAttribute3.AttributeID = Convert.ToInt64(11);
                objPatientComplaintAttribute3.AttributevalueID = Convert.ToInt32(36);
                objPatientComplaintAttribute3.AttributeValueName = "";
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute3);
                attrValue.Add(objPatientComplaintAttribute3);

            }
        }
        return returnval;
    }
}
