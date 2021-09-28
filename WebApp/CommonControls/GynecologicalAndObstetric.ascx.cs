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

public partial class CommonControls_GynecologicalAndObstetric : BaseControl
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
        var lstGynacology = from s in lsthisPHA
                       where s.HistoryID == ID
                       select s;
        if (lstGynacology.Count() > 0)
        {
            List<EMRAttributeClass> menstural = (from d in lstGynacology
                                                 where d.AttributeID == 14
                                                 select new EMRAttributeClass
                                                 {
                                                     AttributeName = d.AttributeName,
                                                     AttributevalueID = d.AttributevalueID,
                                                     AttributeValueName = d.AttributeValueName
                                                 }).ToList();

            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Gynaecology";
            //lstEMRvalue.Attributeid = 14;
            //lstEMRvalue.Attributevaluename = menstural[0].AttributeName;
            //EMR22.Bind(lstEMRvalue, menstural);


            ddlMenstrualCycle.DataSource = menstural.ToList();
            ddlMenstrualCycle.DataTextField = "AttributeValueName";
            ddlMenstrualCycle.DataValueField = "AttributevalueID";
            ddlMenstrualCycle.DataBind();

            List<EMRAttributeClass> result = (from d in lstGynacology
                                              where d.AttributeID == 19
                                              select new EMRAttributeClass
                                              {
                                                  AttributeName = d.AttributeName,
                                                  AttributevalueID = d.AttributevalueID,
                                                  AttributeValueName = d.AttributeValueName
                                              }).ToList();


            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Gynaecology";
            //lstEMRvalue.Attributeid = 19;
            //lstEMRvalue.Attributevaluename = result[0].AttributeName;
            //EMR23.Bind(lstEMRvalue, result);


            ddlLastPapSmearResult.DataSource = result.ToList();
            ddlLastPapSmearResult.DataTextField = "AttributeValueName";
            ddlLastPapSmearResult.DataValueField = "AttributevalueID";
            ddlLastPapSmearResult.DataBind();

            ddlLastMamogramResult.DataSource = result.ToList();
            ddlLastMamogramResult.DataTextField = "AttributeValueName";
            ddlLastMamogramResult.DataValueField = "AttributevalueID";
            ddlLastMamogramResult.DataBind();

            List<EMRAttributeClass> contraception = (from d in lstGynacology
                                                     where d.AttributeID == 17
                                                     select new EMRAttributeClass
                                                     {
                                                         AttributeName = d.AttributeName,
                                                         AttributevalueID = d.AttributevalueID,
                                                         AttributeValueName = d.AttributeValueName
                                                     }).ToList();

            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Gynaecology";
            //lstEMRvalue.Attributeid = 17;
            //lstEMRvalue.Attributevaluename = contraception[0].AttributeName;
            //EMR24.Bind(lstEMRvalue, contraception);

            ddlContraception_50.DataSource = contraception.ToList();
            ddlContraception_50.DataTextField = "AttributeValueName";
            ddlContraception_50.DataValueField = "AttributevalueID";
            ddlContraception_50.DataBind();


            List<EMRAttributeClass> HRTTYPE = (from d in lstGynacology
                                               where d.AttributeID == 22
                                               select new EMRAttributeClass
                                               {
                                                   AttributeName = d.AttributeName,
                                                   AttributevalueID = d.AttributevalueID,
                                                   AttributeValueName = d.AttributeValueName
                                               }).ToList();


            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Gynaecology";
            //lstEMRvalue.Attributeid = 23;
            //lstEMRvalue.Attributevaluename = HRTTYPE[0].AttributeName;
            //EMR27.Bind(lstEMRvalue, HRTTYPE);


            ddlTypeofHRT_59.DataSource = HRTTYPE.ToList();
            ddlTypeofHRT_59.DataTextField = "AttributeValueName";
            ddlTypeofHRT_59.DataValueField = "AttributevalueID";
            ddlTypeofHRT_59.DataBind();

            List<EMRAttributeClass> HRTDelivery = (from d in lstGynacology
                                                   where d.AttributeID == 23
                                                   select new EMRAttributeClass
                                                   {
                                                       AttributeName = d.AttributeName,
                                                       AttributevalueID = d.AttributevalueID,
                                                       AttributeValueName = d.AttributeValueName
                                                   }).ToList();


            //lstEMRvalue.Name = "History";
            //lstEMRvalue.Attributename = "Gynaecology";
            //lstEMRvalue.Attributeid = 23;
            //lstEMRvalue.Attributevaluename = HRTDelivery[0].AttributeName;
            //EMR28.Bind(lstEMRvalue, HRTDelivery);

            ddlHRTDelivery_66.DataSource = HRTDelivery.ToList();
            ddlHRTDelivery_66.DataTextField = "AttributeValueName";
            ddlHRTDelivery_66.DataValueField = "AttributevalueID";
            ddlHRTDelivery_66.DataBind();
        }
        rdoNo_1065.Checked = true;
    }

    public void EditData(List<PatientHistoryAttribute> lstPHA, long ID)
    {
        List<PatientHistoryAttribute> lstEditData = (from s in lstPHA
                                                     where s.HistoryID == ID
                                                     select s).ToList();
        for (int i = 0; i < lstEditData.Count(); i++)
        {
            if (lstEditData[i].HistoryID == ID)
            {
                rdoYes_1065.Checked = true;
                divrdoYes_1065.Style.Add("display", "block");

                if (lstEditData[i].AttributeID == 38)
                {
                    tLMP_38.Text = lstEditData[i].AttributeValueName.ToString();
                }
                if (lstEditData[i].AttributeID == 14)
                {
                    ddlMenstrualCycle.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                }
                if (lstEditData[i].AttributeID == 45)
                {
                    txtCycleLength_45.Text = lstEditData[i].AttributeValueName.ToString();
                }
                if (lstEditData[i].AttributeID == 46)
                {
                    txtLastPapSmearDt_46.Text = lstEditData[i].AttributeValueName.ToString();
                }
                if (lstEditData[i].AttributeID == 47)
                {
                    txtAgeofMenarchy_47.Text = lstEditData[i].AttributeValueName.ToString();
                }
                if (lstEditData[i].AttributeID == 19)
                {
                    ddlLastPapSmearResult.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                }
                if (lstEditData[i].AttributeID == 17)
                {
                    ddlContraception_50.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                    if (lstEditData[i].AttributevalueID == 50)
                    {
                        divddlContraception_50.Style.Add("display", "block");
                        txtContraceptionOthers_50.Text = lstEditData[i].AttributeValueName.ToString();
                    }
                }
                if (lstEditData[i].AttributeID == 55)
                {
                    txtLastMammogramResultDt_55.Text = lstEditData[i].AttributeValueName.ToString();
                }
                if (lstEditData[i].AttributeID == 56)
                {
                    ddlLastMamogramResult.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                }
            }
            if (lstEditData[i].HistoryID == 1066)
            {
                rdoYes_1065.Checked = true;
                divrdoYes_1065.Style.Add("display", "block");
                if (lstEditData[i].AttributeID == 22)
                {
                    ddlTypeofHRT_59.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                    if (lstEditData[i].AttributevalueID == 59)
                    {
                        divddlTypeofHRT_59.Style.Add("display", "none");
                        txtOthersTypeofHRT_59.Text = lstEditData[i].AttributeValueName.ToString();
                    }
                }

                if (lstEditData[i].AttributeID == 23)
                {
                    ddlHRTDelivery_66.SelectedValue = lstEditData[i].AttributevalueID.ToString();
                    if (lstEditData[i].AttributeID == 66)
                    {
                        divddlHRTDelivery_66.Style.Add("display", "none");
                        txtOthersHRTDelivery_66.Text = lstEditData[i].AttributeValueName.ToString();
                    }
                }
            }
        }
    }
    public long GetData(out List<PatientHistory> attribute, out List<PatientHistoryAttribute> attrValue)
    {
        int returnval = -1;
        attribute = new List<PatientHistory>();
        attrValue = new List<PatientHistoryAttribute>();
        if (rdoYes_1065.Checked == true)
        {
            List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
            List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();
            PatientHistory hisPKGDGH = new PatientHistory();
            hisPKGDGH.HistoryID = 1065;
            hisPKGDGH.Description = "GYNAECOLOGICAL HISTORY";
            hisPKGDGH.HistoryName = "GYNAECOLOGICAL HISTORY";
            lstPatientHisPKG.Add(hisPKGDGH);
            attribute.Add(hisPKGDGH);
            if (tLMP_38.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH1 = new PatientHistoryAttribute();
                hisPKGAttGH1.HistoryID = 1065;
                hisPKGAttGH1.AttributeID = 13;
                hisPKGAttGH1.AttributevalueID = 38;
                hisPKGAttGH1.AttributeValueName = tLMP_38.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH1);
                attrValue.Add(hisPKGAttGH1);
            }
            if (ddlMenstrualCycle.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH2 = new PatientHistoryAttribute();
                hisPKGAttGH2.HistoryID = 1065;
                hisPKGAttGH2.AttributeID = 14;
                hisPKGAttGH2.AttributevalueID = Convert.ToInt64(ddlMenstrualCycle.SelectedItem.Value);
                hisPKGAttGH2.AttributeValueName = ddlMenstrualCycle.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH2);
                attrValue.Add(hisPKGAttGH2);
            }
            if (txtCycleLength_45.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH3 = new PatientHistoryAttribute();
                hisPKGAttGH3.HistoryID = 1065;
                hisPKGAttGH3.AttributeID = 15;
                hisPKGAttGH3.AttributevalueID = 45;
                hisPKGAttGH3.AttributeValueName = txtCycleLength_45.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH3);
                attrValue.Add(hisPKGAttGH3);
            }
            if (txtLastPapSmearDt_46.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH4 = new PatientHistoryAttribute();
                hisPKGAttGH4.HistoryID = 1065;
                hisPKGAttGH4.AttributeID = 16;
                hisPKGAttGH4.AttributevalueID = 46;
                hisPKGAttGH4.AttributeValueName = txtLastPapSmearDt_46.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH4);
                attrValue.Add(hisPKGAttGH4);
            }
            if (txtAgeofMenarchy_47.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH5 = new PatientHistoryAttribute();
                hisPKGAttGH5.HistoryID = 1065;
                hisPKGAttGH5.AttributeID = 18;
                hisPKGAttGH5.AttributevalueID = 47;
                hisPKGAttGH5.AttributeValueName = txtAgeofMenarchy_47.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH5);
                attrValue.Add(hisPKGAttGH5);
            }
            if (ddlLastPapSmearResult.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH6 = new PatientHistoryAttribute();
                hisPKGAttGH6.HistoryID = 1065;
                hisPKGAttGH6.AttributeID = 19;
                hisPKGAttGH6.AttributevalueID = Convert.ToInt64(ddlLastPapSmearResult.SelectedItem.Value);
                hisPKGAttGH6.AttributeValueName = ddlLastPapSmearResult.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH6);
                attrValue.Add(hisPKGAttGH6);
            }
            if (ddlContraception_50.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH7 = new PatientHistoryAttribute();
                hisPKGAttGH7.HistoryID = 1065;
                hisPKGAttGH7.AttributeID = 17;
                hisPKGAttGH7.AttributevalueID = Convert.ToInt64(ddlContraception_50.SelectedItem.Value);
                if (ddlContraception_50.SelectedItem.Value != "50")
                {
                    hisPKGAttGH7.AttributeValueName = ddlContraception_50.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttGH7.AttributeValueName = txtContraceptionOthers_50.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttGH7);
                attrValue.Add(hisPKGAttGH7);
            }
            if (txtLastMammogramResultDt_55.Text != "")
            {
                PatientHistoryAttribute hisPKGAttGH8 = new PatientHistoryAttribute();
                hisPKGAttGH8.HistoryID = 1065;
                hisPKGAttGH8.AttributeID = 20;
                hisPKGAttGH8.AttributevalueID = 55;
                hisPKGAttGH8.AttributeValueName = txtLastMammogramResultDt_55.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH8);
                attrValue.Add(hisPKGAttGH8);
            }
            if (ddlLastMamogramResult.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttGH9 = new PatientHistoryAttribute();
                hisPKGAttGH9.HistoryID = 1065;
                hisPKGAttGH9.AttributeID = 21;
                hisPKGAttGH9.AttributevalueID = Convert.ToInt64(ddlLastMamogramResult.SelectedItem.Value);
                hisPKGAttGH9.AttributeValueName = ddlLastMamogramResult.SelectedItem.Text;
                lstPatientHisPKGAttributes.Add(hisPKGAttGH9);
                attrValue.Add(hisPKGAttGH9);
            }
            if (ddlTypeofHRT_59.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT1 = new PatientHistoryAttribute();
                hisPKGAttHRT1.HistoryID = 1065;
                hisPKGAttHRT1.AttributeID = 22;
                hisPKGAttHRT1.AttributevalueID = Convert.ToInt64(ddlTypeofHRT_59.SelectedItem.Value);
                if (ddlTypeofHRT_59.SelectedItem.Value != "59")
                {
                    hisPKGAttHRT1.AttributeValueName = ddlTypeofHRT_59.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT1.AttributeValueName = txtOthersTypeofHRT_59.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT1);
                attrValue.Add(hisPKGAttHRT1);
            }

            if (ddlHRTDelivery_66.SelectedItem.Text != "---Select---")
            {
                PatientHistoryAttribute hisPKGAttHRT2 = new PatientHistoryAttribute();
                hisPKGAttHRT2.HistoryID = 1065;
                hisPKGAttHRT2.AttributeID = 23;
                hisPKGAttHRT2.AttributevalueID = Convert.ToInt64(ddlHRTDelivery_66.SelectedValue);
                if (ddlHRTDelivery_66.SelectedValue != "66")
                {
                    hisPKGAttHRT2.AttributeValueName = ddlHRTDelivery_66.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttHRT2.AttributeValueName = txtOthersHRTDelivery_66.Text;
                }

                lstPatientHisPKGAttributes.Add(hisPKGAttHRT2);
                attrValue.Add(hisPKGAttHRT2);
            }
        }
        return returnval;
    }
}
