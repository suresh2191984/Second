using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using System.Text;
using Attune.Utilitie.Helper;
using Attune.Kernel.NumberToWordConversion;
public partial class CommonControls_AdvanceReceipt : BaseControl
{
    protected string _PatientName = "";
    public string PatientName
    {
        get { return _PatientName; }
        set { _PatientName = value; }
    }

    protected string _PaidDate = "";
    public string PaidDate
    {
        get { return _PaidDate; }
        set { _PaidDate = value; }
    }
    protected string _ReceiptNo = "";
    public string ReceiptNo
    {
        get { return _ReceiptNo; }
        set { _ReceiptNo = value; }
    }
    protected string _ReceiptType = "";
    public string ReceiptType
    {
        get { return _ReceiptType; }
        set { _ReceiptType = value; }
    }
    protected string _ReceiptModel = "";
    public string ReceiptModel
    {
        get { return _ReceiptModel; }
        set { _ReceiptModel = value; }
    }
    protected string _Amount = "0";

    public string Amount
    {
        get { return _Amount; }
        set { _Amount = value; }
    }
    protected string _Duplicate = "N";

    public string Duplicate
    {
        get { return _Duplicate; }
        set { _Duplicate = value; }
    }
    public string NumtoWord = string.Empty;
    public string patientNumberDue { get; set; }
    public long PatientID { get; set; }
    public long VisitID { get; set; }
    public long InterMedID { get; set; }
    public string sType { get; set; }
    public string LabNo { get; set; }
    public long pvid = -1;
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;

    int strChatLimit = 35;
    public bool Ippayments { get; set; }
    string strbill = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_09 == null ? "BILLED BY" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_09;
    string strdue = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_12 == null ? "Due Collection" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_12;
    string strtot = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_13 == null ? "Total Due Amount :" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_13;

    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060 == null ? "Male" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_060;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059 == null ? "Female" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_059;
    string strVet = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_070 == null ? "Veterinary" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_070;
    string strNa = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071 == null ? "NA" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_071;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strAM = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_15 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_15;
    string strPM = Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_16 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_AdvanceBillPrint_ascx_16;
	string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    public CommonControls_AdvanceReceipt()
        : base("CommonControls_AdvanceReceipt_ascx")
    {
    }
    BillingEngine billingBL;
    //List<PaymentType> lstPaymentType = new List<PaymentType>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long.TryParse(Request.QueryString["VID"], out pvid);
            if (_ReceiptType == "Deposit")
            {
                if (Request.QueryString["Duplicate"] != null)
                    Duplicate = Request.QueryString["Duplicate"];
                if (Duplicate == "Y")
                    tdReceiptType.InnerText = "Deposit Receipt (Duplicate Copy)";
                else
                    tdReceiptType.InnerText = "Deposit Receipt";
                dvAdvance.InnerText = "Deposit Payment";
            }

            //lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
            List<Config> lstConfig = new List<Config>();
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.Receipt;

