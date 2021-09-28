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

public partial class HealthPackageControls_RespiratorySystem : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {

        EMR1.DDL = ddlType_43;
        EMR2.DDL = ddlType_45;
        EMR3.DDL = ddlAbnormalities_46;
       
        if (IsPostBack)
        {
            if (chkTrachea_878.Checked == true)
            {
                tr1chkTrachea_878.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkTrachea_878.Attributes.Add("Style", "Display:none");
            }
            if (chkBreathSounds_879.Checked == true)
            {
                tr1chkBreathSounds_879.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkBreathSounds_879.Attributes.Add("Style", "Display:none");
            }            
        }
    }    

    #region bind dropdown
    public void BindBreathSoundsAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(45, out lstExaminationAttributeValues);
        trType_45.Style.Add("display", "block");
        ddlAbnormalities_46.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_46.DataTextField = "AttributeValueName";
        ddlAbnormalities_46.DataValueField = "AttributevalueID";
        ddlAbnormalities_46.DataBind();
    }
    #endregion
    protected void ddlType_45_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_45.SelectedItem.Text != "Normal")
        {
            BindBreathSoundsAbnormal();
            tdType_45.Style.Add("display", "block");
        }
        else
        {
            trType_45.Style.Add("display", "none");
            tdType_45.Style.Add("display", "none");
            divddlAbnormalities_46.Style.Add("display", "none");                
        }
    }

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Trachea
        if (chkTrachea_878.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 878;
            objPatientExamination.ExaminationName = chkTrachea_878.Text;
            attribute.Add(objPatientExamination);

            #region lblType_43
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 878;
                objPatientExaminationAttribute.AttributeID = 43;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_43.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_43.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region chkPostTracheostomy_156
            {
                if (chkPostTracheostomy_156.Checked == true)
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 878;
                    objPatientExaminationAttribute.AttributeID = 44;
                    objPatientExaminationAttribute.AttributevalueID = 156;
                    objPatientExaminationAttribute.AttributeValueName = chkPostTracheostomy_156.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

        }
        #endregion

        #region Breath Sounds
        if (chkBreathSounds_879.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 879;
            objPatientExamination.ExaminationName = chkBreathSounds_879.Text;
            attribute.Add(objPatientExamination);

            #region lblType_45
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 879;
                objPatientExaminationAttribute.AttributeID = 45;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_45.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_45.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLocation_42
            {
                if (ddlType_45.SelectedItem.Text != "Normal")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 879;
                    objPatientExaminationAttribute.AttributeID = 46;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_46.SelectedValue);
                    if (ddlAbnormalities_46.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_46.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtAbnormalitiesOthers_165.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

        }
        #endregion

        return returnval;
    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {

        #region Trachea

        var listT = from Res in lstPEA
                    where Res.ExaminationID == 878
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listT)
        {

            if (objPEA.ExaminationID == 878)
            {
                chkTrachea_878.Checked = true;
                tr1chkTrachea_878.Style.Add("display", "block");
                ddlType_43.SelectedValue = objPEA.AttributevalueID.ToString();
            }
            if (objPEA.AttributeID == 44)
            {
                chkPostTracheostomy_156.Checked = true;
            }
        }

        #endregion

        #region Breath Sounds

        var listBS = from Res in lstPEA
                     where Res.ExaminationID == 879
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listBS)
        {

            if (objPEA.ExaminationID == 879)
            {
                chkBreathSounds_879.Checked = true;
                tr1chkBreathSounds_879.Style.Add("display", "block");
                ddlType_45.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 53)
                {
                    BindBreathSoundsAbnormal();
                    ddlAbnormalities_46.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_46.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_46.Style.Add("display", "block");
                        txtAbnormalitiesOthers_165.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {

        #region Trachea

        var listT = from Res in lstPEA
                     where Res.ExaminationID == 878
                     select Res;

        List<EMRAttributeClass> typeapex = (from s in listT
                       where s.AttributeID == 43
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Trachea";
        lstEMRvalue.Attributeid = 43;
        lstEMRvalue.Attributevaluename = typeapex[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typeapex);
        ddlType_43.DataSource = typeapex.ToList();
        ddlType_43.DataTextField = "AttributeValueName";
        ddlType_43.DataValueField = "AttributevalueID";
        ddlType_43.DataBind();
        ddlType_43.Items.Insert(0, "---Select---");      

        

        #endregion

        #region Breath Sounds

        var listBS = from Res in lstPEA
                     where Res.ExaminationID == 879
                     select Res;

        List<EMRAttributeClass> typebreath = (from s in listBS
                       where s.AttributeID == 45
                       select new EMRAttributeClass
                             {
                                 AttributeName = s.AttributeName,
                                 AttributevalueID = s.AttributevalueID,
                                 AttributeValueName = s.AttributeValueName
                             }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Breath Sounds";
        lstEMRvalue.Attributeid = 45;
        lstEMRvalue.Attributevaluename = typebreath[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typebreath);
        ddlType_45.DataSource = typebreath.ToList();
        ddlType_45.DataTextField = "AttributeValueName";
        ddlType_45.DataValueField = "AttributevalueID";
        ddlType_45.DataBind();
        ddlType_45.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typeapexabnormal = (from s in listBS
                       where s.AttributeID == 46
                       select new EMRAttributeClass
                             {
                                 AttributeName = s.AttributeName,
                                 AttributevalueID = s.AttributevalueID,
                                 AttributeValueName = s.AttributeValueName
                             }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Trachea";
        lstEMRvalue.Attributeid = 46;
        lstEMRvalue.Attributevaluename = typeapexabnormal[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typeapexabnormal);
        ddlAbnormalities_46.DataSource = typeapexabnormal.ToList();
        ddlAbnormalities_46.DataTextField = "AttributeValueName";
        ddlAbnormalities_46.DataValueField = "AttributevalueID";
        ddlAbnormalities_46.DataBind();
        ddlAbnormalities_46.Items.Insert(0, "---Select---");

        //foreach (PatientExaminationAttribute objPEA in listBS)
        //{

        //    if (objPEA.ExaminationID == 879)
        //    {
        //        chkBreathSounds_879.Checked = true;
        //        tr1chkBreathSounds_879.Style.Add("display", "block");
        //        ddlType_45.SelectedValue = objPEA.AttributevalueID.ToString();

        //        if (objPEA.AttributeID == 53)
        //        {
        //            BindBreathSoundsAbnormal();
        //            ddlAbnormalities_46.SelectedValue = objPEA.AttributevalueID.ToString();
        //            if (ddlAbnormalities_46.SelectedItem.Text == "Others")
        //            {
        //                divddlAbnormalities_46.Style.Add("display", "block");
        //                txtAbnormalitiesOthers_165.Text = objPEA.AttributeValueName;
        //            }
        //        }

        //    }
        //}

        #endregion

    }
    protected void ddlAbnormalities_46_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_46.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_46.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_46.Style.Add("display", "none");
        }

    }
}
