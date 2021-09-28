using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;

public partial class ReportsLims_DaywiseCollectionRevenueReport : BasePage
{
    long returnCode = -1;
    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    DataSet ds = new DataSet();

    List<DayWiseCollectionRevenueReport> lstDWCR = new List<DayWiseCollectionRevenueReport>();
    List<DayWiseCollectionRevenueReport> lstOverAllInfo = new List<DayWiseCollectionRevenueReport>();
    string DispAll = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01 == null ? "-----All-----" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01;
    string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        masterBL = new Master_BL(base.ContextInfo);
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (CID > 0)
        {
            txtClientName.Text = UserName;
            txtClientName.Attributes.Add("disabled", "true");
           
        }
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            
            loadlocations(RoleID, OrgID);
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
  

    bool gvFlag = true;
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {

       
        try
        {



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            long ClientID = 0;
            if (CID > 0)
            {
                ClientID = CID;
            }

            else
            {
 		if (txtClientName.Text == "" || txtClientName.Text == null)
                {
                    hdnClientID.Value = "0";
                }
                else
                {
                    ClientID = Convert.ToInt64(hdnClientID.Value);
                }
            }
        
            DateTime fDate, tDate;
            DateTime.TryParse(txtFDate.Text, out fDate);
            DateTime.TryParse(txtTDate.Text, out tDate);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            string pLocationID = ddlLocation.SelectedValue.ToString();


            returnCode = new Report_BL(base.ContextInfo).GetDaywiseCollectionRevenueReport(fDate, tDate, OrgID, Convert.ToInt64(pLocationID), ClientID, out lstDWCR);
            if (lstDWCR.Count > 0)
            {
                grdResult.DataSource = lstDWCR;
                grdResult.DataBind();
                hdnXLFlag.Value = "1";
            }
            else
            {
                grdResult.DataSource = "";
                grdResult.DataBind();
                hdnXLFlag.Value = "0";
            }

            //lstOverAllInfo = (from lst in lstDWCR

            //                  group lst by new { lst.FeeType, lst.BillNumber, lst.VisitDate, lst.PatientName, lst.Age, lst.PaidCurrency, lst.DepositUsed, lst.Discount, lst.Due, lst.AmountReceived, lst.AmountRefund} into g

            //                  select new DayWiseCollectionReport
            //                  {
            //                      FeeType = g.Key.FeeType,
            //                      BillNumber = g.Key.BillNumber,
            //                      VisitDate = g.Key.VisitDate,
            //                      PatientName = g.Key.PatientName,
            //                      Age = g.Key.Age,
            //                      DepositUsed = g.Key.DepositUsed,
            //                      Discount = g.Key.Discount,
            //                      Due = g.Key.Due,
            //                      AmountReceived = g.Key.AmountReceived,
            //                      ItemQuantity = g.Sum(p => p.ItemQuantity),
            //                      ItemAmount = g.Sum(p => p.ItemAmount),
            //                      BilledAmount = g.Sum(p => p.BilledAmount),
            //                      PaidCurrency = g.Key.PaidCurrency,
            //                      PaidCurrencyAmount = g.Sum(p => p.PaidCurrencyAmount),
            //                      AmountRefund = g.Key.AmountRefund,
            //                  }
            //                ).Distinct().ToList();

            //if (lstOverAllInfo.Count() > 0)
            //{

            //    gvIPReport.DataSource = lstOverAllInfo;
            //    gvIPReport.DataBind();
            //    gvIPReport.Visible = true;
            //    DataTable dt = loaddata(lstDWCR);
            //    ds.Tables.Add(dt);
            //    ViewState["report"] = ds;
            //    hdnXLFlag.Value = "1";
            //    divPrint.Visible = true;
            //}
            //else
            //{
            //    gvIPReport.DataSource = null;
            //    gvIPReport.DataBind();
            //    ViewState.Remove("report");
            //    hdnXLFlag.Value = "0";
            //}

        }


        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BillWiseDeptCollectionReport", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save Group", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
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




    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "BillWisePatientWiseReport.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {

                    grdResult.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionRevenueReport dwcr = (DayWiseCollectionRevenueReport)e.Row.DataItem;
                if (dwcr.PatientName.Trim() == "TOTAL")
                {
                    e.Row.CssClass = "grdrows";
                    e.Row.Cells[0].Text = "";
                    
                }
                if (dwcr.PatientName.Trim() == "GROSS TOTAL")
                {
                    e.Row.CssClass = "grdrows";
                    e.Row.Cells[0].Text = "";
                    
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Day wise Collection Revenue Details", ex);
        }
    }

