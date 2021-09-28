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

public partial class CommonControls_PatientTreatment : BaseControl
{
    public event System.EventHandler selectionChanged;
    public event System.EventHandler checkedChanged;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected override void Render(HtmlTextWriter writer)
    {
        Page.ClientScript.RegisterForEventValidation(gvTreatment.UniqueID);
        base.Render(writer);
    }
    public void loadData(IList dataItems, string noData)
    {

        lblName.Text = "";
        if (dataItems.Count > 0)
        {

            gvTreatment.DataSource = dataItems;
            gvTreatment.DataBind();
            gvTreatment.SelectedIndex = 0;
            gvTreatment.HeaderRow.Height = Unit.Pixel(14);

        }
        else
        {
            gvTreatment.DataSource = dataItems;
            gvTreatment.DataBind();
            lblName.Text = noData;
        }
    }
    protected void gvTreatment_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            gvTreatment.PageIndex = e.NewPageIndex;
            if (selectionChanged != null)
                selectionChanged(sender, e);
        }
    }
    protected void gvTreatment_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (checkedChanged != null)
            checkedChanged(sender, e);
    }
    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Checked_Changed(object sender, EventArgs e)
    {
        CheckBox checkPatient = (CheckBox)sender;
        if (checkPatient.Checked)
        {
            GridViewRow row = (GridViewRow)checkPatient.NamingContainer;
            foreach (GridViewRow rows in gvTreatment.Rows)
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
