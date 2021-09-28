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

public partial class HealthPackageControls_CardiovascularExam : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlFindings_47;
        EMR2.DDL = ddlFindings_48;
        EMR3.DDL = ddlFindings_49;
        EMR4.DDL = ddlLocation_51;
        EMR5.DDL = ddlFindings_52;
        EMR6.DDL = ddlTypesofabnormalitiess_53;
        EMR7.DDL = ddlFindings_54;
        EMR8.DDL = ddlTypesofabnormalitiess_55;
        EMR9.DDL = ddlFindings_56;
        EMR10.DDL = ddlTypesofabnormalitiess_57;
        EMR11.DDL = ddlFindingsSigns_50;
        
        if (IsPostBack)
        {
            if (chkPulseRhythm_881.Checked == true)
            {
                tr1chkPulseRhythm_881.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkPulseRhythm_881.Attributes.Add("Style", "Display:none");
            }
            if (chkPulseVolume_882.Checked == true)
            {
                tr1chkPulseVolume_882.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkPulseVolume_882.Attributes.Add("Style", "Display:none");
            }
            if (chkPulseCharacter_883.Checked == true)
            {
                tr1chkPulseCharacter_883.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkPulseCharacter_883.Attributes.Add("Style", "Display:none");
            }
            if (chkPeripheralPulses_884.Checked == true)
            {
                tr1chkPeripheralPulses_884.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkPeripheralPulses_884.Attributes.Add("Style", "Display:none");
            }
            if (chkApexBeat_885.Checked == true)
            {
                tr1chkApexBeat_885.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkApexBeat_885.Attributes.Add("Style", "Display:none");
            }
            if (chkHeartSounds_886.Checked == true)
            {
                tr1chkHeartSounds_886.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkHeartSounds_886.Attributes.Add("Style", "Display:none");
            }
            if (chkHeartMummurs_887.Checked == true)
            {
                tr1chkHeartMummurs_887.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkHeartMummurs_887.Attributes.Add("Style", "Display:none");
            }
            
        }
    }

   

    #region Bind dropdown During the Edit
    public void BindPeripheralPulsesAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(50, out lstExaminationAttributeValues);
        trLocation_51.Style.Add("display", "block");
        ddlLocation_51.DataSource = lstExaminationAttributeValues;
        ddlLocation_51.DataTextField = "AttributeValueName";
        ddlLocation_51.DataValueField = "AttributevalueID";
        ddlLocation_51.DataBind();
    }
    public void BindApexBeatAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(52, out lstExaminationAttributeValues);
        trTypesofabnormalitiess_53.Style.Add("display", "block");
        ddlTypesofabnormalitiess_53.DataSource = lstExaminationAttributeValues;
        ddlTypesofabnormalitiess_53.DataTextField = "AttributeValueName";
        ddlTypesofabnormalitiess_53.DataValueField = "AttributevalueID";
        ddlTypesofabnormalitiess_53.DataBind();
    }
    public void BindHeartSoundsAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(54, out lstExaminationAttributeValues);
        trTypesofabnormalitiess_55.Style.Add("display", "block");
        ddlTypesofabnormalitiess_55.DataSource = lstExaminationAttributeValues;
        ddlTypesofabnormalitiess_55.DataTextField = "AttributeValueName";
        ddlTypesofabnormalitiess_55.DataValueField = "AttributevalueID";
        ddlTypesofabnormalitiess_55.DataBind();
    }
    public void BindHeartMummursAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(56, out lstExaminationAttributeValues);
        trTypesofabnormalitiess_57.Style.Add("display", "block");
        ddlTypesofabnormalitiess_57.DataSource = lstExaminationAttributeValues;
        ddlTypesofabnormalitiess_57.DataTextField = "AttributeValueName";
        ddlTypesofabnormalitiess_57.DataValueField = "AttributevalueID";
        ddlTypesofabnormalitiess_57.DataBind();
    }
    
    #endregion

    #region Bind dropdown
    protected void ddlFindings_56_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFindings_56.SelectedItem.Text == "Abnormal")
        {
            BindHeartMummursAbnormal();
            tdTypesofabnormalitiess_57.Style.Add("display", "block");
          
        }
        else
        {
            trTypesofabnormalitiess_57.Style.Add("display", "none");
            divddlTypesofabnormalitiess_57.Style.Add("display", "none");
            
        }
    }
    protected void ddlFindings_54_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFindings_54.SelectedItem.Text == "Abnormal")
        {
            BindHeartSoundsAbnormal();
            tdTypesofabnormalitiess_55.Style.Add("display", "block");
            ddlTypesofabnormalitiess_55.Focus();
        }
        else
        {
            trTypesofabnormalitiess_55.Style.Add("display", "none");
            divddlTypesofabnormalitiess_55.Style.Add("display", "none");
            
        }
    }
    protected void ddlFindings_52_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFindings_52.SelectedItem.Text == "Abnormal")
        {
            BindApexBeatAbnormal();
            tdTypesofabnormalitiess_53.Style.Add("display", "block");
            ddlTypesofabnormalitiess_53.Focus();
        }
        else
        {
            trTypesofabnormalitiess_53.Style.Add("display", "none");
        }
    }
    protected void ddlFindingsSigns_50_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFindingsSigns_50.SelectedItem.Text == "Weak" || ddlFindingsSigns_50.SelectedItem.Text == "Absent")
        {
            BindPeripheralPulsesAbnormal();
            tdLocation_51.Style.Add("display", "block");
          
        }
        else
        {
            trLocation_51.Style.Add("display", "none");
        }
    }
    #endregion


     public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Pulse Rhythm
        if (chkPulseRhythm_881.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 881;
            objPatientExamination.ExaminationName = chkPulseRhythm_881.Text;
            attribute.Add(objPatientExamination);

            #region lblFindings_47

            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 881;
                objPatientExaminationAttribute.AttributeID = 47;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_47.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_47.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Pulse Volume
        if (chkPulseVolume_882.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 882;
            objPatientExamination.ExaminationName = chkPulseVolume_882.Text;
            attribute.Add(objPatientExamination);

            #region lblFindings_48

            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 882;
                objPatientExaminationAttribute.AttributeID = 48;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_48.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_48.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Pulse Character
        if (chkPulseCharacter_883.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 883;
            objPatientExamination.ExaminationName = chkPulseCharacter_883.Text;
            attribute.Add(objPatientExamination);
            #region lblFindings_49
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 883;
                objPatientExaminationAttribute.AttributeID = 49;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_49.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_49.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Peripheral Pulses
        if (chkPeripheralPulses_884.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 884;
            objPatientExamination.ExaminationName = chkPeripheralPulses_884.Text;
            attribute.Add(objPatientExamination);

            #region lblFindingsSigns_50
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 884;
                objPatientExaminationAttribute.AttributeID = 50;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindingsSigns_50.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindingsSigns_50.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLocation_51

            if (ddlFindingsSigns_50.SelectedItem.Text != "Felt in All Limbs")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 884;
                objPatientExaminationAttribute.AttributeID = 51;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLocation_51.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlLocation_51.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Apex Beat
        if (chkApexBeat_885.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 885;
            objPatientExamination.ExaminationName = chkApexBeat_885.Text;
            attribute.Add(objPatientExamination);

            #region lblFindings_52
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 885;
                objPatientExaminationAttribute.AttributeID = 52;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_52.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_52.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblTypesofabnormalitiess_53

            if (ddlFindings_52.SelectedItem.Text != "Normal")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 885;
                objPatientExaminationAttribute.AttributeID = 53;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlTypesofabnormalitiess_53.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlTypesofabnormalitiess_53.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Heart Sounds
        if (chkHeartSounds_886.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 886;
            objPatientExamination.ExaminationName = chkHeartSounds_886.Text;
            attribute.Add(objPatientExamination);

            #region lblFindings_54
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 886;
                objPatientExaminationAttribute.AttributeID = 54;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_54.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_54.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblTypesofabnormalitiess_55
            if (ddlFindings_54.SelectedItem.Text == "Abnormal" && ddlTypesofabnormalitiess_55.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 886;
                objPatientExaminationAttribute.AttributeID = 55;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlTypesofabnormalitiess_55.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlTypesofabnormalitiess_55.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlFindings_54.SelectedItem.Text == "Abnormal" && ddlTypesofabnormalitiess_55.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 886;
                    objPatientExaminationAttribute.AttributeID = 55;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlTypesofabnormalitiess_55.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_433.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Heart Mummurs
        if (chkHeartMummurs_887.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 887;
            objPatientExamination.ExaminationName = chkHeartMummurs_887.Text;
            attribute.Add(objPatientExamination);

            #region lblFindings_56
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 887;
                objPatientExaminationAttribute.AttributeID = 56;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlFindings_56.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlFindings_56.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblTypesofabnormalitiess_57
            if (ddlFindings_56.SelectedItem.Text == "Abnormal" && ddlTypesofabnormalitiess_57.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 887;
                objPatientExaminationAttribute.AttributeID = 57;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlTypesofabnormalitiess_57.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlTypesofabnormalitiess_57.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlFindings_56.SelectedItem.Text == "Abnormal" && ddlTypesofabnormalitiess_57.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 887;
                    objPatientExaminationAttribute.AttributeID = 57;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlTypesofabnormalitiess_57.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_216.Text;
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
         #region Pulse Rhythm
         var listPR = from Res in lstPEA
                      where Res.ExaminationID == 881
                      select Res;

         

         foreach (PatientExaminationAttribute objPEA in listPR)
         {

             if (objPEA.ExaminationID == 881)
             {
                 chkPulseRhythm_881.Checked = true;
                 tr1chkPulseRhythm_881.Style.Add("display", "block");
                 ddlFindings_47.SelectedValue = objPEA.AttributevalueID.ToString();

             }
         }
         #endregion

         #region Pulse Volume
         var listPV = from Res in lstPEA
                      where Res.ExaminationID == 882
                      select Res;

         foreach (PatientExaminationAttribute objPEA in listPV)
         {

             if (objPEA.ExaminationID == 882)
             {
                 chkPulseVolume_882.Checked = true;
                 tr1chkPulseVolume_882.Style.Add("display", "block");
                 ddlFindings_48.SelectedValue = objPEA.AttributevalueID.ToString();

             }
         }
         #endregion

         #region Pulse Character
         var list = from Res in lstPEA
                    where Res.ExaminationID == 883
                    select Res;

         foreach (PatientExaminationAttribute objPEA in list)
         {

             if (objPEA.ExaminationID == 883)
             {
                 chkPulseCharacter_883.Checked = true;
                 tr1chkPulseCharacter_883.Style.Add("display", "block");
                 ddlFindings_49.SelectedValue = objPEA.AttributevalueID.ToString();

             }
         }
         #endregion

         #region Peripheral Pulses

         var listPP = from Res in lstPEA
                      where Res.ExaminationID == 884
                      select Res;

         foreach (PatientExaminationAttribute objPEA in listPP)
         {

             if (objPEA.ExaminationID == 884)
             {
                 chkPeripheralPulses_884.Checked = true;
                 tr1chkPeripheralPulses_884.Style.Add("display", "block");
                 ddlFindingsSigns_50.SelectedValue = objPEA.AttributevalueID.ToString();

                 if (objPEA.AttributeID == 51)
                 {
                     BindPeripheralPulsesAbnormal();
                     ddlLocation_51.SelectedValue = objPEA.AttributevalueID.ToString();

                 }

             }
         }

         #endregion

         #region Apex Beat

         var listAB = from Res in lstPEA
                      where Res.ExaminationID == 885
                      select Res;

         foreach (PatientExaminationAttribute objPEA in listAB)
         {

             if (objPEA.ExaminationID == 885)
             {
                 chkApexBeat_885.Checked = true;
                 tr1chkApexBeat_885.Style.Add("display", "block");
                 ddlFindings_52.SelectedValue = objPEA.AttributevalueID.ToString();

                 if (objPEA.AttributeID == 53)
                 {
                     BindApexBeatAbnormal();
                     ddlTypesofabnormalitiess_53.SelectedValue = objPEA.AttributevalueID.ToString();

                 }

             }
         }

         #endregion

         #region Heart Sounds

         var listHS = from Res in lstPEA
                      where Res.ExaminationID == 886
                      select Res;

         foreach (PatientExaminationAttribute objPEA in listHS)
         {

             if (objPEA.ExaminationID == 886)
             {
                 chkHeartSounds_886.Checked = true;
                 tr1chkHeartSounds_886.Style.Add("display", "block");
                 ddlFindings_54.SelectedValue = objPEA.AttributevalueID.ToString();

                 if (objPEA.AttributeID == 55)
                 {
                     BindHeartSoundsAbnormal();
                     ddlTypesofabnormalitiess_55.SelectedValue = objPEA.AttributevalueID.ToString();
                     if (ddlTypesofabnormalitiess_55.SelectedItem.Text == "Others")
                     {
                         divddlTypesofabnormalitiess_55.Style.Add("display", "block");
                         txtOthers_433.Text = objPEA.AttributeValueName;
                     }
                 }

             }
         }

         #endregion

         #region Heart Mummurs

         var listT = from Res in lstPEA
                     where Res.ExaminationID == 887
                     select Res;

         foreach (PatientExaminationAttribute objPEA in listT)
         {

             if (objPEA.ExaminationID == 887)
             {
                 chkHeartMummurs_887.Checked = true;
                 tr1chkHeartMummurs_887.Style.Add("display", "block");
                 ddlFindings_56.SelectedValue = objPEA.AttributevalueID.ToString();

                 if (objPEA.AttributeID == 57)
                 {
                     BindHeartMummursAbnormal();
                     ddlTypesofabnormalitiess_57.SelectedValue = objPEA.AttributevalueID.ToString();
                     if (ddlTypesofabnormalitiess_57.SelectedItem.Text == "Others")
                     {
                         divddlTypesofabnormalitiess_57.Style.Add("display", "block");
                         txtOthers_216.Text = objPEA.AttributeValueName;
                     }
                 }

             }
         }

         #endregion


     }

     public void SetData(List<PatientExaminationAttribute> lstPEA)
     {
         #region Pulse Rhythm
         var listPR = from Res in lstPEA
                      where Res.ExaminationID == 881
                      select Res;

         List<EMRAttributeClass> typeLymph = (from s in listPR
                         where s.AttributeID == 47
                          select new EMRAttributeClass
                         {
                             AttributeName = s.AttributeName,
                             AttributevalueID = s.AttributevalueID,
                             AttributeValueName = s.AttributeValueName

                         }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Pulse Rhythm";
         lstEMRvalue.Attributeid = 47;
         lstEMRvalue.Attributevaluename = typeLymph[0].AttributeName;

         EMR1.Bind(lstEMRvalue, typeLymph);
         ddlFindings_47.DataSource = typeLymph.ToList();
         ddlFindings_47.DataTextField = "AttributeValueName";
         ddlFindings_47.DataValueField = "AttributevalueID";
         ddlFindings_47.DataBind();
         ddlFindings_47.Items.Insert(0, "---Select---");
        
        #endregion

         #region Pulse Volume
         var listPV = from Res in lstPEA
                    where Res.ExaminationID == 882
                    select Res;
         List<EMRAttributeClass> typepulse = (from s in listPV
                         where s.AttributeID == 48
                         select new EMRAttributeClass
                         {
                             AttributeName = s.AttributeName,
                             AttributevalueID = s.AttributevalueID,
                             AttributeValueName = s.AttributeValueName

                         }).ToList();
         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Pulse Volume";
         lstEMRvalue.Attributeid = 48;
         lstEMRvalue.Attributevaluename = typepulse[0].AttributeName;

         EMR2.Bind(lstEMRvalue, typepulse);
         ddlFindings_48.DataSource = typepulse.ToList();
         ddlFindings_48.DataTextField = "AttributeValueName";
         ddlFindings_48.DataValueField = "AttributevalueID";
         ddlFindings_48.DataBind();
         ddlFindings_48.Items.Insert(0, "---Select---");


         
         #endregion

         #region Pulse Character
         var list = from Res in lstPEA
                    where Res.ExaminationID == 883
                    select Res;

         List<EMRAttributeClass> typepulsecharacter = (from s in list
                         where s.AttributeID == 49
                         select new EMRAttributeClass
                         {
                             AttributeName = s.AttributeName,
                             AttributevalueID = s.AttributevalueID,
                             AttributeValueName = s.AttributeValueName

                         }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Pulse Volume";
         lstEMRvalue.Attributeid = 49;
         lstEMRvalue.Attributevaluename = typepulsecharacter[0].AttributeName;

         EMR3.Bind(lstEMRvalue, typepulsecharacter);
         ddlFindings_49.DataSource = typepulsecharacter.ToList();
         ddlFindings_49.DataTextField = "AttributeValueName";
         ddlFindings_49.DataValueField = "AttributevalueID";
         ddlFindings_49.DataBind();
         ddlFindings_49.Items.Insert(0, "---Select---");


         //foreach (PatientExaminationAttribute objPEA in list)
         //{

         //    if (objPEA.ExaminationID == 883)
         //    {
         //        chkPulseCharacter_883.Checked = true;
         //        tr1chkPulseCharacter_883.Style.Add("display", "block");
         //        ddlFindings_49.SelectedValue = objPEA.AttributevalueID.ToString();

         //    }
         //}
         #endregion

         #region Peripheral Pulses

         var listPP = from Res in lstPEA
                     where Res.ExaminationID == 884
                     select Res;

         List<EMRAttributeClass> typeperipheral = (from s in listPP
                                  where s.AttributeID == 50
                                  select new EMRAttributeClass
                                  {
                                      AttributeName = s.AttributeName,
                                      AttributevalueID = s.AttributevalueID,
                                      AttributeValueName = s.AttributeValueName

                                  }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Peripheral Pulses";
         lstEMRvalue.Attributeid = 50;
         lstEMRvalue.Attributevaluename = typeperipheral[0].AttributeName;

         EMR11.Bind(lstEMRvalue, typeperipheral);

         ddlFindingsSigns_50.DataSource = typeperipheral.ToList();
         ddlFindingsSigns_50.DataTextField = "AttributeValueName";
         ddlFindingsSigns_50.DataValueField = "AttributevalueID";
         ddlFindingsSigns_50.DataBind();
         ddlFindingsSigns_50.Items.Insert(0, "---Select---");

         List<EMRAttributeClass> typeperipherallocations = (from s in listPP
                              where s.AttributeID == 51
                              select new EMRAttributeClass
                              {
                                  AttributeName = s.AttributeName,
                                  AttributevalueID = s.AttributevalueID,
                                  AttributeValueName = s.AttributeValueName
                              }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Peripheral Pulses";
         lstEMRvalue.Attributeid = 51;
         lstEMRvalue.Attributevaluename = typeperipherallocations[0].AttributeName;

         EMR4.Bind(lstEMRvalue, typeperipherallocations);
         ddlLocation_51.DataSource = typeperipherallocations.ToList();
         ddlLocation_51.DataTextField = "AttributeValueName";
         ddlLocation_51.DataValueField = "AttributevalueID";
         ddlLocation_51.DataBind();
         ddlLocation_51.Items.Insert(0, "---Select---");

         //foreach (PatientExaminationAttribute objPEA in listPP)
         //{

         //    if (objPEA.ExaminationID == 884)
         //    {
         //        chkPeripheralPulses_884.Checked = true;
         //        tr1chkPeripheralPulses_884.Style.Add("display", "block");
         //        ddlFindingsSigns_50.SelectedValue = objPEA.AttributevalueID.ToString();

         //        if (objPEA.AttributeID == 51)
         //        {
         //            BindPeripheralPulsesAbnormal();
         //            ddlLocation_51.SelectedValue = objPEA.AttributevalueID.ToString();
                    
         //        }

         //    }
         //}

         #endregion

         #region Apex Beat

         var listAB = from Res in lstPEA
                     where Res.ExaminationID == 885
                     select Res;

         List<EMRAttributeClass> typeapex = (from s in listAB
                              where s.AttributeID == 52
                              select new EMRAttributeClass
                              {
                                  AttributeName = s.AttributeName,
                                  AttributevalueID = s.AttributevalueID,
                                  AttributeValueName = s.AttributeValueName
                              }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Apex Beat";
         lstEMRvalue.Attributeid = 52;
         lstEMRvalue.Attributevaluename = typeapex[0].AttributeName;

         EMR5.Bind(lstEMRvalue, typeapex);
         ddlFindings_52.DataSource = typeapex.ToList();
         ddlFindings_52.DataTextField = "AttributeValueName";
         ddlFindings_52.DataValueField = "AttributevalueID";
         ddlFindings_52.DataBind();
         ddlFindings_52.Items.Insert(0, "---Select---");

         List<EMRAttributeClass> typeapexlocations = (from s in listAB
                                       where s.AttributeID == 53
                                       select new EMRAttributeClass
                                       {
                                           AttributeName = s.AttributeName,
                                           AttributevalueID = s.AttributevalueID,
                                           AttributeValueName = s.AttributeValueName

                                       }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Apex Beat";
         lstEMRvalue.Attributeid = 53;
         lstEMRvalue.Attributevaluename = typeapexlocations[0].AttributeName;

         EMR6.Bind(lstEMRvalue, typeapexlocations);
         ddlTypesofabnormalitiess_53.DataSource = typeapexlocations.ToList();
         ddlTypesofabnormalitiess_53.DataTextField = "AttributeValueName";
         ddlTypesofabnormalitiess_53.DataValueField = "AttributevalueID";
         ddlTypesofabnormalitiess_53.DataBind();
         ddlTypesofabnormalitiess_53.Items.Insert(0, "---Select---");

         //foreach (PatientExaminationAttribute objPEA in listAB)
         //{

         //    if (objPEA.ExaminationID == 885)
         //    {
         //        chkApexBeat_885.Checked = true;
         //        tr1chkApexBeat_885.Style.Add("display", "block");
         //        ddlFindings_52.SelectedValue = objPEA.AttributevalueID.ToString();

         //        if (objPEA.AttributeID == 53)
         //        {
         //            BindApexBeatAbnormal();
         //            ddlTypesofabnormalitiess_53.SelectedValue = objPEA.AttributevalueID.ToString();
                    
         //        }

         //    }
         //}

         #endregion

         #region Heart Sounds

         var listHS = from Res in lstPEA
                      where Res.ExaminationID == 886
                      select Res;

         List<EMRAttributeClass> typeheart = (from s in listHS
                        where s.AttributeID == 54
                        select new EMRAttributeClass
                        {
                            AttributeName = s.AttributeName,
                            AttributevalueID = s.AttributevalueID,
                            AttributeValueName = s.AttributeValueName

                        }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Heart Sounds";
         lstEMRvalue.Attributeid = 54;
         lstEMRvalue.Attributevaluename = typeheart[0].AttributeName;

         EMR7.Bind(lstEMRvalue, typeheart);
         ddlFindings_54.DataSource = typeheart.ToList();
         ddlFindings_54.DataTextField = "AttributeValueName";
         ddlFindings_54.DataValueField = "AttributevalueID";
         ddlFindings_54.DataBind();
         ddlFindings_54.Items.Insert(0, "---Select---");

         List<EMRAttributeClass> typeheartlocations = (from s in listHS
                                 where s.AttributeID == 55
                                 select new EMRAttributeClass
                                 {
                                     AttributeName = s.AttributeName,
                                     AttributevalueID = s.AttributevalueID,
                                     AttributeValueName = s.AttributeValueName

                                 }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Heart Sounds";
         lstEMRvalue.Attributeid = 55;
         lstEMRvalue.Attributevaluename = typeheartlocations[0].AttributeName;

         EMR8.Bind(lstEMRvalue, typeheartlocations);
         ddlTypesofabnormalitiess_55.DataSource = typeheartlocations.ToList();
         ddlTypesofabnormalitiess_55.DataTextField = "AttributeValueName";
         ddlTypesofabnormalitiess_55.DataValueField = "AttributevalueID";
         ddlTypesofabnormalitiess_55.DataBind();
         ddlTypesofabnormalitiess_55.Items.Insert(0, "---Select---");

         //foreach (PatientExaminationAttribute objPEA in listHS)
         //{

         //    if (objPEA.ExaminationID == 886)
         //    {
         //        chkHeartSounds_886.Checked = true;
         //        tr1chkHeartSounds_886.Style.Add("display", "block");
         //        ddlFindings_54.SelectedValue = objPEA.AttributevalueID.ToString();

         //        if (objPEA.AttributeID == 55)
         //        {
         //            BindHeartSoundsAbnormal();
         //            ddlTypesofabnormalitiess_55.SelectedValue = objPEA.AttributevalueID.ToString();
         //            if (ddlTypesofabnormalitiess_55.SelectedItem.Text == "Others")
         //            {
         //                divddlTypesofabnormalitiess_55.Style.Add("display", "block");
         //                txtOthers_433.Text = objPEA.AttributeValueName;
         //            }
         //        }

         //    }
         //}

         #endregion

         #region Heart Mummurs

         var listT = from Res in lstPEA
                     where Res.ExaminationID == 887
                     select Res;

         List<EMRAttributeClass> typemummurs = (from s in listT
                         where s.AttributeID == 56
                         select new EMRAttributeClass
                         {
                             AttributeName = s.AttributeName,
                             AttributevalueID = s.AttributevalueID,
                             AttributeValueName = s.AttributeValueName

                         }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Heart Sounds";
         lstEMRvalue.Attributeid = 56;
         lstEMRvalue.Attributevaluename = typemummurs[0].AttributeName;

         EMR9.Bind(lstEMRvalue, typemummurs);
         ddlFindings_56.DataSource = typemummurs.ToList();
         ddlFindings_56.DataTextField = "AttributeValueName";
         ddlFindings_56.DataValueField = "AttributevalueID";
         ddlFindings_56.DataBind();
         ddlFindings_56.Items.Insert(0, "---Select---");

         List<EMRAttributeClass> typemumurslocations = (from s in listT
                                  where s.AttributeID == 57
                                  select new EMRAttributeClass
                                  {
                                      AttributeName = s.AttributeName,
                                      AttributevalueID = s.AttributevalueID,
                                      AttributeValueName = s.AttributeValueName

                                  }).ToList();

         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Heart Sounds";
         lstEMRvalue.Attributeid = 57;
         lstEMRvalue.Attributevaluename = typemumurslocations[0].AttributeName;

         EMR10.Bind(lstEMRvalue, typemumurslocations);

         ddlTypesofabnormalitiess_57.DataSource = typemumurslocations.ToList();
         ddlTypesofabnormalitiess_57.DataTextField = "AttributeValueName";
         ddlTypesofabnormalitiess_57.DataValueField = "AttributevalueID";
         ddlTypesofabnormalitiess_57.DataBind();
         ddlTypesofabnormalitiess_57.Items.Insert(0, "---Select---");

         //foreach (PatientExaminationAttribute objPEA in listT)
         //{

         //    if (objPEA.ExaminationID == 887)
         //    {
         //        chkHeartMummurs_887.Checked = true;
         //        tr1chkHeartMummurs_887.Style.Add("display", "block");
         //        ddlFindings_56.SelectedValue = objPEA.AttributevalueID.ToString();

         //        if (objPEA.AttributeID == 57)
         //        {
         //            BindHeartMummursAbnormal();
         //            ddlTypesofabnormalitiess_57.SelectedValue = objPEA.AttributevalueID.ToString();
         //            if (ddlTypesofabnormalitiess_57.SelectedItem.Text == "Others")
         //            {
         //                divddlTypesofabnormalitiess_57.Style.Add("display", "block");
         //                txtOthers_216.Text = objPEA.AttributeValueName;
         //            }
         //        }

         //    }
         //}

         #endregion


     }


     #region show OthersText
     protected void ddlTypesofabnormalitiess_55_SelectedIndexChanged(object sender, EventArgs e)
     {
         if (ddlTypesofabnormalitiess_55.SelectedItem.Text == "Others")
         {
             divddlTypesofabnormalitiess_55.Style.Add("display", "block");
         }
         else
         {
             divddlTypesofabnormalitiess_55.Style.Add("display", "none");
         }
     }
     protected void ddlTypesofabnormalitiess_57_SelectedIndexChanged(object sender, EventArgs e)
     {
         if (ddlTypesofabnormalitiess_57.SelectedItem.Text == "Others")
         {
             divddlTypesofabnormalitiess_57.Style.Add("display", "block");
             ddlTypesofabnormalitiess_57.Focus();
         }
         else
         {
             divddlTypesofabnormalitiess_57.Style.Add("display", "none");
         }
     }
     #endregion
}
