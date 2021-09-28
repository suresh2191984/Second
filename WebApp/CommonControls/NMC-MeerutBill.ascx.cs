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
using NumberToWord;
using System.Collections.Specialized;

public partial class CommonControls_NMC_MeerutBill : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //RemainDeposit.Visible = false;
            //lblHospitalName.InnerHtml = OrgName+"<br/>";
            List<Config> lstConfig = new List<Config>();


            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.OPBill;

            #region Commented code
            /*
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
            */
            #endregion
        }
    }

    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfig);
        int nConfigElements = lstConfig.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfig[nCnt].ConfigValue.Split('^');
            if (sTempConfigElements != null && sTempConfigElements.Length == 2)
            {
                oNV.Add(sTempConfigElements[0], sTempConfigElements[1]);
            }
        }
        for (int nCnt = 0; nCnt < oNV.Count; nCnt++)
        {
            switch (oNV.GetKey(nCnt))
            {
                case "Header Logo":
                    imgBillLogo.ImageUrl = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                    break;
                case "Header Font":
                    lblHospitalName.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Font Size":
                    lblHospitalName.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Content":
                    lblHospitalName.InnerHtml = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                case "Contents Font":
                    tblBillPrint.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblBillPrint.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblBillPrint.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblBillPrint.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;
            }
        }
    }
    #endregion

    public void BillPrinting(long visitID, long FinalbillID, int pdp)
    {
        try
        {
            int serviceFlag = 0;
            //long visitID = Convert.ToInt64(Request.QueryString["VisitID"]);
            string physicianName = string.Empty;
            string splitstatus = string.Empty;
            decimal amtReceived = 0;
            decimal amtRefunded = 0;
            decimal dChequeAmount = 0;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            List<Patient> lstPatientDetails = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<DuePaidDetail> lstDuePaidDetails = new List<DuePaidDetail>();
            List<Taxmaster> lstTax = new List<Taxmaster>();
            List<PatientQualification> lstQualification = new List<PatientQualification>();
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetBillPrintingDetails(visitID, out lstBillingDetail,
                                            out lstFinalBillDetail, out lstPatientDetails,
                                            out lstOrganization, out physicianName,
                                            out lstDuePaidDetails, FinalbillID, out lstTax, out splitstatus, out lstQualification);

            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            billingBL.pGetRefundBillingDetails(visitID, out lstBillingDetails, out amtReceived, out amtRefunded, out dChequeAmount, FinalbillID, 0);
            if (amtRefunded > 0)
            {
                lblrefundamt.Visible = true;
                lblrefundamt.Text = "Amount Refunded to the patient: Rs." + amtRefunded.ToString() + " Only";
            }
            if (lstBillingDetail.Count > 0 && lstFinalBillDetail[0].GrossBillValue > 0)
            {
                if (pdp == 1)
                {
                    //Added By Arivalagan.KK Display duplicate bill print//
                    tdDupBill.Style.Add("display", "table-cell");
                    lblDupBill.Visible = true;
                }
                else
                {
                    lblDupBill.Visible = false;
                }
                // Bind Billing details
                long vpur;
                Int64.TryParse(Request.QueryString["visitPur"], out vpur);
                string clientName = string.Empty;
                clientName = Request.QueryString["ClientName"];
                if (splitstatus == "CGHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantCGHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else if (splitstatus == "DGEHS OP" && OrgID == 82)
                {
                    List<BillingDetails> lstTemp = new List<BillingDetails>();
                    lstTemp = AddConsultantDGEHS(lstBillingDetail);
                    var lstdayOP = (from lst in lstTemp
                                    where lst.FeeType.Trim() != "CON"
                                    select lst);

                    gvBillingDetail.DataSource = lstdayOP;
                    gvBillingDetail.DataBind();

                }
                else
                {

                    gvBillingDetail.DataSource = lstBillingDetail;
                    gvBillingDetail.DataBind();
                }

                string isDueBill = "N";
                string isCreditBill = string.Empty;
                for (int i = 0; i < lstBillingDetail.Count; i++)
                {
                    if (lstBillingDetail[i].FeeId == -2)
                    {
                        isDueBill = "Y";
                    }
                    if (lstBillingDetail[i].ServiceCode != "" && lstBillingDetail[i].ServiceCode != null)
                    {
                        serviceFlag = 1;
                    }

                }
                lblTitleName.Text = lstPatientDetails[0].TitleName;
                lblName.Text = lstPatientDetails[0].Name;
                lblPatientno.Text = lstPatientDetails[0].PatientNumber.ToString();
                if (lstPatientDetails[0].SEX == "M")
                    lblSex.Text = "Male";
                else
                    lblSex.Text = "Female";
                lblAge.Text = lstPatientDetails[0].Age.ToString();
                //lblDoB.Text = lstPatientDetails[0].DOB.ToShortDateString();


                // Bind Final Bill detail

                lblInvoiceNo.Text = lstFinalBillDetail[0].BillNumber.ToString().Trim();

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("ShowDate_WithTime_BillPrint_Ascx", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    lblInvoiceDate.Text = lstFinalBillDetail[0].CreatedAt.ToString("dd/MMM/yyyy");
                }
                lblGrossAmount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].GrossBillValue);

                //if (string.IsNullOrEmpty(lstPatientDetails[0].ReferingPhysicianName))
                //{
                //    if (OrgID == 74)
                //    {
                //        lblPhysician.Visible = true;
                //        lblPhysician.Text = "-";
                //    }
                //    else
                //    {
                //        lblPhy.Visible = false;
                //        lblPhysician.Visible = false;
                //        phyDetails.Visible = false;
                //    }
                //}
                //else
                //{
                //    lblPhy.Visible = true;
                //    lblPhysician.Visible = true;
                //    // Code modified by Vijay TV on 16-Feb-2011 for Bug tracker ID 785 begins
                //    //lblPhysician.Text = physicianName;
                lblPhysician.Text = lstPatientDetails[0].ReferingPhysicianName; // Show Referring Physician name in the header
                lbHospitalName.Text = lstPatientDetails[0].ReferingSpecialityName;
                //    phyDetails.Visible = true;
                //    // Code modified by Vijay TV on 16-Feb-2011 for Bug tracker ID 785 ends
                //}

                //if (lstFinalBillDetail[0].StdDedID > 0)
                //{
                //    if (lstFinalBillDetail[0].StdDedType == "V")
                //        lblDeduction.Text = String.Format("{0:0.00}", Convert.ToInt64(lstFinalBillDetail[0].StdDedValue));
                //    else if (lstFinalBillDetail[0].StdDedType == "P")
                //        lblDeduction.Text = String.Format("{0:0.00}", (Convert.ToInt64(lstFinalBillDetail[0].StdDedValue) * lstFinalBillDetail[0].GrossBillValue / 100));
                //}
                //else
                //{
                //    lblDeduction.Text = "0.00";
                //}

                //if (lstFinalBillDetail[0].DiscountAmount > 0)
                //{
                //    trDiscount.Style.Add("display", "block");
                //    lblDiscount.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].DiscountAmount);
                //}
                if (lstFinalBillDetail[0].TaxAmount > 0)
                {
                    trServiceCharge.Style.Add("display", "block");
                    lblTax.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].TaxAmount);
                   
                }
                
                if (lstFinalBillDetail[0].Due > 0)
                {
                    trPreviousDue.Style.Add("display", "block");
                    lblCurrentVisitDueText.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].Due);

                }
                decimal Ar = Math.Round(lstFinalBillDetail[0].AmountReceived);
                lblAmountRecieved.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].AmountReceived);

                List<Config> lstConfig = new List<Config>();
                GateWay gateWay = new GateWay(base.ContextInfo);
                long returnCode = gateWay.GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    lblDisplayAmount.Text = "Amount Received in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + lstConfig[0].ConfigValue.ToString() + ") ";
                    //Label1.Text = "Remaining Deposit Amount : (" + lstConfig[0].ConfigValue + ")";
                    decimal dec = 0.00m;
                    if (decimal.TryParse(lblCurrentVisitDueText.Text, out dec))
                    {
                        lblDueAmountinWords.Style.Add("display", (dec == decimal.Zero ? "none" : "block"));
                    }
                    else
                    {
                        lblDueAmountinWords.Style.Add("display", "none");
                    }
                }


                else
                {
                    lblDisplayAmount.Text = "Amount Received in Words: (" + CurrencyName + ") ";
                    lblDueAmountinWords.Text = "Due Amount in Words: (" + CurrencyName + ") ";
                }
              

                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if (Convert.ToDouble(lblAmountRecieved.Text.Split('/')[0]) > 0)
                {
                    if (int.Parse(lblAmountRecieved.Text.Split('/')[0].Split('.')[1]) > 0)
                    {
                        lblAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblAmountRecieved.Text.Split('/')[0])) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                        lblAmount.Text = num.Convert(lblAmountRecieved.Text.Split('/')[0]) + " Only";
                    }
                }
                else
                {
                    lblAmount.Text = " Zero Only";
                    //lblAmount.Attributes.Add("display", "none");


                }
                if (lblCurrentVisitDueText.Text != "")
                {
                    if (Convert.ToDouble(lblCurrentVisitDueText.Text) > 0)
                    {
                        if (int.Parse(lblCurrentVisitDueText.Text.Split('.')[1]) > 0)
                        {
                            lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblCurrentVisitDueText.Text)) + " " + MinorCurrencyName + " Only";
                        }
                        else
                        {
                            lblDueAmount.Text = num.Convert(lblCurrentVisitDueText.Text) + " Only";
                        }

                    }
                    if (lblCurrentVisitDueText.Text == "")
                    {
                        lblDueAmount.Attributes.Add("display", "none");
                        lblDueAmountinWords.Attributes.Add("display", "none");
                    }
                }


                if (isDueBill != "Y")
                {
                    decimal nv = Math.Round(lstFinalBillDetail[0].NetValue);//+ lstFinalBillDetail[0].CurrentDue
                    // lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                    lblNetValue.Text = String.Format("{0:0.00}", nv);
                   
                    //decimal sum =Math.Round( lstFinalBillDetail[0].NetValue + lstFinalBillDetail[0].CurrentDue);
                    ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "validateround('" + sum.ToString() + "');", true);
                    ////lblGrossAmount.Text = hdnRoundOff.Value;
                    //lblGrossAmount.Text =String.Format("{0:0.00}", sum);

                }
                else
                {
                    decimal nv = Math.Round(lstFinalBillDetail[0].NetValue);
                    lblNetValue.Text = String.Format("{0:0.00}", lstFinalBillDetail[0].NetValue);
                    lblNetValue.Text = String.Format("{0:0.00}", nv);
                  
                }

                #region TPAAttribute
                string TPAAttributes = (lstPatientDetails[0].TPAAttributes == null) ? "" : lstPatientDetails[0].TPAAttributes;

                if (TPAAttributes != "" || lstPatientDetails[0].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetails[0].TPAAttributes, lstPatientDetails[0].TPAName);
                }
                #endregion
                
               
             


               

                ////lblBilledBy.Text = ("Billed By: (" + UserName + ")").ToUpper();
                lblBillExName.Text =  lstBillingDetail[0].BilledBy.ToUpper();
                lblsignature1.Text = "<b>Authorised Signature<br/>(for NMC-SKY Imaging & Diagnostic Center)</b>";


                



            }

            else
            {
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There is no Bill for this Patient";
                //tblBillPrint.Visible = false;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get bill details for printing in Bill Printing page", ex);
        }
    }
   

    public List<BillingDetails> AddConsultantDGEHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION 1st Visit - CGHS  S.NO - 1.4.2(By Specialist)";
                    lstitem1.Amount = 61.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 4.6";
                    lstitem1.Amount = 81.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //

                }
            }
        }
        return lstdet;
    }
    public List<BillingDetails> AddConsultantCGHS(List<BillingDetails> lstdetails)
    {

        List<BillingDetails> lstdet = lstdetails;

        int count = lstdetails.Count;
        for (int i = 0; i < count; i++)
        {
            if (lstdetails[i].FeeType == "CON")
            {
                decimal Quantitycount;
                Quantitycount = lstdetails[i].Quantity;
                BillingDetails lstitem1;
                for (int j = 0; j < Quantitycount; j++)
                {
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "CONSULTATION - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "REFRACTION - CGHS  S.NO - 63";
                    lstitem1.Amount = 36.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    lstitem1 = null;
                    //
                    lstitem1 = new BillingDetails();
                    lstitem1.FeeDescription = "NCT - CGHS  S.NO - 50";
                    lstitem1.Amount = 50.00m;
                    lstitem1.Quantity = 1.00m;
                    lstdet.Add(lstitem1);
                    decimal amt;
                    amt = lstdetails[i].Amount / lstdetails[i].Quantity;
                    if (amt == 226)
                    {
                        lstitem1 = null;
                        //
                        lstitem1 = new BillingDetails();
                        lstitem1.FeeDescription = "INDIRECT OPTHALMOSCOPE - CGHS  S.NO - 64";
                        lstitem1.Amount = 90.00m;
                        lstitem1.Quantity = 1.00m;
                        lstdet.Add(lstitem1);
                    }
                }
            }
        }
        return lstdet;
    }
}
