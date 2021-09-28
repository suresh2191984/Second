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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
public partial class Invoice_InvoiceCapture : BasePage
{

    public Invoice_InvoiceCapture()
        : base("Invoice_InvoiceCapture_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long clientID = 0;
    int index = 0;
    static List<PaymentType> lstPaymentType = new List<PaymentType>();
    static List<ReasonMaster> lstReason = new List<ReasonMaster>();
    List<Invoice> lstInvoicepayments = new List<Invoice>();
    List<Config> lstConfigList = new List<Config>();
    BillingEngine objBillingEngine ;

    protected void Page_Load(object sender, EventArgs e)
    {
        objBillingEngine = new BillingEngine(base.ContextInfo);
        ViewState["PreviousPage"] = Request.UrlReferrer;
        LoadPaymentType();
        LoadReasonMaster();
        string configMultiplePayment;
        configMultiplePayment = GetConfigValue("InvoiceMultiplePayment", OrgID);//Round off is done by config value(orgbased)
        if (configMultiplePayment == "Y")
        {
            divPayment.Visible = true;
            tblAreaIn.Style.Add("height", "110px");
            hdnInvoiceMultiplePayment.Value = "1";
        }
        else
        {
            divPayment.Visible = false;
            tblAreaIn.Style.Add("height", "70px");
            hdnInvoiceMultiplePayment.Value = "0";
        }
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
        if (lstPaymentType.Count > 0)
        {
            ddlPaymentType.DataSource = lstPaymentType;
            ddlPaymentType.DataTextField = "PaymentName";
            ddlPaymentType.DataValueField = "PaymentTypeID";
            ddlPaymentType.DataBind();
        }
        ddlPaymentType.Items.Insert(0, new ListItem("-- Select --", "0"));
        ddlPaymentType.SelectedIndex = 1;
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
        string rval, roundpattern;
        rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
        roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
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
            hdnResultInvoice.Value = sID;
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

            //returnCode = BE.GetInvoicePayments(lstInvID, OrgID,"", out lstInvoicepayments, out lstInvrecipt);
           
            //grdInvoicePayments.DataSource = lstInvoicepayments;
            //grdInvoicePayments.DataBind();
            //ScriptManager.RegisterStartupScript(this, GetType(), "alt1", "test();", true);
        }
        else
        {
            Response.Redirect("~/Invoice/InvoiceTracker.aspx");
        }
    }
    protected void grdInvoicePayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
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
            decimal ReceieddAmt = Convert.ToDecimal(RevdAmt.Text);
            decimal Total = Convert.ToDecimal(TotalAmt.Text);
            Label WOffAmt = ((Label)e.Row.FindControl("lblWriteOffAmt"));
            Label ROffAmttotal = ((Label)e.Row.FindControl("lblRoundOffTotal"));
            HiddenField hdnNetTotalvalue = ((HiddenField)e.Row.FindControl("hdnNetTotal"));
            TextBox lblRoundOff = ((TextBox)e.Row.FindControl("lblRoundOff"));

