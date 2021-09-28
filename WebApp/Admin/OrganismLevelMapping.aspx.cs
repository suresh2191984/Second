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
using System.Data.OleDb;
using System.Data.Common;
using System.Configuration;
using System.Data.SqlClient;
using Attune.Cryptography;
using Newtonsoft.Json;
using System.Reflection;

public partial class Admin_OrganismLevelMapping : BasePage
{
    List<InvestigationDrugBrand> lstInvestigationDrugBrand = new List<InvestigationDrugBrand>();
    List<InvestigationDrugFamilyMaster> lstFamilyMaster = new List<InvestigationDrugFamilyMaster>();
    List<OrganismMaster> lstOrganismMaster = new List<OrganismMaster>();
    List<InvOrganismDrugMapping> lstInvOrganismDrugMapping = new List<InvOrganismDrugMapping>();

    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(this.ibFamilyDownload);
        scriptManager.RegisterPostBackControl(this.ibFamilyExportDownload);
        scriptManager.RegisterPostBackControl(this.imDrugMasterDownload);
        scriptManager.RegisterPostBackControl(this.imDrugMasterExportDownload);
        scriptManager.RegisterPostBackControl(this.imButtonDownloadBulkMaster);
        scriptManager.RegisterPostBackControl(this.imButtonExportBulkMaster);

        ACETestCodeScheme.ContextKey = Convert.ToString(OrgID + "~" + CodeSchemeType.Investigations);
        ddlDrugName.ToolTip = "Select";
        if (!IsPostBack)
        {

            MainView.ActiveViewIndex = 0;
            LoadOrganismMaster();
            loadDrugBrand();
            LoadFamilyMaster();
            loadMappingDetails();
            /* BEGIN | sabari | 20181129 | Dev | Culture Report */
            LoadLevelMappingDetails();
            /* END | sabari | 20181129 | Dev | Culture Report */
        }

