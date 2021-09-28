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

public partial class CommonControls_SexuallyTransmittedDiseases : BaseControl
{
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
    public void SetData(List<PatientHistoryAttribute> lsthisPHA, long ID)
    {
        var lstSTD = from s in lsthisPHA
                               where s.HistoryID == ID
                               select s;
        if (lstSTD.Count() > 0)
        {
            //List<EMRAttributeClass> cancertype = (from d in lstcancer
            //                                      where d.AttributeID == 13
            //                                      select new EMRAttributeClass
            //                                      {
            //                                          AttributeName = d.AttributeName,
            //                                          AttributevalueID = d.AttributevalueID,
            //                                          AttributeValueName = d.AttributeValueName
            //                                      }).ToList();


            //lstEMRvalue.Name = "Complaint";
            //lstEMRvalue.Attributename = "Cancer";
            //lstEMRvalue.Attributeid = 13;
            //lstEMRvalue.Attributevaluename = cancertype[0].AttributeName;
            ////EMR9.Bind(lstEMRvalue, cancertype);


            //ddlTypeofcancer_13.DataSource = cancertype.ToList();
            //ddlTypeofcancer_13.DataTextField = "AttributeValueName";
            //ddlTypeofcancer_13.DataValueField = "AttributevalueID";
            //ddlTypeofcancer_13.DataBind();

        }
        rdoNo_1100.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
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
                    divrdoYes_1100.Style.Add("display", "block");
                    rdoYes_1100.Checked = true;
                    rdoNo_1100.Checked = false;
                    txtSexuallyTransmitted.Text = lstEditData[j].AttributeValueName.ToString();
                }
                else
                {
                    txtSexuallyTransmitted.Text = "";
                }
            }
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();

        if (rdoYes_1100.Checked == true)
        {
            PatientHistory objPatientHistory = new PatientHistory();
            objPatientHistory.HistoryID = Convert.ToInt32(1100);
            objPatientHistory.HistoryName = rdoYes_1100.Text;
            lstPatientHistory.Add(objPatientHistory);
            attribute.Add(objPatientHistory);
            PatientHistoryAttribute objPatientHistoryAttribute = new PatientHistoryAttribute();
            if (txtSexuallyTransmitted.Text != "")
            {
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1100);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(0);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientHistoryAttribute.AttributeValueName = txtSexuallyTransmitted.Text;
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);

            }
            else
            {
                objPatientHistoryAttribute.HistoryID = Convert.ToInt32(1100);
                objPatientHistoryAttribute.AttributeID = Convert.ToInt64(0);
                objPatientHistoryAttribute.AttributevalueID = Convert.ToInt32(0);
                objPatientHistoryAttribute.AttributeValueName = "";
                lstPatientHistoryAttribute.Add(objPatientHistoryAttribute);
                attrValue.Add(objPatientHistoryAttribute);

            }

        }
        return returnval;
    }
}
