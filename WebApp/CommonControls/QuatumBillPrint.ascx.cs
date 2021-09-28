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
using NumberToWord;
using System.Text;
using System.Collections.Specialized;
using Attune.Utilitie.Helper;
using Attune.Cryptography;

public partial class CommonControls_QuatumBillPrint : BaseControl
{
    string SuburbanPrintFormat = string.Empty;
    string Amount = string.Empty;
    string isDBill = string.Empty;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    int strChatLimit = 35;
    public bool isDynamicPrint { get; set; }
    int LineFooterLimit = 3;
    List<Config> lstConfigList = new List<Config>();
    List<Config> lstConfig = new List<Config>();
    string IsCreditPatient = string.Empty;
    public string IsFullBill { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            isDBill = Request.QueryString["isDbill"];
            if (lblLoginName.Text == "")
            {
                userHide.Attributes.Add("style", "display:none");
            }
            if (lblPassword.Text == "")
            {
                passwordHide.Attributes.Add("style", "display:none");
            }
        }
    }


    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        //List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        if (lstConfigList.Count == 0)
        {
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfigList);
        }
        int nConfigElements = lstConfigList.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfigList[nCnt].ConfigValue.Split('^');
            if (sTempConfigElements != null && sTempConfigElements.Length == 2)
            {
                oNV.Add(sTempConfigElements[0], sTempConfigElements[1]);
            }
        }
        for (int nCnt = 0; nCnt < oNV.Count; nCnt++)
        {
            switch (oNV.GetKey(nCnt))
            {
                case "Header Logo":
                    imgBillLogo.ImageUrl = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                    break;
                case "Header Font":
                    lblHospitalName.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Font Size":
                    lblHospitalName.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Content":
                    lblHospitalName.InnerHtml = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                case "Contents Font":
                    tblBillPrint.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblBillPrint.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblBillPrint.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblBillPrint.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;

                   
            }
        }
    }
    #endregion
    public void BillPrinting(long visitID, long FinalbillID, int pdp)
    {
        try
        {

            string IsRoundOff = string.Empty;
            IsRoundOff = GetConfigValue("PatientCommonRoundOffPattern", OrgID);
            if (String.IsNullOrEmpty(IsRoundOff))
            {
                hdnIsRoundOff.Value = "ON";
            }
            else
            {
                hdnIsRoundOff.Value = "OFF";
            }
            int serviceFlag = 0;
            string LabNo = Convert.ToString(Request.QueryString["Labno"]);
            string physicianName = string.Empty;
            string splitstatus = string.Empty;
            string discountpercent = string.Empty;
            decimal amtReceived = 0;
            decimal amtRefunded = 0;
            decimal dChequeAmount = 0;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            List<OrderedInvestigations> lstOrderInv = new List<OrderedInvestigations>();
            if (Request.QueryString["isFB"] != null && Request.QueryString["isFB"].ToString() == "Y")
            {
                base.ContextInfo.AdditionalInfo = "FULLBILL";
            }
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<PatientQualification> lstQualification = new List<PatientQualification>();
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus, out lstQualification);

            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, FinalbillID, 0);
             


            

            if (amtRefunded > 0)
            {
                lblrefundamt.Visible = true;
                lblrefundamt.Text = "Amount Refunded to the patient: Rs." + amtRefunded.ToString() + " Only";
            }
 
            if (lstBillingDetail.Count > 0)
            {
                if (pdp == 1)
                {
                    //Added By Arivalagan.KK Display duplicate bill print//
                    tdDupBill.Style.Add("display", "table-cell");
                    lblDupBill.Visible = true;
                }
                else
                {
                    lblDupBill.Visible = false;
                }
                // Bind Billing details
                long vpur;
                Int64.TryParse(Request.QueryString["visitPur"], out vpur);
                string clientName = string.Empty;
                clientName = Request.QueryString["ClientName"];
                if (splitstatus == "CGHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantCGHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else if (splitstatus == "DGEHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantDGEHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else
                {

                    gvBillingDetail.DataSource = lstBillingDetail;
                    gvBillingDetail.DataBind();

                }


                Int64.TryParse(Request.QueryString["bid"], out FinalbillID);

                if (FinalbillID == 0)
                {
                    if (gvBillingDetail.Rows.Count > 0)
                    {
                        gvBillingDetail.Columns[1].Visible = true;
                        lblInvoiceNo.Visible = false;
                        Rs_BillNo.Visible = false;
                    }
                }
                else
                {
                    if (gvBillingDetail.Rows.Count > 0)
                    {
                        gvBillingDetail.Columns[1].Visible = false;
                    }
                }

                string isDueBill = "N";
                string isCreditBill = string.Empty;
                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                    if (lstBillingDetail[i].ServiceCode != "" && lstBillingDetail[i].ServiceCode != null)
                    {
                        serviceFlag = 1;
                    }

                }
                string Orgdue = String.Empty;
                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].AttributeDetail != "")
                    {
                        Orgdue = "Y";
                    }
                    else
                    {
                        Orgdue = "N";
                    }
                }
                if (lstBillingDetail[0].WriteOffAmt > 0)
                {
                    trwriteoff.Style.Add("display", "table-row");
                    lblCurrentWriteOff.Text = lstBillingDetail[0].WriteOffAmt.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                }
                else
                {
                    trwriteoff.Style.Add("display", "none");
                }

                //This below code is used to show and hide Service cdoe column in Grid added by suresh

                if (serviceFlag == 1)
                {
                   
                    gvBillingDetail.Columns[4].Visible = true;
                }
                else
                {
                  
                    gvBillingDetail.Columns[4].Visible = false;
                }
                //End


                List<Config> lstConfig = new List<Config>();
                GateWay gateWay = new GateWay(base.ContextInfo);
                long returnCode = gateWay.GetConfigDetails("SuburbanPrintBillFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {

                    SuburbanPrintFormat = lstConfig[0].ConfigValue.ToUpper();

                    if (SuburbanPrintFormat == "Y" && lstFinalBillDetail[0].IsCreditBill == "Y")
                    {
                        gvBillingDetail.Columns[3].Visible = false;                     
                        gvBillingDetail.Columns[5].Visible = false;
                        gvBillingDetail.Columns[6].Visible = false;
                        gvBillingDetail.Columns[7].Visible = false;
                    }
                    

                }

                

                string Qualification = string.Empty;
                if (lstQualification.Count > 0)
                {
                    Qualification = lstQualification[0].MetaTypeID.ToString();
                    lblQualification.Text = Qualification;
                }
                if (lstPatientDetails.Count > 0)
                {
                    lblName.Text = lstPatientDetails[0].Name;
                    //lblTitleName.Text = lstPatientDetails[0].TitleName;
                    //  lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();

                    if (lstPatientDetails[0].URNO == "")
                    {
                        if (lstPatientDetails[0].SEX == "M")
                            lblSex.Text = "Male";
                        else
                            lblSex.Text = "Female";
                    }
                    else
                    {
                        if (lstPatientDetails[0].SEX == "M")
                            lblSex.Text = lstPatientDetails[0].URNO + "/" + "Male";
                        else
                            lblSex.Text = lstPatientDetails[0].URNO + "/" + "Female";

                    }
                    if (lstPatientDetails[0].MobileNumber != "")
                        lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber;

                    if (!string.IsNullOrEmpty(lstPatientDetails[0].MobileNumber))
                    {
                        Rs_PatPhoneNo.Text = "Contact No";
                        lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber;
                    }
                    else if (!string.IsNullOrEmpty(lstPatientDetails[0].LandLineNumber))
                    {
                        Rs_PatPhoneNo.Text = "Contact No";
                        lblPatPhoneNumber.Text = lstPatientDetails[0].LandLineNumber;
                    }
                    else
                    {
                        Rs_PatPhoneNo.Text = "Contact No";
                        lblPatPhoneNumber.Text = "-";
                    }
                    lblPhy.Text = "Ref Doctor";
                    lblRefHos.Text = "Ref Centre";

                    if (!string.IsNullOrEmpty(lstPatientDetails[0].ReferedHospitalName))
                    {
                        lblReferringHos.Text = lstPatientDetails[0].ReferedHospitalName;
                    }
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].TPAName) && lstPatientDetails[0].TPAName!="GENERAL")
                    {
                        lblRefClient.Text = lstPatientDetails[0].TPAName;
                    }

                    //if (!string.IsNullOrEmpty(lstPatientDetails[0].VersionNo))
                    //{
                    //    lblVisitNumber.Text = lstPatientDetails[0].VersionNo.ToString();
                    //    lblVisitNumber.Visible = false;
                    //}
                    //---------------------- Sathish.e-------------------//
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].ExternalVisitID))
                    {
                        lblVisitNumber.Text = lstPatientDetails[0].ExternalVisitID.ToString();
                        lblVisitNumber.Visible = false;
                    }
                    //--------------------End------------------------------//
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].EMail))
                    {
                        lblEmailADD.Text = lstPatientDetails[0].EMail.ToString();
                    }
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].LoginName))
                    {
                        lblLoginName.Text = lstPatientDetails[0].LoginName.ToString();
                    }
                    string EncryptedPassword = string.Empty;
                    string DecryptedPassword = string.Empty;
                    if (!string.IsNullOrEmpty(lstPatientDetails[0].Password))
                    {
                        EncryptedPassword = lstPatientDetails[0].Password;
                        CCryptography objDecryptor = new CCryptFactory().GetDecryptor();
                        objDecryptor.Crypt(EncryptedPassword, out DecryptedPassword);
                        lblPassword.Text = DecryptedPassword;

                    }
                }
               
                  
            

                // Bind Final Bill detail
                IsFullBill = lstFinalBillDetail[0].VersionNo;

                lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString().Trim();

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("ShowDate_WithTime_BillPrint_Ascx", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yyyy");
                }

                
                
                  
               
                    lblPhysician.Text = lstPatientDetails[0].ReferingPhysicianName; // Show Referring Physician name in the header
                  
                    // Code modified by Vijay TV on 16-Feb-2011 for Bug tracker ID 785 ends
                
                if (IsFullBill == "Y")
                {

                  
                    lblInvoiceNo.Text = lstBillingDetail[0].AttributeDetail.ToString();
                 
                    if (lstPatientDetails[0].ReferedHospitalName != "")
                    {
                        trduedot.Visible = true;
                    }
                    else
                    {
                        trduedot.Visible = false;
                    }
                }
                else
                {
                    if (lstPatientDetails[0].ReferedHospitalName != "")
                    {
                        trduedot.Visible = true;
                    }
                    else
                    {
                        trduedot.Visible = false;
                    }

                    lblVisitNumber.Visible = true;
                    //----------Sathish.E----------------------------//
                    lblVisitNumber.Text = lstPatientDetails[0].ExternalVisitID;
                   // lblVisitNumber.Text = lstPatientDetails[0].VersionNo;
                    //--------------Sathish.E----------------------------//
                    trduedot.Visible = true;
                }

                

                if (lstFinalBillDetail[0].DiscountAmount > 0)
                {
                    decimal discountPercentage = Convert.ToDecimal((lstFinalBillDetail[0].DiscountAmount / lstFinalBillDetail[0].GrossBillValue) * 100);
                    decimal r = Math.Round(discountPercentage);
                    lblDiscountPercent.Text = lblDiscountPercent.Text + " (" + r.ToString() + "%" + ")";
                    trDiscount.Attributes.Add("display", "table-row");
                    lblDiscount.Text = lstFinalBillDetail[0].DiscountAmount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    hdnDiscount.Value = "1";
                }
                  decimal sum = lstFinalBillDetail[0].GrossBillValue;
                  lblGrossAmount.Text = sum.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                  if (lstFinalBillDetail[0].DiscountAmount > 0)
                  {
                      decimal NetValue = 0;
                      NetValue = (lstFinalBillDetail[0].GrossBillValue - lstFinalBillDetail[0].DiscountAmount);
                      lblNetValue.Text = NetValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                      hdfRoundcalc.Value = "1";
                  }

                
                else
                {

                    lblNetValue.Text = lstFinalBillDetail[0].GrossBillValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    hdnRound.Value = lblNetValue.Text;
                    hdfRoundcalc.Value = "1";
                }

               
                               // ====================
               
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "validateround('" + sum.ToString() + "');", true);
                //lblGrossAmount.Text = hdnRoundOff.Value;
                //===================
              
                //lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);


                
                if (lstFinalBillDetail[0].TaxAmount > 0)
                {
                  
                    lblTaxAmount.Text = lstFinalBillDetail[0].TaxAmount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    hdnTaxAmount.Value = "1";
                }
                string IsTaxdisclaimer = string.Empty;
                IsTaxdisclaimer = GetConfigValue("Taxdisclaimer", OrgID);
                if (!String.IsNullOrEmpty(IsTaxdisclaimer))
                {
                    if (IsTaxdisclaimer == "Y")
                    {
                        if (lstPatientDetails[0].PayerID == 1)
                        {
                            // trTaxDetails.Attributes.Add("display", "block");
                            lblTaxDetails.Visible = true;
                            lblTaxDetails.Text = "*This amount is subject to " + lstFinalBillDetail[0].TaxPercent.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture) +"% GST";
                        }
                    }
                }

                if (lstFinalBillDetail[0].TaxAmount > 0)
                {
                    decimal GrossTotal = 0;
                    GrossTotal = Convert.ToDecimal(lblNetValue.Text) + Convert.ToDecimal(lblTaxAmount.Text);
                    lblGrandTotal.Text = GrossTotal.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    lblTaxAmounttxt.Text = "VAT(12%)";
                }
                else
                {
                    lblGrandTotal.Text = Convert.ToDecimal(lblNetValue.Text).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                }
                lblAmountRecieved.Text = lstFinalBillDetail[0].AmountReceived.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);

                if (lstFinalBillDetail[0].RemainDeposit > 0)
                {
                    RemainDeposit.Visible = true;
                    Label1.Visible = true;
                    RemainDeposit.Text = " " + (lstFinalBillDetail[0].RemainDeposit).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);

                }
                else
                {
                    RemainDeposit.Visible = false;
                    Label1.Visible = false;
                }
                if (lstFinalBillDetail[0].Due > 0)
                {
                    trDiscount.Attributes.Add("display", "table-row");
                    string DueAmmt = lstFinalBillDetail[0].Due.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    lblCurrentVisitDueText.Text = (DueAmmt);
                    hdnDue.Value = "1";
                }
                //lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                if (isDueBill != "Y" && lstFinalBillDetail[0].CurrentDue > 0)
                {
                    trPreviousDue.Attributes.Add("display", "none");
                    lblPreviousDue.Text = lstFinalBillDetail[0].CurrentDue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    hdnPreviousDue.Value = "1";
                }
                else
                {
                    if (lstFinalBillDetail[0].CurrentDue > 0)
                    {
                        trPreviousDue.Attributes.Add("display", "none");
                        lblPreviousDue.Text = lstFinalBillDetail[0].CurrentDue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                        hdnPreviousDue.Value = "1";
                    }
                    else
                    {
                        lblPreviousDue.Text = String.Format("{0:0.00}", "0");
                    }
                }
                
             
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
                    {
                        lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                      //  lblAmount.Text = num.Convert( lblAmountRecieved.Text.Split('.')[0]) + " Only";
                        lblAmount.Attributes.Add("display", "none");

                    }
                }
                else
                {
                   // lblAmount.Text = " Zero Only";
                    lblAmount.Attributes.Add("display", "none");


                }
                if (lblCurrentVisitDueText.Text != "")
                {
                    if (Convert.ToDouble(lblCurrentVisitDueText.Text) > 0)
                    {
                        if (int.Parse(lblCurrentVisitDueText.Text.Split('.')[1]) > 0)
                        {
                            lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            lblDueAmount.Text = num.Convert(lblCurrentVisitDueText.Text) + " Only";
                        }

                    }
                    if (lblCurrentVisitDueText.Text == "")
                    {
                        lblDueAmount.Attributes.Add("display", "none");
                        lblDueAmountinWords.Attributes.Add("display", "none");
                    }
                }

               

                #region for QUANTUM Changes

                if (lstFinalBillDetail[0].IsCreditBill == "Y")
                {
                    lblTypeBill.Text = "CREDIT BILL";
                }
                else if (lstFinalBillDetail[0].IsCreditBill != "Y" && (lblCurrentVisitDueText.Text != "0.00" && lblCurrentVisitDueText.Text != ""))
                {
                    lblTypeBill.Text = "DUE BILL";
                }
                else
                {
                    lblTypeBill.Text = "INVOICE";
                }
                if (lstFinalBillDetail[0].IsDiscountPercentage == "Y")
                {

                    decimal n;
                    n = (lstFinalBillDetail[0].DiscountAmount / (lstFinalBillDetail[0].GrossBillValue + lstFinalBillDetail[0].TaxPercent)) * 100;
                    if (hdnIsRoundOff.Value == "ON")
                    {
                        discountpercent = "(" + Math.Round(n) + "%)";
                    }
                    else
                    {
                        discountpercent = "(" + n + "%)";
                    }

                    lblDiscountPercent.Text = discountpercent;
                }
                string ReceiptNo = string.Empty;
                int payingPage = 1;
                decimal depamt = 0;
                List<PaymentType> lstPaymentType = new List<PaymentType>();
                List<PaymentType> lstOtherCurrency = new List<PaymentType>();
                List<PaymentType> lstDepositAmt = new List<PaymentType>();
                string appString = string.Empty;
                billingBL.GetPaymentMode(FinalbillID, visitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
                if (lstPaymentType.Count > 0)
                {
                    lblPayment.Visible = true;

                    int flag = 0;
                    for (int i = 0; i < lstPaymentType.Count; i++)
                    {
                        if (lstOtherCurrency.Count > 0)
                        {
                            for (int j = 0; j < lstOtherCurrency.Count; j++)
                            {
                                if (flag == 0)
                                {
                                    //Changed by Arivalagan.kk
                                    appString = lstPaymentType[i].PayDetails + "<br>";
                                    //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                    //appString = lstPaymentType[i].PaymentName + "-" + lstOtherCurrency[j].CurrencyName + "-" + lstOtherCurrency[j].OtherCurrencyAmount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture) + "<br>";
                                }
                                else
                                {
                                    //Changed by Arivalagan.kk
                                    appString = appString + lstPaymentType[i].PayDetails + "<br>";
                                    //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                    //appString = appString + lstPaymentType[i].PaymentName + "-" + lstOtherCurrency[j].CurrencyName + "-" + lstOtherCurrency[j].OtherCurrencyAmount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture) + "<br>";
                                }
                            }
                        }
                        flag++;

                    }
                }
                else
                {
                    lblPayment.Visible = false;
                }
                if (lstDepositAmt.Count > 0)
                {
                    //trDeposit.Attributes.Add("display", "block");
                    lblDepositAmtUsed.Visible = true;
                    lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    depamt = lstDepositAmt[0].AmountUsed;
                    lblPayment.Visible = true;
                }
                if (lstOtherCurrency.Count > 0)
                {
                    if (lstOtherCurrency[0].CurrencyName != null && lstOtherCurrency[0].OtherCurrencyAmount != null)
                    {
                        decimal othercuramt = 0, totothercuramt = 0;
                        decimal servicecharge = 0;


                        othercuramt = Convert.ToDecimal(lstOtherCurrency[0].OtherCurrencyAmount);
                        servicecharge = Convert.ToDecimal(lstFinalBillDetail[0].ServiceCharge);
                        servicecharge = servicecharge == null ? 0 : servicecharge;
                        totothercuramt = othercuramt + servicecharge + depamt;

                        //lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + totothercuramt.ToString();
                        lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";
                        //Label1.Text = "Remaining Deposit Amount : (" + lstOtherCurrency[0].CurrencyName + ")";

                        if (int.Parse(totothercuramt.ToString().Split('.')[1]) > 0)
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " " + MinorCurrencyName + " " + "Only";
                        }
                        else
                        {
                            lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + "Only";
                        }
                        trPayingCurrency.Attributes.Add("display", "table-row");
                        hdnPayingCurrency.Value = "1";


                    }
                    else
                    {
                        hdnPayingCurrency.Value = "0";
                    }
                }
                lblPaymentMode.Text = appString;
                //lblPayMode.InnerHtml = appString;
                #endregion

                ////long returnCode = -1;
                ////GateWay gateWay = new GateWay(base.ContextInfo);
                ////returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                ////if (lstConfig.Count > 0)
                ////{
                ////    lblDisplayAmount.Text = Resources.Defaults.Amount_Recd_In_Words + " (" + lstConfig[0].ConfigValue.ToString() + ") ";
                ////    lblDueAmountinWords.Text = Resources.Defaults.Amount_Due_In_Words + " (" + lstConfig[0].ConfigValue.ToString() + ") ";
                ////    Label1.Text = "Remaining Deposit Amount : (" + lstConfig[0].ConfigValue + ")";
                ////    decimal dec = 0.00m;
                ////    if (decimal.TryParse(lblCurrentVisitDueText.Text, out dec))
                ////    {
                ////        lblDueAmountinWords.Style.Add("display", (dec == decimal.Zero ? "none" : "block"));
                ////    }
                ////    else
                ////    {
                ////        lblDueAmountinWords.Style.Add("display", "none");
                ////    }
                ////}


                ////else
                ////{
                ////    lblDisplayAmount.Text = Resources.Defaults.Amount_Recd_In_Words + " (" + CurrencyName + ") ";
                ////    lblDueAmountinWords.Text = Resources.Defaults.Amount_Due_In_Words + " (" + CurrencyName + ") ";
                ////}
                if (lstFinalBillDetail[0].TATDate.ToString("dd/MM/yyyy") != "01/01/0001")
                {
                    trReportDate.Style.Add("display", "table-row");
                    //lblReportcommitDate.Text = "Please have your report collected at : " + "<b>" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MMM/yyyy");
                    // lblReportcommitDate.Text = "Please have your report collected at : " + "<b>" + lstFinalBillDetail[0].TATDate.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    trReportDate.Style.Add("display", "none");
                }
                //lblBilledBy.Text = ("Billed By: (" + UserName + ")").ToUpper();
                lblBilledBy.Text = ("Billed By: (" + lstBillingDetail[0].BilledBy + ")").ToUpper();


                //if (lstTax.Count > 0)
                //{
                //    dvTaxDetails.Visible = true;
                //    string sTableHTML = "<table width='100%'>";
                //    foreach (Taxmaster tm in lstTax)
                //    {
                //        if (tm.TaxAmount > 0)
                //        {
                //            sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + ((lstFinalBillDetail[0].GrossBillValue - lstFinalBillDetail[0].DiscountAmount) * (tm.TaxPercent / 100)).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture) +"<td/></tr>";
                //        }
                //    }

                //    sTableHTML += "</table>";
                //    dvTaxDetails.InnerHtml = sTableHTML;
                //}
                //else
                //{
                //    dvTaxDetails.Visible = false;
                //}




                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                // if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                
                #endregion

                ////sample print
                #region Modified Billing Print
                //List<Config> lstConfig = new List<Config>();
                int iBillGroupID = 0;
                string isDynamic = "N";
                iBillGroupID = (int)ReportType.OPBill;
                if (lstConfigList.Count == 0)
                {
                    new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, ILocationID, out lstConfigList);
                }
                if (lstConfigList.Count > 0)
                {
                    isDynamic = lstConfigList.Find(a => a.ConfigValue.Split('^')[0] == "Dynamic Print").ConfigValue.Split('^')[1].ToString();
                }
                if (isDynamic == "Y" && lstFinalBillDetail != null && lstFinalBillDetail.Count > 0)
                {
                    isDynamicPrint = true;
                    int ConfigCount = lstConfigList.Count;
                    string[] configKeyValue;
                    NameValueCollection Objnvc = new NameValueCollection();
                    for (int i = 0; i < ConfigCount; i++)
                    {
                        configKeyValue = lstConfigList[i].ConfigValue.Split('^');
                        if (configKeyValue != null & configKeyValue.Length == 2)
                        {
                            Objnvc.Add(configKeyValue[0], configKeyValue[1]);
                        }
                    }
                    for (int j = 0; j < Objnvc.Count; j++)
                    {
                        switch (Objnvc.GetKey(j))
                        {
                            case "Print_LineItem_Limit":
                                intLimit = Convert.ToInt32(Objnvc[j]) == 0 ? intLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                            case "Print_Char_Limit":
                                strChatLimit = Convert.ToInt32(Objnvc[j]) == 0 ? strChatLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                            case "Line_Footer_Limit":
                                LineFooterLimit = Convert.ToInt32(Objnvc[j]) == 0 ? LineFooterLimit : Convert.ToInt32(Objnvc[j]);
                                break;
                        }

                    }
                    StringBuilder objprint = new StringBuilder();
                    string TPAAttributess = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;
                    string TPAName = lstPatientDetails[0].TPAName.ToString();
                    string tpa = string.Empty;
                    string refphyName = lblPhysician.Text;
                    if (TPAAttributess != "" || TPAName != "")
                    {
                        tpa = "Client / Insurance Provider:" + (TPAAttributess + TPAName);
                    }
                    if (refphyName != "")
                    {
                        refphyName = "Ref. Physician Name:" + lblPhysician.Text;
                    }
                    if (pdp == 1)
                        lblTypeBill.Text = lblTypeBill.Text + "( Duplicate Copy)";


                    PrinterHelper.PrintStartAndEnd(ref objprint, "S");

                    objprint.Append("<table id='tblBill' width=100% border=0 cellspacing=0 cellpading=0>" +
                             "<tr>" +
                                "<td height=15 colspan=5 width=10% id='tdDisplay' align=center style=font-weight:bold;>" + lblTypeBill.Text + "</td>" +
                            "</tr> </table>");

                    PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());

                    objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                            "<tr>" +
                               "<td colspan=3 width=10%>" + refphyName + "</td>" +
                           "</tr>" +
                           "<tr>" +
                               "<td colspan=3 width=10%>" + tpa + "</td>" +
                           "</tr>"
                           + "</table>");
                    objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                            "<tr style=font-weight:bold;>" +
                               "<td width=10%>S.NO</td>" +
                               "<td width=50%>Description</td>" +

                               "<td width=20% align=right>Units </td>" +
                               "<td width=20% align=right>Amount </td>" +
                           "</tr> ");
                    string ItemValues = "";
                    int breakLineCount = 0;
                    string perPrintTest = "";
                    int tempLineItem = 0;
                    int pageNo = 1;
                    bool isFooterBreak = true;
                    int LastPageLimit = 0;
                    int NoPages = 0;
                    NoPages = Math.DivRem(lstBillingDetail.Count, intLimit, out LastPageLimit);

                    foreach (BillingDetails item in lstBillingDetail)
                    {
                        intCnt = intCnt + 1;
                        ItemValues = item.FeeDescription.ToWordWrap(strChatLimit, out breakLineCount);
                        if ((intLines + breakLineCount) > intLimit && breakLineCount != intLimit)
                        {
                            perPrintTest = "<tr>" +
                               "<td width=10%>" + intCnt + "</td>" +
                               "<td width=50%>" + ItemValues + "</td>" +

                               "<td width=20% align=right>" + item.Quantity + " </td>" +
                               "<td width=20% align=right>" + item.Amount.ToString("0.00") + " </td>" +
                           "</tr>";
                        }
                        else
                        {
                            objprint.Append("<tr>" +
                                "<td width=10%>" + intCnt + "</td>" +
                                "<td width=50%>" + ItemValues + "</td>" +

                                "<td width=20% align=right>" + item.Quantity + " </td>" +
                                "<td width=20% align=right>" + item.Amount.ToString("0.00") + " </td>" +
                            "</tr>");
                        }
                        if (intCnt != lstBillingDetails.Count || perPrintTest != "")
                        {
                            intLines = (intLines + breakLineCount) == intLimit ? (intLines + breakLineCount) + 1 : (intLines + breakLineCount);
                        }

                        if (isFooterBreak != false && LastPageLimit > 0 && LastPageLimit <= LineFooterLimit)
                        {
                            isFooterBreak = false;
                        }

                        if (intLines > intLimit)
                        {
                            if (intCnt <= lstBillingDetail.Count)
                            {
                                pageNo = pageNo + 1;
                                objprint.Append("</table><p style=\"page-break-before:always\"></p>");
                                objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                            "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");
                                PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());
                                tempLineItem = intLines;
                                intLines = 0;
                                objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
                            "<tr>" +
                               "<td height=30 colspan=3 width=10%>&nbsp;</td>" +

                           "</tr> </table>" +
                           "<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                             "<tr style=font-weight:bold;>" +
                                "<td width=10%>S.no</td>" +
                                "<td width=50%>Description</td>" +

                                "<td width=20% align=right>Quantity </td>" +
                                "<td width=20% align=right>Amount </td>" +
                            "</tr> "
                           );
                                if (perPrintTest != "")
                                {
                                    intLines = breakLineCount;
                                    objprint.Append(perPrintTest);
                                    perPrintTest = "";

                                }
                            }
                        }
                    }
                    objprint.Append("</table>");
                    if (isFooterBreak)
                    {
                        pageNo = pageNo + 1;
                        objprint.Append("<p style=\"page-break-before:always\"></p>");
                        objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                    "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");
                        PrinterHelper.PrintOPPatientDetails(ref objprint, lstPatientDetails[0].Name, lstPatientDetails[0].Age + "/" + lstPatientDetails[0].SEX, lstFinalBillDetail[0].BillNumber.ToString(), lstFinalBillDetail[0].CreatedAt.ToString(), lstPatientDetails[0].PatientNumber, lstBillingDetail[0].LabNo.ToString());
                    }
                    decimal NetValue = lstFinalBillDetail[0].NetValue;
                    string RecAmount;
                    if (hdnIsRoundOff.Value == "ON")
                    {
                        RecAmount = Math.Round(lstFinalBillDetail[0].AmountReceived).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    }
                    else
                    {
                        RecAmount = (lstFinalBillDetail[0].AmountReceived).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    }
                    string pUser = "";
                    string paymode = lblPaymentMode.Text;
                    string grossbill = lstFinalBillDetail[0].GrossBillValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    string AmtResceived = lblDisplayAmount.Text + lblAmount.Text;
                    string PayingCurrency = lblPayingCurrency.Text + lblPayingCurrencyinWords.Text;
                    string Dueamounttxt = lblDueAmountinWords.Text;
                    string Dueamt = lblDueAmount.Text;
                    string RemainDepo = RemainDeposit.Text;
                    if (lstBillingDetail.Count > 0)
                    {
                        pUser = "Billed By: (" + lstBillingDetail[0].BilledBy.ToUpper() + ")";
                    }


                    PrinterHelper.PrintOPAmountDetails(ref objprint, NetValue.ToString(), RecAmount, grossbill, paymode,
                        (lblTaxAmount.Text).ToString(), (lblDiscount.Text).ToString(),
                        (lblRoundOff.Text).ToString(), "",
                    discountpercent, lblCurrentVisitDueText.Text, lblNetValue.Text, AmtResceived,
                    PayingCurrency, pUser, Dueamounttxt, Dueamt, RemainDepo, depamt.ToString());

                    PrinterHelper.PrintStartAndEnd(ref objprint, "E");
                    tdPrint.InnerHtml = objprint.ToString();
                }
                #endregion

                
                
            }

            else
            {
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There is no Bill for this Patient";
                tblBillPrint.Visible = false;
            }

            //---------------------------shobana---------------------------//

            IsCreditPatient = GetConfigValue("DontShowAmtForCreditPatient", OrgID);
            if (IsCreditPatient != null || IsCreditPatient != "")
            {
                if ((lstFinalBillDetail[0].IsCreditBill == "Y") && (IsCreditPatient == "Y") && (!string.IsNullOrEmpty(lstBillingDetail[0].IsOutSource)))
                {
                    AmountPayDetails.Style.Add("display", "none");
                    PaymentModeDetails.Style.Add("display", "none");
                    TaxDueDetails.Style.Add("display", "none");
                    foreach (DataControlField col in gvBillingDetail.Columns)
                    {
                        if (col.HeaderText == "Amount")
                        {
                            col.Visible = false;
                        }
                    }

                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
    public string getprinter()
    {
        return tdPrint.InnerHtml;
    }
    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GateWay gateWay = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        long returnCode = gateWay.GetConfigDetails("Amount(Rs)", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            if (lstConfig[0].ConfigValue.ToUpper() == "Y")
            {
                Amount = "Amount(Rs)";
            }

        }
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Amount == "Amount(Rs)")
            {
                //e.Row.Cells[4].Text = "Amount(Rs)";
                e.Row.Cells[7].Text = "Amount(Rs)";
            }
            else
            {
                //e.Row.Cells[4].Text = "Amount";
                e.Row.Cells[7].Text = "Amount";
            }
        }



    }

    public List<BillingDetails> AddConsultantDGEHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION 1st Visit - CGHS  S.NO - 1.4.2(By Specialist)";
                    lstitem1.Amount = 61.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 4.6";
                    lstitem1.Amount = 81.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //

                }
            }
        }
        return lstdet;
    }
    public List<BillingDetails> AddConsultantCGHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 63";
                    lstitem1.Amount = 36.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "NCT - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    decimal amt;
                    amt = lstdetails[i].Amount / lstdetails[i].Quantity;
                    if (amt == 226)
                    {
                        lstitem1 = null;
                        //
                        lstitem1 = new BillingDetails();
                        lstitem1.FeeDescription = "INDIRECT OPTHALMOSCOPE - CGHS  S.NO - 64";
                        lstitem1.Amount = 90.00m;
                        lstitem1.Quantity = 1.00m;
                        lstdet.Add(lstitem1);
                    }
                }
            }
        }
        return lstdet;
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

    public void BillPrinting_Merge(long visitID)
    {

        string IsRoundOff = string.Empty;
        IsRoundOff = GetConfigValue("PatientCommonRoundOffPattern", OrgID);
        if (String.IsNullOrEmpty(IsRoundOff))
        {
            hdnIsRoundOff.Value = "ON";
        }
        else
        {
            hdnIsRoundOff.Value = "OFF";
        }

        string LabNo = Convert.ToString(Request.QueryString["Labno"]);
        string physicianName = string.Empty;
        string splitstatus = string.Empty;
        string discountpercent = string.Empty;
        List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
        List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
        List<Patient> lstPatientDetails = new List<Patient>();

        BillingEngine BL = new BillingEngine(base.ContextInfo);
        BL.GetMergeBillPrinting(visitID, out lstBillingDetail,
                                       out lstFinalBillDetail, out lstPatientDetails);
        if (lstBillingDetail.Count > 0)
        {
            gvBillingDetail.Columns[1].Visible = false;
            gvBillingDetail.Columns[3].Visible = false;
            gvBillingDetail.Columns[4].Visible = false;
            gvBillingDetail.DataSource = lstBillingDetail;
            gvBillingDetail.DataBind();

        }

        if (lstPatientDetails.Count > 0)
        {
          
            //lblTitleName.Text = lstPatientDetails[0].TitleName.ToString();
            lblName.Text = lstPatientDetails[0].Name.ToString();
         
            lblSex.Text = lstPatientDetails[0].SEX.ToString();
            lblPhysician.Text = lstPatientDetails[0].ReferingPhysicianName.ToString();

            //----------------------Sathish.E------------------//
            lblVisitNumber.Text = lstPatientDetails[0].ExternalVisitID.ToString();
            //lblVisitNumber.Text = lstPatientDetails[0].VersionNo.ToString();

            //----------------------End------------------//
            lblPatPhoneNumber.Text = lstPatientDetails[0].MobileNumber.ToString();
            lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
          
            lblVisitNumber.Visible = true;

            //----------------------Sathish.E------------------//
            lblVisitNumber.Text = lstPatientDetails[0].ExternalVisitID.ToString();
            //lblVisitNumber.Text = lstPatientDetails[0].VersionNo.ToString();

            //----------------------End------------------//
            Rs_BillNo.Text = "";
            lblInvoiceNo.Text = "";
            lblGrossAmount.Text = lstFinalBillDetail[0].GrossBillValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            
            lblGrandTotal.Text = lstFinalBillDetail[0].NetValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            lblPreviousDue.Text = "0";
            lblNetValue.Text = lstFinalBillDetail[0].NetValue.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            lblAmountRecieved.Text = lstFinalBillDetail[0].AmountReceived.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            lblCurrentVisitDueText.Text = lstFinalBillDetail[0].Due.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);           
            lblTaxAmount.Text = "0";          
            hdnDue.Value = "1";

            if (lstFinalBillDetail[0].AmountRefund > 0)
            {
                trAmountRevd.Style.Add("display", "table-row");
                lblAmountRefound.Text = lstFinalBillDetail[0].AmountRefund.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            }
            if (lstFinalBillDetail[0].TPAAmount > 0)
            {
                trClaminAmount.Style.Add("display", "table-row");
                lblClaminAmount.Text = lstFinalBillDetail[0].TPAAmount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            }

            lblRoundOff.Text = lstFinalBillDetail[0].RoundOff.ToString();
            hdnRoundoff.Value = lstFinalBillDetail[0].RoundOff > 0 ? "1" : "0";
        }


    }
}
