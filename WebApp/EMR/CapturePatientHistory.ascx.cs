
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Drawing;
using System.Web.Script.Serialization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class EMR_CapturePatientHistory : BaseControl
{
   // List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
    protected void Page_Load(object sender, EventArgs e)
    {
       // LoadMeatData();
       
        //hndlogin.Value = LID.ToString();
      //  hndlogin.Value = Convert.ToString(LID);
        
        //LoadReferingPhysician();
    }
    //string select = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40 == null ? "--Select--" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40;
    //public void LoadReferingPhysician()
    //{
    //    long returncode = -1;
    //    List<Physician> lstPhysician = new List<Physician>();
    //    PatientVisit_BL objBL = new PatientVisit_BL(base.ContextInfo);
    //    returncode = objBL.GetInternalExternalPhysician(OrgID, out lstPhysician, out lstReferingPhysician);

    //    ddlAssinee.DataSource = lstPhysician;
    //    ddlAssinee.DataTextField = "Assinee";
    //    ddlAssinee.DataValueField = "DeptID";
    //    ddlAssinee.DataBind();
    //    ddlAssinee.Items.Insert(0, new ListItem("---Select--", "0"));
    //    ddlAssinee.SelectedIndex = 0;
    //}
    //protected void btnSave_Click(object sender, EventArgs e)
    //{

    //    List<PatientHistoryAttribute> lsthisPHA1 = new List<PatientHistoryAttribute>();
    //    List<PatientHistory> lstPatientHisPKG1 = new List<PatientHistory>();
    //   // SaveData(out  lsthisPHA1, out lstPatientHisPKG1);

    //}

    //protected void btnclear_click(object sender, EventArgs e)
    //{
        //txtdescription.Text = "";
        //ddlAssinee.Text = "";
        //ddlcancer.Text = "";
        //ddlindications.Text = "";
        //txttype.Text = "";
        //txtfamilyhistory.Text = "";
        //txtstrandcaseid.Text = "";
        //ddlreferral.Text = "";
        //ddlethinicity.Text = "";
        //txtkeyfinding.Text = "";
        //chkboxnewvalidation.Text = "";
        //ddlpaneltype.Text = "";
       

    //}
    


    //public void SaveData(out List<PatientHistoryAttribute> lsthisPHA1, out List<PatientHistory> lstPatientHisPKG1)
    //{

    //    long returncode = -1;
    //    long patientID = -1;
    //    long InvID = -1;
    //    Int64.TryParse(Request.QueryString["vid"], out patientVID);
    //    Int64.TryParse(Request.QueryString["pid"], out patientID);
    //    lsthisPHA1 = new List<PatientHistoryAttribute>();
    //    lstPatientHisPKG1 = new List<PatientHistory>();
    //    List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
    //    List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
    //    List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();

    //    if (chkLMP.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtLMP.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1097;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "LMP";
    //            hisPKGTS.Description = "LMP";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var  ValueID  = from s in lsthisPHA
    //                                where s.HistoryID == 1097
    //                                  select s.AttributevalueID ;
    //                var  AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1097
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1097;
    //                hisPKGAttTS1.AttributeID = 123; //123
    //                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
    //                hisPKGAttTS1.AttributeValueName = txtLMP.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }
    //        }
    //    }



    //    if (ChkFasting_Duration.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtHours.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1098;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "Fasting Duration (hours)";
    //            hisPKGTS.Description = "Fasting Duration (hours)";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1098
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1098
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1098;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(124); //124
    //                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
    //                hisPKGAttTS1.AttributeValueName = txtHours.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }
    //        }
    //    }


    //    if (ChkLastMealTime.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtDateTime.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1099;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "Last Meal Time";
    //            hisPKGTS.Description = "Last Meal Time";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1099
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1099
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1099;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(125); //125
    //                hisPKGAttTS1.AttributevalueID = 0;
    //                hisPKGAttTS1.AttributeValueName = txtDateTime.Text;
    //                Int64.TryParse(hdnInvestigationID.Value, out InvID);
    //                hisPKGAttTS1.InvestigationID = InvID;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }
    //        }
    //    }


    //    if (ChkRecent_Sonography_Report.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtRecent_Sonography_ReportDate.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1100;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "Recent Sonography Report";
    //            hisPKGTS.Description = "Recent Sonography Report";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1100
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1100
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1100;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(126); //126
    //                hisPKGAttTS1.AttributevalueID = 0;
    //                hisPKGAttTS1.AttributeValueName = txtRecent_Sonography_ReportDate.Text + "~" + txtRecent_Sonography_ReportComments.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }
    //        }
    //    }


    //    if (chkurine_volume_Collected.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if ((txtHeight.Text != "") || (txtWeight.Text != ""))
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1101;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "24h urine volume Collected in ml";
    //            hisPKGTS.Description = "24h urine volume Collected in ml";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();

    //            Height
    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1101
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1101 && s.AttributeName == "Height"
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1101;
    //                if ((txtHeight.Text != ""))
    //                {
    //                    hisPKGAttTS1.AttributeID = Convert.ToInt64(127); //127
    //                    hisPKGAttTS1.AttributevalueID = 0;
    //                    hisPKGAttTS1.AttributeValueName = txtHeight.Text;
    //                }
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }


    //            Weight
    //            if (txtWeight.Text != "")
    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1101
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1101 && s.AttributeName == "Weight"
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1101;
    //                if ((txtWeight.Text != "") && (Convert.ToInt64(128) == 128))
    //                {
    //                    hisPKGAttTS1.AttributeID = Convert.ToInt64(128); //128
    //                    hisPKGAttTS1.AttributevalueID = 0;
    //                    hisPKGAttTS1.AttributeValueName = txtWeight.Text;
    //                }
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }


    //        }
    //    }


    //    if (ChkAbstinence_days.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtAbstinence_days.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1102;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "Abstinence days";
    //            hisPKGTS.Description = "Abstinence days";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1102
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1102
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1102;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(129); //129
    //                hisPKGAttTS1.AttributevalueID = 0;
    //                hisPKGAttTS1.AttributeValueName = txtAbstinence_days.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

    //            }
    //        }
    //    }


    //    if (ChkOn_anti_thyroid_disease_drugs.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (ddlCheck.SelectedItem.Text != "" && ddlCheck.SelectedItem.Text != "-- - Select-- - ")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1103;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "On anti-thyroid disease drugs";
    //            hisPKGTS.Description = "On anti-thyroid disease drugs";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1103
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1103
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1103;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(130); //130
    //                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(ddlCheck.SelectedValue);
    //                hisPKGAttTS1.AttributeValueName = ddlCheck.SelectedItem.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


    //            }
    //        }
    //    }



    //    if (ChkReading_taken_between_48_72_hrs.Checked == true)
    //    {

    //        PatientHistory hisPKGTS = new PatientHistory();
    //        if (txtFreeText.Text != "")
    //        {
    //            hisPKGTS.PatientVisitID = patientVID;
    //            hisPKGTS.HistoryID = 1104;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = "Reading taken between 48hrs - 72 hrs";
    //            hisPKGTS.Description = "Reading taken between 48hrs - 72 hrs";
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();
    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1104
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1104
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = 1104;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(0); //130
    //                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
    //                hisPKGAttTS1.AttributeValueName = txtFreeText.Text;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


    //            }
    //        }
    //    }

    //    if (!string.IsNullOrEmpty(hdnPatientHistoryAttribute.Value))
    //    {
    //        ConvertHTMLTablesToDataSet("tblDynamicControls");
    //        JavaScriptSerializer serializer = new JavaScriptSerializer();
    //        List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();
    //        string strLstPatientHistoryAttribute = hdnPatientHistoryAttribute.Value;
    //        lstPatientHistoryAttribute = serializer.Deserialize<List<PatientHistoryAttribute>>(strLstPatientHistoryAttribute);

    //         PatientHistory hisPKGTS = new PatientHistory();
    //        foreach (PatientHistoryAttribute lstHistory in lstPatientHistoryAttribute)
    //        {
    //            PatientHistory hisPKGTS = new PatientHistory();
    //            int HistoryID;
    //            hisPKGTS.PatientVisitID = patientVID;
    //            Int32.TryParse(lstHistory.HistoryID.ToString(), out HistoryID);
    //            hisPKGTS.HistoryID = HistoryID;
    //            hisPKGTS.ComplaintId = 0;
    //            hisPKGTS.HistoryName = lstHistory.HistoryName;
    //            hisPKGTS.Description = lstHistory.HistoryName;
    //            lstPatientHisPKG.Add(hisPKGTS);
    //            List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();
    //            {
    //                PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

    //                var ValueID = from s in lsthisPHA
    //                              where s.HistoryID == 1104
    //                              select s.AttributevalueID;
    //                var AttriID = from s in lsthisPHA
    //                              where s.HistoryID == 1104
    //                              select s.AttributeID;

    //                hisPKGAttTS1.PatientVisitID = patientVID;
    //                hisPKGAttTS1.HistoryID = lstHistory.HistoryID;
    //                hisPKGAttTS1.AttributeID = Convert.ToInt64(0); //130
    //                hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
    //                hisPKGAttTS1.AttributeValueName = lstHistory.AttributeValueName;
    //                lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


    //            }
    //        }

    //    }


    //    try
    //    {
    //        if (lstPatientHisPKG.Count > 0)
    //        {
    //            lstPatientHisPKG1 = lstPatientHisPKG;
    //            lsthisPHA1 = lstPatientHisPKGAttributes;
    //            returncode = patientBL.SaveEMRHistory(lstPatientHisPKG, lstPatientHisPKGAttributes, LID, patientVID, patientID);


    //            if (returncode > 0)
    //            {
    //                  ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Changes saved successfully.');", true);
    //                hdnSaveHisStatus.Value = "Save";
    //                bStatus = true;
    //                ViewHistoryData(patientVID);
    //            }
    //        }
    //        else
    //        {
    //            bStatus = false;
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hhh", "javascript:alert('Please enter History details');", true);
    //            Clearvalues();
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        CLogger.LogError("Error in Save PatientHistory in His.ascx page", ex);

    //    }

    //}
    //public void LoadMeatData()
    //{
    //    try
    //    {
    //        long returncode = -1;
    //        string domains = "IndicationsData,AssineeValue,Genetestresult,PanelOrReferralValue,AffectedCancer,EthncityValue,Gender,TGender,DateAttributes,TMasterCtrlOperRange,TMasterCtrlOperRange1,TMasterCtrlInterpretation,TMasterCtrlSubCategory,TMasterCtrlRtype";
    //        string[] Tempdata = domains.Split(',');
    //        string LangCode = "en-GB";
    //        List<MetaData> lstmetadataInput = new List<MetaData>();
    //        List<MetaData> lstmetadataOutput = new List<MetaData>();
    //        MetaData objMeta;
    //        for (int i = 0; i < Tempdata.Length; i++)
    //        {
    //            objMeta = new MetaData();
    //            objMeta.Domain = Tempdata[i];
    //            lstmetadataInput.Add(objMeta);
    //        }
    //        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
    //        if (lstmetadataOutput.Count > 0)
    //        {
    //            var childItems11 = from child in lstmetadataOutput
    //                              where child.Domain == "EthncityValue"
    //                              select child;
    //            if (childItems11.Count() > 0)
    //            { 
    //                ddlMSTEthncity.DataSource = childItems11;
    //                ddlMSTEthncity.DataTextField = "DisplayText";
    //                ddlMSTEthncity.DataValueField = "Code";
    //                ddlMSTEthncity.DataBind();
    //                ddlMSTEthncity.Items.Insert(0, new ListItem(select, "0"));

    //                ddlethinicity.DataSource = childItems11;
    //                ddlethinicity.DataTextField = "DisplayText";
    //                ddlethinicity.DataValueField = "Code";
    //                ddlethinicity.DataBind();
    //                ddlethinicity.Items.Insert(0, new ListItem(select, "0"));

    //                ddlcolonethnicity.DataSource = childItems11;
    //                ddlcolonethnicity.DataTextField = "DisplayText";
    //                ddlcolonethnicity.DataValueField = "Code";
    //                ddlcolonethnicity.DataBind();
    //                ddlcolonethnicity.Items.Insert(0, new ListItem(select, "0"));

    //                ddlSomaticEthnicity.DataSource = childItems11;
    //                ddlSomaticEthnicity.DataTextField = "DisplayText";
    //                ddlSomaticEthnicity.DataValueField = "Code";
    //                ddlSomaticEthnicity.DataBind();
    //                ddlSomaticEthnicity.Items.Insert(0, new ListItem(select, "0"));

    //                ddlTSPEthnicity.DataSource = childItems11;
    //                ddlTSPEthnicity.DataTextField = "DisplayText";
    //                ddlTSPEthnicity.DataValueField = "Code";
    //                ddlTSPEthnicity.DataBind();
    //                ddlTSPEthnicity.Items.Insert(0, new ListItem(select, "0"));

    //                ddllungethn.DataSource = childItems11;
    //                ddllungethn.DataTextField = "DisplayText";
    //                ddllungethn.DataValueField = "Code";
    //                ddllungethn.DataBind();
    //                ddllungethn.Items.Insert(0, new ListItem(select, "0"));
    //            }
    //            var childItems12 = from child in lstmetadataOutput
    //                               where child.Domain == "AffectedCancer"
    //                               select child;
    //            if (childItems12.Count() > 0)
    //            {
    //                ddlcancer.DataSource = childItems12;
    //                ddlcancer.DataTextField = "DisplayText";
    //                ddlcancer.DataValueField = "Code";
    //                ddlcancer.DataBind();
    //                ddlcancer.Items.Insert(0, new ListItem(select, "0"));
    //            }

    //            var childItems13 = from child in lstmetadataOutput
    //                               where child.Domain == "PanelOrReferralValue"
    //                              select child;
    //            if (childItems13.Count() > 0)
    //            {
    //                ddlpaneltype.DataSource = childItems13;
    //                ddlpaneltype.DataTextField = "DisplayText";
    //                ddlpaneltype.DataValueField = "Code";
    //                ddlpaneltype.DataBind();
    //                ddlpaneltype.Items.Insert(0, new ListItem(select, "0"));

    //                ddlreferral.DataSource = childItems13;
    //                ddlreferral.DataTextField = "DisplayText";
    //                ddlreferral.DataValueField = "Code";
    //                ddlreferral.DataBind();
    //                ddlreferral.Items.Insert(0, new ListItem(select, "0"));

    //                ddlMSTGermlinePanel.DataSource = childItems13;
    //                ddlMSTGermlinePanel.DataTextField = "DisplayText";
    //                ddlMSTGermlinePanel.DataValueField = "Code";
    //                ddlMSTGermlinePanel.DataBind();
    //                ddlMSTGermlinePanel.Items.Insert(0, new ListItem(select, "0"));

    //            }

    //            var childItems14 = from child in lstmetadataOutput
    //                               where child.Domain == "Genetestresult"
    //                               select child;
    //            if (childItems14.Count() > 0)
    //            {
    //                ddlColonGene.DataSource = childItems14;
    //                ddlColonGene.DataTextField = "DisplayText";
    //                ddlColonGene.DataValueField = "Code";
    //                ddlColonGene.DataBind();
    //                ddlColonGene.Items.Insert(0, new ListItem(select, "0"));

    //                ddllunggene.DataSource = childItems14;
    //                ddllunggene.DataTextField = "DisplayText";
    //                ddllunggene.DataValueField = "Code";
    //                ddllunggene.DataBind();
    //                ddllunggene.Items.Insert(0, new ListItem(select, "0"));

    //                ddlSomaticGeneResult.DataSource = childItems14;
    //                ddlSomaticGeneResult.DataTextField = "DisplayText";
    //                ddlSomaticGeneResult.DataValueField = "Code";
    //                ddlSomaticGeneResult.DataBind();
    //                ddlSomaticGeneResult.Items.Insert(0, new ListItem(select, "0"));

    //                ddlTSPGene.DataSource = childItems14;
    //                ddlTSPGene.DataTextField = "DisplayText";
    //                ddlTSPGene.DataValueField = "Code";
    //                ddlTSPGene.DataBind();
    //                ddlTSPGene.Items.Insert(0, new ListItem(select, "0"));
    //            }

    //            var childItems15 = from child in lstmetadataOutput
    //                               where child.Domain == "AssineeValue"
    //                               select child;
    //            if (childItems15.Count() > 0)
    //            {

    //                ddlAssinee.DataSource = childItems15;
    //                ddlAssinee.DataTextField = "DisplayText";
    //                ddlAssinee.DataValueField = "Code";
    //                ddlAssinee.DataBind();
    //                ddlAssinee.Items.Insert(0, new ListItem(select, "0"));

    //                ddlMstAssinee.DataSource = childItems15;
    //                ddlMstAssinee.DataTextField = "DisplayText";
    //                ddlMstAssinee.DataValueField = "Code";
    //                ddlMstAssinee.DataBind();
    //                ddlMstAssinee.Items.Insert(0, new ListItem(select, "0"));

    //                ddlSomaticAssinee.DataSource = childItems15;
    //                ddlSomaticAssinee.DataTextField = "DisplayText";
    //                ddlSomaticAssinee.DataValueField = "Code";
    //                ddlSomaticAssinee.DataBind();
    //                ddlSomaticAssinee.Items.Insert(0, new ListItem(select, "0"));

    //                ddlTSPAssinee.DataSource = childItems15;
    //                ddlTSPAssinee.DataTextField = "DisplayText";
    //                ddlTSPAssinee.DataValueField = "Code";
    //                ddlTSPAssinee.DataBind();
    //                ddlTSPAssinee.Items.Insert(0, new ListItem(select, "0"));

    //                ddlColonAssinee.DataSource = childItems15;
    //                ddlColonAssinee.DataTextField = "DisplayText";
    //                ddlColonAssinee.DataValueField = "Code";
    //                ddlColonAssinee.DataBind();
    //                ddlColonAssinee.Items.Insert(0, new ListItem(select, "0"));

    //                ddlTSPlung.DataSource = childItems15;
    //                ddlTSPlung.DataTextField = "DisplayText";
    //                ddlTSPlung.DataValueField = "Code";
    //                ddlTSPlung.DataBind();
    //                ddlTSPlung.Items.Insert(0, new ListItem(select, "0"));
    //            }

    //           var childItems16 = from child in lstmetadataOutput
    //                               where child.Domain == "IndicationsData"
    //                               select child;
    //            if (childItems16.Count() > 0)
    //            {
    //                ddlindications.DataSource = childItems16;
    //                ddlindications.DataTextField = "DisplayText";
    //                ddlindications.DataValueField = "Code";
    //                ddlindications.DataBind();
    //                ddlindications.Items.Insert(0, new ListItem(select, "0"));

    //                ddlMSTIndicaions.DataSource = childItems16;
    //                ddlMSTIndicaions.DataTextField = "DisplayText";
    //                ddlMSTIndicaions.DataValueField = "Code";
    //                ddlMSTIndicaions.DataBind();
    //                ddlMSTIndicaions.Items.Insert(0, new ListItem(select, "0")); 

    //            }

    //            var childItems = from child in lstmetadataOutput
    //                             where child.Domain == "Gender"
    //                             select child;
    //            if (childItems.Count() > 0)
    //            {
    //                //ddlAssinee.DataSource = childItems;
    //                //ddlAssinee.DataTextField = "DisplayText";
    //                //ddlAssinee.DataValueField = "Code";
    //                //ddlAssinee.DataBind();
    //                //ddlAssinee.Items.Insert(0, new ListItem(select, "0"));
    //                //ddlAssinee.Items[0].Value = "0";
    //                //ddlMstAssinee.DataSource = childItems;
    //                //ddlMstAssinee.DataTextField = "DisplayText";
    //                //ddlMstAssinee.DataValueField = "Code";
    //                //ddlMstAssinee.DataBind();
    //                //ddlMstAssinee.Items.Insert(0, new ListItem(select, "0"));
    //                //ddlMstAssinee.Items[0].Value = "0";
    //            }
    //            var childItems1 = from child in lstmetadataOutput
    //                              where child.Domain == "DateAttributes"
    //                              select child;
    //            if (childItems1.Count() > 0)
    //            {
    //                //ddlcancer.DataSource = childItems1;
    //                //ddlcancer.DataTextField = "DisplayText";
    //                //ddlcancer.DataValueField = "Code";
    //                //ddlcancer.DataBind();
    //                //ddlcancer.Items.Insert(0, new ListItem(select, "0"));

    //                //ddlMSTEthncity.DataSource = childItems1;
    //                //ddlMSTEthncity.DataTextField = "DisplayText";
    //                //ddlMSTEthncity.DataValueField = "Code";
    //                //ddlMSTEthncity.DataBind();
    //                //ddlMSTEthncity.Items.Insert(0, new ListItem(select, "0"));

    //                //ddlindications.DataSource = childItems1;
    //                //ddlindications.DataTextField = "DisplayText";
    //                //ddlindications.DataValueField = "Code";
    //                //ddlindications.DataBind();
    //                //ddlindications.Items.Insert(0, new ListItem(select, "0"));

    //                //ddlMSTIndicaions.DataSource = childItems1;
    //                //ddlMSTIndicaions.DataTextField = "DisplayText";
    //                //ddlMSTIndicaions.DataValueField = "Code";
    //                //ddlMSTIndicaions.DataBind();
    //                //ddlMSTIndicaions.Items.Insert(0, new ListItem(select, "0"));


    //            }
    //            var childItems2 = from child in lstmetadataOutput
    //                              where child.Domain == "TMasterCtrlOperRange"
    //                              select child;
    //            if (childItems2.Count() > 0)
    //            {
    //                //ddlreferral.DataSource = childItems2;
    //                //ddlreferral.DataTextField = "DisplayText";
    //                //ddlreferral.DataValueField = "Code";
    //                //ddlreferral.DataBind();
    //                //ddlreferral.Items.Insert(0, new ListItem(select, "0"));

    //                //ddlethinicity.DataSource = childItems2;
    //                //ddlethinicity.DataTextField = "DisplayText";
    //                //ddlethinicity.DataValueField = "Code";
    //                //ddlethinicity.DataBind();
    //                //ddlethinicity.Items.Insert(0, new ListItem(select, "0"));

    //            }
    //            var childItems3 = from child in lstmetadataOutput
    //                              where child.Domain == "TMasterCtrlOperRange1"
    //                              select child;
    //            if (childItems3.Count() > 0)
    //            {
    //                //ddlpaneltype.DataSource = childItems3;
    //                //ddlpaneltype.DataTextField = "DisplayText";
    //                //ddlpaneltype.DataValueField = "Code";
    //                //ddlpaneltype.DataBind();
    //                //ddlpaneltype.Items.Insert(0, new ListItem(select, "0"));

    //                //ddlMSTGermlinePanel.DataSource = childItems3;
    //                //ddlMSTGermlinePanel.DataTextField = "DisplayText";
    //                //ddlMSTGermlinePanel.DataValueField = "Code";
    //                //ddlMSTGermlinePanel.DataBind();
    //                //ddlMSTGermlinePanel.Items.Insert(0, new ListItem(select, "0"));


    //            }
    //            var childItems4 = from child in lstmetadataOutput
    //                              where child.Domain == "TMasterCtrlInterpretation"
    //                              select child;
    //            if (childItems4.Count() > 0)
    //            {
    //                //ddlmstAssinee.DataSource = childItems4;
    //                //ddlmstAssinee.DataTextField = "DisplayText";
    //                //ddlmstAssinee.DataValueField = "Code";
    //                //ddlmstAssinee.DataBind();
    //                //ddlmstIndications.DataSource = childItems4;
    //                //ddlmstIndications.DataTextField = "DisplayText";
    //                //ddlmstIndications.DataValueField = "Code";
    //                //ddlmstIndications.DataBind();
    //                //ddlmstIndications.DataSource = childItems4;
    //                //ddlmstIndications.DataTextField = "DisplayText";
    //                //ddlmstIndications.DataValueField = "Code";
    //                //ddlmstIndications.DataBind();
    //                //ddlmstIndications.Items.Insert(0, new ListItem(select, "0"));

    //            }
    //            var childItems5 = from child in lstmetadataOutput
    //                              where child.Domain == "TMasterCtrlSubCategory"
    //                              select child;
    //            if (childItems5.Count() > 0)
    //            {
    //                //ddlmstgenename.DataSource = childItems5;
    //                //ddlmstgenename.DataTextField = "DisplayText";
    //                //ddlmstgenename.DataValueField = "Code";
    //                //ddlmstgenename.DataBind();
    //                //ddlmstgenename.Items.Insert(0, new ListItem(select, "0"));

    //            }
    //            var childItems6 = from child in lstmetadataOutput
    //                              where child.Domain == "TGender"
    //                              select child;
    //            if (childItems6.Count() > 0)
    //            {
    //                //ddlmstethinicity.DataSource = childItems6;
    //                //ddlmstethinicity.DataTextField = "DisplayText";
    //                //ddlmstethinicity.DataValueField = "Code";
    //                //ddlmstethinicity.DataBind();
    //                //ddlmstethinicity.Items.Insert(0, new ListItem(select, "0"));
    //                //ddlmstethinicity.SelectedValue = "0";

    //            }
    //            var childItems7 = from child in lstmetadataOutput
    //                              where child.Domain == "TMasterCtrlRtype"
    //                              select child;
    //            if (childItems7.Count() > 0)
    //            {


    //            }
    //        }
    //        //string domains1 = "TestNotification";
    //        //string[] Tempdata1 = domains1.Split(',');
    //        //string LangCode1 = "en-GB";
    //        //List<MetaData> lstmetadataInputs = new List<MetaData>();
    //        //List<MetaData> lstmetadataOutputs = new List<MetaData>();
    //        //MetaData objMeta1;

    //        //for (int i = 0; i < Tempdata1.Length; i++)
    //        //{
    //        //    objMeta1 = new MetaData();
    //        //    objMeta1.Domain = Tempdata1[i];
    //        //    lstmetadataInputs.Add(objMeta1);
    //        //}
    //        //returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode1, out lstmetadataOutputs);
    //        //if (lstmetadataOutputs.Count > 0)
    //        //{
    //        //    var childItems = from child in lstmetadataOutputs
    //        //                     where child.Domain == "TestNotification"
    //        //                     select child;
    //        //    if (childItems.Count() > 0)
    //        //    {
    //        //        //ddlAssinee.DataSource = childItems;
    //        //        //ddlAssinee.DataTextField = "DisplayText";
    //        //        //ddlAssinee.DataValueField = "Code";
    //        //        //ddlAssinee.DataBind();
    //        //        //ddlAssinee.DataSource = childItems;
    //        //        //ddlAssinee.DataTextField = "DisplayText";
    //        //        //ddlAssinee.DataValueField = "Code";
    //        //        //ddlAssinee.DataBind();

    //        //    }
    //        //}
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
    //    }
    //}



}