        //if (Session["Family"] == null && fuFamilyBulkData.HasFile)
        //{
        //    Session["Family"] = fuFamilyBulkData;
        //  //  Label1.Text = fuUpload.FileName;
        //} 
        // Session["Family"] = fuFamilyBulkData.FileName;

    }

    private void LoadOrganismMaster()
    {
        Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
        long returncode = -1;


        returncode = investigationbl.GetOrganismList(0, out lstOrganismMaster);
        if (lstOrganismMaster.Count > 0)
        {
            gvOrganismMaster.DataSource = lstOrganismMaster;
            gvOrganismMaster.DataBind();

            var Value = lstOrganismMaster.Where(X => X.IsActive == true).ToList();
            if (Value != null && Value.Count > 0)
            {
                ddlOrganismName.DataTextField = "Name";
                ddlOrganismName.DataValueField = "ID";
                ddlOrganismName.DataSource = Value;
                ddlOrganismName.DataBind();
            }
            ddlOrganismName.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));

        }
        else
        {
            gvOrganismMaster.DataSource = null;
            gvOrganismMaster.DataBind();
        }
    }

 

    private int GetFamilyId(string Name)
    {
        Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
        long returncode = -1;

        int value = 0;
        returncode = investigationbl.GetFamilyIdByName(Name, out lstFamilyMaster);
        if (lstFamilyMaster.Count > 0)
        {
            value = Convert.ToInt32(lstFamilyMaster[0].FamilyId);
        }
        return value;
    }

    private void LoadFamilyMaster()
    {
        Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
        long returncode = -1;


        List<InvestigationDrugFamilyMaster> lstFamilyMasterl = new List<InvestigationDrugFamilyMaster>();

        returncode = investigationbl.GetInvestigationDrugFamilyList(out lstFamilyMaster);
        if (lstFamilyMaster.Count > 0)
        {
            gvFamilyMaster.DataSource = lstFamilyMaster;
            gvFamilyMaster.DataBind();

            var Value = lstFamilyMaster.Where(X => X.IsActive == true).ToList();
            if (Value != null && Value.Count > 0)
            {
                ddlFamilyName.DataTextField = "Familyname";
                ddlFamilyName.DataValueField = "FamilyId";
                ddlFamilyName.DataSource = Value;
                ddlFamilyName.DataBind();
            }
            ddlFamilyName.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));

        }
        else
        {
            gvFamilyMaster.DataSource = null;
            gvFamilyMaster.DataBind();
            ddlFamilyName.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));

        }
    }

    private void LoadFamilyMasterHistory(long Id)
    {
        Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
        long returncode = -1;

        List<InvestigationDrugFamilyMaster> lstFamilyMaster = new List<InvestigationDrugFamilyMaster>();

        returncode = investigationbl.GetInvestigationDrugFamilyListHistory(Id, out lstFamilyMaster);
        if (lstFamilyMaster.Count > 0)
        {
            gvFamilyMasterHistory.DataSource = lstFamilyMaster;
            gvFamilyMasterHistory.DataBind();
        }
        else
        {
            gvFamilyMasterHistory.DataSource = null;
            gvFamilyMasterHistory.DataBind();
        }
    }

    private void LoadDrugMasterHistory(long Id)
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        long returncode = -1;

        List<InvestigationDrugBrand> lstDrugMaster = new List<InvestigationDrugBrand>();

        returncode = patientBL.GetDrugBrandMasterHistory(Id, out lstDrugMaster);
        if (lstDrugMaster.Count > 0)
        {
            gvDrugMasterHistory.DataSource = lstDrugMaster;
            gvDrugMasterHistory.DataBind();
        }
        else
        {
            gvDrugMasterHistory.DataSource = null;
            gvDrugMasterHistory.DataBind();
        }
    }

    private void LoadOrganismMasterHistory(long Id)
    {
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
        long returncode = -1;

        List<OrganismMaster> lstOrganismMaster = new List<OrganismMaster>();

        returncode = investigationBL.GetOrganismListHistory(Id, out lstOrganismMaster);
        if (lstOrganismMaster.Count > 0)
        {
            gvOrganismMasterHistory.DataSource = lstOrganismMaster;
            gvOrganismMasterHistory.DataBind();
        }
        else
        {
            gvOrganismMasterHistory.DataSource = null;
            gvOrganismMasterHistory.DataBind();
        }
    }

    private void loadDrugBrand()
    {
        ContextInfo.AdditionalInfo = "Y";
        Patient_BL Patientbl = new Patient_BL(base.ContextInfo);
        long returncode = -1;
        returncode = Patientbl.GetInvestigationDrugBrand(OrgID, "", out lstInvestigationDrugBrand);
        if (lstInvestigationDrugBrand.Count > 0)
        {
            gvDrugMaster.DataSource = lstInvestigationDrugBrand;
            gvDrugMaster.DataBind();

            var Value = lstInvestigationDrugBrand.Where(X => X.IsActive == true).ToList();
            if (Value != null && Value.Count > 0)
            {
                gvddlDrugBrand.DataSource = Value;
                gvddlDrugBrand.DataBind();
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "javascript:Loaddropdown(" + JsonConvert.SerializeObject(Value) + ");", true);
            }
            //ddlDrugName.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));

        }
        else
        {
            gvDrugMaster.DataSource = null;
            gvDrugMaster.DataBind();
        }
    }


    private void loadMappingDetails()
    {
        List<InvOrganismDrugMapping> lstInvOrganismDrugMapping = new List<InvOrganismDrugMapping>();
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        long returncode = -1;
        returncode = InvestigationBL.GetOrganismMappingList(0, out lstInvOrganismDrugMapping);
        if (lstInvOrganismDrugMapping.Count > 0)
        {
            gvDrugMappingGrid.DataSource = lstInvOrganismDrugMapping;
            gvDrugMappingGrid.DataBind();
        }
        else
        {
            gvDrugMappingGrid.DataSource = null;
            gvDrugMappingGrid.DataBind();
        }
    }
    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
    private void LoadLevelMappingDetails()
    { 
        Patient_BL Patientbl = new Patient_BL(base.ContextInfo);
        long returncode = -1;
        lstInvestigationDrugBrand.Clear();
        if (lstInvestigationDrugBrand != null && lstInvestigationDrugBrand.Count >0)
        {
            lstInvestigationDrugBrand.Clear();
        }
        returncode = Patientbl.GetInvestigationDrugBrand(OrgID, "", out lstInvestigationDrugBrand);
        if (lstInvestigationDrugBrand.Count > 0)
        {
            //var Value = lstOrganismMaster.Where(X => X.IsActive == true).ToList();
            if (lstInvestigationDrugBrand != null && lstInvestigationDrugBrand.Count > 0)
            {
                ddlLevelMapDrugName.DataTextField = "BrandName";
                ddlLevelMapDrugName.DataValueField = "DrugID";
                ddlLevelMapDrugName.DataSource = lstInvestigationDrugBrand;
                ddlLevelMapDrugName.DataBind();
            }
            ddlLevelMapDrugName.Items.Insert(0, new ListItem("--Select--".Trim(), "-1"));
        }

        /*Begin to bind grid*/
        Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
        long Returncode_Grid = -1;
        List<DrugLevelMapping> lstDrugLevelMapping = new List<DrugLevelMapping>();
        Returncode_Grid = investigationbl.GetDrugLevelMappingDetails( out lstDrugLevelMapping);
        if (lstDrugLevelMapping != null && lstDrugLevelMapping.Count > 0)
        {
            grdDrugLevelMap.DataSource = lstDrugLevelMapping;
            grdDrugLevelMap.DataBind();
        }
        else
        {
            grdDrugLevelMap.DataSource = null;
            grdDrugLevelMap.DataBind();
        }
        /*End to bind grid*/

    }
    protected void grdDrugLevelMap_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HiddenField hiddenID = (HiddenField)e.Row.Cells[3].FindControl("hdnDrugLevelMappingActive");
                if (hiddenID != null)
                {
                    if (hiddenID.Value == "True")
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnLvelMapInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                        lnkbtnActive.Text = "Active";
                        // hiddenID.Value = "True";
                    }
                    else
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnLvelMapInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                        lnkbtnActive.Text = "InActive";
                        // hiddenID.Value = "False";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at grdDrugLevelMap_RowDataBound", ex);
        }
    }
    protected void grdDrugLevelMap_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                grdDrugLevelMap.PageIndex = e.NewPageIndex;
                LoadLevelMappingDetails();
            }
        }
        catch (Exception ex)
        {
            grdDrugLevelMap.PageIndex = 1;
            CLogger.LogError("Error in Organism Level Mapping page at grdDrugLevelMap_PageIndexChanging", ex);
        }
    }
    /* END | sabari | 20181129 | Dev | Culture Report */
    protected void gvDrugMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                gvDrugMaster.PageIndex = e.NewPageIndex;
                loadDrugBrand();
            }
        }
        catch (Exception ex)
        {
            gvDrugMaster.PageIndex = 1;
            CLogger.LogError("Error in Organism Level Mapping page at gvDrugMaster_PageIndexChanging", ex);
        }
    }

    protected void gvDrugMaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HiddenField hiddenID = (HiddenField)e.Row.Cells[3].FindControl("HDDrugMasterActive");
                if (hiddenID != null)
                {
                    if (hiddenID.Value == "True")
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnDrugInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                        lnkbtnActive.Text = "Active";
                        // hiddenID.Value = "True";
                    }
                    else
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnDrugInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                        lnkbtnActive.Text = "InActive";
                        // hiddenID.Value = "False";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at gvOrganismMaster_RowDataBound", ex);
        }
    }

    protected void gvOrganismMaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HiddenField hiddenID = (HiddenField)e.Row.Cells[3].FindControl("HDOrgaanismMasterActive");
                if (hiddenID != null)
                {
                    if (hiddenID.Value == "True")
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                        lnkbtnActive.Text = "Active";
                    }
                    else
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                        lnkbtnActive.Text = "InActive";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at gvOrganismMaster_RowDataBound", ex);
        }
    }

    protected void gvOrganismMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                gvOrganismMaster.PageIndex = e.NewPageIndex;
                LoadOrganismMaster();
            }
        }
        catch (Exception ex)
        {
            gvOrganismMaster.PageIndex = 1;
            CLogger.LogError("Error in Organism Level Mapping page at gvOrganismMaster_PageIndexChanging", ex);
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDOrganismMasterId");
            HDOrganismMasterId.Value = hiddenID.Value;
            txtOrganismName.Text = row.Cells[1].Text;
            txtOrganismCode.Text = row.Cells[2].Text;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }

    protected void btnInActive_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            int IsActive = -1;
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDOrganismMasterId");
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            returncode = investigationBL.GetIsActiveOrganismList(Convert.ToInt32(hiddenID.Value), out IsActive);
            if (returncode == 1 && IsActive == 1)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                // hiddenID.Value = "True";
                lnkbtnActive.Text = "Active";
            }
            else if (returncode == 1 && IsActive == 0)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                // hiddenID.Value = "False";
                lnkbtnActive.Text = "InActive";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnInActive_Click", ex);
        }
    }

    protected void btnHistory_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void btnDrugInActive_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            long IsActive = -1;
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDDrugMasterId");
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            returncode = patientBL.ActiveInactiveInvestigationDrugBrand(Convert.ToInt32(hiddenID.Value), out IsActive);
            if (returncode == 1 && IsActive == 1)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnDrugInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                // hiddenID.Value = "True";
                lnkbtnActive.Text = "Active";
            }
            else if (returncode == 1 && IsActive == 0)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnDrugInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                // hiddenID.Value = "False";
                lnkbtnActive.Text = "InActive";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugInActive_Click", ex);
        }
    }

    protected void btnDrugEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDDrugMasterId");
            DrugMasterId.Value = hiddenID.Value;
            txtDrugName.Text = row.Cells[1].Text;
            txtDrugCode.Text = row.Cells[2].Text;
            HiddenField hiddenFMID = (HiddenField)row.FindControl("hdnFamilyId");
            ddlFamilyName.SelectedValue = hiddenFMID.Value;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }

    protected void btnDrugHistory_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDDrugMasterId");
            if (!String.IsNullOrEmpty(hiddenID.Value))
            {
                LoadDrugMasterHistory(Convert.ToInt64(hiddenID.Value));
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "javascript:FamilyHistory('divDrugMasterHistory');", true);

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugHistory_Click", ex);
        }
    }

    public void ExportToExcel(string FileName, GridView view)
    {
        ////export to excel
        //HttpResponse response = HttpContext.Current.Response;
        try
        {
            view.AllowPaging = false;

            string attachment = "attachment; filename=" + OrgTimeZone + FileName + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            view.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
        finally
        { //Response.End();
        }
    }
    public void DownloadExcelTemplate(string FileName)
    {
        ////export to excel
        //HttpResponse response = HttpContext.Current.Response;
        try
        {
            //This is used to get Project Location.
            string filePath = HttpContext.Current.Server.MapPath("~/ExcelTest/") + FileName + ".xlsx";
            //This is used to get the current response.

            HttpResponse res = HttpContext.Current.Response;

            res.Clear();
            res.AppendHeader("content-disposition", "attachment; filename=" + filePath);

            res.ContentType = "application/octet-stream";

            res.WriteFile(filePath);

            res.Flush();

            res.End();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
        finally
        { //Response.End();
        }
    }

    protected void imDrugMasterDownload_Click(object sender, ImageClickEventArgs e)
    {
        DownloadExcelTemplate("Drugs Template");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //return;
    }

    protected void btnDrugMasterSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long DrugID = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            InvestigationDrugBrand invDrugBrand = new InvestigationDrugBrand();
            if (DrugMasterId.Value == "" || Convert.ToInt32(DrugMasterId.Value) == 0)
            {
                invDrugBrand.BrandName = txtDrugName.Text;
                invDrugBrand.Code = txtDrugCode.Text;
                invDrugBrand.OrgID = OrgID;
                invDrugBrand.FMID = Convert.ToInt32(ddlFamilyName.SelectedItem.Value);
                invDrugBrand.CreatedBy = LID;
                returnCode = patientBL.SaveInvestigationDrugBrand(invDrugBrand, out DrugID);
                if (returnCode == 0)
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    DrugMasterId.Value = "";
                    ddlFamilyName.SelectedValue = "-1";
                    // lblstatus.Visible = true;
                    // btnRefresh.Visible = true;
                    // hdnDrugID.Value = "";
                    //lblstatus.Text = "DrugBrand Is Successfully Added";
                    // lblstatus.Text = "DrugBrand Is Successfully Added";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('DrugBrand Is Successfully Added','Information');", true);
                }
                else
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    DrugMasterId.Value = "";
                    ddlFamilyName.SelectedValue = "-1";
                    //lblstatus.Text = "DrugBrand Is Successfully Added";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Drug Name Already Exists','Information');", true);
                }
            }
            else if (DrugMasterId.Value != "" || Convert.ToInt32(DrugMasterId.Value) > 0)
            {
                invDrugBrand.DrugID = Convert.ToInt64(DrugMasterId.Value);
                invDrugBrand.BrandName = txtDrugName.Text;
                invDrugBrand.Code = txtDrugCode.Text;
                invDrugBrand.OrgID = OrgID;
                invDrugBrand.FMID = Convert.ToInt32(ddlFamilyName.SelectedValue);
                invDrugBrand.ModifiedBy = LID;
                returnCode = patientBL.UpdateInvestigationDrugBrand(invDrugBrand);
                if (returnCode == 0)
                {
                    txtDrugName.Text = "";
                    txtDrugCode.Text = "";
                    ddlFamilyName.SelectedValue = "-1";
                    DrugMasterId.Value = "";
                    //lblstatus.Text = "DrugBrand Is Successfully Updated";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('DrugBrand Is Successfully Updated','Information');", true);
                }
            }
            loadDrugBrand();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Brand Name", excep);
            //ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    protected void btnSaveOrganism_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            int Id = -1;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            OrganismMaster organismMaster = new OrganismMaster();
            if (HDOrganismMasterId.Value == "" || Convert.ToInt32(HDOrganismMasterId.Value) == 0)
            {
                organismMaster.Name = txtOrganismName.Text;
                organismMaster.Code = txtOrganismCode.Text;
                returnCode = investigationBL.InsertUpdateOrganismMaster(organismMaster, out Id);
                if (returnCode == 2)
                {
                    txtOrganismCode.Text = "";
                    txtOrganismName.Text = "";
                    HDOrganismMasterId.Value = "";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Is Successfully Added','Information');", true);
                    LoadOrganismMaster();
                }
                else
                {
                    txtOrganismCode.Text = "";
                    txtOrganismName.Text = "";
                    HDOrganismMasterId.Value = "";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Already Exists','Information');", true);
                }
            }
            else if (HDOrganismMasterId.Value != "" || Convert.ToInt32(HDOrganismMasterId.Value) > 0)
            {
                organismMaster.ID = Convert.ToInt64(HDOrganismMasterId.Value);
                organismMaster.Name = txtOrganismName.Text;
                organismMaster.Code = txtOrganismCode.Text;

                returnCode = investigationBL.InsertUpdateOrganismMaster(organismMaster, out Id);
                if (returnCode == 2)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Is Successfully Updated','Information');", true);
                    txtOrganismCode.Text = "";
                    txtOrganismName.Text = "";
                    HDOrganismMasterId.Value = "";
                    LoadOrganismMaster();
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Organism Master", excep);
        }
    }

    protected void gvFamilyMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                gvFamilyMaster.PageIndex = e.NewPageIndex;
                LoadFamilyMaster();
            }
        }
        catch (Exception ex)
        {
            gvOrganismMaster.PageIndex = 1;
            CLogger.LogError("Error in Organism Level Mapping page at gvOrganismMaster_PageIndexChanging", ex);
        }
    }

    protected void btnFamilyEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDFamilyMasterId");
            hdnFamilyId.Value = hiddenID.Value;
            txtFamilyName.Text = row.Cells[1].Text;
            txtFamilyCode.Text = row.Cells[2].Text;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnFamilyEdit_Click", ex);
        }
    }

    protected void btnFamilyInActive_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            int IsActive = -1;
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDFamilyMasterId");
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            returncode = investigationBL.GetIsActiveDrugFamilyList(Convert.ToInt64(hiddenID.Value), out IsActive);
            if (returncode == 1 && IsActive == 1)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnFamilyInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                // hiddenID.Value = "True";
                lnkbtnActive.Text = "Active";
            }
            else if (returncode == 1 && IsActive == 0)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnFamilyInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                //hiddenID.Value = "False";
                lnkbtnActive.Text = "InActive";
            }
            //sabari added
            /*Here Re-Load Famiy Master at the time of InActive /Active Family Master*/
            LoadFamilyMaster();
            //end sabari addd
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugInActive_Click", ex);
        }
    }

    protected void btnFamilyHistory_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDFamilyMasterId");
            if (!String.IsNullOrEmpty(hiddenID.Value))
            {
                LoadFamilyMasterHistory(Convert.ToInt64(hiddenID.Value));
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "javascript:FamilyHistory('divFamilyMasterHistory');", true);

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            int Id = -1;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            InvestigationDrugFamilyMaster investigationDrugFamilyMaster = new InvestigationDrugFamilyMaster();
            if (hdnFamilyId.Value == "" || Convert.ToInt32(hdnFamilyId.Value) == 0)
            {
                /*sabari added for duplicates filter*/
                long ReturnCodeExsiting = -1;
                var Familyname= txtFamilyName.Text;
                var Familycode=txtFamilyCode.Text;
                if (Familyname != "" && Familycode != "")
                {
                    Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
                    List<InvestigationDrugFamilyMaster> lstFamilyMasterFindExisting = new List<InvestigationDrugFamilyMaster>();
                    ReturnCodeExsiting = investigationbl.GetInvestigationDrugFamilyList(out lstFamilyMasterFindExisting);

                    var IsExisitFlag = lstFamilyMasterFindExisting.Where(n => n.Familyname == Familyname || n.Familycode == Familycode).ToList();

                    if (IsExisitFlag !=null && IsExisitFlag.Count ==0 && IsExisitFlag.Count < 1 )
                    {
                        investigationDrugFamilyMaster.Familyname = txtFamilyName.Text;
                        investigationDrugFamilyMaster.Familycode = txtFamilyCode.Text;
                        returnCode = investigationBL.InsertUpdateFamilyMaster(investigationDrugFamilyMaster, out Id);
                        if (returnCode >= 0)
                        {
                            txtFamilyCode.Text = "";
                            txtFamilyName.Text = "";
                            hdnFamilyId.Value = "";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Is Successfully Added','Information');", true);
                            LoadFamilyMaster();
                        }
                        else
                        {
                            txtFamilyCode.Text = "";
                            txtFamilyName.Text = "";
                            hdnFamilyId.Value = "";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Already Exists','Information');", true);
                        }
                    }
                    else
                    {
                        txtFamilyCode.Text = "";
                        txtFamilyName.Text = "";
                        hdnFamilyId.Value = "";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('FamilyName or FamilyCode Already Exists','Information');", true);

                    }
                }
            }
            else if (hdnFamilyId.Value != "" || Convert.ToInt32(hdnFamilyId.Value) > 0)
            {
                investigationDrugFamilyMaster.FamilyId = Convert.ToInt64(hdnFamilyId.Value);
                investigationDrugFamilyMaster.Familyname = txtFamilyName.Text;
                investigationDrugFamilyMaster.Familycode = txtFamilyCode.Text;

                returnCode = investigationBL.InsertUpdateFamilyMaster(investigationDrugFamilyMaster, out Id);
                if (returnCode == 2)
                {

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Is Successfully Updated','Information');", true);
                    txtFamilyCode.Text = "";
                    txtFamilyName.Text = "";
                    hdnFamilyId.Value = "";
                    LoadFamilyMaster();
                    //sabari added
                    /*Here we have added code for Reload Family Name into Drug Master Gird after Family Name Update*/
                    loadDrugBrand();
                    //end sabari added
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Family Master", excep);
        }
    }
    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
    protected void btnLevelMapEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDLevelID");
            hdnLevelID.Value = hiddenID.Value;
            txtLevelName.Text = row.Cells[2].Text;
            HiddenField hdnDrugID = (HiddenField)row.FindControl("hdnDrugID");
            ddlLevelMapDrugName.SelectedValue = hdnDrugID.Value;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LevelMapping Mapping btnLevelMapEdit_Click", ex);
        }
    }

    protected void btnLevelMapInActive_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            int IsActive = -1;
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDLevelID");
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            returncode = investigationBL.GetIsActiveDrugLevelMapping(Convert.ToInt64(hiddenID.Value), out IsActive);
            if (returncode == 2 && IsActive == 1)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnLvelMapInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                // hiddenID.Value = "True";
                lnkbtnActive.Text = "Active";
            }
            else if (returncode == 2 && IsActive == 0)
            {
                LinkButton lnkbtnActive = (LinkButton)row.FindControl("btnLvelMapInActive");
                lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                //hiddenID.Value = "False";
                lnkbtnActive.Text = "InActive";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugInActive_Click", ex);
        }
    }
    protected void btnAddLevelmap_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            int Id = -1;
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<DrugLevelMapping> lstDrugLevelMapping = new List<DrugLevelMapping>();
            if (hdnLevelID.Value == "" || Convert.ToInt32(hdnLevelID.Value) == 0)
            {
                
                DrugLevelMapping objDrugLevelMapping = new DrugLevelMapping();
                objDrugLevelMapping.DrugID = Convert.ToInt64(ddlLevelMapDrugName.SelectedItem.Value);
                objDrugLevelMapping.LevelName = txtLevelName.Text;
                lstDrugLevelMapping.Add(objDrugLevelMapping);
                returnCode = investigationBL.InsertUpdateDrugLevelMapping(lstDrugLevelMapping, out Id);
                if (returnCode >= 0)
                {
                    txtLevelName.Text = "";
                    hdnLevelID.Value = "";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Drug Level Is Successfully Added','Information');", true);
                    LoadLevelMappingDetails();
                }
                else
                {
                    txtLevelName.Text = "";
                    hdnLevelID.Value = "";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Drug Level Already Exists','Information');", true);
                }
            }
            else if (hdnLevelID.Value != "" || Convert.ToInt32(hdnLevelID.Value) > 0)
            {

                DrugLevelMapping objDrugLevelMapping = new DrugLevelMapping();
                objDrugLevelMapping.LevelID = Convert.ToInt64(hdnLevelID.Value);
                objDrugLevelMapping.DrugID = Convert.ToInt64(ddlLevelMapDrugName.SelectedItem.Value);
                objDrugLevelMapping.LevelName = txtLevelName.Text;
                lstDrugLevelMapping.Add(objDrugLevelMapping);
                returnCode = investigationBL.InsertUpdateDrugLevelMapping(lstDrugLevelMapping, out Id);
                if (returnCode == 2)
                {

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Level is Successfully Updated','Information');", true);
                    ddlLevelMapDrugName.SelectedItem.Value = "-1";
                    txtLevelName.Text = "";
                    hdnLevelID.Value = "";
                }
                LoadLevelMappingDetails();
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while saving Family Master", excep);
        }
    }
    /* END | sabari | 20181129 | Dev | Culture Report */
    protected void btnuploadFamily_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        try
        {
            if (fuFamilyBulkData.PostedFile != null)
            {
                if (fuFamilyBulkData.HasFile)
                {
                    long returnCode = -1;
                    int Id = -1;
                    Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                    InvestigationDrugFamilyMaster investigationDrugFamilyMaster = new InvestigationDrugFamilyMaster();
                    string FileName = System.IO.Path.GetFileName(fuFamilyBulkData.PostedFile.FileName);
                    string Extension = System.IO.Path.GetExtension(fuFamilyBulkData.PostedFile.FileName);
                    string FilePath = HttpContext.Current.Server.MapPath("~/ExcelTest/") + FileName;
                    fuFamilyBulkData.SaveAs(FilePath);
                    dt = Import_To_Grid(FilePath, Extension);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow item in dt.Rows)
                        {
                            investigationDrugFamilyMaster.Familyname = Convert.ToString(item[1]);
                            investigationDrugFamilyMaster.Familycode = Convert.ToString(item[2]);
                            returnCode = investigationBL.InsertUpdateFamilyMaster(investigationDrugFamilyMaster, out Id);
                            if (returnCode < 0)
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Import is failed.','Error');", true);
                                LoadFamilyMaster();
                                break;
                            }

                            //else
                            //{
                            //    txtFamilyCode.Text = "";
                            //    txtFamilyName.Text = "";
                            //    hdnFamilyId.Value = "";
                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Already Exists','Information');", true);
                            //}
                        }

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Import is completed successfully.','Information');", true);
                        LoadFamilyMaster();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('File is not containing Family details.','Information');", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at btnuploadFamily_Click", ex);
        }
    }

    private DataTable Import_To_Grid(string FilePath, string Extension)
    {
        DataTable dt = new DataTable();
        try
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03

                    conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=Excel 12.0;";
                    break;
                case ".xlsx": //Excel 07
                    conStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=Excel 12.0;";
                    break;
            }
            //conStr = String.Format(conStr, FilePath, "Yes");
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            cmdExcel.Connection = connExcel;
            //Get the name of First Sheet
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();
            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at Import_To_Grid", ex);
        }
        return dt;
    }

    protected void gvFamilyMaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HiddenField hiddenID = (HiddenField)e.Row.Cells[3].FindControl("HDFamilyMasterActive");
                if (hiddenID != null)
                {
                    if (hiddenID.Value == "True")
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnFamilyInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Green;
                        lnkbtnActive.Text = "Active";
                        // hiddenID.Value = "True";
                    }
                    else
                    {
                        LinkButton lnkbtnActive = (LinkButton)e.Row.Cells[3].FindControl("btnFamilyInActive");
                        lnkbtnActive.ForeColor = System.Drawing.Color.Red;
                        lnkbtnActive.Text = "InActive";
                        // hiddenID.Value = "False";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at gvFamilyMaster_RowDataBound", ex);
        }
    }

    protected void ibFamilyDownload_Click(object sender, ImageClickEventArgs e)
    {
        DownloadExcelTemplate("Family Template");
    }
    protected void imButtonDownloadBulkMaster_Click(object sender, ImageClickEventArgs e)
    {
        DownloadExcelTemplate("Organism Template");
    }
    protected void btnOrganismHistory_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("HDOrganismMasterId");
            if (!String.IsNullOrEmpty(hiddenID.Value))
            {
                LoadOrganismMasterHistory(Convert.ToInt64(hiddenID.Value));
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "javascript:FamilyHistory('divOrganismMasterHistory');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }
    protected void btnDrugMasterUpload_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        try
        {
            if (fpDrugMaster.PostedFile != null)
            {
                if (fpDrugMaster.HasFile)
                {
                    long returnCode = -1;
                    long Id = -1;

                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    InvestigationDrugBrand investigationDrugBrand = new InvestigationDrugBrand();
                    string FileName = System.IO.Path.GetFileName(fpDrugMaster.PostedFile.FileName);
                    string Extension = System.IO.Path.GetExtension(fpDrugMaster.PostedFile.FileName);
                    string FilePath = HttpContext.Current.Server.MapPath("~/ExcelTest/") + FileName;
                    fpDrugMaster.SaveAs(FilePath);
                    dt = Import_To_Grid(FilePath, Extension);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow item in dt.Rows)
                        {
                            investigationDrugBrand.BrandName = Convert.ToString(item[1]);
                            investigationDrugBrand.Code = Convert.ToString(item[2]);
                            investigationDrugBrand.FMID = GetFamilyId(Convert.ToString(item[3]));
                            returnCode = patientBL.SaveInvestigationDrugBrand(investigationDrugBrand, out Id);
                            if (returnCode < 0)
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Drug Brand Import is failed.','Error');", true);
                                loadDrugBrand();
                                break;
                            }

                            //else
                            //{
                            //    txtFamilyCode.Text = "";
                            //    txtFamilyName.Text = "";
                            //    hdnFamilyId.Value = "";
                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Already Exists','Information');", true);
                            //}
                        }

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Drug Brand Import is completed successfully.','Information');", true);
                        loadDrugBrand();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('File is not containing Drug Brand details.','Information');", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at btnDrugMasterUpload_Click", ex);
        }
    }
    protected void btnOrganismUploadBulkMaster_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        try
        {
            if (fpOrganismUploadBulkMaster.PostedFile != null)
            {
                if (fpOrganismUploadBulkMaster.HasFile)
                {
                    long returnCode = -1;
                    int Id = -1;
                    Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
                    OrganismMaster organismMaster = new OrganismMaster();
                    string FileName = System.IO.Path.GetFileName(fpOrganismUploadBulkMaster.PostedFile.FileName);
                    string Extension = System.IO.Path.GetExtension(fpOrganismUploadBulkMaster.PostedFile.FileName);
                    string FilePath = HttpContext.Current.Server.MapPath("~/ExcelTest/") + FileName;
                    fpOrganismUploadBulkMaster.SaveAs(FilePath);
                    dt = Import_To_Grid(FilePath, Extension);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow item in dt.Rows)
                        {
                            organismMaster.Name = Convert.ToString(item[1]);
                            organismMaster.Code = Convert.ToString(item[2]);
                            returnCode = investigationBL.InsertUpdateOrganismMaster(organismMaster, out Id);
                            if (returnCode < 0)
                            {
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Import is failed.','Error');", true);
                                LoadOrganismMaster();
                                break;
                            }

                            //else
                            //{
                            //    txtFamilyCode.Text = "";
                            //    txtFamilyName.Text = "";
                            //    hdnFamilyId.Value = "";
                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Family Already Exists','Information');", true);
                            //}
                        }

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Import is completed successfully.','Information');", true);
                        LoadOrganismMaster();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('File is not containing Organism details.','Information');", true);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at btnOrganismUploadBulkMaster_Click", ex);
        }
    }



    protected void tbFamilyMaster_Click(object sender, EventArgs e)
    {
        //tbFamilyMaster.Attributes.Add("class", "header active");
        //tbOrganismMapping.CssClass = "Initial";
        //tbOrganismMaster.CssClass = "Initial";
        //tbDrugMaster.CssClass = "Initial";
        tbFamilyMaster.BackColor = System.Drawing.Color.LightSeaGreen;
        tbDrugMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMapping.BackColor = System.Drawing.Color.LightSlateGray;
        tbLevelMaster.BackColor = System.Drawing.Color.LightSlateGray;
        MainView.ActiveViewIndex = 0;
    }
    protected void tbDrugMaster_Click(object sender, EventArgs e)
    {
        //tbFamilyMaster.CssClass = "Initial";
        //tbOrganismMapping.CssClass = "Initial";
        //tbOrganismMaster.CssClass = "Initial";
        //tbDrugMaster.Attributes.Add("class", "header active");
        tbFamilyMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbDrugMaster.BackColor = System.Drawing.Color.LightSeaGreen;
        tbOrganismMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMapping.BackColor = System.Drawing.Color.LightSlateGray;
        tbLevelMaster.BackColor = System.Drawing.Color.LightSlateGray;
        MainView.ActiveViewIndex = 1;

    }
    protected void tbOrganismMaster_Click(object sender, EventArgs e)
    {
        tbFamilyMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbDrugMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMaster.BackColor = System.Drawing.Color.LightSeaGreen;
        tbOrganismMapping.BackColor = System.Drawing.Color.LightSlateGray;
        tbLevelMaster.BackColor = System.Drawing.Color.LightSlateGray; ;
        MainView.ActiveViewIndex = 2;
    }
    protected void tbOrganismMapping_Click(object sender, EventArgs e)
    {
        tbFamilyMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbDrugMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMapping.BackColor = System.Drawing.Color.LightSeaGreen;
        tbLevelMaster.BackColor = System.Drawing.Color.LightSlateGray;
        loadMappingDetails();
        MainView.ActiveViewIndex = 3;
        txtDrugNameMapping.Enabled = true;
        btnGenerate.Visible = true;
        ddlOrganismName.Enabled = true;
        ddlDrugName.Enabled = true;
        LoadOrganismMaster();
        loadDrugBrand();
        ClearData();
    }
    protected void tbLevelMapping_Click(object sender, EventArgs e)
    {
        tbFamilyMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbDrugMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMaster.BackColor = System.Drawing.Color.LightSlateGray;
        tbOrganismMapping.BackColor = System.Drawing.Color.LightSlateGray;
        tbLevelMaster.BackColor = System.Drawing.Color.LightSeaGreen;
        MainView.ActiveViewIndex = 4;
    }
    protected void ddlDrugName_Click(object sender, EventArgs e)
    {
        loadDrugBrand();
        hdnSelectedId.Value = Convert.ToString(ViewState["SelectedId"]);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "javascript:DrugPopup('divdrug');", true);
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('Organism Import is failed.','Error');", true);
    }
    protected void chk_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void btnOk_Click(object sender, EventArgs e)
    {

        try
        {
            GenerateDrugMapping();

            //txtDrugNameMapping.Text = string.Empty;
            //ddlOrganismName.SelectedValue = "-1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at btnOk_Click", ex);
        }
    }

    private void GenerateDrugMapping()
    {
        string Ids = string.Empty;
        int count = 0;
        foreach (GridViewRow row in gvddlDrugBrand.Rows)  //getting each row
        {
            CheckBox Checkbox = row.FindControl("chk") as CheckBox;
            if (Checkbox.Checked == true)  // checking whether the checkbox is checked or not
            {
                HiddenField hiddenID = (HiddenField)row.FindControl("hdDrugIds");
                Ids += hiddenID.Value + ",";
                count++;
            }
        }
        hdnSelectedId.Value = Ids.TrimEnd(',');
        ViewState["SelectedId"] = Ids.TrimEnd(',');
        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "funcHistory", "alert('" + hdnSelectedId.Value + "');", true);

        // LoadDrugNames(Ids);

        if (!string.IsNullOrEmpty(ddlOrganismName.SelectedItem.Text) && !string.IsNullOrEmpty(hdnTestCode.Value) && Convert.ToInt32(hdnTestCode.Value) > 0 && count > 0)
        {
            LoadMappingData();
            if (count > 0)
            {
                ddlDrugName.Text = count + " Selected";
            }
        }
        else if (string.IsNullOrEmpty(ddlOrganismName.SelectedItem.Text))
        {
            if (count > 0)
            {
                ddlDrugName.Text = count + " Selected";
            }
            else
                ddlDrugName.Text = "-- Selected --";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Organism Name is Empty.','Information');", true);
        }
        else if (string.IsNullOrEmpty(hdnTestCode.Value) || Convert.ToInt32(hdnTestCode.Value) == 0)
        {
            if (count > 0)
            {
                ddlDrugName.Text = count + " Selected";
            }
            else
                ddlDrugName.Text = "-- Selected --";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Test Name is Empty.','Information');", true);
        }

        else if (count == 0)
        {
            ddlDrugName.Text = "-- Selected --";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Select Drug Names.','Information');", true);
        }
    }

    private void LoadMappingData()
    {
        try
        {
            DataRow dr;
            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(int));
            dt.Columns.Add("InvestigationID", typeof(int));
            dt.Columns.Add("InvestigationName", typeof(string));
            dt.Columns.Add("OrganismId", typeof(long));
            dt.Columns.Add("OrganismName", typeof(string));
            dt.Columns.Add("Drugs");
            dr = dt.NewRow();

            dr["ID"] = 0;
            dr["InvestigationID"] = Convert.ToInt32(hdnTestCode.Value);
            dr["InvestigationName"] = txtDrugNameMapping.Text == string.Empty ? hdnTestName.Value : txtDrugNameMapping.Text;
            dr["OrganismName"] = ddlOrganismName.SelectedItem.Text;
            dr["OrganismId"] = ddlOrganismName.SelectedValue;
            dr["Drugs"] = "";

            dt.Rows.Add(dr);

            if (dt != null && dt.Rows.Count > 0)
            {
                gvOrgMapping.DataSource = dt;
                gvOrgMapping.DataBind();
            }
            else
            {
                gvOrgMapping.DataSource = null;
                gvOrgMapping.DataBind();
                //gvOrgMapping.EmptyDataText = "";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at LoadMappingData", ex);
        }
    }

    private DataTable LoadDrugNames()
    {
        DataTable dtValues = new DataTable();
        try
        {
            loadDrugBrand();

            string[] id = null;
            id = hdnSelectedId.Value.Split(',');
            List<InvestigationDrugBrand> drugbrand = new List<InvestigationDrugBrand>();
            foreach (string item in id)
            {
                if (!string.IsNullOrEmpty(item))
                    drugbrand.Add(lstInvestigationDrugBrand.SingleOrDefault(s => s.DrugID == Convert.ToInt64(item)));
            }

            dtValues = ToDataTable(drugbrand);
            if (dtValues != null && dtValues.Rows.Count > 0)
            {
                if (!dtValues.Columns.Contains("SeqNo"))
                {
                    dtValues.Columns.Add("SeqNo");
                }
                int seq = 1;
                foreach (DataRow item in dtValues.Rows)
                {
                    item["SeqNo"] = seq;
                    seq++;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at LoadDrugNames method", ex);
        }

        return dtValues;
    }
    protected void gvOrgMapping_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            DataTable data = new DataTable();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView innerGrid = (GridView)e.Row.FindControl("gvOrgMappingDrug");
                data = LoadDrugNames();
                innerGrid.DataSource = data;
                innerGrid.DataBind();

                ImageButton lnkUp = (innerGrid.Rows[0].FindControl("btnUp") as ImageButton);
                ImageButton lnkDown = (innerGrid.Rows[innerGrid.Rows.Count - 1].FindControl("btnDown") as ImageButton);
                lnkUp.Enabled = false;
                lnkUp.CssClass = "button disabled";
                lnkDown.Enabled = false;
                lnkDown.CssClass = "button disabled";
                ViewState["Reckonn"] = data;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at gvOrgMapping_RowDataBound", ex);
            throw;
        }
    }

    public DataTable ToDataTable<T>(List<T> items)
    {
        DataTable dataTable = new DataTable(typeof(T).Name);
        try
        {
            //Get all the properties by using reflection   
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names  
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {

                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Level Mapping page at ToDataTable method", ex);
        }
        return dataTable;
    }



    protected void gvOrgMappingDrug_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int Index = ((GridViewRow)((sender as Control)).NamingContainer).RowIndex;
            GridView innerGrid = (gvOrgMapping.Rows[Index].FindControl("gvOrgMappingDrug") as GridView);
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int count = innerGrid.Rows.Count;
            if (dtt != null && dtt.Rows.Count > 0)
            {
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempDtlID = dtt.Rows[selRow]["DrugID"].ToString();
                        string strTempBrandName = dtt.Rows[selRow]["BrandName"].ToString();
                        //string strTempCode = dtt.Rows[selRow]["Code"].ToString().ToUpper();
                        dtt.Rows[selRow]["DrugID"] = dtt.Rows[swapRow]["DrugID"];
                        dtt.Rows[selRow]["BrandName"] = dtt.Rows[swapRow]["BrandName"];
                        // dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
                        dtt.Rows[swapRow]["BrandName"] = strTempBrandName;
                        dtt.Rows[swapRow]["DrugID"] = strTempDtlID;
                        // dtt.Rows[swapRow]["Code"] = strTempCode;
                        innerGrid.DataSource = dtt;
                        innerGrid.DataBind();
                    }
                    if (selRow > 0)
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + up + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved UP !!');", true);
                    }
                }
                else if (e.CommandName == "DOWN")
                {
                    if (selRow < dtt.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;
                        string strTempDtlID = dtt.Rows[selRow]["DrugID"].ToString();
                        string strTempBrandName = dtt.Rows[selRow]["BrandName"].ToString();
                        //string strTempCode = dtt.Rows[selRow]["Code"].ToString().ToUpper();
                        dtt.Rows[selRow]["DrugID"] = dtt.Rows[swapRow]["DrugID"];
                        dtt.Rows[selRow]["BrandName"] = dtt.Rows[swapRow]["BrandName"];
                        //dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
                        dtt.Rows[swapRow]["BrandName"] = strTempBrandName;
                        dtt.Rows[swapRow]["DrugID"] = strTempDtlID;
                        //dtt.Rows[swapRow]["Code"] = strTempCode;
                        innerGrid.DataSource = dtt;
                        innerGrid.DataBind();
                    }
                    if (selRow < dtt.Rows.Count - 1)
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + down + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved DOWN !!');", true);
                    }
                }
                //if (e.CommandName == "Move")
                //{
                //    foreach (GridViewRow GR in GrdDept.Rows)
                //    {
                //        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                //        if (rdb.Checked)
                //        {
                //            rowindex = GR.RowIndex;
                //            if (rowindex > selRow)
                //            {
                //                for (int i = rowindex; i > selRow; i--)
                //                {
                //                    string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
                //                    string strTempValue = dtt.Rows[i]["DeptName"].ToString();
                //                    string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
                //                    dtt.Rows[i]["DeptID"] = dtt.Rows[i - 1]["DeptID"];
                //                    dtt.Rows[i]["DeptName"] = dtt.Rows[i - 1]["DeptName"];
                //                    dtt.Rows[i]["Code"] = dtt.Rows[i - 1]["Code"];
                //                    dtt.Rows[i - 1]["DeptID"] = strTempDtlID;
                //                    dtt.Rows[i - 1]["DeptName"] = strTempValue;
                //                    dtt.Rows[i - 1]["Code"] = strTempCode;
                //                }
                //            }
                //            else if (rowindex < selRow)
                //            {
                //                for (int i = rowindex; i < selRow; i++)
                //                {
                //                    string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
                //                    string strTempValue = dtt.Rows[i]["DeptName"].ToString();
                //                    string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
                //                    dtt.Rows[i]["DeptID"] = dtt.Rows[i + 1]["DeptID"];
                //                    dtt.Rows[i]["DeptName"] = dtt.Rows[i + 1]["DeptName"];
                //                    dtt.Rows[i]["Code"] = dtt.Rows[i + 1]["Code"];
                //                    dtt.Rows[i + 1]["DeptID"] = strTempDtlID;
                //                    dtt.Rows[i + 1]["DeptName"] = strTempValue;
                //                    dtt.Rows[i + 1]["Code"] = strTempCode;
                //                }
                //            }
                //            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                //            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved !!');", true);
                //            GrdDept.DataSource = dtt;
                //            GrdDept.DataBind();
                //        }

                //    }
                //}
            }
            ImageButton lnkUp = (innerGrid.Rows[0].FindControl("btnUp") as ImageButton);
            ImageButton lnkDown = (innerGrid.Rows[innerGrid.Rows.Count - 1].FindControl("btnDown") as ImageButton);
            lnkUp.Enabled = false;
            lnkUp.CssClass = "button disabled";
            lnkDown.Enabled = false;
            lnkDown.CssClass = "button disabled";
            ViewState["Reckonn"] = dtt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Organism Level Mapping page at GrdDept_RowCommand", ex);
        }
    }
    protected void btnOrgnismSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;

            Investigation_BL investigationbl = new Investigation_BL(base.ContextInfo);
            DataTable dtt = (DataTable)ViewState["Reckonn"];

            HiddenField hdnTestId = (gvOrgMapping.Rows[0].FindControl("HDOrgaanismTestId") as HiddenField);
            HiddenField hdnOrganismId = (gvOrgMapping.Rows[0].FindControl("HDOrgaanismId") as HiddenField);
            // HiddenField hdnOrganismMappingId = (gvOrgMapping.Rows[0].FindControl("hdnOrganismMappingId") as HiddenField);
            DataTable dtOrganismMapping = new DataTable();
            dtOrganismMapping = ConstructDataTable();
            // DataRow dr = dtOrganismMapping.NewRow();

            foreach (DataRow item in dtt.Rows)
            {
                DataRow dr = dtOrganismMapping.NewRow();

                dr["MappingId"] = Convert.ToInt64(hdnAddOrEdit.Value);
                dr["DrugId"] = Convert.ToInt32(item["DrugId"]);
                dr["InvestigationId"] = Convert.ToInt32(hdnTestId.Value);
                dr["SequenceNo"] = Convert.ToInt32(item["SeqNo"]);
                dr["OrganismId"] = Convert.ToInt32(hdnOrganismId.Value);
                dtOrganismMapping.Rows.Add(dr);
            }

            returncode = investigationbl.InsertUpdateOrganismMapping(0, dtOrganismMapping);
            if (returncode > 0)
            {
                hdnAddOrEdit.Value = "0";
                hdnTestCode.Value = "0";
                hdnTestId.Value = "0";
                hdnSelectedId.Value = null;
                ViewState["SelectedId"] = null;
                txtDrugNameMapping.Text = string.Empty;
                ddlOrganismName.SelectedValue = "-1";
                ddlDrugName.Text = "-- Select --";
                gvOrgMapping.DataSource = null;
                gvOrgMapping.DataBind();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('Organism Mapping saved successfully.','Information');", true);
                loadMappingDetails();
                txtDrugNameMapping.Enabled = true;
                ddlOrganismName.Enabled = true;
                ddlDrugName.Enabled = true;
                btnGenerate.Visible = true;
            }
            else
            {
                txtDrugNameMapping.Enabled = true;
                ddlOrganismName.Enabled = true;
                ddlDrugName.Enabled = true;
                btnGenerate.Visible = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('Organism Mapping not saved successfully.','Error');", true);
            }

            //dr[""] = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Organism Level Mapping page at btnOrgnismSave_Click", ex);
        }
    }

    protected DataTable ConstructDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("MappingId", typeof(long));
        dt.Columns.Add("InvestigationId", typeof(Int32));
        dt.Columns.Add("OrganismId", typeof(Int32));
        dt.Columns.Add("DrugId", typeof(Int32));
        dt.Columns.Add("SequenceNo", typeof(Int32));
        return dt;
    }
    protected void gvDrugSubGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void gvDrugSubGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void gvDrugMappingGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            long returnCode = -1;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // string customerId = gvDrugMappingGrid.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView gvDrugs = e.Row.FindControl("gvOrgMappingDrugsubgrid") as GridView;

                List<InvestigationDrugBrand> lstDrug = new List<InvestigationDrugBrand>();
                Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
                HiddenField HDOrgaanismId = (HiddenField)e.Row.FindControl("HDOrgaanismId");
                HiddenField HDOrgaanismTestId = (HiddenField)e.Row.FindControl("HDOrgaanismTestId");
                HiddenField hdnMappedDrugId = (HiddenField)e.Row.FindControl("hdnMappedDrugId");

                List<InvestigationDrugBrand> drugbrand = new List<InvestigationDrugBrand>();
                string[] id = null;
                id = hdnSelectedId.Value.Split(',');
                if (!string.IsNullOrEmpty(HDOrgaanismId.Value) && !string.IsNullOrEmpty(HDOrgaanismId.Value))
                {
                    InvestigationBL.GetMappedDrugBrand(Convert.ToInt64(HDOrgaanismId.Value), Convert.ToInt64(HDOrgaanismTestId.Value), out drugbrand);
                    if (drugbrand.Count > 0)
                    {
                        gvDrugs.DataSource = drugbrand;
                        gvDrugs.DataBind();
                        hdnMappedDrugId.Value = GetMappedIds(drugbrand);
                        //hdnTestName.Value = drugbrand[0].LoginName;
                    }
                    else
                    {
                        gvDrugs.DataSource = null;
                        gvDrugs.DataBind();
                    }

                }
                else
                {
                    gvDrugs.DataSource = null;
                    gvDrugs.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdSigMapLoc_OnRowDataBound", ex);
        }
    }

    protected string GetMappedIds(List<InvestigationDrugBrand> listvalues)
    {
        string value = string.Empty;
        if (listvalues.Count > 0)
        {
            foreach (InvestigationDrugBrand item in listvalues)
            {
                value += item.DrugID + ",";
            }
            value = value.TrimEnd(',');
        }
        return value;
    }

    protected void btnMappedEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvestigationDrugBrand> drugbrand = new List<InvestigationDrugBrand>();
            hdnAddOrEdit.Value = "1";
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            // assuming you store the ID in a Hiddenield:
            HiddenField hiddenID = (HiddenField)row.FindControl("hdnMappedDrugId");
            HiddenField HDOrgaanismId = (HiddenField)row.FindControl("HDOrgaanismId");
            HiddenField hdnInvestigation = (HiddenField)row.FindControl("HDOrgaanismTestId");

            if (!String.IsNullOrEmpty(HDOrgaanismId.Value))
            {
                ddlOrganismName.SelectedValue = HDOrgaanismId.Value;
            }
            if (!String.IsNullOrEmpty(hdnInvestigation.Value))
            {
                hdnTestCode.Value = hdnInvestigation.Value;
                hdnInvestigation.Value = hdnInvestigation.Value;
                InvestigationBL.GetMappedDrugBrand(Convert.ToInt64(HDOrgaanismId.Value), Convert.ToInt64(hdnInvestigation.Value), out drugbrand);
                if (drugbrand.Count() > 0)
                    txtDrugNameMapping.Text = drugbrand[0].LoginName;
            }
            if (!String.IsNullOrEmpty(hiddenID.Value))
            {
                ViewState["SelectedId"] = hiddenID.Value;
                hdnSelectedId.Value = hiddenID.Value;
                LoadMappingData();
                ddlDrugName.Text = hiddenID.Value.Split(',').Count() + " Selected";
                //txtDrugNameMapping.Text = drugbrand[0].LoginName;
            }
            txtDrugNameMapping.Enabled = false;
            btnGenerate.Visible = false;
            ddlOrganismName.Enabled = false;
            ddlDrugName.Enabled = false;
            //LoadMappingData();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }

    protected void btnMappingClear_Click(object sender, EventArgs e)
    {
        try
        {
            ClearData();
            txtDrugNameMapping.Enabled = true;
            btnGenerate.Visible = true;
            ddlOrganismName.Enabled = true;
            ddlDrugName.Enabled = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Organism Mapping level page at btnDrugEdit_Click", ex);
        }
    }

    protected void ClearData()
    {
        hdnAddOrEdit.Value = "0";
        ddlOrganismName.SelectedValue = "-1";
        txtDrugNameMapping.Text = string.Empty;
        ViewState["SelectedId"] = null;
        hdnSelectedId.Value = null;
        hdnTestCode.Value = null;
        hdnTestName.Value = null;
        ddlDrugName.Text = "--Select--";
        gvOrgMapping.DataSource = null;
        gvOrgMapping.DataBind();
    }


    protected void ibFamilyExportDownload_Click(object sender, EventArgs e)
    {
        try
        {
            gvFamilyMaster.AllowPaging = false;
            gvFamilyMaster.Columns[3].Visible = false;
            gvFamilyMaster.Columns[4].Visible = false;
            LoadFamilyMaster();

            if (lstFamilyMaster.Count > 0)
            {
                gvFamilyMaster.DataSource = lstFamilyMaster;
                gvFamilyMaster.DataBind();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sa", "alert('Record is not available to download.');", true);
            }

            ExportToExcel("Family Master", gvFamilyMaster);
            gvFamilyMaster.AllowPaging = true;
            gvFamilyMaster.Columns[4].Visible = true;
            gvFamilyMaster.Columns[5].Visible = true;
            gvFamilyMaster.DataSource = lstFamilyMaster;

            gvFamilyMaster.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }

    protected void imDrugMasterExportDownload_Click(object sender, EventArgs e)
    {
        try
        {
            gvDrugMaster.AllowPaging = false;
            gvDrugMaster.Columns[3].Visible = false;
            gvDrugMaster.Columns[4].Visible = false;
            loadDrugBrand();

            if (lstInvestigationDrugBrand.Count > 0)
            {
                gvDrugMaster.DataSource = lstInvestigationDrugBrand;
                gvDrugMaster.DataBind();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sa", "alert('Record is not available to download.');", true);
            }

            ExportToExcel("Drug Master", gvDrugMaster);
            // gvDrugMaster.AllowPaging = true;
            // gvDrugMaster.Columns[3].Visible = true;
            // gvDrugMaster.Columns[4].Visible = true;
            // gvDrugMaster.DataSource = lstInvestigationDrugBrand;

            gvDrugMaster.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }

    protected void imButtonExportBulkMaster_Click(object sender, EventArgs e)
    {
        try
        {
            gvOrganismMaster.AllowPaging = false;
            gvOrganismMaster.Columns[3].Visible = false;
            gvOrganismMaster.Columns[4].Visible = false;
            LoadOrganismMaster();

            if (lstOrganismMaster.Count > 0)
            {
                gvOrganismMaster.DataSource = lstOrganismMaster;
                gvOrganismMaster.DataBind();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sa", "alert('Record is not available to download.');", true);
            }

            ExportToExcel("Organism Master", gvOrganismMaster);
            gvOrganismMaster.AllowPaging = true;
            gvOrganismMaster.Columns[3].Visible = true;
            gvOrganismMaster.Columns[4].Visible = true;
            gvOrganismMaster.DataSource = lstOrganismMaster;

            gvOrganismMaster.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }

    protected void gvDrugMappingGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != null)
            {
                gvDrugMappingGrid.PageIndex = e.NewPageIndex;
                loadMappingDetails();
            }
        }
        catch (Exception ex)
        {
            gvOrganismMaster.PageIndex = 1;
            CLogger.LogError("Error in Organism Level Mapping page at gvOrganismMaster_PageIndexChanging", ex);
        }
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GenerateDrugMapping();
    }

}