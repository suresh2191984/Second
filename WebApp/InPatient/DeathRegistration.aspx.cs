using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Linq;

public partial class InPatient_DeathRegistration : BasePage
{
    public InPatient_DeathRegistration()
        : base("InPatient\\DeathRegistration.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #region Declaration_Region

    List<PlaceOfDeath> lstPlaceOfDeath = new List<PlaceOfDeath>();
    List<TypeOfDeath> lstTypeOfDeath = new List<TypeOfDeath>();
    List<CauseOfDeathMaster> lstCauseOfDeathMaster = new List<CauseOfDeathMaster>();
    List<LifeSupportMaster> lstLifeSupportMaster = new List<LifeSupportMaster>();
    List<Organ> lstOrgan = new List<Organ>();
    List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
    List<DeathRegistration> lstDeathRegistration = new List<DeathRegistration>();
    List<CauseOfDeath> lstCauseOfDeath = new List<CauseOfDeath>();
    List<CauseOfDeath> lstPCOD = new List<CauseOfDeath>();
    List<CauseOfDeath> lstSCOD = new List<CauseOfDeath>();
    List<CauseOfDeath> lstACOD = new List<CauseOfDeath>();
    List<OrganRegWithMapping> lstOrgRegWithMapping = new List<OrganRegWithMapping>();

    List<PatientHistory> lstPatientHis = new List<PatientHistory>();
    List<PatientHistoryAttribute> lstPatientHisAttributes = new List<PatientHistoryAttribute>();

    #region This region is used for getting patient current details
    List<Patient> lstPatient = new List<Patient>();
    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<PatientVitals> lstVitalsCount = new List<PatientVitals>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();

    List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();

    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstCaseRecordIPTreatmentPlan = new List<IPTreatmentPlan>();

    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();
    #endregion

    IP_BL objIP_BL ;
    long patientVisitID = -1;
    long patientID = -1;
    long retCode = -1;
    string pType = string.Empty;
    
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        objIP_BL = new IP_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();

            hdnType.Value = "I";
            GetDeathRegData();
            GetMLCDetails();
            GetIPOrganDonation();
            GetDeathRegForUpdate();
            GetDischargeSummary();
            GetFCKPath();
            ComplaintICDCode1.ComplaintHeader = "Cause of death";
            ComplaintICDCode1.SetWidth(500);
            ComplaintICDCodeBP1.ComplaintHeader = "Cause of death";
            ComplaintICDCodeBP1.SetWidth(500);
            CODICDCode1.ComplaintHeader = "Cause of death";
            CODICDCode1.SetWidth(500);
        }
    }


    private void GetDischargeSummary()
    {
        try
        {
            long returnCode = -1;
            IP_BL oIP_BL = new IP_BL(base.ContextInfo);

            returnCode = oIP_BL.GetDischargeSummary(patientVisitID, OrgID, out lstPatient, out lstOperationNotes, out lstPatientHistory, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientComplaint, out lstDrugDetails, out lstIPTreatmentPlan, out lstPatientAdvice, out lstCaseRecordIPTreatmentPlan, out lstVitalsCount,out lstInPatientNumber);
            if (returnCode == 0)
            {


                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].BloodGroup != null)
                    {
                        if (lstPatient[0].BloodGroup.ToString() != "-1")
                        {
                            lblBloodgroup.Text = lstPatient[0].BloodGroup.ToString();
                        }
                        else
                        {
                            lblBloodgroup.Text = "Not Yet Tested";
                        }
                    }
                    lblDateOfAdmission.Text = lstPatient[0].CreatedAt.ToString();

                }

                if (lstPatientHistory.Count > 0)
                {
                    foreach (var oPatientHistory in lstPatientHistory)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = oPatientHistory.HistoryName;
                        row1.Cells.Add(cell1);
                        row1.Font.Bold = false;
                        row1.Style.Add("color", "#000");
                        tbPresentHistory.Rows.Add(row1);
                    }
                }

                if (lstBackgroundProblem.Count > 0)
                {
                    foreach (var oBackgroundProblem in lstBackgroundProblem)
                    {
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = oBackgroundProblem.ComplaintName;
                        row1.Cells.Add(cell1);
                        row1.Font.Bold = false;
                        row1.Style.Add("color", "#000");
                        tbPasthistory.Rows.Add(row1);
                    }
                }
                
               

               
                if (lstIPTreatmentPlan.Count > 0)
                {
                    TableRow rowH = new TableRow();
                    TableCell cellH1 = new TableCell();
                    TableCell cellH2 = new TableCell();
                    TableCell cellH3 = new TableCell();
                    TableCell cellH4 = new TableCell();
                    TableCell cellH5 = new TableCell();
                    cellH1.Attributes.Add("align", "left");
                    cellH1.Text = "Type";
                    cellH2.Attributes.Add("align", "left");
                    cellH2.Text = "Treatment Name";
                    cellH3.Attributes.Add("align", "left");
                    cellH3.Text = "Prosthesis";
                    cellH4.Attributes.Add("align", "left");
                    cellH4.Text = "Physician Name";
                    cellH5.Attributes.Add("align", "left");
                    cellH5.Text = "Date";
                    rowH.Cells.Add(cellH1);
                    rowH.Cells.Add(cellH2);
                    rowH.Cells.Add(cellH3);
                    rowH.Cells.Add(cellH4);
                    rowH.Cells.Add(cellH5);
                    rowH.Font.Bold = true;

                    rowH.Style.Add("color", "#000");
                    tblSurgeryDetail.Rows.Add(rowH);

                    foreach (var oIPTreatmentPlan in lstIPTreatmentPlan)
                    {

                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell3 = new TableCell();
                        TableCell cell4 = new TableCell();
                        TableCell cell5 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = oIPTreatmentPlan.ParentName;
                        cell2.Attributes.Add("align", "left");
                        cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;

                        if (oIPTreatmentPlan.Prosthesis == "")
                        {
                            cell3.Attributes.Add("align", "left");
                            cell3.Text = "-";
                        }
                        else
                        {
                            cell3.Attributes.Add("align", "left");
                            cell3.Text = oIPTreatmentPlan.Prosthesis;
                        }


                        cell4.Attributes.Add("align", "left");
                        cell4.Text = oIPTreatmentPlan.PhysicianName;
                        if (oIPTreatmentPlan.FromTime == DateTime.MinValue)
                        {
                            cell5.Attributes.Add("align", "left");
                            cell5.Text = "-";
                        }
                        else
                        {
                            cell5.Attributes.Add("align", "left");
                            cell5.Text = oIPTreatmentPlan.FromTime.ToString();
                        }
                        row1.Cells.Add(cell1);
                        row1.Cells.Add(cell2);
                        row1.Cells.Add(cell3);
                        row1.Cells.Add(cell4);
                        row1.Cells.Add(cell5);

                        row1.Style.Add("color", "#000");
                        tblSurgeryDetail.Rows.Add(row1);
                    }
                }

            }

        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error while loading GetDeathSummary in GetDeathSummary.aspx", ex);
        }

    }

    public void GetIPOrganDonation()
    {
        retCode = -1;
        retCode = objIP_BL.GetIPOrganDonation(patientID, out lstOrgRegWithMapping);
        if (lstOrgRegWithMapping.Count > 0)
        {
            chkOD.Checked = true;
            trODBlock.Style.Add("display", "block");
            trODBlock1.Style.Add("display", "block");
            int i = 300;
            hdnOD.Value = "";
            foreach (OrganRegWithMapping objOrgan in lstOrgRegWithMapping)
            {
                hdnOD.Value += i + "~" + objOrgan.OrganID + "~" + objOrgan.OrganName + "~" + objOrgan.OrganRegWith + "^";
                i += 1;
            }

        }
        else
        {
            trODBlock.Style.Add("display", "none");
            trODBlock1.Style.Add("display", "none");
        }
    }

    public void GetMLCDetails()
    {
        retCode = -1;
        retCode = objIP_BL.GetMLCDetails(patientVisitID, out lstRTAMLCDetails);
        if (lstRTAMLCDetails.Count > 0)
        {


            trRTABlock.Style.Add("display", "block");

            chkRTA.Checked = true;
            foreach (RTAMLCDetails objRTAMLC in lstRTAMLCDetails)
            {
                if (objRTAMLC.AlcoholDrugInfluence == "Y")
                {
                    chkRTAInfluenceOfDrugs.Checked = true;
                }
                if (objRTAMLC.RTAMLCDate != null)
                {
                    txtRTADate.Text = objRTAMLC.RTAMLCDate.ToString();
                }
                if (objRTAMLC.FIRDate != DateTime.MinValue)
                {
                    txtFIRDate.Text = objRTAMLC.FIRDate.ToString();
                }
                txtRTAFIRNo.Text = objRTAMLC.FIRNo;
                txtRTALocation.Text = objRTAMLC.Location;
                txtPoliceStation.Text = objRTAMLC.PoliceStation;
                txtMLCNo.Text = objRTAMLC.MLCNo;
            }
        }
    }

    public void GetDeathRegData()
    {
        retCode = -1;
        retCode = objIP_BL.GetDeathRegData(OrgID, out lstPlaceOfDeath, out lstTypeOfDeath, out lstCauseOfDeathMaster, out lstLifeSupportMaster, out lstOrgan);


        if (lstPlaceOfDeath.Count > 0)
        {
            ddlPOC.DataSource = lstPlaceOfDeath;
            ddlPOC.DataTextField = "PlaceName";
            ddlPOC.DataValueField = "PlaceOfDeathID";
            ddlPOC.DataBind();
            ddlPOC.Items.Insert(0, "-----Select-----");
            ddlPOC.Items[0].Value = "0";
        }


        if (lstTypeOfDeath.Count > 0)
        {
            ddlTOD.DataSource = lstTypeOfDeath;
            ddlTOD.DataTextField = "DeathTypeName";
            ddlTOD.DataValueField = "DeathTypeID";
            ddlTOD.DataBind();
            ddlTOD.Items.Insert(0, "-----Select-----");
            ddlTOD.Items[0].Value = "0";
        }

        //if (lstCauseOfDeathMaster.Count > 0)
        //{
        //    ddlType.DataSource = lstCauseOfDeathMaster;
        //    ddlType.DataTextField = "CauseOfDeathType";
        //    ddlType.DataValueField = "CauseOfDeathTypeID";
        //    ddlType.DataBind();
          
        //}

        if (lstLifeSupportMaster.Count > 0)
        {
            ddlTOLS.DataSource = lstLifeSupportMaster;
            ddlTOLS.DataTextField = "LifeSupportName";
            ddlTOLS.DataValueField = "LifeSupportID";
            ddlTOLS.DataBind();
            ddlTOLS.Items.Insert(0, "-----Select-----");
            ddlTOLS.Items[0].Value = "0";
        }

        if (lstOrgan.Count > 0)
        {
           
            trODBlock.Style.Add("display", "block");
            trODBlock1.Style.Add("display", "block");
            ddlOrgReg.DataSource = lstOrgan;
            ddlOrgReg.DataTextField = "OrganName";
            ddlOrgReg.DataValueField = "OrganID";
            ddlOrgReg.DataBind();
          
        }
    }

    public void GetDeathRegForUpdate()
    {
        retCode = -1;
        retCode = objIP_BL.GetDeathRegForUpdate(patientVisitID, out lstDeathRegistration,out lstCauseOfDeath, out lstPatientHisAttributes);

        if (lstDeathRegistration.Count > 0)
        {
            hdnType.Value = "U";
            txtDOD.Text = lstDeathRegistration[0].DOD.ToString();
            ddlPOC.SelectedValue = lstDeathRegistration[0].PlaceOfDeathID.ToString();
            if (ddlPOC.SelectedItem.Text == "Others")
            {
                divddlPOC.Style.Add("display", "block");
                txtPOCOthers.Text=lstDeathRegistration[0].PlaceOfDeathDes;
                
            }

            ddlTOD.SelectedValue = lstDeathRegistration[0].DeathTypeID.ToString();

            if (ddlTOD.SelectedItem.Text == "Others")
            {
                divddlTOD.Style.Add("display", "block");
                txtTODOthers.Text = lstDeathRegistration[0].DeathTypeDes;
            }

            if (lstDeathRegistration[0].IsPregnancy.Trim() == "Y")
            {
                chkPregnancy.Checked = true;
                divchkPregnancy.Style.Add("display", "block");
            }           

            if (lstDeathRegistration[0].PregnancyStatus == "Delivered")
            {
                divddlPregnancyType.Style.Add("display", "block");
                ddlPregnancyType.SelectedValue = "2";
                txtDelivered.Text = lstDeathRegistration[0].PregnancyDescription;
            }

            if (lstDeathRegistration[0].IsResuscitation.Trim() == "Y")
            {
                chkResuscitation.Checked = true;                
            }
            ddlTOLS.SelectedValue = lstDeathRegistration[0].LifeSupportID.ToString();

            if (lstDeathRegistration[0].IsROSC.Trim() == "Y")
            {
                chkROSC.Checked = true;
            }

            txtROSC.Text = lstDeathRegistration[0].RoscDescription;

            fckHospitalCourse.Value = lstDeathRegistration[0].HospitalCourse;
            txtProcedures.Text = lstDeathRegistration[0].ProcedureDesc;
           
        }
        


        if (lstCauseOfDeath.Count > 0)
        {
            var PCOD = from lstPCOD in lstCauseOfDeath
                       where lstPCOD.CauseOfDeathType == "CODP"
                       select lstPCOD;
            List<CauseOfDeath> lstPC = PCOD.ToList<CauseOfDeath>();

            ComplaintICDCode1.SetCauseOfDeath(lstPC);


            var SCOD = from lstSCOD in lstCauseOfDeath
                       where lstSCOD.CauseOfDeathType == "CODS"
                       select lstSCOD;
            List<CauseOfDeath> lstSC = SCOD.ToList<CauseOfDeath>();
            ComplaintICDCodeBP1.SetCauseOfDeath(lstSC);



            var ACOD = from lstACOD in lstCauseOfDeath
                       where lstACOD.CauseOfDeathType == "CODA"
                       select lstACOD;
            List<CauseOfDeath> lstAC = ACOD.ToList<CauseOfDeath>();
            CODICDCode1.SetCauseOfDeath(lstAC);

            //int i = 500;
            //hdnCOD.Value = "";
            //foreach (CauseOfDeath objCOD in lstCauseOfDeath)
            //{
            //    hdnCOD.Value += i + "~" + objCOD.CauseOfDeathTypeID + "~" + objCOD.CauseOfDeathType + "~" + objCOD.Description + "^";
            //    i += 1;
            //}

        }

        if (lstPatientHisAttributes.Count > 0)
        {
            for (int i = 0; i < lstPatientHisAttributes.Count; i++)
            {
                if (lstPatientHisAttributes[i].HistoryID == 476)
                {
                    divchkSmoking_476.Style.Add("display", "block");
                    chkSmoking_476.Checked = true;


                    if (lstPatientHisAttributes[i].AttributeID == 2)
                    {
                        txtDurationTS.Text = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlDurationTS.SelectedValue = lstPatientHisAttributes[i].AttributevalueID.ToString();
                    }
                    if (lstPatientHisAttributes[i].AttributeID == 3)
                    {
                        txtPacksTS_9.Text = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[0].ToString();
                     
                    }
                }


                if (lstPatientHisAttributes[i].HistoryID == 369)
                {
                    divchkAlcohol_369.Style.Add("display", "block");
                    chkAlcohol_369.Checked = true;


                    if (lstPatientHisAttributes[i].AttributeID == 5)
                    {
                        txtDurationAC.Text = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlDurationAC.SelectedValue = lstPatientHisAttributes[i].AttributevalueID.ToString();
                    }
                    if (lstPatientHisAttributes[i].AttributeID == 6)
                    {
                        txtQtyAC.Text = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlmlDoW.SelectedValue = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[1].ToString();
                    }
                }


                if (lstPatientHisAttributes[i].HistoryID == 1068)
                {
                    divchkTobaccochewing_1068.Style.Add("display", "block");
                    chkTobaccochewing_1068.Checked = true;


                    if (lstPatientHisAttributes[i].AttributeID ==25)
                    {
                        txtQty_72.Text = lstPatientHisAttributes[i].AttributeValueName.ToString();
                    }
                    if (lstPatientHisAttributes[i].AttributeID == 24)
                    {

                        txtDuration_24.Text = lstPatientHisAttributes[i].AttributeValueName.Split(' ')[0].ToString();
                        ddlDurationt_24.SelectedValue = lstPatientHisAttributes[i].AttributevalueID.ToString();

                    }
                }


                if (lstPatientHisAttributes[i].HistoryID == 411)
                {
                    divchkIllicitdrugs_411.Style.Add("display", "block");
                    chkIllicitdrugs_411.Checked = true;
                    if (lstPatientHisAttributes[i].AttributeID == 26)
                    {
                        ddlType_26.SelectedValue = lstPatientHisAttributes[i].AttributevalueID.ToString();

                        if (ddlType_26.SelectedItem.Text == "Others")
                        {
                            divddlType_26.Style.Add("display", "block");
                            txtOthersTypeID_26.Text = lstPatientHisAttributes[i].AttributeValueName.ToString();
                        }


                    }
                    
                }

            }
        }

    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        
        lstCauseOfDeath = GetCauseOfDeath();

        #region Backrountproblem

        if (chkTobaccochewing_1068.Checked == true)
        {
            PatientHistory hisPKGTC = new PatientHistory();
            hisPKGTC.HistoryID = 1068;
            hisPKGTC.ComplaintId = 0;
            hisPKGTC.PatientVisitID = patientVisitID;
            hisPKGTC.Description = chkTobaccochewing_1068.Text;
            hisPKGTC.HistoryName = chkTobaccochewing_1068.Text;

            lstPatientHis.Add(hisPKGTC);


            if (txtDuration_24.Text != "")
            {
                PatientHistoryAttribute hisAttDurationTC1 = new PatientHistoryAttribute();

                hisAttDurationTC1.PatientVisitID = patientVisitID;
                hisAttDurationTC1.HistoryID = 1068;
                hisAttDurationTC1.AttributeID = 24;
                hisAttDurationTC1.AttributevalueID = Convert.ToInt64(ddlDurationt_24.SelectedValue); ;
                hisAttDurationTC1.AttributeValueName = txtDuration_24.Text + " " + ddlDurationt_24.SelectedItem.Text;

                lstPatientHisAttributes.Add(hisAttDurationTC1);
            }

            if (txtQty_72.Text != "")
            {
                PatientHistoryAttribute hisPKGAttQtyTC = new PatientHistoryAttribute();

                hisPKGAttQtyTC.PatientVisitID = patientVisitID;
                hisPKGAttQtyTC.HistoryID = 1068;
                hisPKGAttQtyTC.AttributeID = 25;
                hisPKGAttQtyTC.AttributevalueID = 72;
                hisPKGAttQtyTC.AttributeValueName = txtQty_72.Text;

                lstPatientHisAttributes.Add(hisPKGAttQtyTC);
            }

        }

        if (chkSmoking_476.Checked == true)
        {
            PatientHistory hisPKGTS = new PatientHistory();

            hisPKGTS.HistoryID = 476;
            hisPKGTS.ComplaintId = 0;
            hisPKGTS.PatientVisitID = patientVisitID;
            hisPKGTS.Description = chkSmoking_476.Text;
            hisPKGTS.HistoryName = chkSmoking_476.Text;

            lstPatientHis.Add(hisPKGTS);

            if (txtDurationTS.Text != "")
            {
                PatientHistoryAttribute hisPKGAttTS2 = new PatientHistoryAttribute();

                hisPKGAttTS2.PatientVisitID = patientVisitID;
                hisPKGAttTS2.HistoryID = 476;
                hisPKGAttTS2.AttributeID = 2;
                hisPKGAttTS2.AttributevalueID = Convert.ToInt64(ddlDurationTS.SelectedValue); ;
                hisPKGAttTS2.AttributeValueName = txtDurationTS.Text + " " + ddlDurationTS.SelectedItem.Text;

                lstPatientHisAttributes.Add(hisPKGAttTS2);
            }

            if (txtPacksTS_9.Text != "")
            {
                PatientHistoryAttribute hisPKGAttTS3 = new PatientHistoryAttribute();

                hisPKGAttTS3.PatientVisitID = patientVisitID;
                hisPKGAttTS3.HistoryID = 476;
                hisPKGAttTS3.AttributeID = 3;
                hisPKGAttTS3.AttributevalueID = 9;
                hisPKGAttTS3.AttributeValueName = txtPacksTS_9.Text + " " + lblPacksTS.Text;

                lstPatientHisAttributes.Add(hisPKGAttTS3);
            }
        }


        if (chkAlcohol_369.Checked == true)
        {
            PatientHistory hisPKGAC = new PatientHistory();

            hisPKGAC.HistoryID = 369;
            hisPKGAC.ComplaintId = 0;
            hisPKGAC.PatientVisitID = patientVisitID;
            hisPKGAC.Description = chkAlcohol_369.Text;
            hisPKGAC.HistoryName = chkAlcohol_369.Text;
            lstPatientHis.Add(hisPKGAC);


            if (txtDurationAC.Text != "")
            {
                PatientHistoryAttribute hisPKGAttAC2 = new PatientHistoryAttribute();

                hisPKGAttAC2.PatientVisitID = patientVisitID;
                hisPKGAttAC2.HistoryID = 369;
                hisPKGAttAC2.AttributeID = 5;
                hisPKGAttAC2.AttributevalueID = Convert.ToInt64(ddlDurationAC.SelectedValue);
                hisPKGAttAC2.AttributeValueName = txtDurationAC.Text + " " + ddlDurationAC.SelectedItem.Text;

                lstPatientHisAttributes.Add(hisPKGAttAC2);
            }
            if (txtQtyAC.Text != "")
            {
                PatientHistoryAttribute hisPKGAttAC3 = new PatientHistoryAttribute();

                hisPKGAttAC3.PatientVisitID = patientVisitID;
                hisPKGAttAC3.HistoryID = 369;
                hisPKGAttAC3.AttributeID = 6;
                hisPKGAttAC3.AttributevalueID = 17;
                hisPKGAttAC3.AttributeValueName = txtQtyAC.Text + " " + ddlmlDoW.SelectedItem.Text;

                lstPatientHisAttributes.Add(hisPKGAttAC3);
            }

        }




        if (chkIllicitdrugs_411.Checked == true)
        {
            PatientHistory hisPKGID = new PatientHistory();

            hisPKGID.HistoryID = 411;
            hisPKGID.ComplaintId = 0;
            hisPKGID.PatientVisitID = patientVisitID;
            hisPKGID.Description = chkIllicitdrugs_411.Text;
            hisPKGID.HistoryName = chkIllicitdrugs_411.Text;
            lstPatientHis.Add(hisPKGID);

            {
                PatientHistoryAttribute hisPKGAttID = new PatientHistoryAttribute();

                hisPKGAttID.PatientVisitID = patientVisitID;
                hisPKGAttID.HistoryID = 411;
                hisPKGAttID.AttributeID = 26;
                hisPKGAttID.AttributevalueID = Convert.ToInt64(ddlType_26.SelectedValue);

                if (ddlType_26.SelectedItem.Text != "Others")
                {
                    hisPKGAttID.AttributeValueName = ddlType_26.SelectedItem.Text;
                }
                else
                {
                    hisPKGAttID.AttributeValueName = txtOthersTypeID_26.Text;
                }


                lstPatientHisAttributes.Add(hisPKGAttID);
            }

        }

        #endregion


        #region MLC Details
        RTAMLCDetails objRTAMLC = new RTAMLCDetails();
        objRTAMLC = GetRTAMLCDetails();
        #endregion

        #region Death Registration Details
        DeathRegistration objDeathRegistration = new DeathRegistration();
        objDeathRegistration = GetDeathRegistration();
        #endregion

        #region Get Organ Donation Details

        lstOrgRegWithMapping = GetOrganDonationDetails();
        #endregion

        string pType = string.Empty;
        pType = hdnType.Value;

        retCode = -1;
        retCode = objIP_BL.SaveDeathRegDetails(OrgID, patientVisitID, patientID, LID, pType, lstCauseOfDeath, lstPatientHis,lstPatientHisAttributes,lstOrgRegWithMapping,objRTAMLC,objDeathRegistration);

        if (lstCauseOfDeath.Count > 0)
        {
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.UpdatePatientICDStatus(patientVisitID);
            
        }

        if (retCode > 0)
        {
            try
            {
                Response.Redirect("../InPatient/DeathCaseSheet.aspx?&vid=" + patientVisitID + "&pid=" + patientID + "&vType=" + "IP", true);

            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while save SaveNeonatalNotes  page", ex);
            }

        }      
    

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }


    public List<CauseOfDeath> GetCauseOfDeath()
    {

        List<CauseOfDeath> lstCauseOfDeathTemp = new List<CauseOfDeath>();

        lstPCOD = ComplaintICDCode1.GetCauseOfDeath("CODP");
        if (lstPCOD.Count > 0)
        {
            foreach (CauseOfDeath objCOD in lstPCOD)
            {


                CauseOfDeath objCauseOfDeath = new CauseOfDeath();            
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = objCOD.CauseOfDeathType;
                objCauseOfDeath.ComplaintID = Convert.ToInt32(objCOD.ComplaintID);
                objCauseOfDeath.ComplaintName = objCOD.ComplaintName;
                objCauseOfDeath.ICDCode = objCOD.ICDCode;
                objCauseOfDeath.ICDDescription = objCOD.ICDDescription;
                objCauseOfDeath.ICDCodeStatus = objCOD.ICDCodeStatus;       
                
                lstCauseOfDeathTemp.Add(objCauseOfDeath);

            }
        }

        lstSCOD = ComplaintICDCodeBP1.GetCauseOfDeath("CODS");
        if (lstPCOD.Count > 0)
        {
            foreach (CauseOfDeath objCOD in lstSCOD)
            {


                CauseOfDeath objCauseOfDeath = new CauseOfDeath();
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = objCOD.CauseOfDeathType;
                objCauseOfDeath.ComplaintID = Convert.ToInt32(objCOD.ComplaintID);
                objCauseOfDeath.ComplaintName = objCOD.ComplaintName;
                objCauseOfDeath.ICDCode = objCOD.ICDCode;
                objCauseOfDeath.ICDDescription = objCOD.ICDDescription;
                objCauseOfDeath.ICDCodeStatus = objCOD.ICDCodeStatus;

                lstCauseOfDeathTemp.Add(objCauseOfDeath);

            }
        }

        lstACOD = CODICDCode1.GetCauseOfDeath("CODA");
        if (lstPCOD.Count > 0)
        {
            foreach (CauseOfDeath objCOD in lstACOD)
            {


                CauseOfDeath objCauseOfDeath = new CauseOfDeath();
                objCauseOfDeath.CauseOfDeathTypeID = 0;
                objCauseOfDeath.CauseOfDeathType = objCOD.CauseOfDeathType;
                objCauseOfDeath.ComplaintID = Convert.ToInt32(objCOD.ComplaintID);
                objCauseOfDeath.ComplaintName = objCOD.ComplaintName;
                objCauseOfDeath.ICDCode = objCOD.ICDCode;
                objCauseOfDeath.ICDDescription = objCOD.ICDDescription;
                objCauseOfDeath.ICDCodeStatus = objCOD.ICDCodeStatus;

                lstCauseOfDeathTemp.Add(objCauseOfDeath);

            }
        }

        return lstCauseOfDeathTemp;
    }


    //public List<CauseOfDeath> GetCauseOfDeath()
    //{

    //    List<CauseOfDeath> lstCauseOfDeathTemp = new List<CauseOfDeath>();

    //    foreach (string lstCOD in hdnCOD.Value.Split('^'))
    //    {

    //        if (lstCOD != "")
    //        {
    //            CauseOfDeath objCauseOfDeath = new CauseOfDeath();
    //            string[] lstChildData = lstCOD.Split('~');
    //            objCauseOfDeath.CauseOfDeathTypeID =Convert.ToInt64(lstChildData[1]);
    //            objCauseOfDeath.CauseOfDeathType = lstChildData[2];
    //            objCauseOfDeath.Description = lstChildData[3];
    //            lstCauseOfDeathTemp.Add(objCauseOfDeath);
    //        }
    //    }
       

    //    return lstCauseOfDeathTemp;
    //}


    public RTAMLCDetails GetRTAMLCDetails()
    {
        RTAMLCDetails objRTAMLCDetails = new RTAMLCDetails();
        if (chkRTA.Checked == true)
        {

            if (chkRTAInfluenceOfDrugs.Checked)
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "Y";
            }
            else
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "N";
            }
            objRTAMLCDetails.FIRNo = txtRTAFIRNo.Text;
            objRTAMLCDetails.Location = txtRTALocation.Text;
            objRTAMLCDetails.PoliceStation = txtPoliceStation.Text;
            objRTAMLCDetails.MLCNo = txtMLCNo.Text;

            if (txtFIRDate.Text != "")
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime(txtFIRDate.Text);
            }
            else
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
            }

            if (txtRTADate.Text != "")
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime(txtRTADate.Text);
            }
            else
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            }
        }
        else
        {
            objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
        }

        return objRTAMLCDetails;
    }


    public DeathRegistration GetDeathRegistration()
    {
        DeathRegistration objDeathRegistration = new DeathRegistration();
        objDeathRegistration.DOD =Convert.ToDateTime(txtDOD.Text);
        if (ddlPOC.SelectedItem.Text == "Others")
        {
            objDeathRegistration.PlaceOfDeathID = Convert.ToInt64(ddlPOC.SelectedValue);
            objDeathRegistration.PlaceOfDeathDes = txtPOCOthers.Text;
        }
        else
        {
            objDeathRegistration.PlaceOfDeathID = Convert.ToInt64(ddlPOC.SelectedValue);
        }

        if (ddlTOD.SelectedItem.Text == "Others")
        {
            objDeathRegistration.DeathTypeID = Convert.ToInt64(ddlTOD.SelectedValue);
            objDeathRegistration.DeathTypeDes = txtTODOthers.Text;
        }
        else
        {
            objDeathRegistration.DeathTypeID = Convert.ToInt64(ddlTOD.SelectedValue);
        }

        if (chkPregnancy.Checked == true)
        {
            objDeathRegistration.IsPregnancy = "Y";
            objDeathRegistration.PregnancyStatus = ddlPregnancyType.SelectedItem.Text;

            if (ddlPregnancyType.SelectedItem.Text == "Delivered")
            {
                objDeathRegistration.PregnancyDescription = txtDelivered.Text;
            }
        }
        else
        {
            objDeathRegistration.IsPregnancy = "N";
        }
        if (chkResuscitation.Checked == true)
        {
            objDeathRegistration.IsResuscitation = "Y";
        }
        else
        {
            objDeathRegistration.IsResuscitation = "N";
        }


        objDeathRegistration.LifeSupportID = Convert.ToInt64(ddlTOLS.SelectedValue);


        if (chkROSC.Checked == true)
        {
            objDeathRegistration.IsROSC = "Y";
            objDeathRegistration.RoscDescription = txtROSC.Text;
        }
        else
        {
            objDeathRegistration.IsROSC = "N";
        }

        objDeathRegistration.HospitalCourse = fckHospitalCourse.Value;
        objDeathRegistration.ProcedureDesc = txtProcedures.Text;
     

        return objDeathRegistration;
    }


    public List<OrganRegWithMapping> GetOrganDonationDetails()
    {
        List<OrganRegWithMapping> lstOrganRegWithMappingTemp = new List<OrganRegWithMapping>();

        if (chkOD.Checked == true)
        {         

            foreach (string lstOD in hdnOD.Value.Split('^'))
            {

                if (lstOD != "")
                {
                    OrganRegWithMapping objOrganRegWithMapping = new OrganRegWithMapping();
                    string[] lstChildData = lstOD.Split('~');
                    objOrganRegWithMapping.OrganID = Convert.ToInt16(lstChildData[1]);
                    objOrganRegWithMapping.OrganRegWith = lstChildData[3];
                    lstOrganRegWithMappingTemp.Add(objOrganRegWithMapping);
                }
            }

           
        }
        return lstOrganRegWithMappingTemp;
    }


    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath ;
            sPath = sPath + "/fckeditor/";
            fckHospitalCourse.ToolbarSet = "Attune";
            fckHospitalCourse.BasePath = sPath;
            fckHospitalCourse.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckHospitalCourse.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In DischargeSummary.aspx", ex);
        }
    }

}
