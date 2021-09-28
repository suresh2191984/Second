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
using System.Web.UI.HtmlControls;

public partial class CommonControls_PhySchedule : BaseControl
{
    public CommonControls_PhySchedule()
        : base("CommonControls_PhySchedule_ascx")
    {
    }
    protected int tempOrgID = 0;
    public int TempOrgID
    {
        get { return tempOrgID; }
        set { tempOrgID = value; }
    }
    protected long patientID = 0;
    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }
    protected long referalID = 0;
    public long ReferalID
    {
        get { return referalID; }
        set { referalID = value; }
    }
    protected int locationID = 0;
    public int LocationID 
    {
        get { return locationID; }
        set { locationID = value; }
    }

    protected string postdifferentpage = "";
    public string PostDifferentPage
    {
        get { return postdifferentpage; }
        set { postdifferentpage = value; }
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

    protected UserControl usrCtrl = null;
    public UserControl RelatedControl 
    {
        get { return usrCtrl; }
        set { usrCtrl = value; }
    }

    protected string usrHdn = null;
    public string PreviousHiddenField 
    {
        get { return usrHdn; }
        set { usrHdn = value; }
    }
    GateWay gateWay;


    string UsrlnkWeek1 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_01 == null ? "lnkWeek1" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_01;
    string UsrlnkWeek2 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_02 == null ? "lnkWeek2" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_02;
    string UsrlnkWeek3 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_03 == null ? "lnkWeek3" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_03;
    string UsrlnkWeek4 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_04 == null ? "lnkWeek4" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_04;
    string UsrlnkWeek5 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_05 == null ? "lnkWeek5" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_05;
    string UsrlnkWeek6 = Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_06 == null ? "lnkWeek6" : Resources.CommonControls_ClientDisplay.CommonControls_PhySchedule_ascx_06;

    protected void Page_Load(object sender, EventArgs e)
    {
        string Week = "";
       
        if (hdnMonth.Value == "" || hdnMonth.Value == null)
        {
            hdnMonth.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("MMM/yyyy");
        }

        DateLogic(out Week, 1);
        lnkWeek1.Text = Week;

        DateLogic(out Week, 2);
        lnkWeek2.Text = Week;

        DateLogic(out Week, 3);
        lnkWeek3.Text = Week;

        DateLogic(out Week, 4);
        lnkWeek4.Text = Week;

        DateLogic(out Week, 5);
        lnkWeek5.Text = Week;
        
        DateLogic(out Week, 6);
        lnkWeek6.Text = Week;
        if (PostDifferentPage != "")
        {
            btnRelated.PostBackUrl = "~/Reception/RelativeSchedules.aspx";
        }
        else
        {
            btnRelated.PostBackUrl = "";
        }

        if (!IsPostBack)
        {
            LoadMetaData();
            LoadMeatData();
            gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            int monthduration =0;
            long returnCode = gateWay.GetConfigDetails("ScheduleDuration", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                Int32.TryParse(lstConfig[0].ConfigValue, out monthduration);
            }

            DateTime dtNowDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime dtIncrementDate = dtNowDate;
            string sHtml = "";
            string btnID ="";
            for (int i = 0; i < monthduration; i++)
            {
                btnID = dtIncrementDate.ToString("MMM/yyyy");
                sHtml += "<input type='button' id='" 
                    + btnID + "' class='btn' onclick='ChangeStyle(id);' title='"
                    + dtIncrementDate.ToString("MMM/yyyy") + "' value='" + dtIncrementDate.ToString("MMM/yyyy") + "' runat='server' />";

                dtIncrementDate = dtIncrementDate.AddMonths(1);
            }
            dvMonths.InnerHtml = sHtml;
           
            lnkWeek1.Font.Underline = true;
            lNext_Click(sender, e);
        
        }
    }
    #region  Added from Jagatheeshkumar

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "AdminPhyschAll,AdminPhyschEmailSMS";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "AdminPhyschAll"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlSpeciality.DataSource = childItems;
                    ddlSpeciality.DataTextField = "DisplayText";
                    ddlSpeciality.DataValueField = "Code";
                    ddlSpeciality.DataBind();

                }
                var childItems1 = from child in lstmetadataOutputs
                                  where child.Domain == "AdminPhyschEmailSMS"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlReminder.DataSource = childItems1;
                    ddlReminder.DataTextField = "DisplayText";
                    ddlReminder.DataValueField = "Code";
                    ddlReminder.DataBind();
                    
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion

    private WeekDayList BuildList(List<PhysicianSchedule> daySchedule, DateTime VisitDate)
    {
        List<SchList> dayList = new List<SchList>();
        WeekDayList wk = new WeekDayList();
        string sTime = string.Empty;
        string eTime = string.Empty;
        List<PhysicianSpeciality> pSpeciality = new List<PhysicianSpeciality>();
        List<PhysicianSpeciality> physicianSpeciality = new List<PhysicianSpeciality>();

        string sTrueData = "";

        if (OrgID == TempOrgID)
        {
            sTrueData = "False";
        }
        else
        {
            sTrueData = "True";
        }

        foreach (PhysicianSchedule phySch in daySchedule)
        {
            SchList sch = new SchList();
            sTime = DateTime.Today.Add(phySch.From).ToString("h:mm tt");
            eTime = DateTime.Today.Add(phySch.To).ToString("h:mm tt");
            sch.PhysicianID = phySch.PhysicianID;
            sch.Booked = phySch.Booked;
            sch.TotalSlots = phySch.TotalSlots - phySch.Booked;
            sch.ScheduleID = phySch.ScheduleID;
            if (PostDifferentPage != "")
            {
                if (phySch.ResourceType.TrimEnd() == "P")
                {
                    sch.Details = "<a href='../Reception/Schedule.aspx?RTID=" + phySch.ResourceTemplateID.ToString()
                                + "&SID=" + phySch.ScheduleID.ToString()
                                + "&DFO=" + sTrueData + "&ORG="
                                + TempOrgID.ToString()
                                + "&PID=" + PatientID.ToString()
                                + "&RFID=" + ReferalID.ToString()
                                + "&LOID=" + LocationID.ToString()
                                + "'> <span style='color:lime;'> Dr."
                                + phySch.PhysicianName + "</span><br><b><i>"
                                + sTime + " to " + eTime + "</i></b><br><span style='color:black;'> "
                                + phySch.SpecialityName + "</span></a>";
                    dayList.Add(sch);
                }
                if (phySch.ResourceType.TrimEnd() == "M")
                {
                    sch.Details = "<a href='../Reception/Schedule.aspx?RTID=" + phySch.ResourceTemplateID.ToString()
                                + "&SID=" + phySch.ScheduleID.ToString()
                                + "&DFO=" + sTrueData + "&ORG="
                                + TempOrgID.ToString()
                                + "&PID=" + PatientID.ToString()
                                + "&RFID=" + ReferalID.ToString()
                                + "&LOID=" + LocationID.ToString()
                                + "'> <span style='color:lime;'>"
                                + phySch.PhysicianName + "</span><br><b><i>"
                                + sTime + " to " + eTime + "</i></b><br><span style='color:black;'> "
                                + phySch.SpecialityName + "</span></a>";
                    dayList.Add(sch);
                }
                //else
                //{
                //    sch.Details = "<a href='../Invoice/GenerateInvoice.aspx?CID=" + phySch.PhysicianID.ToString()
                //                + "&FDate=" + phySch.PreviousOccurance.ToString()
                //                + "&Tdate=" + phySch.NextOccurance.ToString()
                                 
                //                + "'> <span style='color:yellow;'>"
                //                + phySch.PhysicianName + "</span><br><b><i>"
                //                + sTime + " to " + eTime + "</i></b><br> </a>";
                //}
            }
            else
            {
                if (phySch.ResourceType == "P")
                {
                    sch.Details = "<span style='color:black;'> Dr."
                                + phySch.PhysicianName + "</span><br><b><i>"
                                + sTime + " to " + eTime + "</i></b><br><span style='color:black;'> "
                                + phySch.SpecialityName + "</span>";
                }
                else
                {
                    sch.Details = "<span style='color:black;'>"
                                                   + phySch.PhysicianName + "</span><br><b><i>"
                                                   + sTime + " to " + eTime + "</i></b><br><span style='color:black;'>  </span>";
                }
                dayList.Add(sch);
            }
            //sch.Details = "<a href='#'><b>" + phySch.PhysicianName + "</b><br>" + phySch.SpecialityName + "<br><b><i>" + phySch.From.ToString() + " to " + phySch.To.ToString() + "</i></b></a>";
          
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
            get { return visitDate; }
            set { visitDate = value; }
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
        int  booked;
        long sID;

        public long ScheduleID
        {
            get { return sID; }
            set { sID = value; }
        }

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
            get { return details; }
            set { details = value; }
        }
        public int Booked
        {
            get { return booked; }
            set { booked = value; }
        }
        int totalSlots = 0;
        public int TotalSlots
        {
            get { return totalSlots; }
            set { totalSlots = value; }
        }

    }

    public void lNext_Click(object sender, EventArgs e)
    {
        hdnSpeciality.Value = ddlSpeciality.SelectedValue;
        Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
        List<PhysicianSchedule> daySchedule;
        List<WeekDayList> wkList = new List<WeekDayList>();

        lday1.Visible = false;
        rDay1.Visible = false;
        lday2.Visible = false;
        rDay2.Visible = false;
        lday3.Visible = false;
        rDay3.Visible = false;
        lday4.Visible = false;
        rDay4.Visible = false;
        rDay5.Visible = false;
        lday5.Visible = false;
        rDay6.Visible = false;
        lday6.Visible = false;

        divnoSchedules.Visible = true;
      
        int cnt = 0;

        if (LocationID == 0)
        {
            LocationID = ILocationID;
        }
           string lnkName = "";

          try
        {
            LinkButton lnkBtn = (LinkButton)sender;
            lnkName = lnkBtn.ID.ToString();
        }
        catch (Exception exp)
        {
            lnkName = "lnkWeek1";
            hdnWeek.Value = lnkWeek1.ID;
        }

          lnkName = currentweekSelect(lnkName);

          DateTime vDate = DateTime.Today;
          DateTime sFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
          DateTime sToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
         
          //if (lnkName == "lnkWeek1")
          if (lnkName == UsrlnkWeek1)
          {
            
              lnkWeek1.Font.Underline = true;
              lnkWeek2.Font.Underline = false;
              lnkWeek3.Font.Underline = false;
              lnkWeek4.Font.Underline = false;
              lnkWeek5.Font.Underline = false;
              lnkWeek6.Font.Underline = false;
              DateSelect(out sFromDate, out sToDate, lnkWeek1);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek1.ID;

          }
          else if (lnkName == UsrlnkWeek2)
          {
             // vDate = DateTime.Today.AddDays(6);
              lnkWeek1.Font.Underline = false;
              lnkWeek2.Font.Underline = true;
              lnkWeek3.Font.Underline = false;
              lnkWeek4.Font.Underline = false;
              lnkWeek5.Font.Underline = false;
              lnkWeek6.Font.Underline = false;
              DateSelect(out sFromDate, out sToDate, lnkWeek2);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek2.ID;
          }
          else if (lnkName == UsrlnkWeek3)
          {
              //vDate = DateTime.Today.AddDays(12);
              lnkWeek1.Font.Underline = false;
              lnkWeek2.Font.Underline = false;
              lnkWeek3.Font.Underline = true;
              lnkWeek4.Font.Underline = false;
              lnkWeek5.Font.Underline = false;
              lnkWeek6.Font.Underline = false;
              DateSelect(out sFromDate, out sToDate, lnkWeek3);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek3.ID;
          }
          else if (lnkName == UsrlnkWeek4)
          {
              //vDate = DateTime.Today.AddDays(18);
              lnkWeek1.Font.Underline = false;
              lnkWeek2.Font.Underline = false;
              lnkWeek3.Font.Underline = false;
              lnkWeek4.Font.Underline = true;
              lnkWeek5.Font.Underline = false;
              lnkWeek6.Font.Underline = false;
              DateSelect(out sFromDate, out sToDate, lnkWeek4);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek4.ID;
          }
          else if (lnkName == UsrlnkWeek5)
          {
              //vDate = DateTime.Today.AddDays(24);
              lnkWeek1.Font.Underline = false;
              lnkWeek2.Font.Underline = false;
              lnkWeek3.Font.Underline = false;
              lnkWeek4.Font.Underline = false;
              lnkWeek5.Font.Underline = true;
              lnkWeek6.Font.Underline = false;
              DateSelect(out sFromDate, out sToDate, lnkWeek5);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek5.ID;
          }
          else if (lnkName == UsrlnkWeek6)
          {
              //vDate = DateTime.Today.AddDays(30);
              lnkWeek1.Font.Underline = false;
              lnkWeek2.Font.Underline = false;
              lnkWeek3.Font.Underline = false;
              lnkWeek4.Font.Underline = false;
              lnkWeek5.Font.Underline = false;
              lnkWeek6.Font.Underline = true;
              DateSelect(out sFromDate, out sToDate, lnkWeek6);
              vDate = sFromDate;
              hdnWeek.Value = lnkWeek6.ID;
          }

        sBL.GetSchedules(0, TempOrgID, out pSchedules, out phySpeciality, LocationID, sFromDate, sToDate);

        int spid = 0;
        Int32.TryParse(hdnSpeciality.Value, out spid);
        

        for (int i = 1; i < 7; i++)
        {
            daySchedule = pSchedules.FindAll(delegate(PhysicianSchedule p)
            { return p.NextOccurance.CompareTo(vDate) == 0; });

            if (spid > 0)
            {
                daySchedule = (from dsh in daySchedule
                               join psy in phySpeciality
                               on dsh.PhysicianID equals psy.PhysicianID 
                               where psy.SpecialityID == spid
                               select dsh).ToList();
            }
            
            if (daySchedule.Count > 0)
            {
               
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
                            spName = spName + " / " + sp.SpecialityName;
                        spCnt++;
                    }
                    phy.SpecialityName = spName;
                }
                wkList.Add(BuildList(daySchedule, vDate));

            }
            var phySpec = (from sp in phySpeciality
                           orderby sp.SpecialityName ascending
                           select new { sp.SpecialityID, sp.SpecialityName }).Distinct();
            ddlSpeciality.DataSource = phySpec;
            ddlSpeciality.DataTextField = "SpecialityName";
            ddlSpeciality.DataValueField = "SpecialityID";
            ddlSpeciality.DataBind();
            ddlSpeciality.Items.Insert(0, new ListItem("--ALL--", "0"));
            vDate = vDate.AddDays(1);
        }
        ddlSpeciality.SelectedValue = spid.ToString();
        if (wkList.Count > 0)
        {
            foreach (WeekDayList wk in wkList)
            {
                tblHide.Visible = true;
                divnoSchedules.Visible = false;

                switch (cnt)
                {
                    case 0:
                        lday1.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay1.DataSource = wk.Visits;
                        rDay1.DataBind();
                        lday1.Visible = true;
                        rDay1.Visible = true;
                        //divnoSchedules.Visible = false;
                        break;
                    case 1:
                        lday2.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay2.DataSource = wk.Visits;
                        rDay2.DataBind();
                        lday2.Visible = true;
                        rDay2.Visible = true;
                        //divnoSchedules1.Visible = false;
                        break;
                    case 2:
                        lday3.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay3.DataSource = wk.Visits;
                        rDay3.DataBind();
                        lday3.Visible = true;
                        rDay3.Visible = true;
                        //divnoSchedules2.Visible = false;
                        break;
                    case 3:
                        lday4.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay4.DataSource = wk.Visits;
                        rDay4.DataBind();
                        lday4.Visible = true;
                        rDay4.Visible = true;
                        //divnoSchedules3.Visible = false;
                        break;
                    case 4:
                        rDay5.DataSource = wk.Visits;
                        rDay5.DataBind();
                        lday5.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay5.Visible = true;
                        lday5.Visible = true;
                        //divnoSchedules4.Visible = false;
                        break;
                    case 5:
                        rDay6.DataSource = wk.Visits;
                        rDay6.DataBind();
                        lday6.Text = wk.VisitDate.ToString("ddd dd MMM");
                        rDay6.Visible = true;
                        lday6.Visible = true;
                        //divnoSchedules5.Visible = false;
                        break;
                }
                cnt++;
            }
        }
        else
        {
            tblHide.Visible = true;

            lday1.Visible = false;
            rDay1.Visible = false;
            lday2.Visible = false;
            rDay2.Visible = false;
            lday3.Visible = false;
            rDay3.Visible = false;
            lday4.Visible = false;
            rDay4.Visible = false;
            rDay5.Visible = false;
            lday5.Visible = false;
            rDay6.Visible = false;
            lday6.Visible = false;

            divnoSchedules.Visible = true;
        }
        //if (BtnID != "")
        //{
            //HtmlAnchor ah = new HtmlAnchor();
            //ah = (HtmlAnchor)Parent.FindControl(BtnID);
            //ah.click();
            //ah.cl
            //this.Page.RegisterClientScriptBlock("ky", "<script language='javascript' >calldata();</script>"); 
        //}
    }

    private void DateLogic(out string WeekDate, int iLabeNo)
    {
        string sFromDate = "";
        string sToDate = "";

        sFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        sToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        string iMonth = hdnMonth.Value.ToString().Split('/')[0];
        DateTime dtMont = Convert.ToDateTime("01/" + hdnMonth.Value.ToString());
        //int iYear = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

        switch (iLabeNo)
        {
            case 1:
                sFromDate = "01/" + iMonth;
                sToDate = "06/" + iMonth;
                break;
            case 2:
                sFromDate = "07/" + iMonth;
                sToDate = "12/" + iMonth;
                break;
            case 3:
                sFromDate = "13/" + iMonth;
                sToDate = "18/" + iMonth;
                break;
            case 4:
                sFromDate = "19/" + iMonth;
                sToDate = "24/" + iMonth;
                break;
            case 5:
                sFromDate = "25/" + iMonth;
                sToDate = (new DateTime
                        (Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year, dtMont.Month, 1).AddMonths(1).AddDays(-1)).ToString("dd")
                        +"/"+ iMonth;

                if (Convert.ToInt32(sToDate.Split('/')[0]) > 30)
                {
                    sToDate = "30/" + iMonth;
                }

                break;

            case 6:
                 
                    sFromDate = (new DateTime
                            (Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year, dtMont.Month, 1).AddMonths(1).AddDays(-1)).ToString("dd")
                            + "/" + iMonth;
                    if ( Convert.ToInt32(sFromDate.Split('/')[0]) < 31)
                {
                    sFromDate = "";
                }
                        sToDate = sFromDate;

                break;
        }
        if (sFromDate == sToDate)
        {
            WeekDate = sFromDate;
        }
        else
        {
            WeekDate = sFromDate + " To " + sToDate;
        }
    }

    private void DateSelect(out DateTime sFromDate, out DateTime sTodate, LinkButton lnkButton)
    {
        string[] sFromnToDate = lnkButton.Text.ToLower().Replace("to", "~").Split('~');
        if (sFromnToDate.Length > 1)
        {
            sFromDate = Convert.ToDateTime(sFromnToDate[0].Split('/')[0] + "/" + hdnMonth.Value.ToString());
            int iCount = sFromnToDate[0].Split('/').Length;
            if (iCount > 1)
            {
                sTodate = Convert.ToDateTime(sFromnToDate[1].Split('/')[0] + "/" + hdnMonth.Value.ToString());
            }
            else
            {
                sTodate = sFromDate;
            }
        }
        else
        {
            sFromDate = Convert.ToDateTime(sFromnToDate[0].Split('/')[0] + "/" + hdnMonth.Value.ToString());
            sTodate = sFromDate;
        }
    }

    protected void btnRelated_Click(object sender, EventArgs e)
    {
        ((HiddenField)RelatedControl.FindControl(PreviousHiddenField)).Value = hdnSelectedID.Value;
        RelatedControl.DataBind();
        HtmlContainerControl htmCurrent = (HtmlContainerControl)Parent.FindControl(CurrentDIV);
        HtmlContainerControl htmNext = (HtmlContainerControl)Parent.FindControl(NextDIV);
        htmCurrent.Style.Remove("Display");
        htmNext.Style.Remove("Display");
        htmNext.Style.Add("Display","Block");
        htmCurrent.Style.Add("Display", "none");
        hdnSelectedID.Value = "";
    }
    private string currentweekSelect(string currentName)
    {
        string lnkName = "";
        HtmlInputButton hmbtn = new HtmlInputButton();
        hmbtn = (HtmlInputButton)Page.FindControl(hdnMonth.Value.ToString());
     //   hmbtn.Style.Add("class", "btnSel");
            if (hdnMonth.Value.Split('/')[0] == Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("MMM"))
            {
                //if (currentName == "lnkWeek1")
                //{
                    long sCurrDate = Convert.ToInt64(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd"));
                    if (sCurrDate >= 1 && sCurrDate <= 6)
                    {
                        if (currentName == "lnkWeek1")
                        {
                            hdnWeek.Value = lnkWeek1.ID.ToString();
                            lnkName = "lnkWeek1";
                        }
                        else
                        { lnkName = currentName; }

                    }
                    else if (sCurrDate >= 7 && sCurrDate <= 12)
                    {
                        if (currentName == "lnkWeek1")
                        {
                            hdnWeek.Value = lnkWeek2.ID.ToString();
                            lnkName = "lnkWeek2";
                        }
                        else
                        { lnkName = currentName; }
                    }
                    else if (sCurrDate >= 13 && sCurrDate <= 18)
                    {
                        if (currentName == "lnkWeek1" || currentName == "lnkWeek2")
                        {
                            hdnWeek.Value = lnkWeek3.ID.ToString();
                            lnkName = "lnkWeek3";
                        }
                        else
                        { lnkName = currentName; }
                    }
                    else if (sCurrDate >= 19 && sCurrDate <= 24)
                    {
                        if (currentName == "lnkWeek1" || currentName == "lnkWeek2" || currentName == "lnkWeek3")
                        {
                            hdnWeek.Value = lnkWeek4.ID.ToString();
                            lnkName = "lnkWeek4";
                        }
                        else
                        { lnkName = currentName; }
                    }
                    else if (sCurrDate >= 25 && sCurrDate <= 30)
                    {
                        if (currentName == "lnkWeek1" || currentName == "lnkWeek2" || currentName == "lnkWeek3"|| currentName == "lnkWeek4" )
                        {
                            hdnWeek.Value = lnkWeek5.ID.ToString();
                            lnkName = "lnkWeek5";
                        }
                        else
                        { lnkName = currentName; }
                    }
                    else if (sCurrDate == 31)
                    {
                        if (currentName == "lnkWeek1" || currentName == "lnkWeek2" || currentName == "lnkWeek3"|| currentName == "lnkWeek4" || currentName == "lnkWeek5")
                        {
                            hdnWeek.Value = lnkWeek6.ID.ToString();
                            lnkName = "lnkWeek6";
                        }
                        else
                        { lnkName = currentName; }
                    }
                //}
                //else
                //{ lnkName = currentName; }
                
            }
            else
            { lnkName = currentName; }
         
       return lnkName;
        //hdnWeek.Value
    }

   
    public void LoadMetaData()
    {
        string all = Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02 == null ? "--All--" : Resources.CommonControls_ClientDisplay.CommonControls_ClientSchedule_ascx_02;

        ddlSpeciality.Items.Insert(0, all);
        try
        {
            long returncode = 0;
            string domains = "Reminder";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }

            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {

                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Reminder"
                                 select child;
                ddlReminder.DataSource = childItems;
                ddlReminder.DataTextField = "DisplayText";
                ddlReminder.DataValueField = "Code";
                ddlReminder.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
        }
    }
   
}