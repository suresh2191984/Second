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

public partial class Reports_DepartmentWiseDetailReportPopUp : BasePage
{
    long returnCode = -1;
    string deptName = string.Empty;
    int visitType = 0;
    DateTime visitdate =DateTime.MinValue;
    DateTime visitFdate = DateTime.MinValue;
    DateTime visitTdate = DateTime.MinValue;

    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalNetValue = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;
    decimal Total = 0;

    IEnumerable<DayWiseCollectionReport> temp;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lst = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
        deptName = Request.QueryString["dpt"];
        visitdate = Convert.ToDateTime(Request.QueryString["vdt"]);
        visitType =Convert.ToInt32(Request.QueryString["vtype"]);

        string fType = string.Empty;
        if (Request.QueryString["vdt"] != null)
        {
            //returnCode = new Report_BL(base.ContextInfo).GetCollectionRptIndDeptOPIP(visitdate, visitdate, OrgID, Convert.ToInt32(visitType), deptName, out lstDWCR);
            returnCode = new Report_BL(base.ContextInfo).GetCollectionRptDptWiseOPIP(visitdate, visitdate, OrgID, 0, Convert.ToInt32(visitType), out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, "0");
        }
        else if ((Request.QueryString["vfdt"] != null) && (Request.QueryString["vtdt"] != null))
        {
            visitFdate = Convert.ToDateTime(Request.QueryString["vfdt"]);
            visitTdate = Convert.ToDateTime(Request.QueryString["vtdt"]);
            //returnCode = new Report_BL(base.ContextInfo).GetCollectionRptIndDeptOPIP(visitFdate, visitTdate, OrgID, Convert.ToInt32(visitType), deptName, out lstDWCR);
            returnCode = new Report_BL(base.ContextInfo).GetDepartmentWiseDetailReportPopUp(visitFdate, visitTdate, OrgID, visitType, out lstDWCR);
        }
        if (lstDWCR.Count > 0)
        {
                fType = deptName;
         

            //lblDeptName.Text = fType;
            divPrint.Attributes.Add("style", "block");
            divOPDWCR.Attributes.Add("style", "block");
            gvCollReport.Columns[0].HeaderText = "Collection Report (" + visitdate.ToString("dd/MM/yyyy") + ")";
            gvCollReport.Visible = true;
            temp = (from c in lstDWCR
                           group c by new { c.FeeType} into g
                                    select new DayWiseCollectionReport
                           {
                               FeeType = g.Key.FeeType,
                           }).Distinct().ToList();


            

            if (Request.QueryString["vdt"] != null)
            {
                
                if (deptName != "0")
                {
                    var childItems = from child in lstDWCR
                                     where child.FeeType == fType
                                     orderby child.VisitDate
                                     select child;
                    lst = childItems.ToList();

                    tblgvCollIndDeptS.Visible = true;
                    gvCollReport.Visible = false;
                    lblFeeType.Text = fType;
                    gvCollIndDeptS.DataSource = childItems;
                    gvCollIndDeptS.DataBind();
                }
                else
                {
                    tblgvCollIndDeptS.Visible = false;
                    gvCollReport.Visible = true;
                    gvCollReport.DataSource = temp;
                    gvCollReport.DataBind();
                }
            }
            else if ((Request.QueryString["vfdt"] != null) && (Request.QueryString["vtdt"] != null))
            {
                if (deptName != "0")
                {
                    var childItems = from child in lstDWCR
                                     where child.FeeType == fType
                                     orderby child.VisitDate
                                     select child;
                    lst = childItems.ToList();

                    tblgvCollIndDeptS.Visible = true;
                    gvCollReport.Visible = false;
                    lblFeeType.Text = fType;
                    gvCollIndDeptS.DataSource = childItems;
                    gvCollIndDeptS.DataBind();
                }
                else
                {
                    tblgvCollIndDeptS.Visible = false;
                    gvCollReport.Visible = true;
                    gvCollReport.DataSource = temp;
                    gvCollReport.DataBind();
                }
            }
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
                                 where child.FeeType == RMaster.FeeType
                                 orderby child.VisitDate
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("gvCollIndDept");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }
    protected void gvCollIndDeptS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport de = (DayWiseCollectionReport) e.Row.DataItem;

                //string pagename = "?vid=" + de.PatientVisitId + "&pagetype=BP&bid=" + de.FinalBillID + "";
                //e.Row.Cells[0].Attributes.Add("onclick", "openViewBill('" + pagename + "','" + deptName + "')");
                //e.Row.Cells[0].Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
                Total += de.AmountReceived;
                lblGrdTot.Text = " Grand Total :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Convert.ToString(Total);
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollIndDeptS_RowDataBound", ex);
        }
    }

    protected void gvCollIndDept_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //string pagename = "?vid=" + lstRcvd.VisitID + "&pagetype=BP&bid=" + lstRcvd.FinalBillID + "";
                //e.Row.Cells[0].Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "')");
                DayWiseCollectionReport dwcr = new DayWiseCollectionReport();
                dwcr = (DayWiseCollectionReport)e.Row.DataItem;
                Total+=dwcr.AmountReceived;
                lblGrdTot.Text = " Grand Total :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Convert.ToString(Total);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollIndDept_RowDataBound", ex);
        }
    }
}
