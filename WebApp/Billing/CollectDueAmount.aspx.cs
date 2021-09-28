using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Podium.PerformingNextAction;
using System.Data;
using System.Collections;

public partial class Billing_CollectDueAmount : BasePage
{
    public Billing_CollectDueAmount()
        : base("Billing_CollectDueAmount_aspx")
    {
    }
    long patientID = -1;
    string patientNumber = string.Empty;
    string patientName = string.Empty;
    string vType = string.Empty;
    long patientVisitID;
    string dischargeStatus = string.Empty;
    string strPatientName = "";
    string strDOB = "";
    string inPatientNo = "";
    string strCellNo = "";
    string strRoomNo = "";
    string strPurpose = "";
    string ipNo = string.Empty;
    string BillNumber = string.Empty;
    long TaskAssignd = 0;

    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    DateTime dtFrom = DateTime.MaxValue; //Convert.ToDateTime(new BasePage().OrgDateTimeZone), 
    DateTime dtTo = DateTime.MaxValue;// Convert.ToDateTime(new BasePage().OrgDateTimeZone);

    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
   string AlertType = Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_Alert;
    string duealert = Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_12 == null ? "Collect Due payment not done" : Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_12;
    string select = Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_13 == null ? "--select--" : Resources.Billing_AppMsg.Billing_CollectDueAmount_aspx_13;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                loadDueItems();
                LoadReasonList();
                LoadPerformRole();
                AutoAuthorizer.ContextKey = OrgID.ToString();
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load Due Clearance", ex);
        }
    }
    private void loadDueItems()
    {
        txtGross.Text = "0.00";
        txtGrandTotal.Text = "0.00";
        string BillNo = "";
        long visitID = 0;
        long PID = 0;
        if (Request.QueryString["PID"] != null)
        {
            PID = Convert.ToInt64(Request.QueryString["PID"]);
        }
        if (Request.QueryString["PatNum"] != null)
        {
            patientNumber = Convert.ToString(Request.QueryString["PatNum"]);
        }
        if (Request.QueryString["Bno"] != null)
        {
            BillNo = Convert.ToString(Request.QueryString["Bno"]);
        }
        if (Request.QueryString["PName"] != null)
        {
            patientName = Request.QueryString["PName"];
        }

        if (Request.QueryString["tid"] != null)
        {
            TaskAssignd = Convert.ToInt32(Request.QueryString["tid"]);
        }
        string sPaymentType = "";
        if (Request.QueryString["PTYPE"] != null)
        {
            sPaymentType = Request.QueryString["PTYPE"].ToString();
        }
        if (Request.QueryString["FDate"] != null)
            DateTime.TryParse(Request.QueryString["fDate"], out dtFrom);
        if (Request.QueryString["TDate"] != null)
            DateTime.TryParse(Request.QueryString["TDate"], out dtTo);
        BillingEngine BE = new BillingEngine(base.ContextInfo);
        List<PatientDueDetails> dueDetails = new List<PatientDueDetails>();
        string pLocation = string.Empty;
        string pVisitNumber = string.Empty;
        BE.getpatientduedetails(patientNumber, BillNo, patientName, OrgID, 0, dtFrom, dtTo, pLocation, pVisitNumber, out dueDetails);


        gvDueDetails.DataSource = dueDetails;
        gvDueDetails.DataBind();

        trAmtDetails.Attributes.Add("display", "block");
        hdnYesData.Value = "1";
        YesData.Visible = true;

        txtGrandTotal.Text = txtGross.Text;
    }


    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    public long loadDueDetail(long orgID, long patientID,
        long patientVisitID, out long finalBillID,
        out List<FinalBill> lstDueDetail, out string VisitType)
    {

        long returnCode = -1;
        lstDueDetail = new List<FinalBill>();
        VisitType = "";

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetDueDetails(orgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out VisitType);

        return returnCode;
    }


    public void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string strHealthCoupon = string.Empty;
            long visitID = 0;
            long patientID = 0;
            string grand = txtGrandTotal.Text;
            decimal FinalAmount = 0;
            long FinalBillID = 0;
            decimal PaidAmt = 0;
            decimal AmtReceived = 0;
            string PName = "";
            string VisitType;
            string BillNo = string.Empty;
            int specialityid, followup;
            long PatientDueID = 0;
            long PatientVID = -1;
            long returnCode = -1;
            long TaskID = 0;
            HiddenField hdnHasHealthCard1 = new HiddenField();
            List<PatientDueDetails> lstPatientDueDetails = new List<PatientDueDetails>();
            List<DuePaidDetail> lstPaidDueDetails = new List<DuePaidDetail>();
            List<BillingDetails> lstBillingdetails = new List<BillingDetails>();
            DateTime Datetime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            List<FinalBill> lstDueDetail = new List<FinalBill>();
            decimal pAmtReceived = Convert.ToDecimal(hdnAmountReceived.Value.ToString());
            decimal pAmountReceived = pAmtReceived; //+PreviousAmountReceived;

            decimal pDue = 0;
            decimal ExisDue = 0;

            foreach (GridViewRow row in gvDueDetails.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect.Checked)
                {
                    PatientDueDetails PatientDueDetail = new PatientDueDetails();
                    DuePaidDetail duepaid = new DuePaidDetail();
                    HiddenField hdnPatientID = (HiddenField)row.FindControl("hdnPatientID");
                    HiddenField hdnPatientDueID = (HiddenField)row.FindControl("hdnPatientDueID");
                    HiddenField hdnVisiID = (HiddenField)row.FindControl("hdnVisiID");
                    HiddenField hdnFinalBillID = (HiddenField)row.FindControl("hdnFinalBillID");
                    TextBox txtPayingAmt = (TextBox)row.FindControl("txtPayingAmt");
                    TextBox txtDiscounts = (TextBox)row.FindControl("txtDiscountAmt");
                    //Label lblWriteOffAmt = (Label)row.FindControl("lblWriteOffAmt");
                    HiddenField hdnWriteOffAmt = (HiddenField)row.FindControl("hdnWriteOffAmt");
                    HiddenField hdnDiscountTotal = (HiddenField)row.FindControl("hdnDiscountedAmount");
                    PatientDueDetail.PatientNumber = row.Cells[1].Text;
                    PatientDueDetail.BillNo = Convert.ToString(row.Cells[2].Text);
                    PatientDueDetail.PatientName = row.Cells[3].Text;
                    hdnHasHealthCard1 = (HiddenField)row.FindControl("hdnHasHealthCard");

                    PatientDueDetail.PatientDueID = Convert.ToInt64(hdnPatientDueID.Value);
                    PatientDueDetail.PatientID = Convert.ToInt64(hdnPatientID.Value);
                    PatientDueDetail.FinalBillID = Convert.ToInt64(hdnFinalBillID.Value);
                    PatientDueDetail.VisitID = Convert.ToInt64(hdnVisiID.Value);
                    PatientDueDetail.DueAmount = Convert.ToDecimal(row.Cells[4].Text);
                    PatientDueDetail.DuePaidAmt = Convert.ToDecimal(txtPayingAmt.Text);
                    ExisDue = Convert.ToDecimal(txtPayingAmt.Text) + Convert.ToDecimal(txtDiscounts.Text);
                    if (Convert.ToDecimal(row.Cells[4].Text) == ExisDue || Convert.ToDecimal(hdnWriteOffAmt.Value) > 0)
                    {
                        PatientDueDetail.Status = "Closed";
                    }
                    else
                    {
                        PatientDueDetail.Status = "Open";
                    }
                    PatientDueDetail.ExistingDue = Convert.ToDecimal(row.Cells[4].Text) - Convert.ToDecimal(txtPayingAmt.Text) - Convert.ToDecimal(txtDiscounts.Text);
                    PatientDueDetail.OrgID = OrgID;
                    PatientDueDetail.WriteOffAmt = Convert.ToDecimal(hdnWriteOffAmt.Value);
                    lstPatientDueDetails.Add(PatientDueDetail);
                    patientName = row.Cells[3].Text;
                    patientID = Convert.ToInt64(hdnPatientID.Value);
                    patientNumber = Convert.ToString(row.Cells[1].Text);
                    visitID = Convert.ToInt64(hdnVisiID.Value);
                    FinalBillID = Convert.ToInt64(hdnFinalBillID.Value);
                    PaidAmt = Convert.ToDecimal(row.Cells[5].Text);
                    PName = row.Cells[3].Text;
                    BillNo = Convert.ToString(row.Cells[2].Text);
                    PatientDueID = Convert.ToInt64(hdnPatientDueID.Value);
                    duepaid.DueBillNo = Convert.ToInt64(hdnFinalBillID.Value);
                    duepaid.DueBillDate = Datetime;
                    //duepaid.BillAmount = FinalAmount;
                    duepaid.PaidAmount = Convert.ToDecimal(txtPayingAmt.Text);
                    duepaid.PaidDate = Datetime;
                    duepaid.PatientName = PName.ToString();
                    duepaid.DueCollectedBy = LID;
                    duepaid.PatientNumber = patientNumber.ToString();
                    duepaid.DiscountAmt = Convert.ToDecimal(txtDiscounts.Text) ;//+ Convert.ToDecimal(hdnDiscountTotal.Value);
                    lstPaidDueDetails.Add(duepaid);
                }


            }

            txtGross.Text = FinalAmount.ToString();
            hdnAmountReceived.Value = hdnAmountReceived.Value == "" ? "0" : hdnAmountReceived.Value;
            AmtReceived = txtAmountRecieved.Text == "" ? 0 : Convert.ToDecimal(txtAmountRecieved.Text);



            if (pAmountReceived == FinalAmount)
            {
                pDue = 0;
            }
            else
            {
                pDue = FinalAmount - pAmountReceived;
            }


            decimal dServiceCharge = 0;
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            dServiceCharge += Convert.ToDecimal(hdnTempService.Value);
            System.Data.DataTable dtAmtReceivedDetails = new System.Data.DataTable();
            dtAmtReceivedDetails = PaymentType.GetAmountReceivedDetails();


            string PayerType = string.Empty;
            string TPAPaymentStatus = string.Empty;
            string DiscountReason = string.Empty;
            long DiscountAuthorisedBy = 0;
            if (ddlDiscountReason.SelectedValue != "0")
            {
                DiscountReason = ddlDiscountReason.SelectedItem.Text;
            }
            if (hdnDiscountApprovedBy.Value != "0")
            {
                DiscountAuthorisedBy = Convert.ToInt64(hdnDiscountApprovedBy.Value);
            }
            PayerType = "Patient";
            TPAPaymentStatus = "Pending";
            List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();

            lstUsage = DepositUsageCtrl.GetDepositUsage();

            ANC_BL ancBL = new ANC_BL(base.ContextInfo);
            ancBL.GetANCSpecilaityID(visitID, out specialityid, out followup);
            loadDueDetail(OrgID, patientID, visitID, out FinalBillID, out lstDueDetail, out VisitType);
            string strHasHealthCard = "Y";
            string ReceiptNo = string.Empty;
            returnCode = new BillingEngine(base.ContextInfo).SavePatientDueDetails(patientID, OrgID, ILocationID, 10,
                                                                          LID, "Due Collection",
                                                                          Convert.ToDecimal(hdnChangedGrandValue.Value),
                                                                          lstPaidDueDetails, dtAmtReceivedDetails,
                                                                          pAmountReceived, LID, visitID, FinalBillID, dServiceCharge,
                                     lstPatientDueDetails, lstUsage, out BillNumber, out PatientVID, DiscountReason, DiscountAuthorisedBy, out lstBillingdetails, out ReceiptNo);

            if (lstBillingdetails.Count > 0)
            {
                long PatientID = -1;
                PatientID = lstBillingdetails[0].PatientID;
                patientVisitID = lstBillingdetails[0].VisitID;

                new BarcodeHelper().SaveReportBarcode(patientVisitID, OrgID, lstBillingdetails[0].VersionNo, "PVN");
                if (!String.IsNullOrEmpty(lstBillingdetails[0].BatchNo) && lstBillingdetails[0].FeeId != 0)
                {
                    new BarcodeHelper().SaveReportBarcode(lstBillingdetails[0].FeeId, OrgID, lstBillingdetails[0].BatchNo, "HCNO");
                    strHasHealthCard = "Y";
                }

                if (Request.QueryString["BKNO"] != null)
                {
                    long BKNO = Convert.ToInt64(Request.QueryString["BKNO"]);
                    if (patientVisitID > 0)
                    {
                        string status = string.Empty;
                        status = "R";
                        new Investigation_BL(base.ContextInfo).UpdateHomeCollectiondetails(BKNO, patientVisitID, status, PatientID);
                    }
                }

            }

            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            PageContextDetails.PatientID = patientID;
            PageContextDetails.PatientVisitID = PatientVID;
            if (BillNumber != null && BillNumber != "")
            {
                PageContextDetails.FinalBillID = Convert.ToInt64(BillNumber);
            }
            else
            {
                PageContextDetails.FinalBillID = 0;
            }
            PageContextDetails.BillNumber = BillNumber.ToString();
            PageContextDetails.ID = LID;// Assign OrgAdressID
            ActionManager objActionManager = new ActionManager(base.ContextInfo);
            objActionManager.PerformingNextStepNotification(PageContextDetails, "", "");
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out TaskID);
                new Tasks_BL(base.ContextInfo).UpdateTask(TaskID, TaskHelper.TaskStatus.Completed, UID);
            }
            OtherCurrencyDisplay1.GetOtherCurrRecd(out pAmountReceived);
            //Response.Redirect("../Billing/ViewDueDetails.aspx?PNO=" + patientNumber + "&Bno=" + BillNo + "&PNam=" + patientName + "&vid=" + visitID + "&pid=" + patientID + "&bid=" + FinalBillID + "&DueID=" + PatientDueID +"&FBNo=" + BillNumber, true);

            System.Data.DataTable dt1 = new DataTable();
            DataColumn Col1 = new DataColumn("Content");
            DataColumn col2 = new DataColumn("Status");
            DataColumn Col3 = new DataColumn("NotificationID");
            DataColumn Col4 = new DataColumn("ClientID");
            DataColumn Col5 = new DataColumn("InvoiceID");
            DataColumn Col6 = new DataColumn("Seq_Num");
            DataColumn Col7 = new DataColumn("Category");
            DataColumn Col8 = new DataColumn("FromDate");
            DataColumn Col9 = new DataColumn("TODate");
            DataColumn Col10 = new DataColumn("ReportPath");
            DataColumn Col11 = new DataColumn("OrgID");
            DataColumn Col12 = new DataColumn("OrgAddressID");
            //add columns
            dt1.Columns.Add(Col1);
            dt1.Columns.Add(col2);
            dt1.Columns.Add(Col3);
            dt1.Columns.Add(Col4);
            dt1.Columns.Add(Col5);
            dt1.Columns.Add(Col6);
            dt1.Columns.Add(Col7);
            dt1.Columns.Add(Col8);
            dt1.Columns.Add(Col9);
            dt1.Columns.Add(Col10);
            dt1.Columns.Add(Col11);
            dt1.Columns.Add(Col12);

            byte[] byte1 = new byte[byte.MinValue];
            Report_BL objReportBL = new Report_BL();
            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("Content");
            DataColumn dbCol2 = new DataColumn("TemplateID");
            DataColumn dbCol3 = new DataColumn("Status");
            DataColumn dbCol4 = new DataColumn("ReportPath");
            DataColumn dbCol5 = new DataColumn("AccessionNumber");
            DataColumn dbCol6 = new DataColumn("NotificationID");
            DataColumn dbCol7 = new DataColumn("VisitID");
            DataColumn dbCol8 = new DataColumn("Seq_Num");
            DataColumn dbCol9 = new DataColumn("OrgID");
            DataColumn dbCol10 = new DataColumn("OrgAddressID");
            //add columns
            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            dt.Columns.Add(dbCol7);
            dt.Columns.Add(dbCol8);
            dt.Columns.Add(dbCol9);
            dt.Columns.Add(dbCol10);
            DataRow dr;
            dr = dt.NewRow();
            dr["Content"] = byte1;
            dr["TemplateID"] = 0;
            dr["Status"] = "DueAmount";
            dr["ReportPath"] = "";
            dr["AccessionNumber"] = "";
            dr["NotificationID"] = "";
            dr["VisitID"] = visitID;
            dr["Seq_Num"] = 0;
            dr["OrgID"] = OrgID;
            dr["OrgAddressID"] = OrgID;
            dt.Rows.Add(dr);
            objReportBL.UpdateNotification(dt, dt1);
            if (returnCode >= 0)
            {
                //string strSsrsShowReport = string.Empty;
                //strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);

                //if (strSsrsShowReport == "Y")
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenIframe('" + FinalBillID.ToString() + "','" + visitID.ToString() + "');", true);
                //}
                //else
                //{
                    string Path = "../InPatient/PrintReceiptPage.aspx?rcptno=" + ReceiptNo + "&PID=" + patientID.ToString() + "&VID=" + visitID.ToString() + "&orgId=" + OrgID + "&pDet=Due collection&IsPopup=Y";
                    Page.RegisterStartupScript("Path", "<script language='javascript'> window.open('" + Path + "', '', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');</script>");
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Msg", "javascript:HomeClick();", true);
                    // Response.Redirect("../Reception/ViewPrintPage.aspx?pid=" + patientID + "&vid=" + PatientVID + "&bid=" + BillNumber + "&pagetype=BP", true);
                //}

            }
            else
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + duealert + "','" + AlertType + "');", true);
            btnSave.Enabled = false;

        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Due Clearance", ex);
        }
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
   
    protected void gvDueDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueDetails pdc = (PatientDueDetails)e.Row.DataItem;
            CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
            TextBox txtPayingAmt = (TextBox)e.Row.FindControl("txtPayingAmt");
            TextBox txtDiscount = (TextBox)e.Row.FindControl("txtDiscountAmt");
            CheckBox chkWriteOff = (CheckBox)e.Row.FindControl("chkWriteOff");
            Label lblRemainingDue = (Label)e.Row.FindControl("lblRemainingDue");
            Label lblWriteOffAmt = (Label)e.Row.FindControl("lblWriteOffAmt");
            HiddenField hdnWriteOffAmt = (HiddenField)e.Row.FindControl("hdnWriteOffAmt");
            HiddenField hdnHasHealthCard = (HiddenField)e.Row.FindControl("hdnHasHealthCard");

            string Restrictdue = GetConfigValue("Restrictbills", OrgID);//selva

            decimal RemainingDue = Convert.ToDecimal(lblRemainingDue.Text);
            decimal WriteOffAmt = Convert.ToDecimal(lblWriteOffAmt.Text);
            if (TaskAssignd > 0)
            {
                chkWriteOff.Checked = true;
                chkWriteOff.Enabled = false;
                txtPayingAmt.Enabled = false;
                txtDiscount.Enabled = false;
                chkSelect.Enabled = false;
                chkAssignTotask.Enabled = false;
            }
            else
            {
                string disableControl = GetConfigValue("DisableDiscount ", OrgID);
                if (disableControl == "Y")
                {

                    if (base.RoleName == "LabReception")
                    {

                        chkWriteOff.Enabled = false;
                        txtDiscount.Enabled = false;
                        ddlDiscountReason.Enabled = false;
                    }
                    else
                    {
                        chkWriteOff.Enabled = true;
                        txtDiscount.Enabled = true;
                    }
                }
                else
                {
                    chkWriteOff.Enabled = true;
                    txtDiscount.Enabled = true;
                }
                txtPayingAmt.Enabled = true;
                chkSelect.Enabled = true;
                chkAssignTotask.Enabled = true;
            }

            //else
            //{
            //    chkWriteOff.Enabled = true;
            //    txtPayingAmt.Enabled = true;
            //    txtDiscount.Enabled = true;
            //    chkSelect.Enabled = true;
            //    chkAssignTotask.Enabled = true;
            //}

            if (hdnHasHealthCard.Value == "Y")
            {
                chkWriteOff.Enabled = false;
                txtPayingAmt.Enabled = false;
                txtDiscount.Enabled = false;
            }
            txtPayingAmt.Text = String.Format("{0:0.00}", (RemainingDue - WriteOffAmt));
            txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(txtPayingAmt.Text) - Convert.ToDecimal(txtDiscount.Text)).ToString();
            txtGrandTotal.Text = (Convert.ToDecimal(txtGross.Text) - Convert.ToDecimal(txtDiscount.Text)).ToString();
            chkSelect.Attributes.Add("OnClick", "Checked('" + chkSelect.ClientID + "','" + txtDiscount.ClientID + "','" + txtPayingAmt.ClientID + "');");
            txtDiscount.Attributes.Add("onblur", "DisAmt('" + chkSelect.ClientID + "','" + txtDiscount.ClientID + "','" + txtPayingAmt.ClientID + "');");
            txtPayingAmt.Attributes.Add("onblur", "SumPayAmt('" + chkSelect.ClientID + "','" + txtDiscount.ClientID + "','" + txtPayingAmt.ClientID + "');");
            chkWriteOff.Attributes.Add("OnClick", "CheckWriteOff('" + chkWriteOff.ClientID + "','" + lblRemainingDue.ClientID + "','" + txtDiscount.ClientID + "','" + txtPayingAmt.ClientID + "','" + lblWriteOffAmt.ClientID + "','" + hdnWriteOffAmt.ClientID + "');");
            if (Restrictdue == "Y")
            {
                ddlDiscountReason.Enabled = false;
                txtAuthorised.Enabled = false;
                txtGross.Enabled = false;
                txtDiscount.Enabled = false;
                chkWriteOff.Enabled = false;
            }
        }
    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {


            Response.Redirect(Request.ApplicationPath + "/InPatient/IPBillingHome.aspx" + "?SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnClose1_Click(object sender, EventArgs e)
    {
        try
        {


            Response.Redirect(Request.ApplicationPath + "/Billing/PatientDueDetails.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    private void LoadReasonList()
    {
        try
        {
            long returnCode = -1;
            List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
            Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
            returnCode = objReasonMaster.GetReasonMaster(0, 0, "DIS", out lstReasonMaster);

            if (lstReasonMaster.Count > 0)
            {
                ddlDiscountReason.DataSource = lstReasonMaster;
                ddlDiscountReason.DataTextField = "Reason";
                ddlDiscountReason.DataValueField = "ReasonCode";
                ddlDiscountReason.DataBind();
                ddlDiscountReason.Items.Insert(0, new ListItem(select, "0"));
//                ddlDiscountReason.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddlDiscountReason.Items.Insert(0, new ListItem(select, "0"));
                //ddlDiscountReason.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LabQuickBilling_ReasonMaster LoadReasonList()", ex);
        }
    }

    protected void btnWriteOff_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        long patientID = 0;
        string grand = txtGrandTotal.Text;
        long FinalBillID = 0;
        decimal PaidAmt = 0;
        string PName = "";
        string BillNo = string.Empty;
        long PatientDueID = 0;
        long returnCode = -1;
        long WriteOffAppID = 0;
        List<PatientDueDetails> lstPatientDueDetails = new List<PatientDueDetails>();
        foreach (GridViewRow row in gvDueDetails.Rows)
        {
            CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
            if (chkSelect.Checked)
            {
                PatientDueDetails PatientDueDetail = new PatientDueDetails();

                HiddenField hdnPatientID = (HiddenField)row.FindControl("hdnPatientID");
                HiddenField hdnPatientDueID = (HiddenField)row.FindControl("hdnPatientDueID");
                HiddenField hdnVisiID = (HiddenField)row.FindControl("hdnVisiID");
                HiddenField hdnFinalBillID = (HiddenField)row.FindControl("hdnFinalBillID");
                TextBox txtPayingAmt = (TextBox)row.FindControl("txtPayingAmt");
                TextBox txtDiscounts = (TextBox)row.FindControl("txtDiscountAmt");
                Label lblWriteOffAmt = (Label)row.FindControl("lblWriteOffAmt");
                HiddenField hdnWriteOffAmt = (HiddenField)row.FindControl("hdnWriteOffAmt");
                HiddenField hdnDiscountTotal = (HiddenField)row.FindControl("hdnDiscountedAmount");
                PatientDueDetail.PatientNumber = row.Cells[1].Text;
                PatientDueDetail.BillNo = Convert.ToString(row.Cells[2].Text);
                PatientDueDetail.PatientName = row.Cells[3].Text;
                PatientDueDetail.PatientDueID = Convert.ToInt64(hdnPatientDueID.Value);
                PatientDueDetail.PatientID = Convert.ToInt64(hdnPatientID.Value);
                PatientDueDetail.FinalBillID = Convert.ToInt64(hdnFinalBillID.Value);
                PatientDueDetail.VisitID = Convert.ToInt64(hdnVisiID.Value);
                PatientDueDetail.DueAmount = Convert.ToDecimal(row.Cells[4].Text);
                PatientDueDetail.OrgID = OrgID;
                PatientDueDetail.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                PatientDueDetail.CreatedBy = LID;
                PatientDueDetail.WriteOffAmt = Convert.ToDecimal(hdnWriteOffAmt.Value);
                patientName = row.Cells[3].Text;
                patientID = Convert.ToInt64(hdnPatientID.Value);
                patientNumber = Convert.ToString(row.Cells[1].Text);
                visitID = Convert.ToInt64(hdnVisiID.Value);
                FinalBillID = Convert.ToInt64(hdnFinalBillID.Value);
                PaidAmt = Convert.ToDecimal(row.Cells[5].Text);
                PName = row.Cells[3].Text;
                BillNo = Convert.ToString(row.Cells[2].Text);
                PatientDueID = Convert.ToInt64(hdnPatientDueID.Value);
                lstPatientDueDetails.Add(PatientDueDetail);

            }

        }
        returnCode = new BillingEngine(base.ContextInfo).InsertDueWriteOffApprovals(lstPatientDueDetails, out WriteOffAppID);
        CreateTask(lstPatientDueDetails[0].PatientID, lstPatientDueDetails[0].VisitID, lstPatientDueDetails[0].PatientName, lstPatientDueDetails[0].BillNo, lstPatientDueDetails[0].PatientNumber, "DUE", WriteOffAppID);
    }
    private void LoadPerformRole()
    {
        List<Role> lstRole = new List<Role>();
        Role_BL rolebl = new Role_BL(base.ContextInfo);
        int TaskActionID = 0;
        TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PerformDueWriteOff);
        rolebl.GetPerformRefundRole(OrgID, TaskActionID, out lstRole);


        if (lstRole.Count > 0)
        {
            chkAssignTotask.DataSource = lstRole;
            chkAssignTotask.DataTextField = "Description";
            chkAssignTotask.DataValueField = "RoleID";
            chkAssignTotask.DataBind();
        }

    }
    protected void CreateTask(long PatientID, long VisitID, string sPatientName, string BillNo, string PatientNumber, string FeeType, long WriteOffAppID)
    {
        try
        {
            long AssingTo = -1;
            long taskID;
            long returnCode = 0;
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long TaskActionID = -1;
            string Name = string.Empty;
            TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.PerformDueWriteOff);
            returnCode = Utilities.GetHashTableWriteOffDDueAmt(TaskActionID, VisitID, PatientID, patientName, FeeType, out dText, out urlVal, BillNo, patientNumber);
            task.TaskActionID = Convert.ToInt32(TaskActionID);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            urlVal.Add("ApprovalID", WriteOffAppID);
            task.PatientID = PatientID;
            foreach (ListItem item in chkAssignTotask.Items)
            {
                if (item.Selected == true)
                {
                    AssingTo = Int64.Parse(item.Value);
                    Name = Name + "," + item.Text;
                }
            }

            task.RoleID = AssingTo;
            task.OrgID = OrgID;
            task.PatientVisitID = VisitID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            Tasks_BL taskBL = new Tasks_BL();
            returnCode = taskBL.CreateTask(task, out taskID);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Redirects", "javascript:ValidationWindow('" + Name + "','" + AlertType + "');", true);

        }
        catch (Exception ex)
        {

        }
    }

}
