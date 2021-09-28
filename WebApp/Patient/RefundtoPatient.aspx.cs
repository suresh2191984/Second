
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
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;
public partial class Patient_RefundtoPatient : BasePage
{

    public Patient_RefundtoPatient()
        : base("Patient_RefundtoPatient_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    BillingEngine billingBL;
    Role_BL rolebl;
    Master_BL objReasonMaster;
    Tasks_BL taskBL;
    Tasks task = new Tasks();
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    List<BillingDetails> lstBillingDetails;
    List<FinalBill> lstFinalBill;
    List<ReasonMaster> lstReasonMaster;
    string RefFlag = "Y";
    long taskID = -1;
    long returnCode = -1;
    long vid = 0;
    long patientID = -1;
    string billno = "";
    string sPatientName = string.Empty;
    string RefundNo = string.Empty;
    long pFinalBillid = 0;
    string PatientNumber = "";
    string Reftypes = "REF";
    string IsCancelRefund;
    string pathname = string.Empty;
    int index = 0;
    List<CurrencyOrgMapping> lstCurrOrgMap = new List<CurrencyOrgMapping>();
    string strAlert = Resources.Scripts_AppMsg.Scripts_Alert == null ? "Alert" : Resources.Scripts_AppMsg.Scripts_Alert;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060 == null ? "Male" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059 == null ? "Female" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059;
    string strVet = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074 == null ? "Vet" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074;
	string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    string strNA = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071 == null ? "NA" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071;
    #region "Common Resource Property"
    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        Users_BL LoginCheckdetails = new Users_BL(base.ContextInfo);
        //LoadMeatData();
        rolebl = new Role_BL(base.ContextInfo);
        objReasonMaster = new Master_BL(base.ContextInfo);
        billingBL = new BillingEngine(base.ContextInfo);
        rblPaymode.Attributes.Add("onclick", "Paymentchanged()");
        AutoCompleteExtender6.ContextKey = OrgID.ToString();
       // AutoCompleteExtender2.ContextKey = "0" + "~" + "Bank";
        billno = Request.QueryString["billno"].ToString();
        PatientNumber = Request.QueryString["pNumber"].ToString();
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        pathname = GetConfigValue("Refund Task Aministrator", OrgID);
        IsCancelRefund = GetConfigValue("CancelWithRefund", OrgID);
        if (Request.QueryString["btype"] == "CAN")
        {
            Reftypes = "CAN";
            hdnType.Value = Reftypes;
        }

        string AssignTask;
        AssignTask = GetConfigValue("SetDefaultTaskAssignToAdmin", OrgID);

        string AssignToCreditController=String.Empty;
        AssignToCreditController = GetConfigValue("SetDefaultTaskAssignToCreditController", OrgID);
       
       
        if (!IsPostBack)
        {
            LoadMeatData(); 
            try
            {
                hdnAuthorisedID.Value = base.LID.ToString();
                txtAuthorised.Text = base.LoginName;
                loadRefundDetails();
                LoadPerformRefundRole();
                LoadCurrency();
                hdnIscreditBill.Value = lstFinalBill[0].IsCreditBill;
                if (lstFinalBill[0].AmountReceived == lstFinalBill[0].AmountRefund && Reftypes == "CAN" && lstFinalBill[0].IsCreditBill=="N")
                {
                    string strcancel = "Current Bill Already Cancelled!!!";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "TASK", "javascript:ValidationWindow('" + strcancel + "','" + strAlert + "');", true);
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading  Refund Details", ex);
            }
        }

        if (AssignTask == "Y")
        {
            foreach (ListItem item in chkAssignTotask.Items)
            {
                item.Selected = true;
				  item.Enabled = false;
                trpnlAssign.Style.Add("display", "block");
                trpnlRefund.Style.Add("display", "none");
                pnlAssign.Style.Add("display", "none"); 
            }
        }
        if (AssignToCreditController == "Y")
        {
            foreach (ListItem item in chkAssignTotask.Items)
            {
                item.Selected = true;
                item.Enabled = false;
                trpnlAssign.Style.Add("display", "block");
                trpnlRefund.Style.Add("display", "none");
                pnlAssign.Style.Add("display", "none");
                Rs_TaskAssignTo.Text = "Task Assign To Credit Controller";
            }
        }

        
        
    }

    #endregion

