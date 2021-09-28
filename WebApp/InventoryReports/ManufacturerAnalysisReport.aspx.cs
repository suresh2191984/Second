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

public partial class InventoryReports_ManufacturerAnalysisReport : Attune_BasePage
{
     public InventoryReports_ManufacturerAnalysisReport()
        : base("InventoryReports_ManufacturerAnalysisReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    List<Organization> lstOrganization = new List<Organization>();
    List<Locations> lstLocations = new List<Locations>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    List<ProductType> lstProductType = new List<ProductType>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);

        if (!IsPostBack)
        {
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();
            LoadOrgan();
            tblExport.Visible = false;
        }
    }
       
   
    private void LoadOrgan()
    {
        new TrustedOrg_BL(ContextInfo).GetSharingOrgList(OrgID, out lstOrganization, out lstLocations);
        ddlTrustedOrg.DataSource = lstOrganization;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
       // ddlTrustedOrg.Items.Insert(0, "--Select--");
        ddlTrustedOrg.Items[0].Value = "0";
        if (lstOrganization.Count == 1)
        {
            ddlTrustedOrg.SelectedValue = OrgID.ToString();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "load selected location", "GetLocationlist();", true);
        }
        ddlLocation.DataBind();
       
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlLocation.Items.Insert(0, ddlselect);
        //ddlLocation.Items.Insert(0, new ListItem("--Select--", "0"));
        ddlLocation.Items[0].Value = "0";
        foreach (var item in lstLocations)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";
        }
    }

    private void LoadManufacturerProduct()
    {
        int pOrgID = OrgID;
        long MfgID = Convert.ToInt64(hdnMfgID.Value);
        string MfgName=string.Empty;
        long ProductID = txtProduct.Text.Trim() == "" ? 0 : Convert.ToInt64(hdnPID.Value);

        DateTime sfromdate = txtFrom.Text.ToInternalDate();
        MfgName=txtSearchNo.Text;
        DateTime sTodate = txtTo.Text.ToInternalDate();

        string ProductName = txtProduct.Text;
        string SearchNo = txtSearchNo.Text;
        if (ddlTrustedOrg.SelectedValue != "0")
        {
            pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        }
        int InventoryLocationID = Convert.ToInt32(hdnInvLocation.Value);
        new InventoryReports_BL(this.ContextInfo).GetManufacturerWiseProductReport(MfgID, MfgName, sfromdate, sTodate, ProductName, ProductID, pOrgID, InventoryLocationID, out lstInventoryItemsBasket);
        grdResult.Visible = true;
        tblExport.Visible = true;
        grdResult.DataSource = lstInventoryItemsBasket;
        grdResult.DataBind();

        if (lstInventoryItemsBasket.Count == 0)
        {
            tblExport.Style.Add("display", "none");
        }
        else
        {
            tblExport.Style.Add("display", "block");
        }
        hdnRowCount.Value = lstInventoryItemsBasket.Count.ToString();
    }
      
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadManufacturerProduct();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "load selected location", "GetSelectedLocation();recalldatepicker();calcHeight();", true);
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
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

    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            grdResult.AllowPaging = false;
            FilterControls(grdResult);
            LoadManufacturerProduct();
            ExportToExcel();
            grdResult.AllowPaging = true;
            grdResult.DataSource = lstInventoryItemsBasket;
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
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            HttpContext.Current.Response.Write(getReportHeader(grdResult.Columns.Count));
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
        string Address = string.Empty;
        string City = string.Empty;
        string PhoneNumber = string.Empty;
        new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        if (lstOrganization[0].Address != null || lstOrganization[0].Address != "")
        {
            Address = lstOrganization[0].Address;
        }
        if (lstOrganization[0].City != null || lstOrganization[0].City != "")
        {
            City = lstOrganization[0].City;
        }
        if (lstOrganization[0].PhoneNumber != null || lstOrganization[0].PhoneNumber != "")
        {
            PhoneNumber = lstOrganization[0].PhoneNumber;
        }
        rptName = "Manufacturer Analysis Report";
        strHeader = "<center><h3>" + OrgName + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>Address : " + Address + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>City : " + City + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'>Report Date : " + DateTimeNow.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>Phone No : " + PhoneNumber + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td align='left'>Manufacturer Name : " + txtSearchNo.Text + "</td>" + getBlankTD(tdCount) + "<td align='LEFT'></td></tr>";
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

    private void ClearControls(Control control)
    {
        for (int i = control.Controls.Count - 1; i >= 0; i--)
        {
            ClearControls(control.Controls[i]);
        } if (!(control is TableCell))
        {
            if (control.GetType().GetProperty("SelectedItem") != null)
            {
                LiteralControl literal = new LiteralControl();
                control.Parent.Controls.Add(literal);
                try
                {
                    literal.Text = (string)control.GetType().GetProperty("SelectedItem").GetValue(control, null);
                }
                catch
                { }
                control.Parent.Controls.Remove(control);
            }
            else if (control.GetType().GetProperty("Text") != null)
            {
                LiteralControl literal = new LiteralControl();
                control.Parent.Controls.Add(literal);
                literal.Text = (string)control.GetType().GetProperty("Text").GetValue(control, null);
                control.Parent.Controls.Remove(control);
            }
        }
        return;
    }
    protected void btnBack_Click(object sender, EventArgs e)
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