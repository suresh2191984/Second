using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Data;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_StockIssuedReport : Attune_BasePage
{
    public InventoryReports_StockIssuedReport()
        : base("InventoryReports_StockIssuedReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    decimal TotalCp = 0;
    decimal TotalSp = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            if (!IsPostBack)
            {
                LoadOrgan();
                LoadLocationName();
                txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
                txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
                txtFrom.Focus();
                Loadstockissudreports();


            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading page Details", Ex);
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
                ListItem ddlselect = GetMetaData("Select", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "Select", Value = "0" };
                }
                ddlTrustedOrg.Items.Insert(0, ddlselect);
                //ddlTrustedOrg.Items.Insert(0, "--Select--");
                ddlTrustedOrg.Items[0].Value = "0";
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
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
        LoadLocationName();
    }
    private void LoadLocationName()
    {
        try
        {
            List<Locations>  lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
            ddlLocation.DataSource = (from Loc in lstLocation
                                      where Loc.LocationID != InventoryLocationID
                                      select Loc).ToList();

            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            ListItem ddlselect = GetMetaData("All", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "All", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);
           // ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
            //string ILocationId = InventoryLocationID.ToString();
            //ListItem itemToRemove = ddlLocation.Items.FindByValue(ILocationId);
            //if (itemToRemove != null)
            //{
            //    ddlLocation.Items.Remove(itemToRemove);
            //}
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }

    }

    private void Loadstockissudreports()
    {
        try
        {
            DateTime sfromdate = DateTime.MinValue;
            DateTime.TryParse(txtFrom.Text, out sfromdate);

            DateTime sTodate = DateTime.MinValue;
            DateTime.TryParse(txtTo.Text, out sTodate);

            string preProduct = txtProduct.Text;
            int ToLocationID = int.Parse(ddlLocation.SelectedValue);
            int FromLocationID = InventoryLocationID;
            hdnLocation.Value = ddlLocation.SelectedValue;

            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

            new InventoryReports_BL(base.ContextInfo).GetStockIssedReport(sfromdate, sTodate, preProduct, OrgID, ILocationID, FromLocationID, ToLocationID, out lstInventoryItemsBasket);
            hdnRowCount.Value = lstInventoryItemsBasket.Count.ToString();
            if (lstInventoryItemsBasket.Count > 0)
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Need_Return_Stock_From_Receive_Indent", OrgID, ILocationID, out lstInventoryConfig);
                string PreviousRecQuantity = "N";
                if (lstInventoryConfig.Count > 0)
                {
                    PreviousRecQuantity = lstInventoryConfig[0].ConfigValue;
                }
                if (PreviousRecQuantity == "Y")
                {
                    grdResult.Columns[17].Visible = true;
                }
                lblNoResult.Visible = false;
                tbtotal.Visible = true;
                divPrintarea.Visible = true;
                grdResult.Visible = true;
                grdResult.DataSource = lstInventoryItemsBasket;
                grdResult.DataBind();
                loaddata(lstInventoryItemsBasket);
                divPrint.Attributes.Add("style", "block");
                divPrint.Visible = true;


                //var id =  from item in lstInventoryItemsBasket
                //          select new item {
            }
            else
            {
                lblNoResult.Visible = true;
                divPrintarea.Visible = false;
                divPrint.Attributes.Add("style", "none");
                divPrint.Visible = false;
                tbtotal.Visible = false;

            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading GetStockIssedReport", Ex);
        }
        
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Loadstockissudreports();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "calcHeight", "javascript:calcHeight();", true);
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    //Code Add By Syed
    public DataTable loaddata(List<InventoryItemsBasket> lstCFS)
    {
        DataTable dt = new DataTable();
        try
        {
           
            DataColumn dcol9 = new DataColumn("Indent No");
            DataColumn dcol10 = new DataColumn("Product");
            DataColumn dcol11 = new DataColumn("Category");
            DataColumn dcol12 = new DataColumn("Batch No");
            DataColumn dcol13 = new DataColumn("Issued Qty(lsu)");
            DataColumn dcol14 = new DataColumn("Selling Price(lsu)");
            DataColumn dcol15 = new DataColumn("TotalSP");
            DataColumn dcol16 = new DataColumn("Issued Date");
            DataColumn dcol17 = new DataColumn("Issued By");
            dt.Columns.Add(dcol9);
            dt.Columns.Add(dcol10);
            dt.Columns.Add(dcol11);
            dt.Columns.Add(dcol12);
            dt.Columns.Add(dcol13);
            dt.Columns.Add(dcol14);
            dt.Columns.Add(dcol15);
            dt.Columns.Add(dcol16);
            dt.Columns.Add(dcol17);
            //dt.Columns.Add(dcol18);
            //dt.Columns.Add(dcol19);
            foreach (InventoryItemsBasket item in lstCFS)
            {
                DataRow dr = dt.NewRow();
                dr["Indent No"] = item.Name;
                dr["Product"] = item.ProductName;
                dr["Category"] = item.CategoryName;
                dr["Batch No"] = item.BatchNo;
                dr["Issued Qty(lsu)"] = item.RcvdLSUQty;
                dr["Selling Price(lsu)"] = item.Rate;
                dr["TotalSP"] = item.TSellingPrice;
                dr["Issued Date"] = item.ExpiryDate;
                dr["Issued By"] = item.SupplierName;
                dt.Rows.Add(dr);
            }
            ViewState["report"] = dt;
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
        return dt;
        
    }

    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
       
       try
       {
            Loadstockissudreports();
            ExportToExcel();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }

    public void ExportToExcel()
    {
        try
        {

            string prefix = string.Empty;
            prefix = Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_01 : "Stock_Issued_Report_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            grdResult.BorderWidth = 1;
            var sReport = Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_02 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_02 : "Stock Issued Report";
            var sReports = Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_03 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_03 : "Total CP";
            var sReportsp = Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_04 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_StockIssuedReport_aspx_04 : "Total SP";
            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'> " + sReport + "</span>");
            grdResult.RenderControl(oHtmlTextWriter);
            oHtmlTextWriter.WriteLine("<span> "+
               " <table  width='100%' style='text-align:right' ><tr><td>" + sReports + "</td><td>" + lblTotalCP.Text + "</td></tr>" +
                " <tr><td>" + sReportsp + "</td><td>" + lblTotalSP.Text + " </td></tr></table>" +
                "</span>");
            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Purchase Order Reports-ExportToExcel", ioe);
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
    //Code End

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                decimal Tcp = Convert.ToDecimal(e.Row.Cells[7].Text) * Convert.ToDecimal(e.Row.Cells[8].Text);
                e.Row.Cells[9].Text=string.Format("{0:0.00}", Tcp);
                TotalCp =TotalCp + Convert.ToDecimal(e.Row.Cells[9].Text);
                TotalSp =TotalSp + Convert.ToDecimal(e.Row.Cells[11].Text);
                lblTotalCP.Text = TotalCp.ToString();
                lblTotalSP.Text = TotalSp.ToString();
                if (e.Row.Cells[13].Text == "01/01/0001")
                {
                    e.Row.Cells[13].Text = "";
                }
                
            }
            if (hdnLocation.Value != "0")
            {
                e.Row.Cells[13].Visible = false;
            }
        }

         catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Stock Issued Report.", ex);
         
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}