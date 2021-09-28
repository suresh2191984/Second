using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;

public partial class Cashier_CashDenominationForm : BasePage
{
    List<CashClosureDenomination> lstCCdeno = new List<CashClosureDenomination>();
    List<CashClosureDenominationMaster> lstCCdenoMaster = new List<CashClosureDenominationMaster>();
    long returnCode = -1;
    BillingEngine billingBL;
    List<ReceivedAmount> lstSplitDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstAmountReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstAmountRefundDetails = new List<ReceivedAmount>();
    List<Users> lstUsers = new List<Users>();
    List<AmountClosureDetails> lstAmountClosure = new List<AmountClosureDetails>();
    List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstINDAmtReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstINDIPAmtReceivedDetails = new List<ReceivedAmount>();
    List<CurrencyOrgMapping> lstCurrencyInHand = new List<CurrencyOrgMapping>();
    List<CashClosureDenomination> lstCCDeno = new List<CashClosureDenomination>();


    protected void Page_Load(object sender, EventArgs e)
    {
        billingBL = new BillingEngine(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadDenominationDetails();
            GetUserClosureDetail();
        }
    }
    private void GetUserClosureDetail()
    {
        decimal totalAmount = 0;
        decimal TotalIncAmount = 0;
        decimal refundAmount = 0; decimal cancellationAmount = 0;
        decimal drAmount;
        decimal othersAmount = 0;
        string sstatus = string.Empty;
        long retval = -1;
        string sAllAmtReceivedID = string.Empty;

        string sRcvdFromtime = string.Empty;
        string sRcvdTotime = string.Empty;
        string sRefundFromtime = string.Empty;
        string sRefundTotime = string.Empty;
        string sMinStartTime = string.Empty;
        string sMaxEndTime = string.Empty;

        DateTime pFDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime pTDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        totalAmount = 0;
        refundAmount = 0;
        drAmount = 0;
        decimal TotalPendingSettledAmount = 0;

        long lUserID = LID;
        List<AmountReceivedDetails> lstreceivedTypes = new List<AmountReceivedDetails>();
        List<AmountReceivedDetails> lstIncSourcePaidDetails = new List<AmountReceivedDetails>();
        retval = billingBL.GetAmountReceivedDetails(lUserID, OrgID, pFDT, pTDT,0,
                    out lstAmountReceivedDetails,
                    out lstAmountRefundDetails,
                    out lstPaymentDetails,
                    out totalAmount,
                    out refundAmount, out cancellationAmount, out sRcvdFromtime,
                    out sRcvdTotime, out sRefundFromtime,
                    out sRefundTotime, out sMinStartTime,
                    out sMaxEndTime, out drAmount,
                    out othersAmount,
                    out  TotalIncAmount,
                    out lstINDAmtReceivedDetails,
                    out lstINDIPAmtReceivedDetails,
                    out lstreceivedTypes, out lstSplitDetails,
                    out lstIncSourcePaidDetails,
                    out lstCurrencyInHand,
                    out lstCCDeno,
                    out TotalPendingSettledAmount);
        if (retval == 0)
        {
            if (sRcvdFromtime != null && sRcvdFromtime != "")
            {
                lblReceivedTime.Visible = true;
                lblReceivedTime.Text = "Received time from : " + sRcvdFromtime + " To " + sRcvdTotime;
            }
            else
            {
                lblReceivedTime.Visible = false;
            }

            if (sRefundFromtime != "" && sRefundFromtime != null)
            {
                lblRefundTime.Visible = true;
                lblRefundTime.Text = "Refunded time from : " + sRefundFromtime + " To " + sRefundTotime;
            }
            else
            {
                lblRefundTime.Visible = false;
            }
            //gvAmountBreakup.Columns.Clear();




        }
        else
        {
            divtimeDisplay.Visible = false;
            lblReceivedTime.Text = "";
            lblRefundTime.Text = "";

        }
        if (totalAmount > 0)
        {
            lblTotal.Text = totalAmount.ToString();
        }
        else
        {
            lblTotal.Text = "0.00";
        }
        if (refundAmount > 0)
        {
            lblRefund.Text = refundAmount.ToString();

        }
        else
        {
            lblRefund.Text = "0.00";
        }
        if (cancellationAmount > 0)
        {
            lblCancelledAmount.Text = cancellationAmount.ToString();
        }
        else
        {
            lblCancelledAmount.Text = "0.00";
        }
        if (drAmount > 0)
        {
            lblPhyAmount.Text = drAmount.ToString();
        }
        else
        {
            lblPhyAmount.Text = "0.00";
        }
        if (othersAmount > 0)
        {
            lblOthersAmount.Text = othersAmount.ToString();
        }
        else
        {
            lblOthersAmount.Text = "0.00";
        }
        refundAmount = (refundAmount == -1 ? 0 : refundAmount);
        totalAmount = (totalAmount == -1 ? 0 : totalAmount);
        cancellationAmount = (cancellationAmount == -1 ? 0 : cancellationAmount);
        lblClosingBalance.Text = (totalAmount - refundAmount - cancellationAmount - drAmount - othersAmount).ToString();
        //GetCollectionWiseDetails(sMinStartTime, sMaxEndTime);

        string cashInHand = string.Empty;
        foreach (CurrencyOrgMapping objCIH in lstCurrencyInHand)
        {
            cashInHand += objCIH.CurrencyName + " - ";
            if (objCIH.IsBaseCurrency == "Y")
            {
                cashInHand += (Convert.ToDecimal(objCIH.ConversionRate) - Convert.ToDecimal((Convert.ToDecimal(totalAmount) - Convert.ToDecimal(lblClosingBalance.Text)))).ToString();
                cashInHand += "<br>";
            }
            else
            {
                cashInHand += objCIH.ConversionRate.ToString();
                cashInHand += "<br>";
            }
        }
        lblClosingCashInHand.Text = cashInHand;
        if (lstCurrencyInHand.Count > 1)
        {
            trCashInHand.Style.Add("display", "block");
        }
        else
        {
            trCashInHand.Style.Add("display", "none");
        }

    }
    private void LoadDenominationDetails()
    {
        returnCode = billingBL.GetCashClosureDenominationMaster(OrgID, out lstCCdenoMaster);
        if (lstCCdenoMaster.Count > 0)
        {
            grdResult.DataSource = lstCCdenoMaster;
            grdResult.DataBind();
        }


    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
                Label lblDetail = (Label)e.Row.FindControl("lblDetail");
                Label lblSumAmt = (Label)e.Row.FindControl("lblSumAmt");
                HiddenField hdnSumAmount = (HiddenField)e.Row.FindControl("hdnSumAmount");
                HiddenField hdnOldPrice = (HiddenField)e.Row.FindControl("hdnOldPrice");
                string sFunProcedures = "CalcItemCost('" + lblDetail.ClientID +
                                                  "','" + txtAmount.ClientID +
                                                  "','" + lblSumAmt.ClientID +
                                                  "','" + hdnSumAmount.ClientID +
                                                  "','" + hdnOldPrice.ClientID +
                                                  "');";

                txtAmount.Attributes.Add("onchange", sFunProcedures);
                // txtAmount.Attributes.Add("onblur", sFunProcedures);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        string CCID = string.Empty;
        List<CashClosureDenomination> lstCCD = new List<CashClosureDenomination>();
        foreach (GridViewRow GR in grdResult.Rows)
        {
            CashClosureDenomination lstChart = new CashClosureDenomination();
            Label lblID = (Label)GR.FindControl("lblID");
            TextBox txtAmount = (TextBox)GR.FindControl("txtAmount");
            Label lblSumAmt = (Label)GR.FindControl("lblSumAmt");
            HiddenField hdnSumAmount = (HiddenField)GR.FindControl("hdnSumAmount");
            long id = Convert.ToInt64(lblID.Text);
            decimal lbAmount = Convert.ToDecimal(hdnSumAmount.Value);
            decimal txsum = Convert.ToDecimal(txtAmount.Text);
            if (lbAmount > 0)
            {
                lstChart.DenominationID = id;
                lstChart.Unit = txsum;
                lstChart.Amount = lbAmount;
                lstChart.LoginID = LID;
            }
            lstCCD.Add(lstChart);
        }
        returnCode = billingBL.InsertCashClosureDenomination(OrgID, lstCCD, LID, 0, out CCID);
        string sPage = string.Empty;
        sPage = "../Billing/CCDenomination.aspx?CCID=" + CCID.ToString()
                  + "&IsPopup=Y";


        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:openPOPupQuick('" + sPage + "');", true);

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
