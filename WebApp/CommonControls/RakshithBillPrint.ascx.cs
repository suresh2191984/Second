using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using NumberToWord;


public partial class Billing_RakshithBillPrint : BaseControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //lblHospitalName.InnerText = OrgName;
        }
    }
    public void BillPrinting(long visitID, long FinalbillID, int pdp)
    {
        try
        {
            //long visitID = Convert.ToInt64(Request.QueryString["VisitID"]);
            string physicianName = string.Empty;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            string splitstatus = string.Empty;
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            List<PatientQualification> lstQualification = new List<PatientQualification>();
           
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus, out lstQualification);

            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
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
                gvBillingDetail.DataSource = lstBillingDetail;
                gvBillingDetail.DataBind();

                string isDueBill = "N";

                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                }
                lblTitleName.Text = lstPatientDetails[0].TitleName;
                lblName.Text = lstPatientDetails[0].Name.ToUpper();
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                if (lstPatientDetails[0].SEX == "M")
                    //lblSex.Text = "Male";
                    lblName.Text += (" / M").ToUpper();
                else
                    lblName.Text += (" / F").ToUpper();

                //lblSex.Text = "Female";

                lblName.Text += (" / " + lstPatientDetails[0].Age.ToString()).ToUpper();
                ////lblAge.Text = lstPatientDetails[0].Age.ToString();
                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

                lblInvoiceNo.Text = lstFinalBillDetail[0].FinalBillID.ToString();
                lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yyyy");

                if (physicianName.Equals(""))
                {
                    lblPhy.Visible = false;
                    lblPhysician.Visible = false;
                    phyDetails.Visible = true;
                    tblPhySal.Visible = false;
                }
                else
                {
                    lblPhy.Visible = true;
                    lblPhysician.Visible = true;
                    lblPhysician.Text = physicianName;
                    phyDetails.Visible = true;
                    tblPhySal.Visible = true;
                }

                if (lstFinalBillDetail[0].StdDedID > 0)
                {
                    if (lstFinalBillDetail[0].StdDedType == "V")
                        lblDeduction.Text = String.Format("{0:0.00}", Convert.ToInt64(lstFinalBillDetail[0].StdDedValue));
                    else if (lstFinalBillDetail[0].StdDedType == "P")
                        lblDeduction.Text = String.Format("{0:0.00}", (Convert.ToInt64(lstFinalBillDetail[0].StdDedValue) * lstFinalBillDetail[0].GrossBillValue / 100));
                }
                else
                {
                    lblDeduction.Text = "0.00";
                }


                lblDiscount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].DiscountAmount);
                lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);

                if (lstFinalBillDetail[0].ServiceCharge > 0)
                {
                    lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].ServiceCharge);
                    trServiceCharge.Style.Add("display", "table-row");
                }
                else
                {
                    trServiceCharge.Style.Add("display", "none");
                }

                //lblPreviousDue.Text = "0.00";
                lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);
                //if (lstFinalBillDetail[0].Due > 0)
                //{
                lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                if (isDueBill != "Y")
                {
                    if (lstFinalBillDetail[0].CurrentDue > 0)
                    {
                        lblPreviousDue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].CurrentDue);
                        trPreviousDue.Style.Add("display", "table-row");
                        trGrandTotal.Style.Add("display", "table-row");
                        trGrandTotalLine.Style.Add("display", "table-row");
                    }
                    else
                    {
                        trPreviousDue.Style.Add("display", "none");
                        trGrandTotal.Style.Add("display", "none");
                        trGrandTotalLine.Style.Add("display", "none");
                    }
                }
                else
                {
                    lblPreviousDue.Text = String.Format("{0:0.00}", "0");
                    trPreviousDue.Style.Add("display", "none");
                    trGrandTotal.Style.Add("display", "none");
                    trGrandTotalLine.Style.Add("display", "none");
                }
                if (isDueBill != "Y")
                {
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                }
                else
                {
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                }
                //}
                //else
                //{

                //    lblCurrentVisitDueLabel.Visible = false;
                //    lblCurrentVisitDueText.Visible = false;

                //}

                //if (lstFinalBillDetail[0].IsCreditBill == "Y")
                //{

                //}
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                    {
                        lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblAmount.Text = num.Convert(lblAmountRecieved.Text.Split('/')[0]) + " Only...";
                    }
                }
                else
                {
                    lblAmount.Text = " Zero Only...";
                }

                if (Convert.ToDouble(lblCurrentVisitDueText.Text) > 0)
                {
                    if (int.Parse(lblCurrentVisitDueText.Text.Split('.')[1]) > 0)
                    {
                        lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblDueAmount.Text = num.Convert(lblCurrentVisitDueText.Text) + " Only...";
                    }
                }
                else
                {
                    lblDueAmount.Text = " Zero Only...";
                }

                #region for KMH Changes

                if (lstFinalBillDetail[0].IsCreditBill == "Y")
                {
                    lblTypeBill.Text = "Credit Bill";
                }
                else if (lstFinalBillDetail[0].IsCreditBill != "Y" && lblCurrentVisitDueText.Text != "0.00")
                {
                    lblTypeBill.Text = "Due Bill";
                }
                else
                {
                    lblTypeBill.Text = "Paid Bill";
                }


                List<PaymentType> lstPaymentType = new List<PaymentType>();
                List<PaymentType> lstOtherCurrency = new List<PaymentType>();
                List<PaymentType> lstDepositAmt = new List<PaymentType>();
                int payingPage = 1;
                string ReceiptNo = string.Empty;
                decimal depamt = 0;
                billingBL.GetPaymentMode(FinalbillID, visitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
               
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
                    lblDepositAmtUsed.Visible = true;
                    lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                    depamt = lstDepositAmt[0].AmountUsed;
                }
                if (lstOtherCurrency.Count > 0)
                {
                    if (lstOtherCurrency[0].CurrencyName != null && lstOtherCurrency[0].OtherCurrencyAmount != null)
                    {
                        decimal othercuramt = 0.00m, totothercuramt = 0.00m;
                        decimal servicecharge = 0.00m;
                        othercuramt = Convert.ToDecimal(lstOtherCurrency[0].OtherCurrencyAmount);
                        servicecharge = Convert.ToDecimal(lstFinalBillDetail[0].ServiceCharge);
                        servicecharge = servicecharge == null ? 0 : servicecharge;
                        totothercuramt = othercuramt + servicecharge + depamt;

                        lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + totothercuramt.ToString();
                        lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";
                        if (int.Parse(totothercuramt.ToString().Split('.')[1]) > 0)
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " " + MinorCurrencyName + " Only...";
                        }
                        else
                        {
                            lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + " Only...";
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

                List<Config> lstConfig = new List<Config>();
                GateWay gateWay = new GateWay(base.ContextInfo);
                long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    lblDisplayAmount.Text = "Amount Received in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                }
                else
                {
                    lblDisplayAmount.Text = "Amount Received in Words: (" + CurrencyName + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + CurrencyName + ") ";
                }

                //List<Users> lstUsers = new List<Users>();
                //new Inventory_BL(base.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
                //lblBilledBy.Text = ("Billed By: (" +  lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name + ")").ToUpper();
                lblBilledBy.Text = ("Billed By: (" + lstBillingDetail[0].BilledBy + ")").ToUpper();


                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetails[0].TPAAttributes, lstPatientDetails[0].TPAName);
                }
                #endregion

                if (lstTax.Count > 0)
                {
                    dvTaxDetails.Visible = true;
                    string sTableHTML = "<table width='100%'>";
                    foreach (Taxmaster tm in lstTax)
                    {
                        sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + String.Format("{0:0.00}", ((lstFinalBillDetail[0].GrossBillValue - lstFinalBillDetail[0].DiscountAmount) * (tm.TaxPercent / 100))) + "<td/></tr>";
                    }

                    sTableHTML += "</table>";
                    dvTaxDetails.InnerHtml = sTableHTML;
                }
                else
                {
                    dvTaxDetails.Visible = false;
                }
                lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].RoundOff);

                //if (lstDuePaidDetails.Count > 0)
                //{
                //    lblDuePaidDetails.Visible = true;
                //    gvDuesPaid.DataSource = lstDuePaidDetails;
                //    gvDuesPaid.DataBind();
                //}
                //else
                //{
                //    lblDuePaidDetails.Visible = false;
                //}
            }
            else
            {

                tblBillPrint.Visible = false;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
}
