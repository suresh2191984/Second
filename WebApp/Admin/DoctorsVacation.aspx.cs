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
        : base("Admin_DoctorsVacation_aspx")
    {
    }

    #region PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_DoctorsVacation_aspx_011 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_DoctorsVacation_aspx_011;
        try
        {
            //btnSave.Attributes.Add("onClick", "return ValidateSchedule()");
            tDOB.Attributes.Add("onChange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,1);");
            txtToDate.Attributes.Add("onChange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,1);");
            if (!Page.IsPostBack)
            {
                
                Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
                List<Physician> lstPhysician = new List<Physician>();
                PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician,0);
                if (lstPhysician.Count > 0)
                {
                    ddlDrName.DataSource = lstPhysician;
                    ddlDrName.DataTextField = "PhysicianName";
                    ddlDrName.DataValueField = "PhysicianID";
                    ddlDrName.DataBind();
                    //ddlDrName.Items.Insert(0, new ListItem("--Select--", "0"));
                    ddlDrName.Items.Insert(0, new ListItem(strSelect, "0"));
                }
                int iDocID = 0;
                Int32.TryParse(ddlDrName.SelectedValue, out iDocID);

                tDOB.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DoctorSchedule", ex);
        }

    }
    #endregion

    

    #region CancelClick
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx", true);
    }
    #endregion

    protected void btnModify_Click(object sender, EventArgs e)
    {
        int VacationID = 0;

        Int32.TryParse(hdnVacationID.Value.ToString(), out VacationID);


        int PhysicianID = 0;
        DateTime Fromdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string CancelledSchedules = "";
        string Status = "";
        Schedule_BL objSchBL = new Schedule_BL(base.ContextInfo);


        Int32.TryParse(ddlDrName.SelectedValue.ToString(), out PhysicianID);
        DateTime.TryParse(tDOB.Text, out Fromdate);
        DateTime.TryParse(txtToDate.Text, out ToDate);
        Status = "LEAVE";

        foreach (DataListItem itm in dlSchedules.Items)
        {
            Label lblScheduleID = new Label();
            lblScheduleID = (Label)itm.FindControl("lblSID");

            CancelledSchedules += lblScheduleID.Text.Trim() + ",";
        }

        objSchBL.InsertVacation(VacationID, PhysicianID, Fromdate, ToDate, CancelledSchedules,
                                Status,Convert.ToInt32(LID));

        bindDatas();

    }

    #region BindDatas
    public void bindDatas()
    {
        string sFromDate = "";
        sFromDate = tDOB.Text;
        string SType = "DateCheck";
        string sToDate = txtToDate.Text;
        int IDoctorID = 0;

        Int32.TryParse(ddlDrName.SelectedValue.ToString(), out IDoctorID);

        Schedule_BL objScheduleBLL = new Schedule_BL(base.ContextInfo);
        List<DoctorSchedule> lstDoctorSchedule = new List<DoctorSchedule>();
        List<PhysicianSchedule> pSchedules = new List<PhysicianSchedule>();
        List<PhysicianSpeciality> phySpeciality = new List<PhysicianSpeciality>();
        List<PhysicianVacationDetails> lstPhyVacation = new List<PhysicianVacationDetails>();

        objScheduleBLL.GetPhysicianVacations(IDoctorID, OrgID, out pSchedules, 
                                                out phySpeciality, SType, Convert.ToDateTime(sFromDate), 
                                                Convert.ToDateTime(sToDate), out lstDoctorSchedule, 
                                                out lstPhyVacation);
        if (lstDoctorSchedule.Count > 0)
        {
            dlBookedSlots.DataSource = lstDoctorSchedule;
            dlBookedSlots.DataBind();
            dlBookedSlots.Visible = true;
            dvBookedSlots.Visible = true;
        }
        else
        {
            dlBookedSlots.Visible = false;
            dvBookedSlots.Visible = false;
        }
       
        if (pSchedules.Count > 0)
        {
            dlSchedules.DataSource = pSchedules;
            dlSchedules.DataBind();
            dlSchedules.Visible = true;
            dvSchedules.Visible = true;
        }
        else
        {
            dlSchedules.Visible = false;
            dvSchedules.Visible = false;
        }
        if (lstPhyVacation.Count > 0)
        {
            gvPhyVacation.DataSource = lstPhyVacation;
            gvPhyVacation.DataBind();
            gvPhyVacation.Visible = true;
            dvAdvancePayments.Visible = true;
        }
        else
        {
            gvPhyVacation.Visible = false;
            dvAdvancePayments.Visible = false;
        }
        if (dvBookedSlots.Visible == false && dvSchedules.Visible == false && gvPhyVacation.Visible == false)
        {
            divError.Visible = true;
        }
        else
        {
            divError.Visible = false;
        }

        if (dvSchedules.Visible == true)
        {
            btnSave.Enabled = true;

        }
        else
        {
            btnSave.Enabled = false;
        }

        //btnSave
    }
    #endregion

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindDatas();
       
    }
    protected void gvPhyVacation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
    }
    protected void gvPhyVacation_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string sType = e.CommandName.ToString();
        string selID = gvPhyVacation.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[0].Text.ToString();
        hdnVacationID.Value = selID;
        if (sType == "Select")
        {
            tDOB.Text = gvPhyVacation.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[2].Text.ToString();
            txtToDate.Text = gvPhyVacation.Rows[Convert.ToInt32(e.CommandArgument.ToString())].Cells[3].Text.ToString();
        }
        else if (sType == "Delete")
        {
            Schedule_BL objSchBL = new Schedule_BL(base.ContextInfo);
            int iVacID = 0;
            Int32.TryParse(hdnVacationID.Value.ToString(), out iVacID);
            objSchBL.UpdatePhysicianVacation(iVacID, Convert.ToInt32(LID));
            bindDatas();
        }

    }
    protected void gvPhyVacation_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
    }
}






