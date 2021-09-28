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

public partial class CommonControls_Cancer : BaseControl
{
    private string id;
    private string attriName;
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    EMR lstEMRvalue;
    public string AttriName
    { 
        get { return attriName; }
        set
        {
            attriName = value;
        }
    }
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
        }
    }
    long visitID = -1;
    long returnCode = -1;
    List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
    List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
    List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
    List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
    List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
    List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
    List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();

    protected void Page_Load(object sender, EventArgs e)
    {
            
    }
    public void SetData(List<PatientComplaintAttribute> lsthisPCA, long CompID)
    {
            var lstcancer = from s in lsthisPCA
                            where s.ComplaintID == CompID
                            select s;
            lstEMRvalue = new EMR(base.ContextInfo);
            if (lstcancer.Count() > 0)
            {
                List<EMRAttributeClass> cancertype = (from d in lstcancer
                                                      where d.AttributeID == 13
                                                      select new EMRAttributeClass
                                                      {
                                                          AttributeName = d.AttributeName,
                                                          AttributevalueID = d.AttributevalueID,
                                                          AttributeValueName = d.AttributeValueName
                                                      }).ToList();


                lstEMRvalue.Name = "Complaint";
                lstEMRvalue.Attributename = "Cancer";
                lstEMRvalue.Attributeid = 13;
                lstEMRvalue.Attributevaluename = cancertype[0].AttributeName;
                //EMR9.Bind(lstEMRvalue, cancertype);


                ddlTypeofcancer_13.DataSource = cancertype.ToList();
                ddlTypeofcancer_13.DataTextField = "AttributeValueName";
                ddlTypeofcancer_13.DataValueField = "AttributevalueID";
                ddlTypeofcancer_13.DataBind();


                List<EMRAttributeClass> cancerstage = (from d in lstcancer
                                                       where d.AttributeID == 14
                                                       select new EMRAttributeClass
                                                       {
                                                           AttributeName = d.AttributeName,
                                                           AttributevalueID = d.AttributevalueID,
                                                           AttributeValueName = d.AttributeValueName
                                                       }).ToList();

                lstEMRvalue.Name = "Complaint";
                lstEMRvalue.Attributename = "Cancer";
                lstEMRvalue.Attributeid = 14;
                lstEMRvalue.Attributevaluename = cancerstage[0].AttributeName;
                //EMR11.Bind(lstEMRvalue, cancerstage);


                ddlStageofcancer_14.DataSource = cancerstage.ToList();
                ddlStageofcancer_14.DataTextField = "AttributeValueName";
                ddlStageofcancer_14.DataValueField = "AttributevalueID";
                ddlStageofcancer_14.DataBind();

                List<EMRAttributeClass> cancertreatment = (from d in lstcancer
                                                           where d.AttributeID == 15
                                                           select new EMRAttributeClass
                                                           {
                                                               AttributeName = d.AttributeName,
                                                               AttributevalueID = d.AttributevalueID,
                                                               AttributeValueName = d.AttributeValueName
                                                           }).ToList();

                lstEMRvalue.Name = "Complaint";
                lstEMRvalue.Attributename = "Cancer";
                lstEMRvalue.Attributeid = 15;
                lstEMRvalue.Attributevaluename = cancertreatment[0].AttributeName;
                //EMR10.Bind(lstEMRvalue, cancertreatment);

                ddlTreatment_15.DataSource = cancertreatment.ToList();
                ddlTreatment_15.DataTextField = "AttributeValueName";
                ddlTreatment_15.DataValueField = "AttributevalueID";
                ddlTreatment_15.DataBind();
            }
            rdoNo_372.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long CompID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == CompID
                                                       select s).ToList();
        if (lstEditData.Count() > 0)
        {
            for (int i = 0; i < lstEditData.Count(); i++)
            {
                rdoYes_372.Checked = true;
                rdoNo_372.Checked = false;
                divrdoYes_372.Style.Add("display", "block");
                if (lstEditData[i].AttributeID == 13)
                {
                    ddlTypeofcancer_13.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                    if (ddlTypeofcancer_13.SelectedItem.Text == "Others")
                    {
                        divddlTypeofcancer_13.Style.Add("display", "block");
                        txtothers_72.Text = lstEditData[i].AttributeValueName.ToString();
                    }
                }
                else if (lstEditData[i].AttributeID == 14)
                {
                    ddlStageofcancer_14.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                }
                else if (lstEditData[i].AttributeID == 15)
                {
                    ddlTreatment_15.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                    if (ddlTreatment_15.SelectedItem.Text == "Others")
                    {
                        divddlTreatment_15.Style.Add("display", "block");
                        txtothers_73.Text = lstEditData[i].AttributeValueName.ToString();
                    }
                }
            }
        }
    }
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        if (rdoYes_372.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = 372;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
            objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(372);
            objPatientComplaintAttribute.AttributeID = Convert.ToInt64(13);
            objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTypeofcancer_13.SelectedValue);
            if (ddlTypeofcancer_13.SelectedItem.Text == "Others")
            {
                objPatientComplaintAttribute.AttributeValueName = txtothers_72.Text;
            }
            else
            {
                objPatientComplaintAttribute.AttributeValueName = ddlTypeofcancer_13.SelectedItem.Text;
            }
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
            attrValue.Add(objPatientComplaintAttribute);

            PatientComplaintAttribute objPatientComplaintAttribute1 = new PatientComplaintAttribute();
            objPatientComplaintAttribute1.ComplaintID = Convert.ToInt32(372);
            objPatientComplaintAttribute1.AttributeID = Convert.ToInt64(14);
            objPatientComplaintAttribute1.AttributevalueID = Convert.ToInt32(ddlStageofcancer_14.SelectedValue);
            objPatientComplaintAttribute1.AttributeValueName = ddlStageofcancer_14.SelectedItem.Text;
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute1);
            attrValue.Add(objPatientComplaintAttribute1);

            PatientComplaintAttribute objPatientComplaintAttribute2 = new PatientComplaintAttribute();
            objPatientComplaintAttribute2.ComplaintID = Convert.ToInt32(372);
            objPatientComplaintAttribute2.AttributeID = Convert.ToInt64(15);
            objPatientComplaintAttribute2.AttributevalueID = Convert.ToInt32(ddlTreatment_15.SelectedValue);
            if (ddlTreatment_15.SelectedItem.Text == "Others")
            {
                objPatientComplaintAttribute2.AttributeValueName = txtothers_73.Text;
            }
            else
            {
                objPatientComplaintAttribute2.AttributeValueName = ddlTreatment_15.SelectedItem.Text;
            }
            lstPatientComplaintAttribute.Add(objPatientComplaintAttribute2);
            attrValue.Add(objPatientComplaintAttribute2);
        }
        return returnval;
    }
}
