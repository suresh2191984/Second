using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Billing_DepositRefund : BasePage
{
    long pPatientID = 0;
    long pDepositID = 0;
    long returnCode = -1;
    string VouNo = string.Empty;
    long OutFlowID = -1;
    decimal totalDepositAmount = 0;
    decimal totalDepositUsed = 0;
    decimal totalDepositBalance = 0;
    Patient_BL patientBL;
    List<Patient> lstPatient = new List<Patient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        if (Request.QueryString["PID"] != null)
        {
            pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        if (Request.QueryString["DID"] != null)
        {
            pDepositID = Request.QueryString["DID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["DID"].ToString());
        }
         
        if (!IsPostBack)
        {
            returnCode = patientBL.GetPatientDemoandAddress(pPatientID, out lstPatient);
            if (lstPatient.Count > 0)
            {
                lblPatientID.Text = lstPatient[0].PatientNumber;
                lblPatientName.Text = lstPatient[0].Name;
            }
            hdnPatientName.Value = lblPatientName.Text;
            loadInitialDatas();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        decimal dAmount = 0;
        BillingEngine objEngine = new BillingEngine(base.ContextInfo);
        List<PatientDepositHistory> lstPDH = new List<PatientDepositHistory>();
        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
        string pPatientName = string.Empty;
        string pPaymentType = string.Empty;
        decimal pAmountRefund = 0.00m;
        string pRemarks = string.Empty;
        string pStatus = "Open";
        DateTime pDateFrom;
        decimal pServiceCharge = 0;
        pPatientName = lblPatientName.Text;
        pPaymentType = "REF";
        pRemarks = "Deposit Amount Refunded";
        hdnNowPaid.Value = hdnNowPaid.Value == "" ? "0" : hdnNowPaid.Value;
        txtPayment.Text = (txtPayment.Text == "0" || txtPayment.Text == "") ? hdnNowPaid.Value : txtPayment.Text;
        pAmountRefund = Convert.ToDecimal(txtPayment.Text);
        dAmount = Convert.ToDecimal(txtPayment.Text);
        pDateFrom = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        dtAdvancePaidDetails = PaymentTypes.GetAmountReceivedDetails();
        returnCode = objEngine.pInsertDepositRefund(pDepositID, pPatientID, pPatientName, pPaymentType, pAmountRefund, pDateFrom,
                                                    pRemarks, pStatus, Convert.ToInt16(LID), OrgID, dtAdvancePaidDetails, pServiceCharge, out VouNo, out OutFlowID, ILocationID);

        
        if (txtPayment.Text.Trim() != "0" && returnCode >= 0)
        {
            hdnAmount.Value = (Convert.ToDecimal(txtPayment.Text.Trim()) - Convert.ToDecimal(hdnServiceCharge.Value.Trim())).ToString();
            hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            hdnReceiptNo.Value = VouNo.ToString().Trim();
            hdnPatientName.Value = lblPatientName.Text;
            hdnOutFlowID.Value = OutFlowID.ToString();
            List<Users> lstUsers = new List<Users>();
            new SharedInventory_BL(base.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
            BilledBy.Value =  lstUsers.Find(P => P.LoginID == LID).Name.ToUpper();
            this.Page.RegisterStartupScript("strKyAdvancePaidDetails", "<script type='text/javascript'> PopUpPage(); </script>");
        }


        //int length = 0;
        //length = dtAdvancePaidDetails.Rows.Count;
        //for (int i = 0; i < length; i++)
        //{
        //    PatientDepositHistory objPDH = new PatientDepositHistory();
        //    objPDH.DepositID = 0;
        //    objPDH.PatientID = pPatientID;
        //    objPDH.OrgID = OrgID;
        //    objPDH.ReceiptNo = 0;
        //    objPDH.AmountDeposited = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["AmtReceived"]);
        //    objPDH.PaymentTypeID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["TypeID"]);
        //    objPDH.ChequeorCardNumber = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["ChequeorCardNumber"]);
        //    objPDH.BankNameorCardType = dtAdvancePaidDetails.Rows[i]["BankNameorCardType"].ToString();
        //    objPDH.Remarks = dtAdvancePaidDetails.Rows[i]["Remarks"].ToString();
        //    objPDH.ServiceCharge = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["ServiceCharge"]);
        //    objPDH.BaseCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["BaseCurrencyID"]);
        //    if (Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["PaidCurrencyID"]) == 0)
        //    {
        //        objPDH.PaidCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["BaseCurrencyID"]);
        //    }
        //    else
        //    {
        //        objPDH.PaidCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["PaidCurrencyID"]);
        //    }
        //    if (Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["OtherCurrencyAmount"]) == 0)
        //    {
        //        objPDH.PaidCurrencyAmount = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["AmtReceived"]);
        //    }
        //    else{
        //        objPDH.PaidCurrencyAmount = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["OtherCurrencyAmount"]);
        //    }
        //    objPDH.CreatedBy = LID;
        //    lstPDH.Add(objPDH);
        //}
        //long ReceiptNo = 0;
        //returnCode = objAdBL.SaveCollectedDeposit(pPatientID, OrgID, LID, lstPDH, out ReceiptNo);
       
        #region Clear Datas

        txtPayment.Text = "";
        ((HiddenField)OtherPayments.FindControl("hdfValues")).Value = "";
        ((HiddenField)OtherPayments.FindControl("hdnValueExists")).Value = "";
        ((HiddenField)OtherPayments.FindControl("hdnValuesDeleted")).Value = "";

        ((HiddenField)PaymentTypes.FindControl("hdfPaymentType")).Value = "";
        ((HiddenField)PaymentTypes.FindControl("hdnPaymentsDeleted")).Value = "";
      
        this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
        #endregion

        loadInitialDatas();
    }

    protected void loadInitialDatas()
    {
        AdvancePaid_BL objapdBL = new AdvancePaid_BL(base.ContextInfo);
        List<PatientDepositHistory> lstPDH = new List<PatientDepositHistory>();
        decimal TotalDepositAmount = 0;
        decimal TotalDepositUsed = 0;
        decimal TotalRefundAmount = 0;
        //decimal tempRefundAmount = 0;
        objapdBL.GetPatientDepositDetails(pPatientID, OrgID, out lstPDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);
        
        lblTotalDepositAmount.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblTotalDepositUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        lblTotalDepositAmountTemp.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblTotalDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
        lblRefundAmount.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
        if (TotalRefundAmount > 0)
        {
            lblRefundedAmt.Visible = true;
            lblRefundAmt.Visible = true;
            lblRefundAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
        }
        gvCollectDepositDetails.DataSource = lstPDH;
        gvCollectDepositDetails.DataBind();
    }
     

    //protected void BindGridDatas()
    //{
    //    long visitID = 0;
    //    decimal dAdvanceAmount = 0;
    //    if (Request.QueryString["VID"] != null)
    //    {
    //        visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
    //    }
    //    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    //    List<AdvancePaidDetails> lstAdvancePaid = new List<AdvancePaidDetails>();
    //    new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, "PNOW", out dAdvanceAmount, out lstAdvancePaid);
      
    //    gvAdvancePaidDetails.DataSource = lstAdvancePaid;
    //    gvAdvancePaidDetails.DataBind();
    //}
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + "/Reception/Home.aspx", true);
            //Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }
    protected void gvCollectDepositDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientDepositHistory p = (PatientDepositHistory)e.Row.DataItem;
                string strScript = "CallPrintReceipt('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoID")).ClientID + "','" + p.CreatedAt + "','" + p.AmountDeposited + "','" + p.ReceiptNo + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollectDepositDetails_RowDataBound", ex);
        }
    }
}


