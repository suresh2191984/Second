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

public partial class InPatient_EditIPViewBill:BasePage
{
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstDueChart1 = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
    List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

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


        if (Request.QueryString["CCPage"] == "Y")
        {
            LeftMenu1.Visible = false;
            MainHeader.Visible = false;
            PatientHeader.Visible = false;
            imagelogo.Visible = false;
            btnItemizedBill.Visible = false;
            btnReceipt.Visible = false;
            btnViewSummary.Visible = false;
            showmenu.Visible = false;
            //data.Visible = false;
            lblTempBill.Visible = false;
            Footer1.Visible = false;
            btnBillPrint.Visible = false;
            chkMedicalItems.Visible = false;
            chkPharmaPrint.Visible = false;

        }
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
            string sPaymentType = "";
            if (Request.QueryString["PTYPE"] != null)
            {
                sPaymentType = Request.QueryString["PTYPE"].ToString();
            }

            if (Request.QueryString["RNO"] != null)
            {
                receiptNo = Request.QueryString["RNO"].ToString();
            }

            if (Request.QueryString["rType"] != null)
            {
                sType = Request.QueryString["rType"].ToString();
            }
            sChkVal = "";
            if (Request.QueryString["CKVA"] != null)
            {
                sChkVal = Request.QueryString["CKVA"].ToString();
            }
            sBID = 0;
            if (Request.QueryString["SID"] != null)
            {
                Int64.TryParse(Request.QueryString["SID"].ToString(), out sBID);
            }
            sEID = 0;
            if (Request.QueryString["EID"] != null)
            {
                Int64.TryParse(Request.QueryString["EID"].ToString(), out sEID);
            }
            ipInertID = 0;
            if (Request.QueryString["INTID"] != null)
            {
                Int64.TryParse(Request.QueryString["INTID"].ToString(), out ipInertID);
            }
            if (Request.QueryString["GB"] != null)
            {
                if (Request.QueryString["GB"] == "Y")
                    btnReceipt.Visible = true;

            }

            #region PrintDiagnoseDetail
            int iBillGroupID1 = 0;
            iBillGroupID1 = (int)ReportType.IPBill;

