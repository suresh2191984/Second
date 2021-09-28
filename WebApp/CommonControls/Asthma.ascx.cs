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

public partial class CommonControls_Asthma : BaseControl
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
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        if (rdoYes_246.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = 246;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt64(17);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTratment_17.SelectedItem.Value);
            objPatientComplaintAttribute.AttributeValueName = ddlTratment_17.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);

            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt32(18);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlExacerbations_18.SelectedItem.Value);
            objPatientComplaintAttribute.AttributeValueName = txtTimes_18.Text + ddlExacerbations_18.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);

            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(246);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt32(16);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_16.SelectedItem.Value);
            objPatientComplaintAttribute.AttributeValueName = txtDuration_16.Text + ddlDuration_16.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);
        }
        return returnval;
    }
    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long ID)
    {
        var lstAsthma = from s in lsthisPCA
                         where s.ComplaintID == ID
                         select s;
        if (lstAsthma.Count() > 0)
        {
            List<EMRAttributeClass> asthmatreatment = (from d in lstAsthma
                                                       where d.AttributeID == 17
                                                       select new EMRAttributeClass
                                                       {
                                                           AttributeName = d.AttributeName,
                                                           AttributevalueID = d.AttributevalueID,
                                                           AttributeValueName = d.AttributeValueName
                                                       }).ToList();

            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "Asthma";
            //lstEMRvalue.Attributeid = 17;
            //lstEMRvalue.Attributevaluename = asthmatreatment[0].AttributeName;
            //EMR12.Bind(lstEMRvalue, asthmatreatment);


            ddlTratment_17.DataSource = asthmatreatment.ToList();
            ddlTratment_17.DataTextField = "AttributeValueName";
            ddlTratment_17.DataValueField = "AttributevalueID";
            ddlTratment_17.DataBind();

            List<EMRAttributeClass> asthmaduration = (from d in lstAsthma
                                                      where d.AttributeID == 16
                                                      select new EMRAttributeClass
                                                      {
                                                          AttributeName = d.AttributeName,
                                                          AttributevalueID = d.AttributevalueID,
                                                          AttributeValueName = d.AttributeValueName
                                                      }).ToList();

            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "Asthma";
            //lstEMRvalue.Attributeid = 16;
            //lstEMRvalue.Attributevaluename = asthmaduration[0].AttributeName;
            //EMR31.Bind(lstEMRvalue, asthmaduration);


            ddlDuration_16.DataSource = asthmaduration.ToList();
            ddlDuration_16.DataTextField = "AttributeValueName";
            ddlDuration_16.DataValueField = "AttributevalueID";
            ddlDuration_16.DataBind();

            List<EMRAttributeClass> asthmaExacerbations = (from d in lstAsthma
                                                           where d.AttributeID == 18
                                                           select new EMRAttributeClass
                                                           {
                                                               AttributeName = d.AttributeName,
                                                               AttributevalueID = d.AttributevalueID,
                                                               AttributeValueName = d.AttributeValueName
                                                           }).ToList();
            ddlExacerbations_18.DataSource = asthmaExacerbations;
            ddlExacerbations_18.DataTextField = "AttributeValueName";
            ddlExacerbations_18.DataValueField = "AttributevalueID";
            ddlExacerbations_18.DataBind();

            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "asthma";
            //lstEMRvalue.Attributeid = 18;
            //lstEMRvalue.Attributevaluename = asthmaExacerbations[0].AttributeName;
            //EMR13.Bind(lstEMRvalue, asthmaExacerbations);
        }
        rdoNo_246.Checked = true;
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
                divrdoYes_246.Style.Add("display", "block");
                rdoYes_246.Checked = true;
                rdoNo_246.Checked = false;
                if (lstPCA[j].AttributeID == 16)
                {
                    txtDuration_16.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlDuration_16.Text = lstPCA[j].AttributevalueID.ToString();
                }
                if (lstPCA[j].AttributeID == 17)
                {
                    ddlTratment_17.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                }
                if (lstPCA[j].AttributeID == 18)
                {
                    chkExacerbations_18.Checked = true;
                    txtTimes_18.Text = lstPCA[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlExacerbations_18.SelectedValue = lstPCA[j].AttributevalueID.ToString();
                }
            }
        }
    }
}
