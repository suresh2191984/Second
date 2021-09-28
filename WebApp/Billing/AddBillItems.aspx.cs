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

public partial class Billing_AddbIllItems : BasePage
{
    public Billing_AddbIllItems()
        : base("Billing\\AddBillItems.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long patientID = -1;
    long patientVisitID = -1;
    long returnCode = -1;
    long taskID = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<StandardDeduction> lstStdDeduction = new List<StandardDeduction>();
    List<FinalBill> lstFinalBill = new List<FinalBill>();
    //Patient_BL pbl = new Patient_BL(base.ContextInfo);
    string PaymentLogic = String.Empty;
    string sAddBI = string.Empty;
    string patientType = string.Empty;
    long FinalID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        sAddBI = Convert.ToString(Request.QueryString["pagetype"]);
        if (sAddBI != null && sAddBI.Equals("ABI"))
        {
            txtDiscount.Enabled = false;
        }
        //if (AddBI == "ABI")
        //{
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetFinalBillID(patientID, patientVisitID, out FinalID);

        if (!Page.IsPostBack)
        {
            LoadTaxMaster();

            btnSave.Enabled = true;

            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

            PatientHeader.PatientID = patientID;
            PatientHeader.PatientVisitID = patientVisitID;

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
            //}
            Physician_BL ObjPhysician = new Physician_BL(base.ContextInfo);
            List<Physician> physicianList = new List<Physician>();

            ObjPhysician.GetPhysicianListByOrg(OrgID, out physicianList, Convert.ToInt32(patientVisitID));
            var PhysicianVis = from pVis in physicianList where (pVis.PhysicianType == "VIS") select pVis;
            ddlPhysicianVis.DataSource = PhysicianVis;

            ddlPhysicianVis.DataTextField = "PhysicianName";
            ddlPhysicianVis.DataValueField = "Amount";
            ddlPhysicianVis.DataBind();


            ddlPhysicianVis.Items.Insert(ddlPhysicianVis.Items.Count, new ListItem("Others", "-2"));

            txtDue.Text = String.Format("{0:0.00}", dueAmount);
            hdnGross.Value = hdnGross.Value == "" ? "0" : hdnGross.Value;

            txtGrossAmount.Text = String.Format("{0:0.00}", Convert.ToDouble(hdnGross.Value.ToString()) - (Convert.ToDouble(txtSubDeduction.Text) + Convert.ToDouble(txtDiscount.Text)));
            txtGrandTotal.Text = String.Format("{0:0.00}", Convert.ToDouble(txtGrossAmount.Text) + Convert.ToDouble(txtDue.Text));
            txtAmountRecieved.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());
            // Assign the text box value in hidden field
            hdnGrossAmount.Value = txtGrossAmount.Text;
            hdnGrandTotal.Value = txtGrandTotal.Text;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Enabled = false;
        try
        {
            txtAmountRecieved.Text = hdnAmountReceived.Value == null ? "0" : hdnAmountReceived.Value.ToString();
            txtRecievedAmount.Text = txtRecievedAmount.Text == "" ? "0" : txtRecievedAmount.Text;
            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
            //------------------------------------------------------------------------------------------------------------------------
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
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
            //finalBill.FinalBillID = FinalBillID;
            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.PatientID = patientID;
            finalBill.StdDedID = Convert.ToInt64(hdnStdDedID.Value);
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            finalBill.GrossBillValue = Convert.ToDecimal(hdnGross.Value.ToString());
            finalBill.NetValue = Convert.ToDecimal(hdnGrossAmount.Value) + dServiceCharge;
            finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text) + Convert.ToDecimal(txtRecievedAmount.Text);

            AmountReceivedDetails amtRD = new AmountReceivedDetails();

            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();

            amtRD.AmtReceived = Convert.ToDecimal(txtAmountRecieved.Text);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;

            finalBill.CurrentDue = finalBill.NetValue + Convert.ToDecimal(txtDue.Text.ToString())
                                       - finalBill.AmountReceived;
            //finalBill.CurrentDue = (Convert.ToDecimal(hdnGross.Value.ToString())
            //                        + Convert.ToDecimal(txtDue.Text))
            //                        - (Convert.ToDecimal(txtAmountRecieved.Text)
            //                            + Convert.ToDecimal(txtDiscount.Text));

            if (txtAmountRecieved.Text.Trim() == "0" || txtAmountRecieved.Text.Trim() == "")
            {
                finalBill.Due = Convert.ToDecimal(hdnGrossAmount.Value) - Convert.ToDecimal(txtDiscount.Text);
            }
            if (chkisCreditTransaction.Checked == true)
            {
                finalBill.Due = Convert.ToDecimal(hdnGrossAmount.Value);
                finalBill.IsCreditBill = "Y";
            }
            else
            {
                finalBill.IsCreditBill = "N";
            }

            finalBill.ModifiedBy = LID;

            if (PaymentLogic == String.Empty)
            {
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails(Request.QueryString["ftype"], OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    PaymentLogic = lstConfig[0].ConfigValue.Trim();
            }
            lstPatientDueChart = getPatientConsultationDetails();
        

            // save before collect payment 

            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["ptid"]), TaskHelper.TaskStatus.Pending, UID);
            returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
            long lReturnID = billingEngineBL.InsertFinalBillForDirect(finalBill, amtRD, dtAmountReceived, lstPatientDueChart, dServiceCharge);