    #region "Events"

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        hdnOldValues.Value = Request.QueryString["hdn"];
        pathname = "/Billing/HospitalBillSearch.aspx?btype=return&hdnold=" + hdnOldValues.Value;
        Response.Redirect(Request.ApplicationPath + pathname, true);
    }

    protected void grdRefund_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList ddlType = (DropDownList)e.Row.FindControl("ddlType");
            if (lstReasonMaster.Count > 0)
            {
                ddlType.DataSource = lstReasonMaster;
                ddlType.DataTextField = "Reason";
                ddlType.DataValueField = "Reason";
                ddlType.DataBind();
            }
            TextBox t1 = (TextBox)e.Row.FindControl("TxtRfdAmt");
            hdnTemprefAmount.Value = hdnTemprefAmount.Value + t1.ClientID + "~";
            index = e.Row.RowIndex;
            Label lblRefundableAmount = (Label)e.Row.FindControl("lblRefundableAmount");
            TextBox TxtRfdAmt = (TextBox)e.Row.FindControl("TxtRfdAmt");
            string Restrictdue = GetConfigValue("Restrictbills", OrgID);
            decimal RefundableAmt = Convert.ToDecimal(lstBillingDetails[index].Amount - lstBillingDetails[index].DiscountAmount - lstBillingDetails[index].RefundedAmt);
            if (lstBillingDetails[index].DiscountAmount > 0)
            {
                lblRefundableAmount.Text = Convert.ToString(String.Format("{0:0.00}", RefundableAmt));
                if (Restrictdue == "Y")
                {
                    TxtRfdAmt.Text = Convert.ToString(String.Format("{0:0.00}", RefundableAmt));
                    TxtRfdAmt.Enabled = false;
                }
            }
            else
            {
                lblRefundableAmount.Text = Convert.ToString(String.Format("{0:0.00}", (lstBillingDetails[index].Amount - lstBillingDetails[index].RefundedAmt)));
                if (Restrictdue == "Y")
                {
                    TxtRfdAmt.Text = Convert.ToString(String.Format("{0:0.00}", lstBillingDetails[index].Amount));
                    TxtRfdAmt.Enabled = false;
                }
            }
            if (Restrictdue == "Y")//selva
            {
                hdnfullcancel.Value = "Y";
            }
            if (lstBillingDetails[index].Amount == lstBillingDetails[index].RefundedAmt)
            {
                e.Row.Enabled = false;
            }
            if (lstBillingDetails[index].BatchNo=="N")
            {
                CheckBox chkrefund = (CheckBox)e.Row.FindControl("chkRefund");
                chkrefund.Enabled = false;
            }
            if (RefundableAmt == lstBillingDetails[index].RefundedAmt && RefundableAmt == 0)
            {
                e.Row.Enabled = false;
            }
        }
        if (Reftypes == "CAN")
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                CheckBox chselectall = (CheckBox)e.Row.FindControl("chkSelectAll");
                //chselectall.Visible = true;
            }
            //e.Row.Cells[4].Style.Add("display", "none");
            e.Row.Cells[5].Style.Add("display", "none");
            e.Row.Cells[6].Style.Add("display", "none");
           // e.Row.Enabled = true;
            if (lstBillingDetails[index].Amount == lstBillingDetails[index].RefundedAmt)
            {
                e.Row.Enabled = false;
            }
        }
    }

    protected void btnRefund_Click(object sender, EventArgs e)
    {
        SaveRefundDetails();
    }

    #endregion

    #region "Methods"

    void loadRefundDetails()
    {
        lstBillingDetails = new List<BillingDetails>();
        lstFinalBill = new List<FinalBill>();
        Int64.TryParse(Request.QueryString["bid"], out pFinalBillid);
        lstReasonMaster = new List<ReasonMaster>();
        objReasonMaster = new Master_BL(base.ContextInfo);
        returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);
        billingBL.GetFinalbillRefundDetails(vid, pFinalBillid, OrgID, out lstBillingDetails, out lstFinalBill);
        grdRefund.DataSource = lstBillingDetails;
        grdRefund.DataBind();

        if (lstFinalBill.Count > 0)
        {
            //Vijayalakshmi.M
            string age = string.Empty;
            string gender = string.Empty;
            string[] splityears = lstFinalBill[0].PatientAge.Split(' ');
            string gender1 = lstFinalBill[0].Comments;
            if (splityears[1] == "Year(s)")
            {
                //splityears[0] = tempyears[1] + "/" + strMale;
                age = splityears[0] + " " + strYear;
            }
            else if (splityears[1] == "Day(s)")
            {
                age = splityears[0] + " " + strDay;
            }
            else if (splityears[1] == "Months(s)")
            {
                age = splityears[0] + " " + strMonth;
            }
			  else if (splityears[1] == "UnKnown")
            {
                age = splityears[0] + " " + strUnknownF;
            }
            else
            {
                age = splityears[0] + " " + strYear;
            }
            if (gender1 == "Male")
            {
                gender = strMale;
            }
            else if (gender1 == "Female")
            {
                gender =strFemale;
            }
			else if (gender1 == "UnKnown")
            {
                gender = strUnknownF;
            }
            else if (gender1 == "NA")
            {
                gender = strNA;
            }
            else
            {
                gender = strMale;
            }
            lstFinalBill[0].Comments = gender;
            lstFinalBill[0].PatientAge = age;
            //End
            if (lstFinalBill[0].IsFreeOfCost == "Y")
            {
                IsCopayment.Value = Convert.ToString(lstFinalBill[0].IsFreeOfCost);
            }
            else { IsCopayment.Value = Convert.ToString(lstFinalBill[0].IsFreeOfCost); }
            // Cancel Restriction -- Seetha //

            hdnCancelRestriction.Value = Convert.ToString(lstFinalBill[0].IsFoc);

            // Cancel Restriction -- Seetha //
            lblPatientNo.Text = lstFinalBill[0].PatientNo;
            lblName.Text = lstFinalBill[0].Name;
            labAge.Text = lstFinalBill[0].PatientAge;
            lalSex.Text = lstFinalBill[0].Comments;
            lblInvoiceNo.Text = lstFinalBill[0].BillNumber;
            lalBillDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yyyy");
            lalBilledBy.Text = lstFinalBill[0].BilledBy;
            lblTotAmtReceived.Text = lstFinalBill[0].AmountReceived.ToString("0.00");
            lblTotAmtRefunded.Text = lstFinalBill[0].AmountRefund.ToString();
            lblRefundableAmt.Text = lstFinalBill[0].NetValue.ToString();
            lbltxtDueAmt.Text = lstFinalBill[0].Due.ToString();
            lbltxtDiscountAmt.Text = lstFinalBill[0].DiscountAmount.ToString();
            hdnHashealthcoupon.Value = lstFinalBill[0].ClientName.ToString();
            hdnCollectionID.Value = lstFinalBill[0].CollectionID.ToString();
            if (Reftypes == "CAN")
            {
                RefundtoPatient.Style.Add("display", "table-cell");
                if (lstFinalBill[0].IsCreditBill == "N")
                {
                    chbRefundPatient.Checked = true;
                }
                if (lstFinalBill[0].IsCreditBill == "Y")
                {
                    chbRefundPatient.Checked = false;
                    chbRefundPatient.Enabled = false;
                }
                if (lstFinalBill[0].Due > 0)
                {
                    chbRefundPatient.Checked = true;
                    chbRefundPatient.Enabled = false;
                }

                if (IsCancelRefund == "Y")
                {

                    RefundtoPatient.Style.Add("display", "none");

                }
                else
                {
                    RefundtoPatient.Style.Add("display", "table-cell");
                }
            }
            if (lstFinalBill[0].Due > 0 || Reftypes == "CAN")
            {
                rblPaymode.Items[2].Enabled = false;
            }
        }
    }

    private void LoadPerformRefundRole()
    {
        int TaskActionID = -1;
        List<Role> lstRole = new List<Role>();
        TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PerformRefund);
        rolebl.GetPerformRefundRole(OrgID, TaskActionID, out lstRole);
        int flag = 0;
        decimal curAmount;
        lblCurName.Text = CurrencyName;
        if (lstRole.Count > 0)
        {
            for (int i = 0; i < lstRole.Count; i++)
            {
                if (RoleName == lstRole[i].RoleName)
                {
                    flag = 1;
                }
            }
        }
        if (flag == 0 && lstRole.Count == 0)
        {
            pnlAssign.Visible = false;
        }
        if (flag == 0 && lstRole.Count > 0)
        {
            pnlAssign.Visible = true;
            curAmount = Convert.ToDecimal(lblTotAmtReceived.Text.ToString()) - Convert.ToDecimal(lblTotAmtRefunded.Text.ToString());
            trTaskAssign.Attributes.Add("display", "block");

            chkAssignTotask.DataSource = lstRole;
            //chkAssignTotask.DataTextField = "Description";
            chkAssignTotask.DataTextField = "RoleName";
            chkAssignTotask.DataValueField = "RoleID";
            chkAssignTotask.DataBind();

            if (pathname == "Y")
            {
                foreach (ListItem item in chkAssignTotask.Items)
                {
                    item.Selected = true;
                    item.Enabled = false;
                }
                trpnlAssign.Style.Add("display", "block");
                trpnlRefund.Style.Add("display", "none");
                pnlAssign.Style.Add("display", "none");
            }
        }

    }

    private void LoadCurrency()
    {
        objReasonMaster.GetCurrencyOrgMapping(OrgID, out lstCurrOrgMap);
        ddlBaseCurrency.DataSource = lstCurrOrgMap;
        ddlBaseCurrency.DataTextField = "CurrencyName";
        ddlBaseCurrency.DataValueField = "CurrencyID";
        ddlBaseCurrency.DataBind();
        for (int i = 0; i < lstCurrOrgMap.Count; i++)
        {
            if (lstCurrOrgMap[i].IsBaseCurrency == "Y")
            {
                ddlBaseCurrency.SelectedValue = lstCurrOrgMap[i].CurrencyID.ToString();
                //hdnBaseCurrencyID.Value = lstCurrOrgMap[i].CurrencyID.ToString();
            }
        }

    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - AmountclosureDebitDetails.aspx", ex);
        }
        return configValue;
    }

    public void ApproveTaskCreation()
    {
        try
        {
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            returnCode = -1;
            long taskreturncode = -1;
            string gUID = string.Empty;
            long createTaskID = -1;
            Investigation_BL DemoBL;
            Tasks task = new Tasks();
            DemoBL = new Investigation_BL(base.ContextInfo);
            Int64.TryParse(Request.QueryString["vid"], out vid);
            Int64.TryParse(Request.QueryString["pid"], out patientID);

            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            if (lstPatientVisitDetails.Count > 0)
            {
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
                int validatedCount = 0;
                validatedCount = (from IL in lstPatientInvestigation
                                  where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                  && IL.Status != InvStatus.SecondOpinion && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Cancel
                                  && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                  && IL.Status != InvStatus.Notgiven && IL.Status != InvStatus.WithholdValidation && IL.Status != "ReflexTest"
                                  && IL.Status != InvStatus.Rejected
                                  select IL).Count();
                if (validatedCount <= 0)
                {
                    int NeedvalidatedCount = 0;
                    NeedvalidatedCount = (from IL in lstPatientInvestigation
                                          where IL.Status == "PartiallyValidated" || IL.Status == InvStatus.Validate
                                          select IL).Count();
                    if (NeedvalidatedCount > 0)
                    {
                        taskreturncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                vid, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                lstPatientInvestigation[0].UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = vid;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = lstPatientInvestigation[0].LabNo;
                        //Create task 

                        taskreturncode = oTasksBL.CreateTask(task, out createTaskID);
                    }
                }
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error in while Cancel bill Approve Task Cretaion", e);
        }

    }

    public void SaveRefundDetails()
    {
        string strAlert = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert;
        string strCash = Resources.Patient_ClientDisplay.Patient_RefundtoPatient_aspx_01 == null ? "Cash" : Resources.Patient_ClientDisplay.Patient_RefundtoPatient_aspx_01;
        string strCheque = Resources.Patient_ClientDisplay.Patient_RefundtoPatient_aspx_02 == null ? "Cheque" : Resources.Patient_ClientDisplay.Patient_RefundtoPatient_aspx_02;
        string strCancelBillingItem = Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_01 == null ? "Cancel BillItems  successfully" : Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_01;
        string strReFund = Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_11 == null ? "Refund successfully" : Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_11;
        string strAssignTo = Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_12 == null ? "Task Assigned to" : Resources.Patient_AppMsg.Patient_RefundtoPatient_aspx_12;
        try
        {
            Reftypes = Request.QueryString["btype"];
            long returncode = -1;
            int RefundStatus = 0;
            int flag = 0;
            string TaskAssign = "";
            long billdetailID = 0;
            foreach (ListItem item in chkAssignTotask.Items)
            {
                if (item.Selected == true)
                {
                    flag = 1;
                    TaskAssign = item.Text; 
                    break;
                }
            }
            List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();

            Int64.TryParse(Request.QueryString["bid"], out pFinalBillid);//
            foreach (GridViewRow grdRef in grdRefund.Rows)
            {
                if (((CheckBox)grdRef.FindControl("chkRefund")).Checked == true)
                {
                    AmountRefundDetails AmountRefund = new AmountRefundDetails();
                    string PrimaryKey = grdRefund.DataKeys[grdRef.RowIndex].Values["BillingDetailsID"].ToString();
                    Label lblAmount = (Label)grdRef.FindControl("lblAmount");
                    TextBox txtRAmount = (TextBox)grdRef.FindControl("TxtRfdAmt");
                    DropDownList txtRReason = (DropDownList)grdRef.FindControl("ddlType");
                    Label lblRefundedAmt = (Label)grdRef.FindControl("lblRfdAmt");
                    Label lbDescription = (Label)grdRef.FindControl("lblDescription");
                    TextBox txtComments = (TextBox)grdRef.FindControl("txtComments");
                    Label lblRefundableAmount = (Label)grdRef.FindControl("lblRefundableAmount");
                    billdetailID = Convert.ToInt64(PrimaryKey);
                    string Reason = txtRReason.SelectedValue;
                    string comments = txtComments.Text;
                    decimal txtRfdAmt = Convert.ToDecimal(txtRAmount.Text == "" ? "0" : txtRAmount.Text);
                    if (txtRfdAmt > 0 || Reftypes == "CAN")
                    {
                        AmountRefund.FinalBillID = pFinalBillid;
                        AmountRefund.BillingDetailsID = billdetailID;
                        AmountRefund.AmtRefund = txtRfdAmt;
                        if (Reftypes == "CAN")
                        {
                            AmountRefund.AmtRefund = Convert.ToDecimal(lblRefundableAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);//Convert.ToDecimal(lblAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);
                            AmountRefund.TranCurrencyAmount = Convert.ToDecimal(lblRefundableAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);// Convert.ToDecimal(lblAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);
                            AmountRefund.CancelAmount = Convert.ToDecimal(lblRefundableAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);//Convert.ToDecimal(lblAmount.Text) - Convert.ToDecimal(lblRefundedAmt.Text);
                        }
                        else
                        {
                            AmountRefund.CancelAmount = txtRfdAmt;
                        }
                        AmountRefund.TranCurrencyAmount = txtRfdAmt;
                        AmountRefund.OrgID = OrgID;
                        AmountRefund.CreatedBy = LID;

                        AmountRefund.RefundType = Reftypes != "CAN" ? "REFUND" : "CANCEL";
                        AmountRefund.RefundBy = LID;
                        if (flag == 0)
                        {
                            RefundStatus = 0;
                            AmountRefund.RefundStatus = "Closed";
                        }
                        else
                        {
                            RefundStatus = 1;
                            AmountRefund.RefundStatus = "Pending";
                        }
                        AmountRefund.RefundType = Reftypes != "CAN" ? "REFUND" : "CANCELLED";
                        AmountRefund.Comments = comments;
                        AmountRefund.ReasonforRefund = Reason;
                        AmountRefund.ApprovedBy = LID;
                        AmountRefund.AuthorisedBy = Convert.ToInt32(hdnAuthorisedID.Value);
                        if (rblPaymode.SelectedItem.Text == strCash.Trim())
                        {
                            AmountRefund.PaymentTypeID = 1;
                        }
                        else if (rblPaymode.SelectedItem.Text == strCheque.Trim())
                        {
                            AmountRefund.PaymentTypeID = 2;
                            if (txtNumber.Text != "")
                            {
                                AmountRefund.ChequeNo = Convert.ToInt64(txtNumber.Text);
                            }
                            else
                            {
                                AmountRefund.ChequeNo = 0;
                            }
                            AmountRefund.BankName = txtBankType.Text;
                            AmountRefund.Remarks = txtRemarks.Text;
                        }
                        else if (rblPaymode.SelectedItem.Text == "Credit Note")
                        {
                            AmountRefund.PaymentTypeID = 11;
                            if (txtNumber.Text != "")
                            {
                                AmountRefund.ChequeNo = Convert.ToInt64(txtNumber.Text);
                            }
                            else
                            {
                                AmountRefund.ChequeNo = 0;
                            }
                            AmountRefund.BankName = txtBankType.Text;
                            AmountRefund.Remarks = txtRemarks.Text;
                        }
                        else
                        {
                            AmountRefund.PaymentTypeID = 11;
                        }
                        lstAmountRefundDetails.Add(AmountRefund);
                    }
                }
            }
            if (lstAmountRefundDetails.Count > 0)
            {
                if (Reftypes == "CAN")
                {
                    if (chbRefundPatient.Checked == true)
                    {
                        RefFlag = "Y";
                    }
                    else
                    {
                        RefFlag = "N";
                    }
                }
                List<BillingDetails> lstBillingdetails = new List<BillingDetails>();
                returncode = billingBL.insertAmtRefundDetails(lstAmountRefundDetails, RefFlag, out RefundNo, RefundStatus, OrgID, out lstBillingdetails, Convert.ToInt64(hdnCollectionID.Value));
                if (returncode==0)
                {
                    long patientVisitID = lstBillingdetails[0].VisitID;
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PageID = Convert.ToInt64(PageID);
                    PC.ButtonName = "btnRefund";
                    PC.ButtonValue = "Submit";
                    PC.ActionType = "LISOrdered";
                    PC.PatientID = patientID;
                    PC.PatientVisitID = patientVisitID;
                    lstpagecontextkeys.Add(PC);
                    long res = -1;                 
                    res = AM.PerformingNextStepNotification(PC, "", "");     
                }

                if (returncode == 0)
                {
                    hdnOldValues.Value = Request.QueryString["hdn"];

                    pathname = "../Billing/HospitalBillSearch.aspx?btype=return&hdnold=" + hdnOldValues.Value;
                    hdnOldValues.Value = pathname;

                    if (Reftypes == "CAN")
                    {
                        ApproveTaskCreation();
                    }
                    if (flag > 0)
                    {
                        string FeeType = Reftypes != "CAN" ? "RFD" : "CAL";
                        CreateTask(FeeType);
                       // ScriptManager.RegisterStartupScript(Page, GetType(), "TASK", "javascript:ValidationWindowCustom1('" + strAssignTo.Trim() + "','" + TaskAssign + "')", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "TASK", "javascript:ValidationWindowCustom1('" +strAssignTo.Trim()+" "+ TaskAssign + "','" + strAlert + "','" + Convert.ToString(hdnOldValues.Value) + "')", true);
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "TASK", "alert('" + strAssignTo.Trim() + " " + TaskAssign + "');", true);
                      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "redirect('" + Convert.ToString(hdnOldValues.Value) + "')", true);
                        trpnlRefund.Style.Add("display", "none");
                        trpnlAssign.Style.Add("display", "block");
                        pnlAssign.Style.Add("display", "none");
                        btnTask.Enabled = false;
                    }
                    else if (Reftypes != "CAN")
                    {
                        trpnlRefund.Style.Add("display", "block");
                        pnlAssign.Style.Add("display", "none");
                        trTaskAssign.Style.Add("display", "none");
                        btnRefund.Enabled = false;
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Refund", "alert('" + strReFund.Trim() + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Refund", "javascript:ValidationWindow('" + strReFund.Trim() + "','" + strAlert + "')", true);
                        string bType = "REF";
                        string BID = "";
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Refund", "alert('" + strReFund.Trim() + "');", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Refund", "javascript:ValidationWindowCustom('" + strReFund.Trim() + "','" + strAlert + "','" + billno.ToString() + "','" + lblCurrChange.Text + "','" + lblName.Text.ToString() + "','" + PatientNumber.ToString() + "','" + lblCurrChange.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "','" + bType + "','" + BID.ToString() + "','" + Convert.ToString(hdnOldValues.Value) + "')", true);
                        
                      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "getMessage('" + billno.ToString() + "','" + lblCurrChange.Text + "','" + lblName.Text.ToString() + "','" + PatientNumber.ToString() + "','" + lblCurrChange.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "','" + bType + "','" + BID.ToString() + "','" + Convert.ToString(hdnOldValues.Value) + "')", true);
                    }
                    else
                    {
                        long patientVisitID = 0;
                        trpnlRefund.Style.Add("display", "block");
                        pnlAssign.Style.Add("display", "none");
                        trTaskAssign.Style.Add("display", "none");
                        btnRefund.Enabled = false;
                        string bType = "CAN";
                        string BID = "";

                        if (lstBillingdetails.Count > 0)
                        {
                            patientVisitID = lstBillingdetails[0].VisitID;
                            if (!String.IsNullOrEmpty(lstBillingdetails[0].BatchNo) && hdnHashealthcoupon.Value == "Y")
                            {
                                long PatientID = -1;
                                PatientID = lstBillingdetails[0].PatientID;


                                new BarcodeHelper().SaveReportBarcode(patientVisitID, OrgID, lstBillingdetails[0].VersionNo, "PVN");
                                if (!String.IsNullOrEmpty(lstBillingdetails[0].BatchNo) && lstBillingdetails[0].FeeId != 0)
                                {
                                    new BarcodeHelper().SaveReportBarcode(lstBillingdetails[0].FeeId, OrgID, lstBillingdetails[0].BatchNo, "HCNO");

                                }
                            }
                        }
                        string strSsrsShowReport = string.Empty;
                        strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);

                        ScriptManager.RegisterStartupScript(Page, GetType(), "Refund", "javascript:ValidationWindowCustom('" + strCancelBillingItem.Trim() + "','" + strAlert + "','" + billno.ToString() + "','" + lblCurrChange.Text + "','" + lblName.Text.ToString() + "','" + PatientNumber.ToString() + "','" + lblCurrChange.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "','" + bType + "','" + BID.ToString() + "','" + Convert.ToString(hdnOldValues.Value) + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Refund", "javascript:ValidationWindow('" + strCancelBillingItem.Trim() + "','" + strAlert + "');", true);
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Refund", "alert('" + strCancelBillingItem.Trim() + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "getMessage('" + billno.ToString() + "','" + lblCurrChange.Text + "','" + lblName.Text.ToString() + "','" + PatientNumber.ToString() + "','" + lblCurrChange.ToString() + "','" + RefundNo.ToString() + "','" + vid.ToString() + "','" + patientID.ToString() + "','" + bType + "','" + BID.ToString() + "','" + Convert.ToString(hdnOldValues.Value) + "')", true);
                        if (strSsrsShowReport == "Y")
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenIframe('" + pFinalBillid.ToString() + "','" + patientVisitID.ToString() + "');", true);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void CreateTask(string FeeType)
    {

        try
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            Int64.TryParse(Request.QueryString["vid"], out vid);
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
            sPatientName = Request.QueryString["pname"];
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            long AssingTo = -1;
            int otherID = 0;
            task = new Tasks();
            dText = new Hashtable();
            urlVal = new Hashtable();
            long ptaskID = -1;
            long TaskActionID = -1;
            Reftypes = Request.QueryString["btype"];
            if (FeeType == "RFD")
                TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.PerformRefund);
            else if (FeeType == "CAL")

                TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.PerformCancel);
            returnCode = Utilities.GetHashTable(TaskActionID, vid, LID, patientID,
                                    sPatientName, "", otherID, "", 0, "", ptaskID, FeeType, out dText, out urlVal,
                                    RefundNo, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskActionID);
            task.DispTextFiller = dText;
            urlVal.Add("RefFlag", RefFlag);
            task.URLFiller = urlVal;
            task.PatientID = patientID;
            foreach (ListItem item in chkAssignTotask.Items)
            {
                if (item.Selected == true)
                {
                    AssingTo = Int64.Parse(item.Value);
                }
            }

            task.RoleID = AssingTo;
            task.OrgID = OrgID;
            task.PatientVisitID = vid;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            taskBL = new Tasks_BL(base.ContextInfo);
            returnCode = taskBL.CreateTask(task, out taskID);
        }
        catch (Exception ex)
        {

        }
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "refundmode";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "refundmode"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblPaymode.DataSource = childItems;
                    rblPaymode.DataTextField = "DisplayText";
                    rblPaymode.DataValueField = "Code";
                    rblPaymode.DataBind();
                    rblPaymode.SelectedIndex = 0;

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    #endregion
}



