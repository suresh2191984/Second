using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PurchaseOrderReport : Attune_BasePage
{
    public InventoryReports_PurchaseOrderReport()
        : base("InventoryReports_PurchaseOrderReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryReports_BL invReportsBL;
    List<Organization> lstOrganization = new List<Organization>();

    Products objProducts = new Products();
    PurchaseOrders objPurchaseOrders = new PurchaseOrders();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<PurchaseOrders> lstDWCRGrandTotal = new List<PurchaseOrders>();
    List<Locations> lstLocations = new List<Locations>();
    PurchaseOrders objDWCR = new PurchaseOrders();
    //long returnCode = 0;
    protected void Page_Load(object sender, EventArgs e)
     {
         invReportsBL = new InventoryReports_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadOrgan();
            LoadLocationName(OrgID, ILocationID);
            txtFrom.Text = DateTimeNow.ToExternalDate();
            txtTo.Text = DateTimeNow.ToExternalDate();
            txtFrom.Focus();
        }
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
            ListItem ddlselect = GetMetaData("All", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "All", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);
           // ddlLocation.Items.Insert(0, "--ALL--");
            ddlLocation.Items[0].Value = "0";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }
    private void LoadGrid()
    {
        try
        {
            string IsChecked;
            gvPurchase.Visible = false;
            MainGrandTotal.Visible = false;
            gvPurchase_Alternate.Visible = false;
            MainGrandTotal_Alt.Visible = false;
            objPurchaseOrders.BranchID = Int32.Parse(ddlLocation.SelectedValue);
            objPurchaseOrders.OrgID = OrgID;
            objPurchaseOrders.OrgAddressID = ILocationID;
            if (chkDefault.Checked == true)
            {
                IsChecked = "Y";
            }
            else
            {
                IsChecked = "N";
            }
            ClearVal();
            invReportsBL.GetPurchaseOrderReport(Convert.ToDateTime(txtFrom.Text),
                  Convert.ToDateTime(txtTo.Text), objPurchaseOrders.BranchID, objPurchaseOrders.OrgID, objPurchaseOrders.OrgAddressID,IsChecked,txtSupplier.Text.Trim(), out lstPurchaseOrders);

           

            if (chkDefault.Checked == true)
            {
                gvPurchase.DataSource = lstPurchaseOrders;
                if (lstPurchaseOrders.Count < gvPurchase.PageSize)
                {
                    hdnRowCount.Value = lstPurchaseOrders.Count.ToString();
                }
                else
                {
                    hdnRowCount.Value = gvPurchase.PageSize.ToString();
                }
                gvPurchase.Visible = true;
                gvPurchase.DataBind();
                
                if (lstPurchaseOrders.Count > 0)
                {
                    tblTool.Style.Add("display", "block");
                }
                else
                {
                    tblTool.Style.Add("display", "none");
                    gvPurchase.Visible = false;
                }
                if (lstPurchaseOrders.Count == 0)
                {
                    gvPurchase.Visible = false;
                    MainGrandTotal.Visible = false;
                }
                foreach (PurchaseOrders fb in lstPurchaseOrders)
                {
                    objDWCR.NetValue += fb.NetValue;
                    objDWCR.GrandTotal += fb.TaxableAmount0;
                    objDWCR.TaxAmount0 += fb.TaxAmount0;
                    objDWCR.NetRoundofValue += fb.NetRoundofValue;//kumaresan
                }
                lstDWCRGrandTotal.Add(objDWCR);
                if (lstDWCRGrandTotal.Count >= 0)
                {
                    MainGrandTotal.Visible = true;
                    MainGrandTotal.DataSource = lstDWCRGrandTotal;
                    MainGrandTotal.DataBind();

                }
                else
                {
                    MainGrandTotal.Visible = false;
                }
            }
            else
            {
                gvPurchase_Alternate.DataSource = lstPurchaseOrders;
                if (lstPurchaseOrders.Count < gvPurchase_Alternate.PageSize)
                {
                    hdnRowCount.Value = lstPurchaseOrders.Count.ToString();
                }
                else
                {
                    hdnRowCount.Value = gvPurchase_Alternate.PageSize.ToString();
                }
                gvPurchase_Alternate.DataBind();
                gvPurchase_Alternate.Visible = true;
                if (lstPurchaseOrders.Count > 0)
                {
                    tblTool.Style.Add("display", "block");
                }
                else
                {
                    tblTool.Style.Add("display", "none");
                    gvPurchase_Alternate.Visible = false;
                }
                if (lstPurchaseOrders.Count == 0)
                {
                    gvPurchase_Alternate.Visible = false;
                    MainGrandTotal_Alt.Visible = false;
                }
                foreach (PurchaseOrders fb in lstPurchaseOrders)
                {
                    objDWCR.NetValue += fb.NetValue;
                    objDWCR.GrandTotal += fb.GrandTotal;
                    objDWCR.TaxAmount5 += fb.TaxAmount5;
                    objDWCR.TaxAmount4 += fb.TaxAmount4;
                    objDWCR.TaxAmount12 += fb.TaxAmount12;
                    objDWCR.TaxAmount13 += fb.TaxAmount13;
                    objDWCR.TaxAmount14 += fb.TaxAmount14;
                    objDWCR.TaxAmount0 += fb.TaxAmount0;
                    objDWCR.CSTAmount += fb.CSTAmount;
                    objDWCR.Others += fb.Others;
                    // plus or minus roundofvalue based on roundoftype.
                    if (fb.RoundOfType == "LL")
                    {
                        objDWCR.RoundofValue -= fb.RoundofValue;
                    }
                    else
                    {
                        objDWCR.RoundofValue += fb.RoundofValue;
                    }
                    objDWCR.NetRoundofValue += fb.NetRoundofValue;

                }
                lstDWCRGrandTotal.Add(objDWCR);
                if (lstDWCRGrandTotal.Count >= 0)
                {
                    MainGrandTotal_Alt.Visible = true;
                    MainGrandTotal_Alt.DataSource = lstDWCRGrandTotal;
                    MainGrandTotal_Alt.DataBind();
                }
                else
                {
                    MainGrandTotal_Alt.Visible = false;

                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - SalesReport.aspx", Ex);
        }
    }

    private void ClearVal()
    {
        lblTotalNet1.Text = "0.00";
        lblVatothers.Text = "0.00";
        lblVat13.Text = "0.00";
        lblVat0.Text = "0.00";
        lblVat12.Text = "0.00";
        lblVat4.Text = "0.00";
        lblVat5.Text = "0.00";
        lblVat14.Text = "0.00";
        lblTotalGross.Text = "0.00";
        lblPaidAmt.Text = "0.00";
        lblTotalNet.Text = "0.00";
        //.Text = "0.00";
        lblTaxableAmount0.Text = "0.00";
        lblVRoundOfvalue.Text = "0.00";
        lblVNetRoundOfvalue.Text = "0.00";
    }

    protected void gvPurchase_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvPurchase.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void gvPurchase_Alternate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvPurchase_Alternate.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void gvPurchase_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PurchaseOrders IOM1 = (PurchaseOrders)e.Row.DataItem;
                lblTotalNet.Text = String.Format("{0:0.00}", (IOM1.NetValue + decimal.Parse(lblTotalNet.Text)));
                lblTaxableAmount0.Text = String.Format("{0:0.00}", (IOM1.TaxableAmount0 + decimal.Parse(lblTaxableAmount0.Text)));
                lblPaidAmt.Text = String.Format("{0:0.00}", (IOM1.TaxAmount0 + decimal.Parse(lblPaidAmt.Text)));
               // lblComments.Text = String.Format("{0:0.00}", (IOM1.TaxAmount0 + decimal.Parse(lblComments.Text)));
            }
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PurchaseOrderReport.", ex);
        }
    }
    protected void gvPurchase_Alternate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PurchaseOrders IOM = (PurchaseOrders)e.Row.DataItem;
                ((Label)e.Row.FindControl("lblBillID")).Text = IOM.PurchaseOrderNo.ToString();
                Label lblround = (Label)e.Row.FindControl("lblRoundOfvalue");
                lblTotalGross.Text = String.Format("{0:0.00}", (IOM.GrandTotal + decimal.Parse(lblTotalGross.Text)));
                lblTotalNet1.Text = String.Format("{0:0.00}", (IOM.NetValue + decimal.Parse(lblTotalNet1.Text)));
                lblVat4.Text = String.Format("{0:0.00}", (IOM.TaxAmount4 + decimal.Parse(lblVat4.Text)));
                lblVat0.Text = String.Format("{0:0.00}", (IOM.TaxAmount0 + decimal.Parse(lblVat0.Text)));
                lblVat5.Text = String.Format("{0:0.00}", (IOM.TaxAmount5 + decimal.Parse(lblVat5.Text)));
                lblVat12.Text = String.Format("{0:0.00}", (IOM.TaxAmount12 + decimal.Parse(lblVat12.Text)));
                lblVat13.Text = String.Format("{0:0.00}", (IOM.TaxAmount13 + decimal.Parse(lblVat13.Text)));
                lblVat14.Text = String.Format("{0:0.00}", (IOM.TaxAmount14 + decimal.Parse(lblVat14.Text)));
                lblVatothers.Text = String.Format("{0:0.00}", (IOM.Others + decimal.Parse(lblVatothers.Text)));
                lblCSTTax.Text = String.Format("{0:0.00}", (IOM.CSTAmount + decimal.Parse(lblCSTTax.Text)));

                // plus or minus roundofvalue based on roundoftype.
                if (IOM.RoundOfType == "LL")
                {
                    lblround.Text = "-" + lblround.Text;
                    lblVRoundOfvalue.Text = Convert.ToString(decimal.Parse(lblVRoundOfvalue.Text) - IOM.RoundofValue);
                }
                if(IOM.RoundOfType == "UL")
                {
                    lblround.Text = "+" + lblround.Text;
                    lblVRoundOfvalue.Text = Convert.ToString(decimal.Parse(lblVRoundOfvalue.Text) + IOM.RoundofValue);
                }
                lblVNetRoundOfvalue.Text = String.Format("{0:0.00}", (IOM.NetRoundofValue + decimal.Parse(lblVNetRoundOfvalue.Text)));
                
            }
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PurchaseOrderReport.", ex);
        }
    }

    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {

            hdnStatus.Value = "Y";
            gvPurchase.AllowPaging = false;
            gvPurchase_Alternate.AllowPaging = false;
           
            LoadGrid();

            ExportToExcel(gvPurchase);
            ExportToExcel(gvPurchase_Alternate);
            ExportToExcel(MainGrandTotal);
            ExportToExcel(MainGrandTotal_Alt);


        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void ExportToExcel(Control CTR1)
    {
        try
        {
            string PurchaseHeader = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_17 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_17 : "Purchase Order Reports";
            string Total = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_18 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_18 : "Total Details:";
            string prefix = string.Empty;
            prefix = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_01 : "Purchase Order Reports_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            // CTR1.BorderWidth = 1;

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>"+PurchaseHeader+"</span>");
            // CTR1.RenderControl(oHtmlTextWriter);

            gvPurchase_Alternate.RenderControl(oHtmlTextWriter);
            gvPurchase.RenderControl(oHtmlTextWriter);

            oHtmlTextWriter.WriteLine("<br /><span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>" + Total + "</span><br />");
            MainGrandTotal.RenderControl(oHtmlTextWriter);
            MainGrandTotal_Alt.RenderControl(oHtmlTextWriter);

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
    private void LoadPOGrid()
    {
        try
        {
            string IsChecked = "";
            if (chkDefault.Checked == true)
            {
                 IsChecked = "Y";
            }
            else
            {
                 IsChecked = "N";
            }
            //ErrorDisplay1.Visible = false;
            objPurchaseOrders.BranchID = Int32.Parse(ddlLocation.SelectedValue);
            objPurchaseOrders.OrgID = OrgID;
            objPurchaseOrders.OrgAddressID = ILocationID;
            ClearVal();
            invReportsBL.GetPurchaseOrderReport(Convert.ToDateTime(txtFrom.Text),
              Convert.ToDateTime(txtTo.Text), objPurchaseOrders.BranchID, objPurchaseOrders.OrgID, objPurchaseOrders.OrgAddressID,IsChecked,txtSupplier.Text.Trim(), out lstPurchaseOrders);
            if (chkDefault.Checked == true)
            {
                LoadDispensingReportHeaders_Alternate(lstPurchaseOrders);
            }
            else
            {
                LoadDispensingReportHeaders(lstPurchaseOrders);
            }

        }
        catch (Exception Ex)
        {
            if (Ex.Message.StartsWith("Thread") == false)
            {
                Response.Redirect("~/Error.aspx?ErrorMsg = " + Ex.Message);
            }
            CLogger.LogError("Error while Loading Location - PurchaseOrderReport.aspx", Ex);
        }

    }
    private void LoadDispensingReportHeaders(List<PurchaseOrders> lstPurchaseOrders)
    {
        if (lstPurchaseOrders.Count() > 0)
        {
            tblTool.Style.Add("display", "Block");
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();

            TableCell hSrdDate = new TableCell();
            TableCell hSrdNo = new TableCell();
            TableCell hSupplierName = new TableCell();
            TableCell hTinNo = new TableCell();
            TableCell hInvoiceNo = new TableCell();
            TableCell hNetValue = new TableCell();
            TableCell hGrandTotal = new TableCell();
            TableCell hVat4 = new TableCell();
            TableCell hVat12 = new TableCell();
            TableCell hVat0 = new TableCell();
            TableCell hVatots = new TableCell();

            hSrdDate.Attributes.Add("align", "left");
            hSrdDate.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_03 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_03 : "SRD Date";
            hSrdDate.Width = Unit.Percentage(8);

            hSrdNo.Attributes.Add("align", "left");
            hSrdNo.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_04 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_04 : "SRD No";
            hSrdNo.Width = Unit.Percentage(8);

            hSupplierName.Attributes.Add("align", "left");
            hSupplierName.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_05 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_05 : "Supplier Name";
            hSupplierName.Width = Unit.Percentage(12);

            hTinNo.Attributes.Add("align", "left");
            hTinNo.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_06 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_06 : "TIN No.";
            hTinNo.Width = Unit.Percentage(8);

            hInvoiceNo.Attributes.Add("align", "left");
            hInvoiceNo.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_07 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_07 : "Invoice No.";
            hInvoiceNo.Width = Unit.Percentage(8);

            hNetValue.Attributes.Add("align", "left");
            hNetValue.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_08 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_08 : "Net Value";
            hNetValue.Width = Unit.Percentage(8);

            hGrandTotal.Attributes.Add("align", "left");
            hGrandTotal.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_09 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_09 : "Grand Total";
            hGrandTotal.Width = Unit.Percentage(8);

            hVat4.Attributes.Add("align", "left");
            hVat4.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_10 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_10 : "Vat (4%)";
            hVat4.Width = Unit.Percentage(6);

            hVat12.Attributes.Add("align", "left");
            hVat12.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_11 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_11 : "Vat (12.5%)";
            hVat12.Width = Unit.Percentage(6);

            hVat0.Attributes.Add("align", "left");
            hVat0.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_12 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_12 : "Vat (0%)";
            hVat0.Width = Unit.Percentage(6);

            hVatots.Attributes.Add("align", "left");
            hVatots.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_13 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_13 : "Others";
            hVatots.Width = Unit.Percentage(6);

            headRow.Cells.Add(hSrdNo);
            headRow.Cells.Add(hSupplierName);
            headRow.Cells.Add(hTinNo);
            headRow.Cells.Add(hInvoiceNo);
            headRow.Cells.Add(hSrdDate);
            headRow.Cells.Add(hNetValue);
            headRow.Cells.Add(hGrandTotal);
            headRow.Cells.Add(hVat4);
            headRow.Cells.Add(hVat12);
            headRow.Cells.Add(hVat0);
            headRow.Cells.Add(hVatots);
            headRow.CssClass = "dyTbHeader";
            if (hdnStatus.Value == "Y")
            {
                headRow.Style.Add("background-color", "#2c88b1");
                headRow.Style.Add("font-weight", "bold");
                headRow.Style.Add("color", "#FFFFFF");
            }
            tblpurchaseOrder.Rows.Add(headRow);


            foreach (PurchaseOrders item in lstPurchaseOrders)
            {
                TableRow dheadRow = new TableRow();
                TableCell dSrdDate = new TableCell();
                TableCell dSrdNo = new TableCell();
                TableCell dSupplierName = new TableCell();
                TableCell dTinNo = new TableCell();
                TableCell dInvoiceNo = new TableCell();
                TableCell dNetValue = new TableCell();
                TableCell dGrandTotal = new TableCell();
                TableCell dVat4 = new TableCell();
                TableCell dVat12 = new TableCell();
                TableCell dVat0 = new TableCell();
                TableCell dVatots = new TableCell();
               
                dSrdDate.Attributes.Add("align", "left");
                dSrdDate.Text = item.PurchaseOrderDate.ToString("dd/MMM/yyyy");

                dSrdNo.Attributes.Add("align", "left");
                dSrdNo.Text = item.PurchaseOrderNo;

                dSupplierName.Attributes.Add("align", "left");
                dSupplierName.Text = item.SupplierName;

                dTinNo.Attributes.Add("align", "left");
                dTinNo.Text = item.TinNo;

                dInvoiceNo.Attributes.Add("align", "left");
                dInvoiceNo.Text = item.InvoiceNo;
                
                dNetValue.Attributes.Add("align", "left");
                dNetValue.Text = item.NetValue.ToString();

                dGrandTotal.Attributes.Add("align", "left");
                dGrandTotal.Text = item.GrandTotal.ToString();

                dVat4.Attributes.Add("align", "left");
                dVat4.Text = item.TaxAmount4.ToString();

                dVat12.Attributes.Add("align", "left");
                dVat12.Text = item.TaxAmount12.ToString();

                dVat0.Attributes.Add("align", "left");
                dVat0.Text = item.TaxAmount0.ToString();

                dVatots.Attributes.Add("align", "left");
                dVatots.Text = item.Others.ToString();

                dheadRow.Cells.Add(dSrdNo);
                dheadRow.Cells.Add(dSupplierName);
                dheadRow.Cells.Add(dTinNo);
                dheadRow.Cells.Add(dInvoiceNo);
                dheadRow.Cells.Add(dSrdDate);
                dheadRow.Cells.Add(dNetValue);
                dheadRow.Cells.Add(dGrandTotal);
                dheadRow.Cells.Add(dVat4);
                dheadRow.Cells.Add(dVat12);
                dheadRow.Cells.Add(dVat0);
                dheadRow.Cells.Add(dVatots);
                dheadRow.CssClass = "dataheaderInvCtrl";
                tblpurchaseOrder.Rows.Add(dheadRow);
            }
            if (hdnStatus.Value == "Y")
            {
            }
        }
        hdnStatus.Value = "N";
    }
    private void LoadDispensingReportHeaders_Alternate(List<PurchaseOrders> lstPurchaseOrders)
    {
        if (lstPurchaseOrders.Count() > 0)
        {
            tblTool.Style.Add("display", "Block");
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();

            TableCell hPODate = new TableCell();
            TableCell hSupplierName = new TableCell();
            TableCell hTinNo = new TableCell();
            TableCell hInvoiceNo = new TableCell();
            TableCell hPaidAmt = new TableCell();
            TableCell hTaxableAmt = new TableCell();
            TableCell hTax = new TableCell();
            TableCell hNetValue = new TableCell();

            hPODate.Attributes.Add("align", "left");
            hPODate.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_03 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_03 : "SRD Date";
            hPODate.Width = Unit.Percentage(8);

            hSupplierName.Attributes.Add("align", "left");
            hSupplierName.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_05 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_05 : "Supplier Name";
            hSupplierName.Width = Unit.Percentage(12);

            hTinNo.Attributes.Add("align", "left");
            hTinNo.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_06 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_06 : "TIN No.";
            hTinNo.Width = Unit.Percentage(8);

            hInvoiceNo.Attributes.Add("align", "left");
            hInvoiceNo.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_07 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_07 : "Invoice No.";
            hInvoiceNo.Width = Unit.Percentage(8);
            
            hPaidAmt.Attributes.Add("align", "left");
            hPaidAmt.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_14 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_14 : "Paid Amt";
            hPaidAmt.Width = Unit.Percentage(8);
            
            hTaxableAmt.Attributes.Add("align", "left");
            hTaxableAmt.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_15 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_15 : "Taxable Amt";
            hTaxableAmt.Width = Unit.Percentage(8);

            hTax.Attributes.Add("align", "left");
            hTax.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_16 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_16 : "Tax";
            hTax.Width = Unit.Percentage(8);

            hNetValue.Attributes.Add("align", "left");
            hNetValue.Text = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_08 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseOrderReport_aspx_08 : "Net Value";
            hNetValue.Width = Unit.Percentage(8);

            headRow.Cells.Add(hPODate);
            headRow.Cells.Add(hSupplierName);
            headRow.Cells.Add(hTinNo);
            headRow.Cells.Add(hInvoiceNo);
            headRow.Cells.Add(hPaidAmt);
            headRow.Cells.Add(hTaxableAmt);
            headRow.Cells.Add(hTax);
            headRow.Cells.Add(hNetValue);
            headRow.CssClass = "dyTbHeader";
            if (hdnStatus.Value == "Y")
            {
                headRow.Style.Add("background-color", "#2c88b1");
                headRow.Style.Add("font-weight", "bold");
                headRow.Style.Add("color", "#FFFFFF");
            }
            tblpurchaseOrder.Rows.Add(headRow);

            foreach (PurchaseOrders item in lstPurchaseOrders)
            {
                TableRow dheadRow = new TableRow();
                TableCell dPODate = new TableCell();
                TableCell dSupplierName = new TableCell();
                TableCell dTinNo = new TableCell();
                TableCell dInvoiceNo = new TableCell();
                TableCell dPaidAmt = new TableCell();
                TableCell dTaxableAmt = new TableCell();
                TableCell dTax = new TableCell();
                TableCell dNetValue = new TableCell();

                dPODate.Attributes.Add("align", "left");
                dPODate.Text = item.CreatedAt.ToString("dd/MMM/yyyy");

                dSupplierName.Attributes.Add("align", "left");
                dSupplierName.Text = item.SupplierName;

                dTinNo.Attributes.Add("align", "left");
                dTinNo.Text = item.TinNo;

                dInvoiceNo.Attributes.Add("align", "left");
                dInvoiceNo.Text = item.InvoiceNo;

                dPaidAmt.Attributes.Add("align", "left");
                dPaidAmt.Text = item.TaxAmount0.ToString();
                
                dTaxableAmt.Attributes.Add("align", "left");
                dTaxableAmt.Text = item.TaxableAmount0.ToString();

                dTax.Attributes.Add("align", "left");
                dTax.Text = item.Comments;

                dNetValue.Attributes.Add("align", "left");
                dNetValue.Text = item.NetValue.ToString();

                dheadRow.Cells.Add(dPODate);
                dheadRow.Cells.Add(dSupplierName);
                dheadRow.Cells.Add(dTinNo);
                dheadRow.Cells.Add(dInvoiceNo);
                dheadRow.Cells.Add(dPaidAmt);
                dheadRow.Cells.Add(dTaxableAmt);
                dheadRow.Cells.Add(dTax);
                dheadRow.Cells.Add(dNetValue);
                dheadRow.CssClass = "dataheaderInvCtrl";
                tblpurchaseOrder.Rows.Add(dheadRow);
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
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
   

}
