using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;
using System.Globalization;
using System.Web.Configuration;

public partial class CommonControls_Attune_OrgHeader : BaseControl
{
    public CommonControls_Attune_OrgHeader()
        : base("CommonControls_Attune_OrgHeader_ascx")
    {
    }
    long returnCode = -1;
    string showPatientSearch = string.Empty;
    public bool  IsShowMenu { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        ShowAlertForTestURL();
        if (OrgDisplayName != null)
        {
            lblOrgName.Text = OrgDisplayName;
        }

        string Location = LocationName == null ? "" : LocationName;

        if (Location != "")
        {
            //lblLocationName.Text = "Location : " + Location;
            lblLocationName.Text = "" + Location;
            lblLocation.Text = "" + Location;
        }
        //lblUserName.Text = "UserName : " + UserName;
        //lblRoleName.Text = "RoleName : " + RoleName;
        lblUserName.Text = "" + UserName;
        lblRoleName.Text = "" + RoleDescription;
       
        lblRoleDes.Text = "" + RoleDescription;
        //displaySessionTimeLeft
        if (!IsPostBack)
        {
            //LoadDepartment();
            //LoadPatientHeader();
           // LoadLocationUserMap();
            LoadMeatData();
            if (Request.Cookies["CultureInfo"] != null)
            {
                ddlLanguage.SelectedValue = Request.Cookies["CultureInfo"].Value;
                string LanguageCode = ddlLanguage.SelectedValue;
                Session.Add("LanguageCode", ddlLanguage.SelectedValue);
            }


            LoadLocationsAndRoles();
            if (Request.QueryString["ILF"] == null)
            {
                if (IsFirstLogin == "N")
                {
                    Response.Redirect(Request.ApplicationPath + "/ChangePassword/ChangePassword.aspx?ILF=Y");
                }
            }
            try
            {
                List<Banners> lstBanners = new List<Banners>();
                returnCode = new Banners_BL(base.ContextInfo).GetBannersText(RoleID, LID, OrgID, out lstBanners);
                if (lstBanners.Count > 0)
                {
                    string bannerText = string.Empty;

                    divBanner.Style.Add("display", "block");
                    foreach (Banners b in lstBanners)
                    {
                        bannerText += "***" + b.BannerText + "*** ";
                    }

                    lblBannerText.Text = bannerText;
                }
                else
                {
                    divBanner.Style.Add("display", "none");
                }


            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in OrgHeader Page Load", ex);
            }

            showPatientSearch = GetConfigValue("ShowPatientSearch", OrgID);
            if (showPatientSearch == "Y")
                aPatientSearch.Visible = true;
            else
               aPatientSearch.Visible = false;
            if (IsShowMenu)
            {
                //showmenu.Src = "../Images/show.png";
                menu.Style.Add("display", "none");
            }
            //showmenu.Attributes.Add("onclick", "return LeftShowmenu('" + showmenu.ClientID + "','" + menu .ClientID+ "');");
            /*if (RoleName == "Patient" || RoleName == "Client" || RoleName == "Remote Registration")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", "hideWidget();", true);
            }*/
        }
    }

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "LanguageHdr";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems2 = from child in lstmetadataOutputs
                                  where child.Domain == "LanguageHdr"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddlLanguage.DataSource = childItems2;
                    ddlLanguage.DataTextField = "DisplayText";
                    ddlLanguage.DataValueField = "Code";
                    ddlLanguage.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }
    protected void btnLogOut_Click(object sender, EventArgs e)
    {

        LogOut();
    }
    protected void RoleChange_Click(object sender, EventArgs e)
    {
       // Department2.LoadLocationsAndRoles();
    }

    public void LoadLocationsAndRoles()
    {
        GateWay gateway = new GateWay(base.ContextInfo);
        List<Role> userRoles = new List<Role>();
        Patient patient = new Patient();
        List<Users> lstUsers = new List<Users>();
        PhysicianSchedule physician = new PhysicianSchedule();
        Nurse nurse = new Nurse();
        long returnCode = -1;
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        loggedIn.LoginID = LID;
        returnCode = gateway.GetRoles(loggedIn, out userRoles);
        var UOrgs = (from child in userRoles
                     orderby child.OrgName
                     select new { child.OrgID, child.OrgName }).Distinct();
        ddlOrg.DataSource = UOrgs;
        ddlOrg.DataTextField = "OrgName";
        ddlOrg.DataValueField = "OrgID";
        ddlOrg.SelectedValue = OrgID.ToString();
        ddlOrg.DataBind();


        List<Role> lstRoles = new List<Role>();
        lstRoles = (from child in userRoles
                    where child.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value)
                    orderby child.Description
                    select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
        //select new { child.RoleID, child.RoleName }).Distinct();
        //ddlRole.DataSource = lstRoles;
        ////ddlRole.DataTextField = "RoleName";
        //ddlRole.DataTextField = "Description";
        //ddlRole.DataValueField = "RoleName";
        //ddlRole.DataBind();
        //ddlRole.SelectedValue = RoleID.ToString() + "~" + RoleName;

        int iOrgID = Int16.Parse(ddlOrg.SelectedItem.Value);
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();



        /********************************** MOOVENDAN **********************************/
        long LocID = 0;
        string LocName = string.Empty;
        returnCode = patientBL.GetLocation(iOrgID, LID, RoleID, out lstLocation);

        if (lstLocation.Count > 0)
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

        //if (lstLocation.Count > 0)
        //{
        //    ddlOrgHeaderLocation.DataSource = lstLocation;
        //    ddlOrgHeaderLocation.DataTextField = "Location";
        //    ddlOrgHeaderLocation.DataValueField = "AddressID";

        //    ddlOrgHeaderLocation.DataBind();
        //    ddlOrgHeaderLocation.SelectedValue = ILocationID.ToString();
        //}

        //--------------------TaskNotification----------------------------------------//
        //if (TaskNotification != "")
        //{
        //    if (TaskNotification == "N")
        //        chkTaskNotification.Checked = false;
        //    else
        //        chkTaskNotification.Checked = true;
        //}
        //else
        //    chkTaskNotification.Checked = false;
        // -------------------------End-----------------------------------------------//
    }

    protected void btnRoleOK_Click(object sender, EventArgs e)
    {
        try
        {
            SetLanguage();
            GateWay gateway = new GateWay(base.ContextInfo);
            long returncode = 0;
            long loginID = -1;
            string orgName = string.Empty;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Role loginrole = new Role();
            loginrole.OrgID = Convert.ToInt32(HdnOrgID.Value);
            loginrole.OrgName = HdnOrgName.Value;

            string[] strRole = null;
            if (!string.IsNullOrEmpty(hdnRole.Value.Trim()))
            {
                strRole = hdnRole.Value.Split('~');
            }

            string[] strLoaction = null;
            string strLocationID = "0";
            string strLocationName = "0";
            if (!string.IsNullOrEmpty(hdnLocation.Value.Trim()))
            {
                strLoaction = hdnLocation.Value.Split('~');
                strLocationID = strLoaction[0];
                strLocationName = strLoaction[1];
            }


            loginrole.RoleID = Convert.ToInt64(strRole[0]);
            loginrole.RoleName = strRole[1];
            loginrole.Description = strRole[2];
            List<Role> lstLoginRole = new List<Role>();
            string path = string.Empty;
            Navigation Navigation = new Navigation();
            lstLoginRole.Add(loginrole);
            returncode = Navigation.GetLandingPage(lstLoginRole, out path);
            if (returncode == 0)
            {
                if (Request.Cookies["LeftMenu"] != null)
                {
                    Response.Cookies["LeftMenu"].Expires = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-1);
                }
                //--------------------TaskNotification----------------------------------------//
                // string chkTaskNotificationtext = "";
                //if (chkTaskNotification.Checked == true)
                //    TaskNotification = "Y";
                //else
                //    TaskNotification = "N";
                //ContextInfo.AdditionalInfo = TaskNotification;
                //Session.Add("TaskNotification", TaskNotification);
                Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
                long ThemeId = 0;
                if (Session["ThemeID"].ToString() != "")
                    ThemeId = Convert.ToInt64(Session["ThemeID"].ToString());
                objTheme_BL.UpdateThemeByLID(LID, ThemeId);
                //----------------------End--------------------------------------------------//

                List<Config> lstConfig = new List<Config>();
                Session.Add("RoleID", lstLoginRole[0].RoleID.ToString());
                Session.Add("OrgID", lstLoginRole[0].OrgID.ToString());
                Session.Add("OrgName", lstLoginRole[0].OrgName);
                Session.Add("OrgDisplayName", lstLoginRole[0].OrgName);
                Session.Add("RoleName", lstLoginRole[0].RoleName.ToString());
                Session.Add("LocationID", strLocationID);
                Session.Add("LocationName", strLocationName);
                Session.Add("RoleDescription", loginrole.Description);
                Session.Add("DepartmentID", ddlDepartment.SelectedValue);
                LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                objLoggedInProfile.IPAddress = Request.UserHostAddress;
                objLoggedInProfile.LoginID = loginID;
                objLoggedInProfile.OrgAddressID = int.Parse(strLocationID);
                objLoggedInProfile.OrgID = lstLoginRole[0].OrgID;
                returncode = gateway.InsertLoggedInProfile(objLoggedInProfile);
                Session.Add("InventoryLocationID", "-1");
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                returncode = gateway.GetLocationUserMap(LID, lstLoginRole[0].OrgID, Int32.Parse(strLocationID), out lstLocationUserMap);
                if (lstLocationUserMap.Count > 0)
                {
                    if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                    {
                        Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                        Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                    }
                }
                else
                {
                    if (RoleHelper.Inventory != RoleName)
                    {
                        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                        returncode = gateway.GetInventoryConfigDetails("InventoryLocation", lstLoginRole[0].OrgID, Int32.Parse(strLocationID), out lstInventoryConfig);
                        if (lstInventoryConfig.Count > 0)
                        {
                            Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                        }
                    }
                }

                if (!string.IsNullOrEmpty(ddlOrgHeaderInvLocation.SelectedValue) && Convert.ToInt16(ddlOrgHeaderInvLocation.SelectedValue) > 0)
                {
                    Session.Add("InventoryLocationID", ddlOrgHeaderInvLocation.SelectedValue);
                }

                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                returncode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(int.Parse(strLocationID), lstLoginRole[0].RoleID, "", out lstTOD);
                if (lstTOD.Count > 0)
                {
                    Session.Add("IsTrustedOrg", "Y");
                }
                else
                {
                    Session.Add("IsTrustedOrg", "N");
                }

                returncode = gateway.GetConfigDetails("UseOrgBasedDrugData", lstLoginRole[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    if (lstConfig[0].ConfigValue == "Y")
                        Session.Add("DrugOrgID", lstLoginRole[0].OrgID);
                    else
                        Session.Add("DrugOrgID", 0);
                }
                else
                {
                    Session.Add("DrugOrgID", 0);
                }
                returncode = gateway.GetConfigDetails("IsAmountEditable", lstLoginRole[0].OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
                else
                    Session.Add("IsAmountEditable", "Y");

                Response.Redirect(Request.ApplicationPath + path, true);
                Helper.PageRedirect(Page, Request.ApplicationPath + path);
            }

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


    protected void SetLanguage()
    {
        //Sets the cookie that is to be used by Global.asax
        HttpCookie cookie = new HttpCookie("CultureInfo");
        cookie.Value = ddlLanguage.SelectedValue;
        Response.Cookies.Add(cookie);
        //Set the culture and reload the page for immediate effect. 
        //Future effects are handled by Global.asax
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(ddlLanguage.SelectedValue);
        Thread.CurrentThread.CurrentCulture = new CultureInfo(ddlLanguage.SelectedValue);
        base.ContextInfo.LanguageCode = ddlLanguage.SelectedValue;
        Session["LanguageCode"] = ddlLanguage.SelectedValue;
    }


    void LoadDepartment()
    {
        string sele = Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_05;
        long returnCode = -1;
        List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
        Master_BL obj = new Master_BL(base.ContextInfo);
        returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
        if (lstEmpDeptMaster.Count > 0)
        {
            ddlDepartment.DataSource = lstEmpDeptMaster;
            ddlDepartment.DataValueField = "Code";
            ddlDepartment.DataTextField = "EmpDeptName";
            ddlDepartment.DataBind();
           // ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items.Insert(0, sele);

            ddlDepartment.Items[0].Value = "0";
        }
        else
        {
           // ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items.Insert(0, sele);

            ddlDepartment.Items[0].Value = "0";
        }

        //if (!string.IsNullOrEmpty(DepartmentID))
        //{
        //    ddlDepartment.SelectedValue = DepartmentID;
        //}
    }
    protected void ShowAlertForTestURL()
    {
        bool _flag = false;

        try
        {
            if (Session["UserAlert"].Equals(null))
            {

            }
        }
        catch (Exception ec)
        {
            _flag = true;
        }


        string userName = string.Empty;
        if (WebConfigurationManager.AppSettings["IsLiveURL"] != null)
        {
            userName = Convert.ToString(WebConfigurationManager.AppSettings["IsLiveURL"]);
            string Cdisplay = Resources.CommonControls_ClientDisplay.CommonControls_Attune_OrgHeader_aspx_001;
            lblUserName.Text = Cdisplay + userName;
        }

        if (!string.IsNullOrEmpty(userName) && userName.ToUpper().Contains("YES") && _flag)
        {
            string Cdisplay1 = Resources.CommonControls_ClientDisplay.CommonControls_Attune_OrgHeader_aspx_002;
            string Cdisplay2 = Resources.CommonControls_ClientDisplay.CommonControls_Attune_OrgHeader_aspx_003;
            hdnTestURLFlag.Value = Cdisplay1;
            Session["UserAlert"] = Cdisplay2;
        }
        else
        {
            hdnTestURLFlag.Value = string.Empty;
        }
    }
    private string GetConfigValue(string configKey, int orgID)
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
    
    public void LoadErrorMsg(string ErrorMsg)
    {
        Control oControl = (Control)this.FindControl("TopHeader1");
        if (oControl != null)
        {
            //CommonControls_NewUI_ErrorDisplay oED ;
            //oED = (CommonControls_NewUI_ErrorDisplay)oControl.FindControl("ErrorDisplay1");
            //if (oED != null)
            //{
            //    oED.ShowError = true;
            //    oED.Status = ErrorMsg;
            //}
        }
    }



    public void LoadPatientHeader()
    {
        long patientVisitID = 0;
        long patientID = 0;
        if ((Request.QueryString["vid"] != null) || (Request.QueryString["pid"] != null))
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            CommonControls_PatientHeader oPH = new CommonControls_PatientHeader();
           // ucPatientHeader.LoadPatientDetails(patientID, patientVisitID);
            ucPatientHeader.Visible = true;
        }
        else if ((Request.QueryString["PatientVisitID"] != null) || (Request.QueryString["PatientID"] != null))
        {
            Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out patientVisitID);
            Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
           // ucPatientHeader.LoadPatientDetails(patientID, patientVisitID);
            ucPatientHeader.Visible = true;
        }
        else
        {
            ucPatientHeader.Visible = false;
        }
    }

    public void LoadInvLocation()
    {
        //Department2.LoadLocationUserMap();
    }

    public void LoadLocationUserMap()
    {
        long iOrgID = Int64.Parse(OrgID.ToString());
        long returnCode = -1;
        List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
        returnCode = new GateWay(base.ContextInfo).GetLocationUserMap(LID, OrgID, ILocationID, out lstLocationUserMap);
        if (lstLocationUserMap != null && lstLocationUserMap.Count > 0)
        {
            ddlOrgHeaderInvLocation.DataSource = lstLocationUserMap;
            ddlOrgHeaderInvLocation.DataTextField = "LocationName";
            ddlOrgHeaderInvLocation.DataValueField = "LocationID";
            ddlOrgHeaderInvLocation.DataBind();
        }
        ddlOrgHeaderInvLocation.Items.Insert(0, "--Select Department--");
        ddlOrgHeaderInvLocation.Items[0].Value = "-1";
        ddlOrgHeaderInvLocation.SelectedValue = InventoryLocationID.ToString();
    }
}

