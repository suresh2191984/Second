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


public partial class Investigation_InvestigationProfile : BasePage
{
    public Investigation_InvestigationProfile()
        : base("Investigation\\InvestigationProfile.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long patientVisitId = 0;
    long previousVisitId = 0;
    long complaintId = 0;
    long taksId = 0;
    long patientId = 0;
    string PaymentLogic = String.Empty;
    string URL = string.Empty; 
                        
    public string patientName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnSave.Attributes.Add("onClick", "return ValidateInv()");

        if (Request.QueryString["vid"] != null)
        {
            try
            {
                patientVisitId = Convert.ToInt64(Request.QueryString["vid"]);
                PatientHeader1.ShowVitals = false;
                PatientHeader1.PatientVisitID = patientVisitId;
                if (PaymentLogic == String.Empty)
                {
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails("INV", OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        PaymentLogic = lstConfig[0].ConfigValue.Trim();
                }
                if (PaymentLogic.ToLower() == "before")
                {
                    rdoPayNow.Checked = true;
                }
                else
                {
                    rdoPayLater.Checked = true;
                }


                List<VisitClientMapping> lPatientVisit = new List<VisitClientMapping> ();
                int clientID = 0;
                new PatientVisit_BL(base.ContextInfo).GetVisitClientMappingDetails(OrgID,patientVisitId, out lPatientVisit);
                if (lPatientVisit.Count > 0)
                {
                    clientID = (int)lPatientVisit[0].RateID;
                }
                //Load Data  to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), 0, clientID, out lstgroups, out lstInvestigations);
                int orgBased = OrgID;
                InvestigationControl1.OrgSpecific = orgBased;
                InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);                
                if (!IsPostBack)
                {
                    ViewState["URL"] = Request.UrlReferrer.ToString();
                    if (patientVisitId != 0)
                    {
                        //Load Data's for Particular visit in Investigation Control
                        //List<PatientInvestigation> lstPatientInves = new List<PatientInvestigation>();
                        List<OrderedInvestigations> lstOrderedInves = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> oInvestigations = new List<OrderedInvestigations>();
                        if (RoleName == RoleHelper.Physician)
                            new Investigation_BL(base.ContextInfo).GetOrderedInvForPhysician(OrgID, patientVisitId, out lstOrderedInves);
                        else
                            new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, patientVisitId, out lstOrderedInves, out oInvestigations);

                        //new Investigation_BL(base.ContextInfo).GetOrderedInvestigation(OrgID, patientVisitId, out lstPatientInves);
                        if (oInvestigations.Count > 0)
                        {
                            //InvestigationControl1.loadOrderedList(lstOrderedInves);
                            InvestigationControl1.loadOrderedList(oInvestigations);
                        }
                    }
                    if (RoleName == RoleHelper.Physician)
                    {
                        rdoPayNow.Visible = false;
                        rdoPayLater.Visible = false;
                    }
                }
                #region Inv-Schedule
                patientVisitId = Convert.ToInt64(Request.QueryString["vid"]);
                if (Request.QueryString["pid"] != null)
                {
                    long returnCode;
                    GateWay gateWay = new GateWay(base.ContextInfo);
                    List<Config> lstConfig = new List<Config>();
                    returnCode = gateWay.GetConfigDetails("IsScheduleForInv", OrgID, out lstConfig);
                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        Int64.TryParse(Request.QueryString["pid"].ToString(), out patientId);
                        string sPage = string.Empty;

                        sPage = "../Admin/DoctorSchedule.aspx?Pid=" + patientId.ToString()
                         + "&Pvid=" + patientVisitId.ToString() + "&IsInvSched=Y";
                        //hdnsPage.Value = sPage;
                        InvestigationControl1.LoadScheduleControl(sPage);
                    }

                }
                #endregion
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error on Investigation PageLoad", ex);
            }
        }
    }
   
    protected void btnSave_Click(object sender, EventArgs e)
    {

        try
        {
            //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();//HL
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;
            long taskID = -1;

            //List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
            List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>(); //HL
            //lstPatientInvest = InvestigationControl1.GetOrderedList();
            lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB(); //HL
            //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
            List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>(); //HL
            //if (lstPatientInvest.Count > 0)
            //{
            //    foreach (PatientInvestigation inves in lstPatientInvest)
            //    {
            //        PatientInvestigation objInvest = new PatientInvestigation();
            //        objInvest.InvestigationID = inves.InvestigationID;
            //        objInvest.InvestigationName = inves.InvestigationName;
            //        objInvest.PatientVisitID = patientVisitId;
            //        objInvest.GroupID = inves.GroupID;
            //        objInvest.GroupName = inves.GroupName;
            //        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            //        objInvest.Status = "Ordered";
            //        objInvest.CreatedBy = LID;                    
            //        objInvest.Type = inves.Type;
            //        orderedInves.Add(objInvest);
            //    }
            //}
            // HL Starts
            string labno = "";
            if (lstPatientInvestHL.Count > 0)
            {
                foreach (OrderedInvestigations inves in lstPatientInvestHL)
                {
                    OrderedInvestigations objInvest = new OrderedInvestigations();
                    objInvest.ID = inves.ID;
                    objInvest.Name = inves.Name;
                    objInvest.VisitID = patientVisitId;
                    objInvest.OrgID = OrgID;
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInvesHL.Add(objInvest);
                }
                returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, orderedInvesHL, out labno);
            }
            // HL Ends
            long result = 0;
            int pOrderedInvCnt = 0;
            string paymentstatus = "Pending";
            if (rdoPayNow.Checked == true)
            {
                paymentstatus = "Paid";
            }
            string GUID = Guid.NewGuid().ToString();
            //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(orderedInvesHL, OrgID, out pOrderedInvCnt, paymentstatus, GUID,labno);
            if (result == 0)
            {
                if (Request.QueryString["pvid"]== null && Request.QueryString["id"]== null)
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    Int64.TryParse(Request.QueryString["tid"], out taksId);

                    returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

                    Int64.TryParse(Request.QueryString["pid"].ToString(), out patientId);
                    if (Request.QueryString["EditMode"] == "Y")
                    {
                        if(ViewState["URL"] != null)
                        {
                            URL = ViewState["URL"].ToString();
                            Response.Redirect(URL, true);
                        }                        
                    }
                    else
                    {
                        if (pOrderedInvCnt > 0)
                        {
                            //Create task for Collect investigation payment
                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();


                            if (PaymentLogic == String.Empty)
                            {
                                List<Config> lstConfig = new List<Config>();
                                new GateWay(base.ContextInfo).GetConfigDetails("INV", OrgID, out lstConfig);
                                if (lstConfig.Count > 0)
                                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
                            }

                            if (PaymentLogic.ToUpper() == "AFTER")
                            {

                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
                                    patientId, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, GUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = patientVisitId;
                                task.PatientID = patientId;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                task.RefernceID = labno.ToString();
                                //create task
                                returnCode = taskBL.CreateTask(task, out taskID);
                                if (RoleName == RoleHelper.Physician)
                                {
                                    List<Role> lstUserRole1 = new List<Role>();
                                    string path1 = string.Empty;
                                    Role role1 = new Role();
                                    role1.RoleID = RoleID;
                                    lstUserRole1.Add(role1);
                                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                                    Response.Redirect(Request.ApplicationPath + path1, false);
                                }
                                else
                                {
                                    string redirectURL = @"..\Billing\InvestigationPayment.aspx?vid=" + patientVisitId + "&tid=" + taskID + "&LabNo=" + labno + "&pid=" + patientId + "&ptid=0&ftype=INV&Show=Y&gUID=" + GUID;
                                    Response.Redirect(redirectURL, true);
                                }
                            }
                            else
                            {
                                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
                                string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), patientVisitId, 0,
                                    patientId, lstPatientVisitDetails[0].TitleName + " " + patientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,GUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = patientVisitId;
                                task.PatientID = patientId;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                task.RefernceID = labno.ToString();
                                //Create task               
                                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out taskID);
                                Response.Redirect("~/Reception/Home.aspx", true);
                            }
                        }
                        else
                        {
                            Response.Redirect("~/Reception/Home.aspx", true);
                        }
                    }
                    
                }
                else if (Request.QueryString["pvid"].ToString() != "0")
                {
                    Int64.TryParse(Request.QueryString["pvid"], out previousVisitId);
                    Response.Redirect("~/Physician/PatientDiagnose.aspx?pvid=" + previousVisitId + "&vid=" + patientVisitId);
                }
                else
                {
                    Int64.TryParse(Request.QueryString["id"], out complaintId);
                    Response.Redirect("~/Physician/PatientDiagnose.aspx?id=" + complaintId + "&vid=" + patientVisitId);
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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["pvid"]!= null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out previousVisitId);
            Response.Redirect("~/Physician/PatientDiagnose.aspx?pvid=" + previousVisitId + "&vid=" + patientVisitId);
        }
        else if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
        {
            Response.Redirect("~/Reception/Home.aspx");
        }
        else
        {
            Int64.TryParse(Request.QueryString["id"], out complaintId);
            Response.Redirect("~/Physician/PatientDiagnose.aspx?id=" + complaintId + "&vid=" + patientVisitId);
        }
    }

    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
}
