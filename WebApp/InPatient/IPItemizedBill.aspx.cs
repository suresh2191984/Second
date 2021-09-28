﻿using System;
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

public partial class InPatient_IPItemizedBill : BasePage
{
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstDueChart1 = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
   

    List<PatientDueChart> lstNonMedicalItems = new List<PatientDueChart>();

    List<string> lstAddData = new List<string>();
    List<Config> lstConfig;
    int sLabEntered = 0;
    int iTempCount = 0;
    string receiptNo = "";
    string primaryConsultant = string.Empty;

    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    string IsCreditBill = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
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
                string sPaymentType = "";
                if (Request.QueryString["PTYPE"] != null)
                {
                    sPaymentType = Request.QueryString["PTYPE"].ToString();
                }
                string receiptNo = "";
                if (Request.QueryString["RNO"] != null)
                {
                    receiptNo = Request.QueryString["RNO"].ToString();
                }

                if (Request.QueryString["BP"] != null)
                {
                    if (Request.QueryString["BP"].ToString() == "Y")
                    {
                        lblAmountinWords.Visible = true;
                        lblAmount.Visible = true;
                        lblSignature.Visible = true;
                        tblHeader.Visible = true;
                    }
                    else
                    {
                        lblAmountinWords.Visible = false;
                        lblAmount.Visible = false;
                        lblSignature.Visible = false;
                        tblHeader.Visible = false;
                    }
                }

                decimal dAdvanceAmount = 0;
                decimal dTotalAmount = 0;
                decimal dTotalDue = 0;
                decimal dPreviousRefund = 0;
                decimal pTotSurgeryAdv = 0;
                decimal pTotSurgeryAmt = 0;
                decimal dPayerTotal = 0;
                List<Patient> lstPatientDetail = new List<Patient>();
                List<Organization> lstOrganization = new List<Organization>();
                List<Physician> physicianName = new List<Physician>();
                List<Taxmaster> lstTaxes = new List<Taxmaster>();
                List<FinalBill> lstFinalBill = new List<FinalBill>();


                PatientHeader.PatientID = patientID;
                PatientHeader.PatientVisitID = visitID;

