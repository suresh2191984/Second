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
using System.Collections.Specialized;

public partial class CommonControls_EsBillPrint :BaseControl 
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //lblHospitalName.InnerHtml = OrgName+"<br/>";
            List<Config> lstConfig = new List<Config>();

            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;

            #region Commented code
            /*
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
            */
            #endregion
        }
    }

    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfig);
        int nConfigElements = lstConfig.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfig[nCnt].ConfigValue.Split('^');
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
            //long visitID = Convert.ToInt64(Request.QueryString["VisitID"]);
            string physicianName = string.Empty;
            //decimal refundAmount = 0;
            //decimal amtReceived = 0;
            //decimal amtRefunded = 0;
            //decimal dChequeAmount = 0;
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
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus,out lstQualification);

            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            //billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, lstFinalBillDetail[0].FinalBillID, lstBillingDetail[0].BillingDetailsID);
            //if (amtRefunded != 0)
            //{
            //    lblrefundamt.Visible = true;
            //    lblrefundamt.Text = "Amount refunded to the patient::" + amtRefunded.ToString();
            //}
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
                lblName.Text = lstPatientDetails[0].Name;
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                if (lstPatientDetails[0].SEX == "M")
                    lblSex.Text = "Male";
                else
                    lblSex.Text = "Female";
                lblAge.Text = lstPatientDetails[0].Age.ToString();
                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

                lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString().Trim();
                lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yyyy");

                if (physicianName.Equals(""))
                {
                    lblPhy.Visible = false;
                    lblPhysician.Visible = false;
                    phyDetails.Visible = false;
                }
                else
                {
                    lblPhy.Visible = true;
                    lblPhysician.Visible = true;
                    lblPhysician.Text = physicianName;
                    phyDetails.Visible = true;
                }


                lblRefPhy.Text=lstPatientDetails[0].ReferingPhysicianName;

                if (lblRefPhy.Text == "")
                {
                    divref.Visible = false;
                    lblRefPhy.Visible = false;
                    lblrefPhyH.Visible = false;
                }
                else
                {
                    lblRefPhy.Text =  lstPatientDetails[0].ReferingPhysicianName;
                    lblRefPhy.Visible = true;
                    lblrefPhyH.Visible = true;
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
                if (lstFinalBillDetail[0].DiscountAmount <= 0)
                {
                    trDiscount.Visible = false;
                }
                else
                {
                    trDiscount.Visible = true;
                }
                //trPayingCurrency.Visible = false; // code added to hide multiple currency for ES
                trPayingCurrency.Attributes.Add("display", "none");
                lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);
                lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].ServiceCharge);
                lblTaxAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].TaxAmount);
                //lblPreviousDue.Text = "0.00";
                lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);
                //if (lstFinalBillDetail[0].Due > 0)
                //{
                lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);
                if (isDueBill != "Y")
                {
                   // lblPreviousDue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].CurrentDue);
                }
                else
                {
                    //lblPreviousDue.Text = String.Format("{0:0.00}", "0");
                }
                if (isDueBill != "Y")
                {
                    //lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
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
                    //lblTypeBill.Text = "Credit Bill";
                }
                else if (lstFinalBillDetail[0].IsCreditBill != "Y" && lblCurrentVisitDueText.Text != "0.00")
                {
                    //lblTypeBill.Text = "Due Bill";
                }
                else
                {
                    //lblTypeBill.Text = "Paid Bill";
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
                    //trDeposit.Attributes.Add("display", "block");
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
                        //below code if commented for ES to hide multiple currency
                        //lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + totothercuramt.ToString();
                        lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";
                        if (int.Parse(totothercuramt.ToString().Split('.')[1]) > 0)
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " Paise Only...";
                        }
                        else
                        {
                            lblPayingCurrencyinWords.Text = Utilities.FormatNumber2Word(num.Convert(totothercuramt.ToString())) + " Only...";
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
                    lblDisplayAmount.Text = "Amount in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                }
                else
                {
                    lblDisplayAmount.Text = "Amount in Words: (" + CurrencyName + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + CurrencyName + ") ";
                }
                if (lstFinalBillDetail[0].Due > 0)
                {
                    trDue.Visible = true;
                    trDueWords.Visible = true;
                }
                else
                {
                    trDue.Visible = false;
                    trDueWords.Visible = false;
                }
                //List<Users> lstUsers = new List<Users>();
                //new Inventory_BL(base.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
                //lblBilledBy.Text = ("Billed By: (" + lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name + ")").ToUpper();
                lblBilledBy.Text = ("Billed By: (" + lstBillingDetail[0].BilledBy + ")").ToUpper();
                if (lstTax.Count > 0)
                {
                    dvTaxDetails.Visible = true;
                    string sTableHTML = "<table width='100%'>";
                    foreach (Taxmaster tm in lstTax)
                    {
                        if (tm.TaxAmount > 0)
                        {
                            sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + String.Format("{0:0.00}", ((lstFinalBillDetail[0].GrossBillValue - lstFinalBillDetail[0].DiscountAmount) * (tm.TaxPercent / 100))) + "<td/></tr>";
                        }
                    }

                    sTableHTML += "</table>";
                    dvTaxDetails.InnerHtml = sTableHTML;
                }
                else
                {
                    dvTaxDetails.Visible = false;
                }


                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetails[0].TPAAttributes, lstPatientDetails[0].TPAName);
                }
                #endregion
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
                    lblTypeBill.Text = "PAID BILL";
                }
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
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There is no Bill for this Patient";
                tblBillPrint.Visible = false;
            }

            lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].RoundOff);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
}
