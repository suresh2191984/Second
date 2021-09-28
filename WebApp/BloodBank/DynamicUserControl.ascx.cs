using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;

public partial class BloodBank_DynamicUserControl : BaseControl
{
    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    //EMR lstEMRvalue = new EMR();
    private string id;
    private string attriName;

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

            if (txtBox_32.Text != "")
            {
                PatientComplaintAttribute objPatientComplaintAttribute = new PatientComplaintAttribute();
                objPatientComplaintAttribute.ComplaintID = Convert.ToInt32(32);
                objPatientComplaintAttribute.AttributeID = Convert.ToInt64(0);
                objPatientComplaintAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientComplaintAttribute.AttributeValueName = txtBox_32.Text;
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
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();

        #region Renal
        if (rdoYes_32.Checked == true)
        {
            PatientHistory objPatientHistory = new PatientHistory();
            objPatientHistory.HistoryID = Convert.ToInt32(32);
            objPatientHistory.HistoryName = rdoYes_32.Text;
            lstPatientHistory.Add(objPatientHistory);
            attribute.Add(objPatientHistory);

            if (txtBox_32.Text != "")
            {
                PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(32);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(0);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientHistoryAttribute.AttributeValueName = txtBox_32.Text;
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);
            }
            else
            {
                PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(32);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(0);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientHistoryAttribute.AttributeValueName = "";
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);
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

    public void SetData(List<PatientComplaintAttribute> lstPCA, long ID)
    {
        List<PatientComplaintAttribute> lstRenal = (from s in lstPCA
                                                    where s.ComplaintID == ID
                                                    select s).ToList();
        lblHeading.Text = lstRenal[0].ControlName.Split('^')[1];
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
        rdoNo_32.ID="rdoNo_"+Convert.ToString(lstRenal[0].ComplaintID);
        rdoYes_32.ID = "rdoYes_" + Convert.ToString(lstRenal[0].ComplaintID);
        rdoUnknown_32.ID = "rdoUnknown_" + Convert.ToString(lstRenal[0].ComplaintID);
        divrdoYes_32.ID = "divrdoYes_" + Convert.ToString(lstRenal[0].ComplaintID);
        rdoYes_32.GroupName = "radioExtend" + Convert.ToString(lstRenal[0].ComplaintID);
        rdoNo_32.GroupName = "radioExtend" + Convert.ToString(lstRenal[0].ComplaintID); 
        rdoUnknown_32.GroupName = "radioExtend" + Convert.ToString(lstRenal[0].ComplaintID);
        rdoNo_32.Checked = true;
    }
    public void SetData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstHis = (from s in lstPHA
                                                    where s.HistoryID == ID
                                                    select s).ToList();
        lblHeading.Text = lstHis[0].ControlName.Split('^')[1];
        rdoNo_32.ID = "rdoNo_" + Convert.ToString(lstHis[0].HistoryID);
        rdoYes_32.ID = "rdoYes_" + Convert.ToString(lstHis[0].HistoryID);
        rdoUnknown_32.ID = "rdoUnknown_" + Convert.ToString(lstHis[0].HistoryID);
        divrdoYes_32.ID = "divrdoYes_" + Convert.ToString(lstHis[0].HistoryID);
        rdoYes_32.GroupName = "radioExtend" + Convert.ToString(lstHis[0].HistoryID);
        rdoNo_32.GroupName = "radioExtend" + Convert.ToString(lstHis[0].HistoryID);
        rdoUnknown_32.GroupName = "radioExtend" + Convert.ToString(lstHis[0].HistoryID);
        rdoNo_32.Checked = true;
    }

    public void EditData(List<PatientComplaintAttribute> lstPCA, long ID)
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
                        txtBox_32.Text = lstEditData[j].AttributeValueName.ToString();
                    }
                    else
                    {
                        txtBox_32.Text = "";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in EditData", ex);
        }
    }
    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        try
        {
            List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                           where s.HistoryID == ID
                                                           select s).ToList();
            for (int j = 0; j < lstEditData.Count(); j++)
            {
                if (lstEditData[j].HistoryID == ID)
                {
                    if (lstEditData[j].AttributeValueName != "")
                    {
                        divrdoYes_32.Style.Add("display", "block");
                        rdoYes_32.Checked = true;
                        rdoNo_32.Checked = false;
                        txtBox_32.Text = lstEditData[j].AttributeValueName.ToString();
                    }
                    else
                    {
                        txtBox_32.Text = "";
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
