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
public partial class Reports_CCStmt : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    DataSet ds1 = new DataSet();
    decimal pTotalCardAmt = -1;
    decimal pTotalServiceCharge = -1;
    string All = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03 == null ? "All" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03;
    string AlertMesg = Resources.Reports_AppMsg.Reports_CCStmt_aspx_02 == null ? "No Matching Records found for the selected dates " : Resources.Reports_AppMsg.Reports_CCStmt_aspx_02;
    string Header = Resources.Reports_AppMsg.Reports_CancelledBillReport_aspx_02 == null ? "Alert" : Resources.Reports_AppMsg.Reports_CancelledBillReport_aspx_02;
    string all = Resources.Reports_AppMsg.Reports_CCStmt_aspx_03 == null ? "All" : Resources.Reports_AppMsg.Reports_CCStmt_aspx_03;
   
    public Reports_CCStmt()
        : base("Reports_CCStmt_aspx")
    {
    }
    
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
LoadMetaData();
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            LoadOrgan();
            LoadPaymentMode();
            LoadLocation();
            ddlLocation.SelectedValue = ILocationID.ToString();
            LoadUser();
        }
    }


    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ReportCCstmtFormat,VisitType1";
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
                                   where child.Domain == "ReportCCstmtFormat"
                                   orderby child.DisplayText
                                   select child;
                rblReportType.DataSource = ReportFormat;
                rblReportType.DataTextField = "DisplayText";
                rblReportType.DataValueField = "Code";
                rblReportType.DataBind();

                rblReportType.SelectedIndex = 1;

                var VisitType1 = from child in lstmetadataOutput
                                where child.Domain == "VisitType1"
                                orderby child.DisplayText
                                select child;
                rblVisitType.DataSource = VisitType1;
                rblVisitType.DataTextField = "DisplayText";
                rblVisitType.DataValueField = "Code";
                rblVisitType.DataBind();
                // rblVisitType.Items.Insert(0, "--Select--");
               // rblVisitType.SelectedValue = "2";
                rblVisitType.SelectedIndex = 1;
            }


        }





        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    private void LoadUser()
    {
        int LocationId = 0;
        AmountReceived_BL AmountReceivedBL = new AmountReceived_BL(base.ContextInfo);
        List<AmountReceivedDetails> lstAmtRecDetails = new List<AmountReceivedDetails>();
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        if(ddlLocation.Items.Count >0)
            LocationId = Convert.ToInt32(ddlLocation.SelectedValue);
        AmountReceivedBL.GetRecievedUser(OrgID, LocationId, out lstAmtRecDetails);
        if (lstAmtRecDetails.Count > 0)
        {
            chkUser.DataSource = lstAmtRecDetails;
            chkUser.DataTextField = "Receiver_Name";
            chkUser.DataValueField = "ReceivedBy";
            chkUser.DataBind();
        }

    }
    private void LoadLocation()
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location

        returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        //  returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
                //ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items.Insert(0, All);
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                //ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items.Insert(0,All);
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();



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
            ddlPaymentType.Items.Insert(0, new ListItem(all, "0"));
            ddlPaymentType.SelectedValue = Convert.ToString(0);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Quick Billing Details.", ex);

        }
    }

    public DataTable loadSumdata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("VisitDate");
        DataColumn dcol2 = new DataColumn("PatientCount");
        DataColumn dcol3 = new DataColumn("ReceivedAmount");
        DataColumn dcol4 = new DataColumn("ServiceCharge");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["VisitDate"] = item.VisitDate;
            dr["PatientCount"] = item.PatientCount;
            dr["ReceivedAmount"] = item.ReceivedAmount;
            dr["ServiceCharge"] = item.ServiceCharge;
            dt.Rows.Add(dr);
        }
        return dt;
    }
 
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Bill Date");
        DataColumn dcol2 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("Bank/Card Name");
        DataColumn dcol5 = new DataColumn("Age");
        DataColumn dcol6 = new DataColumn("BillNumber");
        DataColumn dcol7 = new DataColumn("VisitType");
        DataColumn dcol8 = new DataColumn("ReceivedAmount");
        DataColumn dcol9 = new DataColumn("ServiceCharge");
        
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["Bill Date"] = item.VisitDate;
            dr["PatientNumber"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Bank/Card Name"] = item.CreditorDebitCard;
            dr["Age"] = item.Age;
            dr["BillNumber"] = item.BillNumber;
            dr["VisitType"] = item.VisitType; 
            dr["ReceivedAmount"] = item.ReceivedAmount;
            dr["ServiceCharge"] = item.ServiceCharge;
            
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
        int PaymentTypeID = Convert.ToInt16(ddlPaymentType.SelectedValue);
        
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
        if (PaymentTypeID == 0) 
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).CreditorDebitCard == " - 0")
                {
                    e.Row.Cells[9].Text = "-";
                }
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            int ReportType = Convert.ToInt32(rblReportType.SelectedValue);
            int locationId = 0;
            string Patientname = txtPatientName.Text;
            if (ddlLocation.Items.Count > 0)
            {
                locationId = Convert.ToInt32(ddlLocation.SelectedValue);
            }
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string Receivedby = "";
            int flag = 0;
            foreach (ListItem item in chkUser.Items)
            {
                if (item.Selected == true)
                {
                    if (flag == 0)
                    {
                        Receivedby = item.Value;
                        flag++;
                    }
                    else
                    {
                        Receivedby = Receivedby + "," + item.Value;
                    }
                }
            }

            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            int PaymentTypeID = Convert.ToInt16(ddlPaymentType.SelectedValue);
            if (PaymentTypeID == 1)
            {
                GvSum.Columns[5].Visible = false;
                gvIPCreditMain.Columns[9].Visible = false;
                gvIPCreditMain.Columns[11].Visible = false;
            }
            else
            {
                GvSum.Columns[5].Visible = true ;
                gvIPCreditMain.Columns[9].Visible = true;
                gvIPCreditMain.Columns[11].Visible = true;
            }


            returnCode = new Report_BL(base.ContextInfo).GetCreditCardStmt(fDate, tDate, OrgID, visitType, locationId, ReportType, Receivedby,Patientname, out lstDWCR, out pTotalCardAmt, out pTotalServiceCharge, PaymentTypeID);

            if (lstDWCR.Count > 0)
            {
                
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                if (lstDWCR.Count > 0)
                {
                    divOPDWCR.Attributes.Add("style", "block");
                    divPrint.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    divPrint.Visible = true;
                    if (ReportType == 0)
                    {
                        gvIPCreditMain.Visible = false;
                        GvSum.Visible = true;
                        GvSum.DataSource = lstDWCR;
                        GvSum.DataBind();
                        CalculationPanelBlock();
                        DataTable dt1 = loadSumdata(lstDWCR);
                        ds1.Tables.Add(dt1);
                        ViewState["Sumreport"] = ds1;
                    }
                    else if (ReportType == 1)
                    {
                        gvIPCreditMain.Visible = true;
                        GvSum.Visible = false;
                        gvIPCreditMain.DataSource = lstDWCR;
                        gvIPCreditMain.DataBind();
                        CalculationPanelBlock();
                        DataTable dt = loaddata(lstDWCR);
                        ds.Tables.Add(dt);
                        ViewState["Detailreport"] = ds;
                    }
                }
                      
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlertMesg + "','" + Header + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
            CollapsiblePanelExtender1.Collapsed = true;
            CollapsiblePanelExtender1.ClientState = "true";
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
        ExportToXL();
      
    }
    protected void lnkBtnXL_Click(object sender, EventArgs e)
    {
        ExportToXL();
    }
    public void ExportToXL()
    {
        try
        {
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=CreditCardStatementReport.xls");

            Response.Charset = "";

            // If you want the option to open the Excel file without saving than

            // comment out the line below

            // Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.ContentType = "application/vnd.xls";

            System.IO.StringWriter stringWrite = new System.IO.StringWriter();

            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            divOPDWCR.RenderControl(htmlWrite);

            Response.Write(stringWrite.ToString());

            Response.End();
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
        //gvIPReport.RenderControl(htmlWrite);

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
