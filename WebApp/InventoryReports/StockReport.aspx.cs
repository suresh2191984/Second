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
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Common;


public partial class InventoryReports_StockReport : Attune_BasePage
{
    public InventoryReports_StockReport()
        : base("InventoryReports_StockReport_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    List<Locations> lstLocation = new List<Locations>();
    List<InventoryConfig> lstInventoryConfigOrg = new List<InventoryConfig>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<InventoryConfig> lstInventoryConfigRole = new List<InventoryConfig>();
    decimal TotalClosingStockSPValue = 0;
    decimal TotalClosingStockCPValue = 0;

    string strHideSellingPriceConfig = string.Empty;


    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("HideSellingPriceStockReport", OrgID, ILocationID, out lstInventoryConfig);
        strHideSellingPriceConfig = lstInventoryConfig.Count > 0 ? lstInventoryConfig[0].ConfigValue : "N";

        if (!IsPostBack)
        {
            Attuneheader.IsShowMenu = true;

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule_ProductType", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                hdnIsSellingPriceTypeRuleApply.Value = lstInventoryConfig[0].ConfigValue;
            }
            LoadOrgan();
            txtFrom.Text =DateTimeNow.ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtFrom.Focus();
            LoadLocationName();
            BindCategory();
        }
        hdnIsflag.Value = "false";
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            new Master_BL(ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = Convert.ToString(OrgID); //lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    public void LoadsharedorgLocation(object sender, EventArgs e)
    {
        try
        {
            int OrgAddid = 0;
            idRep.DataSource = null;
            idRep.DataBind();
            ddlLocation.DataSource = null;
            ddlLocation.DataBind();
            string ddlorgid = ddlTrustedOrg.SelectedValue;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(Convert.ToInt32(ddlorgid), OrgAddid, out lstLocation);
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
            ddlLocation.Items[0].Value = "0";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }

    }
    private void LoadLocationName()
    {
        try
        {
            int OrgAddid = 0;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
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
          //  ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    private void LoadStockInHand()
    {
        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtFrom.Text, out sfromdate);
        List<ProductCategories> lstCategories = new List<ProductCategories>();
        List<Locations> lstLocation = new List<Locations>();

        DateTime sTodate = DateTime.MinValue;
        DateTime.TryParse(txtTo.Text, out sTodate);

        string ProductName = txtProduct.Text;
        int DepartmentID = int.Parse(ddlLocation.SelectedValue);
        //int CategoryID = int.Parse(ddlCategory.SelectedValue);
        int ExpiryType = 0;
        string RakNo = txtRak.Text;
        ExpiryType = Convert.ToInt32(rdoexpirydate.SelectedValue);

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
            lstProductCategories_all = lstProductCategories.FindAll(p => p.CategoryID != 0);

            if (lstProductCategories_all.Count > 0)
            {
                lstProductCategories = lstProductCategories.FindAll(p => p.CategoryID != 0);
            }
        }
       
        base.ContextInfo.AdditionalInfo = RakNo;
        string ddlorgid = ddlTrustedOrg.SelectedValue;
        new InventoryReports_BL(base.ContextInfo).GetStockMovement(sfromdate, sTodate,Convert.ToInt32(ddlorgid), ILocationID, DepartmentID, ProductName, 0, ExpiryType, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);

       // lblPageStockValueCP.Text = "0.00";
       // lblPageStockValueSP.Text = "0.00";
        if (lstStockMovement.Count > 0)
        {
            var temp = lstStockMovement;
            if (rdostock.SelectedItem.Text == "Nil Stocks")
            {
                temp = lstStockMovement.FindAll(p => p.OpeningBalance == 0 && p.StockReceived == 0).ToList();
            }
            else if (rdostock.SelectedItem.Text == "Non-Zero Stocks")
            {
                temp = lstStockMovement.FindAll(p => p.ClosingBalance > 0).ToList();
            }
            else if (rdostock.SelectedItem.Text == "All Stocks")
            {
                temp = lstStockMovement.FindAll(p => p.ClosingBalance >= 0).ToList();
            }
            string sDate = sfromdate.ToString("dd-MM-yyyy");
            string eDate = sTodate.ToString("dd-MM-yyyy");
            //lbldateReport.Text = sDate + '-' + eDate;
            idRep.Visible = true;
            lblTotalStockValueCP.Text = "0";
            lblTotalStockValueSP.Text = "0";
            idRep.DataSource = temp;
            if (temp.Count > 0)
            {

                tdExcel.Attributes.Add("class", "displaytd a-left");
                savecancel.Attributes.Remove("class");
                savecancel.Attributes.Add("class", "a-center");
            }
            else
            {

                tdExcel.Attributes.Add("class", "hide");
                savecancel.Attributes.Remove("class");
                savecancel.Attributes.Add("class", "a-center");
            }
            if (rdofastslow.SelectedValue == "0")
            {
                temp = temp.OrderBy(p => p.StockPercent).ToList();
                idRep.DataSource = temp;
            }
            if (rdofastslow.SelectedValue == "1")
            {
                temp = temp.OrderByDescending(p => p.StockPercent).ToList();
                idRep.DataSource = temp;
            }
            if (rdoGroupBy.SelectedValue == "0")
            {
                temp = (from c in temp
                        join e in lstCategories on c.CategoryID equals e.CategoryID
                        group c by e.CategoryName into d
                        orderby d.Key
                        select new StockMovementSummary
                        {
                            CategoryName = d.Key,
                            OpeningBalance = d.Sum(o => o.OpeningBalance),
                            OpeningStockValue = d.Sum(o => o.OpeningBalance * o.CostPrice),
                            OpeningStockValueCP = d.Sum(o => o.OpeningStockValueCP),
                            ClosingStockValue = d.Sum(o => o.ClosingStockValue),
                            ClosingStockValueCP = d.Sum(o => o.ClosingStockValueCP),
                            StockReceived = d.Sum(o => o.StockReceived),
                            ReceivedStockValue = d.Sum(o => o.ReceivedStockValue),
                            ReceivedStockValueCP = d.Sum(o => o.ReceivedStockValueCP),
                            IssuedStockValue = d.Sum(o => o.IssuedStockValue),
                            IssuedStockValueCP = d.Sum(o => o.IssuedStockValueCP),
                            StockIssued = d.Sum(o => o.StockIssued),
                            StockDamage = d.Sum(o => o.StockDamage),
                            StockReturn = d.Sum(o => o.StockReturn),
                            Adhoc = d.Sum(o => o.Adhoc),
                            StockTransfer = d.Sum(o => o.StockTransfer),
                            StockExpiryDate = d.Sum(o => o.StockExpiryDate),
                            ClosingBalance = d.Sum(o => o.ClosingBalance)
                        }).ToList();

               // grdResult.DataSource = temp;
            }
            idRep.DataSource = temp;
            idRep.DataBind();
            lblTotalStockValueCP.Text = String.Format("{0:0.00}", temp.Sum(p => p.ClosingBalance*p.CostPrice));
            lblTotalStockValueSP.Text = String.Format("{0:0.00}", temp.Sum(p => p.ClosingBalance*p.CurrentSellingPrice));
        }
        else
        {
            idRep.DataSource = null;
            idRep.DataBind();
            lblTotalStockValueCP.Text = "0";
            lblTotalStockValueSP.Text = "0";
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
        hdnIsflag.Value = "true";
    }
   
    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
           // grdResult.AllowPaging = false;
           // LoadStockInHand();
            FilterControls(idRep);
            ExportToExcel();
          //  grdResult.AllowPaging = true;
            //grdResult.DataSource = lstStockMovement;
            //grdResult.DataBind();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "Reports_";
        if (rdostock.SelectedItem.Text == "NilStock")
        {
            prefix = "Nil_Stock_Report_";
        }
        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtFrom.Text, out sfromdate);

        DateTime sTodate = DateTime.MinValue;
        DateTime.TryParse(txtTo.Text, out sTodate);
        string sDate = sfromdate.ToString("dd-MM-yyyy");
        string eDate = sTodate.ToString("dd-MM-yyyy");
        string rptDate = prefix + sDate + '-' + eDate;
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        HttpContext.Current.Response.Write(getReportHeader(rdostock.SelectedItem.Text == "NilStock", 33));
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        idRep.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }

    public string getReportHeader(bool rptFlag, int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        List<Organization> lstOrganization = new List<Organization>();
        if (rptFlag == true)
        {
            rptName = "Nil Stock Report";
        }
        else
        {
            rptName = "Stock InHand Report";
        }
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        rptName = "stock Report";
        strHeader = "<center><h1>" + OrgName.ToString() + "</h1></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Date : " + DateTimeNow.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "</table></center>";

        return strHeader;
    }

    public string getBlankTD(int tdCount)
    {
        string strTD = string.Empty;
        if (tdCount > 4)
        {
            tdCount -= 4;
        }
        while (tdCount > 0)
        {
            strTD += "<td></td>";
            tdCount--;
        }
        return strTD;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
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
    #region Stockreport Category Dropdown
    private void BindCategory()
    {
        JavaScriptSerializer JSsearializer = new JavaScriptSerializer();

        inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        hdnProductCategories.Value = JSsearializer.Serialize(lstProductCategories);
    }
    #endregion


}
