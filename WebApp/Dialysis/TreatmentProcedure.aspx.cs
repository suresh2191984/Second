using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using Attune.Podium.BillingEngine;
using System.Web.Security;
using System.Text;

public partial class Dialysis_TreatmentProcedure : BasePage
{
    long visitID = -1;
    long proID = -1;
    long pID = -1;
    long returnCode = -1;
    int returnStatus = -1;
    long taskID = -1;
    long ptaskid = -1;
    string URL = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnSave.Enabled = true;
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        procedures.VisitID = visitID;
        if (!IsPostBack)
        {
            if (Request.UrlReferrer != null)
            {
                ViewState["Url"] = Request.UrlReferrer.ToString();
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["ProcID"], out proID);
        Int64.TryParse(Request.QueryString["pid"], out pID);
        string feeType = "PRO";

        List<Patient> lstPatient = new List<Patient>();
        Patient patient = new Patient();
        ViewState["URL"] = Request.UrlReferrer.ToString();
        returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(pID, out lstPatient);
        patient = lstPatient[0];

        List<PatientTreatmentProcedure> lstPTT = procedures.getPTT(visitID, proID);
        ((HiddenField)procedures.FindControl("hdnFromDate")).Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        List<PatientDueChart> lstpdd = procedures.getInPatientProcedureDetails();
        //List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = procedures.getPhysioDetails();

        //var lstPhysioTherophy = from Res in lstOrderedPhysiotherapy
        //                        where Res.ProcedureName != "Dialysis"
        //                                select Res;


        //if (lstPhysioTherophy.Count() > 0)
        //{
        //    string Type = "Ordered";
        //    returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(visitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy);


        //    Tasks task = new Tasks();
        //    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        //    Hashtable dText = new Hashtable();
        //    Hashtable urlVal = new Hashtable();
        //    List<TaskActions> lstTaskAction = new List<TaskActions>();
        //    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, visitID, 0,
        //           pID, patient.TitleName + " " + patient.Name, "", proID, "", 0, "", 0, feeType, out dText, out urlVal, 0, Convert.ToInt64(patient.PatientNumber), patient.TokenNumber, "");

        //    task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
        //    task.DispTextFiller = dText;
        //    task.URLFiller = urlVal;
        //    task.PatientID = pID;
        //    task.OrgID = OrgID;
        //    task.PatientVisitID = visitID;
        //    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        //    task.CreatedBy = LID;
        //    returnCode = taskBL.CreateTask(task, out ptaskid);

        //}
        if (lstPTT.Count > 0)
        {
            returnCode = new Dialysis_BL(base.ContextInfo).InsertPatientTreatmentProcedure(lstPTT, OrgID, out returnStatus);

            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            List<TaskActions> lstTaskAction = new List<TaskActions>();

            if (Request.QueryString["type"] == "d")
            {
                var lstPhysioTherophy = from Res in lstPTT
                                        where Res.ProcedureDesc == "Dialysis"
                                        select Res;
                if (lstPhysioTherophy.Count() > 0)
                {
                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PreDialysis, visitID, 0,
                        pID, patient.TitleName + " " + patient.Name, "", proID, "", 0, "", 0, feeType, out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                    task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = pID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    returnCode = taskBL.CreateTask(task, out ptaskid);
                }
            }

          


            if (Request.QueryString["EditMode"] == "Y")
            {
                if (ViewState["Url"] != null)
                {
                    URL = ViewState["Url"].ToString();
                    Response.Redirect(URL, true);
                }
            }
            else
            {
                long BillID = 0;
                BillingEngine billingBL = new BillingEngine(base.ContextInfo);
                List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
                SaveBillingDetails save;
                foreach (PatientDueChart row in lstpdd)
                {
                        save = new SaveBillingDetails();

                        save.ID = row.FeeID;
                        save.Amount = row.Amount;
                        save.Description = row.Description;
                        save.Quantity = row.Unit;
                    //save.
                        //save.IsGroup = row;

                        lstBillingDetails.Add(save);
                }

                billingBL.CreateProcedureBillingEntry(OrgID, visitID, out BillID, LID, lstBillingDetails, ILocationID);
                returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CollectPayment, visitID, 0,
                pID, patient.TitleName + " " + patient.Name, "", proID, "", 0, "", 0, feeType, out dText, out urlVal, BillID, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                task.TaskActionID = (int)TaskHelper.TaskAction.CollectPayment;
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.PatientID = pID;
                task.BillID = BillID;
                //task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = visitID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                returnCode = taskBL.CreateTask(task, out taskID);

                string pConfigKey = "IsReceptionCashier";
                string pOutStatus = string.Empty;

                returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);

                if (pOutStatus != "Y")
                {
                    Response.Redirect("~/Billing/Billing.aspx?vid=" + visitID + "&pid=" + pID + "&ptid=" + 0 + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&bid=" + BillID + "", true);
                    //Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + pID + "&ptid=" + ptaskid + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&ProcID=" + proID +"&Show=Y", true);
                }
                else
                {
                    List<Role> lstUserRole1 = new List<Role>();
                    string path1 = string.Empty;
                    Role role1 = new Role();
                    role1.RoleID = RoleID;
                    lstUserRole1.Add(role1);
                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                    Response.Redirect(Request.ApplicationPath + path1, true);
                }
                
            }

           
        }
        else
        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Chooseany1", "javascript:alert('Please Choose atleast any one Procedure');", true);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        List<Role> lstUserRole1 = new List<Role>();
        string path1 = string.Empty;
        Role role1 = new Role();
        role1.RoleID = RoleID;
        lstUserRole1.Add(role1);
        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
        Response.Redirect(Request.ApplicationPath + path1, true);
    }
}
