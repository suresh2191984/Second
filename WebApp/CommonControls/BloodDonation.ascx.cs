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

public partial class CommonControls_BloodDonation : BaseControl 
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

    
    
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstBloodDonation = from s in lsthisPHA
                                   where s.HistoryID== ID
                                   select s;
        if (lstBloodDonation.Count() > 0)
        {

        }
        rdoNo_1104.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                       where s.HistoryID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].AttributeValueName!="")
            {
                rdoYes_1104.Checked = true;
                divrdoYes_1104.Style.Add("display", "block");
                txtBloodDonation.Text = lstEditData[j].AttributeValueName;
            }
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrvalue)
    {
        int returnval = -1;

        attribute = new List<PatientHistory>();
        attrvalue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstpatienthistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstpatienthistoryattribute = new List<PatientHistoryAttribute>();
        if (rdoYes_1104.Checked == true)
        {
            PatientHistory objpatienthistory = new PatientHistory();
            objpatienthistory.HistoryID = Convert.ToInt32(1104);
            objpatienthistory.HistoryName = rdoYes_1104.Text;
            lstpatienthistory.Add(objpatienthistory);
            attribute.Add(objpatienthistory);
            PatientHistoryAttribute objpatienthistoryattribute = new PatientHistoryAttribute();
            if (txtBloodDonation.Text != "")
            {
                objpatienthistoryattribute.HistoryID = Convert.ToInt64(1104);
                objpatienthistoryattribute.AttributeID = Convert.ToInt32(0);
                objpatienthistoryattribute.AttributevalueID = Convert.ToInt32(0);
                objpatienthistoryattribute.AttributeValueName = txtBloodDonation.Text;
                lstpatienthistoryattribute.Add(objpatienthistoryattribute);
                attrvalue.Add(objpatienthistoryattribute);
            }
            else
            {
                objpatienthistoryattribute.HistoryID = Convert.ToInt64(1104);
                objpatienthistoryattribute.AttributeID = Convert.ToInt32(0);
                objpatienthistoryattribute.AttributevalueID = Convert.ToInt32(0);
                objpatienthistoryattribute.AttributeValueName = "";
                lstpatienthistoryattribute.Add(objpatienthistoryattribute);
                attrvalue.Add(objpatienthistoryattribute);
            }
        }
        return returnval;
    }


}
