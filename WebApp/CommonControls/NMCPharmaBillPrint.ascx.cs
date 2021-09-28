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
using System.Text;

public partial class CommonControls_NMCPharmaBillPrint : BaseControl
{
    long visitID = -1;

    string pageid = string.Empty;
    long returncode = -1;
    string pagename = string.Empty;
    long patientID = -1;
    long dup = 0;
    string PharmacyBillNoConfig = string.Empty;
    string PharmacyBillNo = string.Empty;
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

                    //BillPrinting(visitID, FinalBillID);
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
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("Show_Pharmacy_BillNo_EachReceipt_And_InterimBill", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                PharmacyBillNoConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            if (PharmacyBillNoConfig == "Y")
            {

                if (lstBillingDetail.Count > 0)
                {
                    PharmacyBillNo = lstBillingDetail[0].ReferenceType;
                }
            }
            else
            {
                PharmacyBillNo = "";
            }
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {

                //orgDLNoLaser.Text = "D.L.No: " + lstInventoryConfig[0].ConfigValue.ToUpper();
                //trorgDLNoLaser.Style.Add("display", "block");
            }

            List<InventoryConfig> lstInventoryConfig1 = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig1);

            if (lstInventoryConfig1.Count > 0)
            {
                //orgTinNoLaser.Text = "TIN No: " + lstInventoryConfig1[0].ConfigValue.ToUpper();
                //trorgTinNoLaser.Style.Add("display", "block");
            }
            if (dup == 1)
            {
                Duplicate.Visible = true;
                Duplicate.Text = "Duplicate Copy";
            }
            if (lstFinalBillDetail[0].IsCreditBill == "Y")
                CreditOrCash.Text = "Credit Bill";
            else CreditOrCash.Text = "Cash Bill";
            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
            {
                //gvBillingDetail.DataSource = lstBillingDetail;
                //gvBillingDetail.DataBind();


                if (lstBillingDetail.Count > 0)
                {
                    int i = 0;
                    TableRow headLine1Row = new TableRow();
                    TableCell headLineCell1 = new TableCell();
                    headLineCell1.ColumnSpan = 5;
                    headLineCell1.Text = "&nbsp;";
                    headLine1Row.Cells.Add(headLineCell1);
                    // billDetailLaser.Rows.Add(headLine1Row);
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
                    headCell1.Text = "S.No";
                    headCell1.Width = Unit.Percentage(5);
                    headCell2.Attributes.Add("align", "center");
                    headCell2.Text = "Particulars";
                    //headCell2.Width = Unit.Percentage(10);
                    headCell3.Attributes.Add("align", "center");
                    headCell3.Text = "Qty";
                    headCell3.Width = Unit.Percentage(10);
                    headCell4.Attributes.Add("align", "center");
                    headCell4.Text = "Batch";
                    headCell4.Width = Unit.Percentage(10);
                    headCell5.Attributes.Add("align", "center");
                    headCell5.Text = "Exp.Date";
                    headCell5.Width = Unit.Percentage(10);
                    headCell6.Attributes.Add("align", "center");
                    headCell6.Text = "Rate";
                    headCell6.Width = Unit.Percentage(5);

                    headCell7.Attributes.Add("align", "center");
                    headCell7.Text = "Amount";
                    headCell7.Width = Unit.Percentage(5);

                    headCell6.Width = Unit.Percentage(10);
                    headRow.Cells.Add(headCell1);
                    headRow.Cells.Add(headCell2);
                    headRow.Cells.Add(headCell3);
                    headRow.Cells.Add(headCell4);
                    headRow.Cells.Add(headCell5);
                    headRow.Cells.Add(headCell6);
                    headRow.Cells.Add(headCell7);
                    //billDetailLaser.Rows.Add(headRow);
                    TableRow headLine2Row = new TableRow();
                    TableCell headLineCell2 = new TableCell();
                    headLineCell2.ColumnSpan = 6;
                    headLineCell2.Text = "<hr/>";
                    headLine2Row.Cells.Add(headLineCell2);
                    //billDetailLaser.Rows.Add(headLine2Row);
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
                        contentCell1.BorderWidth = 0;
                        contentCell2.BorderWidth = 0;
                        contentCell3.BorderWidth = 0;
                        contentCell4.BorderWidth = 0;
                        contentCell5.BorderWidth = 0;
                        contentCell6.BorderWidth = 0;
                        contentCell7.BorderWidth = 0;

                        contentCell1.Attributes.Add("align", "left");
                        //contentCell1.Text = i.ToString();
                        contentCell1.Text = objBD.Quantity.ToString();
                        contentCell1.Style.Add("padding-right", "0px");
                        contentCell1.Width = Unit.Percentage(2);
                        contentCell2.Attributes.Add("align", "left");
                        contentCell2.Style.Add("padding-left", "10px");
                        contentCell2.Text = objBD.FeeDescription;
                        contentCell2.Width = Unit.Percentage(40);
                        //contentCell2.Width = 50;
                        contentCell3.Attributes.Add("align", "left");
                        contentCell3.Text = objBD.Quantity.ToString();
                        contentCell3.Width = Unit.Percentage(8);
                        contentCell4.Attributes.Add("align", "left");
                        contentCell4.Text = objBD.BatchNo;
                        contentCell4.Width = Unit.Percentage(15);
                        contentCell5.Attributes.Add("align", "left");
                        if (objBD.ExpiryDate <= DateTime.Parse("01/01/1901"))
                        {
                            contentCell5.Text = "--";
                        }
                        else
                        {
                            contentCell5.Text = objBD.ExpiryDate.ToString("MMM-yyyy");
                        }
                        //contentCell5.Style.Add("padding-right", "0px");
                        contentCell5.Width = Unit.Percentage(15);


                        //contentCell6.Attributes.Add("align", "left");
                        //contentCell6.Style.Add("padding-left", "15px");
                        //contentCell6.Text = objBD.Rate.ToString();
                        //contentCell6.Width = Unit.Percentage(8);

                        contentCell6.Attributes.Add("align", "left");
                        contentCell6.Style.Add("padding-left", "10px");
                        contentCell6.Text = objBD.Amount.ToString();
                        contentCell6.Width = Unit.Percentage(8);

                        contentCell7.Attributes.Add("align", "right");
                        contentCell7.Text = objBD.Rate.ToString();
                        contentCell7.Width = Unit.Percentage(5);




                        contentRow.Cells.Add(contentCell1);
                        contentRow.Cells.Add(contentCell2);
                        //contentRow.Cells.Add(contentCell3);
                        contentRow.Cells.Add(contentCell4);
                        contentRow.Cells.Add(contentCell5);
                        //contentRow.Cells.Add(contentCell6);
                        contentRow.Cells.Add(contentCell7);
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
                    SubTotalCell1.Text = "Sub Total: ";
                    SubTotalCell1.Font.Bold = true;
                    TableCell SubTotalCell2 = new TableCell();
                    SubTotalCell2.Attributes.Add("align", "right");
                    SubTotalCell2.Style.Add("padding-left", "0px");
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
                    taxCell1.Text = "Vat: ";
                    taxCell1.Font.Bold = true;
                    TableCell taxCell2 = new TableCell();
                    taxCell2.Attributes.Add("align", "right");
                    taxCell2.Style.Add("padding-left", "0px");
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
                    grossTotalCell1.Text = "Gross Total: ";
                    grossTotalCell1.Font.Bold = true;
                    TableCell grossTotalCell2 = new TableCell();
                    grossTotalCell2.Attributes.Add("align", "right");
                    grossTotalCell2.Style.Add("padding-left", "0px");
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
                        discountCell1.Text = "Discount: ";
                        discountCell1.Font.Bold = true;
                        discountRow.Cells.Add(discountCell1);
                    }

                    TableCell discountCell2 = new TableCell();
                    discountCell2.Attributes.Add("align", "right");
                    discountCell2.Style.Add("padding-left", "0px");
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
                    netTotalCell1.Text = "Net Amount: ";
                    netTotalCell1.Font.Bold = true;
                    TableCell netTotalCell2 = new TableCell();
                    netTotalCell2.Attributes.Add("align", "right");
                    netTotalCell2.Style.Add("padding-left", "0px");
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
                    AmountReceivedCell1.Text = "Paid Amount: ";
                    AmountReceivedCell1.Font.Bold = true;
                    TableCell AmountReceivedCell2 = new TableCell();
                    AmountReceivedCell2.Attributes.Add("align", "right");
                    AmountReceivedCell2.Style.Add("padding-left", "0px");
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

                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);



                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    //orgHeadLaser.Text = lstInventoryConfig[0].ConfigValue;
                }
                //orgAddressLaser.Text = lstOrganization[0].Address + "<br/>" + lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                //patientNameLaser.Text = "Patient Name: " + lstFinalBillDetail[0].Name + "<br/>" + lstFinalBillDetail[0].Comments;
                if (lstFinalBillDetail[0].Physician != "")
                {
                    //PatientAddress.Text = lstFinalBillDetail[0].Comments;
                }
                if (lstPatientDetails.Count <= 0)
                {
                    PatientAddress.Text = lstFinalBillDetail[0].Comments;
                }
                else
                {
                    PatientAddress.Text = lstPatientDetails[0].Address;
                }
                if (lstPatientDetails.Count > 0)
                {
                    if (lstPatientDetails[0].PatientNumber != "")
                    {
                        patientNameLaser.Text = lstFinalBillDetail[0].Name;
                        regno.Text = lstPatientDetails[0].PatientNumber; 
                    }
                    else
                    {
                        patientNameLaser.Text = lstFinalBillDetail[0].Name;
                    }
                }
                else
                {
                    patientNameLaser.Text = lstFinalBillDetail[0].Name;
                }
                refby.Text = lstFinalBillDetail[0].Physician;
                tdSoldByLaser.Text = "Sold By: " + lstUsers.Find(P => P.LoginID == lstFinalBillDetail[0].CreatedBy).Name;

                billNoLaser.Text =  lstFinalBillDetail[0].BillNumber.ToString();
                billDateLaser.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
                lblPharmacyBillNo.Text = "PharmacyBill No: " + PharmacyBillNo;
                


                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();


                returncode = new GateWay(base.ContextInfo).GetInventoryConfigDetails("Bill_Policy", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                   // tdBillPolicy.Text = lstInventoryConfig[0].ConfigValue;
                    //tdBillPolicy.Visible = true;
                }

            }




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }



    public void ReceiptPrintingNMC(string ReceiptID, long FinalbillID)
    {
        try
        {
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<Patient> lstPatientDetails = new List<Patient>();

            SharedInventory_BL invBL = new SharedInventory_BL(base.ContextInfo);
            //invBL.GetReceiptPrintingDetails(ReceiptID, out lstBillingDetail,
            //                                 out lstPatientDetails,
            //                                OrgID);

            if (lstBillingDetail.Count > 0)
            {





                int i = 0;



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
                    contentCell1.BorderWidth = 0;
                    contentCell2.BorderWidth = 0;
                    contentCell3.BorderWidth = 0;
                    contentCell4.BorderWidth = 0;
                    contentCell5.BorderWidth = 0;
                    contentCell6.BorderWidth = 0;
                    contentCell7.BorderWidth = 0;

                    contentCell1.Attributes.Add("align", "left");
                    //contentCell1.Text = i.ToString();
                    contentCell1.Text = objBD.Quantity.ToString();
                    contentCell1.Style.Add("padding-right", "0px");
                    contentCell1.Width = Unit.Percentage(2);
                    contentCell2.Attributes.Add("align", "left");
                    contentCell2.Style.Add("padding-left", "10px");
                    contentCell2.Text = objBD.FeeDescription;
                    contentCell2.Width = Unit.Percentage(40);
                    //contentCell2.Width = 50;
                    contentCell3.Attributes.Add("align", "left");
                    contentCell3.Text = objBD.Quantity.ToString();
                    contentCell3.Width = Unit.Percentage(8);
                    contentCell4.Attributes.Add("align", "left");
                    contentCell4.Text = objBD.BatchNo;
                    contentCell4.Width = Unit.Percentage(15);
                    contentCell5.Attributes.Add("align", "left");
                    if (objBD.ExpiryDate <= DateTime.Parse("01/01/1901"))
                    {
                        contentCell5.Text = "--";
                    }
                    else
                    {
                        contentCell5.Text = objBD.ExpiryDate.ToString("MMM-yyyy");
                    }
                    //contentCell5.Style.Add("padding-right", "0px");
                    contentCell5.Width = Unit.Percentage(15);


                    //contentCell6.Attributes.Add("align", "left");
                    //contentCell6.Style.Add("padding-left", "15px");
                    //contentCell6.Text = objBD.Rate.ToString();
                    //contentCell6.Width = Unit.Percentage(8);

                    contentCell6.Attributes.Add("align", "left");
                    contentCell6.Style.Add("padding-left", "10px");
                    contentCell6.Text = objBD.Amount.ToString();
                    contentCell6.Width = Unit.Percentage(8);

                    contentCell7.Attributes.Add("align", "right");
                    contentCell7.Text = objBD.Rate.ToString();
                    contentCell7.Width = Unit.Percentage(5);




                    contentRow.Cells.Add(contentCell1);
                    contentRow.Cells.Add(contentCell2);
                    //contentRow.Cells.Add(contentCell3);
                    contentRow.Cells.Add(contentCell4);
                    contentRow.Cells.Add(contentCell5);
                    //contentRow.Cells.Add(contentCell6);
                    contentRow.Cells.Add(contentCell7);
                    billDetailLaser.Rows.Add(contentRow);
                }


            }


            TableRow headLine3Row = new TableRow();
            TableCell headLineCell3 = new TableCell();
            headLineCell3.ColumnSpan = 5;
            headLineCell3.Text = "&nbsp;";
            headLine3Row.Cells.Add(headLineCell3);
            billDetailLaser.Rows.Add(headLine3Row);

            decimal NetValue = lstBillingDetail.Sum(p => p.Rate);
            TableRow netTotalRow = new TableRow();
            TableCell netTotalCell1 = new TableCell();
            netTotalCell1.ColumnSpan = 4;
            netTotalCell1.Attributes.Add("align", "right");
            netTotalCell1.Style.Add("padding-right", "30px");
            netTotalCell1.Text = "Net Amount: ";
            netTotalCell1.Font.Bold = false;
            netTotalCell1.Font.Size = FontUnit.Point(9);
            TableCell netTotalCell2 = new TableCell();
            netTotalCell2.Attributes.Add("align", "right");
            netTotalCell2.Style.Add("padding-left", "30px");
            netTotalCell2.Text = NetValue.ToString();
            netTotalCell2.Font.Bold = false;
            netTotalCell2.Font.Size = FontUnit.Point(9);
            netTotalRow.Cells.Add(netTotalCell1);
            netTotalRow.Cells.Add(netTotalCell2);
            billDetailLaser.Rows.Add(netTotalRow);



            TableRow AmountReceived = new TableRow();
            TableCell AmountReceivedCell1 = new TableCell();
            AmountReceivedCell1.ColumnSpan = 4;
            AmountReceivedCell1.Attributes.Add("align", "right");
            AmountReceivedCell1.Style.Add("padding-right", "30px");
            AmountReceivedCell1.Text = "Received Amount: ";
            AmountReceivedCell1.Font.Bold = false;
            AmountReceivedCell1.Font.Size = FontUnit.Point(9);
            TableCell AmountReceivedCell2 = new TableCell();
            AmountReceivedCell2.Attributes.Add("align", "right");
            AmountReceivedCell2.Style.Add("padding-left", "0px");
            AmountReceivedCell2.Text = lstBillingDetail[0].AmountReceived.ToString();
            AmountReceivedCell2.Font.Bold = false;
            AmountReceivedCell2.Font.Size = FontUnit.Point(9);
            AmountReceived.Cells.Add(AmountReceivedCell1);
            AmountReceived.Cells.Add(AmountReceivedCell2);
            billDetailLaser.Rows.Add(AmountReceived);





            patientNameLaser.Text = lstPatientDetails[0].Name;
            refby.Text = lstBillingDetail[0].Name.ToLower();
            //tdDrName.InnerHtml = lstBillingDetail[0].Name;
            PatientAddress.Text = lstPatientDetails[0].Address;

            billNoLaser.Text = lstBillingDetail[0].ReceiptNO.ToString();
            //tdBillNo.InnerHtml = lstBillingDetail[0].ReceiptNO.ToString();

            billDateLaser.Text = lstBillingDetail[0].CreatedAt.ToString("dd/MM/yyyy");
            //tdDate.InnerHtml = lstBillingDetail[0].CreatedAt.ToString("dd/MM/yyyy");
            //tdSoldby.InnerHtml = "Sold By: " + Session["UserName"];

            //amountInWordsLaser.Text = lstFinalBillDetail[0].NetValue.ToString();
            TableRow amtinwords = new TableRow();
            TableCell amtinwordscell1 = new TableCell();
            amtinwordscell1.ColumnSpan = 4;
            amtinwordscell1.Attributes.Add("align", "left");
            string strwords = string.Empty;
            NumberToWord.NumberToWords num1 = new NumberToWord.NumberToWords();
            if (lstBillingDetail[0].AmountReceived > 0)
            {
                if (int.Parse(lstBillingDetail[0].AmountReceived.ToString().Split('.')[1]) > 0)
                {
                    amtinwordscell1.Text = "<br> Amount in Words : " + Utilities.FormatNumber2Word(num1.Convert(lstBillingDetail[0].AmountReceived.ToString())) + " " + MinorCurrencyName + " Only...";
                }
                else
                {
                    amtinwordscell1.Text = "<br> Amount in Words : " + num1.Convert(lstBillingDetail[0].AmountReceived.ToString()) + " Only...";
                }
            }
            else
            {
                amtinwordscell1.Text = "<br> Amount in Words: Zero Only...";

            }
            TableRow headLine5Row = new TableRow();
            TableCell headLineCell5 = new TableCell();
            headLineCell5.ColumnSpan = 7;
            headLineCell5.Style.Add("padding-left", "30px");
            headLineCell5.Text = "<b>" + strwords + "</b>";
            headLine5Row.Cells.Add(headLineCell5);
            billDetailLaser.Rows.Add(headLine5Row);


            TableRow soldby = new TableRow();
            TableCell soldbycell = new TableCell();
            soldbycell.ColumnSpan = 3;
            soldbycell.Attributes.Add("align", "left");
            soldbycell.Text = "Sold by: " + Session["UserName"];
            soldby.Cells.Add(soldbycell);
            tdSoldByLaser.Text = "Sold By: " + Session["UserName"];

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }

    
    

     

}
