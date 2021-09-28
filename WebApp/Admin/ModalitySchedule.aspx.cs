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

public partial class Modality_Schedule : BasePage
{

    public Modality_Schedule()
        : base("Admin_ModalitySchedule_aspx")
    {
    }

    public string orgID = string.Empty;
    int i = 0;
    int count = 0;
    bool flag = false;
    DayOfWeek dow;
    int currentDay;
    DateTime PrevOccur = new DateTime(1900, 01, 01);
    protected void Page_Load(object sender, EventArgs e)
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_DoctorsVacation_aspx_01 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_DoctorsVacation_aspx_01;
        try
        {
            btnSave.Attributes.Add("onClick", "return ValidateSchedule()");
            //ddlFrom.Attributes.Add("onchange", "sheduleTimeValidation('<%=ddlFrom.ClientID%>','ddlTo')");
            //ddlTo.Attributes.Add("onChange", "sheduleTimeValidation('ddlFrom','ddlTo')");
            //ddlTo.Attributes.Add("onblur", "return sheduleTimeValidation('ddlFrom','ddlTo')");
            //tDOB.Attributes.Add("onChange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,1);");
            if (!Page.IsPostBack)
            {
                //PhysicianSchedules();
                lblmindate.Text = DateTime.MinValue.ToString();
                lblmaxdate.Text = DateTime.MaxValue.ToString();
                LoadLocations();
                loadFromtime();
                loadTotime();
                loadMonths();
                LoadMetaData();

                tDOB.Text = OrgTimeZone;
                //chkDays.SelectedItem.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).DayOfWeek.ToString();
                ddlRepeat.Attributes.Add("onchange", "loadMonths()");

                Modality_BL ModalityBL = new Modality_BL(base.ContextInfo);
                List<Modality> lstModality = new List<Modality>();
                ModalityBL.GetModalityListByOrg(OrgID, out lstModality);
                if (lstModality.Count > 0)
                {
                    ddlModalityName.DataSource = lstModality;
                    ddlModalityName.DataTextField = "ModalityName";
                    ddlModalityName.DataValueField = "ModalityID";
                    ddlModalityName.DataBind();
                    //ddlModalityName.Items.Insert(0, "Select");
                    ddlModalityName.Items.Insert(0, strSelect);
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DoctorSchedule", ex);
        }

    }

    #region  Added from Jagatheeshkumar

    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "AdminDoctorScheduleSelect";
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
                var childItems2 = from child in lstmetadataOutputs
                                  where child.Domain == "AdminDoctorScheduleSelect"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddlRepeat.DataSource = childItems2;
                    ddlRepeat.DataTextField = "DisplayText";
                    ddlRepeat.DataValueField = "Code";
                    ddlRepeat.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    protected void ddlFrom_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    public void loadFromtime()
    {
        try
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while loadFromtime", ex);
        }
    }

