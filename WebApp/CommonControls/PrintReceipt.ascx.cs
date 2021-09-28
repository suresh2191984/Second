using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;

public partial class CommonControls_PrintReceipt : BaseControl
{
    public long OutFlowID { get; set; }
    protected string _ReceiptNo = "";
    public string ReceiptNo
    {
        get { return _ReceiptNo; }
        set { _ReceiptNo = value; }
    }
    static decimal TotalVal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblHospitalName.InnerHtml = OrgName;
            List<Config> lstConfig = new List<Config>();

            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.Receipt;

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

            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            lblAccountant.Text = "AUTHORIZED SIGNATORY";
            lblReceiverSign.Text = "RECEIVER NAME";
        }
    }
    public void SetBillDetails()
    {
        List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
        BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
        List<CashOutFlowDetails> lstFlowDetails = new List<CashOutFlowDetails>();
        List<CashOutFlow> lstFLow = new List<CashOutFlow>();
        List<IncSourcePaidDetails> lstCashInFlowDetails = new List<IncSourcePaidDetails>();

        long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblCurrency.Text = lstConfig[0].ConfigValue;
        }
        else
        {
            lblCurrency.Text = CurrencyName;
        }
        string ReceiptType = "INC";
        objBillingBL.GetVoucherDetails(OutFlowID, out lstFlowDetails, out lstFLow, ReceiptNo, ReceiptType, out lstCashInFlowDetails);
        if (lstCashInFlowDetails.Count > 0)
        {
            gvPaymentModes.DataSource = lstCashInFlowDetails;
            gvPaymentModes.DataBind();
            lblRemarks.Text = lstCashInFlowDetails[0].Description;
            lblReceiptNo.Text = lstCashInFlowDetails[0].ReceiptNo;
            lblAmount.Text = lstCashInFlowDetails.Sum(p => p.AmountReceived).ToString("0.00");
            lblTotal.Text = lstCashInFlowDetails.Sum(p => p.AmountReceived).ToString("0.00");
            lblReceivedBy.Text = "( " + lstCashInFlowDetails[0].CurrencyName + " )";
            lblPaidDate.Text = lstCashInFlowDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
            lblName.Text = lstCashInFlowDetails[0].Status;
        }
        if (lblAmount.Text != "")
        {
            if (Convert.ToDouble(lblAmount.Text) > 0)
            {
                if (int.Parse(lblAmount.Text.Split('.')[1]) > 0)
                {
                    lblAmount.Text = "" + Utilities.FormatNumber2Word(num.Convert(lblAmount.Text)) + " " + MinorCurrencyName + " Only...";
                }
                else
                {
                    lblAmount.Text = "" + num.Convert(lblAmount.Text) + " Only...";
                }
            }
        }
        else
        {
            lblAmount.Text = " Zero Only...";
        }
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    protected void gvPaymentModes_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblCardChequeNo = (Label)e.Row.FindControl("lblCardChequeNo");
            if (lblCardChequeNo.Text == "0")
            {
                lblCardChequeNo.Text = "N/A";
            }
            Label lblBankName = (Label)e.Row.FindControl("lblBankName");
            if (lblBankName.Text == "")
            {
                lblBankName.Text = "N/A";
            }
            Label lblAmountReceived = (Label)e.Row.FindControl("lblAmountReceived");
            if (lblAmountReceived.Text != "")
            {
                if (Convert.ToDecimal(lblAmountReceived.Text) > 0)
                {
                    TotalVal += Convert.ToDecimal(lblAmountReceived.Text);
                }
            }
        }
    }
}
