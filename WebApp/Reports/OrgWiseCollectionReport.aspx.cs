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

public partial class Reports_OrgWiseCollectionReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
    SharedInventory_BL inventoryBL;
    Master_BL MasterBL;
    DataSet ds = new DataSet();
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);
        MasterBL = new Master_BL(base.ContextInfo);
        chekTrustedOrg.Focus();
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        
        MasterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (!IsPostBack)
        {

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            LoadOrgan();
            
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
                chekTrustedOrg.DataSource = lstOrgList;
                chekTrustedOrg.DataTextField = "Name";
                chekTrustedOrg.DataValueField = "OrgID";
                chekTrustedOrg.DataBind();
                chekTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                chekTrustedOrg.Focus();
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);

        }
    }
    #region  // LoadOrganisation //
    //private void LoadOrgan1()
    //{
    //    inventoryBL.GetSharingOrgList(OrgID, out lstorgn, out lstloc);
    //    if (lstorgn.Count > 0)
    //    {
    //        trTrustedOrg.Style.Add("display", "block");
    //        ddlTrustedOrg.DataSource = lstorgn;
    //        ddlTrustedOrg.DataTextField = "Name";
    //        ddlTrustedOrg.DataValueField = "OrgID";
    //        ddlTrustedOrg.DataBind();
    //        ddlTrustedOrg.Items.Insert(0, "-----All-----");
    //        ddlTrustedOrg.Items[0].Value = "-1";
    //        ddlTrustedOrg.SelectedValue = lstorgn.Find(p => p.OrgID == OrgID).ToString();
    //        ddlTrustedOrg.Focus();
    //    }
    //    else
    //    {
    //        trTrustedOrg.Style.Add("display", "none");
    //    }

    //}
    #endregion
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            long lUserID = 0;
            int pOrgID = OrgID;
            DataTable dtorg = new DataTable();
            //I have Use LoginID in OrgID
            DataColumn dbCol1 = new DataColumn("LoginID");
            dtorg.Columns.Add(dbCol1);
            DataRow dr;
            string chkValue = string.Empty;
            int selectedUserCount = 0;
            string OrgAll=string.Empty;
            if (Chkboxusers.Checked != true)
            {

                foreach (ListItem chkitem in chekTrustedOrg.Items)
                {

                    if (chkitem.Selected == true)
                    {
                        chkValue = chkitem.Value.ToString();
                        selectedUserCount++;
                        dr = dtorg.NewRow();
                        dr["LoginID"] = Convert.ToInt64(chkValue);
                        dtorg.Rows.Add(dr);

                    }

                }
                if (selectedUserCount < 1)
                {
                    lUserID = Convert.ToInt64(chkValue);
                }
                else
                {
                    lUserID = 0;
                }
            }
            int OrgAddressID = -1;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int currencyID = 0;
            int RefHospitalID = 0;
            int RefPhysicianID = 0;
            int ClientTypeID = 0;
            long ClientID = 0;
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            string pReportType = rblReportType.SelectedItem.Text;
            string pReportType1 = string.Empty;
            if (pReportType == "Summary")
            {
                pReportType1 = "S";
            }
            else
            {
                rblReportType.SelectedValue = "0";
                pReportType = "Summary";
            }
            int retreiveDataBaseOnVtype = visitType;
            string strObj = string.Empty;
            List<DayWiseCollectionReport> lstBillwiseDWCR = new List<DayWiseCollectionReport>();
            returnCode = new Report_BL(base.ContextInfo).GetOrgCollectionReport(fDate, tDate, pOrgID, 0, retreiveDataBaseOnVtype, currencyID, OrgID, pReportType, ClientID, OrgAddressID, strObj, ClientTypeID, RefPhysicianID, RefHospitalID, dtorg, out lstDWCR);

            var dwcr = (from dw in lstDWCR
                        select new { dw.OrgID, dw.OrganisationName }).Distinct();


            
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.OrgID = obj.OrgID;
                pdc.OrganisationName = obj.OrganisationName;
                lstDayWiseRept.Add(pdc);
            }

            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
            foreach (DayWiseCollectionReport obj1 in lstDayWiseRept)
            {
                DayWiseCollectionReport TotalVal = new DayWiseCollectionReport();
                foreach (DayWiseCollectionReport obj in lstDWCR)
                {
                    if (obj1.OrganisationName == obj.OrganisationName)
                    {
                        TotalVal.PatientName = obj.OrganisationName;
                        TotalVal.BillAmount += obj.BillAmount;
                        TotalVal.PreviousDue += obj.PreviousDue;
                        TotalVal.CreditDue += obj.CreditDue;
                        TotalVal.Discount += obj.Discount;
                        TotalVal.NetValue += obj.NetValue;
                        TotalVal.TaxAmount += obj.TaxAmount;
                        TotalVal.ReceivedAmount += obj.ReceivedAmount;
                        TotalVal.Cash += obj.Cash;
                        TotalVal.Cards += obj.Cards;
                        TotalVal.Cheque += obj.Cheque;
                        TotalVal.DD += obj.DD;
                        TotalVal.Due += obj.Due;
                        TotalVal.Coupon += obj.Coupon;
                        TotalVal.RefundAmt += obj.RefundAmt;
                        TotalVal.IPAdvance += obj.IPAdvance;
                        TotalVal.PaidCurrency = "--";
                        TotalVal.PaidCurrencyAmount = 0;
                        TotalVal.DepositUsed += obj.DepositUsed;
                        TotalVal.ServiceCharge += obj.ServiceCharge;
                        TotalVal.WriteOffAmount += obj.WriteOffAmount;
                    }
                }
                lstday.Add(TotalVal);
                
                
            }

            DayWiseCollectionReport TotalVal1 = new DayWiseCollectionReport();
            foreach (DayWiseCollectionReport obj in lstday)
            {
               TotalVal1.PatientName = "Grand Total";
               TotalVal1.BillAmount += obj.BillAmount;
               TotalVal1.PreviousDue += obj.PreviousDue;
               TotalVal1.CreditDue += obj.CreditDue;
               TotalVal1.Discount += obj.Discount;
               TotalVal1.NetValue += obj.NetValue;
               TotalVal1.TaxAmount += obj.TaxAmount;
               TotalVal1.ReceivedAmount += obj.ReceivedAmount;
               TotalVal1.Cash += obj.Cash;
               TotalVal1.Cards += obj.Cards;
               TotalVal1.Cheque += obj.Cheque;
               TotalVal1.DD += obj.DD;
               TotalVal1.Due += obj.Due;
               TotalVal1.Coupon += obj.Coupon;
               TotalVal1.RefundAmt += obj.RefundAmt;
               TotalVal1.IPAdvance += obj.IPAdvance;
               TotalVal1.PaidCurrency = "--";
               TotalVal1.PaidCurrencyAmount = 0;
               TotalVal1.DepositUsed += obj.DepositUsed;
               TotalVal1.ServiceCharge += obj.ServiceCharge;
               TotalVal1.WriteOffAmount += obj.WriteOffAmount;
                
            }
            lstday.Add(TotalVal1);
                


     
            gvIPCreditMainGrandTotal.DataSource = lstday;
            gvIPCreditMainGrandTotal.DataBind();
           
            if (pReportType1 == "S")
            {
                gvOrgwisePatientSummary.DataSource = null;
                gvOrgwisePatientSummary.DataBind();
            }
            else
            {
                gvOrgwisePatientSummary.DataSource = lstDayWiseRept;
                gvOrgwisePatientSummary.DataBind();
                rblReportType.SelectedValue = "1";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, OPCollectionReport", ex);
        }
    }
    protected void gvIPCreditMainGrandTotal_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                DayWiseCollectionReport TotalVal = new DayWiseCollectionReport();
                foreach (DayWiseCollectionReport obj1 in lstDayWiseRept)
                {
                    foreach (DayWiseCollectionReport obj in lstDWCR)
                    {
                        TotalVal.PatientName = "Grand Total";
                        TotalVal.BillAmount += obj.BillAmount;
                        TotalVal.PreviousDue += obj.PreviousDue;
                        TotalVal.CreditDue += obj.CreditDue;
                        TotalVal.Discount += obj.Discount;
                        TotalVal.NetValue += obj.NetValue;
                        TotalVal.TaxAmount += obj.TaxAmount;
                        TotalVal.ReceivedAmount += obj.ReceivedAmount;
                        TotalVal.Cash += obj.Cash;
                        TotalVal.Cards += obj.Cards;
                        TotalVal.Cheque += obj.Cheque;
                        TotalVal.DD += obj.DD;
                        TotalVal.Due += obj.Due;
                        TotalVal.Coupon += obj.Coupon;
                        TotalVal.RefundAmt += obj.RefundAmt;
                        TotalVal.IPAdvance += obj.IPAdvance;
                        TotalVal.PaidCurrency = "--";
                        TotalVal.PaidCurrencyAmount = 0;
                        TotalVal.DepositUsed += obj.DepositUsed;
                        TotalVal.ServiceCharge += obj.ServiceCharge;
                        TotalVal.WriteOffAmount += obj.WriteOffAmount;
                    }
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMainGrandTotal_RowDataBound CollectionReport", ex);
        }
    }
    protected void gvOrgGrandTotals_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                DayWiseCollectionReport TotalVal = new DayWiseCollectionReport();
                var childItems = from child in lstDWCR
                                 orderby child.VisitDate descending
                                 select child;
                foreach (DayWiseCollectionReport obj in childItems.ToList())
                {
                    TotalVal.PatientName = "Grand Total";
                    TotalVal.BillAmount += obj.BillAmount;
                    TotalVal.PreviousDue += obj.PreviousDue;
                    TotalVal.CreditDue += obj.CreditDue;
                    TotalVal.Discount += obj.Discount;
                    TotalVal.NetValue += obj.NetValue;
                    TotalVal.TaxAmount += obj.TaxAmount;
                    TotalVal.ReceivedAmount += obj.ReceivedAmount;
                    TotalVal.Cash += obj.Cash;
                    TotalVal.Cards += obj.Cards;
                    TotalVal.Cheque += obj.Cheque;
                    TotalVal.DD += obj.DD;
                    TotalVal.Due += obj.Due;
                    TotalVal.Coupon += obj.Coupon;
                    TotalVal.RefundAmt += obj.RefundAmt;
                    TotalVal.IPAdvance += obj.IPAdvance;
                    TotalVal.PaidCurrency = "--";
                    TotalVal.PaidCurrencyAmount = 0;
                    TotalVal.DepositUsed += obj.DepositUsed;
                    TotalVal.ServiceCharge += obj.ServiceCharge;
                    TotalVal.WriteOffAmount += obj.WriteOffAmount;
                }
                lstday.Add(TotalVal);
                GridView grdOrgwiseGrandTotal = (GridView)e.Row.FindControl("grdOrgwiseGrandTotal");
                grdOrgwiseGrandTotal.DataSource = lstday;
                grdOrgwiseGrandTotal.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdOrgwiseGrandTotal_RowDataBound CollectionReport", ex);
        }
    }
    protected void grdOrgwiseGrandTotal_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
                e.Row.Cells[5].Text += "<br/><b style='color:green;'>" + "(-)Refund" + " " + Convert.ToDecimal(e.Row.Cells[7].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + "Total Received: " + (Convert.ToDecimal(e.Row.Cells[6].Text) - Convert.ToDecimal(e.Row.Cells[7].Text)).ToString() + "</b>";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMainGrandTotal_RowDataBound CollectionReport", ex);
        }
    }
    protected void gvOrgwiseGrandTotal_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
                e.Row.Cells[5].Text += "<br/><b style='color:green;'>" + "(-)Refund" + " " + Convert.ToDecimal(e.Row.Cells[7].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + "Total Received: " + (Convert.ToDecimal(e.Row.Cells[6].Text) - Convert.ToDecimal(e.Row.Cells[7].Text)).ToString() + "</b>";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMainGrandTotal_RowDataBound CollectionReport", ex);
        }
    }
    protected void gvOrgwisePatientSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<DayWiseCollectionReport> lstDateWiseRept = new List<DayWiseCollectionReport>();
                Label lblOrgID = (Label)e.Row.FindControl("lblOrgID");
                GridView gvDatewisePatientDetail = (GridView)e.Row.FindControl("gvDatewisePatientDetail");
                var dwcr = (from dw in lstDWCR
                            select new { dw.BillDate }).Distinct();
                foreach (var obj in dwcr)
                {
                    DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                    pdc.BillDate = obj.BillDate;
                    pdc.OrgID = Convert.ToInt64(lblOrgID.Text.Trim());
                    lstDateWiseRept.Add(pdc);
                }
                gvDatewisePatientDetail.DataSource = lstDateWiseRept;
                gvDatewisePatientDetail.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvOrgwisePatientSummary_RowDataBound  CollectionReport", ex);
        }
    }
    protected void gvDatewisePatientDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPatientCount = (Label)e.Row.FindControl("lblPatientCount");
                if (rblReportType.SelectedValue == "0")
                {
                    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                    DayWiseCollectionReport TotalVal = new DayWiseCollectionReport();
                    Label lblBillDate = (Label)e.Row.FindControl("lblBillDate");
                    Label lblOrgID = (Label)e.Row.FindControl("lblOrgID");
                    lblPatientCount.Style.Add("display", "none");
                    //var gRow = (GridViewRow)(sender as Control).Parent.Parent;
                    var childItems = from child in lstDWCR
                                     where child.BillDate.ToString() == lblBillDate.Text && child.OrgID == Convert.ToInt64(lblOrgID.Text.Trim())
                                     orderby child.BillDate descending
                                     select child;
                    foreach (DayWiseCollectionReport obj in childItems.ToList())
                    {
                        TotalVal.PatientName = "TOTAL";
                        TotalVal.BillAmount += obj.BillAmount;
                        TotalVal.PreviousDue += obj.PreviousDue;
                        TotalVal.CreditDue += obj.CreditDue;
                        TotalVal.Discount += obj.Discount;
                        TotalVal.NetValue += obj.NetValue;
                        TotalVal.TaxAmount += obj.TaxAmount;
                        TotalVal.ReceivedAmount += obj.ReceivedAmount;
                        TotalVal.Cash += obj.Cash;
                        TotalVal.Cards += obj.Cards;
                        TotalVal.Cheque += obj.Cheque;
                        TotalVal.DD += obj.DD;
                        TotalVal.Due += obj.Due;
                        TotalVal.RefundAmt += obj.RefundAmt;
                        TotalVal.IPAdvance += obj.IPAdvance;
                        TotalVal.PaidCurrency = "--";
                        TotalVal.PaidCurrencyAmount = 0;
                        TotalVal.DepositUsed += obj.DepositUsed;
                        TotalVal.Coupon += obj.Coupon;
                        TotalVal.ServiceCharge += obj.ServiceCharge;
                        TotalVal.WriteOffAmount += obj.WriteOffAmount;
                    }
                    lstday.Add(TotalVal);
                    DataTable dt = loaddata(lstday);
                    ds.Tables.Add(dt);
                    GridView gvOrgwisePatientDetail = (GridView)e.Row.FindControl("gvOrgwisePatientDetail");
                    if (lstday.Count() > 0)
                    {
                        gvOrgwisePatientDetail.DataSource = lstday;
                        gvOrgwisePatientDetail.DataBind();
                    }
                    //lblPatientCount.Text = " <b> &nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;Total no of Patients : </b>" + lstday.Count().ToString();
                }
                else
                {
                    Label lblBillDate = (Label)e.Row.FindControl("lblBillDate");
                    Label lblOrgID = (Label)e.Row.FindControl("lblOrgID");
                    GridView gvOrgwisePatientDetail = (GridView)e.Row.FindControl("gvOrgwisePatientDetail");
                    var childItems = from chld in
                                         (from child in lstDWCR
                                          where child.BillDate.ToString() == lblBillDate.Text && child.OrgID == Convert.ToInt64(lblOrgID.Text.Trim())
                                          orderby child.PatientName, child.VisitDate descending
                                          select child)
                                     orderby chld.FinalBillID ascending
                                     select chld;

                    DataTable dt = loaddata(childItems.ToList());
                    ds.Tables.Add(dt);
                    if (childItems.Count() > 0)
                    {
                        gvOrgwisePatientDetail.DataSource = childItems;
                        gvOrgwisePatientDetail.DataBind();
                    }
                    lblPatientCount.Text = "  &nbsp;&nbsp;&nbsp; /&nbsp;&nbsp;&nbsp;<b>Total no of Patients :<b> " + (childItems.Count() - 1).ToString();
                }
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvDatewisePatientDetail_RowDataBound  CollectionReport", ex);
        }
    }
    protected void gvOrgwisePatientDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (rblReportType.SelectedValue == "0")
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    e.Row.Cells[1].Text = "";
                }
                e.Row.Cells[0].Style.Add("display", "none");
                e.Row.Cells[2].Style.Add("display", "none");
                e.Row.Cells[3].Style.Add("display", "none");
                e.Row.Cells[16].Style.Add("display", "none");
                e.Row.Cells[17].Style.Add("display", "none");
                e.Row.Cells[18].Style.Add("display", "none");
                e.Row.Cells[19].Style.Add("display", "none");
                e.Row.Cells[20].Style.Add("display", "none");
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    if (Convert.ToDecimal(e.Row.Cells[9].Text) == 0 && e.Row.Cells[0].Text.Trim() != "")
                    {
                        e.Row.Style.Add("color", "red");
                        e.Row.ToolTip = "Due collection bill";
                    }
                }
                e.Row.Cells[17].Style.Add("display", "block");
                e.Row.Cells[18].Style.Add("display", "block");
                e.Row.Cells[19].Style.Add("display", "block");
                e.Row.Cells[20].Style.Add("display", "block");
                e.Row.Cells[16].Style.Add("display", "none");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPatientName = (Label)e.Row.Cells[0].FindControl("lblPatientName");
                if (lblPatientName != null && (lblPatientName.Text == "" || lblPatientName.Text == "TOTAL"))
                {
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                    e.Row.Cells[9].Text += "<br/><b style='color:green;'>" + "(-)Refund" + " " + Convert.ToDecimal(e.Row.Cells[8].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + "Total Received: " + (Convert.ToDecimal(e.Row.Cells[10].Text) - Convert.ToDecimal(e.Row.Cells[8].Text)).ToString() + "</b>";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvOrgwisePatientDetail_RowDataBound  CollectionReport", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
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
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();


        DataColumn dcol1 = new DataColumn("PatientNo");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("BillNumber");
        DataColumn dcol5 = new DataColumn("BillAmount");
        DataColumn dcol6 = new DataColumn("TaxAmount");
        DataColumn dcol7 = new DataColumn("Discount");
        DataColumn dcol8 = new DataColumn("RefundAmt");
        DataColumn dcol9 = new DataColumn("NetValue");
        DataColumn dcol10 = new DataColumn("ReceivedAmount");
        DataColumn dcol11 = new DataColumn("Cash");
        DataColumn dcol12 = new DataColumn("Cards");
        DataColumn dcol13 = new DataColumn("Cheque");
        DataColumn dcol14 = new DataColumn("DD");
        DataColumn dcol15 = new DataColumn("Coupon");
        DataColumn dcol16 = new DataColumn("Due");
        DataColumn dcol17 = new DataColumn("ServiceCharge");
        DataColumn dcol18 = new DataColumn("WriteOffAmount");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol16);
        dt.Columns.Add(dcol17);
        dt.Columns.Add(dcol18);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNo"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["BillNumber"] = item.BillNumber;
            dr["BillAmount"] = item.BillAmount;
            dr["TaxAmount"] = item.TaxAmount;
            dr["Discount"] = item.Discount;
            dr["RefundAmt"] = item.RefundAmt;
            dr["NetValue"] = item.NetValue;
            dr["ReceivedAmount"] = item.ReceivedAmount;
            dr["Cash"] = item.Cash;
            dr["Cards"] = item.Cards;
            dr["Cheque"] = item.Cheque;
            dr["DD"] = item.DD;
            dr["Coupon"] = item.Coupon;
            dr["Due"] = item.Due;
            dr["ServiceCharge"] = item.ServiceCharge;
            dr["WriteOffAmount"] = item.WriteOffAmount;

            dt.Rows.Add(dr);
        }
        return dt;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public void ExportToExcel()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=Daywise_collection_report_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            gvIPCreditMainGrandTotal.RenderControl(oHtmlTextWriter);
            gvOrgwisePatientSummary.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, Daywise_collection_report_", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
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