    public void loadTotime()
    {
        try
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing loadTotime", ex);
        }
    }

    public void loadMonths()
    {
        try
        {
            for (i = 0; i < 30; i++)
            {
                ddlMonths.Items.Insert(i, (i + 1).ToString());
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loadMonths:", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strSave = Resources.Admin_AppMsg.Admin_ModalitySchedule_aspx_03 == null ? "Schedule saved Successfully" : Resources.Admin_AppMsg.Admin_ModalitySchedule_aspx_03;
        string strAlert=Resources.Admin_AppMsg.Admin_ModalitySchedule_aspx_Alert==null?"Alert":Resources.Admin_AppMsg.Admin_ModalitySchedule_aspx_Alert;
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

            sResource.OrgID = OrgID;
            sResource.ResourceID = Convert.ToInt64(ddlModalityName.SelectedValue);
            sResource.ResourceType = "M";
            sResource.CreatedBy = LID;
            sResource.OrgAddressID = Convert.ToInt32(ddlOrgLocation.SelectedValue);

            lstResource.Add(sResource);

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
            DateTime eTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
            scheduleTemp.StartTime = TimeSpan.Parse(sTime.ToShortTimeString());
            scheduleTemp.EndTime = TimeSpan.Parse(eTime.ToShortTimeString());
            scheduleTemp.SlotDuration = Convert.ToInt32(ddlDuration.SelectedItem.ToString());


            //add scheduletemplate to list
            lstSchedulreTemp.Add(scheduleTemp);

            Schedule_BL ScheduleBL = new Schedule_BL(base.ContextInfo);
            returnCode = ScheduleBL.InsertSchedules(lstRAbsolute, lstRR, lstSchedulreTemp, lstResource, lstSchedules, stid, rtid, RecurrenceID);
            if (returnCode == 0)
            {
                hdnSTID.Value = "0";
                hdnRTID.Value = "0";
                hdnRecurrenceID.Value = "0";
                hdnPRCylID.Value = "0";
                hdnRCylID.Value = "0";
                ddlModalityName.SelectedIndex = 0;
                ddlRepeat.SelectedIndex = 0;
                ddlModalityName_SelectedIndexChanged(sender, e);
            }
            GenerateSchedules();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Schedulestatus", "javascript:ValidationWindow('" + strSave + "','" + strAlert + "');", true);

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

        dow = Convert.ToDateTime(tDOB.Text).DayOfWeek;
        string[] dayNumber = null;

        try
        {
            //if (ddlRepeat.SelectedIndex == 1)
            //{
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
                currentDay = Convert.ToInt32(dow);
                recurrenceAbsolute.Value = Convert.ToString(currentDay);
            }
            //}

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
            if (ddlRepeat.SelectedIndex == 1)
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
            dow = Convert.ToDateTime(tDOB.Text).DayOfWeek;

            if (rdrptBy.Items[0].Selected)
            {
                recurrenceAbsolute = new RecurrenceAbsolute();
                recurrenceAbsolute.Unit = Convert.ToString(TaskHelper.unit.MD);
                currentDay = Convert.ToInt32(dow);
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
            ddlModalityName.SelectedIndex = 0;
            ddlModalityName_SelectedIndexChanged(sender, e);
            ddlDuration.SelectedIndex = 0;
            ddlFrom.SelectedIndex = 0;
            ddlTo.SelectedIndex = 0;
            ddlRepeat.SelectedIndex = 0;
            tDOB.Text = OrgTimeZone;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while executing lnkChange_Click()", ex);
        }
    }

    protected void PhysicianSchedules()
    {
        try
        {
            int iorgID = (int)OrgID;
            int iResourceID = 0;
            string PType = "M";
            Int32.TryParse(ddlModalityName.SelectedValue, out iResourceID);
            if (iResourceID > 0)
            {
                List<AllPhysicianSchedules> lstPhysicianSchedules = new List<AllPhysicianSchedules>();

                long lresult = new Physician_BL(base.ContextInfo).GetAllPhysicianSchedules(iorgID, iResourceID, PType, out lstPhysicianSchedules);
                if (lresult == 0)
                {
                    phyBooked.BindData(lstPhysicianSchedules);
                }
            }
            else
            {
                phyBooked.ClearData();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get PhysicianSchedules", ex);
        }

    }
    protected void ddlModalityName_SelectedIndexChanged(object sender, EventArgs e)
    {
        PhysicianSchedules();
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
            CLogger.LogError("Error while GenerateSchedules", ex);
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
        try
        {
            retval = taskBL.GetTaskLocationAndSpeciality(OrgID, RoleID, LID,"", out lstLocation, out lstSpeciality, out lstCategory, out taskProfile, out lstDept,out lstClient,out lstProtocal);

            ddlOrgLocation.DataSource = lstLocation;
            ddlOrgLocation.DataTextField = "Location";
            ddlOrgLocation.DataValueField = "AddressID";
            ddlOrgLocation.DataBind();
            ddlOrgLocation.SelectedValue = ILocationID.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadLocations", ex);
        }

    }

}






