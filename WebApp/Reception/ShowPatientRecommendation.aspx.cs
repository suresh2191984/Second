using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;
using System.Web.UI.HtmlControls;

public partial class Reception_ShowPatientRecommendation : BasePage 
{
    PatientVisit Patient = new PatientVisit();
    Patient_BL Patientvisit ;
    long returncode = -1;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Patientvisit = new Patient_BL(base.ContextInfo);
            ddlPurpose.SelectedValue = hdnSelPurpose.Value.ToString();
            Hdnvalue.Value = String.Empty;

            ddlFilterby.SelectedValue = hdnFilterby.Value.ToString();
            hdnFilterby.Value = "";

            if (!IsPostBack)
            {
                txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(1).ToString("dd/MM/yyyy");
                txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(8).ToString("dd/MM/yyyy");
                BindGrid();
                btnFind_Click(sender, e);
            }
            if (hdnSelPurpose.Value == "Health Package")
            {
                dvRecemondation.Style.Remove("display");
                dvSchedules.Style.Remove("display");
                dvSchedules1.Style.Remove("display");

                dvRecemondation.Style.Add("display", "block");
                dvSchedules.Style.Add("display", "none");
                dvSchedules1.Style.Add("display", "none");
            }
            else if (hdnSelPurpose.Value == "Appointments")
            {
                dvRecemondation.Style.Remove("display");
                dvSchedules.Style.Remove("display");
                dvSchedules1.Style.Remove("display");

                dvRecemondation.Style.Add("display", "none");
                dvSchedules.Style.Add("display", "block");
                dvSchedules1.Style.Add("display", "block");
            }
            else
            {
                dvRecemondation.Style.Add("display", "block");
                dvSchedules.Style.Add("display", "block");
                dvSchedules1.Style.Add("display", "block");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load", ex);
        }
    }
    public void BindGrid()
    {
        try
        {
            returncode = Patientvisit.GetPatientRecommendationDetails(OrgID, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                gvPatient.DataSource = lstPatientVisit;
                gvPatient.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BindGrid", ex);
        }
    }
    protected void gvPatient_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit obj = new PatientVisit();
                obj = (PatientVisit)e.Row.DataItem;
                LinkButton lnkshow = (LinkButton)e.Row.FindControl("lnkshow");
                lnkshow.OnClientClick = "ViewPatientRecommendationPopup('" + obj .PatientID+"~"+obj.PatientVisitId+"')";
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (gvPatient.PageIndex) * (gvPatient.PageSize));

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientRecommendation", ex);
        }
    }
    protected void gvPatient_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("enter"))
            {
                long visitid = Convert.ToInt64(e.CommandArgument.ToString());
                foreach (string str in Hdnvalue.Value.Split('^'))
                {
                    string[] value = str.Split('~');
                    long vid = Convert.ToInt64(value[0]);
                    long pid = Convert.ToInt64(value[1]);
                    if (visitid == vid)
                    {
                        Response.Redirect("ViewRecommendation.aspx?vid=" + visitid + "&pid=" + pid + "");
                    }
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvPatient_RowCommand", ex);
        }
    }
    protected void gvPatient_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvPatient.PageIndex = e.NewPageIndex;
            BindGrid();
        }
    }
    protected void btnFind_Click(object sender, EventArgs e)
    {
        
        Schedule_BL sbl = new Schedule_BL(base.ContextInfo);
        DateTime sfromdate = Convert.ToDateTime(txtFromDate.Text.Trim());
        DateTime sToDate = Convert.ToDateTime(txtToDate.Text.Trim());
        List<PhysicianSchedule> lstSchedules = new List<PhysicianSchedule>();

        long retval = sbl.GetSchedulesForDateRange(sfromdate, OrgID, sToDate,out lstSchedules);

        if (ddlFilterby.SelectedValue == "reminded")
        {
            lstSchedules = (from lst in lstSchedules
                           where lst.ResourceTemplateID > 0
                           select lst).ToList();
        }
        else if (ddlFilterby.SelectedValue == "pending")
        {
            lstSchedules = (from lst in lstSchedules
                            where lst.ResourceTemplateID == 0
                            select lst).ToList();
        }
        gvSchedules.DataSource = lstSchedules;
        gvSchedules.DataBind();
    }

    protected void gvSchedules_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PhysicianSchedule obj = new PhysicianSchedule();
                obj = (PhysicianSchedule)e.Row.DataItem;
                Label lblPatientName = (Label)e.Row.FindControl("lblPatientName");
                Label lblPatientNo = (Label)e.Row.FindControl("lblPatientNo");
                Label lblPhoneNo = (Label)e.Row.FindControl("lblPhoneNo");
                Label lblResource = (Label)e.Row.FindControl("lblResource");
                Label lblRemindCount = (Label)e.Row.FindControl("lblRemindCount");

                Image imgLoad = (Image)e.Row.FindControl("imgLoad");
                HtmlInputButton btnRemind = (HtmlInputButton)e.Row.FindControl("btnRemind");

                lblPatientName.Text = obj.PhysicianName.Split('~')[1].Split('>')[0].Trim();
                lblPatientNo.Text = obj.PhysicianName.Split('~')[1].Split('>')[1].Trim();
                lblPhoneNo.Text = obj.PhysicianName.Split('~')[1].Split('>')[2].Trim();
                if (obj.ResourceType == "P")
                {
                    lblResource.Text = "Dr." + obj.PhysicianName.Split('~')[0].Trim();
                }
                else
                {
                    lblResource.Text = obj.PhysicianName.Split('~')[0].Trim();
                }
                string sVal = "javasript:changevisibility('" + btnRemind.ClientID + "','" + imgLoad.ClientID + "','" + obj.Booked + "');";
                btnRemind.Attributes.Add("onclick", sVal);
                if (obj.ResourceTemplateID > 0)
                {
                    lblRemindCount.Visible = true;
                    lblRemindCount.Text = "This Patient has already been reminded (" + obj.ResourceTemplateID + ") Times";
                    btnRemind.Value = "Remind Again";
                    e.Row.CssClass = "errorbox";
                }
                else
                {
                    btnRemind.Value = "Remind";
                    lblRemindCount.Visible = false;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientRecommendation", ex);
        }
    }
    protected void UpdateReminder_Click(object sender, EventArgs e)
    {
        long BookID = 0;
        Int64.TryParse(hdnBookedID.Value, out BookID);
        new Schedule_BL(base.ContextInfo).UpdateScedules(BookID, OrgID, "", "U");
        btnFind_Click(sender, e);
    }
}
