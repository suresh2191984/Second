#region Namespace Decleration
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
#endregion

public partial class CommonControls_PhyBookedSchedule : BaseControl
{
    public CommonControls_PhyBookedSchedule()
        : base("CommonControls_PhyBookedSchedule_ascx")
    {
    }
    int iCount = 0;
    int ival = 0;
    List<AllPhysicianSchedules> lstDetails = new List<AllPhysicianSchedules>();

    public List<AllPhysicianSchedules> LstDetails
    {
        get { return lstDetails; }
        set { lstDetails = value; }
    }


    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    #endregion

    public void BindData(List<AllPhysicianSchedules> lstPhyDetails)
    {
        LstDetails = lstPhyDetails;
        rptSchedules.Visible = true;
        rptSchedules.DataSource = lstPhyDetails;
        rptSchedules.DataBind();
       // rptSchdeules_ItemdataBound();
    }
    public void ClearData()
    {
        rptSchedules.Visible = false;
    }

    protected string rptSchdeules_ItemdataBound()
    {
        string sSelected = "SelectedDatas('"+ lstDetails[iCount].NextOccurance.ToString("dd/MM/yyyy")
                                            + "','" + lstDetails[iCount].ScheduleTemplateID.ToString() 
                                            + "','" + lstDetails[iCount].ResourceTemplateID.ToString() 
                                            + "','" + lstDetails[iCount].RecurrenceID.ToString() 
                                            + "','" + lstDetails[iCount].ParentRecurrenceCycleID.ToString() 
                                            + "','" + lstDetails[iCount].RecurrenceCycleID.ToString() 
                                            + "','" + lstDetails[iCount].StartTime.ToString("hh:mm tt")
                                            + "','" + lstDetails[iCount].EndTime.ToString("hh:mm tt") 
                                            + "','" + lstDetails[iCount].SlotDuration.ToString() 
                                            + "','" + lstDetails[iCount].yEvery.ToString() 
                                            + "','" + lstDetails[iCount].mEvery.ToString() 
                                            + "','" + lstDetails[iCount].wEvery.ToString() 
                                            + "','" + lstDetails[iCount].yDateMonth.ToString() 
                                            + "','" + lstDetails[iCount].mDayofMonth.ToString() 
                                            + "','" + lstDetails[iCount].mDayofWeek.ToString() 
                                            + "','" + lstDetails[iCount].Sunday.ToString() 
                                            + "','" + lstDetails[iCount].Monday.ToString() 
                                            + "','" + lstDetails[iCount].Tuesday.ToString() 
                                            + "','" + lstDetails[iCount].Wednesday.ToString() 
                                            + "','" + lstDetails[iCount].Thursday.ToString() 
                                            + "','" + lstDetails[iCount].Friday.ToString() 
                                            + "','" + lstDetails[iCount].Saturday.ToString()
                                            + "','" + lstDetails[iCount].LocationID.ToString() 
                                            + "'); return false;";
         
        iCount++;
        return sSelected;
    }
    protected string rptDelete_ItemdataBound()
    {
        string sSelected = "deletedData('" + lstDetails[ival].ScheduleTemplateID.ToString()
                                            + "','" + lstDetails[ival].ResourceTemplateID.ToString()
                                            + "'); return false;";

        ival++;
        return sSelected;
    }
}