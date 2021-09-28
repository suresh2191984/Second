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
using System.Xml;
using System.Xml.Xsl;
using System.IO;


public partial class Billing_RefundVoucher : BasePage  
{
    long retunrCode = -1;
    
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<AmountRefundDetails> lstAmountRefundDetails = new List<AmountRefundDetails>();
    List<Patient> lstPatient = new List<Patient>();
    SharedInventory_BL INVUser;
    string FId = string.Empty;
    string RefundNo = string.Empty;
    decimal totRefundAmt = 0;
    string ReceiptNo = string.Empty;
    string ReceiptModel = string.Empty;
    string BillType = string.Empty;
    string refToPatient = string.Empty;
    string Usrsign = Resources.Deposit_ClientDisplay.Deposit_DepositControls_VoucherReceipt_ascx_01 == null ? "AUTHORIZED SIGNATORY" : Resources.Deposit_ClientDisplay.Deposit_DepositControls_VoucherReceipt_ascx_01;
    string Usrname = Resources.Deposit_ClientDisplay.Deposit_DepositControls_VoucherReceipt_ascx_02 == null ? "RECEIVER NAME <br>(with sign and Date)" : Resources.Deposit_ClientDisplay.Deposit_DepositControls_VoucherReceipt_ascx_02;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
   string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
   public Billing_RefundVoucher()
        : base("Billing_RefundVoucher_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        INVUser = new SharedInventory_BL(base.ContextInfo);
        long VisitID =Convert.ToInt64(Request.QueryString["VID"]);
        long PatientID = Convert.ToInt64(Request.QueryString["PatientID"]);
        if (Request.QueryString["ReceiptNo"] != null)
        {
            ReceiptNo = Request.QueryString["ReceiptNo"].ToString();
        }
        if (Request.QueryString["RefFlag"] != null)
        {
            refToPatient = Request.QueryString["RefFlag"].ToString();
        }
        if (Request.QueryString["ReceiptModel"] != null)
        {
            Request.QueryString["ReceiptModel"].ToString();
        }
        if (Request.QueryString["btype"] != null)
        {
            BillType = Request.QueryString["btype"].ToString();
        }
        if (!String.IsNullOrEmpty(BillType) && BillType.Length > 0)
        {
            if (BillType == "CAN")
            {
                tdCANdate.Style.Add("display", "table-cell");
                tdCancelDetails.Style.Add("display", "table-cell");
                tdCancelHeaderText.Style.Add("display", "table-cell");
                tdTxtCancelNo.Style.Add("display", "table-cell");
               // tdlblCancelNo.Style.Add("display", "none");
                tdlblCancelNo.Style.Add("display", "table-cell");
                tdREFdate.Style.Add("display", "none");
                tdREFno.Style.Add("display", "none");
                tdRefundDetails.Style.Add("display", "none");
                tdRefundHeaderText.Style.Add("display", "none");
                tdlblRefundNo.Style.Add("display", "table-cell");
              //  tdTxtRefundNo.Style.Add("display", "none");
                tdTxtRefundNo.Style.Add("display", "table-cell");
                tdTxt1RefundNo.Style.Add("display", "table-cell");
                trReasonForCancel.Style.Add("display", "table-row");
                trRefundAmtInWords.Style.Add("display", "none");
            }
            else
            {
                tdCANdate.Style.Add("display", "none");
                tdCancelno.Style.Add("display", "none");
                tdCancelDetails.Style.Add("display", "none");
                tdCancelHeaderText.Style.Add("display", "none");
                //tdTxtCancelNo.Style.Add("display", "none");
                tdTxtCancelNo.Style.Add("display", "table-cell");
                tdlblCancelNo.Style.Add("display", "none");
                tdREFdate.Style.Add("display", "table-cell");
                tdREFno.Style.Add("display", "table-cell");
                tdRefundDetails.Style.Add("display", "table-cell");
                tdRefundHeaderText.Style.Add("display", "table-cell");
                tdlblRefundNo.Style.Add("display", "table-cell");
                tdTxtRefundNo.Style.Add("display", "table-cell");
                tdTxt1RefundNo.Style.Add("display", "table-cell");
                trReasonForCancel.Style.Add("display", "none");
                trRefundAmtInWords.Style.Add("display", "table-row");
            }

        }
        long InterMedID = 0;
       BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
       objBillingBL.GetReceiptDetails(VisitID, PatientID, OrgID, InterMedID,ReceiptNo,ReceiptModel, out lstBillingDetails, out lstPatient);
       string str = lstPatient[0].Age;
       string[] strage = str.Split(' ');
       if (strage[1] == "Year(s)")
       {
           lstPatient[0].Age = strage[0] + " " + strYear;
       }
       else if (strage[1] == "Month(s)")
       {
           lstPatient[0].Age = strage[0] + " " + strMonth;
       }
       else if (strage[1] == "Day(s)")
       {
           lstPatient[0].Age = strage[0] + " " + strDay;
       }
       else if (strage[1] == "Week(s)")
       {
           lstPatient[0].Age = strage[0] + " " + strWeek;
       }
	    else if (strage[1] == "UnKnown")
       {
           lstPatient[0].Age = strage[0] + " " + strUnknownF;
       }
       else
       {
           lstPatient[0].Age = strage[0] + " " + strYear;
       }
       if (lstPatient.Count > 0)
       {
           lblPNo.Text = lstPatient[0].PatientNumber;
           lblPAge.Text = lstPatient[0].Age;
           lblName.Text = lstPatient[0].Name;
           FId = lstPatient[0].FinalBillID.ToString();
       }
        
      
            htmlbill();
      

        

    }
    private void xslbill()
    {
        //xsl
        tbl1.Visible = false;
        List<Config> lstConfig = new List<Config>();
        string billno = "", billedamt = "", name = "", refundamount = "", refundvoucherno = "";
        billno = Request.QueryString["BillNo"].ToString();
        billedamt = Request.QueryString["BilledAmt"].ToString();
        name = Request.QueryString["Name"].ToString();
        refundamount = Request.QueryString["RefundAmount"].ToString();
        refundvoucherno = Request.QueryString["RefundVoucherNo"].ToString();
        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("RefundVoucherInfo");

                xw.WriteStartElement("BillNo", "");
                xw.WriteString(billno.ToString());
                xw.WriteEndElement();

                xw.WriteStartElement("PrintedDate", "");
                xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt"));
                xw.WriteEndElement();

                xw.WriteStartElement("BilledAmount", "");
                xw.WriteString(billedamt.ToString());
                xw.WriteEndElement();

                xw.WriteStartElement("Name", "");
                xw.WriteString(name.ToString());
                xw.WriteEndElement();

                xw.WriteStartElement("RefundAmount", "");
                xw.WriteString(refundamount.ToString());
                xw.WriteEndElement();


                xw.WriteStartElement("RefundVoucherNo", "");
                xw.WriteString(refundvoucherno.ToString());
                xw.WriteEndElement();

               
                GateWay gateWay = new GateWay(base.ContextInfo);
                string sumamount, Currency;
                double amt;
                long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    Currency = lstConfig[0].ConfigValue;
                }
                else
                {
                       Currency = CurrencyName;
                }


                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                amt = Convert.ToDouble(refundamount.ToString());