                #region PrintDiagnoseDetail
                lstConfig = new List<Config>();
                int iBillGroupID = 0;
                iBillGroupID = (int)ReportType.IPBill;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "PrintDiagnoseWithICD", OrgID, ILocationID, out lstConfig);

                if (lstConfig.Count > 0)
                {

                    if (lstConfig[0].ConfigValue == "Y")
                    {
                        DiagnoseWithICD1.FontSize = "10px";
                        DiagnoseWithICD1.Height = "10px";
                        DiagnoseWithICD1.HeaderText = "DIAGNOSIS";
                        DiagnoseWithICD1.LoadPatientComplaintWithICD(visitID , "IP", "OPR");
                    }

                }

                #endregion

                decimal pNonMedicalAmtPaid = decimal.Zero;
                decimal pCoPayment = decimal.Zero;
                decimal pExcess = decimal.Zero;
                string AdmissionDate = "01/01/1753";
                string MaxBillDate = "01/01/1753";
                string IsVisitHaveChild = string.Empty;
                new PatientVisit_BL(base.ContextInfo).GetIPBillSettlement(visitID, patientID, OrgID,
                                                            out dTotalAmount, out dAdvanceAmount,
                                                            out dTotalDue, out dPreviousRefund,
                                                            out lstDueChart, out lstBedBooking,
                                                            out pTotSurgeryAdv, out pTotSurgeryAmt,
                                                            out lstPatientDetail, out lstOrganization,
                                                            out physicianName, out lstTaxes, out lstFinalBill, 
                                                            out dPayerTotal,
                                                            out pNonMedicalAmtPaid, out pCoPayment, out pExcess, out AdmissionDate, out MaxBillDate, out IsVisitHaveChild,0);

                 txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());
                 //if (lstPatientDetail[0].TPAAttributes != null && lstPatientDetail[0].TPAAttributes != "")
                 //{
                 //    FinalBillHeader1.SetAttribute(lstPatientDetail[0].TPAAttributes);
                 //}
                 string TPAAttributes = (lstPatientDetail[0].TPAAttributes == null) ? "" : lstPatientDetail[0].TPAAttributes;
                 if (TPAAttributes != "" || lstPatientDetail[0].TPAName != "")
                 {
                     FinalBillHeader1.SetAttribute(lstPatientDetail[0].TPAAttributes, lstPatientDetail[0].TPAName);
                 }
                 lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                 lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");

                if (lstFinalBill.Count > 0)
                {
                    lblServiceCharge.Text = String.Format("{0:0.00}", lstFinalBill[0].ServiceCharge);
                    lblRoundOff.Text = String.Format("{0:0.00}", lstFinalBill[0].RoundOff);
                }
                if (lstDueChart.Count > 0)
                {
                    //lstDueChart = lstDueChart.Sort(
                    var chart = ((from listInd in lstDueChart
                                  where listInd.FeeType != "PRM" && listInd.FeeType != "ROM"
                                  orderby listInd.FeeType ascending
                                  select new { listInd.FeeType,listInd.Comments }).Distinct());

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
                        gvTreatmentCharges.Visible = false;
                        dvTreatmentCharges.Style.Add("display", "none");
                        trTreatmentLine.Style.Add("Display", "none");
                    }

                    //if (chart.Count > 0)
                    //{
                    //    dvTreatmentCharges.Visible = true;
                    //}
                    //else
                    //{
                    //    dvTreatmentCharges.Visible = false;
                    //}
                    //gridAttributesAdd(gvIndents);
                    
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


                    if (lstPharmacy.Count > 0)
                    {
                        List<long> childItems2 = (List<long>)(from child in lstPharmacy
                                                              group child by child.FeeID into childItems1
                                                              select childItems1.Key).ToList();

                        List<PatientDueChart> lstDistinctdues = new List<PatientDueChart>();
                        foreach (long tmp in childItems2)
                        {
                            PatientDueChart PD = new PatientDueChart();
                            long DetailsID = 0;
                            string FeeType = "";
                            string BacthNo = "";
                            DateTime ExpDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            long FeeID = 0;
                            string Description = "";
                            decimal AMOUNT = 0;
                            decimal units = 0;

                            FeeID = tmp;
                            units = (decimal)(from chld in lstPharmacy
                                              where chld.FeeID == tmp
                                              select chld.Unit).Sum();
                            AMOUNT = ((List<decimal>)(from chld in lstPharmacy
                                                      where chld.FeeID == tmp
                                                      select chld.Amount).Distinct().ToList())[0];

                            Description = ((List<string>)(from chld in lstPharmacy
                                                          where chld.FeeID == tmp
                                                          select chld.Description).Distinct().ToList())[0];

                            FeeType = ((List<string>)(from chld in lstPharmacy
                                                      where chld.FeeID == tmp
                                                      select chld.FeeType).Distinct().ToList())[0];
                            BacthNo = ((List<string>)(from chld in lstPharmacy
                                                      where chld.FeeID == tmp
                                                      select chld.BatchNo).Distinct().ToList())[0];
                            ExpDate = ((List<DateTime>)(from chld in lstPharmacy
                                                      where chld.FeeID == tmp
                                                      select chld.ExpiryDate).Distinct().ToList())[0];


                            PD.Unit = units;
                            PD.Description = Description;
                            PD.Amount = AMOUNT;
                            PD.FeeID = FeeID;
                            PD.FeeType = FeeType;
                            PD.BatchNo = BacthNo;
                            PD.ExpiryDate = ExpDate;
                            PD.DetailsID = DetailsID;
                            lstDistinctdues.Add(PD);
                        }
                        if (lstDistinctdues.Count > 0)
                        {
                            gvMedicalItems.DataSource = lstDistinctdues;
                            gvMedicalItems.DataBind();
                            gvMedicalItems.Visible = true;
                        }
                        else
                        {
                            gvMedicalItems.Visible = false;
                        }
                    }

                    if (lstPharmacy.Count > 0)
                    {
                        dvpharmacy.Style.Add("display", "block");
                        trPharmacyLine.Style.Add("Display", "block");
                    }
                    else
                    {
                        dvpharmacy.Style.Add("display", "none");
                        trPharmacyLine.Style.Add("Display", "none");
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
                        trRoomCharges.Style.Add("Display", "none");
                        trRoomLine.Style.Add("Display", "none");
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
                        lblNonMedicalDetails.Text = lblNonMedicalDetails.Text + " : -" + CurrencyName + " " + sumAmount.ToString("0.00");
                        if (sumAmount != decimal.Zero)
                        {
                            lblNonMedicalDetails.Visible = true;
                        }
                        else
                        {
                            lblNonMedicalDetails.Visible = false;
                        }
                        divNonMedicalHead.Style.Add("display", "block");
                        trNonMedicalLine.Style.Add("Display", "block");
                    }
                    else
                    {
                        divNonMedicalHead.Style.Add("display","none");
                        trNonMedicalLine.Style.Add("Display", "none");
                    }

                    gridAttributesAdd(gvNonMedicalItems);

                    txtRecievedAdvance.Text = dAdvanceAmount.ToString();
                    txtPreviousAmountPaid.Text = (dTotalAmount + dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString();
                    txtPreviousDue.Text = dTotalDue.ToString();
                    txtPreviousRefund.Text = dPreviousRefund.ToString();
                }
                decimal taxamt = 0;

                if (lstTaxes.Count > 0)
                {
                    dvTaxDetails.Visible = true;
                    string sTableHTML = "<table class='dataheaderInvCtrl' style='border-width:1px;border-style:solid;' >";
                    foreach (Taxmaster tm in lstTaxes)
                    {
                        sTableHTML += "<tr><td> " + tm.TaxName + " : </td><td>&nbsp;&nbsp;&nbsp;</td><td align='right'>" + String.Format("{0:0.00}", ((Convert.ToDecimal(txtGross.Text) - lstFinalBill[0].DiscountAmount) * (tm.TaxPercent / 100))) + "<td/></tr>";
                        taxamt += ((Convert.ToDecimal(txtGross.Text) - lstFinalBill[0].DiscountAmount) * (tm.TaxPercent / 100));
                    }
                    sTableHTML += "</table>";
                    dvTaxDetails.InnerHtml = sTableHTML;
                }
                else
                {
                    dvTaxDetails.Visible = false;
                }
                txtTax.Text = taxamt.ToString("0.00");

                //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) - dAdvanceAmount);
                txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
                                       dPayerTotal ) //+ Convert.ToDecimal(txtRecievedAdvance.Text)
                                       + Convert.ToDecimal(txtPreviousDue.Text) + Convert.ToDecimal(lblRoundOff.Text));

                lblTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblRoundOff.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) + Convert.ToDecimal(txtPreviousDue.Text));
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
                long returnCode = -1;
                List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
                List<VisitClientMapping> listVisitCLientMapping = new List<VisitClientMapping>();
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
                lblHospitalName.Text = OrgName;
                //lblPhysician.Text = physicianName[0].PhysicianName;
                lblPhysician.Text = primaryConsultant;
                lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                lblInvoiceNo.Text = lstFinalBill[0].FinalBillID.ToString();

                lblPatientNumber.Text = lstPatientDetail[0].PatientNumber.Trim();
                lblAge.Text = lstPatientDetail[0].Age;
                txtDiscount.Text = lstFinalBill[0].DiscountAmount.ToString();
                if (lstPatientDetail[0].SEX.ToUpper() == "M")
                {
                    lblSex.Text = "Male";
                }
                else if (lstPatientDetail[0].SEX.ToUpper() == "F")
                {
                    lblSex.Text = "Female";
                }
                else
                {
                    lblSex.Text = "Transgender";
                }

                lblName.Text = lstPatientDetail[0].Name;


                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
                if ((dTotalAmount + dAdvanceAmount - dPreviousRefund) > 0)
                {
                    if (int.Parse((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString().Split('.')[1]) > 0)
                    {
                        lblAmount.Text = Utilities.FormatNumber2Word(num.Convert((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString())) + " " + MinorCurrencyName + " Only...";
                    }
                    else
                    {
                        lblAmount.Text = num.Convert((dTotalAmount + dAdvanceAmount - dPreviousRefund).ToString()) + " Only...";
                    }
                }
                else
                {
                    lblAmount.Text = " Zero Only...";
                }
                //BaseControl. BC = new BaseControl();
                //lblSignature.Text = ("Billed By: (" + BC.UserName + ")").ToUpper();
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
          

                BillingEngine be = new BillingEngine(base.ContextInfo);
                decimal Copercent = -1;
                be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out listVisitCLientMapping);

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

                    lblPaidAmt.Text = pNonMedicalAmtPaid.ToString("0.00");
                    lblCoPayment.Text = pCoPayment.ToString("0.00");
                    

                    trPaidAmt.Visible = Convert.ToDecimal(lblPaidAmt.Text).Equals(decimal.Zero) ? false : true;
                    trCoPay.Visible = Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true;
                    trTPADue.Visible = Convert.ToDecimal(lblTPADue.Text).Equals(decimal.Zero) ? false : true;

                    #region Try

                    //txtGrandTotal.Text = "0.00";
                    //lblCoPayment.Text = "0.00";
                    //lblPaidAmt.Text = hdnNonMedicalDetails.Value = hdnNonMedicalDetails.Value.Trim().Equals(string.Empty) ? 0.ToString("0.00") : hdnNonMedicalDetails.Value;
                    
                    //decimal TpaNetBill = Convert.ToDecimal(lblTotal.Text) - Convert.ToDecimal(hdnNonMedicalDetails.Value) - Convert.ToDecimal(txtPreviousDue.Text);
                    //decimal tmpDue = Convert.ToDecimal(hdnNonMedicalDetails.Value) + Convert.ToDecimal(txtPreviousDue.Text);
                    //decimal tmpAdv = Convert.ToDecimal(txtPreviousAmountPaid.Text);

                    //if (TpaNetBill > pPreAuthAmount)
                    //{
                    //    if (tmpDue > tmpAdv)
                    //    {
                    //        txtGrandTotal.Text = (tmpDue - tmpAdv).ToString("0.00");
                    //    }
                    //    else
                    //    {
                    //        lblCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
                    //        tmpAdv = tmpAdv - tmpDue;
                    //        if ((TpaNetBill - pPreAuthAmount) < tmpAdv)
                    //        {
                    //            lblCoPayment.Text = (tmpAdv - (TpaNetBill - pPreAuthAmount)).ToString("0.00");
                    //        }
                    //        else
                    //        {
                    //            txtGrandTotal.Text = ((TpaNetBill - pPreAuthAmount) - tmpAdv).ToString("0.00");
                    //        }
                    //    }
                    //    lblTPADue.Text = pPreAuthAmount > decimal.Zero && Convert.ToDecimal(txtThirdParty.Text) < pPreAuthAmount ? (pPreAuthAmount - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : Convert.ToDecimal(txtThirdParty.Text).Equals(decimal.Zero) ? pPreAuthAmount.ToString("0.00") : decimal.Zero.ToString("0.00");
                    //}
                    //else
                    //{
                    //    lblTPADue.Text = Convert.ToDecimal(txtThirdParty.Text) < TpaNetBill && Convert.ToDecimal(txtThirdParty.Text) > decimal.Zero ? (TpaNetBill - Convert.ToDecimal(txtThirdParty.Text)).ToString("0.00") : TpaNetBill.ToString("0.00");

                    //    if (tmpDue > tmpAdv)
                    //    {
                    //        txtGrandTotal.Text = (tmpDue - tmpAdv).ToString("0.00");
                    //    }
                    //    else
                    //    {
                    //        lblCoPayment.Text = (tmpAdv - tmpDue).ToString("0.00");
                    //    }
                    //}

                    //lblDueAmount.Text = decimal.Parse(txtGrandTotal.Text) > decimal.Zero ? num.Convert(decimal.Parse(txtGrandTotal.Text).ToString()) + " Only..." : " Zero Only...";
                   
                    #endregion
                }
                else
                {
                    trPaidAmt.Visible = false;
                    trCoPay.Visible = false;
                    trTPADue.Visible = false;
                }
            }
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
                if (lblFeeTypeDetails.Text != "LAB")
                {
                    //DetailsID,FeeType,FeeID,Description,AMOUNT,unit,
                    //lstDueChart[0].un

                    var childItems = from child in lstDueChart
                                     where child.FeeType == lblFeeType.Text.Trim() && child.IsReimbursable != "N"
                                     select child;

                    List<PatientDueChart> lstchilddues = new List<PatientDueChart>();
                    lstchilddues = (List<PatientDueChart>)childItems.ToList();
                    var sumAmount = (from lstdues in lstchilddues
                                     select (lstdues.Amount * lstdues.Unit)).Sum();

                    lstNonMedicalItems.AddRange((from child in lstDueChart
                                                 where child.FeeType == lblFeeType.Text.Trim() && child.IsReimbursable == "N"
                                                 select child).ToList());

                    var childItems2 = (from child in lstchilddues
                                       //where child.FeeType == lblFeeType.Text.Trim()
                                       group child.Description by
                                       new { child.FeeID, child.Description, child.Amount, child.FeeType } into G
                                       select G).Distinct();

                    List<PatientDueChart> lstDistinctdues = new List<PatientDueChart>();
                    foreach (var tmp in childItems2)
                    {
                        PatientDueChart PD = new PatientDueChart();
                        long DetailsID = 0;
                        string FeeType = "";
                        long FeeID = 0;
                        string Description = "";
                        decimal AMOUNT = 0;
                        decimal units = 0;
                        DateTime FromDate = DateTime.MinValue;
                        Description = tmp.Key.Description;
                        units = (decimal)(from chld in lstchilddues
                                          where chld.Description == tmp.Key.Description
                                          && chld.FeeID == tmp.Key.FeeID
                                          && chld.Amount == tmp.Key.Amount
                                          select chld.Unit).Sum();
                        AMOUNT = ((List<decimal>)(from chld in lstchilddues
                                                  where chld.Description == tmp.Key.Description
                                      && chld.FeeID == tmp.Key.FeeID
                                      && chld.Amount == tmp.Key.Amount
                                                  select chld.Amount).Distinct().ToList())[0];

                        FeeID = ((List<long>)(from chld in lstchilddues
                                              where chld.Description == tmp.Key.Description
                                       && chld.FeeID == tmp.Key.FeeID
                                       && chld.Amount == tmp.Key.Amount
                                              select chld.FeeID).Distinct().ToList())[0];

                        FeeType = ((List<string>)(from chld in lstchilddues
                                                  where chld.Description == tmp.Key.Description
                                      && chld.FeeID == tmp.Key.FeeID
                                      && chld.Amount == tmp.Key.Amount
                                                  select chld.FeeType).Distinct().ToList())[0];

                        FromDate = ((List<DateTime>)(from chld in lstchilddues
                                                   where chld.Description == tmp.Key.Description
                                       && chld.FeeID == tmp.Key.FeeID
                                       && chld.Amount == tmp.Key.Amount
                                                   select chld.FromDate).Distinct().ToList())[0];

                        PD.Unit = units;
                        PD.Description = Description;
                        PD.Amount = AMOUNT;
                        PD.FeeID = FeeID;
                        PD.FeeType = FeeType;
                        PD.DetailsID = DetailsID;
                        PD.FromDate = FromDate;
                        lstDistinctdues.Add(PD);
                    }

                    
                    lblFeeTypeDetails.Text = lblFeeTypeDetails.Text + " : -" + CurrencyName + " " + sumAmount.ToString("0.00");
                    
                    if (sumAmount != decimal.Zero)
                    {
                        lblFeeTypeDetails.Visible = true;
                    }
                    else
                    {
                        lblFeeTypeDetails.Visible = false;
                    }
                    if (lstDistinctdues.Count > 0)
                    {
                        childGrid.DataSource = lstDistinctdues;
                        childGrid.DataBind();
                        childGrid.Visible = true;
                    }
                    else
                    {
                        childGrid.Visible = true;
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

                                var childItems2 = (from child in childSubitems
                                                   //where child.FeeType == lblFeeType.Text.Trim()
                                                   group child.Description by 
                                                   new {child.FeeID,child.Description,child.Amount,child.FeeType} into G
                                                   select G);

                                List<PatientDueChart> lstDistinctdues = new List<PatientDueChart>();
                                //List<PatientDueChart> childItems3 = (List<PatientDueChart>)childItems2.ToList();

                                foreach (var tmp in childItems2)
                                {
                                    PatientDueChart PD = new PatientDueChart();
                                    long DetailsID = 0;
                                    string FeeType = "";
                                    long FeeID = 0;
                                    string Description = "";
                                    decimal AMOUNT = 0;
                                    decimal units = 0;
                                    DateTime FromDate = DateTime.MinValue;
                                    Description = tmp.Key.Description;
                                    units = (decimal)(from chld in childSubitems
                                                      where chld.Description == tmp.Key.Description
                                                      && chld.FeeID == tmp.Key.FeeID
                                                      && chld.Amount == tmp.Key.Amount
                                                      select chld.Unit).Sum();
                                    AMOUNT = ((List<decimal>)(from chld in childSubitems
                                                              where chld.Description == tmp.Key.Description
                                                  && chld.FeeID == tmp.Key.FeeID
                                                  && chld.Amount == tmp.Key.Amount
                                                              select chld.Amount).Distinct().ToList())[0];

                                    FeeID = ((List<long>)(from chld in childSubitems
                                                          where chld.Description == tmp.Key.Description
                                                   && chld.FeeID == tmp.Key.FeeID
                                                   && chld.Amount == tmp.Key.Amount
                                                          select chld.FeeID).Distinct().ToList())[0];

                                    FeeType = ((List<string>)(from chld in childSubitems
                                                              where chld.Description == tmp.Key.Description
                                                  && chld.FeeID == tmp.Key.FeeID
                                                  && chld.Amount == tmp.Key.Amount
                                                              select chld.FeeType).Distinct().ToList())[0];

                                    FromDate = ((List<DateTime>)(from chld in childSubitems
                                                                 where chld.Description == tmp.Key.Description
                                                     && chld.FeeID == tmp.Key.FeeID
                                                     && chld.Amount == tmp.Key.Amount
                                                                 select chld.FromDate).Distinct().ToList())[0];

                                    PD.Unit = units;
                                    PD.Description = Description;
                                    PD.Amount = AMOUNT;
                                    PD.FeeID = FeeID;
                                    PD.FeeType = FeeType;
                                    PD.DetailsID = DetailsID;
                                    PD.FromDate = FromDate;
                                    lstDistinctdues.Add(PD);
                                }
                                if (lstDistinctdues.Count > 0)
                                {
                                    childGrid.DataSource = lstDistinctdues;
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
    }

    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;

        e.Row.Cells[3].Visible = true;
        e.Row.Cells[8].Visible = false;
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
        //e.Row.Cells[11].Visible = true;
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


        }


    }

    protected void gvNonMedicalItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;


        e.Row.Cells[3].Visible = true;
        e.Row.Cells[7].Visible = true;
        e.Row.Cells[8].Visible = false;
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
        //e.Row.Cells[11].Visible = true;
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
            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();

            txtUnitPrice = (Label)row.FindControl("txtUnitPrice");
            txtQuantity = (Label)row.FindControl("txtQuantity");
            txtAmount = (Label)row.FindControl("txtAmount");

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");
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
    protected void btnViewBill_Click(object sender, EventArgs e)
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
        Response.Redirect("~/InPatient/IPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=" + BP + "");
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
        string BP = "Y";

        if (Request.QueryString["BP"] != null)
        {
            BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
        }
        string receiptNo = "";
        if (Request.QueryString["RNO"] != null)
        {
            receiptNo = Request.QueryString["RNO"].ToString();
        }
        string amtreceived = "";
        if (Request.QueryString["AMT"] != null)
        {
            amtreceived = Request.QueryString["AMT"].ToString();
        }

        string skey = "PrintCashReceiptPage.aspx?PID=" 
                        + patientID.ToString() + "&VID=" 
                        + visitID.ToString() + "&PNAME=&vType=IP&BP=" 
                        + BP + "&RNO=" + receiptNo 
                        + "&AMT=" + amtreceived.ToString() + "";
        this.Page.RegisterClientScriptBlock("sky",
            "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
        //Response.Redirect("~/InPatient/
    }

    public class BillingdetailsTemp
    {
        #region Fields

        private long feeid = 0;
        private string feetype = "";
        private string description = String.Empty;
        private decimal amount = 0;

        #endregion

        #region Properties
        public long FeeID
        {
            get { return feeid; }
            set { feeid = value; }
        }

        public string FeeType
        {
            get { return feetype; }
            set { feetype = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public decimal Amount
        {
            get { return amount; }
            set { amount = value; }
        }


        #endregion
    }
    
}
