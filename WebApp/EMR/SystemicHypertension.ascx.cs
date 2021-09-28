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

public partial class HealthPackageControls_SystemicHypertension : BaseControl
{
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();

    private string id;
    private string attriName;

    public string AttriName
    {
        get { return attriName; }
        set {
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

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();

        #region SystemicHypertension
        if (rdoYes_402.Checked == true)//High Blood Pressure
        {
            string Duration_1 = string.Empty;
            string chkTreatment = string.Empty;
            string chkOthers = string.Empty;
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(402);
            objPatientComplaint.ComplaintName = rdoYes_402.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            if (txtDuration_1.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(1);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDurationt_1.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_1.Text + " " + ddlDurationt_1.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
                Duration_1 = "Y";
            }


            foreach (ListItem li in chkTreatment_2.Items)//Treatment
            {
                if (li.Selected)
                {
                    PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                    objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                    objPatientComplaintAttribute.AttributeID = Convert.ToInt64(2);
                    objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(li.Value);
                    objPatientComplaintAttribute.AttributeValueName = li.Text;
                    lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                    attrValue.Add(objPatientComplaintAttribute);
                    chkTreatment = "Y";
                }
            }

            if (chkOthers_9.Checked == true)//OtherStext
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(2);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(9);
                objPatientComplaintAttribute.AttributeValueName = txtOthers_9.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
                chkOthers = "Y";
            }

            if (chkOthers == "" && chkTreatment == "" && Duration_1 == "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(402);
                objPatientComplaintAttribute.AttributeID = 402;
                objPatientComplaintAttribute.AttributevalueID = 402;
                objPatientComplaintAttribute.AttributeValueName = rdoYes_402.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);

            }

        }
        #endregion
        return returnval;
    }
    public void LoadDiabData()
    {
        long visitID = -1;
        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;

        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        long id1 = 332; long id2 = 402; long id3 = 409;

        try
        {
            List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
            List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
            List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
            List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
            List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
            List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
            List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
            List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
            List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
            ArrayList lstPatientASel = new ArrayList();
            ArrayList lstPatientSel = new ArrayList();

            //returnCode = new SmartAccessor().GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

            if (lstANCPatientDetails.Count > 0)
            {
                
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }

    public void SetData(List<PatientComplaintAttribute> lsthisPCA,long ID)
    {
        var lsthypertension = from s in lsthisPCA
                              where s.ComplaintID == ID
                              select s;

        List<EMRAttributeClass> hypertension = (from d in lsthypertension
                                                where d.AttributeID == 2 && d.AttributevalueID != 9
                                                select new EMRAttributeClass
                                                {
                                                    AttributeName = d.AttributeName,
                                                    AttributevalueID = d.AttributevalueID,
                                                    AttributeValueName = d.AttributeValueName
                                                }).ToList();

        //lstEMRvalue.Name = "Complaint";
        //lstEMRvalue.Attributename = "Hypertension";
        //lstEMRvalue.Attributeid = 2;
        //lstEMRvalue.Attributevaluename = hypertension[0].AttributeName;
        //EMR1.Bind(lstEMRvalue, hypertension);


        chkTreatment_2.DataSource = hypertension.ToList();
        chkTreatment_2.DataTextField = "AttributeValueName";
        chkTreatment_2.DataValueField = "AttributevalueID";
        chkTreatment_2.DataBind();

        List<EMRAttributeClass> hypertensionduration = (from d in lsthypertension
                                                        where d.AttributeID == 1
                                                        select new EMRAttributeClass
                                                        {
                                                            AttributeName = d.AttributeName,
                                                            AttributevalueID = d.AttributevalueID,
                                                            AttributeValueName = d.AttributeValueName
                                                        }).ToList();

        //lstEMRvalue.Name = "Complaint";
        //lstEMRvalue.Attributename = "Hypertension";
        //lstEMRvalue.Attributeid = 1;
        //lstEMRvalue.Attributevaluename = hypertensionduration[0].AttributeName;
        //EMR2.Bind(lstEMRvalue, hypertensionduration);

        ddlDurationt_1.DataSource = hypertensionduration.ToList();
        ddlDurationt_1.DataTextField = "AttributeValueName";
        ddlDurationt_1.DataValueField = "AttributevalueID";
        ddlDurationt_1.DataBind();
        
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA,long ID)
    {
        List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                       where s.ComplaintID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].ComplaintID == ID)
            {
                divrdoYes_402.Style.Add("display", "block");
                rdoYes_402.Checked = true;

                if (lstEditData[j].AttributeID == 1)
                {
                    txtDuration_1.Text = lstEditData[j].AttributeValueName.Split(' ')[0].ToString();
                    ddlDurationt_1.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                }
                if (lstEditData[j].AttributeID == 2)
                {
                    var lstCN = from Res in lstEditData
                                where Res.AttributeID == 2
                                select Res;

                    foreach (ListItem liComp in chkTreatment_2.Items)
                    {
                        foreach (PatientComplaintAttribute objlstCN in lstCN)
                        {
                            if (liComp.Value == objlstCN.AttributevalueID.ToString())
                            {
                                liComp.Selected = true;
                            }
                        }
                    }
                }

                if (lstEditData[j].AttributevalueID == 9)
                {
                    divchkOthers_9.Style.Add("display", "block");
                    chkOthers_9.Checked = true;
                    txtOthers_9.Text = lstEditData[j].AttributeValueName;
                }

            }
        }
    }
}
