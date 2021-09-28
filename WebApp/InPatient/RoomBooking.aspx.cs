#region Namespace Decleration
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Reflection;
#endregion

public partial class RoomBooking :BasePage
{
    public RoomBooking()
        : base("InPatient\\RoomBooking.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #region Variable Decleration
    public string pname = string.Empty;
    public string rType = string.Empty;
    protected string sFloorName = string.Empty;
    protected string sRoomName = string.Empty;
    protected string sBedName = string.Empty;
    protected string sPatientName = string.Empty;
    protected string sInnerHTML = string.Empty;
    protected string sFromDate = string.Empty;
    protected string sToDate = string.Empty;
    protected string sFromTime = string.Empty;
    protected string sToTime = "1/1/1900";
    protected string sStatus = string.Empty;
    protected string sDescription = string.Empty;

    protected static int iTempBedID = 0;
    protected int iBookingID = 0;
    protected int iBedID = 0;
    protected int iToBedID = 0;
    protected int iRoomID = 0;
    protected int iToRoomID = 0;
    protected int i = 0;
    protected int j = 0;

    protected long lresult = -1;

    List<FloorMaster> lstFloor = new List<FloorMaster>();
    List<RoomBookingDetails> lstRoomDetails = new List<RoomBookingDetails>();
    List<RoomBookingDetails> lstRoomAvailabilityStatus = new List<RoomBookingDetails>();
    List<RoomBookingDetails> lstNowObtainedRooms = new List<RoomBookingDetails>();
    List<RoomBookingDetails> lstNowObtainedBeds = new List<RoomBookingDetails>();
    List<BedMaster> lstBed = new List<BedMaster>();
    RoomBooking_BL objRoomBookingBLL;
    BedBookingDetails objbedbooking = new BedBookingDetails();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL objPhysicianBll ;
    InPatientLocationTransferDetails objLocationtransfer = new InPatientLocationTransferDetails();
    Patient_BL objPatientBL ;
    List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
    Patient_BL patientBL ;
    List<Patient> lstPatient = new List<Patient>();

   // IEnumerable<string> lstPatient;

    long patientID = -1;
    long patientVisitID = -1;
    string patientName = string.Empty;
    string vType = string.Empty;
    public enum Filters { Floor, Type, Status }; 
    #endregion

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        objRoomBookingBLL = new RoomBooking_BL(base.ContextInfo);
        objPhysicianBll = new Physician_BL(base.ContextInfo);
        objPatientBL = new Patient_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);
        //   iOrganisationID = 1;
        if (!IsPostBack)
        {
            if (Request.QueryString["PRINT"] == "Y")
            {
                //label printing for patient admission detail 
                string strConfigKey = "LabelPrintingAD";
                string configValue = GetConfigValue(strConfigKey, OrgID);

                if (configValue == "Y")
                {
                    this.Page.RegisterStartupScript("strPrint", "<script type='text/javascript'> Labelprint(); </script>");

                }
                else
                {
                    this.Page.RegisterStartupScript("strPrint", "<script type='text/javascript'> popupprint(); </script>");
                }


            }
          
        }

        if (Request.QueryString["IsOT"] != null)
        {
            rType = Request.QueryString["IsOT"].ToString();
        }

