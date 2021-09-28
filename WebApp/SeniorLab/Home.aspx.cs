using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Lab_InvestigationApproval : BasePage
{
    long patientVisitID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        loadGrid();
        
    }

    private void loadGrid()
    {
        Investigation_BL obj = new Investigation_BL(base.ContextInfo);
        List<PatientVisitDetails> lstpatient = new List<PatientVisitDetails>();
        obj.GetInvesforApproval(OrgID, out lstpatient);
        if (lstpatient.Count > 0)
        {
            ShowDiv.Visible = true;
            GridView1.DataSource = lstpatient;
            GridView1.DataBind();
        }
        else
        {
            ShowDiv1.Visible = true;
        }
    }

    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.GridView1.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.GridView1.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Red';");
            e.Row.Attributes.Add("onmouseout", "this.style.color='Black';");
            e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                patientVisitID = Convert.ToInt32(GridView1.DataKeys[RowIndex][0]);
                Response.Redirect("~/Investigation/InvestigationDisplay.aspx?vid=" + patientVisitID + "&aut=Lab");
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        loadGrid();
    }
}
