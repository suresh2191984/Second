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
using System.Collections;


public partial class Lab_BatchSheet : BasePage
{


    public Lab_BatchSheet()
        : base("Lab_BatchSheet_aspx")
    {

    }

    long returnCode = -1;
    string fromVisit = "";
    string toVisit = "";
    string fromDate = string.Empty;
    string toDate = string.Empty;
    string Location = string.Empty;
    Investigation_BL investigationBL = new Investigation_BL();
    List<WorkOrder> lstWorkOrder = new List<WorkOrder>();
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<WorkOrder> lstWorkOrderCollec = new List<WorkOrder>();
    List<PatientInvSample> lstPatientInvSample = null;
    List<InvestigationSampleContainer> lstInvestigationSampleContainer = null;
    List<PatientInvSample> lstBatchSheetList;
    ImageClickEventArgs e1;

    #region "Initial"

    string strSelects = Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_01 == null ? "--------SELECT--------" : Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_01;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString() + '~' + ILocationID.ToString();
        //AutoCompleteExtender3.ContextKey = OrgID.ToString() + '~' + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() + '~' + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() + '~' + ILocationID + '~' + 0 + '~' + "GET";
        AutoCompleteExtender3.ContextKey = OrgID.ToString() + '~' + OrgTimeZone.ToString() + '~' + OrgTimeZone.ToString() + '~' + ILocationID + '~' + 0 + '~' + "GET";
        ddlocation.Attributes.Add("onchange", "CheckCode()");
        ddlMultiRoleUsers.Attributes.Add("onchange", "onGetUsersByRole()");      
        txtFrom.Attributes.Add("onBlur", "CheckCode()");
        txtTo.Attributes.Add("onBlur", "CheckCode()");
        rdlBatchMode.Attributes.Add("onClick", "ResetBatch()");
        tabPrintButton.Style.Add("display", "none");

        btnGenerateBatchSheet.Visible = false;
        if (!IsPostBack)
        {
            //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy") + " 12:00:00 AM";
            //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy hh:mm:ss tt");

            txtFrom.Text = Convert.ToDateTime(OrgTimeZone).AddDays(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm:ss tt");
            txtTo.Text = OrgDateTimeZone;
            divBatchSheet.Style.Add("display", "none");
            //prnReport.Style.Add("display", "none");
            returnCode = new Referrals_BL(base.ContextInfo).GetALLProcessingLocation(OrgID, out lAddress);

            List<OrganizationAddress> lstnewLocation = new List<OrganizationAddress>();

            lstnewLocation = lAddress.Where(c => c.AddressID != ILocationID).ToList();
            List<Users> lstusers = new List<Users>();
            long returnCodeUser = new Users_BL(base.ContextInfo).GetUsersByRole(OrgID, out lstusers);
            ddlMultiRoleUsers.DataSource = lstusers;
            ddlMultiRoleUsers.DataTextField = "Name";
            ddlMultiRoleUsers.DataValueField = "LoginID";
            ddlMultiRoleUsers.DataBind();
            ddlMultiRoleUsers.Items.Insert(0, strSelects.Trim());
            ddlMultiRoleUsers.Items[0].Value = "0";
            ddlMultiRoleUsers.Items[0].Text = "ALL";
            ddlMultiRoleUsers.SelectedValue = LID.ToString();
            ddlocation.DataSource = lstnewLocation;
            ddlocation.DataTextField = "City";
            ddlocation.DataValueField = "AddressID";
            //ddlocation.SelectedValue = ILocationID.ToString();
            ddlocation.DataBind();
            ddlocation.Items.Insert(0, strSelects.Trim());
            ddlocation.Items[0].Value = "0";

            TxtLocation.Text = LocationName;
            LoadMeatData();
           // if (ddlMultiRoleUsers.SelectedValue.ToString()!=null)
           // {
            //    bindWorkOrder();
            //}
        }
    }
    #endregion
    #region "Events"

