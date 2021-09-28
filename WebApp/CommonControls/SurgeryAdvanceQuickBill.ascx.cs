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

public partial class CommonControls_SurgeryAdvanceQuickBill : BaseControl
{

    List<PaymentType> lstPaymentType = new List<PaymentType>();
    BillingEngine objBillingEngine;
    long retval = -1;
    Master_BL masterBL;
    long returnCode = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        ScriptReference srf = new ScriptReference();

        this.Page.RegisterStartupScript("Paymentscrpt", "<script>SurgeryCreatePaymentTables();</script>");
        if (!IsPostBack)
        {

            try
            {
                objBillingEngine = new BillingEngine(base.ContextInfo);

                ddlPaymentType.Items.Clear();
                 retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
                if (lstPaymentType.Count > 0)
                {
                    ddlPaymentType.DataSource = lstPaymentType;
                    ddlPaymentType.DataTextField = "PaymentName";
                    ddlPaymentType.DataValueField = "PaymentTypeID";
                    ddlPaymentType.DataBind();
                }
                ddlPaymentType.Items.Insert(0, new ListItem("-- Select --", "0"));
                ddlPaymentType.SelectedIndex = 1;
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
            ddCurrency.SelectedValue = hdnBaseCurrencyValue.Value;
        }

    }
    private void loadCurrency()
    {
        masterBL = new Master_BL(base.ContextInfo);
        List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
        masterBL.GetCurrencyForRateConversion(OrgID, "Y", out lstCurrOrgMapp);
        ddCurrency.Enabled = false;
        ddCurrency.DataSource = lstCurrOrgMapp;
        ddCurrency.DataTextField = "CurrencyName";
        ddCurrency.DataValueField = "IsBaseCurrency";
        ddCurrency.DataBind();
        ////ddCurrency.Items.Insert(0, "--Select--");
        string CurrID = "";
        CurrID = lstCurrOrgMapp.Find(P => P.CurrencyID.ToString() == hdnBaseCurrencyID.Value).IsBaseCurrency;
        hdnBaseCurrencyValue.Value = CurrID;
        hdnOtherCurrencyRate.Value = lstCurrOrgMapp.Find(P => P.CurrencyID.ToString() == hdnBaseCurrencyID.Value).ConversionRate.ToString();
        if (lstCurrOrgMapp.Count > 1)
        {
            ddCurrency.Enabled = true;
        }
    }

    public DataTable GetAmountReceivedDetails()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        System.Data.DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("AmtReceived");
        DataColumn dbCol2 = new DataColumn("TypeID");
        DataColumn dbCol3 = new DataColumn("ChequeorCardNumber");
        DataColumn dbCol4 = new DataColumn("BankNameorCardType");
        DataColumn dbCol5 = new DataColumn("Remarks");
        DataColumn dbCol6 = new DataColumn("AdvanceTypeID");
        DataColumn dbCol7 = new DataColumn("AdvanceType");
        DataColumn dbCol8 = new DataColumn("ServiceCharge");
        DataColumn dbCol9 = new DataColumn("BaseCurrencyID");
        DataColumn dbCol10 = new DataColumn("PaidCurrencyID");
        DataColumn dbCol11 = new DataColumn("OtherCurrencyAmount");



        //add columns
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        dt.Columns.Add(dbCol5);
        dt.Columns.Add(dbCol6);
        dt.Columns.Add(dbCol7);
        dt.Columns.Add(dbCol8);
        dt.Columns.Add(dbCol9);
        dt.Columns.Add(dbCol10);
        dt.Columns.Add(dbCol11);

        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;
        DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                AmountReceivedDetails amtReceived = new AmountReceivedDetails();
                dr = dt.NewRow();
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
                        ///Table Header TotalAmount is interchanged to OtherCurrAmt
                        /// Table Value AmtReceived is interchanged to OtherCurrencyAmount
                        /// Modi By: Kutti  A
                        /// 28/12/2010

                        case "TotalAmount":
                            colValue = colValue == "" ? "0" : colValue;
                            dr["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                        case "PaymentTypeID":
                            dr["TypeID"] = Convert.ToInt32(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            dr["ChequeorCardNumber"] = (colValue);
                            break;
                        case "PaymentBank":
                            dr["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            dr["Remarks"] = colValue;
                            break;
                        case "SurgeryDetailID":
                            dr["AdvanceTypeID"] = Convert.ToInt32(colValue);
                            dr["AdvanceType"] = "SOI";
                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            dr["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                        case "OtherCurrAmt":
                            colValue = colValue == "" ? "0" : colValue;
                            dr["AmtReceived"] = Convert.ToDecimal(colValue); ;
                            break;

                    };
                    dr["BaseCurrencyID"] = Convert.ToInt32(hdnBaseCurrencyID.Value);
                    dr["PaidCurrencyID"] = Convert.ToInt32(hdnOtherCurrencyID.Value);
                }
                dt.Rows.Add(dr);
            }
        }
        return dt;
    }
    public void GetOtherCurrReceivedDetails(out int BaseCurrencyID, out int PaidCurrencyID)
    {
        BaseCurrencyID = 0;
        PaidCurrencyID = 0;

        Int32.TryParse(hdnBaseCurrencyID.Value, out BaseCurrencyID);
        Int32.TryParse(hdnOtherCurrencyID.Value, out PaidCurrencyID);
    }
    
    public void ClearControls()
    {
        hdfPaymentType.Value = "";
    }


}
