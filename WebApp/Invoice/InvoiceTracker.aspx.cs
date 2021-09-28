using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using Attune.Utilitie.Helper;
using System.Security.Cryptography;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.DAL;
using System.Data;
public partial class Invoice_InvoiceTracker : BasePage
{
    string strSelect = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_006 == null ? "--Select--" : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_006;
    long InvID = 0;
    ActionManager objActionManager;
    public Invoice_InvoiceTracker()
        : base("Invoice_InvoiceTracker_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    List<Patient> lstPatient = new List<Patient>();
    List<Invoice> lstInvoice = new List<Invoice>();
    List<Invoice> lstChkListInvoice = new List<Invoice>();
    BillingEngine bill = new BillingEngine();
    int currentPageNo = 1;
    int PageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
    int ZonalID = -1;
    int HubID = -1;
    ArrayList al = new ArrayList();
    DateTime dtFrom;
    DateTime dtTo;

    static List<ActionMaster> lstActionMaster = new List<ActionMaster>();

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMeatData();
        dtFrom = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        dtTo = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        objActionManager = new ActionManager(base.ContextInfo);
        bill = new BillingEngine(base.ContextInfo);
        hdnChkInvoice.Value = "0";
        string InvoiceType = string.Empty;
        if (chkInvDraft.Checked == true)
        {
            InvoiceType = "DRAFT";
        }
        else
        {
            InvoiceType = "INVOICE";
        }
        hdnInvoiceType.Value = InvoiceType;
        string InvoiceReceiptPage;
        InvoiceReceiptPage = GetConfigValue("OldInvoiceReceipt", OrgID);
        if (!IsPostBack)
        {
            GetGroupValues();
            if (InvoiceReceiptPage == "Y")
            {
                btnPostBackUrl.PostBackUrl = "~/Invoice/InvoiceCapturewithoutKnockOff.aspx";
            }
            else
            {
                btnPostBackUrl.PostBackUrl = "~/Invoice/InvoiceCapture.aspx";
            }
            BindDropDownValues();
            LoadLocationPrinter();
            //btnSearch_Click(sender, e);
            //Added BalaMahesh For MetroPolis
            AutoCompleteExtenderOnHub.ContextKey = "Hub";
            // AutoCompleteExtenderOnzone.ContextKey = "zone";
            string configMultiplePayment;
            configMultiplePayment = GetConfigValue("InvoiceMultiplePayment", OrgID);//Round off is done by config value(orgbased)
            //if (configMultiplePayment == "Y")
            //    hdnInvoiceMultiplePayment.Value = "1";
            //else
            //    hdnInvoiceMultiplePayment.Value = "0";

            hdnInvoiceMultiplePayment.Value = (configMultiplePayment == "Y") ? "1" : "0";

        }
        if (IsPostBack)
        {
            if (InvoiceReceiptPage == "Y")
            {
                btnPostBackUrl.PostBackUrl = "~/Invoice/InvoiceCapturewithoutKnockOff.aspx";
            }
            if (hdnShowReport.Value == "true")
            {
                rptMdlPopup.Show();
            }
            else
            {
                rptMdlPopup.Hide();
            }
        }
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "InvoiceCycle1";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
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
            if (lstmetadataOutput.Count > 0)
            {
                var InvoiceCycle1 = from child in lstmetadataOutput
                                   where child.Domain == "InvoiceCycle1"
                                        select child;
                if (InvoiceCycle1.Count() > 0)
                {
                    dropInvoiceCycle.DataSource = InvoiceCycle1;
                    dropInvoiceCycle.DataTextField = "DisplayText";
                    dropInvoiceCycle.DataValueField = "Code";
                    dropInvoiceCycle.DataBind();
                    dropInvoiceCycle.Items.Insert(0, strSelect);
                   

                }
                               
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Type   ", ex);

        }
    }

