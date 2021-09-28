using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;

public partial class Lab_LabRole : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        loadGrid();
    }
    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session["UserName"] = null;
        Response.Redirect("Home.aspx");
    }
    public void loadGrid()
    {

        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
        List<PatientVisitDetails> lstDetails = new List<PatientVisitDetails>();
        //callBL.GetLabInvestigation(OrgID,RoleID, out lstDetails);
        if (lstDetails.Count > 0)
        {
            dCaption.Visible = true;
            dCapture.Visible = true;
            GridView1.DataSource = lstDetails;
            GridView1.DataBind();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadGrid();
        }
    }
}
