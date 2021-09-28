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

public partial class InPatient_RoomAndBedBooking : BasePage
{
    public InPatient_RoomAndBedBooking()
        : base("InPatient\\RoomAndBedBooking.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #region DataTypes
    public string pname = string.Empty;
    public string rType = string.Empty;
    protected string sPatientName = string.Empty;
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

    List<RoomBookingDetails> lstRoomDetails = new List<RoomBookingDetails>();
    List<RoomBookingDetails> lstRoomAvailabilityStatus = new List<RoomBookingDetails>();
    RoomBooking_BL objRoomBookingBLL;
    BedBookingDetails objbedbooking = new BedBookingDetails();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL objPhysicianBll;
    InPatientLocationTransferDetails objLocationtransfer = new InPatientLocationTransferDetails();

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

        if (!IsPostBack)
        {
            LoadDropDown();


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


        if ((!IsPostBack) && (i == 0))
        {
            txtDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            LoadPhysicians();
            getPatientAdmissionDateTime();
            i++;

        }
        hdnCurrentPatientBookedStatus.Value = RoomsView.ColoredPatient;
        AutoCompleteConsultant.ContextKey = Convert.ToString(OrgID);
        AutoCompletePatient.ContextKey = Convert.ToString(OrgID);


    }
    #endregion

    #region LoadDropDown
    protected void LoadDropDown()
    {
        long returnCode = 0;

        List<RoomDetails> lstRoomMaster = new List<RoomDetails>();
        List<RoomBookingDetails> lstOutRoomDetails = new List<RoomBookingDetails>();
        returnCode = new RoomBooking_BL(base.ContextInfo).GetRoomMaster(OrgID, ILocationID, out lstRoomMaster, out lstOutRoomDetails);

        var lstFloors = (from floor in lstRoomMaster
                         where floor.RoomTypeName == "BUILDING"
                         select new { floor.ID, floor.Name }).Distinct();

        ddlFloor.DataSource = lstFloors;
        ddlFloor.DataTextField = "Name";
        ddlFloor.DataValueField = "ID";
        ddlFloor.DataBind();
        ddlFloor.Items.Insert(0, "--All Floor--");
        //RoomsView.LstFloor = lstFloors;

        var lstRoomType = (from type in lstRoomMaster
                           where type.RoomTypeName == "ROOM_TYPE"
                           select new { type.ID, type.Name }).Distinct();

        ddlRoomType.DataSource = lstRoomType;
        ddlRoomType.DataTextField = "Name";
        ddlRoomType.DataValueField = "ID";
        ddlRoomType.DataBind();
        ddlRoomType.Items.Insert(0, "--All RoomType--");


        var lstRoomWard = (from Ward in lstRoomMaster
                           where Ward.RoomTypeName == "WARD"
                           select new { Ward.ID, Ward.Name }).Distinct();

        ddlWard.DataSource = lstRoomWard;
        ddlWard.DataTextField = "Name";
        ddlWard.DataValueField = "ID";
        ddlWard.DataBind();
        ddlWard.Items.Insert(0, "--All Wards--");


        //var lstRoomStatus = (from Status in lstRoomMaster
        //                     where Status.RoomTypeName == "STATUS"
        //                     select new { Status.ID, Status.Name }).Distinct();



        //ddlStatus.DataSource = lstRoomStatus;
        //ddlStatus.DataTextField = "Name";
        //ddlStatus.DataValueField = "Name";
        //ddlStatus.DataBind();
        ddlStatus.Items.Insert(0, "--All Status--");
        ddlStatus.Items.Insert(1, "Booked");
        ddlStatus.Items.Insert(2, "Occupied");

        RoomsView.loadRooms(lstOutRoomDetails);

        if (Request.QueryString["VID"] != null)
        {
            patientVisitID = Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long retval = -1;
        VisitClientMapping PDetails = new VisitClientMapping();
        PatientVisit_BL VisitDetailsBL = new PatientVisit_BL(base.ContextInfo);
        List<VisitClientMapping> lstVisitClient = new List<VisitClientMapping>();

        retval = VisitDetailsBL.GetVisitClientMappingDetails(OrgID, patientVisitID, out lstVisitClient);

        ddlClient.Items.Clear();
        if (retval == 0)
        {
            ddlClient.DataSource = lstVisitClient;
            ddlClient.DataTextField = "ClientName";
            ddlClient.DataValueField = "ClientID";
            ddlClient.DataBind();
        }
        ddlClient.Items.Insert(0, new ListItem("--Select--", "0"));

        if (lstVisitClient.Count > 0)
        {
            hdnClientID.Value = lstVisitClient[0].ClientID.ToString();
            hdnClientCount.Value = lstVisitClient.Count.ToString();
        }

    }
    #endregion

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        filterBinding();
    }

    #region filterBinding()
    protected void filterBinding()
    {
        List<RoomBookingDetails> lstRoomDetails = new List<RoomBookingDetails>();
        List<RoomBookingDetails> lstOutRoomDetails = new List<RoomBookingDetails>();
        int BulidingID = 0;
        int RoomtypeId = 0;
        int WardID = 0;
        string Status = String.Empty;
        long lresult = 0;

        BulidingID = ddlFloor.SelectedIndex > 0 ? Convert.ToInt32(ddlFloor.SelectedValue) : 0;
        RoomtypeId = ddlRoomType.SelectedIndex > 0 ? Convert.ToInt32(ddlRoomType.SelectedValue) : 0;
        WardID = ddlWard.SelectedIndex > 0 ? Convert.ToInt32(ddlWard.SelectedValue) : 0;
        Status = ddlStatus.SelectedIndex > 0 ? ddlStatus.SelectedItem.Text : "";

        lresult = new RoomBooking_BL(base.ContextInfo).GetRoomBookings(OrgID, ILocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString(), rType, BulidingID,
            RoomtypeId, WardID, Status, out lstRoomDetails, out lstOutRoomDetails);

        RoomsView.loadRooms(lstOutRoomDetails);

        if (txtPatient.Text != "" && hdnFilterPatientID.Value != "0")
        {
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.Where(s => s.PatientID.ToString() == (hdnFilterPatientID.Value ?? s.PatientID.ToString())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        if (txtConsultant.Text != "" && hdnFilterPhysicianID.Value != "0")
        {
            List<RoomBookingDetails> lstTempStatus = lstRoomDetails.FindAll(s => s.PrimaryConsultant != null && s.PrimaryConsultant.Split('^').Select(a => a.Split('~')[0].Trim()).Contains(hdnFilterPhysicianID.Value.Trim())).ToList<RoomBookingDetails>();
            lstRoomDetails = lstTempStatus.ToList<RoomBookingDetails>();
        }

        RoomsView.LstRoomDisplay = lstRoomDetails;
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

    #region LoadAllPhysicians
    protected void LoadPhysicians()
    {
        Physician_BL objPhysicianBll = new Physician_BL(base.ContextInfo);
        objPhysicianBll.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
        if (lstPhysician.Count > 0)
        {
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
        }
    }
    #endregion
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

    #region Book Room
    protected void btnBook_Click(object sender, EventArgs e)
    {
        BindDatas("Booked");
        hdnBookingID.Value = "0";

        List<IPTreatmentPlanDetails> lstTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
        List<IPTreatmentPlanDetails> lstReportTreatmentPlanDetails = new List<IPTreatmentPlanDetails>();
        IP_BL objBl = new IP_BL(base.ContextInfo);
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);

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
        if (hdnIsOkClicked.Value == "N" && hdnIsSlotBooking.Value == "Y")
        {
            ModalPopupExtender1.Show();
            ShowBookedDetails(objbedbooking.BedID);
        }
        if (hdnIsOkClicked.Value == "Y" && hdnIsSlotBooking.Value == "Y")
        {
            lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
            ShowBookedDetails(objbedbooking.BedID);
            filterBinding();
        }
        if (hdnIsOkClicked.Value == "N" && hdnIsSlotBooking.Value == "N")
        {
            lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
            ClearAllDatas();
            filterBinding();
        }

    }
    #endregion

    #region Occupy Room
    protected void btnOccupy_Click(object sender, EventArgs e)
    {
        BindDatas("Occupied");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        filterBinding();
    }
    #endregion

    #region Discharge Patient
    protected void btnDischarge_Click(object sender, EventArgs e)
    {
        BindDatas("Discharged");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        filterBinding();
    }
    #endregion

    #region Transfer
    protected void btnTransfer_Click(object sender, EventArgs e)
    {
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
        BindDatas("Occupied");
        lresult = objRoomBookingBLL.SaveRoomTransferDetails(objLocationtransfer, pname,
                        sDescription, Convert.ToDateTime(sToDate));
        ClearAllDatas();
        filterBinding();
    }
    #endregion

    #region Cancel Booking
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        BindDatas("Cancelled");
        lresult = objRoomBookingBLL.SaveBedbooking(objbedbooking, LID);
        ClearAllDatas();
        filterBinding();
    }
    #endregion

    #region Schedules
    protected void btnSchedules_Click1(object sender, EventArgs e)
    {
        lresult = objRoomBookingBLL.GetRoomsListSchedule(objbedbooking.OrgAddID, out lstRoomAvailabilityStatus, sFromDate, sToDate, objbedbooking.BedID);
        this.programmaticModalPopup1.Show();
    }
    #endregion

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
                                            && Convert.ToInt64(Request.QueryString["PID"].ToString()) != Convert.ToInt64(hdnFromPatientID.Value) && sStatusMessage != "Booked")
        {
            visitID = int.Parse(hdnFromVisitID.Value);
            patientID = long.Parse(hdnFromPatientID.Value);
            sPatientName = hdnFromPatientName.Value;
        }
        DateTime s1FromDate = Convert.ToDateTime(txtDate.Text);
        sFromDate = Convert.ToString(s1FromDate);
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
        objbedbooking.ClientID = long.Parse(hdnClientID.Value.ToString());

        if (sStatusMessage == "Discharged" || sStatusMessage == "Transfered")
        {
            objbedbooking.ToDate = sFromDate;
        }
        if (sStatusMessage == "Booked" && hdnIsSlotBooking.Value == "Y")
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
        objLocationtransfer.TransferLocationID = ILocationID;        
        if (objLocationtransfer.TransferInitiatedType == "Doctor")
        {
            objLocationtransfer.TransferInitiatedBy = ddlPhysician.SelectedValue.ToString();
        }
        else
        {
            objLocationtransfer.TransferInitiatedBy = txtAttendant.Text;
        }
        objLocationtransfer.CreatedBy = Convert.ToInt32(LID); //User ID Comes Here
        objLocationtransfer.TransferPerformedBy = Convert.ToInt32(LID); // User ID Comes Here
        objLocationtransfer.OrgID = OrgID;
        objLocationtransfer.DateOfTransfer = Convert.ToDateTime(sFromDate);// +"/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString() + " " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Hour.ToString() + ":" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Minute.ToString() + ":" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Second.ToString();

    }
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
        hdnFromPatientName.Value = "";
        hdnFromVisitID.Value = "0";
        hdnFilterPhysicianID.Value = "0";
        hdnFilterPatientID.Value = "0";
        hdnClientID.Value = "0";
    }
    #endregion

    #region LoadAllPatientConditions
    protected void LoadPatientCondition()
    {
        List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
        new Patient_BL(base.ContextInfo).getPatientCondition(out lstPatientCondition);
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
            string sVal = "";
            sVal = "getValuesTo('" + lstRoomData[ival].BedID + "','" + btn.ClientID + "');";
            btn.Attributes.Add("onfocus", sVal);
            ival++;
        }
    }
    #endregion

    #region ShowBookedDetails
    public void ShowBookedDetails(int BedID)
    {
        List<RoomBookingDetails> BedBookingDatas = new List<RoomBookingDetails>();
        lresult = objRoomBookingBLL.GetBookingDetails(OrgID, ILocationID, BedID, out BedBookingDatas);
        grdBookingDetails.DataSource = BedBookingDatas;
        grdBookingDetails.DataBind();
        filterBinding();
        ModalPopupExtender1.Show();
    }
    #endregion

    #region Booking History
    protected void grdTreatementPlan_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            IPTreatmentPlanDetails IP = (IPTreatmentPlanDetails)e.Row.DataItem;
            string strScript = "INVRowCommon('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + IP.TreatmentPlanID + "');";
            ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onclick", strScript);
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
            lresult = objRoomBookingBLL.UpdateBookedDetails(OrgID, ILocationID, Convert.ToInt64(hdnBookingID.Value), tempstatus, IPTreatmentPlanID, patientVisitID, LID);

            ShowBookedDetails(Convert.ToInt32(hdnFromBedID.Value));
            filterBinding();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while grdBookingDetails_RowCommand", ex);
        }
    }

    protected void grdBookingDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblStatuse = (Label)e.Row.FindControl("lblStatuse");
                Button btnVacate = (Button)e.Row.FindControl("btnVacate");
                Button btnOccupy = (Button)e.Row.FindControl("btnOccupy");
                Button btnCancel = (Button)e.Row.FindControl("btnCancel");
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

            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading BookingDetails.", Ex);
        }
    }

    protected void grdBookingDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
    #endregion
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
        ClearAllDatas();
        filterBinding();
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

}
