using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;

public partial class CommonControls_SampleCollected : BaseControl
{
    public CommonControls_SampleCollected()
        : base("CommonControls_SampleCollected_ascx")
    {
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        deptBlock.Visible = false;
    }
    public string dispDeptBlock
    {
        set { deptBlock.Style.Add("display", value); }
    }
    public void LoadSamples(List<CollectedSample> orderedListOfSamples,List<InvDeptMaster> lstDeptList)
    {
        if (orderedListOfSamples.Count > 0)
        {
            dtSample.DataSource = orderedListOfSamples;
            dtSample.DataBind();
            pnlSampleList.Visible = true;
            pnlSampleListlbl.Style.Add("display", "none");
            lblStatus.Visible = false;
            deptBlock.Style.Add("display", "block");
        }
        else
        {
            pnlSampleList.Visible = false;
            lblStatus.Visible = true;
            pnlSampleListlbl.Style.Add("display", "block");
        }

        if (lstDeptList.Count() > 0)
        {
            dlDeptName.DataSource = lstDeptList;
            dlDeptName.DataBind();
            dlDeptName.Visible = true;
            lblDeptStatus.Visible = false;

        }
        else
        {
            dlDeptName.Visible = false;
            lblDeptStatus.Visible = true;
            deptBlock.Style.Add("display", "none");
        }

    }
    protected void dlInvName_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string strOutSource = Resources.CommonControls_ClientDisplay.CommonControls_SampleCollectedVisit_ascx_01 == null ? "OutSource" : Resources.CommonControls_ClientDisplay.CommonControls_SampleCollectedVisit_ascx_01;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");
            Label lblInvName = (Label)e.Item.FindControl("lblInvName");
            Label Label1 = (Label)e.Item.FindControl("Label1");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            if (lblStatus.Text == strOutSource.Trim())
            {
                lblInvName.ForeColor = System.Drawing.Color.OrangeRed;
                lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                Label1.ForeColor = System.Drawing.Color.OrangeRed;
                Label2.ForeColor = System.Drawing.Color.OrangeRed;
            }

        }
    }
}
