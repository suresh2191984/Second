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

public partial class HealthPackageControls_RectalExamination : BaseControl
{
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (IsPostBack)
        {
            if (chkRectum_912.Checked == true)
            {
                tr1chkRectum_912.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkRectum_912.Attributes.Add("Style", "Display:none");
            }
            if (chkProstate_913.Checked == true)
            {
                tr1chkProstate_913.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkProstate_913.Attributes.Add("Style", "Display:none");
            }     
         }
    }

    
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Rectum
        if (chkRectum_912.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 912;
            objPatientExamination.ExaminationName = chkRectum_912.Text;
            attribute.Add(objPatientExamination);
            #region lblType_93
          
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 912;
                objPatientExaminationAttribute.AttributeID = 93;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_93.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_93.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            if (ddlType_93.SelectedItem.Text != "Normal")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 912;
                objPatientExaminationAttribute.AttributeID = 94;
                objPatientExaminationAttribute.AttributevalueID = 440;
                objPatientExaminationAttribute.AttributeValueName = txtAbnormal_440.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion    
        }
        #endregion

        #region Prostate
        if (chkProstate_913.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 913;
            objPatientExamination.ExaminationName = chkProstate_913.Text;
            attribute.Add(objPatientExamination);
            #region lblType_95
           
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 913;
                objPatientExaminationAttribute.AttributeID = 95;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_95.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_95.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            if (ddlType_95.SelectedItem.Text != "Normal")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 913;
                objPatientExaminationAttribute.AttributeID = 96;
                objPatientExaminationAttribute.AttributevalueID = 441;
                objPatientExaminationAttribute.AttributeValueName = txtAbnormal_441.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion    
        }
        #endregion

        return returnval;
    }

    protected void ddlType_93_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_93.SelectedItem.Text != "Normal")
        {
            trAbnormalities_94.Style.Add("display", "block");
        }
        else
        {
            trAbnormalities_94.Style.Add("display", "none");
        }
    }
    protected void ddlType_95_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_95.SelectedItem.Text != "Normal")
        {
            trAbnormalities_96.Style.Add("display", "block");
        }
        else
        {
            trAbnormalities_96.Style.Add("display", "none");
        }
    }
    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Rectum

        var listR = from Res in lstPEA
                    where Res.ExaminationID == 912
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listR)
        {

            if (objPEA.ExaminationID == 912)
            {
                chkRectum_912.Checked = true;
                tr1chkRectum_912.Style.Add("display", "block");
                ddlType_93.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 94)
                {
                    trAbnormalities_94.Style.Add("display", "block");
                    txtAbnormal_440.Text = objPEA.AttributeValueName;
                }

            }
        }

        #endregion

        #region Prostate

        var listP = from Res in lstPEA
                    where Res.ExaminationID == 913
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listP)
        {

            if (objPEA.ExaminationID == 913)
            {
                chkProstate_913.Checked = true;
                tr1chkProstate_913.Style.Add("display", "block");
                ddlType_95.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 96)
                {
                    trAbnormalities_96.Style.Add("display", "block");
                    txtAbnormal_441.Text = objPEA.AttributeValueName;
                }
            }
        }

        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Rectum

        var listR = from Res in lstPEA
                    where Res.ExaminationID == 912
                    select Res;

        List<EMRAttributeClass> typeapex = (from s in listR
                       where s.AttributeID == 93
                       select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Rectum";
        lstEMRvalue.Attributeid = 93;
        lstEMRvalue.Attributevaluename = typeapex[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typeapex);
        ddlType_93.DataSource = typeapex.ToList();
        ddlType_93.DataTextField = "AttributeValueName";
        ddlType_93.DataValueField = "AttributevalueID";
        ddlType_93.DataBind();
        ddlType_93.Items.Insert(0, "---Select---");

        

        #endregion

        #region Prostate

        var listP = from Res in lstPEA
                    where Res.ExaminationID == 913
                    select Res;

        List<EMRAttributeClass> typeprostate = (from s in listP
                       where s.AttributeID == 95
                       select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Prostate";
        lstEMRvalue.Attributeid = 95;
        lstEMRvalue.Attributevaluename = typeprostate[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typeprostate);
        ddlType_95.DataSource = typeprostate.ToList();
        ddlType_95.DataTextField = "AttributeValueName";
        ddlType_95.DataValueField = "AttributevalueID";
        ddlType_95.DataBind();
        ddlType_95.Items.Insert(0, "---Select---");      


        #endregion

    }
}
