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

public partial class Reports_ChequeDDStmt : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalChequeDDAmt = -1;
    decimal pTotalServiceCharge = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("Age");
        DataColumn dcol2 = new DataColumn("BillNumber");
        DataColumn dcol5 = new DataColumn("VisitType");
        DataColumn dcol6 = new DataColumn("ReceivedAmount");
        DataColumn dcol7 = new DataColumn("ServiceCharge");
        DataColumn dcol8 = new DataColumn("CreditorDebitCard");
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
            dr["PatientNumber"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["BillNumber"] = item.FinalBillID;
            dr["VisitType"] = item.VisitType;
            dr["ReceivedAmount"] = item.ReceivedAmount;
            dr["ServiceCharge"] = item.ServiceCharge;
            dr["CreditorDebitCard"] = item.CreditorDebitCard;
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
            //if (visitTypeID == 0)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //if (visitTypeID == 1)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //else if (visitTypeID == -1)
            //{
            //    e.Row.Cells[4].Visible = true;
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;

                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt);
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        int reportTypeID = Convert.ToInt32(rblReportType.SelectedValue);

        if (reportTypeID == 1)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    //e.Row.Cells[6].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        else if (reportTypeID == 0)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    //e.Row.Cells[6].Text = "";

                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
                else
                {
                    e.Row.Visible = false;
                }
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);

            returnCode = new Report_BL(base.ContextInfo).pGetCheckDDStmt(fDate, tDate, OrgID, visitType, out lstDWCR, out pTotalChequeDDAmt, out pTotalServiceCharge);

            var dwcr = (from dw in lstDWCR
                        select new { dw.VisitDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.VisitDate = obj.VisitDate;
                lstDayWiseRept.Add(pdc);
            }

            if (lstDWCR.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                if (visitType == 0)
                {
                    //gvOPReport.Visible = false;
                    gvIPReport.Visible = true;
                    gvIPReport.Columns[0].HeaderText = "OP - Cheque and DD Statement";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP - Cheque and DD Statement";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP / IP - Cheque and DD Statement";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
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
    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;


        lblCardTotal.InnerText = String.Format("{0:0.00}", (pTotalChequeDDAmt));
        lblServiceCharge.InnerText = String.Format("{0:0.00}", (pTotalServiceCharge));
    }
    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "ChequeDDStmt_Report_";
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
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
}