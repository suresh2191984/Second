using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.IO;
using System.Text;
using AjaxControlToolkit;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Configuration; 


public partial class InventoryReports_StockReturnReport : Attune_BasePage
{
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Locations> lstLocations = new List<Locations>();
    InventoryReports_BL invReportsBL;

    public InventoryReports_StockReturnReport()
        : base("InventoryReports_StockReturnReport_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    { base.page_Init(sender, e);}

    protected void Page_Load(object sender, EventArgs e)
    {
        invReportsBL = new InventoryReports_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadLocationName(OrgID, ILocationID);
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();
        }
    }

    private void LoadLocationName(int oid, int oaid)
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            new Master_BL(ContextInfo).GetInvLocationDetail(oid, OrgAddid, out lstLocations);
            ddlLocation.DataSource = lstLocations.FindAll(p => p.LocationTypeCode == "CS-POS" || p.LocationTypeCode == "CS").ToList();
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            System.Web.UI.WebControls.ListItem ddlselect = GetMetaData("All", "0");
            if (ddlselect == null)
            {
                ddlselect = new System.Web.UI.WebControls.ListItem() { Text = "All", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);
            ddlLocation.Items[0].Value = "0";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadStockReturnDetails();
    }

    protected void LoadStockReturnDetails()
    {
        try
        {
            gvStockReturn.Visible = false;
            DateTime fDate = txtFrom.Text.ToInternalDate();
            DateTime tDate = txtTo.Text.ToInternalDate();
            int ddlLocationID = Int32.Parse(ddlLocation.SelectedValue);

            invReportsBL.GetStockReturnReport(Convert.ToDateTime(txtFrom.Text),
            Convert.ToDateTime(txtTo.Text), ddlLocationID, OrgID, ILocationID, txtSupplier.Text.Trim(), Convert.ToInt32(hdnProdID.Value), out lstInventoryItemsBasket);
            gvStockReturn.DataSource = lstInventoryItemsBasket;

            if (lstInventoryItemsBasket != null)
            {
                contentArea.Style.Add("display", "block");
                tblNoResult.Style.Add("display", "none");
                if (lstInventoryItemsBasket.Count < gvStockReturn.PageSize)
                {
                    hdnRowCount.Value = lstInventoryItemsBasket.Count.ToString();
                }
                else
                {
                    gvStockReturn.PageSize = 10;
                    hdnRowCount.Value = gvStockReturn.PageSize.ToString();
                }
                gvStockReturn.DataBind();
                gvStockReturn.Visible = true;
            }
            else
            {
                lblNodata.Text = "No Matching Records Found!";
                contentArea.Style.Add("display", "none");
                tblNoResult.Style.Add("display", "block");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load Stock Return details", ex);
        }
    }

    protected void gvStockReturn_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvStockReturn.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        try
        {
            gvStockReturn.AllowPaging = false;
            //FilterControls(gvStockReturn);
            LoadStockReturnDetails();
            ExportToExcel();
            gvStockReturn.AllowPaging = true;
            gvStockReturn.DataSource = lstInventoryItemsBasket;
            gvStockReturn.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }

    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "StockReturn_Report_";
        
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
        //HttpContext.Current.Response.Write(getReportHeader(true, 33));
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        gvStockReturn.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    public string getReportHeader(bool rptFlag, int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        DateTime fDate = txtFrom.Text.ToInternalDate();
        DateTime tDate = txtTo.Text.ToInternalDate();
        List<Organization> lstOrganization = new List<Organization>();
        rptName = "Stock Return Report";
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        strHeader = "<center><h2>" + OrgName.ToString() + "</h2></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Date : " + DateTimeNow.ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td align='left'>" + "From Date:" + txtFrom.Text + "</td>" + "<td> To Date:" + txtTo.Text + "</td></tr>";
       
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "<tr><td align='left'>" + rptName + "</td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
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
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.TabIndex = -1;
            e.Row.Attributes["onclick"] = string.Format("javascript:SelectRow(this, {0});", e.Row.RowIndex);

            e.Row.Attributes["onkeydown"] = "javascript:return SelectSibling(event);";
            e.Row.Attributes["onselectstart"] = "javascript:return false;";
        }
    }
}
