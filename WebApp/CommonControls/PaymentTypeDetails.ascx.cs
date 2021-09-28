using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;

public partial class CommonControls_PaymentTypeDetails : BaseControl
{
    public CommonControls_PaymentTypeDetails()
        : base("CommonControls_PaymentTypeDetails_ascx")
    {
    }
    List<PaymentType> lstPaymentType = new List<PaymentType>();
    string UsrMsgselLoc = Resources.CommonControls_AppMsg.CommonControls_PaymentTypeDetails_ascx_21 == null ? "---Select----" : Resources.CommonControls_AppMsg.CommonControls_PaymentTypeDetails_ascx_21;
    BillingEngine objBillingEngine;
    long retval = -1;
    public string IsQuickBilling { get; set; }
    Master_BL masterBL;
    long returnCode = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    public bool Refresh
    {
        set
        {
            if (value == true)
            {
                hdfPaymentType.Value = string.Empty;
            }
        }
    }
    private bool enabledCurrType = true;
    public bool EnabledCurrType
    {
        get { return enabledCurrType; }
        set { enabledCurrType = value; }
    }
    private decimal givenAmount = 0;
    public decimal GivenAmount
    {
        get { return givenAmount; }
        set { givenAmount = value; }
    }
    private decimal balanceAmount = 0;
    public decimal BalanceAmount
    {
        get { return balanceAmount; }
        set { balanceAmount = value; }
    }

    public int settabindex(int TabIndexs)
    {
        //ddlPaymentType.TabIndex = (short)(TabIndexs++);
        //txtAmount.TabIndex = (short)(TabIndexs++);
        //txtNumber.TabIndex = (short)(TabIndexs++);
        //txtBankType.TabIndex = (short)(TabIndexs++);
        //txtServiceCharge.TabIndex = (short)(TabIndexs++);
        //TabIndexs = TabIndexs + 2;
        return TabIndexs;
    }
    public short setTabIndex()
    {
        return (short)(txtServiceCharge.TabIndex + 1);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);

        ScriptReference srf = new ScriptReference();
        AutoCompleteProduct.ContextKey = "0" + '~' + "Bank";
        hdnOrgID.Value = OrgID.ToString();
        this.Page.RegisterStartupScript("Paymentscrpt", "<script>CreatePaymentTables();</script>");
        if (!IsPostBack)
        {
            try
            {
                ddlPaymentType.Items.Clear();
                objBillingEngine = new BillingEngine(base.ContextInfo);
                retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
                if (lstPaymentType.Count > 0)
                {
                    ddlPaymentType.DataSource = lstPaymentType;
                    ddlPaymentType.DataTextField = "PaymentName";
                    //ddlPaymentType.DataValueField = "PaymentTypeID";
                    ddlPaymentType.DataValueField = "PTypeIDIsRequired";
                    ddlPaymentType.DataBind();
                }
                //ddlPaymentType.Items.Insert(0, new ListItem("-- Select --", "0"));
                ddlPaymentType.SelectedValue = Convert.ToString(lstPaymentType.Find(p => p.IsDefault == "Y").PTypeIDIsRequired);
                hdfDefaultPaymentMode.Value = ddlPaymentType.SelectedValue.ToString();


                List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
                masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
                hdnBaseCurrencyID.Value = BaseCurrencyID.ToString();

                loadCurrency();

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Loading Quick Billing Details.", ex);

            }


        }
        ddCurrency.SelectedValue = hdnBaseCurrencyValue.Value;

        List<Config> lstconfig = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("TrackEMIForCards", OrgID, out lstconfig);

