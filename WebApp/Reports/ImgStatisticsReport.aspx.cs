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

public partial class Reports_ImgStatisticsReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    public DataSet ds = new DataSet();
    decimal Amount = 0;
    int ncases = 0;
    int ntests = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

        if (!IsPostBack)
        {
            LoadOrgan();
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            if (Request.QueryString["status"] == "LabOP")
            {
                rblVisitType.SelectedValue = "0";
                btnSubmit_Click(sender, e);
            }
            if (Request.QueryString["status"] == "LabIP")
            {
                rblVisitType.SelectedValue = "1";
                btnSubmit_Click(sender, e);
            }
            if (Request.QueryString["status"] == "LabOPIP")
            {
                rblVisitType.SelectedValue = "-1";
                btnSubmit_Click(sender, e);
            }
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
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("DeptName");
        DataColumn dcol2 = new DataColumn("NoOfTests");
        DataColumn dcol3 = new DataColumn("NoOfCases");       
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);   
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["DeptName"] = item.DeptName;
            dr["NoOfTests"] = item.NoOfTests;
            dr["NoOfCases"] = item.NoOfCases ;
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string visitType = rblVisitType.SelectedItem.Text;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;
                lstday = childItems.ToList();
                foreach (var items in childItems)
                {
                    Amount += Convert.ToDecimal(items.BilledAmount);
                    ncases += Convert.ToInt32(items.NoOfCases);
                    ntests += Convert.ToInt32(items.NoOfTests);

                }
                lblCases.Text = ncases.ToString();
                lblTests.Text = ntests.ToString();
                lblAmount.Text = Amount.ToString();
                DataTable dt = loaddata(lstday);
                //str = lbl.Text.ToString();
                //dt.TableName = str;
                ds.Tables.Add(dt);  
                RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&header=Imaging&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            ViewState["report"] = ds;
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
                //if (dwcr.FeeType != "")
                //{
                string fType = string.Empty;
                lnkDept.ToolTip = "Click Here To view " + dwcr.DeptName + " details";
                string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&header=Imaging&dpt=" + dwcr.DeptName + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                lnkDept.OnClientClick = "ReportPopUP('" + url + "');";              
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
            string pHeaderName = "Imaging";

            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetLabStatisticsReport(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);
            if (lstDWCR.Count > 0)
            {
                divExport.Style.Add("display", "block");
                if (rblReportType.SelectedItem.Value == "0")
                {

                    IEnumerable<DayWiseCollectionReport> pdcs = (from s in lstDWCR
                                                                 group s by new { s.DeptName } into g
                                                                 select new DayWiseCollectionReport
                                                         {
                                                             DeptName = g.Key.DeptName,
                                                             NoOfCases = g.Sum(i => i.NoOfCases),
                                                             NoOfTests = g.Sum(i => i.NoOfTests),
                                                             BilledAmount = g.Sum(i => i.BilledAmount)
                                                             //NoOfCases = g.Key.NoOfCases,
                                                             //NoOfTests = g.Key.NoOfTests,
                                                             //BilledAmount = g.Key.BilledAmount,


                                                         }
                                                          ).Distinct().ToList();


                    grdSummary.DataSource = pdcs;
                    grdSummary.DataBind();
                    divSummary.Style.Add("display", "block");
                    gvIPReport.DataSource = "";
                    gvIPReport.DataBind();
                    Summary.Attributes.Add("style", "block");
                    foreach (DayWiseCollectionReport lst in lstDWCR)
                    {
                        Amount += Convert.ToDecimal(lst.BilledAmount);
                        ncases += Convert.ToInt32(lst.NoOfCases);
                        ntests += Convert.ToInt32(lst.NoOfTests);
                    }  
                    lblCases.Text = ncases.ToString();
                    lblTests.Text = ntests.ToString();
                    lblAmount.Text = Amount.ToString();
                   
                }
                else
                {
                    grdSummary.DataSource = "";
                    grdSummary.DataBind();
                    divSummary.Style.Add("display", "none");
                    var dwcr = (from dw in lstDWCR
                                select new { dw.VisitDate }).Distinct();

                    List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
                    foreach (var obj in dwcr)
                    {
                        DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                        pdc.VisitDate = obj.VisitDate;
                        lstDayWiseRept.Add(pdc);
                    }


                    Summary.Attributes.Add("style", "block");
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;


                    if (visitType == 0)
                    {
                        //gvOPReport.Visible = false;
                        gvIPReport.Visible = true;
                        gvIPReport.Columns[0].HeaderText = "OP - Imaging Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                    }
                    else if (visitType == 1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        gvIPReport.Columns[0].HeaderText = "IP - Imaging Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                    }
                    else if (visitType == -1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        gvIPReport.Columns[0].HeaderText = "OP / IP - Imaging Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();
                    }


                }
            }
            else
            {
                Summary.Style.Add("display", "none");
                divExport.Style.Add("display", "none");
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;

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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ExportToExcel(prnReport);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting to Excel", ex);
        }
    }
    public void ExportToExcel(Control ctr)
    {
        //export to excel
        try
        {
            string rptDate = "Expiry Report_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

            prnReport.Style.Remove("Backcolor");
            // grdResult.RenderControl(oHtmlTextWriter);
            prnReport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
