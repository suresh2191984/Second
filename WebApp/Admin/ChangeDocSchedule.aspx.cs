#region Namespace
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
#endregion


public partial class Admin_ChangeDocSchedule : BasePage
{
    public Admin_ChangeDocSchedule()
        : base("Admin_ChangeDocSchedule_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #region Varialble Decleration
    public string orgID = string.Empty;
    int i = 0;
    int count = 0;
    bool flag = false;
    DayOfWeek dow;
    int currentDay;
    DateTime PrevOccur = new DateTime(1900, 01, 01);
    string strddlRoleName = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_05 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_05;
    #endregion

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //btnSave.Attributes.Add("onClick", "return ValidateSchedule()");
            //ddlFrom.Attributes.Add("onchange", "sheduleTimeValidation('<%=ddlFrom.ClientID%>','ddlTo')");
            //ddlTo.Attributes.Add("onChange", "sheduleTimeValidation('ddlFrom','ddlTo')");
            //ddlTo.Attributes.Add("onblur", "return sheduleTimeValidation('ddlFrom','ddlTo')");
            //tDOB.Attributes.Add("onChange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,1);");
            if (!Page.IsPostBack)
            {
                loadFromtime();
                loadTotime();
                LoadMeatData();

                Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
                List<Physician> lstPhysician = new List<Physician>();
                PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
                if (lstPhysician.Count > 0)
                {
                    var lstphy = (from phy in lstPhysician select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
                    ddlDrName.DataSource = lstphy;
                    //ddlDrName.DataSource = lstPhysician;
                    ddlDrName.DataTextField = "PhysicianName";
                    ddlDrName.DataValueField = "PhysicianID";
                    ddlDrName.DataBind();
                    ddlDrName.Items.Insert(0, strddlRoleName);
                    ddlDrName.Items.Insert(1, new ListItem("-----All-----", "1"));
                   
                }
                int iDocID = 0;
                Int32.TryParse(ddlDrName.SelectedValue, out iDocID);
                //ucBookedSchedules.IDoctorID = iDocID;
                //ucBookedSchedules.BindMainData();
                //ucBookedSchedules.BindSchedule_Datas();


                txtOriginalDate.ReadOnly = true;
                txtPhyName.ReadOnly = true;
                txtPhySpeciality.ReadOnly = true;
                txtSchTime.ReadOnly = true;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DoctorSchedule", ex);
        }

    }
    #endregion

    #region FromTime
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
    #endregion

    #region ToTime
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
    #endregion

    #region CancelClick
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx", true);
    }
    #endregion

    #region ddlDrName_SelectedIndexChanged
    protected void ddlDrName_SelectedIndexChanged(object sender, EventArgs e)
    {
        int iDocID = 0;
        Int32.TryParse(ddlDrName.SelectedValue, out iDocID);
        ucBookedSchedules.IDoctorID = iDocID;
        ucBookedSchedules.BindMainData();
        //ucBookedSchedules.BindSchedule_Datas();

    }
    #endregion
    protected void btnModify_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long ScheduleTemplateID = Convert.ToInt64(hdnRtid.Value.ToString());
        long ScheduleID = Convert.ToInt64(hdnSID.Value.ToString());
        DateTime DateOfChange = Convert.ToDateTime(tDOB.Text.Trim());
        DateTime StartTime = Convert.ToDateTime(ddlFrom.SelectedItem.Text);
        DateTime EndTime = Convert.ToDateTime(ddlTo.SelectedItem.Text); ;
        int SlotDuration = Convert.ToInt32(ddlDuration.SelectedValue.ToString());

        Schedule_BL ScheduleBL = new Schedule_BL(base.ContextInfo);
        returnCode = ScheduleBL.SaveExceptionSchedule(ScheduleTemplateID, ScheduleID, DateOfChange, StartTime, EndTime, SlotDuration, Convert.ToInt32(LID));

        int iDocID = 0;
        Int32.TryParse(ddlDrName.SelectedValue, out iDocID);
        ucBookedSchedules.IDoctorID = iDocID;
        ucBookedSchedules.BindMainData();
        //ucBookedSchedules.BindSchedule_Datas();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        int ScheduleID = 0;
        Int32.TryParse(hdnSID.Value, out ScheduleID);

        Schedule_BL ScheduleBL = new Schedule_BL(base.ContextInfo);
        returnCode = ScheduleBL.UpdateindSchedules(ScheduleID);

        int iDocID = 0;
        Int32.TryParse(ddlDrName.SelectedValue, out iDocID);
        ucBookedSchedules.IDoctorID = iDocID;
        ucBookedSchedules.BindMainData();
        //ucBookedSchedules.BindSchedule_Datas();
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "duration";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "duration"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDuration.DataSource = childItems;
                    ddlDuration.DataTextField = "DisplayText";
                    ddlDuration.DataValueField = "Code";
                    ddlDuration.DataBind();




                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
}






