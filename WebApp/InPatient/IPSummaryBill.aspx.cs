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

public partial class InPatient_IPSummaryBill : BasePage
{
    public InPatient_IPSummaryBill()
        : base("InPatient\\IPSummaryBill.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstDueChart1 = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
    List<Config> lstConfig;
    string primaryConsultant = string.Empty;
    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    decimal Due = 0;
    string IsCreditBill = string.Empty;
    int firstLoad = -1;
    long visitID = 0;
    long patientID = 0;
    string sPaymentType = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                
                if (Request.QueryString["VID"] != null)
                {
                    visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
                }

                
                if (Request.QueryString["PID"] != null)
                {
                    patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
                }
               
                if (Request.QueryString["PTYPE"] != null)
                {
                    sPaymentType = Request.QueryString["PTYPE"].ToString();
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
                       // tblHeader.Visible = false;
                    }
                }

                firstLoad = 0;

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
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

        try
        {
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
                    DiagnoseWithICD1.LoadPatientComplaintWithICD(visitID, "IP", "OPR");
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
            List<AmountReceivedDetails> lstAmtReceived = new List<AmountReceivedDetails>();

            new PatientVisit_BL(base.ContextInfo).pGetAmountReceivedDetailsForIPBILL(visitID, out lstAmtReceived);
            if (lstAmtReceived.Count > 0)
            {
                grdPayDetails.DataSource = lstAmtReceived;
                grdPayDetails.DataBind();
            }
            BillingEngine be = new BillingEngine(base.ContextInfo);
            decimal Copercent = -1;
            be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);

            txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());

            string NeedTime = string.Empty;
            List<Config> lstconfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedTimeToPrint", OrgID, out lstconfig);

            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
                NeedTime = "Y";
                

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
            

            List<TempFees> lstTempData = new List<TempFees>();
            int length = lstPatientDetail.Count;
            for (int i = 0; i < length; i++)
            {
                string TPAAttributes = (lstPatientDetail[i].TPAAttributes == null) ? "" : lstPatientDetail[i].TPAAttributes;
                if (TPAAttributes != "" || lstPatientDetail[i].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetail[i].TPAAttributes, lstPatientDetail[i].TPAName);

                }
            }
            decimal lstTempFees = 0;
            decimal dTotal = 0;
            
            if (IsCreditBill == "Y")
            {
                //ROOM CHARGES
                lstTempFees = (from dAmt in lstBedBooking
                                   where dAmt.IsReimbursable != "N"
                                   select (dAmt.Amount * dAmt.Unit)).Sum();

                TempFees tmpfees = new TempFees();
                dTotal = (decimal)lstTempFees;
                if (dTotal > decimal.Zero)
                {
                    tmpfees.Description = "Room Charges";
                    tmpfees.Amount = dTotal;
                    lstTempData.Add(tmpfees);
                }

                //SURGERY AMOUNT 


                List<PatientDueChart> lstTempsoi = (from dAmt in lstDueChart
                                                    where (dAmt.FeeType.ToUpper() == "SOI" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
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
                                                     where (dAmt.FeeType.ToUpper() == "SPKG" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
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
                               where dAmt.FeeType.ToUpper() == "CON" && dAmt.IsReimbursable != "N"
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
                               where (dAmt.FeeType.ToUpper() == "PKG" || dAmt.FeeType.ToUpper() == "GRP" || dAmt.FeeType.ToUpper() == "INV") && dAmt.IsReimbursable != "N"
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
                               where (dAmt.FeeType.ToUpper() == "REG" || dAmt.FeeType.ToUpper() == "ADD" || dAmt.FeeType.ToUpper() == "IND") && dAmt.IsReimbursable != "N"
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
                               where dAmt.FeeType.ToUpper() == "PRM" && dAmt.IsReimbursable != "N"
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
                               where dAmt.FeeType.ToUpper() == "CAS" && dAmt.IsReimbursable != "N"
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
                               where dAmt.FeeType.ToUpper() == "IMU" && dAmt.IsReimbursable != "N"
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
                               where (dAmt.FeeType.ToUpper() == "OTH" || dAmt.FeeType.ToUpper() == "MISCELLANEOUS" || dAmt.FeeType.ToUpper() == "GEN") && dAmt.IsReimbursable != "N"
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
                if (firstLoad == 0)
                {
                    lstTempFees = (from dAmt in lstDueChart
                                   where dAmt.IsReimbursable == "N"
                                   select (dAmt.Amount * dAmt.Unit)).Sum();



                    dTotal = (decimal)lstTempFees;
                    if (dTotal > decimal.Zero)
                    {
                        tmpfees = new TempFees();
                        tmpfees.Description = "Non-MedicalItems Charges";
                        tmpfees.Amount = dTotal;
                        hdnNonMedicalDetails.Value = dTotal.ToString("0.00");
                        lstTempData.Add(tmpfees);
                    }
                }
            }
            //ROOM CHARGES
            else
            {
                lstTempFees = (from dAmt in lstBedBooking
//                                   where dAmt.IsReimbursable != "Y"
                                   select (dAmt.Amount * dAmt.Unit)).Sum();

                TempFees tmpfees = new TempFees();
                dTotal = (decimal)lstTempFees;
                if (dTotal > decimal.Zero)
                {
                    tmpfees.Description = "Room Charges";
                    tmpfees.Amount = dTotal;
                    lstTempData.Add(tmpfees);
                }

                //SURGERY AMOUNT 


                List<PatientDueChart> lstTempsoi = (from dAmt in lstDueChart
                                                    where (dAmt.FeeType.ToUpper() == "SOI" || dAmt.FeeType.ToUpper() == "SUR") 
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
                                                     where (dAmt.FeeType.ToUpper() == "SPKG" || dAmt.FeeType.ToUpper() == "SUR") 
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
                               where dAmt.FeeType.ToUpper() == "CON" 
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
                               where (dAmt.FeeType.ToUpper() == "PKG" || dAmt.FeeType.ToUpper() == "GRP" || dAmt.FeeType.ToUpper() == "INV") 
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
                               where (dAmt.FeeType.ToUpper() == "REG" || dAmt.FeeType.ToUpper() == "ADD" || dAmt.FeeType.ToUpper() == "IND") 
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
                               where dAmt.FeeType.ToUpper() == "PRM"
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
                               where dAmt.FeeType.ToUpper() == "PRO" 
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
                               where dAmt.FeeType.ToUpper() == "CAS" 
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
                               where dAmt.FeeType.ToUpper() == "IMU" 
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
                               where (dAmt.FeeType.ToUpper() == "OTH" || dAmt.FeeType.ToUpper() == "MISCELLANEOUS" || dAmt.FeeType.ToUpper() == "GEN") 
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
                //if (firstLoad == 0)
                //{
                //    lstTempFees = (from dAmt in lstDueChart
                //                   where dAmt.IsReimbursable == "N"
                //                   select (dAmt.Amount * dAmt.Unit)).Sum();



                //    dTotal = (decimal)lstTempFees;
                //    if (dTotal > decimal.Zero)
                //    {
                //        tmpfees = new TempFees();
                //        tmpfees.Description = "Non-MedicalItems Charges";
                //        tmpfees.Amount = dTotal;
                //        hdnNonMedicalDetails.Value = dTotal.ToString("0.00");
                //        lstTempData.Add(tmpfees);
                //    }
                //}
            }

            lstTempData = (from obtData in lstTempData
                           where obtData.Amount > 0
                           select obtData).ToList();

            gvPatientSummary.DataSource = lstTempData;
            gvPatientSummary.DataBind();

            lstTempFees = (from dAmt in lstTempData
                           select dAmt.Amount).Sum();

            dTotal = (decimal)lstTempFees;

            txtGross.Text = dTotal.ToString("0.00");

            txtRecievedAdvance.Text = dAdvanceAmount.ToString();
            txtPreviousAmountPaid.Text = (dTotalAmount + dAdvanceAmount + pTotSurgeryAdv - dPreviousRefund).ToString();
            //txtPreviousDue.Text = dTotalDue.ToString();
            txtPreviousRefund.Text = dPreviousRefund.ToString();
            txtPreviousDue.Text = "0.00".ToString();

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

            #region CommentTax
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
            //txtTax.Text = taxamt.ToString("0.00");
            //if (txtTax.Text == "0.00")
            //{
            //    trTax.Style.Add("display", "none");
            //}

            #endregion
            
            //txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) - dAdvanceAmount);
            txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text) + Convert.ToDecimal(lblServiceCharge.Text) - lstFinalBill[0].DiscountAmount + Convert.ToDecimal(txtTax.Text) - (Convert.ToDecimal(txtPreviousAmountPaid.Text) +
                                   dPayerTotal) //+ Convert.ToDecimal(txtRecievedAdvance.Text)
                                   + Convert.ToDecimal(txtPreviousDue.Text) + Convert.ToDecimal(lblRoundOff.Text));
            if (txtGrandTotal.Text == "0.00")
            {
                trDue.Style.Add("display", "none");
                trDueAmount.Style.Add("display", "none");
            }
            else
            {
                trDue.Style.Add("display", "block");
                trDueAmount.Style.Add("display", "block");
            }
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
                //txtGrandTotal.Text = txtRefundAmount.Text.Replace("-", "");
                txtRefundAmount.Text = "0";
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


            lblHospitalName.Text = OrgName;
            //lblPhysician.Text = physicianName[0].PhysicianName;
            lblPhysician.Text = primaryConsultant;
            lblInvoiceNo.Text = lstFinalBill[0].BillNumber.ToString();

            lblPatientNumber.Text = lstPatientDetail[0].PatientNumber.Trim();
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
            if (Convert.ToDecimal(txtGrandTotal.Text) > decimal.Zero)
            {
                if (int.Parse(txtGrandTotal.Text.Split('.')[1]) > 0)
                {
                    lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(txtGrandTotal.Text)) + " " + MinorCurrencyName + " Only";
                }
                else
                {
                    lblDueAmount.Text = num.Convert(txtGrandTotal.Text) + " Only";
                }
            }
            else
            {
                lblDueAmount.Text = " Zero Only";
            }


            

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


            
            //if (((CheckBox)PreviousPage.FindControl("chkShowUnbilled")).Checked)
            //{
            //    txtRecievedAdvance.Text = (Convert.ToDecimal(txtRecievedAdvance.Text)-Convert.ToDecimal(((HiddenField)PreviousPage.FindControl("hdnUnBilledAdvanceReceived")).Value)).ToString("0.00");
            //}
            lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("InsuranceHead", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue == "Insurance Head" && IsCreditBill == "Y")
                {
                    trInsuranceDetails.Style.Add("display", "block");
                    trPatientDetails.Style.Add("display", "none");
                    btnItemizedBill.Visible = false;
                    trNormalView.Style.Add("display", "none");
                    trKmhInsuranceFooter.Style.Add("display", "block");
                }
                else
                {
                    trInsuranceDetails.Style.Add("display", "none");
                    trPatientDetails.Style.Add("display", "block");
                    trNormalView.Style.Add("display", "block");
                    trKmhInsuranceFooter.Style.Add("display", "none");
                }
            }
            else
            {
                trInsuranceDetails.Style.Add("display", "none");
                trPatientDetails.Style.Add("display", "block");
                trNormalView.Style.Add("display", "block");
                trKmhInsuranceFooter.Style.Add("display", "none");
            }

            #region Insurance Header

            var MinDate = (from Mindt in lstDueChart select Mindt.FromDate).Min();
            var MaxDate = (from Maxdt in lstDueChart select Maxdt.FromDate).Max();

            string attribvalue = string.Empty;
            string tpaName = string.Empty;
            attribvalue = FinalBillHeader1.attribValue;
            tpaName = FinalBillHeader1.tpaName;
            if ((!string.IsNullOrEmpty(attribvalue) || (!string.IsNullOrEmpty(tpaName))))
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
            lblInsurancePhysicianText.Text = primaryConsultant;
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

            #region PreAuthAmount
            if (pPreAuthAmount >= 0 && IsCreditBill == "Y")
            {
                Preauth.Style.Add("display", "block");
                lblPreAuthAmount.Text = pPreAuthAmount.ToString("0.00");
                trAmountReceived.Style.Add("display", "none");
                trRoundOff.Style.Add("display", "none");
                trCreditDebit.Style.Add("display", "none");
                trPreviousDue.Style.Add("display", "none");
                trTax.Style.Add("display", "none");
                trTaxDetails.Style.Add("display", "none");
                trDiscount.Style.Add("display", "none");
                trEnhanceMent.Style.Add("display", "block");
                //trNonMedicalItems.Style.Add("display", "none");
                trPaidAmt.Style.Add("display", "none");
                trAmountINWords.Style.Add("display", "none");


            }

            #endregion


            

            

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
                trAmountFromTPA.Style.Add("display", "block");
                lblCoPayment.Text = pCoPayment.ToString("0.00");
                lblPaidAmt.Text = pNonMedicalAmtPaid.ToString("0.00");

                trPaidAmt.Visible = Convert.ToDecimal(lblPaidAmt.Text).Equals(decimal.Zero) ? false : true;
                trCoPay.Visible = Convert.ToDecimal(lblCoPayment.Text).Equals(decimal.Zero) ? false : true;
                trTPADue.Visible = Convert.ToDecimal(lblTPADue.Text).Equals(decimal.Zero) ? false : true;

                #region try
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
                #endregion
            }
            else
            {
                trPaidAmt.Visible = false;
                trCoPay.Visible = false;
                trTPADue.Visible = false;
            }
            #region calculate claimAmount

            if (IsCreditBill == "Y")
            {
                if (lstFinalBill.Count > 0)
                {
                    if (lstFinalBill[0].TPAAmount > 0)
                        lblTPADue.Text = lstFinalBill[0].TPAAmount.ToString("0.00");
                    else
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
                }
            }



            #endregion

            #region KmhInsurance Footer
            decimal roundValue = Math.Round(Convert.ToDecimal(lblTPADue.Text));
            ldlGross.Text = txtGross.Text;
            lblCoPayments.Text = lblCoPayment.Text;
            lblPreAutho.Text = pPreAuthAmount.ToString("0.00");
            if (roundValue < 0)
                lblDueTpa.Text = "0.00";
            else
                lblDueTpa.Text = roundValue.ToString("0.00");
            lblTax.Text = txtTax.Text;
            lblInsurancePatientAmtPaidText.Text = txtPreviousAmountPaid.Text;
            lblInsurancePatientAdvanceText.Text = dAdvanceAmount.ToString("0.00");
            lblInsurancePatientAmtRefundText.Text = dPreviousRefund.ToString("0.00");

            #endregion
            if (IsCreditBill == "Y")
            {
                // trAmountReceived.Style.Add("display", "none");
                trTaxDetails.Style.Add("display", "none");
                trDiscount.Style.Add("display", "none");
                trEnhanceMent.Style.Add("display", "block");
                trTax.Style.Add("display", "block");
                //trPaidAmt.Style.Add("display", "none");
                trDueAmount.Style.Add("display", "none");
                trTPADue.Style.Add("display", "block");
                //trGrsndTotal.Style.Add("display", "none");
                trDueAmount.Style.Add("display", "block");
                lblDueAmountinWords.Visible = false;
                lblClaimAmt.Text = "Claim Amount in Words";
                if (int.Parse(lblTPADue.Text.Split('.')[1]) > 0)
                {
                    lblDueAmount.Text = Utilities.FormatNumber2Word(num.Convert(lblTPADue.Text)) + " " + MinorCurrencyName + " Only";
                }
                else
                {
                    lblDueAmount.Text = num.Convert(lblTPADue.Text) + " Only";
                }
            }

           
            if (!string.IsNullOrEmpty(lstPatientDetail[0].Comments))
                lblBilledBy.Text = "<b>Billed BY </b><br> (" + lstPatientDetail[0].Comments + ")";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }

   protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
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
       string strConfigKey = "CustomizedIPViewBilling";
       string configValue = GetConfigValue(strConfigKey, OrgID);

       if (configValue == "Y")
       {
           Response.Redirect("~/InPatient/KMHIPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=" + BP + "");
       }
       else
       {
           Response.Redirect("~/InPatient/IPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=" + BP + "");
       }
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

   protected void chkMedicalItems_CheckedChanged(object sender, EventArgs e)
   {
       if (chkMedicalItems.Checked == true)
       {
           firstLoad = 1;
         
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
          
           lblCoPayment.Text = "0.00";
          
           hdnNonMedicalDetails.Value = "0.00";
          

       }
       if (chkMedicalItems.Checked == false)
       {
           firstLoad = 0;
          
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
           
           lblCoPayment.Text = "0.00";
           
           hdnNonMedicalDetails.Value = "0.00";
          
       }
       visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
       LoadDetails(firstLoad);
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
   
}
