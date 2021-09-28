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
public partial class HealthPackageControls_Ear : BaseControl
{
    EMR lstEMRvalue = new EMR();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        EMR1.DDL = ddlRightEar_35;
        EMR2.DDL = ddlLeftEar_36;
        EMR3.DDL = ddlRightEar_37;
        EMR4.DDL = ddlLeftEar_38;  
        if (IsPostBack)
        {
           
            if (chkAuditoryCanal_872.Checked == true)
            {
                tr1chkAuditoryCanal_872.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkAuditoryCanal_872.Attributes.Add("Style", "Display:none");
            }
            if (chkEarDrum_873.Checked == true)
            {
                tr1chkEarDrum_873.Attributes.Add("Style", "Display:Block");
            }
            else
            {
                tr1chkEarDrum_873.Attributes.Add("Style", "Display:none");
            }
        }
    }
   
    public override long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        int returnval = -1;
        attribute = new ArrayList();
        attrValue = new ArrayList();

        #region Auditory Canal
        if (chkAuditoryCanal_872.Checked == true && ddlRightEar_35.SelectedItem.Text != "---Select---" || ddlLeftEar_36.SelectedItem.Text != "---Select---")
        {
            if (chkAuditoryCanal_872.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 872;
                objPatientExamination.ExaminationName = chkAuditoryCanal_872.Text;
                attribute.Add(objPatientExamination);

                #region lblRightEar_35
                if (ddlRightEar_35.SelectedItem.Text != "---Select---")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 872;
                    objPatientExaminationAttribute.AttributeID = 35;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlRightEar_35.SelectedValue);
                    if (ddlRightEar_35.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlRightEar_35.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtRightEarOthers_110.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion

                #region lblLeftEar_36
                if (ddlLeftEar_36.SelectedItem.Text != "---Select---")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 872;
                    objPatientExaminationAttribute.AttributeID = 36;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLeftEar_36.SelectedValue);
                    if (ddlLeftEar_36.SelectedItem.Text != "Others")
                    {
                        objPatientExaminationAttribute.AttributeValueName = ddlLeftEar_36.SelectedItem.Text;
                    }
                    else
                    {
                        objPatientExaminationAttribute.AttributeValueName = txtLeftEarOthers_114.Text;
                    }
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }

        }
        #endregion

        #region Ear Drum
        if (chkEarDrum_873.Checked == true && ddlRightEar_37.SelectedItem.Text != "---Select---" || ddlLeftEar_38.SelectedItem.Text != "---Select---")
        {

            if (chkEarDrum_873.Checked == true)
            {
                PatientExamination objPatientExamination = new PatientExamination();
                objPatientExamination.ExaminationID = 873;
                objPatientExamination.ExaminationName = chkEarDrum_873.Text;
                attribute.Add(objPatientExamination);

                #region lblRightEar_37
                if (ddlRightEar_37.SelectedItem.Text != "---Select---")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 873;
                    objPatientExaminationAttribute.AttributeID = 37;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlRightEar_37.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlRightEar_37.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion

                #region lblLeftEar_38
                if (ddlLeftEar_38.SelectedItem.Text != "---Select---")
                {
                    PatientExaminationAttribute objPatientExaminationAttribute = new PatientExaminationAttribute();
                    objPatientExaminationAttribute.ExaminationID = 873;
                    objPatientExaminationAttribute.AttributeID = 38;
                    objPatientExaminationAttribute.AttributevalueID = Convert.ToInt64(ddlLeftEar_38.SelectedValue);
                    objPatientExaminationAttribute.AttributeValueName = ddlLeftEar_38.SelectedItem.Text;
                    attrValue.Add(objPatientExaminationAttribute);
                }
                #endregion
            }

        }
        #endregion
        return returnval;
    }

    public void EditData(List<PatientExaminationAttribute> lstPEA)
    {
        # region Auditory Canal

        var listGA = from Res in lstPEA
                     where Res.ExaminationID == 872
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listGA)
        {

            if (objPEA.ExaminationID == 872 && objPEA.AttributeID==35)
            {
                chkAuditoryCanal_872.Checked = true;
                tr1chkAuditoryCanal_872.Style.Add("display", "block");
                ddlRightEar_35.SelectedValue = objPEA.AttributevalueID.ToString();

                if (ddlRightEar_35.SelectedItem.Text == "Others")
                {
                    divddlRightEar_35.Style.Add("display", "block");
                    txtRightEarOthers_110.Text = objPEA.AttributeValueName;
                }

            }

            if (objPEA.ExaminationID == 872 && objPEA.AttributeID == 36)
            {
                chkAuditoryCanal_872.Checked = true;
                tr1chkAuditoryCanal_872.Style.Add("display", "block");
                ddlLeftEar_36.SelectedValue = objPEA.AttributevalueID.ToString();

                if (ddlLeftEar_36.SelectedItem.Text == "Others")
                {
                    divddlLeftEar_36.Style.Add("display", "block");
                    txtLeftEarOthers_114.Text = objPEA.AttributeValueName;
                }

            }
        }
        #endregion


        # region Ear Drum

        var listED = from Res in lstPEA
                     where Res.ExaminationID == 873
                     select Res;

        foreach (PatientExaminationAttribute objPEA in listED)
        {

            if (objPEA.ExaminationID == 873 && objPEA.AttributeID == 37)
            {
                chkEarDrum_873.Checked = true;
                tr1chkEarDrum_873.Style.Add("display", "block");
                ddlRightEar_37.SelectedValue = objPEA.AttributevalueID.ToString();              

            }

            if (objPEA.ExaminationID == 873 && objPEA.AttributeID == 38)
            {
                chkEarDrum_873.Checked = true;
                tr1chkEarDrum_873.Style.Add("display", "block");
                ddlLeftEar_38.SelectedValue = objPEA.AttributevalueID.ToString();             

            }
        }
        #endregion

    }

    public void SetData(List<PatientExaminationAttribute> lstPEA)
    {
        # region Auditory Canal

        var listGA = from Res in lstPEA
                     where Res.ExaminationID == 872
                     select Res;

        List<EMRAttributeClass> typelist = (from s in listGA
                       where s.AttributeID == 35
                       select new EMRAttributeClass 
                       {
                           AttributeName=s.AttributeName,
                           AttributevalueID=s.AttributevalueID,
                          AttributeValueName= s.AttributeValueName

                       }).ToList();

        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Auditory Canal";
        lstEMRvalue.Attributeid = 35;
        lstEMRvalue.Attributevaluename = typelist[0].AttributeName;

        EMR1.Bind(lstEMRvalue, typelist);
        ddlRightEar_35.DataSource = typelist.ToList();
        ddlRightEar_35.DataTextField = "AttributeValueName";
        ddlRightEar_35.DataValueField = "AttributevalueID";
        ddlRightEar_35.DataBind();
        ddlRightEar_35.Items.Insert(0, "---Select---");

         List<EMRAttributeClass> typeleftlist = (from s in listGA
                       where s.AttributeID == 36
                       select new EMRAttributeClass 
                       {
                           AttributeName = s.AttributeName,
                           AttributevalueID = s.AttributevalueID,
                           AttributeValueName = s.AttributeValueName

                       }).ToList();
         lstEMRvalue.Name = "Examination";
         lstEMRvalue.Attributename = "Auditory Canal";
         lstEMRvalue.Attributeid = 36;
         lstEMRvalue.Attributevaluename = typeleftlist[0].AttributeName;

         EMR2.Bind(lstEMRvalue, typeleftlist);
        ddlLeftEar_36.DataSource = typeleftlist.ToList();
        ddlLeftEar_36.DataTextField = "AttributeValueName";
        ddlLeftEar_36.DataValueField = "AttributevalueID";
        ddlLeftEar_36.DataBind();
        ddlLeftEar_36.Items.Insert(0, "---Select---");


        
        
        #endregion


        # region Ear Drum

        var listED = from Res in lstPEA
                     where Res.ExaminationID == 873
                     select Res;

        List<EMRAttributeClass> typerightlist = (from s in listED
                       where s.AttributeID == 37
                                                select new EMRAttributeClass
                       {
                           AttributeName=s.AttributeName,
                           AttributevalueID=s.AttributevalueID,
                          AttributeValueName= s.AttributeValueName

                       }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Ear Drum";
        lstEMRvalue.Attributeid = 37;
        lstEMRvalue.Attributevaluename = typerightlist[0].AttributeName;

        EMR3.Bind(lstEMRvalue, typerightlist);
        //EMR3.dr
        ddlRightEar_37.DataSource = typerightlist.ToList();
        ddlRightEar_37.DataTextField = "AttributeValueName";
        ddlRightEar_37.DataValueField = "AttributevalueID";
        ddlRightEar_37.DataBind();
        ddlRightEar_37.Items.Insert(0, "---Select---");

        List<EMRAttributeClass> typelistleft = (from s in listED
                           where s.AttributeID == 38
                           select new EMRAttributeClass 
                           {
                              AttributeName= s.AttributeName,
                              AttributevalueID= s.AttributevalueID,
                              AttributeValueName= s.AttributeValueName

                           }).ToList();
        lstEMRvalue.Name = "Examination";
        lstEMRvalue.Attributename = "Ear Drum";
        lstEMRvalue.Attributeid = 38;
        lstEMRvalue.Attributevaluename = typelistleft[0].AttributeName;

        EMR4.Bind(lstEMRvalue, typelistleft);
        ddlLeftEar_38.DataSource = typelistleft.ToList();
        ddlLeftEar_38.DataTextField = "AttributeValueName";
        ddlLeftEar_38.DataValueField = "AttributevalueID";
        ddlLeftEar_38.DataBind();
        ddlLeftEar_38.Items.Insert(0, "---Select---");
       
        #endregion

    }
}
