using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using System.Data;

public partial class Billing_PerformRefund : BasePage
{
    long returnCode = -1;
    long vid = 0;
    long taskID = -1;
    decimal total = 0.00M;
    string RefundNo = string.Empty;
    string RequestType = string.Empty;
    long patientID = -1;
    string sPatientName = "";
    long ptaskID = -1;
    string BillNo = string.Empty;
    string RefundStatus = string.Empty;
    string ApprovedBy = string.Empty;
    string path = string.Empty;
    string Reftypes = "REF";
    string billno = string.Empty;
    string RefFlag = "Y";
    string PatientNumber = "";
    string pathname = String.Empty;
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    SharedInventory_BL INVUser;
    List<Users> lstUser;
    Master_BL objReasonMaster;
    List<ReasonMaster> lstReasonMaster;
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
    List<CurrencyOrgMapping> lstCurrOrgMap = new List<CurrencyOrgMapping>();
    protected void Page_Load(object sender, EventArgs e)
    {
        INVUser = new SharedInventory_BL(base.ContextInfo);
        taskBL = new Tasks_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out vid);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        RefundNo = Request.QueryString["rno"];
        RequestType = Request.QueryString["ftype"];
        ApprovedBy = Request.QueryString["CreatedBy"];
        rblAcc.Attributes.Add("onclick", "Reject()");
        if (Request.QueryString["RefFlag"] != null)
        {
            RefFlag = Request.QueryString["RefFlag"];
        }
        rblPaymode.Attributes.Add("onclick", "Paymentchanged()");
        AutoCompleteExtender2.ContextKey = "0" + "~" + "Bank";
        if (RequestType != null)
        {
            if (RequestType.Trim() == "APR")
            {
                Panel2.Visible = false;
                Panel3.Visible = false;
                Panel4.Visible = true;
                pnlAssign.Visible = true;
            }
        }
        if (!IsPostBack)
        {
            loadTaskDetails();
            LoadCurrency();
            btnOk.Visible = true;
        }
    }

    public void loadTaskDetails()
    {
        try
        {
            List<FinalBill> lstFinalBill = new List<FinalBill>();
            lstReasonMaster = new List<ReasonMaster>();
            objReasonMaster = new Master_BL(base.ContextInfo);
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);
            billingBL.GetRefundDetailForTask(OrgID, RefundNo, vid, out lstBillingDetails, out lstFinalBill);
            string Donotshowpaymentmode = String.Empty;
            Donotshowpaymentmode = GetConfigValue("ShowpaymentmodeforCreditController", OrgID);
            if (lstFinalBill.Count > 0)
            {
                if (lstBillingDetails[0].ItemType == "CANCELLED")
                {
                    hdnCancelBill.Value = "Y";
                    if (RefFlag == "Y")
                    {
                        if (Donotshowpaymentmode == Convert.ToInt32(RoleID).ToString())
                        {
                            pnlAssign.Style.Add("display", "block");
                        }
                        else
                        {
                            pnlAssign.Style.Add("display", "none");
                        }
                    }
                }
                lblPatientNo.Text = lstFinalBill[0].PatientNo;
                lblName.Text = lstFinalBill[0].Name;
                labAge.Text = lstFinalBill[0].PatientAge;
                lalSex.Text = lstFinalBill[0].Comments;
                lblInvoiceNo.Text = lstFinalBill[0].BillNumber;
                lalBillDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yyyy");
                lalBilledBy.Text = lstFinalBill[0].BilledBy;
                lblTotAmtReceived.Text = lstFinalBill[0].AmountReceived.ToString("0.00");
                lblTotAmtRefunded.Text = lstFinalBill[0].AmountRefund.ToString();
                lblRefundableAmt.Text = lstFinalBill[0].NetValue.ToString();
                lbltxtDueAmt.Text = lstFinalBill[0].Due.ToString();
                hdnPatientNo.Value = lstPatientVisitDetails[0].PatientNumber;
                total = lstBillingDetails.Sum(p => Convert.ToInt32(p.RefundedAmt));
                lblCurrChange.Text = total.ToString("0.00");
                if (lstBillingDetails.Count > 0)
                {
                    hdnFinalBillId.Value = lstBillingDetails[0].FinalBillID.ToString();
                    grdResult.DataSource = lstBillingDetails;
                    grdResult.DataBind();
                }
            }

            if (lstBillingDetails[0].Performertype == "Rejected")
            {
                long CreateBy = Convert.ToInt64(ApprovedBy);
                lstUser = new List<Users>();
                INVUser.GetUserDetail(CreateBy, out lstUser);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "TaskReject", "alert('Task Rejected by '+'" + lstUser[0].Name + "');", true);
                if (Request.QueryString["tid"] != null)
                {
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
                Panel4.Visible = false;
                btnCancel1.Visible = true;
            }
        }
        catch (Exception ex)
        {
        }
    }

    public void homepage()
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();

            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
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
            DataTable dtSaveApprovedAmt = new DataTable();
            AmountRefundDetails AmtRfnDetails;
            List<AmountRefundDetails> lstApprovedRefund = new List<AmountRefundDetails>();
            RefundStatus = "APPROVED";
            if (rblAcc.SelectedItem.Text != "Approve")
            {
                RefundStatus = "REJECTED";
            }
            else if (RequestType == "CAL")
            {
                RefundStatus = "CANCELLED";
            }
            foreach (GridViewRow grdRef in grdResult.Rows)
            {
                AmtRfnDetails = new AmountRefundDetails();
                TextBox txtApprovedAmt = (TextBox)grdRef.FindControl("TxtRfdAmt");
                string BillingDetID = grdResult.DataKeys[grdRef.RowIndex].Values["BillingDetailsID"].ToString();
                DropDownList ddlType = (DropDownList)grdRef.FindControl("ddlType");
                AmtRfnDetails.BillingDetailsID = Convert.ToInt64(BillingDetID);
                AmtRfnDetails.AmtRefund = Convert.ToDecimal(txtApprovedAmt.Text);
                //AmtRfnDetails.AmtRefund = hdnCancelBill.Value == "Y" ? decimal.Parse("0") : Convert.ToDecimal(txtApprovedAmt.Text);
                AmtRfnDetails.FinalBillID = Convert.ToInt64(hdnFinalBillId.Value);
                AmtRfnDetails.RefundStatus = RefundStatus == "APPROVED" ? "Task" : "Closed";
                AmtRfnDetails.OrgID = OrgID;
                AmtRfnDetails.CreatedBy = LID;
                AmtRfnDetails.RefundType = hdnCancelBill.Value == "N" ? "REFUND" : "CANCEL";
                AmtRfnDetails.Comments = "";
                AmtRfnDetails.ApprovedBy = Int64.Parse(ApprovedBy);
                AmtRfnDetails.AuthorisedBy = Int32.Parse(ApprovedBy);
                AmtRfnDetails.ReasonforRefund = ddlType.SelectedIndex != -1 ? ddlType.SelectedItem.Text : "";
                if (rblPaymode.SelectedItem.Text == "Cash")
                {
                    AmtRfnDetails.PaymentTypeID = 1;
                }
                else if (rblPaymode.SelectedItem.Text == "Credit Card")
                {
                    AmtRfnDetails.PaymentTypeID = 2;
                    if (txtNumber.Text != "")
                    {
                        AmtRfnDetails.ChequeNo = Convert.ToInt64(txtNumber.Text);
                    }
                    else
                    {
                        AmtRfnDetails.ChequeNo = 0;
                    }
                    AmtRfnDetails.BankName = txtBankType.Text;
                    AmtRfnDetails.Remarks = txtRemarks.Text;
                }
                lstApprovedRefund.Add(AmtRfnDetails);
            }


            if (lstApprovedRefund.Count > 0)
            {
                dtSaveApprovedAmt = ConvertToListTable(lstApprovedRefund);
            }
            returnCode = new BillingEngine(base.ContextInfo).UpdateRefundDetails(OrgID, RefFlag, RefundNo, LID, RefundStatus, LID, txtReject.Text, dtSaveApprovedAmt);
            if (returnCode == 0)
            {
                if (Request.QueryString["tid"] != null)
                {
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                }
                CreateTask();
                btnOk.Enabled = false;
                tdApprove.Style.Add("display", "none");
                btnOk.Visible = false;

                if (RefundStatus == "APPROVED" || RefundStatus == "CANCELLED")
                {
                    hdnOldValues.Value = "";// Request.QueryString["hdn"]; 
                    pathname = "../Billing/HospitalBillSearch.aspx?btype=return&hdnold=" + hdnOldValues.Value;
                    hdnOldValues.Value = pathname;
                    PatientNumber = hdnPatientNo.Value;
                    billno = lblInvoiceNo.Text;
                    string bType = "REF";
                    string BID = "";
                    string strCancelBillingItem = Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_01 == null ? "Cancel BillItems  successfully" : Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_01;
                    string strAlert = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert;

                    ScriptManager.RegisterStartupScript(Page, GetType(), "Refund", "javascript:ValidationWindowCustom('" + strCancelBillingItem.Trim() + "','" + strAlert + "','" + billno.ToString() + "','" + lblCurrChange.Text + "','" + lblName.Text.ToString() + "','" + PatientNumber.ToString() + "','" + lblCurrChange.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "','" + bType + "','" + BID.ToString() + "','" + Convert.ToString(hdnOldValues.Value) + "');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Error in Updation!');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Billing_PerformRefund\\btnOk_Click()", ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        homepage();
    }

    protected void btnCancelRefund_Click(object sender, EventArgs e)
    {
        path = "/Reception/LabReceptionHome.aspx";
        Response.Redirect(Request.ApplicationPath + path, true);
    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlType = (DropDownList)e.Row.FindControl("ddlType");
            if (lstReasonMaster.Count > 0)
            {
                ddlType.DataSource = lstReasonMaster;
                ddlType.DataTextField = "Reason";
                ddlType.DataValueField = "Reason";
                ddlType.DataBind();

                int index = e.Row.RowIndex;
                var GetSelectedItem = lstBillingDetails[index].ReasonforRefund;
                if (!string.IsNullOrEmpty(GetSelectedItem))
                {
                    ddlType.SelectedItem.Text = GetSelectedItem;
                }
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow && hdnCancelBill.Value == "N")
        {
            TextBox txtApprovedAmt = (TextBox)e.Row.FindControl("TxtRfdAmt");
            if (RequestType != null)
            {
                if (RequestType.Trim() == "APR")
                {
                    txtApprovedAmt.Enabled = false;
                }
            }
        }
        else if (hdnCancelBill.Value == "Y")
        {
            e.Row.Cells[2].Style.Add("display", "none");
            e.Row.Cells[3].Style.Add("display", "none");
        }

    }

    private DataTable ConvertToListTable(List<AmountRefundDetails> lstApproved)
    {
        DataTable dtItemsBasket = new DataTable();

        try
        {
            dtItemsBasket.Columns.Add("FinalBillID");
            dtItemsBasket.Columns.Add("BillingDetailsID");
            dtItemsBasket.Columns.Add("AmtRefund");
            dtItemsBasket.Columns.Add("RefundBy");
            dtItemsBasket.Columns.Add("RefundStatus");
            dtItemsBasket.Columns.Add("OrgID");
            dtItemsBasket.Columns.Add("CreatedBy");
            dtItemsBasket.Columns.Add("ReasonforRefund");
            dtItemsBasket.Columns.Add("Quantity");
            dtItemsBasket.Columns.Add("RefundType");
            dtItemsBasket.Columns.Add("ApprovedBy");
            dtItemsBasket.Columns.Add("TranCurrencyID");
            dtItemsBasket.Columns.Add("BaseCurrencyID");
            dtItemsBasket.Columns.Add("TranCurrencyAmount");
            dtItemsBasket.Columns.Add("PaymentTypeID");
            dtItemsBasket.Columns.Add("PaymentDetail");
            dtItemsBasket.Columns.Add("ChequeNo");
            dtItemsBasket.Columns.Add("BankName");
            dtItemsBasket.Columns.Add("Remarks");
            dtItemsBasket.Columns.Add("AuthorisedBy");
            dtItemsBasket.Columns.Add("ServiceType");
            dtItemsBasket.Columns.Add("Comments");
            dtItemsBasket.Columns.Add("CancelAmount");
            System.Data.DataRow dr;
            foreach (AmountRefundDetails Item in lstApproved)
            {
                dr = dtItemsBasket.NewRow();
                dr["FinalBillID"] = Item.FinalBillID;
                dr["BillingDetailsID"] = Item.BillingDetailsID;
                dr["AmtRefund"] = Item.AmtRefund;
                dr["RefundBy"] = Item.CreatedBy;
                dr["RefundStatus"] = Item.RefundStatus;
                dr["OrgID"] = Item.OrgID;
                dr["CreatedBy"] = Item.CreatedBy;
                dr["ReasonforRefund"] = Item.ReasonforRefund;
                dr["Quantity"] = 0;
                dr["RefundType"] = Item.RefundType;
                dr["ApprovedBy"] = Item.ApprovedBy;
                dr["TranCurrencyID"] = 0;
                dr["BaseCurrencyID"] = 0;
                dr["TranCurrencyAmount"] = 0;
                dr["PaymentTypeID"] = Item.PaymentTypeID;
                dr["PaymentDetail"] = "";
                dr["ChequeNo"] = Item.ChequeNo;
                dr["BankName"] = Item.BankName;
                dr["Remarks"] = Item.Remarks;
                dr["AuthorisedBy"] = Item.AuthorisedBy;
                dr["ServiceType"] = "";
                dr["Comments"] = Item.Comments;
                dr["CancelAmount"] = Item.CancelAmount;

                dtItemsBasket.Rows.Add(dr);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in AmountRefund", ex);
        }

        return dtItemsBasket;
    }

    protected void CreateTask()
    {
        try
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            long AssingTo = -1;
            long AssingRoleID = -1;
            long TaskActionID = -1;
            Role_BL rolebl = new Role_BL(base.ContextInfo);
            Int64.TryParse(Request.QueryString["CreatedBy"], out AssingTo);
            Int64.TryParse(Request.QueryString["RoleID"], out AssingRoleID);

            sPatientName = lblName.Text.Trim();
            lstUser = new List<Users>();
            //INVUser.GetUserDetail(AssingTo, out lstUser);
            INVUser.GetUserDetail(LID, out lstUser);
            task = new Tasks();
            dText = new Hashtable();
            urlVal = new Hashtable();
            RequestType = "APR";
            TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.Refund);
            returnCode = Utilities.GetHashTable(TaskActionID, vid, LID,
                         patientID, sPatientName, "", RoleID, "", 0, "", ptaskID, RequestType, out dText, out urlVal,
                         RefundNo, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "", "0", lstPatientVisitDetails[0].VisitNumber,"");

            task.TaskActionID = Convert.ToInt32(TaskActionID);
            task.DispTextFiller = dText;
            urlVal.Add("RefFlag", RefFlag);
            task.URLFiller = urlVal;
            task.PatientID = patientID;
            task.AssignedTo = AssingTo;
            task.RoleID = AssingRoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = vid;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.APPROVED;
            task.CreatedBy = LID;

            returnCode = taskBL.CreateTask(task, out taskID);
            if (returnCode == 0)
            {
                if (RefundStatus == "APPROVED" || RefundStatus == "CANCELLED")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "TaskCreate", "alert('Task Successfully Completed by '+'" + lstUser[0].Name.ToString() + "');", true);
                    // homepage();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "TaskReject", "alert('Task Rejected Successfully');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Error in Task Creation');", true);
            }
        }
        catch (Exception ex)
        {

        }

    }

    private void LoadCurrency()
    {
        lblCurName.Text = CurrencyName;
        objReasonMaster = new Master_BL(base.ContextInfo);
        objReasonMaster.GetCurrencyOrgMapping(OrgID, out lstCurrOrgMap);
        ddlBaseCurrency.DataSource = lstCurrOrgMap;
        ddlBaseCurrency.DataTextField = "CurrencyName";
        ddlBaseCurrency.DataValueField = "CurrencyID";
        ddlBaseCurrency.DataBind();
        for (int i = 0; i < lstCurrOrgMap.Count; i++)
        {
            if (lstCurrOrgMap[i].IsBaseCurrency == "Y")
            {
                ddlBaseCurrency.SelectedValue = lstCurrOrgMap[i].CurrencyID.ToString();
            }
        }

    }

    protected void btnRefund_Click(object sender, EventArgs e)
    {
        try
        {

            DataTable dtRefundToPatient = new DataTable();
            List<AmountRefundDetails> lstApprovedRefund = new List<AmountRefundDetails>();
            AmountRefundDetails AmtRfnDetails;
            string bill = string.Empty;
            RefundStatus = hdnCancelBill.Value == "N" ? "REFUND" : "CANCELLED";
            foreach (GridViewRow grdRef in grdResult.Rows)
            {
                AmtRfnDetails = new AmountRefundDetails();
                TextBox txtApprovedAmt = (TextBox)grdRef.FindControl("TxtRfdAmt");
                Label BuildAmount = (Label)grdRef.FindControl("lblAmount");
                DropDownList ddlType = (DropDownList)grdRef.FindControl("ddlType");
                string BillingDetID = grdResult.DataKeys[grdRef.RowIndex].Values["BillingDetailsID"].ToString();
                decimal BuildAmountValue = Convert.ToDecimal(BuildAmount.Text);
                if (hdnCancelBill.Value == "N")
                {
                    BuildAmountValue = 0;
                }
                AmtRfnDetails.BillingDetailsID = Convert.ToInt64(BillingDetID);
                AmtRfnDetails.AmtRefund = Convert.ToDecimal(txtApprovedAmt.Text);
                AmtRfnDetails.FinalBillID = Convert.ToInt64(hdnFinalBillId.Value);
                // AmtRfnDetails.RefundStatus = "Closed";
                AmtRfnDetails.OrgID = OrgID;
                AmtRfnDetails.CreatedBy = LID;
                AmtRfnDetails.RefundType = "Refund";
                AmtRfnDetails.Comments = "";
                AmtRfnDetails.ApprovedBy = Int64.Parse(ApprovedBy);
                AmtRfnDetails.AuthorisedBy = Int32.Parse(ApprovedBy);
                AmtRfnDetails.ReasonforRefund = ddlType.SelectedIndex != -1 ? ddlType.SelectedItem.Text : "";
                AmtRfnDetails.CancelAmount = BuildAmountValue;
                if (rblPaymode.SelectedItem.Text == "Cash")
                {
                    AmtRfnDetails.PaymentTypeID = 1;
                }
                else if (rblPaymode.SelectedItem.Text == "Cheque")
                {
                    AmtRfnDetails.PaymentTypeID = 2;
                    if (txtNumber.Text != "")
                    {
                        AmtRfnDetails.ChequeNo = Convert.ToInt64(txtNumber.Text);
                    }
                    else
                    {
                        AmtRfnDetails.ChequeNo = 0;
                    }
                    AmtRfnDetails.BankName = txtBankType.Text;
                    AmtRfnDetails.Remarks = txtRemarks.Text;
                }
                lstApprovedRefund.Add(AmtRfnDetails);
            }
            if (lstApprovedRefund.Count > 0)
            {
                dtRefundToPatient = ConvertToListTable(lstApprovedRefund);
            }
            returnCode = new BillingEngine(base.ContextInfo).UpdateRefundDetails(OrgID, RefFlag, RefundNo, LID, RefundStatus, LID, "", dtRefundToPatient);
            if (returnCode == 0)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                if (hdnCancelBill.Value == "N")
                {
                    // amtrecvd = lblRefundAmount.Text.ToString();
                    bill = " " + lblName.Text + " (BillNumber:" + lblInvoiceNo.Text + ")";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "RFND", "alert('Amount Successfully Refunded to '+'" + bill + "');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "getMessage('" + lblInvoiceNo.Text.ToString() + "','" + lblCurrChange.Text.ToString()
                                                                                         + "','" + sPatientName.ToString() + "','" + hdnPatientNo.Value.ToString()
                                                                                         + "','" + lblCurrChange.Text.ToString() + "','" + RefundNo
                                                                                         + "','" + vid.ToString() + "','" + patientID.ToString()
                                                                                         + "','" + Reftypes + "','" + hdnFinalBillId.Value + "');", true);
                }
                else
                {
                    Reftypes = "CAN";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "CANCEL", "alert('Services canceled successfully');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "getMessage('" + lblInvoiceNo.Text.ToString() + "','" + lblCurrChange.Text.ToString()
                                                                                        + "','" + sPatientName.ToString() + "','" + hdnPatientNo.Value.ToString()
                                                                                        + "','" + lblCurrChange.Text.ToString() + "','" + RefundNo
                                                                                        + "','" + vid.ToString() + "','" + patientID.ToString()
                                                                                        + "','" + Reftypes + "','" + hdnFinalBillId.Value + "','" + "N" + "');", true);
                }
                Panel4.Visible = false;
                trCancel.Style.Add("display", "block");
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "CANCEL", "alert('Error in Approve Process');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PerformRefund\\btnRefund_Click\\btnOk_Click()", ex);
        }
    }
}
