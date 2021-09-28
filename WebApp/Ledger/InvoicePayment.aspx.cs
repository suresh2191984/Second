using System;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Solution.BusinessLogic_InvoiceLedger;
using Attune.Podium.BusinessEntities.CustomEntities;
using System.Linq;
using System.Web.UI;

public partial class Ledger_InvoicePayment : BasePage
{
    public List<LedgerInvoiceDetails> lstLedgerClient;
    public List<LedgerInvoiceDetails> lstLedgerInvoice;
    public List<LedgerInvoiceDetails> lstLedgerInvoiceCredits;
    public List<LedgerInvoiceDetails> lstLedgerInvoiceDebits;
    public List<LedgerInvoiceDetails> lstLedgerInvoiceBills;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                //AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
                Session["MultiplePaymentInvoiceID"] = null;
                Session["MultipleInvoiceClientID"] = null;
                Session["MultiplePaymentClientCode"] = null;
                Session["MultipleInvoicePaymentAmount"] = null;
                Session["MultipleInvoiceClientID"] = null;
                Session["MultiplePaymentInvoiceID"] = null;
               // Session["InvoicePaymentType"] = null;
                Session["InvoiceWiseCurrencyCode"] = null;
                Session["ClientPayingAmount"] = null;
                Session["PaymentClientCode"] = null;
                Session["ClientPaymentAmount"] = null;
                Session["ClientID"] = null;
                Session["PaymentInvoiceID"] = null;
                Session["SelectedBillID"] = null;
                //Session["BillPaymentType"] = null;
                Session["BillWiseCurrencyCode"] = null;
                Session["IsAdvanceUsed"] = null;
                Session["AdvanceRedeemed"] = null;
                
