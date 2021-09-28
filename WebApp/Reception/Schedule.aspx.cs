using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using System.Web.UI.HtmlControls;

public partial class Reception_Schedule : BasePage
{
    public Reception_Schedule()
        : base("Reception\\Schedule.aspx")
    {
    }


    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long resourceTemplateID = 0;
    DateTime occDate = new DateTime();
    long scheduleID = 0;
    bool bdIsDifferent = false;
    int iOrgID = 0;
    string patientID1 = "-1~0";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["RTID"] != null)
        {
            try
            {
                long patientID = 0;
                Int32.TryParse(Request.QueryString["ORG"], out iOrgID);
                Int64.TryParse(Request.QueryString["RTID"], out resourceTemplateID);
                Int64.TryParse(Request.QueryString["SID"], out scheduleID);
                hdnOrgId.Value = OrgID.ToString();
                //if (Request.QueryString["DFO"] != null)
                //{
                //    if (Request.QueryString["DFO"].ToString().ToLower() == "true")
                //    {
                //        bdIsDifferent = true;
                //    }
                //    else
                //    {
                //        bdIsDifferent = false;
                //    }
                //}


                //lblBkd.Visible = false;
                rtid.Value = Convert.ToString(resourceTemplateID);
                Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
                List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
                List<Bookings> bookings = new List<Bookings>();
                List<PhysicianSchedule> phySch = new List<PhysicianSchedule>();
                List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
                int LocationID = 0;
                Int32.TryParse(Request.QueryString["LOID"], out LocationID);
                sBL.GetSchedules(resourceTemplateID, iOrgID, out pSchedules, out phySpeciality, LocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-30), Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(30));

                List<SlotDetails> slots = new List<SlotDetails>();
                DateTime[] nxtOccurance = new DateTime[10];
                DateTime cOccruance = DateTime.Today;
                int scheduleTemplateID = 0;
                phySch = pSchedules.FindAll(delegate(PhysicianSchedule p) { return p.ScheduleID == scheduleID; });
                List<ScheduleTemplate> sTemplate = new List<ScheduleTemplate>();
                if (pSchedules.Count > 0)
                {
                    if (bdIsDifferent)
                    {
                        litName.Text = "  " + pSchedules[0].PhysicianName + " (" + phySch[0].NextOccurance.ToString("ddd dd MMM") + ")";
                    }
                    else
                    {
                        litName.Text = "Dr." + pSchedules[0].PhysicianName + " (" + phySch[0].NextOccurance.ToString("ddd dd MMM") + ")";
                    }
                    slots = GetSlots(phySch[0].From, phySch[0].To, phySch[0].SlotDuration);
                    occDate = phySch[0].NextOccurance;
                    sBL.GetBookings(resourceTemplateID, iOrgID, phySch[0].NextOccurance, scheduleID, out scheduleTemplateID, out bookings, out sTemplate);
                }
                if (!IsPostBack)
                {
                    btnSave.Attributes.Add("onClick", "return ValidateSchedule()");
                    Int64.TryParse(Request.QueryString["PID"], out patientID);

                    AutoCompleteExtenderPatientName.ContextKey = OrgID.ToString() + '~' + patientID1.ToString();

                    if (patientID > 0)
                    {
                        List<Patient> lstPatient = new List<Patient>();
                        new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
                        if (lstPatient.Count > 0)
                        {
                            txtPatientName.Text = lstPatient[0].Name.Trim();
                            txtPatientNumber.Text = lstPatient[0].PatientNumber.Trim();
                            txtPhoneNumber.Text = lstPatient[0].PatientAddress[0].MobileNumber + " - " + lstPatient[0].PatientAddress[1].MobileNumber;
                            txtPatientName.ReadOnly = true;
                            txtPatientNumber.ReadOnly = true;

                        }
                        else
                        {
                            txtPatientName.Text = "";
                            txtPatientNumber.Text = "";
                            txtPhoneNumber.Text = "";
                            txtPatientName.ReadOnly = false;
                            txtPatientNumber.ReadOnly = false;

                        }
                    }

                    foreach (Bookings dr in bookings)
                    {
                        foreach (SlotDetails slot in slots)
                        {
                            if (slot.SlotNumber == dr.TokenNumber)
                            {
                                //lblBkd.Visible = true;
                                slot.SlotDescription = dr.Description;
                                slot.PatientNumber = dr.PatientNumber;
                                slot.PhoneNumber = dr.PhoneNumber;
                                if (dr.BookingStatus == "V")
                                {
                                    slot.SlotAttributes = "Visited";
                                }
                                else
                                {
                                    slot.SlotAttributes = "Booked";
                                }
                                slot.BookingID = dr.BookingID;
                                slot.PatientName = dr.PatientName;
                                slot.UcurorgID = dr.OrgID;
                                slot.IbookOrgID = dr.BookingOrgID;
                            }
                        }
                    }
                    DrawSchedule(slots);
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading Schedule Page", ex);
            }
        }
        else
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "The selected physician does not have a schedule. Please define a schedule before booking.";
        }

    }

    private void DrawSchedule(List<SlotDetails> slots)
    {
        try
        {
            int NoOfColumns = 3;
            int count = 1;
            // int Id = 1;
            string sTime = string.Empty;
            string eTime = string.Empty;
            DateTime startDateTime = DateTime.Today;
            DateTime endDateTime = DateTime.Today;
            TableRow tRow = new TableRow();
            foreach (SlotDetails slot in slots)
            {
                TableCell tCell = new TableCell();
                sTime = startDateTime.Add(slot.StartTime).ToString("h:mm tt");
                eTime = endDateTime.Add(slot.EndTime).ToString("h:mm tt");
                if (slot.SlotAttributes.Trim().Length == 0)
                {
                    tCell.Attributes.Add("class", "tokenbooking");
                    tCell.Text = "<b>" + sTime + " to " + eTime + "</b><br><a href=\"javascript:Book('" + sTime + "','" + eTime + "','" + slot.SlotNumber.ToString() + "');\" style='text-decoration: underline; color: Black;'>Book</a>";
                    tRow.Cells.Add(tCell);
                    count++;
                    if (count > NoOfColumns)
                    {
                        tSchAv.Rows.Add(tRow);
                        count = 1;
                        tRow = new TableRow();
                    }
                }

            }
            if (count > 0 && count < 5)
                tSchAv.Rows.Add(tRow);
            count = 1;
            tRow = new TableRow();
            foreach (SlotDetails slot in slots)
            {
                TableCell tCell = new TableCell();
                sTime = startDateTime.Add(slot.StartTime).ToString("h:mm tt");
                eTime = endDateTime.Add(slot.EndTime).ToString("h:mm tt");
                if (slot.SlotAttributes.Trim().Length > 0)
                {
                    //lblBkd.Visible = true;
                    tCell.Width = Unit.Pixel(150);
                    tCell.Attributes.Add("class", "tokenbooked");
                    if ((slot.SlotAttributes.Trim() == "Visited") || (slot.UcurorgID != OrgID && slot.IbookOrgID != OrgID))
                    {
                        tCell.Text = "<b>" + "<img id='imgbtn' src='../Images/Token.gif' /> " + slot.SlotNumber + "<br><img id='imgbtn' src='../Images/Time_Icon.gif' /> " + sTime + " to " + eTime + "<br> <img id='imgbtn' src='../Images/patient_small.gif' /> " + slot.PatientName.Trim() + " (" + slot.PatientNumber.ToString() + ") <br><img id='imgbtn' src='../Images/Phone_Icon.gif' /> " + slot.PhoneNumber + "<br> <img id='imgbtn' src='../Images/notes.gif' /> " + slot.SlotDescription + "<br></b>";
                    }
                    else
                    {
                        tCell.Text = "<b>" + "<img id='imgbtn' src='../Images/Token.gif' /> " + slot.SlotNumber + "<br><img id='imgbtn' src='../Images/Time_Icon.gif' /> " + sTime + " to " + eTime + "<br> <img id='imgbtn' src='../Images/patient_small.gif' />" + slot.PatientName.Trim() + " (" + slot.PatientNumber.ToString() + ") <br><img id='imgbtn' src='../Images/Phone_Icon.gif' /> " + slot.PhoneNumber + "<br> <img id='imgbtn' src='../Images/notes.gif' /> " + slot.SlotDescription + "<br><div align='center'><a href=\"javascript:CancelBooking('" + slot.BookingID.ToString() + "','" + slot.SlotDescription + "');\" style='text-decoration:underline;color:Black;'>Cancel</a></div> </b><input type='hidden' id='Desc" + slot.BookingID + "' value='" + slot.SlotDescription + "'/> ";
                    }
                    tRow.Cells.Add(tCell);
                    count++;
                    if (count > NoOfColumns)
                    {

                        tSchBk.Rows.Add(tRow);
                        count = 1;
                        tRow = new TableRow();
                    }
                }
            }
            if (count > 0 && count < 5)
                tSchBk.Rows.Add(tRow);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing DrawSchedule", ex);
        }

    }

    private List<PhysicianSchedule> GetPhysicians(int OrgID)
    {
        Schedule_BL schedulebl = new Schedule_BL(base.ContextInfo);
        List<PhysicianSchedule> physicianschedule = new List<PhysicianSchedule>();
        schedulebl.GetPhysicians(OrgID, out physicianschedule);
        return physicianschedule;
    }

    /* private void GetBookings(long resourceTemplateID, int OrgID, DateTime occDate,out List<SlotDetails> slots, out DateTime[] nxtOccurances)
    {
            List<Bookings> bookings = new List<Bookings>();
            List<ScheduleTemplate> stemplate = new List<ScheduleTemplate>();
            slots = new List<SlotDetails>();
            Schedule_BL scheduleBL = new Schedule_BL(base.ContextInfo);           
            int scheduleTemplateID = 0;
            TimeSpan sTime = TimeSpan.MinValue;
            TimeSpan eTime = TimeSpan.MinValue;
            nxtOccurances = new DateTime[15];
            scheduleBL.GetBookings(resourceTemplateID, OrgID, occDate, out scheduleTemplateID, out bookings, out stemplate);
            sTime = sTime.Add(stemplate[0].StartTime);
            eTime = eTime.Add(stemplate[0].EndTime);
            slots = GetSlots(sTime, eTime, stemplate[0].SlotDuration);
            if (bookings.Count == 0)
            {
                nxtOccurances = scheduleBL.GetNxtOccurances(scheduleTemplateID, occDate);
            }
            else
            {
                nxtOccurances[0] = bookings[0].StartTime;
            }
            foreach (Bookings dr in bookings)
            {
                foreach (SlotDetails slot in slots)
                {
                    if (slot.SlotNumber == dr.TokenNumber)
                    {
                        slot.SlotDescription = dr.Description;
                        slot.SlotAttributes = "Booked";
                        slot.BookingID = dr.BookingID;
                    }
                }

            }
       
    }    */

    private List<SlotDetails> GetSlots(TimeSpan sTime, TimeSpan eTime, int slotDuration)
    {
        List<SlotDetails> slots = new List<SlotDetails>();

        try
        {
            int i = 1;
            while (sTime.CompareTo(eTime) == -1)
            {
                SlotDetails slot = new SlotDetails();
                slot.StartTime = sTime;
                slot.SlotNumber = i++;
                sTime = sTime.Add(new TimeSpan(0, slotDuration, 0));
                slot.EndTime = sTime;
                slots.Add(slot);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing the GetSlots", ex);
        }
        return slots;
    }

    private class SlotDetails
    {
        int slotNumber = 0;
        TimeSpan startTime = TimeSpan.MinValue;
        TimeSpan endTime = TimeSpan.MinValue;
        string slotDesc = string.Empty;
        string slotAttributes = string.Empty;
        string phoneNumber = string.Empty;
        string patientName = string.Empty;
        int icurorgID = 0;
        int ibookOrgID = 0;
        string patientNumber = string.Empty;
        long bookingID = 0;

        public long BookingID
        {
            get { return bookingID; }
            set { bookingID = value; }
        }
        public int SlotNumber
        {
            get { return slotNumber; }
            set { slotNumber = value; }
        }
        public TimeSpan StartTime
        {
            get { return startTime; }
            set { startTime = value; }

        }
        public TimeSpan EndTime
        {
            get { return endTime; }
            set { endTime = value; }
        }
        public string SlotDescription
        {
            get { return slotDesc; }
            set { slotDesc = value; }
        }
        public string SlotAttributes
        {
            get { return slotAttributes; }
            set { slotAttributes = value; }
        }
        public string PhoneNumber
        {
            get { return phoneNumber; }
            set { phoneNumber = value; }
        }
        public string PatientNumber
        {
            get { return patientNumber; }
            set { patientNumber = value; }
        }
        public string PatientName
        {
            get { return patientName; }
            set { patientName = value; }
        }
        public int UcurorgID
        {
            get { return icurorgID; }
            set { icurorgID = value; }
        }
        public int IbookOrgID
        {
            get { return ibookOrgID; }
            set { ibookOrgID = value; }
        }
    }

    protected void bSave_Click(object sender, EventArgs e)
    {

        try
        {
            long referalID = 0;
            Int64.TryParse(Request.QueryString["rfid"], out referalID);

            Bookings bk = new Bookings();

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            long resourceTemplateID = 0;
            int tokenNumber = 0;
            //            DateTime nxtDate = new DateTime();
            DateTime sTime = new DateTime();
            DateTime eTime = DateTime.MinValue;
            string sDTM = string.Empty;
            string eDTM = string.Empty;
            string[] seperator = new string[2];
            string[] time = new string[2];
            seperator[0] = "To";
            time = hidDate.Value.Split(seperator, StringSplitOptions.RemoveEmptyEntries);
            sDTM = occDate.ToShortDateString() + " " + time[0];
            eDTM = occDate.ToShortDateString() + " " + time[1];
            int scheduleTemplateID = 0;
            string sPhoneNumber = txtPhoneNumber.Text.Trim();
            string lPatientNumber = string.Empty;

            int LocationID = 0;
            Int32.TryParse(Request.QueryString["LOID"], out LocationID);

            lPatientNumber = txtPatientNumber.Text.Trim();

            List<Bookings> books = new List<Bookings>();
            List<ScheduleTemplate> stemplate = new List<ScheduleTemplate>();
            List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
            List<PhysicianSchedule> phySch = new List<PhysicianSchedule>();
            List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
            Int32.TryParse(hidToken.Value, out tokenNumber);
            Int64.TryParse(rtid.Value, out resourceTemplateID);
            DateTime.TryParse(sDTM, out sTime);
            DateTime.TryParse(eDTM, out eTime);
            List<SlotDetails> slots = new List<SlotDetails>();
            if (sTime > DateTime.MinValue && tokenNumber > 0)
            {
                bk.ResourceTemplateID = resourceTemplateID;
                bk.TokenNumber = tokenNumber;
                bk.StartTime = sTime;
                bk.EndTime = eTime;
                bk.Description = tBkDesc.Text;
                bk.CreatedBy = LID;
                bk.ScheduleID = scheduleID;
                bk.PhoneNumber = sPhoneNumber;
                bk.PatientNumber = lPatientNumber;
                bk.PatientName = txtPatientName.Text;
                bk.OrgID = iOrgID;
                bk.BookingOrgID = OrgID;
                bk.ReferalID = referalID;

                long retcode = sBL.SaveBooking(bk);
                if (retcode > 0 && retcode != 1001)
                {
                    this.Page.RegisterStartupScript("ky", "<script language='javascript' >alert('Token booked successfully');</script>");
                    long patientID = 0;
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    if (patientID == 0)
                    {
                        txtPatientName.Text = "";
                        txtPatientNumber.Text = "";
                        txtPhoneNumber.Text = "";
                        txtPatientName.ReadOnly = false;
                        txtPatientNumber.ReadOnly = false;
                    }
                }
                else
                {
                    this.Page.RegisterStartupScript("ky", "<script language='javascript' >alert('Token already booked for another patient. Please select any other token');</script>");
                }
            }
            sBL.GetSchedules(resourceTemplateID, iOrgID, out pSchedules, out phySpeciality, LocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(2));

            DateTime[] nxtOccurance = new DateTime[15];
            DateTime cOccruance = DateTime.Today;
            List<ScheduleTemplate> sTemplate = new List<ScheduleTemplate>();
            phySch = pSchedules.FindAll(delegate(PhysicianSchedule p) { return p.ScheduleID == scheduleID; });
            slots = GetSlots(pSchedules[0].From, pSchedules[0].To, pSchedules[0].SlotDuration);

            sBL.GetBookings(resourceTemplateID, iOrgID, phySch[0].NextOccurance, scheduleID, out scheduleTemplateID, out books, out sTemplate);

            foreach (Bookings dr in books)
            {
                foreach (SlotDetails slot in slots)
                {
                    if (slot.SlotNumber == dr.TokenNumber)
                    {
                        slot.SlotDescription = dr.Description;
                        slot.PatientNumber = dr.PatientNumber;
                        slot.PhoneNumber = dr.PhoneNumber;
                        slot.SlotAttributes = "Booked";
                        slot.BookingID = dr.BookingID;
                        slot.PatientName = dr.PatientName;
                        slot.UcurorgID = dr.OrgID;
                        slot.IbookOrgID = dr.BookingOrgID;
                    }
                }

            }
            DrawSchedule(slots);


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving the Schedule", ex);
        }
    }




    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            if (bdIsDifferent)
            {
                Response.Redirect(Request.ApplicationPath + "/Reception/TrustedSchedules.aspx");
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + "/Reception/Home.aspx");
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }


    protected void bCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            long bookId = 0;
            long returnCode = -1;
            string description = string.Empty;
            List<Bookings> books = new List<Bookings>();
            List<ScheduleTemplate> stemplate = new List<ScheduleTemplate>();
            List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
            List<SlotDetails> slots = new List<SlotDetails>();
            List<PhysicianSchedule> phySch = new List<PhysicianSchedule>();
            List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
            int scheduleTemplateID = 0;
            Int64.TryParse(hidBKID.Value, out bookId);
            returnCode = sBL.CancelBooking(bookId, tCanDesc.Text);
            this.Page.RegisterStartupScript("ky", "<script language='javascript' >alert('Token cancelled successfully');</script>");

            int LocationID = 0;
            Int32.TryParse(Request.QueryString["LOID"], out LocationID);

            sBL.GetSchedules(resourceTemplateID, iOrgID, out pSchedules, out phySpeciality, LocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddYears(2));

            DateTime[] nxtOccurance = new DateTime[15];
            DateTime cOccruance = DateTime.Today;
            List<ScheduleTemplate> sTemplate = new List<ScheduleTemplate>();
            phySch = pSchedules.FindAll(delegate(PhysicianSchedule p) { return p.ScheduleID == scheduleID; });
            slots = GetSlots(pSchedules[0].From, pSchedules[0].To, pSchedules[0].SlotDuration);

            sBL.GetBookings(resourceTemplateID, iOrgID, phySch[0].NextOccurance, scheduleID, out scheduleTemplateID, out books, out sTemplate);

            foreach (Bookings dr in books)
            {
                foreach (SlotDetails slot in slots)
                {
                    if (slot.SlotNumber == dr.TokenNumber)
                    {
                        slot.SlotDescription = dr.Description;
                        slot.PatientNumber = dr.PatientNumber;
                        slot.PhoneNumber = dr.PhoneNumber;
                        slot.SlotAttributes = "Booked";
                        slot.BookingID = dr.BookingID;
                        slot.PatientName = dr.PatientName;
                        slot.UcurorgID = dr.OrgID;
                        slot.IbookOrgID = dr.BookingOrgID;
                    }
                }
            }
            DrawSchedule(slots);

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving the Schedule", ex);
        }
    }
}
