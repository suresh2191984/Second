
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
        : base("Reception_Collections_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long pPatientID = 0;
    long pVisitID = 0;
    long returnCode = -1;
    decimal totalDepositAmount = 0;
    decimal totalDepositUsed = 0;
    decimal totalDepositBalance = 0;
    long ClientID = 0;
    string CustomerType = string.Empty;
    string ClientName = string.Empty;
    Patient_BL patientBL;
    PatientVisit_BL patientvisitBL;
    List<Patient> lstPatient = new List<Patient>();
    List<ClientMaster> lstClient = new List<ClientMaster>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
    string isCollectionApproval = "N";
    int PreCollectionID = 0;
    long TaskID = 0;
    int paymentType = 0;

    //string paymentType = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        dList.SelectedValue = "1";
        if (!IsPostBack)
        {
            LoadSearchTypeMetaData();

            if (Request.QueryString["IsClient"] != null && Request.QueryString["IsClient"] == "Y")
            {

                if (Session["CID"] != null && Session["CID"] != "")
                {
                    hdnClientID.Value = Convert.ToString(Session["CID"]);
                    hdnCustomerType.Value = "C";
                }

                if (Session["UserName"] != null && Session["UserName"] != "")
                {
                    txtClientNameSrch.Text = Convert.ToString(Session["UserName"]);
                    hdnclientName.Value=Convert.ToString(Session["UserName"]);
                   txtClientNameSrch.Attributes.Add("readonly", "readonly");
                  
                   dList.Attributes.Add("disabled", "disabled");
                }

                bGo.Attributes.Add("style", "display:none");
                loadInitialClientDatas();
            
            }
                if (isCollectionApproval == "N" &&Request.QueryString["cmid"] != null && Request.QueryString["CID"] != null && Request.QueryString["tid"] != null)
                {
                   hdnPreCollectionID.Value = Convert.ToString(Request.QueryString["cmid"]);
                    hdnClientID.Value = Convert.ToString(Request.QueryString["CID"]);
                    hdnCustomerType.Value = Convert.ToString(Request.QueryString["CusType"]);
                    TaskID = Convert.ToInt64(Request.QueryString["tid"]);
                    hdnTaskID.Value = Convert.ToString(TaskID);
                    hdnIsTaskApproval.Value = "Y";
                    txtClientNameSrch.Text = Convert.ToString(Request.QueryString["CName"]);
                    hdnclientName.Value = Convert.ToString(Request.QueryString["CName"]);
                    bGo.Attributes.Add("style", "display:none");
                    loadInitialClientDatas();
                    dList.SelectedValue = Convert.ToString(Request.QueryString["CType"]);
                    txtClientNameSrch.Attributes.Add("readonly", "readonly");
                    dList.Attributes.Add("disabled", "disabled");
                 //   dList.Items.FindByValue(Convert.ToString(Request.QueryString["CType"])).Selected = true;
                }
            
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
            decimal dAmount = 0;
            AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);
            List<CollectionsHistory> lstCDH = new List<CollectionsHistory>();
            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            decimal depoAmount = 0;
            decimal.TryParse(hdnDepoAmount.Value, out depoAmount);
            hdnNowPaid.Value = hdnNowPaid.Value == "" ? "0" : hdnNowPaid.Value;
            txtPayment.Text = (txtPayment.Text == "0" || txtPayment.Text == "") ? hdnNowPaid.Value : txtPayment.Text;
           // dAmount = Convert.ToDecimal(txtPayment.Text);
           // HdntotAmount.Value = dAmount.ToString();
            System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
            dtAdvancePaidDetails = PaymentTypes.GetAmountReceivedDetails();
            int length = 0;
            length = dtAdvancePaidDetails.Rows.Count;
            for (int i = 0; i < length; i++)
            {
                CollectionsHistory objCDH = new CollectionsHistory();
                objCDH.CollectionID = 0;
                objCDH.Identificationid = Convert.ToInt32(hdnClientID.Value);
                objCDH.OrgID = OrgID;
                objCDH.ReceiptNo = "0";
                objCDH.AmountDeposited = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["AmtReceived"]) - dServiceCharge;
                dAmount = dAmount + objCDH.AmountDeposited;
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
                if (Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["OtherCurrencyAmount"]) == 0)
                {
                    objCDH.PaidCurrencyAmount = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["AmtReceived"]);
                }
                else
                {
                    objCDH.PaidCurrencyAmount = Convert.ToDecimal(dtAdvancePaidDetails.Rows[i]["OtherCurrencyAmount"]);
                }
                objCDH.CardHolderName = dtAdvancePaidDetails.Rows[i]["CardHolderName"].ToString();

                objCDH.CreatedBy = LID;
                objCDH.IdentificationType = dList.SelectedValue;
                lstCDH.Add(objCDH);

            }
            HdntotAmount.Value = dAmount.ToString();
            string Ddtype = dList.SelectedValue;//Drop down selected value
            hdnCollectiontype.Value = Ddtype;
            string CType = "Client"; //Type of customer  selected value 
            string IsRefund = chkIsRefund.Checked ? "Y" : "N";
            string ReceiptNo = string.Empty;
            long Client = Convert.ToInt32(hdnClientID.Value);
            PreCollectionID = Convert.ToInt32(hdnPreCollectionID.Value);
            returnCode = objAdBL.SaveCollectedClientDeposit(Client, Ddtype, CType, IsRefund, OrgID, LID, PreCollectionID,lstCDH, out ReceiptNo);
            if (txtPayment.Text.Trim() != "0")
            {
                Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                if (hdnIsTaskApproval.Value== "Y")
                 {
                     long tid=Convert.ToInt64(hdnTaskID.Value);
                     oTasksBL.UpdateTask(tid, TaskHelper.TaskStatus.Completed, LID);
                }
                hdnAmount.Value = (dAmount - Convert.ToDecimal(hdnServiceCharge.Value.Trim())).ToString();
                hdnDate.Value = OrgDateTimeZone;
                hdnReceiptNo.Value = ReceiptNo.ToString().Trim();
                lblClientName.Text = hdnclientName.Value;
                if (RoleName != "Client")
                {
                   
                    this.Page.RegisterStartupScript("strKyAdvancePaidDetails", "<script type='text/javascript'> PopUpPage('"+hdnIsTaskApproval.Value+"'); </script>");
                }
                }

            #region Clear Datas

            txtPayment.Text = "";
            ((HiddenField)OtherPayments.FindControl("hdfValues")).Value = "";
            ((HiddenField)OtherPayments.FindControl("hdnValueExists")).Value = "";
            ((HiddenField)OtherPayments.FindControl("hdnValuesDeleted")).Value = "";

            ((HiddenField)PaymentTypes.FindControl("hdfPaymentType")).Value = "";
            ((HiddenField)PaymentTypes.FindControl("hdnPaymentsDeleted")).Value = "";
            
            this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
            #endregion


            //AB Code For Sms and Email
            PageContextDetails.PatientID = Convert.ToInt32(hdnClientID.Value);
            PageContextDetails.ButtonName = "btnSave";
            ActionManager objActionManager = new ActionManager(base.ContextInfo);

            objActionManager.PerformingNextStepNotification(PageContextDetails, "", "");

            loadInitialClientDatas();


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
        lblTotalDepositUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        lblTotalDepositAmountTemp.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblTotalDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
        if (TotalRefundAmount > 0)
        {
            lblRefundedAmt.Visible = true;
            lblRefundAmt.Visible = true;
            lblRefundAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
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
        
        decimal TotalDepositedAmt;
        decimal TotalOutstandingAmount;
        decimal PreCollectionAmount;
        //decimal MinimumAmount;

        string PaymentRule = string.Empty;

        long clientid = Convert.ToInt32(hdnClientID.Value);
        PreCollectionID = Convert.ToInt32(hdnPreCollectionID.Value);
        objapdBL.GetClientDepositDetails(clientid, OrgID, PreCollectionID,out PreCollectionAmount ,out lstCDH, out TotalDepositAmount, out TotalDepositUsed,out TotalRefundAmount);
        lblTotalDepositAmount.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblTotalDepositUsed.Text = (Convert.ToDecimal(TotalDepositUsed)).ToString("0.00");
        lblTotalDepositAmountTemp.Text = (Convert.ToDecimal(TotalDepositAmount)).ToString("0.00");
        lblTotalDepositBalance.Text = (Convert.ToDecimal(TotalDepositAmount - TotalDepositUsed)).ToString("0.00");
        if (lstCDH.Count > 0 && lstCDH[0].Remarks == "Y")
        {
            tblData.Style.Add("display", "table");
            tblNotAlowed.Style.Add("display", "none"); 
        }
        else
        { tblData.Style.Add("display", "none");
        tblNotAlowed.Style.Add("display", "table"); 
        }
        if(PreCollectionAmount >0)
        {
            txtPayment.Text = PreCollectionAmount.ToString("0.00");
        }
        if (TotalRefundAmount > 0)
        {
            lblRefundedAmt.Visible = true;
            lblRefundAmt.Visible = true;
            lblRefundAmt.Text = (Convert.ToDecimal(TotalRefundAmount)).ToString("0.00");
        }
        gvCollectDepositDetails.DataSource = lstCDH;
        gvCollectDepositDetails.DataBind();
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
            Response.Redirect(Request.ApplicationPath + "/Reception/Home.aspx", true);
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

                CollectionsHistory D = (CollectionsHistory)e.Row.DataItem;
                string strScript = "CallPrintReceipt('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoID")).ClientID + "','" + D.CreatedAt + "','" + D.AmountDeposited + "','" + D.ReceiptNo + "','" + D.IdentificationType + "');";
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
        string strClient = Resources.Reception_ClientDisplay.Reception_Collections_aspx_01 == null ? "Client" : Resources.Reception_ClientDisplay.Reception_Collections_aspx_01;
        string strDeposit = Resources.Reception_ClientDisplay.Reception_Collections_aspx_02 == null ? "Deposits" : Resources.Reception_ClientDisplay.Reception_Collections_aspx_02;
        tblData.Style.Add("display", "table");
        trpatient.Visible = false;
        trClient.Visible = true;
        lblClientName.Text = hdnclientName.Value;
        CustomerType = hdnCustomerType.Value;
        if (CustomerType == "C")
        {
            //lblClienttype.Text = "Client";
            lblClienttype.Text = strClient;
        }
        if (CustomerType == "C")
        {
            //lblCollection.Text = "Deposits";
            lblCollection.Text = strDeposit;
        }

        ClientID = Convert.ToInt32(hdnClientID.Value);
        loadInitialClientDatas();


    }
    public void LoadSearchTypeMetaData()
    {
        string strSelect = Resources.Reception_ClientDisplay.Reception_Collections_aspx_03 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_Collections_aspx_03;
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
                //dList.Items.Insert(0, "--Select--");
                dList.Items.Insert(0, strSelect);
                dList.Items[0].Value = "-1";

                

            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
}