    /// <summary>
    /// btnFinish_Click
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string strAddToExist = Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_02 == null ? "Add To Exist BatchSheet" : Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_02;
    string strGenerateBatch = Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_03 == null ? "Generate New BatchSheet" : Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_03;
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        divBatchSheet.Style.Add("display", "none");
        divNoRecords.Style.Add("display", "none");
        tabPrintButton.Style.Add("display", "none");
        bindWorkOrder();
        txtFrom.Focus();
        if (rdlBatchMode.SelectedValue == "2")
        {
            btnGenerateBatchSheet.Text = strAddToExist.Trim();
        }
        else
        {
            btnGenerateBatchSheet.Text = strGenerateBatch.Trim();
        }
        /* Code End */
    }
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        try
        {
            grdResult.Columns[0].Visible = false;
            if (Request.QueryString["ViewType"] != "iframe")
            {
                if (rdlBatchMode.SelectedValue == "1")
                {
                    foreach (GridViewRow RowItem in grdResult.Rows)
                    {
                        CheckBox chkBX = (CheckBox)RowItem.FindControl("chkSelect");
                        //if (!chkBX.Checked && chkBX.Visible)
                        //    RowItem.Visible = false;
                    }
                }
            }
            ExportToExcel(prnReport);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnFinish_Click(sender, e);
        }
    }
    /* Added By: Gurunath S
     * Added At: 12-Sep-2013
     * Fix Details: Save Batch sheet details and Update New BatchID in PatientInvSamlpe */
    /* Code Begin */



    /* Code End */
    protected void btnPrint_Click(object sender, ImageClickEventArgs e)
    {

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Print", "javascript:popupprint();", true);

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        try
        {
            btnPrint_Click(sender, e1);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Batch Sheet Details", ex);
        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Boolean haveNewSample = false;
        try
        {
            int count = e.Row.Cells.Count;
            if (count > 0 && count - 2 > 0 && count - 3 > 0)
            {
                e.Row.Cells[count - 2].Visible = false;
                e.Row.Cells[count - 3].Visible = false;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string txt = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PatientName"));
                string bid = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BatchID"));
                string IsSTAT = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsSTAT"));
                CheckBox chkBX = (CheckBox)e.Row.FindControl("chkSelect");

                HiddenField hdn = (HiddenField)e.Row.FindControl("hdnExvisitID");
                hdn.Value = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "LabNo"));

                if (txt == "Total")
                {
                    if (chkBX != null)
                    {
                        chkBX.Checked = false;
                        chkBX.Visible = false;
                    }
                    e.Row.CssClass = "dataheader1";
                    // e.Row.ForeColor = System.Drawing.Color.White;
                }
                if (bid != "0")
                {
                    if (chkBX != null)
                    {
                        chkBX.Checked = false;
                        chkBX.Visible = false;
                    }
                }
                else
                {
                    btnGenerateBatchSheet.Visible = true;
                }

                if (IsSTAT == "Y")
                {
                    e.Row.Font.Bold = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while binding gridview_OnRowDataBound", ex);
        }
    }

    /// <summary>
    /// btnGenerateBatchSheet_Click
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string WinAlert = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10 == null ? "Alert" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10;

    string strBatchSheetGenereted = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_07 == null ? "Batch Sheet Generated Successfully" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_07;
    string strBatchSheetUpdated = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_08 == null ? "Batch Sheet Updated Successfully" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_08;
    string strProblemBatchSheet = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_09 == null ? "Problem in Batch Sheet Generation" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_09;
    protected void btnGenerateBatchSheet_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            DateTime FromDate;
            DateTime ToDate;
            string BatchNo = string.Empty;
            int ProcessingLocationID = -1;
            List<string> lstExternalVisit = new List<string>();
            if (!String.IsNullOrEmpty(txtFrom.Text) && !String.IsNullOrEmpty(txtTo.Text) || (Request.QueryString["Mode"] == "4"))
            {
                lstBatchSheetList = new List<PatientInvSample>();
                //if (ViewState["BatchSheetList"] != null)
                //lstBatchSheetList = (List<PatientInvSample>)ViewState["BatchSheetList"];
                bindWorkOrder();

                if (lstBatchSheetList.Count() > 0)
                {
                    if ((rdlBatchMode.SelectedValue == "1" || rdlBatchMode.SelectedValue == "2") && (Request.QueryString["Mode"] != "4"))
                    {
                        FromDate = Convert.ToDateTime(txtFrom.Text);
                        ToDate = Convert.ToDateTime(txtTo.Text);
                        if (ddlocation.SelectedValue != "-1")
                            ProcessingLocationID = Convert.ToInt32(ddlocation.SelectedValue);
                        if (!String.IsNullOrEmpty(hdnUnSelectedPatients.Value))
                        {
                            //List<string> lstExternalVisit = new List<string>();
                            lstExternalVisit = hdnUnSelectedPatients.Value.Split('~').ToList();

                            var SaveList = from Items in lstBatchSheetList
                                           where lstExternalVisit.Contains(Items.SampleDesc)
                                           select Items;
                            lstBatchSheetList = SaveList.ToList();

                            if (rdlBatchMode.SelectedValue == "2")
                            {
                                var SaveList1 = from Items in lstBatchSheetList
                                                where Items.BatchID == 0
                                                select Items;
                                lstBatchSheetList = SaveList1.ToList();
                                int batchid;
                                int.TryParse(hdnBatchID.Value, out batchid);
                                returnCode = new Investigation_BL(base.ContextInfo).UpdateBatchSheet(OrgID, FromDate, ToDate, ILocationID, ProcessingLocationID, LID, lstBatchSheetList, batchid);
                            }
                            else
                            {
                                returnCode = new Investigation_BL(base.ContextInfo).SaveBatchSheet(OrgID, FromDate, ToDate, ILocationID, ProcessingLocationID, LID, lstBatchSheetList, out BatchNo);
                            }
                        }

                        if (!string.IsNullOrEmpty(BatchNo) || returnCode > 0)
                        {
                            grdResult.Columns[0].Visible = false;
                            int sno = 1;
                            foreach (GridViewRow RowItem in grdResult.Rows)
                            {
                                HiddenField hdn = (HiddenField)RowItem.FindControl("hdnExvisitID");
                                CheckBox chkBX = (CheckBox)RowItem.FindControl("chkSelect");
                                string txt = Convert.ToString(DataBinder.Eval(RowItem.DataItem, "PatientName"));
                                //DataBinder.Eval(RowItem.DataItem, "PatientName")
                                if (!lstExternalVisit.Contains(hdn.Value) || !chkBX.Visible)
                                    //if (!chkBX.Checked && chkBX.Visible)
                                    RowItem.Visible = false;
                                else
                                    RowItem.Cells[3].Text = sno++.ToString();
                            }
                            if (!String.IsNullOrEmpty(BatchNo))
                            {
                                if (CID > 0)
                                {
                                    if (!String.IsNullOrEmpty(UserName))
                                    {
                                        TxtClientName.Text = UserName;
                                        trClient.Attributes.Add("style", "display:block");
                                    }
                                }
                                lblbnoitem.Text = BatchNo;
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('" + strBatchSheetGenereted.Trim() + "');", true);
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + strBatchSheetGenereted + "','" + WinAlert + "');", true);
                            }
                            else
                            {
                                if (CID > 0)
                                {
                                    if (!String.IsNullOrEmpty(UserName))
                                    {
                                        TxtClientName.Text = UserName;
                                        trClient.Attributes.Add("style", "display:block");
                                    }
                                }
                                lblbnoitem.Text = txtBatchNo.Text;
                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('" + strBatchSheetUpdated.Trim() + "');", true);
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + strBatchSheetUpdated + "','" + WinAlert + "');", true);

                            }
                            //if (rdlBatchMode.SelectedValue == "1" && Request.QueryString["ViewType"] != "iframe")
                            //    tabPrintButton.Style.Add("display", "none");
                            //else
                            //    tabPrintButton.Style.Add("display", "block");
                            txtissusedby.Text = LoginName;
                            txtIssedDate.Text = OrgDateTimeZone;
                            btnGenerateBatchSheet.Visible = false;
                            tabPrintButton.Style.Add("display", "block");
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Print", "javascript:popupprint();", true);

                        }
                        else
                        {
                            tabPrintButton.Style.Add("display", "none");
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('" + strProblemBatchSheet.Trim() + "');", true);
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + strProblemBatchSheet + "','" + WinAlert + "');", true);
                        }
                    }
                }
            }
            hdnUnSelectedPatients.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving batch sheet", ex);
        }
    }

    #endregion
    #region "Methods"
    public void bindWorkOrder()
    {
        try
        {
            if (txtFromVisit.Text != "" && txtToVisit.Text != "")
            {
                fromVisit = txtFromVisit.Text;
                toVisit = txtToVisit.Text;
            }
            else
            {
                fromVisit = "";
                toVisit = "";
            }

            if (txtFrom.Text != "" && txtTo.Text != "")
            {
                fromDate = txtFrom.Text;
                toDate = txtTo.Text;
            }
            else
            {
                fromDate = "";
                toDate = "";
            }


            if (ddlocation.SelectedValue != "-1")
            {
                Location = ddlocation.SelectedValue.ToString();
            }
            else
            {
                Location = "-1";
            }
            string Mode = rdlBatchMode.SelectedValue;
            int BatchID = -1;
            int PLocationID = -1;
            int.TryParse(hdnBatchID.Value, out BatchID);
            Int32.TryParse(hdnProcessingLocation.Value, out PLocationID);
            ListItem item = ddlocation.Items.FindByValue(PLocationID.ToString());
            string BatchName = string.Empty;
            string ProcessingLocation = string.Empty;
            BatchName = txtBatchNo.Text;
            //ProcessingLocation = item.Text;
            long ClientID = CID;
                long collected_person_id = Convert.ToInt64(ddlMultiRoleUsers.SelectedValue.ToString());
                GenerateBatchSheet(fromVisit, toVisit, fromDate, toDate, ILocationID, Location, Mode, BatchID, ProcessingLocation, BatchName, ClientID,collected_person_id);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading WorkOrder method", ex);
        }
    }

    string printed = Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_010 == null ? "Printed On :" : Resources.Lab_ClientDisplay.Lab_BatchSheet_aspx_010;
    string strBatchFor = Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_04 == null ? "Batch Sheet For :" : Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_04;
    public void GenerateBatchSheet(string FromVisitNo, string ToVisitNo, string FromDateRange, string ToDateRange, int SourceLocation, string ProcessingLocationID, string Mode, int BatchID, string ProcessingLocation, string BatchNo, long ClientID,long CollectedID)
    {
        try
        {
            DataSet ds = new DataSet();
            int maxcols;
            /* Code Added : Gurunath S
             * Code Added At: 12-Sep-2013
             * Fix Details : Get collection of PatientInvSamples */
            grdResult.DataSource = null;
            grdResult.DataBind();
            grSampleDetails.DataSource = null;
            grSampleDetails.DataBind();
            lstPatientInvSample = new List<PatientInvSample>();
            lstInvestigationSampleContainer = new List<InvestigationSampleContainer>();
            //returnCode = investigationBL.GetBatchSheet(fromVisit, toVisit, fromDate, toDate, Location, ILocationID, OrgID, out ds, out lstPatientInvSample);
            int BatchOrgID = -1;
            string ViewType = string.Empty;
            if (!String.IsNullOrEmpty(Request.QueryString["ViewType"]))
                ViewType = Request.QueryString["ViewType"];
            if (!String.IsNullOrEmpty(ViewType) && ViewType == "iframe")
            {
                if (Mode == "2")
                {
                    if (!String.IsNullOrEmpty(Request.QueryString["BatchOrgID"]))
                        Int32.TryParse(Request.QueryString["BatchOrgID"], out BatchOrgID);
                    else
                        BatchOrgID = OrgID;
                }
                else
                    BatchOrgID = OrgID;
            }
            else
                BatchOrgID = OrgID;
            
            returnCode = new Investigation_BL(base.ContextInfo).GetBatchSheet(FromVisitNo, ToVisitNo, FromDateRange, ToDateRange, ProcessingLocationID, SourceLocation, BatchOrgID, out ds, out lstPatientInvSample, out lstInvestigationSampleContainer, Mode, BatchID, ClientID,CollectedID);
            if (Mode == "1" || Mode == "2")
                grdResult.Columns[0].Visible = true;
            else
                grdResult.Columns[0].Visible = false;
            if (lstPatientInvSample.Count() > 0)
            {
                //tabPrintButton.Style.Add("display", "block");
                //prnReport.Style.Add("display", "block");
                //ViewState["BatchSheetList"] = lstPatientInvSample.ToList();
                lstBatchSheetList = lstPatientInvSample.ToList();
            }
            /* Code End */
            //var collec = from lst in lstWorkOrder
            //             where lst.DeptID == ILocationID
            //             select lst;
            //  lstWorkOrderCollec = collec.ToList<WorkOrder>();
            if (ds.Tables.Count > 0)
            {
                Hashtable ht = new Hashtable();
                string containername = string.Empty;
                int containtercount = 0;
                maxcols = ds.Tables[0].Columns.Count;

                for (int columnpos = 3; columnpos < maxcols - 3; columnpos++)
                {
                    containtercount = 0;
                    containername = string.Empty;
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        if (dr[columnpos] != "")
                        {
                            containtercount += Convert.ToInt32(dr[columnpos]);
                        }
                    }
                    containername = ds.Tables[0].Columns[columnpos].ColumnName;
                    ht.Add(containername, containtercount);
                }
                DataRow newRow = ds.Tables[0].NewRow();
                newRow["PatientName"] = "Total";
                foreach (DictionaryEntry dt in ht)
                {
                    newRow[dt.Key.ToString()] = dt.Value.ToString();
                }
                ds.Tables[0].Rows.Add(newRow);


                ds.Tables[0].AcceptChanges();
                ds.Tables[0].Columns.Add("Remarks");
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    dr["Remarks"] = string.Empty;
                }
            }
            bool isExists = true;
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DivSamplDetails.Style.Add("display", "block");
                    grdResult.DataSource = ds;
                    grdResult.DataBind();
                    maxcols = ds.Tables[0].Columns.Count;
                    //grdResult.Columns[2].ItemStyle.CssClass
                    int TotalSamples = lstInvestigationSampleContainer.Sum(item => item.SampleContainerID);
                    InvestigationSampleContainer objISC = new InvestigationSampleContainer();
                    objISC.ContainerName = "Total";
                    objISC.SampleContainerID = TotalSamples;
                    lstInvestigationSampleContainer.Add(objISC);

                    grSampleDetails.DataSource = lstInvestigationSampleContainer;
                    grSampleDetails.DataBind();

                    lblPrintedOn.Visible = true;
                    lblPrintedOn.Text = printed + OrgTimeZone;

                    lblLocationName.Visible = true;

                    if (Mode == "1")
                        ProcessingLocation = ddlocation.SelectedItem.ToString();

                    string SourceLocationName = string.Empty;
                    if (!String.IsNullOrEmpty(Request.QueryString["ViewType"]) && Request.QueryString["ViewType"] == "iframe")
                        SourceLocationName = Request.QueryString["SourceLocation"];
                    else
                        SourceLocationName = LocationName;
                    lblLocationName.Text = "<font size='4'><b>" + strBatchFor.Trim() + " " + ProcessingLocation + "</b></font> <font size='2'> (Source: " + SourceLocationName + ")</font>";
                    //    tabPrintButton.Style.Add("display", "block");
                    //    hypLnkPrint.NavigateUrl = "PrintWorkOrderFromVisitToVisit.aspx?fvid=" + fromVisit + "&tvid=" + toVisit + "&fdate=" + fromDate + "&tdate=" + toDate + "&loc=" + Location + "&src=" + sourceName + "&vtype=" + visitType + "&ward=" + wardNo;

                    if (rdlBatchMode.SelectedValue == "5")
                    {
                        btnGenerateBatchSheet.Visible = false;
                        tabPrintButton.Style.Add("display", "block");
                        lblbnoitem.Text = txtBatchNo.Text;
                        if (CID > 0)
                        {
                            TxtClientName.Text = UserName;
                            trClient.Attributes.Add("style", "display:block");
                        }
                    }
                    //else
                    //{
                    //    btnGenerateBatchSheet.Visible = true;
                    //}

                }
                else
                    isExists = false;
            }
            else
                isExists = false;
            if (!isExists)
            {
                divNoRecords.Style.Add("display", "block");
                grdResult.DataSource = null;
                grdResult.DataBind();

                lblPrintedOn.Visible = false;
                lblPrintedOn.Text = "";

                lblLocationName.Visible = false;
                lblLocationName.Text = "";

                btnGenerateBatchSheet.Visible = false;
                DivSamplDetails.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating Batch Sheet List", ex);
        }
    }
    public void ExportToExcel(Control ctr)
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "BatchSheet_";

        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;

        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        //prnReport.RenderControl(oHtmlTextWriter); 
        ctr.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "batchmode";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "batchmode"
                                 select child;
                if (childItems.Count() > 0)
                {
                    rdlBatchMode.DataSource = childItems;
                    rdlBatchMode.DataTextField = "DisplayText";
                    rdlBatchMode.DataValueField = "Code";
                    rdlBatchMode.DataBind();
                    rdlBatchMode.SelectedValue = "1";

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
    

    
    
    
    
    
  
}
