
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
public partial class Reports_CollectionReportLIMS : BasePage
{
    public Reports_CollectionReportLIMS()
        : base("Reports_CollectionReportLIMS_aspx")
    {
    }
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    SharedInventory_BL inventoryBL;
    Master_BL MasterBL;
    DataSet ds = new DataSet();
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    string select = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_01 == null ? "--Select--" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_01;
    string strall = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_02 == null ? "--All--" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_02;
    string strtotal = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_03 == null ? "Total no of Patients :" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_03;
    string strgrand = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_04 == null ? "Grand Total" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_04;
    string strreceived = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_05 == null ? "Total Received" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_05;
    string strtot = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_06 == null ? "TOTAL" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_06;
    string strcan = Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_07 == null ? "(-)Cancel" : Resources.Reports_ClientDisplay.Reports_CollectionReportLIMS_aspx_07;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;

   
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);
        MasterBL = new Master_BL(base.ContextInfo);
        ddlTrustedOrg.Focus();
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        string showdes = GetConfigValue("ShowDescription", OrgID);
        if (showdes != "Y")
        {
            ChkBoxShowDescription.Style.Add("display", "none");
        }


        MasterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (!IsPostBack)
        {

            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            MasterBL.GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
            if (lstCurrOrgMapp.Count > 0)
            {
                ddlCurrency.DataSource = lstCurrOrgMapp;
                ddlCurrency.DataTextField = "CurrencyName";
                ddlCurrency.DataValueField = "CurrencyID";
                ddlCurrency.DataBind();
                ddlCurrency.Items.Insert(0, strall);
                ddlCurrency.Items[0].Value = "0";
            }
            LoadOrgan();
            GetClientType();
            loadlocations(RoleID, OrgID);
            LoadMeatData();
        }
    }
    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ListItem lstItem = new ListItem();
                lstItem.Text = select;
                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get InvClientType", ex);
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
                trTrustedOrg.Style.Add("display", "block");
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                //ddlTrustedOrg.Items.Insert(0, "-----All-----");
                //ddlTrustedOrg.Items[0].Value = "-1";
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }
            else
            {
                trTrustedOrg.Style.Add("display", "none");
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
            String[] ArrClientid;
            long ClientID;
            if (hdnSelectedClientID.Value != "")
            {
                String ClientId = hdnSelectedClientID.Value;
                ArrClientid = ClientId.Split('|');
                ClientID = Convert.ToInt32(ArrClientid[0].ToString());
            }
            else {

                ClientID = 0;
            }
            int pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int OrgAddressID = Convert.ToInt32(ddlLocation.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            int currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int RefHospitalID = Convert.ToInt32(hdnReferringHospitalID.Value);
            int RefPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            //long ClientID = Convert.ToInt32(hdnSelectedClientID.Value);

            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            string pReportType = rblReportType.SelectedValue;
            string advFilter = rdoAdvList.SelectedValue;
            string btFilter = rdoBTList.SelectedValue;
            int retreiveDataBaseOnVtype = visitType;
            string strObj = string.Empty;
            List<DayWiseCollectionReport> lstBillwiseDWCR = new List<DayWiseCollectionReport>();
            if (rdoBTList.SelectedValue == "CB")
            {
                strObj = "0";
            }
            else if (rdoBTList.SelectedValue == "NCB")
            {
                strObj = "1";
            }
            returnCode = new Report_BL(base.ContextInfo).GetOPCollectionReportLIMS(fDate, tDate, pOrgID, 0, retreiveDataBaseOnVtype, currencyID, OrgID, pReportType, ClientID, OrgAddressID, strObj, ClientTypeID, RefPhysicianID, RefHospitalID, out lstDWCR);
            //--Added by vijayalakshmi---//
            if (pReportType == "Detailed")
            {
                if (lstDWCR.Count > 0)
                {
                    for (int i = 0; i < lstDWCR.Count; i++)
                    {
                        if (lstDWCR[i].Age != "" && lstDWCR[i].Age != null)
                        {
                            string str = lstDWCR[i].Age;
                            string[] strage = str.Split(' ');
                            if (strage[1] == "Years")
                            {
                                lstDWCR[i].Age = strage[0] + " " + strYear;
                            }
                            else if (strage[1] == "Months")
                            {
                                lstDWCR[i].Age = strage[0] + " " + strMonth;
                            }
                            else if (strage[1] == "Days")
                            {
                                lstDWCR[i].Age = strage[i] + " " + strDay;
                            }
                            else if (strage[1] == "Weeks")
                            {
                                lstDWCR[i].Age = strage[0] + " " + strWeek;
                            }
                            else
                            {
                                lstDWCR[i].Age = strage[0] + " " + strYear;
                            }
                        }
                    }
                }
            }
            //---- END---//

            var dwcr = (from dw in lstDWCR
                        select new { dw.OrgID, dw.OrganisationName }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.OrgID = obj.OrgID;
                pdc.OrganisationName = obj.OrganisationName;
                lstDayWiseRept.Add(pdc);
            }
            gvIPCreditMainGrandTotal.DataSource = lstDayWiseRept;
            gvIPCreditMainGrandTotal.DataBind();
            gvOrgwisePatientSummary.DataSource = lstDayWiseRept;
            gvOrgwisePatientSummary.DataBind();
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
string DayWiseCollectionReportFoPrima = GetConfigValue("DayWiseCollectionReportFoPrima", OrgID);
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                List<DayWiseCollectionReport> lstday1 = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                DayWiseCollectionReport TotalVal = new DayWiseCollectionReport();
                Label lblOrgID = (Label)e.Row.FindControl("lblOrgID");
                var childItems = from child in lstDWCR
                                 where child.OrgID == Convert.ToInt64(lblOrgID.Text.Trim()) // && child.PatientName != "" && child.FinalBillID == 1
                                 orderby child.VisitDate descending
                                 select child;
                if (rblReportType.SelectedValue == "1")
                {
                    childItems = from child in lstDWCR
                                 where child.OrgID == Convert.ToInt64(lblOrgID.Text.Trim()) && child.FinalBillID == 1
                                 orderby child.VisitDate descending
                                 select child;
                }
                foreach (DayWiseCollectionReport obj in childItems.ToList())
                {
                    TotalVal.PatientName = strgrand;
                    TotalVal.BillAmount += obj.BillAmount;
                    TotalVal.PreviousDue += obj.PreviousDue;
                    TotalVal.CreditDue += obj.CreditDue;
                    
                    TotalVal.HOSRefund += obj.HOSRefund;//Added by Thamilselvan For adding the Redeem amount in Collection Report..

                    TotalVal.Discount += obj.Discount;
                    TotalVal.NetValue += obj.NetValue;
                    TotalVal.TaxAmount += obj.TaxAmount;
                    TotalVal.ReceivedAmount += obj.ReceivedAmount;
                    TotalVal.Cash += obj.Cash;
                    TotalVal.Cards += obj.Cards;
                    TotalVal.Cheque += obj.Cheque;
                    TotalVal.DD += obj.DD;
                    //TotalVal.Due += obj.Due;
 if (DayWiseCollectionReportFoPrima == "Y")
                {
                    TotalVal.Due += obj.Due;
                    TotalVal.AmtReceivedServiceCharge += obj.AmtReceivedServiceCharge;
     
                }
                    TotalVal.TotalAmount += obj.TotalAmount; 
                    TotalVal.Coupon += obj.Coupon;
                    TotalVal.RefundAmt += obj.RefundAmt;
                    TotalVal.IPAdvance += obj.IPAdvance;
                    TotalVal.PaidCurrency = "--";
                    TotalVal.PaidCurrencyAmount = 0;
                    TotalVal.DepositUsed += obj.DepositUsed;
                    TotalVal.ServiceCharge += obj.ServiceCharge;
                    TotalVal.WriteOffAmount += obj.WriteOffAmount;
                    TotalVal.RoundOff += obj.RoundOff;
                }
if (DayWiseCollectionReportFoPrima !="Y") 
                {
                    TotalVal.Due = TotalVal.NetValue - TotalVal.ReceivedAmount - TotalVal.WriteOffAmount;
                }
                //TotalVal.Due = TotalVal.NetValue - TotalVal.ReceivedAmount - TotalVal.WriteOffAmount;
                lstday.Add(TotalVal);
                GridView gvOrgwiseGrandTotal = (GridView)e.Row.FindControl("gvOrgwiseGrandTotal");
                gvOrgwiseGrandTotal.DataSource = lstday;
                gvOrgwiseGrandTotal.DataBind();
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
              //  e.Row.Cells[6].Text += "<br/><b style='color:green;'>" + "(-)Refund" + " " + Convert.ToDecimal(e.Row.Cells[8].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + "Total Received: " + (Convert.ToDecimal(e.Row.Cells[6].Text) - Convert.ToDecimal(e.Row.Cells[8].Text)).ToString() + "</b>";
                e.Row.Cells[6].Text += "<br/><b style='color:green;'>" + strcan + " " + Convert.ToDecimal(e.Row.Cells[9].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + strreceived + (Convert.ToDecimal(e.Row.Cells[6].Text) - Convert.ToDecimal(e.Row.Cells[9].Text)).ToString() + "</b>";
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
                        TotalVal.PatientName = strtot;
                        TotalVal.BillAmount += obj.BillAmount;
                        TotalVal.PreviousDue += obj.PreviousDue;
                        TotalVal.CreditDue += obj.CreditDue;
                        
                        TotalVal.HOSRefund += obj.HOSRefund;//Added by Thamilselvan For adding the Redeem amount in Collection Report..

                        TotalVal.Discount += obj.Discount;
                        TotalVal.NetValue += obj.NetValue;
                        TotalVal.TaxAmount += obj.TaxAmount;
                        TotalVal.ReceivedAmount += obj.ReceivedAmount;
                        TotalVal.AmtReceivedServiceCharge += obj.AmtReceivedServiceCharge;
                        TotalVal.Cash += obj.Cash;
                        TotalVal.Cards += obj.Cards;
                        TotalVal.Cheque += obj.Cheque;
                        TotalVal.DD += obj.DD;
                        TotalVal.Due += obj.Due;
                        TotalVal.TotalAmount+=obj.TotalAmount;
                        TotalVal.RefundAmt += obj.RefundAmt;
                        TotalVal.IPAdvance += obj.IPAdvance;
                        TotalVal.PaidCurrency = "--";
                        TotalVal.PaidCurrencyAmount = 0;
                        TotalVal.DepositUsed += obj.DepositUsed;
                        TotalVal.Coupon += obj.Coupon;
                        TotalVal.ServiceCharge += obj.ServiceCharge;
                        TotalVal.WriteOffAmount += obj.WriteOffAmount;
                        TotalVal.RoundOff += obj.RoundOff;
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
                                        
                                     //orderby chld.FinalBillID ascending
                                     orderby chld.BillNumber ascending
                                     orderby chld.RowID ascending
                                     
                                     select chld;

                    DataTable dt = loaddata(childItems.ToList());
                    ds.Tables.Add(dt);
                    if (childItems.Count() > 0)
                    {
                        gvOrgwisePatientDetail.DataSource = childItems;
                        gvOrgwisePatientDetail.DataBind();
                    }
                    lblPatientCount.Text = "  &nbsp;&nbsp;&nbsp; /&nbsp;&nbsp;&nbsp;<b>"+strtotal+"<b> " + (childItems.Count() - 1).ToString();
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
                e.Row.Cells[18].Style.Add("display", "none");
                e.Row.Cells[21].Style.Add("display", "none");
                e.Row.Cells[22].Style.Add("display", "none");
                e.Row.Cells[23].Style.Add("display", "none");
                e.Row.Cells[24].Style.Add("display", "none");
            }
            else
            {
                //if (e.Row.RowType == DataControlRowType.DataRow)
                //{
                //    if (Convert.ToDecimal(e.Row.Cells[9].Text) == 0 && e.Row.Cells[0].Text.Trim() != "")
                //    {
                //        e.Row.Style.Add("color", "red");
                //        e.Row.ToolTip = "Due collection bill";
                //    }
                //}
                e.Row.Cells[19].Style.Add("display", "block");
                e.Row.Cells[20].Style.Add("display", "block");
                e.Row.Cells[21].Style.Add("display", "block");
                e.Row.Cells[22].Style.Add("display", "block");
                if (rdoBTList.SelectedValue != "NCB")
                {
                    e.Row.Cells[18].Style.Add("display", "block");
                }
                else
                {
                    e.Row.Cells[18].Style.Add("display", "none");
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPatientName = (Label)e.Row.Cells[0].FindControl("lblPatientName");
                if (lblPatientName != null && (lblPatientName.Text == "" || lblPatientName.Text == "TOTAL"))
                {
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black"); 
                    e.Row.Cells[11].Text += "<br/><b style='color:green;'>" + strcan + " " + Convert.ToDecimal(e.Row.Cells[9].Text).ToString() + " </b>" + "<br/><b style='color:green;'>" + strreceived+ (Convert.ToDecimal(e.Row.Cells[11].Text) - Convert.ToDecimal(e.Row.Cells[9].Text)).ToString() + "</b>";

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
        DataColumn dcol7 = new DataColumn("Redeem");//Added by Thamilselvan For adding the Redeem amount in Collection Report..
        DataColumn dcol8 = new DataColumn("Discount");
        DataColumn dcol9 = new DataColumn("RefundAmt");
        DataColumn dcol10 = new DataColumn("NetValue");
        DataColumn dcol11 = new DataColumn("ReceivedAmount");
        DataColumn dcol12 = new DataColumn("Cash");
        DataColumn dcol13 = new DataColumn("Cards");
        DataColumn dcol14 = new DataColumn("Cheque");
        DataColumn dcol15 = new DataColumn("DD");
        DataColumn dcol16 = new DataColumn("Coupon");
        DataColumn dcol17 = new DataColumn("Due");
        DataColumn dcol18 = new DataColumn("ServiceCharge");
        DataColumn dcol19 = new DataColumn("WriteOffAmount");
        DataColumn dcol20 = new DataColumn("RoundOff");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);//Added by Thamilselvan For adding the Redeem amount in Collection Report..
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
        dt.Columns.Add(dcol19);
        dt.Columns.Add(dcol20);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNo"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["BillNumber"] = item.BillNumber;
            dr["BillAmount"] = item.BillAmount;
            dr["TaxAmount"] = item.TaxAmount;
            dr["Redeem"] = item.HOSRefund;//Added by Thamilselvan For adding the Redeem amount in Collection Report..
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
            dr["RoundOff"] = item.RoundOff;

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
            string attachment = "attachment; filename=Daywise_collection_report_" + OrgTimeZone + ".xls";
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
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadlocations(RoleID, Convert.ToInt32(ddlTrustedOrg.SelectedValue));
        ClearValues();
    }
    protected void ClearValues()
    {
        hdnPhysicianID.Value = "0";
        txtReferringPhysician.Text = string.Empty;
        hdnReferringHospitalID.Value = "0";
        txtReferringHospital.Text = string.Empty;
        hdnSelectedClientID.Value = "0";
        txtClient.Text = string.Empty;
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            ddlLocation.SelectedValue = ILocationID.ToString();
            //*******************************************************************//
            ListItem lstItem = new ListItem();
            lstItem.Text = select;
            lstItem.Value = "0";
            ddlLocation.Items.Insert(0, lstItem);
            //*******************************************************************//
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetLocation", ex);
        }
    }

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "VisitType1,ReportFormat1,BTList,AdvList";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "VisitType1"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblVisitType.DataSource = childItems;
                    rblVisitType.DataTextField = "DisplayText";
                    rblVisitType.DataValueField = "Code";
                    rblVisitType.DataBind();
                    rblVisitType.SelectedIndex = 0;



                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "ReportFormat1"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblReportType.DataSource = childItems1;
                    rblReportType.DataTextField = "DisplayText";
                    rblReportType.DataValueField = "Code";
                    rblReportType.DataBind();
                    rblReportType.SelectedIndex = 1;


                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "BTList"
                                  select child;
                if (childItems.Count() > 0)
                {
                    rdoBTList.DataSource = childItems2;
                    rdoBTList.DataTextField = "DisplayText";
                    rdoBTList.DataValueField = "Code";
                    rdoBTList.DataBind();
                    rdoBTList.SelectedIndex = 2;


                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "AdvList"
                                  select child;
                if (childItems.Count() > 0)
                {
                    rdoAdvList.DataSource = childItems3;
                    rdoAdvList.DataTextField = "DisplayText";
                    rdoAdvList.DataValueField = "Code";
                    rdoAdvList.DataBind();
                    rdoAdvList.SelectedIndex = 2;


                }



            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

}