            new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID1, "PrintDiagnoseWithICD", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {

                if (lstConfig[0].ConfigValue == "Y")
                {
                    DiagnoseWithICD1.FontSize = "10px";
                    DiagnoseWithICD1.Height = "10px";
                    DiagnoseWithICD1.HeaderText = "DIAGNOSIS";
                    DiagnoseWithICD1.LoadPatientComplaintWithICD(visitID, "IP", "OPR");
                }

            }
            new GateWay(base.ContextInfo).GetConfigDetails("footer", OrgID, out lstConfig);//to display addresses in footer only for mrdfort
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue != "")
                {
                    trmedfortfooter.Attributes.Add("display", "block");
                    medfortfooter.InnerHtml = lstConfig[0].ConfigValue;
                }
            }
            new GateWay(base.ContextInfo).GetConfigDetails("showdate&status", OrgID, out lstConfig);//to disable date coloumn in surgery package only for medfort
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.ToUpper() == "N")
                {

                    showdateandstatus = "N";
                }
            }
            new GateWay(base.ContextInfo).GetConfigDetails("showRupeeImage", OrgID, out lstConfig);//to display rupee image only for mrdfort
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.ToUpper() == "Y")
                {

                    Irupee1.Visible = true; Irupee2.Visible = true; Irupee3.Visible = true;
                    Irupee4.Visible = true; Irupee5.Visible = true; Irupee6.Visible = true;
                    Irupee7.Visible = true; Irupee8.Visible = true; Irupee9.Visible = true;
                    Irupee10.Visible = true; Irupee11.Visible = true; Irupee12.Visible = true;
                    Irupee13.Visible = true; Irupee14.Visible = true; Irupee15.Visible = true;
                    Irupee16.Visible = true; Irupee17.Visible = true; Irupee18.Visible = true;
                    Irupee19.Visible = true;
                }
            }
            else
            {
                Irupee1.Visible = false; Irupee2.Visible = false; Irupee3.Visible = false;
                Irupee4.Visible = false; Irupee5.Visible = false; Irupee6.Visible = false;
                Irupee7.Visible = false; Irupee8.Visible = true; Irupee9.Visible = false;
                Irupee10.Visible = false; Irupee11.Visible = false; Irupee12.Visible = false;
                Irupee13.Visible = false; Irupee14.Visible = false; Irupee15.Visible = false;
                Irupee16.Visible = false; Irupee17.Visible = false; Irupee18.Visible = false;
                Irupee19.Visible = false;
            }



            #endregion

            if (!IsPostBack)
            {

                #region print refund voucher

                if (Request.QueryString["Print"] != null)
                {
                    if (Request.QueryString["Print"] == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "printVoucher", "javascript:printVou('" + visitID + "');", true);
                    }
                }

                #endregion


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
                    //else
                    //{
                    //    s = 'N';
                    //}
                }
                //End the split data;
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

                if (Request.QueryString["BP"] != null)
                {
                    if (Request.QueryString["BP"].ToString() == "Y")
                    {
                        lblAmountinWords.Visible = true;
                        lblAmount.Visible = true;
                        lblSignature.Visible = true;
                        tblHeader.Visible = true;
                        lblTempBill.Visible = false;
                        btnReceipt.Visible = false;
                    }
                    else
                    {
                        //lblAmountinWords.Visible = true;
                        lblAmount.Visible = true;
                        lblSignature.Visible = true;
                        tblHeader.Visible = true;
                        //lblTempBill.Visible = true;
                        //btnReceipt.Visible = false;
                    }
                }
                if (Request.QueryString["GB"] != null)
                {
                    if (Request.QueryString["GB"] == "Y")
                        btnReceipt.Visible = true;

                }
                else
                {
                    btnReceipt.Visible = false;
                }

                #endregion

                firstLoad = 0;
                pharmacyitemshow = 0;
                LoadDetails(firstLoad);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }

    public void LoadDetails(int firstLoad)
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
            decimal dCopayment = 0;
            decimal dDue = 0;
            decimal dTPAPaid = 0;
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
            string stv = "";
            long strtBID = 0;
            long sendid = 0;
            //BillingEngine be = new BillingEngine(base.ContextInfo);
            //decimal Copercent = -1;
            //be.CheckIsCreditBill(visitID, out pPreAuthAmount, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out Copercent);
            if (Request.QueryString["CKVA"] != null)
            {
                stv = Request.QueryString["CKVA"].ToString();
            }
            else
            {
                stv = "N";
            }

            if (Request.QueryString["SID"] != null)
            {
                Int64.TryParse(Request.QueryString["SID"].ToString(), out strtBID);
            }
            if (Request.QueryString["EID"] != null)
            {
                Int64.TryParse(Request.QueryString["EID"].ToString(), out sendid);
            }


            if (stv == "Y")
            {
                lstDueChart = (from lstdue in lstDueChart
                               where lstdue.DetailsID >= strtBID && lstdue.DetailsID <= sendid
                               select lstdue).ToList();

                var des = from lstdes in lstDueChart
                          select lstdes.Description.Split('~').Count();



                lstBedBooking = (from lstbed in lstBedBooking
                                 where lstbed.DetailsID >= strtBID && lstbed.DetailsID <= sendid
                                 select lstbed).ToList();

            }
            txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());
            //string TPAAttributes = (lstPatientDetail[0].TPAAttributes == null) ? "" : lstPatientDetail[0].TPAAttributes;

            int length = lstPatientDetail.Count;
            for (int i = 0; i < length; i++)
            {
                string TPAAttributes = (lstPatientDetail[i].TPAAttributes == null) ? "" : lstPatientDetail[i].TPAAttributes;
                if (TPAAttributes != "" || lstPatientDetail[i].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetail[i].TPAAttributes, lstPatientDetail[i].TPAName);

                }
            }
            lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
            if (lstPatientDetail[0].AdmissionDate < DateTime.Parse("01/01/1900"))
            {
                lblDOA.Text = "";
            }

            lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");
            if (lstFinalBill.Count > 0)
            {
                lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
                lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBill[0].RoundOff);
            }
            if (lblServiceCharge.Text == "0.00")
            {
                trCreditDebit.Style.Add("display", "none");
            }
            if (lblRoundOff.Text == "0.00")
            {
                trRoundOff.Style.Add("display", "none");
            }
            if (lstDueChart.Count > 0)
            {
               
                BillingEngine be = new BillingEngine(base.ContextInfo);
                decimal Copercent = -1;
                be.CheckIsCreditBill(visitID,  out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill,out lstVisitClientMapping);

                if (IsCreditBill == "Y")
                    chkMedicalItems.Visible = true;


                var chart = ((from listInd in lstDueChart
                              where listInd.FeeType != "PRM" && listInd.FeeType != "ROM"
                              orderby listInd.FeeType ascending, listInd.FromDate ascending
                              select new { listInd.FeeType, listInd.Comments }).Distinct());

                if (chart.Count() > 0)
                {
                    gvTreatmentCharges.DataSource = chart;
                    gvTreatmentCharges.DataBind();
                    gvTreatmentCharges.Visible = true;
                    dvTreatmentCharges.Style.Add("display", "block");
                    trTreatmentLine.Style.Add("Display", "block");
                }
                else
                {
                    trTreatmentLine.Style.Add("Display", "none");
                    dvTreatmentCharges.Style.Add("display", "none");
                    gvTreatmentCharges.Visible = false;
                }

                var list = (from list1 in lstBedBooking
                            select list1.RoomTypeName).Distinct();

                foreach (var obj in list)
                {
                    PatientDueChart pdc = new PatientDueChart();
                    pdc.RoomTypeName = obj;
                    lstBedBookingRoomType.Add(pdc);
                }

                List<PatientDueChart> lstPharmacy = (from listInd in lstDueChart
                                                     where listInd.FeeType == "PRM" && listInd.IsReimbursable != "N"
                                                     select listInd).ToList();

                lstNonMedicalItems.AddRange((from listInd in lstDueChart
                                             where listInd.FeeType == "PRM" && listInd.IsReimbursable == "N"
                                             select listInd).ToList());

                var pharmaTotal = (from listInd in lstDueChart
                                   where listInd.FeeType == "PRM"
                                   select listInd).ToList();

                decimal dueSum = (from lst in lstDueChart
                                  where lst.FeeType == "PRM" && lst.IsReimbursable != "N"
                                  select lst.Amount * lst.Unit).Sum();

                if (lstPharmacy.Count > 0)
                {
                    gvMedicalItems.DataSource = lstPharmacy;
                    gvMedicalItems.DataBind();
                    gvMedicalItems.Visible = true;
                    dvpharmacy.Style.Add("display", "block");
                    trPharmacyLine.Style.Add("Display", "block");
                    dvpharmacy.InnerHtml = "<b><u>Pharmacy:- &nbsp;" + dueSum.ToString("0.00") + "</u></b>";
                    chkPharmaPrint.Visible = true;
                    chkPharmaPrint.Checked = true;
                    chkPharmaPrint.Text = "Dont Show Pharmacy Items";
                }
                else
                {
                    gvMedicalItems.Visible = false;
                    dvpharmacy.Style.Add("display", "none");
                    trPharmacyLine.Style.Add("Display", "none");
                    chkPharmaPrint.Visible = false;
                }

                gridAttributesAdd(gvMedicalItems);

                if (lstBedBookingRoomType.Count > 0)
                {
                    trRoomCharges.Style.Add("Display", "block");
                    trRoomLine.Style.Add("Display", "block");
                    gvIndentRoomType.DataSource = lstBedBookingRoomType;
                    gvIndentRoomType.DataBind();
                    gvIndentRoomType.Visible = true;
                }
                else
                {
                    trRoomLine.Style.Add("Display", "none");
                    trRoomCharges.Style.Add("Display", "none");
                    gvIndentRoomType.Visible = false;
                }
                if (lstNonMedicalItems.Count > 0)
                {
                    divNonMedical.Visible = true;
                    gvNonMedicalItems.DataSource = lstNonMedicalItems;
                    gvNonMedicalItems.DataBind();
                    gvNonMedicalItems.Visible = true;
                    var sumAmount = (from lstNonMed in lstNonMedicalItems
                                     select (lstNonMed.Amount * lstNonMed.Unit)).Sum();
                    hdnNonMedicalDetails.Value = sumAmount.ToString("0.00");
                    lblNonMedicalDetails.Text = CurrencyName + " " + sumAmount.ToString("0.00");
                    if (sumAmount != decimal.Zero)
                    {
                        lblNonMedicalItem.Visible = true;
                        lblNonMedicalDetails.Visible = true;
                    }
                    else
                    {
                        lblNonMedicalItem.Visible = false;
                        lblNonMedicalDetails.Visible = false;
                    }
                    divNonMedicalHead.Style.Add("display", "block");
                    trNonMedicalLine.Style.Add("Display", "block");
                }
                else
                {
                    divNonMedical.Visible = false;
                    divNonMedicalHead.Style.Add("display", "none");
                    trNonMedicalLine.Style.Add("Display", "block");
                }
                if (IsCreditBill != "Y" || firstLoad == 0)
                    gridAttributesAdd(gvNonMedicalItems);

                txtRecievedAdvance.Text = dAdvanceAmount.ToString();
                if (stv == "N")
                {
                    txtPreviousAmountPaid.Text = (dTotalAmount + dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString();
                }
                else
                {
                    decimal dTempAmt = 0;
                    if (Request.QueryString["AMT"] != null)
                    {
                        Decimal.TryParse(Request.QueryString["AMT"].ToString(), out dTempAmt);
                    }
                    //txtPreviousAmountPaid.Text = (dTempAmt + dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString();
                    txtPreviousAmountPaid.Text = (dTempAmt).ToString();
                }

                txtPreviousDue.Text = dTotalDue.ToString("0.00");
                txtPreviousRefund.Text = dPreviousRefund.ToString("0.00");
            }

            if (txtPreviousDue.Text == "0.00")
            {
                trPreviousDue.Style.Add("display", "none");
            }
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
            #region comment by suresh
            //if (lstTaxes.Count > 0)
            //{
            //    dvTaxDetails.Visible = true;
            //    string sTableHTML = "<table class='dataheaderInvCtrl' style='border-width:1px;border-style:solid;' >";
            //    foreach (Taxmaster tm in lstTaxes)
            //    {
            //        sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + String.Format("{0:0.00}", ((Convert.ToDecimal(txtGross.Text) - lstFinalBill[0].DiscountAmount) * (tm.TaxPercent / 100))) + "<td/></tr>";
            //        taxamt += ((Convert.ToDecimal(txtGross.Text) - lstFinalBill[0].DiscountAmount) * (tm.TaxPercent / 100));
            //    }
            //    sTableHTML += "</table>";
            //    dvTaxDetails.InnerHtml = sTableHTML;
            //}
            //else
            //{
            //    dvTaxDetails.Visible = false;
            //}
            #endregion



            lblCoPayment.Text = pCoPayment.ToString("0.00");
            lblPaidAmt.Text = pNonMedicalAmtPaid.ToString("0.00");
            //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) - dAdvanceAmount);
            if (IsCreditBill != "Y" || firstLoad == 0)
            {
                txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
                                   dPayerTotal) //+ Convert.ToDecimal(txtRecievedAdvance.Text)
                                   + Convert.ToDecimal(txtPreviousDue.Text) + Convert.ToDecimal(lblRoundOff.Text));
                lblTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(txtPreviousDue.Text));
                txtPreviousAmountPaid.Text = lblTotal.Text;
            }
            else
            {
                lblTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(txtPreviousDue.Text));
                txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(txtGross.Text) - (Convert.ToDecimal(lblCoPayment.Text) + Convert.ToDecimal(txtThirdParty.Text)));
            }



            if (Convert.ToDecimal(txtGrandTotal.Text) < 0)
            {
                txtRefundAmount.Text = txtGrandTotal.Text.Replace("-", "");
                txtGrandTotal.Text = "0";
                if (dPreviousRefund < (Convert.ToDecimal(txtRefundAmount.Text) + dPreviousRefund))
                {
                    txtRefundAmount.Text = Convert.ToString(Convert.ToDecimal(txtRefundAmount.Text) - dPreviousRefund);
                }
                else
                {
                    txtRefundAmount.Text = "0";
                }
            }
            txtRefundAmount.Text = txtRefundAmount.Text == "" ? "0" : txtRefundAmount.Text;
            if (Convert.ToDecimal(txtRefundAmount.Text) < 0)
            {
                txtGrandTotal.Text = txtRefundAmount.Text.Replace("-", "");
                txtRefundAmount.Text = "0";
            }
            if ((txtGrandTotal.Text == "0.00") && (txtRefundAmount.Text == "0"))
            {
                //trGrsndTotal.Style.Add("display", "none");
            }
            else
            {
                //trGrsndTotal.Style.Add("display", "block");
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
            lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
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



            if (txtDiscount.Text == "0.00")
            {
                trDiscount.Style.Add("display", "none");
            }

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
            lstConfig = new List<Config>();


            new GateWay(base.ContextInfo).GetConfigDetails("InsuranceHead", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue == "Insurance Head" && IsCreditBill == "Y")
                {
                    trInsuranceDetails.Style.Add("display", "block");
                    trPatientDetails.Style.Add("display", "none");
                    btnItemizedBill.Visible = false;
                    trKmhInsuranceFooter.Style.Add("display", "block");
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
            lblInsuranceBillDateText.Text = MaxDate.ToString("dd/MM/yyyy");
            lblInsuranceBillPeriodText.Text = MinDate.ToString("dd/MM/yyyy") + " to " + MaxDate.ToString("dd/MM/yyyy");
            lblInsuranceAgeSexText.Text = lstPatientDetail[0].Age + "/" + sex;
            lblInsuranceAdmitDateText.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
            lblInsuranceAddressText.Text = lstPatientDetail[0].Address.ToString();
            lblInsuranceDischargeDateText.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "-" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");
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
            dGrossAmount = Decimal.Parse(txtGross.Text);
            dServiceCharge = Decimal.Parse(lblServiceCharge.Text);
            dTax = Decimal.Parse(txtTax.Text);
            dPrevAmountPaid = decimal.Parse(txtPreviousAmountPaid.Text);
            dPrevDue = decimal.Parse(txtPreviousDue.Text);
            dRoundoff = decimal.Parse(lblRoundOff.Text);
            dCopayment = decimal.Parse(lblCoPayment.Text);
            dTPAPaid = decimal.Parse(txtThirdParty.Text);
            if (IsCreditBill != "Y" || firstLoad == 0)
            {
                lblEnhancementBill.Visible = false;
                dDue = dGrossAmount + dServiceCharge + dTax + dPrevDue + dRoundoff -
                     (lstFinalBill[0].DiscountAmount + dPrevAmountPaid + dPayerTotal);
            }

            if ((dDue) == 0)
            {
                tdDueAmount.Style.Add("display", "none");
            }
            //else
            //{
            //    dDue = Convert.ToDecimal(txtGrandTotal.Text);
            //}

            if ((dDue) > 0)
            {
                if (int.Parse(dDue.ToString().Split('.')[1]) > 0)
                {
                    lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(dDue.ToString()))+" " +MinorCurrencyName + " Only";
                }
                else
                {
                    lblDueAmount.Text = num.Convert(dDue.ToString()) + " Only";
                }
            }
            else
            {
                lblDueAmount.Text =  " Zero Only";
            }


            //else
            //{
            //    lblDueAmount.Text = " Zero Only";
            //}
            if (lstPatientDetail[0].IPNumber.Trim() == "0")
            {
                lblIPNo.Text = "-";
            }
            else
            {
                lblIPNo.Text = lstPatientDetail[0].IPNumber;
            }
            if (lstPatientDetail[0].TPAID > 0)
            {
                tpaDetails.Visible = true;
                txtThirdParty.Visible = true;
            }
            else
            {
                tpaDetails.Visible = false;
                txtThirdParty.Visible = false;
            }
            lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("PrintReceipt", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue.Trim() == "Y")
                {
                    if (Request.QueryString["BP"].ToString() == "Y")
                    {
                        //btnReceipt.Visible = false;
                    }
                    else
                    {
                        // btnReceipt.Visible = false;
                    }
                }
                else
                {
                    //  btnReceipt.Visible = false;
                }
            }

            if (sChkVal == "Y")
            {
                btnItemizedBill.Visible = false;
                btnViewSummary.Visible = false;
            }
            else
            {
                btnItemizedBill.Visible = true;
                btnViewSummary.Visible = true;
            }




            //else
            //{
            //    lblDueAmount.Text = " Zero Only";
            //}
            if (lstPatientDetail[0].IPNumber.Trim() == "0")
            {
                lblIPNo.Text = "-";
            }
            else
            {
                lblIPNo.Text = lstPatientDetail[0].IPNumber;
            }
            if (lstPatientDetail[0].TPAID > 0)
            {
                tpaDetails.Visible = true;
                txtThirdParty.Visible = true;
                Irupee12.Visible = true;
            }
            else
            {
                tpaDetails.Visible = false;
                txtThirdParty.Visible = false;
                Irupee12.Visible = false;
            }


            if (IsCreditBill == "Y" || firstLoad == 0)
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

                #region servicetax
                //new GateWay(base.ContextInfo).GetConfigDetails("ServiceTaxNumber", OrgID, out lstConfig);
                //if (lstConfig.Count > 0)
                //{
                //    if (lstConfig[0].ConfigValue.Trim() != "")
                //    {
                //        lblInsuranceTaxNoText.Text = lstConfig[0].ConfigValue.Trim();

                //    }
                //}
                //new GateWay(base.ContextInfo).GetConfigDetails("PanNumber", OrgID, out lstConfig);
                //if (lstConfig.Count > 0)
                //{
                //    if (lstConfig[0].ConfigValue.Trim() != "")
                //    {
                //        lblInsurancePanNoText.Text = lstConfig[0].ConfigValue.Trim();

                //    }
                //}
                #endregion



                trPaidAmt.Visible = Convert.ToDecimal(lblPaidAmt.Text).Equals(decimal.Zero) ? false : true;
                //trCoPay.Visible = IsCreditBill == "Y" ? Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true : false;
                trCoPay.Visible = false;
                //trCoPay.Visible = Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true;
                // trTPADue.Visible = Convert.ToDecimal(lblTPADue.Text).Equals(decimal.Zero) ? false : true;

                #region Try

                #region commentedline
                //txtGrandTotal.Text="0.00";
                //lblPaidAmt.Text = hdnNonMedicalDetails.Value = hdnNonMedicalDetails.Value.Trim().Equals(string.Empty) ? 0.ToString("0.00") : hdnNonMedicalDetails.Value;
                //lblCoPayment.Text = Convert.ToDecimal(txtPreviousAmountPaid.Text) > 0 && Convert.ToDecimal(txtPreviousAmountPaid.Text) > (Convert.ToDecimal(hdnNonMedicalDetails.Value)) ? (Convert.ToDecimal(txtPreviousAmountPaid.Text) - Convert.ToDecimal(hdnNonMedicalDetails.Value)).ToString("0.00") : 0.ToString("0.00");
                // txtThirdParty.Text = (decimal.Parse(lblAmount.Text) - decimal.Parse(hdnNonMedicalDetails.Value)).ToString("0.00");
                //decimal TpaNetBill = Convert.ToDecimal(lblTotal.Text) - Convert.ToDecimal(hdnNonMedicalDetails.Value) - Convert.ToDecimal(txtPreviousDue.Text);
                //decimal tmpDue = Convert.ToDecimal(hdnNonMedicalDetails.Value) + Convert.ToDecimal(txtPreviousDue.Text);
                //decimal tmpAdv=Convert.ToDecimal(txtPreviousAmountPaid.Text);

                //if (TpaNetBill > pPreAuthAmount)
                //{
                //    if (tmpDue > tmpAdv)
                //    {
                //        txtGrandTotal.Text = (tmpDue - tmpAdv).ToString("0.00");
                //        //lblCoPayment.Text = "0.00";
                //    }
                //    else
                //    {
                //        lblCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
                //        tmpAdv = tmpAdv - tmpDue;
                //        if ((TpaNetBill - pPreAuthAmount) < tmpAdv)
                //        {
                //            lblCoPayment.Text = (tmpAdv - (TpaNetBill - pPreAuthAmount)).ToString("0.00");
                //            //txtGrandTotal.Text = "0.00";
                //        }
                //        else
                //        {
                //            txtGrandTotal.Text = ((TpaNetBill - pPreAuthAmount) - tmpAdv).ToString("0.00");
                //            //lblCoPayment.Text = "0.00";
                //        }
                //    }
                //    lblTPADue.Text = pPreAuthAmount > decimal.Zero && Convert.ToDecimal(txtThirdParty.Text) < pPreAuthAmount ? (pPreAuthAmount - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : Convert.ToDecimal(txtThirdParty.Text).Equals(decimal.Zero) ? pPreAuthAmount.ToString("0.00") : decimal.Zero.ToString("0.00");
                //    //txtThirdParty.Text = pPreAuthAmount.ToString("0.00");
                //}
                //else
                //{
                //    lblTPADue.Text = Convert.ToDecimal(txtThirdParty.Text) < TpaNetBill && Convert.ToDecimal(txtThirdParty.Text) > decimal.Zero ? (TpaNetBill - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : TpaNetBill.ToString("0.00");

                //    if (tmpDue > tmpAdv)
                //    {
                //        txtGrandTotal.Text = (tmpDue - tmpAdv).ToString("0.00");
                //        //lblCoPayment.Text = "0.00";
                //    }
                //    else
                //    {
                //        lblCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
                //        //txtGrandTotal.Text = "0.00";
                //    }
                //}
                //txtGrandTotal.Text = (Convert.ToDecimal(txtGrandTotal.Text) + (Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) == decimal.Zero ? Convert.ToDecimal(hdnNonMedicalDetails.Value) : decimal.Zero)).ToString("0.00");
                //txtGrandTotal.Text = (Convert.ToDecimal(txtGrandTotal.Text) + (Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) < Convert.ToDecimal(hdnNonMedicalDetails.Value) && Convert.ToDecimal(lblCoPayment.Text) > decimal.Zero ? Convert.ToDecimal(hdnNonMedicalDetails.Value) - Convert.ToDecimal(lblCoPayment.Text) : decimal.Zero)).ToString();
                //lblCoPayment.Text = ((Convert.ToDecimal(lblCoPayment.Text) - Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) > Convert.ToDecimal(hdnNonMedicalDetails.Value) ? Convert.ToDecimal(hdnNonMedicalDetails.Value) : decimal.Zero)).ToString("0.00");


                trPaidAmt.Visible = Convert.ToDecimal(lblPaidAmt.Text).Equals(decimal.Zero) ? false : true;
                if (trPaidAmt.Visible == false)
                {
                    Irupee10.Visible = false;
                }
                //trCoPay.Visible = IsCreditBill == "Y" ? Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true : false;
                if (trCoPay.Visible == false)
                {
                    Irupee11.Visible = false;
                }
                //trCoPay.Visible = Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true;
                // trTPADue.Visible = Convert.ToDecimal(lblTPADue.Text).Equals(decimal.Zero) ? false : true;

                //tmpResult = Convert.ToDecimal(txtGrandTotal.Text) + dPrevDue;
                //txtGrandTotal.Text = tmpResult - Convert.ToDecimal(lblCoPayment.Text) > decimal.Zero ? (tmpResult - Convert.ToDecimal(lblCoPayment.Text)).ToString("0.00") : tmpResult.ToString("0.00");
                //txtGrandTotal.Text = tmpResult - Convert.ToDecimal(lblCoPayment.Text) < decimal.Zero ? decimal.Zero.ToString("0.00") : tmpResult.ToString("0.00");
                //lblCoPayment.Text = tmpResult - Convert.ToDecimal(lblCoPayment.Text) > decimal.Zero ? decimal.Zero.ToString("0.00"):(Convert.ToDecimal(lblCoPayment.Text) - tmpResult).ToString("0.00") ;


                //if (TpaNetBill > pPreAuthAmount)
                //{

                //    txtGrandTotal.Text = (TpaNetBill - pPreAuthAmount) > Convert.ToDecimal(lblCoPayment.Text) ? Convert.ToDecimal(lblCoPayment.Text) > decimal.Zero ? ((TpaNetBill - pPreAuthAmount) - Convert.ToDecimal(lblCoPayment.Text)).ToString("0.00") : (TpaNetBill - pPreAuthAmount).ToString("0.00") : decimal.Zero.ToString("0.00");
                //    txtGrandTotal.Text = (Convert.ToDecimal(txtGrandTotal.Text) + (Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) == decimal.Zero ? Convert.ToDecimal(hdnNonMedicalDetails.Value) : decimal.Zero)).ToString("0.00");
                //    txtGrandTotal.Text = (Convert.ToDecimal(txtGrandTotal.Text) + (Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) < Convert.ToDecimal(hdnNonMedicalDetails.Value) && Convert.ToDecimal(lblCoPayment.Text) > decimal.Zero ? Convert.ToDecimal(hdnNonMedicalDetails.Value) - Convert.ToDecimal(lblCoPayment.Text) : decimal.Zero)).ToString();
                //    lblCoPayment.Text = ((Convert.ToDecimal(lblCoPayment.Text) - Convert.ToDecimal(hdnNonMedicalDetails.Value) > decimal.Zero && Convert.ToDecimal(lblCoPayment.Text) > Convert.ToDecimal(hdnNonMedicalDetails.Value)  ? Convert.ToDecimal(hdnNonMedicalDetails.Value) : decimal.Zero)).ToString("0.00");
                //    lblTPADue.Text = pPreAuthAmount > decimal.Zero && Convert.ToDecimal(txtThirdParty.Text) < pPreAuthAmount ? (pPreAuthAmount - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : Convert.ToDecimal(txtThirdParty.Text).Equals(decimal.Zero) ? pPreAuthAmount.ToString("0.00") : decimal.Zero.ToString("0.00");
                //    //txtThirdParty.Text = pPreAuthAmount.ToString("0.00");
                //    txtGrandTotal.Text = (Convert.ToDecimal(txtGrandTotal.Text) + dPrevDue).ToString();
                //}
                //else
                //{
                //    lblTPADue.Text = Convert.ToDecimal(txtThirdParty.Text) < TpaNetBill && Convert.ToDecimal(txtThirdParty.Text) > decimal.Zero ? (TpaNetBill - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : TpaNetBill.ToString("0.00");
                //}
                //lblDueAmount.Text = Convert.ToDecimal(txtGrandTotal.Text) > decimal.Zero ? num.Convert(Convert.ToDecimal(txtGrandTotal.Text).ToString()) + " Only..." : " Zero Only...";
                #endregion
                #endregion
            }
            else
            {
                //trPaidAmt.Visible = false;
                trCoPay.Visible = false;
                // trTPADue.Visible = false;
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
            //new GateWay(base.ContextInfo).GetConfigDetails("Footer", OrgID, out lstConfig);
            //if (lstConfig.Count > 0)
            //{
            //    if (lstConfig[0].ConfigValue != "")
            //    {

            //        medfortfooter.InnerHtml = lstConfig[0].ConfigValue;
            //    }
            //}

            #region calculate claimAmount

            if (IsCreditBill == "Y")
            {
                if (pPreAuthAmount < Convert.ToDecimal(txtGross.Text))
                {
                    //lblTPADue.Text = ((Convert.ToDecimal(pPreAuthAmount) + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(lblRoundOff.Text)) - Convert.ToDecimal(txtThirdParty.Text)).ToString();
                    lblTPADue.Text = ((Convert.ToDecimal(pPreAuthAmount) + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(lblRoundOff.Text) - Convert.ToDecimal(pCoPayment)).ToString("0.00"));

                }
                else
                {
                    lblTPADue.Text = ((Convert.ToDecimal(txtGross.Text) - Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(lblRoundOff.Text)) - Convert.ToDecimal(pCoPayment) - (chkMedicalItems.Checked ? 0 : Convert.ToDecimal(lblPaidAmt.Text))).ToString();

                }
            }


            #endregion
            #region PreAuthAmount
            if ((pPreAuthAmount >= 0 && IsCreditBill == "Y") || firstLoad == 0)
            {
                Preauth.Style.Add("display", (IsCreditBill == "Y" ? "block" : "none"));
                lblPreAuthAmount.Text = pPreAuthAmount.ToString("0.00");

                //trRoundOff.Style.Add("display", "none");
                //trCreditDebit.Style.Add("display", "none");

                if (lblServiceCharge.Text == "0.00")
                {
                    trCreditDebit.Style.Add("display", "none");
                }
                if (lblRoundOff.Text == "0.00")
                {
                    trRoundOff.Style.Add("display", "none");
                }
                if (IsCreditBill == "N")
                {
                    trAmountReceived.Style.Add("display", "block");
                    //trPreviousDue.Style.Add("display", "block");
                }
                if (IsCreditBill == "Y")
                {
                    // trAmountReceived.Style.Add("display", "none");
                    trTaxDetails.Style.Add("display", "none");
                    trDiscount.Style.Add("display", "none");
                    trEnhanceMent.Style.Add("display", "block");
                    trTax.Style.Add("display", "block");
                    //trPaidAmt.Style.Add("display", "none");
                    trAmountInWords.Style.Add("display", "none");
                    //trTPADue.Style.Add("display", "block");
                   // trGrsndTotal.Style.Add("display", "none");
                    //trDueAmountinWords.Style.Add("display", "none");
                    //lbldueamt.Text = "Claim Amount in Words";
                    //lblDueAmount.Text = num.Convert(lblTPADue.Text) + " Only";
                }
                if (firstLoad != 0)
                    trNonMedicalItems.Style.Add("display", "none");
                if (firstLoad == 0)
                    trNonMedicalItems.Style.Add("display", "block");
            }

            #endregion



            #region KmhInsurance Footer
            decimal roundValue = Math.Round(Convert.ToDecimal(lblTPADue.Text));
            ldlGross.Text = txtGross.Text;
            lblCoPayments.Text = lblCoPayment.Text;
            lblPreAutho.Text = pPreAuthAmount.ToString("0.00");
            lblDueTpa.Text = roundValue.ToString("0.00");
            lblTax.Text = txtTax.Text;
            #endregion
            #region Avoid zero amount display
            if (txtDiscount.Text != "0.00")
                trDiscount.Style.Add("display", "block");
            if (txtTax.Text != "0.00")
                trTax.Style.Add("display", "block");
            if (dvTaxDetails.InnerHtml != "0.00")
                trTaxDetails.Style.Add("display", "block");
            if (txtPreviousDue.Text != "0.00")
                trPreviousDue.Style.Add("display", "block");
            if (lblServiceCharge.Text != "0.00")
                trCreditDebit.Style.Add("display", "block");
            if (lblRoundOff.Text != "0.00")
                trRoundOff.Style.Add("display", "block");
            //if (lblTotal.Text != "0.00")
            //    trNetAmount.Style.Add("display", "block");
            lblPreAuthAmount.Text = pPreAuthAmount.ToString("0.00");
            if (lblPreAuthAmount.Text != "0.00")
                Preauth.Style.Add("display", "block");
            if (txtPreviousAmountPaid.Text != "0.00")
            {
                trAmountReceived.Style.Add("display", "block");
                divMore1.Style.Add("display", "block");
            }
            if (lblCoPayment.Text != "0.00")
                trCoPay.Style.Add("display", "block");
            if (txtThirdParty.Text != "0.00")
                trAmountFromTPA.Style.Add("display", "block");
            //if (lblTPADue.Text != "0.00")
            //    trTPADue.Style.Add("display", "block");
            if (txtGrandTotal.Text != "0.00")
            {
               // trGrsndTotal.Style.Add("display", "block");
                tdDueAmount.Style.Add("display", "block");
            }
            #endregion


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }



    protected void gvIndentRoomType_RowDataBound(Object sender, GridViewRowEventArgs e)
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

    protected void gvTreatment_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //PatientDueChart BMaster = (PatientDueChart)e.Row.DataItem;
                Label lblFeeType = (Label)e.Row.FindControl("lblFeeType");
                GridView childGrid = (GridView)e.Row.FindControl("gvIndents");

                decimal dtotalAmount = 0;
                Label lblFeeTypeDetails = (Label)e.Row.FindControl("lblFeeTypeDetails");
                lblFeeTypeDetails.Text = "";
                new GateWay(base.ContextInfo).GetConfigDetails("Grdheader", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue.ToUpper() == "Y")
                    {
                        lblFeeTypeDetails.Text = "";
                    }
                }
                else
                {
                    if (lblFeeType.Text == "CON")
                    {
                        lblFeeTypeDetails.Text = "Consultation";
                    }
                    else if (lblFeeType.Text == "PRO")
                    {
                        lblFeeTypeDetails.Text = "Procedures";
                    }
                    else if (lblFeeType.Text == "INV" || (lblFeeType.Text == "PKG") || (lblFeeType.Text == "GRP"))
                    {
                        lblFeeTypeDetails.Text = "LAB";
                    }
                    else if (lblFeeType.Text == "IND")
                    {
                        lblFeeTypeDetails.Text = "Medical Indents";
                    }
                    else if (lblFeeType.Text == "SOI" || lblFeeType.Text == "SUR")
                    {
                        lblFeeTypeDetails.Text = "Surgery/Intervention";
                    }
                    else if (lblFeeType.Text == "SPKG")
                    {
                        lblFeeTypeDetails.Text = "Surgery Packages";
                    }
                    else if (lblFeeType.Text == "CAS")
                    {
                        lblFeeTypeDetails.Text = "Casuality";
                    }
                    else if (lblFeeType.Text == "IMU")
                    {
                        lblFeeTypeDetails.Text = "Immunization";
                    }
                    else
                    {
                        lblFeeTypeDetails.Text = "Other Treatment Charges";
                    }
                }
                if (lblFeeTypeDetails.Text != "LAB")
                {
                    var childItems = from child in lstDueChart
                                     where child.FeeType == lblFeeType.Text.Trim() && child.IsReimbursable != "N"
                                     select child;

                    List<PatientDueChart> lstchilddues = new List<PatientDueChart>();
                    lstchilddues = (List<PatientDueChart>)childItems.ToList();

                    lstNonMedicalItems.AddRange((from child in lstDueChart
                                                 where child.FeeType == lblFeeType.Text.Trim() && child.IsReimbursable == "N"
                                                 select child).ToList());

                    var sumAmount = (from lstdues in lstchilddues
                                     select (lstdues.Amount * lstdues.Unit)).Sum();
                    new GateWay(base.ContextInfo).GetConfigDetails("Grdheader", OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                    {
                        if (lstConfig[0].ConfigValue.ToUpper() == "N")
                        {
                            lblFeeTypeDetails.Text = "";
                        }
                    }
                    else
                    {
                        lblFeeTypeDetails.Text = lblFeeTypeDetails.Text + " : -" + CurrencyName + " " + sumAmount.ToString("0.00");
                    }

                    if (sumAmount != decimal.Zero)
                    {
                        lblFeeTypeDetails.Visible = true;
                    }
                    else
                    {
                        lblFeeTypeDetails.Visible = false;
                    }
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
                }
                else if (lblFeeTypeDetails.Text == "LAB")
                {
                    List<string> lstChildItems = (from child in lstDueChart
                                                  orderby child.Comments ascending
                                                  where (child.FeeType == "INV") || (child.FeeType == "PKG") || (child.FeeType == "GRP")
                                                  select child.Comments.Split('~')[1]).Distinct().ToList();

                    int iCount = lstChildItems.Count;
                    if (sLabEntered <= iCount)
                    {
                        List<PatientDueChart> childItems = (from child in lstDueChart
                                                            orderby child.Comments ascending
                                                            where (child.FeeType == "INV") || (child.FeeType == "PKG") || (child.FeeType == "GRP")
                                                            select child).ToList();
                        if (childItems.Count > 0)
                        {
                            if (lstChildItems.Count > iTempCount)
                            {
                                List<PatientDueChart> childSubitems = (from child in childItems
                                                                       where (child.Comments.Split('~')[1].ToLower() == lstChildItems[iTempCount].ToLower()) && child.IsReimbursable != "N"
                                                                       select child).ToList();


                                lstNonMedicalItems.AddRange((from child in childItems
                                                             where (child.Comments.Split('~')[1].ToLower() == lstChildItems[iTempCount].ToLower()) && child.IsReimbursable == "N"
                                                             select child).ToList());
                                //childSubitems = childSubitems.FindAll(delegate(PatientDueChart h) { return h.Comments.Split('~')[1].ToLower() != lstAddData; });
                                string stemp = lstChildItems[iTempCount];
                                lstAddData.Add(stemp);

                                //withDue = dueSearch.FindAll(delegate(DailyReport h) { return h.AmountDue > 0; });

                                //GridView childGrid = (GridView)e.Row.FindControl("gvIndents");
                                if (childSubitems.Count > 0)
                                {
                                    childGrid.DataSource = childSubitems;
                                    childGrid.DataBind();
                                    childGrid.Visible = true;
                                }
                                else
                                {
                                    childGrid.Visible = false;
                                }

                                List<PatientDueChart> lstchilddues = new List<PatientDueChart>();
                                lstchilddues = (List<PatientDueChart>)childItems.ToList();
                                var sumAmount = (from lstdues in childSubitems
                                                 select (lstdues.Amount * lstdues.Unit)).Sum();
                                if (lstChildItems[iTempCount] != "")
                                {
                                    lblFeeTypeDetails.Text = lstChildItems[iTempCount] + " : -" + CurrencyName + " " + sumAmount.ToString("0.00");
                                }
                                else
                                {
                                    lblFeeTypeDetails.Text = lblFeeTypeDetails.Text + " : -" + CurrencyName + " " + sumAmount.ToString("0.00");
                                }

                                if (sumAmount != decimal.Zero)
                                {
                                    lblFeeTypeDetails.Visible = true;
                                }
                                else
                                {
                                    lblFeeTypeDetails.Visible = false;
                                }

                            }
                            else
                            {
                                lblFeeTypeDetails.Visible = false;
                                lblFeeType.Visible = false;
                                lblFeeTypeDetails.Text = "";
                            }

                        }
                        else
                        {
                            lblFeeTypeDetails.Visible = false;
                        }
                        childGrid.Visible = true;
                        sLabEntered++; iTempCount++;

                    }
                    else
                    {
                        lblFeeTypeDetails.Visible = false;
                    }

                }
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

    protected void gvIndentRoomDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;

        e.Row.Cells[3].Visible = true;
        e.Row.Cells[9].Visible = false;
        if (e.Row.Cells[9].Text == "Pending")
        {
            e.Row.BackColor = System.Drawing.Color.Gray;
        }
        //if (sChkVal == "Y")
        //{
        //    if (Convert.ToInt64(e.Row.Cells[0].Text.Trim()) >= sBID && Convert.ToInt64(e.Row.Cells[0].Text.Trim()) <= sEID)
        //    {
        //        e.Row.Visible = true;
        //    }
        //    else
        //    {
        //        e.Row.Visible = false;
        //    }
        //}
        //else
        //{
        //    e.Row.Visible = true;
        //}
    }
    protected void gvPharmacy_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblBatchNo = new Label();
            Label lblExpiryDate = new Label();
            lblBatchNo = (Label)e.Row.FindControl("lblBatchNo");
            lblExpiryDate = (Label)e.Row.FindControl("lblExpiryDate");
            PatientDueChart pdc = (PatientDueChart)e.Row.DataItem;
            lblExpiryDate.Text = pdc.ExpiryDate.ToString("MMM/yyyy");
            if (pdc.ExpiryDate < DateTime.Parse("01/01/1900"))
            {
                lblExpiryDate.Text = "-";
            }
            if (pdc.BatchNo == "")
            {
                lblBatchNo.Text = "-";
            }
            Label titleLabel = (Label)e.Row.FindControl("lblReceiptNO");
            string strval = ((Label)(titleLabel)).Text;
            string title = (string)ViewState["title"];
            if (title == strval)
            {
                titleLabel.Visible = false;
                titleLabel.Text = string.Empty;
            }
            else
            {
                title = strval;
                ViewState["title"] = title;
                titleLabel.Visible = true;
                titleLabel.Text = "<b>" + title + "</b>";
            }

        }



    }

    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //FeeType ="SPKG";
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;

        e.Row.Cells[3].Visible = true;
        e.Row.Cells[8].Visible = false;

        //This code for To split the data in Report side (description and Amount ) in organisation 82(MED)
        //int iBillGroupID2 = 0;
        //iBillGroupID2 = (int)ReportType.IPBill;

        //new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID2, "SplitFBillDA", OrgID, ILocationID, out lstConfig);
        //if (lstConfig.Count > 0)
        //{
        //    if (lstConfig[0].ConfigValue.Trim() == "Y")
        //    {
        if (s == 'Y')
        {
            Label txtUnitPrice = (Label)e.Row.FindControl("txtUnitPrice");
            Label chkID1 = (Label)e.Row.FindControl("chkID");



            if ((e.Row.Cells[1].Text == "SPKG"))
            {


                string[] s1 = chkID1.Text.Split('~');
                chkID1.Text = s1[1].ToString();
                txtUnitPrice.Text = s1[2].ToString();

            }
        }
        else
        {

            Label txtUnitPrice = (Label)e.Row.FindControl("txtUnitPrice");
            Label chkID1 = (Label)e.Row.FindControl("chkID");



            if ((e.Row.Cells[1].Text == "SPKG"))
            {


                string[] s1 = chkID1.Text.Split('~');
                chkID1.Text = s1[0].ToString();
                //txtUnitPrice.Text = s1[2].ToString();
            }
        }

        //    }
        //}



        //End for split data in orgid 82
        if (e.Row.Cells[8].Text == "Pending")
        {
            e.Row.BackColor = System.Drawing.Color.Gray;
        }
        HiddenField hdnServiceCode = (HiddenField)e.Row.FindControl("hdnServiceCode");

        if (hdnServiceCode != null && hdnServiceCode.Value.Trim() != string.Empty && ((PatientDueChart)e.Row.DataItem).FeeType != "CON")
        {
            Label chkID = (Label)e.Row.FindControl("chkID");
            chkID.Text += " (" + hdnServiceCode.Value + ")";
        }
        if (showdateandstatus == "N" && !string.IsNullOrEmpty(showdateandstatus))
        {
            e.Row.Cells[4].Visible = false;

        }
        //if (sChkVal == "Y")
        //{
        //    if (Convert.ToInt64(e.Row.Cells[0].Text.Trim()) >= sBID && Convert.ToInt64(e.Row.Cells[0].Text.Trim()) <= sEID)
        //    {
        //        e.Row.Visible = true;
        //    }
        //    else
        //    {
        //        e.Row.Visible = false;
        //    }
        //}
        //else
        //{
        //    e.Row.Visible = true;
        //}
        //e.Row.Cells[11].Visible = true;
        //((GridView)gvTreatmentCharges.FindControl("gvIndents")).Columns[4].Visible = false;

    }


    protected void gridAttributesAdd(GridView gvAll)
    {
        decimal dtotalAmount = 0;
        //string sStatus = "";

        foreach (GridViewRow row in gvAll.Rows)
        {
            Label txtUnitPrice = new Label();
            Label txtQuantity = new Label();
            Label txtAmount = new Label();
            //HiddenField hdnAmount = new HiddenField();
            //HiddenField hdnOldPrice = new HiddenField();
            //HiddenField hdnOldQuantity = new HiddenField();

            //txtUnitPrice = (Label)row.FindControl("txtUnitPrice");
            //txtQuantity = (Label)row.FindControl("txtQuantity");
            txtAmount = (Label)row.FindControl("txtAmount");

            //hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            //hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            //hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");
            dtotalAmount += Convert.ToDecimal(txtAmount.Text);
        }
        txtGross.Text = (Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(dtotalAmount)).ToString();

    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    protected void btnViewSummary_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string BP = "Y";

        if (Request.QueryString["BP"] != null)
        {
            BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
        }
        Response.Redirect("~/InPatient/IPSummaryBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=" + BP + "");
    }

    protected void btnItemizedBill_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string BP = "Y";

        if (Request.QueryString["BP"] != null)
        {
            BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
        }
        Response.Redirect("~/InPatient/IPItemizedBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=" + BP + "");
    }

    protected void btnViewReceipt_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        BillingEngine objBL = new BillingEngine(base.ContextInfo);
        List<BillSearch> lstDetails = new List<BillSearch>();
        long returnCode = -1;
        string receiptNo = string.Empty;
        decimal amtreceived = 0;
        string patientName = string.Empty;
        string BP = "Y";
        string PatientNumber = string.Empty;

        returnCode = objBL.GetGenerateBillReceipt(visitID, OrgID, out lstDetails);
        if (lstDetails.Count > 0)
        {
            receiptNo = lstDetails[0].ClientName;
            amtreceived = lstDetails[0].Amount;
            patientName = lstDetails[0].Name;
            sType = lstDetails[0].Status;
            ipInertID = lstDetails[0].PaymentDetailsID;
            PatientNumber = lstDetails[0].PatientNumber.ToString();
            if (Request.QueryString["BP"] != null)
            {
                BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
            }
            string skey = "PrintReceiptPage.aspx?Amount="
                       + amtreceived + "&dDate="
                       + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                       + "&rcptno=" + receiptNo
                       + "&PID=" + patientID.ToString()
                       + "&VID=" + visitID.ToString()
                       + "&PNAME=" + patientName
                       + "&pdid=" + ipInertID.ToString()
                       + "&PNumber=" + PatientNumber
                       + "&pDet=" + sType
                       + "&FinalReceipt=Y"
                       + "";

            this.Page.RegisterClientScriptBlock("sky",
                "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "alert('No Receipt for this Patient');", true);
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



    protected void chkMedicalItems_CheckedChanged(object sender, EventArgs e)
    {
        if (chkMedicalItems.Checked == true)
        {
            firstLoad = 1;
            hdnGross.Value = "0.00";
            txtGross.Text = "0.00";
            txtDiscount.Text = "0.00";
            txtTax.Text = "0.00";
            txtPreviousDue.Text = "0.00";
            lblServiceCharge.Text = "0.00";
            lblRoundOff.Text = "0.00";
            lblTotal.Text = "0.00";
            lblPreAuthAmount.Text = "0.00";
            txtPreviousAmountPaid.Text = "0.00";
            lblPaidAmt.Text = "0.00";
            lblCoPayment.Text = "0.00";
            txtThirdParty.Text = "0.00";
            lblTPADue.Text = "0.00";
            txtGrandTotal.Text = "0.00";
            ldlGross.Text = "0.00";
            lblPreAutho.Text = "0.00";
            lblCoPayment.Text = "0.00";
            lblTax.Text = "0.00";
            lblDueTpa.Text = "0.00";
            hdnNonMedicalDetails.Value = "0.00";
            lblNonMedicalDetails.Text = "0.00";

        }
        if (chkMedicalItems.Checked == false)
        {
            firstLoad = 0;
            hdnGross.Value = "0.00";
            txtGross.Text = "0.00";
            txtDiscount.Text = "0.00";
            txtTax.Text = "0.00";
            txtPreviousDue.Text = "0.00";
            lblServiceCharge.Text = "0.00";
            lblRoundOff.Text = "0.00";
            lblTotal.Text = "0.00";
            lblPreAuthAmount.Text = "0.00";
            txtPreviousAmountPaid.Text = "0.00";
            lblPaidAmt.Text = "0.00";
            lblCoPayment.Text = "0.00";
            txtThirdParty.Text = "0.00";
            lblTPADue.Text = "0.00";
            txtGrandTotal.Text = "0.00";
            ldlGross.Text = "0.00";
            lblPreAutho.Text = "0.00";
            lblCoPayment.Text = "0.00";
            lblTax.Text = "0.00";
            lblDueTpa.Text = "0.00";
            hdnNonMedicalDetails.Value = "0.00";
            lblNonMedicalDetails.Text = "0.00";
        }
        LoadDetails(firstLoad);
    }
    protected void chkPharmaPrint_CheckedChanged(object sender, EventArgs e)
    {
        if (chkPharmaPrint.Checked == true)
        {
            gvMedicalItems.Style.Add("display", "block");
            tdpharma.Style.Add("align", "left");
            dvpharmacy.Style.Add("text-align", "left");
            chkPharmaPrint.Text = "Dont Show Pharmacy Items";

        }
        else
        {
            gvMedicalItems.Style.Add("display", "none");
            dvpharmacy.Style.Add("text-align", "right");
            tdpharma.Style.Add("align", "right");
            chkPharmaPrint.Text = "Show Pharmacy Items";

        }
    }
}