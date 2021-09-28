using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Text;

public partial class ANC_ANCCaseSheet : BasePage
{
    long patientVisitID = -1;
    long patientID = -1;
    long returnCode = -1;
    long taskId = -1;
    string physicianName = String.Empty;
    string sex = "";
    string noofFetous;
    decimal sbp, sbp1, dbp, pulse, weight, RR;
    string feeType = String.Empty;
    string others = string.Empty;
    long complaintID = -1;
    string PaymentLogic = String.Empty;
     string InvDrugData = string.Empty;
     int drugCount = 0;
     string UID = string.Empty;
     long createTaskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {

        Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
        Int64.TryParse(Request.QueryString["tid"].ToString(), out taskId);
        //Int64.TryParse(Request.QueryString["id"].ToString(), out complaintID);
        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
        UID = Convert.ToString(Request.QueryString["gUID"]);

        long FinalBillID = 0;
        Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
        feeType = Convert.ToString(Request.QueryString["ftype"]);
        others = Convert.ToString(Request.QueryString["oC"]);

        if (PaymentLogic == String.Empty)
        {
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                PaymentLogic = lstConfig[0].ConfigValue.Trim();
        }

        if (PaymentLogic == "After")
        {
            billing.LoadDBData = true;
            btnOk.Visible = true;
            btnEdit.Visible = true;
        }
        else
        {
            billing.LoadDBData = false;
            btnOk.Visible = true;
            btnEdit.Visible = true;
        }

        if (!IsPostBack)
        {
            patientHeader.PatientID = patientID;
            patientHeader.PatientVisitID = patientVisitID;
            patientHeader.ShowVitalsDetails();             
            ancCS.LoadCaseSheetDetails(patientVisitID, patientID);

            if (PaymentLogic == "After")
            {
                PhysicianSchedule physician = new PhysicianSchedule();
                new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                billing.Procedure = false;
                billing.Investigation = false;
                billing.Consulting = true;
                billing.PhysicianID = LID;
                billing.PatientVisitID = patientVisitID;

                //billing.LoadDBData = true;

                billing.loadData();
            }
            
            #region Don't delete

            //StringBuilder caseSheetLabel = new StringBuilder();
            //StringBuilder caseSheetPrescription = new StringBuilder();
            //StringBuilder caseSheetComplaint = new StringBuilder();
            //StringBuilder caseSheetAdvice = new StringBuilder();

            //patientHeader.PatientVisitID = patientVisitID;

            //List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
            //List<PatientExamination>  lstPatientExamination = new List<PatientExamination>();
            //List<PatientComplaint>  lstPatientComplaint = new List<PatientComplaint>();
            //List<Patient> lstPatient = new List<Patient>();
            //List<PatientAdvice>  lstPatientAdvice = new List<PatientAdvice>();
            //List<PatientPrescription> lstPatientPrescription = new List<PatientPrescription>();
            //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            //List<PatientFetalFindings> lstPatientFetalFindings = new List<PatientFetalFindings>();
            //List<ANCPatientDetails> lstANCPatientDetails = new List<ANCPatientDetails>();

            //List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();
            //Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            //patientBL.GetPatientVitals(patientVisitID, patientID, OrgID, out lstPatient, out lstpv);

            //returnCode = new ANC_BL(base.ContextInfo).GetANCCaseSheetDetails(patientVisitID, patientID, out lstPatientHistory, out lstPatientExamination, out lstPatientComplaint, out lstPatient, out lstPatientAdvice, out lstPatientPrescription, out lstPatientInvestigation, out lstPatientFetalFindings, out lstANCPatientDetails);

            //if (lstPatientComplaint.Count > 0)
            //{
            //    physicianName = "<b>ANTENATAL CASESHEET<b> - <br />" + "Consultation by Dr. <b>" + lstPatientComplaint[0].PhysicianName + ", </b>" + "on (Dated : " + lstPatientComplaint[0].CreatedAt + ") <br /> Visist(ANC) - " + lstPatientComplaint[0].GestationalWeek + '.' + lstPatientComplaint[0].GestationalDays;

            //    lblDocterName.Text = physicianName;

            //    #region Patient Vitals

            //    if (lstpv.Count > 0)
            //    {
            //        for (int i = 0; i < lstpv.Count; i++)
            //        {
            //            if (lstpv[i].VitalsName == "SBP")
            //            {
            //                sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
            //                sbp = Math.Ceiling(sbp);
            //                sbp1 = sbp;
            //            }
            //            if (lstpv[i].VitalsName == "DBP")
            //            {
            //                dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
            //                dbp = Math.Ceiling(dbp);

            //                lblBP.Text = sbp1 + "/" + dbp.ToString() + " " + lstpv[i].UOMCode;
            //            }
            //            if (lstpv[i].VitalsName == "Temp")
            //            {
            //                lblTemp.Text = lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode;
            //            }
            //            if (lstpv[i].VitalsName == "Weight")
            //            {
            //                weight = decimal.Parse(lstpv[i].VitalsValue.ToString());
            //                weight = Math.Ceiling(weight);
            //                lblWeight.Text = weight + " " + lstpv[i].UOMCode;
            //            }
            //            if (lstpv[i].VitalsName == "Pulse")
            //            {
            //                pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
            //                pulse = Math.Ceiling(pulse);
            //                lblPulse.Text = pulse + " " + lstpv[i].UOMCode;
            //            }
            //            if (lstpv[i].VitalsName == "RR")
            //            {
            //                RR = decimal.Parse(lstpv[i].VitalsValue.ToString());
            //                RR = Math.Ceiling(RR);
            //                lblRR.Text = RR + " " + lstpv[i].UOMCode;
            //            }
            //        }
            //    }

            //    #endregion

            //    #region PatientPrescription

            //    if (lstPatientPrescription.Count > 0)
            //    {
            //        for (int i = 0, j = 1; i < lstPatientPrescription.Count; i++, j++)
            //        {
            //            PatientPrescription pp = new PatientPrescription();
            //            pp = lstPatientPrescription[i];
            //            caseSheetPrescription.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + j.ToString() + ". </td>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Formulation + "</td>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.BrandName + "</td>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Dose + "</td>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.DrugFrequency + "</td>");
            //            caseSheetPrescription.Append("<td nowrap='nowrap'>" + pp.Duration + "</td>");
            //            caseSheetPrescription.Append("<td style='overflow:auto' >" + pp.ROA + "</td>");
            //            caseSheetPrescription.Append("</tr></table>");
            //        }
            //    }
            //    else
            //    {
            //        caseSheetPrescription.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
            //        caseSheetPrescription.Append("<td nowrap='nowrap'> No Prescription avilable. </td>");
            //        caseSheetPrescription.Append("</tr></table>");
            //    }
            //    lblPrescription.Text = caseSheetPrescription.ToString();

            //    #endregion

            //    #region ANCPatientDetails for G P L A

            //    if (lstANCPatientDetails.Count > 0)
            //    {
            //        lblG.Text = lstANCPatientDetails[0].Gravida.ToString();
            //        lblP.Text = lstANCPatientDetails[0].Para.ToString();
            //        lblL.Text = lstANCPatientDetails[0].Live.ToString();
            //        lblA.Text = lstANCPatientDetails[0].Abortus.ToString();

            //        lblEDD.Text = lstANCPatientDetails[0].EDD.ToShortDateString();
            //        noofFetous = lstANCPatientDetails[0].MultipleGestation.ToString();
            //    }

            //    #endregion

            //    #region Patient Details, History, Examination

            //    // Patient Details
            //    string desc = String.Empty;
            //    caseSheetComplaint.Append("<b>" + lstPatient[0].TitleName + " " + lstPatient[0].Name);
            //    caseSheetComplaint.Append("(Patient No:" + lstPatient[0].PatientNumber.ToString() + ")</b>");
            //    if (lstPatient[0].PatientAge > 0)
            //    {
            //        caseSheetComplaint.Append(", aged " + lstPatient[0].PatientAge.ToString() + " years ");
            //    }

            //    if (lstPatient[0].PatientAge > 12)
            //    {
            //        if (lstPatient[0].SEX == "M")
            //            caseSheetComplaint.Append(" male,");
            //        else if (lstPatient[0].SEX == "F")
            //            caseSheetComplaint.Append(" female,");
            //    }
            //    else if ((lstPatient[0].PatientAge <= 12) && (lstPatient[0].PatientAge > 0))
            //    {
            //        caseSheetComplaint.Append(" child,");
            //    }
            //    else
            //    {
            //        if (lstPatient[0].SEX == "M")
            //            caseSheetComplaint.Append(" male,");
            //        else if (lstPatient[0].SEX == "F")
            //            caseSheetComplaint.Append(" female,");
            //    }

            //    //Foetus Desc
            //    caseSheetComplaint.Append("with a (" + noofFetous + ") viable foetus");
            //    caseSheetComplaint.Append("(" + lstPatientComplaint[0].GestationalWeek + "weeks of gestation, 11 weeks by ultrasound " + ")");
            //    caseSheetComplaint.Append("");

            //    //Patient History
            //    if (lstPatientHistory.Count > 0)
            //    {
            //        //caseSheetComplaint.Append("." + sex + " was found to have ");
            //        for (int i = 0; i < lstPatientHistory.Count; i++)
            //        {
            //            if (lstPatientHistory[i].Description != "" && lstPatientHistory[i].HistoryName != "")
            //                desc = "(" + lstPatientHistory[i].Description + ")";
            //            else
            //                desc = "";

            //            if (i == 0)
            //                caseSheetComplaint.Append(lstPatientHistory[i].HistoryName + desc);
            //            else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName != "")
            //                caseSheetComplaint.Append(" and " + lstPatientHistory[i].HistoryName + desc);
            //            else if (i == lstPatientHistory.Count - 1 && lstPatientHistory[i].HistoryName == "")
            //                caseSheetComplaint.Append(" and " + lstPatientHistory[i].Description + desc);
            //            else
            //                caseSheetComplaint.Append(", " + lstPatientHistory[i].HistoryName + desc);
            //        }
            //    }
            //    else
            //    {
            //        caseSheetComplaint.Append(". presented in an asymptatic state.");
            //    }
                

            //    if (lstPatient[0].SEX == "M")
            //        sex = "He";
            //    else if (lstPatient[0].SEX == "F")
            //        sex = "She";

            //    //Examination

            //    if (lstPatientExamination.Count > 0)
            //    {
            //        caseSheetComplaint.Append(". On examination, she was found to have ");
                    
            //        string examdesc = String.Empty;
            //        for (int i = 0; i < lstPatientExamination.Count; i++)
            //        {
            //            if (lstPatientExamination[i].Description != "" && lstPatientExamination[i].ExaminationName != "")
            //                examdesc = "(" + lstPatientExamination[i].Description + ")";
            //            else
            //                examdesc = "";

            //            if (i == 0)
            //                caseSheetComplaint.Append(lstPatientExamination[i].ExaminationName + examdesc);
            //            else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName != "")
            //                caseSheetComplaint.Append(" and " + lstPatientExamination[i].ExaminationName + examdesc);
            //            else if (i == lstPatientExamination.Count - 1 && lstPatientExamination[i].ExaminationName == "")
            //                caseSheetComplaint.Append(" and " + lstPatientExamination[i].Description + examdesc);
            //            else
            //                caseSheetComplaint.Append(", " + lstPatientExamination[i].ExaminationName + examdesc);
            //        }
            //    }
            //    else
            //    {
            //        caseSheetComplaint.Append("." + sex + "On examination, she was found to be clinically normal for her gestational age ");
            //    }

            //    // Examination Details
                

            //    caseSheetComplaint.Append(". " + sex + " has been diagnosed to have ");

            //    string compdesc = string.Empty;
            //    string sQuery = string.Empty;

            //    for (int i = 0; i < lstPatientComplaint.Count; i++)
            //    {
            //        if (lstPatientComplaint[i].Query.Equals("Y"))
            //            sQuery = "?";

            //        if (lstPatientComplaint[i].Description != null && lstPatientComplaint[i].Description != "")
            //            compdesc = "-" + lstPatientComplaint[i].Description;
            //        else
            //            compdesc = "";

            //        if (i == 0)
            //            caseSheetComplaint.Append(sQuery + lstPatientComplaint[i].ComplaintName + compdesc);
            //        else if (i == lstPatientComplaint.Count - 1)
            //            caseSheetComplaint.Append(" and " + sQuery + lstPatientComplaint[i].ComplaintName + compdesc);
            //        else
            //            caseSheetComplaint.Append(", " + sQuery + lstPatientComplaint[i].ComplaintName + compdesc);

            //        sQuery = string.Empty;
            //    }
            //    caseSheetComplaint.Append(". " + sex + " is prescribed the following course of treatment and advice: ");

            //    lblComplaintDesc.Text = caseSheetComplaint.ToString();

            //    #endregion

            //    #region General Advice

            //    for (int m = 0, n = 1; m < lstPatientAdvice.Count; m++, n++)
            //    {
            //        PatientAdvice pa = new PatientAdvice();
            //        pa = lstPatientAdvice[m];
            //        caseSheetAdvice.Append("<table><tr align='left' style='text-align:left;font-family:Verdana;font-size:11px;'>");
            //        caseSheetAdvice.Append("<td nowrap='nowrap'>" + n.ToString() + ". </td>");
            //        caseSheetAdvice.Append("<td nowrap='nowrap'>" + pa.Description + "</td>");
            //        caseSheetAdvice.Append("</tr></table>");
            //    }
            //    lblANCAdvice.Text = caseSheetAdvice.ToString();

            //    #endregion

            //    #region Next Review Date

            //    lblReviewDate.Text = lstPatient[0].NextReviewDate;

            //    #endregion
            //}
            //else
            //{
            //    caseSheetLabel.Append("<table > ");
            //    caseSheetLabel.Append("<tr>");

            //    caseSheetLabel.Append("<td><font size='2'><b>No Case Sheet Available for the selected visit</b></font></td>");
            //    caseSheetLabel.Append("</tr>");
            //    caseSheetLabel.Append("</table>");

            //    lblPrescription.Text = caseSheetLabel.ToString();
            //}
            #endregion
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"../ANC/ANCPatientDignose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskId + "&mode=eV" + "", true);
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        long taskID;
        int referedCount, orderedCount;

        try
        {

            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }

            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            long BillID = 0;
            decimal dAMt = 0;

            if (PaymentLogic == "After")
            {
                billing.PatientVisitID = patientVisitID;
                billing.Consulting = true;
                billing.SaveFeesDetails(out BillID);
                dAMt = billing.ZeroAmt;
            }


            #region Create Task to Collect Inv Payment, Referred Inv, CaseSheet

            returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out orderedCount);

            //List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            if (orderedCount > 0)
            {
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), patientVisitID, 0, patientID,
                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, 
                "", 0, "", 0, "CON", out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, UID);
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.BillID = BillID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task               
                returnCode = taskBL.CreateTaskAllowDuplicate(task, out createTaskID);


