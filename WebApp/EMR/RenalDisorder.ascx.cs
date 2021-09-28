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

public partial class HealthPackageControls_RenalDisorder : BaseControl
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

        #region Renal
        if (rdoYes_32.Checked == true)
        {
            PatientComplaint objPatientComplaint = new PatientComplaint();
            objPatientComplaint.ComplaintID = Convert.ToInt32(32);
            objPatientComplaint.ComplaintName = rdoYes_32.Text;
            lstPatientComplaint.Add(objPatientComplaint);
            attribute.Add(objPatientComplaint);

            if (txtRenal_32.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(32);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtRenal_32.Text;
                lstPatientComplaintAttribute.Add(objPatientComplaintAttribute);
                attrValue.Add(objPatientComplaintAttribute);
            }
            else
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(32);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = "";
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

    public void SetData(List<PatientComplaintAttribute> lstPCA,long ID)
    {
        List<PatientComplaintAttribute> lstRenal = (from s in lstPCA
                           where s.ComplaintID == ID
                           select s).ToList();
        //for (int i = 0; i < lstRenal.Count(); i++)
        //{
        //    if (lstRenal[i].ComplaintID == ID)
        //    {
        //        if (lstRenal[i].AttributeValueName != "")
        //        {
        //            divrdoYes_32.Style.Add("display", "block");
        //            rdoYes_32.Checked = true;
        //            txtRenal_32.Text = lstPCA[i].AttributeValueName.ToString();
        //        }
        //        else
        //        {
        //            txtRenal_32.Text = "";
        //        }
        //    }
        //}
        rdoNo_32.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA,long ID)
    {
        try
        {
            List<PatientComplaintAttribute> lstEditData = (from s in lstPCA
                                                           where s.ComplaintID == ID
                                                           select s).ToList();
            for (int j = 0; j < lstEditData.Count(); j++)
            {
                if (lstEditData[j].ComplaintID == ID)
                {
                    if (lstEditData[j].AttributeValueName != "")
                    {
                        divrdoYes_32.Style.Add("display", "block");
                        rdoYes_32.Checked = true;
                        rdoNo_32.Checked = false;
                        txtRenal_32.Text = lstEditData[j].AttributeValueName.ToString();
                    }
                    else
                    {
                        txtRenal_32.Text = "";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in EditData", ex);
        }
    }
}
