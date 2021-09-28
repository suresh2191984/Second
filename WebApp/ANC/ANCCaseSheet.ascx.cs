using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;
using System.Collections;

public partial class ANC_ANCCaseSheet : BaseControl
{
    long patientVisitID = -1;
    long patientID = -1;
    long complaintID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVID = -1;
    long createdBy = -1;
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    
    long createTaskID = -1;
    string feeType = String.Empty;
    string PaymentLogic = String.Empty;
    string others = string.Empty;

    string physicianName = String.Empty;
    string sex = "";
    string noofFetous;
    decimal sbp, sbp1, dbp, pulse, weight, RR;
    int noofWeeks;

    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        //Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
        //Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
        //Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
        //Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
        //feeType = Convert.ToString(Request.QueryString["ftype"]);
        //others = Convert.ToString(Request.QueryString["oC"]);
    }

    public bool LoadCaseSheetDetails(long patientVisitID, long patientID)
    {
        StringBuilder caseSheetLabel = new StringBuilder();
        StringBuilder caseSheetPrescription = new StringBuilder();
        StringBuilder caseSheetComplaint = new StringBuilder();
        StringBuilder caseSheetAdvice = new StringBuilder();
        StringBuilder caseSheetBGP = new StringBuilder();
        StringBuilder caseSheetAlerts = new StringBuilder();
        StringBuilder caseSheetInvs = new StringBuilder();

        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<Patient> lstPatient = new List<Patient>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientFetalFindings> lstPatientFetalFindings = new List<PatientFetalFindings>();
        List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();
        List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
        List<ANCAlerts> lstANCAlerts = new List<ANCAlerts>();
        List<PatienttoScanforANC> lstANCScan = new List<PatienttoScanforANC>();
        List<ANCAdvice> lstANCAdvice = new List<ANCAdvice>();
        List<PatientComplication> lstPatientComplication = new List<PatientComplication>();

        List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);

        try
        {
            int pVisitCount = -1;
            patientBL.GetPatientVitals(patientVisitID, patientID, OrgID, out lstPatient, out lstpv);

            returnCode = new ANC_BL(base.ContextInfo).GetANCCaseSheetDetails(patientVisitID, patientID, out lstPatientHistory, out lstPatientExamination, out lstPatientComplaint, out lstPatient, out lstPatientAdvice, out lstANCAdvice, out lstPatientPrescription, out lstPatientInvestigation, out lstPatientFetalFindings, out lstANCPatientDetails, out lstBackgroundProblem, out lstANCAlerts, out lstANCScan, out lstPatientComplication, out pVisitCount);

            if (lstPatientComplaint.Count > 0)
            {
                divANCCS.Visible = true;

                physicianName = "<b> <span class='ancCSredColorBold'>Consultation by Dr. </span><b> <span class='ancCSredColor'>" + lstPatientComplaint[0].PhysicianName + "</span>, </b>" + "<span class='ancCSredColorBold'>on (Dated : </span><span class='ancCSredColor'>" + lstPatientComplaint[0].PatientVisitTime + "</span><span class='ancCSredColorBold'>)</span> <br /> <span class='ancCSredColorBold'>Visit(</span><span class='ancCSredColor'>ANC</span><span class='ancCSredColorBold'>) -</span> <span class='ancCSredColor'>" + pVisitCount + "</span>";

                lblDocterName.Text = physicianName;

                #region Patient Vitals

                if (lstpv.Count > 0)
                {
                    for (int i = 0; i < lstpv.Count; i++)
                    {
                        if (lstpv[i].VitalsName == "SBP")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                sbp = Math.Ceiling(sbp);
                                sbp1 = sbp;
                            }
                            else
                            {

                            }
                        }
                        if (lstpv[i].VitalsName == "DBP")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                dbp = Math.Ceiling(dbp);

                                lblBP.Text = sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode;
                            }
                            else
                            {
                                //lblBP.Text = sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode;
                                trBP.Visible = false;
                            }
                        }
                        if (lstpv[i].VitalsName == "Temp")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                lblTemp.Text = lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode;
                            }
                            else
                            {
                                trTemp.Visible = false;
                            }
                        }
                        if (lstpv[i].VitalsName == "Weight")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                weight = Math.Ceiling(weight);
                                lblWeight.Text = weight + " " + lstpv[i].UOMCode;
                            }
                            else
                            {
                                trWeight.Visible = false;
                            }
                        }
                        if (lstpv[i].VitalsName == "Pulse")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblPulse.Text = pulse + " " + lstpv[i].UOMCode;
                            }
                            else
                            {
                                trPulse.Visible = false;
                            }
                        }
                        if (lstpv[i].VitalsName == "RR")
                        {
                            if ((lstpv[i].VitalsValue.ToString() != "0.00") && (lstpv[i].VitalsValue.ToString() != "0"))
                            {
                                RR = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                RR = Math.Ceiling(RR);
                                //lblRR.Text = RR + " " + lstpv[i].UOMCode;
                            }
                            else
                            {

                            }
                        }
                    }
                }
                else
                {
                    divVHeader.Visible = false;

                    trPulse.Visible = false;

                    trBP.Visible = false;

                    trTemp.Visible = false;

                    trWeight.Visible = false;
                }

                #endregion

                #region PatientPrescription

                if (lstPatientPrescription.Count > 0)
                {
                    caseSheetPrescription.Append("<table style='width: 90%;'>");
                    for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
                    {
                        PatientPrescription pp = new PatientPrescription();
                        pp = lstPatientPrescription[i];
                        caseSheetPrescription.Append("<tr align='left' class='ancCSviolet'>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
                        caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
                        caseSheetPrescription.Append("<td style='overflow:auto' >" + pp.Instruction + "</td>");
                        caseSheetPrescription.Append("</tr>");
                    }
                    caseSheetPrescription.Append("</table>");
                }
                else
                {
                    caseSheetPrescription.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                    caseSheetPrescription.Append("<td nowrap='nowrap'> No Prescription in this visit. </td>");
                    caseSheetPrescription.Append("</tr></table>");
                }
                lblPrescription.Text = caseSheetPrescription.ToString();

                #endregion

                #region ANCPatientDetails for G P L A

                if (lstANCPatientDetails.Count > 0)
                {
                    lblG.Text = lstANCPatientDetails[0].Gravida.ToString();
                    lblP.Text = lstANCPatientDetails[0].Para.ToString();
                    lblL.Text = lstANCPatientDetails[0].Live.ToString();
                    lblA.Text = lstANCPatientDetails[0].Abortus.ToString();

                    if (lstANCPatientDetails[0].EDD != Convert.ToDateTime("01/01/0001"))
                    {
                        lblEDD.Text = lstANCPatientDetails[0].EDD.ToShortDateString();
                    }
                    else
                    {
                        divEDD.Visible = false;
                    }
                    if (lstANCPatientDetails[0].LMPDate != Convert.ToDateTime("01/01/0001"))
                    {
                        lblLMP.Text = lstANCPatientDetails[0].LMPDate.ToShortDateString();
                    }
                    else
                    {
                        divEDD.Visible = false;
                    }
                    
                    noofFetous = lstANCPatientDetails[0].MultipleGestation.ToString();

                    if (lstANCPatientDetails[0].AdmissionSuggested == "Y")
                    {
                        trAdmission.Style.Add("display", "block");
                        lblAdmission.Text = "Admit the Patient";
                    }
                    else
                    {
                        trAdmission.Style.Add("display", "none");
                        //lblAdmission.Text = "Not applicable";
                    }

                    if ((lstANCPatientDetails[0].IsPrimipara == "1") && (lstANCPatientDetails[0].IsBadObstretic == "1"))
                    {
                        lblPrimiBOH.Text = "Patient is of <b>Primipara & Bad Obstretic History</b>";
                    }
                    else if (lstANCPatientDetails[0].IsPrimipara == "1")
                    {
                        lblPrimiBOH.Text = "Patient is of <b>Primipara</b>";
                    }
                    else if (lstANCPatientDetails[0].IsBadObstretic == "1")
                    {
                        lblPrimiBOH.Text = "Patient is of <b>Bad Obstretic History</b>";
                    }
                    else
                    {
                        lblPrimiBOH.Text = "";
                    }


                }

                #endregion

                #region Patient to be Scanned

                if (lstANCScan.Count > 0)
                {
                    if (lstANCScan[0].ScanStatus == "Y")
                    {
                        trScan.Style.Add("display", "block");
                        lblScan.Text = "Pregnancy UltraSound";
                    }
                    else
                    {
                        trScan.Style.Add("display", "none");
                        lblScan.Text = "Not Applicable";
                    }
                }

                #endregion

                #region Date of UltraSound

                if (lstPatientComplaint[0].DateOfUltraSound != null)
                {
                    if ((lstPatientComplaint[0].DateOfUltraSound != "01/01/1901") || (lstPatientComplaint[0].DateOfUltraSound != "01/01/1900") || (lstPatientComplaint[0].DateOfUltraSound != "01/01/0001") || (lstPatientComplaint[0].DateOfUltraSound != "01/01/1800"))
                    {
                        trdusd.Style.Add("display", "block");
                        lblDateofUSD.Text = lstPatientComplaint[0].DateOfUltraSound;
                    }
                    else
                    {
                        trdusd.Style.Add("display", "none");
                    }
                }
                else
                {
                    trdusd.Style.Add("display", "none");
                }

                #endregion

                #region Patient Details, History, Examination, Fetal Description, Complication

                #region Patient Details

                // Patient Details
                string desc = String.Empty;
                caseSheetComplaint.Append("<span class='ancCSredColorBold'>" + lstPatient[0].TitleName + " " + lstPatient[0].Name);
                caseSheetComplaint.Append(" (Patient No: " + lstPatient[0].PatientNumber.ToString() + ")</span>");
                int page = Convert.ToInt32(lstPatient[0].PatientAge.Split(' ')[0]);
                if (page > 0)
                {
                    caseSheetComplaint.Append("<span class='ancCSredColor'>, aged " + lstPatient[0].PatientAge.ToString());
                }

                if (page > 12)
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetComplaint.Append(" male,");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetComplaint.Append(" female,");
                }
                else if ((page <= 12) && (page > 0))
                {
                    caseSheetComplaint.Append(" child,");
                }
                else
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetComplaint.Append(" male,");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetComplaint.Append(" female,");
                }

                #endregion

                #region No of Foetus, yet to pregnancy, Gestational Weeks

                //No of Foetus
                if (noofFetous != "0")
                {
                    caseSheetComplaint.Append(" with </span><span class='ancCSviolet'><b>" + noofFetous + "</b></span> <span class='ancCSviolet'>viable foetus </span>");
                }
                else
                {
                    caseSheetComplaint.Append("is yet to Conform as Pregnant. ");
                }

                if (lstANCPatientDetails[0].NoOfWeeks != null)
                {
                    caseSheetComplaint.Append("<span class='ancCSredColor'>(" + "<b> " + lstANCPatientDetails[0].NoOfWeeks + "</b> weeks by gestation");

                    if (lstPatientComplaint[0].GestationalWeek != 0)
                    {
                        //caseSheetComplaint.Append(", <b>" + lstPatientComplaint[0].GestationalWeek + "</b> weeks by ultrasound</span>). <br />");
                        caseSheetComplaint.Append(")</span>. ");
                    }
                    else
                    {
                        caseSheetComplaint.Append(")</span>");
                    }
                }
                else if (lstPatientComplaint[0].GestationalWeek != 0)
                {
                    //caseSheetComplaint.Append("(<span class='ancCSredColor'><b>" + lstPatientComplaint[0].GestationalWeek + "</b> weeks by ultrasound</span>) and <br />");
                }

                #endregion

                #region Patient History

                //Patient History
                if (lstPatientHistory.Count > 0)
                {
                    caseSheetComplaint.Append(" <span class='ancCSviolet'> With history of   <b>");
                    //for (int i = 0; i < lstPatientHistory.Count; i++)
                    //{
                    //    if (lstPatientHistory[i].Description != "" && lstPatientHistory[i].HistoryName != "")
                    //        desc = "(<b>" + lstPatientHistory[i].Description + "</b>)";
                    //    else
                    //        desc = "";

                    //    if (i == 0)
                    //        caseSheetComplaint.Append(lstPatientHistory[i].HistoryName + desc);
                    //    else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName != "")
                    //        caseSheetComplaint.Append(" and <b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                    //    else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName == "")
                    //        caseSheetComplaint.Append(" and <b>" + lstPatientHistory[i].Description + desc + "</b>");
                    //    else
                    //        caseSheetComplaint.Append("</b>, <b>" + lstPatientHistory[i].HistoryName + desc + "");
                    //}
                    for (int i = 0; i < lstPatientHistory.Count; i++)
                    {
                        if (lstPatientHistory[i].Description != "" && lstPatientHistory[i].HistoryName != "")
                            desc = "(<b>" + lstPatientHistory[i].Description + "</b>)";
                        else
                            desc = "";

                        if (i == 0)
                            caseSheetComplaint.Append(lstPatientHistory[i].HistoryName + desc);
                        else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName != "")
                            caseSheetComplaint.Append(" and <b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                        else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName == "")
                            //caseSheetComplaint.Append(" and " + lstPatientHistory[i].Description + examdesc);
                            caseSheetComplaint.Append("</b> , <b>" + lstPatientHistory[i].Description + desc + "</b>");
                        else
                            caseSheetComplaint.Append("</b>, <b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                    }
                }
                else
                {
                    caseSheetComplaint.Append("<span class='ancCSviolet'> With history, Presented in an asymptomatic state</span>");
                }


                #endregion

                #region Patient Examination

                if (lstPatient[0].SEX == "M")
                    sex = "He";
                else if (lstPatient[0].SEX == "F")
                    sex = "She";

                //Examination
                if (lstPatientExamination.Count > 0)
                {
                    if (lstPatientExamination[0].ExaminationID != 0 && lstPatientExamination[0].ExaminationName != null && lstPatientExamination[0].Description != null)
                    {
                        if (lstPatientExamination.Count > 0)
                        {
                            caseSheetComplaint.Append(".</span> On examination, she <span class='ancCSviolet'>was found to have <b>");

                            string examdesc = String.Empty;
                            for (int i = 0; i < lstPatientExamination.Count; i++)
                            {
                                if (lstPatientExamination[i].Description != "" && lstPatientExamination[i].ExaminationName != "")
                                    examdesc = "(<b>" + lstPatientExamination[i].Description + "</b>)";
                                else
                                    examdesc = "";

                                if (i == 0)
                                    caseSheetComplaint.Append(lstPatientExamination[i].ExaminationName + examdesc);
                                else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName != "")
                                    caseSheetComplaint.Append(" and <b>" + lstPatientExamination[i].ExaminationName + examdesc + "</b>");
                                else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName == "")
                                    //caseSheetComplaint.Append(" and " + lstPatientExamination[i].Description + examdesc);
                                    caseSheetComplaint.Append("</b> , <b>" + lstPatientExamination[i].Description + examdesc + "</b>");
                                else
                                    caseSheetComplaint.Append("</b>, <b>" + lstPatientExamination[i].ExaminationName + examdesc + "</b>");
                            }
                        }
                        else
                        {
                            caseSheetComplaint.Append(".</span> On examination, she was found to be <span class='ancCSredColorBold'> clinically normal for her gestational age</span>");
                        }
                    }
                    else
                    {
                        caseSheetComplaint.Append(".</span> On examination, she was found to be <span class='ancCSredColorBold'>clinically normal</span>");
                    }
                }
                else
                {
                    caseSheetComplaint.Append(".</span> On examination, she was found to be <span class='ancCSredColorBold'>clinically normal</span>");
                }

                #endregion

                #region Patient Complication

                //Patient Complication
                if (lstPatientComplication.Count > 0)
                {
                    caseSheetComplaint.Append(" </span><span class='ancCSviolet'>. She has been diagnosed to have ");
                    for (int i = 0; i < lstPatientComplication.Count; i++)
                    {
                        if (lstPatientComplication[i].ANCStatus != "F")
                        {
                            if (i == 0)
                            {
                                caseSheetComplaint.Append("<b>" + lstPatientComplication[i].ComplicationName + "</b>");
                            }
                            else if (i == lstPatientComplication.Count - 1 && lstPatientComplication[i].ComplicationName != "")
                                caseSheetComplaint.Append(" and <b>" + lstPatientComplication[i].ComplicationName + "</b> ");
                            else
                                caseSheetComplaint.Append(", <b>" + lstPatientComplication[i].ComplicationName + "</b>");
                        }
                    }
                    
                    
                    for (int i = 0; i < lstPatientComplication.Count; i++)
                    {
                        if (lstPatientComplication[i].ANCStatus != "M")
                        {
                            caseSheetComplaint.Append(" <span class='ancCSviolet'> ");
                            if (i == 0)
                            {
                                caseSheetComplaint.Append("<b>" + lstPatientComplication[i].ComplicationName + "</b>");
                            }
                            else if (i == lstPatientComplication.Count - 1 && lstPatientComplication[i].ComplicationName != "")
                                caseSheetComplaint.Append(" and <b>" + lstPatientComplication[i].ComplicationName + "</b>");
                            else
                                caseSheetComplaint.Append(", <b>" + lstPatientComplication[i].ComplicationName + "</b>");

                        }
                    }
                    //caseSheetComplaint.Append(".");
                }
                //else
                //{
                //    caseSheetComplaint.Append("<span class='ancCSviolet'> With Complication</span>");
                //}

                #endregion

                #region Foetus Description

                //Fetous Description

                if (lstPatientFetalFindings.Count > 1)
                {
                    for (int s = 0; s < lstPatientFetalFindings.Count; s++)
                    {
                        PatientFetalFindings pff = new PatientFetalFindings();
                        pff = lstPatientFetalFindings[s];
                        caseSheetComplaint.Append("</span>.<br /><span class='ancCSredColorBold'>The foetus </span><span class='ancCSviolet'>");
                        caseSheetComplaint.Append("(" + pff.FetalNumber + ") displayed ");
                        //if (pff.FetalPresentationDesc != "0")
                        //{
                        //    caseSheetComplaint.Append("<span class='ancCSviolet'>" + pff.FetalPresentationDesc + " presentation in " + pff.FetalPositionDesc + " position with " + pff.FetalFHSDesc + " fetal heart sounds and " + pff.FetalMovementsDesc + " foetal movements.</span>");
                        //}
                        if (pff.FetalPresentationDesc != "0")
                        {
                            caseSheetComplaint.Append("<b>" + pff.FetalPresentationDesc + "</b>");
                            caseSheetComplaint.Append(" Presentation ");
                        }

                        if (pff.FetalPositionDesc != "0")
                        {
                            caseSheetComplaint.Append(" in ");
                            caseSheetComplaint.Append("<b>" + pff.FetalPositionDesc + "</b>");
                            caseSheetComplaint.Append(" position");
                        }

                        if (pff.FetalFHSDesc != "0")
                        {
                            caseSheetComplaint.Append(" with ");
                            caseSheetComplaint.Append("<b>" + pff.FetalFHSDesc + "</b>");
                            caseSheetComplaint.Append(" fetal heart sounds");
                        }

                        if (pff.FetalMovementsDesc != "0")
                        {
                            if (pff.FetalFHSDesc != "0")
                            {
                                caseSheetComplaint.Append(" and ");
                            }
                            else
                            {
                                caseSheetComplaint.Append(" with ");
                            }
                            caseSheetComplaint.Append("<b>" + pff.FetalMovementsDesc + "</b>");
                            if (pff.FetalOthers != "")
                            {
                                caseSheetComplaint.Append(" fetal movements and ");
                            }
                            else
                            {
                                caseSheetComplaint.Append(" fetal movements");
                            }
                        }
                        if (pff.FetalOthers != "")
                        {
                            caseSheetComplaint.Append("<b>" + pff.FetalOthers + "</b>");
                        }
                        
                    }
                }
                else if (lstPatientFetalFindings.Count == 1)
                {
                    caseSheetComplaint.Append("</span>.<br /><span class='ancCSredColorBold'>The foetus displayed </span><span class='ancCSviolet'>");

                    if(lstPatientFetalFindings[0].FetalPresentationDesc != "0"){
                        caseSheetComplaint.Append("<b>" + lstPatientFetalFindings[0].FetalPresentationDesc + "</b>");
                        caseSheetComplaint.Append(" Presentation ");
                    }

                    if(lstPatientFetalFindings[0].FetalPositionDesc != "0"){
                        caseSheetComplaint.Append(" in ");
                        caseSheetComplaint.Append("<b>" + lstPatientFetalFindings[0].FetalPositionDesc + "</b>");
                        caseSheetComplaint.Append(" position");
                    }

                    if(lstPatientFetalFindings[0].FetalFHSDesc!= "0"){
                        caseSheetComplaint.Append(" with ");
                        caseSheetComplaint.Append("<b>" + lstPatientFetalFindings[0].FetalFHSDesc + "</b>");
                        caseSheetComplaint.Append(" fetal heart sounds");
                    }

                    if(lstPatientFetalFindings[0].FetalMovementsDesc!= "0"){
                        if (lstPatientFetalFindings[0].FetalFHSDesc != "0")
                        {
                            caseSheetComplaint.Append(" and ");
                        }
                        else
                        {
                            caseSheetComplaint.Append(" with ");
                        }
                        caseSheetComplaint.Append("<b>" + lstPatientFetalFindings[0].FetalMovementsDesc + "</b>");
                        if (lstPatientFetalFindings[0].FetalOthers != "")
                        {
                            caseSheetComplaint.Append(" fetal movements and ");
                        }
                        else
                        {
                            caseSheetComplaint.Append(" fetal movements");
                        }
                    }
                    if (lstPatientFetalFindings[0].FetalOthers != "")
                    {
                        caseSheetComplaint.Append("<b>" + lstPatientFetalFindings[0].FetalOthers + "</b>");
                    }

                    //caseSheetComplaint.Append("<span class='ancCSviolet'>" + lstPatientFetalFindings[0].FetalPresentationDesc + " presentation in " + lstPatientFetalFindings[0].FetalPositionDesc + " position with " + lstPatientFetalFindings[0].FetalFHSDesc + " fetal heart sounds and " + lstPatientFetalFindings[0].FetalMovementsDesc + " foetal movements</span>");
                }
                else
                {

                }

                caseSheetComplaint.Append(".</span> ");//+ sex + " is prescribed the following course of treatment and advice: ");


                lblComplaintDesc.Text = caseSheetComplaint.ToString();

                #endregion

                #endregion

                #region Investigations

                if (lstPatientInvestigation.Count > 0)
                {
                    trInv.Style.Add("display", "block");

                    caseSheetInvs.Append("<table>");
                    for (int y = 0, z = 1; y < lstPatientInvestigation.Count; y++, z++)
                    {
                        PatientInvestigation pInv = new PatientInvestigation();
                        pInv = lstPatientInvestigation[y];
                        caseSheetInvs.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetInvs.Append("<td nowrap='nowrap' class='ancCSAlerts'> &#8226; </td>");
                        caseSheetInvs.Append("<td nowrap='nowrap' class='ancCSAlerts'>" + pInv.InvestigationName + "</td>");
                        caseSheetInvs.Append("<td nowrap='nowrap' class='ancCSAlerts'> :  </td>");
                        caseSheetInvs.Append("<td nowrap='nowrap' class='ancCSAlerts'><b>" + pInv.InvestigationValue + "</b></td>");
                        caseSheetInvs.Append("</tr>");
                    }
                    caseSheetInvs.Append("</table>");

                    lblInvestigation.Text = caseSheetInvs.ToString();
                }
                else
                {
                    trInv.Style.Add("display", "none");
                }
                
                #endregion

                #region General Advice
                caseSheetAdvice.Append("<table>");
                for (int m = 0, n = 1; m < lstPatientAdvice.Count; m++, n++)
                {
                    PatientAdvice pa = new PatientAdvice();
                    pa = lstPatientAdvice[m];
                    caseSheetAdvice.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                    caseSheetAdvice.Append("<td nowrap='nowrap' class='ancCSAlerts'> &#8226; </td>");
                    caseSheetAdvice.Append("<td nowrap='nowrap' class='ancCSAlerts'>" + pa.Description + "</td>");
                    caseSheetAdvice.Append("</tr>");
                }
                caseSheetAdvice.Append("</table>");

                if (lstANCPatientDetails[0].PregnancyStatus == "1")
                {
                    if (lstANCPatientDetails[0].AdmissionSuggested != "Y")
                    {
                        caseSheetAdvice.Append("<table>");
                        for (int mm = 0, nn = 1; mm < lstANCAdvice.Count; mm++, nn++)
                        {
                            ANCAdvice aa = new ANCAdvice();
                            aa = lstANCAdvice[mm];
                            caseSheetAdvice.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                            caseSheetAdvice.Append("<td nowrap='nowrap' class='ancCSAlerts'> &#8226; </td>");
                            caseSheetAdvice.Append("<td nowrap='nowrap' class='ancCSAlerts'>" + aa.Description + "</td>");
                            caseSheetAdvice.Append("</tr>");
                        }
                        caseSheetAdvice.Append("</table>");
                    }
                }
                lblANCAdvice.Text = caseSheetAdvice.ToString();

                #endregion

                #region BackgroundProblem

                if (lstBackgroundProblem.Count > 0)
                {
                    caseSheetBGP.Append("<table>");
                    for (int l = 0; l < lstBackgroundProblem.Count; l++)
                    {
                        BackgroundProblem bgp = new BackgroundProblem();
                        bgp = lstBackgroundProblem[l];

                        caseSheetBGP.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetBGP.Append("<td nowrap='nowrap' class='ancCSredColor'> &#8226; </td>");
                        if (bgp.Description != "")
                        {
                            caseSheetBGP.Append("<td nowrap='nowrap' class='ancCSredColor'>" + bgp.ComplaintName + " (" + bgp.Description + ")" + "</td>");
                        }
                        else
                        {
                            caseSheetBGP.Append("<td nowrap='nowrap' class='ancCSredColor'>" + bgp.ComplaintName + " </td>");
                        }
                        caseSheetBGP.Append("</tr>");
                    }
                    caseSheetBGP.Append("</table>");
                    lblBGP.Text = caseSheetBGP.ToString();
                }
                else
                {
                    caseSheetBGP.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                    caseSheetBGP.Append("<td nowrap='nowrap'>" + " No History Found " + "</td>");
                    caseSheetBGP.Append("</tr></table>");

                    lblBGP.Text = caseSheetBGP.ToString();
                    bgpPMH.Visible = false;
                    lblBGP.Text = "";
                }

                #endregion

                #region Next Review Date

                lblReviewDate.Text = lstPatient[0].NextReviewDate;
                //lblReviewDate.CssClass = ancCSviolet;

                #endregion

                #region ANC Alerts

                if (lstANCPatientDetails[0].PregnancyStatus == "1")
                {
                    if (lstANCPatientDetails[0].AdmissionSuggested != "Y")
                    {
                        for (int q = 0; q < lstANCAlerts.Count; q++)
                        {
                            ANCAlerts alerts = new ANCAlerts();
                            alerts = lstANCAlerts[q];

                            caseSheetAlerts.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                            caseSheetAlerts.Append("<td nowrap='nowrap' class='ancCSAlerts'> &#8226; </td>");
                            caseSheetAlerts.Append("<td nowrap='nowrap' class='ancCSAlerts'>" + alerts.Description + "</td>");
                            caseSheetAlerts.Append("</tr></table>");
                        }
                        lblANCAlerts.Text = caseSheetAlerts.ToString();
                    }
                    else
                    {
                        //trAlertsHeading.Visible = false;
                        trAlerts.Style.Add("display", "none");
                    }
                }
                else
                {
                    //trAlertsHeading.Visible = false;
                    trAlerts.Style.Add("display", "none");
                }
                #endregion

                string pConfigKey = "SystemAuthorization";
                string pOutStatus = string.Empty;
                long rCode = -1;

                rCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus); //Refers to System Authorization
                if (pOutStatus == "Y")
                {
                    lblautoGenerate.Visible = true;
                }
            }
            else
            {
                caseSheetLabel.Append("<table> ");
                caseSheetLabel.Append("<tr>");

                caseSheetLabel.Append("<td><font size='2'><b>No Case Sheet Available for the selected visit</b></font></td>");
                caseSheetLabel.Append("</tr>");
                caseSheetLabel.Append("</table>");

                //lblPrescription.Text = caseSheetLabel.ToString();
                divANCCS.Visible = false;
                lblMessage.Text = caseSheetLabel.ToString();
            }

            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC Case Sheet.ascx", ex);
        }
        return true;
    }
}
