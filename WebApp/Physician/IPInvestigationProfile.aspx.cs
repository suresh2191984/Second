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

public partial class Physician_IPInvestigationProfile : BasePage
{
    long patientVisitId = 0;    
    int complaintId = 0;
    long taksId = 0;
    long patientId = 0;
    public string patientName = string.Empty;
    string vType = string.Empty;
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();

    IP_BL ipBL;


    protected void Page_Load(object sender, EventArgs e)
    {
        //btnSave.Attributes.Add("onClick", "return ValidateInv()");
        ipBL = new IP_BL(base.ContextInfo);
        if (Request.QueryString["vid"] != null)
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitId);
                // Int32.TryParse(Request.QueryString["tid"], out taksId);
                Int64.TryParse(Request.QueryString["pid"], out patientId);
                PatientHeader1.ShowVitals = false;
                PatientHeader1.PatientVisitID = patientVisitId;
                if (!IsPostBack)
                {
                    //Load Data's to investigation Control
                    List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                    new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), out lstgroups, out lstInvestigations);
                    int orgBased = 0;
                    InvestigationControl1.OrgSpecific = orgBased;
                    InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
                    if (patientVisitId != 0)
                    {
                        //Load Data's for Particular visit in Investigation Control
                        //List<PatientInvestigation> lstPatientInves = new List<PatientInvestigation>();
                        //new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, patientVisitId, out lstPatientInves);
                        List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> oInvestigations = new List<OrderedInvestigations>();
                        if (RoleName == RoleHelper.Physician)
                            new Investigation_BL(base.ContextInfo).GetOrderedInvForPhysician(OrgID, patientVisitId, out lstOrderedInves);
                        else
                            new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, patientVisitId, out lstOrderedInves, out oInvestigations);

                        if (lstOrderedInves.Count > 0)
                        {
                            InvestigationControl1.loadOrderedList(lstOrderedInves);
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error on Investigation PageLoad", ex);
            }
        }
        }
    protected void btnDueChart_Click(object sender, EventArgs e)
    {
        lstPatientInvestigation = InvestigationControl1.GetOrderedList();

        long returnCode = -1;
        long returnCodeINV = -1;
        long createTaskID = -1;
      
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation inves in lstPatientInvestigation)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = inves.InvestigationID;
                objInvest.InvestigationName = inves.InvestigationName;
                objInvest.PatientVisitID = patientVisitId;
                objInvest.GroupID = inves.GroupID;
                objInvest.GroupName = inves.GroupName;
                objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objInvest.Status = "Paid";
                objInvest.CreatedBy = LID;
                objInvest.ComplaintId = complaintId;
                objInvest.Type = inves.Type;
                orderedInves.Add(objInvest);
            }
        }
        int pOrderedInvCnt = 0;
        returnCodeINV = new Investigation_BL(base.ContextInfo).SaveInPatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
        if (pOrderedInvCnt > 0)
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitId, 0,
                patientId, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = patientVisitId;
            task.PatientID = patientId;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            //Create task               
            returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
            string InterimBillNo = string.Empty;
            ipBL.InsertIPOrderedInv(lstPatientInvestigation, patientVisitId, LID, patientId,out InterimBillNo);
            if (createTaskID == -1 || createTaskID > 0)
            {
                try
                {
                    Navigation navigation = new Navigation();
                    Role role = new Role();
                    role.RoleID = RoleID;
                    List<Role> userRoles = new List<Role>();
                    userRoles.Add(role);
                    string relPagePath = string.Empty;
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
        }
    }
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        try
        {
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;
            long taskID = -1;

            vType = Request.QueryString["vType"];

            List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
            lstPatientInvest = InvestigationControl1.GetOrderedList();
            List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();

            if (lstPatientInvest.Count > 0)
            {
                foreach (PatientInvestigation inves in lstPatientInvest)
                {
                    PatientInvestigation objInvest = new PatientInvestigation();
                    objInvest.InvestigationID = inves.InvestigationID;
                    objInvest.InvestigationName = inves.InvestigationName;
                    objInvest.PatientVisitID = patientVisitId;
                    objInvest.GroupID = inves.GroupID;
                    objInvest.GroupName = inves.GroupName;
                    objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInves.Add(objInvest);
                }
            }


            long result = 0;
            int pOrderedInvCnt = 0;
            //for(int i=0;i<lstPatientInvestigation.Count;i++)
            //{
            //    lstPatientInvestigation[i].CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone) ;
            //    lstPatientInvestigation[i].CreatedBy = LID;
            //    lstPatientInvestigation[i].PatientVisitID = Convert.ToInt64(patientVisitId);
            //}
            
            //Venkat Changes(GUID)
            returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(orderedInves, OrgID,"", out pOrderedInvCnt);

            //investigBL.SavePatientInvestigation(lstPatientInvestigation, Convert.ToInt64(OrgID));
            //(lstPatientInvestnigation, Convert.ToInt64(patientVisitId), Convert.ToInt64(OrgID));

            if (result == 0)
            {
                if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    Int64.TryParse(Request.QueryString["tid"], out taksId);

                    returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

                    Int64.TryParse(Request.QueryString["pid"].ToString(), out patientId);

                    if (pOrderedInvCnt > 0)
                    {
                        //Create task for Collect investigation payment
                        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
                        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
                            patientId, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitId;
                        task.PatientID = patientId;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        //create task
                        returnCode = taskBL.CreateTask(task, out taskID);
                        //string redirectURL = @"..\Billing\InvestigationPayment.aspx?vid=" + patientVisitId + "&tid=" + taskID + "&vType=" + "IP" + "&pid=" + patientId + "&ptid=0&ftype=INV";
                        //Response.Redirect(redirectURL, true);

                        if (vType == "IP")
                        {
                            Response.Redirect("../Nurse/Home.aspx", true);
                        }

                    }                   

                }
              
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while saving investigation profile";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while saving investigation profile";
            CLogger.LogError("Error while saving Investigation Profile", ex);

        }
    }
}

