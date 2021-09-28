using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class Billing_Billing : BasePage
{
    long patientID = -1;
    long patientVisitID = -1;
    long returnCode = -1;
    long taskID = -1;
    long ptaskid = -1;
    long rateID = 0;
    string labno = string.Empty;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<StandardDeduction> lstStdDeduction = new List<StandardDeduction>();
    List<FinalBill> lstFinalBill = new List<FinalBill>();
    //Patient_BL pbl = new Patient_BL(base.ContextInfo);
    //string PaymentLogic = String.Empty;
    string sAddBI = string.Empty;
    string patientType = string.Empty;
    string gUID = string.Empty;
    long FinalID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //btnAddAmt.Attributes.Add("onClick", "return validation1()");

        sAddBI = Convert.ToString(Request.QueryString["pagetype"]);
        txtTax.ReadOnly = true;

        if (sAddBI != null && sAddBI.Equals("ABI"))
        {
            txtDiscount.Enabled = false;
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetFinalBillID(patientID, patientVisitID, out FinalID);

        if (!Page.IsPostBack)
        {
            CLogger.LogInfo("step1:");
            string rval = GetConfigValue("roundoffpatamt", OrgID);
            hdnDefaultRoundoff.Value = rval;
            rval = GetConfigValue("patientroundoffpattern", OrgID);
            hdnRoundOffType.Value = rval;

            chkisCreditTransaction.Enabled = false;


            if (Request.Form.Count > 0)
            {
                ViewState["Url"] = Request.Form["txtB"].ToString();
            }
            // string hdn = Request.Form["txtB"].ToString();
            btnSave.Enabled = true;
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            //PatientHeader.PatientID = patientID;
            //PatientHeader.PatientVisitID = patientVisitID;
            //PatientHeader.ShowVitalsDetails();
            // LoadCorporateMaster();
            LoadBillingDetail();
            //LoadFinalBillDetail();
            GetCorporateDiscount();
            LoadTaxMaster();
            List<FinalBill> lstDueDetail = new List<FinalBill>();
            long finalBillID = -1;
            string visittype = "";
            dueDetail.loadDueDetail(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out visittype);
            double dueAmount = 0;
            //for (int i = 0; i < lstDueDetail.Count; i++)
            //{


            int iCount = lstDueDetail.Count == 0 ? 1 : lstDueDetail.Count;
            if (lstDueDetail.Count > 0)
            {
                Double.TryParse(lstDueDetail[lstDueDetail.Count - 1].CurrentDue.ToString(), out dueAmount);

                var lstDeamt = from lst in lstDueDetail
                               group lst by lst.PatientID into d
                               select new
                               {
                                   DueAmount = d.Sum(t => t.CurrentDue)
                               };
                txtDue.Text = String.Format("{0:0.00}", lstDeamt.First().DueAmount);

            }
            else
            {
                txtDue.Text = String.Format("{0:0.00}", 0);
            }

            txtGrossAmount.Text = String.Format("{0:0.00}", Convert.ToDouble(hdnGross.Value.ToString()) - (Convert.ToDouble(txtSubDeduction.Text) + Convert.ToDouble(txtDiscount.Text)));
            txtGrandTotal.Text = String.Format("{0:0.00}", GetCustomRoundoff(Convert.ToDecimal(txtGrossAmount.Text)));//+ Convert.ToDouble(txtDue.Text)
            txtAmountRecieved.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());

            TextBox TxtAmt = (TextBox)PaymentType.FindControl("txtAmount");
            TxtAmt.Text = txtGrandTotal.Text;

            hdnGrossAmount.Value = txtGrossAmount.Text;
            hdnGrandTotal.Value = txtGrandTotal.Text;
            LoadClientValue();
            loadRateType();
            SaveBilling();
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
            if (lstPatientVisitDetails.Count > 0)
            {
                rateID = lstPatientVisitDetails[0].RateID;
            }
            LoadFeeType(lstPatientVisitDetails[0].VisitType);

            //AutoCompleteConsultant.ContextKey = "CON~" + OrgID.ToString() + "~" + rateID.ToString();
            AutoCompleteConsultant.ContextKey = OrgID.ToString();
        }
    }
    private void loadRateType()
    {

        List<RateMaster> lstRateMaster = new List<RateMaster>();
        try
        {

            new Master_BL(base.ContextInfo).pGetRateName(OrgID, out lstRateMaster);
            ddlRateCard.DataSource = lstRateMaster;
            ddlRateCard.DataTextField = "RateName";
            ddlRateCard.DataValueField = "RateId";
            ddlRateCard.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Rate Type Master ", ex);
        }
    }
    private void LoadFeeType(int VisitType)
    {
        List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
        new BillingEngine(base.ContextInfo).GetFeeType(OrgID, (VisitType == 0 ? "OP" : "IP"), out lstFeeTypeMaster);
        if (lstFeeTypeMaster.Count > 0)
        {
            ddlFeeType.DataSource = lstFeeTypeMaster;
            ddlFeeType.DataTextField = "FeeTypeDesc";
            ddlFeeType.DataValueField = "FeeType";
            ddlFeeType.DataBind();
            // ddlFeeType.Items.Insert(0, "--Select Type--");
        }
    }
    protected string GetCustomRoundoff(decimal netRound)
    {
        decimal DefaultRound = decimal.Parse(hdnDefaultRoundoff.Value);
        string RoundType = hdnRoundOffType.Value;
        string result = string.Empty;
        if (RoundType.ToLower() == "lower value")
        {
            result = (Math.Floor(netRound / DefaultRound) * DefaultRound).ToString("0.00");
        }
        else if (RoundType.ToLower() == "upper value")
        {
            result = (Math.Ceiling(netRound / DefaultRound) * DefaultRound).ToString("0.00");
        }
        else if (RoundType.ToLower() == "none")
        {
            result = GetNumberWithSignNone(netRound, 2);
        }
        else
        {
            result = netRound.ToString("0.00");
        }
        return result;
    }
    protected string GetNumberWithSignNone(decimal Value, int precision)
    {
        Value = Value * Convert.ToDecimal(Math.Pow(1, precision));
        string result = (Convert.ToDouble(Math.Round(Value)) / Math.Pow(1, precision)).ToString();
        return result;
    }
    private void LoadBillingDetail()
    {
        try
        {
            long FinalBillID = 0;
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            billingEngineBL.GetBillingDetails(OrgID, patientID, patientVisitID, out lstBillingDetails, out lstStdDeduction, FinalBillID);

            gvBillingDetail.DataSource = lstBillingDetails;
            gvBillingDetail.DataBind();
            //BindGridValuesDatas();
            gridAttributesAdd(gvBillingDetail);

            ddlSubDeduction.DataSource = lstStdDeduction;
            ddlSubDeduction.DataTextField = "StdDedName";
            ddlSubDeduction.DataValueField = "StdDedDetails";
            ddlSubDeduction.DataBind();
            //ddlSubDeduction.Items.Insert(0, "-------Select-------");
            //ddlSubDeduction.Items.Insert(1, "Hello");

            double grossAmount = 0;
            for (int i = 0; i < lstBillingDetails.Count; i++)
            {
                grossAmount += Convert.ToDouble(lstBillingDetails[i].Amount * lstBillingDetails[i].Quantity);
            }
            txtGross.Text = String.Format("{0:0.00}", grossAmount);
            hdnGross.Value = txtGross.Text;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load Billing detail in loadBillingMethod in Billing.aspx page", ex);
        }
    }
    protected void SaveBilling()
    {
        try
        {
            txtAmountRecieved.Text = hdnAmountReceived.Value == null ? "0" : hdnAmountReceived.Value.ToString();
            txtRecievedAmount.Text = txtRecievedAmount.Text == "" ? "0" : txtRecievedAmount.Text;
            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
            decimal pRoundOff = 0;
            decimal.TryParse(hdnRoundOff.Value, out pRoundOff);

            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            foreach (GridViewRow row in gvBillingDetail.Rows)
            {
                TextBox txtAmount = new TextBox();
                Label BillingDetailsID = new Label();
                TextBox txtQty = new TextBox();
                txtAmount = (TextBox)row.FindControl("txtUnitPrice");
                TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");

                BillingDetailsID = (Label)row.FindControl("BillingDetailsID");
                txtQty = (TextBox)row.FindControl("txtQuantity");
                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = Convert.ToInt64(BillingDetailsID.Text);
                ((Label)row.FindControl("lblFeeID")).Text = ((Label)row.FindControl("lblFeeID")).Text == "" ? "0" : ((Label)row.FindControl("lblFeeID")).Text;
                _PatientDueChart.FeeID = Convert.ToInt64(((Label)row.FindControl("lblFeeID")).Text.Trim());
                _PatientDueChart.FeeType = ((Label)row.FindControl("lblFeeType")).Text.Trim();
                _PatientDueChart.Description = ((Label)row.FindControl("lblDescription")).Text.Trim();

                txtAmount.Text = txtAmount.Text == "" ? "0" : txtAmount.Text;
                _PatientDueChart.Amount = Convert.ToDecimal(txtAmount.Text.ToString());
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.Unit = Convert.ToDecimal(txtQty.Text);
                _PatientDueChart.Status = "Paid";
                _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());
                lstPatientDueChart.Add(_PatientDueChart);
            }
            long FinalBillID = 0;
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            string feeType = String.Empty;
            FinalBill finalBill = new FinalBill();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            finalBill.FinalBillID = FinalBillID;
            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.StdDedID = Convert.ToInt64(hdnStdDedID.Value);
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            finalBill.GrossBillValue = Convert.ToDecimal(hdnGross.Value.ToString());
            finalBill.NetValue = (finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                    - finalBill.DiscountAmount) + pRoundOff;
            finalBill.ServiceCharge = dServiceCharge;
            finalBill.AmountReceived = 0;
            finalBill.DiscountReason = txtDiscountReason.Text;

            AmountReceivedDetails amtRD = new AmountReceivedDetails();

            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            ctrlBalanceCalc.setAmounts();
            PaymentType.GivenAmount = ctrlBalanceCalc.CtrlGivenAmount;
            PaymentType.BalanceAmount = ctrlBalanceCalc.CtrlBalanceAmount;
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();

            amtRD.AmtReceived = 0;
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;
            finalBill.CurrentDue = 0;
            finalBill.Due = 0;
            finalBill.IsCreditBill = "N";

            finalBill.ModifiedBy = LID;

            decimal recievedAmount = 0;

            if (chkisCreditTransaction.Checked == false)
            {

                if (Convert.ToDouble(txtDue.Text) > 0 && Convert.ToDouble(txtAmountRecieved.Text) > 0)
                {
                    List<DuePaidDetail> lstPaidDueDetail = new List<DuePaidDetail>();
                    DuePaidDetail duePaidDetail;
                    long finalBillID = -1;

                    List<FinalBill> lstDueDetail = new List<FinalBill>();
                    billingEngineBL = new BillingEngine(base.ContextInfo);
                    string visittype = "";
                    billingEngineBL.GetDueDetails(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out visittype);


                    // If Amount Recieved equal to Grand Total then
                    if (Convert.ToDouble(txtAmountRecieved.Text) == Convert.ToDouble(txtGrandTotal.Text))
                    {
                        for (int i = 0; i < lstDueDetail.Count; i++)
                        {
                            duePaidDetail = new DuePaidDetail();
                            duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                            duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                            duePaidDetail.PaidAmount = lstDueDetail[i].Due;
                            duePaidDetail.PaidBillNo = FinalBillID;
                            duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            duePaidDetail.DueCollectedBy = LID;
                            lstPaidDueDetail.Add(duePaidDetail);
                            recievedAmount = recievedAmount - lstDueDetail[i].Due;
                        }
                    }
                    // If Amount recieved Less than Grand total
                    else
                    {
                        for (int i = 0; i < lstDueDetail.Count; i++)
                        {
                            // If Amount recieved Greater than lstDueDetail[i].Due value
                            if (recievedAmount > lstDueDetail[i].Due)
                            {
                                duePaidDetail = new DuePaidDetail();
                                duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                                duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                                duePaidDetail.PaidAmount = lstDueDetail[i].Due;
                                duePaidDetail.PaidBillNo = FinalBillID;
                                duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                duePaidDetail.DueCollectedBy = LID;
                                lstPaidDueDetail.Add(duePaidDetail);
                                recievedAmount = recievedAmount - lstDueDetail[i].Due;
                            }
                            else
                            {
                                if (recievedAmount > 0)
                                {
                                    duePaidDetail = new DuePaidDetail();
                                    duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                                    duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                                    duePaidDetail.PaidAmount = recievedAmount;
                                    duePaidDetail.PaidBillNo = FinalBillID;
                                    duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                    duePaidDetail.DueCollectedBy = LID;
                                    lstPaidDueDetail.Add(duePaidDetail);
                                    recievedAmount = 0;
                                }
                            }
                        }
                    }
                    returnCode = new BillingEngine(base.ContextInfo).UpdateAndInsertDueDetail(lstPaidDueDetail);
                }
                txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
                txtRecievedAmount.Text = txtRecievedAmount.Text == "" ? "0" : txtRecievedAmount.Text;
                List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
                lstTaxDetails = getTaxDetails();
                finalBill.Due = 0;
                finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtRecievedAmount.Text);
                lstPatientDueChart.RemoveAll(p => p.FeeType == "REG");
                finalBill.RoundOff = pRoundOff;

                //  billingEngineBL.UpdateFinalBill(finalBill, amtRD, dtAmountReceived, lstPatientDueChart, lstTaxDetails, dServiceCharge);
                decimal ClaimAmount = 0;
                decimal CoPayment = 0;
                decimal TowardsAmount = 0;

                decimal.TryParse(hdnClaim.Value, out ClaimAmount);
                decimal.TryParse(hdnCopayment.Value, out CoPayment);
                decimal.TryParse(hdnTowardsAmount.Value, out TowardsAmount);

                finalBill.IsCreditBill = hdnIsCreditBill.Value;
                List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

                if (finalBill.IsCreditBill == "Y")
                {
                    VisitClientMapping lstVisit = new VisitClientMapping();
                    lstVisit.VisitClientMappingID = Int64.Parse(hdnVisitClientMappingID.Value);
                    lstVisit.ClaimAmount = ClaimAmount;
                    lstVisit.CoPayment = CoPayment;
                    lstVisit.NonMedicalAmount = decimal.Parse(hdntotalNonMedical.Value);
                    lstVisit.VisitID = patientVisitID;
                    lstVisitClientMapping.Add(lstVisit);
                }


                if (TowardsAmount > finalBill.AmountReceived && finalBill.IsCreditBill == "Y")
                {
                    finalBill.CurrentDue = TowardsAmount - finalBill.AmountReceived;
                    finalBill.Due = TowardsAmount - finalBill.AmountReceived;
                }
                List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();
                lstUsage = DepositUsageCtrl.GetDepositUsage();
                billingEngineBL.UpdateFinalBill(finalBill, amtRD, dtAmountReceived, lstPatientDueChart, lstTaxDetails, dServiceCharge, lstVisitClientMapping, lstUsage);
            }




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Final Bill Update in Billing.aspx page", ex);
        }

    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        //long AmountReceiedID = 0;
        try
        {
            labno = Request.QueryString["LabNo"];
            txtAmountRecieved.Text = hdnAmountReceived.Value == null ? "0" : hdnAmountReceived.Value.ToString();
            txtRecievedAmount.Text = txtRecievedAmount.Text == "" ? "0" : txtRecievedAmount.Text;
            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
            decimal pRoundOff = 0;
            decimal.TryParse(hdnRoundOff.Value, out pRoundOff);

            decimal ClaimAmount = 0;
            decimal CoPayment = 0;
            decimal TowardsAmount = 0;

            decimal.TryParse(hdnClaim.Value, out ClaimAmount);
            decimal.TryParse(hdnCopayment.Value, out CoPayment);
            decimal.TryParse(hdnTowardsAmount.Value, out TowardsAmount);

            //------------------------------------------------------------------------------------------------------------------------
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            foreach (GridViewRow row in gvBillingDetail.Rows)
            {
                TextBox txtAmount = new TextBox();
                Label BillingDetailsID = new Label();
                TextBox txtQty = new TextBox();
                txtAmount = (TextBox)row.FindControl("txtUnitPrice");
                TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");

                BillingDetailsID = (Label)row.FindControl("BillingDetailsID");
                txtQty = (TextBox)row.FindControl("txtQuantity");
                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = Convert.ToInt64(BillingDetailsID.Text);
                ((Label)row.FindControl("lblFeeID")).Text = ((Label)row.FindControl("lblFeeID")).Text == "" ? "0" : ((Label)row.FindControl("lblFeeID")).Text;
                _PatientDueChart.FeeID = Convert.ToInt64(((Label)row.FindControl("lblFeeID")).Text.Trim());
                _PatientDueChart.FeeType = ((Label)row.FindControl("lblFeeType")).Text.Trim();
                _PatientDueChart.Description = ((Label)row.FindControl("lblDescription")).Text.Trim();

                txtAmount.Text = txtAmount.Text == "" ? "0" : txtAmount.Text;
                _PatientDueChart.Amount = Convert.ToDecimal(txtAmount.Text.ToString());
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.Unit = Convert.ToDecimal(txtQty.Text);
                _PatientDueChart.Status = "Paid";
                _PatientDueChart.Remarks = labno;
                _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());
                lstPatientDueChart.Add(_PatientDueChart);
            }
            if (Convert.ToDecimal(hdnRateCardDiffAmount.Value) > 0)
            {
                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = 0;
                _PatientDueChart.FeeID = -1;
                _PatientDueChart.FeeType = "DIF";
                _PatientDueChart.Description = "Rate Card Difference Amount";
                _PatientDueChart.Amount = Convert.ToDecimal(hdnRateCardDiffAmount.Value);
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.Unit = 1;
                _PatientDueChart.Status = "Paid";
                _PatientDueChart.Remarks = "";
                _PatientDueChart.DiscountAmount = 0;
                lstPatientDueChart.Add(_PatientDueChart);
            }



            //------------------------------------------------------------------------------------------------------------------------
            //if (chkisCreditTransaction.Checked == false && Convert.ToDecimal(txtAmountRecieved.Text) == 0)
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "Please Enter Amount";
            //}
            //else
            //{
            long FinalBillID = 0;

            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);

            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

            string feeType = String.Empty;

            FinalBill finalBill = new FinalBill();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            //---------------------------------------------------------------------------------------------------------
            finalBill.FinalBillID = FinalBillID;
            //---------------------------------------------------------------------------------------------------------
            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.StdDedID = Convert.ToInt64(hdnStdDedID.Value);
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            finalBill.GrossBillValue = Convert.ToDecimal(hdnGross.Value) + Convert.ToDecimal(hdnRateCardDiffAmount.Value);
            finalBill.NetValue = (finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                    - finalBill.DiscountAmount) + pRoundOff;
            finalBill.ServiceCharge = dServiceCharge;
            finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text)
                + Convert.ToDecimal(txtRecievedAmount.Text);
            finalBill.DiscountReason = txtDiscountReason.Text;

            AmountReceivedDetails amtRD = new AmountReceivedDetails();

            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            ctrlBalanceCalc.setAmounts();
            PaymentType.GivenAmount = ctrlBalanceCalc.CtrlGivenAmount;
            PaymentType.BalanceAmount = ctrlBalanceCalc.CtrlBalanceAmount;
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();

            amtRD.AmtReceived = Convert.ToDecimal(txtAmountRecieved.Text);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;

            finalBill.IsCreditBill = hdnIsCreditBill.Value;
            //finalBill.CurrentDue = Convert.ToDecimal(txtGrandTotal.Text.ToString()) - (Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtDiscount.Text));

            if (finalBill.IsCreditBill == "N")
            {
                finalBill.CurrentDue = finalBill.NetValue
                                          - finalBill.AmountReceived;

                if (txtAmountRecieved.Text.Trim() == "0" || txtAmountRecieved.Text.Trim() == "0.00" || txtAmountRecieved.Text.Trim() == "")
                {
                    finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff;
                }
            }
            else
            {
                if (TowardsAmount > finalBill.AmountReceived && finalBill.IsCreditBill == "Y")
                {
                    finalBill.CurrentDue = TowardsAmount - finalBill.AmountReceived;
                    finalBill.Due = TowardsAmount - finalBill.AmountReceived;
                }
            }


            //if (chkisCreditTransaction.Checked == true)
            //{
            //    //finalBill.Due = Convert.ToDecimal(hdnGrossAmount.Value);
            //    finalBill.IsCreditBill = "Y";
            //}
            //else
            //{
            //    finalBill.IsCreditBill = "N";
            //}

            finalBill.ModifiedBy = LID;

            if (Convert.ToString(Request.QueryString["ftype"]) == "CON" ||
                Convert.ToString(Request.QueryString["ftype"]) == "PRO" || Convert.ToString(Request.QueryString["ftype"]) == "INV")
            {
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
            }
            decimal recievedAmount = Convert.ToDecimal(txtAmountRecieved.Text);

            if (chkisCreditTransaction.Checked == false)
            {

                if (Convert.ToDouble(txtDue.Text) > 0 && Convert.ToDouble(txtAmountRecieved.Text) > 0)
                {
                    List<DuePaidDetail> lstPaidDueDetail = new List<DuePaidDetail>();
                    DuePaidDetail duePaidDetail;
                    long finalBillID = -1;

                    List<FinalBill> lstDueDetail = new List<FinalBill>();
                    billingEngineBL = new BillingEngine(base.ContextInfo);
                    string visittype = "";
                    billingEngineBL.GetDueDetails(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out visittype);


                    // If Amount Recieved equal to Grand Total then
                    if (Convert.ToDouble(txtAmountRecieved.Text) == Convert.ToDouble(txtGrandTotal.Text))
                    {
                        for (int i = 0; i < lstDueDetail.Count; i++)
                        {
                            duePaidDetail = new DuePaidDetail();
                            duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                            duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                            duePaidDetail.PaidAmount = lstDueDetail[i].Due;
                            duePaidDetail.PaidBillNo = FinalBillID;
                            duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            duePaidDetail.DueCollectedBy = LID;
                            lstPaidDueDetail.Add(duePaidDetail);
                            recievedAmount = recievedAmount - lstDueDetail[i].Due;
                        }
                    }
                    // If Amount recieved Less than Grand total
                    else
                    {
                        for (int i = 0; i < lstDueDetail.Count; i++)
                        {
                            // If Amount recieved Greater than lstDueDetail[i].Due value
                            if (recievedAmount > lstDueDetail[i].Due)
                            {
                                duePaidDetail = new DuePaidDetail();
                                duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                                duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                                duePaidDetail.PaidAmount = lstDueDetail[i].Due;
                                duePaidDetail.PaidBillNo = FinalBillID;
                                duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                duePaidDetail.DueCollectedBy = LID;
                                lstPaidDueDetail.Add(duePaidDetail);
                                recievedAmount = recievedAmount - lstDueDetail[i].Due;
                            }
                            else
                            {
                                if (recievedAmount > 0)
                                {
                                    duePaidDetail = new DuePaidDetail();
                                    duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                                    duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                                    duePaidDetail.PaidAmount = recievedAmount;
                                    duePaidDetail.PaidBillNo = FinalBillID;
                                    duePaidDetail.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                    duePaidDetail.DueCollectedBy = LID;
                                    lstPaidDueDetail.Add(duePaidDetail);
                                    recievedAmount = 0;
                                }
                            }
                        }
                    }
                    returnCode = new BillingEngine(base.ContextInfo).UpdateAndInsertDueDetail(lstPaidDueDetail);
                }
                txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
                txtRecievedAmount.Text = txtRecievedAmount.Text == "" ? "0" : txtRecievedAmount.Text;
                List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
                lstTaxDetails = getTaxDetails();

                if (recievedAmount > 0 && finalBill.IsCreditBill == "N")
                {
                    if (Convert.ToDecimal(txtGrandTotal.Text) > 0)
                    {
                        finalBill.Due = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                                - finalBill.DiscountAmount - Convert.ToDecimal(txtAmountRecieved.Text) + pRoundOff;//- recievedAmount 
                        /* -(Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtDiscount.Text) + Convert.ToDecimal(txtRecievedAmount.Text)
                         ;*/
                    }
                    else
                    {
                        finalBill.Due = 0;
                    }
                    finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtRecievedAmount.Text);
                }
                else
                {
                    if (TowardsAmount > finalBill.AmountReceived && finalBill.IsCreditBill == "Y")
                    {
                        finalBill.CurrentDue = TowardsAmount - finalBill.AmountReceived;
                        finalBill.Due = TowardsAmount - finalBill.AmountReceived;
                    }
                    else
                    {
                        finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff - finalBill.AmountReceived;
                    }
                }
                finalBill.RoundOff = pRoundOff;
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);

                List<PatientDueDetails> lstPatientDueDetails = new List<PatientDueDetails>();
                PatientDueDetails PDD = new PatientDueDetails();
                PDD.PatientID = patientID;
                PDD.VisitID = patientVisitID;
                PDD.FinalBillID = FinalBillID;

                if (finalBill.IsCreditBill == "N")
                {
                    PDD.DueAmount = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                                    - finalBill.DiscountAmount - Convert.ToDecimal(txtAmountRecieved.Text) + pRoundOff;
                }
                else
                {
                    if (TowardsAmount > finalBill.AmountReceived && finalBill.IsCreditBill == "Y")
                    {
                        PDD.DueAmount = TowardsAmount - finalBill.AmountReceived;
                    }
                }

                PDD.OrgID = OrgID;
                PDD.IsCreditBill = finalBill.IsCreditBill;

                //PDD.DueAmount = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                //                                - finalBill.DiscountAmount - Convert.ToDecimal(txtAmountRecieved.Text) + pRoundOff;

                PDD.OrgID = OrgID;
                //if (chkisCreditTransaction.Checked == true)
                //{
                //    PDD.IsCreditBill = "Y";
                //}
                //else
                //{
                //    PDD.IsCreditBill = "N";
                //}
                PDD.Status = "Open";
                lstPatientDueDetails.Add(PDD);
                if (PDD.DueAmount > 0)
                {
                    billingEngineBL.InsertOpDuedetails(lstPatientDueDetails);
                }
                // billingEngineBL.UpdateFinalBill(finalBill, amtRD, dtAmountReceived, lstPatientDueChart, lstTaxDetails, dServiceCharge);

                List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

                if (finalBill.IsCreditBill == "Y")
                {
                    VisitClientMapping lstVisit = new VisitClientMapping();
                    lstVisit.VisitClientMappingID = Int64.Parse(hdnVisitClientMappingID.Value);
                    lstVisit.ClaimAmount = ClaimAmount;
                    lstVisit.CoPayment = CoPayment;
                    lstVisit.VisitID = patientVisitID;
                    lstVisitClientMapping.Add(lstVisit);
                }
                List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();
                lstUsage = DepositUsageCtrl.GetDepositUsage();
                billingEngineBL.UpdateFinalBill(finalBill, amtRD, dtAmountReceived, lstPatientDueChart, lstTaxDetails, dServiceCharge, lstVisitClientMapping, lstUsage);


                List<PatientDueChart> lstTempPhysiotherapy = (from lstduetemp in lstPatientDueChart
                                                              where lstduetemp.FeeType == "PRO" && lstduetemp.Description != "Dialysis" && lstduetemp.Description != "Others" && lstduetemp.Description != "Radiation Therapy"
                                                              select lstduetemp).ToList();

                List<PatientDueChart> lstTemporderedinv = (from lstduetemp in lstPatientDueChart
                                                           where lstduetemp.FeeType == "INV" || lstduetemp.FeeType == "GRP" || lstduetemp.FeeType == "PKG" && lstduetemp.Description != "Dialysis" && lstduetemp.Description != "Others" && lstduetemp.Description != "Radiation Therapy"
                                                           select lstduetemp).ToList();


                List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();

                if (lstTemporderedinv.Count > 0 && Convert.ToString(Request.QueryString["ftype"]) != "INV" && Convert.ToString(Request.QueryString["ftype"]) != "HEALTHPKG")
                {

                    List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                    List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                    List<InvestigationValues> lstInvResult = new List<InvestigationValues>();

                    Tasks task = new Tasks();
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    gUID = Request.QueryString["gUID"] == null ? "" : Request.QueryString["gUID"].ToString();
                    new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
                    List<OrderedInvestigations> lstUpdatePatientInvStatusHL = new List<OrderedInvestigations>();
                    int count = -1;


                    returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvSampleCollected(lstUpdatePatientInvStatusHL, 0, out count);

                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "Y")
                        {
                            Int64.TryParse(Request.QueryString["pid"], out patientID);
                            if (Request.QueryString["gUID"] != null)
                            {
                                gUID = Request.QueryString["gUID"].ToString();

                            }
                            long cTaskID = -1;
                            string strConfigKey = "SampleCollect";
                            string configValue = GetConfigValue(strConfigKey, OrgID);
                            if (configValue != "N")
                            {

                                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                                string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                             patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                             patientName, "", 0, "", 0, "", 0, "INV"
                                             , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, gUID);
                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = patientVisitID;
                                task.PatientID = patientID;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                //task.RefernceID = labno.ToString();
                                //Create task               
                                returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out cTaskID);
                                break;
                            }
                        }
                    }
                    foreach (var item in lstSampleDept1)
                    {
                        if (item.Display == "N")
                        {
                            InvestigationValues inValues = new InvestigationValues();
                            inValues.InvestigationID = item.InvestigationID;
                            inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                            inValues.PackageID = item.PackageID;
                            inValues.PackageName = item.PackageName;

                            lstInvResult.Add(inValues);
                        }
                    }

                    returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);


                }
                if (lstTempPhysiotherapy.Count > 0)
                {


                    foreach (PatientDueChart dueitem in lstTempPhysiotherapy)
                    {
                        OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();
                        ptt.ProcedureID = dueitem.FeeID;
                        ptt.ProcedureName = dueitem.Description;
                        ptt.OdreredQty = dueitem.Unit;
                        ptt.Status = "Ordered";
                        ptt.PaymentStatus = "";
                        lstOrderedPhysiotherapy.Add(ptt);
                    }
                }


                if (lstOrderedPhysiotherapy.Count > 0)
                {
                    string Type = "Ordered";
                    int Physiocount = 0;

                    returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(patientVisitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy, out Physiocount);

                    if (Physiocount > 0)
                    {
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        List<Patient> lstPatient = new List<Patient>();
                        returnCode = patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
                        Patient patient = new Patient();
                        patient = lstPatient[0];
                        Tasks task = new Tasks();
                        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                        Hashtable dText = new Hashtable();
                        Hashtable urlVal = new Hashtable();
                        List<TaskActions> lstTaskAction = new List<TaskActions>();
                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, patientVisitID, 0,
                               patientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0,
                               feeType, out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, "");

                        task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out ptaskid);
                    }


                }

                //Sami ended the lines




            }
            long createTaskID = -1;
            // Create task to lab tech for collect samples
            if ((Convert.ToString(Request.QueryString["ftype"]) == "INV") || (Convert.ToString(Request.QueryString["ftype"]) == "HEALTHPKG"))
            {

                List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
                List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
                List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
                Tasks task = new Tasks();
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                gUID = Request.QueryString["gUID"] == null ? "" : Request.QueryString["gUID"].ToString();
                new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

                //---------------------------------------------------Newly Added(paid investigation)
                List<OrderedInvestigations> lstUpdatePatientInvStatusHL = new List<OrderedInvestigations>();
                int count = -1;
                foreach (var item in lstPatientDueChart)
                {
                    OrderedInvestigations lstUpdatePa = new OrderedInvestigations();
                    lstUpdatePa.Name = item.Description;
                    lstUpdatePa.ID = item.FeeID;
                    lstUpdatePa.VisitID = patientVisitID;
                    lstUpdatePa.CreatedBy = LID;
                    lstUpdatePa.Status = item.Status;
                    lstUpdatePa.Type = item.FeeType;
                    lstUpdatePa.OrgID = OrgID;
                    lstUpdatePatientInvStatusHL.Add(lstUpdatePa);
                }

                returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvSampleCollected(lstUpdatePatientInvStatusHL, 0, out count);
                //-----------------------------------------------------------------------------------
                foreach (var item in lstSampleDept1)
                {
                    if (item.Display == "Y")
                    {
                        Int64.TryParse(Request.QueryString["pid"], out patientID);
                        if (Request.QueryString["gUID"] != null)
                        {
                            gUID = Request.QueryString["gUID"].ToString();

                        }
                        //long createTaskID = -1;
                        string strConfigKey = "SampleCollect";
                        string configValue = GetConfigValue(strConfigKey, OrgID);
                        if (configValue != "N")
                        {

                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                            string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                         patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                         patientName, "", 0, "", 0, "", 0, "INV"
                                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, gUID);
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = patientVisitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.RefernceID = labno.ToString();
                            //Create task               
                            returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
                            break;
                        }
                    }
                }
                foreach (var item in lstSampleDept1)
                {
                    if (item.Display == "N")
                    {
                        InvestigationValues inValues = new InvestigationValues();
                        inValues.InvestigationID = item.InvestigationID;
                        inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                        inValues.PackageID = item.PackageID;
                        inValues.PackageName = item.PackageName;

                        lstInvResult.Add(inValues);
                    }
                }

                returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);

            }
            FinalBillID = 0;
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);

            billingEngineBL.GetBillingDetails(OrgID, patientID, patientVisitID, out lstBillingDetails, out lstStdDeduction, FinalBillID);
            if (lstBillingDetails.Count > 0)
            {
                if (lstBillingDetails[0].FeeType == "PRO")
                    Response.Redirect("../Printing/DialysisCaseSheetPrint.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + Convert.ToString(Request.QueryString["tid"]), true);
                else
                    Response.Redirect("../Reception/ViewPrintPage.aspx?vid=" + patientVisitID + "&pagetype=BP&pid=" + patientID + "&tid=" + Convert.ToString(Request.QueryString["tid"]) + "&bid=" + FinalBillID.ToString() + "&LabNo=" + labno, true);
            }
            else
            {
                Response.Redirect("../Reception/ViewPrintPage.aspx?vid=" + patientVisitID + "&pagetype=BP&pid=" + patientID + "&tid=" + Convert.ToString(Request.QueryString["tid"]) + "&bid=" + FinalBillID.ToString() + "&LabNo=" + labno, true);
            }


        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while Final Bill Update in Billing.aspx page", ex);
            btnSave.Visible = true;
            btnSave.Enabled = true;
        }

    }

    protected void ddlSubDeduction_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            string Url;
            if (ViewState["Url"] != null)
            {
                if (ViewState["Url"].ToString() != "")
                {
                    Url = ViewState["Url"].ToString();
                    string redirectURL = Request.ApplicationPath + Request.Url.PathAndQuery.ToString();
                    Response.Redirect(Url, true);
                }
                else
                {
                    Response.Redirect("../Reception/Home.aspx", true);
                }
            }
            else
            {
                Response.Redirect("../Reception/Home.aspx", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnPrintBill_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Response.Redirect("~/Reception/ViewPrintPage.aspx?vid=" + patientVisitID + "&pagetype=BP");
    }
    protected void btnAddAmt_Click(object sender, EventArgs e)
    {
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        BillingDetails objBD = new BillingDetails();
        objBD.FinalBillID = FinalID;
        //objBD.FeeId = -1;
        //objBD.FeeType = "OTH";
        objBD.FeeDescription = txtFeeDesc.Text;
        txtAmnt.Text = txtAmnt.Text == "" ? "0" : txtAmnt.Text;
        objBD.Amount = Convert.ToDecimal(txtAmnt.Text);
        objBD.CreatedBy = LID;
        objBD.ModifiedBy = 0;

        objBD.FeeType = ddlFeeType.SelectedValue == "LAB" ? "INV" : ddlFeeType.SelectedValue;
        if (chkNonReimburse.Checked)
        {
            objBD.IsReimbursable = "Y";
        }
        else
        {
            objBD.IsReimbursable = "N";
        }
        if (ddlFeeType.SelectedValue.Equals("CON"))
        {
            objBD.FeeId = long.Parse(hdnFilterPhysicianID.Value);
        }
        else
        {
            objBD.FeeId = -1;
        }

        billingEngineBL.InsertMiscellaneousBills(objBD);
        //txtAmt.Text = "";
        //txtDesc.Text = "";
        txtAmnt.Text = txtFeeDesc.Text = string.Empty;

        // string hdn = Request.Form["txtB"].ToString();
        btnSave.Enabled = true;

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

        //PatientHeader.PatientID = patientID;
        //PatientHeader.PatientVisitID = patientVisitID;
        //PatientHeader.ShowVitalsDetails();
        //LoadCorporateMaster();
        LoadBillingDetail();
        //LoadFinalBillDetail();
        GetCorporateDiscount();
        LoadTaxMaster();
        List<FinalBill> lstDueDetail = new List<FinalBill>();

        long finalBillID = -1;
        string visittype = "";
        dueDetail.loadDueDetail(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out visittype);
        double dueAmount = 0;
        //for (int i = 0; i < lstDueDetail.Count; i++)
        //{
        int iCount = lstDueDetail.Count == 0 ? 1 : lstDueDetail.Count;
        if (lstDueDetail.Count > 0)
        {
            Double.TryParse(lstDueDetail[lstDueDetail.Count - 1].CurrentDue.ToString(), out dueAmount);

        }
        txtDue.Text = String.Format("{0:0.00}", dueAmount);
        txtGrossAmount.Text = String.Format("{0:0.00}", Convert.ToDouble(hdnGross.Value.ToString()) - (Convert.ToDouble(txtSubDeduction.Text) + Convert.ToDouble(txtDiscount.Text)));
        txtGrandTotal.Text = String.Format("{0:0.00}", Convert.ToDouble(txtGrossAmount.Text));// + Convert.ToDouble(txtDue.Text)
        txtAmountRecieved.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());
        hdnGrossAmount.Value = txtGrossAmount.Text;
        hdnGrandTotal.Value = txtGrandTotal.Text;
    }

    //public void LoadCorporateMaster()
    //{
    //    IP_BL invBL = new IP_BL(base.ContextInfo);
    //    List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
    //    invBL.GetCorporateMaster(OrgID, out lstCorporateMaster);
    //    ddlCorporate.DataSource = lstCorporateMaster;
    //    ddlCorporate.DataTextField = "CorporateName";
    //    ddlCorporate.DataValueField = "CorporateID";
    //    ddlCorporate.DataBind();
    //    ddlCorporate.Items.Insert(0, "---Select---");
    //    ddlCorporate.Items[0].Value = "0";
    //}
    public void GetCorporateDiscount()
    {
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        List<CorporateMaster> lstCorporateMaster = new List<CorporateMaster>();
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        patientVisitBL.GetCorporateClientByVisit(patientVisitID, out lstPatientVisit);
        if (lstPatientVisit.Count > 0)
        {
            // txtDiscount.Text = lstPatientVisit[0].Discount.ToString();
            hdnCorporateDiscount.Value += lstPatientVisit[0].Discount + "~" + lstPatientVisit[0].DiscountType + "^";

            //if (lstPatientVisit[0].CorporateID != 0)
            //{
            //    ddlCorporate.SelectedValue = lstPatientVisit[0].CorporateID.ToString();
            //    ddlCorporate.Enabled = false;
            //}
            //if (lstPatientVisit[0].ClientID == 0)
            //{
            //billingEngineBL.GetCorporateDiscount(OrgID, out lstCorporateMaster);
            //if (lstCorporateMaster.Count > 0)
            //{
            //    foreach (CorporateMaster objCorporateMaster in lstCorporateMaster)
            //    {
            //        hdnCorporateDiscount.Value += objCorporateMaster.CorporateID + "~" + objCorporateMaster.CorporateName + "~" + objCorporateMaster.Discount + "~" + objCorporateMaster.DiscountType + "^";
            //    }
            //}
            //}
        }
    }
    protected void LoadTaxMaster()
    {
        BillingEngine billBL = new BillingEngine(base.ContextInfo);
        List<Taxmaster> lstTaxMaster = new List<Taxmaster>();
        billBL.GetTaxDetails(OrgID, out lstTaxMaster);
        string sHtml = "";
        foreach (Taxmaster tm in lstTaxMaster)
        {
            sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxPercent + "' runat='server' onclick='chkTaxPayment(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
        }
        dvTaxDetails.InnerHtml = sHtml;
    }
    private List<TaxBillDetails> getTaxDetails()
    {
        List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
        if (hdfTax.Value != null)
        {
            foreach (string sValue in hdfTax.Value.ToString().Split('>'))
            {
                if (sValue != "")
                {
                    TaxBillDetails tTax = new TaxBillDetails();
                    tTax.TaxID = Convert.ToInt32(sValue.Split('~')[0].Split('#')[1]);
                    tTax.TaxPercent = Convert.ToDecimal(sValue.Split('~')[1]);
                    lstTax.Add(tTax);
                }
            }
        }
        return lstTax;
    }
    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillingDetails bd = (BillingDetails)e.Row.DataItem;
                //gridAttributesAdd(gvBillingDetail);
                TextBox txtUnitPrice = new TextBox();
                txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");
                Label lbEditStatus = new Label();
                lbEditStatus = (Label)e.Row.FindControl("lblEditStats");
                if (Convert.ToDecimal(txtUnitPrice.Text) > 0)
                {
                    if (lbEditStatus.Text == "Y")
                    {
                        txtUnitPrice.Enabled = true;
                    }
                    else
                    {
                        txtUnitPrice.Enabled = false;
                    }
                }
                else
                {
                    txtUnitPrice.Enabled = true;
                }
                gvBillingDetail.Columns[6].Visible = false;

                if (bd.IsReimbursable != "N")
                {
                    ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
                }
                else
                {
                    ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvBillingDetail_RowDataBound", ex);
        }
    }
    protected void gridAttributesAdd(GridView gvDataGrid)
    {
        decimal dtotalAmount = 0;
        string sStatus = "";

        foreach (GridViewRow row in gvDataGrid.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            TextBox txtIndvDiscount = new TextBox();

            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();
            //HiddenField hdnOldDiscount = new HiddenField();


            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");
            txtIndvDiscount = (TextBox)row.FindControl("txtDiscount");

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");
            //hdnOldDiscount = (HiddenField)row.FindControl("hdnDiscount");


            string sFunProcedures = "funcChkProcedures('" + txtUnitPrice.ClientID +
                                            "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                            "','" + hdnAmount.ClientID +
                                            "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                            "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                            "','" + txtReceivedAdvance.ClientID + "','" + txtGrandTotal.ClientID +
                                            "','" + hdnGross.ClientID +
                                            "','" + txtIndvDiscount.ClientID +
                                            "','" + hdnDiscountArray.ClientID + "');";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtIndvDiscount.Attributes.Add("onBlur", sFunProcedures);

            dtotalAmount += Convert.ToDecimal(txtAmount.Text);
            hdnDiscountArray.Value = txtIndvDiscount.ClientID + "|" + hdnDiscountArray.Value.Trim();

            //if (RoleName.ToLower() != "Administrator")
            //{
            //    sStatus = row.Cells[11].Text.Trim();
            //    if ((sStatus.ToLower() == "ordered") || (sStatus.ToLower() == "pending"))
            //    {
            //        txtQuantity.Enabled = true;
            //        txtUnitPrice.Enabled = true;
            //    }
            //    else
            //    {
            //        txtQuantity.Enabled = false;
            //        txtUnitPrice.Enabled = false;
            //    }
            //}
            if (txtUnitPrice.Text == "0.00")
            {
                row.BackColor = System.Drawing.Color.Tomato;
            }
        }
        txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");

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
    public void LoadClientValue()
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        long returnCode = -1;
        PatientVisit_BL obj = new PatientVisit_BL(new BaseClass().ContextInfo);
        long VisitID = 0;
        VisitID = Int64.Parse(Request.QueryString["vid"]);
        returnCode = obj.GetVisitClientMappingDetails(OrgID, VisitID, out lstVisitClientMapping);

        if (lstVisitClientMapping.Count > 0)
        {
            long FinalBillID = 0;
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
            List<VisitClientMapping> lstVisitMap = new List<VisitClientMapping>();
            lstVisitMap = lstVisitClientMapping.FindAll(p => p.FinalBillID == FinalBillID);

            if (FinalBillID > 0)
            {
                lblClient.Text = lstVisitClientMapping[0].ClientName.ToString();
                lblRateCard.Text = lstVisitClientMapping[0].RateName.ToString();
                hdnClientId.Value = lstVisitClientMapping[0].ClientID.ToString();
                hdnRateCardID.Value = lstVisitClientMapping[0].RateID.ToString();

                //hdnPaymentlogin.Value = lstVisitMap[0].CoPaymentLogic.ToString();
                //hdnClaimlogin.Value = lstVisitMap[0].ClaimLogic.ToString();
                //hdnCoPercentage.Value = lstVisitMap[0].CopaymentPercent.ToString();
                //hdnPerAuthAmount.Value = lstVisitMap[0].PreAuthAmount.ToString();
                //hdnVisitClientMappingID.Value = lstVisitMap[0].VisitClientMappingID.ToString();
                //lblClientName.Text = lstVisitMap[0].ClientName.ToString();
                //lblPreAuthAmount.Text = lstVisitMap[0].PreAuthAmount.ToString();
                //hdnIsCreditBill.Value = lstVisitMap[0].AsCreditBill.ToString();

                //if (lstVisitMap[0].Description != null)
                //{
                //    lblCopaymentLogin.Text = "Co-Payment@ " + lstVisitMap[0].CopaymentPercent.ToString() + " % On " + lstVisitMap[0].Description.Split('~')[6].ToString() +
                //        " and " + lstVisitMap[0].Description.Split('~')[8].ToString();
                //}
                //else
                //{
                //    lblCopaymentLogin.Text = "Co-Payment@ " + lstVisitMap[0].CopaymentPercent.ToString();
                //}

            }
        }


    }
}