            try
            {

                long returncode = -1;
                string domains = "PaymentType";
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


                // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
                returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                if (lstmetadataOutput.Count > 0)
                {
                    var PaymentType = from child in lstmetadataOutput
                                      where child.Domain == "PaymentType"
                                      select child;
                    if (PaymentType.Count() > 0)
                    {
                        ddlStatus.DataSource = PaymentType;
                        ddlStatus.DataTextField = "DisplayText";
                        ddlStatus.DataValueField = "Code";
                        ddlStatus.DataBind();
                        ddlStatus.SelectedValue = "Pending";

                    }


                }
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error while  loading Type   ", ex);

            }
            ddlReason.DataSource = lstReason;
            ddlReason.DataValueField = "ReasonID";
            ddlReason.DataTextField = "Reason";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, new ListItem("--Select--", "0"));
            decimal RoundOff = 0;
            decimal RoundOffValue = Convert.ToDecimal(hdnDefaultRoundoff.Value);
            if (RoundOffValue > 0)
            {
                Total = Math.Floor(((Total) / (RoundOffValue)) * (RoundOffValue));

            }
            
            string FinalTotal = Convert.ToString(Total);
            decimal Round = (Convert.ToDecimal(FinalTotal) - (Convert.ToDecimal(TotalAmt.Text)));
            TotalAmt.Text = FinalTotal;
            if (Round < 0)
            {
                RoundOff = Round * (-1);
            }
            else
            {
                RoundOff = Round;
            }

            lblRoundOff.Text = RoundOff.ToString();
            decimal RoundTotal = Convert.ToDecimal(FinalTotal.ToString());

            if (lstPaymentType.Count > 0)
            {
                //ddlPayment.DataSource = lstPaymentType.FindAll(p => p.PaymentTypeID == 2 || p.PaymentTypeID == 4);
                ddlPayment.DataSource = lstPaymentType;
                ddlPayment.DataTextField = "PaymentName";
                ddlPayment.DataValueField = "PaymentTypeID";
                ddlPayment.DataBind();
            }

            HiddenField hdnComments = new HiddenField();
            hdnComments = (HiddenField)e.Row.FindControl("hdnComments");
            string[] lstComments = hdnComments.Value.Split('-');
            string comment = string.Empty;
            Double writeOff = 0.00;
            if (lstComments.Length >= 4)
            {
                comment = !String.IsNullOrEmpty(lstComments[3]) ? lstComments[3] : string.Empty;
            }
            Double.TryParse(comment, out writeOff);
            if (RoundTotal == ReceieddAmt || writeOff > 0)
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

                if (chkWOff.Checked == true)
                {
                    if (ReceivedAmt.Text != "")
                    {
                        decimal RecAmt = ReceiveAmt.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(ReceiveAmt.Text);
                        decimal ROffAmt = lblRoundOff.Text == "" ? Convert.ToDecimal("0.00") : Convert.ToDecimal(lblRoundOff.Text);
                        ChkWOffAmt = Convert.ToDecimal(lblInvoiceAmt.Text) - Convert.ToDecimal(ReceivedAmt.Text) - RecAmt - ROffAmt;
                    }
                    else
                    {
                        if (lblInvoiceAmt.Text != "")
                        {
                            ChkWOffAmt = Convert.ToDecimal(lblInvoiceAmt.Text) - Convert.ToDecimal("0.00");
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
                InvoiceItems.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                InvoiceItems.WriteOffAmt = ChkWOffAmt;
                InvoiceItems.RoundOffAmt = Convert.ToDecimal(lblRoundOff.Text == "" ? "0" : lblRoundOff.Text);
                InvoiceItems.OrgID = OrgID;
                InvoiceItems.OrgAddID = ILocationID;
                InvoiceItems.Status = Status.SelectedValue;
                InvoiceItems.CreatedBy = LID;
                lstInvoices.Add(InvoiceItems);
                InvoiceItems = new InvoiceReceipts();
                lblGrandTotal.Text = Convert.ToDecimal(ReceiveAmt.Text == "" ? "0" : ReceiveAmt.Text).ToString();
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
                string clientname1 = string.Empty;

                lblInvoiceNumber.Text = lstInvoices[0].ReceiptNumber.ToString();
                lblReceiptNumber.Text = lstAmountRecDetails[0].ReceiptNO;
                lblInvoiceDate.Text = lstInvoices[0].CreatedAt.ToString();
                lblClientName.Text = lstInvoices[0].ClientName.ToString();

                lblPaidDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                lblPrintDate.Text = GetDate().ToString();
                lblPrintDate.Text = GetDate().ToString();
                lbl_Billedoutput.Text = "(" + lstAmountRecDetails[0].Name + ")";
                lblrecivAmountinWords.Text = Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_009 == null ? " The Sum Of " : Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_009 + CurrencyName + ". ";
                //lblrecivAmountinWords.Text = " The Sum of " + CurrencyName + ". ";

                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();

                if (lblGrandTotal.Text != "")
                {
                    if (Convert.ToDouble(lblGrandTotal.Text) > 0)
                    {
                        string DispRS = Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_010 == null ? "Rupees" : Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_010;
                        string DispOnly = Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_011 == null ? "Only" : Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_011;
                        string[] Total = lblGrandTotal.Text.Split('.');
                        if (Total.Count() == 1)
                        {
                            //lblrecivAmount.Text = num.Convert(Total[0]) + " Rupees"+" Only";
                            lblrecivAmount.Text = num.Convert(Total[0]) + DispRS + DispOnly;
                        }
                        else
                        {
                            lblrecivAmount.Text = num.Convert(Total[0]) + DispRS + "  " + Utilities.FormatNumber2Word(num.Convert(Total[1])) + " " + MinorCurrencyName + DispOnly;
//                            lblrecivAmount.Text = num.Convert(Total[0]) + " Rupees" + "  " + Utilities.FormatNumber2Word(num.Convert(Total[1])) + " " + MinorCurrencyName + " Only";
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
                        ////////amr.PaymentMode = lblPaymentMode.Text.ToString();

                        if (amr.PaymentName == "Cash")
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
            btnSave.Visible = false;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(ViewState["PreviousPage"].ToString());
    }

    protected void btnSaveIn_Click(object sender, EventArgs e)
    {
        //ScriptManager.RegisterStartupScript(this, GetType(), "function", "SaveDetails()", true);
        ScriptManager.RegisterStartupScript(this, GetType(), "function2", "txtdisable()", true);
        ScriptManager.RegisterStartupScript(this, GetType(), "function1", "FirstLoad('" + hdnResultInvoice.Value + "');", true);
        try
        {
            if (!string.IsNullOrEmpty(hdnResultInvoice.Value) && (hdnInvoiceMultiplePayment.Value == "1"))
            {
                foreach (string HiddenValue in hdnResultInvoice.Value.Split('^'))
                {
                    string InvoiceId = HiddenValue.Split('~')[0];
                    string InvoiceNumber = HiddenValue.Split('~')[1];
                    string ClientId = HiddenValue.Split('~')[2];
                    SaveInvoicePicture(InvoiceNumber, InvoiceId, ClientId);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving button save click() in Invoice Capture", ex);
        }
    }


    private long SaveInvoicePicture(String InvoiceNumber, String InvoiceId, String ClientId)
    {
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        try
        {
            //Modified / By Arivalagan K//
            if (!string.IsNullOrEmpty(Convert.ToString(FileUpload1.FileName)))
            {
                DateTime dt = new DateTime();
                dt = Convert.ToDateTime(OrgDateTimeZone);

                int Year = dt.Year;
                int Month = dt.Month;
                int Day = dt.Day;

                String Root = String.Empty;
                String RootPath = String.Empty;

                Root = "Invoice_Upload-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + InvoiceNumber + "-";
                Root = Root.Replace("-", "\\\\");
                RootPath = pathname + Root;

                string fileName = Path.GetFileName(FileUpload1.FileName);
                string fileExtension = Path.GetExtension(FileUpload1.FileName);

                string picNameWithoutExt = InvoiceNumber + '_' + InvoiceId + '_' + OrgID + '_' + fileName;
                string pictureName = string.Empty;
                string filePath = string.Empty;
                Response.OutputStream.Flush();
                if (!System.IO.Directory.Exists(RootPath))
                {
                    System.IO.Directory.CreateDirectory(RootPath);
                }
                //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                string[] fileNames = Directory.GetFiles(RootPath, picNameWithoutExt + ".*");
                foreach (string path in fileNames)
                {
                    File.Delete(path);
                }

                pictureName = picNameWithoutExt + fileExtension;
                //filePath = imagePath + pictureName;
                filePath = RootPath + pictureName;
                FileUpload1.SaveAs(filePath);

                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                int pno = int.Parse(ClientId.ToString());
                int Vid = int.Parse(InvoiceId.ToString());
                long Iid = Convert.ToInt64(InvoiceNumber);
                returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, Iid, "Invoice_Upload", Root, LID, dt, "Y", 0);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveInvoicePicture() in Invoice Capture", ex);
        }
        return returncode;
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
            lblHospitalName.InnerHtml += "<td style='Padding-left:18px;'>" + lines[1] + "</td> ";
            lblHospitalName.InnerHtml += "</tr>";
            lblHospitalName.InnerHtml += "<tr>";
            lblHospitalName.InnerHtml += "<td style='Padding-left:18px;'>" + lines[2] + "</td> ";
            lblHospitalName.InnerHtml += "</tr>";
            lblHospitalName.InnerHtml += "<tr>";
            lblHospitalName.InnerHtml += "<td style='Padding-left:18px;'>" + lines[3] + "</td> ";
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