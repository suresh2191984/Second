using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class InPatient_DueClearance : BasePage
{
    public InPatient_DueClearance()
        : base("InPatient\\DueClearance.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long patientID = -1;
    string patientNumber = string.Empty;
    string patientName = string.Empty;
    string vType = string.Empty;
    string pmtType = "";
    long patientVisitID;
    string dischargeStatus = string.Empty;
    string strPatientName = "";
    string strDOB = "";
    string inPatientNo = "";
    string strCellNo = "";
    string strRoomNo = "";
    string strPurpose = "";
    string ipNo = string.Empty;


    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    string ddlvalue = string.Empty;


    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                loadDueItems();
            }
            if (Request.QueryString["ddl"] != null)
            {
                ddlvalue = Request.QueryString["ddl"];
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load Due Clearance", ex);
        }
    }
    private void loadDueItems()
    {
        txtGross.Text = "0.00";
        txtGrandTotal.Text = "0.00";
        Rshiden.Value = "0";

        if (Request.QueryString["PNumber"] != null)
        {
            patientNumber = Convert.ToString(Request.QueryString["PNumber"]);
        }

        if (Request.QueryString["PNAME"] != null)
        {
            patientName = Request.QueryString["PNAME"].ToString();
        }
        if (Request.QueryString["PID"] != null)
        {
            patientID = Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        if (Request.QueryString["VID"] != null)
        {
            patientVisitID = Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["SPN"] != null)
        {
            strPatientName = Request.QueryString["SPN"].ToString();
        }
        if (Request.QueryString["SDOB"] != null)
        {
            strDOB = Request.QueryString["SDOB"].ToString();
        }
        if (Request.QueryString["SPID"] != null)
        {
            inPatientNo = Request.QueryString["SPID"].ToString();
        }
        if (Request.QueryString["SCELL"] != null)
        {
            strCellNo = Request.QueryString["SCELL"].ToString();
        }
        if (Request.QueryString["SRM"] != null)
        {
            strRoomNo = Request.QueryString["SRM"].ToString();
        }
        if (Request.QueryString["SPRP"] != null)
        {
            strPurpose = Request.QueryString["SPRP"].ToString();
        }
        if (Request.QueryString["vType"] != null)
        {
            vType = Request.QueryString["vType"].ToString();
        }
        if (Request.QueryString["ptType"] != null)
        {
            pmtType = Request.QueryString["ptType"].ToString();
        }

        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            patientVisitID = visitID;
        }

        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }



        PatientHeader.PatientID = patientID;
        PatientHeader.PatientVisitID = visitID;

        decimal dAdvanceAmount = 0;
        decimal dTotalAmount = 0;
        decimal dTotalDue = 0;
        decimal dPreviousRefund = 0;
        decimal pTotSurgeryAdv = 0;
        decimal pTotSurgeryAmt = 0;
        decimal dPayerTotal = 0;
        List<Patient> lstPatientDetail = new List<Patient>();
        List<Organization> lstOrganization = new List<Organization>();
        List<Physician> physicianName = new List<Physician>();
        List<Taxmaster> lstTaxes = new List<Taxmaster>();
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();


        BillingEngine be = new BillingEngine(base.ContextInfo);
        decimal Copercent = -1;
        be.CheckIsCreditBill(visitID,  out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);
        if (IsCreditBill == "Y")
        {
            chkisCreditTransaction.Checked = true;
        }

        decimal pNonMedicalAmtPaid = decimal.Zero;
        decimal pCoPayment = decimal.Zero;
        decimal pExcess = decimal.Zero;
        string AdmissionDate = string.Empty;
        long IntrimNo = 0;

        //if (IsCreditBill != "Y")
        //{
        string MaxBillDate = "01/01/1753";
        string IsVisitHaveChild = string.Empty;
        new PatientVisit_BL(base.ContextInfo).GetIPBillSettlement(visitID, patientID, OrgID,
                                            out dTotalAmount, out dAdvanceAmount,
                                            out dTotalDue, out dPreviousRefund,
                                            out lstDueChart, out lstBedBooking,
                                            out pTotSurgeryAdv,
                                            out pTotSurgeryAmt,
                                            out lstPatientDetail, out lstOrganization,
                                            out physicianName, out lstTaxes, out lstFinalBill, out dPayerTotal,
                                            out pNonMedicalAmtPaid, out pCoPayment, out pExcess, out AdmissionDate, out MaxBillDate, out IsVisitHaveChild,0);

        //}
        //else
        //{
        //    lblMessage.Text = "Due Collection cannot be performed for Credit Bill.";
        //}



        //IntrimNo = Convert.ToInt64(Request.QueryString["ReferenceID"]);
        // IntrimNo = lstDueChart.Last().ReceiptNO;
        IntrimNo = (lstDueChart != null && lstDueChart.Count > 0 && lstDueChart.Last() != null) ? lstDueChart.Last().ReceiptNO : 0;
        //if (Request.QueryString["ReferenceID"] != null)
        //{
        //    Int64.TryParse(Request.QueryString["ReferenceID"], out IntrimNo);
        //}  

        if (lstFinalBill.Count > 0)
        {
            if (pmtType != "pnow")
            {
                txtServiceCharge.Text = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
                hdnServiceCharge.Value = txtServiceCharge.Text;
            }
            else
            {

                hdnTempService.Value = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
            }
        }

        if (lstDueChart.Count > 0)
        {


            if (pmtType == "pnow")
            {

                var dueData = from duelist in lstDueChart
                              where (
                              duelist.FeeType.ToLower() != "soi"
                              && duelist.FeeType.ToLower() != "prm"
                              && duelist.FeeType.ToLower() != "rom"
                              && duelist.FromTable.ToLower() == "pdc"
                              && duelist.Status.ToLower() == "pending"
                              && duelist.ReceiptNO == IntrimNo
                              )
                              select duelist;

                //||( duelist.Status.ToLower() == "pending")


                if (dueData.Count() > 0)
                {
                    trAdvancedPaid.Style.Add("display", "none");
                    //lblAdvancePaid.Style.Add("display", "none");
                    //txtRecievedAdvance.Style.Add("display", "none");

                    trAmountPaid.Style.Add("display", "none");
                    //lblAmountPaid.Style.Add("display", "none");
                    //txtPreviousAmountPaid.Style.Add("display", "none");


                    trPreviousDue.Style.Add("display", "none");
                    //lblPreviousDue.Style.Add("display", "none");
                    //txtPreviousDue.Style.Add("display", "none");

                    gvIndents.DataSource = dueData;
                    gvIndents.DataBind();

                    txtRecievedAdvance.Text = "0";
                    txtPreviousAmountPaid.Text = "0";
                    txtPreviousDue.Text = "0";
                    txtPreviousRefund.Text = "0";

                    Nodata.Visible = false;
                    trAmtDetails.Attributes.Add("display", "block");
                    hdnYesData.Value = "1";
                    YesData.Visible = true;


                }
                else
                {
                    Nodata.Visible = true;
                    YesData.Attributes.Add("display", "none");
                    trAmtDetails.Attributes.Add("display", "none");
                    hdnYesData.Value = "0";
                    // YesData.Attributes.Add("display", "none");
                }
            }
            else
            {
                var dueData = from duelist in lstDueChart
                              where (duelist.FeeType.ToLower() != "soi" && duelist.FeeType.ToLower() != "prm" && duelist.FeeType.ToLower() != "rom" && duelist.FromTable.ToLower() == "pdc" && duelist.Status.ToLower() == "pending")
                              select duelist;
                if (dueData.Count() > 0)
                {

                    //trAdvancedPaid.Style.Add("display", "block");
                    //lblAdvancePaid.Style.Add("display", "block");
                    //txtRecievedAdvance.Style.Add("display", "block");

                    //trPreviousDue.Style.Add("display", "block");

                    //lblPreviousDue.Style.Add("display", "block");
                    //txtPreviousDue.Style.Add("display", "block");

                    //trAmountPaid.Style.Add("display", "block");
                    //lblAmountPaid.Style.Add("display", "block");
                    //txtPreviousAmountPaid.Style.Add("display", "block");


                    gvIndents.DataSource = dueData;
                    gvIndents.DataBind();

                    txtRecievedAdvance.Text = dAdvanceAmount.ToString();
                    txtPreviousAmountPaid.Text = dTotalAmount.ToString();
                    txtPreviousDue.Text = "0.00";
                    txtPreviousRefund.Text = dPreviousRefund.ToString();

                    Nodata.Visible = false;
                    YesData.Visible = true;
                    trAmtDetails.Attributes.Add("display", "block");
                    hdnYesData.Value = "1";

                }
                else
                {
                    Nodata.Visible = true;
                    hdnYesData.Value = "0";
                    YesData.Attributes.Add("display", "none");
                }
            }

            gridAttributesAdd();



        }
        else
        {
            Nodata.Visible = true;
            YesData.Attributes.Add("display", "none");
        }
        //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(hdnServiceCharge.Value) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
        //                 Convert.ToDecimal(txtRecievedAdvance.Text)) + Convert.ToDecimal(txtPreviousDue.Text));
        //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(hdnServiceCharge.Value) - 
        //    (Convert.ToDecimal(txtRecievedAdvance.Text)) + Convert.ToDecimal(txtPreviousDue.Text));
        txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(hdnServiceCharge.Value) -
             +Convert.ToDecimal(txtPreviousDue.Text));
        if (Convert.ToDecimal(txtGrandTotal.Text) < 0)
        {
            txtRefundAmount.Text = txtGrandTotal.Text.Replace("-", "");
            txtGrandTotal.Text = "0";
            if (dPreviousRefund < (Convert.ToDecimal(txtRefundAmount.Text) + dPreviousRefund))
            {
                txtRefundAmount.Text = Convert.ToString(Convert.ToDecimal(txtRefundAmount.Text) - dPreviousRefund);
            }
            else
            {
                txtRefundAmount.Text = "0";
            }
        }
        txtRefundAmount.Text = txtRefundAmount.Text == "" ? "0" : txtRefundAmount.Text;
        if (Convert.ToDecimal(txtRefundAmount.Text) < 0)
        {
            txtGrandTotal.Text = txtRefundAmount.Text.Replace("-", "");
            txtRefundAmount.Text = "0";
        }

        hdnGross.Value = txtGross.Text;
        if (IsPostBack)
        {
            //Table dvPaymentTable = (Table)PaymentType.FindControl("dvPaymentTable");
            //dvPaymentTable.Rows.RemoveAt(1);
            //int a = PaymentType.FindControl("dvPaymentTable").ClientID.;
            //PaymentType.FindControl("dvPaymentTable").ClientID.Remove(a - 1);
            //PaymentType.FindControl("dvPaymentTable").Visible = false;

        }
    }


    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueChart pdc = (PatientDueChart)e.Row.DataItem;
            if (pdc.IsReimbursable != "N")
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = true;
            }
            else
            {
                ((CheckBox)e.Row.FindControl("chkIsReImbursableItem")).Checked = false;
            }



            //To Display Check Box on Grid
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            CheckBox chkRefund1 = (CheckBox)e.Row.FindControl("chkRefund1");


            //if (pdc.Status.ToUpper() == "PAID")
            //{
            //    e.Row.Attributes.Add("disabled", "true");
            //    chkRefund1.Checked = false;
            //}

            string CalcNonReimbursable = "CheckedCal('" + txtAmount.ClientID +
                                                    "','" + chkRefund1.ClientID +
                                                     "');";

            chkRefund1.Attributes.Add("OnClick", CalcNonReimbursable);
        }
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        //e.Row.Cells[3].Visible = false;
        e.Row.Cells[11].Visible = false;

    }

    protected void gridAttributesAdd()
    {
        decimal dtotalAmount = 0;
        string sStatus = "";

        foreach (GridViewRow row in gvIndents.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();

            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");
            Label lblComments = (Label)row.FindControl("Comments");

            TextBox txtIndvDiscount = new TextBox();
            txtIndvDiscount = (TextBox)row.FindControl("txtDiscount");

            lblComments.Text = lblComments.Text.Trim().Split('~')[0];

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");

            string sFunProcedures = "doCalcDue('" + txtUnitPrice.ClientID +
                                            "','" + txtQuantity.ClientID +
                                            "','" + txtAmount.ClientID +
                                            "','" + hdnAmount.ClientID +
                                            "','" + hdnOldPrice.ClientID +
                                            "','" + hdnOldQuantity.ClientID +
                                            "','" + txtGross.ClientID +
                                            "','" + txtDiscount.ClientID +
                                            "','" + txtRecievedAdvance.ClientID +
                                            "','" + txtGrandTotal.ClientID +
                                            "','" + hdnGross.ClientID +
                                            "','" + txtIndvDiscount.ClientID +
                                            "','" + hdnDiscountArray.ClientID +
                                            "');document.getElementById('" + txtIndvDiscount.ClientID + "').value=parseFloat(document.getElementById('" + txtIndvDiscount.ClientID + "').value).toFixed(2);";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            txtIndvDiscount.Attributes.Add("onBlur", sFunProcedures);

            hdnDiscountArray.Value = txtIndvDiscount.ClientID + "|" + hdnDiscountArray.Value.Trim();

            dtotalAmount += Convert.ToDecimal(txtAmount.Text);

            if (RoleName.ToLower() != "Administrator")
            {
                sStatus = row.Cells[11].Text.Trim();
                if ((sStatus.ToLower() == "ordered") || (sStatus.ToLower() == "pending"))
                {
                    txtQuantity.Enabled = true;
                    txtUnitPrice.Enabled = true;
                }
                else
                {
                    txtQuantity.Enabled = false;
                    txtUnitPrice.Enabled = false;
                }
            }
            if (txtUnitPrice.Text == "0.00")
            {
                row.BackColor = System.Drawing.Color.Tomato;
            }
        }
        txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }

            long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            if (Request.QueryString["PNumber"] != null)
            {
                patientNumber = Convert.ToString(Request.QueryString["PNumber"]);
            }

            string LabNo = string.Empty;
            if (Request.QueryString["LabNo"] != null)
            {
                LabNo = Convert.ToString(Request.QueryString["LabNo"]);
            }

            decimal FinalAmount = 0;

            string sPaymentType = "";
            //if (Request.QueryString["PTYPE"] != null)
            //{
            //    sPaymentType = Request.QueryString["PTYPE"].ToString();
            //}

            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            string sSTatus = "";
            string Flag = string.Empty;
            if (Request.QueryString["Flg"] != null)
            {
                Flag = Request.QueryString["Flg"];
            }
            else
            {
                Flag = "Save";
            }

            foreach (GridViewRow row in gvIndents.Rows)
            {
                CheckBox chkRefund1 = (CheckBox)row.Cells[3].FindControl("chkRefund1");
                sSTatus = row.Cells[11].Text.Trim().ToLower();
                if ((sSTatus != "paid") && (sSTatus != "printed") && (chkRefund1.Checked == true))
                {
                    TextBox txtUnitPrice = new TextBox();
                    TextBox txtQuantity = new TextBox();
                    TextBox txtAmount = new TextBox();
                    HiddenField hdnAmount = new HiddenField();
                    TextBox txtItemisedDiscount = (TextBox)row.FindControl("txtDiscount");

                    txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
                    txtQuantity = (TextBox)row.FindControl("txtQuantity");
                    txtAmount = (TextBox)row.FindControl("txtAmount");
                    hdnAmount = (HiddenField)row.FindControl("hdnAmount");


                    PatientDueChart _PatientDueChart = new PatientDueChart();
                    _PatientDueChart.DetailsID = Convert.ToInt64(row.Cells[0].Text);
                    _PatientDueChart.FeeID = Convert.ToInt64(row.Cells[2].Text);
                    _PatientDueChart.FeeType = row.Cells[1].Text;
                    _PatientDueChart.Description = row.Cells[4].Text;

                    txtAmount.Text = txtAmount.Text == "" ? txtUnitPrice.Text : txtAmount.Text;
                    hdnAmount.Value = (hdnAmount.Value == null || hdnAmount.Value == "") ? txtAmount.Text : hdnAmount.Value;
                    _PatientDueChart.Amount = Convert.ToDecimal(txtUnitPrice.Text.ToString());
                    _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    _PatientDueChart.FromDate = Convert.ToDateTime(row.Cells[6].Text);
                    _PatientDueChart.ToDate = Convert.ToDateTime(row.Cells[7].Text);
                    _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());
                    _PatientDueChart.Remarks = LabNo;
                    _PatientDueChart.DiscountAmount = Convert.ToDecimal(txtItemisedDiscount.Text.Trim() == "" ? "0" : txtItemisedDiscount.Text.Trim());

                    if (txtQuantity.Text != "0")
                    {
                        _PatientDueChart.Status = "Paid";
                    }
                    else
                    {
                        _PatientDueChart.Status = "Deleted";
                    }
                    FinalAmount += _PatientDueChart.Amount;

                    if (((CheckBox)row.FindControl("chkIsReImbursableItem")).Checked)
                    {
                        _PatientDueChart.IsReimbursable = "Y";
                    }
                    else
                    {
                        _PatientDueChart.IsReimbursable = "N";
                    }
                    if (ddlvalue == "Clear Dues")
                    {
                        _PatientDueChart.IsTaxable = "P";//pdc
                    }
                    else
                    {
                        _PatientDueChart.IsTaxable = "B";//BDT
                    }


                    lstPatientDueChart.Add(_PatientDueChart);
                }
            }

            string isCreditBill = "";
            if (chkisCreditTransaction.Checked == true)
            {
                isCreditBill = "Y";
            }
            else
            {
                isCreditBill = "N";
            }


            txtGross.Text = FinalAmount.ToString();

            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtRecievedAdvance.Text = txtRecievedAdvance.Text == "" ? "0" : txtRecievedAdvance.Text;
            txtGrandTotal.Text = txtGrandTotal.Text == "" ? "0" : txtGrandTotal.Text;
            hdnAmountReceived.Value = hdnAmountReceived.Value == "" ? "0" : hdnAmountReceived.Value;

            decimal pAmtReceived = Convert.ToDecimal(hdnAmountReceived.Value.ToString());
            decimal pAdvanceReceived = Convert.ToDecimal(txtRecievedAdvance.Text);
            decimal pPreviousDue = Convert.ToDecimal(txtPreviousDue.Text);
            //decimal PreviousAmountReceived = Convert.ToDecimal(txtPreviousAmountPaid.Text);
            decimal pAmountReceived = pAmtReceived; //+PreviousAmountReceived;

            decimal pRefundAmount = 0;

            string sreasonforRefund = "";
            if (ChkRefund.Checked == true)
            {
                pRefundAmount = Convert.ToDecimal(txtRefundAmount.Text);
                sreasonforRefund = txtReasonForRefund.Text;
            }

            decimal pDiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            decimal pDue = 0;
            if (pAmountReceived == FinalAmount)
            {
                pDue = 0;
            }
            else
            {
                pDue = FinalAmount - pAmountReceived;
            }

            decimal pGrossBillValue = (FinalAmount + pPreviousDue) -
                (pDiscountAmount + pAdvanceReceived);
            // decimal pGrossBillValue =Convert.ToDecimal (txtGross.Text);
            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            dServiceCharge += Convert.ToDecimal(hdnTempService.Value);
            decimal pnetValue = FinalAmount + dServiceCharge - pDiscountAmount;

            System.Data.DataTable dtAmtReceivedDetails = new System.Data.DataTable();
            dtAmtReceivedDetails = PaymentType.GetAmountReceivedDetails();

            //lstPatientDueChart = new List<PatientDueChart>();
            string PayerType = string.Empty;
            string TPAPaymentStatus = string.Empty;
            PayerType = "Patient";
            TPAPaymentStatus = "Pending";
            string ReceiptNo = string.Empty;
            long IpIntermediateID = 0;
            string sType = "";
            new PatientVisit_BL(base.ContextInfo).InsertPatientBillItemsDetails(lstPatientDueChart, visitID, LID, OrgID,
                                                                    pAmountReceived, pRefundAmount,
                                                                    pDiscountAmount, pDue,
                                                                    pGrossBillValue, isCreditBill,
                                                                    pnetValue, pAdvanceReceived,
                                                                    dtAmtReceivedDetails, pAmtReceived,
                                                                    LID, sPaymentType, ILocationID,
                                                                    dServiceCharge, TPAPaymentStatus,
                                                                    PayerType, out ReceiptNo, out IpIntermediateID,
                                                                    out sType);

            //Response.Redirect("~/InPatient/IPCashReceipt.aspx?VID=" + visitID + "&PID=" + patientID);

            string sPage = "PrintReceiptPage.aspx?rcptno=" + ReceiptNo.ToString()
                         + "&PID=" + patientID.ToString()
                         + "&PNO=" + patientNumber.ToString()
                         + "&VID=" + visitID.ToString()
                         + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "";
            this.Page.RegisterClientScriptBlock("sky", "<script language='javascript'> window.open('" + sPage + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
            btnSave.Enabled = false;
            this.Page.RegisterStartupScript("sky", "<script>ClearPaymentControlEvents();</script>");
            loadDueItems();
        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Due Clearance", ex);
        }
    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            //List<Role> lstUserRole = new List<Role>();
            //string path = string.Empty;
            //Role role = new Role();
            //role.RoleID = RoleID;
            //lstUserRole.Add(role);
            //long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            //Response.Redirect(Request.ApplicationPath  + path, true);

            Response.Redirect(Request.ApplicationPath  + "/InPatient/IPBillingHome.aspx" + "?SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