        if (Request.QueryString["PNAME"] != null)
        {
            lblPatientName.Text = Request.QueryString["PNAME"].ToString();
            patientName = Request.QueryString["PNAME"].ToString();
        }
        if (Request.QueryString["PID"] != null)
        {
            patientID = Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        if (Request.QueryString["VID"] != null)
        {
            patientVisitID = Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["vType"] != null)
        {
            vType = Request.QueryString["vType"].ToString();
        }
        if (Request.QueryString["IsCB"] != null)
        {
            hdnIsCreditBill.Value = Request.QueryString["IsCB"].ToString();
        }
        else
        {
            if (patientID > 0)
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);
                if (lstPatientVisit.Count > 0)
                {
                    if (lstPatientVisit[0].ClientMappingDetailsID > 0)
                    {
                        hdnIsCreditBill.Value = "Y";
                    }
                }
            }
        }
        if ((!IsPostBack) && (i == 0))
        {
            txtDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
           // ShowList();
            LoadPhysicians();
            getFilters();
            getPatientAdmissionDateTime();
            i++;
           
        }
         hdnCurrentPatientBookedStatus.Value = RoomsView.ColoredPatient;
        AutoCompleteConsultant.ContextKey = Convert.ToString(OrgID);
        AutoCompletePatient.ContextKey = Convert.ToString(OrgID);
    }
    #endregion

    #region Cancel Event
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            BindDatas("Cancelled");
            lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking,LID);
            Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    #endregion

    #region Search for Datas
     
    public void ShowList()
    {
        //divFloorDetails.Controls.Clear();
        sFromDate = "";
        lresult = objRoomBookingBLL.GetRoomBook(OrgID, ILocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), rType, out lstFloor, out lstBed,
                                                out lstRoomDetails);
       

        RoomsView.ExPatientID = patientID;
        RoomsView.LstRoomDisplay = lstRoomDetails;
        RoomsView.LstFloor = lstFloor;
        RoomsView.bindData();
        
        List<RoomBookingDetails> RoomsForPerson = null;
        foreach (RoomBookingDetails liroom in lstRoomDetails)
        {
            RoomsForPerson = (from bed in lstRoomDetails
                             where ( bed.PatientStatus == "" 
                                         || bed.PatientStatus == "Cancelled" 
                                         || bed.PatientStatus == "Discharged" 
                                         || bed.PatientStatus == "Transfered" )
                             select bed).ToList();
        }

        dlRoomsMaster.DataSource = RoomsForPerson;
        dlRoomsMaster.DataBind();
        bindTransferData(RoomsForPerson);
        
    }
    #endregion

    #region Book Room
    protected void btnBook_Click(object sender, EventArgs e)
    {
        try
        {
                BindDatas("Booked");
                hdnBookingID.Value = "0";
                List<IPTreatmentPlanDetails> lstTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
                List<IPTreatmentPlanDetails> lstReportTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
                IP_BL objBl = new IP_BL(base.ContextInfo);
                patientBL.GetPatientDemoandAddress(patientID, out lstPatient);
                if (lstPatient.Count > 0)
                {
                    lblNameValue.Text = lstPatient[0].Name;
                    lblAgeOrSexValue.Text = lstPatient[0].Age + "/" + lstPatient[0].SEX;
                    lblPnovalue.Text = lstPatient[0].PatientNumber;
                    lbladdressvalue.Text = lstPatient[0].PatientAddress[0].Add1;
                    lblcontactNovalue.Text = lstPatient[0].PatientAddress[0].MobileNumber;


                }
        
                objBl.GetIPTreatmentPlanDetails(patientID, out lstTreatmentPlanDetails, out lstReportTreatmentPlanDetails);
                if (lstTreatmentPlanDetails.Count() > 0)
                {
                    grdTreatementPlan.DataSource = lstTreatmentPlanDetails;
                    grdTreatementPlan.DataBind();
                }
                if (hdnIsOkClicked.Value == "N" && hdnIsSlotBooking.Value=="Y" )
                {
                    //long s = Convert.ToInt64(hdnTreatmentPlanID.Value);
                    ModalPopupExtender1.Show();
                    ShowBookedDetails(objbedbooking.BedID);
                }
                if (hdnIsOkClicked.Value == "Y" && hdnIsSlotBooking.Value == "Y")
                {
                    //long s = Convert.ToInt64(hdnTreatmentPlanID.Value);
                    lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
                    ShowBookedDetails(objbedbooking.BedID);
                }
                if (hdnIsOkClicked.Value == "N" && hdnIsSlotBooking.Value == "N")
                {
                    //long s = Convert.ToInt64(hdnTreatmentPlanID.Value.ToString());

                    lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
                }
                ClearAllDatas();
                ShowList();
                //btnSearch_Click(sender, e);
                //Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
                //btnRefresh1_Click(sender, (ImageClickEventArgs)e);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    #endregion 

    #region Occupy Room
    protected void btnOccupy_Click(object sender, EventArgs e)
    {
        BindDatas("Occupied");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        ShowList();
        //btnSearch_Click(sender, e);
        //btnRefresh1_Click(sender, (ImageClickEventArgs)e);
        //Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
    }
    #endregion

    #region Discharge Patient
    protected void btnDischarge_Click(object sender, EventArgs e)
    {
        BindDatas("Discharged");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        ShowList();
        //btnSearch_Click(sender, e);
        //Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
    }
    #endregion

    #region Transfer
    protected void btnTransfer_Click(object sender, EventArgs e)
    {
        //hdnBookingID
        //hdnFromBedID
        //hdnToBedID
        //hdnFromPatientID
        sToDate = sToDate == "" ? "01/01/1900" : sToDate;

        if (Request.QueryString["PNAME"] != null)
        {
            pname = Request.QueryString["PNAME"].ToString();
        }

        if (Convert.ToInt64(Request.QueryString["PID"].ToString()) != Convert.ToInt64(hdnFromPatientID.Value))
        {
            pname = hdnFromPatientName.Value;
        }

        if (chkRetainExistingRoom.Checked != true)
        {
            BindDatas("Transfered");
            lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        }
        //hdnBookingID.Value = "0";
        BindDatas("Occupied");
        //lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking);

        
        //sDescription = txtDescription.Text;
        lresult = objRoomBookingBLL.SaveRoomTransferDetails(objLocationtransfer, pname, 
                        sDescription, Convert.ToDateTime(sToDate));
        ClearAllDatas();
        ShowList();
        //btnSearch_Click(sender, e);
        //Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
    }
    #endregion

    #region Cancel Booking
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        BindDatas("Cancelled");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        ShowList();
        //btnSearch_Click(sender, e);
        //btnRefresh1_Click(sender, (ImageClickEventArgs)e);
        //Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
    }
    #endregion

    #region Schedules
    protected void btnSchedules_Click1(object sender, EventArgs e)
    {
       // BindDatas("");
        lresult = objRoomBookingBLL.GetRoomsListSchedule(objbedbooking.OrgAddID, out lstRoomAvailabilityStatus,sFromDate,sToDate,objbedbooking.BedID);
     //   gdvRoomsAvailability.DataSource = lstRoomAvailabilityStatus;
       // gdvRoomsAvailability.DataBind();
        this.programmaticModalPopup1.Show();
    }
    #endregion

    #region Custom Functions

    #region BindDatas
    protected void BindDatas(string sStatusMessage)
    {

        int visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt32(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }

        sPatientName = lblPatientName.Text.Trim();
        sDescription = txtDescription.Text.Trim();

        if (hdnFromPatientName.Value.Trim() != ""
                                            && Convert.ToInt64(Request.QueryString["PID"].ToString()) != Convert.ToInt64(hdnFromPatientID.Value) && sStatusMessage!="Booked")
        {
            visitID = int.Parse(hdnFromVisitID.Value);
            patientID = long.Parse(hdnFromPatientID.Value);
            sPatientName = hdnFromPatientName.Value;
        }
        //sFromTime = ddlfromtime.SelectedItem.Text.Trim();
        //sToTime = ddltotime.SelectedItem.Text.Trim();
        DateTime s1FromDate =Convert.ToDateTime(txtDate.Text);
        //sFromDate = txtFrom.Text.Trim() + ' ' + sFromTime;
        sFromDate = Convert.ToString(s1FromDate); 
        //sToDate = txtTo.Text.Trim() + ' ' + sToTime;
        sStatus = sStatusMessage;
       
        if (hdnFromBedID.Value != null)
        {
            iBedID = Convert.ToInt32(hdnFromBedID.Value.ToString());
        }

        if (hdnToBedID.Value != null)
        {
            iToBedID = Convert.ToInt32(hdnToBedID.Value.ToString());
        }
        if (hdnBookingID.Value != null)
        {
            iBookingID = Convert.ToInt32(hdnBookingID.Value.ToString());
        }

        if (iBookingID == 0)
        {
            objbedbooking.BedID = iToBedID;
        }
        else
        {
            objbedbooking.BedID = iBedID;
        }
        objbedbooking.BookingID = iBookingID;
        objbedbooking.VisitID = visitID;
        objbedbooking.PatientID = patientID;
        objbedbooking.OrgAddID = ILocationID;
        objbedbooking.OrgID = OrgID;
        objbedbooking.FromDate = sFromDate;
        objbedbooking.ToDate = sToDate;
        objbedbooking.TreatmentPlanID = int.Parse(hdnTreatmentPlanID.Value.ToString());
        if (sStatusMessage == "Discharged" || sStatusMessage == "Transfered")
        {
            objbedbooking.ToDate = sFromDate;
        }
        if (sStatusMessage == "Booked" && hdnIsSlotBooking.Value=="Y")
        {
            objbedbooking.FromDate = txtFrom.Text;
            objbedbooking.ToDate = txtTo.Text;
        }
        objbedbooking.Status = sStatus;
        objbedbooking.PatientName = sPatientName;
        objbedbooking.Description = sDescription;
        //During Room Transfer
        objLocationtransfer.AttendeesAccompanying1 = txtAttendees1.Text;
        objLocationtransfer.VisitID = visitID;
        objLocationtransfer.PatientID = Convert.ToInt32(patientID);
        objLocationtransfer.AttendeesAccompanying1Phone = txtAttendees1Phone.Text;
        objLocationtransfer.AttendeesAccompanying2 = txtAttendees2.Text;
        objLocationtransfer.AttendeesAccompanying2Phone = txtAttendees2Phone.Text;
        objLocationtransfer.ConditionOnTransfer = ddlConditionOnTransfer.SelectedValue.ToString();
        objLocationtransfer.FromBedID = iBedID;
        objLocationtransfer.ToBedID = iToBedID;
        objLocationtransfer.ReasonForTransfer = txtReasonForTransfer.Text;
        objLocationtransfer.TransferInitiatedType = ddlTransferRequestedBy.SelectedItem.Text.Trim();
        objLocationtransfer.TransferLocationID = ILocationID; //If we need to modify any transfer we need to specify transferlocatioid 
        if (objLocationtransfer.TransferInitiatedType == "Doctor")
        {
            objLocationtransfer.TransferInitiatedBy = ddlPhysician.SelectedValue.ToString();
        }
        else
        {
            objLocationtransfer.TransferInitiatedBy = txtAttendant.Text;
        }
        objLocationtransfer.CreatedBy =Convert.ToInt32(LID); //User ID Comes Here
        objLocationtransfer.TransferPerformedBy = Convert.ToInt32(LID); // User ID Comes Here
        objLocationtransfer.OrgID = OrgID;
        objLocationtransfer.DateOfTransfer = Convert.ToDateTime(sFromDate);// +"/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString() + " " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Hour.ToString() + ":" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Minute.ToString() + ":" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Second.ToString();

    }
    #endregion
 
    #region Load From Time
    //public void loadToTime()
    //{
    //    DateTime dt = Convert.ToDateTime("12:00 am");
    //    DateTime time = DateTime.MinValue;
    //    DateTime value = DateTime.MinValue;
    //    for (int i = 0; i < 48; i++)
    //    {
    //        ddlfromtime.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
    //        dt = dt.AddMinutes(30);
    //    }
    //}
    #endregion

    #region Clear all Datas from Hidden Variables
    protected void ClearAllDatas()
    {
        hdnFromBedID.Value = "0";
        hdnToBedID.Value = "0";
        hdnBookingID.Value = "0";
        txtAttendant.Text = "";
        txtAttendees1.Text = "";
        txtAttendees1Phone.Text = "";
        txtAttendees2.Text = "";
        txtAttendees2Phone.Text = "";
        txtDescription.Text = "";
        txtReasonForTransfer.Text = "";
        hdnFromPatientID.Value = "0";
        hdnTransfer.Value = "0";
        ddlTransferRequestedBy.SelectedIndex = 0;
        //   hdnFromFloorID.Value = "0";
        //   hdnToFloorID.Value = "0";
        //   hdnFromRoomID.Value = "0";
        //   hdnToRoomID.Value = "0";
        hdnFromPatientName.Value = "";
        hdnFromVisitID.Value = "0";
        hdnFilterPhysicianID.Value = "0";
        hdnFilterPatientID.Value="0";
    }
    #endregion

    #region LoadAllPhysicians
    protected void LoadPhysicians()
    {
        objPhysicianBll.GetPhysicianListByOrg(OrgID,out lstPhysician,0);
        if (lstPhysician.Count > 0)
        {
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
        }
    }
    #endregion

    #region LoadAllPatientConditions
    protected void LoadPatientCondition()
    {
        lstPatientCondition = new List<PatientCondition>();
        objPatientBL.getPatientCondition(out lstPatientCondition);
        if (lstPatientCondition.Count > 0)
        {
            ddlConditionOnTransfer.DataSource = lstPatientCondition;
            ddlConditionOnTransfer.DataTextField = "Condition";
            ddlConditionOnTransfer.DataValueField = "ConditionID";
            ddlConditionOnTransfer.DataBind();
        }
    }
    #endregion

    #region BindTransferData
    private void bindTransferData(List<RoomBookingDetails> lstRoomData)
    {
        int ival = 0;
        foreach (DataListItem itm in dlRoomsMaster.Items)
        {
            HtmlInputRadioButton btn = new HtmlInputRadioButton();
            btn = (HtmlInputRadioButton)itm.FindControl("chkBedID");
            string sVal ="";
            sVal = "getValuesTo('" + lstRoomData[ival].BedID + "','" + btn.ClientID + "');";
            btn.Attributes.Add("onfocus", sVal);
            ival++;
        }
    }
    #endregion

    #endregion

    #region Refresh Page
    protected void btnRefresh1_Click(object sender, EventArgs e)
    {
        try
        {
            if (patientID > 0 && patientVisitID > 0)
                Response.Redirect("RoomBooking.aspx?PID=" + patientID + "&VID=" + patientVisitID + "&PNAME=" + patientName + "&vType=" + vType, true);
            else
                Response.Redirect("RoomBooking.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Doctor schedule", ex);
        }
    }
    #endregion

    #region Getting Filter DropDown DataSource
    public void getFilters()
    {
        lresult = objRoomBookingBLL.GetRoomBook(OrgID, ILocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), rType, out lstFloor, out lstBed,
                                              out lstRoomDetails);
        RoomsView.LstRoomDisplay = lstRoomDetails;
        RoomsView.LstFloor = lstFloor;

        lstRoomDetails = RoomsView.LstRoomDisplay;
        lstFloor = RoomsView.LstFloor;

        var lstFloors = (from floor in lstFloor
                         select new { floor.FloorID, floor.FloorName }).Distinct();
        bindDataSource(ddlFloor, lstFloors.ToList(), Filters.Floor);

        var lstType = (from type in lstRoomDetails
                       select new { type.RoomTypeID, type.RoomTypeName }).Distinct();
        bindDataSource(ddlRoomType, lstType.ToList(), Filters.Type);

        var lstStatus = (from status in lstRoomDetails
                         select new { status.PatientStatus }).Distinct();
        bindDataSource(ddlStatus, lstStatus.ToList(), Filters.Status);
    }
    #endregion

    protected void ddlFloor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFloor.SelectedIndex > 0)
        {

            long returnCode = -1;
            List<RoomDetails> lstWardDetails = new List<RoomDetails>();
            returnCode = new RoomBooking_BL().LoadRoomMasterDetails("WARD", OrgID, 1, Convert.ToInt32(ddlFloor.SelectedValue), out lstWardDetails);
            ddlWard.DataSource = lstWardDetails;
            ddlWard.DataValueField = "ID";
            ddlWard.DataTextField = "Name";
            ddlWard.DataBind();
            ddlWard.Items.Insert(0, "--All Wards--");
        }
    }

    #region Binding Filter DropDown DataSource
    protected void bindDataSource<T>(DropDownList ddl, IList<T> lstSource, Filters sender)
    {
        switch (sender)
        {
            case Filters.Floor:
                ddl.DataSource = lstSource;
                ddl.DataTextField = "FloorName";
                ddl.DataValueField = "FloorID";
                ddl.DataBind();
                ddl.Items.Insert(0, "--All Floor--");
                break;

            case Filters.Type:
                ddl.DataSource = lstSource;
                ddl.DataTextField = "RoomTypeName";
                ddl.DataValueField = "RoomTypeID";
                ddl.DataBind();
                ddl.Items.Insert(0, "--All RoomType--");
                break;

            case Filters.Status:
                ddl.DataSource = lstSource;
                ddl.DataTextField = "PatientStatus";
                ddl.DataValueField = "PatientStatus";
                ddl.DataBind();
                ddl.Items.Insert(0, "--All Status--");
                ddl.Items.Remove("");
                ddl.Items.Add(new ListItem("Available",""));
                break;

        }

    }
    #endregion

    #region Trigger Filter
    protected void btnFilter_Click(object sender, EventArgs e)
    {
        filterBinding();
    }
        
    protected void filterBinding()
    {

        lresult = objRoomBookingBLL.GetRoomBook(OrgID, ILocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), rType, out lstFloor, out lstBed,
                                              out lstRoomDetails);
        
        if (ddlFloor.Text != "--All Floor--")
        {
            List<FloorMaster> lstTempFloor = lstFloor.Where(f => f.FloorID.ToString() == (ddlFloor.SelectedValue ?? f.FloorID.ToString())).ToList<FloorMaster>();//?? f.FloorID.ToString())
            lstFloor = lstTempFloor.ToList<FloorMaster>();
        }

        if (ddlRoomType.Text != "--All RoomType--")
        {
            List<RoomBookingDetails> lstTempType = lstRoomDetails.Where(t => t.RoomTypeID.ToString() == (ddlRoomType.SelectedValue ?? t.RoomTypeID.ToString())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempType.ToList<RoomBookingDetails>();
        }

        if (ddlStatus.Text != "--All Status--")
        {
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.Where(s => s.PatientStatus == (ddlStatus.SelectedValue ?? s.PatientStatus)).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        if (ddlWard.Text != "--All Wards--")
        {
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.Where(s => s.WardID.ToString() == (ddlWard.SelectedValue ?? s.WardID.ToString())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        if (txtPatient.Text != "" && hdnFilterPatientID.Value != "0")
        {
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.Where(s => s.PatientID.ToString() == (hdnFilterPatientID.Value ?? s.PatientID.ToString())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        if (txtConsultant.Text != "" && hdnFilterPhysicianID.Value != "0")
        {
            //List<RoomBookingDetails> lstTempStatus = lstRoomDetails.FindAll(s => s.PrimaryConsultant.Split('^').Select(a => a.Split('~')[0].Trim()) == (hdnFilterPhysicianID.Value.Trim() ?? s.PrimaryConsultant.Split('~')[0].Trim())).ToList<RoomBookingDetails>();
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.FindAll(s => s.PrimaryConsultant !=null && s.PrimaryConsultant.Split('^').Select(a => a.Split('~')[0].Trim()).Contains(hdnFilterPhysicianID.Value.Trim())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        RoomsView.LstRoomDisplay = lstRoomDetails;
        RoomsView.LstFloor = lstFloor;
        RoomsView.bindData();

        List<RoomBookingDetails> RoomsForPerson = null;
        foreach (RoomBookingDetails liroom in lstRoomDetails)
        {
            RoomsForPerson = (from bed in lstRoomDetails
                              where (bed.PatientStatus == ""
                                          || bed.PatientStatus == "Cancelled"
                                          || bed.PatientStatus == "Discharged"
                                          || bed.PatientStatus == "Transfered")
                              select bed).ToList();
        }

        dlRoomsMaster.DataSource = RoomsForPerson;
        dlRoomsMaster.DataBind();
        bindTransferData(RoomsForPerson);
    }
    #endregion

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
    public void getPatientAdmissionDateTime()
    {
        IP_BL IPBL = new IP_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        IPBL.GetIPVisitDetails(patientVisitID, out lstPatientVisit);
        if (lstPatientVisit.Count > 0)
        {
           hdnAdmissionDate.Value = lstPatientVisit[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
        }

    }
    public void ShowBookedDetails(int BedID)
    {
        List<RoomBookingDetails> BedBookingDatas = new List<RoomBookingDetails>();
        lresult = objRoomBookingBLL.GetBookingDetails(OrgID,ILocationID,BedID, out BedBookingDatas);
        grdBookingDetails.DataSource = BedBookingDatas;
        grdBookingDetails.DataBind();
        ModalPopupExtender1.Show();
    }

    protected void grdBookingDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblStatuse =(Label) e.Row.FindControl("lblStatuse");
                Button btnVacate =(Button) e.Row.FindControl("btnVacate");
                Button btnOccupy =(Button) e.Row.FindControl("btnOccupy");
                Button btnCancel =(Button) e.Row.FindControl("btnCancel");
                if (lblStatuse.Text == "Booked")
                {
                    btnVacate.Enabled = false;
                    btnOccupy.Enabled = true;
                    btnCancel.Enabled = true;
                }
                else if (lblStatuse.Text == "Occupied")
                {
                    btnVacate.Enabled = true;
                    btnOccupy.Enabled = false;
                    btnCancel.Enabled = false;
                }
                string strScript = "BedSelect('" + ((RadioButton)e.Row.FindControl("rdosel")).ClientID + "');";
                ((RadioButton)e.Row.FindControl("rdosel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((RadioButton)e.Row.FindControl("rdosel")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading BookingDetails.", Ex);
        }
    }
    protected void grdBookingDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string tempstatus = string.Empty;
            int IPTreatmentPlanID = 0;
            if (hdnTreatmentPlanID.Value != "" && hdnTreatmentPlanID.Value != null)
            {
                IPTreatmentPlanID = Convert.ToInt32(hdnTreatmentPlanID.Value);
            }
            if (Request.QueryString["VID"] != null)
            {
                patientVisitID = Convert.ToInt64(Request.QueryString["VID"].ToString());
            }
            HiddenField hdnBookingID = new HiddenField();
                if (e.CommandName == "Vacate")
                {
                    int RowIndex = Convert.ToInt32(e.CommandArgument);
                    hdnBookingID = (HiddenField)grdBookingDetails.Rows[RowIndex].FindControl("hdnBookingID");
                    tempstatus = "Discharged";

                }
                if (e.CommandName == "Occupy")
                {
                    int RowIndex = Convert.ToInt32(e.CommandArgument);
                    hdnBookingID = (HiddenField)grdBookingDetails.Rows[RowIndex].FindControl("hdnBookingID");
                    tempstatus = "Occupied";
                }
                if (e.CommandName == "Cancel")
                {
                    int RowIndex = Convert.ToInt32(e.CommandArgument);
                    hdnBookingID = (HiddenField)grdBookingDetails.Rows[RowIndex].FindControl("hdnBookingID");
                    tempstatus = "Cancelled";
                }
                lresult = objRoomBookingBLL.UpdateBookedDetails(OrgID, ILocationID, Convert.ToInt64(hdnBookingID.Value), tempstatus, IPTreatmentPlanID, patientVisitID,LID);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while grdBookingDetails_RowCommand", ex);
        }
    }
    protected void grdTreatementPlan_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        { 
            

              if (e.Row.RowType == DataControlRowType.DataRow)
            
             {
              IPTreatmentPlanDetails IP  = (IPTreatmentPlanDetails)e.Row.DataItem;
             string strScript = "INVRowCommon('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID +"','"+IP.TreatmentPlanID+"');";
            ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onclick", strScript); 
           }

        }
        catch (Exception ex)
        {
        }
    }
}