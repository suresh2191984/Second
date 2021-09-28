using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;


public partial class InventoryReports_AdminStockReport : Attune_BasePage
{
    public InventoryReports_AdminStockReport()
        : base("InventoryReports_AdminStockReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<ProductCategories> lstCategories = new List<ProductCategories>();
    List<Locations> lstLocation = new List<Locations>();
    decimal totOpeningBalance = 0;
    decimal totOpeningStockValue = 0;
    decimal totClosingBalance = 0;
    decimal totClosingStockValue = 0;
    InventoryReports_BL invReportBL;
    InventoryCommon_BL inventoryBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            txtFrom.Text = DateTimeNow.ToExternalDate();
            txtTo.Text = DateTimeNow.ToExternalDate();
            BindLocation();
            BindCategory();
            LoadOrgan();
            rptHeader.Visible=false;

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
                ddlTrustedOrg.DataValueField = "OrgID";
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
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindLocation();
        BindCategory();
       
    }
    private void BindLocation()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        int OrgAddid = 0;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        List<Locations> lstLocation = new List<Locations>();
        new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
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
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        ddlCategory.DataSource = lstProductCategories;
        ddlCategory.DataTextField = "CategoryName";
        ddlCategory.DataValueField = "CategoryID";
        ddlCategory.DataBind();
        hdnProductCategories.Value = JSsearializer.Serialize(lstProductCategories);
        ListItem ddlSelect = GetMetaData("All", "0");
        if (ddlSelect == null)
        {
            ddlSelect = new ListItem { Text = "All", Value = "0" };
        }
        ddlCategory.Items.Insert(0, ddlSelect);
    }


    private void LoadStockInHand()
    {
        invReportBL = new InventoryReports_BL(base.ContextInfo);
        DateTime sfromdate = DateTime.MinValue;
        if (!String.IsNullOrEmpty(txtFrom.Text.Trim()))
        {
           sfromdate= txtFrom.Text.ToInternalDate();
        }
        DateTime sTodate = DateTime.MinValue;
        if (!String.IsNullOrEmpty(txtTo.Text.Trim()))
        {
            sTodate=txtTo.Text.ToInternalDate();
        }
        string ProductName = txtProduct.Text;
        int DepartmentID = Int32.Parse(ddlLocation.SelectedValue);
        int CategoryID = 0;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue); List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        if (ddlCategory.SelectedIndex > -1)
            CategoryID = Convert.ToInt32(ddlCategory.SelectedValue); 
        List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string strLstProductCategories = hdnProductCategorieschk.Value;
        lstProductCategories = serializer.Deserialize<List<ProductCategories>>(strLstProductCategories);
        if (lstProductCategories == null)
        {
            lstProductCategories = new List<ProductCategories>();
        }
        else if (lstProductCategories.Count > 0)
        {
            lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID == 0);

            if (lstProductCategories_all.Count > 0)
            {
                lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID == 0);
            }
        }
        Session["lstProductCategories"] = lstProductCategories;

        invReportBL.GetStockMovement(sfromdate, sTodate, OrgID, ILocationID, DepartmentID, ProductName, CategoryID, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);
         
        string sType = "N";
        rptHeader.Visible = true;
        lblTotalStockValue.Text = "0";
        if (ddlLocation.SelectedValue != "0")
        {
        }
        if (ddlLocation.SelectedValue == "0")
        {
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

        
        if (lstStockMovement.Count > 0)
        {
            
            if (chkNilStock.Checked == true)
            {
                lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
                hypLnkPrint.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                            "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&isNil=Y";
                hypLnkExportXL.NavigateUrl = "AdminXLStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                            "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType + "&isNil=Y";
            }
            else
            {
                hypLnkPrint.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                        "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType;
                hypLnkExportXL.NavigateUrl = "AdminXLStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text +
                        "&pName=" + ProductName + "&Lid=" + DepartmentID + "&Cid=" + 0 + " &SType=" + sType;
            }
        }
        rptHeader.Visible = true;
        rptHeader.DataSource = lstLocation;
        rptHeader.DataBind();
        ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "LoadCategoryValue();", true);

    }

    protected void rptHeader_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        try
        {
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
                                                                     group c by new { c.StockReceived,c.StockReturn,c.StockDamage,c.StockIssued, c.ProductID,c.CategoryID,c.CurrentSellingPrice,c.Units,c.ProductName
                                                               } into g
                                                                   select new StockMovementSummary
                                                                {
                                                                    CategoryID=g.Key.CategoryID,
                                                                    CurrentSellingPrice=g.Key.CurrentSellingPrice,
                                                                    ClosingBalance = g.Sum(p => p.ClosingBalance),
                                                                    ClosingStockValue = g.Sum(p => p.ClosingStockValue),
                                                                    OpeningBalance = g.Sum(p => p.OpeningBalance),
                                                                    OpeningStockValue = g.Sum(p => p.OpeningStockValue),
                                                                    ProductID=g.Key.ProductID,
                                                                    ProductName=g.Key.ProductName,
                                                                    StockReceived=g.Sum(p => p.StockReceived),
                                                                    StockIssued = g.Sum(p => p.StockIssued),
                                                                    StockReturn = g.Sum(p => p.StockReturn),
                                                                    StockDamage = g.Sum(p => p.StockDamage),
                                                                    Units=g.Key.Units,
                                                                }).Distinct().ToList();
                    lsttemp = iChildStock.ToList();

                }

            }

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
                lbtnProduct.ToolTip = "Click Here To Print the " + inv.ProductName + " Stock Report";
                lbtnProduct.NavigateUrl = "PrintAdminStockReport.aspx?dFrom=" + txtFrom.Text +
                        "&dTo=" + txtTo.Text + "&ProID=" + inv.ProductID + "&Lid=" + inv.LocationID + "&Cid="
                        + inv.CategoryID + "&SType=" + sType;
                lblTotalStockValue.Text = String.Format("{0:0.00}", (inv.ClosingStockValue + decimal.Parse(lblTotalStockValue.Text)));
    // ***********Code for footer total amount calculation   ******************************************* //
                totOpeningBalance += inv.OpeningBalance;
                totOpeningStockValue += inv.OpeningStockValue;
                totClosingBalance += inv.ClosingBalance;
                totClosingStockValue += inv.ClosingStockValue;
   // ************************************************************************************************* //
            }
   //*********** Code for footer total amount display **************************************************//  

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[1].Text = "Total";
                e.Row.Cells[1].Attributes.Add("style", "text-align:centre;font-weight:Bold;");
                e.Row.Cells[2].Text = totOpeningBalance.ToString("0.00");
                e.Row.Cells[2].Attributes.Add("style", "text-align: right;font-weight:Bold;");
                e.Row.Cells[3].Text = totOpeningStockValue.ToString("0.00");
                e.Row.Cells[3].Attributes.Add("style", "text-align: right;font-weight:Bold;");
                e.Row.Cells[8].Text = totClosingBalance.ToString("0.00");
                e.Row.Cells[8].Attributes.Add("style", "text-align: right;font-weight:Bold;");
                e.Row.Cells[9].Text = totClosingStockValue.ToString("0.00");
                e.Row.Cells[9].Attributes.Add("style", "text-align: right;font-weight:Bold;");
                totOpeningBalance = 0;
                totOpeningStockValue = 0;
                totClosingBalance = 0;
                totClosingStockValue = 0;
            }

    //**************************************************************************************************//

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
        invReportBL = new InventoryReports_BL(base.ContextInfo);
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
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            List<ProductCategories> lstProductCategories = new List<ProductCategories>();
            invReportBL.GetStockMovement(sfromdate, sTodate, OrgID, ILocationID, pLocationID, ProductName, pCategoryID, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);


            if (lstStockMovement.Count > 0)
            {
                if (chkNilStock.Checked == true)
                {
                    lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
                }
              
            }
            grdResult.DataSource = lstStockMovement;
            grdResult.DataBind();

        }
    }

    private void LoadXMLStockInHand()
    {
        invReportBL = new InventoryReports_BL(base.ContextInfo);
        DateTime sfromdate = DateTime.MinValue;
        if(!String.IsNullOrEmpty(txtFrom.Text.Trim()))
        {
            sfromdate= txtFrom.Text.ToInternalDate();
        }
        DateTime sTodate = DateTime.MinValue;
        if (!String.IsNullOrEmpty(txtFrom.Text.Trim()))
        {
            sTodate=txtTo.Text.ToInternalDate();
        }

        string ProductName = txtProduct.Text;
        int DepartmentID = Int32.Parse(ddlLocation.SelectedValue);
        int CategoryID =0;
        if(ddlCategory.SelectedIndex>-1)
            CategoryID = Int32.Parse(ddlCategory.SelectedValue);
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string strLstProductCategories = hdnProductCategorieschk.Value;
        lstProductCategories = serializer.Deserialize<List<ProductCategories>>(strLstProductCategories);
        if (lstProductCategories == null)
        {
            lstProductCategories = new List<ProductCategories>();
        }
        else if (lstProductCategories.Count > 0)
        {
            lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID == 0);

            if (lstProductCategories_all.Count > 0)
            {
                lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID == 0);
            }
        }
        invReportBL.GetStockMovement(sfromdate, sTodate, OrgID, ILocationID, DepartmentID, ProductName, 0, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);


        if (chkNilStock.Checked == true)
        {
            lstStockMovement.RemoveAll(P => P.ClosingStockValue > 0);
            //    lstStockMovement.Remove(lstStockMovement.Find(P => P.ClosingStockValue > 0));

           // hypLnkPrint.NavigateUrl = "PrintStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text + "&pName=" + ProductName + "&isNil=Y";
        }
        else
        {
           // hypLnkPrint.NavigateUrl = "PrintStockReport.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text + "&pName=" + ProductName;
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