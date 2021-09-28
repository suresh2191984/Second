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

public partial class CommonControls_DoctorSchedule : BaseControl
{
    #region Variable Decleration
    protected string sFromDate = string.Empty;
    protected string sToDate = string.Empty;
    protected string sFromTime = string.Empty;
    protected string sToTime = string.Empty;
    protected string sResourceType = string.Empty;

    protected int iDoctorID = 0;
    protected int iTempDoctorID = 0;
    protected int i = 0;
    protected int j = 0;

    protected long lresult = -1;
    #endregion

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
         
    }
    #endregion

    #region BindDatas
    public void bindDatas()
    {
        sFromTime = ddlfromtime.SelectedItem.Text.Trim();
        sToTime = ddltotime.SelectedItem.Text.Trim();
        sFromDate = txtFrom.Text.Trim() + ' ' + sFromTime;
        sToDate = txtTo.Text.Trim() + ' ' + sToTime;
        if((divallPhysicians.Visible == true)&& (ddlPhysician.SelectedItem.Text == "--All--"))
        {
            iTempDoctorID = 0;
        }
        else if ((divallPhysicians.Visible == true) && (ddlPhysician.SelectedItem.Text != "--All--"))
        {
            iTempDoctorID = Int32.Parse(ddlPhysician.SelectedValue);
        }
        else
        {
            iTempDoctorID = IDoctorID;
        }

        Schedule_BL objScheduleBLL = new Schedule_BL(base.ContextInfo);
        List<DoctorSchedule> lstDoctorSchedule = new List<DoctorSchedule>();
    
        objScheduleBLL.GetDoctorsSchedule(OrgID, sFromDate, sToDate,iTempDoctorID , SResourceType, out lstDoctorSchedule);
        dlFloorMaster.DataSource = lstDoctorSchedule;
        dlFloorMaster.DataBind();
        if (lstDoctorSchedule.Count == 0)
        {
            lblNoData.Text = "No Schedules Available ";
        }
        else
        {
            lblNoData.Text = "";
        }
    }
    #endregion

    #region Load From Time
    public void loadFromTime()
    {
        DateTime df = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddltotime.Items.Insert(i, df.ToString("hh:mm.FF tt"));
            df = df.AddMinutes(30);
        }
    }
    #endregion

    #region Load To Time
    public void loadToTime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddlfromtime.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }
    #endregion

    #region Get DoctorID And Type
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

    #region Search Click
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if ((ddlPhysician.Items.Count > 0) && (IDoctorID != 0))
        {
            ddlPhysician.SelectedValue = IDoctorID.ToString();
        }
        bindDatas();
    }
    #endregion

    #region Filldatas
    public void filldatas()
    {
        txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Day.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Month.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Year.ToString();
        txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Day.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Month.ToString() + "/" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date.Year.ToString();
        loadToTime();
        loadFromTime();
        ddltotime.SelectedIndex = ddltotime.Items.Count - 1;
    }
    #endregion

    #region BindPhysicians
    public void bindDropDown()
    {

        Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician,0);
        if (lstPhysician.Count > 0)
        {
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
            ddlPhysician.Items.Insert(0, "--All--");
        }
         if ((Session["RoleName"].ToString().ToLower() == "Administrator")||(Session["RoleName"].ToString().ToLower() =="Receptionist"))
        {
            divallPhysicians.Visible = true;
        }
        else
        {
            divallPhysicians.Visible = false;
        }
    }
    #endregion

}
