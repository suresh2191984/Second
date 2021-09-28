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
using NumberToWord;
using System.IO;
using System.Text;
using Attune.Utilitie.Helper;


public partial class CommonControls_DueChartList : BaseControl
{
    protected string _PatientName = "";
    public string PatientName
    {
        get { return _PatientName; }
        set { _PatientName = value; }
    }

    protected string _RaisedDate = "";
    public string RaisedDate
    {
        get { return _RaisedDate; }
        set { _RaisedDate = value; }
    }
    protected string _interimBillNo;
    public string InterimBillNo
    {
        get { return _interimBillNo; }
        set { _interimBillNo = value; }
    }

    public long PatientID { get; set; }
    public long VisitID { get; set; }
    public string LabNo { get; set; }
    public long ViewBill { get; set; }
    protected string isSurgeryBill = "N";
    public string IsSurgeryBill
    {
        get { return isSurgeryBill; }
        set { isSurgeryBill = value; }
    }
    int intLines = 0;
    int intLimit = 5;
    int intCnt = 0;
    int lineitemcount = 1;
    int strChatLimit = 35;
    string PharmacyName = string.Empty;
    public bool isDynamicPrint { get; set; }

    public void IsSurgeryHideItems()
    {
        trTotal.Attributes.Add("Style", "display:none");
        trTotalAmount.Attributes.Add("Style", "display:none");

        gvIndents.Columns[5].Visible = false;
        gvIndents.Columns[6].Visible = false;
    }
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string PharmacyBillNoConfig = string.Empty;
    string PharmacyBillNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");

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
                    long returncode = -1;
                    lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
                    if (OrgID == 127)
                    {

                        returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {

                            if (lstInventoryConfig[0].ConfigValue != "")
                            {
                                PharmacyName = lstInventoryConfig[0].ConfigValue;
                                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyAddress", OrgID, ILocationID, out lstInventoryConfig);
                                if (lstInventoryConfig.Count > 0)
                                {
                                    lblHospitalName.InnerHtml = PharmacyName + " <br> " + lstInventoryConfig[0].ConfigValue;
                                }

                            }

                        }
                    }
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
            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "BorderStyle Width", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                tblBillPrint.Style.Add("border-width", lstConfig[0].ConfigValue.Trim());
            }

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Border Width", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                tblBillPrint.Width = lstConfig[0].ConfigValue.Trim();
            }
        }
    }

    public void SetBillDetails()
    {
        lblName.Text = PatientName;
        lblReferenceNo.Text = InterimBillNo.ToString();
        NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();


        lblRaisedDate.Text = RaisedDate;
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
        BillingEngine objBillingBL = new BillingEngine(base.ContextInfo);
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<Patient> lstPatient = new List<Patient>();
        List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
        new PatientVisit_BL(base.ContextInfo).GetInterimDueChart(out lstDueChart, out lstPatient, OrgID, PatientID, VisitID, InterimBillNo, IsSurgeryBill == null ? "N" : IsSurgeryBill);

        gvIndents.DataSource = lstDueChart;
        gvIndents.DataBind();
        decimal totalAmount = 0;
        foreach (GridViewRow row in gvIndents.Rows)
        {
            Label amount = (Label)row.FindControl("txtAmount");
            totalAmount += Convert.ToDecimal(amount.Text);
        }
        if (IsSurgeryBill == "Y")
        {
            //IsSurgeryHideItems();
        }
        new GateWay(base.ContextInfo).GetInventoryConfigDetails("Show_Pharmacy_BillNo_EachReceipt_And_InterimBill", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            PharmacyBillNoConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
        }
        if (PharmacyBillNoConfig == "Y")
        {


            if (lstDueChart.Count > 0)
            {
                PharmacyBillNo = lstDueChart[0].ReferenceType;
                lblPharmacybillNovalue.Text = PharmacyBillNo;
                lblPharmacybillNovalue.Visible = true;
                lblPharmacyBillNo.Visible = true;

            }

        }
        else
        {
            //lblPharmacyBillNo.Visible = false;
            //lblPharmacybillNovalue.Visible = false;
            PharmacyBillNo = "";
        }
           

        //--------------------------------------------LabNo
        if (lstDueChart.Count > 0 && lstDueChart[0].LabNo != null && lstDueChart[0].LabNo != "" && lstDueChart[0].LabNo != (-1).ToString())
        {
            trDuecharLabno.Visible = true;
            lblLabNo.Text = lstDueChart[0].LabNo.ToString();
            lblReferenceName.Text = lstDueChart[0].RefPhyName.ToString();
        }
        else if (lstDueChart.Count > 0 && lstDueChart[0].LabNo == (-1).ToString())
        {
            trDuecharLabno.Visible = false;
            lblReferenceName.Text = lstDueChart[0].RefPhyName.ToString();
        }
        else
        {
            trDuecharLabno.Visible = false;
        }
        //--------------------------------------------------
        dvDetails.Visible = true;
        // decimal totalvalue = Math.Round(totalAmount);
        lblTotal.Text = totalAmount.ToString("0.00");
        dvAdvance.Visible = false;
        if (lstPatient.Count > 0)
        {
            if (lstPatient[0].Name != null && lstPatient[0].Name != "")
            {
                lblName.Text = lstPatient[0].Name;
            }
            lblPNumber.Text = lstPatient[0].PatientNumber;
            lblAge.Text = lstPatient[0].Age;
            lblAge.Text = lstPatient[0].Age;

        }

        if (Convert.ToDouble(lblTotal.Text.Split('/')[0]) > 0)
        {
            if (LanguageCode == "en-GB")
            {
                if (int.Parse(lblTotal.Text.Split('/')[0].Split('.')[1]) > 0)
                {
                    LblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblTotal.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only";
                }
                else
                {
                    LblAmount.Text = num.Convert(lblTotal.Text.Split('/')[0]) + " Only";
                }
            }
            else if (LanguageCode == "id-ID")
            {
                if (int.Parse(lblTotal.Text.Split('/')[0].Split(',')[1]) > 0)
                {
                    LblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblTotal.Text.Split('/')[0])) + " " + MinorCurrencyName;
                }
                else
                {
                    string lsConvertAmount = lblTotal.Text.Split('/')[0].Replace(',', '.');
                    LblAmount.Text = num.Convert(lsConvertAmount);
                }
            }
        }
        else
        {
            LblAmount.Text = " Zero Only";
        }
        returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblCurrency.Text = lstConfig[0].ConfigValue;
        }
        else
        {
            lblCurrency.Text = CurrencyName;
        }
        if (Request.QueryString["RBY"] != null)
        {
            string BilledBy = string.Empty;
            BilledBy = Request.QueryString["RBY"].ToString();
            lblBilledBy.Text = ("Raised By: (" + BilledBy.Replace(".,", "") + ")").ToUpper();
        }
        else
        {
            if (lstDueChart.Count > 0)
            {
                lblBilledBy.Text = ("Raised By: (" + lstDueChart[0].BilledBy + ")").ToUpper();
            }
            else
            {
                lblBilledBy.Text = ("Raised By: (" + UserName.Replace(".,", "") + ")").ToUpper();
            }

        }
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.Receipt;
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);

        if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
        {
            isDynamicPrint = true;
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
            int pageNo = 1;
            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            new PatientVisit_BL(base.ContextInfo).GetInterimDueChart(out lstDueChart, out lstPatient, OrgID, PatientID, VisitID, InterimBillNo, IsSurgeryBill == null ? "N" : IsSurgeryBill);



            StringBuilder objprint = new StringBuilder();
            PrinterHelper.PrintStartAndEnd(ref objprint, "S");
            PrinterHelper.PrintHeaderCondant(ref objprint, "Patient Interim Dues", "N");
            PrinterHelper.InrmPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age, lstDueChart[0].InterimBillNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate.Text, lstPatient[0].PatientNumber, RaisedDate, lstDueChart[0].LabNo.ToString(), lstDueChart[0].RefPhyName.ToString(), PharmacyBillNo);
            //objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            //        "<tr>" +
            //           "<td height=15 colspan=3 width=10%>&nbsp;</td>" +

            //       "</tr> </table>");
            objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                    "<tr style=font-weight:bold;>" +
                       "<td width=10%>S.NO</td>" +
                       "<td width=60%>Description</td>" +
                        "<td width=10%>UnitPrice</td>" +
                       "<td width=10%>Quantity</td>" +
                       "<td width=10% align=right>Amount </td>" +
                   "</tr> ");


            string ItemValues = "";
            int breakLineCount = 0;
            string perPrintTest = "";
            int tempLineItem = 0;

            foreach (PatientDueChart item in lstDueChart)
            {

                intCnt = intCnt + 1;
                ItemValues = item.Description.ToWordWrap(strChatLimit, out breakLineCount);
                if ((intLines + breakLineCount) > intLimit && breakLineCount != intLimit)
                {
                    perPrintTest = "<tr>" +
                        "<td width=12%>" + intCnt + "</td>" +
                        "<td width=50%>" + ItemValues + "</td>" +
                        "<td width=12%>" + item.Amount + "</td>" +
                        "<td width=12%>" + item.Unit + " </td>" +
                        "<td width=14% align=right>" + (item.Amount * item.Unit).ToString("0.00") + " </td>" +
                    "</tr>";
                }
                else
                {
                    objprint.Append("<tr>" +
                        "<td width=12%>" + intCnt + "</td>" +
                        "<td width=50%>" + ItemValues + "</td>" +
                        "<td width=12%>" + item.Amount + "</td>" +
                        "<td width=12%>" + item.Unit + " </td>" +
                        "<td width=14% align=right>" + (item.Amount * item.Unit).ToString("0.00") + " </td>" +
                    "</tr>");
                }
                if (intCnt != lstBillingDetails.Count || perPrintTest != "")
                {
                    intLines = (intLines + breakLineCount) == intLimit ? (intLines + breakLineCount) + 1 : (intLines + breakLineCount);
                }
                if (intLines > intLimit)
                {
                    if (intCnt <= lstDueChart.Count)
                    {
                        pageNo = pageNo + 1;
                        objprint.Append("</table><p style=\"page-break-before:always\"></p>");
                        objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
                                        "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");

                        PrinterHelper.InrmPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age, lstDueChart[0].InterimBillNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate.Text, lstPatient[0].PatientNumber, RaisedDate, lstDueChart[0].LabNo.ToString(), lstDueChart[0].RefPhyName.ToString(), PharmacyBillNo);
                        tempLineItem = intLines;
                        intLines = 0;
                        objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
                                        "<tr style=font-weight:bold;>" +
                                        "<td width=12%>S.NO</td>" +
                                       "<td width=50%>Description</td>" +
                                        "<td width=12%>UnitPrice</td>" +
                                       "<td width=12%>Quantity</td>" +
                                       "<td width=14% align=right>Amount </td>" +
                                        "</tr> "
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
            string grossbill = String.Format("{0:0.00}", Math.Round(lstBillingDetails.Sum(p => p.Rate)));
            PrinterHelper.PrintIPInrmAmountDetails(ref objprint, lblTotal.Text.ToString(), lstDueChart[0].Amount.ToString(), lstDueChart[0].Amount.ToString(), "sample", (lstDueChart[0].CreatedAt).ToString());
            PrinterHelper.PrintInrmAmountFooter(ref objprint, lblCurrency.Text + "-" + LblAmount.Text.ToString(), lblBilledBy.Text);
            PrinterHelper.PrintStartAndEnd(ref objprint, "E");
            tdPrint.InnerHtml = objprint.ToString();


            //if (IsSurgeryBill == "Y")
            //{

            //    StringBuilder objprint = new StringBuilder();
            //    PrinterHelper.PrintStartAndEnd(ref objprint, "S");
            //    PrinterHelper.PrintHeaderCondant(ref objprint, "Patient Interim Dues", "N");
            //    PrinterHelper.InrmPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age, lstDueChart[0].InterimBillNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate.Text, lstPatient[0].PatientNumber, RaisedDate, lstDueChart[0].LabNo.ToString(),lstDueChart[0].RefPhyName.ToString());
            //    //objprint.Append("<table  width=100% border=0 cellspacing=0 cellpading=0>" +
            //    //        "<tr>" +
            //    //           "<td height=15 colspan=3 width=10%>&nbsp;</td>" +

            //    //       "</tr> </table>");
            //    objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
            //            "<tr style=font-weight:bold;>" +
            //               "<td width=10%>S.NO</td>" +
            //               "<td width=60%>Description</td>" +                           
            //               "<td width=10%>Quantity</td>" +                           
            //           "</tr> ");


            //    string ItemValues = "";
            //    int breakLineCount = 0;
            //    string perPrintTest = "";
            //    int tempLineItem = 0;

            //    foreach (PatientDueChart item in lstDueChart)
            //    {

            //        intCnt = intCnt + 1;
            //        ItemValues = item.Description.ToWordWrap(strChatLimit, out breakLineCount);
            //        if ((intLines + breakLineCount) > intLimit && breakLineCount != intLimit)
            //        {
            //            perPrintTest = "<tr>" +
            //                "<td width=12%>" + intCnt + "</td>" +
            //                "<td width=50%>" + ItemValues + "</td>" +                           
            //                "<td width=12%>" + item.Unit + " </td>" +                           
            //            "</tr>";
            //        }
            //        else
            //        {
            //            objprint.Append("<tr>" +
            //                "<td width=12%>" + intCnt + "</td>" +
            //                "<td width=50%>" + ItemValues + "</td>" +                          
            //                "<td width=12%>" + item.Unit + " </td>" +
            //            "</tr>");
            //        }
            //        if (intCnt != lstBillingDetails.Count || perPrintTest != "")
            //        {
            //            intLines = (intLines + breakLineCount) == intLimit ? (intLines + breakLineCount) + 1 : (intLines + breakLineCount);
            //        }
            //        if (intLines > intLimit)
            //        {
            //            if (intCnt <= lstDueChart.Count)
            //            {
            //                pageNo = pageNo + 1;
            //                objprint.Append("</table><p style=\"page-break-before:always\"></p>");
            //                objprint.Append("<table  width=100% border=0 cellspacing=2 cellpading=2>" +
            //                                "<tr>" + "<td align=center>(" + pageNo + ")</td>" + "</tr> </table>");

            //                PrinterHelper.InrmPrintPatientDetails(ref objprint, lstPatient[0].Name, lstPatient[0].Age, lstDueChart[0].InterimBillNo.ToString(), lstPatient[0].IPNumber, lblInvoiceDate.Text, lstPatient[0].PatientNumber, RaisedDate, lstDueChart[0].LabNo.ToString(),lstDueChart[0].RefPhyName.ToString());
            //                tempLineItem = intLines;
            //                intLines = 0;
            //                objprint.Append("<table  width=100% border=0 cellspacing=1 cellpading=1>" +
            //                                "<tr style=font-weight:bold;>" +
            //                                "<td width=12%>S.NO</td>" +
            //                               "<td width=50%>Description</td>" +                                           
            //                               "<td width=12%>Quantity</td>" +                                            
            //                                "</tr> "
            //            );
            //                if (perPrintTest != "")
            //                {
            //                    intLines = breakLineCount;
            //                    objprint.Append(perPrintTest);
            //                    perPrintTest = "";

            //                }
            //            }
            //        }
            //    }
            //    objprint.Append("</table>");

            //    //decimal NetValue = Math.Round(lstBillingDetails.Sum(p => p.Rate));
            //    //string grossbill = String.Format("{0:0.00}", Math.Round(lstBillingDetails.Sum(p => p.Rate)));
            //    //PrinterHelper.PrintIPInrmAmountDetails(ref objprint, lblTotal.Text.ToString(), lstDueChart[0].Amount.ToString(), lstDueChart[0].Amount.ToString(), "sample", (lstDueChart[0].CreatedAt).ToString());
            //    PrinterHelper.PrintInrmAmountFooter1(ref objprint, lblBilledBy.Text);
            //    PrinterHelper.PrintStartAndEnd(ref objprint, "E");
            //    tdPrint.InnerHtml = objprint.ToString();
            //}

        }

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
    public string getprinter()
    {
        return tdPrint.InnerHtml;
    }



    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (OrgID == 78)
            {
                gvIndents.Columns[2].Visible = false;
                gvIndents.Columns[3].Visible = false;
            }
        }
    }

}