            finalBill.FinalBillID = lReturnID;

            if (chkisCreditTransaction.Checked == false)
            {
                decimal recievedAmount = Convert.ToDecimal(txtAmountRecieved.Text);
                if (Convert.ToDouble(txtDue.Text) > 0 && Convert.ToDouble(txtAmountRecieved.Text) > 0)
                {
                    List<DuePaidDetail> lstPaidDueDetail = new List<DuePaidDetail>();
                    DuePaidDetail duePaidDetail;
                    long finalBillID = -1;

                    List<FinalBill> lstDueDetail = new List<FinalBill>();
                    billingEngineBL = new BillingEngine(base.ContextInfo);
                    string visittype = "";
                    billingEngineBL.GetDueDetails(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail,out visittype);

                    // If Amount Recieved equal to Grand Total then
                    if (Convert.ToDouble(txtAmountRecieved.Text) == Convert.ToDouble(txtGrandTotal.Text))
                    {
                        for (int i = 0; i < lstDueDetail.Count; i++)
                        {
                            duePaidDetail = new DuePaidDetail();
                            duePaidDetail.DueBillNo = lstDueDetail[i].FinalBillID;
                            duePaidDetail.BillAmount = lstDueDetail[i].NetValue;
                            duePaidDetail.PaidAmount = lstDueDetail[i].Due;
                            duePaidDetail.PaidBillNo = finalBillID;
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
                                duePaidDetail.PaidBillNo = finalBillID;
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
                                    duePaidDetail.PaidBillNo = finalBillID;
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
                List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
                List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();
                lstTax = getTaxDetails();
                if (recievedAmount > 0)
                {
                    AmountReceivedDetails amtRD1 = new AmountReceivedDetails();

                    amtRD1.AmtReceived = 0;
                    amtRD1.ReceivedBy = LID;
                    amtRD1.CreatedBy = LID;
                    decimal temp =  
                    (Convert.ToDecimal(hdnGross.Value.ToString())
                                    + Convert.ToDecimal(txtDue.Text))
                                    - Convert.ToDecimal(txtDiscount.Text);
                    if (temp > 0)
                    {
                        finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                                   - finalBill.DiscountAmount - recievedAmount;
                    }
                    else
                    {
                        finalBill.Due = 0;
                    }
                    dtAmountReceived.Clear();
                    
                    List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                    billingEngineBL.UpdateFinalBill(finalBill, amtRD1, dtAmountReceived, lstPatientDueChart, lstTax, dServiceCharge, lstVisitClientMapping, lstUsage);
                   // billingEngineBL.UpdateFinalBill(finalBill, amtRD1, dtAmountReceived, lstPatientDueChart,lstTax,dServiceCharge);
                }
                else
                {
                    AmountReceivedDetails amtRD2 = new AmountReceivedDetails();

                    amtRD2.AmtReceived = 0;
                    amtRD2.ReceivedBy = LID;
                    amtRD2.CreatedBy = LID;
                    //finalBill.AmountReceived = Convert.ToDecimal(txtRecievedAmount.Text) + recievedAmount;
                    finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount;
                    
                    List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                    billingEngineBL.UpdateFinalBill(finalBill, amtRD2, dtAmountReceived, lstPatientDueChart, lstTax, dServiceCharge, lstVisitClientMapping, lstUsage);

                   // billingEngineBL.UpdateFinalBill(finalBill, amtRD2, dtAmountReceived, lstPatientDueChart, lstTax,dServiceCharge);
                }
            }
            billingEngineBL.GetBillingDetails(OrgID, patientID, patientVisitID, out lstBillingDetails, out lstStdDeduction, FinalBillID);
            Response.Redirect("../Printing/BillPrinting.aspx?vid=" + patientVisitID + "&pid=" + patientID + "&tid=" + Convert.ToString(Request.QueryString["tid"]), true);
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
            Response.Redirect("../Reception/Home.aspx", true);
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
        objBD.FeeId = -2;
        objBD.FeeType = "OTH";
        objBD.CreatedBy = LID;
        objBD.ModifiedBy = 0;
        objBD.BillingDetailsID = -2;
        billingEngineBL.InsertMiscellaneousBills(objBD);

        List<FinalBill> lstDueDetail = new List<FinalBill>();

        long finalBillID = -1;
        string visittype = "";
        dueDetail.loadDueDetail(OrgID, patientID, patientVisitID, out finalBillID, out lstDueDetail,out visittype);
        double dueAmount = 0;
        for (int i = 0; i < lstDueDetail.Count; i++)
        {
            dueAmount += Convert.ToDouble(lstDueDetail[i].Due);
        }

        txtDue.Text = String.Format("{0:0.00}", dueAmount);

        txtGrossAmount.Text = String.Format("{0:0.00}", Convert.ToDouble(hdnGross.Value.ToString()) - (Convert.ToDouble(txtSubDeduction.Text) + Convert.ToDouble(txtDiscount.Text)));

        txtGrandTotal.Text = String.Format("{0:0.00}", Convert.ToDouble(txtGrossAmount.Text) + Convert.ToDouble(txtDue.Text));

        hdnGrossAmount.Value = txtGrandTotal.Text;

        if (txtRecievedAmount.Visible == true)
        {
            txtGrandTotal.Text = String.Format("{0:0.00}", Convert.ToDouble(txtGrandTotal.Text) - Convert.ToDouble(txtRecievedAmount.Text));
        }

        txtAmountRecieved.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());
    }

    public List<PatientDueChart> getPatientConsultationDetails()
    {
        List<PatientDueChart> lstBillingDetails = new List<PatientDueChart>();


        string hidValue = iconHidDelete.Value;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    PatientDueChart objBilling = new PatientDueChart();
                    objBilling.FeeID = Convert.ToInt64(lineItems[0]);
                    if (lineItems[0] == "-2")
                    {
                        objBilling.FeeType = "OTH";
                    }
                    else
                    {
                        objBilling.FeeType = "CON";
                    }
                    objBilling.Description = lineItems[2];
                    objBilling.Comments = "";
                    objBilling.Status = "";
                    objBilling.Amount = Convert.ToDecimal(lineItems[3]);
                    objBilling.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objBilling.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objBilling.Unit = 1;
                    objBilling.DetailsID = Convert.ToInt64(lineItems[0]);
                    lstBillingDetails.Add(objBilling);
                }
            }
        }
        return lstBillingDetails;
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

}
