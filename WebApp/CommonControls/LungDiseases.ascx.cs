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

public partial class CommonControls_LungDiseases : BaseControl
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
        var lstAsthma = from s in lsthisPCA
                        where s.ComplaintID == 246
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
        }
        rdoNo_959.Checked = true;
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
                divrdoYes_959.Style.Add("display", "block");
                rdoYes_959.Checked = true;
                //chkAsthma_246.Checked = true;
                //divchkAsthma_246.Style.Add("display", "block");
                if (lstEditData[j].AttributeID == 16)
                {
                    txtDuration_16.Text = lstEditData[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlDuration_16.Text = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 17)
                {
                    ddlTratment_17.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 18)
                {
                    chkExacerbations_18.Checked = true;
                    tdExacer.Style.Add("display", "block");
                    txtTimes_18.Text = lstEditData[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlExacerbations_18.SelectedValue = lstEditData[j].AttributevalueID.ToString();
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
        PatientComplaint objPatientComplaint = new PatientComplaint();
        
        if (rdoYes_959.Checked == true)
        {
            //if (chkAsthma_246.Checked == true)
            //{
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

                PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
                objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute1.AttributeID = Convert.ToInt32(18);
                objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(ddlExacerbations_18.SelectedItem.Value);
                objPatientComplaintAttribute1.AttributeValueName = txtTimes_18.Text+" " + ddlExacerbations_18.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
                attrValue.Add(objPatientComplaintAttribute1);

                PatientComplaintAttribute objPatientComplaintAttribute2 = new PatientComplaintAttribute();
                objPatientComplaintAttribute2.ComplaintID = Convert.ToInt32(246);
                objPatientComplaintAttribute2.AttributeID = Convert.ToInt32(16);
                objPatientComplaintAttribute2.AttributevalueID = Convert.ToInt32(ddlDuration_16.SelectedItem.Value);
                objPatientComplaintAttribute2.AttributeValueName = txtDuration_16.Text+" "  + ddlDuration_16.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute2);
                attrValue.Add(objPatientComplaintAttribute2);
            //}
        }
        return returnval;
    }
}
