using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PrintStockReport : Attune_BasePage
{
    public InventoryReports_PrintStockReport()
        : base("InventoryReports_PrintStockReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    DateTime fromDate;
    DateTime toDate;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<Organization> lstOrganization = new List<Organization>();
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<StockMovementSummary> lstStockMovements = new List<StockMovementSummary>();
    List<ProductCategories> lstCategories = new List<ProductCategories>();
    List<Locations> lstLocation = new List<Locations>();
    int pExpiryType = 2;
    InventoryReports_BL invReportsBL;
    //long returnCode = -1;
    long ProductId = 0;
    string ProductName = "";
    int Lid = 0;
    //int Cid = 0;
    string strStockFor = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_01 == null ? "Stock Report For" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_01;
    string strFrom = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_02 == null ? "From" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_02;
    string strTo = Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_03 == null ? "To" : Resources.InventoryReports_ClientDisplay.InventoryReports_PrintStockReport_aspx_03;

    protected void Page_Load(object sender, EventArgs e)
    {
        invReportsBL = new InventoryReports_BL(base.ContextInfo);
        if (!Page.IsPostBack)
        {

                DateTime.TryParse(Request.QueryString["dFrom"], out fromDate);
                DateTime.TryParse(Request.QueryString["dto"], out toDate);
                Int64.TryParse(Request.QueryString["ProID"], out ProductId);
                Int32.TryParse(Request.QueryString["Lid"], out Lid);
                Int32.TryParse(Request.QueryString["Exp"], out pExpiryType);
                     
                
            try
            {
               
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                orgName.Text = lstOrganization[0].Name;
                orgAddress.Text = lstOrganization[0].City + "<br/>" + lstOrganization[0].PhoneNumber;
                if (Request.QueryString["ProID"] != null)
                {
                   
                    if (Request.QueryString["ProID"] != null)
                    {
                        invReportsBL.GetStockMovementByProduct(fromDate, toDate, OrgID, ILocationID, Lid, ProductId,
                            out lstStockMovements, out lstCategories, out lstLocation, "Details", pExpiryType);
                        if (lstStockMovements.Count >= 0)
                        {
                            ProductName = lstStockMovements.Find(p => p.ProductID == ProductId).ProductName;
                        }
                        fromToStockReport.Text = strStockFor + " " + ProductName.ToUpper() + strFrom + " " + fromDate.ToString("dd/MM/yyyy") + strTo + " " + toDate.ToString("dd/MM/yyyy");

                    }
                    gvprintsales.Visible = true;
                    gvprintsales.DataSource =lstStockMovements ;
                    gvprintsales.DataBind();
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in PrintDispensingReport.aspx", ex);
            }
        }
    }


    protected void gvprintsales_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((StockMovementSummary)e.Row.DataItem).ExpiredDate.ToString() == "01/01/1753 00:00:00")
            {
                e.Row.Cells[2].Text = "--";

            }

        }
    }
}
