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

public partial class HealthPackageControls_Neck : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlType_39;
        EMR2.DDL = ddlAbnormalities_40;
        EMR3.DDL = ddlType_41;
        EMR4.DDL = ddlLocation_42;  

        if (IsPostBack)
        {
            if (chkThyroidGland_875.Checked == true)
            {
                tr1chkThyroidGland_875.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkThyroidGland_875.Attributes.Add("Style", "Display:none");
            }
            if (chkLymphNodes_876.Checked == true)
            {
                tr1chkLymphNodes_876.Attributes.Add("Style", "Display:block");
            }
            else
            {
                tr1chkLymphNodes_876.Attributes.Add("Style", "Display:none");
            }
        }
    }    

    #region Bind Dropdown 
    public void BindThyroidGlandAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(39, out lstExaminationAttributeValues);
        trType_39.Style.Add("display", "block");
        //tdType_39.Style.Add("Style", "display:block");
        ddlAbnormalities_40.DataSource = lstExaminationAttributeValues;
        ddlAbnormalities_40.DataTextField = "AttributeValueName";
        ddlAbnormalities_40.DataValueField = "AttributevalueID";
        ddlAbnormalities_40.DataBind();
    }
    public void BindLymphNodesAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(41, out lstExaminationAttributeValues);
        trType_41.Style.Add("display", "block");
        //tdType_41.Style.Add("Style", "display:block");
        ddlLocation_42.DataSource = lstExaminationAttributeValues;
        ddlLocation_42.DataTextField = "AttributeValueName";
        ddlLocation_42.DataValueField = "AttributevalueID";
        ddlLocation_42.DataBind();
    }
    #endregion

    protected void ddlType_39_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType_39.SelectedItem.Text != "Normal" && ddlType_39.SelectedItem.Text !="Not Palpable")
        {
            BindThyroidGlandAbnormal();
            tdType_39.Style.Add("display", "block");
            ddlType_39.Focus();
            ddlAbnormalities_40.Focus();
        }
        else
        {
            trType_39.Style.Add("display", "none");
            tdType_39.Style.Add("display", "none");
            divddlAbnormalities_40.Style.Add("display", "none");   
            
        }
    }
    
    protected void ddlType_41_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlLocation_42.Focus();
        if (ddlType_41.SelectedItem.Text != "Not Swollen")
        {
            BindLymphNodesAbnormal();
            tdType_41.Style.Add("display", "block");
        }
        else
        {
            trType_41.Style.Add("display", "none");
            tdType_41.Style.Add("display", "none");
        }
    }

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Neck Thyroid Gland
        if (chkThyroidGland_875.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 875;
            objPatientExamination.ExaminationName = chkThyroidGland_875.Text;
            attribute.Add(objPatientExamination);

            #region lblType_39
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 875;
                objPatientExaminationAttribute.AttributeID = 39;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_39.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_39.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblAbnormalities_40
            {
                if (ddlType_39.SelectedItem.Text != "Normal" && ddlType_39.SelectedItem.Text !="Not Palpable")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 875;
                    objPatientExaminationAttribute.AttributeID = 40;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlAbnormalities_40.SelectedValue);

                    if (ddlAbnormalities_40.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlAbnormalities_40.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtAbnormalitiesOthers_129.Text;
                    }

                    attrValue.Add(objPatientExaminationAttribute);
                }
                

            }
            #endregion

        }
        #endregion

        #region Neck Lymph Nodes
        if (chkLymphNodes_876.Checked == true)
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 876;
            objPatientExamination.ExaminationName = chkLymphNodes_876.Text;
            attribute.Add(objPatientExamination);

            #region lblType_41
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 876;
                objPatientExaminationAttribute.AttributeID = 41;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlType_41.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlType_41.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblLocation_42
            {
                if (ddlType_41.SelectedItem.Text != "Not Swollen")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 876;
                    objPatientExaminationAttribute.AttributeID = 42;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLocation_42.SelectedValue);

                    objPatientExaminationAttribute.AttributeValueName = ddlLocation_42.SelectedItem.Text;
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
        #region Thyroid Gland

        var listTG = from Res in lstPEA
                     where Res.ExaminationID == 875
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listTG)
        {

            if (objPEA.ExaminationID == 875)
            {
                chkThyroidGland_875.Checked = true;
                tr1chkThyroidGland_875.Style.Add("display", "block");
                ddlType_39.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 40)
                {
                    BindThyroidGlandAbnormal();
                    ddlAbnormalities_40.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlAbnormalities_40.SelectedItem.Text == "Others")
                    {
                        divddlAbnormalities_40.Style.Add("display", "block");
                        txtAbnormalitiesOthers_129.Text = objPEA.AttributeValueName;
                    }
                }

            }
        }

        #endregion


        #region Lymph Nodes

        var listLN = from Res in lstPEA
                     where Res.ExaminationID == 876
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listLN)
        {

            if (objPEA.ExaminationID == 876)
            {
                chkLymphNodes_876.Checked = true;
                tr1chkLymphNodes_876.Style.Add("display", "block");
                ddlType_41.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 42)
                {
                    BindLymphNodesAbnormal();
                    ddlLocation_42.SelectedValue = objPEA.AttributevalueID.ToString();

                }

            }
        }

        #endregion



    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Thyroid Gland

        var listTG = from Res in lstPEA
                     where Res.ExaminationID == 875
                     select Res;
        List<EMRAttributeClass>  typelist = (from s in listTG
                             where s.AttributeID == 39
                            select new EMRAttributeClass
                             {
                                 AttributeName = s.AttributeName,
                                 AttributevalueID = s.AttributevalueID,
                                 AttributeValueName = s.AttributeValueName

                             }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Thyroid Gland";
        lstEMRvalue.Attributeid = 39;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typelist);

        ddlType_39.DataSource = typelist.ToList();
        ddlType_39.DataTextField = "AttributeValueName";
        ddlType_39.DataValueField = "AttributevalueID";
        ddlType_39.DataBind();
        ddlType_39.Items.Insert(0, "---Select---");


        List<EMRAttributeClass> typetonguelist = (from s in listTG
                             where s.AttributeID == 40
                             select new EMRAttributeClass
                             {
                                 AttributeName = s.AttributeName,
                                 AttributevalueID = s.AttributevalueID,
                                 AttributeValueName = s.AttributeValueName

                             }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Thyroid Gland";
        lstEMRvalue.Attributeid = 40;
        lstEMRvalue.Attributevaluename = typetonguelist[0].AttributeName;

        EMR2.Bind(lstEMRvalue, typetonguelist);
        ddlAbnormalities_40.DataSource = typetonguelist.ToList();
        ddlAbnormalities_40.DataTextField = "AttributeValueName";
        ddlAbnormalities_40.DataValueField = "AttributevalueID";
        ddlAbnormalities_40.DataBind();
        ddlAbnormalities_40.Items.Insert(0, "---Select---");

        

        #endregion


        #region Lymph Nodes

        var listLN= from Res in lstPEA
                     where Res.ExaminationID == 876
                     select Res;

        List<EMRAttributeClass> typeLymph = (from s in listLN
                       where s.AttributeID == 41
                       select new EMRAttributeClass
                       {
                           AttributeName = s.AttributeName,
                           AttributevalueID = s.AttributevalueID,
                           AttributeValueName = s.AttributeValueName

                       }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Lymph Nodes";
        lstEMRvalue.Attributeid = 41;
        lstEMRvalue.Attributevaluename = typeLymph[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typeLymph);

        ddlType_41.DataSource = typeLymph.ToList();
        ddlType_41.DataTextField = "AttributeValueName";
        ddlType_41.DataValueField = "AttributevalueID";
        ddlType_41.DataBind();
        ddlType_41.Items.Insert(0, "---Select---");


        List<EMRAttributeClass> typeLymphlist = (from s in listLN
                             where s.AttributeID == 42
                             select new EMRAttributeClass
                             {
                                 AttributeName = s.AttributeName,
                                 AttributevalueID = s.AttributevalueID,
                                 AttributeValueName = s.AttributeValueName
                             }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Lymph Nodes";
        lstEMRvalue.Attributeid = 42;
        lstEMRvalue.Attributevaluename = typeLymphlist[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typeLymphlist);
        ddlLocation_42.DataSource = typeLymphlist.ToList();
        ddlLocation_42.DataTextField = "AttributeValueName";
        ddlLocation_42.DataValueField = "AttributevalueID";
        ddlLocation_42.DataBind();
        ddlLocation_42.Items.Insert(0, "---Select---");


       

        #endregion

        

    }

    protected void ddlAbnormalities_40_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAbnormalities_40.SelectedItem.Text == "Others")
        {
            divddlAbnormalities_40.Style.Add("display", "block");
        }
        else
        {
            divddlAbnormalities_40.Style.Add("display", "none");
        }

    }
}
