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


public partial class ReportsLims_DueReportLims : BasePage
{
    public ReportsLims_DueReportLims()
        : base("ReportsLims_DueReportLims_aspx")
    {
    }
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalDueAmt = -1;
    List<PaymentType> lstPaymentType = new List<PaymentType>();
    List<DuePaidDetail> lstDuePaidDetail;
    Report_BL objReport_BL;
    DataSet dsDuePaid = new DataSet();
    Dictionary<string, decimal> dicpagetotal = new Dictionary<string, decimal>();
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    string TotDue = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_05 == null ? "Total Due Amount:" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_05;
    string Pagewise = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_06 == null ? "Page wise Total Paid:" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_06;
    string Totpaid = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_07 == null ? "Total Paid Amount:" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_07;
    protected void Page_Load(object sender, EventArgs e)
    {
        string DispAll = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01 == null ? "-----All-----" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01;
        masterBL = new Master_BL(base.ContextInfo);
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            if (ddlTrustedOrg.Items.Count > 0)
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
            }
            loadlocations(RoleID, OrgID);
            drpLocation.SelectedValue = ILocationID.ToString();
            GetClientType();
            GetPaymentType();
            LoadMeatData();

            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            masterBL.GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
            if (lstCurrOrgMapp.Count > 0)
            {
                ddlCurrency.DataSource = lstCurrOrgMapp;
                ddlCurrency.DataTextField = "CurrencyName";
                ddlCurrency.DataValueField = "CurrencyID";
                ddlCurrency.DataBind();
                ddlCurrency.Items.Insert(0, DispAll);
                ddlCurrency.Items[0].Value = "0";


            }
        }
    }
    #region  Added from Jagatheeshkumar

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "PayTypeCCCC";
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
                                 where child.Domain == "PayTypeCCCC"
                                 select child;
                if (childItems.Count() > 0)
                {
                    Rbltypeofpatient.DataSource = childItems;
                    Rbltypeofpatient.DataTextField = "DisplayText";
                    Rbltypeofpatient.DataValueField = "Code";
                    Rbltypeofpatient.DataBind();
                    Rbltypeofpatient.SelectedIndex = 2;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    public void GetPaymentType()
    {
        string DispAll = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01 == null ? "-----All-----" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_01;
      
        long retval = -1;
        BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);
        retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
        if (lstPaymentType.Count > 0)
        {
            DropDownListPM.DataSource = lstPaymentType;
            DropDownListPM.DataTextField = "PaymentName";
            //ddlPaymentType.DataValueField = "PaymentTypeID";
            DropDownListPM.DataBind();
            DropDownListPM.Items.Insert(0, DispAll);
            DropDownListPM.Items[0].Value = "0";
        }

    }
    public void GetClientType()
    {
        string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
       
        long returnCode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ListItem lstItem = new ListItem();
                lstItem.Text = DispSelect;
                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
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
        LoadLocationsCall();
    }
    private void LoadLocationsCall()
    {
        try
        {
            if (ddlTrustedOrg.Items.Count > 0 && ddlTrustedOrg.SelectedItem.Value != "0")
            {
                loadlocations(RoleID, Convert.ToInt32(ddlTrustedOrg.SelectedItem.Value));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadLocationsCall", ex);
        }
    }
    protected void loadlocations(long uroleID, int intOrgID)
    {
        string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
       
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        drpLocation.DataSource = lstLocation;
        drpLocation.DataTextField = "Location";
        drpLocation.DataValueField = "AddressID";
        drpLocation.DataBind();

        if (lstLocation.Count == 1)
        {
            drpLocation.Items.Insert(0, DispSelect);
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            drpLocation.Items.Insert(0, DispSelect);
            drpLocation.Items[0].Value = "0";
            drpLocation.Items[0].Selected = true;
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("Age");
        DataColumn dcol2 = new DataColumn("BillNumber");
        DataColumn dcol7 = new DataColumn("VisitDate");
        DataColumn dcol5 = new DataColumn("VisitType");
        DataColumn dcol6 = new DataColumn("TotalAmount");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["BillNumber"] = item.BillNumber;
            dr["VisitDate"] = item.VisitDate;
            dr["VisitType"] = item.VisitType;
            dr["TotalAmount"] = item.TotalAmount;

            dt.Rows.Add(dr);
        }
        return dt;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

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
                var temp = lstDWCR;
                if (Rbltypeofpatient.SelectedItem.Value == "Creditandcash")
                {
                    temp = temp.FindAll(p => p.IsCreditBill == "Y" || p.IsCreditBill == "N").ToList();

                }


                else if (Rbltypeofpatient.SelectedItem.Value == "Credit")
                {

                    temp = temp.FindAll(p => p.IsCreditBill == "Y").ToList();


                }

                else if (Rbltypeofpatient.SelectedItem.Value == "Cash")
                {

                    temp = temp.FindAll(p => p.IsCreditBill == "N").ToList();

                }

                var childItems = from child in temp
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;


                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt);

                Label lblTPC = (Label)e.Row.FindControl("lblTPC");
                lblTPC.Text = "(" + lstday.Count.ToString() + " Patient )";

                GridView childGrid = (GridView)e.Row.FindControl("grdDueReport");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            // ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void grdDueReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      //  int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        int reportTypeID = 1;// Convert.ToInt32(rblReportType.SelectedValue);
        if (reportTypeID == 1)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[1].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[4].Text = "";

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
                    e.Row.Cells[1].Text = "";
                    e.Row.Cells[3].Text = "";
                    e.Row.Cells[4].Text = "";

                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
                else
                {
                    e.Row.Visible = false;
                }
            }
        }
        if (Rbltypeofpatient.SelectedItem.Value == "Creditandcash")
        {
            e.Row.Cells[7].Visible = true;

        }
        if (Rbltypeofpatient.SelectedItem.Value == "Cash" || Rbltypeofpatient.SelectedItem.Value == "Credit")
        {
            e.Row.Cells[7].Visible = false;

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string AlrtHdrWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt;
           
            string UsrMsg = Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_02 == null ? "No Matching Records found for the selected dates" : Resources.ReportsLims_ClientDisplay.ReportsLims_DueReportLims_aspx_02;
            if (hdnReportType.Value == "DL")
            {
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
               // int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
                DateTime fDate = Convert.ToDateTime(txtFDate.Text);
                DateTime tDate = Convert.ToDateTime(txtTDate.Text);
                int IntOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
                string[] CID;
                string Cid = "0";
                string Clientid = Convert.ToString(hdnSelectedClientID.Value);
                if (Clientid.Contains("|"))
                {
                    CID = Clientid.Split('|');
                    Cid = CID[0];
                }
                long ClientID = Convert.ToInt64(Cid);
                int pLocationID = Convert.ToInt32(drpLocation.SelectedValue);
                decimal totDueAmt = 0;
                string PName = txtName.Text;
                string PNo = txtPNo.Text;

                //if (txtPNo.Text != null || txtPNo.Text !="" )
                //{
                //    PNo = Int32.Parse(txtPNo.Text);
                //}
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                returnCode = new Report_BL(base.ContextInfo).GetDueandDiscountLims(fDate, tDate, IntOrgID,"","",0,0, "DUE", PName, PNo, pLocationID, ClientTypeID, ClientID, out lstDWCR, out pTotalDueAmt);



                //   List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();



                if (lstDWCR.Count > 0)
                {
                    divPrint.Style.Add("display", "block");
                    var temp = lstDWCR;
                    if (lstDWCR.Count > 0)
                    {
                        if (Rbltypeofpatient.SelectedItem.Text == "Credit&Cash")


                      //  if (Rbltypeofpatient.SelectedItem.Value == "Creditandcash")
                        {
                            totDueAmt = lstDWCR.FindAll(p => p.IsCreditBill == "Y" || p.IsCreditBill == "N").Sum(p => p.Due);
                            temp = temp.FindAll(p => (p.IsCreditBill == "Y" || p.IsCreditBill == "N") && p.TotalAmount > 0).ToList();
                        }


                        else if (Rbltypeofpatient.SelectedItem.Text == "Credit")
                        {

                            totDueAmt = lstDWCR.FindAll(p => p.IsCreditBill == "Y").Sum(p => p.Due);
                            temp = temp.FindAll(p => p.IsCreditBill == "Y" && p.TotalAmount > 0).ToList();

                        }

                        else if (Rbltypeofpatient.SelectedItem.Text == "Cash")
                        {
                            totDueAmt = lstDWCR.FindAll(p => p.IsCreditBill == "N").Sum(p => p.Due);
                            temp = temp.FindAll(p => p.IsCreditBill == "N" && p.TotalAmount > 0).ToList();

                        }

                        divOPDWCR.Attributes.Add("style", "block");
                        dvDuepaid.Attributes.Add("Style", "Display:none");
                        //divOPDWCR.Visible = true;
                        // divPrint.Visible = true;
                        CalculationPanelBlock(totDueAmt);

                        if (temp.Count > 0)
                        {
                            grdDueReport.DataSource = from t in temp
                                                      orderby t.PatientNumber ascending
                                                      select t;
                            grdDueReport.DataBind();
                            //DataTable dt = loaddata(temp);
                            //ds.Tables.Add(dt);
                            //ViewState["report"] = ds;
                        }
                        else
                        {
                            divOPDWCR.Attributes.Add("style", "none");
                            grdDueReport.DataSource = null;
                            grdDueReport.DataBind();
                            //divOPDWCR.Visible = false;
                            // divPrint.Visible = false;
                            CalculationPanelNone();
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + UsrMsg + "','" + AlrtHdrWin + "');", true);
                        }
                        //if (visitType == 0)
                        //{
                        //    //gvOPReport.Visible = false;
                        //    //gvIPReport.Visible = true;
                        //    //gvIPReport.Columns[0].HeaderText = "OP - Due Report";
                        //    //gvIPReport.DataSource = lstDayWiseRept;
                        //    //gvIPReport.DataBind();

                        //}
                        //else if (visitType == 1)
                        //{
                        //    gvIPReport.Visible = true;
                        //    //gvOPReport.Visible = false;
                        //    gvIPReport.Columns[0].HeaderText = "IP - Due Report";
                        //    gvIPReport.DataSource = lstDayWiseRept;
                        //    gvIPReport.DataBind();
                        //    CalculationPanelBlock(totDueAmt);
                        //}
                        //else if (visitType == -1)
                        //{
                        //    gvIPReport.Visible = true;
                        //    //gvOPReport.Visible = false;
                        //    gvIPReport.Columns[0].HeaderText = "OP / IP - Due Report";
                        //    gvIPReport.DataSource = lstDayWiseRept;
                        //    gvIPReport.DataBind();
                        //    CalculationPanelBlock(totDueAmt);
                        //}
                    }
                }
                else
                {
                    divPrint.Style.Add("display", "none");
                    grdDueReport.DataSource = null;
                    grdDueReport.DataBind();
                    //divOPDWCR.Attributes.Add("style", "none");
                    //divPrint.Attributes.Add("style", "none");
                    divOPDWCR.Attributes.Add("Style", "Display:none");

                    CalculationPanelBlock(totDueAmt);
                    // divOPDWCR.Visible = false;
                    //divPrint.Visible = false;
                    //CalculationPanelNone();
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + UsrMsg + "','" + AlrtHdrWin + "');", true);
                        
                }
                dvDuepaid.Attributes.Add("Style", "Display:none");
                tdName.Attributes.Add("style", "Display:block");
                PaymentDrp.Attributes.Add("style", "Display:none");
                Payment.Attributes.Add("style", "Display:none");
              
            }
            else
            {
                BindDuePaidReport();
                PaymentDrp.Attributes.Add("style", "Display:table-cell");
                Payment.Attributes.Add("style", "Display:table-cell");
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

    public void CalculationPanelBlock(decimal totDueAmt)
    {
        if (totDueAmt > 0)
        {
            tabGranTotal1.Visible = true;
            lblDueTotal.InnerText = String.Format("{0:0.00}", (totDueAmt));
        }
        else
        {
            tabGranTotal1.Visible = false;
        }
    }

    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
    }


    protected void imgBtnXL_Click(object sender, EventArgs e)
    {

        if (hdnReportType.Value == "DL")
        {
            gvDuepaidReport.DataSource = null;
            //BindDuePaidReport(); 
            gvDuepaidReport.DataBind();
            ExportToExcel(grdDueReport);
            ExportToExcel(Tr1);


        }
        else
        {

            grdDueReport.DataSource = null;
            BindDuePaidReport();
            grdDueReport.DataBind();
            ExportToExcel(gvDuepaidReport);



        }


    }
    public void ExportToExcel(Control CTRl)
    {


        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Due Report"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";

        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        grdDueReport.RenderControl(htmlWrite);

        gvDuepaidReport.RenderControl(htmlWrite);
        Tr1.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    #region duepaid by Syed
    private void BindDuePaidReport()
    {
        try
        {
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            decimal totDueAmt = 0;
            StringBuilder sb = new StringBuilder();
            StringBuilder sbs = new StringBuilder();
            lstDuePaidDetail = new List<DuePaidDetail>();
            objReport_BL = new Report_BL(base.ContextInfo);
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int pLocationID = Convert.ToInt32(drpLocation.SelectedValue);
            //currencyID = 63;
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            //objReport_BL.GetDuePaidDetailsReportLims(Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), OrgID, currencyID, out lstDuePaidDetail);
            objReport_BL.GetDuePaidDetailsReport(Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), OrgID, currencyID, pLocationID,Convert.ToString(DropDownListPM.SelectedItem.Value), out lstDuePaidDetail);


            dvDuepaid.Attributes.Add("Style", "Display:block");
            divOPDWCR.Attributes.Add("Style", "Display:none");
            // divPrint.Attributes.Add("style", "block");

            tdName.Attributes.Add("style", "Display:none");
            CalculationPanelBlock(totDueAmt);

            if (lstDuePaidDetail.Count > 0)
            {
                divPrint.Style.Add("display", "block");
                dicpagetotal.Add("PaidAmount", 0);
                gvDuepaidReport.DataSource = lstDuePaidDetail;
                gvDuepaidReport.DataBind();
                sb.Append("<b>");
                sb.Append(TotDue);
                sb.Append("</b>");
                sb.Append("<b>");
                sb.Append("" + lstDuePaidDetail.FindAll(p => p.BillAmount != 0).Sum(p => p.BillAmount).ToString() + "");
                sb.Append("</b>");
                sbs.Append("<b>");
                sbs.Append("<font color='blue'>" + Pagewise + "</font>");
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.AppendFormat("<font color='blue'>" + dicpagetotal["PaidAmount"].ToString() + "</font> <br/>");
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.Append(Totpaid);
                sbs.Append("</b>");
                sbs.Append("<b>");
                sbs.Append("" + lstDuePaidDetail.FindAll(p => p.BillAmount != 0).Sum(p => p.PaidAmount).ToString() + "");
                sbs.Append("</b>");
                // gvDuepaidReport.FooterRow.Cells[3].Text = sb.ToString();
                gvDuepaidReport.FooterRow.Cells[9].HorizontalAlign = HorizontalAlign.Right;
                gvDuepaidReport.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Left;
                gvDuepaidReport.FooterRow.Cells[9].Font.Bold = true;
                gvDuepaidReport.FooterRow.Cells[8].Font.Bold = true;
                if (showPaidCurrency1 == 1 || showPaidCurrency != 1)
                {
                    if (pPaidCurrencyTotal == 0)
                    {
                        gvDuepaidReport.FooterRow.Cells[9].Text = "";
                        gvDuepaidReport.FooterRow.Cells[8].Text = pPaidCurrencyCode;
                    }
                    else
                    {
                        gvDuepaidReport.FooterRow.Cells[9].Text = pPaidCurrencyTotal.ToString();
                        gvDuepaidReport.FooterRow.Cells[8].Text = pPaidCurrencyCode;
                    }
                }
                else
                {
                    gvDuepaidReport.FooterRow.Cells[9].Text = "Multiple Currencies";
                    gvDuepaidReport.FooterRow.Cells[8].Text = "--";
                }

                gvDuepaidReport.FooterRow.Cells[6].Text = sbs.ToString();

                //DataTable dt = loaddataDuePaid(lstDuePaidDetail);
                //dsDuePaid.Tables.Add(dt);
                //ViewState["report"] = dsDuePaid;
            }
            else
            {
                divPrint.Style.Add("display", "none");
                gvDuepaidReport.DataSource = null;
                gvDuepaidReport.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BindDuePaidReport", ex);
        }
    }


    protected void gvDuepaidReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            TableCell cell;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    cell = e.Row.Cells[i];
                    if (gvDuepaidReport.HeaderRow.Cells[i].Text == "Paid Amount")
                    {
                        Label lbl = (Label)e.Row.FindControl("lblPaidAmount");
                        dicpagetotal["PaidAmount"] += Decimal.Parse(lbl.Text);
                        cell.HorizontalAlign = HorizontalAlign.Right;
                    }
                }
                pPaidCurrencyTotal += Convert.ToDecimal(e.Row.Cells[9].Text);
                if (e.Row.Cells[8].Text != "" && e.Row.Cells[8].Text != "&nbsp;")
                {
                    pPaidCurrencyCode = e.Row.Cells[8].Text;
                }
                if (e.Row.Cells[8].Text != "" && e.Row.Cells[8].Text != "&nbsp;" && e.Row.Cells[8].Text != BaseCurrencyCode)
                {
                    showPaidCurrency = 1;
                }
                if (e.Row.Cells[8].Text != "" && e.Row.Cells[8].Text != "&nbsp;")
                {
                    showPaidCurrency1 += 1;
                }

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DueReport, gvDuepaidReport_RowDataBound", ex);
        }
    }
    protected void gvDuepaidReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvDuepaidReport.PageIndex = e.NewPageIndex;
                btnSubmit_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvDuepaidReport_PageIndexChanging", ex);
        }
    }


    //public DataTable loaddataDuePaid(List<DuePaidDetail> lstDWCR)
    //{
    //    DataTable dt = new DataTable();
    //    DataColumn dcol1 = new DataColumn("DueBillNo");
    //    DataColumn dcol3 = new DataColumn("PatientName");
    //    DataColumn dcol4 = new DataColumn("Age");
    //    DataColumn dcol2 = new DataColumn("BillAmount");
    //    DataColumn dcol5 = new DataColumn("PaidAmount");
    //    DataColumn dcol6 = new DataColumn("PaidBillNo");
    //    DataColumn dcol7 = new DataColumn("PaidDate");
    //    DataColumn dcol8 = new DataColumn("DueCollectedBy");
    //    DataColumn dcol9 = new DataColumn("ReceivedBy");
    //    DataColumn dcol10 = new DataColumn("Address");
    //    DataColumn dcol11 = new DataColumn("ContactNo");
    //    DataColumn dcol12 = new DataColumn("DueBillDate");
    //    DataColumn dcol13 = new DataColumn("BilledBy");

    //    dt.Columns.Add(dcol1);
    //    dt.Columns.Add(dcol2);
    //    dt.Columns.Add(dcol3);
    //    dt.Columns.Add(dcol4);
    //    dt.Columns.Add(dcol5);
    //    dt.Columns.Add(dcol6);
    //    dt.Columns.Add(dcol7);
    //    dt.Columns.Add(dcol8);

    //    dt.Columns.Add(dcol10);
    //    dt.Columns.Add(dcol11);
    //    dt.Columns.Add(dcol12);
    //    dt.Columns.Add(dcol13);
    //    dt.Columns.Add(dcol9);


    //    foreach (DuePaidDetail item in lstDWCR)
    //    {
    //        DataRow dr = dt.NewRow();
    //        dr["DueBillNo"] = item.DueBillNo;
    //        dr["PatientName"] = item.PatientName;
    //        dr["Age"] = item.Age;
    //        dr["BillAmount"] = item.BillAmount;
    //        dr["PaidAmount"] = item.PaidAmount;
    //        dr["PaidBillNo"] = item.PaidBillNo;
    //        dr["PaidDate"] = item.PaidDate;
    //        dr["DueCollectedBy"] = item.DueCollectedBy;

    //        dr["Address"] = item.Address;
    //        dr["ContactNo"] = item.ContactNo;
    //        dr["DueBillDate"] = item.DueBillDate;
    //        dr["BilledBy"] = item.BilledBy;
    //        dr["ReceivedBy"] = item.ReceivedBy;
    //        dt.Rows.Add(dr);
    //    }
    //    return dt;
    //}

    #endregion



}
