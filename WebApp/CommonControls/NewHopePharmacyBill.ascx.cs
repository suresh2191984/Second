using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_NewHopePharmacyBill : BaseControl
{
    long visitID = -1;
    string pageid = string.Empty;
    long returncode = -1;
    string pagename = string.Empty;
    long patientID = -1;
    long dup = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["dup"], out dup);
                long FinalBillID = 0;
                Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
                if (dup == 1)
                {
                    Duplicate.Visible = true;
                    Duplicate.Text = "Duplicate Copy";
                }
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in GracePrintBill.aspx", ex);
            }
        }
    }
    public void BillPrinting(long visitID, long FinalbillID)
    {
        try
        {
            string physicianName = string.Empty;
            string licenceNo = string.Empty;
            string tinNo = string.Empty;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();

            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            //inventoryBL.GetInvBillPrintingDetails(visitID, out lstBillingDetail,
            //                                out lstFinalBillDetail, out lstPatientDetails,
            //                                out lstOrganization, out physicianName,
            //                                out lstDuePaidDetails, FinalbillID);
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

            List<Users> lstUsers = new List<Users>();
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);
            List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig1);
            if (dup == 1)
            {
                Duplicate.Visible = true;
                Duplicate.Text = "Duplicate Copy";
            }
            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
            {
                TableRow tbrPatientDetails1 = new TableRow();
                TableCell tcPD_PB = new TableCell();
                tcPD_PB.Attributes.Add("align", "left");
                tcPD_PB.Width = Unit.Pixel(91);

                TableCell tcPD_PBV = new TableCell();
                tcPD_PB.Attributes.Add("align", "left");
                tcPD_PBV.Width = Unit.Pixel(242);
                tcPD_PBV.Font.Size = 11;
                tcPD_PBV.Text = lstFinalBillDetail[0].Physician;

                TableCell tcPD_BN = new TableCell();
                tcPD_PB.Attributes.Add("align", "left");
                tcPD_BN.Width = Unit.Pixel(42);

                TableCell tcPD_BNV = new TableCell();
                tcPD_BNV.Attributes.Add("align", "left");
                tcPD_BNV.Width = Unit.Pixel(159);
                tcPD_BNV.Font.Size = 11;
                tcPD_BNV.Text = lstFinalBillDetail[0].BillNumber;

                TableRow tbrPatientDetails2 = new TableRow();

                TableCell tcPD_NM = new TableCell();
                tcPD_NM.Attributes.Add("align", "left");
                tcPD_NM.Width = Unit.Pixel(91);

                TableCell tcPD_NMV = new TableCell();
                tcPD_NMV.Attributes.Add("align", "left");
                tcPD_NMV.Width = Unit.Pixel(242);
                tcPD_NMV.Font.Size = 11;
                tcPD_NMV.Text = lstPatientDetails[0].Name;

                TableCell tcPD_DT = new TableCell();
                tcPD_DT.Attributes.Add("align", "left");
                tcPD_DT.Width = Unit.Pixel(42);

                TableCell tcPD_DTV = new TableCell();
                tcPD_DTV.Attributes.Add("align", "left");
                tcPD_DTV.Width = Unit.Pixel(159);
                tcPD_DTV.Text = Convert.ToString(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
                tcPD_DTV.Font.Size = 11;

                TableRow tbrPatientDetails3 = new TableRow();

                TableCell tcPD_AD = new TableCell();
                tcPD_AD.Attributes.Add("align", "left");
                tcPD_AD.Width = Unit.Pixel(91);

                TableCell tcPD_ADV = new TableCell();
                tcPD_ADV.Attributes.Add("align", "left");
                tcPD_ADV.Width = Unit.Pixel(242);
                tcPD_ADV.Text = lstPatientDetails[0].Address;
                tcPD_ADV.Font.Size = 11;

                TableCell tcPD_EMT = new TableCell();
                tcPD_EMT.Attributes.Add("align", "left");
                tcPD_EMT.Width = Unit.Pixel(42);

                TableCell tcPD_EMTV = new TableCell();
                tcPD_EMTV.Attributes.Add("align", "left");
                tcPD_EMTV.Width = Unit.Pixel(159);
                tcPD_EMTV.Text = "";
                tcPD_EMTV.Font.Size = 11;

                tbrPatientDetails1.Cells.Add(tcPD_PB);
                tbrPatientDetails1.Cells.Add(tcPD_PBV);
                tbrPatientDetails1.Cells.Add(tcPD_BN);
                tbrPatientDetails1.Cells.Add(tcPD_BNV);

                tbrPatientDetails2.Cells.Add(tcPD_NM);
                tbrPatientDetails2.Cells.Add(tcPD_NMV);
                tbrPatientDetails2.Cells.Add(tcPD_DT);
                tbrPatientDetails2.Cells.Add(tcPD_DTV);

                tbrPatientDetails3.Cells.Add(tcPD_AD);
                tbrPatientDetails3.Cells.Add(tcPD_ADV);
                tbrPatientDetails3.Cells.Add(tcPD_EMT);
                tbrPatientDetails3.Cells.Add(tcPD_EMTV);

                tblPatientDetails.Rows.Add(tbrPatientDetails1);
                tblPatientDetails.Rows.Add(tbrPatientDetails2);
                tblPatientDetails.Rows.Add(tbrPatientDetails3);

                if (lstBillingDetail.Count > 0)
                {
                    int i = 0;
                    TableRow headLine1Row = new TableRow();
                    TableCell headLineCell1 = new TableCell();
                    headLineCell1.ColumnSpan = 5;
                    headLineCell1.Text = "&nbsp;";
                    headLine1Row.Cells.Add(headLineCell1);
                    TableRow headRow = new TableRow();
                    TableCell headCell1 = new TableCell();
                    TableCell headCell2 = new TableCell();
                    TableCell headCell3 = new TableCell();
                    TableCell headCell4 = new TableCell();
                    TableCell headCell5 = new TableCell();
                    TableCell headCell6 = new TableCell();
                    TableCell headCell7 = new TableCell();
                    headCell1.BorderWidth = 1;
                    headCell2.BorderWidth = 1;
                    headCell3.BorderWidth = 1;
                    headCell4.BorderWidth = 1;
                    headCell5.BorderWidth = 1;
                    headCell6.BorderWidth = 1;
                    headCell7.BorderWidth = 1;

                    headCell1.Attributes.Add("align", "center");
                    //headCell1.Text = "Qty";
                    headCell1.Width = Unit.Pixel(75);
                    headCell1.Height = Unit.Pixel(15);
                    headCell1.Font.Size = 11;

                    headCell2.Attributes.Add("align", "center");
                    //headCell2.Text = "Product";
                    headCell2.Width = Unit.Pixel(275);
                    headCell2.Height = Unit.Pixel(15);
                    headCell2.Font.Size = 11;

                    headCell3.Attributes.Add("align", "center");
                    //headCell3.Text = "Batch";
                    headCell3.Width = Unit.Pixel(47);
                    headCell3.Height = Unit.Pixel(15);
                    headCell3.Font.Size = 11;

                    headCell4.Attributes.Add("align", "center");
                    //headCell4.Text = "Exp.Date";
                    headCell4.Width = Unit.Pixel(60);
                    headCell4.Height = Unit.Pixel(15);
                    headCell4.Font.Size = 11;

                    headCell5.Attributes.Add("align", "center");
                    //headCell5.Text = "Amount";
                    headCell5.Width = Unit.Pixel(75);
                    headCell5.Height = Unit.Pixel(15);
                    headCell5.Font.Size = 11;

                    headRow.Cells.Add(headCell1);
                    headRow.Cells.Add(headCell2);
                    headRow.Cells.Add(headCell3);
                    headRow.Cells.Add(headCell4);
                    headRow.Cells.Add(headCell5);

                    TableRow headLine2Row = new TableRow();
                    TableCell headLineCell2 = new TableCell();

                    foreach (BillingDetails objBD in lstBillingDetail)
                    {
                        i += 1;
                        TableRow contentRow = new TableRow();
                        TableCell contentCell1 = new TableCell();
                        TableCell contentCell2 = new TableCell();
                        TableCell contentCell3 = new TableCell();
                        TableCell contentCell4 = new TableCell();
                        TableCell contentCell5 = new TableCell();
                        TableCell contentCell6 = new TableCell();
                        TableCell contentCell7 = new TableCell();

                        contentCell1.Attributes.Add("align", "left");
                        contentCell1.Text = objBD.Quantity.ToString();
                        contentCell1.Style.Add("padding-right", "0px");
                        contentCell1.Width = Unit.Pixel(75);
                        contentCell1.Font.Size = 11;

                        contentCell2.Attributes.Add("align", "left");
                        contentCell2.Style.Add("padding-left", "10px");
                        contentCell2.Text = objBD.FeeDescription;
                        contentCell2.Width = Unit.Pixel(275);
                        contentCell2.Font.Size = 11;

                        contentCell3.Attributes.Add("align", "left");
                        contentCell3.Text = objBD.BatchNo.ToString();
                        contentCell3.Width = Unit.Pixel(47);
                        contentCell3.Font.Size = 11;

                        contentCell4.Attributes.Add("align", "left");
                        contentCell4.Width = Unit.Pixel(60);
                        contentCell4.Attributes.Add("align", "left");
                        contentCell4.Font.Size = 11;
                        if (objBD.ExpiryDate <= DateTime.Parse("01/01/1901"))
                        {
                            contentCell4.Text = "--";
                        }
                        else
                        {
                            contentCell4.Text = objBD.ExpiryDate.ToString("MMM-yyyy");
                        }

                        contentCell5.Attributes.Add("align", "left");
                        contentCell5.Style.Add("padding-left", "10px");
                        contentCell5.Width = Unit.Pixel(75);
                        contentCell5.Text = objBD.Amount.ToString();                        
                        contentCell5.Font.Size = 11;

                        contentRow.Cells.Add(contentCell1);
                        contentRow.Cells.Add(contentCell2);
                        contentRow.Cells.Add(contentCell3);
                        contentRow.Cells.Add(contentCell4);
                        contentRow.Cells.Add(contentCell5);
                        billDetailLaser.Rows.Add(contentRow);
                    }
                    TableRow headLine3Row = new TableRow();
                    TableCell headLineCell3 = new TableCell();
                    headLineCell3.ColumnSpan = 5;
                    headLineCell3.Text = "&nbsp;";
                    headLine3Row.Cells.Add(headLineCell3);
                    billDetailLaser.Rows.Add(headLine3Row);

                    TableRow SubTotalRow = new TableRow();
                    TableCell SubTotalCell1 = new TableCell();
                    SubTotalCell1.ColumnSpan = 4;
                    SubTotalCell1.Attributes.Add("align", "right");
                    SubTotalCell1.Style.Add("padding-right", "30px");
                    SubTotalCell1.Font.Size = 11;
                    SubTotalCell1.Text = "Sub Total: ";
                    SubTotalCell1.Width = Unit.Pixel(472);
                    SubTotalCell1.Font.Bold = true;

                    TableCell SubTotalCell2 = new TableCell();
                    SubTotalCell2.Attributes.Add("align", "right");
                    SubTotalCell2.Style.Add("padding-left", "0px");
                    SubTotalCell2.Width = Unit.Pixel(72);
                    SubTotalCell2.Font.Size = 11;
                    SubTotalCell2.Text = (lstFinalBillDetail[0].GrossBillValue).ToString();
                    SubTotalCell2.Font.Bold = true;
                    SubTotalRow.Cells.Add(SubTotalCell1);
                    SubTotalRow.Cells.Add(SubTotalCell2);

                    billDetailLaser.Rows.Add(SubTotalRow);


                    TableRow taxRow = new TableRow();
                    TableCell taxCell1 = new TableCell();
                    taxCell1.ColumnSpan = 4;
                    taxCell1.Attributes.Add("align", "right");
                    taxCell1.Style.Add("padding-right", "30px");
                    taxCell1.Width = Unit.Pixel(472);
                    taxCell1.Font.Size = 11;
                    taxCell1.Text = "Vat: ";
                    taxCell1.Font.Bold = true;

                    TableCell taxCell2 = new TableCell();
                    taxCell2.Attributes.Add("align", "right");
                    taxCell2.Style.Add("padding-left", "0px");
                    taxCell2.Width = Unit.Pixel(72);
                    taxCell2.Font.Size = 11;
                    taxCell2.Text = lstFinalBillDetail[0].TaxPercent.ToString();
                    taxCell2.Font.Bold = true;
                    taxRow.Cells.Add(taxCell1);
                    taxRow.Cells.Add(taxCell2);

                    billDetailLaser.Rows.Add(taxRow);


                    TableRow grossTotalRow = new TableRow();
                    TableCell grossTotalCell1 = new TableCell();
                    grossTotalCell1.ColumnSpan = 4;
                    grossTotalCell1.Attributes.Add("align", "right");
                    grossTotalCell1.Style.Add("padding-right", "30px");
                    grossTotalCell1.Width = Unit.Pixel(472);
                    grossTotalCell1.Font.Size = 11;
                    grossTotalCell1.Text = "Gross Total: ";
                    grossTotalCell1.Font.Bold = true;

                    TableCell grossTotalCell2 = new TableCell();
                    grossTotalCell2.Attributes.Add("align", "right");
                    grossTotalCell2.Style.Add("padding-left", "0px");
                    grossTotalCell2.Width = Unit.Pixel(72);
                    grossTotalCell2.Font.Size = 11;
                    grossTotalCell2.Text = (lstFinalBillDetail[0].GrossBillValue + lstFinalBillDetail[0].TaxPercent).ToString();
                    grossTotalCell2.Font.Bold = true;
                    grossTotalRow.Cells.Add(grossTotalCell1);
                    grossTotalRow.Cells.Add(grossTotalCell2);

                    billDetailLaser.Rows.Add(grossTotalRow);

                    TableRow discountRow = new TableRow();
                    if (lstFinalBillDetail[0].IsDiscountPercentage.ToString() == "Y")
                    {
                        TableCell discountPercentCell = new TableCell();
                        discountPercentCell.ColumnSpan = 4;
                        discountPercentCell.Attributes.Add("align", "right");
                        discountPercentCell.Style.Add("padding-right", "30px");
                        discountPercentCell.Font.Size = 11;
                        discountPercentCell.Width = Unit.Pixel(544);
                        string discountpercent = string.Empty;
                        decimal n;
                        n = (lstFinalBillDetail[0].DiscountAmount / (lstFinalBillDetail[0].GrossBillValue + lstFinalBillDetail[0].TaxPercent)) * 100;
                        discountpercent = "(" + Math.Round(n) + "%)" + "Discount: ";
                        discountPercentCell.Text = discountpercent;
                        discountPercentCell.Font.Bold = true;
                        discountRow.Cells.Add(discountPercentCell);
                    }
                    else
                    {
                        TableCell discountCell1 = new TableCell();
                        discountCell1.ColumnSpan = 4;
                        discountCell1.Attributes.Add("align", "right");
                        discountCell1.Style.Add("padding-right", "30px");
                        discountCell1.Width = Unit.Pixel(472);
                        discountCell1.Font.Size = 11;
                        discountCell1.Text = "Discount: ";
                        discountCell1.Font.Bold = true;
                        discountRow.Cells.Add(discountCell1);
                    }

                    TableCell discountCell2 = new TableCell();
                    discountCell2.Attributes.Add("align", "right");
                    discountCell2.Style.Add("padding-left", "0px");
                    discountCell2.Width = Unit.Pixel(72);
                    discountCell2.Font.Size = 11;
                    discountCell2.Text = lstFinalBillDetail[0].DiscountAmount.ToString();
                    discountCell2.Font.Bold = true;

                    discountRow.Cells.Add(discountCell2);

                    billDetailLaser.Rows.Add(discountRow);

                    TableRow headLine4Row = new TableRow();
                    TableCell headLineCell4 = new TableCell();
                    headLineCell4.ColumnSpan = 4;
                    headLineCell4.Text = "&nbsp;";
                    headLine4Row.Cells.Add(headLineCell4);
                    //billDetailLaser.Rows.Add(headLine4Row);

                    TableRow netTotalRow = new TableRow();
                    TableCell netTotalCell1 = new TableCell();
                    netTotalCell1.ColumnSpan = 4;
                    netTotalCell1.Attributes.Add("align", "right");
                    netTotalCell1.Style.Add("padding-right", "30px");
                    netTotalCell1.Width = Unit.Pixel(472);
                    netTotalCell1.Font.Size = 11;
                    netTotalCell1.Text = "Net Amount: ";
                    netTotalCell1.Font.Bold = true;

                    TableCell netTotalCell2 = new TableCell();
                    netTotalCell2.Attributes.Add("align", "right");
                    netTotalCell2.Style.Add("padding-left", "0px");
                    netTotalCell2.Width = Unit.Pixel(72);
                    netTotalCell2.Font.Size = 11;
                    netTotalCell2.Text = lstFinalBillDetail[0].NetValue.ToString();
                    netTotalCell2.Font.Bold = true;
                    netTotalRow.Cells.Add(netTotalCell1);
                    netTotalRow.Cells.Add(netTotalCell2);

                    billDetailLaser.Rows.Add(netTotalRow);


                    TableRow AmountReceived = new TableRow();
                    TableCell AmountReceivedCell1 = new TableCell();
                    AmountReceivedCell1.ColumnSpan = 4;
                    AmountReceivedCell1.Attributes.Add("align", "right");
                    AmountReceivedCell1.Style.Add("padding-right", "30px");
                    AmountReceivedCell1.Width = Unit.Pixel(472);
                    AmountReceivedCell1.Text = "Paid Amount: ";
                    AmountReceivedCell1.Font.Size = 11;
                    AmountReceivedCell1.Font.Bold = true;

                    TableCell AmountReceivedCell2 = new TableCell();
                    AmountReceivedCell2.Attributes.Add("align", "right");
                    AmountReceivedCell2.Style.Add("padding-left", "0px");
                    AmountReceivedCell2.Width = Unit.Pixel(72);
                    AmountReceivedCell2.Font.Size = 11;
                    AmountReceivedCell2.Text = lstFinalBillDetail[0].AmountReceived.ToString();
                    AmountReceivedCell2.Font.Bold = true;

                    AmountReceived.Cells.Add(AmountReceivedCell1);
                    AmountReceived.Cells.Add(AmountReceivedCell2);

                    billDetailLaser.Rows.Add(AmountReceived);

                    amountInWordsLaser.Text = lstFinalBillDetail[0].NetValue.ToString();
                    string strwords = string.Empty;
                    NumberToWord.NumberToWords num1 = new NumberToWord.NumberToWords();
                    if (Convert.ToDouble(lstFinalBillDetail[0].AmountReceived) > 0)
                    {
                        if (int.Parse(lstFinalBillDetail[0].AmountReceived.ToString().Split('.')[1]) > 0)
                        {
                            strwords = "Amount in Words: (" + CurrencyName + ") " + Utilities.FormatNumber2Word(num1.Convert(lstFinalBillDetail[0].AmountReceived.ToString())) + " " + MinorCurrencyName + " Only...";
                        }
                        else
                        {
                            strwords = "Amount in Words: (" + CurrencyName + ") " + num1.Convert(lstFinalBillDetail[0].AmountReceived.ToString()) + " Only...";
                        }
                    }
                    else
                    {
                        strwords = "Zero Only...";

                    }


                    TableRow headLine5Row = new TableRow();
                    TableCell headLineCell5 = new TableCell();
                    headLineCell5.ColumnSpan = 7;
                    headLineCell5.Style.Add("padding-left", "30px");
                    headLineCell5.Text = "<b>" + strwords + "</b>";
                    headLine5Row.Cells.Add(headLineCell5);
                    billDetailLaser.Rows.Add(headLine5Row);

                }

                string isDueBill = "N";

                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                }
                tdSoldByLaser.Text = "Sold By: " + lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name;
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }

}
