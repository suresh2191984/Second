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

public partial class HealthPackageControls_NeurologicaExamination : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    List<EMRAttributeClass> lstemr = new List<EMRAttributeClass>();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlType_75;
        EMR13.DDL = chkAbnormalities_76;
        EMR2.DDL = ddlType_77;
        EMR3.DDL = ddlAbnormalities_78;
        EMR4.DDL = ddlType_79;
        EMR5.DDL = ddlType_81;
        EMR6.DDL = ddlAbnormalities_82;
        EMR7.DDL = ddlType_83;
        EMR8.DDL = ddlAbnormalities_84;
        EMR9.DDL = ddlType_85;
        EMR10.DDL = ddlAbnormalities_86;
        EMR11.DDL = ddlAbnormalities_80;
        //EMR12.DDL = chkAbnormalities_76;

        if (IsPostBack)
        {
            if (chkCranialNerves_901.Checked == true)
            {
                tr1chkCranialNerves_901.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkCranialNerves_901.Attributes.Add("Style", "Display:none");
            }
            if (chkSensorySystem_902.Checked == true)
            {
                tr1chkSensorySystem_902.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkSensorySystem_902.Attributes.Add("Style", "Display:none");
            }
            if (chkReflexes_903.Checked == true)
            {
                tr1chkReflexes_903.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkReflexes_903.Attributes.Add("Style", "Display:none");
            }
            if (chkMotorSystem_904.Checked == true)
            {
                tr1chkMotorSystem_904.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkMotorSystem_904.Attributes.Add("Style", "Display:none");
            }
            if (chkMusculoSkeletalsystem_905.Checked == true)
            {
                tr1chkMusculoSkeletalsystem_905.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkMusculoSkeletalsystem_905.Attributes.Add("Style", "Display:none");
            }
            if (chkGait_906.Checked == true)
            {
                tr1chkGait_906.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkGait_906.Attributes.Add("Style", "Display:none");
            }
        }
    }    
    #region Bind Dropdown During Edit
    public void BindCranialNervesAbnormal()
    {

        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(75, out lstExaminationAttributeValues);
        trAbnormalities_76.Style.Add("display", "block");
        chkAbnormalities_76.DataSource = lstExaminationAttributeValues;
        chkAbnormalities_76.DataTextField = "AttributeValueName";
        chkAbnormalities_76.DataValueField = "AttributevalueID";
        chkAbnormalities_76.DataBind();

        //lstEMRvalue.Name = "Examination";
        //lstEMRvalue.Attributename = "Cranial Nerves";
        //lstEMRvalue.Attributeid = 76;
        //lstEMRvalue.Attributevaluename ="Abnormalities";  
    }
    public void BindSensorySystemAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(77, out lstExaminationAttributeValues);
        trAbnormalities_78.Style.Add("display", "block");
        ddlAbnormalities_78.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_78.DataTextField = "AttributeValueName";
        ddlAbnormalities_78.DataValueField = "AttributevalueID";
        ddlAbnormalities_78.DataBind();
    }

    public void BindReflexesAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(79, out lstExaminationAttributeValues);
        trAbnormalities_80.Style.Add("display", "block");
        ddlAbnormalities_80.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_80.DataTextField = "AttributeValueName";
        ddlAbnormalities_80.DataValueField = "AttributevalueID";
        ddlAbnormalities_80.DataBind();
    }

    public void BindMotorSystemAbnormal()
    {        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(81, out lstExaminationAttributeValues);
        trAbnormalities_82.Style.Add("display", "block");
        ddlAbnormalities_82.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_82.DataTextField = "AttributeValueName";
        ddlAbnormalities_82.DataValueField = "AttributevalueID";
        ddlAbnormalities_82.DataBind();
    }

    public void BindMusculoSkeletalsystemAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(83, out lstExaminationAttributeValues);
        trAbnormalities_84.Style.Add("display", "block");
        ddlAbnormalities_84.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_84.DataTextField = "AttributeValueName";
        ddlAbnormalities_84.DataValueField = "AttributevalueID";
        ddlAbnormalities_84.DataBind();
    }


    public void BindgaitAbnormal()
    {

        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(85, out lstExaminationAttributeValues);
        trAbnormalities_86.Style.Add("display", "block");
        ddlAbnormalities_86.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_86.DataTextField = "AttributeValueName";
        ddlAbnormalities_86.DataValueField = "AttributevalueID";
        ddlAbnormalities_86.DataBind();

    }




    #endregion


    #region Dropdown SelectedIndexChanged
    protected void ddlType_75_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_75.SelectedItem.Text == "Abnormal")
        {
            BindCranialNervesAbnormal();
            tdAbnormalities_76.Style.Add("display", "block");
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Test", "javascript:test(" + trAbnormalities_76 .ClientID+ ");", true);
        }
        else
        {
            trAbnormalities_76.Style.Add("display", "none");
            tdAbnormalities_76.Style.Add("display", "none");
            
        }
    }

    protected void ddlType_77_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_77.SelectedItem.Text == "Abnormal")
        {
            BindSensorySystemAbnormal();
            tdAbnormalities_78.Style.Add("display", "block");           
        }
        else
        {
            trAbnormalities_78.Style.Add("display", "none");
            tdAbnormalities_78.Style.Add("display", "none");
            divddlAbnormalities_78.Style.Add("display", "none");            
        }
    }
    protected void ddlType_79_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_79.SelectedItem.Text == "Abnormal")
        {
            BindReflexesAbnormal();
        }
        else
        {
            trAbnormalities_80.Style.Add("display", "none");
            divddlAbnormalities_80.Style.Add("display", "none");
        }
    }
    protected void ddlType_81_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_81.SelectedItem.Text == "Abnormal")
        {
            BindMotorSystemAbnormal();
            tdAbnormalities_82.Style.Add("display", "block");
        }
        else
        {
            tdAbnormalities_82.Style.Add("display", "none");
            trAbnormalities_82.Style.Add("display", "none");
            divddlAbnormalities_82.Style.Add("display", "none");
        }
    }
    protected void ddlType_83_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_83.SelectedItem.Text == "Abnormal")
        {

            BindMusculoSkeletalsystemAbnormal();
            tdAbnormalities_84.Style.Add("display", "block");
        }
        else
        {
            trAbnormalities_84.Style.Add("display", "none");
            tdAbnormalities_84.Style.Add("display", "none");
            divddlAbnormalities_84.Style.Add("display", "none");
        }
    }
    protected void ddlType_85_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_85.SelectedItem.Text == "Abnormal")
        {
            BindgaitAbnormal();
            tdAbnormalities_86.Style.Add("display", "block");           
        }
        else
        {
            trAbnormalities_86.Style.Add("display", "none");
            tdAbnormalities_86.Style.Add("display", "none");
            divddlAbnormalities_86.Style.Add("display", "none");
        }
    }
    #endregion

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();
        
        #region CranialNerves
        if (chkCranialNerves_901.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 901;
            objPatientExamination.ExaminationName = chkCranialNerves_901.Text;
            attribute.Add(objPatientExamination);

            #region lblType_75
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 901;
                objPatientExaminationAttribute.AttributeID = 75;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_75.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_75.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_76
            if (ddlType_75.SelectedItem.Text == "Abnormal" )
            {
                foreach (ListItem li in chkAbnormalities_76.Items)//Treatment
                {
                    if (li.Selected)
                    {
                        PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                        objPatientExaminationAttribute.ExaminationID = 901;
                        objPatientExaminationAttribute.AttributeID = 76;
                        objPatientExaminationAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                        objPatientExaminationAttribute.AttributeValueName = li.Text;
                        attrValue.Add(objPatientExaminationAttribute);
                    }
                }
            }            

            #endregion

        }
        #endregion

        #region Sensory System
        if (chkSensorySystem_902.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 902;
            objPatientExamination.ExaminationName = chkSensorySystem_902.Text;
            attribute.Add(objPatientExamination);

            #region lblType_77
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 902;
                objPatientExaminationAttribute.AttributeID = 77;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_77.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_77.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_78
            if (ddlType_77.SelectedItem.Text == "Abnormal" && ddlAbnormalities_78.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 902;
                objPatientExaminationAttribute.AttributeID = 78;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_78.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_78.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_77.SelectedItem.Text == "Abnormal" && ddlAbnormalities_78.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 902;
                    objPatientExaminationAttribute.AttributeID = 78;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_78.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_339.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion         

        #region Reflexes
        if (chkReflexes_903.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 903;
            objPatientExamination.ExaminationName = chkReflexes_903.Text;
            attribute.Add(objPatientExamination);

            #region lblType_79
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 903;
                objPatientExaminationAttribute.AttributeID = 79;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_79.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_79.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_80
            if (ddlType_79.SelectedItem.Text == "Abnormal" && ddlAbnormalities_80.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 903;
                objPatientExaminationAttribute.AttributeID = 80;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_80.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_80.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_79.SelectedItem.Text == "Abnormal" && ddlAbnormalities_80.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 903;
                    objPatientExaminationAttribute.AttributeID = 80;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_80.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_347.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
           
            #endregion

        }
        #endregion

        #region Motor System
        if (chkMotorSystem_904.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 904;
            objPatientExamination.ExaminationName = chkMotorSystem_904.Text;
            attribute.Add(objPatientExamination);

            #region lblType_81
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 904;
                objPatientExaminationAttribute.AttributeID = 81;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_81.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_81.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_82
            if (ddlType_81.SelectedItem.Text == "Abnormal" && ddlAbnormalities_82.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 904;
                objPatientExaminationAttribute.AttributeID = 82;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_82.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_82.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_81.SelectedItem.Text == "Abnormal" && ddlAbnormalities_82.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 904;
                    objPatientExaminationAttribute.AttributeID = 82;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_82.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_358.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion       

        #region  Musculo Skeletal system
        if (chkMusculoSkeletalsystem_905.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 905;
            objPatientExamination.ExaminationName = chkMusculoSkeletalsystem_905.Text;
            attribute.Add(objPatientExamination);

            #region lblType_83
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 905;
                objPatientExaminationAttribute.AttributeID = 83;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_83.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_83.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_84
            if (ddlType_83.SelectedItem.Text == "Abnormal" && ddlAbnormalities_84.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 905;
                objPatientExaminationAttribute.AttributeID = 84;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_84.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_84.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_83.SelectedItem.Text == "Abnormal" && ddlAbnormalities_84.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 905;
                    objPatientExaminationAttribute.AttributeID = 84;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_84.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_367.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
           
            #endregion

        }
        #endregion

        #region Gait
        if (chkGait_906.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 906;
            objPatientExamination.ExaminationName = chkGait_906.Text;
            attribute.Add(objPatientExamination);

            #region lblType_85
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 906;
                objPatientExaminationAttribute.AttributeID = 85;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_85.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_85.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_86
            if (ddlType_85.SelectedItem.Text == "Abnormal" && ddlAbnormalities_86.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 906;
                objPatientExaminationAttribute.AttributeID = 86;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_86.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_86.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_85.SelectedItem.Text == "Abnormal" && ddlAbnormalities_86.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 906;
                    objPatientExaminationAttribute.AttributeID = 86;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_86.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_384.Text;
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

        #region Cranial Nerves

        var listT = from Res in lstPEA
                    where Res.ExaminationID == 901
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listT)
        {

            if (objPEA.ExaminationID == 901)
            {
                chkCranialNerves_901.Checked = true;
                tr1chkCranialNerves_901.Style.Add("display", "block");
                ddlType_75.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 76)
                {
                    BindCranialNervesAbnormal();

                    var lstCN = from Res in lstPEA
                                where Res.AttributeID == 76
                                select Res;

                    foreach (ListItem li in chkAbnormalities_76.Items)
                    {
                        foreach (PatientExaminationAttribute objlstCN in lstCN)
                        {
                            if (li.Value ==objlstCN.AttributevalueID.ToString())
                            {
                                li.Selected = true;
                            }
                        }
                    }
                }

            }
        }

        #endregion

        #region Sensory System

        var listSS = from Res in lstPEA
                     where Res.ExaminationID == 902
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listSS)
        {

            if (objPEA.ExaminationID == 902)
            {
                chkSensorySystem_902.Checked = true;
                tr1chkSensorySystem_902.Style.Add("display", "block");
                ddlType_77.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 78)
                {
                    BindSensorySystemAbnormal();
                    ddlAbnormalities_78.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_78.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_78.Style.Add("display", "block");
                        txtOthers_339.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Reflexes

        var listRF = from Res in lstPEA
                     where Res.ExaminationID == 903
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listRF)
        {

            if (objPEA.ExaminationID == 903)
            {
                chkReflexes_903.Checked = true;
                tr1chkReflexes_903.Style.Add("display", "block");
                ddlType_79.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 80)
                {
                    BindReflexesAbnormal();
                    ddlAbnormalities_80.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_80.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_80.Style.Add("display", "block");
                        txtOthers_347.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Motor System

        var listMS = from Res in lstPEA
                     where Res.ExaminationID == 904
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listMS)
        {

            if (objPEA.ExaminationID == 904)
            {
                chkMotorSystem_904.Checked = true;
                tr1chkMotorSystem_904.Style.Add("display", "block");
                ddlType_81.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 82)
                {
                    BindMotorSystemAbnormal();
                    ddlAbnormalities_82.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_82.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_82.Style.Add("display", "block");
                        txtOthers_358.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Musculo Skeletal system

        var listMSS = from Res in lstPEA
                     where Res.ExaminationID == 905
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listMSS)
        {

            if (objPEA.ExaminationID == 905)
            {
                chkMusculoSkeletalsystem_905.Checked = true;
                tr1chkMusculoSkeletalsystem_905.Style.Add("display", "block");
                ddlType_83.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 84)
                {
                    BindMusculoSkeletalsystemAbnormal();
                    ddlAbnormalities_84.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_84.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_84.Style.Add("display", "block");
                        txtOthers_367.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Gait

        var listG = from Res in lstPEA
                      where Res.ExaminationID == 906
                      select Res;

        foreach (PatientExaminationAttribute objPEA in listG)
        {

            if (objPEA.ExaminationID == 906)
            {
                chkGait_906.Checked = true;
                tr1chkGait_906.Style.Add("display", "block");
                ddlType_85.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 86)
                {
                    BindgaitAbnormal();
                    ddlAbnormalities_86.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_86.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_86.Style.Add("display", "block");
                        txtOthers_384.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion



    }
    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {

        #region Cranial Nerves

        var listT = from Res in lstPEA
                    where Res.ExaminationID == 901
                    select Res;

        List<EMRAttributeClass> typeprostate = (from s in listT
                           where s.AttributeID == 75
                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Cranial Nerves";
        lstEMRvalue.Attributeid = 75;
        lstEMRvalue.Attributevaluename = typeprostate[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typeprostate);
        ddlType_75.DataSource = typeprostate.ToList();
        ddlType_75.DataTextField = "AttributeValueName";
        ddlType_75.DataValueField = "AttributevalueID";
        ddlType_75.DataBind();
        ddlType_75.Items.Insert(0, "---Select---");


        List<EMRAttributeClass> type = (from s in listT
                                                where s.AttributeID == 76
                                                select new EMRAttributeClass
                                                {
                                                    AttributeName = s.AttributeName,
                                                    AttributevalueID = s.AttributevalueID,
                                                    AttributeValueName = s.AttributeValueName
                                                }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Cranial Nerves";
        lstEMRvalue.Attributeid = 76;
        lstEMRvalue.Attributevaluename = type[0].AttributeName;

        EMR13.Bind(lstEMRvalue, type);
        #endregion

        #region Sensory System

        var listSS = from Res in lstPEA
                     where Res.ExaminationID == 902
                     select Res;

        List<EMRAttributeClass> typeabdominal = (from s in listSS
                            where s.AttributeID == 77
                             select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Sensory System";
        lstEMRvalue.Attributeid = 77;
        lstEMRvalue.Attributevaluename = typeabdominal[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typeabdominal);
        ddlType_77.DataSource = typeabdominal.ToList();
        ddlType_77.DataTextField = "AttributeValueName";
        ddlType_77.DataValueField = "AttributevalueID";
        ddlType_77.DataBind();
        ddlType_77.Items.Insert(0, "---Select---");

        var typesensory = (from s in listSS
                            where s.AttributeID == 78
                             select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Kidneys";
        lstEMRvalue.Attributeid = 78;
        lstEMRvalue.Attributevaluename = typesensory[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typesensory);
        ddlAbnormalities_78.DataSource = typesensory.ToList();
        ddlAbnormalities_78.DataTextField = "AttributeValueName";
        ddlAbnormalities_78.DataValueField = "AttributevalueID";
        ddlAbnormalities_78.DataBind();
        ddlAbnormalities_78.Items.Insert(0, "---Select---");
                
        #endregion

        #region Reflexes

        var listRF = from Res in lstPEA
                     where Res.ExaminationID == 903
                     select Res;


        List<EMRAttributeClass> typeReflexes = (from s in listRF
                            where s.AttributeID == 79
                             select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Reflexes";
        lstEMRvalue.Attributeid = 79;
        lstEMRvalue.Attributevaluename = typeReflexes[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typeReflexes);
        ddlType_79.DataSource = typeReflexes.ToList();
        ddlType_79.DataTextField = "AttributeValueName";
        ddlType_79.DataValueField = "AttributevalueID";
        ddlType_79.DataBind();
        ddlType_79.Items.Insert(0, "---Select---");

        var typeReflexessensory = (from s in listRF
                          where s.AttributeID == 80
                           select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Kidneys";
        lstEMRvalue.Attributeid = 80;
        lstEMRvalue.Attributevaluename = typeReflexessensory[0].AttributeName;

        EMR11.Bind(lstEMRvalue, typeReflexessensory);
        ddlAbnormalities_80.DataSource = typeReflexessensory.ToList();
        ddlAbnormalities_80.DataTextField = "AttributeValueName";
        ddlAbnormalities_80.DataValueField = "AttributevalueID";
        ddlAbnormalities_80.DataBind();
        ddlAbnormalities_80.Items.Insert(0, "---Select---");     

        #endregion

        #region Motor System

        var listMS = from Res in lstPEA
                     where Res.ExaminationID == 904
                     select Res;

        List<EMRAttributeClass> typemotor = (from s in listMS
                           where s.AttributeID == 81
                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Motor System";
        lstEMRvalue.Attributeid = 81;
        lstEMRvalue.Attributevaluename = typemotor[0].AttributeName;

        EMR5.Bind(lstEMRvalue, typemotor);
        ddlType_81.DataSource = typemotor.ToList();
        ddlType_81.DataTextField = "AttributeValueName";
        ddlType_81.DataValueField = "AttributevalueID";
        ddlType_81.DataBind();
        ddlType_81.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typemotorsystem = (from s in listMS
                                  where s.AttributeID == 82
                                   select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Kidneys";
        lstEMRvalue.Attributeid = 64;
        lstEMRvalue.Attributevaluename = typemotorsystem[0].AttributeName;

        EMR6.Bind(lstEMRvalue, typemotorsystem);
        ddlAbnormalities_82.DataSource = typemotorsystem.ToList();
        ddlAbnormalities_82.DataTextField = "AttributeValueName";
        ddlAbnormalities_82.DataValueField = "AttributevalueID";
        ddlAbnormalities_82.DataBind();
        ddlAbnormalities_82.Items.Insert(0, "---Select---");       

        #endregion

        #region Musculo Skeletal system

        var listMSS = from Res in lstPEA
                      where Res.ExaminationID == 905
                      select Res;
        List<EMRAttributeClass> typeskeletal = (from s in listMSS
                        where s.AttributeID == 83
                         select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Musculo Skeletal system";
        lstEMRvalue.Attributeid = 83;
        lstEMRvalue.Attributevaluename = typeskeletal[0].AttributeName;

        EMR7.Bind(lstEMRvalue, typeskeletal);
        ddlType_83.DataSource = typeskeletal.ToList();
        ddlType_83.DataTextField = "AttributeValueName";
        ddlType_83.DataValueField = "AttributevalueID";
        ddlType_83.DataBind();
        ddlType_83.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typeskeletalsystem = (from s in listMSS
                              where s.AttributeID == 84
                               select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Musculo Skeletal system";
        lstEMRvalue.Attributeid = 84;
        lstEMRvalue.Attributevaluename = typeskeletalsystem[0].AttributeName;

        EMR8.Bind(lstEMRvalue, typeskeletalsystem);
        ddlAbnormalities_84.DataSource = typeskeletalsystem.ToList();
        ddlAbnormalities_84.DataTextField = "AttributeValueName";
        ddlAbnormalities_84.DataValueField = "AttributevalueID";
        ddlAbnormalities_84.DataBind();
        ddlAbnormalities_84.Items.Insert(0, "---Select---");       

        #endregion

        #region Gait

        var listG = from Res in lstPEA
                    where Res.ExaminationID == 906
                    select Res;

        List<EMRAttributeClass> typegait = (from s in listG
                           where s.AttributeID == 85
                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Gait";
        lstEMRvalue.Attributeid = 85;
        lstEMRvalue.Attributevaluename = typegait[0].AttributeName;

        EMR9.Bind(lstEMRvalue, typegait);
        ddlType_85.DataSource = typeskeletal.ToList();
        ddlType_85.DataTextField = "AttributeValueName";
        ddlType_85.DataValueField = "AttributevalueID";
        ddlType_85.DataBind();
        ddlType_85.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typegaitsystem = (from s in listG
                                 where s.AttributeID == 86
                                  select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Gait";
        lstEMRvalue.Attributeid = 86;
        lstEMRvalue.Attributevaluename = typegaitsystem[0].AttributeName;

        EMR10.Bind(lstEMRvalue, typegaitsystem);
        ddlAbnormalities_86.DataSource = typeskeletalsystem.ToList();
        ddlAbnormalities_86.DataTextField = "AttributeValueName";
        ddlAbnormalities_86.DataValueField = "AttributevalueID";
        ddlAbnormalities_86.DataBind();
        ddlAbnormalities_86.Items.Insert(0, "---Select---");              
        #endregion
    }
    #region show OthersText
    protected void ddlAbnormalities_78_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_78.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_78.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_78.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_80_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_80.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_80.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_80.Style.Add("display", "none");
        }

    }
    protected void ddlAbnormalities_82_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_82.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_82.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_82.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_84_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_84.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_84.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_84.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_86_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_86.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_86.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_86.Style.Add("display", "none");
        }
    }
    #endregion
}
