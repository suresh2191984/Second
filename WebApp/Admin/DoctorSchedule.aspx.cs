using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Globalization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Serialization;
using System.IO;
using Attune.Podium.BillingEngine;
public partial class Admin_DoctorSchedule : BasePage
{

    public Admin_DoctorSchedule()
        : base("Admin_DoctorSchedule_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    public string orgID = string.Empty;
    int i = 0;
    int count = 0;
    bool flag = false;
    DayOfWeek dow;
    int currentDay;
    DateTime PrevOccur = new DateTime(1900, 01, 01);
    string Tab = string.Empty;
    string TabTable = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (IsPostBack)
            {
                Tab = hdnSelectedTab.Value;
                TabTable = hdnSelectedDiv.Value;
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "test", "javascript:ShowTabContentPostBack('" + Tab + "','" + TabTable + "');", true);

            }

            btnSave.Attributes.Add("onClick", "return ValidateSchedule()");
            hdnOrgID.Value = OrgID.ToString();
            if (!Page.IsPostBack)
            {

                LoadLocations();
                LoadMeatData();
                loadFromtime();
                loadTotime();
                loadMonths();
                GetGroupValues();
                // loadClient();
                tDOB.Text = OrgTimeZone;
                ddlRepeat.Attributes.Add("onchange", "loadMonths()");
                #region Inv-Schedule
                if (Request.QueryString["IsInvSched"] != null)
                {
                    long patientId = -1;
                    long patientVisitId = -1;
                    long InvestigationID = -1;
                    string InvName = string.Empty;
                    string IsInvSched = string.Empty;
                    string FType = string.Empty;

                    InvName = Request.QueryString["InvName"];
                    IsInvSched = Request.QueryString["IsInvSched"];
                    hdnIsInvSched.Value = IsInvSched;
                    if (Request.QueryString["Pvid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["Pvid"].ToString(), out patientVisitId);
                    }
                    if (Request.QueryString["Pid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["Pid"].ToString(), out patientId);
                    }
                    if (Request.QueryString["PInvId"] != null)
                    {
                        Int64.TryParse(Request.QueryString["PInvId"].ToString(), out InvestigationID);
                        HdnInvestigationID.Value = Convert.ToString(InvestigationID);
                    }
                    FType = Request.QueryString["FType"];

                    string rawdata = string.Empty;
                    rawdata = "Pvid" + "~" + patientId + "|" + "Pvid" + "~" + patientVisitId + "|" + "PInvId" + "~" + InvestigationID + "|" + "FType" + "~" + FType + "^";
                    Hdnrawdata.Value = rawdata;
                    //  trddlType.Attributes.Add("style", "display:none"); 





                }
                #endregion
                LoadInvGrpPkg();
                Loadphy();
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DoctorSchedule", ex);
        }

    }
    # region Jagatheesh added to Listbox items

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "AdminDoctorScheduleHrs,AdminDoctorScheduleSelect,AdminDoctorScheduleRadio,AdminDoctorScheduleWeekDays";
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
                                 where child.Domain == "AdminDoctorScheduleHrs"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDurationType.DataSource = childItems;
                    ddlDurationType.DataTextField = "DisplayText";
                    ddlDurationType.DataValueField = "Code";
                    ddlDurationType.DataBind();

                }
                var childItems1 = from child in lstmetadataOutputs
                                 where child.Domain == "AdminDoctorScheduleSelect"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    ddlRepeat.DataSource = childItems1;
                    ddlRepeat.DataTextField = "DisplayText";
                    ddlRepeat.DataValueField = "Code";
                    ddlRepeat.DataBind();
                    ddlRepeat.SelectedIndex = 0;
                }
                var childItems2 = from child in lstmetadataOutputs
                                  where child.Domain == "AdminDoctorScheduleRadio"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    rdrptBy.DataSource = childItems2;
                    rdrptBy.DataTextField = "DisplayText";
                    rdrptBy.DataValueField = "Code";
                    rdrptBy.DataBind();
                    
                }
                var childItems3 = from child in lstmetadataOutputs
                                  where child.Domain == "AdminDoctorScheduleWeekDays"
                                  select child;
                if (childItems3.Count() > 0)
                {
                    chkDays.DataSource = childItems3;
                    chkDays.DataTextField = "DisplayText";
                    chkDays.DataValueField = "Code";
                    chkDays.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }





    #endregion
    public void LoadInvGrpPkg()
    {

        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";

    }

    public void Loadphy()
    {

        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~";

    }

    public void loadClient()
    {

        long Returncode = -1;

        List<InvClientType> client = new List<InvClientType>();

        Returncode = new Patient_BL(base.ContextInfo).GetInvClientType(out client);

        if (client.Count > 0)
        {
            drpClientType.DataSource = client;
            drpClientType.DataTextField = "ClientTypeName";
            drpClientType.DataValueField = "ClientTypeID";
            drpClientType.DataBind();
            drpClientType.Items.Insert(0, "Select");

        }

    }



    public void loadFromtime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (i = 0; i < 48; i++)
        {
            ddlFrom.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }

    public void loadTotime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (i = 0; i < 48; i++)
        {
            ddlTo.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }

    public void loadMonths()
    {
        for (i = 0; i < 1; i++)
        {
            ddlMonths.Items.Insert(i, (i + 1).ToString());
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;

        try
        {
            List<RecurrenceRelative> lstRR = new List<RecurrenceRelative>();
            List<ScheduleTemplate> lstSchedulreTemp = new List<ScheduleTemplate>();
            List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();
            List<SchedulableResource> lstResource = new List<SchedulableResource>();
            List<Schedules> lstSchedules = new List<Schedules>();

            int stid = 0;
            int rtid = 0;
            int RecurrenceID = 0;
            int PRCylID = 0;
            int RCylID = 0;

            Int32.TryParse(hdnSTID.Value, out stid);
            Int32.TryParse(hdnRTID.Value, out rtid);
            Int32.TryParse(hdnRecurrenceID.Value, out RecurrenceID);
            Int32.TryParse(hdnPRCylID.Value, out PRCylID);
            Int32.TryParse(hdnRCylID.Value, out RCylID);

            RecurrenceRelative RRelative = new RecurrenceRelative();


            switch (Convert.ToInt32(ddlRepeat.SelectedValue.ToString()))
            {
                case 1:
                    RRelative.Type = Convert.ToString(TaskHelper.RelativeType.D);
                    lstRAbsolute = selectedDays();
                    break;
                case 2:
                    RRelative.Type = Convert.ToString(TaskHelper.RelativeType.W);
                    lstRAbsolute = selectedWeek();
                    break;
                case 3:
                    RRelative.Type = Convert.ToString(TaskHelper.RelativeType.M);
                    lstRAbsolute = selectedMonth();
                    break;
                case 4:
                    RRelative.Type = Convert.ToString(TaskHelper.RelativeType.Y);
                    lstRAbsolute = selectedYear();
                    break;
            }

            RRelative.Interval = Convert.ToInt32(ddlMonths.SelectedItem.ToString());

            //add recurence relative to recurrence list
            lstRR.Add(RRelative);




            #region scheduleResource


            SchedulableResource sResource = new SchedulableResource();

            if (Request.QueryString["IsInvSched"] != null && Request.QueryString["IsInvSched"] == "Y")
            {
                string xmlContent = string.Empty;
                sResource.OrgID = OrgID;
                sResource.ResourceID = Convert.ToInt64(HdnInvestigationID.Value);
                sResource.ResourceType = "I";
                sResource.CreatedBy = LID;
                sResource.OrgAddressID = Convert.ToInt32(ddlOrgLocation.SelectedValue);
                ConvertRawData(Hdnrawdata.Value, out xmlContent);
                sResource.AdditionalContextKey = xmlContent;
                lstResource.Add(sResource);
            }

            else if (Tab == "tabPhysician")
            {
                long PhysicianId = Convert.ToInt64(hdnPhyID.Value);

                sResource.OrgID = OrgID;
                sResource.ResourceID = PhysicianId;
                sResource.ResourceType = "P";
                sResource.CreatedBy = LID;
                sResource.OrgAddressID = Convert.ToInt32(ddlOrgLocation.SelectedValue);

                lstResource.Add(sResource);
            }

            else if (Tab == "tabClient")
            {
                long ClientId = Convert.ToInt64(hdnClientID.Value);
                sResource.OrgID = OrgID;
                sResource.ResourceID = ClientId;
                sResource.ResourceType = "C";
                sResource.CreatedBy = LID;
                sResource.OrgAddressID = Convert.ToInt32(ddlOrgLocation.SelectedValue);

                lstResource.Add(sResource);
            }
            else if (Tab == "tabInvestigation")
            {
                sResource.OrgID = OrgID;
                sResource.ResourceID = Convert.ToInt64(hdnInvID.Value);
                sResource.ResourceType = hdnInvType.Value;
                sResource.CreatedBy = LID;
                sResource.OrgAddressID = Convert.ToInt32(ddlOrgLocation.SelectedValue);
                lstResource.Add(sResource);
            }



            #endregion


            #region Schedules


            Schedules schedule = new Schedules();
            schedule.NextOccurance = Convert.ToDateTime(tDOB.Text);
            schedule.Status = "A";
            schedule.PreviousOccurance = PrevOccur;
            lstSchedules.Add(schedule);


            #endregion


            //create an object for schedule template
            ScheduleTemplate scheduleTemp = new ScheduleTemplate();
            DateTime sTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
            scheduleTemp.StartTime = TimeSpan.Parse(sTime.ToShortTimeString());

            int SlotDurationInMins = 0;
            if (txtDuration.Text != "")
            {
                if (ddlDurationType.SelectedValue == "Mins")
                {
                    SlotDurationInMins = Convert.ToInt32(txtDuration.Text);
                }
                if (ddlDurationType.SelectedValue == "Hours")
                {
                    SlotDurationInMins = Convert.ToInt32(txtDuration.Text) * 60;
                }
            }

            if (Request.QueryString["IsInvSched"] != null && Request.QueryString["IsInvSched"] == "Y")
            {
                DateTime eTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
                scheduleTemp.EndTime = TimeSpan.Parse(eTime.ToShortTimeString());
                scheduleTemp.SlotDuration = SlotDurationInMins; //Convert.ToInt32(ddlDuration.SelectedItem.ToString());
            }
            if (Tab == "tabPhysician")
            {
                DateTime eTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
                scheduleTemp.EndTime = TimeSpan.Parse(eTime.ToShortTimeString());
                scheduleTemp.SlotDuration = SlotDurationInMins;// Convert.ToInt32(SlotDurationInMins.SelectedItem.ToString());
            }
            if (Tab == "tabInvestigation")
            {

                DateTime eTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
                scheduleTemp.EndTime = TimeSpan.Parse(eTime.ToShortTimeString());
                scheduleTemp.SlotDuration = SlotDurationInMins;

            }

            if (Tab == "tabClient")
            {
                scheduleTemp.EndTime = TimeSpan.Parse(sTime.ToShortTimeString()).Add(TimeSpan.FromMinutes(30));
                scheduleTemp.SlotDuration = 30;
            }
            //add scheduletemplate to listhttps://www.register.prometric.com/DateTime.asp
            lstSchedulreTemp.Add(scheduleTemp);

            Schedule_BL ScheduleBL = new Schedule_BL(base.ContextInfo);
            returnCode = ScheduleBL.InsertSchedules(lstRAbsolute, lstRR, lstSchedulreTemp, lstResource, lstSchedules, stid, rtid, RecurrenceID);
            if (returnCode >= 0)
            {
                hdnSTID.Value = "0";
                hdnRTID.Value = "0";
                hdnRecurrenceID.Value = "0";
                hdnPRCylID.Value = "0";
                hdnRCylID.Value = "0";
                txtDuration.Text = "";
                ddlDurationType.SelectedIndex = -1;
                ddlFrom.SelectedIndex = -1;
                ddlTo.SelectedIndex = -1;
                ddlRepeat.SelectedIndex = 0;
                foreach (ListItem li in chkDays.Items)
                {
                    li.Selected = false;
                }
                foreach (ListItem li in rdrptBy.Items)
                {
                    li.Selected = false;
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ClosePopUp('Scheduled Successfully');", true);
                ddlMonths.SelectedIndex = -1;

            }
            GenerateSchedules();
            if (Tab == "tabClient")
            {
                ClientSchedules();
            }
            if (Tab == "tabInvestigation")
            {

                InvSchedules();

            }
            if (Tab == "tabPhysician")
            {

                PhysicianSchedules();
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "test", "javascript:ShowTabContent('" + Tab + "','" + TabTable + "');", true);

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

    public List<RecurrenceAbsolute> selectedDays()
    {
        //create an object for RecurrenceAbsolute
        RecurrenceAbsolute recurrenceAbsolute = new RecurrenceAbsolute();
        List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();

        int day = Convert.ToDateTime(tDOB.Text).Day;
        string[] dayNumber = null;

        try
        {
            if (Convert.ToInt32(ddlRepeat.SelectedValue) == 1)
            {
                int iCount = 0;
                Int32.TryParse(ddlMonths.SelectedValue.ToString(), out iCount);
                dayNumber = new string[chkDays.Items.Count];

                for (int i = 0; i < chkDays.Items.Count; i++)
                {
                    if (chkDays.Items[i].Selected)
                    {
                        flag = true;
                        switch (i)
                        {
                            case 0:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Sunday).ToString();
                                break;
                            case 1:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Monday).ToString();
                                break;
                            case 2:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Tuesday).ToString();
                                break;
                            case 3:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Wednesday).ToString();
                                break;
                            case 4:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Thursday).ToString();
                                break;
                            case 5:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Friday).ToString();
                                break;
                            case 6:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Saturday).ToString();
                                break;
                        }
                    }
                }


                if (flag)
                {
                    for (i = 0; i < dayNumber.Length; i++)
                    {

                        if (dayNumber[i] != null)
                        {
                            if (count == 0)
                            {
                                recurrenceAbsolute.Value = dayNumber[i];
                                count++;
                            }
                            else
                            {
                                recurrenceAbsolute.Value = recurrenceAbsolute.Value + "," + dayNumber[i];
                            }
                        }
                    }
                }
                else
                {
                    currentDay = Convert.ToInt32(day);
                    recurrenceAbsolute.Value = Convert.ToString(currentDay);
                }
            }

            recurrenceAbsolute.Unit = "DD";//Convert.ToString(TaskHelper.unit.WD);
            lstRAbsolute.Add(recurrenceAbsolute);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing selected week", ex);
        }

        return lstRAbsolute;
    }


    public List<RecurrenceAbsolute> selectedWeek()
    {
        //create an object for RecurrenceAbsolute
        RecurrenceAbsolute recurrenceAbsolute = new RecurrenceAbsolute();
        List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();




        dow = Convert.ToDateTime(tDOB.Text).DayOfWeek;
        string[] dayNumber = null;

        try
        {
            if (ddlRepeat.SelectedIndex == 2)
            {
                dayNumber = new string[chkDays.Items.Count];

                for (int i = 0; i < chkDays.Items.Count; i++)
                {
                    if (chkDays.Items[i].Selected)
                    {
                        flag = true;
                        switch (i)
                        {
                            case 0:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Sunday).ToString();
                                break;
                            case 1:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Monday).ToString();
                                break;
                            case 2:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Tuesday).ToString();
                                break;
                            case 3:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Wednesday).ToString();
                                break;
                            case 4:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Thursday).ToString();
                                break;
                            case 5:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Friday).ToString();
                                break;
                            case 6:
                                dayNumber[i] = Convert.ToInt32(DayOfWeek.Saturday).ToString();
                                break;
                        }
                    }
                }


                if (flag)
                {
                    for (i = 0; i < dayNumber.Length; i++)
                    {

                        if (dayNumber[i] != null)
                        {
                            if (count == 0)
                            {
                                recurrenceAbsolute.Value = dayNumber[i];
                                count++;
                            }
                            else
                            {
                                recurrenceAbsolute.Value = recurrenceAbsolute.Value + "," + dayNumber[i];
                            }
                        }
                    }
                }
                else
                {
                    currentDay = Convert.ToInt32(dow);
                    recurrenceAbsolute.Value = Convert.ToString(currentDay);
                }
            }

            recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.WD);
            lstRAbsolute.Add(recurrenceAbsolute);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing selected week", ex);
        }

        return lstRAbsolute;
    }


    public List<RecurrenceAbsolute> selectedMonth()
    {

        //create an object for RecurrenceAbsolute
        RecurrenceAbsolute recurrenceAbsolute = new RecurrenceAbsolute();
        List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();

        try
        {
            int day = Convert.ToDateTime(tDOB.Text).Day;
            dow = Convert.ToDateTime(tDOB.Text).DayOfWeek;

            if (rdrptBy.Items[0].Selected)
            {
                recurrenceAbsolute = new RecurrenceAbsolute();
                recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.MD);
                currentDay = Convert.ToInt32(day);
                recurrenceAbsolute.Value = Convert.ToString(currentDay);
                lstRAbsolute.Add(recurrenceAbsolute);

            }
            else
            {
                recurrenceAbsolute = new RecurrenceAbsolute();
                recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.WN);
                currentDay = Convert.ToInt32(dow);
                recurrenceAbsolute.Value = GetWeekNumber();
                lstRAbsolute.Add(recurrenceAbsolute);

                recurrenceAbsolute = new RecurrenceAbsolute();
                recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.WD);
                currentDay = Convert.ToInt32(dow);
                recurrenceAbsolute.Value = Convert.ToString(currentDay);
                lstRAbsolute.Add(recurrenceAbsolute);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing selected month()", ex);
        }

        return lstRAbsolute;
    }


    public List<RecurrenceAbsolute> selectedYear()
    {
        //create an object for RecurrenceAbsolute
        RecurrenceAbsolute recurrenceAbsolute = new RecurrenceAbsolute();
        List<RecurrenceAbsolute> lstRAbsolute = new List<RecurrenceAbsolute>();

        try
        {

            int month = Convert.ToDateTime(tDOB.Text).Month;
            dow = Convert.ToDateTime(tDOB.Text).DayOfWeek;

            recurrenceAbsolute = new RecurrenceAbsolute();
            recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.MN);
            recurrenceAbsolute.Value = Convert.ToString(month);
            lstRAbsolute.Add(recurrenceAbsolute);

            recurrenceAbsolute = new RecurrenceAbsolute();
            recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.WD);
            currentDay = Convert.ToInt32(dow);
            recurrenceAbsolute.Value = Convert.ToString(currentDay);
            lstRAbsolute.Add(recurrenceAbsolute);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing selectedYear()", ex);
        }

        return lstRAbsolute;

    }


    public string GetWeekNumber()
    {
        string week = string.Empty;

        try
        {
            switch (weekNo.Value)
            {
                case "First":
                    week = Convert.ToInt32(TaskHelper.weekNumber.First).ToString();
                    break;

                case "Second":
                    week = Convert.ToInt32(TaskHelper.weekNumber.Second).ToString();
                    break;

                case "Third":
                    week = Convert.ToInt32(TaskHelper.weekNumber.Third).ToString();
                    break;

                case "Fourth":
                    week = Convert.ToInt32(TaskHelper.weekNumber.Fourth).ToString();
                    break;

                case "Fifth":
                    week = Convert.ToInt32(TaskHelper.weekNumber.Fifth).ToString();
                    break;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetWeek()", ex);
        }
        return week;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetWeek()", ex);
        }
    }
    protected void lnkChange_Click(object sender, EventArgs e)
    {
        try
        {
            hdnSTID.Value = "0";
            hdnRTID.Value = "0";
            hdnRecurrenceID.Value = "0";
            hdnPRCylID.Value = "0";
            hdnRCylID.Value = "0";

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing lnkChange_Click()", ex);
        }
    }

    protected void PhysicianSchedules()
    {
        int iorgID = (int)OrgID;
        int iResourceID = 0;
        string PhyType = "P";

        Int32.TryParse(hdnPhyID.Value, out iResourceID);
        if (iResourceID > 0)
        {
            List<AllPhysicianSchedules> lstPhysicianSchedules = new List<AllPhysicianSchedules>();

            long lresult = new Physician_BL(base.ContextInfo).GetAllPhysicianSchedules(iorgID, iResourceID, PhyType, out lstPhysicianSchedules);
            if (lstPhysicianSchedules.Count > 0)
            {
                phyBooked.BindData(lstPhysicianSchedules);
               // btnSave.Enabled = false;
            }
            else
            {
                phyBooked.ClearData();
              //  btnSave.Enabled = true;
            }

        }
        else
        {
            phyBooked.ClearData();
        }




    }


    protected void ClientSchedules()
    {
        int iorgID = (int)OrgID;
        int iResourceID = 0;
        string PhyType = "C";

        Int32.TryParse(hdnClientID.Value, out iResourceID);
        if (iResourceID > 0)
        {
            List<AllPhysicianSchedules> lstPhysicianSchedules = new List<AllPhysicianSchedules>();

            long lresult = new Physician_BL(base.ContextInfo).GetAllPhysicianSchedules(iorgID, iResourceID, PhyType, out lstPhysicianSchedules);
            if (lstPhysicianSchedules.Count > 0)
            {
                phyBooked.BindData(lstPhysicianSchedules);
              //  btnSave.Enabled = false;
            }
            else
            {
                phyBooked.ClearData();
             //   btnSave.Enabled = true;
            }

        }
        else
        {
            phyBooked.ClearData();
        }




    }


    protected void InvSchedules()
    {
        int iorgID = (int)OrgID;
        int iResourceID = 0;
        string PhyType = hdnInvType.Value;
        Int32.TryParse(hdnInvID.Value, out iResourceID);
        if (iResourceID > 0)
        {
            List<AllPhysicianSchedules> lstPhysicianSchedules = new List<AllPhysicianSchedules>();

            long lresult = new Physician_BL(base.ContextInfo).GetAllPhysicianSchedules(iorgID, iResourceID, PhyType, out lstPhysicianSchedules);
            if (lstPhysicianSchedules.Count > 0)
            {
                phyBooked.BindData(lstPhysicianSchedules);
               // btnSave.Enabled = false;
            }
            else
            {
                phyBooked.ClearData();
              //  btnSave.Enabled = true;
            }

        }
        else
        {
            phyBooked.ClearData();
        }




    }




    protected void GenerateSchedules()
    {
        string orgIds = string.Empty;


        ScheduleGenerator schGen = new ScheduleGenerator();
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        Schedule_BL objSchBL = new Schedule_BL(base.ContextInfo);

        List<int> sTemplates = new List<int>();
        List<Organization> lstOrganisation = new List<Organization>();

        long lresult = objSchBL.getOrganizations(out lstOrganisation);

        DateTime[] nxtOccurances = new DateTime[Int16.MaxValue];

        foreach (Organization orgVal in lstOrganisation)
        {
            orgIds += orgVal.OrgID.ToString() + ",";
        }

        //orgIds = "12";
        int IorgID;
        DateTime nxtOccurance = DateTime.Today;
        try
        {
            foreach (string orgID in orgIds.Split(','))
            {
                Int32.TryParse(orgID, out IorgID);
                pSchedules = schGen.GetResources(IorgID, ILocationID);
                foreach (PhysicianSchedule pSch in pSchedules)
                {
                    sTemplates = schGen.GetScheduleTemplates(pSch.ResourceTemplateID, IorgID);
                    foreach (int sTID in sTemplates)
                    {
                        if (pSch.NextOccurance.CompareTo(DateTime.Today) < 0)
                        {
                            schGen.DeleteSchedule(pSch.ScheduleID);
                        }
                        nxtOccurance = pSch.NextOccurance;
                        nxtOccurances = schGen.GetNxtOccurances(sTID, nxtOccurance);
                        schGen.SaveOccurances(nxtOccurances, pSch.ResourceTemplateID, nxtOccurance);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }

    protected void LoadLocations()
    {
        long retval = -1;

        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<TaskActions> lstCategory = new List<TaskActions>();
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        List<ClientMaster> lstClient = new List<ClientMaster>();
        List<MetaData> lstProtocal = new List<MetaData>();
        TaskProfile taskProfile = new TaskProfile();
        retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID,"", out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept, out lstClient,out lstProtocal);

        ddlOrgLocation.DataSource = lstLocation;
        ddlOrgLocation.DataTextField = "Location";
        ddlOrgLocation.DataValueField = "AddressID";
        ddlOrgLocation.DataBind();
        ddlOrgLocation.SelectedValue = ILocationID.ToString();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long stid = 0;
        long rtid = 0;
        Int64.TryParse(hdnSTID.Value, out stid);
        Int64.TryParse(hdnRTID.Value, out rtid);

        Schedule_BL schBL = new Schedule_BL(base.ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        schBL.DeletePhysicianSchedule(stid, rtid);
        hdnSTID.Value = "0";
        hdnRTID.Value = "0";
        hdnRecurrenceID.Value = "0";
        hdnPRCylID.Value = "0";
        hdnRCylID.Value = "0";

        ddlRepeat.SelectedIndex = 0;

    }

    public void ConvertRawData(string rawdata, out string xmlContent)
    {
        xmlContent = string.Empty;
        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("InvSchedules");
                string[] CatagoryAgeMain = rawdata.Split('^');
                for (int i = 0; i < CatagoryAgeMain.Length; i++)
                {
                    xw.WriteStartElement("InvSchedule");
                    foreach (string O in CatagoryAgeMain[i].Split('|'))
                    {
                        if (O != string.Empty)
                        {
                            xw.WriteStartElement(O.Split('~')[0]);
                            xw.WriteString(O.Split('~')[1]);
                            xw.WriteEndElement();
                        }
                    }
                    xw.WriteEndElement();
                }
                xw.WriteEndElement();
                xw.WriteEndDocument();
                xw.Close();
            }
            xmlContent = sw.ToString();
        }
    }
    protected void drpClientType_SelectedIndexChanged(object sender, EventArgs e)
    {

        phyBooked.ClearData();

        if (drpClientType.SelectedItem.Text == "Select")
        {
            txtclient.Enabled = false;
        }
        else
        {
            txtclient.Enabled = true;
            int ClientTypeID = 0;
            int CustomerTypeID = Convert.ToInt32(drpClientType.SelectedValue.ToString());
            AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + ClientTypeID.ToString() + "~" + CustomerTypeID.ToString();
            txtclient.Focus();
            txtclient.Text = "";

        }

    }
    protected void txtNew_TextChanged(object sender, EventArgs e)
    {

        PhysicianSchedules();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:loadMonths()", true);
    }
    protected void txtTestName_TextChanged(object sender, EventArgs e)
    {
        InvSchedules();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:loadMonths();clearfn();", true);
    }
    protected void txtclient_TextChanged(object sender, EventArgs e)
    {
        ClientSchedules();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:loadMonths()", true);

    }

    public void GetGroupValues()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstmetavalue.Count > 0)
            {
                string setID = "0";
                lstmetavalue.RemoveAll(p => p.Code != "BT");

                drpClientType.DataSource = lstmetavalue;
                drpClientType.DataTextField = "Value";
                drpClientType.DataValueField = "MetaValueID";
                drpClientType.DataBind();
                drpClientType.Items.Insert(0, "--Select--");
                drpClientType.Items[0].Value = "0";
                drpClientType.SelectedValue = setID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
}





