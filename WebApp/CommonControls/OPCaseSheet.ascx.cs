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
using System.Collections.Specialized;
using System.Text;
using Attune.Podium.Common;

public partial class CommonControls_OPCaseSheet : BaseControl
{

    string sex = "";
    public string prescription = string.Empty;
    long visitID = 0;
    public decimal sbp1;
    int patientdetailsid = 0;
    long pID = 0;
    string physicianName = String.Empty;
    long returnCode = -1;
    string strConfigKey;
    string configValue;
    decimal wt = 0, Ht = 0, bmi = 0;

    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }

    public int PatientDetailsID
    {
        get { return patientdetailsid; }
        set { patientdetailsid = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        printHeader();
        if (!Page.IsPostBack)
        {

           

        }
    }

    public bool LoadPatientDetails(long patientVisitID, int patientDetailsID)
    {

        //patientDetailsID = patientdetailsid;
        StringBuilder caseSheetLabel = new StringBuilder();
        StringBuilder pVitals = new StringBuilder();

        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<Patient> lstPatient = new List<Patient>();
        List<Advice> lstAdvice = new List<Advice>();
        List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
        List<Investigation> lstinv = new List<Investigation>();
        Investigation_BL InvestionBL = new Investigation_BL(base.ContextInfo);
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientComplaint> lstPhysiciancomments = new List<PatientComplaint>();

        //InvestionBL.GetInvestigationFiles(patientVisitID, out lstinv);

        InvestionBL.getCaseSheetDetail(patientVisitID, out lstPatientHistory, out lstPatientExamination, out lstPatientComplaint, out lstPatient, out lstAdvice, out lstPatientPrescription, out lstPatientInvestigation, out lstPhysiciancomments);
        pID = lstPatient[0].PatientID;
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstpatient = new List<Patient>();
        List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();

        long proTaskStatusID = -1;
        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
        returnCode = patientBL.GetOrderedPhysio(pID, patientVisitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);

        string NextReview = string.Empty;
        string NextReviewNos = string.Empty;
        string NextReviewDMY = string.Empty;
        string[] nReview;

        patientBL.GetPatientVitals(patientVisitID, pID, OrgID, out lstpatient, out lstpv);

       
        

        decimal sbp, dbp, pulse, weight, Height;
        //if (lstpatient.Count > 0)
        //{

        //    if (lstpv.Count > 0)
        //    {
        //        for (int i = 0; i < lstpv.Count; i++)
        //        {
        //            if (lstpv[i].VitalsName == "SBP")
        //            {
        //                sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
        //                sbp = Math.Ceiling(sbp);
        //                lblBPVal.Text = sbp.ToString();
        //                //pVitals.Append(
        //            }
        //            if (lstpv[i].VitalsName == "DBP")
        //            {
        //                dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
        //                dbp = Math.Ceiling(dbp);
        //                lblBPVal.Text = lblBPVal.Text + " / " + dbp.ToString() + " " + lstpv[i].UOMCode; ;
        //            }
        //            if (lstpv[i].VitalsName == "Temp")
        //            {
        //                lblTempVal.Text = lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode; ;
        //            }
        //            if (lstpv[i].VitalsName == "Pulse")
        //            {
        //                pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
        //                pulse = Math.Ceiling(pulse);
        //                lblPulseVal.Text = pulse + " " + lstpv[i].UOMCode; ;
        //            }
        //        }
        //    }
        //    else
        //    {
        //        lblBP.Visible = false;
        //        lblTemp.Visible = false;
        //        lblPulse.Visible = false;
        //    }
        //}


        if (lstPatientComplaint.Count > 0)
        {
            if (patientDetailsID != Convert.ToInt32(Utilities.PatientDetailOptions.ContinueSameTreatment))
            {
                if (lstPatientComplaint.Count > 0)
                {
                    physicianName = "<b>Prescribed by Dr. " + lstPatientComplaint[0].PhysicianName + "</b>, (Dated: " + lstPatientComplaint[0].CreatedAt + ")";
                }
            }
        }
        else
        {
            // If there is no patient Complaint there cannot be a case sheet.
            caseSheetLabel.Append("<table > ");
            caseSheetLabel.Append("<tr>");

            caseSheetLabel.Append("<td><font size='2'><b>No Case Sheet Available for the selected visit</b></font></td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("</table>");

            lblPrescription.Text = caseSheetLabel.ToString();
            return false;
        }


        // Patient Details

        if (patientDetailsID == Convert.ToInt32(Utilities.PatientDetailOptions.ContinueSameTreatment))
        {
            caseSheetLabel.Append("<table align='center' width='100%'>");
            caseSheetLabel.Append("<tr><td align='center' width='100%'><b>Case Sheet</b></td></tr>");
            if (physicianName != String.Empty)
            {
                
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                caseSheetLabel.Append(physicianName);
                caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("<tr><td>&nbsp;<tr><td>");
            }
            caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

            caseSheetLabel.Append("<b>" + lstPatient[0].TitleName + " " + lstPatient[0].Name);
            caseSheetLabel.Append("(Patient No:" + lstPatient[0].PatientNumber.ToString() + ")</b>");
            int page = 0;// Convert.ToInt32();
            Int32.TryParse(lstPatient[0].PatientAge.Split(' ')[0], out page);
            if (page > 0)
            {
                caseSheetLabel.Append(", aged " + lstPatient[0].PatientAge.ToString());
            }

            if (page > 12)
            {
                if (lstPatient[0].SEX == "M")
                    caseSheetLabel.Append(" male,");
                else if (lstPatient[0].SEX == "F")
                    caseSheetLabel.Append(" female,");
            }
            else if ((page <= 12) && (page > 0))
            {
                caseSheetLabel.Append(" child,");
            }
            else
            {
                if (lstPatient[0].SEX == "M")
                    caseSheetLabel.Append(" male,");
                else if (lstPatient[0].SEX == "F")
                    caseSheetLabel.Append(" female,");
            }

            caseSheetLabel.Append(" was diagnosed on ");
            caseSheetLabel.Append(lstPatientComplaint[0].CreatedAt + ". ");
            if (lstPatient[0].SEX == "M")
                caseSheetLabel.Append("He");
            else if (lstPatient[0].SEX == "F")
                caseSheetLabel.Append("She");

            caseSheetLabel.Append(" is found to be compatible with the current course of treatment and is advised to continue the same.");
            //caseSheetLabel.Append("Adviced to continue the same treatment");

            caseSheetLabel.Append("</td></tr>");


            // Vitals

            if (lstpatient.Count > 0)
            {

                if (lstpv.Count > 0)
                {
                    //caseSheetLabel.Append("<table align='center' width='90%'>");
                    //caseSheetLabel.Append("<tr><td>");

                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                    caseSheetLabel.Append("<table align='left' width='100%' > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>VITALS</b></font></td>");
                    caseSheetLabel.Append("</tr><tr><td>");

                    //for (int i = 0; i < lstpv.Count; i++)
                    //{
                    //    if (lstpv[i].VitalsName == "SBP")
                    //    {
                    //        sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    //        sbp = Math.Ceiling(sbp);
                    //        sbp1 = sbp;
                    //    }
                    //    if (lstpv[i].VitalsName == "DBP")
                    //    {
                    //        dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    //        dbp = Math.Ceiling(dbp);
                    //        caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");//</font></td>");
                    //    }
                    //    if (lstpv[i].VitalsName == "Temp")
                    //    {
                    //        caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                    //    }
                    //    if (lstpv[i].VitalsName == "Weight")
                    //    {
                    //        weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    //        weight = Math.Ceiling(weight);
                    //        caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                    //    }
                    //    if (lstpv[i].VitalsName == "Pulse")
                    //    {
                    //        pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                    //        pulse = Math.Ceiling(pulse);
                    //        caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ",");
                    //    }
                    //}
                    for (int i = 0; i < lstpv.Count; i++)
                    {
                        if (lstpv[i].VitalsName == "SBP")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                sbp = Math.Ceiling(sbp);
                                sbp1 = sbp;
                            }
                        }
                        if (lstpv[i].VitalsName == "DBP")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                dbp = Math.Ceiling(dbp);
                                if (sbp1 != 0)
                                {
                                    caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                }
                                else
                                {
                                    caseSheetLabel.Append("BP : " + "-/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            else if (sbp1 != 0)
                            {
                                caseSheetLabel.Append("BP : " + sbp1 + "/-" + lstpv[i].UOMCode + ", ");
                            }
                        }
                        if (lstpv[i].VitalsName == "Temp")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
                        if (lstpv[i].VitalsName == "Weight")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                weight = Math.Ceiling(weight);
                                wt = weight;
                                caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
                        if (lstpv[i].VitalsName == "Height")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                Height = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                Height = Math.Ceiling(Height);
                                Ht = Height;
                                caseSheetLabel.Append("Height : " + Height + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
                        if (lstpv[i].VitalsName == "Pulse")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
                    }
                    if (Ht > 0 && wt > 0)
                    {
                        decimal HtInMtrs = (Ht / 100);
                        bmi = (wt / (HtInMtrs * HtInMtrs));
                        caseSheetLabel.Append("BMI : " + bmi.ToString("#.##") + ", ");

                    }
                    caseSheetLabel.Append(".</td></tr>");
                    caseSheetLabel.Append("</table>");

                    //caseSheetLabel.Append("<hr />");

                    caseSheetLabel.Append("</td></tr>");

                }
                else
                {
                    //lblBP.Visible = false;
                    //lblTemp.Visible = false;
                    //lblPulse.Visible = false;
                }
            }


            caseSheetLabel.Append("<table align='center' width='90%'>");
            // Patient Treatment details
            caseSheetLabel.Append("<tr><td>");
            if (lstPatientPrescription.Count > 0)
            {
                caseSheetLabel.Append("<table width='100%' > ");
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                caseSheetLabel.Append("<hr />");
                caseSheetLabel.Append("<td colspan='6'><font size='2'><b>TREATMENT</b></font></td>");
                caseSheetLabel.Append("</tr>");
                //caseSheetLabel.Append("<tr>");

                for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
                {
                    PatientPrescription pp = new PatientPrescription();
                    pp = lstPatientPrescription[i];
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Direction  + "</td>");
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Instruction + "</td>");
                    caseSheetLabel.Append("<td style='overflow:auto' >" + pp.ROA + "</td>");
                    caseSheetLabel.Append("</tr>");


                }
                caseSheetLabel.Append("</table>");

            }

            caseSheetLabel.Append("</td></tr>");
            caseSheetLabel.Append("</table>");

           
            string pConfigKey = "SystemAuthorization";
            string pOutStatus = string.Empty;

            returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
            if (pOutStatus == "Y")
            {
                caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                caseSheetLabel.Append("</tr></td></table><br>");
            }
            else
            {
                caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("<tr align='right' style='text-align:right;'>");
                caseSheetLabel.Append("<td>");
                caseSheetLabel.Append("Doctor's Signature");
                caseSheetLabel.Append("</td></tr>");

            }

            lblPrescription.Text = caseSheetLabel.ToString();
        }

        else
        {
                       
            if (lstinv.Count <= 0 || patientDetailsID == 3)
            {
                caseSheetLabel.Append("<table align='center' width='100%'>");
                caseSheetLabel.Append("<tr><td align='center' width='100%'><b>Case Sheet</b></td></tr>");
                if (physicianName != String.Empty)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append(physicianName);
                    caseSheetLabel.Append("</tr></td>");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>&nbsp;<tr><td>");
                }
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                caseSheetLabel.Append("<b>" + lstPatient[0].TitleName + " " + lstPatient[0].Name);
                caseSheetLabel.Append(" (Patient No:" + lstPatient[0].PatientNumber.ToString() + ")</b>");
                int page = 0; // Convert.ToInt32(lstPatient[0].PatientAge.Split(' ')[0]);
                Int32.TryParse(lstPatient[0].PatientAge.Split(' ')[0], out page);
                if (page > 0)
                {
                    caseSheetLabel.Append(", aged " + lstPatient[0].PatientAge.ToString());
                }

                if (page > 12)
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetLabel.Append(" male,");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetLabel.Append(" female,");
                }
                else if ((page <= 12) && (page > 0))
                {
                    caseSheetLabel.Append(" child,");
                }
                else
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetLabel.Append(" male,");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetLabel.Append(" female,");
                }
                if (lstPatientComplaint[0].ComplaintName != "N/A")
                {
                    if (lstPatientComplaint[0].ComplaintID != -1)
                    {
                        if (lstPatientHistory.Count > 0)
                        {
                            caseSheetLabel.Append(" presented with ");
                        }
                        else
                        {
                            caseSheetLabel.Append(" was asymptomatic on presentation");
                        }



                        // History Details
                        string desc = String.Empty;
                        for (int i = 0; i < lstPatientHistory.Count; i++)
                        {
                            if (lstPatientHistory[i].Description != "" && lstPatientHistory[i].HistoryName != "")
                                desc = "(" + lstPatientHistory[i].Description + ")";
                            else
                                desc = "";

                            if (i == 0)
                                caseSheetLabel.Append("<b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                            else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName != "")
                                caseSheetLabel.Append(" and " + "<b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                            else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName == "")
                                caseSheetLabel.Append(" and " + "<b>" + lstPatientHistory[i].Description + desc + "</b>");
                            else
                                caseSheetLabel.Append(", " + "<b>" + lstPatientHistory[i].HistoryName + desc + "</b>");
                        }
                    }
                }
                if (lstPatient[0].SEX == "M")
                    sex = "He";
                else if (lstPatient[0].SEX == "F")
                    sex = "She";

                if (lstPatientComplaint[0].ComplaintName != "N/A")
                {
                    if (lstPatientComplaint[0].ComplaintID != -1)
                    {
                        if (lstPatientExamination.Count > 0)
                        {
                            caseSheetLabel.Append("." + sex + " was found to have ");
                        }
                        else
                        {
                            caseSheetLabel.Append("." + sex + " was found to be clinically normal ");
                        }

                        // Examination Details
                        string examdesc = String.Empty;
                        for (int i = 0; i < lstPatientExamination.Count; i++)
                        {
                            if (lstPatientExamination[i].Description != "" && lstPatientExamination[i].ExaminationName != "")
                                examdesc = "(" + lstPatientExamination[i].Description + ")";
                            else
                                examdesc = "";

                            if (i == 0)
                                caseSheetLabel.Append("<b>" + lstPatientExamination[i].ExaminationName + examdesc + "</b>");
                            else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName != "")
                                caseSheetLabel.Append(" and " + "<b>" + lstPatientExamination[i].ExaminationName + examdesc + "</b>");
                            else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName == "")
                                caseSheetLabel.Append(" and " + "<b>" + lstPatientExamination[i].Description + examdesc + "</b>");
                            else
                                caseSheetLabel.Append(", " + "<b>" + lstPatientExamination[i].ExaminationName + examdesc + "</b>");
                        }

                        caseSheetLabel.Append(". " + sex + " has been diagnosed to have ");
                    }
                    else
                    {
                        caseSheetLabel.Append(" has been diagnosed to have ");
                    }
                }

                string compdesc = string.Empty;
                string sQuery = string.Empty;
                strConfigKey = "NeedICD10CodeInCaseSheet";
                configValue = GetConfigValue(strConfigKey, OrgID);
                if (lstPatientComplaint[0].ComplaintName != "N/A")
                {
                    for (int i = 0; i < lstPatientComplaint.Count; i++)
                    {
                        string ICDCode = lstPatientComplaint[i].ICDCode == null ? "" : lstPatientComplaint[i].ICDCode;

                        if (lstPatientComplaint[i].Query.Equals("Y"))
                        {
                            sQuery = "?";
                        }

                        if (lstPatientComplaint[i].Description != null && lstPatientComplaint[i].Description != "")
                        {
                            compdesc = "-" + lstPatientComplaint[i].Description;
                        }
                        else
                        {
                            compdesc = "";
                        }


                        if (configValue == "Y")
                        {
                            if (ICDCode != "")
                            {
                                if (i == 0)
                                {
                                    caseSheetLabel.Append("<b>" + sQuery + lstPatientComplaint[i].ComplaintName + "(" + ICDCode + ")" + compdesc + "</b>");
                                }
                                else if (i == lstPatientComplaint.Count - 1)
                                {
                                    caseSheetLabel.Append(" and " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + "(" + ICDCode + ")" + compdesc + "</b>");
                                }
                                else
                                {
                                    caseSheetLabel.Append(", " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + "(" + ICDCode + ")" + compdesc + "</b>");

                                    sQuery = string.Empty;
                                }
                            }
                            else
                            {
                                if (i == 0)
                                {
                                    caseSheetLabel.Append("<b>" + sQuery + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");
                                }
                                else if (i == lstPatientComplaint.Count - 1)
                                {
                                    caseSheetLabel.Append(" and " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");
                                }
                                else
                                {
                                    caseSheetLabel.Append(", " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");

                                    sQuery = string.Empty;
                                }
                            }
                        }
                        else
                        {
                            if (i == 0)
                            {
                                caseSheetLabel.Append(sQuery + "<b>" + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");
                            }
                            else if (i == lstPatientComplaint.Count - 1)
                            {
                                caseSheetLabel.Append(" and " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");
                            }
                            else
                            {
                                caseSheetLabel.Append(", " + "<b>" + sQuery + lstPatientComplaint[i].ComplaintName + compdesc + "</b>");

                                sQuery = string.Empty;
                            }
                        }
                    }
                }
                //caseSheetLabel.Append(".");
                //caseSheetLabel.Append(" in this visit");
                caseSheetLabel.Append(". " + sex + " is prescribed the following course of treatment and advice: ");
                caseSheetLabel.Append("<hr/>");
                caseSheetLabel.Append("</td></tr>");


                // Vitals

                if (lstpatient.Count > 0)
                {

                    if (lstpv.Count > 0)
                    {
                        //caseSheetLabel.Append("<table align='center' width='90%'>");
                        //caseSheetLabel.Append("<tr><td>");

                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                        caseSheetLabel.Append("<table align='left' width='100%' > ");
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                        caseSheetLabel.Append("<td colspan='6'><font size='2'><b>VITALS</b></font></td>");
                        caseSheetLabel.Append("</tr><tr><td>");

                        for (int i = 0; i < lstpv.Count; i++)
                        {
                            if (lstpv[i].VitalsName == "SBP")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    sbp = Math.Ceiling(sbp);
                                    sbp1 = sbp;
                                }
                            }
                            if (lstpv[i].VitalsName == "DBP")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    dbp = Math.Ceiling(dbp);
                                    if (sbp1 != 0)
                                    {
                                        caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                    }
                                    else
                                    {
                                        caseSheetLabel.Append("BP : " + "-/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                    }
                                }
                                else if (sbp1 != 0)
                                {
                                    caseSheetLabel.Append("BP : " + sbp1 + "/-" + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Temp")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Weight")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    weight = Math.Ceiling(weight);
                                    wt = weight;
                                    caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Height")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    Height = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    Height = Math.Ceiling(Height);
                                    Ht = Height;
                                    caseSheetLabel.Append("Height : " + Height + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Pulse")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ", ");
                                }
                            }


                        }

                        if (Ht > 0 && wt > 0)
                        {
                            decimal HtInMtrs = (Ht / 100);
                            bmi = (wt / (HtInMtrs * HtInMtrs));
                            caseSheetLabel.Append("BMI : " + bmi.ToString("#.##") + ", ");

                        }


                        caseSheetLabel.Append(".</td></tr>");
                        caseSheetLabel.Append("</table>");

                        //caseSheetLabel.Append("<hr />");

                        caseSheetLabel.Append("</td></tr>");

                    }
                    else
                    {
                        //lblBP.Visible = false;
                        //lblTemp.Visible = false;
                        //lblPulse.Visible = false;
                    }
                }



                // Patient Treatment details
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                if (lstPatientPrescription.Count > 0)
                {
                    caseSheetLabel.Append("<table width='100%' > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>TREATMENT</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    // caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
                    {
                        PatientPrescription pp = new PatientPrescription();
                        pp = lstPatientPrescription[i];
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Direction + "</td>");
                        caseSheetLabel.Append("<td style='overflow:auto' >" + pp.Instruction + "</td>");
                        caseSheetLabel.Append("</tr>");


                    }
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");
                }
                else
                {
                    caseSheetLabel.Append("<table > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    caseSheetLabel.Append("<td><font size='2'>No Prescription Available for the selected visit</font></td>");
                    caseSheetLabel.Append("</tr>");
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");


                }

                caseSheetLabel.Append("</td></tr>");

                // List of Investigations

                if (lstPatientInvestigation.Count > 0)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append("<table > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<td><font size='2'><b>Investigations Ordered</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    for (int ii = 0, jj = 1; ii < lstPatientInvestigation.Count; ii++, jj++)
                    {
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                        caseSheetLabel.Append(jj.ToString() + ". " + lstPatientInvestigation[ii].InvestigationName);
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    }
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("</td></tr>");
                }

                // Advice
                if (lstAdvice.Count > 0)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append("<table > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<td><font size='2'><b>ADVICE</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    for (int i = 0, j = 1; i < lstAdvice.Count; i++, j++)
                    {
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                        //advice desc --G-Avoid Long Travel 
                        if (lstAdvice[i].AdviceDesc.Split('-')[0] == "G")
                        {
                            string GenAdv = lstAdvice[i].AdviceDesc.Split('-')[1];
                            caseSheetLabel.Append(j.ToString() + "." + GenAdv);
                        }
                        else
                        {
                            caseSheetLabel.Append(j.ToString() + "." + lstAdvice[i].AdviceDesc);
                        }
                        
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    }
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("</td></tr>");
                }
                //procedures

                if (lstOrderedPhysiotherapy.Count > 0)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append("<table width='100%' > ");
                    caseSheetLabel.Append("<tr> <td ><font size='2'><b>Ordered Procedures</b></font></td></tr>");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("<td ><font size='2'><b>S.No</b></font></td>");
                    caseSheetLabel.Append("<td ><font size='2'><b>Procedure Name</b></font></td>");
                    caseSheetLabel.Append("<td ><font size='2'><b>Ordered Quantity</b></font></td>");
                    caseSheetLabel.Append("</tr>");


                    for (int i = 0, j = 1; i < lstOrderedPhysiotherapy.Count; i++, j++)
                    {
                        OrderedPhysiotherapy pp = new OrderedPhysiotherapy();
                        pp = lstOrderedPhysiotherapy[i];
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.ProcedureName + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.OdreredQty + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.PhysicianComments + "</td>");
                        caseSheetLabel.Append("</tr>");

                    }
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("</td></tr>");

                }

               
                // Review && ((lstPatient[0].NextReviewDate.Split('-')[0]!="0")||(lstPatient[0].NextReviewDate.Split('-')[1]!="Select")))

                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                if ((lstPatient[0].NextReviewDate != null) && (lstPatient[0].NextReviewDate != ""))
                
               {
                    NextReview = lstPatient[0].NextReviewDate;
                    nReview = NextReview.Split('-');
                    if (nReview.Length > 0)
                    {
                        NextReviewNos = nReview[0].ToString();
                        NextReviewDMY = nReview[1].ToString();
                        if ((NextReviewNos.ToString() != "0") && (NextReviewDMY.ToString() != "Select"))
                        {
                            caseSheetLabel.Append("<table  ");
                            caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                            caseSheetLabel.Append("<td><font size='2'><b>REVIEW</b></font></td>");
                            caseSheetLabel.Append("</tr>");

                            //caseSheetLabel.Append("<tr><td>");
                            //caseSheetLabel.Append("Review to our OPD after 5 days with your medical reports (if any)");

                            //caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                            caseSheetLabel.Append("Next Review (On/After) : " + lstPatient[0].NextReviewDate);
                            caseSheetLabel.Append("<br />");
                            caseSheetLabel.Append("<hr/>");
                            caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("</table>");
                            caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                            if (lstPatient[0].AdmissionSuggested == "Y")
                            {
                            caseSheetLabel.Append("<table  ");
                            caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                            caseSheetLabel.Append("<td><font size='2'><b>Admission Status </b></font></td>");
                            caseSheetLabel.Append("</tr>");

                            //caseSheetLabel.Append("<tr><td>");
                            //caseSheetLabel.Append("Review to our OPD after 5 days with your medical reports (if any)");

                            //caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                            caseSheetLabel.Append(" Suggested for Admission");
                            caseSheetLabel.Append("<br />");
                            caseSheetLabel.Append("<hr/>");
                            caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("</table>");
                            caseSheetLabel.Append("</td></tr>");

                           
                           
                              
                            }
                            caseSheetLabel.Append("<br /> </td></tr>");


                          


                            caseSheetLabel.Append("</td></tr>");
                            caseSheetLabel.Append("<tr align='right' style='text-align:right;'>");
                            caseSheetLabel.Append("<td>");
                            caseSheetLabel.Append("Doctor's Signature");
                            caseSheetLabel.Append("</td></tr>");

                            caseSheetLabel.Append("</table>");
                        }
                    }
                }
                
               

                #region NextReviewDate --Commented By Moovendan
                //else
                //{
                //    caseSheetLabel.Append("<table  ");
                //    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                //    caseSheetLabel.Append("<td><font size='2'><b>REVIEW</b></font></td>");
                //    caseSheetLabel.Append("</tr>");

                //    //caseSheetLabel.Append("<tr><td>");
                //    //caseSheetLabel.Append("Review to our OPD after 5 days with your medical reports (if any)");

                //    //caseSheetLabel.Append("</td></tr>");
                //    caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                //    caseSheetLabel.Append("Next Review (On/After) : " + "---");
                //    caseSheetLabel.Append("<br />");
                //    caseSheetLabel.Append("<hr/>");
                //    caseSheetLabel.Append("</td></tr>");

                //    caseSheetLabel.Append("</table>");

                //    caseSheetLabel.Append("</td></tr>");
                //    caseSheetLabel.Append("</table>");
                //}
                #endregion

              

                //caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                //caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                //caseSheetLabel.Append("</tr></td></table><br>");

                string pConfigKey = "SystemAuthorization";
                string pOutStatus = string.Empty;

                returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
                if (pOutStatus == "Y")
                {
                    caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                    caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                    caseSheetLabel.Append("</tr></td></table><br>");
                }
                //else
                //{
                //    caseSheetLabel.Append("</td></tr>");
                //    caseSheetLabel.Append("<tr align='right' style='text-align:right;'>");
                //    caseSheetLabel.Append("<td>");
                //    caseSheetLabel.Append("Doctor's Signature:");
                //    caseSheetLabel.Append("</td></tr>");

                //}


                //caseSheetLabel.Append("<tr><td>");
                //caseSheetLabel.Append("</tr><td>");


                //caseSheetLabel.Append("</table>");
                //caseSheetLabel.Append("</tr><td>");
              
                lblPrescription.Text = caseSheetLabel.ToString();

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                List<InvestigationValues> investValues = new List<InvestigationValues>();
                List<InvestigationDisplayName> lstDisplayName = new List<InvestigationDisplayName>();
                List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                long lResult = -1;
                lResult = investigationBL.GetInvestigationResults(patientVisitID, out investValues, out lstDisplayName, out lstPatientInvSampleResults);


                //if (BioChemistry1.diplayBiochemistry(investValues, lstDisplayName))
                //{

                //    DBio.Visible = true;
                //    //Page.RegisterStartupScript("d1003", "<script>document.getElementById('DBio').style.display='block';</script>");
                //}
                //else
                //{
                //    DBio.Visible = false;
                //}

                //if (MicroBioDiplay1.displayMicro(investValues, lstDisplayName))
                //{
                //    DMicro.Visible = true;
                //    //Page.RegisterStartupScript("d1002", "<script>document.getElementById('DMicro').style.display='block';</script>");
                //}
                //else
                //{
                //    DMicro.Visible = false;
                //}

                //if (HemotologyDisplay1.diplayHemotology(investValues, lstDisplayName))
                //{
                //    DHemat.Visible = true;
                //    //Page.RegisterStartupScript("d1004", "<script>document.getElementById('DHemat').style.display='block';</script>");
                //}
                //else
                //{
                //    DHemat.Visible = true;
                //}
                //if (ClinicalDisplay1.diplayBiochemistry(investValues, lstDisplayName))
                //{
                //    DClinic.Visible = true;
                //    //Page.RegisterStartupScript("d1005", "<script>document.getElementById('DClinic').style.display='block';</script>");
                //}
                //else
                //{
                //    DClinic.Visible = false;
                //}

            }
            else
            {
                caseSheetLabel.Append("<table align='center' width='70%'>");

                if (physicianName != String.Empty)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append(physicianName);
                    caseSheetLabel.Append("</tr></td>");
                    caseSheetLabel.Append("</tr></td>");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>&nbsp;<tr align='left' style='text-align:left;'><td>");
                }


                caseSheetLabel.Append("Name : <b>" + lstPatient[0].TitleName + " " + lstPatient[0].Name + "</br> Patient No:" + lstPatient[0].PatientNumber + "</b><br> Age&nbsp&nbsp&nbsp&nbsp" + ": " + lstPatient[0].PatientAge.ToString());

                caseSheetLabel.Append("</td></tr>");

                caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td> <br />");
                caseSheetLabel.Append("Next Review (On/After) : " + lstPatient[0].NextReviewDate);
                if (lstPatient[0].AdmissionSuggested == "Y")
                {
                    caseSheetLabel.Append("<table  ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<td><font size='2'><b>Admission Status </b></font></td>");
                    caseSheetLabel.Append("</tr>");

                    //caseSheetLabel.Append("<tr><td>");
                    //caseSheetLabel.Append("Review to our OPD after 5 days with your medical reports (if any)");

                    //caseSheetLabel.Append("</td></tr>");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                    caseSheetLabel.Append(" Suggested for Admission");
                    caseSheetLabel.Append("<br />");
                    caseSheetLabel.Append("<hr/>");
                    caseSheetLabel.Append("</td></tr>");
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("</td></tr>");




                }
                caseSheetLabel.Append("<br /> </td></tr>");



                // Vitals

                if (lstpatient.Count > 0)
                {

                    if (lstpv.Count > 0)
                    {
                        //caseSheetLabel.Append("<table align='center' width='90%'>");
                        //caseSheetLabel.Append("<tr><td>");

                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                        caseSheetLabel.Append("<table align='left' width='100%' > ");
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                        caseSheetLabel.Append("<td colspan='6'><font size='2'><b>VITALS</b></font></td>");
                        caseSheetLabel.Append("</tr><tr><td>");

                        //for (int i = 0; i < lstpv.Count; i++)
                        //{
                        //    if (lstpv[i].VitalsName == "SBP")
                        //    {
                        //        sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        //        sbp = Math.Ceiling(sbp);
                        //        sbp1 = sbp;
                        //    }
                        //    if (lstpv[i].VitalsName == "DBP")
                        //    {
                        //        dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        //        dbp = Math.Ceiling(dbp);
                        //        caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");//</font></td>");
                        //    }
                        //    if (lstpv[i].VitalsName == "Temp")
                        //    {
                        //        caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                        //    }
                        //    if (lstpv[i].VitalsName == "Weight")
                        //    {
                        //        weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        //        weight = Math.Ceiling(weight);
                        //        caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                        //    }
                        //    if (lstpv[i].VitalsName == "Pulse")
                        //    {
                        //        pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        //        pulse = Math.Ceiling(pulse);
                        //        caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ", ");
                        //    }
                        //}
                        for (int i = 0; i < lstpv.Count; i++)
                        {
                            if (lstpv[i].VitalsName == "SBP")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    sbp = Math.Ceiling(sbp);
                                    sbp1 = sbp;
                                }
                            }
                            if (lstpv[i].VitalsName == "DBP")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    dbp = Math.Ceiling(dbp);
                                    if (sbp1 != 0)
                                    {
                                        caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                    }
                                    else
                                    {
                                        caseSheetLabel.Append("BP : " + "-/" + dbp.ToString() + " " + lstpv[i].UOMCode + ", ");
                                    }
                                }
                                else if (sbp1 != 0)
                                {
                                    caseSheetLabel.Append("BP : " + sbp1 + "/-" + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Temp")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Weight")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    weight = Math.Ceiling(weight);
                                    wt = weight;
                                    caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Height")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    Height = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    Height = Math.Ceiling(Height);
                                    Ht = Height;
                                    caseSheetLabel.Append("Height : " + Height + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Pulse")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + ", ");
                                }
                            }
                        }

                        if (Ht > 0 && wt > 0)
                        {
                            decimal HtInMtrs = (Ht / 100);
                            bmi = (wt / (HtInMtrs * HtInMtrs));
                            caseSheetLabel.Append("BMI : " + bmi.ToString("#.##") + ", ");

                        }
                        caseSheetLabel.Append(".</td></tr>");
                        caseSheetLabel.Append("</table>");

                        //caseSheetLabel.Append("<hr />");

                        caseSheetLabel.Append("</td></tr>");

                    }
                    else
                    {
                        //lblBP.Visible = false;
                        //lblTemp.Visible = false;
                        //lblPulse.Visible = false;
                    }
                }



                caseSheetLabel.Append("<table align='center' width='70%'>");
                // Patient Treatment details
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                if (lstPatientPrescription.Count > 0)
                {
                    caseSheetLabel.Append("<table width='100%' > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>TREATMENT</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    //   caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
                    {
                        PatientPrescription pp = new PatientPrescription();
                        pp = lstPatientPrescription[i];
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetLabel.Append("<td width='10px'>" + j.ToString() + ". </td>");
                        caseSheetLabel.Append("<td width='30px'>" + pp.Formulation + "</td>");
                        caseSheetLabel.Append("<td width='120px'>" + pp.BrandName + "</td>");
                        caseSheetLabel.Append("<td width='200px'>" + pp.Dose + "</td>");
                        caseSheetLabel.Append("<td width='200px'>" + pp.DrugFrequency + "</td>");
                        caseSheetLabel.Append("<td width='220px'>" + pp.Duration + "</td>");
                        caseSheetLabel.Append("<td width='220px'>" + pp.Direction + "</td>");
                        caseSheetLabel.Append("<td width='320px' style='word-wrap:none;'>" + pp.ROA + "</td>");
                        caseSheetLabel.Append("</tr>");


                    }
                    caseSheetLabel.Append("</table>");

                }
                else
                {
                    caseSheetLabel.Append("<table > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    caseSheetLabel.Append("<td><font size='2'>No Prescription Available for the selected visit</font></td>");
                    caseSheetLabel.Append("</tr>");
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");


                }

                caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("</table>");
                //caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                //caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                //caseSheetLabel.Append("</tr></td></table><br>");
                string pConfigKey = "SystemAuthorization";
                string pOutStatus = string.Empty;

                returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
                if (pOutStatus == "Y")
                {
                    caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                    caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                    caseSheetLabel.Append("</tr></td></table><br>");
                }
                else
                {
                    caseSheetLabel.Append("</td></tr>");
                    caseSheetLabel.Append("<tr align='right' style='text-align:right;'>");
                    caseSheetLabel.Append("<td>");
                    caseSheetLabel.Append("Doctor's Signature");
                    caseSheetLabel.Append("</td></tr>");

                }
                lblPrescription.Text = caseSheetLabel.ToString();
                
            }
        }
        if (Request.QueryString["pagetype"] == "CPL")
        {
            lblPrescription.Visible = false;
        }
        

        return true;

       
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

    private void printHeader()
    {

        List<Config> lstConfig = new List<Config>();

        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.CaseSheet;

        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, ILocationID, out lstConfig);        
        if (lstConfig.Count > 0)
        {
            int lstCount = lstConfig.Count;
            NameValueCollection objNVC = new NameValueCollection();
            string[] ConfigKeyValue;
            for (int i = 0; i < lstCount; i++)
            {
                ConfigKeyValue = lstConfig[i].ConfigValue.Split('^');
                if (ConfigKeyValue != null && ConfigKeyValue.Length == 2)
                {
                    objNVC.Add(ConfigKeyValue[0], ConfigKeyValue[1]);
                }

            }
            for (int j = 0; j < objNVC.Count; j++)
            {
                switch (objNVC.GetKey(j))
                { 
                    case "Header Logo":
                        if (objNVC[j] != "")
                        {
                            imgBillLogo.ImageUrl = objNVC[j].Trim();
                            imgBillLogo.Visible = true;
                        }
                        else
                        {
                            imgBillLogo.Visible = false;
                        }
                        break;
                    case "OrgName":
                        lblHospitalName.Text = objNVC[j].ToString();
                        break;
                    case "Footer":
                        lblFooter.Text = objNVC[j].ToString();
                        break;
                    case "moto":
                        lblmoto.Text = objNVC[j].ToString();
                        break;
                }
            }
        }

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        //if (lstConfig.Count > 0)
        //{
        //    //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
        //    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
        //    //imgBillLogo.Visible = lstConfig[0].ConfigValue.Trim()== "" ? false : true;
        //    //if (lstConfig[0].ConfigValue.Trim() != "")
        //    //{
        //    //    imgBillLogo.Visible = true;
        //    //}
        //    //else
        //    //{
        //    //    imgBillLogo.Visible = false;
        //    //}
        //}
        //else
        //{
        //    imgBillLogo.Visible = false;
        //}

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "OrgName", OrgID, ILocationID, out lstConfig);

        //if (lstConfig.Count > 0)
        //{
        //   // lblHospitalName.Text = "Kamakshi Memoial ";
         
        //    lblHospitalName.Text = lstConfig[0].ConfigValue.ToString();
           
        //    //lblHospitalName.Style.Add("OrgName", lstConfig[0].ConfigValue.Trim());
        //    //    lblimagelogo.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());

        //}


        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Footer", OrgID, ILocationID, out lstConfig);

        //if (lstConfig.Count > 0)
        //{
        //    lblFooter.Text = lstConfig[0].ConfigValue.ToString();
        //    //lblFooter.Style.Add("Footer", lstConfig[0].ConfigValue.Trim());
        //    //    lblimagelogo.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());

        //}

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "moto", OrgID, ILocationID, out lstConfig);

        //if (lstConfig.Count > 0)
        //{
        //    lblmoto.Text = lstConfig[0].ConfigValue.ToString();
        //   //lblmoto.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
        //    //  lblimagelogo.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
        //}
      
       
    }

    
}

    
    
    
       
    


