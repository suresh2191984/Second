using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;

public partial class Admin_CashFlow : BasePage
{
    public Admin_CashFlow()
        : base("Admin_CashFlow_aspx")
    {
    }
    string ddlSelect = Resources.Admin_AppMsg.Admin_drpSelect == null ? "----Select----" : Resources.Admin_AppMsg.Admin_drpSelect;
    protected void Page_Load(object sender, EventArgs e)
    {
        string patientName = string.Empty;
        try
        {
            if (!IsPostBack)
            {
                lblMsg.Text = string.Empty;
                AutoCompleteExtenderRefPhy.ContextKey = "RPH"; 
                divDetails.Style.Add("display", "none");
                divSave.Style.Add("display", "none");
                divPayment.Style.Add("display", "none");
                divFTDate.Style.Add("display", "none");
                divPhySettlement.Style.Add("display", "none");
                Panel2.Style.Add("display", "none");
                divSupplierFTDate.Style.Add("display", "none");

                Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
                List<Physician> lstPhysician = new List<Physician>();
                PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
                LoadCashExpense();
                LoadPhysicians(lstPhysician);
                loadDoctorsReffered();
                LoadSuppliers();
                txtFromDate.Text = OrgTimeZone;
                txtToDate.Text = OrgTimeZone;
                txtSupFTD.Text = OrgTimeZone;
                txtSupTFD.Text = OrgTimeZone;
                hdndPurpose.Value = string.Empty;
            }
            else
            {
                dPurpose.Items.FindByValue(hdndPurpose.Value).Selected = true;
            }
            hdnValues.Value = "";
        }
        catch (Exception ex1)
        {
            CLogger.LogError("An error occured while trying to load visit entry page", ex1);
        }
    }

    private void LoadSuppliers()
    {
        try
        {
            List<Suppliers> lstSuppliers = new List<Suppliers>();
            new SharedInventory_BL(base.ContextInfo).GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            if (lstSuppliers.Count > 0)
            {
                ddlSuppliers.DataSource = lstSuppliers;
                ddlSuppliers.DataTextField = "SupplierName";
                ddlSuppliers.DataValueField = "SupplierID";
                ddlSuppliers.DataBind();
                ddlSuppliers.Items.Insert(0, ddlSelect);
                ddlSuppliers.Items[0].Value = "0";
            }
        }
        catch (Exception ex1)
        {
            CLogger.LogError("An error occured while trying to load Suppliers", ex1);
        }
    }

    public void LoadCashExpense()
    {
        Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
        List<CashExpenseMaster> lstCashExpense = new List<CashExpenseMaster>();
        PhysicianBL.GetCashExpenseByOrg(OrgID, out lstCashExpense);


        if (lstCashExpense.Count > 0)
        {
            dPurpose.DataSource = lstCashExpense;
            dPurpose.DataTextField = "HeadName";
            dPurpose.DataValueField = "HeadDesc";
            dPurpose.DataBind();
            dPurpose.Items.Insert(0, ddlSelect);
            dPurpose.Items[0].Value = "0";
        }
    }
    
