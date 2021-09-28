using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;

public partial class Reports_PurchaseOrderReport : BasePage
{

    Report_BL PoReport;
    List<PurchaseOrders> lstDetails = new List<PurchaseOrders>();
    List<PurchaseOrderMappingLocation> PurDetails = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrders> PrhOrder = new List<PurchaseOrders>();

    protected void Page_Load(object sender, EventArgs e)
    {
        PoReport = new Report_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadLocationName();
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtFrom.Focus();
            

        }

    }

    private void LoadLocationName()
    {
        try
        {

            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            List<Locations> lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            //int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        OrgAddid = 0;
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}
            new SharedInventory_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        string PoNo=txtPoid.Text.ToString();
        DateTime dFromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime dToDate = Convert.ToDateTime(txtTo.Text);
       
        
        List<PurchaseOrderMappingLocation> PurDetails = new List<PurchaseOrderMappingLocation>();
        
//        PoReport.GetPurchaseOrder(OrgID, ILocationID, PoNo, dFromDate, dToDate, out PrhOrder,out PurDetails);

        IEnumerable<PurchaseOrders> pdcs = (from s in PrhOrder
                                             group s by new { s.LocationID , s.PurchaseOrderNo } into g
                                            select new PurchaseOrders
                                             {
                                                 LocationID = g.Key.LocationID,
                                                 PurchaseOrderNo = g.Key.PurchaseOrderNo,
                                             }
                                               ).Distinct().ToList();



        GrdPrhOrder.DataSource = pdcs;
        GrdPrhOrder.DataBind();

    }
    protected void GrdPrhOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //DayWiseCollectionReport BMaster = (DayWiseCollectionReport)e.Row.DataItem;
            PurchaseOrders obj = (PurchaseOrders)e.Row.DataItem;
            //var childItems = (from child in lstPhy1
            //                  where child.PhysicianName == BMaster.PhysicianName
            //                  select child);


            var childItems = (from child in PrhOrder
                              where child.PurchaseOrderNo == obj.PurchaseOrderNo &&  child.LocationID == obj.LocationID 
                              select child);
            GridView childGrid = (GridView)e.Row.FindControl("GrdChild");
            childGrid.DataSource = childItems;
            childGrid.DataBind();

        }

    }

    protected void GrdPrhOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            GrdPrhOrder.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
}
