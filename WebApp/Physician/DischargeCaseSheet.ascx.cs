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

public partial class Physician_DischargeCaseSheet : BaseControl
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;
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

    List<GeneralAdvice> lstGeneralAdvice = new List<GeneralAdvice>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();




    //Newly Added
    List<PatientVitals> lstPatientVitalsCount = new List<PatientVitals>();
    List<VitalsUOMJoin> lstDischargeVitalsUOMJoin = new List<VitalsUOMJoin>();

    List<IPComplaint> lstNegativeIPComplaint = new List<IPComplaint>();
    List<Examination> lstNegativeExamination = new List<Examination>();

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();

    List<RoomMaster> lstRoomMaster = new List<RoomMaster>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();



    IP_BL oIP_BL;

    protected void Page_Load(object sender, EventArgs e)
    {
        oIP_BL = new IP_BL(base.ContextInfo);
        //try
        //{

        //    VistType = Request.QueryString["vType"];
        //    if (VistType == "IP")
        //    {
        //        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        //        Int64.TryParse(Request.QueryString["pid"], out patientID);
              
        //    }
           
        //    if (!IsPostBack)
        //    {
        //        if (VistType == "IP")
        //        {
        //            tblDischargeDetail.Style.Add("display", "none");
        //            GetDischargeSummaryCaseSheet();
        //            GetPatientHistory();
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
          
        //    CLogger.LogError("Error in DischargeSummaryCaseSheet.aspx:Page_Load", ex);
        //}
        if (!Page.IsPostBack)
        {



        }
    }



    public bool LoadPatientDischarge(long patientVisitID)
    {
        
        try
        {
            returnCode = oIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);

            returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes, out OrthoCount);

           
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

                    //if (lsPatient[0].SEX == "M")
                    //{
                    //    if (BloodGroup != "")
                    //    {
                    //        lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    //    }
                    //    else
                    //    {
                    //        lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                    //    }

                    //}
                    //else if (lsPatient[0].SEX == "F")
                    //{
                    //    if (BloodGroup != "")
                    //    {
                    //        lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    //    }
                    //    else
                    //    {
                    //        lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                    //    }
                    //}

                    if (OrgID == 26)
                    {
                        if (lsPatient[0].SEX == "M")
                        {

                            if (lstInPatientNumber.Count == 0)
                            {
                                IpNumber = "-";
                            }
                            else
                            {
                                IpNumber = lstInPatientNumber[0].IPNumber.ToString();
                            }

                            if (BloodGroup != "")
                            {
                                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + BloodGroup;
                            }

                        }
                        else if (lsPatient[0].SEX == "F")
                        {
                            if (lstInPatientNumber.Count == 0)
                            {
                                IpNumber = "-";
                            }
                            else
                            {
                                IpNumber = lstInPatientNumber[0].IPNumber.ToString();
                            }
                            if (BloodGroup != "")
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "," + "(IP NO-" + IpNumber + ")" + "," + "(UNIT/Ward:-" + lstRoomMaster[0].RoomName + ")" + BloodGroup;

                            }
                        }
                    }

                    else
                    {
                        if (lsPatient[0].SEX == "M")
                        {
                            if (BloodGroup != "")
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                            }

                        }
                        else if (lsPatient[0].SEX == "F")
                        {
                            if (BloodGroup != "")
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                lblPatientDetail.Text =  lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                            }
                        }
                    }
                }

                if (lstInPatientAdmissionDetails.Count > 0)
                {
                    //lblDOA.Text = lstInPatientAdmissionDetails[0].AdmissionDate.ToString();
                    string CPhysician = lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                    string CSurgeon = lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
                    if (CPhysician != "")
                    {
                        //trCPhysician.Style.Add("display", "block");
                        trCPhysician.Style.Add("display", "none");
                        lblCPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                        trConsultant.Style.Add("display", "block");
                        lblConsultant.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                    }
                    if (CSurgeon != "")
                    {
                        //trCSurgeon.Style.Add("display", "block");
                        trCSurgeon.Style.Add("display", "none");
                        lblCSurgeon.Text = "Dr." + lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
                    }

                }

                if (lstAdmissionDate.Count > 0)
                {
                    if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
                    {
                        lblDOA.Text = "";
                    }
                    else
                    {
                        trDOA.Style.Add("display", "block");
                        lblDOA.Text = lstAdmissionDate[0].AdmissionDate.ToString();
                    }
                }
                if (lstOperationNotes.Count > 0)
                {

                    if (lstOperationNotes[0].FromTime == DateTime.MinValue)
                    {
                        lblDOS.Text = "";
                    }
                    else
                    {
                        trDOS.Style.Add("display", "block");
                        lblDOS.Text = lstOperationNotes[0].FromTime.ToString();
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

                        lblNextReview.Text = "After" + lstDischargeSummary[0].NextReviewAfter.ToString();
                    }


                    string HospitalCourse = lstDischargeSummary[0].HospitalCourse;
                    var lstCRC = from resCRC in lstDrugDetails
                                 where resCRC.PrescriptionType == "CRC"
                                 select resCRC;

                    if (HospitalCourse != string.Empty || lstCRC.Count() > 0)
                    {
                        trCourseHospital.Style.Add("display", "block");
                        ltrHospitalcourse.Text = lstDischargeSummary[0].HospitalCourse;

                        if (OrgID == 29)
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

                    if (lstDischargeSummary[0].DateOfDischarge == DateTime.MinValue)
                    {
                        lblDOD.Text = "";
                    }
                    else
                    {
                        trDOS.Style.Add("display", "block");
                        lblDOD.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
                    }

                    if (lstDischargeSummary[0].DischargeTypeName == "Expired")
                    {
                        lblTypeOfDis.Text = "Death Summary";

                    }
                    else
                    {
                        lblTypeOfDis.Text = "Discharge Summary";
                        lblDischargeTypeName.Text = "(" + lstDischargeSummary[0].DischargeTypeName + ")";
                    }

                }

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


                if (lstPatientAddress.Count > 0)
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


                if (lstPatientAddress.Count > 0)
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

                if (lstCaserecordIPTreatmentPlan.Count > 0)
                {
                    //trSurgery.Style.Add("display", "block");
                    trSurgery.Style.Add("display", "none");
                    repTreatmentPlan.DataSource = lstCaserecordIPTreatmentPlan;
                    repTreatmentPlan.DataBind();
                    //if (lstCaserecordIPTreatmentPlan.Count > 0)
                    //{
                    //    TableRow rowH = new TableRow();
                    //    TableCell cellH1 = new TableCell();
                    //    TableCell cellH2 = new TableCell();
                    //    TableCell cellH3 = new TableCell();
                    //    cellH1.Attributes.Add("align", "left");
                    //    cellH1.Text = "Type";
                    //    cellH2.Attributes.Add("align", "left");
                    //    cellH2.Text = "Treatment Name";
                    //    cellH3.Attributes.Add("align", "left");
                    //    cellH3.Text = "Prosthesis";
                    //    rowH.Cells.Add(cellH1);
                    //    rowH.Cells.Add(cellH2);
                    //    rowH.Cells.Add(cellH3);
                    //    rowH.Font.Bold = true;
                    //    rowH.BorderWidth = 1;
                    //    rowH.Style.Add("color", "#000");
                    //    tblSurgery.Rows.Add(rowH);

                    //    foreach (var oIPTreatmentPlan in lstCaserecordIPTreatmentPlan)
                    //    {
                    //        TableRow row1 = new TableRow();
                    //        TableCell cell1 = new TableCell();
                    //        TableCell cell2 = new TableCell();
                    //        TableCell cell3 = new TableCell();
                    //        cell1.Attributes.Add("align", "left");
                    //        cell1.Text = oIPTreatmentPlan.ParentName;
                    //        cell2.Attributes.Add("align", "left");
                    //        cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;
                    //        cell3.Attributes.Add("align", "left");
                    //        cell3.Text = oIPTreatmentPlan.Prosthesis;
                    //        row1.Cells.Add(cell1);
                    //        row1.Cells.Add(cell2);
                    //        row1.Cells.Add(cell3);

                    //        row1.Style.Add("color", "#000");
                    //        tblSurgery.Rows.Add(row1);
                    //    }
                    //}

                }


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


                if (lstNegativeIPComplaint.Count > 0)
                {
                    trBackgroundProblem.Style.Add("display", "block");
                    string NegaitiveHis = string.Empty;
                    foreach (var oNegativeIPComplaint in lstNegativeIPComplaint)
                    {
                        if (NegaitiveHis == string.Empty)
                        {
                            NegaitiveHis = oNegativeIPComplaint.ComplaintName;
                        }
                        else
                        {
                            NegaitiveHis += "," + oNegativeIPComplaint.ComplaintName;
                        }
                    }

                    lblBackgroundProblems.Text = "No history of" + " " + NegaitiveHis + ".";
                }

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

                                cell2.Text = oPatientExamination.ExaminationName + "," + cell2.Text;
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

                    if (cell2.Text != "")
                    {
                        trGeneralExamination.Style.Add("display", "block");
                        row2.Cells.Add(cell2);
                        row2.Style.Add("color", "#000");
                        tblGeneralExam.Rows.Add(row2);
                    }

                    if (lstNegativeExamination.Count > 0)
                    {
                        lblGeneralExam.Text = "";
                        trGeneralExamination.Style.Add("display", "block");
                        string NegaitiveSigns = string.Empty;
                        foreach (var oNegativeExamination in lstNegativeExamination)
                        {
                            if (NegaitiveSigns == string.Empty)
                            {
                                NegaitiveSigns = oNegativeExamination.ExaminationName;
                            }
                            else
                            {
                                NegaitiveSigns += "," + oNegativeExamination.ExaminationName;
                            }
                        }

                        lblGeneralExam.Text = "No signs of" + " " + NegaitiveSigns + ".";
                    }


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
                         foreach (var oDrugDetails in lstDrugDetails)
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


                if (lstOperationIPTreatmentPlan.Count > 0)
                {
                    trplan.Style.Add("display", "block");
                    if (lstOperationIPTreatmentPlan.Count > 0)
                    {
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
                                cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString();
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
                            Age =  lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
                        }
                        else
                        {
                            Age =  lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

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
                            Age =  lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

                        }
                    }
                }
                cell2.Text = Age + PatientHistory + ".";


                row2.Cells.Add(cell2);
                row2.Style.Add("color", "#000");
                tblHistory.Rows.Add(row2);

            }
        }

        catch (Exception ex)
        {

            CLogger.LogError("Error in GetDischargeSummaryCaseSheeDetailst.aspx", ex);
        }

        return true;
    }

    protected void repTreatmentPlan_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblProsthesis = (Label)e.Item.FindControl("lblProsthesis");
            Label lblIPTreatmentPlanName = (Label)e.Item.FindControl("lblIPTreatmentPlanName");
            Label lblFromTime = (Label)e.Item.FindControl("lblFromTime");
            Label lblPhysicianName = (Label)e.Item.FindControl("lblPhysicianName");

            if (lblProsthesis.Text == "")
            {
                lblIPTreatmentPlanName.Text = lblIPTreatmentPlanName.Text + "-";
            }
            else
            {
                lblProsthesis.Text = "(" + lblProsthesis.Text + ")";
            }

            if (lblFromTime.Text == DateTime.MinValue.ToString())
            {
                lblFromTime.Text = "";
            }
            else
            {
                lblPhysicianName.Text = lblPhysicianName.Text + "-";
            }

        }
        
    }

    private void GetPatientHistory()
    {
        //try
        //{
        //    returnCode = oIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);

        //    if (lstPatientHistory.Count > 0)
        //    {
        //        trHistory.Style.Add("display", "block");
        //        TableRow row2 = new TableRow();
        //        TableCell cell2 = new TableCell();
        //        cell2.Attributes.Add("align", "left");
        //        string PatientHistory = string.Empty;
        //        string Age = string.Empty;
        //        foreach (var oPatientHistory in lstPatientHistory)
        //        {
        //            if (PatientHistory == string.Empty)
        //            {

        //                if (oPatientHistory.HistoryName != string.Empty)
        //                {
        //                    if (oPatientHistory.Description != " ")
        //                    {
        //                        PatientHistory = oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
        //                    }
        //                    else
        //                    {
        //                        PatientHistory = oPatientHistory.HistoryName;
        //                    }
        //                }

        //            }

        //            else
        //            {

        //                if (oPatientHistory.HistoryName != string.Empty)
        //                {
        //                    if (oPatientHistory.Description != " ")
        //                    {
        //                        PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
        //                    }
        //                    else
        //                    {
        //                        PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName;
        //                    }
        //                }

        //            }

        //        }

        //        if (lsPatient.Count > 0)
        //        {

        //            string[] Age1 = lsPatient[0].Age.Split(' ');
        //            if (lsPatient[0].SEX == "M")
        //            {
        //                if (int.Parse(Age1[0]) > 18 && Age1[1] == "Years")
        //                {
        //                    Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
        //                }
        //                else
        //                {
        //                    Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

        //                }

        //            }
        //            else if (lsPatient[0].SEX == "F")
        //            {
        //                if (int.Parse(Age1[0]) > 18 && Age1[1] == "Years")
        //                {
        //                    Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with history of" + " ";
        //                }
        //                else
        //                {
        //                    Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

        //                }
        //            }
        //        }
        //        cell2.Text = Age + PatientHistory + ".";


        //        row2.Cells.Add(cell2);
        //        row2.Style.Add("color", "#000");
        //        tblHistory.Rows.Add(row2);

        //    }
        //}

        //catch (Exception ex)
        //{
           
        //    CLogger.LogError("Error on Loading INPatientHistory in DischargeSummaryCaseSheet.aspx", ex);
        //}
    }

    private void GetDischargeSummaryCaseSheet(long patientVisitID)
    {
        //try
        //{
        //    returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress);


        //    if (returnCode == 0)
        //    {
        //        string BloodGroup;
        //        if (lsPatient.Count > 0)
        //        {
        //            if (lsPatient[0].BloodGroup == "-1")
        //            {
        //                BloodGroup = "";
        //            }
        //            else
        //            {
        //                BloodGroup = lsPatient[0].BloodGroup;
        //            }

        //            if (lsPatient[0].SEX == "M")
        //            {
        //                if (BloodGroup != "")
        //                {
        //                    lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientID.ToString() + ")" + "  BloodGroup: " + BloodGroup;
        //                }
        //                else
        //                {
        //                    lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientID.ToString() + ")" + BloodGroup;
        //                }

        //            }
        //            else if (lsPatient[0].SEX == "F")
        //            {
        //                if (BloodGroup != "")
        //                {
        //                    lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientID.ToString() + ")" + "  BloodGroup: " + BloodGroup;
        //                }
        //                else
        //                {
        //                    lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientID.ToString() + ")" + BloodGroup;

        //                }
        //            }
        //        }

        //        if (lstInPatientAdmissionDetails.Count > 0)
        //        {
        //            //lblDOA.Text = lstInPatientAdmissionDetails[0].AdmissionDate.ToString();
        //            string CPhysician = lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
        //            string CSurgeon = lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
        //            if (CPhysician != "")
        //            {
        //                trCPhysician.Style.Add("display", "block");
        //                lblCPhysician.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
        //            }
        //            if (CSurgeon != "")
        //            {
        //                trCSurgeon.Style.Add("display", "block");
        //                lblCSurgeon.Text = "Dr." + lstInPatientAdmissionDetails[0].ConsultingSurgeonName;
        //            }

        //        }

        //        if (lstAdmissionDate.Count > 0)
        //        {
        //            if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
        //            {
        //                lblDOA.Text = "";
        //            }
        //            else
        //            {
        //                trDOA.Style.Add("display", "block");
        //                lblDOA.Text = lstAdmissionDate[0].AdmissionDate.ToString();
        //            }
        //        }
        //        if (lstOperationNotes.Count > 0)
        //        {

        //            if (lstOperationNotes[0].FromTime == DateTime.MinValue)
        //            {
        //                lblDOS.Text = "";
        //            }
        //            else
        //            {
        //                trDOS.Style.Add("display", "block");
        //                lblDOS.Text = lstOperationNotes[0].FromTime.ToString();
        //            }
        //        }

        //        if (lstDischargeSummary.Count > 0)
        //        {

        //            if (lstDischargeSummary[0].NextReviewAfter.Contains("/"))
        //            {
        //                lblNextReview.Text = lstDischargeSummary[0].NextReviewAfter.ToString();
        //            }
        //            else
        //            {

        //                lblNextReview.Text = "After" + lstDischargeSummary[0].NextReviewAfter.ToString();
        //            }


        //            string HospitalCourse = lstDischargeSummary[0].HospitalCourse;
        //            if (HospitalCourse != string.Empty)
        //            {
        //                trCourseHospital.Style.Add("display", "block");
        //                ltrHospitalcourse.Text = lstDischargeSummary[0].HospitalCourse;
        //            }

        //            if (lstDischargeSummary[0].DateOfDischarge == DateTime.MinValue)
        //            {
        //                lblDOD.Text = "";
        //            }
        //            else
        //            {
        //                trDOS.Style.Add("display", "block");
        //                lblDOD.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
        //            }

        //            lblDischargeTypeName.Text = "(" + lstDischargeSummary[0].DischargeTypeName + ")";

        //        }

        //        if (lstPatientComplaint.Count > 0)
        //        {
        //            trDiagnosis.Style.Add("display", "block");
        //            foreach (var oPatientComplaint in lstPatientComplaint)
        //            {

        //                TableRow row1 = new TableRow();
        //                TableCell cell1 = new TableCell();
        //                cell1.Attributes.Add("align", "left");
        //                cell1.Text = oPatientComplaint.ComplaintName;
        //                row1.Cells.Add(cell1);
        //                row1.Style.Add("color", "#000");
        //                tbldiagnosis.Rows.Add(row1);


        //            }
        //        }


        //        if (lstPatientAddress.Count > 0)
        //        {

        //            string ppermenantAddress = string.Empty;
        //            foreach (var oPatientAddress in lstPatientAddress)
        //            {
        //                if (oPatientAddress.AddressType == "P" && oPatientAddress.Add2 != "")
        //                {
        //                    ppermenantAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.PostalCode + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;
        //                }

        //            }
        //            string[] PAdd = ppermenantAddress.Split(',');
        //            if (PAdd.Length > 1)
        //            {
        //                tdPermenantAddress.Style.Add("display", "block");
        //                foreach (string sPAdd in PAdd)
        //                {
        //                    if (sPAdd != "")
        //                    {
        //                        TableRow row1 = new TableRow();
        //                        TableCell cell1 = new TableCell();
        //                        cell1.Attributes.Add("align", "left");
        //                        cell1.Text = sPAdd;
        //                        row1.Cells.Add(cell1);
        //                        row1.Style.Add("color", "#000");
        //                        tblPermenantAddress.Rows.Add(row1);
        //                    }
        //                }
        //            }
        //        }

        //        if (lstPatientAddress.Count > 0)
        //        {

        //            string pPresentAddress = string.Empty;
        //            foreach (var oPatientAddress in lstPatientAddress)
        //            {
        //                if (oPatientAddress.AddressType == "C" && oPatientAddress.Add2 != "")
        //                {
        //                    pPresentAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + oPatientAddress.PostalCode + "," + oPatientAddress.MobileNumber + "," + oPatientAddress.LandLineNumber;
        //                }

        //            }
        //            string[] PAdd = pPresentAddress.Split(',');

        //            if (PAdd.Length > 1)
        //            {
        //                tdPresentAddress.Style.Add("display", "block");
        //                foreach (string sPAdd in PAdd)
        //                {
        //                    if (sPAdd != "")
        //                    {
        //                        TableRow row1 = new TableRow();
        //                        TableCell cell1 = new TableCell();
        //                        cell1.Attributes.Add("align", "left");
        //                        cell1.Text = sPAdd;
        //                        row1.Cells.Add(cell1);
        //                        row1.Style.Add("color", "#000");
        //                        tblPresentAddress.Rows.Add(row1);
        //                    }
        //                }
        //            }
        //        }


        //        if (lstCaserecordIPTreatmentPlan.Count > 0)
        //        {
        //            trSurgery.Style.Add("display", "block");
        //            repTreatmentPlan.DataSource = lstCaserecordIPTreatmentPlan;
        //            repTreatmentPlan.DataBind();
        //            //if (lstCaserecordIPTreatmentPlan.Count > 0)
        //            //{
        //            //    TableRow rowH = new TableRow();
        //            //    TableCell cellH1 = new TableCell();
        //            //    TableCell cellH2 = new TableCell();
        //            //    TableCell cellH3 = new TableCell();
        //            //    cellH1.Attributes.Add("align", "left");
        //            //    cellH1.Text = "Type";
        //            //    cellH2.Attributes.Add("align", "left");
        //            //    cellH2.Text = "Treatment Name";
        //            //    cellH3.Attributes.Add("align", "left");
        //            //    cellH3.Text = "Prosthesis";
        //            //    rowH.Cells.Add(cellH1);
        //            //    rowH.Cells.Add(cellH2);
        //            //    rowH.Cells.Add(cellH3);
        //            //    rowH.Font.Bold = true;
        //            //    rowH.BorderWidth = 1;
        //            //    rowH.Style.Add("color", "#000");
        //            //    tblSurgery.Rows.Add(rowH);

        //            //    foreach (var oIPTreatmentPlan in lstCaserecordIPTreatmentPlan)
        //            //    {
        //            //        TableRow row1 = new TableRow();
        //            //        TableCell cell1 = new TableCell();
        //            //        TableCell cell2 = new TableCell();
        //            //        TableCell cell3 = new TableCell();
        //            //        cell1.Attributes.Add("align", "left");
        //            //        cell1.Text = oIPTreatmentPlan.ParentName;
        //            //        cell2.Attributes.Add("align", "left");
        //            //        cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;
        //            //        cell3.Attributes.Add("align", "left");
        //            //        cell3.Text = oIPTreatmentPlan.Prosthesis;
        //            //        row1.Cells.Add(cell1);
        //            //        row1.Cells.Add(cell2);
        //            //        row1.Cells.Add(cell3);

        //            //        row1.Style.Add("color", "#000");
        //            //        tblSurgery.Rows.Add(row1);
        //            //    }
        //            //}

        //        }


        //        if (lstBackgroundProblem.Count > 0)
        //        {
        //            trBackgroundProblem.Style.Add("display", "block");
        //            foreach (var oBackgroundProblem in lstBackgroundProblem)
        //            {
        //                TableRow row1 = new TableRow();
        //                TableCell cell1 = new TableCell();
        //                if (oBackgroundProblem.Description != "")
        //                {
        //                    if (oBackgroundProblem.ComplaintName == "Stroke(CVA)")
        //                    {
        //                        string[] PStroke = oBackgroundProblem.Description.Split('^');
        //                        if (PStroke[0].Contains('/'))
        //                        {
        //                            cell1.Attributes.Add("align", "left");
        //                            cell1.Text = oBackgroundProblem.ComplaintName + " - " + PStroke[0] + "," + PStroke[1];
        //                        }
        //                        else
        //                        {
        //                            cell1.Attributes.Add("align", "left");
        //                            cell1.Text = oBackgroundProblem.ComplaintName + " - " + PStroke[1];
        //                        }

        //                    }
        //                    else
        //                    {
        //                        cell1.Attributes.Add("align", "left");
        //                        cell1.Text = oBackgroundProblem.ComplaintName + " - " + oBackgroundProblem.Description;
        //                    }
        //                }
        //                else
        //                {
        //                    cell1.Attributes.Add("align", "left");
        //                    cell1.Text = oBackgroundProblem.ComplaintName;
        //                }
        //                row1.Cells.Add(cell1);
        //                row1.Style.Add("color", "#000");
        //                tblBackgroundProblems.Rows.Add(row1);
        //            }
        //        }


        //        if (lstVitalsUOMJoin.Count > 0)
        //        {
        //            trgeneralExam.Style.Add("display", "block");

        //            //TableRow rowH = new TableRow();
        //            //TableCell cellH1 = new TableCell();
        //            //TableCell cellH2 = new TableCell();
        //            //cellH1.Attributes.Add("align", "left");
        //            //cellH1.Text = "Vitals";
        //            //rowH.Cells.Add(cellH1);
        //            //rowH.Font.Bold = true;
        //            //rowH.Style.Add("color", "#000");
        //            //tblgeneralExamination.Rows.Add(rowH);
        //            //foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
        //            //{
        //            //    TableRow row1 = new TableRow();
        //            //    TableCell cell1 = new TableCell();
        //            //    cell1.Attributes.Add("align", "left");
        //            //    cell1.Text = oVitalsUOMJoin.VitalsName + "-" + oVitalsUOMJoin.VitalsValue.ToString() + "" + oVitalsUOMJoin.UOMCode;
        //            //    row1.Cells.Add(cell1);
        //            //    row1.Style.Add("color", "#000");
        //            //    tblgeneralExamination.Rows.Add(row1);
        //            //}


        //            string Vitalsname = string.Empty;
        //            string Vitalsvalue = string.Empty;
        //            string Vitalsunit = string.Empty;

        //            foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
        //            {
        //                if (Vitalsname == string.Empty)
        //                {
        //                    Vitalsname = oVitalsUOMJoin.VitalsName;
        //                }
        //                else
        //                {
        //                    Vitalsname += "," + oVitalsUOMJoin.VitalsName;
        //                }
        //                if (Vitalsvalue == string.Empty)
        //                {
        //                    Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
        //                }
        //                else
        //                {
        //                    Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
        //                }
        //                if (Vitalsunit == string.Empty)
        //                {
        //                    Vitalsunit = oVitalsUOMJoin.UOMCode;
        //                }
        //                else
        //                {
        //                    Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
        //                }
        //            }

        //            string[] resVitalsname = Vitalsname.Split(',');
        //            string[] resVitalsvalue = Vitalsvalue.Split(',');
        //            string[] resVitalsunit = Vitalsunit.Split(',');



        //            TableRow rowH = new TableRow();
        //            TableCell cellH1 = new TableCell();
        //            TableCell cellH2 = new TableCell();
        //            TableCell cellH3 = new TableCell();
        //            TableCell cellH4 = new TableCell();
        //            TableCell cellH5 = new TableCell();
        //            TableCell cellH6 = new TableCell();
        //            TableCell cellH7 = new TableCell();
        //            TableCell cellH8 = new TableCell();
        //            cellH1.Attributes.Add("align", "left");
        //            cellH1.Text = resVitalsname[0];
        //            cellH2.Attributes.Add("align", "left");
        //            cellH2.Text = resVitalsname[1];
        //            cellH3.Attributes.Add("align", "left");
        //            cellH3.Text = resVitalsname[2];
        //            cellH4.Attributes.Add("align", "left");
        //            cellH4.Text = resVitalsname[3];
        //            cellH5.Attributes.Add("align", "left");
        //            cellH5.Text = resVitalsname[4];
        //            cellH6.Attributes.Add("align", "left");
        //            cellH6.Text = resVitalsname[5];
        //            cellH7.Attributes.Add("align", "left");
        //            cellH7.Text = resVitalsname[6];
        //            cellH8.Attributes.Add("align", "left");
        //            cellH8.Text = resVitalsname[7];
        //            rowH.Cells.Add(cellH1);
        //            rowH.Cells.Add(cellH2);
        //            rowH.Cells.Add(cellH3);
        //            rowH.Cells.Add(cellH4);
        //            rowH.Cells.Add(cellH5);
        //            rowH.Cells.Add(cellH6);
        //            rowH.Cells.Add(cellH7);
        //            rowH.Cells.Add(cellH8);
        //            rowH.Font.Bold = true;
        //            rowH.Style.Add("color", "#000");
        //            tblgeneralExamination.Rows.Add(rowH);


        //            TableRow row1 = new TableRow();
        //            TableCell cell1 = new TableCell();
        //            TableCell cell2 = new TableCell();
        //            TableCell cell3 = new TableCell();
        //            TableCell cell4 = new TableCell();
        //            TableCell cell5 = new TableCell();
        //            TableCell cell6 = new TableCell();
        //            TableCell cell7 = new TableCell();
        //            TableCell cell8 = new TableCell();
        //            if (resVitalsvalue[0] != "0.00")
        //            {
        //                cell1.Attributes.Add("align", "left");
        //                cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
        //            }
        //            else
        //            {
        //                cell1.Text = "-";
        //            }
        //            if (resVitalsvalue[1] != "0.00")
        //            {
        //                //cell2.Attributes.Add("align", "left");
        //                //cell2.Text = resVitalsvalue[1] + " " + resVitalsunit[1];
        //                cell2.Attributes.Add("align", "left");
        //                string SBP = resVitalsvalue[1];
        //                string[] resSBP = SBP.Split('.');
        //                cell2.Text = resSBP[0] + " " + resVitalsunit[1];
        //            }
        //            else
        //            {
        //                cell2.Text = "-";
        //            }
        //            if (resVitalsvalue[2] != "0.00")
        //            {
        //                //cell3.Attributes.Add("align", "left");
        //                //cell3.Text = resVitalsvalue[2] + " " + resVitalsunit[2];

        //                cell3.Attributes.Add("align", "left");
        //                string DBP = resVitalsvalue[2];
        //                string[] resDBP = DBP.Split('.');
        //                cell3.Text = resDBP[0] + " " + resVitalsunit[2];
        //            }
        //            else
        //            {
        //                cell3.Text = "-";
        //            }
        //            if (resVitalsvalue[3] != "0.00")
        //            {
        //                //cell4.Attributes.Add("align", "left");
        //                //cell4.Text = resVitalsvalue[3] + " " + resVitalsunit[3];
        //                cell4.Attributes.Add("align", "left");
        //                string Pulse = resVitalsvalue[3];
        //                string[] resPulse = Pulse.Split('.');
        //                cell4.Text = resPulse[0] + " " + resVitalsunit[3];
        //            }
        //            else
        //            {
        //                cell4.Text = "-";
        //            }

        //            if (resVitalsvalue[4] != "0.00")
        //            {
        //                cell5.Attributes.Add("align", "left");
        //                cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
        //            }
        //            else
        //            {
        //                cell5.Text = "-";
        //            }
        //            if (resVitalsvalue[5] != "0.00")
        //            {
        //                cell6.Attributes.Add("align", "left");
        //                cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
        //            }
        //            else
        //            {
        //                cell6.Text = "-";
        //            }

        //            if (resVitalsvalue[6] != "0.00")
        //            {
        //                cell7.Attributes.Add("align", "left");
        //                cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
        //            }
        //            else
        //            {
        //                cell7.Text = "-";
        //            }

        //            if (resVitalsvalue[7] != "0.00")
        //            {
        //                //cell8.Attributes.Add("align", "left");
        //                //cell8.Text = resVitalsvalue[7] + " " + resVitalsunit[7];
        //                cell8.Attributes.Add("align", "left");
        //                string RR = resVitalsvalue[7];
        //                string[] resRR = RR.Split('.');
        //                cell8.Text = resRR[0] + " " + resVitalsunit[7];
        //            }
        //            else
        //            {
        //                cell8.Text = "-";
        //            }

        //            row1.Cells.Add(cell1);
        //            row1.Cells.Add(cell2);
        //            row1.Cells.Add(cell3);
        //            row1.Cells.Add(cell4);
        //            row1.Cells.Add(cell5);
        //            row1.Cells.Add(cell6);
        //            row1.Cells.Add(cell7);
        //            row1.Cells.Add(cell8);
        //            row1.Style.Add("color", "#000");
        //            tblgeneralExamination.Rows.Add(row1);




        //        }

        //        if (lstPatientExamination.Count > 0)
        //        {

        //            trSystemicExam.Style.Add("display", "block");

        //            TableRow row2 = new TableRow();
        //            TableCell cell2 = new TableCell();
        //            cell2.Attributes.Add("align", "left");
        //            string pSwollen = string.Empty;
        //            string resSwollen = string.Empty;
        //            foreach (var oPatientExamination in lstPatientExamination)
        //            {

        //                if (oPatientExamination.Description == "")
        //                {
        //                    if (oPatientExamination.ExaminationName.Contains("Swollen"))
        //                    {
        //                        if (pSwollen == string.Empty)
        //                        {
        //                            pSwollen = oPatientExamination.ExaminationName;
        //                        }
        //                        else
        //                        {
        //                            pSwollen = pSwollen + "," + oPatientExamination.ExaminationName;
        //                        }

        //                    }
        //                    else
        //                    {
        //                        cell2.Text = oPatientExamination.ExaminationName + "," + cell2.Text;
        //                    }
        //                }

        //            }

        //            string[] splitSwollen = pSwollen.Split(',');
        //            if (splitSwollen.Length > 1)
        //            {
        //                foreach (var pSwollenitems in splitSwollen)
        //                {
        //                    string[] rowSplit = pSwollenitems.Split(' ');
        //                    if (rowSplit[2] == "Lymph")
        //                    {
        //                        if (resSwollen == string.Empty)
        //                        {
        //                            resSwollen = "Swollen Lymph Nodes" + "(" + rowSplit[1];
        //                        }
        //                        else
        //                        {
        //                            resSwollen = resSwollen + "," + rowSplit[1];
        //                        }

        //                    }
        //                }

        //                cell2.Text = cell2.Text + resSwollen + ")" + "+";
        //            }

        //            else
        //            {
        //                if (splitSwollen.Length == 1)
        //                {
        //                    resSwollen = splitSwollen[0];
        //                    cell2.Text = cell2.Text + resSwollen;
        //                }
        //                else if (splitSwollen.Length == 0)
        //                {
        //                    cell2.Text = cell2.Text;
        //                }




        //            }

        //            //if (cell2.Text != "")
        //            //{
        //            //    cell2.Text = cell2.Text + resSwollen + ")" +"+";
        //            //}


        //            row2.Cells.Add(cell2);
        //            row2.Style.Add("color", "#000");
        //            tblSystamaticExamination.Rows.Add(row2);

        //            foreach (var oPatientExamination in lstPatientExamination)
        //            {
        //                TableRow row1 = new TableRow();
        //                TableCell cell1 = new TableCell();
        //                cell1.Attributes.Add("align", "left");
        //                if (oPatientExamination.Description != "")
        //                {
        //                    cell1.Text = oPatientExamination.ExaminationName + " - " + oPatientExamination.Description;

        //                }


        //                row1.Cells.Add(cell1);
        //                row1.Style.Add("color", "#000");
        //                tblSystamaticExamination.Rows.Add(row1);
        //            }
        //        }



        //        if (lstDrugDetails.Count > 0)
        //        {
        //            trPrescription.Style.Add("display", "block");

        //            TableRow rowH = new TableRow();
        //            TableCell cellH1 = new TableCell();
        //            TableCell cellH2 = new TableCell();
        //            TableCell cellH3 = new TableCell();
        //            TableCell cellH4 = new TableCell();
        //            TableCell cellH5 = new TableCell();
        //            TableCell cellH6 = new TableCell();
        //            TableCell cellH7 = new TableCell();
        //            cellH1.Attributes.Add("align", "left");
        //            cellH1.Text = "Drug Name";
        //            cellH2.Attributes.Add("align", "left");
        //            cellH2.Text = "Dose";
        //            cellH3.Attributes.Add("align", "left");
        //            cellH3.Text = "Formulation";
        //            cellH4.Attributes.Add("align", "left");
        //            cellH4.Text = "ROA";
        //            cellH5.Attributes.Add("align", "left");
        //            cellH5.Text = "DrugFrequency";
        //            cellH6.Attributes.Add("align", "left");
        //            cellH6.Text = "Duration";
        //            cellH7.Attributes.Add("align", "left");
        //            cellH7.Text = "Instruction";
        //            rowH.Cells.Add(cellH1);
        //            rowH.Cells.Add(cellH2);
        //            rowH.Cells.Add(cellH3);
        //            rowH.Cells.Add(cellH4);
        //            rowH.Cells.Add(cellH5);
        //            rowH.Cells.Add(cellH6);
        //            rowH.Cells.Add(cellH7);
        //            rowH.Font.Bold = true;
        //            rowH.Style.Add("color", "#000");
        //            tblprescription.Rows.Add(rowH);
        //            foreach (var oDrugDetails in lstDrugDetails)
        //            {

        //                TableRow row1 = new TableRow();
        //                TableCell cell1 = new TableCell();
        //                TableCell cell2 = new TableCell();
        //                TableCell cell3 = new TableCell();
        //                TableCell cell4 = new TableCell();
        //                TableCell cell5 = new TableCell();
        //                TableCell cell6 = new TableCell();
        //                TableCell cell7 = new TableCell();
        //                cell1.Attributes.Add("align", "left");
        //                cell1.Text = oDrugDetails.DrugName;
        //                cell2.Attributes.Add("align", "left");
        //                cell2.Text = oDrugDetails.Dose;
        //                cell3.Attributes.Add("align", "left");
        //                cell3.Text = oDrugDetails.DrugFormulation;
        //                cell4.Attributes.Add("align", "left");
        //                cell4.Text = oDrugDetails.ROA;
        //                cell5.Attributes.Add("align", "left");
        //                cell5.Text = oDrugDetails.DrugFrequency;
        //                cell6.Attributes.Add("align", "left");
        //                cell6.Text = oDrugDetails.Days;
        //                cell7.Attributes.Add("align", "left");
        //                cell7.Text = oDrugDetails.Instruction.ToString();
        //                row1.Cells.Add(cell1);
        //                row1.Cells.Add(cell2);
        //                row1.Cells.Add(cell3);
        //                row1.Cells.Add(cell4);
        //                row1.Cells.Add(cell5);
        //                row1.Cells.Add(cell6);
        //                row1.Cells.Add(cell7);


        //                row1.Style.Add("color", "#000");
        //                tblprescription.Rows.Add(row1);
        //            }
        //        }

        //        if (lstPatientAdvice.Count > 0)
        //        {

        //            foreach (var oPatientAdvice in lstPatientAdvice)
        //            {
        //                TableRow row1 = new TableRow();
        //                TableCell cell1 = new TableCell();
        //                cell1.Attributes.Add("align", "left");
        //                cell1.Text = oPatientAdvice.Description;
        //                row1.Cells.Add(cell1);
        //                row1.Style.Add("color", "#000");
        //                tblAdvice.Rows.Add(row1);
        //            }
        //        }


        //        if (lstOperationIPTreatmentPlan.Count > 0)
        //        {
        //            trplan.Style.Add("display", "block");
        //            if (lstOperationIPTreatmentPlan.Count > 0)
        //            {
        //                TableRow rowH = new TableRow();
        //                TableCell cellH1 = new TableCell();
        //                TableCell cellH2 = new TableCell();
        //                TableCell cellH3 = new TableCell();
        //                TableCell cellH4 = new TableCell();
        //                cellH1.Attributes.Add("align", "left");
        //                cellH1.Text = "Type";
        //                cellH2.Attributes.Add("align", "left");
        //                cellH2.Text = "Treatment Name";
        //                cellH3.Attributes.Add("align", "left");
        //                cellH3.Text = "Prosthesis";
        //                cellH4.Attributes.Add("align", "left");
        //                cellH4.Text = "TreatmentPlan Date";
        //                rowH.Cells.Add(cellH1);
        //                rowH.Cells.Add(cellH2);
        //                rowH.Cells.Add(cellH3);
        //                rowH.Cells.Add(cellH4);
        //                rowH.Font.Bold = true;
        //                rowH.Style.Add("color", "#000");
        //                tblPlan.Rows.Add(rowH);

        //                foreach (var oIPTreatmentPlan in lstOperationIPTreatmentPlan)
        //                {
        //                    TableRow row1 = new TableRow();

        //                    TableCell cell1 = new TableCell();
        //                    TableCell cell2 = new TableCell();
        //                    TableCell cell3 = new TableCell();
        //                    TableCell cell4 = new TableCell();
        //                    cell1.Attributes.Add("align", "left");
        //                    cell1.Text = oIPTreatmentPlan.ParentName;
        //                    cell2.Attributes.Add("align", "left");
        //                    cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;
        //                    cell3.Attributes.Add("align", "left");
        //                    cell3.Text = oIPTreatmentPlan.Prosthesis;
        //                    if (oIPTreatmentPlan.TreatmentPlanDate == DateTime.MinValue)
        //                    {
        //                        cell4.Attributes.Add("align", "left");
        //                        cell4.Text = "Will Be Scheduled later";
        //                    }
        //                    else
        //                    {
        //                        cell4.Attributes.Add("align", "left");
        //                        cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString();
        //                    }
        //                    row1.Cells.Add(cell1);
        //                    row1.Cells.Add(cell2);
        //                    row1.Cells.Add(cell3);
        //                    row1.Cells.Add(cell4);

        //                    row1.Style.Add("color", "#000");
        //                    tblPlan.Rows.Add(row1);
        //                }
        //            }

        //        }

        //    }
        //}

        //catch (Exception ex)
        //{
          
        //    CLogger.LogError("Error in GetDischargeSummaryCaseSheeDetailst.aspx", ex);
        //}

    }
   
 
 
  

   
}