                if (amt > 0)
                {
                    sumamount = Convert.ToInt32(amt.ToString().Split('.')[1]) > 0 ? Utilities.FormatNumber2Word(num.Convert(amt.ToString())) + " " + MinorCurrencyName + " Only..." : num.Convert(amt.ToString()) + " Only...";
                }
                else
                {
                    sumamount = " Zero Only";
                }


                xw.WriteStartElement("AmountInWords", "");
                //xw.WriteString(Currency + "." + sumamount.ToString());
                xw.WriteString(sumamount.ToString());
                xw.WriteEndElement();

                xw.WriteEndElement();
                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xmldom2 = new XmlDocument();
                xmldom2.LoadXml(sw.ToString());
                XslTransform xmltra = new XslTransform();
                Patient_BL billingBL = new Patient_BL(base.ContextInfo);
                List<XslBillType> xbt = new List<XslBillType>();
                int BillTypeID = 4;
                string filename = "";
                billingBL.GetXSLBillValue(OrgID, BillTypeID, out xbt);
                if (xbt.Count > 0)
                {
                    foreach (XslBillType item in xbt)
                    {
                        filename = item.BillTypeValue;
                    }
                }
                string file;
                file = "../xsl/" + filename + ".xsl";

                //file = "../xsl/LNHRefundReceipt.xsl";
                string s = Server.MapPath(file);

