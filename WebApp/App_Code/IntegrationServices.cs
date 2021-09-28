using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml.Linq;
using System.Web.SessionState;
using System.Xml.Serialization;
using Attune.Podium.Common;
using Attune.Cryptography;
using NCalc;
using System.Xml;
using System.Collections;
using System.Text.RegularExpressions;
using Attune.Podium.ClientEntity;
using System.Globalization;
using System.Data;
using Attune.Podium.PerformingNextAction;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Text;
using System.Web.Script.Serialization;


//using System.Runtime.Serialization.Formatters.Soap;
//using System.Xml.Serialization;
//using System.Runtime.Serialization.Formatters.Soap;

/// <summary>
/// Summary description for IntegrationServices
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class IntegrationServices : System.Web.Services.WebService
{
    string IsExcludeAutoApproval;
    string Agedays = "0";
    int OrgId;
    List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();
    List<BarcodeIntegrationResults> lstbarcoode = new List<BarcodeIntegrationResults>();


    [WebMethod]
    public void InsertInvestigationResult(long AccessionNumber, string InvestigationResult)
    {
        new Investigation_BL().SaveInvestiagtionResult(AccessionNumber, InvestigationResult);
    }

    #region GetModalityWorkList

    [WebMethod]
    public void GetModalityWorkList(string ModalityName, DateTime FromDate, DateTime ToDate, int OrgID, out List<ModalityWorkList> modalityWorkList, out List<ModalityWorkList> CompletionList)
    {
        modalityWorkList = new List<ModalityWorkList>();
        CompletionList = new List<ModalityWorkList>();
        new Investigation_BL().GetModalityWorkList(ModalityName, FromDate, ToDate, OrgID, out modalityWorkList, out CompletionList);
    }

    #endregion
    [WebMethod]
    public void SetMPPSStatus(string studyInstanceID, long accessionNumber, int status)
    {
        long returnCode = -1;
        returnCode = new Investigation_BL().UpdateMMPSStatus(accessionNumber, studyInstanceID, status);
    }
    [WebMethod(EnableSession = true)]
    public long OrderInvestigationsForBarcode(PatientDetails pDetails, PatientAddress pAddress, VisitDetails pVisit,
     List<InvestigationDetail> lInvestigationList, List<ClientDetails_Integration> pClientDetails, int OrgID, string SecurityToken,

     out List<InvestigationDetail> lstIds, out int TranStatus, out List<BarcodeIntegrationResults> lstbarcode)
    {
        lstIds = new List<InvestigationDetail>();
        lstbarcode = new List<BarcodeIntegrationResults>();
        List<PatientInvSample> lstinvsample = new List<PatientInvSample>();
        TranStatus = -1;
        long ReturnCode = -1;

        try
        {
            OrderInvestigations(pDetails, pAddress, pVisit, lInvestigationList, pClientDetails, OrgID, SecurityToken, out lstIds, out  TranStatus);
            string ExternalVisitId = pVisit.ExternalVisitID;
            ReturnCode = new IntegrationBL().GetBarCodeForSample(ExternalVisitId, OrgID, out lstinvsample, out lstbarcode, out TranStatus);


        }
        catch (Exception ex)
        {

            TranStatus = -1;
            CLogger.LogError("Error in patient registration: ", ex);
        }

        return ReturnCode;
    }
    [WebMethod(EnableSession = true)]
    public long OrderInvestigations(PatientDetails pDetails, PatientAddress pAddress, VisitDetails pVisit, List<InvestigationDetail> lInvestigationList, List<ClientDetails_Integration> pClientDetails, int OrgID, string SecurityToken, out List<InvestigationDetail> lstIds, out int TranStatus)
    {
        long returnCode = -1;
        TranStatus = -1;
        OrgId = OrgID;
        lstIds = new List<InvestigationDetail>();
        long ClientID = 0;
        try
        {
            //if (ValidateToken(SecurityToken))
            //{
            long pVisitID = 0;
            long OrgAddressID = -1;
            long PatientID = -1;
            Role roleName = new Role();
            Patient patient = new Patient();
            List<Role> lRole = new List<Role>();
            int patientCount = -1;
            List<IntegrationHistory> lstValue = new List<IntegrationHistory>();
            IntegrationHistory oHistory = new IntegrationHistory();
            ClientSave(pClientDetails, out ClientID);
            string patientXML = Attune.Podium.Common.Utilities.ConvertToXML(pDetails, typeof(PatientDetails));
            string AddressXML = Attune.Podium.Common.Utilities.ConvertToXML(pAddress, typeof(PatientAddress));
            string visitXML = Attune.Podium.Common.Utilities.ConvertToXML(pVisit, typeof(VisitDetails));
            string InvestigationXML = Attune.Podium.Common.Utilities.ConvertToXML(lInvestigationList, typeof(List<InvestigationDetail>));
            string ClientXML = Attune.Podium.Common.Utilities.ConvertToXML(pClientDetails, typeof(List<ClientDetails_Integration>));
            Attune.Podium.Common.CLogger.LogWarning("ExterVisitID:" + pVisit.ExternalVisitID + "VisitType :" + pVisit.VisitType);

            if (patientXML != string.Empty)
            {
                oHistory.IntegrationValue = patientXML;
                oHistory.OrgID = OrgID;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = pVisit.ExternalVisitID;
                oHistory.Type = "Medall";
                oHistory.XMLType = "PatientXML";
                lstValue.Add(oHistory);
            }
            if (AddressXML != string.Empty)
            {
                oHistory = new IntegrationHistory();
                oHistory.IntegrationValue = AddressXML;
                oHistory.OrgID = OrgID;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = pVisit.ExternalVisitID;
                oHistory.Type = "Medall";
                oHistory.XMLType = "PatientAddressXML";
                lstValue.Add(oHistory);
            }
            if (visitXML != string.Empty)
            {
                oHistory = new IntegrationHistory();
                oHistory.IntegrationValue = visitXML;
                oHistory.OrgID = OrgID;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = pVisit.ExternalVisitID;
                oHistory.Type = "Medall";
                oHistory.XMLType = "PatientVisitXML";
                lstValue.Add(oHistory);
            }
            if (InvestigationXML != string.Empty)
            {
                oHistory = new IntegrationHistory();
                oHistory.IntegrationValue = InvestigationXML;
                oHistory.OrgID = OrgID;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = pVisit.ExternalVisitID;
                oHistory.Type = "Medall";
                oHistory.XMLType = "InvestigationXML";
                lstValue.Add(oHistory);
            }
            if (ClientXML != string.Empty)
            {
                oHistory = new IntegrationHistory();
                oHistory.IntegrationValue = ClientXML;
                oHistory.OrgID = OrgID;
                oHistory.CreatedBy = -1;
                oHistory.ExternalID = pVisit.ExternalVisitID;
                oHistory.Type = "Medall";
                oHistory.XMLType = "ClientXML";
                lstValue.Add(oHistory);
            }
            if (lstValue.Count > 0)
            {
                returnCode = new IntegrationBL().SaveIntegrationData(lstValue);

            }
            if (pDetails.DOB.ToShortDateString() == "01/01/0001")
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                //pDetails.DOB = new DateTime(1800, 1, 1);
                //DateTime.MinValue.ToString("d");
                //The  Aboue Cod e is  comented and  modified By Arivalagan.kk

                DateTime pYear = DateTime.Now;
                int pAge = 0;
                if (pDetails.Age != "" && pDetails.Age.Length <= 2)
                {
                    pAge = Convert.ToInt32(pDetails.Age);
                }
                pDetails.DOB = pYear.AddYears(-pAge);
            }


            patient.Name = pDetails.Name;
            patient.Age = pDetails.Age;
            patient.OrgID = OrgID;
            patient.SEX = pDetails.SEX;
            patient.TITLECode = pDetails.TITLECode;
            //patient.Nationality =Convert.ToInt64(pDetails.Nationality);
            if (pDetails.Nationality != null && pDetails.Nationality != "")
            {
                patient.Nationality = Convert.ToInt64(pDetails.Nationality);
            }
            else
            {
                patient.Nationality = 0;
            }
            patient.DOB = pDetails.DOB;
            patient.PatientNumber = pDetails.PatientNumber;
            patient.EMail = pDetails.EMail;

            if (!string.IsNullOrEmpty(pVisit.ReferingPhysician.PhysicianCode) && !string.IsNullOrEmpty(pVisit.ReferingPhysician.PhysicianName))
            {
                List<ReferingPhysicianDetails> lstrefphy = new List<ReferingPhysicianDetails>();
                ReferingPhysicianDetails refphy = new ReferingPhysicianDetails();
                refphy.PhysicianCode = pVisit.ReferingPhysician.PhysicianCode;
                refphy.PhysicianName = pVisit.ReferingPhysician.PhysicianName;
                refphy.Mobile = pVisit.ReferingPhysician.Mobile;
                refphy.OrgID = pVisit.ReferingPhysician.OrgID;
                refphy.HasReportingEmail = pVisit.ReferingPhysician.HasReportingEmail;
                refphy.HasReportingSms = pVisit.ReferingPhysician.HasReportingSms;
                refphy.EmailID = pVisit.ReferingPhysician.EmailID;
                refphy.CountryID = 75;
                refphy.StateID = 31;
                lstrefphy.Add(refphy);
                if (lstrefphy.Count > 0 && lstrefphy != null)
                {
                    long Refferingphysicianid = 0;
                    SaveReferringPhysician(lstrefphy, out Refferingphysicianid);
                    pVisit.ReferingPhysician.ReferingPhysicianID = Convert.ToInt32(Refferingphysicianid);
                }
            }
            PatientVisit VisitDetails = new PatientVisit();
            VisitDetails.PriorityID = pVisit.PriorityID;
            VisitDetails.ReferingPhysicianID = pVisit.ReferingPhysician.ReferingPhysicianID;
            VisitDetails.ReferingPhysicianName = pVisit.ReferingPhysician.PhysicianName;
            VisitDetails.HospitalID = pVisit.ReferinghospitalID;
            VisitDetails.HospitalName = pVisit.ReferingHospitalName;
            //************For  Do From Visit ClientID Made By Arivalagan.kk*************//
            VisitDetails.ClientID = ClientID;
            //************For  Do From Visit ClientID Made By Arivalagan.kk*************//
            //VisitDetails.ClientName = pVisit.ClientName;
            VisitDetails.CollectionCentreID = pVisit.CollectionCentreID;
            VisitDetails.CollectionCentreName = pVisit.CollectionCentreName;
            VisitDetails.ExternalVisitID = pVisit.ExternalVisitID;
            VisitDetails.VisitType = pVisit.VisitType;
            VisitDetails.OrgID = OrgID;
            VisitDetails.OrgAddressID = pVisit.CollectionCentreID;
            VisitDetails.WardNo = pVisit.WardNo;
            VisitDetails.IsDueBill = pVisit.IsDueBill;
            List<InvestigationDetail> lstreturncode2 = new List<InvestigationDetail>();
            bool proceedtransaction = true;

            #region "Duplicate Investigaton ID / group ID exists for the paticular visit"


            int index = 0;
            while (index < lInvestigationList.Count - 1)
            {
                if (lInvestigationList[index].ID == lInvestigationList[index + 1].ID)
                {
                    lInvestigationList.RemoveAt(index);
                    lstreturncode2.Add(lInvestigationList[index]);
                    returnCode = 2;
                    proceedtransaction = false;
                }
                else
                {
                    index++;
                }
            }
            lstIds = lstreturncode2;



            List<InvestigationDetail> lstIdExists = new List<InvestigationDetail>();
            List<InvestigationDetail> lstDupIds = new List<InvestigationDetail>();

            if (proceedtransaction == true)
            {



                returnCode = new IntegrationBL().GetDuplicateIDforIntegration(OrgID, lInvestigationList, out lstIdExists, out lstDupIds);

                if (lstIdExists.Count() > 0)
                {

                    returnCode = 1;
                    lstIds = lstIdExists;
                    proceedtransaction = false;

                }
                if (lstDupIds.Count() > 0 && proceedtransaction == true)
                {

                    returnCode = 3;
                    lstIds = lstDupIds;
                    proceedtransaction = false;


                }
            }
            #endregion
            #region "Old Code"
            #endregion
            List<VisitClientMapping> lst = new List<VisitClientMapping>();
            VisitClientMapping obj = new VisitClientMapping();
            obj.ClientID = ClientID;
            lst.Add(obj);
            ContextDetails context = new ContextDetails();
            context.LocationID = pVisit.CollectionCentreID;
            context.OrgID = OrgID;
            returnCode = new IntegrationBL(context).PushintegratedData(patient, pAddress, VisitDetails, lInvestigationList, lst);
            if (returnCode == 0)
            {
                TranStatus = 0;
            }
            else
            {
                TranStatus = -1;
            }

        }
        catch (Exception ex)
        {
            returnCode = -1;
            TranStatus = -1;
            CLogger.LogError("Error in patient registration: ", ex);
        }
        return returnCode;
    }
    #region Client Details
    [WebMethod(EnableSession = true)]
    public long ClientSave(List<ClientDetails_Integration> pClientDetails, out long ClientID)
    {
        ClientID = 0;
        long returncode = -1;
        //List<ClientDetails_Integration> lstClientDetails = new List<ClientDetails_Integration>();
        try
        {
            returncode = new IntegrationBL().SaveClientDetails(pClientDetails, out ClientID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveClientDetails", ex.InnerException);
        }
        return ClientID;
    }
    #endregion
    #region Reffering Details
    [WebMethod(EnableSession = true)]
    public long SaveReferringPhysician(List<ReferingPhysicianDetails> lstrefphy, out long Refferingphysicianid)
    {
        Refferingphysicianid = 0;
        long returncode = -1;
        try
        {
            returncode = new IntegrationBL().SaveReferingphysiciandetails(lstrefphy, out Refferingphysicianid);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveRefferingdetails in IntegrationService", ex.InnerException);
        }

        return Refferingphysicianid;
    }
    #endregion
    #region UpdateDueBillvisit
    [WebMethod]
    public void UpdateDueBillvisit(String ExternalVisitID, int IsDuebill, int Orgid)
    {
        long returnCode = -1;
        returnCode = new IntegrationBL().UpdateDueBillvisit(ExternalVisitID, IsDuebill, Orgid);
    }
    #endregion

    #region DeviceIntegration
    [WebMethod(EnableSession = true)]
    public long InsertInvIntegrationResult(List<InvIntegrationResult> lstInvIntegrationResult, int OrgID)
    //, string SecurityToken, out int TranStatus)
    {
        long outputReturnCode = -1;
        long TranStatus = -1;
        long InvID = 0;
        long returnCodedevieflag = 0;
        bool DeviceErrorFlag = false;
        List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
        List<PatientInvestigationAttributes> Lstpatattr = new List<PatientInvestigationAttributes>();
        Investigation_BL InvBL = new Investigation_BL();
        try
        {
            //if (ValidateToken(SecurityToken))
            //{
            string STATUSAll = string.Empty;
            string isFromDevice = "Y";

            string QCResult = string.Empty;
            bool IsdeltaCheck = false;
            decimal DeltaLowerLimit = 0;
            decimal DeltaHigherLimit = 0;
            string deviceresult;
            string RoleID = "0";
            string IsdeviceApprove = "N";
            STATUSAll = GetConfigValues("SampleStatusAllCompleted", OrgID);
            if (lstInvIntegrationResult.Count > 0)
            {
                PageContextkey PageContextDetails = new PageContextkey();

                // Integration Result For loop - Begins
                for (int p = 0; p < lstInvIntegrationResult.Count; p++)
                {
                    long returnCode = -1;
                    long returnCodeGrp = -1;
                    Role oRoleName = new Role();
                    List<Role> lstRole = new List<Role>();
                    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    List<IntegrationHistory> lstIntegrationHistoryRawData = new List<IntegrationHistory>();
                    IntegrationHistory oIntHistory = new IntegrationHistory();
                    InvIntegrationResult oIntegrationResult = lstInvIntegrationResult[p];
                    string strSampleInstanceID = string.Empty;
                    // saving RAW data to Integration History - Begins
                    strSampleInstanceID = oIntegrationResult.SampleInstanceID;
                    string strIntegrationResultXML = Attune.Podium.Common.Utilities.ConvertToXML(lstInvIntegrationResult[p], typeof(InvIntegrationResult));
                    if (strIntegrationResultXML != string.Empty)
                    {
                        oIntHistory.IntegrationValue = strIntegrationResultXML;
                        oIntHistory.OrgID = OrgID;
                        oIntHistory.CreatedBy = -1;
                        oIntHistory.ExternalID = strSampleInstanceID;
                        oIntHistory.Type = "DeviceIntegration";
                        lstIntegrationHistoryRawData.Add(oIntHistory);
                    }
                    if (lstIntegrationHistoryRawData.Count > 0)
                    {
                        returnCode = new IntegrationBL().SaveIntegrationData(lstIntegrationHistoryRawData);
                    }
                    // saving RAW data to Integration History - Ends

                    //using (System.Transactions.TransactionScope rootScope = new System.Transactions.TransactionScope())
                    //{
                    //Extracting Investigation to PatientInvestigation - begins
                    long returnCod = -1;
                    long ivid = 0;
                    int vCount = 0;
                    int intOrgID = 0;
                    string struid = "";
                    int pOrderedCount = -1;
                    Investigation_BL oInvBL = new Investigation_BL();
                    List<PatientInvestigation> lstPatInvestigation = new List<PatientInvestigation>();
                    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                    List<InvDeptMaster> lstdeptList = new List<InvDeptMaster>();
                    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                    List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();

                    string suffixOrgBarcode = strSampleInstanceID + "#" + OrgID.ToString();
                    string ExternalBarcode = GetConfigValues("AllowExternalBarcode", OrgID);
                    string ExDeviceID, AssayCode;
                    ExDeviceID = oIntegrationResult.LstIntegrationResultValue[0].DeviceID;
                    AssayCode = oIntegrationResult.LstIntegrationResultValue[0].TestCode;
                    string labcode = oIntegrationResult.LstIntegrationResultValue[0].OrganismCode;
                    string oBarcode = string.Empty;
                    if (!string.IsNullOrEmpty(labcode))
                    {
                        returnCod = new IntegrationBL().GetIntegrationVisitDetailforLabCode(suffixOrgBarcode, ExDeviceID, AssayCode, out ivid, out vCount, out struid, out intOrgID, out oBarcode);
                    }
                    else if (ExternalBarcode == "Y")
                    {
                        returnCod = new IntegrationBL().GetIntegrationVisitDetailforExternalBarcode(suffixOrgBarcode, ExDeviceID, AssayCode, out ivid, out vCount, out struid, out intOrgID);
                    }
                    else
                    {
                        returnCod = new IntegrationBL().GetIntegrationVisitDetail(suffixOrgBarcode, out ivid, out vCount, out struid, out intOrgID);
                    }
                    //returnCod = new IntegrationBL().GetIntegrationVisitDetail(strSampleInstanceID, out ivid, out vCount, out struid, out intOrgID);
                    OrgId = intOrgID;
                    returnCode = oInvBL.GetInvestigationSamplesCollect(ivid, intOrgID, 0, struid, 0, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out lstdeptList, out lstSampleContainer);

                    PatientInvestigation objInvest;
                    if (lstPatientInvestigation.Count > 0)
                    {
                        foreach (PatientInvestigation patient in lstPatientInvestigation)
                        {
                            objInvest = new PatientInvestigation();
                            objInvest.InvestigationID = patient.InvestigationID;
                            objInvest.InvestigationName = patient.InvestigationName;
                            objInvest.PatientVisitID = patient.PatientVisitID;
                            objInvest.GroupID = patient.GroupID;
                            objInvest.GroupName = patient.GroupName;
                            objInvest.Status = patient.Status;
                            objInvest.CollectedDateTime = patient.CreatedAt;
                            objInvest.CreatedBy = 0;
                            objInvest.Type = patient.Type;
                            objInvest.OrgID = intOrgID;
                            objInvest.InvestigationMethodID = 0;
                            objInvest.KitID = 0;
                            objInvest.InstrumentID = 0;
                            objInvest.UID = patient.UID;
                            objInvest.AutoApproveLoginID = patient.AutoApproveLoginID;
                            lstPatInvestigation.Add(objInvest);
                        }
                    }
                    if (lstPatInvestigation.Count > 0 && vCount == 0)
                    {
                        //saving Patient Investigation

                        if (returnCode == 0)
                        {
                            returnCode = new Investigation_BL().SavePatientInvestigation(lstPatInvestigation, intOrgID, struid, out pOrderedCount);
                        }
                    }
                    //Extracting Investigation to PatientInvestigation - Ends

                    //Inserting Investigation Values - Begins
                    //Preparing Data - Begins
                    List<PatientInvestigation> lstPatInvTestCode = new List<PatientInvestigation>();
                    List<InvestigationMaster> lstIM = new List<InvestigationMaster>();
                    if (oIntegrationResult != null)
                    {
                        //for (int i = 0; i < oIntegrationResult.Count; i++)
                        //{
                        InvIntegrationResult oInvIntegrationResult = new InvIntegrationResult();
                        List<InvIntegrationResultValue> lstInvIntegrationResultValue = new List<InvIntegrationResultValue>();
                        oInvIntegrationResult = oIntegrationResult;
                        oInvIntegrationResult.SampleInstanceID = oIntegrationResult.SampleInstanceID;
                        if (oInvIntegrationResult.LstIntegrationResultValue.Count > 0)
                        {
                            InvestigationMaster oIM;
                            InvIntegrationResultValue oRV;
                            string Barcode = strSampleInstanceID;
                            string DeviceId = string.Empty;
                            for (int j = 0; j < oInvIntegrationResult.LstIntegrationResultValue.Count; j++)
                            {
                                oIM = new InvestigationMaster();
                                oRV = new InvIntegrationResultValue();
                                oRV.TestCode = oInvIntegrationResult.LstIntegrationResultValue[j].TestCode;
                                oRV.ResultValue = oInvIntegrationResult.LstIntegrationResultValue[j].ResultValue;
                                oRV.ResultUOM = oInvIntegrationResult.LstIntegrationResultValue[j].ResultUOM;
                                oRV.DeviceID = oInvIntegrationResult.LstIntegrationResultValue[j].DeviceID;
                                oIM.TestCode = oInvIntegrationResult.LstIntegrationResultValue[j].TestCode;
                                DeviceId = oInvIntegrationResult.LstIntegrationResultValue[j].DeviceID;
                                oRV.DeviceErrorCode = oInvIntegrationResult.LstIntegrationResultValue[j].DeviceErrorCode;
                                lstIM.Add(oIM);
                                lstInvIntegrationResultValue.Add(oRV);
                            }

                            //Fetching matching InvestigationId for TestCode - begins
                            if (returnCode == 0)
                            {
                                returnCode = new IntegrationBL().GetTestCodeInvestigation(lstIM, intOrgID, ivid, struid, Barcode, DeviceId, out lstPatInvTestCode);
                            }
                            //Fetching matching InvestigationId for TestCode - ends
                            List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
                            List<List<InvestigationValues>> lstlstInvestigationValues = new List<List<InvestigationValues>>();
                            List<PatientInvestigation> lstReflexPatientInvestigation = new List<PatientInvestigation>();
                            lstlstInvestigationValues.Clear();
                            if (lstInvIntegrationResultValue.Count > 0)
                            {
                                InvestigationValues oIV;
                                List<InvestigationValues> lstIV;
                                List<PatientInvestigation> item;
                                PatientInvestigation oPinv;
                                foreach (InvIntegrationResultValue rvitem in lstInvIntegrationResultValue)
                                {
                                    oIV = new InvestigationValues();
                                    lstIV = new List<InvestigationValues>();

                                    if (lstPatInvTestCode.Count > 0)
                                    {

                                        QCResult = lstPatInvTestCode[0].QCData;
                                        IsdeltaCheck = lstPatInvTestCode[0].IsDeltaCheck;
                                        DeltaLowerLimit = lstPatInvTestCode[0].DeltaLowerLimit;
                                        DeltaHigherLimit = lstPatInvTestCode[0].DeltaHigherLimit;
                                        deviceresult= rvitem.ResultValue;
                                        var lstPIItems = from Items in lstPatInvTestCode
                                                         where Items.PackageName == rvitem.TestCode
                                                         select Items;
                                        item = lstPIItems.ToList<PatientInvestigation>();

                                        for (int k = 0; k < item.Count; k++)
                                        {
                                            oIV = new InvestigationValues();
                                            lstIV = new List<InvestigationValues>();

                                            oIV.Name = item[k].InvestigationName;
                                            oIV.InvestigationID = item[k].InvestigationID;
                                            oIV.PatientVisitID = item[k].PatientVisitID;
                                            //below code is to multiple WBC with 1000 for device integration
                                            double resultvalue = 0;
                                            double.TryParse(rvitem.ResultValue, out resultvalue);
                                            string DeviceID = rvitem.DeviceID;
                                            int InvestigationID = Convert.ToInt32(item[k].InvestigationID);
                                            string ResultValue = rvitem.ResultValue;
                                            long orgID = OrgID;
                                            // --- Ramkumar.S -- Added for Negative or Positive values were not pushed from Device---//
                                            string resultval2 = string.Empty;
                                            LabUtil oLabUtil = new LabUtil();
                                            if (!string.IsNullOrEmpty(rvitem.ResultValue.Trim()))
                                            {
                                                bool Isnumeric = IsNumeric(ResultValue);
                                                if (Isnumeric)
                                                {
                                                    oIV.Value = DecimalPlace(DeviceID, InvestigationID, ResultValue, orgID);
                                                    resultval2 = oLabUtil.ConvertResultValue(oIV.Value).ToString();
                                                }
                                                else
                                                {
                                                    oIV.Value = ResultValue;
                                                    resultval2 = oIV.Value;
                                                }
                                            }
                                            else
                                            {
                                                oIV.Value = "";
                                            }
                                            //-------ENds----------------
                                            oIV.DeviceValue = oIV.Value;
                                            oIV.DeviceActualValue = rvitem.ResultValue;
                                            //string resultval2 = oIV.Value;
                                            if (item[0].ResultValueType == "NTS")
                                            {
                                                //LabUtil oLabUtil = new LabUtil();
                                                oIV.Value = oLabUtil.ReplaceNumberWithCommas(resultval2);
                                            }
                                            oIV.UOMCode = null;
                                            oIV.CreatedBy = 0;
                                            oIV.GroupID = item[k].GroupID;
                                            oIV.GroupName = item[k].GroupName;
                                            oIV.PackageID = item[k].PackageID;
                                            oIV.PackageName = item[k].PackageName;
                                            oIV.Orgid = item[k].OrgID;
                                            oIV.DeviceErrorCode = rvitem.DeviceErrorCode;
                                            InvID = item[k].InvestigationID;
                                            OrgID = item[k].OrgID;
                                            returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                            InvBL = new Investigation_BL();
                                            #region hide code merge for quantum
                                            ////if (lstInvValueRangeMaster.Count > 0)
                                            ////{
                                            ////    //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                            ////    //{                                                            
                                            ////    if (fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation))
                                            ////    {
                                            ////        oIV.Status = "Pending";
                                            ////    }
                                            ////    else
                                            ////    {
                                            ////        oIV.Status = "Pending";
                                            ////    }
                                            ////}
                                            ////else
                                            ////{
                                            ////    oIV.Status = "Pending";
                                            ////    //oIV.Status = "Pending";
                                            ////}
                                            ////oIV.DeviceID = rvitem.DeviceID;

                                            ////oPinv = new PatientInvestigation();
                                            ////oPinv.InvestigationID = item[k].InvestigationID;
                                            ////oPinv.PatientVisitID = item[k].PatientVisitID;
                                            ////oPinv.GroupID = item[k].GroupID;
                                            ////if (lstInvValueRangeMaster.Count > 0)
                                            ////{
                                            ////    //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                            ////    //{                                                            
                                            ////    if (fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation))
                                            ////    {
                                            ////        oPinv.Status = "Pending";
                                            ////    }
                                            ////    else
                                            ////    {
                                            ////        oPinv.Status = "Pending";
                                            ////    }
                                            ////}
                                            ////else
                                            ////{
                                            ////    oPinv.Status = "Pending";
                                            ////    //oIV.Status = "Pending";
                                            ////}

                                            ////oPinv.AutoApproveLoginID = item[k].AutoApproveLoginID;
                                            ////IsExcludeAutoApproval = item[k].RefSuffixText;


                                            ////oPinv.Reason = item[k].Reason;
                                            ////oPinv.OrgID = item[k].OrgID;

                                            ////oPinv.AccessionNumber = item[k].AccessionNumber;
                                            ////oPinv.InvestigationValue = item[k].InvestigationValue;
                                            ////oPinv.GroupID = item[k].GroupID;
                                            #endregion
                                            List<InvestigationValues> Investigationvalues = new List<InvestigationValues>();
                                            if (string.IsNullOrEmpty(rvitem.DeviceErrorCode.ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                                                {
                                                    if (!string.IsNullOrEmpty(rvitem.ResultValue.Trim()))
                                                    {
                                                        InvID = item[k].InvestigationID;
                                                        OrgID = item[k].OrgID;
                                                        returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                                        //InvBL = new Investigation_BL();
                                                        returnCodeGrp = InvBL.GetAutocompleteForGroupid(item[k].GroupID, OrgID, out lstInvOrgGroup);
                                                        if ((lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].AllowAutoComplete == true) || (item[k].GroupID == 0))
                                                        {
                                                            if (lstInvValueRangeMaster.Count > 0)
                                                            {
                                                                //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                                //{                                                            
                                                                if (fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation))
                                                                {
                                                                    oIV.Status = "Pending";
                                                                }
                                                                else
                                                                {
                                                                    oIV.Status = "Completed";
                                                                }
                                                            }
                                                            else
                                                            {
                                                                oIV.Status = "Completed";
                                                                //oIV.Status = "Pending";
                                                            }
                                                        }
                                                        else if (lstInvOrgGroup.Count == 0)
                                                        {
                                                            oIV.Status = "Completed";
                                                        }
                                                        else
                                                        {
                                                            oIV.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oIV.Status = "Pending";
                                                    }
                                                }
                                                else
                                                {
                                                    oIV.Status = "Pending";
                                                }
                                            }
                                            else
                                            {
                                                if (!string.IsNullOrEmpty(rvitem.ResultValue.Trim()))
                                                {
                                                    returnCodedevieflag = InvBL.DeviceErrorFlagcheck(orgID, rvitem.DeviceID, rvitem.DeviceErrorCode, InvestigationID, out Investigationvalues);
                                                    if (Investigationvalues.Count == 0)
                                                    {
                                                        oIV.Status = "Completed";
                                                        oIV.Value = oIV.Value;
                                                    }
                                                    else
                                                    {
                                                        oIV.Status = "Pending"; //Sur
                                                        oIV.Value = Investigationvalues[0].Statustype + oIV.Value;
                                                    }
                                                }
                                                else
                                                {
                                                    oIV.Status = "Pending";
                                                    oIV.Value = oIV.Value;
                                                }
                                                InvID = item[0].InvestigationID;
                                                OrgID = item[k].OrgID;
                                                returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                                if (lstInvValueRangeMaster.Count > 0)
                                                {
                                                    //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                    //{
                                                    if (fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation))
                                                    {

                                                    }
                                                    else
                                                    {

                                                    }
                                                }
                                            }
                                            oIV.DeviceID = rvitem.DeviceID;
                                            lstIV.Add(oIV);
                                            //lstlstInvestigationValues.Add(lstIV);
                                            oPinv = new PatientInvestigation();
                                            oPinv.InvestigationID = item[k].InvestigationID;
                                            oPinv.PatientVisitID = item[k].PatientVisitID;
                                            oPinv.GroupID = item[k].GroupID;
                                            if (string.IsNullOrEmpty(rvitem.DeviceErrorCode.ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                                                {
                                                    if (!string.IsNullOrEmpty(rvitem.ResultValue.Trim()))
                                                    {
                                                        if (lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].AllowAutoComplete == true || (item[k].GroupID == 0))
                                                        {
                                                            if (lstInvValueRangeMaster.Count > 0)
                                                            {
                                                                //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                                //{                                                            
                                                                if ((fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation)))
                                                                {
                                                                    oPinv.Status = "Pending";
                                                                }
                                                                else
                                                                {
                                                                    oPinv.Status = "Completed";
                                                                }
                                                            }
                                                            else
                                                            {
                                                                oPinv.Status = "Completed";
                                                                //oPinv.Status = "Pending";
                                                            }
                                                        }
                                                        else if (lstInvOrgGroup.Count == 0)
                                                        {
                                                            oPinv.Status = "Completed";
                                                        }
                                                        else
                                                        {
                                                            oPinv.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oPinv.Status = "Pending";
                                                    }
                                                }
                                                else
                                                {
                                                    oPinv.Status = "Pending";
                                                }
                                            }
                                            else
                                            {
                                                if (!string.IsNullOrEmpty(rvitem.ResultValue.Trim()))
                                                {
                                                    if (Investigationvalues.Count == 0)
                                                    {
                                                        oPinv.Status = "Completed";
                                                    }
                                                    else
                                                    {
                                                        oPinv.Status = "Pending"; //Sur
                                                    }
                                                }
                                                else
                                                {
                                                    oPinv.Status = "Pending";
                                                }
                                            }

                                            oPinv.AutoApproveLoginID = item[k].AutoApproveLoginID;
                                            IsExcludeAutoApproval = item[k].RefSuffixText;


                                            oPinv.Reason = item[k].Reason;
                                            oPinv.OrgID = item[k].OrgID;
                                            //Added By Prasanna.S
                                            oPinv.AccessionNumber = item[k].AccessionNumber;
                                            oPinv.InvestigationValue = item[k].InvestigationValue;
                                            oPinv.GroupID = item[k].GroupID;
                                            string result = string.Empty;

                                            Patient_BL patientBL = new Patient_BL();
                                            List<PatientVisit> visitList = new List<PatientVisit>();
                                            patientBL.GetLabVisitDetails(item[k].PatientVisitID, OrgID, out visitList);
                                            lstPatientInv = ValidateReferenceRange(lstPatientInv, oPinv, item[k], rvitem.ResultValue, oIV.Value, oIV.DeviceID, resultval2, visitList);

                                            // Start by VEL//
                                            if (!string.IsNullOrEmpty(ResultValue.Trim()) && !string.IsNullOrEmpty(item[k].ReferenceRange))
                                            {
                                                XElement xe = XElement.Parse(item[k].ReferenceRange);
                                                var Range = from range in xe.Elements("resultsinterpretationrange").Elements("property")
                                                            select range;
                                                if (Range != null && Range.Count() > 0)
                                                {
                                                    //LabUtil oLabUtil = new LabUtil();
                                                    //string result = string.Empty;
                                                    string resultType = string.Empty;
                                                    decimal deviceValue = 0;
                                                    bool isNumericValue = false;
                                                    deviceValue = oLabUtil.ConvertResultValue(oIV.Value, out isNumericValue);
                                                    if (isNumericValue)
                                                    {
                                                        string patientAge = string.Empty;
                                                        string pGender = visitList[0].Sex.ToString();
                                                        Array pAgeRaw = visitList[0].PatientAge.Split(' ');

                                                        pGender = !string.IsNullOrEmpty(pGender) && pGender != "0" ? (pGender == "F" ? "Female" : "Male") : string.Empty;
                                                        string pAge = string.Empty;
                                                        string pAgetype = string.Empty;
                                                        if (pAgeRaw != null && pAgeRaw.Length > 0)
                                                        {
                                                            pAge = pAgeRaw.GetValue(0).ToString();
                                                            if (pAgeRaw.Length > 1)
                                                            {
                                                                pAgetype = pAgeRaw.GetValue(1).ToString();
                                                            }
                                                        }
                                                        patientAge = pGender + "~" + pAge + "~" + pAgetype;

                                                        string[] lstAge = patientAge.Split('~');
                                                        string gender = lstAge[0] != null ? lstAge[0] : string.Empty;
                                                        string age = lstAge[1] != null && lstAge[2] != null ? lstAge[1] + " " + lstAge[2] : string.Empty;
                                                        oLabUtil.ValidateInterpretationRange(item[k].ReferenceRange, gender, age, deviceValue, DeviceID, out result, out resultType);
                                                        if (result != string.Empty)
                                                        {
                                                            if (resultType == "Interpretation")
                                                            {
                                                                oIV.Value = result;
                                                            }
                                                            else
                                                            {
                                                                oIV.Value = result + "," + oIV.Value;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            // Start by VEL END//

                                            //Rule Master Starts
                                            //lstPatientInv[0].IsAbnormal
                                            bool AcrFlag = false;
                                            bool MrrFlag = false;
                                            string rulemedicalremarks = string.Empty;
                                            int remarksid = 0;
                                            List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
                                            List<InvRuleMaster> lstInvremarks = new List<InvRuleMaster>();                                            
                                            List<PatientAgeGenderRule> lstPatientAgeGenderRule = new List<PatientAgeGenderRule>();
                                            List<TestResultsRule> lstTestResultsRule = new List<TestResultsRule>();
                                            List<MachineErrorRule> lstMachineErrorRule = new List<MachineErrorRule>();                                            
                                            if (item[k].GroupID > 0)
                                            {

                                                returnCode = InvBL.GetInvRulemasterVisit(item[k].PatientVisitID, item[k].GroupID, OrgID, "GRP", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
                                                if (lstInvRuleMaster.Count == 0 )
                                                {
                                                    returnCode = InvBL.GetInvRulemasterVisit(item[k].PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
                                                }
                                            }
                                            else
                                            {
                                                returnCode = InvBL.GetInvRulemasterVisit(item[k].PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
                                            }
                                            if (lstInvRuleMaster.Count > 0)
                                            {
                                                List<PatientAgeGenderRule> lstPatientAgeGender = new List<PatientAgeGenderRule>();
                                                List<TestResultsRule> lstTestResults = new List<TestResultsRule>();
                                                List<MachineErrorRule> lstMachineError = new List<MachineErrorRule>();
                                                foreach (InvRuleMaster orm in lstInvRuleMaster)
                                                {
                                                    if (orm.Code == "ACR")
                                                    {
                                                        lstPatientAgeGender = lstPatientAgeGenderRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId).ToList();
                                                        lstTestResults = lstTestResultsRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId).ToList();
                                                        lstMachineError = lstMachineErrorRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId).ToList();
                                                        AcrFlag = ValidateRuleMaster(InvID, oIV.Value, lstPatientInv[0].IsAbnormal, visitList[0].Sex.ToString(), rvitem.DeviceErrorCode, lstPatientAgeGender, lstTestResults, lstMachineError);
                                                    }
                                                    if (AcrFlag)
                                                    {
                                                        break;
                                                    }
                                                }
                                                foreach (InvRuleMaster orm in lstInvRuleMaster)
                                                {
                                                    if (orm.Code == "MRR")
                                                    {
                                                        foreach (InvRuleMaster irm in lstInvremarks)
                                                        {
                                                            lstPatientAgeGender = lstPatientAgeGenderRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                                                            lstMachineError = lstMachineErrorRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                                                            lstTestResults = lstTestResultsRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                                                            if (item[k].GroupID > 0)
                                                            {
                                                                lstTestResults = new List<TestResultsRule>();
                                                                lstTestResults = lstTestResultsRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId && RR.ResultInvestigationID == InvID).ToList();
                                                            }

                                                            MrrFlag = ValidateRuleMaster(InvID, oIV.Value, lstPatientInv[0].IsAbnormal, visitList[0].Sex.ToString(), rvitem.DeviceErrorCode, lstPatientAgeGender, lstTestResults, lstMachineError);
                                                            if (MrrFlag)
                                                            {
                                                                rulemedicalremarks = irm.InvRemarksValue;
                                                                remarksid = irm.RemarksId;
                                                                break;
                                                            }
                                                        }
                                                        if (MrrFlag)
                                                        {
                                                            break;
                                                        }
                                                    }
                                                }
                                            }
                                            PatientInvestigationAttributes PatAttr = new PatientInvestigationAttributes();
                                            if (MrrFlag == true)
                                            {
                                                if (rulemedicalremarks != "")
                                                {
                                                    lstPatientInv[0].MedicalRemarks = rulemedicalremarks;
                                                    PatAttr.PatientVisitID = item[k].PatientVisitID;


                                                    PatAttr.OrgID = OrgID;
                                                    PatAttr.InvestigationID = item[k].InvestigationID;
                                                    PatAttr.AccessionNumber = item[k].AccessionNumber;
                                                    PatAttr.MedicalRemarksID = remarksid;
                                                    Lstpatattr.Add(PatAttr);
                                                    oPinv.MedicalRemarks = rulemedicalremarks;
                                                }
                                                else
                                                {
                                                    lstPatientInv[0].MedicalRemarks = oPinv.MedicalRemarks;
                                                }
                                            }
                                            else
                                            {
                                                lstPatientInv[0].MedicalRemarks = oPinv.MedicalRemarks;
                                            }
                                            
                                            
                                            //seetha Starts for medicalremarks
                                            //List<MedicalRemarksRuleMaster> lstmedicalRemarks = new List<MedicalRemarksRuleMaster>();
                                            //patientBL.GetAutoMedicalComments(item[k].PatientVisitID, OrgID, out lstmedicalRemarks);
                                            //bool MedRemarksCondition = false;
                                            //long medInvestigationID;
                                            //long medAccessionNumber;
                                            //long MedRemarksID;
                                            //                string RemarksText= string.Empty;
                                            //                if (lstmedicalRemarks.Count > 0)
                                            //                {
                                            //                    string pGender = visitList[0].Sex.ToString();
                                            //                    string pAge = visitList[0].ReferenceRangeAge.ToString();
                                            //                    result = result == string.Empty ? resultval2 : result;
                                            //                result = oLabUtil.ConvertResultValue(result).ToString();
                                            //                CLogger.LogWarning("2" + result);
                                            //                    MedRemarksCondition = GetRemarksCondition(lstmedicalRemarks, item[k].InvestigationID, result, OrgID, pGender, pAge, out medInvestigationID, out medAccessionNumber, out MedRemarksID,out RemarksText);
                                            //                if (MedRemarksCondition == true)
                                            //                    {
                                            //                        PatientInvestigationAttributes PatAttr = new PatientInvestigationAttributes();
                                            //                        PatAttr.PatientVisitID = item[k].PatientVisitID;


                                            //                        PatAttr.OrgID = OrgID;
                                            //                        PatAttr.InvestigationID = medInvestigationID;
                                            //                        PatAttr.AccessionNumber = medAccessionNumber;
                                            //                        PatAttr.MedicalRemarksID = MedRemarksID;
                                            //                        Lstpatattr.Add(PatAttr);
                                            //                        if(oPinv.InvestigationID == medInvestigationID)
                                            //                        {
                                            //                            oPinv.MedicalRemarks = RemarksText;
                                            //                        }
                                            //                    }
                                            //                    else
                                            //                    {
                                            //                        PatientInvestigationAttributes PatAttr = new PatientInvestigationAttributes();
                                            //                        PatAttr.PatientVisitID = item[k].PatientVisitID;


                                            //                        PatAttr.OrgID = OrgID;
                                            //                        PatAttr.InvestigationID = medInvestigationID;
                                            //                        PatAttr.AccessionNumber = medAccessionNumber;
                                            //                        PatAttr.MedicalRemarksID = 0;
                                            //                        if (oPinv.InvestigationID == medInvestigationID)
                                            //                        {
                                            //                            oPinv.MedicalRemarks = "";
                                            //                        }
                                            //                        Lstpatattr.Add(PatAttr);
                                            //                    }
                                            //                }
                                                            
                                            List<InvestigationValues> lstInvValues =new List<InvestigationValues>();
                                            bool isTechneeded = false;
                                            bool isautocertify = ValidateAutoCertify(oPinv.InvestigationID, oPinv.OrgID, oPinv.PatientVisitID, oPinv.GroupID, QCResult, DeltaLowerLimit, DeltaHigherLimit, oIV.Value, rvitem.DeviceErrorCode, lstPatientInv[0].IsAbnormal, lstPatientInv[0].IsAutoAuthorize, oIV.DeviceID,AcrFlag, out lstInvValues, out isTechneeded);
                                            if (AcrFlag == true)
                                            {
                                                isautocertify = false;
                                                oPinv.IsAutoAuthorize = "N";
                                            }
                                           // oPinv.IsAutoAuthorize = "N";
                                            if (isautocertify)
                                            {
                                                string finalstatus = "Pending";

                                                if (lstInvValues.Count > 0)
                                                {
                                                    if (lstInvValues[0].PackageID == 1)
                                                    {
                                                        finalstatus = "Approve";
                                                    }
                                                    lstlstInvestigationValues.Add(lstInvValues);
                                                    PatientInvestigation Pinvs = null;

                                                    foreach (InvestigationValues obj in lstInvValues)
                                                    {
                                                        Pinvs = new PatientInvestigation();
                                                        Pinvs.GroupID = obj.GroupID;
                                                        Pinvs.AccessionNumber = obj.AccessionNumber;
                                                        Pinvs.AutoApproveLoginID = item[k].AutoApproveLoginID;
                                                        Pinvs.InvestigationValue = obj.Value;
                                                        Pinvs.ReferenceRange = obj.ReferenceRange;
                                                        Pinvs.InvestigationID = obj.InvestigationID;
                                                        Pinvs.PatientVisitID = obj.PatientVisitID;
                                                        Pinvs.Status = finalstatus;
                                                        Pinvs.InvestigationName = obj.InvestigationName;
                                                        Pinvs.GroupName = obj.GroupName;
                                                        Pinvs.OrgID = obj.Orgid;
                                                        Pinvs.UID = obj.UID;
                                                        Pinvs.IsAbnormal = obj.IsAbnormal;
                                                        Pinvs.MedicalRemarks = obj.MedicalRemarks;
                                                        //Pinvs.IsAutoAuthorize = "Y";
                                                        lstPatientInv = ValidateReferenceRange(lstPatientInv, Pinvs, Pinvs, obj.Value, obj.Value, oIV.DeviceID, obj.Value, visitList);
                                                    }
                                                }
                                                foreach (PatientInvestigation objpi in lstPatientInv)
                                                {
                                                    if (objpi.GroupID > 0)
                                                    {
                                                        objpi.IsAutoAuthorize = "Y";
                                                        objpi.Status = finalstatus;
                                                        objpi.ApprovedBy = item[k].AutoApproveLoginID;
                                                        oIV.Status = finalstatus;
                                                        if (finalstatus == "Pending")
                                                        {
                                                            objpi.ApprovedBy = 0;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        objpi.Status = "Approve";
                                                        objpi.ApprovedBy = item[k].AutoApproveLoginID;
                                                        oIV.Status = "Approve";
                                                    }
                                                    if (isTechneeded)
                                                    {
                                                        objpi.ApprovedBy = 0;
                                                        objpi.Status = "Pending";
                                                        oIV.Status = "Pending";
                                                    }
                                                    IsdeviceApprove = "Y";
                                                }
                                            }
                                            else
                                            {
                                               if (oPinv.IsAutoAuthorize != "Y")
                                                {
                                                    oPinv.IsAutoAuthorize = "N";
                                                }
                                            }

                                           
                                            
					                       lstlstInvestigationValues.Add(lstIV);
                                        }
                                        
                                    }
                                }
                            }

                            List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                            List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
                            List<PatientInvestigationFiles> lstlPFiles = new List<PatientInvestigationFiles>();
                            Investigation_BL oInvBl = new Investigation_BL();
                            int returnStatus = -1;
                            long pSCMID = -1;
                            int deptID = Convert.ToInt32("0");
                            //Preparing Data - Ends

                            if (returnCode == 0)
                            {
                                //Inserting InvestigationValues History  - begins
                                returnCode = new IntegrationBL().InsertInvestigationHistory(lstlstInvestigationValues, struid);
                                //Inserting InvestigationValues History  - ends
                            }

                            if (returnCode == 0)
                            {
                                //Saving Investigation values - begins
                                if (lstlstInvestigationValues.Count > 0)
                                {
                                    returnCode = oInvBl.SaveInvestigationResults(pSCMID, lstlstInvestigationValues, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lstlPFiles, ivid, intOrgID, deptID, 0, struid, PageContextDetails, out returnStatus, lstReflexPatientInvestigation, isFromDevice, Lstpatattr);

                                }//Saving Investigation values - ends

                                if (returnCode == 0 && IsdeviceApprove=="Y")
                                {
                                    BasePage bp = new BasePage();
                                    RoleID = bp.GetConfigValue("RoleForDevice", OrgID);
                                    ContextDetails contextInfo = new ContextDetails();
                                    ActionManager AM = new ActionManager(contextInfo);
                                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                    PageContextkey PC = new PageContextkey();
                                    PC.ID = Convert.ToInt64(0);
                                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                                    PC.RoleID = Convert.ToInt64(RoleID);
                                    PC.OrgID = OrgID;
                                    PC.PatientVisitID = ivid;
                                    PC.PageID = Convert.ToInt64(474);
                                    PC.ButtonName = "btnSaveToDispatch";
                                    PC.ButtonValue = "Save And Home";
                                    PC.ContextType = "P";
                                    lstpagecontextkeys.Add(PC);
                                    long res = -1;
                                    res = AM.PerformingNextStepNotification(PC, "", "");
                                }

                                //Return code for device
                                outputReturnCode = returnCode;
                            }


                            if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                            {
                                var completedstatus = lstPatientInv.FindAll(s => s.Status == "Completed");
                                if (lstPatientInv.Count > 0 && completedstatus.Count > 0)
                                {
                                    Patinvestasks = lstPatientInv;
                                    CreateTask(lstPatInvTestCode[0].ApprovedBy, lstPatInvTestCode[0].PatientVisitID, struid, intOrgID, 0, 0);
                                }
                            }
                        }
                        //Code for Group Processing
                        List<InvestigationMaster> lstIMG = new List<InvestigationMaster>();
                        List<InvIntegrationResultValue> lstRVG = new List<InvIntegrationResultValue>();
                        if (oInvIntegrationResult.LstIntegrationGroups.Count > 0)
                        {
                            InvIntegrationGroups olstIntegrationGrp;
                            for (int k = 0; k < oInvIntegrationResult.LstIntegrationGroups.Count; k++)
                            {
                                olstIntegrationGrp = new InvIntegrationGroups();
                                olstIntegrationGrp = oInvIntegrationResult.LstIntegrationGroups[k];
                                olstIntegrationGrp.ParentCode = oInvIntegrationResult.LstIntegrationGroups[k].ParentCode;
                                if (olstIntegrationGrp.LstResultValue.Count > 0)
                                {
                                    InvestigationMaster oIM;
                                    InvIntegrationResultValue oRV;
                                    string Barcode = strSampleInstanceID;
                                    string DeviceId = string.Empty;
                                    for (int l = 0; l < olstIntegrationGrp.LstResultValue.Count; l++)
                                    {
                                        oIM = new InvestigationMaster();
                                        oRV = new InvIntegrationResultValue();
                                        oRV.TestCode = olstIntegrationGrp.LstResultValue[l].TestCode;
                                        oRV.ResultValue = olstIntegrationGrp.LstResultValue[l].ResultValue;
                                        oRV.ResultUOM = olstIntegrationGrp.LstResultValue[l].ResultUOM;
                                        oIM.TestCode = olstIntegrationGrp.LstResultValue[l].TestCode;
                                        DeviceId = olstIntegrationGrp.LstResultValue[l].DeviceID;
                                        lstIMG.Add(oIM);
                                        lstRVG.Add(oRV);
                                    }
                                    if (returnCode == 0)
                                    {
                                        //Fetching matching InvestigationId for TestCode - begins
                                        returnCode = new IntegrationBL().GetTestCodeInvestigation(lstIMG, intOrgID, ivid, struid, Barcode, DeviceId, out lstPatInvTestCode);
                                        //Fetching matching InvestigationId for TestCode - ends
                                    }
                                    List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
                                    List<List<InvestigationValues>> lstlstInvestigationValues = new List<List<InvestigationValues>>();
                                    List<PatientInvestigation> lstReflexPatientInvestigation = new List<PatientInvestigation>();
                                    lstlstInvestigationValues.Clear();
                                    if (lstRVG.Count > 0)
                                    {
                                        InvestigationValues oIV;
                                        List<InvestigationValues> lstIV;
                                        List<PatientInvestigation> item;
                                        PatientInvestigation oPinv;
                                        PatientInvestigation oPinv1;
                                        foreach (InvIntegrationResultValue rvitem in lstRVG)
                                        {
                                            oIV = new InvestigationValues();
                                            lstIV = new List<InvestigationValues>();
                                            var lstPIItems = from Items in lstPatInvTestCode
                                                             where Items.PackageName == rvitem.TestCode
                                                             select Items;
                                            item = lstPIItems.ToList<PatientInvestigation>();
                                            if (item.Count > 0)
                                            {
                                                oIV.Name = item[0].InvestigationName;
                                                oIV.InvestigationID = item[0].InvestigationID;
                                                oIV.PatientVisitID = item[0].PatientVisitID;
                                                if (item[0].ResultValueType == "NTS")
                                                {
                                                    LabUtil oLabUtil = new LabUtil();
                                                    oIV.Value = oLabUtil.ReplaceNumberWithCommas(rvitem.ResultValue);
                                                }
                                                else
                                                {
                                                    oIV.Value = rvitem.ResultValue;
                                                }
                                                //oIV.Value = rvitem.ResultValue;
                                                oIV.UOMCode = rvitem.ResultUOM;
                                                oIV.CreatedBy = 0;
                                                oIV.GroupID = item[0].GroupID;
                                                oIV.GroupName = item[0].GroupName;
                                                oIV.Orgid = item[0].OrgID;
                                                if (string.IsNullOrEmpty(rvitem.DeviceErrorCode.ToString()))
                                                {
                                                    if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                                                    {
                                                        returnCodeGrp = InvBL.GetAutocompleteForGroupid(item[0].GroupID, OrgID, out lstInvOrgGroup);
                                                        InvID = item[0].InvestigationID;
                                                        OrgID = item[k].OrgID;
                                                        returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                                        if ((lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].AllowAutoComplete == true) || (item[0].GroupID == 0))
                                                        {
                                                            if (lstInvValueRangeMaster.Count > 0)
                                                            {
                                                                //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                                //{
                                                                if ((fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation)))
                                                                {
                                                                    oIV.Status = "Pending";
                                                                }
                                                                else
                                                                {
                                                                    oIV.Status = "Completed";
                                                                }

                                                            }
                                                            else
                                                            {
                                                                oIV.Status = "Completed";
                                                                //oIV.Status = "Pending";
                                                            }
                                                        }

                                                        else if (lstInvOrgGroup.Count == 0)
                                                        {
                                                            oIV.Status = "Completed";
                                                        }
                                                        else
                                                        {
                                                            oIV.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oIV.Status = "Pending";
                                                    }
                                                }
                                                else
                                                {
                                                    oIV.Status = "Pending";
                                                    InvID = item[0].InvestigationID;
                                                    OrgID = item[k].OrgID;
                                                    returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                                    if ((lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].AllowAutoComplete == true) || (item[0].GroupID == 0))
                                                    {
                                                        if (lstInvValueRangeMaster.Count > 0)
                                                        {
                                                            //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                            //{
                                                            if ((fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation)))
                                                            {
                                                                oIV.Status = "Pending";
                                                            }
                                                            else
                                                            {
                                                                oIV.Status = "Pending";
                                                            }

                                                        }
                                                        else
                                                        {
                                                            oIV.Status = "Pending";
                                                            //oIV.Status = "Pending";
                                                        }
                                                    }
                                                }
                                                oIV.DeviceID = rvitem.DeviceID;
                                                oIV.DeviceValue = rvitem.ResultValue;
                                                oIV.DeviceActualValue = rvitem.ResultValue;
                                                oIV.PackageID = item[k].PackageID;
                                                oIV.PackageName = item[k].PackageName;
                                                //IV.PackageID = PackageID;
                                                //IV.PackageName = PackageName;
                                                lstIV.Add(oIV);
                                                lstlstInvestigationValues.Add(lstIV);
                                                oPinv = new PatientInvestigation();
                                                oPinv.InvestigationID = item[0].InvestigationID;
                                                oPinv.PatientVisitID = item[0].PatientVisitID;
                                                if (string.IsNullOrEmpty(rvitem.DeviceErrorCode.ToString()))
                                                {
                                                    if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                                                    {
                                                        if ((lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].AllowAutoComplete == true) || (item[0].GroupID == 0))
                                                        {
                                                            if (lstInvValueRangeMaster.Count > 0)
                                                            {
                                                                //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                                //{
                                                                if ((fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation)))
                                                                {
                                                                    oPinv.Status = "Pending";
                                                                }
                                                                else
                                                                {
                                                                    oPinv.Status = "Completed";
                                                                }

                                                            }
                                                            else
                                                            {
                                                                oPinv.Status = "Completed";
                                                                //oPinv.Status = "Pending";
                                                            }
                                                        }
                                                        else if (lstInvOrgGroup.Count == 0)
                                                        {
                                                            oPinv.Status = "Completed";
                                                        }
                                                        else
                                                        {
                                                            oPinv.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oPinv.Status = "Pending";
                                                    }
                                                }
                                                else
                                                {
                                                    oPinv.Status = "Pending";
                                                    //oPinv.Status = "Pending";
                                                }
                                                //oPinv.Status = "Pending";
                                                oPinv.ReferenceRange = item[0].ReferenceRange;
                                                oPinv.Reason = item[0].Reason;
                                                oPinv.OrgID = item[0].OrgID;
                                                oPinv.AccessionNumber = item[0].AccessionNumber;
                                                oPinv.InvestigationValue = item[0].InvestigationValue;
                                                oPinv.GroupID = item[0].GroupID;
                                                lstPatientInv.Add(oPinv);
                                            }
                                        }
                                    }
                                    List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                                    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
                                    List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
                                    Investigation_BL oInvBl = new Investigation_BL();
                                    int returnStatus = -1;
                                    long pSCMID = -1;
                                    int deptID = Convert.ToInt32("0");
                                    //Preparing Data - Ends
                                    if (returnCode == 0)
                                    {
                                        //Inserting InvestigationValues History  - begins
                                        returnCode = new IntegrationBL().InsertInvestigationHistory(lstlstInvestigationValues, struid);
                                        //Inserting InvestigationValues History  - ends
                                    }
                                    if (returnCode == 0)
                                    {
                                        //Saving Investigation values - begins
                                        returnCode = oInvBl.SaveInvestigationResults(pSCMID, lstlstInvestigationValues, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, ivid, intOrgID, deptID, 0, struid, PageContextDetails, out returnStatus, lstReflexPatientInvestigation, isFromDevice,Lstpatattr);
                                        //Saving Investigation values - ends

                                        //Return code for device
                                        outputReturnCode = returnCode;
                                    }

                                    if (!string.IsNullOrEmpty(STATUSAll) && STATUSAll == "Y")
                                    {
                                        var completedstatus = lstPatientInv.FindAll(s => s.Status == "Completed");
                                        if (lstPatientInv.Count > 0 && completedstatus.Count > 0)
                                        {
                                            CreateTask(lstPatInvTestCode[0].PatientID, lstPatInvTestCode[0].PatientVisitID, struid, OrgID, 0, 0);
                                        }
                                    }
                                }
                            }
                        }
                        //}
                    }
                    //Inserting Investigation Values - Ends
                    //    rootScope.Complete();
                    //}
                }
                // Integration Result For loop - Ends
                TranStatus = 0;
            }
            else
                TranStatus = 5;
            //}
            //else
            //    TranStatus = 4;
        }
        catch (Exception ex)
        {
            TranStatus = -1;
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values (InsertInvIntegrationResult) in IntegrationWebservice", ex);

        }
        return outputReturnCode;
    }
    public bool GetRemarksCondition(List<MedicalRemarksRuleMaster> lstmedicalRemarks, long InvestigationID, string result, int OrgID, string pGender, string pAge,out long medInvestigationID,out long medAccessionNumber,out long MedRemarksID,out string RemarksText)
    {
        bool MedRemarksCondition = false;
        LabUtil oLabUtil = new LabUtil();
        OPIPBilling objopip = new OPIPBilling();
        medInvestigationID = 0;
        medAccessionNumber = 0;
        MedRemarksID = 0;
        RemarksText = "";
      if (lstmedicalRemarks != null && lstmedicalRemarks.Count > 0)
        {
            var MedicalRemarks = from Items in lstmedicalRemarks
                                 where Items.CrossParameterID == InvestigationID
                                 select Items;
         
            List<MedicalRemarksRuleMaster> meditem;
            meditem = MedicalRemarks.ToList<MedicalRemarksRuleMaster>();
            if (meditem.Count > 0)
            {
            medInvestigationID = meditem[0].InvestigationID;
            medAccessionNumber = meditem[0].InvAccessionNumber;
            MedRemarksID = meditem[0].RemarksID;
            string MedRemarksText = meditem[0].RemarksText;
            RemarksText = MedRemarksText;

                var LstFilterMedicalRemarks = from Items in lstmedicalRemarks
                                              where Items.InvestigationID == meditem[0].InvestigationID
                                              select Items;
                List<MedicalRemarksRuleMaster> medCalculation;
                medCalculation = LstFilterMedicalRemarks.ToList<MedicalRemarksRuleMaster>();
                for (int j = 0; j < medCalculation.Count; j++)
                {
                    string resultMedvalue;
                    if (medCalculation[j].CrossParameterID == InvestigationID)
                    {
                        resultMedvalue = result;
                    }
                    else
                    {
                        resultMedvalue = medCalculation[j].Value == string.Empty ? "" : medCalculation[j].Value;
                        resultMedvalue = oLabUtil.ConvertResultValue(resultMedvalue).ToString();
                    }
                    string AutoMedicalRemarks;
                    if (resultMedvalue != "")
                    {
                        AutoMedicalRemarks = objopip.CalculateMedicalComments(medCalculation[j].CrossParameterID, resultMedvalue, OrgID, pGender, pAge, Convert.ToInt32(medCalculation[j].RemarksID), medCalculation[j].RemarksText, medCalculation[j].Rule);
                    }
                    else
                    {
                        AutoMedicalRemarks = "";
                    }
                    if (AutoMedicalRemarks != "")
                    {
                        medCalculation[j].RemarksCondition = true;
                    }

                }
                for (int m = 0; m < medCalculation.Count; m++)
                {
                    if (m == 0)
                    {
                        MedRemarksCondition = medCalculation[m].RemarksCondition;
                    }

                    if (m > 0)
                    {
                        switch (medCalculation[m].Operator)
                        {
                            case "And":
                                MedRemarksCondition = (MedRemarksCondition && medCalculation[m].RemarksCondition);
                                break;
                            case "OR":
                                MedRemarksCondition = (MedRemarksCondition || medCalculation[m].RemarksCondition);
                                break;
                        }

                }
            }
        }
		}
        return MedRemarksCondition;

    }


    // Added by Velmurugan D | 12-May-2020 | Start //
    [WebMethod(EnableSession = true)]
    public long InsertInvIntegrationQCResult(List<InvIntegrationQCResult> lstInvIntegrationQCResult, int OrgID, int OrgAddressID)
    {
        long TranStatus = -1;
        Investigation_BL InvBL = new Investigation_BL();
        try
        {
            if (lstInvIntegrationQCResult.Count > 0)
            {
                PageContextkey PageContextDetails = new PageContextkey();

                // Integration Result For loop - Begins
                for (int p = 0; p < lstInvIntegrationQCResult.Count; p++)
                {
                    List<IntegrationHistory> lstIntegrationHistoryRawData = new List<IntegrationHistory>();
                    IntegrationHistory oIntHistory = new IntegrationHistory();
                    InvIntegrationQCResult oIntegrationQCResult = lstInvIntegrationQCResult[p];
                    string strSampleInstanceID = string.Empty;
                    // saving RAW data to Integration History - Begins
                    strSampleInstanceID = oIntegrationQCResult.SampleInstanceID;
                    string strIntegrationResultXML = Attune.Podium.Common.Utilities.ConvertToXML(lstInvIntegrationQCResult[p], typeof(InvIntegrationQCResult));
                    if (strIntegrationResultXML != string.Empty)
                    {
                        oIntHistory.IntegrationValue = strIntegrationResultXML;
                        oIntHistory.OrgID = OrgID;
                        oIntHistory.CreatedBy = -1;
                        oIntHistory.ExternalID = strSampleInstanceID;
                        oIntHistory.Type = "QCDeviceIntegration";
                        lstIntegrationHistoryRawData.Add(oIntHistory);
                    }
                    if (lstIntegrationHistoryRawData.Count > 0)
                    {
                        long returnCode = new IntegrationBL().SaveIntegrationData(lstIntegrationHistoryRawData);
                    }
                    // saving RAW data to Integration History - Ends

                    if (oIntegrationQCResult != null)
                    {
                        InvIntegrationQCResult oInvIntegrationQCResult = new InvIntegrationQCResult();
                        List<InvIntegrationQCResultValue> lstInvIntegrationQCResultValue = new List<InvIntegrationQCResultValue>();
                        oInvIntegrationQCResult = oIntegrationQCResult;
                        oInvIntegrationQCResult.SampleInstanceID = oIntegrationQCResult.SampleInstanceID;
                        if (oInvIntegrationQCResult.LstIntegrationQCResultValue.Count > 0)
                        {
                            InvIntegrationQCResultValue oRV;
                            for (int j = 0; j < oInvIntegrationQCResult.LstIntegrationQCResultValue.Count; j++)
                            {
                                oRV = new InvIntegrationQCResultValue();
                                oRV.TestCode = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].TestCode;
                                oRV.ResultValue = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].ResultValue;
                                oRV.ResultUOM = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].ResultUOM;
                                oRV.DeviceID = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].DeviceID;
                                oRV.DeviceErrorCode = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].DeviceErrorCode;
                                oRV.LotName = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].LotName;
                                oRV.QCLevel = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].QCLevel;
                                oRV.AddInfo = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].AddInfo;
                                oRV.AddInfoValue = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].AddInfoValue;
                                oRV.QCRange = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].QCRange;
                                oRV.QCStatus = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].QCStatus;
                                oRV.QCFiledRule = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].QCFiledRule;
                                oRV.ProcessedAt = oInvIntegrationQCResult.LstIntegrationQCResultValue[j].ProcessedAt;
                                lstInvIntegrationQCResultValue.Add(oRV);
                            }

                            if (lstInvIntegrationQCResultValue.Count > 0)
                            {
                                int returnStatus = 0;
                                TranStatus = InvBL.SaveInvestigationQCResults(strSampleInstanceID, OrgID, OrgAddressID, lstInvIntegrationQCResultValue, out returnStatus);
                            }

                            TranStatus = 0;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            TranStatus = -1;
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values (InsertInvIntegrationResult) in IntegrationWebservice", ex);
        }
        return TranStatus;
    }
    // Added by Velmurugan D | 12-May-2020 | QMS End //

    // Added by Velmurugan D | 21-May-2020 | QMS Start //

    [WebMethod(EnableSession = true)]
    public void GetQCResultValidationDetails(string DeviceID, string LotNumber, string TestCode, string Level, int OrgID, out List<QCResultValidationDetails> lstQCValidateDetails, out List<QCResultDetails> lstlotResults, out List<QCResultDetails> lstotherlotResults)
    {
        long result = 0;
        lstQCValidateDetails = new List<QCResultValidationDetails>();
        lstlotResults = new List<QCResultDetails>();
        lstotherlotResults = new List<QCResultDetails>();

        try
        {
            Investigation_BL InvBL = new Investigation_BL();
            result = InvBL.GetQCResultValidationDetails(DeviceID, LotNumber, TestCode, Level, OrgID, out lstQCValidateDetails, out lstlotResults, out lstotherlotResults);
        }
        catch (Exception excp)
        {
            CLogger.LogError("Error while executing SaveInvestigationQCResults in Investigation_BL", excp);
        }
        //result = InvBL.
        //return result;
    }
    // Added by Velmurugan D | 21-May-2020 | End //

    public bool ValidateAutoCertify(long investigationid, int orgid, long visitid, long groupid, string QCStatus, decimal DeltaLowerLimit, decimal DeltaHigherLimit, string value, string DeviceErrorCode, string Isabnormal, string IsAutoAuthorize, string DeviceID,bool AcrFlag, out List<InvestigationValues> lstInvvalues,out bool isTechneeded)
    {
        bool isautocertifyvalidate = false;
        isTechneeded = false;
        long returncode = -1;
        lstInvvalues = new List<InvestigationValues>();
        Investigation_BL obj = new Investigation_BL();
        List<InvAutoCertifyValidation> objInvAutoCertifyValidation = new List<InvAutoCertifyValidation>();
        List<InvAutoCertifyValidation> lstCrossInvAutoCertifyValidation = new List<InvAutoCertifyValidation>();
        try
        {
            returncode = obj.GetValidateAutoCertify(investigationid, orgid, visitid, groupid, out objInvAutoCertifyValidation, out lstCrossInvAutoCertifyValidation);
            if (objInvAutoCertifyValidation != null && objInvAutoCertifyValidation.Count > 0 && objInvAutoCertifyValidation[0].Isautocertify)
            {

                isTechneeded = objInvAutoCertifyValidation[0].IsTechnicianVerificationNeeded;
                if (objInvAutoCertifyValidation[0].Isautocertify && objInvAutoCertifyValidation[0].IsDeltavalue == false && objInvAutoCertifyValidation[0].IsAutoauthorizationrange == false && objInvAutoCertifyValidation[0].IsCriticalValue == false
                    && objInvAutoCertifyValidation[0].IsCrossParameterCheck == false && objInvAutoCertifyValidation[0].IsDeviceError == false && objInvAutoCertifyValidation[0].IsQCstatus == false)
                {
                    isautocertifyvalidate = true;

                }
                else
                {
                    isautocertifyvalidate = CheckAutoCertifyValidation(objInvAutoCertifyValidation[0], QCStatus, DeltaLowerLimit, DeltaHigherLimit, value, DeviceErrorCode, Isabnormal, IsAutoAuthorize);
                    bool isautocertifyvalidatecross = false;
                    if (objInvAutoCertifyValidation != null && objInvAutoCertifyValidation.Count > 0 && objInvAutoCertifyValidation[0].Isautocertify)
                    {

                        if (objInvAutoCertifyValidation[0].IsCrossParameterCheck)
                        {
                            if (lstCrossInvAutoCertifyValidation != null && lstCrossInvAutoCertifyValidation.Count > 0)
                            {
                                foreach (InvAutoCertifyValidation Pinv in lstCrossInvAutoCertifyValidation)
                                {
                                    if (Pinv.Isautocertify)
                                    {
                                        isautocertifyvalidatecross = CheckAutoCertifyValidation(Pinv, Pinv.QCStatus, Pinv.DeltaLowerLimit, Pinv.DeltaHigherLimit, Pinv.InvestigationValue, Pinv.DeviceErrorCode, Pinv.IsAbnormal, Pinv.IsAutoAuthorize);
                                        if (!isautocertifyvalidatecross)
                                        {
                                            isautocertifyvalidate = isautocertifyvalidatecross;
                                            break;
                                        }
                                    }
                                }
                            }
                            else
                            {
                                if ((objInvAutoCertifyValidation[0].Isautocertify || objInvAutoCertifyValidation[0].IsDeltavalue == true || objInvAutoCertifyValidation[0].IsAutoauthorizationrange == true || objInvAutoCertifyValidation[0].IsCriticalValue == true
                                 || objInvAutoCertifyValidation[0].IsCrossParameterCheck == true || objInvAutoCertifyValidation[0].IsDeviceError == true || objInvAutoCertifyValidation[0].IsQCstatus == true) && isautocertifyvalidate == false)
                                { isautocertifyvalidate = false; }
                                else
                                { isautocertifyvalidate = true; }
                            }

                        }
                        if (!objInvAutoCertifyValidation[0].IsDeviceError &&
                         !objInvAutoCertifyValidation[0].IsQCstatus &&
                         !objInvAutoCertifyValidation[0].IsCriticalValue &&
                         !objInvAutoCertifyValidation[0].IsDeltavalue &&
                         !objInvAutoCertifyValidation[0].IsAutoauthorizationrange && isautocertifyvalidatecross)
                        {
                            isautocertifyvalidate = isautocertifyvalidatecross;
                        }

                    }
                }
                if (isautocertifyvalidate)
                {
                    if (AcrFlag)
                    {
                        value = value + "~" + "N";
                    }
                    else
                    {
                        value = value + "~" + "Y";
                    }
                    if (objInvAutoCertifyValidation[0].IsGroupDependencies)
                    {
                        returncode = CalculateDependentTest(groupid, visitid, orgid, investigationid, value, DeviceID, out lstInvvalues);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While ValidateAutoCertify in IntegrationWebservice", ex);
        }
        return isautocertifyvalidate;
    }
    public bool CheckAutoCertifyValidation(InvAutoCertifyValidation objInvAutoCertifyValidation, string QCStatus, decimal DeltaLowerLimit, decimal DeltaHigherLimit, string value, string DeviceErrorCode, string Isabnormal, string IsAutoAuthorize)
    {
        bool isautocertify = false;
        if (objInvAutoCertifyValidation.IsDeltavalue)
        {
            if (DeltaLowerLimit == 0 && DeltaHigherLimit == 0)
            {
                isautocertify = true;
            }
            else
            {
                    isautocertify = ValidateDeltacheck(DeltaLowerLimit, DeltaHigherLimit, value);
                    if (isautocertify == false)
                    {
                        return isautocertify;
                    }
            }
        }
        
        if (objInvAutoCertifyValidation.IsQCstatus)
        {
            if (QCStatus != null && QCStatus != "Fail")
            {
                isautocertify = true;
            }
            else
            {
                isautocertify = false;
                return isautocertify;
            }
        }
        if (objInvAutoCertifyValidation.IsDeviceError)
        {
            if (!string.IsNullOrEmpty(DeviceErrorCode))
            {
                isautocertify = false;
                return isautocertify;
            }
            else
            {
                isautocertify = true;
            }
        }
        if (objInvAutoCertifyValidation.IsCriticalValue)
        {
            isautocertify = true;
            if (Isabnormal == "P")
            {
                isautocertify = false;
                return isautocertify;
            }
        }
        if (objInvAutoCertifyValidation.IsAutoauthorizationrange)
        {
            isautocertify = false;
            if (IsAutoAuthorize == "Y")
            {
                isautocertify = true;
            }
            else
            {
                isautocertify = false;
                return isautocertify;
            }
        }
        return isautocertify;
    }

    public bool ValidateDeltacheck(decimal DeltaLowerLimit, decimal DeltaHigherLimit, string deviceresult)
     {
         bool isautocertify = false;
         decimal val = 0;
         bool isNum = decimal.TryParse(deviceresult, out val);
         if (isNum)
         {
             if (val >= DeltaLowerLimit && val <= DeltaHigherLimit)
             {
                 isautocertify = true;

             }
         }
      
         return isautocertify;
     }
    public List<PatientInvestigation> ValidateReferenceRange(List<PatientInvestigation> lstPatientInvs, PatientInvestigation oPinv, PatientInvestigation item, string ResultValue, string Value, string DeviceID, string resultval2, List<PatientVisit> visitList)
    {
        List<PatientInvestigation> lstPatientInv = lstPatientInvs;
        try
        {
            string RoleID = "0";
            string result = string.Empty;
            int OrgID = oPinv.OrgID;
            LabUtil oLabUtil = new LabUtil();
            //convert xml to string and validate abnormal - added by mohan - begin
            string ReferenceRange;
            string OtherReferenceRange;
            string PatientAge = string.Empty;
            string PrintableRange = string.Empty;
            if (item.ReferenceRange != null && LabUtil.TryParseXml(item.ReferenceRange))
            {
                ConvertXmlToString(item.ReferenceRange, out ReferenceRange, out PatientAge, item.UOMCode, item.PatientVisitID, item.ApprovedBy, item.OrgID, out PrintableRange);
                oPinv.ReferenceRange = ReferenceRange;
                oPinv.PrintableRange = PrintableRange;
                //////if (!string.IsNullOrEmpty(ResultValue.Trim()))
                //////{
                //////    XElement xe = XElement.Parse(item.ReferenceRange);
                //////    var Range = from range in xe.Elements("resultsinterpretationrange").Elements("property")
                //////                select range;
                //////    if (Range != null && Range.Count() > 0)
                //////    {
                //////        //LabUtil oLabUtil = new LabUtil();
                //////        //string result = string.Empty;
                //////        string resultType = string.Empty;
                //////        decimal deviceValue = 0;
                //////        bool isNumericValue = false;
                //////        deviceValue = oLabUtil.ConvertResultValue(Value, out isNumericValue);
                //////        if (isNumericValue)
                //////        {
                //////            string[] lstAge = PatientAge.Split('~');
                //////            string gender = lstAge[0] != null ? lstAge[0] : string.Empty;
                //////            string age = lstAge[1] != null && lstAge[2] != null ? lstAge[1] + " " + lstAge[2] : string.Empty;
                //////            oLabUtil.ValidateInterpretationRange(item.ReferenceRange, gender, age, deviceValue, DeviceID, out result, out resultType);
                //////            if (result != string.Empty)
                //////            {
                //////                if (resultType == "Interpretation")
                //////                {
                //////                    Value = result;
                //////                }
                //////                else
                //////                {
                //////                    Value = result + "," + Value;
                //////                }
                //////            }
                //////        }
                //////    }
                //////}
                //////else
                //////{
                //////    oPinv.ReferenceRange = item.ReferenceRange;
                //////    oPinv.PrintableRange = string.Empty;
                //////}
                //convert xml to string and validate abnormal - added by mohan - end
                //
                if (!string.IsNullOrEmpty(ResultValue.Trim()))
                {
                    result = result == string.Empty ? resultval2 : result;
                    oPinv.IsAbnormal = validateAllRange(item.ReferenceRange + "|" + PatientAge + "|" + item.InvestigationID + "|" + resultval2 + "|" + "" + "|" + "" + "|" + "" + "|" + "text" + "|" + item.AutoApproveLoginID + "^");
                    oPinv.IsAutoAuthorize = validateAllRange1(item.ReferenceRange + "|" + PatientAge + "|" + item.InvestigationID + "|" + resultval2 + "|" + "" + "|" + "" + "|" + "" + "|" + "text" + "|" + item.AutoApproveLoginID + "^");
                }
                if (!string.IsNullOrEmpty(ResultValue.Trim()))
                {
                    if (visitList != null && visitList.Count > 0)
                    {
                        string pGender = visitList[0].Sex.ToString();
                        //Array pAgeRaw = visitList[0].PatientAge.Split(' ');
                        Array pAgeRaw = visitList[0].ReferenceRangeAge.Split(' ');

                        //pGender = pGender == "F" ? "Female" : "Male";
                        //string pAge = visitList[0].PatientAge.ToString();
                        string pAge = visitList[0].ReferenceRangeAge.ToString();

                        result = result == string.Empty ? resultval2 : result;
                        result = oLabUtil.ConvertResultValue(result).ToString();
                        CLogger.LogWarning("2" + result);
                        OPIPBilling objopip = new OPIPBilling();
                        oPinv.MedicalRemarks = objopip.GetMedicalComments(item.InvestigationID, result, OrgID, pGender, pAge);
                    }
                }
               
                //if ((oPinv.GroupID != 0 && oPinv.Status == "Completed" && lstInvOrgGroup.Count > 0 && lstInvOrgGroup[0].IsFormulaCalculateOnDevice == true))
                //{
                //    List<PatientInvestigation> lstp = new List<PatientInvestigation>();
                //    List<List<InvestigationValues>> lstlstiv = new List<List<InvestigationValues>>();
                //    fnCalculateCumputationField(oPinv, oIV, out lstp, out lstlstiv);
                //    foreach (var n in lstp)
                //    {
                //        lstPatientInv.Add(n);
                //    }
                //    foreach (var n in lstlstiv)
                //    {
                //        lstlstInvestigationValues.Add(n);
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            oPinv.ReferenceRange = item.ReferenceRange;
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values (Reference Range) in IntegrationWebservice", ex);
            Attune.Podium.Common.CLogger.LogInfo("Reference Range");
        }
        finally
        {

            lstPatientInv.Add(oPinv);

        }
        return lstPatientInv;
    }

    public long CalculateDependentTest(long groupid, long visitid, long orgid,long investigationid,string value,string deviceID,out List<InvestigationValues> lstInvValues)
    {
        lstInvValues = new List<InvestigationValues>();
        Investigation_BL InvBL = new Investigation_BL();
        InvBL.CalculateFormulatest(groupid, visitid, orgid, investigationid, value, deviceID, out lstInvValues);
        return 0;
    }

    [WebMethod(EnableSession = true)]
    public long InsertVitekIntegrationResult(List<InvIntegrationResult> lstInvIntegrationResult, int OrgID)
    {
        long outputReturnCode = -1;
        long TranStatus = -1;
        long InvID = 0;
        List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
        List<PatientInvestigationAttributes> Lstpatattr = new List<PatientInvestigationAttributes>();
        Investigation_BL InvBL = new Investigation_BL();
        try
        {
            string STATUSAll = string.Empty;
            string isFromDevice = "Y";
            STATUSAll = GetConfigValues("SampleStatusAllCompleted", OrgID);
            if (lstInvIntegrationResult.Count > 0)
            {
                PageContextkey PageContextDetails = new PageContextkey();

                List<string> lstSampleInstanceID = new List<string>();
                lstSampleInstanceID = (from IR in lstInvIntegrationResult
                                       select IR.SampleInstanceID).Distinct().ToList();
                List<InvIntegrationResult> lstIntegrationResult;
                List<IntegrationHistory> lstIntegrationHistoryRawData;
                long returnCode = -1;
                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                Role oRoleName = new Role();
                List<Role> lstRole = new List<Role>();
                IntegrationHistory oIntHistory;
                InvIntegrationResult oIntegrationResult;
                string strIntegrationResultXML;
                string suffixOrgBarcode;
                if (lstSampleInstanceID != null && lstSampleInstanceID.Count > 0)
                {
                    foreach (string oSampleInstanceID in lstSampleInstanceID)
                    {
                        lstIntegrationResult = (from IR in lstInvIntegrationResult
                                                where IR.SampleInstanceID == oSampleInstanceID
                                                select IR).Distinct().ToList();
                        if (lstIntegrationResult != null && lstIntegrationResult.Count > 0)
                        {
                            lstIntegrationHistoryRawData = new List<IntegrationHistory>();

                            for (int p = 0; p < lstIntegrationResult.Count; p++)
                            {
                                // saving RAW data to Integration History - Begins
                                strIntegrationResultXML = Attune.Podium.Common.Utilities.ConvertToXML(lstIntegrationResult[p], typeof(InvIntegrationResult));
                                if (!string.IsNullOrEmpty(strIntegrationResultXML))
                                {
                                    oIntHistory = new IntegrationHistory();
                                    oIntHistory.IntegrationValue = strIntegrationResultXML;
                                    oIntHistory.OrgID = OrgID;
                                    oIntHistory.CreatedBy = -1;
                                    oIntHistory.ExternalID = oSampleInstanceID;
                                    oIntHistory.Type = "DeviceIntegration";
                                    lstIntegrationHistoryRawData.Add(oIntHistory);
                                }
                            }
                            if (lstIntegrationHistoryRawData.Count > 0)
                            {
                                returnCode = new IntegrationBL().SaveIntegrationData(lstIntegrationHistoryRawData);
                            }
                            // saving RAW data to Integration History - Ends

                            //using (System.Transactions.TransactionScope rootScope = new System.Transactions.TransactionScope())
                            //{
                            //Extracting Investigation to PatientInvestigation - begins
                            long returnCod = -1;
                            long ivid = 0;
                            int vCount = 0;
                            int intOrgID = 0;
                            string struid = "";
                            int pOrderedCount = -1;
                            Investigation_BL oInvBL = new Investigation_BL();
                            List<PatientInvestigation> lstPatInvestigation = new List<PatientInvestigation>();
                            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                            List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                            List<InvDeptMaster> lstdeptList = new List<InvDeptMaster>();
                            List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();

                            suffixOrgBarcode = oSampleInstanceID + "#" + OrgID;
                            returnCod = new IntegrationBL().GetIntegrationVisitDetail(suffixOrgBarcode, out ivid, out vCount, out struid, out intOrgID);
                            returnCode = oInvBL.GetInvestigationSamplesCollect(ivid, intOrgID, 0, struid, 0, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out lstdeptList, out lstSampleContainer);

                            if (lstPatientInvestigation.Count > 0)
                            {
                                PatientInvestigation objInvest;
                                foreach (PatientInvestigation patient in lstPatientInvestigation)
                                {
                                    objInvest = new PatientInvestigation();
                                    objInvest.InvestigationID = patient.InvestigationID;
                                    objInvest.InvestigationName = patient.InvestigationName;
                                    objInvest.PatientVisitID = patient.PatientVisitID;
                                    objInvest.GroupID = patient.GroupID;
                                    objInvest.GroupName = patient.GroupName;
                                    objInvest.Status = patient.Status;
                                    objInvest.CollectedDateTime = patient.CreatedAt;
                                    objInvest.CreatedBy = 0;
                                    objInvest.Type = patient.Type;
                                    objInvest.OrgID = intOrgID;
                                    objInvest.InvestigationMethodID = 0;
                                    objInvest.KitID = 0;
                                    objInvest.InstrumentID = 0;
                                    objInvest.UID = patient.UID;
                                    objInvest.AutoApproveLoginID = patient.AutoApproveLoginID;
                                    lstPatInvestigation.Add(objInvest);
                                }
                            }
                            if (lstPatInvestigation.Count > 0 && vCount == 0)
                            {
                                //saving Patient Investigation

                                if (returnCode == 0)
                                {
                                    returnCode = new Investigation_BL().SavePatientInvestigation(lstPatInvestigation, intOrgID, struid, out pOrderedCount);
                                }
                            }
                            //Extracting Investigation to PatientInvestigation - Ends

                            //Inserting Investigation Values - Begins
                            //Preparing Data - Begins
                            InvestigationMaster oIM = new InvestigationMaster();
                            InvIntegrationResult oInvIntegrationResult = lstIntegrationResult[0];
                            List<InvestigationMaster> lstIM = new List<InvestigationMaster>();
                            string DeviceId = string.Empty;
                            List<PatientInvestigation> lstPatInvTestCode = new List<PatientInvestigation>();
                            InvIntegrationResultValue oInvIntegrationResultValue;
                            IntegrationBL oIntegrationBL = new IntegrationBL();
                            if (oInvIntegrationResult.LstIntegrationResultValue != null && oInvIntegrationResult.LstIntegrationResultValue.Count > 0)
                            {
                                oInvIntegrationResultValue = oInvIntegrationResult.LstIntegrationResultValue[0];
                                oIM.TestCode = oInvIntegrationResultValue.TestCode;
                                DeviceId = oInvIntegrationResultValue.DeviceID;
                                lstIM.Add(oIM);
                                //Fetching matching InvestigationId for TestCode - begins
                                if (returnCode == 0)
                                {
                                    returnCode = new IntegrationBL().GetTestCodeInvestigation(lstIM, intOrgID, ivid, struid, oSampleInstanceID, DeviceId, out lstPatInvTestCode);
                                }
                                //Fetching matching InvestigationId for TestCode - ends
                                if (lstPatInvTestCode != null && lstPatInvTestCode.Count > 0)
                                {
                                    PatientInvestigation oPatientInvestigation = lstPatInvTestCode[0];
                                    List<VitekDeviceIntegrationResult> UDTVitekDeviceIntegrationResult = new List<VitekDeviceIntegrationResult>();
                                    VitekDeviceIntegrationResult oVitekDeviceIntegrationResult;
                                    int resultCount = lstIntegrationResult.Count;
                                    int resultValueCount = 0;
                                    InvIntegrationResultValue objInvIntegrationResultValue;
                                    for (int i = 0; i < resultCount; i++)
                                    {
                                        resultValueCount = lstIntegrationResult[i].LstIntegrationResultValue.Count;
                                        for (int j = 0; j < resultValueCount; j++)
                                        {
                                            objInvIntegrationResultValue = lstIntegrationResult[i].LstIntegrationResultValue[j];
                                            oVitekDeviceIntegrationResult = new VitekDeviceIntegrationResult();
                                            oVitekDeviceIntegrationResult.VisitID = oPatientInvestigation.PatientVisitID;
                                            oVitekDeviceIntegrationResult.OrgID = intOrgID;
                                            oVitekDeviceIntegrationResult.GroupID = oPatientInvestigation.GroupID;
                                            oVitekDeviceIntegrationResult.InvestigationID = oPatientInvestigation.InvestigationID;
                                            oVitekDeviceIntegrationResult.OrganismName = objInvIntegrationResultValue.OrganismName;
                                            oVitekDeviceIntegrationResult.OrganismCode = objInvIntegrationResultValue.OrganismCode;
                                            oVitekDeviceIntegrationResult.DrugCode = objInvIntegrationResultValue.DrugCode;
                                            oVitekDeviceIntegrationResult.DrugName = objInvIntegrationResultValue.DrugName;
                                            oVitekDeviceIntegrationResult.Sensitivity = objInvIntegrationResultValue.Sensitivity;
                                            oVitekDeviceIntegrationResult.MicValue = objInvIntegrationResultValue.MicValue;
                                            oVitekDeviceIntegrationResult.CreatedBy = 0;
                                            oVitekDeviceIntegrationResult.CreatedAt = DateTime.Now;
                                            UDTVitekDeviceIntegrationResult.Add(oVitekDeviceIntegrationResult);
                                        }
                                    }
                                    if (UDTVitekDeviceIntegrationResult.Count > 0)
                                    {
                                        returnCode = oIntegrationBL.SaveVitekDeviceIntegrationResult(UDTVitekDeviceIntegrationResult);
                                    }
                                    List<VitekDeviceIntegrationResult> UVitekDeviceIntegrationResult = (from UDT in UDTVitekDeviceIntegrationResult.AsEnumerable()
                                                                                                        select new
                                                                                                        {
                                                                                                            VisitID = UDT.VisitID,
                                                                                                            OrgID = UDT.OrgID,
                                                                                                            InvestigationID = UDT.InvestigationID,
                                                                                                            GroupID = UDT.GroupID
                                                                                                        }).Distinct().Select(x => new VitekDeviceIntegrationResult() { VisitID = x.VisitID, OrgID = x.OrgID, InvestigationID = x.InvestigationID, GroupID = x.GroupID }).ToList();
                                    //List<VitekDeviceIntegrationResult> resultUVitekDeviceIntegrationResult = UVitekDeviceIntegrationResult.Distinct().ToList();
                                    List<VitekDeviceIntegrationResult> lstVitekDeviceIntegrationResult = new List<VitekDeviceIntegrationResult>();
                                    returnCode = oIntegrationBL.GetVitekDeviceIntegrationResult(UVitekDeviceIntegrationResult, out lstVitekDeviceIntegrationResult);
                                    string xmlResultValue = string.Empty;
                                    if (lstVitekDeviceIntegrationResult.Count > 0)
                                    {
                                        LabUtil oLabUtil = new LabUtil();
                                        xmlResultValue = oLabUtil.CreateOrganDrugDetailsXML(lstVitekDeviceIntegrationResult, oPatientInvestigation.InvestigationName, OrgID);
                                    }
                                    List<InvIntegrationResultValue> lstInvIntegrationResultValue = new List<InvIntegrationResultValue>();

                                    InvIntegrationResultValue oRV = new InvIntegrationResultValue();
                                    oRV.TestCode = oInvIntegrationResultValue.TestCode;
                                    oRV.ResultValue = xmlResultValue;
                                    oRV.ResultUOM = oInvIntegrationResultValue.ResultUOM;
                                    oRV.DeviceID = oInvIntegrationResultValue.DeviceID;

                                    lstInvIntegrationResultValue.Add(oRV);

                                    List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
                                    List<List<InvestigationValues>> lstlstInvestigationValues = new List<List<InvestigationValues>>();
                                    List<PatientInvestigation> lstReflexPatientInvestigation = new List<PatientInvestigation>();
                                    lstlstInvestigationValues.Clear();
                                    if (lstInvIntegrationResultValue.Count > 0)
                                    {
                                        InvestigationValues oIV;
                                        List<InvestigationValues> lstIV;
                                        List<PatientInvestigation> item;
                                        PatientInvestigation oPinv;
                                        foreach (InvIntegrationResultValue rvitem in lstInvIntegrationResultValue)
                                        {
                                            oIV = new InvestigationValues();
                                            lstIV = new List<InvestigationValues>();

                                            if (lstPatInvTestCode.Count > 0)
                                            {
                                                var lstPIItems = from Items in lstPatInvTestCode
                                                                 where Items.Migrated_TestCode == rvitem.TestCode
                                                                 select Items;
                                                item = lstPIItems.ToList<PatientInvestigation>();

                                                for (int k = 0; k < item.Count; k++)
                                                {
                                                    oIV.Name = item[k].InvestigationName;
                                                    oIV.InvestigationID = item[k].InvestigationID;
                                                    oIV.PatientVisitID = item[k].PatientVisitID;
                                                    oIV.Value = xmlResultValue;
                                                    oIV.DeviceValue = xmlResultValue;
                                                    oIV.DeviceActualValue = xmlResultValue;
                                                    oIV.UOMCode = null;
                                                    oIV.CreatedBy = 0;
                                                    oIV.GroupID = item[k].GroupID;
                                                    oIV.GroupName = item[k].GroupName;
                                                    oIV.PackageID = item[k].PackageID;
                                                    oIV.PackageName = item[k].PackageName;
                                                    oIV.Orgid = item[k].OrgID;
                                                    //oIV.Status = "Pending";
                                                    returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                                                    if (lstInvValueRangeMaster.Count > 0)
                                                    {
                                                        //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                        //{                                                            
                                                        if (fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation))
                                                        {
                                                            oIV.Status = "Pending";
                                                        }
                                                        else
                                                        {
                                                            oIV.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oIV.Status = "Pending";
                                                        //oIV.Status = "Pending";
                                                    }

                                                    oIV.DeviceID = rvitem.DeviceID;
                                                    lstIV.Add(oIV);
                                                    lstlstInvestigationValues.Add(lstIV);

                                                    oPinv = new PatientInvestigation();
                                                    oPinv.InvestigationID = item[k].InvestigationID;
                                                    oPinv.PatientVisitID = item[k].PatientVisitID;
                                                    oPinv.GroupID = item[k].GroupID;
                                                    //oPinv.Status = "Pending";
                                                    if (lstInvValueRangeMaster.Count > 0)
                                                    {
                                                        //if ((rvitem.ResultValue == lstInvValueRangeMaster[0].ValueRange) || (lstInvValueRangeMaster[0].ValueRange == ""))
                                                        //{
                                                        if ((fnValidateResulValue(rvitem.ResultValue, lstInvValueRangeMaster, out lstReflexPatientInvestigation)))
                                                        {
                                                            oPinv.Status = "Pending";
                                                        }
                                                        else
                                                        {
                                                            oPinv.Status = "Pending";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        oPinv.Status = "Pending";
                                                        //oPinv.Status = "Pending";
                                                    }
                                                    oPinv.AutoApproveLoginID = item[k].AutoApproveLoginID;
                                                    IsExcludeAutoApproval = item[k].RefSuffixText;
                                                    oPinv.Reason = item[k].Reason;
                                                    oPinv.OrgID = item[k].OrgID;

                                                    lstPatientInv.Add(oPinv);
                                                }
                                            }
                                        }
                                    }

                                    List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
                                    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
                                    List<PatientInvestigationFiles> lstlPFiles = new List<PatientInvestigationFiles>();
                                    Investigation_BL oInvBl = new Investigation_BL();
                                    int returnStatus = -1;
                                    long pSCMID = -1;
                                    int deptID = Convert.ToInt32("0");
                                    //Preparing Data - Ends

                                    if (returnCode == 0)
                                    {
                                        //Inserting InvestigationValues History  - begins
                                        returnCode = new IntegrationBL().InsertInvestigationHistory(lstlstInvestigationValues, struid);
                                        //Inserting InvestigationValues History  - ends
                                    }

                                    if (returnCode == 0)
                                    {
                                        //Saving Investigation values - begins
                                        if (lstlstInvestigationValues.Count > 0)
                                        {
                                            returnCode = oInvBl.SaveInvestigationResults(pSCMID, lstlstInvestigationValues, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lstlPFiles, ivid, intOrgID, deptID, 0, struid, PageContextDetails, out returnStatus, lstReflexPatientInvestigation, isFromDevice, Lstpatattr);

                                        }//Saving Investigation values - ends

                                        //Return code for device
                                        outputReturnCode = returnCode;
                                    }
                                }
                            }
                        }
                    }
                }
                // Integration Result For loop - Ends
                TranStatus = 0;
            }
            else
                TranStatus = 5;
            //}
            //else
            //    TranStatus = 4;
        }
        catch (Exception ex)
        {
            TranStatus = -1;
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values (InsertVitekIntegrationResult) in IntegrationWebservice", ex);

        }
        return outputReturnCode;
    }
    #endregion
#region RuleMaster
    public bool ValidateRuleMaster(long InvestigationId, string Value, string IsAbnormal, string Gender, string DeviceErrCode, List<PatientAgeGenderRule> lstPatientAgeGender, List<TestResultsRule> lstTestResults, List<MachineErrorRule> lstMachineError)
    {
        bool PAGFlag = false;
        bool RESFlag = false;
        bool MEFlag = false;
        bool Flag = false;
        try
        {
            if (lstPatientAgeGender.Count > 0)
            {
                PAGFlag = ValidatePatientAgeGenderRule(Gender, lstPatientAgeGender);
            }
            if (lstTestResults.Count > 0)
            {
                RESFlag = ValidateTestResultRule(InvestigationId, Value, IsAbnormal, lstTestResults);
            }
            if (lstMachineError.Count > 0)
            {
                MEFlag = ValidateMachineErrorRule(DeviceErrCode, lstMachineError);
            }
            if (lstPatientAgeGender.Count > 0 && lstTestResults.Count > 0 && lstMachineError.Count > 0)
            {
                if (PAGFlag && RESFlag && MEFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count > 0 && lstTestResults.Count == 0 && lstMachineError.Count == 0)
            {
                if (PAGFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count == 0 && lstTestResults.Count > 0 && lstMachineError.Count == 0)
            {
                if (RESFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count == 0 && lstTestResults.Count == 0 && lstMachineError.Count > 0)
            {
                if (MEFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count > 0 && lstTestResults.Count > 0 && lstMachineError.Count == 0)
            {
                if (PAGFlag && RESFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count == 0 && lstTestResults.Count > 0 && lstMachineError.Count > 0)
            {
                if (MEFlag && RESFlag)
                {
                    Flag = true;
                }
            }
            if (lstPatientAgeGender.Count > 0 && lstTestResults.Count == 0 && lstMachineError.Count > 0)
            {
                if (MEFlag && PAGFlag)
                {
                    Flag = true;
                }
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidatePatientAge in Integrationservice", ex);

        }

        return Flag;
    }
       
    public bool ValidatePatientAgeGenderRule(string Gender, List<PatientAgeGenderRule> lstPatientAgeGender)
    {
        bool flag = false;
        bool Pageflag = false;
        try
        {
            if (lstPatientAgeGender.Count > 0)
            {
                foreach (PatientAgeGenderRule objpage in lstPatientAgeGender)
                {
                    Pageflag = ValidatePatientAge(Gender, objpage);
                    if (Pageflag == false && (objpage.LogicalOperator == "0" || objpage.LogicalOperator.ToLower() == "and"))
                    {
                        flag = Pageflag;
                        break;
                    }
                    else if (Pageflag == true && objpage.LogicalOperator.ToLower() == "or")
                    {
                        flag = Pageflag;
                        break;
                    }
                    else
                    {
                        flag = Pageflag;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidatePatientAgeGenderRule in Integrationservice", ex);

        }
        return flag;
    }
    public bool ValidatePatientAge(string Gender, PatientAgeGenderRule objPatientAgeGender)
    {
        bool flag = false;
        double pAgedays = 0;
        double agedays1 = 0;
        double agedays2 = 0;
        double AgeValue1 = 0;
        double AgeValue2 = 0;
        LabUtil oLabUtil = new LabUtil();
        try
        {
            if (Gender == objPatientAgeGender.Gender.Trim() || objPatientAgeGender.Gender == "Both")
            {
                string[] CatagoryAge = objPatientAgeGender.Age.Split(' ');
                double pAge = Convert.ToDouble(CatagoryAge[0]);
                pAgedays = ConvertToDays(pAge, CatagoryAge[1]);

                AgeValue1 = Convert.ToDouble(objPatientAgeGender.AgeValue1);
                agedays1 = ConvertToDays(AgeValue1, objPatientAgeGender.AgeType);

                if (objPatientAgeGender.Agevalue2 != 0)
                {
                    AgeValue2 = Convert.ToDouble(objPatientAgeGender.Agevalue2);
                    agedays2 = ConvertToDays(AgeValue2, objPatientAgeGender.AgeType);
                }

                switch (objPatientAgeGender.AgeOptr)
                {
                    case "<":
                        if (pAgedays < agedays1)
                        {
                            flag = true;
                        }
                        break;
                    case "<=":
                        if (pAgedays <= agedays1)
                        {
                            flag = true;
                        }
                        break;
                    case "=":
                        if (pAgedays == agedays1)
                        {
                            flag = true;
                        }
                        break;
                    case "=>":
                        if (pAgedays >= agedays1)
                        {
                            flag = true;
                        }
                        break;
                    case ">":

                        if (pAgedays > agedays1)
                        {
                            flag = true;
                        }
                        break;
                    case "Between":
                        if (pAgedays >= agedays1 && pAgedays <= agedays2)
                        {
                            flag = true;
                        }
                        break;
                }

            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidatePatientAge in Integrationservice", ex);

        }
        return flag;
    }
    public bool ValidateTestResultRule(long InvestigationId, string Value, string IsAbnormal, List<TestResultsRule> lstTestResults)
    {
        bool flag = false;
        bool Testflag = false;
        try
        {
            if (lstTestResults.Count > 0)
            {
                foreach (TestResultsRule objTestres in lstTestResults)
                {
                    if (InvestigationId == objTestres.ResultInvestigationID)
                    {
                        Testflag = ValidateTestResult(Value, IsAbnormal, objTestres);
                    }
                    else
                    {
                        if (objTestres.ResultValue != "0")
                        {
                            string[] splt = objTestres.ResultInvestigation.Split('^');
                            if (splt.Count() > 1)
                            {
                                Testflag = ValidateTestResult(objTestres.ResultValue, splt[1], objTestres);
                            }
                        }
                        else
                        {
                            Testflag = false;
                        }
                    }
                    if (Testflag == false && (objTestres.LogicalOperator == "0" || objTestres.LogicalOperator.ToLower() == "and"))
                    {
                        flag = Testflag;
                        break;
                    }
                    else if (Testflag == true && objTestres.LogicalOperator.ToLower() == "or")
                    {
                        flag = Testflag;
                        break;
                    }
                    else
                    {
                        flag = Testflag;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidateTestResultRule in Integrationservice", ex);

        }

        return flag;
    }
    public bool ValidateTestResult(string Value, string IsAbnormal, TestResultsRule objTestResults)
    {
        bool flag = false;
        try
        {

            if (objTestResults.ResultType.Trim() == "RES")
            {
                switch (objTestResults.ResultOptr)
                {
                    case "Normal":
                        if (IsAbnormal == "N")
                        {
                            flag = true;
                        }
                        break;
                    case "Abnormal":
                        if (IsAbnormal == "L" || IsAbnormal == "A")
                        {
                            flag = true;
                        }
                        break;
                    case "Critical":
                        if (IsAbnormal == "P")
                        {
                            flag = true;
                        }
                        break;
                }
            }
            else
            {
                decimal numericResult;
                decimal numResult1;
                decimal numResult2;
                decimal.TryParse(Value, out numericResult);
                switch (objTestResults.ResultOptr)
                {
                    case "<":
                        decimal.TryParse(objTestResults.ResultValue1, out numResult1);
                        if (numericResult < numResult1)
                        {
                            flag = true;
                        }
                        break;
                    case "<=":
                        decimal.TryParse(objTestResults.ResultValue1, out numResult1);
                        if (numericResult <= numResult1)
                        {
                            flag = true;
                        }
                        break;
                    case "=":
                        Value = Value.ToString();
                        Value = Value.ToLower();
                        string CompareValue = (objTestResults.ResultValue1).ToString();
                        CompareValue = CompareValue.ToLower();
                        if (Value.Trim() == CompareValue.Trim())
                        {
                            flag = true;
                        }
                        break;
                    case "=>":
                        decimal.TryParse(objTestResults.ResultValue1, out numResult1);
                        if (numericResult >= numResult1)
                        {
                            flag = true;
                        }
                        break;
                    case ">":
                        decimal.TryParse(objTestResults.ResultValue1, out numResult1);
                        if (numericResult > numResult1)
                        {
                            flag = true;
                        }
                        break;
                    case "Between":
                        decimal.TryParse(objTestResults.ResultValue1, out numResult1);
                        decimal.TryParse(objTestResults.Resultvalue2, out numResult2);
                        if (numericResult >= numResult1 && numericResult <= numResult2)
                        {
                            flag = true;
                        }
                        break;
                }

            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidateTestResult in Integrationservice", ex);

        }
        return flag;
    }
    public bool ValidateMachineErrorRule(string DeviceErrCode, List<MachineErrorRule> lstMacErrorResults)
    {
        bool flag = false;
        bool Errflag = false;
        try
        {
            if (lstMacErrorResults.Count > 0 && DeviceErrCode != "")
            {
                foreach (MachineErrorRule objTestres in lstMacErrorResults)
                {
                    Errflag = ValidateMachineError(DeviceErrCode, objTestres);

                    if (Errflag == false && (objTestres.LogicalOperator == "0" || objTestres.LogicalOperator.ToLower() == "and"))
                    {
                        flag = Errflag;
                        break;
                    }
                    else if (Errflag == true && objTestres.LogicalOperator.ToLower() == "or")
                    {
                        flag = Errflag;
                        break;
                    }
                    else
                    {
                        flag = Errflag;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidateMachineErrorRule in Integrationservice", ex);

        }
        return flag;
    }
    public bool ValidateMachineError(string DeviceErrCode, MachineErrorRule objMachineerr)
    {
        bool flag = false;
        try
        {
            if (DeviceErrCode == objMachineerr.ErrorCode)
            {
                flag = true;
            }
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Inserting Device values ValidateMachineError in Integrationservice", ex);

        }
        return flag;
    }
    double ConvertToDays(double age, string agetype)
    {
        double ageInDays = 0;
        if (agetype == "Week(s)")
        {
            agetype = "Weeks";
        }
        else if (agetype == "Month(s)")
        {
            agetype = "Months";
        }
        else if (agetype == "Year(s)")
        {
            agetype = "Years";
        }
        else if (agetype == "Day(s)")
        {
            agetype = "Days";
        }

        switch (agetype)
        {
            case "Weeks":
                ageInDays = Math.Round(age * 7);
                break;
            case "Months":
                ageInDays = Math.Round(age * 30.416666667);
                break;
            case "Years":
                ageInDays = Math.Round(age * 365);
                break;
            case "Days":
                ageInDays = Math.Round(age);
                break;
        }
        return ageInDays;

    }

#endregion
    #region GetDeviceImportData

    [WebMethod]
    public void GetDeviceImportData(string date, int orgID, string Status, string DeviceID, out List<DeviceImportData> objImportData)
    {
        objImportData = new List<DeviceImportData>();

        new Investigation_BL().GetDeviceImportData(date, orgID, Status, DeviceID, out objImportData);
    }

    #endregion

    # region "Commemt code"

    //[WebMethod]
    //public void EditPatientDetails(PatientDetails Patient,PatientAddress PatientAddress)
    //{
    //    long returnCode = -1;
    //    List<IntegrationHistory> lstValue = new List<IntegrationHistory>();
    //    IntegrationHistory oHistory = new IntegrationHistory();

    //    try
    //    {
    //        string patientXML = Attune.Podium.Common.Utilities.ConvertToXML(Patient, typeof(PatientDetails));
    //        string AddressXML = Attune.Podium.Common.Utilities.ConvertToXML(PatientAddress, typeof(PatientAddress));
    //        if (patientXML != string.Empty)
    //        {
    //            oHistory = new IntegrationHistory();
    //            oHistory.IntegrationValue = patientXML;
    //            oHistory.OrgID = Patient.OrgID;
    //            oHistory.CreatedBy = -1;
    //            lstValue.Add(oHistory);
    //        }
    //        if (AddressXML != string.Empty)
    //        {
    //            oHistory = new IntegrationHistory();
    //            oHistory.IntegrationValue = AddressXML;
    //            oHistory.OrgID = Patient.OrgID;
    //            oHistory.CreatedBy = -1;
    //            lstValue.Add(oHistory);
    //        }
    //        if (lstValue.Count > 0)
    //        {
    //            returnCode = new IntegrationBL().SaveIntegrationData(lstValue);
    //        }
    //        returnCode = new Patient_BL().UpdatePatientDetailsForIntegration(Patient, PatientAddress);
    //    }
    //    catch (Exception ex)
    //    {
    //        Attune.Podium.Common.CLogger.LogError("Error While load EditPatientDetails Method in IntegrationWebservice", ex);
    //    }
    //}
    //[WebMethod]
    //public void EditVisitDetail(VisitDetails pVisit, List<InvestigationDetail> DeleteInvDetail, List<InvestigationDetail> AddInvDetail, long VisitID, int OrgID)
    //{
    //    long returnCode = -1;
    //    long pVisitID = -1;
    //    List<OrderedInvestigations> DelInvDetails = new List<OrderedInvestigations>();
    //    List<OrderedInvestigations> AddInvDetails = new List<OrderedInvestigations>();

    //    List<IntegrationHistory> lstValue = new List<IntegrationHistory>();
    //    IntegrationHistory oHistory = new IntegrationHistory();

    //    string VisitDetXML = Attune.Podium.Common.Utilities.ConvertToXML(pVisit, typeof(VisitDetails));
    //    string DelInvXML = Attune.Podium.Common.Utilities.ConvertToXML(DeleteInvDetail, typeof(List<InvestigationDetail>));
    //    string AddInvXML = Attune.Podium.Common.Utilities.ConvertToXML(AddInvDetail, typeof(List<InvestigationDetail>));

    //    if (VisitDetXML != string.Empty)
    //    {
    //        oHistory = new IntegrationHistory();
    //        oHistory.IntegrationValue = VisitDetXML;
    //        oHistory.OrgID = OrgID;
    //        oHistory.CreatedBy = -1;
    //        lstValue.Add(oHistory);
    //    }
    //    if (DelInvXML != string.Empty)
    //    {
    //        oHistory = new IntegrationHistory();
    //        oHistory.IntegrationValue = DelInvXML;
    //        oHistory.OrgID = OrgID;
    //        oHistory.CreatedBy = -1;
    //        lstValue.Add(oHistory);
    //    }
    //    if (AddInvXML != string.Empty)
    //    {
    //        oHistory = new IntegrationHistory();
    //        oHistory.IntegrationValue = AddInvXML;
    //        oHistory.OrgID = OrgID;
    //        oHistory.CreatedBy = -1;
    //        lstValue.Add(oHistory);
    //    }
    //    if (lstValue.Count > 0)
    //    {
    //        returnCode = new IntegrationBL().SaveIntegrationData(lstValue);
    //    }
    //    PatientVisit VisitDetails = new PatientVisit();
    //    VisitDetails.PriorityID = pVisit.PriorityID;
    //    VisitDetails.ReferingPhysicianID =  pVisit.ReferingPhysician.ReferingPhysicianID;
    //    VisitDetails.ReferingPhysicianName = pVisit.ReferingPhysician.PhysicianName;
    //    VisitDetails.HospitalID = pVisit.ReferinghospitalID;
    //    VisitDetails.HospitalName = pVisit.ReferingHospitalName;
    //    VisitDetails.ClientID = pVisit.ClientID;
    //    VisitDetails.ClientName = pVisit.ClientName;
    //    VisitDetails.CollectionCentreID = pVisit.CollectionCentreID;
    //    VisitDetails.CollectionCentreName = pVisit.CollectionCentreName;
    //    VisitDetails.ExternalVisitID = pVisit.ExternalVisitID;
    //    VisitDetails.VisitType = pVisit.VisitType;
    //    VisitDetails.OrgID = OrgID;// pVisit.OrgID;
    //    foreach (var OI in DeleteInvDetail)
    //    {
    //        OrderedInvestigations eOI = new OrderedInvestigations();
    //        eOI.ID = OI.ID;
    //        eOI.Type = OI.Type;
    //        eOI.Name = OI.Name;
    //        DelInvDetails.Add(eOI);
    //    }
    //    foreach (var OI in AddInvDetail)
    //    {
    //        OrderedInvestigations eOI = new OrderedInvestigations();
    //        eOI.ID = OI.ID;
    //        eOI.Type = OI.Type;
    //        eOI.Name = OI.Name;
    //        AddInvDetails.Add(eOI);
    //    }
    //    returnCode = new IntegrationBL().UpdateVisitDetails(VisitDetails);
    //    returnCode = new Investigation_BL().DeleteInvestigation(DelInvDetails, VisitID, OrgID, out pVisitID);
    //    string sGUID = System.Guid.NewGuid().ToString();
    //    if (pVisitID != -1)
    //    {
    //        if (AddInvDetails.Count > 0)
    //        {
    //            returnCode = new Investigation_BL().SaveOrderedInvestigation(AddInvDetails, OrgID, pVisitID, sGUID);
    //        }
    //    }
    //}
    # endregion

    #region GetBidirectionalBarCodes

    [WebMethod(EnableSession = true)]

    public List<BidirectionalBarcodes> GetBidirectionalBarCodes(DateTime FromDate, DateTime ToDate, int OrgID, string DeviceID)
    {
        long returncode = -1;
        List<BidirectionalBarcodes> lstBarCode = new List<BidirectionalBarcodes>();
        try
        {
            returncode = new IntegrationBL().GetBidirectionalBarCodeDetails(FromDate, ToDate, OrgID, DeviceID, out lstBarCode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBidirectionalBarCodes", ex.InnerException);
        }
        return lstBarCode;
    }

    #endregion

    #region UpdateBidirectionalBarCodes

    [WebMethod(EnableSession = true)]

    public long UpdateBidirectionalBarCodes(List<BidirectionalBarcodes> Barcode)
    {
        long returncode = -1;
        List<BidirectionalBarcodes> lstBarCode = Barcode;
        try
        {
            returncode = new IntegrationBL().UpdateBidirectionalBarCodeDetails(lstBarCode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBidirectionalBarCodes", ex.InnerException);
        }
        return returncode;
    }

    

    #endregion

    #region GetTestCodesForBarCodes

    [WebMethod(EnableSession = true)]
    public void GetTestCodesForBarCodes(string DeviceID, List<DeviceImportData> lstBarCode, string SecurityToken, out List<DeviceImportData> lstTestCode, out int TranStatus)
    {
        CLogger.LogInfo("Start GetTestCodesForBarCodes " + DeviceID);
        TranStatus = -1;
        lstTestCode = new List<DeviceImportData>();

        try
        {
            CLogger.LogInfo("start GetTestCodesForBarCodes DeviceID " + DeviceID + " Barcode Count " + lstBarCode.Count);
            new IntegrationBL().GetTestCodesForBarCodes(DeviceID, lstBarCode, out lstTestCode);
            CLogger.LogInfo("2 GetTestCodesForBarCodes Output Count " + lstTestCode.Count);
            TranStatus = 0;


            if (lstTestCode.Count > 0)
            {
                string STATUS = string.Empty;
                STATUS = GetConfigValues("DeviceLoadingStatus", lstTestCode[0].OrgID);

                if (!string.IsNullOrEmpty(STATUS) && STATUS == "Y")
                {
                    long Rcode = -1;
                    Rcode = new IntegrationBL().UpdateDeviceSampleStatus(lstTestCode[0].OrgID, lstTestCode[0].OrgAddressID, lstTestCode);
                }

            }
        }
        catch (Exception ex)
        {
            TranStatus = -1;
            CLogger.LogError("Error in GetTestCodesForBarCodes", ex.InnerException);
        }
    }
    #endregion

    #region Decimal Places
    public string DecimalPlace(string DeviceID, int investigationID, string value, long orgID)
    {
        string finalValue = value;

        long ReturnCode = -1;
        IntegrationBL BAL = new IntegrationBL();

        string Formula = "";
        try
        {
            ReturnCode = BAL.GetDeviceIntegrationFormula(orgID, DeviceID, investigationID, out Formula);

            if (!String.IsNullOrEmpty(Formula) && Formula.Length > 0)
            {
                Formula = Formula.Replace("[" + investigationID + "]", value);
                ExpressionFormula ExpFormula = new ExpressionFormula();
                finalValue = ExpFormula.ExpressionEvaluator(Formula);

            }

        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while GetValues in Expression Evaluator", ex);

        }
        return finalValue;
    }



    #endregion

    #region RoundOff
    public static double RoundDown(double valueToRound)
    {
        double floorValue = Math.Floor(valueToRound);
        if ((valueToRound - floorValue) >= .5)
        {
            return (floorValue + 1);
        }
        else
        {
            return (floorValue);
        }
    }
    #endregion

    #region Reference range Validation


    public void ConvertXmlToString(string xmlData, out string NormalReferenceRange, out string patientAge, string uom, long patientVisitID, long patientID, int OrgID, out string PrintableRange)
    {
        NormalReferenceRange = string.Empty;
        patientAge = string.Empty;
        string OtherReferenceRange = string.Empty;
        PrintableRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;

            Patient_BL patientBL = new Patient_BL();
            List<Patient> lstpatient = new List<Patient>();

            List<PatientVisit> visitList = new List<PatientVisit>();
            patientBL.GetLabVisitDetails(patientVisitID, OrgID, out visitList);
            if (visitList != null && visitList.Count > 0)
            {
                string pGender = visitList[0].Sex.ToString();
                Array pAgeRaw = visitList[0].PatientAge.Split(' ');

                pGender = !string.IsNullOrEmpty(pGender) && pGender != "0" ? (pGender == "F" ? "Female" : "Male") : string.Empty;
                string pAge = string.Empty;
                string pAgetype = string.Empty;
                if (pAgeRaw != null && pAgeRaw.Length > 0)
                {
                    pAge = pAgeRaw.GetValue(0).ToString();
                    if (pAgeRaw.Length > 1)
                    {
                        pAgetype = pAgeRaw.GetValue(1).ToString();
                    }
                }
                patientAge = pGender + "~" + pAge + "~" + pAgetype;

                LabUtil oLabUtil = new LabUtil();
                oLabUtil.ConvertXmlToString(xmlData, uom, visitList[0].Sex, visitList[0].PatientAge, out NormalReferenceRange, out OtherReferenceRange, out PrintableRange);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting reference range xml to string", ex);
        }
    }
    public void ConvertXmlToString1(string xmlData, out string ReferenceRange, out string patientAge, out string Agedays, string uom, long patientVisitID, long patientID, int OrgID, out string OtherReferenceRange)
    {
        ReferenceRange = string.Empty;
        patientAge = string.Empty;
        Agedays = "0";
        OtherReferenceRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;

            Patient_BL patientBL = new Patient_BL();
            List<Patient> lstpatient = new List<Patient>();

            List<PatientVisit> visitList = new List<PatientVisit>();
            patientBL.GetLabVisitDetails(patientVisitID, OrgID, out visitList);
            if (visitList != null && visitList.Count > 0)
            {
                string pGender = visitList[0].Sex.ToString();
                //Array pAgeRaw = visitList[0].PatientAge.Split(' ');
                Array pAgeRaw = visitList[0].ReferenceRangeAge.Split(' ');

                pGender = pGender == "F" ? "Female" : "Male";
                string pAge = pAgeRaw.GetValue(0).ToString();
                int pAgeint = Convert.ToInt32(pAge);
                string pAgetype = pAgeRaw.GetValue(1).ToString();

                patientAge = pGender + "~" + pAgeint + "~" + pAgetype;
                Agedays = visitList[0].AgeDays;
                LabUtil oLabUtil = new LabUtil();
                //oLabUtil.ConvertXmlToString(xmlData, uom, visitList[0].Sex, visitList[0].PatientAge, visitList[0].AgeDays, out ReferenceRange, out OtherReferenceRange);
                oLabUtil.ConvertXmlToString(xmlData, uom, visitList[0].Sex, visitList[0].ReferenceRangeAge, visitList[0].AgeDays, out ReferenceRange, out OtherReferenceRange);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting reference range xml to string", ex);
        }
    }
    private string validateAllRange(string rawDatas)
    {
        string RangeCode = "N";
        try
        {
            string txtControl = string.Empty;
            string textColor;

            string[] controlArryMain = rawDatas.Split('^');

            ArrayList testNamearr = new ArrayList();

            for (int i = 0; i < controlArryMain.Length - 1; i++)
            {
                string[] CatagoryxmlMain = controlArryMain[i].Split('|');

                if (LabUtil.TryParseXml(CatagoryxmlMain[0]))
                {
                    ValidateUserResult(controlArryMain[i], out textColor, out txtControl, out RangeCode);
                    if (RangeCode == "AutoA")
                    {
                        RangeCode = "A";
                    }
                    if (RangeCode == "AutoP")
                    {
                        RangeCode = "P";
                    }
                    if (RangeCode == "AutoL")
                    {
                        RangeCode = "L";
                    }
                    if (RangeCode != "A" && RangeCode != "L" && RangeCode != "P")
                    {
                        RangeCode = "N";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while validating reference range with device result value: ", ex);
        }
        return RangeCode;
    }
    private string validateAllRange1(string rawDatas)
    {
        string RangeCode = "N";
        try
        {
            string txtControl = string.Empty;
            string textColor;

            string[] controlArryMain = rawDatas.Split('^');

            ArrayList testNamearr = new ArrayList();

            for (int i = 0; i < controlArryMain.Length - 1; i++)
            {
                string[] CatagoryxmlMain = controlArryMain[i].Split('|');

                if (LabUtil.TryParseXml(CatagoryxmlMain[0]))
                {
                    ValidateUserResult(controlArryMain[i], out textColor, out txtControl, out RangeCode);
                    if (RangeCode == "AutoA" || RangeCode == "AutoP" || RangeCode == "AutoL" || RangeCode == "Autowhite" || textColor=="LightGreen")
                    {
                        RangeCode = "Y";
                    }
                    else
                    {
                        RangeCode = "N";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while validating reference range with device result value: ", ex);
        }
        return RangeCode;
    }


    public void ValidateUserResult(string xmlData, out string textColor, out string textControl, out string RangeCode)
    {
        textColor = "white";
        textControl = "";
        RangeCode = "white";
        LabUtil objlabutil = new LabUtil();
        List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
        long returnCode = new Investigation_BL().getReferencerangetype(OrgId, "en-GB" , out lstReferenceRangeType);

        string[] CatagoryAgeMain = xmlData.Split('|');



        Array userarr = CatagoryAgeMain[1].Split('~');
        string pGender = userarr.GetValue(0).ToString();
        string pAge = userarr.GetValue(1).ToString();
        string pAgetype = userarr.GetValue(2).ToString();
        string txtControl = CatagoryAgeMain[2].ToString();
        textControl = txtControl;
        try
        {

            objlabutil.ValidateResult(xmlData, IsExcludeAutoApproval, OrgId, out textColor, out RangeCode, lstReferenceRangeType);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while parsing reference range", ex);
        }
    }


    #endregion

    public bool IsNumeric(string s)
    {
        foreach (char c in s)
        {
            if (!char.IsDigit(c) && c != '.')
            {
                return false;
            }
        }

        return true;
    }
    #region PDF Stream Report
    [WebMethod]
    public long GetReport(int OrgID, string ExternalVisitID, string FromDate, string toDate, string PatientName, string TypeReport, string patientnumber, string pVisitNumber, out List<byte[]> bytes)
    {
        long returncode = -1;
        //OrgID = 67;
        bytes = new List<byte[]>();
        string AccessionNo = "";
        string TemplateName = "";
        //Attune.Podium.Common.CLogger.LogWarning("Visitid:venkt");
        string _Status = "Approve";
        try
        {

            if (TypeReport == "1")
            {
                _Status = "Approve";
            }
            else
            {
                _Status = "Approve";
            }

            List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
            List<PatientVisit> lstpatientVisit = new List<PatientVisit>();
            Attune.Solution.BusinessComponent.Patient_BL patientBL = new Patient_BL();
            returncode = patientBL.GetInvestigationOrgChange(ExternalVisitID, OrgID, FromDate, toDate, PatientName, patientnumber, pVisitNumber, out lstpatientVisit, out lstOrderinvestication);

            long pVisitID = 0;
            if (lstpatientVisit.Count > 0)
            {
                pVisitID = lstpatientVisit[0].PatientVisitId;
            }
            List<InvReportMaster> lstReport, lstReportName = new List<InvReportMaster>();
            List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
            patientBL.GetReportTemplate(pVisitID, OrgID,"", out lstReport, out lstReportName, out lstDpts);
            //patientBL.GetReportTemplate(pVisitID, OrgID, out lstReport, out lstReportName);


            foreach (InvReportMaster iReportMaste in lstReportName)
            {
                byte[] ReportByteArr = new byte[byte.MaxValue];

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
                    else
                    {
                        AccessionNo = string.Join(",", ((from p in lstReport
                                                         where p.TemplateID == iReportMaste.TemplateID
                                                         && p.Status.Contains(_Status)
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());

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
                else
                {
                    if (iReportMaste.TemplateID == 10)
                    {

                        AccessionNo = string.Join(",", ((from p in lstReport
                                                         where p.TemplateID == iReportMaste.TemplateID
                                                         && p.Status.Contains(_Status)
                                                         select p.AccessionNumber.ToString()).Distinct()).ToArray());
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
            returncode = 0;
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error while Loading SSRS dsd", ex.InnerException);
        }
        return returncode;
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
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    private bool ValidateToken(string SecurityToken)
    {
        try
        {
            long returnCode = -1;
            int returnStatus = 0;
            returnCode = new GateWay().CheckSecurityToken(SecurityToken, out returnStatus);
            if (returnStatus > 0)
                return true;
            else
                return false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Validate Security Token", ex.InnerException);
            return false;
        }
    }

    [WebMethod(EnableSession = true)]
    public int Authenticate(string userId, string password, int orgId, out string SecurityToken)
    {
        long returnCode = -1;
        SecurityToken = string.Empty;
        int TranStatus = -1;
        string encryptedPassword, IsLocked, DecryptedPassword;
        Login login, loggedIn;
        CCryptography objCryptography;
        GateWay gateWay;
        int OrgID = -1;
        try
        {
            encryptedPassword = IsLocked = DecryptedPassword = string.Empty;
            string IsExpired = string.Empty;
            string IsBlocked = string.Empty;
            string BlockedTo = string.Empty;
            login = new Login();
            login.LoginName = userId;

            objCryptography = new CCryptFactory().GetDecryptor();
            objCryptography.Crypt(password, out DecryptedPassword);
            password = DecryptedPassword;


            objCryptography = new CCryptFactory().GetEncryptor();
            objCryptography.Crypt(password, out encryptedPassword);
            login.Password = encryptedPassword;

            gateWay = new GateWay();
            loggedIn = new Login();
            returnCode = gateWay.AuthenticateUser(login, Session.SessionID, out loggedIn, out OrgID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo);

            if (loggedIn != null && loggedIn.LoginID > 0)
            {
                if (IsLocked == "N")
                {
                    Session["SecurityToken"] = Session.SessionID;
                    SecurityToken = Session.SessionID;
                    TranStatus = 0;
                }
                else
                    TranStatus = 2;
            }
            else
                TranStatus = 1;
        }
        catch (Exception ex)
        {
            TranStatus = -1;
            CLogger.LogError("Error in Authentication", ex.InnerException);
        }
        return TranStatus;
    }

    //[WebMethod(EnableSession = true)]
    public long Logoff(string SecurityToken)
    {
        long returnCode = -1;
        try
        {
            returnCode = new GateWay().DeleteLoggedInUserBySessionID(SecurityToken);
        }
        catch (Exception ex)
        {
            returnCode = -1;
            CLogger.LogError("Error in logout", ex.InnerException);
        }
        return returnCode;
    }

    [WebMethod(EnableSession = true)]

    public long RegisterPatient(int OrgID, int OrgAddressID, string ClientCode, string SecurityToken, string OrderDetails, out List<Status> StrStatus)
    {
        long returncode = -1;
          StrStatus = new List<Status>();
          Status objstatus = new Status();
 
        if (SecurityToken == "abc@123")
        {
        // List<PatientDetails> pdetails = new List<PatientDetails>();
        List<Patient> Patientdetails = new List<Patient>();
        List<ReferingPhysicianDetails> lstrefphy = new List<ReferingPhysicianDetails>();
       
        List<PatientAddress> lstPatientAddress = new List<PatientAddress>();
        List<OrderedInvestigations> lInvestigationList = new List<OrderedInvestigations>();
        List<VisitDetails> pVisit = new List<VisitDetails>();
            XDocument xdoc1 = new XDocument();


            try
            {
                CLogger.LogInfo(OrderDetails);
                if (!string.IsNullOrEmpty(OrderDetails))
                {
                    xdoc1 = XDocument.Parse(OrderDetails);

            Patientdetails = (from _Pdetails in xdoc1.Descendants("PID")

                              select new Patient
                             {

                                         PatientNumber = _Pdetails.Element("Patient_Id_Number").Value,
                                         Name = _Pdetails.Element("Patient_Name").Value,
                                         DOB = Convert.ToDateTime(this.Getdateofbirth(_Pdetails.Element("Date_Of_Birth").Value)),
                                         SEX = _Pdetails.Element("Gender_Code").Value,
                                         MartialStatus = _Pdetails.Element("Marital_Status_Code").Value,
                                         ExternalPatientNumber = _Pdetails.Element("Patient_Id_Number").Value,


                             }).ToList();



            Patient objPatientDetails = new Patient();
            foreach (var Patdetails in Patientdetails)
            {
                objPatientDetails.PatientNumber = Patdetails.PatientNumber;
                objPatientDetails.Name = Patdetails.Name;
                objPatientDetails.DOB = Patdetails.DOB;
                objPatientDetails.SEX = Patdetails.SEX;
                objPatientDetails.MartialStatus = Patdetails.MartialStatus;
                objPatientDetails.ExternalPatientNumber = Patdetails.ExternalPatientNumber;


            }

            string Age = GetAge(objPatientDetails.DOB);
            objPatientDetails.Age = Age;


                    lstPatientAddress = (from _paddress in xdoc1.Descendants("PID")
                                         select new PatientAddress
                                         {
                                             Add1 = _paddress.Element("Address1").Value,
                                             Add2 = _paddress.Element("Address2").Value,
                                             Add3 = this.Getcountrycode(_paddress.Element("Country_Code").Value),//In this field REUSE FOR GET Country Code 
                                             City = _paddress.Element("City").Value,
                                             StateName = _paddress.Element("State").Value,
                                             PostalCode = _paddress.Element("Postal_Code").Value,
                                             CountryCode = 0,
                                             //    CountryCode = Convert.ToInt32(this.Getcountrycode(_paddress.Element("Country_Code").Value)),
                                             // CountryCode = Convert.ToInt32(this.Getcountrycode(_paddress.Element("Country_Code").Value)),
                                             LandLineNumber = _paddress.Element("Phone_Home").Value,
                                             MobileNumber = _paddress.Element("Phone_Mobile").Value,

                                 }).ToList();




                    pVisit = (from _pvisitdetails in xdoc1.Descendants("PV1")
                              select new VisitDetails
                              {
                                  WardNo = _pvisitdetails.Element("Ward_Code").Value,
                                  //     CollectionCentreName = _pvisitdetails.Element("Attending_Doctor_Desc").Value,
                                  // ExternalVisitID = _pvisitdetails.Element("Preadmit_Number").Value,

                              }).ToList();

                    List<VisitDetails> pVisit1 = new List<VisitDetails>();
                    pVisit1 = (from _pvisitdetails in xdoc1.Descendants("ORC")
                               select new VisitDetails
                               {
                                   ExternalVisitID = _pvisitdetails.Element("ORC_Placer_Order_Number").Value,



                               }).ToList();
                    List<ReferingPhysicianDetails> prefPhy1 = new List<ReferingPhysicianDetails>();
                    prefPhy1 = (from _pvisitdetails in xdoc1.Descendants("ORC")
                                select new ReferingPhysicianDetails
                               {
                                   PhysicianCode = Convert.ToString(_pvisitdetails.Element("ORC_Ordering_Provider_ID").Value),
                                   PhysicianName = _pvisitdetails.Element("ORC_Ordering_Provider_Name").Value,



                       }).ToList();

            VisitDetails vdetails = new VisitDetails();
            foreach (var VisDetails in pVisit)
            {
                vdetails.WardNo = VisDetails.WardNo;

                vdetails.CollectionCentreName = VisDetails.CollectionCentreName;

            }

            VisitDetails vdetails1 = new VisitDetails();
            foreach (var VisDetails in pVisit1)
            {
                vdetails1.ExternalVisitID = VisDetails.ExternalVisitID;
            }
                    String PhysicianCode = "";
                    String PhysicianName = "";

                    foreach (var RefPhylst in prefPhy1)
                    {

                        PhysicianName = RefPhylst.PhysicianName;
                        PhysicianCode = RefPhylst.PhysicianCode;
                    }

                    lstrefphy = (from _refphy in xdoc1.Descendants("PV1")
                                 select new ReferingPhysicianDetails
                                 {
                                     //PhysicianName = _refphy.Element("Referring_Doctor_Desc").Value,
                                     //PhysicianCode = _refphy.Element("Referring_Doctor_Code").Value,
                                     PhysicianName = PhysicianName,
                                     PhysicianCode = PhysicianCode,
                                     OrgID = OrgID,
                                     Salutation = 14,
                                     AddressTypeID = 0,
                                     Address1 = "J.J.HOSPITAL,MADURAI.",
                                     City = "chennai",
                                     CountryID = 75,
                                     StateID = 31,
                                     EmailID = string.Empty,
                                     Phone = string.Empty,
                                     Mobile = string.Empty,
                                     IsCommunication = "N",
                                     FaxNumber = string.Empty,
                                     CreatedBy = 22801,
                                     ISDCode = 0,
                                     LoginName = "bose",
                                     Password = "abc@12"
                                 }).ToList();
                    ReferingPhysicianDetails refphy = new ReferingPhysicianDetails();
                    foreach (var refphysician in lstrefphy)
                    {
                        refphy.PhysicianName = refphysician.PhysicianName;
                        refphy.PhysicianCode = refphysician.PhysicianCode;
                        refphy.OrgID = refphysician.OrgID;
                        refphy.Salutation = refphysician.Salutation;
                        refphy.Address1 = refphysician.Address1;
                        refphy.City = refphysician.City;
                        refphy.CountryID = refphysician.CountryID;
                        refphy.StateID = refphysician.StateID;
                        refphy.EmailID = refphysician.EmailID;
                        refphy.Phone = refphysician.Phone;
                        refphy.Mobile = refphysician.Mobile;
                        refphy.IsCommunication = refphysician.IsCommunication;
                        refphy.FaxNumber = refphysician.FaxNumber;
                        refphy.CreatedBy = refphysician.CreatedBy;
                        refphy.ISDCode = refphysician.ISDCode;
                        refphy.LoginName = refphysician.LoginName;
                        refphy.Password = refphysician.Password;

            }



            lInvestigationList = (from _pinvestigationdetails in xdoc1.Descendants("OBR")
                                  select new OrderedInvestigations
                                  {
                                      //ID = Convert.ToInt32(_pinvestigationdetails.Element("Set_Id_OBR").Value),
                                      Name = _pinvestigationdetails.Element("Test_Name").Value,
                                      TestCode = _pinvestigationdetails.Element("Test_Code").Value,
                                      Status = this.GetStatus(_pinvestigationdetails.Element("Cancel_Reason_Code").Value),

                                  }).ToList();

            OrderedInvestigations invdetails = new OrderedInvestigations();
            foreach (var InvDetails in lInvestigationList)
            {
                invdetails.ID = InvDetails.ID;
                invdetails.Name = InvDetails.Name;
                invdetails.TestCode = InvDetails.TestCode;
                invdetails.Status = InvDetails.Status;

            }




            if (string.IsNullOrEmpty(objPatientDetails.Name))
            {

                returncode = GetErrorMsg("Name", OrgID, out StrStatus);
            }
            else if (objPatientDetails.DOB == DateTime.MinValue)
            {

                returncode = GetErrorMsg("Age", OrgID, out StrStatus);
            }
            else if (string.IsNullOrEmpty(objPatientDetails.SEX))
            {
                returncode = GetErrorMsg("Gender", OrgID, out StrStatus);

            }
            else if (string.IsNullOrEmpty(ClientCode))
            {
                returncode = GetErrorMsg("ClientCode", OrgID, out StrStatus);
            }
            else if (string.IsNullOrEmpty(invdetails.TestCode))
            {
                returncode = GetErrorMsg("TestCode", OrgID, out StrStatus);
            }
            else if (string.IsNullOrEmpty(refphy.PhysicianCode))
            {
                returncode = GetErrorMsg("Refferphysician", OrgID, out StrStatus);
            }
            else
            {

                // Client Save Start //
                long ClientID = 0;
                long Refferingphysicianid = 0;
                List<ClientDetails_Integration> pClientDetails = new List<ClientDetails_Integration>();
                ClientDetails_Integration Pclient = new ClientDetails_Integration();
                Pclient.ClientCode = ClientCode;
                Pclient.ClientName = "Integration Client";
                Pclient.ClientType = 1;
                Pclient.OrgId = OrgID;
                Pclient.ISCash = "N";

                        pClientDetails.Add(Pclient);
                        ClientSave(pClientDetails, out ClientID);
                        // Client Save End //
                        if (PhysicianName != "" && PhysicianName != null)
                        {
                            SaveReferringPhysician(lstrefphy, out Refferingphysicianid);
                        }
                        refphy.ReferingPhysicianID = Convert.ToInt32(Refferingphysicianid);
                        returncode = SavePatientBilling(objPatientDetails, lstPatientAddress, refphy, vdetails, vdetails1, lInvestigationList, ClientID, OrgID, OrgAddressID, out StrStatus);

                        if (returncode == 1)
                        {

                            objstatus.STATUS = "Saved sucessfully";
                            StrStatus.Add(objstatus);
                        }
                        else
                        {
                            objstatus.STATUS = "Patient visit not saved sucessfully";
                            StrStatus.Add(objstatus);
                        }

            }

        }
                else
                {
                    objstatus.STATUS = "Order Details should not empty";
                    StrStatus.Add(objstatus);
                }
            }

        catch (Exception ex)
        {
            CLogger.LogError("Error in IntegrationServices : RegisterPatient Method ", ex);
            }
        }
        else
        {
            returncode = -1;
            objstatus.STATUS = "Invalid Security Token";
            StrStatus.Add(objstatus);
        }


        return returncode;

    }
    private string GetAge(DateTime Dob)
    {
        string DateResult = string.Empty;
        if (Dob != DateTime.MinValue)
        {
            //DateTime Dob = Convert.ToDateTime(Dateofbirth);
            //decimal Age;
            //var today = DateTime.Today;
            //var a = (today.Year * 100 + today.Month) * 100 + today.Day;
            //var b = (Dob.Year * 100 + Dob.Month) * 100 + Dob.Day;
            //Age = (a - b) / 100;
            //decimal ExactAge = Age / 100;
            //string ExactAge1 = Convert.ToString(ExactAge.ToString("F2"));
            //string[] lstAge = ExactAge1.Split('.');
            //int Afterdecimal = Convert.ToInt32(lstAge[1]);
            //lstAge[1] = Convert.ToString(Afterdecimal);
            //AgeMonth = lstAge[0] + "." + lstAge[1] + " " + "Year(s)";


            DateTime Now = DateTime.Now;
            int Years = new DateTime(DateTime.Now.Subtract(Dob).Ticks).Year - 1;
            DateTime PastYearDate = Dob.AddYears(Years);
            int Months = 0;
            for (int i = 1; i <= 12; i++)
            {
                if (PastYearDate.AddMonths(i) == Now)
                {
                    Months = i;
                    break;
                }
                else if (PastYearDate.AddMonths(i) >= Now)
                {
                    Months = i - 1;
                    break;
                }
            }
            int Days = Now.Subtract(PastYearDate.AddMonths(Months)).Days;
            int Hours = Now.Subtract(PastYearDate).Hours;
            int Minutes = Now.Subtract(PastYearDate).Minutes;
            int Seconds = Now.Subtract(PastYearDate).Seconds;

            if (Years == 0)
            {
                if (Months == 0)
                {
                    DateResult = Convert.ToString(Days) + " Day(s)";
                }
                else
                {
                    DateResult = Convert.ToString(Months) + " Month(s)";
                }

            }
            else
            {
                DateResult = Convert.ToString(Years) + "." + Convert.ToString(Months) + " Year(s)";
            }
        }

        return DateResult;

    }
    private string GetStatus(string p)
    {
        string status = string.Empty;
        if (p == "CA")
        {
            status = "Cancel";
        }
        else
        {
            status = "Paid";

        }
        return status;
    }

    public long SavePatientBilling(Patient objPatientDetails, List<PatientAddress> lstPatientAddress, ReferingPhysicianDetails refphy, 
	VisitDetails vdetails, VisitDetails vdetails1, List<OrderedInvestigations> invdetails, long ClientID, int OrgID, int OrgAddressID, 
	out List<Status> StrStatus)
    {

        long returncode = -1, taskID = -1, PatientRoleID = 0, TodayVisitID = -1;
        int investigationid = 0, returnStatus = -1, needTaskDisplay = 0, Rateid = 0, LoginID = 0, Roleid = 0;
        decimal Rate = Decimal.Zero;
        decimal Rate1 = decimal.Zero;
        StrStatus = new List<Status>();
        string type = string.Empty;
        Patient objPatient = new Patient();


        string IntegrationLogin = GetConfigValues("IntegrationLogin", OrgID);
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        PatientDueChart objpatientduechart = new PatientDueChart();
        List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        OrderedInvestigations Investigationdetails = new OrderedInvestigations();
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        List<PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
        List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
        List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();

        //OrderedInvestigations Investigationdetails1 ;
        List<OrderedInvestigations> invdetails1 = new List<OrderedInvestigations>();
        string gUID = Guid.NewGuid().ToString();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        FinalBill objFinalBill = new FinalBill();
        VisitClientMapping vstclient = new VisitClientMapping();

        PageContextkey PageContextDetails1 = new PageContextkey();

        DataTable dtAmountReceivedDet = new DataTable();
        dtAmountReceivedDet = GetAmountReceivedDetails(Rate1);
        Patient_BL patbl = new Patient_BL();
        string StatFlag = string.Empty;
        string ClientFlag = string.Empty;
        string Iseditmode = string.Empty;



        objPatient.PatientNumber = objPatientDetails.PatientNumber;
        objPatient.Name = objPatientDetails.Name;
        objPatient.DOB = objPatientDetails.DOB;
        objPatient.SEX = objPatientDetails.SEX;
        objPatient.PatientAddress = lstPatientAddress;
        objPatient.PriorityID = "0";
        objPatient.OrgID = OrgID;
        objPatient.Age = objPatientDetails.Age;
        objPatient.MartialStatus = objPatientDetails.MartialStatus;
        objPatient.ReferingPhysicianID = refphy.ReferingPhysicianID;
        objPatient.ReferingPhysicianName = refphy.PhysicianName;
        objPatient.CreatedBy = Convert.ToInt64(IntegrationLogin);
        objPatient.VisitPurposeID = 3;
        objPatient.ExternalPatientNumber = objPatientDetails.ExternalPatientNumber;

        int patientCount = -1;
        List<Patient> lPatient = new List<Patient>();
        List<PatientVisit> LstPatientvisit = new List<PatientVisit>();
        IntegrationBL intbl = new IntegrationBL();
        returncode = intbl.GetRegistrationStatus_integration(objPatient.ExternalPatientNumber, vdetails1.ExternalVisitID, OrgID, out patientCount, out lPatient, out LstPatientvisit);

        foreach (var InvDetails in invdetails)
        {

            objpatientduechart = new PatientDueChart();
            Investigationdetails = new OrderedInvestigations();
            GetRateforInvestigation(InvDetails.TestCode, OrgID, ClientID, out investigationid, out Rate, out Rateid, out LoginID, out Roleid, out type);

            dtAmountReceivedDet = GetAmountReceivedDetails(Rate1);


            Investigationdetails.TestCode = InvDetails.TestCode;
            Investigationdetails.ID = investigationid;
            Investigationdetails.Name = InvDetails.Name;
            Investigationdetails.TestCode = InvDetails.TestCode;
            Investigationdetails.Status = InvDetails.Status;
            Investigationdetails.OrgID = OrgID;
            Investigationdetails.Type = type;
            Investigationdetails.UID = gUID;

            invdetails1.Add(Investigationdetails);


            objpatientduechart.FeeID = investigationid;
            objpatientduechart.FeeType = type;
            objpatientduechart.Description = InvDetails.Name;
            objpatientduechart.Amount = Rate;
            objpatientduechart.Unit = 1;
            objpatientduechart.Status = InvDetails.Status;
            objpatientduechart.OrgID = OrgID;
            objpatientduechart.RateID = Rateid;
            objpatientduechart.ClientID = ClientID;
            objpatientduechart.FromDate = DateTime.Now;
            objpatientduechart.ActualAmount = Rate;
            lstPatientDueChart.Add(objpatientduechart);

            Rate1 = Rate1 + Rate;

        }






        objFinalBill.GrossBillValue = Rate1;
        objFinalBill.NetValue = Rate;
        objFinalBill.OrgID = OrgID;
        objFinalBill.IsCreditBill = "Y";
        objFinalBill.OrgAddressID = OrgAddressID;
        objFinalBill.CreatedBy = 24107;

        vstclient.ClientID = ClientID;
        vstclient.RateID = Rateid;
        vstclient.PreAuthAmount = 0;
        vstclient.OrgID = OrgID;
        vstclient.IsCreditBill = "Y";

        lst.Add(vstclient);




        dtAmountReceivedDet = GetAmountReceivedDetails(Rate1);

        if (patientCount == 0 || (patientCount > 0 && LstPatientvisit.Count == 0))
        {

            Iseditmode = "N";

            if (patientCount == 0)
            {
                objPatient.PatientID = -1;

                returncode = patbl.InsertPatientBilling_Integration(objPatient, objFinalBill, refphy.ReferingPhysicianID,
                                                            0, 0, lstPatientDueChart, 0, "",
                                                            0, "", "", gUID, dtAmountReceivedDet, invdetails1, lstTaxDetails,
                                                            out lstBillingDetails, out returnStatus, 0, "", Roleid, LoginID, PageContextDetails1,
                                                            "Y", 0,
                                                            vdetails.WardNo, 0, 0, 0, 0, "", DateTime.Now, "", new List<ControlMappingDetails>(),
                                                            Iseditmode, out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID,
                                                           0, TodayVisitID, "", vdetails1.ExternalVisitID, "",
                                                             out taskID, "", lstPatientDiscount, "", "",
                                                            "", "", "", 0, "",
                                                            0, 0, 0, 0, 0, lstPatientRedemDetails,
                                                            lstPkgandGrps, StatFlag, ClientFlag, 0, "", "", "", "");
            }

            else if (patientCount > 0 && LstPatientvisit.Count == 0)
            {
                Patient objpatient = new Patient();
                foreach (var lstPatient in lPatient)
                {
                    objpatient.PatientID = lstPatient.PatientID;
                    objpatient.PatientNumber = lstPatient.PatientNumber;
                }

                objPatient.PatientID = objpatient.PatientID;
                objPatient.PatientNumber = objpatient.PatientNumber;

                returncode = patbl.InsertPatientBilling_Integration(objPatient, objFinalBill, refphy.ReferingPhysicianID,
                                                       0, 0, lstPatientDueChart, 0, "",
                                                       0, "", "", gUID, dtAmountReceivedDet, invdetails1, lstTaxDetails,
                                                       out lstBillingDetails, out returnStatus, 0, "", Roleid, LoginID, PageContextDetails1,
                                                       "Y", 0,
                                                       vdetails.WardNo, 0, 0, 0, 0, "", DateTime.Now, "", new List<ControlMappingDetails>(),
                                                       Iseditmode, out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID,
                                                      0, TodayVisitID, "", vdetails1.ExternalVisitID, "",
                                                        out taskID, "", lstPatientDiscount, "", "",
                                                       "", "", "", 0, "",
                                                       0, 0, 0, 0, 0, lstPatientRedemDetails,
                                                       lstPkgandGrps, StatFlag, ClientFlag, 0, "", "", "", "");
            }
        }
        else
        {
            Iseditmode = "Y";

            Patient objpatient = new Patient();
            foreach (var lstPatient in lPatient)
            {
                objpatient.PatientID = lstPatient.PatientID;
            }

            objPatient.PatientID = objpatient.PatientID;

            returncode = patbl.InsertPatientBilling_Integration(objPatient, objFinalBill, refphy.ReferingPhysicianID,
                                                        0, 0, lstPatientDueChart, 0, "",
                                                        0, "", "", gUID, dtAmountReceivedDet, invdetails1, lstTaxDetails,
                                                        out lstBillingDetails, out returnStatus, 0, "", Roleid, LoginID, PageContextDetails1,
                                                        "N", 0,
                                                        vdetails.WardNo, 0, 0, 0, 0, "", DateTime.Now, "", new List<ControlMappingDetails>(),
                                                        Iseditmode, out needTaskDisplay, lstDispatchDetails, lst, out PatientRoleID,
                                                       0, TodayVisitID, "", vdetails1.ExternalVisitID, "",
                                                         out taskID, "", lstPatientDiscount, "", "",
                                                        "", "", "", 0, "",
                                                        0, 0, 0, 0, 0, lstPatientRedemDetails,
                                                        lstPkgandGrps, StatFlag, ClientFlag, 0, "", "", "", "");
        }


        return returncode;
    }



    public DataTable GetAmountReceivedDetails(decimal Rate1)
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
        string sNewDatas = "";
        foreach (string row in sNewDatas.Split('|'))
        {
            _datarow = _datatable.NewRow();
            _datarow["OtherCurrencyAmount"] = Rate1;
            _datarow["ChequeorCardNumber"] = string.Empty;
            _datarow["BankNameorCardType"] = string.Empty;
            _datarow["Remarks"] = string.Empty;
            _datarow["TypeID"] = 1;
            _datarow["ChequeValidDate"] = Convert.ToDateTime(DateTime.Now);
            _datarow["ServiceCharge"] = 0;
            _datarow["AmtReceived"] = Rate1;
            _datarow["EMIROI"] = 0;
            _datarow["EMITenor"] = 0;
            _datarow["EMIValue"] = 0;
            _datarow["ReferenceID"] = 0;
            _datarow["ReferenceType"] = string.Empty;
            _datarow["Units"] = 0;
            _datarow["CardHolderName"] = string.Empty;
            _datarow["EMIOpted"] = string.Empty;
            _datarow["BaseCurrencyID"] = 0;
            _datarow["PaidCurrencyID"] = 0;
            _datarow["CashGiven"] = 0;
            _datarow["BalanceGiven"] = 0;
            _datarow["TransactionID"] = string.Empty;
            _datarow["BranchName"] = string.Empty;
            _datarow["PaymentCollectedFrom"] = string.Empty;
            _datarow["IsOutStation"] = "";
            _datarow["AmtReceivedID"] = 0;
            _datarow["AuthorisationCode"] = string.Empty;

            _datatable.Rows.Add(_datarow);
        }

        return _datatable;
    }

    public void GetRateforInvestigation(string p, int OrgId, long ClientID, out int investigationid, out decimal Rate, out int Rateid, out int LoginID, out int Roleid, out string type)
    {


        IntegrationBL integBL = new IntegrationBL();

        string Testcode = string.Empty;
        Testcode = p;
        investigationid = 0;
        Rate = decimal.Zero;
        type = string.Empty;
        integBL.GetRateforInvestigation(Testcode, OrgId, ClientID, out investigationid, out Rate, out Rateid, out LoginID, out Roleid, out type);


    }



    private string Getcountrycode(string p)
    {
        string countrrcode = string.Empty;
        if (p == "")
        {
            countrrcode = null;
        }
        else
        {
            countrrcode = p;
        }
        return countrrcode;
    }

    private long GetErrorMsg(string p, int OrgId, out List<Status> lststatus)
    {


        long returnmsg = -1;

        IntegrationBL integBL = new IntegrationBL();

        returnmsg = integBL.GetIntegrationError(p, OrgId, out lststatus);


        return returnmsg;

    }



    private DateTime Getdateofbirth(string p)
    {
        DateTime DateOFBirth;
        if (p != "")
        {
            int year = int.Parse(p.Substring(0, 4));
            int month = int.Parse(p.Substring(4, 2));
            int day = int.Parse(p.Substring(6, 2));

            DateOFBirth = new DateTime(year, month, day);

        }
        else
        {

            DateOFBirth = DateTime.MinValue;

        }



        return DateOFBirth;

    }
    public Boolean fnValidateResulValue(string resultValue, List<InvValueRangeMaster> lstInvValueRangeMaster, out List<PatientInvestigation> lstReflexPatientInvestigation)
    {
        Boolean result = false;
        lstReflexPatientInvestigation = new List<PatientInvestigation>();
        try
        {
            LabUtil obj = new LabUtil();
            Boolean ISNumericResultValue = false;
            Decimal ResultValueS = 0;
            ResultValueS = obj.ConvertResultValue(resultValue, out ISNumericResultValue);
            foreach (var item in lstInvValueRangeMaster)
            {
                PatientInvestigation objpinv = new PatientInvestigation();
                switch (item.Range)
                {
                    case "EQ":
                        if (resultValue.ToLower().Trim() == item.ValueRange.ToLower().Trim())
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "NEQ":
                        if (resultValue.ToLower().Trim() != item.ValueRange.ToLower().Trim())
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "LT":
                        if (ResultValueS < Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "GT":
                        if (ResultValueS > Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "LTEQ":
                        if (ResultValueS <= Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "GTEQ":
                        if (ResultValueS >= Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "BTW":
                        string[] resultval = item.ValueRange.Split('-');
                        if ((Convert.ToDecimal(resultval[0]) <= ResultValueS) && (ResultValueS <= Convert.ToDecimal(resultval[1])))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    default:
                        //result = false;
                        result = result == true ? true : false;
                        break;
                }
                lstReflexPatientInvestigation.Add(objpinv);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public void fnCalculateCumputationField(PatientInvestigation opinv, InvestigationValues oinv, out List<PatientInvestigation> lstpinv, out List<List<InvestigationValues>> lstlstInv)
    {
        long rtnCode = 0;
        Investigation_BL InvBL = new Investigation_BL();
        List<PatientInvestigation> lstDependentinv = new List<PatientInvestigation>();
        List<PatientInvestigation> lstPatientinv = new List<PatientInvestigation>();
        List<PatientInvestigation> lstpatinv = new List<PatientInvestigation>();
        lstpinv = new List<PatientInvestigation>();
        lstlstInv = new List<List<InvestigationValues>>();
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        ArrayList arr = new ArrayList();
        int OrgID = opinv.OrgID;
        LabUtil objLabUtil = new LabUtil();
        try
        {
            lstpatinv.Add(opinv);
            rtnCode = InvBL.GetDependentInvestigationdetails(opinv.PatientVisitID, opinv.OrgID, lstpatinv, out lstDependentinv, out lstPatientinv);
            if (lstDependentinv.Count > 0 && lstPatientinv.Count > 0)
            {
                Dictionary<long, string> oDict = new Dictionary<long, string>();
                foreach (var p in lstPatientinv)
                {
                    oDict[p.InvestigationID] = objLabUtil.ConvertResultValue(p.Value).ToString();
                    //oDict[p.InvestigationID] = p.Value;
                }
                //oDict[oinv.InvestigationID] = oinv.Value;
                oDict[oinv.InvestigationID] = objLabUtil.ConvertResultValue(oinv.Value).ToString();
                string ValidationRule = lstPatientinv[0].ValidationRule;
                string[] valRule = ValidationRule.Split('^');
                int valLength = valRule.Length;
                PatientInvestigation oPinv;
                InvestigationValues oIV;
                for (int k = 0; k < valLength; k++)
                {
                    string finalValue = string.Empty;
                    string formula = string.Empty;
                    string pattern = @"\[(.*?)\]";
                    string[] invid = valRule[k].Split('=');
                    string childinvid = invid[0].Replace("[", "").Replace("]", "");
                    string parentinv = invid[1];
                    var parentinvid = Regex.Matches(parentinv, pattern);
                    oPinv = new PatientInvestigation();
                    List<PatientInvestigation> item;
                    long childinvid1 = Convert.ToInt64(childinvid);
                    var lstPIItems = from Items in lstDependentinv
                                     where Items.InvestigationID == childinvid1
                                     select Items;
                    item = lstPIItems.ToList<PatientInvestigation>();

                    if (lstPIItems.Count() > 0)
                    {
                        try
                        {

                            foreach (Match m in parentinvid)
                            {
                                long id = Convert.ToInt64(m.Groups[1].Value);
                                string parentinv1 = parentinv.Replace("[" + id + "]", oDict[id].ToString());
                                parentinv = parentinv1;
                            }
                            int index = parentinv.IndexOf("toFixed");
                            if (index > -1)
                                formula = parentinv.Remove(index - 1, 11);
                            else
                                formula = parentinv;
                            if (item[0].DecimalPlaces != null && item[0].DecimalPlaces != "")
                            {
                                formula = "Round(" + formula + "," + item[0].DecimalPlaces + ")";
                            }
                            else
                            {
                                formula = "Round" + formula + "";
                            }
                            //parentinv = parentinv.Replace(@"[",oDict[");
                            ExpressionFormula ExpFormula = new ExpressionFormula();
                            finalValue = ExpFormula.ExpressionEvaluator(formula);
                            //Expression ExpFormula1 = new Expression(formula);
                            //finalValue = ExpFormula1.Evaluate().ToString();



                            oPinv.InvestigationID = item[0].InvestigationID;
                            oPinv.PatientVisitID = item[0].PatientVisitID;
                            oPinv.Status = "Completed";
                            oPinv.AutoApproveLoginID = item[0].AutoApproveLoginID;
                            IsExcludeAutoApproval = item[0].RefSuffixText;

                            oPinv.Reason = item[0].Reason;
                            oPinv.OrgID = item[0].OrgID;
                            //Added By Prasanna.S
                            oPinv.AccessionNumber = item[0].AccessionNumber;
                            oPinv.InvestigationValue = item[0].InvestigationValue;
                            oPinv.GroupID = item[0].GroupID;
                            string result = string.Empty;
                            oIV = new InvestigationValues();
                            try
                            {
                                //convert xml to string and validate abnormal - added by mohan - begin
                                string ReferenceRange;
                                string OtherReferenceRange;
                                string PatientAge = string.Empty;
                                if (item[0].ReferenceRange != null && LabUtil.TryParseXml(item[0].ReferenceRange))
                                {
                                    ConvertXmlToString1(item[0].ReferenceRange, out ReferenceRange, out PatientAge, out Agedays, item[0].UOMCode, item[0].PatientVisitID, item[0].ApprovedBy, item[0].OrgID, out OtherReferenceRange);
                                    oPinv.ReferenceRange = ReferenceRange;
                                    oPinv.ConvReferenceRange = OtherReferenceRange;
                                    //convert xml to string and validate abnormal - added by mohan - end
                                    //
                                    //result = result == string.Empty ? resultval2 : result;
                                    //}
                                    //else
                                    //{
                                    //    oPinv.ReferenceRange = item[0].ReferenceRange;
                                    //}

                                    XElement xe = XElement.Parse(item[0].ReferenceRange);
                                    var Range = from range in xe.Elements("resultsinterpretationrange").Elements("property")
                                                select range;
                                    if (Range != null && Range.Count() > 0)
                                    {
                                        //LabUtil oLabUtil = new LabUtil();
                                        string resultType = string.Empty;
                                        decimal deviceValue = 0;
                                        deviceValue = objLabUtil.ConvertResultValue(finalValue);
                                        string[] lstAge = PatientAge.Split('~');
                                        string gender = lstAge[0] != null ? lstAge[0] : string.Empty;
                                        string age = lstAge[1] != null && lstAge[2] != null ? lstAge[1] + " " + lstAge[2] : string.Empty;
                                        objLabUtil.ValidateInterpretationRange(item[0].ReferenceRange, gender, age, deviceValue, oIV.DeviceID, out result, out resultType);
                                        if (result != string.Empty)
                                        {
                                            if (resultType == "Interpretation")
                                            {
                                                oIV.Value = result;
                                            }
                                            else
                                            {
                                                oIV.Value = result + "," + oIV.Value;
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    oPinv.ReferenceRange = item[0].ReferenceRange;
                                }
                                finalValue = result == string.Empty ? finalValue : result;
                                oPinv.IsAbnormal = validateAllRange(item[0].ReferenceRange + "|" + PatientAge + "|" + item[0].InvestigationID + "|" + finalValue + "|" + "" + "|" + "" + "|" + "" + "|" + "text" + "|" + item[0].AutoApproveLoginID + "^");

                                //try
                                //{
                                //if (PatientAge == string.Empty)
                                //{
                                Patient_BL patientBL = new Patient_BL();
                                List<PatientVisit> visitList = new List<PatientVisit>();
                                patientBL.GetLabVisitDetails(item[0].PatientVisitID, OrgID, out visitList);
                                if (visitList != null && visitList.Count > 0)
                                {
                                    string pGender = visitList[0].Sex.ToString();
                                    //Array pAgeRaw = visitList[0].PatientAge.Split(' ');
                                    Array pAgeRaw = visitList[0].ReferenceRangeAge.Split(' ');

                                    //pGender = pGender == "F" ? "Female" : "Male";
                                    //string pAge = visitList[0].PatientAge.ToString();
                                    string pAge = visitList[0].ReferenceRangeAge.ToString();
                                    string rvalue = string.Empty;
                                    rvalue = objLabUtil.ConvertResultValue(finalValue).ToString();
                                    OPIPBilling objopip = new OPIPBilling();
                                    oPinv.MedicalRemarks = objopip.GetMedicalComments(item[0].InvestigationID, rvalue, OrgID, pGender, pAge);
                                }
                                lstpinv.Add(oPinv);



                                oIV.Name = item[0].InvestigationName;
                                oIV.InvestigationID = item[0].InvestigationID;
                                oIV.PatientVisitID = item[0].PatientVisitID;
                                oIV.Status = "Completed";
                                //below code is to multiple WBC with 1000 for device integration
                                double resultvalue = 0;
                                double.TryParse(finalValue, out resultvalue);
                                string DeviceID = "";
                                int InvestigationID = Convert.ToInt32(item[0].InvestigationID);
                                string ResultValue = finalValue;
                                long orgID = OrgID;
                                // --- Ramkumar.S -- Added for Negative or Positive values were not pushed from Device---//
                                bool Isnumeric = IsNumeric(ResultValue);
                                string resultval2 = string.Empty;
                                //LabUtil oLabUtil1 = new LabUtil();
                                if (Isnumeric)
                                {
                                    oIV.Value = DecimalPlace(DeviceID, InvestigationID, ResultValue, orgID);
                                    resultval2 = objLabUtil.ConvertResultValue(oIV.Value).ToString();
                                }
                                else
                                {
                                    oIV.Value = ResultValue;
                                    resultval2 = oIV.Value;
                                }

                                //-------ENds----------------
                                oIV.DeviceValue = string.Empty;
                                oIV.DeviceActualValue = string.Empty;

                                oIV.UOMCode = null;
                                oIV.CreatedBy = 0;
                                oIV.GroupID = item[0].GroupID;
                                oIV.GroupName = item[0].GroupName;
                                oIV.Orgid = item[0].OrgID;
                                oIV.DeviceErrorCode = string.Empty;

                                oIV.DeviceID = string.Empty;
                                lstValues.Add(oIV);

                            }

                            catch (Exception er)
                            {

                            }
                            //return arr;
                        }
                        catch (Exception er1)
                        {

                        }
                    }
                }
                lstlstInv.Add(lstValues);
                //arr.Add(lstpinv);
                //arr.Add(lstlstInvestigationValues);
            }
        }
        catch (Exception excep)
        {

        }
        //return arr;
    }

    #region CreateTask
    public void CreateTask(long PatientID, long vid, string gUID, int OrgID, long RoleID, long LID)
    {
        long returncode = -1;
        Tasks task = new Tasks();
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Investigation_BL DemoBL = new Investigation_BL();
        List<PatientInvestigation> pattasks = new List<PatientInvestigation>();

        long createTaskID = -1;
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        returncode = new PatientVisit_BL().GetVisitDetails(vid, out lstPatientVisitDetails);
        returncode = Attune.Podium.Common.Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                     vid, 0, lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " +
                     lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                     , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                     gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
        task.TaskActionID = Convert.ToInt32(Convert.ToInt64(TaskHelper.TaskAction.Validate));
        task.DispTextFiller = dText;
        task.URLFiller = urlVal;
        task.RoleID = RoleID;
        task.OrgID = OrgID;
        task.PatientVisitID = vid;
        task.PatientID = lstPatientVisitDetails[0].PatientID;
        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        task.CreatedBy = LID;

        //Create task  

        if (Patinvestasks.Count > 0)
        {

            Patinvestasks.Select(e => new { e.AccessionNumber }).Distinct().ToList();

            DemoBL.GetGrouplevelvalidation(vid, task.TaskActionID, Patinvestasks, OrgID, 0, out pattasks);

        }

        if (pattasks.Count > 0)
        {
            task.RefernceID = pattasks[0].LabNo;
            returncode = new Tasks_BL().CreateTask(task, out createTaskID);
            string display = string.Empty;
        }

        //returncode = new Investigation_BL().GetWayToMethodKit(RoleID, OrgID, deptID, out display);
    }
    #endregion
    #region Reprint Barcode
    //Vijayalakshmi.M
    [WebMethod(EnableSession = true)]
    public long ReprintBarcode(string ExternalVistiId, int OrgID, out int TranStatus, out List<BarcodeIntegrationResults> lstsample)
    {
        OrgId = OrgID;
        long ReturnCode = -1;
        TranStatus = -1;
        lstsample = new List<BarcodeIntegrationResults>();
        IntegrationBL integBL = new IntegrationBL();
        try
        {
            ReturnCode = integBL.GetBarCodeDetails(ExternalVistiId, OrgId, out TranStatus, out lstsample);
        }
        catch (Exception ex)
        {

            TranStatus = -1;
            CLogger.LogError("Error in GetBarCodeDetails: ", ex);
        }

        return ReturnCode;


    }
    #endregion
    //Vijayalakshmi.M changes for Mobile App API
    #region Method for GetReferenceRange
    [WebMethod(EnableSession = true)]
    public string ReferenceRange(long VisitID, long InvestigationID, string Value, int OrgID, string ReferenceRange, string Age, string IsAbnormal, out string textColor, out string Abnormal)
    {
        OrgId = OrgID;
        List<VisitDetails> lstVisitdetails = new List<VisitDetails>();
        Investigation_BL InvBL = new Investigation_BL();
        LabUtil Objlab = new LabUtil();
        textColor = "";
        Abnormal = "";
        try
        {
            List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
            long returnCode = InvBL.getReferencerangetype(OrgID, "en-GB", out lstReferenceRangeType);

            InvBL.GetReferenceRangeDetails(VisitID, InvestigationID, Value, OrgID, IsAbnormal, out lstVisitdetails, out textColor, out Abnormal);
            ReferenceRange = lstVisitdetails[0].ReferenceRange;
            Age = lstVisitdetails[0].Age;
            Objlab.ValidateResult(VisitID, InvestigationID, Value, OrgID, ReferenceRange, Age, out lstVisitdetails, out textColor, out Abnormal, lstReferenceRangeType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ReferenceRange: ", ex);
        }

        return textColor;


    }
    #endregion
    #region Method for GetReportDetails
    [WebMethod(EnableSession = true)]
    public long GetReportDetails(int VisitID, long OrgID, out VisitCountDetails[] lstVisitscount, out byte[] bytes)
    {

        lstVisitscount = null;
        List<VisitCountDetails> lstVisit = new List<VisitCountDetails>();
        bytes = null;
        List<byte[]> objbytes = new List<byte[]>();
        Investigation_BL InvBL = new Investigation_BL();
        long ReturnCode = -1;
        string strInvStatus = InvStatus.Approved;
        List<string> lstInvStatus = new List<string>();
        lstInvStatus.Add(strInvStatus);
        long RoleID = -1;
        int orgAddressID = 0;
        long LoginID = -1;
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        ReportUtil objreport = new ReportUtil();
        try
        {
            InvBL.GetInvestigationReportDetails(VisitID, OrgID, out lstVisitscount);
            objreport.GetReports(VisitID, Convert.ToInt32(OrgID), RoleID, orgAddressID, lstInvStatus, LoginID, true, "printreport", "", -1, "", "", out lstReportSnapshot,"");
            if (lstReportSnapshot.Count > 0)
            {
                bytes = lstReportSnapshot[0].Content;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetReportDetails: ", ex);
        }

        return ReturnCode;
    }
    #endregion
    //End
    [WebMethod(EnableSession = true)]
    public List<OrderedStatus> GetOrderedStatus(string ExternalVisitID)
    {

        long ReturnCode = -1;
        List<OrderedStatus> lstOrderedStatus = new List<OrderedStatus>();
       
        try
        {


            ReturnCode = new IntegrationBL().GetOrderedStatus(ExternalVisitID, out lstOrderedStatus);


        }
        catch (Exception ex)
        {


            CLogger.LogError("Error in GetOrderedStatus ", ex);
        }

        return lstOrderedStatus;
    }

    #region GetBidirectionalBarCodeDetail
    [WebMethod(EnableSession = true)]
    public void InvBidirectionalBarCodeDetails(int OrgID, int OrgAddressID, string DeviceID, out List<BidirectionalBarcodesDetails> objData)
    {
        objData = new List<BidirectionalBarcodesDetails>();
        try
        {
            new IntegrationBL().GetBidirectionalBarCodeDetails(OrgID, OrgAddressID, DeviceID, out objData);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvBidirectionalBarCodeDetails", ex.InnerException);
        }
    }
    #endregion

    #region InsertDeviceInvestigationData
    [WebMethod(EnableSession = true)]
    public void InsertDeviceInvestigationData(List<DeviceInvestigationData> oDeviceTranData, int OrgID)
    {
        new IntegrationBL().InsertDeviceInvestigationData(oDeviceTranData, OrgID);
    }
    #endregion

    /// <summary>
    /// UpdateBidirectionalBarCodeDetails
    /// </summary>
    /// <param name="Barcode"></param>
    /// <returns></returns>
    #region UpdateBidirectionalBarCodeDetails

    [WebMethod(EnableSession = true)]

    public long UpdateBidirectionalBarCodeDetails(List<BidirectionalBarcodesDetails> Barcode)
    {
        long returncode = -1;
        List<BidirectionalBarcodesDetails> lstBarCode = Barcode;
        try
        {
            returncode = new IntegrationBL().UpdateBidirectionalBarCodeDetails(lstBarCode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in UpdateBidirectionalBarCodeDetails", ex.InnerException);
        }
        return returncode;
    }

    #endregion

    #region OutsourceFilesMerge
    /// <summary>
    /// Outsourcefilemerge for RLS | VEL
    /// </summary>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string OutsourceFilesMerge()
    {
        string returnMsg = string.Empty;
        string filenme = string.Empty;
        StringBuilder sb = new StringBuilder();
        try
        {
            string SourceFilePath = string.Empty, DestinationFilePath = string.Empty;
            int OrgID = 202;
            SourceFilePath = GetConfigValue("OutSourceReportpdfprocessfolderpath", OrgID);
            DestinationFilePath = GetConfigValue("OutSourceReportspdffolderpath", OrgID);
            Investigation_BL InvBL = new Investigation_BL();
            sb.AppendLine(" OutSource PDF process start from" + SourceFilePath);
            DirectoryInfo d = new DirectoryInfo(SourceFilePath);
            FileInfo[] Files = d.GetFiles();
            string DestiFilePath = string.Empty;
            sb.AppendLine("PDF files count :" + Files.Count());
            if (Files != null && Files.Count() > 0)
            {
                string Year = string.Empty, Month = string.Empty, Date = string.Empty;
                Year = DateTime.Now.Year.ToString();
                Month = DateTime.Now.Month.ToString();
                Date = DateTime.Now.Day.ToString();
                string VisitNumber = string.Empty, TestCode = string.Empty, OrgCode = string.Empty, filepath = string.Empty;
                foreach (FileInfo file in Files)
                {
                    if (file.Name.Contains('_'))
                    {
                        sb.AppendLine("PDF file process start :" + file.Name);

                        filenme = file.Name.Replace(".pdf", "");
                        string[] filenamaearry = filenme.Split('_');

                        if (filenamaearry != null && filenamaearry.Length > 2)
                        {
                            VisitNumber = filenamaearry[0];
                            TestCode = filenamaearry[1];
                            OrgCode = filenamaearry[2];
                            filepath = OrgCode + "/" + Year + "/" + Month + "/" + Date + "/" + file.Name;

                            long returnCode = InvBL.SaveOutSourcingPDFFilesDetails(VisitNumber, TestCode, OrgCode, filepath,"");
                            //long returnCode = 0;
                            if (returnCode != -1)
                            {
                                if (returnCode == 1)
                                {
                                    sb.AppendLine("Org Id or Visit not available in DB : Visit Number" + VisitNumber + "Org Id" + OrgCode);
                                    DestiFilePath = DestinationFilePath + "/" + OrgCode + "/" + Year + "/UnProcessed/";
                                    CLogger.LogInfo("UnProcessed Path -" + DestiFilePath);
                                    if (!System.IO.Directory.Exists(DestiFilePath))
                                    {
                                        returnMsg = System.Environment.NewLine + "PDF UnProcessed path created";
                                        System.IO.Directory.CreateDirectory(DestiFilePath);
                                    }
                                    string sourceFile = System.IO.Path.Combine(SourceFilePath, file.Name);
                                    string destFile = System.IO.Path.Combine(DestiFilePath, file.Name);
                                    File.Move(sourceFile, destFile);
                                    sb.AppendLine("PDF file moved to destination :" + file.Name);
                                }
                                else if (returnCode == 0 || returnCode == 2)
                                {
                                    sb.AppendLine("PDF file saved to DB :" + file.Name);
                                    DestiFilePath = DestinationFilePath + "/" + OrgCode + "/" + Year + "/" + Month + "/" + Date + "/";
                                    CLogger.LogInfo("Destination Path -" + DestiFilePath);
                                    if (!System.IO.Directory.Exists(DestiFilePath))
                                    {
                                        sb.AppendLine("PDF Destination path created" + DestiFilePath);
                                        System.IO.Directory.CreateDirectory(DestiFilePath);
                                    }
                                    string sourceFile = System.IO.Path.Combine(SourceFilePath, file.Name);
                                    string destFile = System.IO.Path.Combine(DestiFilePath, file.Name);
                                    if (File.Exists(destFile))
                                    {
                                        sb.AppendLine("PDF file have duplicate :" + file.Name);
                                        string DestiFilePath1 = DestiFilePath + "/Duplicate";
                                       
                                        string DestiFileName1 = file.Name;
                                       
                                        if (!System.IO.Directory.Exists(DestiFilePath1))
                                        {
                                            System.IO.Directory.CreateDirectory(DestiFilePath1);
                                        }

                                        string dupFiles = file.Name.Replace(".pdf", "*.pdf");
                                        DirectoryInfo d1 = new DirectoryInfo(DestiFilePath1);
                                        FileInfo[] filecm = d1.GetFiles(dupFiles);
                                        if (filecm != null && filecm.Length >= 0)
                                        {
                                            DestiFileName1 = DestiFilePath1 + "\\" + DestiFileName1;
                                            string strDespath = DestiFileName1.Replace(file.Extension, "") + "(" + ((filecm.Length + 1).ToString()) + ")" + file.Extension;
                                            File.Move(destFile, strDespath);
                                        }
                                    }
                                    File.Move(sourceFile, destFile);
                                    sb.AppendLine("PDF file moved to destination :" + file.Name);
                                    if (returnCode == 0)
                                    {
                                        string TempFileName = destFile;
                                        TempFileName = TempFileName.Replace(".pdf", "temp.pdf");
                                        if (File.Exists(TempFileName))
                                        {
                                            File.Delete(TempFileName);
                                        }
                                        File.Copy(destFile, TempFileName);
                                        sb.AppendLine("PDF file remove paging:" + TempFileName);
                                        AddPageNumber(TempFileName, destFile);
                                    }
                                }
                            }
                            else
                            {
                                sb.AppendLine("PDF file not moved because error occur :" + file.Name);
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting SetOtherLocationDetails in HL7IntegrationService", ex);
            sb.AppendLine("Error in " + filenme + ex.Message);
        }
        returnMsg = sb.ToString();
        return returnMsg;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string OutsourceFilesRoundPDFMerge()
    {
        string ActionType = "ROUNDBPDF";
        string returnMsg = string.Empty;
        string filenme = string.Empty;
        StringBuilder sb = new StringBuilder();
        try
        {
            string SourceFilePath = string.Empty, DestinationFilePath = string.Empty;
            int OrgID = 202;
            SourceFilePath = GetConfigValue("OutSourceReportsRoundpdffolderpath", OrgID);
            DestinationFilePath = GetConfigValue("OutSourceReportRoundpdfprocessfolderpath", OrgID);
            Investigation_BL InvBL = new Investigation_BL();
            sb.AppendLine(" OutSource Round PDF process start from" + SourceFilePath);
            DirectoryInfo d = new DirectoryInfo(SourceFilePath);
            FileInfo[] Files = d.GetFiles();
            string DestiFilePath = string.Empty;
            sb.AppendLine("PDF files count :" + Files.Count());
            if (Files != null && Files.Count() > 0)
            {
                string Year = string.Empty, Month = string.Empty, Date = string.Empty;
                Year = DateTime.Now.Year.ToString();
                Month = DateTime.Now.Month.ToString();
                Date = DateTime.Now.Day.ToString();
                string VisitNumber = string.Empty, TestCode = string.Empty, OrgCode = string.Empty, filepath = string.Empty;
                foreach (FileInfo file in Files)
                {
                    if (file.Name.Contains('_'))
                    {
                        sb.AppendLine("Round PDF file process start :" + file.Name);

                        filenme = file.Name.Replace(".pdf", "");
                        string[] filenamaearry = filenme.Split('_');

                        if (filenamaearry != null && filenamaearry.Length > 2)
                        {
                            VisitNumber = filenamaearry[0];
                            TestCode = filenamaearry[1];
                            OrgCode = filenamaearry[2];
                            filepath = OrgCode + "/" + Year + "/" + Month + "/" + Date + "/" + file.Name;

                            long returnCode = InvBL.SaveOutSourcingPDFFilesDetails(VisitNumber, TestCode, OrgCode, filepath,ActionType);
                            //long returnCode = 0;
                            if (returnCode != -1)
                            {
                                if (returnCode == 1)
                                {
                                    sb.AppendLine("Org Id or Visit not available in DB : Visit Number" + VisitNumber + "Org Id" + OrgCode);
                                    DestiFilePath = DestinationFilePath + "/" + OrgCode + "/" + Year + "/UnProcessed/";
                                    CLogger.LogInfo("UnProcessed Path -" + DestiFilePath);
                                    if (!System.IO.Directory.Exists(DestiFilePath))
                                    {
                                        returnMsg = System.Environment.NewLine + "PDF UnProcessed path created";
                                        System.IO.Directory.CreateDirectory(DestiFilePath);
                                    }
                                    string sourceFile = System.IO.Path.Combine(SourceFilePath, file.Name);
                                    string destFile = System.IO.Path.Combine(DestiFilePath, file.Name);
                                    File.Move(sourceFile, destFile);
                                    sb.AppendLine("PDF file moved to destination :" + file.Name);
                                }
                                else if (returnCode == 0 || returnCode == 2)
                                {
                                    sb.AppendLine("PDF file saved to DB :" + file.Name);
                                    DestiFilePath = DestinationFilePath + "/" + OrgCode + "/" + Year + "/" + Month + "/" + Date + "/";
                                    CLogger.LogInfo("Destination Path -" + DestiFilePath);
                                    if (!System.IO.Directory.Exists(DestiFilePath))
                                    {
                                        sb.AppendLine("PDF Destination path created" + DestiFilePath);
                                        System.IO.Directory.CreateDirectory(DestiFilePath);
                                    }
                                    string sourceFile = System.IO.Path.Combine(SourceFilePath, file.Name);
                                    string destFile = System.IO.Path.Combine(DestiFilePath, file.Name);
                                    if (File.Exists(destFile))
                                    {
                                        sb.AppendLine("PDF file have duplicate :" + file.Name);
                                        string DestiFilePath1 = DestiFilePath + "/Duplicate";

                                        string DestiFileName1 = file.Name;

                                        if (!System.IO.Directory.Exists(DestiFilePath1))
                                        {
                                            System.IO.Directory.CreateDirectory(DestiFilePath1);
                                        }

                                        string dupFiles = file.Name.Replace(".pdf", "*.pdf");
                                        DirectoryInfo d1 = new DirectoryInfo(DestiFilePath1);
                                        FileInfo[] filecm = d1.GetFiles(dupFiles);
                                        if (filecm != null && filecm.Length >= 0)
                                        {
                                            DestiFileName1 = DestiFilePath1 + "\\" + DestiFileName1;
                                            string strDespath = DestiFileName1.Replace(file.Extension, "") + "(" + ((filecm.Length + 1).ToString()) + ")" + file.Extension;
                                            File.Move(destFile, strDespath);
                                        }
                                    }
                                    File.Move(sourceFile, destFile);
                                    sb.AppendLine("PDF file moved to destination :" + file.Name);
                                    if (returnCode == 0)
                                    {
                                        string TempFileName = destFile;
                                        TempFileName = TempFileName.Replace(".pdf", "temp.pdf");
                                        if (File.Exists(TempFileName))
                                        {
                                            File.Delete(TempFileName);
                                        }
                                        File.Copy(destFile, TempFileName);
                                        sb.AppendLine("PDF file remove paging:" + TempFileName);
                                        AddPageNumber(TempFileName, destFile);
                                    }
                                }
                            }
                            else
                            {
                                sb.AppendLine("PDF file not moved because error occur :" + file.Name);
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting SetOtherLocationDetails in HL7IntegrationService", ex);
            sb.AppendLine("Error in " + filenme + ex.Message);
        }
        returnMsg = sb.ToString();
        return returnMsg;
    }

    #region Remove Page Number
    protected void AddPageNumber(string InputFileName, string OutputFileName)
    {
        try
        {
            byte[] bytes = File.ReadAllBytes(InputFileName);
            iTextSharp.text.Font blackFont = FontFactory.GetFont("Arial", 9, iTextSharp.text.Font.NORMAL, BaseColor.BLACK);
            iTextSharp.text.Font whiteFont = FontFactory.GetFont("Arial", 25, iTextSharp.text.Font.NORMAL, BaseColor.RED);
            using (MemoryStream stream = new MemoryStream())
            {
                iTextSharp.text.pdf.PdfReader reader = new iTextSharp.text.pdf.PdfReader(bytes);

                //PdfReader readerimg = new PdfReader(bytesimg);
                using (PdfStamper stamper = new PdfStamper(reader, stream))
                {
                    int pages = reader.NumberOfPages;
                    iTextSharp.text.pdf.PdfRectangle rect1 = new iTextSharp.text.pdf.PdfRectangle(0, 100, 450, 35);
                    if (File.Exists(OutputFileName))
                    {
                        File.Delete(OutputFileName);
                    }
                    FileStream fs = new FileStream(OutputFileName, FileMode.Create);
                    PdfPTable table = new PdfPTable(1);
                    table.TotalWidth = 200f;
                    Document doc = new Document(iTextSharp.text.PageSize.A4, 25, 25, 30, 30);
                    PdfWriter writer = PdfWriter.GetInstance(doc, fs);

                    doc.Open();
                    PdfContentByte cb = writer.DirectContent;
                    cb.BeginText();
                    fs.Close();
                    int ilx = 480;
                    int ily = 840;//66,53,60
                    PdfPCell cell = new PdfPCell();
                    for (int i = 1; i <= pages; i++)
                    {
                        string pagecontent = "Page " + i.ToString() + " of " + pages;
                        DataTable dt = GetDataTable();
                        if (dt != null)
                        {
                            Font font8 = FontFactory.GetFont("ARIAL", 8, BaseColor.WHITE);
                            table = new PdfPTable(dt.Columns.Count);

                            cell = new PdfPCell(new Phrase(new Chunk("ID", font8)));
                            cell.BackgroundColor = BaseColor.WHITE;
                            cell.BorderColor = BaseColor.WHITE;
                            cell.Rowspan = 6;
                            table.AddCell(cell);
                            cell = new PdfPCell(new Phrase(new Chunk("Name", font8)));
                            cell.BackgroundColor = BaseColor.WHITE;
                            cell.BorderColor = BaseColor.WHITE;
                            cell.Rowspan = 6;
                            table.AddCell(cell);
                            cell = new PdfPCell(new Phrase(new Chunk("Country", font8)));
                            cell.BackgroundColor = BaseColor.WHITE;
                            cell.BorderColor = BaseColor.WHITE;
                            cell.Rowspan = 6;
                            table.AddCell(cell);
                        }
                        ColumnText ct = new ColumnText(stamper.GetOverContent(i));
                        ct.AddElement(table);
                        iTextSharp.text.Rectangle rect = new iTextSharp.text.Rectangle(46, 190, 530, 36);
                        //iTextSharp.text.Rectangle rect = new iTextSharp.text.Rectangle(56, 160, 530, 58);
                        ct.SetSimpleColumn(ilx, ily, iTextSharp.text.PageSize.A4.Width - 36, 15);
                        ct.Go();

                        //ColumnText.ShowTextAligned(stamper.GetOverContent(i), Element.ALIGN_TOP, new Phrase(pagecontent, blackFont), 538f, 35f, 0);

                        doc.Add(table);
                    }

                }
                bytes = stream.ToArray();
            }
            File.WriteAllBytes(OutputFileName, bytes);
        }
        catch (Exception ex)
        {
            //  CLogger.LogError("Error in AddPageNumber", ex);
        }
        finally
        {
            if (File.Exists(InputFileName))
            {
                File.Delete(InputFileName);
            }
        }

    }
    private DataTable GetDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[3] { new DataColumn("Id", typeof(int)),
                        new DataColumn("Name", typeof(string)),
                        new DataColumn("Country",typeof(string)) });
        dt.Rows.Add(1, "", "");
        dt.Rows.Add(2, "", "");
        dt.Rows.Add(3, "", "");
        return dt;
    }
    #endregion

    #region GetConfigValue
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        ContextDetails objcontext = new ContextDetails();
        objcontext = SetContextDetailsInBound(orgID, "en-GB", 1, 1, 1);
        GateWay objGateway = new GateWay(objcontext);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
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
    #endregion
[WebMethod(EnableSession = true)]
    public string GetRuleMasterMedicalRemarks(long PatientVisitID, long GroupID, long InvID, int OrgID, string value, string IsAbnormal, string Gender, string StrTestResultsRule)
    {
        string rulemedicalremarks = string.Empty;
        int remarksid = 0;
        try
        {
            //Rule Master Starts
            //lstPatientInv[0].IsAbnormal
            bool AcrFlag = false;
            bool MrrFlag = false;
            long returnCode = 0;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<TestResultsRule> lstCrossTestResults = new List<TestResultsRule>();
            lstCrossTestResults = serializer.Deserialize<List<TestResultsRule>>(StrTestResultsRule);
            List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
            List<InvRuleMaster> lstInvremarks = new List<InvRuleMaster>();
            List<PatientAgeGenderRule> lstPatientAgeGenderRule = new List<PatientAgeGenderRule>();
            List<TestResultsRule> lstTestResultsRule = new List<TestResultsRule>();
            List<MachineErrorRule> lstMachineErrorRule = new List<MachineErrorRule>();
            Investigation_BL InvBL = new Investigation_BL();
            if (GroupID > 0)
            {

                returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, GroupID, OrgID, "GRP", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule,out lstInvremarks);
                if (lstInvRuleMaster.Count == 0)
                {
                    returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
                }
            }
            else
            {
                returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
            }
            if (lstInvRuleMaster.Count > 0)
            {
                List<PatientAgeGenderRule> lstPatientAgeGender = new List<PatientAgeGenderRule>();
                List<TestResultsRule> lstTestResults = new List<TestResultsRule>();
                List<MachineErrorRule> lstMachineError = new List<MachineErrorRule>();
                foreach (InvRuleMaster orm in lstInvRuleMaster)
                {
                    if (orm.Code == "MRR")
                    {
                        foreach (InvRuleMaster irm in lstInvremarks)
                        {
                            lstPatientAgeGender = lstPatientAgeGenderRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                            
                            lstTestResults = lstTestResultsRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                            if (GroupID > 0)
                            {
                                lstTestResults = new List<TestResultsRule>();
                                lstTestResults = lstTestResultsRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId && RR.ResultInvestigationID == InvID).ToList();
                            }
                            if (lstCrossTestResults.Count > 0)
                            {
                                foreach (var rcodeObj in lstCrossTestResults)
                                {
                                    foreach (var obj in (lstTestResults.Where(t => t.RuleMasterId == rcodeObj.RuleMasterId && t.ResultInvestigationID == rcodeObj.ResultInvestigationID)))
                                    {
                                        obj.ResultValue = rcodeObj.ResultValue;
                                        obj.ResultInvestigation = rcodeObj.ResultInvestigation;
                                    }
                                }
                            }
                            lstMachineError = lstMachineErrorRule.FindAll(RR => RR.RuleMasterId == orm.RuleMasterId && RR.RemarksId == irm.RemarksId).ToList();
                            MrrFlag = ValidateRuleMaster(InvID, value, IsAbnormal, Gender, "", lstPatientAgeGender, lstTestResults, lstMachineError);
                            if (MrrFlag)
                            {
                                rulemedicalremarks = irm.InvRemarksValue;
                                remarksid = irm.RemarksId;
                                return remarksid.ToString() + "~" + rulemedicalremarks; ;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetRuleMasterMedicalRemarks ", ex);
        }
        //if (MrrFlag == true)
        //{
        //    if (rulemedicalremarks != "")
        //    {
        //        return rulemedicalremarks;
        //    }
        //}
        return remarksid.ToString()+"~"+rulemedicalremarks;
    }

[WebMethod(EnableSession = true)]
public List<TestResultsRule> GetRuleMasterCrossParameter(long PatientVisitID, long GroupID, long InvID, int OrgID, string value, string IsAbnormal, string Gender)
{

    List<TestResultsRule> lstTestResults = new List<TestResultsRule>();
    try
    {
        bool AcrFlag = false;
        bool MrrFlag = false;
        long returnCode = 0;

        List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
        List<InvRuleMaster> lstInvremarks = new List<InvRuleMaster>();
        List<PatientAgeGenderRule> lstPatientAgeGenderRule = new List<PatientAgeGenderRule>();
        List<TestResultsRule> lstTestResultsRule = new List<TestResultsRule>();
        List<MachineErrorRule> lstMachineErrorRule = new List<MachineErrorRule>();
        Investigation_BL InvBL = new Investigation_BL();
        if (GroupID > 0)
        {

            returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, GroupID, OrgID, "GRP", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
            if (lstInvRuleMaster.Count == 0)
            {
                returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
            }
        }
        else
        {
            returnCode = InvBL.GetInvRulemasterVisit(PatientVisitID, InvID, OrgID, "INV", out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule, out lstInvremarks);
        }
        if (lstInvRuleMaster.Count > 0)
        {
                lstTestResults = ((from TR in lstTestResultsRule
                    join IRM in lstInvRuleMaster
                 on TR.RuleMasterId equals IRM.RuleMasterId
                                   where IRM.Code == "MRR" && TR.ResultInvestigationID != InvID 
                    select new TestResultsRule
            {
               ResultInvestigationID= TR.ResultInvestigationID,
               TestResultsRuleId=TR.TestResultsRuleId,
               ResultValue=TR.ResultValue,
               RuleMasterId =TR.RuleMasterId,
               ResultInvestigation=TR.ResultInvestigation
               
           }).Distinct()).ToList();
        }
    }
    catch (Exception ex)
    {
        CLogger.LogError("Error in GetRuleMasterMedicalRemarks ", ex);
    }

    return lstTestResults;
}

}
class MyReportServerCredent : Microsoft.Reporting.WebForms.IReportServerCredentials
{
    string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
    string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

    public MyReportServerCredent()
    {
    }

    public System.Security.Principal.WindowsIdentity ImpersonationUser
    {
        get
        {
            return null;  // Use default identity.
        }
    }

    public System.Net.ICredentials NetworkCredentials
    {
        get
        {
            return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
        }
    }

    public bool GetFormsCredentials(out System.Net.Cookie authCookie,
            out string user, out string password, out string authority)
    {
        authCookie = null;
        user = password = authority = null;
        return false;  // Not use forms credentials to authenticate.
    }
    #endregion
}
