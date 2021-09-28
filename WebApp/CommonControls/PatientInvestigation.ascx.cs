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

public partial class CommonControls_PatientInvestigation : BaseControl
{
    public event System.EventHandler selectionChanged;
    public event System.EventHandler checkedChanged;
    private string uploadPath = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected override void Render(HtmlTextWriter writer)
    {
        Page.ClientScript.RegisterForEventValidation(gvInvestigation.UniqueID);
        base.Render(writer);
    }
    public void loadData(IList dataItems, string noData)
    {

        lblName.Text = "";
        if (dataItems.Count > 0)
        {

            gvInvestigation.DataSource = dataItems;
            gvInvestigation.DataBind();
            gvInvestigation.SelectedIndex = 0;
            gvInvestigation.HeaderRow.Height = Unit.Pixel(14);

        }
        else
        {
            gvInvestigation.DataSource = dataItems;
            gvInvestigation.DataBind();
            lblName.Text = noData;
        }
    }

    protected void gvInvestigation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            gvInvestigation.PageIndex = e.NewPageIndex;
            if (selectionChanged != null)
                selectionChanged(sender, e);
        }
    }
    protected void gvInvestigation_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (checkedChanged != null)
            checkedChanged(sender, e);
    }
    protected void gvInvestigation_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    e.Row.Attributes["onmouseover"] = "this.style.cursor='hand';this.style.textDecoration='underline';";
        //    e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

        //    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(this.gvPatient, "Select$" + e.Row.RowIndex);
        //}

    }

    protected void Checked_Changed(object sender, EventArgs e)
    {
        CheckBox checkPatient = (CheckBox)sender;
        if (checkPatient.Checked)
        {
            GridViewRow row = (GridViewRow)checkPatient.NamingContainer;
            foreach (GridViewRow rows in gvInvestigation.Rows)
            {
                CheckBox uncheck = (CheckBox)(rows.FindControl("checkPatient"));
                uncheck.Checked = false;
            }

            checkPatient.Checked = true;
        }

        if (checkedChanged != null)
            checkedChanged(sender, e);
    }

    protected void gvInvestigation_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Go")
        {
            string fileName=string.Empty;
            LinkButton lbtnFilepath1 = (LinkButton)gvInvestigation.Rows[gvInvestigation.SelectedIndex].FindControl("lbtnFilepath");
            fileName=lbtnFilepath1.Text.ToString();
            System.Diagnostics.Process.Start(UploadPath+fileName);
            
        }
       
    }

    public string UploadPath
    {
        get { return uploadPath; }
        set { uploadPath = value; }

    }
}
