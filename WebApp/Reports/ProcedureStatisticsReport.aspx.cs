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

public partial class Reports_ProcedureStatisticsReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }

    protected void gvIPReport_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            int totNoofTests = 0;
            string visitType = rblVisitType.SelectedItem.Text;
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Item.DataItem;
                var childItems = (from child in lstDWCR
                                  where child.VisitDate == RMaster.VisitDate
                                  select child).OrderByDescending(o => o.TotalCounts);

                totNoofTests = childItems.Sum(O => O.TotalCounts);
                ((Label)e.Item.FindControl("lblTot")).Text = totNoofTests.ToString();

                decimal decTotalDetailAmount = 0;
                decTotalDetailAmount = childItems.Sum(O => O.BilledAmount);
                ((Label)e.Item.FindControl("lblDetTotalAmount")).Text = String.Format("{0:0.00}", decTotalDetailAmount);

                RMaster = (DayWiseCollectionReport)e.Item.DataItem;
                LinkButton lnkDwcr = (LinkButton)e.Item.FindControl("lnkDate");
                //lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";


                //string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                //lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                GridView childGrid = (GridView)e.Item.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }

    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string visitType = rblVisitType.SelectedItem.Text;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport dwcr = new DayWiseCollectionReport();
                dwcr = (DayWiseCollectionReport)e.Row.DataItem;
                LinkButton lnkDept = (LinkButton)e.Row.FindControl("lnkDept");
                if (dwcr.TotalCounts != 0)
                {
                    //string fType = string.Empty;
                    //lnkDept.ToolTip = "Click Here To view " + dwcr.DeptName + " details";

                    //string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + dwcr.DeptName + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    //lnkDept.OnClientClick = "ReportPopUP('" + url + "');";
                }
                else
                {
                    lnkDept.ForeColor = System.Drawing.Color.Black;
                    e.Row.BackColor = System.Drawing.Color.Aqua;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMain_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string pHeaderName = rblReportHeader.SelectedValue.ToString();
            string strHeaderText = rblReportHeader.SelectedItem.Text.ToString();

            if (ddlType.SelectedItem.Text == "Detailed")
            {

                returnCode = new Report_BL(base.ContextInfo).GetProcedureStatisticsReport(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);

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
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;
                    divSummary.Visible = false;
                    divSummPrint.Visible = false;

                    if (visitType == 0)
                    {
                        //gvOPReport.Visible = false;
                        gvIPReport.Visible = true;
                        //gvIPReport.Columns[0].HeaderText = "OP - Lab Statistcs Report";
                        lblHeader.Text = "OP - " + strHeaderText + " Statistcs Report"; //"OP - Procedure Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == 1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        lblHeader.Text = "IP - " + strHeaderText + " Statistcs Report"; //"IP - Procedure Statistcs Report";
                        //gvIPReport.Columns[0].HeaderText = "IP - Lab Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == -1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        lblHeader.Text = "OP / IP - Procedure Statistcs Report";
                        //gvIPReport.Columns[0].HeaderText = "OP / IP - Lab Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                }
                else
                {
                    lblHeader.Text = "Procedure Statistics Summary Report";
                    divOPDWCR.Visible = false;
                    divPrint.Visible = false;

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                }
            }
            else if (ddlType.SelectedItem.Text == "Summary")
            {
                returnCode = new Report_BL(base.ContextInfo).GetProStatisticsReportSummary(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);
                if (lstDWCR.Count > 0)
                {
                    decimal dblDetailTotal = 0;
                    foreach (var bill in lstDWCR)
                    {
                        dblDetailTotal = dblDetailTotal + bill.BilledAmount;
                    }
                    lblSummaryTotalAmount.Text = String.Format("{0:0.00}", dblDetailTotal);

                    divOPDWCR.Visible = false;
                    divSummary.Visible = true;
                    divPrint.Visible = false;
                    divSummPrint.Visible = true;
                    gvIPSummary.DataSource = lstDWCR;
                    gvIPSummary.DataBind();
                    //totTest.Text = "Total Number of Procedures Done (" + txtFDate.Text + " To " + txtTDate.Text + ") :" + lstDWCR.Sum(O => O.TotalCounts).ToString();
                    totTest.Text = "Total Number of " + strHeaderText + " (" + txtFDate.Text + " To " + txtTDate.Text + ") :" + lstDWCR.Sum(O => O.TotalCounts).ToString();
                }
                else
                {
                    divSummary.Visible = false;
                    divOPDWCR.Visible = false;
                    divPrint.Visible = false;
                    divSummPrint.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv1", "javascript:alert('No Matching Records found for the selected dates');", true);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, Pocedure Statistics Report", ex);
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
