using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Data;
using Attune.Podium.Common;
using System.Collections;
public partial class Physician_CaseSheetDialysis : BasePage
{
    long patientVisitID = -1;
    long procedureID = -1;
    long taskID = -1;
    string PaymentLogic = string.Empty;
    string ftype = string.Empty;
    PatientVisitDetails patientVisit = new PatientVisitDetails();

   

    protected void Page_Load(object sender, EventArgs e)
    {
        // ftype is used to find the PaymentLogic for Dialysis
        ftype = "PRO";
        // ftype

        if (Request.QueryString["vid"] != null)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["ProcID"], out procedureID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            FeesEntry1.Procedure = true;
            FeesEntry1.ProcedureID = procedureID;
            FeesEntry1.PatientVisitID = patientVisitID;
            FeesEntry1.OrgID = OrgID;

            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(ftype, OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }

            if (PaymentLogic == "Before")
            {
                FeesEntry1.LoadDBData = false;
            }
            else
            {
                FeesEntry1.LoadDBData = true;
            }
            
            if (!Page.IsPostBack)
            {

                //Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                //Int64.TryParse(Request.QueryString["ProcID"], out procedureID);
                //Int64.TryParse(Request.QueryString["tid"], out taskID);

                //FeesEntry1.Procedure = true;
                //FeesEntry1.ProcedureID = procedureID;
                //FeesEntry1.PatientVisitID = patientVisitID;
                //FeesEntry1.OrgID = OrgID;

                //if (PaymentLogic == String.Empty)
                //{
                //    List<Config> lstConfig = new List<Config>();
                //    new GateWay(base.ContextInfo).GetConfigDetails(ftype, OrgID, out lstConfig);
                //    if (lstConfig.Count > 0)
                //        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                //}

                //if (PaymentLogic == "Before")
                //{

                //    FeesEntry1.LoadDBData = false;
                //    FeesEntry1.loadData();
                //}
                //else
                //{
                //    FeesEntry1.LoadDBData = true;
                //    FeesEntry1.loadData();
                //}

                //patientHeader.PatientID = patientID;
                patientHeader.PatientVisitID = patientVisitID;
                FeesEntry1.sCheckAll = "Y";
                FeesEntry1.loadData();


                PatientVisit_BL patVisitBL = new PatientVisit_BL(base.ContextInfo);
                List<PatientVisitDetails> pVisitDetails = new List<PatientVisitDetails>();
                patVisitBL.GetVisitDetails(patientVisitID, out pVisitDetails);
                if (pVisitDetails.Count > 0)
                    patientVisit = pVisitDetails[0];
            }
        }
       
    }

    protected void dialysis_savecompleted(object sender, EventArgs e)
    {
        //Response.Redirect("~\\Dialysis\\DialysisCaseSheetPrint.aspx", true);
    }

    protected void bSave_Click(object sender, EventArgs e)
    {

        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Int64.TryParse(Request.QueryString["ProcID"], out procedureID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);

        FeesEntry1.Procedure = true;
        FeesEntry1.PatientVisitID = patientVisitID;
        FeesEntry1.OrgID = OrgID;

        long createTaskID = -1;
        long returnCode = -1;
        try
        {
            Uri_BL uriBL = new Uri_BL(base.ContextInfo);
            Dialysis_BL dBL = new Dialysis_BL(base.ContextInfo);
            List<PatientPrescription> pPres = new List<PatientPrescription>();
            PatientPayments pPayment = new PatientPayments();
            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            List<DrugDetails> drgDet = uPres.GetPrescription(patientVisitID);
            decimal amount = 0;
            foreach (DrugDetails drg in drgDet)
            {
                PatientPrescription pp = new PatientPrescription();
                //pp.DrugID = drg.DrugID;
                pp.PatientVisitID = drg.PatientVisitID;
                pp.BrandName = drg.DrugName;
                pp.Dose = drg.Dose;
                pp.Formulation = drg.DrugFormulation;
                pp.ROA = drg.ROA;
                pp.Duration = drg.Days;
                pp.DrugFrequency = drg.DrugFrequency;
                pp.CreatedBy = LID;
                pPres.Add(pp);
            }
            if (pPres.Count > 0)
            {
                returnCode = dBL.SavePrescription(pPres);
            }
            else
            {
                returnCode = 0;
            }
            long FinalBillID = 0;
            FeesEntry1.SaveFeesDetails(out FinalBillID);
            if (returnCode != 0)
            {                
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was an error. Please try after sometime";                
                CLogger.LogWarning("Error:DialysisAdvice:Save: Non-zero returnvalue");
            }
            else
            {
                #region Old Code

                //if (patientVisitID > 0)
                //{
                    
                //    Payment_BL payBL = new Payment_BL(base.ContextInfo);
                //    //Decimal.TryParse(tAmt.Text, out amount);
                //    pPayment.Amount = amount;
                //    pPayment.PatientVisitID = patientVisitID;
                //    pPayment.PatientID = patientVisit.PatientId;
                //    pPayment.CreatedBy = UID;
                //    returnCode = payBL.InsertAmouttobePaid(pPayment);
                //    if (returnCode == 0)
                //    {

                //        //*******for Task*******************
                //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                //        task.PatientID = patientVisitID;
                //        task.RoleID = RoleID;
                //        task.OrgID = OrgID;
                //        task.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Pending);
                //        urlVal.Add("PatientVisitID", patientVisitID);
                //        dText.Add("PatientName", patientVisit.PatientName);
                //        task.DispTextFiller = dText;
                //        task.URLFiller = urlVal;
                //        returnCode = taskBL.CreateTask(task);
                //        if (returnCode != 0)
                //        {
                //            lblStatus.Text = "Patient name may not appear in the task screen";
                //            CLogger.LogWarning("Task was not created DialysisAdvice:CreateTask: returnCode:" + returnCode.ToString());
                //        }
                //        else
                //        {
                //            Response.Redirect("~\\Nurse\\Home.aspx", true);
                //        }
                //    }


                //}
                #endregion

                int status=-1;
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

                returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(patientVisitID, out status);
                if (status == 0)
                {
                    PatientVisitDetails patientVisit = new PatientVisitDetails();
                    patientVisit = lstPatientVisitDetails[0];

                    //HiddenField hdnPro = new HiddenField();
                    //hdnPro = (HiddenField)FeesEntry1.FindControl("hdnProAmount");
                    decimal zeroPro = FeesEntry1.ZeroAmt;
                    if (zeroPro != 0)
                    {
                        Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitID, 0, patientVisit.PatientID,
                           patientVisit.PatientName, "", 0, "", 0, "", 0, "PRO", out dText, out urlVal, FinalBillID, patientVisit.PatientNumber, patientVisit.TokenNumber, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.BillID = FinalBillID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientVisit.PatientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //Create collection task
                        returnCode = taskBL.CreateTask(task, out createTaskID);
                    }
                    long pid;
                    string PatientName, MachineName, LastTestTime;

                    dBL.GetHTParamsForOnFlowTask(patientVisitID, out pid, out PatientName, out MachineName, out LastTestTime);
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverDialysisCaseSheet);
                    returnCode = taskBL.CreateTask(task, out createTaskID);

                }
                // Need To Check with get landing page
                Response.Redirect("../Dialysis/Home.aspx", true);

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing DialysisAdvice: ", ex);
        }
    }
    
}
