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

public partial class HealthPackageControls_Eye : BaseControl
{
    long returnCode =-1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlType_9;
        EMR2.DDL = ddlType_11;
        EMR3.DDL = ddlType_13;
        EMR4.DDL = ddlDescription_14;
        EMR5.DDL = ddlType_16;
        EMR6.DDL = ddlType_18;
        EMR7.DDL = ddlType_20;
        EMR8.DDL = ddlRightEye_26;
        EMR9.DDL = ddlRightEye_29;
        EMR10.DDL = ddlLeftEye_30;
        EMR11.DDL = ddlAbnormalities_31;
        EMR12.DDL = ddlLeftEye_27;
        EMR13.DDL = ddlAssociatedConditions_19;
        EMR14.DDL = ddlAbnormality_21;     

        if (IsPostBack)
        {
            if (chkColorVision_921.Checked == true)
            {
                tr1chkColorVision_921.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkColorVision_921.Attributes.Add("Style", "Display:None");
            }
            if (chkDistantVision_919.Checked == true)
            {
                tr1chkDistantVision_919.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkDistantVision_919.Attributes.Add("Style", "Display:None");
            }
            if (chkEyeMovements_925.Checked == true)
            {
                tr1chkEyeMovements_925.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkEyeMovements_925.Attributes.Add("Style", "Display:None");
            }
            if (chkIOLPresent_922.Checked == true)
            {
                tr1chkIOLPresent_922.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkIOLPresent_922.Attributes.Add("Style", "Display:None");
            }
            if (chkNearVision_920.Checked == true)
            {
                tr1chkNearVision_920.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkNearVision_920.Attributes.Add("Style", "Display:None");
            }
            if (chkPterygium_923.Checked == true)
            {
                tr1chkPterygium_923.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkPterygium_923.Attributes.Add("Style", "Display:None");
            }
            if (chkPupils_926.Checked == true)
            {
                tr1chkPupils_926.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkPupils_926.Attributes.Add("Style", "Display:None");
            }
            if (chkTonometry_927.Checked == true)
            {
                tr1chkTonometry_927.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkTonometry_927.Attributes.Add("Style", "Display:None");
            }
            if (chkXanthelasma_924.Checked == true)
            {
                tr1chkXanthelasma_924.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkXanthelasma_924.Attributes.Add("Style", "Display:None");
            }
        }     
    }
    
     #region

    public void BindColorVisionAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(13, out lstExaminationAttributeValues);
        trType_13.Style.Add("display", "block");
        ddlDescription_14.DataSource = lstExaminationAttributeValues;
        ddlDescription_14.DataTextField = "AttributeValueName";
        ddlDescription_14.DataValueField = "AttributevalueID";
        ddlDescription_14.DataBind();
    }

    public void BindXanthelasmaAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(18, out lstExaminationAttributeValues);
        trType_18.Style.Add("display", "block");
        ddlAssociatedConditions_19.DataSource = lstExaminationAttributeValues;
        ddlAssociatedConditions_19.DataTextField = "AttributeValueName";
        ddlAssociatedConditions_19.DataValueField = "AttributevalueID";
        ddlAssociatedConditions_19.DataBind();

    }

    public void BindEyeMovementsAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(20, out lstExaminationAttributeValues);
        trType_20.Style.Add("display", "block");
        ddlAbnormality_21.DataSource = lstExaminationAttributeValues;
        ddlAbnormality_21.DataTextField = "AttributeValueName";
        ddlAbnormality_21.DataValueField = "AttributevalueID";
        ddlAbnormality_21.DataBind();
    }

     
    #endregion

    protected void ddlType_13_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_13.SelectedItem.Text != "Normal")
        {
            BindColorVisionAbnormal();
            EMRType_13.Attributes.Add("style","disply:block");
            
        }
        else
        {
            trType_13.Style.Add("display", "none");
            divddlDescription_14.Style.Add("display", "none");
            EMRType_13.Attributes.Add("style", "disply:none");
            
        }
    }
    protected void ddlType_16_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_16.SelectedItem.Text != "Absent")
        {
            trType_16.Style.Add("display", "block");
            EMRType_18.Style.Add("display", "none");
        }
        else
        {
            trType_16.Style.Add("display", "none");
        }
    }
    protected void ddlType_18_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_18.SelectedItem.Text != "Absent")
        {
            BindXanthelasmaAbnormal();           
            //EMRType_18.Attributes.Add("style", "disply:block");
            EMRType_18.Attributes.Add("style", "disply:none");
        }
        else
        {
            trType_18.Style.Add("display", "none");
            divddlAssociatedConditions_19.Style.Add("display", "none");            
            EMRType_18.Attributes.Add("style", "disply:none");
            
        }
    }
    protected void ddlType_20_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_20.SelectedItem.Text != "Absent")
        {
            BindEyeMovementsAbnormal();
            
            //EMRType_20.Attributes.Add("style", "disply:block");
            EMRType_20.Attributes.Add("style", "disply:none");
        }
        else
        {
            trType_20.Style.Add("display", "none");
            divddlAbnormality_21.Style.Add("display", "none");           
            EMRType_20.Attributes.Add("style", "disply:none");
        }
    }

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Distant Vision
        if (chkDistantVision_919.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 919;
            objPatientExamination.ExaminationName = chkDistantVision_919.Text;
            attribute.Add(objPatientExamination);

            #region lblType_9
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 919;
                objPatientExaminationAttribute.AttributeID = 9;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_9.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_9.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblRightEye_10
            if(txtRightEye_10.Text.Trim()!="")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 919;
                objPatientExaminationAttribute.AttributeID = 10;
                objPatientExaminationAttribute.AttributevalueID = 41;
                objPatientExaminationAttribute.AttributeValueName = txtRightEye_10.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLeftEye_97
            if (txtLeftEye_97.Text.Trim() != "")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 919;
                objPatientExaminationAttribute.AttributeID = 97;
                objPatientExaminationAttribute.AttributevalueID = 42;
                objPatientExaminationAttribute.AttributeValueName = txtLeftEye_97.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Near Vision
        if (chkNearVision_920.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 920;
            objPatientExamination.ExaminationName = chkNearVision_920.Text;
            attribute.Add(objPatientExamination);

            #region lblType_11
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 920;
                objPatientExaminationAttribute.AttributeID = 11;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_11.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_11.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblRightEye_12
            if (txtRightEye_12.Text.Trim() != "")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 920;
                objPatientExaminationAttribute.AttributeID = 12;
                objPatientExaminationAttribute.AttributevalueID = 45;
                objPatientExaminationAttribute.AttributeValueName = txtRightEye_12.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLeftEye_99
            if (txtLeftEye_99.Text.Trim() != "")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 920;
                objPatientExaminationAttribute.AttributeID = 99;
                objPatientExaminationAttribute.AttributevalueID = 46;
                objPatientExaminationAttribute.AttributeValueName = txtLeftEye_99.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Color Vision
        if (chkColorVision_921.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 921;
            objPatientExamination.ExaminationName = chkColorVision_921.Text;
            attribute.Add(objPatientExamination);

            #region lblType_13
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 921;
                objPatientExaminationAttribute.AttributeID = 13;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_13.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_13.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLocation_42
            {
                if (ddlType_13.SelectedItem.Text != "Normal")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 921;
                    objPatientExaminationAttribute.AttributeID = 14;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlDescription_14.SelectedValue);
                    if (ddlDescription_14.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlDescription_14.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtDescriptionOthers_57.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

        }
        #endregion

        #region IOL
        if (chkIOLPresent_922.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 922;
            objPatientExamination.ExaminationName = chkIOLPresent_922.Text;
            attribute.Add(objPatientExamination);

            #region lblEyes_15
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 922;
                objPatientExaminationAttribute.AttributeID = 15;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlEyes_15.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlEyes_15.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion
        }
        #endregion

        #region Pterygium
        if (chkPterygium_923.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 923;
            objPatientExamination.ExaminationName = chkPterygium_923.Text;
            attribute.Add(objPatientExamination);

            #region lblType_16
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 923;
                objPatientExaminationAttribute.AttributeID = 16;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_16.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_16.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblDescription_17
            {
                if (ddlType_16.SelectedItem.Text != "Absent")
                {

                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 923;
                    objPatientExaminationAttribute.AttributeID = 17;
                    objPatientExaminationAttribute.AttributevalueID = 65;
                    objPatientExaminationAttribute.AttributeValueName = txtDescription_65.Text;

                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion
        }
        #endregion

        #region Xanthelasma
        if (chkXanthelasma_924.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 924;
            objPatientExamination.ExaminationName = chkXanthelasma_924.Text;
            attribute.Add(objPatientExamination);

            #region lblType_18
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 924;
                objPatientExaminationAttribute.AttributeID = 18;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_18.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_18.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAssociatedConditions_19
            {
                if (ddlType_18.SelectedItem.Text != "Absent")
                {

                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 924;
                    objPatientExaminationAttribute.AttributeID = 19;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAssociatedConditions_19.SelectedValue);
                    if (ddlAssociatedConditions_19.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlAssociatedConditions_19.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtAssociatedConditions_74.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion
        }
        #endregion

        #region Eye Movements
        if (chkEyeMovements_925.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 925;
            objPatientExamination.ExaminationName = chkEyeMovements_925.Text;
            attribute.Add(objPatientExamination);

            #region lblType_20
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 925;
                objPatientExaminationAttribute.AttributeID = 20;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_20.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_20.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAbnormality_21
            {
                if (ddlType_20.SelectedItem.Text != "Absent")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 925;
                    objPatientExaminationAttribute.AttributeID = 21;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormality_21.SelectedValue);
                    if (ddlAbnormality_21.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlAbnormality_21.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtAbnormality_86.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

        }
        #endregion

        #region Pupils

        if (chkPupils_926.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 926;
            objPatientExamination.ExaminationName = chkPupils_926.Text;
            attribute.Add(objPatientExamination);

            #region Size - lblRightEye_23
            if(txtRightEye_23.Text.Trim()!="")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 23;
                objPatientExaminationAttribute.AttributevalueID = 87;
                objPatientExaminationAttribute.AttributeValueName = txtRightEye_23.Text + " " + lblUOM_23.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region Size - lblLeftEye_24
            if (txtLeftEye_24.Text.Trim() != "")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 24;
                objPatientExaminationAttribute.AttributevalueID = 88;
                objPatientExaminationAttribute.AttributeValueName = txtLeftEye_24.Text + " " + lblUOM_24.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region Shape - lblRightEye_26
            {
                if (ddlRightEye_26.SelectedValue != "0")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 926;
                    objPatientExaminationAttribute.AttributeID = 26;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlRightEye_26.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlRightEye_26.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

            #region Shape - lblLeftEye_27
            {
                if (ddlLeftEye_27.SelectedValue != "0")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 926;
                    objPatientExaminationAttribute.AttributeID = 27;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLeftEye_27.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlLeftEye_27.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
            #endregion

            #region Reaction to Light - lblRightEye_29
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 29;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlRightEye_29.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlRightEye_29.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region Reaction to Light - lblLeftEye_30
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 30;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLeftEye_30.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlLeftEye_30.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region Abnormalities

            if (ddlAbnormalities_31.SelectedValue != "0")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 31;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_31.SelectedValue);
                if (ddlAbnormalities_31.SelectedItem.Text != "Others")
                {
                    objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_31.SelectedItem.Text;
                }
                else
                {
                    objPatientExaminationAttribute.AttributeValueName = txtAbnormalitiesOthers_100.Text;
                }
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblDescription_32
            if(txtDescription_32.Text.Trim()!="")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 926;
                objPatientExaminationAttribute.AttributeID = 32;
                objPatientExaminationAttribute.AttributevalueID = 100;
                objPatientExaminationAttribute.AttributeValueName = txtDescription_32.Text;

                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion
        }
        #endregion

        #region Tonometry

        if (chkTonometry_927.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 927;
            objPatientExamination.ExaminationName = chkTonometry_927.Text;
            attribute.Add(objPatientExamination);

            #region IOP - lblRightIOP_33
            if(txtRightIOP_33.Text.Trim()!="")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 927;
                objPatientExaminationAttribute.AttributeID = 33;
                objPatientExaminationAttribute.AttributevalueID = 102;
                objPatientExaminationAttribute.AttributeValueName = txtRightIOP_33.Text + " " + lblUOM_33.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region IOP - lblLeftIOP_34
            if (txtLeftIOP_34.Text.Trim() != "")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 927;
                objPatientExaminationAttribute.AttributeID = 34;
                objPatientExaminationAttribute.AttributevalueID = 103;
                objPatientExaminationAttribute.AttributeValueName = txtLeftIOP_34.Text + " " + lblUOM_34.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion
        }

        #endregion

        return returnval;
    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Distant Vision

        var listDV = from Res in lstPEA
                     where Res.ExaminationID == 919
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listDV)
        {
            if (objPEA.ExaminationID == 919)
            {
                chkDistantVision_919.Checked = true;
                tr1chkDistantVision_919.Style.Add("display", "block");
                ddlType_9.SelectedValue = objPEA.AttributevalueID.ToString();
            }
            if (objPEA.AttributeID == 10)
            {
                txtRightEye_10.Text = objPEA.AttributeValueName;
            }
            if (objPEA.AttributeID == 97)
            {
                txtLeftEye_97.Text = objPEA.AttributeValueName;
            }
        }
        #endregion

        #region Near Vision

        var listNV = from Res in lstPEA
                     where Res.ExaminationID == 920
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listNV)
        {

            if (objPEA.ExaminationID == 920)
            {
                chkNearVision_920.Checked = true;
                tr1chkNearVision_920.Style.Add("display", "block");
                ddlType_11.SelectedValue = objPEA.AttributevalueID.ToString();
            }

            if (objPEA.AttributeID == 12)
            {
                txtRightEye_12.Text = objPEA.AttributeValueName;

            }

            if (objPEA.AttributeID == 99)
            {
                txtLeftEye_99.Text = objPEA.AttributeValueName;

            }
        }

        #endregion

        #region Color Vision

        var listCV = from Res in lstPEA
                     where Res.ExaminationID == 921
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listCV)
        {

            if (objPEA.ExaminationID == 921)
            {
                chkColorVision_921.Checked = true;
                tr1chkColorVision_921.Style.Add("display", "block");
                ddlType_13.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 14)
                {
                    BindColorVisionAbnormal();
                    ddlDescription_14.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlDescription_14.SelectedItem.Text == "Others")
                    {
                        divddlDescription_14.Style.Add("display", "block");
                        txtDescriptionOthers_57.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region IOL Present

        var listIOLP = from Res in lstPEA
                       where Res.ExaminationID == 922
                       select Res;

        foreach (PatientExaminationAttribute objPEA in listIOLP)
        {

            if (objPEA.ExaminationID == 922)
            {
                chkIOLPresent_922.Checked = true;
                tr1chkIOLPresent_922.Style.Add("display", "block");
                ddlEyes_15.SelectedValue = objPEA.AttributevalueID.ToString();

            }
        }

        #endregion

        #region Pterygium

        var listP = from Res in lstPEA
                    where Res.ExaminationID == 923
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listP)
        {

            if (objPEA.ExaminationID == 923)
            {
                chkPterygium_923.Checked = true;
                tr1chkPterygium_923.Style.Add("display", "block");
                ddlType_16.SelectedValue = objPEA.AttributevalueID.ToString();

            }

            if (objPEA.AttributeID == 17)
            {
                trType_16.Style.Add("display", "block");
                txtDescription_65.Text = objPEA.AttributeValueName;

            }
        }

        #endregion

        #region Xanthelasma

        var listX = from Res in lstPEA
                    where Res.ExaminationID == 924
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listX)
        {

            if (objPEA.ExaminationID == 924)
            {
                chkXanthelasma_924.Checked = true;
                tr1chkXanthelasma_924.Style.Add("display", "block");
                ddlType_18.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 19)
                {
                    BindXanthelasmaAbnormal();
                    ddlAssociatedConditions_19.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAssociatedConditions_19.SelectedItem.Text == "Others")
                    {
                        divddlAssociatedConditions_19.Style.Add("display", "block");
                        txtAssociatedConditions_74.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Eye Movements

        var listEM = from Res in lstPEA
                     where Res.ExaminationID == 925
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listEM)
        {

            if (objPEA.ExaminationID == 925)
            {
                chkEyeMovements_925.Checked = true;
                tr1chkEyeMovements_925.Style.Add("display", "block");
                ddlType_20.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 21)
                {
                    BindEyeMovementsAbnormal();
                    ddlAbnormality_21.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormality_21.SelectedItem.Text == "Others")
                    {
                        divddlAbnormality_21.Style.Add("display", "block");
                        txtAbnormality_86.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion


        #region Pupils

        var listPP = from Res in lstPEA
                     where Res.ExaminationID == 926
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listPP)
        {

            if (objPEA.ExaminationID == 926)
            {
                chkPupils_926.Checked = true;
                tr1chkPupils_926.Style.Add("display", "block");

                if (objPEA.AttributeID == 23)
                {
                    string[] RI = objPEA.AttributeValueName.Split(' ');
                    txtRightEye_23.Text = RI[0];

                }
                if (objPEA.AttributeID == 24)
                {
                    string[] LI = objPEA.AttributeValueName.Split(' ');
                    txtLeftEye_24.Text = LI[0];

                }

                if (objPEA.AttributeID == 26)
                {
                    ddlRightEye_26.SelectedValue = objPEA.AttributevalueID.ToString();

                }
                if (objPEA.AttributeID == 27)
                {
                    ddlLeftEye_27.SelectedValue = objPEA.AttributevalueID.ToString();

                }

                if (objPEA.AttributeID == 29)
                {
                    ddlRightEye_29.SelectedValue = objPEA.AttributevalueID.ToString();

                }
                if (objPEA.AttributeID == 30)
                {
                    ddlLeftEye_30.SelectedValue = objPEA.AttributevalueID.ToString();

                }


                if (objPEA.AttributeID == 31)
                {

                    ddlAbnormalities_31.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_31.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_31.Style.Add("display", "block");
                        txtAbnormalitiesOthers_100.Text = objPEA.AttributeValueName;
                    }
                }

                if (objPEA.AttributeID == 32)
                {
                    txtDescription_32.Text = objPEA.AttributeValueName;

                }

            }
        }

        #endregion





        #region Tonometry

        var listT = from Res in lstPEA
                    where Res.ExaminationID == 927
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listT)
        {

            if (objPEA.ExaminationID == 927)
            {
                chkTonometry_927.Checked = true;
                tr1chkTonometry_927.Style.Add("display", "block");
            }

            if (objPEA.AttributeID == 33)
            {
                string[] RI = objPEA.AttributeValueName.Split(' ');
                txtRightIOP_33.Text = RI[0];

            }

            if (objPEA.AttributeID == 34)
            {
                string[] LI = objPEA.AttributeValueName.Split(' ');
                txtLeftIOP_34.Text = LI[0];

            }
        }

        #endregion

    }


    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Distant Vision

        var listDV = from Res in lstPEA
                     where Res.ExaminationID == 919
                     select Res;
        
            List<EMRAttributeClass> typelist = (from s in listDV
                           where s.AttributeID == 9
                           select new EMRAttributeClass
                           {
                               AttributeName=s.AttributeName, 
                               AttributevalueID=s.AttributevalueID,
                               AttributeValueName = s.AttributeValueName
                           }).ToList();
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Distant Vision";
            lstEMRvalue.Attributeid = 9;
            lstEMRvalue.Attributevaluename = typelist[0].AttributeName;

            EMR1.Bind(lstEMRvalue, typelist);

            ddlType_9.DataSource = typelist.ToList();
            ddlType_9.DataTextField = "AttributeValueName";
            ddlType_9.DataValueField = "AttributevalueID";
            ddlType_9.DataBind();   

        #endregion

        #region Near Vision

        var listNV = from Res in lstPEA
                     where Res.ExaminationID == 920
                     select Res;

        List<EMRAttributeClass> typenear = (from s in listNV
                       where s.AttributeID == 11
                       select new EMRAttributeClass
                       {
                           AttributeName=s.AttributeName, 
                           AttributevalueID=s.AttributevalueID,
                           AttributeValueName = s.AttributeValueName
                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Near Vision";
        lstEMRvalue.Attributeid = 11;
        lstEMRvalue.Attributevaluename = typenear[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typenear);

        ddlType_11.DataSource = typenear.ToList();
        ddlType_11.DataTextField = "AttributeValueName";
        ddlType_11.DataValueField = "AttributevalueID";
        ddlType_11.DataBind();   

        
        #endregion

        #region Color Vision

        var listCV = from Res in lstPEA
                     where Res.ExaminationID == 921
                     select Res;

        List<EMRAttributeClass> typecolor = (from s in listCV
                       where s.AttributeID == 13
                       select new EMRAttributeClass
                       {
                           AttributeName=s.AttributeName,
                          AttributevalueID= s.AttributevalueID,
                           AttributeValueName=s.AttributeValueName
                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Color Vision";
        lstEMRvalue.Attributeid = 13;
        lstEMRvalue.Attributevaluename = typecolor[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typecolor);

        ddlType_13.DataSource = typecolor.ToList();
        ddlType_13.DataTextField = "AttributeValueName";
        ddlType_13.DataValueField = "AttributevalueID";
        ddlType_13.DataBind();

        List<EMRAttributeClass> typecolordesc = (from s in listCV
                        where s.AttributeID == 14
                        select new EMRAttributeClass
                        {
                            AttributeName=s.AttributeName, 
                           AttributevalueID= s.AttributevalueID,
                            AttributeValueName=s.AttributeValueName
                        }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Distant Vision";
        lstEMRvalue.Attributeid = 14;
        lstEMRvalue.Attributevaluename = typecolordesc[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typecolordesc);

        ddlDescription_14.DataSource = typecolordesc.ToList();
        ddlDescription_14.DataTextField = "AttributeValueName";
        ddlDescription_14.DataValueField = "AttributevalueID";
        ddlDescription_14.DataBind(); 
 


        #endregion

        #region IOL Present

        //var listIOLP = from Res in lstPEA
        //             where Res.ExaminationID == 922
        //             select Res;

        //foreach (PatientExaminationAttribute objPEA in listIOLP)
        //{

        //    if (objPEA.ExaminationID == 922)
        //    {
        //        chkIOLPresent_922.Checked = true;
        //        tr1chkIOLPresent_922.Style.Add("display", "block");
        //        ddlEyes_15.SelectedValue = objPEA.AttributevalueID.ToString();            

        //    }
        //}

        #endregion

        #region Pterygium

        var listP= from Res in lstPEA
                     where Res.ExaminationID == 923
                     select Res;

        List<EMRAttributeClass> typePterygium = (from s in listP
                            where s.AttributeID == 16
                            select new EMRAttributeClass
                            {
                                AttributeName=s.AttributeName, 
                                AttributevalueID=s.AttributevalueID,
                                AttributeValueName=s.AttributeValueName
                            }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pterygium";
        lstEMRvalue.Attributeid = 16;
        lstEMRvalue.Attributevaluename = typePterygium[0].AttributeName;

        EMR5.Bind(lstEMRvalue, typePterygium);
        ddlType_16.DataSource = typePterygium.ToList();
        ddlType_16.DataTextField = "AttributeValueName";
        ddlType_16.DataValueField = "AttributevalueID";
        ddlType_16.DataBind(); 

        

        #endregion

        #region Xanthelasma

        var listX = from Res in lstPEA
                     where Res.ExaminationID == 924
                     select Res;

        List<EMRAttributeClass> typeXanthelasma = (from s in listX
                            where s.AttributeID == 18
                                                  select new EMRAttributeClass
                            {
                               AttributeName= s.AttributeName,
                               AttributevalueID=s.AttributevalueID,
                               AttributeValueName=s.AttributeValueName
                            }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Xanthelasma";
        lstEMRvalue.Attributeid = 18;
        lstEMRvalue.Attributevaluename = typeXanthelasma[0].AttributeName;

        EMR6.Bind(lstEMRvalue, typeXanthelasma);
        ddlType_18.DataSource = typeXanthelasma.ToList();
        ddlType_18.DataTextField = "AttributeValueName";
        ddlType_18.DataValueField = "AttributevalueID";
        ddlType_18.DataBind();

        List<EMRAttributeClass> typeXanthelasmaAssociate = (from s in listX
                              where s.AttributeID == 19
                              select new EMRAttributeClass
                              {
                                  AttributeName=s.AttributeName,
                                  AttributevalueID=s.AttributevalueID,
                                 AttributeValueName= s.AttributeValueName
                              }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Xanthelasma";
        lstEMRvalue.Attributeid = 19;
        lstEMRvalue.Attributevaluename = typeXanthelasmaAssociate[0].AttributeName;

        EMR13.Bind(lstEMRvalue, typeXanthelasmaAssociate);
        ddlAssociatedConditions_19.DataSource = typeXanthelasmaAssociate.ToList();
        ddlAssociatedConditions_19.DataTextField = "AttributeValueName";
        ddlAssociatedConditions_19.DataValueField = "AttributevalueID";
        ddlAssociatedConditions_19.DataBind(); 


        #endregion

        #region Eye Movements

        var listEM = from Res in lstPEA
                     where Res.ExaminationID == 925
                     select Res;

        List<EMRAttributeClass> typemovements = (from s in listEM
                              where s.AttributeID == 20
                              select new EMRAttributeClass
                              {
                                 AttributeName= s.AttributeName, 
                                 AttributevalueID= s.AttributevalueID,
                                 AttributeValueName= s.AttributeValueName
                              }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Eye Movements";
        lstEMRvalue.Attributeid = 20;
        lstEMRvalue.Attributevaluename = typemovements[0].AttributeName;

        EMR7.Bind(lstEMRvalue, typemovements);
        ddlType_20.DataSource = typemovements.ToList();
        ddlType_20.DataTextField = "AttributeValueName";
        ddlType_20.DataValueField = "AttributevalueID";
        ddlType_20.DataBind();

        List<EMRAttributeClass> typemovementsabnormality = (from s in listEM
                                       where s.AttributeID == 21
                                       select new EMRAttributeClass
                                       {
                                          AttributeName= s.AttributeName,
                                          AttributevalueID= s.AttributevalueID,
                                          AttributeValueName= s.AttributeValueName
                                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Eye Movements";
        lstEMRvalue.Attributeid = 21;
        lstEMRvalue.Attributevaluename = typemovementsabnormality[0].AttributeName;

        EMR14.Bind(lstEMRvalue, typemovementsabnormality);
        ddlAbnormality_21.DataSource = typemovementsabnormality.ToList();
        ddlAbnormality_21.DataTextField = "AttributeValueName";
        ddlAbnormality_21.DataValueField = "AttributevalueID";
        ddlAbnormality_21.DataBind(); 


        #endregion


        #region Pupils

        var listPP = from Res in lstPEA
                     where Res.ExaminationID == 926
                     select Res;

        List<EMRAttributeClass> typerightshape = (from s in listPP
                           where s.AttributeID == 26
                           select new EMRAttributeClass
                           {
                              AttributeName= s.AttributeName, 
                              AttributevalueID= s.AttributevalueID,
                             AttributeValueName= s.AttributeValueName
                           }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pupils";
        lstEMRvalue.Attributeid = 26;
        lstEMRvalue.Attributevaluename = typerightshape[0].AttributeName;

        EMR8.Bind(lstEMRvalue, typerightshape);
        ddlRightEye_26.DataSource = typerightshape.ToList();
        ddlRightEye_26.DataTextField = "AttributeValueName";
        ddlRightEye_26.DataValueField = "AttributevalueID";
        ddlRightEye_26.DataBind();

        List<EMRAttributeClass> typeleftshape = (from s in listPP
                           where s.AttributeID == 27
                           select new EMRAttributeClass
                           {
                               AttributeName=s.AttributeName,
                               AttributevalueID=s.AttributevalueID,
                               AttributeValueName=s.AttributeValueName
                           }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pupils";
        lstEMRvalue.Attributeid = 27;
        lstEMRvalue.Attributevaluename = typeleftshape[0].AttributeName;

        EMR12.Bind(lstEMRvalue, typeleftshape);
        ddlLeftEye_27.DataSource = typeleftshape.ToList();
        ddlLeftEye_27.DataTextField = "AttributeValueName";
        ddlLeftEye_27.DataValueField = "AttributevalueID";
        ddlLeftEye_27.DataBind();

        List<EMRAttributeClass> typerighteye = (from s in listPP
                        where s.AttributeID == 29
                        select new EMRAttributeClass
                        {
                           AttributeName= s.AttributeName, 
                           AttributevalueID= s.AttributevalueID,
                           AttributeValueName= s.AttributeValueName
                        }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pupils";
        lstEMRvalue.Attributeid = 29;
        lstEMRvalue.Attributevaluename = typerighteye[0].AttributeName;

        EMR9.Bind(lstEMRvalue, typerighteye);
        ddlRightEye_29.DataSource = typerighteye.ToList();
        ddlRightEye_29.DataTextField = "AttributeValueName";
        ddlRightEye_29.DataValueField = "AttributevalueID";
        ddlRightEye_29.DataBind();

        List<EMRAttributeClass> typelefteye = (from s in listPP
                        where s.AttributeID == 30
                        select new EMRAttributeClass
                        {
                            AttributeName=s.AttributeName ,
                            AttributevalueID=s.AttributevalueID,
                           AttributeValueName= s.AttributeValueName
                        }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pupils";
        lstEMRvalue.Attributeid = 30;
        lstEMRvalue.Attributevaluename = typelefteye[0].AttributeName;

        EMR10.Bind(lstEMRvalue, typelefteye);
        ddlLeftEye_30.DataSource = typelefteye.ToList();
        ddlLeftEye_30.DataTextField = "AttributeValueName";
        ddlLeftEye_30.DataValueField = "AttributevalueID";
        ddlLeftEye_30.DataBind(); 

        List<EMRAttributeClass> typepupils = (from s in listPP
                                       where s.AttributeID == 31
                                       select new EMRAttributeClass
                                       {
                                          AttributeName= s.AttributeName, 
                                          AttributevalueID= s.AttributevalueID,
                                          AttributeValueName= s.AttributeValueName
                                       }).ToList();


        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pupils";
        lstEMRvalue.Attributeid = 31;
        lstEMRvalue.Attributevaluename = typepupils[0].AttributeName;

        EMR11.Bind(lstEMRvalue, typepupils);
        ddlAbnormalities_31.DataSource = typepupils.ToList();
        ddlAbnormalities_31.DataTextField = "AttributeValueName";
        ddlAbnormalities_31.DataValueField = "AttributevalueID";
        ddlAbnormalities_31.DataBind(); 

        #endregion





        #region Tonometry

        var listT = from Res in lstPEA
                     where Res.ExaminationID == 927
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listT)
        {

            if (objPEA.ExaminationID == 927)
            {
                chkTonometry_927.Checked = true;
                tr1chkTonometry_927.Style.Add("display", "block");               
            }

            if (objPEA.AttributeID == 33)
            {
                string[] RI = objPEA.AttributeValueName.Split(' ');
                txtRightIOP_33.Text = RI[0];

            }

            if (objPEA.AttributeID == 34)
            {
                string[] LI = objPEA.AttributeValueName.Split(' ');
                txtLeftIOP_34.Text = LI[0];

            }
            if (txtRightIOP_33.Text.Trim() == "" && txtLeftIOP_34.Text.Trim() == "")
            {
                chkTonometry_927.Checked = false;
                tr1chkTonometry_927.Style.Add("display", "none");
            }
        }

        #endregion

    }

    #region show OthersText
    protected void ddlAssociatedConditions_19_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAssociatedConditions_19.SelectedItem.Text == "Others")
        {
            divddlAssociatedConditions_19.Style.Add("display", "block");
        }
        else
        {
            divddlAssociatedConditions_19.Style.Add("display", "none");
        }


    }
    protected void ddlAbnormality_21_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormality_21.SelectedItem.Text == "Others")
        {
            divddlAbnormality_21.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormality_21.Style.Add("display", "none");
        }

    }
    #endregion
}
