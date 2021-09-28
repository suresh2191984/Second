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

public partial class ReportsLims_BillWiseDeptCollectionReportLims : BasePage
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

    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstOverAllInfo = new List<DayWiseCollectionReport>();
    string DispAll = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01 == null ? "-----All-----" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01;
    string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
    string NeedmodeofPayment = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        NeedmodeofPayment = GetConfigValue("NeedModeofPaymentinBillWise", OrgID);

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
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            masterBL.GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
            if (lstCurrOrgMapp.Count > 0)
            {
                ddlCurrency.DataSource = lstCurrOrgMapp;
                ddlCurrency.DataTextField = "CurrencyName";
                ddlCurrency.DataValueField = "CurrencyID";
                ddlCurrency.DataBind();
                ddlCurrency.Items.Insert(0, DispAll);
                ddlCurrency.Items[0].Value = "0";
            }
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
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();

        DataColumn dcol1 = new DataColumn("BillNumber");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("Description");
        DataColumn dcol5 = new DataColumn("VisitDate");
        DataColumn dcol6 = new DataColumn("FeeType");
        DataColumn dcol7 = new DataColumn("BilledAmount");
        DataColumn dcol8 = new DataColumn("AmountReceived");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();

            dr["BillNumber"] = item.BillNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["Description"] = item.Description;
            dr["VisitDate"] = item.VisitDate.ToString("dd/MMM/yy hh:mm tt");
            dr["FeeType"] = item.FeeType;
            dr["BilledAmount"] = item.BilledAmount;
            dr["AmountReceived"] = item.AmountReceived;

            dt.Rows.Add(dr);
        }
        return dt;
    }


    bool gvFlag = true;
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;

                var childItems = from child in lstDWCR

                                 where child.BillNumber == RMaster.BillNumber
                                 && child.FeeType == RMaster.FeeType
                                 group child by new { child.FeeType, child.ConsultantName, child.BilledAmount, child.AmountReceived, child.ItemAmount } into g

                                 select new DayWiseCollectionReport

                                 {
                                     FeeType = g.Key.FeeType,
                                     ConsultantName = g.Key.ConsultantName,
                                     BilledAmount = g.Key.BilledAmount,
                                     AmountReceived = g.Key.AmountReceived,
                                     ItemAmount = g.Key.ItemAmount,
                                 };

                if (RMaster.FeeType == "Total")
                {
                    e.Row.BackColor = System.Drawing.Color.Gray;
                    e.Row.Font.Bold = true;
                    e.Row.Font.Size = 8;
                    e.Row.Cells[0].Text = "";

                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[4].Text = "";


                }
                GridView childGrid = (GridView)e.Row.FindControl("gvDescription");



                if (gvFlag == true)
                {
                    childGrid.ShowHeader = true;
                    gvFlag = false;
                }
                else
                {
                    childGrid.ShowHeader = false;
                }


                childGrid.DataSource = childItems;
                childGrid.DataBind();
                ChildGridDecorator.MergeRows(childGrid);
            }


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
            long LID = 0;
            if (CID > 0)
            {
                LID = CID;
            }

            else
            {
 		if (txtClientName.Text == "" || txtClientName.Text == null)
                {
                    hdnClientID.Value = "0";
                }
                else
                {
                    LID = Convert.ToInt64(hdnClientID.Value);
                }
            }
        
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate, tDate;
            DateTime.TryParse(txtFDate.Text, out fDate);
            DateTime.TryParse(txtTDate.Text, out tDate);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            string pLocationID = ddlLocation.SelectedValue.ToString();

            if (!String.IsNullOrEmpty(pLocationID))
            {
                ContextInfo.AdditionalInfo = pLocationID;
            }
            else
            {
                ContextInfo.AdditionalInfo = ILocationID.ToString();
            }
            returnCode = new Report_BL(base.ContextInfo).GetBillWiseDeptCollectionReportLims(fDate, tDate, OrgID, LID, visitType, currencyID, out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, "0");
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

            if (NeedmodeofPayment == "Y")
            {
                grdResult.Columns[13].Visible = true;
            }
            else
            {
                grdResult.Columns[13].Visible = false;
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
                DayWiseCollectionReport dwcr = (DayWiseCollectionReport)e.Row.DataItem;
                if (dwcr.PatientName.Trim() == "Total")
                {
                    e.Row.CssClass = "grdrows";
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[5].Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Patient-wise Bill-wise Collection Details", ex);
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

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}