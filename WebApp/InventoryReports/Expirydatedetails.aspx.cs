using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryReports.BL;


public partial class InventoryReports_Expirydatedetails : Attune_BasePage
{
    public InventoryReports_Expirydatedetails()
        : base("InventoryReports_Expirydatedetails_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    InventoryReports_BL inventoryBL;
    Products objProducts = new Products();
    List<InventoryItemsBasket> lstItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    int dDate = 0;
    string strConfig=string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Attuneheader.IsShowMenu = true;
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule_ProductType", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            hdnIsSellingPriceTypeRuleApply.Value = lstInventoryConfig[0].ConfigValue;

                    if (hdnIsSellingPriceTypeRuleApply.Value == "N")
                    {
                    }
                }
                inventoryBL = new InventoryReports_BL(base.ContextInfo);
       // divTool.Attributes.Add("display", "block");
        if (!IsPostBack)
        {
            LoadOrgan();
            LoadLocation();

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();

            if (lstInventoryConfig.Count > 0)
            {
                strConfig = lstInventoryConfig[0].ConfigValue;
                Int32.TryParse(strConfig,out dDate);
                lblExpLevel.Text += strConfig + " " + "Month(s)"; 
                //DateTime dt = DateTimeUtility.GetServerDate().AddMonths(dDate); 
                //txtTo.Text = DateTimeUtility.GetServerDate().ToString("dd/MM/yyyy");
            }
            //LoadExpiredatedetails();
            // divLegend.Attributes.Add("display", "none");

        }
    }
    private void LoadLocation()
    {
        try
        {
            List<Locations> lstInvLocation = new List<Locations>();
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, 0, out lstInvLocation);
            List<Locations> objLocations = new List<Locations>();
            foreach (Locations item in lstInvLocation)
            {
                //item.LocationTypeCode = item.LocationID;// +"@" + item.OrgAddressID;
                objLocations.Add(item);
            }

            if (objLocations != null && objLocations.Count > 0)
            {
                ddlLocation.DataSource = objLocations.OrderBy(x => x.OrgAddressName).ToList();
                ddlLocation.DataTextField = "OrgAddressName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
            }
            ListItem ddlAll = GetMetaData("All", "0");
            if (ddlAll == null)
            {
                ddlAll = new ListItem() { Text = "All", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlAll);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading location", ex);
        }
    }


    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            Master_BL objBl = new Master_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
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

    private void LoadExpiredatedetails()
    {
        txtExpiredColor.Visible = false;
        lblExpired.Visible = false;
        int ddllocationid = Convert.ToInt32(ddlLocation.SelectedValue);
        int locationid = 0;
        if (ddllocationid > -1)
        {
            locationid = ddllocationid;
        }
        //if (chkAllreadyExp.Checked)
        //{
        //    lblExpired.Visible = true;
        //    txtExpiredColor.Visible = true;
        //}

        DateTime sfromdate = txtFrom.Text.ToInternalDate();
        //if (!string.IsNullOrEmpty(txtTo.Text.Trim()))
        //{
        //    sfromdate = Convert.ToDateTime(txtFrom.Text.Trim());
        //}

        string pProdName = string.Empty;
        DateTime sTodate = txtTo.Text.ToInternalDate();
        //if (!string.IsNullOrEmpty(txtTo.Text.Trim()))
        //{
        //    sTodate = Convert.ToDateTime(txtTo.Text.Trim());
        //}
       
        pProdName = txtProduct.Text;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        inventoryBL.GetExpiredatedetails(sfromdate, sTodate, pProdName, OrgID, locationid, locationid, out lstItemsBasket);

        lblExpLevel.Text = "product will be Expired between dates";
        txtExpLevelColor.CssClass = "grdchecked";
        txtExpiredColor.CssClass = "grdcheck";

        if (lstItemsBasket != null && lstItemsBasket.Count > 0)
        {
            contentArea.Style.Add("display", "block");
            divPrint.Visible = true;
            var lstgrpproduct = lstItemsBasket.GroupBy(p => new { p.ProductID, p.BatchNo,p.LocationName });
            List<InventoryItemsBasket> lstitem = new List<InventoryItemsBasket>();
            foreach (var i in lstgrpproduct)
            {
                InventoryItemsBasket inv = new InventoryItemsBasket();
                // inv.ProductID = i.Key;
                //inv.BatchNo = i.Key.ToString();
                //inv.SupplierName = i.Key.ToString();
                // var name = (from supplier in lstItemsBasket select new {supplier.SupplierName}).Distinct();
                Hashtable ht = new Hashtable();
                foreach (var entry in i)
                {
                    //inv.ProductID  = entry.ProductID; 
                    //inv.ProductName = entry.ProductName;
                    //inv.BatchNo = entry.BatchNo;


                    if (entry.ProductID != 0)
                    {
                        inv.ProductID = entry.ProductID;
                    }

                    if (entry.ProductName != null)
                    {
                        //if (!ht.Contains(entry.ProductName))
                        //{
                        //    inv.ProductName += entry.ProductName + ',';
                        //    ht.Add(entry.ProductName, entry.ProductID);
                        //}
                        if (!ht.Contains(entry.ProductName) && (!string.IsNullOrEmpty(entry.ProductName)))
                        {
                            if (inv.ProductName.Length > 0)
                                inv.ProductName += ',' + entry.ProductName;
                            else
                                inv.ProductName = entry.ProductName;
                            ht.Add(entry.ProductName, entry.ProductID);
                        }

                    }
                    //if(entry.BatchNo!=null)
                    //{

                    //        inv.BatchNo = entry.BatchNo;



                    //}
                    if (entry.RakNo != null && entry.RakNo != "")
                    {
                        //if (!ht.Contains(entry.RakNo))
                        //{
                        //    inv.RakNo += entry.RakNo + ',';
                        //    ht.Add(entry.RakNo, entry.ProductID);
                        //}
                        if (!ht.Contains(entry.RakNo) && (!string.IsNullOrEmpty(entry.RakNo)))
                        {
                            if (inv.RakNo.Length > 0)
                                inv.RakNo += ',' + entry.RakNo;
                            else
                                inv.RakNo = entry.RakNo;
                            ht.Add(entry.RakNo, entry.ProductID);
                        }

                    }
                    if (inv.SupplierName != null)
                    {

                        if (!ht.Contains(entry.SupplierName) && (!string.IsNullOrEmpty(entry.SupplierName)))
                        {
                            if(inv.SupplierName.Length>0)
                                inv.SupplierName +=','+ entry.SupplierName ;
                            else
                                inv.SupplierName =entry.SupplierName ;
                            ht.Add(entry.SupplierName, entry.ProductID);
                        }
                    }

                    inv.InHandQuantity = entry.InHandQuantity;
                    inv.Unit = entry.Unit;
                    inv.BatchNo = entry.BatchNo;
                    inv.ExpiryDate = entry.ExpiryDate;
                    inv.TSellingPrice = entry.TSellingPrice;

                    inv.UnitPrice = entry.UnitPrice;
                    inv.LocationName = entry.LocationName;


                }
                ht.Clear();
                lstitem.Add(inv);


            }
            grdResult.DataSource = lstitem;
            grdResult.DataBind();
            lblTotalStockValueCP.Text = String.Format("{0:0.00}", lstitem.Sum(p => p.UnitPrice));
            lblTotalStockValueSP.Text = String.Format("{0:0.00}", lstitem.Sum(p => p.TSellingPrice));
            divExp.Visible = true;

        }
        else
        {
            contentArea.Style.Add("display", "none");
            divPrint.Visible = false;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv1", "javascript:alert('No Matching Records found for the selected dates');", true);
        }
      
       

    }
    protected void grdResult_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
   
    public void ExportToExcel(Control ctr)
    {
        //export to excel
        try
        {
            string rptDate = "Expiry Report_" + System.DateTime.Today.ToExternalDate();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
       
        grdResult.Style.Remove("Backcolor");
       // grdResult.RenderControl(oHtmlTextWriter);
        divPrint.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
            LoadExpiredatedetails();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.IPBill;
        int ddllocationid = Convert.ToInt32(ddlLocation.SelectedValue);
        int locationid = 0;
        if (ddllocationid > -1)
        {
            locationid = ddllocationid;
        }
        string sCurrentPage = Request.AppRelativeCurrentExecutionFilePath;
        //string sHeaderText = (string)GetGlobalResourceObject("Resource", sCurrentPage);
        //string sHeaderText = Resources.InventoryReports_ClientDisplay.InventoryReports_Expirydatedetails_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_Expirydatedetails_aspx_01 : "Expiry Date Details Report";

        lblReportName.Text = "Expiry Date Details Report";

        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, locationid, out lstConfig);
        if (lstConfig.Count > 0)
        {
            imgPath.Src = lstConfig[0].ConfigValue.Trim().Replace("..", System.Configuration.ConfigurationManager.AppSettings["ApplicationName"].ToString());
        }

        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, locationid, out lstConfig);

        if (lstConfig.Count > 0)
        {
            lblHospital.Text = lstConfig[0].ConfigValue.Trim();
        }

        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, locationid, out lstInventoryConfig);

        if (lstInventoryConfig.Count > 0)
        {
            strConfig = lstInventoryConfig[0].ConfigValue;
            Int32.TryParse(strConfig, out dDate);
        }
        LoadExpiredatedetails();
    }

    private void FilterControls(Control gvRst)
    {
        //Removing Hyperlinks and other controls b4 export

        LinkButton lb = new LinkButton();
        HyperLink hl = new HyperLink();
        Literal l = new Literal();
        string name = String.Empty;
        for (int i = 0; i < gvRst.Controls.Count; i++)
        {
            if (gvRst.Controls[i].GetType() == typeof(LinkButton))
            {
                l.Text = (gvRst.Controls[i] as LinkButton).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].GetType() == typeof(HyperLink))
            {
                l.Text = (gvRst.Controls[i] as HyperLink).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].HasControls())
            {
                FilterControls(gvRst.Controls[i]);
            }
        
        }
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
       
            ExportToExcel(divPrint);
           
        

    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IIM = new InventoryItemsBasket();
                IIM = (InventoryItemsBasket)e.Row.DataItem;
                Label lblExpDate = (Label)e.Row.FindControl("lblExpDate");
                Label lblInHandQty = (Label)e.Row.FindControl("lblInHandQty");
                TimeSpan tsExpLevel = DateTime.Parse(lblExpDate.Text) - DateTime.Today;

                if (IIM.Description == "Y")
                {
                    //e.Row.Style.Add("background-color", "#95B546");
                    e.Row.CssClass = "grdchecked";
                    e.Row.Cells[5].Visible = false;
                }
                if (IIM.Description == "N")
                {
                    //e.Row.BackColor = System.Drawing.Color.Orange;
                    e.Row.CssClass = "grdcheck";
                }
                if (hdnIsSellingPriceTypeRuleApply.Value == "Y")
                {
                    e.Row.Cells[8].Visible = false;
                }
            }
            if (hdnIsSellingPriceTypeRuleApply.Value == "Y")
            {
                e.Row.Cells[8].Visible = false;
            }
        }
            
       
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading ExpireDate Details.", ex);
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
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