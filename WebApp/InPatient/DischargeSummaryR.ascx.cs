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

public partial class InPatient_DischargeSummaryR : BaseControl
{

    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string IpNumber = string.Empty;
    string primaryConsultant = string.Empty;
    decimal sbp, dbp, pulse, weight, height, temp, RR, spo2, sbp1;
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


    List<PatientVitals> lstPatientVitalsCount = new List<PatientVitals>();
    List<VitalsUOMJoin> lstDischargeVitalsUOMJoin = new List<VitalsUOMJoin>();

    List<IPComplaint> lstNegativeIPComplaint = new List<IPComplaint>();
    List<Examination> lstNegativeExamination = new List<Examination>();

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();

    List<RoomMaster> lstRoomMaster = new List<RoomMaster>();
    List<InPatientNumber> lstInPatientNumber = new List<InPatientNumber>();

    IP_BL oIP_BL ;
    List<GeneralAdvice> lstGeneralAdvice = new List<GeneralAdvice>();
    List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();


    protected void Page_Load(object sender, EventArgs e)
    {
        oIP_BL = new IP_BL(base.ContextInfo);
    }

    public void GetDischargeSummaryCaseSheet(long patientVisitID)
    {
        try
        {

            returnCode = oIP_BL.GetDischargeSummaryCaseSheet(patientVisitID, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstOperationNotes, out lstDischargeSummary, out lstPatientComplaint, out lstCaserecordIPTreatmentPlan, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstOperationIPTreatmentPlan, out lstAdmissionDate, out lstPatientAddress, out lstDischargeVitalsUOMJoin, out lstPatientVitalsCount, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt, out lstRoomMaster, out lstInPatientNumber, out lstGeneralAdvice, out lstDischargeInvNotes, out OrthoCount);


            if (returnCode == 0)
            {
                if (lstPatientHistoryExt.Count > 0)
                {
                    trHistory.Style.Add("display", "block");
                    ltrDetailHistory.Text = lstPatientHistoryExt[0].DetailHistory;
                }

                if (lsPatient.Count > 0)
                {

                    lblNameV.Text = lsPatient[0].Name;
                    lblAgeSexV.Text = lsPatient[0].Age + "/" + lsPatient[0].SEX;
                    lblIPNOV.Text = lstInPatientNumber[0].IPNumber.ToString();
                    lblPIDV.Text = lsPatient[0].PatientNumber.ToString();
                    lblUnitV.Text = lstRoomMaster[0].RoomName;

                }



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
                            primaryConsultant += "," + "  " + objPC.PhysicianName;
                        }

                    }
                }

                if (primaryConsultant != "")
                {

                    lblConsultantV.Text = primaryConsultant;
                    lblCI.Text = primaryConsultant;

                }

                if (lstAdmissionDate.Count > 0)
                {
                    if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
                    {
                        lblDOAV.Text = "";
                    }
                    else
                    {

                        lblDOAV.Text = lstAdmissionDate[0].AdmissionDate.ToString();
                    }
                }


