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

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        BindMainData();
    }
    #endregion

    #region BuildList
    private List<SchList> BuildList(List<PhysicianSchedule> daySchedule)
    {
        List<SchList> dayList = new List<SchList>();
        
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
            sch.Details = "" + phySch.PhysicianName + "<br><i>" + sTime + " to " + eTime + "</b><br>"+phySch.NextOccurance.ToString("dd/MM/yyyy");
            sch.AllIds = "ChangeFrom('" + phySch.ResourceTemplateID.ToString() + "'," +
                                                    "'" + phySch.ScheduleID.ToString() + "'," +
                                                    "'" + phySch.PhysicianName.ToString() + "'," +
                                                    "'" + phySch.From.ToString() + "'," +
                                                    "'" + phySch.To.ToString() + "'," +
                                                    "'" + phySch.SpecialityName.ToString() + "'," +
                                                    "'" + phySch.NextOccurance.ToString("dd/MM/yyyy") + "');";
            sch.DelIds = "DeleteFrom('" + phySch.ResourceTemplateID.ToString() + "'," +
                                                    "'" + phySch.ScheduleID.ToString() + "'," +
                                                    "'" + phySch.PhysicianName.ToString() + "'," +
                                                    "'" + phySch.From.ToString() + "'," +
                                                    "'" + phySch.To.ToString() + "'," +
                                                    "'" + phySch.SpecialityName.ToString() + "'," +
                                                    "'" + phySch.NextOccurance.ToString("dd/MM/yyyy") + "');";
            dayList.Add(sch);
        }

        return dayList;
    }
    #endregion

    #region SchList
    private class SchList
    {
        long phyID;
        long RTID;
        string details;
        string allids;
        string delids;

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

        public string AllIds
        {
            get { return allids; }
            set { allids = value; }
        }

        public string DelIds
        {
            get { return delids; }
            set { delids = value; }
        }
    }
    #endregion

    #region Get DoctorID And Type
    protected int iDoctorID = 0;
    protected string sResourceType = string.Empty;

    public int IDoctorID
    {
        get
        {
            return iDoctorID;
        }
        set
        {
            iDoctorID = value;
        }
    }
    public string SResourceType
    {
        get
        {
            return sResourceType;
        }
        set
        {
            sResourceType = value;
        }
    }
    #endregion

    public void BindMainData()
    {
        Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();

        string sType = "";
        DateTime sFromDate = Convert.ToDateTime("1/1/1753 12:00:00 AM");
        DateTime sToDate = Convert.ToDateTime("1/1/1753 12:00:00 AM");

        sBL.GetSchedulesForEdit(IDoctorID, OrgID, out pSchedules, out phySpeciality, sType, sFromDate, sToDate,ILocationID);
        if (pSchedules.Count() > 0)
        {
            dlFloorMaster.DataSource = BuildList(pSchedules);
            dlFloorMaster.DataBind();
            NoData.Visible = false;
            YesData.Visible = true;
        }
        else
        {
            NoData.Visible = true;
            YesData.Visible = false;
        }
    }
}