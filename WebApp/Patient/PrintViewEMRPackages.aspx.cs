using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;

public partial class Patient_PrintViewEMRPackages : BasePage
{
    long visitID = -1;
    long patientID = -1;
    long taskID = -1;
    long returnCode = -1;
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    string PaymentLogic = String.Empty;
    string feeType = "HEALTHPKG";
    long FinalBillID = 0;
    decimal dAMt = 0;
    string Url = string.Empty;
    string BackBtn = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);

        //if (RoleName == "Physician Assistant")
        //{
        //    btnsavecont.Visible = false;
        //}
        //else
        //{
        //    btnsavecont.Visible = true;
        //}
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
        }
        else
        {
            billing.LoadDBData = false;
        }        
        if (!IsPostBack)
        {
           try
           {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            PrintHistory1.LoadHistoryData(visitID);
            PrintExam1.LoadExamData(visitID);
            InvestigationReportViewer.ShowInvestigation(visitID);
            //PrInvestigation.LoadInvestigation(visitID);
            PrintDiagnostics1.LoadDiagnostics(visitID);
             PrintDiagnostics1.LoadDiagnostics(visitID);
            ViewState["Url"] = Request.UrlReferrer.ToString();
            if (PaymentLogic == "After")
            {
                //PhysicianSchedule physician = new PhysicianSchedule();
                //new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                billing.Procedure = false;
                billing.Investigation = false; //temp
                billing.Consulting = false;
                billing.PhysicianID = LID;
                billing.PatientVisitID = visitID;
                //billing.LoadDBData = true;
                if (Request.QueryString["sp"] != "N")
                {
                    billing.Visible = true;
                    billing.loadData();
                }
            }
            else if (PaymentLogic == "Before")
            {
                PhysicianSchedule physician = new PhysicianSchedule();
                //new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
                billing.Procedure = false;
                billing.Investigation = false;//temp
                billing.Consulting = false;
                billing.PhysicianID = LID;
                billing.PatientVisitID = visitID;
                //billing.LoadDBData = false;
                billing.loadData();
            }
            billing.Visible = false;

            //if (Request.QueryString["PCL"] == "Y")
            //{
            //    btnEdit.Visible = false;
            //    btnSaveExit.Visible = false;
            //}
            //else
            //{
            //    btnEdit.Visible = true;
            //    btnSaveExit.Visible = true;
            //}
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "pop", "popupprint();", true);

        }
            catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
        }

        
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {        
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        try
        {
            Response.Redirect("../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&tid=" + taskID + "&mode=" + "U", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    protected void btnSaveExit_Click(object sender, EventArgs e)
    {
        try{
            fn_Save();

                //Response.Redirect("../Patient/PatientRecommendation.aspx?pid=" + patientID + "&vid=" + visitID, true);
                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                //Response.Redirect(Request.ApplicationPath + path1, false);
                Response.Redirect("../Patient/PrintEMRPackages.aspx?pid=" + patientID + "&vid=" + visitID, true);
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }
    private void fn_Save()
    { 
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        try
        {
            BackBtn = "";
            BackBtn = Request.QueryString["BackBtn"];
            if (taskID > 0 && BackBtn == null)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

                if (PaymentLogic == String.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }

                if (PaymentLogic == "After")
                {
                    billing.PatientVisitID = visitID;
                    billing.Consulting = true;
                    billing.SaveFeesDetails(out FinalBillID);
                    dAMt = billing.ZeroAmt;
                }
                else if (PaymentLogic == "Before")
                {
                    billing.PatientVisitID = visitID;
                    billing.Consulting = true;
                    billing.SaveFeesDetails(out FinalBillID);
                    dAMt = billing.ZeroAmt;
                }
                else
                {

                }

                Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientID,
                    lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.BillID = FinalBillID;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;

                //Create task               
                returnCode = taskBL.CreateTask(task, out taskID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
            
    }

    protected void btnPatientRecomendation_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        string feeType = "HEALTHPKG";
        try
        {
            BackBtn = "";
            BackBtn = Request.QueryString["BackBtn"];
            if (taskID > 0 && BackBtn == null)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

                if (PaymentLogic == String.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }

                if (PaymentLogic == "After")
                {
                    billing.PatientVisitID = visitID;
                    billing.Consulting = true;
                    billing.SaveFeesDetails(out FinalBillID);
                    dAMt = billing.ZeroAmt;
                }
                else if (PaymentLogic == "Before")
                {
                    billing.PatientVisitID = visitID;
                    billing.Consulting = true;
                    billing.SaveFeesDetails(out FinalBillID);
                    dAMt = billing.ZeroAmt;
                }
                else
                {

                }
                if (Request.QueryString["PCL"] != "Y")
                {
                    Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.InvestigationPayment), visitID, 0, patientID,
                        lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, feeType, out dText, out urlVal, FinalBillID, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.BillID = FinalBillID;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;

                    //Create task               
                    returnCode = taskBL.CreateTask(task, out taskID);
                }
            }

            Response.Redirect("../Patient/PatientRecommendation.aspx?pid=" + patientID + "&vid=" + visitID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Redirect to EMR Examination Page", ex);
        }
    }



     protected void btnsavecontinue_Click(object sender, EventArgs e)
 
       {

          
           fn_Save();
           Response.Redirect("../Physician/diabetesEMR.aspx?pid=" + patientID + "&vid=" + visitID, true);

          }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Response.Redirect("../Patient/PatientEMRPackage.aspx?pid=" + patientID + "&vid=" + visitID + "&taskID=" + taskID, true);
        //Url = ViewState["Url"].ToString() + "&BackBtn=Y";
        //Response.Redirect(Url, true);
    }
}
