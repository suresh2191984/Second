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
using System.Xml.Linq;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_PatientHistory : BaseControl
{
    public event System.EventHandler selectionChanged;
    public event System.EventHandler checkedChanged;
    String Flag = String.Empty;
    bool showph = false;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected override void Render(HtmlTextWriter writer)
    {
        Page.ClientScript.RegisterForEventValidation(gvHistory.UniqueID);
        base.Render(writer);
    }
    public void loadData(IList dataItems, string noData)
    {

        lblName.Text = "";
        if (dataItems.Count > 0)
        {
            gvHistory.DataSource = dataItems;
            gvHistory.DataBind();
            gvHistory.SelectedIndex = 0;
            gvHistory.HeaderRow.Height = Unit.Pixel(14);
        }
        else
        {
            gvHistory.DataSource = dataItems;
            gvHistory.DataBind();
            Flag = noData;
            lblName.Text = noData;
        }
    }

    public string DataFlag
    {
        get { return Flag; }
        set { Flag = value; }
    }

    public bool ShowPH
    {
        set
        {
            showph = value;
            ShowHidePH();
        }
    }

    private void ShowHidePH()
    {
        gvHistory.Visible = showph;        
    }

    protected void gvHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            gvHistory.PageIndex = e.NewPageIndex;
            if (selectionChanged != null)
                selectionChanged(sender, e);
        }
    }
    protected void gvHistory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (checkedChanged != null)
            checkedChanged(sender, e);
    }
    protected void gvHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Checked_Changed(object sender, EventArgs e)
    {
        CheckBox checkPatient = (CheckBox)sender;
        if (checkPatient.Checked)
        {
            GridViewRow row = (GridViewRow)checkPatient.NamingContainer;
            foreach (GridViewRow rows in gvHistory.Rows)
            {
                CheckBox uncheck = (CheckBox)(rows.FindControl("checkPatient"));
                uncheck.Checked = false;
            }

            checkPatient.Checked = true;
        }

        if (checkedChanged != null)
            checkedChanged(sender, e);
    }

}
