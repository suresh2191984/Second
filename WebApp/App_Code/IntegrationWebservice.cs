using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Xml;
using NCalc;
using System.IO;
using System.Text;
using System.Xml.Serialization;
using Attune.HL7Integration;
using OutBoundMsgBusinessLogic;
using System.Data;

/// <summary>
/// Summary description for IntegrationWebservice
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class IntegrationWebservice : System.Web.Services.WebService
{

    public IntegrationWebservice()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //[WebMethod]
    //public string HelloWorld()
    //{
    //    return "Hello World";
    //}


    ContextDetails objcontext = new ContextDetails();
    Patient_BL ObjPatient_BL = new Patient_BL();
    string[] Errorlist;
    string Error = string.Empty;
    string ErrorText = " Not Found";
    long CreatedBy = 0;
    OrderedInvestigations objOrderInv;
    string PhysicianName = string.Empty;
    StringWriter sw = new StringWriter();
    IntegrationHistory oHistory = new IntegrationHistory();
    List<IntegrationHistory> lstValue = new List<IntegrationHistory>();
    long HistoryID = 0;

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void OrderInvestigations(string xmlData, out string Response, string OrginalMessage)
    {
        List<OrderedInvestigations> lstOrdInv = new List<OrderedInvestigations>();
        Bookings oBooking = new Bookings();
        Response = string.Empty;
        string Reason = string.Empty;
        string Status = string.Empty;
        long returnCode = -1;
        int OrgId = 0;
        int OrgAddressID = 0;
        string OrgName = string.Empty;
        string LocationName = string.Empty;
        string Acknowledgement = string.Empty;
        long bookingID = 0;
        try
        {
            XmlDocument aml = new XmlDocument();
            aml.LoadXml(xmlData);
            XElement xelement = XElement.Parse(xmlData);
            GetLabDetails(xelement, out OrgName, out LocationName);
            GetOrgDetails(OrgName, LocationName, out OrgId, out OrgAddressID);
            GetBookingDetails(xelement, out oBooking, OrgId, OrgAddressID);
            GetOrderedInvestigationDetails(xelement, out lstOrdInv, OrgId, OrgAddressID);
            //GetLoginDetails(objHLMessage, out LoginId, out RoleId);
            objcontext = SetContextDetails(OrgId, "en-GB", OrgAddressID,0, 0);
            Schedule_BL sBL = new Schedule_BL(objcontext);
            SaveIntegrationHistory(xmlData, OrgId, oBooking.ReferalID, OrginalMessage);
            if (string.IsNullOrEmpty(Error))
            {
                returnCode = sBL.SaveServiceQuotationDetails(oBooking, lstOrdInv, OrgId, 0, out  bookingID);
                if (bookingID > 0)
                {
                    Acknowledgement = new IntegrationBL(objcontext).ResponseXml(HistoryID.ToString());
                    Reason = "";
                    Status = "Y";
                    Response = Acknowledgement;
                    returnCode = new IntegrationBL(objcontext).InsertIntegrationHistoryAck(HistoryID, Reason, Status, OrgId, OrgAddressID, Acknowledgement);

                }
            }
            else
            {
                if (!string.IsNullOrEmpty(Error))
                    Reason = Error + ErrorText;
                Response = new IntegrationBL(objcontext).ResponseFailureXml(Reason);
                Status = "N";
                returnCode = new IntegrationBL(objcontext).InsertIntegrationHistoryAck(HistoryID, Reason, Status, OrgId, OrgAddressID, Response);
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Getting OrderInvestigations() Method in Integrationservice-" + xmlData, Ex);
        }
    }
    private void GetOrgDetails(string OrgName, string LocationName, out int Orgid, out int OrgAddressId)
    {
        Orgid = 0;
        OrgAddressId = 0;
        long Returncode = 0;
        Patient_BL objPatientBL = new Patient_BL();
        List<Organization> objorgnaization = new List<Organization>();
        try
        {
            // patient.OrganizationID = OrgID;
            //patient.CreatedBy = LID;
            Returncode = objPatientBL.GetOrgDetails(OrgName, LocationName, out objorgnaization);
            if (objorgnaization.Count > 0)
            {
                if (objorgnaization[0].OrgID > 0 && objorgnaization[0].ReferTypeID > 0)
                {
                    Orgid = objorgnaization[0].OrgID;
                    OrgAddressId = Convert.ToInt32(objorgnaization[0].ReferTypeID);
                }
                else
                {
                    Adderror("OrgName or OrgAddressName");
                }
            }
            else
            {
                Adderror("OrgName or OrgAddressName");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetOrgDetails() Method in Integrationservice", ex);
        }
    }
    public void GetLabDetails(XElement xelement, out string OrgName, out string LocationName)
    {
        OrgName = string.Empty;
        LocationName = string.Empty;
        try
        {
            var XMLDetails = xelement.Descendants("data");
            int LabDetailsCount = xelement.Descendants("LabDetails").Count();
            if (LabDetailsCount > 0)
            {
                var PLabDetails = xelement.Descendants("LabDetails");
                foreach (var objPLabDetails in PLabDetails)
                {
                    if (objPLabDetails.Descendants("OrgName").Count() > 0 && objPLabDetails.Element("OrgName").Value.Length > 0)
                        OrgName = objPLabDetails.Element("OrgName").Value;
                    else
                        Adderror("OrgName");
                    if (objPLabDetails.Descendants("OrgAddressName").Count() > 0 && objPLabDetails.Element("OrgAddressName").Value.Length > 0)
                        LocationName = objPLabDetails.Element("OrgAddressName").Value;
                    else
                        Adderror("OrgAddressName");
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetLabDetails() Method in Integrationservice", ex);
        }
    }
    public void GetBookingDetails(XElement xelement, out Bookings oBookings, int Orgid, int Orgaddressid)
    {
        oBookings = new Bookings();
        string ClientCode = string.Empty;
        string RefPhyCode = string.Empty;
        var XMLDetails = xelement.Descendants("data");
        int PatientDetailsCount = xelement.Descendants("PatientDetails").Count();
        int AddressDetailsCount = xelement.Descendants("PatientAddress").Count();
        int VisitDetailsCount = xelement.Descendants("VisitDetails").Count();
        try
        {
            if (PatientDetailsCount > 0)
            {
                var PDetails = xelement.Descendants("PatientDetails");
                foreach (var objPDetails in PDetails)
                {
                    if (objPDetails.Descendants("PatientNumber").Count() > 0 && objPDetails.Element("PatientNumber").Value.Length > 0)
                        oBookings.PatientNumber = objPDetails.Element("PatientNumber").Value;
                    if (objPDetails.Descendants("Name").Count() > 0 && objPDetails.Element("Name").Value.Length > 0)
                        oBookings.PatientName = objPDetails.Element("Name").Value;
                    else
                        Adderror("Patient Name");

                    if (objPDetails.Descendants("Age").Count() > 0 && objPDetails.Element("Age").Value.Length > 0)
                        oBookings.Age = objPDetails.Element("Age").Value;
                    if (objPDetails.Descendants("Patient_Id_Int").Count() > 0 && objPDetails.Element("Patient_Id_Int").Value.Length > 0)
                        oBookings.NRICNumber = objPDetails.Element("Patient_Id_Int").Value;
                    if (objPDetails.Descendants("Patient_Id_Type").Count() > 0 && objPDetails.Element("Patient_Id_Type").Value.Length > 0)
                        oBookings.NRICType = objPDetails.Element("Patient_Id_Type").Value;
                    if (objPDetails.Descendants("Patient_Id_Number").Count() > 0 && objPDetails.Element("Patient_Id_Number").Value.Length > 0)
                        oBookings.ExternalPatientNo = objPDetails.Element("Patient_Id_Number").Value;

                    if (objPDetails.Descendants("DOB").Count() > 0 && objPDetails.Element("DOB").Value.Length > 0)
                    {
                        var PatDOB = objPDetails.Element("DOB").Value;
                        if (PatDOB != "")
                        {
                            string day = PatDOB.Substring(6, 2);
                            string month = PatDOB.Substring(4, 2);
                            string year = PatDOB.Substring(0, 4);
                            string date = day + "-" + month + "-" + year;
                            oBookings.DOB = Convert.ToDateTime(date);

                        }
                        // pDetails.DOB = Convert.ToDateTime(objPDetails.Element("DOB").Value);
                        if (string.IsNullOrEmpty(oBookings.Age))
                            oBookings.Age = CountAge(oBookings.DOB);
                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(oBookings.Age))
                        {
                            DateTime dob = DateTime.Now;
                            if (oBookings.Age.Split(' ').Length > 1)
                            {
                                string[] age = oBookings.Age.Split(' ');

                                dob = dob.AddYears(-(int.Parse(age[0])));
                            }
                            else
                                dob = dob.AddYears(-(int.Parse(oBookings.Age)));


                            oBookings.DOB = dob;

                        }

                    }
                    if (string.IsNullOrEmpty(oBookings.Age) && oBookings.DOB.Date.ToString("yyyy") == "0001")
                        Adderror("Age or Dob");

                    if (objPDetails.Descendants("Sex").Count() > 0 && objPDetails.Element("Sex").Value.Length > 0)
                        oBookings.SEX = objPDetails.Element("Sex").Value;
                    else
                        Adderror("sex");
                    if (objPDetails.Descendants("Title").Count() > 0 && objPDetails.Element("Title").Value.Length > 0)
                        oBookings.TITLECode = Convert.ToByte(objPDetails.Element("Title").Value);
                    else
                        Adderror("Title");

                    oBookings.OrgID = Orgid;
                    oBookings.OrgAddressID = Orgaddressid;
                }
            }
            else
                Adderror("Patient Details");
            if (AddressDetailsCount > 0)
            {
                var PADetails = xelement.Descendants("PatientAddress");
                foreach (var objPDetails in PADetails)
                {

                    //if (objPDetails.Descendants("AddressType").Count() > 0 && objPDetails.Element("AddressType").Value.Length > 0)
                    //    oBookings.a = objPDetails.Element("AddressType").Value;
                    if (objPDetails.Descendants("AddressLine1").Count() > 0 && objPDetails.Element("AddressLine1").Value.Length > 0)
                        oBookings.CollectionAddress = objPDetails.Element("AddressLine1").Value;
                    if (objPDetails.Descendants("AddressLine2").Count() > 0 && objPDetails.Element("AddressLine2").Value.Length > 0)
                        oBookings.CollectionAddress2 = objPDetails.Element("AddressLine2").Value;
                    if (objPDetails.Descendants("AddressLine3").Count() > 0 && objPDetails.Element("AddressLine3").Value.Length > 0)
                        oBookings.CollectionAddress2 += objPDetails.Element("AddressLine3").Value;
                    if (objPDetails.Descendants("MobileNo").Count() > 0 && objPDetails.Element("MobileNo").Value.Length > 0)
                        oBookings.PhoneNumber = objPDetails.Element("MobileNo").Value;
                    if (objPDetails.Descendants("LandLineNo").Count() > 0 && objPDetails.Element("LandLineNo").Value.Length > 0)
                        oBookings.LandLineNumber = objPDetails.Element("LandLineNo").Value;
                    if (objPDetails.Descendants("City").Count() > 0 && objPDetails.Element("City").Value.Length > 0)
                        oBookings.City = objPDetails.Element("City").Value;
                    //if (objPDetails.Descendants("StateID").Count() > 0 && objPDetails.Element("StateID").Value.Length > 0)
                    //    oBookings.sta = short.Parse(objPDetails.Element("StateID").Value);
                    //if (objPDetails.Descendants("StateName").Count() > 0 && objPDetails.Element("StateName").Value.Length > 0)
                    //    pAddress.StateName = objPDetails.Element("StateName").Value;
                    //if (objPDetails.Descendants("CountryID").Count() > 0 && objPDetails.Element("CountryID").Value.Length > 0)
                    //    pAddress.CountryID = short.Parse(objPDetails.Element("CountryID").Value);
                    //if (objPDetails.Descendants("CountryName").Count() > 0 && objPDetails.Element("CountryName").Value.Length > 0)
                    //    pAddress.CountryName = objPDetails.Element("CountryName").Value;
                    oBookings.CreatedBy = CreatedBy;
                }
            }
            if (VisitDetailsCount > 0)
            {
                var PDetails = xelement.Descendants("VisitDetails");
                foreach (var objPDetails in PDetails)
                {
                    if (objPDetails.Descendants("ExternalVisitID").Count() > 0 && objPDetails.Element("ExternalVisitID").Value.Length > 0)
                        oBookings.ReferalID = Convert.ToInt64(objPDetails.Element("ExternalVisitID").Value);
                    else
                        Adderror("ExternalVisitID");
                    ;
                    if (objPDetails.Descendants("CollectionCentreID").Count() > 0 && objPDetails.Element("CollectionCentreID").Value.Length > 0)
                        oBookings.TokenID = objPDetails.Element("CollectionCentreID").Value;
                    if (objPDetails.Descendants("ReferingPhysicianName").Count() > 0 && objPDetails.Element("ReferingPhysicianName").Value.Length > 0)
                    {
                        oBookings.RefPhysicianName = objPDetails.Element("ReferingPhysicianName").Value;
                    }
                    if (objPDetails.Descendants("ClientCode").Count() > 0 && objPDetails.Element("ClientCode").Value.Length > 0)
                    {
                        ClientCode = objPDetails.Element("ClientCode").Value;
                    }
                    if (objPDetails.Descendants("ReferingPhysicianName").Count() > 0 && objPDetails.Element("ReferingPhysicianName").Value.Length > 0)
                    {
                        RefPhyCode = objPDetails.Element("ReferingPhysicianName").Value;
                    }
                    if (!string.IsNullOrEmpty(ClientCode))
                    {
                        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
                        ObjPatient_BL.GetClientNamebyClientType(Orgid, ClientCode, 0, 0, out lstClientMaster);
                        if (lstClientMaster.Count > 0)
                        {
                            oBookings.ClientID = Convert.ToInt32(lstClientMaster[0].ClientID);
                        }

                    }
                    if (!string.IsNullOrEmpty(RefPhyCode))
                    {
                        //List<ClientMaster> lstClientMaster = new List<ClientMaster>();
                        //ObjPatient_BL.GetClientNamebyClientType(Orgid, ClientCode, 22, 22, out lstClientMaster);
                        oBookings.RefPhysicianName = RefPhyCode;
                    }

                    oBookings.SourceType = "Intregration";

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetBookingDetails() Method in Integrationservice", ex);
        }
    }

    public void GetOrderedInvestigationDetails(XElement xelement, out List<OrderedInvestigations> lstInv, int Orgid, int Orgaddressid)
    {
        lstInv = new List<OrderedInvestigations>();
        int InvestigationDetailsCount = xelement.Descendants("InvestigationDetails").Count();
        try
        {
            if (InvestigationDetailsCount > 0)
            {
                var invDetails = xelement.Descendants("InvestigationDetails");
                var inv = invDetails.Descendants("Investigation");
                if (inv.Count() > 0)
                {
                    foreach (var objInv in inv)
                    {
                        objOrderInv = new OrderedInvestigations();
                        if (objInv.Descendants("InvestigationID").Count() > 0 && objInv.Element("InvestigationID").Value.Length > 0)
                            objOrderInv.ID = Convert.ToInt64(objInv.Element("InvestigationID").Value);
                        else
                            Adderror("InvestigationID");
                        if (objInv.Descendants("Type").Count() > 0 && objInv.Element("Type").Value.Length > 0)
                        {
                            objOrderInv.Type = objInv.Element("Type").Value;
                        }
                        else
                            Adderror("Investigation Type");
                        if (objInv.Descendants("Name").Count() > 0 && objInv.Element("Name").Value.Length > 0)
                        {
                            objOrderInv.Name = objInv.Element("Name").Value;
                        }
                        else
                            Adderror("InvestigationName");
                        if (objInv.Descendants("OBR_Placer_Order_Number").Count() > 0 && objInv.Element("OBR_Placer_Order_Number").Value.Length > 0)
                        {
                            objOrderInv.InvestigationsType = objInv.Element("OBR_Placer_Order_Number").Value;
                        }
                        else
                            // Adderror("OBR_Placer_Order_Number");
                        objOrderInv.Status = "Ordered";
                        objOrderInv.OrgID = Orgid;
                        lstInv.Add(objOrderInv);

                    }
                }

            }

            else
                Adderror("InvestigationDetails");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetOrderedInvestigationDetails() Method in Integrationservice", ex);
        }
    }
    private ContextDetails SetContextDetails(int OrgId, string LanguageCode, int LocationId, int RoleId, long LoginId)
    {
        ContextDetails objcontext = new ContextDetails();
        try
        {
            objcontext.OrgID = OrgId;
            objcontext.LoginID = LoginId;
            objcontext.LanguageCode = LanguageCode;
            objcontext.LocationID = LocationId;
            objcontext.RoleID = RoleId;
            objcontext.LoginID = LoginId;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting SetContextDetails() Method in Integrationservice", ex);
        }
        return objcontext;
    }
    public void Adderror(string tag)
    {
        if (Error != "")
        {
            Error += "," + tag;
        }
        else
        {
            Error = tag;
        }
    }
    private string CountAge(DateTime DOB)
    {

        string Returnage = string.Empty;
        string[] bD = null;
        int dd;
        int mm;
        int yy;
        string main;
        var m = 0;
        var n = 0;
        var p = 0;
        try
        {
            bD = DOB.ToString().Substring(0, 10).Split('/');
            var agetemp = 0;
            Int32.TryParse(bD[0], out dd);
            Int32.TryParse(bD[1], out mm);
            Int32.TryParse(bD[2], out yy);
            main = "valid";
            if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1))
                main = "Invalid";
            else
                if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
                    main = "Invalid";
                else
                    if (mm == 2)
                    {
                        if (dd > 29)
                            main = "Invalid";
                        else if ((dd > 28) && (!leapyear(yy)))
                            main = "Invalid";
                    }
                    else
                        if ((yy > 9999) || (yy < 0))
                            main = "Invalid";

            DateTime today = DateTime.Now;
            int gdate = today.Day;
            int gmonth = today.Month;
            int gyear = today.Year;
            int age = (gyear - yy);
            //if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
            //    age = age;
            //}
            //else {
            //    if (mm <= (gmonth)) {
            //        age = age;
            //    }
            //    //else {
            //    //  age = age - 1;
            //    //}
            //}
            if (age == 0)
                agetemp = age;
            if (mm <= (gmonth + 1))
                age = age - 1;
            if ((mm == (gmonth + 1)) && (dd > gdate))
                age = age + 1;

            if (mm == 12) { n = 31 - dd; }
            if (mm == 11) { n = 61 - dd; }
            if (mm == 10) { n = 92 - dd; }
            if (mm == 9) { n = 122 - dd; }
            if (mm == 8) { n = 153 - dd; }
            if (mm == 7) { n = 184 - dd; }
            if (mm == 6) { n = 214 - dd; }
            if (mm == 5) { n = 245 - dd; }
            if (mm == 4) { n = 275 - dd; }
            if (mm == 3) { n = 306 - dd; }
            if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
            if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
            if (gmonth == 1) m = 31;
            if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
            int totdays = (Convert.ToInt32(age) * 365);
            totdays += Convert.ToInt32(age) / 4;
            totdays = totdays + gdate + m + n;
            int months = Convert.ToInt32(age) * 12;
            var t = mm;
            months += 12 - mm;
            months += gmonth + 1;
            if (gmonth == 1) p = 31 + gdate;
            if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
            if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
            if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
            int week = totdays / 7;
            string weeks = week + " weeks";
            if (agetemp <= 0)
            {
                if (months <= 0)
                {
                    if (week <= 0)
                    {
                        if (totdays >= 0)
                        {
                            Returnage = totdays + " " + "Day(s)";
                        }
                    }

                    else
                    {
                        Returnage = weeks;
                    }
                }
                else
                {
                    Returnage = months + " " + "Month(s)";
                    if (months > 11)
                    {
                        Returnage = Math.Round(months / 12.0) + " " + "Year(s)";
                    }
                }
            }
            else
            {
                Returnage = agetemp + " " + "Year(s)";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting CountAge() Method in Integrationservice", ex);
        }

        return Returnage;

    }
    private bool leapyear(int a)
    {
        if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
        { return true; }
        else
        { return false; }
    }
    public string ResponseFailureXml(string error)
    {
        try
        {
            XmlDocument doc = new XmlDocument();
            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-16", null);
            doc.AppendChild(docNode);
            XmlNode responseNode = doc.CreateElement("Response");
            doc.AppendChild(responseNode);
            XmlNode integrationIDNode = doc.CreateElement("Error");
            integrationIDNode.AppendChild(doc.CreateTextNode(error));
            responseNode.AppendChild(integrationIDNode);
            XmlNode statusNode = doc.CreateElement("Status");
            statusNode.AppendChild(doc.CreateTextNode("1"));
            responseNode.AppendChild(statusNode);
            XmlTextWriter tw = new XmlTextWriter(sw);
            doc.WriteTo(tw);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting ResponseFailureXml() Method in Integrationservice", ex);
        }
        return sw.ToString();


    }
    public void SaveIntegrationHistory(string xmlData, int OrgId, long ExternalVisitID, string OrginalMessage)
    {
        try
        {
            long returnCode = -1;
            XmlDocument doc = new XmlDocument();
            //  XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            doc.LoadXml(xmlData);
            //XmlElement root = doc.DocumentElement;
            //doc.InsertBefore(docNode, root);
            sw = new StringWriter();
            XmlTextWriter tw = new XmlTextWriter(sw);
            doc.WriteTo(tw);

            //  string xmlcontent = ConvertXml(pDetails, pAddress, pVisit, lInvestigationList);
            string xmlcontent = sw.ToString();


            Attune.Podium.Common.CLogger.LogWarning("ExterVisitID:" + ExternalVisitID + "VisitType :" + "Integration");
            if (!string.IsNullOrEmpty(xmlcontent.ToString()))
            {
                oHistory.IntegrationValue = OrginalMessage.ToString();
                oHistory.OrgID = OrgId;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = ExternalVisitID.ToString();
                oHistory.Type = "JMC";
                oHistory.XMLType = "InBound";
                lstValue.Add(oHistory);
            }

            returnCode = new IntegrationBL().SaveIntegrationHistory(lstValue, out HistoryID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting SaveIntegrationHistory() Method in Integrationservice", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void LISIntegration(string xmlData, out string Response)
    {
        //Response = string.Empty;
        //string XMl = xmlData;
        //XElement xelement;
        //XmlDocument xdoc = new XmlDocument();
        //xdoc.LoadXml(XMl);
        //XmlDocument xdoc1 = new XmlDocument();
        //xdoc1.LoadXml(xdoc.InnerText);
        //xdoc1.GetElementsByTagName("data");
        //XElement Elemet = XElement.Parse(XMl);
        //XDocument xDoc = XDocument.Load(new StringReader(XMl));
        //string strxdoc = xdoc.InnerText.ToString();
        //StringBuilder sb = new StringBuilder();
        //sb.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        //sb.Append(strxdoc);
        //strxdoc = sb.ToString();
        //xelement = XElement.Parse(strxdoc);

        //int msgHeaderCount = xelement.Descendants("MSH").Count();



        //string OrgName1 = string.Empty;
        //string LocationName1 = string.Empty;
        //data d = new data();
        //if (msgHeaderCount > 0)
        //{
        //    var PLabDetails = xelement.Descendants("MSH");
        //    foreach (var PDetails in PLabDetails)
        //    {
        //        if (PLabDetails.Descendants("Recv_Application").Count() > 0)
        //            OrgName1 = PDetails.Element("Recv_Application").Value;
        //        if (PLabDetails.Descendants("Recv_Facility").Count() > 0)
        //            LocationName1 = PDetails.Element("Recv_Facility").Value;

        //    }

        //    d.LabDetails.OrgName = OrgName1;
        //    d.LabDetails.OrgAddressName = LocationName1;
        //}
        //string Patient_UHID = string.Empty;
        //string Patient_fname = string.Empty;
        //string Patient_Sex = string.Empty;
        //DateTime Patient_DOB = DateTime.MaxValue;
        //int PatientHeader = xelement.Descendants("PID").Count();
        //if (PatientHeader > 0)
        //{
        //    var PatDetailss = xelement.Descendants("PID");
        //    foreach (var PDetailss in PatDetailss)
        //    {
        //        if (PatDetailss.Descendants("Patient_UHID").Count() > 0)
        //        {
        //            Patient_UHID = PDetailss.Element("Patient_UHID").Value;
        //        }


        //        if (PatDetailss.Descendants("Patient_fname").Count() > 0)
        //        {
        //            Patient_fname = PDetailss.Element("Patient_fname").Value;
        //        }

        //        if (PatDetailss.Descendants("Patient_Sex").Count() > 0)
        //        {
        //            Patient_Sex = PDetailss.Element("Patient_Sex").Value;
        //        }
        //        string date;
        //        if (PatDetailss.Descendants("Patient_DOB").Count() > 0)
        //        {
        //            var PatDOB = PDetailss.Element("Patient_DOB").Value;
        //            if (PatDOB != "")
        //            {
        //                string day = PatDOB.Substring(6, 2);
        //                string month = PatDOB.Substring(4, 2);
        //                string year = PatDOB.Substring(0, 4);
        //                date = day + "/" + month + "/" + year;
        //                Patient_DOB = Convert.ToDateTime(date);
        //                d.PatientDetails.DOB = PatDOB;
        //            }
        //        }
        //    }

        //    d.PatientDetails.Title = "0";
        //    d.PatientDetails.PatientNumber = Patient_UHID;
        //    d.PatientDetails.Name = Patient_fname;
        //    //d.PatientDetails.DOB = Patient_DOB;
        //    d.PatientDetails.Sex = Patient_Sex;
        //}
        //int VisitDetails = xelement.Descendants("PV1").Count();
        //string ExternalVisitID = string.Empty;
        //string CollectionCentreID = string.Empty;
        //if (VisitDetails > 0)
        //{
        //    var VisitDetailselement = xelement.Descendants("PV1");
        //    foreach (var VtDetail in VisitDetailselement)
        //    {
        //        if (VisitDetailselement.Descendants("Visit_Number").Count() > 0)
        //        {
        //            CollectionCentreID = VtDetail.Element("Visit_Number").Value;
        //        }
        //    }

        //    d.VisitDetails.CollectionCentreID = CollectionCentreID;
        //}
        //int VisitDetails1 = xelement.Descendants("ORC").Count();
        //string ClientCode = string.Empty;
        //if (VisitDetails1 > 0)
        //{
        //    var VisitDetails1elemet = xelement.Descendants("ORC");
        //    foreach (var VDetails1elemet in VisitDetails1elemet)
        //    {
        //        if (VisitDetails1elemet.Descendants("Placer_Order_Number").Count() > 0)
        //        {
        //            ExternalVisitID = VDetails1elemet.Element("Placer_Order_Number").Value;
        //        }

        //        if (VisitDetails1elemet.Descendants("Entered_By").Count() > 0)
        //        {
        //            ClientCode = VDetails1elemet.Element("Entered_By").Value;
        //        }
        //    }


        //    d.VisitDetails.ClientCode = ClientCode;
        //    d.VisitDetails.ExternalVisitID = ExternalVisitID;
        //}
        //int ObservationRequest = xelement.Descendants("ObservationRequest").Count();
        //string grpName = string.Empty;
        //List<data> lstdata = new List<data>();
        //data d2 = new data();
        //List<DischargeInvNotes> lstinvMaster = new List<DischargeInvNotes>();
        //DischargeInvNotes lstInvNote;
        ////s lstInvNote = new DischargeInvNotes();
        //if (ObservationRequest > 0)
        //{
        //    var ObservationRequestElemet = xelement.Descendants("ObservationRequest");
        //    foreach (var objOR in ObservationRequestElemet)
        //    {
        //        foreach (var objOBR in objOR.Descendants("OBR"))
        //        {
        //            lstInvNote = new DischargeInvNotes();
        //            grpName = objOBR.Element("Order_Service_Identifier").Value;
        //            lstInvNote.DischargeInvNotesID = 0;
        //            lstInvNote.InvestigationDetails = grpName;
        //            lstinvMaster.Add(lstInvNote);
        //        }

        //    }


        //}
        //long Returncode = -1;


        //List<OrderedInvestigations> objlstOrdinv = new List<OrderedInvestigations>();
        //if (lstinvMaster.Count > 0)
        //{
        //    Returncode = new Investigation_BL().GetInvestigationList(lstinvMaster, 69, out objlstOrdinv);

        //}

        //d.InvestigationDetails =
        //             (from observation in objlstOrdinv
        //              select new Attune.HL7Integration.Investigation
        //              {
        //                  InvestigationID = observation.ID,
        //                  Name = observation.Name,
        //                  Type = observation.Type
        //              }).ToList();




        //XmlSerializer xsSubmit = new XmlSerializer(typeof(data));

        //XmlDocument doc = new XmlDocument();
        //System.IO.StringWriter sww = new System.IO.StringWriter();
        //XmlWriter writer = XmlWriter.Create(sww);
        //xsSubmit.Serialize(writer, d);
        //string XMLLL = sww.ToString();
        //string XmlConvertResponse = string.Empty;
        //OrderInvestigations(XMLLL, out Response);
        //XmlConvertResponse = Response;


        Response = string.Empty;
        string XMl = xmlData;
        string OrginalMessage = xmlData;
        XElement xelement;
        try
        {

            XmlDocument sdoc;
            GetXmlDocumentFromString(xmlData, out sdoc);
        XmlDocument xdoc222 = new XmlDocument();
        //xdoc222.LoadXml(XMl);
        XmlDocument xdoc1 = new XmlDocument();
        //xdoc1.LoadXml(xdoc222.InnerXml);
        xdoc222 = sdoc;
        XmlNodeList elemList = xdoc222.GetElementsByTagName("arg0");
        //xdoc222.GetElementsByTagName("arg0");
        string str = xdoc222.InnerXml.ToString();
        //XElement Elemet = XElement.Parse(XMl);
        XDocument xDoc = XDocument.Load(new StringReader(elemList[0].InnerXml));
        string strxdoc = xDoc.ToString();
        StringBuilder sb = new StringBuilder();          
        sb.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        sb.Append(strxdoc);
        strxdoc = sb.ToString();
        xelement = XElement.Parse(strxdoc);

        int msgHeaderCount = xelement.Descendants("MSH").Count();



        string OrgName1 = string.Empty;
        string LocationName1 = string.Empty;
        data d = new data();
        if (msgHeaderCount > 0)
        {
            var PLabDetails = xelement.Descendants("MSH");
            foreach (var PDetails in PLabDetails)
            {
                if (PLabDetails.Descendants("Sending_Application").Count() > 0)
                    OrgName1 = PDetails.Element("Sending_Application").Value;
                if (PLabDetails.Descendants("Sending_Facility").Count() > 0)
                    LocationName1 = PDetails.Element("Sending_Facility").Value;
               // OrgName1 = "IGENETIC Diagnostics Pvt. Ltd.";
                ///LocationName1 = "Andheri";

            }

            d.LabDetails.OrgName = OrgName1;
            d.LabDetails.OrgAddressName = LocationName1;
        }
        string Patient_UHID = string.Empty;
        string Patient_fname = string.Empty;
        string Patient_Sex = string.Empty;
        DateTime Patient_DOB = DateTime.MaxValue;
        int PatientHeader = xelement.Descendants("PID").Count();
        string Patient_Id_Int = string.Empty;
        string Patient_Id_Type = string.Empty;
        string Patient_Id_Number = string.Empty;
        string Phone_Home = string.Empty;
        string Phone_Mobile = string.Empty;
        var PatDOB = "";
        if (PatientHeader > 0)
        {
            var PatDetailss = xelement.Descendants("PID");
            foreach (var PDetailss in PatDetailss)
            {
                if (PatDetailss.Descendants("Patient_UHID").Count() > 0)
                {
                    Patient_UHID = PDetailss.Element("Patient_UHID").Value;
                }

                if (PatDetailss.Descendants("Patient_Id_Int").Count() > 0)
                {
                    Patient_Id_Int = PDetailss.Element("Patient_Id_Int").Value;
                }

                if (PatDetailss.Descendants("Patient_Id_Type").Count() > 0)
                {
                    Patient_Id_Type = PDetailss.Element("Patient_Id_Type").Value;
                }

                if (PatDetailss.Descendants("Patient_Id_Number").Count() > 0)
                {
                    Patient_Id_Number = PDetailss.Element("Patient_Id_Number").Value;
                }
                if (PatDetailss.Descendants("Patient_Name").Count() > 0)
                {
                    Patient_fname = PDetailss.Element("Patient_Name").Value;
                }

                if (PatDetailss.Descendants("Gender_Code").Count() > 0)
                {
                    Patient_Sex = PDetailss.Element("Gender_Code").Value;
                }

                if (PatDetailss.Descendants("Date_Of_Birth").Count() > 0)
                {
                    PatDOB = PDetailss.Element("Date_Of_Birth").Value;
                    if (PatDOB != "")
                    {
                        string day = PatDOB.Substring(6, 2);
                        string month = PatDOB.Substring(4, 2);
                        string year = PatDOB.Substring(0, 4);
                        string date = day + "/" + month + "/" + year;
                        Patient_DOB = Convert.ToDateTime(date);
                    }

                }
                if (PatDetailss.Descendants("Phone_Home").Count() > 0)
                {
                    Phone_Home = PDetailss.Element("Phone_Home").Value;
                }
                if (PatDetailss.Descendants("Phone_Mobile").Count() > 0)
                {
                    Phone_Mobile = PDetailss.Element("Phone_Mobile").Value;
                }
            }

            d.PatientDetails.Patient_Id_Int = Patient_Id_Number;
            d.PatientDetails.Patient_Id_Number = Patient_Id_Int;
            d.PatientDetails.Patient_Id_Type = Patient_Id_Type;
            d.PatientDetails.PatientNumber = Patient_UHID;
            d.PatientDetails.Name = Patient_fname;
            d.PatientDetails.DOB = PatDOB;
            d.PatientDetails.Sex = Patient_Sex;
            d.PatientDetails.Title = "0";
            d.PatientAddress.LandLineNo = Phone_Home;
            d.PatientAddress.MobileNo = Phone_Mobile;
            
        }
        int VisitDetails = xelement.Descendants("PV1").Count();
        string ExternalVisitID = string.Empty;
        string CollectionCentreID = string.Empty;
        string RefPhyCode = string.Empty;
        string ClientCode = string.Empty;
        if (VisitDetails > 0)
        {
            var VisitDetailselement = xelement.Descendants("PV1");
            foreach (var VtDetail in VisitDetailselement)
            {
                if (VisitDetailselement.Descendants("Visit_Number").Count() > 0)
                {
                    CollectionCentreID = VtDetail.Element("Visit_Number").Value;
                }
                if (VisitDetailselement.Descendants("Admitting_Doctor_Code").Count() > 0)
                {
                    RefPhyCode = VtDetail.Element("Admitting_Doctor_Code").Value;
                }
                if (VisitDetailselement.Descendants("Ward_Code").Count() > 0)
                {
                    ClientCode = VtDetail.Element("Ward_Code").Value;
                }
            }
            d.VisitDetails.ReferingPhysicianName = RefPhyCode;
            d.VisitDetails.ClientCode = ClientCode;
            //d.VisitDetails.CollectionCentreID = CollectionCentreID;
        }
        int VisitDetails1 = xelement.Descendants("ORC").Count();
         string Order_Control = string.Empty;
        if (VisitDetails1 > 0)
        {
            var VisitDetails1elemet = xelement.Descendants("ORC");
            foreach (var VDetails1elemet in VisitDetails1elemet)
            {
                if (VisitDetails1elemet.Descendants("Placer_Order_Number").Count() > 0)
                {
                    ExternalVisitID = VDetails1elemet.Element("Placer_Order_Number").Value;
                }
                if (VisitDetails1elemet.Descendants("ORC_Placer_Order_Number").Count() > 0)
                {
                    CollectionCentreID = VDetails1elemet.Element("ORC_Placer_Order_Number").Value;
                }
                if (VisitDetails1elemet.Descendants("Entered_By").Count() > 0)
                {
                    ClientCode = VDetails1elemet.Element("Entered_By").Value;
                }
                    if (VisitDetails1elemet.Descendants("Order_Control").Count() > 0)
                    {
                        Order_Control = VDetails1elemet.Element("Order_Control").Value;
                    }
                }

            d.VisitDetails.CollectionCentreID = CollectionCentreID;
            d.PatientAddress.AddressLine1 = Order_Control;
            
            // d.VisitDetails.ClientCode = ClientCode;
            if (ExternalVisitID == "")
            {
                d.VisitDetails.ExternalVisitID = ExternalVisitID;
            }
            else
            {
                d.VisitDetails.ExternalVisitID = "0";
            }
            d.VisitDetails.ExternalVisitID = "0";
        }
        int ObservationRequest = xelement.Descendants("OBR").Count();
        string grpName = string.Empty;
        List<data> lstdata = new List<data>();
        data d2 = new data();
        List<DischargeInvNotes> lstinvMaster = new List<DischargeInvNotes>();
        DischargeInvNotes lstInvNote;
        //s lstInvNote = new DischargeInvNotes();
        string OBR_Placer_Order_Number = string.Empty;
        if (ObservationRequest > 0)
        {
            var ObservationRequestElemet = xelement.Descendants("OBR");
            foreach (var objOR in xelement.Descendants("OBR"))
            {

                lstInvNote = new DischargeInvNotes();
                grpName = objOR.Element("Test_Code").Value;
                OBR_Placer_Order_Number = objOR.Element("OBR_Placer_Order_Number").Value;
                lstInvNote.DischargeInvNotesID = 0;
                lstInvNote.InvestigationDetails = grpName;
                lstInvNote.Type = OBR_Placer_Order_Number;
                lstinvMaster.Add(lstInvNote);


            }


        }
        long Returncode = -1;
        int OrgId;
        int OrgAddressID;
        GetOrgDetails(OrgName1, LocationName1, out OrgId, out OrgAddressID);
        List<OrderedInvestigations> objlstOrdinv = new List<OrderedInvestigations>();
        if (lstinvMaster.Count > 0)
        {
            Returncode = new Investigation_BL().GetInvestigationList(lstinvMaster, OrgId, out objlstOrdinv);

        }

        d.InvestigationDetails =
                     (from observation in objlstOrdinv
                      select new Attune.HL7Integration.Investigation
                      {
                          InvestigationID = observation.ID,
                          Name = observation.Name,
                          Type = observation.Type,
                           OBR_Placer_Order_Number = observation.Migrated_TestCode
                      }).ToList();




        XmlSerializer xsSubmit = new XmlSerializer(typeof(data));

        XmlDocument doc = new XmlDocument();
        System.IO.StringWriter sww = new System.IO.StringWriter();
        XmlWriter writer = XmlWriter.Create(sww);
        xsSubmit.Serialize(writer, d);
        string XMLLL = sww.ToString();
        string XmlConvertResponse = string.Empty;
        OrderInvestigations(XMLLL, out Response, OrginalMessage);
        XmlConvertResponse = Response;

    }
        catch (Exception EX)
        {

            throw;
        }

    }
    XmlDocument GetXmlDocumentFromString(string xml, out XmlDocument doc1)
    {
        doc1 = new XmlDocument();
        var doc = new XmlDocument();
        //XmlDocument doc1 = new XmlDocument() ;
        using (var sr = new StringReader(xml))
        using (var xtr = new XmlTextReader(sr) { Namespaces = false })
            doc1.Load(xtr);

        return doc1;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Hl7OutBoundMessageDetails> GetApprovedReportNotification(int OrgID, string Status)
    {
        long result = -1;
        List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails = new List<Hl7OutBoundMessageDetails>();
        OutBoundMsg_BL Inv_BL = new OutBoundMsg_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.GetApprovedDataForOutBound(OrgID, Status, out lstHl7OutBoundMessageDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetApprovedReportList:", ex);
        }
        return lstHl7OutBoundMessageDetails;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillDetails> BillDetails(int OrgID, long PatientVisitID, out List<BillDetails> bdetils)
    {
        long result = -1;
        bdetils = new List<BillDetails>();
        Patient_BL pBL = new Patient_BL();
        result=pBL.WGetBillDetails(OrgID, PatientVisitID, out bdetils);
        return bdetils;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long UpdateWortixNotifications(List<OutBillDetails> lstOutBillDetails,String Msg)
    {
        long result = -1;
        //bdetils = new List<BillDetails>();
        Patient_BL pBL = new Patient_BL();
        if (lstOutBillDetails[0].complete == "true")
        {
        }
        result = pBL.WUpdateNotifications(lstOutBillDetails[0].data.Client_id, Convert.ToInt32(lstOutBillDetails[0].data.Facility_id), Msg);
        //result = pBL.WUpdateNotifications(lstOutBillDetails.data[0].Client_id, Convert.ToInt32(lstOutBillDetails[0].data[0].Facility_id), Msg);
        return result;

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void XMlGenerator(int OrgID, long PatientVisitID, long AccessionNumber, string Status, out string ResultXML)
    {

        OutBoundMsg_BL outbl = new OutBoundMsg_BL();
        List<MSH> lstMsh = new List<MSH>();
        List<EVN> lstEvn = new List<EVN>();
        List<PID> lstPID = new List<PID>();
        List<PV1> lstPV1 = new List<PV1>();
        List<ORC> lstORC = new List<ORC>();
        List<OBR> lstOBR = new List<OBR>();
        List<OBX> lstOBX = new List<OBX>();
        outbl.GetOrderedApprovedDetailsForOutBound(OrgID, PatientVisitID, AccessionNumber, Status, out lstMsh, out lstEvn, out lstPID, out lstPV1, out lstORC, out lstOBR, out lstOBX);

        XmlSerializer xsSubmit = new XmlSerializer(typeof(content));
        content Con = new content();

        Con.MSG.MSH11 = (from a in lstMsh
                         select new MSH
                         {
                             Sending_Application = a.Sending_Application,
                             Sending_Facility = a.Sending_Facility,
                             Receiving_Application = a.Receiving_Application,
                             Receiving_Facility = a.Receiving_Facility,
                             Message_Date_Time = a.Message_Date_Time,
                             Message_Type = a.Message_Type,
                             Message_Control_Id = a.Message_Control_Id
                         }).ToList();
        Con.MSG.EVN11 = (from b in lstEvn
                         select new EVN
                         {
                             Event_Type_Code = b.Event_Type_Code,
                             Recorded_DateTime = b.Recorded_DateTime
                         }).ToList();


        Con.MSG.PID11 = (from observation in lstPID
                         select new PID
                         {
                             Patient_Id_Int = observation.Patient_Id_Int,
                             Patient_Id_Ext = observation.Patient_Id_Ext,
                             Patient_Id_Number = observation.Patient_Id_Number,
                             Patient_Id_Type = observation.Patient_Id_Type,
                             Patient_Name = observation.Patient_Name,
                             Date_Of_Birth = observation.Date_Of_Birth,
                             Gender_Code = observation.Gender_Code,
                             Race_code = observation.Race_code,
                             Address1 = observation.Address1,
                             Address2 = observation.Address2,
                             Address3 = observation.Address3,
                             City = observation.City,
                             State = observation.State,
                             Postal_Code = observation.Postal_Code,
                             Country_Code = observation.Country_Code,
                             Phone_Home = observation.Phone_Home,
                             Phone_Mobile = observation.Phone_Mobile,
                             Phone_Business = observation.Phone_Business,
                             Primary_Language = observation.Primary_Language,
                             Marital_Status_Code = observation.Marital_Status_Code,
                             Religion_Code = observation.Religion_Code,
                             Nationality_Code = observation.Nationality_Code
                         }).ToList();

        Con.MSG.PV111 = (from C in lstPV1
                         select new PV1
                         {
                             Patient_Type_Code = C.Patient_Type_Code,
                             Ward_Code = C.Ward_Code,
                             Admission_Type = C.Admission_Type,
                             Preadmit_Number = C.Preadmit_Number,
                             Specialty_Code = C.Specialty_Code,
                             Attending_Doctor_Code = C.Attending_Doctor_Code,
                             Attending_Doctor_Desc = C.Attending_Doctor_Desc,
                             Referring_Doctor_Code = C.Referring_Doctor_Code,
                             Referring_Doctor_Desc = C.Referring_Doctor_Desc,
                             Consulting_Doctor_Code = C.Consulting_Doctor_Code,
                             Consulting_Doctor_Desc = C.Consulting_Doctor_Desc,
                             Admitting_Doctor_Code = C.Admitting_Doctor_Code,
                             Admitting_Doctor_Desc = C.Admitting_Doctor_Desc,
                             Patient_Class = C.Patient_Class,
                             Visit_Number = C.Visit_Number,
                             Financial_Class_Code = C.Financial_Class_Code,
                             Admit_DateTime = C.Admit_DateTime

                         }
                            ).ToList();

        Con.MSG.ORC11 = (from d in lstORC
                         select new ORC
                         {
                             Order_Control = d.Order_Control,
                             ORC_Placer_Order_Number = d.ORC_Placer_Order_Number,
                             ORC_Filler_Order_Number = d.ORC_Filler_Order_Number,
                             Placer_Group_Number = d.Placer_Group_Number,
                             Order_Status_Code = d.Order_Status_Code,
                             Response_Flag = d.Response_Flag,
                             ORC_Quantity_Timing = d.ORC_Quantity_Timing,
                             Parent = d.Parent,
                             DateTime_Of_Transaction = d.DateTime_Of_Transaction,
                             Entered_By_ID = d.Entered_By_ID,
                             Entered_By_Name = d.Entered_By_Name,
                             Verified_By_ID = d.Verified_By_ID,
                             Verified_By_Name = d.Verified_By_Name,
                             ORC_Ordering_Provider_ID = d.ORC_Ordering_Provider_ID,
                             ORC_Ordering_Provider_Name = d.ORC_Ordering_Provider_Name,
                             Enter_Location = d.Enter_Location,
                             Call_Back_Phone_Number = d.Call_Back_Phone_Number,
                             Order_Effective_DateTime = d.Order_Effective_DateTime,
                             Order_Control_Code_Reason = d.Order_Control_Code_Reason,
                             Entering_Organization = d.Entering_Organization,
                             Entering_Device = d.Entering_Device,
                             Action_By = d.Action_By,
                             Advanced_Beneficiary_Notice_Code = d.Advanced_Beneficiary_Notice_Code,
                             Ordering_Facility_Code = d.Ordering_Facility_Code,
                             Ordering_Facility_Name = d.Ordering_Facility_Name
                         }).ToList();

        Con.MSG.Observation_Request.OBR11 = (from F in lstOBR
                                             select new OBR
                                             {
                                                 Set_Id_OBR = F.Set_Id_OBR,
                                                 OBR_Placer_Order_Number = F.OBR_Placer_Order_Number,
                                                 OBR_Filler_Order_Number = F.OBR_Filler_Order_Number,
                                                 Package_Code = F.Package_Code,
                                                 Package_Description = F.Package_Description,
                                                 Test_Code = F.Test_Code,
                                                 Test_Name = F.Test_Name,
                                                 Priority_Code = F.Priority_Code,
                                                 Requested_DateTime = F.Requested_DateTime,
                                                 Observation_DateTime = F.Observation_DateTime,
                                                 Observation_End_DateTime = F.Observation_End_DateTime,
                                                 Specimen_Received_DateTime = F.Specimen_Received_DateTime,
                                                 Specimen_Source_Code = F.Specimen_Source_Code,
                                                 Specimen_Source_Desc = F.Specimen_Source_Desc,
                                                 OBR_Ordering_Provider_ID = F.OBR_Ordering_Provider_ID,
                                                 OBR_Ordering_Provider_Name = F.OBR_Ordering_Provider_Name,
                                                 Placer_Field1 = F.Placer_Field1,
                                                 Placer_Field2 = F.Placer_Field2,
                                                 Filler_Field1 = F.Filler_Field1,
                                                 Filler_Field2 = F.Filler_Field2,
                                                 Status_Change_DateTime = F.Status_Change_DateTime,
                                                 Charge_To_Practice = F.Charge_To_Practice,
                                                 Diagnostic_Serv_Sect_Code = F.Diagnostic_Serv_Sect_Code,
                                                 Diagnostic_Serv_Sect_Desc = F.Diagnostic_Serv_Sect_Desc,
                                                 Parent_Result = F.Parent_Result,
                                                 OBR_Quantity_Timing = F.OBR_Quantity_Timing,
                                                 Unit_Code = F.Unit_Code,
                                                 Cancel_Reason_Code = F.Cancel_Reason_Code,
                                                 Cancel_Reason_Desc = F.Cancel_Reason_Desc

                                             }).ToList();
        if (Status != "SampleReceived"  && Status != "Rejected")
        {


            Con.MSG.Observation_Request.Observation.OBX11 = (from p in lstOBX
                                                             select new OBX
                                                             {
                                                                 SET_ID = p.SET_ID,
                                                                 Observation_Value_Type = p.Observation_Value_Type,
                                                                 Observation_Identifier = p.Observation_Identifier,
                                                                 Observation_Value = p.Observation_Value,
                                                                 ObservationResultsStatus = p.ObservationResultsStatus,
                                                                 Observation_Date_Time = p.Observation_Date_Time,
                                                                 Units = p.Units,
                                                                 ReferenceRange = p.ReferenceRange,
                                                                 MedicalRemarks = p.MedicalRemarks,
                                                                 IsAbnormalflag = p.IsAbnormalflag
                                                             }).ToList();
        }
        XmlDocument doc = new XmlDocument();
        System.IO.StringWriter sww = new System.IO.StringWriter();
       
        XmlWriter writer = XmlWriter.Create(sww);
        xsSubmit.Serialize(writer, Con);
        string XMLLL = sww.ToString();
        string s = XMLLL.ToString();
        
        string val = GetConfigValues("Need Utf-8/Utf-16 encoding", OrgID);
        if (val != "")
        {
           // s = s.Replace("<?xml version=\"1.0\" encoding=\"utf-16\"?>", "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            s = s.Replace("<?xml version=\"1.0\" encoding=\"utf-16\"?>", "<?xml version=\"1.0\" encoding=\"" + val + "\"?>");
        }

        string VisitDetails = lstPID[0].Address3;
        string VisitNumber = string.Empty;
        string ClinickCode = string.Empty;
        string LastUpdate = string.Empty;
        if (lstPID[0].Address3 != "")
        {
            VisitNumber = lstPID[0].Address3.Split('_')[0];
            ClinickCode = lstPID[0].Address3.Split('_')[1];
            LastUpdate = lstPID[0].Address3.Split('_')[2];

            string ClinickSys = "";

            ClinickSys = "<VN>" + VisitNumber + "</VN><OrgId>" + ClinickCode + "</OrgId><LastUpdate>" + LastUpdate + "</LastUpdate>";
        }
        s = s.Replace("<MSH11>", "");
        s = s.Replace("</MSH11>", "");
        s = s.Replace("<MSH11 />", "");
        s = s.Replace("<EVN11>", "");
        s = s.Replace("</EVN11>", "");
        s = s.Replace("<EVN11 />", "");
        s = s.Replace("<PID11>", "");
        s = s.Replace("</PID11>", "");
        s = s.Replace("<PID11 />", "");
        s = s.Replace("<PV111>", "");
        s = s.Replace("</PV111>", "");
        s = s.Replace("<PV111 />", "");
        s = s.Replace("<ORC11>", "");
        s = s.Replace("</ORC11>", "");
        s = s.Replace("<ORC11 />", "");
        s = s.Replace("<OBR11>", "");
        s = s.Replace("</OBR11>", "");
        s = s.Replace("<OBR11 />", "");
        s = s.Replace("<OBX11>", "");
        s = s.Replace("</OBX11>", "");
        s = s.Replace("<OBX11 />", "");
        s = s.Replace("<Observation />", "");
        if (Status == "SampleReceived"  && Status != "Rejected")
        {
            s = s.Replace("<Observation>", "");
            s = s.Replace("</Observation>", "");
        }

        //s = s.Replace("<MSH>", ClinickSys + "<MSH>");
        //string acc = string.Empty;
        ResultXML = s.ToString();

    }
    #region PDF Report For OutBound
    [WebMethod]
    public void GetReportForOutBoundInBytes(int OrgID, long PatientVisitID, long AccesionNumber, string Status, out byte[] ReportByteArr)
    {
        ReportByteArr = new byte[byte.MaxValue];
        long returncode = -1;
        //OrgID = 67;
        List<byte[]> bytes = new List<byte[]>();
        string AccessionNo = "";
        string TemplateName = "";
        //Attune.Podium.Common.CLogger.LogWarning("Visitid:venkt");
        string _Status = "Approve";
        try
        {


            List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
            List<PatientVisit> lstpatientVisit = new List<PatientVisit>();
            Attune.Solution.BusinessComponent.Patient_BL patientBL = new Patient_BL();
            // returncode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, FromDate, toDate, PatientName, patientnumber, pVisitNumber, out lstpatientVisit, out lstOrderinvestication);

            long pVisitID = 0;
            pVisitID = PatientVisitID;
            //if (lstpatientVisit.Count > 0)
            //{
            //    pVisitID = lstpatientVisit[0].PatientVisitId;
            //}
            //List<InvReportMaster> lstReport, lstReportName = new List<InvReportMaster>();
            List<InvReportMaster> lstReport1, lstReportName1, lstReport, lstReportName = new List<InvReportMaster>();
            List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(PatientVisitID, OrgID,"", out lstReport1, out lstReportName1, out lstDpts);
            //patientBL.GetReportTemplate(pVisitID, OrgID, out lstReport, out lstReportName);

            lstReport = lstReport1.FindAll(p => p.AccessionNumber == AccesionNumber);
            lstReportName = lstReportName1.ToList();
            foreach (InvReportMaster iReportMaste in lstReportName)
            {


                if (iReportMaste.TemplateID != 10)
                {
                    TemplateName = (lstReportName.Find(Obj => Obj.TemplateID == iReportMaste.TemplateID).ReportTemplateName);

                    if (iReportMaste.TemplateID == 1)
                    {
                        AccessionNo = string.Join(",", ((from p in lstReport
                                                         where p.TemplateID == iReportMaste.TemplateID
                                                           && p.Status.Contains(_Status)
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());



                        Microsoft.Reporting.WebForms.ReportViewer rReportViewer = new Microsoft.Reporting.WebForms.ReportViewer();

                        string strURL = string.Empty;
                        string connectionString = string.Empty;
                        if (AccessionNo != null && AccessionNo != "")
                        {


                            connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
                            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
                            strURL = GetConfigValues("ReportServerURL", OrgID);
                            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
                            rReportViewer.ServerReport.ReportPath = TemplateName;// "/InvestigationReport/MedAllInvestigationValuesReportKilpauk1";
                            rReportViewer.ShowParameterPrompts = false;
                            rReportViewer.ShowPrintButton = true;

                            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
                            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(pVisitID));
                            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
                            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", iReportMaste.TemplateID.ToString());
                            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(AccessionNo));
                            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
                            rReportViewer.ServerReport.SetParameters(reportParameterList);
                            Attune.Podium.Common.CLogger.LogWarning("Visitid:" + pVisitID + "! " + OrgID + "! " + iReportMaste.TemplateID.ToString() + "! " + AccessionNo + "! " + TemplateName + "!" + connectionString);
                            Microsoft.Reporting.WebForms.Warning[] warnings;
                            string mimeType;
                            string encoding;
                            string extension;
                            string deviceInfo = "";
                            string[] streamids;
                            deviceInfo =
                              "<DeviceInfo>" +
                              "  <OutputFormat>PDF</OutputFormat>" +
                              "  <PageSize>A4</PageSize>" +
                              "  <PageWidth>8.5in</PageWidth>" +
                              "  <PageHeight>11in</PageHeight>" +
                              "  <MarginTop>0.25in</MarginTop>" +
                              "  <MarginLeft>0.25in</MarginLeft>" +
                              "  <MarginRight>0.25in</MarginRight>" +
                              "  <MarginBottom>0.25in</MarginBottom>" +
                              "</DeviceInfo>";
                            /*bytes - holds the converted pdf report in byte stream*/
                            //ReportViewer rpt = new ReportViewer();
                            ReportByteArr = rReportViewer.ServerReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                            string filename = "Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd mm yy") + ".PDF";
                            //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString() + ".PDF"), System.IO.FileMode.Create);
                            //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/" + filename), System.IO.FileMode.Create);
                            //fs.Write(ReportByteArr, 0, ReportByteArr.Length);
                            //fs.Close();
                            bytes.Add(ReportByteArr);
                        }
                    }
                    else
                    {
                        AccessionNo = string.Join(",", ((from p in lstReport
                                                         where p.TemplateID == iReportMaste.TemplateID
                                                         && p.Status.Contains(_Status)
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());
                        if (AccessionNo != null && AccessionNo != "")
                        {


                            foreach (string Accno in AccessionNo.Split(','))
                            {

                                Microsoft.Reporting.WebForms.ReportViewer rReportViewer = new Microsoft.Reporting.WebForms.ReportViewer();

                                string strURL = string.Empty;
                                string connectionString = string.Empty;

                                connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
                                rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
                                strURL = GetConfigValues("ReportServerURL", OrgID);
                                rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
                                rReportViewer.ServerReport.ReportPath = TemplateName;
                                rReportViewer.ShowParameterPrompts = false;
                                rReportViewer.ShowPrintButton = true;

                                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
                                reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(pVisitID));
                                reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
                                reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", iReportMaste.TemplateID.ToString());
                                reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(Accno));
                                reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
                                rReportViewer.ServerReport.SetParameters(reportParameterList);
                                Attune.Podium.Common.CLogger.LogWarning("Visitid:" + pVisitID + "! " + OrgID + "! " + iReportMaste.TemplateID.ToString() + "! " + AccessionNo + "! " + TemplateName + "!" + connectionString);
                                Microsoft.Reporting.WebForms.Warning[] warnings;
                                string mimeType;
                                string encoding;
                                string extension;
                                string deviceInfo = "";
                                string[] streamids;
                                deviceInfo =
                                  "<DeviceInfo>" +
                                  "  <OutputFormat>PDF</OutputFormat>" +
                                  "  <PageSize>A4</PageSize>" +
                                  "  <PageWidth>8.5in</PageWidth>" +
                                  "  <PageHeight>11in</PageHeight>" +
                                  "  <MarginTop>0.25in</MarginTop>" +
                                  "  <MarginLeft>0.25in</MarginLeft>" +
                                  "  <MarginRight>0.25in</MarginRight>" +
                                  "  <MarginBottom>0.25in</MarginBottom>" +
                                  "</DeviceInfo>";
                                /*bytes - holds the converted pdf report in byte stream*/
                                //ReportViewer rpt = new ReportViewer();
                                ReportByteArr = rReportViewer.ServerReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                                //string filename = "Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd mm yy") + ".PDF";
                                //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString() + ".PDF"), System.IO.FileMode.Create);
                                //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/" + filename), System.IO.FileMode.Create);

                                //fs.Write(ReportByteArr, 0, ReportByteArr.Length);
                                //fs.Close();
                                bytes.Add(ReportByteArr);
                            }
                        }
                    }
                }
                else
                {
                    if (iReportMaste.TemplateID == 10)
                    {

                        AccessionNo = string.Join(",", ((from p in lstReport
                                                         where p.TemplateID == iReportMaste.TemplateID
                                                         && p.Status.Contains(_Status)
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());
                        if (AccessionNo != "" && AccessionNo != null)
                        {


                            foreach (string Accno in AccessionNo.Split(','))
                            {
                                Microsoft.Reporting.WebForms.ReportViewer rReportViewer = new Microsoft.Reporting.WebForms.ReportViewer();

                                string strURL = string.Empty;
                                string connectionString = string.Empty;

                                connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
                                rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
                                strURL = GetConfigValues("ReportServerURL", OrgID);
                                rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
                                rReportViewer.ServerReport.ReportPath = "/InvestigationReport/MedAllTextReportKilpauk";
                                rReportViewer.ShowParameterPrompts = false;
                                rReportViewer.ShowPrintButton = true;

                                Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
                                reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(pVisitID));
                                reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
                                reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", "10");
                                reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(Accno));
                                reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
                                rReportViewer.ServerReport.SetParameters(reportParameterList);
                                Attune.Podium.Common.CLogger.LogWarning("Visitid:" + pVisitID + "! " + OrgID + "! " + iReportMaste.TemplateID.ToString() + "! " + Accno + "! " + TemplateName + "!" + connectionString);
                                Microsoft.Reporting.WebForms.Warning[] warnings;
                                string mimeType;
                                string encoding;
                                string extension;
                                string deviceInfo = "";
                                string[] streamids;
                                deviceInfo =
                                  "<DeviceInfo>" +
                                  "  <OutputFormat>PDF</OutputFormat>" +
                                  "  <PageSize>A4</PageSize>" +
                                  "  <PageWidth>8.5in</PageWidth>" +
                                  "  <PageHeight>11in</PageHeight>" +
                                  "  <MarginTop>0.25in</MarginTop>" +
                                  "  <MarginLeft>0.25in</MarginLeft>" +
                                  "  <MarginRight>0.25in</MarginRight>" +
                                  "  <MarginBottom>0.25in</MarginBottom>" +
                                  "</DeviceInfo>";
                                /*bytes - holds the converted pdf report in byte stream*/
                                //ReportViewer rpt = new ReportViewer();
                                ReportByteArr = rReportViewer.ServerReport.Render("PDF", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                                string filename = "Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd mm yy") + ".PDF";
                                //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/Sample" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString() + ".PDF"), System.IO.FileMode.Create);
                                //System.IO.FileStream fs = new System.IO.FileStream(Server.MapPath("~/TransferredReport/" + filename), System.IO.FileMode.Create);

                                //fs.Write(ReportByteArr, 0, ReportByteArr.Length);
                                //fs.Close();
                                bytes.Add(ReportByteArr);
                            }
                        }
                    }
                }
            }
            returncode = 0;
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error while Loading SSRS dsd", ex.InnerException);
        }
        //return returncode;
    }
    private string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay();
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            //else
            //    Attune.Podium.Common.CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void UpdateOutBoundMessageDetails(List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails)
    {

        List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails1 = new List<Hl7OutBoundMessageDetails>();
        lstHl7OutBoundMessageDetails1 = lstHl7OutBoundMessageDetails;
        System.Data.DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("HL7ID");
        DataColumn dbCol2 = new DataColumn("ID");
        DataColumn dbCol3 = new DataColumn("Name");
        DataColumn dbCol4 = new DataColumn("Type");
        DataColumn dbCol5 = new DataColumn("Status");
        DataColumn dbCol6 = new DataColumn("AccessionNumber");
        DataColumn dbCol7 = new DataColumn("GeneratedXML");
        DataColumn dbCol8 = new DataColumn("TestStatus");
        DataColumn dbCol9 = new DataColumn("PatientVisitID");

        //add columns
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        dt.Columns.Add(dbCol5);
        dt.Columns.Add(dbCol6);
        dt.Columns.Add(dbCol7);
        dt.Columns.Add(dbCol8);
        dt.Columns.Add(dbCol9);
        DataRow dr;
        for (int i = 0; i < lstHl7OutBoundMessageDetails1.Count; i++)
        {



            dr = dt.NewRow();
            dr["HL7ID"] = Convert.ToInt64(lstHl7OutBoundMessageDetails1[i].HL7ID);
            dr["ID"] = Convert.ToInt64(lstHl7OutBoundMessageDetails1[i].ID);
            dr["Name"] = lstHl7OutBoundMessageDetails1[i].Name.ToString();
            dr["Type"] = lstHl7OutBoundMessageDetails1[i].Type.ToString();
            dr["Status"] = lstHl7OutBoundMessageDetails1[i].Status.ToString();
            dr["AccessionNumber"] = Convert.ToInt64(lstHl7OutBoundMessageDetails1[i].AccessionNumber);
            dr["GeneratedXML"] = lstHl7OutBoundMessageDetails1[i].GeneratedXML.ToString();
            dr["TestStatus"] = lstHl7OutBoundMessageDetails1[i].TestStatus.ToString();
            dr["PatientVisitID"] = Convert.ToInt64(lstHl7OutBoundMessageDetails1[i].PatientVisitID);
            dt.Rows.Add(dr);

        }
        long OrgId = 0;
        OrgId = lstHl7OutBoundMessageDetails[0].OrgID;
        OutBoundMsg_BL obj_bl = new OutBoundMsg_BL();
        //List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails = new List<Hl7OutBoundMessageDetails>();
        obj_bl.UpdateOutBoundMsgDetils(OrgId, dt);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void XMlGeneratorForPDF(long OrgID1, long PatientVisitID, long AccessionNumber,
        string Status, out string ResultXML, byte[] ReportByteArr, long Hl7ID)
    {
        List<ContentPDF> lstContent1 = new List<ContentPDF>();
        try
        {


            XmlSerializer xsSubmit = new XmlSerializer(typeof(ContentPDF));
            ContentPDF Con = new ContentPDF();
            OutBoundMsg_BL Bl = new OutBoundMsg_BL();
            Bl.getPdfDetails(OrgID1, PatientVisitID, AccessionNumber, out lstContent1);
            //Bl.getPdfDetails(OrgID1, PatientVisitID, AccessionNumber, out  lstContent1);
            if (lstContent1.Count > 0)
            {
                Con.OBR_Placer_Order_Number = lstContent1[0].OBR_Placer_Order_Number;
                Con.Observation_Date_Time = lstContent1[0].Observation_Date_Time;
                Con.Entered_By_ID = lstContent1[0].Entered_By_ID;
                if (ReportByteArr != null)
                {
                    Con.PDFBytes = ReportByteArr;
                }


            }
            XmlDocument doc = new XmlDocument();
            System.IO.StringWriter sww = new System.IO.StringWriter();
            XmlWriter writer = XmlWriter.Create(sww);
            xsSubmit.Serialize(writer, Con);
            ResultXML = sww.ToString();
            string val = GetConfigValues("Need Utf-8/Utf-16 encoding",Convert.ToInt32 (OrgID1));
            if (val != "")
            {
                // s = s.Replace("<?xml version=\"1.0\" encoding=\"utf-16\"?>", "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                ResultXML = ResultXML.Replace("<?xml version=\"1.0\" encoding=\"utf-16\"?>", "<?xml version=\"1.0\" encoding=\"" + val + "\"?>");
            }
        }
        catch (Exception ee)
        {

            throw;
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Hl7OutBoundMessageDetails> GetApprovedDataForOutBoundClinincSys(int OrgID, string Status, string VisitNumber)
    {
        long result = -1;
        List<Hl7OutBoundMessageDetails> lstHl7OutboundClingSys = new List<Hl7OutBoundMessageDetails>();
        try
        {

            OutBoundMsg_BL obj_bl = new OutBoundMsg_BL(new BaseClass().ContextInfo);
            result = obj_bl.GetApprovedDataForOutBoundClinincSys(OrgID, Status, VisitNumber, out lstHl7OutboundClingSys);

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Executing GetApprovedDataForOutBoundClinincSys", ex);
        }
        return lstHl7OutboundClingSys;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void GetApprovedDetailsForOutboundClinicsystem(int OrgID, string VisitNumber, out string[] ApprovedResultVaues)
    {

        OutBoundMsg_BL obj_bl = new OutBoundMsg_BL();
        List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails = new List<Hl7OutBoundMessageDetails>();
        string Status = string.Empty;
        List<Hl7OutBoundMessageDetails> AppRptPdfErrorList = new List<Hl7OutBoundMessageDetails>();
        List<Hl7OutBoundMessageDetails> AppRptPdfCompletedList = new List<Hl7OutBoundMessageDetails>();
        if (Status != "Approve")
        {
            obj_bl.GetApprovedDataForOutBoundClinincSys(OrgID, Status, VisitNumber, out lstHl7OutBoundMessageDetails);
        }

        Hl7OutBoundMessageDetails[] AppReportPdfList;
        AppReportPdfList = lstHl7OutBoundMessageDetails.ToArray();
        byte[] results = new byte[byte.MaxValue];
        List<byte[]> bytes1 = new List<byte[]>();
        ApprovedResultVaues = new string[lstHl7OutBoundMessageDetails.Count];
        if (AppReportPdfList != null && AppReportPdfList.Count() > 0)
        {
            // ServiceTimer.Stop();
            //IsTimerStop = "Y";

            ApprovedResultVaues = new string[AppReportPdfList.Length];
            Hl7OutBoundMessageDetails[] AppReportGenPdf;
            List<byte[]> bytes;
            byte[] PDFBytes = new byte[0];
            string ConfigKey = "CMSFilePath";
            string ConfigKeyRetrive = "CMSRetrivePath";

            for (int i = 0; i < AppReportPdfList.Count(); i++)
            {
                try
                {

                    string ResultXML = string.Empty;
                    if (AppReportPdfList[i].PDFForOutBound == "Y")
                    {
                        string FilePath = GetConfigValuee(ConfigKey, Convert.ToInt32(AppReportPdfList[i].OrgID));
                        FilePath = FilePath + AppReportPdfList[i].HL7ID + ".PDF";
                        byte[] bytes11 = new byte[0];
                        long OrgId = 0;
                        OrgId = AppReportPdfList[i].OrgID;
                        if (File.Exists(FilePath))
                        {
                            bytes11 = System.IO.File.ReadAllBytes(FilePath);
                        }
                        //  byteArray = StrToByteArray(lstHl7OutBoundDetailsInBytes[i].Name);
                        //byte[] bytes = Encoding.ASCII.GetBytes(lstHl7OutBoundDetailsInBytes[i].Name);
                        //byte[] bArray = Encoding.UTF8.GetBytes(lstHl7OutBoundDetailsInBytes[i].Name);
                        ////  byteArray = GetBytes(lstHl7OutBoundDetailsInBytes[i].Name);
                        string RetriveData = GetConfigValuee(ConfigKeyRetrive, Convert.ToInt32(AppReportPdfList[i].OrgID));
                        SaveBytesToFile(RetriveData + AppReportPdfList[i].HL7ID + ".PDF", bytes11);
                        //string[] AppValuesinbytes;
                        // ConvertVarBinaryTobyteArray(OrgID, Status, VisitNumber, AppReportPdfList[i].PatientVisitID, out AppValuesinbytes);
                        //GetReportForOutBoundInBytes(69, AppReportPdfList[i].PatientVisitID, AppReportPdfList[i].AccessionNumber, AppReportPdfList[i].Status, out PDFBytes);
                        if (bytes11.Length > 0)
                        {
                            XMlGeneratorForPDF(OrgId, AppReportPdfList[i].PatientVisitID, AppReportPdfList[i].AccessionNumber, "Approve", out ResultXML, bytes11, AppReportPdfList[i].HL7ID);
                            //string Path = System.Configuration.ConfigurationSettings.AppSettings["PDFPath"];
                            //string textPath = System.Configuration.ConfigurationSettings.AppSettings["TextPath"];
                            //ApprovedResultVaues[i] = ResultXML.ToString();
                            //// string OutputMsg = obj1.acceptMessage(ResultXML.ToString());
                            //// root = ReportFolderPath;
                            //// LogInfo(OutputMsg);
                            ////ResultXML = PDFBytes.ToString();
                            //string a = "1";
                            //a = (1 + a).ToString();
                            //SaveBytesToFile(Path + AppReportPdfList[i].HL7ID + ".PDF", PDFBytes);
                            // ByteArrayToFile(textPath + AppReportPdfList[i].HL7ID + ".xml", ResultXML);
                            //FileStream objFS = new FileStream(root + "jeya.PDF", FileMode.Create);
                            //objFS.Write(results, 0, results.Length);
                            //objFS.Close();
                            //objFS = null;
                            Hl7OutBoundMessageDetails objAppReports = new Hl7OutBoundMessageDetails();
                            objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                            objAppReports.PatientVisitID = AppReportPdfList[i].PatientVisitID;
                            objAppReports.AccessionNumber = AppReportPdfList[i].AccessionNumber;
                            objAppReports.ID = AppReportPdfList[i].ID;
                            objAppReports.Status = "Completed";
                            objAppReports.GeneratedXML = ResultXML.ToString();
                            AppRptPdfCompletedList.Add(objAppReports);
                            ApprovedResultVaues[i] = objAppReports.GeneratedXML;
                        }

                        else
                        {
                            //LogInfo("Pdf does not have Contents");
                            Hl7OutBoundMessageDetails objAppReports = new Hl7OutBoundMessageDetails();
                            objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                            objAppReports.PatientVisitID = AppReportPdfList[i].PatientVisitID;
                            objAppReports.AccessionNumber = AppReportPdfList[i].AccessionNumber;
                            objAppReports.ID = AppReportPdfList[i].ID;
                            objAppReports.Status = "";
                            objAppReports.GeneratedXML = ResultXML.ToString();
                            AppRptPdfCompletedList.Add(objAppReports);
                        }
                    }
                    else
                    {
                        int OrgId = 0;
                        OrgId =Convert.ToInt32( AppReportPdfList[i].OrgID);
                        XMlGenerator(OrgId, AppReportPdfList[i].PatientVisitID, AppReportPdfList[i].AccessionNumber, "Approve", out ResultXML);
                        if (ResultXML != "" && ResultXML != null)
                        {
                            ApprovedResultVaues[i] = ResultXML.ToString();
                            //  root = ReportFolderPath;

                            //   string OutputMsg = obj1.acceptMessage(ResultXML);
                            //  root = ReportFolderPath;
                            //LogInfo(OutputMsg);
                            //FileStream objFS = new FileStream(root + "jeya.PDF", FileMode.Create);
                            //objFS.Write(results, 0, results.Length);
                            //objFS.Close();
                            //objFS = null;
                            Hl7OutBoundMessageDetails objAppReports = new Hl7OutBoundMessageDetails();
                            objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                            objAppReports.PatientVisitID = AppReportPdfList[i].PatientVisitID;
                            objAppReports.AccessionNumber = AppReportPdfList[i].AccessionNumber;
                            objAppReports.ID = AppReportPdfList[i].ID;
                            objAppReports.Status = "Completed";
                            objAppReports.GeneratedXML = ResultXML.ToString();
                            AppRptPdfCompletedList.Add(objAppReports);
                            ApprovedResultVaues[i] = objAppReports.GeneratedXML;
                        }
                        else
                        {
                            //LogInfo("Pdf does not have Contents");
                            Hl7OutBoundMessageDetails objAppReports = new Hl7OutBoundMessageDetails();
                            objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                            objAppReports.PatientVisitID = AppReportPdfList[i].PatientVisitID;
                            objAppReports.AccessionNumber = AppReportPdfList[i].AccessionNumber;
                            objAppReports.ID = AppReportPdfList[i].ID;
                            objAppReports.Status = "";
                            objAppReports.GeneratedXML = ResultXML.ToString();
                            AppRptPdfCompletedList.Add(objAppReports);
                        }
                    }

                    //string OutputMsg = obj1.acceptMessage(ResultXML);
                    //LogInfo("jeya");
                    //LogInfo(OutputMsg);

                }
                catch (Exception ex)
                {

                    // LogError(ex);
                    //LogInfo("Error while Pdf Generating:");
                    //LogError(ex);
                    Hl7OutBoundMessageDetails objAppReports = new Hl7OutBoundMessageDetails();
                    objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                    objAppReports.HL7ID = AppReportPdfList[i].HL7ID;
                    objAppReports.PatientVisitID = AppReportPdfList[i].PatientVisitID;
                    objAppReports.AccessionNumber = AppReportPdfList[i].AccessionNumber;
                    objAppReports.GeneratedXML = AppRptPdfCompletedList[i].GeneratedXML;
                    objAppReports.Status = "Error";
                    AppRptPdfCompletedList.Add(objAppReports);
                }
            }
            if (AppRptPdfErrorList.Count > 0)
            {
                try
                {
                    UpdateOutBoundMessageDetails(AppRptPdfErrorList);
                }
                catch (Exception ex)
                {
                    //LogError(ex);
                    //LogInfo("Error while SaveReportSnapshot:");
                    //LogError(ex);
                }
            }
            if (AppRptPdfCompletedList.Count > 0)
            {
                try
                {

                    UpdateOutBoundMessageDetails(AppRptPdfCompletedList);
                }
                catch (Exception ex)
                {
                    //LogError(ex);
                    //LogInfo("Error while SaveReportSnapshot:");
                    //LogError(ex);
                }
            }
        }
        //obj_bl.GetApprovedDataForOutBoundClinincSys(OrgID, "", VisitNumber);


    }
    public string GetConfigValuee(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        BaseClass tfm = new BaseClass();

        GateWay objGateway = new GateWay(tfm.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }


    public static void SaveBytesToFile(string filename, byte[] bytesToWrite)
    {

        if (filename != null && filename.Length > 0 && bytesToWrite != null)
        {
            if (!Directory.Exists(Path.GetDirectoryName(filename)))
                Directory.CreateDirectory(Path.GetDirectoryName(filename));

            FileStream file = File.Create(filename);

            file.Write(bytesToWrite, 0, bytesToWrite.Length);
            //  File.WriteAllBytes(filename, bytesToWrite);
            file.Close();
        }
    }
}

