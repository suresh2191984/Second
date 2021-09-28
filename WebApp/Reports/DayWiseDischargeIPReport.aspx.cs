using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Podium.ExcelExportManager;
using System.Collections.Generic;

public partial class Reports_DayWiseDischargeIPReport :BasePage 
{
    long returnCode = -1;
    DataSet ds = new DataSet();
    Master_BL masterBL;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    //decimal pTotalBillAmt = -1;
    //decimal   pTotalDiscount = -1;
    //decimal pTotalDue = -1;
    //decimal  pTotalNetValue = -1;
    //decimal   pTotalReceivedAmt = -1;
    //decimal pServiceCharge = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }

    protected void gvDaywiseDischargeRpt_RowBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[1].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");

            }
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("AdmissionDate");
        DataColumn dcol4 = new DataColumn("DischargeDT");
        DataColumn dcol11 = new DataColumn("BilledAmount");
        DataColumn dcol5 = new DataColumn("NetValue");
        DataColumn dcol6 = new DataColumn("AmountReceived");
        DataColumn dcol7 = new DataColumn("Discount");
        DataColumn dcol8 = new DataColumn("Refund");
        DataColumn dcol9 = new DataColumn("Due");
        DataColumn dcol10 = new DataColumn("AdvanceAmount");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientID;
            dr["PatientName"] = item.PatientName;
            dr["AdmissionDate"] = item.DoAdmission ;
            dr["DischargeDT"] = item.DoDischarge ;
            dr["NetValue"] = item.NetValue;
            dr["BilledAmount"] = item.BillAmount;
            dr["AmountReceived"] = item.AmountReceived;
            dr["Discount"] = item.Discount;
            dr["Refund"] = item.AmountRefund;
            dr["Due"] = item.Due;
            dr["AdvanceAmount"] =item.ReceivedAmount ;
            dt.Rows.Add(dr);
        }
        return dt;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
            masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            returnCode = new Report_BL(base.ContextInfo).GetDayWiseDisChargeReport(fDate, tDate, OrgID,out lstDWCR , 1, LID, BaseCurrencyID);
          //Lamda For getting Total 

            //var lsttotal = (from lsttemp in lstDWCR
            //                group lsttemp by new {  lsttemp.NetValue, lsttemp.Discount, lsttemp.AmountRefund, lsttemp.Due, lsttemp.IPAdvance } into g
            //                select new DayWiseCollectionReport
            //                {
            //                    NetValue = g.Sum(p => p.NetValue),
            //                    Discount = g.Sum(p => p.Discount),
            //                    AmountRefund = g.Sum(p => p.AmountRefund),
            //                    Due = g.Sum(p => p.Due),
            //                    IPAdvance = g.Sum(p => p.IPAdvance)
            //                }).Distinct().ToList();




            if (lstDWCR.Count > 0)
            {
                lstday = lstDWCR;
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt);
                gvDaywiseDischargeRpt.Visible = true;
                gvDaywiseDischargeRpt.DataSource = lstDWCR;
                gvDaywiseDischargeRpt.DataBind();
                divPrint.Style.Add("display", "block");
                //gvDaywiseDischargeRpt.DataSource = lsttotal;
                //gvDaywiseDischargeRpt.DataBind();
                //gvDaywiseDischargeRpt.Visible = true;
                //DataTable dt = loaddata(lstDWCR);
                //ds.Tables.Add(dt);
                //ViewState["report"] = ds;


            }
            else
            {
                gvDaywiseDischargeRpt.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
           
            ViewState["report"] = ds;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, DayWiseDischrgeReport", ex);
        }
    }


    protected void gvDaywiseDischargeRpt_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "Total")
                {
                    e.Row.Cells[0].Text = "";
                   // e.Row.Cells[1].Text = "TOTAL";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    //e.Row.Cells[6].Text = "";
                    //e.Row.Cells[16].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, DayWiseDischargeReport", ex);

        }
    }

     //gvIPReport.DataSource = lstOverAllInfo;
     //           gvIPReport.DataBind();
     //           gvIPReport.Visible = true;
     //           DataTable dt = loaddata(lstDWCR);
     //           ds.Tables.Add(dt);
     //           ViewState["report"] = ds;
     //           hdnXLFlag.Value = "1";

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
         
        try
        {
            string prefix = string.Empty;
            prefix = "DayWiseDischarge_Report";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while converting to Excel", ex);
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
}
