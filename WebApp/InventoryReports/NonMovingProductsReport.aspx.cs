using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_NonMovingProductsReport : Attune_BasePage
{
    public InventoryReports_NonMovingProductsReport()
        : base("InventoryReports_NonMovingProductsReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<ProductCategories> lstCategories = new List<ProductCategories>();
    List<Locations> lstLocation = new List<Locations>();

    InventoryCommon_BL inventoryBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
            BindLocation();
            BindCategory();
            rptHeader.Visible = false;

        }
    }
    private void BindLocation()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

        int OrgAddid = 0;
        List<Locations> lstLocation = new List<Locations>();
        new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
        lstLocation.RemoveAll(p => p.OrgAddressID != ILocationID);
        ddlLocation.DataSource = lstLocation;
        ddlLocation.DataTextField = "LocationName";
        ddlLocation.DataValueField = "LocationID";
        ddlLocation.DataBind();
        ListItem ddlselect = GetMetaData("All", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "All", Value = "0" };
        }
        ddlLocation.Items.Insert(0, ddlselect);

        ddlLocation.Items[0].Value = "0";
    }

    private void BindCategory()
    {
        JavaScriptSerializer JSsearializer = new JavaScriptSerializer();
        List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        hdnProductCategories.Value = JSsearializer.Serialize(lstProductCategories);
    }


    private void LoadStockInHand()
    {

        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtFrom.Text, out sfromdate);

        DateTime sTodate = DateTime.MinValue;
        DateTime.TryParse(txtTo.Text, out sTodate);

        string ProductName = txtProduct.Text;
        int DepartmentID = Int32.Parse(ddlLocation.SelectedValue);

        string sType = "N";
        rptHeader.Visible = true;
        lblTotalStockValue.Text = "0";
        if (ddlLocation.SelectedValue != "0")
        {
            divAll.Style.Add("display", "none");
        }
        if (ddlLocation.SelectedValue == "0")
        {
            divAll.Style.Add("display", "block");
            string lName = "";
            if (rdosummary.Checked)
            {
                foreach (Locations item in lstLocation)
                {
                    lName += item.LocationName + ",";
                }
                Locations loc = new Locations();
                loc.LocationName = lName.TrimEnd(',');
                lstLocation.RemoveAll(p => p.LocationID != 0);
                lstLocation.Add(loc);
                sType = "Y";
            }
        }

        rptHeader.Visible = true;
        rptHeader.DataSource = lstLocation;
        rptHeader.DataBind();

        if (chkNilStock.Checked == true)
        {
            lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
            hypLnkPrint.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                        "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&isNil=Y&NMI=Y";
            hypLnkExportXL.NavigateUrl = "AdminXLStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                        "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&isNil=Y&NMI=Y";
        }
        else
        {
            hypLnkPrint.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                    "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&NMI=Y";
            hypLnkExportXL.NavigateUrl = "AdminXLStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                    "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&NMI=Y";
        }

    }

    protected void rptHeader_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            //string lName = "";
            Locations objLocations = new Locations();
            objLocations = (Locations)e.Item.DataItem;
            Repeater rptMiddle = (Repeater)e.Item.FindControl("rptMiddle");
            List<ProductCategories> lstTempCategories = new List<ProductCategories>();
            lstTempCategories = lstCategories.FindAll(p => p.DeptID == objLocations.LocationID);

            if (ddlLocation.SelectedValue == "0")
            {
                if (rdosummary.Checked)
                {
                    IEnumerable<ProductCategories> iChildCat = (from c in lstCategories
                                                                group c by new { c.CategoryID, c.CategoryName } into g

                                                                select new ProductCategories
                                                                {
                                                                    CategoryID = g.Key.CategoryID,
                                                                    CategoryName = g.Key.CategoryName,
                                                                }).Distinct().ToList();
                    lstTempCategories = iChildCat.ToList();

                }
            }
            rptMiddle.DataSource = lstTempCategories;
            rptMiddle.DataBind();


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading StockInHand Details.", ex);
        }
    }

    protected void rptMiddle_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
            ProductCategories objcat = new ProductCategories();
            objcat = (ProductCategories)e.Item.DataItem;
            GridView grdResult = (GridView)e.Item.FindControl("grdResult");
            List<StockMovementSummary> lsttemp = new List<StockMovementSummary>();
            lsttemp = lstStockMovement.FindAll(p => p.LocationID == objcat.DeptID && p.CategoryID == objcat.CategoryID);
            if (ddlLocation.SelectedValue == "0")
            {
                if (rdosummary.Checked)
                {
                    IEnumerable<StockMovementSummary> iChildStock = (from c in lstStockMovement
                                                                     where c.CategoryID == objcat.CategoryID
                                                                     group c by new
                                                                     {
                                                                         c.ProductID,
                                                                         c.CategoryID,
                                                                         c.CurrentSellingPrice,
                                                                         c.Units,
                                                                         c.ProductName
                                                                     } into g
                                                                     select new StockMovementSummary
                                                                     {
                                                                         CategoryID = g.Key.CategoryID,
                                                                         CurrentSellingPrice = g.Key.CurrentSellingPrice,
                                                                         ClosingBalance = g.Sum(p => p.ClosingBalance),
                                                                         ClosingStockValue = g.Sum(p => p.ClosingStockValue),
                                                                         OpeningBalance = g.Sum(p => p.OpeningBalance),
                                                                         OpeningStockValue = g.Sum(p => p.OpeningStockValue),
                                                                         ProductID = g.Key.ProductID,
                                                                         ProductName = g.Key.ProductName,
                                                                         StockReceived = g.Sum(p => p.StockReceived),
                                                                         StockIssued = g.Sum(p => p.StockIssued),
                                                                         StockReturn = g.Sum(p => p.StockReturn),
                                                                         StockDamage = g.Sum(p => p.StockDamage),
                                                                         Units = g.Key.Units,
                                                                     }).Distinct().ToList();
                    lsttemp = iChildStock.ToList();
                   

                }

            }
            lsttemp.RemoveAll(P => P.StockIssued > 0||P.OpeningBalance==0);
            grdResult.DataSource = lsttemp;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading StockInHand Details.", ex);
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                StockMovementSummary inv = new StockMovementSummary();
                inv = (StockMovementSummary)e.Row.DataItem;
                HyperLink lbtnProduct = (HyperLink)e.Row.FindControl("hypProduct");
                string sType = "N";
                if (inv.ProductID > 0)
                {
                    if (ddlLocation.SelectedValue == "0")
                    {
                        if (rdosummary.Checked)
                        {
                            sType = "Y";
                        }
                    }

                }
                string strStockReport = Resources.InventoryReports_ClientDisplay.InventoryReports_NonMovingProductsReport_aspx_01 == null ? "Click Here To Print the  {0} Stock Report" : Resources.InventoryReports_ClientDisplay.InventoryReports_NonMovingProductsReport_aspx_01;

                lbtnProduct.ToolTip = strStockReport.Replace("{0}", inv.ProductName);
                lbtnProduct.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text +
                        "&dTo=" + txtTo.Text + "&ProID=" + inv.ProductID + "&Lid=" + inv.LocationID + "&Cid="
                        + inv.CategoryID + "&SType=" + sType;
                lblTotalStockValue.Text = String.Format("{0:0.00}", (inv.ClosingStockValue + decimal.Parse(lblTotalStockValue.Text)));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading StockInHand Details.", ex);
        }
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
        LoadStockInHand();
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        int pLocationID = 0;
        int pCategoryID = 0;
        if (e.NewPageIndex != -1)
        {

            GridView grdResult = (GridView)sender;

            pLocationID = Int32.Parse(grdResult.DataKeys[0]["LocationID"].ToString());
            pCategoryID = Int32.Parse(grdResult.DataKeys[0]["CategoryID"].ToString());
            grdResult.PageIndex = e.NewPageIndex;

            DateTime sfromdate = DateTime.MinValue;
            DateTime.TryParse(txtFrom.Text, out sfromdate);

            DateTime sTodate = DateTime.MinValue;
            DateTime.TryParse(txtTo.Text, out sTodate);

            string ProductName = txtProduct.Text;

            List<ProductCategories> lstProductCategories = new List<ProductCategories>();
            List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strLstProductCategories = hdnProductCategories.Value;
            lstProductCategories = serializer.Deserialize<List<ProductCategories>>(strLstProductCategories);
            if (lstProductCategories == null)
            {
                lstProductCategories = new List<ProductCategories>();
            }
            else if (lstProductCategories.Count > 0)
            {
                lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID == pCategoryID);

                if (lstProductCategories_all.Count > 0)
                {
                    lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID == pCategoryID);
                }
            }
            Session["lstProductCategories"] = lstProductCategories;
            new InventoryReports_BL(base.ContextInfo).GetStockMovement(sfromdate, sTodate, OrgID, ILocationID, pLocationID, ProductName, 0, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);
            grdResult.DataSource = lstStockMovement;
            grdResult.DataBind();

        }
    }

    private void LoadXMLStockInHand()
    {

        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtFrom.Text, out sfromdate);

        DateTime sTodate = DateTime.MinValue;
        DateTime.TryParse(txtTo.Text, out sTodate);

        string ProductName = txtProduct.Text;
        int DepartmentID = Int32.Parse(ddlLocation.SelectedValue);
        if (chkNilStock.Checked == true)
        {
            lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
        }
        else
        {
        }
        rptHeader.Visible = true;
        lblTotalStockValue.Text = "0";
        grdXLResult.DataSource = lstStockMovement;
        grdXLResult.DataBind();
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