using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
public partial class CommonControls_LocationUserMap : BaseControl
{
    public CommonControls_LocationUserMap()
        : base("CommonControls_LocationUserMap_ascx")
    {
    }
    List<OrganizationAddress> lstLocation;
    List<Role> lstRoleLocation;
    PatientVisit_BL PatientVisitBL;
    static List<Role> RL = new List<Role>();
    List<InvDeptMaster> lstRoleDeptMap = new List<InvDeptMaster>();
    List<InvDeptMaster> lstInvDeptMaster;
    List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
    string strSelectRole = Resources.CommonControls_AppMsg.CommonControls_LocationUserMap_ascx_12 == null ? "--Select Role--" : Resources.CommonControls_AppMsg.CommonControls_LocationUserMap_ascx_12;
    string stralert = Resources.CommonControls_AppMsg.CommonControls_LocationUserMap_ascx_13 == null ? "Successfully updated !!" : Resources.CommonControls_AppMsg.CommonControls_LocationUserMap_ascx_13;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void getUserLocation(int OrgID, string LoginName, long loginID, List<Role> SelectedRoles)
    {
        long returnCode = -1; 
        hdnLoginName.Value = loginID.ToString();
        long RlId = -1;
        lblUser.Text = LoginName;
        PatientVisitBL = new PatientVisit_BL(base.ContextInfo);
        lstLocation = new List<OrganizationAddress>();
        lstInvDeptMaster = new List<InvDeptMaster>();
        RL = SelectedRoles;
        drpRole.DataSource = SelectedRoles;
        drpRole.DataTextField = "RoleName";
        drpRole.DataValueField = "RoleID";
        drpRole.DataBind();
        drpRole.Items.Insert(0, new ListItem(strSelectRole, "0"));
        try
        {
            pnlLocations.Style.Add("display", "none");
            returnCode = PatientVisitBL.GetLocation(OrgID, loginID, RlId, out lstLocation);
            if (lstLocation.Count > 0)
            {
                chkLocations.DataSource = lstLocation;
                chkLocations.DataTextField = "Location";
                chkLocations.DataValueField = "AddressID";
                chkLocations.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LocationUserMap while execute GetLocation()", ex);
        }
        try
        {
            pnlDepts.Style.Add("display", "none");
            returnCode = PatientVisitBL.GetDepartment(OrgID, loginID, RlId, out lstInvDeptMaster, out lstDeptMaster);
            if (lstLocation.Count > 0)
            {
                chkDepartment.DataSource = lstInvDeptMaster;
                chkDepartment.DataTextField = "DeptName";
                chkDepartment.DataValueField = "DeptID";
                chkDepartment.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LocationUserMap while execute GetDepartment()", ex);
        }
    }
    protected void btnSaveLocations_Click(object sender, EventArgs e)
    {
        try
        {
            lstRoleLocation = new List<Role>();
            PatientVisitBL = new PatientVisit_BL(base.ContextInfo);
            lstInvDeptMaster = new List<InvDeptMaster>();
            long returnCode = -1;
            Role lstorg;
            Role lstorg1;
            foreach (ListItem lstItem in chkLocations.Items)
            {
                lstorg = new Role();
                lstorg.RoleID = Convert.ToInt64(drpRole.SelectedValue);
                lstorg.OrgAddressID = Convert.ToInt32(lstItem.Value);
                lstorg.ParentID = 0;
                lstorg.Description = lstItem.Selected == true ? "Y" : "N";
                lstRoleLocation.Add(lstorg);
            }
            foreach (ListItem lstDeptItem in chkDepartment.Items)
            {
                lstorg1 = new Role();
                lstorg1.OrgAddressID = 0;
                lstorg1.RoleID = Convert.ToInt64(drpRole.SelectedValue);
                lstorg1.ParentID = Convert.ToInt64(lstDeptItem.Value);
                lstorg1.Description = lstDeptItem.Selected == true ? "Y" : "N";
                lstRoleLocation.Add(lstorg1);
            }
            returnCode = PatientVisitBL.SaveRoleDeptLocationMap(OrgID, lstRoleLocation, Convert.ToInt64(hdnLoginName.Value)); 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LocationUserMap while execute SaveRoleDeptLocationMap()", ex);
        }
        tdMsg.Style.Add("display", "block");
        lblMsg.Text = stralert;
        btnSaveLocations.Enabled = false;
        getUserLocation(OrgID, lblUser.Text, Convert.ToInt64(hdnLoginName.Value), RL);
    }
    protected void drpRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            tdMsg.Style.Add("display", "none");
            lblMsg.Text = "";
            string flagLoc = "0";
            string flagDept = "0";
            long RoleID = Convert.ToInt64(drpRole.SelectedValue);
            if (RoleID > 0)
            {
                btnSaveLocations.Enabled = true;
                new Role_BL(base.ContextInfo).GetRoleLocation(OrgID, RoleID, Convert.ToInt64(hdnLoginName.Value), out lstLocation, out lstRoleDeptMap);

                chkLocations.DataSource = lstLocation;
                chkLocations.DataTextField = "Location";
                chkLocations.DataValueField = "AddressID";
                chkLocations.DataBind();

                chkDepartment.DataSource = lstRoleDeptMap;
                chkDepartment.DataTextField = "DeptName";
                chkDepartment.DataValueField = "DeptID";
                chkDepartment.DataBind();

                foreach (ListItem li in chkLocations.Items)
                {
                    string LcID = li.Value;
                    li.Selected = lstLocation.Exists(p => p.AddressID.ToString() == LcID && p.Comments == "Y") ? true : false;
                    li.Attributes.Add("onclick", "SelectLocations();");
                    if (li.Selected == false)
                    {
                        flagLoc = "1";
                    }
                }
                if (chkLocations.Items.Count > 0)
                {
                    pnlLocations.Style.Add("display", "table-cell");
                }
                else
                {
                    pnlLocations.Style.Add("display", "none");
                }



                foreach (ListItem Dli in chkDepartment.Items)
                {
                    string DID = Dli.Value;
                    Dli.Selected = lstRoleDeptMap.Exists(p => p.DeptCode == "Y" && p.DeptID.ToString() == DID) ? true : false;
                    Dli.Attributes.Add("class", "");
                    Dli.Attributes.Add("onclick", "SelectDept();");
                   
                  //  Dli.Attributes.Add("class", "checkbox1");
                    if (Dli.Selected == false)
                    {
                        flagDept = "1";
                    }
                }
                if (chkDepartment.Items.Count > 0)
                {
                    pnlDepts.Style.Add("display", "table-cell");
                }
                else
                {
                    pnlDepts.Style.Add("display", "none");
                }




                if (lstLocation.Count > 0)
                {
                    chkAllLocations.Checked = flagLoc == "0" ? true : false;
                }
                else
                {
                    chkAllLocations.Checked = false;
                }
                if (lstRoleDeptMap.Count > 0)
                {
                    chkAllDepartments.Checked = flagDept == "0" ? true : false;
                }
                else
                {
                    chkAllDepartments.Checked = false;
                }
            }
            else
            {
                foreach (ListItem Dli in chkDepartment.Items)
                {
                    Dli.Selected = false;
                }
                foreach (ListItem li in chkLocations.Items)
                {
                    li.Selected = false;
                }
                chkAllDepartments.Checked = false;
                chkAllLocations.Checked = false;
                btnSaveLocations.Enabled = false;
                pnlLocations.Style.Add("display", "none");
                pnlDepts.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LocationUserMap while execute GetRoleLocation()", ex);
        }
    }
}