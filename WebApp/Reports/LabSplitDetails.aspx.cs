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

public partial class Reports_LabSplitDetails : BasePage
{
    long returnCode = -1;
    string deptName = string.Empty;
    string visitType = string.Empty;
    DateTime pDate = DateTime.MinValue;

    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
        deptName = Request.QueryString["dpt"];
        pDate = Convert.ToDateTime(Request.QueryString["vdt"]);
        visitType = Request.QueryString["vtype"];
        //visitType = (visitType == "OP") ? "0" : "1";
        visitType = (visitType == "OP") ? "0" : ((visitType == "IP") ? "1" : "-1");
        string fType = string.Empty;
        string pHeaderName = string.Empty;
        if (Request.QueryString["header"] == null)
        {
            pHeaderName = "";
        }
        else
        {
            pHeaderName = Request.QueryString["header"];
        }

        returnCode = new Report_BL(base.ContextInfo).GetLabStatSplitReport(pDate, deptName, Convert.ToInt32(visitType), OrgID, pHeaderName, out lstDWCR);
        if (lstDWCR.Count > 0)
        {
            divPrint.Attributes.Add("style", "block");
            divOPDWCR.Attributes.Add("style", "block");
            gvCollReport.Columns[0].HeaderText = "Collection Report (" + pDate.ToString("dd/MM/yyyy") + ")";
            gvCollReport.Visible = true;
            IEnumerable<DayWiseCollectionReport> temp = (from c in lstDWCR
                                                         group c by new { c.DeptName } into g
                                                         select new DayWiseCollectionReport
                                                         {
                                                             DeptName = g.Key.DeptName,
                                                         }).Distinct().ToList();


            gvCollReport.DataSource = temp;
            gvCollReport.DataBind();
        }
        else
        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the given date');", true);
        }
    }

    protected void gvCollReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //string visitType = rblVisitType.SelectedItem.Text;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.DeptName == RMaster.DeptName
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("gvCollIndDept");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollReport_RowDataBound OPCollectionReport", ex);
        }
    }

    protected void gvCollIndDept_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //string visitType = rblVisitType.SelectedItem.Text;
            visitType = Request.QueryString["vtype"];
            if (visitType == "OP")
            {
                e.Row.Cells[0].Visible = true;
                e.Row.Cells[1].Visible = false;
            }
            else if (visitType == "IP")
            {
                e.Row.Cells[0].Visible = true;
                e.Row.Cells[1].Visible = true;
            }
            else if (visitType == "OP-IP")
            {
                e.Row.Cells[0].Visible = true;
                e.Row.Cells[1].Visible = true;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).IPNumber.Trim() == "0")
                {
                    e.Row.Cells[1].Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollIndDept_RowDataBound OPCollectionReport", ex);
        }
    }

    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            ExportToExcel(prnReport);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void ExportToExcel(Control ctr)
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "Image Statistics Reports_";
      
        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
    
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        prnReport.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
