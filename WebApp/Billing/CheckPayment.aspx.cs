using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class Billing_CheckPayment : BasePage
{

    public Billing_CheckPayment()
        : base("Billing\\CheckPayment.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }



    long patientVisitID = -1; long billDetailsID = -1;
    long patientID = -1;
    string feeType = String.Empty;
    long taskID = -1;
    long ptaskID = -1;
    long returnCode = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    long procedureID = -1;
    long physicianID = -1;
    string PaymentLogic = string.Empty;
    string URL = string.Empty;
    int? VisitType = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        taskBL = new Tasks_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID); 
        Int64.TryParse(Request.QueryString["bdid"], out billDetailsID);
        feeType = Request.QueryString["ftype"].ToString();
        try
        {
            FeesEntry1.sCheckAll = "N";
            if (Request.QueryString["Show"] != null)
            {
                if (Request.QueryString["Show"] != "Y")
                {
                    btnBack.Visible = true;
                }
            }
            else
            {
                btnBack.Visible = false;
            }
            if (feeType == "CON")
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisit);
                patientID = lstPatientVisit[0].PatientID;
                physicianID = lstPatientVisit[0].PhysicianID;
                VisitType = lstPatientVisit[0].VisitType;
               
                FeesEntry1.Consulting = true;
            }
            else if (feeType == "PRO")
            {
                Int64.TryParse(Request.QueryString["ProcID"], out procedureID);
                FeesEntry1.Procedure = true;
            }
            else if (feeType == "INV")
            {
                FeesEntry1.Investigation = true;
            }
            else if (feeType == "IMU")
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisit);
                patientID = lstPatientVisit[0].PatientID;
                FeesEntry1.Immunization = true;
                FeesEntry1.LoadDBData = true;
            }
            else if (feeType == "CAS")
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisit);
                patientID = lstPatientVisit[0].PatientID;
                //physicianID = lstPatientVisit[0].PhysicianID;
                FeesEntry1.Casualty = true;
            }
            else if (feeType == "HEALTHPKG")
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisit);
                patientID = lstPatientVisit[0].PatientID;
                physicianID = lstPatientVisit[0].PhysicianID;
                FeesEntry1.HealthPackage = true;
            }
            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }
            if (PaymentLogic == "Before")
            {
                if (Request.QueryString["ABI"] != "Y")
                {
                    FeesEntry1.LoadDBData = true;
                }
                else
                {
                    FeesEntry1.LoadDBData = false;
                }                
            }
            else
            {
                List<Patient> lstPatient = new List<Patient>();
                List<Speciality> lstSpeciality = new List<Speciality>();
                List<AllPhysicianSchedules> lstPhysicianSchedule = new List<AllPhysicianSchedules>();
                returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(patientVisitID, patientID, out lstPatient,out lstSpeciality,out lstPhysicianSchedule);
                if (lstPatient.Count > 0)
                {
                    if (lstPatient[0].SecuredCode != "")
                    {
                        FeesEntry1.LoadDBData = true;
                    }
                    else
                    {
                        FeesEntry1.LoadDBData = false;
                    }
                }

            }
            FeesEntry1.PatientVisitID = patientVisitID;
            FeesEntry1.ProcedureID = procedureID;
            FeesEntry1.PhysicianID = physicianID;

            if (!Page.IsPostBack)
            {
               
                List<FeeTypeMaster> lstFeeTypeMaster=new List<FeeTypeMaster>();

                new BillingEngine(base.ContextInfo).GetFeeType(OrgID,(VisitType==0 ? "OP":"IP"),out lstFeeTypeMaster);
                
                if (lstFeeTypeMaster.Count > 0)
                {
                    FeesEntry1.LstFeeTypeMaster = lstFeeTypeMaster;
                }
                
                if (btnBack.Visible == true)
                {
                    ViewState["Url"] = Request.UrlReferrer.ToString();
                    txtB.Value = ViewState["Url"].ToString();
                }
                btnSave.Enabled = true;
                if (billDetailsID <= 0)
                {
                    FeesEntry1.loadData();
                }
                else
                {
                    FeesEntry1.loadDifferenceAmount();
                }
                //Check Fees type variable or not...
                GridView gv = (GridView)FeesEntry1.FindControl("gvFeesEntry");
                foreach (GridViewRow row in gv.Rows)
                {
                    Label lblisVariable = (Label)row.FindControl("lblisVariable");
                    if (lblisVariable.Text == "N")
                    {
                        btnSave_Click(sender, e);
                        break;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Billing CheckPayment Load", ex);
        }         
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (!IsCrossPagePostBack)
        //{
        btnSave.Enabled = false;
        try
        {
            feeType = Request.QueryString["ftype"].ToString();
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            string sFx = "N";
            if (Request.QueryString["isDoc"] != null && Request.QueryString["isDoc"].ToString() != "")
            {
                sFx = Request.QueryString["isDoc"].ToString().Trim();
                feeType = "CON";
            }
            if (feeType == "CON")
                FeesEntry1.Consulting = true;
            else if (feeType == "PRO")
                FeesEntry1.Procedure = true;
            else if (feeType == "INV")
                FeesEntry1.Investigation = true;
            else if (feeType == "IMU")
                FeesEntry1.Immunization = true;
            else if (feeType == "CAS")
                FeesEntry1.Casualty = true;

            FeesEntry1.PatientVisitID = patientVisitID;
            long BillID = 0;
            FeesEntry1.SaveFeesDetails(out BillID);
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["ptid"], out ptaskID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            feeType = Request.QueryString["ftype"].ToString();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<Patient> lstPatient = new List<Patient>();
            // - For Update in Patient Procedure Paid Status
            long rCode = -1;
            rCode = new Dialysis_BL(base.ContextInfo).UpdatePatientTreatmentProcedure(patientVisitID, OrgID);
            //
            returnCode = taskBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
            // Collect payment task
            task = new Tasks();
            dText = new Hashtable();
            urlVal = new Hashtable();
            returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
            returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CollectPayment, patientVisitID, 0,
            patientID, lstPatient[0].Name, "", 0, "", 0, "", ptaskID, feeType, out dText, out urlVal, BillID,
            lstPatient[0].PatientNumber, 0,""); // Other Id meand Procedure ID
            task.TaskActionID = (int)TaskHelper.TaskAction.CollectPayment;
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.PatientID = patientID;
            task.BillID = BillID;
            //task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = patientVisitID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            returnCode = taskBL.CreateTask(task, out taskID);
            if (Request.QueryString["ABI"] != "Y")
            {
                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                string strValues = path1.Split('/')[1];
                if (strValues != "Nurse" && sFx == "N")
                {
                    Response.Redirect(@"~\Billing\Billing.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&ptid=" + ptaskID + "&ftype=" + feeType + "&tid=" + taskID.ToString() + "&bid=" + BillID + "", true);
                }
                Response.Redirect(Request.ApplicationPath + path1, true);
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
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
            btnSave.Visible = true;
            btnSave.Enabled = true;
        }
        //}
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        string str = Request.RawUrl;
        string u = Request.UrlReferrer.ToString();
        string u1 = Request.ServerVariables["HTTP_REFERER"].ToString();
        URL = ViewState["Url"].ToString() + "&EditMode=Y&EtskID=" + taskID;
        string redirectURL = Request.ApplicationPath + Request.Url.PathAndQuery.ToString();
        Response.Redirect(URL, true);
    }
}
