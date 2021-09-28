using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.BillingEngine;
using System.Data;


public partial class Corporate_prescriptionStockReturn : BasePage
{
    long vid = -1;
    long FinalbillID = -1;
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();
    List<BillingDetails> lstTransAmountRefundDetails = new List<BillingDetails>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    SharedInventory_BL inventoryBL;
    FinalBill fBill = new FinalBill();
    long returnCode = -1;
    long PatientVisitID = -1;
    long PatientID = -1;
    string pNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);

        if (!IsPostBack)
        {
           

            //Int64.TryParse(Request.QueryString["Bid"], out FinalbillID);
            if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null && Request.QueryString["pNo"] != null)
            {
                PatientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                PatientID = Convert.ToInt64(Request.QueryString["pid"]);
                pNo = Request.QueryString["pNo"];
            }
            hdnVid.Value = Convert.ToString(PatientVisitID);
            loadPrescriptionBillingdetail(FinalbillID);
        }

    }

    public void loadPrescriptionBillingdetail(long FinalbillID)
    {
        try
        {
            string physicianName = string.Empty;

            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();

            List<Patient> lstPatient = new List<Patient>();
            List<Physician> lstPhysician = new List<Physician>();
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<InventoryItemsBasket> lstInventoryBillingdetails = new List<InventoryItemsBasket>();


           // inventoryBL.GetPrescriptionBillingDetails(OrgID, ILocationID, PatientVisitID, FinalbillID, PatientID, pNo, InventoryLocationID, out lstPatient, out lstPhysician, out lstInventoryBillingdetails);
            

            if (lstPatient.Count() > 0)
            {
                lblPNumber.Text = ":" + lstPatient[0].PatientNumber;
                lblPname.Text = ":" + lstPatient[0].TitleName + lstPatient[0].Name;
                if (lstPatient[0].SEX == "M")
                {
                    lblGender.Text = ":" + "Male";
                }
                else
                {
                    lblGender.Text = ":" + "Female";
                }
                lblAge.Text = ":" + lstPatient[0].Age;
                lblVoucherDtae.Text = ":" + lstPatient[0].DOB.ToString();
                if (lstPhysician.Count > 0)
                    lblDoctorname.Text = ":" + lstPhysician[0].PhysicianName;
            }

            if (lstInventoryBillingdetails.Count() > 0)
            {
                lblVoucherno.Text = ":"+lstInventoryBillingdetails[0].PrescriptionNO.ToString();

            }
            if (lstInventoryBillingdetails.Count > 0 )
            {

                gvBillingDetail.DataSource = lstInventoryBillingdetails;
                gvBillingDetail.DataBind();
                trtotalamt.Visible = true;
            }
            else
            {
                lblResult.Text = "";
                lblResult.Text  = "There is no Bill Items for this Patient";
                btnRefund.Visible = false;
                btnRefund.Enabled = false;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for BillingDetails", ex);
        }
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
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }


    protected void gvBillingDetail_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                TextBox txtReturnQuantity = new TextBox();
                HiddenField hdnIssuedQuantity = new HiddenField();
                HiddenField hdnIssuedAmount = new HiddenField();
                TextBox txtRefundAmount = new TextBox();
                TextBox txtReason = new TextBox();
                txtReturnQuantity = (TextBox)e.Row.FindControl("txtReturnQuantity");
                hdnIssuedQuantity = (HiddenField)e.Row.FindControl("hdnIssuedQuantity");
                hdnIssuedAmount = (HiddenField)e.Row.FindControl("hdnRate");
                txtRefundAmount = (TextBox)e.Row.FindControl("txtRefundAmount");
                txtReason = (TextBox)e.Row.FindControl("txtReason");
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");

                txtRefundAmount.Attributes.Add("readonly", "true");
                string sFunQty = "funcChkAmountQty('" + hdnIssuedQuantity.ClientID +
                                                   "','" + hdnIssuedAmount.ClientID +
                                                   "','" + txtReturnQuantity.ClientID +
                                                   "','" + txtRefundAmount.ClientID + "');";
                string sFun = "funcChkAmount('" + hdnIssuedQuantity.ClientID +
                                                 "','" + hdnIssuedAmount.ClientID +
                                                 "','" + txtReturnQuantity.ClientID +
                                                 "','" + txtRefundAmount.ClientID + "');";

                string sRetAllQty = "funcReturnAllQty('" + chkSelect.ClientID +
                                                 "','" + hdnIssuedQuantity.ClientID +
                                                 "','" + hdnIssuedAmount.ClientID +
                                                 "','" + txtReturnQuantity.ClientID +
                                                 "','" + txtRefundAmount.ClientID + "');";


                Label lblReturnQty = (Label)e.Row.FindControl("lblReturnQuantity");
                Label lblReason = (Label)e.Row.FindControl("lblReason");
                Label lblRefundAmt = (Label)e.Row.FindControl("lblRefundAmt");
                decimal rqty = Convert.ToDecimal(lblReturnQty.Text);

                if (rqty > 0)
                {
                    txtReturnQuantity.Text = lblReturnQty.Text;
                    chkSelect.Checked = true;
                    txtReason.Text = lblReason.Text;
                    txtRefundAmount.Text = lblRefundAmt.Text;
                    txtTotalRefundAmount.Text = (Convert.ToDecimal(txtTotalRefundAmount.Text) + Convert.ToDecimal(lblRefundAmt.Text)).ToString("0.00");


                }
                if (Request.QueryString["IsPay"] == "Y")
                {
                    txtReturnQuantity.Enabled = false;
                    txtReason.Enabled = false;
                    chkSelect.Enabled = false;
                }

                txtReturnQuantity.Attributes.Add("onBlur", sFunQty);
                txtRefundAmount.Attributes.Add("onBlur", sFun);
                chkSelect.Attributes.Add("onclick", sRetAllQty);
                hdnValues.Value += hdnIssuedQuantity.ClientID + "~" + hdnIssuedAmount.ClientID + "~"
                    + txtReturnQuantity.ClientID + "~" + txtRefundAmount.ClientID + "~" + chkSelect.ClientID + "^";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }


    protected void btnRefund_Click(object sender, EventArgs e)
    {
        btnRefund.Visible = false;
        int flag = 0;
        string sError = string.Empty;
        btnRefund.Enabled = false;
        long returncode = -1;
        string refundNo = string.Empty;
        vid = Convert.ToInt64(hdnVid.Value);
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        try
        {

            foreach (GridViewRow gR in gvBillingDetail.Rows)
            {
                InventoryItemsBasket objINV = new InventoryItemsBasket();
                Label lblDescription = (Label)gR.FindControl("lblDescription");
                Label lblBatch = (Label)gR.FindControl("lblBatch");



                TextBox txtReturnQuantity = (TextBox)gR.FindControl("txtReturnQuantity");
                TextBox txtRefundAmount = (TextBox)gR.FindControl("txtRefundAmount");
                TextBox txtRReason = (TextBox)gR.FindControl("txtReason");
                HiddenField hdnBillingDetailsID = (HiddenField)gR.FindControl("hdnBillingDetailsID");
                HiddenField hdnFinalBillID = (HiddenField)gR.FindControl("hdnFinalBillID");
                HiddenField hdnFeeId = (HiddenField)gR.FindControl("hdnFeeId");
                HiddenField hdnIssuedAmount = (HiddenField)gR.FindControl("hdnIssuedAmount");
                HiddenField hdnRate = (HiddenField)gR.FindControl("hdnRate");
                HiddenField hfnStockOutFlowID = (HiddenField)gR.FindControl("hfnStockOutFlowID");
                HiddenField hdnIssuedQuantity = (HiddenField)gR.FindControl("hdnIssuedQuantity");
                HiddenField hdnpUnitPrice = (HiddenField)gR.FindControl("hdnUnitPrice");
                HiddenField hdnpSellingUnit = (HiddenField)gR.FindControl("hdnSellingUnit");
                HiddenField hdnphdnExpiryDate = (HiddenField)gR.FindControl("hdnExpiryDate");
                HiddenField hdnpSellingPrice = (HiddenField)gR.FindControl("hdnSellingPrice");
                HiddenField hdnpProductKey = (HiddenField)gR.FindControl("hdnProductKey");
                HiddenField hdnpLocationID = (HiddenField)gR.FindControl("hdnLocationID");
                HiddenField hdnpPrescriptionNo = (HiddenField)gR.FindControl("hdnPrescriptionNo");


                if (txtReturnQuantity.Text != "" && txtReturnQuantity.Text != "0.00" && txtReturnQuantity.Text != "0")
                {
                    long bdid = Convert.ToInt64(hdnBillingDetailsID.Value);
                    long fbid = Convert.ToInt64(hdnFinalBillID.Value);
                    decimal totAmt = Convert.ToDecimal(hdnRate.Value);
                    decimal totRfdAmt = Convert.ToDecimal(txtRefundAmount.Text);
                    string rReason = txtRReason.Text;
                    decimal amt = Convert.ToDecimal(txtRefundAmount.Text == "" ? "0" : txtRefundAmount.Text);
                  
                    decimal Qty = Convert.ToDecimal(hdnIssuedQuantity.Value) - Convert.ToDecimal(txtReturnQuantity.Text);
                    if (Convert.ToDecimal(txtReturnQuantity.Text) > 0 && Convert.ToDecimal(hdnIssuedQuantity.Value) > 0)
                    {

                        objINV.ProductID = Convert.ToInt64(hdnFeeId.Value);
                        objINV.BatchNo = lblBatch.Text;
                        objINV.Quantity = Qty;
                        objINV.ID = Convert.ToInt64(hfnStockOutFlowID.Value);//StockoutFlowDetailID
                        objINV.CategoryID = int.Parse(hdnFinalBillID.Value);//FinalBillID
                        objINV.RECQuantity = Convert.ToDecimal(txtReturnQuantity.Text);
                        objINV.ExpiryDate = Convert.ToDateTime(hdnphdnExpiryDate.Value);
                        objINV.Manufacture = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                        objINV.Rate = Convert.ToDecimal(hdnpSellingPrice.Value);
                        objINV.UnitPrice = Convert.ToDecimal(hdnpUnitPrice.Value);
                        objINV.SellingUnit = hdnpSellingUnit.Value;
                        objINV.ProductKey = hdnpProductKey.Value;
                        objINV.UsageCount  = Convert.ToInt16(hdnpLocationID.Value);//LocationID
                        objINV.Providedby = Convert.ToInt64(hdnBillingDetailsID.Value);//BillingDetailID
                        objINV.PrescriptionNO = hdnpPrescriptionNo.Value;
                        objINV.Remarks = txtRReason.Text;
                        objINV.Type = "PRESCRIPTION";
                        lstInventoryItemsBasket.Add(objINV);
                          
                        flag++;

                    }
                }
            }

            if (flag > 0)
            {

                if (Request.QueryString["vid"] != null && Request.QueryString["pid"] != null && Request.QueryString["pNo"] != null)
                {
                    PatientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                    PatientID = Convert.ToInt64(Request.QueryString["pid"]);
                    pNo = Request.QueryString["pNo"];
                }
              //  returncode = inventoryBL.UpdatePrescriptionStockReturn(OrgID, ILocationID, LID, lstInventoryItemsBasket, PatientVisitID, PatientID, pNo, InventoryLocationID, out refundNo);

                if (Convert.ToInt32(refundNo) > 0)
                {
                    Response.Redirect("RefundVoucher.aspx?pBid=" + refundNo + "&vid=" + vid, true);
                    
                }
                else
                {
                    lblResult.Visible = true;
                    lblResult.Text = "";
                    lblResult.Text = "Amount Has Not Been Refunded";
                }
            }
            else
            {
                lblResult.Visible = true;
                lblResult.Text = "";
                lblResult.Text = "Please Select atleast one Bill Item";
                btnRefund.Visible = true ;
                btnRefund.Enabled = true;
            }

            if (returncode == 0)
            {
                Int64.TryParse(Request.QueryString["Bid"], out FinalbillID);
                loadPrescriptionBillingdetail(FinalbillID);
            }
            else
            {
                btnRefund.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }


  
       
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        List<Role> lstUserRole = new List<Role>();
        string path = string.Empty;
        Role role = new Role();
        role.RoleID = RoleID;
        lstUserRole.Add(role);
        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
        Response.Redirect(Request.ApplicationPath + path, true);
    }
}
