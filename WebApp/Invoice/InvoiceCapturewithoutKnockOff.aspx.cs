using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using System.Collections.Specialized;
public partial class Invoice_InvoiceCapturewithoutKnockOff : BasePage
{

    public Invoice_InvoiceCapturewithoutKnockOff()
        : base("Invoice_InvoiceCapturewithoutKnockOff.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    static List<PaymentType> lstPaymentType = new List<PaymentType>();
    static List<ReasonMaster> lstReason = new List<ReasonMaster>();
    List<Invoice> lstInvoicepayments = new List<Invoice>();

    long clientID = 0;
    int index = 0;
    BillingEngine objBillingEngine ;

    protected void Page_Load(object sender, EventArgs e)
    {
        objBillingEngine = new BillingEngine(base.ContextInfo);
        ViewState["PreviousPage"] = Request.UrlReferrer; 
        LoadPaymentType();
        LoadReasonMaster();
        if (!IsPostBack)
        {
            LoadpaymentDetails();
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:hidemenu();", true);
        }
    }
    private void LoadReasonMaster()
    {
        try
        {
            string ReasonCode = "INVCA"; 
            long returnCode = -1;
            Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
            returnCode = objReasonMaster.GetReasonMaster(1, 1,ReasonCode, out lstReason);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load GetReasonMaster details", ex);
        }
    }
    public void LoadPaymentType()
    {
        long retval = -1;
        retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
        
         
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
    void LoadpaymentDetails()
    {
        try
        {
            string rval, roundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            if (rval == "" || rval == null)
            {
                rval = "0";
            }
            hdnDefaultRoundoff.Value = rval;
            hdnRoundOffType.Value = roundpattern;

            long returnCode = -1;
            List<Invoice> lstInvID = new List<Invoice>();
            List<Invoice> lstInvoicepayments = new List<Invoice>();
            List<InvoiceReceipts> lstInvrecipt = new List<InvoiceReceipts>();
            BillingEngine BE = new BillingEngine(base.ContextInfo);
            string sID = string.Empty;

            if ((PreviousPage != null) && (PreviousPage.IsCrossPagePostBack))
            {
                sID = ((HiddenField)PreviousPage.FindControl("hdnResult")).Value;
            }

            if (sID != "")
            {
                foreach (string O in sID.Split('^'))
                {
                    if (O != string.Empty)
                    {
                        Invoice Iv = new Invoice();
                        Iv.InvoiceID = Convert.ToInt64(O.Split('~')[0]);
                        Iv.InvoiceNumber = O.Split('~')[1];
                        Iv.ClientID = Convert.ToInt64(O.Split('~')[2]);
                        if (!string.IsNullOrEmpty(O.Split('~')[2]))
                        {
                            Session["clientID"] = (O.Split('~')[2]);
                        }
                        lstInvID.Add(Iv);
                    }
                }

                returnCode = BE.GetInvoicePayments(lstInvID, OrgID, "INVOICE", out lstInvoicepayments, out lstInvrecipt);
                grdInvoicePayments.DataSource = lstInvoicepayments;
                grdInvoicePayments.DataBind();
            }
            else
            {
                Response.Redirect("~/Invoice/InvoiceTracker.aspx");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing LoadpaymentDetails", ex);
        }
    }
    protected void grdInvoicePayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CLogger.LogWarning("Sur4");
                index = e.Row.RowIndex;
                DropDownList ddlReason = ((DropDownList)e.Row.FindControl("ddlReason"));
                DropDownList ddlPayment = ((DropDownList)e.Row.FindControl("ddlPayMentType"));
                DropDownList ddlStatus = ((DropDownList)e.Row.FindControl("ddlStatus"));
                CheckBox chkBox = ((CheckBox)e.Row.FindControl("chkBox"));
                CheckBox chkWOff = ((CheckBox)e.Row.FindControl("chkWOff"));
                Label RevdAmt = ((Label)e.Row.FindControl("lblReceivedAmt"));
                Label TotalAmt = ((Label)e.Row.FindControl("lblInvoiceAmt"));
                TextBox TxtRvingAmt = ((TextBox)e.Row.FindControl("txtReceiveAmt"));
                TextBox TxtBank = ((TextBox)e.Row.FindControl("txtBankName"));
                TextBox TxtChqNo = ((TextBox)e.Row.FindControl("lblChqorCardNo"));
                TxtChqNo.Attributes.Add("maxlength", "14");
                decimal ReceieddAmt = Convert.ToDecimal(RevdAmt.Text);
                decimal Total = Convert.ToDecimal(TotalAmt.Text);
                Label WOffAmt = ((Label)e.Row.FindControl("lblWriteOffAmt"));
                Label ROffAmttotal = ((Label)e.Row.FindControl("lblRoundOffTotal"));
                HiddenField hdnNetTotalvalue = ((HiddenField)e.Row.FindControl("hdnNetTotal"));
                TextBox lblRoundOff = ((TextBox)e.Row.FindControl("lblRoundOff"));
                
                ddlReason.DataSource = lstReason;
                ddlReason.DataValueField = "ReasonID";
                ddlReason.DataTextField = "Reason";
                ddlReason.DataBind();
                ddlReason.Items.Insert(0, new ListItem("--Select--", "0"));
                CLogger.LogWarning("Sur13");
                decimal RoundOff = 0;
                CLogger.LogWarning(hdnDefaultRoundoff.Value);
                decimal RoundOffValue = Convert.ToDecimal(hdnDefaultRoundoff.Value);
                CLogger.LogWarning("Sur14");
                CLogger.LogWarning("Sur10");
                if (RoundOffValue > 0)
                {
                    CLogger.LogWarning("Sur11");
                    Total = Math.Floor(((Total) / (RoundOffValue)) * (RoundOffValue));
                    CLogger.LogWarning("Sur12");

                }
                CLogger.LogWarning("Sur8");
                decimal FinalTotal = (Total);
                decimal Round = (Convert.ToDecimal(FinalTotal) - (Convert.ToDecimal(TotalAmt.Text)));
                TotalAmt.Text = FinalTotal.ToString();
                CLogger.LogWarning("Sur10");
                if (Round < 0)
                {
                    RoundOff = Round * (-1);
                }
                else
                {
                    RoundOff = Round;
                }
                CLogger.LogWarning("Sur9");
                lblRoundOff.Text = RoundOff.ToString();
                decimal RoundTotal = Convert.ToDecimal(FinalTotal);
                //long retval = -1;
                //retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
                CLogger.LogWarning("Sur5");
                if (lstPaymentType.Count > 0)
                {
                    CLogger.LogWarning("Sur6");
                    ddlPayment.DataSource = lstPaymentType;
                    ddlPayment.DataTextField = "PaymentName";
                    ddlPayment.DataValueField = "PaymentTypeID";
                    ddlPayment.DataBind();
                }


                HiddenField hdnComments = new HiddenField();
                hdnComments = (HiddenField)e.Row.FindControl("hdnComments");
                string[] lstComments = hdnComments.Value.Split('-');
                string comment = string.Empty;
                //Double writeOff = 0.00;
                if (lstComments.Length >= 4)
                {
                    comment = !String.IsNullOrEmpty(lstComments[3]) ? lstComments[3] : string.Empty;
                }
                //Double.TryParse(comment, out writeOff);
                if (RoundTotal == ReceieddAmt )
                {
                    ddlStatus.SelectedIndex = 1;
                    TxtRvingAmt.Enabled = false;
                    ddlStatus.Enabled = false;
                    ddlPayment.Enabled = false;
                    chkBox.Enabled = false;
                    chkWOff.Enabled = false;
                    TxtBank.Enabled = false;
                    TxtChqNo.Enabled = false;
                }

                string sComments = "showModalPopup('" + hdnComments.ClientID + "');";
                e.Row.Cells[1].Attributes.Add("onclick", sComments);
                hdnChkValues.Value += chkBox.ClientID + "~";
                string str = "javascript:showHideReason('" + ddlReason.ClientID + "','" + chkWOff.ClientID + "');";
                chkWOff.Attributes.Add("onclick", str);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error loading grdInvoicePayments_RowDataBound", ex);
        }
    }
    //protected void btnCalculate_Click(object sender, EventArgs e)
    //{
       
    //    foreach (GridViewRow grd in grdInvoicePayments.Rows)
    //    {
    //        CheckBox chkbox = (CheckBox)grd.FindControl("chkbox");
    //        if (chkbox.Checked == true)
    //        {  
    //            TextBox ReceiveAmt = (TextBox)grd.FindControl("txtReceiveAmt");
    //            Label ReceivedAmt = (Label)grd.FindControl("lblReceivedAmt"); 
    //            TextBox DiscountAmt = (TextBox)grd.FindControl("txtDiscountAmt");
    //            TextBox TDSAmt = (TextBox)grd.FindControl("txtTDSAmt");

    //            double DiscountAmount, TDSAmount, ReceiveAmount; 
    //            double.TryParse(DiscountAmt.Text, out DiscountAmount);
    //            double.TryParse(TDSAmt.Text, out TDSAmount);
    //            double.TryParse(ReceiveAmt.Text, out ReceiveAmount);
    //            ReceiveAmount = ReceiveAmount -(DiscountAmount + TDSAmount);
    //            ReceiveAmt.Text = "";
    //            ReceiveAmt.Text = ReceiveAmount.ToString();
    //        }
    //    }
    
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {

        long CreateBy = 0;
        long returnCode = -1;
        decimal ChkWOffAmt = 0;
        long returnCode1 = -1;
        string ReceiptNo = string.Empty;
        long ReceiptID = -1;
        BillingEngine bill = new BillingEngine(base.ContextInfo);
        List<InvoiceReceipts> lstInvoices = new List<InvoiceReceipts>();
        InvoiceReceipts InvoiceItems = new InvoiceReceipts();
        List<AmountReceivedDetails> lstAmountRecDetails = new List<AmountReceivedDetails>();
        foreach (GridViewRow grd in grdInvoicePayments.Rows)
        {
            CheckBox chkbox = (CheckBox)grd.FindControl("chkbox");
            if (chkbox.Checked == true)
            {
                Label InvoiceID = (Label)grd.FindControl("lblInvoiceID");
                Label lblInvoiceAmt = (Label)grd.FindControl("lblInvoiceAmt");
                TextBox ChqorCardNo = (TextBox)grd.FindControl("lblChqorCardNo");
                DropDownList ddlPayType = (DropDownList)grd.FindControl("ddlPayMentType");
                DropDownList Status = (DropDownList)grd.FindControl("ddlStatus");
                TextBox txtBank = (TextBox)grd.FindControl("txtBankName");
                TextBox ReceiveAmt = (TextBox)grd.FindControl("txtReceiveAmt");
                Label ReceivedAmt = (Label)grd.FindControl("lblReceivedAmt");
                CheckBox chkWOff = ((CheckBox)grd.FindControl("chkWOff"));
                TextBox lblRoundOff = (TextBox)grd.FindControl("lblRoundOff");
                DropDownList ddlReason = (DropDownList)grd.FindControl("ddlReason");
                TextBox DiscountAmt = (TextBox)grd.FindControl("txtDiscountAmt");
                TextBox TDSAmt = (TextBox)grd.FindControl("txtTDSAmt");

                decimal DisctAmt = DiscountAmt.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(DiscountAmt.Text);
                decimal TDSAmount = TDSAmt.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(TDSAmt.Text);
                if (chkWOff.Checked == true)
                {
                    if (ReceivedAmt.Text != "")
                    {
                        decimal RecAmt = ReceiveAmt.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(ReceiveAmt.Text);
                        decimal ROffAmt = lblRoundOff.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(lblRoundOff.Text);
                        ChkWOffAmt = Convert.ToDecimal(lblInvoiceAmt.Text) - Convert.ToDecimal(ReceivedAmt.Text) - RecAmt - ROffAmt -(DisctAmt+TDSAmount);
                    }
                    else
                    {
                        if (lblInvoiceAmt.Text != "")
                        {
                            ChkWOffAmt = Convert.ToDecimal(lblInvoiceAmt.Text) - Convert.ToDecimal("0.00") - (DisctAmt + TDSAmount);
                        }
                    }
                }
                else
                {
                    ChkWOffAmt = Convert.ToDecimal("0.00");
                }
                InvoiceItems.WriteOffReason = ddlReason.SelectedItem.Text == "--Select--" ? "" : ddlReason.SelectedItem.Text;
                InvoiceItems.InvoiceID = Convert.ToInt64(InvoiceID.Text);
                InvoiceItems.InvoiceAmount = Convert.ToDecimal(lblInvoiceAmt.Text == "" ? "0" : lblInvoiceAmt.Text);
                InvoiceItems.ReceivedAmount = Convert.ToDecimal(ReceiveAmt.Text == "" ? "0" : ReceiveAmt.Text);
                InvoiceItems.PaymentTypeID = Convert.ToInt32(ddlPayType.SelectedValue);
                InvoiceItems.ChequeorCardNumber = ChqorCardNo.Text == "" ? "0" : ChqorCardNo.Text;
                InvoiceItems.BankNameorCardType = txtBank.Text;
                InvoiceItems.CreatedAt = DateTime.Now;
                InvoiceItems.WriteOffAmt = ChkWOffAmt;
                InvoiceItems.RoundOffAmt = Convert.ToDecimal(lblRoundOff.Text == "" ? "0" : lblRoundOff.Text);
                InvoiceItems.OrgID = OrgID;
                InvoiceItems.OrgAddID = ILocationID;
                InvoiceItems.Status = Status.SelectedValue;
                InvoiceItems.CreatedBy = LID;
                InvoiceItems.DiscountAmount = DisctAmt;
                InvoiceItems.TDSAmount = TDSAmount;
                lstInvoices.Add(InvoiceItems);
                InvoiceItems = new InvoiceReceipts();

                lblGrandTotal.Text = Convert.ToDecimal(ReceiveAmt.Text == "" ? "0" : ReceiveAmt.Text).ToString();
               // lblPaymentMode.Text = ddlPayType.SelectedItem.Text;

            }
        }



        returnCode = bill.InsertInvoiceReceipts(lstInvoices, out ReceiptNo, out ReceiptID);

        if (ReceiptNo != string.Empty && ReceiptID != -1 && returnCode >= 0 && returnCode != -1)
        {
            if (!string.IsNullOrEmpty(Session["clientID"].ToString()))
            {
                clientID = Convert.ToInt64(Session["clientID"]);
            }
            returnCode1 = bill.GetInVoiceReceiptDetailss(OrgID, ILocationID, clientID, ReceiptNo, ReceiptID, lstInvoices[0].InvoiceID, out  lstInvoices, out lstAmountRecDetails);
            if (returnCode1 >= 0)
            {
                LoadBillConfigMetadata(OrgID, ILocationID);
                string clientname1=string.Empty;               
                
                lblInvoiceNumber.Text = lstInvoices[0].ReceiptNumber.ToString();
                lblReceiptNumber.Text = lstAmountRecDetails[0].ReceiptNO;
                lblInvoiceDate.Text = lstInvoices[0].CreatedAt.ToString();
                lblClientName.Text = lstInvoices[0].ClientName.ToString();            
                
                lblPaidDate.Text = DateTime.Now.ToString();
                lblPrintDate.Text = GetDate().ToString();
                lblPrintDate.Text = GetDate().ToString();
                lbl_Billedoutput.Text = "(" + lstAmountRecDetails[0].Name + ")";              
               
                lblrecivAmountinWords.Text = " The Sum of " + CurrencyName + ". ";               


                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
               
                if (lblGrandTotal.Text != "")
                {
                    if (Convert.ToDouble(lblGrandTotal.Text) > 0)
                    {
                        string[] Total = lblGrandTotal.Text.Split('.');
                        if(Total.Count()==1)
                        
                        {
                            lblrecivAmount.Text = num.Convert(Total[0]) + " Rupees" + " Only";
                          
                        }
                        else
                        {
                            lblrecivAmount.Text = num.Convert(Total[0]) + " Rupees" + "  " + Utilities.FormatNumber2Word(num.Convert(Total[1])) + " " + MinorCurrencyName + " Only";
                            
                        }

                    }
                    if (lblGrandTotal.Text == "")
                    {
                        lblrecivAmount.Attributes.Add("display", "none");
                        lblrecivAmountinWords.Attributes.Add("display", "none");
                    }
                }
                
                
                if (lstAmountRecDetails.Count > 0)
                {
                    foreach (AmountReceivedDetails amr in lstAmountRecDetails)
                    {
                        amr.AmtReceived = Convert.ToDecimal(lblGrandTotal.Text);
                        //amr.PaymentMode = lblPaymentMode.Text.ToString();

                        if(amr.PaymentName =="Cash")
                        {

                            gvReceipt.Columns[2].Visible = false;
                            gvReceipt.Columns[3].Visible = false;


                        }
                       

                    }
                }  
          
                
                gvReceipt.DataSource = lstAmountRecDetails;
                gvReceipt.DataBind();
               
              
                
               
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Print", "javascript:popupprint();", true);


        }
        btnSave.Visible = false;

    



        //if (returnCode >= 0 && returnCode != -1)
        //{

        //    Response.Redirect(ViewState["PreviousPage"].ToString());
        //}


    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(ViewState["PreviousPage"].ToString());
    }
   



    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.InvoiceReceipt;
        List<Config> lstConfigList = new List<Config>();
        
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");

                imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    imgBillLogo.Visible = true;
                }
                else
                {
                    imgBillLogo.Visible = false;
                }
            }
            else
            {
                imgBillLogo.Visible = false;
            }


            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim().Replace(",,,,", ",");
                lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,,", ",");
                lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,", ",");
                string[] lines = lblHospitalName.InnerHtml.Split(new[] { "<br>" }, StringSplitOptions.None);
                lblHospitalName.InnerHtml = "";
                lblHospitalName.InnerHtml += "<table width='250%' style='font-family: Verdana; font-size: 14px;padding-left:250px;'>";
                lblHospitalName.InnerHtml += "<tr>";
                lblHospitalName.InnerHtml += "<td style='Padding-left:20px;'>" + lines[0] + "</td> ";
                lblHospitalName.InnerHtml += "</tr>";
                lblHospitalName.InnerHtml += "<tr>";
                lblHospitalName.InnerHtml += "<td>" + lines[1] + "</td> ";
                lblHospitalName.InnerHtml += "</tr>";
                lblHospitalName.InnerHtml += "<tr>";
                lblHospitalName.InnerHtml += "<td style='Padding-left:20px;'>" + lines[2] + "</td> ";
                lblHospitalName.InnerHtml += "</tr>";
                lblHospitalName.InnerHtml += "</table>";
            }

            //---------------------------------------------------------------------------------------------
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Contents Font Size", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Style", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("border-style", lstConfig[0].ConfigValue.Trim());
            }
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Width = lstConfig[0].ConfigValue.Trim();


            }
             
    }
   
}