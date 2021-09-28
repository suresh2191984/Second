using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class CommonControls_UserRoleChange : BaseControl
{
    string styleClass = string.Empty;
    string styleMidClass = string.Empty;
    // GateWay gateWay = new GateWay(base.ContextInfo);
	// GateWay gateWay;
    Nurse nurse = new Nurse();
    List<Users> lstUsers = new List<Users>();
    PhysicianSchedule physician = new PhysicianSchedule();
    long loginID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            leftDiv.Attributes.Add("Class", CSSStyle);
            //divRoles.Attributes.Add("Class", styleMidClass);

            if (IsPostBack == false)
            {
                long loginid = LID;

                GateWay gateway = new GateWay(base.ContextInfo);
                LoginRole loginRole = new LoginRole();
                loginRole.LoginID = loginid;
                loginRole.RoleID = RoleID;
                List<LoginRole> lstrole = new List<LoginRole>();

                gateway.GetLoggedInRoles(loginRole, out lstrole);
                if (lstrole.Count > 0)
                {
                    leftDiv.Visible = true;
                    rptRole.DataSource = lstrole;
                    rptRole.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading UserRoleChangeControl", ex);

        }
    }
    
    protected void rptRole_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
		GateWay gateWay = new GateWay(base.ContextInfo);
        try
        {
            long returncode = 0;
            long returnCode1 = -1;
            string path = string.Empty;
            string orgName = string.Empty;
            if (e.CommandName == "go")
            {
                Role loginrole = new Role();
                Label lblRoleid = (Label)e.Item.FindControl("lblRole");
                loginrole.OrgName = ((Label)e.Item.FindControl("lblOrgName")).Text;
                loginrole.OrgID = Convert.ToInt32(((Label)e.Item.FindControl("lblOrgID")).Text);
                loginrole.RoleName = ((Label)e.Item.FindControl("lblRoleName")).Text;
                loginrole.Description = ((Label)e.Item.FindControl("lblRoleDesc")).Text;
                loginrole.RoleID =Int32.Parse(lblRoleid.Text);
                //string str = lblRoleid.Text.ToString();



                /********************************** MOOVENDAN **********************************/
                //PatientVisit_BL patientBL = new PatientVisit_BL();
                //List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                //long LocID = 0;
                //string LocName = string.Empty;
                //returnCode1 = patientBL.GetLocation(loginrole.OrgID, LID, Convert.ToInt64(lblRoleid.Text), out lstLocation); 
                //if (lstLocation.Count > 0)
                //{
                //    LocID = lstLocation[0].AddressID;
                //    LocName = lstLocation[0].Location;
                //    foreach (OrganizationAddress lstLoc in lstLocation)
                //    {
                //        if (lstLoc.AddressID == ILocationID)
                //        {
                //            LocID = lstLoc.AddressID;
                //            LocName = lstLoc.Location;
                //        }
                //    }
                //}
                //Session.Add("LocationID", LocID);
                //Session.Add("LocationName", LocName);
                //Session.Add("InventoryLocationID", "-1");


                /********************************** MOOVENDAN **********************************/


                if (OrgID != loginrole.OrgID)
                {

                    Department2.OrgID = loginrole.OrgID;
                    Department2.URoleID = loginrole.RoleID;
                    //Department2.LoadLocationsAndRoles();

                    //Department2.LocationID = loginrole.
                }
                else
                {

                 


                Session.Add("RoleId", lblRoleid.Text.ToString());
                Session.Add("OrgID", loginrole.OrgID.ToString());
                Session.Add("OrgName", loginrole.OrgName);
                Session.Add("RoleName", loginrole.RoleName.ToString());
                Session.Add("RoleDescription", loginrole.Description.ToString());
                //Session.Add("LocationID", ddlLocation.SelectedValue.ToString());

                loginrole.RoleID = Convert.ToInt64(lblRoleid.Text);
                List<Role> lstLoginRole = new List<Role>();
                Navigation Navigation = new Navigation();
                lstLoginRole.Add(loginrole);
                returncode = Navigation.GetLandingPage(lstLoginRole, out path);
                if (returncode == 0)
                {
                    Session.Add("RoleId", lstLoginRole[0].RoleID.ToString());
                    Session.Add("RoleName", lstLoginRole[0].RoleName.ToString());

                    Int64.TryParse(Session["LID"].ToString(), out loginID);
                    switch (lstLoginRole[0].RoleName)
                    {
                        case "Physician": // Physician

                            returncode = gateWay.GetPhysicianDetails(loginID, out physician);
                            Session.Add("Name", physician.PhysicianName + " [ " + physician.SpecialityName + " ]");
                            returncode = 0;
                            break;
                        case "Nurse":  // Nurse
                            returncode = gateWay.GetNurseDetails(loginID, out nurse);
                            Session.Add("UserName", nurse.NurseName);
                            break;
                        case "Lab Technician": // Lab Tech
                            returncode = gateWay.GetUserDetail(loginID, out lstUsers);
                            Session.Add("UserName", lstUsers[0].Name);
                            returncode = 0;
                            break;
                        case "Patient": // Patient
                            returncode = 0;
                            break;
                        case "Receptionist": // Reception
                            returncode = gateWay.GetUserDetail(loginID, out lstUsers);
                            Session.Add("UserName", lstUsers[0].Name);
                            returncode = 0;
                            break;
                        case "Administrator":  // Admin
                            returncode = gateWay.GetUserDetail(loginID, out lstUsers);
                            Session.Add("UserName", lstUsers[0].Name);
                            returncode = 0;
                            break;

                        case "SrLabTech": // Senior Lab
                            returncode = gateWay.GetUserDetail(loginID, out lstUsers);
                            Session.Add("UserName", lstUsers[0].Name);
                            returncode = 0;
                            break;

                        case "Dialysis Technician": // Dialysis Technician
                            returncode = gateWay.GetUserDetail(loginID, out lstUsers);
                            Session.Add("UserName", lstUsers[0].Name);
                            returncode = 0;
                            break;
                    };
                    long returnCode = -1;
                    long DeptID = -1;
                    returnCode = gateWay.UpdateLoggedInUser(Session.SessionID, LID, lstLoginRole[0].RoleID, DeptID,OrgID );
                    Response.Redirect(Request.ApplicationPath + path, true);
                }
            }
        }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error at UserRoleChange Control itemcommand", ex);
        }
    }
    public string CSSStyle
    {
        set
        {
            styleClass = value;
        }
        get
        {
            return styleClass;
        }
    }
    public string CSSMidStyle
    {
        set
        {
            styleMidClass = value;
        }
        get
        {
            return styleMidClass;
        }
    }
}
