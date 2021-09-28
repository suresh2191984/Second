using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Admin_LocationTimeCapture : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadOrganization();
    }
    private void LoadOrganization()
    {
        try
        {
            List<Organization> lstOrg = new List<Organization>();
            new Schedule_BL(base.ContextInfo).getOrganizations(out lstOrg);
            if (lstOrg.Count > 0)
            {
                ddlOrganization.DataSource = lstOrg;
                ddlOrganization.DataTextField = "Name";
                ddlOrganization.DataValueField = "OrgID";
                ddlOrganization.DataBind();
                ddlOrganization.SelectedValue = OrgID.ToString();
                ddlOrganization.Enabled = false;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}