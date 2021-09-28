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

public partial class CommonControls_AlcoholConsumption : BaseControl
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
        var lstAlcohol = from s in lsthisPHA
                         where s.HistoryID == ID
                         select s;
        if (lstAlcohol.Count() > 0)
        {
            List<EMRAttributeClass> lstalcoholduration = (from d in lstAlcohol
                                                          where d.AttributeID == 4
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeName = d.AttributeName,
                                                              AttributevalueID = d.AttributevalueID,
                                                              AttributeValueName = d.AttributeValueName
                                                          }).ToList();
            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Alcohol";
            //lstEMRvalue.Attributeid = 4;
            //lstEMRvalue.Attributevaluename = lstalcoholduration[0].AttributeName;
            //EMR16.Bind(lstEMRvalue, lstalcoholduration);

            ddlTypesAC_12.DataSource = lstalcoholduration.ToList();
            ddlTypesAC_12.DataTextField = "AttributeValueName";
            ddlTypesAC_12.DataValueField = "AttributevalueID";
            ddlTypesAC_12.DataBind();
            ddlTypesAC_12.Items.Insert(0, "---Select---");

            List<EMRAttributeClass> lstalcoholtype = (from d in lstAlcohol
                                                      where d.AttributeID == 5
                                                      select new EMRAttributeClass
                                                      {
                                                          AttributeName = d.AttributeName,
                                                          AttributevalueID = d.AttributevalueID,
                                                          AttributeValueName = d.AttributeValueName
                                                      }).ToList();
            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Alcohol";
            //lstEMRvalue.Attributeid = 5;
            //lstEMRvalue.Attributevaluename = lstalcoholtype[0].AttributeName;
            //EMR17.Bind(lstEMRvalue, lstalcoholtype);

            ddlDurationAC.DataSource = lstalcoholtype.ToList();
            ddlDurationAC.DataTextField = "AttributeValueName";
            ddlDurationAC.DataValueField = "AttributevalueID";
            ddlDurationAC.DataBind();
        }
        rdoNo_369.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                     where s.HistoryID == ID
                                                     select s).ToList();
        for (int j = 0; j < lstEditData.Count(); j++)
        {
            rdoYes_369.Checked = true;
            divrdoYes_369.Style.Add("display", "block");
            if (lstEditData[j].AttributeID == 4)
            {
                ddlTypesAC_12.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                if (ddlTypesAC_12.SelectedItem.Text == "Others")
                {
                    txtOthersTypeAC_17.Text = lstEditData[j].AttributeValueName;
                }
            }
            if (lstEditData[j].AttributeID == 5)
            {
                ddlDurationAC.SelectedValue = lstEditData[j].AttributevalueID.ToString();
                string[] Dur = lstEditData[j].AttributeValueName.Split(' ');
                txtDurationAC.Text = Dur[0].ToString();
                //ddlDurationAC.SelectedValue = Dur[1].ToString();
            }
            if (lstEditData[j].AttributeID == 6)
            {
                string[] Qty = lstEditData[j].AttributeValueName.Split(' ');
                txtQtyAC.Text = Qty[0].ToString();
            }
        }
        List<PatientHistoryAttribute> lstEditData1 = (from s in lstPHA
                                                     where s.HistoryID == 1095
                                                     select s).ToList();
        for (int j = 0; j < lstEditData1.Count(); j++)
        {
            chkQuitAlc_4.Checked = true;
            tdchkQuitAlc_4.Style.Add("display", "block");
            if (lstEditData1[j].AttributeID == 55)
            {
                ddlTypesAC_12.SelectedValue = lstEditData1[j].AttributevalueID.ToString();
            }
            if (lstEditData1[j].AttributeID == 54)
            {
                txtQuitAlc_4.Text = lstEditData1[j].AttributeValueName;
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
        if (rdoYes_369.Checked == true)
        {
            List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
            List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();
            PatientHistory hisPKGAC = new PatientHistory();
            hisPKGAC.HistoryID = 369;
            hisPKGAC.ComplaintId = 0;
            hisPKGAC.Description = "Alcohol Consumption";
            hisPKGAC.HistoryName = "Alcohol Consumption";
            lstPatientHisPKG.Add(hisPKGAC);
            attribute.Add(hisPKGAC);
            {
                PatientHistoryAttribute hisPKGAttAC1 = new PatientHistoryAttribute();
                hisPKGAttAC1.HistoryID = 369;
                hisPKGAttAC1.AttributeID = 4;
                hisPKGAttAC1.AttributevalueID = Convert.ToInt64(ddlTypesAC_12.SelectedValue);
                if (ddlTypesAC_12.SelectedItem.Text != "Others")
                {
                    hisPKGAttAC1.AttributeValueName = ddlTypesAC_12.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttAC1.AttributeValueName = txtOthersTypeAC_17.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttAC1);
                attrValue.Add(hisPKGAttAC1);
            }
            if (txtDurationAC.Text != "")
            {
                PatientHistoryAttribute hisPKGAttAC2 = new PatientHistoryAttribute();
                hisPKGAttAC2.HistoryID = 369;
                hisPKGAttAC2.AttributeID = 5;
                hisPKGAttAC2.AttributevalueID = Convert.ToInt64(ddlDurationAC.SelectedValue);
                hisPKGAttAC2.AttributeValueName = txtDurationAC.Text + " " + ddlDurationAC.SelectedItem.Text;

                lstPatientHisPKGAttributes.Add(hisPKGAttAC2);
                attrValue.Add(hisPKGAttAC2);
            }
            if (txtQtyAC.Text != "")
            {
                PatientHistoryAttribute hisPKGAttAC3 = new PatientHistoryAttribute();
                hisPKGAttAC3.HistoryID = 369;
                hisPKGAttAC3.AttributeID = 6;
                hisPKGAttAC3.AttributevalueID = 17;
                hisPKGAttAC3.AttributeValueName = txtQtyAC.Text + " " + lblMlLtr.Text;

                lstPatientHisPKGAttributes.Add(hisPKGAttAC3);
                attrValue.Add(hisPKGAttAC3);
            }
            if (chkQuitAlc_4.Checked == true)
            {

                PatientHistory hisPKGALQ = new PatientHistory();

                hisPKGALQ.HistoryID = 1095;
                hisPKGALQ.Description = "Alcohol use Quit";
                hisPKGALQ.HistoryName = "Alcohol use Quit";
                lstPatientHisPKG.Add(hisPKGALQ);
                attribute.Add(hisPKGALQ);
                if (txtQuitAlc_4.Text.Trim() != "")
                {
                    PatientHistoryAttribute hisPKGAttALQ1 = new PatientHistoryAttribute();
                    hisPKGAttALQ1.HistoryID = 1095;
                    hisPKGAttALQ1.AttributeID = 54;
                    hisPKGAttALQ1.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttALQ1.AttributeValueName = txtQuitAlc_4.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttALQ1);
                    attrValue.Add(hisPKGAttALQ1);
                }
                if (ddlQuitAlcDuration.SelectedItem.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttALQ2 = new PatientHistoryAttribute();
                    hisPKGAttALQ2.HistoryID = 1095;
                    hisPKGAttALQ2.AttributeID = 55;
                    hisPKGAttALQ2.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttALQ2.AttributeValueName = ddlQuitAlcDuration.SelectedItem.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttALQ2);
                    attrValue.Add(hisPKGAttALQ2);
                }
            }
        }
        return returnval;
    }
}
