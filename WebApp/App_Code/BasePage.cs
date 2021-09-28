using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.AccessControl;
using System.Security.Permissions;
using System.Security.Principal;
using System.Web.UI;
using System.Web.SessionState;
using System.Configuration;
using Attune.Podium.Common;
using System.Web.Caching;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Threading;
using System.Web.UI.WebControls;
using System.Text;
using System.Xml;
using System.IO;
using System.IO.Compression;


using Attune.Kernel.PlatForm.Utility;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    string masterPageFile = string.Empty;
    string styleSheetTheme = string.Empty;
    string theme = string.Empty;
    int orgID = 0;
    int roleID = 0;
    int iLocationID = 0;
    int inventoryLocationID = 0;
    long uID = 0;
    long cID = 0;
    string userName = string.Empty;
    int iUserID = 0;
    string name = string.Empty;
    string errorPage = string.Empty;
    string orgName = string.Empty;
    string currencyName = string.Empty;
    //int themeid = 0;
    GateWay gateWay = null;
    bool IsLoggedIn = false;
    string age = String.Empty;
    string bloodGroup = String.Empty;
    string isivalue = string.Empty;
    string roleName = string.Empty;
    string ActionCode = string.Empty;
    string SearchType = string.Empty;
    string isSplAuthorize = string.Empty;
    public string IsFirstLogin { get; set; }
    public string languageCode = string.Empty;

    Int64 pageID = 0;
    long lID = 0;
    Hashtable queryString = new Hashtable();
    Navigation navigator = new Navigation();
    PageContextkey pageContextDetails = new PageContextkey();
    ContextDetails contextInfo = new ContextDetails();
    string logoPath = String.Empty;
    string isTrustedOrg = string.Empty;
    string uploadPath = string.Empty;
    string currencyFormat = string.Empty;
    string isAmountEditable = string.Empty;
    string departmentName = string.Empty;
    string integrationName = string.Empty;
    public int ThemeID { get; set; }
    public string LocationName { get; set; }
    public string _LoginName = string.Empty;
    private string minorCurrencyName = string.Empty;
    public string isCorporateOrg = string.Empty;
    public string isCorporateOrgPaymenttype = string.Empty;
    public string HideIPManageRate { get; set; }
    private int countryID = 0;
    private int stateID = 0;
    private string orgTimeZone = string.Empty;
    private string orgDateTimeZone = string.Empty;
    //private string timeDifferenceShort = string.Empty;
    string roleDescription;
    long patientID = 0;
    // Below two variables is for handling localized user or error messages read from Resource file
    public string CompletePageName = string.Empty;
    public StringBuilder UserMessages = new StringBuilder();
    private string datetimeFormat = string.Empty;

    #region "Property Declared by 02-Feb-2016 Added By Venkatesh S"
    
    public StringBuilder ClientDisplay = new StringBuilder();
    public const string TEXTBOX = "TextBox";
    public const string LABEL = "Label";

    #endregion

    public BasePage()
    {

    }
    #region Overloaded constructor
    /// <summary>
    /// Base constructor - Gets called during each page's initialization. Depending on the page name (through the parameter), 
    /// the appropriate set of keys applicable for this page alone are passed to the Resource file and the values are 
    /// stored in UserMessages variable. 
    /// The values will be in the form of Key=Value^Key=Value. The Page_Init method will create a client side script and push this value.
    /// </summary>
    /// <param name="sCompletePageName">For storing the name of the Page</param>
    public BasePage(string sCompletePageName)
    {

        //string ResFileName = "~";
        //CompletePageName = sCompletePageName;
        //object oResourceOutput;
        //object oResourceOutput1;
        //if (!string.IsNullOrEmpty(sCompletePageName))
        //{

        //    string strLangCode = "";
        //    if (Thread.CurrentThread.CurrentUICulture.IetfLanguageTag != "en-GB")
        //    {
        //        strLangCode = "." + Thread.CurrentThread.CurrentUICulture.IetfLanguageTag;
        //    }
        //    string[] pageName = sCompletePageName.Split(new string[] { "_" }, StringSplitOptions.None);
        //    if (pageName.Length > 0)
        //    {
        //        if (!string.IsNullOrEmpty(pageName[0]))
        //        {

        //            string sUserMsgResourceFile = pageName[0] + "_AppMsg" + strLangCode + ".resx";
        //            string sClientDisplayText = pageName[0] + "_ClientDisplay" + strLangCode + ".resx";

        //            oResourceOutput = Attune_LocalResourceObject(sUserMsgResourceFile, sCompletePageName);
        //            if (oResourceOutput != null)
        //                UserMessages.Append(oResourceOutput.ToString());
        //            oResourceOutput1 = Attune_LocalResourceObject(sClientDisplayText, sCompletePageName);
        //            if (oResourceOutput1 != null)
        //                ClientDisplay.Append(oResourceOutput1.ToString());

        //        }
        //    }
            //oResourceOutput = "^" + Attune_LocalResourceObject("PlatForm_AppMsg" + strLangCode + ".resx", "_js");
            //if (oResourceOutput != null)
            //    UserMessages.Append(oResourceOutput.ToString());
            //oResourceOutput1 = "^" + Attune_LocalResourceObject("PlatForm_ClientDisplay" + strLangCode + ".resx", "_js");
            //if (oResourceOutput1 != null)
            //    ClientDisplay.Append(oResourceOutput1.ToString());
            //oResourceOutput = "^" + Attune_LocalResourceObject("InventoryCommon_AppMsg" + strLangCode + ".resx", "_js");
            //if (oResourceOutput != null)
            //   UserMessages.Append(oResourceOutput.ToString());
            //oResourceOutput1 = "^" + Attune_LocalResourceObject("InventoryCommon_ClientDisplay" + strLangCode + ".resx", "_js");
            //if (oResourceOutput1 != null)
            //  ClientDisplay.Append(oResourceOutput1.ToString());
        //    oResourceOutput = "^" + Attune_LocalResourceObject("Scripts_AppMsg" + strLangCode + ".resx", "_js");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("Scripts_ClientDisplay" + strLangCode + ".resx", "_js");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());
        //    oResourceOutput = "^" + Attune_LocalResourceObject("CommonControls_AppMsg" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("CommonControls_ClientDisplay" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());
        //    oResourceOutput = "^" + Attune_LocalResourceObject("Invoice_AppMsg" + strLangCode + ".resx", "_aspx");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("Invoice_ClientDisplay" + strLangCode + ".resx", "_aspx");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());

        //    oResourceOutput = "^" + Attune_LocalResourceObject("NewInstanceCreation_AppMsg" + strLangCode + ".resx", "_aspx");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("NewInstanceCreation_ClientDisplay" + strLangCode + ".resx", "_aspx");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());
        //    oResourceOutput = "^" + Attune_LocalResourceObject("EMR_AppMsg" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("EMR_ClientDisplay" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());
        //    oResourceOutput = "^" + Attune_LocalResourceObject("Investigation_AppMsg" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput != null)
        //        UserMessages.Append(oResourceOutput.ToString());
        //    oResourceOutput1 = "^" + Attune_LocalResourceObject("Investigation_ClientDisplay" + strLangCode + ".resx", "_ascx");
        //    if (oResourceOutput1 != null)
        //        ClientDisplay.Append(oResourceOutput1.ToString());


        //}

    }
    
    #endregion
    #region Page Init

    /// <summary>
    /// Creates a Javascript block and pushes it to the client side. "RegisterStartupScript" will push  
    /// it to the last part of the client side code i.e. after all the page Html & scripts are formed,   
    /// this will get appended. The UserMessages formed in the constructor gets assigned to the Hidden 
    /// variable (which must be already defined in the page). 
    /// The "SListForApplicationMessages" variable would be defined in the "MessageHandler.js" file (in 
    /// Scripts folder and included in each page). The call to SListForApplicationMessages.Load will  
    /// parse the Key=Value^ collection and form it as an Array. In the individual pages (client side), 
    /// this Array will be available (containing only the Key, value pair required for that page). 
    /// Whenever it is required to display the message (in the client side), the Get method should be 
    /// called by passing the key.

    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void page_Init(object sender, EventArgs e)
    {
        /* Code Added */
        #region "Code Added Date : 02-02-2016"
        
        //Page.RegisterHiddenField("hdnSListClientDisplay", "");
        //Page.RegisterHiddenField("hdnSListUserMsg", "");
        
        this.Load += new EventHandler(Page_Load);
        //this.LoadComplete += new EventHandler(BasePage_LoadComplete);
       
        //if (CompletePageName != string.Empty)
        //{
        //    StringBuilder sContent = new StringBuilder();
        //    UserMessages = UserMessages.Replace("\r", "").Replace("\n", "").Replace("'", "&quot;");
        //    if (!string.IsNullOrEmpty(ClientDisplay.ToString()))
        //    {
        //        sContent.Append("document.getElementById('hdnSListClientDisplay').value=document.getElementById('hdnSListClientDisplay').value+'^'+'" + ClientDisplay.ToString().Replace("\r", "").Replace("\n", "").Replace("'", "&quot;") + "';");
        //        sContent.Append("SListForAppDisplay = new SortedList();");
        //        sContent.Append("SListForAppDisplay.Load(document.getElementById('hdnSListClientDisplay').value);");
        //    }
        //    if (!string.IsNullOrEmpty(UserMessages.ToString()))
        //    {
        //        sContent.Append("document.getElementById('hdnSListUserMsg').value=document.getElementById('hdnSListUserMsg').value+'^'+'" + UserMessages.ToString().Replace("\r", "").Replace("\n", "").Replace("'", "&quot;") + "';");
        //        sContent.Append("SListForAppMsg = new SortedList();");
        //        sContent.Append("SListForAppMsg.Load(document.getElementById('hdnSListUserMsg').value);");
        //    }

        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", sContent.ToString(), true);
        //}

        #endregion

        //if (CompletePageName != string.Empty && UserMessages.ToString() != string.Empty)
        //{
        //    StringBuilder sContent = new StringBuilder();
        //    UserMessages = UserMessages.Replace("\r", "").Replace("\n", "");
        //    sContent.Append("<script type='text/javascript'>");
        //    sContent.Append("document.getElementById('hdnMessages').value = '" + UserMessages + "';");
        //    sContent.Append("SListForApplicationMessages = new SortedList();");
        //    sContent.Append("SListForApplicationMessages.Load(document.getElementById('hdnMessages').value);");
        //    sContent.Append("</script>");
        //    Page.RegisterStartupScript("UserMessage", sContent.ToString());
        //}
    }

    #endregion

    public void AddQuerySrting(string name, string value)
    {
        queryString.Add(name, value);
    }

    public void NavigateTo(string actionName)
    {
        string relativePath = string.Empty;
        relativePath = navigator.GetURIPath(actionName, OrgID, queryString);
        Response.Redirect(Request.ApplicationPath  + relativePath);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region Encription
            StringBuilder Sb = new StringBuilder();
            //Sb.Append("window.sessionStorage['loginGuid']=Base64.encode('" + Convert.ToString(Session["loginGuid"]) + "');");
            Sb.Append("window.sessionStorage['LoggedInApp']=Base64.encode('" + Convert.ToString(Session["LoggedInApp"]) + "');");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "localLoginid", Sb.ToString(), true);
            #endregion
        }
    }


    #region OnInitComplete
    protected override void OnInitComplete(EventArgs e)
    {
        base.OnInitComplete(e);
        this.errorPage = Request.ApplicationPath  + "/Error.aspx";
        gateWay = new GateWay(contextInfo);
        if (Request.QueryString["IsPopup"] == null)
        {
            if (Request.ServerVariables["HTTP_REFERER"] == null)
            {
                //Response.Redirect(Request.ApplicationPath  + "/Home.aspx");
                LogOut();
            }
        }

        if (Request.QueryString["ACode"] != null && Request.QueryString["SearchType"] != null && (Session["RoleID"]) != null)
        {
            GateWay BAL = new GateWay();
            long ReturnCode = -1;

            ActionCode = Request.QueryString["ACode"];
            SearchType = Request.QueryString["SearchType"];
            Int32.TryParse(Session["RoleID"].ToString(), out roleID);
            RoleID = roleID;

            string PATH = HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath;
            string QUERY = HttpContext.Current.Request.Url.Query.Replace("&ACode=" + Request.QueryString["ACode"], "").Replace("&", "^");

            ReturnCode = gateWay.GetActioncodeforSplAuthorise(RoleID, ActionCode, SearchType, out isSplAuthorize);

            if (isSplAuthorize.Length > 0 && isSplAuthorize != "" && isSplAuthorize != "N")
            {
                if (isSplAuthorize == "Y")
                {

                    Response.Redirect("../ChangePassword/ChangePassword.aspx?URL='" + PATH + QUERY + "'", true);
                }
            }
        }

        if ((Session["OrgID"]) != null)
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            OrgID = orgID;
            pageContextDetails.OrgID = orgID;
            contextInfo.OrgID = orgID;
        }
        else
        {
            LogOut();
            //Response.Redirect(Request.ApplicationPath  + "/Home.aspx");
        }
        if ((Session["OrgTimeZone"]) != null)
        {
            orgTimeZone = Session["OrgTimeZone"].ToString();
            pageContextDetails.OrgTimeZone = orgTimeZone;
            contextInfo.OrgTimeZone = orgTimeZone;
        }
        //if ((Session["TimeDifferenceShort"]) != null)
        //{
        //    TimeDifferenceShort = Session["TimeDifferenceShort"].ToString();
        //    pageContextDetails.TimeDifferenceShort = TimeDifferenceShort;
        //    contextInfo.TimeDifferenceShort = TimeDifferenceShort;
        //}
        if ((Session["RoleID"]) != null)
        {
            Int32.TryParse(Session["RoleID"].ToString(), out roleID);
            RoleID = roleID;
            pageContextDetails.RoleID = roleID;
            contextInfo.RoleID = roleID;
        }
        else
        {
            LogOut();
            //Response.Redirect(Request.ApplicationPath  + "/Home.aspx");
        }
        if (Session["IsFirstLogin"] != null)
        {
            IsFirstLogin = Session["IsFirstLogin"].ToString();
        }

        if (Session["UID"] != null)
        {
            Int64.TryParse(Session["UID"].ToString(), out uID);

        }
        /*Added by Sathish.E for Client Portal-- [CID = ClientID]*/
        if (Session["CID"] != null)
        {
            Int64.TryParse(Session["CID"].ToString(), out cID);
            

        }
        if ((Session["UserName"]) != null)
        {
            userName = Session["UserName"].ToString();
            contextInfo.Name = userName;
        }
        if (Session["UserID"] != null)
        {
            Int32.TryParse(Session["UserID"].ToString(), out iUserID);
            ContextInfo.UserID = iUserID;
        }

        if ((Session["Name"]) != null)
        {
            name = Session["Name"].ToString();
            contextInfo.Name = Name;

        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=3");
        //}

        if ((Session["OrgName"]) != null)
        {
            orgName = Session["OrgName"].ToString();
            contextInfo.OrgName = orgName;

        }

        if (Convert.ToString(Session["LogoPath"]) != String.Empty)
        {
            logoPath = Session["LogoPath"].ToString();
            LogoPath = logoPath;
        }
        else
        {
            LogoPath = "../Images/Logo/defaultlogo1.png";
        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=3");
        //}

        if ((Session["RoleDescription"]) != null)
        {
            RoleDescription = Session["RoleDescription"].ToString();
        }

        if ((Session["RoleName"]) != null)
        {
            RoleName = Session["RoleName"].ToString();
            contextInfo.RoleName = RoleName;
        }
        if ((Session["Age"]) != null)
        {
            Age = Session["Age"].ToString();
        }
        if ((Session["BloodGroup"]) != null)
        {
            BloodGroup = Session["BloodGroup"].ToString();
        }
        if ((Session["RoleName"]) != null)
        {
            RoleName = Session["RoleName"].ToString();
        }


        if ((Session["LID"]) != null)
        {

            Int64.TryParse(Session["LID"].ToString(), out lID);
            gateWay.IsUserLoggedIn(lID, Session.SessionID, out IsLoggedIn);
            if (!IsLoggedIn)
                LogOut();
                //Response.Redirect(Request.ApplicationPath  + "/Home.aspx");
            LID = lID;
            contextInfo.LoginID = lID;
            gateWay.GetOrganizationDBMapping(OrgID);

        }

        if ((Session["LocationID"]) != null)
        {
            Int32.TryParse(Session["LocationID"].ToString(), out iLocationID);
            contextInfo.LocationID = iLocationID;
        }
        if ((Session["OrgCurrency"]) != null)
        {
            currencyName = Session["OrgCurrency"].ToString();

        }

        if ((Session["IsTrustedOrg"]) != null)
        {
            IsTrustedOrg = Session["IsTrustedOrg"].ToString();
        }


        if ((Session["UploadPath"]) != null)
        {
            Uploadpath = Session["UploadPath"].ToString();
        }
        if ((Session["InventoryLocationID"]) != null)
        {
            Int32.TryParse(Session["InventoryLocationID"].ToString(), out inventoryLocationID);
            contextInfo.InventoryLocationID = inventoryLocationID;
        }

        if ((Session["OrgCurrencyFormat"]) != null)
        {
            CurrencyFormat = Session["OrgCurrencyFormat"].ToString();
        }
        else
        {
            CurrencyFormat = ",";
        }
        if ((Session["IsAmountEditable"]) != null)
        {
            IsAmountEditable = Session["IsAmountEditable"].ToString();
        }
        if ((Session["DepartmentName"]) != null)
        {
            DepartmentName = Session["DepartmentName"].ToString();
        }
        else
        {
            DepartmentName = "-";
        }

        if ((Session["ThemeID"]) != null)
        {
            ThemeID = Convert.ToInt32((Session["ThemeID"].ToString()));
            contextInfo.ThemeID = ThemeID;
        }

        if ((Session["LocationName"]) != null)
        {
            LocationName = Session["LocationName"].ToString();
        }


        if ((Session["IntegrationName"]) != null)
        {
            IntegrationName = Session["IntegrationName"].ToString();

        }
        if ((Session["LoginName"] != null))
        {
            LoginName = Session["LoginName"].ToString();

        }

        if ((Session["IsCorporateOrg"] != null))
        {
            IsCorporateOrg = Session["IsCorporateOrg"].ToString();

        }
        if ((Session["HideIPManageRate"] != null))
        {
            HideIPManageRate = Session["HideIPManageRate"].ToString();
        }

        if ((Session["IsCorporateOrgPaymenttype"] != null))
        {
            IsCorporateOrgPaymenttype = Session["IsCorporateOrgPaymenttype"].ToString();

        }
        if ((Session["CountryID"]) != null)
        {
            countryID = Convert.ToInt32(Session["CountryID"].ToString());
            contextInfo.CountryID = countryID;
            //Session.Remove("CountryID");
        }
        if ((Session["StateID"]) != null)
        {
            stateID = Convert.ToInt32(Session["StateID"].ToString());
            contextInfo.StateID = stateID;
            //Session.Remove("StateID");
        }
        if ((Session["LanguageCode"]) != null)
        {
            contextInfo.LanguageCode = Session["LanguageCode"].ToString();
            LanguageCode = Session["LanguageCode"].ToString();
        }

        if (Session["PatientID"] != null)
        {
            Int64.TryParse(Session["PatientID"].ToString(), out patientID);

        }

        MinorCurrencyName = Session["MinorCurrency"] != null ? Session["MinorCurrency"].ToString() : string.Empty;

        gateWay.GetPageDetails(HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.Replace("~", ""), out pageID);
        pageContextDetails.PageID = pageID;
        ContextInfo.PageID = pageID;
        ContextInfo.SessionID = Session.SessionID;
        //Alacarte objMenuItem = null;
        //new Attune.Kernel.PlatForm.BL.Master_BL().GetPageDetails(HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.Replace("~", ""), LanguageCode, out objMenuItem);
        //if (objMenuItem != null)
        //{
        //    pageContextDetails.PageID = objMenuItem.PageID;
        //    ContextInfo.PageID = objMenuItem.PageID;
        //}
        //else
        //{
        //    pageContextDetails.PageID = 0;
        //    ContextInfo.PageID = 0;

        //}
        ContextInfo.SessionID = Session.SessionID;
    }
    #endregion

    #region Properties
    public int InventoryLocationID
    {
        get { return inventoryLocationID; }
        set { inventoryLocationID = value; }
    }
    public string DepartmentName
    {
        get { return departmentName; }
        set { departmentName = value; }
    }
    public string Age
    {
        get { return age; }
        set { age = value; }
    }
    public string BloodGroup
    {
        get { return bloodGroup; }
        set { bloodGroup = value; }
    }

    public int IUserID
    {
        get
        {
            return iUserID;
        }
        set
        {
            iUserID = value;
        }
    }

    public int ILocationID
    {
        get { return iLocationID; }
        set { iLocationID = value; }
    }


    public int OrgID
    {
        get
        {
            return orgID;
        }
        set
        {
            orgID = value;
        }
    }

    public string OrgTimeZone
    {
        get
        {
            if (Session["OrgTimeZone"] != null)
            {
                string timeZone = Session["OrgTimeZone"].ToString();
                orgTimeZone = (TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById(timeZone))).ToString("dd/MM/yyyy");
            }
            else
            {
                orgTimeZone = DateTime.Now.ToString("dd/MM/yyyy");
            }

            return orgTimeZone;
        }
        set
        {
        }
    }
    public string OrgDateTimeZone
    {
        get
        {
            if (Session["OrgTimeZone"] != null)
            {
                string timeZone = Session["OrgTimeZone"].ToString();
                orgDateTimeZone = (TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById(timeZone))).ToString("dd-MM-yyyy hh:mm:sstt");
            }
            else
            {
                orgDateTimeZone = DateTime.Now.ToString("dd-MM-yyyy hh:mm:sstt");
            }

            return orgDateTimeZone;
        }
        set
        {
        }
    }
    public string RoleName
    {
        get { return roleName; }
        set { roleName = value; }
    }
    public int RoleID
    {
        get
        {
            return roleID;
        }
        set
        {

            roleID = value;
        }
    }

    public long UID
    {
        get
        {
            return uID;
        }
        set
        {
            uID = value;
        }
    }
    /*Added by Sathish.E for Client Portal-- [CID = ClientID]*/
    public long CID
    {
        get
        {
            return cID;
        }
        set
        {
            cID = value;
        }
    }
    public string UserName
    {
        get { return userName; }
        set { userName = value; }
    }

    public string Name
    {
        get
        {
            return name;
        }
        set
        {
            name = value;
        }
    }

    public string LogoPath
    {
        get { return logoPath; }
        set { logoPath = value; }
    }

    public string ISIValue
    {
        get { return isivalue; }
        set { isivalue = value; }

    }


    public string OrgName
    {
        get { return orgName; }
        set { orgName = value; }
    }

    public override string MasterPageFile
    {
        get { return masterPageFile; }
        set { masterPageFile = value; }
    }

    public override string StyleSheetTheme
    {
        get { return styleSheetTheme; }
        set { styleSheetTheme = value; }
    }

    public override string Theme
    {
        get { return theme; }
        set { theme = value; }
    }

    public long LID
    {
        get { return lID; }
        set { lID = value; }
    }
    #endregion

    public virtual void LogOut()
    {
        try
        {
            Session.Abandon();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now - new TimeSpan(1, 0, 0));
            Response.Cache.SetLastModified(DateTime.Now);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            string _LogoRedirectPath = "";
            HttpCookie cookie = Request.Cookies["LoginLogo"];
            if (cookie != null)
            {
                if (!string.IsNullOrEmpty(cookie.Value))
                {
                    _LogoRedirectPath = cookie.Value;
                    Response.Cookies.Add(new HttpCookie("LoginLogo", ""));
                    Response.Redirect(Request.ApplicationPath + "/Home.aspx?LoginPageLogo=" + _LogoRedirectPath, true);
                }
                else
                {
                    Response.Redirect(Request.ApplicationPath + "/Home.aspx", true);
                }
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + "/Home.aspx", true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    public DateTime GetDate()
    {
        return DateTime.Now;
    }
    #region Properties
    public string CurrencyName
    {
        get { return currencyName; }
        set { currencyName = value; }
    }
    public string IsTrustedOrg
    {
        get { return isTrustedOrg; }
        set { isTrustedOrg = value; }
    }

    public string Uploadpath
    {
        get { return uploadPath; }
        set { uploadPath = value; }
    }
    public string CurrencyFormat
    {
        get { return currencyFormat; }
        set { currencyFormat = value; }
    }
    public string IsAmountEditable
    {
        get { return isAmountEditable; }
        set { isAmountEditable = value; }
    }
    public string IntegrationName
    {
        get { return integrationName; }
        set { integrationName = value; }
    }
    public string LoginName
    {
        get { return _LoginName; }
        set { _LoginName = value; }
    }
    public string MinorCurrencyName
    {
        get { return minorCurrencyName; }
        set { minorCurrencyName = value; }
    }

    public string IsCorporateOrg
    {
        get { return isCorporateOrg; }
        set { isCorporateOrg = value; }
    }

    public string IsCorporateOrgPaymenttype
    {
        get { return isCorporateOrgPaymenttype; }
        set { isCorporateOrgPaymenttype = value; }
    }
    public string LanguageCode
    {
        get { return languageCode; }
        set { languageCode = value; }
    }
    public int CountryID
    {
        get { return countryID; }
        set { countryID = value; }
    }
    public int StateID
    {
        get { return stateID; }
        set { stateID = value; }
    }
    public PageContextkey PageContextDetails
    {
        get { return pageContextDetails; }
        set { pageContextDetails = value; }
    }
    public Int64 PageID
    {
        get { return pageID; }
        set { pageID = value; }
    }
    public ContextDetails ContextInfo
    {
        get { return contextInfo; }
        set { contextInfo = value; }
    }
    public string RoleDescription
    {
        get { return roleDescription; }
        set { roleDescription = value; }
    }
    #endregion

    #region Read the XML for Page - Controls association to get the user messages for the controls used inside the pages
    /// <summary>
    /// Loop through the XML and find out if a particular page has any controls associated (which has user messages)
    /// Collect all such and return it as a string
    /// </summary>
    /// <param name="sCompletePageName"></param>
    /// <returns></returns>
    public string ReadXmlFile(string sCompletePageName)
    {
        bool bPageFound = false;
        string sControlsUsed = string.Empty;
        string fileName = Server.MapPath("~\\App_Data\\Page_Controls_Mapping_For_UserMessages.xml");
        XmlTextReader xReader = new XmlTextReader(fileName);
        while (xReader.Read())
        {
            if (xReader.NodeType == XmlNodeType.Element && xReader.Name == sCompletePageName)
            {
                bPageFound = true;
            }
            else if (xReader.NodeType == XmlNodeType.Element)
            {
                if (bPageFound)
                {
                    sControlsUsed += xReader.Name;
                    sControlsUsed += "\\";
                }
            }
            else if (xReader.NodeType == XmlNodeType.Text)
            {
                if (bPageFound)
                {
                    sControlsUsed += xReader.Value;
                    sControlsUsed += "~";
                }
            }
            else if (xReader.NodeType == XmlNodeType.EndElement && xReader.Name == sCompletePageName)
            {
                if (bPageFound)
                {
                    bPageFound = false;
                    break;
                }
            }
        }
        bPageFound = false;
        xReader.Close();
        return sControlsUsed;
    }
    #endregion

    /// <summary>
    /// Wrapper method for GetGlobalResourceObject call - to handle the exception of missing entry 
    /// in resource file
    /// </summary>
    /// <param name="sResourceFile"></param>
    /// <param name="sKey"></param>
    /// <returns></returns>
    public object Attune_GetGlobalResourceObject(string sResourceFile, string sKey)
    {
        try
        {
            return HttpContext.GetGlobalResourceObject(sResourceFile, sKey);
        }
        catch (System.Resources.MissingManifestResourceException)
        {
            return null;
        }
    }




    
    #region Added for Newworklist
    public string DateTimeFormat
    {
        get
        {

            datetimeFormat = GetConfigValue("FormatDateTime", OrgID);
            if (datetimeFormat == "" || datetimeFormat == null)
            {
                datetimeFormat = "dd/MM/yyyy HH:mm";
            }
            return datetimeFormat;
        }
        set
        {

        }

    }
    public string GetConfigValue(string configKey, int OrgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, OrgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    #endregion

    #region "Code Added By Venkatesh S"

    /// <summary>
    /// Wrapper method for GetGlobalResourceObject call - to handle the exception of missing entry 
    /// in resource file
    /// </summary>
    /// <param name="sResourceFile"></param>
    /// <param name="sKey"></param>
    /// <returns></returns>
    public object Attune_LocalResourceObject(string sResourceFile, string sKey)
    {
        string resourceValues = "";
        try
        {
            //return HttpContext.GetLocalResourceObject(sResourceFile, sKey);
            //return HttpContext.GetGlobalResourceObject(sResourceFile, sKey);
            List<MetaData> lstMetaData = Attune.Podium.Common.ResourceHelper.GetResourceByFileName(sResourceFile);
            
            foreach (MetaData entry in lstMetaData)
            {
                if (entry.Code.Contains(sKey) || entry.Code.Contains("_js") || entry.Code.Contains("_Cancel") || entry.Code.Contains("_Error")
                 || entry.Code.Contains("_Information") || entry.Code.Contains("_Ok") || entry.Code.Contains("_Alert") || entry.Code.Contains("_Alert1"))
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

    void BasePage_LoadComplete(object sender, EventArgs e)
    {
        SetDecoding(this.Page.Form);
        SetEncoding(this.Page.Form);
    }

    private void SetDecoding(System.Web.UI.Control objControl)
    {
        if (objControl != null && !objControl.HasControls())
        {
            switch (objControl.GetType().Name)
            {
                case TEXTBOX:
                    (objControl as System.Web.UI.WebControls.TextBox).Text = Server.HtmlDecode((objControl as System.Web.UI.WebControls.TextBox).Text);
                    break;
                case LABEL:
                    (objControl as System.Web.UI.WebControls.Label).Text = Server.HtmlDecode((objControl as System.Web.UI.WebControls.Label).Text);
                    break;
                default:
                    break;
            }
        }
        foreach (System.Web.UI.Control pageControl in objControl.Controls)
        {
            SetDecoding(pageControl);
        }
    }

    private void SetEncoding(System.Web.UI.Control objControl)
    {
        if (objControl != null && !objControl.HasControls())
        {
            switch (objControl.GetType().Name)
            {
                //case TEXTBOX:
                //    (objControl as TextBox).Text = Microsoft.Security.Application.Encoder.HtmlEncode((objControl as TextBox).Text);
                //    break;
                //case HIDDENFIELD:
                //    (objControl as HiddenField).Value = Microsoft.Security.Application.Encoder.HtmlEncode((objControl as HiddenField).Value);
                //    break;
                //case HTMLHIDDENINPUT:
                //    (objControl as System.Web.UI.HtmlControls.HtmlInputHidden).Value = Microsoft.Security.Application.Encoder.HtmlEncode((objControl as System.Web.UI.HtmlControls.HtmlInputHidden).Value);
                //    break;
                //case DROPDOWN:
                //    DropDownList oDropDownList = (objControl as DropDownList);
                //    if (oDropDownList.SelectedItem != null)
                //    {
                //        (objControl as DropDownList).SelectedItem.Value = Microsoft.Security.Application.Encoder.HtmlEncode(oDropDownList.SelectedItem.Value);
                //        //(objControl as DropDownList).SelectedItem.Text = Microsoft.Security.Application.Encoder.HtmlEncode(oDropDownList.SelectedItem.Text);
                //    }
                //    break;
                //case LABEL:
                //    (objControl as Label).Text = Microsoft.Security.Application.Encoder.HtmlEncode((objControl as Label).Text);
                //    break;
                //case HTMLTABLECELL:
                //    (objControl as HtmlTableCell).InnerText = Microsoft.Security.Application.Encoder.HtmlEncode((objControl as HtmlTableCell).InnerText);
                //    break;
                default:
                    break;
            }
        }
        foreach (System.Web.UI.Control pageControl in objControl.Controls)
        {
            SetEncoding(pageControl);
        }
    }

    #endregion

    #region compressViewstate

    private const string CompressedViewStateId = "CompressedViewState";

    private void CompressViewstate(object state)
    {
        //The ObjectStateFormatter is explicitly for serializing
        //viewstate, if you're using .net 1.1 then use the LosFormatter

        //First off, lest gets the state in a byte[]
        ObjectStateFormatter formatter = new ObjectStateFormatter();
        byte[] bytes;
        using (MemoryStream writer = new MemoryStream())
        {
            formatter.Serialize(writer, state);
            bytes = writer.ToArray();
        }

        //Now we've got the raw data, lets squish the whole thing
        using (MemoryStream output = new MemoryStream())
        {
            using (DeflateStream compressStream = new DeflateStream(output, CompressionMode.Compress, true))
            {
                compressStream.Write(bytes, 0, bytes.Length);
            }

            //OK, now lets store the compressed data in a hidden field.
            ScriptManager.RegisterHiddenField(this, CompressedViewStateId, Convert.ToBase64String(output.ToArray()));
        }
    }



    private object DecompressViewstate()
    {
        //First lets get ths raw compressed string into a byte[]
        byte[] bytes = Convert.FromBase64String(Request.Form[CompressedViewStateId]);

        using (MemoryStream input = new MemoryStream(bytes))
        {
            //Now push the compressed data into the decompression stream
            using (DeflateStream decompressStream = new DeflateStream(input, CompressionMode.Decompress, true))
            {
                using (MemoryStream output = new MemoryStream())
                {
                    //Now we wip through the decompression stream and pull our data back out
                    byte[] buffer = new byte[256];
                    int data;
                    while ((data = decompressStream.Read(buffer, 0, buffer.Length)) > 0)
                    {
                        output.Write(buffer, 0, data);
                    }

                    //Finally we convert the whole lot back into a string and convert it
                    //back into it's original object.
                    ObjectStateFormatter formatter = new ObjectStateFormatter();
                    return formatter.Deserialize(Convert.ToBase64String(output.ToArray()));
                }
            }
        }
    }

    protected override object LoadPageStateFromPersistenceMedium()
    {

        return this.DecompressViewstate();

    }

    protected override void SavePageStateToPersistenceMedium(

        object state

    )
    {

        this.CompressViewstate(state);

    }
    #endregion

    public string OrgDateTimeZoneNew
    {
        get
        {
            if (Session["OrgTimeZone"] != null)
            {
                string timeZone = Session["OrgTimeZone"].ToString();
                orgDateTimeZone = (TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById(timeZone))).ToString("dd-MM-yyyy hh:mmtt");
            }
            else
            {
                orgDateTimeZone = DateTime.Now.ToString("dd-MM-yyyy hh:mmtt");
            }

            return orgDateTimeZone;
        }
        set
        {
        }
    }
}

