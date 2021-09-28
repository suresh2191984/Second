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

public partial class CommonControls_InvRefundRecepit : BaseControl 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblHospitalName.InnerText = OrgName;
        }

    }
    public void ReceiptPrinting(string ReceiptID, long FinalbillID, long BillingDetailsID)
    {
        try
        {
            //long visitID = Convert.ToInt64(Request.QueryString["VisitID"]);
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();


            SharedInventory_BL invBL = new SharedInventory_BL(base.ContextInfo);
            //invBL.GetRefundReceiptPrintingDetails(ReceiptID, out lstAmountRefundDetails,
            //                                 out lstPatientDetails,
            //                                OrgID,BillingDetailsID);

            if (lstAmountRefundDetails.Count > 0)
            {

                // Bind Billing details
                gvBillingDetail.DataSource = lstAmountRefundDetails;
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
                lblInvoiceNo.Text = lstAmountRefundDetails[0].ReceiptNo .ToString();
                lblInvoiceDate.Text = lstAmountRefundDetails[0].CreatedAt.ToString("dd/MM/yyyy");
                if (lstAmountRefundDetails[0].Name == "")
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
                    lblPhysician.Text = lstAmountRefundDetails[0].Name;

                    phyDetails.Visible = true;
                }
                decimal NetValue = lstAmountRefundDetails.Sum(p => p.Rate);

                lblNetValue.Text = String.Format("{0:0.00}", NetValue);
                lblAmountRecieved.Text = String.Format("{0:0.00}", NetValue);
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                    {
                        lblAmount.Text = "Refund Amount in Words " + CurrencyName + ":  " + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0]).ToString()) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblAmount.Text = "Refund Amount in Words " + CurrencyName + ":  " + num.Convert(lblAmountRecieved.Text.Split('/')[0]).ToString() + " Only...";
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

                lblBilledBy.Text = ("Billed By: (" + lstUsers.Find(P => P.LoginID == lstAmountRefundDetails[0].CreatedBy).Name + ")").ToUpper();
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




}
