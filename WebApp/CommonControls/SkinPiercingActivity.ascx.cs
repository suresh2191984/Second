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

public partial class CommonControls_SkinPiercingActivity : BaseControl 
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
        var lstSkinPiercing = from s in lsthisPHA
                                        where s.HistoryID == ID
                                        select s;
        if (lstSkinPiercing.Count() > 0)
        {

        }
        rdoNo_1107.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                       where s.HistoryID == ID
                                                       select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            if (lstEditData[j].AttributeValueName != "")
            {
                rdoYes_1107.Checked = true;
                divrdoYes_1107.Style.Add("display", "block");
                string str = "";
                str = lstEditData[j].AttributeValueName;
                string[] strarr = str.Split('~');
                for (int k = 0; k < strarr.Count(); k++)
                {
                    if (strarr[k].ToString() == "Tattoo")
                    {
                        chkTattoo.Checked = true;

                    }
                    if (strarr[k].ToString() == "BodyPiercing")
                    {
                        chkBodyPiercing.Checked = true;
                    }

                    if (strarr[k].ToString() == "EarPiercing")
                    {
                        chkEarPiercing.Checked = true;
                    }
                    if (strarr[k].ToString() == "Acupuncture")
                    {
                        chkAcupuncture.Checked = true;
                    }
                }
            }
        }
    }

    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrvalue)
    {
        int returnval = -1;
        string Text = string.Empty;
        attribute = new List<PatientHistory>();
        attrvalue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstpatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstpatientHistoryattribute = new List<PatientHistoryAttribute>();
        if (rdoYes_1107.Checked == true)
        {
            PatientHistory objpatientHistory = new PatientHistory();
            objpatientHistory.HistoryID = Convert.ToInt32(1107);
            objpatientHistory.HistoryName = rdoYes_1107.Text;
            lstpatientHistory.Add(objpatientHistory);
            attribute.Add(objpatientHistory);
            PatientHistoryAttribute objpatientHistoryattribute = new PatientHistoryAttribute();
            objpatientHistoryattribute.HistoryID = Convert.ToInt64(1107);
            objpatientHistoryattribute.AttributeID = Convert.ToInt32(0);
            if (chkBodyPiercing.Checked == true)
            {
                Text = Text + "BodyPiercing" + "~";
            }
            if (chkTattoo.Checked == true)
            {
                Text = Text + "Tattoo" + "~";
            }
            if (chkEarPiercing.Checked == true)
            {
                Text = Text + "EarPiercing" + "~";
            }
            if (chkAcupuncture.Checked == true)
            {
                Text = Text + "Acupuncture" + "~";
            }
            if (Text != "")
            {
                
                objpatientHistoryattribute.AttributevalueID = Convert.ToInt32(0);
                objpatientHistoryattribute.AttributeValueName = Text.ToString();
                lstpatientHistoryattribute.Add(objpatientHistoryattribute);
                attrvalue.Add(objpatientHistoryattribute);
            }
            else
            {
                objpatientHistoryattribute.AttributevalueID = Convert.ToInt32(0);
                objpatientHistoryattribute.AttributeValueName = "";
                lstpatientHistoryattribute.Add(objpatientHistoryattribute);
                attrvalue.Add(objpatientHistoryattribute);
            }

        }
        return returnval;
    }   
}
