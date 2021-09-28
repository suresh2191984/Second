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

public partial class InventoryReports_StockAdjasmentReport : Attune_BasePage
{
    public InventoryReports_StockAdjasmentReport()
        : base("InventoryReports_StockAdjasmentReport_aspx")
   {
   }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
    List<InventoryItemsBasket> lstInventroyItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    List<Organization> lstOrganization = new List<Organization>();
    decimal totOpeningBal = 0;
    decimal totOpeningStockValueCP = 0;
    decimal totOpeningStockValueSP = 0;
    decimal totClosingBalance = 0;
    decimal totClosingStockValueCP = 0;
    decimal totClosingStockValueSP = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        total.Visible = false;
        btnHome.Visible = false;
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
            //LoadStockInHand();

            DateTime sfromdate = DateTime.MinValue;
            DateTime.TryParse(txtFrom.Text, out sfromdate);

            DateTime sTodate = DateTime.MinValue;
            DateTime.TryParse(txtTo.Text, out sTodate);

            string ProductName = txtProduct.Text;

            hdnfromdate.Value = sfromdate.ToString();
            hdnTodate.Value = sTodate.ToString();
            hdnOrgID.Value = OrgID.ToString();
            hdnLocationID.Value = ILocationID.ToString();
            hdnDepartmentID.Value = InventoryLocationID.ToString();
            hdnProductName.Value = ProductName.ToString();

        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            InventoryReports_BL objBl = new InventoryReports_BL(base.ContextInfo);
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
    private void LoadStockInHand()
    {

        DateTime sfromdate = DateTime.MinValue;
        DateTime.TryParse(txtFrom.Text, out sfromdate);

        DateTime sTodate = DateTime.MinValue;
        DateTime.TryParse(txtTo.Text, out sTodate);
        sTodate.AddDays(1).AddSeconds(-1);
        string ProductName = txtProduct.Text;
        List<ProductCategories> lstCategories = new List<ProductCategories>();
        List<Locations> lstLocation = new List<Locations>();

        int DepartmentID = InventoryLocationID;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        new InventoryReports_BL(base.ContextInfo).GetStockAdjasMent(sfromdate, sTodate, OrgID, ILocationID, DepartmentID, ProductName, out lstInventroyItemsBasket);

        hdnfromdate.Value = sfromdate.ToString();
        hdnTodate.Value = sTodate.ToString();
        hdnOrgID.Value = OrgID.ToString();
        hdnLocationID.Value = ILocationID.ToString();
        hdnDepartmentID.Value = DepartmentID.ToString();
        hdnProductName.Value = ProductName.ToString();

        if (lstInventroyItemsBasket.Count > 0)
        {
            contentArea.Style.Add("display", "block");
            total.Visible = true;
            btnHome.Visible = true;
            grdResult.Visible = true;
            lblTotalStockValue.Text = "0";
            lblTotalStockValueCP.Text = "0";
            grdResult.DataSource = lstInventroyItemsBasket;
            grdResult.DataBind();
            if (lstInventroyItemsBasket.Count < grdResult.PageSize)
            {
                hdnRowCount.Value = lstInventroyItemsBasket.Count.ToString();
            }
            else
            {
                hdnRowCount.Value = grdResult.PageSize.ToString();
            }

        }
        else
        {
            contentArea.Style.Add("display", "block");
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
                lblTotalStockValue.Text = String.Format("{0:0.00}", (inv.ClosingStockValue + decimal.Parse(lblTotalStockValue.Text)));
                lblTotalStockValueCP.Text = String.Format("{0:0.00}", (inv.ClosingStockValueCP + decimal.Parse(lblTotalStockValueCP.Text)));

                //*********** Total Amount Calculation ******************************************//
                totOpeningBal += inv.OpeningBalance;
                totOpeningStockValueCP += inv.OpeningStockValueCP;
                totOpeningStockValueSP += inv.OpeningStockValue;
                totClosingBalance += inv.ClosingBalance;
                totClosingStockValueCP += inv.ClosingStockValueCP;
                totClosingStockValueSP += inv.ClosingStockValue;
                //**********************************************************************************//
            }
            //**********Added the code for Footer Total Amount Display *****************************//
            if (e.Row.RowType == DataControlRowType.Footer)
            {
            }

            // ****************************************************************************************** //

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading ProductLegend Details.", ex);
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
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            grdResult.AllowPaging = false;
            LoadStockInHand();
            FilterControls(grdResult);
            //FilterControls(gvIndents);
            ExportToExcel();
            grdResult.AllowPaging = true;
            grdResult.DataSource = lstStockMovement;
            grdResult.DataBind();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void ExportToExcel()
    {
        try
        {

            //export to excel
            string prefix = string.Empty;
            prefix = "Reports_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            HttpContext.Current.Response.Write(getReportHeader(grdResult.Columns.Count));
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdResult.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Export Excel.", ex);
        }


    }

    public string getReportHeader(int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        rptName = "Product Legend Report";
        strHeader = "<center><h3>" + OrgName + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>Address : " + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>City : " + lstOrganization[0].City + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>Report Date : " + DateTimeNow.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>Phone No : " + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'></td></tr>";
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
    public string getDate()
    {

        return DateTimeNow.ToString();

    }

    private void FilterControls(Control gvRst)
    {

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

    protected void gridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
        {
            e.Row.TabIndex = -1;
            e.Row.Attributes["onclick"] = string.Format("javascript:SelectRow(this, {0});", e.Row.RowIndex);
            e.Row.Attributes["onkeydown"] = "javascript:return SelectSibling(event);";
            e.Row.Attributes["onselectstart"] = "javascript:return false;";
        }
    }
}
