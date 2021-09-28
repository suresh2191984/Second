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


public partial class Lab_ipPerformInvestigation : BasePage
{
    long vid = -1;
    long returnCode = -1;
    int pCount = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["vid"] != null)
        {
            vid = int.Parse(Request.QueryString.Get("vid"));
        }
        if (!IsPostBack)
        {
            patientHeader.PatientVisitID = vid;

            List<IpInvSampleCollectionMaster> sample = new List<IpInvSampleCollectionMaster>();
            long visitID = Convert.ToInt64(vid);
            new Investigation_BL(base.ContextInfo).GetIPPatientForInvestigation(visitID, OrgID, out sample);
            if (sample.Count > 0)
            {
                grdResult.DataSource = sample;
                grdResult.DataBind();
            }
            else
            {
                lblStatus.Visible = true;
                lblStatus.Text = "No Matching Receords Found!";
            }
        }
    }
    //protected void btnGo_Click(object sender, EventArgs e)
    //{
    //    lblStatus.Visible = false;
    //    if (txtpVisiitID.Text != string.Empty)
    //    {
    //        List<IpInvSampleCollectionMaster> sample = new List<IpInvSampleCollectionMaster>();
    //        long visitID=Convert.ToInt64(txtpVisiitID.Text);
    //        new Investigation_BL(base.ContextInfo).GetIPPatientForInvestigation(visitID, OrgID, out sample);
    //        if (sample.Count > 0)
    //        {
    //            grdResult.DataSource = sample;
    //            grdResult.DataBind();
    //        }
    //        else
    //        {
    //            lblStatus.Visible = true;
    //            lblStatus.Text = "No Matching Receords Found!";
    //        }
    //    }
    //    else
    //    {
    //        lblStatus.Visible = true;
    //        lblStatus.Text = "Enter Visit Number to Search";
    //    }
    //}

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IPPerformInv")
        {
            //Label lbsmcID = (Label)grdResult.Rows.FindControl("lblSCMID");
            //GridViewRow row = grdResult.SelectedRow;
            //Label lbsmcID = (Label)row.FindControl("lblSCMID");
            //int iIndex = grdResult.SelectedRow.RowIndex;
            long smcID = Convert.ToInt64(e.CommandArgument.ToString());
            //Label lbsmcID = (Label)grdResult.Rows[iIndex ].FindControl("lblSCMID");
            //long smcID = 0; Convert.ToInt64(lbsmcID);

            returnCode = new Investigation_BL(base.ContextInfo).CheckIPInvCompleted(vid, smcID, out pCount);
            if (pCount > 0)
            {
                Response.Redirect(@"../Investigation/InvestigationCapture.aspx?vid=" + vid + "&SID=" + smcID + "", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:alert('There are no Pending Investigations');", true);
            }
        }
    }
}
