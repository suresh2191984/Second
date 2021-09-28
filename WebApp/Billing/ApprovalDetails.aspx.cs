using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Podium.PerformingNextAction;
using System.Data;
using System.Collections;

public partial class Billing_ApprovalDetails : BasePage
{
    string PageUrl = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            LoadApprovalDetails();
            PageUrl = Request.UrlReferrer.ToString();
        }
    }

    private void LoadApprovalDetails()
    {

        List<PatientDueDetails> lstPatientDueDetails = new List<PatientDueDetails>();
        BillingEngine BE = new BillingEngine(base.ContextInfo);
        long ApprovalID = 0;
        long FinalBillID = 0;
        long PatientID = 0;
        Int64.TryParse(Request.QueryString["APID"], out ApprovalID);
        Int64.TryParse(Request.QueryString["Bid"], out FinalBillID);
        Int64.TryParse(Request.QueryString["Pid"], out PatientID);
        BE.GetDueWriteOffApprovals(ApprovalID, PatientID, FinalBillID, out lstPatientDueDetails);
        if (lstPatientDueDetails.Count > 0)
        {
            lblPatientNo.Text = lstPatientDueDetails[0].PatientNumber;
            lblName.Text = lstPatientDueDetails[0].PatientName;
            labAge.Text = lstPatientDueDetails[0].VersionNo;
            lblInvoiceNo.Text = lstPatientDueDetails[0].BillNo;
            lalBillDate.Text = lstPatientDueDetails[0].CreatedAt.ToString();
            if (lstPatientDueDetails[0].Status == "M")
            {
                lalSex.Text = "Male";
            }
            else
            {
                lalSex.Text = "FeMale";
            }
            txtWriteoffAmt.Text = lstPatientDueDetails[0].WriteOffAmt.ToString();
            hdnCreatedBy.Value = lstPatientDueDetails[0].CreatedBy.ToString();
            hdnVisitID.Value = lstPatientDueDetails[0].VisitID.ToString();
        }

    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        BillingEngine BE = new BillingEngine(base.ContextInfo);
        long ApprovalID = 0;
        long PatientID=0;
        long taskID = 0;
        Int64.TryParse(Request.QueryString["APID"], out ApprovalID);
        decimal ApprovalAmt=0;
        ApprovalAmt = Convert.ToDecimal(txtWriteoffAmt.Text);
        string ApprovalStatus = string.Empty;
        int TaskStatus = 0;
        List<Users> lstUser;
        SharedInventory_BL User;
        User = new SharedInventory_BL(base.ContextInfo);
        TaskStatus = Convert.ToInt16(TaskHelper.TaskStatus.Completed);

        if (rdoApprove.Checked==true)
        {
            ApprovalStatus = "Approved";
        }
        else
        {
            ApprovalStatus = "Rejected";
        }
       BE.UpdateDueWriteOffApprovals(ApprovalID, ApprovalAmt, OrgID, ApprovalStatus);
        Int64.TryParse(Request.QueryString["Pid"], out PatientID);
        long VisitID=0;
        VisitID=Convert.ToInt32(hdnVisitID.Value);

        if (Request.QueryString["tid"] != null)
        {
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
        }
        CreateTask(PatientID, VisitID, lblName.Text, lblInvoiceNo.Text, lblPatientNo.Text, "", ApprovalID);
        User.GetUserDetail(Convert.ToInt32(hdnCreatedBy.Value), out lstUser);
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "TaskCreate", " AlertMsg('" + lstUser[0].Name + "');", true);

    }
    protected void CreateTask(long PatientID, long VisitID, string sPatientName, string BillNo, string PatientNumber, string FeeType, long WriteOffAppID)
    {
        try
        {


            long AssingTo = -1;
            long taskID;
            long returnCode = 0;
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long TaskActionID = -1;

            TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.DueWriteOffApproval);
            returnCode = Utilities.GetHashTableWriteOffDDueAmt(TaskActionID, VisitID, PatientID, sPatientName, FeeType, out dText, out urlVal, BillNo, PatientNumber);
            task.TaskActionID = Convert.ToInt32(TaskActionID);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            urlVal.Add("ApprovalID", WriteOffAppID);
            task.PatientID = PatientID;
            AssingTo = 1856;//Convert.ToInt32(hdnCreatedBy.Value);
            task.RoleID = AssingTo;
            task.OrgID = OrgID;
            task.PatientVisitID = VisitID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            Tasks_BL taskBL = new Tasks_BL();
            returnCode = taskBL.CreateTask(task, out taskID);
        }
        catch (Exception ex)
        {

        }
    }
}