        if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
        {
            hdnIsEMI.Value = "Y";
            trERM.Style.Add("display", "table-row");
        }
        else
        {
            trERM.Style.Add("display", "none");
        }
        //this.Page.RegisterClientScriptBlock("Paymentscrpt", "<script>Paymentchanged();</script>");
    }

    private void loadCurrency()
    {
        List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
        masterBL.GetCurrencyForRateConversion(OrgID, "Y", out lstCurrOrgMapp);
        ddCurrency.Enabled = false;
        ddCurrency.DataSource = lstCurrOrgMapp;
        ddCurrency.DataTextField = "CurrencyName";
        ddCurrency.DataValueField = "IsBaseCurrency";
        ddCurrency.DataBind();
        ddCurrency.Items.Insert(0, new ListItem(UsrMsgselLoc, "0"));
        string CurrID = "";
        CurrID = lstCurrOrgMapp.Find(P => P.CurrencyID.ToString() == hdnBaseCurrencyID.Value).IsBaseCurrency;
        hdnBaseCurrencyValue.Value = CurrID;
        hdnOtherCurrencyRate.Value = lstCurrOrgMapp.Find(P => P.CurrencyID.ToString() == hdnBaseCurrencyID.Value).ConversionRate.ToString();
        if (lstCurrOrgMapp.Count > 1 && EnabledCurrType == true)
        {
            ddCurrency.Enabled = true;
        }
    }
    public void clearDatas()
    {
        hdfPaymentType.Value = "";
        hdnPaymentsDeleted.Value = "";
        //this.Page.RegisterClientScriptBlock("Paymentscrpt1", "<script>CreatePaymentTables();</script>");

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  CreatePaymentTables();", true);
    }
    public DataTable GetAmountReceivedDetails()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        System.Data.DataTable _datatable = new System.Data.DataTable();

        _datatable.Columns.Add("AmtReceived", typeof(System.Decimal));
        _datatable.Columns.Add("TypeID", typeof(System.Int32));
        _datatable.Columns.Add("ChequeorCardNumber", typeof(System.String));
        _datatable.Columns.Add("BankNameorCardType", typeof(System.String));
        _datatable.Columns.Add("Remarks", typeof(System.String));
        _datatable.Columns.Add("ChequeValidDate", typeof(System.DateTime));
        _datatable.Columns.Add("ServiceCharge", typeof(System.Decimal));
        _datatable.Columns.Add("BaseCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("PaidCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("OtherCurrencyAmount", typeof(System.Decimal));
        _datatable.Columns.Add("EMIOpted", typeof(System.String));
        _datatable.Columns.Add("EMIROI", typeof(System.Decimal));
        _datatable.Columns.Add("EMITenor", typeof(System.Int32));
        _datatable.Columns.Add("EMIValue", typeof(System.Decimal));
        _datatable.Columns.Add("ReferenceID", typeof(System.Int64));
        _datatable.Columns.Add("ReferenceType", typeof(System.String));
        _datatable.Columns.Add("Units", typeof(System.Int32));
        _datatable.Columns.Add("CardHolderName", typeof(System.String));
        _datatable.Columns.Add("CashGiven", typeof(System.Decimal));
        _datatable.Columns.Add("BalanceGiven", typeof(System.Decimal));
        _datatable.Columns.Add("TransactionID", typeof(System.String));
        _datatable.Columns.Add("BranchName", typeof(System.String));
        _datatable.Columns.Add("PaymentCollectedFrom", typeof(System.String));
        _datatable.Columns.Add("IsOutStation", typeof(System.String));
        _datatable.Columns.Add("AmtReceivedID", typeof(System.Int64));
        _datatable.Columns.Add("AuthorisationCode", typeof(System.String));
        DataRow _datarow;

        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;

        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                AmountReceivedDetails amtReceived = new AmountReceivedDetails();
                _datarow = _datatable.NewRow();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    //"RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "";
                    // RID^0~PaymentNAME^Debit Card~PaymentAmount^5000.00~PaymenMNumber^1212121~PaymentBank^sdksdsk~PaymentRemarks^~PaymentTypeID^3~ServiceCharge^1.50~TotalAmount^5075.00
                    switch (colName)
                    {
                        //case "TotalAmount":
                        ///Table Header PaymentAmount is interchanged to OtherCurrAmt
                        /// Table Value AmtReceived is interchanged to OtherCurrencyAmount
                        /// Modi By: Kutti  A
                        /// 28/12/2010

                        case "PaymentAmount":
                            colValue = (colValue == "" ? "0" : colValue);

                            _datarow["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["ChequeorCardNumber"] = (colValue);
                            break;
                        case "PaymentBank":
                            _datarow["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            _datarow["Remarks"] = colValue;
                            break;
                        case "PaymentTypeID":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["TypeID"] = Convert.ToInt32(colValue);
                            break;
                        case "ChequeValidDate":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            _datarow["ChequeValidDate"] = Convert.ToDateTime(colValue);
                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                        case "OtherCurrAmt":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["AmtReceived"] = Convert.ToDecimal(colValue);
                            break;
                        case "EMIROI":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMIROI"] = Convert.ToDecimal(colValue);
                            break;

                        case "EMITenor":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMITenor"] = Convert.ToInt16(colValue);
                            break;
                        case "EMIValue":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMIValue"] = Convert.ToDecimal(colValue);
                            break;
                        case "ReferenceID":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ReferenceID"] = Convert.ToInt64(colValue);
                            break;
                        case "ReferenceType":
                            _datarow["ReferenceType"] = colValue;
                            break;
                        case "Units":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["Units"] = Convert.ToInt32(colValue);
                            break;
                        case "CardHolderName":
                            _datarow["CardHolderName"] = colValue;
                            break;
                    };

                    if (hdnIsEMI.Value == "Y")
                    {
                        _datarow["EMIOpted"] = "Y";
                    }
                    else
                    {
                        _datarow["EMIOpted"] = "N";
                    }
                    _datarow["BaseCurrencyID"] = Convert.ToInt32(hdnBaseCurrencyID.Value);
                    _datarow["PaidCurrencyID"] = Convert.ToInt32(hdnOtherCurrencyID.Value);
                    _datarow["CashGiven"] = GivenAmount;
                    _datarow["BalanceGiven"] = BalanceAmount;
                    _datarow["TransactionID"] = string.Empty;
                    _datarow["BranchName"] = string.Empty;
                    _datarow["PaymentCollectedFrom"] =
                    _datarow["IsOutStation"] = "";
                    _datarow["AmtReceivedID"] = 0;
                    _datarow["AuthorisationCode"] = string.Empty;

                }
                _datatable.Rows.Add(_datarow);
            }
        }
        return _datatable;
    }

    public DataTable GetFeeTypeAmountReceivedDetails(string pFeeType)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        System.Data.DataTable _datatable = new System.Data.DataTable();

        _datatable.Columns.Add("AdvanceAmount", typeof(System.Decimal));
        _datatable.Columns.Add("TypeID", typeof(System.Int32));
        _datatable.Columns.Add("ChequeorCardNumber", typeof(System.String));
        _datatable.Columns.Add("BankNameorCardType", typeof(System.String));
        _datatable.Columns.Add("Remarks", typeof(System.String));
        _datatable.Columns.Add("AdvanceTypeID", typeof(System.Int64));
        _datatable.Columns.Add("AdvanceType", typeof(System.String));
        _datatable.Columns.Add("ServiceCharge", typeof(System.Decimal));
        _datatable.Columns.Add("BaseCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("PaidCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("OtherCurrencyAmount", typeof(System.Decimal));

        DataRow _datarow;

        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;

        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                AmountReceivedDetails amtReceived = new AmountReceivedDetails();
                _datarow = _datatable.NewRow();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    //"RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "";

                    switch (colName)
                    {
                        //case "TotalAmount":
                        ///Table Header TotalAmount is interchanged to OtherCurrAmt
                        /// Table Value AmtReceived is interchanged to OtherCurrencyAmount
                        /// Modi By: Kutti  A
                        /// 28/12/2010

                        case "TotalAmount":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                        case "PaymentTypeID":
                            _datarow["TypeID"] = Convert.ToInt32(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["ChequeorCardNumber"] = colValue;
                            break;
                        case "PaymentBank":
                            _datarow["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            _datarow["Remarks"] = colValue;
                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                        case "OtherCurrAmt":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["AdvanceAmount"] = Convert.ToDecimal(colValue);
                            break;

                    };
                    _datarow["AdvanceType"] = pFeeType;
                    _datarow["BaseCurrencyID"] = Convert.ToInt32(hdnBaseCurrencyID.Value);
                    _datarow["PaidCurrencyID"] = Convert.ToInt32(hdnOtherCurrencyID.Value);
                }
                _datatable.Rows.Add(_datarow);
            }
        }
        return _datatable;
    }



    public void GetOtherCurrReceivedDetails(out int BaseCurrencyID, out int PaidCurrencyID)
    {
        BaseCurrencyID = 0;
        PaidCurrencyID = 0;

        Int32.TryParse(hdnBaseCurrencyID.Value, out BaseCurrencyID);
        Int32.TryParse(hdnOtherCurrencyID.Value, out PaidCurrencyID);
    }
    public void TPALAB()
    {
        txtAmount.Text = "0.00";
        txtAmount.Enabled = false;
        txtAmount.ToolTip = "This Patient's Bill Guantor by Client";
    }
    public DataTable GetSOIAmountReceivedDetails()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        System.Data.DataTable _datatable = new System.Data.DataTable();

        _datatable.Columns.Add("AdvanceAmount", typeof(System.Decimal));
        _datatable.Columns.Add("TypeID", typeof(System.Int32));
        _datatable.Columns.Add("ChequeorCardNumber", typeof(System.String));
        _datatable.Columns.Add("BankNameorCardType", typeof(System.String));
        _datatable.Columns.Add("Remarks", typeof(System.String));
        _datatable.Columns.Add("AdvanceTypeID", typeof(System.Int64));
        _datatable.Columns.Add("AdvanceType", typeof(System.String));
        _datatable.Columns.Add("ServiceCharge", typeof(System.Decimal));
        _datatable.Columns.Add("BaseCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("PaidCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("OtherCurrencyAmount", typeof(System.Decimal));

        DataRow _datarow;

        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;

        foreach (string row in sNewDatas.Split('|'))
        {
            //RID^1~PaymentNAME^Cash~PaymentAmount^500.00~PaymenMNumber^~PaymentBank^~PaymentRemarks^~PaymentTypeID^1~ServiceCharge^0~TotalAmount^500.00~OtherCurrAmt^500|
            if (row.Trim().Length != 0)
            {
                AdvancePaidDetails amtReceived = new AdvancePaidDetails();
                _datarow = _datatable.NewRow();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];


                    switch (colName)
                    {


                        case "PaymentAmount":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["AdvanceAmount"] = Convert.ToDecimal(colValue);
                            //_datarow["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["ChequeorCardNumber"] = (colValue);
                            break;
                        case "PaymentBank":
                            _datarow["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            _datarow["Remarks"] = colValue;
                            break;
                        case "PaymentTypeID":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["TypeID"] = Convert.ToInt32(colValue);

                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                        case "OtherCurrAmt":
                            colValue = colValue == "" ? "0" : colValue;
                            //_datarow["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                    };
                    _datarow["BaseCurrencyID"] = Convert.ToInt32(hdnBaseCurrencyID.Value);
                    _datarow["PaidCurrencyID"] = Convert.ToInt32(hdnBaseCurrencyID.Value);
                    _datarow["AdvanceType"] = "SOI";
                    _datarow["AdvanceTypeID"] = 0;
              



                }
                _datatable.Rows.Add(_datarow);
            }
        }
        return _datatable;
    }
}
