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

public partial class CommonControls_EMROPCaseSheet :BaseControl 
{

    string sex = "";
    public string prescription = string.Empty;
    long visitID = 0;
    public decimal sbp1;
    int patientdetailsid = 0;
    long pID = 0;
    string physicianName = String.Empty;
    string phycomments = String.Empty;
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
        patientprescription.loadData(lstPatientPrescription);
        //InvestionBL.GetInvestigationFiles(patientVisitID, out lstinv);

        InvestionBL.getCaseSheetDetail(patientVisitID, out lstPatientHistory, out lstPatientExamination, out lstPatientComplaint, out lstPatient, out lstAdvice, out lstPatientPrescription, out lstPatientInvestigation,out lstPhysiciancomments);
        pID = lstPatient[0].PatientID;
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstpatient = new List<Patient>();
        List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();

        string NextReview = string.Empty;
        string NextReviewNos = string.Empty;
        string NextReviewDMY = string.Empty;
        string[] nReview;

      
        //ICDCode1.GetDiagnoseComplaint();
      
        patientBL.GetPatientVitals(patientVisitID, pID, OrgID, out lstpatient, out lstpv);
        decimal sbp, dbp, pulse, weight, Height;
           if (lstPatientComplaint.Count > 0)
        {
            if (patientDetailsID != Convert.ToInt32(Utilities.PatientDetailOptions.ContinueSameTreatment))
            {
                if (lstPatientComplaint.Count > 0)
                {
                    physicianName = "<b>Dr. " + lstPatientComplaint[0].PhysicianName +  "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp"+ "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp"+"</b>";
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
            caseSheetLabel.Append("<table align ='center' width='100%' border ='0'>");
            caseSheetLabel.Append("<tr align ='left'> ");
            caseSheetLabel.Append(" <td > Patient Name: " + lstPatient[0].TitleName + " " + lstPatient[0].Name + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");

            caseSheetLabel.Append("  Patient No:  " + lstPatient[0].PatientNumber.ToString() + "</td>");
            caseSheetLabel.Append("</tr>");
            caseSheetLabel.Append("<tr Align='left'> <td>");
            caseSheetLabel.Append(" Age/Sex    :" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
            int page = 0;// Convert.ToInt32();
            Int32.TryParse(lstPatient[0].PatientAge.Split(' ')[0], out page);
            if (page > 0)
            {
                caseSheetLabel.Append(" " + lstPatient[0].PatientAge.ToString());
            }

            if (page > 12)
            {
                if (lstPatient[0].SEX == "M")
                    caseSheetLabel.Append(" male / ");
                else if (lstPatient[0].SEX == "F")
                    caseSheetLabel.Append(" female/");
                caseSheetLabel.Append("&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
            }
            else if ((page <= 12) && (page > 0))
            {
                caseSheetLabel.Append(" child");
            }
            //else
            //{
            //    if (lstPatient[0].SEX == "M")
            //        //caseSheetLabel.Append(" male");
            //    else if (lstPatient[0].SEX == "F")
            //       // caseSheetLabel.Append(" female" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
            //         caseSheetLabel.Append("&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
            //}

            // caseSheetLabel.Append(" was diagnosed on ");
            // caseSheetLabel.Append(lstPatientComplaint[0].CreatedAt + ". ");
            //if (lstPatient[0].SEX == "M")
            //    caseSheetLabel.Append("He");
            //else if (lstPatient[0].SEX == "F")
            //caseSheetLabel.Append("She");

            // caseSheetLabel.Append(" is found to be compatible with the current course of treatment and is advised to continue the same.");
            //caseSheetLabel.Append("Adviced to continue the same treatment");
            caseSheetLabel.Append(" Address :" + lstPatient[0].Add1 + "" + lstPatient[0].Add2 + "" + lstPatient[0].Add3 + "");
            //caseSheetLabel.Append("</td></tr>");
            caseSheetLabel.Append("</tr> </td>");
            if (physicianName != String.Empty)
            {
                caseSheetLabel.Append("Consultant Name:" + physicianName + "Visit Date  & Time:" + lstPatientComplaint[0].CreatedAt + "");
                //caseSheetLabel.Append(physicianName);
                caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("<tr><td>&nbsp;<tr><td>");
            }
            caseSheetLabel.Append("<hr />");
            caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

          

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

                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Vitals:</b></font></td>");
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
                        caseSheetLabel.Append("</tr><tr></td>");
                        caseSheetLabel.Append("</tr><tr><td>");
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
                        caseSheetLabel.Append("</tr><tr></td>");
                        caseSheetLabel.Append("</tr><tr><td>");
                        if (lstpv[i].VitalsName == "Temp")
                        
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
                        caseSheetLabel.Append("</tr><tr></td>");
                       
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
                        caseSheetLabel.Append("</tr><tr></td>");
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
                        if (Ht > 0 && wt > 0)
                        {
                            decimal HtInMtrs = (Ht / 100);
                            bmi = (wt / (HtInMtrs * HtInMtrs));
                            caseSheetLabel.Append("&nbsp &nbsp BMI : " + bmi.ToString("#.##") + ", ");

                        }
                        if (lstpv[i].VitalsName == "WaistCircumference")

                        { 
                            decimal WC=decimal.Parse(lstpv[i].VitalsValue.ToString());
                            caseSheetLabel.Append("WC :" + WC + "" + lstpv[i].UOMCode + "");
                        }
                        if (lstpv[i].VitalsName == "HipCircumference")
                        {
                            decimal HC = decimal.Parse(lstpv[i].VitalsValue.ToString());
                            caseSheetLabel.Append("HC :" + HC + "" + lstpv[i].UOMCode + "");
                        }
                        if (lstpv[i].VitalsName == "WHR")
                        {
                            decimal whr = decimal.Parse(lstpv[i].VitalsValue.ToString());
                            caseSheetLabel.Append(" &nbsp &nbsp WHR :" + whr + "" + lstpv[i].UOMCode + "");
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
                        if (lstpv[i].VitalsName == "SPO2")
                        {
                            if (lstpv[i].VitalsValue != 0)
                            {
                                decimal spo2 = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                spo2 = Math.Ceiling(spo2);
                                caseSheetLabel.Append("SPO2 : " + spo2 + " " + lstpv[i].UOMCode + ", ");
                            }
                        }
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
                caseSheetLabel.Append("<table width='100%'> ");
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                caseSheetLabel.Append("<hr />");
                caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Prescription:</b></font></td>");
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
                    caseSheetLabel.Append("<td nowrap='nowrap'>" + pp.Instruction + "</td>");
                    caseSheetLabel.Append("<td style='overflow:auto' >" + pp.ROA + "</td>");
                    caseSheetLabel.Append("</tr>");


                }
                caseSheetLabel.Append("</table>");

            }
            caseSheetLabel.Append("<hr />");

          
          

            string pConfigKey = "SystemAuthorization";
            string pOutStatus = string.Empty;

            returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
            if (pOutStatus == "Y")
            {
                caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                caseSheetLabel.Append("</tr></td></table><br>");
            }
            lblPrescription.Text = caseSheetLabel.ToString();
        }

        else
        {
            if (lstinv.Count <= 0 || patientDetailsID == 3)
            {
                caseSheetLabel.Append("<table align ='center' width='100%' border ='0'>");
                caseSheetLabel.Append("<tr align ='left'> ");
                caseSheetLabel.Append(" <td > Patient Name: " + lstPatient[0].TitleName + " " + lstPatient[0].Name + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
               
                caseSheetLabel.Append(" Patient No:  &nbsp  &nbsp&nbsp  &nbsp &nbsp  &nbsp " + lstPatient[0].PatientNumber.ToString()+"</td>");
                caseSheetLabel.Append("</tr>");
                caseSheetLabel.Append("<tr Align='left'> <td>");
                caseSheetLabel.Append(" Age/Sex    :" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
                int page = 0;// Convert.ToInt32();
                Int32.TryParse(lstPatient[0].PatientAge.Split(' ')[0], out page);
                if (page > 0)
                {
                    caseSheetLabel.Append(" " + lstPatient[0].PatientAge.ToString());
                }

                if (page > 12)
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetLabel.Append("/ male ");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetLabel.Append(" /female");
                }
                else if ((page <= 12) && (page > 0))
                {
                    caseSheetLabel.Append(" child");
                }
                else
                {
                    if (lstPatient[0].SEX == "M")
                        caseSheetLabel.Append("/ male" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
                    else if (lstPatient[0].SEX == "F")
                        caseSheetLabel.Append(" /female" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp");
                }

               // caseSheetLabel.Append(" was diagnosed on ");
               // caseSheetLabel.Append(lstPatientComplaint[0].CreatedAt + ". ");
                //if (lstPatient[0].SEX == "M")
                //    caseSheetLabel.Append("He");
                //else if (lstPatient[0].SEX == "F")
                    //caseSheetLabel.Append("She");

                    // caseSheetLabel.Append(" is found to be compatible with the current course of treatment and is advised to continue the same.");
                    //caseSheetLabel.Append("Adviced to continue the same treatment");
                //caseSheetLabel.Append("&nbsp" + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp " + "Address : " + lstPatient[0].Add1 + "" + lstPatient[0].Add2 + "" + lstPatient[0].Add3 + "");
                //caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("</tr> </td>");
                if (physicianName != String.Empty)
                {
                    caseSheetLabel.Append("Consultant Name:" + physicianName + "Visit Date  & Time:" + lstPatientComplaint[0].CreatedAt + "");
                    //caseSheetLabel.Append(physicianName);
                    caseSheetLabel.Append("</td></tr>");
                    caseSheetLabel.Append("<tr><td>&nbsp;<tr><td>");
                }
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                caseSheetLabel.Append("<hr />");
                // Vitals

                if (lstpatient.Count > 0)
                {

                    if (lstpv.Count > 0)
                    {


                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                        caseSheetLabel.Append("<table align='left' width='100%' > ");
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                        caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Vitals:</b></font></td>");
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
                                        caseSheetLabel.Append("BP : " + sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                    }
                                    else
                                    {
                                        caseSheetLabel.Append("BP : " + "-/" + dbp.ToString() + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                    }
                                }
                                else if (sbp1 != 0)
                                {
                                    caseSheetLabel.Append("BP : " + sbp1 + "/-" + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Temp")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    caseSheetLabel.Append("Temp : " + lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Weight")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    weight = Math.Ceiling(weight);
                                    wt = weight;
                                    caseSheetLabel.Append("Weight : " + weight + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                }
                            }
                            if (lstpv[i].VitalsName == "Height")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    Height = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    Height = Math.Ceiling(Height);
                                    Ht = Height;
                                    caseSheetLabel.Append("Height : " + Height + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                }
                            }
                            //if (lstpv[i].VitalsName == "Pulse")
                            //{
                            //    if (lstpv[i].VitalsValue != 0)
                            //    {
                            //        pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                            //        pulse = Math.Ceiling(pulse);
                            //        caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                            //    }
                            //}
                            if (lstpv[i].VitalsName == "WaistCircumference")
                            {
                                decimal WC = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                caseSheetLabel.Append("WC :" + WC + "" + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                            }
                            if (lstpv[i].VitalsName == "HipCircumference")
                            {
                                decimal HC = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                caseSheetLabel.Append("HC :" + HC + "" + lstpv[i].UOMCode +"&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                            }
                            if (lstpv[i].VitalsName == "WHR")
                            {
                                decimal whr = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                caseSheetLabel.Append("WHR :" + whr + "" + lstpv[i].UOMCode +"&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                            }
                            if (lstpv[i].VitalsName == "Pulse")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    caseSheetLabel.Append("Pulse : " + pulse + " " + lstpv[i].UOMCode + "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
                                }
                            }
                            if (lstpv[i].VitalsName == "SPO2")
                            {
                                if (lstpv[i].VitalsValue != 0)
                                {
                                    decimal spo2 = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    spo2 = Math.Ceiling(spo2);
                                    caseSheetLabel.Append("SPO2 : " + spo2 + " " + lstpv[i].UOMCode +  "&nbsp" + "&nbsp" + "&nbsp" + "&nbsp " + "&nbsp " + "&nbsp ");
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


                caseSheetLabel.Append("<hr />");

                //get patient ICD Code 

                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                if (lstPatientComplaint.Count > 0)
                {
                    caseSheetLabel.Append("<table width='100%' > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Diagonosis:</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    // caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    for (int i = 0, j = 1; i < lstPatientComplaint.Count; i++, j++)
                    {
                        PatientComplaint pc = new PatientComplaint();
                        pc = lstPatientComplaint[i];
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.ICDCode + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.ComplaintName + "</td>");
                        caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.ICDDescription + "</td>");
                        // caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.i + "</td>");
                        // caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.PhysicianComments + "</td>");
                        // caseSheetLabel.Append("<td nowrap='nowrap'>" + pc.Query + "</td>");

                        caseSheetLabel.Append("</tr>");


                    }
                    caseSheetLabel.Append("</table>");
                }

                caseSheetLabel.Append("<hr />");

                //get Physician Comments 


                caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                if (lstPhysiciancomments.Count > 0)
                {
                    caseSheetLabel.Append("<table width='100%'> ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Doctor Comments:</b></font></td></tr>");
                    caseSheetLabel.Append("<tr><td colspan='6'>");
                    caseSheetLabel.Append(lstPhysiciancomments[0].PhysicianComments);
                    caseSheetLabel.Append("</td>");

                    caseSheetLabel.Append("</tr>");

                    caseSheetLabel.Append("</table>");


                }
                caseSheetLabel.Append("</td></tr>");



                // Patient Treatment details
                //caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
               if (lstPatientPrescription.Count > 0)
                {
                    caseSheetLabel.Append("<table width='100%' > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Prescription:</b></font></td>");
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
                


                }

           

                 // caseSheetLabel.Append("</tr>");




                //

            


                // List of Investigations

                if (lstPatientInvestigation.Count > 0)
                {
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    caseSheetLabel.Append("<table > ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<td><font size='2'><b>Investigations Ordered:</b></font></td>");
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
                    caseSheetLabel.Append("<td><font size='2'><b>Advice:</b></font></td>");
                    caseSheetLabel.Append("</tr>");
                    for (int i = 0, j = 1; i < lstAdvice.Count; i++, j++)
                    {
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                        caseSheetLabel.Append(j.ToString() + ". " + lstAdvice[i].AdviceDesc);
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");
                    }
                    caseSheetLabel.Append("</table>");
                    caseSheetLabel.Append("<hr />");
                    caseSheetLabel.Append("</td></tr>");
                }



               

              //  caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

    if ((lstPatient[0].NextReviewDate != null)&&(lstPatient[0].NextReviewDate != ""))
    {
        NextReview = lstPatient[0].NextReviewDate;
        nReview = NextReview.Split('-');
        if (nReview.Length > 0)
        {
            NextReviewNos = nReview[0].ToString();
            NextReviewDMY = nReview[1].ToString();
            if ((NextReviewNos.ToString() != "0") && (NextReviewDMY.ToString()!="Select"))
            {
                caseSheetLabel.Append("<table  ");
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                caseSheetLabel.Append("<td><font size='2'><b>Review:</b></font></td>");
                caseSheetLabel.Append("</tr>");

            
                caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                caseSheetLabel.Append("Next Review (On/After) : " + lstPatient[0].NextReviewDate);
                caseSheetLabel.Append("<br />");
                caseSheetLabel.Append("<hr/>");
                caseSheetLabel.Append("</td></tr>");

                caseSheetLabel.Append("</table>");

                caseSheetLabel.Append("</td></tr>");
                caseSheetLabel.Append("</table>");
            }
        }
    }
                #region NextReviewDate --Commented By Moovendan
             
                #endregion

                if (lstPatient[0].AdmissionSuggested == "Y")
                {

                    caseSheetLabel.Append("<table  ");
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");
                    caseSheetLabel.Append("<td><font size='2'><b>Admission Status:</b></font></td>");
                    caseSheetLabel.Append("</tr>");

                
                    caseSheetLabel.Append("<tr align='left' style='text-align:left;'> <td>");
                    caseSheetLabel.Append("Suggested for Admission ");
                    caseSheetLabel.Append("<br />");
                    caseSheetLabel.Append("<hr/>");
                    caseSheetLabel.Append("</td></tr>");

                    caseSheetLabel.Append("</table>");

                    caseSheetLabel.Append("</td></tr>");
                    caseSheetLabel.Append("</table>");
                }
                
              

                string pConfigKey = "SystemAuthorization";
                string pOutStatus = string.Empty;

                returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
                if (pOutStatus == "Y")
                {
                    caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                    caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                    caseSheetLabel.Append("</tr></td></table><br>");
                }
                
               

                lblPrescription.Text = caseSheetLabel.ToString();

                Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                List<InvestigationValues> investValues = new List<InvestigationValues>();
                List<InvestigationDisplayName> lstDisplayName = new List<InvestigationDisplayName>();
                List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                long lResult = -1;
                lResult = investigationBL.GetInvestigationResults(patientVisitID, out investValues, out lstDisplayName, out lstPatientInvSampleResults);


              
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
                if(lstPatient[0].AdmissionSuggested == "Y")
                {
                    caseSheetLabel.Append("<br /> Suggested for Admission");
                }
                caseSheetLabel.Append("<br /> </td></tr>");


                // Vitals

                if (lstpatient.Count > 0)
                {

                    if (lstpv.Count > 0)
                    {
                       

                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'><td>");

                        caseSheetLabel.Append("<table align='left' width='100%' > ");
                        caseSheetLabel.Append("<tr align='left' style='text-align:left;'>");

                        caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Vitals:</b></font></td>");
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
                    caseSheetLabel.Append("<td colspan='6'><font size='2'><b>Treatment:</b></font></td>");
                    caseSheetLabel.Append("</tr>");
              
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
               
                string pConfigKey = "SystemAuthorization";
                string pOutStatus = string.Empty;

                returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);//Refers to System Authorization
                if (pOutStatus == "Y")
                {
                    caseSheetLabel.Append("<br><table width='100%'><tr align='center'><td>");
                    caseSheetLabel.Append("Note: Since this is a Computer Generated CaseSheet No Signature Required");
                    caseSheetLabel.Append("</tr></td></table><br>");
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

}
