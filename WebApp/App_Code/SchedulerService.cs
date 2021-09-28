using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Xml.Linq;
using Attune.Solution.DAL;
using Attune.Podium.SmartAccessor;
using System.Collections.Specialized;
using AjaxControlToolkit;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
/// <summary>
/// Summary description for SchedulerService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class SchedulerService :WebService
{

   const int OCCURANCECOUNT = 365;

   public SchedulerService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void MainSchedule()
    {
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        Schedule_BL objSchBL = new Schedule_BL(new BaseClass().ContextInfo);

        List<int> sTemplates = new List<int>();
        List<OrganizationAddress> lstOrganisation = new List<OrganizationAddress>();

       //long lresult = objSchBL.getOrganizations(out lstOrganisation);
        long lresult = objSchBL.getOrganizationAddress(out lstOrganisation);

        DateTime[] nxtOccurances = new DateTime[Int16.MaxValue];

        //foreach (OrganizationAddress orgVal in lstOrganisation)
        //{
        //    orgIds += orgVal.Comments.ToString() + ",";
        //}

        //orgIds = "12";
        int IorgID;
        int IOrgAddressID;
        DateTime nxtOccurance = DateTime.Today;
        try
        {
            foreach (OrganizationAddress orgVal in lstOrganisation)
            {
                Int32.TryParse(orgVal.Comments.Split('~')[0], out IorgID);
                Int32.TryParse(orgVal.Comments.Split('~')[1], out IOrgAddressID);

                pSchedules = GetResources(IorgID, IOrgAddressID);
                foreach (PhysicianSchedule pSch in pSchedules)
                {
                    sTemplates = GetScheduleTemplates(pSch.ResourceTemplateID, IorgID);
                    foreach (int sTID in sTemplates)
                    {
                        //if (pSch.NextOccurance.CompareTo(DateTime.Today) < 0)
                        //{
                        //    DeleteSchedule(pSch.ScheduleID);
                        //}
                         nxtOccurance = pSch.NextOccurance;
                        nxtOccurances = GetNxtOccurances(sTID, nxtOccurance);
                        SaveOccurances(nxtOccurances, pSch.ResourceTemplateID, nxtOccurance);

                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PhysicianSchedule> GetResources(int orgID, int OrgAddressID)
    {
        Schedule_BL sBL = new Schedule_BL(new BaseClass().ContextInfo);
        List<PhysicianSchedule> pSch = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> pSpl = new List<PhysicianSpeciality>();
        DateTime[] nxtOccurance = new DateTime[365];
        DateTime cOccruance = DateTime.Today;
        sBL.GetSchedules(0, orgID, out pSch, out pSpl, OrgAddressID, DateTime.Now.AddMonths(-3), DateTime.Now.AddYears(2));
        return pSch;
    }

    [WebMethod(EnableSession = true)]
    public List<int> GetScheduleTemplates(long resourceTemplateID, int orgID)
    {
        long retCode = -1;
        Schedule_BL schBL = new Schedule_BL(new BaseClass().ContextInfo);
        List<int> sTemplates = new List<int>();
        schBL.GetScheduleTemplates(resourceTemplateID, orgID, out sTemplates);
        return sTemplates;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public DateTime[] GetNxtOccurances(int scheduleTemplateID, DateTime occDate)
    {

        List<RecurrenceRelative> rrelative = new List<RecurrenceRelative>();
        List<RecurrenceAbsolute> rabsolute = new List<RecurrenceAbsolute>();
        Schedule_BL scheduleBL = new Schedule_BL(new BaseClass().ContextInfo);
        DateTime[] nxtOccurance = new DateTime[OCCURANCECOUNT];
        nxtOccurance = scheduleBL.GetNxtOccurances(scheduleTemplateID, occDate);
        return nxtOccurance;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveOccurances(DateTime[] nxtOccurance, long RTID, DateTime prevOccurance)
    {
        long returnCode = -1;
        Schedule_BL sBL = new Schedule_BL(new BaseClass().ContextInfo);
        Schedules schedule = new Schedules();
        schedule.ResourceTemplateID = RTID;
        schedule.Status = "A";
        schedule.CreatedBy = 1;
        schedule.PreviousOccurance = prevOccurance;
        foreach (DateTime nxtOcc in nxtOccurance)
        {
            if (nxtOcc > DateTime.MinValue)
            {
                schedule.NextOccurance = nxtOcc.Date;
                returnCode = sBL.SaveOccurances(schedule);
            }
        }
        return returnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long DeleteSchedule(long RTID)
    {
        long returnCode = -1;
        Schedule_BL sBL = new Schedule_BL(new BaseClass().ContextInfo);
        returnCode = sBL.DeleteSchedule(RTID);
        return returnCode;
    }
}

