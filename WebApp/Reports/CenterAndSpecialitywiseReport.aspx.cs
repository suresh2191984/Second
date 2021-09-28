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
using Microsoft.Reporting.WebForms;
using System.Net;
using Attune.Podium.ExcelExportManager;
public partial class Reports_CenterAndSpecialitywiseReport : BasePage
{
    

    long returnCode = -1;
    List<DayWiseCollectionReport> lstPhy = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstPhy1 = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstPhy3 = new List<DayWiseCollectionReport>();
     List<DayWiseCollectionReport> lstPhy2 = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstPHYGrandTotal = new List<DayWiseCollectionReport>();
    DayWiseCollectionReport objDWCR = new DayWiseCollectionReport();
    AdminReports_BL arBL;
    Physician_BL PhysicianBL;
    List<Physician> lstPhysician = new List<Physician>();
    protected void Page_Load(object sender, EventArgs e)
    {
        arBL = new AdminReports_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
            LoadPhysicians(lstPhysician);
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        divPrint.Attributes.Add("style", "block");
        divPrint.Visible = true;
       
        
    }
    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Doctorsids=string.Empty;

        //foreach (ListItem item in ddlDoctorName.Items)
        //{
        //    if (item.Selected)
        //    {
        //        if (item.Text != "-----Select All-----")
        //        {
        //            Doctorsids += item.Value.ToString() + ",";
        //        }
              
        //    }
        //}

        var Doc = from dname in ddlDoctorName.Items.Cast<ListItem>()
                  where dname.Selected 
                  select dname.Value;

