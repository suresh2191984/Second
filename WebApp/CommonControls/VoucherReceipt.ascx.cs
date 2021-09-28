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

public partial class CommonControls_AdvanceReceipt : BaseControl
{
    protected string _ReceiverName = "";
    public string ReceiverName
    {
        get { return _ReceiverName; }
        set { _ReceiverName = value; }
    }

    protected string _PaidDate = "";
    public string PaidDate
    {
        get { return _PaidDate; }
        set { _PaidDate = value; }
    }
    protected string _VoucherNo = "";
    public string VoucherNo
    {
        get { return _VoucherNo; }
        set { _VoucherNo = value; }
    }

    protected string _Amount = "0";

    public string Amount
    {
        get { return _Amount; }
        set { _Amount = value; }
    }
    public long OutFlowID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblHospitalName.InnerHtml = OrgName;
            List<Config> lstConfig = new List<Config>();

            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.Voucher;

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

            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            //lblAccountant.Text = "ACCOUNTANT";
            //lblDirector.Text = "DIRECTOR";
            lblAccountant.Text = "AUTHORIZED SIGNATORY";
            lblReceiverSign.Text = "RECEIVER NAME <br>(with sign and Date)";
        }
    }

    public void SetBillDetails()
    {
        //lblName.Text = ReceiverName;
        //lblAmount.Text = Amount;
        //lblTotal.Text = Amount;
        //lblVoucherNo.Text = VoucherNo;
        //if (Request.QueryString["BBY"] != null)
        //{
        //    string billedby = string.Empty;
        //    billedby = Request.QueryString["BBY"].ToString();
        //    lblPassedBy.Text = ("Passed By <br>(" + billedby + ")").ToUpper();
        //}
        //else
        //{
        //    lblPassedBy.Text = ("Passed By <br>(" + UserName + ")").ToUpper();
        //}
        //lblPaidDate.Text = PaidDate;
        List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblCurrency.Text = lstConfig[0].ConfigValue;
        }
        else
        {
            lblCurrency.Text = CurrencyName;
        }
        BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
        List<CashOutFlowDetails> lstFlowDetails = new List<CashOutFlowDetails>();
        List<CashOutFlow> lstFLow = new List<CashOutFlow>();
        List<IncSourcePaidDetails> lstCashInFlowDetails = new List<IncSourcePaidDetails>();
        string VoucherNo = string.Empty;
        string VoucherType = string.Empty;
        objBillingBL.GetVoucherDetails(OutFlowID, out lstFlowDetails, out lstFLow, VoucherNo, VoucherType, out lstCashInFlowDetails);

        gvPaymentModes.DataSource = lstFlowDetails;
        gvPaymentModes.DataBind();
        if (lstFLow.Count > 0)
        {
            lblRemarks.Text = lstFLow[0].Remarks;
            lblName.Text = lstFLow[0].ReceiverName.ToString();
            lblAmount.Text = lstFLow[0].AmountReceived.ToString();
            lblTotal.Text = lstFLow[0].AmountReceived.ToString();
            lblVoucherNo.Text = lstFLow[0].VoucherNO.ToString();
            lblPaidDate.Text = lstFLow[0].DateFrom.ToString("dd/MM/yyyy hh:mm tt");
        }
        if (lstFlowDetails.Count > 0)
        {
            lblPassedBy.Text = ("Passed By <br>(" + lstFlowDetails[0].BilledBy.ToString() + ")").ToUpper();
        }
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
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
        }
    }
}