                #region Commented by Sami
                //Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverANCCaseSheet), patientVisitID, 0, patientID,
                //    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                //    0, "", 0, "", 0, "CON", out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
                //task.DispTextFiller = dText;
                //task.URLFiller = urlVal;
                //task.RoleID = RoleID;
                //task.OrgID = OrgID;
                //task.BillID = BillID;
                //task.PatientVisitID = patientVisitID;
                //task.PatientID = patientID;
                //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //task.CreatedBy = LID;
                ////Create collection task
                //returnCode = taskBL.CreateTask(task, out createTaskID);
                #endregion

            }
            else
            {
                #region Commented by Sami
                //Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverANCCaseSheet), patientVisitID, 0, patientID,
                //    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 
                //    0, "", 0, "", 0, feeType, out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
                //task.DispTextFiller = dText;
                //task.URLFiller = urlVal;
                //task.RoleID = RoleID;
                //task.OrgID = OrgID;
                //task.BillID = BillID;
                //task.PatientVisitID = patientVisitID;
                //task.PatientID = patientID;
                //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //task.CreatedBy = LID;
                ////Create collection task
                //returnCode = taskBL.CreateTask(task, out createTaskID);
                #endregion
            }
            if (referedCount > 0)
            {
                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), patientVisitID, 0, patientID,
                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 
                0, "", 0, "CON", out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.BillID = BillID;
                task.PatientVisitID = patientVisitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task               
                returnCode = taskBL.CreateTask(task, out createTaskID);


            }

            if (orderedCount == 0)
            {
                int status = 0;
                //returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(patientVisitID, out status);
                if (PaymentLogic == "After")
                {
                    if (dAMt > 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 
                            0, "", 0, "", 0, feeType, out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = BillID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                    //Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverANCCaseSheet), patientVisitID, 0, patientID,
                    //    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal);

                    //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
                    //task.DispTextFiller = dText;
                    //task.URLFiller = urlVal;
                    //task.RoleID = RoleID;
                    //task.OrgID = OrgID;
                    //task.PatientVisitID = patientVisitID;
                    //task.PatientID = patientID;
                    //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //task.CreatedBy = LID;
                    ////Create collection task
                    //returnCode = taskBL.CreateTask(task, out createTaskID);

                    //Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                    //lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal);

                    //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverANCCaseSheet);
                    //task.DispTextFiller = dText;
                    //task.URLFiller = urlVal;
                    //task.RoleID = RoleID;
                    //task.OrgID = OrgID;
                    //task.PatientVisitID = patientVisitID;
                    //task.PatientID = patientID;
                    //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    //task.CreatedBy = LID;
                    ////Create collection task
                    //returnCode = taskBL.CreateTask(task, out createTaskID);
                    //}
                }
            }
            ///Task For Pharmacy From PatientPrescription 
            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            if (InvDrugData == "Y")
            {
                int ptaskID = 0;
                long PhysicianID = 0;
                DrugDetails pAdvices = new DrugDetails();
                PhysicianSchedule physician = new PhysicianSchedule();
                new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                pAdvices.PhysicianID = physician.PhysicianID;
                PhysicianID = pAdvices.PhysicianID;
                string PrescriptionNo = "0";
                string pTaskStatus = "";

                //returnCode = new Inventory_BL(base.ContextInfo).getPatientPrescriptiondrugCount(patientVisitID, out drugCount, out ptaskID, PhysicianID, out PrescriptionNo, out pTaskStatus);
                if (ptaskID > 0 && pTaskStatus == "PENDING")
                {
                    if (drugCount > 0)
                    {
                      //  returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, patientID, patientVisitID);
                    }
                }
                else
                {
                    if (drugCount > 0)
                    {

                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Pharmacy), patientVisitID, LID, patientID,
                              lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "",
                              0, "", 0, "", 0, "PRM", out dText, out urlVal, BillID, "", 0, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Pharmacy);


                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.BillID = BillID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        // task.LocationID = InvLocationID;
                        //task.TaskID = taskID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);

                        //returnCode = new Inventory_BL(base.ContextInfo).InsertTaskID("PRM", createTaskID, PrescriptionNo, OrgID, patientID, patientVisitID);


                    }
                }
            }
            #endregion

            Int64.TryParse(Request.QueryString["tid"], out taskID);

            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

            List<Role> lstUserRole1 = new List<Role>();
            string path1 = string.Empty;
            Role role1 = new Role();
            role1.RoleID = RoleID;
            lstUserRole1.Add(role1);
            returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
            Response.Redirect(Request.ApplicationPath  + path1, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
            btnOk.Visible = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ANC Case Sheet", ex);
            btnOk.Visible = true;
        }
    }
}
