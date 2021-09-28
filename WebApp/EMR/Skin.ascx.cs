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
using Attune.Podium.Common;

public partial class HealthPackageControls_Skin : BaseControl
{
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlSkinType_1;
        EMR2.DDL = ddlSkinLesions_2;
        if (IsPostBack)
        {
            if ((chkSkin_928.Checked == true))
            {
                tr1chkSkin_928.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkSkin_928.Attributes.Add("Style", "Display:none");
            }
        }
    }
    
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Skin
        if (txtSign.Text != "")
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 941;
            objPatientExamination.ExaminationName = "General Sign";
            attribute.Add(objPatientExamination);
            PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
            objPatientExaminationAttribute.ExaminationID = 941;
            objPatientExaminationAttribute.AttributeID = 114;
            objPatientExaminationAttribute.AttributevalueID = 506;
            objPatientExaminationAttribute.AttributeValueName = Server.HtmlEncode(txtSign.Text).Replace("\n", "<br/>");
            attrValue.Add(objPatientExaminationAttribute);
        }
        if (chkSkin_928.Checked == true && ddlSkinType_1.SelectedItem.Text != "---Select---" || ddlSkinLesions_2.SelectedItem.Text != "---Select---")
        {
            if(chkSkin_928.Checked == true)
            {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 928;
            objPatientExamination.ExaminationName = chkSkin_928.Text;
            attribute.Add(objPatientExamination);

            #region lblSkinType_1
            if (ddlSkinType_1.SelectedItem.Text != "---Select---")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 928;
                objPatientExaminationAttribute.AttributeID = 1;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlSkinType_1.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlSkinType_1.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblSkinLesions_2
            if (ddlSkinLesions_2.SelectedItem.Text != "---Select---")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 928;
                objPatientExaminationAttribute.AttributeID = 2;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlSkinLesions_2.SelectedValue);

                if (ddlSkinLesions_2.SelectedItem.Text != "Others")
                {
                    objPatientExaminationAttribute.AttributeValueName = ddlSkinLesions_2.SelectedItem.Text;
                }
                else
                {
                    objPatientExaminationAttribute.AttributeValueName = txtSkinLesionsOthers_19.Text;
                }
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion
        }

        }
        #endregion

        return returnval;
    }


    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        try
        {

            var list = from S in lstPEA
                       where S.ExaminationID == 928
                       select S;


            List<EMRAttributeClass> typelist = (from s in list
                                                where s.AttributeID == 1
                                                select new EMRAttributeClass
                                                {
                                                    AttributeName = s.AttributeName,
                                                    AttributevalueID = s.AttributevalueID,
                                                    AttributeValueName = s.AttributeValueName

                                                }).ToList();
            lstEMR = typelist;
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Skin";
            lstEMRvalue.Attributeid = 1;
            lstEMRvalue.Attributevaluename = typelist[0].AttributeName;

            EMR1.Bind(lstEMRvalue, lstEMR);

            ddlSkinType_1.DataSource = typelist.ToList();
            ddlSkinType_1.DataTextField = "AttributeValueName";
            ddlSkinType_1.DataValueField = "AttributevalueID";
            ddlSkinType_1.DataBind();
            ddlSkinType_1.Items.Insert(0, "---Select---");

            List<EMRAttributeClass> Lessionslist = (from s in list
                                                    where s.AttributeID == 2
                                                    select new EMRAttributeClass
                                                    {
                                                        AttributeName = s.AttributeName,
                                                        AttributevalueID = s.AttributevalueID,
                                                        AttributeValueName = s.AttributeValueName
                                                    }).ToList();
            lstEMRlesions = Lessionslist;
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "Skin";
            lstEMRvalue.Attributeid = 2;
            lstEMRvalue.Attributevaluename = Lessionslist[0].AttributeName;
            EMR2.Bind(lstEMRvalue, lstEMRlesions);
            ddlSkinLesions_2.DataSource = Lessionslist.ToList();
            ddlSkinLesions_2.DataTextField = "AttributeValueName";
            ddlSkinLesions_2.DataValueField = "AttributevalueID";
            ddlSkinLesions_2.DataBind();
            ddlSkinLesions_2.Items.Insert(0, "---Select---");


            var listGeneral = from S in lstPEA
                              where S.ExaminationID == 941
                              select S;


            List<EMRAttributeClass> typelistGeneral = (from s in listGeneral
                                                       where s.AttributeID == 114
                                                       select new EMRAttributeClass
                                                       {
                                                           AttributeName = s.AttributeName,
                                                           AttributevalueID = s.AttributevalueID,
                                                           AttributeValueName = s.AttributeValueName

                                                       }).ToList();
            lstEMR = typelistGeneral;
            lstEMRvalue.Name = "Examination";
            lstEMRvalue.Attributename = "General";
            lstEMRvalue.Attributeid = 1;
            if (typelistGeneral.Count > 0)
            {
                lstEMRvalue.Attributevaluename = typelistGeneral[0].AttributeValueName;
                txtSign.Text = typelistGeneral[0].AttributeValueName.Replace("<br/>", "");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }

    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        var list = from S in lstPEA
                   where S.ExaminationID == 928
                   select S;

        foreach (PatientExaminationAttribute objPEA in list)
        {

            if (objPEA.ExaminationID == 928)
            {
                chkSkin_928.Checked = true;
                tr1chkSkin_928.Style.Add("display", "block");
                if (objPEA.AttributeID == 1)
                {

                    ddlSkinType_1.SelectedValue = objPEA.AttributevalueID.ToString();
                }
                if (objPEA.AttributeID == 2)
                {
                    ddlSkinLesions_2.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlSkinLesions_2.SelectedItem.Text == "Others")
                    {
                        divddlSkinLesions_2.Style.Add("display", "block");
                        txtSkinLesionsOthers_19.Text = objPEA.AttributeValueName;
                    }
                }

            }
            
        }
        var listGeneral = from S in lstPEA
                   where S.ExaminationID == 941
                   select S;
        foreach (PatientExaminationAttribute objPEA in listGeneral)
        {
            if (objPEA.ExaminationID == 941)
            {

                txtSign.Text = objPEA.AttributeValueName.ToString();

            }
        }

    }
    
    protected void lnklesion_Click(object sender, EventArgs e)
    {
        try
        {
            lstEMRlesions = (List<EMRAttributeClass>)Session["lesions"];
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }
}
