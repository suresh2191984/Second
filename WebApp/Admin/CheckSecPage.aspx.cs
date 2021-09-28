using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Text;

public partial class Admin_CheckSecPage : BasePage
{
    public Admin_CheckSecPage()
        : base("Admin\\CheckSecPage.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UcSecPage1.Visible = false;
            //Panel2.Style.Value = "none";
            Label1.Visible = false;
            Image1.Visible = false;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            hdnCount.Value = "0";
            Label1.Visible = false;
            Image1.Visible = false;
            UcSecPage1.Visible = false;

            lblMessage.Text = string.Empty;

            long returnCode = -1;
            List<Patient> lstPatient = new List<Patient>();
            int pCount = -1;

            returnCode = new AdminReports_BL(base.ContextInfo).GetPVDetailOnSecCode(OrgID, txtSecCode.Text, out lstPatient, out pCount);
            if (pCount == 1)
            {
                UcSecPage1.Visible = true;
                Label1.Visible = true;
                Image1.Visible = true;

                hdnCount.Value = pCount.ToString();

                lblMessage.Text = "This is a valid Security Code";

                UcSecPage1.loadPatientSecDetail(lstPatient);
            }
            else
            {
                lblMessage.Text = "This is a Invalid Security Code";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin/CheckSecPage.aspx", ex);
        }
    }
}
