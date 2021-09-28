using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;

public partial class CommonControls_MinorSurgery : BaseControl 
{
    public string ComplaintHeader { get; set; }
    public string DefaultComplaintID { get; set; }
    public int ComplaintID { get; set; }
    public string ComplaintName { get; set; }
    public string AddBtnVisible { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        //lblComplaint.Text = ComplaintHeader;

    }



    public void SetData(List<SurgicalDetail> lsthisPCA, long ID)
    {
        var lstSurgery = from s in lsthisPCA
                                   where s.SurgeryID == ID
                                   select s;
        if (lstSurgery.Count() > 0)
        {

        }
        rdoNo_974.Checked = true;
    }

    public void EditData(List<SurgicalDetail> lstSurgicalDetails)
    {
        if (lstSurgicalDetails.Count > 0)
        {
            int i = 110;
            foreach (SurgicalDetail objS in lstSurgicalDetails)
            {
                if (objS.ParentName == "Minor")
                {
                    hdnSurgeryItems.Value += i + "~" + objS.SurgeryName + "~" + objS.TreatmentPlanDate + "~" + objS.HospitalName + "^";
                    rdoYes_974.Checked = true;
                    divrdoYes_974.Style.Add("display", "block");
                }
                i += 1;
            }
            string type = "minor";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "STable", "javascript:LoadSurgeryItems('"+type+"');", true);
        }

    }
    public long GetData(out List<SurgicalDetail> attribute)
    {
        int returnval = -1;

        attribute = new List<SurgicalDetail>();
        //attrvalue = new List<PatientComplaintAttribute>();
        //List<PatientComplaint> Istpatientcomplaint = new List<PatientComplaint>();
        //List<PatientComplaintAttribute> Istpatientcomplaintattribute = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetail = new List<SurgicalDetail>();
        if (rdoYes_974.Checked == true)
        {
            attribute = GetPatientSurgeryDetail();
            //PatientComplaint objpatientcomplaint = new PatientComplaint();
            //objpatientcomplaint.ComplaintID = Convert.ToInt32(974);
            //objpatientcomplaint.ComplaintName = rdoYes_974.Text;
            //Istpatientcomplaint.Add(objpatientcomplaint);
            //attribute.Add(objpatientcomplaint);
            //PatientComplaintAttribute objpatientcomplaintattribute = new PatientComplaintAttribute();
            //if (txtAcupuncture.Text != "")
            //{
            //    objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(963);
            //    objpatientcomplaintattribute.AttributeID = Convert.ToInt32(0);
            //    objpatientcomplaintattribute.AttributevalueID = Convert.ToInt32(0);
            //    objpatientcomplaintattribute.AttributeValueName = txtAcupuncture.Text;
            //    Istpatientcomplaintattribute.Add(objpatientcomplaintattribute);
            //    attrvalue.Add(objpatientcomplaintattribute);
            //}
            //else
            //{
            //    objpatientcomplaintattribute.ComplaintID = Convert.ToInt64(963);
            //    objpatientcomplaintattribute.AttributeID = Convert.ToInt32(0);
            //    objpatientcomplaintattribute.AttributevalueID = Convert.ToInt32(0);
            //    objpatientcomplaintattribute.AttributeValueName = "";
            //    Istpatientcomplaintattribute.Add(objpatientcomplaintattribute);
            //    attrvalue.Add(objpatientcomplaintattribute);
            //}
        }
        return returnval;
    }
    public List<SurgicalDetail> GetPatientSurgeryDetail()
    {
        List<SurgicalDetail> lstSurgicalDetailTemp = new List<SurgicalDetail>();
        foreach (string listSurgeryItems in hdnSurgeryItems.Value.Split('^'))
        {
            if (listSurgeryItems != "")
            {
                SurgicalDetail objSurgicalDetail = new SurgicalDetail();
                string[] listChild = listSurgeryItems.Split('~');
                objSurgicalDetail.SurgeryID = 0;
                objSurgicalDetail.SurgeryName = listChild[1];
                if (listChild[2] != "")
                {
                    objSurgicalDetail.TreatmentPlanDate = Convert.ToDateTime(listChild[2]);
                }
                objSurgicalDetail.ParentName = "Minor";
                objSurgicalDetail.HospitalName = listChild[3];
                lstSurgicalDetailTemp.Add(objSurgicalDetail);
            }
        }
        return lstSurgicalDetailTemp;
    }



}
