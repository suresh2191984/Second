using System;
using System.Collections;
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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;



public partial class CaseSheet_CaseSheet : BasePage
{
    long patientVisitID = -1;
    int patientDetailsID = -1;
    long createTaskID = -1;
    
    long patientID = -1;
    int complaintID = -1;
    long taskID = -1;
    long returnCode = -1;
    long previousVID = -1;



    Tasks task = new Tasks();
    Tasks_BL taskBL;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    string PaymentLogic = String.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        if (PaymentLogic == String.Empty)
        {
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("CON", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                PaymentLogic = lstConfig[0].ConfigValue.Trim();
        }

        if (PaymentLogic == "After")
        {
            billing.LoadDBData = true;
        }
        else
        {
            billing.LoadDBData = false;
        }

        if (!Page.IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int32.TryParse(Request.QueryString["optionid"], out patientDetailsID);
            Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);
            PatientHeader1.PatientVisitID = patientVisitID;
            PatientHeader1.ShowVitalsDetails();
            OP1.LoadPatientDetails(previousVID, patientDetailsID);

            if (patientDetailsID == 1)
            {
                btnEdit.Visible = false;
            }
            else
            {
                btnEdit.Visible = true;
            }

            if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
            {
                if (Convert.ToInt32(Request.QueryString["vid"]) !=
                    Convert.ToInt32(Request.QueryString["pvid"]))
                {
                    //if (PaymentLogic == String.Empty)
                    //{
                    //    List<Config> lstConfig = new List<Config>();
                    //    new GateWay(base.ContextInfo).GetConfigDetails("CON", OrgID, out lstConfig);
                    //    if (lstConfig.Count > 0)
                    //        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                    //}

                    //if (PaymentLogic == "After")
                    //{
                        PhysicianSchedule physician = new PhysicianSchedule();
                        billing.Procedure = false;
                        billing.Investigation = false;
                        billing.Consulting = true;
                        billing.PhysicianID = LID;
                        billing.PatientVisitID = patientVisitID;

                        billing.loadData();
                   //}
                }
            }
            
        }
    }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int32.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);

            List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            if (Request.QueryString["vid"] != null && Request.QueryString["pvid"] != null)
            {
                if (Request.QueryString["vid"].ToString() == Request.QueryString["pvid"].ToString())
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(patientVisitID, out lstPatientComplaintDetail);
                else
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(previousVID, out lstPatientComplaintDetail);
            }
            else
            {
                returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(patientVisitID, out lstPatientComplaintDetail);
            }



            if (lstPatientComplaintDetail.Count > 1)
            {
                Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + taskID + "&pvid=" + previousVID + "&id=" + complaintID, true);
            }
            else if (lstPatientComplaintDetail.Count == 1)
            {
                Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + previousVID + "&tid=" + taskID + "", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        
        try
        {
            Int64.TryParse(Request.QueryString["vid"].ToString(), out patientVisitID);
            Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
            Int32.TryParse(Request.QueryString["id"].ToString(), out complaintID);
            Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
            Int64.TryParse(Request.QueryString["pvid"].ToString(), out previousVID);

            taskID = Convert.ToInt64(Request.QueryString["tid"]);

            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            PatientVisit_BL pvBL = new PatientVisit_BL(base.ContextInfo);
            string nextReviewDate;
            nextReviewDate = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();
            pvBL.SaveContinueSameTreatment(patientVisitID, previousVID, nextReviewDate, LID);
            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.PrescriptionPrinting), patientVisitID, 0, patientID,
            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PrescriptionPrinting);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = patientVisitID;
            task.PatientID = patientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            
            // Delete patient diagnose details only for current visit id.
            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
            if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
            {
                if (Convert.ToInt32(Request.QueryString["vid"]) ==
                    Convert.ToInt32(Request.QueryString["pvid"]))
                {
                    string rmvPres = "Remove";
                    returnCode = new Uri_BL(base.ContextInfo).DeletePatientDiagnoseDetail(complaintID, patientVisitID, rmvPres);
                    //Create collection task
                    returnCode = taskBL.CreateTask(task, out createTaskID);
                    Response.Redirect(@"../Physician/Home.aspx");
                }
                if (Convert.ToInt32(Request.QueryString["vid"]) !=
                    Convert.ToInt32(Request.QueryString["pvid"]))
                {
                    if (PaymentLogic == String.Empty)
                    {
                        List<Config> lstConfig = new List<Config>();
                        new GateWay(base.ContextInfo).GetConfigDetails("CON", OrgID, out lstConfig);
                        if (lstConfig.Count > 0)
                            PaymentLogic = lstConfig[0].ConfigValue.Trim();
                    }

                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverCaseSheet), patientVisitID, 0, patientID,
                                lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverCaseSheet);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = patientVisitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    //Create collection task
                    returnCode = taskBL.CreateTask(task, out createTaskID);

                    //if (PaymentLogic == "After")
                    //{
                    //  PhysicianSchedule physician = new PhysicianSchedule();
                        billing.Procedure = false;
                        billing.Investigation = false;
                        billing.Consulting = true;
                        billing.PhysicianID = LID;
                        billing.PatientVisitID = patientVisitID;
                        long BillID = 0;

                        if (!billing.SaveFeesDetails(out BillID))
                        {

                            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0, patientID,
                            lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "CON", out dText, out urlVal, BillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");

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
                            Response.Redirect(@"../Physician/Home.aspx");
                        }
                        else
                        {
                            //Create Handover Prescription task
                            returnCode = taskBL.CreateTask(task, out createTaskID);
                            Response.Redirect(@"../Physician/Home.aspx");

                        }
                //    }
                //    else
                //    {
                //        //Create collection task
                //        returnCode = taskBL.CreateTask(task, out createTaskID);
                //        Response.Redirect(@"../Physician/Home.aspx");
                //    }
                }
            }
            else
            {
                //Create collection task
                returnCode = taskBL.CreateTask(task, out createTaskID);
                Response.Redirect(@"../Physician/Home.aspx");
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
}
