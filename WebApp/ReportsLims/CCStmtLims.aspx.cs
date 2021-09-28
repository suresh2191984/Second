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
public partial class ReportsLims_CCStmtLims : BasePage
{
    public ReportsLims_CCStmtLims()
        : base("ReportsLims_CCStmtLims_aspx")
    {

    }
   
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalCardAmt = -1;
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
            LoadOrgan();
            LoadPaymentMode();
            LoadMetaData();
        }
    }
    public void LoadMetaData()
    {
        try
        {
                    long returncode = -1;
                    string domains = "ReportFormat,VisitType";
                    string[] Tempdata = domains.Split(',');
                    string LangCode = "en-GB";
                    // string LangCode = string.Empty;
                    List<MetaData> lstmetadataInput = new List<MetaData>();
                    List<MetaData> lstmetadataOutput = new List<MetaData>();

                    MetaData objMeta;

                    for (int i = 0; i < Tempdata.Length; i++)
                    {
                        objMeta = new MetaData();
                        objMeta.Domain = Tempdata[i];
                        lstmetadataInput.Add(objMeta);

                    }

                    // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
                    returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                    //if (returncode == 0)
                    //{
                    if (lstmetadataOutput.Count > 0)
                    {
                        var ReportFormat = from child in lstmetadataOutput
                                           where child.Domain == "ReportFormat"
                                         orderby child.DisplayText
                                         select child;
                        rblReportType.DataSource = ReportFormat;
                        rblReportType.DataTextField = "DisplayText";
                        rblReportType.DataValueField = "Code";
                        rblReportType.DataBind();
                        
                        rblReportType.SelectedValue = "-1";

                        var VisitType = from child in lstmetadataOutput
                                        where child.Domain == "VisitType"
                                        orderby child.DisplayText
                                        select child;
                        rblVisitType.DataSource = VisitType;
                        rblVisitType.DataTextField = "DisplayText";
                        rblVisitType.DataValueField = "Code";
                        rblVisitType.DataBind();
                       // rblVisitType.Items.Insert(0, "--Select--");
                        rblVisitType.SelectedValue = "2";
                    }


                }

            
            
        

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

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
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadPaymentMode();
    }
    private void LoadPaymentMode()
    {
        List<PaymentType> lstPaymentType = new List<PaymentType>();
        BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);
        long retval = -1;
        try
        {
            ddlPaymentType.Items.Clear();
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
            if (lstPaymentType.Count > 0)
            {
                ddlPaymentType.DataSource = lstPaymentType;
                ddlPaymentType.DataTextField = "PaymentName";
                ddlPaymentType.DataValueField = "PaymentTypeID";
                ddlPaymentType.DataBind();
            }
            ddlPaymentType.Items.Insert(0, new ListItem("-- All --", "0"));
            //ddlPaymentType.SelectedValue = Convert.ToString(lstPaymentType.Find(p => p.IsDefault == "Y").PaymentTypeID);
            ddlPaymentType.SelectedValue = "0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Quick Billing Details.", ex);

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
        int reportTypeID=-1;
        if (rblReportType.SelectedValue!="" )
        {
            reportTypeID = Convert.ToInt32(rblReportType.SelectedValue);
        }
        if (reportTypeID == 1)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[4].Text = "";
                    e.Row.Cells[5].Text = "";
                    //e.Row.Cells[6].Text = "";
                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        else if (reportTypeID == 2)
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
        string WinAlert = Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_Alert == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_Alert;
        string UsrMsgWin = Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_01 == null ? "No Matching Records found for the selected dates" : Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_01;
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);

            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int PaymentTypeID = Convert.ToInt16(ddlPaymentType.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetCreditCardStmtLims(fDate, tDate, OrgID, visitType, out lstDWCR, out pTotalCardAmt, out pTotalServiceCharge, PaymentTypeID);

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
                    gvIPReport.Columns[0].HeaderText = "OP - Credit Card Statement";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP - Credit Card Statement";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP / IP - Credit Card Statement";
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
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
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
    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;


        lblCardTotal.InnerText = String.Format("{0:0.00}", (pTotalCardAmt));
        lblServiceCharge.InnerText = String.Format("{0:0.00}", (pTotalServiceCharge));
    }
    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
    }
    //protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        //export to excel
    //        string prefix = string.Empty;
    //        prefix = "CreditCardStmt_Report_";
    //        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
    //        DataSet dsrpt = (DataSet)ViewState["report"];
    //        if (dsrpt != null)
    //        {
    //            ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
    //        }
    //        // HttpContext.Current.ApplicationInstance.CompleteRequest();
    //    }
    //    catch (System.Threading.ThreadAbortException ex)
    //    {
    //        CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
    //    }
    //}

    #region SingleXLReport
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        string WinAlert = Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_Alert == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_Alert;
        string UsrMsgWin = Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_02 == null ? "First click the get report" : Resources.ReportsLims_ClientDisplay.ReportsLims_CCStmtLims_aspx_02;

        try
        {
            string SingleXl = GetConfigValue("SingleXLReport", OrgID);
            if (SingleXl == "Y")
            {
                btnSubmit_Click(sender, e);
                ExportToExcel(gvIPReport);
            }
            else
            {
                string prefix = string.Empty;
                prefix = "Collection_ReportsDPTOPIP_";
                string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
                DataSet dsrpt = (DataSet)ViewState["report"];
                if (dsrpt != null)
                {
                    ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during exporting to Excel", ex);
        }
    }

    public void ExportToExcel(Control CTRl)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Collection_ReportsDPTOPIP"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        // gvIPCreditMainSummary.RenderControl(htmlWrite);
        gvIPReport.RenderControl(htmlWrite);

        tabGranTotal1.RenderControl(htmlWrite);


        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public void Export(string ID, string ExcelName)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", ExcelName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        GridView ExcelGrid = new GridView();
        ExcelGrid.ID = ID;

        ExcelGrid.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    #endregion
}
