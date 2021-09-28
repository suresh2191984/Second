using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using System.IO;

public partial class Billing_AmountApprovalDetails : BasePage
{
    long taskID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadAmountApprovalDetails();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in RateType Page Loading", ex);
        }

    }
    public void LoadAmountApprovalDetails()
    {
        try
        {
            long returnCode = -1;
            List<AmountApprovalDetails> lstAmountApprovalDetails = new List<AmountApprovalDetails>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            long AmountApprovalDetailsID = 0;
            Int64.TryParse(Request.QueryString["AAD"], out AmountApprovalDetailsID);
            returnCode = patientBL.GetAmountApprovalDetails(AmountApprovalDetailsID, OrgID, out lstAmountApprovalDetails);
            if (lstAmountApprovalDetails.Count > 0)
            {  
                string str = lstAmountApprovalDetails[0].PatientName + "~"
                    + lstAmountApprovalDetails[0].Age + "~"
                    + lstAmountApprovalDetails[0].VisitPurpose + "~"
                    + lstAmountApprovalDetails[0].ApprovalType + "~"
                    + lstAmountApprovalDetails[0].ApprovalStatus + "~"
                    + lstAmountApprovalDetails[0].PaymentCardNo + "~"
                    + lstAmountApprovalDetails[0].ChequeValidDate + "~"
                    + lstAmountApprovalDetails[0].BankName + "~"
                    + lstAmountApprovalDetails[0].PaymentAmount + "~"
                    + lstAmountApprovalDetails[0].Discount + "~"
                     + lstAmountApprovalDetails[0].NetAmount + "~"
                    + lstAmountApprovalDetails[0].Comments + "~"
                    + lstAmountApprovalDetails[0].UserName + "~"
                    + lstAmountApprovalDetails[0].CreatedAt;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:AssignApprovalDetails('" + str + "');", true);
                DataSet ds = new DataSet();
                StringReader stream = new StringReader(lstAmountApprovalDetails[0].FeeDescription);
                ds.ReadXml(stream);
                gvFeeDetails.DataSource = ds;
                gvFeeDetails.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Item Rate", ex);
        }
    }
    protected void btnAmountApprovalDetailsOk_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long AmountApprovalID = 0;
            string RefType;
            string comments;
            string ApprovalStatus;
            string GetStatus;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            //long AmountApprovalDetailsID = 0; 
            //AmountApprovalID = AmountApprovalDetailsID;
            Int64.TryParse(Request.QueryString["AAD"].ToString(), out AmountApprovalID);
            RefType = "UPDATE";
            comments = txtComments.Text == "" ? string.Empty : txtComments.Text;
            ApprovalStatus = "Approved";
            returnCode = patientBL.GetUpdateAmountApprovalDetails(AmountApprovalID, RefType, comments, ApprovalStatus, OrgID, out  GetStatus);
            if (returnCode == 1)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Approved Success');", true);
                Response.Redirect("../Admin/Home.aspx"); 
            } 
        }
        catch (Exception EX)
        {
            CLogger.LogError("Error in GetUpdateAmountApprovalDetails", EX);

        }
    }
    protected void btnAmountApprovalDetailsCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long AmountApprovalID = 0;
            string RefType;
            string comments;
            string ApprovalStatus;
            int OrgId;
            string GetStatus;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            // long AmountApprovalDetailsID = 0;
            //AmountApprovalID = AmountApprovalDetailsID;
            Int64.TryParse(Request.QueryString["AAD"].ToString(), out AmountApprovalID);
            RefType = "UPDATE";
            comments = txtComments.Text;
            ApprovalStatus = "Rejected";
            OrgId = OrgID;
            returnCode = patientBL.GetUpdateAmountApprovalDetails(AmountApprovalID, RefType, comments, ApprovalStatus, OrgId, out  GetStatus);
            if (returnCode == 1)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('ApprovalDeatails Rejected');", true);
                Response.Redirect("../Admin/Home.aspx"); 
            }

        }
        catch (Exception EX)
        {
            CLogger.LogError("Error in GetUpdateAmountApprovalDetails", EX);

        }
    }
}