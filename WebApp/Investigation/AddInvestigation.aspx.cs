using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using Attune.Podium.ExcelExportManager;

public partial class Investigation_AddInvestigation : BasePage
{
    long returnCode = -1;
    List<InvestigationMaster> lstInvestigation = new List<InvestigationMaster>();
    public DataSet ds = new DataSet();
    string InvName = string.Empty;
    int currentPageNo = 1;
    int PageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
    public Investigation_AddInvestigation()
        : base("Investigation_AddInvestigation_aspx")
    {
    }

    #region "Common Resource Property"
    string Update = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_Update == null ? "Update" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_Update;
    string AlertType = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_Alert;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
                Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
                //returnCode = invBL.SearchInvestigation(OrgID, InvName, out lstInvestigation);
                btnSearch_Click(sender, e);
                //  loadgrid(e, currentPageNo, PageSize);
                string CodingScheme = GetConfigValue("CodingScheme", OrgID);
                if (CodingScheme == "Y")
                {
                    loadCodingSchemaName();
                    loadCodingSchemaNamesss();
                }
                hdnOrgID.Value = Convert.ToInt64(OrgID).ToString();

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation ", ex);
        }
    }
    #endregion
    #region "Events"
   
    protected void BtnClearCodingScheme_OnClick(object sender, EventArgs e)
    {
        clear111();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('SPL');", true);
    }
    protected void BtnDltCodingScheme_OnClick(object sender, EventArgs e)
    {
        string strSuccessAlert = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_09 == null ? "Deleted Successfully!" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_09;
        try
        {
            long returncode = -1;
            int Orgid = OrgID;
            int CodeTypeID = Convert.ToInt32(HdnCodingSchemeID.Value);
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returncode = MasterBL.DeleteCodingScheme(Orgid, CodeTypeID);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strSuccessAlert + "','" + AlertType + "');", true);
            
            clear111();
            loadCodingSchemaNamesss();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('SPL');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error In During BtnDltCodingScheme_OnClick", ex);
        }

    }
    protected void grdInvCodingScheme_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdInvCodingScheme.PageIndex = e.NewPageIndex;
        }
        loadCodingSchemaName();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('SPL');", true);
    }
    protected void grdInvCodingScheme_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[0].Visible = false;
            e.Row.Cells[1].Visible = false;

        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton starbutton = (ImageButton)e.Row.FindControl("starbutton") as ImageButton;
            if (e.Row.RowIndex >= 1)
            {
                starbutton.Attributes.Add("style", "display:none");
            }
        }
    }
    protected void grdinv_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "EditINV")
            {
                btnGo.Text = Update;
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                hdnInvestigationID.Value = grdinv.DataKeys[rowIndex]["InvestigationID"] != null ? Convert.ToString(grdinv.DataKeys[rowIndex]["InvestigationID"]) : string.Empty;
                txtInvestigation.Text = grdinv.DataKeys[rowIndex]["InvestigationName"] != null ? (string)grdinv.DataKeys[rowIndex]["InvestigationName"] : string.Empty;
                txtInvestigation.Focus();
                loadCodingSchemaName();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvestigationName", ex);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
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
    protected void btnNext_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
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
    protected void btnGoes_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        txtpageNo.Text = "";
    }
    protected void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        loaddgrid();

    }
    protected void BtnSaveCodingScheme_OnClick(object sender, EventArgs e)
    {
        string strChangesSaved = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_10 == null ? "Changes Saved Successfully!" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_10;
        string strSaved = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_11 == null ? "Saved Successfully!" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_11;
        try
        {
            long returncode = -1;
            List<CodingSchemeMaster> lstCodingSchemeMaster = new List<CodingSchemeMaster>();
            List<CodingSchemeOrgMapping> lstCodingSchemeOrgMapping = new List<CodingSchemeOrgMapping>();
            CodingSchemeMaster objcodingSchemeMaster = new CodingSchemeMaster();
            CodingSchemeOrgMapping objcodingSchemeOrgmapping = new CodingSchemeOrgMapping();
            Master_BL master_BL = new Master_BL(base.ContextInfo);
            int CodeTypeID = 0;
            objcodingSchemeMaster.CodingSchemaName = txtCodingSchemeName.Text;
            objcodingSchemeMaster.VersionNo = "1";
            objcodingSchemeOrgmapping.OrgID = OrgID;
            objcodingSchemeOrgmapping.ParentOrgID = OrgID;
            objcodingSchemeOrgmapping.RootOrgID = OrgID;

            if (chkboxIsPrimary.Checked)
            {
                objcodingSchemeOrgmapping.IsPrimary = "Y";

            }
            else
            {
                objcodingSchemeOrgmapping.IsPrimary = "N";
            }

            lstCodingSchemeMaster.Add(objcodingSchemeMaster);
            lstCodingSchemeOrgMapping.Add(objcodingSchemeOrgmapping);

            if (HdnCodingSchemeID.Value != "")
            {
                CodeTypeID = Convert.ToInt32(HdnCodingSchemeID.Value);
            }
            returncode = master_BL.SaveCodingScheme(OrgID, CodeTypeID, lstCodingSchemeMaster, lstCodingSchemeOrgMapping);

            if (returncode >= 0)
            {
                if (hdnBtnSaveCodingScheme.Value == Update)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strChangesSaved + "','" + AlertType+ "');", true);
                    

                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strSaved + "','" + AlertType + "');", true);

                }

            }
            clear111();

            loadCodingSchemaNamesss();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('SPL');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BtnSaveCodingScheme_OnClick", ex);
        }
    }
    protected void grdCodingScheme_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdCodingScheme.PageIndex = e.NewPageIndex;
        }
        loadCodingSchemaNamesss();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('SPL');", true);
    }
    protected void grdCodingScheme_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CodingSchemeMaster CSM = (CodingSchemeMaster)e.Row.DataItem;
            string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + CSM.CodeTypeID + "','" + CSM.CodingSchemaName + "','" + CSM.IsPrimary + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string strInvestigationNameSaved = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_12 == null ? "InvestigationName saved successfully." : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_12;
        string strInvestigationCode = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_13 == null ? "InvestigationName or Code Already Exists!!!." : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_13;
        string strInvestigationUpdated = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_14 == null ? "InvestigationName Updated successfully." : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_14;
        string[] Codeschemelabels = new string[grdInvCodingScheme.Rows.Count];
        string[] CodeSchemeNames = new string[grdInvCodingScheme.Rows.Count];
        string[] CodeMasterId = new string[grdInvCodingScheme.Rows.Count];
        int InvID = 0;
        if (hdnInvestigationID.Value != "")
        {
            InvID = Convert.ToInt32(hdnInvestigationID.Value.ToString());
        }
        string CodeType = "Investigations";
        int i = 0;
        try
        {
            InvName = txtInvestigation.Text;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
            {
                Codeschemelabels[i] = (GrdRow.FindControl("lblCodingSchemeNameMasterID") as Label).Text;
                CodeSchemeNames[i] = (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text;
                CodeMasterId[i] = (GrdRow.FindControl("lblCodeMasterID") as Label).Text;
                i = i + 1;

            }
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges();

            int j = 0;

            for (j = 0; j <= i - 1; j++)
            {
                DataRow dr;
                dr = dtCodingSchemeMaster.NewRow();
                dr["CodeLabel"] = Codeschemelabels[j];
                dr["CodeTextbox"] = CodeSchemeNames[j];
                dr["CodeMasterID"] = CodeMasterId[j];
                dtCodingSchemeMaster.Rows.Add(dr);
                dtCodingSchemeMaster.AcceptChanges();

            }
            string strsave = string.Empty;
            strsave = Resources.Investigation_ClientDisplay.Investigation_AddInvestigation_aspx_03 == null ? "Save" : Resources.Investigation_ClientDisplay.Investigation_AddInvestigation_aspx_03;
            if (btnGo.Text == strsave)
            {

                returnCode = invBL.ADDinvestigationName(OrgID, InvName, dtCodingSchemeMaster, CodeType, out lstInvestigation);

                if (returnCode >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + strInvestigationNameSaved + "','" + AlertType + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + strInvestigationCode + "','" + AlertType + "');", true);
                }
            }
            else
            {
                returnCode = invBL.UpdateInvestigationName(OrgID, InvID, InvName, dtCodingSchemeMaster, CodeType, out lstInvestigation);

                if (returnCode >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + strInvestigationUpdated+ "','" + AlertType + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + strInvestigationCode + "','" + AlertType + "');", true);
                }
            }

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
            txtInvestigation.Text = "";
            foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
            {
                (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text = string.Empty;
            }
            InvName = "";
            hdnInvestigationID.Value = "";
            btnGo.Text =strsave;
            LoadGrid(e, currentPageNo, PageSize);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in save investigation ", ex);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            hdnCurrent.Value = "";
            InvName = txtSearch.Text;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            returnCode = invBL.SearchInvestigation(OrgID, InvName, out lstInvestigation, PageSize, currentPageNo, out totalRows);
            if (returnCode == 0)
            {
                LoadGrid(e, currentPageNo, PageSize);
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
            // txtSearch.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation search ", ex);
        }
    }
    protected void grdinv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdinv.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            LoadGrid(e, currentPageNo, PageSize);
        }

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
    }
    protected void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            InvName = txtSearch.Text;
            Investigation_BL invBL = new Investigation_BL(base.ContextInfo);
            returnCode = invBL.SearchInvestigation(OrgID, InvName, out lstInvestigation, PageSize, currentPageNo, out totalRows);
            if (lstInvestigation.Count > 0)
            {
                GrdFooter.Style.Add("display", "table-row");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                hdntotalpage.Value = lblTotal.Text;
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
            if (lstInvestigation.Count > 0)
            {
                grdinv.Visible = true;
                // lblResult.Visible = false;
                // lblResult.Text = "";
                grdinv.DataSource = lstInvestigation;
                grdinv.DataBind();
            }
            else
            {
                grdinv.Visible = false;
                // lblResult.Visible = true;
                //lblResult.Text = "No matching records found";
            }



            //grdinv.DataSource = lstInvestigation;
            //grdinv.DataBind();
            DataTable dt = loaddata(lstInvestigation);
            //DataTable dt = new DataTable();
            //Utilities.ConvertFrom(lstInvestigation, out dt);
            ds.Tables.Add(dt);
            ViewState["Investigation"] = ds;
            hdnCurrent.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records ", ex);
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        string strNoData = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_15 == null ? "NO DATA" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_15;
        try
        {
            string prefix = string.Empty;
            prefix = "InvestigationMasterDetails";
            string rptDate = prefix + OrgTimeZone + ".xls";
            DataSet dsrpt = (DataSet)ViewState["Investigation"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + strNoData + "','" + AlertType + "');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in exporting to excel", ex);
        }
    }

    #endregion

    #region "Methods"
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

    public DataTable loaddata(List<InvestigationMaster> lstInvestigation)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("InvestigationID");
        DataColumn dcol2 = new DataColumn("PrimaryCode");
        DataColumn dcol3 = new DataColumn("InvestigationName");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        foreach (InvestigationMaster item in lstInvestigation)
        {
            DataRow dr = dt.NewRow();
            dr["InvestigationID"] = item.InvestigationID;
            dr["PrimaryCode"] = item.CodeName;
            dr["InvestigationName"] = item.InvestigationName;
            dt.Rows.Add(dr);

        }
        return dt;

    }
    private void loadCodingSchemaNamesss()
    {
        try
        {
            long returnCode = -1;

            List<CodingSchemeMaster> CSM = new List<CodingSchemeMaster>();
            int InvID = 0;
            if (hdnInvestigationID.Value != "")
            {
                InvID = Convert.ToInt32(hdnInvestigationID.Value.ToString());
            }
            string PkgName = txtInvestigation.Text;
            string Type = "Investigations";
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returnCode = MasterBL.GetCodingSchemeName(OrgID, PkgName, Type, InvID, out CSM);
            grdCodingScheme.DataSource = CSM;
            grdCodingScheme.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadCodingSchemeName", ex);
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
    }
    private void clear111()
    {
        txtCodingSchemeName.Text = "";
        HdnCodingSchemeID.Value = string.Empty;
        hdnBtnSaveCodingScheme.Value = "";
        chkboxIsPrimary.Checked = false;
    }
    private void loadCodingSchemaName()
    {
        try
        {
            long returnCode = -1;
            string PkgName = txtInvestigation.Text;
            string Type = "Investigations";
            List<CodingSchemeMaster> CSM = new List<CodingSchemeMaster>();
            int InvID = 0;
            if (hdnInvestigationID.Value != "")
            {
                InvID = Convert.ToInt32(hdnInvestigationID.Value.ToString());
            }
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returnCode = MasterBL.GetCodingSchemeName(OrgID, PkgName, Type, InvID, out CSM);
            grdInvCodingScheme.DataSource = CSM;
            grdInvCodingScheme.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadCodingSchemeName", ex);
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:DisplayTab('CLI');", true);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }   
    public void loaddgrid()
    {
        InvName = txtSearch.Text;
        ContextDetails contextInfo = new ContextDetails();
        contextInfo = base.ContextInfo;
        contextInfo.AdditionalInfo = "Y";
        //base.ContextInfo.AdditionalInfo="Y";
        Investigation_BL invBL = new Investigation_BL(contextInfo);

        returnCode = invBL.SearchInvestigation(OrgID, InvName, out lstInvestigation, PageSize, currentPageNo, out totalRows);
        if (lstInvestigation.Count > 0)
        {
            DataTable table = ConvertListToDataTable(lstInvestigation);
            GridExport.DataSource = table;
            GridExport.DataBind();
            ExportToExcel();
        }
        // DataTable table = new DataTable();


    }
    public void ExportToExcel()
    {
        try
        {
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string attachment = "attachment; filename=" + "Investigatin Master" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            GridExport.AllowPaging = false;
            InvName = txtSearch.Text;
            ContextDetails contextInfo = new ContextDetails();
            contextInfo = base.ContextInfo;
            contextInfo.AdditionalInfo = "Y";
            Investigation_BL invBL = new Investigation_BL(contextInfo);
            returnCode = invBL.SearchInvestigation(OrgID, InvName, out lstInvestigation, 10000, currentPageNo, out totalRows);
            GridExport.DataSource = null;
            GridExport.DataBind();
            if (lstInvestigation.Count > 0)
            {
                DataTable table = ConvertListToDataTable(lstInvestigation);
                GridExport.DataSource = table;
                GridExport.DataBind();
            }
            GridExport.Visible = true;
            GridExport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    static DataTable ConvertListToDataTable(List<InvestigationMaster> lstInvestigation)
    {
        string s = string.Empty;
        string strinvid = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_16 == null ? "Investigation ID" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_16;
        string strinvcode = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_17 == null ? "Code Name" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_17;
        string strinvname = Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_18 == null ? "Investigation Name" : Resources.Investigation_AppMsg.Investigation_AddInvestigation_aspx_18;
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn(strinvid);
        DataColumn dcol2 = new DataColumn(strinvcode);
        DataColumn dcol3 = new DataColumn(strinvname);

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        foreach (var item in lstInvestigation)
        {
            var row = dt.NewRow();
            row[strinvid] = item.InvestigationID;
            row[strinvcode] = item.CodeName;
            row[strinvname] = item.InvestigationName;

            dt.Rows.Add(row);
        }
        return dt;
    }

    #endregion


}
