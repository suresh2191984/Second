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


public partial class Physician_ViewIPCaseSheet : BasePage //System.Web.UI.Page
{
    long patientID = -1;
    long patientVisitID = 0;
    long returnCode = -1;
    string VistType = string.Empty;
    string primaryConsultant = string.Empty;

    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<Patient> lsPatient = new List<Patient>();
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


    IP_BL oIP_BL  ;

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
                GetCaseRecordSheet();
                GetPatientHistory();
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

    private void GetCaseRecordSheet()
    {

        try
        {
            string viewType = "VST";
            returnCode = oIP_BL.GetIPCaseRecordSheet(patientID, patientVisitID, viewType, OrgID, out lsPatient, out lstInPatientAdmissionDetails, out lstPatientComplaint,
                out lstBackgroundProblem, out lstVitalsUOMJoin, out lstPatientExamination, out lstDrugDetails, out lstCaseRecordIPTreatmentPlan,
                out lstAdmissionDate, out lstOrderedInvestigations, out lstNegativeIPComplaint, out lstNegativeExamination, out lstPatientHistoryExt,
                out lstAdvice, out lstPatientHistory);

            new GateWay(base.ContextInfo).GetAllDischargeConfig(OrgID, out DischargeConfigs, out lstAllDischargeConfig);

            string BloodGroup;
            if (lstPatientHistoryExt.Count > 0)
            {
                ltrDetailHistory.Text = lstPatientHistoryExt[0].DetailHistory;
            }
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
                        lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    }
                    else
                    {
                        lblPatientDetail.Text = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;
                    }

                }
                else if (lsPatient[0].SEX == "F")
                {
                    if (BloodGroup != "")
                    {
                        lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + "  BloodGroup: " + BloodGroup;
                    }
                    else
                    {
                        lblPatientDetail.Text = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" + BloodGroup;

                    }
                }
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
                        primaryConsultant += " , " + objPC.PhysicianName;
                    }

                }
            }
            if (primaryConsultant!="")
            {
                //lblDOA.Text = lstInPatientAdmissionDetails[0].AdmissionDate.ToString();
                //string CPhysician = lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
              
                //if (CPhysician != "")
                //{
                //    trCSB.Style.Add("display", "block");
                //    lblCSB.Text = "Dr." + lstInPatientAdmissionDetails[0].PrimaryPhysicianName;
                //}
                 trCSB.Style.Add("display", "block");
                 lblCSB.Text = primaryConsultant;
                
                

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

          //  new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedNegativeBackroundProblemInCRC", OrgID, out lstDischargeConfig);

            var NeedNegativeBackroundProblemInCRC = from res in lstAllDischargeConfig
                                           where res.DischargeConfigKey == "NeedNegativeBackroundProblemInCRC"
                                         && res.DischargeConfigValue == "Y"
                                           select res;
            if (NeedNegativeBackroundProblemInCRC.Count()>0)
                {
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
                }
           
            else
            {
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
            }

           

            if (lstVitalsUOMJoin.Count > 0)
            {
                trAdmissionVitals.Style.Add("display", "block");

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
                tblAdmissionVitals.Rows.Add(rowH);


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
                tblAdmissionVitals.Rows.Add(row1);

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

                                if (oPatientExamination.ExaminationName == "Febrile")
                                {
                                    cell2.Text = "Fever" + " ," + cell2.Text;
                                }
                                else
                                {
                                    cell2.Text = oPatientExamination.ExaminationName + " ," + cell2.Text;

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


                //new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedNegativeExamInCRC", OrgID, out lstDischargeConfig);


                var NeedNegativeExamInCRC = from res in lstAllDischargeConfig
                                                        where res.DischargeConfigKey == "NeedNegativeExamInCRC"
                                                      && res.DischargeConfigValue == "Y"
                                                        select res;


                if (NeedNegativeExamInCRC.Count()>0)
                    {
                        if (lstNegativeExamination.Count > 0)
                        {
                            lblGeneralExam.Text = "";
                            trGeneralExamination.Style.Add("display", "block");

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
               

                else
                {
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

            Musculoskeletal1.BindMusculoskeletal(patientVisitID, OrgID);


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
                 DiagnoseWithICD1.HeaderText = "PROVISIONAL DIAGNOSIS";
                 DiagnoseWithICD1.LoadPatientComplaintWithICD(patientVisitID , "IP","CRC");
             }




            if (lstCaseRecordIPTreatmentPlan.Count > 0)
            {
                trplan.Style.Add("display", "block");



                if (lstCaseRecordIPTreatmentPlan.Count > 0)
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

                    foreach (var oIPTreatmentPlan in lstCaseRecordIPTreatmentPlan)
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
                            //cell4.Text = "Will Be Scheduled later";
                            cell4.Text = "  -  ";
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


            if (lstOrderedInvestigations.Count > 0)
            {
                trInvOrdered.Style.Add("display", "block");
                foreach (var oOrderedInvestigations in lstOrderedInvestigations)
                {
                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oOrderedInvestigations.Name;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblInvOrdered.Rows.Add(row1);

                }
            }




            if (lstDrugDetails.Count > 0)
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


            //Added by Perumal on 12 Nov 2011 - Start
            // Advice
            if (lstAdvice.Count > 0)
            {
                tbladvice.Style.Add("display", "block");
                trAdvice.Style.Add("display", "block");

                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "ADVICE";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                //rowH.Style.Add("color", "#000");
                tbladvice.Rows.Add(rowH);

                for (int i = 0, j = 1; i < lstAdvice.Count; i++, j++)
                {
                    string Description = lstAdvice[i].AdviceDesc;
                    if (Description.Split('-')[0] == "G")
                    {
                        TableRow row1 = new TableRow();
                        TableCell cell1 = new TableCell();
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = j.ToString() + ". " + Description.Split('-')[1];
                        row1.Cells.Add(cell1);
                        //row1.Style.Add("color", "#000");
                        tbladvice.Rows.Add(row1);
                    }
                }
            }

            // Next Review Date
            if (lsPatient.Count > 0)
            {
                tblNewReviewDate.Style.Add("display", "block");
                trNextReviewDate.Style.Add("display", "block");

                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "REVIEW";
                rowH.Cells.Add(cellH1);
                rowH.Font.Bold = true;
                //rowH.Style.Add("color", "#000");
                tblNewReviewDate.Rows.Add(rowH);

                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = "Next Review (On/After) : " + lsPatient[0].NextReviewDate;
                row1.Cells.Add(cell1);
                //row1.Style.Add("color", "#000");
                tblNewReviewDate.Rows.Add(row1);
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error on Loading GetCaseRecordSheet in IPCaseRecordSheet.aspx", ex);
        }
    }


    private void GetPatientHistory()
    {
        try
        {
            returnCode = oIP_BL.GetPatientHistory(patientVisitID, OrgID, out lstPatientHistory);

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
                            Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
                        }
                        else
                        {
                            Age = "Mr." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

                        }

                    }
                    else if (lsPatient[0].SEX == "F")
                    {
                        if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                        {
                            Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with history of" + " ";
                        }
                        else
                        {
                            Age = "Ms." + lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

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
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
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