    public void LoadPhysicians(List<Physician> phySch)
    {

        if (phySch.Count > 0)
        {
            var lstphy = (from phy in phySch select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
            ddlDrName.DataSource = lstphy;
            ddlDrName.DataTextField = "PhysicianName";
            ddlDrName.DataValueField = "PhysicianID";
            ddlDrName.DataBind();
            ddlDrName.Items.Insert(0, ddlSelect);
            ddlDrName.Items[0].Value = "0";
        }
    }

    protected void bsave_Click(object sender, EventArgs e)
    {
        int ReceiverID = 0;
        string ReceiverName = "";
        string ReceiverType = "";
        decimal AmountReceived = 0;
        decimal Due = 0;
        decimal Surplus = 0;

        decimal payableAmt = 0;

        DateTime DateFrom = DateTime.MaxValue;
        DateTime DateTo = DateTime.MaxValue;
        string Remarks = "";
        string sPaymentType = "";
        string status = Resources.Admin_ClientDisplay.Admin_CashFlow_aspx_001 == null ? "Open" : Resources.Admin_ClientDisplay.Admin_CashFlow_aspx_001;//"Open";
        CashOutFlow objCashoutFlow = new CashOutFlow();

        try
        {
            ReceiverType = dPurpose.SelectedValue.ToString();
            if (ReceiverType == "PHY")
            {
                if (ddlDrName.SelectedItem != null)
                {
                    ReceiverName = ddlDrName.SelectedItem.Text;
                    Int32.TryParse(ddlDrName.SelectedValue.ToString(), out ReceiverID);
                }
				else{
				    ReceiverName = txtNew.Text;
				}
            }
            else if (ReceiverType == "OTH")
            {
                ReceiverName = txtOthers.Text;
                ReceiverID = 0;
            }
            else if (ReceiverType == "SUP")
            {
                ReceiverID = int.Parse(ddlSuppliers.SelectedValue);
                ReceiverName = ddlSuppliers.SelectedItem.Text;

                lblPayableAmount.Text = GetPayableAmount().ToString();
            }
            else
            {
                ReceiverName = dPurpose.SelectedItem.Text;

            }

            decimal.TryParse(hdnPayable.Value.ToString().Trim(), out AmountReceived);
            decimal.TryParse(txtPreviousSurplus.Text.Trim(), out Surplus);
            decimal.TryParse(hdfPayableAmount.Value.ToString(), out payableAmt);
            payableAmt = payableAmt == 0 ? AmountReceived : payableAmt;

            Surplus = AmountReceived - payableAmt;

            if (Surplus < 0)
            {
                Due = -(Surplus);
                Surplus = 0;
            }

            Remarks = txtRemarks.Text;

            DateFrom = Convert.ToDateTime(txtFromDate.Text);
            DateTo = Convert.ToDateTime(txtToDate.Text);

            if (rdoOfficial.Checked == true)
            {
                sPaymentType = "OFF";
                //Official Payments
            }
            if (rdoPersonal.Checked == true)
            {
                sPaymentType = "PER";
                //personal payments
            }

            long retval = -1;

            long OutFlowID = 0;
            string VoucherNO = "";
            System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
            dtAdvancePaidDetails = PaymentTypeDetails1.GetAmountReceivedDetails();
            decimal dserviceCharge = 0;
            decimal.TryParse(txtServiceCharge.Text.Trim(), out dserviceCharge);
            List<CashFlowTransactions> lstCashFlowTransactions = new List<CashFlowTransactions>();
            if (ReceiverType == "SUP")
            {
                lstCashFlowTransactions = GetCashFlowTransactionsDetails();
            }

            if (ReceiverType == "PHY")
            {
                decimal TDSAmount = decimal.Zero;
                objCashoutFlow.TotalAmount = txtTotalAmount.Text == "" ? 0 : Convert.ToDecimal(txtTotalAmount.Text);
                objCashoutFlow.OrgAmount = txtOrgAmount.Text == "" ? 0 : Convert.ToDecimal(txtOrgAmount.Text);
                objCashoutFlow.AmtBeforeTDS = objCashoutFlow.TotalAmount - objCashoutFlow.OrgAmount;
                objCashoutFlow.TDSPercent = lblOPTax.Text == "" ? 0 : Convert.ToDecimal(lblOPTax.Text);
                TDSAmount = txtIPTax.Text == "" ? 0 : Convert.ToDecimal(txtIPTax.Text);
                TDSAmount += txtOPTax.Text == "" ? 0 : Convert.ToDecimal(txtOPTax.Text);
                objCashoutFlow.TDSAmount = TDSAmount;
                objCashoutFlow.TermPayableAmount = txtCommisiontoPhysician.Text == "" ? 0 : Convert.ToDecimal(txtCommisiontoPhysician.Text);
                objCashoutFlow.PreviousDue = txtPreviousDue.Text == "" ? 0 : Convert.ToDecimal(txtPreviousDue.Text);
                objCashoutFlow.TotalPayable = objCashoutFlow.TermPayableAmount + objCashoutFlow.PreviousDue;
                objCashoutFlow.TotalPaid = AmountReceived;
                objCashoutFlow.TermPayment = (objCashoutFlow.TermPayableAmount - AmountReceived) > 0 ? AmountReceived : (objCashoutFlow.TermPayableAmount - AmountReceived);
                //objCashoutFlow.DueSettled = (objCashoutFlow.PreviousDue - (objCashoutFlow.TotalPaid - objCashoutFlow.TermPayment)) == 0 ? objCashoutFlow.PreviousDue : objCashoutFlow.TotalPaid - objCashoutFlow.TermPayment;
                objCashoutFlow.DueSettled = (objCashoutFlow.PreviousDue - (objCashoutFlow.TotalPaid - objCashoutFlow.TermPayment)) == 0 ? objCashoutFlow.PreviousDue : (objCashoutFlow.TotalPaid - objCashoutFlow.TermPayment) < 0 ? 0 : (objCashoutFlow.TotalPaid - objCashoutFlow.TermPayment);
                if (lblAmtPayedSoFar.Text == "" )
                {
                    lblAmtPayedSoFar.Text = "0";   
                }
                objCashoutFlow.TermDue = objCashoutFlow.TermPayableAmount - objCashoutFlow.TermPayment - Convert.ToDecimal(lblAmtPayedSoFar.Text);
                objCashoutFlow.TotalDue = objCashoutFlow.TermDue + (objCashoutFlow.PreviousDue - objCashoutFlow.DueSettled);

            }

            retval = new BillingEngine(base.ContextInfo).InsertCashFlow(ReceiverID, ReceiverName, ReceiverType, sPaymentType,
                AmountReceived, Due, Surplus, DateFrom, DateTo, Remarks, status, Convert.ToInt32(LID), OrgID,
                dtAdvancePaidDetails, dserviceCharge, out VoucherNO, out OutFlowID, lstCashFlowTransactions, objCashoutFlow, ILocationID);

            if (ReceiverType == "SUP")
            {
                hdnValues.Value = "";
                List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
                lstInventoryItemsBasket = GetReceivedItems();
              //  retval = new Inventory_BL(base.ContextInfo).UpdateReceivedInventoryApproval("Payment", lstInventoryItemsBasket, 0, "", LID, OrgID, ILocationID);
               
            }
            ClearDatas1();

            //string skey = "PrintVoucherPage.aspx?Amount="
            //                + AmountReceived.ToString() + "&dDate="
            //                + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
            //                + "&OID=" + OutFlowID.ToString()
            //                + "&VONO=" + VoucherNO.ToString()
            //                + "&RNAME=" + ReceiverName + "";
            string skey = "PrintVoucherPage.aspx?OID=" + OutFlowID.ToString()
                            + "&VONO=" + VoucherNO.ToString();
                            

            this.Page.RegisterStartupScript("sky",
              "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
            string DispText = Resources.Admin_ClientDisplay.Admin_CashFlow_aspx_002 == null ? "Successfully Saved" : Resources.Admin_ClientDisplay.Admin_CashFlow_aspx_002;
            lblMsg.Text = DispText;//"Successfully Saved";
            gvPreviousPayments.Visible = false;
            btnSupSearch_Click(this, e);
        }
        catch (Exception ex1)
        {
            CLogger.LogError("Error occured while saving cash outflow.", ex1);

            // Show error div
           // ulErrorDiv.Style.Add("display", "block");
            //divError.ShowError = true;
           // divError.Status = "Error saving cash outflow data. Pl. try later or report to Admin";

            bsave.Visible = true;
        }
        
    }

    private List<CashFlowTransactions> GetCashFlowTransactionsDetails()
    {
        List<CashFlowTransactions> lstCashFlowTransactions = new List<CashFlowTransactions>();
        foreach (GridViewRow row in grdResult.Rows)
        {
            CashFlowTransactions newBasket = new CashFlowTransactions();
            TextBox txtSupAmount = (TextBox)row.FindControl("txtSupAmount");
            CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
            HiddenField hdnStockReceivedID = (HiddenField)row.FindControl("hdnStockReceivedID");
            HiddenField hdnInvoiceNo = (HiddenField)row.FindControl("hdnInvoiceNo");
            HiddenField hdnTotalAmt = (HiddenField)row.FindControl("hdnTotalAmt");
            if (chkSelect.Checked)
            {
                newBasket.ReferenceID = Int64.Parse(hdnStockReceivedID.Value);
                double AmyToPay = double.Parse(txtSupAmount.Text);
                newBasket.AmountPaid = decimal.Parse(txtSupAmount.Text);
                newBasket.ReferenceType = "PRM";
                newBasket.InvoiceNo = hdnInvoiceNo.Value;
                lstCashFlowTransactions.Add(newBasket);
            }
        }
        return lstCashFlowTransactions;
    }


   

    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        //
        lblMsg.Text = string.Empty;
        hdnValues.Value = "";
        if (dPurpose.SelectedValue.ToString() == "OTH")
        {
            ClearDatas1();
        }
        else
        {
            txtPayableAmount.Text = "0";
            hdfPayableAmount.Value = "0";
            txtServiceCharge.Text = "0";
            hdnServiceCharge.Value = "0";
            ((HiddenField)PaymentTypeDetails1.FindControl("hdfPaymentType")).Value = "";
            ((HiddenField)PaymentTypeDetails1.FindControl("hdnPaymentsDeleted")).Value = "";
           // this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
        

            List<CashFlowSummary> lstCashFlowSummary = new List<CashFlowSummary>();
            long lPhysicianID = 0;
            DateTime dfromDate = DateTime.MaxValue;
            DateTime toDate = DateTime.MaxValue;
            decimal dTotalDue = 0;
            decimal dTotalAdvance = 0;

            decimal dIPPercent = 0;
            decimal dOPPercent = 0;
            decimal dIPTax = 0;
            decimal dOPTax = 0;
            decimal dtotGivenAmt = 0;
            List<CashOutFlow> lstOutFlow = new List<CashOutFlow>();



            Int64.TryParse(ddlDrName.SelectedValue.ToString(), out lPhysicianID);

            dfromDate = Convert.ToDateTime(txtFromDate.Text);
            toDate = Convert.ToDateTime(txtToDate.Text);
            long retval = -1;
            retval = new BillingEngine(base.ContextInfo).GetCashFlow(OrgID, lPhysicianID, dfromDate, toDate,
                                                     out lstCashFlowSummary, out dTotalDue,
                                                     out dTotalAdvance, out dIPPercent, out dOPPercent,
                                                     out dIPTax, out dOPTax, out lstOutFlow, out dtotGivenAmt);

            if (lstCashFlowSummary.Count > 0)
            {
                gvConsultation.DataSource = lstCashFlowSummary;
                gvConsultation.DataBind();
                gvConsultation.Visible = true;
                
            }
            else
            {
                
                ClearDatas1();
                string HdrWin = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                string sPath = Resources.Admin_AppMsg.Admin_CashFlow_aspx_12 == null ? "There is no Payment for Consultation on Selected Date" : Resources.Admin_AppMsg.Admin_CashFlow_aspx_12;//"Admin\\\\CashFlow.aspx.cs_12";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "NoPids", "ShowAlertMsg('"+sPath+"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + sPath + "','" + HdrWin + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "NoPids", "javascript:alert('There is no Payment for Consultation on Selected Date');", true);
            }
            gvPreviousPayments.DataSource = lstOutFlow;
            gvPreviousPayments.DataBind();
            gvPreviousPayments.Visible = true;

            decimal dTemp = dTotalDue - dTotalAdvance;
            if (dTemp > 0)
            {
                dTotalDue = dTotalDue - dTotalAdvance;
            }
            else if (dTemp < 0)
            {
                dTotalAdvance = dTotalAdvance - dTotalDue;
            }
            else if (dTemp == 0)
            {
                dTotalAdvance = 0;
                dTotalDue = 0;
            }

            txtPreviousDue.Text = dTotalDue.ToString();
            txtPreviousSurplus.Text = dTotalAdvance.ToString();
            lblIPPercent.Text = dIPPercent.ToString();
            lblOPPercent.Text = dOPPercent.ToString();
            lblIPTax.Text = dIPTax.ToString();
            lblOPTax.Text = dOPTax.ToString();
            
            lblAmtPayedSoFar.Text = dtotGivenAmt.ToString("#.00");

            if (lstCashFlowSummary.Count > 0)
            {
                BindGridValues();
            }
            
            decimal orgAMT = Convert.ToDecimal(txtIPAmountToOrg.Text) + Convert.ToDecimal(txtOPAmountToOrg.Text);
            txtOrgAmount.Text = orgAMT.ToString();
            decimal comtoPhy = Convert.ToDecimal(txtIPPayable.Text) + Convert.ToDecimal(txtOPPayable.Text);
            txtCommisiontoPhysician.Text = comtoPhy.ToString();

            

        }
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "sKy", "funcChangeType();", true);
    }
    
