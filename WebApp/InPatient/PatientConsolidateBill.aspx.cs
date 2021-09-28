using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class InPatient_PatientConsolidateBill : BasePage
{
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstDueChart1 = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();

    List<PatientDueChart> lstNonMedicalItems = new List<PatientDueChart>();

    List<Config> lstConfig;
    List<string> lstAddData = new List<string>();
    int sLabEntered = 0;
    int iTempCount = 0;
    string receiptNo = "";
    string primaryConsultant = string.Empty;
    string patientName = "";

    string sType = "";
    string sChkVal = "";
    long ipInterID = 0;
    long sBID = 0;
    long sEID = 0;
    long ipInertID = 0;

    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    string FeeType = string.Empty;
    char s;
    long visitID = 0;
    long patientID = 0;
    int firstLoad = -1;
    int pharmacyitemshow = -1;
    string showdateandstatus = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {



        try
        {

            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }


            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }

            

            if (!IsPostBack)
            {
                #region headerconfig
                lstConfig = new List<Config>();

                int iBillGroupID = 0;
                iBillGroupID = (int)ReportType.IPBill;

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

                //Split the data

                int iBillGroupID2 = 0;
                iBillGroupID2 = (int)ReportType.IPBill;

                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID2, "SplitFBillDA", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue.Trim() == "Y")
                    {
                        s = 'Y';
                    }
                   
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
                    lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
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


                #endregion

                LoadDetails();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }

    public void LoadDetails()
    {

        try
        {
            decimal dAdvanceAmount = 0;
            decimal dTotalAmount = 0;
            decimal dTotalDue = 0;
            decimal dPreviousRefund = 0;
            decimal pTotSurgeryAdv = 0;
            decimal pTotSurgeryAmt = 0;
            decimal dPayerTotal = 0;
            decimal dGrossAmount = 0;
            decimal dServiceCharge = 0;
            decimal dTax = 0;
            decimal dPrevAmountPaid = 0;
            decimal dPrevDue = 0;
            decimal dRoundoff = 0;
            
            List<Patient> lstPatientDetail = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<Physician> physicianName = new List<Physician>();
            List<Taxmaster> lstTaxes = new List<Taxmaster>();
            List<FinalBill> lstFinalBill = new List<FinalBill>();





            PatientHeader.PatientID = patientID;
            PatientHeader.PatientVisitID = visitID;

            decimal pNonMedicalAmtPaid = decimal.Zero;
            decimal pCoPayment = decimal.Zero;
            decimal pExcess = decimal.Zero;
            string AdmissionDate = "01/01/1753";
            string MaxBillDate = "01/01/1753";
            string IsVisitHaveChild = string.Empty;
            List<AmountReceivedDetails> lstAmtReceived = new List<AmountReceivedDetails>();
            List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

            new PatientVisit_BL(base.ContextInfo).pGetAmountReceivedDetailsForIPBILL(visitID, out lstAmtReceived);
            if (lstAmtReceived.Count > 0)
            {
                grdPayDetails.DataSource = lstAmtReceived;
                grdPayDetails.DataBind();
            }

            new PatientVisit_BL(base.ContextInfo).GetIPBillSettlement(visitID, patientID, OrgID,
                                                        out dTotalAmount, out dAdvanceAmount,
                                                        out dTotalDue, out dPreviousRefund,
                                                        out lstDueChart, out lstBedBooking,
                                                        out pTotSurgeryAdv, out pTotSurgeryAmt,
                                                        out lstPatientDetail, out lstOrganization,
                                                        out physicianName, out lstTaxes, out lstFinalBill,
                                                        out dPayerTotal,
                                                        out pNonMedicalAmtPaid, out pCoPayment, out pExcess, out AdmissionDate, out MaxBillDate, out IsVisitHaveChild,0);


            #region header details

            string NeedTime = string.Empty;
            List<Config> lstconfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedTimeToPrint", OrgID, out lstconfig);
            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
                NeedTime = "Y";

            int length = lstPatientDetail.Count;
            for (int i = 0; i < length; i++)
            {
                string TPAAttributes = (lstPatientDetail[i].TPAAttributes == null) ? "" : lstPatientDetail[i].TPAAttributes;
                if (TPAAttributes != "" || lstPatientDetail[i].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetail[i].TPAAttributes, lstPatientDetail[i].TPAName);

                }
            }
            if (NeedTime == "Y")
            {
                lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");
                lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
            }
            else
            {
                lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy");
                lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy");
                lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy").Trim() == "01/01/0001" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy");
            }
            
            if (lstPatientDetail[0].AdmissionDate < DateTime.Parse("01/01/1900"))
            {
                lblDOA.Text = "";
            }

            
            if (lstFinalBill.Count > 0)
            {
                lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
                lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBill[0].RoundOff);
            }
            
            if (lstDueChart.Count > 0)
            {

                BillingEngine be = new BillingEngine(base.ContextInfo);
                decimal Copercent = -1;
                be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);






            }

            long returnCode = -1;
            List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
            returnCode = new Patient_BL(base.ContextInfo).GetPrimaryConsultant(visitID, 0, out lstPrimaryConsultant);

            if (lstPrimaryConsultant.Count > 0)
            {
                foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                {
                    if (primaryConsultant == "")
                    {
                        primaryConsultant = objPC.PhysicianName;
                    }
                    else
                    {
                        primaryConsultant += " , " + objPC.PhysicianName;
                    }
                }
            }

            hdnGross.Value = txtGross.Text;

            //lblPhysician.Text = physicianName[0].PhysicianName;
            lblPhysician.Text = primaryConsultant;
            
            lblInvoiceNo.Text = lstFinalBill[0].BillNumber.ToString();
            new GateWay(base.ContextInfo).GetConfigDetails("IsMRDNo", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.ToUpper() == "Y")
                {
                    lblPatientNo.Text = "MRD No";
                    lblPatientNumber.Text = lstPatientDetail[0].URNO.Trim();
                }
                else
                {
                    lblPatientNo.Text = "Patient No";
                    lblPatientNumber.Text = lstPatientDetail[0].PatientNumber.Trim();
                }
            }
            else
            {
                lblPatientNo.Text = "Patient No";
                lblPatientNumber.Text = lstPatientDetail[0].PatientNumber.Trim();
            }
            patientName = lstPatientDetail[0].Name.Trim();
            lblAge.Text = lstPatientDetail[0].Age;
            txtDiscount.Text = lstFinalBill[0].DiscountAmount.ToString();




            string sex = string.Empty;
            if (lstPatientDetail[0].SEX.ToUpper() == "M")
            {
                lblSex.Text = "Male";
                sex = "Male";
            }
            else if (lstPatientDetail[0].SEX.ToUpper() == "F")
            {
                lblSex.Text = "Female";
                sex = "Female";
            }
            else
            {
                lblSex.Text = "Transgender";
                sex = "Transgender";
            }

            lblName.Text = lstPatientDetail[0].Name;
            //  string RedirectPage = GetConfigValue("BillPrintControl", OrgID);
            if (lstPatientDetail[0].IPNumber.Trim() == "0")
            {
                lblIPNo.Text = "-";
            }
            else
            {
                lblIPNo.Text = lstPatientDetail[0].IPNumber;
            }

            lstConfig = new List<Config>();


            new GateWay(base.ContextInfo).GetConfigDetails("InsuranceHead", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue == "Insurance Head" && IsCreditBill == "Y")
                {
                    trInsuranceDetails.Style.Add("display", "block");
                    trPatientDetails.Style.Add("display", "none");
                    trAmountDetails.Style.Add("display", "none");


                }
                else
                {
                    Preauth.Style.Add("display", (IsCreditBill == "Y" ? "block" : "none"));
                    trInsuranceDetails.Style.Add("display", "none");
                    trPatientDetails.Style.Add("display", "block");
                }
            }
            else
            {
                Preauth.Style.Add("display", (IsCreditBill == "Y" ? "block" : "none"));
                trInsuranceDetails.Style.Add("display", "none");
                trPatientDetails.Style.Add("display", "block");
            }

            #region Insurance Header
            var MinDate = (from Mindt in lstDueChart select Mindt.FromDate).Min();
            var MaxDate = (from Maxdt in lstDueChart select Maxdt.FromDate).Max();

            string attribvalue = string.Empty;
            string tpaName = string.Empty;
            attribvalue = FinalBillHeader1.attribValue;
            tpaName = FinalBillHeader1.tpaName;
            if (!(string.IsNullOrEmpty(attribvalue) || string.IsNullOrEmpty(tpaName)))
            {
                if (!string.IsNullOrEmpty(attribvalue))
                {
                    attribvalue = attribvalue.Replace("<br>", "");
                    lblInsuranceCoNameText.Text = attribvalue;
                }
                else
                {
                    lblInsuranceCoNameText.Text = " - ";
                }
                if (!string.IsNullOrEmpty(tpaName))
                {
                    lblInsuranceTPAText.Text = FinalBillHeader1.tpaName;
                }
                else
                {
                    lblInsuranceTPAText.Text = " - ";
                }
            }
            else
            {
                lblInsuranceCoNameText.Text = " - ";
                lblInsuranceTPAText.Text = " - ";
            }
            lblInsuranceBillNoText.Text = lstFinalBill[0].BillNumber.ToString();
            lblInsurancePatientNameText.Text = lstPatientDetail[0].Name;
            if (NeedTime == "Y")
            {
                lblInsuranceBillDateText.Text = MaxDate.ToString("dd/MM/yyyy hh:mm tt");
                lblInsuranceBillPeriodText.Text = MinDate.ToString("dd/MM/yyyy hh:mm tt") + " to " + MaxDate.ToString("dd/MM/yyyy hh:mm tt");
                lblInsuranceAdmitDateText.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                lblInsuranceDischargeDateText.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "-" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");
            }
            else
            {
                lblInsuranceBillDateText.Text = MaxDate.ToString("dd/MM/yyyy");
                lblInsuranceBillPeriodText.Text = MinDate.ToString("dd/MM/yyyy") + " to " + MaxDate.ToString("dd/MM/yyyy");
                lblInsuranceAdmitDateText.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy");
                lblInsuranceDischargeDateText.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy").Trim() == "01/01/0001" ? "-" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy");
            }
            lblInsuranceAgeSexText.Text = lstPatientDetail[0].Age + "/" + sex;
            lblInsuranceAddressText.Text = lstPatientDetail[0].Address.ToString();
            lblInsuranceRegNoText.Text = lstPatientDetail[0].PatientNumber.Trim();
            lblInsuranceIPNoText.Text = lstPatientDetail[0].IPNumber;
            if (lstTaxes.Count > 0)
            {
                lblInsuranceTaxNoText.Text = lstTaxes[0].TaxID.ToString();
            }
            else
            {
                lblInsuranceTaxNoText.Text = "-";
            }



            #endregion



            NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
            if ((dTotalAmount + dAdvanceAmount - dPreviousRefund) > 0)
            {
                if (int.Parse((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString().Split('.')[1]) > 0)
                {
                    lblAmount.Text = Utilities.FormatNumber2Word(num.Convert((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString())) + " " + MinorCurrencyName + " Only";
                }
                else
                {
                    lblAmount.Text = num.Convert((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString()) + " Only";
                }
            }
            else
            {
                lblAmount.Text = " Zero Only";
            }
            new GateWay(base.ContextInfo).GetConfigDetails("DisplayCurrencyFormat", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    lblCurrency.Text = lstConfig[0].ConfigValue.Trim();
                    lblDueAmountinWords.Text = lstConfig[0].ConfigValue.Trim();
                }
                else
                {
                    lblCurrency.Text = CurrencyName;
                    lblDueAmountinWords.Text = lstConfig[0].ConfigValue.Trim();
                }
            }
            
            

           


            if (IsCreditBill == "Y")
            {

                lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("ServiceTaxREGNO", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue.Trim() != "")
                    {
                        lblInvoiceDate.Text = lstConfig[0].ConfigValue.Trim();
                        lblBillDate.Text = "Service tax Reg.no.";
                    }
                }

                

                
            }
            else
            {

            }


            new GateWay(base.ContextInfo).GetConfigDetails("ServiceTaxNumber", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    lblInsuranceTaxNoText.Text = lstConfig[0].ConfigValue.Trim();

                }
            }
            new GateWay(base.ContextInfo).GetConfigDetails("PanNumber", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.Trim() != "")
                {
                    lblInsurancePanNoText.Text = lstConfig[0].ConfigValue.Trim();

                }
            }
            #endregion

            #region business 

            if (lstDueChart.Count > 0)
            {

               


                #region Hospital Bill Details

                var lstbilldetails = (from lbd in lstDueChart
                                      where lbd.FeeType != "PRM"
                                      select new { lbd.ReceiptNO, lbd.ReceiptInterimNo ,lbd.Status }).Distinct();
                List<PatientDueChart> lstdues = new List<PatientDueChart>();
                foreach (var obj in lstbilldetails)
                {
                    PatientDueChart pdc = new PatientDueChart();
                    pdc.ReceiptNO = obj.ReceiptNO;
                    pdc.Status = obj.Status;
                    pdc.ReceiptInterimNo = obj.ReceiptInterimNo;
                    lstdues.Add(pdc);
                }

                gvParentGrid.DataSource = lstdues;
                gvParentGrid.DataBind();

                #endregion


                #region Pharmacy Bill Details

                var lstPhabilldetails = (from lbd in lstDueChart
                                      where lbd.FeeType == "PRM"
                                      select new { lbd.ReceiptNO,lbd.ReceiptInterimNo ,lbd.Status }).Distinct();
              
                    List<PatientDueChart> lstPhadues = new List<PatientDueChart>();
                    foreach (var obj in lstPhabilldetails)
                    {
                        PatientDueChart pdc = new PatientDueChart();
                        pdc.ReceiptNO = obj.ReceiptNO;
                        pdc.Status = obj.Status;
                        pdc.ReceiptInterimNo  = obj.ReceiptInterimNo ;
                        lstPhadues.Add(pdc);
                    }

                    gvParentPharmaGrid.DataSource = lstPhadues;
                    gvParentPharmaGrid.DataBind();

                #endregion


                #region Room Details

                   var list = (from list1 in lstBedBooking
                                select list1.RoomTypeName).Distinct();

                    foreach (var obj in list)
                    {
                        PatientDueChart pdc = new PatientDueChart();
                        pdc.RoomTypeName = obj;
                        lstBedBookingRoomType.Add(pdc);
                    }

                    if (lstBedBookingRoomType.Count > 0)
                    {
                        
                        gvIndentRoomType.DataSource = lstBedBookingRoomType;
                        gvIndentRoomType.DataBind();
                        gvIndentRoomType.Visible = true;
                    }
                    else
                    {
                        
                        
                        gvIndentRoomType.Visible = false;
                    }


                #endregion


            }

            #endregion


            #region Amount Received Break up

            new PatientVisit_BL(base.ContextInfo).pGetAmountReceivedDetailsForIPBILL(visitID, out lstAmtReceived);
            if (lstAmtReceived.Count > 0)
            {
                grdPayDetails.DataSource = lstAmtReceived;
                grdPayDetails.DataBind();
            }

            #endregion

            #region Business Calculation

            decimal GrossAmt = 0;

            GrossAmt = lstDueChart.Sum(p => Convert.ToDecimal(p.Unit * p.Amount));
            GrossAmt = GrossAmt + lstBedBooking.Sum(p => Convert.ToDecimal(p.Amount * p.Unit));

            txtGross.Text = GrossAmt.ToString("0.00");
            txtDiscount.Text = lstFinalBill[0].DiscountAmount.ToString();

            decimal taxamt = 0;
            if (!string.IsNullOrEmpty(lstFinalBill[0].TaxAmount.ToString()))
            {
                taxamt = lstFinalBill[0].TaxAmount;
                txtTax.Text = taxamt.ToString("0.00");
            }
            if (txtTax.Text == "0.00")
            {
                trTax.Style.Add("display", "none");
            }

            txtPreviousDue.Text = dTotalDue.ToString("0.00");
            lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
            lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBill[0].RoundOff);
            txtPreviousAmountPaid.Text = (dTotalAmount + dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString("0.00");
            if (IsCreditBill != "Y")
            {
                txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
                                   dPayerTotal) //+ Convert.ToDecimal(txtRecievedAdvance.Text)
                                   + Convert.ToDecimal(txtPreviousDue.Text) + Convert.ToDecimal(lblRoundOff.Text));
                lblTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(txtPreviousDue.Text));
            }
            else
            {
                lblTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(txtPreviousDue.Text));
                txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(txtGross.Text) - (Convert.ToDecimal(lblCoPayment.Text) + Convert.ToDecimal(txtThirdParty.Text)));
            }

            txtRecievedAdvance.Text = dAdvanceAmount.ToString("0.00");

            lblPreAuthAmount.Text = pPreAuthAmount.ToString("0.00");

            if (pPreAuthAmount < Convert.ToDecimal(txtGross.Text))
            {
                lblTPADue.Text = ((Convert.ToDecimal(pPreAuthAmount) + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(lblRoundOff.Text)) - Convert.ToDecimal(txtThirdParty.Text)).ToString();
            }
            else
            {
                lblTPADue.Text = ((Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(lblRoundOff.Text)) - Convert.ToDecimal(txtThirdParty.Text) -  Convert.ToDecimal(lblPaidAmt.Text)).ToString();
            }

            

            txtPreviousDue.Text = dTotalDue.ToString("0.00");
            txtPreviousRefund.Text = dPreviousRefund.ToString("0.00");

            #endregion


            #region show hide footer content


            if(txtDiscount.Text != "0.00")
                   trDiscount.Style.Add("display","block");     
            if(txtTax.Text != "0.00")
                    trTax.Style.Add("display","block");     
            if(txtPreviousDue.Text != "0.00")
                    trPreviousDue.Style.Add("display","block");     
            if(lblServiceCharge.Text != "0.00")
                    trCreditDebit.Style.Add("display","block");     
            if( lblRoundOff.Text != "0.00")
                    trRoundOff.Style.Add("display","block");     
            if( txtRecievedAdvance.Text != "0.00")
                    trAdvance.Style.Add("display","block");     
            if( lblPreAuthAmount.Text != "0.00")
                    Preauth .Style.Add("display","block");     
            if(txtPreviousRefund.Text != "0.00")
                    trPreviousRefund.Style.Add("display","block");     
            if(lblPaidAmt.Text != "0.00")
                    trPaidAmt.Style.Add("display","block");     
            if(lblCoPayment.Text != "0.00")
                    trCoPay .Style.Add("display","block");     
            if(txtThirdParty.Text != "0.00")
                    trTpaDetails.Style.Add("display","block");     
            if(lblTPADue.Text != "0.00")
                    trTPADue.Style.Add("display","block");
            if (txtGrandTotal.Text != "0.00")
               trGrsndTotal.Style.Add("display", "block");


            #endregion



            #region summary bill

            List<TempFees> lstTempData = new List<TempFees>();
            //ROOM CHARGES
            var lstTempFees = (from dAmt in lstBedBooking
                               where dAmt.IsReimbursable != "N"
                               select (dAmt.Amount * dAmt.Unit)).Sum();

            TempFees tmpfees = new TempFees();
            decimal dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees.Description = "Room Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //SURGERY AMOUNT 
            List<PatientDueChart> lstTempsoi = (from dAmt in lstDueChart
                                                where (dAmt.FeeType.ToUpper() == "SOI" || dAmt.FeeType.ToUpper() == "SUR") //&& dAmt.IsReimbursable != "N"
                                                select dAmt).ToList();

            foreach (PatientDueChart pd in lstTempsoi)
            {
                if ((pd.Amount * pd.Unit) > decimal.Zero)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = pd.Description;
                    tmpfees.Amount = (pd.Amount * pd.Unit);
                    lstTempData.Add(tmpfees);
                }
            }



            //SURGERY Package AMOUNT 
            List<PatientDueChart> lstTempSPKG = (from dAmt in lstDueChart
                                                 where (dAmt.FeeType.ToUpper() == "SPKG" || dAmt.FeeType.ToUpper() == "SUR") //&& dAmt.IsReimbursable != "N"
                                                 select dAmt).ToList();

            foreach (PatientDueChart pd in lstTempSPKG)
            {
                if ((pd.Amount * pd.Unit) > decimal.Zero)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = pd.Description;
                    tmpfees.Amount = (pd.Amount * pd.Unit);
                    lstTempData.Add(tmpfees);
                }
            }



            //CONSULTATION 
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "CON" //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Consultation Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }


            //LAB 
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "PKG" || dAmt.FeeType.ToUpper() == "GRP" || dAmt.FeeType.ToUpper() == "INV") //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Lab Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //TREATMENT 
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "REG" || dAmt.FeeType.ToUpper() == "ADD" || dAmt.FeeType.ToUpper() == "IND") //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Treatment Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //PHARMACY
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "PRM" //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Pharmacy Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //PROCEDURES
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "PRO" && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Procedure Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //CASUALITY
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "CAS" //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;

            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Casuality Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //IMMUNIZATION
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "IMU" //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Immunization Charges";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //MISCELLANEOUS
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "OTH" || dAmt.FeeType.ToUpper() == "MISCELLANEOUS" || dAmt.FeeType.ToUpper() == "GEN") //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;

            if (dTotal > decimal.Zero)
            {
                tmpfees = new TempFees();
                tmpfees.Description = "Miscellaneous";
                tmpfees.Amount = dTotal;
                lstTempData.Add(tmpfees);
            }

            //NON-MEDICALITEMS
           
                //lstTempFees = (from dAmt in lstDueChart
                //               where dAmt.IsReimbursable == "N"
                //               select (dAmt.Amount * dAmt.Unit)).Sum();



                //dTotal = (decimal)lstTempFees;
                //if (dTotal > decimal.Zero)
                //{
                //    tmpfees = new TempFees();
                //    tmpfees.Description = "Non-MedicalItems Charges";
                //    tmpfees.Amount = dTotal;
                //    //hdnNonMedicalDetails.Value = dTotal.ToString("0.00");
                //    lstTempData.Add(tmpfees);
                //}
            

            lstTempData = (from obtData in lstTempData
                           where obtData.Amount > 0
                           select obtData).ToList();

            gvPatientSummary.DataSource = lstTempData;
            gvPatientSummary.DataBind();



            #endregion


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }
    private class TempFees
    {
        private decimal amount = 0;
        private string description = "";
        public decimal Amount
        {
            get { return amount; }
            set { amount = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

    }
    protected void grdPayDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {

            e.Row.Cells.Clear();
            TableCell tCell = new TableCell();
            tCell.ColumnSpan = 4;
            tCell.Style.Add("color", "red");
            tCell.Text = "* Break up Incl All Taxes";
            e.Row.Cells.Add(tCell);
            e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Font.Bold = true;

        }

    }
    protected void gvParentGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        decimal total = 0;
        int count = 0;
        List<PatientDueChart> lstReceipt = new List<PatientDueChart>();
        List<PatientDueChart> lstReceipt1 = new List<PatientDueChart>();
        PatientDueChart RMaster = (PatientDueChart)e.Row.DataItem;
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblReceiptInterim = (Label)e.Row.FindControl("lblReceiptInterim");
                if (RMaster.Status == "Pending")
                    lblReceiptInterim.Text = "Interim No :";
                if (RMaster.Status == "Paid")
                    lblReceiptInterim.Text = "Receipt No :";
                lblReceiptInterim.Style.Add("font-size", "10px");

                var childItems = from child in lstDueChart
                                 where child.ReceiptNO == RMaster.ReceiptNO //&& child.FeeType != "PRM" && child.FeeType != "ROM"
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("gvChildGrid");



                count = childItems.Count();
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstReceipt = childItems.ToList();


                //==============================================================
                //========Receipt total count in Receipt wise ===========
                total = (from child in lstReceipt
                         where child.ReceiptNO == RMaster.ReceiptNO
                         select child.Amount).Sum();
                decimal totalamt = Convert.ToDecimal(total);
                Label LblTotvalue = (Label)e.Row.FindControl("LblTotvalue");
                LblTotvalue.Text = totalamt.ToString();

                //==============================================================

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Patient consolidate hospital view bill", ex);
        }

    }
    protected void gvParentPharmaGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        decimal total = 0;
        int count = 0;
        List<PatientDueChart> lstReceipt = new List<PatientDueChart>();
        List<PatientDueChart> lstReceipt1 = new List<PatientDueChart>();
        PatientDueChart RMaster = (PatientDueChart)e.Row.DataItem;
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPharReceiptInterim = (Label)e.Row.FindControl("lblPharReceiptInterim");
                if (RMaster.Status == "Pending")
                    lblPharReceiptInterim.Text = "Interim No :";
                if (RMaster.Status == "Paid")
                    lblPharReceiptInterim.Text = "Receipt No :";
                lblPharReceiptInterim.Style.Add("font-size", "10px");
                var childItems = from child in lstDueChart
                                 where child.ReceiptNO == RMaster.ReceiptNO //&& child.FeeType != "PRM" && child.FeeType != "ROM"
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("gvPharChildGrid");



                count = childItems.Count();
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstReceipt = childItems.ToList();


                //==============================================================
                //========Receipt total count in Receipt wise ===========
                total = (from child in lstReceipt
                         where child.ReceiptNO == RMaster.ReceiptNO
                         select child.Amount * child.Unit).Sum();
                decimal totalamt = Convert.ToDecimal(total);
                Label LblPharTotvalue = (Label)e.Row.FindControl("LblPharTotvalue");
                LblPharTotvalue.Text = totalamt.ToString("0.00");

                //==============================================================

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Patient consolidate pharmacy view bill", ex);
        }

    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }








    protected void gvIndentRoomType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblFeeTypeDetails = (Label)e.Row.FindControl("lblFeeTypeDetails");

                PatientDueChart BMaster = (PatientDueChart)e.Row.DataItem;

                var childItems = from child in lstBedBooking
                                 where child.RoomTypeName == BMaster.RoomTypeName && child.IsReimbursable != "N"
                                 select child;

                lstNonMedicalItems.AddRange((from child in lstBedBooking
                                             where child.RoomTypeName == BMaster.RoomTypeName && child.IsReimbursable == "N"
                                             select child).ToList());

                GridView childGrid = (GridView)e.Row.FindControl("gvIndentRoomDetails");
                if (childItems.Count() > 0)
                {
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                    childGrid.Visible = true;
                }
                else
                {
                    childGrid.Visible = false;
                }

                List<PatientDueChart> lstchilddues = new List<PatientDueChart>();
                lstchilddues = (List<PatientDueChart>)childItems.ToList();
                var sumAmount = (from lstdues in lstchilddues
                                 select (lstdues.Amount * lstdues.Unit)).Sum();

                lblFeeTypeDetails.Text = lblFeeTypeDetails.Text + "         : -" + CurrencyName + " " + sumAmount.ToString("0.00");

                if (sumAmount != decimal.Zero)
                {
                    lblFeeTypeDetails.Visible = true;
                }
                else
                {
                    lblFeeTypeDetails.Visible = false;
                }

                decimal dtotalAmount = 0;


                foreach (GridViewRow row1 in childGrid.Rows)
                {
                    Label txtUnitPrice = new Label();
                    Label txtAmount = new Label();
                    txtAmount = (Label)row1.FindControl("txtAmount");
                    dtotalAmount += Convert.ToDecimal(txtAmount.Text);
                    if (txtUnitPrice.Text == "0.00")
                    {
                        row1.BackColor = System.Drawing.Color.Gray;
                    }
                }
                txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabAdminSummaryReports Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
}
