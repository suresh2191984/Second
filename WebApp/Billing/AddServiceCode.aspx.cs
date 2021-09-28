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
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;

public partial class Billing_AddServiceCode : BasePage
{
    public Billing_AddServiceCode()
        : base("Billing\\AddServiceCode.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long BillID = 0, billingDetailsID = 0, returnCode = -1, patientID = -1, vid = 0;
    decimal amtReceived = 0, amtRefunded = 0, dChequeAmount = 0;
    List<BillingDetails> lstBillingDetails;
    BillingEngine billingBL;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadBillingDetails();
        }
    }

    protected void grdRefund_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdRefund.PageIndex = e.NewPageIndex;
            loadBillingDetails();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        lstBillingDetails = new List<BillingDetails>(); billingBL = new BillingEngine();
        foreach (GridViewRow gR in grdRefund.Rows)
        {
            BillingDetails bd = new BillingDetails();
            Label lbBillDetailID = (Label)gR.FindControl("lblBillDetailsID");
            Label lbFinalBillID = (Label)gR.FindControl("lblFinalBillID");
            TextBox txtServiceCode = (TextBox)gR.FindControl("txtServiceCode");
            TextBox txtDisplayText = (TextBox)gR.FindControl("txtDisplayText");
            long bdid = Convert.ToInt64(lbBillDetailID.Text);
            long fbid = Convert.ToInt64(lbFinalBillID.Text);
            bd.FinalBillID = fbid;
            bd.BillingDetailsID = bdid;
            bd.ServiceCode = txtServiceCode.Text;
            bd.FeeDescription = txtDisplayText.Text;
            lstBillingDetails.Add(bd);


        }
        returnCode = billingBL.UpdateServiceCodeForBill(lstBillingDetails);
        if (returnCode >= 0)
        {
            ScriptManager.RegisterStartupScript(Page, GetType(), "alert", "alert('Service code saved')", true);
        }
        Int64.TryParse(Request.QueryString["bid"], out BillID); Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        Int64.TryParse(Request.QueryString["vid"], out vid);
        string pagename = string.Empty;
        pagename = "?vid=" + vid + "&pagetype=BP&bid=" + BillID + "";
        Response.Redirect("../Reception/ViewPrintPage.aspx" + pagename);
    }
    public void loadBillingDetails()
    {

        lstBillingDetails = new List<BillingDetails>();
        billingBL = new BillingEngine();
        Int64.TryParse(Request.QueryString["bid"], out BillID); Int64.TryParse(Request.QueryString["bdid"], out billingDetailsID);
        Int64.TryParse(Request.QueryString["vid"], out vid);
        billingBL.pGetRefundBillingDetails(vid, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, BillID, billingDetailsID);
        if (lstBillingDetails.Count > 0)
        {
            grdRefund.DataSource = lstBillingDetails;
            grdRefund.DataBind();

        }
        else
        {
            lblResult.Visible = true;
            lblResult.Text = "Bill is yet to be generated";
            btnCancel.Visible = true;
            btnSave.Enabled = false;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Billing/HospitalBillSearch.aspx", true);
    }
}
