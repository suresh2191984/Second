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
using System.IO;
public partial class ReportsLims_LabTestStatisticsReportLims : BasePage
{
    public ReportsLims_LabTestStatisticsReportLims()
        : base("ReportsLims_LabTestStatisticsReportLims_aspx")
    {
    }
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

        if (!IsPostBack)
        {
            LoadOrgan();
			LoadMeatData();
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
        DataColumn dcol2 = new DataColumn("TotalCounts");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["DeptName"] = item.DeptName;
            dr["TotalCounts"] = item.TotalCounts;
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
                DataTable dt = loaddata(lstday);
                //str = lbl.Text.ToString();
                //dt.TableName = str;
                ds.Tables.Add(dt);
                RMaster = (DayWiseCollectionReport)e.Row.DataItem;

                //LinkButton lnkDwcr = (LinkButton)e.Row.FindControl("lnkDate");
                //lnkDwcr.ToolTip = "Click Here To view " + RMaster.VisitDate + " details";
                //string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                //lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
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
                //LinkButton lnkDept = (LinkButton)e.Row.FindControl("lnkDept");
                Label lnkDept = (Label)e.Row.FindControl("lblDept");

                //string fType = string.Empty;
                //lnkDept.ToolTip = "Click Here To view " + dwcr.DeptName + " details";
                //string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + dwcr.DeptName + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                //lnkDept.OnClientClick = "ReportPopUP('" + url + "');";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMain_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    #region  Added from Jagatheeshkumar

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "VisitType,ReportFormat,ReportHdr";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "VisitType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblVisitType.DataSource = childItems;
                    rblVisitType.DataTextField = "DisplayText";
                    rblVisitType.DataValueField = "Code";
                    rblVisitType.DataBind();

                }
                var childItems1 = from child in lstmetadataOutputs
                                 where child.Domain == "ReportFormat"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    rblReportType.DataSource = childItems1;
                    rblReportType.DataTextField = "DisplayText";
                    rblReportType.DataValueField = "Code";
                    rblReportType.DataBind();

                }
                var childItems2 = from child in lstmetadataOutputs
                                  where child.Domain == "ReportHdr"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    rblHeader.DataSource = childItems2;
                    rblHeader.DataTextField = "DisplayText";
                    rblHeader.DataValueField = "Code";
                    rblHeader.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string AlrtWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt;
        string WindHMsg = Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_04 == null ? "No Matching Records found for the selected dates" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_04;
        string DispText = Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_01 == null ? "OP - Lab Test Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_01;
        string DispText1 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_02 == null ? "IP - Lab Test Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_02;
        string DispText2 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_03 == null ? "OP / IP - Lab Test Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_03;
        string DispText3 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_04 == null ? "Total No of Tests :" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabTestStaticsReportLims_aspx_04;
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string pHeaderName = Convert.ToString(rblHeader.SelectedItem.Value);
            if (pHeaderName == "0")
            {
                pHeaderName = "IMAGING";
            }
            if (rblReportType.SelectedItem.Value=="1")
            {
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                returnCode = new Report_BL(base.ContextInfo).GetLabTestStatReportLims(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);

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
                    //divOPDWCR.Attributes.Add("style", "block");
                    //divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    DivsumPrint.Visible = false;
                    divPrint.Visible = true;
                    divSumm.Visible = false;
                    if (visitType == 0)
                    {
                        //gvOPReport.Visible = false;
                        gvIPReport.Visible = true;
                        //gvIPReport.Columns[0].HeaderText = "OP - Lab Test Statistcs Report";
                        gvIPReport.Columns[0].HeaderText = DispText;
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == 1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        //gvIPReport.Columns[0].HeaderText = "IP - Lab Test Statistcs Report";
                        gvIPReport.Columns[0].HeaderText = DispText1;
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == -1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        //gvIPReport.Columns[0].HeaderText = "OP / IP - Lab Test Statistcs Report";
                        gvIPReport.Columns[0].HeaderText = DispText2;
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                }
                else
                {
                    //divOPDWCR.Attributes.Add("style", "none");
                    //divPrint.Attributes.Add("style", "none");
                    divOPDWCR.Visible = false;
                    divPrint.Visible = false;
                    divSumm.Visible = false;
                    DivsumPrint.Visible = false;

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + WindHMsg + "','" + AlrtWin + "');", true);
                }
            }
            else if (rblReportType.SelectedItem.Value == "0" || rblReportType.SelectedItem.Value == "2")
            {
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                returnCode = new Report_BL(base.ContextInfo).GetLabTestStatReportSummaryLims(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);
                if (lstDWCR.Count > 0)
                {
                    divOPDWCR.Visible = false;
                    DivsumPrint.Visible = true;
                    divPrint.Visible = false;
                    divSumm.Visible = true;

                    gvIPSummary.DataSource = lstDWCR;
                    gvIPSummary.DataBind();

                   // lblTottest.Text = "Total No of Tests : " + lstDWCR.Sum(O => O.TotalCounts).ToString();
                    lblTottest.Text = DispText3 + lstDWCR.Sum(O => O.TotalCounts).ToString();
                }
                else
                {
                    divOPDWCR.Visible = false;
                    DivsumPrint.Visible = false;
                    divPrint.Visible = false;
                    divSumm.Visible = false;
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv1", "javascript:alert('No Matching Records found for the selected dates');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv1", "javascript:ValidationWindow('" + WindHMsg + "','" + AlrtWin + "');", true);
                }

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
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
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
            Response.Clear();
            Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.xls", "Lab Test Statistics Report"));
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";

            StringWriter stringWrite = new StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            if (rblReportType.SelectedItem.Value == "1")
            {
                gvIPReport.RenderControl(htmlWrite);
            }
            if (rblReportType.SelectedItem.Value == "0")
            {
                gvIPSummary.RenderControl(htmlWrite);
            }

            Response.Write(stringWrite.ToString());
            Response.End();


            //string prefix = string.Empty;
            //prefix = "LabTest_Reports_";
            //string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            //DataSet dsrpt = (DataSet)ViewState["report"];
            //if (dsrpt != null)
            //{
            //    ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            //}
            //else
            //{
            //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting to Excel", ex);
        }
    }
}
