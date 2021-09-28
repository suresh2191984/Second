using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Xml;
using System.Data;
using System.Text;
using System.IO;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.DAL;
using AjaxControlToolkit;
using System.Security.Cryptography;
using System.Net;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;
using Hl7toXMLGenerator;
using HL7toXML_Convert;

/// <summary>
/// Summary description for HL7IntegrationService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class HL7IntegrationService : System.Web.Services.WebService
{

    public HL7IntegrationService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    ContextDetails objcontext = new ContextDetails();
    string barcodesuffix = string.Empty;
    string barcodeempty = string.Empty;
    string LabNoBasedBarcode = string.Empty;
    string[] Errorlist;
    string Error = string.Empty;
    string clientcode = "GENERAL";
    string ClientCodeWithTower = string.Empty;
    string ReffeingPhysicianName = string.Empty;
    string Ageandtype = string.Empty;
    string Person_Identifier = string.Empty;
    string physicianPNo = string.Empty;
    int EXVType = 0;

    string MigratedvisitNumber = string.Empty;
    string istat = string.Empty;
    string FutureDate = string.Empty;
    string issstat = string.Empty;
    string MigratedReferNumber = string.Empty;
    string strConfig = string.Empty;

    string Errorcode1 = "1";
    DateTime Transactiondate1 = DateTime.MaxValue;
    DateTime MessageDate = DateTime.MaxValue;
    string TestName = string.Empty;
    String XMLFile = string.Empty;
    int orgID = 0, OrgAddressID = 0, RoleId = 0;
    int intOrgAddressID = 0;
    long LoginId = 0, returncode = -1;
    string strLocationCode = string.Empty;
    string strFileDetails = string.Empty;
    List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
    string strFileName = string.Empty;
    List<HLMessageErrorDetails> lstHLMessageErrorDetails = new List<HLMessageErrorDetails>();
    List<HL7Segments> lstHL7Segments = new List<HL7Segments>();
    DateTime TatDateTime = DateTime.Now;
    #region HL72XML
    [WebMethod(EnableSession = true)]
    public string HL72XML(string HL7Message, string FileDetails, int OrgID, out List<string> lstLocation)
    {
        string PageErrorCode = string.Empty;
        if (FileDetails.Contains("~"))
        {
            strFileName = FileDetails.Split('~')[0];
        }
        //string sXML = ConvertToXml(HL7Message);
        ContextDetails objcontext = new ContextDetails();
        objcontext = SetContextDetailsInBound(0, "en-GB", 0, 0, 0);
        Patient_BL PBL = new Patient_BL(objcontext);
        long returnCode = PBL.GetHL7Segments(orgID, out lstHL7Segments);
        string sXML = ConvertToXmlByManual(HL7Message);
        lstLocation = new List<string>();
        if (lstHLMessageErrorDetails.Count() > 0)
        {
            PageErrorCode = "Invalid File";
            CLogger.LogWarning("Invalid File - " + strFileName);
            //return PageErrorCode;
        }
        GetOrgDet(HL7Message, OrgID, out lstLocation);
        strFileDetails = FileDetails;
        ORUInBound(sXML, HL7Message, out PageErrorCode);
        if (string.IsNullOrEmpty(PageErrorCode))
        {
            sXML = PageErrorCode;
        }

        return PageErrorCode;

    }
    #endregion
    #region ORUInBound
    public void ORUInBound(String HL7XML, string HL7Msg, out string PageErrorCode)
    {

        DateTime dtSampleDate = DateTime.Now;

        Error = string.Empty;
        string MsgType = string.Empty;
        string MsgError = "";
        PageErrorCode = "";
        HLMessages objHLMessage = new HLMessages();
        List<HLMessages> lstobjHLmessage = new List<HLMessages>();
        ContextDetails objcontext = new ContextDetails();
        XElement xelement = XElement.Parse(HL7XML);
        //objHLMessage = GetHLMesssgeInBound(xelement);
        //MsgType = objHLMessage.MsgType;
        objHLMessage = GetHLMesssgeDetailsInBoundDetails(xelement, HL7Msg, out MsgError);
        GetOrgDetailsInBound(objHLMessage, out orgID, out OrgAddressID);
        GetLoginDetailsInBound(objHLMessage, out LoginId, out RoleId);

        /*Temp comment for checking process - 10/11/2017
        //MsgType = objHLMessage.MsgType;
        //objcontext = SetContextDetailsInBound(orgID, "en-GB", OrgAddressID, RoleId, LoginId);
        //if (objHLMessage.Sending_App != "")
        //{
        //    new Patient_BL().GetPatientData("SendApp", objHLMessage.Sending_App, orgID, out lstobjHLmessage);
        //    if (lstobjHLmessage.Count > 0)
        //    {
        //        objHLMessage.CountryID = lstobjHLmessage[0].CountryID;
        //        objHLMessage.StateID = lstobjHLmessage[0].StateID;
        //        objHLMessage.Patient_Country = lstobjHLmessage[0].Patient_Country;
        //        objHLMessage.Patient_State = lstobjHLmessage[0].Patient_State;
        //        objHLMessage.Nationality = lstobjHLmessage[0].Nationality;

        //    }
        //    else
        //    {
        //        Adderror("Send_ApplicationE");
        //        Errorcode1 = "0";
        //    }
        //}

        //if (objHLMessage.Sending_Facility != "")
        //{
        //    lstobjHLmessage = new List<HLMessages>();
        //    new Patient_BL().GetPatientData("SendFac", objHLMessage.Sending_Facility, orgID, out lstobjHLmessage);
        //    if (lstobjHLmessage.Count == 0)
        //    {
        //        Adderror("Send_FacilityE");
        //        Errorcode1 = "0";
        //    }
        //}*/

        //Temp comment for checking process - 26/10/2017
        //returncode = new Patient_BL(objcontext).insertHLMessage(objHLMessage, "0", "", HL7Msg);
        //PageErrorCode = Errorcode1;
        PageErrorCode += System.Environment.NewLine + MsgError;

    }
    #endregion

    #region InBoundDetails
    [WebMethod(EnableSession = true)]
    //public void SetInBoundDetails(List<HLMessages> AppInBoundMsgList, List<HLMessagePatientIDDetails> lstPatient, List<HLMessageOBRDetails> lstHLMessageOBRDetails, out string ParseError)
    public string SetInBoundDetails(List<HLMessages> AppInBoundMsgList, List<HLMessagePatientIDDetails> lstPatient, List<HLMessageOBRDetails> lstHLMessageOBRDetails)
    {
        List<HLMessages> AppInboundCompletedList = new List<HLMessages>();
        string ParseError = "";
        for (int i = 0; i < AppInBoundMsgList.Count(); i++)
        {
            try
            {
                ParseError += System.Environment.NewLine + "Before HL7InBoundMessages";
                string strtest = "";
                string[] test = new string[20];
                string Hl7InMessage = "";
                Hl7InMessage = HL7InBoundMessages(AppInBoundMsgList[i].XMLERROR.ToString(), lstPatient, lstHLMessageOBRDetails, out strtest);
                ParseError += System.Environment.NewLine + strtest + System.Environment.NewLine + "After HL7InBoundMessages";
                if (Hl7InMessage != "" && Hl7InMessage != null)
                {
                    if (Hl7InMessage == "1")
                    {
                        HLMessages objAppHLmsg = new HLMessages();
                        objAppHLmsg.HLMessagesID = AppInBoundMsgList[i].HLMessagesID;
                        objAppHLmsg.MsgControlId = AppInBoundMsgList[i].MsgControlId;
                        objAppHLmsg.ErrorList = AppInBoundMsgList[i].ErrorList;
                        objAppHLmsg.StatusOfInbound = "Completed";
                        AppInboundCompletedList.Add(objAppHLmsg);
                    }
                    else
                    {
                        HLMessages objAppHLmsg = new HLMessages();
                        objAppHLmsg.HLMessagesID = AppInBoundMsgList[i].HLMessagesID;
                        objAppHLmsg.MsgControlId = AppInBoundMsgList[i].MsgControlId;
                        objAppHLmsg.ErrorList = "ERROR";
                        objAppHLmsg.StatusOfInbound = "ERROR";
                        ParseError += Environment.NewLine + "After GetInBoundListForHLMessages - Data Pushed Successfully" + Environment.NewLine + "*************************************************************";
                        AppInboundCompletedList.Add(objAppHLmsg);
                    }
                }
                else
                {
                    ParseError += System.Environment.NewLine + "HL7InMessage is null";
                }
            }
            catch (Exception ex)
            {
                ParseError += System.Environment.NewLine + "Error in Inboundservice datapush: " + ex.Message.ToString();
                HLMessages objAppHLmsg = new HLMessages();
                objAppHLmsg.HLMessagesID = AppInBoundMsgList[i].HLMessagesID;
                objAppHLmsg.MsgControlId = AppInBoundMsgList[i].MsgControlId;
                objAppHLmsg.ErrorList = "Catchloop";
                objAppHLmsg.StatusOfInbound = "Completed";
                AppInboundCompletedList.Add(objAppHLmsg);
            }
            finally
            {
                if (AppInboundCompletedList.Count > 0)
                {
                    try
                    {
                        UpdateInBoundMessageDetails(AppInboundCompletedList);
                        ParseError += Environment.NewLine + "After UpdateInBoundMessageDetails - Bound Message Status is updated Successfully" + Environment.NewLine + "*************************************************************";
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error while executing UpdateInBoundMessageDetails-SetInBoundDetails in HL7Integrationservice", ex);
                        ParseError += Environment.NewLine + "Error while executing UpdateInBoundMessageDetails-SetInBoundDetails in HL7Integrationservice " + ex.InnerException;
                    }
                }
            }
        }
        return ParseError;
    }
    #endregion
    #region HL7InBoundMessages
    [WebMethod(EnableSession = true)]
    public string HL7InBoundMessages(string HL7Message, List<HLMessagePatientIDDetails> lstPatient, List<HLMessageOBRDetails> lstHLMessageOBRDetails, out string ErrorMsg)
    {
        string PageErrorCode = string.Empty;
        string PageErrorCode1 = string.Empty;
        string MsgError = string.Empty;
        string sXML = ConvertToXmlByService(HL7Message);
        try
        {
            PageErrorCode1 += "Before ORUInBoundMessage in HL7InBoundMessages" + System.Environment.NewLine;
            ORUInBoundMessage(sXML, HL7Message, lstPatient, lstHLMessageOBRDetails, out PageErrorCode, out MsgError);
            PageErrorCode1 += System.Environment.NewLine + MsgError + System.Environment.NewLine + "After ORUInBoundMessage in HL7InBoundMessages" + System.Environment.NewLine;
            if (string.IsNullOrEmpty(PageErrorCode))
            {
                sXML = PageErrorCode;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing HL7InBoundMessages in HL7IntegrationService", ex);
            PageErrorCode1 += Environment.NewLine + "Error while executing HL7InBoundMessages in HL7IntegrationService";
        }
        ErrorMsg = PageErrorCode1;
        return PageErrorCode;
    }
    #endregion

    #region GetOrgDet
    // Getting LocationCode 
    [WebMethod(EnableSession = true)]
    public string GetOrgDet(string objHLMessage, int Orgid, out List<string> lstLocation)
    {
        long Returncode = 0;
        string LocationCode = "";
        Patient_BL objPatientBL = new Patient_BL();
        lstLocation = new List<string>();
        List<Organization> objorgnaization = new List<Organization>();
        List<HLMessages> lstobjHLMessages = new List<HLMessages>();
        try
        {
            //Returncode = objPatientBL.GetOrgDet(Orgid,0, out objorgnaization);
            Returncode = objPatientBL.GetPatientData("", "", 0, out lstobjHLMessages);
            if (lstobjHLMessages.Count > 0)
            {
                foreach (var item in lstobjHLMessages)
                {
                    lstLocation.Add(item.LocationCode);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetOrgDet() Method in HL7Integrationservice", ex);
        }
        return LocationCode;
    }
    #endregion
    #region ORUInBoundMessage
    [WebMethod(EnableSession = true)]
    public XmlDocument ORUInBoundMessage(String HL7XML, string HL7Msg, List<HLMessagePatientIDDetails> lstPatient, List<HLMessageOBRDetails> lstHLMessageOBRDetails, out string PageErrorCode, out string MsgError)
    {
        Error = string.Empty;
        MsgError = string.Empty;
        string MsgType = string.Empty;
        XmlDocument ReturnXML = new XmlDocument();
        string gUID = string.Empty;
        String WardDetails = string.Empty;
        String AssignedWardDetails = string.Empty;
        String PriorWardDetails = string.Empty;
        String ExtVisitid = string.Empty;
        string PriorPatId = string.Empty;
        string ORCNumber = string.Empty;
        int reportClientid = 0;
        int EXVisitType = 0;
        int pOrderedCount = -1;
        HLMessages objHLMessage = new HLMessages();
        HLMessageHeaderDetails objHLMessageHeader = new HLMessageHeaderDetails();
        HLMessagePatientIDDetails objHLMessagePatientID = new HLMessagePatientIDDetails();
        HLMessageORCDetails objHLMessageORC = new HLMessageORCDetails();
        HLMessageOBRDetails objHLMessageOBR = new HLMessageOBRDetails();
        Patient patient = new Patient();
        List<OrderedInvestigations> lstOrdinv = new List<OrderedInvestigations>();
        List<InvestigationValues> objPatInv = new List<InvestigationValues>();
        FinalBill objFinalBill = new FinalBill();
        DataTable dtAmountReceivedDet = null;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
        PageContextkey pageContextDetails = new PageContextkey();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        List<PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        List<HLMessages> lstobjHLmessage = new List<HLMessages>();
        List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();
        ContextDetails objcontext = new ContextDetails();
        string ExternalPatientNumber = "";
        string ExternalPatientVisitNumber = "";
        string ReportMode = string.Empty;
        string Relevant_Clinical_Information = string.Empty;
        string Placer_Field2 = string.Empty;
        string Collectors_Comment = string.Empty;
        DateTime PatientRegDateTime = DateTime.Now;
        DateTime OrderedDateTime = DateTime.Now;
        //DateTime TatDateTime = DateTime.Now;
        string HLEnteredBy = string.Empty;
        bool IsCumulative = false;
        string ParentOrder = string.Empty;
        int orgID = 0, returnStatus = -1, needTaskDisplay = -1, OrgAddressID = 0, RoleId = 0;
        long PatientRoleID = 0, returncode = -1, returncancelcode = -1, taskid = 0, pPatientID = 0;
        DateTime dtSampleDate = DateTime.Now;
        PageErrorCode = "";
        long Dvisitid = -1;
        try
        {
            XElement xelement = XElement.Parse(HL7XML);
            objHLMessage = GetHLMesssgeInBound(xelement);
            MsgType = lstPatient[0].MessageType;
            GetOrgDetailsInBound(objHLMessage, out orgID, out OrgAddressID);
            GetLoginDetailsInBound(objHLMessage, out LoginId, out RoleId);
            orgID = Convert.ToInt32(lstPatient[0].OrgID);
            OrgAddressID = Convert.ToInt32(lstPatient[0].LocationID);

            returncode = new AdminReports_BL(objcontext).GetUserNames("HLMessages", orgID, "Users", "A", out lstOrgUsers);
            if (lstOrgUsers.Count > 0)
            {
                LoginId = lstOrgUsers[0].LoginID;
            }
            objcontext = SetContextDetailsInBound(orgID, "en-GB", OrgAddressID, RoleId, LoginId);
            if (lstHLMessageOBRDetails.Count > 0)
            {
                ReportMode = lstHLMessageOBRDetails[0].Result_Copies_To;
                PatientRegDateTime = lstHLMessageOBRDetails[0].Requested_Date_Time;
                OrderedDateTime = lstHLMessageOBRDetails[0].Login_Create_DateTime;
                Relevant_Clinical_Information = lstHLMessageOBRDetails[0].Relevant_Clinical_Information;
                Placer_Field2 = lstHLMessageOBRDetails[0].Placer_Field2;
                Collectors_Comment = lstHLMessageOBRDetails[0].Collectors_Comment;
                TatDateTime = lstHLMessageOBRDetails[0].Scheduled_Date_Time;
            }
            IsCumulative = lstPatient[0].Production_Class_Code == "Y" ? true : false;
            ParentOrder = string.IsNullOrEmpty(lstPatient[0].Breed_Code) ? "" : lstPatient[0].Breed_Code;
            if (objHLMessage.Sending_App != "")
            {
                new Patient_BL().GetPatientData("SendApp", objHLMessage.Sending_App, orgID, out lstobjHLmessage);
                if (lstobjHLmessage.Count > 0)
                {
                    objHLMessage.CountryID = lstobjHLmessage[0].CountryID;
                    objHLMessage.StateID = lstobjHLmessage[0].StateID;
                    objHLMessage.Patient_Country = lstobjHLmessage[0].Patient_Country;
                    objHLMessage.Patient_State = lstobjHLmessage[0].Patient_State;
                    objHLMessage.Nationality = lstobjHLmessage[0].Nationality;
                }
                else
                {
                    //  Adderror("Send_ApplicationE");
                }
            }

            if (objHLMessage.Sending_Facility != "")
            {
                lstobjHLmessage = new List<HLMessages>();
                new Patient_BL().GetPatientData("SendFac", objHLMessage.Sending_Facility, orgID, out lstobjHLmessage);
                if (lstobjHLmessage.Count == 0)
                {
                    // Adderror("Send_FacilityE");
                }
            }
            //returncode = new Patient_BL(objcontext).insertHLMessage(objHLMessage, "0", "", HL7Msg);
            if (MsgType != "" && MsgType != null)
            {

                //if (Error == "")
                //{
                String ObjStatus = string.IsNullOrEmpty(objHLMessage.ControlType) ? "" : objHLMessage.ControlType;
                patient = HLPatientDetails(objHLMessage, lstPatient, orgID, LoginId);
                if (lstPatient.Count > 0)
                {
                    if (MsgType == "ADTA04" || MsgType == "ADTA08" || MsgType == "ORMO01")
                    {
                        ExternalPatientNumber = patient.ExternalPatientNumber;
                        TimeSpan diff = DateTime.Now - patient.DOB;
                        int agedays = diff.Days;
                        string[] ageunit = patient.Age.Split(' ');
                        int ageValue = 0;
                        Int32.TryParse(ageunit[0], out ageValue);
                        string Uname, Pwd, PatientNumber = string.Empty;
                        long PatientId = -1;
                        patient.PersonalIdentification = lstPatient[0].Patient_ID;
                        HLEnteredBy = lstPatient[0].RegisteredBy;
                        ExternalPatientVisitNumber = !string.IsNullOrEmpty(lstPatient[0].ExternalVisitID) ? lstPatient[0].ExternalVisitID : "";
                        patient.AlternateContact = lstPatient[0].Phone_Number_home;
                        if (lstPatient[0].Patient_Name != "")
                            patient.FirstName = lstPatient[0].Patient_Name;
                        else
                            patient.FirstName = "";
                        if (objHLMessage.Patient_middlename != "")
                            patient.MiddleName = objHLMessage.Patient_middlename;
                        else
                            patient.MiddleName = "";
                        if (objHLMessage.Patient_lastname != "")
                            patient.LastName = lstPatient[0].PIDFamily_Name;
                        else
                            patient.LastName = "";
                        patient.Status = "A";
                        MsgError += "Before Insert the Patient Details in ORUInBoundMessage" + Environment.NewLine;
                        new Patient_BL(objcontext).SavePatient(patient, patient.DOB, ageValue, ageunit[1], "", "", out Uname, out Pwd, out PatientNumber, out PatientId, 0, new List<PatientQualification>());
                        MsgError += "After Insert the Patient Details Successfully in ORUInBoundMessage" + Environment.NewLine;
                        if (PatientId > 0)
                        {
                            pPatientID = PatientId;
                            returncode = 1;
                        }
                    }
                }
                if (MsgType == "ORMO01" || MsgType == "ORMO01ORM_O01")
                {
                    if (ObjStatus != "XO" || ObjStatus != "CA")
                    {
                        Patient_BL PBL = new Patient_BL(objcontext);
                        List<OrderedInvestigations> lstGuid = new List<OrderedInvestigations>();
                        long returnCode = PBL.GetGuidForSameVisit(ExternalPatientVisitNumber, orgID, out lstGuid);
                        MsgError += "Before executing HLOrderDetails in ORUInBoundMessage" + Environment.NewLine;
                        lstOrdinv = HLOrderDetails(objHLMessage, lstHLMessageOBRDetails, objcontext, orgID, pPatientID, out gUID);
                        if (lstGuid.Count > 0)
                        {
                            gUID = lstGuid[0].UID;
                            Dvisitid = lstGuid[0].VisitID;
                            for (int i = 0; i < lstOrdinv.Count; i++)
                            {
                                lstOrdinv[i].UID = lstGuid[0].UID;
                            }
                        }
                        MsgError += "After executing HLOrderDetails in ORUInBoundMessage" + Environment.NewLine;
                        objFinalBill = GetFinalbilldetail(lstOrdinv, OrgAddressID);
                        MsgError += "After executing GetFinalbilldetail in ORUInBoundMessage" + Environment.NewLine;
                        dtAmountReceivedDet = GetAmountReceivedDetails(objFinalBill);
                        MsgError += "After executing GetAmountReceivedDetails in ORUInBoundMessage" + Environment.NewLine;
                        lstPatientDueChart = GetBillingItems(lstOrdinv);
                        MsgError += "After executing GetBillingItems in ORUInBoundMessage" + Environment.NewLine;
                        if (lstHLMessageOBRDetails.Count > 0)
                        {
                            clientcode = lstHLMessageOBRDetails[0].Collector_Identifier;
                        }
                        else
                        {
                            clientcode = "GENERAL";
                        }
                        lst = GetVisitClientMappingDetails(clientcode, orgID);
                        MsgError += "After executing GetVisitClientMappingDetails in ORUInBoundMessage" + Environment.NewLine;
                    }
                }
                if (MsgType == "ADTA02" || MsgType == "ADTA12")
                {
                    AssignedWardDetails = objHLMessage.WardDeatils.ToString();
                    PriorWardDetails = objHLMessage.PriorWardDetails.ToString();
                    ExtVisitid = objHLMessage.ExternalVisitId.ToString();
                    MsgError += "Before executing UpdateWardDetails in ORUInBoundMessage" + Environment.NewLine;
                    returncode = new Patient_BL(objcontext).UpdateWardDetails(ExtVisitid.ToString(), objHLMessage.PatientIdentifier, AssignedWardDetails, PriorWardDetails, MsgType);
                    MsgError += "After executing UpdateWardDetails in ORUInBoundMessage" + Environment.NewLine;
                }
                if (MsgType == "ADTA18")
                {
                    PriorPatId = objHLMessage.PriorIdNumber.ToString();
                    MsgError += "Before executing PatientmergeHl7 in ORUInBoundMessage" + Environment.NewLine;
                    returncode = new Patient_BL(objcontext).PatientmergeHl7(objHLMessage.PatientIdentifier, objHLMessage.Patient_fname, PriorPatId, MsgType);
                    MsgError += "After executing PatientmergeHl7 in ORUInBoundMessage" + Environment.NewLine;
                }
                if (MsgType == "ORMO01" || MsgType == "ORMO01ORM_O01")
                {
                    //WardDetails = objHLMessage.WardDeatils.ToString();
                    ORCNumber = lstHLMessageOBRDetails[0].Tasks_Sales_ID;
                    //EXVisitType = Int32.Parse(objHLMessage.OrderStatus.ToString());
                    EXVisitType = EXVType;
                    //String ObjStatus = string.IsNullOrEmpty(objHLMessage.ControlType) ? "" : objHLMessage.ControlType;
                    if (lstOrdinv.Count > 0)
                    {
                        // Separate (XO & CA) & NW Status as for Cancel Test
                        //Code Begin
                        if (ObjStatus == "XO" || ObjStatus == "CA")
                        {
                            objcontext.AdditionalInfo = ReffeingPhysicianName;
                            MsgError += "Before executing UpdateCancelBilling in ORUInBoundMessage" + Environment.NewLine;
                            returncancelcode = new Patient_BL(objcontext).UpdateCancelBilling(ORCNumber, ObjStatus, Person_Identifier, physicianPNo);
                            MsgError += "After executing UpdateCancelBilling in ORUInBoundMessage" + Environment.NewLine;
                            returncode = returncancelcode;
                        }
                        else
                        {
                            if (objHLMessage.Patient_firstname != "")
                                patient.FirstName = objHLMessage.Patient_firstname;
                            else
                                patient.FirstName = "";
                            if (objHLMessage.Patient_middlename != "")
                                patient.MiddleName = objHLMessage.Patient_middlename;
                            else
                                patient.MiddleName = "";
                            if (objHLMessage.Patient_lastname != "")
                                patient.LastName = objHLMessage.Patient_lastname;
                            else
                                patient.LastName = "";
                            patient.RegistrationRemarks = Relevant_Clinical_Information;
                            patient.StateID = objHLMessage.StateID;
                            //patient.SpeciesName = "";
                            //Code End
                            //objcontext.RoleName = string.IsNullOrEmpty(objHLMessage.ControlType) ? "" : objHLMessage.ControlType;
                            patient.ExternalPatientNumber = ExternalPatientNumber;
                            MsgError += "Before executing InsertPatientBilling in ORUInBoundMessage" + Environment.NewLine;
                            returncode = new Patient_BL(objcontext).InsertPatientBillingHL(patient, objFinalBill, 0,
                                                                     -1, 0, lstPatientDueChart, 0, "",
                                                                     0, "", "Paid", gUID, dtAmountReceivedDet, lstOrdinv, lstTaxDetails,
                                                                     out lstBillingDetails, out returnStatus, -1, "", RoleId, LoginId, pageContextDetails,
                                                                     "", 0, WardDetails, 0, 0, 0, 0, "", dtSampleDate, "", new List<ControlMappingDetails>(), "N",
                                                                     out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID, 0, 0, "",
                                                                     ExternalPatientVisitNumber, "", out taskid, "", lstPatientDiscount, "", "", "", "", "", 0, "", 0, 0, 0, 0, 0,
                                                                     EXVisitType, ORCNumber, MigratedvisitNumber, MigratedReferNumber, lstPatientRedemDetails, lstOrdinv, "", "", 0, "", "", "", "",
                                                                     Person_Identifier, physicianPNo, FutureDate, ReportMode, PatientRegDateTime, OrderedDateTime, HLEnteredBy, reportClientid, IsCumulative, ParentOrder,
                                                                Relevant_Clinical_Information, Placer_Field2, Collectors_Comment, "");
                            MsgError += "After executing InsertPatientBilling in ORUInBoundMessage" + Environment.NewLine;
                            //returncode = new Patient_BL(objcontext).InsertPatientBilling(patient, objFinalBill, 0,
                            //                                         -1, 0, lstPatientDueChart, 0, "",
                            //                                         0, "", "Paid", gUID, dtAmountReceivedDet, lstOrdinv, lstTaxDetails,
                            //                                         out lstBillingDetails, out returnStatus, -1, "", RoleId, LoginId, pageContextDetails,
                            //                                         "", 0, WardDetails, 0, 0, 0, 0, "", dtSampleDate, "", new List<ControlMappingDetails>(), "N",
                            //                                         out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID, 0, 0, "",
                            //                                         objHLMessage.ExternalVisitNumber, "", out taskid, "", lstPatientDiscount, "", "", "", "", "", 0, "", 0, 0, 0, 0, 0,
                            //                                         lstPatientRedemDetails, lstOrdinv, "", "", 0, "", Person_Identifier,
                            //                                         "", "");
                            long pVisitID = 0;
                            if (lstBillingDetails.Count > 0)
                            {
                                pVisitID = lstBillingDetails[0].VisitID;
                            }
                            String ExternalVisitBarcodeImg = String.Empty;
                            ExternalVisitBarcodeImg = GetConfigValue("ExternalVisitBarcodeImg", orgID);
                            MsgError += "Before executing SaveReportBarcode in ORUInBoundMessage" + Environment.NewLine;
                            if (ExternalVisitBarcodeImg == "Y")
                            {
                                new BarcodeHelper().SaveReportBarcode(pVisitID, orgID, ExternalPatientVisitNumber, "PVN");
                            }
                            else
                            {
                                new BarcodeHelper().SaveReportBarcode(pVisitID, orgID, lstBillingDetails[0].VersionNo, "PVN");
                            }
                            MsgError += "After executing SaveReportBarcode in ORUInBoundMessage" + Environment.NewLine;
                            if (returncode >= 0)
                            {
                                Role_BL roleBL = new Role_BL(objcontext);
                                List<Role> lstrole = new List<Role>();
                                List<Role> lstroletemp = new List<Role>();
                                long retCode = roleBL.GetRoleName(orgID, out lstrole);
                                objcontext = SetContextDetailsInBound(orgID, "en-GB", OrgAddressID, RoleId, LoginId);
                                lstroletemp = lstrole.Where(x => x.RoleName == "Accession").ToList();
                                if (lstroletemp.Count > 0)
                                {
                                    Patient_BL PB = new Patient_BL(objcontext);
                                    loadCollectSampleList(orgID, lstroletemp[0].RoleID, OrgAddressID, pVisitID, gUID, Dvisitid);
                                    Tasks_BL oTasksBL = new Tasks_BL(objcontext);
                                    oTasksBL.UpdateTask(taskid, TaskHelper.TaskStatus.Completed, LoginId);
                                    long returnCode1 = PB.InsertUnRegisteredUserDetails(ExternalPatientVisitNumber, orgID);
                                }
                                Patient_BL objPatient = new Patient_BL(objcontext);
                                List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                                MsgError += "Before executing GetSecBarCodeDetForSamples in ORUInBoundMessage" + Environment.NewLine;
                                long returnCode = objPatient.GetSecBarCodeDetForSamples(pVisitID, orgID, out lstPatientInvSample);
                                MsgError += "After executing GetSecBarCodeDetForSamples in ORUInBoundMessage" + Environment.NewLine;
                                List<BarcodeAttributes> lstBarcodeAttributes = null;
                                List<BarcodePattern> lstBarcodePattern = null;


                                if (lstPatientInvSample.Count > 0)
                                {
                                    string CategoryCode = "ContainerRg";
                                    string lstPatientVisitID = pVisitID.ToString();
                                    string lstSampleId = lstPatientInvSample[0].SampleDesc;
                                    lstBarcodeAttributes = new List<BarcodeAttributes>();
                                    lstBarcodePattern = new List<BarcodePattern>();
                                    BarcodeHelper objBarcodeHelper = new BarcodeHelper();
                                    PrintBarcode objPrintBarcode;
                                    List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                                    string MachineID = string.Empty;
                                    returnCode = new GateWay(objcontext).GetBarcodeAttributeNValues(orgID, lstPatientVisitID, lstSampleId, 0, CategoryCode, out lstBarcodeAttributes, out lstBarcodePattern);
                                    if (lstBarcodeAttributes.Count > 0)
                                    {
                                        foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                                        {
                                            objPrintBarcode = new PrintBarcode();
                                            objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                                            objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                                            objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                                            objPrintBarcode.MachineID = MachineID;
                                            objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                                            objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                                            objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                                            objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                                            objPrintBarcode.RightHeaderLine1 = objBarcodeAttributes.RightHeaderLine1;
                                            objPrintBarcode.RightHeaderLine2 = objBarcodeAttributes.RightHeaderLine2;
                                            objPrintBarcode.RightHeaderLine3 = objBarcodeAttributes.RightHeaderLine3;
                                            objPrintBarcode.RightHeaderLine4 = objBarcodeAttributes.RightHeaderLine4;
                                            objPrintBarcode.RightHeaderLine5 = objBarcodeAttributes.RightHeaderLine5;
                                            objPrintBarcode.RightHeaderLine6 = objBarcodeAttributes.RightHeaderLine6;
                                            objPrintBarcode.RightHeaderLine7 = objBarcodeAttributes.RightHeaderLine7;

                                            //objPrintBarcode.RightHeaderFontFamily = objBarcodeAttributes.RightHeaderFontFamily;
                                            //objPrintBarcode.RightHeaderFontSize = objBarcodeAttributes.RightHeaderFontSize;
                                            //objPrintBarcode.RightHeaderFontStyle = objBarcodeAttributes.RightHeaderFontStyle;
                                            lstPrintBarcode.Add(objPrintBarcode);
                                        }
                                    }
                                    if (lstPrintBarcode.Count > 0)
                                    {
                                        GateWay objGateWay = new GateWay(objcontext);
                                        int returnStat = -1;
                                        MsgError += "Before executing SaveBarcodePrintDetails in ORUInBoundMessage" + Environment.NewLine;
                                        objGateWay.SaveBarcodePrintDetails(lstPrintBarcode, out returnStat);
                                        MsgError += "After executing SaveBArcodePrintDetails in ORUInBoundMessage" + Environment.NewLine;
                                    }
                                }
                            }
                        }
                        //if (objcontext.RoleName == "XO")
                        //{
                        //    returncode = 1;
                        //}
                    }
                    else
                    {
                        Adderror("Ordered Test Missing");
                        Errorlist = Error.Split(',');
                        Errorcode1 = "0";
                    }
                }


                //}
                //else
                //{
                // Errorlist = Error.Split(',');
                // Errorcode1 = "0";
                // returncode = new Patient_BL(objcontext).insertHLMessage(objHLMessage, "2", "", HL7Msg);
                //}
            }
            MsgError += "Before executing GetXmlErrorDescription in ORUInBoundMessage" + Environment.NewLine;
            string s = GetXmlErrorDescription(Errorlist, objHLMessage, HL7Msg, objcontext, returncode);
            MsgError += "After executing GetXmlErrorDescription in ORUInBoundMessage" + Environment.NewLine;
            // ReturnXML = GetXmlerror(Errorlist, objHLMessage, HL7Msg, objcontext, returncode);
            PageErrorCode = Errorcode1;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting ORUInBoundMessage() Method in HL7Integrationservice", ex);
            MsgError += "Error while Getting ORUInBoundMessage() Method in HL7Integrationservice" + ex.InnerException.ToString() + Environment.NewLine;
        }
        return ReturnXML;
    }
    #endregion
    #region GetOrgDetailsInBound
    // Getting OrganizationID and OrgAddressId from XML
    private void GetOrgDetailsInBound(HLMessages objHLMessage, out int Orgid, out int OrgAddressId)
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
            Returncode = objPatientBL.GetOrgDetails("LALPATH LABS", "Delhi", out objorgnaization);
            if (objorgnaization.Count > 0)
            {
                Orgid = objorgnaization[0].OrgID;
                OrgAddressId = Convert.ToInt32(objorgnaization[0].ReferTypeID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetOrgDetails() Method in HL7Integrationservice", ex);
        }
    }
    #endregion
    #region GetLoginDetailsInBound
    //Getting LoginID and RoleID from XML

    private void GetLoginDetailsInBound(HLMessages objHLMessage, out long LoginId, out int RoleId)
    {
        LoginId = 0;
        RoleId = 0;
        long Returncode = 0;

        GateWay objGateWay = new GateWay();
        List<Login> objLogin = new List<Login>();
        try
        {
            Returncode = objGateWay.GetLoginDetails(objHLMessage.LoginName, objHLMessage.RoleName, out objLogin);
            if (objLogin.Count > 0)
            {
                LoginId = objLogin[0].LoginID;
                RoleId = Convert.ToInt32(objLogin[0].OrgID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetLoginDetails() Method in HL7Integrationservice", ex);
        }
    }
    #endregion
    #region SetContextDetailsInBound
    //Saving Basic Details into Context Info 
    private ContextDetails SetContextDetailsInBound(int OrgId, string LanguageCode, int LocationId, int RoleId, long LoginId)
    {
        ContextDetails objcontext = new ContextDetails();
        objcontext.OrgID = OrgId;
        objcontext.LanguageCode = LanguageCode;
        objcontext.LocationID = LocationId;
        objcontext.RoleID = RoleId;
        objcontext.LoginID = LoginId;
        return objcontext;
    }
    #endregion

    #region GetHLMesssgeDetailsInBoundDetails
    private HLMessages GetHLMesssgeDetailsInBoundDetails(XElement xelement, string HL7Msg, out string PageErrorCode)
    {
        HLMessages objHLMessage = new HLMessages();
        HLMessageHeaderDetails objHLMessageHeader = new HLMessageHeaderDetails();
        HLMessagePatientIDDetails objHLMessagePatientID = new HLMessagePatientIDDetails();
        HLMessageORCDetails objHLMessageORC = new HLMessageORCDetails();
        HLMessageOBRDetails objHLMessageOBR = new HLMessageOBRDetails();
        HLMessageErrorDetails objHLMessageErrorDetails = new HLMessageErrorDetails();
        List<HLMessageOBRDetails> objHLMessageOBRContent = new List<HLMessageOBRDetails>();
        ContextDetails objcontext = new ContextDetails();
        List<HLMessageHeaderDetails> lstHLMessageHeaderDetails = new List<HLMessageHeaderDetails>();
        List<HLMessageOBRDetails> lstHLMessageOBRDetails = new List<HLMessageOBRDetails>();
        List<HLMessageORCDetails> lstHLMessageORCDetails = new List<HLMessageORCDetails>();
        List<HLMessagePatientIDDetails> lstHLMessagePatientIDDetails = new List<HLMessagePatientIDDetails>();

        List<HLMessages> lstHLMessages = new List<HLMessages>();
        int orgID = 0, OrgAddressID = 0, RoleId = 0;
        long LoginId = 0, returncode = -1;
        string MessageControlID = "";
        PageErrorCode = "";
        string strOBR7Status = "";
        string strPID7Status = "";
        string strOBR27Status = "";
        string strOBR27Test = "";
        try
        {
            var ItemName = "";
            var HLDetails = xelement.Descendants("Record");
            /*Message Header Count*/
            int MsgctrlidCount = xelement.Descendants("Message_control_id").Count();
            int MsgTypecount = xelement.Descendants("Trigger_Event").Count();
            int SAppCount = xelement.Descendants("Sending_Application").Count();
            int SFacCount = xelement.Descendants("Sending_Facility").Count();
            int RAppCount = xelement.Descendants("Receiving_Application").Count();
            int RFacCount = xelement.Descendants("Receiving_Facility").Count();
            int SecurityCount = xelement.Descendants("Security").Count();
            int ProcessingIDCount = xelement.Descendants("Processing_ID").Count();
            int VersionIDCount = xelement.Descendants("Version_ID").Count();
            /*End Message Header Count*/

            int PatientIdCount = xelement.Descendants("ID_Number").Count();
            int PatientidNewCount = xelement.Descendants("Patient_Identifier_List").Count();
            int PatientNameCount = xelement.Descendants("Patient_Name").Count();
            int ExtVisitidcount = xelement.Descendants("Visit_Number").Count();
            int PatientDobCount = xelement.Descendants("Date-time_Of_Birth").Count();
            int PatientSexCount = xelement.Descendants("Date-Administrative_Sex").Count();
            int PatientAddrCount = xelement.Descendants("Patient_Address").Count();
            int PatientHomePhoneCount = xelement.Descendants("Phone_Number_home").Count();
            int PatientPhoneCount = xelement.Descendants("Phone_Number_Business").Count();
            //int PCountryCount = xelement.Descendants("Patient_Country").Count();
            //int PStateCount = xelement.Descendants("Patient_State").Count();
            int OrderNoCount = xelement.Descendants("Placer_Order_Number").Count();
            int clientcodecount = xelement.Descendants("Entered_By").Count();
            int LoginnameCount = xelement.Descendants("LoginName").Count();
            int RoleNameCount = xelement.Descendants("RoleName").Count();
            int NTE = xelement.Descendants("NTE").Count();
            var HLData = xelement.Descendants("Message_Type");
            var PVAssiginedLoc = xelement.Descendants("Assigned_Patient_Location").Count();
            var PVPriorPatLoc = xelement.Descendants("Prior_Patient_Location").Count();
            var PriorPatientid = xelement.Descendants("Prior_Patient_ID").Count();
            var Order_Control = xelement.Descendants("Order_Control").Count();
            var Order_Control_Type = xelement.Descendants("Order_Control");

            int PlacerGroupNumber = xelement.Descendants("Placer_Group_Number").Count();
            int QuantityTimingcount = xelement.Descendants("Quantity-Timing").Count();
            var AttendingDRcount = xelement.Descendants("Attending_Doctor").Count();
            var Patient_Class = xelement.Descendants("Patient_Class").Count();
            var Ordering_Provider = xelement.Descendants("Ordering_Provider").Count();
            //Ramkumar ADDED
            var SpeceisName = xelement.Descendants("Species_Code").Count();
            var Age = xelement.Descendants("Multiple_Birth_Indicator").Count();
            var OrderLocation = xelement.Descendants("Enterer_Location").Count();
            var Confidential = xelement.Descendants("Confidentially_Code").Count();
            var ResultCopies = xelement.Descendants("Result_Copies_To").Count();
            //var ReportType = xelement.Descendants("Result_Copies_To").Count();

            //var  = xelement.Descendants("Enterer's Location").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();

            GetOrgDetailsInBound(objHLMessage, out orgID, out OrgAddressID);
            GetLoginDetailsInBound(objHLMessage, out LoginId, out RoleId);



            if (MsgTypecount > 0)
            {
                foreach (var objHLdata in HLData)
                {
                    objHLMessage.MsgType = objHLdata.Value;

                }
            }
            List<string> lstContent = new List<string>();
            lstContent = HL7Msg.Split('\r').ToList();
            if (strFileDetails.Contains("~"))
            {
                objHLMessage.FileNames = strFileDetails.Split('~')[0];
                objHLMessage.FileCreatedAt = Convert.ToDateTime(Convert.ToDateTime(strFileDetails.Split('~')[1]).ToString("dd/MM/yyyy hh:mm:ss tt"));
                objHLMessage.FileModifiedAt = Convert.ToDateTime(Convert.ToDateTime(strFileDetails.Split('~')[2]).ToString("dd/MM/yyyy hh:mm:ss tt"));
            }
            //if (objHLMessage.MsgType == "" && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Message_Type" && p.TableCode == "MSH")))
            if (objHLMessage.MsgType == "")
            {
                Adderror("Message_Type");
                //objHLMessageErrorDetails = new HLMessageErrorDetails();
                //objHLMessageErrorDetails.HLMessageError = "Message_Type";
                //objHLMessageErrorDetails.OrgID = orgID;
                //objHLMessageErrorDetails.LocationID = OrgAddressID;
                //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
            }
            List<HLMessages> lstobjHLMessages = new List<HLMessages>();
            List<Organization> lstOrgName = new List<Organization>();
            returncode = new Patient_BL().GetPatientData("", "", 0, out lstobjHLMessages);
            Investigation_BL oInvestigationBL = new Investigation_BL(objcontext);
            string strOBRSetID = "";
            foreach (var HL in HLDetails)
            {
                var OCR = xelement.Descendants("ORC");
                string strSendingApp = "";
                string strSendingFacility = "";
                string strReceivingApp = "";
                string strReceivingFacility = "";
                string strProcessingType = "";
                string ApplicationStatus = "Y";
                string strOtherLocation = "N";
                string strORCOrderControl = "";
                string strPIDSetID = "";

                int intOrgID = 0;
                PageErrorCode += "GetHLMesssgeDetailsInBoundDetails Method Started" + System.Environment.NewLine;
                HLMessageErrorDetails objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                if (OCR.Count() == 0)
                {
                    ApplicationStatus = "N";
                }
                foreach (var objOCR in OCR)
                {
                    string strEntererLocation = "";
                    objHLMessageORC = new HLMessageORCDetails();
                    if (objOCR.Elements("Enterer_Location").Any())
                    {
                        strEntererLocation = objOCR.Element("Enterer_Location").Value;
                        objHLMessageORC.Enterer_Location = strEntererLocation;// objOCR.Element("Enterer_Location").Value;
                    }
                    if (strEntererLocation.Trim() != "")
                    {
                        var temp = lstobjHLMessages.FindAll(P => P.LocationCode == strEntererLocation);
                        if (temp.Count > 0)
                        {
                            strSendingApp = temp[0].Sending_App;
                            strSendingFacility = temp[0].Sending_Facility;
                            strReceivingApp = temp[0].Rec_App;
                            strReceivingFacility = temp[0].Rec_Facility;
                            strProcessingType = temp[0].ProcessingType;
                            intOrgID = temp[0].OrgId;
                            if (intOrgAddressID != -1)
                            {
                                intOrgAddressID = temp[0].OrgAddressID;
                                OrgAddressID = temp[0].OrgAddressID;
                            }
                        }
                        else
                        {
                            temp = lstobjHLMessages.FindAll(P => P.Locations == "Y");
                            strSendingApp = temp[0].Sending_App;
                            strSendingFacility = temp[0].Sending_Facility;
                            strReceivingApp = temp[0].Rec_App;
                            strReceivingFacility = temp[0].Rec_Facility;
                            strProcessingType = temp[0].ProcessingType;
                            intOrgID = temp[0].OrgId;
                            if (intOrgAddressID != -1)
                            {
                                intOrgAddressID = 0;
                                OrgAddressID = 0;
                            }
                            strOtherLocation = "Y";
                            ApplicationStatus = "N";
                        }
                    }
                    else
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "Enterer_Location - Missing";
                        objHLMessageErrorDetails.HLMessageColumns = "ORC 13";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                }
                long returnval = oInvestigationBL.GetTestProcessingOrgName(intOrgID, "OUT", out lstOrgName);
                if (ApplicationStatus == "N")
                {
                    PageErrorCode += "ORC Not Contain Organization Locations" + System.Environment.NewLine;
                    //objHLMessageErrorDetails1=new HLMessageErrorDetails ();
                    //objHLMessageErrorDetails1.HLMessageError="ORC Not Contain Organization Locations";
                }
                else
                {
                    PageErrorCode += "ORC Contain Registered Locations" + System.Environment.NewLine;
                }
                objcontext = SetContextDetailsInBound(intOrgID, "en-GB", intOrgAddressID, RoleId, LoginId);
                returncode = new AdminReports_BL(objcontext).GetUserNames("HLMessages", intOrgID, "Users", "A", out lstOrgUsers);
                if (lstOrgUsers.Count > 0)
                {
                    LoginId = lstOrgUsers[0].LoginID;
                }
                List<HLMessageMandatoryDetails> lstHLMessageMandatoryDetails = new List<HLMessageMandatoryDetails>();
                long returnCode = new Patient_BL(objcontext).GetHLMessageMandatoryDetails(intOrgID, intOrgAddressID, out lstHLMessageMandatoryDetails);
                string strMSHLastNode = "";
                string strORCLastNode = "";
                string strOBRLastNode = "";
                string strPIDLastNode = "";
                string strMSHNodeError = "";
                string strORCNodeError = "";
                string strOBRNodeError = "";
                string strPIDNodeError = "";
                string strDOBError = "";
                DateTime DOBDate = DateTime.MaxValue;
                if (lstHLMessageMandatoryDetails.Count > 0)
                {
                    strMSHLastNode = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageHeaderDetails" && p.HLMessageColumns == "Last_Node").TableCode.ToString();
                    strORCLastNode = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageORCDetails" && p.HLMessageColumns == "Last_Node").TableCode.ToString();
                    strOBRLastNode = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageOBRDetails" && p.HLMessageColumns == "Last_Node").TableCode.ToString();
                    strPIDLastNode = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessagePatientIDDetails" && p.HLMessageColumns == "Last_Node").TableCode.ToString();
                    strMSHNodeError = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageHeaderDetails" && p.HLMessageColumns == "Last_Node").ErrorMessage.ToString();
                    strORCNodeError = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageORCDetails" && p.HLMessageColumns == "Last_Node").ErrorMessage.ToString();
                    strOBRNodeError = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessageOBRDetails" && p.HLMessageColumns == "Last_Node").ErrorMessage.ToString();
                    strPIDNodeError = lstHLMessageMandatoryDetails.SingleOrDefault(p => p.HLMessageTable == "HLMessagePatientIDDetails" && p.HLMessageColumns == "Last_Node").ErrorMessage.ToString();
                }
                //Message Header
                var MSH = xelement.Descendants("MSH");
                foreach (var objMSH in MSH)
                {
                    string MSHLastNode = objMSH.LastNode.ToString();
                    if (!MSHLastNode.Contains(strMSHLastNode))
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = strMSHNodeError;
                        objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "MSH";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    objHLMessageHeader = new HLMessageHeaderDetails();
                    objHLMessage.Msg_Content = xelement.ToString();
                    if (objMSH.Elements("Encoding_Characters").Any())
                    {
                        objHLMessageHeader.Encoding_Characters = objMSH.Element("Encoding_Characters").Value;
                    }
                    if (SAppCount > 0)
                    {
                        objHLMessageHeader.Sending_Application = objMSH.Element("Sending_Application").Value;
                        objHLMessage.Sending_App = objMSH.Element("Sending_Application").Value;

                    }
                    if (string.IsNullOrEmpty(objHLMessageHeader.Sending_Application))
                    {
                        Adderror("Sending_Application");
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "Sending_Application";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "MSH";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }

                    if (SFacCount > 0)
                    {
                        objHLMessageHeader.Sending_Facility = objMSH.Element("Sending_Facility").Value;
                        objHLMessage.Sending_Facility = objMSH.Element("Sending_Facility").Value;
                        objHLMessageHeader.HLMessageHeaderContent = "";
                        var MSHMessSendFacCount = objMSH.Descendants("Sending_Facility").Count();
                        if (MSHMessSendFacCount > 0)
                        {
                            var MSHMessSendFac = objMSH.Descendants("Sending_Facility");
                            foreach (var objMSSendFac in MSHMessSendFac)
                            {
                                if (objMSSendFac.Elements("Namespace_ID").Any())
                                    objHLMessageHeader.SFNamespace_ID = objMSSendFac.Element("Namespace_ID").Value;
                                if (objMSSendFac.Elements("Universal_ID").Any())
                                    objHLMessageHeader.Trigger_Event = objMSSendFac.Element("Universal_ID").Value;
                            }
                        }
                    }
                    //if (objHLMessageHeader.Sending_Facility == "" && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Sending_Facility")))
                    if (objHLMessageHeader.Sending_Facility == "")
                    {
                        Adderror("Sending_Facility");
                        //objHLMessageErrorDetails = new HLMessageErrorDetails();
                        //objHLMessageErrorDetails.HLMessageError = "Sending_Facility";
                        //objHLMessageErrorDetails.OrgID = orgID;
                        //objHLMessageErrorDetails.LocationID = OrgAddressID;
                        //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    if (RAppCount > 0)
                    {
                        objHLMessage.Rec_App = objMSH.Element("Receiving_Application").Value;
                        objHLMessageHeader.Receiving_Application = objMSH.Element("Receiving_Application").Value;
                    }
                    if (objHLMessageHeader.Receiving_Application == "")
                    //    if (objHLMessageHeader.Receiving_Application == "" && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Receiving_Application")))
                    {
                        Adderror("Receiving_Application");
                        //objHLMessageErrorDetails = new HLMessageErrorDetails();
                        //objHLMessageErrorDetails.HLMessageError = "Receiving_Application";
                        //objHLMessageErrorDetails.OrgID = orgID;
                        //objHLMessageErrorDetails.LocationID = OrgAddressID;
                        //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    if (RFacCount > 0)
                    {
                        objHLMessage.Rec_Facility = objMSH.Element("Receiving_Facility").Value;
                        objHLMessageHeader.Receiving_Facility = objMSH.Element("Receiving_Facility").Value;
                    }
                    var MessageDate1 = "";
                    string strMsgDateError = "";
                    MessageDate1 = objMSH.Element("Message_Date_Time").Value;
                    MessageDate = GetDateFormat(MessageDate1, out strMsgDateError);
                    //if (MessageDateFormat != DateTime.MinValue)
                    //    MessageDate = MessageDateFormat;
                    if (strMsgDateError.Trim() != "")
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "Message_Date_Time Invalid Format";
                        objHLMessageErrorDetails.HLMessageColumns = "MSH 6";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "MSH";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    objHLMessageHeader.Message_Date_Time = MessageDate;
                    objHLMessage.Transaction_Date_Time = MessageDate;
                    if (SecurityCount > 0)
                    {
                        objHLMessageHeader.MessageSecurity = objMSH.Element("Security").Value;
                    }
                    var MSHMessTypeCount = objMSH.Descendants("Message_Type").Count();
                    if (MSHMessTypeCount > 0)
                    {
                        var MSHMessType = objMSH.Descendants("Message_Type");
                        foreach (var objMST in MSHMessType)
                        {
                            objHLMessageHeader.Message_Type = objMST.Element("Message_Code").Value;
                            objHLMessageHeader.Message_Code = objMST.Element("Message_Code").Value;
                            objHLMessageHeader.Trigger_Event = objMST.Element("Trigger_Event").Value;
                            objHLMessage.MsgType = objMST.Element("Message_Code").Value;
                            if (objMST.Elements("Message_Structure").Any())
                            {
                                objHLMessageHeader.Message_Structure = objMST.Element("Message_Structure").Value;
                            }
                        }
                    }

                    if (MsgctrlidCount > 0)
                    {
                        objHLMessageHeader.Message_control_id = objMSH.Element("Message_control_id").Value;
                        objHLMessage.MsgControlId = objMSH.Element("Message_control_id").Value;
                        MessageControlID = objMSH.Element("Message_control_id").Value;
                    }
                    if ((objHLMessageHeader.Message_control_id == "" || MsgctrlidCount == 0))
                    //    if ((objHLMessageHeader.Message_control_id != "" || MsgctrlidCount == 0) && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Message_control_id")))
                    {
                        Adderror("Message_control_id");
                        //objHLMessageErrorDetails = new HLMessageErrorDetails();
                        //objHLMessageErrorDetails.HLMessageError = "Message_control_id";
                        //objHLMessageErrorDetails.OrgID = orgID;
                        //objHLMessageErrorDetails.LocationID = OrgAddressID;
                        //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    if (ProcessingIDCount > 0)
                    {
                        objHLMessageHeader.Processing_ID = objMSH.Element("Processing_ID").Value;
                    }
                    if (VersionIDCount > 0)
                    {
                        objHLMessageHeader.Version_ID = objMSH.Element("Version_ID").Value;
                    }
                    objHLMessageHeader.OrgID = intOrgID;
                    objHLMessageHeader.LocationID = intOrgAddressID;
                    if (lstContent.Count > 0)
                    {
                        if (lstContent[0].Contains("MSH|"))
                        {
                            objHLMessageHeader.HLMessageHeaderContent = lstContent[0].ToString();
                        }
                    }
                    lstHLMessageHeaderDetails.Add(objHLMessageHeader);
                    objHLMessageHeader = null;



                    //if (objHLMessage.Rec_Facility == "")
                    //{
                    //    Adderror("Receiving_Facility");
                    //}
                }
                PageErrorCode += "Got MSH Details" + System.Environment.NewLine;
                if (ApplicationStatus.Trim() != "N")
                {
                    if (strSendingApp.Trim() != "")
                    {
                        if ((!(lstHLMessageHeaderDetails.Exists(p => p.Sending_Application.ToUpper() == strSendingApp.ToUpper()))) || (!(lstHLMessageHeaderDetails.Exists(p => p.Sending_Facility.ToUpper() == strSendingFacility.ToUpper()))))
                        {
                            ApplicationStatus = "N";
                            PageErrorCode += "Sending Application is Not Matched" + System.Environment.NewLine;
                            Adderror(PageErrorCode);
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = "Sending Application is Not Matched";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageColumns = "MSH 2";
                            objHLMessageErrorDetails.HLMessageTable = "MSH";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                        if ((!(lstHLMessageHeaderDetails.Exists(p => p.Receiving_Application.ToUpper() == strReceivingApp.ToUpper()))) || (!(lstHLMessageHeaderDetails.Exists(p => p.Receiving_Facility.ToUpper() == strReceivingFacility.ToUpper()))))
                        {
                            ApplicationStatus = "N";
                            PageErrorCode += "Receiving Application is Not Matched" + System.Environment.NewLine;
                            Adderror(PageErrorCode);
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = "Receiving Application is Not Matched";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageColumns = "MSH 4";
                            objHLMessageErrorDetails.HLMessageTable = "MSH";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                        if ((!(lstHLMessageHeaderDetails.Exists(p => p.Processing_ID.ToUpper() == strProcessingType.ToUpper()))))
                        {
                            ApplicationStatus = "N";
                            PageErrorCode += "Processing Type is Not Matched" + System.Environment.NewLine;
                            Adderror(PageErrorCode);
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = "Processing Type is Not Matched";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageColumns = "MSH 11";
                            objHLMessageErrorDetails.HLMessageTable = "MSH";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                    }
                }
                #region ApplicationStatus is Success

                // Patient Merge
                var MRGPriorPatient = xelement.Descendants("Prior_Patient_ID");
                if (PriorPatientid > 0)
                {
                    foreach (var objpriorpid in MRGPriorPatient)
                    {
                        if (objpriorpid.Descendants("Prior_ID_Number").Count() > 0)
                        {
                            string pidnumber = objpriorpid.Element("Prior_ID_Number").Value;
                            objHLMessage.PriorIdNumber = string.IsNullOrEmpty(objpriorpid.Element("Prior_ID_Number").Value) ? "" : pidnumber;
                        }
                        else
                        {
                            objHLMessage.PriorIdNumber = "";
                        }
                    }

                }
                #endregion
                // Patient Merge


                //Getting Patient Details
                #region Getting Patient Details
                var PID = xelement.Descendants("PID");
                objHLMessage.Patient_ID = "-1";
                PageErrorCode += "Getting Patient Details" + System.Environment.NewLine;
                try
                {
                    if (PID.Count() == 0)
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "PID Node is missing";
                        objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "MSH";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    foreach (var objPID in PID)
                    {
                        string PIDLastNode = objPID.LastNode.ToString();
                        if (!PIDLastNode.Contains(strPIDLastNode))
                        {
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = strPIDNodeError;
                            objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageTable = "PID";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                        objHLMessagePatientID = new HLMessagePatientIDDetails();
                        if (PatientIdCount > 0)
                        {
                            if (objPID.Elements("Event_Type").Any())
                            {
                                objHLMessagePatientID.PIDEvent_Type = objPID.Element("Event_Type").Value;
                            }
                            if (objPID.Elements("Set_ID_PID").Any())
                            {
                                objHLMessagePatientID.Set_ID_PID = objPID.Element("Set_ID_PID").Value;
                                strPIDSetID = objHLMessagePatientID.Set_ID_PID;
                            }
                            var PLIST = xelement.Descendants("Patient_Identifier_List");
                            foreach (var ObjPList in PLIST)
                            {
                                int ID_Number = ObjPList.Descendants("ID_Number").Count();
                                int Identifier_Check_Digit = ObjPList.Descendants("Identifier_Check_Digit").Count();
                                int Check_Digit_Scheme = ObjPList.Descendants("Check_Digit_Scheme").Count();
                                //if (ObjPList.Descendants("Set_ID_PID").Any())
                                //    objHLMessagePatientID.Set_ID_PID = ObjPList.Descendants("Set_ID_PID").ToString();
                                if (ID_Number > 0)
                                {
                                    int index1 = 0;
                                    index1 = ObjPList.Element("ID_Number").Value.IndexOf("^");
                                    if (index1 > 0)
                                        ObjPList.Element("ID_Number").Value = ObjPList.Element("ID_Number").Value.Substring(0, index1);
                                    objHLMessage.Patient_ID = ObjPList.Element("ID_Number").Value;
                                    objHLMessage.PatientIdentifier = ObjPList.Element("ID_Number").Value;
                                    objHLMessagePatientID.Patient_ID = ObjPList.Element("ID_Number").Value;
                                    objHLMessagePatientID.Identifier_Check_Digit = ObjPList.Element("Identifier_Check_Digit").Value;
                                    objHLMessagePatientID.Check_Digit_Scheme = ObjPList.Element("Check_Digit_Scheme").Value;
                                    objHLMessagePatientID.ID_Number = ObjPList.Element("ID_Number").Value;
                                    if (ObjPList.Elements("PID.3.3").Any())
                                    {
                                        objHLMessagePatientID.PIDAssigning_Authority = ObjPList.Element("PID.3.3").Value;
                                    }
                                    if (ObjPList.Elements("PID.3.4").Any())
                                    {
                                        objHLMessagePatientID.PIDIdentifier_Type_Code = ObjPList.Element("PID.3.4").Value;
                                    }
                                    if ((objHLMessage.Patient_ID == "" || objHLMessage.Patient_ID == "-1"))
                                    //if ((objHLMessage.Patient_ID == "" || objHLMessage.Patient_ID == "-1") && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "ID_Number" && p.TableCode == "PID")))
                                    {
                                        Adderror("ID_Number");
                                        //objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        //objHLMessageErrorDetails.HLMessageError = "ID_Number";
                                        //objHLMessageErrorDetails.OrgID = orgID;
                                        //objHLMessageErrorDetails.LocationID = OrgAddressID;
                                        //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    }
                                }
                            }
                            if (PatientidNewCount > 0)
                            {
                                int ID_Number = objPID.Descendants("ID_Number").Count();
                                int Identifier_Check_Digit = objPID.Descendants("Identifier_Check_Digit").Count();
                                int Check_Digit_Scheme = objPID.Descendants("Check_Digit_Scheme").Count();

                                var PLISTNEw = xelement.Descendants("Patient_Identifier_List");
                                foreach (var ObjPList in PLISTNEw)
                                {
                                    if (ObjPList.Elements("ID_Number").Any())
                                    {
                                        objHLMessage.Patient_ID = ObjPList.Element("ID_Number").Value;
                                        objHLMessage.PatientIdentifier = ObjPList.Element("ID_Number").Value;
                                        objHLMessagePatientID.Patient_Identifier_List = ObjPList.Element("ID_Number").Value + ObjPList.Element("Identifier_Check_Digit").Value + ObjPList.Element("Check_Digit_Scheme").Value;
                                        objHLMessagePatientID.ID_Number = ObjPList.Element("ID_Number").Value;
                                        objHLMessagePatientID.Identifier_Check_Digit = ObjPList.Element("Identifier_Check_Digit").Value;
                                        objHLMessagePatientID.Check_Digit_Scheme = ObjPList.Element("Check_Digit_Scheme").Value;
                                    }
                                    if (ObjPList.Elements("Check_Digit_Scheme").Any())
                                    {
                                        objHLMessagePatientID.Check_Digit_Scheme = ObjPList.Element("Check_Digit_Scheme").Value;
                                    }
                                }

                                if (objHLMessage.Patient_ID == "" || objHLMessage.Patient_ID == "-1")
                                {
                                    Adderror("Patient_Identifier_List");
                                    //objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    //objHLMessageErrorDetails.HLMessageError = "Patient_Identifier_List";
                                    //objHLMessageErrorDetails.OrgID = orgID;
                                    //objHLMessageErrorDetails.LocationID = OrgAddressID;
                                    //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                //}

                            }
                            if (PatientNameCount > 0)
                            {
                                var PNameList = xelement.Descendants("Patient_Name");
                                string strPatientName = "";
                                foreach (var ObjNameList in PNameList)
                                {
                                    int FNAMECount = ObjNameList.Descendants("Given_Name").Count();
                                    int MNAMECount = ObjNameList.Descendants("Second_and_further_given_Names_or_Initials_Thereof").Count();
                                    int LNAMECount = ObjNameList.Descendants("Family_Name").Count();

                                    string FName = string.Empty;
                                    string MName = string.Empty;
                                    string LName = string.Empty;
                                    if (FNAMECount > 0)
                                    {
                                        FName = string.IsNullOrEmpty(ObjNameList.Element("Given_Name").Value) ? "" : ObjNameList.Element("Given_Name").Value;
                                    }
                                    if (MNAMECount > 0)
                                    {
                                        MName = string.IsNullOrEmpty(ObjNameList.Element("Second_and_further_given_Names_or_Initials_Thereof").Value) ? "" : ObjNameList.Element("Second_and_further_given_Names_or_Initials_Thereof").Value;
                                    }
                                    if (LNAMECount > 0)
                                    {
                                        LName = string.IsNullOrEmpty(ObjNameList.Element("Family_Name").Value) ? "" : ObjNameList.Element("Family_Name").Value;
                                    }

                                    if (FNAMECount == 0 && MNAMECount == 0 && LNAMECount == 0)
                                    {
                                        objHLMessage.Patient_fname = objPID.Element("Patient_Name").Value;
                                    }
                                    else
                                    {
                                        //if (MName != "")
                                        //    MName = " " + MName + " ";
                                        //else
                                        //    FName = FName + " ";

                                        string fname = FName;
                                        string mname = "";
                                        if (MName != "")
                                            mname = MName + " ";
                                        if (FName != "")
                                            fname = FName + " ";

                                        objHLMessage.Patient_fname = fname + mname + LName.ToString();
                                        objHLMessage.Patient_firstname = FName.ToString();
                                        objHLMessage.Patient_lastname = LName.ToString();
                                        objHLMessage.Patient_middlename = MName.ToString();
                                        objHLMessagePatientID.Patient_Name = fname + mname + LName.ToString().Trim();
                                        strPatientName = fname + mname + LName.ToString().Trim();
                                        objHLMessagePatientID.PIDFamily_Name = LName.ToString();
                                        objHLMessagePatientID.Given_Name = FName.ToString();
                                        objHLMessagePatientID.Second_and_further_given_Names_or_Initials_Thereof = MName.ToString();
                                        if (ObjNameList.Elements("Suffix").Any())
                                        {
                                            objHLMessagePatientID.PIDSuffix = ObjNameList.Element("Suffix").Value;
                                        }
                                        if (ObjNameList.Elements("Prefix").Any())
                                        {
                                            objHLMessagePatientID.PIDPrefix = ObjNameList.Element("Prefix").Value;
                                        }
                                        if (ObjNameList.Elements("Degree").Any())
                                        {
                                            objHLMessagePatientID.PIDDegree = ObjNameList.Element("Degree").Value;
                                        }
                                    }

                            //if (objHLMessage.Patient_fname == "")
                            //{
                           //     Adderror("Patient_Name");
                            //    objHLMessageErrorDetails = new HLMessageErrorDetails();
                           //     objHLMessageErrorDetails.HLMessageError = "Patient_Name";
                           //             objHLMessageErrorDetails.OrgID = intOrgID;
                           //             objHLMessageErrorDetails.LocationID = intOrgAddressID;
                           //             objHLMessageErrorDetails.HLMessageTable = "PID";
                           //     lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                          //  }
                           //         else
				if (objHLMessage.Patient_fname.Trim() != "")
                                    {
                                        Regex RgxUrl = new Regex("[^a-z0-9A-Z/_ ]");
                                        if (RgxUrl.IsMatch(strPatientName))
                                        {
                                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails.HLMessageColumns = "PID 5";
                                            objHLMessageErrorDetails.HLMessageError = "Special Character Not allowed";
                                            objHLMessageErrorDetails.OrgID = intOrgID;
                                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails.HLMessageTable = "PID";
                                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                        }
                                    }
                                }
                            }

                            objHLMessage.OrgId = intOrgID;
                            long LocationID = 0;
                            Int64.TryParse(intOrgAddressID.ToString(), out LocationID);
                            objHLMessage.LocationID = LocationID;
                            //if (PatDOB != "")
                            //{
                            //    string day = PatDOB.Substring(6, 2);
                            //    string month = PatDOB.Substring(4, 2);
                            //    string year = PatDOB.Substring(0, 4);
                            //    string date = day + "/" + month + "/" + year;
                            //    objHLMessage.Patient_DOB = Convert.ToDateTime(date);
                            //    objHLMessagePatientID.Date_time_Of_Birth = Convert.ToDateTime(date);
                            //}
                            //  if (objHLMessage.Patient_DOB == DateTime.MaxValue && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Date_time_Of_Birth")))
                            //objHLMessageErrorDetails = new HLMessageErrorDetails();
                            //objHLMessageErrorDetails.HLMessageError = "Date-time_Of_Birth";
                            //objHLMessageErrorDetails.OrgID = orgID;
                            //objHLMessageErrorDetails.LocationID = OrgAddressID;
                            //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            if (PatientSexCount > 0)
                            {
                                objHLMessage.Patient_Sex = objPID.Element("Date-Administrative_Sex").Value;
                                objHLMessagePatientID.Date_Administrative_Sex = objPID.Element("Date-Administrative_Sex").Value;
                            }
                            if (objHLMessage.Patient_Sex == "U")
                            {
                                objHLMessage.Patient_Sex = "M";
                                // Adderror("Patient_Sex");
                            }
                            if (objPID.Elements("Patient_Alies").Any())
                            {
                                objHLMessagePatientID.Patient_Alies = objPID.Element("Patient_Alies").Value;
                            }
                            if (objPID.Elements("Race").Any())
                            {
                                objHLMessagePatientID.Race = objPID.Element("Race").Value;
                            }
                            if (PatientAddrCount > 0)
                            {
                                var PAddress = xelement.Descendants("Patient_Address");
                                foreach (var ObjAddressList in PAddress)
                                {
                                    objHLMessage.Patient_Address = ObjAddressList.Element("Street_Mailing_Address").Value + "," + ObjAddressList.Element("City").Value + "," + ObjAddressList.Element("Zip_Or_Postal_Code").Value;
                                    objHLMessagePatientID.Patient_Address = ObjAddressList.Element("Street_Mailing_Address").Value + "," + ObjAddressList.Element("City").Value + "," + ObjAddressList.Element("Zip_Or_Postal_Code").Value;
                                    objHLMessagePatientID.Street_Mailing_Address = ObjAddressList.Element("Street_Mailing_Address").Value;
                                    objHLMessagePatientID.City = ObjAddressList.Element("City").Value;
                                    if (ObjAddressList.Elements("State_Of_Province").Any())
                                    {
                                        objHLMessagePatientID.State_Of_Province = ObjAddressList.Element("State_Of_Province").Value;
                                    }
                                    if (ObjAddressList.Elements("Zip_Or_Postal_Code").Any())
                                    {
                                        objHLMessagePatientID.Zip_Or_Postal_Code = ObjAddressList.Element("Zip_Or_Postal_Code").Value;
                                    }
                                    if (ObjAddressList.Elements("Country").Any())
                                    {
                                        objHLMessagePatientID.Country = ObjAddressList.Element("Country").Value;
                                    }

                                }
                            }
                            if (objPID.Elements("Country_Code").Any())
                            {
                                objHLMessagePatientID.PIDCountry_Code = objPID.Element("Country_Code").Value;
                            }
                            if (objPID.Elements("Primary_Language").Any())
                            {
                                objHLMessagePatientID.Primary_Language = objPID.Element("Primary_Language").Value;
                            }
                            if (objPID.Elements("Primary_Language").Any())
                            {
                                objHLMessagePatientID.Primary_Language = objPID.Element("Primary_Language").Value;
                            }
                            if (objPID.Elements("Marital_Status").Any())
                            {
                                objHLMessagePatientID.Marital_Status = objPID.Element("Marital_Status").Value;
                            }
                            if (objPID.Elements("Religion").Any())
                            {
                                objHLMessagePatientID.Religion = objPID.Element("Religion").Value;
                            }
                            if (objPID.Elements("Patient_Account_Number").Any())
                            {
                                objHLMessagePatientID.Patient_Account_Number = objPID.Element("Patient_Account_Number").Value;
                            }
                            if (objPID.Elements("SSN_Number_Patient").Any())
                            {
                                objHLMessagePatientID.SSN_Number_Patient = objPID.Element("SSN_Number_Patient").Value;
                            }
                            if (objPID.Elements("Driver_License_Number_Patient").Any())
                            {
                                objHLMessagePatientID.Driver_License_Number_Patient = objPID.Element("Driver_License_Number_Patient").Value;
                            }
                            if (objPID.Elements("Mother_Identifier").Any())
                            {
                                objHLMessagePatientID.Mother_Identifier = objPID.Element("Mother_Identifier").Value;
                            }
                            if (objPID.Elements("Ethnic_Group").Any())
                            {
                                objHLMessagePatientID.Ethnic_Group = objPID.Element("Ethnic_Group").Value;
                            }
                            if (objPID.Elements("Birth_Place").Any())
                            {
                                objHLMessagePatientID.Birth_Place = objPID.Element("Birth_Place").Value;
                            }
                            if (objPID.Elements("Multiple_Birth_Indicator").Any())
                            {
                                objHLMessagePatientID.Multiple_Birth_Indicator = objPID.Element("Multiple_Birth_Indicator").Value;
                            }
                            if (objPID.Elements("Birth_Order").Any())
                            {
                                objHLMessagePatientID.Birth_Order = objPID.Element("Birth_Order").Value;
                            }
                            if (objPID.Elements("Citizenship").Any())
                            {
                                objHLMessagePatientID.Citizenship = objPID.Element("Citizenship").Value;
                            }
                            if (objPID.Elements("Alteration_Patient_ID_PID").Any())
                            {
                                objHLMessagePatientID.Alteration_Patient_ID_PID = objPID.Element("Alteration_Patient_ID_PID").Value;
                            }
                            if (objPID.Elements("Mother_Maiden_Name").Any())
                            {
                                objHLMessagePatientID.Mother_Maiden_Name = objPID.Element("Mother_Maiden_Name").Value;
                            }
                            if (objPID.Elements("Phone_Number_home").Any())
                            {
                                var PHPhone = xelement.Descendants("Phone_Number_home");
                                foreach (var ObjPHPhone in PHPhone)
                                {
                                    if (ObjPHPhone.Elements("HTelephone_Number").Any())
                                    {
                                        objHLMessagePatientID.HTelephone_Number = ObjPHPhone.Element("HTelephone_Number").Value;
                                    }
                                    if (ObjPHPhone.Elements("HTelecommunication_use_code").Any())
                                    {
                                        objHLMessagePatientID.HTelecommunication_use_code = ObjPHPhone.Element("HTelecommunication_use_code").Value;
                                    }
                                    if (ObjPHPhone.Elements("HTelecommunication_Equipment_Type").Any())
                                    {
                                        objHLMessagePatientID.HTelecommunication_Equipment_Type = ObjPHPhone.Element("HTelecommunication_Equipment_Type").Value;
                                    }
                                    if (ObjPHPhone.Elements("HCommunication_Address").Any())
                                    {
                                        objHLMessagePatientID.HCommunication_Address = ObjPHPhone.Element("HCommunication_Address").Value;
                                    }
                                }
                            }
                            if (objPID.Elements("Telecommunication_use_code").Any())
                            {
                                objHLMessagePatientID.Telecommunication_use_code = objPID.Element("Telecommunication_use_code").Value;
                            }
                            if (objPID.Elements("Telecommunication_Equipment_Type").Any())
                            {
                                objHLMessagePatientID.Telecommunication_Equipment_Type = objPID.Element("Telecommunication_Equipment_Type").Value;
                            }
                            if (objPID.Elements("Communication_Address").Any())
                            {
                                objHLMessagePatientID.Communication_Address = objPID.Element("Communication_Address").Value;
                            }
                            if (PatientHomePhoneCount > 0)
                            {
                                //if (PatientHomePhoneCount == 1)
                                //{
                                //  objHLMessage.Patient_HomePhone = objPID.Element("Phone_Number_home").Value;
                                //}
                                //else
                                //{
                                //var Phomephone = xelement.Descendants("Phone_Number_home");
                                //foreach (var ObjPhoneList in Phomephone)
                                //{
                                objHLMessage.Patient_HomePhone = objPID.Element("Phone_Number_home").Value;
                                objHLMessagePatientID.Phone_Number_home = objPID.Element("Phone_Number_home").Value;
                                //}
                                //}
                            }

                            if (PatientPhoneCount > 0)
                            {
                                //if (PatientPhoneCount == 1)
                                //{
                                //    objHLMessage.Patient_Businessphone = objPID.Element("Phone_Number_Business").Value;
                                //}
                                //else
                                //{
                                //var PBusinessphone = xelement.Descendants("Phone_Number_Business");
                                //foreach (var ObjPhoneLists in PBusinessphone)
                                //{
                                if (objPID.Elements("Phone_Number_Business").Any())
                                {
                                    objHLMessage.Patient_Businessphone = objPID.Element("Phone_Number_Business").Value;
                                    objHLMessagePatientID.HPhone_Number_Business = objPID.Element("Phone_Number_Business").Value;
                                    objHLMessagePatientID.HBTelephone_Number = objPID.Element("Phone_Number_Business").Value;
                                    //}
                                }

                                //if (SpeceisName > 0)
                                //{
                            }
                            if (objPID.Elements("Veterans_Military_Status").Any())
                            {
                                objHLMessagePatientID.Veterans_Military_Status = objPID.Element("Veterans_Military_Status").Value;
                            }
                            if (objPID.Elements("Nationality").Any())
                            {
                                objHLMessagePatientID.Nationality = objPID.Element("Nationality").Value;
                            }
                            if (objPID.Elements("Patient_Death_Indicator").Any())
                            {
                                objHLMessagePatientID.Patient_Death_Indicator = objPID.Element("Patient_Death_Indicator").Value;
                            }
                            if (objPID.Elements("Identity_Unknown_Indicator").Any())
                            {
                                objHLMessagePatientID.Identity_Unknown_Indicator = objPID.Element("Identity_Unknown_Indicator").Value;
                            }
                            if (objPID.Elements("Identity_reliability_Code").Any())
                            {
                                objHLMessagePatientID.Identity_reliability_Code = objPID.Element("Identity_reliability_Code").Value;
                            }
                            //if (SpeceisName > 0)
                            //{
                            //For LAL Path
                            strConfig = GetConfigValue("HL7MessageIntegration", intOrgID);
                            //if (strConfig == "Need Changes in Common HL7Message")
                            //{
                            //    objHLMessage.SpeciesName = string.IsNullOrEmpty(objPID.Element("Last_Update_Facility").Value) ? "" : objPID.Element("Last_Update_Facility").Value;
                            //    objHLMessagePatientID.Species_Code = string.IsNullOrEmpty(objPID.Element("Last_Update_Facility").Value) ? "" : objPID.Element("Last_Update_Facility").Value;
                            //    objHLMessagePatientID.Last_Update_Facility = string.IsNullOrEmpty(objPID.Element("Last_Update_Facility").Value) ? "" : objPID.Element("Last_Update_Facility").Value;
                            //}
                            //else
                            //{
                            objHLMessage.SpeciesName = string.IsNullOrEmpty(objPID.Element("Species_Code").Value) ? "" : objPID.Element("Species_Code").Value;
                            objHLMessagePatientID.Species_Code = string.IsNullOrEmpty(objPID.Element("Species_Code").Value) ? "" : objPID.Element("Species_Code").Value;
                            objHLMessagePatientID.Last_Update_Facility = string.IsNullOrEmpty(objPID.Element("Last_Update_Facility").Value) ? "" : objPID.Element("Last_Update_Facility").Value;
                            //}
                            //if ((objHLMessagePatientID.Species_Code == "" || MsgctrlidCount == 0) && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Species_Code")))
                            //{
                            //    objHLMessageErrorDetails = new HLMessageErrorDetails();
                            //    objHLMessageErrorDetails.HLMessageError = "Species_Code";
                            //    objHLMessageErrorDetails.OrgID = orgID;
                            //    objHLMessageErrorDetails.LocationID = OrgAddressID;
                            //    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            //}
                            var SexAge = "";
                            var AgeMonth = "";
                            int intAge = 0;
                            if (Age > 0)
                            {
                                //SexAge = string.IsNullOrEmpty(objPID.Element("Multiple_Birth_Indicator").Value) ? "" : objPID.Element("Multiple_Birth_Indicator").Value;
                                //AgeMonth = string.IsNullOrEmpty(objPID.Element("Birth_Order").Value) ? "" : objPID.Element("Birth_Order").Value;
                                SexAge = string.IsNullOrEmpty(objPID.Element("Birth_Order").Value) ? "" : objPID.Element("Birth_Order").Value;
                                AgeMonth = string.IsNullOrEmpty(objPID.Element("Multiple_Birth_Indicator").Value) ? "" : objPID.Element("Multiple_Birth_Indicator").Value;
                                if (!string.IsNullOrEmpty(SexAge))
                                    Int32.TryParse(SexAge, out intAge);
                                if (intAge < 0)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Birth_Order Invalid";
                                    objHLMessageErrorDetails1.HLMessageColumns = "PID 25";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "PID";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessagePatientID.Multiple_Birth_Indicator = AgeMonth;
                                objHLMessagePatientID.Birth_Order = SexAge;
                                string agetype = string.Empty;


                                switch (AgeMonth)
                                {
                                    case "T":
                                        agetype = "Minute(s)";
                                        break;
                                    case "H":
                                        agetype = "Hour(s)";
                                        break;
                                    case "D":
                                        agetype = "Day(s)";
                                        break;
                                    case "W":
                                        agetype = "Week(s)";
                                        break;
                                    case "M":
                                        agetype = "Month(s)";
                                        break;
                                    case "Y":
                                        agetype = "Year(s)";
                                        break;
                                    default:
                                        agetype = "";
                                        break;

                                }

                                Ageandtype = SexAge.ToString() + agetype.ToString();
                            }

                            if (objPID.Elements("Date-time_Of_Birth").Any())
                            {
                                var PatDOB = "";
                                PatDOB = objPID.Element("Date-time_Of_Birth").Value;

                                DOBDate = GetDateFormat(PatDOB, out strDOBError);
                                //if (DOBDate1 != DateTime.MinValue)
                                //    DOBDate = DOBDate1;
                                if (strDOBError.Trim() != "" || PatDOB.Trim().Length > 14)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Date-time_Of_Birth Invalid Format";
                                    objHLMessageErrorDetails1.HLMessageColumns = "PID 7";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "PID";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    strPID7Status = "True";
                                }
                                objHLMessage.Patient_DOB = DOBDate;
                                objHLMessagePatientID.Date_time_Of_Birth = DOBDate;
                            }
                            if (objHLMessage.Patient_DOB == DateTime.MaxValue)
                            {
                                if (SexAge != "" && AgeMonth != "")
                                {
                                    DateTime dtDOB = DateTime.Now;
                                    dtDOB = GetDOB(SexAge, AgeMonth);
                                    objHLMessage.Patient_DOB = dtDOB;
                                    objHLMessagePatientID.Date_time_Of_Birth = dtDOB;
                                }
                            }
                            objHLMessagePatientID.Patient_Death_Date_and_Time = DateTime.MaxValue;
                            objHLMessagePatientID.Last_Updated_DateTime = DateTime.MaxValue;
                            objHLMessagePatientID.OrgID = intOrgID;
                            objHLMessagePatientID.LocationID = intOrgAddressID;
                            objHLMessagePatientID.HLMessagePatientIDContent = "";
                            if (lstContent.Count > 0)
                            {
                                if (lstContent[1].Contains("PID|"))
                                {
                                    objHLMessagePatientID.HLMessagePatientIDContent = lstContent[1].ToString();
                                }
                            }
                            lstHLMessagePatientIDDetails.Add(objHLMessagePatientID);
                            objHLMessagePatientID = null;
                        }
                    }
                }
                catch (Exception ex1)
                {
                    CLogger.LogError("Error while Getting Patient Details GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex1);
                }
                #endregion
                #region Getting Order details
                string Order_ControlType = string.Empty;
                PageErrorCode += "Getting ORC Details" + System.Environment.NewLine;
                try
                {
                    if (OCR.Count() == 0)
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "ORC Node is missing";
                        objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "ORC";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    foreach (var objOCR in OCR)
                    {
                        string strEntererLocation = "";
                        string ORCLastNode = objOCR.LastNode.ToString();
                        if (!ORCLastNode.Contains(strORCLastNode))
                        {
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = strORCNodeError;
                            objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageTable = "ORC";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                        objHLMessageORC = new HLMessageORCDetails();
                        if (objOCR.Elements("Enterer_Location").Any())
                        {
                            strEntererLocation = objOCR.Element("Enterer_Location").Value;
                            objHLMessageORC.Enterer_Location = strEntererLocation;// objOCR.Element("Enterer_Location").Value;
                        }
                        if (strEntererLocation != "")
                        {
                            var temp = lstobjHLMessages.FindAll(P => P.LocationCode == strEntererLocation);
                        }
                        if (objOCR.Elements("Order_Control").Any())
                        {
                            objHLMessageORC.Order_Control = objOCR.Element("Order_Control").Value;
                            strORCOrderControl = objHLMessageORC.Order_Control;
                        }
                        if (objOCR.Elements("Filler_Order_Number").Any())
                        {
                            objHLMessageORC.ORCFiller_Order_Number = objOCR.Element("Filler_Order_Number").Value;
                            var ORCFiller = xelement.Descendants("Patient_Address");
                            foreach (var ORCFillerList in ORCFiller)
                            {
                                if (ORCFillerList.Elements("Entity_Identifier").Any())
                                    objHLMessageORC.ORCFiller_Order_Number = ORCFillerList.Element("Filler_Order_Number").Value;
                            }
                        }
                        if (OrderNoCount > 0)
                        {
                            objHLMessage.Placer_Order_Number = objOCR.Element("Place_Order_Number").Value;
                            objHLMessageORC.Place_Order_Number = objOCR.Element("Place_Order_Number").Value;
                            var ORCPlacer = xelement.Descendants("Place_Order_Number");
                            foreach (var ORCPlacerList in ORCPlacer)
                            {
                                if (ORCPlacerList.Elements("Entity_Identifier").Any())
                                {
                                    objHLMessageORC.ORCFEntity_Identifier = ORCPlacerList.Element("Entity_Identifier").Value;
                                }
                            }
                        }
                        if (objHLMessage.Placer_Order_Number == "")
                        {
                            Adderror("Placer_Order_Number");
                        }
                        if (PlacerGroupNumber > 0)
                        {

                            var OPGN = xelement.Descendants("Placer_Group_Number");
                            foreach (var ObjGorupList in OPGN)
                            {
                                int ORReferCount = ObjGorupList.Descendants("Enity_Identifier").Count();
                                int PvMigcount = ObjGorupList.Descendants("ORC.4.1").Count();
                                if (ORReferCount > 0)
                                {
                                    MigratedReferNumber = string.IsNullOrEmpty(ObjGorupList.Element("Enity_Identifier").Value) ? "" : ObjGorupList.Element("Enity_Identifier").Value;
                                    objHLMessageORC.ORCPrEntity_Identifier = ObjGorupList.Element("Enity_Identifier").Value;
                                }
                                if (PvMigcount > 0)
                                {
                                    MigratedvisitNumber = string.IsNullOrEmpty(ObjGorupList.Element("ORC.4.1").Value) ? "" : ObjGorupList.Element("ORC.4.1").Value;
                                }
                            }
                        }
                        if (objOCR.Elements("Placer_Group_Number").Any())
                        {
                            objHLMessageORC.Placer_Group_Number = objOCR.Element("Placer_Group_Number").Value;
                        }
                        if (objOCR.Elements("Order_Status").Any())
                        {
                            objHLMessageORC.Order_Status = objOCR.Element("Order_Status").Value;
                        }
                        if (objOCR.Elements("Response_Flag").Any())
                        {
                            objHLMessageORC.Response_Flag = objOCR.Element("Response_Flag").Value;
                        }
                        if (objOCR.Elements("Quantity-Timing").Any())
                        {
                            objHLMessageORC.ORCQuantity_Timing = objOCR.Element("Quantity-Timing").Value;
                        }
                        if (objOCR.Elements("Quantity-Timing").Any())
                        {
                            objHLMessageORC.ORCQuantity_Timing = objOCR.Element("Quantity-Timing").Value;
                        }
                        if (QuantityTimingcount > 0)
                        {
                            var QtyTiming = xelement.Descendants("Quantity-Timing");
                            foreach (var objQtyTiming in QtyTiming)
                            {
                                int StatCode = objQtyTiming.Descendants("Priority").Count();
                                if (StatCode > 0 && !(string.IsNullOrEmpty(objQtyTiming.Element("Priority").Value)))
                                {
                                    istat = Convert.ToString(objQtyTiming.Element("Priority").Value);
                                    if (istat == "099" || istat == "010" || istat.ToUpper() == "S")
                                        issstat = "Y";
                                    else if (istat == "001")
                                        issstat = "N";
                                    objHLMessageORC.ORCPriority = issstat;
                                }
                                int Task_Date_Time = objQtyTiming.Descendants("Start_Date-Time").Count();
                                if (Task_Date_Time > 0 && !(string.IsNullOrEmpty(objQtyTiming.Element("Start_Date-Time").Value)))
                                {
                                    FutureDate = Convert.ToString(objQtyTiming.Element("Start_Date-Time").Value);
                                    var F_Date = "";
                                    F_Date = objQtyTiming.Element("Start_Date-Time").Value;
                                    string strStartDate = "";
                                    DateTime FuDate = DateTime.MaxValue;
                                    FuDate = GetDateFormat(F_Date, out strStartDate);
                                    //if (GetDateFormat(F_Date, out strStartDate) != DateTime.MinValue)
                                    //    FuDate = FuDate1;
                                    if (strStartDate.Trim() != "" || F_Date.Trim().Length > 14)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Start_Date-Time Invalid Format";
                                        objHLMessageErrorDetails1.HLMessageColumns = "OBR 27";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "ORC";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    }
                                    objHLMessage.Futuredate = FuDate;
                                    objHLMessageORC.Start_Date_Time = FuDate;
                                }
                                if (objQtyTiming.Elements("Quantity").Any())
                                {
                                    objHLMessageORC.Quantity = objQtyTiming.Element("Quantity").Value;
                                }
                                if (objQtyTiming.Elements("Interval").Any())
                                {
                                    objHLMessageORC.Interval = objQtyTiming.Element("Interval").Value;
                                }
                                if (objQtyTiming.Elements("Duration").Any())
                                {
                                    objHLMessageORC.Duration = objQtyTiming.Element("Duration").Value;
                                }
                                if (objQtyTiming.Elements("End_Date-Time").Any())
                                {
                                    string EndDate = Convert.ToString(objQtyTiming.Element("End_Date-Time").Value);
                                    var E_Date = "";
                                    E_Date = objQtyTiming.Element("End_Date-Time").Value;
                                    if (E_Date != "" && E_Date != "00000000000000")
                                    {
                                        string strEndDate = "";
                                        DateTime EnDate = DateTime.MaxValue;
                                        EnDate = GetDateFormat(E_Date, out strEndDate);
                                        //if (EnDate1 != DateTime.MinValue)
                                        //    EnDate = EnDate1;
                                        if (strEndDate.Trim() != "" || E_Date.Trim().Length > 14)
                                        {
                                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails.HLMessageError = "End_Date_Time Invalid Format";
                                            objHLMessageErrorDetails1.HLMessageColumns = "OBR 27";
                                            objHLMessageErrorDetails.OrgID = intOrgID;
                                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails.HLMessageTable = "ORC";
                                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                        }
                                        objHLMessage.Futuredate = EnDate;
                                        objHLMessageORC.End_Date_Time = EnDate;
                                    }
                                }
                            }
                        }
                        if (objOCR.Elements("Parent_Order").Any())
                        {
                            objHLMessageORC.Parent_Order = objOCR.Element("Parent_Order").Value;
                            var ParentOrder = xelement.Descendants("Parent_Order");
                            foreach (var objParentOrder in ParentOrder)
                            {
                                if (objParentOrder.Elements("Placer_Assigned_Identifier").Any())
                                {
                                    objHLMessageORC.Placer_Assigned_Identifier = objParentOrder.Element("Placer_Assigned_Identifier").Value;
                                }
                            }
                        }
                        var Transactiondate = "";
                        Transactiondate = objOCR.Element("Date-Time_Of_Transaction").Value;
                        if (Transactiondate != "" && Transactiondate != "00000000000000")
                        {
                            string strTransDate = "";
                            DateTime TransDate = DateTime.MaxValue;
                            TransDate = GetDateFormat(Transactiondate, out strTransDate);
                            //if (TransDate1 != DateTime.MinValue)
                            //    TransDate = TransDate1;
                            if (strTransDate.Trim() != "" || (Transactiondate.Trim().Length > 14 || Transactiondate.Trim().Length < 12))
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "Date-Time_Of_Transaction Invalid Format";
                                objHLMessageErrorDetails1.HLMessageColumns = "ORC 9";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "ORC";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            }
                            objHLMessage.Transaction_Date_Time = TransDate;
                            objHLMessageORC.Date_Time_Of_Transaction = TransDate;
                        }
                        objHLMessage.TransferDatetime = System.DateTime.Now;
                        if (clientcodecount > 0)
                        {
                            clientcode = objOCR.Element("Entered_By").Value;
                            objHLMessageORC.Entered_By = objOCR.Element("Entered_By").Value;
                            var EnteredBy = objOCR.Descendants("Entered_By");
                            foreach (var objEnteredBy in EnteredBy)
                            {
                                if (objEnteredBy.Elements("Person_Identifier").Any())
                                {
                                    objHLMessageORC.EnterPerson_Identifier = objEnteredBy.Element("Person_Identifier").Value;
                                }
                                if (objEnteredBy.Elements("Family_Name").Any())
                                {
                                    objHLMessageORC.EnterFamily_Name = objEnteredBy.Element("Family_Name").Value;
                                }
                                if (objEnteredBy.Elements("Given_Name").Any())
                                {
                                    objHLMessageORC.EnterGiven_Name = objEnteredBy.Element("Given_Name").Value;
                                }
                                if (objEnteredBy.Elements("Second_and_Further_Given_Names_or_Initials_Thereof").Any())
                                {
                                    objHLMessageORC.EnterSecond_and_Further_Given_Names_or_Initials_Thereof = objEnteredBy.Element("Second_and_Further_Given_Names_or_Initials_Thereof").Value;
                                }
                            }
                        }
                        if (objOCR.Elements("Ordering_Provider").Any())
                        {
                            objHLMessageORC.ORCOrdering_Provider = objOCR.Element("Ordering_Provider").Value;
                            var OrderedBy = objOCR.Descendants("Ordering_Provider");
                            foreach (var objOrderedBy in OrderedBy)
                            {
                                if (objOrderedBy.Elements("Person_Identifier").Any())
                                {
                                    objHLMessageORC.OrderingPerson_Identifier = objOrderedBy.Element("Person_Identifier").Value;
                                }
                                if (objOrderedBy.Elements("Family_Name").Any())
                                {
                                    objHLMessageORC.OrderingFamily_Name = objOrderedBy.Element("Family_Name").Value;
                                }
                                if (objOrderedBy.Elements("Given_Name").Any())
                                {
                                    objHLMessageORC.OrderingGiven_Name = objOrderedBy.Element("Given_Name").Value;
                                }
                                if (objOrderedBy.Elements("Second_and_Further_Given_Names_or_Initials_Thereof").Any())
                                {
                                    objHLMessageORC.OrderingSecond_and_Further_Given_Names_or_Initials_Thereof = objOrderedBy.Element("Second_and_Further_Given_Names_or_Initials_Thereof").Value;
                                }
                            }
                        }
                        if (objHLMessage.Placer_Order_Number == "")
                        {
                            Adderror("Entered_By");
                        }
                        if (objOCR.Elements("Verified_By").Any())
                        {
                            objHLMessageORC.Verified_By = objOCR.Element("Verified_By").Value;
                        }
                        int phypnocount = objOCR.Descendants("Call_Back_Phone_Number").Count();
                        if (phypnocount > 0 && !(string.IsNullOrEmpty(objOCR.Element("Call_Back_Phone_Number").Value)))
                        {
                            physicianPNo = string.IsNullOrEmpty(objOCR.Element("Call_Back_Phone_Number").Value) ? "" : (objOCR.Element("Call_Back_Phone_Number").Value);
                            int phycount = physicianPNo.Length;
                            // physicianPNo = physicianPNo.Substring(1, (phycount - 1));
                            objHLMessageORC.Call_Back_Phone_Number = physicianPNo;
                        }
                        if (objOCR.Elements("Order_Control_Code_Reason").Any())
                        {
                            objHLMessageORC.Order_Control_Code_Reason = objOCR.Element("Order_Control_Code_Reason").Value;
                        }
                        if (objOCR.Elements("Entering_Organization").Any())
                        {
                            objHLMessageORC.Entering_Organization = objOCR.Element("Entering_Organization").Value;
                        }
                        if (objOCR.Elements("Entering_Device").Any())
                        {
                            objHLMessageORC.Entering_Device = objOCR.Element("Entering_Device").Value;
                        }
                        if (objOCR.Elements("Action_By").Any())
                        {
                            objHLMessageORC.Action_By = objOCR.Element("Action_By").Value;
                        }
                        if (objOCR.Elements("Advanced_Beneficiary_Notice_Code").Any())
                        {
                            objHLMessageORC.Advanced_Beneficiary_Notice_Code = objOCR.Element("Advanced_Beneficiary_Notice_Code").Value;
                        }
                        if (objOCR.Elements("Ordering_Facility_Name").Any())
                        {
                            objHLMessageORC.Ordering_Facility_Name = objOCR.Element("Ordering_Facility_Name").Value;
                        }
                        if (objOCR.Elements("Ordering_Facility_Address").Any())
                        {
                            objHLMessageORC.Ordering_Facility_Address = objOCR.Element("Ordering_Facility_Address").Value;
                        }
                        if (objOCR.Elements("Ordering_Facility_Phone_Number").Any())
                        {
                            objHLMessageORC.Ordering_Facility_Phone_Number = objOCR.Element("Ordering_Facility_Phone_Number").Value;
                        }
                        if (objOCR.Elements("Ordering_Provider_Address").Any())
                        {
                            objHLMessageORC.Ordering_Provider_Address = objOCR.Element("Ordering_Provider_Address").Value;
                        }
                        if (objOCR.Elements("Order_Status_Modifier").Any())
                        {
                            objHLMessageORC.Order_Status_Modifier = objOCR.Element("Order_Status_Modifier").Value;
                        }
                        if (objOCR.Elements("Advanced_Beneficiary_Notice_Override_Reason").Any())
                        {
                            objHLMessageORC.Advanced_Beneficiary_Notice_Override_Reason = objOCR.Element("Advanced_Beneficiary_Notice_Override_Reason").Value;
                        }
                        if (objOCR.Elements("Confidentially_Code").Any())
                        {
                            objHLMessageORC.Confidentially_Code = objOCR.Element("Confidentially_Code").Value;
                        }
                        if (objOCR.Elements("Order_Type").Any())
                        {
                            objHLMessageORC.Order_Type = objOCR.Element("Order_Type").Value;
                        }
                        objHLMessage.OrderCreatedby = "Bala";
                        if (OrderLocation > 0)
                        {
                            objHLMessage.OrderedLocation = string.IsNullOrEmpty(objOCR.Element("Enterer_Location").Value) ? "" : objOCR.Element("Enterer_Location").Value;
                        }
                        if (Confidential > 0)
                        {
                            objHLMessage.Patient_Confidential = string.IsNullOrEmpty(objOCR.Element("Confidentially_Code").Value) ? "" : objOCR.Element("Confidentially_Code").Value;
                        }
                        objHLMessageORC.OrgID = intOrgID;
                        objHLMessageORC.LocationID = intOrgAddressID;
                        objHLMessageORC.HLMessageORCContent = "";
                        if (lstContent.Count > 0)
                        {
                            if (lstContent[2].Contains("ORC|"))
                            {
                                objHLMessageORC.HLMessageORCContent = lstContent[2].ToString();
                            }
                        }
                        lstHLMessageORCDetails.Add(objHLMessageORC);
                        objHLMessageORC = null;
                    }
                }
                catch (Exception ex1)
                {
                    CLogger.LogError("Error while Getting ORC Details GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex1);
                }
                #endregion
                #region Currently we are not use these segments
                /*Currently we are not use these segments*/
                // Getting Login Details
                var LID = xelement.Descendants("LID");
                if (LID.Count() > 0)
                {
                    PageErrorCode += "Getting LID Details" + System.Environment.NewLine;
                    foreach (var objLID in LID)
                    {
                        if (LoginnameCount > 0)
                        {
                            objHLMessage.LoginName = objLID.Element("LoginName").Value;
                        }
                        if (objHLMessage.LoginName == "")
                        {
                            Adderror("LoginName");
                        }
                        if (RoleNameCount > 0)
                        {
                            objHLMessage.RoleName = objLID.Element("RoleName").Value;
                        }
                        if (objHLMessage.RoleName == "")
                        {
                            Adderror("RoleName");
                        }
                    }
                }
                objHLMessage.LoginName = "Bala";
                objHLMessage.RoleName = "DataMigrator";
                objHLMessage.ExternalVisitNumber = "";
                //Getting Patient Visit Details
                var PV = xelement.Descendants("PV1");
                foreach (var objPV in PV)
                {
                    if (objPV.Descendants("Visit_Number").Count() > 0)
                    {
                        objHLMessage.ExternalVisitNumber = objPV.Element("Visit_Number").Value;
                    }
                    if (PVAssiginedLoc > 0)
                    {
                        var PVWardDetails = xelement.Descendants("Assigned_Patient_Location");
                        foreach (var objPVWard in PVWardDetails)
                        {
                            if (objPVWard.Descendants().Count() != 0)
                            {
                                string Facility = string.Empty;
                                string Location_Status = string.Empty;
                                string Point_Of_Care = string.Empty;
                                string Room = string.Empty;
                                string Bed = string.Empty;
                                int Facilitycount = objPVWard.Descendants("Facility").Count();
                                int LocStatuscount = objPVWard.Descendants("Location_Status").Count();
                                int Priorofcarecount = objPVWard.Descendants("Point_Of_Care").Count();
                                int PriorRoomcount = objPVWard.Descendants("Room").Count();
                                int PriorBedcount = objPVWard.Descendants("Bed").Count();
                                if (Priorofcarecount > 0)
                                {
                                    Point_Of_Care = string.IsNullOrEmpty(objPVWard.Element("Point_Of_Care").Value) ? "" : objPVWard.Element("Point_Of_Care").Value;
                                    objHLMessage.WardDeatils = Point_Of_Care;
                                }
                                if (PriorRoomcount > 0)
                                {
                                    Room = string.IsNullOrEmpty(objPVWard.Element("Room").Value) ? "" : objPVWard.Element("Room").Value;
                                    objHLMessage.WardDeatils += "`" + Room;
                                }
                                if (PriorBedcount > 0)
                                {
                                    Bed = string.IsNullOrEmpty(objPVWard.Element("Bed").Value) ? "" : objPVWard.Element("Bed").Value;
                                    objHLMessage.WardDeatils += "`" + Bed;
                                }
                                if (Facilitycount > 0)
                                {
                                    Facility = string.IsNullOrEmpty(objPVWard.Element("Facility").Value) ? "" : objPVWard.Element("Facility").Value;
                                    objHLMessage.WardDeatils += "`" + Facility;
                                }
                                if (LocStatuscount > 0)
                                {
                                    Location_Status = string.IsNullOrEmpty(objPVWard.Element("Location_Status").Value) ? "" : objPVWard.Element("Location_Status").Value;
                                    objHLMessage.WardDeatils += "`" + Location_Status;
                                }
                                ClientCodeWithTower = Point_Of_Care;
                            }
                        }
                    }
                    if (ExtVisitidcount > 0)
                    {
                        var ExtVisitDetails = xelement.Descendants("Visit_Number");
                        foreach (var objPVisitDetails in ExtVisitDetails)
                        {
                            int vidcount = objPVisitDetails.Descendants("ID").Count();
                            if (vidcount > 0)
                            {
                                string IDs = string.Empty;
                                IDs = string.IsNullOrEmpty(objPVisitDetails.Element("ID").Value) ? "" : objPVisitDetails.Element("ID").Value;
                                objHLMessage.ExternalVisitId = IDs;
                            }
                        }
                    }
                    if (PVPriorPatLoc > 0)
                    {
                        var PVPriorWardDetails = xelement.Descendants("Prior_Patient_Location");
                        foreach (var objPVWards in PVPriorWardDetails)
                        {
                            if (objPVWards.Descendants().Count() != 0)
                            {
                                string Facility1 = string.Empty;
                                string Location_Status1 = string.Empty;
                                string Prior_Of_Care = string.Empty;
                                string Room1 = string.Empty;
                                string Bed1 = string.Empty;
                                int Facilitycount1 = objPVWards.Descendants("Facility").Count();
                                int LocStatuscount1 = objPVWards.Descendants("Location_Status").Count();
                                int Priorofcarecount = objPVWards.Descendants("Point_Of_Care").Count();
                                int PriorRoomcount = objPVWards.Descendants("Room").Count();
                                int PriorBedcount = objPVWards.Descendants("Bed").Count();
                                if (Priorofcarecount > 0)
                                {
                                    Prior_Of_Care = string.IsNullOrEmpty(objPVWards.Element("Point_Of_Care").Value) ? "" : objPVWards.Element("Point_Of_Care").Value;
                                    objHLMessage.PriorWardDetails = Prior_Of_Care;
                                }
                                if (PriorRoomcount > 0)
                                {
                                    Room1 = string.IsNullOrEmpty(objPVWards.Element("Room").Value) ? "" : objPVWards.Element("Room").Value;
                                    objHLMessage.PriorWardDetails += "`" + Room1;
                                }
                                if (PriorBedcount > 0)
                                {
                                    Bed1 = string.IsNullOrEmpty(objPVWards.Element("Bed").Value) ? "" : objPVWards.Element("Bed").Value;
                                    objHLMessage.PriorWardDetails += "`" + Bed1;
                                }
                                if (Facilitycount1 > 0)
                                {
                                    Facility1 = string.IsNullOrEmpty(objPVWards.Element("Facility").Value) ? "" : objPVWards.Element("Facility").Value;
                                    objHLMessage.PriorWardDetails += "`" + Facility1;
                                }
                                if (LocStatuscount1 > 0)
                                {
                                    Location_Status1 = string.IsNullOrEmpty(objPVWards.Element("Location_Status").Value) ? "" : objPVWards.Element("Location_Status").Value;
                                    objHLMessage.PriorWardDetails += "`" + Location_Status1;
                                }
                            }
                        }
                    }
                    //if (AttendingDRcount > 0)
                    //{
                    //    var PVAttendingDR = xelement.Descendants("Attending_Doctor");
                    //    foreach (var OBJPVAttDr in PVAttendingDR)
                    //    {
                    //        int PIDCount = OBJPVAttDr.Descendants("Person_Identifier").Count();
                    //        int FNAMECount = OBJPVAttDr.Descendants("Family_Name").Count();
                    //        int GNAMECount = OBJPVAttDr.Descendants("Given_Name").Count();
                    //        if (PIDCount > 0 && FNAMECount > 0 && GNAMECount > 0)
                    //        {
                    //            string Person_Identifier = string.IsNullOrEmpty(OBJPVAttDr.Element("Person_Identifier").Value) ? "" : OBJPVAttDr.Element("Person_Identifier").Value;
                    //            string Family_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Family_Name").Value) ? "" : OBJPVAttDr.Element("Family_Name").Value;
                    //            string Given_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Given_Name").Value) ? "" : OBJPVAttDr.Element("Given_Name").Value;
                    //            ReffeingPhysicianName = Person_Identifier + "^" + Given_Name + " " + Family_Name;
                    //        }
                    //    }

                    //}


                    //  }
                    if (Patient_Class > 0)
                    {
                        objHLMessage.OrderStatus = string.IsNullOrEmpty(objPV.Element("Patient_Class").Value) ? "" : objPV.Element("Patient_Class").Value;
                        if (objHLMessage.OrderStatus == "I")
                        {
                            EXVType = 0;
                        }
                        else if (objHLMessage.OrderStatus == "O")
                        {
                            EXVType = 1;
                        }
                        else
                        {
                            EXVType = 2;
                        }

                    }


                }
                /*End Currently we are not use these segments*/
                #endregion

                //Getting Order details
                /*if (objHLMessage.Placer_Order_Number == "")
                    //if (objHLMessage.Placer_Order_Number == "" && (lstHLMessageMandatoryDetails.Exists(p => p.HLMessageColumns == "Placer_Order_Number")))
                {
                    Adderror("Placer_Order_Number");
                    //objHLMessageErrorDetails.HLMessageError = "Placer_Order_Number";
                    //objHLMessageErrorDetails.OrgID = orgID;
                    //objHLMessageErrorDetails.LocationID = OrgAddressID;
                    //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                }*/


                //Quantity-Timing
                //if (F_Date != "" && F_Date != "00000000000000")
                //{
                //    string day = F_Date.Substring(6, 2);
                //    string month = F_Date.Substring(4, 2);
                //    string year = F_Date.Substring(0, 4);
                //    string Hour = F_Date.Substring(8, 2);
                //    string Mins = F_Date.Substring(10, 2);
                //    string Sec = F_Date.Substring(12, 2);
                //    string date = day + "-" + month + "-" + year + " " + Hour + ":" + Mins + ":" + Sec;
                //    objHLMessage.Futuredate = Convert.ToDateTime(date);
                //    objHLMessageORC.Start_Date_Time = Convert.ToDateTime(date);
                //}

                //    string day = E_Date.Substring(6, 2);
                //    string month = E_Date.Substring(4, 2);
                //    string year = E_Date.Substring(0, 4);
                //    string Hour = E_Date.Substring(8, 2);
                //    string Mins = E_Date.Substring(10, 2);
                //    string Sec = E_Date.Substring(12, 2);
                //    string date = day + "-" + month + "-" + year + " " + Hour + ":" + Mins + ":" + Sec;
                //    objHLMessage.Futuredate = Convert.ToDateTime(date);
                //    objHLMessageORC.End_Date_Time = Convert.ToDateTime(date);
                //Quantity-Timing
                //string day = Transactiondate.Substring(6, 2);
                //string month = Transactiondate.Substring(4, 2);
                //string year = Transactiondate.Substring(0, 4);
                //string Hour = Transactiondate.Substring(8, 2);
                //string Mins = Transactiondate.Substring(10, 2);
                //string Sec = Transactiondate.Substring(12, 2);
                //string date = day + "-" + month + "-" + year + " " + Hour + ":" + Mins + ":" + Sec;
                //objHLMessage.Transaction_Date_Time = Convert.ToDateTime(date);
                //Transactiondate1 = Convert.ToDateTime(date);
                //objHLMessageORC.Date_Time_Of_Transaction = Transactiondate1;

                //clientcode = "GENERAL";

                /*if (objHLMessage.Placer_Order_Number == "")
                {
                    Adderror("Entered_By");
                    //objHLMessageErrorDetails.HLMessageError = "Entered_By";
                    //objHLMessageErrorDetails.OrgID = orgID;
                    //objHLMessageErrorDetails.LocationID = OrgAddressID;
                    //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                }*/
                // if (PIDCount > 0 && FNAMECount > 0 && GNAMECount > 0)

                //string Given_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Given_Name").Value) ? "" : OBJPVAttDr.Element("Given_Name").Value;
                //ReffeingPhysicianName = Person_Identifier + "^" + Given_Name + " " + Family_Name;


                //objHLMessage.OrderStatus = string.IsNullOrEmpty(objOCR.Element("Order_Status").Value) ? "" : objOCR.Element("Order_Status").Value;
                //if (objHLMessage.OrderStatus == "IP")
                //{
                //    EXVType = 0;
                //}
                //else if (objHLMessage.OrderStatus == "OP")
                //{
                //    EXVType = 1;
                //}
                //else
                //{
                //    EXVType = 2;
                //}








                //objHLMessage.OrderCreatedby = objOCR.Element("Entered_By").Value;
                //objHLMessage.TransferDatetime = DateTime.Now;



                if (Order_Control > 0)
                {
                    foreach (var ObjCType in Order_Control_Type)
                    {
                        objHLMessage.ControlType = string.IsNullOrEmpty(ObjCType.Value) ? "" : ObjCType.Value;
                    }
                }





                var NTComments = xelement.Descendants("NTE");
                //var Order_Control = xelement.Descendants("Order_Control");
                //if (Order_Control.ToString() == "NW")
                //{
                if (NTE > 0)
                {
                    foreach (var ObjNTE in NTComments)
                    {
                        if (ObjNTE.Descendants("NTE_Comment").Count() > 0)
                        {
                            objHLMessage.Remarks = ObjNTE.Element("NTE_Comment").Value;
                        }
                    }
                }
                //}
                #region Getting OBR Details



                var OBR = xelement.Descendants("OBR");
                int i = 0;
                int lineCount = 3;
                string grpName = string.Empty;
                string strORC1Flag = string.Empty;
                PageErrorCode += "Getting OBR Details" + System.Environment.NewLine;
                try
                {
                    if (OBR.Count() == 0 && strORCOrderControl.ToUpper() == "NW")
                    {
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "OBR Node is missing";
                        objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    if ((strPIDSetID != strORCOrderControl))
                    {
                        strORC1Flag = "Y";
                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                        objHLMessageErrorDetails.HLMessageError = "PID Set_ID not match with ORC Order Control and OBR Set_ID";
                        objHLMessageErrorDetails.HLMessageColumns = "ORC 1";
                        objHLMessageErrorDetails.OrgID = intOrgID;
                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                        objHLMessageErrorDetails.HLMessageTable = "ORC";
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                    }
                    foreach (var objOBR in OBR)
                    {
                        string OBRLastNode = objOBR.LastNode.ToString();
                        if (!OBRLastNode.Contains(strOBRLastNode))
                        {
                            objHLMessageErrorDetails = new HLMessageErrorDetails();
                            objHLMessageErrorDetails.HLMessageError = strOBRNodeError;
                            objHLMessageErrorDetails.HLMessageColumns = "Node Mismatch";
                            objHLMessageErrorDetails.OrgID = intOrgID;
                            objHLMessageErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageErrorDetails.HLMessageTable = "OBR";
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                        }
                        objHLMessageOBR = new HLMessageOBRDetails();
                        if (objOBR.Elements("Set_ID_OBR").Any())
                        {
                            objHLMessageOBR.Set_ID_OBR = objOBR.Element("Set_ID_OBR").Value;
                            if (strORC1Flag != "Y" && ((strOBRSetID != "" && strOBRSetID != objHLMessageOBR.Set_ID_OBR) || (strOBRSetID != "" && strOBRSetID != strORCOrderControl) || (strOBRSetID != "" && strOBRSetID != strPIDSetID)))
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "PID Set_ID not match with ORC Order Control and OBR Set_ID";
                                objHLMessageErrorDetails.HLMessageColumns = "OBR 1";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "OBR";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            }
                            strOBRSetID = objHLMessageOBR.Set_ID_OBR;
                        }
                        if (objOBR.Elements("Placer_Order_Number").Any())
                        {
                            objHLMessageOBR.Placer_Order_Number = objOBR.Element("Placer_Order_Number").Value;
                        }
                        if (objOBR.Elements("Filler_Order_Number").Any())
                        {
                            objHLMessageOBR.OBRFiller_Order_Number = objOBR.Element("Filler_Order_Number").Value;
                        }
                        if (objOBR.Elements("Universal_Service_Identifier").Any())
                        {
                            objHLMessageOBR.Universal_Service_Identifier = objOBR.Element("Universal_Service_Identifier").Value;
                            var objUniversalServiceIdentifier = xelement.Descendants("Universal_Service_Identifier");
                            foreach (var objUniversalService in objUniversalServiceIdentifier)
                            {

                                if (objUniversalService.Elements("Identifier").Any())
                                {
                                    objHLMessageOBR.OBRIdentifier = objOBR.Element("Identifier").Value;
                                }
                                if (objUniversalService.Elements("Text").Any())
                                {
                                    objHLMessageOBR.OBRText = objOBR.Element("Text").Value;
                                }
                                if (objUniversalService.Elements("Name_Of_Coding_System").Any())
                                {
                                    objHLMessageOBR.Name_Of_Coding_System = objOBR.Element("Name_Of_Coding_System").Value;
                                }
                            }
                        }
                        if (objOBR.Elements("Priority").Any())
                        {
                            Regex RgxUrl = new Regex("[^0-9]");
                            string strPriority = objOBR.Element("Priority").Value;
                            if (RgxUrl.IsMatch(strPriority) && strPriority.Trim() != "")
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "OBR Priority - Allowed only Numeric";
                                objHLMessageErrorDetails.HLMessageColumns = "OBR 5";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "OBR";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            }
                            else
                            {
                                objHLMessageOBR.OBRPriority = objOBR.Element("Priority").Value;
                            }
                        }
                        DateTime ObseDate = DateTime.MaxValue;
                        DateTime ObsenDate = DateTime.MaxValue;
                        DateTime TransDate = DateTime.MaxValue;
                        string strOberDateError = "";
                        string strObserEndError = "";
                        string strReqDateTime = "";
                        string ReqDateTime = "";
                        
                        objHLMessageOBR.Requested_Date_Time = TransDate;
                        if (objOBR.Elements("Requested_Date-Time").Any())
                        {
                            ReqDateTime = objOBR.Element("Requested_Date-Time").Value;
                            if (ReqDateTime != "" && ReqDateTime != "00000000000000")
                            {

                                TransDate = GetDateFormat(ReqDateTime, out strReqDateTime);
                                //if (TransDate1 != DateTime.MinValue)
                                //    TransDate = TransDate1;
                                if (strReqDateTime.Trim() != "" || (ReqDateTime.Trim().Length > 14 || ReqDateTime.Trim().Length < 12))
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Requested_Date-Time Invalid Format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 6";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessageOBR.Requested_Date_Time = TransDate;
                                if (DOBDate != DateTime.MaxValue && DOBDate > TransDate)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Requested_Date-Time Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 6";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                            }

                        }
                        objHLMessageOBR.Observation_Date_Time = ObseDate;
                        if (objOBR.Elements("Observation_Date-Time").Any())
                        {
                            string ObsDateTime = objOBR.Element("Observation_Date-Time").Value;
                            if (ObsDateTime != "" && ObsDateTime != "00000000000000")
                            {

                                ObseDate = GetDateFormat(ObsDateTime, out strOberDateError);
                                if (strOberDateError.Trim() != "" || (ObsDateTime.Trim().Length > 14 || ObsDateTime.Trim().Length < 12))
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Observation_Date-Time Invalid Format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 7";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    strOBR7Status = "True";
                                }
                                if (strOberDateError == "" && ObsDateTime != "" && strOBR7Status=="")
                                {
                                    if (ObseDate > DateTime.Now)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Observation_Date-Time future date is not allowed";
                                        objHLMessageErrorDetails.HLMessageColumns = "OBR 7";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                        strOBR7Status = "True";
                                    }
                                }
                                if (DOBDate != DateTime.MaxValue && DOBDate > ObseDate && strOBR7Status == "")
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Observation_Date-Time Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 7";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    strOBR7Status = "True";
                                }
                                objHLMessageOBR.Observation_Date_Time = ObseDate;
                            }
                        }
                        if (strReqDateTime == "" && ReqDateTime != "")
                        {
                            if (TransDate > DateTime.Now)
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "Requested_Date-Time future date is not allowed";
                                objHLMessageErrorDetails.HLMessageColumns = "OBR 6";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "OBR";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            }
                        }
                        if (strReqDateTime == "" && strOberDateError == "")
                        {
                            if (ObseDate != DateTime.MaxValue && ObseDate > TransDate && strOBR7Status == "")
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "Observation_Date-Time cannot be greater than Requested Date Time";
                                objHLMessageErrorDetails.HLMessageColumns = "OBR 7";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "OBR";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                strOBR7Status = "True";
                            }
                        }
                        objHLMessageOBR.Observation_End_Date_Time = ObsenDate;
                        if (objOBR.Elements("Observation_End_Date-Time").Any())
                        {
                            string ObsEnDateTime = objOBR.Element("Observation_End_Date-Time").Value;
                            if (ObsEnDateTime != "" && ObsEnDateTime != "00000000000000")
                            {

                                ObsenDate = GetDateFormat(ObsEnDateTime, out strObserEndError);
                                //if (ObsenDate1 != DateTime.MinValue)
                                //    ObsenDate = ObsenDate1;
                                if (strObserEndError.Trim() != "" || (ObsEnDateTime.Trim().Length > 14 || ObsEnDateTime.Trim().Length < 12))
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Observation_End_Date-Time Invalid Format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 8";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                if (DOBDate != DateTime.MaxValue && DOBDate > ObsenDate)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Observation_End_Date-Time Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 8";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessageOBR.Observation_End_Date_Time = ObsenDate;
                            }
                        }
                        if (objOBR.Elements("Collection_Volume").Any())
                        {
                            objHLMessageOBR.Collection_Volume = objOBR.Element("Collection_Volume").Value;
                        }
                        if (objOBR.Elements("Collector_Identifier").Any())
                        {
                            objHLMessageOBR.Collector_Identifier = objOBR.Element("Collector_Identifier").Value;
                        }
                        if (objOBR.Elements("Spicemen_Action_Code").Any())
                        {
                            objHLMessageOBR.Spicemen_Action_Code = objOBR.Element("Spicemen_Action_Code").Value;
                        }
                        if (objOBR.Elements("Danger_Code").Any())
                        {
                            objHLMessageOBR.Danger_Code = objOBR.Element("Danger_Code").Value;
                        }
                        if (objOBR.Elements("Relevant_Clinical_Information").Any())
                        {
                            string strRelevant = objOBR.Element("Relevant_Clinical_Information").Value;
                            Regex RgxUrl = new Regex("[|~\\\\^]");
                            if (RgxUrl.IsMatch(strRelevant))
                            {
                                objHLMessageErrorDetails = new HLMessageErrorDetails();
                                objHLMessageErrorDetails.HLMessageError = "Relevant_Clinical_Information - Special Character Not Allowed";
                                objHLMessageErrorDetails.HLMessageColumns = "OBR 13";
                                objHLMessageErrorDetails.OrgID = intOrgID;
                                objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails.HLMessageTable = "OBR";
                                lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                            }
                            else
                            {
                                objHLMessageOBR.Relevant_Clinical_Information = objOBR.Element("Relevant_Clinical_Information").Value;
                            }
                        }
                        if (objOBR.Elements("Specimen_Received_Date-Time").Any())
                        {
                            string SpeRecDateTime = objOBR.Element("Specimen_Received_Date-Time").Value;
                            if (SpeRecDateTime != "" && SpeRecDateTime != "00000000000000")
                            {
                                string strSpeError = "";
                                DateTime SpecDate = DateTime.MaxValue;
                                SpecDate = GetDateFormat(SpeRecDateTime, out strSpeError);
                                //if (SpecDate1 != DateTime.MinValue)
                                //    SpecDate = SpecDate1;
                                if (strSpeError.Trim() != "" || SpeRecDateTime.Trim().Length > 14)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Specimen_Received_Date-Time Invalid format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 14";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                if (DOBDate != DateTime.MaxValue && DOBDate > SpecDate)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Specimen_Received_Date-Time Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 14";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessageOBR.Specimen_Received_Date_Time = SpecDate;
                            }
                        }
                        if (objOBR.Elements("Specimen_Source").Any())
                        {
                            objHLMessageOBR.Specimen_Source = objOBR.Element("Specimen_Source").Value;
                        }
                        if (objOBR.Elements("Specimen_Source").Any())
                        {
                            objHLMessageOBR.Specimen_Source = objOBR.Element("Specimen_Source").Value;
                        }
                        if (objOBR.Elements("Ordering_Provider").Any())
                        {
                            objHLMessageOBR.OBROrdering_Provider = objOBR.Element("Ordering_Provider").Value;
                            var OrderingProvider = objOBR.Descendants("Ordering_Provider");
                            foreach (var objobjOrderingProvider in OrderingProvider)
                            {
                                if (objobjOrderingProvider.Elements("Person_Identifier").Any())
                                {
                                    objHLMessageOBR.Person_Identifier = objobjOrderingProvider.Element("Person_Identifier").Value;
                                }
                                if (objobjOrderingProvider.Elements("Family_Name").Any())
                                {
                                    objHLMessageOBR.OBRFamily_Name = objobjOrderingProvider.Element("Family_Name").Value;
                                }
                                if (objobjOrderingProvider.Elements("Given_Name").Any())
                                {
                                    objHLMessageOBR.Given_Name = objobjOrderingProvider.Element("Given_Name").Value;
                                }
                                if (objobjOrderingProvider.Elements("Second_and_Further_Given_Names_or_Initials_There_of").Any())
                                {
                                    objHLMessageOBR.Second_and_Further_Given_Names_or_Initials_There_of = objobjOrderingProvider.Element("Second_and_Further_Given_Names_or_Initials_There_of").Value;
                                }
                                if (objobjOrderingProvider.Elements("Suffix").Any())
                                {
                                    objHLMessageOBR.OBRSuffix = objobjOrderingProvider.Element("Suffix").Value;
                                }
                                if (objobjOrderingProvider.Elements("Prefix").Any())
                                {
                                    objHLMessageOBR.OBRPrefix = objobjOrderingProvider.Element("Prefix").Value;
                                }
                                if (objobjOrderingProvider.Elements("Degree").Any())
                                {
                                    objHLMessageOBR.OBRDegree = objobjOrderingProvider.Element("Degree").Value;
                                }
                            }
                        }
                        if (objOBR.Elements("Order_Callback_Phone_Number").Any())
                        {
                            objHLMessageOBR.Order_Callback_Phone_Number = objOBR.Element("Order_Callback_Phone_Number").Value;
                        }
                        if (objOBR.Elements("Placer_Field1").Any())
                        {
                            string strEntererLocation = objOBR.Element("Placer_Field1").Value;
                            /*if (strOtherLocation == "N")
                            {
                            if (lstobjHLMessages.Exists(P => P.LocationCode == strEntererLocation))
                            {
                                var temp = lstobjHLMessages.FindAll(P => P.LocationCode == strEntererLocation);
                                intOrgID = temp[0].OrgId;
                                if (intOrgAddressID != -1)
                                intOrgAddressID = temp[0].OrgAddressID;
                                objHLMessageOBR.OrgID = intOrgID;
                                objHLMessageOBR.LocationID = intOrgAddressID;
                                objHLMessageOBR.LocationSource = "I";
                            }
                            else
                            {
                                if (lstOrgName.Exists(P => P.Name == strEntererLocation))
                                {
                                objHLMessageOBR.OrgID = intOrgID;
                                    objHLMessageOBR.LocationID = Convert.ToInt64(lstOrgName.SingleOrDefault(P => P.Name == strEntererLocation).OrgID.ToString());
                                objHLMessageOBR.LocationSource = "O";
                                }
                                    else if(strEntererLocation !="")
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Invalid Placer Field1";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 18";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                }
                            }
                            else
                            {
                                objHLMessageOBR.OrgID = intOrgID;
                                objHLMessageOBR.LocationID = intOrgAddressID;
                                objHLMessageOBR.LocationSource = "O";
                            }*/
                            objHLMessageOBR.Placer_Field1 = objOBR.Element("Placer_Field1").Value;
                        }
                        if (objOBR.Elements("Placer_Field2").Any())
                        {
                            objHLMessageOBR.Placer_Field2 = objOBR.Element("Placer_Field2").Value;
                        }
                        if (objOBR.Elements("Filler_Field1").Any())
                        {
                            objHLMessageOBR.Filler_Field1 = objOBR.Element("Filler_Field1").Value;
                        }
                        if (objOBR.Elements("Filler_Field2").Any())
                        {
                            objHLMessageOBR.Filler_Field2 = objOBR.Element("Filler_Field2").Value;
                        }
                        objHLMessageOBR.Results_Rpt_Status_Chng_DateTime = DateTime.MaxValue;
                        if (objOBR.Elements("Results_Rpt-Status_Chng-DateTime").Any())
                        {
                            string ResuDateTime = objOBR.Element("Results_Rpt-Status_Chng-DateTime").Value;
                            if (ResuDateTime != "" && ResuDateTime != "00000000000000")
                            {
                                string strResuError = "";
                                DateTime ResultDate = DateTime.MaxValue;
                                ResultDate = GetDateFormat(ResuDateTime, out strResuError);
                                //if (ResultDate1 != DateTime.MinValue)
                                //    ResultDate = ResultDate1;
                                if (strResuError.Trim() != "" || ResuDateTime.Trim().Length > 14)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Results_Rpt-Status_Chng-DateTime Invalid format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 23";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                if (DOBDate != DateTime.MaxValue && DOBDate > ResultDate)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Results_Rpt-Status_Chng-DateTime Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 23";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessageOBR.Results_Rpt_Status_Chng_DateTime = ResultDate;
                            }
                        }



                        if (objOBR.Elements("Diagnostic_Serv_Sect_ID").Any())
                        {
                            objHLMessageOBR.Diagnostic_Serv_Sect_ID = objOBR.Element("Diagnostic_Serv_Sect_ID").Value;
                        }
                        if (objOBR.Elements("Result_Status").Any())
                        {
                            objHLMessageOBR.Result_Status = objOBR.Element("Result_Status").Value;
                        }
                        if (objOBR.Elements("Parent_Status").Any())
                        {
                            objHLMessageOBR.Parent_Status = objOBR.Element("Parent_Status").Value;
                        }
                        if (objOBR.Elements("Quantity-Timing").Any())
                        {
                            objHLMessageOBR.OBRQuantity_Timing = objOBR.Element("Quantity-Timing").Value;
                            var QuantityTiming = objOBR.Descendants("Quantity-Timing");
                            foreach (var objQuantityTiming in QuantityTiming)
                            {
                                if (objQuantityTiming.Elements("Quantity-Timing_Quantity").Any())
                                {
                                    objHLMessageOBR.OBRQuantity_TimingQuantity = Convert.ToInt32(string.IsNullOrEmpty(objQuantityTiming.Element("Quantity-Timing_Quantity").Value) ? "0" : objQuantityTiming.Element("Quantity-Timing_Quantity").Value);
                                }
                                if (objQuantityTiming.Elements("Quantity-Timing_Interval").Any())
                                {
                                    objHLMessageOBR.OBRQuantity_TimingInterval = Convert.ToInt32(string.IsNullOrEmpty(objQuantityTiming.Element("Quantity-Timing_Interval").Value) ? "0" : objQuantityTiming.Element("Quantity-Timing_Interval").Value);
                                }
                                if (objQuantityTiming.Elements("Quantity-Timing_Duration").Any())
                                {
                                    objHLMessageOBR.OBRQuantity_TimingDuration = Convert.ToInt32(string.IsNullOrEmpty(objQuantityTiming.Element("Quantity-Timing_Duration").Value) ? "0" : objQuantityTiming.Element("Quantity-Timing_Duration").Value);
                                }
                                if (objQuantityTiming.Elements("Quantity-Timing_StartDate").Any())
                                {
                                    string TimingStartDate = objQuantityTiming.Element("Quantity-Timing_StartDate").Value;
                                    string strTimeError = "";
                                    DateTime OBRQuantity_TimingStartDate = DateTime.MaxValue;
                                    OBRQuantity_TimingStartDate = GetDateFormat(TimingStartDate, out strTimeError);
                                    if (OBRQuantity_TimingStartDate == DateTime.MaxValue)
                                    {
                                        strOBR27Status = "True";
                                    }
                                    //if (OBRQuantity_TimingStartDate1 != DateTime.MinValue)
                                    //    OBRQuantity_TimingStartDate = OBRQuantity_TimingStartDate1;
                                    if (strTimeError.Trim() != "" || TimingStartDate.Trim().Length > 14)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Quantity-Timing_StartDate Invalid format";
                                        objHLMessageErrorDetails.HLMessageColumns = "OBR 27";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);

                                    }
                                    objHLMessageOBR.OBRQuantity_TimingStartDate = OBRQuantity_TimingStartDate;
                                    if (DOBDate != DateTime.MaxValue && DOBDate > OBRQuantity_TimingStartDate)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Quantity-Timing_StartDate Cannot be Less than the DOB";
                                        objHLMessageErrorDetails.HLMessageColumns = "OBR 27";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    }
                                }

                                if (objQuantityTiming.Elements("Quantity-Timing_EndDate").Any())
                                {
                                    string TimingEndDate = objQuantityTiming.Element("Quantity-Timing_EndDate").Value;
                                    string strTimeEndError = "";
                                    DateTime OBRQuantity_TimingEndDate = DateTime.MaxValue;
                                    OBRQuantity_TimingEndDate = GetDateFormat(TimingEndDate, out strTimeEndError);
                                    //if (OBRQuantity_TimingEndDate1 != DateTime.MinValue)
                                    //    OBRQuantity_TimingEndDate = OBRQuantity_TimingEndDate1;
                                    if (strTimeEndError.Trim() != "" || TimingEndDate.Trim().Length > 14)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Quantity-Timing_EndDate Invalid format";
                                        objHLMessageErrorDetails.HLMessageColumns = "OBR 27";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    }
                                    objHLMessageOBR.OBRQuantity_TimingEndDate = OBRQuantity_TimingEndDate;
                                    if (DOBDate != DateTime.MaxValue && DOBDate > OBRQuantity_TimingEndDate)
                                    {
                                        objHLMessageErrorDetails = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails.HLMessageError = "Quantity-Timing_EndDate Cannot be Less than the DOB";
                                        objHLMessageErrorDetails.HLMessageColumns = "OBR 27";
                                        objHLMessageErrorDetails.OrgID = intOrgID;
                                        objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails.HLMessageTable = "OBR";
                                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                    }
                                }
                                if (objQuantityTiming.Elements("Quantity-Timing_Priority").Any())
                                {
                                    objHLMessageOBR.OBRQuantity_TimingPriority = objQuantityTiming.Element("Quantity-Timing_Priority").Value;
                                }
                            }
                        }
                        if (objOBR.Elements("Result_Copies_To").Any())
                        {
                            objHLMessageOBR.Result_Copies_To = objOBR.Element("Result_Copies_To").Value;
                        }
                        if (objOBR.Elements("Parent_Result_Observation_Identifier").Any())
                        {
                            objHLMessageOBR.Parent_Result_Observation_Identifier = objOBR.Element("Parent_Result_Observation_Identifier").Value;
                        }
                        if (objOBR.Elements("Transporation_Mode").Any())
                        {
                            objHLMessageOBR.Transporation_Mode = objOBR.Element("Transporation_Mode").Value;
                        }
                        if (objOBR.Elements("Reason_For_Study").Any())
                        {
                            objHLMessageOBR.Reason_For_Study = objOBR.Element("Reason_For_Study").Value;
                        }
                        if (objOBR.Elements("Principal_Result_Interpreter").Any())
                        {
                            objHLMessageOBR.Principal_Result_Interpreter = objOBR.Element("Principal_Result_Interpreter").Value;
                        }
                        if (objOBR.Elements("Assistant_Result_Interpreter").Any())
                        {
                            objHLMessageOBR.Assistant_Result_Interpreter = objOBR.Element("Assistant_Result_Interpreter").Value;
                        }
                        if (objOBR.Elements("Technician").Any())
                        {
                            objHLMessageOBR.Technician = objOBR.Element("Technician").Value;
                        }
                        if (objOBR.Elements("Transcriptionist").Any())
                        {
                            objHLMessageOBR.Transcriptionist = objOBR.Element("Transcriptionist").Value;
                        }
                        if (objOBR.Elements("Transcriptionist").Any())
                        {
                            objHLMessageOBR.Transcriptionist = objOBR.Element("Transcriptionist").Value;
                        }
                        if (objOBR.Elements("Scheduled_Date-Time").Any())
                        {
                            string ScheDateTime = objOBR.Element("Scheduled_Date-Time").Value;
                            if (ScheDateTime != "" && ScheDateTime != "00000000000000")
                            {
                                string strScheError = "";
                                DateTime ResultDate = DateTime.MaxValue;
                                ResultDate = GetDateFormat(ScheDateTime, out strScheError);
                                //if (ResultDate1 != DateTime.MinValue)
                                //    ResultDate = ResultDate1;
                                if (strScheError.Trim() != "" || ScheDateTime.Trim().Length > 14)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Scheduled_Date-Time Invalid format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 36";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                if (DOBDate != DateTime.MaxValue && DOBDate > ResultDate)
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Scheduled_Date-Time Cannot be Less than the DOB";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 36";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                objHLMessageOBR.Scheduled_Date_Time = ResultDate;
                            }
                        }
                        if (objOBR.Elements("Number_Of_Sample_Containers").Any())
                        {
                            objHLMessageOBR.Number_Of_Sample_Containers = objOBR.Element("Number_Of_Sample_Containers").Value;
                        }
                        if (objOBR.Elements("Transport_Logistics_Of_Collected_Samlpe").Any())
                        {
                            objHLMessageOBR.Transport_Logistics_Of_Collected_Samlpe = objOBR.Element("Transport_Logistics_Of_Collected_Samlpe").Value;
                        }
                        if (objOBR.Elements("Collectors_Comment").Any() && objOBR.Element("Collectors_Comment").Value.Trim() != "")
                        {
                            string strCollectorsComment = objOBR.Element("Collectors_Comment").Value;
                            objHLMessageOBR.Collectors_Comment = objOBR.Element("Collectors_Comment").Value;
                            Regex RgxUrl = new Regex("[^a-z0-9A-Z]");
                            string strFlag = "Y";
                            if (RgxUrl.IsMatch(strCollectorsComment))
                            {
                                strFlag = "N";
                            }
                            var CollectorsComment = objOBR.Descendants("Collectors_Comment");
                            string strCollectorComment = "";
                            string errornode = string.Empty;
                            foreach (var objCollectorsComment in CollectorsComment)
                            {
                                string data = objCollectorsComment.ToString();
                                XDocument doc = XDocument.Parse(data);
                                Dictionary<string, string> dataDictionary = new Dictionary<string, string>();
                                foreach (XElement element in doc.Descendants().Where(p => p.HasElements == false))
                                {
                                    int keyInt = 0; string keyName = element.Name.LocalName;
                                    while (dataDictionary.ContainsKey(keyName))
                                    { keyName = element.Name.LocalName + "_" + keyInt++; }
                                    dataDictionary.Add(keyName, element.Value);
                                }
                                int nodecount = 1;
                                foreach (XElement element in doc.Descendants())
                                {
                                    if (element.Name.LocalName == "OBR.39.0")
                                    {
                                        if (element.Nodes().Count() > 1)
                                        {
                                            strFlag = "N";
                                        }
                                    }
                                    else if (element.Name.LocalName != "Collectors_Comment")
                                    {
                                        if (element.HasElements)
                                        {
                                            if (element.Nodes().Count() != 2)
                                            {
                                                strFlag = "N";
                                            }
                                            nodecount = 1;
                                        }
                                        else
                                        {
                                            if (element.Nodes().Count() != 1 && element.LastNode != null)
                                            {
                                                strFlag = "N";
                                            }
                                            if (nodecount % 3 == 0)
                                            {
                                                if (element.Nodes().Count() != 2)
                                                {
                                                    strFlag = "N";
                                                }
                                                nodecount = 1;
                                            }
                                            else
                                            {
                                                nodecount++;
                                            }
                                        }
                                    }
                                }
                                string T = dataDictionary.Keys.ElementAt(0);
                                for (int j = 0; j < dataDictionary.Count(); j++)
                                {
                                    if (j % 2 == 0)
                                    {
                                        strCollectorComment += dataDictionary.Values.ElementAt(j) + "^";
                                    }
                                    else
                                    {
                                        strCollectorComment += dataDictionary.Values.ElementAt(j) + "~";
                                    }
                                    if (dataDictionary.Values.ElementAt(j).Trim() == "" && j != dataDictionary.Count() - 1)
                                    {
                                        strFlag = "N";
                                    }
                                }
                                if (strFlag == "N")
                                {
                                    objHLMessageErrorDetails = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails.HLMessageError = "Collectors_Comment Invalid format";
                                    objHLMessageErrorDetails.HLMessageColumns = "OBR 39";
                                    objHLMessageErrorDetails.OrgID = intOrgID;
                                    objHLMessageErrorDetails.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails.HLMessageTable = "OBR";
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails);
                                }
                                //if(objCollectorsComment.Elements("OBR.39.0").Any())
                                //{
                                //    strCollectorComment=objCollectorsComment.Element("OBR.39.0").Value;
                                //    if(objCollectorsComment.Elements("OBR.39.1").Any())
                                //    {
                                //        var CollectorValue=objCollectorsComment.Descendants("OBR.39.1");
                                //        foreach (var objCollectorValue in CollectorValue)
                                //        {
                                //            string strCollectorValue=objCollectorValue.Element("OBR.39.1.0").Value;
                                //            strCollectorComment =strCollectorComment+"^"+strCollectorValue+"~";
                                //        }
                                //    }

                                //}
                            }
                            objHLMessageOBR.Collectors_Comment = strCollectorComment;
                        }
                        if (objOBR.Elements("Transport_Arrangement_Responsibility").Any())
                        {
                            objHLMessageOBR.Transport_Arrangement_Responsibility = objOBR.Element("Transport_Arrangement_Responsibility").Value;
                        }
                        if (objOBR.Elements("Transport_Arranged").Any())
                        {
                            objHLMessageOBR.Transport_Arranged = objOBR.Element("Transport_Arranged").Value;
                        }
                        if (objOBR.Elements("Escort_Required").Any())
                        {
                            objHLMessageOBR.Escort_Required = objOBR.Element("Escort_Required").Value;
                        }
                        if (objOBR.Elements("Planned_Patient_Transport_Comment").Any())
                        {
                            objHLMessageOBR.Planned_Patient_Transport_Comment = objOBR.Element("Planned_Patient_Transport_Comment").Value;
                        }
                        if (objOBR.Elements("Procedure_Code").Any())
                        {
                            objHLMessageOBR.Procedure_Code = objOBR.Element("Procedure_Code").Value;
                        }
                        if (objOBR.Elements("Procedure_Code_Modifier").Any())
                        {
                            objHLMessageOBR.Procedure_Code_Modifier = objOBR.Element("Procedure_Code_Modifier").Value;
                        }
                        if (objOBR.Elements("Placer_Supplemental_Service_Information").Any())
                        {
                            objHLMessageOBR.Placer_Supplemental_Service_Information = objOBR.Element("Placer_Supplemental_Service_Information").Value;
                        }
                        if (objOBR.Elements("Filler_Supplemental_Service_Information").Any())
                        {
                            objHLMessageOBR.Filler_Supplemental_Service_Information = objOBR.Element("Filler_Supplemental_Service_Information").Value;
                        }
                        if (objOBR.Elements("Medically_Necessary_Duplicate_Procedure_Reason").Any())
                        {
                            objHLMessageOBR.Medically_Necessary_Duplicate_Procedure_Reason = objOBR.Element("Medically_Necessary_Duplicate_Procedure_Reason").Value;
                        }
                        if (objOBR.Elements("Result_Handling").Any())
                        {
                            objHLMessageOBR.Result_Handling = objOBR.Element("Result_Handling").Value;
                        }
                        if (objOBR.Elements("Parent_Universal_Service_Identifier").Any())
                        {
                            objHLMessageOBR.Parent_Universal_Service_Identifier = objOBR.Element("Parent_Universal_Service_Identifier").Value;
                        }

                        if (objOBR.Elements("Change_to_Practice").Any())
                        {
                            objHLMessageOBR.Change_to_Practice = objOBR.Element("Change_to_Practice").Value;
                            var ChangetoPractice = xelement.Descendants("Change_to_Practice");
                            int j = 0;
                            foreach (var objChangetoPractice in ChangetoPractice)
                            {
                                if (ChangetoPractice.Elements("OBR.23.0").Any())
                                {
                                    if (i == j)
                                    {
                                        decimal TLD = 0;
                                        Decimal.TryParse(objChangetoPractice.Element("OBR.23.0").Value, out TLD);
                                        objHLMessageOBR.Tasks_Line_Discount = TLD;
                                    }
                                }
                                if (objChangetoPractice.Elements("OBR.23.1").Any())
                                {
                                    var OBR231 = objChangetoPractice.Descendants("OBR.23.1");
                                    if (OBR231 != null)
                                    {
                                        foreach (var objOBR231 in OBR231)
                                        {
                                            if (i == j)
                                            {
                                                if (objOBR231.Elements("OBR.23.1.1").Any())
                                                {
                                                    decimal TLA = 0;
                                                    Decimal.TryParse(objOBR231.Element("OBR.23.1.1").Value, out TLA);
                                                    objHLMessageOBR.Tasks_Line_Amount = TLA;
                                                }
                                                break;
                                            }
                                        }
                                    }
                                }
                                if (objChangetoPractice.Elements("OBR.23.2").Any())
                                {
                                    var OBR232 = objChangetoPractice.Descendants("OBR.23.2");
                                    if (OBR232 != null)
                                    {
                                        foreach (var objOBR232 in OBR232)
                                        {
                                            if (i == j)
                                            {
                                                if (objOBR232.Elements("OBR.23.2.1").Any())
                                                {
                                                    decimal TSP = 0;
                                                    Decimal.TryParse(objOBR232.Element("OBR.23.2.1").Value, out TSP);
                                                    objHLMessageOBR.Tasks_Sales_Price = TSP;
                                                }
                                                break;
                                            }
                                        }
                                    }
                                }
                                if (objChangetoPractice.Elements("OBR.23.3").Any())
                                {
                                    var OBR233 = objChangetoPractice.Descendants("OBR.23.3");
                                    if (OBR233 != null)
                                    {
                                        foreach (var objOBR233 in OBR233)
                                        {
                                            if (i == j)
                                            {
                                                if (objOBR233.Elements("OBR.23.3.1").Any())
                                                {
                                                    objHLMessageOBR.Tasks_Sales_ID = MessageControlID; //objOBR233.Element("OBR.23.3.1").Value;
                                                }
                                            }
                                        }
                                    }
                                }
                                j++;
                            }
                        }
                        objHLMessageOBR.OrgID = intOrgID;
                        objHLMessageOBR.LocationID = intOrgAddressID;
                        objHLMessageOBR.HLMessageOBRContent = "";
                        lstHLMessageOBRDetails.Add(objHLMessageOBR);
                        if (lstContent.Count > 0)
                        {
                            if (lstContent[lineCount].Contains("OBR|") && lstContent[lineCount].Trim() != "")
                            {
                                objHLMessageOBR.HLMessageOBRContent = lstContent[lineCount].ToString();
                            }
                        }
                        lineCount++;
                        objHLMessageOBR = null;
                        i++;
                    }
                }
                catch (Exception ex1)
                {
                    CLogger.LogError("Error while Getting OBR Details GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex1);
                }
                #endregion
                if (xelement.Descendants("Universal_Service_Identifier").Any())
                {
                    var OR = xelement.Descendants("Universal_Service_Identifier");
                    var OResult = xelement.Descendants("Result_Copies_To");
                    if (OResult.Count() > 0)
                    {
                        foreach (var objresult in OResult)
                        {
                            objHLMessage.ResultCopies = objresult.Value;
                            // objHLMessage.ResultCopies = string.IsNullOrEmpty(objresult.Element("Result_Copies_To").Value) ? "" : objresult.Element("Result_Copies_To").Value;
                        }
                    }
                    if (OR.Count() > 0)
                    {
                        foreach (var objOR in OR)
                        {
                            //foreach (var objOBR in objOR.Descendants("OBR"))
                            //{       
                            if (objOR.FirstNode != null)
                                grpName = objOR.FirstNode.ToString();

                            // grpName += objOR.Element("Universal_Service_Identifier").Value + "," ;
                            if (grpName.Length > 1)
                            {
                                objHLMessage.GroupName += grpName + ",";

                            }
                            else
                            {
                                objHLMessage.GroupName += grpName;
                            }
                            //objHLMessage.GroupName += objOR.Element("Universal_Service_Identifier").Value + "," ;

                            ////index = 0;
                            ////index = grpName.IndexOf("^");
                            ////if (index > 0)
                            ////    grpName = grpName.Substring(0, index);

                            //////if (objHLMessage.GroupName == "")
                            //////{
                            //////    objHLMessage.GroupName = objOR.Element("Identifier").Value;
                            //////    index = 0;
                            //////    index = objHLMessage.GroupName.IndexOf("^");
                            //////    if (index > 0)
                            //////        objHLMessage.GroupName = objHLMessage.GroupName.Substring(0, index);
                            //////}
                            //////else
                            //////{
                            //////    index = 0;
                            //////    index = objOR.Element("Identifier").Value.IndexOf("^");
                            //////    if (index > 0)
                            //////        objOR.Element("Identifier").Value = objOR.Element("Identifier").Value.Substring(0, index);
                            //////    objHLMessage.GroupName += "^" + objOR.Element("Identifier").Value;
                            //////}

                            //}


                        }

                    }
                }
                //}
                #region Check Mandtory Items
                //List<HLMessageErrorDetails> lstHLMessageErrorDetails1 = new List<HLMessageErrorDetails>();

                PageErrorCode += "Checking Mandatory Details Started" + System.Environment.NewLine;
                try
                {
                    if (objHLMessageErrorDetails1 != null && objHLMessageErrorDetails1.HLMessageError != "")
                    {
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                    }
                    foreach (var Mandtoryitem in lstHLMessageMandatoryDetails)
                    {
                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                        if (Mandtoryitem.TableCode.Contains("MSH"))
                        {
                            foreach (var Headeritems in lstHLMessageHeaderDetails)
                            {
                                string l1 = Headeritems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).GetValue(Headeritems, null).ToString();
                                if (Headeritems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).PropertyType.FullName == "System.DateTime" && l1 == DateTime.MinValue.ToString())
                                {
                                    //if (l1 == DateTime.MaxValue.ToString())
                                    //{
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "MSH";
                                    //}
                                }
                                else if (l1.Equals(""))
                                {
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "MSH";
                                }
                                if (objHLMessageErrorDetails1 != null && objHLMessageErrorDetails1.HLMessageError != "")
                                {
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                                }
                                objHLMessageErrorDetails1 = null;
                            }
                            if (lstHLMessageHeaderDetails.Count == 0)
                            {
                                if (objHLMessageErrorDetails1 == null)
                                    objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                objHLMessageErrorDetails1.OrgID = intOrgID;
                                objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                objHLMessageErrorDetails1.HLMessageTable = "OBR";
                            }
                        }
                        if (Mandtoryitem.TableCode.Contains("PID"))
                        {
                            foreach (var Patientitems in lstHLMessagePatientIDDetails)
                            {
                                string l1 = Patientitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).GetValue(Patientitems, null).ToString();

                                if (Mandtoryitem.HLMessageColumns.ToString() == "Patient_Name")
                                {
                                    if (Patientitems.Given_Name.Trim() == "" && Patientitems.PIDFamily_Name.Trim() == "" && Patientitems.Second_and_further_given_Names_or_Initials_Thereof.Trim() == "")
                                    {
                                        if (objHLMessageErrorDetails1 == null)
                                            objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                        objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                        objHLMessageErrorDetails1.OrgID = intOrgID;
                                        objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails1.HLMessageTable = "PID";
                                    }
                                }
                                else if (Mandtoryitem.HLMessageColumns.ToString() == "Date_time_Of_Birth")
                                {
                                    if (Patientitems.Date_time_Of_Birth == DateTime.MaxValue)
                                    {
                                        if (Patientitems.Multiple_Birth_Indicator.Trim() == "" && strPID7Status=="")
                                        {
                                            if (objHLMessageErrorDetails1 == null)
                                                objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                            objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                            objHLMessageErrorDetails1.OrgID = intOrgID;
                                            objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails1.HLMessageTable = "PID";
                                            strPID7Status = "True";
                                        }
                                        if (Patientitems.Birth_Order.Trim() == "" && strPID7Status == "")
                                        {
                                            if (objHLMessageErrorDetails1 == null)
                                                objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                            objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                            objHLMessageErrorDetails1.OrgID = intOrgID;
                                            objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails1.HLMessageTable = "PID";
                                            strPID7Status = "True";
                                        }
                                    }
                                }
                                else if (Mandtoryitem.HLMessageColumns.ToString() == "Multiple_Birth_Indicator" || Mandtoryitem.HLMessageColumns.ToString() == "Birth_Order")
                                {
                                    if (Patientitems.Date_time_Of_Birth == DateTime.MaxValue)
                                    {
                                        if (Patientitems.Multiple_Birth_Indicator.Trim() == "" && strPID7Status=="")
                                        {
                                            if (objHLMessageErrorDetails1 == null)
                                                objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                            objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                            objHLMessageErrorDetails1.OrgID = intOrgID;
                                            objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails1.HLMessageTable = "PID";
                                            strPID7Status = "True";
                                        }
                                        if (Patientitems.Birth_Order.Trim() == "" && strPID7Status == "")
                                        {
                                            if (objHLMessageErrorDetails1 == null)
                                                objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                            objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                            objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                            objHLMessageErrorDetails1.OrgID = intOrgID;
                                            objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                            objHLMessageErrorDetails1.HLMessageTable = "PID";
                                            strPID7Status = "True";
                                        }
                                    }
                                }
                                else if (Mandtoryitem.HLMessageColumns.ToString() == "Phone_Number_home")
                                {
                                    if (Patientitems.HTelephone_Number.Trim() == "" && Patientitems.HTelecommunication_use_code.Trim() == "")
                                    {
                                        if (objHLMessageErrorDetails1 == null)
                                            objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                        objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                        objHLMessageErrorDetails1.OrgID = intOrgID;
                                        objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails1.HLMessageTable = "PID";
                                    }
                                }
                                else if (Patientitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).PropertyType.FullName == "System.DateTime" && l1 == DateTime.MaxValue.ToString())
                                {
                                    //if (l1 == DateTime.MaxValue.ToString())
                                    //{
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "PID";
                                    //}
                                }
                                else if (l1.Equals(""))
                                {
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "PID";
                                }
                                if (objHLMessageErrorDetails1 != null && objHLMessageErrorDetails1.HLMessageError != "")
                                {
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                                }
                                objHLMessageErrorDetails1 = null;
                            }
                        }
                        if (Mandtoryitem.TableCode.Contains("ORC"))
                        {
                            foreach (var ORCitems in lstHLMessageORCDetails)
                            {
                                string l1 = ORCitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).GetValue(ORCitems, null).ToString();
                                if (Mandtoryitem.HLMessageColumns.ToString() == "ORCOrdering_Provider")
                                {
                                    if (ORCitems.OrderingPerson_Identifier.Trim() == "" && ORCitems.OrderingFamily_Name.Trim() == "")
                                    {
                                        if (objHLMessageErrorDetails1 == null)
                                            objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                        objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                        objHLMessageErrorDetails1.OrgID = intOrgID;
                                        objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails1.HLMessageTable = "ORC";
                                    }
                                    else if (ORCitems.OrderingPerson_Identifier.Trim() == "")
                                    {
                                        if (objHLMessageErrorDetails1 == null)
                                            objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails1.HLMessageError = "ORCOrdering_Provider Code - Missing";
                                        objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                        objHLMessageErrorDetails1.OrgID = intOrgID;
                                        objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails1.HLMessageTable = "ORC";
                                    }
                                    else if (ORCitems.OrderingFamily_Name.Trim() == "")
                                    {
                                        if (objHLMessageErrorDetails1 == null)
                                            objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                        objHLMessageErrorDetails1.HLMessageError = "ORCOrdering_Provider Name - Missing";
                                        objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                        objHLMessageErrorDetails1.OrgID = intOrgID;
                                        objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                        objHLMessageErrorDetails1.HLMessageTable = "ORC";
                                    }
                                }
                                else if (ORCitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).PropertyType.FullName == "System.DateTime" && l1 == DateTime.MaxValue.ToString())
                                {
                                    //if (l1 == DateTime.MaxValue.ToString())
                                    //{
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "ORC";
                                    //}
                                }
                                else if (l1.Equals(""))
                                {
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "ORC";
                                }
                                if (objHLMessageErrorDetails1 != null && objHLMessageErrorDetails1.HLMessageError != "")
                                {
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                                }
                                objHLMessageErrorDetails1 = null;
                            }
                        }
                        if (Mandtoryitem.TableCode.Contains("OBR"))
                        {
                            foreach (var OBRitems in lstHLMessageOBRDetails)
                            {
                                string l1 = OBRitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).GetValue(OBRitems, null).ToString();
                                if (OBRitems.GetType().GetProperty(Mandtoryitem.HLMessageColumns).PropertyType.FullName == "System.DateTime" && l1 == DateTime.MaxValue.ToString())
                                {
                                    //if (l1 == DateTime.MaxValue.ToString())
                                    //{
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage;
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "OBR";
                                    //}
                                }
                                else if (l1.Equals(""))
                                {
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = Mandtoryitem.ErrorMessage + "-" + OBRitems.Universal_Service_Identifier.ToString();
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "OBR";
                                }
                                else if (Mandtoryitem.HLMessageColumns == "OBRQuantity_Timing" && strOBR27Status == "True")
                                {
                                    if (objHLMessageErrorDetails1 == null)
                                        objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                                    objHLMessageErrorDetails1.HLMessageError = "Quantity-Timing_StartDate is not allowed to be empty" + "-" + OBRitems.Universal_Service_Identifier.ToString();
                                    objHLMessageErrorDetails1.HLMessageColumns = Mandtoryitem.TableCode;
                                    objHLMessageErrorDetails1.OrgID = intOrgID;
                                    objHLMessageErrorDetails1.LocationID = intOrgAddressID;
                                    objHLMessageErrorDetails1.HLMessageTable = "OBR";
                                    strOBR27Status = "";
                                }
                                if (objHLMessageErrorDetails1 != null && objHLMessageErrorDetails1.HLMessageError != "")
                                {
                                    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                                }
                                objHLMessageErrorDetails1 = null;
                            }
                        }
                    }
                }
                catch (Exception ex1)
                {
                    CLogger.LogError("Error while Getting Mandatory Details GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex1);
                }
                #endregion
                try
                {
                    //var OBRTest = (from p in lstHLMessageOBRDetails
                    //               group p by new { p.Universal_Service_Identifier, p.OBRPriority } into g
                    //               where g.Count() > 1
                    //               select new
                    //               {
                    //                   g.Key,
                    //                   ProductCount = g.Count()
                    //               }).ToList();
                    //var OBRTest = (from ex in lstHLMessageOBRDetails
                    //               group ex by new { ex.Universal_Service_Identifier} into g
                    //               select new HLMessageOBRDetails
                    //         {
                    //             Universal_Service_Identifier = g.Key.Universal_Service_Identifier
                    //         }).Distinct().ToList();
                    string strTestCode = "";
                    string strError = "";
                    List<HLMessageOBRDetails> lstHLMessageOBRDetailsTemp = new List<HLMessageOBRDetails>();
                    lstHLMessageOBRDetailsTemp = lstHLMessageOBRDetails.OrderBy(p => p.Universal_Service_Identifier).ToList();
                    string strUniversal_Service_Identifier = "";
                    for (int obrCount = 0; obrCount < lstHLMessageOBRDetailsTemp.Count; obrCount++)
                    {
                        List<HLMessageOBRDetails> lstHLMessageOBRTest;
                        lstHLMessageOBRTest = (from RPC in lstHLMessageOBRDetailsTemp
                                               where RPC.Universal_Service_Identifier == lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier &&
                                               RPC.OBRPriority == ""
                                               group RPC by new { RPC.Universal_Service_Identifier, RPC.OBRPriority } into glist
                                               where glist.Count() > 1
                                               select new HLMessageOBRDetails { Universal_Service_Identifier = glist.Key.Universal_Service_Identifier, OBRPriority = glist.Key.OBRPriority.ToString() }).ToList();
                        if (lstHLMessageOBRTest.Count > 0)
                        {
                            HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                            strError = "Priority is missing for - " + lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                            objHLMessageTestErrorDetails.HLMessageError = strError;
                            objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                            objHLMessageTestErrorDetails.OrgID = intOrgID;
                            objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                            objHLMessageTestErrorDetails.HLMessageTable = "OBR";
                            var ErrCount = lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError);
                            if (!(lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError)))
                            {
                                lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                            }
                        }
                        else
                        {
                            lstHLMessageOBRTest = (from RPC in lstHLMessageOBRDetailsTemp
                                                   where RPC.Universal_Service_Identifier == lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier
                                                   group RPC by new { RPC.OBRPriority } into glist
                                                   select new HLMessageOBRDetails { OBRPriority = glist.Key.OBRPriority.ToString() }).ToList();
                            int lstHLMessageOBRTestCount = (from RPC in lstHLMessageOBRDetailsTemp
                                                            where RPC.Universal_Service_Identifier == lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier
                                                            select RPC.Universal_Service_Identifier).Count();
                            if (lstHLMessageOBRTest.Count != lstHLMessageOBRTestCount && strUniversal_Service_Identifier != lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier)
                            {
                                strUniversal_Service_Identifier = lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                                strError = "Same Priority numbers are not allowed - " + lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                objHLMessageTestErrorDetails.HLMessageError = strError;
                                objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                                objHLMessageTestErrorDetails.OrgID = intOrgID;
                                objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                                objHLMessageTestErrorDetails.HLMessageTable = "OBR";
                                if (!(lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError)))
                                {
                                    lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                                }
                            }
                            else
                            {
                                if (strTestCode.Trim() != lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier.Trim())
                                {
                                    strTestCode = lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                    if (lstHLMessageOBRTest.Count > 1)
                                    {
                                        lstHLMessageOBRTest = lstHLMessageOBRTest.OrderBy(p => p.OBRPriority).ToList();
                                        for (int obrPrioritycount = 0; obrPrioritycount < lstHLMessageOBRTest.Count; obrPrioritycount++)
                                        {
                                            if (lstHLMessageOBRTest[obrPrioritycount].OBRPriority == "")
                                            {
                                                HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                                                strError = "Priority is missing for - " + lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                                objHLMessageTestErrorDetails.HLMessageError = strError;
                                                objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                                                objHLMessageTestErrorDetails.OrgID = intOrgID;
                                                objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                                                objHLMessageTestErrorDetails.HLMessageTable = "OBR";
                                                if (!(lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError)))
                                                {
                                                    lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                                                }
                                                break;
                                            }
                                            //            else if (Convert.ToInt32(lstHLMessageOBRTest[obrPrioritycount].OBRPriority.ToString()) != obrPrioritycount + 1)
                                            //{
                                            //                HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                                            //                    strError = "Priority is not in the sequence order for - " + lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                            //                    objHLMessageTestErrorDetails.HLMessageError = strError;
                                            //                objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                                            //                objHLMessageTestErrorDetails.OrgID = intOrgID;
                                            //                objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                                            //                    objHLMessageTestErrorDetails.HLMessageTable = "OBR";
                                            //                    if (!(lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError)))
                                            //                    {
                                            //                lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                                            //                    }
                                            //                break;
                                            //    }
                                        }

                                    }
                                    //else if (lstHLMessageOBRTest.Count == 1)
                                    //{
                                    //if (lstHLMessageOBRDetailsTemp[obrCount].OBRPriority.Trim() != "" && lstHLMessageOBRDetailsTemp[obrCount].Set_ID_OBR.Trim() == "MO" && lstHLMessageOBRDetailsTemp[obrCount].OBRPriority.Trim() !="0")
                                    //    {
                                    //        HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                                    //        strError = "Priority is not required for - " + lstHLMessageOBRDetailsTemp[obrCount].Universal_Service_Identifier;
                                    //        objHLMessageTestErrorDetails.HLMessageError = strError;
                                    //        objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                                    //        objHLMessageTestErrorDetails.OrgID = intOrgID;
                                    //        objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                                    //        objHLMessageTestErrorDetails.HLMessageTable = "OBR";
                                    //        if (!(lstHLMessageErrorDetails.Exists(P => P.HLMessageError == strError)))
                                    //        {
                                    //            lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                                }
                            }
                        }
                    }


                    /******************************************
                   List<HLMessageOBRDetails> lstHLMessageOBRTest = (from RPC in lstHLMessageOBRDetails
                                                                    join RP in OBRTest on RPC.Universal_Service_Identifier equals RP.Universal_Service_Identifier
                                                                    where RPC.OBRPriority == "" 
                                                                    group RPC by new { RPC.Universal_Service_Identifier} into glist
                                                                    where glist.Count() > 1
                                                                    select new HLMessageOBRDetails { Universal_Service_Identifier= glist.Key.Universal_Service_Identifier.ToString() }).ToList();
                   List<HLMessageOBRDetails> lstHLMessageOBRTestPriority = (from RPC in lstHLMessageOBRDetails
                                                                            join RP in OBRTest on RPC.Universal_Service_Identifier equals RP.Universal_Service_Identifier
                                                                    where RPC.OBRPriority != ""
                                                                    group RPC by new { RPC.Universal_Service_Identifier} into glist
                                                                            select new HLMessageOBRDetails { Universal_Service_Identifier = glist.Key.Universal_Service_Identifier.ToString()}).ToList();
                   lstHLMessageOBRTestPriority = lstHLMessageOBRTestPriority.OrderBy(p => p.Universal_Service_Identifier).OrderBy(p=> p.OBRPriority).ToList();





                   

                   if (lstHLMessageOBRTest.Count > 0)
                   {
                       for (int testcount = 0; testcount < lstHLMessageOBRTest.Count; testcount++)
                       {
                           HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                           objHLMessageTestErrorDetails.HLMessageError = "Priority is missing for - " + lstHLMessageOBRTest[testcount].Universal_Service_Identifier;
                           objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                           objHLMessageTestErrorDetails.OrgID = intOrgID;
                           objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                           lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                       }
                   }
                   if (lstHLMessageOBRTestPriority.Count > 0)
                   {
                       int j=1;
                       string strTestCode="";
                       for (int prioritycount = 0; prioritycount < lstHLMessageOBRTestPriority.Count; prioritycount++)
                       {
                           if (strTestCode == "")
                           {
                               strTestCode = lstHLMessageOBRTestPriority[prioritycount].Universal_Service_Identifier;
                           }
                           else if(strTestCode != lstHLMessageOBRTestPriority[prioritycount].Universal_Service_Identifier)
                           {
                               strTestCode = lstHLMessageOBRTestPriority[prioritycount].Universal_Service_Identifier;
                               j = 1;
                           }
                           if (j !=Convert.ToInt32(lstHLMessageOBRTestPriority[prioritycount].OBRPriority))
                           {
                               HLMessageErrorDetails objHLMessageTestErrorDetails = new HLMessageErrorDetails();
                               objHLMessageTestErrorDetails.HLMessageError = "Priority is not in the sequence order for - " + lstHLMessageOBRTestPriority[prioritycount].Universal_Service_Identifier;
                               objHLMessageTestErrorDetails.HLMessageColumns = "OBR 5";
                               objHLMessageTestErrorDetails.OrgID = intOrgID;
                               objHLMessageTestErrorDetails.LocationID = intOrgAddressID;
                               lstHLMessageErrorDetails.Add(objHLMessageTestErrorDetails);
                           }
                           j++;
                       }
                   }
                   ******************************************/




                    PageErrorCode += "Checking Mandatory Details Finished" + System.Environment.NewLine;
                    objHLMessage.Locations = strOtherLocation;
                    lstHLMessages.Add(objHLMessage);
                    returncode = new Patient_BL(objcontext).InsertHLMessageDetails(objHLMessage, "0", "", HL7Msg, lstHLMessageHeaderDetails, lstHLMessageOBRDetails, lstHLMessageORCDetails, lstHLMessagePatientIDDetails, lstHLMessageErrorDetails, lstHLMessages);
                    strOBRSetID = "";
                    strORCOrderControl = "";
                    strPIDSetID = "";
                    lstHLMessageErrorDetails.Clear();
                    PageErrorCode += "Message Inserted into the table" + System.Environment.NewLine;
                }
                catch (Exception ex1)
                {
                    CLogger.LogError("Error while Getting Insert the Values in GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex1);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice", ex);
            PageErrorCode = "Error while Getting GetHLMessageDetailsInBoundDetails() Method in HL7Integrationservice" + ex.Message.ToString();
        }
        return objHLMessage;


    }
    #endregion
    #region GetDOB
    private DateTime GetDOB(string strAge, string strAgeMonth)
    {
        DateTime dt = DateTime.Now;
        int age = 0;
        int.TryParse(strAge, out age);
        if (strAgeMonth.ToLower() != "" && age > 0)
        {
            switch (strAgeMonth.ToUpper())
            {
                case "Y":
                    dt = dt.AddYears(-age);
                    break;
                case "M":
                    dt = dt.AddMonths(-age);
                    break;
                case "W":
                    age = age * 7;
                    dt = dt.AddDays(-age);
                    break;
                case "D":
                    dt = dt.AddDays(-age);
                    break;
            }
        }
        return dt;
    }
    #endregion
    #region GetDateFormat
    private DateTime GetDateFormat(string strDate, out string strError)
    {
        DateTime ConvertedDate = DateTime.MaxValue;
        strDate = strDate.Trim();
        strError = "";
        try
        {
            if (strDate != "" && strDate != "00000000000000")
            {
                string day = strDate.Substring(6, 2);
                string month = strDate.Substring(4, 2);
                string year = strDate.Substring(0, 4);
                string Hour = "";
                string Mins = "";
                string Sec = "";

                string date = "";
                date = day + "-" + month + "-" + year;
                if (strDate.Length > 8)
                {
                    Mins = strDate.Substring(10, 2);
                    Hour = strDate.Substring(8, 2);
                    date = date + " " + Hour + ":" + Mins;// +":" + Sec;
                }
                if (strDate.Length > 12)
                {
                    Sec = strDate.Substring(12, 2);
                    date = date + ":" + Sec;
                }
                ConvertedDate = Convert.ToDateTime(date);
            }
        }
        catch (Exception ex)
        {
            strError = ex.Message.ToString();
        }
        return ConvertedDate;
    }
    #endregion

    #region GetHLMesssgeInBound
    private HLMessages GetHLMesssgeInBound(XElement xelement)
    {
        HLMessages objHLMessage = new HLMessages();
        try
        {
            var ItemName = "";
            var HLDetails = xelement.Descendants("Record");

            int MsgctrlidCount = xelement.Descendants("Message_control_id").Count();
            int MsgTypecount = xelement.Descendants("Trigger_Event").Count();
            int SAppCount = xelement.Descendants("Sending_Application").Count();
            int SFacCount = xelement.Descendants("Sending_Facility").Count();
            int RAppCount = xelement.Descendants("Receiving_Application").Count();
            int RFacCount = xelement.Descendants("Receiving_Facility").Count();
            int PatientIdCount = xelement.Descendants("ID_Number").Count();
            int PatientidNewCount = xelement.Descendants("Patient_Identifier_List").Count();
            int PatientNameCount = xelement.Descendants("Patient_Name").Count();
            int ExtVisitidcount = xelement.Descendants("Visit_Number").Count();
            int PatientDobCount = xelement.Descendants("Date-time_Of_Birth").Count();
            int PatientSexCount = xelement.Descendants("Date-Administrative_Sex").Count();
            int PatientAddrCount = xelement.Descendants("Patient_Address").Count();
            int PatientHomePhoneCount = xelement.Descendants("Phone_Number_home").Count();
            int PatientPhoneCount = xelement.Descendants("Phone_Number_Business").Count();
            //int PCountryCount = xelement.Descendants("Patient_Country").Count();
            //int PStateCount = xelement.Descendants("Patient_State").Count();
            int OrderNoCount = xelement.Descendants("Placer_Order_Number").Count();
            int clientcodecount = xelement.Descendants("Entered_By").Count();
            int LoginnameCount = xelement.Descendants("LoginName").Count();
            int RoleNameCount = xelement.Descendants("RoleName").Count();
            int NTE = xelement.Descendants("NTE").Count();
            var HLData = xelement.Descendants("Message_Type");
            var PVAssiginedLoc = xelement.Descendants("Assigned_Patient_Location").Count();
            var PVPriorPatLoc = xelement.Descendants("Prior_Patient_Location").Count();
            var PriorPatientid = xelement.Descendants("Prior_Patient_ID").Count();
            var Order_Control = xelement.Descendants("Order_Control").Count();
            var Order_Control_Type = xelement.Descendants("Order_Control");

            int PlacerGroupNumber = xelement.Descendants("Placer_Group_Number").Count();
            int QuantityTimingcount = xelement.Descendants("Quantity-Timing").Count();
            var AttendingDRcount = xelement.Descendants("Attending_Doctor").Count();
            var Patient_Class = xelement.Descendants("Patient_Class").Count();
            var Ordering_Provider = xelement.Descendants("Ordering_Provider").Count();
            //Ramkumar ADDED
            var SpeceisName = xelement.Descendants("Species_Code").Count();
            var Age = xelement.Descendants("Multiple_Birth_Indicator").Count();
            var OrderLocation = xelement.Descendants("Enterer_Location").Count();
            var Confidential = xelement.Descendants("Confidentially_Code").Count();
            var ResultCopies = xelement.Descendants("Result_Copies_To").Count();
            //var ReportType = xelement.Descendants("Result_Copies_To").Count();

            //var  = xelement.Descendants("Enterer's Location").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();
            //var Speceis_UnKnown = xelement.Descendants("Unknown").Count();


            if (MsgTypecount > 0)
            {
                foreach (var objHLdata in HLData)
                {
                    objHLMessage.MsgType = objHLdata.Value;

                }
            }
            if (objHLMessage.MsgType == "")
            {
                Adderror("Message_Type");
            }
            foreach (var HL in HLDetails)
            {
                //Message Header
                var MSH = xelement.Descendants("MSH");
                foreach (var objMSH in MSH)
                {
                    objHLMessage.Msg_Content = xelement.ToString();
                    if (MsgctrlidCount > 0)
                    {
                        objHLMessage.MsgControlId = objMSH.Element("Message_control_id").Value;

                    }
                    if (objHLMessage.MsgControlId == "" || MsgctrlidCount == 0)
                    {
                        Adderror("Message_control_id");
                    }


                    if (SAppCount > 0)
                    {
                        objHLMessage.Sending_App = objMSH.Element("Sending_Application").Value;

                    }
                    if (string.IsNullOrEmpty(objHLMessage.Sending_App))
                    {
                        Adderror("Sending_Application");
                    }
                    if (SFacCount > 0)
                    {
                        objHLMessage.Sending_Facility = objMSH.Element("Sending_Facility").Value;

                        //var PSFLst = xelement.Descendants("Sending_Facility");


                        //foreach (var ObjSFList in PSFLst)
                        //{                            
                        //    objHLMessage.Sending_Facility = ObjSFList.Element("Namespace_ID").Value + "^" + ObjSFList.Element("Universal_ID").Value;
                        //   // objHLMessage.Sending_Facility = ObjSFList.Element("Sending_Application").Value;
                        //    if (objHLMessage.Sending_Facility == "")
                        //    {
                        //        Adderror("Sending_Facility");
                        //    }
                        //}
                    }
                    if (objHLMessage.Sending_Facility == "")
                    {
                        Adderror("Sending_Facility");
                    }
                    if (RAppCount > 0)
                    {
                        objHLMessage.Rec_App = objMSH.Element("Receiving_Application").Value;
                    }
                    //if (objHLMessage.Rec_App == "")
                    //{
                    //    Adderror("Receiving_Application");
                    //}
                    if (RFacCount > 0)
                    {
                        objHLMessage.Rec_Facility = objMSH.Element("Receiving_Facility").Value;
                    }
                    //if (objHLMessage.Rec_Facility == "")
                    //{
                    //    Adderror("Receiving_Facility");
                    //}
                }
                // Patient Merge
                var MRGPriorPatient = xelement.Descendants("Prior_Patient_ID");
                if (PriorPatientid > 0)
                {
                    foreach (var objpriorpid in MRGPriorPatient)
                    {
                        if (objpriorpid.Descendants("Prior_ID_Number").Count() > 0)
                        {
                            string pidnumber = objpriorpid.Element("Prior_ID_Number").Value;
                            objHLMessage.PriorIdNumber = string.IsNullOrEmpty(objpriorpid.Element("Prior_ID_Number").Value) ? "" : pidnumber;
                        }
                        else
                        {
                            objHLMessage.PriorIdNumber = "";
                        }
                    }

                }
                // Patient Merge


                //Getting Patient Details
                var PID = xelement.Descendants("PID");
                objHLMessage.Patient_ID = "-1";
                foreach (var objPID in PID)
                {

                    if (PatientIdCount > 0)
                    {
                        var PLIST = xelement.Descendants("Patient_Identifier_List");
                        foreach (var ObjPList in PLIST)
                        {
                            int ID_Number = ObjPList.Descendants("ID_Number").Count();
                            int Identifier_Check_Digit = ObjPList.Descendants("Identifier_Check_Digit").Count();
                            int Check_Digit_Scheme = ObjPList.Descendants("Check_Digit_Scheme").Count();
                            if (ID_Number > 0)
                            {
                                int index1 = 0;
                                index1 = ObjPList.Element("ID_Number").Value.IndexOf("^");
                                if (index1 > 0)
                                    ObjPList.Element("ID_Number").Value = ObjPList.Element("ID_Number").Value.Substring(0, index1);
                                objHLMessage.Patient_ID = ObjPList.Element("ID_Number").Value;
                                objHLMessage.PatientIdentifier = ObjPList.Element("ID_Number").Value;

                                if (objHLMessage.Patient_ID == "" || objHLMessage.Patient_ID == "-1")
                                {
                                    Adderror("ID_Number");
                                }
                            }
                        }
                    }
                    if (PatientidNewCount > 0)
                    {
                        int ID_Number = objPID.Descendants("ID_Number").Count();
                        int Identifier_Check_Digit = objPID.Descendants("Identifier_Check_Digit").Count();
                        int Check_Digit_Scheme = objPID.Descendants("Check_Digit_Scheme").Count();

                        var PLISTNEw = xelement.Descendants("Patient_Identifier_List");
                        foreach (var ObjPList in PLISTNEw)
                        {
                            if (ID_Number > 0 && Identifier_Check_Digit > 0 && Check_Digit_Scheme > 0)
                            {

                                objHLMessage.Patient_ID = ObjPList.Element("ID_Number").Value;
                                objHLMessage.PatientIdentifier = ObjPList.Element("ID_Number").Value;
                            }
                            else
                            {
                                objHLMessage.Patient_ID = objPID.Element("Patient_Identifier_List").Value;
                                objHLMessage.PatientIdentifier = objPID.Element("Patient_Identifier_List").Value;

                            }
                        }

                        if (objHLMessage.Patient_ID == "" || objHLMessage.Patient_ID == "-1")
                        {
                            Adderror("Patient_Identifier_List");
                        }
                        //}

                    }
                    if (PatientNameCount > 0)
                    {
                        var PNameList = xelement.Descendants("Patient_Name");
                        foreach (var ObjNameList in PNameList)
                        {
                            int FNAMECount = ObjNameList.Descendants("Given_Name").Count();
                            int MNAMECount = ObjNameList.Descendants("Second_and_further_given_Names_or_Initials_Thereof").Count();
                            int LNAMECount = ObjNameList.Descendants("Family_Name").Count();

                            string FName = string.Empty;
                            string MName = string.Empty;
                            string LName = string.Empty;
                            if (FNAMECount > 0)
                            {
                                FName = string.IsNullOrEmpty(ObjNameList.Element("Given_Name").Value) ? "" : ObjNameList.Element("Given_Name").Value;
                            }
                            if (MNAMECount > 0)
                            {
                                MName = string.IsNullOrEmpty(ObjNameList.Element("Second_and_further_given_Names_or_Initials_Thereof").Value) ? "" : ObjNameList.Element("Second_and_further_given_Names_or_Initials_Thereof").Value;
                            }
                            if (LNAMECount > 0)
                            {
                                LName = string.IsNullOrEmpty(ObjNameList.Element("Family_Name").Value) ? "" : ObjNameList.Element("Family_Name").Value;
                            }

                            if (FNAMECount == 0 && MNAMECount == 0 && LNAMECount == 0)
                            {
                                objHLMessage.Patient_fname = objPID.Element("Patient_Name").Value;
                            }
                            else
                            {
                                if (MName == "")
                                {
                                    //objHLMessage.Patient_fname = FName.ToString() + " " + MName.ToString() + " " + LName.ToString();

                                    objHLMessage.Patient_fname = FName.ToString() + " " + LName.ToString();
                                    objHLMessage.Patient_firstname = FName.ToString();
                                    objHLMessage.Patient_lastname = LName.ToString();
                                    objHLMessage.Patient_middlename = MName.ToString();
                                }
                                else
                                {
                                    objHLMessage.Patient_fname = FName.ToString() + " " + MName.ToString() + " " + LName.ToString();
                                    objHLMessage.Patient_firstname = FName.ToString();
                                    objHLMessage.Patient_lastname = LName.ToString();
                                    objHLMessage.Patient_middlename = MName.ToString();
                                }
                            }

                            if (objHLMessage.Patient_fname == "")
                            {
                                Adderror("Patient_Name");
                            }
                        }
                    }

                    if (PatientDobCount > 0)
                    {
                        var PatDOB = "";
                        PatDOB = objPID.Element("Date-time_Of_Birth").Value;
                        if (PatDOB != "")
                        {
                            string day = PatDOB.Substring(6, 2);
                            string month = PatDOB.Substring(4, 2);
                            string year = PatDOB.Substring(0, 4);
                            string date = day + "/" + month + "/" + year;
                            objHLMessage.Patient_DOB = Convert.ToDateTime(date);
                        }
                    }
                    if (objHLMessage.Patient_DOB == DateTime.MaxValue)
                    {
                        Adderror("Date-time_Of_Birth");
                    }
                    if (PatientSexCount > 0)
                    {
                        objHLMessage.Patient_Sex = objPID.Element("Date-Administrative_Sex").Value;
                    }
                    if (objHLMessage.Patient_Sex == "U")
                    {
                        objHLMessage.Patient_Sex = "M";
                        // Adderror("Patient_Sex");
                    }
                    if (PatientAddrCount > 0)
                    {
                        var PAddress = xelement.Descendants("Patient_Address");
                        foreach (var ObjAddressList in PAddress)
                        {
                            objHLMessage.Patient_Address = ObjAddressList.Element("Street_Mailing_Address").Value + "," + ObjAddressList.Element("City").Value + "," + ObjAddressList.Element("Zip_Or_Postal_Code").Value;

                        }
                    }
                    if (PatientHomePhoneCount > 0)
                    {
                        //if (PatientHomePhoneCount == 1)
                        //{
                        //  objHLMessage.Patient_HomePhone = objPID.Element("Phone_Number_home").Value;
                        //}
                        //else
                        //{
                        //var Phomephone = xelement.Descendants("Phone_Number_home");
                        //foreach (var ObjPhoneList in Phomephone)
                        //{
                        objHLMessage.Patient_HomePhone = objPID.Element("Phone_Number_home").Value;
                        //}
                        //}
                    }

                    if (PatientPhoneCount > 0)
                    {
                        //if (PatientPhoneCount == 1)
                        //{
                        //    objHLMessage.Patient_Businessphone = objPID.Element("Phone_Number_Business").Value;
                        //}
                        //else
                        //{
                        //var PBusinessphone = xelement.Descendants("Phone_Number_Business");
                        //foreach (var ObjPhoneLists in PBusinessphone)
                        //{
                        objHLMessage.Patient_Businessphone = objPID.Element("Phone_Number_Business").Value;
                        //}
                        //}
                    }

                    if (SpeceisName > 0)
                    {
                        var SpeciesName = string.IsNullOrEmpty(objPID.Element("Species_Code").Value) ? "" : objPID.Element("Species_Code").Value;

                    }
                    if (Age > 0)
                    {
                        //var SexAge = string.IsNullOrEmpty(objPID.Element("Multiple_Birth_Indicator").Value) ? "" : objPID.Element("Multiple_Birth_Indicator").Value;
                        //var AgeMonth = string.IsNullOrEmpty(objPID.Element("Birth_Place").Value) ? "" : objPID.Element("Birth_Place").Value;
                        var SexAge = string.IsNullOrEmpty(objPID.Element("Birth_Order").Value) ? "" : objPID.Element("Birth_Order").Value;
                        var AgeMonth = string.IsNullOrEmpty(objPID.Element("Multiple_Birth_Indicator").Value) ? "" : objPID.Element("Multiple_Birth_Indicator").Value;
                        string agetype = string.Empty;


                        switch (AgeMonth)
                        {
                            case "T":
                                agetype = "Minute(s)";
                                break;
                            case "H":
                                agetype = "Hour(s)";
                                break;
                            case "D":
                                agetype = "Day(s)";
                                break;
                            case "W":
                                agetype = "Week(s)";
                                break;
                            case "M":
                                agetype = "Month(s)";
                                break;
                            case "Y":
                                agetype = "Year(s)";
                                break;
                            default:
                                agetype = "";
                                break;

                        }

                        Ageandtype = SexAge.ToString() + agetype.ToString();
                    }
                }
                // Getting Login Details
                var LID = xelement.Descendants("LID");
                if (LID.Count() > 0)
                {
                    foreach (var objLID in LID)
                    {
                        if (LoginnameCount > 0)
                        {
                            objHLMessage.LoginName = objLID.Element("LoginName").Value;
                        }
                        if (objHLMessage.LoginName == "")
                        {
                            Adderror("LoginName");
                        }
                        if (RoleNameCount > 0)
                        {
                            objHLMessage.RoleName = objLID.Element("RoleName").Value;
                        }
                        if (objHLMessage.RoleName == "")
                        {
                            Adderror("RoleName");
                        }
                    }
                }
                objHLMessage.LoginName = "Bala";
                objHLMessage.RoleName = "DataMigrator";
                objHLMessage.ExternalVisitNumber = "";

                var PV = xelement.Descendants("PV1");
                foreach (var objPV in PV)
                {
                    if (objPV.Descendants("Visit_Number").Count() > 0)
                    {
                        objHLMessage.ExternalVisitNumber = objPV.Element("Visit_Number").Value;
                    }
                    if (PVAssiginedLoc > 0)
                    {
                        var PVWardDetails = xelement.Descendants("Assigned_Patient_Location");
                        foreach (var objPVWard in PVWardDetails)
                        {
                            if (objPVWard.Descendants().Count() != 0)
                            {
                                string Facility = string.Empty;
                                string Location_Status = string.Empty;
                                string Point_Of_Care = string.Empty;
                                string Room = string.Empty;
                                string Bed = string.Empty;
                                int Facilitycount = objPVWard.Descendants("Facility").Count();
                                int LocStatuscount = objPVWard.Descendants("Location_Status").Count();
                                int Priorofcarecount = objPVWard.Descendants("Point_Of_Care").Count();
                                int PriorRoomcount = objPVWard.Descendants("Room").Count();
                                int PriorBedcount = objPVWard.Descendants("Bed").Count();
                                if (Priorofcarecount > 0)
                                {
                                    Point_Of_Care = string.IsNullOrEmpty(objPVWard.Element("Point_Of_Care").Value) ? "" : objPVWard.Element("Point_Of_Care").Value;
                                    objHLMessage.WardDeatils = Point_Of_Care;
                                }
                                if (PriorRoomcount > 0)
                                {
                                    Room = string.IsNullOrEmpty(objPVWard.Element("Room").Value) ? "" : objPVWard.Element("Room").Value;
                                    objHLMessage.WardDeatils += "`" + Room;
                                }
                                if (PriorBedcount > 0)
                                {
                                    Bed = string.IsNullOrEmpty(objPVWard.Element("Bed").Value) ? "" : objPVWard.Element("Bed").Value;
                                    objHLMessage.WardDeatils += "`" + Bed;
                                }
                                if (Facilitycount > 0)
                                {
                                    Facility = string.IsNullOrEmpty(objPVWard.Element("Facility").Value) ? "" : objPVWard.Element("Facility").Value;
                                    objHLMessage.WardDeatils += "`" + Facility;
                                }
                                if (LocStatuscount > 0)
                                {
                                    Location_Status = string.IsNullOrEmpty(objPVWard.Element("Location_Status").Value) ? "" : objPVWard.Element("Location_Status").Value;
                                    objHLMessage.WardDeatils += "`" + Location_Status;
                                }
                                ClientCodeWithTower = Point_Of_Care;
                            }
                        }
                    }
                    if (ExtVisitidcount > 0)
                    {
                        var ExtVisitDetails = xelement.Descendants("Visit_Number");
                        foreach (var objPVisitDetails in ExtVisitDetails)
                        {
                            int vidcount = objPVisitDetails.Descendants("ID").Count();
                            if (vidcount > 0)
                            {
                                string IDs = string.Empty;
                                IDs = string.IsNullOrEmpty(objPVisitDetails.Element("ID").Value) ? "" : objPVisitDetails.Element("ID").Value;
                                objHLMessage.ExternalVisitId = IDs;
                            }
                        }
                    }
                    if (PVPriorPatLoc > 0)
                    {
                        var PVPriorWardDetails = xelement.Descendants("Prior_Patient_Location");
                        foreach (var objPVWards in PVPriorWardDetails)
                        {
                            if (objPVWards.Descendants().Count() != 0)
                            {
                                string Facility1 = string.Empty;
                                string Location_Status1 = string.Empty;
                                string Prior_Of_Care = string.Empty;
                                string Room1 = string.Empty;
                                string Bed1 = string.Empty;
                                int Facilitycount1 = objPVWards.Descendants("Facility").Count();
                                int LocStatuscount1 = objPVWards.Descendants("Location_Status").Count();
                                int Priorofcarecount = objPVWards.Descendants("Point_Of_Care").Count();
                                int PriorRoomcount = objPVWards.Descendants("Room").Count();
                                int PriorBedcount = objPVWards.Descendants("Bed").Count();
                                if (Priorofcarecount > 0)
                                {
                                    Prior_Of_Care = string.IsNullOrEmpty(objPVWards.Element("Point_Of_Care").Value) ? "" : objPVWards.Element("Point_Of_Care").Value;
                                    objHLMessage.PriorWardDetails = Prior_Of_Care;
                                }
                                if (PriorRoomcount > 0)
                                {
                                    Room1 = string.IsNullOrEmpty(objPVWards.Element("Room").Value) ? "" : objPVWards.Element("Room").Value;
                                    objHLMessage.PriorWardDetails += "`" + Room1;
                                }
                                if (PriorBedcount > 0)
                                {
                                    Bed1 = string.IsNullOrEmpty(objPVWards.Element("Bed").Value) ? "" : objPVWards.Element("Bed").Value;
                                    objHLMessage.PriorWardDetails += "`" + Bed1;
                                }
                                if (Facilitycount1 > 0)
                                {
                                    Facility1 = string.IsNullOrEmpty(objPVWards.Element("Facility").Value) ? "" : objPVWards.Element("Facility").Value;
                                    objHLMessage.PriorWardDetails += "`" + Facility1;
                                }
                                if (LocStatuscount1 > 0)
                                {
                                    Location_Status1 = string.IsNullOrEmpty(objPVWards.Element("Location_Status").Value) ? "" : objPVWards.Element("Location_Status").Value;
                                    objHLMessage.PriorWardDetails += "`" + Location_Status1;
                                }
                            }
                        }
                    }
                    //if (AttendingDRcount > 0)
                    //{
                    //    var PVAttendingDR = xelement.Descendants("Attending_Doctor");
                    //    foreach (var OBJPVAttDr in PVAttendingDR)
                    //    {
                    //        int PIDCount = OBJPVAttDr.Descendants("Person_Identifier").Count();
                    //        int FNAMECount = OBJPVAttDr.Descendants("Family_Name").Count();
                    //        int GNAMECount = OBJPVAttDr.Descendants("Given_Name").Count();
                    //        if (PIDCount > 0 && FNAMECount > 0 && GNAMECount > 0)
                    //        {
                    //            string Person_Identifier = string.IsNullOrEmpty(OBJPVAttDr.Element("Person_Identifier").Value) ? "" : OBJPVAttDr.Element("Person_Identifier").Value;
                    //            string Family_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Family_Name").Value) ? "" : OBJPVAttDr.Element("Family_Name").Value;
                    //            string Given_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Given_Name").Value) ? "" : OBJPVAttDr.Element("Given_Name").Value;
                    //            ReffeingPhysicianName = Person_Identifier + "^" + Given_Name + " " + Family_Name;
                    //        }
                    //    }

                    //}


                    //  }
                    if (Patient_Class > 0)
                    {
                        objHLMessage.OrderStatus = string.IsNullOrEmpty(objPV.Element("Patient_Class").Value) ? "" : objPV.Element("Patient_Class").Value;
                        if (objHLMessage.OrderStatus == "I")
                        {
                            EXVType = 0;
                        }
                        else if (objHLMessage.OrderStatus == "O")
                        {
                            EXVType = 1;
                        }
                        else
                        {
                            EXVType = 2;
                        }

                    }


                }


                //Getting Order details
                var OCR = xelement.Descendants("ORC");
                string Order_ControlType = string.Empty;
                foreach (var objOCR in OCR)
                {
                    if (OrderNoCount > 0)
                    {
                        objHLMessage.Placer_Order_Number = objOCR.Element("Place_Order_Number").Value;
                    }
                    if (objHLMessage.Placer_Order_Number == "")
                    {
                        Adderror("Placer_Order_Number");
                    }
                    if (clientcodecount > 0)
                    {
                        clientcode = objOCR.Element("Entered_By").Value;
                        clientcode = "GENERAL";

                    }
                    /*if (objHLMessage.Placer_Order_Number == "")
                    {
                        Adderror("Entered_By");
                    }*/

                    //objHLMessage.OrderStatus = string.IsNullOrEmpty(objOCR.Element("Order_Status").Value) ? "" : objOCR.Element("Order_Status").Value;
                    //if (objHLMessage.OrderStatus == "IP")
                    //{
                    //    EXVType = 0;
                    //}
                    //else if (objHLMessage.OrderStatus == "OP")
                    //{
                    //    EXVType = 1;
                    //}
                    //else
                    //{
                    //    EXVType = 2;
                    //}

                    if (PlacerGroupNumber > 0)
                    {

                        var OPGN = xelement.Descendants("Placer_Group_Number");
                        foreach (var ObjGorupList in OPGN)
                        {
                            int ORReferCount = ObjGorupList.Descendants("Enity_Identifier").Count();
                            int PvMigcount = ObjGorupList.Descendants("ORC.4.1").Count();


                            //string ORREfNumber = string.Empty;
                            //string PVMigNumber = string.Empty;

                            if (ORReferCount > 0)
                            {
                                MigratedReferNumber = string.IsNullOrEmpty(ObjGorupList.Element("Enity_Identifier").Value) ? "" : ObjGorupList.Element("Enity_Identifier").Value;
                            }
                            if (PvMigcount > 0)
                            {
                                MigratedvisitNumber = string.IsNullOrEmpty(ObjGorupList.Element("ORC.4.1").Value) ? "" : ObjGorupList.Element("ORC.4.1").Value;
                            }

                        }
                    }
                    if (QuantityTimingcount > 0)
                    {
                        var QtyTiming = xelement.Descendants("Quantity-Timing");
                        //Quantity-Timing
                        foreach (var objQtyTiming in QtyTiming)
                        {
                            int StatCode = objQtyTiming.Descendants("Priority").Count();
                            if (StatCode > 0 && !(string.IsNullOrEmpty(objQtyTiming.Element("Priority").Value)))
                            {
                                istat = Convert.ToString(objQtyTiming.Element("Priority").Value);
                                if (istat == "099" || istat == "010" || istat.ToUpper() == "S")
                                    issstat = "Y";
                                else if (istat == "001")
                                    issstat = "N";
                            }
                            int Task_Date_Time = objQtyTiming.Descendants("Start_Date-Time").Count();
                            if (Task_Date_Time > 0 && !(string.IsNullOrEmpty(objQtyTiming.Element("Start_Date-Time").Value)))
                            {
                                FutureDate = Convert.ToString(objQtyTiming.Element("Start_Date-Time").Value);
                                var F_Date = "";
                                F_Date = objQtyTiming.Element("Start_Date-Time").Value;
                                if (F_Date != "" && F_Date != "00000000000000")
                                {
                                    string day = F_Date.Substring(6, 2);
                                    string month = F_Date.Substring(4, 2);
                                    string year = F_Date.Substring(0, 4);
                                    string Hour = F_Date.Substring(8, 2);
                                    string Mins = F_Date.Substring(10, 2);
                                    string Sec = F_Date.Substring(12, 2);
                                    string date = day + "-" + month + "-" + year + " " + Hour + ":" + Mins + ":" + Sec;
                                    objHLMessage.Futuredate = Convert.ToDateTime(date);
                                }
                            }
                        }
                    }
                    if (Ordering_Provider > 0)
                    {
                        var PVAttendingDR = xelement.Descendants("Ordering_Provider");
                        foreach (var OBJPVAttDr in PVAttendingDR)
                        {
                            int PIDCount = OBJPVAttDr.Descendants("Person_Identifier").Count();
                            int FNAMECount = OBJPVAttDr.Descendants("Family_Name").Count();
                            int GNAMECount = OBJPVAttDr.Descendants("Given_Name").Count();
                            // if (PIDCount > 0 && FNAMECount > 0 && GNAMECount > 0)
                            if (PIDCount > 0 && FNAMECount > 0)
                            {

                                Person_Identifier = string.IsNullOrEmpty(OBJPVAttDr.Element("Person_Identifier").Value) ? "" : OBJPVAttDr.Element("Person_Identifier").Value;
                                string Family_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Family_Name").Value) ? "" : OBJPVAttDr.Element("Family_Name").Value;
                                //string Given_Name = string.IsNullOrEmpty(OBJPVAttDr.Element("Given_Name").Value) ? "" : OBJPVAttDr.Element("Given_Name").Value;
                                ReffeingPhysicianName = Family_Name;
                                //ReffeingPhysicianName = Person_Identifier + "^" + Given_Name + " " + Family_Name;
                                Person_Identifier = Convert.ToString(Person_Identifier);
                            }
                        }

                    }

                    int phypnocount = objOCR.Descendants("Call_Back_Phone_Number").Count();
                    if (phypnocount > 0 && !(string.IsNullOrEmpty(objOCR.Element("Call_Back_Phone_Number").Value)))
                    {
                        physicianPNo = string.IsNullOrEmpty(objOCR.Element("Call_Back_Phone_Number").Value) ? "" : (objOCR.Element("Call_Back_Phone_Number").Value);
                        int phycount = physicianPNo.Length;
                        physicianPNo = physicianPNo.Substring(1, (phycount - 1));
                    }


                    var Transactiondate = "";
                    Transactiondate = objOCR.Element("Date-Time_Of_Transaction").Value;
                    if (Transactiondate != "" && Transactiondate != "00000000000000")
                    {
                        string day = Transactiondate.Substring(6, 2);
                        string month = Transactiondate.Substring(4, 2);
                        string year = Transactiondate.Substring(0, 4);
                        string Hour = Transactiondate.Substring(8, 2);
                        string Mins = Transactiondate.Substring(10, 2);
                        string Sec = Transactiondate.Substring(12, 2);
                        string date = day + "-" + month + "-" + year + " " + Hour + ":" + Mins + ":" + Sec;
                        objHLMessage.Transaction_Date_Time = Convert.ToDateTime(date);
                        Transactiondate1 = Convert.ToDateTime(date);
                    }
                    objHLMessage.TransferDatetime = System.DateTime.Now;
                    //objHLMessage.OrderCreatedby = objOCR.Element("Entered_By").Value;
                    //objHLMessage.TransferDatetime = DateTime.Now;
                    objHLMessage.OrderCreatedby = "Bala";

                    if (OrderLocation > 0)
                    {
                        objHLMessage.OrderedLocation = string.IsNullOrEmpty(objOCR.Element("Enterer_Location").Value) ? "" : objOCR.Element("Enterer_Location").Value;
                    }
                    if (Confidential > 0)
                    {
                        objHLMessage.Patient_Confidential = string.IsNullOrEmpty(objOCR.Element("Confidentially_Code").Value) ? "" : objOCR.Element("Confidentially_Code").Value;
                    }
                }


                if (Order_Control > 0)
                {
                    foreach (var ObjCType in Order_Control_Type)
                    {
                        objHLMessage.ControlType = string.IsNullOrEmpty(ObjCType.Value) ? "" : ObjCType.Value;
                    }
                }





                var NTComments = xelement.Descendants("NTE");
                //var Order_Control = xelement.Descendants("Order_Control");
                //if (Order_Control.ToString() == "NW")
                //{
                if (NTE > 0)
                {
                    foreach (var ObjNTE in NTComments)
                    {
                        if (ObjNTE.Descendants("NTE_Comment").Count() > 0)
                        {
                            objHLMessage.Remarks = ObjNTE.Element("NTE_Comment").Value;
                        }
                    }
                }
                //}




                var OBR = xelement.Descendants("OBR");
                int i = 0;
                int index = 0;
                string grpName = string.Empty;
                var OR = xelement.Descendants("Universal_Service_Identifier");
                var OResult = xelement.Descendants("Result_Copies_To");
                if (OResult.Count() > 0)
                {
                    foreach (var objresult in OResult)
                    {
                        objHLMessage.ResultCopies = objresult.Value;
                        // objHLMessage.ResultCopies = string.IsNullOrEmpty(objresult.Element("Result_Copies_To").Value) ? "" : objresult.Element("Result_Copies_To").Value;
                    }
                }
                if (OR.Count() > 0)
                {
                    foreach (var objOR in OR)
                    {
                        //foreach (var objOBR in objOR.Descendants("OBR"))
                        //{       
                        grpName = objOR.FirstNode.ToString();

                        // grpName += objOR.Element("Universal_Service_Identifier").Value + "," ;
                        if (grpName.Length > 1)
                        {
                            objHLMessage.GroupName += grpName + ",";

                        }
                        else
                        {
                            objHLMessage.GroupName += grpName;
                        }
                        //objHLMessage.GroupName += objOR.Element("Universal_Service_Identifier").Value + "," ;

                        ////index = 0;
                        ////index = grpName.IndexOf("^");
                        ////if (index > 0)
                        ////    grpName = grpName.Substring(0, index);

                        //////if (objHLMessage.GroupName == "")
                        //////{
                        //////    objHLMessage.GroupName = objOR.Element("Identifier").Value;
                        //////    index = 0;
                        //////    index = objHLMessage.GroupName.IndexOf("^");
                        //////    if (index > 0)
                        //////        objHLMessage.GroupName = objHLMessage.GroupName.Substring(0, index);
                        //////}
                        //////else
                        //////{
                        //////    index = 0;
                        //////    index = objOR.Element("Identifier").Value.IndexOf("^");
                        //////    if (index > 0)
                        //////        objOR.Element("Identifier").Value = objOR.Element("Identifier").Value.Substring(0, index);
                        //////    objHLMessage.GroupName += "^" + objOR.Element("Identifier").Value;
                        //////}

                        //}


                    }

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetHLMessage() Method in HL7Integrationservice", ex);
        }
        return objHLMessage;


    }
    #endregion

    #region GetOrgDetails
    // Getting OrganizationID and OrgAddressId from XML
    private void GetOrgDetails(HLMessages objHLMessage, out int Orgid, out int OrgAddressId)
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
            Returncode = objPatientBL.GetOrgDetails(objHLMessage.Rec_App, objHLMessage.Rec_Facility, out objorgnaization);
            if (objorgnaization.Count > 0)
            {
                Orgid = objorgnaization[0].OrgID;
                OrgAddressId = Convert.ToInt32(objorgnaization[0].ReferTypeID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetOrgDetails() Method in HL7Integrationservice", ex);
        }
    }
    #endregion
    #region GetLoginDetails
    //Getting LoginID and RoleID from XML

    private void GetLoginDetails(HLMessages objHLMessage, out long LoginId, out int RoleId)
    {
        LoginId = 0;
        RoleId = 0;
        long Returncode = 0;

        GateWay objGateWay = new GateWay();
        List<Login> objLogin = new List<Login>();
        try
        {
            Returncode = objGateWay.GetLoginDetails(objHLMessage.LoginName, objHLMessage.RoleName, out objLogin);
            if (objLogin.Count > 0)
            {
                LoginId = objLogin[0].LoginID;
                RoleId = Convert.ToInt32(objLogin[0].OrgID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetLoginDetails() Method in HL7Integrationservice", ex);
        }
    }
    #endregion
    #region SetContextDetails
    //Saving Basic Details into Context Info 
    private ContextDetails SetContextDetails(int OrgId, string LanguageCode, int LocationId, int RoleId, long LoginId)
    {
        ContextDetails objcontext = new ContextDetails();
        objcontext.OrgID = OrgId;
        objcontext.LanguageCode = LanguageCode;
        objcontext.LocationID = LocationId;
        objcontext.RoleID = RoleId;
        objcontext.LoginID = LoginId;
        return objcontext;
    }
    #endregion
    #region Adderror
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
    #endregion
    #region HLPatientDetails
    //Getting Patient Details from XML 
    public Patient HLPatientDetails(HLMessages objHLMessage, List<HLMessagePatientIDDetails> lstPatient, int orgID, long Lid)
    {

        long returncode = -1;
        Patient objPatient = new Patient();
        List<HLMessages> lstobjPatient = new List<HLMessages>();
        Patient objPatient1 = new Patient();
        PatientAddress PA = new PatientAddress();
        DateTime DOB = new DateTime();
        List<PatientAddress> pAddresses = new List<PatientAddress>();
        var MaritalStatus = "";
        var Pincode = "";
        var PatEmail = "";
        try
        {

            objPatient.ExternalPatientNumber = lstPatient[0].Patient_ID;
            returncode = new Patient_BL().GetPatientData("Patient", objPatient.ExternalPatientNumber, orgID, out lstobjPatient);
            objPatient.PatientID = -1;
            if (lstobjPatient.Count > 0)
            {
                objPatient.PatientID = Convert.ToInt64(lstobjPatient[0].Patient_ID);
            }
            if (objPatient.PatientID > 0)
            {
                //objHLMessage.ExternalVisitNumber = "";
            }
            if (lstPatient.Count > 0)
            {
                objPatient.Name = lstPatient[0].Patient_Name;
                objPatient.DOB = lstPatient[0].Date_time_Of_Birth;
                if (string.IsNullOrEmpty(Convert.ToString(lstPatient[0].Date_time_Of_Birth)) || lstPatient[0].Date_time_Of_Birth == DateTime.MaxValue)
                {
                    objPatient.Age = Ageandtype;
                }
                else
                {
                    if (lstPatient[0].Multiple_Birth_Indicator != "" && Convert.ToInt32(lstPatient[0].Birth_Order) > 0)
                    {
                        string agetype = "";
                        string AgeMonth = lstPatient[0].Multiple_Birth_Indicator;
                        switch (AgeMonth)
                        {
                            case "T":
                                agetype = "Minute(s)";
                                break;
                            case "H":
                                agetype = "Hour(s)";
                                break;
                            case "D":
                                agetype = "Day(s)";
                                break;
                            case "W":
                                agetype = "Week(s)";
                                break;
                            case "M":
                                agetype = "Month(s)";
                                break;
                            case "Y":
                                agetype = "Year(s)";
                                break;
                            default:
                                agetype = "";
                                break;
                        }
                        objPatient.Age = lstPatient[0].Birth_Order + " " + agetype;
                    }
                    else
                    {
                        objPatient.Age = CountAge(lstPatient[0].Date_time_Of_Birth);
                    }
                }
                objPatient.SEX = lstPatient[0].Date_Administrative_Sex;
                PA.Add1 = lstPatient[0].Patient_Address;
                objPatient.Add3 = "";
                PA.AddressType = "P";
                //PA.LandLineNumber = objHLMessage.Patient_HomePhone;
                PA.LandLineNumber = lstPatient[0].HPhone_Number_Business;
                PA.MobileNumber = lstPatient[0].Phone_Number_home;
                PA.CountryID = objHLMessage.CountryID;
                PA.StateID = objHLMessage.StateID;
                PA.OtherCountryName = lstPatient[0].Country;
                PA.City = lstPatient[0].City;
                objPatient.CountryID = objHLMessage.CountryID;

                //    objPatient.Nationality = Convert.ToInt64(objHLMessage.Nationality);

                objPatient.CountryName = lstPatient[0].Country;
                objPatient.StateName = "";// lstPatient[0].StateName;
                byte byTitleCode;
                Byte.TryParse(lstPatient[0].HLMessagePatientIDDetailsID.ToString(), out byTitleCode);
                objPatient.TITLECode = byTitleCode;

                pAddresses.Add(PA);
                objPatient.OrgID = orgID;
                objPatient.CreatedBy = Lid;
                objPatient.PatientAddress = pAddresses;
                objPatient.MartialStatus = MaritalStatus;
                objPatient.CompressedName = lstPatient[0].Patient_Name;
                objPatient.PostalCode = Pincode;
                objPatient.RegistrationFee = 0;
                objPatient.SmartCardNumber = "0";
                objPatient.RelationName = "";
                objPatient.RelationTypeId = 0;
                objPatient.Race = "";
                //objPatient.EMail = string.IsNullOrEmpty(lstPatient[0].HTelecommunication_use_code) ? "" : lstPatient[0].HTelecommunication_use_code;
                objPatient.EMail = string.IsNullOrEmpty(lstPatient[0].HCommunication_Address) ? "" : lstPatient[0].HCommunication_Address;
                objPatient.NotifyType = 0;
                objPatient.URNO = "";
                objPatient.URNofId = 0;
                objPatient.URNTypeId = 0;
                objPatient.VisitPurposeID = 3;
                objPatient.SecuredCode = System.Guid.NewGuid().ToString();
                objPatient.TPAName = "";
                objPatient.TPAAttributes = "";
                objPatient.RoundNo = "";
                objPatient.ParentPatientID = 0;
                objPatient.PatientHistory = string.IsNullOrEmpty(objHLMessage.DetailHistory) ? "" : objHLMessage.DetailHistory;
                objPatient.PatientType = "";
                objPatient.PatientStatus = "NR";
                objPatient.PriorityID = "0";
                objPatient.ReferingPhysicianName = ReffeingPhysicianName; //string.IsNullOrEmpty(objHLMessage.ReferingPhysicianName) ? "" : objHLMessage.ReferingPhysicianName;
                objPatient.ReferedHospitalName = string.IsNullOrEmpty(objHLMessage.ReferedHospitalName) ? "" : objHLMessage.ReferedHospitalName;
                objPatient.RegistrationRemarks = string.IsNullOrEmpty(objHLMessage.Remarks) ? "" : objHLMessage.Remarks;
                objPatient.ExAutoAuthorization = "";
                objPatient.ZoneID = 0;
                objPatient.SpeciesName = lstPatient[0].Species_Code;
                objPatient.Confidential = string.IsNullOrEmpty(lstPatient[0].Confidential) ? "N" : lstPatient[0].Confidential;
                // objPatient.SpeciesName = objHLMessage.SpeciesName;

                int passwordlength = 6;
                string NewPassword = string.Empty;
                GeneratePassword objGeneratePass = new GeneratePassword();
                objGeneratePass.GenerateNewPassword(passwordlength, out NewPassword);
                objPatient.NewPassword = NewPassword;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetPatientDetails() Method in HL7Integrationservice", ex);
        }
        return objPatient;
    }
    #endregion
    #region HLOrderDetails
    //Getting Order Details from XML 
    public List<OrderedInvestigations> HLOrderDetails(HLMessages objHLMessage, List<HLMessageOBRDetails> lstHLMessageOBRDetails, ContextDetails objcontextinfo, int orgID, long PatientId, out string gUID)
    {
        List<OrderedInvestigations> objlstOrderinv = new List<OrderedInvestigations>();
        List<OrderedInvestigations> objlstOrdinv = new List<OrderedInvestigations>();
        List<DischargeInvNotes> lstinvMaster = new List<DischargeInvNotes>();
        List<HLMessageOBRDetails> lstTempHLMessageOBRDetails = new List<HLMessageOBRDetails>();
        DischargeInvNotes lstInvNote;
        string IsExists = "N";
        long Returncode = -1;
        gUID = Guid.NewGuid().ToString();
        TatDateTime = lstHLMessageOBRDetails[0].Scheduled_Date_Time;
        try
        {
            issstat = lstHLMessageOBRDetails.Exists(P => P.OBRQuantity_TimingPriority == "S") ? "Y" : "N";
            foreach (var child in lstHLMessageOBRDetails)
            {
                lstInvNote = new DischargeInvNotes();
                lstInvNote.DischargeInvNotesID = 0;
                lstInvNote.InvestigationDetails = child.Universal_Service_Identifier;
                lstInvNote.Type = child.Parent_Result_Observation_Identifier;
                lstInvNote.DiscountAmount = child.Tasks_Line_Discount;
                lstInvNote.ActualAmount = child.Tasks_Line_Amount;
                lstInvNote.SalesAmount = child.Tasks_Sales_Price;
                lstInvNote.HistoryDetails = child.Collectors_Comment;
                lstInvNote.VisitID = child.HLMessageOBRDetailsID;
                int intTestSeqOrder = 0;
                Int32.TryParse(child.OBRPriority, out intTestSeqOrder);
                lstInvNote.TestSequenceOrder = intTestSeqOrder;
                lstinvMaster.Add(lstInvNote);
            }

            lstTempHLMessageOBRDetails = (from child in lstHLMessageOBRDetails
                                          group child by new { child.Parent_Result_Observation_Identifier } into newchild
                                          select new HLMessageOBRDetails
                                          {
                                              Parent_Result_Observation_Identifier = newchild.Key.Parent_Result_Observation_Identifier
                                          }).ToList();

            foreach (var child in lstTempHLMessageOBRDetails)
            {
                lstInvNote = new DischargeInvNotes();
                lstInvNote.DischargeInvNotesID = 0;
                lstInvNote.InvestigationDetails = child.Parent_Result_Observation_Identifier;
                lstinvMaster.Add(lstInvNote);
            }

            #region comment
            //if (objHLMessage.GroupName.Split('^') != null)
            //{
            //    string[] SplitGrpName = objHLMessage.GroupName.Split('^');
            //    for (int i = 0; i < SplitGrpName.Count(); i++)
            //    {
            //        lstInvNote = new DischargeInvNotes();
            //        lstInvNote.DischargeInvNotesID = 0;
            //        lstInvNote.InvestigationDetails = SplitGrpName[i];
            //        //  lstInvNote.Type = "GRP";
            //        lstinvMaster.Add(lstInvNote);
            //    }
            //}
            #endregion


            if (lstinvMaster.Count > 0)
            {
                Returncode = new Investigation_BL(objcontextinfo).GetInvestigationList(lstinvMaster, orgID, out objlstOrderinv);
            }
            if (objlstOrderinv.Count > 0)
            {
                Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
                string OrderedID = objHLMessage.Placer_Order_Number.ToString();
                #region comment
                ////Inv_BL.CheckOrdereIDExists("OrderedID", OrderedID, PatientId, 0, objlstOrderinv[0].ID, objlstOrderinv[0].Type, out IsExists);
                ////if (IsExists == "N")
                ////{
                ////    //var _flag = objlstOrdinv.Any(p => p.ID == objlstOrderinv[0].ID && p.Type == objlstOrderinv[0].Type && p.LabNo == objHLMessage.Placer_Order_Number);
                ////    objlstOrderinv[0].LabNo = objHLMessage.Placer_Order_Number;
                ////    objlstOrderinv[0].UID = gUID;
                ////    objlstOrderinv[0].VisitID = -1;
                ////    objlstOrderinv[0].Status = "Paid";
                ////    objlstOrderinv[0].OrgID = orgID;
                ////    objlstOrderinv[0].PaymentStatus = "Paid";
                ////    objlstOrderinv[0].StudyInstanceUId = CreateUniqueDecimalString();
                ////    objlstOrderinv[0].IsStat = issstat;
                ////    objlstOrdinv.Add(objlstOrderinv[0]);
                ////}
                #endregion
            }

            #region comment
            //for (int i = 0; i < objlstOrdinv.Count; i++)
            //{

            //    objlstOrdinv[i].LabNo = objHLMessage.Placer_Order_Number;
            //    objlstOrdinv[i].UID = gUID;
            //    objlstOrdinv[i].VisitID = -1;
            //    objlstOrdinv[i].Status = "Paid";
            //    objlstOrdinv[i].OrgID = orgID;
            //    objlstOrdinv[i].PaymentStatus = "Paid";
            //    objlstOrdinv[i].StudyInstanceUId = CreateUniqueDecimalString();
            //    objlstOrdinv[i].IsStat = issstat;
            //}
            #endregion
            for (int i = 0; i < objlstOrderinv.Count; i++)
            {
                Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
                string OrderedID = lstHLMessageOBRDetails[0].Tasks_Sales_ID;

                //Inv_BL.CheckOrdereIDExists("OrderedID", OrderedID, PatientId, 0, objlstOrderinv[i].ID, objlstOrderinv[i].Type, out IsExists);
                //if (IsExists == "N")
                //{

                objlstOrderinv[i].LabNo = objHLMessage.Placer_Order_Number;
                objlstOrderinv[i].UID = gUID;
                objlstOrderinv[i].VisitID = -1;
                objlstOrderinv[i].Status = "Paid";
                objlstOrderinv[i].OrgID = orgID;
                objlstOrderinv[i].PaymentStatus = "Paid";
                objlstOrderinv[i].StudyInstanceUId = CreateUniqueDecimalString();
                objlstOrderinv[i].IsStat = string.IsNullOrEmpty(issstat) ? "N" : issstat;
                objlstOrderinv[i].SampleID = objlstOrderinv[i].TCODE;
                objlstOrderinv[i].InvestigationsType = objlstOrderinv[i].CollectorComments;
                objlstOrderinv[i].ReferedToOrgID =objlstOrderinv[i].HLMessageOBRDetailsID;
                objlstOrderinv[i].TestSequenceOrder = objlstOrderinv[i].TestSequenceOrder;
                //objlstOrderinv[i].TatDateTime = TatDateTime;
                objlstOrdinv.Add(objlstOrderinv[i]);

                //}
            }

            foreach (var child in objlstOrdinv)
            {
                foreach (var child1 in lstinvMaster)
                {
                    if (child.TCODE == child1.InvestigationDetails)
                    {
                        child.SalesAmount = child1.SalesAmount;
                        child.ActualAmount = child1.ActualAmount;
                        child.DiscountAmount = child1.DiscountAmount;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading HLOrderDetails", ex);

        }

        return objlstOrdinv;
    }
    #endregion
    #region GetFinalbilldetail
    //Getting Billing Details from XML 
    public FinalBill GetFinalbilldetail(List<OrderedInvestigations> lstOrderInv, int OrgAddressID)
    {
        FinalBill objFinalbill = new FinalBill();
        for (int i = 0; i < lstOrderInv.Count; i++)
        {
            objFinalbill.AmountReceived += lstOrderInv[i].Rate;
            objFinalbill.NetValue += lstOrderInv[i].Rate;
            objFinalbill.GrossBillValue += lstOrderInv[i].Rate;
            objFinalbill.VisitID = -1;
            objFinalbill.OrgID = lstOrderInv[i].OrgID;
            objFinalbill.OrgAddressID = OrgAddressID;
            objFinalbill.IsCreditBill = "N";
        }
        return objFinalbill;
    }
    #endregion
    #region GetAmountReceivedDetails
    public DataTable GetAmountReceivedDetails(FinalBill objFinalBill)
    {
        System.Data.DataTable _datatable = new System.Data.DataTable();

        _datatable.Columns.Add("AmtReceived", typeof(System.Decimal));
        _datatable.Columns.Add("TypeID", typeof(System.Int32));
        _datatable.Columns.Add("ChequeorCardNumber", typeof(System.String));
        _datatable.Columns.Add("BankNameorCardType", typeof(System.String));
        _datatable.Columns.Add("Remarks", typeof(System.String));
        _datatable.Columns.Add("ChequeValidDate", typeof(System.DateTime));
        _datatable.Columns.Add("ServiceCharge", typeof(System.Decimal));
        _datatable.Columns.Add("BaseCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("PaidCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("OtherCurrencyAmount", typeof(System.Decimal));
        _datatable.Columns.Add("EMIOpted", typeof(System.String));
        _datatable.Columns.Add("EMIROI", typeof(System.Decimal));
        _datatable.Columns.Add("EMITenor", typeof(System.Int32));
        _datatable.Columns.Add("EMIValue", typeof(System.Decimal));
        _datatable.Columns.Add("ReferenceID", typeof(System.Int64));
        _datatable.Columns.Add("ReferenceType", typeof(System.String));
        _datatable.Columns.Add("Units", typeof(System.Int32));
        _datatable.Columns.Add("CardHolderName", typeof(System.String));
        _datatable.Columns.Add("CashGiven", typeof(System.Decimal));
        _datatable.Columns.Add("BalanceGiven", typeof(System.Decimal));
        _datatable.Columns.Add("TransactionID", typeof(System.String));
        _datatable.Columns.Add("BranchName", typeof(System.String));
        _datatable.Columns.Add("PaymentCollectedFrom", typeof(System.String));
        _datatable.Columns.Add("IsOutStation", typeof(System.String));
        _datatable.Columns.Add("AmtReceivedID", typeof(System.Int64));
        _datatable.Columns.Add("AuthorisationCode", typeof(System.String));



        DataRow _datarow;
        _datarow = _datatable.NewRow();

        _datarow["AmtReceived"] = objFinalBill.AmountReceived;
        _datarow["TypeID"] = 1;
        _datarow["ChequeorCardNumber"] = 0;
        _datarow["BankNameorCardType"] = "";
        _datarow["Remarks"] = "";
        _datarow["ChequeValidDate"] = DateTime.Now;
        _datarow["ServiceCharge"] = 0;
        _datarow["BaseCurrencyID"] = 63;
        _datarow["PaidCurrencyID"] = 63;
        _datarow["OtherCurrencyAmount"] = objFinalBill.AmountReceived;
        _datarow["EMIOpted"] = "N";
        _datarow["EMIROI"] = 0;
        _datarow["EMITenor"] = 0;
        _datarow["EMIValue"] = 0;
        _datarow["ReferenceID"] = 0;
        _datarow["ReferenceType"] = "0";
        _datarow["Units"] = 0;
        _datarow["CardHolderName"] = "";
        _datarow["CashGiven"] = 0;
        _datarow["BalanceGiven"] = 0;
        _datarow["TransactionID"] = "";
        _datarow["BranchName"] = "";
        _datarow["PaymentCollectedFrom"] = "";
        _datarow["IsOutStation"] = "";
        _datarow["AmtReceivedID"] = 0;
        _datarow["AuthorisationCode"] = "";
        _datatable.Rows.Add(_datarow);
        return _datatable;

    }
    #endregion
    #region GetBillingItems
    public List<PatientDueChart> GetBillingItems(List<OrderedInvestigations> lstOrdinv)
    {
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<OrderedInvestigations> lstOrdinvtemp = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstOrdPKGtemp = new List<OrderedInvestigations>();
        //lstOrdinv.RemoveAll(p => p.PkgID > 0);
        lstOrdinvtemp = lstOrdinv.Where(x => x.PkgID <= 0).ToList();
        lstOrdPKGtemp = lstOrdinv.Where(x => x.PkgID > 0).ToList();
        PatientDueChart objBilling;
        for (int i = 0; i < lstOrdinvtemp.Count; i++)
        {
            objBilling = new PatientDueChart();
            objBilling.Description = lstOrdinvtemp[i].Name;
            objBilling.IsReimbursable = "N";
            objBilling.IsTaxable = "N";
            objBilling.IsDiscountable = "Y";
            objBilling.IsSTAT = string.IsNullOrEmpty(issstat) ? "N" : issstat;
            objBilling.IsOutSource = "N";
            objBilling.IsNABL = "Y";
            objBilling.ActualAmount = lstOrdinvtemp[i].ActualAmount;
            objBilling.AdvanceAmount = 0;
            objBilling.Amount = lstOrdinvtemp[i].SalesAmount;
            objBilling.DiscountAmount = lstOrdinvtemp[i].DiscountAmount;
            objBilling.FeeID = lstOrdinvtemp[i].ID;
            objBilling.FeeType = lstOrdinvtemp[i].Type;
            objBilling.Status = "Paid";
            objBilling.FromDate = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm tt"));
            objBilling.ToDate = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm tt"));
            objBilling.TatDate = TatDateTime;// Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm tt"));
            objBilling.VisitID = -1;
            objBilling.OrgID = lstOrdinvtemp[i].OrgID;
            objBilling.Unit = Convert.ToDecimal(1.00);
            lstPatientDueChart.Add(objBilling);
        }

        foreach (var child in lstPatientDueChart)
        {
            foreach (var child1 in lstOrdPKGtemp)
            {
                if (child.FeeID == child1.PkgID)
                {
                    child.Amount += child1.SalesAmount;
                    child.DiscountAmount += child1.DiscountAmount;
                    child.ActualAmount += child1.ActualAmount;
                }
            }
        }

        return lstPatientDueChart;
    }
    #endregion
    #region GetVisitClientMappingDetails
    public List<VisitClientMapping> GetVisitClientMappingDetails(string clientcode, int orgid)
    {
        List<VisitClientMapping> objlstVcm = new List<VisitClientMapping>();

        try
        {
            List<ClientMaster> lstClientmaster = new List<ClientMaster>();
            VisitClientMapping objVcm = new VisitClientMapping();
            Referrals_BL refs = new Referrals_BL();
            Patient_BL PatientBL = new Patient_BL();
            // int ExecuteType = 0;
            //int Clientid = 0;
            List<DiscountPolicy> lstDiscountPolicy = new List<DiscountPolicy>();
            //PatientBL.GetClientNamebyClientType(orgid, clientcode, -1, -1, out lstClientmaster);
            PatientBL.GetClientName(orgid, clientcode, -1, out lstClientmaster);
            if (lstClientmaster.Count > 0)
            {
                objVcm.ClientID = lstClientmaster[0].ClientID;
            }
            else
            {
                objVcm.ClientID = 1;
            }
            // string.IsNullOrEmpty(ObjNameList.Element("Given_Name").Value) ? "" : ObjNameList.Element("Given_Name").Value;
            objVcm.RateID = 0;
            objVcm.VisitID = -1;
            objlstVcm.Add(objVcm);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetVisitClientMappingDetails() Method in HL7Integrationservice", ex);
        }
        return objlstVcm;
    }
    #endregion
    #region GetXmlErrorDescription
    //Capture Error Description
    private string GetXmlErrorDescription(string[] Errorlist, HLMessages objHLMessage, string HL7Message, ContextDetails objcontext, long isXmlExist)
    {
        StringBuilder sbnew = new StringBuilder();
        if (Errorlist != null)
        {

            //xw.WriteStartElement("Provide_Details");
            for (int i = 0; i < Errorlist.Count(); i++)
            {
                if (Errorlist[i] == "Send_ApplicationE")
                {

                    sbnew.Append(objHLMessage.Sending_App + " not found");
                    Errorcode1 = "0";
                }
                else if (Errorlist[i] == "Sending_Application")
                {

                    sbnew.Append("Sending application not given");
                    Errorcode1 = "0";
                }
                else if (Errorlist[i] == "Send_FacilityE")
                {

                    sbnew.Append(objHLMessage.Sending_Facility + " not found");
                    Errorcode1 = "0";
                }
                else if (Errorlist[i] == "Sending_Facility")
                {

                    sbnew.Append("Sending Facility not given");
                    Errorcode1 = "0";
                }
                else if (Errorlist[i] == "Message_ID")
                {

                    sbnew.Append("Message ID not found");
                    Errorcode1 = "0";
                }
                else if (Errorlist[i] == "Ordered Test Missing")
                {

                    sbnew.Append("Ordered test Missing Due to Invalid TestCode");
                    Errorcode1 = "0";
                }

                else
                {

                    sbnew.Append(Errorlist[i] + " not given");
                    Errorcode1 = "0";
                }
            }
            // xw.WriteEndElement();
        }
        return sbnew.ToString();
    }
    #endregion
    #region GetXmlerror
    // Generating Acknowledgement XML. 
    private XmlDocument GetXmlerror(string[] Errorlist, HLMessages objHLMessage, string HL7Message, ContextDetails objcontext, long isXmlExist)
    {
        long returncode = 0;
        string UniqueCtrlKey = string.Empty;
        string XmlValue = string.Empty;
        string datetime = DateTime.Now.ToString().Replace("/", "");
        StringBuilder sb = new StringBuilder();
        StringBuilder sbnew = new StringBuilder();
        XmlWriterSettings settings = new XmlWriterSettings();
        XmlDocument xmlDocument = new XmlDocument();
        try
        {
            UniqueCtrlKey = GetUniqueCtrlKey();
            using (var xw = XmlWriter.Create(sb, settings))
            {
                xw.WriteStartElement("data");
                xw.WriteElementString("Message_ID", UniqueCtrlKey);
                xw.WriteElementString("Message_Type", objHLMessage.MsgType);
                xw.WriteElementString("Sending_Application", objHLMessage.Rec_App);
                xw.WriteElementString("Sending_Facility", objHLMessage.Rec_Facility);
                xw.WriteElementString("Recv_Application", objHLMessage.Sending_App);
                xw.WriteElementString("Recv_Facility", objHLMessage.Sending_Facility);
                xw.WriteElementString("Date_Time", datetime);
                if (isXmlExist == -1)
                {
                    xw.WriteElementString("Acknowledgment", "AR");
                    xw.WriteElementString("Parent_Message_ID", objHLMessage.MsgControlId);
                    //xw.WriteStartElement("Reject");
                    xw.WriteElementString("ErrorMessage", "Duplicate Message ID");
                    sbnew.Append("Not Inserted Properly");
                    //sbnew.Append("D");
                    Errorcode1 = "0";
                    //xw.WriteEndElement();
                }

                else
                {
                    if (Errorlist != null)
                    {
                        xw.WriteElementString("Acknowledgment", "AR");
                        xw.WriteElementString("Parent_Message_ID", objHLMessage.MsgControlId);
                        //xw.WriteStartElement("Provide_Details");
                        for (int i = 0; i < Errorlist.Count(); i++)
                        {
                            if (Errorlist[i] == "Send_ApplicationE")
                            {
                                xw.WriteElementString("ErrorMessage", "Sending application " + objHLMessage.Sending_App + " not found");
                                sbnew.Append(objHLMessage.Sending_App + " not found");
                                Errorcode1 = "0";
                            }
                            else if (Errorlist[i] == "Sending_Application")
                            {
                                xw.WriteElementString("ErrorMessage", "Sending application not given");
                                sbnew.Append("Sending application not given");
                                Errorcode1 = "0";
                            }
                            else if (Errorlist[i] == "Send_FacilityE")
                            {
                                xw.WriteElementString("ErrorMessage", "Sending Facility " + objHLMessage.Sending_Facility + " not found");
                                sbnew.Append(objHLMessage.Sending_Facility + " not found");
                                Errorcode1 = "0";
                            }
                            else if (Errorlist[i] == "Sending_Facility")
                            {
                                xw.WriteElementString("ErrorMessage", "Sending Facility not given");
                                sbnew.Append("Sending Facility not given");
                                Errorcode1 = "0";
                            }
                            else if (Errorlist[i] == "Message_ID")
                            {
                                xw.WriteElementString("ErrorMessage", "Message ID not found");
                                sbnew.Append("Message ID not found");
                                Errorcode1 = "0";
                            }
                            else if (Errorlist[i] == "Ordered Test Missing")
                            {
                                xw.WriteElementString("ErrorMessage", "Ordered test Missing Due to Invalid TestCode");
                                sbnew.Append("Ordered test Missing Due to Invalid TestCode");
                                Errorcode1 = "0";
                            }

                            else
                            {
                                xw.WriteElementString("ErrorMessage", Errorlist[i] + " not given");
                                sbnew.Append(Errorlist[i] + " not given");
                                Errorcode1 = "0";
                            }
                        }
                        // xw.WriteEndElement();
                    }
                    else
                    {
                        xw.WriteElementString("Acknowledgment", "AA");
                        xw.WriteElementString("Parent_Message_ID", objHLMessage.MsgControlId);
                        xw.WriteStartElement("Success");
                        xw.WriteElementString("Registration", "Successfully Registered");
                        xw.WriteEndElement();
                    }
                }
                xw.WriteEndElement();
                xw.Flush();
                xmlDocument.LoadXml(sb.ToString());
                objHLMessage.ErrorList = sb.ToString();
                if (sbnew != null)
                {
                    objHLMessage.ErrorList = sbnew.ToString();
                }
                else
                {
                    objHLMessage.ErrorList = "";
                }
                //returncode = new Patient_BL(objcontext).insertHLMessage(objHLMessage, UniqueCtrlKey, xmlDocument.InnerXml, HL7Message);
            }
        }
        catch (Exception ex)
        {

        }
        return xmlDocument;
    }
    #endregion
    public static void GetDifference(DateTime date1, DateTime date2, out int Years, out int Months, out int Weeks, out int Days)
    {
        //assumes date2 is the bigger date for simplicity
        //----------------------------------------------
        //years
        TimeSpan diff = date2 - date1;
        Years = diff.Days / 366;
        DateTime workingDate = date1.AddYears(Years);
        while (workingDate.AddYears(1) <= date2)
        {
            workingDate = workingDate.AddYears(1);
            Years++;
        }
        //---------------------------------------------
        //months
        diff = date2 - workingDate;
        Months = diff.Days / 31;
        workingDate = workingDate.AddMonths(Months);
        while (workingDate.AddMonths(1) <= date2)
        {
            workingDate = workingDate.AddMonths(1);
            Months++;
        }
        //---------------------------------------------
        //weeks and days
        diff = date2 - workingDate;
        if (diff.Days % 7 > 0)
        {
            Weeks = 0; //weeks always have 7 days
            Days = diff.Days;
        }
        else
        {
            Weeks = diff.Days / 7; //weeks always have 7 days
            Days = 0;
        }
        //---------------------------------------------
    }
    #region CountAge
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
        int intye = 0;
        int intmon = 0;
        int intda = 0;
        int intweek = 0;
        GetDifference(DOB, today, out intye, out intmon, out intweek, out intda);
        if (intye <= 0)
        {
            if (intmon <= 0)
            {
                if (intweek <= 0)
                {
                    if (intda >= 0)
                    {
                        Returnage = intda.ToString() + " " + "Day(s)";
                    }
                }

                else
                {
                    Returnage = intweek.ToString() + " " + "Week(s)";
                }
            }
            else
            {
                Returnage = intmon.ToString() + " " + "Month(s)";
                if (intmon > 11)
                {
                    Returnage = Math.Round(intmon / 12.0) + " " + "Year(s)";
                }
            }
        }
        else
        {
            Returnage = intye.ToString() + " " + "Year(s)";
        }

        return Returnage;

    }
    #endregion
    #region CreateUniqueDecimalString
    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    #endregion
    #region GetUniqueKey
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    #endregion
    #region GetUniqueCtrlKey
    private string GetUniqueCtrlKey()
    {
        int maxSize = 5;
        char[] chars = new char[62];
        string a;
        a = "01234567890123456789ABCDEF01234567890123456789ABCDEF01234567890123456789ABCDEF";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    #endregion
    #region leapyear
    private bool leapyear(int a)
    {
        if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
        { return true; }
        else
        { return false; }
    }
    #endregion

    #region JC Code
    #region ConvertToXml
    private string ConvertToXml(string sHL7)
    {

        XmlDocument _xmlDoc;

        //Read the HL7Tags        

        hl7toxml hl7_Props = new hl7toxml();

        // Go and create the base XML
        _xmlDoc = CreateXmlDoc();

        // HL7 message segments are terminated by carriage returns, so to get an array of the message segments, split on carriage return
        //string[] sHL7Lines = sHL7.Split('\n');
        string[] sHL7Lines = sHL7.Split('\r');
        //string[] stringSeparators = new string[] { "<br/>" };
        //string[] sHL7Lines = sHL7.Split(stringSeparators, StringSplitOptions.None);

        // Now we want to replace any other unprintable control characters with whitespace otherwise they'll break the XML
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            sHL7Lines[i] = Regex.Replace(sHL7Lines[i], @"[^ -~]", "");
        }

        // Go through each segment in the message and first get the fields, separated by pipe (|), then for each of those, get the field components,
        // separated by carat (^), and check for repetition (~) and also check each component for subcomponents, and repetition within them too.
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            // Don't care about empty lines
            if (sHL7Lines[i] != string.Empty)
            {
                // Get the line and get the line's segments
                string sHL7Line = sHL7Lines[i];
                string[] sFields = GetMessgeFields(sHL7Line);

                // Create a new element in the XML for the line
                XmlElement el = _xmlDoc.CreateElement(sFields[0]);
                _xmlDoc.DocumentElement.AppendChild(el);

                // For each field in the line of HL7
                for (int a = 0; a < sFields.Length; a++)
                {
                    // Create a new element
                    //XmlElement fieldEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString());

                    XmlElement fieldEl;

                    string cur_val = sFields[0] + "." + a.ToString(); //fieldEl.LocalName;                           

                    if (hl7_Props.hl7tags.ContainsKey(cur_val))
                    {
                        cur_val = hl7_Props.hl7tags[cur_val];
                    }


                    fieldEl = _xmlDoc.CreateElement(cur_val);


                    // Part of the HL7 specification is that part of the message header defines which characters are going to be used to delimit the message
                    // and since we want to capture the field that contains those characters we need to just capture them and stick them in an element.

                    if (sFields[a] != @"^~\&" && cur_val != "Encoding_Characters") // Here I don't want to split the MSH Encoding characters. So using this condition
                    {
                        // Get the components within this field, separated by carats (^). If there are more than one, go through and create an element
                        // for each, then check for subcomponents, and repetition in both.

                        string[] sComponents = GetComponents(sFields[a]);
                        if (sComponents.Length > 1)
                        {
                            for (int b = 0; b < sComponents.Length; b++)
                            {
                                //XmlElement componentEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString() + "." + b.ToString());

                                string cur_val1 = sFields[0] + "." + a.ToString() + "." + b.ToString(); // Form the components and sub components here

                                if (hl7_Props.hl7tags.ContainsKey(cur_val1)) // Check with our Dictionary
                                {
                                    cur_val1 = hl7_Props.hl7tags[cur_val1];
                                }
                                //string res2 = hl7_Props.CurrentValue;


                                XmlElement componentEl = _xmlDoc.CreateElement(cur_val1);  // Write into the XML 

                                string[] subComponents = GetSubComponents(sComponents[b]);
                                if (subComponents.Length > 1)
                                // There were subcomponents
                                {
                                    for (int c = 0; c < subComponents.Length; c++)
                                    {
                                        // Check for repetition
                                        string[] subComponentRepetitions = GetRepetitions(subComponents[c]);
                                        if (subComponentRepetitions.Length > 1)
                                        {
                                            for (int d = 0; d < subComponentRepetitions.Length; d++)
                                            {
                                                string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString() + "." + d.ToString(); // Form the components and sub components here

                                                if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                                {
                                                    cur_val2 = hl7_Props.hl7tags[cur_val2];
                                                }

                                                XmlElement subComponentRepEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                                subComponentRepEl.InnerText = subComponentRepetitions[d];
                                                componentEl.AppendChild(subComponentRepEl);
                                            }
                                        }
                                        else
                                        {
                                            string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString();  // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                            {
                                                cur_val2 = hl7_Props.hl7tags[cur_val2];
                                            }

                                            XmlElement subComponentEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                            subComponentEl.InnerText = subComponents[c];
                                            componentEl.AppendChild(subComponentEl);

                                        }
                                    }
                                    fieldEl.AppendChild(componentEl);
                                }
                                else // There were no subcomponents
                                {
                                    string[] sRepetitions = GetRepetitions(sComponents[b]);
                                    if (sRepetitions.Length > 1)
                                    {
                                        XmlElement repetitionEl = null;
                                        for (int c = 0; c < sRepetitions.Length; c++)
                                        {
                                            string cur_val3 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString(); // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val3)) // Check with our Dictionary
                                            {
                                                cur_val3 = hl7_Props.hl7tags[cur_val3];
                                            }
                                            repetitionEl = _xmlDoc.CreateElement(cur_val3); // Write into the XML 
                                            repetitionEl.InnerText = sRepetitions[c].Replace("_", " ");
                                            componentEl.AppendChild(repetitionEl);
                                        }
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                    else
                                    {
                                        componentEl.InnerText = sComponents[b];
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                }
                            }
                            el.AppendChild(fieldEl);
                        }
                        else
                        {
                            fieldEl.InnerText = sFields[a];
                            el.AppendChild(fieldEl);
                        }
                    }
                    else
                    {
                        fieldEl.InnerText = sFields[a];
                        el.AppendChild(fieldEl);
                    }
                }
            }
        }
        string result = Convert.ToString(_xmlDoc.OuterXml.ToString());
        return _xmlDoc.OuterXml;

        //Call the function with output

    }
    #endregion
    #region ConvertToXmlByManual
    private string ConvertToXmlByManual(string sHL7)
    {

        XmlDocument _xmlDoc;

        //Read the HL7Tags        

        hl7toxml hl7_Props = new hl7toxml();

        // Go and create the base XML
        _xmlDoc = CreateXmlDoc();

        // HL7 message segments are terminated by carriage returns, so to get an array of the message segments, split on carriage return
        //string[] sHL7Lines = sHL7.Split('\n');
        string[] sHL7Lines = sHL7.Split('\r');
        //string[] stringSeparators = new string[] { "<br/>" };
        //string[] sHL7Lines = sHL7.Split(stringSeparators, StringSplitOptions.None);

        // Now we want to replace any other unprintable control characters with whitespace otherwise they'll break the XML
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            sHL7Lines[i] = Regex.Replace(sHL7Lines[i], @"[^ -~]", "");
        }

        // Go through each segment in the message and first get the fields, separated by pipe (|), then for each of those, get the field components,
        // separated by carat (^), and check for repetition (~) and also check each component for subcomponents, and repetition within them too.
        string Segment = "";
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            // Don't care about empty lines
            if (sHL7Lines[i] != string.Empty)
            {
                // Get the line and get the line's segments
                string sHL7Line = sHL7Lines[i];
                string[] sFields = GetMessgeFields(sHL7Line);
                if (i < lstHL7Segments.Count())
                {
                    Segment = lstHL7Segments[i].HL7SegmentsName;
                }
                if (sFields[0].Trim() == "")
                {
                    HLMessageErrorDetails objHLMessageErrorDetails1 = new HLMessageErrorDetails();
                    //if (i == 0)
                    //{
                    //    objHLMessageErrorDetails1.HLMessageColumns = "MSH";
                    //    objHLMessageErrorDetails1.HLMessageError = "MSH - Missing";
                    //}
                    //else if (i == 1)
                    //{
                    //    objHLMessageErrorDetails1.HLMessageColumns = "PID";
                    //    objHLMessageErrorDetails1.HLMessageError = "PID - Missing";
                    //}
                    //else if (i == 2)
                    //{
                    //    objHLMessageErrorDetails1.HLMessageColumns = "ORC";
                    //    objHLMessageErrorDetails1.HLMessageError = "ORC - Missing";
                    //}
                    //else
                    //{
                    //    objHLMessageErrorDetails1.HLMessageColumns = "OBR";
                    //    objHLMessageErrorDetails1.HLMessageError = "OBR - Missing";
                    //}
                    //objHLMessageErrorDetails1.FileNames = strFileName;
                    //lstHLMessageErrorDetails.Add(objHLMessageErrorDetails1);
                    //break;
                    string strSegments = sFields[0].Trim();
                    if (i <= lstHL7Segments.Count())
                    {
                        if (!(lstHL7Segments.Exists((P => P.HL7SegmentsName == strSegments && ((P.SeqOrder == i) && (P.HL7ControlType.ToUpper() == sFields[1].Trim().ToUpper()))))))
                        {
                            HLMessageErrorDetails objHLMessageErrorDetails2 = new HLMessageErrorDetails();
                            objHLMessageErrorDetails2.HLMessageColumns = Segment;
                            objHLMessageErrorDetails2.HLMessageError = Segment + " - Missing";
                            objHLMessageErrorDetails2.FileNames = strFileName;
                            objHLMessageErrorDetails2.LocationID = -1;
                            objHLMessageErrorDetails2.HLMessageTable = Segment;
                            intOrgAddressID = -1;
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails2);
                            break;
                        }
                    }
                    else
                    {
                        if (Segment != strSegments)
                        {
                            HLMessageErrorDetails objHLMessageErrorDetails2 = new HLMessageErrorDetails();
                            objHLMessageErrorDetails2.HLMessageColumns = Segment;
                            objHLMessageErrorDetails2.HLMessageError = Segment + " - Missing";
                            objHLMessageErrorDetails2.FileNames = strFileName;
                            objHLMessageErrorDetails2.HLMessageTable = Segment;
                            intOrgAddressID = -1;
                            lstHLMessageErrorDetails.Add(objHLMessageErrorDetails2);
                            break;
                        }
                    }
                }
                else if (sFields[0].Trim() != "")
                {
                    string strSegments = sFields[0].Trim();
                    if (!(lstHL7Segments.Exists((P => P.HL7SegmentsName == strSegments && ((P.HL7ControlType.ToUpper() == "BOTH") || (P.HL7ControlType.ToUpper() == sFields[1].Trim().ToUpper()))))))
                    {
                        HLMessageErrorDetails objHLMessageErrorDetails2 = new HLMessageErrorDetails();
                        objHLMessageErrorDetails2.HLMessageColumns = "Invalid File Format";
                        objHLMessageErrorDetails2.HLMessageError = strSegments + " Not Valid Segment";
                        objHLMessageErrorDetails2.FileNames = strFileName;
                        objHLMessageErrorDetails2.HLMessageTable = Segment;
                        intOrgAddressID = -1;
                        lstHLMessageErrorDetails.Add(objHLMessageErrorDetails2);
                        break;
                    }
                    //else if (!(lstHL7Segments.Exists((P => P.HL7SegmentsName == strSegments && ((P.SeqOrder == i + 1 && strSegments != "OBR") && (P.HL7ControlType.ToUpper() == sFields[1].Trim().ToUpper()))))))
                    //{
                    //    HLMessageErrorDetails objHLMessageErrorDetails2 = new HLMessageErrorDetails();
                    //    objHLMessageErrorDetails2.HLMessageColumns = "Invalid File Format";
                    //    objHLMessageErrorDetails2.HLMessageError = strSegments + " Not Valid Segment";
                    //    objHLMessageErrorDetails2.FileNames = strFileName;
                    //    objHLMessageErrorDetails2.HLMessageTable = Segment;
                    //    intOrgAddressID = -1;
                    //    lstHLMessageErrorDetails.Add(objHLMessageErrorDetails2);
                    //    break;
                    //}
                }
                // Create a new element in the XML for the line
                XmlElement el = _xmlDoc.CreateElement(sFields[0]);
                _xmlDoc.DocumentElement.AppendChild(el);

                // For each field in the line of HL7
                for (int a = 0; a < sFields.Length; a++)
                {
                    // Create a new element
                    //XmlElement fieldEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString());

                    XmlElement fieldEl;

                    string cur_val = sFields[0] + "." + a.ToString(); //fieldEl.LocalName;                           

                    if (hl7_Props.hl7tags.ContainsKey(cur_val))
                    {
                        cur_val = hl7_Props.hl7tags[cur_val];
                    }


                    fieldEl = _xmlDoc.CreateElement(cur_val);


                    // Part of the HL7 specification is that part of the message header defines which characters are going to be used to delimit the message
                    // and since we want to capture the field that contains those characters we need to just capture them and stick them in an element.

                    if (sFields[a] != @"^~\&" && cur_val != "Encoding_Characters") // Here I don't want to split the MSH Encoding characters. So using this condition
                    {
                        // Get the components within this field, separated by carats (^). If there are more than one, go through and create an element
                        // for each, then check for subcomponents, and repetition in both.

                        string[] sComponents = GetComponents(sFields[a]);
                        if (sComponents.Length > 1)
                        {
                            for (int b = 0; b < sComponents.Length; b++)
                            {
                                //XmlElement componentEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString() + "." + b.ToString());

                                string cur_val1 = sFields[0] + "." + a.ToString() + "." + b.ToString(); // Form the components and sub components here

                                if (hl7_Props.hl7tags.ContainsKey(cur_val1)) // Check with our Dictionary
                                {
                                    cur_val1 = hl7_Props.hl7tags[cur_val1];
                                }
                                //string res2 = hl7_Props.CurrentValue;


                                XmlElement componentEl = _xmlDoc.CreateElement(cur_val1);  // Write into the XML 

                                string[] subComponents = GetSubComponents(sComponents[b]);
                                if (subComponents.Length > 1)
                                // There were subcomponents
                                {
                                    for (int c = 0; c < subComponents.Length; c++)
                                    {
                                        // Check for repetition
                                        string[] subComponentRepetitions = GetRepetitions(subComponents[c]);
                                        if (subComponentRepetitions.Length > 1)
                                        {
                                            for (int d = 0; d < subComponentRepetitions.Length; d++)
                                            {
                                                string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString() + "." + d.ToString(); // Form the components and sub components here

                                                if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                                {
                                                    cur_val2 = hl7_Props.hl7tags[cur_val2];
                                                }

                                                XmlElement subComponentRepEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                                subComponentRepEl.InnerText = subComponentRepetitions[d];
                                                componentEl.AppendChild(subComponentRepEl);
                                            }
                                        }
                                        else
                                        {
                                            string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString();  // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                            {
                                                cur_val2 = hl7_Props.hl7tags[cur_val2];
                                            }

                                            XmlElement subComponentEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                            subComponentEl.InnerText = subComponents[c];
                                            componentEl.AppendChild(subComponentEl);

                                        }
                                    }
                                    fieldEl.AppendChild(componentEl);
                                }
                                else // There were no subcomponents
                                {
                                    string[] sRepetitions = GetRepetitions(sComponents[b]);
                                    if (sRepetitions.Length > 1)
                                    {
                                        XmlElement repetitionEl = null;
                                        for (int c = 0; c < sRepetitions.Length; c++)
                                        {
                                            string cur_val3 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString(); // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val3)) // Check with our Dictionary
                                            {
                                                cur_val3 = hl7_Props.hl7tags[cur_val3];
                                            }
                                            repetitionEl = _xmlDoc.CreateElement(cur_val3); // Write into the XML 
                                            repetitionEl.InnerText = sRepetitions[c].Replace("_", " ");
                                            componentEl.AppendChild(repetitionEl);
                                        }
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                    else
                                    {
                                        componentEl.InnerText = sComponents[b];
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                }
                            }
                            el.AppendChild(fieldEl);
                        }
                        else
                        {
                            fieldEl.InnerText = sFields[a];
                            el.AppendChild(fieldEl);
                        }
                    }
                    else
                    {
                        fieldEl.InnerText = sFields[a];
                        el.AppendChild(fieldEl);
                    }
                }
            }
        }
        string result = Convert.ToString(_xmlDoc.OuterXml.ToString());
        return _xmlDoc.OuterXml;

        //Call the function with output

    }
    #endregion
    #region ConvertToXmlByService
    private string ConvertToXmlByService(string sHL7)
    {

        XmlDocument _xmlDoc;

        //Read the HL7Tags        

        hl7toxml hl7_Props = new hl7toxml();

        // Go and create the base XML
        _xmlDoc = CreateXmlDoc();

        // HL7 message segments are terminated by carriage returns, so to get an array of the message segments, split on carriage return
        string[] sHL7Lines = sHL7.Split('\n');
        //string[] sHL7Lines = sHL7.Split('\r');
        //string[] stringSeparators = new string[] { "<br/>" };
        //string[] sHL7Lines = sHL7.Split(stringSeparators, StringSplitOptions.None);

        // Now we want to replace any other unprintable control characters with whitespace otherwise they'll break the XML
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            sHL7Lines[i] = Regex.Replace(sHL7Lines[i], @"[^ -~]", "");
        }

        // Go through each segment in the message and first get the fields, separated by pipe (|), then for each of those, get the field components,
        // separated by carat (^), and check for repetition (~) and also check each component for subcomponents, and repetition within them too.
        for (int i = 0; i < sHL7Lines.Length; i++)
        {
            // Don't care about empty lines
            if (sHL7Lines[i] != string.Empty)
            {
                // Get the line and get the line's segments
                string sHL7Line = sHL7Lines[i];
                string[] sFields = GetMessgeFields(sHL7Line);

                // Create a new element in the XML for the line
                XmlElement el = _xmlDoc.CreateElement(sFields[0]);
                _xmlDoc.DocumentElement.AppendChild(el);

                // For each field in the line of HL7
                for (int a = 0; a < sFields.Length; a++)
                {
                    // Create a new element
                    //XmlElement fieldEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString());

                    XmlElement fieldEl;

                    string cur_val = sFields[0] + "." + a.ToString(); //fieldEl.LocalName;                           

                    if (hl7_Props.hl7tags.ContainsKey(cur_val))
                    {
                        cur_val = hl7_Props.hl7tags[cur_val];
                    }


                    fieldEl = _xmlDoc.CreateElement(cur_val);


                    // Part of the HL7 specification is that part of the message header defines which characters are going to be used to delimit the message
                    // and since we want to capture the field that contains those characters we need to just capture them and stick them in an element.

                    if (sFields[a] != @"^~\&" && cur_val != "Encoding_Characters") // Here I don't want to split the MSH Encoding characters. So using this condition
                    {
                        // Get the components within this field, separated by carats (^). If there are more than one, go through and create an element
                        // for each, then check for subcomponents, and repetition in both.

                        string[] sComponents = GetComponents(sFields[a]);
                        if (sComponents.Length > 1)
                        {
                            for (int b = 0; b < sComponents.Length; b++)
                            {
                                //XmlElement componentEl = _xmlDoc.CreateElement(sFields[0] + "." + a.ToString() + "." + b.ToString());

                                string cur_val1 = sFields[0] + "." + a.ToString() + "." + b.ToString(); // Form the components and sub components here

                                if (hl7_Props.hl7tags.ContainsKey(cur_val1)) // Check with our Dictionary
                                {
                                    cur_val1 = hl7_Props.hl7tags[cur_val1];
                                }
                                //string res2 = hl7_Props.CurrentValue;


                                XmlElement componentEl = _xmlDoc.CreateElement(cur_val1);  // Write into the XML 

                                string[] subComponents = GetSubComponents(sComponents[b]);
                                if (subComponents.Length > 1)
                                // There were subcomponents
                                {
                                    for (int c = 0; c < subComponents.Length; c++)
                                    {
                                        // Check for repetition
                                        string[] subComponentRepetitions = GetRepetitions(subComponents[c]);
                                        if (subComponentRepetitions.Length > 1)
                                        {
                                            for (int d = 0; d < subComponentRepetitions.Length; d++)
                                            {
                                                string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString() + "." + d.ToString(); // Form the components and sub components here

                                                if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                                {
                                                    cur_val2 = hl7_Props.hl7tags[cur_val2];
                                                }

                                                XmlElement subComponentRepEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                                subComponentRepEl.InnerText = subComponentRepetitions[d];
                                                componentEl.AppendChild(subComponentRepEl);
                                            }
                                        }
                                        else
                                        {
                                            string cur_val2 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString();  // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val2)) // Check with our Dictionary
                                            {
                                                cur_val2 = hl7_Props.hl7tags[cur_val2];
                                            }

                                            XmlElement subComponentEl = _xmlDoc.CreateElement(cur_val2); // Write into the XML 
                                            subComponentEl.InnerText = subComponents[c];
                                            componentEl.AppendChild(subComponentEl);

                                        }
                                    }
                                    fieldEl.AppendChild(componentEl);
                                }
                                else // There were no subcomponents
                                {
                                    string[] sRepetitions = GetRepetitions(sComponents[b]);
                                    if (sRepetitions.Length > 1)
                                    {
                                        XmlElement repetitionEl = null;
                                        for (int c = 0; c < sRepetitions.Length; c++)
                                        {
                                            string cur_val3 = sFields[0] + "." + a.ToString() + "." + b.ToString() + "." + c.ToString(); // Form the components and sub components here

                                            if (hl7_Props.hl7tags.ContainsKey(cur_val3)) // Check with our Dictionary
                                            {
                                                cur_val3 = hl7_Props.hl7tags[cur_val3];
                                            }
                                            repetitionEl = _xmlDoc.CreateElement(cur_val3); // Write into the XML 
                                            repetitionEl.InnerText = sRepetitions[c].Replace("_", " ");
                                            componentEl.AppendChild(repetitionEl);
                                        }
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                    else
                                    {
                                        componentEl.InnerText = sComponents[b];
                                        fieldEl.AppendChild(componentEl);
                                        el.AppendChild(fieldEl);
                                    }
                                }
                            }
                            el.AppendChild(fieldEl);
                        }
                        else
                        {
                            fieldEl.InnerText = sFields[a];
                            el.AppendChild(fieldEl);
                        }
                    }
                    else
                    {
                        fieldEl.InnerText = sFields[a];
                        el.AppendChild(fieldEl);
                    }
                }
            }
        }
        string result = Convert.ToString(_xmlDoc.OuterXml.ToString());
        return _xmlDoc.OuterXml;

        //Call the function with output

    }
    #endregion
    #region GetMessgeFields
    private static string[] GetMessgeFields(string s)
    {
        return s.Split('|');
    }
    #endregion

    #region GetComponents
    // Get the components of a string by splitting based on carat.
    private static string[] GetComponents(string s)
    {
        return s.Split('^');
    }
    #endregion

    #region GetSubComponents
    // Get the subcomponents of a string by splitting on ampersand.          
    private static string[] GetSubComponents(string s)
    {
        return s.Split('&');
    }
    #endregion

    #region GetRepetitions
    // Get the repetitions within a string based on tilde.            
    private static string[] GetRepetitions(string s)
    {
        return s.Split('~');
    }
    #endregion

    #region XmlDocument
    // Create the basic XML document that represents the HL7 message           
    private static XmlDocument CreateXmlDoc()
    {
        XmlDocument output = new XmlDocument();
        XmlElement rootNode = output.CreateElement("Records");

        output.AppendChild(rootNode);
        XmlElement rootNode1 = output.CreateElement("Record");
        output.DocumentElement.AppendChild(rootNode1);
        return output;
    }
    #endregion
    #endregion

    #region GetInBoundListForHLMessages
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetInBoundListForHLMessages(int OrgID, string Status, out List<HLMessages> lstHl7InBoundMessageDetails, out List<HLMessagePatientIDDetails> lstPatient, out List<HLMessageOBRDetails> lstHLMessageOBRDetails)
    {
        long result = -1;
        string strParseError = "";
        string strParseError1 = "";
        lstHl7InBoundMessageDetails = null;
        lstPatient = null;
        lstHLMessageOBRDetails = null;
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.GetInBoundListForLIMS(OrgID, Status, out lstHl7InBoundMessageDetails, out lstPatient, out lstHLMessageOBRDetails);
            if (lstHl7InBoundMessageDetails != null && lstHl7InBoundMessageDetails.Count() > 0)
            {
                strParseError1 = "Data Came from HL Message Tables" + Environment.NewLine;
                strParseError = SetInBoundDetails(lstHl7InBoundMessageDetails, lstPatient, lstHLMessageOBRDetails);
                if (strParseError != "")
                {
                    strParseError1 += strParseError + Environment.NewLine;
                }
            }
            else
            {
                strParseError1 += "Data Came from HL Message Tables Is null or no count" + Environment.NewLine;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInBoundListForLIMS:", ex);
            strParseError1 += "Error in GetInBoundListForLIMS:" + ex.InnerException.ToString() + Environment.NewLine;
        }
        return strParseError1;
    }
    #endregion
    #region CheckHL7InBoundService
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<HLMessages> CheckHL7InBoundService(int Interval, string ServiceType, DateTime ProcessingTime)
    {
        CLogger.LogInfo("Service from Inbound");
        long result = -1;
        string IsActive = "N";
        List<HLMessages> ActiveHL7Messages = new List<HLMessages>();
        HLMessages LstMessages = new HLMessages();
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.CheckHL7InboundService(Interval, ServiceType, ProcessingTime, out IsActive);
            LstMessages.Status = IsActive;
            ActiveHL7Messages.Add(LstMessages);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in CheckHL7InBoundService:", ex);
        }
        return ActiveHL7Messages;

    }
    #endregion
    #region UpdateInBoundMessageDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void UpdateInBoundMessageDetails(List<HLMessages> lstHl7InBoundMessageDetails)
    {
        List<HLMessages> lstHl7InBoundMessageDetails1 = new List<HLMessages>();
        lstHl7InBoundMessageDetails1 = lstHl7InBoundMessageDetails;
        System.Data.DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("Id");
        DataColumn dbCol2 = new DataColumn("MsgControlId");
        DataColumn dbCol3 = new DataColumn("ErrorList");
        DataColumn dbCol4 = new DataColumn("StatusOfInbound");

        //add columns
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        DataRow dr;
        for (int i = 0; i < lstHl7InBoundMessageDetails1.Count; i++)
        {

            dr = dt.NewRow();
            dr["Id"] = Convert.ToInt64(lstHl7InBoundMessageDetails1[i].HLMessagesID);
            dr["MsgControlId"] = lstHl7InBoundMessageDetails1[i].MsgControlId.ToString();
            dr["ErrorList"] = lstHl7InBoundMessageDetails1[i].ErrorList.ToString();
            dr["StatusOfInbound"] = lstHl7InBoundMessageDetails1[i].StatusOfInbound.ToString();
            dt.Rows.Add(dr);

        }

        Investigation_BL obj_bl = new Investigation_BL();
        //List<Hl7OutBoundMessageDetails> lstHl7OutBoundMessageDetails = new List<Hl7OutBoundMessageDetails>();
        obj_bl.UpdateInBoundMsgDetails(lstHl7InBoundMessageDetails1[0].OrgId, dt);
    }
    #endregion
    #region GetConfigValue
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        ContextDetails objcontext = new ContextDetails();
        objcontext = SetContextDetailsInBound(orgID, "en-GB", OrgAddressID, RoleId, LoginId);
        GateWay objGateway = new GateWay(objcontext);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    #endregion

    #region loadCollectSampleList
    public void loadCollectSampleList(int OrgID, long RoleID, int ILocationID, long VisitID, string gUID, long Dvisitid)
    {
        try
        {
            returncode = new AdminReports_BL(objcontext).GetUserNames("HLMessages", OrgID, "Users", "A", out lstOrgUsers);
            if (lstOrgUsers.Count > 0)
            {
                LoginId = lstOrgUsers[0].LoginID;
            }
            //gUID = Guid.NewGuid().ToString();
            objcontext = SetContextDetailsInBound(OrgID, "en-GB", ILocationID, RoleId, LoginId);
            long returnCode = -1;
            string strCollectAgain = string.Empty;
            string strInvColNSList = string.Empty;
            string strInvRejected = string.Empty;
            string strSampleRelationshipID = string.Empty;
            string strCmoreSample = string.Empty;
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
            InvDeptSamples eInvDeptSamples = new InvDeptSamples();
            Patient_BL patientBL = new Patient_BL(objcontext);
            List<PatientVisit> visitList = new List<PatientVisit>();
            List<InvDeptSamples> lstDeptSamples = new List<InvDeptSamples>();
            returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, gUID, out visitList);


            int taskactionID = (int)TaskHelper.TaskAction.CollectSample;

            Investigation_BL invbl = new Investigation_BL(objcontext);
            invbl.GetInvestigationSamplesCollect(VisitID, OrgID, RoleID, gUID, ILocationID, taskactionID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);


            List<PatientInvestigation> PaidItems = new List<PatientInvestigation>();
            //Load list  of samples in OrderSample list user control
            if (lstPatientInvestigation.Count() > 0)
            {

                //Change Sample name into dropdown List
                List<PatientInvestigation> lstInvColNSList = new List<PatientInvestigation>();
                List<PatientInvestigation> lstNotCollectedInvestigation = new List<PatientInvestigation>();
                if (strCollectAgain == "Y")
                {
                    long result;
                    result = invbl.GetInvestigationForSampleID(VisitID, OrgID, Convert.ToInt32(strSampleRelationshipID), out lstInvColNSList);

                    foreach (PatientInvestigation i in lstInvColNSList)
                    {
                        if (strInvColNSList == "")
                        {
                            strInvColNSList = i.InvestigationID.ToString() + "~" + i.SampleID.ToString();
                        }
                        else
                        {
                            strInvColNSList = strInvColNSList + "," + i.InvestigationID.ToString() + "~" + i.SampleID.ToString();
                        }
                    }
                    lstNotCollectedInvestigation = lstInvColNSList;
                }
                else if (strCmoreSample == "Y")
                {
                    lstNotCollectedInvestigation = lstPatientInvestigation;
                }
                else
                {
                    List<PatientInvestigation> lstInvRejected = new List<PatientInvestigation>();
                    long result;
                    result = invbl.GetInvRejected(VisitID, OrgID, out lstInvRejected);

                    foreach (PatientInvestigation i in lstInvRejected)
                    {
                        if (strInvRejected == "")
                        {
                            strInvRejected = i.InvestigationID.ToString();
                        }
                        else
                        {
                            strInvRejected = strInvRejected + "," + i.InvestigationID.ToString();
                        }
                    }
                    if (strInvRejected.Length > 0)
                    {
                        foreach (string strInv in strInvRejected.Split(','))
                        {
                            lstPatientInvestigation.RemoveAll(P => P.InvestigationID == Convert.ToInt64(strInv));
                        }
                    }

                    PaidItems = lstPatientInvestigation.FindAll(P => P.Status == "Paid" || P.Status == "SampleNotGiven" || P.Status == "SampleRejected" || P.Status == "Ordered");
                    lstNotCollectedInvestigation = PaidItems;
                }
                //List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
                //List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
                //List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                //List<LabRefOrgAddress> lstOutsource = new List<LabRefOrgAddress>();
                // returnCode = invbl.GetCollectSampleDropDownValues(OrgID, PageType.CollectSample, out lstInvSampleStatus, out lstInvReasonMaster, out lstLocation, out lstOutsource);
                // ctlCollectSample.SetValues(lstInvSampleMaster, lstSampleContainer, lstInvSampleStatus, lstInvReasonMaster, lstLocation, lstOutsource, lstNotCollectedInvestigation);


                List<PatientInvestigation> lstSampleDept = new List<PatientInvestigation>();
                List<PatientInvSample> lstPatInvSample = new List<PatientInvSample>();
                invbl.GetDeptToTrackSamples(VisitID, OrgID, RoleID, gUID, out lstSampleDept, out lstPatInvSample);
                if (strCollectAgain == "Y")
                {
                    foreach (string strInv in strInvColNSList.Split(','))
                    {
                        int intPosition = -1;
                        int intSampleCode = 0;
                        string strInvestigationID = "";
                        if (strInv.IndexOf("~") != -1)
                        {
                            intPosition = strInv.IndexOf("~");
                            strInvestigationID = strInv.Substring(0, intPosition);
                            intSampleCode = Convert.ToInt32(strInv.Substring(intPosition + 1));
                            lstPatInvSample.RemoveAll(P => (P.InvestigationID != strInvestigationID && P.SampleCode != intSampleCode));
                        }
                    }
                }
                else
                {
                    foreach (string strInv in strInvRejected.Split(','))
                    {
                        lstPatInvSample.RemoveAll(P => P.InvestigationID == strInv);
                    }
                }

                foreach (PatientInvestigation listInv in lstSampleDept)
                {
                    eInvDeptSamples = new InvDeptSamples();
                    eInvDeptSamples.PatientVisitID = VisitID;
                    eInvDeptSamples.DeptID = Convert.ToInt32(listInv.DeptID);
                    eInvDeptSamples.OrgID = OrgID;
                    lstDeptSamples.Add(eInvDeptSamples);
                }

                if (lstPatInvSample.Count > 0)
                {
                    LoadCollectSampleList(lstPatInvSample, lstSampleDept, lstDeptSamples, -1, OrgID, ILocationID, gUID, Dvisitid);
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while load data investigation sample", ex);
        }

    }
    #endregion

    #region LoadCollectSampleList
    public void LoadCollectSampleList(List<PatientInvSample> lstPatInvSample, List<PatientInvestigation> lstPatientinvestigation, List<InvDeptSamples> lstDeptSamples, long DoFromVisitID, int OrgID, int ILocationID, string gUID, long Dvisitid)
    {
        try
        {

            List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
            List<PatientInvSample> objPatientInvSample = new List<PatientInvSample>();
            //  List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();            
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<InvestigationValues> linvValues = new List<InvestigationValues>();
            List<PatientInvSampleMapping> lSampleMapping = new List<PatientInvSampleMapping>();

            SampleTracker elstSampleTracker = new SampleTracker();
            PatientInvSample elstPatientInvSample = new PatientInvSample();
            // PatientInvSample objPatientInvSamplesecondary = new PatientInvSample();
            PatientInvestigation elstPatientInvestigation = new PatientInvestigation();
            InvestigationValues elinvValues = new InvestigationValues();
            PatientInvSampleMapping elSampleMapping = new PatientInvSampleMapping();

            List<PatientInvSampleMapping> groupByResult = new List<PatientInvSampleMapping>();
            List<string> lstCollectedSampleStatus = new List<string>();


            long returnCode = -1;
            string SampleContainerCount = string.Empty;
            List<PatientInvSample> lsttempPatInvSample = new List<PatientInvSample>();
            List<PatientInvSample> lsttempPatInvSample1 = new List<PatientInvSample>();
            LabUtil objLabUtil = new LabUtil();
            GateWay gateWay = new GateWay(objcontext);
            List<Config> lstConfig = new List<Config>();
            //config key value(GroupBarcodeDeptSharing) is Y then new method will run else

            returnCode = gateWay.GetConfigDetails("GroupBarcodeDeptSharing", OrgID, out lstConfig);
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                lsttempPatInvSample = objLabUtil.GroupCollectSampleDetailsDeptSharing(lstPatInvSample);

            else
                lsttempPatInvSample = objLabUtil.GroupCollectSampleDetails(lstPatInvSample);

            barcodesuffix = GetConfigValue("Add_Suffix_Barcode", OrgID);
            barcodeempty = GetConfigValue("IsEmptyBarcode", OrgID);
            LabNoBasedBarcode = GetConfigValue("LabNoBasedBarcode", OrgID);

            returnCode = gateWay.GetConfigDetails("NeedAutoAlicoteforOutSource", OrgID, out lstConfig);
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
            {
                lsttempPatInvSample1 = objLabUtil.GetAutoAlicotedSampleForOutSourcing(lsttempPatInvSample);
            }
            else
            {
                lsttempPatInvSample1 = lsttempPatInvSample;
            }
            //hdnLabNoBarcode.Value = lsttempPatInvSample1[0].BarcodeNumber.Remove(9, 2);
            returnCode = gateWay.GetConfigDetails("PrintSampleBarcode", OrgID, out lstConfig);
            long RefID = -1; string RefType = "";
            long PatientVisitID = -1;
            if (Dvisitid != -1 || Dvisitid != 0)
            {
                PatientVisitID = Dvisitid;
            }
            else
            {
                PatientVisitID = -1;
            }

            int SampleCode = -1;
            int sampleContainerID = -1;

            string UID = string.Empty;
            if (lsttempPatInvSample1.Count > 0)
            {
                string BarcodeNo = "0";
                string MLNumber = "0";

                Investigation_BL InvestigationBL = new Investigation_BL(objcontext);
                foreach (PatientInvSample Pinv in lsttempPatInvSample1)
                {

                    if (Pinv.IsMLNumber != "Y")
                    {
                        if (PatientVisitID == -1 || PatientVisitID == 0)
                        {

                            RefID = lsttempPatInvSample[0].PatientVisitID;
                            string barcodeSufix = string.IsNullOrEmpty(Pinv.Suffix) == false ? Pinv.Suffix : "";
                            if (LabNoBasedBarcode == "Y")
                            {
                                Pinv.BarcodeNumber = Pinv.BarcodeNumber;
                            }

                            else if (barcodeempty == "Y")
                            {
                                Pinv.BarcodeNumber = string.Empty;
                            }

                            else if (barcodesuffix == "Y")
                            {
                                returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                                Pinv.BarcodeNumber = barcodeSufix + BarcodeNo;
                            }
                            else
                            {
                                returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                                Pinv.BarcodeNumber = BarcodeNo + barcodeSufix;
                            }




                            //Pinv.BarcodeNumber = BarcodeNo;
                        }
                        else if (Dvisitid != -1 || Dvisitid != 0)
                        {
                            string type = string.Empty;
                            type = "DoFrmVisitNumber";
                            SampleCode = Pinv.SampleCode;
                            long OrganizationID = Convert.ToInt64(OrgID);
                            sampleContainerID = Pinv.SampleContainerID;
                            returnCode = InvestigationBL.GetBarcodeNumForDoFromVisit(OrganizationID, Dvisitid, out BarcodeNo, SampleCode, UID, type, sampleContainerID);
                            if (BarcodeNo == "")
                            {
                                returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                                Pinv.BarcodeNumber = BarcodeNo;

                            }
                            else
                            {
                                Pinv.BarcodeNumber = BarcodeNo;
                            }
                        }
                        else
                        {
                            returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                            Pinv.BarcodeNumber = BarcodeNo;

                        }
                    }

                    else
                    {
                        string[] InvID = Pinv.InvestigationID.Split('~');
                        if (InvID.Count() > 0)
                        {
                            Int64.TryParse(InvID[0], out RefID);
                            RefType = InvID[1];
                        }
                        returnCode = InvestigationBL.GetNextMLNumber(OrgID, ILocationID, "MLNO", out MLNumber, RefID, RefType);
                        string barcodeSufix = string.IsNullOrEmpty(Pinv.Suffix) == false ? Pinv.Suffix : "";
                        Pinv.BarcodeNumber = MLNumber + barcodeSufix;
                    }



                    //xw.WriteStartElement(ReferenceRange[0]);
                    //PatientInvSample

                    elstPatientInvSample = new PatientInvSample();
                    elstPatientInvSample.PatientVisitID = Pinv.PatientVisitID;
                    elstPatientInvSample.OrgID = OrgID;
                    elstPatientInvSample.CreatedBy = LoginId;
                    elstPatientInvSample.UID = gUID;
                    elstPatientInvSample.CollectedLocID = ILocationID;
                    elstPatientInvSample.SampleRelationshipID = 0;
                    elstPatientInvSample.SampleCode = Pinv.SampleCode;
                    elstPatientInvSample.SampleContainerID = Pinv.SampleContainerID;
                    elstPatientInvSample.InvSampleStatusDesc = "Collected";
                    elstPatientInvSample.BarcodeNumber = Pinv.BarcodeNumber;
                    elstPatientInvSample.RecSampleLocID = Pinv.RecSampleLocID;
                    //elstPatientInvSample.CollectedDateTime = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm"));
                    elstPatientInvSample.CollectedDateTime = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));// Pinv.CreatedAt == DateTime.MaxValue ? DateTime.Now : Pinv.CreatedAt;
                    //elstPatientInvSample.CreatedAt = Pinv.CreatedAt == DateTime.MaxValue ? DateTime.Now : Pinv.CreatedAt;
                    elstPatientInvSample.CreatedAt = Pinv.CreatedAt == DateTime.MaxValue ? Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt")) : Convert.ToDateTime(Pinv.CreatedAt.ToString("dd/MM/yyyy hh:mm:ss tt"));
                    elstPatientInvSample.SampleDesc = Pinv.SampleDesc;
                    elstPatientInvSample.VmValue = 0;
                    elstPatientInvSample.VmUnitID = 0;
                    elstPatientInvSample.SampleRelationshipID = 0;
                    elstPatientInvSample.InvSampleStatusID = Pinv.IsOutsourcingSample == "Y" ? 12 : 1;
                    elstPatientInvSample.IsSecondaryBarCode = Pinv.IsSecondaryBarCode;
                    elstPatientInvSample.IsSecBarCode = Pinv.IsSecondaryBarCode == "Y" ? true : false;
                    elstPatientInvSample.ID1 = Pinv.ID1;////For MO Changes
                    objPatientInvSample.Add(elstPatientInvSample);


                    foreach (PatientInvestigation Pinvn in lstPatientinvestigation)
                    {


                        //PatientVisitID = -1;
                        Array Groups = Pinv.InvestigationID.Split('|');
                        for (int j = 0; j <= Groups.Length - 1; j++)
                        {
                            Array Tests = Groups.GetValue(j).ToString().Split('~');
                            //        elstPatientInvSample = new PatientInvSample();
                            //        elstPatientInvSample.PatientVisitID = Pinv.PatientVisitID;
                            //        elstPatientInvSample.OrgID = OrgID;
                            //        elstPatientInvSample.CreatedBy = LoginId;
                            //        elstPatientInvSample.UID = gUID;
                            //        elstPatientInvSample.CollectedLocID = ILocationID;
                            //        elstPatientInvSample.SampleRelationshipID = 0;
                            //        elstPatientInvSample.SampleCode = Pinv.SampleCode;
                            //        elstPatientInvSample.SampleContainerID = Pinv.SampleContainerID;
                            //        elstPatientInvSample.InvSampleStatusDesc = "Collected";
                            //        elstPatientInvSample.BarcodeNumber = Pinv.BarcodeNumber;
                            //        elstPatientInvSample.RecSampleLocID = Pinv.RecSampleLocID;
                            //        elstPatientInvSample.CollectedDateTime = Pinvn.CreatedAt == DateTime.MaxValue ? DateTime.Now : Pinvn.CreatedAt;
                            //        elstPatientInvSample.CreatedAt = Pinvn.CreatedAt == DateTime.MaxValue ? DateTime.Now : Pinvn.CreatedAt;
                            //        elstPatientInvSample.SampleDesc = Pinv.SampleDesc;
                            //        elstPatientInvSample.VmValue = 0;
                            //        elstPatientInvSample.VmUnitID = 0;
                            //        elstPatientInvSample.SampleRelationshipID = 0;
                            //        elstPatientInvSample.InvSampleStatusID = 1;
                            //elstPatientInvSample.IsSecBarCode = Pinv.IsSecondaryBarCode == "Y" ? true : false;
                            //        objPatientInvSample.Add(elstPatientInvSample);
                            //    }

                            //Sampletracker
                            if (!lstSampleTracker.Any(x => x.DeptID == Pinvn.DeptID))
                            {
                                elstSampleTracker = new SampleTracker();
                                elstSampleTracker.PatientVisitID = Pinv.PatientVisitID;
                                elstSampleTracker.DeptID = Pinvn.DeptID;
                                elstSampleTracker.InvSampleStatusID = Pinv.IsOutsourcingSample == "Y" ? 12 : 1;
                                lstSampleTracker.Add(elstSampleTracker);
                            }

                            //Patient Inv Sample Mapping

                            if (Convert.ToString(Tests.GetValue(1)) == "INV")
                            {
                                if (!lSampleMapping.Any(x => x.ID == Convert.ToInt64(Tests.GetValue(0)) && x.Type == Convert.ToString(Tests.GetValue(1)) && x.SampleID == Pinv.SampleCode))
                                {
                                    elSampleMapping = new PatientInvSampleMapping();
                                    elSampleMapping.ID = Convert.ToInt64(Tests.GetValue(0));
                                    elSampleMapping.SampleID = Pinv.SampleCode;
                                    elSampleMapping.Type = Convert.ToString(Tests.GetValue(1));
                                    elSampleMapping.Barcode = Pinv.BarcodeNumber;
                                    elSampleMapping.VisitID = Pinv.PatientVisitID;
                                    elSampleMapping.OrgID = OrgID;
                                    elSampleMapping.UID = gUID;
                                    lSampleMapping.Add(elSampleMapping);
                                }
                            }
                            else
                            {
                                if (!lSampleMapping.Any(x => x.ID == Convert.ToInt64(Tests.GetValue(0)) && x.Type == Convert.ToString(Tests.GetValue(1)) && x.Barcode == Pinv.BarcodeNumber))
                                {
                                    elSampleMapping = new PatientInvSampleMapping();
                                    elSampleMapping.ID = Convert.ToInt64(Tests.GetValue(0));
                                    elSampleMapping.SampleID = Pinv.SampleCode;
                                    elSampleMapping.Type = Convert.ToString(Tests.GetValue(1));
                                    elSampleMapping.Barcode = Pinv.BarcodeNumber;
                                    elSampleMapping.VisitID = Pinv.PatientVisitID;
                                    elSampleMapping.OrgID = OrgID;
                                    elSampleMapping.UID = gUID;
                                    lSampleMapping.Add(elSampleMapping);
                                }


                            }
                            //Investigationvalues
                            if (Convert.ToString(Tests.GetValue(1)) == "INV")
                            {
                                if (!linvValues.Any(x => x.InvestigationID == Convert.ToInt64(Tests.GetValue(0)) && x.Status == Convert.ToString(Tests.GetValue(1))))
                                {
                                    elinvValues = new InvestigationValues();
                                    elinvValues.InvestigationID = Convert.ToInt64(Tests.GetValue(0));
                                    elinvValues.Orgid = OrgID;
                                    elinvValues.Value = "Collected";
                                    elinvValues.Status = Convert.ToString(Tests.GetValue(1));
                                    elinvValues.ReferralID = Pinv.IsOutsourcingSample == "Y" ? Pinv.RecSampleLocID : -1;
                                    elinvValues.UOMID = Convert.ToInt32(Pinv.ID1);////For MO Changes
                                    linvValues.Add(elinvValues);
                                }
                            }
                            else
                            {
                                if (!linvValues.Any(x => x.InvestigationID == Convert.ToInt64(Tests.GetValue(0)) && x.Status == Convert.ToString(Tests.GetValue(1))))
                                {
                                    elinvValues = new InvestigationValues();
                                    elinvValues.InvestigationID = Convert.ToInt64(Tests.GetValue(0));
                                    elinvValues.Orgid = OrgID;
                                    elinvValues.Value = "Collected";
                                    elinvValues.Status = Convert.ToString(Tests.GetValue(1));

                                    elinvValues.ReferralID = Pinv.IsOutsourcingSample == "Y" ? Pinv.RecSampleLocID : -1;
                                    elinvValues.UOMID = Convert.ToInt32(Pinv.ID1);////For MO Changes
                                    linvValues.Add(elinvValues);
                                }

                            }

                            //PatientInvestigation
                            if (Convert.ToString(Tests.GetValue(1)) == "INV")
                            {
                                if (!lstPatientInvestigation.Any(x => x.InvestigationID == Convert.ToInt64(Tests.GetValue(0))))
                                {
                                    elstPatientInvestigation = new PatientInvestigation();
                                    elstPatientInvestigation.InvestigationID = Convert.ToInt64(Tests.GetValue(0));
                                    //elstPatientInvestigation.GroupID = Convert.ToInt32(Pinv.InvestigationID);
                                    elstPatientInvestigation.AccessionNumber = Pinvn.AccessionNumber;
                                    elstPatientInvestigation.UID = gUID;
                                    elstPatientInvestigation.Status = "Collected";
                                    elstPatientInvestigation.Type = Convert.ToString(Tests.GetValue(1));
                                    lstPatientInvestigation.Add(elstPatientInvestigation);
                                }
                            }



                        }


                    }

                }

                //foreach (PatientInvSample Pinv in objPatientInvSample)
                //{
                //    lsttempPatInvSample1= lsttempPatInvSample1.Where(p => p.IsSecondaryBarCode == "Y").ToList();

                //    objPatientInvSamplesecondary = new PatientInvSample();
                //    if (lsttempPatInvSample1.Any(x => x.SampleCode == Pinv.SampleCode))
                //    {
                //        objPatientInvSamplesecondary.IsSecBarCode = true;
                //    }
                //    else
                //    {
                //        objPatientInvSamplesecondary.IsSecBarCode = false;

                //    }
                //    objPatientInvSamplesecondary.PatientVisitID = Pinv.PatientVisitID;
                //    objPatientInvSamplesecondary.OrgID = Pinv.OrgID;
                //    objPatientInvSamplesecondary.CreatedBy = Pinv.CreatedBy;
                //    objPatientInvSamplesecondary.UID = Pinv.UID;
                //    objPatientInvSamplesecondary.CollectedLocID = Pinv.CollectedLocID;
                //    objPatientInvSamplesecondary.SampleRelationshipID = Pinv.SampleRelationshipID;
                //    objPatientInvSamplesecondary.SampleCode = Pinv.SampleCode;
                //    objPatientInvSamplesecondary.SampleContainerID = Pinv.SampleContainerID;
                //    objPatientInvSamplesecondary.InvSampleStatusDesc = Pinv.InvSampleStatusDesc;
                //    objPatientInvSamplesecondary.BarcodeNumber = Pinv.BarcodeNumber;
                //    objPatientInvSamplesecondary.RecSampleLocID = Pinv.RecSampleLocID;
                //    objPatientInvSamplesecondary.CollectedDateTime = Pinv.CollectedDateTime;
                //    objPatientInvSamplesecondary.CreatedAt = Pinv.CollectedDateTime;
                //    objPatientInvSamplesecondary.SampleDesc = Pinv.SampleDesc;
                //    objPatientInvSamplesecondary.VmValue = Pinv.VmValue;
                //    objPatientInvSamplesecondary.VmUnitID = Pinv.VmUnitID;
                //    objPatientInvSamplesecondary.SampleRelationshipID = Pinv.SampleRelationshipID;
                //    objPatientInvSamplesecondary.InvSampleStatusID = Pinv.InvSampleStatusID;
                //    objPatientInvSamplesecondary.TestID = Pinv.TestID;
                //elstPatientInvSample.IsSecBarCode = Pinv.IsSecondaryBarCode == "Y" ? true : false;
                //    lstPatientInvSample.Add(objPatientInvSamplesecondary);




            }

            string lstSampleId = string.Empty;



            groupByResult = (from lst in lSampleMapping
                             group lst by
                             new
                             {
                                 lst.ID,
                                 lst.SampleID,
                                 lst.Type,
                                 lst.Barcode,
                                 lst.VisitID,
                                 lst.OrgID,
                                 lst.UID
                             } into grp

                             select new PatientInvSampleMapping
                             {
                                 ID = grp.Key.ID,
                                 SampleID = grp.Key.SampleID,
                                 Type = grp.Key.Type
                                 ,
                                 Barcode = grp.Key.Barcode,
                                 VisitID = grp.Key.VisitID,
                                 OrgID = grp.Key.OrgID,
                                 UID = grp.Key.UID
                             }).Distinct().ToList();

            LabUtil objLabUtil1 = new LabUtil();


            // pnlChildSamples.Attributes.Add("style", "display:block;"); 
            if (lsttempPatInvSample1 != null && lsttempPatInvSample1.Count > 0)
            {
                List<InvestigationSampleContainer> lstContainerCount = (from ord in lsttempPatInvSample1
                                                                        where !String.IsNullOrEmpty(ord.SampleContainerName)
                                                                        group ord by ord.SampleContainerID into g
                                                                        select new InvestigationSampleContainer
                                                                        {
                                                                            SampleContainerID = g.Key,
                                                                            ContainerName = g.Select(n => n.SampleContainerName).First(),
                                                                            ContainerCount = g.Count()
                                                                        }).ToList();
                if (lstContainerCount != null && lstContainerCount.Count > 0)
                {
                    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                    SampleContainerCount = oJavaScriptSerializer.Serialize(lstContainerCount);
                }

                SaveCollectSampleDetails(OrgID, ILocationID, gUID, PatientVisitID, lstSampleTracker, lstDeptSamples, objPatientInvSample, groupByResult, lstPatientinvestigation, linvValues);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting LoadCollectSampleList in HL7IntegrationService", ex);
            throw ex;
        }
    }
    #endregion

    #region SaveCollectSampleDetails
    public void SaveCollectSampleDetails(int OrgID, int ILocationID, string gUID, long PatientVisitID, List<SampleTracker> lstTracker, List<InvDeptSamples> lstDeptSamples, List<PatientInvSample> lstPatientInvSample, List<PatientInvSampleMapping> groupByResult, List<PatientInvestigation> LstPatientInvestigation, List<InvestigationValues> lstInvValues)
    {
        try
        {
            objcontext = SetContextDetailsInBound(OrgID, "en-GB", ILocationID, RoleId, LoginId);
            long ReturnCode = -1;
            string lstSampleId = string.Empty;
            int status = -1;
            Investigation_BL invBL = new Investigation_BL(objcontext);
            ReturnCode = invBL.SavePatientInvSample(lstPatientInvSample, lstTracker, lstDeptSamples, groupByResult,
                        LstPatientInvestigation, lstInvValues, gUID, out status, out lstSampleId);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting SaveCollectSampleDetails in HL7IntegrationService", ex);
        }

    }
    #endregion
    #region GetOtherLocationFiledet
    [WebMethod(EnableSession = true)]
    public string GetOtherLocationFiledet(out List<string> lstFileDetails)
    {
        string PageErrorCode = string.Empty;
        lstFileDetails = new List<string>();
        HLMessageOBRDetails objHLMessageOBRDetails = new HLMessageOBRDetails();
        List<HLMessageOBRDetails> lstHLMessageOBRDetails = new List<HLMessageOBRDetails>();
        try
        {
            long returnCode = new Patient_BL().GetOtherLocationFiledet(out lstHLMessageOBRDetails);
            if (lstHLMessageOBRDetails.Count > 0)
            {
                int i = 0;
                foreach (var objlstHLMessageOBRDetails in lstHLMessageOBRDetails)
                {
                    lstFileDetails.Add(objlstHLMessageOBRDetails.HLMessageOBRContent);
                    i++;
                }

            }
        }
        catch (Exception ex)
        {
            PageErrorCode += System.Environment.NewLine + "Error in GetOtherLocationFiledet : " + ex.Message.ToString();
        }
        return PageErrorCode;

    }
    #endregion
    #region UpdateOtherLocationFileDetails
    [WebMethod(EnableSession = true)]
    public string UpdateOtherLocationFileDetails(List<HLMessages> lstHLMessage, List<HLMessageErrorDetails> lstHLErrorDetails, out string strStatus)
    {
        strStatus = "Success";
        List<HLMessages> lstHLMessages = new List<HLMessages>();
        lstHLMessages = lstHLMessage;
        try
        {
            if (lstHLMessage.Count > 0)
            {
                objcontext = SetContextDetailsInBound(orgID, "en-GB", intOrgAddressID, RoleId, LoginId);
                returncode = new Patient_BL(objcontext).UpdateOtherLocationFileDetails(lstHLMessages, lstHLErrorDetails);
                if (returncode == -1)
                    strStatus = "Not Updated";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting UpdateOtherLocationFileDetails in HL7IntegrationService", ex);
        }
        return strStatus;
    }
    #endregion
}

