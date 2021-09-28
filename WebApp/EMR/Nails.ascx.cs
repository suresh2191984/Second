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
public partial class HealthPackageControls_Nails : BaseControl
{
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        EMR2.DDL = ddlNailsType_4;

        if (IsPostBack)
        {
            if (chkNails_916.Checked == true)
            {
                tr1chkNails_916.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkNails_916.Attributes.Add("Style", "Display:None");
            }
        }
    }

    
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Nail
        if (chkNails_916.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 916;
            objPatientExamination.ExaminationName = chkNails_916.Text;
            attribute.Add(objPatientExamination);

            #region lblNailsType_4
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 916;
                objPatientExaminationAttribute.AttributeID = 4;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlNailsType_4.SelectedValue);
                if (ddlNailsType_4.SelectedItem.Text != "Others")
                {
                    objPatientExaminationAttribute.AttributeValueName = ddlNailsType_4.SelectedItem.Text;
                }
                else
                {
                    objPatientExaminationAttribute.AttributeValueName = txtNailsTypeOthers_34.Text;
                }
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblNailsDescription_5
            if(ddlNailsType_4.SelectedItem.Text!="Normal" &&ddlNailsType_4.SelectedItem.Text!="Others" && txtNailsDescription_422.Text.Trim()!="")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 916;
                objPatientExaminationAttribute.AttributeID = 5;
                objPatientExaminationAttribute.AttributevalueID = 422;
                objPatientExaminationAttribute.AttributeValueName = txtNailsDescription_422.Text;

                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        return returnval;
    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Rectum

        var listR = from Res in lstPEA
                    where Res.ExaminationID == 916
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listR)
        {

            if (objPEA.ExaminationID == 916)
            {
                chkNails_916.Checked = true;
                tr1chkNails_916.Style.Add("display", "block");
                ddlNailsType_4.SelectedValue = objPEA.AttributevalueID.ToString();

                if (ddlNailsType_4.SelectedItem.Text == "Others")
                {
                    divddlNailsType_4.Style.Add("display", "block");
                    txtNailsTypeOthers_34.Text = objPEA.AttributeValueName;
                }

                if (objPEA.AttributeID == 4 && ddlNailsType_4.SelectedItem.Text != "Others" && ddlNailsType_4.SelectedItem.Text != "Normal")
                {
                    trNailsDescription_5.Style.Add("display", "block");

                }

                if (objPEA.AttributeID == 5)
                {
                    txtNailsDescription_422.Text = objPEA.AttributeValueName;
                }



            }
        }

        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Nail

        var list = from Res in lstPEA
                    where Res.ExaminationID == 916
                    select Res;

        List<EMRAttributeClass> typelist = (from s in list
                       where s.AttributeID == 4
                        select new EMRAttributeClass
                       {
                           AttributeName=s.AttributeName,
                           AttributevalueID=s.AttributevalueID,
                           AttributeValueName=s.AttributeValueName
                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Nail";
        lstEMRvalue.Attributeid = 4;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;
        EMR2.Bind(lstEMRvalue, typelist);

        ddlNailsType_4.DataSource = typelist.ToList();
        ddlNailsType_4.DataTextField = "AttributeValueName";
        ddlNailsType_4.DataValueField = "AttributevalueID";
        ddlNailsType_4.DataBind();
        ddlNailsType_4.Items.Insert(0, "---Select---");

        
        

        #endregion

    }
}
