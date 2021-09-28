using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PurchaseStatusReport : Attune_BasePage
{
    public InventoryReports_PurchaseStatusReport()
        : base("InventoryReports_PurchaseStatusReport_aspx")
   {
   }

    protected void page_init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<Organization> lstOrganization = new List<Organization>();
    List<Locations> lstLocation = new List<Locations>();

    protected void Page_Load(object sender, EventArgs e)
    {

        inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            LoadLocationName();
            txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
            //LoadStockInHand();
            hdnFromDate.Value = txtFrom.Text.ToString();
            hdnToDate.Value = txtTo.Text.ToString();
            hdnLocationID.Value = InventoryLocationID.ToString();
            hdnOrgAddressID.Value = ILocationID.ToString();
            hdnOrgID.Value = OrgID.ToString();


        }

    }


    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            new Master_BL(base.ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrganizationID";
                ddlTrustedOrg.DataBind();
                //ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                if (lstOrgList.Count(p => p.OrgID == OrgID) > 0)
                {
                    ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).OrgID.ToString();
                }
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }

    private void LoadLocationName()
    {
        try
        {
            int OrgAddid = 0;
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ListItem ddlselect = GetMetaData("ALL", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "ALL", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);
            //ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }


    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }

    }
}
