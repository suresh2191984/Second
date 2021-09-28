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
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_PurchaseTaxReports : Attune_BasePage
{
    public InventoryReports_PurchaseTaxReports()
        : base("InventoryReports_PurchaseTaxReports_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Suppliers> lstSuppliers = new List<Suppliers>();

    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    InventoryCommon_BL inventoryBL;
    List<Organization> lstOrganization = new List<Organization>();

    Products objProducts = new Products();
    PurchaseOrders objPurchaseOrders = new PurchaseOrders();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<Locations> lstLocations = new List<Locations>();
    //long returnCode = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadLocationName(OrgID, ILocationID);
            //txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
            //txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();

        }
    }

    private void LoadPOGrid()
    {
        try
        {
            objPurchaseOrders.BranchID = Int32.Parse(ddlLocation.SelectedValue);
            objPurchaseOrders.OrgID = OrgID;
            objPurchaseOrders.OrgAddressID = ILocationID;
            new InventoryReports_BL(this.ContextInfo).GetPurchaseOrderReport(Convert.ToDateTime(txtFrom.Text),
              Convert.ToDateTime(txtTo.Text), objPurchaseOrders.BranchID, objPurchaseOrders.OrgID, objPurchaseOrders.OrgAddressID, "N", txtSupplier.Text.Trim(), out lstPurchaseOrders);
            LoadDispensingReportHeaders(lstPurchaseOrders,objPurchaseOrders.BranchID);

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - PurchaseTaxReport.aspx", Ex);
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        LoadPOGrid();
    }

    private void LoadDispensingReportHeaders(List<PurchaseOrders> lstPurchaseOrders,int BranchID)
    {

        decimal tax0= 0;
        decimal tax4 = 0;
        decimal tax5 = 0;
        decimal tax12 = 0;
        decimal tax13 = 0;
        decimal tax14 = 0;
        decimal taxable0 = 0;
        decimal taxable4 = 0;
        decimal taxable5 = 0;
        decimal taxable12 = 0;
        decimal taxable13= 0;
        decimal taxable14 = 0;
        decimal nettax= 0;
        decimal nettaxable = 0;
        decimal others=0;

         
        hdnRowCount.Value = (lstPurchaseOrders.Count+1).ToString();
        tblTool.Style.Add("display", "None");
        if (lstPurchaseOrders.Count() > 0)
        {

            tblTool.Style.Add("display", "Block");
            TableRow headRow = new TableRow();
            TableRow footRow = new TableRow();

            TableCell hSrdDate = new TableCell();
            TableCell hSNo = new TableCell();
            TableCell hSrdNo = new TableCell();
            TableCell hSupplierName = new TableCell();
            TableCell hTinNo = new TableCell();
            TableCell hInvoiceNo = new TableCell();
            TableCell hNetValue = new TableCell();
            TableCell hGrandTotal = new TableCell();
            TableCell hVat4 = new TableCell();
            TableCell hVat12 = new TableCell();
            TableCell hVat0 = new TableCell();

            TableCell hVat5 = new TableCell();
            TableCell hVat13 = new TableCell();
            TableCell hVat14 = new TableCell();
            
            TableCell hVatable4 = new TableCell();
            TableCell hVatable12 = new TableCell();
            TableCell hVatable0 = new TableCell();

            TableCell hVatable5 = new TableCell();
            TableCell hVatable13 = new TableCell();
            TableCell hVatable14 = new TableCell();
            TableCell hVatableothers = new TableCell();
            TableCell hLocationName = new TableCell();
            

            TableCell hVatots = new TableCell();

            hSNo.Attributes.Add("align", "left");
            hSNo.Text = "S.No.";
            hSNo.Width = Unit.Percentage(2);

            hSrdNo.Attributes.Add("align", "left");
            hSrdNo.Text = "SRD No";
            hSrdNo.Width = Unit.Percentage(8);

            hSupplierName.Attributes.Add("align", "left");
            hSupplierName.Text = "Supplier Name";
            hSupplierName.Width = Unit.Percentage(12);

            hTinNo.Attributes.Add("align", "left");
            hTinNo.Text = "Tin No.";
            hTinNo.Width = Unit.Percentage(8);



            hInvoiceNo.Attributes.Add("align", "left");
            hInvoiceNo.Text = "Invoice No.";
            hInvoiceNo.Width = Unit.Percentage(8);

            hSrdDate.Attributes.Add("align", "left");
            hSrdDate.Text = "SRD Date";
            hSrdDate.Width = Unit.Percentage(8);

            hNetValue.Attributes.Add("align", "left");
            hNetValue.Text = "Net Total";
            hNetValue.Width = Unit.Percentage(8);

            hGrandTotal.Attributes.Add("align", "left");
            hGrandTotal.Text = "Net Tax";
            hGrandTotal.Width = Unit.Percentage(8);

            hVat4.Attributes.Add("align", "left");
            hVat4.Text = "4% Tax";
            hVat4.Width = Unit.Percentage(6);
           
           

            hVat12.Attributes.Add("align", "left");
            hVat12.Text = "12.5% Tax";
            hVat12.Width = Unit.Percentage(6);

            hVat0.Attributes.Add("align", "left");
            hVat0.Text = "0% Tax";
            hVat0.Width = Unit.Percentage(6);

            hVat5.Attributes.Add("align", "left");
            hVat5.Text = "5% Tax";
            hVat5.Width = Unit.Percentage(6);

            hVat13.Attributes.Add("align", "left");
            hVat13.Text = "13.5% Tax";
            hVat13.Width = Unit.Percentage(6);

            hVat14.Attributes.Add("align", "left");
            hVat14.Text = "14.5% Tax";
            hVat14.Width = Unit.Percentage(6);


        

            hVatable4.Attributes.Add("align", "left");
            hVatable4.Text = "4% Taxable";
            hVatable4.Width = Unit.Percentage(6);

            hVatable12.Attributes.Add("align", "left");
            hVatable12.Text = "12.5% Taxable";
            hVatable12.Width = Unit.Percentage(6);

            hVatable0.Attributes.Add("align", "left");
            hVatable0.Text = "0% Taxable";
            hVatable0.Width = Unit.Percentage(6);

            hVatable5.Attributes.Add("align", "left");
            hVatable5.Text = "5% Taxable";
            hVatable5.Width = Unit.Percentage(6);
            hVatable13.Attributes.Add("align", "left");
            hVatable13.Text = "13.5% Taxable";
            hVatable13.Width = Unit.Percentage(6);

            hVatable14.Attributes.Add("align", "left");
            hVatable14.Text = "14.5% Taxable";
            hVatable14.Width = Unit.Percentage(6);

            hVatots.Attributes.Add("align", "left");
            hVatots.Text = "Other Tax%";
            hVatots.Width = Unit.Percentage(6);

            hLocationName.Attributes.Add("align", "left");
            hLocationName.Text = "Location Name";
            hLocationName.Width = Unit.Percentage(12);

            headRow.Cells.Add(hSNo);
            headRow.Cells.Add(hSrdDate);
            headRow.Cells.Add(hSrdNo);
            headRow.Cells.Add(hSupplierName);
            headRow.Cells.Add(hTinNo);
            headRow.Cells.Add(hInvoiceNo);
            headRow.Cells.Add(hVat0);
            headRow.Cells.Add(hVat4);
            headRow.Cells.Add(hVat5);
            headRow.Cells.Add(hVat12);                    
            headRow.Cells.Add(hVat13);
            headRow.Cells.Add(hVat14);
            headRow.Cells.Add(hVatots);
            headRow.Cells.Add(hVatable0);
            headRow.Cells.Add(hVatable4);
            headRow.Cells.Add(hVatable5);
            headRow.Cells.Add(hVatable12);            
            headRow.Cells.Add(hVatable13);
            headRow.Cells.Add(hVatable14);
          
            headRow.Cells.Add(hGrandTotal);
            headRow.Cells.Add(hNetValue);
            if (BranchID == 0)
            {
                headRow.Cells.Add(hLocationName);
            }
            headRow.CssClass = "dyTbHeader";
            if (hdnStatus.Value == "Y")
            {
                headRow.Style.Add("background-color", "#2c88b1");
                headRow.Style.Add("font-weight", "bold");
                headRow.Style.Add("color", "#FFFFFF");
            }
            tblpurchaseOrder.Rows.Add(headRow);

            int i = 1;
            foreach (PurchaseOrders item in lstPurchaseOrders)
            {
                
                TableRow dheadRow = new TableRow();
                dheadRow.Font.Name = "calibric";
                dheadRow.Font.Size = 8;

                TableCell dSno = new TableCell();
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
                TableCell dVat5 = new TableCell();
                TableCell dVat13 = new TableCell();
                TableCell dVat14 = new TableCell();
                TableCell dVatots = new TableCell();
                TableCell dVatable4 = new TableCell();
                TableCell dVatable12 = new TableCell();
                TableCell dVatable5 = new TableCell();
                TableCell dVatable13 = new TableCell();
                TableCell dVatable14 = new TableCell();
                TableCell dVatable0 = new TableCell();
                TableCell dLocationName = new TableCell();
              
                
                dSno.Attributes.Add("align", "left");
                dSno.Text = i.ToString();
               



                dSrdNo.Attributes.Add("align", "left");
                dSrdNo.Text = item.PurchaseOrderNo;

                dSupplierName.Attributes.Add("align", "left");
                dSupplierName.Text = item.SupplierName;

                dTinNo.Attributes.Add("align", "left");
                dTinNo.Text = item.TinNo;

                dInvoiceNo.Attributes.Add("align", "left");
                dInvoiceNo.Text = item.InvoiceNo;

                dSrdDate.Attributes.Add("align", "left");
                dSrdDate.Text = item.CreatedAt.ToString("dd/MMM/yyyy");

                dNetValue.Attributes.Add("align", "Right");
                dNetValue.Text = (item.TaxAmount0 + item.TaxAmount12 + item.TaxAmount4 + item.TaxAmount5 + item.TaxAmount13 + item.TaxAmount14).ToString();
                nettaxable += (item.TaxAmount0 + item.TaxAmount12 + item.TaxAmount4 + item.TaxAmount5 + item.TaxAmount13 + item.TaxAmount14);


                dVat4.Attributes.Add("align", "Right");
                dVat4.Text = item.TaxAmount4.ToString();
                tax4 += item.TaxAmount4;

                dVatable4.Attributes.Add("align", "Right");
                dVatable4.Text = item.TaxableAmount4.ToString();
                taxable4 += item.TaxableAmount4;




                dVat12.Attributes.Add("align", "Right");
                dVat12.Text = item.TaxAmount12.ToString();
                tax12 += item.TaxAmount12;

                dVatable12.Attributes.Add("align", "Right");
                dVatable12.Text = item.TaxableAmount12.ToString();
                taxable12 += item.TaxableAmount12;


                dVat0.Attributes.Add("align", "Right");
                dVat0.Text = item.TaxAmount0.ToString();
                tax0 += item.TaxAmount0;

                dVatable0.Attributes.Add("align", "Right");
                dVatable0.Text = item.TaxableAmount0.ToString();
                taxable0 += item.TaxableAmount0;

                dVat5.Attributes.Add("align", "Right");
                dVat5.Text = item.TaxAmount5.ToString();
                tax5 += item.TaxAmount5;

                dVatable5.Attributes.Add("align", "Right");
                dVatable5.Text = item.TaxableAmount5.ToString();
                taxable5 += item.TaxableAmount5;


                dVat13.Attributes.Add("align", "Right");
                dVat13.Text = item.TaxAmount13.ToString();
                tax13 += item.TaxAmount13;

                

                dVatable13.Attributes.Add("align", "Right");
                dVatable13.Text = item.TaxableAmount13.ToString();
                taxable13 += item.TaxableAmount13;


                dVat14.Attributes.Add("align", "Right");
                dVat14.Text = item.TaxAmount14.ToString();
                tax14 += item.TaxAmount14;

                dVatable14.Attributes.Add("align", "Right");
                dVatable14.Text = item.TaxableAmount14.ToString();
                taxable14 += item.TaxableAmount14;

                dLocationName.Attributes.Add("align", "Right");
                dLocationName.Text = item.LocationName;

                dGrandTotal.Attributes.Add("align", "Right");
                dGrandTotal.Text = (item.TaxableAmount0 + item.TaxableAmount12 + item.TaxableAmount4 + item.TaxableAmount5 + item.TaxableAmount13 + (item.TaxAmount0 + item.TaxAmount12 + item.TaxAmount4 + item.TaxAmount5 + item.TaxAmount13 + item.TaxAmount14)).ToString();
                nettax += (item.TaxableAmount0 + item.TaxableAmount12 + item.TaxableAmount4 + item.TaxableAmount5 + item.TaxableAmount13 + item.TaxAmount0 + item.TaxAmount12 + item.TaxAmount4 + item.TaxAmount5 + item.TaxAmount13 + item.TaxAmount14);
               
                dVatots.Text = item.Others.ToString();
                others+=item.Others ;
                dheadRow.Cells.Add(dSno);
                dheadRow.Cells.Add(dSrdDate);
                dheadRow.Cells.Add(dSrdNo);
                dheadRow.Cells.Add(dSupplierName);
                dheadRow.Cells.Add(dTinNo);
                dheadRow.Cells.Add(dInvoiceNo);
                dheadRow.Cells.Add(dVat0);
                dheadRow.Cells.Add(dVat4);
                dheadRow.Cells.Add(dVat5);
              
                dheadRow.Cells.Add(dVat12);
                dheadRow.Cells.Add(dVat13);
                dheadRow.Cells.Add(dVat14);
                dheadRow.Cells.Add(dVatots);
                dheadRow.Cells.Add(dVatable0);
                dheadRow.Cells.Add(dVatable4);
                dheadRow.Cells.Add(dVatable5);
                dheadRow.Cells.Add(dVatable12);
                dheadRow.Cells.Add(dVatable13);
                dheadRow.Cells.Add(dVatable14);
                dheadRow.Cells.Add(dNetValue);
                
                dheadRow.Cells.Add(dGrandTotal);
                if (BranchID == 0)
                {
                    dheadRow.Cells.Add(dLocationName);
                }
                dheadRow.TabIndex = -1;
                dheadRow.Attributes["onclick"] = string.Format("javascript:SelectRow(this, {0});", i.ToString());
                dheadRow.Attributes["onkeydown"] = "javascript:return SelectSibling(event);";
                dheadRow.Attributes["onselectstart"] = "javascript:return false;";
             
                
                dheadRow.CssClass = "dataheaderInvCtrl";
                i++;
                tblpurchaseOrder.Rows.Add(dheadRow);
            }
            TableRow footerRow = new TableRow();
            footerRow.BackColor = System.Drawing.Color.DarkGray;
            footerRow.Font.Name = "calibric";
            footerRow.Font.Size = 10;
            footerRow.Font.Bold = true;
            TableCell fSno = new TableCell();
            TableCell fSrdDate = new TableCell();
            TableCell fSrdNo = new TableCell();
            TableCell fSupplierName = new TableCell();
            TableCell fTinNo = new TableCell();
            TableCell fInvoiceNo = new TableCell();

            TableCell fVat4 = new TableCell();
            TableCell fVat12 = new TableCell();
            TableCell fVat0 = new TableCell();
            TableCell fVat5 = new TableCell();
            TableCell fVat13 = new TableCell();
            TableCell fVat14 = new TableCell();
            TableCell fothers = new TableCell();
            TableCell fVatable4 = new TableCell();
            TableCell fVatable12 = new TableCell();
            TableCell fVatable0 = new TableCell();
            TableCell fVatable5 = new TableCell();
            TableCell fVatable13 = new TableCell();
            TableCell fVatable14= new TableCell();

            TableCell fGrandTotal = new TableCell();
            TableCell fNetValue = new TableCell();
            TableCell fLoationName = new TableCell();

            fSno.Attributes.Add("align", "right");
            fSno.Text = "";
            fSno.Width = Unit.Percentage(2);

            fSrdDate.Attributes.Add("align", "right");
            fSrdDate.Text = "";
            fSrdDate.Width = Unit.Percentage(8);

            fSrdNo.Attributes.Add("align", "right");
            fSrdNo.Text = "";
            fSrdNo.Width = Unit.Percentage(8);

            fSupplierName.Attributes.Add("align", "right");
            fSupplierName.Text = "";
            fSupplierName.Width = Unit.Percentage(8);

            fTinNo.Attributes.Add("align", "right");
            fTinNo.Text = "";
            fTinNo.Width = Unit.Percentage(8);

            fInvoiceNo.Attributes.Add("align", "right");
            fInvoiceNo.Text = "Grand Total";
            fInvoiceNo.Width = Unit.Percentage(8);
            fVat4.Attributes.Add("align", "right");
            fVat4.Text = String.Format("{0:f}", tax4);
            fVat4.Width = Unit.Percentage(8);

            fVat12.Attributes.Add("align", "right");
            fVat12.Text = String.Format("{0:f}", tax12);
            fVat12.Width = Unit.Percentage(8);
            fVat0.Attributes.Add("align", "right");
            fVat0.Text = String.Format("{0:f}", tax0);
            fVat0.Width = Unit.Percentage(6);

            fVat5.Attributes.Add("align", "right");
            fVat5.Text = String.Format("{0:f}", tax5);
            fVat5.Width = Unit.Percentage(8);


            fVat13.Attributes.Add("align", "right");
            fVat13.Text = String.Format("{0:f}", tax13);
            fVat13.Width = Unit.Percentage(8);

            fVat14.Attributes.Add("align", "right");
            fVat14.Text = String.Format("{0:f}", tax14);
            fVat14.Width = Unit.Percentage(8);


            fVatable4.Attributes.Add("align", "right");
            fVatable4.Text = String.Format("{0:f}", taxable4);
            fVatable4.Width = Unit.Percentage(8);



            fVatable12.Attributes.Add("align", "right");
            fVatable12.Text = String.Format("{0:f}", taxable12);
            fVatable12.Width = Unit.Percentage(8);



            fVatable0.Attributes.Add("align", "right");
            fVatable0.Text = String.Format("{0:f}", taxable0);
            fVatable0.Width = Unit.Percentage(8);

            fVatable5.Attributes.Add("align", "right");
            fVatable5.Text = String.Format("{0:f}", taxable5);
            fVatable5.Width = Unit.Percentage(8);


            fVatable13.Attributes.Add("align", "right");
            fVatable13.Text = String.Format("{0:f}", taxable13);
            fVatable13.Width = Unit.Percentage(8);

            fVatable14.Attributes.Add("align", "right");
            fVatable14.Text = String.Format("{0:f}", taxable14);
            fVatable14.Width = Unit.Percentage(8);

            fNetValue.Attributes.Add("align", "right");
            fNetValue.Text = String.Format("{0:f}", nettaxable);
            fNetValue.Width = Unit.Percentage(8);

            fGrandTotal.Attributes.Add("align", "right");
            fGrandTotal.Text = String.Format("{0:f}", nettax);
            fGrandTotal.Width = Unit.Percentage(8);


            fLoationName.Attributes.Add("align", "right");
            fLoationName.Text = "";
            fLoationName.Width = Unit.Percentage(12);



            fothers.Attributes.Add("align", "right");
            fothers.Text = String.Format("{0:f}", others);
            fothers.Width = Unit.Percentage(8);



            footerRow.Cells.Add(fSno);
            footerRow.Cells.Add(fSrdDate);
            footerRow.Cells.Add(fSrdNo);
            footerRow.Cells.Add(fSupplierName);

            footerRow.Cells.Add(fTinNo);
            footerRow.Cells.Add(fInvoiceNo);
            footerRow.Cells.Add(fVat0);

            footerRow.Cells.Add(fVat4);
            footerRow.Cells.Add(fVat5);
            footerRow.Cells.Add(fVat12);
           
           
            footerRow.Cells.Add(fVat13);
            footerRow.Cells.Add(fVat14);
            footerRow.Cells.Add(fothers);
            footerRow.Cells.Add(fVatable0);
            footerRow.Cells.Add(fVatable4);
            footerRow.Cells.Add(fVatable5);
            footerRow.Cells.Add(fVatable12);
            footerRow.Cells.Add(fVatable13);
            footerRow.Cells.Add(fVatable14);

            footerRow.Cells.Add(fNetValue);
            footerRow.Cells.Add(fGrandTotal);
            if (BranchID == 0)
            {
                footerRow.Cells.Add(fLoationName);
            }
            tblpurchaseOrder.Rows.Add(footerRow);

            if (hdnStatus.Value == "Y")
            {
                ExportToExcel(tblpurchaseOrder);
            }
        }
        hdnStatus.Value = "N";
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
          //  ddlLocation.Items.Insert(0, "--ALL--");
           // ddlLocation.Items[0].Value = "0";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
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


    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            hdnStatus.Value = "Y";
            LoadPOGrid();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void ExportToExcel(Table rstTable)
    {
        try
        {

            string prefix = string.Empty;

            prefix = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseTaxReports_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseTaxReports_aspx_01 : "Purchase Tax Reports_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);
            rstTable.BorderWidth = 1;

            string displayTool = Resources.InventoryReports_ClientDisplay.InventoryReports_PurchaseTaxReports_aspx_02;
            displayTool = displayTool == null ? "Purchase Tax Reports" : displayTool;

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>" + displayTool + "</span>");
            rstTable.RenderControl(oHtmlTextWriter);
            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Purchase Tax Reports-ExportToExcel", ioe);
        }


    }

}
