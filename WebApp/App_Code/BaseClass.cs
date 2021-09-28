using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using Attune.Podium.Common;
using System.Web;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

/// <summary>
/// Summary description for BaseWebService
/// </summary>
public class BaseClass : Page
{

    public BaseClass()
    {
        GetSeeeionValue();
    }

    public string IsFirstLogin { get; set; }
    int orgID = 0;
    int roleID = 0;
    long uID = 0;
    string name = string.Empty;
    string orgName = string.Empty;
    string orgDisplayName = string.Empty;
    long lID = 0;
    int iLocationID = 0;
    int iUserID = 0;
    //int themeid = 0;
    string userName = string.Empty;
    string nurseName = string.Empty;
    string roleName = string.Empty;
    string logoPath = String.Empty;
    string age = String.Empty;
    string bloodGroup = String.Empty;
    string uRNo = String.Empty;
    int inventoryLocationID = 0;
    string currencyName = string.Empty;

    string isTrustedOrg = string.Empty;
    string uploadPath = string.Empty;
    string currencyFormat = string.Empty;
    string isAmountEditable = string.Empty;
    string departmentName = string.Empty;

    public int ThemeID { get; set; }
    public string HideIPManageRate { get; set; }
    public string LocationName { get; set; }
    private string minorCurrencyName = string.Empty;
    private int countryID = 0;
    private int stateID = 0;
    public string isCorporateOrg = string.Empty;
    Int64 pageID = 0;
    PageContextkey pageContextDetails = new PageContextkey();
    ContextDetails contextInfo = new ContextDetails();
    GateWay gateWay = new GateWay();

    public string IsCorporateOrg
    {
        get { return isCorporateOrg; }
        set { isCorporateOrg = value; }
    }

    public virtual long GetData(out ArrayList attribute, out ArrayList attrValue)
    {
        attribute = null;
        attrValue = null;
        return -1;
    }

     
    protected  void GetSeeeionValue()
    {

        if ((Session["OrgID"]) != null)
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            OrgID = orgID;
            pageContextDetails.OrgID = orgID;
            contextInfo.OrgID = OrgID;
        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=1");
        //}
        if ((Session["RoleID"]) != null)
        {
            Int32.TryParse(Session["RoleID"].ToString(), out roleID);
            RoleID = roleID;
            pageContextDetails.RoleID = roleID;
            contextInfo.RoleID = roleID;
        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=2");
        //}

        if ((Session["UID"]) != null)
        {
            Int64.TryParse(Session["UID"].ToString(), out uID);
            UID = uID;
        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=3");
        //}
        if (Session["UserID"] != null)
        {
            Int32.TryParse(Session["UserID"].ToString(), out iUserID);
            ContextInfo.UserID = iUserID;
        }

        if ((Session["Name"]) != null)
        {
            Name = Session["Name"].ToString();
            contextInfo.Name = Name;

        }
        //else
        //{
        //    Response.Redirect("Error.aspx?ID=3");
        //}
        if (Session["IsFirstLogin"] != null)
        {
            IsFirstLogin = Session["IsFirstLogin"].ToString();
        }

        if ((Session["OrgName"]) != null)
        {
            orgName = Session["OrgName"].ToString();
            contextInfo.OrgName = orgName;

        }
        if ((Session["OrgDisplayName"]) != null)
        {
            orgDisplayName = Session["OrgDisplayName"].ToString();
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

        if ((Session["LID"]) != null)
        {
            Int64.TryParse(Session["LID"].ToString(), out lID);
            LID = lID;
            contextInfo.LoginID = lID;
        }

        if ((Session["Age"]) != null)
        {
            Age = Session["Age"].ToString();
        }
        if ((Session["URNo"]) != null)
        {
            URNo = Session["URNo"].ToString();
        }
        if ((Session["BloodGroup"]) != null)
        {
            BloodGroup = Session["BloodGroup"].ToString();
        }

        if ((Session["UserName"]) != null)
        {
            userName = Session["UserName"].ToString();
            UserName = userName;
        }
        if ((Session["NurseName"]) != null)
        {
            nurseName = Session["NurseName"].ToString();
            NurseName = nurseName;
        }
        if ((Session["RoleName"]) != null)
        {
            RoleName = Session["RoleName"].ToString();
            contextInfo.RoleName = RoleName;
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
            UploadPath = Session["UploadPath"].ToString();
        }
        if ((Session["InventoryLocationID"]) != null)
        {
            Int32.TryParse(Session["InventoryLocationID"].ToString(), out inventoryLocationID);
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
        if ((Session["IsCorporateOrg"]) != null)
        {
            IsCorporateOrg = Session["IsCorporateOrg"].ToString();

        }
        if ((Session["HideIPManageRate"] != null))
        {
            HideIPManageRate = Session["HideIPManageRate"].ToString();
        }
        if ((Session["LocationName"]) != null)
        {
            LocationName = Session["LocationName"].ToString();
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
            ContextInfo.LanguageCode = Session["LanguageCode"].ToString();
            LanguageCode = Session["LanguageCode"].ToString();
        }
        MinorCurrencyName = Session["MinorCurrency"] != null ? Session["MinorCurrency"].ToString() : string.Empty;

        gateWay.GetPageDetails(HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.Replace("~", ""), out pageID);
        pageContextDetails.PageID = pageID;
        contextInfo.PageID = pageID;
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
    }

    
    public string LanguageCode { get; set; }
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

    public string URNo
    {
        get { return uRNo; }
        set { uRNo = value; }
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
        get { return iUserID; }
        set { iUserID = value; }
    }
    public string LogoPath
    {
        get { return logoPath; }
        set { logoPath = value; }
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
    public string RoleName
    {
        get { return roleName; }
        set { roleName = value; }
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

    public long LID
    {
        get { return lID; }
        set { lID = value; }
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


    public string OrgName
    {
        get { return orgName; }
        set { orgName = value; }
    }
    public string OrgDisplayName
    {
        get { return orgDisplayName; }
        set { orgDisplayName = value; }
    }
    public string UserName
    {
        get { return userName; }
        set { userName = value; }
    }
    public string NurseName
    {
        get { return nurseName; }
        set { nurseName = value; }
    }
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

    public string UploadPath
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

    public string MinorCurrencyName
    {
        get { return minorCurrencyName; }
        set { minorCurrencyName = value; }
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
}
