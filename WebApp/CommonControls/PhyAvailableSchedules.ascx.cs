using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Attune.Podium.Common;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_PhySchedule : BaseControl
{
    Schedule_BL sBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        string Week1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.ToString("dd/MM/yyyy") + " To " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(6).Date.ToString("dd/MM/yyyy");
        string Week2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(7).Date.ToString("dd/MM/yyyy") + " To " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(13).Date.ToString("dd/MM/yyyy");
        string Week3 = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(14).Date.ToString("dd/MM/yyyy") + " To " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(20).Date.ToString("dd/MM/yyyy");
        string Week4 = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(21).Date.ToString("dd/MM/yyyy") + " To " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(26).Date.ToString("dd/MM/yyyy");

        lnkWeek1.Text = Week1;
        lnkWeek2.Text = Week2;
        lnkWeek3.Text = Week3;
        lnkWeek4.Text = Week4;

        if (!IsPostBack)
        {

            
            lnkWeek1.Font.Underline = true;

            sBL = new Schedule_BL(base.ContextInfo);
            List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
            List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
            List<PhysicianSchedule> daySchedule;
            List<WeekDayList> wkList = new List<WeekDayList>();
            int cnt = 0;
            sBL.GetSchedules(0, OrgID, out pSchedules, out phySpeciality, ILocationID,Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-30), Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(30));
            DateTime vDate = DateTime.Today;
            for (int i = 0; i < 7; i++)
            {
                daySchedule = pSchedules.FindAll(delegate(PhysicianSchedule p) { return p.NextOccurance.CompareTo(vDate) == 0; });
                foreach (PhysicianSchedule phy in daySchedule)
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

                if (daySchedule.Count > 0)
                {
                    wkList.Add(BuildList(daySchedule, vDate));
                }
                vDate = vDate.AddDays(1);
            }
            foreach (WeekDayList wk in wkList)
            {
                tblHide.Visible = true;

                switch (cnt)
                {
                    case 0:
                        lday1.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay1.DataSource = wk.Visits;
                        rDay1.DataBind();
                        break;
                    case 1:
                        lday2.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay2.DataSource = wk.Visits;
                        rDay2.DataBind();
                        break;
                    case 2:
                        lday3.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay3.DataSource = wk.Visits;
                        rDay3.DataBind();
                        break;
                    case 3:
                        lday4.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay4.DataSource = wk.Visits;
                        rDay4.DataBind();
                        break;
                    case 4:
                        rDay5.DataSource = wk.Visits;
                        rDay5.DataBind();
                        lday5.Text = wk.VisitDate.ToString("ddd dd MMM");
                        break;
                    case 5:
                        rDay6.DataSource = wk.Visits;
                        rDay6.DataBind();
                        lday6.Text = wk.VisitDate.ToString("ddd dd MMM");
                        break;
                }
                cnt++;
            }
        }

    }


    private WeekDayList BuildList(List<PhysicianSchedule> daySchedule,DateTime VisitDate)
    {
        List<SchList> dayList = new List<SchList>();
        WeekDayList wk = new WeekDayList();
        string sTime = string.Empty;
        string eTime = string.Empty;
        List<PhysicianSpeciality> pSpeciality = new List<PhysicianSpeciality>();
        List<PhysicianSpeciality> physicianSpeciality = new List<PhysicianSpeciality>();
        foreach (PhysicianSchedule phySch in daySchedule)
        {
            SchList sch = new SchList();
            sTime = DateTime.Today.Add(phySch.From).ToString("h:mm tt");
            eTime = DateTime.Today.Add(phySch.To).ToString("h:mm tt");
            sch.PhysicianID = phySch.PhysicianID;
            sch.Details = "<a href='Schedule.aspx?RTID=" + phySch.ResourceTemplateID.ToString() + "&SID=" + phySch.ScheduleID.ToString() + "'><b>" + phySch.PhysicianName + "</b><br><b><i>" + sTime + " to " + eTime + "</i></b><br>" + phySch.SpecialityName + "</a>";
            //sch.Details = "<a href='#'><b>" + phySch.PhysicianName + "</b><br>" + phySch.SpecialityName + "<br><b><i>" + phySch.From.ToString() + " to " + phySch.To.ToString() + "</i></b></a>";
            dayList.Add(sch);
        }

        wk.VisitDate = VisitDate;
        wk.Visits = dayList;
        return wk;
    }


    private class WeekDayList
    {
        DateTime visitDate;
        List<SchList> visits;
        public DateTime VisitDate
        {
            get{return visitDate;}
            set{visitDate = value;}
        }
        public List<SchList> Visits
        {
            get { return visits; }
            set { visits = value; }
        }
    }

    private class SchList
    {
        long phyID;
        long RTID;
        string details;

        public long PhysicianID
        {
            get { return phyID; }
            set { phyID = value; }
        }

        public long ResourceTemplateID
        {
            get { return RTID; }
            set { RTID = value; }
        }

        public string Details
        {
            get {return details; }
            set { details = value; }
        }

    }
    protected void lNext_Click(object sender, EventArgs e)
    {

        Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
        List<PhysicianSchedule> daySchedule;
        List<WeekDayList> wkList = new List<WeekDayList>();
        int cnt = 0;
        sBL.GetSchedules(0, OrgID, out pSchedules, out phySpeciality, ILocationID, Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-30), Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(30));

        LinkButton lnkBtn = (LinkButton)sender;
        string lnkName = lnkBtn.ID.ToString();
        
        DateTime vDate = DateTime.Today;

        if (lnkName == "lnkWeek1")
        {
            vDate = DateTime.Today;
            lnkWeek1.Font.Underline = true;
            lnkWeek2.Font.Underline = false;
            lnkWeek3.Font.Underline = false;
            lnkWeek4.Font.Underline = false;
        }
        else if (lnkName == "lnkWeek2")
        {
            vDate = DateTime.Today.AddDays(7);
            lnkWeek1.Font.Underline = false;
            lnkWeek2.Font.Underline = true;
            lnkWeek3.Font.Underline = false;
            lnkWeek4.Font.Underline = false;
        }
        else if (lnkName == "lnkWeek3")
        {
            vDate = DateTime.Today.AddDays(14);
            lnkWeek1.Font.Underline = false;
            lnkWeek2.Font.Underline = false;
            lnkWeek3.Font.Underline = true;
            lnkWeek4.Font.Underline = false;
        }
        else if (lnkName == "lnkWeek4")
        {
            vDate = DateTime.Today.AddDays(21);
            lnkWeek1.Font.Underline = false;
            lnkWeek2.Font.Underline = false;
            lnkWeek3.Font.Underline = false;
            lnkWeek4.Font.Underline = true;
        }

        for (int i = 1; i < 7; i++)
        {
            daySchedule = pSchedules.FindAll(delegate(PhysicianSchedule p) { return p.NextOccurance.CompareTo(vDate) == 0; });
            if (daySchedule.Count > 0)
            {
                wkList.Add(BuildList(daySchedule, vDate));
            }
            vDate = vDate.AddDays(1);
        }
        foreach (WeekDayList wk in wkList)
        {
            tblHide.Visible = true;

            switch (cnt)
            {
                case 0:
                    lday1.Text = wk.VisitDate.ToString("ddd dd MMM");
                    rDay1.DataSource = wk.Visits;
                    rDay1.DataBind();
                    break;
                case 1:
                    lday2.Text = wk.VisitDate.ToString("ddd dd MMM");
                    rDay2.DataSource = wk.Visits;
                    rDay2.DataBind();
                    break;
                case 2:
                    lday3.Text = wk.VisitDate.ToString("ddd dd MMM");
                    rDay3.DataSource = wk.Visits;
                    rDay3.DataBind();
                    break;
                case 3:
                    lday4.Text = wk.VisitDate.ToString("ddd dd MMM");
                    rDay4.DataSource = wk.Visits;
                    rDay4.DataBind();
                    break;
                case 4:
                    rDay5.DataSource = wk.Visits;
                    rDay5.DataBind();
                    lday5.Text = wk.VisitDate.ToString("ddd dd MMM");
                    break;
                case 5:
                    rDay6.DataSource = wk.Visits;
                    rDay6.DataBind();
                    lday6.Text = wk.VisitDate.ToString("ddd dd MMM");
                    break;
            }
            cnt++;
        }
    }
}