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
public partial class Reports_GetRoomCollectionIPReport :BasePage
{
    long returnCode = -1;
    Decimal total=-1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

            if (!IsPostBack)            {               

                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            
            returnCode = new Report_BL(base.ContextInfo).GetRoomCollectionReportIP(fDate, tDate, OrgID, out lstDWCR,out total, ILocationID);
            var dwcr = (from dw in lstDWCR
                        select new { dw.BillDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.BillDate = obj.BillDate;
                lstDayWiseRept.Add(pdc);
            }
            if (lstDWCR.Count > 0)
            {
                divPrint.Attributes.Add("style", "block");
                divPrint.Visible = true;
                gvIPReport.Columns[0].HeaderText = "IP - Room Collection Report";
                gvIPReport.DataSource = lstDayWiseRept;
                gvIPReport.DataBind();
                CalculationPanelBlock();
            }
            else
            {               
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, RoomCollectionReport", ex);
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("IPNumber");
        DataColumn dcol2 = new DataColumn("InsuranceName");
        DataColumn dcol5 = new DataColumn("MLCNo");
        DataColumn dcol6 = new DataColumn("Age");
        DataColumn dcol7 = new DataColumn("ReferredBy");
        DataColumn dcol8 = new DataColumn("ConsultantName");
        DataColumn dcol9 = new DataColumn("SpecialityName");
        DataColumn dcol10 = new DataColumn("ADMDiagnosis");
        DataColumn dcol11 = new DataColumn("TypeofSurgery");
        DataColumn dcol12 = new DataColumn("SurgeonName");
        DataColumn dcol13 = new DataColumn("Anaesthetist");
        DataColumn dcol14 = new DataColumn("TypeofAnaesthesia");
        DataColumn dcol15 = new DataColumn("DischargeStatus");
        DataColumn dcol16 = new DataColumn("LengthofStay");
        DataColumn dcol17 = new DataColumn("DateofSurgery");
        DataColumn dcol18 = new DataColumn("Address");

        DataColumn dcol19 = new DataColumn("FinalBillID");
        DataColumn dcol20 = new DataColumn("Qty");
        DataColumn dcol21 = new DataColumn("BillDate");
        DataColumn dcol22 = new DataColumn("BillNumber");
        DataColumn dcol23 = new DataColumn("RoomName");
        DataColumn dcol24 = new DataColumn("BillAmount");
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

        dt.Columns.Add(dcol19);
        dt.Columns.Add(dcol20);
        dt.Columns.Add(dcol21);
        dt.Columns.Add(dcol22);
        dt.Columns.Add(dcol23);
        dt.Columns.Add(dcol24);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientID ;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["FinalBillID"] = item.FinalBillID;
            dr["Qty"] = item.Qty;
            dr["BillDate"] = item.BillDate;
            dr["BillNumber"] = item.BillNumber;
            dr["RoomName"] = item.RoomName;
            dr["BillAmount"] = item.BillAmount;            
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.BillDate == RMaster.BillDate
                                 select child;

                lstday = lstDWCR;
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
            CLogger.LogError("Error in Get Report, RoomCollectionReport", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).RoomName == "Total")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[5].Text = "";
                    //e.Row.Cells[6].Text = "";
                    //e.Row.Cells[16].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, RoomCollectionReport", ex);

        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ExportToExcel();
            //export to excel
            //string prefix = string.Empty;
            //prefix = "Room_Collection_Report_";
            //string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            //DataSet dsrpt = (DataSet)ViewState["report"];
            //if (dsrpt != null)
            //{
            //    ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            //}
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }


    public void ExportToExcel()
    {
        //export to excel
        string attachment = "attachment; filename=RoomCollectionReport.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        gvIPReport.RenderControl(oHtmlTextWriter);
        tabGranTotal1.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;

        lblGrandTotal.InnerText = String.Format("{0:0.00}", (total));
       
    }
    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
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
