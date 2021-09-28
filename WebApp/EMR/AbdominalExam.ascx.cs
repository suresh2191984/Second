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
public partial class HealthPackageControls_AbdominalExam : BaseControl
{
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {

        EMR1.DDL = ddlInspection_58;
        EMR2.DDL = ddlPalpation_59;
        EMR3.DDL = ddlType_60;
        EMR4.DDL = ddlType_62;
        EMR5.DDL = ddlType_64;       
       
        if (IsPostBack)
        {
            if (chkAbdominalInspection_889.Checked == true)
            {
                tr1chkAbdominalInspection_889.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkAbdominalInspection_889.Attributes.Add("Style", "Display:none");
            }
            if (chkAbdominalPalpation_890.Checked == true)
            {
                tr1chkAbdominalPalpation_890.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkAbdominalPalpation_890.Attributes.Add("Style", "Display:none");
            }
            if (chkLiver_891.Checked == true)
            {
                tr1chkLiver_891.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkLiver_891.Attributes.Add("Style", "Display:none");
            }
            if (chkSpleen_892.Checked == true)
            {
                tr1chkSpleen_892.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkSpleen_892.Attributes.Add("Style", "Display:none");
            }
            if (chkKidneys_893.Checked == true)
            {
                tr1chkKidneys_893.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkKidneys_893.Attributes.Add("Style", "Display:none");
            }
            
        }
    }
    #region Bind dropdown
    protected void ddlType_60_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_60.SelectedItem.Text != "Not Palable")
        {
            trDescription_61.Style.Add("display", "block");
        }
        else
        {
            trDescription_61.Style.Add("display", "none");
        }
    }
    protected void ddlType_62_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_62.SelectedItem.Text != "Not Palable")
        {
            trDescription_63.Style.Add("display", "block");
        }
        else
        {
            trDescription_63.Style.Add("display", "none");
        }
    }
    protected void ddlType_64_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_64.SelectedItem.Text != "Not Ballotable")
        {
            trDescription_65.Style.Add("display", "block");
        }
        else
        {
            trDescription_65.Style.Add("display", "none");
        }
    }
    #endregion

    
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Abdominal Inspection
        if (chkAbdominalInspection_889.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 889;
            objPatientExamination.ExaminationName = chkAbdominalInspection_889.Text;
            attribute.Add(objPatientExamination);

            #region lblInspection_58

            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 889;
                objPatientExaminationAttribute.AttributeID = 58;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlInspection_58.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlInspection_58.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Abdominal Palpation
        if (chkAbdominalPalpation_890.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 890;
            objPatientExamination.ExaminationName = chkAbdominalPalpation_890.Text;
            attribute.Add(objPatientExamination);

            #region lblPalpation_59

            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 890;
                objPatientExaminationAttribute.AttributeID = 59;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlPalpation_59.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlPalpation_59.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion

        #region Liver
        if (chkLiver_891.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 891;
            objPatientExamination.ExaminationName = chkLiver_891.Text;
            attribute.Add(objPatientExamination);

            #region lblType_60  
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 891;
                objPatientExaminationAttribute.AttributeID = 60;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_60.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_60.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblDescription_61
            if (ddlType_60.SelectedItem.Text != "Not Palable")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 891;
                objPatientExaminationAttribute.AttributeID = 61;
                objPatientExaminationAttribute.AttributevalueID = 234;
                objPatientExaminationAttribute.AttributeValueName = txtDescription_234.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


        }
        #endregion

        #region Spleen
        if (chkSpleen_892.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 892;
            objPatientExamination.ExaminationName = chkSpleen_892.Text;
            attribute.Add(objPatientExamination);

            #region lblType_62
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 892;
                objPatientExaminationAttribute.AttributeID = 62;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_62.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_62.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblDescription_63
            if (ddlType_62.SelectedItem.Text != "Not Palable")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 892;
                objPatientExaminationAttribute.AttributeID = 63;
                objPatientExaminationAttribute.AttributevalueID = 238;
                objPatientExaminationAttribute.AttributeValueName = txtDescription_238.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


        }
        #endregion

        #region Kidneys
        if (chkKidneys_893.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 893;
            objPatientExamination.ExaminationName = chkKidneys_893.Text;
            attribute.Add(objPatientExamination);

            #region lblType_64
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 893;
                objPatientExaminationAttribute.AttributeID = 64;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_64.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_64.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblDescription_65
            if (ddlType_64.SelectedItem.Text != "Not Ballotable")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 893;
                objPatientExaminationAttribute.AttributeID = 65;
                objPatientExaminationAttribute.AttributevalueID = 246;
                objPatientExaminationAttribute.AttributeValueName = txtDescription_246.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion


        }
        #endregion


        #region Other Findings
        if (chkOtherFindings_914.Checked == true && txtOtherFindings_439.Text!="")
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 914;
            objPatientExamination.ExaminationName = chkOtherFindings_914.Text;
            attribute.Add(objPatientExamination);

            #region lblOtherFindings_98
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 914;
                objPatientExaminationAttribute.AttributeID = 98;
                objPatientExaminationAttribute.AttributevalueID = 439;
                objPatientExaminationAttribute.AttributeValueName = txtOtherFindings_439.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

        }
        #endregion



        return returnval;
    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Abdominal Inspection
        var listAE = from Res in lstPEA
                     where Res.ExaminationID == 889
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listAE)
        {

            if (objPEA.ExaminationID == 889)
            {
                chkAbdominalInspection_889.Checked = true;
                tr1chkAbdominalInspection_889.Style.Add("display", "block");
                ddlInspection_58.SelectedValue = objPEA.AttributevalueID.ToString();

            }
        }
        #endregion

        #region Abdominal Palpation
        var listAP = from Res in lstPEA
                     where Res.ExaminationID == 890
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listAP)
        {

            if (objPEA.ExaminationID == 890)
            {
                chkAbdominalPalpation_890.Checked = true;
                tr1chkAbdominalPalpation_890.Style.Add("display", "block");
                ddlPalpation_59.SelectedValue = objPEA.AttributevalueID.ToString();

            }
        }
        #endregion

        #region Liver

        var listL = from Res in lstPEA
                    where Res.ExaminationID == 891
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listL)
        {

            if (objPEA.ExaminationID == 891)
            {
                chkLiver_891.Checked = true;
                tr1chkLiver_891.Style.Add("display", "block");
                ddlType_60.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 61)
                {
                    trDescription_61.Style.Add("display", "block");
                    txtDescription_234.Text = objPEA.AttributeValueName;
                }

            }
        }

        #endregion

        #region Spleen

        var listS = from Res in lstPEA
                    where Res.ExaminationID == 892
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listS)
        {

            if (objPEA.ExaminationID == 892)
            {
                chkSpleen_892.Checked = true;
                tr1chkSpleen_892.Style.Add("display", "block");
                ddlType_62.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 63)
                {
                    trDescription_63.Style.Add("display", "block");
                    txtDescription_238.Text = objPEA.AttributeValueName;
                }

            }
        }

        #endregion

        #region Kidneys

        var listK = from Res in lstPEA
                    where Res.ExaminationID == 893
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listK)
        {

            if (objPEA.ExaminationID == 893)
            {
                chkKidneys_893.Checked = true;
                tr1chkKidneys_893.Style.Add("display", "block");
                ddlType_64.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 65)
                {
                    trDescription_65.Style.Add("display", "block");
                    txtDescription_246.Text = objPEA.AttributeValueName;
                }

            }
        }

        #endregion

        #region OtherFindings
        var listOF = from Res in lstPEA
                     where Res.ExaminationID == 914
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listOF)
        {

            if (objPEA.ExaminationID == 914)
            {
                chkOtherFindings_914.Checked = true;
                tr1chkOtherFindings_914.Style.Add("display", "block");
                txtOtherFindings_439.Text = objPEA.AttributeValueName;

            }
        }
        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Abdominal Inspection
        var listAE = from Res in lstPEA
                     where Res.ExaminationID == 889
                     select Res;

        List<EMRAttributeClass> typeapex = (from s in listAE
                       where s.AttributeID == 58
                      select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Abdominal Inspection";
        lstEMRvalue.Attributeid = 58;
        lstEMRvalue.Attributevaluename = typeapex[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typeapex);
        ddlInspection_58.DataSource = typeapex.ToList();
        ddlInspection_58.DataTextField = "AttributeValueName";
        ddlInspection_58.DataValueField = "AttributevalueID";
        ddlInspection_58.DataBind();
        ddlInspection_58.Items.Insert(0, "---Select---");

        
        #endregion

        #region Abdominal Palpation
        var listAP = from Res in lstPEA
                     where Res.ExaminationID == 890
                     select Res;

        List<EMRAttributeClass> typeabdominal = (from s in listAP
                       where s.AttributeID == 59
                       select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Abdominal Palpation";
        lstEMRvalue.Attributeid = 59;
        lstEMRvalue.Attributevaluename = typeabdominal[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typeabdominal);
        ddlPalpation_59.DataSource = typeabdominal.ToList();
        ddlPalpation_59.DataTextField = "AttributeValueName";
        ddlPalpation_59.DataValueField = "AttributevalueID";
        ddlPalpation_59.DataBind();
        ddlPalpation_59.Items.Insert(0, "---Select---");

        
        #endregion

        #region Liver

        var listL = from Res in lstPEA
                    where Res.ExaminationID == 891
                    select Res;

        List<EMRAttributeClass> typeliver = (from s in listL
                            where s.AttributeID == 60
                            select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Liver";
        lstEMRvalue.Attributeid = 60;
        lstEMRvalue.Attributevaluename = typeliver[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typeliver);
        ddlType_60.DataSource = typeliver.ToList();
        ddlType_60.DataTextField = "AttributeValueName";
        ddlType_60.DataValueField = "AttributevalueID";
        ddlType_60.DataBind();
        ddlType_60.Items.Insert(0, "---Select---");
        

        #endregion

        #region Spleen

        var listS = from Res in lstPEA
                    where Res.ExaminationID == 892
                    select Res;

        List<EMRAttributeClass> typespleen = (from s in listS
                        where s.AttributeID == 62
                        select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Spleen";
        lstEMRvalue.Attributeid = 62;
        lstEMRvalue.Attributevaluename = typespleen[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typespleen);

        ddlType_62.DataSource = typespleen.ToList();
        ddlType_62.DataTextField = "AttributeValueName";
        ddlType_62.DataValueField = "AttributevalueID";
        ddlType_62.DataBind();
        ddlType_62.Items.Insert(0, "---Select---");
        

        #endregion

        #region Kidneys

        var listK = from Res in lstPEA
                    where Res.ExaminationID == 893
                    select Res;

        List<EMRAttributeClass> typekidneys = (from s in listK
                         where s.AttributeID == 64
                         select new EMRAttributeClass
                                            {
                                                AttributeName = s.AttributeName,
                                                AttributevalueID = s.AttributevalueID,
                                                AttributeValueName = s.AttributeValueName
                                            }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Kidneys";
        lstEMRvalue.Attributeid = 64;
        lstEMRvalue.Attributevaluename = typekidneys[0].AttributeName;

        EMR5.Bind(lstEMRvalue, typekidneys);

        ddlType_64.DataSource = typekidneys.ToList();
        ddlType_64.DataTextField = "AttributeValueName";
        ddlType_64.DataValueField = "AttributevalueID";
        ddlType_64.DataBind();
        ddlType_64.Items.Insert(0, "---Select---");
        

        #endregion      

    }
}
