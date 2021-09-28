using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.TrustedOrg;
using System.Collections;
using System.Globalization;
using Attune.Kernel.PlatForm.BL;


using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;

public partial class PlatFormControls_Department : Attune_BaseControl
{
    public PlatFormControls_Department()
        : base("PlatFormControls_Department_ascx")
    {
    }
    private int _OrgID = 0;
    private long _RoleID = 0;
    public String strBrowser = string.Empty;
    public string strBrowserVersion = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
        if (OrgID == 0)
        {
            OrgID = OrgID;
        }
        if (URoleID == 0)
        {
            URoleID = RoleID;
        }
        //Getting Browsing Browser to stored in Logged in profile.

        System.Web.HttpBrowserCapabilities browserDetection = Request.Browser;
        if (browserDetection.Id == "safari1plus")
        {
            strBrowser = "Chrome";
        }
        else
        {
            strBrowser = browserDetection.Browser;
        }
        strBrowserVersion = browserDetection.Version;
    }

    public void LoadLocationUserMap()
    {
        //long iOrgID = Int64.Parse(OrgID.ToString());
        int iOrgID = 0;
        if ((Session["OrgID"]) != null)
        {
             iOrgID =Convert.ToInt32(Session["OrgID"]);
        }
        long returnCode = -1;
        List<LocationUserMap> lstLocationUserMap = null;
        returnCode = new GateWay(base.ContextInfo).GetLocationUserMap(LID, iOrgID, ILocationID, out lstLocationUserMap);
        if (lstLocationUserMap!=null && lstLocationUserMap.Count > 0)
        {
            ddlLocation.DataSource = lstLocationUserMap;
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataValueField = "LocationID";
            ddlLocation.DataBind();
            
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlLocation.Items.Insert(0, ddlselect);
            //ddlLocation.Items.Insert(0, GetMetaData("Select", "0"));
            ddlLocation.Items[0].Value = "-1";
            ddlLocation.SelectedValue = InventoryLocationID.ToString();
            mpeAttributeLocation.Show();
        }
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        Attune_Navigation navigation = new Attune_Navigation();
        Role role = new Role();
        try
        {

            try
            {
                Session.Add("InventoryLocationID", ddlLocation.SelectedValue);
                Session.Add("DepartmentName", ddlLocation.SelectedItem.Text);

                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                long returnCode = -1;
                if ((Session["OrgID"]) != null)
                {
                    OrgID = Convert.ToInt32(Session["OrgID"]);
                }
                returnCode = new GateWay(base.ContextInfo).SetDefaultInventoryLocation(LID, int.Parse(ddlLocation.SelectedValue), OrgID, ILocationID);

                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);


                if (returnCode == 0)
                {
                    if (Request.Cookies["LeftMenu"] != null)
                    {
                        Response.Cookies["LeftMenu"].Expires = DateTime.Now.AddDays(-1);
                    }
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                }
            }
            catch (System.Threading.ThreadAbortException tex)
            {
                string te = tex.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
            }

        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    public void LoadLocationsAndRoles()
    {
        GateWay gateway = new GateWay(base.ContextInfo);
        List<Role> userRoles = null;
        Patient patient = new Patient();
        List<Users> lstUsers = new List<Users>();
        PhysicianSchedule physician = new PhysicianSchedule();
        Nurse nurse = new Nurse();
        long returnCode = -1;
        Attune.Kernel.BusinessEntities.Login login = new Attune.Kernel.BusinessEntities.Login();
        Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
        loggedIn.LoginID = LID;
        returnCode = gateway.GetRoles(loggedIn, out userRoles);
        if (userRoles != null && userRoles.Count > 0)
        {
        var UOrgs = (from child in userRoles
                     orderby child.OrgName
                     select new { child.OrgID, child.OrgDisplayName }).Distinct();
        ddlOrg.DataSource = UOrgs;
        ddlOrg.DataTextField = "OrgDisplayName";
        ddlOrg.DataValueField = "OrgID";
        ddlOrg.SelectedValue = OrgID.ToString();
        ddlOrg.DataBind();
        }
        List<Role> lstRoles = new List<Role>();
        lstRoles = (from child in userRoles
                    where child.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value)
                    orderby child.Description
                    select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
        //select new { child.RoleID, child.RoleName }).Distinct();
        ddlRole.DataSource = lstRoles;
        //ddlRole.DataTextField = "RoleName";
        ddlRole.DataTextField = "Description";
        ddlRole.DataValueField = "RoleName";
        ddlRole.DataBind();
        ddlRole.SelectedValue = RoleID.ToString() + "~" + RoleName;

        int iOrgID = Int32.Parse(ddlOrg.SelectedItem.Value);
        Master_BL patientBL = new Master_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();



        /********************************** MOOVENDAN **********************************/
        long LocID = 0;
        string LocName = string.Empty;
        returnCode = new Organization_BL(base.ContextInfo).GetLocation(iOrgID, LID, RoleID, out lstLocation);

        if (lstLocation!=null && lstLocation.Count > 0)
        {
            LocID = lstLocation[0].AddressID;
            LocName = lstLocation[0].Location;
            foreach (OrganizationAddress lstLoc in lstLocation)
            {
                if (lstLoc.AddressID == ILocationID)
                {
                    LocID = lstLoc.AddressID;
                    LocName = lstLoc.Location;
                }
            }
        }
        Session.Add("LocationID", LocID);
        Session.Add("LocationName", LocName);
        /********************************** MOOVENDAN **********************************/

        if (lstLocation.Count > 0)
        {
            ddlLocation1.DataSource = lstLocation;
            ddlLocation1.DataTextField = "Location";
            ddlLocation1.DataValueField = "AddressID";

            ddlLocation1.DataBind();
            ddlLocation1.SelectedValue = ILocationID.ToString();
        }
        mpeLocationAndRole.Show();
    }
    public int OrgID
    {
        set { _OrgID = value; }
        get { return _OrgID; }
    }
    //venkat
    public long URoleID
    {
        set { _RoleID = value; }
        get { return _RoleID; }
    }
    protected void ddlOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        long returnCode = -1;
        GateWay gateway = new GateWay(base.ContextInfo);
        List<Role> userRoles = new List<Role>();
        Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
        loggedIn.LoginID = LID;
        returnCode = gateway.GetRoles(loggedIn, out userRoles);
        List<Role> lstRoles = new List<Role>();
        if (userRoles != null && userRoles.Count > 0)
        {
        lstRoles = (from child in userRoles
                    where child.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value)
                    orderby child.Description
                    select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
        //select new { child.RoleID, child.RoleName }).Distinct();
        ddlRole.DataSource = lstRoles;
        //ddlRole.DataTextField = "RoleName";
        ddlRole.DataTextField = "Description";
        ddlRole.DataValueField = "RoleName";
        ddlRole.DataBind();
        }
        //ddlRole.SelectedValue = RoleID.ToString()+"~"+RoleName;
        int iOrgID = Int32.Parse(ddlOrg.SelectedItem.Value);
        
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = new Organization_BL(base.ContextInfo).GetLocation(iOrgID, LID, RoleID, out lstLocation);
        if (lstLocation!=null && lstLocation.Count > 0)
        {
            ddlLocation1.DataSource = lstLocation;
            ddlLocation1.DataTextField = "Location";
            ddlLocation1.DataValueField = "AddressID";
            ddlLocation1.DataBind();
        }


        mpeLocationAndRole.Show();
    }

    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        long returnCode = -1;
        GateWay gateway = new GateWay();
        List<Role> userRoles =null;
        Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
        loggedIn.LoginID = LID;
        returnCode = gateway.GetRoles(loggedIn, out userRoles);
        if (userRoles != null && userRoles.Count > 0)
        {
        var URoles = (from child in userRoles
                      where child.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value)
                      orderby child.Description
                      select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
        //select new { child.RoleID, child.RoleName }).Distinct();
        ddlRole.DataSource = URoles;
        //ddlRole.DataTextField = "RoleName";
        ddlRole.DataTextField = "Description";
        ddlRole.DataValueField = "RoleName";
        ddlRole.DataBind();
        ddlRole.SelectedValue = RoleID.ToString() + "~" + RoleName;
        }
        int iOrgID = Int32.Parse(ddlOrg.SelectedItem.Value);
        List<OrganizationAddress> lstLocation =null;
        returnCode = new Organization_BL(base.ContextInfo).GetLocation(iOrgID, LID, RoleID, out lstLocation);
        if (lstLocation!=null && lstLocation.Count > 0)
        {
            ddlLocation1.DataSource = lstLocation;
            ddlLocation1.DataTextField = "Location";
            ddlLocation1.DataValueField = "AddressID";
            ddlLocation1.DataBind();
        }
        mpeLocationAndRole.Show();
    }

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        long returnCode = -1;
        GateWay gateway = new GateWay(base.ContextInfo);
        List<Role> userRoles = new List<Role>();
        Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
        loggedIn.LoginID = LID;

        int iOrgID = Int32.Parse(ddlOrg.SelectedItem.Value);
        long RoleID = Int64.Parse(ddlRole.SelectedItem.Value.Split('~')[0]);
        List<OrganizationAddress> lstLocation =null;
        returnCode = new Organization_BL(base.ContextInfo).GetLocation(iOrgID, LID, RoleID, out lstLocation);
        if (lstLocation!=null && lstLocation.Count > 0)
        {
            ddlLocation1.DataSource = lstLocation;
            ddlLocation1.DataTextField = "Location";
            ddlLocation1.DataValueField = "AddressID";
            ddlLocation1.DataBind();
        }
        mpeLocationAndRole.Show();
    }

    protected void btnRoleOK_Click(object sender, EventArgs e)
    {
        try
        {

            long returnCode = 0;
            long loginID = -1;
            GateWay gateWay = new GateWay(base.ContextInfo);
            string path = string.Empty;
            Attune_Navigation Attune_Navigation = new Attune_Navigation();
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            List<Role> userRoles = new List<Role>();
            Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
            loggedIn.LoginID = loginID;
            LID = loginID;

            returnCode = gateWay.GetRoles(loggedIn, out userRoles);
            if (returnCode == 0 && userRoles!=null && userRoles.Count > 0)
            {

                List<Config> lstConfig = new List<Config>();

                userRoles = userRoles.FindAll(p => p.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value) && p.RoleID == Convert.ToInt64(ddlRole.SelectedItem.Value.Split('~')[0]));
                Session.Add("OrgID", userRoles[0].OrgID.ToString());
                Session.Add("LocationID", ddlLocation1.SelectedItem.Value.ToString());
                Session.Add("LocationName", ddlLocation1.SelectedItem.Text);
                Session.Add("OrgName", userRoles[0].OrgName);
                if (userRoles[0].OrgDisplayName != null)
                {
                    Session.Add("OrgDisplayName", userRoles[0].OrgDisplayName.ToString());
                }
                else
                {
                    Session.Add("OrgDisplayName", "");
                }
                Session.Add("LID", loggedIn.LoginID.ToString());
                Session.Add("RoleName", userRoles[0].RoleName.ToString());
                Session.Add("RoleDescription", userRoles[0].Description.ToString());
                Session.Add("IntegrationName", Convert.ToString(userRoles[0].IntegrationName));
                //--------------------TaskNotification----------------------------------------//
                string chkTaskNotificationtext = "";
                if (chkTaskNotification.Checked == true)
                    chkTaskNotificationtext = "Y";
                else
                    chkTaskNotificationtext = "N";
                ContextInfo.AdditionalInfo = chkTaskNotificationtext;

                Session.Add("TaskNotification", chkTaskNotificationtext);
                Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
                long ThemeId = 0;
                if (Session["ThemeID"].ToString() != "")
                    ThemeId = Convert.ToInt64(Session["ThemeID"].ToString());
                objTheme_BL.UpdateThemeByLID(LID, ThemeId);
                //----------------------End--------------------------------------------------//

                Configuration_BL configBL = new Configuration_BL(base.ContextInfo);
                returnCode = configBL.GetConfigDetails("UseOrgBasedDrugData", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                        Session.Add("DrugOrgID", userRoles[0].OrgID);
                    else
                        Session.Add("DrugOrgID", 0);
                }
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                        Session.Add("DrugOrgID", userRoles[0].OrgID);
                    else
                        Session.Add("DrugOrgID", 0);
                }

                returnCode = configBL.GetConfigDetails("UploadPath", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("UploadPath", lstConfig[0].ConfigValue);
                else
                    Session.Add("UploadPath", "");

                returnCode = configBL.GetConfigDetails("IsCorporateOrg", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsCorporateOrg", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsCorporateOrg", "N");

                returnCode = configBL.GetConfigDetails("HideIPManageRate", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("HideIPManageRate", lstConfig[0].ConfigValue);
                else
                    Session.Add("HideIPManageRate", "N");

                returnCode = configBL.GetConfigDetails("NoBilling", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsCorporateOrgPaymenttype", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsCorporateOrgPaymenttype", "N");

                returnCode = configBL.GetConfigDetails("Employee", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("Employee", lstConfig[0].ConfigValue);
                else
                    Session.Add("Employee", "N");

                returnCode = configBL.GetConfigDetails("Currency", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("OrgCurrency", lstConfig[0].ConfigValue);
                else
                    Session.Add("OrgCurrency", "");

                returnCode = configBL.GetConfigDetails("IsAmountEditable", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsAmountEditable", "Y");

                returnCode = configBL.GetConfigDetails("CurrencyFormat", userRoles[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("OrgCurrencyFormat", lstConfig[0].ConfigValue);
                else
                    Session.Add("OrgCurrencyFormat", "");

                List<CurrencyDetails> lstCurrencyDetails = new List<CurrencyDetails>();
                returnCode = gateWay.GetCurrencyDetails(userRoles[0].OrgID, out lstCurrencyDetails);
                if (lstCurrencyDetails != null && lstCurrencyDetails.Count > 0)
                {
                Session.Add("MinorCurrency", lstCurrencyDetails.Count > 0 ? lstCurrencyDetails.Find(p => p.IsBaseCurrency == "Y").MinorCurrencyDisplayText : "");
                Session.Add("LogoPath", userRoles[0].LogoPath);
                }
                CLogger.LogInfo("OrgName : " + userRoles[0].OrgName);
                CLogger.LogInfo("IP Addr : " + Request.UserHostAddress);
                CLogger.LogInfo("Date : " + DateTime.Now);
                CLogger.LogInfo("Role : " + userRoles[0].RoleName + " & UserName : " + UserName);

                GateWay headBL = new GateWay(base.ContextInfo);
                //Prasanna lines End
                if (userRoles.Count >= 1)
                {
                    returnCode = -1;
                    Session.Add("RoleID", userRoles[0].RoleID.ToString());
                    PhysicianSchedule physician = new PhysicianSchedule();
                    Nurse nurse = new Nurse();
                    switch (userRoles[0].RoleName)
                    {
                        case "Physician": // Physician
                            returnCode = headBL.GetPhysicianDetails(loggedIn.LoginID, out physician);
                            Session.Add("Name", physician.PhysicianName + " [ " + physician.SpecialityName + " ]");
                            Session.Add("UserName", physician.PhysicianName);
                            returnCode = 0;
                            Session.Add("UserID", physician.PhysicianID);
                            break;
                        case "Nurse": // Nurse
                            returnCode = headBL.GetNurseDetails(loggedIn.LoginID, out nurse);
                            Session.Add("UserName", nurse.NurseName);
                            Session.Add("UserID", nurse.NurseID);
                            break;

                        default:
                            List<Users> lstUsers = new List<Users>();
                            returnCode = headBL.GetUserDetail(loggedIn.LoginID, out lstUsers);
							if(lstUsers!=null && lstUsers.Count>0)
							{
								Session.Add("UserName", lstUsers[0].Name);
								Session.Add("UserID", lstUsers[0].UserID);
								Session.Add("LoginName", lstUsers[0].LoginName);
							}
                            returnCode = 0;
                            break;

                    };

                    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                    returnCode = new Organization_BL(base.ContextInfo).GetLocation(userRoles[0].OrgID, loggedIn.LoginID, userRoles[0].RoleID, out lstLocation);
                    if (lstLocation!=null && lstLocation.Count > 0)
                    {

                        Session.Add("CountryID", lstLocation.Find(p => p.AddressID == int.Parse(ddlLocation1.SelectedItem.Value)).CountryID);
                        Session.Add("StateID", lstLocation.Find(p => p.AddressID == int.Parse(ddlLocation1.SelectedItem.Value)).StateID);

                        LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                        objLoggedInProfile.IPAddress = Request.UserHostAddress;
                        objLoggedInProfile.LoginID = loggedIn.LoginID;
                        objLoggedInProfile.OrgAddressID = (int)lstLocation[0].AddressID;
                        objLoggedInProfile.OrgID = userRoles[0].OrgID;
                        objLoggedInProfile.BrowserName = strBrowser;
                        objLoggedInProfile.Browserversion = strBrowserVersion;
                        returnCode = gateWay.InsertLoggedInProfile(objLoggedInProfile);

                        ContextInfo.AdditionalInfo = "ChangeRole";
                        returnCode = gateWay.UpdateLoggedInUser(Session.SessionID, Convert.ToInt64(Session["LID"]), Convert.ToInt64(Session["RoleID"]), -1,Convert.ToInt64(Session["LocationID"]),OrgID);

                    }

                    List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                    returnCode = new TrustedOrg().GetTrustedOrgList((int)lstLocation[0].AddressID, userRoles[0].RoleID, "", out lstTOD);
                    if (lstTOD!=null && lstTOD.Count > 0)
                    {
                        Session.Add("IsTrustedOrg", "Y");
                    }
                    else
                    {
                        Session.Add("IsTrustedOrg", "N");
                    }
                    Session.Add("InventoryLocationID", "-1");

                    List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                    returnCode = gateWay.GetLocationUserMap(loggedIn.LoginID, userRoles[0].OrgID, (int)lstLocation[0].AddressID, out lstLocationUserMap);
                    if (lstLocationUserMap!=null && lstLocationUserMap.Count > 0)
                    {
                        if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                        {
                            Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                            Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                        }
                    }
                    else
                    {
                        if (RoleHelper.Inventory != userRoles[0].RoleName)
                        {
                            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                            returnCode = configBL.GetInventoryConfigDetails("InventoryLocation", userRoles[0].OrgID, Convert.ToInt32(userRoles[0].OrgAddressID), out lstInventoryConfig);
                            if (lstInventoryConfig.Count > 0)
                            {
                                Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                            }
                        }
                    }
                }
            }



            Role loginrole = new Role();
            loginrole.OrgID = Convert.ToInt32(ddlOrg.SelectedItem.Value);
            loginrole.OrgName = ddlOrg.SelectedItem.Text;
            loginrole.RoleID = Convert.ToInt64(ddlRole.SelectedItem.Value.Split('~')[0]);
            loginrole.RoleName = ddlRole.SelectedItem.Value.Split('~')[1];
            loginrole.OrgDisplayName = ddlOrg.SelectedItem.Text;

            List<Role> lstLoginRole = new List<Role>();

            lstLoginRole.Add(loginrole);

            returnCode = Attune_Navigation.GetLandingPage(lstLoginRole, out path);
            if (Request.Cookies["LeftMenu"] != null)
            {
                Response.Cookies["LeftMenu"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect(Request.ApplicationPath + path, true);
            Attune_Helper.PageRedirect(Page, Request.ApplicationPath + path);




        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while moving between available roles", ex);
        }
    }
}
