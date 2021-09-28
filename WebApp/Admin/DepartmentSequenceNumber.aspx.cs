using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;
using Attune.Podium.BusinessEntities.CustomEntities;


public partial class Admin_DepartmentSequenceNumber : BasePage
{
    #region Inti

    public Admin_DepartmentSequenceNumber()
        : base("Admin_DepartmentSequenceNumber_aspx")
    {
    }

    string Select = Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05 == null ? "---Select---" : Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05;
    Master_BL ObjMas;

    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    List<InvestigationOrgMapping> lstInvOrg = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMAll = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> IOMSelect = new List<InvestigationOrgMapping>();
    List<InvestigationMaster> objMap = new List<InvestigationMaster>();
    List<InvestigationOrgMapping> objLoadInvMap = new List<InvestigationOrgMapping>();
    Investigation_BL ObjInv;
    PatientVisit_BL ObjPatVisit;
    List<InvGroupMaster> lstgrp = new List<InvGroupMaster>();
    List<InvGroupMaster> objGrpMap = new List<InvGroupMaster>();
    List<OrderedInvestigations> objInvGrp = new List<OrderedInvestigations>();
    List<OrderedInvestigations> objInvPkg = new List<OrderedInvestigations>();
    List<InvOrgGroup> lstGrp = new List<InvOrgGroup>();
    List<InvOrgGroup> lstPkg = new List<InvOrgGroup>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
    List<InvestigationHeader> lstManageHeader = new List<InvestigationHeader>();
    long returnCode = 0;
    string groupname;
    string Pkgname;
    int GroupID;
    int PkgID;
    int DeptID;
    string DtCode;
    string DeptName;
    string IsClientSMSConfig = "N";
    GridView grdvalue;
    int RowIndex1;

    string alertMgs = Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_01 == null ? "Changes Saved successfully." : Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_01;
    string UserHeaderText = Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_06 == null ? "Information" : Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_06;
    string alertMgs1 = Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_02 == null ? "Changes Updated successfully." : Resources.Admin_AppMsg.Admin_DepartmentSequenceNumber_aspx_02;

    #endregion

    #region event

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ObjMas = new Master_BL(base.ContextInfo);
            IsClientSMSConfig = GetConfigValue("NeedDeptLevel_PatientSMS", OrgID);

            if (IsClientSMSConfig == "Y")
            {

                trclientSMS.Attributes.Add("Style", "diplay:block");
                //chkClientPatientSMS.Checked = true;
                
            }
            
