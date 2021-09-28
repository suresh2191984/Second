using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using Attune.Podium.BillingEngine;
 
public partial class InPatient_BillCollect:BasePage
{
    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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
            string sPaymentType = "";
            if (Request.QueryString["PTYPE"] != null)
            {
                sPaymentType = Request.QueryString["PTYPE"].ToString();
            }

            //if (sPaymentType.ToLower() != "pnow")
            //{
            //    txtAmt.ReadOnly = true;
            //    txtAmt.Text = "0";
            //}
            //else
            //{
            //    txtAmt.ReadOnly = false;
            //}

            decimal dAdvanceAmount = 0;
            PatientHeader.PatientID = patientID;
            PatientHeader.PatientVisitID = visitID;

            List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
            List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
            new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, sPaymentType, out dAdvanceAmount, out lstadvancepaidDetails);
            if (lstDueChart.Count > 0)
            {
                gvIndents.DataSource = lstDueChart;
                gvIndents.DataBind();
                gridAttributesAdd();
                txtRecievedAdvance.Text = dAdvanceAmount.ToString();
            }
            //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) - dAdvanceAmount);
            txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text));
            hdnGross.Value = txtGrandTotal.Text;



            BillingEngine be = new BillingEngine(base.ContextInfo);
            decimal Copercent=-1;
            be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);

            if (IsCreditBill == "Y")
            {
                chkisCreditTransaction.Checked = true;
            }

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
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

        decimal FinalAmount = 0;

        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }
        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);


        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        foreach (GridViewRow row in gvIndents.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            HiddenField hdnAmount = new HiddenField();

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
            _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());
            if (txtQuantity.Text != "0")
            {
               _PatientDueChart.Status = "Paid";
            }
            else
            {
                _PatientDueChart.Status = "Deleted";
            }
            FinalAmount += _PatientDueChart.Amount;
            lstPatientDueChart.Add(_PatientDueChart);
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

        //decimal pAmountReceived = Convert.ToDecimal(txtRecievedAdvance.Text) + pAmtReceived;
        decimal pAmountReceived = pAmtReceived;
        decimal pRefundAmount = 0;
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
        decimal pGrossBillValue = FinalAmount - pDiscountAmount - pAdvanceReceived;
        decimal pnetValue = Convert.ToDecimal(txtGrandTotal.Text);
     
        System.Data.DataTable dtAmtReceivedDetails = new System.Data.DataTable();
        dtAmtReceivedDetails = PaymentType.GetAmountReceivedDetails();
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
                                                                    PayerType,out ReceiptNo,out IpIntermediateID,out sType);


        //string sPage = "~InPatient/PrintReceiptPage.aspx?Amount="
        //             + pnetValue.ToString() + "&dDate="
        //             + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
        //             + "&rcptno=" + ReceiptNo.ToString()
        //             + "&PNAME=" + patientName + "";
        //Response.Redirect(sPage, true);

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
    }
    protected void gridAttributesAdd()
    {
        decimal dtotalAmount = 0;
        foreach(GridViewRow row in gvIndents.Rows)
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

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");

            string sFunProcedures = "funcChkProcedures('" + txtUnitPrice.ClientID + 
                                            "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID + 
                                            "','" + hdnAmount.ClientID +  
                                            "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID + 
                                            "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                            "','" + txtRecievedAdvance.ClientID + "','" + txtGrandTotal.ClientID + "','" + hdnGross.ClientID + "');";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            dtotalAmount += Convert.ToDecimal(txtAmount.Text);

            if (txtUnitPrice.Text == "0.00")
            {
                row.BackColor = System.Drawing.Color.Tomato;
            }

        }
        txtGross.Text = dtotalAmount.ToString();
        
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        long visitID=0;
         if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }


        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }
        if (sPaymentType != "")
        {
            Response.Redirect("~/InPatient/AdvancePaidDetails.aspx?VID=" + visitID + "&PID=" + patientID + "&PTYPE=" + sPaymentType);
        }
        else
        {
            Response.Redirect("~/InPatient/InPatientBilling.aspx?VID=" + visitID + "&PID=" + patientID);
        }
    }

    protected void btnAddAmt_Click(object sender, EventArgs e)
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
            string pType = "";
            if (Request.QueryString["PTYPE"] != null)
            {
                pType = Request.QueryString["PTYPE"].ToString();
            }

            PatientDueChart pDueChart = new PatientDueChart();
            pDueChart.DetailsID = 0;
            pDueChart.VisitID = visitID;
            pDueChart.PatientID = patientID;
            pDueChart.FeeType = "OTH";
            pDueChart.FeeID = -1;
            pDueChart.Description = txtDesc.Text;

            pDueChart.Amount = Convert.ToDecimal(txtAmt.Text);
            pDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            pDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            if (pType.ToLower() == "pnow")
            {
                pDueChart.Status = "Ordered";//
                pDueChart.Comments = txtAmt.Text.Trim();
            }
            else
            {
                pDueChart.Comments = txtAmt.Text.Trim();
                pDueChart.Status = "Pending";
            }

            pDueChart.Unit = 1;
            pDueChart.CreatedBy = Convert.ToInt32(LID);
            string InterimBillNo = string.Empty;
            new PatientVisit_BL(base.ContextInfo).InsertAdditionalBillItems(pDueChart, pType, out InterimBillNo);

            List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
            decimal dAdvanceAmount = 0;

            new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, pType, out dAdvanceAmount, out lstadvancepaidDetails);
            if (lstDueChart.Count > 0)
            {
                gvIndents.DataSource = lstDueChart;
                gvIndents.DataBind();
                gridAttributesAdd();
                txtRecievedAdvance.Text = dAdvanceAmount.ToString();
            }
            txtDesc.Text = "";
            txtAmt.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BillCollect", ex);
        }
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }
}
