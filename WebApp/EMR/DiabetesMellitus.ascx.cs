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

public partial class HealthPackageControls_DiabetesMellitus : BaseControl
{
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    private string id;
    private string attriName;
    private long vid;
   // public delegate void btnSample_Click(object sender, System.EventArgs e);
    //public event EventHandler btnSampleClick;
   
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
    public long visitid
    {
        get { return vid; }
        set { vid = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        //EMR4.DDL = ddlDuration_5;

        //EMR5.DDL = ddlType_6;

        //EMR6.DDL = ddlTreatment_7;
        if (rdoYes_389.Checked == true)
        {
            divrdoYes_389.Style.Add("display", "block");
        }
        //EMR_EditEMR objEMR = new EMR_EditEMR();
        //EMR4.btnSaveClk += new btnSave_Click(EMR_btnSaveClk);
        
    }
    void EMR_btnSaveClk(object sender, EventArgs e)
    {
        //EMR_EditEMR editemr = ((EMR_EditEMR)(sender));  
    }
    protected void btnSample_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/SampleBillPrint.aspx");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Close btn in Modal Popup", ex);
        }
    }
     
    public long GetData(out List<PatientComplaint> attribute, out List<PatientComplaintAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientComplaint>();
        attrValue = new List<PatientComplaintAttribute>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<PatientComplaintAttribute> lstPatientComplaintAttribute = new List<PatientComplaintAttribute>();
        #region DiabetesMellitus
        if (rdoYes_389.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(389);
            objPatientComplaint.ComplaintName = rdoYes_389.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);
            if (txtDuration_5.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(5);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlDuration_5.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = txtDuration_5.Text + " " + ddlDuration_5.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
            }
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(6);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlType_6.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlType_6.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute); 
            }
            if (ddlTreatment_7.SelectedItem.Text == "Others")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(7);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(68);
                objPatientComplaintAttribute.AttributeValueName = txtothers_68.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(389);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(7);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(ddlTreatment_7.SelectedValue);
                objPatientComplaintAttribute.AttributeValueName = ddlTreatment_7.SelectedItem.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
            }
            
        }
        #endregion
        return returnval;
    }
    public long GetHistoryData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        PatientHistory hisPKGAH40 = new PatientHistory();
        PatientHistoryAttribute hisPKGAttAH40 = new PatientHistoryAttribute();
        List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();
        //if (ddlFHODM_1083.SelectedIndex > 0)
        //{
            hisPKGAH40.HistoryID = 1069;
            hisPKGAH40.ComplaintId = 0;
            hisPKGAH40.PatientVisitID = vid;
            hisPKGAH40.Description = "F/H/O DM";
            hisPKGAH40.HistoryName = "F/H/O DM";
            lstPatientHisPKG.Add(hisPKGAH40);
            attribute.Add(hisPKGAH40);
            {
                hisPKGAttAH40.PatientVisitID = vid;
                hisPKGAttAH40.HistoryID = 1069;
                hisPKGAttAH40.AttributeID = 27;

                //if (ddlFHODM_1083.SelectedIndex > 0)
                //{
                //    hisPKGAttAH40.AttributevalueID = Convert.ToInt64(ddlFHODM_1083.SelectedItem.Value.ToString());
                //    if (ddlFHODM_1083.SelectedItem.Text == "Present" || ddlFHODM_1083.SelectedItem.Text == "Insignificant")
                //    {
                //        hisPKGAttAH40.AttributeValueName = ddlFHODM_1083.SelectedItem.Text + " - " + txtFHODM_1083.Text + ";";
                //    }

                //    else
                //    {
                //        hisPKGAttAH40.AttributeValueName = ddlFHODM_1083.SelectedItem.Text;
                //    }
                //}
                //else
                //{
                //    hisPKGAttAH40.AttributevalueID = 0;
                //    hisPKGAttAH40.AttributeValueName = "";
                //}

                lstPatientHisPKGAttributes.Add(hisPKGAttAH40);
            }

        //}
        PatientHistory hisPKGAH41 = new PatientHistory();
        PatientHistoryAttribute hisPKGAttAH41 = new PatientHistoryAttribute();
        //if (txtHOHypoglycemia_1084.Text.Trim() != "")
        //{
            hisPKGAH41.HistoryID = 1093;
            hisPKGAH41.ComplaintId = 0;
            hisPKGAH41.PatientVisitID = vid;
            hisPKGAH41.Description = "H/O Hypoglycemia";
            hisPKGAH41.HistoryName = "H/O Hypoglycemia";
            lstPatientHisPKG.Add(hisPKGAH41);
            {
                hisPKGAttAH41.PatientVisitID = vid;
                hisPKGAttAH41.HistoryID = 1093;
                hisPKGAttAH41.AttributeID = 0;

                //if (txtHOHypoglycemia_1084.Text.Trim() != "")
                //{
                //    hisPKGAttAH41.AttributeValueName = txtHOHypoglycemia_1084.Text;
                //}
                //else
                //{
                //    hisPKGAttAH41.AttributeValueName = "";
                //}

                lstPatientHisPKGAttributes.Add(hisPKGAttAH41);
            }
        //}
        return returnval;
    }
    //public void LoadDiabData()
    //{
    //    long visitID = -1;
    //    long patientID = -1;
    //    long taskID = -1;
    //    long returnCode = -1;

    //    if (Request.QueryString["pvid"] != null)
    //    {
    //        Int64.TryParse(Request.QueryString["pvid"], out visitID);
    //    }
    //    else
    //    {
    //        Int64.TryParse(Request.QueryString["vid"], out visitID);
    //    }
    //    Int64.TryParse(Request.QueryString["pid"], out patientID);
    //    Int64.TryParse(Request.QueryString["tid"], out taskID);

    //    long id1 = 332; long id2 = 402; long id3 = 409;

    //    try
    //    {
    //        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
    //        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
    //        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
    //        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    //        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
    //        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
    //        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
    //        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
    //        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
    //        ArrayList lstPatientASel = new ArrayList();
    //        ArrayList lstPatientSel = new ArrayList();

    //        returnCode = new SmartAccessor().GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

    //        if (lstANCPatientDetails.Count > 0)
    //        {
                
    //        }
    //        //SetData(lsthisPCA);
    //       // EditData(lstPCA);

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Page Load", ex);
    //    }
    //}
    public void LoadData(List<PatientHistoryAttribute> lsthisPHA)
    {
        try
        {
            var lstFHO = from s in lsthisPHA
                         where s.HistoryID == 1069
                         select s;

            List<EMRAttributeClass> lstFHOtype = (from d in lstFHO
                                                  where d.AttributeID == 27
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeName = d.AttributeName,
                                                      AttributevalueID = d.AttributevalueID,
                                                      AttributeValueName = d.AttributeValueName
                                                  }).ToList();

            lstEMRvalue.Name = "History";
            lstEMRvalue.Attributename = "F/H/O DM";
            lstEMRvalue.Attributeid = 27;
            lstEMRvalue.Attributevaluename = lstFHOtype[0].AttributeName;

            //ddlFHODM_1083.DataSource = lstFHO.ToList();
            //ddlFHODM_1083.DataTextField = "AttributeValueName";
            //ddlFHODM_1083.DataValueField = "AttributevalueID";
            //ddlFHODM_1083.DataBind();
            //ddlFHODM_1083.Items.Insert(0, "---Select---");
            //EMR36.Bind(lstEMRvalue, lstFHOtype);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadData", ex);
        }
    }
    public void SetData(List<PatientComplaintAttribute> lsthisPCA,long ID)
    {
        try
        {
            //lsthisPCA = new List<PatientComplaintAttribute>();

                trrdoYes_389.Attributes.Add("style", "display:block");
                trrdoYes_389.Attributes.Add("style", "display:block");
                rdoYes_389.Visible = true;
                var lstdiabetics = from s in lsthisPCA
                                   where s.ComplaintID == ID
                                   select s;
                for (int i = 0; i < lstdiabetics.Count(); i++)
                {
                List<EMRAttributeClass> diabeticsetreatment = (from d in lstdiabetics
                                                               where d.AttributeID == 7
                                                               select new EMRAttributeClass
                                                               {
                                                                   AttributeName = d.AttributeName,
                                                                   AttributevalueID = d.AttributevalueID,
                                                                   AttributeValueName = d.AttributeValueName
                                                               }).ToList();

                //lstEMRvalue.Name = "Complaint";
                //lstEMRvalue.Attributename = "Diabetics";
                //lstEMRvalue.Attributeid = 7;
                //lstEMRvalue.Attributevaluename = diabeticsetreatment[0].AttributeName;
                //EMR6.Bind(lstEMRvalue, diabeticsetreatment);


                ddlTreatment_7.DataSource = diabeticsetreatment.ToList();
                ddlTreatment_7.DataTextField = "AttributeValueName";
                ddlTreatment_7.DataValueField = "AttributevalueID";
                ddlTreatment_7.DataBind();
                List<EMRAttributeClass> diabeticsetype = (from d in lstdiabetics
                                                          where d.AttributeID == 6
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = d.AttributeName,
                                                              AttributevalueID = d.AttributevalueID,
                                                              AttributeValueName = d.AttributeValueName
                                                          }).ToList();


                //lstEMRvalue.Name = "Complaint";
                //lstEMRvalue.Attributename = "Diabetics";
                //lstEMRvalue.Attributeid = 6;
                //lstEMRvalue.Attributevaluename = diabeticsetype[0].AttributeName;
                //EMR5.Bind(lstEMRvalue, diabeticsetype);


                ddlType_6.DataSource = diabeticsetype.ToList();
                ddlType_6.DataTextField = "AttributeValueName";
                ddlType_6.DataValueField = "AttributevalueID";
                ddlType_6.DataBind();

                List<EMRAttributeClass> diabeticsduration = (from d in lstdiabetics
                                                             where d.AttributeID == 5
                                                             select new EMRAttributeClass
                                                             {
                                                                 AttributeName = d.AttributeName,
                                                                 AttributevalueID = d.AttributevalueID,
                                                                 AttributeValueName = d.AttributeValueName
                                                             }).ToList();

                //lstEMRvalue.Name = "Complaint";
                //lstEMRvalue.Attributename = "Diabetics";
                //lstEMRvalue.Attributeid = 5;
                //lstEMRvalue.Attributevaluename = diabeticsduration[0].AttributeName;
                //EMR4.Bind(lstEMRvalue, diabeticsduration);


                ddlDuration_5.DataSource = diabeticsduration.ToList();
                ddlDuration_5.DataTextField = "AttributeValueName";
                ddlDuration_5.DataValueField = "AttributevalueID";
                ddlDuration_5.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
        rdoNo_389.Checked = true;
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
                    divrdoYes_389.Style.Add("display", "block");
                    rdoYes_389.Checked = true;
                    if (lstEditData[j].AttributeID == 5)
                    {
                        txtDuration_5.Text = lstEditData[j].AttributeValueName.Split(' ')[0].ToString();
                        ddlDuration_5.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                    }
                    if (lstEditData[j].AttributeID == 6)
                    {
                        ddlType_6.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                    }
                    if (lstEditData[j].AttributeID == 7)
                    {
                        ddlTreatment_7.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                        if (lstEditData[j].AttributevalueID == 68)
                        {
                            divddlTreatment_7.Style.Add("display", "block");
                            txtothers_68.Text = lstEditData[j].AttributeValueName.ToString();
                        }
                    }
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
