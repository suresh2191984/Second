using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.TrustedOrg;
using System.Threading;
using System.Globalization;
using System.Web.Configuration;
using Attune.Kernel.PlatForm.BL;

using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;
using System.Xml.Linq;
using System.Collections;
using System.Web.Hosting;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
public partial class PlatFormControls_Attune_OrgHeader : Attune_BaseControl
{
    public PlatFormControls_Attune_OrgHeader()
        : base("PlatFormControls_Attune_OrgHeader_ascx")
    {
    }
    long returnCode = -1;
    string showPatientSearch = string.Empty;
    public bool IsShowMenu { get; set; }
    public string Cntx = string.Empty;
    public string ApiUrl = string.Empty;
    public string AppointmentRedirect = string.Empty;  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["IsPopup"] != null)
        {
            IsShowMenu = true;
        }
        long pid = 0;
        long visitID = 0;
        if (!String.IsNullOrEmpty(Request.QueryString["pid"]))
        {
            long.TryParse(Request.QueryString["pid"], out pid);
        }
        if (!string.IsNullOrEmpty(Request.QueryString["vid"]))
        {
            long.TryParse(Request.QueryString["vid"], out visitID);
        }
        if (Request.Url.AbsolutePath.Contains("patientdiagnose.aspx"))
        {
            Int64.TryParse(Convert.ToString(Session["PatientID"]), out pid);
            Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
        }

        if (pid != 0 || visitID != 0)
        {
             
            Control objControl = LoadControl("../PlatForm/CommonControls/PatientHeader.ascx");
            if(objControl!=null)
            {
                objControl.ID = "ucPatientHeader";
                patientBanner.Controls.Add(objControl);
            }
            if (NeedPatientHeader == "Y")
            {
                imgshowDemographic.Attributes.Add("Class", "show");
            }
             
             
        }
        //displaySessionTimeLeft
        if (!IsPostBack)
        {
            #region Language

            XDocument xDocument = XDocument.Load(Server.MapPath("~\\App_Data\\ApplicationSettings.xml"));
            var query = from xEle in xDocument.Descendants("LanguageCode")
                        select new ListItem(xEle.Element("Name").Value, xEle.Element("Code").Value);

            ddlLanguage.DataSource = query;
            ddlLanguage.DataTextField = "text";
            ddlLanguage.DataValueField = "value";
            ddlLanguage.DataBind();

            #endregion

            /*Arun Code*/
            ApiUrl = GetConfigValue("PlatFormApi", OrgID);

            JavaScriptSerializer js = new JavaScriptSerializer();
            object obj = base.ContextInfo;
            Cntx = js.Serialize(obj);
            /*Arun Code*/
            if (!string.IsNullOrEmpty(UserProfileImg))
            {
                imguserprofile.Src = "~/UserImage/"+UserProfileImg;
                imguserprofile1.Src = "~/UserImage/" + UserProfileImg;

            }
            //string ConfigForAppointmentIcon = string.Empty;
            //ConfigForAppointmentIcon = GetConfigValue("IsNeedForAppointmentBookingInReceptionist", OrgID);
            if (RoleName == "Receptionist")
            {
                ImgAppointment.Attributes.Add("class", "pointer inline-block");
            }            

            string AppointmentSchedulingIcon = string.Empty;
            AppointmentSchedulingIcon = GetConfigValue("AppointmentSchedulingInReceptionist", OrgID);
            if (!string.IsNullOrEmpty(AppointmentSchedulingIcon))
            {
                if (AppointmentSchedulingIcon.ToLower() == "y")
                {
                    AppointmentRedirect = "../Appointment/AppointmentSchedule.aspx";
                }
                else
                {
                    AppointmentRedirect ="../Appointment/Appointments.aspx";
                }
            }
            else
            {
                AppointmentRedirect = "../Appointment/Appointments.aspx";
            }

            //LoadDepartment();
            List<Config> lstConfig = null;
            returnCode = new Configuration_BL(base.ContextInfo).GetConfigDetails("Need_Department", OrgID, out lstConfig);

            if (lstConfig !=null && lstConfig.Count > 0)
            {
                if (!string.IsNullOrEmpty(lstConfig[0].ConfigValue) && lstConfig[0].ConfigValue == "Y")
                {
                    trDepartment.Attributes.Add("class", "displaytr");
                    trLanguage.Attributes.Add("class", "displaytr");
                }
                else
                {
                    if (Request.Cookies["CultureInfo"] != null)
                    {
                        ddlLanguage.SelectedValue = Request.Cookies["CultureInfo"].Value;
                        LanguageCode = ddlLanguage.SelectedValue;
                        Session.Add("LanguageCode", ddlLanguage.SelectedValue);
                    }
                }
            }
            else
            {
                if (Request.Cookies["CultureInfo"] != null)
                {
                    ddlLanguage.SelectedValue = Request.Cookies["CultureInfo"].Value;
                    LanguageCode = ddlLanguage.SelectedValue;
                    Session.Add("LanguageCode", ddlLanguage.SelectedValue);
                }
            }
           
             
            string sLangCode = "en-GB";
            string strFileName = "../PlatForm/StyleSheets/Common";
            if (Session["LanguageCode"] != null)
            {
                
                sLangCode = Session["LanguageCode"].ToString();
                var query1 = (from xEle in xDocument.Descendants("LanguageCode")
                              where xEle.Element("Code").Value == sLangCode
                              select new ListItem(xEle.Element("Code").Value, xEle.Element("Alignment").Value)).ToList();
                if (query1[0].Value.ToString() == "RTL")
                {
                    strFileName = strFileName + query1[0].Value.ToString();
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "loadleftsidescroll", "loadleftsidescroll();", true);
                }
                ddlLanguage.SelectedValue = sLangCode;
            }

            
            lnkCommon_css.Attributes.Add("href", strFileName + ".css");
            if (Request.QueryString["ILF"] == null)
            {
                if (IsFirstLogin == "N")
                {
                    Response.Redirect(Request.ApplicationPath + "/UserSettings/ChangePassword.aspx?ILF=Y");
                }
            }
            try
            {
                List<Banners> lstBanners = null;
                returnCode = new Banners_BL(base.ContextInfo).GetBannersText(RoleID, LID, OrgID, out lstBanners);
                if (lstBanners!=null && lstBanners.Count > 0)
                {
                    divBanner.Attributes.Add("class", "marqueemsg");
                    foreach (Banners b in lstBanners)
                    {
                        BannerText += "***" + b.BannerText + "*** ";
                    }
                }
                else
                {
                    divBanner.Attributes.Add("class", "hide");
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
            
            RoleMenu_BL rBL = new RoleMenu_BL(base.ContextInfo);
            List<Alacarte> lstMainMenu;

            rBL.GetAllMenuItems(OrgID, LanguageCode, RoleID, InventoryLocationType, out lstMainMenu);
            rptMainMenu.DataSource = lstMainMenu;
            rptMainMenu.DataBind();

            #region LoadPatientHeader
            //long pid = 0;
            //long visitID = 0;
            //if (!String.IsNullOrEmpty(Request.QueryString["pid"]))
            //{
            //    long.TryParse(Request.QueryString["pid"], out pid);
            //}
            if (!string.IsNullOrEmpty(Request.QueryString["patientID"]))
            {
                long.TryParse(Request.QueryString["patientID"], out pid);
            }

            //if (!string.IsNullOrEmpty(Request.QueryString["vid"]))
            //{
            //    long.TryParse(Request.QueryString["vid"], out visitID);
            //}
            else if (!string.IsNullOrEmpty(Request.QueryString["visitID"]))
            {
                long.TryParse(Request.QueryString["visitID"], out visitID);
            }
            //if (pid != 0 && visitID != 0)
            //{
            //    if (File.Exists(Server.MapPath("../PlatForm/CommonControls/PatientHeader.ascx")))
            //    {
            //        Control objControl = LoadControl("../PlatForm/CommonControls/PatientHeader.ascx");
            //        objControl.ID = "ucPatientHeader";
            //        patientBanner.Controls.Add(objControl);
            //    }
            //}
            #endregion
        }
    }

    public string BannerText { get; set; }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        LogOut();
    }

    protected void RoleChange_Click(object sender, EventArgs e)
    {
        // Department2.LoadLocationsAndRoles();
    }
    private string _appDomain;

    public string AppDomain
    {
        get
        {
            if (string.IsNullOrEmpty(_appDomain))
            {
                _appDomain = Request.Url.Host + "_" + HostingEnvironment.ApplicationHost.GetVirtualPath();
            }
            return _appDomain;
        }
        set { _appDomain = value; }
    }
    private string needPatientHeader = string.Empty;
    public string NeedPatientHeader
    {
        get
        {
            return needPatientHeader;
        }
        set
        {
            needPatientHeader = value;
        }
    }
    //public void LoadLocationsAndRoles()
    //{
    //    GateWay gateway = new GateWay(base.ContextInfo);
    //    List<Role> userRoles = new List<Role>();
    //    Patient patient = new Patient();
    //    List<Users> lstUsers = new List<Users>();
    //    PhysicianSchedule physician = new PhysicianSchedule();
    //    Nurse nurse = new Nurse();
    //    long returnCode = -1;
    //    Attune.Kernel.BusinessEntities.Login login = new Attune.Kernel.BusinessEntities.Login();
    //    Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
    //    loggedIn.LoginID = LID;
    //    returnCode = gateway.GetRoles(loggedIn, out userRoles);
    //    var UOrgs = (from child in userRoles
    //                 orderby child.OrgName
    //                 select new { child.OrgID, child.OrgName }).Distinct();
    //    ddlOrg.DataSource = UOrgs;
    //    ddlOrg.DataTextField = "OrgName";
    //    ddlOrg.DataValueField = "OrgID";
    //    ddlOrg.SelectedValue = OrgID.ToString();
    //    ddlOrg.DataBind();


    //    List<Role> lstRoles = new List<Role>();
    //    lstRoles = (from child in userRoles
    //                where child.OrgID == Convert.ToInt32(ddlOrg.SelectedItem.Value)
    //                orderby child.Description
    //                select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
    //    //select new { child.RoleID, child.RoleName }).Distinct();
    //    //ddlRole.DataSource = lstRoles;
    //    ////ddlRole.DataTextField = "RoleName";
    //    //ddlRole.DataTextField = "Description";
    //    //ddlRole.DataValueField = "RoleName";
    //    //ddlRole.DataBind();
    //    //ddlRole.SelectedValue = RoleID.ToString() + "~" + RoleName;

    //    int iOrgID = Int16.Parse(ddlOrg.SelectedItem.Value);

    //    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();



    //    /********************************** MOOVENDAN **********************************/
    //    long LocID = 0;
    //    string LocName = string.Empty;
    //    returnCode = new Master_BL(base.ContextInfo).GetLocation(iOrgID, LID, RoleID, out lstLocation);

    //    if (lstLocation.Count > 0)
    //    {
    //        LocID = lstLocation[0].AddressID;
    //        LocName = lstLocation[0].Location;
    //        foreach (OrganizationAddress lstLoc in lstLocation)
    //        {
    //            if (lstLoc.AddressID == ILocationID)
    //            {
    //                LocID = lstLoc.AddressID;
    //                LocName = lstLoc.Location;
    //            }
    //        }
    //    }

    //    Session.Add("LocationID", LocID);
    //    Session.Add("LocationName", LocName);
    //    /********************************** MOOVENDAN **********************************/

    //    //if (lstLocation.Count > 0)
    //    //{
    //    //    ddlOrgHeaderLocation.DataSource = lstLocation;
    //    //    ddlOrgHeaderLocation.DataTextField = "Location";
    //    //    ddlOrgHeaderLocation.DataValueField = "AddressID";

    //    //    ddlOrgHeaderLocation.DataBind();
    //    //    ddlOrgHeaderLocation.SelectedValue = ILocationID.ToString();
    //    //}

    //    //--------------------TaskNotification----------------------------------------//
    //    if (TaskNotification != "")
    //    {
    //        if (TaskNotification == "N")
    //            chkTaskNotification.Checked = false;
    //        else
    //            chkTaskNotification.Checked = true;
    //    }
    //    else
    //        chkTaskNotification.Checked = false;
    //    // -------------------------End-----------------------------------------------//
    //}

    //protected void btnRoleOK_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        SetLanguage();

    //        if (Convert.ToString(Session["ThemeID"]) != ddlTheme.SelectedValue)
    //        {
    //            ChangeTheme();
    //        }

    //        if (!string.IsNullOrEmpty(ddlOrgHeaderInvLocation.SelectedValue) && Convert.ToInt16(ddlOrgHeaderInvLocation.SelectedValue) > 0)
    //        {
    //            returnCode = new GateWay(base.ContextInfo).SetDefaultInventoryLocation(LID, int.Parse(ddlOrgHeaderInvLocation.SelectedValue), OrgID, ILocationID);
    //        }

    //        GateWay gateway = new GateWay(base.ContextInfo);
    //        long returncode = 0;
    //        long loginID = -1;
    //        string orgName = string.Empty;
    //        Int64.TryParse(Session["LID"].ToString(), out loginID);
    //        Role loginrole = new Role();
    //        loginrole.OrgID = Convert.ToInt32(ddlOrg.SelectedItem.Value);
    //        loginrole.OrgName = ddlOrg.SelectedItem.Text;

    //        string[] strRole = null;
    //        if (!string.IsNullOrEmpty(hdnRole.Value.Trim()))
    //        {
    //            strRole = hdnRole.Value.Split('~');
    //        }

    //        string[] strLoaction = null;
    //        string strLocationID = "0";
    //        string strLocationName = "0";
    //        if (!string.IsNullOrEmpty(hdnLocation.Value.Trim()))
    //        {
    //            strLoaction = hdnLocation.Value.Split('~');
    //            strLocationID = strLoaction[0];
    //            strLocationName = strLoaction[1];
    //        }


    //        loginrole.RoleID = Convert.ToInt64(strRole[0]);
    //        loginrole.RoleName = strRole[1];


    //        Alacarte menuItem = null;
    //        Attune_Navigation Attune_Navigation = new Attune_Navigation();

    //        returncode = Attune_Navigation.GetLandingPage(loginrole.RoleID, out menuItem);
    //        if (returncode == 0 && menuItem != null)
    //        {
    //            if (Request.Cookies["LeftMenu"] != null)
    //            {
    //                Response.Cookies["LeftMenu"].Expires = DateTime.Now.AddDays(-1);
    //            }
    //            //--------------------TaskNotification----------------------------------------//
    //            // string chkTaskNotificationtext = "";
    //            if (chkTaskNotification.Checked == true)
    //                TaskNotification = "Y";
    //            else
    //                TaskNotification = "N";
    //            ContextInfo.AdditionalInfo = TaskNotification;
    //            Session.Add("TaskNotification", TaskNotification);
    //            Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
    //            long ThemeId = 0;
    //            if (Session["ThemeID"].ToString() != "")
    //                ThemeId = Convert.ToInt64(Session["ThemeID"].ToString());
    //            objTheme_BL.UpdateThemeByLID(LID, ThemeId);
    //            //----------------------End--------------------------------------------------//

    //            List<Config> lstConfig = new List<Config>();
    //            Session.Add("RoleID", loginrole.RoleID.ToString());
    //            Session.Add("OrgID", loginrole.OrgID.ToString());
    //            Session.Add("OrgName", loginrole.OrgName);
    //            Session.Add("OrgDisplayName", loginrole.OrgName);
    //            Session.Add("RoleName", loginrole.RoleName.ToString());
    //            Session.Add("LocationID", strLocationID);
    //            Session.Add("LocationName", strLocationName);
    //            Session.Add("RoleDescription", loginrole.RoleName);
    //            Session.Add("DepartmentID", ddlDepartment.SelectedValue);
    //            LoggedInProfile objLoggedInProfile = new LoggedInProfile();
    //            objLoggedInProfile.IPAddress = Request.UserHostAddress;
    //            objLoggedInProfile.LoginID = loginID;
    //            objLoggedInProfile.OrgAddressID = int.Parse(strLocationID);
    //            objLoggedInProfile.OrgID = loginrole.OrgID;
    //            returncode = gateway.InsertLoggedInProfile(objLoggedInProfile);
    //            Session.Add("InventoryLocationID", "-1");
    //            List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
    //            returncode = gateway.GetLocationUserMap(LID, loginrole.OrgID, Int32.Parse(strLocationID), out lstLocationUserMap);
    //            if (lstLocationUserMap.Count > 0)
    //            {
    //                if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
    //                {
    //                    Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
    //                    Session.Add("InventoryLocationType", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationTypeID);
    //                    Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
    //                }
    //            }
    //            else
    //            {
    //                if (RoleHelper.Inventory != RoleName)
    //                {
    //                    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    //                    returncode = new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("InventoryLocation", loginrole.OrgID, Int32.Parse(strLocationID), out lstInventoryConfig);
    //                    if (lstInventoryConfig.Count > 0)
    //                    {
    //                        Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
    //                    }
    //                }
    //            }

    //            if (!string.IsNullOrEmpty(ddlOrgHeaderInvLocation.SelectedValue) && Convert.ToInt16(ddlOrgHeaderInvLocation.SelectedValue) > 0)
    //            {
    //                Session.Add("InventoryLocationID", ddlOrgHeaderInvLocation.SelectedValue);
    //            }

    //            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
    //            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    //            returncode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(int.Parse(strLocationID), loginrole.RoleID, "", out lstTOD);
    //            if (lstTOD.Count > 0)
    //            {
    //                Session.Add("IsTrustedOrg", "Y");
    //            }
    //            else
    //            {
    //                Session.Add("IsTrustedOrg", "N");
    //            }

    //            returncode = new Configuration_BL(base.ContextInfo).GetConfigDetails("UseOrgBasedDrugData", loginrole.OrgID, out lstConfig);
    //            if (lstConfig.Count > 0)
    //            {
    //                if (lstConfig[0].ConfigValue == "Y")
    //                    Session.Add("DrugOrgID", loginrole.OrgID);
    //                else
    //                    Session.Add("DrugOrgID", 0);
    //            }
    //            else
    //            {
    //                Session.Add("DrugOrgID", 0);
    //            }
    //            returncode = new Configuration_BL(base.ContextInfo).GetConfigDetails("IsAmountEditable", loginrole.OrgID, out lstConfig);
    //            if (lstConfig.Count > 0)
    //                Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
    //            else
    //                Session.Add("IsAmountEditable", "Y");

    //            Response.Redirect(Request.ApplicationPath + menuItem.MenuURL, true);
    //            Attune_Helper.PageRedirect(Page, Request.ApplicationPath + menuItem.MenuURL);
    //        }

    //    }

    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }

    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while moving between available roles", ex);
    //    }

    //}


    //protected void SetLanguage()
    //{
    //    //Sets the cookie that is to be used by Global.asax
    //    HttpCookie cookie = new HttpCookie("CultureInfo");
    //    cookie.Value = ddlLanguage.SelectedValue;
    //    Response.Cookies.Add(cookie);
    //    //Set the culture and reload the page for immediate effect. 
    //    //Future effects are handled by Global.asax
    //    Thread.CurrentThread.CurrentUICulture = new CultureInfo(ddlLanguage.SelectedValue);
    //    Thread.CurrentThread.CurrentCulture = new CultureInfo(ddlLanguage.SelectedValue);
    //    base.ContextInfo.LanguageCode = ddlLanguage.SelectedValue;
    //    Session["LanguageCode"] = ddlLanguage.SelectedValue;
    //}


    //void LoadDepartment()
    //{
    //    long returnCode = -1;
    //    List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
    //    GateWay obj = new GateWay(base.ContextInfo);
    //    // returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
    //    if (lstEmpDeptMaster.Count > 0)
    //    {
    //        ddlDepartment.DataSource = lstEmpDeptMaster;
    //        ddlDepartment.DataValueField = "Code";
    //        ddlDepartment.DataTextField = "EmpDeptName";
    //        ddlDepartment.DataBind();

    //    }
    //    else
    //    {
    //        ddlDepartment.Items.Insert(0, GetMetaData("Select", "0"));
    //        ddlDepartment.Items[0].Value = "0";
    //    }

    //    if (!string.IsNullOrEmpty(DepartmentID))
    //    {
    //        ddlDepartment.SelectedValue = DepartmentID;
    //    }
    //}
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
			CLogger.LogError("Error while loading ShowAlertForTestURL-Attune_OrgHeader", ec);
            _flag = true;
        }


        string userName = string.Empty;
        if (WebConfigurationManager.AppSettings["IsLiveURL"] != null)
        {
            userName = Convert.ToString(WebConfigurationManager.AppSettings["IsLiveURL"]);
            string sPath = Resources.PlatFormControls_ClientDisplay.PlatFormControls_Attune_OrgHeader_ascx_cs_01;
            string.Format(sPath, userName);
            if (sPath == null)
            {
                sPath = "UserName: " + userName;
            }
            //lblUserName.Text = sPath;
        }

        if (!string.IsNullOrEmpty(userName) && userName.ToUpper().Contains("YES") && _flag)
        {
            hdnTestURLFlag.Value = "ShowAlert";
            Session["UserAlert"] = "Showed";
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
        List<Config> lstConfig = null;

        returncode = new Configuration_BL(base.ContextInfo).GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig !=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    public void LoadErrorMsg(string ErrorMsg)
    {
        Control oControl = (Control)this.FindControl("TopHeader1");
        if (oControl != null)
        {
            //CommonControls_ErrorDisplay oED ;
            //oED = (CommonControls_ErrorDisplay)oControl.FindControl("//ErrorDisplay1");
            //if (oED != null)
            //{   
            //    oED.ShowError = true;
            //    oED.Status = ErrorMsg;
            //}
        }
    }



    

    public void LoadInvLocation()
    {
        //Department2.LoadLocationUserMap();
    }

    //public void LoadLocationUserMap()
    //{
    //    long iOrgID = Int64.Parse(OrgID.ToString());
    //    long returnCode = -1;
    //    List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
    //    returnCode = new GateWay(base.ContextInfo).GetLocationUserMap(LID, OrgID, ILocationID, out lstLocationUserMap);
    //    if (lstLocationUserMap != null && lstLocationUserMap.Count > 0)
    //    {
    //        ddlOrgHeaderInvLocation.DataSource = lstLocationUserMap;
    //        ddlOrgHeaderInvLocation.DataTextField = "LocationName";
    //        ddlOrgHeaderInvLocation.DataValueField = "LocationID";
    //        ddlOrgHeaderInvLocation.DataBind();
    //    }
    //    ddlOrgHeaderInvLocation.Items.Insert(0, GetMetaData("Select", "0"));
    //    ddlOrgHeaderInvLocation.Items[0].Value = "-1";
    //    ddlOrgHeaderInvLocation.SelectedValue = InventoryLocationID.ToString();
    //}
    //protected override void OnPreRender(EventArgs e)
    //{
    //    if (Thread.CurrentThread.CurrentUICulture.IetfLanguageTag == "ar-SA")
    //    {
    //        lnkCommon_css.Attributes.Remove("href");
    //        lnkCommon_css.Attributes.Add("href", "../PlatForm/StyleSheets/CommonRTL.css");
    //    }

    //    base.OnPreRender(e);
    //}

    //protected void BtnthemeChange_Click(object sender, EventArgs e)
    //{
    //    ChangeTheme();
    //}

    //protected void ChangeTheme()
    //{
    //    if (!string.IsNullOrEmpty(ddlTheme.SelectedValue))
    //    {
    //        long themesID = -1;
    //        Int64.TryParse(ddlTheme.SelectedValue, out themesID);
    //        Theme_BL objTheme_BL = new Theme_BL(base.ContextInfo);
    //        objTheme_BL.UpdateThemeByLID(LID, themesID);
    //        Session.Add("ThemeID", "");
    //        Session.Add("ThemeID", themesID);
    //    }
    //}
    protected void rptMainMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item != null)
        {
            Repeater rptSubMenu = (Repeater)e.Item.FindControl("rptMenu");
            Alacarte objMenu = e.Item.DataItem as Alacarte;

            if (rptSubMenu != null && objMenu != null)
            {
                if (objMenu.SubMenu.Count > 0)
                {
                    rptSubMenu.DataSource = objMenu.SubMenu.Where(o=>o.IsMenu=="1");
                    rptSubMenu.DataBind();
                }
                else
                {
                    e.Item.Visible = false;
                }
            }

        }
    }

    //private void LoadThemeCtrl()
    //{
    //    long retCode = -1;
    //    Theme_BL ThmBL = new Theme_BL(base.ContextInfo);
    //    List<Theme> lstThemeName = new List<Theme>();
    //    retCode = ThmBL.GetTheme(out lstThemeName);
    //    ddlTheme.DataSource = lstThemeName;
    //    ddlTheme.DataBind();
    //    int ThemeID = 0;
    //    int.TryParse(Convert.ToString(Session["ThemeID"]), out ThemeID);
    //    string ThemeValue = (from c in lstThemeName
    //                         where c.ThemeID == ThemeID
    //                         select c.ThemeURL).SingleOrDefault();
    //    SetTheme(ThemeID, ThemeValue);
    //}

    //private void SetTheme(int themeID, string themeValue)
    //{

    //    try
    //    {
    //        hdnThemesetValue.Value = "1";

    //        if (!string.IsNullOrEmpty(lnkStyle.Attributes["href"]))
    //        {
    //            lnkStyle.Attributes.Remove("href");
    //        }
    //        lnkStyle.Attributes.Add("href", "../PlatForm" + themeValue);

    //        //link.Text = "<link media=\"all\" href=\"../PlatForm" + dt.Value.ToString() + "\" rel=\"stylesheet\" type=\"text/css\"  />";
    //        if (Page.Header != null)
    //        {
    //            //Page.Header.Controls.Add(link);
    //            hdnThemesetValue.Value = "0";
    //        }
    //        else
    //        {
    //            hdnThemesetValue.Value = "1";
    //        }

    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //}



}

