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


public partial class InventoryReports_SalesReport : Attune_BasePage
{
    InventoryCommon_BL inventoryBL;
    List<SalesTax> lstFinalBill = null;

    public InventoryReports_SalesReport()
        : base("InventoryReports_SalesReport_aspx")
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
        //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if (!IsPostBack)
        {
            string strConfigKey = "IsExtendedGrid";
            hdnextendedGrid.Value = "N";
            string configValue = GetConfigValue(strConfigKey, OrgID);
            LoadOrgan();
            LoadLocationName(OrgID, ILocationID);
            txtFrom.Text = System.DateTime.Today.ToExternalDate();
            txtTo.Text = System.DateTime.Today.ToExternalDate();
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
            new Master_BL(ContextInfo).GetInvLocationDetail(oid, OrgAddid, out lstLocations);
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
        lblVat55.Text = "0.00";
        lblVat12.Text = "0.00";
        lblVat13.Text = "0.00";
        lblVat14.Text = "0.00";
        lblVat145.Text = "0.00";
        lblVat0.Text = "0.00";
        lblVatothers.Text = "0.00";
    }
    protected void clearUserFooterControls()
    {
        lblAmountReceived.Text = "0.00";
        lblUserTotalNet.Text = "0.00";
        lblCurrentDue.Text = "0.00";
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        clearFooterControls();
        clearUserFooterControls();

        long returnCode = 0;
        decimal pTotalBillAmt = -1;
        decimal pTotalPreDueReceived = -1;
        decimal pTotalDiscount = -1;
        decimal pTotalNetValue = -1;
        decimal pTotalReceivedAmt = -1;
        decimal pTotalDue = -1;
        decimal pTax = -1;
        decimal pServiceCharge = -1;
        string BaseCurrencyCode = string.Empty;
        string pPaidCurrencyCode = string.Empty;
        int currencyID = 63;
        DateTime fDate = txtFrom.Text.ToInternalDate();
        DateTime tDate = txtTo.Text.ToInternalDate();
        int retreiveDataBaseOnVtype = -1;
        List<SalesTax> lstDWCR = null;
        List<SalesTax> lstSalesDetail = null;
        List<SalesTax> lstDWCRGrandTotal = new List<SalesTax>();

        string BillNumber = string.Empty;
        if (txtBillNumber.Text.Trim() != "")
        {
            BillNumber = Convert.ToString(txtBillNumber.Text);
        }
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        if (hdnextendedGrid.Value == "Y")
        {
            divsummary.Visible = true;

            returnCode = new InventoryReports_BL(base.ContextInfo).GetCollectionReportOPIPSummary(fDate, tDate, OrgID, 0, retreiveDataBaseOnVtype, currencyID, out lstDWCR, out pTotalBillAmt, out pTotalPreDueReceived, out pTotalDiscount, out pTotalNetValue, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge);
            if (lstDWCR != null && lstDWCR.Count > 0)
            {
                gvIPCreditMainGrandTotal.Visible = true;
                gvIPCreditMainGrandTotal.DataSource = lstDWCR;
                gvIPCreditMainGrandTotal.DataBind();
            }
        }
        else
        {
            divsummary.Visible = false;
        }

        int visitType = Convert.ToInt32(rbtSales.SelectedValue);
        List<SalesTax> lstSalesGSTDetail = null;
        new InventoryReports_BL(this.ContextInfo).GetSalesReport(fDate, tDate, 0, OrgID, ILocationID, BillNumber, out lstFinalBill, out lstSalesDetail,out lstSalesGSTDetail, visitType);
        if (lstFinalBill!=null && lstFinalBill.Count > 0)
        {
            contentArea.Style.Add("display", "block");
            if (rdotypes.SelectedItem.Value.ToLower().Contains("details"))
            {
                divBill.Style.Add("display", "block");

                gvSales.Visible = true;
                gvSales.DataSource = lstFinalBill.FindAll(p => p.Comments != "Summary").ToList();
                gvSales.DataBind();
                hdnRowCount.Value = gvSales.PageSize.ToString();
                if (lstSalesDetail!=null && lstSalesDetail.Count > 0)
                {
                    grdSummarydata.Visible = true;
                    grdSummarydata.DataSource = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").ToList();
                    grdSummarydata.DataBind();
                    var pharm = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_01 : "Pharmacy Total Refund Amount";
                    var Refund = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_02 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_02 : "Pharmacy Product Item Refund Value";
                    lblPharmacytotRefund.Text = "" + pharm + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + lstSalesDetail[0].NetAmount.ToString("0.00");
                    lblPharmacyDateRangeRefund.Text = "" + Refund + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + lstSalesDetail[0].NetValue.ToString("0.00");

                    divPharmacytotRefund.Visible = true;
                    if (grdSummarydata.Rows.Count > 0)
                    {
                        grdSummarydata.FooterRow.Cells[0].Text = "Grand Total";
                        grdSummarydata.FooterRow.Cells[1].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.NetAmount).ToString("#.##");
                        grdSummarydata.FooterRow.Cells[2].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.NetValue).ToString("#.##");
                        grdSummarydata.FooterRow.Cells[3].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.GrossBillValue).ToString("#.##");
                    }
                }
                else
                {
                    grdSummarydata.Visible = false;
                }
            }
            if (rdotypes.SelectedItem.Value.ToLower().Contains("summary"))
            {
                MainGrandTotal.Visible = true;
                lstDWCRGrandTotal = lstFinalBill.FindAll(p => p.Comments == "Summary");
                MainGrandTotal.DataSource = lstDWCRGrandTotal;
                MainGrandTotal.DataBind();
                if (lstSalesDetail != null && lstSalesDetail.Count > 0)
                {
                    grdSummarydata.Visible = true;
                    grdSummarydata.DataSource = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").ToList();
                    grdSummarydata.DataBind();
                    var pharm = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_01 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_01 : "Pharmacy Total Refund Amount";
                    var Refund = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_02 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_02 : "Pharmacy Product Item Refund Value";
                    lblPharmacytotRefund.Text = "" + pharm + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + lstSalesDetail[0].NetAmount.ToString("0.00");
                    lblPharmacyDateRangeRefund.Text = "" + Refund + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + lstSalesDetail[0].NetValue.ToString("0.00");

                    divPharmacytotRefund.Visible = true;
                    if (grdSummarydata.Rows.Count > 0)
                    {
                        grdSummarydata.FooterRow.Cells[0].Text = "Grand Total";
                        grdSummarydata.FooterRow.Cells[1].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.NetAmount).ToString("#.##");
                        grdSummarydata.FooterRow.Cells[2].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.NetValue).ToString("#.##");
                        grdSummarydata.FooterRow.Cells[3].Text = lstSalesDetail.FindAll(p => p.Comments == "GroupBy").Sum(x => x.GrossBillValue).ToString("#.##");
                    }
                }
                else
                {
                    grdSummarydata.Visible = false;
                }
            }
        }
        else
        {
            contentArea.Style.Add("display", "none");
        }
        #region NationWide_Show_All_VAT_Tax in report
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedTo_Show_All_VAT_Percentage", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            if (lstInventoryConfig[0].ConfigValue == "Y")
            {
                MainGrandTotal.Columns[2].Visible = false;
                MainGrandTotal.Columns[3].Visible = false;
                MainGrandTotal.Columns[5].Visible = false;
                MainGrandTotal.Columns[6].Visible = false;

                gvSales.Columns[2].Visible = false;
                gvSales.Columns[3].Visible = false;
                gvSales.Columns[5].Visible = false;
                gvSales.Columns[6].Visible = false;
                gvSales.Columns[8].Visible = false;
                gvSales.Columns[9].Visible = false;


            }
        }
        #endregion
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
                lblVat55.Text = String.Format("{0:0.00}", (IOM.GrossAmount + decimal.Parse(lblVat55.Text)));
                lblVat12.Text = String.Format("{0:0.00}", (IOM.AmountReceived + decimal.Parse(lblVat12.Text)));
                lblVat13.Text = String.Format("{0:0.00}", (IOM.ServiceCharge + decimal.Parse(lblVat13.Text)));
                lblVat14.Text = String.Format("{0:0.00}", (IOM.TaxAmount14 + decimal.Parse(lblVat14.Text)));
                lblVat145.Text = String.Format("{0:0.00}", (IOM.TaxAmount145 + decimal.Parse(lblVat145.Text)));
                lblVat0.Text = String.Format("{0:0.00}", (IOM.AmountRefund + decimal.Parse(lblVat0.Text)));
                lblVatothers.Text = String.Format("{0:0.00}", (IOM.CurrentDue + decimal.Parse(lblVatothers.Text)));
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
            if (lstFinalBill != null && lstFinalBill.Count > 0)
            {
                gvSales.DataSource = lstFinalBill;
                gvSales.DataBind();
            }
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
        if (hdnextendedGrid.Value == "Y")
        {
            gvSales.RenderControl(htmlWrite);
            gvIPCreditMainGrandTotal.RenderControl(htmlWrite);
            MainGrandTotal.RenderControl(htmlWrite);
        }
        else
        {
            gvSales.RenderControl(htmlWrite);
            MainGrandTotal.RenderControl(htmlWrite);
        }
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
            long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
            rptName = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_03 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_03 : "Sales Report";
            var name = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_04 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_04 : "Report Name";
            var reportdate = Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_05 != null ? Resources.InventoryReports_ClientDisplay.InventoryReports_SalesReport_aspx_05 : "Report Date";
            strHeader += "<center><table>";
            strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>" + name + " : " + rptName + "</td></tr>";
            strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>" + reportdate + " : " + DateTimeNow.ToShortDateString() + "</td></tr>";
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
}
