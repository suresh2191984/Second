using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.IO;
using System.Xml.Linq;

public partial class InPatient_KDRDischargeSummary : BasePage
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;
    string primaryConsultant = string.Empty;
    string DischargeConfigs = string.Empty;
    int OrthoCount = -1;

    List<Patient> lsPatient = new List<Patient>();
    List<InPatientAdmissionDetails> lstInPatientAdmissionDetails = new List<InPatientAdmissionDetails>();
    List<InPatientAdmissionDetails> lstAdmissionDate = new List<InPatientAdmissionDetails>();
    List<OperationNotes> lstOperationNotes = new List<OperationNotes>();
    List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<IPTreatmentPlan> lstCaserecordIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<IPTreatmentPlan> lstOperationIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();

    List<IPTreatmentPlanMaster> lstIPTreatmentPlanMaster = new List<IPTreatmentPlanMaster>();
    List<IPTreatmentPlan> lstIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
    List<DischargeSummary> lstDischargeSummaryByPatientID = new List<DischargeSummary>();

    //Newly Added
    List<PatientVitals> lstPatientVitalsCount = new List<PatientVitals>();
    List<VitalsUOMJoin> lstDischargeVitalsUOMJoin = new List<VitalsUOMJoin>();

    List<IPComplaint> lstNegativeIPComplaint = new List<IPComplaint>();
    List<Examination> lstNegativeExamination = new List<Examination>();

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();

    List<RoomMaster> lstRoomMaster = new List<RoomMaster>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();

    List<DischargeConfig> lstDischargeConfig = new List<DischargeConfig>();
    List<DischargeConfig> lstAllDischargeConfig = new List<DischargeConfig>();

    List<OperationNotes> lstOperationNotesForDS = new List<OperationNotes>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();



    IP_BL oIP_BL;
    List<GeneralAdvice> lstGeneralAdvice = new List<GeneralAdvice>();
  

    protected void Page_Load(object sender, EventArgs e)
    {
        oIP_BL = new IP_BL(base.ContextInfo);
        try
        {

            

            VistType = Request.QueryString["vType"];
            if (VistType == "IP")
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                patientHeader.PatientID = patientID;
                patientHeader.PatientVisitID = patientVisitID;
                patientHeader.ShowVitalsDetails();
                returnCode = oIP_BL.GetDischargeSummaryDetailsForupdate(patientVisitID, out lstDischargeSummary, out lstDischargeInvNotes);


                if (lstDischargeSummary.Count > 0)
                {
                    if (lstDischargeSummary[0].SummaryStatus == "Completed" && RoleName != "Administrator")
                    {
                        btnEdit.Visible = false;
                    }
                    else
                    {
                        btnEdit.Visible = true;
                    }

                }
            }
            else
            {
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                oIP_BL.GetPatientDischargeDetailByPatientID(patientID, out lstDischargeSummaryByPatientID);
                gvDischargeDetail.DataSource = lstDischargeSummaryByPatientID;
                gvDischargeDetail.DataBind();
                tblSave.Style.Add("display", "none");
                tblDischrageResult.Style.Add("display", "none");

            }

            if (!IsPostBack)
            {
                if (VistType == "IP")
                {
                    tblDischargeDetail.Style.Add("display", "none");
                    GetDischargeSummaryCaseSheet();
                    GetPatientHistory();
                }

                if (Request.QueryString["page"] == "ICD")
                {
                    btnPrint.Visible = false;
                    btnEdit.Visible = false;
                    btnCancel.Visible = false;
                    LeftMenu1.Visible = false;
                    MainHeader.Visible = false;

                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in KDRDischargeSummaryCaseSheet.aspx:Page_Load", ex);
        }
    }



    private void GetPatientHistory()
    {
        try
        {
            returnCode = oIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);
            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

            var NeedHistoryInDSY = from res in lstAllDischargeConfig
                                   where res.DischargeConfigKey == "NeedHistoryInDSY"
                                            && res.DischargeConfigValue == "N"
                                   select res;

            if (NeedHistoryInDSY.Count() == 0)
            {
                if (lstPatientHistory.Count > 0)
                {
                    trHistory.Style.Add("display", "block");
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();
                    cell2.Attributes.Add("align", "left");
                    string PatientHistory = string.Empty;
                    string Age = string.Empty;
                    foreach (var oPatientHistory in lstPatientHistory)
                    {
                        if (PatientHistory == string.Empty)
                        {

                            if (oPatientHistory.HistoryName != string.Empty)
                            {
                                if (oPatientHistory.Description != " ")
                                {
                                    PatientHistory = oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                                }
                                else
                                {
                                    PatientHistory = oPatientHistory.HistoryName;
                                }
                            }

                        }

                        else
                        {

                            if (oPatientHistory.HistoryName != string.Empty)
                            {
                                if (oPatientHistory.Description != " ")
                                {
                                    PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                                }
                                else
                                {
                                    PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName;
                                }
                            }

                        }

                    }

                    if (lsPatient.Count > 0)
                    {

                        string[] Age1 = lsPatient[0].Age.Split(' ');
                        if (lsPatient[0].SEX == "M")
                        {
                            if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
                            }
                            else
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

                            }

                        }
                        else if (lsPatient[0].SEX == "F")
                        {
                            if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with history of" + " ";
                            }
                            else
                            {
                                Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

                            }
                        }
                    }
                    cell2.Text = Age + PatientHistory + ".";


                    row2.Cells.Add(cell2);
                    row2.Style.Add("color", "#000");
                    tblHistory.Rows.Add(row2);

                }

            }

            // Org Header


            //List<Config> lstConfig = new List<Config>();
            //new GateWay(base.ContextInfo).GetConfigDetails("OrgAddress", OrgID, out lstConfig);
            new GateWay(base.ContextInfo).GetDischargeConfigDetails("OrgAddress", OrgID, out lstDischargeConfig);
            if (lstDischargeConfig.Count > 0)
            {

                lblHospitalName.Text = OrgName + "<br/>" + lstDischargeConfig[0].DischargeConfigValue.Trim();
            }

            //new GateWay(base.ContextInfo).GetConfigDetails("BillPrintLogo", OrgID, out lstConfig);

            new GateWay(base.ContextInfo).GetDischargeConfigDetails("DischargeLogo", OrgID, out lstDischargeConfig);

            if (lstDischargeConfig.Count > 0)
            {
                //tbl1.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                imgBillLogo.ImageUrl = lstDischargeConfig[0].DischargeConfigValue.Trim();
                imgBillLogo.Visible = true;
            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error on Loading DischargeSummarySheet in KDRDischargeSummaryCaseSheet.aspx", ex);
        }
    }

    private void GetDischargeSummaryCaseSheet()
    {
        try
        {
            returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes, out OrthoCount);


            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);


            //XDocument xmlFile = XDocument.Load(DischargeConfigs);             
            //var query = from c in xmlFile.Elements("DischargeConfigTable")
            //            where (string)c.Element("DischargeConfigKey") == "NeedNegativeBackroundProblemDSY"
            //            select (string)c.Element("DischargeConfigKey");  




            oIP_BL.GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);

            if (returnCode == 0)
            {
                if (lstPatientHistoryExt.Count > 0)
                {
                    ltrDetailHistory.Text = lstPatientHistoryExt[0].DetailHistory;
                }

                string BloodGroup;
                if (lsPatient.Count > 0)
                {
                    if (lsPatient[0].BloodGroup == "-1")
                    {
                        BloodGroup = "";
                    }
                    else
                    {
                        BloodGroup = lsPatient[0].BloodGroup;
                    }
                    //if (OrgID == 26)
                    //{
                    //    if (lsPatient[0].SEX == "M")
                    //    {

                    //        if (lstInPatientNumber.Count == 0)
                    //        {
                    //            IpNumber = "-";
                    //        }
                    //        else
                    //        {
                    //            IpNumber = lstInPatientNumber[0].IPNumber.ToString();
                    //        }

                    //        if (BloodGroup != "")
                    //        {
                    //            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + "  BloodGroup: " + BloodGroup;
                    //        }
                    //        else
                    //        {
                    //            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + BloodGroup;
                    //        }

                    //    }
                    //    else if (lsPatient[0].SEX == "F")
                    //    {
                    //        if (lstInPatientNumber.Count == 0)
                    //        {
                    //            IpNumber = "-";
                    //        }
                    //        else
                    //        {
                    //            IpNumber = lstInPatientNumber[0].IPNumber.ToString();
                    //        }
                    //        if (BloodGroup != "")
                    //        {
                    //            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + "  BloodGroup: " + BloodGroup;
                    //        }
                    //        else
                    //        {
                    //            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + BloodGroup;

                    //        }
                    //    }
                    //}
                    //else
                    //{
                    if (lsPatient[0].SEX == "M")
                    {
                        if (BloodGroup != "")
                        {
                            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                        }
                        else
                        {
                            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                        }

                    }
                    else if (lsPatient[0].SEX == "F")
                    {
                        if (BloodGroup != "")
                        {
                            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                        }
                        else
                        {
                            lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                        }
                    }
                    //}

                }

                if (lstInPatientAdmissionDetails.Count > 0)
                {
                    //lblDOA.Text = lstInPatientAdmissionDetails[0].AdmissionDate.ToString();
                    string CPhysician = lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                    string CSurgeon = lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
                    if (CPhysician != "")
                    {
                        //trCPhysician.Style.Add("display", "block");
                        //trCPhysician.Style.Add("display", "none");
                        //lblCPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                        //trConsultant.Style.Add("display", "block");
                        //lblConsultant.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                        //lblCI.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                    }
                    if (CSurgeon != null)
                    {
                        //trCSurgeon.Style.Add("display", "block");
                        trCSurgeon.Style.Add("display", "none");
                        lblCSurgeon.Text = "Dr." + lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
                    }

                }


                var NeedSeniorMedicalOfficerInDSY = from res in lstAllDischargeConfig
                                                    where res.DischargeConfigKey == "NeedSeniorMedicalOfficerInDSY"
                                             && res.DischargeConfigValue == "N"
                                                    select res;

                var NeedSeniorMedicalOfficerNameInDSY = from res in lstAllDischargeConfig
                                                        where res.DischargeConfigKey == "NeedSeniorMedicalOfficerNameInDSY"
                                             && res.DischargeConfigValue == "N"
                                                        select res;

                if (NeedSeniorMedicalOfficerInDSY.Count() == 0)
                {

                    if (lstInPatientAdmissionDetails.Count > 0)
                    {
                        lblSMOT.Visible = true;


                        if (NeedSeniorMedicalOfficerNameInDSY.Count() == 0)
                        {
                            lblSMO.Text = lstInPatientAdmissionDetails[0].DutyOfficer;
                            lblSMO.Visible = true;
                        }

                    }
                }

                var NeedPrimaryConsultant = from res in lstAllDischargeConfig
                                            where res.DischargeConfigKey == "NeedPrimaryConsultant"
                                             && res.DischargeConfigValue == "N"
                                            select res;

                if (NeedPrimaryConsultant.Count() == 0)
                {
                    List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
                    returnCode = new Patient_BL(base.ContextInfo).GetPrimaryConsultant(patientVisitID, 1, out lstPrimaryConsultant);

                    if (lstPrimaryConsultant.Count > 0)
                    {
                        foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                        {
                            if (primaryConsultant == "")
                            {
                                primaryConsultant = objPC.PhysicianName;
                            }
                            else
                            {
                                primaryConsultant += " , " + objPC.PhysicianName;
                            }

                        }
                    }

                    if (primaryConsultant != "")
                    {
                        //trCPhysician.Style.Add("display", "none");
                        //lblCPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                        trConsultant.Style.Add("display", "block");
                        lblConsultant.Text = primaryConsultant;
                        //lblCI.Text = primaryConsultant;
                    }
                }
                var NeedConsultantInchargeInDSY = from res in lstAllDischargeConfig
                                                  where res.DischargeConfigKey == "NeedConsultantInchargeInDSY"
                                             && res.DischargeConfigValue == "N"
                                                  select res;

                var NeedConsultantInchargeNameInDSY = from res in lstAllDischargeConfig
                                                      where res.DischargeConfigKey == "NeedConsultantInchargeNameInDSY"
                                             && res.DischargeConfigValue == "N"
                                                      select res;

                if (NeedConsultantInchargeInDSY.Count() == 0)
                {
                    lblCIT.Visible = true;

                    if (NeedConsultantInchargeNameInDSY.Count() == 0)
                    {
                        lblCI.Text = primaryConsultant;
                        lblCI.Visible = true;
                    }
                }

                var NeedDateOfAdmission = from res in lstAllDischargeConfig
                                          where res.DischargeConfigKey == "NeedDateOfAdmission"
                                                 && res.DischargeConfigValue == "N"
                                          select res;
                if (NeedDateOfAdmission.Count() == 0)
                {

                    if (lstAdmissionDate.Count > 0)
                    {
                        if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
                        {
                            lblDOA.Text = "";
                        }
                        else
                        {
                            trDOA.Style.Add("display", "block");
                            lblDOA.Text = lstAdmissionDate[0].AdmissionDate.ToString("dd/MM/yyyy");
                        }
                    }
                }
                var NeedDateOfSurgery = from res in lstAllDischargeConfig
                                        where res.DischargeConfigKey == "NeedDateOfSurgery"
                                                 && res.DischargeConfigValue == "N"
                                        select res;

                if (NeedDateOfSurgery.Count() == 0)
                {
                    if (lstOperationNotes.Count > 0)
                    {
                        trDOS.Style.Add("display", "block");
                        string OpertionDate = string.Empty;
                        foreach (var objIPitem in lstOperationNotes)
                        {
                            if (OpertionDate == "")
                            {
                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate = objIPitem.FromTime.ToString("dd/MM/yyyy ");
                                }
                            }
                            else
                            {

                                if (objIPitem.FromTime != DateTime.MinValue)
                                {
                                    OpertionDate += ", " + objIPitem.FromTime.ToString("dd/MM/yyyy ");
                                }


                            }

                        }

                        lblDOS.Text = OpertionDate;


                    }
                }

                if (lstDischargeSummary.Count > 0)
                {

                    if (lstDischargeSummary[0].NextReviewAfter.Contains("/"))
                    {
                        lblNextReview.Text = lstDischargeSummary[0].NextReviewAfter.ToString();
                    }
                    else
                    {

                        string[] NextReview = lstDischargeSummary[0].NextReviewAfter.Split('-');
                        if (NextReview[0] != "0" && NextReview[1] != "0")
                        {
                            lblNextReview.Text = "After  " + lstDischargeSummary[0].NextReviewAfter.ToString();
                        }
                    }

                    var NeedTypedByInDSY = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedTypedByInDSY"
                                                  && res.DischargeConfigValue == "N"
                                           select res;
                    if (NeedTypedByInDSY.Count() == 0)
                    {
                        lblTypedBy.Visible = true;
                        lblTypedByT.Visible = true;
                        lblTypedBy.Text = lstDischargeSummary[0].Name;

                    }

                    var NeedPreparedByInDSY = from res in lstAllDischargeConfig
                                              where res.DischargeConfigKey == "NeedPreparedByInDSY"
                                                     && res.DischargeConfigValue == "N"
                                              select res;

                    if (NeedPreparedByInDSY.Count() == 0)
                    {
                        lblPreparedBy.Visible = true;
                        lblPreparedByT.Visible = true;
                        lblPreparedBy.Text = lstDischargeSummary[0].PreparedBy;

                    }


                    string HospitalCourse = lstDischargeSummary[0].HospitalCourse;

                    var lstCRC = from resCRC in lstDrugDetails
                                 where resCRC.PrescriptionType == "CRC"
                                 select resCRC;



                    var NeedCourseHospitalInDSY = from res in lstAllDischargeConfig
                                                  where res.DischargeConfigKey == "NeedCourseHospitalInDSY"
                                                         && res.DischargeConfigValue == "N"
                                                  select res;

                    if (NeedCourseHospitalInDSY.Count() == 0)
                    {

                        if (HospitalCourse != string.Empty || lstCRC.Count() > 0)
                        {
                            trCourseHospital.Style.Add("display", "block");
                            ltrHospitalcourse.Text = lstDischargeSummary[0].HospitalCourse;

                            var NeedAdmissionPrescriptionInDSY = from res in lstAllDischargeConfig
                                                                 where res.DischargeConfigKey == "NeedAdmissionPrescriptionInDSY"
                                                                        && res.DischargeConfigValue == "N"
                                                                 select res;

                            if (NeedAdmissionPrescriptionInDSY.Count() == 0)
                            {
                                trCRCPresc.Style.Add("display", "block");
                            }


                            TableRow rowH = new TableRow();
                            TableCell cellH1 = new TableCell();
                            TableCell cellH2 = new TableCell();
                            TableCell cellH3 = new TableCell();
                            TableCell cellH4 = new TableCell();
                            TableCell cellH5 = new TableCell();
                            TableCell cellH6 = new TableCell();
                            TableCell cellH7 = new TableCell();
                            cellH1.Attributes.Add("align", "left");
                            cellH1.Text = "Drug Name";
                            cellH2.Attributes.Add("align", "left");
                            cellH2.Text = "Dose";
                            cellH3.Attributes.Add("align", "left");
                            cellH3.Text = "Formulation";
                            cellH4.Attributes.Add("align", "left");
                            cellH4.Text = "ROA";
                            cellH5.Attributes.Add("align", "left");
                            cellH5.Text = "DrugFrequency";
                            cellH6.Attributes.Add("align", "left");
                            cellH6.Text = "Duration";
                            rowH.Cells.Add(cellH1);
                            rowH.Cells.Add(cellH2);
                            rowH.Cells.Add(cellH3);
                            rowH.Cells.Add(cellH4);
                            rowH.Cells.Add(cellH5);
                            rowH.Cells.Add(cellH6);

                            rowH.Font.Bold = true;
                            rowH.Style.Add("color", "#000");
                            tblCRCPresc.Rows.Add(rowH);
                            foreach (var oDrugDetails in lstCRC)
                            {

                                TableRow row1 = new TableRow();
                                TableCell cell1 = new TableCell();
                                TableCell cell2 = new TableCell();
                                TableCell cell3 = new TableCell();
                                TableCell cell4 = new TableCell();
                                TableCell cell5 = new TableCell();
                                TableCell cell6 = new TableCell();

                                cell1.Attributes.Add("align", "left");
                                cell1.Text = oDrugDetails.DrugName;
                                cell2.Attributes.Add("align", "left");
                                cell2.Text = oDrugDetails.Dose;
                                cell3.Attributes.Add("align", "left");
                                cell3.Text = oDrugDetails.DrugFormulation;
                                cell4.Attributes.Add("align", "left");
                                cell4.Text = oDrugDetails.ROA;
                                cell5.Attributes.Add("align", "left");
                                cell5.Text = oDrugDetails.DrugFrequency;
                                cell6.Attributes.Add("align", "left");
                                cell6.Text = oDrugDetails.Days;

                                row1.Cells.Add(cell1);
                                row1.Cells.Add(cell2);
                                row1.Cells.Add(cell3);
                                row1.Cells.Add(cell4);
                                row1.Cells.Add(cell5);
                                row1.Cells.Add(cell6);


                                row1.Style.Add("color", "#000");
                                tblCRCPresc.Rows.Add(row1);
                            }
                        }


                    }


                    var NeedDateOfDischarge = from res in lstAllDischargeConfig
                                              where res.DischargeConfigKey == "NeedDateOfDischarge"
                                                     && res.DischargeConfigValue == "N"
                                              select res;
                    if (NeedDateOfDischarge.Count() == 0)
                    {
                        if (lstDischargeSummary[0].DateOfDischarge == DateTime.MinValue)
                        {
                            lblDOD.Text = "";
                        }
                        else
                        {
                            trDOD.Style.Add("display", "block");
                            lblDOD.Text = lstDischargeSummary[0].DateOfDischarge.ToString("dd/MM/yyyy ");
                        }
                    }
                    var NeedDischargeTitle = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedDischargeTitle"
                                                    && res.DischargeConfigValue == "N"
                                             select res;


                    if (NeedDischargeTitle.Count() == 0)
                    {

                        if (lstDischargeSummary[0].DischargeTypeName == "Expired")
                        {
                            lblTypeOfDis.Text = "Death Summary";

                        }
                        else
                        {
                            lblTypeOfDis.Text = "Discharge Summary";
                           // lblDischargeTypeName.Text = "(" + lstDischargeSummary[0].DischargeTypeName + ")";
                          
                        }
                    }


                    var NeedyTypeOfDischarge = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedyTypeOfDischarge"
                                                      && res.DischargeConfigValue == "N"
                                               select res;
                    if (NeedyTypeOfDischarge.Count() == 0)
                    {
                        trTOD.Style.Add("display", "block");
                        lblTOD.Text = lstDischargeSummary[0].DischargeTypeName;
                    }


                    var NeedConditionOnDischarge = from res in lstAllDischargeConfig
                                                   where res.DischargeConfigKey == "NeedConditionOnDischarge"
                                                            && res.DischargeConfigValue == "N"
                                                   select res;
                    if (NeedConditionOnDischarge.Count() == 0)
                    {
                        if (lstDischargeSummary[0].ConditionOnDischarge != "")
                        {
                            trCOD.Style.Add("display", "block");
                            lblCODV.Text = lstDischargeSummary[0].ConditionOnDischarge;
                        }
                    }


                }

                var NeedDiagnoseInDSY = from res in lstAllDischargeConfig
                                        where res.DischargeConfigKey == "NeedDiagnoseInDSY"
                                               && res.DischargeConfigValue == "N"
                                        select res;

                if (NeedDiagnoseInDSY.Count() == 0)
                {

                    var NeedDiagnoseWithICD10InDSY = from res in lstAllDischargeConfig
                                                     where res.DischargeConfigKey == "NeedDiagnoseWithICD10InDSY"
                                                            && res.DischargeConfigValue == "Y"
                                                     select res;

                    if (NeedDiagnoseWithICD10InDSY.Count() == 0)
                    {

                        if (lstPatientComplaint.Count > 0)
                        {
                            trDiagnosis.Style.Add("display", "block");
                            foreach (var oPatientComplaint in lstPatientComplaint)
                            {

                                TableRow row1 = new TableRow();
                                TableCell cell1 = new TableCell();
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = "<li type=a>" + oPatientComplaint.ComplaintName;
                                row1.Cells.Add(cell1);
                                row1.Style.Add("color", "#000");
                                tbldiagnosis.Rows.Add(row1);
                            }
                        }

                    }
                    else
                    {
                        DiagnoseWithICD1.HeaderText = "DIAGNOSIS";
                        DiagnoseWithICD1.LoadPatientComplaintWithICD(patientVisitID , "IP", "DSY");
                    }
                }


                var NeedPatientAddress = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedPatientAddress"
                                                && res.DischargeConfigValue == "N"
                                         select res;

                if (NeedPatientAddress.Count() == 0)
                {
                    if (lstPatientAddress.Count > 0)
                    {

                        var NeedPermenantAddress = from res in lstAllDischargeConfig
                                                   where res.DischargeConfigKey == "NeedPermenantAddress"
                                                          && res.DischargeConfigValue == "N"
                                                   select res;

                        if (NeedPermenantAddress.Count() == 0)
                        {

                            string ppermenantAddress = string.Empty;

                            foreach (var oPatientAddress in lstPatientAddress)
                            {
                                if (oPatientAddress.AddressType == "P" && oPatientAddress.Add2 != "")
                                {
                                    ppermenantAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;


                                }

                            }
                            string[] PAdd = ppermenantAddress.Split(',');
                            string paddress = string.Empty;
                            if (PAdd.Length > 1)
                            {
                                trAddress.Style.Add("display", "block");
                                tdPermenantAddress.Style.Add("display", "block");
                                foreach (string sPAdd in PAdd)
                                {
                                    if (sPAdd != "")
                                    {
                                        if (paddress == "")
                                        {
                                            paddress = sPAdd;
                                        }
                                        else
                                        {
                                            paddress += " ," + sPAdd;
                                        }
                                    }
                                }

                                TableRow row1 = new TableRow();
                                TableCell cell1 = new TableCell();
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = paddress + ".";
                                row1.Cells.Add(cell1);
                                row1.Style.Add("color", "#000");
                                tblPermenantAddress.Rows.Add(row1);
                            }
                        }
                    }

                    if (lstPatientAddress.Count > 0)
                    {


                        var NeedPresentAddress = from res in lstAllDischargeConfig
                                                 where res.DischargeConfigKey == "NeedPresentAddress"
                                                        && res.DischargeConfigValue == "N"
                                                 select res;
                        if (NeedPresentAddress.Count() == 0)
                        {
                            string pPresentAddress = string.Empty;
                            foreach (var oPatientAddress in lstPatientAddress)
                            {
                                if (oPatientAddress.AddressType == "C" && oPatientAddress.Add2 != "")
                                {
                                    pPresentAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;
                                }

                            }
                            string[] PAdd = pPresentAddress.Split(',');
                            string caddress = string.Empty;

                            if (PAdd.Length > 1)
                            {
                                tdPresentAddress.Style.Add("display", "block");
                                foreach (string sPAdd in PAdd)
                                {
                                    if (sPAdd != "")
                                    {
                                        if (caddress == "")
                                        {
                                            caddress = sPAdd;
                                        }
                                        else
                                        {
                                            caddress += " ," + sPAdd;
                                        }
                                    }
                                }

                                TableRow row1 = new TableRow();
                                TableCell cell1 = new TableCell();
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = caddress + ".";
                                row1.Cells.Add(cell1);
                                row1.Style.Add("color", "#000");
                                tblPresentAddress.Rows.Add(row1);
                            }
                        }
                    }

                }



                var NeedSurgeryDetailInDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedSurgeryDetailInDSY"
                                           && res.DischargeConfigValue == "N"
                                             select res;


                new IP_BL(base.ContextInfo).GetOperationNotesForDS(patientVisitID, OrgID, out lstOperationNotesForDS);
                if (NeedSurgeryDetailInDSY.Count() == 0)
                {
                    if (lstOperationNotesForDS.Count > 0)
                    {
                        trSurgery.Style.Add("display", "block");
                        // trSurgery.Style.Add("display", "none");
                        repTreatmentPlan.DataSource = lstOperationNotesForDS;
                        repTreatmentPlan.DataBind();


                    }
                }



                //if (lstOperationNotesForDS.Count > 0)
                //{
                //    foreach (OperationNotes s in lstOperationNotesForDS)
                //    {
                //        TableRow tr = new TableRow();
                //        TableCell td1 = new TableCell();
                //        TableCell td2 = new TableCell();

                //        td1.Text = "TreatmentName";
                //        td2.Text = s.TreatmentName;
                //        tr.Cells.Add(td1);
                //        tr.Cells.Add(td2);

                //        tblS.Rows.Add(tr);
                //    }

                //}

                var NeedBackgroundProblemInDSY = from res in lstAllDischargeConfig
                                                 where res.DischargeConfigKey == "NeedBackgroundProblemInDSY"
                                                        && res.DischargeConfigValue == "N"
                                                 select res;

                if (NeedBackgroundProblemInDSY.Count() == 0)
                {

                    if (lstDischargeSummary.Count > 0)
                    {
                        if (lstDischargeSummary[0].PrintNegativeHistory == "N")
                        {
                            trBackgroundProblem.Style.Add("display", "none");
                            trNegativeHistory.Style.Add("display", "none");

                        }


                        else
                        {
                            if (lstNegativeIPComplaint.Count > 0)
                            {
                                trBackgroundProblem.Style.Add("display", "block");
                                trNegativeHistory.Style.Add("display", "block");
                                string NegaitiveHis = string.Empty;
                                foreach (var oNegativeIPComplaint in lstNegativeIPComplaint)
                                {
                                    if (NegaitiveHis == string.Empty)
                                    {
                                        NegaitiveHis = oNegativeIPComplaint.ComplaintName;
                                    }
                                    else
                                    {
                                        NegaitiveHis += ", " + oNegativeIPComplaint.ComplaintName;
                                    }
                                }

                                lblBackgroundProblems.Text = "No history of" + " " + NegaitiveHis + ".";
                            }
                        }
                    }

                   
                }



                if (NeedBackgroundProblemInDSY.Count() == 0)
                {
                    if (lstBackgroundProblem.Count > 0)
                    {
                        trBackgroundProblem.Style.Add("display", "block");
                        foreach (var oBackgroundProblem in lstBackgroundProblem)
                        {
                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            if (oBackgroundProblem.Description != "")
                            {
                                if (oBackgroundProblem.ComplaintName == "Stroke(CVA)")
                                {
                                    string[] PStroke = oBackgroundProblem.Description.Split('^');
                                    if (PStroke[0].Contains('/'))
                                    {
                                        cell1.Attributes.Add("align", "left");
                                        cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[0] + "," + PStroke[1];
                                    }
                                    else
                                    {
                                        cell1.Attributes.Add("align", "left");
                                        cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[1];
                                    }

                                }
                                else
                                {
                                    cell1.Attributes.Add("align", "left");
                                    cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + oBackgroundProblem.Description;
                                }
                            }
                            else
                            {
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName;
                            }
                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblBackgroundProblems.Rows.Add(row1);
                        }
                    }
                }
                // new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedNegativeBackroundProblemDSY", OrgID, out lstDischargeConfig);

                var NeedAdmissionVitalsInDSY = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedAdmissionVitalsInDSY"
                                                        && res.DischargeConfigValue == "N"
                                               select res;

                if (NeedAdmissionVitalsInDSY.Count() == 0)
                {
                    if (lstVitalsUOMJoin.Count > 0)
                    {
                        trgeneralExam.Style.Add("display", "block");

                        //TableRow rowH = new TableRow();
                        //TableCell cellH1 = new TableCell();
                        //TableCell cellH2 = new TableCell();
                        //cellH1.Attributes.Add("align", "left");
                        //cellH1.Text = "Vitals";
                        //rowH.Cells.Add(cellH1);
                        //rowH.Font.Bold = true;
                        //rowH.Style.Add("color", "#000");
                        //tblgeneralExamination.Rows.Add(rowH);
                        //foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
                        //{
                        //    TableRow row1 = new TableRow();
                        //    TableCell cell1 = new TableCell();
                        //    cell1.Attributes.Add("align", "left");
                        //    cell1.Text = oVitalsUOMJoin.VitalsName + "-" + oVitalsUOMJoin.VitalsValue.ToString() + "" + oVitalsUOMJoin.UOMCode;
                        //    row1.Cells.Add(cell1);
                        //    row1.Style.Add("color", "#000");
                        //    tblgeneralExamination.Rows.Add(row1);
                        //}


                        string Vitalsname = string.Empty;
                        string Vitalsvalue = string.Empty;
                        string Vitalsunit = string.Empty;

                        foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
                        {
                            if (Vitalsname == string.Empty)
                            {
                                Vitalsname = oVitalsUOMJoin.VitalsName;
                            }
                            else
                            {
                                Vitalsname += "," + oVitalsUOMJoin.VitalsName;
                            }
                            if (Vitalsvalue == string.Empty)
                            {
                                Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
                            }
                            else
                            {
                                Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
                            }
                            if (Vitalsunit == string.Empty)
                            {
                                Vitalsunit = oVitalsUOMJoin.UOMCode;
                            }
                            else
                            {
                                Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
                            }
                        }

                        string[] resVitalsname = Vitalsname.Split(',');
                        string[] resVitalsvalue = Vitalsvalue.Split(',');
                        string[] resVitalsunit = Vitalsunit.Split(',');



                        TableRow rowH = new TableRow();
                        TableCell cellH1 = new TableCell();
                        TableCell cellH2 = new TableCell();
                        TableCell cellH3 = new TableCell();
                        TableCell cellH4 = new TableCell();
                        TableCell cellH5 = new TableCell();
                        TableCell cellH6 = new TableCell();
                        TableCell cellH7 = new TableCell();
                        TableCell cellH8 = new TableCell();
                        cellH1.Attributes.Add("align", "left");
                        cellH1.Text = resVitalsname[0];
                        cellH2.Attributes.Add("align", "left");
                        cellH2.Text = resVitalsname[1];
                        cellH3.Attributes.Add("align", "left");
                        cellH3.Text = resVitalsname[2];
                        cellH4.Attributes.Add("align", "left");
                        cellH4.Text = resVitalsname[3];
                        cellH5.Attributes.Add("align", "left");
                        cellH5.Text = resVitalsname[4];
                        cellH6.Attributes.Add("align", "left");
                        cellH6.Text = resVitalsname[5];
                        cellH7.Attributes.Add("align", "left");
                        cellH7.Text = resVitalsname[6];
                        cellH8.Attributes.Add("align", "left");
                        cellH8.Text = resVitalsname[7];
                        rowH.Cells.Add(cellH1);
                        rowH.Cells.Add(cellH2);
                        rowH.Cells.Add(cellH3);
                        rowH.Cells.Add(cellH4);
                        rowH.Cells.Add(cellH5);
                        rowH.Cells.Add(cellH6);
                        rowH.Cells.Add(cellH7);
                        rowH.Cells.Add(cellH8);
                        rowH.Font.Bold = true;
                        rowH.Style.Add("color", "#000");
                        tblgeneralExamination.Rows.Add(rowH);


                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        TableCell cell2 = new TableCell();
                        TableCell cell3 = new TableCell();
                        TableCell cell4 = new TableCell();
                        TableCell cell5 = new TableCell();
                        TableCell cell6 = new TableCell();
                        TableCell cell7 = new TableCell();
                        TableCell cell8 = new TableCell();
                        if (resVitalsvalue[0] != "0.00")
                        {
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
                        }
                        else
                        {
                            cell1.Text = "-";
                        }
                        if (resVitalsvalue[1] != "0.00")
                        {
                            //cell2.Attributes.Add("align", "left");
                            //cell2.Text = resVitalsvalue[1] + " " + resVitalsunit[1];
                            cell2.Attributes.Add("align", "left");
                            string SBP = resVitalsvalue[1];
                            string[] resSBP = SBP.Split('.');
                            cell2.Text = resSBP[0] + " " + resVitalsunit[1];
                        }
                        else
                        {
                            cell2.Text = "-";
                        }
                        if (resVitalsvalue[2] != "0.00")
                        {
                            //cell3.Attributes.Add("align", "left");
                            //cell3.Text = resVitalsvalue[2] + " " + resVitalsunit[2];

                            cell3.Attributes.Add("align", "left");
                            string DBP = resVitalsvalue[2];
                            string[] resDBP = DBP.Split('.');
                            cell3.Text = resDBP[0] + " " + resVitalsunit[2];
                        }
                        else
                        {
                            cell3.Text = "-";
                        }
                        if (resVitalsvalue[3] != "0.00")
                        {
                            //cell4.Attributes.Add("align", "left");
                            //cell4.Text = resVitalsvalue[3] + " " + resVitalsunit[3];
                            cell4.Attributes.Add("align", "left");
                            string Pulse = resVitalsvalue[3];
                            string[] resPulse = Pulse.Split('.');
                            cell4.Text = resPulse[0] + " " + resVitalsunit[3];
                        }
                        else
                        {
                            cell4.Text = "-";
                        }

                        if (resVitalsvalue[4] != "0.00")
                        {
                            cell5.Attributes.Add("align", "left");
                            cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
                        }
                        else
                        {
                            cell5.Text = "-";
                        }
                        if (resVitalsvalue[5] != "0.00")
                        {
                            cell6.Attributes.Add("align", "left");
                            cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
                        }
                        else
                        {
                            cell6.Text = "-";
                        }

                        if (resVitalsvalue[6] != "0.00")
                        {
                            cell7.Attributes.Add("align", "left");
                            cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
                        }
                        else
                        {
                            cell7.Text = "-";
                        }

                        if (resVitalsvalue[7] != "0.00")
                        {
                            //cell8.Attributes.Add("align", "left");
                            //cell8.Text = resVitalsvalue[7] + " " + resVitalsunit[7];
                            cell8.Attributes.Add("align", "left");
                            string RR = resVitalsvalue[7];
                            string[] resRR = RR.Split('.');
                            cell8.Text = resRR[0] + " " + resVitalsunit[7];
                        }
                        else
                        {
                            cell8.Text = "-";
                        }

                        row1.Cells.Add(cell1);
                        row1.Cells.Add(cell2);
                        row1.Cells.Add(cell3);
                        row1.Cells.Add(cell4);
                        row1.Cells.Add(cell5);
                        row1.Cells.Add(cell6);
                        row1.Cells.Add(cell7);
                        row1.Cells.Add(cell8);
                        row1.Style.Add("color", "#000");
                        tblgeneralExamination.Rows.Add(row1);

                    }
                }

                var NeedDischargeVitalsInDSY = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedDischargeVitalsInDSY"
                                                      && res.DischargeConfigValue == "N"
                                               select res;

                if (NeedDischargeVitalsInDSY.Count() == 0)
                {
                    if (lstPatientVitalsCount[0].VitalsSetID > 8)
                    {
                        if (lstDischargeVitalsUOMJoin.Count > 0)
                        {
                            trDischargeVitals.Style.Add("display", "block");

                            //TableRow rowH = new TableRow();
                            //TableCell cellH1 = new TableCell();
                            //TableCell cellH2 = new TableCell();
                            //cellH1.Attributes.Add("align", "left");
                            //cellH1.Text = "Vitals";
                            //rowH.Cells.Add(cellH1);
                            //rowH.Font.Bold = true;
                            //rowH.Style.Add("color", "#000");
                            //tblgeneralExamination.Rows.Add(rowH);
                            //foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
                            //{
                            //    TableRow row1 = new TableRow();
                            //    TableCell cell1 = new TableCell();
                            //    cell1.Attributes.Add("align", "left");
                            //    cell1.Text = oVitalsUOMJoin.VitalsName + "-" + oVitalsUOMJoin.VitalsValue.ToString() + "" + oVitalsUOMJoin.UOMCode;
                            //    row1.Cells.Add(cell1);
                            //    row1.Style.Add("color", "#000");
                            //    tblgeneralExamination.Rows.Add(row1);
                            //}


                            string Vitalsname = string.Empty;
                            string Vitalsvalue = string.Empty;
                            string Vitalsunit = string.Empty;

                            foreach (var oVitalsUOMJoin in lstDischargeVitalsUOMJoin)
                            {
                                if (Vitalsname == string.Empty)
                                {
                                    Vitalsname = oVitalsUOMJoin.VitalsName;
                                }
                                else
                                {
                                    Vitalsname += "," + oVitalsUOMJoin.VitalsName;
                                }
                                if (Vitalsvalue == string.Empty)
                                {
                                    Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
                                }
                                else
                                {
                                    Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
                                }
                                if (Vitalsunit == string.Empty)
                                {
                                    Vitalsunit = oVitalsUOMJoin.UOMCode;
                                }
                                else
                                {
                                    Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
                                }
                            }

                            string[] resVitalsname = Vitalsname.Split(',');
                            string[] resVitalsvalue = Vitalsvalue.Split(',');
                            string[] resVitalsunit = Vitalsunit.Split(',');



                            TableRow rowH = new TableRow();
                            TableCell cellH1 = new TableCell();
                            TableCell cellH2 = new TableCell();
                            TableCell cellH3 = new TableCell();
                            TableCell cellH4 = new TableCell();
                            TableCell cellH5 = new TableCell();
                            TableCell cellH6 = new TableCell();
                            TableCell cellH7 = new TableCell();
                            TableCell cellH8 = new TableCell();
                            cellH1.Attributes.Add("align", "left");
                            cellH1.Text = resVitalsname[0];
                            cellH2.Attributes.Add("align", "left");
                            cellH2.Text = resVitalsname[1];
                            cellH3.Attributes.Add("align", "left");
                            cellH3.Text = resVitalsname[2];
                            cellH4.Attributes.Add("align", "left");
                            cellH4.Text = resVitalsname[3];
                            cellH5.Attributes.Add("align", "left");
                            cellH5.Text = resVitalsname[4];
                            cellH6.Attributes.Add("align", "left");
                            cellH6.Text = resVitalsname[5];
                            cellH7.Attributes.Add("align", "left");
                            cellH7.Text = resVitalsname[6];
                            cellH8.Attributes.Add("align", "left");
                            cellH8.Text = resVitalsname[7];
                            rowH.Cells.Add(cellH1);
                            rowH.Cells.Add(cellH2);
                            rowH.Cells.Add(cellH3);
                            rowH.Cells.Add(cellH4);
                            rowH.Cells.Add(cellH5);
                            rowH.Cells.Add(cellH6);
                            rowH.Cells.Add(cellH7);
                            rowH.Cells.Add(cellH8);
                            rowH.Font.Bold = true;
                            rowH.Style.Add("color", "#000");
                            tbDischargeVitals.Rows.Add(rowH);


                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            TableCell cell2 = new TableCell();
                            TableCell cell3 = new TableCell();
                            TableCell cell4 = new TableCell();
                            TableCell cell5 = new TableCell();
                            TableCell cell6 = new TableCell();
                            TableCell cell7 = new TableCell();
                            TableCell cell8 = new TableCell();
                            if (resVitalsvalue[0] != "0.00")
                            {
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
                            }
                            else
                            {
                                cell1.Text = "-";
                            }
                            if (resVitalsvalue[1] != "0.00")
                            {
                                //cell2.Attributes.Add("align", "left");
                                //cell2.Text = resVitalsvalue[1] + " " + resVitalsunit[1];
                                cell2.Attributes.Add("align", "left");
                                string SBP = resVitalsvalue[1];
                                string[] resSBP = SBP.Split('.');
                                cell2.Text = resSBP[0] + " " + resVitalsunit[1];
                            }
                            else
                            {
                                cell2.Text = "-";
                            }
                            if (resVitalsvalue[2] != "0.00")
                            {
                                //cell3.Attributes.Add("align", "left");
                                //cell3.Text = resVitalsvalue[2] + " " + resVitalsunit[2];

                                cell3.Attributes.Add("align", "left");
                                string DBP = resVitalsvalue[2];
                                string[] resDBP = DBP.Split('.');
                                cell3.Text = resDBP[0] + " " + resVitalsunit[2];
                            }
                            else
                            {
                                cell3.Text = "-";
                            }
                            if (resVitalsvalue[3] != "0.00")
                            {
                                //cell4.Attributes.Add("align", "left");
                                //cell4.Text = resVitalsvalue[3] + " " + resVitalsunit[3];
                                cell4.Attributes.Add("align", "left");
                                string Pulse = resVitalsvalue[3];
                                string[] resPulse = Pulse.Split('.');
                                cell4.Text = resPulse[0] + " " + resVitalsunit[3];
                            }
                            else
                            {
                                cell4.Text = "-";
                            }

                            if (resVitalsvalue[4] != "0.00")
                            {
                                cell5.Attributes.Add("align", "left");
                                cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
                            }
                            else
                            {
                                cell5.Text = "-";
                            }
                            if (resVitalsvalue[5] != "0.00")
                            {
                                cell6.Attributes.Add("align", "left");
                                cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
                            }
                            else
                            {
                                cell6.Text = "-";
                            }

                            if (resVitalsvalue[6] != "0.00")
                            {
                                cell7.Attributes.Add("align", "left");
                                cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
                            }
                            else
                            {
                                cell7.Text = "-";
                            }

                            if (resVitalsvalue[7] != "0.00")
                            {
                                //cell8.Attributes.Add("align", "left");
                                //cell8.Text = resVitalsvalue[7] + " " + resVitalsunit[7];
                                cell8.Attributes.Add("align", "left");
                                string RR = resVitalsvalue[7];
                                string[] resRR = RR.Split('.');
                                cell8.Text = resRR[0] + " " + resVitalsunit[7];
                            }
                            else
                            {
                                cell8.Text = "-";
                            }

                            row1.Cells.Add(cell1);
                            row1.Cells.Add(cell2);
                            row1.Cells.Add(cell3);
                            row1.Cells.Add(cell4);
                            row1.Cells.Add(cell5);
                            row1.Cells.Add(cell6);
                            row1.Cells.Add(cell7);
                            row1.Cells.Add(cell8);
                            row1.Style.Add("color", "#000");
                            tbDischargeVitals.Rows.Add(row1);

                        }
                    }
                }


                if (lstPatientExamination.Count > 0)
                {
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();
                    cell2.Attributes.Add("align", "left");
                    string pSwollen = string.Empty;
                    string resSwollen = string.Empty;
                    foreach (var oPatientExamination in lstPatientExamination)
                    {

                        if (oPatientExamination.Description == "")
                        {
                            if (oPatientExamination.ExaminationName.Contains("Swollen"))
                            {
                                if (pSwollen == string.Empty)
                                {
                                    pSwollen = oPatientExamination.ExaminationName;
                                }
                                else
                                {
                                    pSwollen = pSwollen + "," + oPatientExamination.ExaminationName;
                                }

                            }
                            else
                            {
                                if (oPatientExamination.ExaminationName != "CVS" && oPatientExamination.ExaminationName != "RS" && oPatientExamination.ExaminationName != "ABD" && oPatientExamination.ExaminationName != "CNS" && oPatientExamination.ExaminationName != "P/R" && oPatientExamination.ExaminationName != "Genitalia" && oPatientExamination.ExaminationName != "Others")

                                    cell2.Text = oPatientExamination.ExaminationName + " ," + cell2.Text;
                            }
                        }

                    }

                    string[] splitSwollen = pSwollen.Split(',');
                    if (splitSwollen.Length > 1)
                    {
                        foreach (var pSwollenitems in splitSwollen)
                        {
                            string[] rowSplit = pSwollenitems.Split(' ');
                            if (rowSplit[2] == "Lymph")
                            {
                                if (resSwollen == string.Empty)
                                {
                                    resSwollen = "Swollen Lymph Nodes" + "(" + rowSplit[1];
                                }
                                else
                                {
                                    resSwollen = resSwollen + "," + rowSplit[1];
                                }

                            }
                        }

                        cell2.Text = cell2.Text + resSwollen + ")" + "+";
                    }

                    else
                    {
                        if (splitSwollen.Length == 1)
                        {
                            resSwollen = splitSwollen[0];
                            cell2.Text = cell2.Text + resSwollen;
                        }
                        else if (splitSwollen.Length == 0)
                        {
                            cell2.Text = cell2.Text;
                        }

                    }

                    //if (cell2.Text != "")
                    //{
                    //    cell2.Text = cell2.Text + resSwollen + ")" +"+";
                    //}

                    var NeedGeneralExaminationInDSY = from res in lstAllDischargeConfig
                                                      where res.DischargeConfigKey == "NeedGeneralExaminationInDSY"
                                                            && res.DischargeConfigValue == "N"
                                                      select res;


                    if (NeedGeneralExaminationInDSY.Count() == 0)
                    {
                        if (lstNegativeExamination.Count > 0)
                        {
                            lblGeneralExam.Text = "";


                            string Febrile = string.Empty;

                            var lstFebrile = from res in lstNegativeExamination
                                             where res.ExaminationName == "Febrile"
                                             select res;

                            if (lstFebrile.Count() > 0)
                            {
                                Febrile = "Afebrile";
                            }
                            string NegaitiveSigns = string.Empty;
                            foreach (var oNegativeExamination in lstNegativeExamination)
                            {
                                if (NegaitiveSigns == string.Empty)
                                {
                                    if (oNegativeExamination.ExaminationName != "Febrile")
                                    {
                                        NegaitiveSigns = oNegativeExamination.ExaminationName;
                                    }
                                }
                                else
                                {
                                    if (oNegativeExamination.ExaminationName != "Febrile")
                                    {
                                        NegaitiveSigns += ", " + oNegativeExamination.ExaminationName;
                                    }
                                }
                            }

                            // new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedNegativeExamInDSY", OrgID, out lstDischargeConfig);

                            //var NeedNegativeExamInDSY = from res in lstAllDischargeConfig
                            //                            where res.DischargeConfigKey == "NeedNegativeExamInDSY"
                            //                                        && res.DischargeConfigValue == "N"
                            //                            select res;
                            if (lstDischargeSummary.Count > 0)
                            {
                                if (lstDischargeSummary[0].PrintNegativeExam == "N")
                                {
                                    trGeneralExamination.Style.Add("display", "None");
                                    trNegativeExam.Style.Add("display", "None");

                                }

                                else
                                {
                                    trGeneralExamination.Style.Add("display", "block");
                                    trNegativeExam.Style.Add("display", "block");
                                    if (NegaitiveSigns != "" && Febrile != "")
                                    {
                                        lblGeneralExam.Text = Febrile + ",  " + "No signs of" + " " + NegaitiveSigns + ".";
                                    }

                                    if (NegaitiveSigns != "" && Febrile == "")
                                    {
                                        lblGeneralExam.Text = "No signs of" + " " + NegaitiveSigns + ".";
                                    }
                                    if (NegaitiveSigns == "" && Febrile != "")
                                    {
                                        lblGeneralExam.Text = Febrile + " .";
                                    }
                                }
                            }

                          

                            if (NeedGeneralExaminationInDSY.Count() == 0)
                            {
                                if (cell2.Text != "")
                                {
                                    trGeneralExamination.Style.Add("display", "block");
                                    row2.Cells.Add(cell2);
                                    row2.Style.Add("color", "#000");
                                    tblGeneralExam.Rows.Add(row2);
                                }
                            }



                        }
                    }
                    var NeedSystamaticExaminationInDSY = from res in lstAllDischargeConfig
                                                         where res.DischargeConfigKey == "NeedSystamaticExaminationInDSY"
                                                                && res.DischargeConfigValue == "N"
                                                         select res;


                    if (NeedSystamaticExaminationInDSY.Count() == 0)
                    {
                        foreach (var oPatientExamination in lstPatientExamination)
                        {
                            trSystemicExam.Style.Add("display", "block");
                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            if (oPatientExamination.Description != "")
                            {
                                cell1.Text = oPatientExamination.ExaminationName + " - " + oPatientExamination.Description;

                            }


                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblSystamaticExamination.Rows.Add(row1);
                        }
                    }
                }


                var NeedDischargePrescriptionInDSY = from res in lstAllDischargeConfig
                                                     where res.DischargeConfigKey == "NeedDischargePrescriptionInDSY"
                                                            && res.DischargeConfigValue == "N"
                                                     select res;


                if (NeedDischargePrescriptionInDSY.Count() == 0)
                {
                    if (lstDrugDetails.Count > 0)
                    {
                        var lstDsy = from resDsy in lstDrugDetails
                                     where resDsy.PrescriptionType == "DSY"
                                     select resDsy;

                        if (lstDsy.Count() > 0)
                        {


                            trPrescription.Style.Add("display", "block");

                            TableRow rowH = new TableRow();
                            TableCell cellH1 = new TableCell();
                            TableCell cellH2 = new TableCell();
                            TableCell cellH3 = new TableCell();
                            TableCell cellH4 = new TableCell();
                            TableCell cellH5 = new TableCell();
                            TableCell cellH6 = new TableCell();
                            TableCell cellH7 = new TableCell();
                            cellH1.Attributes.Add("align", "left");
                            cellH1.Text = "Drug Name";
                            cellH2.Attributes.Add("align", "left");
                            cellH2.Text = "Dose";
                            cellH3.Attributes.Add("align", "left");
                            cellH3.Text = "Formulation";
                            cellH4.Attributes.Add("align", "left");
                            cellH4.Text = "ROA";
                            cellH5.Attributes.Add("align", "left");
                            cellH5.Text = "DrugFrequency";
                            cellH6.Attributes.Add("align", "left");
                            cellH6.Text = "Duration";
                            cellH7.Attributes.Add("align", "left");
                            cellH7.Text = "Instruction";
                            rowH.Cells.Add(cellH1);
                            rowH.Cells.Add(cellH2);
                            rowH.Cells.Add(cellH3);
                            rowH.Cells.Add(cellH4);
                            rowH.Cells.Add(cellH5);
                            rowH.Cells.Add(cellH6);
                            rowH.Cells.Add(cellH7);
                            rowH.Font.Bold = true;
                            rowH.Style.Add("color", "#000");
                            tblprescription.Rows.Add(rowH);
                            foreach (var oDrugDetails in lstDsy)
                            {

                                TableRow row1 = new TableRow();
                                TableCell cell1 = new TableCell();
                                TableCell cell2 = new TableCell();
                                TableCell cell3 = new TableCell();
                                TableCell cell4 = new TableCell();
                                TableCell cell5 = new TableCell();
                                TableCell cell6 = new TableCell();
                                TableCell cell7 = new TableCell();
                                cell1.Attributes.Add("align", "left");
                                cell1.Text = oDrugDetails.DrugName;
                                cell2.Attributes.Add("align", "left");
                                cell2.Text = oDrugDetails.Dose;
                                cell3.Attributes.Add("align", "left");
                                cell3.Text = oDrugDetails.DrugFormulation;
                                cell4.Attributes.Add("align", "left");
                                cell4.Text = oDrugDetails.ROA;
                                cell5.Attributes.Add("align", "left");
                                cell5.Text = oDrugDetails.DrugFrequency;
                                cell6.Attributes.Add("align", "left");
                                cell6.Text = oDrugDetails.Days;
                                cell7.Attributes.Add("align", "left");
                                cell7.Text = oDrugDetails.Instruction.ToString();
                                row1.Cells.Add(cell1);
                                row1.Cells.Add(cell2);
                                row1.Cells.Add(cell3);
                                row1.Cells.Add(cell4);
                                row1.Cells.Add(cell5);
                                row1.Cells.Add(cell6);
                                row1.Cells.Add(cell7);


                                row1.Style.Add("color", "#000");
                                tblprescription.Rows.Add(row1);
                            }
                        }
                    }
                }

                var NeedAdviceInDSY = from res in lstAllDischargeConfig
                                      where res.DischargeConfigKey == "NeedAdviceInDSY"
                                             && res.DischargeConfigValue == "N"
                                      select res;

                if (NeedAdviceInDSY.Count() == 0)
                {
                    trAdvice.Style.Add("display", "block");
                    if (lstPatientAdvice.Count > 0)
                    {

                        foreach (var oPatientAdvice in lstPatientAdvice)
                        {
                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = oPatientAdvice.Description;
                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblAdvice.Rows.Add(row1);
                        }
                    }
                }




                var NeedTreatmentPlanInDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedTreatmentPlanInDSY"
                                                        && res.DischargeConfigValue == "N"
                                             select res;

                if (NeedTreatmentPlanInDSY.Count() == 0)
                {
                    if (lstOperationIPTreatmentPlan.Count > 0)
                    {
                        //var lstTreatmentPlan = from resPlan in lstOperationIPTreatmentPlan
                        //                       where resPlan.StagePlanned == "DSY"
                        //                       select resPlan;

                        trplan.Style.Add("display", "block");
                        //trplan.Style.Add("display", "none");


                        TableRow rowH = new TableRow();
                        TableCell cellH1 = new TableCell();
                        TableCell cellH2 = new TableCell();
                        TableCell cellH3 = new TableCell();
                        TableCell cellH4 = new TableCell();
                        cellH1.Attributes.Add("align", "left");
                        cellH1.Text = "Type";
                        cellH2.Attributes.Add("align", "left");
                        cellH2.Text = "Treatment Name";
                        cellH3.Attributes.Add("align", "left");
                        cellH3.Text = "Prosthesis";
                        cellH4.Attributes.Add("align", "left");
                        cellH4.Text = "TreatmentPlan Date";
                        rowH.Cells.Add(cellH1);
                        rowH.Cells.Add(cellH2);
                        rowH.Cells.Add(cellH3);
                        rowH.Cells.Add(cellH4);
                        rowH.Font.Bold = true;
                        rowH.Style.Add("color", "#000");
                        tblPlan.Rows.Add(rowH);

                        foreach (var oIPTreatmentPlan in lstOperationIPTreatmentPlan)
                        {
                            TableRow row1 = new TableRow();

                            TableCell cell1 = new TableCell();
                            TableCell cell2 = new TableCell();
                            TableCell cell3 = new TableCell();
                            TableCell cell4 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = oIPTreatmentPlan.ParentName;
                            cell2.Attributes.Add("align", "left");
                            cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;
                            cell3.Attributes.Add("align", "left");
                            cell3.Text = oIPTreatmentPlan.Prosthesis;
                            if (oIPTreatmentPlan.TreatmentPlanDate == DateTime.MinValue)
                            {
                                cell4.Attributes.Add("align", "left");
                                cell4.Text = "Will Be Scheduled later";
                            }
                            else
                            {
                                cell4.Attributes.Add("align", "left");


                                string[] splitDate = oIPTreatmentPlan.TreatmentPlanDate.ToString().Split(' ');

                                if (splitDate[1] == "00:00:00")
                                {

                                    cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString("dd/MM/yyyy");
                                }
                                else
                                {
                                    cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString("dd/MM/yyyy hh:mm tt");
                                }
                            }
                            row1.Cells.Add(cell1);
                            row1.Cells.Add(cell2);
                            row1.Cells.Add(cell3);
                            row1.Cells.Add(cell4);

                            row1.Style.Add("color", "#000");
                            tblPlan.Rows.Add(row1);
                        }



                    }
                }

            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in GetDischargeSummaryCaseSheeDetailst.aspx", ex);
        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (patientVisitID == 0)
        {
            patientVisitID = Convert.ToInt64(Session["VisitID"].ToString());

        }

        try
        {
            Response.Redirect("../Physician/DischargeSummary.aspx?&vid=" + patientVisitID + "&pid=" + patientID, true);

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Displaying DischargeSummary  page", ex);
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
    protected void repTreatmentPlan_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            OperationNotes OPN = (OperationNotes)e.Item.DataItem;
            Table tblSOI = (Table)e.Item.FindControl("tblSOI");


            Label lblTreatmentName = (Label)e.Item.FindControl("lblTreatmentName");
            Label lblTreatmentNameT = (Label)e.Item.FindControl("lblTreatmentNameT");

            if (OPN.TreatmentName == "")
            {
                tblSOI.Rows[0].Style.Add("display", "none");
            }

            if (OPN.TreatmentName == null)
            {
                tblSOI.Rows[0].Style.Add("display", "none");
            }

            Label lblFromTime = (Label)e.Item.FindControl("lblFromTime");
            Label lblFromTimeT = (Label)e.Item.FindControl("lblFromTimeT");

            if (OPN.FromTime == DateTime.MinValue)
            {
                tblSOI.Rows[1].Style.Add("display", "none");
            }
            else
            {
                lblFromTime.Text = OPN.FromTime.ToString("dd/MM/yyyy");
            }

            Label lblAnesthesiaTypeT = (Label)e.Item.FindControl("lblAnesthesiaTypeT");
            Label lblAnesthesiaType = (Label)e.Item.FindControl("lblAnesthesiaType");

            if (OPN.AnesthesiaType == "")
            {
                tblSOI.Rows[2].Style.Add("display", "none");
            }

            if (OPN.AnesthesiaType == null)
            {
                tblSOI.Rows[2].Style.Add("display", "none");
            }

            Label lblSurgeryTypeT = (Label)e.Item.FindControl("lblSurgeryTypeT");
            Label lblSurgeryType = (Label)e.Item.FindControl("lblSurgeryType");

            if (OPN.SurgeryType == "")
            {
                tblSOI.Rows[3].Style.Add("display", "none");
            }

            if (OPN.SurgeryType == null)
            {
                tblSOI.Rows[3].Style.Add("display", "none");
            }

            Label lblOperationTypeT = (Label)e.Item.FindControl("lblOperationTypeT");
            Label lblOperationType = (Label)e.Item.FindControl("lblOperationType");


            if (OPN.OperationType == "")
            {
                tblSOI.Rows[4].Style.Add("display", "none");
            }
            if (OPN.OperationType == null)
            {
                tblSOI.Rows[4].Style.Add("display", "none");
            }

            Label lblOperationFindingsT = (Label)e.Item.FindControl("lblOperationFindingsT");
            Label lblOperationFindings = (Label)e.Item.FindControl("lblOperationFindings");

            if (OPN.OperativeFindings == "")
            {
                tblSOI.Rows[5].Style.Add("display", "none");
            }
            if (OPN.OperativeFindings == null)
            {
                tblSOI.Rows[5].Style.Add("display", "none");
            }


            Label lblOperativeTechniqueT = (Label)e.Item.FindControl("lblOperativeTechniqueT");
            Label lblOperativeTechnique = (Label)e.Item.FindControl("lblOperativeTechnique");

            if (OPN.OperativeTechnique == "")
            {
                tblSOI.Rows[6].Style.Add("display", "none");
            }

            if (OPN.OperativeTechnique == null)
            {
                tblSOI.Rows[6].Style.Add("display", "none");
            }

        }
    }
    protected void gvDischargeDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DischargeSummary d = (DischargeSummary)e.Row.DataItem;
            string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + d.PatientVistID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            Label lblDiagnosis = (Label)e.Row.FindControl("lblDiagnosis");
            Label lblSurgery = (Label)e.Row.FindControl("lblSurgery");
            Label lblPhysician = (Label)e.Row.FindControl("lblPhysician");
            patientVisitID = d.PatientVistID;

            returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes, out OrthoCount);

            //Bind Diagnosis
            int count = 0;
            string sDiagnosis = string.Empty;
            string sSurgery = string.Empty;
            if (lstPatientComplaint.Count > 0)
            {
                foreach (var oPatientComplaint in lstPatientComplaint)
                {
                    if (count <= 2)
                    {
                        if (sDiagnosis == string.Empty)
                        {
                            sDiagnosis = oPatientComplaint.ComplaintName;
                            count++;
                        }
                        else
                        {
                            sDiagnosis += "," + oPatientComplaint.ComplaintName;
                            count++;
                        }
                    }
                }

                lblDiagnosis.Text = sDiagnosis;
            }

            else
            {
                lblDiagnosis.Text = "-";
            }

            if (lstCaserecordIPTreatmentPlan.Count > 0)
            {

                foreach (var oIPTreatmentPlan in lstCaserecordIPTreatmentPlan)
                {
                    if (count <= 2)
                    {
                        if (sSurgery == string.Empty)
                        {
                            sSurgery = oIPTreatmentPlan.IPTreatmentPlanName;
                            count++;
                        }
                        else
                        {
                            sSurgery += "," + oIPTreatmentPlan.IPTreatmentPlanName;
                            count++;
                        }
                    }
                }

                lblSurgery.Text = sSurgery;
            }

            else
            {
                lblSurgery.Text = "-";
            }


            if (lstInPatientAdmissionDetails.Count > 0)
            {

                lblPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;

            }

        }

    }

    protected void btnEditDischrageDetails_Click(object sender, EventArgs e)
    {
        string rdoVisitID;

        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            rdoVisitID = Request.Form["pid"];
            Session["VisitID"] = rdoVisitID;
            patientVisitID = Convert.ToInt32(rdoVisitID.ToString());
            GetDischargeSummaryCaseSheet();
            GetPatientHistory();
            tblDischargeDetail.Style.Add("display", "none");
            tblSave.Style.Add("display", "block");
            tblDischrageResult.Style.Add("display", "block");

        }
    }
}
