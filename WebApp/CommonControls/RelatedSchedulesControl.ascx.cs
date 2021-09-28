using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
 

public partial class CommonControls_RelatedSchedulesControl : BaseControl
{
    private string selIDVals;
    public string SelIDS
    {
        get { return selIDVals ; }
        set { selIDVals = value; }
    }

    private string patientname;
    public string Patientname
    {
        get { return patientname; }
        set { patientname = value; }
    }

    private string patientNumber;
    public string PatientNumber
    {
        get { return patientNumber; }
        set { patientNumber = value; }
    }
    
    private string phoneNumber;
    public string PhoneNumber
    {
        get { return phoneNumber; }
        set { phoneNumber = value; }
    }

    protected string currentDIV = "";
    public string CurrentDIV
    {
        get { return currentDIV; }
        set { currentDIV = value; }
    }

    protected string nextDIV = "";
    public string NextDIV
    {
        get { return nextDIV; }
        set { nextDIV = value; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public void loadDatas()
    {
        try
        {
            object sender = null;
            EventArgs e = null;
            hdnOrgId.Value = OrgID.ToString();
            hdnSelectedSchedules.Value = SelIDS;
            btnSearch_Click(sender, e);
             
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error while executing the pageload", ex);
        }
    }

    public override void DataBind()
    {
        try
        {
            object sender = null;
            EventArgs e = null;
            hdnOrgId.Value = OrgID.ToString();
            
            btnSearch_Click(sender, e);

        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error while executing the pageload", ex);
        }
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
        List<Bookings> bookings = new List<Bookings>();
        List<SlotDetails> slots = new List<SlotDetails>();

        sBL.GetSchedulesAndBookings(hdnSelectedSchedules.Value.Trim(), OrgID, out pSchedules, out phySpeciality, ILocationID, out bookings);

        foreach (PhysicianSchedule phy in pSchedules)
        {

            var speciality = from sp in phySpeciality
                             where sp.PhysicianID == phy.PhysicianID
                             select sp;
            string spName = string.Empty;
            int spCnt = 0;
            foreach (var sp in speciality)
            {
                if (spCnt == 0)
                    spName = sp.SpecialityName;
                else
                    spName = spName + "/" + sp.SpecialityName;
                spCnt++;
            }
            phy.SpecialityName = spName;
        }

        string sStartHTML = "";
        string sEndHTML = "";
        sStartHTML = "<table border='1' cellpadding='0' cellspacing='0'>";
        sEndHTML = sStartHTML + "</table>";

        //List<DateTime> pDates = ((from p in pSchedules
        //                          select p.NextOccurance).Distinct()).ToList();
        //if (pDates.Count > 0)
        //{
        //    sStartHTML += "<tr class='theader'>";
        //    for (int i = 0; i < pDates.Count; i++)
        //    {
        //        sStartHTML += " <td align='center'>" + pDates[i].ToString("dd/MMM/yyyy") + "</td>";
        //    }
        //    sStartHTML += " </tr>";
        //}
        sStartHTML += "<tr>";
        for (int i = 0; i < pSchedules.Count; i++)
        {
            if (pSchedules[i].ResourceType == "P")
            {
                sStartHTML += "<td align='center' valign='top' bgcolor='#0099FF'><span class='theader'>&nbsp; Dr."
                                   + pSchedules[i].PhysicianName + "&nbsp;&nbsp;<br/> " + pSchedules[i].SpecialityName + "<br/> (" + pSchedules[i].NextOccurance.ToString("dd MMM yyyy") + ") </span></td>";
            }
            else
            {
                sStartHTML += "<td align='center' valign='top' bgcolor='#0099FF'><span class='theader'>"
                                  + pSchedules[i].PhysicianName + "&nbsp;&nbsp;<br/> " + pSchedules[i].SpecialityName + "<br/> (" + pSchedules[i].NextOccurance.ToString("dd MMM yyyy") + " </span></td>";
            }
        }
        sStartHTML += "</tr>";
        sStartHTML += "<tr>";
        for (int i = 0; i < pSchedules.Count; i++)
        {

            sStartHTML += "<td align='center' valign='top' bgcolor='#999999'>";
            slots = GetSlots(pSchedules[i].From, pSchedules[i].To, pSchedules[i].SlotDuration, pSchedules[i].ScheduleID, pSchedules[i].ResourceTemplateID, pSchedules[i].PhysicianName, pSchedules[i].NextOccurance.ToString("dd MMM yy"), pSchedules[i].ResourceType, pSchedules[i].NextOccurance);
            foreach (Bookings dr in bookings)
            {
                foreach (SlotDetails slot in slots)
                {
                    if (slot.SlotNumber == dr.TokenNumber && dr.ScheduleID == pSchedules[i].ScheduleID)
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
            string sInnerTable = DrawSchedule(slots);
            sStartHTML += sInnerTable;
            sStartHTML += "    </td>";

        }
        sStartHTML += "</tr>";
        dvTableData.InnerHtml = sStartHTML + sEndHTML;
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
        DateTime dtSlotDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        public DateTime SlotDate
        {
            get { return dtSlotDate; }
            set { dtSlotDate = value; }
        }

        public long BookingID
        {
            get { return bookingID; }
            set { bookingID = value; }
        }

        long scheduleID = 0;
        public long ScheduleID
        {
            get { return scheduleID; }
            set { scheduleID = value; }
        }

        string resourceName = "";
        public string ResourceName
        {
            get { return resourceName; }
            set { resourceName = value; }
        }

        long rtid = 0;
        public long RTID
        {
            get { return rtid; }
            set { rtid = value; }
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

    private string DrawSchedule(List<SlotDetails> slots)
    {
        string sTable = "<div style='height:450px;width:150px;overflow:scroll;' > <table width='100%' border='1' align='center' cellpadding='0' cellspacing='0'>";

        try
        {
            //int NoOfColumns = 3;
            //int count = 1;
            // int Id = 1;
            string sTime = string.Empty;
            string eTime = string.Empty;
            DateTime startDateTime = DateTime.Today;
            DateTime endDateTime = DateTime.Today;
            //TableRow tRow = new TableRow();

            foreach (SlotDetails slot in slots)
            {
                sTime = startDateTime.Add(slot.StartTime).ToString("h:mm tt");
                eTime = endDateTime.Add(slot.EndTime).ToString("h:mm tt");
                string slotdate = slot.SlotDate.ToString("dd/MM/yyyy");
                if (slot.SlotAttributes.Trim().Length == 0)
                {
                    string sDetails = "";
                    sDetails = slotdate + " " + sTime + "~" + slotdate + " " + eTime + "~" + slot.SlotNumber.ToString() + "~" + slot.ScheduleID.ToString() + "~" + slot.RTID.ToString();
                    sTable += "<tr><td width='65%' align='left' bgcolor='#CAF0FF' class='theader'>" + sTime +
                        //"-" + eTime +
                        " </td>" +
                             "<td width='17px' align='center' bgcolor='#FFFFFF' class='theader'>" +
                             " <input type='checkbox' id='" + sDetails + "' onclick='Book1(this.id);' runat='server'  />" +
                             "</td></tr>";
                    
                }
                if (slot.SlotAttributes.Trim().Length > 0)
                {
                    var slotdesc = slot.PatientName + "-(Mob:" + slot.PhoneNumber + ")";

                    if ((slot.SlotAttributes.Trim() == "Visited") || (slot.UcurorgID != OrgID && slot.IbookOrgID != OrgID))
                    {
                        sTable += "<tr> <td align='left' width='65%' bgcolor='#FF9900'><a class='theader' href='#' title=" + slotdesc + " > " + sTime +
                            //" - " + eTime + 
                            "<br/>(P.No:" + slot.PatientNumber.ToString() + ")</a></td>" +
                                    "<td align='center' bgcolor='#FFFFFF' width='17px'><span class='theader'></span></td></tr>";
                    }
                    else
                    {
                        sTable += "<tr> <td width='65%' align='left' bgcolor='#FF9900' ><a class='theader' href='#' title=" + slotdesc + " > " + sTime +
                            //" - " + eTime + 
                            "<br/>(P.No:" + slot.PatientNumber.ToString() + ")</a></td>" +
                        "<td align='center' bgcolor='#FFFFFF' width='17px' >" +
                             "<img src='../Images/CloseIcon.png' alt='Cancel Slots'   onClick= \"javascript:CancelBooking1('" + slot.BookingID.ToString() + "','" + slot.SlotDescription + "');\" style='cursor:Pointer;' > </img>" +

                            "</td></tr>";
                    }
                }

            }
            sTable += "</div></table>";
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error while executing DrawSchedule", ex);
        }
        return sTable;
    }

    private List<SlotDetails> GetSlots(TimeSpan sTime, TimeSpan eTime,
        int slotDuration, long schID, long RtempID, string phyName, string DOSch, string resourcetype, DateTime slotDate)
    {
        List<SlotDetails> slots = new List<SlotDetails>();

        try
        {
            int i = 1;
            while (sTime.CompareTo(eTime) == -1)
            {
                SlotDetails slot = new SlotDetails();
                slot.StartTime = sTime;
                slot.ScheduleID = schID;
                slot.RTID = RtempID;
                slot.SlotNumber = i++;
                sTime = sTime.Add(new TimeSpan(0, slotDuration, 0));
                slot.EndTime = sTime;
                slots.Add(slot);
                slot.SlotDate = slotDate;
                if (resourcetype == "P")
                {
                    slot.ResourceName = "Dr." + phyName + " (" + DOSch + ")";
                }
                else
                {
                    slot.ResourceName = phyName + " (" + DOSch + ")";
                }
            }
        }

        catch (Exception ex)
        {
            //CLogger.LogError("Error while executing the GetSlots", ex);
        }
        return slots;
    }

    protected void bSave_Click(object sender, EventArgs e)
    {

        try
        {
            long referalID = 0;
            string sreq = hdnSelectedID.Value;
            Int64.TryParse(Request.QueryString["rfid"], out referalID);

            Bookings bk = new Bookings();

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);



            long retcode = sBL.SaveBookingBulkSchedules(GetBooks());
            if (retcode == 1)
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


            btnSearch_Click(sender, e);
            hdnSelectedID.Value = "";
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error while saving the Schedule", ex);
        }
    }
    protected List<Bookings> GetBooks()
    {
        long resourceTemplateID = 0;
        int tokenNumber = 0;
        //            DateTime nxtDate = new DateTime();

        string sPhoneNumber = txtPhoneNumber.Text.Trim();
        string sPatientName = txtPatientName.Text.Trim();
        string lPatientNumber = string.Empty;

        int LocationID = ILocationID;

        lPatientNumber=txtPatientNumber.Text.Trim();
        List<Bookings> books = new List<Bookings>();

        string sSelectedValue = "";
        sSelectedValue = hdnSelectedID.Value.ToString();


        Int32.TryParse(hidToken.Value, out tokenNumber);
        Int64.TryParse(rtid.Value, out resourceTemplateID);
        string[] Maindata = sSelectedValue.Split('|');
        if (Maindata.Length > 0)
        {
            for (int i = 0; i < Maindata.Length; i++)
            {
                if (Maindata[i] != "")
                {
                    string[] Childdata = Maindata[i].Split('~');
                    if (Childdata.Length > 0)
                    {
                        Bookings bkdata = new Bookings();
                        bkdata.StartTime = Convert.ToDateTime(Childdata[0].ToString());
                        bkdata.EndTime = Convert.ToDateTime(Childdata[1].ToString());
                        bkdata.TokenNumber = Convert.ToInt32(Childdata[2].ToString());
                        bkdata.ScheduleID = Convert.ToInt64(Childdata[3].ToString());
                        bkdata.ResourceTemplateID = Convert.ToInt64(Childdata[4].ToString());
                        bkdata.Description = tBkDesc.Text;
                        bkdata.CreatedBy = LID;
                        bkdata.PhoneNumber = sPhoneNumber;
                        bkdata.PatientNumber = lPatientNumber;
                        bkdata.PatientName = txtPatientName.Text;
                        bkdata.OrgID = OrgID;
                        bkdata.BookingOrgID = OrgID;
                        bkdata.ReferalID = 0;

                        books.Add(bkdata);
                    }
                }
            }
        }
        //DateTime.TryParse(sDTM, out sTime);
        //DateTime.TryParse(eDTM, out eTime);


        //bk.ResourceTemplateID = resourceTemplateID;
        //bk.TokenNumber = tokenNumber;
        //bk.StartTime = sTime;
        //bk.EndTime = eTime;
        //


        return books;
    }

    protected void bCancel_Click(object sender, EventArgs e)
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
        Int64.TryParse(hidBKID.Value, out bookId);
        returnCode = sBL.CancelBooking(bookId, tCanDesc.Text);
                this.Page.RegisterStartupScript("ky", "<script language='javascript' >alert('Token cancelled successfully');</script>");

        btnSearch_Click(sender, e);
        hdnSelectedID.Value = "";
    }

    protected void btnSlots_Back(object sender, EventArgs e)
    {
        if (CurrentDIV != "")
        {
            HtmlContainerControl htmCurrent = (HtmlContainerControl)Parent.FindControl(CurrentDIV);
            HtmlContainerControl htmNext = (HtmlContainerControl)Parent.FindControl(NextDIV);
            hdnSelectedSchedules.Value = "";

            htmCurrent.Style.Remove("Display");
            htmNext.Style.Remove("Display");
            htmNext.Style.Add("Display", "Block");
            htmCurrent.Style.Add("Display", "none");
            this.Parent.Page.ToString();
        }
        else
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
    }
}
