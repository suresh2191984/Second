using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;
using System.IO;
using System.Data;
using Attune.Podium.BusinessEntities.CustomEntities;

public partial class Admin_ManagePackages : BasePage
{
    string strselect = Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_01 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_01;
    string stradd = Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_27 == null ? "Add" : Resources.Admin_ClientDisplay.Admin_InvRefRanges_aspx_27;
    string strupdate = Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_09 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_09;
    public Admin_ManagePackages()
        : base("Admin_ManagePackages_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string ModifiedBy = string.Empty;
    List<InvOrgGroup> lstorgroup = new List<InvOrgGroup>();
    List<InvOrgGroup> lstPackages = new List<InvOrgGroup>();
    Investigation_BL investigationBL = new Investigation_BL();
    List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
    List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
    List<InvGroupMaster> lstgroupsIC = new List<InvGroupMaster>();
    List<InvestigationMaster> lstInvestigationsIC = new List<InvestigationMaster>();
    List<InvPackageMapping> lstPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
    List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<InvPackageMapping> lstCollectedPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstDeletedPackageMapping = new List<InvPackageMapping>();
    List<ProcedureMaster> lstCollectedProcedures = new List<ProcedureMaster>();
    List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();

    string strAlert = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
         strAlert = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_Alert;

        if (!IsPostBack)
        {
            InvestigationControl1.IsMappingtems = "Y";
            LoadMetaData();
            LoadScheduleType();
            btnsearch_Click(sender, e);
            //LoadSpecialityName();
           // GetProcedureData();
            string CodingScheme = GetConfigValue("CodingScheme", OrgID);
            if (CodingScheme == "Y")
            {
                loadCodingSchemaName();
            }
            //new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroupsIC, out lstInvestigationsIC);
            //InvestigationControl1.LoadDatas(lstgroupsIC, lstInvestigationsIC);

        }
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
    protected void btnsave_Click(object sender, EventArgs e)
    {
        string strExits = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_06 == null ? "Name Already Exists!" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_06;

        string PackageName = txtpackagename.Text;
        string packagecode = string.Empty;
        //string packagecode = txtpackagecode.Text;
        long retcode = -1;
        if (btnsave.Text == strupdate)
        {
            Update();
            Clear();
        }
        else
        {
            try
            {

                retcode = investigationBL.GetHealthPackageDataName(OrgID, PackageName, packagecode, out lstPackages, out lstorgroup);
                if (lstorgroup.Count > 0)
                {
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Name Already Exists!');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strExits + "','" + strAlert + "');", true);
                    Clear();
                }
                //else if (lstPackages.Count > 0)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('PackageCode Already Exists!');", true);
                //    txtpackagecode.Text = string.Empty;
                //}
                else
                {
                    if (btnsave.Text == stradd)
                    {
                        show();
                        Clear();
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading SaveInvestigationGrpName", ex);
            }

        }
        if (txtpackagename.Text.Length > 0)
        {

        }
        else
        {
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpackagename.Focus();
    }
    public void Clear()
    {
        txtpackagename.Text = String.Empty;
        txtremarks.Text = string.Empty;
        //txtpackagecode.Text = string.Empty;
        //ddlstatus.SelectedValue = "0";
        ddlstatus.SelectedValue = null;
        ddlGender1.SelectedValue = "0";
        ddlScheduleType.SelectedValue = "-1";
        chkServiceTax.Checked = false;
        chkPrintSeparately.Checked = false;
        chkIsTransfer.Checked = false;//////////////////////////
        ddlTestCategory.SelectedValue = "0";
        hdnpkgid.Value = "";
        txtBillingName.Text = "";
        foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
        {
            (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text = string.Empty;
        }
    }
    public void show()
    {
        string strAdded = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_07 == null ? "Package Added Successfully!" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_07;
        string strCodeName = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_08 == null ? "PackageName or CodeName AlreadyExists!!!" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_08;

        try
        {

            string[] Codeschemelabels = new string[grdInvCodingScheme.Rows.Count];
            string[] CodeSchemeNames = new string[grdInvCodingScheme.Rows.Count];
            string[] CodeMasterId = new string[grdInvCodingScheme.Rows.Count];
            int i = 0;
            int CutOffTimeValue = 0;
            int CutOffTimeValue1 = 0;
            string CutOffTimeType = string.Empty;

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
            string groupName = txtpackagename.Text;
            string BillingName = txtBillingName.Text;
            string GroupCode = string.Empty;
            string remarks = txtremarks.Text;
            string Status = ddlstatus.SelectedItem.Value;
            string Pkgcode = string.Empty;
            string Gender = (String.IsNullOrEmpty(ddlGender1.SelectedItem.Value) || ddlGender1.SelectedIndex == 0) ? string.Empty : ddlGender1.SelectedItem.Value;
             
            string IsServiceTaxable = chkServiceTax.Checked ? "Y" : "N";
            string printSeparately = chkPrintSeparately.Checked ? "Y" : "N";
            long returnCode = -1;
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            string type = "PKG";
            int ddlCase = 4;
            int iDptId = 0;
            long lHeader = 0;

            if (!String.IsNullOrEmpty(txtCutOffValue.Text) && ddlCutOffType.Items.Count > 0)
            {
                Int32.TryParse(txtCutOffValue.Text, out CutOffTimeValue1);
                CutOffTimeValue = CutOffTimeValue1;
                CutOffTimeType = ddlCutOffType.SelectedItem.Value;
            }

            InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
            objGpMas.OrgID = OrgID;
            objGpMas.DeptID = 0;
            objGpMas.HeaderID = 0;
            if (ddlTestCategory.Items.Count > 0)
            {
                 objGpMas.SubCategory = (String.IsNullOrEmpty(ddlTestCategory.SelectedItem.Value) || ddlTestCategory.SelectedIndex == 0) ? string.Empty : ddlTestCategory.SelectedItem.Value;
            }


            short IsTATrandom = 0;
            if (ddlScheduleType.SelectedValue != "-1")
            {
                IsTATrandom = Convert.ToInt16((ddlScheduleType.SelectedValue));
            }

             bool IsPkgTransfer  = chkIsTransfer.Checked ? true : false;
            
            objMap.Add(objGpMas);
            returnCode = ObjInv.SaveInvestigationGrpName(objMap, groupName, BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, Status, Pkgcode, printSeparately, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, Gender, IsServiceTaxable, IsTATrandom, IsPkgTransfer);

            if (returnCode >= 0)
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Package Added Successfully!');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strAdded + "','" + strAlert + "');", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('PackageName or CodeName AlreadyExists!!!');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strCodeName + "','" + strAlert + "');", true);
            }
            foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
            {
                (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text = string.Empty;
            }
            txtCutOffValue.Text = string.Empty;
            ddlCutOffType.SelectedIndex = 0;
            Clear();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading show()", ex);
        }
    }
    public void Update()
    {
        string strChange = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_09 == null ? "Changes Saved Successfully!" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_09;

        long RetCode = -1;
        InvOrgGroup objgrppackages = new InvOrgGroup();
        Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);

        string[] Codeschemelabels = new string[grdInvCodingScheme.Rows.Count];
        string[] CodeSchemeNames = new string[grdInvCodingScheme.Rows.Count];
        string[] CodeMasterId = new string[grdInvCodingScheme.Rows.Count];
        int i = 0;
        int CutOffTimeValue = 0;
        int CutOffTimeValue1 = 0;
        string CutOffTimeType = string.Empty;
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
         //if (Codeschemelabels[j] == "1")
         //   {
         //       dtCodingSchemeMaster.Rows.Add(dr);
         //       dtCodingSchemeMaster.AcceptChanges();
         //   }

        }
        objgrppackages.DisplayText = txtpackagename.Text;
        objgrppackages.OrgGroupID = Convert.ToInt32(hdnpkgid.Value);
        objgrppackages.OrgID = OrgID;
        objgrppackages.Status = ddlstatus.SelectedValue;
        objgrppackages.Remarks = txtremarks.Text;
        objgrppackages.BillingName = txtBillingName.Text;
        objgrppackages.Packagecode = CodeSchemeNames[0].ToString();
        objgrppackages.ModifiedBy = RoleID;
        objgrppackages.PrintSeparately = chkPrintSeparately.Checked ? "Y" : "N";
        objgrppackages.Gender = (String.IsNullOrEmpty(ddlGender1.SelectedItem.Value) || ddlGender1.SelectedIndex == 0) ? string.Empty : ddlGender1.SelectedItem.Value;
        //objgrppackages.Gender = ddlGender1.SelectedValue;
        objgrppackages.IsServicetaxable = chkServiceTax.Checked ? "Y" : "N";
        //ContextInfo.AdditionalInfo = chkIsTransfer.Checked ? "Y" : "N";

        //ContextDetails objContextInfo = base.ContextInfo;
        //ContextInfo.AdditionalInfo = chkIsTransfer.Checked ? "Y" : "N";
        objgrppackages.IsPkgTransfer = chkIsTransfer.Checked ? true : false;

        if (!String.IsNullOrEmpty(txtCutOffValue.Text) && ddlCutOffType.Items.Count > 0)
        {
            Int32.TryParse(txtCutOffValue.Text, out CutOffTimeValue1);
            CutOffTimeValue = CutOffTimeValue1;
            CutOffTimeType = ddlCutOffType.SelectedItem.Value;
        }
        String SubCategory = String.Empty;
        if (ddlTestCategory.Items.Count > 0)
        {
             SubCategory = (String.IsNullOrEmpty(ddlTestCategory.SelectedItem.Value) || ddlTestCategory.SelectedIndex == 0) ? string.Empty : ddlTestCategory.SelectedItem.Value;
        }

        short IsTATrandom = 0;
        if (ddlScheduleType.SelectedValue != "-1")
        {
            IsTATrandom = Convert.ToInt16((ddlScheduleType.SelectedValue));
        }
            

        RetCode = investigationBL.Updatepackages(objgrppackages, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType, SubCategory,IsTATrandom);
        if (RetCode >= 0)
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strChange + "','" + strAlert + "');", true);
        }
        else
        {
            string strCodeName = Resources.Admin_AppMsg.Admin_ManagePackages_aspx_08 == null ? "PackageName or CodeName AlreadyExists!!!" : Resources.Admin_AppMsg.Admin_ManagePackages_aspx_08;

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('PackageName or Code Already Exists!!!');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:ValidationWindow('" + strCodeName + "','" + strAlert + "');", true);
        }
        foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
        {
            (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text = string.Empty;
        }
        txtCutOffValue.Text = string.Empty;
        ddlCutOffType.SelectedIndex = 0;
        btnsave.Text = stradd;
        Clear();
    }
    protected void grdpackages_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "Mapping")
            {
                UpdateProgress1.Visible=true;
                string isactivestatus = Convert.ToString(e.CommandArgument);
                string[] arg = new string[2];
                arg = isactivestatus.Split(',');
                int ID = Convert.ToInt32(arg[0]);
                hdnpkgid.Value = arg[0];
                int contentid = ID;
                string Name = Convert.ToString(arg[1]);
                if (ID != -1)
                {
                    testNameHDN.Value = string.Empty;
                    ModelPopPackageSearch.Show();
                    LoadPackageData();
                    LoadExtraSamplesForPackage();
                }
            }
            if (e.CommandName == "Select")
            {
                btnsave.Text = strupdate;
                short ScheduleType=0;
                string TestCategory = string.Empty;
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                hdnpkgid.Value = grdpackages.DataKeys[rowIndex]["OrgGroupID"] != null ? Convert.ToString(grdpackages.DataKeys[rowIndex]["OrgGroupID"]) : string.Empty;
                txtpackagename.Text = grdpackages.DataKeys[rowIndex]["DisplayText"] != null ? (string)grdpackages.DataKeys[rowIndex]["DisplayText"] : string.Empty;
                ddlstatus.SelectedValue = grdpackages.DataKeys[rowIndex]["Status"] != null ? (string)grdpackages.DataKeys[rowIndex]["Status"] : string.Empty;
                txtremarks.Text = grdpackages.DataKeys[rowIndex]["Remarks"] != null ? (string)grdpackages.DataKeys[rowIndex]["Remarks"] : string.Empty;
                //txtpackagecode.Text = grdpackages.DataKeys[rowIndex]["Packagecode"] != null ? (string)grdpackages.DataKeys[rowIndex]["Packagecode"] : string.Empty;
                string printSeparately = grdpackages.DataKeys[rowIndex]["PrintSeparately"] != null ? (string)grdpackages.DataKeys[rowIndex]["PrintSeparately"] : string.Empty;
                chkPrintSeparately.Checked = String.IsNullOrEmpty(printSeparately) ? false : printSeparately == "Y" ? true : false;
                txtCutOffValue.Text = grdpackages.DataKeys[rowIndex]["CutOffTimeValue"] != null ? Convert.ToString(grdpackages.DataKeys[rowIndex]["CutOffTimeValue"]) : string.Empty;
                ddlCutOffType.SelectedValue = (grdpackages.DataKeys[rowIndex]["CutOffTimeType"] != null && grdpackages.DataKeys[rowIndex]["CutOffTimeType"] != "") ? (string)grdpackages.DataKeys[rowIndex]["CutOffTimeType"] : "H";
                ddlGender1.SelectedValue = (grdpackages.DataKeys[rowIndex]["Gender"] != null && grdpackages.DataKeys[rowIndex]["Gender"] != "") ? (string)grdpackages.DataKeys[rowIndex]["Gender"] : "0";
                string IsServicetaxable = grdpackages.DataKeys[rowIndex]["IsServicetaxable"] != null ? (string)grdpackages.DataKeys[rowIndex]["IsServicetaxable"] : string.Empty;
                chkServiceTax.Checked = string.IsNullOrEmpty(IsServicetaxable) ? false : IsServicetaxable == "Y" ? true : false;
                TestCategory = Convert.ToString(grdpackages.DataKeys[rowIndex]["SubCategory"]);
                txtBillingName.Text = grdpackages.DataKeys[rowIndex]["BillingName"] != null ? Convert.ToString(grdpackages.DataKeys[rowIndex]["BillingName"]) : string.Empty;
                //string IspkgTransfer = grdpackages.DataKeys[rowIndex]["IsPkgTransfer"] != null ? (string)grdpackages.DataKeys[rowIndex]["IsPkgTransfer"] : string.Empty;
                bool IspkgTransfer = grdpackages.DataKeys[rowIndex]["IsPkgTransfer"] != null ? (bool)grdpackages.DataKeys[rowIndex]["IsPkgTransfer"] : false;
                if (IspkgTransfer == true)
                {
                    chkIsTransfer.Checked = true;
                }
                else
                {
                    chkIsTransfer.Checked = false;
                }
                if (!String.IsNullOrEmpty(TestCategory) && TestCategory.Length > 0)
                {
                    ddlTestCategory.SelectedValue = TestCategory;
                }               
                
                ScheduleType = Convert.ToInt16(grdpackages.DataKeys[rowIndex]["IsTATrandom"]);
                ddlScheduleType.SelectedValue = ScheduleType.ToString();
               // ScheduleType = grdpackages.DataKeys[rowIndex]["IsTATrandom"] != null ? (short)grdpackages.DataKeys[rowIndex]["IsTATrandom"]: Convert.ToInt16("0");                
                loadCodingSchemaName();
                txtpackagename.Focus();
            }
            if (e.CommandName == "Package Name")
            {

                ShowHideGrid.Visible = true;
                   UpdateProgress1.Visible = true;
                string isactivestatus = Convert.ToString(e.CommandArgument);
                string[] arg = new string[2];
                arg = isactivestatus.Split(',');
                int ID = Convert.ToInt32(arg[0]);
                hdnpkgid.Value = arg[0];
                List<PackageDetails> lstPkgdetails=new List<PackageDetails> ();

                Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
                long rcode=invbl.getPakageDetails(ID, out lstPkgdetails);
                if (lstPkgdetails.Count > 0)
                {

                    GridContent.DataSource = lstPkgdetails;
                    GridContent.DataBind();
                    GridContent.Visible = true;
                    btnclose.Style.Add("display", "block");

                }
                else 
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Package Content Is Empty')", true);
                    
                    GridContent.Visible = false;
                    btnclose.Style.Add("display", "none");
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading GetPackagesearch()", ex);
        }
    }
    protected void grdpackages_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdpackages.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            btnsearch_Click(sender, e);
        }
    }
    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL().GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);
        listSpeciality.DataSource = lstSpeciality;
        listSpeciality.DataTextField = "SpecialityName";
        listSpeciality.DataValueField = "SpecialityID";
        listSpeciality.DataBind();
    }
    public void GetProcedureData()
    {
        long returnCode = -1;
        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
        returnCode = new PatientVisit_BL().GetProcedureName(OrgID, out lstProceduremaster);
        listProcedure.DataSource = lstProceduremaster;
        listProcedure.DataTextField = "ProcedureName";
        listProcedure.DataValueField = "ProcedureID";
        listProcedure.DataBind();
    }
    public void LoadPackageData()
    {
        List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
        hdntotalFinalPKG.Value = "";
        string GroupName = string.Empty;
        int pkgid = Convert.ToInt32(hdnpkgid.Value);
        investigationBL.GetHealthPackageDataSearch(OrgID, GroupName, pkgid, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        if (lstGeneralHealthCheckUpMaster.Count > 0)
        {
            listHealthCheckup.DataSource = lstGeneralHealthCheckUpMaster;
            listHealthCheckup.DataTextField = "GeneralHealthCheckUpName";
            listHealthCheckup.DataValueField = "GeneralHealthCheckUpID";
            listHealthCheckup.DataBind();
        }
        
        if (lstPackages.Count > 0)
        {
            string strHeader = Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_50 == null ? "Health Packages" : Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_50;
            string strAddMore = Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_52 == null ? "Add More.." : Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_52;
            string strDefault = Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_51 == null ? "Set as Default Items to" : Resources.Admin_ClientDisplay.Admin_ManagePackages_aspx_51;
            TableRow rowHeader = new TableRow();
            TableCell cellHeader = new TableCell();
            cellHeader.Attributes.Add("align", "center");
            cellHeader.Text = "<b>" + strHeader + "</b>";
            cellHeader.Font.Bold = true;
            cellHeader.CssClass = "Duecolor";
            cellHeader.Style.Add("height","27px");
            cellHeader.ColumnSpan = 2;
            rowHeader.Cells.Add(cellHeader);
            healthPackagesTab.Rows.Add(rowHeader);
            foreach (InvGroupMaster objGM in lstPackages)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                CheckBox chkPKG = new CheckBox();
                chkPKG.Attributes.Add("onclick", "javascript:showHidePKGContent(" + objGM.GroupID.ToString() + ");");
                chkPKG.ID = "chk" + objGM.GroupID.ToString();
                chkPKG.Text = "<b>" + objGM.GroupName + "</b>";
                cell.Attributes.Add("align", "left");
                cell.Controls.Add(chkPKG);
                row.Cells.Add(cell);
                healthPackagesTab.Rows.Add(row);
                //Package Content
                TableRow rowContentHeader = new TableRow();
                TableCell cellContentHeader = new TableCell();
                rowContentHeader.ID = "rowHeader" + objGM.GroupID.ToString();
                //rowContentHeader.Style.Add("display", "none");
                cellContentHeader.Attributes.Add("align", "center");
                cellContentHeader.CssClass = "Duecolor";
                //cellContentHeader.Style.Add("background-color", "#");
                //cellContentHeader.Style.Add("color", "#FFFFFF");
                cellContentHeader.Style.Add("height", "20px");
                cellContentHeader.Text = "<b>" + objGM.GroupName + "</b>";
                rowContentHeader.Cells.Add(cellContentHeader);
                healthPackagesContentTab.Rows.Add(rowContentHeader);
                TableRow rowContent = new TableRow();
                rowContent.ID = "rowContent" + objGM.GroupID.ToString();
                //rowContent.Style.Add("display", "none");
                TableCell cellContent = new TableCell();
                cellContent.CssClass = "dataheaderInvCtrl";
                //CheckBox chk = new CheckBox();
                //chk.ID = "chk" + objGM.GroupID.ToString();
                //chk.Text = "<b>" + objGM.GroupName + "</b>";
                //cellContent.Attributes.Add("align", "left");
                //cellContent.Controls.Add(chk);
                //   rowContent.Cells.Add(cellContent);
                Table innerContentTab = new Table();
                //  innerContentTab.Rows.Add(rowContent);
                var mappingList = from pkgMapp in lstPackageMapping
                                  where pkgMapp.PackageID == objGM.GroupID
                                  select pkgMapp;
                List<InvPackageMapping> lstpkgMappTemp = mappingList.ToList<InvPackageMapping>();
                if (lstpkgMappTemp.Count > 0)
                {
                    foreach (InvPackageMapping objPKGMapp in lstpkgMappTemp)
                    {
                        TableRow rowinnerContent = new TableRow();
                        TableCell cellinnerContent = new TableCell();
                        Table innerContentTab1 = new Table();
                        var invList = from inv in lstPackageContents
                                      where inv.PackageID == objGM.GroupID && inv.InvestigationID == objPKGMapp.ID && inv.Type == objPKGMapp.Type && objPKGMapp.Type == "INV"
                                      select inv;
                        List<PatientInvestigation> lstPI1 = invList.ToList<PatientInvestigation>();
                        if (lstPI1.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Investigations";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI1 in lstPI1)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI1.InvestigationName + "</b>" + " (Investigation)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG('" + objPI1.InvestigationID.ToString() + "~" + objPI1.PackageID.ToString() + "~INV" + "');");
                                chk.ID = "chk" + objPI1.InvestigationID.ToString() + "~" + objPI1.PackageID.ToString() + "~INV";
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI1.InvestigationName + "</b>" + " (Investigation)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var grpList = from grp in lstPackageContents
                                      where grp.PackageID == objGM.GroupID && grp.GroupID == objPKGMapp.ID && grp.Type == objPKGMapp.Type && objPKGMapp.Type == "GRP"
                                      select grp;
                        List<PatientInvestigation> lstPI2 = grpList.ToList<PatientInvestigation>();
                        if (lstPI2.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Groups";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI2 in lstPI2)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI2.GroupName + "</b>" + " (Group)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG('" + objPI2.GroupID.ToString() + "~" + objPI2.PackageID.ToString() + "~GRP" + "');");
                                //chk.Attributes.Add("onclick", "javascript:showHidePKG(5);");
                                chk.ID = "chk" + objPI2.GroupID.ToString() + "~" + objPI2.PackageID.ToString() + "~GRP";
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI2.GroupName + "</b>" + " (Group)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var spList = from sp in lstPackageContents
                                     where sp.PackageID == objGM.GroupID && sp.InvestigationID == objPKGMapp.ID && sp.Type == objPKGMapp.Type && objPKGMapp.Type == "CON"
                                     select sp;
                        List<PatientInvestigation> lstPI3 = spList.ToList<PatientInvestigation>();
                        if (lstPI3.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Consultations";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI3 in lstPI3)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI3.InvestigationName + "</b>" + " (Consultation)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG('" + objPI3.InvestigationID.ToString() + "~" + objPI3.PackageID.ToString() + "~CON" + "');");
                                chk.ID = "chk" + objPI3.InvestigationID.ToString() + "~" + objPI3.PackageID.ToString() + "~CON";
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI3.InvestigationName + "</b>" + " (Consultation)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var proList = from pro in lstPackageContents
                                      where pro.PackageID == objGM.GroupID && pro.InvestigationID == objPKGMapp.ID && pro.Type == objPKGMapp.Type && objPKGMapp.Type == "PRO"
                                      select pro;
                        List<PatientInvestigation> lstPI4 = proList.ToList<PatientInvestigation>();
                        if (lstPI4.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Procedures";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI4 in lstPI4)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI4.InvestigationName + "</b>" + " (Procedure)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG('" + objPI4.InvestigationID.ToString() + "~" + objPI4.PackageID.ToString() + "~PRO" + "');");
                                chk.ID = "chk" + objPI4.InvestigationID.ToString() + "~" + objPI4.PackageID.ToString() + "~PRO";
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI4.InvestigationName + "</b>" + " (Procedure)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        var GHCList = from ghc in lstPackageContents
                                      where ghc.PackageID == objGM.GroupID && ghc.InvestigationID == objPKGMapp.ID && ghc.Type == objPKGMapp.Type && objPKGMapp.Type == "GHC"
                                      select ghc;
                        List<PatientInvestigation> lstPI5 = GHCList.ToList<PatientInvestigation>();
                        if (lstPI5.Count > 0)
                        {
                            //TableRow rowinnerContentH = new TableRow();
                            //TableCell cellinnerContentH = new TableCell();
                            //cellinnerContentH.Text = "Procedures";
                            //cellinnerContentH.Font.Bold = true;
                            //cellinnerContentH.Style.Add("color", "#");
                            //rowinnerContentH.Cells.Add(cellinnerContentH);
                            //innerContentTab1.Rows.Add(rowinnerContentH);
                            foreach (PatientInvestigation objPI5 in lstPI5)
                            {
                                TableRow rowinnerContent1 = new TableRow();
                                TableCell cellinnerContent1 = new TableCell();
                                cellinnerContent1.CssClass = "colorsample";
                                cellinnerContent1.Text = "<b>" + objPI5.InvestigationName + "</b>" + " (Health Checkup)" + "</font>";
                                CheckBox chk = new CheckBox();
                                chk.Attributes.Add("onclick", "javascript:showHidePKG('" + objPI5.InvestigationID.ToString() + "~" + objPI5.PackageID.ToString() + "~GHC" + "');");
                                chk.ID = "chk" + objPI5.InvestigationID.ToString() + "~" + objPI5.PackageID.ToString() + "~GHC";
                                chk.CssClass = "colorsample";
                                chk.Text = "<b>" + objPI5.InvestigationName + "</b>" + " (Health Checkup)" + "</font>";
                                chk.Checked = true;
                                cellinnerContent1.Attributes.Add("align", "left");
                                cellinnerContent1.Controls.Add(chk);
                                rowinnerContent1.Cells.Add(cellinnerContent1);
                                innerContentTab1.Rows.Add(rowinnerContent1);
                            }
                        }
                        cellinnerContent.Controls.Add(innerContentTab1);
                        rowinnerContent.Cells.Add(cellinnerContent);
                        innerContentTab.Rows.Add(rowinnerContent);
                    }
                }
                cellContent.Controls.Add(innerContentTab);
                HyperLink hypinnerContentLink = new HyperLink();
                hypinnerContentLink.ID = "hyp" + objGM.GroupID.ToString();
                hypinnerContentLink.CssClass = "colorpacks";
                hypinnerContentLink.Text = "<span class='bold'><u>"+strAddMore+"</u></span>";
                hypinnerContentLink.Attributes.Add("onclick", "javascript:showHideSwapBlock(" + objGM.GroupID.ToString() + ");");
                cellContent.Controls.Add(hypinnerContentLink);
                Table tblAddedSpeciality = new Table();
                tblAddedSpeciality.ID = "tblAddedSpecialityItems" + objGM.GroupID.ToString();
                tblAddedSpeciality.CellPadding = 3;
                cellContent.Controls.Add(tblAddedSpeciality);
                Table tblAddedProcedure = new Table();
                tblAddedProcedure.ID = "tblAddedProcedureItems" + objGM.GroupID.ToString();
                tblAddedProcedure.CellPadding = 3;
                cellContent.Controls.Add(tblAddedProcedure);
                Table tblAddedInvGRP = new Table();
                tblAddedInvGRP.ID = "tblOrderedInvesAddedTemp" + objGM.GroupID.ToString();
                tblAddedInvGRP.CellPadding = 3;
                cellContent.Controls.Add(tblAddedInvGRP);
                Table tblAddedHealthPKG = new Table();
                tblAddedHealthPKG.ID = "tblAddedHealthCheckupItems" + objGM.GroupID.ToString();
                tblAddedHealthPKG.CellPadding = 3;
                cellContent.Controls.Add(tblAddedHealthPKG);
                HiddenField hdnAddedSpeciality = new HiddenField();
                hdnAddedSpeciality.ID = "hdnAddedSpecialityItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedSpeciality);
                HiddenField hdnAddedProcedure = new HiddenField();
                hdnAddedProcedure.ID = "hdnAddedProcedureItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedProcedure);
                HiddenField hdnAddedInvGRP = new HiddenField();
                hdnAddedInvGRP.ID = "hdnAddedInvGRP" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedInvGRP);
                HiddenField hdnAddedHealthPKG = new HiddenField();
                hdnAddedHealthPKG.ID = "hdnAddedHealthCheckupItems" + objGM.GroupID.ToString();
                cellContent.Controls.Add(hdnAddedHealthPKG);
                CheckBox chkDft = new CheckBox();
                chkDft.ID = "chkDefault" + objGM.GroupID.ToString();
                //chkDft.Style.Add("color", "#");
                chkDft.CssClass = "colorsample";
                chkDft.Text = "<b>"+strDefault+" " + objGM.GroupName + "</b>";
                chkDft.Checked = true;
                //chkDft.Style.Add("display", "none");
                chkDft.Attributes.Add("onfocus", "javascript:setDefaultPKG();");
                cellContent.Controls.Add(chkDft);
                rowContent.Cells.Add(cellContent);
                healthPackagesContentTab.Rows.Add(rowContent);
                if (tblAddedInvGRP.Rows.Count > 0)
                {
                    chkDft.Checked = true;
                }
                hdntotalFinalPKG.Value += objGM.GroupID.ToString() + "~";
            }
            //code added for bug fix - begins 29-09-2010
            List<InvGroupMaster> lstgroupsIC = new List<InvGroupMaster>();
            List<InvestigationMaster> lstInvestigationsIC = new List<InvestigationMaster>();
            new Investigation_BL(base.ContextInfo).GetInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroupsIC, out lstInvestigationsIC);
            int orgBased = OrgID;
            InvestigationControl1.OrgSpecific = orgBased;
            InvestigationControl1.LoadDatas(lstgroupsIC, lstInvestigationsIC);
            LoadSpecialityName();
             GetProcedureData();

            //code added for bug fix - ends 29-09-2010
        }
    }
    public void CollectPackageContent(out List<InvGroupMaster> lstPackagesTemp, out List<InvPackageMapping> lstCollectedDefaultPackageMapping, out List<InvPackageMapping> lstCollectedPackageMapping, out List<Speciality> lstCollectedSpeciality, out List<ProcedureMaster> lstCollectedProcedures, out List<InvPackageMapping> lstDeletedPackageMapping, out List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster)
    {
        int success = 0;
        List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
        int pkgid = Convert.ToInt32(hdnpkgid.Value);
        lstCollectedPackageMapping = new List<InvPackageMapping>();
        lstCollectedSpeciality = new List<Speciality>();
        lstCollectedProcedures = new List<ProcedureMaster>();
        lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
        lstDeletedPackageMapping = new List<InvPackageMapping>();
        lstPackagesTemp = new List<InvGroupMaster>();
        lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
        investigationBL.GetHealthPackageData(OrgID, pkgid, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
        //if (Hdnfld.Value != "")
        //{
        //    foreach (string value in Hdnfld.Value.Split('^'))
        //    {
        //        if (value != "")
        //        {
        //            string[] str = value.Split('~');
        //            InvPackageMapping obj = new InvPackageMapping();
        //            obj.ID = Convert.ToInt64(str[0]);
        //            obj.PackageID = Convert.ToInt32(str[1]);
        //            obj.Type = str[2];
        //            obj.Active = "A";
        //            lstCollectedPackageMapping.Add(obj);
        //        }
        //    }  
        //}
        //else
        //{

        //}
        if (Hdn.Value != "")
        {
            foreach (string value in Hdn.Value.Split('^'))
            {
                if (value != "")
                {
                    string[] str = value.Split('~');
                    InvPackageMapping obj = new InvPackageMapping();
                    obj.ID = Convert.ToInt64(str[0]);
                    obj.PackageID = Convert.ToInt32(str[1]);
                    obj.Type = str[2];
                    obj.Active = "D";
                    lstDeletedPackageMapping.Add(obj);
                }
            }
        }
        else
        {

        }
        foreach (string pkgID in hdntotalFinalPKG.Value.Split('~'))
        {
            if (pkgID != "")
            {
                foreach (InvGroupMaster objGMTemp in lstPackages)
                {
                    foreach (string pkgIDTemp in hdntotalFinalPKG.Value.Split('~'))
                    {
                        if (pkgIDTemp != "")
                        {
                            if (Convert.ToInt32(pkgIDTemp) == objGMTemp.OrgGroupID)
                            {
                                foreach (string pkgIDTemp1 in setOrderedPKGTemp.Value.Split('~'))
                                {
                                    if (pkgIDTemp1 != "" && pkgIDTemp == pkgIDTemp1)
                                    {
                                        success = 1;
                                    }
                                }
                                if (success == 0)
                                {
                                    setOrderedPKGTemp.Value += pkgIDTemp + "~";
                                    lstPackagesTemp.Add(objGMTemp);
                                    var invPMList = from invPM in lstPackageMapping
                                                    where invPM.PackageID == Convert.ToInt32(pkgIDTemp) && invPM.Type == "CON"
                                                    select invPM;
                                    List<InvPackageMapping> lstPI1 = invPMList.ToList<InvPackageMapping>();
                                    foreach (InvPackageMapping objPMTTT in lstPI1)
                                    {
                                        Speciality objCollectedSpeciality = new Speciality();
                                        objCollectedSpeciality.SpecialityID = Convert.ToInt32(objPMTTT.ID);
                                        objCollectedSpeciality.SpecialityName = "";
                                        objCollectedSpeciality.Active = "A";
                                        lstCollectedSpeciality.Add(objCollectedSpeciality);
                                    }
                                }
                            }
                        }
                    }
                }

                foreach (string pkgID1 in collectedFinalINVGRP.Value.Split('|'))
                {
                    if (pkgID1 != "")
                    {
                        string[] items1 = pkgID1.Split('$');
                        if (items1[0] == pkgID)
                        {
                            foreach (string innerItems1 in items1[1].Split('^'))
                            {
                                if (innerItems1 != "")
                                {
                                    string[] innerSubItems1 = innerItems1.Split('~');
                                    InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                    objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                    objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems1[0]);
                                    objCollectedINVGRP.Type = innerSubItems1[2];
                                    objCollectedINVGRP.Active = "A";
                                    lstCollectedPackageMapping.Add(objCollectedINVGRP);
                                }
                            }
                        }
                    }
                }


                foreach (string pkgID2 in collectedFinalSpeciality.Value.Split('|'))
                {
                    if (pkgID2 != "")
                    {
                        string[] items2 = pkgID2.Split('-');
                        if (items2[0] == pkgID)
                        {
                            foreach (string innerItems2 in items2[1].Split('^'))
                            {
                                if (innerItems2 != "")
                                {
                                    string[] innerSubItems2 = innerItems2.Split('~');
                                    Speciality objCollectedSpeciality = new Speciality();
                                    objCollectedSpeciality.SpecialityID = Convert.ToInt16(innerSubItems2[0]);
                                    objCollectedSpeciality.SpecialityName = innerSubItems2[1];
                                    objCollectedSpeciality.Active = "A";
                                    lstCollectedSpeciality.Add(objCollectedSpeciality);
                                }
                            }
                        }
                    }
                }



                foreach (string pkgID3 in collectedFinalProcedure.Value.Split('|'))
                {
                    if (pkgID3 != "")
                    {
                        string[] items3 = pkgID3.Split('-');
                        if (items3[0] == pkgID)
                        {
                            foreach (string innerItems3 in items3[1].Split('^'))
                            {
                                if (innerItems3 != "")
                                {
                                    string[] innerSubItems3 = innerItems3.Split('~');
                                    ProcedureMaster objCollectedProcedure = new ProcedureMaster();
                                    objCollectedProcedure.ProcedureID = Convert.ToInt32(innerSubItems3[1]);
                                    objCollectedProcedure.ProcedureName = innerSubItems3[2];
                                    objCollectedProcedure.Active = "A";
                                    lstCollectedProcedures.Add(objCollectedProcedure);
                                }
                            }
                        }
                    }
                }

                foreach (string pkgID4 in collectedFinalHealthCheckUp.Value.Split('|'))
                {
                    if (pkgID4 != "")
                    {
                        string[] items3 = pkgID4.Split('-');
                        if (items3[0] == pkgID)
                        {
                            foreach (string innerItems3 in items3[1].Split('^'))
                            {
                                if (innerItems3 != "")
                                {
                                    string[] innerSubItems3 = innerItems3.Split('~');
                                    GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(innerSubItems3[1]);
                                    objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = innerSubItems3[2];
                                    objGeneralHealthCheckUpMaster.Active = "A";
                                    lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                                }
                            }
                        }
                    }
                }
                foreach (string pkgIDsetDefault in hdntotalFinalPKG.Value.Split('~'))
                {
                    if (pkgIDsetDefault != "" && pkgIDsetDefault == pkgID)
                    {
                        //          alert(document.getElementById('PackageProfileControl_collectedFinalSpeciality').value);
                        //          alert(document.getElementById('PackageProfileControl_collectedFinalProcedure').value);
                        foreach (string pkgID1 in collectedFinalINVGRP.Value.Split('|'))
                        {
                            if (pkgID1 != "")
                            {
                                string[] items1 = pkgID1.Split('$');
                                if (items1[0] == pkgID)
                                {
                                    foreach (string innerItems1 in items1[1].Split('^'))
                                    {
                                        if (innerItems1 != "")
                                        {
                                            string[] innerSubItems1 = innerItems1.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems1[0]);
                                            objCollectedINVGRP.Type = innerSubItems1[2];
                                            objCollectedINVGRP.Active = "A";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }


                        foreach (string pkgID2 in collectedFinalSpeciality.Value.Split('|'))
                        {
                            if (pkgID2 != "")
                            {
                                string[] items2 = pkgID2.Split('-');
                                if (items2[0] == pkgID)
                                {
                                    foreach (string innerItems2 in items2[1].Split('^'))
                                    {
                                        if (innerItems2 != "")
                                        {
                                            string[] innerSubItems2 = innerItems2.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems2[0]);
                                            objCollectedINVGRP.Type = "CON";
                                            objCollectedINVGRP.Active = "A";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);

                                        }
                                    }
                                }
                            }
                        }




                        foreach (string pkgID3 in collectedFinalProcedure.Value.Split('|'))
                        {
                            if (pkgID3 != "")
                            {
                                string[] items3 = pkgID3.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.Type = "PRO";
                                            objCollectedINVGRP.Active = "A";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }

                        foreach (string pkgID4 in collectedFinalHealthCheckUp.Value.Split('|'))
                        {
                            if (pkgID4 != "")
                            {
                                string[] items3 = pkgID4.Split('-');
                                if (items3[0] == pkgID)
                                {
                                    foreach (string innerItems3 in items3[1].Split('^'))
                                    {
                                        if (innerItems3 != "")
                                        {
                                            string[] innerSubItems3 = innerItems3.Split('~');
                                            InvPackageMapping objCollectedINVGRP = new InvPackageMapping();
                                            objCollectedINVGRP.PackageID = Convert.ToInt32(pkgID);
                                            objCollectedINVGRP.ID = Convert.ToInt64(innerSubItems3[1]);
                                            objCollectedINVGRP.Type = "GHC";
                                            objCollectedINVGRP.Active = "A";
                                            lstCollectedDefaultPackageMapping.Add(objCollectedINVGRP);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                // LoadPackageData();
            }
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        List<AdditionalTubeMapping> lstAdditionalTubeMapping = new List<AdditionalTubeMapping>();
        int pPackageID = Convert.ToInt32(hdnpkgid.Value);
        foreach (ListItem item in chklstExtraSamples.Items)
        {
            AdditionalTubeMapping objects = new AdditionalTubeMapping();
            objects.ID = pPackageID;
            objects.Type = "PKG";
            objects.SampleCode = Convert.ToInt64(item.Value);
            if (item.Selected)
            {
                objects.IsActive = 'Y';
            }
            else
            {
                objects.IsActive = 'N';
            }
            lstAdditionalTubeMapping.Add(objects);
        }
        CollectPackageContent(out lstPackagesTemp, out lstCollectedDefaultPackageMapping, out lstCollectedPackageMapping, out lstCollectedSpeciality, out lstCollectedProcedures, out lstDeletedPackageMapping, out lstGeneralHealthCheckUpMaster);
        returncode = new Investigation_BL(base.ContextInfo).UpdatePackageContent(lstCollectedDefaultPackageMapping, lstDeletedPackageMapping, OrgID, lstAdditionalTubeMapping);
        LoadPackageData();
        LoadExtraSamplesForPackage();
        Hdnfld.Value = "";
        Hdn.Value = "";
        hdntotalFinalPKG.Value = "";
        collectedFinalINVGRP.Value = "";
        collectedFinalSpeciality.Value = "";
        collectedFinalProcedure.Value = "";
        collectedFinalHealthCheckUp.Value = "";
        //txtBillingName.Text = "";
        if (ddlSelectType.Items.Count > 0)
        {
            ddlSelectType.SelectedValue = "Lab_Investigation";
        }
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        ShowHideGrid.Visible = false;
        hdnCurrent.Value = "";
        LoadGrid(e, currentPageNo, PageSize);
        if (btnsave.Text == strupdate)
        {
            btnsave.Text = stradd;
        }
        //txtsearchpkg.Text = "";
    }
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {

        long returnCode = -1;
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        List<InvOrgGroup> lstpackages = new List<InvOrgGroup>();
        string Packagename = txtsearchpkg.Text;
        string remarks = string.Empty;
        int ClientTypeID = 0;
        int ClientID = 0;
        string status = ddlstatus.SelectedValue;
        string packagecode = string.Empty;
        //string Gender = ddlGender1.SelectedValue;
        string Gender = (String.IsNullOrEmpty(ddlGender1.SelectedItem.Value) || ddlGender1.SelectedIndex == 0) ? string.Empty : ddlGender1.SelectedItem.Value;
        //string packagecode = txtpackagecode.Text;
        int pkgid = 0;
        returnCode = invbl.Getpackagesearch(OrgID, pkgid, status, out lstpackages, PageSize, currentPageNo, out totalRows, Packagename, remarks, packagecode);

        if (lstpackages.Count > 0)
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
        if (lstpackages.Count > 0)
        {
            grdpackages.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdpackages.DataSource = lstpackages;
            grdpackages.DataBind();
        }
        else
        {
            grdpackages.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No matching records found";
            hdnCurrent.Value = "";
            txtsearchpkg.Text = "";
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        ShowHideGrid.Visible = false;
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
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        ShowHideGrid.Visible = false;
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
    protected void btnGo_Click(object sender, EventArgs e)
    {
        ShowHideGrid.Visible = false;
        hdnCurrent.Value = "";
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        txtpageNo.Text = ""; 
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "PackageStatus,SelectType,Gender,CutOffTimeType";
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

            // returncode = new MetaData_BL().LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "PackageStatus" //orderby child .MetaDataID
                                 select child;
                ddlstatus.DataSource = childItems;
                ddlstatus.DataTextField = "DisplayText";
                ddlstatus.DataValueField = "Code";
                ddlstatus.DataBind();

                //ddlstatus.Items.Insert(0, "--Select--");
                //ddlstatus.Items[0].Value = "0";
            }

            //objMeta = new MetaData();
            //objMeta.Domain = "CutOffTimeType";
            //lstmetadataInput = new List<MetaData>();
            //lstmetadataInput.Add(objMeta);
            //lstmetadataOutput = new List<MetaData>();
            //// returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);
            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                List<MetaData> lstCutOffTimeType = ((from child in lstmetadataOutput
                                                     where child.Domain == "CutOffTimeType"
                                                     select child).Distinct()).ToList();
                if (lstCutOffTimeType != null && lstCutOffTimeType.Count > 0)
                {
                    ddlCutOffType.DataSource = lstCutOffTimeType;
                    ddlCutOffType.DataTextField = "DisplayText";
                    ddlCutOffType.DataValueField = "Code";
                    ddlCutOffType.DataBind();
                    ddlCutOffType.Items.Insert(0, new ListItem(strselect, "0"));
                    //ddlCutOffType.Items.Insert(0, new ListItem("--Select--", "0"));
                    ddlCutOffType.Items[0].Value = "0";

                }
            }

            //objMeta = new MetaData();
            //objMeta.Domain = "Gender";
            //lstmetadataInput = new List<MetaData>();
            //lstmetadataInput.Add(objMeta);
            //lstmetadataOutput = new List<MetaData>();
            //// returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);
            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                List<MetaData> lstGender = ((from child in lstmetadataOutput
                                             where child.Domain == "Gender"
                                             select child).Distinct()).ToList();
                if (lstGender != null && lstGender.Count > 0)
                {
                    ddlGender1.DataSource = lstGender;
                    ddlGender1.DataTextField = "DisplayText";
                    ddlGender1.DataValueField = "Code";
                    ddlGender1.DataBind();
                    ddlGender1.Items.Insert(0, strselect);
                    //ddlGender1.Items.Insert(0, "--Select--");
                    ddlGender1.Items[0].Value = "0";
                }
            }

            List<MetaValue_Common> lstGroupCategory = new List<MetaValue_Common>();
            returncode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVESTIGATION_FEE", out lstGroupCategory);

            if (lstGroupCategory.Count > 0)
            {
                ddlTestCategory.DataSource = lstGroupCategory;
                ddlTestCategory.DataTextField = "Value";
                ddlTestCategory.DataValueField = "Code";
                ddlTestCategory.DataBind();
            }
            ListItem item = new ListItem();
            item.Text = strselect;
            //item.Text = "---Select---";
            item.Value = "0";
            ddlTestCategory.Items.Insert(0, item);

            var SelectType = from child in lstmetadataOutput
                             where child.Domain == "SelectType"
                             select child;
            if (SelectType.Count() > 0)
            {
                ddlSelectType.DataSource = SelectType;
                ddlSelectType.DataTextField = "DisplayText";
                ddlSelectType.DataValueField = "Code";
                ddlSelectType.DataBind();
                ddlSelectType.SelectedValue = "Lab_Investigation";
                //ddlSelectType.Items.Insert(0, "--Select--");
                //ddlSelectType.Items[0].Value = "-1";
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }
    protected void grdpackages_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InvOrgGroup inv = (InvOrgGroup)e.Row.DataItem;
            if (inv.Status == "A")
            {

                e.Row.Cells[4].Text = "Active";
            }
            else if (inv.Status == "D")
            {

                e.Row.Cells[4].Text = "In Active";
            }
            else
            {
                e.Row.Cells[4].Text = "";
            }
        }
    }

    private void loadCodingSchemaName()
    {
        try
        {
            long returnCode = -1;
            int InvID = 0;
            if (hdnpkgid.Value != "")
            {
                InvID = Convert.ToInt32(hdnpkgid.Value.ToString());
            }
            string PkgName = txtpackagename.Text;
            string Type = "PKG";
            List<CodingSchemeMaster> CSM = new List<CodingSchemeMaster>();

            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returnCode = MasterBL.GetCodingSchemeName(OrgID, PkgName, Type, InvID, out CSM);
            if (CSM.Count > 0)
            {
                grdInvCodingScheme.DataSource = CSM;
                grdInvCodingScheme.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadCodingSchemeName", ex);
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

    public void LoadScheduleType()
    {
        try
        {
            long returncode = -1;
            string domains = "TestScheduleType";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TestScheduleType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlScheduleType.DataSource = childItems;
                    ddlScheduleType.DataTextField = "DisplayText";
                    ddlScheduleType.DataValueField = "Code";
                    ddlScheduleType.DataBind();
                    ddlScheduleType.Items.Insert(0, strselect);
                    //ddlScheduleType.Items.Insert(0, "--Select--");
                    ddlScheduleType.Items[0].Value = "-1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

    public void LoadExtraSamplesForPackage()
    {
        try
        {
            long returnCode = -1;
            int pOrgId = OrgID;
            int pID = Convert.ToInt32(hdnpkgid.Value);
            string pType = "PKG";
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<AdditionalTubeMapping> lstAdditionalTubeMapping = new List<AdditionalTubeMapping>();
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            returnCode = objMaster_BL.GetSamplesForAdditionalTube(pOrgId, pID, pType, out lstInvSampleMaster, out lstAdditionalTubeMapping);
            chklstExtraSamples.Items.Clear();
            lblExtraTube.Style.Add("display", "none");
            if (lstInvSampleMaster.Count > 0)
            {
                lblExtraTube.Style.Add("display", "block");
                chklstExtraSamples.DataSource = lstInvSampleMaster;
                chklstExtraSamples.DataTextField = "SampleDesc";
                chklstExtraSamples.DataValueField = "SampleCode";
                chklstExtraSamples.DataBind();

            }
            if (lstAdditionalTubeMapping.Count > 0)
            {
                foreach (AdditionalTubeMapping objects in lstAdditionalTubeMapping)
                {
                    foreach (ListItem item in chklstExtraSamples.Items)
                    {
                        if (item.Value == objects.SampleCode.ToString())
                        {
                            item.Selected = true;
                            // break;
                        }

                    }

                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadExtraSamplesForPackage in ManagePackages.aspx.cs", ex);
        }

    }
    #region Export To Excel
    protected void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            loaddgridforExcel();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }
    }

    public void loaddgrid()
    {
        try
        {
            long returnCode = -1;
            string Packagename = txtsearchpkg.Text;
            string remarks = string.Empty;
            int ClientTypeID = 0;
            int ClientID = 0;
            string status = ddlstatus.SelectedValue;
            string packagecode = "COrg";
            int pkgid = 0;
            Investigation_BL invbl = new Investigation_BL();
            List<InvOrgGroup> lstpackages = new List<InvOrgGroup>();


            returnCode = new Investigation_BL(base.ContextInfo).Getpackagesearch(OrgID, pkgid, status, out lstpackages, PageSize, currentPageNo, out totalRows, Packagename, remarks, packagecode);

            if (lstpackages.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstpackages);

                ExportToExcel();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public void loaddgridforExcel()
    {
        try
        {
            long returnCode = -1;
            string Packagename = txtsearchpkg.Text;
            string remarks = string.Empty;
            int ClientTypeID = 0;
            int ClientID = 0;
            string status = ddlstatus.SelectedValue;
            string packagecode = "COrg";
            int pkgid = 0;

            ContextDetails objContextInfo = base.ContextInfo;
            ContextInfo.AdditionalInfo = "Y";
            Investigation_BL invbl = new Investigation_BL();
            List<InvOrgGroup> lstpackages = new List<InvOrgGroup>();


            returnCode = new Investigation_BL(ContextInfo).Getpackagesearch(OrgID, pkgid, status, out lstpackages, PageSize, currentPageNo, out totalRows, Packagename, remarks, packagecode);

            if (lstpackages.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstpackages);
                grdpackages.DataSource = lstpackages;
                grdpackages.DataBind();
                ExportToExcel();
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }




    public void ExportToExcel()
    {

        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string attachment = "attachment; filename=" + "ManagaePackages" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdpackages.AllowPaging = false;
            long returnCode = -1;
            string Packagename = txtsearchpkg.Text;
            string remarks = string.Empty;
            string status = ddlstatus.SelectedValue;
            string packagecode = "COrg";
            int pkgid = 0;
            ContextDetails objContextInfo = base.ContextInfo;
            ContextInfo.AdditionalInfo = "Y";
            Investigation_BL invbl = new Investigation_BL();
            List<InvOrgGroup> lstpackages = new List<InvOrgGroup>();
            returnCode = new Investigation_BL(ContextInfo).Getpackagesearch(OrgID, pkgid, status, out lstpackages, 10000, currentPageNo, out totalRows, Packagename, remarks, packagecode);
            grdpackages.DataSource = null;
            grdpackages.DataBind();
            if (lstpackages.Count > 0)
            {
                grdpackages.DataSource = lstpackages;
                grdpackages.DataBind();
            }
            grdpackages.Visible = true;
            PrepareExcelSheet();
            grdpackages.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }
    private void PrepareExcelSheet()
    {
        try
        {
            grdpackages.HeaderRow.Cells[grdpackages.Columns.Count - 1].Visible = false;
            for (int i = 0; i < grdpackages.Rows.Count; i++)
            {
                grdpackages.Rows[i].Cells[grdpackages.Columns.Count - 1].Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    #endregion
}
