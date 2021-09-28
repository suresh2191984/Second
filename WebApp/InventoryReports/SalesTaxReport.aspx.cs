using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_SalesTaxReport : Attune_BasePage
{
    InventoryCommon_BL inventoryBL;
    List<SalesTax> lstFinalBill = new List<SalesTax>();

    public InventoryReports_SalesTaxReport()
        : base("InventoryReports_SalesTaxReport_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        divBill.Style.Add("display", "none");

        MainGrandTotal.Visible = false;
        gvSales.Visible = false;
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            string strConfigKey = "IsExtendedGrid";
            hdnextendedGrid.Value = "N";
            string configValue = GetConfigValue(strConfigKey, OrgID);
            LoadOrgan();
            LoadLocationName(OrgID, ILocationID);
            txtFrom.Text = DateTimeNow.ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeNow.ToString("dd/MM/yyyy");

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
    //newly added
    private void LoadLocationName(int oid, int oaid)
    {
        try
        {
            List<Locations> lstLocations = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            new Master_BL(base.ContextInfo).GetInvLocationDetail(oid, OrgAddid, out lstLocations);
            ddlLocation.DataSource = lstLocations;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    protected void clearFooterControls()
    {
        lblTotalGross.Text = "0.00";
        lblTotalNet.Text = "0.00";
        lblTotalVat.Text = "0.00";
        lblVat4.Text = "0.00";
        lblVat5.Text = "0.00";
        lblVat12.Text = "0.00";
        lblVat13.Text = "0.00";
        lblVat14.Text = "0.00";
        lblVat0.Text = "0.00";
        lblVatothers.Text = "0.00";
        lblTotalNetsales.Text = "0.00";
        lblSalAmt.Text = "0.00";
        lblRetAmt.Text = "0.00";

        rlblTotalGross.Text = "0.00";
        rlblTotalNet.Text = "0.00";
        rlblTotalVat.Text = "0.00";
        rlblVat4.Text = "0.00";
        rlblVat5.Text = "0.00";
        rlblVat12.Text = "0.00";
        rlblVat13.Text = "0.00";
        rlblVat14.Text = "0.00";
        rlblVat0.Text = "0.00";
        rlblVatothers.Text = "0.00";

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        clearFooterControls();


        string BaseCurrencyCode = string.Empty;
        string pPaidCurrencyCode = string.Empty;

        DateTime fDate = Convert.ToDateTime(txtFrom.Text);
        DateTime tDate = Convert.ToDateTime(txtTo.Text);

        List<SalesTax> lstDWCR = new List<SalesTax>();
        List<SalesTax> lstSalesDetail = new List<SalesTax>();
        List<SalesTax> lstDWCRGrandTotal = new List<SalesTax>();

        string BillNumber = string.Empty;
        if (txtBillNumber.Text.Trim() != "")
        {
            BillNumber = Convert.ToString(txtBillNumber.Text);
        }
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);


        new InventoryReports_BL(this.ContextInfo).GetSalesTaxReport(Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), 0, OrgID, ILocationID,
            out lstFinalBill, out lstSalesDetail);

        gnRefundDetails.Visible = false;
        grdSummarydata.Visible = false;

        if (lstFinalBill.Count > 0)
        {
            contentArea.Style.Add("display", "block");
            if (rdotypes.SelectedItem.Text.ToLower().Contains("details"))
            {
                divBill.Style.Add("display", "block");

                gvSales.Visible = true;
                gvSales.DataSource = lstFinalBill.FindAll(p => p.Comments != "Summary").ToList();
                gvSales.DataBind();
                hdnRowCount.Value = gvSales.PageSize.ToString();
                if (lstSalesDetail.Count > 0 && lstSalesDetail[0].GrossBillValue>0)
                {
                    gnRefundDetails.Visible = true;
                    gnRefundDetails.DataSource = lstSalesDetail.FindAll(p => p.Comments != "Summary").ToList();
                    gnRefundDetails.DataBind();

                }
                var TotalSales = (from list in lstFinalBill
                                  where list.Type == "Grand Total"
                                  select list.GrossBillValue).Sum();



                var salesreturn = (from list in lstSalesDetail
                                   where list.Type == "Grand Total"
                                   select list.GrossBillValue).Sum();


                lblSalAmt.Text = (Convert.ToDecimal(TotalSales)).ToString("0.00");
                lblRetAmt.Text = (Convert.ToDecimal(salesreturn)).ToString("0.00");
                lblTotalNetsales.Text = (Convert.ToDecimal(TotalSales) - Convert.ToDecimal(salesreturn)).ToString("0.00");
            }
            if (rdotypes.SelectedItem.Text.ToLower().Contains("summary"))
            {
                MainGrandTotal.Visible = true;
                lstDWCRGrandTotal = lstFinalBill.FindAll(p => p.Comments != "Details");
                MainGrandTotal.DataSource = lstDWCRGrandTotal;
                MainGrandTotal.DataBind();
                if (lstSalesDetail.Count > 0 && lstSalesDetail[0].GrossBillValue>0)
                {
                    grdSummarydata.Visible = true;
                    grdSummarydata.DataSource = lstSalesDetail.FindAll(p => p.Comments != "Details").ToList();
                    grdSummarydata.DataBind();


                }
                var TotalSales = (from list in lstFinalBill
                                  where list.Type == "Grand Total"
                                  select list.GrossBillValue).Sum();



                var salesreturn = (from list in lstSalesDetail
                                   where list.Type == "Grand Total"
                                   select list.GrossBillValue).Sum();

                lblSalAmt.Text = (Convert.ToDecimal(TotalSales)).ToString("0.00");
                lblRetAmt.Text = (Convert.ToDecimal(salesreturn)).ToString("0.00");
                lblTotalNetsales.Text = (Convert.ToDecimal(TotalSales) - Convert.ToDecimal(salesreturn)).ToString("0.00");


            }

        }
        else
        {
            contentArea.Style.Add("display", "none");
        }
    }

    protected void gvAllSales_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            SalesTax IOM = (SalesTax)e.Row.DataItem;
            if (IOM.Comments == "Summary" && IOM.Type == "Grand Total")
            {
                BindTotal(e.Row);


            }
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
    }
    protected void grdSummarydata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            SalesTax IOM = (SalesTax)e.Row.DataItem;
            if (IOM.Type == "Grand Total")
            {
                BindTotal(e.Row);


            }

            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
        }
    }

    protected void gvSales_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvSales.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    protected void gvSales_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SalesTax IOM = (SalesTax)e.Row.DataItem;
                ((Label)e.Row.FindControl("lblBillID")).Text = IOM.BillNumber.ToString();

                lblTotalGross.Text = String.Format("{0:0.00}", (IOM.GrossBillValue + decimal.Parse(lblTotalGross.Text)));
                lblTotalNet.Text = String.Format("{0:0.00}", (IOM.NetValue + decimal.Parse(lblTotalNet.Text)));
                lblTotalVat.Text = String.Format("{0:0.00}", (IOM.TaxAmount + decimal.Parse(lblTotalVat.Text)));
                lblVat4.Text = String.Format("{0:0.00}", (IOM.AdvanceRecieved + decimal.Parse(lblVat4.Text)));
                lblVat5.Text = String.Format("{0:0.00}", (IOM.TaxPercent + decimal.Parse(lblVat5.Text)));
                lblVat12.Text = String.Format("{0:0.00}", (IOM.AmountReceived + decimal.Parse(lblVat12.Text)));
                lblVat13.Text = String.Format("{0:0.00}", (IOM.ServiceCharge + decimal.Parse(lblVat13.Text)));
                lblVat14.Text = String.Format("{0:0.00}", (IOM.TaxAmount14 + decimal.Parse(lblVat14.Text)));
                lblVat0.Text = String.Format("{0:0.00}", (IOM.AmountRefund + decimal.Parse(lblVat0.Text)));
                lblVatothers.Text = String.Format("{0:0.00}", (IOM.CurrentDue + decimal.Parse(lblVatothers.Text)));
                lblDisc.Text = String.Format("{0:0.00}", (IOM.Discount + decimal.Parse(lblDisc.Text)));
                lbRoundoff.Text = String.Format("{0:0.00}", (IOM.DueAmount + decimal.Parse(lbRoundoff.Text)));
                if (IOM.Comments == "Comm" && IOM.Type == "Grand Total")
                {
                    BindTotal(e.Row);


                }
                e.Row.Attributes.Add("onmouseover", "this.className='hover'");
                e.Row.Attributes.Add("onmouseout", "this.className='hout'");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading SalesReport.", ex);
        }
    }
    void BindTotal(GridViewRow e)
    {
        e.BackColor = System.Drawing.Color.Gray;
        e.Font.Bold = true;
        e.Font.Size = 11;
    }

    protected void btn_export_Click(object sender, EventArgs e)
    {
        try
        {
            gvSales.AllowPaging = false;
            clearFooterControls();
            btnSearch_Click(sender, e);
            FilterControls(gvSales);
            ExportToExcel();
            gvSales.AllowPaging = true;
            gvSales.DataSource = lstFinalBill;
            gvSales.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }

    }
    public void ExportToExcel()
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "salesreport"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";

        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        MainGrandTotal.RenderControl(htmlWrite);
        grdSummarydata.RenderControl(htmlWrite);
        gvSales.RenderControl(htmlWrite);
        gnRefundDetails.RenderControl(htmlWrite);
        Tr1.RenderControl(htmlWrite);
        Tr2.RenderControl(htmlWrite);
        tbNetsales.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }

    public string getReportHeader(int tdCount)
    {
        List<Organization> lstOrganization = null;
        string strHeader = string.Empty;
        string rptName = string.Empty;
        try
        {
            lstOrganization = new List<Organization>();
            long lresult =new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
            rptName = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_01 : "Sales Report";
            var rptnnmae = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_02 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_02 : "Report Name";
            var rptdate = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_03 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesTaxReport_aspx_03 : "Report Date";
            //strHeader = "<center><h3>" + OrgName.ToString() + "</h3></center>";
            strHeader += "<center><table>";
            strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>" + rptnnmae + " : " + rptName + "</td></tr>";
            strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>" + rptdate + " : " + DateTimeNow.ToShortDateString() + "</td></tr>";
            strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
            strHeader += "<tr><td><br /></td></tr>";
            strHeader += "</table></center>";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in getReportHeader : ", ex);
        }
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
    protected void rgvSales_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SalesTax IOM = (SalesTax)e.Row.DataItem;
                ((Label)e.Row.FindControl("lblBillID")).Text = IOM.BillNumber.ToString();

                rlblTotalGross.Text = String.Format("{0:0.00}", (IOM.GrossBillValue + decimal.Parse(rlblTotalGross.Text)));
                rlblTotalNet.Text = String.Format("{0:0.00}", (IOM.NetValue + decimal.Parse(rlblTotalNet.Text)));
                rlblTotalVat.Text = String.Format("{0:0.00}", (IOM.TaxAmount + decimal.Parse(rlblTotalVat.Text)));
                rlblVat4.Text = String.Format("{0:0.00}", (IOM.AdvanceRecieved + decimal.Parse(rlblVat4.Text)));
                rlblVat5.Text = String.Format("{0:0.00}", (IOM.TaxPercent + decimal.Parse(rlblVat5.Text)));
                rlblVat12.Text = String.Format("{0:0.00}", (IOM.AmountReceived + decimal.Parse(rlblVat12.Text)));
                rlblVat13.Text = String.Format("{0:0.00}", (IOM.ServiceCharge + decimal.Parse(rlblVat13.Text)));
                rlblVat14.Text = String.Format("{0:0.00}", (IOM.TaxAmount14 + decimal.Parse(rlblVat14.Text)));
                rlblVat0.Text = String.Format("{0:0.00}", (IOM.AmountRefund + decimal.Parse(rlblVat0.Text)));
                rlblVatothers.Text = String.Format("{0:0.00}", (IOM.CurrentDue + decimal.Parse(rlblVatothers.Text)));
                rlblDisc.Text = String.Format("{0:0.00}", (IOM.Discount + decimal.Parse(rlblDisc.Text)));
                rlblRounoff.Text = String.Format("{0:0.00}", (IOM.DueAmount + decimal.Parse(rlblRounoff.Text)));
                if (IOM.Comments == "Comm" && IOM.Type == "Grand Total")
                {
                    BindTotal(e.Row);
                }
                e.Row.Attributes.Add("onmouseover", "this.className='hover'");
                e.Row.Attributes.Add("onmouseout", "this.className='hout'");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading SalesReturn", ex);
        }
    }
}