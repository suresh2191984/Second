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

public partial class Billing_OPBillSettlement : BasePage
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
    string sAddBI = string.Empty;
    string patientType = string.Empty;
    string gUID = string.Empty;
    long FinalID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            CLogger.LogInfo("step1:");
            string rval = GetConfigValue("roundoffpatamt", OrgID);
            hdnDefaultRoundoff.Value = rval;
            rval = GetConfigValue("patientroundoffpattern", OrgID);
            hdnRoundOffType.Value = rval;
            btnSave.Enabled = true;
            loadRateType();
            loadCopaymentLogin();
            loadClaimAmountType();
            GetCorporateDiscount();
            LoadBillingDetail();
            // LoadTaxMaster();
            LoadClientValue();




        }
        AutoCompleteExtenderClientCorp.ContextKey = "CLI";
    }


    private void LoadBillingDetail()
    {
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            BillingEngine billBL = new BillingEngine(base.ContextInfo);
            List<FinalBill> lstFinalBillNO = new List<FinalBill>();
            List<FinalBill> lstFinalBillNOWise = new List<FinalBill>();
            billBL.GetOPBillSettlement(patientVisitID, OrgID, out lstBillingDetails, out lstFinalBill, out lstFinalBillNOWise);
            gvBillingDetail.DataSource = lstBillingDetails;
            gvBillingDetail.DataBind();
            gridAttributesAdd(gvBillingDetail);
            MergeRows(gvBillingDetail);

            if (lstFinalBill.Count > 0)
            {
                txtGross.Text = String.Format("{0:0.00}", lstFinalBill[0].GrossBillValue);
                hdnGross.Value = txtGross.Text;
                txtNetValue.Text = String.Format("{0:0.00}", GetCustomRoundoff(lstFinalBill[0].NetValue));
                hdnNetValue.Value = txtNetValue.Text;
                txtPreviousAmountPaid.Text = (lstFinalBill[0].AmountReceived - lstFinalBill[0].AmountRefund).ToString();
                hdnPreviousRecievedAmount.Value = txtPreviousAmountPaid.Text;
                hdnRoundOff.Value = lstFinalBill[0].RoundOff.ToString();
                txtRoundOff.Text = lstFinalBill[0].RoundOff.ToString();
                hdnoldRoundOff.Value = lstFinalBill[0].RoundOff.ToString();
                hdnEditVisitDetails.Value = lstFinalBill[0].Comments;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while load Billing detail in loadBillingMethod in Billing.aspx page", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        try
        {
            txtAmountRecieved.Text = hdnAmountReceived.Value == null ? "0" : hdnAmountReceived.Value.ToString();
            txtPreviousAmountPaid.Text = hdnPreviousRecievedAmount.Value == null ? "0" : hdnPreviousRecievedAmount.Value.ToString();
            decimal pRoundOff = 0;
            decimal.TryParse(hdnRoundOff.Value, out pRoundOff);

            if (pRoundOff == 0)
            {
                decimal.TryParse(hdnoldRoundOff.Value, out pRoundOff);
            }

            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();

            foreach (GridViewRow row in gvBillingDetail.Rows)
            {
                TextBox txtAmount = new TextBox();
                Label BillingDetailsID = new Label();
                TextBox txtQty = new TextBox();
                txtAmount = (TextBox)row.FindControl("txtUnitPrice");
                TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");
                CheckBox chkReImbursableItem = (CheckBox)row.FindControl("chkIsReImbursableItem");
                Label BillNumber = (Label)row.FindControl("lblBillNo");

                BillingDetailsID = (Label)row.FindControl("BillingDetailsID");
                txtQty = (TextBox)row.FindControl("txtQuantity");
                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = Convert.ToInt64(BillingDetailsID.Text);
                ((Label)row.FindControl("lblFeeID")).Text = ((Label)row.FindControl("lblFeeID")).Text == "" ? "0" : ((Label)row.FindControl("lblFeeID")).Text;
                _PatientDueChart.FeeID = Convert.ToInt64(((Label)row.FindControl("lblFeeID")).Text.Trim());
                _PatientDueChart.FeeType = ((Label)row.FindControl("lblFeeType")).Text.Trim();
                _PatientDueChart.Description = ((Label)row.FindControl("lblDescription")).Text.Trim();
                _PatientDueChart.IsReimbursable = chkReImbursableItem.Checked == true ? "Y" : "N";
                txtAmount.Text = txtAmount.Text == "" ? "0" : txtAmount.Text;
                _PatientDueChart.ClientID = Convert.ToInt64(BillNumber.Text);//Final BillID
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

            decimal RateDifferenceAmount = 0;
            decimal.TryParse(hdnRateDifferenceAmount.Value, out RateDifferenceAmount);

            if (RateDifferenceAmount > 0)
            {
                PatientDueChart _PatientDueChart = new PatientDueChart();
                _PatientDueChart.DetailsID = 0;
                _PatientDueChart.FeeType = "OTH";
                _PatientDueChart.Description = "OTHERS";
                _PatientDueChart.IsReimbursable = "N";
                _PatientDueChart.Amount = RateDifferenceAmount;
                _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                _PatientDueChart.Unit = 1;
                _PatientDueChart.Status = "Paid";
                _PatientDueChart.Remarks = labno;
                _PatientDueChart.DiscountAmount = 0;
                lstPatientDueChart.Add(_PatientDueChart);
            }
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            string feeType = String.Empty;
            FinalBill finalBill = new FinalBill();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);

            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.GrossBillValue = Convert.ToDecimal(hdnGross.Value.ToString());
            finalBill.NetValue = (finalBill.GrossBillValue + dServiceCharge)
                                    + pRoundOff;
            finalBill.ServiceCharge = dServiceCharge;
            finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text)
                + Convert.ToDecimal(txtPreviousAmountPaid.Text);

            finalBill.ModifiedBy = LID;
            finalBill.IsCreditBill = hdnIsCreditBill.Value;

            decimal recievedAmount = Convert.ToDecimal(txtAmountRecieved.Text);
            txtPreviousAmountPaid.Text = txtPreviousAmountPaid.Text == "" ? "0" : txtPreviousAmountPaid.Text;

            List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();

            //if (recievedAmount > 0)
            //{
                if (Convert.ToDecimal(txtNetValue.Text) > 0 && hdnIsCreditBill.Value == "N")
                {
                    finalBill.CurrentDue = finalBill.NetValue - finalBill.AmountReceived;
                    finalBill.Due = (finalBill.GrossBillValue + dServiceCharge + pRoundOff)
                                        - (Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtPreviousAmountPaid.Text));//- recievedAmount 
                }
                else if (Convert.ToDecimal(txtNetValue.Text) > 0 && hdnIsCreditBill.Value == "Y")
                {
                    finalBill.CurrentDue = Convert.ToDecimal(hdnTowardsAmount.Value) - Convert.ToDecimal(txtAmountRecieved.Text);
                    finalBill.Due = Convert.ToDecimal(hdnTowardsAmount.Value) - Convert.ToDecimal(txtAmountRecieved.Text);//- recievedAmount 
                }
                else
                {
                    finalBill.Due = 0;
                }
                finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtPreviousAmountPaid.Text);
           // }

            finalBill.RoundOff = pRoundOff;

            List<PatientDueDetails> lstPatientDueDetails = new List<PatientDueDetails>();
            PatientDueDetails PDD = new PatientDueDetails();
            PDD.PatientID = patientID;
            PDD.VisitID = patientVisitID;

            if (hdnIsCreditBill.Value == "N")
            {
                PDD.DueAmount = (finalBill.GrossBillValue + dServiceCharge + pRoundOff)
                                                 - (Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtPreviousAmountPaid.Text));
            }
            else
            {
                PDD.DueAmount = Convert.ToDecimal(hdnTowardsAmount.Value) - Convert.ToDecimal(txtAmountRecieved.Text);
            }

            PDD.OrgID = OrgID;
            PDD.IsCreditBill = finalBill.IsCreditBill;
            PDD.OrgID = OrgID;
            PDD.Status = "Open";

            if (PDD.DueAmount > 0)
            {
                lstPatientDueDetails.Add(PDD);
            }

            AmountReceivedDetails amtRD = new AmountReceivedDetails();
            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();
            amtRD.AmtReceived = Convert.ToDecimal(txtAmountRecieved.Text);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;

            decimal pRefundAmount = 0;
            string ReasonforRefund = "";
            int lstPaymentType = 0;
            string BankName = "";
            string ChekNO = "";

            if (ChkRefund.Checked == true)
            {
                pRefundAmount = Convert.ToDecimal(txtAmountRefunded.Text);
                ReasonforRefund = txtReasonForRefund.Text;

                lstPaymentType = Convert.ToInt32(ddlPayMode.SelectedValue);

                if (lstPaymentType == 2)
                {
                    BankName = txtBankName.Text;
                    ChekNO = txtCardNo.Text;
                }

            }
            finalBill.AmountRefund = pRefundAmount;
            finalBill.RefundStatus = ReasonforRefund;
            List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
            VisitClientMapping lstVitiClient = new VisitClientMapping();
            lstVitiClient.CoPaymentLogic = Convert.ToInt32(hdnPaymentlogin.Value);
            lstVitiClient.ClientID = Convert.ToInt64(hdnClientID.Value);
            lstVitiClient.RateID = Convert.ToInt64(hdnRateCardID.Value);
            lstVitiClient.ClientName = txtClient.Text != "" ? txtClient.Text : lblClient.Text;
            lstVitiClient.RateName = txtClient.Text != "" ? ddlRateCard.SelectedItem.Text : lblRateCard.Text;
            lstVitiClient.ClaimLogic = Convert.ToInt32(hdnClaimlogin.Value);
            lstVitiClient.CopaymentPercent = hdnCoPercentage.Value != "" ? Convert.ToDecimal(hdnCoPercentage.Value) : 0;
            lstVitiClient.PreAuthApprovalNumber = txtPreAuthApprovalNumber.Text;
            lstVitiClient.PreAuthAmount = Convert.ToDecimal(hdnPerAuthAmount.Value);
            lstVitiClient.ClaimAmount = Convert.ToDecimal(hdnClaim.Value);
            lstVisitClientMapping.Add(lstVitiClient);
            List<Edt_AccountsImpactDetails> lstAccountImpact = new List<Edt_AccountsImpactDetails>();

            long returncode = -1;
            decimal NewAmountRecvd = 0;
            Decimal.TryParse(txtAmountRecieved.Text, out NewAmountRecvd);

            returncode = billingEngineBL.UpdateSettlementFinallBill(finalBill, amtRD, dtAmountReceived, lstPatientDueChart,
                lstTaxDetails, dServiceCharge, lstPatientDueDetails, lstAccountImpact, lstVisitClientMapping,
                lstPaymentType, BankName, ChekNO, NewAmountRecvd);

            Response.Redirect("../Billing/MergeBillPrint.aspx?VID=" + patientVisitID, true);

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while Final Bill Update in Billing.aspx page", ex);
            btnSave.Visible = true;
            btnSave.Enabled = true;
        }

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

    public void GetCorporateDiscount()
    {
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        patientVisitBL.GetCorporateClientByVisit(patientVisitID, out lstPatientVisit);
        if (lstPatientVisit.Count > 0)
        {
            hdnCorporateDiscount.Value += lstPatientVisit[0].Discount + "~" + lstPatientVisit[0].DiscountType + "^";
        }
    }

    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillingDetails bd = (BillingDetails)e.Row.DataItem;
                TextBox txtUnitPrice = new TextBox();
                txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");
                Label lbEditStatus = new Label();

                gvBillingDetail.Columns[5].Visible = false;
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

        foreach (GridViewRow row in gvDataGrid.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            TextBox txtIndvDiscount = new TextBox();

            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();

            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");
            txtIndvDiscount = (TextBox)row.FindControl("txtDiscount");

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");

            string sFunProcedures = "funcChkProcedures1('" + txtUnitPrice.ClientID +
                                            "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID +
                                            "','" + hdnAmount.ClientID +
                                            "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID +
                                            "','" + txtGross.ClientID +
                                            "','" + txtReceivedAdvance.ClientID + "','" + txtNetValue.ClientID +
                                            "','" + hdnGross.ClientID +
                                            "','" + txtIndvDiscount.ClientID + "');";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtIndvDiscount.Attributes.Add("onBlur", sFunProcedures);

            dtotalAmount += Convert.ToDecimal(txtAmount.Text);
            hdnDiscountArray.Value = txtIndvDiscount.ClientID + "|" + hdnDiscountArray.Value.Trim();

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


    public static void MergeRows(GridView gridView)
    {

        for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = gridView.Rows[rowIndex];
            GridViewRow previousRow = gridView.Rows[rowIndex + 1];


            Label currenValue = (Label)row.FindControl("lblBillNumber");
            Label previousValue = (Label)previousRow.FindControl("lblBillNumber");

            if (currenValue.Text == previousValue.Text)
            {
                row.Cells[0].RowSpan = previousRow.Cells[0].RowSpan < 2 ? 2 : previousRow.Cells[0].RowSpan + 1;

                previousRow.Cells[0].Visible = false;
            }


        }
    }
    protected void ddlRateCard_SelectedIndexChanged(object sender, EventArgs e)
    {
        ChangeRateCard();
    }

    public void ChangeRateCard()
    {
        if (ddlRateCard.SelectedValue != "0")
        {
            List<BillingDetails> lstDetails = new List<BillingDetails>();
            decimal BilledandSelectedRateCardDifference = -1;
            BillingEngine objBE = new BillingEngine(new BaseClass().ContextInfo);
            long VisitID = 0;
            Int64.TryParse(Request.QueryString["vid"], out VisitID);
            objBE.GetBillingDetailsByRateTypeForOP(VisitID, 0, 0, Convert.ToInt64(ddlRateCard.SelectedValue), out BilledandSelectedRateCardDifference, OrgID, "OP", out lstDetails);
            gvBillingDetail.DataSource = lstDetails;
            gvBillingDetail.DataBind();
            gridAttributesAdd(gvBillingDetail);
            MergeRows(gvBillingDetail);
            BillingEngine billBL = new BillingEngine(new BaseClass().ContextInfo);
            List<FinalBill> lstFinalBillNO = new List<FinalBill>();
            List<FinalBill> lstFinalBillNOWise = new List<FinalBill>();
            billBL.GetOPBillSettlement(VisitID, OrgID, out lstBillingDetails, out lstFinalBill, out lstFinalBillNOWise);

            if (lstFinalBill.Count > 0)
            {
                txtGross.Text = String.Format("{0:0.00}", lstFinalBill[0].GrossBillValue);
                hdnGross.Value = txtGross.Text;
                txtNetValue.Text = String.Format("{0:0.00}", lstFinalBill[0].NetValue);
                hdnNetValue.Value = txtNetValue.Text;
                txtPreviousAmountPaid.Text = (lstFinalBill[0].AmountReceived - lstFinalBill[0].AmountRefund).ToString();
                hdnPreviousRecievedAmount.Value = txtPreviousAmountPaid.Text;
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "SetVal", "TotalMedial();", true);
        }
    }
    public void LoadClientValue()
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        long returnCode = -1;
        PatientVisit_BL obj = new PatientVisit_BL(new BaseClass().ContextInfo);
        long VisitID = 0;
        Int64.TryParse(Request.QueryString["vid"], out VisitID);
        returnCode = obj.GetVisitClientMappingDetails(OrgID, VisitID, out lstVisitClientMapping);

        if (lstVisitClientMapping.Count > 0)
        {
            hdnPaymentlogin.Value = lstVisitClientMapping[0].CoPaymentLogic.ToString();
            hdnClientID.Value = lstVisitClientMapping[0].ClientID.ToString();
            hdnRateCardID.Value = lstVisitClientMapping[0].RateID.ToString();
            lblClient.Text = lstVisitClientMapping[0].ClientName.ToString();
            lblRateCard.Text = lstVisitClientMapping[0].RateName.ToString();
            hdnClaimlogin.Value = lstVisitClientMapping[0].ClaimLogic.ToString();
            hdnCoPercentage.Value = lstVisitClientMapping[0].CopaymentPercent.ToString();
            hdnPerAuthAmount.Value = lstVisitClientMapping[0].PreAuthAmount.ToString();
            hdnVisitClientMappingID.Value = lstVisitClientMapping[0].VisitClientMappingID.ToString();
            hdnIsCreditBill.Value = lstVisitClientMapping[0].AsCreditBill.ToString();
        }

     

        if (hdnEditVisitDetails.Value != "")
        {
            string[] lsValue = hdnEditVisitDetails.Value.Split('~');
            hdnClientID.Value = lsValue[0];
            txtClient.Text = lsValue[1];
            hdnRateCardID.Value = lsValue[3];
            hdnCoPercentage.Value = lsValue[5];
            hdnPaymentlogin.Value = lsValue[7];
            hdnClaimlogin.Value = lsValue[9];
            hdnPerAuthAmount.Value = lsValue[10];
            txtCoperent.Text = lsValue[5];
            txtAuthamount.Text = lsValue[10];
            hdnIsCreditBill.Value = lsValue[15];
            hdnClaim.Value = lsValue[16];

            ddlpaymentLogic.SelectedValue = lsValue[7];
            ddlClaimAmount.SelectedValue = lsValue[9];
        }



    }


    private void loadCopaymentLogin()
    {
        try
        {
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            lstmetadataInput.Add(new MetaData { Domain = "CopaymentLogic" });
            new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "CopaymentLogic"
                             select child;
            ddlpaymentLogic.DataSource = childItems;
            ddlpaymentLogic.DataTextField = "DisplayText";
            ddlpaymentLogic.DataValueField = "Code";
            ddlpaymentLogic.DataBind();
            ddlpaymentLogic.Items.Insert(0, "--Select--");
            ddlpaymentLogic.Items[0].Value = "-1";


        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    private void loadClaimAmountType()
    {
        List<ClaimAmountLogic> lstClaim = new List<ClaimAmountLogic>();
        try
        {
            new AdminReports_BL(base.ContextInfo).pGetClaimAmountLogic(OrgID, out lstClaim);
            ddlClaimAmount.DataSource = lstClaim;
            ddlClaimAmount.DataTextField = "ClaimLogicName";
            ddlClaimAmount.DataValueField = "ClaimID";
            ddlClaimAmount.DataBind();
            ddlClaimAmount.Items.Insert(0, "--Select--");
            ddlClaimAmount.Items[0].Value = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Claim amount data in  Client Insurance", ex);
        }

    }
    protected void btnChangeRateCard_Click(object sender, EventArgs e)
    {
        ChangeRateCard(); 
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
}