    //public void loadClient()
    //{
    //    long Returncode = -1;
    //    List<InvClientType> client = new List<InvClientType>();
    //    Returncode = new Patient_BL(base.ContextInfo).GetInvClientType(out client);
    //    if (client.Count > 0)
    //    {
    //        drpClientType.DataSource = client;
    //        drpClientType.DataTextField = "ClientTypeName";
    //        drpClientType.DataValueField = "ClientTypeID";
    //        drpClientType.DataBind();
    //        drpClientType.Items.Insert(0, new ListItem("--Select--", "0"));
    //    }
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        grdInvoiceBill.DataSource = null;
        LoadGrid(e, currentPageNo, PageSize);
    }

    protected void grdInvoiceBill_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            long returncode = 0;
            int InvoiceID = 0, ClientID = 0;
            List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
            List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
            //Determine the RowIndex of the Row whose Button was clicked.
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = grdInvoiceBill.Rows[rowIndex];

            //Fetch values.
            string lblClientID = (row.FindControl("lblClientID") as Label).Text;
            string lblInvoiceID = (row.FindControl("lblInvoiceID") as Label).Text;
            if (!string.IsNullOrEmpty(lblInvoiceID))
            {
                InvoiceID = Convert.ToInt16(lblInvoiceID);
            }
            if (!string.IsNullOrEmpty(lblClientID))
            {
                ClientID = Convert.ToInt16(lblClientID);
            }
            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(ClientID, InvoiceID, OrgID, "", out lstFiles);

            if (lstFiles.Count > 0)
            {
                lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "Invoice_Upload");
            }

            if (lstTRF.Count > 0)
            {
                //if (lstTRF.Count == 1)
                //{
                    string PictureName = string.Empty;
                    PictureName = lstTRF[0].FileName;
                    string fileName = Path.GetFileNameWithoutExtension(PictureName);
                    string fileExtension = Path.GetExtension(PictureName);

                    if (!string.IsNullOrEmpty(PictureName))
                    {
                        if (PictureName != "" && fileExtension != ".pdf")
                        {
                            if (!String.IsNullOrEmpty(PictureName))
                            {
                                modalPopUp.Show();
                                ifInvoiveImage.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                                //imgPatient.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID + "&IsFromDefaultPath=" + IsFromDefaultPath;
                            }
                        }
                    }
                //}
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void grdInvoiceBill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Invoice Iv = (Invoice)e.Row.DataItem;
            string strScript = "javascript:onChaangeChk('" + ((CheckBox)e.Row.Cells[0].FindControl("chkInvoiceItem")).ClientID + "')";
            ((CheckBox)e.Row.Cells[0].FindControl("chkInvoiceItem")).Attributes.Add("onclick", strScript);
            //if(hdnInvoiceMultiplePayment.Value=="1")
            e.Row.Cells[15].Visible = (hdnInvoiceMultiplePayment.Value == "1") ? true : false;

        }
        else if (e.Row.RowType == DataControlRowType.Header)
        {
          //  e.Row.Style.Add("display", "block");
        }

    }

    protected void BindDropDownValues()
    {
        try
        {
            long returnCode = -1;
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.Invoice, out lstActionMaster);
            ddlOption.Items.Clear();
            #region Load Action Menu to Drop Down List
            //ddlOption.DataSource = lstActionMaster.ToList();
            //ddlOption.DataTextField = "ActionName";
            //ddlOption.DataValueField = "ActionCode";
            //ddlOption.DataBind();
            ////ddlOption.Items.Insert(0, "--Select--");
            //ddlOption.Items.Insert(0, strSelect);
            //ddlOption.Items[0].Value = "0";

            if (lstActionMaster.Count > 0)
            {
                ddlOption.DataSource = lstActionMaster;
                ddlOption.DataTextField = "ActionName";
                ddlOption.DataValueField = "ActionCode";
                ddlOption.DataBind();
            }
            ddlOption.Items.Insert(0, new ListItem("-- Select --", "0"));
            //ddlOption.SelectedIndex = 1;

            #endregion
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionList", ex);

        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }

    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            long returnCode = -1;
            BillingEngine BE = new BillingEngine(base.ContextInfo);
            List<Invoice> lstInvoice = new List<Invoice>();
            string InvoiceNo = txtInvoiceNo.Text;
            int ClientID = 0;

            int businessTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());

            if (Convert.ToInt32(hdnClientID.Value) > 0)
            {
                ClientID = Convert.ToInt32(hdnClientID.Value);
            }

            if (txtFrom.Text != "")
            {
                dtFrom = Convert.ToDateTime(txtFrom.Text);
            }
            else
            {
                dtFrom = Convert.ToDateTime("1/1/1753 12:00:00");
            }

            if (txtTo.Text != "")
            {
                dtTo = Convert.ToDateTime(txtTo.Text);
            }
            else
            {
                dtTo = Convert.ToDateTime("1/1/1753 12:00:00");

            }
            Int32.TryParse(hdntxtzoneID.Value, out ZonalID);
            Int32.TryParse(hdnHubID.Value, out HubID);

            ContextInfo.StateID = ZonalID;
            ContextInfo.ThemeID = HubID;
            ContextInfo.AdditionalInfo = dropInvoiceCycle.SelectedValue;
            BE.SearchInvoice(InvoiceNo, OrgID, ILocationID, Convert.ToDateTime(dtFrom), Convert.ToDateTime(dtTo), out lstInvoice, PageSize, currentPageNo, out totalRows, businessTypeID, ClientID, hdnInvoiceType.Value);
            if (lstInvoice.Count > 0)
            {
                tblgrd.Style.Add("display", "table");
                tblprintaction.Style.Add("display", "table");
                GrdHeader.Style.Add("display", "table");
                GrdFooter.Style.Add("display", "table-row");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
            if (returnCode == -1 && lstInvoice.Count > 0)
            {
                grdInvoiceBill.Visible = true;
                lblResult.Visible = false;
                lblResult.Text = "";
                grdInvoiceBill.DataSource = lstInvoice;
                grdInvoiceBill.DataBind();
                trddl.Style.Add("display", "table-row");
            }
            else
            {
                grdInvoiceBill.Visible = false;
                lblResult.Visible = true;
                trddl.Style.Add("display", "none");
                lblResult.Text = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_002 == null ? "No matching records found" : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_002;//"No matching records found";
            }


            Int32.TryParse(hdntxtzoneID.Value, out ZonalID);
            Int32.TryParse(hdnHubID.Value, out HubID);

            ContextInfo.StateID = ZonalID;
            ContextInfo.ThemeID = HubID;
            ContextInfo.AdditionalInfo = dropInvoiceCycle.SelectedValue;
            BE.SearchInvoice(InvoiceNo, OrgID, ILocationID, Convert.ToDateTime(dtFrom), Convert.ToDateTime(dtTo), out lstChkListInvoice, -1, -1, out totalRows, businessTypeID, ClientID, hdnInvoiceType.Value);

            outerDataList.DataSource = lstChkListInvoice;
            outerDataList.DataBind();
            GridView1.DataSource = lstChkListInvoice;
            GridView1.DataBind();
            lblprintingperiod.Text = txtFrom.Text.ToString() + " TO " + txtTo.Text.ToString();
            lblPrintedAt.Text = "Printed At " + OrgDateTimeZone;


            //act
            List<Invoice> lstinvoiceAct = new List<Invoice>();

            lstinvoiceAct = (from child in lstChkListInvoice
                             select new Invoice { ZoneName = child.ZoneName }).Distinct().ToList();

            DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("ZoneName");
            DataRow dr;
            //add columns
            dt.Columns.Add(dbCol1);
            for (int j = 0; j < lstinvoiceAct.Count; j++)
            {
                dr = dt.NewRow();
                dr["ZoneName"] = lstinvoiceAct[j].ZoneName.ToString();
                dt.Rows.Add(dr);
            }
            DataView dv = new DataView(dt);
            DataTable dt1 = dt.DefaultView.ToTable(true, "ZoneName");
            ZoneActList.DataSource = dt1;
            ZoneActList.DataBind();
            //
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get InvoiceDetails", ex);
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }

    protected void grdInvoiceBill_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdInvoiceBill.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {

        if (chkInvDraft.Checked == false)
        {
            hdnCurrent.Value = txtpageNo.Text;
            LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        }

    }
    protected void btnPostBackUrl_Click(object sender, EventArgs e)
    {
        hdnResult.Value = GetValue();
    }

    public void LoadReportDetails(long Clientid, long InvoiceId, int OrgID)
    {
        long returnCode = -1;
        try
        {


            BillingEngine BE = new BillingEngine(base.ContextInfo);

            string InvoiceNo = txtInvoiceNo.Text;



            returnCode = BE.getClientInvoiceDetails(Clientid, InvoiceId, OrgID, out lstInvoice);

            if (lstInvoice.Count > 0)
            {
                var invoiceDate = (from ex in lstInvoice
                                   group ex by new { ex.InvoiceDate, ex.ClientID, ex.Comments, ex.InvoiceID } into g
                                   select new Invoice
                                   {
                                       InvoiceDate = g.Key.InvoiceDate,
                                       ClientID = g.Key.ClientID,
                                       Comments = g.Key.Comments,
                                       InvoiceID = g.Key.InvoiceID,
                                   }).Distinct().ToList();
                grdPatientView.DataSource = invoiceDate;
                grdPatientView.DataBind();

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadReportDetails", ex);
        }
    }
    protected void grdPatientView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Invoice PPD = (Invoice)e.Row.DataItem;
                var invoiceDate = (from ex in lstInvoice
                                   group ex by new { ex.InvoiceDate, ex.ClientID, ex.Comments, ex.InvoiceID } into g
                                   select new Invoice
                                   {
                                       InvoiceDate = g.Key.InvoiceDate,
                                       ClientID = g.Key.ClientID,
                                       Comments = g.Key.Comments,
                                       InvoiceID = g.Key.InvoiceID,
                                   }).Distinct().ToList();

                GridView childGrid = (GridView)e.Row.FindControl("grdOrderedinv");
                childGrid.DataSource = lstInvoice;
                childGrid.DataBind();


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Wile binding GetPreviousPhysioVisit ", ex);
        }
    }
    protected void btnSendsms_Click(object sender, EventArgs e)
    {
        string AlertMessg = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_003 == null ? "Invoice Email Queue Sent" : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_003;//"Invoice Email Queue Sent";
        string AlrtWinHdr = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_002 == null ? "Alert" : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_002;
        string AlrtMessg1 = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_004 == null ? "Invoice Print Queue Sent" : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_004;
                     
        //if (ddlOption.SelectedItem.Text == "Invoice Capture")
        //{
        //    hdnResult.Value = GetValue();
        //}
        hdnResult.Value = GetValue();
        #region Get Redirect URL
        QueryMaster objQueryMaster = new QueryMaster();

        string RedirectURL = string.Empty;
        string QueryString = string.Empty;
        string Invoices = string.Empty;
        List<Invoice> lstInvID = new List<Invoice>();
        if (lstActionMaster.Exists(p => p.ActionCode == ddlOption.SelectedValue))
        {
            QueryString = lstActionMaster.Find(p => p.ActionCode == ddlOption.SelectedValue).QueryString;
        }
        Invoice Iv = new Invoice();
        Invoices = hdnResult.Value;
        foreach (string O in Invoices.Split('^'))
        {
            if (O != string.Empty)
            {

                Iv.InvoiceID = Convert.ToInt64(O.Split('~')[0]);
                Iv.InvoiceNumber = O.Split('~')[1];
                Iv.ClientID = Convert.ToInt64(O.Split('~')[2]);
                Iv.Comments = Convert.ToString(O.Split('~')[3]);
                //Mahesh
                Iv.ReportTemplateID = Convert.ToInt32(O.Split('~')[4]);
                lstInvID.Add(Iv);
            }
        }
        if (ddlOption.SelectedValue.ToString() == "Invoice_Receipts")
        {
            rptMdlPopup.Hide();
            btnPostBackUrl.PostBackUrl = "~/Invoice/InvoiceCapture.aspx";
        }
        else if (ddlOption.SelectedValue.ToString() == "Show_PDF")
        {
            rptMdlPopup.Hide();
            //long pVisitID = Convert.ToInt64(hdnVID.Value);

            //uctPatientDetail1.LoadPatientDetails(pVisitID, OrgID, "");
            string invStatus = InvStatus.Pending.ToLower() + "," + InvStatus.Completed.ToLower() + "," + InvStatus.Validate.ToLower() + "," + InvStatus.Approved.ToLower();
            //hdnPDFType.Value = "ShowPdf";

            LoadReportDetails(Convert.ToInt64(Iv.ClientID), Iv.InvoiceID, OrgID);
            Report_BL objReportBL = new Report_BL(base.ContextInfo);
            List<ReportSnapshot> ReportPath = new List<ReportSnapshot>();

            objReportBL.GetPath(OrgID, Iv.InvoiceID, "invoice", out ReportPath);

            string filePath = string.Empty;
            if (ReportPath.Count() > 0)
            {
                filePath = ReportPath[0].ReportPath;
            }
            mpReportPreview.Show();
            frameReportPreview.Attributes["src"] = "../Patient/ReportPdf.aspx?pdf=" + filePath + "&type=" + hdnPDFType.Value.ToString();
            //&type=showreport&invstatus=
            hdnPDFType.Value = "";
        }
        else if (ddlOption.SelectedValue.ToString() == "Invoice_Tracker_View Invoice")
        {
            frameReportPreview.Attributes.Clear();
            long returnCode = -1;
            string reportPath = string.Empty;
            string Type = string.Empty;
            Type = "Invoice";
            long InvoiceID = 0;
            InvoiceID = lstInvID[0].InvoiceID;
            long ClientID = 0;
            ClientID = lstInvID[0].ClientID;
            //Mahesh
            long ReportTemplateID = 0;
            ReportTemplateID = lstInvID[0].ReportTemplateID;


            List<BillingDetails> lstReportPath = new List<BillingDetails>();
            //Mahesh
            returnCode = bill.GetInvoiceReportPath(OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
            SetGroupValues();
            if (lstReportPath.Count > 0)
            {
                drpreportformat.SelectedValue = Convert.ToString(lstInvID[0].ReportTemplateID);
            }
            //drpreportformat.DataTextField = "ReportTemplateName";
            //drpreportformat.DataValueField = "TemplateID";
            //drpreportformat.DataBind();
            if (lstReportPath.Count > 0)
            {
                reportPath = lstReportPath[0].RefPhyName.ToString();
            }
            InvID = InvoiceID;
            long returnCode1 = -1;
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay();
            returnCode1 = gateWay.GetCommunicationDetails(CommunicationType.Invoice, InvID, LocationName, out lstCommunicationDetails);

            if (lstCommunicationDetails.Count > 0)
            {
                txtClientEmail.Text = Convert.ToString(lstCommunicationDetails[0].To);
                if (txtClientEmail.Text.Trim().ToString() != "")
                {
                    txtClientEmail.Enabled = false;
                    btnSendEmail.Enabled = true;
                    lblmsg.Text = "";
                }
                else
                {
                    txtClientEmail.Enabled = true;
                    btnSendEmail.Enabled = true;
                    lblmsg.Text = "";
                }
                hdnInvID.Value = String.Empty;
            }
            else
            {
                txtClientEmail.Text = "";
                hdnInvID.Value = String.Empty;
            }
            ShowReport(reportPath, InvoiceID, OrgID, ILocationID, LID, hdnInvoiceType.Value);

            rptMdlPopup.Show();
        }
        else if (ddlOption.SelectedValue.ToString() == "Collect_InvoicePayment_Collect")
        { 
            frameReportPreview.Attributes.Clear();
            long returnCode = -1;
            string reportPath = string.Empty;
            string Type = string.Empty;
            Type = "Invoice";
            long InvoiceID = 0;
            InvoiceID = lstInvID[0].InvoiceID;
            long ClientID = 0;
            ClientID = lstInvID[0].ClientID;
            //Mahesh
            long ReportTemplateID = 0;
            ReportTemplateID = lstInvID[0].ReportTemplateID;


            List<BillingDetails> lstReportPath = new List<BillingDetails>();
            //Mahesh
            returnCode = bill.GetInvoiceReportPath(OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
            SetGroupValues();
            if (lstReportPath.Count > 0)
            {
                drpreportformat.SelectedValue = Convert.ToString(lstInvID[0].ReportTemplateID);
            }
            //drpreportformat.DataTextField = "ReportTemplateName";
            //drpreportformat.DataValueField = "TemplateID";
            //drpreportformat.DataBind();
            if (lstReportPath.Count > 0)
            {
                reportPath = lstReportPath[0].RefPhyName.ToString();
            }
            InvID = InvoiceID;
            long returnCode1 = -1;
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay();
            returnCode1 = gateWay.GetCommunicationDetails(CommunicationType.Invoice, InvID, LocationName, out lstCommunicationDetails);

            if (lstCommunicationDetails.Count > 0)
            {
                txtClientEmail.Text = Convert.ToString(lstCommunicationDetails[0].To);
                if (txtClientEmail.Text.Trim().ToString() != "")
                {
                    txtClientEmail.Enabled = false;
                    btnSendEmail.Enabled = true;
                    lblmsg.Text = "";
                }
                else
                {
                    txtClientEmail.Enabled = true;
                    btnSendEmail.Enabled = true;
                    lblmsg.Text = "";
                }
                hdnInvID.Value = String.Empty;
            }
            else
            {
                txtClientEmail.Text = "";
                hdnInvID.Value = String.Empty;
            }
            ShowReport(reportPath, InvoiceID, OrgID, ILocationID, LID, hdnInvoiceType.Value); 
        }
        else if (ddlOption.SelectedValue == "SMS")
        {
            rptMdlPopup.Hide();
            long retrunCode = -1;
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();

            foreach (string O in hdnResult.Value.Split('^'))
            {
                if (O != string.Empty)
                {
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(O.Split('~')[2]);//ClientID
                    PC.PatientID = Convert.ToInt64(O.Split('~')[0]);//InvoiceID  
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.ButtonName = ((Button)sender).ID;
                    PC.ButtonValue = ((Button)sender).Text;
                    lstpagecontextkeys.Add(PC);
                }
            }

            ActionManager am = new ActionManager(base.ContextInfo);
            List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
            retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
            if (NotifyAudit.Count > 0)
            {
                Patient_BL Patsms = new Patient_BL(base.ContextInfo);
                Patsms.insertNotificationAudit(OrgID, ILocationID, LID, NotifyAudit);

            }
            rptMdlPopup.Hide();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tmultiplesendsms", "javascript:Cleardata();", true);
        }
        else if (ddlOption.SelectedValue.ToLower() == "send_email")
        {
            rptMdlPopup.Hide();
            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("ActionType");
            DataColumn dbCol2 = new DataColumn("Value");
            DataColumn dbCol3 = new DataColumn("AdditionalContext");
            DataColumn dbCol4 = new DataColumn("Category");
            DataColumn dbCol5 = new DataColumn("version");
            DataColumn dbCol6 = new DataColumn("Status");
            DataColumn dbCol7 = new DataColumn("OrgID");
            DataColumn dbCol8 = new DataColumn("OrgAddressID");
            DataColumn dbCol9 = new DataColumn("CreatedAt");
            DataColumn dbCol10 = new DataColumn("CreatedBy");
            DataColumn dbCol11 = new DataColumn("Template");
            DataColumn dbCol12 = new DataColumn("ContextType");
            DataColumn dbCol13 = new DataColumn("IsAttachment");
            DataColumn dbCol14 = new DataColumn("Subject");
            DataColumn dbCol15 = new DataColumn("AttachmentName");
            DataColumn dbCol16 = new DataColumn("IsClientBlinding");
            //add columns
            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            dt.Columns.Add(dbCol7);
            dt.Columns.Add(dbCol8);
            dt.Columns.Add(dbCol9);
            dt.Columns.Add(dbCol10);
            dt.Columns.Add(dbCol11);
            dt.Columns.Add(dbCol12);
            dt.Columns.Add(dbCol13);
            dt.Columns.Add(dbCol14);
            dt.Columns.Add(dbCol15);
            dt.Columns.Add(dbCol16);

            if (chkAllItem.Checked == true)
            {
                if (txtFrom.Text != "")
                {
                    dtFrom = Convert.ToDateTime(txtFrom.Text);
                }
                else
                {
                    dtFrom = Convert.ToDateTime("1/1/1753 12:00:00");
                }

                if (txtTo.Text != "")
                {
                    dtTo = Convert.ToDateTime(txtTo.Text);
                }
                else
                {
                    dtTo = Convert.ToDateTime("1/1/1753 12:00:00");
                }
                BillingEngine BE = new BillingEngine(base.ContextInfo);



                Int32.TryParse(hdntxtzoneID.Value, out ZonalID);
                Int32.TryParse(hdnHubID.Value, out HubID);

                ContextInfo.StateID = ZonalID;
                ContextInfo.ThemeID = HubID;
                ContextInfo.AdditionalInfo = dropInvoiceCycle.SelectedValue;

                string InvoiceNo = txtInvoiceNo.Text;
                int ClientID = 0;
                if (Convert.ToInt32(hdnClientID.Value) > 0)
                {
                    ClientID = Convert.ToInt32(hdnClientID.Value);
                }
                int businessTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());
                BE.SearchInvoice(InvoiceNo, OrgID, ILocationID, Convert.ToDateTime(dtFrom), Convert.ToDateTime(dtTo),
                    out lstInvoice, -1, -1, out totalRows, businessTypeID, ClientID, hdnInvoiceType.Value);
                for (int i = 0; i < lstInvoice.Count(); i++)
                {

                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = lstInvoice[i].InvoiceID;
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PageID = Convert.ToInt64(PageID);
                    PC.ButtonName = "INVOICEEMAILBTN";
                    PC.ButtonValue = "INVOICEEMAILBTN";
                    PC.PatientVisitID = lstInvoice[i].ClientID;
                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");

                    //string Additionalcontext = "<?xml version=" + "1.0" + " encoding=" + "utf-16" + "?><ContextInfo><InvoiceID>" + lstInvoice[i].InvoiceID.ToString() + "</InvoiceID><ClientID>" + lstInvoice[i].ClientID.ToString() + "</ClientID><FromDate>0</FromDate><ToDate>0</ToDate></ContextInfo>";

                    //DataRow dr;
                    //dr = dt.NewRow();
                    //dr["ActionType"] = "INVOICEPRINT";
                    //dr["Value"] = lstInvoice[i].InvoiceID.ToString();
                    //dr["AdditionalContext"] = Additionalcontext;
                    //dr["Category"] = "Invoice";
                    //dr["Status"] = "";
                    //dr["OrgID"] = OrgID;
                    //dr["OrgAddressID"] = ddlLocationPrinter.SelectedValue;
                    //dr["CreatedAt"] = DateTime.MinValue;
                    //dr["CreatedBy"] = RoleID;
                    //dr["Template"] = "";
                    //dr["ContextType"] = "INV";
                    //dr["IsAttachment"] = "Y";
                    //dr["Subject"] = "";
                    //dr["AttachmentName"] = "";
                    //dt.Rows.Add(dr);
                }
                //long res = -1;
                //Report_DAL objReportdal = new Report_DAL(base.ContextInfo);
                //res = objReportdal.SaveActionDetails(dt);
                //dt = null;
                //tblgrd.Style.Add("display", "none");
                //tblprintaction.Style.Add("display", "none");
                //GrdHeader.Style.Add("display", "none");
                //string AlertMessg = "Invoice Email Queue Sent";
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);

                GrdHeader.Style.Add("display", "none");
                tblgrd.Style.Add("display", "none");
                tblprintaction.Style.Add("display", "none");
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Dispatchstatus", "javascript:ValidationWindow('" + AlertMessg + "','" + AlrtWinHdr + "');", true);

            }
            else
            {
                rptMdlPopup.Hide();
                long InvoiceID = 0;
                long ClientID = 0;
                foreach (GridViewRow gvRow in grdInvoiceBill.Rows)
                {
                    if (gvRow.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkSel = (CheckBox)gvRow.FindControl("chkInvoiceItem");
                        if (chkSel.Checked == true)
                        {
                            Label lblClientID = (Label)gvRow.FindControl("lblClientID");
                            Label lblInvoiceID = (Label)gvRow.FindControl("lblInvoiceID");
                            if (lblInvoiceID != null)
                            {
                                InvoiceID = Convert.ToInt64(lblInvoiceID.Text);
                            }
                            if (lblClientID != null)
                            {
                                ClientID = Convert.ToInt64(lblClientID.Text);
                            }

                            ActionManager AM = new ActionManager(base.ContextInfo);
                            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                            PageContextkey PC = new PageContextkey();
                            PC.ID = Convert.ToInt64(ILocationID);
                            PC.PatientID = InvoiceID; //patientId having invoiceID value
                            PC.RoleID = Convert.ToInt64(RoleID);
                            PC.OrgID = OrgID;
                            PC.PatientVisitID = ClientID; //patientId having cientID value
                            PC.FinalBillID = 0;
                            PC.BillNumber = "0";
                            PC.PageID = Convert.ToInt64(PageID);
                            PC.ButtonName = "INVOICEEMAILBTN";
                            PC.ButtonValue = "INVOICEEMAILBTN";
                            lstpagecontextkeys.Add(PC);
                            long res = -1;
                            res = AM.PerformingNextStepNotification(PC, "", "");
                        }
                    }
                }
                //long res = -1;
                //Report_DAL objReportdal = new Report_DAL(base.ContextInfo);
                //res = objReportdal.SaveActionDetails(dt);
                //dt = null;
                GrdHeader.Style.Add("display", "none");
                tblgrd.Style.Add("display", "none");
                tblprintaction.Style.Add("display", "none");
                //string AlertMessg = "Invoice Email Queue Sent";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Dispatchstatus", "javascript:ValidationWindow('" + AlertMessg + "','" + AlrtWinHdr + "');", true);

                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
            }
        }
        //
        else if (ddlOption.SelectedValue == "Show_Print")
        {
            rptMdlPopup.Hide();
            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("ActionType");
            DataColumn dbCol2 = new DataColumn("Value");
            DataColumn dbCol3 = new DataColumn("AdditionalContext");
            DataColumn dbCol4 = new DataColumn("Category");
            DataColumn dbCol5 = new DataColumn("version");
            DataColumn dbCol6 = new DataColumn("Status");
            DataColumn dbCol7 = new DataColumn("OrgID");
            DataColumn dbCol8 = new DataColumn("OrgAddressID");
            DataColumn dbCol9 = new DataColumn("CreatedAt");
            DataColumn dbCol10 = new DataColumn("CreatedBy");
            DataColumn dbCol11 = new DataColumn("Template");
            DataColumn dbCol12 = new DataColumn("ContextType");
            DataColumn dbCol13 = new DataColumn("IsAttachment");
            DataColumn dbCol14 = new DataColumn("Subject");
            DataColumn dbCol15 = new DataColumn("AttachmentName");
            DataColumn dbCol16 = new DataColumn("IsClientBlinding");
	    DataColumn dbCol17 = new DataColumn("CCTo");
            DataColumn dbCol18 = new DataColumn("BccTo");
            DataColumn dbCol19 = new DataColumn("ReportType");
            DataColumn dbCol20 = new DataColumn("IsManualReport");
            DataColumn dbCol21 = new DataColumn("IsReprinting");
            DataColumn dbCol22 = new DataColumn("ReportLanguage");
            DataColumn dbCol23 = new DataColumn("NoofCopies");
            //add columns
            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            dt.Columns.Add(dbCol7);
            dt.Columns.Add(dbCol8);
            dt.Columns.Add(dbCol9);
            dt.Columns.Add(dbCol10);
            dt.Columns.Add(dbCol11);
            dt.Columns.Add(dbCol12);
            dt.Columns.Add(dbCol13);
            dt.Columns.Add(dbCol14);
            dt.Columns.Add(dbCol15);
            dt.Columns.Add(dbCol16);
            dt.Columns.Add(dbCol17);
            dt.Columns.Add(dbCol18);
            dt.Columns.Add(dbCol19);
            dt.Columns.Add(dbCol20);
            dt.Columns.Add(dbCol21);
            dt.Columns.Add(dbCol22);
            dt.Columns.Add(dbCol23);

            if (chkAllItem.Checked == true)
            {
                if (txtFrom.Text != "")
                {
                    dtFrom = Convert.ToDateTime(txtFrom.Text);
                }
                else
                {
                    dtFrom = Convert.ToDateTime("1/1/1753 12:00:00");
                }

                if (txtTo.Text != "")
                {
                    dtTo = Convert.ToDateTime(txtTo.Text);
                }
                else
                {
                    dtTo = Convert.ToDateTime("1/1/1753 12:00:00");
                }
                BillingEngine BE = new BillingEngine(base.ContextInfo);



                Int32.TryParse(hdntxtzoneID.Value, out ZonalID);
                Int32.TryParse(hdnHubID.Value, out HubID);

                ContextInfo.StateID = ZonalID;
                ContextInfo.ThemeID = HubID;
                ContextInfo.AdditionalInfo = dropInvoiceCycle.SelectedValue;

                string InvoiceNo = txtInvoiceNo.Text;
                int ClientID = 0;
                if (Convert.ToInt32(hdnClientID.Value) > 0)
                {
                    ClientID = Convert.ToInt32(hdnClientID.Value);
                }
                int businessTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());
                BE.SearchInvoice(InvoiceNo, OrgID, ILocationID, Convert.ToDateTime(dtFrom), Convert.ToDateTime(dtTo),
                    out lstInvoice, -1, -1, out totalRows, businessTypeID, ClientID, hdnInvoiceType.Value);
                for (int i = 0; i < lstInvoice.Count(); i++)
                {

                    //ActionManager AM = new ActionManager(base.ContextInfo);
                    //List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    //PageContextkey PC = new PageContextkey();
                    //PC.ID = Convert.ToInt64(ddlLocationPrinter.SelectedValue);
                    //PC.PatientID = lstInvoice[i].ClientID;
                    //PC.RoleID = Convert.ToInt64(RoleID);
                    //PC.OrgID = OrgID;
                    //PC.PageID = Convert.ToInt64(PageID);
                    //PC.ButtonName = "INVOICEPRINTBTN";
                    //PC.ButtonValue = "INVOICEPRINTBTN";
                    //PC.PatientVisitID = lstInvoice[i].InvoiceID;
                    //lstpagecontextkeys.Add(PC);
                    //long res = -1;
                    //res = AM.PerformingNextStepNotification(PC, "", "");

                    string Additionalcontext = "<?xml version=" + "1.0" + " encoding=" + "utf-16" + "?><ContextInfo><InvoiceID>" + lstInvoice[i].InvoiceID.ToString() + "</InvoiceID><ClientID>" + lstInvoice[i].ClientID.ToString() + "</ClientID><FromDate>0</FromDate><ToDate>0</ToDate></ContextInfo>";

                    DataRow dr;
                    dr = dt.NewRow();
                    dr["ActionType"] = "INVOICEPRINT";
                    dr["Value"] = lstInvoice[i].InvoiceID.ToString();
                    dr["AdditionalContext"] = Additionalcontext;
                    dr["Category"] = "Invoice";
                    dr["Status"] = "";
                    dr["OrgID"] = OrgID;
                    dr["OrgAddressID"] = ddlLocationPrinter.SelectedValue;
                    dr["CreatedAt"] = DateTime.MinValue;
                    dr["CreatedBy"] = RoleID;
                    dr["Template"] = "";
                    dr["ContextType"] = "INV";
                    dr["IsAttachment"] = "Y";
                    dr["Subject"] = "";
                    dr["AttachmentName"] = "";
                    dr["IsClientBlinding"] = "";
		    dr["CCTo"] ="";
                    dr["BccTo"] ="";
                    dr["ReportType"] ="";
                    dr["IsManualReport"] = Convert.ToBoolean(false);
                    dr["IsReprinting"] = "";
                    dr["IsReprinting"] = "en-GB";
                    dr["NoofCopies"] = 1;

                    dt.Rows.Add(dr);
                }
                long res = -1;
                Report_DAL objReportdal = new Report_DAL(base.ContextInfo);
                res = objReportdal.SaveActionDetails(dt);
                dt = null;
                tblgrd.Style.Add("display", "none");
                tblprintaction.Style.Add("display", "none");
                GrdHeader.Style.Add("display", "none");
                //string AlertMessg = "Invoice Print Queue Sent";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Dispatchstatus", "javascript:ValidationWindow('" + AlrtMessg1 + "','" + AlrtWinHdr + "');", true);

               // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlrtMessg1 + "');", true);
            }
            else
            {
                rptMdlPopup.Hide();
                long InvoiceID = 0;
                long ClientID = 0;
                foreach (GridViewRow gvRow in grdInvoiceBill.Rows)
                {
                    if (gvRow.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkSel = (CheckBox)gvRow.FindControl("chkInvoiceItem");
                        if (chkSel.Checked == true)
                        {
                            Label lblClientID = (Label)gvRow.FindControl("lblClientID");
                            Label lblInvoiceID = (Label)gvRow.FindControl("lblInvoiceID");
                            if (lblInvoiceID != null)
                            {
                                InvoiceID = Convert.ToInt64(lblInvoiceID.Text);
                            }
                            if (lblClientID != null)
                            {
                                ClientID = Convert.ToInt64(lblClientID.Text);
                            }
                            string Additionalcontext = "<?xml version=" + "1.0" + " encoding=" + "utf-16" + "?><ContextInfo><InvoiceID>" + InvoiceID.ToString() + "</InvoiceID><ClientID>" + ClientID.ToString() + "</ClientID><FromDate>0</FromDate><ToDate>0</ToDate></ContextInfo>";
                            DataRow dr;
                            dr = dt.NewRow();
                            dr["ActionType"] = "INVOICEPRINT";
                            dr["Value"] = InvoiceID;
                            dr["AdditionalContext"] = Additionalcontext;
                            dr["Category"] = "Invoice";
                            dr["Status"] = "";
                            dr["OrgID"] = OrgID;
                            dr["OrgAddressID"] = ddlLocationPrinter.SelectedValue;
                            dr["CreatedAt"] = DateTime.MinValue;
                            dr["CreatedBy"] = RoleID;
                            dr["Template"] = "";
                            dr["ContextType"] = "INV";
                            dr["IsAttachment"] = "Y";
                            dr["Subject"] = "";
                            dr["AttachmentName"] = "";
                            dr["IsClientBlinding"] = "";
                            dt.Rows.Add(dr);
                            //ActionManager AM = new ActionManager(base.ContextInfo);
                            //List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                            //PageContextkey PC = new PageContextkey();
                            //PC.ID = Convert.ToInt64(ILocationID);
                            //PC.PatientID = ClientID;
                            //PC.RoleID = Convert.ToInt64(RoleID);
                            //PC.OrgID = OrgID;
                            //PC.PatientVisitID = InvoiceID;
                            //PC.FinalBillID = 0;
                            //PC.BillNumber = "0";
                            //PC.PageID = Convert.ToInt64(PageID);
                            //PC.ButtonName = "INVOICEPRINTBTN";
                            //PC.ButtonValue = "INVOICEPRINTBTN";
                            //lstpagecontextkeys.Add(PC);
                            //long res = -1;
                            //res = AM.PerformingNextStepNotification(PC, "", "");
                        }
                    }
                }
                long res = -1;
                Report_DAL objReportdal = new Report_DAL(base.ContextInfo);
                res = objReportdal.SaveActionDetails(dt);
                dt = null;
                GrdHeader.Style.Add("display", "none");
                tblgrd.Style.Add("display", "none");
                tblprintaction.Style.Add("display", "none");
               // string AlertMessg = "Invoice Print Queue Sent";
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Dispatchstatus", "alert('" + AlertMessg + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Dispatchstatus", "javascript:ValidationWindow('" + AlrtMessg1 + "','" + AlrtWinHdr + "');", true);

            }
        }
        //
        #endregion
    }
    public void callpage(object sender, EventArgs e)
    {
        Page_Load(sender, e);
    }
    public void ShowReport(string reportPath, long InvID, long Orgid, long OrgAddressID, long LID, string InvoiceType)
    {
        try
        {
            hdnShowReport.Value = "true";
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            //   strURL = "http://attune4-pc/ReportServer";
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[6];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pInvoiceID", Convert.ToString(InvID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(ILocationID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("LoginID", Convert.ToString(LID));
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("InvoiceType", Convert.ToString(InvoiceType));
            rReportViewer.ServerReport.SetParameters(reportParameterList);
            hdnInvID.Value = Convert.ToString(InvID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Invoice SSRS", ex);
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    protected void SendInvoiceEMail()
    {

        long InvID = 0;
        InvID = Convert.ToInt64(hdnInvID.Value);
        string deviceInfo = null;
        string format = "PDF";
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        string[] streamIDs = null;
        Microsoft.Reporting.WebForms.Warning[] warnings = null;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {

            long returnCode = -1;
            targetStream = new MemoryStream();
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay(base.ContextInfo);

            returnCode = gateWay.GetCommunicationDetails(CommunicationType.Invoice, InvID, LocationName, out lstCommunicationDetails);
            if (lstCommunicationDetails.Count > 0 && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
            {
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                sourceStream = new MemoryStream(results);
                PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                PdfSecuritySettings securitySettings = document.SecuritySettings;
                securitySettings.UserPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.OwnerPassword = lstCommunicationDetails[0].DocPassword;
                securitySettings.PermitAccessibilityExtractContent = false;
                securitySettings.PermitAnnotations = false;
                securitySettings.PermitAssembleDocument = false;
                securitySettings.PermitExtractContent = false;
                securitySettings.PermitFormsFill = false;
                securitySettings.PermitFullQualityPrint = true;
                securitySettings.PermitModifyDocument = false;
                securitySettings.PermitPrint = true;
                document.Save(targetStream, false);

                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "InvoiceReport_" + String.Format("{0:ddMMMyyyy}", OrgDateTimeZone) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                objActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail(lstCommunicationDetails[0].To, lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your One Time Password :" + lstCommunicationDetails[0].DocPassword + ", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
            }
        }
        catch (Exception ex)
        {
            // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }

    void AddToViewState()
    {
        long InvoiceId = -1;
        string InvoiceNo = string.Empty;
        string strInvDetails = string.Empty;
        long Clientid = -1;
        long ReportTemplateID = -1;
        string ClientName = string.Empty;
        bool blnExists = false;
        string ProductDetails = string.Empty;
        string[] hiddenIDs = new string[] { };
        ArrayList alTemp = al;

        foreach (GridViewRow row in grdInvoiceBill.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("chkInvoiceItem");
                if (chkBox.Checked)
                {
                    InvoiceId = Convert.ToInt64(grdInvoiceBill.DataKeys[row.RowIndex][0]);
                    InvoiceNo = grdInvoiceBill.DataKeys[row.RowIndex][1].ToString();
                    Clientid = Convert.ToInt64(grdInvoiceBill.DataKeys[row.RowIndex][2]);
                    ClientName = Convert.ToString(grdInvoiceBill.DataKeys[row.RowIndex][3]);
                    ReportTemplateID = Convert.ToInt32(grdInvoiceBill.DataKeys[row.RowIndex][4]);
                    strInvDetails = InvoiceId.ToString() + "~" + InvoiceNo + "~" + Clientid + "~" + ClientName + "~" + ReportTemplateID;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            if (al[i].ToString() == strInvDetails)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (!blnExists)
                        {
                            alTemp.Add(strInvDetails);
                        }
                    }
                    else
                    {
                        alTemp.Add(strInvDetails);
                    }
                }
                else
                {
                    InvoiceId = Convert.ToInt64(grdInvoiceBill.DataKeys[row.RowIndex][0].ToString());
                    InvoiceNo = grdInvoiceBill.DataKeys[row.RowIndex][1].ToString();
                    Clientid = Convert.ToInt64(grdInvoiceBill.DataKeys[row.RowIndex][2]);
                    ClientName = Convert.ToString(grdInvoiceBill.DataKeys[row.RowIndex][3]);
                    ReportTemplateID = Convert.ToInt32(grdInvoiceBill.DataKeys[row.RowIndex][4]);
                    strInvDetails = InvoiceId.ToString() + "~" + InvoiceNo + "~" + Clientid.ToString() + "~" + ClientName + "~" + ReportTemplateID;
                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {

                            if (al[i].ToString() == strInvDetails)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (blnExists)
                        {
                            alTemp.Remove(strInvDetails);
                        }
                    }
                }
            }
        }
        ViewState["Invoice"] = alTemp;

    }
    public string GetValue()
    {
        string str = string.Empty;
        AddToViewState();
        ArrayList alTemp = (ArrayList)ViewState["Invoice"];

        for (int i = 0; i < alTemp.Count; i++)
        {
            str += alTemp[i].ToString() + "^";
        }
        return str;
    }
    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
        out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }
    //----------------------------------------------Random Password---------------------------------------//


    public class RandomPassword
    {
        private static int DEFAULT_MIN_PASSWORD_LENGTH = 6;
        private static int DEFAULT_MAX_PASSWORD_LENGTH = 8;
        private static string PASSWORD_CHARS_LCASE = "abcdefgijkmnopqrstwxyz";
        private static string PASSWORD_CHARS_UCASE = "ABCDEFGHJKLMNPQRSTWXYZ";
        private static string PASSWORD_CHARS_NUMERIC = "1234567890";
        private static string PASSWORD_CHARS_SPECIAL = "*$?@#&=!%{}/";

        public static string Generate()
        {
            return Generate(DEFAULT_MIN_PASSWORD_LENGTH,
                            DEFAULT_MAX_PASSWORD_LENGTH);
        }

        public static string Generate(int length)
        {
            return Generate(length, length);
        }

        public static string Generate(int minLength,
                                      int maxLength)
        {

            if (minLength <= 0 || maxLength <= 0 || minLength > maxLength)
                return null;


            char[][] charGroups = new char[][] 
        {
            PASSWORD_CHARS_LCASE.ToCharArray(),
            PASSWORD_CHARS_UCASE.ToCharArray(),
            PASSWORD_CHARS_NUMERIC.ToCharArray(),
            PASSWORD_CHARS_SPECIAL.ToCharArray()
        };


            int[] charsLeftInGroup = new int[charGroups.Length];


            for (int i = 0; i < charsLeftInGroup.Length; i++)
                charsLeftInGroup[i] = charGroups[i].Length;


            int[] leftGroupsOrder = new int[charGroups.Length];


            for (int i = 0; i < leftGroupsOrder.Length; i++)
                leftGroupsOrder[i] = i;

            byte[] randomBytes = new byte[4];


            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            rng.GetBytes(randomBytes);


            int seed = (randomBytes[0] & 0x7f) << 24 |
                        randomBytes[1] << 16 |
                        randomBytes[2] << 8 |
                        randomBytes[3];


            Random random = new Random(seed);


            char[] password = null;


            if (minLength < maxLength)
                password = new char[random.Next(minLength, maxLength + 1)];
            else
                password = new char[minLength];


            int nextCharIdx;


            int nextGroupIdx;


            int nextLeftGroupsOrderIdx;

            int lastCharIdx;


            int lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;


            for (int i = 0; i < password.Length; i++)
            {

                if (lastLeftGroupsOrderIdx == 0)
                    nextLeftGroupsOrderIdx = 0;
                else
                    nextLeftGroupsOrderIdx = random.Next(0,
                                                         lastLeftGroupsOrderIdx);


                nextGroupIdx = leftGroupsOrder[nextLeftGroupsOrderIdx];


                lastCharIdx = charsLeftInGroup[nextGroupIdx] - 1;


                if (lastCharIdx == 0)
                    nextCharIdx = 0;
                else
                    nextCharIdx = random.Next(0, lastCharIdx + 1);


                password[i] = charGroups[nextGroupIdx][nextCharIdx];


                if (lastCharIdx == 0)
                    charsLeftInGroup[nextGroupIdx] =
                                              charGroups[nextGroupIdx].Length;

                else
                {

                    if (lastCharIdx != nextCharIdx)
                    {
                        char temp = charGroups[nextGroupIdx][lastCharIdx];
                        charGroups[nextGroupIdx][lastCharIdx] =
                                    charGroups[nextGroupIdx][nextCharIdx];
                        charGroups[nextGroupIdx][nextCharIdx] = temp;
                    }

                    charsLeftInGroup[nextGroupIdx]--;
                }


                if (lastLeftGroupsOrderIdx == 0)
                    lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;

                else
                {

                    if (lastLeftGroupsOrderIdx != nextLeftGroupsOrderIdx)
                    {
                        int temp = leftGroupsOrder[lastLeftGroupsOrderIdx];
                        leftGroupsOrder[lastLeftGroupsOrderIdx] =
                                    leftGroupsOrder[nextLeftGroupsOrderIdx];
                        leftGroupsOrder[nextLeftGroupsOrderIdx] = temp;
                    }

                    lastLeftGroupsOrderIdx--;
                }
            }


            return new string(password);
        }
    }



    //-----------------------------------------------------------------------------------------------------//
    protected void SendInvoiceEMail1()
    {


        InvID = Convert.ToInt64(hdnInvID.Value);
        string deviceInfo = null;
        string format = "PDF";
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        string[] streamIDs = null;
        Microsoft.Reporting.WebForms.Warning[] warnings = null;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {

            long returnCode = -1;
            targetStream = new MemoryStream();
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay();

            returnCode = gateWay.GetCommunicationDetails(CommunicationType.Invoice, InvID, LocationName, out lstCommunicationDetails);
            if (lstCommunicationDetails.Count > 0 && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
            {
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                sourceStream = new MemoryStream(results);
                PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                PdfSecuritySettings securitySettings = document.SecuritySettings;
                string DocPassword = RandomPassword.Generate(8, 10);

                securitySettings.UserPassword = DocPassword;
                securitySettings.OwnerPassword = DocPassword;
                securitySettings.PermitAccessibilityExtractContent = false;
                securitySettings.PermitAnnotations = false;
                securitySettings.PermitAssembleDocument = false;
                securitySettings.PermitExtractContent = false;
                securitySettings.PermitFormsFill = false;
                securitySettings.PermitFullQualityPrint = true;
                securitySettings.PermitModifyDocument = false;
                securitySettings.PermitPrint = true;
                document.Save(targetStream, false);

                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "InvoiceReport_" + String.Format("{0:ddMMMyyyy}", OrgDateTimeZone) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                objActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail(txtClientEmail.Text.Trim().ToString(), lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your password :" + DocPassword + ", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
                lblmsg.Text = "Mail sent successfully.";
                //hdnInvID.Value = String.Empty;
                txtClientEmail.Text = String.Empty;
                txtClientEmail.Enabled = true;
                //Communication.SendMail(String.IsNullOrEmpty(lstCommunicationDetails[0].From) ? "admin@attunelive.com" : lstCommunicationDetails[0].From, lstCommunicationDetails[0].To, lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your password :" + DocPassword + ", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", OrgName, lstMailAttachment, oMailConfig);

                // Communication.SendMail("admin@attunelive.com", "nallathambhi.n@attunelive.com", "", "", "Invoice", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + "Venkat" + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + "ATTUNE" + "<br/>" + "Guindy, Chennai" + "</strong></div></div>", OrgName, lstMailAttachment);

            }
            else
            {
                results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
                sourceStream = new MemoryStream(results);
                PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
                PdfSecuritySettings securitySettings = document.SecuritySettings;
                string DocPassword = RandomPassword.Generate(8, 10);

                securitySettings.UserPassword = DocPassword;
                securitySettings.OwnerPassword = DocPassword;
                securitySettings.PermitAccessibilityExtractContent = false;
                securitySettings.PermitAnnotations = false;
                securitySettings.PermitAssembleDocument = false;
                securitySettings.PermitExtractContent = false;
                securitySettings.PermitFormsFill = false;
                securitySettings.PermitFullQualityPrint = true;
                securitySettings.PermitModifyDocument = false;
                securitySettings.PermitPrint = true;
                document.Save(targetStream, false);

                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                objMailAttachment.ContentStream = targetStream;
                objMailAttachment.FileName = "InvoiceReport_" + String.Format("{0:ddMMMyyyy}", OrgDateTimeZone) + ".pdf";
                lstMailAttachment.Add(objMailAttachment);
                MailConfig oMailConfig = new MailConfig();
                objActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail(txtClientEmail.Text.Trim().ToString(), lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your password :" + DocPassword + ", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
                lblmsg.Text = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_005 == null ? "Mail sent successfully." : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_005;
                //hdnInvID.Value = String.Empty;
                txtClientEmail.Text = String.Empty;
            }
            ////else
            ////{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed. Please enable notification settings.');", true);
            ////}
        }
        catch (Exception ex)
        {
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }
    protected void btnSendEmail_Click(object sender, EventArgs e)
    {

        SendInvoiceEMail1();
    }
    //Added By BalaMahesh For MetroPolis
    public void SetGroupValues()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstrptmaster.Count > 0)
            {
                drpreportformat.DataSource = lstrptmaster;
                drpreportformat.DataTextField = "ReportTemplateName";
                drpreportformat.DataValueField = "TemplateID";
                drpreportformat.DataBind();
                drpreportformat.Items.Insert(0, strSelect);
                //drpreportformat.Items.Insert(0, "--Select--");
                drpreportformat.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    //Added By BalaMahesh For MetroPolis
    protected void drpreportformat_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Invoices = string.Empty;
        List<Invoice> lstInvID = new List<Invoice>();
        Invoices = hdnResult.Value;
        foreach (string O in Invoices.Split('^'))
        {
            if (O != string.Empty)
            {
                Invoice Iv = new Invoice();
                Iv.InvoiceID = Convert.ToInt64(O.Split('~')[0]);
                Iv.InvoiceNumber = O.Split('~')[1];
                Iv.ClientID = Convert.ToInt64(O.Split('~')[2]);
                Iv.Comments = Convert.ToString(O.Split('~')[3]);
                //Mahesh
                Iv.ReportTemplateID = Convert.ToInt32(O.Split('~')[4]);
                lstInvID.Add(Iv);
            }
        }
        long returnCode = -1;
        string reportPath = string.Empty;
        string Type = string.Empty;
        Type = "Invoice";
        long InvoiceID = 0;
        InvoiceID = lstInvID[0].InvoiceID;
        long ClientID = 0;
        ClientID = lstInvID[0].ClientID;
        //Mahesh
        long ReportTemplateID = 0;
        ReportTemplateID = Convert.ToInt32(drpreportformat.SelectedValue);

        List<BillingDetails> lstReportPath = new List<BillingDetails>();
        returnCode = bill.GetInvoiceReportPath(OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
        if (lstReportPath.Count > 0)
        {
            reportPath = lstReportPath[0].RefPhyName.ToString();
        }
        ShowReport(reportPath, InvoiceID, OrgID, ILocationID, LID, hdnInvoiceType.Value);

    }

    protected void drpCustomerType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpCustomerType.SelectedIndex == 0)
        {
            txtclient.Enabled = false;
            txtclient.Text = "";
        }
        else
        {
            txtclient.Enabled = true;
            int ClientTypeID = 0;
            int CustomerTypeID = Convert.ToInt32(drpCustomerType.SelectedValue.ToString());
            AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + ClientTypeID.ToString() + "~" + CustomerTypeID.ToString();
            txtclient.Focus();
            txtclient.Text = "";

        }
    }

    public void GetGroupValues()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstmetavalue.Count > 0)
            {
                string setID = "0";
                lstmetavalue.RemoveAll(p => p.Code != "BT");
                //string getCTOrg = "";
                //getCTOrg = GetConfigValue("CTORG", OrgID);
                //if (getCTOrg == "Y")
                //{
                //    if (lstmetavalue.Exists(p => p.Value == "CLINICALTRIAL"))
                //    {
                //        setID = lstmetavalue.Find(p => p.Value == "CLINICALTRIAL").MetaValueID.ToString();
                //    }
                //}
                drpCustomerType.DataSource = lstmetavalue;
                drpCustomerType.DataTextField = "Value";
                drpCustomerType.DataValueField = "MetaValueID";
                drpCustomerType.DataBind();
                drpCustomerType.Items.Insert(0, strSelect);
               // drpCustomerType.Items.Insert(0, "--Select--");
                drpCustomerType.Items[0].Value = "0";
                drpCustomerType.SelectedValue = setID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    public void LoadLocationPrinter()
    {
        List<LocationPrintMap> lpm = new List<LocationPrintMap>();
        long returnCode = new Referrals_BL(base.ContextInfo).GetLocationPrinter(OrgID, ILocationID,"", out lpm);
        if (lpm.Count == 1)
        {
            ddlLocationPrinter.DataSource = lpm;
            ddlLocationPrinter.DataTextField = "PrinterName";
            ddlLocationPrinter.DataValueField = "Code";
            ddlLocationPrinter.DataBind();
        }
        else
        {
            ddlLocationPrinter.DataSource = lpm;
            ddlLocationPrinter.DataTextField = "PrinterName";
            ddlLocationPrinter.DataValueField = "Code";
            ddlLocationPrinter.DataBind();
            ddlLocationPrinter.Items.Insert(0, "--Select--");
            ddlLocationPrinter.Items[0].Value = "-1";
        }
        /////////////////

    }
    protected void ZoneActDatList_ItemDataBound(object sender, DataListItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {

            DataList ClientActDataList = e.Item.FindControl("ClientActDataList") as DataList;
            List<Invoice> lstClientDataList = new List<Invoice>();
            Label Zone = (Label)e.Item.FindControl("ZoneName");
            Label printingperiod = (Label)e.Item.FindControl("lblprintingperiod");
            Label lblPrintedAt = (Label)e.Item.FindControl("lblPrintedAt");
            //if (txtFromPeriod.Text.ToString() == "")
            //{outerDataList

            printingperiod.Text = txtFrom.Text.ToString() + " TO " + txtTo.Text.ToString();
            //}
            //else
            //{

            //    printingperiod.Text = txtFromPeriod.Text.ToString() + " TO " + txtToPeriod.Text.ToString();
            //}

            //if (ddlRegisterDate.SelectedItem.Text == "Today")
            //{
            //    printingperiod.Text = OrgTimeZone + " to " + OrgTimeZone;
            //}

            //  lblPrintedAt.Text = "Printed At " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();

            lstClientDataList = (from child in lstChkListInvoice
                                 where child.ZoneName.ToUpper() == Zone.Text.ToString()
                                 select child).Distinct().ToList(); ;
            ClientActDataList.DataSource = lstClientDataList;
            ClientActDataList.DataBind();
        }

    }
    protected void btnExcelEprt_Click(object sender, EventArgs e)
    {
        try
        {
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Invoice CheckList.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            htw.WriteLine("<br>");
            htw.WriteLine("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

            htw.WriteLine("                    COLLECTION CENTER WISE BILL REGISTER " + txtFrom.Text.ToString() + " TO " + txtTo.Text.ToString());
            htw.WriteLine("<br>");
            htw.WriteLine("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
            htw.WriteLine("             Printed At " + OrgDateTimeZone);

            htw.WriteLine("<br>");
            htw.WriteLine("<br>");
            htw.WriteLine("<br>");
            // BTNSearch();
            // grdInvoiceBill.AllowPaging = false;

            //Int32.TryParse(hdntxtzoneID.Value, out ZonalID);
            //Int32.TryParse(hdnHubID.Value, out HubID);

            //ContextInfo.StateID = ZonalID;
            //ContextInfo.ThemeID = HubID;
            //BillingEngine BE = new BillingEngine(base.ContextInfo);
            //string InvoiceNo = txtInvoiceNo.Text;
            //int ClientID = 0;
            //if (Convert.ToInt32(hdnClientID.Value) > 0)
            //{
            //    ClientID = Convert.ToInt32(hdnClientID.Value);
            //}
            //int businessTypeID = Convert.ToInt32(drpCustomerType.SelectedItem.Value.ToString());
            //BE.SearchInvoice(InvoiceNo, OrgID, ILocationID, Convert.ToDateTime(txtFrom.Text),
            //    Convert.ToDateTime(dtTo), out lstInvoice, -1, -1, out totalRows, businessTypeID, ClientID);
            //DataGrid dg = new DataGrid();
            //dg.AutoGenerateColumns = true;


            //List<Invoice> lstinvoiceActexcel = new List<Invoice>();

            //lstinvoiceActexcel = (from child in lstInvoice
            //                      select new Invoice
            //                      {
            //                          InvoiceNumber = child.InvoiceNumber,
            //                          Comments = child.Comments,
            //                          BilledDate = child.BilledDate,
            //                          GrossValue = child.GrossValue,
            //                          DiscountAmt = child.DiscountAmt,
            //                          ZoneCode = child.ZoneCode,
            //                          NetValue = child.NetValue,
            //                          SaPLabCode = child.SaPLabCode
            //                      }).Distinct().ToList();

            //DataTable dt = new DataTable();

            //DataColumn dbCol1 = new DataColumn("Bill.No");
            //DataColumn dbCol2 = new DataColumn("Party Name");
            //DataColumn dbCol3 = new DataColumn("Bill.Date");
            //DataColumn dbCol4 = new DataColumn("Total Amt");
            //DataColumn dbCol5 = new DataColumn("Discount");
            //DataColumn dbCol6 = new DataColumn("Zone");
            //DataColumn dbCol7 = new DataColumn("Balance");
            //DataColumn dbCol8 = new DataColumn("SaP Lab Code");

            //DataRow dr;
            ////add columns
            //dt.Columns.Add(dbCol1);
            //dt.Columns.Add(dbCol2);
            //dt.Columns.Add(dbCol3);
            //dt.Columns.Add(dbCol4);
            //dt.Columns.Add(dbCol5);
            //dt.Columns.Add(dbCol6);
            //dt.Columns.Add(dbCol7);
            //dt.Columns.Add(dbCol8);

            //for (int j = 0; j < lstinvoiceActexcel.Count; j++)
            //{
            //    dr = dt.NewRow();
            //    dr["Bill.No"] = lstinvoiceActexcel[j].InvoiceNumber.ToString();
            //    dr["Party Name"] = lstinvoiceActexcel[j].Comments.ToString();
            //    dr["Bill.Date"] = lstinvoiceActexcel[j].BilledDate.ToString();
            //    dr["Total Amt"] = lstinvoiceActexcel[j].GrossValue.ToString("0.00");
            //    dr["Discount"] = lstinvoiceActexcel[j].DiscountAmt.ToString("0.00");
            //    dr["Zone"] = lstinvoiceActexcel[j].ZoneCode.ToString();
            //    dr["Balance"] = lstinvoiceActexcel[j].NetValue.ToString("0.00");
            //    dr["SaP Lab Code"] = lstinvoiceActexcel[j].SaPLabCode.ToString();

            //    dt.Rows.Add(dr);
            //}
            ////grdInvoiceBill.DataSource = dt;
            //grdInvoiceBill.DataBind();
            //form1.Controls.Add(dg);
            //Change the Header Row back to white colors
            //uterDataList.HeaderRow.Style.Add("background-color", "#FFFFFF");
            GridView1.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