            if (!IsPostBack)
            {
                if (IsClientSMSConfig == "Y")
                {
                    grdDeptLoc.Columns[10].Visible = true;
                }
		
                LocationBind();
                LoadGrid();
                loaddepartmentname();
                LoadManageHeader();
                loadDepartments();
                LoadRole();
                loadgrid();
                LoadGrdSigMap();
                Load_Shared_Dept();
                SharedDeptBind();
                LoadLocation();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber Page_Load", ex);
        }
    }


    protected void TabContainer_ActiveTabIndexChanged(object sender, EventArgs e)
        {
            if (TabContainer1.ActiveTabIndex == 0)
            {
                LoadGrid();
            }
            if (TabContainer1.ActiveTabIndex == 1)
            {
                loadgrid();
            }
            if (TabContainer1.ActiveTabIndex == 2)
            {
                LoadRole();
                loaddepartmentname();
            }
            if (TabContainer1.ActiveTabIndex == 3)
            {
                LoadManageHeader();
            }
            if (TabContainer1.ActiveTabIndex == 4)
            {
                LoadLocation();
                loadDepartments();
                LoadGrdSigMap();
            }
            if (TabContainer1.ActiveTabIndex == 5)
            {
                    SharedDeptBind();
                    Load_Shared_Dept();
            }
        }

    protected void grdDeptLoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        LoadGrid();
        grdDeptLoc.PageIndex = e.NewPageIndex;
        grdDeptLoc.DataBind();
    }

    protected void GrdDept_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        loadgrid();
        GrdDept.PageIndex = e.NewPageIndex;
        GrdDept.DataBind();
    }

    protected void gvManageHeader_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        LoadManageHeader();
        gvManageHeader.PageIndex = e.NewPageIndex;
        gvManageHeader.DataBind();
    }
    protected void GrdSigMapLoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        LoadGrdSigMap();
        GrdSigMapLoc.PageIndex = e.NewPageIndex;
        GrdSigMapLoc.DataBind();
    }
    

    
    protected void grdDeptLoc_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        List<Role> lstRoleLocation = new List<Role>();
        try
        {
            if (e.CommandName == "EditRow")
            {
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                DeptIDLoc.Value = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["DeptID"]);
                string DeptName = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["DeptName"]);
                string Code = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["Code"]);
                string Display = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["Display"]);
                string DeptCode = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["DeptCode"]);
                string PrintSeparately = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["PrintSeparately"]);
                string LocationDetails = Convert.ToString(grdDeptLoc.DataKeys[rowIndex]["LocationDetails"]);
                Boolean AutoScanIn = Convert.ToBoolean(grdDeptLoc.DataKeys[rowIndex]["IsScanInRequired"]);
                Boolean IsShareAble = Convert.ToBoolean(grdDeptLoc.DataKeys[rowIndex]["IsShareAble"]);
                Boolean ISclientSMS = Convert.ToBoolean(grdDeptLoc.DataKeys[rowIndex]["IsClientSMS"]);
                string[] tokens;
                txtdeptName.Text = DeptName;
                txtcodeDep.Text = Code;
                txtDeptCode.Text = DeptCode;
                if (Display == "Y")
                    chkDisplay.Checked = true;
                else
                    chkDisplay.Checked = false;
                if (PrintSeparately == "Y")
                    ChkPriSe.Checked = true;
                else
                    ChkPriSe.Checked = false;

                if (AutoScanIn == true)
                    ChkSacn.Checked = true;
                else
                    ChkSacn.Checked = false;

                if (IsShareAble == true)
                    Chkshareable.Checked = true;
                else
                    Chkshareable.Checked = false;

                if (ISclientSMS == true)
                    chkClientPatientSMS.Checked = true;
                else
                    chkClientPatientSMS.Checked = false;
                btnSaveLoc.Text = "Update";
                Role lstorg = new Role();
                foreach (ListItem lstItem in chkLocations.Items)
                {
                    lstItem.Selected = false;
                }
                lstRoleLocation.Add(lstorg);
                if (!String.IsNullOrEmpty(LocationDetails) && LocationDetails.Length > 0)
                {
                    tokens = LocationDetails.Split('|');
                    for (int i = 0; i < tokens.Length; i++)
                    {
                        foreach (ListItem lstItem in chkLocations.Items)
                        {
                            if (Convert.ToInt32(tokens[i]) == Convert.ToInt32(lstItem.Value))
                            {
                                lstItem.Selected = true;
                            }
                        }
                    }
                }
                else
                {

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber grdDeptLoc_RowCommand", ex);
        }
    }

    protected void grdDeptLoc_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.BackColor = System.Drawing.Color.PapayaWhip;
        }

         // if (IsClientSMSConfig != "Y")
        //{
        // e.Row.Cells[10].Visible = false;
        //}
        
    }

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        chkCheckAll.Checked = false;
        checkAll(false);
        try
        {
            long RoleID = Convert.ToInt64(ddlRole.SelectedItem.Value);
            List<RoleDeptMap> lstDeptID = new List<RoleDeptMap>();
            Role_BL objRole_BL = new Role_BL(base.ContextInfo);
            objRole_BL.GetDeptID(RoleID, out lstDeptID);
            foreach (var item in lstDeptID)
            {
                foreach (ListItem chkItem in checkLst.Items)
                {
                    if (item.DeptID == Convert.ToInt32(chkItem.Value))
                    {
                        chkItem.Selected = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber ddlRole_SelectedIndexChanged", ex);
        }
    }

    protected void ddlLocationsig_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
           
            long DeptID = Convert.ToInt64(ddlDeptSigMap.SelectedItem.Value);
            long LocID = Convert.ToInt64(ddlLocationSig.SelectedItem.Value);
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "text", "BindLogin('" + DeptID + "','" + LocID + "')", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber ddlLocationsig_SelectedIndexChanged", ex);
        }
        
    }

    protected void ddlDeptSigMap_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //long DeptID = Convert.ToInt64(ddlDeptSigMap.SelectedItem.Value);
            //List<OrganizationAddress> lstDeptID = new List<OrganizationAddress>();
            //Master_BL objMas_BL = new Master_BL(base.ContextInfo);
            //objMas_BL.GetLocID(DeptID, OrgID, out lstDeptID);
            //ddlLocationSig.Items.Clear();
            //if (lstDeptID.Count > 0)
            //{
            //    ddlLocationSig.DataSource = lstDeptID;
            //    ddlLocationSig.DataTextField = "Location";
            //    ddlLocationSig.DataValueField = "AddressID";
            //    ddlLocationSig.DataBind();
            //    ddlLocationSig.Items.Insert(0, Select);
            //    ddlLocationSig.Items[0].Value = "0";
            //}
            //else
            //{
            //    ddlLocationSig.Items.Insert(0, Select);
            //    ddlLocationSig.Items[0].Value = "0";
            //}
          
            long DeptID = Convert.ToInt64(ddlDeptSigMap.SelectedItem.Value);
            long LocID = Convert.ToInt64(ddlLocationSig.SelectedItem.Value);
            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "text", "BindLogin('" + DeptID + "','" + LocID + "')", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber ddlDeptSigMap_SelectedIndexChanged", ex);
        }
    }

    protected void btnCancelDep_Click(object sender, EventArgs e)
    {
        try
        {
            ClearLocTabData();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber btnCancelDep_Click", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long RoleID = Convert.ToInt64(ddlRole.SelectedItem.Value);
            List<RoleDeptMap> lstRoleDeptMap = new List<RoleDeptMap>();

            foreach (ListItem item in checkLst.Items)
            {
                if (item.Selected)
                {
                    RoleDeptMap objRoleDeptMap = new RoleDeptMap();
                    objRoleDeptMap.DeptID = Convert.ToInt32(item.Value);
                    objRoleDeptMap.RoleID = RoleID;
                    lstRoleDeptMap.Add(objRoleDeptMap);
                }
            }
            Role_BL objRole_BL = new Role_BL(base.ContextInfo);
            returnCode = objRole_BL.InsertMapDetails(lstRoleDeptMap);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                ClearRoleDepMap();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving DepartmentSequenceNumber btnSave_Click", ex);
        }
    }

    protected void btnSaveSharDept_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long DeptID = Convert.ToInt64(ddlDeptshare.SelectedItem.Value);
            List<RoleDeptMap> lstDept = new List<RoleDeptMap>();

            foreach (ListItem item in ChckDeptShared.Items)
            {
                if (item.Selected)
                {
                    RoleDeptMap objDeptShare = new RoleDeptMap();
                    objDeptShare.DeptID = Convert.ToInt32(item.Value);
                    objDeptShare.RoleID = DeptID;
                    objDeptShare.RoleDetpID = OrgID;
                    lstDept.Add(objDeptShare);
                }
            }
            Master_BL objMas_BL = new Master_BL(base.ContextInfo);
            returnCode = objMas_BL.InsertSharedDeptDetails(DeptID,lstDept);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                ClearRoleDepMap();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Saving DepartmentSequenceNumber btnSave_Click", ex);
        }
    }

    protected void btnsaveSig_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long DeptID = Convert.ToInt64(ddlDeptSigMap.SelectedItem.Value);
            long LocID = Convert.ToInt64(ddlLocationSig.SelectedItem.Value);
            List<RoleDeptMap> lstLocationDeptUserMap = new List<RoleDeptMap>();
            string saveflag = "Y";
            if (btnsaveSig.Text == "Save")
            {
                foreach (GridViewRow row in GrdSigMapLoc.Rows)
                {
                    Label DeptIDgrd = (Label)row.FindControl("lblDepID");
                    Label AddressIDgrd = (Label)row.FindControl("lblAddressID");
                    if (DeptID == Convert.ToInt32(DeptIDgrd.Text) && LocID == Convert.ToInt32(AddressIDgrd.Text))
                    {
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showddl", "javascript:BindLogin('" + DeptID + "','" + LocID + "')", true);
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + "You can not allow to add more than one.Please edit and add more" + "','" + UserHeaderText + "');", true);
                        saveflag = "N";
                    }
                }
            }
            string[] safddas = HdLoginName.Value.Split(',');
            int seq = 1;
            for (int i = 0; i < safddas.Length; i++)
            {
                RoleDeptMap objRoleDeptMap = new RoleDeptMap();
                objRoleDeptMap.RoleID = Convert.ToInt32(safddas[i].ToString());
                objRoleDeptMap.DeptID = seq;
                lstLocationDeptUserMap.Add(objRoleDeptMap);
                seq = seq + 1;
            }
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            if (btnsaveSig.Text == "Save")
            {
                InsUpdflag.Value = "1";
            }
            else if (btnsaveSig.Text == "Update")
            {
                InsUpdflag.Value = "2";
            }
            if (saveflag == "Y")
            {
                returnCode = objMaster_BL.SaveLocDepUserMap(DeptID, LocID, "Y", 1, OrgID, Convert.ToString(InsUpdflag.Value), lstLocationDeptUserMap);
            }
            if (returnCode > 0)
            {
                LoadGrdSigMap();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "Resetdrplogin()", true);
                ClearFiled_Click(sender, e);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                ddlDeptSigMap.Enabled = true;
                ddlLocationSig.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in DepartmentSequenceNumber btnsaveSig_Click", ex);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
        string HeaderName = txtHeaderName.Text;
        bool IsActive;
        try
        {
            if (chkIsActive.Checked == true)
            {
                IsActive = true;
            }
            else
            {
                IsActive = false;
            }
            returnCode = objInv.pSaveManageHeader(HeaderName, IsActive);
            if (returnCode == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                gvManageHeader.EditIndex = -1;
                txtHeaderName.Text = "";
                chkIsActive.Checked = false;
                LoadManageHeader();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber btnAdd_Click", ex);
        }
    }

    protected void gvManageHeader_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Sequence Investigation", ex);
        }
    }

    protected void gvManageHeader_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvManageHeader.EditIndex = -1;
        LoadManageHeader();
    }

    protected void gvManageHeader_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvManageHeader.EditIndex = e.NewEditIndex;
        LoadManageHeader();
    }

    protected void btnDeptsave_Click(object sender, EventArgs e)
    {
        try
        {
            long DeptCode = Convert.ToInt64(ddlDeptName.SelectedValue);
            string Code = txtCode.Text.Trim().ToUpper();
            string DeptName = ddlDeptName.SelectedValue == "0" ? txtDeptadd.Text.Trim() : ddlDeptName.SelectedItem.Text;
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            List<InvDeptMaster> lstDept = new List<InvDeptMaster>();

            returnCode = objInv.pInsertDeptName(OrgID, DeptName, DeptCode, Code, out lstDept);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                ClearData();
                loadgrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber btnDeptsave_Click", ex);
        }
    }

    protected void saveDept_Click(object sender, EventArgs e)
    {
        try
        {
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            returnCode = objInv.pUpdateDeptSequenceNo(dtt, OrgID);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                txtDeptadd.Text = string.Empty;
                txtCode.Text = string.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber saveDept_Click", ex);
        }
    }

    protected void saveSequance_Click(object sender, EventArgs e)
    {
        try
        {
            Master_BL objInv = new Master_BL(base.ContextInfo);
            DataTable dtt = (DataTable)ViewState["UserName"];
            DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("Id");
            DataColumn dbCol2 = new DataColumn("name");
            DataColumn dbCol3 = new DataColumn("UserID");
            DataColumn dbCol4 = new DataColumn("UserName");
            DataColumn dbCol5 = new DataColumn("SeqNo");
            DataColumn dbCol6 = new DataColumn("Defaultsig");

            dt.Columns.Add(dbCol1);
            dt.Columns.Add(dbCol2);
            dt.Columns.Add(dbCol3);
            dt.Columns.Add(dbCol4);
            dt.Columns.Add(dbCol5);
            dt.Columns.Add(dbCol6);
            long seq = 1;

            string Check;
            foreach (GridViewRow row in gvPopupgrid.Rows)
            {
                CheckBox Defaultsig1 = (CheckBox)row.FindControl("chckDisPopupgrid");
                if (Defaultsig1.Checked == true)
                { 
                 Check="Y";
                }
                else
                 Check="N";
                
                Label Id = (Label)row.FindControl("lblID");
                Label SeqNo = (Label)row.FindControl("lblSeqNoPopup");
                Label LoginID = (Label)row.FindControl("lblLoginIDPopup");
                Label LoginName = (Label)row.FindControl("lblLoginNamePopup");
               
                DataRow dr = dt.NewRow();
                dr["Id"] = Id.Text;
                dr["name"] = string.Empty;
                dr["UserID"] = LoginID.Text;
                dr["UserName"] = LoginName.Text;
                dr["SeqNo"] = seq;
                dr["Defaultsig"] = Check.ToString();
                dt.Rows.Add(dr);
                seq++;

            }
            returnCode = objInv.pUpdateSequenceNo(dt, OrgID);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                txtDeptadd.Text = string.Empty;
                txtCode.Text = string.Empty;
                LoadGrdSigMap();
                ClearFiled_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber saveSequance_Click", ex);
        }
    }

    protected void btnSaveLocations_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstRoleLocation = new List<Role>();
            Master_BL MasBL = new Master_BL(base.ContextInfo);
            lstInvDeptMaster = new List<InvDeptMaster>();

            long returnCode = 0;
            string InsUpdfl = "0";
            Role lstorg;
            if (btnSaveLoc.Text == "Save")
            {
                InsUpdfl = "1";
            }
            else if (btnSaveLoc.Text == "Update")
            {
                InsUpdfl = "2";
            }
            string deptName = txtdeptName.Text.ToString();
            string Code = txtcodeDep.Text.ToString();
            string deptcode = txtDeptCode.Text.ToString();
            string CDisplay;
            string AutoScan;
            string ChkPriSep;
            long shareable;

            bool IsClientSMS = true;

            if (IsClientSMSConfig == "Y")
            {
                if (chkClientPatientSMS.Checked == true)
                    IsClientSMS = true;
                else
                    IsClientSMS = false;
            }

            if (chkDisplay.Checked == true)
                CDisplay = "Y";
            else
                CDisplay = "N";
            //string ChkPriSep;
            if (ChkPriSe.Checked == true)
                ChkPriSep = "Y";
            else
                ChkPriSep = "N";

            if (ChkSacn.Checked == true)
                AutoScan = "1";
            else
                AutoScan = "0";

            if (Chkshareable.Checked == true)
                shareable = 1;
            else
                shareable = 0;

            foreach (ListItem lstItem in chkLocations.Items)
            {
                lstorg = new Role();
                if (lstItem.Selected == true)
                {
                    lstorg.RoleID = Convert.ToInt64(0);
                    lstorg.OrgAddressID = Convert.ToInt32(lstItem.Value);
                    lstorg.ParentID = 0;
                    lstorg.Description = lstItem.Selected == true ? "Y" : "N";
                    lstRoleLocation.Add(lstorg);
                }
            }

            returnCode = MasBL.SaveLocationMap(OrgID, Convert.ToInt32(DeptIDLoc.Value), deptName, Code, CDisplay, deptcode, ChkPriSep, AutoScan, InsUpdfl, shareable, IsClientSMS, lstRoleLocation);
            if (returnCode > 0)
            {
                if (InsUpdfl == "1")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs + "','" + UserHeaderText + "');", true);
                }
                else if (InsUpdfl == "2")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs1 + "','" + UserHeaderText + "');", true);
                }
                ClearLocTabData();
                LocationBind();
                LoadGrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber btnSaveLocations_Click", ex);
        }
    }

    protected void chkLocations_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber", ex);
        }
    }

    protected void gvManageHeader_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
        Label DeptmentID = (Label)gvManageHeader.Rows[e.RowIndex].FindControl("lblDeptID");
        Label lbldept = (Label)gvManageHeader.Rows[e.RowIndex].FindControl("lbldeptName");
        TextBox Txtdept = (TextBox)gvManageHeader.Rows[e.RowIndex].FindControl("txtdeptName");
        CheckBox chkActive = (CheckBox)gvManageHeader.Rows[e.RowIndex].FindControl("chkIsActive");
        try
        {
            long HeaderID = Convert.ToInt16(DeptmentID.Text); ;
            string HeaderName = Txtdept.Text;
            bool IsActive;
            if (chkActive.Checked == true)
            {
                IsActive = true;
            }
            else
            {
                IsActive = false;
            }

            returnCode = objInv.pUpdateManageHeader(HeaderID, HeaderName, IsActive);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs1 + "','" + UserHeaderText + "');", true);
                gvManageHeader.EditIndex = -1;
                LoadManageHeader();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber gvManageHeader_RowUpdating", ex);
        }
    }

    protected void Divbound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.FindControl("rdbcheck") != null)
                {
                string strScript = "SelectInvSeqRowCommon('" + ((RadioButton)e.Row.FindControl("rdbcheck")).ClientID + "');";
                    ((RadioButton)e.Row.FindControl("rdbcheck")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                    ((RadioButton)e.Row.FindControl("rdbcheck")).Attributes.Add("onclick", strScript);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber Divbound", ex);
        }
    }

    protected void Sigbound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
		if(e.Row.FindControl("lblDefaultsig") !=null)
		{
                Label lblSeq = (e.Row.FindControl("lblDefaultsig") as Label);
			if (e.Row.FindControl("chckDis") != null)
                	{
                if (lblSeq.Text == "Y")
                {
                    CheckBox chkisdefault = (CheckBox)e.Row.FindControl("chckDis");
                    chkisdefault.Checked = true;
                }
                string strScript = "SelectInvSeqRowCommon('" + ((CheckBox)e.Row.FindControl("chckDis")).ClientID + "');";
	                	((CheckBox)e.Row.FindControl("chckDis")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
	                	((CheckBox)e.Row.FindControl("chckDis")).Attributes.Add("onclick", strScript);
			}
		}	
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber Sigbound", ex);
        }
    }

    protected void GrdDept_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int rowindex = 0;
            int count = GrdDept.Rows.Count;
            if (dtt != null && dtt.Rows.Count > 0)
            {
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
                        string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
                        string strTempCode = dtt.Rows[selRow]["Code"].ToString().ToUpper();
                        dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
                        dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
                        dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
                        dtt.Rows[swapRow]["DeptName"] = strTempValue;
                        dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
                        dtt.Rows[swapRow]["Code"] = strTempCode;
                        GrdDept.DataSource = dtt;
                        GrdDept.DataBind();
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
                        string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
                        string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
                        string strTempCode = dtt.Rows[selRow]["Code"].ToString().ToUpper();
                        dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
                        dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
                        dtt.Rows[selRow]["Code"] = dtt.Rows[swapRow]["Code"];
                        dtt.Rows[swapRow]["DeptName"] = strTempValue;
                        dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
                        dtt.Rows[swapRow]["Code"] = strTempCode;
                        GrdDept.DataSource = dtt;
                        GrdDept.DataBind();
                    }
                    if (selRow < dtt.Rows.Count - 1)
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + down + "','" + UserHeaderText + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved DOWN !!');", true);
                    }
                }
                if (e.CommandName == "Move")
                {
                    foreach (GridViewRow GR in GrdDept.Rows)
                    {
                        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                        if (rdb.Checked)
                        {
                            rowindex = GR.RowIndex;
                            if (rowindex > selRow)
                            {
                                for (int i = rowindex; i > selRow; i--)
                                {
                                    string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
                                    string strTempValue = dtt.Rows[i]["DeptName"].ToString();
                                    string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
                                    dtt.Rows[i]["DeptID"] = dtt.Rows[i - 1]["DeptID"];
                                    dtt.Rows[i]["DeptName"] = dtt.Rows[i - 1]["DeptName"];
                                    dtt.Rows[i]["Code"] = dtt.Rows[i - 1]["Code"];
                                    dtt.Rows[i - 1]["DeptID"] = strTempDtlID;
                                    dtt.Rows[i - 1]["DeptName"] = strTempValue;
                                    dtt.Rows[i - 1]["Code"] = strTempCode;
                                }
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempDtlID = dtt.Rows[i]["DeptID"].ToString();
                                    string strTempValue = dtt.Rows[i]["DeptName"].ToString();
                                    string strTempCode = dtt.Rows[i]["Code"].ToString().ToUpper();
                                    dtt.Rows[i]["DeptID"] = dtt.Rows[i + 1]["DeptID"];
                                    dtt.Rows[i]["DeptName"] = dtt.Rows[i + 1]["DeptName"];
                                    dtt.Rows[i]["Code"] = dtt.Rows[i + 1]["Code"];
                                    dtt.Rows[i + 1]["DeptID"] = strTempDtlID;
                                    dtt.Rows[i + 1]["DeptName"] = strTempValue;
                                    dtt.Rows[i + 1]["Code"] = strTempCode;
                                }
                            }
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + content + "','" + UserHeaderText + "');", true);
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "dd", "alert('Content Moved !!');", true);
                            GrdDept.DataSource = dtt;
                            GrdDept.DataBind();
                        }

                    }
                }
            }
            ViewState["Reckonn"] = dtt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdDept_RowCommand", ex);
        }
    }

    protected void GrdSigMapLoc_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string Logins = string.Empty;
            if (e.CommandName == "ChangeSeq")
            {
                int RowIndex = Convert.ToInt32((e.CommandArgument).ToString());
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
                Master_BL ObjInv = new Master_BL(base.ContextInfo);
                Label DeptId = (Label)GrdSigMapLoc.Rows[RowIndex].FindControl("lblDepID");
                Label LoctId = (Label)GrdSigMapLoc.Rows[RowIndex].FindControl("lblAddressID");
                gvPopupgrid.DataSource = stUsLoDep;
                gvPopupgrid.DataBind();

                returnCode = ObjInv.GetDeptSigSeqMapLog(OrgID, Convert.ToInt32(DeptId.Text), Convert.ToInt32(LoctId.Text), out stUsLoDep);
                GrdSigMap.DataSource = stUsLoDep;
                gvPopupgrid.DataSource = stUsLoDep;
                gvPopupgrid.DataBind();
                List<InvDeptMaster> stInvdep = new List<InvDeptMaster>();

                foreach (UserSigLocBasedDept org in stUsLoDep)
                {
                    InvDeptMaster objInvDeptMaster = new InvDeptMaster();
                    objInvDeptMaster.DeptID = Convert.ToInt32(org.Id);
                    objInvDeptMaster.SequenceNo = Convert.ToInt32(org.SeqNo);
                    objInvDeptMaster.RoleID = Convert.ToInt32(org.UserID);
                    objInvDeptMaster.Location = Convert.ToString(org.UserName);
                    objInvDeptMaster.Display = Convert.ToString(org.Defaultsig);
                    stInvdep.Add(objInvDeptMaster);
                }
                logInName(stInvdep);                
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openModalJQ('mymodaldiag1', 'myModalclass1')", true);
                ClearFiled_Click(sender, e);    
            }

            if (e.CommandName == "Editrow")
            {
                int RowIndex = Convert.ToInt32((e.CommandArgument).ToString());


                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                long Dept = Convert.ToInt64(GrdSigMap.DataKeys[rowIndex]["DeptID"]);
                long AddressID = Convert.ToInt64(GrdSigMap.DataKeys[rowIndex]["AddressID"]);
                ddlDeptSigMap.SelectedValue = Dept.ToString();
                ddlDeptSigMap_SelectedIndexChanged(sender, e);
                ddlLocationSig.SelectedValue = AddressID.ToString();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showddl", "javascript:BindLogin('" + Dept + "','" + AddressID + "')", true);
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showddl1", "javascript:SelectLogin('" + OrgID + "','" + Dept + "','" + AddressID + "')", true);
                List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
                Master_BL ObjInv = new Master_BL(base.ContextInfo);
                Label DeptId = (Label)GrdSigMapLoc.Rows[RowIndex].FindControl("lblDepID");
                Label LoctId = (Label)GrdSigMapLoc.Rows[RowIndex].FindControl("lblAddressID");

                returnCode = ObjInv.GetDeptSigSeqMapLog(OrgID, Convert.ToInt32(DeptId.Text), Convert.ToInt32(LoctId.Text), out stUsLoDep);
                GrdSigMap.DataSource = stUsLoDep;
                GridView pubTitle = (GridView)GrdSigMapLoc.Rows[RowIndex].FindControl("gvSubgrid");
                pubTitle.DataSource = stUsLoDep;
                pubTitle.DataBind();
                gvPopupgrid.DataSource = stUsLoDep;
                gvPopupgrid.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "shrinkandgrow()", true);
                ddlDeptSigMap.Enabled = false;
                ddlLocationSig.Enabled = false;
                btnsaveSig.Text = "Update";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdSigMapLoc_RowCommand", ex);
        }
    }

    protected void GrdSigMap_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dtt = (DataTable)ViewState["DeptSeq"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int rowindex = 0;
            int count = GrdDept.Rows.Count;
            string Logins = string.Empty;
            if (dtt != null && dtt.Rows.Count > 0)
            {
                if (e.CommandName == "Editrow")
                {
                    Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                    string Dept = Convert.ToString(GrdSigMap.DataKeys[rowIndex]["DeptID"]);
                    string AddressID = Convert.ToString(GrdSigMap.DataKeys[rowIndex]["AddressID"]);
                    ddlDeptSigMap.SelectedValue = Dept;
                    ddlDeptSigMap_SelectedIndexChanged(sender, e);
                    ddlLocationSig.SelectedValue = AddressID;
                    ddlLocationsig_SelectedIndexChanged(sender, e);
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "SelectLogin('" + Logins + "')", true);
                }
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strlID = dtt.Rows[selRow]["ID"].ToString();
                        string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
                        string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
                        string strAddressID = dtt.Rows[selRow]["AddressID"].ToString();
                        string strLocation = dtt.Rows[selRow]["Location"].ToString();
                        string strUserID = dtt.Rows[selRow]["UserID"].ToString();
                        string strUserName = dtt.Rows[selRow]["UserName"].ToString();
                        string strSeqNo = dtt.Rows[selRow]["SeqNo"].ToString();
                        string strDefaultsig = dtt.Rows[selRow]["Defaultsig"].ToString();

                        dtt.Rows[selRow]["Id"] = dtt.Rows[swapRow]["Id"];
                        dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
                        dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
                        dtt.Rows[selRow]["AddressID"] = dtt.Rows[swapRow]["AddressID"];
                        dtt.Rows[selRow]["Location"] = dtt.Rows[swapRow]["Location"];
                        dtt.Rows[selRow]["UserID"] = dtt.Rows[swapRow]["UserID"];
                        dtt.Rows[selRow]["UserName"] = dtt.Rows[swapRow]["UserName"];
                        dtt.Rows[selRow]["SeqNo"] = dtt.Rows[swapRow]["SeqNo"];
                        dtt.Rows[selRow]["Defaultsig"] = dtt.Rows[swapRow]["Defaultsig"];

                        dtt.Rows[swapRow]["ID"] = strlID;
                        dtt.Rows[swapRow]["DeptName"] = strTempValue;
                        dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
                        dtt.Rows[swapRow]["AddressID"] = strAddressID;
                        dtt.Rows[swapRow]["Location"] = strLocation;
                        dtt.Rows[swapRow]["UserID"] = strUserID;
                        dtt.Rows[swapRow]["UserName"] = strUserName;
                        dtt.Rows[swapRow]["SeqNo"] = strSeqNo;
                        dtt.Rows[swapRow]["Defaultsig"] = strDefaultsig;

                        GrdSigMap.DataSource = dtt;
                        GrdSigMap.DataBind();
                    }
                }
                else if (e.CommandName == "DOWN")
                {
                    if (selRow < dtt.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;
                        string strlID = dtt.Rows[selRow]["ID"].ToString();
                        string strTempDtlID = dtt.Rows[selRow]["DeptID"].ToString();
                        string strTempValue = dtt.Rows[selRow]["DeptName"].ToString();
                        string strAddressID = dtt.Rows[selRow]["AddressID"].ToString();
                        string strLocation = dtt.Rows[selRow]["Location"].ToString();
                        string strUserID = dtt.Rows[selRow]["UserID"].ToString();
                        string strUserName = dtt.Rows[selRow]["UserName"].ToString();
                        string strSeqNo = dtt.Rows[selRow]["SeqNo"].ToString();
                        string strDefaultsig = dtt.Rows[selRow]["Defaultsig"].ToString();

                        dtt.Rows[selRow]["Id"] = dtt.Rows[swapRow]["Id"];
                        dtt.Rows[selRow]["DeptID"] = dtt.Rows[swapRow]["DeptID"];
                        dtt.Rows[selRow]["DeptName"] = dtt.Rows[swapRow]["DeptName"];
                        dtt.Rows[selRow]["AddressID"] = dtt.Rows[swapRow]["AddressID"];
                        dtt.Rows[selRow]["Location"] = dtt.Rows[swapRow]["Location"];
                        dtt.Rows[selRow]["UserID"] = dtt.Rows[swapRow]["UserID"];
                        dtt.Rows[selRow]["UserName"] = dtt.Rows[swapRow]["UserName"];
                        dtt.Rows[selRow]["SeqNo"] = dtt.Rows[swapRow]["SeqNo"];
                        dtt.Rows[selRow]["Defaultsig"] = dtt.Rows[swapRow]["Defaultsig"];

                        dtt.Rows[swapRow]["ID"] = strlID;
                        dtt.Rows[swapRow]["DeptName"] = strTempValue;
                        dtt.Rows[swapRow]["DeptID"] = strTempDtlID;
                        dtt.Rows[swapRow]["AddressID"] = strAddressID;
                        dtt.Rows[swapRow]["Location"] = strLocation;
                        dtt.Rows[swapRow]["UserID"] = strUserID;
                        dtt.Rows[swapRow]["UserName"] = strUserName;
                        dtt.Rows[swapRow]["SeqNo"] = strSeqNo;
                        dtt.Rows[swapRow]["Defaultsig"] = strDefaultsig;

                        GrdSigMap.DataSource = dtt;
                        GrdSigMap.DataBind();
                    }
                }

            }
            ViewState["Reckonn"] = dtt;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdSigMap_RowCommand", ex);
        }
    }

    protected void GrdDept_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            GrdDept.EditIndex = e.NewEditIndex;
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            GrdDept.DataSource = dtt;
            GrdDept.DataBind();
            //loadgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdDept_RowEditing", ex);
        }
    }

    protected void GrdDept_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            Investigation_BL objInv = new Investigation_BL(base.ContextInfo);
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            Label DeptmentID = (Label)GrdDept.Rows[e.RowIndex].FindControl("DeptID");
            Label lbldept = (Label)GrdDept.Rows[e.RowIndex].FindControl("lbldept");
            TextBox Txtdept = (TextBox)GrdDept.Rows[e.RowIndex].FindControl("Txtdept");
            RadioButton chkActive =
              (RadioButton)GrdDept.Rows[e.RowIndex].FindControl("rdbcheck");
            TextBox TxtCode = (TextBox)GrdDept.Rows[e.RowIndex].FindControl("TxtCode");

            DeptName = Txtdept.Text;
            DeptID = Convert.ToInt16(DeptmentID.Text);
            DtCode = TxtCode.Text.Trim().ToUpper();
            returnCode = objInv.pUpdateDeptSequence(dtt, OrgID, DeptID, DeptName, DtCode);
            if (returnCode == 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + alertMgs1 + "','" + UserHeaderText + "');", true);
                GrdDept.EditIndex = -1;
                loadgrid();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdDept_RowUpdating", ex);
        }
    }

    protected void GrdDept_RowCancelingEdit(object sender,
                             GridViewCancelEditEventArgs e)
    {
        try
        {
            GrdDept.EditIndex = -1;
            DataTable dtt = (DataTable)ViewState["Reckonn"];
            GrdDept.DataSource = dtt;
            GrdDept.DataBind();
            //loadgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdDept_RowCancelingEdit", ex);
        }
    }

    protected void ClearFiled_Click(object sender, EventArgs e)
    {
        try
        {
            ddlLoginName.Items.Clear();
            //ddlLocationSig.Items.Clear();
            ddlLocationSig.SelectedValue = "0";
            ddlDeptSigMap.SelectedValue = "0";
            btnsaveSig.Text = "Save";
            ddlDeptSigMap.Enabled = true;
            ddlLocationSig.Enabled = true;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "Resetdrplogin()", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber ClearFiled_Click", ex);
        }
    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gvOrders = e.Row.FindControl("gvOrders") as GridView;
                List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
                Master_BL ObjInv = new Master_BL(base.ContextInfo);
                returnCode = ObjInv.GetDeptSigSeqMap(OrgID, out stUsLoDep);
                gvOrders.DataSource = stUsLoDep;
                gvOrders.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber OnRowDataBound", ex);
        }
    }

    protected void gvUserInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
                Master_BL ObjInv = new Master_BL(base.ContextInfo);
                returnCode = ObjInv.GetDeptSigSeqMap(OrgID, out stUsLoDep);
                GridView gv = (GridView)e.Row.FindControl("gvChildGrid");
                gv.DataSource = stUsLoDep;
                gv.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber gvUserInfo_RowDataBound", ex);
        }
    }
    protected void DepSeqBound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
		if(e.Row.FindControl("lblDefaultsigPopup") !=null)
		{
                Label lblSeq = (e.Row.FindControl("lblDefaultsigPopup") as Label);

                if (lblSeq.Text == "Y")
                {
				if(e.Row.FindControl("chckDisPopupgrid") !=null)
				{
                    CheckBox chkisdefaultPop = (CheckBox)e.Row.FindControl("chckDisPopupgrid");
                    chkisdefaultPop.Checked = true;
				}

                    
                	}
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber DepSeqBound", ex);
        }
    }
    protected void GrdSigMapLoc_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
                Master_BL ObjInv = new Master_BL(base.ContextInfo);
                Label DeptId = (Label)e.Row.FindControl("lblDepID");
                Label LoctId = (Label)e.Row.FindControl("lblAddressID");

                returnCode = ObjInv.GetDeptSigSeqMapLog(OrgID, Convert.ToInt32(DeptId.Text), Convert.ToInt32(LoctId.Text), out stUsLoDep);
                GrdSigMap.DataSource = stUsLoDep;

                GridView pubTitle = (GridView)e.Row.FindControl("gvSubgrid");
                pubTitle.DataSource = stUsLoDep;
                pubTitle.DataBind();

                gvPopupgrid.DataSource = stUsLoDep;
                gvPopupgrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber GrdSigMapLoc_OnRowDataBound", ex);
        }
    }

    protected void gvSubgrid_RowCommand(Object sender, GridViewCommandEventArgs e)
    {
        DataTable dtt = (DataTable)ViewState["UserName"];
        int selRow = Convert.ToInt32(e.CommandArgument);
        int index = Convert.ToInt32(e.CommandArgument);
        int swapRow = 0;
        try
        {
            if (e.CommandName == "UP")
            {
                if (selRow > 0)
                {
                    swapRow = selRow - 1;
                    string strSeqNo = dtt.Rows[selRow]["SeqNo"].ToString();
                    string strUserID = dtt.Rows[selRow]["UserID"].ToString();
                    string strUserName = dtt.Rows[selRow]["UserName"].ToString();
                    string strDefaultsig = dtt.Rows[selRow]["Defaultsig"].ToString();
                    dtt.Rows[selRow]["SeqNo"] = dtt.Rows[swapRow]["SeqNo"];
                    dtt.Rows[selRow]["UserID"] = dtt.Rows[swapRow]["UserID"];
                    dtt.Rows[selRow]["UserName"] = dtt.Rows[swapRow]["UserName"];
                    dtt.Rows[selRow]["Defaultsig"] = dtt.Rows[swapRow]["Defaultsig"];
                    dtt.Rows[swapRow]["SeqNo"] = strSeqNo;
                    dtt.Rows[swapRow]["UserID"] = strUserID;
                    dtt.Rows[swapRow]["UserName"] = strUserName;
                    dtt.Rows[swapRow]["Defaultsig"] = strDefaultsig;
                    gvPopupgrid.DataSource = dtt;
                    gvPopupgrid.DataBind();
                }
            }
            if (e.CommandName == "DOWN")
            {
                if (selRow < dtt.Rows.Count - 1)
                {
                    swapRow = selRow + 1;
                    string strSeqNo = dtt.Rows[selRow]["SeqNo"].ToString();
                    string strUserID = dtt.Rows[selRow]["UserID"].ToString();
                    string strUserName = dtt.Rows[selRow]["UserName"].ToString();
                    string strDefaultsig = dtt.Rows[selRow]["Defaultsig"].ToString();
                    dtt.Rows[selRow]["SeqNo"] = dtt.Rows[swapRow]["SeqNo"];
                    dtt.Rows[selRow]["UserID"] = dtt.Rows[swapRow]["UserID"];
                    dtt.Rows[selRow]["UserName"] = dtt.Rows[swapRow]["UserName"];
                    dtt.Rows[selRow]["Defaultsig"] = dtt.Rows[swapRow]["Defaultsig"];
                    dtt.Rows[swapRow]["SeqNo"] = strSeqNo;
                    dtt.Rows[swapRow]["UserID"] = strUserID;
                    dtt.Rows[swapRow]["UserName"] = strUserName;
                    dtt.Rows[swapRow]["Defaultsig"] = strDefaultsig;
                    gvPopupgrid.DataSource = dtt;
                    gvPopupgrid.DataBind();
                }
            }
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "openModalJQ('mymodaldiag1', 'myModalclass1')", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber gvSubgrid_RowCommand", ex);
        }
    }

    protected void ddlDeptshare_SelectedIndexChanged(object sender, EventArgs e)
    {
        UncheckAll(false);
        try
        {
            int DeptshareID = Convert.ToInt32(ddlDeptshare.SelectedItem.Value);
            List<InvDeptMaster> lstDeptID = new List<InvDeptMaster>();
            Master_BL objMas_BL = new Master_BL(base.ContextInfo);
            objMas_BL.GetSharedDeptID(OrgID, DeptshareID, out lstDeptID);
            foreach (var item in lstDeptID)
            {
                foreach (ListItem chkItem in ChckDeptShared.Items)
                {
                    if (item.DeptID == Convert.ToInt32(chkItem.Value))
                    {
                        chkItem.Selected = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber ddlRole_SelectedIndexChanged", ex);
        }
    }

    #endregion

    #region Fucntion

    public void LoadGrid()
    {
        string InstrumentName = string.Empty;
        long Returncode = -1;
        try
        {
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            List<InvDeptMaster> lstDIM = new List<InvDeptMaster>();
            string Nomatch = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20 == null ? "No Matching Records Found" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20;
            Returncode = MasterBL.GetManageDeptDetails(OrgID, out lstDIM);
            if (lstDIM.Count > 0)
            {
                divGrid.Style.Add("display", "block");
                grdDeptLoc.DataSource = lstDIM;
                grdDeptLoc.DataBind();
            }
            else
            {
                divGrid.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LoadGrid", ex);
        }
    }

    protected void loaddepartmentname()
    {
        try
        {
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                checkLst.DataSource = lstDpt;
                checkLst.DataTextField = "DeptName";
                checkLst.DataValueField = "DeptID";
                checkLst.DataBind();
                checkAll(false);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber loaddepartmentname", ex);
        }
    }

    private void LoadRole()
    {
        try
        {
            Role_BL roleBL = new Role_BL(base.ContextInfo);
            List<Role> lstrole = new List<Role>();
            returnCode = roleBL.GetRoleName(OrgID, out lstrole);
            if (lstrole.Count > 0)
            {
                ddlRole.DataSource = lstrole;
                ddlRole.DataTextField = "RoleDescription";
                ddlRole.DataValueField = "RoleID";
                ddlRole.DataBind();
                ddlRole.Items.Insert(0, Select);
                ddlRole.Items[0].Value = "0";
            }
            else
            {
                ddlRole.Items.Insert(0, Select);
                ddlRole.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LoadRole", ex);
        }
    }

    public void checkAll(Boolean chk)
    {
        try
        {
            foreach (ListItem item in checkLst.Items)
            {
                item.Selected = chk;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber checkAll", ex);
        }
    }

    public void LoadLocation()
    {
        try
        {
            long DeptID = 0;
            List<OrganizationAddress> lstDeptID = new List<OrganizationAddress>();
            Master_BL objMas_BL = new Master_BL(base.ContextInfo);
            objMas_BL.GetLocID(DeptID, OrgID, out lstDeptID);
            ddlLocationSig.Items.Clear();
            if (lstDeptID.Count > 0)
            {
                ddlLocationSig.DataSource = lstDeptID;
                ddlLocationSig.DataTextField = "Location";
                ddlLocationSig.DataValueField = "AddressID";
                ddlLocationSig.DataBind();
                ddlLocationSig.Items.Insert(0, Select);
                ddlLocationSig.Items[0].Value = "0";
            }
            else
            {
                ddlLocationSig.Items.Insert(0, Select);
                ddlLocationSig.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LoadLocation()", ex);
        }
    }

    public void UncheckAll(Boolean chk)
    {
        try
        {
            foreach (ListItem item in ChckDeptShared.Items)
            {
                item.Selected = chk;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber checkAll", ex);
        }
    }

    public void loadDepartments()
    {
        try
        {
            ObjPatVisit = new PatientVisit_BL(base.ContextInfo);
            returnCode = ObjPatVisit.GetDepartment(OrgID, LID, 0, out lstInvDeptMaster, out lstDeptMaster);
            if (lstDeptMaster.Count > 0)
            {
                ddlDeptName.DataSource = lstDeptMaster;
                ddlDeptName.DataTextField = "DeptName";
                ddlDeptName.DataValueField = "RoleID";
                ddlDeptName.DataBind();
                ddlDeptName.Items.Insert(0, Select);
                ddlDeptName.Items[0].Value = "0";
            }
            else
            {
                ddlDeptName.Items.Insert(0, Select);
                ddlDeptName.Items[0].Value = "0";
            }
            if (lstInvDeptMaster.Count > 0)
            {
                ddlDeptSigMap.DataSource = lstInvDeptMaster;
                ddlDeptSigMap.DataTextField = "DeptName";
                ddlDeptSigMap.DataValueField = "DeptID";
                ddlDeptSigMap.DataBind();
                ddlDeptSigMap.Items.Insert(0, Select);
                ddlDeptSigMap.Items[0].Value = "0";
            }
            else
            {
                ddlDeptSigMap.Items.Insert(0, Select);
                ddlDeptSigMap.Items[0].Value = "0";
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber loadDepartments", ex);
        }
    }

    public void ClearRoleDepMap()
    {
        ddlRole.SelectedValue = "0";
        ddlDeptshare.SelectedValue = "0";
        chkCheckAll.Checked = false;
        ChckDeptShar.Checked = false;
        checkAll(false);
        UncheckAll(false);
    }

    protected void LocationBind()
    {
        try
        {
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            List<InvDeptMaster> lstRoleDeptMap = new List<InvDeptMaster>();
            long returncode = -1;

            returncode = new Role_BL(base.ContextInfo).GetRoleLocation(OrgID, 0, Convert.ToInt64(0), out lstLocation, out lstRoleDeptMap);

            chkLocations.DataSource = lstLocation;
            chkLocations.DataTextField = "Location";
            chkLocations.DataValueField = "AddressID";
            chkLocations.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LocationBind", ex);
        }
    }

    public void LoadManageHeader()
    {
        ObjInv = new Investigation_BL(base.ContextInfo);
        try
        {
            returnCode = ObjInv.GetDepartmentHeaders(out lstManageHeader);
            if (lstManageHeader.Count > 0)
            {
                gvManageHeader.DataSource = lstManageHeader;
                gvManageHeader.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LoadManageHeader", ex);
        }
    }

    protected void ClearData()
    {
        txtDeptadd.Text = string.Empty;
        txtCode.Text = string.Empty;
    }

    protected void ClearLocTabData()
    {
        txtdeptName.Text = string.Empty;
        txtcodeDep.Text = string.Empty;
        txtDeptCode.Text = string.Empty;
        btnSaveLoc.Text = "Save";
        LocationBind();
    }

    protected void loadgrid()
    {
        try
        {
            ObjInv = new Investigation_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
            GrdDept.DataSource = lstDpt;
            GrdDept.DataBind();

            loaddept(lstDpt);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber loadgrid", ex);
        }
    }

    protected void LoadGrdSigMap()
    {
        try
        {
            List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
            Master_BL ObjInv = new Master_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSigSeqMap(OrgID, out stUsLoDep);
            GrdSigMap.DataSource = stUsLoDep;
            GrdSigMap.DataBind();
            loaddeptSeq(stUsLoDep);
            GrdSigMapLoc.DataSource = stUsLoDep;
            GrdSigMapLoc.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LoadGrdSigMap", ex);
        }
    }

    protected void loaddeptSeq(List<UserSigLocBasedDept> lstdeptseq)
    {
        try
        {
            if (lstdeptseq.Count > 0)
            {
                System.Data.DataTable dtt = new DataTable();
                DataColumn dbCol1 = new DataColumn("Id");
                DataColumn dbCol2 = new DataColumn("DeptID");
                DataColumn dbCol3 = new DataColumn("DeptName");
                DataColumn dbCol4 = new DataColumn("AddressID");
                DataColumn dbCol5 = new DataColumn("Location");
                DataColumn dbCol6 = new DataColumn("UserID");
                DataColumn dbCol7 = new DataColumn("UserName");
                DataColumn dbCol8 = new DataColumn("SeqNo");
                DataColumn dbCol9 = new DataColumn("Defaultsig");

                dtt.Columns.Add(dbCol1);
                dtt.Columns.Add(dbCol2);
                dtt.Columns.Add(dbCol3);
                dtt.Columns.Add(dbCol4);
                dtt.Columns.Add(dbCol5);
                dtt.Columns.Add(dbCol6);
                dtt.Columns.Add(dbCol7);
                dtt.Columns.Add(dbCol8);
                dtt.Columns.Add(dbCol9);
                foreach (UserSigLocBasedDept org in lstdeptseq)
                {
                    DataRow dr = dtt.NewRow();
                    dr["Id"] = org.Id;
                    dr["DeptID"] = org.DeptID;
                    dr["DeptName"] = org.DeptName;
                    dr["AddressID"] = org.AddressID;
                    dr["Location"] = org.Location;
                    dr["UserID"] = org.UserID;
                    dr["UserName"] = org.UserName;
                    dr["SeqNo"] = org.SeqNo;
                    dr["Defaultsig"] = org.Defaultsig;
                    dtt.Rows.Add(dr);
                }
                ViewState["DeptSeq"] = dtt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in DepartmentSequenceNumber loaddeptSeq", ex);
        }
    }

    protected void loaddept(List<InvDeptMaster> lstdeptseq)
    {
        try
        {
            if (lstdeptseq.Count > 0)
            {
                System.Data.DataTable dtt = new DataTable();
                DataColumn dbCol1 = new DataColumn("DeptID");
                DataColumn dbCol2 = new DataColumn("DeptName");
                DataColumn dbCol3 = new DataColumn("OrgId");
                DataColumn dbCol4 = new DataColumn("Display");
                DataColumn dbCol5 = new DataColumn("SequenceNO");
                DataColumn dbCol6 = new DataColumn("Code");

                dtt.Columns.Add(dbCol1);
                dtt.Columns.Add(dbCol2);
                dtt.Columns.Add(dbCol3);
                dtt.Columns.Add(dbCol4);
                dtt.Columns.Add(dbCol5);
                dtt.Columns.Add(dbCol6);

                foreach (InvDeptMaster org in lstdeptseq)
                {
                    DataRow dr = dtt.NewRow();
                    dr["DeptID"] = org.DeptID;
                    dr["DeptName"] = org.DeptName;
                    dr["OrgId"] = org.OrgID;
                    dr["Display"] = org.Display;
                    dr["SequenceNO"] = org.SequenceNo;
                    dr["Code"] = org.Code;
                    dtt.Rows.Add(dr);
                }
                ViewState["Reckonn"] = dtt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber loaddept", ex);
        }
    }

    protected void logInName(List<InvDeptMaster> lstdeptseq)
    {
        try
        {
            if (lstdeptseq.Count > 0)
            {
                System.Data.DataTable dtt = new DataTable();
                DataColumn dbCol1 = new DataColumn("Id");
                DataColumn dbCol2 = new DataColumn("SeqNo");
                DataColumn dbCol3 = new DataColumn("UserID");
                DataColumn dbCol4 = new DataColumn("UserName");
                DataColumn dbCol5 = new DataColumn("Defaultsig");
                dtt.Columns.Add(dbCol1);
                dtt.Columns.Add(dbCol2);
                dtt.Columns.Add(dbCol3);
                dtt.Columns.Add(dbCol4);
                dtt.Columns.Add(dbCol5);
                foreach (InvDeptMaster org in lstdeptseq)
                {
                    DataRow dr = dtt.NewRow();
                    dr["Id"] = org.DeptID;
                    dr["SeqNo"] = org.SequenceNo;
                    dr["UserID"] = org.RoleID;
                    dr["UserName"] = org.Location;
                    dr["Defaultsig"] = org.Display;
                    dtt.Rows.Add(dr);
                }
                ViewState["UserName"] = dtt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber logInName", ex);
        }
    }

    public void Load_Shared_Dept()
    {
        try
        {
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            Master_BL ObjInv = new Master_BL(base.ContextInfo);
            returnCode = ObjInv.GetSharedDept(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                ddlDeptshare.DataSource = lstDpt;
                ddlDeptshare.DataTextField = "DeptName";
                ddlDeptshare.DataValueField = "DeptID";
                ddlDeptshare.DataBind();
                ddlDeptshare.Items.Insert(0, Select);
                ddlDeptshare.Items[0].Value = "0";
            }
            else
            {
                ddlDeptshare.Items.Insert(0, Select);
                ddlDeptshare.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber loaddepartmentname", ex);
        }
    }

    public void SharedDeptBind()
    {
        try
        {
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            returnCode = ObjInv.GetDeptSequence(OrgID, out lstDpt);
            if (lstDpt.Count > 0)
            {
                ChckDeptShared.DataSource = lstDpt;
                ChckDeptShared.DataTextField = "DeptName";
                ChckDeptShared.DataValueField = "DeptID";
                ChckDeptShared.DataBind();
                checkAll(false);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while DepartmentSequenceNumber LocationBind", ex);
        }
    }

    #endregion
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;

        try
        {

            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();

            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - DepartmentSequenceNumber.aspx.cs", ex);
        }
        return configValue;
    }
}