                hdnOrgID.Value = OrgID.ToString();
                tdFilterGrid.Style.Add("display", "none");
                tblhome.Style.Add("display", "none");
                GrdLedgerClient.Style.Add("display", "none");
                if (CID > 0)
                {
                    hdnCID.Value = CID.ToString();
                    hdnclientType.Value = "CLP";
                    GetClientLedgerInvoice(CID);
                }
                else
                {
                    masterdata.Style.Add("display", "");
                    tblhome.Style.Add("display", "none");
                    hdnCID.Value = "0";
                    hdnclientType.Value = "CLI";
                    GetMasterClient();
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load while Outsatnding List :" + ex.ToString() + " Inner Exception-", ex.InnerException);

        }
    }


    protected void GrdLedgerClient_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {         
            Label lblClientID = (Label)e.Row.FindControl("lblClientID");
            List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
            long clientid = Convert.ToInt64(lblClientID.Text);
            GridView gv_Child = (GridView)e.Row.FindControl("GrdLedgerInvoice");
            InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
            lstLedgerInvoiceDetails = lstLedgerInvoice.Where(x => x.ClientId == clientid).ToList();
            if (lstLedgerInvoiceDetails.Count > 0)
            {
                gv_Child.DataSource = lstLedgerInvoiceDetails;
                gv_Child.DataBind();
            }
        }
    }
    protected void GrdLedgerInvoice_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblInvoiceID = (Label)e.Row.FindControl("lblInvoiceID");
            Label lblAmountID = (Label)e.Row.FindControl("lblAmount");
            List<LedgerInvoiceDetails> lstLedgerInvoiceBillsDetails = new List<LedgerInvoiceDetails>();
            List<LedgerInvoiceDetails> lstLedgerInvoiceCreditsDetails = new List<LedgerInvoiceDetails>();
            List<LedgerInvoiceDetails> lstLedgerInvoiceDebitDetails = new List<LedgerInvoiceDetails>();
            long InvoiceID = Convert.ToInt64(lblInvoiceID.Text);
            decimal amount = Convert.ToDecimal(lblAmountID.Text);
            GridView gv_NestedChildBills = (GridView)e.Row.FindControl("GrdLedgerInvoiceBills");
            GridView gv_NestedChildCredits = (GridView)e.Row.FindControl("GrdLedgerInvoiceCredits");
            GridView gv_NestedChildDebits = (GridView)e.Row.FindControl("GrdLedgerInvoiceDebits");
            lstLedgerInvoiceBillsDetails = lstLedgerInvoiceBills.Where(x => x.InvoiceId == InvoiceID && x.OrgID==OrgID).ToList();
            lstLedgerInvoiceCreditsDetails = lstLedgerInvoiceCredits.Where(x => x.InvoiceId==InvoiceID && x.OrgID== OrgID).ToList();
            lstLedgerInvoiceDebitDetails = lstLedgerInvoiceDebits.Where(x => x.InvoiceId == InvoiceID && x.OrgID == OrgID).ToList();
            if (lstLedgerInvoiceBillsDetails.Count > 0)
            {
                gv_NestedChildBills.DataSource = lstLedgerInvoiceBillsDetails;
                gv_NestedChildBills.DataBind();
            }
            if (lstLedgerInvoiceCreditsDetails.Count > 0)
            {
                gv_NestedChildCredits.DataSource = lstLedgerInvoiceCreditsDetails;
                gv_NestedChildCredits.DataBind();
            }
            if (lstLedgerInvoiceDebitDetails.Count > 0)
            {
                gv_NestedChildDebits.DataSource = lstLedgerInvoiceDebitDetails;
                gv_NestedChildDebits.DataBind();
            }
            var CreditSum = lstLedgerInvoiceCreditsDetails.Sum(x => Convert.ToDecimal(x.Amount));
            var DebitSum = lstLedgerInvoiceDebitDetails.Sum(x => Convert.ToDecimal(x.Amount));
            Label lblBillSummary = (Label)e.Row.FindControl("lblBillSummary");
            Label lblDebitSummary = (Label)e.Row.FindControl("lblDebitSummary");
            Label lblCreditSummary = (Label)e.Row.FindControl("lblCreditSummary");
            Label lblSumBill = (Label)e.Row.FindControl("lblSumlBill");
            Label lblSumDebit = (Label)e.Row.FindControl("lblSumDebit");
            Label lblSumCredit = (Label)e.Row.FindControl("lblSumCredit");
            lblBillSummary.Text = amount.ToString();
            lblDebitSummary.Text = DebitSum.ToString();
            lblCreditSummary.Text = CreditSum.ToString();
            lblSumBill.Text = amount.ToString();
            lblSumDebit.Text = DebitSum.ToString();
            lblSumCredit.Text = CreditSum.ToString();
            decimal NetPay = 0;
            NetPay = (amount + DebitSum) - CreditSum;
            NetPay = amount;
            Label lblNetPay = (Label)e.Row.FindControl("lblTotalAmount");
            ImageButton lnkpay = (ImageButton)e.Row.FindControl("lnkPayAmount");
            ImageButton lnksubmit = (ImageButton)e.Row.FindControl("lnkPayAmountOffline");
            //ImageButton lnkMultiplepayOffline = (ImageButton)e.Row.FindControl("lnkMultiplePayAmountOffline");
            //ImageButton lnkMultipleOnline = (ImageButton)e.Row.FindControl("lnkMultiplePayAmountOnline");
            //if (ddlPaymentMode.SelectedValue.ToString() == "OFF")
            //{
            //    lnkpay.Style.Add("display", "none");
            //    lnksubmit.Style.Add("display", "");
            //}
            //else
            //{
            //    lnkpay.Style.Add("display", "");
            //    lnksubmit.Style.Add("display", "none");
            //}
            lblNetPay.Text = NetPay.ToString();
        }
    }
    public void GetClientLedgerInvoice(long ClientID)
    {
        try
        {
            lstLedgerClient = new List<LedgerInvoiceDetails>();
            lstLedgerInvoice = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceCredits = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceDebits = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceBills = new List<LedgerInvoiceDetails>();
            string ClientCode = "";
            InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
            objInvoiceLedger_BL.GetClientInvoiceDetails(ClientCode, ClientID, OrgID,
                out lstLedgerClient, out lstLedgerInvoice, out lstLedgerInvoiceCredits,
                out lstLedgerInvoiceDebits, out lstLedgerInvoiceBills);
            if (lstLedgerClient.Count > 0)
            {
                GrdLedgerClient.DataSource = lstLedgerClient;
                GrdLedgerClient.DataBind();
                tdFilterGrid.Style.Add("display", "none");
                GrdLedgerClient.Style.Add("display", "");

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL GetClientInvoice", ex);
        }
    }
    protected void GrdLedgerClient_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdLedgerClient.PageIndex = e.NewPageIndex;
        //GetClientLedgerInvoice();
    }
    protected void GrdLedgerClient_SelectedIndexChanged(object sender, EventArgs e)
    {
    //    long ClientId;
    //    try
    //    {
    //        foreach (GridViewRow row in GrdLedgerClient.Rows)
    //        {
    //            if (row.RowIndex == GrdLedgerClient.SelectedIndex)
    //            {
    //                row.ToolTip = string.Empty;
    //                Label hdndata = (Label)row.FindControl("lblClientID");
    //                ClientId = Convert.ToInt64(hdndata.Text);
    //                List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
    //                GridView gv_Child = (GridView)row.FindControl("GrdLedgerInvoice");
    //                InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
    //                lstLedgerInvoiceDetails = lstLedgerInvoice.Where(x => x.ClientId == ClientId).ToList();
    //                if (lstLedgerInvoiceDetails.Count > 0)
    //                {
    //                    gv_Child.DataSource = lstLedgerInvoiceDetails;
    //                    gv_Child.DataBind();
    //                }
    //            }
    //            else
    //            {
    //                row.ToolTip = "Click to select this row.";
    //                row.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading  grdApproval_SelectedIndexChanged in CreditDebitApproval.aspx :" + ex.ToString() + " Inner Exception-", ex.InnerException);

    //    }
    }
    protected void GrdLedgerInvoiceBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblLabelWithToolTip = e.Row.FindControl("lblLabelWithToolTip") as Label;
            string strFullText = lblLabelWithToolTip.Text;
 
            if (lblLabelWithToolTip.Text.Length > 5)
            {
                lblLabelWithToolTip.Text = lblLabelWithToolTip.Text.Substring(0, 5) + "...";
            }
            lblLabelWithToolTip.ToolTip = strFullText;
        }
    }
    public void GetMasterClient()
    {
        try
        {
            lstLedgerClient = new List<LedgerInvoiceDetails>();
            lstLedgerInvoice = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceCredits = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceDebits = new List<LedgerInvoiceDetails>();
            lstLedgerInvoiceBills = new List<LedgerInvoiceDetails>();
            string ClientCode = "";
            InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
            objInvoiceLedger_BL.GetClientInvoiceDetails(ClientCode, 0, OrgID,
                out lstLedgerClient, out lstLedgerInvoice, out lstLedgerInvoiceCredits,
                out lstLedgerInvoiceDebits, out lstLedgerInvoiceBills);
            if (lstLedgerClient.Count > 0)
            {
                grdOutstanding.DataSource = lstLedgerClient;
                grdOutstanding.DataBind();
                tdFilterGrid.Style.Add("display", "");
                masterdata.Style.Add("display", "");
                GrdLedgerClient.DataSource = null;
                GrdLedgerClient.DataBind();
                GrdLedgerClient.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL GetMasterClient", ex);
        }
    }
    protected void grdOutstanding_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdOutstanding.PageIndex = e.NewPageIndex;
        GetMasterClient();
    }
    protected void lnkpay_Click(object sender, EventArgs e)
    {
        long ClientId = 0;
        string CurrencyCode = string.Empty;
        LinkButton lnk = (LinkButton)sender;
        GridViewRow gr = (GridViewRow)lnk.NamingContainer;
        ClientId = Convert.ToInt64(grdOutstanding.DataKeys[gr.RowIndex].Values["ClientId"].ToString());
        try
        {
            if (ClientId!=0)
            {
                Session["DueAdvanceAmount"] = null;
                InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
                List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
                objInvoiceLedger_BL.GetClientAdvanceAmount(ClientId, OrgID, out lstLedgerInvoiceDetails);
                if (lstLedgerInvoiceDetails.Count > 0)
                {
                 Session["DueAdvanceAmount"] = lstLedgerInvoiceDetails[0].TotalAdvanceAmount.ToString();
                }   
                masterdata.Style.Add("display", "none");
                tblhome.Style.Add("display", "");
                GetClientLedgerInvoice(ClientId);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading lnkpay_Click in page ClientOutstandingPayment.aspx :" + ex.ToString() + " Inner Exception-", ex.InnerException);

        }
    }
    protected void btnhome_Click(object sender, EventArgs e)
    {
        Response.Redirect("InvoicePayment.aspx");
    }
}

