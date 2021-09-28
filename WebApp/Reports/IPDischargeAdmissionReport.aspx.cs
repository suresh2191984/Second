using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.Collections;

public partial class Reports_IPDischargeAdmissionReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
    List<Speciality> temphy = new List<Speciality>();
    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;
            

            rblRptType.Attributes.Add("onclick", "javascript:checkAddress('" + rblRptType.ClientID + "');");          

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            if (Request.QueryString["status"] == "ADM")
            {
                rblVisitType.SelectedValue = "1";
                rblRptType.SelectedValue = "1";
                btnSubmit_Click(sender, e);
            }
            else if (Request.QueryString["status"] == "DIS")
            {
                rblVisitType.SelectedValue = "0";
                rblRptType.SelectedValue = "1";
                btnSubmit_Click(sender, e);
            }
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol2 = new DataColumn("IPNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("Age");
        DataColumn dcol5 = new DataColumn("ConsultantName");
        DataColumn dcol6 = new DataColumn("SpecialityName");
        DataColumn dcol7 = new DataColumn("BedName");
        DataColumn dcol8 = new DataColumn("DutyDoctor");
        DataColumn dcol9 = new DataColumn("DoAdmission");
        DataColumn dcol10 = new DataColumn("DoDischarge");
        DataColumn dcol11 = new DataColumn("LengthofStay");
        DataColumn dcol12 = new DataColumn("ADMDiagnosis");
        DataColumn dcol13 = new DataColumn("Address");        
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);        
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientNumber;
            dr["IPNumber"] = item.IPNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["ConsultantName"] = item.ConsultantName;
            dr["SpecialityName"] = item.SpecialityName;
            dr["BedName"] = item.BedName;
            dr["DutyDoctor"] = item.DutyDoctor;
            dr["DoAdmission"] = item.DoAdmission;
            dr["DoDischarge"] = item.DoDischarge;
            dr["LengthofStay"] = item.LengthofStay;
            dr["ADMDiagnosis"] = item.ADMDiagnosis;
            dr["Address"] = item.Address;           
            dt.Rows.Add(dr);
        }
        return dt;
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
            //if (visitTypeID == 0)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //if (visitTypeID == 1)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //else if (visitTypeID == -1)
            //{
            //    e.Row.Cells[4].Visible = true;
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;
                
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string requestType = rblVisitType.SelectedItem.Text;
        if (requestType == "DISCHARGE")
        {
            e.Row.Cells[10].Visible = true;
            //e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[9].Visible = true;
        }
        else if (requestType == "ADMISSION")
        {
            e.Row.Cells[10].Visible = false;
            e.Row.Cells[6].Visible = true;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[9].Visible = false;
        }
        if (!chkShowAddress.Checked)
        {
            e.Row.Cells[12].Visible = false;
        }

        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (!chkShowAddress.Checked)
            {
                e.Row.Cells[12].Visible = false;
            }
            if (requestType == "DISCHARGE")
            {
                e.Row.Cells[11].Text = "Final Diagnosis";
            }
            if (requestType == "ADMISSION")
            {
                e.Row.Cells[11].Text = "Provisional Diagnosis";
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string requestType = rblVisitType.SelectedItem.Text;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            
            List<Physician> lstPhysician = new List<Physician>();

            #region SearchMore
            if (hdnStats.Value == rblRptType.SelectedValue)
            {
                if (RdoSearchOption.SelectedValue == "0")
                {
                    foreach (ListItem lSpec in cblSpeciality.Items)
                    {
                        if (lSpec.Selected)
                        {
                            DayWiseCollectionReport s = new DayWiseCollectionReport();
                            s.OrgID = Convert.ToInt32(lSpec.Value);
                            lstSpecialityIds.Add(s);
                        }
                    }
                }
                if (RdoSearchOption.SelectedValue == "1")
                {
                    foreach (ListItem lSpec in cblConsultingName.Items)
                    {
                        if (lSpec.Selected)
                        {
                            DayWiseCollectionReport s = new DayWiseCollectionReport();
                            s.PhysicianID = Convert.ToInt32(lSpec.Value);
                            lstPhyIDs.Add(s);
                        }
                    }
                }
            }
            #endregion

            tdTotalCount.Visible = false;
            lbltTotal.Text = "0";
            returnCode = new Report_BL(base.ContextInfo).GetPatientReport(fDate.ToString("dd/MM/yyyy"), tDate.ToString("dd/MM/yyyy"), OrgID, 0, requestType, 0, 0, lstSpecialityIds, lstPhyIDs, out lstDWCR, out lstPhysician);
            if (lstDWCR.Count > 0)
            {                                
                IEnumerable<Speciality> lstSpeciality = (from dw in lstDWCR
                                                         group dw by new { dw.SpecialityName, dw.RowID } into g
                                                         where g.Key.RowID!=0
                                                         select new Speciality
                                                         {
                                                             SpecialityName = g.Key.SpecialityName,
                                                             SpecialityID = g.Key.RowID
                                                         }).Distinct().ToList();

                IEnumerable<WardMaster> lstWard = (from dw in lstDWCR
                                                   group dw by new { dw.WardID, dw.WardName } into g
                                                   where g.Key.WardID != 0
                                                   select new WardMaster
                                                         {
                                                             WardName = g.Key.WardName,
                                                             WardID = g.Key.WardID
                                                         }).Distinct().ToList();

                IEnumerable<Speciality> lstRefPhysicians = (from dw in lstDWCR
                                                         group dw by new { dw.ReferingPhysicianID, dw.RefphysicianName} into g
                                                         where g.Key.ReferingPhysicianID>0
                                                         select new Speciality
                                                         {
                                                             PhysicianID = g.Key.ReferingPhysicianID,
                                                             PhysicianName = g.Key.RefphysicianName
                                                         }).Distinct().ToList();


                IEnumerable<Speciality> lstPhysicians = (from dw in lstDWCR
                                                         group dw by new { dw.PhysicianID, dw.ConsultantName } into g
                                                         select new Speciality
                                                         {
                                                             PhysicianID = g.Key.PhysicianID,
                                                             PhysicianName = g.Key.ConsultantName
                                                         }).Distinct().ToList();

                var tempPhysicians = (from dw in lstDWCR
                                      group dw by new { dw.PatientVisitId } into g
                                      select new
                                      {
                                          PatientVisitId = g.Key.PatientVisitId,
                                      }).Distinct().ToList();

                foreach (var item in tempPhysicians)
                {
                    Speciality objspty = new Speciality();
                    foreach (DayWiseCollectionReport val in lstDWCR.FindAll(P => P.PatientVisitId == item.PatientVisitId))
                    {
                        objspty.PhysicianName += val.ConsultantName + ",";                       
                    }
                    objspty.PhysicianID = item.PatientVisitId;
                    objspty.PhysicianName = objspty.PhysicianName.TrimEnd(',');
                    temphy.Add(objspty);
                }

                IEnumerable<Speciality> TempPhysicians = (from dw in temphy
                                                          group dw by new { dw.PhysicianID, dw.PhysicianName } into g
                                                          select new Speciality
                                                          {
                                                              PhysicianID = g.Key.PhysicianID,
                                                              PhysicianName = g.Key.PhysicianName
                                                          }).Distinct().ToList();

                IEnumerable<Speciality> TempPhysicians1 = (from dw in temphy
                                                          group dw by new { dw.PhysicianName } into g
                                                          select new Speciality
                                                          {
                                                              PhysicianName = g.Key.PhysicianName
                                                          }).Distinct().ToList();

                if (lstSpecialityIds.Count == 0 && lstPhyIDs.Count == 0)
                {
                    LoadSpecialityName(lstSpeciality);
                    LoadPhysician(lstPhysicians);
                    LoadReferingName(lstRefPhysicians);
                    LoadWardNme(lstWard);
                    divMore3.Style.Add("display", "none");
                    divMore2.Style.Add("display", "none");
                    divMore1.Style.Add("display", "block");
                }
                else
                {
                    divMore3.Style.Add("display", "block");
                    divMore2.Style.Add("display", "block");
                    divMore1.Style.Add("display", "none");
                }
                divPrint.Style.Add("display", "block");
                trConsultant.Style.Add("display", "block");
                divMoreDetails.Style.Add("display", "block");
                div1.Style.Add("display", "block");

                if (rblRptType.SelectedValue == "0")
                {
                    #region Summary
                    rptDetails.Visible = false;
                    gvSummary.Visible = true;
                    divShowAdd.Style.Add("display", "none");

                    if (RdoSearchOption.SelectedValue == "0")
                    {
                        trConsultant.Style.Add("display", "none");
                        trSpeciality.Style.Add("display", "block");
                        gvSummary.DataSource = lstSpeciality;
                    }
                    if (RdoSearchOption.SelectedValue == "1")
                    {
                        trConsultant.Style.Add("display", "block");
                        trSpeciality.Style.Add("display", "none");
                        gvSummary.DataSource = TempPhysicians1;
                    }
                    tdTotalCount.Visible = true;
                    gvSummary.DataBind();
                    #endregion
                }
                else
                {
                    #region Details
                    tdTotalCount.Visible = false;
                    rptDetails.Visible = true;
                    gvSummary.Visible = false;
                    divShowAdd.Style.Add("display", "block");
                    List<DayWiseCollectionReport> TempDWCR = (from lst in lstDWCR
                                                                     join lstcheck in TempPhysicians on lst.PatientVisitId equals lstcheck.PhysicianID
                                                                     select new DayWiseCollectionReport
                                                                     {
                                                                         Address = lst.Address,
                                                                         ADMDiagnosis = lst.ADMDiagnosis,
                                                                         Age = lst.Age,
                                                                         AmountReceived = lst.AmountReceived,
                                                                         AmountRefund = lst.AmountRefund,
                                                                         Anaesthetist = lst.Anaesthetist,
                                                                         BedName = lst.BedName,
                                                                         BedOccName = lst.BedOccName,
                                                                         BillAmount = lst.BillAmount,
                                                                         BillDate = lst.BillDate,
                                                                         BilledAmount = lst.BilledAmount,
                                                                         BillNumber = lst.BillNumber,
                                                                         Cards = lst.Cards,
                                                                         Cash = lst.Cash,
                                                                         Casualty = lst.Casualty,
                                                                         Cheque = lst.Cheque,
                                                                         City = lst.City,
                                                                         CollectedBY = lst.CollectedBY,
                                                                         CollectedName = lst.CollectedName,
                                                                         ConsultantName = lstcheck.PhysicianName,
                                                                         Consultation = lst.Consultation,
                                                                         DateofSurgery = lst.DateofSurgery,
                                                                         DD = lst.DD,
                                                                         DeptName = lst.DeptName,
                                                                         Description = lst.Description,
                                                                         DischargeStatus = lst.DischargeStatus,
                                                                         Discount = lst.Discount,
                                                                         DISDiagnosis = lst.DISDiagnosis,
                                                                         DoAdmission = lst.DoAdmission,
                                                                         DoDischarge = lst.DoDischarge,
                                                                         Due = lst.Due,
                                                                         DutyDoctor = lst.DutyDoctor,
                                                                         FeeType = lst.FeeType,
                                                                         FinalBillID = lst.FinalBillID,
                                                                         Imaging = lst.Imaging,
                                                                         InsuranceName = lst.InsuranceName,
                                                                         IPAdvance = lst.IPAdvance,
                                                                         IPNumber = lst.IPNumber,
                                                                         ItemAmount = lst.ItemAmount,
                                                                         ItemQuantity = lst.ItemQuantity,
                                                                         Labs = lst.Labs,
                                                                         LengthofStay = lst.LengthofStay,
                                                                         MLCNo = lst.MLCNo,
                                                                         NetValue = lst.NetValue,
                                                                         OrderedDate = lst.OrderedDate,
                                                                         Others = lst.Others,
                                                                         Packages = lst.Packages,
                                                                         PatientID = lst.PatientID,
                                                                         PatientName = lst.PatientName,
                                                                         PatientNumber = lst.PatientNumber,
                                                                         PatientVisitId = lst.PatientVisitId,
                                                                         Pharmacy = lst.Pharmacy,
                                                                        // PhysicianID = lst.PhysicianID,
                                                                         PhysicianName = lst.PhysicianName,
                                                                         PlaceofDeath = lst.PlaceofDeath,
                                                                         POA = lst.POA,
                                                                         PreviousDue = lst.PreviousDue,
                                                                         Procedures = lst.Procedures,
                                                                         Qty = lst.Qty,
                                                                         ReceivedAmount = lst.ReceivedAmount,
                                                                         ReferredBy = lst.ReferredBy,
                                                                         Registrationfees = lst.Registrationfees,
                                                                         RoomName = lst.RoomName,
                                                                         RoomTypeName = lst.RoomTypeName,
                                                                         RowID = lst.RowID,
                                                                         RowNUM = lst.RowNUM,
                                                                         ServiceCharge = lst.ServiceCharge,
                                                                         SpecialityName = lst.SpecialityName,
                                                                         SurgeonName = lst.SurgeonName,
                                                                         SurgeryAdvance = lst.SurgeryAdvance,
                                                                         TaxAmount = lst.TaxAmount,
                                                                         TotalAmount = lst.TotalAmount,
                                                                         TotalCounts = lst.TotalCounts,
                                                                         TypeofAnaesthesia = lst.TypeofAnaesthesia,
                                                                         TypeofDeath = lst.TypeofDeath,
                                                                         TypeofSurgery = lst.TypeofSurgery,
                                                                         VisitDate = lst.VisitDate,
                                                                         VisitType = lst.VisitType
                                                                     }).ToList();


                    List<DayWiseCollectionReport> lstDWCR1 = (from lst in TempDWCR
                                                              group lst by new
                                                              {
                                                                  lst.Address,
                                                                  lst.ADMDiagnosis,
                                                                  lst.Age,
                                                                  lst.AmountReceived,
                                                                  lst.AmountRefund,
                                                                  lst.Anaesthetist,
                                                                  lst.BedName,
                                                                  lst.BedOccName,
                                                                  lst.BillAmount,
                                                                  lst.BillDate,
                                                                  lst.BilledAmount,
                                                                  lst.BillNumber,
                                                                  lst.Cards,
                                                                  lst.Cash,
                                                                  lst.Casualty,
                                                                  lst.Cheque,
                                                                  lst.City,
                                                                  lst.CollectedBY,
                                                                  lst.CollectedName,
                                                                  lst.ConsultantName,
                                                                  lst.Consultation,
                                                                  lst.DateofSurgery,
                                                                  lst.DD,
                                                                  lst.DeptName,
                                                                  lst.Description,
                                                                  lst.DischargeStatus,
                                                                  lst.Discount,
                                                                  lst.DISDiagnosis,
                                                                  lst.DoAdmission,
                                                                  lst.DoDischarge,
                                                                  lst.Due,
                                                                  lst.DutyDoctor,
                                                                  lst.FeeType,
                                                                  lst.FinalBillID,
                                                                  lst.Imaging,
                                                                  lst.InsuranceName,
                                                                  lst.IPAdvance,
                                                                  lst.IPNumber,
                                                                  lst.ItemAmount,
                                                                  lst.ItemQuantity,
                                                                  lst.Labs,
                                                                  lst.LengthofStay,
                                                                  lst.MLCNo,
                                                                  lst.NetValue,
                                                                  lst.OrderedDate,
                                                                  lst.Others,
                                                                  lst.Packages,
                                                                  lst.PatientID,
                                                                  lst.PatientName,
                                                                  lst.PatientNumber,
                                                                  lst.PatientVisitId,
                                                                  lst.Pharmacy,
                                                                  lst.PhysicianID,
                                                                  lst.PhysicianName,
                                                                  lst.PlaceofDeath,
                                                                  lst.POA,
                                                                  lst.PreviousDue,
                                                                  lst.Procedures,
                                                                  lst.Qty,
                                                                  lst.ReceivedAmount,
                                                                  lst.ReferredBy,
                                                                  lst.Registrationfees,
                                                                  lst.RoomName,
                                                                  lst.RoomTypeName,
                                                                  lst.RowID,
                                                                  lst.RowNUM,
                                                                  lst.ServiceCharge,
                                                                  lst.SpecialityName,
                                                                  lst.SurgeonName,
                                                                  lst.SurgeryAdvance,
                                                                  lst.TaxAmount,
                                                                  lst.TotalAmount,
                                                                  lst.TotalCounts,
                                                                  lst.TypeofAnaesthesia,
                                                                  lst.TypeofDeath,
                                                                  lst.TypeofSurgery,
                                                                  lst.VisitDate,
                                                                  lst.VisitType,
                                                              } into g
                                                              select new DayWiseCollectionReport
                                                              {
                                                                  Address = g.Key.Address,
                                                                  ADMDiagnosis = g.Key.ADMDiagnosis,
                                                                  Age = g.Key.Age,
                                                                  AmountReceived = g.Key.AmountReceived,
                                                                  AmountRefund = g.Key.AmountRefund,
                                                                  Anaesthetist = g.Key.Anaesthetist,
                                                                  BedName = g.Key.BedName,
                                                                  BedOccName = g.Key.BedOccName,
                                                                  BillAmount = g.Key.BillAmount,
                                                                  BillDate = g.Key.BillDate,
                                                                  BilledAmount = g.Key.BilledAmount,
                                                                  BillNumber = g.Key.BillNumber,
                                                                  Cards = g.Key.Cards,
                                                                  Cash = g.Key.Cash,
                                                                  Casualty = g.Key.Casualty,
                                                                  Cheque = g.Key.Cheque,
                                                                  City = g.Key.City,
                                                                  CollectedBY = g.Key.CollectedBY,
                                                                  CollectedName = g.Key.CollectedName,
                                                                  ConsultantName = g.Key.ConsultantName,
                                                                  Consultation = g.Key.Consultation,
                                                                  DateofSurgery = g.Key.DateofSurgery,
                                                                  DD = g.Key.DD,
                                                                  DeptName = g.Key.DeptName,
                                                                  Description = g.Key.Description,
                                                                  DischargeStatus = g.Key.DischargeStatus,
                                                                  Discount = g.Key.Discount,
                                                                  DISDiagnosis = g.Key.DISDiagnosis,
                                                                  DoAdmission = g.Key.DoAdmission,
                                                                  DoDischarge = g.Key.DoDischarge,
                                                                  Due = g.Key.Due,
                                                                  DutyDoctor = g.Key.DutyDoctor,
                                                                  FeeType = g.Key.FeeType,
                                                                  FinalBillID = g.Key.FinalBillID,
                                                                  Imaging = g.Key.Imaging,
                                                                  InsuranceName = g.Key.InsuranceName,
                                                                  IPAdvance = g.Key.IPAdvance,
                                                                  IPNumber = g.Key.IPNumber,
                                                                  ItemAmount = g.Key.ItemAmount,
                                                                  ItemQuantity = g.Key.ItemQuantity,
                                                                  Labs = g.Key.Labs,
                                                                  LengthofStay = g.Key.LengthofStay,
                                                                  MLCNo = g.Key.MLCNo,
                                                                  NetValue = g.Key.NetValue,
                                                                  OrderedDate = g.Key.OrderedDate,
                                                                  Others = g.Key.Others,
                                                                  Packages = g.Key.Packages,
                                                                  PatientID = g.Key.PatientID,
                                                                  PatientName = g.Key.PatientName,
                                                                  PatientNumber = g.Key.PatientNumber,
                                                                  PatientVisitId = g.Key.PatientVisitId,
                                                                  Pharmacy = g.Key.Pharmacy,
                                                                  PhysicianID = g.Key.PhysicianID,
                                                                  PhysicianName = g.Key.PhysicianName,
                                                                  PlaceofDeath = g.Key.PlaceofDeath,
                                                                  POA = g.Key.POA,
                                                                  PreviousDue = g.Key.PreviousDue,
                                                                  Procedures = g.Key.Procedures,
                                                                  Qty = g.Key.Qty,
                                                                  ReceivedAmount = g.Key.ReceivedAmount,
                                                                  ReferredBy = g.Key.ReferredBy,
                                                                  Registrationfees = g.Key.Registrationfees,
                                                                  RoomName = g.Key.RoomName,
                                                                  RoomTypeName = g.Key.RoomTypeName,
                                                                  RowID = g.Key.RowID,
                                                                  RowNUM = g.Key.RowNUM,
                                                                  ServiceCharge = g.Key.ServiceCharge,
                                                                  SpecialityName = g.Key.SpecialityName,
                                                                  SurgeonName = g.Key.SurgeonName,
                                                                  SurgeryAdvance = g.Key.SurgeryAdvance,
                                                                  TaxAmount = g.Key.TaxAmount,
                                                                  TotalAmount = g.Key.TotalAmount,
                                                                  TotalCounts = g.Key.TotalCounts,
                                                                  TypeofAnaesthesia = g.Key.TypeofAnaesthesia,
                                                                  TypeofDeath = g.Key.TypeofDeath,
                                                                  TypeofSurgery = g.Key.TypeofSurgery,
                                                                  VisitDate = g.Key.VisitDate,
                                                                  VisitType = g.Key.VisitType,
                                                              }).Distinct().ToList();

                    lstDWCR = lstDWCR1;                 

                    if (RdoSearchOption.SelectedValue == "0")
                    {
                        trConsultant.Style.Add("display", "none");
                        trSpeciality.Style.Add("display", "block");
                        rptDetails.DataSource = lstSpeciality;
                    }
                    if (RdoSearchOption.SelectedValue == "1")
                    {
                        trConsultant.Style.Add("display", "block");
                        trSpeciality.Style.Add("display", "none");
                        rptDetails.DataSource = TempPhysicians1;
                    }
                    rptDetails.DataBind();
                    lstday = lstDWCR;
                    ViewState["lst"] = lstday;
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt);
                }
                    #endregion
                hdnStats.Value = rblRptType.SelectedValue;
            }
            else
            {
                divPrint.Attributes.Add("style", "none");
                divPrint.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }   
    
    protected void rptDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            Speciality oblSpeciality = (Speciality)e.Item.DataItem;
            GridView gvSummary = (GridView)e.Item.FindControl("gvIPCreditMain");
            Label lblName = (Label)e.Item.FindControl("lblName");
            Label lbl1Total = (Label)e.Item.FindControl("lblTotal");
            Label lblgender = (Label)e.Item.FindControl("lblMale");
            Label lblfemale = (Label)e.Item.FindControl("lblFemale");

            IEnumerable<ListItem> allChecked = (from ListItem item in cblReferingphysician.Items
                                                where item.Selected
                                                select item);
            IEnumerable<ListItem> allward = (from ListItem item in cblWardName.Items
                                             where item.Selected
                                             select item);

            foreach (ListItem item in allChecked)
            {
                lstday.AddRange(lstDWCR.FindAll(p => p.ReferingPhysicianID.ToString() == item.Value));
            }
            foreach (ListItem item in allward)
            {
                lstday.AddRange(lstDWCR.FindAll(p => p.WardID.ToString() == item.Value));
            }
            if (RdoSearchOption.SelectedValue == "1")
            {
                lblName.Text = RdoSearchOption.SelectedItem.Text+" : "+ oblSpeciality.PhysicianName;
                lbl1Total.Text = "Total Patient " + lstDWCR.FindAll(p => p.ConsultantName == oblSpeciality.PhysicianName).Count.ToString();
                lblgender.Text = "No of Male:" + lstDWCR.FindAll(p => p.Age.Contains("M") && p.ConsultantName == oblSpeciality.PhysicianName).Count.ToString();
                lblfemale.Text = "No of Female:" + lstDWCR.FindAll(p => p.Age.Contains("F") && p.ConsultantName == oblSpeciality.PhysicianName).Count.ToString();
                gvSummary.DataSource = lstDWCR.FindAll(p => p.ConsultantName == oblSpeciality.PhysicianName);
                gvSummary.DataBind();
            }
            if (RdoSearchOption.SelectedValue == "0")
            {
                lblName.Text = RdoSearchOption.SelectedItem.Text + " : " + oblSpeciality.SpecialityName;
                lbl1Total.Text ="Total Patient "+ lstDWCR.FindAll(p => p.RowID == oblSpeciality.SpecialityID).Count.ToString();
                lblgender.Text = "No of Male:" + lstDWCR.FindAll(p => p.Age.Contains("M") && p.RowID == oblSpeciality.SpecialityID).Count.ToString();
                lblfemale.Text = "No of Female:" + lstDWCR.FindAll(p => p.Age.Contains("F") && p.RowID == oblSpeciality.SpecialityID).Count.ToString();
                gvSummary.DataSource = lstDWCR.FindAll(p => p.RowID == oblSpeciality.SpecialityID);
                gvSummary.DataBind();
            }           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt.", ex);
        }
    }   
    protected void gvSummary_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (RdoSearchOption.SelectedValue == "1")
        {
            e.Row.Cells[2].Visible = true;
            e.Row.Cells[1].Visible = false;
        }
        if (RdoSearchOption.SelectedValue == "0")
        {
            e.Row.Cells[1].Visible = true;
            e.Row.Cells[2].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Speciality oblSpeciality = (Speciality)e.Row.DataItem;
            Label lblTotal = (Label)e.Row.FindControl("lblTotal");
            Label lblConsultantName = (Label)e.Row.FindControl("lblConsultantName");
            Label lblSpecialityName = (Label)e.Row.FindControl("lblSpecialityName");
           
            if (RdoSearchOption.SelectedValue == "1")
            {               
                //var pTemp = (from c in lstDWCR
                //             where c.RowID == oblSpeciality.SpecialityID
                //             group c by new { c.PatientVisitId } into g
                //             select new
                //             {
                //                 PatientVisitId = g.Key.PatientVisitId,
                //                 LengthofStay = g.Count()
                //             });
                //lblTotal.Text = pTemp.Count().ToString(); //lstDWCR.FindAll(p => p.LengthofStay == oblSpeciality.SpecialityID).Distinct().Count().ToString();

                
                lblTotal.Text = temphy.FindAll(P => P.PhysicianName == oblSpeciality.PhysicianName).Count.ToString();
                lblConsultantName.Text = oblSpeciality.PhysicianName;
                lbltTotal.Text = (Convert.ToInt32(lblTotal.Text) + Convert.ToInt32(lbltTotal.Text)).ToString();
            }
            if (RdoSearchOption.SelectedValue == "0")
            {
                var pTemp = (from c in lstDWCR
                            where c.RowID == oblSpeciality.SpecialityID
                            group c by new { c.PatientVisitId } into g
                            select new { PatientVisitId = g.Key.PatientVisitId,
                                         LengthofStay = g.Count()
                            });

                lblSpecialityName.Text = oblSpeciality.SpecialityName;
                lblTotal.Text = pTemp.Count().ToString(); //lstDWCR.FindAll(p => p.LengthofStay == oblSpeciality.SpecialityID).Distinct().Count().ToString();
                lbltTotal.Text = (Convert.ToInt32(lblTotal.Text) + Convert.ToInt32(lbltTotal.Text)).ToString();

            }
        }
    }
    protected void rptSummary_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            DayWiseCollectionReport dt = (DayWiseCollectionReport)e.Item.DataItem;
            List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
           
            GridView gvSummary = (GridView)e.Item.FindControl("gvSummary");

            Label lblTotal = (Label)e.Item.FindControl("lblTotal");
            
            //gvSummary.DataSource = lstDWCR.FindAll(p => p.VisitDate == dt.VisitDate);
            //gvSummary.DataBind();

            lblTotal.Text = lstDWCR.FindAll(p => p.VisitDate == dt.VisitDate).Sum(p => p.TotalCounts).ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt.", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }    
    private void LoadReferingName(IEnumerable<Speciality> lstSpeciality)
    {
        if (lstSpeciality.Count() > 0)
        {
            cblReferingphysician.DataSource = lstSpeciality;
            cblReferingphysician.DataTextField = "PhysicianName";
            cblReferingphysician.DataValueField = "PhysicianID";
            cblReferingphysician.DataBind();
        }
        else
        {
            tr1.Attributes.Add("Style","Display:none");
        }
    }
    private void LoadWardNme(IEnumerable<WardMaster> lstWard)
    {
        if (lstWard.Count() > 0)
        {
            cblWardName.DataSource = lstWard;
            cblWardName.DataTextField = "WardName";
            cblWardName.DataValueField = "WardID";
            cblWardName.DataBind();
        }
        else
        {
            trward.Attributes.Add("Style", "Display:none");
        }
    }
    private void LoadSpecialityName(IEnumerable<Speciality> lstSpeciality)
    {
        cblSpeciality.DataSource = lstSpeciality;
        cblSpeciality.DataTextField = "SpecialityName";
        cblSpeciality.DataValueField = "SpecialityID";
        cblSpeciality.DataBind();
    }

    private void LoadPhysician(IEnumerable<Speciality> lstPhysician)
    {
        cblConsultingName.DataSource = lstPhysician;
        cblConsultingName.DataTextField = "PhysicianName";
        cblConsultingName.DataValueField = "PhysicianID";
        cblConsultingName.DataBind();
    } 
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "IPDischargeAdmissionReport_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
}