    protected void gvConsultation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
    }

    protected void BindGridValues()
    {
        decimal totalAmount = 0;
        decimal amountToOrg = 0;
        decimal amountToPhy = 0;
        decimal tempAmt = 0;
        int i = 0;
        int iCount = 0;
        int iOPCount = 0;
        int iIPCount = 0;

        decimal IPAmount = 0;
        decimal OPAmount = 0;

        decimal ipPercent = 0;
        decimal opPercent = 0;
        decimal ipTax = 0;
        decimal opTax = 0;


        decimal.TryParse(lblIPPercent.Text, out ipPercent);
        decimal.TryParse(lblOPPercent.Text, out opPercent);
        decimal.TryParse(lblIPTax.Text, out ipTax);
        decimal.TryParse(lblOPTax.Text, out opTax);

        foreach (GridViewRow rows in gvConsultation.Rows)
        {
            tempAmt = 0;
            decimal.TryParse(rows.Cells[6].Text.ToString(), out tempAmt);
            totalAmount += tempAmt;

            if (rows.Cells[5].Text.ToString() == "IP")
            {
                iIPCount++;
                tempAmt = 0;
                decimal.TryParse(rows.Cells[6].Text.ToString(), out tempAmt);
                IPAmount += tempAmt;
            }
            if (rows.Cells[5].Text.ToString() == "OP")
            {
                iOPCount++;
                tempAmt = 0;
                decimal.TryParse(rows.Cells[6].Text.ToString(), out tempAmt);
                OPAmount += tempAmt;
            }

            i = 0;
            Int32.TryParse(rows.Cells[4].Text.ToString(), out i);
            iCount += i;

        }

        txtNoOfConsultations.Text = iCount.ToString();
        txtTotalAmount.Text = totalAmount.ToString();
        txtOrgAmount.Text = amountToOrg.ToString();
        txtCommisiontoPhysician.Text = amountToPhy.ToString();

        txtNoOfIPs.Text = iIPCount.ToString();
        txtNoOfOPs.Text = iOPCount.ToString();

        txtOPAmount.Text = OPAmount.ToString("#.00");
        txtIPAmount.Text = IPAmount.ToString("#.00");

        txtIPAmountToOrg.Text = Convert.ToString(IPAmount * ipPercent / 100);
        txtOPAmountToOrg.Text = Convert.ToString(OPAmount * opPercent / 100);

        //txtIPTax.Text = Convert.ToString(IPAmount * ipTax / 100);
        //txtOPTax.Text = Convert.ToString(OPAmount * opTax / 100);

        txtIPTax.Text = Convert.ToString((IPAmount - Convert.ToDecimal(txtIPAmountToOrg.Text)) * ipTax / 100);
        txtOPTax.Text = Convert.ToString((OPAmount - Convert.ToDecimal(txtOPAmountToOrg.Text)) * opTax / 100);

        //txtIPPayable.Text = Convert.ToString(IPAmount - (IPAmount * ipPercent / 100) - (IPAmount * ipTax / 100));
        //txtOPPayable.Text = Convert.ToString(OPAmount - (OPAmount * opPercent / 100) - (OPAmount * opTax / 100));

        txtIPPayable.Text = Convert.ToString(IPAmount - Convert.ToDecimal(txtIPAmountToOrg.Text) - Convert.ToDecimal(txtIPTax.Text));
        txtOPPayable.Text = Convert.ToString(OPAmount - Convert.ToDecimal(txtOPAmountToOrg.Text) - Convert.ToDecimal(txtOPTax.Text));



        amountToPhy = Convert.ToDecimal(txtIPPayable.Text) + Convert.ToDecimal(txtOPPayable.Text);

        //txtPayableAmount.Text = Convert.ToString(amountToPhy + Convert.ToDecimal(txtPreviousDue.Text)- Convert.ToDecimal(txtPreviousSurplus.Text));
        lblPayableAmount.Text = Convert.ToString((amountToPhy + Convert.ToDecimal(txtPreviousDue.Text)) - Convert.ToDecimal(txtPreviousSurplus.Text) - Convert.ToDecimal(lblAmtPayedSoFar.Text));

        hdfPayableAmount.Value = txtPayableAmount.Text;
    }

    private void loadDoctorsReffered()
    {
        //to get Doctors list
        PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        long returnCode = -1;
        returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysician);
        if (lstPhysician.Count > 0)
        {
            ddlReferDoctor.DataSource = lstPhysician;
            ddlReferDoctor.DataTextField = "PhysicianName";
            ddlReferDoctor.DataValueField = "OrgID";
            ddlReferDoctor.DataBind();
        }
    }

    private void ClearDatas1()
    {
        txtCommisiontoPhysician.Text = "";
        txtFromDate.Text = OrgTimeZone;
        txtToDate.Text = OrgTimeZone;

        txtTotalAmount.Text = "0";
        txtPreviousDue.Text = "0";
        txtPreviousSurplus.Text = "0";
        txtNoOfConsultations.Text = "0";
        txtOrgAmount.Text = "0";
        txtCommisiontoPhysician.Text = "0";
        txtPayableAmount.Text = "0";
        hdnPayable.Value = "0";
        lblPayableAmount.Text = "0";
        hdfPayableAmount.Value = "0";
        txtRemarks.Text = "";

        txtNoOfIPs.Text = "0";
        txtNoOfOPs.Text = "0";

        txtOPAmount.Text = "0";
        txtIPAmount.Text = "0";

        txtIPAmountToOrg.Text = "0";
        txtOPAmountToOrg.Text = "0";

        txtIPTax.Text = "0";
        txtOPTax.Text = "0";

        txtIPPayable.Text = "0";
        txtOPPayable.Text = "0";

        lblIPPercent.Text = "0";
        lblOPPercent.Text = "0";

        lblIPTax.Text = "0";
        lblOPTax.Text = "0";

        rdoOfficial.Checked = true;
        gvConsultation.Visible = false;

        txtOthers.Text = "";
        txtPayableAmount.Text = "0";
        hdfPayableAmount.Value = "0";
        txtServiceCharge.Text = "0";
        hdnServiceCharge.Value = "0";
        ((HiddenField)PaymentTypeDetails1.FindControl("hdfPaymentType")).Value = "";
        ((HiddenField)PaymentTypeDetails1.FindControl("hdnPaymentsDeleted")).Value = "";
        //this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
        
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        //try
        //{
        //    Response.Redirect("Home.aspx", true);
        //}

        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error while executing GetWeek()", ex);
        //}
    }

    protected void btnSupSearch_Click(object sender, EventArgs e)
    {
        List<StockReceived> lstStockReceived = new List<StockReceived>();
        try
        {
            string Fromdate = txtSupFTD.Text == "" ? "01/01/2001" : txtSupFTD.Text;
            string ToDate = txtSupTFD.Text == "" ? "01/01/2001" : txtSupTFD.Text;
            string InvoiceNo = txtInvoiceNo.Text == "" ? "0" : txtInvoiceNo.Text;
            string POno = txtPOno.Text == "" ? "0" : txtPOno.Text;
            new SharedInventory_BL(base.ContextInfo).GetSupplierInvoiceList(int.Parse(ddlSuppliers.SelectedValue), OrgID, ILocationID, Fromdate, ToDate, InvoiceNo, POno, out lstStockReceived);
            grdResult.DataSource = lstStockReceived;
            grdResult.DataBind();
            divSupplierFTDate.Style.Add("display", "block");
            divSupplier.Style.Add("display", "block");
            divPayment.Style.Add("display", "block");
            divSave.Style.Add("display", "block");
            trGrantTotal.Style.Add("display", "block");
            hdndPurpose.Value = dPurpose.SelectedValue;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while Searching the Supplier Invoice No", ex);
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtSupAmount = (TextBox)e.Row.FindControl("txtSupAmount");
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            HiddenField hdnTotalAmt = (HiddenField)e.Row.FindControl("hdnTotalAmt");

            string strScript = "SelectCheckCommon('" + chkSelect.ClientID + "','" + txtSupAmount.ClientID + "');";
            string str = "CheckCommon('" + chkSelect.ClientID + "','" + txtSupAmount.ClientID + "','" + hdnTotalAmt.Value + "');";
            chkSelect.Attributes.Add("onclick", strScript);
            //chkSelect.Attributes.Add("disabled", "true");
            hdnValues.Value += chkSelect.ClientID + "~" + txtSupAmount.ClientID + "^";
            txtSupAmount.Attributes.Add("onBlur", str);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
    }
    private decimal GetPayableAmount()
    {
        decimal total = 0;
        foreach (GridViewRow gr in grdResult.Rows)
        {
            TextBox txtSupAmount = (TextBox)gr.FindControl("txtSupAmount");
            CheckBox chkSelect = (CheckBox)gr.FindControl("chkSelect");
            if (chkSelect.Checked)
            {
                total += decimal.Parse(txtSupAmount.Text);
            }
        }
        return total;
    }

    public List<InventoryItemsBasket> GetReceivedItems()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket newBasket = new InventoryItemsBasket();
            TextBox txtSupAmount = (TextBox)row.FindControl("txtSupAmount");
            CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
            HiddenField hdnStockReceivedID=(HiddenField)row.FindControl("hdnStockReceivedID");
            HiddenField  hdnTotalAmt  = (HiddenField)row.FindControl("hdnTotalAmt");
            if (chkSelect.Checked)
            {
                newBasket.ID = Int64.Parse(hdnStockReceivedID.Value);
                double AmyToPay = double.Parse(txtSupAmount.Text);
                double TotalAmt = double.Parse(hdnTotalAmt.Value);
                newBasket.Amount= decimal.Parse(txtSupAmount.Text);
                if (AmyToPay >= TotalAmt)
                {
                    newBasket.Description = "PAID";
                }
                else
                {
                    newBasket.Description = "PARTLY PAID";
                }
                newBasket.ExpiryDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                newBasket.Manufacture = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }





    
}