        Doctorsids += String.Join(",", Doc.ToArray());
        if (Doctorsids == string.Empty)
        {
            string sPath = "Reports\\\\CenterAndSpecialitywiseReport.aspx.cs_1";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "doctors", "javascript:alert('"+ sPath +"');", true);
        }
                 
        DateTime fDate = Convert.ToDateTime(txtFDate.Text);
        DateTime tDate = Convert.ToDateTime(txtTDate.Text);
        #region SSRs Report Now not working
        //returnCode = new Report_BL(base.ContextInfo).GetDepartmentWiseCollectionReport(fDate, tDate, OrgID, visitType, out lstCash, out lstCredit, out lstTotal, out pTotalDiscount, out pTotalRefund, out pTotalDue, out pTotalGrossAmount, out pTotalAdvance, out pCashDiscount, out pCreditDiscount);
        //grdCenterandspecialitywise.DataSource = lstCredit;
        //grdCenterandspecialitywise.DataBind();
        //rReportViewer.Visible = true;
        //string strURL = string.Empty;
        //string connectionString = string.Empty;
        //connectionString = Utilities.GetConnectionString();
        //rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
        //strURL = GetConfigValues("ReportServerURL", OrgID);
        //rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
        //rReportViewer.ServerReport.ReportPath = "/InvestigationReport/Report3";
        //rReportViewer.ShowParameterPrompts = false;
        //rReportViewer.ShowPrintButton = true;

        //Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
        //reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pFromDt", Convert.ToString(fDate));
        //reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pToDt", Convert.ToString(tDate));

        //reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("pPhysicianID", Doctorsids);
        //reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(OrgID));
        ////reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
        ////reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
        //rReportViewer.ServerReport.SetParameters(reportParameterList);
        //rptMdlPopup.Show();
        #endregion

        //Grid View 

        #region Grand Total
        decimal pTotalBillAmt = -1;
        decimal pTotalPreDueReceived = -1;
        decimal pTotalDiscount = -1;
        decimal pTotalNetValue = -1;
        decimal pTotalReceivedAmt = -1;
        decimal pTotalDue = -1;
        decimal pTax = -1;
        decimal pServiceCharge = -1;

        //int visitType = -1;
        fDate = Convert.ToDateTime(txtFDate.Text);
        tDate = Convert.ToDateTime(txtTDate.Text);
        int  currencyID = 63;
        int retreiveDataBaseOnVtype = -1;//== 3 ? -1 : visitType;

        returnCode = new Report_BL(base.ContextInfo).GetCollectionReportOPIP(fDate, tDate, OrgID, 0, retreiveDataBaseOnVtype, currencyID, out lstPhy, out pTotalBillAmt, out pTotalPreDueReceived, out pTotalDiscount, out pTotalNetValue, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge);
        
        var PhyItems = (from child1 in lstPhy
                                                     where  child1.PatientName == "TOTAL"
                                                      select child1).ToList();

        foreach (DayWiseCollectionReport obj in PhyItems)
        {
            objDWCR.PatientName = "Grand Total";
            objDWCR.BillAmount += obj.BillAmount;
            objDWCR.PreviousDue += obj.PreviousDue;
            objDWCR.CreditDue += obj.CreditDue;
            objDWCR.Discount += obj.Discount;
            objDWCR.NetValue += obj.NetValue;
            objDWCR.ReceivedAmount += obj.ReceivedAmount;
            objDWCR.Cash += obj.Cash;
            objDWCR.Cards += obj.Cards;
            objDWCR.Cheque += obj.Cheque;
            objDWCR.DD += obj.DD;
            objDWCR.Due += obj.Due;
            objDWCR.AmountRefund += obj.AmountRefund;
            objDWCR.IPAdvance += obj.IPAdvance;
            objDWCR.PaidCurrency = "--";
            objDWCR.PaidCurrencyAmount = 0;
            objDWCR.DepositUsed += obj.DepositUsed;
        }
       
        lstPHYGrandTotal.Add(objDWCR);
        if (PhyItems.Count > 0)
        {
            MainGrandTotal.Visible = true;
            MainGrandTotal.DataSource = lstPHYGrandTotal;
         MainGrandTotal.DataBind();
         MainGrandTotal.HeaderRow.Cells[1].Text = "";
         MainGrandTotal.Visible = true;
         //lblFromToDate.Text = "Date: " + txtFDate.Text + " - " + txtTDate.Text;
        }
        else
        {
            MainGrandTotal.Visible = true;
            MainGrandTotal.Visible = true;
        }
        #endregion

        //
        arBL.GetPhysicianReports(fDate, tDate, OrgID, Doctorsids, out lstPhy);
        lstPhy1 = lstPhy;
        lstPhy3 = lstPhy;
        


        var childItems = (from child in lstPhy
                          group new {child.PhysicianID,child.PhysicianName}
                          by child.PhysicianName into bynamegroup
                          select  bynamegroup.First());
        foreach (var list in childItems)
        {
            DayWiseCollectionReport obj = new DayWiseCollectionReport();
            obj.PhysicianName = list.PhysicianName;
            lstPhy2.Add(obj);
        }
        
        grdResult.Visible = true;
      
        //commented by sami
        //btnConverttoXL.Visible = true;
        grdResult.DataSource = lstPhy2;
        grdResult.DataBind();
        loaddata(lstPhy3);

 


    }
    public void LoadPhysicians(List<Physician> phySch)
    {
        if (phySch.Count > 0)
        {
            //code added for fixing bug - Begins
            var lstphy = (from phy in phySch select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
            //code added for fixing bug - ends
            ddlDoctorName.DataSource = lstphy;
            ddlDoctorName.DataTextField = "PhysicianName";
            ddlDoctorName.DataValueField = "PhysicianID";
            ddlDoctorName.DataBind();
            ddlDoctorName.Items.Insert(0, "Others");
            ddlDoctorName.Items[0].Value = "0";


            //int count = ddlDoctorName.Items.Count;
            //for (int i = 0; i < count; i++)
            //{
            //    ddlDoctorName.Items[i].Attributes.Add("onclick", "CheckRow(this.id)");
            //}



        }
    }
    int noofcases1 = 0;
    int nooftest1 = 0;
    decimal abill1 = 0;
    decimal SBill1= 0;
    
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport BMaster = (DayWiseCollectionReport)e.Row.DataItem;

                int noofcases = 0;
                int nooftest = 0;
                decimal abill = 0;
                decimal SBill = 0;



              var childItems = (from child in lstPhy1
                               where child.PhysicianName == BMaster.PhysicianName
                                select child);
                                
                //lstPhy1.FindAll(P => P.PhysicianName == BMaster.PhysicianName);
                   
                                 


                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                Label lblSubTotal = (Label)e.Row.FindControl("lblSubTotal");
                Label lblTest = (Label)e.Row.FindControl("lblTest");
                Label ActualBill = (Label)e.Row.FindControl("ActualBill");
                Label StdBill = (Label)e.Row.FindControl("StdBill");
                foreach (var data in childItems)
                {
                    if (data.Category != "Consultation")
                    {
                        nooftest = (data.NoOfTests + nooftest);
                        nooftest1 = nooftest + nooftest1;
                    }

                    noofcases = (data.NoOfCases + noofcases);

                    abill = (data.ActualBilled + abill);
                    SBill = (data.StdBillAmount + SBill);
                }

                lblSubTotal.Text =  noofcases.ToString();
                lblTest.Text =  nooftest.ToString();
                ActualBill.Text = String.Format("{0:0.00}", abill);
                StdBill.Text = String.Format("{0:0.00}", SBill);
               


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = " Please contact system administrator";
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
    }
    protected void grdChildResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //DayWiseCollectionReport BMaster = (DayWiseCollectionReport)e.Row.DataItem;
                //lblSubTotal.Text = String.Format("{0:0.00}", (BMaster.NoOfCases + int.Parse(lblSubTotal.Text)));

                ////Label category = (Label)e.Row.FindControl("category");
                ////DayWiseCollectionReport BMaster = (DayWiseCollectionReport)e.Row.DataItem;
                ////var childItems = (from child in lstPhy1
                ////                  where child.Category == category.Text && child.PhysicianName == BMaster.PhysicianName
                ////                  select child);


                ////GridView childGrid = (GridView)e.Row.FindControl("grdgrandChildResult");
                ////childGrid.DataSource = childItems;
                ////childGrid.DataBind();


                if ((e.Row.Cells[0].Text == "Consultation"))
                {
                    e.Row.Cells[2].Text = "NA";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstdcr)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PhysicianName");
        DataColumn dcol2 = new DataColumn("Category");
        DataColumn dcol3 = new DataColumn("SubCategory");
        DataColumn dcol4 = new DataColumn("NoOfTests");
        DataColumn dcol5 = new DataColumn("NoOfCases");
        DataColumn dcol6 = new DataColumn("ActualBilled");
        DataColumn dcol7 = new DataColumn("StdBillAmount");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        foreach (DayWiseCollectionReport item in lstdcr)
        {
            DataRow dr = dt.NewRow();
            dr["PhysicianName"] = item.PhysicianName;
            dr["Category"] = item.Category;
            dr["SubCategory"] = item.SubCategory;
            dr["NoOfTests"] = item.NoOfTests;
            dr["NoOfCases"] = item.NoOfCases;
            dr["ActualBilled"] = item.ActualBilled;
            dr["StdBillAmount"] = item.StdBillAmount;


            dt.Rows.Add(dr);

        }
        ViewState["report"] = dt;
        return dt;
    }
    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            
            DataTable dt = (DataTable)ViewState["report"];
            string prefix = string.Empty;
            prefix = "Physic_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            var ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
}
