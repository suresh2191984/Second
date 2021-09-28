using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities.CustomEntities;
using System.Web.Script.Serialization;
using Attune.Solution.BusinessLogic_InvoiceLedger;

public partial class Ledger_InvoiceReceiptOfflinePayment : BasePage
{

    ClientCredit ClientCreditdet = new ClientCredit();
    ClientDebit ClientDebitdet = new ClientDebit();
    string type = string.Empty;
    string PaymentType = string.Empty;
    string AdvanceAmount = string.Empty;
    string BillingAmount = string.Empty;
    string Advance = string.Empty;
    //string PaymentType = string.Empty;
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {

            hdnPaymentType.Value = string.Empty;

            if (Session["BillPaymentType"] != null)
            {
                if (Session["BillPaymentType"].ToString() != "")
                {
                    if (Session["BillPaymentType"].ToString() == "BILLWISE")
                    {
                        PaymentType = Session["BillPaymentType"].ToString();
                        hdnPaymentType.Value = PaymentType;
                        BillingAmount = Session["ClientPaymentAmount"].ToString();

                    }
                }
            }
            else if (Session["InvoicePaymentType"] != null)
            {
                if (Session["InvoicePaymentType"].ToString() != "")
                {
                    if (Session["InvoicePaymentType"].ToString() == "INVOICEWISE")
                    {
                        PaymentType = Session["InvoicePaymentType"].ToString();
                        hdnPaymentType.Value = PaymentType;
                        BillingAmount = Session["MultipleInvoicePaymentAmount"].ToString();

                    }
                }
            }

            if (Session["DueAdvanceAmount"] != null)
            {
                if (Session["DueAdvanceAmount"] != "")
                {
                    Advance = Session["DueAdvanceAmount"].ToString();
                    if (Convert.ToInt32(Math.Round(Convert.ToDouble(Advance), 3)) > 0)
                    {
                        //chkAdvanceSelect.Enabled = false;
                        txtAdvanceAmount.Text = Advance;
                        txtAmount.Text = BillingAmount;
                        //if (Convert.ToInt32(txtAdvanceAmount.Text) >= Convert.ToInt32(txtAmount.Text))
                        //{
                        //   // DivRpwd.Style.Add("display", "none");
                        //   // DivCheque.Style.Add("display", "none");
                        //    //DivCash.Style.Add("display", "none");
                        //}
                        //else if (Convert.ToInt32(Advance) < Convert.ToInt32(BillingAmount))
                        //{

                        //   // DivRpwd.Style.Add("display", "block");
                        //   // DivCheque.Style.Add("display", "none");
                        //    //DivCash.Style.Add("display", "block");
                        //}

                    }
                    else if (Convert.ToInt32(Math.Round(Convert.ToDouble(Advance), 3)) <= 0)
                    {
                        divAdvanceProceed.Style.Add("display", "none");
                    }
                }
            }
            else
            {
                divAdvanceProceed.Style.Add("display", "none");
            }
            if (PaymentType == "BILLWISE")
            {
                if (Session["PaymentClientCode"] != null && Session["ClientPaymentAmount"] != null && Session["ClientID"] != null && Session["PaymentInvoiceID"] != null && Session["SelectedBillID"] != null)
                {
                    if (Session["PaymentClientCode"].ToString() != "" && Session["ClientPaymentAmount"].ToString() != "" && Session["ClientID"].ToString() != "" &&
                 Session["PaymentInvoiceID"].ToString() != "" && Session["SelectedBillID"].ToString() != "")
                    {
                        txtRClientName.Text = Session["PaymentClientCode"].ToString();
                        txtRClientName.Enabled = false;
                        txtCashAmount.Text = Session["ClientPaymentAmount"].ToString();
                        txtCashReAmount.Text = Session["ClientPaymentAmount"].ToString();
                        txtCashReAmount.Enabled = false;
                        txtChequeAmount.Text = Session["ClientPaymentAmount"].ToString();
                        txtCashAmount.Enabled = false;
                        txtCashReAmount.Visible = false;
                        hdnRClientid.Value = Session["PaymentClientCode"].ToString();
                        txtChequeEnterAmount.Text = Session["ClientPaymentAmount"].ToString();
                        txtChequeEnterAmount.Enabled = false;
                        lblCashReAmount.Enabled = false;
                    }
                }
            }
            else if (PaymentType == "INVOICEWISE")
            {
                if (Session["MultiplePaymentClientCode"] != null && Session["MultipleInvoicePaymentAmount"] != null && Session["MultipleInvoiceClientID"] != null && Session["MultiplePaymentInvoiceID"] != null)
                {
                    if (Session["MultiplePaymentClientCode"].ToString() != "" && Session["MultipleInvoicePaymentAmount"].ToString() != "" && Session["MultipleInvoiceClientID"].ToString() != "" &&
                 Session["MultiplePaymentInvoiceID"].ToString() != "")
                    {
                        txtRClientName.Text = Session["MultiplePaymentClientCode"].ToString();
                        txtRClientName.Enabled = false;
                        txtCashAmount.Text = Session["MultipleInvoicePaymentAmount"].ToString();
                        txtCashReAmount.Text = Session["MultipleInvoicePaymentAmount"].ToString();
                        txtCashReAmount.Enabled = false;
                        txtChequeAmount.Text = Session["MultipleInvoicePaymentAmount"].ToString();
                        txtCashAmount.Enabled = false;
                        txtCashReAmount.Visible = false;
                        hdnRClientid.Value = Session["MultiplePaymentClientCode"].ToString();
                        txtChequeEnterAmount.Text = Session["MultipleInvoicePaymentAmount"].ToString();
                        txtChequeEnterAmount.Enabled = false;
                        lblCashReAmount.Enabled = false;
                    }
                }

            }
            //Session["MultiplePaymentClientCode"] = ClientCode;
            //Session["MultipleInvoicePaymentAmount"] = Amount;
            //Session["MultipleInvoiceClientID"] = ClientID;
            //Session["MultiplePaymentInvoiceID"] = InvoiceID;
            //Session["InvoicePaymentType"] = PaymentType;



            else
            {
                //txtChequedate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtCashDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                //ddlType_SelectedIndexChanged(sender, e);
            }
        }
        //AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
        AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
        hdnClientLoginID.Value = LID.ToString();
        hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        hdnOrgID.Value = OrgID.ToString();
        hdnDrivePath.Value = GetConfigValue("ReceiptEntryProofPath", OrgID);


