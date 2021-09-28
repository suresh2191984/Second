using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;

public partial class Corporate_CancelledServices : BasePage
{
    long returnCode = -1;
    long patientID = -1;
    long vid = 0;
    long taskid = -1;
    decimal refundAmount = 0;
    decimal amtReceived = 0;
    decimal amtRefunded = 0;
    decimal dChequeAmount = 0;
    string sPatientName = "";
    long PatientNumber = 0;
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();
    List<TaskDetails> lstTaskDetails = new List<TaskDetails>();
    BillingEngine billingBL ;
    FinalBill fBill = new FinalBill();
    Master_BL masterBL;
    Role_BL rolebl;
    int purpID = 0;
    long phyID = -1;
    int otherID = 0;
    long BillID = 0;
    long billno = 0;
    string feeType = string.Empty;
    int BaseCurrencyID = -1;
    string gUID = string.Empty;
    string ReceiptNo = string.Empty;
    int returnstatus = -1;
    string RefundNo = string.Empty;
    int RefundStatus = 2;
    protected void Page_Load(object sender, EventArgs e)
    {
        rolebl = new Role_BL(base.ContextInfo);
        masterBL = new Master_BL(base.ContextInfo);
        billingBL = new BillingEngine(base.ContextInfo);
        long billingDetailsID = 0;
        Int64.TryParse(Request.QueryString["vid"], out vid);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["bid"], out BillID);
        Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        Int64.TryParse(Request.QueryString["billno"], out billno);
        sPatientName = Request.QueryString["pname"];
        Int64.TryParse(Request.QueryString["pNumber"], out PatientNumber);
        if (!IsPostBack)
        {
            lblServiceNo.Text = billno.ToString();
            lblEmpName.Text = sPatientName;
            TaskDetailsForPatient();
            billingBL.pGetCorporateRefundBillingDetails(vid, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, BillID, billingDetailsID);
            if (lstBillingDetails.Count > 0)
            {
                grdRefund.DataSource = lstBillingDetails;
                grdRefund.DataBind();
            }
            List<PatientVisit> visitList = new List<PatientVisit>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            long returnCode = -1;
            returnCode = patientBL.GetLabVisitDetails(vid, OrgID, out visitList);
            if (visitList.Count > 0)
            {
                lblPNo.Text = Convert.ToString(visitList[0].PatientNumber);
                lblName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;

                if (visitList[0].Sex == "M")
                {
                    lblSex.Text = "[Male]";
                }
                else
                {
                    lblSex.Text = "[Female]";
                }
                lblAge.Text = visitList[0].PatientAge.ToString();
                lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy"));
            }
        }
    }
    protected void grdRefund_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            BillingDetails t = (BillingDetails)e.Row.DataItem;
            e.Row.Cells[8].Style.Add("display", "None");
            if (t.ReferenceType == "Closed")
            {
                e.Row.Cells[0].Enabled = false;
                e.Row.Cells[7].Enabled = false;
            }
            else
            {
                e.Row.Cells[0].Enabled = true;
                e.Row.Cells[7].Enabled = true;
            }
            string[] TaskIdandParentId = hdnCon.Value.Split('^');
            for (int i = 0; i < TaskIdandParentId.Count() - 1; i++)
            {
                string[] TaskIdandParentId1 = TaskIdandParentId[i].Split('~');
                if (Convert.ToInt64(TaskIdandParentId1[0].ToString()) == t.TaskID)
                {
                    if (Convert.ToInt64(TaskIdandParentId1[2].ToString()) == 5)
                    {
                        e.Row.Cells[7].Text = "Task Picked";
                        e.Row.Cells[0].Enabled = false;
                    }
                    if (Convert.ToInt64(TaskIdandParentId1[2].ToString()) == 2)
                    {
                        e.Row.Cells[7].Text = "Task Finish";
                        e.Row.Cells[0].Enabled = false;
                    }
                }
            }
            
        }
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[8].Style.Add("display", "None");
        }
       
    }
    public void CancelledService()
    {
        AmountRefundDetails ARD = new AmountRefundDetails();
        int flag = 0;
        string des = "";
        btnSubmit.Enabled = false;
        long returncode = -1;
       
        long billingDetailsID = 0; Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        if (btnSubmit.Text == "Cancel Service")
        {
            //decimal amtrecvd = Convert.ToDecimal(lblTotAmtReceived.Text);
            // decimal amtrfd = Convert.ToDecimal(lblTotAmtRefunded.Text);
            foreach (GridViewRow gR in grdRefund.Rows)
            {
                if (((CheckBox)gR.FindControl("chkRefund")).Checked == true)
                {
                    Label lblFeetype = (Label)gR.FindControl("lblFeeType");
                    Label lbBillDetailID = (Label)gR.FindControl("lblBillDetailsID");
                    Label lbFinalBillID = (Label)gR.FindControl("lblFinalBillID");
                    Label lbAmount = (Label)gR.FindControl("lblAmount");
                    TextBox txtRReason = (TextBox)gR.FindControl("txtRfdReason");
                    Label lbDescription = (Label)gR.FindControl("lblDescription");
                    des = lbDescription.Text;
                    long bdid = Convert.ToInt64(lbBillDetailID.Text);
                    long fbid = Convert.ToInt64(lbFinalBillID.Text);
                    decimal totAmt = Convert.ToDecimal(lbAmount.Text);
                    string rReason = txtRReason.Text;
                    if (rReason != "")
                    {
                        refundAmount += totAmt;
                        ARD = new AmountRefundDetails();
                        ARD.FinalBillID = Convert.ToInt64(lbFinalBillID.Text);
                        ARD.BillingDetailsID = Convert.ToInt64(lbBillDetailID.Text);
                        ARD.AmtRefund = Convert.ToDecimal(lbAmount.Text == "" ? "0" : lbAmount.Text);
                        ARD.OrgID = OrgID;
                        ARD.CreatedBy = LID;
                        ARD.ReasonforRefund = txtRReason.Text;
                        ARD.RefundType = "SERVICE CANCELLED";
                        ARD.PaymentDetail = lbFinalBillID.Text;
                        lstAmountRefundDetails.Add(ARD);

                        fBill = new FinalBill();
                        fBill.AmountRefund = refundAmount;
                    }
                }
            }
            returncode = billingBL.inserCorporatetAmtRefundDetails(vid, fBill, lstAmountRefundDetails, out returnstatus, out ReceiptNo, out RefundNo, RefundStatus);
            if (returnstatus >0)
            {
                foreach (GridViewRow gR in grdRefund.Rows)
                {
                    if (((CheckBox)gR.FindControl("chkRefund")).Checked == true)
                    {
                        Label lblTaskID = (Label)gR.FindControl("lblTaskID");
                        long TkID = Convert.ToInt64(lblTaskID.Text);
                        new Tasks_BL(base.ContextInfo).UpdateTask(TkID, TaskHelper.TaskStatus.Deleted, LID);
                    }
               
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:FnIsvalid('" + returnstatus + "');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Cancel", "alert('Service has not been cancelled');", true);
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        CancelledService();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        List<Role> lstUserRole = new List<Role>();
        string path = string.Empty;
        Role role = new Role();
        role.RoleID = RoleID;
        lstUserRole.Add(role);
        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
        Response.Redirect(Request.ApplicationPath + "/Corporate/CorporateService.aspx", true);
    }
    public void TaskDetailsForPatient()
    {
        billingBL.PgetTaskDetailsforvisit(vid, OrgID, out lstTaskDetails);
        if (lstTaskDetails.Count > 0)
        {
            for (int i = 0; i < lstTaskDetails.Count; i++)
            {
                hdnCon.Value += lstTaskDetails[i].TaskID + "~" + lstTaskDetails[i].ParentID + "~" + lstTaskDetails[i].TaskStatusID + "^";
            } 
        }
        
    }
}
    