            //Need Header In IPReceipt Print Page
            string strConfigKey = "NeedHeaderInIPR";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            if (configValue == "Y")
            {
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
                    //lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
                    lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim().Replace(",,,,", ",");
                    lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,,", ",");
                    lblHospitalName.InnerHtml = lblHospitalName.InnerHtml.Replace(",,", ",");
                }
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
                //tblBillPrint.Style.Add("border-width" ,lstConfig[0].ConfigValue.Trim());
            }

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "BorderStyle Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("border-width", lstConfig[0].ConfigValue.Trim());
            }


        }
    }

    public void SetBillDetails()
    {
        if (Request.QueryString["Duplicate"] != null)
            Duplicate = Request.QueryString["Duplicate"];
        if (Duplicate == "Y")
            Rs_PaymentReceipt.Text = "Payment Receipt (Duplicate Copy)";
        lblName.Text = PatientName;
        if (Request.QueryString["RNAME"] != null)
            lblName.Text = Request.QueryString["RNAME"].ToString();
        lblReceiptNo.Text = ReceiptNo;
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.Receipt;
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();

        if (Request.QueryString["PNumber"] != null)
        {
            string PNo = string.Empty;
            PNo = Request.QueryString["PNumber"].ToString();
            lblPatientNo.Text = PNo;

        }
        if (Request.QueryString["PNumber"] == null)
        {

            if (patientNumberDue != "-1")
            {
                lblPatientNo.Text = patientNumberDue.ToString(); ;

            }
            else
            {
                lblPatientNo.Text = "";
            }
        }
        if (Request.QueryString["Age"] != null)
        {
            lblAge.Text = Request.QueryString["Age"].ToString();
        }
        NumtoWord = GetConfigValue("NumberToWord", OrgID);
        List<Config> lstConfig = new List<Config>();
        GateWay gateWay = new GateWay(base.ContextInfo);
        long returnCode = gateWay.GetConfigDetails("ShowDisclaimer", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            if (lstConfig[0].ConfigValue.ToLower() == "n")
            {
                dvDisclaimer.Visible = false;
            }
            else
            {
                dvDisclaimer.Visible = true;
            }
        }
        lstConfig = new List<Config>();
        gateWay = new GateWay(base.ContextInfo);
        returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblCurrency.Text = lstConfig[0].ConfigValue;
        }
        else
        {
            lblCurrency.Text = CurrencyName;
        }
        List<PaymentType> lstPaymentType = new List<PaymentType>();
        List<PaymentType> lstOtherCurrency = new List<PaymentType>();
        List<PaymentType> lstDepositAmt = new List<PaymentType>();
        int payingPage = 2;
        long FinalbillID = 0;
        if (sType.ToUpper() == "IPPAYMENTS")
        {
            BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);

            List<Patient> lstPatient = new List<Patient>();
            ReceiptModel = "";
            objBillingBL.GetReceiptDetails(VisitID, PatientID, OrgID, InterMedID, ReceiptNo, ReceiptModel, out lstBillingDetails, out lstPatient);

            #region for KMH Changes

            pvid = -1;
            long.TryParse(Request.QueryString["VID"], out pvid);
            if (_ReceiptType == "Deposit")
            {
                payingPage = 3;
            }
            billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetPaymentMode(FinalbillID, pvid, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
            decimal depamt = 0;
            string appString = string.Empty;
            int flag = 0;
            for (int i = 0; i < lstPaymentType.Count; i++)
            {
                if (flag == 0)
                {
                    appString = lstPaymentType[i].PayDetails + "<br>";
                }
                else
                {
                    appString = appString + lstPaymentType[i].PayDetails + "<br>";
                }
                flag++;

            }
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
            if (lstPatient[0].SEX == "M")
                lstPatient[0].SEX = strMale;
            else if (lstPatient[0].SEX == "F")
                lstPatient[0].SEX = strFemale;
            else if (lstPatient[0].SEX == "V")
                lstPatient[0].SEX = strVet;
            else if (lstPatient[0].SEX == "N")
                lstPatient[0].SEX = strNa;
			 else if (lstPatient[0].SEX == "U")
                lstPatient[0].SEX = strUnknownF;
            else
                lstPatient[0].SEX = "";
            if (lstPatient.Count > 0)
            {
                lblPatientNo.Text = lstPatient[0].PatientNumber;
                lblAge.Text = lstPatient[0].Age + " / " + lstPatient[0].SEX;
                lblName.Text = lstPatient[0].Name;
            }
            if (lstBillingDetails.Count > 0)
            {
                appString = appString + lstBillingDetails[0].PaymentName + "<br>";
                lblPaidDate.Text = lstBillingDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            }
            if (lstDepositAmt.Count > 0 && lstDepositAmt[0].AmountUsed > 0)
            {
                lblDepositAmtUsed.Visible = true;
                lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                depamt = lstDepositAmt[0].AmountUsed;

            }
            lblPaymentMode.Text = appString;
            hdnpaymode.Value = appString;
            #endregion

            if (OrgID == 26)
            {
                gvIndents.Visible = false;

            }

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);
            decimal amtRec = 0;
            string Amt = "";
            decimal amtReceived = 0;
            StringBuilder objprint = new StringBuilder();
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
            {
                Ippayments = true;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Print_LineItem_Limit", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    intLimit = Convert.ToInt32(lstConfig[0].ConfigValue) == 0 ? intLimit : Convert.ToInt32(lstConfig[0].ConfigValue);
                }
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Print_Char_Limit", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    strChatLimit = Convert.ToInt32(lstConfig[0].ConfigValue) == 0 ? strChatLimit : Convert.ToInt32(lstConfig[0].ConfigValue);
                }
                string physicianName = string.Empty;
                string splitstatus = string.Empty;

                string lblInvoiceDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                string LabNo = string.Empty;
                int pageNo = 1;

                //objBillingBL.GetReceiptDetails(VisitID, PatientID, OrgID, InterMedID,ReceiptNo,ReceiptModel, out lstBillingDetails, out lstPatient);
                PaidDate = lstBillingDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");


                PrinterHelper.PrintStartAndEnd(ref objprint, "S");
                PrinterHelper.PrintHeaderCondant(ref objprint, "Payment Receipt", Duplicate);
                LabNo = lstBillingDetails[0].LabNo.ToString();
                PrinterHelper.IpReceiptPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age + "/" + lstPatient[0].SEX, ReceiptNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate, lstPatient[0].PatientNumber, PaidDate, LabNo);
                objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                        "<tr style=font-weight:bold;>" +
                           "<td width=5%>S.No</td>" +
                           "<td width=55%>Description</td>" +
                            "<td width=10% align=center >Date</td>" +
                            "<td width=10%>UnitPrice</td>" +
                           "<td width=10%>Quantity</td>" +
                           "<td width=10% align=right >Amount </td>" +
                       "</tr> ");
                string ItemValues = "";
                int breakLineCount = 0;
                string perPrintTest = "";
                int tempLineItem = 0;
                lblPaidDate.Text = lstBillingDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");

                foreach (BillingDetails item in lstBillingDetails)
                {
                    intCnt = intCnt + 1;
                    ItemValues = item.FeeDescription.ToWordWrap(strChatLimit, out breakLineCount);
                    if ((intLines + breakLineCount) > intLimit && breakLineCount != intLimit)
                    {
                        perPrintTest = "<tr valign=top>" +
                           "<td width=5%>" + intCnt + "</td>" +
                           "<td width=55%>" + ItemValues + "</td>" +
                           "<td width=10% align=center>" + item.FromDate.ToString("dd/MM/yyyy") + "</td >" +
                           "<td width=10%>" + item.Amount.ToString("0.00") + "</td>" +
                           "<td width=10%>" + item.Quantity + " </td>" +
                           "<td width=10% align=right>" + item.Rate.ToString("0.00") + " </td>" + "</tr>";

                    }
                    else
                    {
                        objprint.Append("<tr valign=top>" +
                         "<td width=5%>" + intCnt + "</td>" +
                         "<td width=55%>" + ItemValues + "</td>" +
                         "<td width=10% align=center>" + item.FromDate.ToString("dd/MM/yyyy") + "</td >" +
                         "<td width=10%>" + item.Amount.ToString("0.00") + "</td>" +
                         "<td width=10%>" + item.Quantity + " </td>" +
                         "<td width=10% align=right>" + item.Rate.ToString("0.00") + " </td>" + "</tr>");

                    }
                    amtRec += Convert.ToDecimal(item.Rate);
                    if (intCnt != lstBillingDetails.Count || perPrintTest != "")
                    {
                        intLines = (intLines + breakLineCount) == intLimit ? (intLines + breakLineCount) + 1 : (intLines + breakLineCount);
                    }
                    if (intLines > intLimit)
                    {
                        if (intCnt <= lstBillingDetails.Count)
                        {
                            pageNo = pageNo + 1;
                            objprint.Append("</table><p style=\"page-break-before:always\"></p>");
                            objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                            "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");
                            PrinterHelper.IpReceiptPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age + "/" + lstPatient[0].SEX, ReceiptNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate, lstPatient[0].PatientNumber, PaidDate, LabNo);
                            tempLineItem = intLines;
                            intLines = 0;
                            objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                            "<tr>" + "<td height=2 colspan=3 width=10%></td>" +
                                            "</tr> </table>" +
                                            "<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                            "<tr style=font-weight:bold;>" +
                                            "<td width=5%>S.NO</td>" +
                                            "<td width=55%>Description</td>" +
                                            "<td width=10% align=center >Date</td>" +
                                            "<td width=10%>UnitPrice</td>" +
                                            "<td width=10%>Quantity</td>" +
                                            "<td width=10% align=right>Amount </td>" + "</tr> "
                        );
                            if (perPrintTest != "")
                            {
                                intLines = breakLineCount;
                                objprint.Append(perPrintTest);
                                perPrintTest = "";

                            }

                        }
                    }

                }
                objprint.Append("</table>");

                decimal NetValue = Math.Round(lstBillingDetails.Sum(p => p.Rate));
                string RecAmount = String.Format("{0:0.00}", Math.Round(lstBillingDetails[0].AmountReceived));
                string pUser = "";
                string grossbill = String.Format("{0:0.00}", Math.Round(lstBillingDetails.Sum(p => p.Rate)));
                if (Convert.ToDouble(amtRec) > 0)
                {
                    lblAmountRecieved.Text = amtRec.ToString();
                    amtReceived = Convert.ToDecimal(String.Format("{0:0.00}", amtRec));
                    if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
                    {
                        Amt = "Received Amount in Words:" + lblCurrency.Text.ToString() + "-" + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                        Amt = "Received Amount in Words:" + lblCurrency.Text.ToString() + "-" + num.Convert(lblAmountRecieved.Text) + " Only";
                    }
                }
                else
                {
                    Amt = "";
                }
                lblBilledBy.Text = (strbill + " (" + lstBillingDetails[0].BilledBy.Replace(".,", "") + ")").ToUpper();

                pUser = (strbill + " (" + lstBillingDetails[0].BilledBy.Replace(".,", "") + ")").ToUpper();
                PrinterHelper.PrintIPAmountDetails(ref objprint, NetValue.ToString(), amtReceived.ToString(), grossbill, lblPaymentMode.Text, (lstBillingDetails[0].CreatedAt).ToString());
                PrinterHelper.PrintIPAmountFooter(ref objprint, Amt, pUser);
                PrinterHelper.PrintStartAndEnd(ref objprint, "E");
                tdPrint.InnerHtml = objprint.ToString();
                if (Request.QueryString["usr"] == null)
                {
                    // ScriptManager.RegisterStartupScript(this, GetType(), "PrintTest", "javascript:fnCallPrint('" + tdPrint.ClientID + "');", true);
                    Response.Write(tdPrint.InnerHtml);
                    ScriptManager.RegisterStartupScript(this, GetType(), "PrintTest", "javascript: window.print();", true);
                    tbl1.Style.Add("display", "none");
                }
                gvIndents.DataSource = lstBillingDetails;
                gvIndents.DataBind();
            }

            /////sample print

            else
            {
                if (NumtoWord == "Y")
                {
                    Attune.Kernel.NumberToWordConversion.Attune_NumberToWord obj = new Attune.Kernel.NumberToWordConversion.Attune_NumberToWord();
                    Amt = lblCurrency.Text.ToString() + "-" + obj.ConvertToWord(lblAmountRecieved.Text, base.ContextInfo.LanguageCode) + " Sólo";
                    //ConvertToWord
                }
                else
                {
                if (Convert.ToDouble(lstBillingDetails[0].AmountReceived) > 0)
                {
                    lblAmountRecieved.Text = lstBillingDetails[0].AmountReceived.ToString("0.00");
                    amtReceived = Convert.ToDecimal(String.Format("{0:0.00}", lstBillingDetails[0].AmountReceived));
                    if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
                    {
                        Amt = lblCurrency.Text.ToString() + "-" + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                        Amt = lblCurrency.Text.ToString() + "-" + num.Convert(lblAmountRecieved.Text) + " Only";
                        }
                    }
                }
                if (!string.IsNullOrEmpty(lstBillingDetails[0].ReimbursableAmount.ToString()))
                {
                    if (lstBillingDetails[0].ReimbursableAmount > 0)
                    {
                        lblRoundOffAmountText.Text = lstBillingDetails[0].ReimbursableAmount.ToString("0.00");
                        trRoundOffAmount.Style.Add("display", "table-row");
                    }
                    else
                    {
                        trRoundOffAmount.Style.Add("display", "none");
                    }
                }
                else
                {
                    trRoundOffAmount.Style.Add("display", "table-row");
                }
                lblAmount.Text = Amt;
                lblCurrency.Visible = false;
                gvIndents.DataSource = lstBillingDetails;
                gvIndents.DataBind();
            }

            if (lstBillingDetails.Count > 0)
            {
                if (Convert.ToInt64(lstBillingDetails[0].LabNo) > 0)
                {
                    lblAdLabno.Text = lstBillingDetails[0].LabNo.ToString();
                    tdComma.Style.Add("display", "table-cell");
                    lblAdLabno.Style.Add("display", "block");
                    labNumber.Style.Add("display", "block");
                }
            }

            var lstDetails = (from lstbills in lstBillingDetails
                              select ((lstbills.Amount) * (lstbills.Quantity))).Sum();
            dvDetails.Visible = true;
            if (OrgID == 26)
            {

                lblTotal.Text = lblAmountRecieved.Text;
            }
            else
            {
                lblTotal.Text = ((decimal)lstDetails).ToString("0.00");
            }

            if (Convert.ToDecimal(lblTotal.Text) - Convert.ToDecimal(lblAmountRecieved.Text) > 0)
            {
                lblRemainingDue.Visible = true;
                lblRemainingDuevalue.Text = Convert.ToString(Convert.ToDecimal(lblTotal.Text) - Convert.ToDecimal(lblAmountRecieved.Text));

            }

            dvAdvance.Visible = false;
            if (lstPatient != null && lstPatient.Count > 0)
            {
                lblName.Text = lstPatient[0].Name.Trim();
            }
            if (lstBillingDetails.Count > 0)
            {
                lblRefPhy.Text = lstBillingDetails[0].RefPhyName;
            }
            if (lblRefPhy.Text == "")
            {
                refphy.Visible = false;
                lblRefPhy.Visible = false;
                lblrefPhyH.Visible = false;
            }
            else
            {
                refphy.Visible = true;
                lblRefPhy.Text = lstBillingDetails[0].RefPhyName;
                lblRefPhy.Visible = true;
                lblrefPhyH.Visible = true;
            }

            #region for finalbill settlement receipt changes

            if (Request.QueryString["FinalReceipt"] != null)
            {
                decimal excessAmt;
                excessAmt = Convert.ToDecimal(lblAmountRecieved.Text) - Convert.ToDecimal(lstDetails);
                if (excessAmt > 0)
                {
                    lblFinalReceiptAmount.Text = "<b> Previous Receipt Amount: </b>" + excessAmt.ToString("0.00");
                    trPreviousReceipt.Style.Add("display", "table-row");
                }
            }

            #endregion

        }
        else
        {

            if (sType.ToUpper() == "DEPOSIT")
            {
                lblAmountType.Text = "Deposit Amount";
            }
            if (sType.ToUpper() == "ADVANCE")
            {
                lblAmountType.Text = "Advance Payment";
                ReceiptModel = "Advance Receipt";
                lblRemainingDue.Visible = false;
                lblRemainingDuevalue.Visible = false;
            }
            dvDetails.Visible = false;
            dvAdvance.Visible = true;
            lblTotal.Text = lblAmountRecieved.Text;
            refphy.Visible = false;

            lblRefPhy.Visible = false;
            lblrefPhyH.Visible = false;
            if (sType.ToUpper() == "DUE COLLECTION")
            {
                lblAmountType.Text = strdue;
                ReceiptModel = "Due collection";
                lblReceiptNo.Text = ReceiptNo;
            }
            if (sType.ToUpper() == "GENERATEBILL")
            {
                dvGenerateBill.Visible = true;
                refphy.Visible = false;
                lblRefPhy.Visible = false;
                lblrefPhyH.Visible = false;
                dvDetails.Visible = false;
                dvAdvance.Visible = false;
                ReceiptModel = "Generate Bill Receipt";
            }

            if (sType.ToUpper() == "COPAYMENT")
            {
                if (Request.QueryString["Duplicate"] != null)
                    Duplicate = Request.QueryString["Duplicate"];
                if (Duplicate == "Y")
                    Rs_PaymentReceipt.Text = "Co-Payment Receipt (Duplicate Copy)";
                else
                    Rs_PaymentReceipt.Text = "Co-Payment Receipt";
                Rs_PaymentMode.Visible = false;
                ReceiptModel = "Copayment Receipt";
                dvGenerateBill.Visible = true;
                refphy.Visible = false;
                lblRefPhy.Visible = false;
                lblrefPhyH.Visible = false;
                dvDetails.Visible = false;
                dvAdvance.Visible = false;

            }
            if (_ReceiptType == "Deposit")
            {
                payingPage = 3;
            }
            try
            {
                BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
                List<Patient> lstPatient = new List<Patient>();
                objBillingBL.GetReceiptDetails(VisitID, PatientID, OrgID, InterMedID, ReceiptNo, ReceiptModel, out lstBillingDetails, out lstPatient);
                lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm:ss tt");
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
                if (lstPatient[0].SEX == "M")
                    lstPatient[0].SEX = strMale;
                else if (lstPatient[0].SEX == "F")
                    lstPatient[0].SEX = strFemale;
                else if (lstPatient[0].SEX == "V")
                    lstPatient[0].SEX = strVet;
                else if (lstPatient[0].SEX == "N")
                    lstPatient[0].SEX = strNa;
				 else if (lstPatient[0].SEX == "U")
                    lstPatient[0].SEX = strUnknownF;
                else
                    lstPatient[0].SEX = "";
                if (lstPatient.Count > 0)
                {
                    lblPatientNo.Text = lstPatient[0].PatientNumber;
                    lblAge.Text = lstPatient[0].Age + " / " + lstPatient[0].SEX;
                    lblName.Text = lstPatient[0].Name;
                }
                decimal depamt = 0;
                string AmountReceived = string.Empty;
                if (lstBillingDetails.Count > 0)
                {

                    depamt = 0;
                    string appString = string.Empty;
                    if (lstBillingDetails.Count > 0)
                    {
                        //lblPayment.Visible = true;

                        int flag = 0;
                        for (int i = 0; i < lstBillingDetails.Count; i++)
                        {
                            if (flag == 0)
                            {
                                //appString = lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                appString = lstBillingDetails[i].PaymentName + "<br>";
                            }
                            else
                            {
                                //appString = appString + lstPaymentType[i].PayDetails + "-"+lstOtherCurrency[0].CurrencyName+"<br>";
                                appString = appString + lstBillingDetails[i].PaymentName + "<br>";
                            }
                            flag++;

                        }
                    }
                    depamt = lstBillingDetails[0].AmountUsed;
                    lblPaymentMode.Text = appString;
                    //**Remove Round off value**/
                    //AmountReceived = String.Format("{0:0.00}", Math.Round(lstBillingDetails.Sum(p => p.AmountDeposited)));
                    if (sType.ToUpper() == "DUE COLLECTION")
                    {
                        AmountReceived = String.Format("{0:0.00}", (lstBillingDetails[0].AmountDeposited));
                    }
                    else
                    {
                        AmountReceived = String.Format("{0:0.00}", (lstBillingDetails.Sum(p => p.AmountDeposited)));
                    }
                    if (lstBillingDetails[0].AttributeDetail == "OPTICAL")
                    {
                       // lblDeliveryDate.Visible = true;
                        //Rs_DeliveryDate.Visible = true;
                        //divRsDeliveryDate.Style.Add("display", "block");
                        refphy.Visible = true;
                        //lblDeliveryDate.Text = lstBillingDetails[0].ModifiedAt.ToString("dd/MMM/yyyy");
                    }
                    if (Convert.ToDouble(lstBillingDetails[0].AmountDeposited.ToString()) > 0)
                    {
                        //   lblAmountRecieved.Text = lstBillingDetails[0].AmountDeposited.ToString();
                        lblAmountRecieved.Text = AmountReceived;
                        Amount = lstBillingDetails[0].Amount.ToString();
                        if (NumtoWord == "Y")
                        {
                            Attune.Kernel.NumberToWordConversion.Attune_NumberToWord obj = new Attune.Kernel.NumberToWordConversion.Attune_NumberToWord();
                            lblAmount.Text = lblCurrency.Text.ToString() + "-" + obj.ConvertToWord(lblAmountRecieved.Text, base.ContextInfo.LanguageCode) + " Sólo";
                            //ConvertToWord
                        }
                        else
                        {
                        if (int.Parse(lblAmountRecieved.Text.Split('.')[1]) > 0)
                        {
                            lblAmount.Text = "" + Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text)) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            lblAmount.Text = "" + num.Convert(lblAmountRecieved.Text) + " Only";
                            }
                        }
                    }
                    else
                    {
                        lblAmountRecieved.Text = "0.00";
                        lblAmount.Text = "Zero only";

                    }
                    //   lblTotal.Text = lstBillingDetails[0].AmountDeposited.ToString();
                    lblTotal.Text = AmountReceived;
                    lblPaidDate.Text = lstBillingDetails[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                    lblPaidDate.Visible = true;
                    lblBilledBy.Text = (strbill + " (" + lstBillingDetails[0].BilledBy.Replace(".,", "") + ")").ToUpper();
                    if (sType.ToUpper() == "COPAYMENT")
                    {
                        lblGenerateBillAmt.Text = "Co-Payment Charges Rs. " + Amount;
                    }
                    else if (sType.ToUpper() == "GENERATEBILL")
                    {
                        lblGenerateBillAmt.Text = "Amount Received From Final Bill Receipt is " + Amount;
                    }
                }
                if (sType.ToUpper() == "DUE COLLECTION")
                {
                    lstPaymentType = new List<PaymentType>();
                    lstOtherCurrency = new List<PaymentType>();
                    lstDepositAmt = new List<PaymentType>();
                    payingPage = 3;
                    billingBL = new BillingEngine();
                    billingBL.GetPaymentMode(FinalbillID, VisitID, ReceiptNo, payingPage, out lstPaymentType, out lstOtherCurrency, out lstDepositAmt);
                    trAlreadduepaidamt.Style.Add("display", "table-row");
                    trPreviousDuecollection.Style.Add("display", "table-row");
                    Rs_Total.Text = strtot;

                    if (lstDepositAmt.Count > 0 && lstDepositAmt[0].AmountUsed > 0)
                    {
                        //tdDeposittype.Style.Add("display", "block");
                        lblDepositAmtUsed.Visible = true;
                        lblDepositAmtUsed.Text = "Deposit Amount Used - " + lstDepositAmt[0].AmountUsed.ToString("0.00");
                        //depamt = lstDepositAmt[0].AmountUsed;

                    }
                    lblAmountType.Text = strdue;
                    ReceiptModel = "Due collection";
                    Decimal TotalAmount = 0;
                    Decimal AlreadyDuePaidAmount = 0;
                    Decimal PreviousDueCollectionAmt = 0;
                    Decimal DiscountAmount = 0;
                    Decimal RemainingDue = 0;
                    TotalAmount = Convert.ToDecimal(AmountReceived);
                    lblTotal.Text = TotalAmount.ToString();
                    trdiscountamount.Style.Add("display", "table-row");
                    if (lstBillingDetails.Count > 0)
                    {
                        TotalAmount = lstBillingDetails[0].NonReimbursableAmount;
                        //AlreadyDuePaidAmount = lstBillingDetails[0].AgreedAmount;
                        PreviousDueCollectionAmt = lstBillingDetails[0].TransferAmount;
                        DiscountAmount = lstBillingDetails[0].DiscountAmount;
                      
                        if (AlreadyDuePaidAmount == 0)
                        {
                            trAlreadduepaidamt.Style.Add("display", "none");
                        }
                        if (PreviousDueCollectionAmt == 0)
                        {
                            trPreviousDuecollection.Style.Add("display", "none");
                        }
                    }
                    lblDiscountAmount.Text = DiscountAmount.ToString();
                    lblTotal.Text = TotalAmount.ToString();
                    lblAlreadyDuePaidAmountText.Text = AlreadyDuePaidAmount.ToString();
                    lblPreviousDueCollectionAmtText.Text = PreviousDueCollectionAmt.ToString();
                    RemainingDue = lstBillingDetails[0].NonReimbursableAmount - (//lstBillingDetails[0].AgreedAmount +
                        lstBillingDetails[0].AmountDeposited + lstBillingDetails[0].DiscountAmount + lstBillingDetails[0].TransferAmount + lstBillingDetails[0].WriteOffAmt+lstBillingDetails[0].RefundedAmt);
                    lblRemainingDuevalue.Text = String.Format("{0:0.00}", RemainingDue);
                    //lblDueBillNo.Text = lstPatient[0].BillNumber != null ? lstPatient[0].BillNumber : "";
                    //ReceiptBillNo.Style.Add("display", "block");

                    /*added By jagatheesh*/
                    decimal amt = Convert.ToDecimal(lstBillingDetails[0].WriteOffAmt);
                   
                    if (amt > 0)
                    {
                        lblWriteOffAmt1.Text = lstBillingDetails[0].WriteOffAmt.ToString();
                    }
                    else
                    {
                        lblWriteOffAmt.Text = "";
                        lblWriteOffAmt1.Text = "";
                    }

                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Advance Receipt SetBillDetails Method ", ex);
            }
        }
    }
    public string getprinter()
    {
        return tdPrint.InnerHtml;
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
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



}
