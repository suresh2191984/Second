using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Text.RegularExpressions;
using System.Linq;
using System.IO;
using Attune.Podium.PerformingNextAction;


public partial class Admin_OrgCreateUser : BasePage
{
    long returnCode = -1;
    string rName = string.Empty;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    LoginRole LR = new LoginRole();
    List<Users> lstUsers = new List<Users>();
    List<Users> lstUsersForExcel = new List<Users>();
    List<Organization> lstOrganization = new List<Organization>();
    List<LoginRole> lstrole = new List<LoginRole>();
    List<Role> lstroleList = new List<Role>();
    GateWay gateway;
    LoginRole loginRole = new LoginRole();
    List<LoginRole> lstLoginRole = new List<LoginRole>();
    List<Role> lstLoginRoledt = new List<Role>();
    List<Role> lstRoleID = new List<Role>();
    int iInv = 0;
    int flage = 0;
    int refclientid = -1;
    string strInvID = string.Empty;
    int currentPageNo = 1;
    //int PageSize = 10;
    int PageSize = 0;
    int totalRows = 0;
    int totalpage = 0;
    int rolid = 0;
    public Admin_OrgCreateUser()
        : base("Admin_OrgCreateUser_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        roleBL = new Role_BL(base.ContextInfo);
        gateway = new GateWay(base.ContextInfo);
        if (!IsPostBack)
        {
            CtConfig.Value = GetConfigValue("CTORG", OrgID);
            if (CtConfig.Value == "Y")
            {
                Panel4.Style.Add("display", "block");
                Panel2.Style.Add("display", "block");
            }
            else
            {
                Panel4.Style.Add("display", "none");
                Panel2.Style.Add("display", "none");
            }
            GetUserDetails();
            lblorganisation.Text = "";
            ddlorganizationbind();
            ddlorguserbind();
            //lblorganisation.Text = "All";
            lblorganisation.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001 == null ? "All" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001;
           // lbluserorgname.Text = "All";
            lbluserorgname.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001 == null ? "All" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001;
            //GetRolename();
        }
    }
    private void GetUserDetails()
    {
        try
        {
            long returnCode = -1;
            string Tex;
            Tex = "";
            int chkValue = 0;
            string pCategory = "Users";
            string DispUsrNm = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_002 == null ? "----Select UserName----" : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_002;
            //string pCategory = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_002 == null ? "Users" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_002;
            returnCode = new AdminReports_BL(base.ContextInfo).GetUserstoManage(OrgID, Tex, chkValue, PageSize, currentPageNo, pCategory, out totalRows, out lstUsers, out lstUsersForExcel);
            returnCode = new Schedule_BL(base.ContextInfo).getOrganizations(out lstOrganization);
            if (lstUsers.Count > 0)
            {

                var lstUsersquery = (from p in lstUsers
                                     select new { p.LoginID, p.LoginName })
                             .Distinct();
                //--------------------------------username
                ddlUsername.DataSource = lstUsers;
                ddlUsername.DataTextField = "LoginName";
                ddlUsername.DataValueField = "LoginID";
                ddlUsername.DataBind();
                ddlUsername.Items.Insert(0, DispUsrNm);
                ddlUsername.Items[0].Value = "0";
                //--------------------------------OrgName
                //   ddlOrgname.DataSource = lstOrganization;
                //    ddlOrgname.DataValueField = "OrgID";
                //    ddlOrgname.DataTextField = "Name";
                //    ddlOrgname.DataBind();
                //    ddlOrgname.Items.Insert(0, "----Select OrgName----");
                //--------------------------------Rolename



            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin Admin_OrgCreateUser_UserMasterHome", ex);
        }
    }
    private void GetOrgRolename()
    {
        try
        {
            returnCode = roleBL.GetRoleName(Convert.ToInt32(ddlOrgname.SelectedValue), out role);
            chkUserType.DataSource = role;
            chkUserType.DataTextField = "RoleName";
            chkUserType.DataValueField = "RoleID";
            chkUserType.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin Admin_OrgCreateUser_UserMasterHome", ex);
        }
    }
    private void GetRolename()
    {
        try
        {
            GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
            loginRole.RoleID = RoleID;
            gateway.GetLoggedInRoles(loginRole, out lstrole);
            chkUserType.DataSource = lstOrganization;
            chkUserType.DataValueField = "RoleName";
            chkUserType.DataTextField = "RoleID";
            chkUserType.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin Admin_OrgCreateUser_UserMasterHome", ex);
        }
    }
    protected void ddlOrgname_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            chkUserType.Items.Clear();
            GetOrgRolename();
            GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
            loginRole.RoleID = RoleID;
            gateway.GetLoggedInRoles(loginRole, out lstrole);
            ChkRoleUserType.DataSource = lstrole;
            ChkRoleUserType.DataValueField = "RoleID";
            ChkRoleUserType.DataTextField = "RoleName";
            ChkRoleUserType.DataBind();
            gvAllUsers.DataSource = lstrole;
            gvAllUsers.DataBind();
            foreach (ListItem item in ChkRoleUserType.Items)
            {
                foreach (ListItem items in chkUserType.Items)
                {

                    if (item.Value == items.Value)
                    {
                        items.Selected = true;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin_OrgCreateUser_RoleName", ex);
        }
    }
    protected void Save_Click(object sender, EventArgs e)
    {
        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
        string UsrMsgs = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_05 == null ? "Saved successfully." : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_05;
        string UsrMsgs1 = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_06 == null ? "Any One Role Select." : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_06;
        string UsrMsgs2 = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_07 == null ? "Update Sucessfully." : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_07;
        string TextUpdate=Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
        string Textsave = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01;
        try
        {
            if (Save.Text ==Textsave)// "Save")
            {
                for (int i = 0; i < chkUserType.Items.Count; i++)
                {
                    if (chkUserType.Items[i].Selected == true)
                    {
                        flage = 1;
                    }
                }
                if (flage == 1)
                {
                    for (int i = 0; i < chkUserType.Items.Count; i++)
                    {
                        //if (chkUserType.Items[i].Selected == true)
                        //{

                            List<LoginRole> LoginRole = new List<LoginRole>();
                            LR.RoleID = Convert.ToInt32(chkUserType.SelectedValue);
                            LR.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
                            LR.CreatedBy = LID;
                            LR.ModifiedBy = LID;
                            if (chkUserType.Items[i].Selected == true)
                            {
                                LR.Status = 'A'.ToString();
                            }
                            else
                            {
                                LR.Status = 'D'.ToString();
                            }
                          

                            string RoleName = chkUserType.Items[i].Text;
                            returnCode = new Role_BL(base.ContextInfo).SaveLoginRole(LR);
                            if (HdnCtConfig.Value == "Y" && RoleName == "Project Assistant")
                            {
                                Communication(LR.LoginID, LR.RoleID, "SaveLoginRole");
                            }
                            chkUserType.Items.Clear();
                            GetOrgRolename();
                            GateWay gateway = new GateWay(base.ContextInfo);
                            LoginRole loginRole = new LoginRole();
                            loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue.ToString());
                            loginRole.RoleID = 0;
                            gateway.GetLoggedInRoles(loginRole, out lstrole);
                            ChkRoleUserType.DataSource = lstrole;
                            ChkRoleUserType.DataValueField = "RoleID";
                            ChkRoleUserType.DataTextField = "RoleName";
                            ChkRoleUserType.DataBind();
                            gvAllUsers.DataSource = lstrole;
                            gvAllUsers.DataBind();
                            ddlOrgname.SelectedIndex = 0;
                       // }

                    }
                     ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs + "','" + Information + "');", true);
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('saved successfully.');", true);
                    for (int i = 0; i < chkUserType.Items.Count; i++)
                    {
                        chkUserType.Items[i].Selected = false;
                    }
                    Save.Text = TextUpdate;
                }
                else
                {
                   // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Any One Role Select.');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs1 + "','" + Information + "');", true);

                }
            }
            else
            {
                for (int i = 0; i < chkUserType.Items.Count; i++)
                {
                    //if (chkUserType.Items[i].Selected == true)
                    //{
                        List<LoginRole> LoginRole = new List<LoginRole>();
                        LoginRole LR1 = new LoginRole();
                        LR.RoleID = Convert.ToInt32(chkUserType.Items[i].Value.ToString());
                        LR.LoginID = Convert.ToInt32(ddlUsername.SelectedValue.ToString());
                        LR.CreatedBy = LID;
                        LR.ModifiedBy = LID;
                        if (chkUserType.Items[i].Selected == true)
                        {
                            LR.Status = 'A'.ToString();
                            returnCode = new Role_BL(base.ContextInfo).SaveLoginRole(LR);
                        }
                        else
                        {
                            LR.Status='D'.ToString();
                            returnCode = new Role_BL(base.ContextInfo).SaveLoginRole(LR);
                        }

                        returnCode = new Role_BL(base.ContextInfo).SaveLoginRole(LR);

                        string RoleName = chkUserType.Items[i].Text;
                        if (HdnCtConfig.Value == "Y" && RoleName == "Project Assistant")
                        {
                            Communication(LR1.LoginID, LR1.RoleID, "SaveLoginRole");
                        }

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs2 + "','" + Information + "');", true);
                Save.Text = TextUpdate;
                        ddlOrgname.SelectedIndex = 0;
                    //}
                }
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Update Sucessfully.');", true);
                //Save.Text = "Update";
                //ddlOrgname.SelectedIndex = 0;
            }
            ddlUsername_SelectedIndexChanged(this, EventArgs.Empty);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin_OrgCreate_Save", ex);
        }

    }
    protected long Communication(long pLoginID, long pRoleID, string ButtonValue)
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();
        long LoginID = -1;
        LoginID = LID;
        PC.PatientID = pLoginID;
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.OrgID = OrgID;
        PC.ButtonName = Save.ID;
        PC.ButtonValue = ButtonValue;// btnFinish.Text;
        PC.ID = pRoleID;
        PC.PageID = PageID;// Convert.ToInt64(hdnProtocalID.Value);
        PC.ActionType = "";
        PC.ContextType = "EPI";
        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string TextUpdate = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
        string TextEdit = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_003 == null ? "Edit" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_003;
        
        for (int i = 0; i < chkUserType.Items.Count; i++)
        {
            chkUserType.Items[i].Selected = false;
        }
        chkUserType.Items.Clear();
        GetOrgRolename();
        GateWay gateway = new GateWay(base.ContextInfo);
        LoginRole loginRole = new LoginRole();
        loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue.ToString());
        loginRole.RoleID = RoleID;
        gateway.GetLoggedInRoles(loginRole, out lstrole);
        ChkRoleUserType.DataSource = lstrole;
        ChkRoleUserType.DataValueField = "RoleID";
        ChkRoleUserType.DataTextField = "RoleName";
        ChkRoleUserType.DataBind();
        gvAllUsers.DataSource = lstrole;
        gvAllUsers.DataBind();
        Save.Text = TextUpdate;// "Update";
        btnUpdate.Text = TextEdit;// "Edit";
    }
    protected void ddlUsername_SelectedIndexChanged(object sender, EventArgs e)
    {
        chkUserType.Items.Clear();
        GetOrgRolename();
        GateWay gateway = new GateWay(base.ContextInfo);
        LoginRole loginRole = new LoginRole();
        loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
        loginRole.RoleID = RoleID;
        gateway.GetLoggedInRoles(loginRole, out lstrole);
        ChkRoleUserType.DataSource = lstrole;
        ChkRoleUserType.DataValueField = "RoleID";
        ChkRoleUserType.DataTextField = "RoleName";
        ChkRoleUserType.DataBind();
        gvAllUsers.DataSource = lstrole;
        gvAllUsers.DataBind();
        foreach (ListItem item in ChkRoleUserType.Items)
        {
            foreach (ListItem items in chkUserType.Items)
            {

                if (item.Value == items.Value)
                {
                    items.Selected = true;
                }
            }
        }
    }
    protected void btnCreateNew_Click(object sender, EventArgs e)
    {
        string Textsave = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01;
        
        Save.Text = Textsave;// "Save";
        for (int i = 0; i < chkUserType.Items.Count; i++)
        {
            chkUserType.Items[i].Selected = false;
        }

    }


    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string TextUpdate = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
        string TextDelete = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_004 == null ? "Delete" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_004;

        Save.Text = TextUpdate;// "Update";
        loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
        loginRole.RoleID = RoleID;
        gateway.GetLoggedInRoles(loginRole, out lstrole);
        ChkRoleUserType.DataSource = lstrole;
        ChkRoleUserType.DataValueField = "RoleID";
        ChkRoleUserType.DataTextField = "RoleName";
        ChkRoleUserType.DataBind();
        foreach (ListItem item in ChkRoleUserType.Items)
        {
            foreach (ListItem items in chkUserType.Items)
            {

                if (item.Value == items.Value)
                {
                    items.Selected = true;
                }
            }
        }
        if (btnUpdate.Text == TextDelete)//"Delete")
        {
            long lresult = -1;
            long returnCode = -1;
            long logID = -1;
            string rName = string.Empty;
            logID = Convert.ToInt32(ddlUsername.SelectedValue);
            rName = ddlUsername.SelectedItem.ToString();
            string[] rNam;
            rNam = Regex.Split(rName, "([0-9])");
            rName = rNam[0];
            int pCount = -1;
            int pCountRole = -1;
            long ModifiedBy = LID;
            long OrgID = Convert.ToInt32(ddlOrgname.SelectedValue);
            for (int i = 0; i < chkUserType.Items.Count; i++)
            {
                if (chkUserType.Items[i].Selected == true)
                {

                    string txt = chkUserType.Items[i].Text;
                    long oroleID = 0;
                    returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(logID, OrgID, txt, oroleID, ModifiedBy);

                    chkUserType.Items.Clear();
                    GetOrgRolename();
                    loginRole.LoginID = Convert.ToInt32(ddlUsername.SelectedValue);
                    loginRole.RoleID = 0;
                    gateway.GetLoggedInRoles(loginRole, out lstrole);
                    ChkRoleUserType.DataSource = lstrole;
                    ChkRoleUserType.DataValueField = "RoleID";
                    ChkRoleUserType.DataTextField = "RoleName";
                    ChkRoleUserType.DataBind();
                    gvAllUsers.DataSource = lstrole;
                    gvAllUsers.DataBind();
            string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
            string UsrMsgs2 = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_08 == null ? "Delete Role Sucessfully." : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_08;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs2 + "','" + Information + "');", true);
                    ddlOrgname.SelectedIndex = 0;
                }
            }
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Delete Role successfully.');", true);
            //ddlOrgname.SelectedIndex = 0;
        }
        btnUpdate.Text = TextDelete;// "Delete";
    }
    public void ddlorganizationbind()
    {
        string DispOrgNm = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003 == null ? "--- Select Org Name ---" : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003;
        if (rdbcro.Checked == true)
        {
            refclientid = 5;
        }
        else if (rdbstudy.Checked == true)
        {
            refclientid = 1;
        }
        else
        {
            refclientid = -1;
        }
        returnCode = new Schedule_BL(base.ContextInfo).getOrganizationsWithType(refclientid, out lstOrganization);
        ddlOrgname.DataSource = lstOrganization;
        ddlOrgname.DataValueField = "OrgID";
        ddlOrgname.DataTextField = "Name";
        ddlOrgname.DataBind();
        ddlOrgname.Items.Insert(0, DispOrgNm);
        ddlOrgname.Items[0].Value = "0";
    }
    protected void rdbcro_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbcro.Checked == true)
        {
            lblorganisation.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_005 == null ? "CRO" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_005;//"CRO";
            rdbstudy.Checked = false;
            rdball.Checked = false;
            ddlorganizationbind();
        }
    }
    protected void rdbstudy_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbstudy.Checked == true)
        {
            lblorganisation.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_006 == null ? "Study" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_006;//"Study";
            rdbcro.Checked = false;
            rdball.Checked = false;
            ddlorganizationbind();
        }
    }
    protected void rdball_CheckedChanged(object sender, EventArgs e)
    {
        if (rdball.Checked == true)
        {
            lblorganisation.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001 == null ? "All" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001;//"ALL";
            rdbcro.Checked = false;
            rdbstudy.Checked = false;
            ddlorganizationbind();
        }
    }

    protected void rdbuserCRO_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbuserCRO.Checked == true)
        {
            lbluserorgname.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_005 == null ? "CRO" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_005;//"CRO";
            rdbuserStudy.Checked = false;
            rdbuserAll.Checked = false;
            ddlorguserbind();
        }
    }
    protected void rdbuserStudy_CheckedChanged(object sender, EventArgs e)
    {
        if (rdbuserStudy.Checked == true)
        {
            lbluserorgname.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_006 == null ? "Study" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_006;//"Study";
            rdbuserCRO.Checked = false;
            rdbuserAll.Checked = false;
            ddlorguserbind();
        }
    }
    protected void rdbuserAll_CheckedChanged(object sender, EventArgs e)
    {
        if (rdball.Checked == true)
        {
            lbluserorgname.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001 == null ? "All" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_001;//"ALL";
            rdbuserCRO.Checked = false;
            rdbuserStudy.Checked = false;
            ddlorguserbind();
        }
    }
    public void ddlorguserbind()
    {
        string DispOrgNm = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003 == null ? "--- Select Org Name ---" : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003;
        if (rdbuserCRO.Checked == true)
        {
            refclientid = 5;
        }
        else if (rdbuserStudy.Checked == true)
        {
            refclientid = 1;
        }
        else
        {
            refclientid = -1;
        }
        returnCode = new Schedule_BL(base.ContextInfo).getOrganizationsWithType(refclientid, out lstOrganization);
        ddluserorgname.DataSource = lstOrganization;
        ddluserorgname.DataValueField = "OrgID";
        ddluserorgname.DataTextField = "Name";
        ddluserorgname.DataBind();
        ddluserorgname.Items.Insert(0, DispOrgNm);
        ddluserorgname.Items[0].Value = "0";
    }
    protected void ddluserorgname_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            chkuserorg.Items.Clear();
            GetuserOrgRolename();
            GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = Convert.ToInt64(ddluserorgname.SelectedValue);
            loginRole.RoleID = RoleID;
            gateway.GetLoggedInRoles(loginRole, out lstrole);
            chkuserroleorg.DataSource = lstrole;
            chkuserroleorg.DataValueField = "RoleID";
            chkuserroleorg.DataTextField = "RoleName";
            chkuserroleorg.DataBind();
            //gvAllUsers.DataSource = lstrole;
            //gvAllUsers.DataBind();
            foreach (ListItem item in chkuserroleorg.Items)
            {
                foreach (ListItem items in chkuserorg.Items)
                {

                    if (item.Value == items.Value)
                    {
                        items.Selected = true;
                    }
                }
            }
            GridViewDetails.Style.Add("display", "none");
            GrdFooter.Style.Add("display", "none");
            chkall.Style.Add("display", "none");

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin_OrgCreateUser_RoleName", ex);
        }
    }
    private void GetuserOrgRolename()
    {
        Role_BL RoleBl = new Role_BL(base.ContextInfo);
        try
        {
            returnCode = roleBL.GetRoleName(Convert.ToInt32(ddluserorgname.SelectedValue), out role);
            chkuserorg.DataSource = role;
            chkuserorg.DataTextField = "RoleName";
            chkuserorg.DataValueField = "RoleID";
            chkuserorg.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin Admin_OrgCreateUser_UserMasterHome", ex);
        }
    }
    protected void chkuserorg_SelectedIndexChanged(object sender, EventArgs e)
    {

        foreach (ListItem lstValue in chkuserorg.Items)
        {
            if (lstValue.Selected)
            {
                Role Role = new Role();
                iInv = Convert.ToInt32(lstValue.Value);
                Role.RoleID = iInv;
                //  strInvID += iInv + ",";
                lstRoleID.Add(Role);
            }
        }
        GridViewDetails.Style.Add("display", "block");
        hdnCurrent.Value = "";
        txtpageNo.Text = "";
        LoadGrid(e, currentPageNo, PageSize);
        //GridBind();

    }
    protected void GridViewDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Role BMaster = (Role)e.Row.DataItem;
                var childItems = from child in lstroleList
                                 where child.RoleID == BMaster.RoleID
                                 select child;


                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;

                childGrid.DataBind();
                ;
            }
        }

        catch (Exception ee)
        {
            CLogger.LogError("Error while loading grid", ee);
        }
    }
    protected void GridViewDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            GridViewDetails.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            LoadGrid(e, currentPageNo, PageSize);
        }
    }
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        string DispOrgNm = Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003 == null ? "--- Select Org Name ---" : Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_003;
        long returnCode = -1;
        Role_BL RoleBL = new Role_BL(base.ContextInfo);
        //string Packagename = txtpackagename.Text;
        string Pname = string.Empty;
        int ClientTypeID = 0;
        int ClientID = 0;
        //string status = ddlstatus.SelectedValue;
        //string packagecode = txtpackagecode.Text;
        int pkgid = 0;
        int pOrgID = 0;
        PageSize = 10;
        if (ddluserorgname.SelectedItem.Value != DispOrgNm)
        {
            pOrgID = Convert.ToInt32(ddluserorgname.SelectedItem.Value);
        }
        returnCode = RoleBL.SearchUserDetail(pOrgID, lstRoleID, out lstroleList, out lstLoginRole, PageSize, currentPageNo, out totalRows, Pname);

        if (lstroleList.Count > 0)
        {
            GrdFooter.Style.Add("display", "block");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            //else
            //{
            //    lblCurrent.Text = hdnCurrent.Value;
            //    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            //}
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
        if (lstroleList.Count > 0)
        {

            IEnumerable<Role> FilterValue = (from list in lstroleList
                                             group list by new
                                             {
                                                 list.RoleName,
                                                 list.RoleID,

                                             } into g1
                                             select new Role
                                             {
                                                 RoleName = g1.Key.RoleName,
                                                 RoleID = g1.Key.RoleID,
                                             }).ToList();


            lstLoginRoledt = FilterValue.ToList();
            GridViewDetails.Visible = true;
            lblResult.Style.Add("display", "none");
            GridViewDetails.DataSource = lstLoginRoledt;
            GridViewDetails.DataBind();

        }
        else
        {
            GridViewDetails.Visible = false;
            lblResult.Style.Add("display", "block");
            lblResult.Text = Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_007 == null ? "No matching records found" : Resources.Admin_ClientDisplay.Admin_OrgCreateUser_aspx_007;//"No matching records found";
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        PageSize = 10;
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {

        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            chkuserorg_SelectedIndexChanged(sender, e);
            // LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            chkuserorg_SelectedIndexChanged(sender, e);
            //LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            chkuserorg_SelectedIndexChanged(sender, e);
            // LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            chkuserorg_SelectedIndexChanged(sender, e);
            //LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        currentPageNo = Convert.ToInt32(hdnCurrent.Value);
        // LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        chkuserorg_SelectedIndexChanged(sender, e);
    }
}
