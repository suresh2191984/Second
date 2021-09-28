using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Text.RegularExpressions;
using Attune.Solution.DAL;
using Attune.Podium.SmartAccessor;
using System.Collections.Specialized;
using AjaxControlToolkit;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Collections;
using System.Xml;
using System.Data;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using Attune.Podium.PerformingNextAction;
using HomeCollectionsBL;
using Newtonsoft.Json;
using System.Globalization;
using Attune.Podium.FileUpload;
using System.Data.OleDb;
using Attune.Podium.BusinessEntities.CustomEntities;

/// <summary>
/// Summary description for HCService
/// </summary>
[WebService(Namespace = "http://Attunelive.Com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class HCService : System.Web.Services.WebService
{
    string sExaminationName = string.Empty;
    string sComplaintName = string.Empty;
    string sHistoryName = string.Empty;

    string DrugName = string.Empty;
    string Formulation = string.Empty;
    string ROA = string.Empty;
    string Dose = string.Empty;

    string groupInv = string.Empty;
    string IndInv = string.Empty;
    string ProductInv = string.Empty;
    string Iname = string.Empty;
    string orgUserName = string.Empty;
    int OrgAddressID = 0;
    int InventoryLocationID = 0;
    int OrgId = 0;
    long PatientVisitID = 0;
    string SurgeryName = string.Empty;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    string phyName = string.Empty;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    public HCService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPatientListforBookings(string prefixText, string contextKey, int flag)
    {
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        long retCode = -1;
        int orgID = 0;
        string IsCorporateOrg = "N";
        Utilities objUtilities = new Utilities();
        string KeyValue = string.Empty;
        objUtilities.GetApplicationValue("PatientRegistrationListCount", out KeyValue);
        string[] PatientList = null;
        List<string> items = new List<string>();
        if (Session["RoleName"].ToString() != "Referring Physician")
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            //IsCorporateOrg = Session["IsCorporateOrg"].ToString();

            if (IsCorporateOrg == "N")
            {
                retCode = new HomeCollectionsBL.HomeCollections_BL(new BaseClass().ContextInfo).MobileHCGetPatientListforBookings(prefixText, orgID,flag, out lstPatient);
            }

            if (lstPatient.Count > 0)
            {
                PatientList = new string[lstPatient.Count];
                for (int i = 0; i < lstPatient.Count; i++)
                {
                    string[] name = lstPatient[i].Name.Split('~');
                    string KeyVal = name[0];
                    string value = lstPatient[i].Comments;
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
                }
            }
        }
        return items.ToArray();
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetLocationforHomeCollection(string prefixText, string contextKey)
    {       
        List<locationDetails> lstLocation = new List<locationDetails>();
        List<Location> lstLocationforHomeCollection = new List<Location>();
        List<string> items = new List<string>();
        //string[] strLocationName = null;
        long Pincode = 0;
        long LocationID = 0;

        try
        {

            HomeCollections_BL home_Bl = new HomeCollections_BL(new BaseClass().ContextInfo);
            home_Bl.GetLocationforHomeCollection(Pincode, LocationID, prefixText, out lstLocationforHomeCollection);
            if (lstLocationforHomeCollection.Count > 0)
            {
                foreach (Location location in lstLocationforHomeCollection)
                {
                    string pincode = location.Pincode.ToString() != null ? location.Pincode.ToString() : "";
                    string locationname = location.LocationName.ToString() != null ? location.LocationName.ToString() : "";
                    string city = location.CityName.ToString() != null ? location.CityName.ToString() : "";
                    string state = location.StateName.ToString() != null ? location.StateName.ToString() : "";
                    long cityID = location.CityID != null ? location.CityID : 0;
                    long StateID = location.StateID != null ? location.StateID : 0;

                    if (contextKey == "Y")
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(locationname, pincode + "~" + city + "~" + state + "~" + cityID + "~" + StateID));
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetLocationforHomeCollection: ", ex);
        }
        return items.ToArray();
    }

    #region GetLocationforHomeCollectionpincode
    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public List<Location> GetLocationforHomeCollectionpincode(long pincode)
        {
        List<Location> lstLocationforHomeCollection = new List<Location>();
        //List<string> items = new List<string>();       
        //long Pincode = 0;
        string prefixText = "";
        long LocationID = 0;

        try
        {
            new HomeCollections_BL(new BaseClass().ContextInfo).GetLocationforHomeCollection(pincode, LocationID, prefixText, out lstLocationforHomeCollection);
            if (lstLocationforHomeCollection.Count > 0)
            {

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetLocationforHomeCollection: ", ex);
        }
        return lstLocationforHomeCollection;
    }
    #endregion

    #region GetHomeCollectionTime
    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public List<Bookings> GetHomeCollectionTime(long userid, string collectiontime)
    {
        List<Bookings> GetCollectiontimeValidation = new List<Bookings>();
        //List<string> items = new List<string>();       
        //long Pincode = 0;
        string prefixText = "";
        long LocationID = 0;

        try
        {
            new HomeCollections_BL(new BaseClass().ContextInfo).GetCollectiontimeValidation(userid, Convert.ToDateTime(collectiontime), out GetCollectiontimeValidation);
            if (GetCollectiontimeValidation.Count > 0)
            {
                long pid = GetCollectiontimeValidation[0].PatientID;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }
        return GetCollectiontimeValidation;
    }
    #endregion


    #region GetHomeCollectionDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Bookings> GetHomeCollectionDetails(long PatientID, DateTime Fromdate, DateTime Todate, long RoleID, long UserID, int CollecOrgID,
             long CollecOrgAddrID, int LoginOrgID, DateTime BookedFrom, DateTime BookedTo, string Status, string Task, string MobileNumber, string TelePhone,
              string pName, int PageSize, int currentPageNo, long BookingNumber)
    {
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
        string Patient = string.Empty;

        try
        {

            new HomeCollections_BL(new BaseClass().ContextInfo).GetHomeCollectionDetails(PatientID, Fromdate, Todate, RoleID, UserID, CollecOrgID,
                 CollecOrgAddrID, LoginOrgID, BookedFrom, BookedTo, Status, Task, out lstHomeCollectionDetails, MobileNumber, TelePhone,
                 pName, PageSize, currentPageNo, BookingNumber, out totalRows);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }
        return lstHomeCollectionDetails;

    }
    #endregion




    #region NewGetHomeCollectionDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public List<Bookings> NewGetHomeCollectionDetails(DateTime Fromdate, DateTime Todate, int CollecOrgID,
    //          int LoginOrgID, string Status, string Task, string MobileNumber, string TelePhone,
    //          string pName, int PageSize, int currentPageNo, long BookingNumber)
    public List<Bookings> NewGetHomeCollectionDetails(string CollecttionFromdate, string CollecttionTodate, string Fromdate, string Todate, string CollecOrgID,
              string LoginOrgID, string Status, string Task, string Location,
                      string Pincode, long UserID, string MobileNumber, string TelePhone,
              string pName, string PageSize, string currentPageNo, string BookingNumber)
    {
        DateTime FromdateLoc;
        DateTime TodateLoc;
        DateTime ClollectFromLoc;
        DateTime ClollectToLoc;
        int PageSizeLoc = 0;
        int CurrentPageNoLoc = 0;
        int CollecOrgIDLoc = 0;
        int LoginOrgIDLoc = 0;
        if (Fromdate != "")
        {
            DateTime.TryParse(Fromdate, out FromdateLoc);
        }
        else
        {
            FromdateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (Todate != "")
        {
            DateTime.TryParse(Todate, out TodateLoc);
        }
        else
        {
            TodateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (CollecttionFromdate != "")
        {

            DateTime.TryParse(CollecttionFromdate, out ClollectFromLoc);
        }
        else
        {
            ClollectFromLoc = Convert.ToDateTime("1/1/1753");
        }
        if (CollecttionTodate != "")
        {

            DateTime.TryParse(CollecttionTodate, out ClollectToLoc);
        }
        else
        {
            ClollectToLoc = Convert.ToDateTime("1/1/1753");
        }

        long BookingNumberLoc = 0;
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
        string Patient = string.Empty;

        try
        {
            Int64.TryParse(BookingNumber, out BookingNumberLoc);
            Int32.TryParse(PageSize, out PageSizeLoc);
            Int32.TryParse(currentPageNo, out CurrentPageNoLoc);
            Int32.TryParse(CollecOrgID, out CollecOrgIDLoc);
            Int32.TryParse(LoginOrgID, out LoginOrgIDLoc);
            HomeCollections_BL home_BlUI1 = new HomeCollections_BL(new BaseClass().ContextInfo);
            home_BlUI1.NewGetHomeCollectionDetails(ClollectFromLoc, ClollectToLoc, FromdateLoc, TodateLoc,
                 CollecOrgIDLoc, LoginOrgIDLoc, Status, Task, Location, Pincode, UserID,
                    out lstHomeCollectionDetails, MobileNumber, TelePhone, pName, PageSizeLoc, CurrentPageNoLoc, BookingNumberLoc);
            
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }
        return lstHomeCollectionDetails;


    }
    #endregion

    #region SaveServiceQuotationDetails
    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //[WebGet(ResponseFormat = WebMessageFormat.Json)]   
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    public long SaveServiceQuotationDetails(List<Bookings> lstBookings)
    {
       // BasePage r = new BasePage();
        int OrgID = OrgId;
        long LID = -1;
        long returnCode = -1;
        long bookingID = -1;
       // PageContextkey PC = new PageContextkey();

        //lstBookings = new List<Bookings>();
        //Bookings oBookings = new Bookings();
        
        //oBookings.BookingID = lstBookings[0];
        //oBookings.TokenNumber = 0;
        //oBookings.PatientName = "";
        //oBookings.Age = "";
        //oBookings.OtherOrgID = 67;
        //DateTime DOB = new DateTime();
        //DOB = new DateTime(1800, 1, 1);
        //string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
        //oBookings.DOB = Convert.ToDateTime("01/01/1800");
        //oBookings.LandLineNumber = "";
        //oBookings.FeeType = "";
        //oBookings.SourceType = "Home Collection";
        //oBookings.ClientID = 0;

        //oBookings.PatientID = 0;
        //oBookings.OrgAddressID = 67;
        //oBookings.OtherOrgID = 67;
        //oBookings.CollectionAddress = "";
        //oBookings.RoleID = 0;
        //oBookings.PhoneNumber = "";
        //oBookings.RoleID = RoleID;
        //oBookings.UserID = Convert.ToInt64(UserId);
        //oBookings.CollectionTime = Convert.ToDateTime(CollectionTime);
        //if (BookingStatus == "Booked")
        //{
        //    BookingStatus = "B";
        //}
        //else if (BookingStatus == "Completed")
        //{
        //    BookingStatus = "R";
        //}
        //else
        //{
        //    BookingStatus = "C";
        //}
        //if (CityID != "")
        //{
        //    oBookings.Pincode = CityID.Split('~')[0];
        //    oBookings.City = CityID.Split('~')[1];
        //    oBookings.State = CityID.Split('~')[2];
        //    oBookings.CityID = Convert.ToInt32(CityID.Split('~')[3]);
        //    oBookings.StateID = Convert.ToInt32(CityID.Split('~')[4]);
        //}
        //else
        //{
        //    oBookings.City = "";
        //    oBookings.State = "";
        //    oBookings.Pincode = "";
        //    oBookings.CityID = 0;
        //    oBookings.StateID = 0; ;
        //}

        //oBookings.BookingStatus = BookingStatus;
        //oBookings.CollectionAddress2 = Location;

        //oBookings.PatientNumber = "0";
        ////oBookings.Priority = Convert.ToInt32(Priority);
        //oBookings.Priority = Priority;
        //oBookings.BillDescription = "";



        //oBookings.Comments = Comments;
        string value = string.Empty;
        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstPreOrderInv = new List<OrderedInvestigations>();
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        returnCode=    new HomeCollections_BL(new BaseClass().ContextInfo).SaveServiceQuotationDetails(lstBookings[0], 
                             lstInv,lstPreOrderInv, OrgID, LID, out  bookingID);

        if (returnCode == 1)
        {
            ActionManager AM = new ActionManager(new BaseClass().ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            if (lstBookings[0].TokenID=="U")
            {
                PC.OrgID = lstBookings[0].BookingOrgID;
                PC.ButtonName = "btnUpdateHC";
                PC.ButtonValue = "UpdateHC";
                PC.PageID = 581;
                PC.RoleID = 3843;
                PC.PatientVisitID = bookingID;
            }
            else if (lstBookings[0].TokenID == "C")
            {
                PC.OrgID = lstBookings[0].BookingOrgID;
                PC.ButtonName = "btnCancel";
                PC.ButtonValue = "CancelHC";
                PC.PageID = 581;
                PC.RoleID = 3843;
                PC.PatientVisitID = bookingID;


            }
            else
            {
                PC.OrgID = lstBookings[0].BookingOrgID;
                PC.ButtonName = "btnCancel";
                PC.ButtonValue = "CancelHC";
                PC.PageID = 581;
                PC.RoleID = 3843;
                PC.PatientVisitID = bookingID;
            }

            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC, "", "");
          
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert1", "javascript:alert('Updated successfully');", true);
            //string PageUrl = Request.ApplicationPath + @"/Homecollection/homecollection.aspx?IsPopup=Y";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Updated successfully');window.location ='" + PageUrl + "';", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Clear", "clearupdate();", true);
        }
        return Convert.ToInt64(bookingID);

    }
    #endregion
    #region SaveServiceQuotationDetailscbk
    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //[WebGet(ResponseFormat = WebMessageFormat.Json)]   
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    public long SaveServiceQuotationDetailscbk(List<Bookings> lstBookings)
    {
        // BasePage r = new BasePage();
        int OrgID = OrgId;
        long LID = -1;
        long returnCode = -1;
        long bookingID = -1;
        // PageContextkey PC = new PageContextkey();

        //lstBookings = new List<Bookings>();
        //Bookings oBookings = new Bookings();

        //oBookings.BookingID = lstBookings[0];
        //oBookings.TokenNumber = 0;
        //oBookings.PatientName = "";
        //oBookings.Age = "";
        //oBookings.OtherOrgID = 67;
        //DateTime DOB = new DateTime();
        //DOB = new DateTime(1800, 1, 1);
        //string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
        //oBookings.DOB = Convert.ToDateTime("01/01/1800");
        //oBookings.LandLineNumber = "";
        //oBookings.FeeType = "";
        //oBookings.SourceType = "Home Collection";
        //oBookings.ClientID = 0;

        //oBookings.PatientID = 0;
        //oBookings.OrgAddressID = 67;
        //oBookings.OtherOrgID = 67;
        //oBookings.CollectionAddress = "";
        //oBookings.RoleID = 0;
        //oBookings.PhoneNumber = "";
        //oBookings.RoleID = RoleID;
        //oBookings.UserID = Convert.ToInt64(UserId);
        //oBookings.CollectionTime = Convert.ToDateTime(CollectionTime);
        //if (BookingStatus == "Booked")
        //{
        //    BookingStatus = "B";
        //}
        //else if (BookingStatus == "Completed")
        //{
        //    BookingStatus = "R";
        //}
        //else
        //{
        //    BookingStatus = "C";
        //}
        //if (CityID != "")
        //{
        //    oBookings.Pincode = CityID.Split('~')[0];
        //    oBookings.City = CityID.Split('~')[1];
        //    oBookings.State = CityID.Split('~')[2];
        //    oBookings.CityID = Convert.ToInt32(CityID.Split('~')[3]);
        //    oBookings.StateID = Convert.ToInt32(CityID.Split('~')[4]);
        //}
        //else
        //{
        //    oBookings.City = "";
        //    oBookings.State = "";
        //    oBookings.Pincode = "";
        //    oBookings.CityID = 0;
        //    oBookings.StateID = 0; ;
        //}

        //oBookings.BookingStatus = BookingStatus;
        //oBookings.CollectionAddress2 = Location;

        //oBookings.PatientNumber = "0";
        ////oBookings.Priority = Convert.ToInt32(Priority);
        //oBookings.Priority = Priority;
        //oBookings.BillDescription = "";



        //oBookings.Comments = Comments;
        string value = string.Empty;
        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstPreOrderedInv = new List<OrderedInvestigations>();
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).SaveServiceQuotationDetails(lstBookings[0], lstInv, lstPreOrderedInv, OrgID, LID, out  bookingID);

        if (returnCode == 1)
        {
            ActionManager AM = new ActionManager(new BaseClass().ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            if (lstBookings[0].TokenID == "U")
            {
                PC.OrgID = lstBookings[0].BookingOrgID;
                PC.ButtonName = "btnUpdateHC";
                PC.ButtonValue = "UpdateHC";
                PC.PageID = 581;
                PC.RoleID = 3843;
                PC.PatientVisitID = bookingID;
            }
            else if (lstBookings[0].TokenID == "C")
            {
                PC.OrgID = lstBookings[0].BookingOrgID;
                PC.ButtonName = "btnCancel";
                PC.ButtonValue = "CancelHC";
                PC.PageID = 581;
                PC.RoleID = 3843;
                PC.PatientVisitID = bookingID;


            }
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC, "", "");

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert1", "javascript:alert('Updated successfully');", true);
            //string PageUrl = Request.ApplicationPath + @"/Homecollection/homecollection.aspx?IsPopup=Y";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Updated successfully');window.location ='" + PageUrl + "';", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Clear", "clearupdate();", true);
        }
        return Convert.ToInt64(bookingID);

    }
    #endregion


    public class locationDetails
    {
        public string locationName { get; set; }
        public string description { get; set; }

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<locationDetails> NewGetLocationforHomeCollection(string prefixText, string contextKey)
    {
        List<locationDetails> lstLocation = new List<locationDetails>();
        List<Location> lstLocationforHomeCollection = new List<Location>();
        List<string> items = new List<string>();
        //string[] strLocationName = null;
        long Pincode = 0;
        long LocationID = 0;

        try
        {

            new HomeCollections_BL(new BaseClass().ContextInfo).GetLocationforHomeCollection(Pincode, LocationID, prefixText, out lstLocationforHomeCollection);
            if (lstLocationforHomeCollection.Count > 0)
            {
                foreach (Location location in lstLocationforHomeCollection)
                {
                    string pincode = location.Pincode.ToString() != null ? location.Pincode.ToString() : "";
                    string locationname = location.LocationName.ToString() != null ? location.LocationName.ToString() : "";
                    string city = location.CityName.ToString() != null ? location.CityName.ToString() : "";
                    string state = location.StateName.ToString() != null ? location.StateName.ToString() : "";
                    long cityID = location.CityID != null ? location.CityID : 0;
                    long StateID = location.StateID != null ? location.StateID : 0;

                    if (contextKey == "Y")
                    {
                        locationDetails hclocation = new locationDetails(); ;
                        hclocation.locationName = locationname;
                        hclocation.description = pincode + "~" + city + "~" + state + "~" + cityID + "~" + StateID;
                        lstLocation.Add(hclocation);
                        //items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(locationname, pincode + "~" + city + "~" + state + "~" + cityID + "~" + StateID));

                    }


                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetLocationforHomeCollection: ", ex);
        }
        //return items.ToArray();
        return lstLocation;
    }


    //[WebMethod(EnableSession = true)]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public List<Role> BindRole(int orgID)
    //{
    //    long returnCode = -1;
    //    GateWay gateway = new GateWay(new BaseClass().ContextInfo);
    //    List<Role> userRoles = new List<Role>();
    //    Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
    //    loggedIn.LoginID = Convert.ToInt64(Session["LID"]);
    //    returnCode = gateway.GetRoles(loggedIn, out userRoles);
    //    List<Role> lstRoles = new List<Role>();
    //    lstRoles = (from child in userRoles
    //                where child.OrgID == orgID
    //                orderby child.Description
    //                select new Role { RoleName = child.RoleID + "~" + child.RoleName, Description = child.Description }).Distinct().ToList();
    //    return lstRoles;
    //}


    //[WebMethod(EnableSession = true)]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public List<OrganizationAddress> BindLocation(int orgID, long RoleID)
    //{
    //    long returnCode = -1;
    //    Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
    //    loggedIn.LoginID = Convert.ToInt64(Session["LID"]);
    //    PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
    //    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    //    returnCode = patientBL.GetLocation(orgID, Convert.ToInt64(Session["LID"]), RoleID, out lstLocation);
    //    return lstLocation;
    //}

    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetUserName(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = null;
        try
        {
            StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            long orgId;
            long loginID = -1;
            long Locationid = -1;
            long roleId = -1;
            if (!kv.ContainsKey("Org") || !Int64.TryParse(kv["Org"], out orgId))
            {
                return null;
            }
            if (!kv.ContainsKey("Location") || !Int64.TryParse(kv["Location"].Split('~')[0], out Locationid))
            {
                return null;
            }
            if (!kv.ContainsKey("Role") || !Int64.TryParse(kv["Role"].Split('~')[0], out roleId))
            {
                return null;
            }

            Role_BL RoleBL = new Role_BL(new BaseClass().ContextInfo);
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Login objLogin = new Login();
            objLogin.LoginID = loginID;
            List<Users> lstResult = new List<Users>();

            RoleBL.GetUserName(orgId, roleId, out lstResult);


            List<Users> lstUsers = (from child in lstResult where child.OrgID == orgId orderby child.Name select child).ToList();
            values = new List<CascadingDropDownNameValue>();
            List<CascadingDropDownNameValue> orgExist;
            string username = string.Empty;
            string userDescript = string.Empty;
            foreach (Users objUser in lstUsers)
            {
                username = String.IsNullOrEmpty(objUser.Name) ? objUser.Name : objUser.Name.Trim();
                //roleDescript = objUser.Description.Trim();
                orgExist = values.Where(v => v.name == username).ToList();
                if (orgExist.Count == 0)

                    values.Add(new CascadingDropDownNameValue(username, Convert.ToString(objUser.UserID)));// + "~" + username

            }
            if (values.Count > 0)
            {
                List<CascadingDropDownNameValue> isDefaultExist = values.Where(v => v.isDefaultValue == true).ToList();
                if (isDefaultExist.Count == 0)
                    values[0].isDefaultValue = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations: ", ex);
        }
        return values.ToArray();
    }


    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetRoleName(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = null;
        try
        {
            StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            long orgId;
            long loginID = -1;
            long Locationid = -1;

            if (!kv.ContainsKey("Org") || !Int64.TryParse(kv["Org"], out orgId))
            {
                return null;
            }
            if (!kv.ContainsKey("Location") || !Int64.TryParse(kv["Location"].Split('~')[0], out Locationid))
            {
                return null;
            }

            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Login objLogin = new Login();
            objLogin.LoginID = loginID;
            List<Role> lstResult = new List<Role>();

            gateWay.GetRoles(objLogin, out lstResult);
            List<Role> lstRole = (from child in lstResult where child.OrgID == orgId orderby child.RoleName select child).ToList();
            values = new List<CascadingDropDownNameValue>();
            List<CascadingDropDownNameValue> orgExist;
            string roleName = string.Empty;
            string roleDescript = string.Empty;
            foreach (Role objRole in lstRole)
            {
                roleName = String.IsNullOrEmpty(objRole.RoleName) ? objRole.RoleName : objRole.RoleName.Trim();
                roleDescript = objRole.Description.Trim();
                orgExist = values.Where(v => v.name == roleName).ToList();
                if (orgExist.Count == 0)
                    if (roleName == "Phlebotomist" || roleName == "Sr Phlebotomist")
                    {
                        values.Add(new CascadingDropDownNameValue(roleDescript, Convert.ToString(objRole.RoleID)));// + "~" + roleName, objRole.IsDefault
                    }
            }
            if (values.Count > 0)
            {
                List<CascadingDropDownNameValue> isDefaultExist = values.Where(v => v.isDefaultValue == true).ToList();

                if (isDefaultExist.Count == 0)
                    values[0].isDefaultValue = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations: ", ex);
        }
        return values.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string IsTaskAlreadyExists(string BookingID)
    {
        string resultValue = "";
        try
        {
            //HomeCollections_BL HBL = new HomeCollections_BL(new BaseClass().ContextInfo);
            new HomeCollections_BL(new BaseClass().ContextInfo).pMobile_HCisAlreadyPicked(BookingID, out resultValue);
            
        }
        catch (Exception ex)
        {
            
             CLogger.LogError("Error in Web Service IsTaskAlreadyExists: ", ex);
        }
        return resultValue;
    }
    #region GetPreviousVisitBilling
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<Array> GetPreviousVisitBilling_HC(long ID,  string Type)
    {
        List<Array> Obj = new List<Array>();
        Array Obj1;//= new Array();
       

        List<Bookings> lsBookingsdetails = new List<Bookings>();
        try
        {

            long returnCode = -1;
            returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).GetPreviousVisitBilling_HC(ID,Type, out lsBookingsdetails);
            Obj1 = lsBookingsdetails.ToArray();
            
            Obj.Add(Obj1);
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Home Collection Web Service GetPreviousVisitBilling Message:", ex);
        }
        return Obj;
    }
    #endregion
    #region GetHCBookingDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public List<Bookings> NewGetHomeCollectionDetails(DateTime Fromdate, DateTime Todate, int CollecOrgID,
    //          int LoginOrgID, string Status, string Task, string MobileNumber, string TelePhone,
    //          string pName, int PageSize, int currentPageNo, long BookingNumber)
    public List<Bookings> GetHCBookingDetails(string CollecttionFromdate, string CollecttionTodate, string Fromdate, string Todate, string CollecOrgID,
              string LoginOrgID, string Status, string Task, string Location,
                      string Pincode, long UserID, string MobileNumber, string TelePhone,
              string pName, string PageSize, string currentPageNo, string BookingNumber)
    {
        DateTime FromdateLoc;
        DateTime TodateLoc;
        DateTime ClollectFromLoc;
        DateTime ClollectToLoc;
        int PageSizeLoc = 0;
        int CurrentPageNoLoc = 0;
        int CollecOrgIDLoc = 0;
        int LoginOrgIDLoc = 0;
        if (Fromdate != "")
        {
            DateTime.TryParse(Fromdate, out FromdateLoc);
        }
        else
        {
            FromdateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (Todate != "")
        {
            DateTime.TryParse(Todate, out TodateLoc);
        }
        else
        {
            TodateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (CollecttionFromdate != "")
        {

            DateTime.TryParse(CollecttionFromdate, out ClollectFromLoc);
        }
        else
        {
            ClollectFromLoc = Convert.ToDateTime("1/1/1753");
        }
        if (CollecttionTodate != "")
        {

            DateTime.TryParse(CollecttionTodate, out ClollectToLoc);
        }
        else
        {
            ClollectToLoc = Convert.ToDateTime("1/1/1753");
        }

        long BookingNumberLoc = 0;
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
        List<OrderedInvestigations> lstOrdInvDetails = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstPreOrdInvDetails = new List<OrderedInvestigations>();

        string Patient = string.Empty;

        try
        {
            Int64.TryParse(BookingNumber, out BookingNumberLoc);
            Int32.TryParse(PageSize, out PageSizeLoc);
            Int32.TryParse(currentPageNo, out CurrentPageNoLoc);
            Int32.TryParse(CollecOrgID, out CollecOrgIDLoc);
            Int32.TryParse(LoginOrgID, out LoginOrgIDLoc);
            HomeCollections_BL home_BlUI1 = new HomeCollections_BL(new BaseClass().ContextInfo);
            //home_BlUI1.GetHCBookingDetails(ClollectFromLoc, ClollectToLoc, FromdateLoc, TodateLoc,
            //     CollecOrgIDLoc, LoginOrgIDLoc, Status, Task, Location, Pincode, UserID,
            //        out lstHomeCollectionDetails, MobileNumber, TelePhone, pName, PageSizeLoc, CurrentPageNoLoc, BookingNumberLoc);
            home_BlUI1.GetHCBookingDetails(ClollectFromLoc, ClollectToLoc, UserID, CollecOrgIDLoc, Location, Pincode, LoginOrgIDLoc, FromdateLoc, TodateLoc,
            Status, Task, MobileNumber, TelePhone, pName, PageSizeLoc, CurrentPageNoLoc, BookingNumberLoc,
            out  lstOrdInvDetails, out lstPreOrdInvDetails, out lstHomeCollectionDetails);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }
        return lstHomeCollectionDetails;


    }
    #endregion

    #region UpdateHCBookingDetails
    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    // To allow this Web Service to be called from script, using ASP.NET AJAX  
   // [System.Web.Script.Services.ScriptService]  
    //[WebGet(ResponseFormat = WebMessageFormat.Json)]   
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    // [WebMethod(EnableSession = true)]
    //  [System.Web.Script.Services.ScriptMethod()]
    public long UpdateHCBookingDetails(List<Bookings> lstBookings, List<PageContextkey> lstPageContext)
    {
    //    int count = 0;
        // BasePage r = new BasePage();
        int OrgID = OrgId;
        long LID = 0;
        long returnCode = -1;
        long bookingID = -1;
        long res = -1;
       // var result = JsonConvert.DeserializeObject<List<test>>(json);
        string value = string.Empty;

        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        ActionManager AM = new ActionManager(new BaseClass().ContextInfo);
        PageContextkey PC = new PageContextkey(); 
        //JavaScriptSerializer js = new JavaScriptSerializer();
        //var oBookings = js.Deserialize<List<Bookings>>(lstBookings.ToString());


        returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).UpdateHCBookingDetails(lstBookings, lstInv, OrgID, LID, out  bookingID);

      //  return Convert.ToInt32(oBookings[0].BookingID.ToString());
        foreach (PageContextkey item in lstPageContext)
        {
            res = AM.PerformingNextStepNotification(item, "", "");
        }
        return bookingID;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public long UpdateHCBulkBookingDetails(List<Bookings> lstBookings, List<PageContextkey> lstPageContext) //save data to database
    {
        int count = 0;
       
        int OrgID = OrgId;
        long LID = 1;
        long returnCode = -1;
        long bookingID = -1; 
        long res = -1;
        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        ActionManager AM = new ActionManager(new BaseClass().ContextInfo);
        PageContextkey PC = new PageContextkey(); 

        returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).UpdateHCBulkBookingDetails(lstBookings, lstInv, OrgID, LID, out  bookingID, out count);
      //  return lstBooking[0].BookingID.ToString();
        foreach (PageContextkey item in lstPageContext)
        {
            res = AM.PerformingNextStepNotification(item, "", "");
        }
        return count;
    }
   
    [WebMethod(EnableSession = true)]
  //  [ScriptMethod(UseHttpGet = true)]
    [System.Web.Script.Services.ScriptMethod( ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
    //[System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<BookingInfo> GetHCMapBookingDetails(long BookingNumber, long UserID)
      {
          //  long returnCode = -1;UseHttpGet = true,

          List<BookingInfo> lstBooking = new List<BookingInfo>();
          List<BookingInfo> lstCollection = new List<BookingInfo>();
          List<BookingInfo> lstBookingHistory = new List<BookingInfo>();
       

        try
        {
         //   returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).GetHCMapBookingDetails(pUserID, out lstBooking, out lstCollection, out lstBookingHistory);
            HomeCollections_BL Book = new HomeCollections_BL(new BaseClass().ContextInfo);
            Book.GetHCMapBookingDetails(BookingNumber,UserID, out lstBooking, out lstCollection, out lstBookingHistory);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }
        return lstBooking;

        
      
       
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
    public List<BookingInfo> GetHCMapBookingHistDetails(long BookingNumber, long UserID)
    {
        // long returnCode = -1;UseHttpGet = true, 

        List<BookingInfo> lstBooking = new List<BookingInfo>();
        List<BookingInfo> lstCollection = new List<BookingInfo>();
        List<BookingInfo> lstBookingHistory = new List<BookingInfo>();

     //   long BookingNumberLoc = 0;
     //   long UserIDLoc = 0;
        try
        {
          //  Int64.TryParse(BookingNumber, out BookingNumberLoc);
         //   Int64.TryParse(UserID, out UserIDLoc);
            HomeCollections_BL home_BlUI1 = new HomeCollections_BL(new BaseClass().ContextInfo);
            home_BlUI1.GetHCMapBookingDetails(BookingNumber,UserID, out lstBooking, out lstCollection, out lstBookingHistory);
        //    returnCode = new HomeCollections_BL(new BaseClass().ContextInfo).GetHCMapBookingDetails(pUserID, out lstBooking, out lstCollection, out lstBookingHistory);


            
        
        
        
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCollectiontimeValidation: ", ex);
        }


        if (lstBookingHistory != null && lstBookingHistory.Count > 0)
        {

            return lstBookingHistory;
        }
        else
        {
            return lstBooking;
        }




    }
	
	[WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Bookingsdata> GetBookingsdetailsforBulkReg(string pFromdt, string pTodt, long pOrgID, long pOrgAddressID)
    {
        long result = -1;
        List<Bookingsdata> lstBooking = new List<Bookingsdata>();

        try
        {
            HomeCollections_BL HCbl = new HomeCollections_BL(new BaseClass().ContextInfo);
            result = HCbl.GetBookingsdetailsforBulkReg(Convert.ToDateTime(pFromdt), Convert.ToDateTime(pTodt), pOrgID, pOrgAddressID, out lstBooking);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBookingsdetailsforBulkReg in HCService.cs: ", ex);
        }

        return lstBooking;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Bookingsdata> GetHCBookingsdetailsforBulkReg(string pFromdt, string pTodt, long pOrgID, long pOrgAddressID)
    {
        long result = -1;
        List<Bookingsdata> lstBooking = new List<Bookingsdata>();
        try
        {
            HomeCollections_BL HCbl = new HomeCollections_BL(new BaseClass().ContextInfo);
            result = HCbl.GetHCBookingsdetailsforBulkReg(Convert.ToDateTime(pFromdt), Convert.ToDateTime(pTodt), pOrgID, pOrgAddressID, out lstBooking);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBookingsdetailsforBulkReg in HCService.cs: ", ex);
        }
        return lstBooking;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList HCBulkBooking(string fulupload, int Fromdata, int ToData)
    {
        ArrayList fileUpload = new ArrayList();
        string Conne = "";
        List<string> objSheet = new List<string>();
        List<HCBookingData> brd = new List<HCBookingData>();
        HCBookingData BulkReg;
        OleDbConnection con;
        DataTable objBookData;
        OleDbDataAdapter adp;
        OleDbCommand cmd;
        int count = 0, tmpcount = 0;
        string filename = "";
        Conne = GetConnection(fulupload, out objSheet, out filename);
        try
        {
            if (Conne != "")
            {
                foreach (string item in objSheet)
                {
                    if (item == "Bulkbooking$")
                    {
                        try
                        {
                            objBookData = new DataTable();
                            con = new OleDbConnection(Conne);
                            con.Open();
                            adp = new OleDbDataAdapter("select * from [" + item + "] where SlNo>" + Fromdata + " and SlNo<=" + ToData + "", con); //where Sl. No>" + Fromdata + " and Sl. No<=" + ToData + "
                            adp.Fill(objBookData);
                            cmd = new OleDbCommand("Select count(1) from [" + item + "]", con);
                            tmpcount = (int)cmd.ExecuteScalar();
                            int pat = 1;
                            con.Close();
                            if (objBookData.Rows.Count == 0)
                            {
                                int a = -1;
                                fileUpload.Add(a);
                            }
                            if (objBookData.Columns.Count == 24)
                            {
                                foreach (DataRow dr in objBookData.Rows)
                                {
                                    BulkReg = new HCBookingData();
                                    BulkReg.SlNo = dr[0].ToString();
                                    BulkReg.OrgName = Convert.ToString(dr[1]);
                                    BulkReg.OrgLocation = Convert.ToString(dr[2]);
                                    string pdate = Convert.ToString(dr[3]);
                                    if (pdate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.BookingDate = pdate;
                                    BulkReg.PatientNumber = Convert.ToString(dr[4]);
                                    BulkReg.Salutation = Convert.ToString(dr[5]);
                                    BulkReg.PatientName = Convert.ToString(dr[6]);
                                    BulkReg.DOB = Convert.ToString(dr[7]);
                                    BulkReg.Age = Convert.ToString(dr[8]);
                                    BulkReg.AgeType = Convert.ToString(dr[9]);
                                    BulkReg.Sex = Convert.ToString(dr[10]);                                   
                                    BulkReg.Pincode = Convert.ToString(dr[11]);
                                    BulkReg.Location = Convert.ToString(dr[12]);
                                    BulkReg.CollectionAddress = Convert.ToString(dr[13]);
                                    string bkCollectionDate = Convert.ToString(dr[14]);
                                    if (bkCollectionDate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(bkCollectionDate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        bkCollectionDate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.CollectionDate = bkCollectionDate; 
                                    BulkReg.Technician = Convert.ToString(dr[15]);                                
                                    BulkReg.TestCodes = Convert.ToString(dr[16]);
                                    BulkReg.Discount = Convert.ToString(dr[17]);
                                    BulkReg.ClientCode = Convert.ToString(dr[18]);
                                    BulkReg.MobileNo = Convert.ToString(dr[19]);
                                    BulkReg.EmailID = Convert.ToString(dr[20]);
                                    BulkReg.DispatchMode = Convert.ToString(dr[21]);
                                    BulkReg.RefDocName = Convert.ToString(dr[22]);
                                    BulkReg.Remarks = Convert.ToString(dr[23]);
                                    brd.Add(BulkReg);
                                    pat++;
                                }
                                count = tmpcount + count;
                            }
                        }
                        catch (Exception ex)
                        {
                            CLogger.LogError("Error while importing excel", ex);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generat XLS Sheet ", ex);
        }
        finally
        {
            fileUpload.Add(brd);
            fileUpload.Add(count);
            if (File.Exists(filename))
            {
                File.Delete(filename);
            }
        }
        return fileUpload;
    }
    private string GetConnection(string ful, out List<String> lstSheetname, out string filename)
    {
        string newfilepath = "";
        lstSheetname = new List<string>();
        filename = string.Empty;
        string Conne = "";
        try
        {
            if (File.Exists(ful))
            {
                DateTime CurrentDateTime = DateTime.Now;
                string fileName = System.IO.Path.GetFileName(ful);
                string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(ful);
                string extension = System.IO.Path.GetExtension(fileName);
                if ((extension == ".xls" || extension == ".xlsx"))
                {
                    String rootPath = Server.MapPath("~/ExcelTest/");
                    filename = rootPath + fileName;
                    newfilepath = ful;
                    if (extension == ".xls")
                    {
                       Conne = "Provider=Microsoft.ACE.OLEDB.12.0;data source=" + newfilepath + ";Extended Properties=Excel 8.0";
                    }
                    if (extension == ".xlsx")
                    {
                        Conne = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + newfilepath + ";Extended Properties=Excel 12.0";
                    }
                }
                OleDbConnection con = null;
                con = new OleDbConnection(Conne);
                con.Open();
                DataTable dt = null;
                dt = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                con.Close();
                foreach (DataRow row in dt.Rows)
                {
                    lstSheetname.Add(row["TABLE_NAME"].ToString());
                }
                con.Close();
                con.Dispose();
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in Webservice GetConnection", Ex);
        }
        finally { }
        return Conne;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList ValidateBulkBookingDetails(string list)
    {
        long returncode = -1;
        ArrayList ValBulkReg = new ArrayList();
        List<HCBookingData> brd = new List<HCBookingData>();
        List<HCBookingData> lstCamp = new List<HCBookingData>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        int count = 0;
        try
        {
            brd = oSerializer.Deserialize<List<HCBookingData>>(list);
            returncode = new HomeCollections_BL(new BaseClass().ContextInfo).ValidateBulkBookingDetails(brd, out lstCamp);
            count = lstCamp.Count;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while importing excel", ex);
        }
        finally
        {
            ValBulkReg.Add(lstCamp);
            ValBulkReg.Add(count);
        }
        return ValBulkReg;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<HCBookingData> SaveBulkBookingDetails(string list, string Testlist)
    {
        long returncode = -1;
        List<HCBookingData> lstinsertCampDetail = new List<HCBookingData>();
        HCBookingData entlstTestCamp;
        List<HCBookingData> lstresult = new List<HCBookingData>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        try
        {
            HCBookingData[] lstCamp = oSerializer.Deserialize<HCBookingData[]>(list);
            HCTestDetails[] lstTestCamp = oSerializer.Deserialize<HCTestDetails[]>(Testlist);
            if (lstCamp.Length > 0 && lstTestCamp.Length > 0)
            {
                foreach (var lst in lstCamp)
                {
                    foreach (var item in lstTestCamp)
                    {
                        if (lst.Id == item.Id)
                        {
                            entlstTestCamp = new HCBookingData();
                            entlstTestCamp.Id = lst.Id;
                            entlstTestCamp.OrgName = lst.OrgName;
                            entlstTestCamp.SlNo = lst.SlNo;
                            entlstTestCamp.OrgLocation = lst.OrgLocation;
                            entlstTestCamp.BookingDate = lst.BookingDate;
                            entlstTestCamp.PatientNumber = lst.PatientNumber;
                            entlstTestCamp.Title = lst.Title;
                            entlstTestCamp.PatientName = lst.PatientName;
                            entlstTestCamp.DOB = lst.DOB;
                            entlstTestCamp.Age = lst.Age;
                            entlstTestCamp.AgeType = lst.AgeType;
                            entlstTestCamp.Sex = lst.Sex;
                            entlstTestCamp.Pincode = lst.Pincode;
                            entlstTestCamp.Location = lst.Location;
                            entlstTestCamp.CollectionAddress = lst.CollectionAddress;
                            entlstTestCamp.CollectionDate = lst.CollectionDate;
                            entlstTestCamp.Technician = lst.Technician;
                            entlstTestCamp.Discount = lst.Discount;
                            entlstTestCamp.ClientCode = lst.ClientCode;
                            entlstTestCamp.MobileNo = lst.MobileNo;
                            entlstTestCamp.EmailID = lst.EmailID;
                            entlstTestCamp.DispatchMode = lst.DispatchMode;
                            entlstTestCamp.Remarks = lst.Remarks;
                            entlstTestCamp.RefDocName = lst.RefDocName;
                            entlstTestCamp.CreatedBy = lst.CreatedBy;
                            entlstTestCamp.CreatedbyId = lst.CreatedbyId;
                            entlstTestCamp.ClientID = lst.ClientID;
                            entlstTestCamp.LocationID = lst.LocationID;
                            entlstTestCamp.Salutation = lst.Salutation;
                            entlstTestCamp.ErrorStatus = lst.ErrorStatus;
                            entlstTestCamp.OrgID = lst.OrgID;
                            entlstTestCamp.SCollectedBy = lst.SCollectedBy;
                            entlstTestCamp.OrgLocationID = lst.OrgLocationID;
                            entlstTestCamp.TestCodes = item.TestCodes;
                            entlstTestCamp.ErrorDesc = item.ErrorDesc;
                            entlstTestCamp.TestCode = item.TestCode;                           
                            entlstTestCamp.TestType = item.TestType;
                            entlstTestCamp.FeeId = item.FeeId;                        
                            lstinsertCampDetail.Add(entlstTestCamp);
                        }
                    }
                }
            }
            returncode = new HomeCollections_BL(new BaseClass().ContextInfo).SaveBookingDetails(lstinsertCampDetail, out lstresult);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SaveBulkBookingDetails", ex);
        }
        finally
        {
        }
        return lstresult;
    }
}

