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
public partial class Physician_ViewConsolidateCaseSheet : BasePage
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string primaryConsultant = string.Empty;
    StringBuilder caseSheet = new StringBuilder();
    StringBuilder caseshhetfreeze = new StringBuilder();

    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<Patient> lsPatient = new List<Patient>();
    List<Patient> lsPatient1 = new List<Patient>();
 
    List<IPTreatmentPlan> lstCaseRecordIPTreatmentPlan = new List<IPTreatmentPlan>();
    List<BackgroundProblem> lstBackgroundProblem = new List<BackgroundProblem>();
    List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<InPatientAdmissionDetails> lstInPatientAdmissionDetails = new List<InPatientAdmissionDetails>();
    List<InPatientAdmissionDetails> lstAdmissionDate = new List<InPatientAdmissionDetails>();
    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();

    List<IPComplaint> lstNegativeIPComplaint = new List<IPComplaint>();
    List<Examination> lstNegativeExamination = new List<Examination>();

    List<PatientHistoryExt> lstPatientHistoryExt = new List<PatientHistoryExt>();

    // List<DischargeConfig> lstDischargeConfig = new List<DischargeConfig>();

    List<DischargeConfig> lstAllDischargeConfig = new List<DischargeConfig>();

    List<Advice> lstAdvice = new List<Advice>(); //Added by Perumal on 12 Nov 2011
    List<PatientVisit> lstPrevVisits = new List<PatientVisit>(); //Added by Perumal on 12 Nov 2011

    string DischargeConfigs = string.Empty;


    IP_BL oIP_BL ;

    protected void Page_Load(object sender, EventArgs e)
    {

        oIP_BL = new IP_BL(base.ContextInfo);
        VistType = Request.QueryString["vType"];

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        if (!IsPostBack)
        {
            if (VistType == "OP" || VistType == "IP" || Request.QueryString["page"] == "ICD")
            {
                string ViewType = "PAT";
                returnCode = oIP_BL.GetIPCaseRecordSheet(patientID, patientVisitID, ViewType, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstPatientComplaint, out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstCaseRecordIPTreatmentPlan,
                out lstAdmissionDate, out lstOrderedInvestigations, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt,
                out lstAdvice, out lstPatientHistory);
                
                if (lsPatient.Count > 0)
                {
                    //caseSheet.Append("<div class='table_wrapper'>");
                    // caseSheet.Append("<table width='100%' border='1' cellspacing='0' cellpadding='0'>");
                    //caseSheet.Append("<tr>");
                    //caseSheet.Append("<td class='tloc' style='font-weight: bold; height: 20px; color: #000; font-size:20px'>");


                    caseshhetfreeze.Append("<table>");
                    caseshhetfreeze.Append("<tr><td  align='center' style='font-weight: bold;font-size:20px'>CASE SHEET</td></tr>");
                        
                     
                    string BloodGroup;
                    string PatientDetails = string.Empty;
                    string AdmissionDetails = string.Empty;
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

                        if (lsPatient[0].SEX == "M")
                        {
                            if (BloodGroup != "")
                            {
                                PatientDetails = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                PatientDetails = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                            }

                        }
                        else if (lsPatient[0].SEX == "F")
                        {
                            if (BloodGroup != "")
                            {
                                PatientDetails = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                            }
                            else
                            {
                                PatientDetails = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                            }
                        }
                    }

                    caseshhetfreeze.Append("<tr><td align='left' style='font-weight: bold; height: 20px;font-size:12px'>");
                    caseshhetfreeze.Append(PatientDetails);
                    caseshhetfreeze.Append("</br></td></tr>");

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
                        caseshhetfreeze.Append("<tr><td>");
                        caseshhetfreeze.Append("Case Seen by -" + primaryConsultant);
                        caseshhetfreeze.Append("</td></tr>");
                    }

                    if (lstAdmissionDate.Count > 0)
                    {
                        if (lstAdmissionDate[0].AdmissionDate == DateTime.MinValue)
                        {
                            AdmissionDetails = "";
                        }
                        else
                        {
                            AdmissionDetails = lstAdmissionDate[0].AdmissionDate.ToString();
                            caseshhetfreeze.Append("<tr><td>");
                            caseshhetfreeze.Append("Date & Time of Admission -" + AdmissionDetails);
                            caseshhetfreeze.Append("</td></tr>");
                        }
                    }

                    if (lstBackgroundProblem.Count > 0)
                    {

                        caseshhetfreeze.Append("<tr><td>");


                        caseshhetfreeze.Append("<table cellpadding='0' cellspacing='0' border='0' width='80%'>");
                        caseshhetfreeze.Append("<tr><td align='left' style='font-weight: bold; height: 10px; color: #000;'> BACKROUND MEDICAL PROBLEMS </td> </tr>");
                        //caseSheet.Append("<tr><td>");
                         
                       // caseSheet.Append("<table GridLines='Both'>");
                        
                        foreach (var oBackgroundProblem in lstBackgroundProblem)
                        {
                            caseSheet.Append("<tr>");
                            if (oBackgroundProblem.Description != "")
                            {
                                if (oBackgroundProblem.ComplaintName == "Stroke(CVA)")
                                {
                                    string[] PStroke = oBackgroundProblem.Description.Split('^');
                                    if (PStroke[0].Contains('/'))
                                    {
                                        caseshhetfreeze.Append("<td align='left'><li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[0] + "," + PStroke[1] + "</td>");
                                    }
                                    else
                                    {
                                        caseshhetfreeze.Append("<td align='left'><li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[1] + "</td>");
                                    }

                                }
                                else
                                {
                                    caseshhetfreeze.Append("<td align='left'><li type=a>" + oBackgroundProblem.ComplaintName + " - " + oBackgroundProblem.Description + "</td>");
                                }
                            }
                            else
                            {
                                caseshhetfreeze.Append("<td align='left'><li type=a>" + oBackgroundProblem.ComplaintName + "</td>");
                            }
                            caseshhetfreeze.Append("</tr>");
                        }
                        caseshhetfreeze.Append("</table>");

                        caseshhetfreeze.Append("</td></tr>");
                        //static table ends down
                        caseshhetfreeze.Append("</table>");
                    

                        //caseshhetfreeze.Append("</td>");
                        //caseshhetfreeze.Append("</tr>");
                        //caseshhetfreeze.Append("</table>");
                       //lbind.Text = caseSheet.ToString();
                    }
                    lblfreezpane.Text = caseshhetfreeze.ToString();

                    new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);
                    var NeedNegativeBackroundProblemInCRC = from res in lstAllDischargeConfig
                                                            where res.DischargeConfigKey == "NeedNegativeBackroundProblemInCRC"
                                                          && res.DischargeConfigValue == "Y"
                                                            select res;
                    if (NeedNegativeBackroundProblemInCRC.Count() > 0)
                    {
                        if (lstNegativeIPComplaint.Count > 0)
                        {
                            //trBackgroundProblem.Style.Add("display", "block");
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
                            //caseSheet.Append("<div class='table_inner'>");

                            //caseSheet.Append("<table width='100%' border='1' cellspacing='0' cellpadding='0'>");
                            //caseSheet.Append("<tr><td>");


                            caseSheet.Append("<table cellpadding='0' cellspacing='0' border='0' width='80%'>");
                            caseSheet.Append("<tr><td align='left' style='font-weight: bold; height: 10px; color: #000;'> BACKROUND MEDICAL PROBLEMS </td> </tr>");
                            
                            caseSheet.Append("<tr><td>");

                            caseSheet.Append("<table GridLines='Both'>");
                            caseSheet.Append("<tr><td> No history of" + " " + NegaitiveHis + ".</td></tr>");
                            caseSheet.Append("</table>");

                            caseSheet.Append("</tr></td>");

                            caseSheet.Append("</table>");
                        }
                    }

                    else
                    {
                        if (lstNegativeIPComplaint.Count > 0)
                        {
                            //trBackgroundProblem.Style.Add("display", "block");
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

                            caseSheet.Append("<tr><td>No history of" + " " + NegaitiveHis + ".</td></tr></table>");
                        }
                    }

                    #region History
                    if (lstPatientHistory.Count > 0)
                    {
                        caseSheet.Append("<table width='100%'>");
                        caseSheet.Append("<tr><td>");

                        caseSheet.Append("<table width='100%'>");
                        caseSheet.Append("<tr><td style='font-weight: bold; height: 20px; color: #000;'> HISTORY </td></tr>");
                        caseSheet.Append("<tr><td>");

                        caseSheet.Append("<table cellpadding='0' cellspacing='0' border='0' width='100%'>");
                        caseSheet.Append("<tr><td align='left'>");

                        string PatientHistory = string.Empty;
                        string Age = string.Empty;
                        if (lsPatient.Count > 0)
                        {

                            string[] Age1 = lsPatient[0].Age.Split(' ');
                            if (lsPatient[0].SEX == "M")
                            {
                                if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                                {
                                    Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with following history. The History's are;" + " ";
                                }
                                else
                                {
                                    Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with following history's are" + " ";

                                }

                            }
                            else if (lsPatient[0].SEX == "F")
                            {
                                if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                                {
                                    Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with following history's are" + " ";
                                }
                                else
                                {
                                    Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with following history's are" + " ";

                                }
                            }
                            caseSheet.Append(Age);
                            caseSheet.Append("</td></tr>");
                        }
                        int i = 1;
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
                            caseSheet.Append("<tr><td>"+ i + "." + PatientHistory + "</td></tr>");
                            PatientHistory = string.Empty;
                            i++;
                        }
                        caseSheet.Append("</table>");



                        caseSheet.Append("</td></tr>");


                        caseSheet.Append("</table>");

                        caseSheet.Append("</td></tr>");

                        caseSheet.Append("</table>");



                        //caseSheet.Append("</td></tr>");
                        //caseSheet.Append("</table>");
                        //caseSheet.Append("</div>");


                        //caseSheet.Append("</div>");
                    }
                    #endregion
                    
                    lsPatient.RemoveAll(P => P.PatientVisitID == patientVisitID);
                    fnTableCreate(lsPatient, lstVitalsUOMJoin);
                    lblbind.Text = caseSheet.ToString();
                }
            }

            //if (Request.QueryString["page"] == "ICD")
            //{
            //    GetCaseRecordSheet();
            //    GetPatientHistory();
            //}

            if (Request.QueryString["Prt"] == "Y")
            {
                this.Page.RegisterStartupScript("scrpt", "<script language='javascript' type='text/javascript'> window.print();</script>");
            }
        }        
    }
    private void fnTableCreate(List<Patient> lstPatient, List<VitalsUOMJoin> lstVitalsUOMJoin)
    {
        try
        {
            for (int i = 0; i < lstPatient.Count; i++)
            {
                caseSheet.Append("<br><table width='100%'>");
                caseSheet.Append("<tr><td align='center' style='font-weight: bold;'>");
                caseSheet.Append("VISIT DATE :" + lstPatient[i].VisitDate);
                caseSheet.Append("</tr></td>");
                caseSheet.Append("</table>");
                string DtlHistory = string.Empty;                
                if (lstPatientHistoryExt.Count > 0)
                {
                    var lstPatHistExt = (from ex in lstPatientHistoryExt
                                         where ex.PatientVisitId == lstPatient[i].PatientVisitID
                                         select ex);
                    foreach (var lstPatExt in lstPatHistExt)
                    {
                        if (lstPatExt != null)
                        {
                            DtlHistory = lstPatExt.DetailHistory;
                        }
                        else
                        {
                            DtlHistory = string.Empty;
                        }
                    }
                }
                if (DtlHistory != string.Empty && DtlHistory != "")
                {
                    caseSheet.Append("<table width='100%'>");
                    caseSheet.Append("<tr><td style='font-weight: bold; height: 20px; color: #000;'> Deatils History </td><tr>");
                    caseSheet.Append("<tr><td>" + DtlHistory + "</td></tr>");
                    caseSheet.Append("</table>");
                }
                
                caseSheet.Append("<table width='100%'>");

                #region Admission Vitals
                if (lstVitalsUOMJoin.Count > 0)
                {
                    string Vitalsname = string.Empty;
                    string Vitalsvalue = string.Empty;
                    string Vitalsunit = string.Empty;
                    List<VitalsUOMJoin> lstVitals = (from ex in lstVitalsUOMJoin
                                     where ex.PatientVisitID == lstPatient[i].PatientVisitID
                                     select  ex).ToList();
                    //if (lstVitals != string.Empty)
                    //{

                    //}
                    if (lstVitals.Count != 0)
                    {
                        caseSheet.Append("<tr><td>");
                        caseSheet.Append("<table width='100%'>");
                        caseSheet.Append("<tr><td style='font-weight: bold; height: 20px; color: #000;'> ADMISSION VITALS </td></tr>");
                        caseSheet.Append("<tr><td><table BorderWidth='1px' CellPadding='8' border='1' GridLines='Both'>");

                        foreach (var oVitalsUOMJoin in lstVitals)
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


                        if (resVitalsname[0] != "")
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[0]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[1]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[2]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[3]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[4]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[5]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[6]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append(resVitalsname[7]);
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            if (resVitalsvalue[0] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(resVitalsvalue[0] + " " + resVitalsunit[0]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }
                            if (resVitalsvalue[1] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                string SBP = resVitalsvalue[1];
                                string[] resSBP = SBP.Split('.');
                                caseSheet.Append(resSBP[0] + " " + resVitalsunit[1]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }
                            if (resVitalsvalue[2] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                string DBP = resVitalsvalue[2];
                                string[] resDBP = DBP.Split('.');
                                caseSheet.Append(resDBP[0] + " " + resVitalsunit[2]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }
                            if (resVitalsvalue[3] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                string Pulse = resVitalsvalue[3];
                                string[] resPulse = Pulse.Split('.');
                                caseSheet.Append(resPulse[0] + " " + resVitalsunit[3]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }

                            if (resVitalsvalue[4] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(resVitalsvalue[4] + " " + resVitalsunit[4]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }
                            if (resVitalsvalue[5] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(resVitalsvalue[5] + " " + resVitalsunit[5]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }

                            if (resVitalsvalue[6] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(resVitalsvalue[6] + " " + resVitalsunit[6]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }

                            if (resVitalsvalue[7] != "0.00")
                            {
                                caseSheet.Append("<td align='left'>");
                                string RR = resVitalsvalue[7];
                                string[] resRR = RR.Split('.');
                                caseSheet.Append(resRR[0] + " " + resVitalsunit[7]);
                                caseSheet.Append("</td>");
                            }
                            else
                            {
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append("-");
                                caseSheet.Append("</td>");
                            }
                        }
                        caseSheet.Append("</tr>");
                        caseSheet.Append("</table>");
                        caseSheet.Append("</td></tr>");
                    }
                #endregion

                #region General Examination
                    if (lstPatientExamination.Count > 0)
                    {

                        string pSwollen = string.Empty;
                        string resSwollen = string.Empty;
                        string strtxt = string.Empty;

                        List<PatientExamination> lsPatientExamination = (from ex in lstPatientExamination
                                                                         where ex.PatientVisitID == lstPatient[i].PatientVisitID
                                                                         select ex).ToList();
                        if (lsPatientExamination.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='80%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> GENERAL EXAMINATION");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='26px'>");
                            caseSheet.Append("<tr>");
                            foreach (var oPatientExamination in lsPatientExamination)
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

                                            if (oPatientExamination.ExaminationName == "Febrile")
                                            {
                                                strtxt = "Fever" + " ," + strtxt;
                                            }
                                            else
                                            {
                                                strtxt = oPatientExamination.ExaminationName + " ," + strtxt;
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

                                strtxt = strtxt + resSwollen + ")" + "+";
                            }

                            else
                            {
                                if (splitSwollen.Length == 1)
                                {
                                    resSwollen = splitSwollen[0];
                                    strtxt = strtxt + resSwollen;
                                }
                                else if (splitSwollen.Length == 0)
                                {
                                    strtxt.ToString();
                                }

                            }

                            if (strtxt != "")
                            {
                                caseSheet.Append("<td>" + strtxt + "</td>");
                                caseSheet.Append("</tr></table></td></tr></table></td></tr>");
                            }

                            //string GeneralExam = string.Empty;
                            //var NeedNegativeExamInCRC = from res in lstAllDischargeConfig
                            //                            where res.DischargeConfigKey == "NeedNegativeExamInCRC"
                            //                          && res.DischargeConfigValue == "Y"
                            //                            select res;


                            //if (NeedNegativeExamInCRC.Count() > 0)
                            //{
                            //    if (lstNegativeExamination.Count > 0)
                            //    {

                            //        string Febrile = string.Empty;

                            //        var lstFebrile = from res in lstNegativeExamination
                            //                         where res.ExaminationName == "Febrile"
                            //                         select res;

                            //        if (lstFebrile.Count() > 0)
                            //        {
                            //            Febrile = "Afebrile";
                            //        }

                            //        string NegaitiveSigns = string.Empty;
                            //        foreach (var oNegativeExamination in lstNegativeExamination)
                            //        {
                            //            if (NegaitiveSigns == string.Empty)
                            //            {
                            //                if (oNegativeExamination.ExaminationName != "Febrile")
                            //                {
                            //                    NegaitiveSigns = oNegativeExamination.ExaminationName;
                            //                }
                            //            }
                            //            else
                            //            {
                            //                if (oNegativeExamination.ExaminationName != "Febrile")
                            //                {
                            //                    NegaitiveSigns += ", " + oNegativeExamination.ExaminationName;
                            //                }
                            //            }
                            //        }

                            //        if (NegaitiveSigns != "" && Febrile != "")
                            //        {
                            //            GeneralExam = Febrile + ",  " + "No signs of" + " " + NegaitiveSigns + ".";
                            //        }

                            //        if (NegaitiveSigns != "" && Febrile == "")
                            //        {
                            //            GeneralExam = "No signs of" + " " + NegaitiveSigns + ".";
                            //        }
                            //        if (NegaitiveSigns == "" && Febrile != "")
                            //        {
                            //            GeneralExam = Febrile + " .";
                            //        }
                            //    }
                            //    caseSheet.Append("<tr><td>" + GeneralExam + "</td></tr>");
                            //    caseSheet.Append("</table>");
                            //    caseSheet.Append("</td></tr>");
                            //}

                            //else
                            //{
                            //    if (lstNegativeExamination.Count > 0)
                            //    {
                            //        string NegaitiveSigns = string.Empty;
                            //        foreach (var oNegativeExamination in lstNegativeExamination)
                            //        {
                            //            if (NegaitiveSigns == string.Empty)
                            //            {
                            //                NegaitiveSigns = oNegativeExamination.ExaminationName;
                            //            }
                            //            else
                            //            {
                            //                NegaitiveSigns += "," + oNegativeExamination.ExaminationName;
                            //            }
                            //        }

                            //        GeneralExam = "No signs of" + " " + NegaitiveSigns + ".";
                            //    }
                            //    caseSheet.Append("<tr><td>" + GeneralExam + "</td></tr>");
                            //    caseSheet.Append("</table>");
                            //    caseSheet.Append("</td></tr>");
                        }
                #endregion

                #region Systemic Examination
                        

                        List<PatientExamination> lsyPatientExamination = (from ex in lstPatientExamination
                                                                          where ex.PatientVisitID == lstPatient[i].PatientVisitID
                                                                          select ex).ToList();
                        if (lsyPatientExamination.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> SYSTEMIC EXAMINATION");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table>");

                            foreach (var oPatientExamination in lsyPatientExamination)
                            {
                                if (oPatientExamination.Description != "")
                                {
                                    caseSheet.Append("<tr><td>" + oPatientExamination.ExaminationName + " - " + oPatientExamination.Description + "</tr></td>");

                                }
                            }
                            caseSheet.Append("</tr>");
                            caseSheet.Append("</table>");
                        }
                        //Musculoskeletal1.BindMusculoskeletal(lsPatient[i].PatientVisitID, OrgID);
                        caseSheet.Append("</td>");
                        caseSheet.Append("</tr>");
                        caseSheet.Append("</table>");
                        caseSheet.Append("</td>");
                        caseSheet.Append("</tr>");
                    }
                #endregion

                #region Investigation Order

                    if (lstOrderedInvestigations.Count > 0)
                    {
                        

                        List<OrderedInvestigations> lsOrderedInvestigations = (from ex1 in lstOrderedInvestigations
                                                       where ex1.VisitID == lstPatient[i].PatientVisitID
                                                       select ex1).ToList();
                        if (lsOrderedInvestigations.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> INVESTIGATION ORDERED");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table>");
                            caseSheet.Append("<tr>");

                            foreach (var oOrderedInvestigations in lsOrderedInvestigations)
                            {
                                caseSheet.Append("<td>" + "<li type=a>" + oOrderedInvestigations.Name + "</td>");
                            }
                            caseSheet.Append("</tr>");
                            caseSheet.Append("</table>");
                            caseSheet.Append("</td></tr></table></td></tr>");
                        }
                    }

                    #endregion

                #region Provisional Diagnosis

                    var NeedDiagnoseWithICD10InDSY = from res in lstAllDischargeConfig
                                                     where res.DischargeConfigKey == "NeedDiagnoseWithICD10InDSY"
                                                            && res.DischargeConfigValue == "Y"
                                                     select res;

                    if (NeedDiagnoseWithICD10InDSY.Count() == 0)
                    {
                        if (lstPatientComplaint.Count > 0)
                        {
                            
                            List<PatientComplaint> lsPatientComplaint = (from ex1 in lstPatientComplaint
                                                      where ex1.PatientVisitID == lstPatient[i].PatientVisitID
                                                      select ex1).ToList();
                            if (lsPatientComplaint.Count > 0)
                            {
                                caseSheet.Append("<tr>");
                                caseSheet.Append("<td>");
                                caseSheet.Append("<table width='100%'>");
                                caseSheet.Append("<tr>");
                                caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> PROVISIONAL DIAGNOSIS");
                                caseSheet.Append("</td>");
                                caseSheet.Append("</tr>");
                                caseSheet.Append("<tr>");
                                caseSheet.Append("<td>");
                                caseSheet.Append("<table>");

                                foreach (var oPatientComplaint in lsPatientComplaint)
                                {

                                    caseSheet.Append("<tr>");
                                    caseSheet.Append("<td align='left>'");
                                    caseSheet.Append("<li type=a>" + oPatientComplaint.ComplaintName);
                                    caseSheet.Append("</td></tr>");
                                }
                                caseSheet.Append("</table>");
                                caseSheet.Append("</td></tr></table></td></tr>");
                            }

                        }
                    }
                    //else
                    //{
                    //    caseSheet.Append("<tr>");
                    //    caseSheet.Append("<td>");
                    //    caseSheet.Append("<table width='100%'>");
                    //    caseSheet.Append("<tr>");
                    //    caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> PROVISIONAL DIAGNOSIS");
                    //    caseSheet.Append("</td>");
                    //    caseSheet.Append("</tr>");
                    //    caseSheet.Append("<tr>");
                    //    caseSheet.Append("<td>");
                    //    //DiagnoseWithICD1.LoadPatientComplaintWithICD(lstPatient[i].PatientVisitID, "IP", "CRC");
                    //    caseSheet.Append("</td>");
                    //    caseSheet.Append("</tr>");
                    //    caseSheet.Append("</table>");
                    //    caseSheet.Append("</td>");
                    //    caseSheet.Append("</tr>");
                    //}

                    #endregion

                #region Treatment Plan

                    if (lstCaseRecordIPTreatmentPlan.Count > 0)
                    {
                        caseSheet.Append("<tr>");
                        caseSheet.Append("<td>");
                        caseSheet.Append("<table width='100%'>");
                        caseSheet.Append("<tr>");
                        caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> TREATMENT PLAN");
                        caseSheet.Append("</td>");
                        caseSheet.Append("</tr>");
                        caseSheet.Append("<tr>");
                        caseSheet.Append("<td>");
                        caseSheet.Append("<table CellSpacing='4' BorderWidth='0px' GridLines='Both'>");
                        if (lstCaseRecordIPTreatmentPlan.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Type");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Treatment Name");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Prosthesis");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("TreatmentPlan Date");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");


                            var lsCaseRecordIPTreatmentPlan = (from ex1 in lstCaseRecordIPTreatmentPlan
                                                               where ex1.PatientVisitID == lstPatient[i].PatientVisitID
                                                               select ex1);

                            foreach (var oIPTreatmentPlan in lsCaseRecordIPTreatmentPlan)
                            {
                                caseSheet.Append("<tr>");
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oIPTreatmentPlan.ParentName);
                                caseSheet.Append("</td>");
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oIPTreatmentPlan.IPTreatmentPlanName);
                                caseSheet.Append("</td>");
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oIPTreatmentPlan.Prosthesis);
                                caseSheet.Append("</td>");
                                if (oIPTreatmentPlan.TreatmentPlanDate == DateTime.MinValue)
                                {
                                    caseSheet.Append("<td align='left'>");
                                    caseSheet.Append("  -  ");
                                    caseSheet.Append("</td>");
                                }
                                else
                                {
                                    caseSheet.Append("<td align='left'>");
                                    caseSheet.Append(oIPTreatmentPlan.TreatmentPlanDate.ToString());
                                    caseSheet.Append("</td>");
                                }
                                caseSheet.Append("</tr>");
                            }
                        }
                        caseSheet.Append("</table>");
                        caseSheet.Append("</td></tr></table></td></tr>");
                    }

                    #endregion

                #region PRESCRIPTION

                    if (lstDrugDetails.Count > 0)
                    {

                        List<DrugDetails> lsDrugDetails = (from ex1 in lstDrugDetails
                                             where ex1.PatientVisitID == lstPatient[i].PatientVisitID
                                             select ex1).ToList();
                        if (lsDrugDetails.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%' border='0'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td style='font-weight: bold; height: 20px; color: #000;'> PRESCRIPTION");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table CellPadding='7' BorderWidth='1px' GridLines='Both' border='1' >");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Drug Name");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Dose");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Formulation");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("ROA");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("DrugFrequency");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Duration");
                            caseSheet.Append("</td>");

                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Instruction");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");

                            foreach (var oDrugDetails in lsDrugDetails)
                            {

                                caseSheet.Append("<tr>");
                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.DrugName);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.Dose);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.DrugFormulation);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.ROA);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.DrugFrequency);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.Days);
                                caseSheet.Append("</td>");

                                caseSheet.Append("<td align='left'>");
                                caseSheet.Append(oDrugDetails.Instruction.ToString());
                                caseSheet.Append("</td>");
                                caseSheet.Append("</tr>");
                            }

                            caseSheet.Append("</table>");
                            caseSheet.Append("</td></tr></table></td></tr>");
                        }
                    }

                    #endregion

                #region Advice

                    if (lstAdvice.Count > 0)
                    {

                        int lstAdvCount = (from ex in lstAdvice
                                      where ex.PatientVisitID == lstPatient[i].PatientVisitID
                                      select ex).Count();

                        List<Advice> lstAdv = (from ex in lstAdvice
                                           where ex.PatientVisitID == lstPatient[i].PatientVisitID
                                           select ex).ToList();
                        if (lstAdv.Count > 0)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td> <b>ADVICE</b>");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table>");
                            int iCount = 1;
                            foreach (var lstAdvic in lstAdv)
                            {
                                string Description = lstAdvic.ToString();
                                if (Description.Split('-')[0] == "G")
                                {
                                    caseSheet.Append("<tr>");
                                    caseSheet.Append("<td align='left'>");
                                    caseSheet.Append(iCount + "." + Description.Split('-')[1]);
                                    caseSheet.Append("</td>");
                                    caseSheet.Append("</tr>");
                                    iCount++;
                                }
                            }
                            caseSheet.Append("</table>");
                            caseSheet.Append("</td></tr></table></td></tr>");
                        }
                       
                    }

                    #endregion

                #region Next Review

                    if (lsPatient.Count > 0)
                    {
                        string nxtDate = lsPatient[i].NextReviewDate;
                        if (nxtDate == "" || nxtDate == null)
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td> <b>REVIEW</b>");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("No Review Date for this Visit");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("</table>");
                            caseSheet.Append("</td></tr></table></td></tr>");
                        }
                        else
                        {
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table width='100%'>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td> <b>REVIEW</b>");
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td>");
                            caseSheet.Append("<table>");
                            caseSheet.Append("<tr>");
                            caseSheet.Append("<td align='left'>");
                            caseSheet.Append("Next Review (On/After) : " + lsPatient[i].NextReviewDate);
                            caseSheet.Append("</td>");
                            caseSheet.Append("</tr>");
                            caseSheet.Append("</table>");
                            caseSheet.Append("</td></tr></table></td></tr>");
                        }
                    }

                    #endregion

                caseSheet.Append("<tr>");
                caseSheet.Append("<td>");
                caseSheet.Append("<hr></hr>");
                caseSheet.Append("</td>");
                caseSheet.Append("</tr>");
                caseSheet.Append("</table>");
                caseSheet.Append("</table>");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Loading INPatientHistory in IPCaseRecordSheet.aspx", ex);
        }

    }

    private void GetPatientHistory(long VisitID)
    {
        try
        {
            returnCode = oIP_BL.GetPatientHistory(VisitID, OrgID, out lstPatientHistory);

            
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error on Loading INPatientHistory in IPCaseRecordSheet.aspx", ex);
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
            Response.Redirect("../Physician/IPCaseRecord.aspx?&vid=" + patientVisitID + "&pid=" + patientID, true);

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
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
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
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);
    }
}
