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

public partial class HealthPackageControls_OralCavity : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlType_66;
        EMR2.DDL = ddlType_67;
        EMR3.DDL = ddlAbnormalities_68;
        EMR4.DDL = ddlType_69;
        EMR5.DDL = ddlAbnormalities_70;
        EMR6.DDL = ddlType_71;
        EMR7.DDL = ddlAbnormalities_72;
        EMR8.DDL = ddlType_73;
        EMR9.DDL = ddlAbnormalities_74;        
       
        if (IsPostBack)
        {
            if (chkGeneralAppearance_895.Checked == true)
            {
                tr1chkGeneralAppearance_895.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkGeneralAppearance_895.Attributes.Add("Style", "Display:none");
            }
            if (chkTeeth_896.Checked == true)
            {
                tr1chkTeeth_896.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkTeeth_896.Attributes.Add("Style", "Display:none");
            }
            if (chkTongue_897.Checked == true)
            {
                tr1chkTongue_897.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkTongue_897.Attributes.Add("Style", "Display:none");
            }
            if (chkTonsils_898.Checked == true)
            {
                tr1chkTonsils_898.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkTonsils_898.Attributes.Add("Style", "Display:none");
            }
            if (chkPharynx_899.Checked == true)
            {
                tr1chkPharynx_899.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkPharynx_899.Attributes.Add("Style", "Display:none");
            }
        }
    }

    #region Dropdown SelectedIndexChanged
    protected void ddlType_67_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_67.SelectedItem.Text == "Abnormal")
        {
            //List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
            //returnCode = new SmartAccessor().GetExamAttributeValues(67, out lstExaminationAttributeValues);
            //trAbnormalities_68.Style.Add("display", "block");
            //ddlAbnormalities_68.DataSource = lstExaminationAttributeValues;
            //ddlAbnormalities_68.DataTextField = "AttributeValueName";
            //ddlAbnormalities_68.DataValueField = "AttributevalueID";
            //ddlAbnormalities_68.DataBind();
            BindTeethAbnormal();
           

        }
        else
        {
            trAbnormalities_68.Style.Add("display", "none");
            divddlAbnormalities_68.Style.Add("display", "none");
            
        }
    }
    protected void ddlType_69_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_69.SelectedItem.Text == "Abnormal")
        {
            //List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
            //returnCode = new SmartAccessor().GetExamAttributeValues(69, out lstExaminationAttributeValues);
            //trAbnormalities_70.Style.Add("display", "block");
            //ddlAbnormalities_70.DataSource = lstExaminationAttributeValues;
            //ddlAbnormalities_70.DataTextField = "AttributeValueName";
            //ddlAbnormalities_70.DataValueField = "AttributevalueID";
            //ddlAbnormalities_70.DataBind();
            BindTongueAbnormal();
        }
        else
        {
            trAbnormalities_70.Style.Add("display", "none");
            divddlAbnormalities_70.Style.Add("display", "none");
            
        }
    }
    protected void ddlType_71_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_71.SelectedItem.Text == "Abnormal")
        {
            //List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
            //returnCode = new SmartAccessor().GetExamAttributeValues(71, out lstExaminationAttributeValues);
            //trAbnormalities_72.Style.Add("display", "block");
            //ddlAbnormalities_72.DataSource = lstExaminationAttributeValues;
            //ddlAbnormalities_72.DataTextField = "AttributeValueName";
            //ddlAbnormalities_72.DataValueField = "AttributevalueID";
            //ddlAbnormalities_72.DataBind();
            BindTonsilsAbnormal();
        }
        else
        {
            trAbnormalities_72.Style.Add("display", "none");
            divddlAbnormalities_72.Style.Add("display", "none");
        }
    }
    protected void ddlType_73_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_73.SelectedItem.Text == "Abnormal")
        {
            //List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
            //returnCode = new SmartAccessor().GetExamAttributeValues(73, out lstExaminationAttributeValues);
            //trAbnormalities_74.Style.Add("display", "block");
            //ddlAbnormalities_74.DataSource = lstExaminationAttributeValues;
            //ddlAbnormalities_74.DataTextField = "AttributeValueName";
            //ddlAbnormalities_74.DataValueField = "AttributevalueID";
            //ddlAbnormalities_74.DataBind();
            BindPharynxAbnormal();
        }
        else
        {
            trAbnormalities_74.Style.Add("display", "none");
            divddlAbnormalities_74.Style.Add("display", "none");
        }
    }
    #endregion


    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        # region General Appearance
        if (chkGeneralAppearance_895.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 895;
            objPatientExamination.ExaminationName = chkGeneralAppearance_895.Text;
            attribute.Add(objPatientExamination);
            # region lblType_66
            if (ddlType_66.SelectedItem.Text == "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 895;
                objPatientExaminationAttribute.AttributeID = 66;
                objPatientExaminationAttribute.AttributevalueID = 252;
                objPatientExaminationAttribute.AttributeValueName = txtOthers_252.Text;
                attrValue.Add(objPatientExaminationAttribute);

            }
            else
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 895;
                objPatientExaminationAttribute.AttributeID = 66;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_66.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_66.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            # endregion

        }
        # endregion

        #region Teeth
        if (chkTeeth_896.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 896;
            objPatientExamination.ExaminationName = chkTeeth_896.Text;
            attribute.Add(objPatientExamination);

            #region lblType_67
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 896;
                objPatientExaminationAttribute.AttributeID = 67;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_67.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_67.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_68
            if (ddlType_67.SelectedItem.Text == "Abnormal" && ddlAbnormalities_68.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 896;
                objPatientExaminationAttribute.AttributeID = 68;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_68.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_68.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_67.SelectedItem.Text == "Abnormal" && ddlAbnormalities_68.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 896;
                    objPatientExaminationAttribute.AttributeID = 68;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_68.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_263.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }
           
            #endregion

        }
        #endregion

        #region Tongue
        if (chkTongue_897.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 897;
            objPatientExamination.ExaminationName = chkTongue_897.Text;
            attribute.Add(objPatientExamination);

            #region lblType_69
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 897;
                objPatientExaminationAttribute.AttributeID = 69;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_69.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_69.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


            #region lblAbnormalities_70
            if (ddlType_69.SelectedItem.Text == "Abnormal" && ddlAbnormalities_70.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 897;
                objPatientExaminationAttribute.AttributeID = 70;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_70.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_70.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_69.SelectedItem.Text == "Abnormal" && ddlAbnormalities_70.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 897;
                    objPatientExaminationAttribute.AttributeID = 70;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_70.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_275.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Tonsils
        if (chkTonsils_898.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 898;
            objPatientExamination.ExaminationName = chkTonsils_898.Text;
            attribute.Add(objPatientExamination);

            #region lblType_71
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 898;
                objPatientExaminationAttribute.AttributeID = 71;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_71.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_71.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAbnormalities_72
            if (ddlType_71.SelectedItem.Text == "Abnormal" && ddlAbnormalities_72.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 898;
                objPatientExaminationAttribute.AttributeID = 72;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_72.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_72.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_71.SelectedItem.Text == "Abnormal" && ddlAbnormalities_72.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 898;
                    objPatientExaminationAttribute.AttributeID = 72;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_72.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_283.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
            }

            #endregion

        }
        #endregion

        #region Pharynx
        if (chkPharynx_899.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 899;
            objPatientExamination.ExaminationName = chkPharynx_899.Text;
            attribute.Add(objPatientExamination);

            #region lblType_73
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 899;
                objPatientExaminationAttribute.AttributeID = 73;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_73.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_73.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAbnormalities_74
            if (ddlType_73.SelectedItem.Text == "Abnormal" && ddlAbnormalities_74.SelectedItem.Text != "Others")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 899;
                objPatientExaminationAttribute.AttributeID = 74;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_74.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_74.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            else
            {
                if (ddlType_73.SelectedItem.Text == "Abnormal" && ddlAbnormalities_74.SelectedItem.Text == "Others")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 899;
                    objPatientExaminationAttribute.AttributeID = 74;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_74.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = txtOthers_290.Text;
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

        # region General Appearance

        var listGA = from S in lstPEA
                     where S.ExaminationID == 895
                     select S;

        foreach (PatientExaminationAttribute objPEA in listGA)
        {

            if (objPEA.ExaminationID == 895)
            {
                chkGeneralAppearance_895.Checked = true;
                tr1chkGeneralAppearance_895.Style.Add("display", "block");
                ddlType_66.SelectedValue = objPEA.AttributevalueID.ToString();

                if (ddlType_66.SelectedItem.Text == "Others")
                {
                    divddlType_66.Style.Add("display", "block");
                    txtOthers_252.Text = objPEA.AttributeValueName;
                }

            }
        }
        #endregion

        #region Teeth

        var listT = from S in lstPEA
                    where S.ExaminationID == 896
                    select S;

        foreach (PatientExaminationAttribute objPEA in listT)
        {

            if (objPEA.ExaminationID == 896)
            {
                chkTeeth_896.Checked = true;
                tr1chkTeeth_896.Style.Add("display", "block");
                ddlType_67.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 68)
                {
                    BindTeethAbnormal();
                    ddlAbnormalities_68.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_68.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_68.Style.Add("display", "block");
                        txtOthers_263.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Tongue

        var listTongue = from S in lstPEA
                         where S.ExaminationID == 897
                         select S;

        foreach (PatientExaminationAttribute objPEA in listTongue)
        {

            if (objPEA.ExaminationID == 897)
            {
                chkTongue_897.Checked = true;
                tr1chkTongue_897.Style.Add("display", "block");
                ddlType_69.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 70)
                {
                    BindTongueAbnormal();
                    ddlAbnormalities_70.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_70.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_70.Style.Add("display", "block");
                        txtOthers_275.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Tonsils

        var listTonsils = from S in lstPEA
                          where S.ExaminationID == 898
                          select S;

        foreach (PatientExaminationAttribute objPEA in listTonsils)
        {

            if (objPEA.ExaminationID == 898)
            {
                chkTonsils_898.Checked = true;
                tr1chkTonsils_898.Style.Add("display", "block");
                ddlType_71.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 72)
                {
                    BindTonsilsAbnormal();
                    ddlAbnormalities_72.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_72.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_72.Style.Add("display", "block");
                        txtOthers_283.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

        #region Pharynx

        var listPharynx = from S in lstPEA
                          where S.ExaminationID == 899
                          select S;

        foreach (PatientExaminationAttribute objPEA in listPharynx)
        {

            if (objPEA.ExaminationID == 899)
            {
                chkPharynx_899.Checked = true;
                tr1chkPharynx_899.Style.Add("display", "block");
                ddlType_73.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 74)
                {
                    BindPharynxAbnormal();
                    ddlAbnormalities_74.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_74.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_74.Style.Add("display", "block");
                        txtOthers_290.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion

    }


    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {

        # region General Appearance

        var listGA = from S in lstPEA
                   where S.ExaminationID == 895
                   select S;

        List<EMRAttributeClass> typerightlist = (from s in listGA
                            where s.AttributeID ==66
                            select new EMRAttributeClass
                            {
                                AttributeName = s.AttributeName,
                                AttributevalueID = s.AttributevalueID,
                                AttributeValueName = s.AttributeValueName
                            }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "General Appearance";
        lstEMRvalue.Attributeid = 895;
        lstEMRvalue.Attributevaluename = typerightlist[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typerightlist);  

        ddlType_66.DataSource = typerightlist.ToList();
        ddlType_66.DataTextField = "AttributeValueName";
        ddlType_66.DataValueField = "AttributevalueID";
        ddlType_66.DataBind();
        ddlType_66.Items.Insert(0, "---Select---");

        
        #endregion

        #region Teeth

        var listT = from S in lstPEA
                     where S.ExaminationID == 896
                     select S;

        List<EMRAttributeClass> typelist = (from s in listT
                                            where s.AttributeID == 67
                                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName

                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Teeth";
        lstEMRvalue.Attributeid = 67;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typelist);  
        ddlType_67.DataSource = typelist.ToList();
        ddlType_67.DataTextField = "AttributeValueName";
        ddlType_67.DataValueField = "AttributevalueID";
        ddlType_67.DataBind();
        ddlType_67.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typeabnormallist = (from s in listT
                            where s.AttributeID == 68
                           select new EMRAttributeClass
                            {
                               AttributeName= s.AttributeName,
                               AttributevalueID= s.AttributevalueID,
                               AttributeValueName= s.AttributeValueName
                            }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Teeth";
        lstEMRvalue.Attributeid = 68;
        lstEMRvalue.Attributevaluename = typeabnormallist[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typeabnormallist);  
        ddlAbnormalities_68.DataSource = typeabnormallist.ToList();
        ddlAbnormalities_68.DataTextField = "AttributeValueName";
        ddlAbnormalities_68.DataValueField = "AttributevalueID";
        ddlAbnormalities_68.DataBind();
        ddlAbnormalities_68.Items.Insert(0, "---Select---");        
        #endregion

        #region Tongue

        var listTongue = from S in lstPEA
                    where S.ExaminationID == 897
                    select S;


        List<EMRAttributeClass> typetonguelist = (from s in listTongue
                                                  where s.AttributeID == 69
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeName = s.AttributeName,
                                                      AttributevalueID = s.AttributevalueID,
                                                      AttributeValueName = s.AttributeValueName

                                                  }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Tongue";
        lstEMRvalue.Attributeid = 69;
        lstEMRvalue.Attributevaluename = typetonguelist[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typetonguelist);  
        ddlType_69.DataSource = typetonguelist.ToList();
        ddlType_69.DataTextField = "AttributeValueName";
        ddlType_69.DataValueField = "AttributevalueID";
        ddlType_69.DataBind();
        ddlType_69.Items.Insert(0, "---Select---");


        List<EMRAttributeClass> typeabnormaltonguelist = (from s in listTongue
                       where s.AttributeID == 70
                       select new EMRAttributeClass
                       {
                           AttributeName=s.AttributeName,
                           AttributevalueID=s.AttributevalueID,
                           AttributeValueName=s.AttributeValueName

                       }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Tongue";
        lstEMRvalue.Attributeid = 70;
        lstEMRvalue.Attributevaluename = typeabnormaltonguelist[0].AttributeName;

        EMR5.Bind(lstEMRvalue, typeabnormaltonguelist);
        ddlAbnormalities_70.DataSource = typeabnormaltonguelist.ToList();
        ddlAbnormalities_70.DataTextField = "AttributeValueName";
        ddlAbnormalities_70.DataValueField = "AttributevalueID";
        ddlAbnormalities_70.DataBind();
        ddlAbnormalities_70.Items.Insert(0, "---Select---");


       

        #endregion

        #region Tonsils

        var listTonsils = from S in lstPEA
                    where S.ExaminationID == 898
                    select S;

        List<EMRAttributeClass> typetonsilslist = (from s in listTonsils
                              where s.AttributeID == 71
                              select new EMRAttributeClass
                              {
                                  AttributeName = s.AttributeName,
                                  AttributevalueID = s.AttributevalueID,
                                  AttributeValueName = s.AttributeValueName

                              }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Tonsils";
        lstEMRvalue.Attributeid = 71;
        lstEMRvalue.Attributevaluename = typetonsilslist[0].AttributeName;

        EMR6.Bind(lstEMRvalue, typetonsilslist);

        ddlType_71.DataSource = typetonsilslist.ToList();
        ddlType_71.DataTextField = "AttributeValueName";
        ddlType_71.DataValueField = "AttributevalueID";
        ddlType_71.DataBind();
        ddlType_71.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typeabnormaltonsilslist = (from s in listTonsils
                             where s.AttributeID == 72
                             select new EMRAttributeClass
                             {
                                 AttributeName=s.AttributeName,
                                 AttributevalueID=s.AttributevalueID,
                                 AttributeValueName=s.AttributeValueName

                             }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Tonsils";
        lstEMRvalue.Attributeid = 72;
        lstEMRvalue.Attributevaluename = typeabnormaltonsilslist[0].AttributeName;

        EMR7.Bind(lstEMRvalue, typeabnormaltonsilslist);

        ddlAbnormalities_72.DataSource = typeabnormaltonsilslist.ToList();
        ddlAbnormalities_72.DataTextField = "AttributeValueName";
        ddlAbnormalities_72.DataValueField = "AttributevalueID";
        ddlAbnormalities_72.DataBind();
        ddlAbnormalities_72.Items.Insert(0, "---Select---");

        

        #endregion

        #region Pharynx

        var listPharynx = from S in lstPEA
                          where S.ExaminationID == 899
                          select S;

        List<EMRAttributeClass> typepharynxlist = (from s in listPharynx
                                                   where s.AttributeID == 73
                                                   select new EMRAttributeClass
                                                   {
                                                       AttributeName = s.AttributeName,
                                                       AttributevalueID = s.AttributevalueID,
                                                       AttributeValueName = s.AttributeValueName

                                                   }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pharynx";
        lstEMRvalue.Attributeid = 73;
        lstEMRvalue.Attributevaluename = typepharynxlist[0].AttributeName;

        EMR8.Bind(lstEMRvalue, typepharynxlist);

        ddlType_73.DataSource = typepharynxlist.ToList();
        ddlType_73.DataTextField = "AttributeValueName";
        ddlType_73.DataValueField = "AttributevalueID";
        ddlType_73.DataBind();
        ddlType_73.Items.Insert(0, "---Select---");


        List<EMRAttributeClass> typeabnormalpharynxlist = (from s in listPharynx
                              where s.AttributeID == 74
                              select new EMRAttributeClass
                              {
                                  AttributeName = s.AttributeName,
                                  AttributevalueID = s.AttributevalueID,
                                  AttributeValueName = s.AttributeValueName

                              }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Pharynx";
        lstEMRvalue.Attributeid = 74;
        lstEMRvalue.Attributevaluename = typeabnormalpharynxlist[0].AttributeName;

        EMR9.Bind(lstEMRvalue, typeabnormalpharynxlist);

        ddlAbnormalities_74.DataSource = typeabnormalpharynxlist.ToList();
        ddlAbnormalities_74.DataTextField = "AttributeValueName";
        ddlAbnormalities_74.DataValueField = "AttributevalueID";
        ddlAbnormalities_74.DataBind();
        ddlAbnormalities_74.Items.Insert(0, "---Select---");

        

        #endregion

      

    }
    
    #region Bind Dropdown During Edit
    public void BindTeethAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(68, out lstExaminationAttributeValues);
        trAbnormalities_68.Style.Add("display", "block");
        tdAbnormalities_68.Style.Add("display", "block");
        ddlAbnormalities_68.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_68.DataTextField = "AttributeValueName";
        ddlAbnormalities_68.DataValueField = "AttributevalueID";
        ddlAbnormalities_68.DataBind();
    }

    public void BindTongueAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(70, out lstExaminationAttributeValues);
        trAbnormalities_70.Style.Add("display", "block");
        tdAbnormalities_70.Style.Add("display", "block");
        ddlAbnormalities_70.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_70.DataTextField = "AttributeValueName";
        ddlAbnormalities_70.DataValueField = "AttributevalueID";
        ddlAbnormalities_70.DataBind();
    }

    public void BindTonsilsAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(72, out lstExaminationAttributeValues);
        trAbnormalities_72.Style.Add("display", "block");
        tdAbnormalities_72.Style.Add("display", "block");
        ddlAbnormalities_72.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_72.DataTextField = "AttributeValueName";
        ddlAbnormalities_72.DataValueField = "AttributevalueID";
        ddlAbnormalities_72.DataBind();
    }
    public void BindPharynxAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(74, out lstExaminationAttributeValues);
        trAbnormalities_74.Style.Add("display", "block");
        tdAbnormalities_74.Style.Add("display", "block");
        ddlAbnormalities_74.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_74.DataTextField = "AttributeValueName";
        ddlAbnormalities_74.DataValueField = "AttributevalueID";
        ddlAbnormalities_74.DataBind();
    }



    #endregion


    #region show OthersText
    protected void ddlAbnormalities_68_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_68.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_68.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_68.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_70_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_70.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_70.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_70.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_72_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlAbnormalities_72.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_72.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_72.Style.Add("display", "none");
        }
    }
    protected void ddlAbnormalities_74_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_74.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_74.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_74.Style.Add("display", "none");
        }
    }
    #endregion
}
