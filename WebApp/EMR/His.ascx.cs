using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.DAL;
using Attune.Podium.EMR;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Xml;

public partial class EMR_His : BaseControl
{
    public EMR_His()
        : base("EMR_His_ascx")
    {
    }

    List<EMRAttributeClass> lstEMR = new List<EMRAttributeClass>();
    List<EMRAttributeClass> lstEMRlesions = new List<EMRAttributeClass>();
    EMR lstEMRvalue = new EMR();
    Physician_BL Physiciansbl;
    Patient_BL patientBL;
    long patientVID = -1;
    long invID = -1;
    DateTime dTIME;
    bool bStatus;
    public string TypeValue = string.Empty;
    public string ReturnPage = string.Empty;

    #region "Common Resource Property"

    string strSelect = Resources.EMR_ClientDisplay.EMR_His_ascx_01 == null ? "---Select---" : Resources.EMR_ClientDisplay.EMR_His_ascx_01;
    string strAlert = Resources.EMR_AppMsg.EMR_His_ascx_Alert == null ? "Alert" : Resources.EMR_AppMsg.EMR_His_ascx_Alert;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        Physiciansbl = new Physician_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            //if (chkLMP.Checked == true)
            //{
            //    divchkLMP.Attributes.Add("Style", "Display:Block");
            //    tr1PatientHistory_LMP_1097.Attributes.Add("Style", "Display:Block");
            //}
            //else
            //{
            //    divchkLMP.Attributes.Add("Style", "Display:None");
            //}

