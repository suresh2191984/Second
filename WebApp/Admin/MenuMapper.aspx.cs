using System;
using System.Data;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;

public partial class Admin_MenuMapper : BasePage
{
    string Save_Msg = Resources.AppMessages.Save_Message;
    string Update_Msg = Resources.AppMessages.Update_Message;
    string Error_Save_Msg = Resources.AppMessages.Failed_Message;
    string strAlert = Resources.Admin_AppMsg.Admin_MenuMapper_aspx_Alert;
    public Admin_MenuMapper()
        : base("Admin_MenuMapper_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    List<RoleMenuInfo> lstRoleInfo = new List<RoleMenuInfo>();
    List<RoleMenuInfo> lstRoleMenuInfo = new List<RoleMenuInfo>();
    List<RoleMenuInfo> lstRoleMenuInfoAll = new List<RoleMenuInfo>();
    List<MenuMasterHeader> lstMenuMasterHeader = new List<MenuMasterHeader>();
    protected void Page_Load(object sender, EventArgs e)
    {
        string strSelectRole = Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01 == null ? "----Select Role----" : Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01;
        if (!IsPostBack)
        {
            LoadPageURL(OrgID);
            btnAddRole.Style.Add("display", "none");
            txtAddNewRole.Style.Add("display","none");
            txtRoleDescription.Style.Add("display", "none");
            /*Ajit Add*/
            astric.Style.Add("display", "none");
            /**/
            lblDescription.Style.Add("display", "none");
            lblAddRole.Style.Add("display", "none");
            lblMessage.Text = "";
             LoadOrganization(ddlOrganisation); // No need to call loading of Organization as the control is removed.
           // ddlRole.Items.Insert(0, "----Select Role----");
             ddlRole.Items.Insert(0, strSelectRole);
            // Load all the Roles for the logged in Organization
            LoadRoles(ddlRole, OrgID); // Pass the OrgID from the Basepage which in turn has this in Session
        }
    }
    private void LoadOrganization(DropDownList ddlOrg)
    {
        string strSelectOrg = Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_02 == null ? "--Select An Organization--" : Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_02;
        try
        {
            List<Organization> lstOrg = new List<Organization>();
            new Schedule_BL(base.ContextInfo).getOrganizations(out lstOrg);
            if (lstOrg.Count > 0)
            {
                var lstOrgs = lstOrg.Where(a => a.OrgID == OrgID).ToList();
                ddlOrg.DataSource = lstOrgs;
                //ddlOrg.DataSource = lstOrg;
                ddlOrg.DataTextField = "Name";
                ddlOrg.DataValueField = "OrgID";
                ddlOrg.DataBind();
                //ddlOrg.Items.Insert(0, "--Select An Organization--");
                ddlOrg.Items.Insert(0, strSelectOrg);
                ddlOrg.SelectedValue = OrgID.ToString();
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    private void LoadRoles(DropDownList ddlControl,int pOrgID)
    {
        string strSelectRole = Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01 == null ? "----Select Role----" : Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01;

        try
        {
            hdnPageUrl.Value = "";
            List<Role> lstRole = new List<Role>();
            new Role_BL(base.ContextInfo).GetRoleNameForMenuMapper(pOrgID, out lstRole);
            if (lstRole.Count > 0)
            {
                ddlControl.Items.Clear();
                ddlControl.DataSource = lstRole;
                ddlControl.DataTextField = "RoleName";
                ddlControl.DataValueField = "RoleID";
                ddlControl.DataBind();

                if (ddlControl.Items.Contains(ddlControl.Items.FindByText("Billing")))
                {
                    ddlControl.Items.FindByText("Billing").Enabled = false;
                }
                //ddlControl.Items.Insert(0, "----Select Role----");
                ddlControl.Items.Insert(0, strSelectRole);
                ddlControl.SelectedValue = "----Select Role----";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlRole.SelectedIndex != 0)
            {
                lblMessage.Text = "";
                new Role_BL(base.ContextInfo).GetMenuMapperInfo(Convert.ToInt64(ddlRole.SelectedValue), int.Parse(ddlOrganisation.SelectedValue), out lstRoleMenuInfo, out lstRoleMenuInfoAll,out lstRoleInfo);
                if (lstRoleInfo.Count > 0)
                {
                    hdnPageUrl.Value = lstRoleInfo[0].Description;
                }
                if (lstRoleMenuInfoAll.Count > 0)
                {
                    ucMenuItems.BindMenuList(lstRoleMenuInfo,lstRoleMenuInfoAll,Convert.ToInt64(ddlRole.SelectedValue),int.Parse(ddlOrganisation.SelectedValue));
                    divSubmit.Visible = true;
                    divHolder.Visible = true;
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        int pSeqNo = 1;
        int pParentID = 1;
        int pPageID = 0;
        string pDisplayText = string.Empty;
        string pPageURL = string.Empty;
        try
        {
            if (drpPageUrl.SelectedIndex == 0)
            {
                pDisplayText = hdnPageUrl.Value.Split('^')[4].Split('~')[1];
                pPageURL = hdnPageUrl.Value.Split('^')[5].Split('~')[1];
            }
            if (drpPageUrl.SelectedIndex > 0)
            {
                pPageID = int.Parse(drpPageUrl.SelectedValue.Split('~')[0]);
                pDisplayText = drpPageUrl.SelectedItem.Text;
                pPageURL = drpPageUrl.SelectedValue.Split('~')[1];
            }
            lstRoleMenuInfo = ucMenuItems.GetMenuItems();
            returnCode = new Role_BL(base.ContextInfo).SaveMenuMapperInfo(Convert.ToInt64(ddlRole.SelectedValue),
                                   int.Parse(ddlOrganisation.SelectedValue), pPageID, pSeqNo,
                                   pDisplayText, pPageURL, pParentID, lstRoleMenuInfo);
            if (returnCode >= 0)
            {
                HttpContext.Current.Cache.Remove("MenuCacheNewFile");
                // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success", "alert('"+Update_Msg+"');", true);  ------>Commented by GowthamRaj
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success", "alert('Changes saved successfully.');", true);
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success", "javascript:ValidationWindow('" + Update_Msg + "','"+strAlert+"');", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Failed", "javascript:ValidationWindow('" + Error_Save_Msg + "','" + strAlert + "');", true);
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Failed", "alert('There is a problem saving the data');", true);
            }
            ddlOrganisation_SelectedIndexChanged(sender, e);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
   
    protected void btnCancelOne_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    
    protected void ddlOrganisation_SelectedIndexChanged(object sender, EventArgs e)
    {
        drpPageUrl.SelectedIndex = 0;
        lstRoleMenuInfo.Clear();
        if (ddlOrganisation.SelectedIndex != 0)
        {
            divSubmit.Visible = false;
            ddlRole.Enabled = true;
            divHolder.Visible = false;
            LoadRoles(ddlRole, int.Parse(ddlOrganisation.SelectedValue));
        }
        else
        {
            ddlRole.Enabled = false;
        }
    }
    protected void btnAddRole_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            int Organisation= int.Parse(ddlOrganisation.SelectedValue);
            string Desc = txtRoleDescription.Text.Trim();
            returnCode = new Role_BL(base.ContextInfo).SaveRole(txtAddNewRole.Text, Organisation, Desc, OrgID);
            if (returnCode > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "TestStr", "javascript:ValidationWindow('" + Save_Msg + "','"+strAlert+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "TestStr","javascript:alert('Role Added Successfully');", true);
            }
            chkAddNew.Checked = false;
            txtAddNewRole.Text = "";
            txtRoleDescription.Text = "";
            ddlOrganisation_SelectedIndexChanged(sender,e);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void LoadPageURL(int orgID)
    {
        long returnCode = -1;
        List<Role> lstPages = new List<Role>();
        string strSelectDef = Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_03 == null ? "----Default Page----" : Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_03;
        try
        {
            returnCode = new Role_BL(base.ContextInfo).LoadPageURL(orgID, out lstPages);
            if (returnCode == 0)
            {
                drpPageUrl.DataSource = lstPages;
                drpPageUrl.DataTextField = "OrgName";
                drpPageUrl.DataValueField = "Description";
                drpPageUrl.DataBind();
                //drpPageUrl.Items.Insert(0, "----Default Page----");
                drpPageUrl.Items.Insert(0, strSelectDef);
                drpPageUrl.SelectedValue ="0";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
