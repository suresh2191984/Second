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

public partial class HealthPackageControls_Hair : BaseControl
{
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR2.DDL = ddlHairType_3;
        if (IsPostBack)
        {
            if (chkHair_915.Checked == true)
            {
                tr1chkHair_915.Attributes.Add("Style", "Display:Block");
            }
        }
    }  

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        var list = from S in lstPEA
                   where S.ExaminationID == 915
                   select S;

        List<EMRAttributeClass> typelist = (from s in list
                       where s.AttributeID == 3
                       select new EMRAttributeClass 
                       {
                           AttributeName = s.AttributeName, 
                           AttributevalueID=s.AttributevalueID,
                          AttributeValueName= s.AttributeValueName
                       }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Hair";
        lstEMRvalue.Attributeid = 3;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;
        EMR2.Bind(lstEMRvalue, typelist);
        ddlHairType_3.DataSource = typelist.ToList();
        ddlHairType_3.DataTextField = "AttributeValueName";
        ddlHairType_3.DataValueField = "AttributevalueID";
        ddlHairType_3.DataBind();
        ddlHairType_3.Items.Insert(0, "---Select---");



    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        var list = from S in lstPEA
                   where S.ExaminationID == 915
                   select S;

        foreach (PatientExaminationAttribute objPEA in list)
        {

            if (objPEA.ExaminationID == 915)
            {
                chkHair_915.Checked = true;
                tr1chkHair_915.Style.Add("display", "block");
                ddlHairType_3.SelectedValue = objPEA.AttributevalueID.ToString();

            }
        }

    }

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Hair
        if (chkHair_915.Checked == true && ddlHairType_3.SelectedItem.Text != "---Select---")
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 915;
            objPatientExamination.ExaminationName = chkHair_915.Text;
            attribute.Add(objPatientExamination);

            #region lblHairType_3
            if (ddlHairType_3.SelectedItem.Text != "---Select---")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 915;
                objPatientExaminationAttribute.AttributeID = 3;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlHairType_3.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlHairType_3.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion
        return returnval;
    }

}
