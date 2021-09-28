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


public partial class InPatient_PhysioCaseSheet : BasePage
{
    StringBuilder caseSheet = new StringBuilder();
    long visitID = 0;
    long patientID = 0;
    string VisitType = String.Empty;
    string patientName = string.Empty;
    string sex = string.Empty;
    string AgeSex = string.Empty;
    string PatientNo = string.Empty;
    string ConsultantName = string.Empty;
    string clinical = string.Empty;
    string rolename = string.Empty;
    long parentVID = 0;
    string symptoms = string.Empty;
    string PhysicianComments = string.Empty;
    string type = string.Empty;
    long finalVisitID = 0;
    long procID;
    List<PatientPhysioDetails> lsPatientPhysioDetails = new List<PatientPhysioDetails>();
    static string EmpNo = "0";
    int PhysioCount = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Patient> lstPatient = new List<Patient>();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);

        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
       // tdCurrent.Style.Add("display", "block");
        //divCurrent.Attributes.Add("display", "block");
        //tdConsolidate.Style.Add("display", "none");
        //divConsol.Style.Add("display", "none");
        if (Request.QueryString["role"] != null)
        {
            rolename = Request.QueryString["role"].ToString();
        }       

        objPatient_BL.GetPatientVisitType(patientID, visitID, out lstPatientVisit);

        if (lstPatientVisit[0].VisitType == 0)
        {
            VisitType = "OP";
        }
        else
        {
            VisitType = "IP";
        }
        objPatient_BL.BindPatientRegDetail(patientID, visitID, VisitType, out lstPatient);

        if (VisitType == "IP")
        {
            List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
            new Patient_BL(base.ContextInfo).GetPrimaryConsultant(visitID, 1, out lstPrimaryConsultant);

            if (lstPrimaryConsultant.Count > 0)
            {
                foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                {
                    if (ConsultantName == "")
                    {
                        ConsultantName = objPC.PhysicianName;
                    }
                    else
                    {
                        ConsultantName += " , " + objPC.PhysicianName;
                    }

                }
            }


            patientName = lstPatient[0].Name;
            sex = (lstPatient[0].SEX == "M") ? "Male" : "Female";
            AgeSex = lstPatient[0].Age + " / " + sex;
            PatientNo = lstPatient[0].PatientNumber.ToString();
        }

        else
        {
            patientName = lstPatient[0].Name;
            sex = (lstPatient[0].SEX == "M") ? "Male" : "Female";
            AgeSex = lstPatient[0].Age + " / " + sex;
            PatientNo = lstPatient[0].PatientNumber.ToString();
            if (lstPatient[0].ReferingPhysicianName != null)
            {
                ConsultantName = "Dr. " + lstPatient[0].ReferingPhysicianName;
            }
            else if (lstPatient[0].PrimaryPhysician != null)
            {
                ConsultantName = lstPatient[0].PrimaryPhysician;
            }
        }

        List<PhysioCompliant> lstPhysioCompliant = new List<PhysioCompliant>();
        objPatient_BL.GetPhysioComplaint(patientID, visitID, out lstPhysioCompliant);
        if (lstPhysioCompliant.Count > 0)
        {
            for (int i = 0; i < lstPhysioCompliant.Count(); i++)
            {
                clinical = clinical + lstPhysioCompliant[i].ComplaintName.ToString() + "<br>&nbsp ";
            }
           
        }        
        objPatient_BL = new Patient_BL(base.ContextInfo);        
        //if (Request.QueryString["parentVID"] != null && Request.QueryString["parentVID"] !="")
        //{
        //    Int64.TryParse(Request.QueryString["parentVID"], out parentVID);            
        //}
        //if (parentVID != 0 && parentVID != null)
        //{
        //    type = "PRTVID";
        //    finalVisitID = parentVID;
        //}
        //else
        //{
            type = "CVID";
            finalVisitID = visitID;
        //}
        objPatient_BL.GetPatientPhysioDetail(patientID, finalVisitID, type, out lsPatientPhysioDetails);
        if (lsPatientPhysioDetails.Count > 0)
        {
            if (rolename == "Receptionist")
            {
                btnEdit.Visible = false;
                btnHome.Visible = false;
                btnBack.Visible = true;
            }
            else
            {
                btnEdit.Visible = true;
                btnHome.Visible = true;
                btnBack.Visible = false;
            }
            string VisittypeID = "Current";
            PhysioDetialCaseSheet(VisittypeID, visitID);
            //VisittypeID = "Consolidate";
            //if (Request.QueryString["parentVID"] != null)
            //{
            //    Int64.TryParse(Request.QueryString["parentVID"], out parentVID);
            //    PhysioDetialCaseSheet(VisittypeID, parentVID);
            //}
        }
        else
        {
            lblPhysio.Text = "There is no Details for this Patient, Yet to Perform";
            if (rolename == "Receptionist")
            {
                btnEdit.Visible = false;
                btnHome.Visible = false;
                btnBack.Visible = true;
                btnPrint.Disabled = true;
            }
            else
            {
                btnEdit.Visible = true;
                btnHome.Visible = true;
                btnBack.Visible = false;
            }
        }
    }
    
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            #region Physiotherapy Task
            if (IsCorporateOrg == "Y")
            {
                Int32.TryParse(Request.QueryString["PhysioCount"], out PhysioCount);
                Patient patient;
                List<Patient> lsPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                string feeType = String.Empty;
                feeType = "PRO";
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                long retunCode = -1;
                long taskID = -1;
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                if (taskID > 0)
                {
                    retunCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
                long physioTaskID;
                long retnCode = -1;
                if (PhysioCount > 0)
                {
                    retnCode = patientBL.GetPatientDemoandAddress(patientID, out lsPatient);
                    patient = lsPatient[0];
                    if (lsPatient.Count > 0)
                    {
                        EmpNo = lsPatient[0].PatientNumber.ToString();
                    }
                    retnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, visitID, 0,
                           patientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, feeType, out dText,
                           out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, "");
                    task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = patientID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    retnCode = taskBL.CreateTask(task, out physioTaskID);
                    //foreach (var items in lstOrderedPhysiotherapy)
                    //{
                    //    for (int i = 0; i < lstOrderedPhysiotherapy.Count; i++)
                    //    {
                    //        PatientDueChart inValues = new PatientDueChart();
                    //        inValues.FeeID = lstOrderedPhysiotherapy[i].ProcedureID;
                    //        inValues.FeeType = "PRO";
                    //        inValues.Description = lstOrderedPhysiotherapy[i].ProcedureName;
                    //        inValues.DetailsID = physioTaskID;
                    //        inValues.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    //        inValues.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    //        //lstBillingforTask.Add(inValues);
                    //    }
                    //}
                }
            }
            else
            {
                Int32.TryParse(Request.QueryString["PhysioCount"], out PhysioCount);
                Patient patient;
                List<Patient> lsPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                string feeType = String.Empty;
                feeType = "PRO";
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                long retunCode = -1;
                long taskID = -1;
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                if (taskID > 0)
                {
                    retunCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
                long physioTaskID;
                long retnCode = -1;
                if (PhysioCount > 0)
                {
                    retnCode = patientBL.GetPatientDemoandAddress(patientID, out lsPatient);
                    patient = lsPatient[0];
                    if (lsPatient.Count > 0)
                    {
                        EmpNo = lsPatient[0].PatientNumber.ToString();
                    }
                    retnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, visitID, 0,
                           patientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, feeType, out dText,
                           out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, "");
                    task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = patientID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    retnCode = taskBL.CreateTask(task, out physioTaskID);
                }
            #endregion
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
    public void PhysioDetialCaseSheet(string VisittypeID, long visitID)
    {
       
        List<PatientPhysioDetails> lstPhysioHeader = new List<PatientPhysioDetails>();
        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>(); 
        if (VisittypeID == "Current")
        {
           lstPhysioHeader = (from ex in lsPatientPhysioDetails
                                         where ex.VisitID == visitID
                                         select ex).ToList();
           foreach (var varPhysioHeader in lstPhysioHeader)
           {
               symptoms = varPhysioHeader.Symptoms;
               PhysicianComments = varPhysioHeader.PhysicianComments;
               chkShowAll.Visible = false;
               lblShowAll.Visible = false;
           }
        }
        //else
        //{
        //    lstPhysioHeader = (from ex in lsPatientPhysioDetails
        //                       where ex.ParentID == visitID
        //                       select ex).ToList();
        //    foreach (var varPhysioHeader in lstPhysioHeader)
        //    {
        //        symptoms = varPhysioHeader.Symptoms;
        //        PhysicianComments = varPhysioHeader.PhysicianComments;
        //    }
        //}        

        caseSheet.Append("<table border='1' width='100%' align='center' style='border-collapse:collapse; border-color:Black; border-style:solid; border-width:1pt; font-family: Tahoma;'>");
        caseSheet.Append("<tr><td align='center'><b><u> CASESHEET </u></b></td></tr>");
        caseSheet.Append("<tr><td align='justify'> <table border='0' align='center' width='100%'><tr><td width='25%'> PATIENT NAME </td><td width='45%'>:" + "&nbsp " + patientName + "</td>");
        caseSheet.Append("<td width='15%'> AGE/SEX </td><td width='45%'>:" + "&nbsp " + AgeSex + "</td></tr>");
        caseSheet.Append("<tr><td> PATIENT NO </td><td>:" + "&nbsp " + PatientNo + "</td>");
        if (ConsultantName != "")
        {
            caseSheet.Append("<td> CONSULTANT NAME</td><td>:" + "&nbsp " + ConsultantName + "</td></tr>");
        }
        else
        {
            caseSheet.Append("<td> &nbsp;</td><td> &nbsp;</td></tr>");
        }
        if (clinical.Trim() != "")
        {
            caseSheet.Append("<tr><td valign='top'> CLINICAL DIAGNOSIS </td><td valign='top' colspan='2'>:" + "&nbsp;" + clinical.Trim() + "&nbsp;</td></tr>");
        }
        else
        {
            caseSheet.Append("<tr><td> &nbsp;</td><td> &nbsp;</td></tr>");
        }
        caseSheet.Append("<tr><td valign='top'> SYMPTOMS / HISTORY </td><td valign='top' colspan='2'>:" + "&nbsp;" + symptoms + "&nbsp;</td></tr>");

        if (PhysicianComments != "")
        {
            caseSheet.Append("<tr><td valign='top'> PHYSICIAN COMMENTS </td><td valign='top' colspan='2'>:" + "&nbsp;" + PhysicianComments + "&nbsp;</td></tr>");
        }
        else
        {
            caseSheet.Append("<tr><td> &nbsp;</td><td> &nbsp;</td></tr>");
        }
        caseSheet.Append("</table></td></tr>");

        caseSheet.Append("<tr><td><table  align='center' border='0'  cellpadding='3' cellspacing='2' width='100%'><tr><td align='center' colspan='4'><u><b> PHYSIOTHERAPHY DETAILS </b></u></td></tr>");

        List<PatientPhysioDetails> lstPhysioConsolidate = new List<PatientPhysioDetails>();
        if (VisittypeID == "Current")
        {
            lstPhysioConsolidate = (from ex in lsPatientPhysioDetails
                                    where ex.VisitID == visitID
                                    select ex).ToList();           
        }
        else
        {
            lstPhysioConsolidate = (from ex in lsPatientPhysioDetails
                                    where ex.ParentID == visitID
                                    select ex).ToList();            
        }
        caseSheet.Append("<tr>");
        caseSheet.Append("<td>");
        caseSheet.Append("<table border='1' cellpadding='8' cellspacing='0' class='dataheaderInvCtrl' width='100%' height='50%' style='font-family: Tahoma'>");
        caseSheet.Append("<tr style='background-color:#2c88b1'>");
        caseSheet.Append("<td><b> PROCEDURE NAME </b></td>");
        caseSheet.Append("<td><b> DURATION </b></td>");
        caseSheet.Append("<td><b> ADVICED NO. OF SITTING </b></td>");
        caseSheet.Append("<td><b> CURRENT SITTING </b></td>");
        caseSheet.Append("<td><b> PHYSIOTHERAPHY NOTES </b></td>");
        caseSheet.Append("<td><b> NEXT REVIEW DATE </b></td>");
        caseSheet.Append("</tr>");
        foreach (var lstBind in lstPhysioConsolidate)
        {
            caseSheet.Append("<tr><td>" + "&nbsp " + lstBind.ProcedureName + "</td>");
            string strDur = lstBind.DurationValue.ToString();
            if (strDur.Contains(".00"))
            {
                strDur = strDur.Replace(".00", "");
            }
            caseSheet.Append("<td>" + "&nbsp " + strDur + " " + lstBind.DurationUnits + "</td>");
            caseSheet.Append("<td>" + "&nbsp " + lstBind.AdvisedNoOfSitting + "</td>");
            caseSheet.Append("<td>" + "&nbsp " + lstBind.CurrentNoOfSitting + "</td>");
            //string strScore = lstBind.ScoreCardValue.ToString();
            //if (strScore.Contains(".00"))
            //{
            //    strScore = strScore.Replace(".00", "");
            //}
            caseSheet.Append("<td>" + "&nbsp " + lstBind.Remarks.Split('|')[0] + "</td>");
            //caseSheet.Append("<tr><td style='display:none'> SCORE CARD VALUE </td><td style='display:none'>:" + "&nbsp " + strScore.ToString() + "</td>");
            if (lstBind.NextReview != "")
            {
                DateTime dtTime = Convert.ToDateTime(lstBind.NextReview);
                string nxtReview = dtTime.ToString(" dd/MM/yyyy ").Trim();
                caseSheet.Append("<td>" + "&nbsp " + nxtReview + "</td>");
            }
            caseSheet.Append("</tr>");
        }
        caseSheet.Append("</table></td></tr>");
        caseSheet.Append("<tr><td>");
        Patient_BL objPatient = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        long proTaskStatusID = -1;
        returnCode = objPatient.GetOrderedPhysio(patientID, visitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);
        if (lstOrderedPhysiotherapy.Count > 0)
        {
            caseSheet.Append("<table class='dataheaderInvCtrl'>");
            caseSheet.Append("<tr style='background-color:#2c88b1'><td style='font-bold:true'> Procedure Name</td><td style='font-bold:true'>No. Of Sitting</td></tr>");
            foreach (var orderedPhysio in lstOrderedPhysiotherapy)
            {
                caseSheet.Append("<tr><td>" + orderedPhysio.ProcedureName + "</td>");
                caseSheet.Append("<td>" + String.Format("{0:0}", orderedPhysio.OdreredQty).ToString() + "</td></tr>");
            }
            caseSheet.Append("</table>");
        }
        caseSheet.Append("</td></tr></table></td></tr></table>");
        if (VisittypeID == "Current")
        {
            lblPhysio.Text = caseSheet.ToString();
        }
        //Int64.TryParse(Request.QueryString["parentVID"], out parentVID);
        //if (parentVID != 0)
        //{
        //    lblConsolidate.Text = caseSheet.ToString();
        //}
        //else
        //{
        //    lblConsolidate.Text = lblPhysio.Text;
        //}
        caseSheet.Length = 0;
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string parentVisitID = string.Empty;
        if (Request.QueryString["parentVID"] != null)
        {
            parentVisitID = Request.QueryString["parentVID"].ToString();
        }
        if (Request.QueryString["ProcID"] != null)
        {
            Int64.TryParse(Request.QueryString["ProcID"], out procID);
        }
        long taskID = -1;
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Response.Redirect("../InPatient/PhysiotherapyNotes.aspx?pid=" + patientID + "&vid=" + visitID + "&mode=" + "U" + "&Edit=" + "Y" + "&parentVID=" + parentVisitID + "&ProcID=" + procID + "&tid=" + taskID.ToString(), true);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (rolename == "Receptionist")
        {
            Response.Redirect("../Corporate/CorporatePatientSearch.aspx");
        }
        else
        {
            Response.Redirect("../Home.aspx");
        }
    }
}
