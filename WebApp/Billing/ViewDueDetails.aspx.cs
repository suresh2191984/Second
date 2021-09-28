using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;

public partial class Billing_ViewDueDetails : BasePage
{
    long visitID = -1;
    string pageid = string.Empty;
    List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
    string pagename = string.Empty;
    long patientID = -1;
    string physicianName = string.Empty;
    string splitstatus = string.Empty;
    decimal amtReceived = 0;
    decimal amtRefunded = 0;
    decimal dChequeAmount = 0;
    string BillNo = string.Empty;
    string patientNumber = string.Empty;
    string patientName = string.Empty;
    long PatientDueID = 0;
    string BillNumber = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadOrgHeader();
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        if (Request.QueryString["PNO"] != null)
        {
            patientNumber = Convert.ToString(Request.QueryString["PNO"]);
        }
        if (Request.QueryString["Bno"] != null)
        {
            BillNo = Convert.ToString(Request.QueryString["Bno"]);
        }
        if (Request.QueryString["PNam"] != null)
        {
            patientName = Request.QueryString["PNam"];
        }
        if (Request.QueryString["DueID"] != null)
        {
            PatientDueID = Convert.ToInt64(Request.QueryString["DueID"]);
        }
        if (Request.QueryString["FBNo"] != null)
        {
            BillNumber = Convert.ToString(Request.QueryString["FBNo"]);
        }
        long FinalBillID = 0;
        Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
        LoadBillInfo(FinalBillID);

    }

    private void LoadBillInfo(long FinalBillID)
    {
        try
        {

            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            BillingEngine billingBL = new BillingEngine(new BaseClass().ContextInfo);
            List<PatientQualification> lstQualification = new List<PatientQualification>();
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalBillID, out lstTax, out splitstatus, out lstQualification);


            lblPatientNumber.Text = lstPatientDetails[0].PatientNumber;
            lblInvoiceDate.Text = DateTime.Today.ToString("dd/MMM/yyyy");
            lblTitleName.Text = lstPatientDetails[0].TitleName;
            lblName.Text = lstPatientDetails[0].Name;
            lblAge.Text = lstPatientDetails[0].Age;
            lblSex.Text = lstPatientDetails[0].SEX;
            lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString();

            BillingEngine BE = new BillingEngine(new BaseClass().ContextInfo);
            List<PatientDueDetails> lstdueDetails = new List<PatientDueDetails>();

            BE.PatientDueResult(patientID, BillNumber, out lstdueDetails);

            var lstNew = from lst in lstdueDetails
                         group lst by lst.PatientID into g
                         select new
                         {
                             Description = "Due Collection",
                             Due = g.Sum(t => t.DueAmount),
                             Paid = g.Sum(t => t.DuePaidAmt)
                         };

            gvResult.DataSource = lstNew;

            gvResult.DataBind();

            //lblGrossAmount.Text = lstdueDetails[0].DueAmount.ToString();
            lblGrossAmount.Text = lstNew.First().Due.ToString();
            
            //lblAmountRecieved.Text = lstDuePaidDetails[0].PaidAmount.ToString();
            //lblCurrentVisitDueText.Text =(Convert.ToDecimal(lblGrandTotal.Text)).ToString();
            lblDueAmounttxt.Text = (lstNew.First().Due-lstNew.Last().Paid).ToString();
            
            List<PaymentType> lstPaymentType = new List<PaymentType>();
            List<PaymentType> lstOtherCurrency = new List<PaymentType>();
            string appString = string.Empty;
            //billingBL.GetPaymentMode(FinalBillID, visitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
            billingBL.GetDuePaymentMode(FinalBillID, OrgID, out lstPaymentType, out lstOtherCurrency);
            lblServiceCharge.Text = lstOtherCurrency[0].AmountUsed.ToString();
            lblGrandTotal.Text = (Convert.ToDecimal(lblGrossAmount.Text)+ Convert.ToDecimal(lblServiceCharge.Text)).ToString();
            //lstFinalBillDetail --[lstDuePaidDetails.Count - 1]

            lblAmountRecieved.Text = (lstOtherCurrency[0].OtherCurrencyAmount + Convert.ToDecimal(lblServiceCharge.Text)).ToString();
            if (lstPaymentType.Count > 0)
            {
                lblPayment.Visible = true;
                lblPaymentMode.Text = lstPaymentType[0].PaymentName;
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
            }
            //else
            //{
            //    lblPayment.Visible = false;
            //}

            lblPaymentMode.Text = appString;
            NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
            if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
            {
                lblDisplayAmount.Text = "Amount Received in Words:" + lstOtherCurrency[0].CurrencyName;
                if (int.Parse(lblAmountRecieved.Text.Split('/')[0].ToString().Split('.')[1]) > 0)
                {
                    lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0]))+ " "+ MinorCurrencyName + " Only";
                }
                else
                {
                    lblAmount.Text = num.Convert(lblAmountRecieved.Text.Split('/')[0]) + " Only";
                }
            }
            else
            {
                lblAmount.Text = " Zero Only";
            }
            if (lblDueAmounttxt.Text != "")
            {
                if (Convert.ToDouble(lblDueAmounttxt.Text) > 0)
                {
                    lblDueAmountinWords.Text = "Due Amount in Words:" + lstOtherCurrency[0].CurrencyName;
                    if (int.Parse(lblDueAmounttxt.Text.Split('.')[1]) > 0)
                    {
                        lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblDueAmounttxt.Text)) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                        lblDueAmount.Text = num.Convert(lblDueAmounttxt.Text) + " Only";
                    }
                }
            }
            else
            {
                lblDueAmount.Text = " Zero Only";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occurred while loading LoadBillInfo() in ViewDueDetails.aspx", ex);
        }

    }

    public void LoadOrgHeader()
    {
        try
        {
            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;

            iBillGroupID = (int)ReportType.OPBill;
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
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
            
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occurred while loading LoadOrgHeader() in ViewDueDetails.aspx", ex);
        }
    }
}