                xmltra.Load(s);

                Xml1.Document = xmldom2;
                Xml1.Transform = xmltra;

            }
        }

    }
    private void htmlbill()
    {
        tblxsl.Visible = false;
        List<Config> lstConfig = new List<Config>();
        BillingEngine be = new BillingEngine(base.ContextInfo);
        GateWay gateWay1 = new GateWay(base.ContextInfo);
        List<Config> lstRoundConfig = new List<Config>();
        string roundoff = "";
        retunrCode = gateWay1.GetConfigDetails("TPARoundOffPattern", OrgID, out lstRoundConfig);
        if (lstRoundConfig.Count > 0)
        {
            roundoff = lstRoundConfig[0].ConfigValue;
        }
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.Voucher;
        string refundAmount = "";
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
            //    lblimagelogo.Style.Add("font-family", lstConfig[0].ConfigValue.Trim());

        }

        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0)
        {
            lblHospitalName.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
            //  lblimagelogo.Style.Add("font-size", lstConfig[0].ConfigValue.Trim());
        }
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0)
        {
            lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
            //lblimagelogo.InnerHtml = lstConfig[0].ConfigValue.Trim();
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


        #region refund printing

     
        if (Request.QueryString["BillNo"] != null)
        {
            lblBillNo.Text = Request.QueryString["BillNo"].ToString();
            lblBillNoword.Text = Request.QueryString["BillNo"].ToString();
           // lblCancelValue.Text = Request.QueryString["BillNo"].ToString();
            FId=Request.QueryString["BillNo"].ToString();
        }
        if (Request.QueryString["RefundVoucherNo"] != null)
        {
            lblRefundVoucherNo.Text = Request.QueryString["RefundVoucherNo"].ToString();
            RefundNo=Request.QueryString["RefundVoucherNo"].ToString();
        }
        string pType = "";
        if (Request.QueryString["pType"] != null)
        {
            pType = Request.QueryString["pType"].ToString();
        }

        if (pType == "FINALSTLMT")
        {
            RefundNo = "-2";
        }
        if (Request.QueryString["FinallBillID"] != null)
        {
            FId = (Request.QueryString["FinallBillID"].ToString());
        }
        retunrCode = be.GetRefundVoucherPrint(FId, RefundNo, OrgID, out lstBillingDetails,out lstAmountRefundDetails,out lstPatient);
        if (lstBillingDetails.Count > 0 && pType != "PRMSTLMT" & pType != "FINALSTLMT")
        {
            gvdata.Style.Add("display", "table-row");
            totRefundAmt = lstBillingDetails.Sum(p => p.RefundedAmt);
            gvResult.DataSource = lstBillingDetails;
            gvResult.DataBind();
            trRefundDetails.Style.Add("display", "none");
            trReasonForRefund.Style.Add("display", "none");
            lblTxtReasonForCancel.Text = lstBillingDetails[0].ReasonforRefund;


            if (lstBillingDetails[0].TransferAmount > 0)
            {
                lbladjustedDue.Text = lstBillingDetails[0].TransferAmount.ToString();
            }
            else
            {
                tdRefuntadjusted.Style.Add("display", "none");
            }

            if (lstBillingDetails[0].TransferAmount > 0)
            {
                trdue.Style.Add("display", "table-row");
                lbldues.Text = lstBillingDetails.Sum(p => p.TransferAmount).ToString();
            }
            else
            {
                trdue.Style.Add("display", "none");
            }
                tralreadyrefundamount.Style.Add("display", "table-row");
                lblAlreadyrefundamts.Text = lstAmountRefundDetails.Sum(p => p.AmtRefund).ToString();
                totRefundAmt = Convert.ToDecimal(lblAlreadyrefundamts.Text);
            if (lstBillingDetails[0].DiscountAmount > 0)
            {
                trdiscount.Style.Add("display", "table-row");
                lblDiscount.Text = lstBillingDetails.Sum(p=>p.DiscountAmount).ToString();

            }
            if (lstAmountRefundDetails.Count() > 0)
            {
                if (lstAmountRefundDetails[0].ChequeNo > 0)
                {
                    trchequedetails.Style.Add("display", "table-row");
                    lblchequeno.Text = "<b>Cheque Number:</b> " + lstAmountRefundDetails[0].ChequeNo.ToString();
                    if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].BankName.ToString()) && lstAmountRefundDetails[0].BankName.ToString().Length > 0)
                        lblbankname.Text = "<b>Bank Name:</b> " + lstAmountRefundDetails[0].BankName;
                }
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].BillNumber.ToString()) && lstAmountRefundDetails[0].BillNumber.ToString().Length > 0)
                    lblBillNo.Text = lstAmountRefundDetails[0].BillNumber.ToString();
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].RefundNo.ToString()) && lstAmountRefundDetails[0].RefundNo.ToString().Length > 0)
                    lblCancelValue.Text = lstAmountRefundDetails[0].RefundNo.ToString();
              
            }
            if (roundoff == "Normal")
            {
                if (lstAmountRefundDetails[0].RefundRoundOFF !=0)
                {
                    trroundoff.Style.Add("display", "table-row");
                    lroundoffval.Text = lstAmountRefundDetails.Sum(p=>p.RefundRoundOFF).ToString();
                }
            }

        }
        else
        {
            gvdata.Style.Add("display", "none");
            if (lstAmountRefundDetails.Count() > 0)
            {
                if (lstAmountRefundDetails[0].ChequeNo > 0)
                {
                    trchequedetails.Style.Add("display", "table-row");
                    lblchequeno.Text = "<b>Cheque Number:</b>  " + lstAmountRefundDetails[0].ChequeNo.ToString();
                    if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].BankName.ToString()) && lstAmountRefundDetails[0].BankName.ToString().Length > 0)
                    lblbankname.Text = "<b>Bank Name:</b> "+ lstAmountRefundDetails[0].BankName;
                }


                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].AmtRefund.ToString()) && lstAmountRefundDetails[0].AmtRefund.ToString().Length > 0)
                    lblAmount.Text = lstAmountRefundDetails[0].AmtRefund.ToString("0.00");
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].BillNumber.ToString()) && lstAmountRefundDetails[0].BillNumber.ToString().Length > 0)
                    lblBillNoword.Text = lstAmountRefundDetails[0].BillNumber.ToString();
                trRefundDetails.Style.Add("display", "table-row");
                trReasonForRefund.Style.Add("display", "table-row");
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].ReasonforRefund) && lstAmountRefundDetails[0].ReasonforRefund.Length > 0)
                    lblRefundReason.Text = lstAmountRefundDetails[0].ReasonforRefund;
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].BillNumber.ToString()) && lstAmountRefundDetails[0].BillNumber.ToString().Length > 0)
                    lblBillNo.Text = lstAmountRefundDetails[0].BillNumber.ToString();
                if (!String.IsNullOrEmpty(lstAmountRefundDetails[0].RefundNo.ToString()) && lstAmountRefundDetails[0].RefundNo.ToString().Length > 0)
                    //lblRefundVoucherNo.Text = lstAmountRefundDetails[0].RefundNo.ToString();
                    lblCancelValue.Text = lstAmountRefundDetails[0].RefundNo.ToString();
                if (!String.IsNullOrEmpty(lblAmount.Text) && lblAmount.Text.Length > 0)
                    totRefundAmt = Convert.ToDecimal(lblAmount.Text);
            }

        }
        #endregion


        if (Request.QueryString["BillNo"] != null)
        {
            lblBillNo.Text = Request.QueryString["BillNo"].ToString();
            lblBillNoword.Text = Request.QueryString["BillNo"].ToString();
            
        }
        if (Request.QueryString["BilledAmt"] != null)
        {
            lblAmount.Text = Request.QueryString["BilledAmt"].ToString();
            
        }
        //if (Request.QueryString["Name"] != null)
        //{
        //    lblName.Text = Request.QueryString["Name"].ToString();
                
        //}
        if (Request.QueryString["PNumber"] != null)
        {
            lblPNo.Text = Request.QueryString["PNumber"].ToString();

        }
        //if (Request.QueryString["PAge"] != null)
        //{
        //    lblPAge.Text = Request.QueryString["PAge"].ToString();
        //}
        if (Request.QueryString["RefundAmount"] != null)
        {
            lblAmount.Text = Request.QueryString["RefundAmount"].ToString();
            refundAmount =   Request.QueryString["RefundAmount"].ToString();
        }
        if (Request.QueryString["RefundVoucherNo"] != null)
        {
            lblRefundVoucherNo.Text = Request.QueryString["RefundVoucherNo"].ToString();
            
        }
        if (Request.QueryString["Date"] != null)
        {
            lblInvoiceDate.Text = Request.QueryString["Date"].ToString();
        }
        else
        {
            lblInvoiceDate.Text = OrgDateTimeZone;
        }
        
        //Int64.TryParse(Request.QueryString["RefundAmount"].ToString(), out refundAmount);

        //List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        string sumamount, Currency;
        double amt;
        long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            Currency = lstConfig[0].ConfigValue;
        }
        else
        {
            Currency = CurrencyName;
        }


        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
        amt = Convert.ToDouble(totRefundAmt.ToString());

        if (amt > 0)
        {
            sumamount = Utilities.FormatNumber2Word(num.Convert(amt.ToString()));
        }
        else
        {
            sumamount = "";
        }
        lblAmountword.Text = sumamount.ToString();
        lblCurrency.Text = Currency;
        if (Request.QueryString["BilledBy"] != null)
        {
            lblPassedBy.Text = ("Passed By <br>(" + Request.QueryString["BilledBy"].ToString() + ")").ToUpper();
        }
        else
        {
            List<Users> lstUsers = new List<Users>();
            //INVUser.GetUserDetail(AssingTo, out lstUser);
            INVUser.GetUserDetail(LID, out lstUsers); 
            //lblPassedBy.Text = lstBillingDetails[0].FORENAME.ToString();
            if (!String.IsNullOrEmpty(lstBillingDetails[0].FORENAME.ToString()))
            {
                lblPassedBy.Text = ("Passed By <br>(" + lstBillingDetails[0].FORENAME.ToString().Trim().ToLower() + ")");
            }
            if (!String.IsNullOrEmpty(lstUsers[0].Name.ToString()))
            {
                lblApprovedBy.Text = ("Approved By <br>(" + lstUsers[0].Name.ToString().Trim().ToLower() + ")");
            }
        }
        
        //lblPassedBy.Text = ("Passed By <br>(" + Name + ")").ToUpper();
        lblAccountant.Text = Usrsign;
        lblReceiverSign.Text = Usrname;
    }

    protected void gvResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (Request.QueryString["btype"] == "CAN")
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    if (refToPatient == "Y")
                    {
                        e.Row.Cells[2].Text = "CancelledAmount";
                    }
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Request.QueryString["btype"] == "CAN")
                {
                    //gvResult.Columns[2].Visible = false;
                    gvResult.Columns[3].Visible = false;
                }
                else
                {
                    gvResult.Columns[2].Visible = false;
                    gvResult.Columns[3].Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while laoding", ex);
        }
    }

}