        //handlerpath.Value = ConfigurationManager.AppSettings["DriveName"].ToString();
    }
    List<ClientCredit> CreditValue = new List<ClientCredit>();
    List<ClientDebit> DebitValue = new List<ClientDebit>();
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void btnReset_click(object sender, EventArgs e)
    {
        //cleardata();
    }

    protected void btnCashReset_Click(object sender, EventArgs e)
    {
        Session["PaymentClientCode"] = null;
        Session["ClientPaymentAmount"] = null;
        Session["ClientID"] = null;
        Session["PaymentInvoiceID"] = null;
        Session["SelectedBillID"] = null;
        Session["BillPaymentType"] = null;
        Session["BillWiseCurrencyCode"] = null;
        Session["ClientPayingAmount"] = null;
        Session["DueAdvanceAmount"] = null;
        Response.Redirect("..\\Payment\\CrediMaxResponse.aspx");
    }
    protected void btnChequeSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Ledger/InvoicePayment.aspx");
    }
    protected void btnCashSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Ledger/InvoicePayment.aspx");
    }
    protected void chkAdvanceSelect_CheckedChanged(object sender, EventArgs e)
    {
        if (chkAdvanceSelect.Checked == true)
        {
            if (txtAmount.Text != "" && txtAdvanceAmount.Text != "")
            {

                if (Convert.ToInt32(txtAdvanceAmount.Text) >= Convert.ToInt32(txtAmount.Text))
                {
                    txtPayAmount.Text = "0"; // Convert.ToString(Convert.ToInt32(txtAdvanceAmount.Text) - Convert.ToInt32(txtOutstandingAmt.Text));
                    lblBalanceAdvance.Text = Convert.ToString(Convert.ToInt32(txtAdvanceAmount.Text) - Convert.ToInt32(txtAmount.Text));
                    trReminingAdv.Style.Add("Display", "block");
                    btnProceed.Visible = true;
                    //btnPay.Visible = false;
                }
                if (Convert.ToInt32(txtAdvanceAmount.Text) < Convert.ToInt32(txtAmount.Text))
                {
                    txtPayAmount.Text = Convert.ToString(Convert.ToInt32(txtAmount.Text) - Convert.ToInt32(txtAdvanceAmount.Text));
                    lblBalanceAdvance.Text = "0";// Convert.ToString(Convert.ToDecimal(txtOutstandingAmt.Text) - Convert.ToDecimal(txtAdvanceAmount.Text));
                    trReminingAdv.Style.Add("Display", "block");
                    btnProceed.Visible = false;

                }
            }
        }
        if (chkAdvanceSelect.Checked == false)
        {
            txtPayAmount.Text = txtAmount.Text;
            trReminingAdv.Style.Add("Display", "none");
            btnProceed.Visible = false;
            //btnPay.Visible = true;
        }
    }


    protected void btnProccedPay_Click(object sender, EventArgs e)
    {

        List<ClientReceipt> lstClientreceipt = new List<ClientReceipt>();
        List<ClientReceipt> lstClientreceiptInvoiceList = new List<ClientReceipt>();
        List<LedgerInvoiceDetails> lstClientReceiptDetail = new List<LedgerInvoiceDetails>();
        string respcd = null;
        long InvoiceID = 0;
        long ClientID = 0;
        string clientcode = string.Empty;
        long SuccessCode = 0;
        string currencyCode = string.Empty;
        string PaymentType = string.Empty;
        string remarks = string.Empty;
        JavaScriptSerializer serilize = new JavaScriptSerializer();
        // Session["BillWiseCurrencyCode"] = "BHD";
        remarks = "ResponseCode: " + "0" + ", ResponseMsg: " + "Successfully Paid form Advance"
            + ", EPGTxnId: " + "0" + ", TxnId: " + "0" + ", Amount: " + txtAmount.Text
             + ", AuthIdCode: " + "0" + ", PaymentGateway: Payment Done with Advance Amount";

        InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL(ContextInfo);
        ClientReceipt objClientReceipt = new ClientReceipt();
        ClientReceiptDetail objClientReceiptDetail = new ClientReceiptDetail();
        objClientReceipt = new ClientReceipt();
        if (Session["BillPaymentType"] != null)
        {
            if (Session["BillPaymentType"].ToString() != "")
            {
                if (Session["BillPaymentType"].ToString() == "BILLWISE")
                {
                    PaymentType = Session["BillPaymentType"].ToString();
                    clientcode = Session["PaymentClientCode"].ToString();
                    currencyCode = Session["BillWiseCurrencyCode"].ToString();
                }
            }
        }
        else if (Session["InvoicePaymentType"] != null)
        {
            if (Session["InvoicePaymentType"].ToString() != "")
            {
                if (Session["InvoicePaymentType"].ToString() == "INVOICEWISE")
                {
                    PaymentType = Session["InvoicePaymentType"].ToString();
                    clientcode = Session["MultiplePaymentClientCode"].ToString();
                    currencyCode = Session["InvoiceWiseCurrencyCode"].ToString();
                }
            }

            objClientReceipt.Amount = Convert.ToDecimal(txtAmount.Text);
            //objClientReceipt.BankName = "ICICI";
            objClientReceipt.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.CreatedBy = LID;
            objClientReceipt.Mode = "Online";
            objClientReceipt.ReceiptDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.Remarks = remarks;
            objClientReceipt.SourceCode = clientcode;
            objClientReceipt.OrgID = OrgID;
            objClientReceipt.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.ModifiedBy = UID;
            objClientReceipt.ResponseCode = "0";
            objClientReceipt.ResponseMsg = "Successfully Paid form Advance";
            objClientReceipt.TransactionID = "0";
            objClientReceipt.AuthIDCode = "0";
            lstClientreceipt.Add(objClientReceipt);
            if (PaymentType == "BILLWISE")
            {
                if (Session["PaymentInvoiceID"] != null && Session["ClientID"] != null && Session["SelectedBillID"] != null)
                    if (Session["PaymentInvoiceID"].ToString() != "" && Session["ClientID"].ToString() != "" && Session["SelectedBillID"].ToString() != "")
                    {
                        {
                            InvoiceID = Convert.ToInt64(Session["PaymentInvoiceID"].ToString());
                            ClientID = Convert.ToInt64(Session["ClientID"].ToString());
                            string[] items = Session["SelectedBillID"].ToString().Split('^');
                            int count = items.Length;
                            for (int i = 0; i < count; i++)
                            {
                                LedgerInvoiceDetails objledger = new LedgerInvoiceDetails();
                                objledger.InvoiceDetailsID = Convert.ToInt64(items[i]);
                                objledger.ClientId = ClientID;
                                objledger.PaymentMode = PaymentType;
                                objledger.InvoiceId = InvoiceID;
                                objledger.OrgID = OrgID;
                                objledger.CurrencyCode = currencyCode;
                                objledger.UsedAdvanceAmount = Convert.ToDecimal(txtAmount.Text);
                                objledger.RemainingAdvanceAmount = Convert.ToDecimal(lblBalanceAdvance.Text);
                                objledger.IsSucceedTransaction = "Y";
                                objledger.IsAdvanceUsed = "Y";
                                lstClientReceiptDetail.Add(objledger);
                            }

                            if (lstClientreceipt.Count > 0 && lstClientReceiptDetail.Count > 0)
                            {
                                objInvoiceLedger_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientreceipt, lstClientReceiptDetail, out SuccessCode);
                                Session["PaymentClientCode"] = null;
                                Session["ClientPaymentAmount"] = null;
                                Session["ClientID"] = null;
                                Session["PaymentInvoiceID"] = null;
                                Session["SelectedBillID"] = null;
                                Session["BillPaymentType"] = null;
                                Session["BillWiseCurrencyCode"] = null;
                                Session["DueAdvanceAmount"] = null;
                                txtAdvanceAmount.Text = "";
                                txtAmount.Text = "";
                                txtCashAmount.Text = "";
                                divAdvanceProceed.Style.Add("display", "none");
                                Response.Redirect("../Ledger/InvoicePayment.aspx");

                            }
                        }

                    }
            }
            else if (PaymentType == "INVOICEWISE")
            {

                if (Session["MultiplePaymentInvoiceID"] != null && Session["MultipleInvoiceClientID"] != null)
                {
                    if (Session["MultiplePaymentInvoiceID"].ToString() != "" && Session["MultipleInvoiceClientID"].ToString() != "")
                    {
                        string items = Session["MultiplePaymentInvoiceID"].ToString();
                        lstClientReceiptDetail = serilize.Deserialize<List<LedgerInvoiceDetails>>(items);
                        //InvoiceID = Convert.ToInt64(Session["PaymentInvoiceID"].ToString());
                        ClientID = Convert.ToInt64(Session["MultipleInvoiceClientID"].ToString());
                        if (lstClientReceiptDetail.Count > 0)
                        {
                            lstClientReceiptDetail = lstClientReceiptDetail.Select
                                (ee =>
                                {
                                    ee.CurrencyCode = currencyCode; ee.UsedAdvanceAmount = Convert.ToDecimal(txtAmount.Text);
                                    ee.RemainingAdvanceAmount = Convert.ToDecimal(lblBalanceAdvance.Text);
                                    ee.IsSucceedTransaction = "Y"; ee.IsAdvanceUsed = "Y"; return ee;
                                }).ToList();
                        }

                        foreach (var item in lstClientReceiptDetail)
                        {

                            ClientReceipt objClientReceiptInvoiceList = new ClientReceipt();
                            objClientReceiptInvoiceList.ReceiptID = Convert.ToInt64(item.InvoiceId);
                            objClientReceiptInvoiceList.Amount = lstClientreceipt[0].Amount;
                            objClientReceiptInvoiceList.CreatedAt = lstClientreceipt[0].CreatedAt;
                            objClientReceiptInvoiceList.CreatedBy = lstClientreceipt[0].CreatedBy;
                            objClientReceiptInvoiceList.Mode = lstClientreceipt[0].Mode;
                            objClientReceiptInvoiceList.ReceiptDate = lstClientreceipt[0].ReceiptDate;
                            objClientReceiptInvoiceList.Remarks = lstClientreceipt[0].Remarks;
                            objClientReceiptInvoiceList.SourceCode = lstClientreceipt[0].SourceCode;
                            objClientReceiptInvoiceList.OrgID = lstClientreceipt[0].OrgID;
                            objClientReceiptInvoiceList.ModifiedAt = lstClientreceipt[0].ModifiedAt;
                            objClientReceiptInvoiceList.ModifiedBy = lstClientreceipt[0].ModifiedBy;
                            objClientReceiptInvoiceList.ResponseCode = lstClientreceipt[0].ResponseCode;
                            objClientReceiptInvoiceList.ResponseMsg = lstClientreceipt[0].ResponseMsg;
                            objClientReceiptInvoiceList.PaymentReceiptNo = lstClientreceipt[0].PaymentReceiptNo;
                            objClientReceiptInvoiceList.TransactionID = lstClientreceipt[0].TransactionID;
                            objClientReceiptInvoiceList.AuthIDCode = lstClientreceipt[0].AuthIDCode;
                            lstClientreceiptInvoiceList.Add(objClientReceiptInvoiceList);
                        }
                        if (lstClientreceiptInvoiceList.Count > 0 && lstClientReceiptDetail.Count > 0)
                        {
                            objInvoiceLedger_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientreceiptInvoiceList, lstClientReceiptDetail, out SuccessCode);
                            Session["MultiplePaymentInvoiceID"] = null;
                            Session["MultipleInvoiceClientID"] = null;
                            Session["MultiplePaymentClientCode"] = null;
                            Session["MultipleInvoicePaymentAmount"] = null;
                            Session["MultipleInvoiceClientID"] = null;
                            Session["MultiplePaymentInvoiceID"] = null;
                            Session["InvoicePaymentType"] = null;
                            Session["InvoiceWiseCurrencyCode"] = null;
                            Session["DueAdvanceAmount"] = null;
                            txtAdvanceAmount.Text = "";
                            txtAmount.Text = "";
                            txtCashAmount.Text = "";
                            divAdvanceProceed.Style.Add("display", "none");
                            Response.Redirect("../Ledger/InvoicePayment.aspx");

                        }
                    }
                    //SaveClientReceipt(lstClientreceipt);
                    Session["MultipleInvoicePaymentAmount"] = "";

                }
            }
        }


    }
    protected void btnCashAdvence_Click(object sender, EventArgs e)
    {
        List<ClientReceipt> lstClientreceipt = new List<ClientReceipt>();
        List<ClientReceipt> lstClientreceiptInvoiceList = new List<ClientReceipt>();
        List<LedgerInvoiceDetails> lstClientReceiptDetail = new List<LedgerInvoiceDetails>();
        string respcd = null;
        long InvoiceID = 0;
        long ClientID = 0;
        string clientcode = string.Empty;
        long SuccessCode = 0;
        string currencyCode = string.Empty;
        string PaymentType = string.Empty;
        string remarks = string.Empty;
        JavaScriptSerializer serilize = new JavaScriptSerializer();
       // Session["BillWiseCurrencyCode"] = "BHD";
        remarks = "ResponseCode: " + "0" + ", ResponseMsg: " + "Successfully Paid form Advance"
            + ", EPGTxnId: " + "0" + ", TxnId: " + "0" + ", Amount: " + txtCashAmount.Text
             + ", AuthIdCode: " + "0" + ", PaymentGateway: Payment Done with Advance Amount";

        InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL(ContextInfo);
        ClientReceipt objClientReceipt = new ClientReceipt();
        ClientReceiptDetail objClientReceiptDetail = new ClientReceiptDetail();
        objClientReceipt = new ClientReceipt();
        if (Session["BillPaymentType"] != null)
        {
            if (Session["BillPaymentType"].ToString() != "")
            {
                if (Session["BillPaymentType"].ToString() == "BILLWISE")
                {
                    PaymentType = Session["BillPaymentType"].ToString();
                    clientcode = Session["PaymentClientCode"].ToString();
                    currencyCode = Session["BillWiseCurrencyCode"].ToString();
                }
            }
        }
        else if (Session["InvoicePaymentType"] != null)
        {
            if (Session["InvoicePaymentType"].ToString() != "")
            {
                if (Session["InvoicePaymentType"].ToString() == "INVOICEWISE")
                {
                    PaymentType = Session["InvoicePaymentType"].ToString();
                    clientcode = Session["MultiplePaymentClientCode"].ToString();
                    currencyCode = Session["InvoiceWiseCurrencyCode"].ToString();
                }
            }

            objClientReceipt.Amount = Convert.ToDecimal(txtCashAmount.Text);
            //objClientReceipt.BankName = "ICICI";
            objClientReceipt.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.CreatedBy = LID;
            objClientReceipt.Mode = "Online";
            objClientReceipt.ReceiptDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.Remarks = remarks;
            objClientReceipt.SourceCode = clientcode;
            objClientReceipt.OrgID = OrgID;
            objClientReceipt.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            objClientReceipt.ModifiedBy = UID;
            objClientReceipt.ResponseCode = "0";
            objClientReceipt.ResponseMsg = "Successfully Paid form Advance";
            objClientReceipt.TransactionID = "0";
            objClientReceipt.AuthIDCode = "0";
            objClientReceipt.PaymentType = "CahAdvance";
            lstClientreceipt.Add(objClientReceipt);
            if (PaymentType == "BILLWISE")
            {
                if (Session["PaymentInvoiceID"] != null && Session["ClientID"] != null && Session["SelectedBillID"] != null)
                    if (Session["PaymentInvoiceID"].ToString() != "" && Session["ClientID"].ToString() != "" && Session["SelectedBillID"].ToString() != "")
                    {
                        {
                            InvoiceID = Convert.ToInt64(Session["PaymentInvoiceID"].ToString());
                            ClientID = Convert.ToInt64(Session["ClientID"].ToString());
                            string[] items = Session["SelectedBillID"].ToString().Split('^');
                            int count = items.Length;
                            for (int i = 0; i < count; i++)
                            {
                                LedgerInvoiceDetails objledger = new LedgerInvoiceDetails();
                                objledger.InvoiceDetailsID = Convert.ToInt64(items[i]);
                                objledger.ClientId = ClientID;
                                objledger.PaymentMode = PaymentType;
                                objledger.InvoiceId = InvoiceID;
                                objledger.OrgID = OrgID;
                                objledger.CurrencyCode = currencyCode;
                                objledger.UsedAdvanceAmount = Convert.ToDecimal(txtAdvanceAmount.Text);
                                objledger.RemainingAdvanceAmount = Convert.ToDecimal(lblBalanceAdvance.Text);
                                objledger.IsSucceedTransaction = "Y";
                                objledger.IsAdvanceUsed = "Y";
                                lstClientReceiptDetail.Add(objledger);
                            }

                            if (lstClientreceipt.Count > 0 && lstClientReceiptDetail.Count > 0)
                            {
                                objInvoiceLedger_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientreceipt, lstClientReceiptDetail, out SuccessCode);
                                Session["PaymentClientCode"] = null;
                                Session["ClientPaymentAmount"] = null;
                                Session["ClientID"] = null;
                                Session["PaymentInvoiceID"] = null;
                                Session["SelectedBillID"] = null;
                                Session["BillPaymentType"] = null;
                                Session["BillWiseCurrencyCode"] = null;
                                Session["DueAdvanceAmount"] = null;
                                txtAdvanceAmount.Text = "";
                                txtAmount.Text = "";
                                txtCashAmount.Text = "";
                                divAdvanceProceed.Style.Add("display", "none");
                                Response.Redirect("../Ledger/InvoicePayment.aspx");

                            }
                        }

                    }
            }
            else if (PaymentType == "INVOICEWISE")
            {

                if (Session["MultiplePaymentInvoiceID"] != null && Session["MultipleInvoiceClientID"] != null)
                {
                    if (Session["MultiplePaymentInvoiceID"].ToString() != "" && Session["MultipleInvoiceClientID"].ToString() != "")
                    {
                        string items = Session["MultiplePaymentInvoiceID"].ToString();
                        lstClientReceiptDetail = serilize.Deserialize<List<LedgerInvoiceDetails>>(items);
                        //InvoiceID = Convert.ToInt64(Session["PaymentInvoiceID"].ToString());
                        ClientID = Convert.ToInt64(Session["MultipleInvoiceClientID"].ToString());
                        if (lstClientReceiptDetail.Count > 0)
                        {
                            lstClientReceiptDetail = lstClientReceiptDetail.Select
                                (ee =>
                                {
                                    ee.CurrencyCode = currencyCode; ee.UsedAdvanceAmount = Convert.ToDecimal(txtAmount.Text);
                                    ee.RemainingAdvanceAmount = Convert.ToDecimal(lblBalanceAdvance.Text);
                                    ee.IsSucceedTransaction = "Y"; ee.IsAdvanceUsed = "Y"; return ee;
                                }).ToList();
                        }

                        foreach (var item in lstClientReceiptDetail)
                        {

                            ClientReceipt objClientReceiptInvoiceList = new ClientReceipt();
                            objClientReceiptInvoiceList.ReceiptID = Convert.ToInt64(item.InvoiceId);
                            objClientReceiptInvoiceList.Amount = lstClientreceipt[0].Amount;
                            objClientReceiptInvoiceList.CreatedAt = lstClientreceipt[0].CreatedAt;
                            objClientReceiptInvoiceList.CreatedBy = lstClientreceipt[0].CreatedBy;
                            objClientReceiptInvoiceList.Mode = lstClientreceipt[0].Mode;
                            objClientReceiptInvoiceList.ReceiptDate = lstClientreceipt[0].ReceiptDate;
                            objClientReceiptInvoiceList.Remarks = lstClientreceipt[0].Remarks;
                            objClientReceiptInvoiceList.SourceCode = lstClientreceipt[0].SourceCode;
                            objClientReceiptInvoiceList.OrgID = lstClientreceipt[0].OrgID;
                            objClientReceiptInvoiceList.ModifiedAt = lstClientreceipt[0].ModifiedAt;
                            objClientReceiptInvoiceList.ModifiedBy = lstClientreceipt[0].ModifiedBy;
                            objClientReceiptInvoiceList.ResponseCode = lstClientreceipt[0].ResponseCode;
                            objClientReceiptInvoiceList.ResponseMsg = lstClientreceipt[0].ResponseMsg;
                            objClientReceiptInvoiceList.PaymentReceiptNo = lstClientreceipt[0].PaymentReceiptNo;
                            objClientReceiptInvoiceList.TransactionID = lstClientreceipt[0].TransactionID;
                            objClientReceiptInvoiceList.AuthIDCode = lstClientreceipt[0].AuthIDCode;
                            lstClientreceiptInvoiceList.Add(objClientReceiptInvoiceList);
                        }
                        if (lstClientreceiptInvoiceList.Count > 0 && lstClientReceiptDetail.Count > 0)
                        {
                            objInvoiceLedger_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientreceiptInvoiceList, lstClientReceiptDetail, out SuccessCode);
                            Session["MultiplePaymentInvoiceID"] = null;
                            Session["MultipleInvoiceClientID"] = null;
                            Session["MultiplePaymentClientCode"] = null;
                            Session["MultipleInvoicePaymentAmount"] = null;
                            Session["MultipleInvoiceClientID"] = null;
                            Session["MultiplePaymentInvoiceID"] = null;
                            Session["InvoicePaymentType"] = null;
                            Session["InvoiceWiseCurrencyCode"] = null;
                            Session["DueAdvanceAmount"] = null;
                            txtAdvanceAmount.Text = "";
                            txtAmount.Text = "";
                            txtCashAmount.Text = "";
                            divAdvanceProceed.Style.Add("display", "none");
                            Response.Redirect("../Ledger/InvoicePayment.aspx");

                        }
                    }
                    //SaveClientReceipt(lstClientreceipt);
                    Session["MultipleInvoicePaymentAmount"] = "";

                }
            }
        }

    }




}
