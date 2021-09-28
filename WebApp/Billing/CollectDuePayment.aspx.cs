using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;

public partial class Billing_CollectDuePayment : BasePage
{

    public Billing_CollectDuePayment()
        : base("Billing\\CollectDuePayment.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long patientID = -1;
    long patientVisitID = -1;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            loadDueDetail();
        }
        txtReceivedAmount.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());
    }

    private void loadDueDetail()
    {
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        List<FinalBill> lstDueDetail = new List<FinalBill>();
        long finalBillID = -1;
        string visittype = "";
        ucDueDetail.loadDueDetail(OrgID, patientID, 0, out finalBillID, out lstDueDetail, out visittype);
        //if (visittype.Trim().Split('~')[0] != "1")
        //{
            double dueAmount = 0;
            if (lstDueDetail.Count > 0)
            {
                tbDueDetails.Style.Add("display", "block");
                for (int i = 0; i < lstDueDetail.Count; i++)
                {
                    int iCount = lstDueDetail.Count == 0 ? 1 : lstDueDetail.Count;
                    if (lstDueDetail.Count > 0)
                    {
                        Double.TryParse(lstDueDetail[iCount - 1].CurrentDue.ToString(), out dueAmount);
                    }
                }
                txtTotalAmount.Text = String.Format("{0:0.00}", dueAmount);
                txtReceivedAmount.Text = String.Format("{0:0.00}", 0);
                PatientHeader.PatientID = patientID;

                PatientHeader.PatientVisitID = patientVisitID;
                PatientHeader.ShowVitalsDetails();
            }
            else
            {
                tbDueDetails.Style.Add("display", "none");
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = " There is no due for this patient ";
            }
        //}
        //else
        //{
        //    if (lstDueDetail.Count > 0)
        //    {
        //        Response.Redirect("~/InPatient/IPBillSettlement.aspx?PID=" + patientID.ToString() + "&VID=" + visittype.Trim().Split('~')[1] + "&PNAME=&vType=IP", true);
        //    }
        //    else
        //    {
        //        ErrorDisplay1.ShowError = true;
        //        ErrorDisplay1.Status = " There is no due for this patient ";
        //    }
        //}
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            txtReceivedAmount.Text = txtReceivedAmount.Text == "" ? "0" : txtReceivedAmount.Text;
            if (Convert.ToDouble(txtReceivedAmount.Text) > 0)
            {
                List<DuePaidDetail> lstPaidDueDetail;
                System.Data.DataTable dtAmountReceived;
                long enteredPatientID;
                long lFinalBillID;
                long lVisitID;
                decimal dServiceCharge;
                GetPatientDueCollectionDetails(out lstPaidDueDetail, out dtAmountReceived, out enteredPatientID, out lFinalBillID, out lVisitID, out dServiceCharge);

                //returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID);
                /*_____________________________________________________________________________________________________________________________________________________________________*/

                returnCode = new BillingEngine(base.ContextInfo).InsertPatientDueCollections(enteredPatientID, OrgID, ILocationID, 10,
                                                                            LID, "Due Collection",
                                                                            Convert.ToDecimal(txtTotalAmount.Text),
                                                                            lstPaidDueDetail, dtAmountReceived,
                                                                            Convert.ToDecimal(txtReceivedAmount.Text), out lVisitID, out lFinalBillID, dServiceCharge);
                //returnCode = new BillingEngine(base.ContextInfo).UpdateAndInsertDueDetail(lstPaidDueDetail);
                //returnCode = new BillingEngine(base.ContextInfo).InsertAmountReceivedDetails(dtAmountReceived, OrgID, Convert.ToDecimal(txtReceivedAmount.Text), LID, LID, 0);
                Response.Redirect("../Reception/ViewPrintPage.aspx?pid=" + enteredPatientID + "&vid=" + lVisitID + "&bid=" + lFinalBillID + "&pagetype=BP", true);
            }
        }
        catch (System.Threading.ThreadAbortException exe)
        {
            string execp = exe.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving due amount", ex);
        }
    }
    protected void btnWriteoffDues_Click(object sender, EventArgs e)
    {
        try
        {
            txtReceivedAmount.Text = txtReceivedAmount.Text == "" ? "0" : txtReceivedAmount.Text;
           
                List<DuePaidDetail> lstPaidDueDetail;
                System.Data.DataTable dtAmountReceived;
                long enteredPatientID;
                long lFinalBillID;
                long lVisitID;
                decimal dServiceCharge;
                GetPatientDueCollectionDetails(out lstPaidDueDetail, out dtAmountReceived, out enteredPatientID, out lFinalBillID, out lVisitID, out dServiceCharge);

                //returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID);
                /*_____________________________________________________________________________________________________________________________________________________________________*/
            if(chkWriteoffdues.Checked)
            {
                returnCode = new BillingEngine(base.ContextInfo).InsertWriteOffPatientDue(enteredPatientID, OrgID, ILocationID, 10,
                                                                            LID, "Due Collection",
                                                                            Convert.ToDecimal(txtTotalAmount.Text),
                                                                            lstPaidDueDetail, dtAmountReceived,
                                                                            Convert.ToDecimal(txtReceivedAmount.Text), out lVisitID, out lFinalBillID, dServiceCharge);
            }
            else
            {
                returnCode = new BillingEngine(base.ContextInfo).InsertPatientDueCollections(enteredPatientID, OrgID, ILocationID, 10,
                                                                          LID, "Due Collection",
                                                                          Convert.ToDecimal(txtTotalAmount.Text),
                                                                          lstPaidDueDetail, dtAmountReceived,
                                                                          Convert.ToDecimal(txtReceivedAmount.Text), out lVisitID, out lFinalBillID, dServiceCharge);
            }
                if (Convert.ToDouble(txtReceivedAmount.Text) > 0)
                {
                    Response.Redirect("../Reception/ViewPrintPage.aspx?pid=" + enteredPatientID + "&vid=" + lVisitID + "&bid=" + lFinalBillID + "&pagetype=BP", true);
                }
                else
                {
                    string sPath = "Billing\\\\CollectDuePayment.aspx.cs_1";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "WriteoffDues", "ShowAlertMsg('" + sPath + "')", true);
                
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "WriteoffDues", "javascript:alert('Due amount written-off successfully ');", true);
                    loadDueDetail();
                }

        }
        catch (System.Threading.ThreadAbortException exe)
        {
            string execp = exe.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Write-off Due amount", ex);
        }
    }

    private void GetPatientDueCollectionDetails(out List<DuePaidDetail> lstPaidDueDetail, out System.Data.DataTable dtAmountReceived, out long enteredPatientID, out long lFinalBillID, out long lVisitID, out decimal dServiceCharge)
    {
        decimal recievedAmount = Convert.ToDecimal(txtReceivedAmount.Text);
        lstPaidDueDetail = new List<DuePaidDetail>();
        DuePaidDetail duePaidDetail;
        long finalBillID = -1;

        List<FinalBill> lstDueDetail = new List<FinalBill>();

        Int64.TryParse(Request.QueryString["pid"], out patientID);
        string visittype = "";
        ucDueDetail.loadDueDetail(OrgID, patientID, 0, out finalBillID, out lstDueDetail, out visittype);

        dtAmountReceived = new System.Data.DataTable();
        dtAmountReceived = PaymentType.GetAmountReceivedDetails();

        // If Amount Recieved equal to Grand Total then
        if (Convert.ToDouble(txtTotalAmount.Text) == Convert.ToDouble(txtReceivedAmount.Text))
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

        /*______________________________________________SAVE VISIT_____________________________________________________________________________________________________________*/

        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        PatientVisit pVisit = new PatientVisit();
        int purpID = (int)TaskHelper.VisitPurpose.DuePayment;
        long phyID = -1;
        int otherID = -1;
        long referOrgID = -1;
        int orgAddressID = -1;

        pVisit.VisitPurposeID = purpID;
        pVisit.PhysicianID = (int)phyID;
        pVisit.OrgID = OrgID;
        pVisit.PatientID = patientID;
        pVisit.OrgAddressID = orgAddressID;
        pVisit.SpecialityID = otherID;
        pVisit.ReferOrgID = referOrgID;
        long visitID = -1;
        enteredPatientID = 0;
        Int64.TryParse(Request.QueryString["PID"], out enteredPatientID);

        lFinalBillID = 0;
        lVisitID = 0;
        dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            string execp = ex.ToString();
        }
    }


    protected void SaveBilling()
    {
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);



        List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
        SaveBillingDetails save;
        decimal zeroAmount = 0;

        decimal amount1;
        //set private variable indicating the list to be empty as false
        long ID = -1;
        string description = "Due Payment";
        if (txtReceivedAmount.Text != "")
        {
            amount1 = Convert.ToDecimal(txtReceivedAmount.Text);
            zeroAmount += amount1;
        }
        else
        {
            amount1 = 0;
            zeroAmount += amount1;
        }
        string isGroup = "";
        save = new SaveBillingDetails();

        save.ID = ID;
        save.Amount = amount1;
        save.Description = description;
        save.IsGroup = isGroup;

        lstBillingDetails.Add(save);



        if (zeroAmount != 0)
        {
            // Save Consulting Billing information
            //billingBL.CreateConsultingBillingEntry(OrgID, PatientVisitID, LID, lstBillingDetails);
        }
    }
}
