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
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_ProductLegend : Attune_BasePage
{
    public InventoryReports_ProductLegend()
        : base("InventoryReports_ProductLegend_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<StockMovementSummary> lstStockMovement = new List<StockMovementSummary>();
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
        Attuneheader.IsShowMenu = true;
        //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            trError.Visible = false;
            LoadOrgan();
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();

        }
    }
    string strProdReport = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_01 == null ? "Click Here To Print the {0} Product Legend Report" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_01;
    string strReportName = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_02 == null ? "Report Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_02;
    string strReportDate = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_03 == null ? "Report Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_03;
    string strAddress = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_04 == null ? "Address" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_04;
    string strCity = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_05 == null ? "City" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_05;
    string strPhoneNo = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_06 == null ? "Phone No" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_06;
    string strTotal = Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_07 == null ? "Total" : Resources.InventoryReports_ClientDisplay.InventoryReports_ProductLegend_aspx_07;


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
    private void LoadStockInHand()
    {

        DateTime sfromdate = txtFrom.Text.ToInternalDate();
        DateTime sTodate = txtTo.Text.ToInternalDate();

        string ProductName = txtProduct.Text;


        List<ProductCategories> lstCategories = new List<ProductCategories>();
        List<Locations> lstLocation = new List<Locations>();


        int DepartmentID = InventoryLocationID;
        int CategoryID = 0;
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue); List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        List<ProductCategories> lstProductCategories_all = new List<ProductCategories>();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        hdnProductCategories.Value = "[{'CategoryID':'0'}]";
        string strLstProductCategories = hdnProductCategories.Value;
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
        new InventoryReports_BL(base.ContextInfo).GetStockMovement(sfromdate, sTodate, OrgID, ILocationID, DepartmentID, ProductName, 0, 2, lstProductCategories, out lstStockMovement, out lstCategories, out lstLocation);



        if (lstStockMovement.Count > 0)
        {

            contentArea.Attributes.Add("class", "show");
            total.Visible = true;
            trError.Visible = false;
            grdResult.Visible = true;
            lblTotalStockValue.Text = "0";
            lblTotalStockValueCP.Text = "0";
            grdResult.DataSource = lstStockMovement;
            grdResult.DataBind();
            if (lstStockMovement.Count < grdResult.PageSize)
            {
                hdnRowCount.Value = lstStockMovement.Count.ToString();
            }
            else
            {
                hdnRowCount.Value = grdResult.PageSize.ToString();
            }

        }
        else
        {
            trError.Visible = true;
            lblResult.Text = Resources.InventoryReports_AppMsg.InventoryReports_ProductLegend_aspx_09 != null ? Resources.InventoryReports_AppMsg.InventoryReports_ProductLegend_aspx_09 : "No Matching Records Found!";
            contentArea.Attributes.Add("class", "show");

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
                if (inv.ProductID > 0)
                {
                    lbtnProduct.ToolTip = strProdReport.Replace("{0}", inv.ProductName);
                    lbtnProduct.NavigateUrl = "ProductLegendDetail.aspx?dFrom=" + txtFrom.Text + "&dTo=" + txtTo.Text + "&ProID=" + inv.ProductID;
                }

                lblTotalStockValue.Text = String.Format("{0:N}", (inv.ClosingStockValue + decimal.Parse(lblTotalStockValue.Text)));
                lblTotalStockValueCP.Text = String.Format("{0:N}", (inv.ClosingStockValueCP + decimal.Parse(lblTotalStockValueCP.Text)));

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
                e.Row.Cells[1].Text = strTotal;
                e.Row.Cells[1].Attributes.Add("class", "a-right bold");
                e.Row.Cells[2].Attributes.Add("class", "a-right bold");
                e.Row.Cells[2].Text = totOpeningBal.ToString("0.00");
                e.Row.Cells[3].Attributes.Add("class", "a-right bold");
                e.Row.Cells[3].Text = totOpeningStockValueCP.ToString("0.00");
                e.Row.Cells[4].Attributes.Add("class", "a-right bold");
                e.Row.Cells[4].Text = totOpeningStockValueSP.ToString("0.00");
                e.Row.Cells[5].Attributes.Add("class", "a-right bold");
                e.Row.Cells[5].Text = totClosingBalance.ToString("0.00");
                e.Row.Cells[6].Attributes.Add("class", "a-right bold");
                e.Row.Cells[6].Text = totClosingStockValueCP.ToString("0.00");
                e.Row.Cells[7].Attributes.Add("class", "a-right bold");
                e.Row.Cells[7].Text = totClosingStockValueSP.ToString("0.00");

            }

            // ****************************************************************************************** //

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading ProductLegend Details.", ex);
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
        new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

        rptName = "Product Legend Report";

        strHeader = "<center><h3>" + OrgName + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>" + strAddress + ": " + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>" + strReportName + " : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + strCity + ": " + lstOrganization[0].City + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>" + strReportDate + " : " + DateTimeNow.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + strPhoneNo + " : " + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'></td></tr>";
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

        return DateTimeUtility.GetServerDate().ToString();

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
