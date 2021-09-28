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

public partial class CommonControls_EsIPInvPrientBill :BaseControl
{
    string ReceiptID = string.Empty;
    long returncode = -1;
    long visitID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
              
                long FinalBillID = 0;
                Int64.TryParse(Request.QueryString["VisitID"], out visitID);
                Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
                ReceiptID=Request.QueryString["rid"];
                //ReceiptPrinting(ReceiptID, FinalBillID);

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in GracePrintBill.aspx", ex);
            }
        }
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
public void ReceiptPrinting(string ReceiptID, long FinalbillID)
    {
        try
        {
            
            string strwords1 = string.Empty;
            string strwords2 = string.Empty;
            string physicianName = string.Empty;
            string discountpercent = string.Empty;
            string licenceNo = string.Empty;
            string Dlno = string.Empty;
            string tinNo = string.Empty;
            string appString = string.Empty;
            
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            //inventoryBL.GetReceiptPrintingDetails(ReceiptID, out lstBillingDetail, out lstPatientDetails, OrgID);

            List<Patient> lstPatientDetails1 = new List<Patient>();
           
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            List<Users> lstUsers = new List<Users>();
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID,ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                orgDLNoLaser.Text = "D.L.No: " + lstInventoryConfig[0].ConfigValue.ToUpper();
                Dlno = lstInventoryConfig[0].ConfigValue.ToUpper();
                trorgDLNoLaser.Style.Add("display", "block");
            }

            List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig1);
            if (lstInventoryConfig1.Count > 0)
            {
                orgTinNoLaser.Text = "TIN No: " + lstInventoryConfig1[0].ConfigValue.ToUpper();
                trorgTinNoLaser.Style.Add("display", "block");
            }
            //if (dup == 1)
            //{
            //    Duplicate.Visible = true;
            //    Duplicate.Text = "Duplicate Copy";
            //}
            //if (lstFinalBillDetail[0].IsCreditBill == "Y")
            //    CreditOrCash.Text = "Credit Bill";
            //else CreditOrCash.Text = "Cash Bill";
            if (lstBillingDetail.Count > 0)
            if (lstBillingDetail.Count > 0 )//(&& lstFinalBillDetail[0].GrossBillValue >=  0)
            {
                //gvBillingDetail.DataSource = lstBillingDetail;
                //gvBillingDetail.DataBind();
                string RoundofQty = GetConfigValue("PharmaBillPrint", OrgID);
                if (lstBillingDetail.Count > 0)
                {
                    int i = 0;
                    TableRow headLine1Row = new TableRow();
                    TableCell headLineCell1 = new TableCell();
                    headLineCell1.ColumnSpan = 7;
                    headLineCell1.Text = "&nbsp;";
                    headLine1Row.Cells.Add(headLineCell1);
                    // billDetailLaser.Rows.Add(headLine1Row);
                    TableRow headRow = new TableRow();
                    TableCell headCell1 = new TableCell();
                    TableCell headCell2 = new TableCell();
                    TableCell headCell3 = new TableCell();
                    TableCell headCell4 = new TableCell();
                    TableCell headCell5 = new TableCell();
                    TableCell headCell6 = new TableCell();
                    TableCell headCell7 = new TableCell();
                    headCell1.BorderWidth = 1;
                    headCell2.BorderWidth = 1;
                    headCell3.BorderWidth = 1;
                    headCell4.BorderWidth = 1;
                    headCell5.BorderWidth = 1;
                    headCell6.BorderWidth = 1;
                    headCell7.BorderWidth = 1;

                    headCell1.Attributes.Add("align", "center");
                    headCell1.Text = "S.No";
                    headCell1.Width = Unit.Percentage(5);
                    headCell2.Attributes.Add("align", "center");
                    headCell2.Text = "Particulars";
                    //headCell2.Width = Unit.Percentage(10);
                    headCell3.Attributes.Add("align", "center");
                    headCell3.Text = "Qty";
                    headCell3.Width = Unit.Percentage(10);
                    headCell4.Attributes.Add("align", "center");
                    headCell4.Text = "Batch";
                    headCell4.Width = Unit.Percentage(10);
                    headCell5.Attributes.Add("align", "center");
                    headCell5.Text = "Exp.Date";
                    headCell5.Width = Unit.Percentage(10);
                    headCell6.Attributes.Add("align", "center");
                    headCell6.Text = "Rate";
                    headCell6.Width = Unit.Percentage(5);

                    headCell7.Attributes.Add("align", "center");
                    headCell7.Text = "Amount";
                    headCell7.Width = Unit.Percentage(5);

                    headCell6.Width = Unit.Percentage(10);
                    headRow.Cells.Add(headCell1);
                    headRow.Cells.Add(headCell2);
                    headRow.Cells.Add(headCell3);
                    headRow.Cells.Add(headCell4);
                    headRow.Cells.Add(headCell5);
                    headRow.Cells.Add(headCell6);
                    headRow.Cells.Add(headCell7);
                    billDetailLaser.Rows.Add(headRow);
                    TableRow headLine2Row = new TableRow();
                    TableCell headLineCell2 = new TableCell();
                    headLineCell2.ColumnSpan = 6;
                    headLineCell2.Text = "<hr/>";
                    headLine2Row.Cells.Add(headLineCell2);
                    //billDetailLaser.Rows.Add(headLine2Row);
                    foreach (BillingDetails objBD in lstBillingDetail)
                    {
                        i += 1;
                        TableRow contentRow = new TableRow();
                        TableCell contentCell1 = new TableCell();
                        TableCell contentCell2 = new TableCell();
                        TableCell contentCell3 = new TableCell();
                        TableCell contentCell4 = new TableCell();
                        TableCell contentCell5 = new TableCell();
                        TableCell contentCell6 = new TableCell();
                        TableCell contentCell7 = new TableCell();
                        contentCell1.BorderWidth = 0;
                        contentCell2.BorderWidth = 0;
                        contentCell3.BorderWidth = 0;
                        contentCell4.BorderWidth = 0;
                        contentCell5.BorderWidth = 0;
                        contentCell6.BorderWidth = 0;
                        contentCell7.BorderWidth = 0;

                        contentCell1.Attributes.Add("align", "left");
                        contentCell1.Text = i.ToString();
                        contentCell1.Style.Add("padding-right", "0px");
                        contentCell1.Width = Unit.Percentage(5);
                        contentCell2.Attributes.Add("align", "left");
                        contentCell2.Style.Add("padding-left", "15px");
                        contentCell2.Text = objBD.FeeDescription;
                        //contentCell2.Width = 50;
                        contentCell3.Attributes.Add("align", "center");
                        if (RoundofQty == "NMCPharmaBillPrint")
                        {
                            contentCell3.Text = Convert.ToInt32(objBD.Quantity).ToString();
                        }
                        else
                        {
                            contentCell3.Text = objBD.Quantity.ToString();
                        }
                        contentCell3.Width = Unit.Percentage(10);
                        contentCell4.Attributes.Add("align", "left");
                        contentCell4.Text = objBD.BatchNo;
                        contentCell4.Width = Unit.Percentage(10);
                        contentCell5.Attributes.Add("align", "left");
                        if (objBD.ExpiryDate <= DateTime.Parse("01/01/1901"))
                        {
                            contentCell5.Text = "--";
                        }
                        else
                        {
                            contentCell5.Text = objBD.ExpiryDate.ToString("MMM-yyyy");
                        }
                        //contentCell5.Style.Add("padding-right", "0px");
                        contentCell5.Width = Unit.Percentage(15);
                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Style.Add("padding-left", "15px");
                        contentCell6.Text = objBD.Rate.ToString();
                        contentCell6.Width = Unit.Percentage(10);

                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Style.Add("padding-left", "15px");
                        contentCell6.Text = objBD.Amount.ToString();
                        contentCell6.Width = Unit.Percentage(10);

                        contentCell7.Attributes.Add("align", "left");
                        contentCell7.Text = objBD.Rate.ToString();
                        contentCell7.Width = Unit.Percentage(5);

                        contentRow.Cells.Add(contentCell1);
                        contentRow.Cells.Add(contentCell2);
                        contentRow.Cells.Add(contentCell3);
                        contentRow.Cells.Add(contentCell4);
                        contentRow.Cells.Add(contentCell5);
                        contentRow.Cells.Add(contentCell6);
                        contentRow.Cells.Add(contentCell7);
                        billDetailLaser.Rows.Add(contentRow);
                    }
                    TableRow headLine3Row = new TableRow();
                    TableCell headLineCell3 = new TableCell();
                    headLineCell3.ColumnSpan = 7;
                    headLineCell3.Text = "&nbsp;";
                    headLine3Row.Cells.Add(headLineCell3);
                    billDetailLaser.Rows.Add(headLine3Row);
                                        
                    TableRow headLine4Row = new TableRow();
                    TableCell headLineCell4 = new TableCell();
                    headLineCell4.ColumnSpan = 7;
                    headLineCell4.Text = "&nbsp;";
                    headLine4Row.Cells.Add(headLineCell4);
                    //billDetailLaser.Rows.Add(headLine4Row);
                    decimal NetValue = lstBillingDetail.Sum(p => p.Rate);
                    TableRow netTotalRow = new TableRow();
                    TableCell netTotalCell1 = new TableCell();
                    netTotalCell1.ColumnSpan = 6;
                    netTotalCell1.Attributes.Add("align", "right");
                    netTotalCell1.Style.Add("padding-right", "30px");
                    netTotalCell1.Text = "Net Amount: ";
                    
                    TableCell netTotalCell2 = new TableCell();
                    netTotalCell2.Attributes.Add("align", "right");
                    netTotalCell2.Style.Add("padding-left", "15px");
                    netTotalCell2.Text = NetValue.ToString();
                    netTotalRow.Cells.Add(netTotalCell1);
                    netTotalRow.Cells.Add(netTotalCell2);
                    billDetailLaser.Rows.Add(netTotalRow);

                    TableRow AmountReceived = new TableRow();
                    TableCell AmountReceivedCell1 = new TableCell();
                    AmountReceivedCell1.ColumnSpan = 6;
                    AmountReceivedCell1.Attributes.Add("align", "right");
                    AmountReceivedCell1.Style.Add("padding-right", "30px");
                    AmountReceivedCell1.Text = "Paid Amount: ";
                    TableCell AmountReceivedCell2 = new TableCell();
                    AmountReceivedCell2.Attributes.Add("align", "right");
                    AmountReceivedCell2.Style.Add("padding-left", "15px");
                    AmountReceivedCell2.Text = lstBillingDetail[0].AmountReceived.ToString();
                    AmountReceived.Cells.Add(AmountReceivedCell1);
                    AmountReceived.Cells.Add(AmountReceivedCell2);
                    billDetailLaser.Rows.Add(AmountReceived);
            //Payment Mode
                    
                    int payingPage = 1;
                    decimal depamt = 0;
                    List<PaymentType> lstPaymentType = new List<PaymentType>();
                    List<PaymentType> lstOtherCurrency = new List<PaymentType>();
                    List<PaymentType> lstDepositAmt = new List<PaymentType>();
                   
                    BillingEngine billingBL = new BillingEngine(base.ContextInfo);
                    billingBL.GetPaymentMode(FinalbillID, visitID, ReceiptID, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
                    if (lstPaymentType.Count > 0)
                    {
                       // lblPayment.Visible = true;
                        int flag = 0;
                        for (int j = 0; j < lstPaymentType.Count; j++)
                        {
                            if (flag == 0)
                            {
                                //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                appString = lstPaymentType[j].PayDetails + "<br>";
                            }
                            else
                            {
                                //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                appString = appString + lstPaymentType[j].PayDetails + "<br>";
                            }
                            flag++;

                        }
                    }
                    else
                    {
                        //lblPayment.Visible = false;
                    }

                   //if (lstOtherCurrency.Count > 0)
                   // {
                   //     if (lstOtherCurrency[0].CurrencyName != null && lstOtherCurrency[0].OtherCurrencyAmount != null)
                   //     {
                   //         decimal othercuramt = 0, totothercuramt = 0;
                   //         decimal servicecharge = 0;
                   //         othercuramt = Convert.ToDecimal(lstOtherCurrency[0].OtherCurrencyAmount);
                   //         servicecharge = Convert.ToDecimal(lstBillingDetail[0].ServiceCharge);
                   //         servicecharge = servicecharge == null ? 0 : servicecharge;
                   //         totothercuramt = othercuramt + servicecharge + depamt;

                   //         TableRow OtherCurrency = new TableRow();
                   //         TableCell OtherCurrencyCell1 = new TableCell();
                   //         OtherCurrencyCell1.ColumnSpan = 6;
                   //         OtherCurrencyCell1.Attributes.Add("align", "left");
                   //         OtherCurrencyCell1.Style.Add("padding-right", "30px");
                   //         OtherCurrencyCell1.Text = "<B>Payment Mode:<B>   <B>" + appString + "<B>";
                   //         OtherCurrencyCell1.Font.Bold = true;
                   //         OtherCurrency.Cells.Add(OtherCurrencyCell1);
                   //         billDetailLaser.Rows.Add(OtherCurrency);

                   //         TableRow Paymentmode = new TableRow();
                   //         TableCell OtherCurrencyCell2 = new TableCell();
                   //         OtherCurrencyCell1.ColumnSpan = 6;
                   //         OtherCurrencyCell2.Attributes.Add("align", "left");
                   //         OtherCurrencyCell2.Style.Add("padding-right", "50px");
                   //         // OtherCurrencyCell2.Text = lstFinalBillDetail[0].OtherCurrencyAmount.ToString();
                   //         // OtherCurrencyCell2.Text = string.Concat(lstFinalBillDetail[0].OtherCurrencyAmount.ToString(), lstFinalBillDetail[0].CurrencyCode.ToString());
                   //         // OtherCurrencyCell2.Text = appString;
                   //         OtherCurrencyCell2.Font.Bold = true;
                   //         Paymentmode.Cells.Add(OtherCurrencyCell2);
                   //         billDetailLaser.Rows.Add(Paymentmode);

                   //         //lblOtherCurrency.Text = "<br>" + "<b>Paying Currency/Amount = </b>" + lstOtherCurrency[0].CurrencyName + " - " + totothercuramt.ToString();
                   //        // lblPayingCurrency.Text = "Paying Currency: (" + lstOtherCurrency[0].CurrencyName + ")";
                   //         //Label1.Text = "Remaining Deposit Amount : (" + lstOtherCurrency[0].CurrencyName + ")";
                   //       //  lblPayingCurrencyinWords.Text = num.Convert(totothercuramt.ToString()) + " Only";
                   //        // trPayingCurrency.Attributes.Add("display", "block");
                   //        // hdnPayingCurrency.Value = "1";
                   //     }
                   //     else
                   //     {
                   //         //hdnPayingCurrency.Value = "0";
                   //     }
                   // }
                    //Payment mode
                    if (lstBillingDetail[0].AmountRefund > 0)
                    {
                        TableRow RefundAmount = new TableRow();
                        TableCell RefundAmountCell1 = new TableCell();
                        RefundAmountCell1.ColumnSpan = 6;
                        RefundAmountCell1.Attributes.Add("align", "right");
                        RefundAmountCell1.Style.Add("padding-right", "15px");
                        RefundAmountCell1.Text = "Refunded Amount: ";
                        RefundAmountCell1.Font.Bold = true;
                        TableCell RefundAmountCell2 = new TableCell();
                        RefundAmountCell2.Attributes.Add("align", "right");
                        RefundAmountCell2.Style.Add("padding-left", "15px");
                        RefundAmountCell2.Text = lstBillingDetail[0].AmountRefund.ToString();
                        RefundAmountCell2.Font.Bold = true;
                        RefundAmount.Cells.Add(RefundAmountCell1);
                        RefundAmount.Cells.Add(RefundAmountCell2);
                        billDetailLaser.Rows.Add(RefundAmount);
                    }
                    //amountInWordsLaser.Text = lstBillingDetail[0].NetValue.ToString();
                    string strwords = string.Empty;
                    
                    NumberToWord.NumberToWords num1 = new NumberToWord.NumberToWords();
                    NumberToWord.NumberToWords num2 = new NumberToWord.NumberToWords();
                    if (Convert.ToDouble(lstBillingDetail[0].AmountReceived) > 0)
                    {
                        if (int.Parse(lstBillingDetail[0].AmountReceived.ToString().Split('.')[1]) > 0)
                        {
                            strwords = "Amount in Words: (" + CurrencyName + ") " + Utilities.FormatNumber2Word(num1.Convert(lstBillingDetail[0].AmountReceived.ToString())) + " " + MinorCurrencyName + " Only...";
                        }
                        else
                        {
                            strwords = "Amount in Words: (" + CurrencyName + ") " + num1.Convert(lstBillingDetail[0].AmountReceived.ToString()) + " Only...";
                        }
                    }
                    else
                    {
                        strwords = "Zero Only...";

                    }
                    if (Convert.ToDouble(lstBillingDetail[0].AmountRefund) > 0)
                    {
                        if (int.Parse(lstBillingDetail[0].AmountRefund.ToString().Split('.')[1]) > 0)
                        {
                            strwords1 = "Refunded Amount in Words: " + CurrencyName + ". " + Utilities.FormatNumber2Word(num2.Convert(lstBillingDetail[0].AmountRefund.ToString())) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            strwords1 = "Refunded Amount in Words: " + CurrencyName + ". " + num2.Convert(lstBillingDetail[0].AmountRefund.ToString()) + " Only";
                        }
                    }
                    else
                    {
                        strwords1 = "";

                    }
                    if (lstBillingDetail[0].AdvanceRecieved > 0)
                    {
                        strwords2 = "Remaining Advance Amount : " + CurrencyName + ". " + lstBillingDetail[0].AdvanceRecieved.ToString();
                    }
                    else
                    {
                        strwords2 = "";
                    }
                    TableRow headLine5Row = new TableRow();
                    TableCell headLineCell5 = new TableCell();
                    headLineCell5.ColumnSpan = 7;
                    headLineCell5.Style.Add("padding-left", "30px");
                    headLineCell5.Text = strwords ;
                    headLine5Row.Cells.Add(headLineCell5);
                    billDetailLaser.Rows.Add(headLine5Row);
                    TableRow headLine6Row = new TableRow();
                    TableCell headLineCell6 = new TableCell();
                    headLineCell6.ColumnSpan = 7;
                    headLineCell6.Style.Add("padding-left", "30px");
                    headLineCell6.Text =  strwords1 ;
                    headLine6Row.Cells.Add(headLineCell6);
                    billDetailLaser.Rows.Add(headLine6Row);

                    TableRow headLine7Row = new TableRow();
                    TableCell headLineCell7 = new TableCell();
                    headLineCell7.ColumnSpan = 7;
                    headLineCell7.Style.Add("padding-left", "30px");
                    headLineCell7.Text =  strwords2 ;
                    headLine7Row.Cells.Add(headLineCell7);
                    billDetailLaser.Rows.Add(headLine7Row);

                }

                string isDueBill = "N";

                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                }
                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);
                string RedirectPage = GetConfigValue("KmhPharmaBillPrint", OrgID);
                if (RedirectPage != "KMHPharmacy")
                {
                    RedirectPage = GetConfigValue("PharmaBillPrint", OrgID);
                        orgAddressLaser.Text = GetConfigValue("EsIpPharAddress", OrgID); // lstOrganization[0].Address + "<br/>" + lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                }
                if (RedirectPage == "KMHPharmacy")
                {
                    billLaser.Width = Unit.Percentage(100);
                    billLaser.Attributes.Add("align", "center");
                }
                patientNameLaser.Text = "Patient Name: " + lstPatientDetails[0].Name + "<br/>" + lstPatientDetails[0].Name;
                //PatientNoLaser.Text = "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>"+ lstPatientDetails[0].Comments;
                //PatientAgeLaser.Text = "PatientAge: " + lstPatientDetails[0].Age  + "<br/>" +lstPatientDetails[0].Comments;
                if (lstBillingDetail[0].RefPhyName != "")
                {
                    drNameLaser.Text = "Prescribed By:" + lstBillingDetail[0].RefPhyName;
                    physicianName = lstBillingDetail[0].RefPhyName;
                }
                if (lstPatientDetails.Count > 0)
                {
                    if (lstPatientDetails[0].PatientNumber != "")
                    {
                        if (lstPatientDetails[0].Name != null)
                        {
                            PatientNoLaser.Text = "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>";// +lstFinalBillDetail[0].Comments;
                            patientNameLaser.Text = "Patient Name: " + lstPatientDetails[0].Name + "<br/>";// +"Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>";// +lstFinalBillDetail[0].Comments;
                            PatientAgeLaser.Text = "Patient Age: " + lstPatientDetails[0].Age + "<br/>";// +lstFinalBillDetail[0].Comments;
                        }
                        else
                        {
                            PatientNoLaser.Text = "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>";// +lstFinalBillDetail[0].Comments;
                            patientNameLaser.Text = "Patient Name: " + lstPatientDetails[0].Name + "<br/>" + "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>" + lstPatientDetails[0].Comments;
                        }
                    }
                    else
                    {
                        PatientNoLaser.Text = "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>";// +lstFinalBillDetail[0].Comments;
                        patientNameLaser.Text = "Patient Name: " + lstPatientDetails[0].Name + "<br/>" + lstPatientDetails[0].Comments;
                    }
                }
                //else
                //{
                //    PatientNoLaser.Text = "Patient Number: " + lstPatientDetails[0].PatientNumber + "<br/>";// +lstFinalBillDetail[0].Comments;
                //    patientNameLaser.Text = "Patient Name: " + lstFinalBillDetail[0].Name + "<br/>";// +lstFinalBillDetail[0].Comments;
                   
                //}
                tdSoldByLaser.Text = "Sold By: " + lstUsers.Find(P => P.LoginID == lstBillingDetail[0].CreatedBy).Name;
                billNoLaser.Text = "ReceiptNo: " + lstBillingDetail[0].ReceiptNO.ToString();
                billDateLaser.Text = "Date: " + lstBillingDetail[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("Bill_Policy", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    tdBillPolicy.Text = lstInventoryConfig[0].ConfigValue;
                    //tdBillPolicy.Visible = true;
                }
                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyFooter", OrgID, ILocationID, out lstInventoryConfig);
                 if (lstInventoryConfig.Count > 0)
                 {
                     tblFottor.Text = lstInventoryConfig[0].ConfigValue;
                     //tdBillPolicy.Visible = true;
                 }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}