            hdnSaveHisStatus.Value = "";
            dTIME = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            //txtDateTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");


        }

        hdnConfig.Value = "";
        string DontShowEMRPopUp = GetConfigValue("DntShowEmrPopUp", OrgID);
        if (DontShowEMRPopUp == "Y")
        {
            hdnConfig.Value = "Y";
        }
        else
        {
            hdnConfig.Value = "N";
        }
    }

    #endregion

    #region "Events"

    protected void btnSave_Click(object sender, EventArgs e)
    {

        List<PatientHistoryAttribute> lsthisPHA1 = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHisPKG1 = new List<PatientHistory>();
        SaveData(out  lsthisPHA1, out lstPatientHisPKG1);

    }

    #endregion

    #region "Methods"

    public void ViewHistoryData(long Vid)
    {

        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;
        long InID = -1;

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["invid"], out InID);
        try
        {
            tblMain.Style.Add("display", "none");
            divviewHistory.Style.Add("display", "block");
            tr1.Style.Add("display", "none");
            tr2.Style.Add("display", "none");
            tr3.Style.Add("display", "none");
            tr4.Style.Add("display", "none");
            tr5.Style.Add("display", "none");
            tr6.Style.Add("display", "none");
            tr7.Style.Add("display", "none");
            tr8.Style.Add("display", "none");

            if (Vid > 0 != null)
            {

                List<PatientHistoryAttribute> lstPatHisAttribute1 = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> lsthisPHA1 = new List<PatientHistoryAttribute>();
                List<DrugDetails> lstDrugDetails1 = new List<DrugDetails>();
                List<GPALDetails> lstGPALDetails1 = new List<GPALDetails>();
                List<ANCPatientDetails> lstANCPatientDetails1 = new List<ANCPatientDetails>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory1 = new List<PatientPastVaccinationHistory>();
                List<PatientComplaintAttribute> lstPCA1 = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> lsthisPCA1 = new List<PatientComplaintAttribute>();
                List<SurgicalDetail> lstSurgicalDetails1 = new List<SurgicalDetail>();

                returnCode = new SmartAccessor().GetPatientHistoryPKGEdit
                  (Vid, out lstPatHisAttribute1, out lstDrugDetails1, out lstGPALDetails1, out lstANCPatientDetails1,
                  out lstPatientPastVaccinationHistory1, out lstPCA1, out lstSurgicalDetails1, out lsthisPCA1, out lsthisPHA1);


                if (lstPatHisAttribute1.Count > 0)
                {
                    for (int i = 0; i < lstPatHisAttribute1.Count; i++)
                    {
                        PatientIdLbl.Text = "Patient ID : " + lstPatHisAttribute1[i].PatientID;
                        PatientNameLbl.Text = "Patient Name : " + lstPatHisAttribute1[i].PatientName;
                        divViewHeader.Style.Add("display", "block");
                        tr7.Style.Add("display", "table-row");
                        grdHistory.DataSource = lstPatHisAttribute1;
                        grdHistory.DataBind();
                    }

                }
                else
                {

                }

                tblAtt.Visible = false;
                tblBtnAtt.Visible = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewHistoryData PatientHistory in His.ascx page", ex);
        }




    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public bool getstatus()
    {
        return bStatus;
    }

    public void Clearvalues()
    {
        txtAbstinence_days.Text = "";
        txtFreeText.Text = "";
        txtLMP.Text = "";
        txtHeight.Text = "";
        txtWeight.Text = "";
        txtHours.Text = "";
        txtRecent_Sonography_ReportComments.Text = "";
        txtRecent_Sonography_ReportDate.Text = "";

    }

    public void LoadHistory()
    {
        tblMain.Style.Add("display", "none");
        divviewHistory.Style.Add("display", "none");
        long returnCode = -1;
        long patientID = -1;
        long taskID = -1;

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        dTIME = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        txtDateTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");


        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        try
        {

            returnCode = new SmartAccessor().GetPatientHistoryPKGEdit(0, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

            if (lstANCPatientDetails.Count > 0)
            {
            }

            var lstFHO = from s in lsthisPHA
                         where s.HistoryID == 1103
                         select s;

            List<EMRAttributeClass> lstFHOtype = (from d in lstFHO
                                                  where d.AttributeID == 130
                                                  select new EMRAttributeClass
                                                  {
                                                      AttributeID = d.AttributeID,
                                                      AttributeName = d.AttributeName,
                                                      AttributevalueID = d.AttributevalueID,
                                                      AttributeValueName = d.AttributeValueName
                                                  }).ToList();

            lstEMRvalue.Name = "On anti-thyroid disease drugs";
            lstEMRvalue.Attributename = "F/H/O DM";
            lstEMRvalue.Attributeid = 130;
            if (lstFHOtype.Count > 0)
            {
                lstEMRvalue.Attributevaluename = lstFHOtype[0].AttributeName;
            }
            if (lstFHO.Count() > 0)
            {
                ddlCheck.DataSource = lstFHO.ToList();
                ddlCheck.DataTextField = "AttributeValueName";
                ddlCheck.DataValueField = "AttributevalueID";
                ddlCheck.DataBind();
            }
            ddlCheck.Items.Insert(0, strSelect.Trim());
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHistory Page Load", ex);
        }




    }

    public void LoadHistoryControl(long visitID, long InvestigationID)
    {

        tblMain.Style.Add("display", "none");
        divviewHistory.Style.Add("display", "none");
        long returnCode = -1;
        long patientID = -1;
        long taskID = -1;
        long InvID = 0;
        Int64.TryParse(hdnInvestigationID.Value, out InvID);
        if (InvID > 0)
        {
        }
        else
        {
            hdnInvestigationID.Value = InvestigationID.ToString();
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        dTIME = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        txtDateTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");


        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        try
        {
            if (visitID > 0 || InvestigationID > 0)
            {
                List<Patient> lstPatient = new List<Patient>();
                Patient patient = new Patient();
                List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping = new List<InvMedicalDetailsMapping>();
                List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping1 = new List<InvMedicalDetailsMapping>();
                List<InvMedicalDetailsMapping> lstInvestigationMappingList = new List<InvMedicalDetailsMapping>();
                Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
                Physician_BL PhysiciansbL = new Physician_BL(new BaseClass().ContextInfo);
                patBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                returnCode = PhysiciansbL.GetInvestigationHistoryDetail(patientID, visitID, InvestigationID, OrgID, TypeValue,out lstInvMedicalDetailsMapping, out lstInvestigationMappingList);




                IEnumerable<InvMedicalDetailsMapping> lstInvHistorylist = (from H in lstInvMedicalDetailsMapping
                                                                           where (lstInvestigationMappingList.Any(I => I.InvID == H.InvID))
                                                                           select H).ToList();


                //lstInvMedicalDetailsMapping1 = lstInvestigationMappingList.Where(c =>   lstInvMedicalDetailsMapping.Contains(c.InvID));

                //  lstInvMedicalDetailsMapping1 = lstInvMedicalDetailsMapping.Contains(c => lstInvestigationMappingList.Contains(c.InvID));
                //  lstInvMedicalDetailsMapping1=lstInvMedicalDetailsMapping.Contains(c =>List lstInvestigationMappingList
                lstInvMedicalDetailsMapping1 = (from s in lstInvMedicalDetailsMapping
                                                where s.MedicalDetailID == 1097
                                                select s).ToList();


                if (lstInvMedicalDetailsMapping.Count > 0)
                {
                    IEnumerable<InvMedicalDetailsMapping> lstInvlist = (from S in lstInvMedicalDetailsMapping
                                                                        group S by new
                                                                        {
                                                                            S.MedicalDetailType,
                                                                            S.InvID,
                                                                            S.MedicalDetailID

                                                                        } into g
                                                                        select new InvMedicalDetailsMapping
                                                                        {
                                                                            MedicalDetailType = g.Key.MedicalDetailType,
                                                                            InvID = g.Key.InvID,
                                                                            MedicalDetailID = g.Key.MedicalDetailID

                                                                        }).Distinct().ToList();

                    foreach (InvMedicalDetailsMapping item1 in lstInvlist)
                    {
                        bStatus = true;
                        tblMain.Style.Add("display", "table");
                        if (item1.MedicalDetailID == 1097)
                        {
                            tr1PatientHistory_LMP_1097.Style.Add("display", "table-row");
                            divchkLMP.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1098)
                        {
                            trFasting_Duration_1098.Style.Add("display", "table-row");
                            divFasting_Duration.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1099)
                        {
                            trLastMealTime_1099.Style.Add("display", "table-row");
                            divLastMealTime.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1100)
                        {
                            trRecent_Sonography_Report_1100.Style.Add("display", "table-row");
                            divRecent_Sonography_Report.Style.Add("display", "block");
                        }

                        else if (item1.MedicalDetailID == 1101)
                        {
                            trurine_volume_Collected_1101.Style.Add("display", "table-row");
                            divurine_volume_Collected.Style.Add("display", "block");
                        }

                        else if (item1.MedicalDetailID == 1102)
                        {
                            trAbstinence_days_1102.Style.Add("display", "table-row");
                            divAbstinence_days.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1103)
                        {
                            trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "table-row");
                            divOn_anti_thyroid_disease_drugs.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1104)
                        {
                            trReading_taken_between_48_72_hrs_1104.Style.Add("display", "table-row");
                            divReading_taken_between_48_72_hrs.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID >0)
                        {
                            trDynamicControlsTable.Style.Add("display", "table-row");
                            tblDynamicControls.Style.Add("display", "table");
                        }
                        else
                        {
                            //tableHistory.Style.Add("display", "none");
                            //tblMain.Style.Add("display", "none");
                            //divStatus.Style.Add("display", "block");
                            //lblStatus.Text = "There is no History for this test";
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "javascript:alert('No History for this test.');", true);

                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHistoryControl Page Load", ex);
        }



    }


    public void LoadHistoryData(long visitID, long InvestigationID)
    {
        string strValidate = Resources.EMR_AppMsg.EMR_His_ascx_10 == null ? "No History for this test." : Resources.EMR_AppMsg.EMR_His_ascx_10;
        tblMain.Style.Add("display", "table");
        divviewHistory.Style.Add("display", "none");
        long returnCode = -1;
        long patientID = -1;
        long taskID = -1;
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        dTIME = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        txtDateTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:sstt");

        hdnInvestigationID.Value = InvestigationID.ToString();

        List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
        List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
        List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
        try
        {
            if (visitID > 0 || InvestigationID > 0)
            {
                List<Patient> lstPatient = new List<Patient>();
                Patient patient = new Patient();
                List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping = new List<InvMedicalDetailsMapping>();
                List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping1 = new List<InvMedicalDetailsMapping>();
                List<InvMedicalDetailsMapping> lstInvestigationMappingList = new List<InvMedicalDetailsMapping>();
                Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
                Physician_BL PhysiciansbL = new Physician_BL(new BaseClass().ContextInfo);

                patBL.GetPatientDetailsPassingVisitID(visitID, out lstPatient);
                returnCode = PhysiciansbL.GetInvestigationHistoryDetail(patientID, visitID, InvestigationID, OrgID,TypeValue, out lstInvMedicalDetailsMapping, out  lstInvestigationMappingList);

                lstInvMedicalDetailsMapping1 = (from s in lstInvMedicalDetailsMapping
                                                where s.MedicalDetailID == 1097
                                                select s).ToList();

              
                if (lstInvMedicalDetailsMapping.Count > 0)
                {
                    hdnInvestigationID.Value = InvestigationID == 0 ? lstInvMedicalDetailsMapping[0].InvID.ToString() : InvestigationID.ToString();
                    IEnumerable<InvMedicalDetailsMapping> lstInvlist = (from S in lstInvMedicalDetailsMapping
                                                                        group S by new
                                                                        {
                                                                            S.MedicalDetailType,
                                                                            S.InvID,
                                                                            S.MedicalDetailID

                                                                        } into g
                                                                        select new InvMedicalDetailsMapping
                                                                        {
                                                                            MedicalDetailType = g.Key.MedicalDetailType,
                                                                            InvID = g.Key.InvID,
                                                                            MedicalDetailID = g.Key.MedicalDetailID

                                                                        }).Distinct().ToList();

                    foreach (InvMedicalDetailsMapping item1 in lstInvlist)
                    {

                        if (item1.MedicalDetailID == 1097)
                        {
                            tr1PatientHistory_LMP_1097.Style.Add("display", "table-row");
                            divchkLMP.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1098)
                        {
                            trFasting_Duration_1098.Style.Add("display", "table-row");
                            divFasting_Duration.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1099)
                        {
                            trLastMealTime_1099.Style.Add("display", "table-row");
                            divLastMealTime.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1100)
                        {
                            trRecent_Sonography_Report_1100.Style.Add("display", "table-row");
                            divRecent_Sonography_Report.Style.Add("display", "block");
                        }

                        else if (item1.MedicalDetailID == 1101)
                        {
                            trurine_volume_Collected_1101.Style.Add("display", "table-row");
                            divurine_volume_Collected.Style.Add("display", "block");
                        }

                        else if (item1.MedicalDetailID == 1102)
                        {
                            trAbstinence_days_1102.Style.Add("display", "table-row");
                            divAbstinence_days.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1103)
                        {
                            trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "table-row");
                            divOn_anti_thyroid_disease_drugs.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID == 1104)
                        {
                            trReading_taken_between_48_72_hrs_1104.Style.Add("display", "table-row");
                            divReading_taken_between_48_72_hrs.Style.Add("display", "block");
                        }
                        else if (item1.MedicalDetailID > 0)
                        {
                            trDynamicControlsTable.Style.Add("display", "none");
                            tblDynamicControls.Style.Add("display", "none"); 
                        }
                        else
                        {
                            tableHistory.Style.Add("display", "none");
                            tblMain.Style.Add("display", "none");
                            divStatus.Style.Add("display", "block");
                            lblStatus.Text = "There is no History for this test";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "ValidationWindow('" + strValidate.Trim() + "," + strAlert.Trim() + "');", true);

                        }

                    }

                    //  returnCode =Physiciansbl.GetInvestigationHistoryDetail(patientID, visitID, 0,OrgID , out lstInvMedicalDetailsMapping);

                    returnCode = new SmartAccessor().GetPatientHistoryPKGEdit(visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails, out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

                    if (lstANCPatientDetails.Count > 0)
                    {
                    }

                    var lstFHO = from s in lsthisPHA
                                 where s.HistoryID == 1103
                                 select s;

                    List<EMRAttributeClass> lstFHOtype = (from d in lstFHO
                                                          where d.AttributeID == 130
                                                          select new EMRAttributeClass
                                                          {
                                                              AttributeID = d.AttributeID,
                                                              AttributeName = d.AttributeName,
                                                              AttributevalueID = d.AttributevalueID,
                                                              AttributeValueName = d.AttributeValueName
                                                          }).ToList();

                    lstEMRvalue.Name = "On anti-thyroid disease drugs";
                    lstEMRvalue.Attributename = "F/H/O DM";
                    lstEMRvalue.Attributeid = 130;
                    lstEMRvalue.Attributevaluename = lstFHOtype[0].AttributeName;

                    ddlCheck.DataSource = lstFHO.ToList();
                    ddlCheck.DataTextField = "AttributeValueName";
                    ddlCheck.DataValueField = "AttributevalueID";
                    ddlCheck.DataBind();
                    ddlCheck.Items.Insert(0, strSelect.Trim());


                }
                else
                {

                    tableHistory.Style.Add("display", "none");
                    tblMain.Style.Add("display", "none");
                    divStatus.Style.Add("display", "block");
                    lblStatus.Text = "No History for this Patient";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey", "ValidationWindow('"+strValidate.Trim()+","+strAlert.Trim()+"');", true);

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }

    public void SaveData(out List<PatientHistoryAttribute> lsthisPHA1, out List<PatientHistory> lstPatientHisPKG1)
    {

        long returncode = -1;
        long patientID = -1;
        long InvID=-1;
        Int64.TryParse(Request.QueryString["vid"], out patientVID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        lsthisPHA1 = new List<PatientHistoryAttribute>();
        lstPatientHisPKG1 = new List<PatientHistory>();
        List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
        List<PatientHistory> lstPatientHisPKG = new List<PatientHistory>();
        List<PatientHistoryAttribute> lstPatientHisPKGAttributes = new List<PatientHistoryAttribute>();

        if (chkLMP.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtLMP.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1097;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "LMP";
                hisPKGTS.Description = "LMP";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var  ValueID  = from s in lsthisPHA
                    //                where s.HistoryID == 1097
                    //                  select s.AttributevalueID ;
                    //var  AttriID = from s in lsthisPHA
                    //              where s.HistoryID == 1097
                    //              select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1097;
                    hisPKGAttTS1.AttributeID = 123; //123
                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttTS1.AttributeValueName = txtLMP.Text; 
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }
            }
        }



        if (ChkFasting_Duration.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtHours.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1098;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "Fasting Duration (hours)";
                hisPKGTS.Description = "Fasting Duration (hours)";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1098
                    //              select s.AttributevalueID;
                    var AttriID = from s in lsthisPHA
                                  where s.HistoryID == 1098
                                  select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1098;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(124); //124
                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttTS1.AttributeValueName = txtHours.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }
            }
        }


        if (ChkLastMealTime.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtDateTime.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1099;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "Last Meal Time";
                hisPKGTS.Description = "Last Meal Time";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1099
                    //              select s.AttributevalueID;
                    var AttriID = from s in lsthisPHA
                                  where s.HistoryID == 1099
                                  select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1099;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(125); //125
                    hisPKGAttTS1.AttributevalueID = 0;
                    hisPKGAttTS1.AttributeValueName = txtDateTime.Text;
                    Int64.TryParse(hdnInvestigationID.Value, out InvID);
                    hisPKGAttTS1.InvestigationID = InvID;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }
            }
        }


        if (ChkRecent_Sonography_Report.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtRecent_Sonography_ReportDate.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1100;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "Recent Sonography Report";
                hisPKGTS.Description = "Recent Sonography Report";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1100
                    //              select s.AttributevalueID;
                    var AttriID = from s in lsthisPHA
                                  where s.HistoryID == 1100
                                  select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1100;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(126); //126
                    hisPKGAttTS1.AttributevalueID = 0;
                    hisPKGAttTS1.AttributeValueName = txtRecent_Sonography_ReportDate.Text + "~" + txtRecent_Sonography_ReportComments.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }
            }
        }


        if (chkurine_volume_Collected.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if ((txtHeight.Text != "") || (txtWeight.Text != ""))
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1101;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "24h urine volume Collected in ml";
                hisPKGTS.Description = "24h urine volume Collected in ml";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();

                //Height
                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1101
                    //              select s.AttributevalueID;
                    var AttriID = from s in lsthisPHA
                                  where s.HistoryID == 1101 && s.AttributeName == "Height"
                                  select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1101;
                    if ((txtHeight.Text != ""))
                    {
                        hisPKGAttTS1.AttributeID = Convert.ToInt64(127); //127
                        hisPKGAttTS1.AttributevalueID = 0;
                        hisPKGAttTS1.AttributeValueName = txtHeight.Text;
                    }
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }


                //Weight
                if (txtWeight.Text != "")
                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1101
                    //              select s.AttributevalueID;
                    //var AttriID = from s in lsthisPHA
                    //              where s.HistoryID == 1101 && s.AttributeName == "Weight"
                    //              select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1101;
                    if ((txtWeight.Text != "") && (Convert.ToInt64(128) == 128))
                    {
                        hisPKGAttTS1.AttributeID = Convert.ToInt64(128); //128
                        hisPKGAttTS1.AttributevalueID = 0;
                        hisPKGAttTS1.AttributeValueName = txtWeight.Text;
                    }
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }


            }
        }


        if (ChkAbstinence_days.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtAbstinence_days.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1102;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "Abstinence days";
                hisPKGTS.Description = "Abstinence days";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1102
                    //              select s.AttributevalueID;
                    //var AttriID = from s in lsthisPHA
                    //              where s.HistoryID == 1102
                    //              select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1102;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(129); //129
                    hisPKGAttTS1.AttributevalueID = 0;
                    hisPKGAttTS1.AttributeValueName = txtAbstinence_days.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);

                }
            }
        }


        if (ChkOn_anti_thyroid_disease_drugs.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (ddlCheck.SelectedItem.Text != "" && ddlCheck.SelectedItem.Text != "-- - Select-- - ")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1103;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "On anti-thyroid disease drugs";
                hisPKGTS.Description = "On anti-thyroid disease drugs";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();


                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1103
                    //              select s.AttributevalueID;
                    var AttriID = from s in lsthisPHA
                                  where s.HistoryID == 1103
                                  select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1103;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(130); //130
                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(ddlCheck.SelectedValue);
                    hisPKGAttTS1.AttributeValueName = ddlCheck.SelectedItem.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


                }
            }
        }



        if (ChkReading_taken_between_48_72_hrs.Checked == true)
        {

            PatientHistory hisPKGTS = new PatientHistory();
            if (txtFreeText.Text != "")
            {
                hisPKGTS.PatientVisitID = patientVID;
                hisPKGTS.HistoryID = 1104;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = "Reading taken between 48hrs - 72 hrs";
                hisPKGTS.Description = "Reading taken between 48hrs - 72 hrs";
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();
                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1104
                    //              select s.AttributevalueID;
                    //var AttriID = from s in lsthisPHA
                    //              where s.HistoryID == 1104
                    //              select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = 1104;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(0); //130
                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttTS1.AttributeValueName = txtFreeText.Text;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


                }
            }
        }

        if (!string.IsNullOrEmpty(hdnPatientHistoryAttribute.Value))
        {
            //ConvertHTMLTablesToDataSet("tblDynamicControls");
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<PatientHistoryAttribute> lstPatientHistoryAttribute = new List<PatientHistoryAttribute>();
            string strLstPatientHistoryAttribute = hdnPatientHistoryAttribute.Value;
            lstPatientHistoryAttribute = serializer.Deserialize<List<PatientHistoryAttribute>>(strLstPatientHistoryAttribute);

           // PatientHistory hisPKGTS = new PatientHistory();
           foreach(PatientHistoryAttribute lstHistory in lstPatientHistoryAttribute)
            {
                PatientHistory hisPKGTS = new PatientHistory();
               int HistoryID;
                hisPKGTS.PatientVisitID = patientVID;
                Int32.TryParse(lstHistory.HistoryID.ToString(), out HistoryID);
                hisPKGTS.HistoryID = HistoryID;
                hisPKGTS.ComplaintId = 0;
                hisPKGTS.HistoryName = lstHistory.HistoryName;
                hisPKGTS.Description = lstHistory.HistoryName;
                lstPatientHisPKG.Add(hisPKGTS);
                List<PatientHistoryAttribute> lsthisAttributes = new List<PatientHistoryAttribute>();
                {
                    PatientHistoryAttribute hisPKGAttTS1 = new PatientHistoryAttribute();

                    //var ValueID = from s in lsthisPHA
                    //              where s.HistoryID == 1104
                    //              select s.AttributevalueID;
                    //var AttriID = from s in lsthisPHA
                    //              where s.HistoryID == 1104
                    //              select s.AttributeID;

                    hisPKGAttTS1.PatientVisitID = patientVID;
                    hisPKGAttTS1.HistoryID = lstHistory.HistoryID;
                    hisPKGAttTS1.AttributeID = Convert.ToInt64(0); //130
                    hisPKGAttTS1.AttributevalueID = Convert.ToInt64(0);
                    hisPKGAttTS1.AttributeValueName = lstHistory.AttributeValueName;
                    lstPatientHisPKGAttributes.Add(hisPKGAttTS1);


                }
            } 

        }


        try
        {
            if (lstPatientHisPKG.Count > 0)
            {
                lstPatientHisPKG1 = lstPatientHisPKG;
                lsthisPHA1 = lstPatientHisPKGAttributes;
                returncode = patientBL.SaveEMRHistory(lstPatientHisPKG, lstPatientHisPKGAttributes, LID, patientVID, patientID);


                if (returncode > 0)
                {      
                        //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Changes saved successfully.');", true);
                        hdnSaveHisStatus.Value = "Save";
                        bStatus = true;
                        ViewHistoryData(patientVID);  
                }
            }
            else
            {
                bStatus = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hhh", "javascript:alert('Please enter History details');", true);
                Clearvalues();
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Save PatientHistory in His.ascx page", ex);

        }

    }


    public void EditHistoryData(long visitID, long InvestigationID)
    {
        long patientID = -1;
        long taskID = -1;
        long returnCode = -1;

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "none");
        divOn_anti_thyroid_disease_drugs.Style.Add("display", "none");

        trFasting_Duration_1098.Style.Add("display", "none");
        divFasting_Duration.Style.Add("display", "none");

        trLastMealTime_1099.Style.Add("display", "none");
        divLastMealTime.Style.Add("display", "none");

        trRecent_Sonography_Report_1100.Style.Add("display", "none");
        divRecent_Sonography_Report.Style.Add("display", "none");

        trurine_volume_Collected_1101.Style.Add("display", "none");
        divurine_volume_Collected.Style.Add("display", "none");

        trAbstinence_days_1102.Style.Add("display", "none");
        divAbstinence_days.Style.Add("display", "none");

        trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "none");
        divOn_anti_thyroid_disease_drugs.Style.Add("display", "none");

        trReading_taken_between_48_72_hrs_1104.Style.Add("display", "none");
        divReading_taken_between_48_72_hrs.Style.Add("display", "none");

        trDynamicControlsTable.Style.Add("display", "none");
        tblDynamicControls.Style.Add("display", "none");

 
        try
        {
            if (visitID > 0 != null)
            {

                List<PatientHistoryAttribute> lstPatHisAttribute = new List<PatientHistoryAttribute>();
                List<PatientHistoryAttribute> lsthisPHA = new List<PatientHistoryAttribute>();
                List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                List<GPALDetails> lstGPALDetails = new List<GPALDetails>();
                List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
                List<PatientPastVaccinationHistory> lstPatientPastVaccinationHistory = new List<PatientPastVaccinationHistory>();
                List<PatientComplaintAttribute> lstPCA = new List<PatientComplaintAttribute>();
                List<PatientComplaintAttribute> lsthisPCA = new List<PatientComplaintAttribute>();
                List<SurgicalDetail> lstSurgicalDetails = new List<SurgicalDetail>();
                List<InvMedicalDetailsMapping> lstInvMedicalDetailsMapping2 = new List<InvMedicalDetailsMapping>();

                returnCode = new SmartAccessor().GetPatientHistoryPKGEdit
                   (visitID, out lstPatHisAttribute, out lstDrugDetails, out lstGPALDetails, out lstANCPatientDetails,
                   out lstPatientPastVaccinationHistory, out lstPCA, out lstSurgicalDetails, out lsthisPCA, out lsthisPHA);

                LoadHistoryControl(visitID, InvestigationID);

                if (lstPatHisAttribute.Count > 0)
                {

                    for (int i = 0; i < lstPatHisAttribute.Count; i++)
                    {

                        if (lstPatHisAttribute[i].HistoryID == 1097)
                        {
                            tr1PatientHistory_LMP_1097.Style.Add("display", "table-row");
                            divchkLMP.Style.Add("display", "block");
                            chkLMP.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 123)
                            //{
                            txtLMP.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }

                        else if (lstPatHisAttribute[i].HistoryID == 1098)
                        {
                            trFasting_Duration_1098.Style.Add("display", "table-row");
                            divFasting_Duration.Style.Add("display", "block");
                            ChkFasting_Duration.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 124)
                            //{
                            txtHours.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }

                        else if (lstPatHisAttribute[i].HistoryID == 1099)
                        {
                            trLastMealTime_1099.Style.Add("display", "table-row");
                            divLastMealTime.Style.Add("display", "block");
                            ChkLastMealTime.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 125)
                            //{
                            txtDateTime.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }
                        else if (lstPatHisAttribute[i].HistoryID == 1100)
                        {
                            trRecent_Sonography_Report_1100.Style.Add("display", "table-row");
                            divRecent_Sonography_Report.Style.Add("display", "block");
                            ChkRecent_Sonography_Report.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 126)
                            //{
                            txtRecent_Sonography_ReportDate.Text = lstPatHisAttribute[i].AttributeValueName.ToString().Split('-')[0];
                            txtRecent_Sonography_ReportComments.Text = lstPatHisAttribute[i].AttributeValueName.ToString().Split('-')[1];
                            // }
                        }

                        else if (lstPatHisAttribute[i].HistoryID == 1101)
                        {
                            trurine_volume_Collected_1101.Style.Add("display", "table-row");
                            divurine_volume_Collected.Style.Add("display", "block");
                            chkurine_volume_Collected.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 127)
                            //{
                            txtHeight.Text = lstPatHisAttribute[i].AttributeValueName.ToString().Split('-')[0];
                            //}
                            //if (lstPatHisAttribute[i].AttributeID == 128)
                            //{
                            txtWeight.Text = lstPatHisAttribute[i].AttributeValueName.ToString().Split('-')[1];
                            //}
                        }

                        else if (lstPatHisAttribute[i].HistoryID == 1102)
                        {
                            trAbstinence_days_1102.Style.Add("display", "table-row");
                            divAbstinence_days.Style.Add("display", "block");
                            ChkAbstinence_days.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 129)
                            //{
                            txtAbstinence_days.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }

                        else if (lstPatHisAttribute[i].HistoryID == 1103)
                        {
                            trOn_anti_thyroid_disease_drugs_1103.Style.Add("display", "table-row");
                            divOn_anti_thyroid_disease_drugs.Style.Add("display", "block");
                            ChkOn_anti_thyroid_disease_drugs.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 130)
                            //{
                            ddlCheck.SelectedValue = lstPatHisAttribute[i].AttributevalueID.ToString();
                            //}
                        }
                        else if (lstPatHisAttribute[i].HistoryID == 1104)
                        {
                            trReading_taken_between_48_72_hrs_1104.Style.Add("display", "table-row");
                            divReading_taken_between_48_72_hrs.Style.Add("display", "block");
                            ChkReading_taken_between_48_72_hrs.Checked = true;

                            //if (lstPatHisAttribute[i].AttributeID == 0)
                            //{
                            txtFreeText.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }
                        else if (lstPatHisAttribute[i].HistoryID > 0)
                        {
                            trDynamicControlsTable.Style.Add("display", "table-row");
                            tblDynamicControls.Style.Add("display", "block");
                             
                            HtmlTable myTable = new HtmlTable();
                           
                            var ChkID = lstPatHisAttribute[i].InvestigationID + "_" + lstPatHisAttribute[i].HistoryID + "_chk";
                            var TxtID = lstPatHisAttribute[i].InvestigationID + "_" + lstPatHisAttribute[i].HistoryID + "_txt";
                            var Spn = lstPatHisAttribute[i].InvestigationID + "_" + lstPatHisAttribute[i].HistoryID + "_spn";
                            var HdnID1 = lstPatHisAttribute[i].InvestigationID + "_" + lstPatHisAttribute[i].HistoryID + "_h1";
                            var HdnID2 = lstPatHisAttribute[i].InvestigationID + "_" + lstPatHisAttribute[i].HistoryID + "_h2";

                            HtmlInputCheckBox Chk = new HtmlInputCheckBox();
                            Chk.ID = ChkID;
                            Chk.Checked = true;
     
                            HtmlInputText txt = new HtmlInputText();
                            txt.ID = TxtID;
                            txt.Value = lstPatHisAttribute[i].AttributeValueName.ToString(); ;

                            HtmlInputHidden Hdn1 = new HtmlInputHidden();
                            Hdn1.ID = HdnID1;
                            Hdn1.Value = lstPatHisAttribute[i].HistoryName;

                            HtmlInputHidden Hdn2 = new HtmlInputHidden();
                            Hdn2.ID = HdnID2;
                            Hdn2.Value = lstPatHisAttribute[i].HistoryID.ToString();


                            HtmlTableRow row = new HtmlTableRow();
                           
                            HtmlTableCell cel = new HtmlTableCell();
                            cel.Controls.Add(Chk);
                            
                            HtmlTableCell cel1 = new HtmlTableCell();
                            cel1.InnerHtml = lstPatHisAttribute[i].HistoryName; 

                            HtmlTableCell cel2 = new HtmlTableCell();
                            cel2.Controls.Add(txt);
                            
                            HtmlTableCell cel3 = new HtmlTableCell();
                            cel3.Controls.Add(Hdn1);

                            HtmlTableCell cel4 = new HtmlTableCell();
                            cel4.Controls.Add(Hdn2);

                            

                            row.Cells.Add(cel);
                            row.Cells.Add(cel1);
                            row.Cells.Add(cel2);
                            row.Cells.Add(cel3);
                            row.Cells.Add(cel4); 
                            tblDynamicControls.Rows.Add(row);

                             
                            //if (lstPatHisAttribute[i].AttributeID == 0)
                            //{
                           // txtFreeText.Text = lstPatHisAttribute[i].AttributeValueName.ToString();
                            //}
                        }

                    }
                    bStatus = true;
                }




            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in EditHistoryData PatientHistory in His.ascx page", ex);
        }

    }

    #endregion
}
