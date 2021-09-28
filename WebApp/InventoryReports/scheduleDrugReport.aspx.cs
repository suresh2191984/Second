using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using System.Drawing;


public partial class InventoryReports_scheduleDrugReport : Attune_BasePage
{
    public InventoryReports_scheduleDrugReport()
        : base("InventoryReports_scheduleDrugReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<BillingDetails> lResult = new List<BillingDetails>();
    List<Locations> lstLocations = new List<Locations>();
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnProductValues.Value = "";

        //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();
            btnSearch_Click(sender, e);
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            new Master_BL(base.ContextInfo).GetSharingOrganizations(OrgID, out lstOrgList);
            int OrgAddid = 0;
            if (lstOrgList.Count > 0)
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

                InventoryCommon_BL inventoryBL = new InventoryCommon_BL();
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

                new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocations);
                ddlLocation.DataSource = lstLocations.FindAll(p => p.LocationTypeCode == "CS-POS" || p.LocationTypeCode == "CS").ToList();
                ddlLocation.DataTextField = "LocationName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
                ListItem ddlselect = GetMetaData("All", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "ALL", Value = "0" };
                }
                ddlLocation.Items.Insert(0, ddlselect);
                ddlLocation.Items[0].Value = "0";
				ddlLocation.SelectedValue = InventoryLocationID.ToString();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReportGrid();
        
    }
    protected void LoadReportGrid()
    {
        try
        {
            long returnCode = -1;
            DateTime fromDate = txtFrom.Text.ToInternalDate();
            DateTime toDate = txtTo.Text.ToInternalDate();
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

            int InvLocationId = Convert.ToInt32( ddlLocation.SelectedValue);
            returnCode = new InventoryReports_BL(base.ContextInfo).GetScheduleDrugsReport(fromDate, toDate, OrgID, ILocationID, InvLocationId, out lResult);
            IEnumerable<BillingDetails> billing = (from val in lResult
                        group val by new { val.Name, val.FeeType,val.Address } into g
                            select new BillingDetails
                            { 
                               
                               Name=g.Key.Name,
                               FeeType=g.Key.FeeType,
                              Address=g.Key.Address,
                            }).Distinct().ToList();
            if (lResult.Count > 0)
            {
                hypLnkPrint.Visible = true;
                lnkExportXL.Visible = true;
                imgBtnXL.Visible = true;
                tblScheduleDrug.Visible = true;
                lnkPrint.Visible = true;
                lblstatus.Visible = false;
            }
            else
            {
                lblstatus.Visible = true;
                tblScheduleDrug.Visible = false;
                hypLnkPrint.Visible = false;
                lnkExportXL.Visible = false;
                imgBtnXL.Visible = false;
                lnkPrint.Visible = false;
            }
                            
            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            TableCell cellH6 = new TableCell();
            TableCell cellH7 = new TableCell();
            TableCell cellH8 = new TableCell();
            rowH.BorderWidth = 1;
            rowH.BorderColor = Color.Black;
            //Added by Perumal - Start
            TableCell cellH9 = new TableCell();
            TableCell cellH10 = new TableCell();
            TableCell cellH11 = new TableCell();
            //Added by Perumal - End
            //Added by Saravanan -Start
            //Added by Saravanan - End

            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "Bill No";
            cellH1.Width = Unit.Percentage(8);

            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "Patient";
            cellH2.Width = Unit.Percentage(12);

            cellH3.Attributes.Add("align", "left");
            cellH3.Text = "Place";
            if (OrgID ==84)
            {
                cellH3.Visible = false;
            }
            cellH3.Width = Unit.Percentage(12);

            cellH4.Attributes.Add("align", "left");
            cellH4.Text = "Dr.Name";
            cellH4.Width = Unit.Percentage(10);

            cellH5.Attributes.Add("align", "left");
            cellH5.Text = "Drug Name";
            cellH5.Width = Unit.Percentage(15);

            cellH6.Attributes.Add("align", "left");
            cellH6.Text = "Batch No";
            cellH6.Width = Unit.Percentage(8);

            cellH7.Attributes.Add("align", "left");
            cellH7.Text = "Date Of Expiry";
            cellH7.Width = Unit.Percentage(8);

            cellH8.Attributes.Add("align", "left");
            cellH8.Text = "Quantity";
            cellH8.Width = Unit.Percentage(6);
          
            //Added by Perumal - Start
            cellH9.Attributes.Add("align", "left");
            cellH9.Text = "Bill Date";
            cellH9.Width = Unit.Percentage(10);

            cellH10.Attributes.Add("align", "left");
            cellH10.Text = "Manufacturer";
            cellH10.Width = Unit.Percentage(15);
            cellH10.Attributes.Add("class", "hide");
            cellH11.Attributes.Add("align", "left");
            cellH11.Text = "Signature";
            cellH11.Width = Unit.Percentage(10);
            cellH11.Attributes.Add("class", "hide");
            //Added by Perumal - End
           
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Cells.Add(cellH6);
            rowH.Cells.Add(cellH7);
            rowH.Cells.Add(cellH8);

            //Added by Perumal - Start
            rowH.Cells.Add(cellH9);
            rowH.Cells.Add(cellH10);
            rowH.Cells.Add(cellH11);
            //Added by Perumal - End
            //Added by Saravanan - Start
            //Added By Saravanana -Start
            rowH.Font.Bold = true;
            rowH.CssClass = "gridHeader";
            tblScheduleDrug.Rows.Add(rowH);

            foreach (var item in lResult)
            {
                TableRow rowCh = new TableRow();
                TableCell cellCh1 = new TableCell();
                TableCell cellCh2 = new TableCell();
                TableCell cellCh3 = new TableCell();
                TableCell cellCh4 = new TableCell();

                TableCell cellCh5 = new TableCell();
                TableCell cellCh6 = new TableCell();
                TableCell cellCh7 = new TableCell();
                TableCell cellCh8 = new TableCell();

                //Added by Perumal - Start
                TableCell cellCh9 = new TableCell();
                TableCell cellCh10 = new TableCell();
                TableCell cellCh11 = new TableCell();
                rowCh.BorderWidth = 1;
                rowCh.BorderColor = Color.Black;
                cellCh1.Attributes.Add("align", "left");
                cellCh1.Text = item.BillNumber.ToString();
                rowCh.Cells.Add(cellCh1);

                cellCh2.Attributes.Add("align", "left");
                cellCh2.Text = item.Name.ToString();
                rowCh.Cells.Add(cellCh2);

                cellCh3.Attributes.Add("align", "left");
                string[] str = item.Address.Split(' ');
                if (OrgID ==84)
                {
                    cellCh3.Visible = false;
                }
                cellCh3.Text = item.Address.ToString();
                rowCh.Cells.Add(cellCh3);

                cellCh4.Attributes.Add("align", "left");
                cellCh4.Text = item.FeeType.ToString();
                rowCh.Cells.Add(cellCh4);
                tblScheduleDrug.Rows.Add(rowCh);
               /* foreach (BillingDetails bill in lResult.FindAll(p => p.BillNumber == item.BillNumber))
                {
                    TableCell cellChi1 = new TableCell();
                    TableCell cellChi2 = new TableCell();
                    TableCell cellChi3 = new TableCell();
                    TableCell cellChi4 = new TableCell();

                    TableRow rowChChild = new TableRow();
                    rowChChild.BorderWidth = 1;
                    rowChChild.BorderColor = Color.Black;
                    TableCell cellCh5 = new TableCell();
                    TableCell cellCh6 = new TableCell();
                    TableCell cellCh7 = new TableCell();
                    TableCell cellCh8 = new TableCell();

                    //Added by Perumal - Start
                    TableCell cellCh9 = new TableCell();
                    TableCell cellCh10 = new TableCell();
                    TableCell cellCh11 = new TableCell();
                    //Added by Perumal - End

                    //Added by Saravanan - Start
                    //Added by Saravanan - End

                    cellChi1.Attributes.Add("align", "left");
                    rowChChild.Cells.Add(cellChi1);

                    cellChi2.Attributes.Add("align", "left");
                    rowChChild.Cells.Add(cellChi2);

                    cellChi1.Attributes.Add("align", "left");
                    rowChChild.Cells.Add(cellChi1);
                    if (OrgID == 84)
                    {

                    }
                    else
                    {
                        cellChi3.Attributes.Add("align", "left");
                        rowChChild.Cells.Add(cellChi3);
                    }
                        
                  

                    cellChi4.Attributes.Add("align", "left");
                    rowChChild.Cells.Add(cellChi4);

                    cellCh5.Attributes.Add("align", "left");
                    cellCh5.Text = bill.FeeDescription.ToString();
                    rowCh.Cells.Add(cellCh5);

                    cellCh6.Attributes.Add("align", "left");
                    cellCh6.Text = bill.BatchNo.ToString();
                    rowCh.Cells.Add(cellCh6);

                    cellCh7.Attributes.Add("align", "left");
                    cellCh7.Text = bill.ExpiryDate.ToString("MMM/yyyy") == "Jan/1753" ? "**" : bill.ExpiryDate.ToString("MMM/yyyy");
                    rowCh.Cells.Add(cellCh7);

                    cellCh8.Attributes.Add("align", "left");
                    cellCh8.Text = bill.Quantity.ToString();
                    rowCh.Cells.Add(cellCh8);
                    tblScheduleDrug.Rows.Add(rowCh);


       
                        //Added by Perumal - Start
                        cellCh9.Attributes.Add("align", "left");
                        cellCh9.Text = bill.BilledDate.ToString("dd/MM/yyyy"); ; // for Bill Date
                        rowCh.Cells.Add(cellCh9);
                        tblScheduleDrug.Rows.Add(rowCh);

                        cellCh10.Attributes.Add("align", "left");
                        cellCh10.Text = bill.ProcedureName.ToString(); // for Manufacturer Name
                        rowCh.Cells.Add(cellCh10);
                        tblScheduleDrug.Rows.Add(rowCh);
                        cellCh10.Attributes.Add("class", "hide");
                        cellCh11.Attributes.Add("align", "left");
                        cellCh11.Text = bill.FromTable.ToString();   // for Signature
                        rowCh.Cells.Add(cellCh11);
                        cellCh11.Attributes.Add("class", "hide");

                     
                
                        tblScheduleDrug.Rows.Add(rowCh);
                    //Added by Perumal - End

                    //tblScheduleDrug.Rows.Add(rowChChild);
                  
                }*/
                cellCh5.Attributes.Add("align", "left");
                cellCh5.Text = item.FeeDescription.ToString();
                rowCh.Cells.Add(cellCh5);

                cellCh6.Attributes.Add("align", "left");
                cellCh6.Text = item.BatchNo.ToString();
                rowCh.Cells.Add(cellCh6);

                cellCh7.Attributes.Add("align", "left");
                cellCh7.Text = item.ExpiryDate.ToString("MMM/yyyy") == "Jan/1753" ? "**" : item.ExpiryDate.ToString("MMM/yyyy");
                rowCh.Cells.Add(cellCh7);

                cellCh8.Attributes.Add("align", "left");
                cellCh8.Text = item.Quantity.ToString();
                rowCh.Cells.Add(cellCh8);
                tblScheduleDrug.Rows.Add(rowCh);



                //Added by Perumal - Start
                cellCh9.Attributes.Add("align", "left");
                cellCh9.Text = item.BilledDate.ToString("dd/MM/yyyy"); ; // for Bill Date
                rowCh.Cells.Add(cellCh9);
                tblScheduleDrug.Rows.Add(rowCh);

                cellCh10.Attributes.Add("align", "left");
                cellCh10.Text = item.ProcedureName.ToString(); // for Manufacturer Name
                rowCh.Cells.Add(cellCh10);
                tblScheduleDrug.Rows.Add(rowCh);
                cellCh10.Attributes.Add("class", "hide");
                cellCh11.Attributes.Add("align", "left");
                cellCh11.Text = item.FromTable.ToString();   // for Signature
                rowCh.Cells.Add(cellCh11);
                cellCh11.Attributes.Add("class", "hide");



                tblScheduleDrug.Rows.Add(rowCh);
                
            }
            if (hdnStatus.Value == "Y")
            {
                ExportToExcel(tblScheduleDrug);
            }
            hdnStatus.Value = "N";
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ISchedule Drugs", ex);
        }

    }
    
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            BillingDetails iim = (BillingDetails)e.Row.DataItem;
            GridView grdReportChild = (GridView)e.Row.FindControl("grdReportChild");
            grdReportChild.DataSource = lResult.FindAll(p => p.BillNumber == iim.BillNumber);
            grdReportChild.DataBind();
        }
    }

    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            hdnStatus.Value = "Y";
            LoadReportGrid();
           
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
            prefix = "ScheduleDrug_Reports_";
            string rptDate = prefix + DateTimeNow.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            rstTable.RenderControl(oHtmlTextWriter);
            HttpContext.Current.Response.Write(oStringWriter.ToString());
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in scheduleDrugReport.aspx-ExportToExcel", ioe);
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