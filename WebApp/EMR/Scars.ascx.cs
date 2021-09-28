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

public partial class HealthPackageControls_Scars : BaseControl
{
    long returnCode = -1;
    EMR lstEMRvalue = new EMR();
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR2.DDL = ddlScarType_6;
        EMR3.DDL = ddlScaretiology_7;
        if (IsPostBack)
        {
            if (chkScar_917.Checked == true)
            {
                tr1chkScar_917.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkScar_917.Attributes.Add("Style", "Display:None");
            }
        }
    }    
    #region Bind Dropdown
    public void BindScarAbnormal()
    {
        List<ExaminationAttributeValues> lstExaminationAttributeValues = new List<ExaminationAttributeValues>();
        returnCode = new SmartAccessor().GetExamAttributeValues(6, out lstExaminationAttributeValues);
        trScarType_6.Style.Add("display", "block");
        ddlScaretiology_7.DataSource = lstExaminationAttributeValues;
        ddlScaretiology_7.DataTextField = "AttributeValueName";
        ddlScaretiology_7.DataValueField = "AttributevalueID";
        ddlScaretiology_7.DataBind();
        ddlScaretiology_7.Focus();
    }
    #endregion
    protected void ddlScarType_6_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        if ((ddlScarType_6.SelectedItem.Text != "No obvious Scars") && (ddlScarType_6.SelectedValue != "0"))
        {
            BindScarAbnormal();
            
        }
        else
        {
            trScarType_6.Style.Add("display", "none");
        }
        ddlScarType_6.Focus();
    }

    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Hair
        if (chkScar_917.Checked == true && ddlScarType_6.SelectedItem.Text!="---Select---")
        {
            PatientExamination objPatientExamination = new PatientExamination();
            objPatientExamination.ExaminationID = 917;
            objPatientExamination.ExaminationName = chkScar_917.Text;
            attribute.Add(objPatientExamination);

            #region lblScarType_6
            if (ddlScarType_6.SelectedItem.Text != "---Select---")
            {
                PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                objPatientExaminationAttribute.ExaminationID = 917;
                objPatientExaminationAttribute.AttributeID = 6;
                objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlScarType_6.SelectedValue);
                objPatientExaminationAttribute.AttributeValueName = ddlScarType_6.SelectedItem.Text;
                attrValue.Add(objPatientExaminationAttribute);
            }
            #endregion

            #region lblScaretiology_7
            {
                if ((ddlScarType_6.SelectedItem.Text != "No obvious Scars") && (ddlScarType_6.SelectedValue != "0"))
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 917;
                    objPatientExaminationAttribute.AttributeID = 7;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlScaretiology_7.SelectedValue);

                    if (ddlScaretiology_7.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlScaretiology_7.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtScaretiologyOthers_7.Text;
                    }

                    attrValue.Add(objPatientExaminationAttribute);
                }
                if ((ddlScarType_6.SelectedItem.Text != "No obvious Scars") && (ddlScarType_6.SelectedValue != "0") && txtScarLocation_38.Text.Trim()!="")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 917;
                    objPatientExaminationAttribute.AttributeID = 8;
                    objPatientExaminationAttribute.AttributevalueID = 38;
                    objPatientExaminationAttribute.AttributeValueName = txtScarLocation_38.Text;
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
        #region Scar

        var listS = from Res in lstPEA
                    where Res.ExaminationID == 917
                    select Res;

        foreach (PatientExaminationAttribute objPEA in listS)
        {

            if (objPEA.ExaminationID == 917)
            {
                chkScar_917.Checked = true;
                tr1chkScar_917.Style.Add("display", "block");
                ddlScarType_6.SelectedValue = objPEA.AttributevalueID.ToString();

                if (objPEA.AttributeID == 7)
                {
                    BindScarAbnormal();
                    ddlScaretiology_7.SelectedValue = objPEA.AttributevalueID.ToString();
                    if (ddlScaretiology_7.SelectedItem.Text == "Others")
                    {
                        divddlScaretiology_7.Style.Add("display", "block");
                        txtScaretiologyOthers_7.Text = objPEA.AttributeValueName;
                    }

                }

                if (objPEA.AttributeID == 8)
                {
                    txtScarLocation_38.Text = objPEA.AttributeValueName;

                }

            }
        }

        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        #region Scar

        var listS = from Res in lstPEA
                    where Res.ExaminationID == 917
                    select Res;

        List<EMRAttributeClass> typelist = (from s in listS
                       where s.AttributeID == 6
                       select new EMRAttributeClass
                       {
                          AttributeName= s.AttributeName,
                          AttributevalueID=s.AttributevalueID,
                          AttributeValueName= s.AttributeValueName
                       }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Scar";
        lstEMRvalue.Attributeid = 6;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;
        EMR2.Bind(lstEMRvalue, typelist);

        ddlScarType_6.DataSource = typelist.ToList();
        ddlScarType_6.DataTextField = "AttributeValueName";
        ddlScarType_6.DataValueField = "AttributevalueID";
        ddlScarType_6.DataBind();
        ddlScarType_6.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> Lessionslist = (from s in listS
                       where s.AttributeID == 7
                       select new EMRAttributeClass
                       {
                          AttributeName= s.AttributeName, 
                          AttributevalueID= s.AttributevalueID,
                          AttributeValueName= s.AttributeValueName
                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Scar";
        lstEMRvalue.Attributeid = 7;
        //lstEMRvalue.Attributevaluename = Lessionslist[0].AttributeName;
        //EMR3.Bind(lstEMRvalue, Lessionslist);
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;
        EMR3.Bind(lstEMRvalue, typelist);

        ddlScaretiology_7.DataSource = typelist.ToList();
        ddlScaretiology_7.DataTextField = "AttributeValueName";
        ddlScaretiology_7.DataValueField = "AttributevalueID";
        ddlScaretiology_7.DataBind();
        ddlScaretiology_7.Items.Insert(0, "---Select---");        

        #endregion

    }
}
