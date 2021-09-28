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

public partial class CommonControls_InvReceipt : BaseControl
{
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string PharmacyBillNoConfig = string.Empty;
    string PharmacyBillNo = string.Empty;
    List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
    long returncode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (OrgID == 127)
            {
                OrgaddressDisplay.Style.Add("display", "block");
                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {

                    if (lstInventoryConfig[0].ConfigValue != "")
                    {
                        lblHospitalName.InnerText = lstInventoryConfig[0].ConfigValue;
                        returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyAddress", OrgID, ILocationID, out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {
                            lblOrgAddress.Style.Add("Font-Size", "12px");
                            lblOrgAddress.Text = lstInventoryConfig[0].ConfigValue;
                        }

                    }
                    else
                    {
                        lblHospitalName.InnerText = OrgName;
                    }
                }
            }
            else
            {
                lblHospitalName.InnerText = OrgName;
            }
        }
    }
    public void ReceiptPrinting(string ReceiptID, long FinalbillID)
    {
        try
        {

            //long visitID = Convert.ToInt64(Request.QueryString["VisitID"]);
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<Patient> lstPatientDetails = new List<Patient>();

            SharedInventory_BL invBL = new SharedInventory_BL(base.ContextInfo);
            //invBL.GetReceiptPrintingDetails(ReceiptID, out lstBillingDetail,
            //                                 out lstPatientDetails,
            //                                OrgID);

            if (lstBillingDetail.Count > 0)
            {

                // Bind Billing details  
                      
                gvBillingDetail.DataSource = lstBillingDetail;
                gvBillingDetail.DataBind();
              
                lblName.Text = lstPatientDetails[0].Name;
                lblPatientNumber.Text = lstPatientDetails[0].PatientNumber.ToString();
                if (lstPatientDetails[0].SEX == "M")
                {
                    lblSex.Text = "Male";
                }
                else
                {
                    lblSex.Text = "Female";
                }
                if (lstPatientDetails[0].IPNumber != null)
                {
                    lblIPNo.Visible = true;
                    lblIPNumber.Visible = true;
                    lblIPNumber.Text = lstPatientDetails[0].IPNumber;
                }
                else
                {
                    lblIPNo.Visible = false;
                    lblIPNumber.Visible = false;
                }
                lblAge.Text = lstPatientDetails[0].Age.ToString();
                //lblInvoiceNo.Text = lstFinalBillDetail[0].FinalBillID.ToString();
                lblInvoiceNo.Text = lstBillingDetail[0].ReceiptNO.ToString();
                lblInvoiceDate.Text = lstBillingDetail[0].CreatedAt.ToString("dd/MM/yyyy");

               
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("Show_Pharmacy_BillNo_EachReceipt_And_InterimBill", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    PharmacyBillNoConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
                }
                if (PharmacyBillNoConfig == "Y")
                {


                    if (lstBillingDetail.Count > 0)
                    {
                        PharmacyBillNo = lstBillingDetail[0].ReferenceType;
                        lblPharmacyBillNo.Text = PharmacyBillNo;
                        lblPBillNo.Visible = true;
                        lblPharmacyBillNo.Visible = true;

                    }

                }
                else
                {
                    lblPharmacyBillNo.Visible = false;
                    lblPBillNo.Visible = false;
                    PharmacyBillNo = "";
                }
                if (lstBillingDetail[0].Name==null || lstBillingDetail[0].Name=="")
                {
                    lblPhy.Visible = false;
                    lblPhysician.Visible = false;
                    phyDetails.Visible = false;
                }
                else
                {
                    lblPhy.Visible = true;
                    lblPhysician.Visible = true;
                    //
                    lblPhysician.Text = lstBillingDetail[0].Name;
                    
                    phyDetails.Visible = true;
                }
                decimal NetValue;
                string rval, roundpattern;
                rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
                roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
                hdnDefaultRoundoff.Value = rval;
                hdnRoundOffType.Value = roundpattern;
               
                if (rval != "" || roundpattern != "")//Round off is done by config value(orgbased)
                {
                    NetValue = lstBillingDetail.Sum(p => p.Rate);
                    lblAmountRecieved.Text = String.Format("{0:0.00}", lstBillingDetail[0].AmountReceived);
                }
                else
                {
                    NetValue = Math.Round(lstBillingDetail.Sum(p => p.Rate));
                    lblAmountRecieved.Text = String.Format("{0:0.00}", Math.Round(lstBillingDetail[0].AmountReceived));
                }
                lblNetValue.Text = String.Format("{0:0.00}", NetValue);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Roundoff", "javascript:Round();", true);

                
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                    {
                        lblAmount.Text = "Received Amount in Words " + CurrencyName + ":  " + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0]).ToString()) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblAmount.Text = "Received Amount in Words " + CurrencyName + ":  " + num.Convert(lblAmountRecieved.Text.Split('/')[0]).ToString() + " Only...";
                    }
                }
                else
                {
                    lblAmount.Text = "Received Amount in Words " + CurrencyName + ":  " + " Zero Only...";
                }

                //if (NetValue > 0)
                //{
                //    lblDisplayAmount.Text = "Net Amount in Words " + CurrencyName + ":  " + num.Convert(NetValue.ToString()) + " Only...";
                //}
                //else
                //{
                //    lblAmount.Text = "Net Amount in Words " + CurrencyName + ":  " + " Zero Only...";
                //}
                List<Users> lstUsers = new List<Users>();
                invBL.GetListOfUsers(OrgID, out lstUsers);

                lblBilledBy.Text = ("Billed By: (" + lstUsers.Find(P => P.LoginID == lstBillingDetail[0].CreatedBy).Name + ")").ToUpper();

                #region for Payment Mode changes

                List<PaymentType> lstPaymentType = new List<PaymentType>();
                List<PaymentType> lstOtherCurrency = new List<PaymentType>();
                List<PaymentType> lstDepositAmt = new List<PaymentType>();
                BillingEngine billingBL = new BillingEngine(base.ContextInfo);
                int payingPage = 2;
                long pvid = -1;
                if (Request.QueryString["vid"] != null)
                {
                    pvid=Convert.ToInt64(Request.QueryString["vid"]);
                }
                billingBL.GetPaymentMode(FinalbillID, pvid, ReceiptID, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
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
                
                lblPaymentMode.Text = appString;
                
                #endregion

            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There is no Receipt for this Patient";
                tblBillPrint.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in InvReceipt Printing page", ex);
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

    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((BillingDetails)e.Row.DataItem).ExpiryDate.ToString() == "01/01/1753 00:00:00")
            {
                e.Row.Cells[3].Text = "--";

            }

        }
    }
}
