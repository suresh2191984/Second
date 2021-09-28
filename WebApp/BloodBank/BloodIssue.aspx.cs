using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.DataAccessEngine;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Linq;
using Attune.Podium.BillingEngine;


public partial class BloodBank_BloodIssue : BasePage
{
    List<BloodRequistionDetails> lstBloodRequest = new List<BloodRequistionDetails>();
    List<Patient> lstPatient = new List<Patient>();
    BloodBank_BL objBL = new BloodBank_BL();
    long returnCode = -1;
    long RequestNo = 0;
    long PatientID = -1;
    long VisitID = -1;
    long TaskID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        PatientID = Convert.ToInt32(Request.QueryString["pid"]);
        VisitID = Convert.ToInt32(Request.QueryString["vid"]);
        TaskID = Convert.ToInt32(Request.QueryString["tid"]);
        if (!IsPostBack)
        {
            DateTime pFDT;
            DateTime pTDT;
            pFDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            pTDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            returnCode = new BloodBank_BL(base.ContextInfo).GetBloodRequestDetails(PatientID, VisitID, pFDT, pTDT, out RequestNo, out lstBloodRequest, out lstPatient);
            if (returnCode != -1)
            {
                lblRequestNoValue.Text = RequestNo.ToString();
                grdRequestedComponents.DataSource = lstBloodRequest;
                grdRequestedComponents.DataBind();
              
                lblRecepientNameValue.Text = lstPatient[0].Name;
                lblAgeValue.Text = lstPatient[0].Age;
                lblSexValue.Text = lstPatient[0].SEX;
                lblBloodGroupValue.Text = lstPatient[0].BloodGroup;
                lblAddressValue.Text = lstPatient[0].Add1 + "  /  " + lstPatient[0].AlternateContact;
            }
        }

    }
   

    protected void grdRequestedComponents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            PlaceHolder plachldr = e.Row.FindControl("PlaceHolder1") as PlaceHolder;
            PlaceHolder plachldr2 = e.Row.FindControl("PlaceHolder2") as PlaceHolder;
            Label lblNoofunits = (Label)e.Row.FindControl("lblnoofunits");
            // int n1 = Convert.ToInt32(lblNoofunits.Text);
            int n = Convert.ToInt32(lblNoofunits.Text);
            if (plachldr != null)
            {
                for (int i = 0; i < n; i++)
                {
                    TextBox txt1 = new TextBox();
                    txt1.ID = "txtBagNo"+i.ToString();
                    txt1.BackColor = System.Drawing.Color.Ivory;
                    Label lbl1 = new Label();
                    lbl1.Height = Unit.Pixel(20);
                    plachldr.Controls.Add(txt1);
                    plachldr.Controls.Add(lbl1);

                    hdnBagNo.Value += txt1.ClientID;
                }
                //TextBox t = FindControl("txtBagNo") as TextBox;
                //Response.Write(t);

            }
            if (plachldr2 != null)
            {
                for (int i = 0; i < n; i++)
                {
                    TextBox txt2 = new TextBox();
                    txt2.ID = "txtRate" + i .ToString();
                    txt2.Text = "0.00";
                    txt2.BackColor = System.Drawing.Color.Ivory;
                    Label lbl2 = new Label();
                    lbl2.Height = Unit.Pixel(20);
                    plachldr2.Controls.Add(txt2);
                    plachldr2.Controls.Add(lbl2);
                    hdnRate.Value += txt2.ClientID+"^";
                }
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        int otherID = -1;
        long visitID = -1;
        string feeType = string.Empty;
        string otherName = string.Empty;
        string PaymentLogic = string.Empty;
        int purpID = (int)TaskHelper.VisitPurpose.Pharmacy;
        string physicianName = String.Empty;
        string referrerName = string.Empty;
        int ClientID = 0;
        long FinalBillID = -1;
        string visittype = "";
        decimal dueAmount = 0;
      
        try
        {
            FinalBill finalBill = new FinalBill();
            AmountReceivedDetails amtRD = new AmountReceivedDetails();
            List<InventoryItemsBasket> lstStockUsageDetails = new List<InventoryItemsBasket>();
            decimal dserviceCharge = 0;
            DataTable dtAmountReceived = new DataTable();
           
            PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit pVisit = new PatientVisit();
            List<Patient> lstPatient = new List<Patient>();
            List<FinalBill> lstDueDetail1 = new List<FinalBill>();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            List<BillingDetails> lstBloodBillingDetails = new List<BillingDetails>();
            List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
            List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();
            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            GetInvBillingDetails(out  finalBill, out  dtAmountReceived, out  amtRD, out lstStockUsageDetails, out dserviceCharge);
            finalBill.PatientID = PatientID;
            finalBill.VisitID = VisitID;
            finalBill.CurrentDue = finalBill.Due;
            finalBill.Due = 0;
          
            finalBill.NetValue = 0;
            finalBill.NetValue = Convert.ToDecimal(hdnTotalAmount.Value);
            List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
          
            if (lstStockUsageDetails.Count > 0)
            {

                //returnCode = new Inventory_BL(base.ContextInfo).SaveOPInventoryBilling(lblRecepientName.Text, ILocationID, finalBill, dtAmountReceived, amtRD, lstStockUsageDetails, InventoryLocationID, out FinalBillID, dserviceCharge, lstUsage, lstVisitClientMapping);
                finalBill.FinalBillID = FinalBillID;
              
                Int64.TryParse(Request.QueryString["tid"], out TaskID);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(TaskID, TaskHelper.TaskStatus.Completed, UID, "");
                returnCode=new BloodBank_BL(base.ContextInfo).GetBloodIssuedComponents(VisitID, FinalBillID, out lstBloodBillingDetails);
                if (lstBloodBillingDetails.Count() > 0)

                {
                    lblPatientNumber.Text = Convert.ToString(lstBloodBillingDetails[0].ItemType);
                    lblIssuedDate.Text =Convert.ToString(lstBloodBillingDetails[0].CreatedAt);
                    lblName.Text = lstBloodBillingDetails[0].SourceType;
                    lblBillNo.Text = Convert.ToString(lstBloodBillingDetails[0].Status);
                    lblPAge.Text = lstBloodBillingDetails[0].AttributeDetail;
                    lblSexValueP.Text = lstBloodBillingDetails[0].RefPhyName;
                    gvResult.DataSource = lstBloodBillingDetails;
                    gvResult.DataBind();
                   
                }

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Print", "popupprint();", true);

             
              //  Response.Redirect(@"~/Inventory/PrintBill.aspx?bid=" + finalBill.FinalBillID + "&IsPopup=Y&vid=" + visitID + "&pid =" + patientID);
                //hdnprint.NavigateUrl = @"PrintBill.aspx?bid=" + finalBill.FinalBillID + "&IsPopup=Y&vid=" + visitID + "&pid =" + patientID;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Comp", "openPOPup();GetCurrencyValues();ReDirectPage('" + pageSTR + "');", true);
            }

            
        }

        catch (Exception ex)
        {
            CLogger.LogError("There is problem in Saving Billing", ex);
        }

    }

   
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }



    protected void btnAdding_Click(object sender, EventArgs e)
    {
       
        GetBloodIssueDetails();
        
    }


    private List<BloodRequistionDetails> GetBloodIssueDetails()
    {
        List<BloodRequistionDetails> lstBloodIssue = new List<BloodRequistionDetails>();
        foreach (GridViewRow row in grdRequestedComponents.Rows)
        {
            BloodRequistionDetails newBasket = new BloodRequistionDetails();
            Label lblComponentname = (Label)row.FindControl("lblComponentname");
            Label Lblnoofunits = (Label)row.FindControl("lblnoofunits");
            PlaceHolder ph = (PlaceHolder)grdRequestedComponents.Rows[2].FindControl("PlaceHolder1");
            TextBox txtBagNumber = ph.FindControl("txtBagNo") as TextBox;

            //PlaceHolder txtBagNumber =Convert.ToString(txtBagNo);
            //PlaceHolder txtrate = 
            CheckBox chkIsTest = (CheckBox)row.FindControl("chkIsTest");
          
            if (chkIsTest.Checked)
            {
                newBasket.ComponentName = Convert.ToString(lblComponentname.Text);
               // newBasket.NoOfUnits = Convert.ToInt16(Lblnoofunits.ToString());
               // newBasket.Rate = Convert.ToDecimal(txtRate.Text);
                newBasket.BagNumber = Convert.ToString(hdnBagNo.ToString());
              //  newBasket.CompatiblityTestingdone = Convert.ToString(chkIsTest);
               
               
              
            }
        }
        return lstBloodIssue;
    }

    private void GetInvBillingDetails(out FinalBill finalBill, out DataTable dtAmountReceived, out AmountReceivedDetails amtRD, out List<InventoryItemsBasket> lstStockUsageDetails, out decimal dserviceCharge)
    {
        finalBill = new FinalBill();
        amtRD = new AmountReceivedDetails();
        lstStockUsageDetails = new List<InventoryItemsBasket>();
        dserviceCharge = 0;
        dtAmountReceived = new DataTable();
        int BaseCurrencyID = 0;
        int PaidCurrencyID = 0;
        decimal OtherCurrencyAmount = 0;
        try
        {
            # region Billing
           
            finalBill.NetValue =hdnTotalAmount.Value ==" " ? 0: Convert.ToDecimal(hdnTotalAmount.Value);//  Convert.ToDecimal(hdnGrandTotal.Value)-;
            finalBill.AmountReceived = hdnTotalAmount.Value == " " ? 0 : Convert.ToDecimal(hdnTotalAmount.Value);
            finalBill.OrgID = OrgID;
            VisitClientMapping VisitClientMapping = new VisitClientMapping();
            dtAmountReceived = Payment.GetAmountReceivedDetails();
            Payment.GetOtherCurrReceivedDetails(out BaseCurrencyID, out PaidCurrencyID);
            OtherCurrencyDisplay1.GetOtherCurrRecd(out OtherCurrencyAmount);
            amtRD.OtherCurrencyAmount = OtherCurrencyAmount;
            PaidCurrencyID = BaseCurrencyID;
            amtRD.AmtReceived = Convert.ToDecimal(hdnTotalAmount.Value);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;

            finalBill.CurrentDue = 0;
           

            //ends here
           

            lstStockUsageDetails = GetCollectedItems();
            //if (Request.QueryString["tid"] != null)
            //{
            //    lstStockUsageDetails = GetTaskINVBasket(lstStockUsageDetails);
            //}

            //returnCode = new Inventory_BL(base.ContextInfo).CheckAvailableQuantity(ILocationID, OrgID, ref lstStockUsageDetails);
            //if (CheckQuantity(lstStockUsageDetails))
            //{
            //    returnCode = 0;
            //}
            //else
            //{
            //    returnCode = -1;
            //}


            #endregion

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing op billing", ex);
            return;
        }

    }


    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (string listParent in hdnIssueComponents.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID =Convert.ToInt64(hdnSID.Value);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[4];
                newBasket.Quantity = Convert.ToDecimal(listChild[2]);
                newBasket.Unit = "Bag";
              
                newBasket.ProductID = Convert.ToInt64(listChild[0]);
                newBasket.Amount = Convert.ToDecimal(listChild[3]);
                newBasket.Rate = Convert.ToDecimal(listChild[3]);
                //newBasket.Tax = Convert.ToDecimal(listChild[8]);
                newBasket.ExpiryDate = Convert.ToDateTime(hdnExpDate.Value);
                newBasket.Manufacture = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                newBasket.DiscOrEnhanceType  = "BLD";
                newBasket.CategoryID = 67;
                newBasket.CategoryName = "Blood";
               
                //if (listChild[11] == "Yes")
                //{
                //    Isreimbursable = "Y";
                //}
                //if (listChild[11] == "No")
                //{
                //    Isreimbursable = "N";
                //}
                newBasket.Type = Isreimbursable;
                newBasket.AttributeDetail = "N";
                newBasket.UnitPrice = Convert.ToDecimal(listChild[3]);
                newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                                + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
               // newBasket.PrescriptionNO = PrcNo;
                lstInventoryItemsBasket.Add(newBasket);
              

            }
        }
        return lstInventoryItemsBasket;
    }



}
