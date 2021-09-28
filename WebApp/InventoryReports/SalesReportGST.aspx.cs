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


public partial class InventoryReports_SalesReportGST : Attune_BasePage
{
    InventoryCommon_BL inventoryBL;
    List<SalesTax> lstFinalBill = null;
    List<SalesTax> lstSalesGSTDetail = null;
    SalesTax objDWCR = new SalesTax();
    private decimal TotalNetValue = (decimal)0.00;
    private decimal TotalTaxAmount = (decimal)0.00;
    private decimal TotalTaxableAmount = (decimal)0.00;
    private decimal TotalSGST = (decimal)0.00;
    private decimal TotalCGST = (decimal)0.00;
    private decimal TotalTaxableValue = (decimal)0.00;
    public InventoryReports_SalesReportGST()
        : base("InventoryReports_SalesReportGST_aspx")
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
		lblTotalTaxableValue.Text="0.00";
        lblTotalVat.Text = "0.00";
        lblVat4.Text = "0.00";
        lblVat5.Text = "0.00";
        lblVat55.Text = "0.00";
        lblVat12.Text = "0.00";
        lblVat13.Text = "0.00";
        lblVat14.Text = "0.00";
        lblVat145.Text = "0.00";
        //lblVat0.Text = "0.00";
        lblSVat0.Text = "0.00";
        lblVatothers.Text = "0.00";
        lblVat18.Text = "0.00";
        lblVat28.Text = "0.00";

        lblSVat0.Text = "0.00";
        lblCVat0.Text = "0.00";

        lblSVat5.Text = "0.00";
        lblCVat5.Text = "0.00";

        lblSVat12.Text = "0.00";
        lblCVat12.Text = "0.00";

        lblSVat18.Text = "0.00";
        lblCVat18.Text = "0.00";

        lblSVat28.Text = "0.00";
        lblCVat28.Text = "0.00";

