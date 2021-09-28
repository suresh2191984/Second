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

public partial class HealthPackageControls_GynaecologicalExam : BaseControl
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Bind Dropdown During Edit

    public void BindBreastsAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(87, out lstExaminationAttributeValues);
        trAbnormalities_88.Style.Add("display", "block");
        ddlAbnormalities_88.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_88.DataTextField = "AttributeValueName";
        ddlAbnormalities_88.DataValueField = "AttributevalueID";
        ddlAbnormalities_88.DataBind();
    }
    public void BindUterusAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(89, out lstExaminationAttributeValues);
        trAbnormalities_90.Style.Add("display", "block");
        ddlAbnormalities_90.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_90.DataTextField = "AttributeValueName";
        ddlAbnormalities_90.DataValueField = "AttributevalueID";
        ddlAbnormalities_90.DataBind();
    }
    public void BindExternalGenetailaAbnormal()
    {

        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(91, out lstExaminationAttributeValues);
        trAbnormalities_92.Style.Add("display", "block");
        ddlAbnormalities_92.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_92.DataTextField = "AttributeValueName";
        ddlAbnormalities_92.DataValueField = "AttributevalueID";
        ddlAbnormalities_92.DataBind();
    }

    #endregion

    #region Dropdown SelectedIndexChanged
    protected void ddlType_91_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_91.SelectedItem.Text == "Abnormal")
        {
            BindExternalGenetailaAbnormal();
        }
        else
        {
            trAbnormalities_92.Style.Add("display", "none");
            divddlAbnormalities_92.Style.Add("display", "none");
            
        }
    }
    protected void ddlType_87_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_87.SelectedItem.Text == "Abnormal")
        {

            BindBreastsAbnormal();
        }
        else
        {
            trAbnormalities_88.Style.Add("display", "none");
            divddlAbnormalities_88.Style.Add("display", "none");
        }
    }
    protected void ddlType_89_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_89.SelectedItem.Text == "Abnormal")
        {
            BindUterusAbnormal();
           
        }
        else
        {
            trAbnormalities_90.Style.Add("display", "none");
            divddlAbnormalities_90.Style.Add("display", "none");
        }
    }
    #endregion

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Breasts
        if (chkBreasts_908.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 908;
            objPatientExamination.ExaminationName = chkBreasts_908.Text;
            attribute.Add(objPatientExamination);

            #region lblType_87
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 908;
                objPatientExaminationAttribute.AttributeID = 87;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_87.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_87.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAbnormalities_88
            if (ddlType_87.SelectedItem.Text == "Abnormal" && ddlAbnormalities_88.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 908;
                objPatientExaminationAttribute.AttributeID = 88;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_88.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_88.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_87.SelectedItem.Text == "Abnormal" && ddlAbnormalities_88.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 908;
                    objPatientExaminationAttribute.AttributeID = 88;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_88.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_405.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Uterus
        if (chkUterus_909.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 909;
            objPatientExamination.ExaminationName = chkUterus_909.Text;
            attribute.Add(objPatientExamination);

            #region lblType_89
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 909;
                objPatientExaminationAttribute.AttributeID = 89;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_89.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_89.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_90
            if (ddlType_89.SelectedItem.Text == "Abnormal" && ddlAbnormalities_90.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 909;
                objPatientExaminationAttribute.AttributeID = 90;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_90.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_90.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_89.SelectedItem.Text == "Abnormal" && ddlAbnormalities_90.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 909;
                    objPatientExaminationAttribute.AttributeID = 90;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_90.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_415.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region External Genetaila
        if (chkExternalGenetaila_910.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 910;
            objPatientExamination.ExaminationName = chkExternalGenetaila_910.Text;
            attribute.Add(objPatientExamination);

            #region lblType_91
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 910;
                objPatientExaminationAttribute.AttributeID = 91;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_91.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_91.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_92
            if (ddlType_91.SelectedItem.Text == "Abnormal" && ddlAbnormalities_92.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 910;
                objPatientExaminationAttribute.AttributeID = 92;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_92.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_92.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_91.SelectedItem.Text == "Abnormal" && ddlAbnormalities_92.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 910;
                    objPatientExaminationAttribute.AttributeID = 92;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_92.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_394.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        return returnval;
    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Breasts

        var listB = from Res in lstPEA
                     where Res.ExaminationID == 908
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listB)
        {

            if (objPEA.ExaminationID == 908)
            {
                chkBreasts_908.Checked = true;
                tr1chkBreasts_908.Style.Add("display", "block");
                ddlType_87.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 88)
                {
                    BindBreastsAbnormal();
                    ddlAbnormalities_88.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_88.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_88.Style.Add("display", "block");
                        txtOthers_405.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Uterus

        var listU = from Res in lstPEA
                    where Res.ExaminationID == 909
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listU)
        {

            if (objPEA.ExaminationID == 909)
            {
                chkUterus_909.Checked = true;
                tr1chkUterus_909.Style.Add("display", "block");
                ddlType_89.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 90)
                {
                    BindUterusAbnormal();
                    ddlAbnormalities_90.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_90.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_90.Style.Add("display", "block");
                        txtOthers_415.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region External Genetaila

        var listEG = from Res in lstPEA
                    where Res.ExaminationID == 910
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listEG)
        {

            if (objPEA.ExaminationID == 910)
            {
                chkExternalGenetaila_910.Checked = true;
                tr1chkExternalGenetaila_910.Style.Add("display", "block");
                ddlType_91.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 92)
                {
                    BindExternalGenetailaAbnormal();
                    ddlAbnormalities_92.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_92.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_92.Style.Add("display", "block");
                        txtOthers_394.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

    }

    #region show OthersText
    protected void ddlAbnormalities_88_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_88.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_88.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_88.Style.Add("display", "none");
        }

    }
    protected void ddlAbnormalities_90_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_90.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_90.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_90.Style.Add("display", "none");
        }

    }
    protected void ddlAbnormalities_92_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_92.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_92.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_92.Style.Add("display", "none");
        }

    }
    #endregion
}
