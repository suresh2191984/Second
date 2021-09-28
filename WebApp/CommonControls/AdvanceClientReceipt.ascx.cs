using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using System.Text;
using Attune.Utilitie.Helper;
public partial class CommonControls_AdvanceClientReceipt : BaseControl
{
    protected string _ClientName = "";
    public string ClientName
    {
        get { return _ClientName; }
        set { _ClientName = value; }
    }

    protected string _PaidDate = "";
    public string PaidDate
    {
        get { return _PaidDate; }
        set { _PaidDate = value; }
    }
    protected string _ReceiptNo = "";
    public string ReceiptNo
    {
        get { return _ReceiptNo; }
        set { _ReceiptNo = value; }
    }
    protected string _ReceiptType = "";
    public string ReceiptType
    {
        get { return _ReceiptType; }
        set { _ReceiptType = value; }
    }
    protected string _ReceiptModel = "";
    public string ReceiptModel
    {
        get { return _ReceiptModel; }
        set { _ReceiptModel = value; }
    }
    protected string _Amount = "0";

    public string Amount
    {
        get { return _Amount; }
        set { _Amount = value; }
    }
    protected string _Duplicate = "N";

    public string Duplicate
    {
        get { return _Duplicate; }
        set { _Duplicate = value; }
    }

    public string patientNumberDue { get; set; }
    public long ClientID { get; set; }
    public long VisitID { get; set; }
    public long InterMedID { get; set; }
    public string sType { get; set; }
    public string LabNo { get; set; }
    public long pClientID = -1;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    BillingEngine billingBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                long.TryParse(Request.QueryString["ClientID"], out pClientID);

                 if (_ReceiptType == "0")
                 {
                     tdReceiptType.InnerText = "Deposit Receipt";
                 }
                 else if (_ReceiptType == "1")
                 {
                     tdReceiptType.InnerText = "Advance Receipt";
                 }
                 else
                 {
                     tdReceiptType.InnerText = "";
                 }
                
                //lblReceiptNo.Text = Request.QueryString["rcptno"].ToString();
                 lblReceiptNo.Text = ReceiptNo;
                
                //lblClientName.Text = Request.QueryString["ClientName"].ToString();
                 lblClientName.Text = ClientName;
                lblClienttype.Text = "Client";
                lblClientName1.Text = ClientName;
                //lblClientName1.Text = Request.QueryString["ClientName"].ToString();
                if (Request.QueryString["DDate"].ToString() != null || Request.QueryString["DDate"].ToString() != "")
                {
                    DateTime d = Convert.ToDateTime(Request.QueryString["DDate"].ToString());
                    lblInvoiceDate.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                    lblInvoiceDate1.Text = d.ToString("dd/MM/yyyy hh:mm tt");
                }
                
                if (Request.QueryString["DAmount"].ToString() != null || Request.QueryString["DAmount"].ToString() != "")
                {
                    decimal TotalDepositAmount = Convert.ToDecimal (Request.QueryString["DAmount"].ToString());

                    lblDepositedAmount.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
                    lblAmountRecieved.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
                    lblTotal.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
                    NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                    lblAmount.Text =   Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " +  " Rupees Only";
                }
                /*Code Added by Syed*/
                if (Request.QueryString["Rtype"].ToString() != null || Request.QueryString["Rtype"].ToString() != "")
                {
                    Rs_AmountReceived.Text = "Amount Refunded";
                    lblpayType.Text = "Refunded Date";
                    lblAmount1.Text = "Amount Refunded";
                    Rs_Date.Text = "Refunded Date"; 
                    tdReceiptType.InnerText = "Advance Refund Receipt";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    public void SetBillDetails()
    {
        List<PaymentType> lstPaymentType = new List<PaymentType>();
        List<PaymentType> lstOtherCurrency = new List<PaymentType>();
        List<PaymentType> lstDepositAmt = new List<PaymentType>();
        int payingPage = 4;
        billingBL = new BillingEngine(base.ContextInfo);
        billingBL.GetPaymentMode(0, 0, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
        decimal depamt = 0;
        string appString = string.Empty;
        int flag = 0;
        for (int i = 0; i < lstPaymentType.Count; i++)
        {
            if (flag == 0)
            {
                appString = lstPaymentType[i].PayDetails + "<br>";
            }
            else
            {
                appString = appString + lstPaymentType[i].PayDetails + "<br>";
            }
            flag++;

        }
        
        //if (lstBillingDetails.Count > 0)
        //{
        //    appString = appString + lstBillingDetails[0].PaymentName + "<br>";
        //    lblPaidDate.Text = lstBillingDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
        //    lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        //}
        //if (lstDepositAmt.Count > 0)
        //{
        //    lblDepositAmtUsed.Visible = true;
        //    lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
        //    depamt = lstDepositAmt[0].AmountUsed;

        //}
        lblPaymentMode.Text = appString;
        hdnpaymode.Value = appString;
    }
    
}
