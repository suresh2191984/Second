using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Linq;
using ReportBusinessLogic;
using System.IO;
using System.Web;
using Attune.Podium.ExcelExportManager;


public partial class Reports_AntibioticsStatsReport : BasePage 
{
    DataSet _dsStatics = new DataSet();
    List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
    protected void Page_Load(object sender, EventArgs e)
    {
        ////hdnOrgID.Value = Convert.ToString(OrgID);
        try
        {
            AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load", ex);
        }
    }
   
    protected void btnsearch_Click(object sender, EventArgs e)
    {
      
        SearchData();
         
    }

    public void SearchData()
    {
        List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
        //int OrgID =Convert.ToInt32( hdnOrgID.Value);
        DateTime FromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime ToDate = Convert.ToDateTime(txtTo.Text);
        long ClientID = Convert.ToInt32(hdnClientID.Value);

        long result = -1;
        //  List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
        try
        {

            ReportBusinessLogic.ReportExcel_BL objReportExcel = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
            result = objReportExcel.getAntibioticsstatsReport(OrgID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), ClientID, out _dsStatics);
            if (_dsStatics.Tables.Count > 0)
            {
                grdReport.DataSource = _dsStatics.Tables[0].DefaultView;
                grdReport.DataBind();
                imgBtnXL.Visible = true;
                lblExport.Visible = true;
            }
            else
            {
                imgBtnXL.Visible = false;
                lblStatus.Visible = true;
                lblExport.Visible = false;
            }

            

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While GetAntibiotics Stats Report in WebService", ex);
        }
         
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
        DateTime FromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime ToDate = Convert.ToDateTime(txtTo.Text);
        long ClientID = Convert.ToInt32(hdnClientID.Value);

        long result = -1;
        ReportBusinessLogic.ReportExcel_BL objReportExcel = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
        result = objReportExcel.getAntibioticsstatsReport(OrgID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), ClientID, out _dsStatics);
        string prefix = string.Empty;
        prefix = "Antibiotics_Stats_Report_";
        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
        ExcelHelper.ToExcel(_dsStatics.Tables[0], rptDate, Page.Response);
      
    }

    //void ExportToExcel(DataTable dt, string FileName)
    //{
    //    if (dt.Rows.Count > 0)
    //    {
    //        string filename = FileName + ".xml";
    //        System.IO.StringWriter tw = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
    //        DataGrid dgGrid = new DataGrid();
    //        dgGrid.DataSource = dt;
    //        dgGrid.DataBind();
    //        //Get the HTML for the control.
    //        dgGrid.RenderControl(hw);
    //        //Write the HTML back to the browser.
    //        //Response.ContentType = application/vnd.ms-excel;
    //        Response.ContentType = "application/vnd.xml";
    //        Response.AppendHeader("Content-Disposition",
    //                              "attachment; filename=" + filename + "");
    //        this.EnableViewState = false;
    //        Response.Write(tw.ToString());
    //        hw.Close();
    //        tw.Close();
    //        Response.End();
    //    }
    //}

    protected void grdReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdReport.PageIndex = e.NewPageIndex;
        }
        btnsearch_Click(sender, e);
    }
   
}
