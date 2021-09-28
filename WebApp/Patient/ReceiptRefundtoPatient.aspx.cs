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

public partial class Patient_ReceiptRefundtoPatient : BasePage,System.Web.UI.ICallbackEventHandler
{
    long returnCode = -1;
    long patientID = -1;
    long vid = 0;
    long interPayId = -1;
    decimal refundAmount = 0;
    decimal amtReceived = 0;
    decimal amtRefunded = 0;
    decimal dChequeAmount = 0;
    long taskid = -1;
    string sPatientName = "";
    string PatientNumber=string.Empty;
    string pReceiptType = string.Empty;
    string ReceiptNo = string.Empty;
    string RefundNo = string.Empty;
    int RefundStatus = 0;
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    BillingEngine billingBL ;
    List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();
    FinalBill fBill = new FinalBill();
    long BillID = 0;
    Master_BL masterBL;
    Role_BL rolebl;
    string BaseCurrencyCode = string.Empty;
    List<CurrencyOrgMapping> lstCurrOrgMap = new List<CurrencyOrgMapping>();
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL;
    long taskID = -1;
    long ptaskID = -1;
    int BaseCurrencyID = -1;
    string gUID = string.Empty;
    string feeType = string.Empty;
    long phyID = -1;
    int otherID = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        billingBL = new BillingEngine(base.ContextInfo);
        masterBL = new Master_BL(base.ContextInfo);
        rolebl = new Role_BL(base.ContextInfo);
        taskBL = new Tasks_BL(base.ContextInfo);
        rblPaymode.Attributes.Add("onclick", "Paymentchanged()");
        Int64.TryParse(Request.QueryString["vid"], out vid);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["interPayId"], out interPayId);
        pReceiptType = Request.QueryString.Get("receiptType");
        sPatientName = Request.QueryString["pname"].ToString();
        PatientNumber=Request.QueryString["pNumber"].ToString();

        ClientScriptManager cs = Page.ClientScript;
        String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "ShowSuccess", "", "ProcessCallBackError", false);
        String callBackScript = "function  SaveRefund(arg){" + callBackReference + "; }";
        cs.RegisterClientScriptBlock(this.GetType(), "CallXmlValidation", callBackScript, true);


        if (!IsPostBack)
        {
            if (Request.QueryString["btype"] == "RFD")
            {
                pnlRefund.Visible = true;
                pnlCancel.Visible = false;
                if (Request.QueryString["pname"] != null)
                {
                    //lblPName.Text = "Refund to " + Request.QueryString["pname"].ToString();
                }

                billingBL.GetRefundReceiptDetails(vid, OrgID, patientID, interPayId, pReceiptType, out amtReceived, out amtRefunded, out dChequeAmount, out lstBillingDetails);
                
                if (lstBillingDetails.Count <= 0)
                {
                    lblResult.Visible = true;
                    lblResult.Text = "";
                    lblResult.Text = "Bill is yet to be generated";

                    btnCancel.Visible = false;
                    btnRefund.Visible = false;
                }
                else
                {
                    loadRefundforPatients();
                    LoadCurrency();
                    LoadPerformRefundRole();
                    lblCurrChange.Text = "0.00";
                    lblResult.Text = "";
                    lblResult.Text = "";

                    btnCancel.Visible = true;
                    
                    btnRefund.Visible = true;
                }
                if (lstBillingDetails.Count > 0)
                {
                    if (lstBillingDetails[0].IsTaskAssign == "Y")
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Task Assigned to this Bill. So You cannot Refund');", true);
                        pnlRefund.Visible = false;
                        pnlAssign.Visible = false;
                        lblResult.Visible = true;
                        lblResult.Text = "Task Assigned to this Bill. So You cannot Refund";
                        hdntrTaskAssign.Value = "1";
                    }
                }
            }
        }
    }
    private void LoadCurrency()
    {

        masterBL.GetCurrencyOrgMapping(OrgID, out lstCurrOrgMap);
        ddlBaseCurrency.DataSource = lstCurrOrgMap;
        ddlBaseCurrency.DataTextField = "CurrencyName";
        ddlBaseCurrency.DataValueField = "CurrencyID";
        ddlBaseCurrency.DataBind();
        //ddlBaseCurrency.Items.Insert(0, "--Select--");

        for (int i = 0; i < lstCurrOrgMap.Count; i++)
        {
            if (lstCurrOrgMap[i].IsBaseCurrency == "Y")
            {
                ddlBaseCurrency.SelectedValue = lstCurrOrgMap[i].CurrencyID.ToString();
                hdnBaseCurrencyID.Value = lstCurrOrgMap[i].CurrencyID.ToString();
            }
        }

    }
    private void LoadPerformRefundRole()
    {
        List<Role> lstRole = new List<Role>();
        rolebl.GetPerformRefundRole(OrgID, 43, out lstRole);
        int flag = 0;
        decimal curAmount;
        lblCurName.Text = CurrencyName;
        if (lstRole.Count > 0)
        {
            for (int i = 0; i < lstRole.Count; i++)
            {
                if (RoleName == lstRole[i].RoleName)
                {
                    flag = 1;
                }

            }
        }
        if (flag == 0 && lstRole.Count == 0)
        {
            pnlAssign.Visible = false;
        }
        if (flag == 0 && lstRole.Count > 0)
        {
            pnlAssign.Visible = true;
            curAmount = Convert.ToDecimal(lblTotAmtReceived.Text.ToString()) - Convert.ToDecimal(lblTotAmtRefunded.Text.ToString());
            trTaskAssign.Attributes.Add("display", "block");


            chkAssignTotask.DataSource = lstRole;
            chkAssignTotask.DataTextField = "RoleName";
            chkAssignTotask.DataValueField = "RoleID";
            chkAssignTotask.DataBind();

        }
        else
        {
            trTaskAssign.Attributes.Add("display", "none");
            hdntrTaskAssign.Value = "0";
        }



    }

    protected void grdRefund_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label l1 = (Label)e.Row.FindControl("lblAmount");
                Label l2 = (Label)e.Row.FindControl("lblRfdAmt");
                Label l3 = (Label)e.Row.FindControl("lblamtcanbetrans");

                TextBox t1 = (TextBox)e.Row.FindControl("TxtRfdAmt");
                hdnTemprefAmount.Value = hdnTemprefAmount.Value + t1.ClientID + "~";
                decimal min;
                min = Convert.ToDecimal(l1.Text) - Convert.ToDecimal(l2.Text);
                l3.Text = min.ToString();
                l3.ForeColor = System.Drawing.Color.Red;
                if (Request.QueryString["btype"] == "RFD")
                {
                    long billingDetailsID = 0;
                    Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
                    if (billingDetailsID > 0)
                    {
                        grdRefund.Columns[0].Visible = false;
                        grdRefund.Columns[6].Visible = false;
                        grdRefund.Columns[7].Visible = false;
                        //grdRefund.Columns[8].Visible = false;
                        ((TextBox)e.Row.FindControl("TxtRfdAmt")).Text = amtRefunded.ToString();
                        ((TextBox)e.Row.FindControl("TxtRfdAmt")).Enabled = false;
                        grdRefund.Columns[9].Visible = false;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Receipt Refund / Cancel", ex);
        }
    }

    //protected void grdRefund_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdRefund.PageIndex = e.NewPageIndex;
    //        loadRefundforPatients();
    //    }
    //}

    public void loadRefundforPatients()
    {
        long BillID = 0; long billingDetailsID = 0;
        Int64.TryParse(Request.QueryString["bid"], out BillID); Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        billingBL.GetRefundReceiptDetails(vid, OrgID, patientID, interPayId, pReceiptType, out amtReceived, out amtRefunded, out dChequeAmount, out lstBillingDetails);
        if (lstBillingDetails.Count > 0)
        {
            btnRefund.Enabled = true;
            grdRefund.DataSource = lstBillingDetails;
            grdRefund.DataBind();
        }
        if (interPayId > 0)
        {
            lblTotAmtReceived.Text = amtReceived.ToString("0.00");
            lblTotAmtRefunded.Text = amtRefunded.ToString("0.00");
            lblRefundableAmt.Text = (amtReceived - amtRefunded).ToString("0.00"); 
            lblTotAmtReceived.ForeColor = System.Drawing.Color.DarkRed;
            lblTotAmtRefunded.ForeColor = System.Drawing.Color.DarkRed;
            lblRefundableAmt.ForeColor = System.Drawing.Color.DarkRed;
        }
        else if (billingDetailsID > 0)
        {
            lblTotAmtReceived.Text = amtReceived.ToString();
            lblTotAmtRefunded.Text = amtRefunded.ToString();
            lblRefundableAmt.Text = (amtReceived - amtRefunded).ToString("0.00"); 
            lblTotAmtReceived.Visible = false;
            lblTotAmtRefunded.Visible = false;
            lblAmtReceivedText.Visible = false;
            lblAmtRefundedText.Visible = false;
        }

        if (dChequeAmount > 0)
        {
            lblWarning.Visible = true;
            lblWarning.Text = "This Bill has Cheque Payment of Rs." + dChequeAmount + "/-. Please ensure before refunding";
        }
        else
        {
            lblWarning.Visible = false;
        }
    }

    protected void grdRefund_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }
    protected void CreateTask()
    {
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
        long AssingTo = -1;
        task = new Tasks();
        dText = new Hashtable();
        urlVal = new Hashtable();
        feeType = "RFD";
        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformRefund, vid, LID,
        patientID, sPatientName, "", otherID, "",
        0, "", ptaskID, feeType, out dText, out urlVal, RefundNo, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, ""); // Other Id meand Procedure ID
        task.TaskActionID = (int)TaskHelper.TaskAction.PerformRefund;
        task.DispTextFiller = dText;
        task.URLFiller = urlVal;
        task.PatientID = patientID;
        foreach (ListItem item in chkAssignTotask.Items)
        {
            if (item.Selected == true)
            {
                AssingTo = Int64.Parse(item.Value);
            }
        }
        task.RoleID = AssingTo;
        //task.RoleID = RoleID;
        task.OrgID = OrgID;
        task.PatientVisitID = vid;
        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        task.CreatedBy = LID;
        returnCode = taskBL.CreateTask(task, out taskID);
    }

    public void RaiseCallbackEvent(String eventArgument)
    {
        SaveRefund();

    }
    public string GetCallbackResult()
    {
        return "";
    }

    protected void btnTask_Click(object sender, EventArgs e)
    {
        SaveRefund();

    }

    protected void btnRefund_Click(object sender, EventArgs e)
    {
        SaveRefund();
        
    }
    protected void SaveRefund()
    {
        AmountRefundDetails ARD = new AmountRefundDetails();
        int flag = 0;
        int flagAssign = -1;
        int flagRfd = -1;
        string sError = string.Empty;
        decimal totalamount = 0;
        btnRefund.Enabled = false;
        long returncode = -1;
        int returnstatus = -1; long billingDetailsID = 0; Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        if (btnRefund.Text == "Refund")
        {
            decimal amtrecvd = Convert.ToDecimal(lblTotAmtReceived.Text);
            decimal amtrfd = Convert.ToDecimal(lblTotAmtRefunded.Text);
            decimal checkAR = 0;

            foreach (GridViewRow gR in grdRefund.Rows)
            {
                if (((CheckBox)gR.FindControl("chkRefund")).Checked == true)
                {
                    


                    BillingDetails bd = new BillingDetails();
                    Label lbBillDetailID = (Label)gR.FindControl("lblBillDetailsID");
                    Label lbFinalBillID = (Label)gR.FindControl("lblFinalBillID");

                    Label lbAmount = (Label)gR.FindControl("lblAmount");
                    Label lbRfdAmount = (Label)gR.FindControl("lblRfdAmt");
                    TextBox txtRAmount = (TextBox)gR.FindControl("TxtRfdAmt");
                    TextBox txtRReason = (TextBox)gR.FindControl("txtRfdReason");
                    long bdid = Convert.ToInt64(lbBillDetailID.Text);
                    //long fbid = 0;
                    //if(lbFinalBillID.Text=="")
                    //    fbid = 0;
                    //else
                    //    fbid = Convert.ToInt64(lbFinalBillID.Text);
                    decimal totAmt = Convert.ToDecimal(lbAmount.Text);
                    decimal totRfdAmt = Convert.ToDecimal(lbRfdAmount.Text);
                    string rReason = txtRReason.Text;

                    decimal amt = Convert.ToDecimal(txtRAmount.Text == "" ? "0" : txtRAmount.Text);
                    checkAR += amt;
                    decimal maxAmt = (totAmt - totRfdAmt) - amt;

                    if (maxAmt >= 0 && amt > 0 && rReason != "")
                    {
                        refundAmount += amt;
                        flagRfd = 0;
                        ARD = new AmountRefundDetails();

                        if (pnlAssign.Visible == true)
                        {
                            foreach (ListItem item in chkAssignTotask.Items)
                            {
                                if (item.Selected == true)
                                {

                                    ARD.ApprovedBy = Int64.Parse(item.Value);
                                    flagAssign = 1;
                                    RefundStatus = 1;
                                }


                            }


                            ARD.TranCurrencyID = Convert.ToInt32(ddlBaseCurrency.SelectedValue.ToString());
                            ARD.BaseCurrencyID = Convert.ToInt32(hdnBaseCurrencyID.Value);
                            if (hdnCurrencyAmount.Value != "")
                                ARD.TranCurrencyAmount = Convert.ToDecimal(hdnCurrencyAmount.Value);
                            if (rblPaymode.SelectedItem.Text == "Cash")
                            {

                                ARD.PaymentTypeID = 1;
                                ARD.ChequeNo = -1;
                                ARD.BankName = "NULL";
                                ARD.Remarks = "NULL";
                            }
                            else if (rblPaymode.SelectedItem.Text == "Cheque")
                            {
                                ARD.PaymentTypeID = 2;
                                ARD.ChequeNo = Convert.ToInt64(txtNumber.Text);
                                ARD.BankName = txtBankType.Text;
                                ARD.Remarks = txtRemarks.Text;
                            }
                        }
                        if (lbFinalBillID.Text == "")
                            ARD.PaymentDetail = "0";
                        else
                            ARD.PaymentDetail = lbFinalBillID.Text.ToString();
                        ARD.BillingDetailsID = Convert.ToInt64(lbBillDetailID.Text);
                        ARD.AmtRefund = Convert.ToDecimal(txtRAmount.Text == "" ? "0" : txtRAmount.Text);
                        
                        if (flagAssign == -1)
                            ARD.RefundBy = LID;
                        ARD.OrgID = OrgID;
                        ARD.CreatedBy = LID;
                        ARD.RefundType = pReceiptType;
                        ARD.ReasonforRefund = txtRReason.Text;
                        lstAmountRefundDetails.Add(ARD);

                        fBill = new FinalBill();
                        fBill.AmountRefund = refundAmount;

                        flag++;
                    }
                    else
                    {
                        flag++;
                        flagRfd = -1;

                        if (maxAmt < 0)
                        {
                            //sError = "Max amount already refunded";
                            sError = "Refundable amount should be less than received amount";
                            break;
                        }
                        else if (amt <= 0)
                        {
                            sError = "Entered amount should be greater than zero";
                            break;
                        }
                        else if (rReason == "")
                        {
                            sError = "Reason for refund is mandatory";
                            break;
                        }
                    }
                }
            }

            //if (checkAR <= amtrecvd && checkAR >= amtrfd)
            decimal dRefund = checkAR + amtrfd;
            if (amtrecvd >= dRefund)
            {
                if (flag > 0)
                {
                    if (flagRfd == 0)
                    {
                        List<BillingDetails> lstBillingdetails = new List<BillingDetails>();
                        returncode = billingBL.insertAmtRefundDetails(lstAmountRefundDetails, "", out RefundNo, RefundStatus, OrgID, out lstBillingdetails,0);
                        foreach (AmountRefundDetails item in lstAmountRefundDetails)
                        {
                            //s = item.AmtRefund.ToString();

                            totalamount += Convert.ToDecimal(item.AmtRefund.ToString());

                        }
                        if (returnstatus > 0)
                        {
                            lblResult.Visible = true;
                            lblResult.Text = "";
                            if (flagAssign == -1)
                            {
                                lblResult.Text = "Amount Has Been Successfully Refunded";
                            }
                            if (flagAssign == 1)
                            {
                                lblResult.Text = "Task Assigned";
                                CreateTask();
                            }
                            //string Rno = string.Empty;
                            //Rno = RefundNo.ToString();
                            Patient_BL pbl = new Patient_BL(base.ContextInfo);
                            //List<IDMaster> idmaster = new List<IDMaster>();
                            //string s = "";
                            //pbl.GetRefundReceipt(OrgID, out idmaster);
                            //if (idmaster.Count > 0)
                            //{
                            //    foreach (IDMaster item in idmaster)
                            //    {
                            //        s = item.RefundVoucherNo.ToString();
                            //    }
                            //}
                            if (!ClientScript.IsStartupScriptRegistered("alert"))
                            {
                                string[] sar = new string[100];
                                if (flagAssign == -1)
                                {
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "getMessage('" + lstAmountRefundDetails[0].PaymentDetail.ToString() + "','" + amtrecvd.ToString() + "','" + sPatientName.ToString() + "', '" + PatientNumber.ToString() + "', '" + totalamount.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "')", true);
                                }


                            }




                            //Response.Redirect(@"~\Billing\RefundVoucher.aspx?BNo=" + vid.ToString() + "&BilledAmt=" + amtrecvd.ToString() + "&PatientName=" + sPatientName.ToString() + "&ReceivedAmt=" + s.ToString(), true);
                            //Response.Redirect(@"~\Billing\RefundVoucher.aspx");
                        }
                        else
                        {
                            lblResult.Visible = true;
                            lblResult.Text = "";
                            lblResult.Text = "Amount Has Not Been Refunded";
                        }
                    }
                    else
                    {
                        lblResult.Visible = true;
                        lblResult.Text = "";
                        lblResult.Text = sError;
                    }
                }
                else
                {
                    lblResult.Visible = true;
                    lblResult.Text = "";
                    lblResult.Text = "Please Select atleast one Bill Item";
                    btnRefund.Enabled = true;
                }
            }
            else
            {
                lblResult.Visible = true;
                lblResult.Text = "";
                lblResult.Text = "Refund Amount Should Not be Higher than Received Amount";
                btnRefund.Enabled = true;
            }
            if (returnstatus == 0)
                loadRefundforPatients();
            //else
            //    btnRefund.Enabled = true;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //List<Role> lstUserRole = new List<Role>();
        //string path = string.Empty;
        //Role role = new Role();
        //role.RoleID = RoleID;
        //lstUserRole.Add(role);
        //returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
        Response.Redirect(Request.ApplicationPath + "/Billing/ReceiptSearch.aspx");
    }
}
