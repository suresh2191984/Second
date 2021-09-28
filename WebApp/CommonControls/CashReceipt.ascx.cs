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
using System.Collections;
using Attune.Podium.Common;

public partial class CommonControls_CashReceipt :BaseControl
{
    List<BillingDetails> lstPatientBilling = new List<BillingDetails>();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected long _PatientID = 0;

    public long PatientID
    {
        get { return _PatientID; }
        set { _PatientID = value; }
    }
    protected long _VisitID = 0;

    public long VisitID
    {
        get { return _VisitID; }
        set { _VisitID = value; }
    }

    protected long _VisitCount = 0;

    public long VisitCount
    {
        get { return _VisitCount; }
        set { _VisitCount = value; }
    }

    protected string _ReceiptNo = "0";

    public string ReceiptNo
    {
        get { return _ReceiptNo; }
        set { _ReceiptNo = value; }
    }

    protected decimal _TempAmount = 0;

    public decimal TempAmount
    {
        get { return _TempAmount; }
        set { _TempAmount = value; }
    }
    protected string _Status = "";


    public void SetBillDetails()
    {
        PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);
     
        List<Patient> lstPatient = new List<Patient>();
        long retCode = -1;
        decimal pAmountReceived = 0;
        decimal pGrandTotal = 0;
        decimal pserviecCharge = 0;
        retCode = objPatientVisitBL.GetInPatientBills(PatientID, OrgID,
                                           VisitID,
                                           out lstPatientBilling,
                                           out lstPatient,
                                           out pAmountReceived,
                                           out pGrandTotal, out pserviecCharge);

        var Billdetails = from BDetails in lstPatientBilling
                          where BDetails.IsCreditBill == "" || BDetails.IsCreditBill == "N" || BDetails.IsCreditBill == null
                          select BDetails;
        VisitCount = Billdetails.Count();
        //gvBillingDetail.DataSource = Billdetails;
        //gvBillingDetail.DataBind();
        //lblServiceCharge.Text = pserviecCharge.ToString();
        //VisitCount = gvBillingDetail.Rows.Count;
       // ViewState.Add("DK", lstPatientBilling);

        if (lstPatient.Count > 0)
        {
            lblName.Text = lstPatient[0].Name;
            lblPatientNumber.Text = lstPatient[0].PatientNumber;
            lblAge.Text = lstPatient[0].Age.ToString();
            lblIPNo.Text = lstPatient[0].IPNumber;
             
            if (lstPatient[0].SEX.ToString() == "M")
            {
                lblSex.Text = "Male";
            }
            else
            {
                lblSex.Text = "Female";
            }
            lblAdmission.Text = lstPatient[0].RegistrationDTTM.ToString("dd/MM/yyyy hh:mm tt");
            if (TempAmount == 0)
            {
                lblAmountRecieved.Text = pAmountReceived.ToString();
            }
            else
            {
                lblAmountRecieved.Text = TempAmount.ToString();
            }
            //decimal dgrandTotal = 0;
            //decimal dTempAmount =0;

            //foreach (GridViewRow rows in gvBillingDetail.Rows)
            //{
            //    Decimal.TryParse(rows.Cells[4].Text, out dTempAmount);
            //    dgrandTotal += dTempAmount;
            //}

            //lblGrandTotal.Text = dgrandTotal.ToString();

            NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();

            if (Convert.ToDouble(lblAmountRecieved.Text) > 0)
            {
                if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
                {
                    lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " + MinorCurrencyName + " Only...";
                }
                else
                {
                    lblAmount.Text = num.Convert(lblAmountRecieved.Text) + " Only...";
                }
            }
            else
            {
                lblAmount.Text = "";
            }
            lblReceiptNo.Text = ReceiptNo;
            lblBilledBy.Text = ("Billed By: (" + UserName+")").ToUpper();
            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            List<Config> lstConfig = new List<Config>();
            GateWay gateWay = new GateWay(base.ContextInfo);
            long returnCode = gateWay.GetConfigDetails("ShowDisclaimer", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.ToLower() == "N")
                {
                    dvDisclaimer.Visible = false;
                }
                else
                {
                    dvDisclaimer.Visible = true;
                }
            }

            lstConfig = new List<Config>();
            gateWay = new GateWay(base.ContextInfo);
            returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                lblCurrency.Text = lstConfig[0].ConfigValue;
            }
            else
            {
                lblCurrency.Text = CurrencyName;
            }
        }
    }


    //public List<PatientDueChart> GetBillDetails()
    //{
    //    List<PatientDueChart> lstPatientBillingDetails = new List<PatientDueChart>();
    //    // _PatientBillingDetails = (List<BillingDetails>)ViewState["DK"];
          
    //     foreach (GridViewRow row in gvBillingDetail.Rows)
    //     {
    //         PatientDueChart _PatientBillingDetails = new PatientDueChart();
    //         _PatientBillingDetails.DetailsID = Convert.ToInt64(row.Cells[0].Text);
    //         _PatientBillingDetails.Status = "Printed";
    //         _PatientBillingDetails.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //         _PatientBillingDetails.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //         lstPatientBillingDetails.Add(_PatientBillingDetails);
    //     }
    //     return lstPatientBillingDetails;
    //}

    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
    }
}
