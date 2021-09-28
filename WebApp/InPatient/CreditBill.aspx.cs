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

public partial class InPatient_CreditBill : BasePage
{
    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
    List<PatientDueChart> lstDueChart1 = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
    List<PatientDueChart> tempBedBooking = new List<PatientDueChart>();
    List<TempFees> lstTempData = new List<TempFees>();
    
    List<Config> lstConfig;
    string primaryConsultant = string.Empty;
    string patientName = string.Empty;
    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    decimal Due = 0;
    string IsCreditBill = string.Empty;
    decimal Total1 = 0;
    decimal GrantTotal = 0;
    decimal GrantActualTotal = 0;
    decimal ActualTotal = 0;
    int firstLoad = -1;
    long visitID = 0;
    long patientID = 0;
    string sPaymentType = "";
    decimal Total2 = 0;
    long FinalBillID = 0;
    string BP = string.Empty;
    string IsPopup = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
       // grdResult.Columns[6].Visible = false;
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
                BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
                if (BP == "Print")
                {
                    //bdnSave.Text = "Print";
                }
            }
        
            //if (!IsPostBack)
            //{ 
                LoadDetails();
                lblGrantTotal.Text = Convert.ToString(GrantTotal);
                
               
            //}
           

    }

    public void LoadDetails()
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

        try
        {
            decimal pNonMedicalAmtPaid = decimal.Zero;
            decimal pCoPayment = decimal.Zero;
            decimal pExcess = decimal.Zero;
            string AdmissionDate = "01/01/1753";
            string MaxBillDate = "01/01/1753";
            hdnValues.Value = "";

            new PatientVisit_BL(base.ContextInfo).GetIPBillSettlement_CreditBill(visitID, patientID, OrgID,
                                                        out dTotalAmount, out dAdvanceAmount,
                                                        out dTotalDue, out dPreviousRefund,
                                                        out lstDueChart, out lstBedBooking,
                                                        out pTotSurgeryAdv, out pTotSurgeryAmt,
                                                        out lstPatientDetail, out lstOrganization,
                                                        out physicianName, out lstTaxes, out lstFinalBill,
                                                        out dPayerTotal,
                                                        out pNonMedicalAmtPaid, out pCoPayment, out pExcess, out AdmissionDate, out MaxBillDate);


           // txtThirdParty.Text = String.Format("{0:0.00}", dPayerTotal.ToString());

            string NeedTime = string.Empty;
            List<Config> lstconfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("NeedTimeToPrint", OrgID, out lstconfig);

            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
                NeedTime = "Y";


            if (lstFinalBill.Count > 0)
            {
                lblBillNo.Text = lstFinalBill[0].BillNumber.ToString();
                FinalBillID = lstFinalBill[0].FinalBillID;
                
               
            }
            int length = lstPatientDetail.Count;
            for (int i = 0; i < length; i++)
            {
                string TPAAttributes = (lstPatientDetail[i].TPAAttributes == null) ? "" : lstPatientDetail[i].TPAAttributes;
                if (TPAAttributes != "" || lstPatientDetail[i].TPAName != "")
                {
                    FinalBillHeader1.SetAttribute(lstPatientDetail[i].TPAAttributes, lstPatientDetail[i].TPAName);

                }
            }
            string attribvalue = string.Empty;
            string tpaName = string.Empty;
            attribvalue = FinalBillHeader1.attribValue;
            tpaName = FinalBillHeader1.tpaName;
            if ((!string.IsNullOrEmpty(attribvalue) || (!string.IsNullOrEmpty(tpaName))))
            {
                if (!string.IsNullOrEmpty(attribvalue))
                {
                    attribvalue = attribvalue.Replace("<br>", "");
                    lblLetterNo.Text = attribvalue;
                }
                else
                {
                    lblLetterNo.Text = " - ";
                }
                if (!string.IsNullOrEmpty(tpaName))
                {
                    lblCrpName.Text = tpaName;
                }
                else
                {
                    lblCrpName.Text = " - ";
                }
            }
            
            if (lstPatientDetail.Count>0 && lstPatientDetail[0].DischargedDT != null && lstPatientDetail[0].DischargedDT.ToString() != "")
            {
                if (NeedTime == "Y")
                {
                    lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
                    lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt").Trim() == "01/01/0001 12:00 AM" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy hh:mm tt");
                    //lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    //lblInvoiceDate.Text = lstFinalBill[0].CreatedAt.ToString("dd/MMM/yy");
                    lblDOA.Text = lstPatientDetail[0].AdmissionDate.ToString("dd/MM/yyyy");
                    lblDOD.Text = lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy").Trim() == "01/01/0001" ? "" : lstPatientDetail[0].DischargedDT.ToString("dd/MM/yyyy");
                }
                if (lblDOD.Text != "")
                {
                    lblDate.Text = lblDOD.Text;
                }
                else
                {
                    lblDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                }
            }
            else
            {
                lblDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            }
            lblREGNO.Text = lstPatientDetail[0].PatientNumber.Trim();
            lblAgeSex.Text = lstPatientDetail[0].Age + "/" + lstPatientDetail[0].SEX.ToUpper();

            lblName.Text = lstPatientDetail[0].Name;
            //lblCorpName.Text = lstPatientDetail[0].TPAName;
            hdnClientId.Value=Convert.ToString(lstPatientDetail[0].ClientID);






            if (lstPatientDetail[0].IPNumber.Trim() == "0")
            {
                lblIPNo.Text = "-";
            }
            else
            {
                lblIPNo.Text = lstPatientDetail[0].IPNumber;
            }

            //List<TempFees> lstTempData = new List<TempFees>();
            
            //ROOM CHARGES
            var lstTempFees = (from dAmt in lstBedBooking
                               where dAmt.IsReimbursable != "N"
                               select (dAmt.Amount * dAmt.Unit)).Sum();
            var lstTempActualFees = (from dAmt in lstBedBooking
                               where dAmt.IsReimbursable != "N"
                               select (dAmt.Amount * dAmt.Unit)).Sum();
            var lstTempUnitPrice = (from dAmt in lstBedBooking
                                    where dAmt.IsReimbursable != "N"
                                    select dAmt.Amount).Sum();
            var lstTempUnit = (from dAmt in lstBedBooking
                               where dAmt.IsReimbursable != "N"
                               select dAmt.Unit).Sum();
            var lstFeetype = (from dfeetype in lstBedBooking
                              where dfeetype.IsReimbursable != "N"
                              select dfeetype.FeeType);
            var lstDiscount = (from dfeetype in lstBedBooking
                               where dfeetype.IsReimbursable != "N"
                               select dfeetype.DiscountAmount);

            decimal RoomDiscountPercent = 0;
            //string RoomRemarks = string.Empty;
            // RoomRemarks = lstBedBooking[0].Remarks;

            TempFees tmpfees = new TempFees();
            decimal dTotal;
            decimal dActualTotal;
            decimal dUnitPrice;
            decimal dUnit;
            string dFeetype;
            if (lstBedBooking.Count > 0)
            {
                RoomDiscountPercent = lstBedBooking[0].DiscountPercent;
                tempBedBooking = lstBedBooking;
                var Roomquery = tempBedBooking
                    .GroupBy(f => new { f.Remarks, f.DiscountPercent, f.RoomTypeID, f.Amount })
                    .Select(group => new { fee = group.Key, totalUnit = group.Sum(f => f.Unit) });

                foreach (var pd in Roomquery)
                {
                    TempFees tmpfees1 = new TempFees();
                    tmpfees1.Amount = pd.fee.Amount * pd.totalUnit;
                    tmpfees1.Unit = pd.totalUnit;
                    tmpfees1.Remarks = pd.fee.Remarks;
                    tmpfees1.Description = "Room Rent Charges";
                    tmpfees1.Unitprice = pd.fee.Amount;
                    tmpfees1.Feetype = "ROM";
                    tmpfees1.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees1.RoomTypeID = pd.fee.RoomTypeID;

                    lstTempData.Add(tmpfees1);
                }

            }

            //SURGERY AMOUNT 

            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "SOI" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();
            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                decimal SURGERYDiscountPercent = (from dAmt in lstDueChart
                                                  where (dAmt.FeeType.ToUpper() == "SOI" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
                                                  select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempSURGERYDueChart = lstDueChart.FindAll(P => P.FeeType == "SOI" || P.FeeType.ToUpper() == "SUR" && P.IsReimbursable != "N");

                var SURGERYquery = tempSURGERYDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID, f.DiscountPercent })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });

                foreach (var pd in SURGERYquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Surgery Amount";
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "SUR";
                    lstTempData.Add(tmpfees);
                }
            }



            //SURGERY Package AMOUNT 


            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "SPKG" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                decimal SPKGDiscountPercent = (from dAmt in lstDueChart
                                               where (dAmt.FeeType.ToUpper() == "SPKG" || dAmt.FeeType.ToUpper() == "SUR") && dAmt.IsReimbursable != "N"
                                               select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempSPKGDueChart = lstDueChart.FindAll(P => P.FeeType == "SPKG" || P.FeeType.ToUpper() == "SUR" && P.IsReimbursable != "N");
                var SPKGquery = tempSPKGDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });

                foreach (var pd in SPKGquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Surgery Package";
                    tmpfees.DiscountPercent = SPKGDiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "SPKG";
                    lstTempData.Add(tmpfees);
                }

            }



            //CONSULTATION 


            List<PatientDueChart> tempDueChart = lstDueChart.FindAll(P => P.FeeType == "CON" && P.IsReimbursable != "N");

            var query = tempDueChart
            .GroupBy(f => new { f.Description, f.FeeID, f.DiscountPercent, f.Remarks, f.RoomTypeID })
            .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit), totalUnit = group.Sum(f => f.Unit) });
            List<PatientDueChart> dsd = (List<PatientDueChart>)tempDueChart;

            if (dsd.Count > 0)
            {
                foreach (var pd in query)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Consultation(" + pd.fee.Description + ")";
                    tmpfees.Amount = pd.total;
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Unit = pd.totalUnit;
                    tmpfees.Feetype = tempDueChart[0].FeeType;
                    tmpfees.FeeID = pd.fee.FeeID;
                    lstTempData.Add(tmpfees);



                }
            }

            //LAB 
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "PKG" || dAmt.FeeType.ToUpper() == "GRP" || dAmt.FeeType.ToUpper() == "INV") && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();


            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                decimal LabDiscountPercent = (from dAmt in lstDueChart
                                              where (dAmt.FeeType.ToUpper() == "PKG" || dAmt.FeeType.ToUpper() == "GRP" || dAmt.FeeType.ToUpper() == "INV") && dAmt.IsReimbursable != "N"
                                              select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempLabDueChart = lstDueChart.FindAll(P => P.FeeType == "PKG" || P.FeeType.ToUpper() == "GRP" || P.FeeType.ToUpper() == "INV" && P.IsReimbursable != "N");
                var Labquery = tempLabDueChart
                    .GroupBy(f => new { f.Remarks, f.DiscountPercent, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });


                foreach (var pd in Labquery)
                {
                    //tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees = new TempFees();
                    tmpfees.Description = "Lab Charges";
                    tmpfees.Amount = pd.total;
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "INV";
                    lstTempData.Add(tmpfees);
                }

            }

            //TREATMENT 
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "REG" || dAmt.FeeType.ToUpper() == "ADD" || dAmt.FeeType.ToUpper() == "IND") && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                decimal TREATMENTDiscountPercent = (from dAmt in lstDueChart
                                                    where (dAmt.FeeType.ToUpper() == "REG" || dAmt.FeeType.ToUpper() == "ADD" || dAmt.FeeType.ToUpper() == "IND") && dAmt.IsReimbursable != "N"
                                                    select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempTretmentDueChart = lstDueChart.FindAll(P => P.FeeType == "REG" || P.FeeType.ToUpper() == "ADD" || P.FeeType.ToUpper() == "IND" && P.IsReimbursable != "N");
                var Tretmentquery = tempTretmentDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID, f.DiscountPercent })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });

                foreach (var pd in Tretmentquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Treatment Charges";
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "IND";
                    lstTempData.Add(tmpfees);
                }
            }

            //PHARMACY
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "PRM" //&& dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();
            lstTempActualFees = (from dAmt in lstDueChart
                                 where dAmt.FeeType.ToUpper() == "PRM" //&& dAmt.IsReimbursable != "N"
                                 select (dAmt.ActualAmount * dAmt.Unit)).Sum();
            dTotal = (decimal)lstTempFees;
            dActualTotal = (decimal)lstTempActualFees;
            if (dTotal > decimal.Zero)
            {
                decimal PHARMACYDiscountPercent = (from dAmt in lstDueChart
                                                   where dAmt.FeeType.ToUpper() == "PRM" //&& dAmt.IsReimbursable != "N"
                                                   select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempPharmacyDueChart = lstDueChart.FindAll(P => P.FeeType == "PRM");//&& P.IsReimbursable != "N"--PortTrust Also Pay NonMedical Amount Of Pharmacy
                var Pharmacyquery = tempPharmacyDueChart
                    .GroupBy(f => new { f.Remarks, f.DiscountPercent, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit),actualtotal=group.Sum(f=>f.ActualAmount *f.Unit) });

                foreach (var pd in Pharmacyquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Druges&Consumables";
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Amount = pd.total;
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Feetype = "PRM";
                    tmpfees.ActualAmount = pd.actualtotal;
                    lstTempData.Add(tmpfees);
                }

            }

            //PROCEDURES
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "PRO" && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();



            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {

                List<PatientDueChart> tempPROCEDURESDueChart = lstDueChart.FindAll(P => P.FeeType == "PRO" && P.IsReimbursable != "N");
                var PROCEDURESquery = tempPROCEDURESDueChart
                    .GroupBy(f => new { f.Remarks, f.DiscountPercent, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });


                foreach (var pd in PROCEDURESquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Procedure Charges";
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "PRO";
                    lstTempData.Add(tmpfees);
                }



            }

            //CASUALITY
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "CAS" && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();




            dTotal = (decimal)lstTempFees;

            if (dTotal > decimal.Zero)
            {
                decimal CASUALITYDiscountPercent = (from dAmt in lstDueChart
                                                    where dAmt.FeeType.ToUpper() == "CAS" && dAmt.IsReimbursable != "N"
                                                    select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempCASUALITYDueChart = lstDueChart.FindAll(P => P.FeeType == "CAS" && P.IsReimbursable != "N");
                var CASUALITYquery = tempCASUALITYDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });


                foreach (var pd in CASUALITYquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Casuality Charges";
                    tmpfees.DiscountPercent = CASUALITYDiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "CAS";
                    lstTempData.Add(tmpfees);
                }
            }

            //IMMUNIZATION
            lstTempFees = (from dAmt in lstDueChart
                           where dAmt.FeeType.ToUpper() == "IMU" && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;
            if (dTotal > decimal.Zero)
            {
                decimal IMMUNIZATIONDiscountPercent = (from dAmt in lstDueChart
                                                       where dAmt.FeeType.ToUpper() == "IMU" && dAmt.IsReimbursable != "N"
                                                       select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempIMMUNIZATIONDueChart = lstDueChart.FindAll(P => P.FeeType == "IMU" && P.IsReimbursable != "N");
                var IMMUNIZATIONquery = tempIMMUNIZATIONDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });


                foreach (var pd in IMMUNIZATIONquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Immunization Charges";
                    tmpfees.DiscountPercent = IMMUNIZATIONDiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "IMU";
                    lstTempData.Add(tmpfees);
                }
            }

            //MISCELLANEOUS
            lstTempFees = (from dAmt in lstDueChart
                           where (dAmt.FeeType.ToUpper() == "OTH" || dAmt.FeeType.ToUpper() == "MISCELLANEOUS" || dAmt.FeeType.ToUpper() == "GEN") && dAmt.IsReimbursable != "N"
                           select (dAmt.Amount * dAmt.Unit)).Sum();

            dTotal = (decimal)lstTempFees;

            if (dTotal > decimal.Zero)
            {
                decimal MISCELLANEOUSDiscountPercent = (from dAmt in lstDueChart
                                                        where (dAmt.FeeType.ToUpper() == "OTH" || dAmt.FeeType.ToUpper() == "MISCELLANEOUS" || dAmt.FeeType.ToUpper() == "GEN") && dAmt.IsReimbursable != "N"
                                                        select dAmt.DiscountPercent).Average();
                List<PatientDueChart> tempMISCELLANEOUSDueChart = lstDueChart.FindAll(P => P.FeeType == "OTH" || P.FeeType.ToUpper() == "MISCELLANEOUS" || P.FeeType.ToUpper() == "GEN" && P.IsReimbursable != "N");
                var MISCELLANEOUSquery = tempMISCELLANEOUSDueChart
                    .GroupBy(f => new { f.Remarks, f.RoomTypeID, f.DiscountPercent })
                    .Select(group => new { fee = group.Key, total = group.Sum(f => f.Amount * f.Unit) });


                foreach (var pd in MISCELLANEOUSquery)
                {
                    tmpfees = new TempFees();
                    tmpfees.Description = "Miscellaneous";
                    tmpfees.DiscountPercent = pd.fee.DiscountPercent;
                    tmpfees.Remarks = pd.fee.Remarks;
                    tmpfees.Amount = pd.total;
                    tmpfees.RoomTypeID = pd.fee.RoomTypeID;
                    tmpfees.Feetype = "MISCELLANEOUS";
                    lstTempData.Add(tmpfees);
                }
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
                    //hdnNonMedicalDetails.Value = dTotal.ToString("0.00");
                    lstTempData.Add(tmpfees);
                }
            }

            lstTempData = (from obtData in lstTempData
                           where obtData.Amount > 0
                           select obtData).ToList();

            //grdResult.DataSource = lstTempData;
            //grdResult.DataBind();
            //var d = (from obtData in lstTempData
            //         where obtData.Feetype == "ROM"
            //         select obtData).ToList();
            var d = (from obtData in lstTempData
                     group obtData by new { obtData.RoomTypeID } into de
                     select new { de.Key.RoomTypeID }).ToList();
            grdParentGrid.DataSource = d;
            grdParentGrid.DataBind();


            lstTempFees = (from dAmt in lstTempData
                           select dAmt.Amount).Sum();

            dTotal = (decimal)lstTempFees;


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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }
    protected void grdParentGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblRoomTypeID = (Label)e.Row.FindControl("lblRoomTypeID");
                //Label lblGrantTotal = (Label)e.Row.FindControl("lblGrantTotal");
                int RoomTypeID = Convert.ToInt32(lblRoomTypeID.Text);
                GridView grdResult = (GridView)e.Row.FindControl("grdResult");
                var f = (from obtData in lstTempData
                         where obtData.RoomTypeID == RoomTypeID
                                select obtData).ToList();
           
                grdResult.DataSource = f;
                grdResult.DataBind();
                GrantTotal += Total1;
                GrantActualTotal += ActualTotal;
                //
                Total1 = 0;
                ActualTotal = 0;
            }
         }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
       

    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblQtymode = (Label)e.Row.FindControl("lblQtymode");
                Label lblAmt = (Label)e.Row.FindControl("lblAmt");
                Label lblQty = (Label)e.Row.FindControl("lblQty");
                Label lblUnitPrice = (Label)e.Row.FindControl("lblUnitPrice");
                Label lblstar = (Label)e.Row.FindControl("lblstar");
                Label lblActAmt=(Label)e.Row.FindControl("lblActualAmt");
                
                HiddenField hdnAmt = (HiddenField)e.Row.FindControl("hdnAmt");
               

                Total1 += Convert.ToDecimal(lblAmt.Text);
                ActualTotal += Convert.ToDecimal(lblActAmt.Text);
                if (lblQty.Text == "" || lblQty.Text == null || Convert.ToDecimal(lblQty.Text) == 0)
                {
                    lblQty.Visible = false;
                    lblUnitPrice.Visible = false;
                    lblstar.Visible = false;
                    lblQtymode.Visible = false;
                }
                if (lblQtymode.Text != "" && lblQtymode.Text != null)
                {
                    if (lblQtymode.Text.ToUpper() == "ROM")
                    {
                        lblQtymode.Text = "Days";
                    }
                    else if (lblQtymode.Text.ToUpper() == "CON")
                    {
                        lblUnitPrice.Visible = false;
                        lblstar.Visible = false;
                        lblQtymode.Text = "Visits";
                    }
                    else
                    {
                        lblQtymode.Visible = false;
                    }
                }
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotalAmt1 = (Label)e.Row.FindControl("lblTotalAmt1");
                lblTotalAmt1.Text = Total1.ToString();
                Label lblATotalAmt1 = (Label)e.Row.FindControl("lblActualTotalAmt1");
                lblATotalAmt1.Text = ActualTotal.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
       

    }
    
    
    protected void btnBack_Click(object sender, EventArgs e)
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
        if (Request.QueryString["PNAME"] != null)
        {
            patientName = Request.QueryString["PNAME"].ToString();
        }
        string BP = "Y";

        if (Request.QueryString["BP"] != null)
        {
            BP = Request.QueryString["BP"].ToString() == "" ? "Y" : Request.QueryString["BP"].ToString();
        }
       
            Response.Redirect("~/InPatient/KMHIPViewBill.aspx?PID=" + patientID + "&VID=" + visitID + "&PNAME=&vType=IP&BP=Y");
       
    }
   

    private class TempFees
    {
        private decimal amount = 0;
        private decimal unit = 0;
        private decimal unitprice=0;
        private string description = "";
        private string feetype = "";
        private string remarks = "";
        private long feeID = 0;
        private decimal discountPercent = 0;
        private int roomTypeID;
        private decimal actualAmount = 0;
        public decimal Amount
        {
            get { return amount; }
            set { amount = value; }
        }
        public decimal Unit
        {
            get { return unit; }
            set { unit = value; }
        }
        public decimal Unitprice
        {
            get { return unitprice; }
            set { unitprice = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public string Feetype
        {
            get { return feetype; }
            set { feetype = value; }
        }
        public long FeeID
        {
            get { return feeID; }
            set { feeID = value; }
        }
        public decimal DiscountPercent
        {
            get { return discountPercent; }
            set { discountPercent = value; }
        }
        public string Remarks
        {
            get { return remarks; }
            set { remarks = value; }
        }
        
        public int RoomTypeID
        {
            get { return roomTypeID; }
            set { roomTypeID = value; }
        }
        public decimal ActualAmount
        {
            get { return actualAmount; }
            set { actualAmount = value; }
        }

    }
   
}
