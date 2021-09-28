using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Globalization;

public partial class Reminder_ReminderPage : BasePage
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtStartDt.Attributes.Add("onchange", "ExcedDate('" + txtStartDt.ClientID.ToString() + "','',0,1);");
        txtEndDt.Attributes.Add("onchange", "ExcedDate('" + txtEndDt.ClientID.ToString() + "','',0,1);");
        if (!Page.IsPostBack)
        {
            getReminderTemplateDetail();
           
            if (RoleName == "Physician")
            {
               // PhyHeader1.Visible = true;
             //   UsrHeader1.Visible = false;
            }
            else
            {
               // PhyHeader1.Visible = false;
              //  UsrHeader1.Visible = true;
            }
        }
    }
   
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            CultureInfo provider = CultureInfo.InvariantCulture;
            string format = "dd/MM/yyyy";
            if (btnSave.Text == "Save")
            {
                long returnCode = -1;

                ReminderTemplate lstreminderTemplate = new ReminderTemplate();
                lstreminderTemplate.StartDate = DateTime.ParseExact(txtStartDt.Text, format, provider);
                lstreminderTemplate.EndDate = DateTime.ParseExact(txtEndDt.Text, format, provider);
                lstreminderTemplate.Notes = txtNotes.Text;
                lstreminderTemplate.Frequency = ddlFrequency.SelectedItem.Text;
                lstreminderTemplate.UserID = LID;
                lstreminderTemplate.RoleID = RoleID;
                Reminder_BL reminderBL = new Reminder_BL(base.ContextInfo);
                returnCode = reminderBL.SaveReminderTemplate(lstreminderTemplate);

                getReminderTemplateDetail();
                

            }
            else if (btnSave.Text == "Update")
            {
                long returnCode = -1;
                ReminderTemplate reminderTemplate = new ReminderTemplate();
                reminderTemplate.ReminderTemplateID =Convert.ToInt64(hdnReminderTemplateID.Value);
                reminderTemplate.StartDate = DateTime.ParseExact(txtStartDt.Text, format, provider);
                reminderTemplate.EndDate = DateTime.ParseExact(txtEndDt.Text, format, provider);
                reminderTemplate.Notes = txtNotes.Text;
                reminderTemplate.Frequency = ddlFrequency.SelectedItem.Text;
                Reminder_BL reminderBL = new Reminder_BL(base.ContextInfo);
                returnCode =  reminderBL.UpdatereminderTemplate(reminderTemplate);
                getReminderTemplateDetail();
                

            }
            clear();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save/Update in remainder template page", ex); 
        }
    }

    private void getReminderTemplateDetail()
    {

        Reminder_BL reminderBL = new Reminder_BL(base.ContextInfo);
        List<ReminderTemplate> lstreminderTemplate = new List<ReminderTemplate>();
        reminderBL.getReminderTemplate(LID, RoleID, out lstreminderTemplate);

        gvReminderTemplate.DataSource = lstreminderTemplate;
        gvReminderTemplate.DataBind();

    }

    protected void gvReminderTemplate_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            GridViewRow row = gvReminderTemplate.Rows[Convert.ToInt32(e.CommandArgument)];
            
            Label lblRemindertemplatyeID = (Label)row.FindControl("lblReminderTemplateID");
            Label lblStartDate = (Label) row.FindControl("lblStartDate");
            Label lblEnddate = (Label)row.FindControl("lblEndDate");
            Label lblNotes = (Label)row.FindControl("lblNotes");
            Label lblFrequency = (Label)row.FindControl("lblFrequency");

            txtStartDt.Text = Convert.ToDateTime(lblStartDate.Text).ToString("dd/MM/yyy");
            txtEndDt.Text = Convert.ToDateTime(lblEnddate.Text).ToString("dd/MM/yyy");
            txtNotes.Text = lblNotes.Text;
            //ddlFrequency.SelectedItem.Text = lblFrequency.Text.Trim();
            ddlFrequency.ClearSelection();
            ddlFrequency.Items.FindByText(lblFrequency.Text.Trim()).Selected = true;
            
            btnSave.Text = "Update";

            hdnReminderTemplateID.Value = lblRemindertemplatyeID.Text;
          
        }
        else if (e.CommandName == "Delete")
        {
            GridViewRow row = gvReminderTemplate.Rows[Convert.ToInt32(e.CommandArgument)];
            Label lblRemindertemplatyeID = (Label)row.FindControl("lblReminderTemplateID");

            Reminder_BL reminderBL = new Reminder_BL(base.ContextInfo);
            reminderBL.DeleteReminderTemplate(Convert.ToInt64(lblRemindertemplatyeID.Text));

            getReminderTemplateDetail();
            clear();

        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            clear();
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    private void clear()
    {
        btnSave.Text = "Save";
        txtStartDt.Text = "";
        txtEndDt.Text = "";
        txtNotes.Text = "";
        ddlFrequency.ClearSelection();
    }
    protected void gvReminderTemplate_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void gvReminderTemplate_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void gvReminderTemplate_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}