    public class GridDecorator
    {
        public static void MergeRows(GridView gridView)
        {
            decimal PAmt = 0;
            decimal CAmt = 0;
            for (int rowIndex = gridView.Rows.Count - 3; rowIndex >= 0; rowIndex--)
            {
                GridViewRow row = gridView.Rows[rowIndex];
                GridViewRow previousRow = gridView.Rows[rowIndex + 1];

                if (row.Cells[0].Text == previousRow.Cells[0].Text)
                {
                    //Bill Number,Patient Name,Age,Visit Date
                    for (int i = 0; i < 4; i++)
                    {
                        if (row.Cells[i].Text == previousRow.Cells[i].Text)
                        {
                            row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                                   previousRow.Cells[i].RowSpan + 1;
                            previousRow.Cells[i].Visible = false;
                        }
                    }
                    //BilledAmount
                    for (int i = 5; i < 6; i++)
                    {
                        PAmt = Convert.ToDecimal(previousRow.Cells[i].Text);
                        CAmt = Convert.ToDecimal(row.Cells[i].Text);

                        PAmt += CAmt;
                        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                               previousRow.Cells[i].RowSpan + 1;
                        previousRow.Cells[i].Visible = false;
                        row.Cells[i].Text = Convert.ToString(PAmt);
                    }
                    //DiscountAmount
                    for (int i = 6; i < 10; i++)
                    {
                        if (row.Cells[i].Text == previousRow.Cells[i].Text)
                        {
                            row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                                   previousRow.Cells[i].RowSpan + 1;
                            previousRow.Cells[i].Visible = false;
                        }
                    }

                    //for (int i = 7; i < 8; i++)
                    //{
                    //    PAmt = Convert.ToDecimal(previousRow.Cells[i].Text);
                    //    CAmt = Convert.ToDecimal(row.Cells[i].Text);

                    //    PAmt += CAmt;
                    //    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                    //                           previousRow.Cells[i].RowSpan + 1;
                    //    previousRow.Cells[i].Visible = false;
                    //    row.Cells[i].Text = Convert.ToString(PAmt);
                    //}
                    //for (int i = 8; i < 10; i++)
                    //{
                    //    if (row.Cells[i].Text == previousRow.Cells[i].Text)
                    //    {
                    //        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                    //                               previousRow.Cells[i].RowSpan + 1;
                    //        previousRow.Cells[i].Visible = false;
                    //    }
                    //}

                }
            }
        }
    }

    public class ChildGridDecorator
    {
        public static void MergeRows(GridView gridView)
        {
            for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
            {
                GridViewRow row = gridView.Rows[rowIndex];
                GridViewRow previousRow = gridView.Rows[rowIndex + 1];

                for (int i = 2; i < row.Cells.Count; i++)
                {
                    if (row.Cells[i].Text == previousRow.Cells[i].Text)
                    {
                        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                               previousRow.Cells[i].RowSpan + 1;
                        previousRow.Cells[i].Visible = false;
                    }
                }
            }
        }
    }

    protected void loadlocations(long uroleID, int intOrgID)
    {
        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlLocation.DataSource = LoginLoc;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
            else
            {
                ddlLocation.DataSource = lstOrganizationAddress;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
        }
        ddlLocation.Items.Insert(0, DispSelect);
        ddlLocation.Items[0].Value = "0";
        ddlLocation.SelectedValue = Convert.ToString(ILocationID);
    }
}