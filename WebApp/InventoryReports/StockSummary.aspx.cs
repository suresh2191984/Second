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
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;


public partial class InventoryReports_StockSummary : Attune_BasePage
{
    public InventoryReports_StockSummary()
        : base("InventoryReports_StockSummary_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    InventoryCommon_BL inventoryBL ;
    List<StockMovementSummary> lstStockSummary = new List<StockMovementSummary>();
    List<LocationStockValues> lstIssuedStockvalue = new List<LocationStockValues>();
    List<LocationStockValues> lstAmtReceived = new List<LocationStockValues>();
    List<LocationStockValues> lstrecdStockvalue = new List<LocationStockValues>();
    List<Locations> lstLocation = new List<Locations>();
    //string isNil = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtDate.Text = DateTimeNow.ToString("dd/MM/yyyy");
            LoadLocationName();

        }
    }

    private void LoadLocationName()
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }

    }

    private void LoadStockSummary()
    {

        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtDate.Text, out sfromdate);

        new InventoryReports_BL(base.ContextInfo).GetStockSummary(sfromdate, OrgID, ILocationID, int.Parse(ddlLocation.SelectedValue), out lstStockSummary, out lstIssuedStockvalue, out lstAmtReceived,out lstrecdStockvalue);

        lblOSV.Text = lstStockSummary[0].OpeningStockValue.ToString();
        lblpurchaseduring.Text = lstStockSummary[0].StockReceived.ToString();
        lblothers.Text = lstStockSummary[0].StockReturn.ToString();

        if (lstrecdStockvalue.Count > 0)
        {
            tdrecdvalue.Style.Add("display", "block");
            tdrecdvalue.Style.Add("display", "block");
            lblLocation.Text = lstrecdStockvalue[0].LocationName;
            lblRecdValue.Text = lstrecdStockvalue[0].StockValue.ToString();
            lblSubTotal1.Text = (lstrecdStockvalue[0].StockValue + lstStockSummary[0].StockReceived).ToString();
            lblgrandTotal.Text = (lstrecdStockvalue[0].StockValue + lstStockSummary[0].StockReceived + lstStockSummary[0].OpeningStockValue).ToString();
        }
        else
        {
            lblSubTotal1.Text = (lstStockSummary[0].StockReceived + lstStockSummary[0].OpeningStockValue).ToString();

        }


       


        decimal tot1 = 0;
        if (lstAmtReceived.Count > 0)
        {
            foreach (LocationStockValues item in lstAmtReceived)
            {
                tot1 = +item.StockValue;
            }
            gvUsers.DataSource = lstAmtReceived;
            gvUsers.DataBind();
        }

        if (lstIssuedStockvalue.Count > 0)
        {
            tdiss.Style.Add("display", "block");
            tdtoiss.Style.Add("display", "block");
        }

        decimal diff=lstStockSummary[0].ClosingBalance-tot1;

        lblothers.Text = diff.ToString();
        lblSubToatl2.Text = (tot1 + diff).ToString();
        lblClosingValues.Text = lstStockSummary[0].ClosingBalance.ToString();
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadStockSummary();
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {

            btnSearch_Click(sender, e);
        }
    }
}
