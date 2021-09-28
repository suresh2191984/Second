using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_INVBillPrint : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        long returncode = -1;
        if (!Page.IsPostBack)
        {

            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);


            if (lstInventoryConfig.Count > 0)
            {
                lblHospitalName.InnerText = lstInventoryConfig[0].ConfigValue;
            }

            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyAddress", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {

                lblHospitalAddress.Text = lstInventoryConfig[0].ConfigValue;
            }

        }
       
    }

    protected void gvBillingDetail_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
                Label lblExpiry = (Label)e.Row.FindControl("lblExpiry");

                if (DateTime.Parse(lblExpiry.Text)<= DateTime.Parse("01/01/1901"))
                {
                    lblExpiry.Text = "--";
                }
                else
                {
                    lblExpiry.Text = (DateTime.Parse(lblExpiry.Text)).ToString("MMM-yyyy");
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while loading bill detail grid", Ex);
        }
    }

    public void BillPrinting(long visitID, long FinalbillID)
    {
        try
        {
           
            string physicianName = string.Empty;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();

            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            //inventoryBL.GetInvBillPrintingDetails(visitID, out lstBillingDetail,
            //                                out lstFinalBillDetail, out lstPatientDetails,
            //                                out lstOrganization, out physicianName,
            //                                out lstDuePaidDetails, FinalbillID);
            List<Users> lstUsers = new List<Users>();
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);
           

            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
            {

              
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

                lblName.Text = lstFinalBillDetail[0].Name;
                if (lstFinalBillDetail[0].Physician == "")
                {
                    tdphy.Attributes.Add("display", "none");
                }
                lblPhysician.Text = lstFinalBillDetail[0].Physician;
                if (lstPatientDetails.Count > 0)
                {
                    lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                   
                }
                else
                {
                    lblPatientNumber.Visible = false;
                    lblPatientNo.Visible = false;
                }

                lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString();
               
                lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                lblDiscount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].DiscountAmount) + "/-";
                lblSubTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue) + "/-";
                lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue+lstFinalBillDetail[0].TaxPercent)+ "/-";
                lblGrandTotal.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue) + "/-";
                lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived) + "/-";
                lblTax.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].TaxPercent) + "/-";
                lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due) + "/-";
                if (isDueBill != "Y")
                {
                    lblPreviousDue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].CurrentDue) + "/-";
                }
                else
                {
                    lblPreviousDue.Text = String.Format("{0:0.00}", "0");
                }
                if (isDueBill != "Y")
                {
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue) + "/-";
                }
                else
                {
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue) + "/-";
                }

                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                    {
                        lblAmount.Text = "Amount in Words: (" + CurrencyName + ") " + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblAmount.Text = "Amount in Words: (" + CurrencyName + ") " + num.Convert(lblAmountRecieved.Text.Split('/')[0]) + " Only...";
                    }
                }
                else
                {
                    lblAmount.Text = "Amount in Words: Zero Only...";
                }
                tdSoldByLaser.Text = "Sold By: " + lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name;

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("Bill_Policy", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    lblPolicy.Text = lstInventoryConfig[0].ConfigValue;
                    lblPolicy.Visible = true;
                }

                #region for payment mode
                int payingPage = 1;
                decimal depamt = 0;
                string ReceiptNo = string.Empty;
                BillingEngine billingBL = new BillingEngine(base.ContextInfo);
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
                        if (flag == 0)
                        {
                            //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            appString = lstPaymentType[i].PayDetails + "<br>";
                        }
                        else
                        {
                            //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                            appString = appString + lstPaymentType[i].PayDetails + "<br>";
                        }
                        flag++;

                    }
                    lblPaymentMode.Text = appString;
                }
                else
                {
                    lblPayment.Visible = false;
                }
                if (lstDepositAmt.Count > 0)
                {
                    //trDeposit.Attributes.Add("display", "block");
                    lblDepositAmtUsed.Visible = true;
                    lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                    depamt = lstDepositAmt[0].AmountUsed;
                    lblPayment.Visible = true;
                }
               
                #endregion

            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There is no Bill for this Patient";
                tblBillPrint.Visible = false;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
}