                if (lstDischargeSummary.Count > 0)
                {

                    if (lstDischargeSummary[0].ProcedureDesc != "")
                    {
                        trProcedure.Style.Add("display", "block");
                        ltrProcedureDesc.Text = lstDischargeSummary[0].ProcedureDesc;
                    }

                    if (lstDischargeSummary[0].ConditionOnDischarge != "")
                    {
                        trCOD.Style.Add("display", "block");
                        lblCODV.Text = lstDischargeSummary[0].ConditionOnDischarge;
                    }


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

                    lblPreparedBy.Text = lstDischargeSummary[0].PreparedBy;


                    lblTypedBy.Text = lstDischargeSummary[0].Name;

                    string HospitalCourse = lstDischargeSummary[0].HospitalCourse;

                    var lstCRC = from resCRC in lstDrugDetails
                                 where resCRC.PrescriptionType == "CRC"
                                 select resCRC;
                    if (HospitalCourse != string.Empty || lstCRC.Count() > 0)
                    {
                        trCourseHospital.Style.Add("display", "block");
                        ltrHospitalcourse.Text = lstDischargeSummary[0].HospitalCourse;
                    }

                    if (lstDischargeSummary[0].DateOfDischarge == DateTime.MinValue)
                    {
                        lblDODV.Text = "";
                    }
                    else
                    {

                        lblDODV.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
                    }

                    if (lstDischargeSummary[0].DischargeTypeName == "Expired")
                    {
                        lblTypeOfDis.Text = "Death Summary";

                    }
                    else
                    {
                        string title = "Discharge Summary";
                        lblTypeOfDis.Text = title.ToUpper();
                        lblDischargeTypeName.Text = "(" + lstDischargeSummary[0].DischargeTypeName.ToUpper() + ")";
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
                if (lstVitalsUOMJoin.Count > 0)
                {
                    // trADMV.Style.Add("display", "block");
                    lblADMV.Text = "";

                    for (int i = 0; i < lstVitalsUOMJoin.Count; i++)
                    {

                        if (lstVitalsUOMJoin[i].VitalsName == "SBP")
                        {
                            if (lstVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                sbp = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                sbp = Math.Ceiling(sbp);
                                sbp1 = sbp;
                            }
                        }
                        if (lstVitalsUOMJoin[i].VitalsName == "DBP")
                        {
                            if (lstVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                dbp = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                dbp = Math.Ceiling(dbp);

                                if (lblADMV.Text == "")
                                {
                                    if (sbp1 != 0)
                                    {
                                        lblADMV.Text = "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                    }
                                    else
                                    {
                                        lblADMV.Text = "BP : " + "-/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                    }
                                }
                                else
                                {
                                    if (sbp1 != 0)
                                    {
                                        lblADMV.Text = lblADMV.Text + "," + "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                    }
                                    else
                                    {
                                        lblADMV.Text = lblADMV.Text + "," + "BP : " + "-/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                    }
                                }

                            }
                            else if (sbp1 != 0)
                            {
                                if (lblADMV.Text == "")
                                {
                                    lblADMV.Text = "BP : " + sbp1 + "/-" + lstVitalsUOMJoin[i].UOMCode;
                                }
                                else
                                {
                                    lblADMV.Text = lblADMV.Text + "," + "BP : " + sbp1 + "/-" + lstVitalsUOMJoin[i].UOMCode;
                                }

                            }
                        }
                        if (lstVitalsUOMJoin[i].VitalsName == "Temp")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    lblADMV.Text = "Temp : " + lstVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    lblADMV.Text = lblADMV.Text + "," + "Temp : " + lstVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }
                        if (lstVitalsUOMJoin[i].VitalsName == "Weight")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    weight = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    weight = Math.Ceiling(weight);
                                    lblADMV.Text = "Weight : " + weight + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    weight = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    weight = Math.Ceiling(weight);
                                    lblADMV.Text = lblADMV.Text + "," + "Weight : " + weight + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }
                        if (lstVitalsUOMJoin[i].VitalsName == "Pulse")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = "Pulse : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = lblADMV.Text + "," + "Pulse : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }

                        if (lstVitalsUOMJoin[i].VitalsName == "Height")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = "Height : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = lblADMV.Text + "," + "Height : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }

                        if (lstVitalsUOMJoin[i].VitalsName == "RR")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = "RR : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = lblADMV.Text + "," + "RR : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }

                        if (lstVitalsUOMJoin[i].VitalsName == "SpO2")
                        {
                            if (lblADMV.Text == "")
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = "SpO2 : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (lstVitalsUOMJoin[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblADMV.Text = lblADMV.Text + "," + "SpO2 : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }

                    }
                }

                //if (lstDischargeVitalsUOMJoin.Count > 0)
                //{
                //    lblVitals.Text = "";

                //    for (int i = 0; i < lstDischargeVitalsUOMJoin.Count; i++)
                //    {

                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "SBP")
                //        {
                //            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //            {
                //                sbp = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                sbp = Math.Ceiling(sbp);
                //                sbp1 = sbp;
                //            }
                //        }
                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "DBP")
                //        {
                //            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //            {
                //                dbp = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                dbp = Math.Ceiling(dbp);

                //                if (lblVitals.Text == "")
                //                {
                //                    if (sbp1 != 0)
                //                    {
                //                        lblVitals.Text = "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                    }
                //                    else
                //                    {
                //                        lblVitals.Text = "BP : " + "-/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                    }
                //                }
                //                else
                //                {
                //                    if (sbp1 != 0)
                //                    {
                //                        lblVitals.Text = lblVitals.Text + "," + "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                    }
                //                    else
                //                    {
                //                        lblVitals.Text = lblVitals.Text + "," + "BP : " + "-/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                    }
                //                }

                //            }
                //            else if (sbp1 != 0)
                //            {
                //                if (lblVitals.Text == "")
                //                {
                //                    lblVitals.Text = "BP : " + sbp1 + "/-" + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //                else
                //                {
                //                    lblVitals.Text = lblVitals.Text + "," + "BP : " + sbp1 + "/-" + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }

                //            }
                //        }
                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "Temp")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    lblVitals.Text = "Temp : " + lstDischargeVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    lblVitals.Text = lblVitals.Text + "," + "Temp : " + lstDischargeVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }
                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "Weight")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    weight = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    weight = Math.Ceiling(weight);
                //                    lblVitals.Text = "Weight : " + weight + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    weight = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    weight = Math.Ceiling(weight);
                //                    lblVitals.Text = lblVitals.Text + "," + "Weight : " + weight + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }
                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "Pulse")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = "Pulse : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = lblVitals.Text + "," + "Pulse : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }

                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "Height")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = "Height : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = lblVitals.Text + "," + "Height : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }

                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "RR")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = "RR : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = lblVitals.Text + "," + "RR : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }

                //        if (lstDischargeVitalsUOMJoin[i].VitalsName == "SpO2")
                //        {
                //            if (lblVitals.Text == "")
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = "SpO2 : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }
                //            else
                //            {
                //                if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                //                {
                //                    pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                //                    pulse = Math.Ceiling(pulse);
                //                    lblVitals.Text = lblVitals.Text + "," + "SpO2 : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                //                }
                //            }

                //        }

                //    }
                //}

                if (lstPatientExamination.Count > 0)
                {
                    trGeneralExamination.Style.Add("display", "block");
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
                                {
                                    if (cell2.Text == "")
                                    {
                                        cell2.Text = oPatientExamination.ExaminationName;
                                    }
                                    else
                                    {
                                        cell2.Text += " , " + oPatientExamination.ExaminationName;

                                    }

                                }
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

                        cell2.Text = cell2.Text + "," + resSwollen + ")" + "+";
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

                    if (cell2.Text != "")
                    {
                        trGeneralExamination.Style.Add("display", "block");
                        row2.Cells.Add(cell2);
                        row2.Style.Add("color", "#000");
                        tblGeneralExam.Rows.Add(row2);
                    }

                    foreach (var oPatientExamination in lstPatientExamination)
                    {

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

                if (lstNegativeExamination.Count > 0)
                {

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



                if (lstDrugDetails.Count > 0)
                {
                    var lstDsy = from resDsy in lstDrugDetails
                                 where resDsy.PrescriptionType == "DSY"
                                 select resDsy;

                    if (lstDsy.Count() > 0 || lstPatientAdvice.Count > 0)
                    {


                        tblAdvice.Style.Add("display", "block");

                        //TableRow rowH = new TableRow();
                        //TableCell cellH1 = new TableCell();
                        //TableCell cellH2 = new TableCell();
                        //TableCell cellH3 = new TableCell();
                        //TableCell cellH4 = new TableCell();
                        //TableCell cellH5 = new TableCell();
                        //TableCell cellH6 = new TableCell();
                        //TableCell cellH7 = new TableCell();
                        //cellH1.Attributes.Add("align", "left");
                        //cellH1.Text = "Drug Name";
                        //cellH2.Attributes.Add("align", "left");
                        //cellH2.Text = "Dose";
                        //cellH3.Attributes.Add("align", "left");
                        //cellH3.Text = "Formulation";
                        //cellH4.Attributes.Add("align", "left");
                        //cellH4.Text = "ROA";
                        //cellH5.Attributes.Add("align", "left");
                        //cellH5.Text = "DrugFrequency";
                        //cellH6.Attributes.Add("align", "left");
                        //cellH6.Text = "Duration";
                        //cellH7.Attributes.Add("align", "left");
                        //cellH7.Text = "Instruction";
                        //rowH.Cells.Add(cellH1);
                        //rowH.Cells.Add(cellH2);
                        //rowH.Cells.Add(cellH3);
                        //rowH.Cells.Add(cellH4);
                        //rowH.Cells.Add(cellH5);
                        //rowH.Cells.Add(cellH6);
                        //rowH.Cells.Add(cellH7);
                        //rowH.Font.Bold = true;
                        //rowH.Style.Add("color", "#000");
                        //tblprescription.Rows.Add(rowH);
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
                            cell1.Text = oDrugDetails.DrugFormulation;
                            cell2.Attributes.Add("align", "left");
                            cell2.Text = oDrugDetails.DrugName;
                            cell3.Attributes.Add("align", "center");
                            cell3.Text = oDrugDetails.Dose;
                            cell4.Attributes.Add("align", "left");
                            cell4.Text = oDrugDetails.ROA;
                            cell5.Attributes.Add("align", "center");
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
                        cell1.Text = "<li type=a>" + oPatientAdvice.Description;
                        row1.Cells.Add(cell1);
                        row1.Style.Add("color", "#000");
                        tblAdvice.Rows.Add(row1);
                    }
                }

            }
        }

        catch (Exception ex)
        {           
            CLogger.LogError("Error in GetDischargeSummaryCaseSheeDetailst.aspx", ex);
        }

    }
}
