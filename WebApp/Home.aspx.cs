using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using Attune.Kernel.PlatForm.Utility;
using System.Xml.Xsl;
using System.Web.Caching;
using Attune.Kernel.TrustedOrg;
using System.IO;
using System.Threading;
using System.Globalization;
using System.Linq;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.BusinessEntities;
using System.Web.Hosting;
using System.Text;
using System.Xml.Linq;
using Attune.Kernel.PlatForm.BL;
using System.Text.RegularExpressions;
using Attune.Cryptography;

public partial class Masters_Home : System.Web.UI.Page
{
    //string sUserMessage = string.Empty;
    public string sUserMessage_1 = Resources.Home_AppMsg._Home_aspx_01;
    public string sUserMessage_2 = Resources.Home_AppMsg._Home_aspx_02;
    public string sUserMessage_3 = Resources.Home_AppMsg._Home_aspx_03;
    public string sUserMessage_4 = Resources.Home_AppMsg._Home_aspx_04;
    public string sUserMessage_5 = Resources.Home_AppMsg._Home_aspx_05;
    public string sUserMessage_6 = Resources.Home_AppMsg._Home_aspx_06;
    public String strBrowser = string.Empty;
    string OS = string.Empty;
    public string strBrowserVersion = string.Empty;
     
    public string LanguageCode { get; set; }
    public Masters_Home()
    {
        LanguageCode = "en-GB";


        if (Thread.CurrentThread.CurrentUICulture.IetfLanguageTag != "en-GB")
        {
            LanguageCode = "." + Thread.CurrentThread.CurrentUICulture.IetfLanguageTag;

        }
        

    }
    
    
    public object Attune_LocalResourceObject(string sResourceFile, string sKey)
    {
        string resourceValues = "";
        try
        {
            //return HttpContext.GetLocalResourceObject(sResourceFile, sKey);
            //return HttpContext.GetGlobalResourceObject(sResourceFile, sKey);
            List<Attune.Podium.BusinessEntities.MetaData> lstMetaData = Attune.Podium.Common.ResourceHelper.GetResourceByFileName(sResourceFile);

            foreach (Attune.Podium.BusinessEntities.MetaData entry in lstMetaData)
            {
                if (entry.Code.Contains(sKey) || entry.Code.Contains("_js") || entry.Code.Contains("_Cancel") || entry.Code.Contains("_Error")
                    || entry.Code.Contains("_Information") || entry.Code.Contains("_Ok"))
                {
                    resourceValues = resourceValues + "^" + entry.Code + "=" + entry.DisplayText;
                }
            }

            resourceValues = resourceValues.TrimStart('^');

        }

        catch (System.Resources.MissingManifestResourceException)
        {
            return null;
        }
        catch (Exception ex)
        {
            return null;
        }
        return resourceValues;
    }

    public void page_Init(object sender, EventArgs e)
    {
         
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        //test 1
        if (!IsPostBack)
        {
            if (Request.Cookies["CSGuid"] != null)
            {
                Response.Cookies["CSGuid"].Expires = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-1);
            }
            string _LandingPageLogo = string.Empty;
                try
                {
                    if (Request.QueryString["LoginPageLogo"] != null)
                    {
                        string LandingPageLogo = Request.QueryString["LoginPageLogo"].ToString();
                        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                        obj.Crypt(LandingPageLogo, out _LandingPageLogo);
                        if (!string.IsNullOrEmpty(_LandingPageLogo))
                        {
                            LoginPageLogo.ImageUrl = "~/Images/" + _LandingPageLogo + ".png";
                            CLogger.LogWarning(_LandingPageLogo + LoginPageLogo.ImageUrl);
                            //Request.Cookies["LoginLogo"].Value = LandingPageLogo;

                            HttpCookie cookie = new HttpCookie("LoginLogo");
                            cookie.Value = LandingPageLogo;
                            Response.Cookies.Add(cookie);
                            
                        }
                        else
                        {
                            LoginPageLogo.ImageUrl = "Images/logo.png";
                            HttpCookie cookie = new HttpCookie("LoginLogo");
                            cookie.Value = null;
                            Response.Cookies.Add(cookie);
                        }
                    }
                    else
                    {
                        LoginPageLogo.ImageUrl = "Images/logo.png";
                        HttpCookie cookie = new HttpCookie("LoginLogo");
                        cookie.Value = null;
                        Response.Cookies.Add(cookie);
                    }

                    if (Request.QueryString["CSID"] != null)
                    {
                        string CSID = Request.QueryString["CSID"].ToString();
                        string _CobrandingLogo = string.Empty;
                        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                        obj.Crypt(CSID, out _CobrandingLogo);
                        if (!string.IsNullOrEmpty(_CobrandingLogo))
                        {
                            imgCustomerLogo.ImageUrl = "~/Images/CoBrandingLogo/" + _CobrandingLogo + ".png";
                        }
                    }



                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error in convertiong logo path" + _LandingPageLogo, ex);
                    LoginPageLogo.ImageUrl = "Images/logo.png";
                }

            //txtPassword.Attributes.Add("Placeholder", Resources.Home_ClientDisplay._Home_aspx_01 == null ? "Enter Password" : Resources.Home_ClientDisplay._Home_aspx_01);
            //txtUserName.Attributes.Add("Placeholder", Resources.Home_ClientDisplay._Home_aspx_02 == null ? "Enter UserName" : Resources.Home_ClientDisplay._Home_aspx_02);
            if (Request.Cookies["CultureInfo"] != null)
                ddLang.SelectedValue = Request.Cookies["CultureInfo"].Value;
            LanguageCode = ddLang.SelectedValue;
            Session.Add("LanguageCode", ddLang.SelectedValue);
            if (Request.Cookies["LeftMenu"] != null)
            {
                Response.Cookies["LeftMenu"].Expires = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-1);
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

            String userAgent = Request.UserAgent;
            if (userAgent.IndexOf("Windows NT 6.3") > 0)
            {
                OS = "Windows 8.1";
            }
            else if (userAgent.IndexOf("Windows NT 6.2") > 0)
            {
                OS = "Windows 8";
            }
            else if (userAgent.IndexOf("Windows NT 6.1") > 0)
            {
                OS = "Windows 7";
            }
            else if (userAgent.IndexOf("Windows NT 6.0") > 0)
            {
                OS = "Windows Vista";
            }
            else if (userAgent.IndexOf("Windows NT 5.2") > 0)
            {
                OS = "Windows Server 2003";
            }
            else if (userAgent.IndexOf("Windows NT 5.1") > 0)
            {
                OS = "Windows XP";
            }
            else if (userAgent.IndexOf("Windows NT 5.01") > 0)
            {
                OS = "Windows 2000, Service Pack 1 (SP1)";
            }
            else if (userAgent.IndexOf("Windows NT 5.0") > 0)
            {
                OS = "Windows 2000";
            }
            else if (userAgent.IndexOf("Windows NT 4.0") > 0)
            {
                OS = "Microsoft Windows NT 4.0";
            }
            else if (userAgent.IndexOf("Win 9x 4.90") > 0)
            {
                OS = "Windows Millennium Edition (Windows Me)";
            }
            else if (userAgent.IndexOf("Windows 98") > 0)
            {
                OS = "Windows 98";
            }
            else if (userAgent.IndexOf("Windows 95") > 0)
            {
                OS = "Windows 95";
            }
            else if (userAgent.IndexOf("Windows CE") > 0)
            {
                OS = "Windows CE";
            }
            else
            {
                OS = Convert.ToString(userAgent);
            }

            #region Language

            XDocument xDocument = XDocument.Load(Server.MapPath("~\\App_Data\\ApplicationSettings.xml"));
            var query = from xEle in xDocument.Descendants("LanguageCode")
                        select new ListItem(xEle.Element("Name").Value, xEle.Element("Code").Value);

            ddLang.DataSource = query;
            ddLang.DataTextField = "text";
            ddLang.DataValueField = "value";
            ddLang.DataBind();

            #endregion

        }
      
