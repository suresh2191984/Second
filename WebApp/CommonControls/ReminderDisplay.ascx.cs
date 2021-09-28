using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;


public partial class CommonControls_ReminderDisplay : BaseControl
{

    public CommonControls_ReminderDisplay()
        : base("CommonControls_ReminderDisplay_ascx")
    {
    }
    public void LoadData()
    {
       
            Reminder_BL reminderBL = new Reminder_BL(base.ContextInfo);
            List<Reminder> lstReminder = new List<Reminder>();
            reminderBL.GetReminderDetail(LID, RoleID, out lstReminder);
            if (lstReminder.Count <= 0)
                lblRemainderDetail.Visible = false;
            else
                lblRemainderDetail.Visible = true;

            gvRemainder.DataSource = lstReminder;
            gvRemainder.DataBind();
       
    }
    protected void gvRemainder_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Close")
        {
            GridViewRow selectedRow = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            GridViewRow row = gvRemainder.Rows[selectedRow.RowIndex];

            Reminder_BL remainderBL = new Reminder_BL(base.ContextInfo);
            Label lblremainderID = (Label)row.FindControl("lblRemainderID");
            remainderBL.UpdateReminderStatus(Convert.ToInt32(lblremainderID.Text));

            LoadData();
        }
        else if (e.CommandName == "Defer")
        {
            GridViewRow selectedRow = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            GridViewRow row = gvRemainder.Rows[selectedRow.RowIndex];

            Label lblRemainderID = (Label)row.FindControl("lblRemainderID");
            TextBox txtDeferDate = (TextBox)row.FindControl("txtDeferDate");
            Reminder_BL remainderBL = new Reminder_BL(base.ContextInfo);

            remainderBL.UpdateReminderDeferDate(Convert.ToInt64(lblRemainderID.Text), Convert.ToDateTime(txtDeferDate.Text));


            Panel pnl = (Panel)row.FindControl("pnlDefer");
            pnl.Visible = false;

            LoadData();

        }
        else if (e.CommandName == "ShowDefer")
        {
            if (Convert.ToInt32(hdnSelectedRowIndex.Value) >= 0)
            {
                GridViewRow rows = gvRemainder.Rows[Convert.ToInt32(hdnSelectedRowIndex.Value)];
                Panel pnls = (Panel)rows.FindControl("pnlDefer");
                pnls.Visible = false;
            }

            GridViewRow selectedRow = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            GridViewRow row = gvRemainder.Rows[selectedRow.RowIndex];
            hdnSelectedRowIndex.Value = selectedRow.RowIndex.ToString();
            Panel pnl = (Panel)row.FindControl("pnlDefer");
            pnl.Visible = true;
        }
        else if (e.CommandName == "Cancel")
        {
            GridViewRow selectedRow = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            GridViewRow row = gvRemainder.Rows[selectedRow.RowIndex];
            hdnSelectedRowIndex.Value = selectedRow.RowIndex.ToString();
            TextBox txtDeferDate = (TextBox)row.FindControl("txtDeferDate");
            txtDeferDate.Text = "";
            hdnSelectedRowIndex.Value = "-1";
            Panel pnl = (Panel)row.FindControl("pnlDefer");

            pnl.Visible = false;
        }
    }

    protected void gvRemainder_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
    protected void Page_Load(object sender, EventArgs e)
    {
      //  txtDeferDate.Attributes.Add("onchange", "ExcedDate('" + txtDeferDate.ClientID.ToString() + "','',0,1);");
        
    }
    protected void gvRemainder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtDeferDate = (TextBox)e.Row.FindControl("txtDeferDate");
            txtDeferDate.Attributes.Add("onblur", "ExcedDate('" + txtDeferDate.ClientID.ToString() + "','',0,1);");
            //txtDeferDate.Attributes.Add("onclick", "javascript:alert('Hello')");

        }
    }
  
}
