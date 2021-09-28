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

public partial class CommonControls_PharmacyDueReceipt : BaseControl
{
    protected string _PatientName = "";
    public string PatientName
    {
        get { return _PatientName; }
        set { _PatientName = value; }
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
    public long PatientID { get; set; }
    public long VisitID { get; set; }
    public long InterMedID { get; set; }
    public string sType { get; set; }
    public long pvid = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
         
        if (!IsPostBack)
        {
            long.TryParse(Request.QueryString["VID"], out pvid);
            if (_ReceiptType=="Deposit")
            {
            tdReceiptType.InnerText = "Deposit Receipt";
            dvAdvance.InnerText = "Deposit Payment";
            }

            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");

            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.Receipt;

            //Need Header In IPReceipt Print Page
            string strConfigKey = "NeedHeaderInIPR";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            if (configValue == "Y")
            {
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                    if (lstConfig[0].ConfigValue.Trim() != "")
                    {
                        imgBillLogo.Visible = true;
                    }
                    else
                    {
                        imgBillLogo.Visible = false;
                    }
                }
                else
                {
                    imgBillLogo.Visible = false;
                }


                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
                }

                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
                }
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {
                    lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
                }
            }

            //---------------------------------------------------------------------------------------------
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Width = lstConfig[0].ConfigValue.Trim();
            }
        }
    }

    public void SetBillDetails()
    {
        lblName.Text = PatientName;
        lblAmountRecieved.Text = Amount;
        lblReceiptNo.Text = ReceiptNo;
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        if (Convert.ToDouble(lblAmountRecieved.Text) > 0)
        {
            if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
            {
                lblAmount.Text = "" + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " + MinorCurrencyName + " Only...";
            }
            else
            {
                lblAmount.Text = "" + num.Convert(lblAmountRecieved.Text) + " Only...";
            }
        }
        else
        {
            lblAmount.Text = " Zero Only...";
        }
        if (Request.QueryString["BBY"] != null)
        {
            string BilledBy = string.Empty;
            BilledBy = Request.QueryString["BBY"].ToString();
            lblBilledBy.Text = ("Billed By: (" + BilledBy + ")").ToUpper();
        }
        else
        {
            lblBilledBy.Text = ("Billed By: (" + UserName + ")").ToUpper();
        }
        lblPaidDate.Text = PaidDate;
        List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        long returnCode = gateWay.GetConfigDetails("ShowDisclaimer", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            if (lstConfig[0].ConfigValue.ToLower() == "n")
            {
                dvDisclaimer.Visible = false;
            }
            else
            {
                dvDisclaimer.Visible = true;
            }
        }
        lstConfig = new List<Config>();
        gateWay = new GateWay(base.ContextInfo);
        returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblCurrency.Text = lstConfig[0].ConfigValue;
        }
        else
        {
            lblCurrency.Text = CurrencyName;
        }
        if (sType.ToUpper() == "IPPAYMENTS")
        {
            BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
            
            List<Patient> lstPatient = new List<Patient>();
            objBillingBL.GetReceiptDetails(VisitID, PatientID, OrgID, InterMedID,ReceiptNo,ReceiptModel, out lstBillingDetails, out lstPatient);
            //gvIndents.DataSource = lstBillingDetails;
            //gvIndents.DataBind();

            var lstDetails = (from lstbills in lstBillingDetails
                              select ((lstbills.Amount) * (lstbills.Quantity))).Sum();
            dvDetails.Visible = true;
            lblTotal.Text = ((decimal)lstDetails).ToString("0.00");
            dvAdvance.Visible = false;
            lblName.Text = lstPatient[0].Name.Trim();
            if (lstBillingDetails.Count > 0)
            {
                lblRefPhy.Text = lstBillingDetails[0].RefPhyName;
            }
            if (lblRefPhy.Text == "")
            {
                divref.Visible = false;
                lblRefPhy.Visible = false;
                lblrefPhyH.Visible = false;
            }
            else
            {
                lblRefPhy.Text = "Dr. " + lstBillingDetails[0].RefPhyName;
                lblRefPhy.Visible = true;
                lblrefPhyH.Visible = true;
            }
        }
        else
        {
            BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
            dvAdvance.Visible = true;
            List<DueClearanceReference> lstDueClearanceReference = new List<DueClearanceReference>();
            objBillingBL.GetCreditDueItem(VisitID, OrgID, PatientID, ReceiptNo, out lstDueClearanceReference);
            if (lstDueClearanceReference.Count > 0)
            {
                gvBillingDetail.DataSource = lstDueClearanceReference;
                gvBillingDetail.DataBind();
                lblTotal1.Text = lstDueClearanceReference[0].Total.ToString();
                lblTotal.Visible = false;
            }
            else
            {
                lblTotal.Visible = true;
            }
            dvDetails.Visible = false;
            dvAdvance.Visible = true;
            lblTotal.Text = lblAmountRecieved.Text;
            
            divref.Visible = false;
            lblRefPhy.Visible = false;
            lblrefPhyH.Visible = false;
        }

        #region for KMH Changes

         


        List<PaymentType> lstPaymentType = new List<PaymentType>();
        List<PaymentType> lstOtherCurrency = new List<PaymentType>();
        List<PaymentType> lstDepositAmt = new List<PaymentType>();
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        int payingPage = 2;
        
        
        long FinalbillID = 0;
        pvid = -1;
        long.TryParse(Request.QueryString["VID"], out pvid);

        billingBL.GetPaymentMode(FinalbillID, pvid, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
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
        if (lstDepositAmt.Count > 0)
        {
            //trDeposit.Attributes.Add("display", "block");
            lblDepositAmtUsed.Visible = true;
            lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
            depamt = lstDepositAmt[0].AmountUsed;
        }
        if (lstOtherCurrency.Count > 0)
        {
            if (lstOtherCurrency[0].CurrencyName != null && lstOtherCurrency[0].OtherCurrencyAmount != null)
            {

                if (int.Parse(lstOtherCurrency[0].OtherCurrencyAmount.ToString("0.00").Split('.')[1]) > 0)
                {
                    lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(lstOtherCurrency[0].OtherCurrencyAmount.ToString("0.00"))) + " " + MinorCurrencyName + " Only...";
                }
                else
                {
                    lblPayingCurrencyinWords.Text = num.Convert(lstOtherCurrency[0].OtherCurrencyAmount.ToString("0.00")) + " Only...";
                }
                lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + lstOtherCurrency[0].OtherCurrencyAmount.ToString("0.00");
                lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";

                //lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + " Only...";
                 
            }
          
        }
        lblPaymentMode.Text = appString;
        //lblPayMode.InnerHtml = appString;
        #endregion
        
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

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

}