        string strFileName = "LTL";
        LanguageCode = ddLang.SelectedValue;
        XDocument xDocument1 = XDocument.Load(Server.MapPath("~\\App_Data\\ApplicationSettings.xml"));
        var query1 = (from xEle in xDocument1.Descendants("LanguageCode")
                      where xEle.Element("Code").Value == LanguageCode
                      select new ListItem(xEle.Element("Code").Value, xEle.Element("Alignment").Value)).ToList();
        //if (query1[0].Value.ToString() == "RTL")
        //{
        linkCommonCSS.Attributes.Add("href", strFileName + ".css");
       // strFileName = "PlatForm/StyleSheets/Common";
        strFileName = "StyleSheets/Style";
        if (query1[0].Value.ToString() == "RTL")
        {
            strFileName = strFileName + query1[0].Value.ToString();
        }
        linkCommonCSS.Attributes.Add("href", strFileName + ".css");
        try
        {
            if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["LoginBackgroundImage"]))
            {
                string imagePath = ConfigurationManager.AppSettings["LoginBackgroundImage"];
                if (File.Exists(HttpContext.Current.Request.PhysicalApplicationPath + imagePath))
                {
                    System.Drawing.Image image = System.Drawing.Image.FromFile(HttpContext.Current.Request.PhysicalApplicationPath + imagePath);
                    if (image != null)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "BackgroundImage", "javascript:SetBodyBackground('" + imagePath + "');", true);
                        divLoginImg.Style.Add("background-image", "");
                        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["LoginLabelTextColor"]))
                        {
                            string color = ConfigurationManager.AppSettings["LoginLabelTextColor"];
                            Language.Style.Add("color", color);
                        }
                        //divLoginImg.Style.Add("width", image.Width + "px");
                        //if (image.Width > 520)
                        //{
                        //    divLoginImg.Style.Add("margin-left", "20%");
                        //    tblInputBox.Style.Add("width", "160px");
                        //}
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load " + ex.Message, ex);
        }
    }
    protected void lnkforgetPassword_Click(object sender, EventArgs e)
    {
       Response.Redirect("~/ForgotPassword.aspx");
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {

    }
    bool _flag = false;
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

    protected void imgGo_Click(object sender, EventArgs e)
    {
        try
        {
            Session["MacAddress"] = hdnMacAddress.Value;
            Session["RegKeyExists"] = hdnRegKeyExists.Value;
            GateWay gateWay = new GateWay();
            if (Session["RoleID"] != null || Session["OrgID"] != null || Session["LID"] != null)
            {
                if (gateWay.CheckIfLoggedIn(Convert.ToInt64(Session["LID"]), Session.SessionID) == 1)
                {
                    if (sUserMessage_1 == null)
                    {
                        sUserMessage_1 = "Session Already Exists. Logout from the previous session.";
                    }
                    string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }

                    //lblStatus.Text = "There is a live session already running on this machine.Please log-out from the previous session.";
                    // lblStatus.Text = "Session Already Exists. Please log-out from the previous session";
                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_2").ToString();

                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_1").ToString();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + sUserMessage_1 + "','" + ErrorMsg + "');", true);
                    //sUserMessage = "Home.aspx_1";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                }
                else
                {
                    _flag = true;
                }
            }
            else
            {
                _flag = true;
            }
            if (_flag)
            {
                ContinueLogin();
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
    //TODO: Authorization
    private void ContinueLogin()
    {
        long returnCode = 0;
        string relPagePath = string.Empty;
        //long loginID = 0;
        Attune.Kernel.BusinessEntities.Login login = new Attune.Kernel.BusinessEntities.Login();
        Attune.Kernel.BusinessEntities.Login loggedIn = new Attune.Kernel.BusinessEntities.Login();
         

        GateWay gateWay = new GateWay(new ContextDetails() { LanguageCode = Convert.ToString(Session["LanguageCode"]) });
        Patient patient = new Patient();
        List<Users> lstUsers = new List<Users>();
        List<EmployerDeptMaster> lstDeptarment = new List<EmployerDeptMaster>();
        PhysicianSchedule physician = new PhysicianSchedule();
        Nurse nurse = new Nurse();
        ClientMaster clientMaster = new ClientMaster();
        // int phyID = 0;
        login.LoginName = txtUserName.Text;

        //login.Password = txtPassword.Text;

        string EncryptedString = string.Empty;
        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
        obj.Crypt(txtPassword.Text, out EncryptedString);
        login.Password = EncryptedString;

        try
        {
            int OrgID = -1;
            string IsLocked = "";
            string IsExpired = "";
            string IsBlocked = "";
            string BlockedTo = "";
            Guid LoginTime = new Guid();
            //returnCode = new Attune_Gateway.AuthenticateUser(login, Session.SessionID, out loggedIn, out OrgID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo);
            returnCode = new Attune.Kernel.PlatForm.BL.GateWay().AuthenticateUser(login, Session.SessionID, "", out loggedIn, out OrgID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo, out LoginTime, out lstDeptarment);

            if (returnCode != -1)
            {
                if (IsExpired != "Y")
                {
                    if (IsBlocked != "Y" && BlockedTo == "" || BlockedTo != "")
                    {
                        if (IsBlocked != "Y" && BlockedTo != "" || IsBlocked == "")
                        {
                            if (IsLocked != "")
                            {

                                if (IsLocked == "N")
                                {
                                    if (returnCode == 0)
                                    {
                                        //Prasanna Changes Starts
                                        //imgGo.Enabled = false;
                                        //Prasanna Changes Ends

                                        //--------------------TaskNotification----------------------------------------//
                                        returnCode = -1;
                                        long TLoginID = loggedIn.LoginID;

                                        returnCode = new GateWay().GetUserDetail(TLoginID, out lstUsers);
                                        if (lstUsers != null)
                                        {
                                        if (lstUsers.Count > 0)
                                        {
                                            if (!string.IsNullOrEmpty(lstUsers[0].Remarks))
                                            {
                                                Session.Add("TaskNotification", lstUsers[0].Remarks);
                                            }
                                            else
                                            {
                                                Session.Add("TaskNotification", "N");
                                            }
                                        }
                                        }
                                        //-------------------------End-----------------------------------------//
                                        returnCode = -1;
                                        List<Role> userRoles = new List<Role>();
                                        List<Config> lstMobileConfig = new List<Config>();
                                        returnCode = new GateWay(new ContextDetails() { LanguageCode = Convert.ToString(Session["LanguageCode"]) }).GetRoles(loggedIn, out userRoles);
                                        var lstOrgId = userRoles.GroupBy(org => org.OrgID).ToList();
                                        if (returnCode >= 0 && userRoles.Count > 0)
                                        {
                                            returnCode = -1;
                                            List<Config> lstConfig = new List<Config>();

                                            Session.Add("OrgID", userRoles[0].OrgID.ToString());
                                            Session.Add("OrgName", userRoles[0].OrgName);
                                            Session.Add("OrgTimeZone", userRoles[0].OrgTimeZone);
                                            if (userRoles[0].OrgDisplayName != null)
                                            {
                                                Session.Add("OrgDisplayName", userRoles[0].OrgDisplayName.ToString());
                                            }
                                            else
                                            {
                                                Session.Add("OrgDisplayName", "");
                                            }
                                            Session.Add("LID", loggedIn.LoginID.ToString());


                                            string strLoggedInTime;
                                            RSACryptography obj1 = new RSACryptFactory().GetEncryptor();
                                            string publicKey = ConfigurationManager.AppSettings["public"];
                                            obj1.Crypt(Convert.ToString(LoginTime), publicKey, out strLoggedInTime);
                                            strLoggedInTime = Uri.EscapeDataString(strLoggedInTime);
                                            Session.Add("loginGuid", strLoggedInTime);
                                            string strLoggedInClient = "";
                                            obj1.Crypt("LISKernelApp||LISKernelApp", publicKey, out strLoggedInClient);
                                            strLoggedInClient = Uri.EscapeDataString(strLoggedInClient);
                                            Session.Add("LoggedInApp", strLoggedInClient);

                                            Session.Add("RoleName", userRoles[0].RoleName.ToString());
                                            Session.Add("RoleDescription", userRoles[0].Description.ToString());
                                            Session.Add("IntegrationName", Convert.ToString(userRoles[0].IntegrationName));
                                            Session.Add("ThemeID", loggedIn.ThemeID.ToString());
                                            Session.Add("IsFirstLogin", loggedIn.IsFirstLogin);
                                            Session.Add("DeptID", userRoles[0].ParentID);
                                            Session.Add("LoginName", loggedIn.LoginName);
                                            if (lstDeptarment != null && lstDeptarment.Count > 0)
                                                Session.Add("DepartmentID", lstDeptarment[0].Code);

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("IsEnableMobileLOgin", userRoles[0].OrgID, out lstMobileConfig);
											if(lstMobileConfig!=null)
											{
                                            if (lstMobileConfig.Count > 0)
                                            {
                                                if (lstMobileConfig[0].ConfigValue == "Y")
                                                {
                                                    if (Request.Browser.IsMobileDevice)
                                                    {
                                                        return;
                                                    }

                                                }
                                            }
											}
                                            //Added By Ramki
                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("UseOrgBasedDrugData", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null && lstConfig.Count > 0)
                                            {
                                                if (lstConfig[0].ConfigValue == "Y")
                                                    Session.Add("DrugOrgID", userRoles[0].OrgID);
                                                else
                                                    Session.Add("DrugOrgID", 0);
                                            }
                                            if (lstConfig != null && lstConfig.Count > 0)
                                            {
                                                if (lstConfig[0].ConfigValue == "Y")
                                                    Session.Add("DrugOrgID", userRoles[0].OrgID);
                                                else
                                                    Session.Add("DrugOrgID", 0);
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("UploadPath", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("UploadPath", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("UploadPath", "");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("IsCorporateOrg", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("IsCorporateOrg", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("IsCorporateOrg", "N");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("HideIPManageRate", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("HideIPManageRate", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("HideIPManageRate", "N");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("NoBilling", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("IsCorporateOrgPaymenttype", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("IsCorporateOrgPaymenttype", "N");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("Employee", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("Employee", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("Employee", "N");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("Currency", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("OrgCurrency", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("OrgCurrency", "");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("IsAmountEditable", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("IsAmountEditable", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("IsAmountEditable", "Y");
                                            }

                                            returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("CurrencyFormat", userRoles[0].OrgID, out lstConfig);
                                            if (lstConfig != null)
                                            {
                                                if (lstConfig.Count > 0)
                                                    Session.Add("OrgCurrencyFormat", lstConfig[0].ConfigValue);
                                                else
                                                    Session.Add("OrgCurrencyFormat", "");
                                            }

                                            List<CurrencyDetails> lstCurrencyDetails = new List<CurrencyDetails>();
                                            returnCode = gateWay.GetCurrencyDetails(userRoles[0].OrgID, out lstCurrencyDetails);
                                           if(lstCurrencyDetails !=null && lstCurrencyDetails.Count>0)
                                            Session.Add("MinorCurrency",  lstCurrencyDetails.Find(p => p.IsBaseCurrency == "Y").MinorCurrencyDisplayText );

                                            GateWay headBl = new GateWay();
                                            //Prasanna Added Below lines
                                            Session.Add("LogoPath", userRoles[0].LogoPath);
                                            CLogger.LogInfo("OrgName : " + userRoles[0].OrgName);
                                            CLogger.LogInfo("IP Addr : " + Request.UserHostAddress);
                                            CLogger.LogInfo("Date : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone));
                                            CLogger.LogInfo("Role : " + userRoles[0].RoleName + " & UserName : " + txtUserName.Text);
                                            //Prasanna lines End
                                            if (userRoles.Count >= 1)
                                            {
                                                returnCode = -1;
                                                Session.Add("RoleID", userRoles[0].RoleID.ToString());
                                                switch (userRoles[0].RoleName)
                                                {
                                                    case "Physician": // Physician
                                                        returnCode = headBl.GetPhysicianDetails(loggedIn.LoginID, out physician);
                                                        Session.Add("Name", physician.PhysicianName + " [ " + physician.SpecialityName + " ]");
                                                        Session.Add("UserName", physician.PhysicianName);
                                                        returnCode = 0;
                                                        Session.Add("UserID", physician.PhysicianID);
                                                        break;
                                                    case "Nurse": // Nurse
                                                        returnCode = headBl.GetNurseDetails(loggedIn.LoginID, out nurse);
                                                        Session.Add("UserName", nurse.NurseName);
                                                        Session.Add("UserID", nurse.NurseID);
                                                        break;

                                                    case "Client": //Client --- Added By Leo -- ClientPortal
                                                        returnCode = headBl.GetClientDetails(loggedIn.LoginID, out clientMaster);
                                                        Session.Add("CID", clientMaster.ClientID);
                                                        Session.Add("UserName", clientMaster.ClientName);
                                                        Session.Add("UserID", loggedIn.LoginID);
                                                        break;


                                                    case "Remote Registration": //Client --- Added By Sathish.E -- ClientPortal
                                                        returnCode = headBl.GetClientDetails(loggedIn.LoginID, out clientMaster);
                                                        Session.Add("CID", clientMaster.ClientID);
                                                        Session.Add("UserName", clientMaster.ClientName);
                                                        Session.Add("UserID", loggedIn.LoginID);
                                                        break;
                                                    case "Patient": // Patient
                                                        List<Patient> lstPatient = new List<Patient>();

                                                        returnCode = headBl.GetPatientDetail(loggedIn.LoginID, out lstPatient);

                                                        Session.Add("UserName", lstPatient[0].Name);
                                                        Session.Add("LoginName", lstPatient[0].PatientNumber);
                                                        Session.Add("Age", lstPatient[0].Age);
                                                        Session.Add("UID",lstPatient[0].PatientID);
                                                        Session.Add("UserID",loggedIn.LoginID);
                                                        Session.Add("BloodGroup", lstPatient[0].BloodGroup);
                                                        Session.Add("URNo", lstPatient[0].URNO);
                                                        if (lstPatient[0].Status == "N")
                                                        {
                                                            Session.Add("LogoPath", "Images/Logo/attune_logo.png");
                                                            // Response.Redirect("PatientAccountInfo.aspx", true);
                                                            string strRedirectURL = ConfigurationManager.AppSettings["ApplicationName"] + "/PatientAccountInfo.aspx" + "?IsPopup=Y";
                                                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "Redirect('" + strRedirectURL + "');", true);


                                                        }
                                                        else
                                                        {
                                                            Session.Add("LogoPath", "../Images/Logo/attune_logo.png");

                                                        }
                                                        returnCode = 0;
                                                        break;

                                                    //Team please add Code for Exceptional role only (like Physician,Nurse)
                                                    #region "Duplicate Code"

                                                    //Commented Code 

                                                    //case "Lab Technician": // Lab Tech
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "Receptionist": // Reception
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "Administrator": // Admin
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "Senior Lab Technician": // Senior Lab
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "Dialysis Technician": // Dialysis Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "HematologyLab": // Hematology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "BioChemistryLab": // BioChemistry Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "MicroBiologyLab": // MicroBiology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;

                                                    //case "ClinicalPathologyLab": // Clinical Pathology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    ////

                                                    //case "BloodBankLab": // BloodBank Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "CytogeneticsLab": // Cytogenetics Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "GeneralLab": // General Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "HistopathologyLab": // Histopathology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "ImagingLab": // Imaging Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;
                                                    //case "ImmunologyLab": // Immunology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "MolecularBiologyLab": // MolecularBiology Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "DDCLab": // DDC Lab Technician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "Billing": // Billing 
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "Xray": // Xray
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "Accounts": // Accounts
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "Pharmacist": // Accounts
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "Inventory": // inventory 
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "JrLabTech": // Senior Lab
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    returnCode = 0;
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    break;


                                                    //case "LabTechnician": // Dispatch
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "MRILabTech": // Dispatch
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "CTLabTech": // Dispatch
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;


                                                    //case "Ultrasonographer": // Dispatch
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "Endoscopy": // Dispatch
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "MRO": // MRO
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "Cashier": // Cashier
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    //case "LabAdmin": // LabAdmin
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "LabReception": // LabReception
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "Physiotherapist": // Physiotherapist
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].FORENAME);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;

                                                    //case "Referring Physician": // ReferingPhysician
                                                    //    returnCode = gateWay.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    //    Session.Add("UserName", lstUsers[0].Name);
                                                    //    Session.Add("UserID", lstUsers[0].UserID);
                                                    //    Session.Add("LoginName", lstUsers[0].LoginName);
                                                    //    returnCode = 0;
                                                    //    break;
                                                    #endregion
                                                    default:
                                                        returnCode = headBl.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                        string LanguageCode = "";
                                                        if (Session["LanguageCode"] != null)
                                                        {
                                                            LanguageCode = Session["LanguageCode"].ToString();
                                                        }
                                                        for (int i = 0; i < lstUsers.Count; i++)
                                                        {
                                                            //if (lstUsers[i].TitleCode == LanguageCode)
                                                            //{
                                                            Session.Add("UserName", lstUsers[i].Name);
                                                            Session.Add("UserID", lstUsers[i].UserID);
                                                            Session.Add("LoginName", lstUsers[i].LoginName);
                                                            break;
                                                            //}
                                                        }
                                                        returnCode = 0;
                                                        break;

                                                };

                                                if (((int.Parse(Session["UserID"].ToString()) == 0) && (Session["UserName"] == "")))
                                                {
                                                    returnCode = headBl.GetUserDetail(loggedIn.LoginID, out lstUsers);
                                                    string LanguageCode = "";
                                                    if (Session["LanguageCode"] != null)
                                                    {
                                                        LanguageCode = Session["LanguageCode"].ToString();
                                                    }
                                                    for (int i = 0; i < lstUsers.Count; i++)
                                                    {
                                                        if (lstUsers[i].TitleCode == LanguageCode)
                                                        {
                                                            Session.Add("UserName", lstUsers[i].Name);
                                                            Session.Add("UserID", lstUsers[i].UserID);
                                                            Session.Add("LoginName", lstUsers[i].LoginName);
                                                            break;
                                                        }
                                                    }
                                                    returnCode = 0;
                                                }
                                                string Need_Department = string.Empty;
                                                Need_Department = "N";
                                                returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetConfigDetails("Need_Department", userRoles[0].OrgID, out lstConfig);
                                                if (lstConfig != null)
                                                {
                                                    if (lstConfig.Count > 0)
                                                    {
                                                        Need_Department = lstConfig[0].ConfigValue;
                                                    }
                                                }

                                                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                                                returnCode = new Attune.Kernel.PlatForm.BL.Organization_BL().GetLocation(userRoles[0].OrgID, loggedIn.LoginID, userRoles[0].RoleID, out lstLocation);
                                                if ((lstLocation.Count > 1) || (userRoles.Count > 1))
                                                {
                                                    if (lstOrgId.Count == 1)
                                                    {
                                                        string strAddrssID = string.Empty;
                                                        foreach (OrganizationAddress objAdd in lstLocation)
                                                        {
                                                            strAddrssID += objAdd.AddressID.ToString() + "*" + objAdd.CountryID.ToString() + "~" + objAdd.StateID.ToString() + "^";
                                                        }
                                                        Session.Add("AddressID", strAddrssID);
                                                    }
                                                    //string strRedirectURL = ConfigurationManager.AppSettings["ApplicationName"] + "/SelectRole.aspx" + "?IsPopup=Y";
                                                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "Redirect('" + strRedirectURL + "');", true);
                                                    if ((userRoles[0].RoleName == "Client" || userRoles[0].RoleName == "Remote Registration") && Session["UserName"] == "")
                                                    {
                                                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_100", "javascript:ValidationWindow('Login details are not mapped properly. Please contact support team','Login') return false;", true);

                                                    }
                                                    else
                                                    {
                                                        Response.Redirect("SelectRole.aspx", false);
                                                    }
                                                }
                                                else if (Need_Department == "Y")
                                                {
                                                    if (lstOrgId.Count == 1)
                                                    {
                                                        string strAddrssID = string.Empty;
                                                        foreach (OrganizationAddress objAdd in lstLocation)
                                                        {
                                                            strAddrssID += objAdd.AddressID.ToString() + "*" + objAdd.CountryID.ToString() + "~" + objAdd.StateID.ToString() + "^";
                                                        }
                                                        Session.Add("AddressID", strAddrssID);
                                                    }
                                                    //string strRedirectURL = ConfigurationManager.AppSettings["ApplicationName"] + "/SelectRole.aspx" + "?IsPopup=Y";
                                                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "Redirect('" + strRedirectURL + "');", true);
                                                    if ((userRoles[0].RoleName == "Client" || userRoles[0].RoleName == "Remote Registration") && Session["UserName"] == "")
                                                    {
                                                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_100", "javascript:ValidationWindow('Login details are not mapped properly. Please contact support team','Login') return false;", true);

                                                    }
                                                    else
                                                    {
                                                        Response.Redirect("SelectRole.aspx", false);
                                                    }
                                                }

                                                Session.Add("LocationID", lstLocation[0].AddressID);
                                                Session.Add("LocationName", lstLocation[0].Location);
                                                LoggedInProfile objLoggedInProfile = new LoggedInProfile();
                                                objLoggedInProfile.IPAddress = Request.UserHostAddress;
                                                objLoggedInProfile.LoginID = loggedIn.LoginID;
                                                objLoggedInProfile.OrgAddressID = (int)lstLocation[0].AddressID;
                                                objLoggedInProfile.OrgID = userRoles[0].OrgID;
                                                HttpCookie CSGuid = new HttpCookie("CSGuid");
                                                CSGuid.Value = userRoles[0].OrgID.ToString();
                                                Response.Cookies.Add(CSGuid);

                                                objLoggedInProfile.BrowserName = strBrowser;
                                                objLoggedInProfile.Browserversion = strBrowserVersion;
                                                objLoggedInProfile.OS = OS;
                                                //objLoggedInProfile.ID = loggedIn.ModifiedBy;
                                                returnCode = gateWay.InsertLoggedInProfile(objLoggedInProfile);

                                                //Session.Add("DeptID", -1);
                                                //Convert.ToInt64(Session["LID"]), Session.SessionID
                                                //returnCode = gateWay.UpdateLoggedInUser(Session.SessionID, Convert.ToInt64(Session["LID"]), Convert.ToInt64(Session["RoleID"]), -1);

                                                Session.Add("CountryID", lstLocation[0].CountryID);
                                                Session.Add("StateID", lstLocation[0].StateID);
                                                Session.Add("TimeZone", lstLocation[0].TimeZone);
                                                Session.Add("TimeDifference", lstLocation[0].TimeDifference);
                                                Session.Add("DateFormat", lstLocation[0].DateFormat ?? "dd/MM/yyyy");
                                                Session.Add("TimeFormat", lstLocation[0].TimeFormat ?? "hh:mm:ss tt");
                                                Session.Add("DateTimeFormat", (lstLocation[0].DateFormat ?? "") + " " + (lstLocation[0].TimeFormat ?? ""));
                                                //Regex r = new Regex(@"[~`!@#$%^&*()+=|\\{}':;.,<>/?[\]""_-]");
                                                Match separator = Regex.Match(Convert.ToString(Session["DateFormat"]), @"[~`!@#$%^&*()+=|\\{}':;.,<>/?[\]""_-]");
                                                string MonthPattern = (lstLocation[0].DateFormat ?? "dd/MM/yyyy").Replace("dd", "d").Replace("d" + separator, "").Replace(separator + "d", "");
                                                string YearPattern = ((MonthPattern.Contains("MMM") == true) ? MonthPattern.Replace("MMM", "M") : MonthPattern.Replace("MM", "M")).Replace("M" + separator, "").Replace(separator + "M", "");
                                                Session.Add("MonthFormat", MonthPattern);
                                                Session.Add("YearFormat", YearPattern);

                                                new  Attune.Solution.BusinessComponent.GateWay().GetOrganizationDBMapping(userRoles[0].OrgID);

                                                List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
                                                returnCode = new TrustedOrg().GetTrustedOrgList((int)lstLocation[0].AddressID, userRoles[0].RoleID, "", out lstTOD);
                                                if (lstTOD!=null &&  lstTOD.Count > 0)
                                                {
                                                    Session.Add("IsTrustedOrg", "Y");
                                                }
                                                else
                                                {
                                                    Session.Add("IsTrustedOrg", "N");
                                                }
                                                // Pharmacy Location ID
                                                Session.Add("InventoryLocationID", "-1");

                                                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
                                                returnCode = gateWay.GetLocationUserMap(loggedIn.LoginID, userRoles[0].OrgID, (int)lstLocation[0].AddressID, out lstLocationUserMap);
                                                if (lstLocationUserMap !=null && lstLocationUserMap.Count > 0)
                                                {
                                                    if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                                                    {
                                                        Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                                                        Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                                                        Session.Add("InventoryLocationType", lstLocationUserMap.Find(p => p.IsDefault == "Y").LocationTypeID);
                                                    }
                                                    else
                                                    {
                                                        Session.Add("InventoryLocationID", lstLocationUserMap.FirstOrDefault().LocationID);
                                                        Session.Add("DepartmentName", lstLocationUserMap.FirstOrDefault().LocationName);
                                                        Session.Add("InventoryLocationType", lstLocationUserMap.FirstOrDefault().LocationTypeID);
                                                    }
                                                }
                                                else
                                                {
                                                    if (RoleHelper.Inventory != userRoles[0].RoleName)
                                                    {
                                                        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                                                        returnCode = new Attune.Kernel.PlatForm.BL.Configuration_BL(new ContextDetails()).GetInventoryConfigDetails("InventoryLocation", userRoles[0].OrgID, Convert.ToInt32(userRoles[0].OrgAddressID), out lstInventoryConfig);
                                                        if (lstInventoryConfig.Count > 0)
                                                        {
                                                            Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                                                        }
                                                    }
                                                }


                                            }
                                            else
                                            {
                                                if (sUserMessage_2 == null)
                                                {
                                                    sUserMessage_2 = "No roles associated with this User. Contact system administrator.";
                                                }
                                                string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                                if (ErrorMsg == null)
                                                {
                                                    ErrorMsg = "Error";
                                                }
                                                CLogger.LogWarning("No roles associated with the user.UserName:" + txtUserName + "UserID");
                                                // lblStatus.Text = "No roles associated with the user.Please contact system administrator";
                                                //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_2").ToString();
                                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + sUserMessage_2 + "','" + ErrorMsg + "');", true);
                                                // sUserMessage = "Home.aspx_2";
                                                // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                                returnCode = -1;
                                            }
                                        }
                                        else
                                        {

                                            long RtrnCode = -1;
                                            gateWay = new GateWay();
                                            string LogInAttempt = string.Empty;
                                            string noOfOrgAttmpts = string.Empty;
                                            string OrgHit = string.Empty;
                                            RtrnCode = gateWay.GetLoginAttemptFailureDetail(txtUserName.Text, out LogInAttempt, out OrgHit);
                                            if (OrgHit != "")
                                            {
                                                int RemaingHit = -1;
                                                RemaingHit = Convert.ToInt32(OrgHit) - Convert.ToInt32(LogInAttempt);
                                                if (RemaingHit > 0)
                                                {
                                                    if (sUserMessage_3 == null)
                                                    {
                                                        sUserMessage_3 = "more login attempts remaining";
                                                    }
                                                    string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                                    if (ErrorMsg == null)
                                                    {
                                                        ErrorMsg = "Error";
                                                    }

                                                    CLogger.LogWarning("Login userroles returncode=" + returnCode.ToString() + "UserName:" + txtUserName.Text + "UserID");
                                                    // lblStatus.Text = RemaingHit + "  more login attempts remains...";

                                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_3").ToString();
                                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_003", "javascript:ValidationWindow('" + RemaingHit.ToString() + sUserMessage_3 + "','" + ErrorMsg + "');", true);
                                                    //sUserMessage = "Home.aspx_3";
                                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                                }
                                                if (RemaingHit == 0)
                                                {
                                                    if (sUserMessage_4 == null)
                                                    {
                                                        sUserMessage_4 = "Exceeded the Maximum no. of Login attempts. Contact Administrator.";
                                                    }
                                                    string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                                    if (ErrorMsg == null)
                                                    {
                                                        ErrorMsg = "Error";
                                                    }
                                                    CLogger.LogWarning("Login userroles returncode=" + returnCode.ToString() + "UserName:" + txtUserName.Text + "UserID");
                                                    // lblStatus.Text = "The account you tried to login into, is now locked due to excessive failed login attempts. Please Contact Administrator..";
                                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_4").ToString();
                                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_004", "javascript:ValidationWindow('" + sUserMessage_4 + "','" + ErrorMsg + "');", true);
                                                    // sUserMessage = "Home.aspx_4";
                                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);

                                                }
                                            }
                                            else
                                            {
                                                if (sUserMessage_5 == null)
                                                {
                                                    sUserMessage_5 = "Invalid Username or Password";
                                                }
                                                string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                                if (ErrorMsg == null)
                                                {
                                                    ErrorMsg = "Error";
                                                }
                                                CLogger.LogWarning("Invalid Username/Password." + txtUserName.Text);
                                                // lblStatus.Text = "Invalid Username or Password";
                                                // sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + sUserMessage_5 + "','" + ErrorMsg + "');", true);
                                                //sUserMessage = "Home.aspx_5";
                                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                            }


                                        }
                                        if (userRoles.Count == 1)
                                        {
                                            if ((userRoles[0].RoleName == "Client" || userRoles[0].RoleName == "Remote Registration") && Session["UserName"] == "")
                                            {
                                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_100", "javascript:ValidationWindow('Login details are not mapped properly. Please contact support team','Login') return false;", true);

                                            }
                                            else
                                            {
                                           Navigation navigation = new Navigation();
                                            returnCode = navigation.GetLandingPage(userRoles[0].RoleID, out relPagePath);
                                            if (returnCode == 0)
                                            {
                                                // Attune_Helper.PageRedirect(this, Attune_Helper.GetAppName() + relPagePath);
                                                Response.Redirect(Request.ApplicationPath + relPagePath, true);
                                                //string strRedirectURL = ConfigurationManager.AppSettings["ApplicationName"] + relPagePath + "?IsPopup=Y";
                                                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Redirect", "Redirect('" + strRedirectURL + "');", true);
                                                // Response.Redirect("SelectRole.aspx", false);
                                                //imgGo.Enabled = false;
                                                //imgGo.Visible = false;
                                                }
                                            }
                                        }

                                    }
                                    else
                                    {
                                        if (sUserMessage_5 == null)
                                        {
                                            sUserMessage_5 = "Invalid Username or Password";
                                        }
                                        string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                        if (ErrorMsg == null)
                                        {
                                            ErrorMsg = "Error";
                                        }
                                        CLogger.LogWarning("Invalid Username/Password." + txtUserName.Text);
                                        //lblStatus.Text = "Invalid Username or Password";
                                        //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + sUserMessage_5 + "','" + ErrorMsg + "');", true);
                                        //sUserMessage = "Home.aspx_5";
                                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                    }
                                }
                                else
                                {
                                    if (sUserMessage_6 == null)
                                    {
                                        sUserMessage_6 = "UserName is Locked.  Contact Administrator..";
                                    }
                                    string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                    if (ErrorMsg == null)
                                    {
                                        ErrorMsg = "Error";
                                    }
                                    CLogger.LogWarning("UserName is locked.Please contact administrator.." + txtUserName.Text);
                                    // lblStatus.Text = "UserName is Locked. Please Contact Administrator..";
                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_6").ToString();
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_006", "javascript:ValidationWindow('" + sUserMessage_6 + "','" + ErrorMsg + "');", true);
                                    //sUserMessage = "Home.aspx_6";
                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                }
                            }

                            else
                            {
                                if (sUserMessage_5 == null)
                                {
                                    sUserMessage_5 = "Invalid Username or Password";
                                }
                                string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                                if (ErrorMsg == null)
                                {
                                    ErrorMsg = "Error";
                                }
                                CLogger.LogWarning("Invalid Username/Password." + txtUserName.Text);
                                // lblStatus.Text = "Invalid Username or Password";
                                //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + sUserMessage_5 + "','" + ErrorMsg + "');", true);
                                //sUserMessage = "Home.aspx_5";
                                // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                            }
                        }

                        else
                        {
                            string sPath = Resources.Home_AppMsg._Home_aspx_08;
                            sPath = string.Format(sPath, BlockedTo);
                            if (string.IsNullOrEmpty(sPath))//if (sPath == null) 
                            {
                                sPath = "Your login is blocked up to " + BlockedTo;
                            }
                            string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                            if (ErrorMsg == null)
                            {
                                ErrorMsg = "Error";
                            }
                            CLogger.LogWarning("User Has Been Blocked." + txtUserName.Text);
                            // lblStatus.Text = "Invalid Username or Password";
                            //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                            // sUserMessage = "Home.aspx_5";
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);


                        }
                    }
                    else
                    {
                        CLogger.LogWarning("User Has Been Blocked." + txtUserName.Text);
                        // lblStatus.Text = "Invalid Username or Password";
                        //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                        //string Message= "Your login is blocked.Please contact administrator";
                        string ResMessage = Resources.Home_AppMsg._Home_aspx_09;
                        if (string.IsNullOrEmpty(ResMessage))
                        {
                            ResMessage = "Your login has expired. Contact administrator";
                        }
                        string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                        if (ErrorMsg == null)
                        {
                            ErrorMsg = "Error";
                        }
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + ResMessage + "','" + ErrorMsg + "');", true);
                        //sUserMessage = "Home.aspx_5";
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);

                    }
                }
                else
                {
                    CLogger.LogWarning("User Validity Date Expired." + txtUserName.Text);
                    // lblStatus.Text = "Invalid Username or Password";
                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                    //string Message= "Your login is expired.please contact administrator";
                    string ResMessage = Resources.Home_AppMsg._Home_aspx_09;
                    if (string.IsNullOrEmpty(ResMessage))
                    {
                        ResMessage = "Your login has expired. Contact administrator";
                    }
                    string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + ResMessage + "','" + ErrorMsg + "');", true);
                    //sUserMessage = "Home.aspx_5";
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                }
            }
            else
            {
                if (sUserMessage_5 == null)
                {
                    sUserMessage_5 = "Invalid Username or Password";
                }
                string ErrorMsg = Resources.Home_AppMsg._Home_aspx_07;
                if (ErrorMsg == null)
                {
                    ErrorMsg = "Error";
                }
                CLogger.LogWarning("Invalid Username/Password." + txtUserName.Text);
                // lblStatus.Text = "Invalid Username or Password";

                // sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:ValidationWindow('" + sUserMessage_5 + "','" + ErrorMsg + "');", true);
                //sUserMessage = "Home.aspx_5";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
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

        //TODO: Authorization
    }

    protected void SetLanguage(object sender, EventArgs e)
    {
        //Sets the cookie that is to be used by Global.asax
        HttpCookie cookie = new HttpCookie("CultureInfo");
        cookie.Value = ddLang.SelectedValue;
        Response.Cookies.Add(cookie);
        //Set the culture and reload the page for immediate effect. 
        //Future effects are handled by Global.asax
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(ddLang.SelectedValue);
        string _LogoRedirectPath = "";
        HttpCookie Logocookie = Request.Cookies["LoginLogo"];
        if (!string.IsNullOrEmpty(Logocookie.Value))
        {
            _LogoRedirectPath = Logocookie.Value;
            //Response.Cookies.Add(new HttpCookie("LoginLogo", ""));
            //Response.Redirect(Request.ApplicationPath + "/Home.aspx?LoginPageLogo=" + _LogoRedirectPath, true);
            Response.Redirect(Request.Path + "?LoginPageLogo=" + _LogoRedirectPath);
        }
        else
        {
            Response.Redirect(Request.Path);
        }
        //Response.Redirect(Request.Path);
    }

}
