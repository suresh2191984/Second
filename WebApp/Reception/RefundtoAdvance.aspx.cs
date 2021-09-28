
using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.IO;
using System.Linq;
using Attune.Podium.PerformingNextAction;

public partial class Reception_Collections : BasePage
{
    public Reception_Collections()
        : base("Reception\\RefundtoAdvance.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long pPatientID = 0;
    //long pVisitID = 0;
    long returnCode = -1;
    //decimal totalDepositAmount = 0;
    //decimal totalDepositUsed = 0;
    //decimal totalDepositBalance = 0;
    long ClientID = 0;
    string CustomerType = string.Empty;
    string ClientName = string.Empty;
    //Patient_BL patientBL;
    //PatientVisit_BL patientvisitBL;
    List<Patient> lstPatient = new List<Patient>();
    List<ClientMaster> lstClient = new List<ClientMaster>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "3";
            Rs_Selectapatient.Visible = false;
            dList.Visible = false;
            LoadSearchTypeMetaData();
        }

        
        //AB Code
        //Rs_TotalAmount.Visible = false;
        //txtPayment.Visible = false;
        //Rs_ServiceCharge.Visible = false;
        //txtServiceCharge.Visible = false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (hdnCustomerType.Value == "C")
        {
            //decimal refundable = (Convert.ToDecimal(lblTotalDepositAmount.Text)) - ((Convert.ToDecimal(lblRefundedAmt.Text)) + (Convert.ToDecimal(txtPayment.Text)));
            //if (refundable > 0)
            //{

                decimal dAmount = 0;
                AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);
                List<CollectionsHistory> lstCDH = new List<CollectionsHistory>();
                decimal dServiceCharge = 0;
                decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
                decimal depoAmount = 0;
                decimal.TryParse(hdnDepoAmount.Value, out depoAmount);
                hdnNowPaid.Value = hdnNowPaid.Value == "" ? "0" : hdnNowPaid.Value;
                txtPayment.Text = (txtPayment.Text == "0" || txtPayment.Text == "") ? hdnNowPaid.Value : txtPayment.Text;
                dAmount = Convert.ToDecimal(txtPayment.Text);
                HdntotAmount.Value = dAmount.ToString();
                System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
                dtAdvancePaidDetails = PaymentTypes.GetAmountReceivedDetails();
                int length = 0;
                length = dtAdvancePaidDetails.Rows.Count;
                for (int i = 0; i < length; i++)
                {
                    CollectionsHistory objCDH = new CollectionsHistory();
                    objCDH.CollectionID = 0;
                    objCDH.CreatedAt = DateTime.Today;
                    objCDH.Identificationid = Convert.ToInt32(hdnClientID.Value);//ClientID
                    //objCDH.OrgID = OrgID;
                    //objCDH.ReceiptNo = "0";
                    objCDH.AmountDeposited = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["AmtReceived"]) - dServiceCharge;//RefundAmount
                    //
                    //objCDH.CreatedBy = LID;//
                    objCDH.PaymentTypeID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["TypeID"]);
                    objCDH.ChequeorCardNumber = dtAdvancePaidDetails.Rows[i]["ChequeorCardNumber"].ToString();
                    objCDH.BankNameorCardType = dtAdvancePaidDetails.Rows[i]["BankNameorCardType"].ToString();
                    objCDH.Remarks = dtAdvancePaidDetails.Rows[i]["Remarks"].ToString();
                    objCDH.ServiceCharge = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["ServiceCharge"]);
                    objCDH.BaseCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["BaseCurrencyID"]);
                    if (Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["PaidCurrencyID"]) == 0)
                    {
                        objCDH.PaidCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["BaseCurrencyID"]);
                    }
                    else
                    {
                        objCDH.PaidCurrencyID = Convert.ToInt32(dtAdvancePaidDetails.Rows[i]["PaidCurrencyID"]);
                    }
                    
                    lstCDH.Add(objCDH);

                }
                string Ddtype = dList.SelectedValue;//Drop down selected value
                hdnCollectiontype.Value = Ddtype;
                string CType = "Client"; //Type of customer  selected value 
                string IsRefund = chkIsRefund.Checked ? "Y" : "N";
                string ReceiptNo = string.Empty;
                long Client = Convert.ToInt32(hdnClientID.Value);
                //string CreatedAT = DateTime.Today.ToString();
                returnCode = objAdBL.SaveCollectedRefundDeposit(Client, Ddtype, CType, IsRefund, OrgID, LID, lstCDH, out ReceiptNo);
                if (txtPayment.Text.Trim() != "0")
                {
                    hdnAmount.Value = (Convert.ToDecimal(txtPayment.Text.Trim()) - Convert.ToDecimal(hdnServiceCharge.Value.Trim())).ToString();
                    hdnDate.Value = OrgDateTimeZone;
                    hdnReceiptNo.Value = ReceiptNo.ToString().Trim();
                    lblClientName.Text = hdnclientName.Value;

                    this.Page.RegisterStartupScript("strKyAdvancePaidDetails", "<script type='text/javascript'> PopUpPage(); </script>");
                }
                #region Clear Datas

                txtPayment.Text = "";
                ((HiddenField)OtherPayments.FindControl("hdfValues")).Value = "";
                ((HiddenField)OtherPayments.FindControl("hdnValueExists")).Value = "";
                ((HiddenField)OtherPayments.FindControl("hdnValuesDeleted")).Value = "";

                ((HiddenField)PaymentTypes.FindControl("hdfPaymentType")).Value = "";
                ((HiddenField)PaymentTypes.FindControl("hdnPaymentsDeleted")).Value = "";

                this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");

                //Ab Code For Sms Alert
                PageContextDetails.PatientID = Convert.ToInt32(hdnClientID.Value);
                PageContextDetails.ButtonName = "btnSave";
                ActionManager objActionManager = new ActionManager(base.ContextInfo);

                objActionManager.PerformingNextStepNotification(PageContextDetails, "", "");
                #endregion
                loadInitialClientDatas();
            //}
            //else
            //{
            //    #region Clear Datas

            //    txtPayment.Text = "";
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Refund amount should not exceed total amount...');", true);
            //    ((HiddenField)OtherPayments.FindControl("hdfValues")).Value = "";
            //    ((HiddenField)OtherPayments.FindControl("hdnValueExists")).Value = "";
            //    ((HiddenField)OtherPayments.FindControl("hdnValuesDeleted")).Value = "";

            //    ((HiddenField)PaymentTypes.FindControl("hdfPaymentType")).Value = "";
            //    ((HiddenField)PaymentTypes.FindControl("hdnPaymentsDeleted")).Value = "";

            //    this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
            //    #endregion
            //    loadInitialClientDatas();
            //}


        }

    }

    protected void loadInitialDatas()
    {
        AdvancePaid_BL objapdBL = new AdvancePaid_BL(base.ContextInfo);
        List<PatientDepositHistory> lstPDH = new List<PatientDepositHistory>();
        decimal TotalDepositAmount = 0;
        decimal TotalDepositUsed = 0;
        decimal TotalRefundAmount = 0;
        objapdBL.GetPatientDepositDetails(pPatientID, OrgID, out lstPDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);
        lblTotalDepositAmount.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        //lblTotalDepositUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        lblTotalDepositAmountTemp.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        //lblTotalDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
        if (TotalRefundAmount > 0)
        {
            //lblRefundedAmt.Visible = true;
            //lblRefundAmt.Visible = true;
            //lblRefundAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
        }
        
        gvCollectDepositDetails.DataSource = lstPDH;
        gvCollectDepositDetails.DataBind();
    }

    protected void loadInitialClientDatas()
    {
        AdvancePaid_BL objapdBL = new AdvancePaid_BL(base.ContextInfo);
        List<CollectionsHistory> lstCDH = new List<CollectionsHistory>();
        decimal TotalDepositAmount = 0;
        decimal TotalDepositUsed = 0;
        decimal TotalRefundAmount = 0;
        long clientid = Convert.ToInt32(hdnClientID.Value);
        //objapdBL.GetClientDepositDetails(clientid, OrgID, out lstCDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);
        objapdBL.GetClientRefundDetails(clientid, OrgID, out lstCDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);
        //if (Convert.ToDecimal(TotalDepositAmount) > 0)
        //{
            lblTotalDepositAmount.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
            lblRefundUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
            lblRefundedAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");

            lblTotalDepositAmountTemp.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
            //lblTotalDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
            if (TotalRefundAmount > 0)
            {
                lblRefundedAmt.Visible = true;
                //lblRefundAmt.Visible = true;
                ////lblRefundedAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
                lblRefundedAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
                lblTotalRefundable.Text = ((Convert.ToDecimal(lblTotalDepositAmount.Text)) - (Convert.ToDecimal(TotalDepositUsed + TotalRefundAmount))).ToString();
            }
            else
            {
                //AB Code
                decimal TotalUsedAmount = Convert.ToDecimal(TotalDepositUsed);
                if (TotalUsedAmount > 0)
                {
                    lblTotalRefundable.Visible = true;
                    lblTotalRefundable.Text = ((Convert.ToDecimal(lblTotalDepositAmount.Text)) - (Convert.ToDecimal(TotalDepositUsed))).ToString();
                }
                else
                {
                    lblTotalRefundable.Visible = true;
                    lblTotalRefundable.Text = (Convert.ToDecimal(lblTotalDepositAmount.Text)).ToString("0.00");
                }
            }


            gvCollectDepositDetails.DataSource = lstCDH;
            gvCollectDepositDetails.DataBind();
        //}
        //else
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('This is not a advance client');", true);
        //}
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + "/Reception/RefundtoAdvance.aspx", true);
            //Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }
    protected void gvCollectDepositDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                RadioButton rdoID = (RadioButton)e.Row.FindControl("rdoID");

                CollectionsHistory D = (CollectionsHistory)e.Row.DataItem;
                string strScript = "CallPrintReceipt('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoID")).ClientID + "','" + D.CreatedAt + "','" + D.RefundAmount + "','" + D.ReceiptNo + "','" + D.IdentificationType + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollectDepositDetails_RowDataBound", ex);
        }
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        tblData.Style.Add("display", "block");
        trpatient.Visible = false;
        trClient.Visible = true;
        lblClientName.Text = hdnclientName.Value;
        CustomerType = hdnCustomerType.Value;
        if (CustomerType == "C")
        {
            lblClienttype.Text = "Client";
        }
        if (CustomerType == "C")
        {
            lblCollection.Text = "Deposits";
        }

        ClientID = Convert.ToInt32(hdnClientID.Value);
        loadInitialClientDatas();


    }
    public void LoadSearchTypeMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "CollectionType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "CollectionType"
                                 select child;
                dList.DataSource = childItems;
                dList.DataTextField = "DisplayText";
                dList.DataValueField = "Code";
                dList.DataBind();
                dList.Items.Insert(0, "--Select--");
                dList.Items[0].Value = "-1";



            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
}