        lblVatothers.Text = "0.00";
        lblDiscount.Text = "0.00";
        lblTaxAmount.Text = "0.00";
        lblRoundoff.Text = "0.00";
        lblSubTotal.Text = "0.00";
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
        base.ContextInfo.AdditionalInfo = "GST";
        if (txtBillNumber.Text.Trim() != "")
        {
            BillNumber = Convert.ToString(txtBillNumber.Text);
        }
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        if (hdnextendedGrid.Value == "Y")
        {
            divsummary.Visible = true;
            base.ContextInfo.AdditionalInfo = "GST";
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
        new InventoryReports_BL(this.ContextInfo).GetSalesReport(fDate, tDate, 0, OrgID, ILocationID, BillNumber, out lstFinalBill, out lstSalesDetail, out lstSalesGSTDetail, visitType);
        #region lstFinalBill
        if (lstFinalBill != null && lstFinalBill.Count > 0)
        {
            contentArea.Style.Add("display", "block");
            #region details
            if (rdotypes.SelectedItem.Value.ToLower().Contains("details"))
            {
                divBill.Style.Add("display", "block");

                gvSales.Visible = true;
                gvSales.DataSource = lstFinalBill.FindAll(p => p.Comments != "summary").ToList();
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
            #endregion
            #region summary
            if (rdotypes.SelectedItem.Value.ToLower().Contains("summary"))
            {
         //       MainGrandTotal.Visible = true;
          //      lstDWCRGrandTotal = lstFinalBill.FindAll(p => p.Comments == "Summary");
         //       MainGrandTotal.DataSource = lstDWCRGrandTotal;
         //       MainGrandTotal.DataBind();
         //       if (lstSalesDetail != null && lstSalesDetail.Count > 0)
                if (lstSalesGSTDetail != null)
                {
                    Grdsummarytax.DataSource = lstSalesGSTDetail;
                    Grdsummarytax.Visible = true;

                    if (lstSalesGSTDetail.Count < Grdsummarytax.PageSize)
                    {
                        hdnRowCount.Value = lstSalesGSTDetail.Count.ToString();
                    }
                    else
                    {
                        hdnRowCount.Value = Grdsummarytax.PageSize.ToString();
                    }
                    Grdsummarytax.Visible = true;

                    Grdsummarytax.DataBind();
                    //if (lstSalesGSTDetail.Count > 0)
                    //{
                    //    tblTool.Style.Add("display", "block");
                    //}
                    //else
                    //{
                    //    tblTool.Style.Add("display", "none");
                    //    gvPurchase.Visible = false;
                    //}
                    if (lstSalesGSTDetail.Count == 0)
                    {
                        Grdsummarytax.Visible = false;
                        grdSummarydata.Visible = false;
                        MainGrandTotal.Visible = false;
                    }
                    foreach (SalesTax fb in lstSalesGSTDetail)
                    {
                        objDWCR.TaxableAmount = fb.TaxableAmount;
                        objDWCR.SGST = fb.SGST;
                        objDWCR.CGST = fb.CGST;
                        objDWCR.Tax = fb.Tax;
                        objDWCR.TaxAmount = fb.TaxAmount;
                        objDWCR.NetValue = fb.NetValue;//kumaresan
                    }
                    lstDWCRGrandTotal.Add(objDWCR);

                    foreach (var row in lstSalesGSTDetail)
                    {
                     

                        TotalTaxableAmount += row.GrossValue;

                        TotalCGST += row.CGST;
                        TotalSGST += row.SGST;
                        TotalTaxAmount += row.TaxAmount;
                        TotalNetValue += row.NetValue;


                    }
                    if (Grdsummarytax.Rows.Count > 0)
                    {
                        Grdsummarytax.FooterRow.Cells[0].Text = "Total";

                        Grdsummarytax.FooterRow.Cells[1].Text = TotalTaxableAmount.ToString("N2");
                        Grdsummarytax.FooterRow.Cells[2].Text = TotalCGST.ToString("N2");
                        Grdsummarytax.FooterRow.Cells[3].Text = TotalSGST.ToString("N2");

                        Grdsummarytax.FooterRow.Cells[4].Text = TotalTaxAmount.ToString("N2");
                        Grdsummarytax.FooterRow.Cells[5].Text = TotalNetValue.ToString("N2");

                    }
                }
            }
            else
            {
                Grdsummarytax.Visible = false;
                grdSummarydata.Visible = false;
            }
            #endregion

            if (rdotypes.SelectedItem.Value.ToLower() == ("details") || rdotypes.SelectedItem.Value.ToLower() == ("summary/ details"))
            {
                grdSummarydata.Visible = true;
            }
            else
            {
                grdSummarydata.Visible = false;
            }
        }
        else
        {
            contentArea.Style.Add("display", "none");
        }
        #endregion
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
                if (IOM.Comments.ToLower() == "details")
                {
                    lblTotalGross.Text = String.Format("{0:0.0000}", (IOM.DepositUsed + decimal.Parse(lblTotalGross.Text)));
                    lblTotalNet.Text = String.Format("{0:0.0000}", (IOM.GrossBillValue + decimal.Parse(lblTotalNet.Text)));
					lblTotalTaxableValue.Text = String.Format("{0:0.0000}", (IOM.TaxableAmount + decimal.Parse(lblTotalTaxableValue.Text)));
                 //   lblTotalNet.Text = String.Format("{0:0.0000}", (IOM.NetValue + decimal.Parse(lblTotalNet.Text)));
                    lblTotalVat.Text = String.Format("{0:0.0000}", (IOM.TaxAmount + decimal.Parse(lblTotalVat.Text)));
                    lblVat4.Text = String.Format("{0:0.0000}", (IOM.AdvanceRecieved + decimal.Parse(lblVat4.Text)));
                    lblVat5.Text = String.Format("{0:0.0000}", (IOM.TaxPercent + decimal.Parse(lblVat5.Text)));
                    lblVat55.Text = String.Format("{0:0.0000}", (IOM.GrossAmount + decimal.Parse(lblVat55.Text)));
                    lblVat12.Text = String.Format("{0:0.0000}", (IOM.AmountReceived + decimal.Parse(lblVat12.Text)));
                    lblVat13.Text = String.Format("{0:0.0000}", (IOM.ServiceCharge + decimal.Parse(lblVat13.Text)));
                    lblVat14.Text = String.Format("{0:0.0000}", (IOM.TaxAmount14 + decimal.Parse(lblVat14.Text)));
                    lblVat18.Text = String.Format("{0:0.0000}", (IOM.TaxAmount18 + decimal.Parse(lblVat18.Text)));
                    lblVat28.Text = String.Format("{0:0.0000}", (IOM.TaxAmount28 + decimal.Parse(lblVat28.Text)));
                    lblVat145.Text = String.Format("{0:0.0000}", (IOM.TaxAmount145 + decimal.Parse(lblVat145.Text)));
                    //lblVat0.Text = String.Format("{0:0.00}", (IOM.AmountRefund + decimal.Parse(lblVat0.Text)));
                    lblSVat0.Text = String.Format("{0:0.0000}", (IOM.AmountRefund / 2 + decimal.Parse(lblSVat0.Text)));
                    lblCVat0.Text = String.Format("{0:0.0000}", (IOM.AmountRefund / 2 + decimal.Parse(lblSVat0.Text)));

                    lblSVat5.Text = String.Format("{0:0.0000}", (IOM.TaxPercent / 2 + decimal.Parse(lblSVat5.Text)));
                    lblCVat5.Text = String.Format("{0:0.0000}", (IOM.TaxPercent / 2 + decimal.Parse(lblCVat5.Text)));

                    lblSVat12.Text = String.Format("{0:0.0000}", (IOM.TaxAmount12 / 2 + decimal.Parse(lblSVat12.Text)));
                    lblCVat12.Text = String.Format("{0:0.0000}", (IOM.TaxAmount12 / 2 + decimal.Parse(lblCVat12.Text)));

                    lblSVat18.Text = String.Format("{0:0.0000}", (IOM.TaxAmount18 / 2 + decimal.Parse(lblSVat18.Text)));
                    lblCVat18.Text = String.Format("{0:0.0000}", (IOM.TaxAmount18 / 2 + decimal.Parse(lblCVat18.Text)));

                    lblSVat28.Text = String.Format("{0:0.0000}", (IOM.TaxAmount28 / 2 + decimal.Parse(lblSVat28.Text)));
                    lblCVat28.Text = String.Format("{0:0.0000}", (IOM.TaxAmount28 / 2 + decimal.Parse(lblCVat28.Text)));

                    lblVatothers.Text = String.Format("{0:0.0000}", (IOM.CurrentDue + decimal.Parse(lblVatothers.Text)));
                    lblDiscount.Text = String.Format("{0:0.0000}", (IOM.Discount + decimal.Parse(lblDiscount.Text)));
                    lblTaxAmount.Text = String.Format("{0:0.0000}", (IOM.TaxAmount + decimal.Parse(lblTaxAmount.Text)));
                    lblRoundoff.Text = String.Format("{0:0.0000}", (IOM.Others + decimal.Parse(lblRoundoff.Text)));
                    lblSubTotal.Text = String.Format("{0:0.0000}", (IOM.DepositUsed + decimal.Parse(lblSubTotal.Text)));
                }
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
            if (rdotypes.SelectedItem.Value.ToLower().Contains("Summary"))
            {
            Grdsummarytax.AllowPaging = false;
            clearFooterControls();
            btnSearch_Click(sender, e);
            FilterControls(gvSales);
            ExportToExcel();
            Grdsummarytax.AllowPaging = true;
            if (lstSalesGSTDetail != null && lstSalesGSTDetail.Count > 0)
            {
                Grdsummarytax.DataSource = lstSalesGSTDetail;
                Grdsummarytax.DataBind();
            }
            
            }
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
        prefix = "Reports_";
        if (rdotypes.SelectedItem.Text == "Summary")
        {
            prefix = "Summary_Sales_Report_";
        }
        else
        {
            prefix = "Details_Sales_Report_";
        }
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
        HttpContext.Current.Response.Write(getReportHeader(rdotypes.SelectedItem.Text == "Summary", 33));
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
      //  idRep.RenderControl(oHtmlTextWriter);
        if (hdnextendedGrid.Value == "Y")
        {
            gvSales.RenderControl(oHtmlTextWriter);
            gvIPCreditMainGrandTotal.RenderControl(oHtmlTextWriter);
            MainGrandTotal.RenderControl(oHtmlTextWriter);
        }
        else
        {
            gvSales.RenderControl(oHtmlTextWriter);
            MainGrandTotal.RenderControl(oHtmlTextWriter);
        }

        if (rdotypes.SelectedItem.Value.ToLower().Contains("summary"))
        {
            if (hdnextendedGrid.Value == "Y")
            {
                Grdsummarytax.RenderControl(oHtmlTextWriter);

            }
            else
            {
                Grdsummarytax.RenderControl(oHtmlTextWriter);

            }

        }
       
        Response.Write(oStringWriter.ToString());
        Response.End();
    }

    public string getReportHeader(bool rptFlag, int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        DateTime fDate = txtFrom.Text.ToInternalDate();
        DateTime tDate = txtTo.Text.ToInternalDate();
        List<Organization> lstOrganization = new List<Organization>();
        if (rptFlag == true)
        {
            rptName = "Summary Sales Report";
        }
        else
        {
            rptName = "Details Sales Report";
        }
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
     //   rptName = rptName + "Sales Report";
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
    protected void btnprint_Click(object sender, EventArgs e)
    {
        if (rdotypes.SelectedItem.Value.ToLower().Contains("Summary"))
        {
            exporttopdf();
        }
        else
        {
            List<SalesTax> lstSalesDetail = null;
            gvSales.AllowPaging = false;
            divsummary.Visible = true;
            gvSales.Visible = true;
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
            
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "printdiv", "javascript:printwin();", true);
           
            gvSales.AllowPaging = true;
            
        }
    }
    public void exporttopdf()
    {
        List<SalesTax> lstDWCR = null;
        List<SalesTax> lstSalesDetail = null;
        List<SalesTax> lstDWCRGrandTotal = new List<SalesTax>();
        DateTime fDate = txtFrom.Text.ToInternalDate();
        DateTime tDate = txtTo.Text.ToInternalDate();
        string BillNumber = string.Empty;
        base.ContextInfo.AdditionalInfo = "GST";
        if (txtBillNumber.Text.Trim() != "")
        {
            BillNumber = Convert.ToString(txtBillNumber.Text);
        }
        int visitType = Convert.ToInt32(rbtSales.SelectedValue);
        new InventoryReports_BL(this.ContextInfo).GetSalesReport(fDate, tDate, 0, OrgID, ILocationID, BillNumber, out lstFinalBill, out lstSalesDetail, out lstSalesGSTDetail, visitType);
       
        string rptName = string.Empty;
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                StringBuilder sb = new StringBuilder();
                

                if (rdotypes.SelectedItem.Text == "Summary")
                {
                    rptName = "Chemist GST Summary Sales Report";
                }
                else
                {
                    rptName = "Chemist GST Details Sales Report";
                }
                List<Organization> lstOrganization = new List<Organization>();
                long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
                
               
                //Generate Invoice (Bill) Header.
                sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");

                sb.Append("<tr><td colspan = '2'></td></tr>");
                sb.Append("<tr><td align='center' colspan = '2'><b>");
                sb.Append(OrgName.ToString());
                sb.Append("</b></td></tr>");
                sb.Append("<tr><td align='center' style='font-size:9px' colspan = '2'>");
                sb.Append(lstOrganization[0].Address);
                sb.Append(" </td></tr>");
                sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2' style='font-size:12px'><b>" + rptName + "</b></td></tr>");
                sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2' style='font-size:10px'>" + "From Date:" + txtFrom.Text + "   To Date:" + txtTo.Text + "</td></tr>");

                sb.Append("</table>");
                sb.Append("<br />");


                //Generate Invoice (Bill) Items Grid.
                sb.Append("<table border = '1'>");
                sb.Append("<tr>");
                sb.Append("<td>");
                sb.Append("Rate (%)");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append("Taxable Value");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append("SGST");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append("CGST");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append("Tax Amount");
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append("Net Value");

                sb.Append("</td>");

                sb.Append("</tr>");
                sb.Append("<tr>");

                if (lstSalesGSTDetail != null && lstSalesGSTDetail.Count > 0)
                {
                     foreach (var row in lstSalesGSTDetail)
                       {
                           TotalTaxableValue += row.GrossValue;
                           TotalSGST += (row.TaxAmount / 2);
                           TotalCGST += (row.TaxAmount / 2);
                           TotalNetValue += row.NetValue;
                           TotalTaxAmount += row.TaxAmount;
                         sb.Append("<td>");
                     sb.Append(row.Tax);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(row.GrossValue);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(row.TaxAmount / 2);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(row.TaxAmount / 2);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(row.TaxAmount);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(row.NetValue);
                     sb.Append("</td>");

                      }
                     sb.Append("</tr>");
                     sb.Append("<tr><td align = 'right'>Total</td>");


                     sb.Append("<td>");
                     sb.Append(TotalTaxableValue);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(TotalSGST);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(TotalCGST);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(TotalTaxAmount);
                     sb.Append("</td>");
                     sb.Append("<td>");
                     sb.Append(TotalNetValue);
                     sb.Append("</td>");
                     sb.Append("</tr>");



                }
               
              

                sb.Append("</table>");
           

                //Export HTML String as PDF.
                StringReader sr = new StringReader(sb.ToString());
               
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
           
                pdfDoc.Close();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=" + rptName + ".pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                Response.End();
              
            }
        }
       
      
      
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
