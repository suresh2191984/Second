using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Solution.DAL;


public partial class CommonControls_UserRoleControl : BaseControl
{
    long returncode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {


    }

    public void loadUserRole(long loginid)
    {
        GateWay gateway = new GateWay(base.ContextInfo);
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        login.LoginID = loginid;
        List<Role> lstuserroles = new List<Role>();
        returncode = gateway.GetRoles(login, out lstuserroles);
        List<Role> lstRoles = new List<Role>();
        lstRoles = (from child in lstuserroles
                    where child.OrgID == OrgID
                    orderby child.Description
                    select new Role { RoleName = child.RoleID + "~" + child.RoleName , Description = child.Description }).Distinct().ToList();

        if (lstuserroles.Count > 0)
        {
            ddlRoles.DataSource = lstuserroles;
            ddlRoles.DataTextField = "Description";
            ddlRoles.DataValueField = "RoleName";
            ddlRoles.DataBind();
            ddlRoles.Items.Insert(0, new ListItem("Select", "0"));
            ddlRoles.SelectedValue = "0";// Convert.ToString(lstuserroles[0].RoleID);
            returncode = -1;
        
        }
    }


    protected void ddlRoles_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (ddlRoles.SelectedIndex > 0)
            {
                string Pagepath = string.Empty;
                Role loginRole = new Role();
                List<Role> lstUserRoles = new List<Role>();
                PhysicianSchedule Physician = new PhysicianSchedule();
                GateWay gateway = new GateWay(base.ContextInfo);
                Patient Patient = new Patient();
                Navigation Navigation = new Navigation();
                loginRole.RoleID = Convert.ToInt64(ddlRoles.SelectedValue.Split('~')[0]);
                Nurse Nurse = new Nurse();
                int phyID = 0;
                long UserID = 0;

                Session.Add("RoleID", ddlRoles.SelectedValue.Split('~')[0]);
                Session.Add("RoleDescription", ddlRoles.SelectedItem.Text);
                Session.Add("RoleName", ddlRoles.SelectedValue.Split('~')[1]);
                   
                // Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();

                // Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
                // loggedIn.LoginID = 7;
                //returncode = gateway.GetRoles(loggedIn, out lstUserRoles);
                // if (returncode == 0)
                // {
                //if (lstUserRoles.Count > 0)
                //{
                // Session["LID"] = 5;

                if (Session["LID"] != null)
                {

                    switch (Convert.ToInt32(ddlRoles.SelectedValue.Split('~')[0]))
                    {
                        case 4:
                            UserID = Convert.ToInt64(Session["LID"]);
                            returncode = gateway.GetPatientDetails(UserID, out Patient);
                            if (returncode == 0)
                            {
                                Session.Add("Name", Patient.TitleName + " " + Patient.Name);
                                Session.Add("Age", Patient.Age.ToString());
                            }
                            break;
                        case 5:
                            returncode = 0;
                            break;
                        case 1:
                            Session.Add("Name", "Dr." + " " + Physician.PhysicianName + " [" + Physician.SpecialityName + "]");
                            phyID = Convert.ToInt32(Session["LID"]);
                            returncode = gateway.GetPhysicianDetails(phyID, out Physician);
                            returncode = 0;
                            break;
                        case 2:
                            returncode = gateway.GetNurseDetails(Convert.ToInt32(Session["LID"]), out Nurse);
                            break;

                        case 3:
                            returncode = 0;
                            break;
                        case 6:
                            returncode = 0;
                            break;
                    };

                    lstUserRoles.Add(loginRole);
                    returncode = Navigation.GetLandingPage(lstUserRoles, out Pagepath);

                    if (returncode == 0)
                    {
                        Session.Add("RoleId", lstUserRoles[0].RoleID.ToString());
                        Response.Redirect(Request.ApplicationPath + Pagepath);
                    }
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
}
    //}
//}
