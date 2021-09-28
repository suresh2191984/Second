using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Solution.QMSBusinessLogic;
using Attune.Podium.Common;
using System.Data;
using System.IO;
using System.Web.UI;
using Attune.Solution;
using Attune.Solution.QMSBusinessEntities;
using Attune.Solution.QMSDataAccessLayer;
using Attune.Solution.QMSBusinessEntities.CustomEntities;
using System.ComponentModel;
using Attune.Solution.QMSBasecClassConvert;



/// <summary>
/// Summary description for QMS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class QMS : System.Web.Services.WebService
{

    public QMS()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    /// <summary>
    /// This method used to retrive menu data against the particular role
    /// </summary>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<Alacarte> GetMenuItems(int roleID, int orgID, int parentID)
    {

        long retCode = -1;
        List<Alacarte> lstMenuDetails = new List<Alacarte>();

        RoleMenu_BL rolemenu_BL = new RoleMenu_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        
        retCode = rolemenu_BL.GetMenuItems(roleID, orgID, parentID, out lstMenuDetails);
        return lstMenuDetails;
    }
    #region Added By Arivalagan.kk For QMS Load Drop Downs
    //********************Added By Arivalagan.kk For QMS Analyte Master*****************// 
    AnalyteMasterBL _AnalyteMasterBL;
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public ArrayList LoadQMSDropDown(int Orgid)
    //{
    //    ArrayList AaList = new ArrayList();
    //    try
    //    {
    //        long returncode = -1;
    //        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
    //        List<InvSampleMaster> lstSample = new List<InvSampleMaster>();
    //        List<InvestigationSampleContainer> lstAdditive = new List<InvestigationSampleContainer>();
    //        List<InvestigationMethod> lstMethod = new List<InvestigationMethod>();
    //        List<InvPrincipleMaster> lstPrinciple = new List<InvPrincipleMaster>();
    //        List<MetaValue_Common> lstResultValue = new List<MetaValue_Common>();
    //        List<MetaValue_Common> lstSubCategory = new List<MetaValue_Common>();
    //        List<Role> lstRoles = new List<Role>();
    //        List<InvInstrumentMaster> lstInstrument = new List<InvInstrumentMaster>();
    //        List<Products> lstKit = new List<Products>();
    //        List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
    //        List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
    //        List<MetaValue_Common> lstCategory = new List<MetaValue_Common>();
    //        List<InvestigationHeader> lstHeader = new List<InvestigationHeader>();

    //        returncode = new Master_BL(new BaseClass().ContextInfo).GetTestMasterDropDownValues(Orgid, out lstDept,
    //            out lstSample, out lstAdditive, out lstMethod, out lstPrinciple, out lstResultValue, out lstSubCategory,
    //            out lstRoles, out lstInstrument, out lstKit, out lstInvClientMaster, out lstReasonMaster,
    //            out lstCategory, out lstHeader);

    //        MetaData oMetaData = new MetaData();
    //        oMetaData.Domain = "TestClassification";
    //        string LangCode = "en-GB";
    //        List<MetaData> lstDomain = new List<MetaData>();
    //        lstDomain.Add(oMetaData);
    //        List<MetaData> lstClassify = new List<MetaData>();
    //        returncode = new MetaData_BL(new QMSBaseClass().ContextInfo).LoadMetaDataOrgMapping(lstDomain, Orgid, LangCode, out lstClassify);
    //        oMetaData = new MetaData();
    //        oMetaData.Domain = "CutOffTimeType";
    //        lstDomain = new List<MetaData>();
    //        lstDomain.Add(oMetaData);
    //        List<MetaData> lstMetaData = new List<MetaData>();
    //        returncode = new MetaData_BL(new QMSBaseClass().ContextInfo).LoadMetaDataOrgMapping(lstDomain, Orgid, LangCode, out lstMetaData);
    //        //ddlDepartment
    //        AaList.Add(lstDept);
    //        //ddlAdditive
    //        AaList.Add(lstAdditive);
    //        //ddlResultValue
    //        AaList.Add(lstResultValue);
    //        //ddlSampleType
    //        AaList.Add(lstSample);
    //        //ddlMethod
    //        AaList.Add(lstMethod);
    //        //ddlPrinciple
    //        AaList.Add(lstPrinciple);
    //        //ddlClassification
    //        if (lstClassify.Count > 0)
    //        {
    //            List<MetaData> lstClassification = ((from child in lstClassify
    //                                                 where child.Domain == "TestClassification"
    //                                                 select child).Distinct()).ToList();
    //            if (lstClassification != null && lstClassification.Count > 0)
    //            {
    //                AaList.Add(lstClassification);
    //            }
    //        }
    //        //ddlHours
    //        if (lstMetaData.Count > 0)
    //        {
    //            List<MetaData> lstCutOffTimeType = ((from child in lstMetaData
    //                                                 where child.Domain == "CutOffTimeType"
    //                                                 select child).Distinct()).ToList();
    //            if (lstCutOffTimeType != null && lstCutOffTimeType.Count > 0)
    //            {
    //                AaList.Add(lstCutOffTimeType);
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Loading QMS DDLS ", ex);
    //    }
    //    return AaList;
    //}

    //********************End Added By Arivalagan.kk*************************************// 
    #endregion
    #region Added By vinothini.B For QMS AnalyerMaster

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long InvInstrumentMaster(string roleID, string orgID, List<InvInstrumentMaster> SaveAnalyzer, string MaintenanceDoneDate
      , string MaintenanceDueDate, string CalibrationDoneDate, string CalibrationDueDate, string[] DeptID)
    {
        long returncode = -1;
        int OrgID = Convert.ToInt16(orgID);
        int RoleID = Convert.ToInt16(roleID);
        AnalyzerMaster_BL Obj_Analyzer_BL;
        int instrumentID = -1;
        try
        {
            
            /// BaseClass objBClass= new BaseClass();
           //new ClassConvert(new BaseClass().ContextInfo);

           //ContextDetails cd = new ClassConvert(new BaseClass().ContextInfo).returnContext;


            Obj_Analyzer_BL = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
           

            returncode = Obj_Analyzer_BL.InvInstrumentMaster_BL(RoleID, OrgID, SaveAnalyzer, MaintenanceDoneDate, MaintenanceDueDate, CalibrationDoneDate, CalibrationDueDate, DeptID, out instrumentID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while inserting in InvInstrumentMaster_AppcodeQMS", ex);
        }
        return instrumentID;
    }
 
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public long QMS_DeleteInstrumentMaster(int ID)
    {
        long returncode = -1;
        AnalyzerMaster_BL Obj_BL;
        try
        {
            Obj_BL = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_DeleteInstrumentMaster_BL(ID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Deleting in QMS_DeleteInstrumentMaster_Appcode", ex);
        }
        return returncode;
    }
    
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_EditInstrumentMaster(string roleID, string orgID, List<InvInstrumentMaster> SaveAnalyzer, string MaintenanceDoneDate
      , string MaintenanceDueDate, string CalibrationDoneDate, string CalibrationDueDate, string[] DeptID)
    {
        long returncode = -1;
        int OrgID = Convert.ToInt16(orgID);
        int RoleID = Convert.ToInt16(roleID);
        AnalyzerMaster_BL obj_BL;
        try
        {

            obj_BL = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj_BL.QMS_EditInstrumentMaster_BL(RoleID, OrgID, SaveAnalyzer, MaintenanceDoneDate, MaintenanceDueDate, CalibrationDoneDate, CalibrationDueDate, DeptID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Editing in QMS_EditInstrumentMaster_Appcode ", ex);
        }
        return returncode;
    }
   
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadAnalyzerMaster()
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();

        AnalyzerMaster_BL bl = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.LoadAnalyzerMaster(out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Analyzer Data", ex);
        }
       serializer.MaxJsonLength= Int32.MaxValue;
        return serializer.Serialize(rows);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] QMS_LoadInvPrincipleMaster()
    {
        long returncode = -1;
        List<InvPrincipleMaster> Obj = new List<InvPrincipleMaster>();
        List<InvestigationMethod> Obj1 = new List<InvestigationMethod>();
        List<InvDeptMaster> Obj2 = new List<InvDeptMaster>();
        List<OrganizationAddress> Obj3 = new List<OrganizationAddress>();
        List<DeviceManufacturer> Obj4 = new List<DeviceManufacturer>();
        List<LotVendorMaster> Obj5 = new List<LotVendorMaster>();

        List<object> lstobj = new List<object>();
        try
        {
            AnalyzerMaster_BL Obj_BL = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.LoadInvPrincipleMaster_BL(out Obj, out Obj1, out Obj2, out Obj3, out Obj4, out Obj5);

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while loading data QMS_LoadInvPrincipleMaster ", Ex);
        }
        lstobj.Add(Obj);
        lstobj.Add(Obj1);
        lstobj.Add(Obj2);
        lstobj.Add(Obj3);
        lstobj.Add(Obj4);
        lstobj.Add(Obj5);

        return lstobj.ToArray();


    }
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<InvestigationMethod> QMS_LoadInvestigationMethod(String status)
    //{
    //    long returncode = -1;
    //    List<InvestigationMethod> obj = new List<InvestigationMethod>();
    //    try
    //    {
    //        AnalyzerMaster_BL Obj_BL = new AnalyzerMaster_BL(new QMSBaseClass().ContextInfo);
    //        returncode = Obj_BL.LoadInvestigationMethod_BL(status, out obj);
    //    }
    //    catch (Exception e)
    //    {
    //        CLogger.LogError("Error while loading data QMS_LoadInvestigationMethod", e);
    //    }
    //    return obj;
    //}
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<InvDeptMaster> OMS_LoadInvDeptMaster(String status)
    //{
    //    long returncode = -1;
    //    List<InvDeptMaster> obj = new List<InvDeptMaster>();
    //    try
    //    {
    //        AnalyzerMaster_BL Obj_BL = new AnalyzerMaster_BL(new QMSBaseClass().ContextInfo);
    //        returncode = Obj_BL.LoadInvDeptMaster_BL(status, out obj);
    //    }
    //    catch (Exception e)
    //    {
    //        CLogger.LogError("Error while inserting QMS_LoadInvDeptMaster", e);
    //    }
    //    return obj;
    //}
  
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> QMS_LoadDevices(string Status)
    {
        long returncode = -1;
        List<InvInstrumentMaster> obj = new List<InvInstrumentMaster>();
        try
        {
            AnalyzerMapping_BL Obj_BL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadDevices_BL(Status, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadDevices_ASMX ", e);

        }
        return obj;
    }
   
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> QMS_DeviceDetails(int InstrumentID)
    {
        long returncode = -1;
        List<InvInstrumentMaster> obj = new List<InvInstrumentMaster>();
        try
        {
            AnalyzerMapping_BL Obj_BL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_DeviceDetails_BL(InstrumentID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_DeviceDetails_ASMX ", e);
        }
        return obj;
    }
   
 [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DashboardContent> Dashboard_AnalyzerDetails(int OrgID, int LocationID, int DepartmentID, DateTime fromDate, DateTime toDate, int checkDiff)
    {
        long returncode = -1;
        List<DashboardContent> obj = new List<DashboardContent>();
        try
        {
            QMS_Dashboard_BL objDal = new QMS_Dashboard_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = objDal.Dashboard_AnalyzerDetails_BL(OrgID, LocationID, DepartmentID, fromDate,toDate,checkDiff, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_DeviceDetails_ASMX ", e);
        }
        return obj;
    
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Department > Dashboard_DeptList(int OrgID)
    {
        long returncode = -1;
        List<Department> obj = new List<Department>();
        try
        {
       
            ContextDetails bc = new QMS_Integration(new BaseClass().ContextInfo).returnContext;
            int LoginID = Convert.ToInt32(bc.LoginID);
            int RoleID = bc.RoleID;
            QMS_Dashboard_BL objDal = new QMS_Dashboard_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);

            returncode = objDal.Dashboard_LoadDept_BL(LoginID, OrgID, RoleID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_DeviceDetails_ASMX ", e);
        }
        return obj;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    
    public List<InvestigationOrgMapping> QMS_LoadAnalyte(string Status, String prefixText)
    {
        long returncode = -1;
        List<InvestigationOrgMapping> obj = new List<InvestigationOrgMapping>();
        try
        {
            AnalyzerMapping_BL Obj_BL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadAnalyte_BL(Status, prefixText, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadAnalyte_ASMX ", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_SaveAnalyzermappingDetails(List<QC_AnalyzerMapping> QCAnalyzerMapping)
    {
        long returncode = -1;

        try
        {

            AnalyzerMapping_BL obj = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_SaveAnalyzermappingDetails_BL(QCAnalyzerMapping);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadAnalyzerMappingDetails()
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();

        AnalyzerMapping_BL bl = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.QMS_PgetAnalyzerMappingDetails_BL(out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Analyzer Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_UpdateAnalyzermappingDetails(List<QC_AnalyzerMapping> QCAnalyzerMapping, string DeviceMappingId,string  Extras)
    {
        long returncode = -1;
        
        try
        {
            AnalyzerMapping_BL obj = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_UpdateAnalyzermappingDetails_BL(QCAnalyzerMapping, DeviceMappingId, Extras);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_DeleteAnalyzermappingDetails(string DeviceID, string TestCode, string Activationstatus)
    {
        long returncode = -1;

        try
        {

            AnalyzerMapping_BL obj = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_PdeleteAnalyzermappingDetailsCommand_BL(DeviceID, TestCode, Activationstatus);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_DeleteAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Localities> QMS_Loadcountrydetails()
    {
        long returncode = -1;
        List<Localities> obj = new List<Localities>();
        try
        {
            Country_BL countryBL = new Country_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
          //  returncode = countryBL.GetLocalities(0, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_Loadcountrydetails", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Localities> QMS_Loadlocalitiesdetails(int CountryID)
    {
        long returncode = -1;
        List<Localities> obj = new List<Localities>();
        try
        {
            Country_BL countryBL = new Country_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            //returncode = countryBL.GetLocalities(CountryID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_Loadlocalitiesdetails", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public long QMS_LotVendorMaster(List<LotVendorMaster> LotVendorMaster,string city)
    {
        long returncode = -1;
        try
        {
            LotManagement_BL lot_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = lot_BL.LotVendorMaster_BL(LotVendorMaster,city);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LotVendorMaster", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadLotvendorDetails()
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();
        LotManagement_BL bl = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.QMS_pGetLotVendormaster_BL(out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading LoadLotvendorDetails", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_DeletelotVendormasterDetails(string Activationstatus, int VendorID)
    {
        long returncode = -1;

        try
        {

            LotManagement_BL obj = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_DeletelotVendormasterDetails_BL(Activationstatus, VendorID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_DeletelotVendormasterDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public long QMS_UpdateLotVendorMaster(int VendorID, List<LotVendorMaster> LotVendorMaster,string city)
    {
        long returncode = -1;
        try
        {
            LotManagement_BL lot_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = lot_BL.QMS_UpdateLotVendorMaster_BL(VendorID, LotVendorMaster,city);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_UpdateLotVendorMaster", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public long QMS_LotManufacturerMaster(List<DeviceManufacturer> LotManufacturerMaster)
    {
        long returncode = -1;
        try
        {
            LotManagement_BL lot_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = lot_BL.LotManufacturerMaster_BL(LotManufacturerMaster);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LotManufacturerMaster", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadLotManufacturerDetails()
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();
        LotManagement_BL bl = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.QMS_pGetLotManufacturermaster_BL(out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading LoadLotManufacturerDetails", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_DeletelotManufacturermasterDetails(string Activationstatus, int MacID)
    {
        long returncode = -1;

        try
        {

            LotManagement_BL obj = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_DeletelotManufacturermasterDetails_BL(Activationstatus, MacID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_DeletelotManufacturermasterDetails", e);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public long QMS_UpdateLotManufactureMaster(int MacID, List<DeviceManufacturer> Manufacturemaster)
    {
        long returncode = -1;
        try
        {
            LotManagement_BL lot_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = lot_BL.QMS_UpdatelotManufacturermasterDetails_BL(MacID, Manufacturemaster);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_UpdateLotVendorMaster", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DeviceManufacturer> QMS_LoadDevicesManufacturer(string status)
    {
        long returncode = -1;
        List<DeviceManufacturer> obj = new List<DeviceManufacturer>();
        try
        {
            LotManagement_BL Obj_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadDevicesManufacturer_BL(status, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadDevicesManufacturer ", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<LotVendorMaster> QMS_LoadVendorMaster(string status)
    {
        long returncode = -1;
        List<LotVendorMaster> obj = new List<LotVendorMaster>();
        try
        {
            LotManagement_BL Obj_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadVendorMaster_BL(status, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadVendorMaster ", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> QMS_LoadAnalyteMaster(string status)
    {
        long returncode = -1;
        List<InvInstrumentMaster> obj = new List<InvInstrumentMaster>();
        //List<InvInstrumentMaster> obj = new List<InvInstrumentMaster>();
        
        try
        {
            LotManagement_BL Obj_BL = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadAnalyteMaster_BL(status, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadAnalyteMaster ", e);

        }
        return obj;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_SaveLotManagement(List<LotMaster> LotMaster, int[] AnalyteID, string[] AnalyteName, string LevelID)
    {
        long returncode = -1;

        try
        {

            LotManagement_BL obj = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.SaveLotManagement_BL(LotMaster, AnalyteID, AnalyteName, LevelID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadLotMasterDetails()
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();

        LotManagement_BL bl = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.QMS_pGetLoadLotdetailsCommand_BL(out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading LoadLotMasterDetails Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_SaveQcValues(List<QcValueDetails> QCAnalyzerMapping)
    {
        long returncode = -1;

        try
        {
            AnalyzerMapping_BL obj = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_SaveQcValues_BL(QCAnalyzerMapping);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<QcValueDetails> QMS_LoadAnalyteForAnalyzer(long InstrumentID, string Time, long Level)
    {
        long returncode = -1;
        List<QcValueDetails> obj = new List<QcValueDetails>();
        try
        {
            DateTime dTime = Convert.ToDateTime(Time);
            AnalyzerMapping_BL Obj_BL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadAnalyteForAnalyzer_BL(InstrumentID, dTime, Level, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadAnalyte_ASMX ", e);

        }
        return obj;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> QMS_AnalyzerAutoComplete(string Status, string prefixText)
    {
        long returncode = -1;
        List<InvInstrumentMaster> obj = new List<InvInstrumentMaster>();
        try
        {
            AnalyzerMapping_BL Obj_BL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.QMS_LoadDevicesAutoComplete_BL(Status, prefixText, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_LoadDevices_ASMX ", e);

        }
        return obj;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_UpdateLotManagement(List<LotMaster> LotMaster, int[] AnalyteID, string[] AnalyteName,string LevelID)
    {
        long returncode = -1;

        try
        {

            LotManagement_BL obj = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.UpdateLotManagement_BL(LotMaster, AnalyteID, AnalyteName, LevelID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_DeletelotmasterDetails(int LotID)
    {
        long returncode = -1;

        try
        {

            LotManagement_BL obj = new LotManagement_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_Deletelotmaster_BL(LotID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_DeletelotmasterDetails", e);
        }
        return returncode;
    }
  [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DropDownKeyValue> QMS_LoadCascadingDDL(string Value, string CtrlName)
    {


        long returncode = -1;
        List<DropDownKeyValue> _lstKeyVAlue = new List<DropDownKeyValue>();
        try
        {
            InternalQualityControl_BL Obj_BL = new InternalQualityControl_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.GetQMSAutoComp_BL(Value, CtrlName, out _lstKeyVAlue);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error While Executing Methode  QMS_LoadCascadingDDL In QMS Webservice", e);
        }

        return _lstKeyVAlue;
    }





    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> QMS_LJChartFilter(int LocationID, int InstrumentID,int LotID, int AnalyteID, string Level, string FromDate, string ToDate)
    {
       

        long returncode = -1;
        List<InternalQualityControl> _lstIQC = new List<InternalQualityControl>();
         List<QCMedanSD> lstMeanSD = new List<QCMedanSD>();
        List<object> _lstObject = new List<object>();
        List<LJChartValue> _lstLJPlot = new List<LJChartValue>();
        string _strLJPlot = "";
      
        try
        {
            InternalQualityControl_BL Obj_BL = new InternalQualityControl_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.LoadQCLJChartDetails_BL(LocationID, InstrumentID,LotID, AnalyteID, Level, FromDate, ToDate, out _lstIQC, out lstMeanSD, out _strLJPlot, out _lstLJPlot);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error While Executing Methode  QMS_LJChartFilter In QMS Webservice", e);
        }
        _lstObject.Add(_lstIQC);
        _lstObject.Add(lstMeanSD);
        _lstObject.Add(_strLJPlot);
        _lstObject.Add(_lstLJPlot);

        return _lstObject;
      
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> QMS_LJComparisonChartFilter(int LocationID, int InstrumentID, int LotID, int AnalyteID, string Level, string FromDate, string ToDate)
    {
        long returncode = -1;
        List<InternalQualityControl> _lstIQC = new List<InternalQualityControl>();
        List<QCMedanSD> lstMeanSD = new List<QCMedanSD>();
        List<object> _lstObject = new List<object>();
        List<LJChartValue> _lstLJPlot = new List<LJChartValue>();
        string _strLJOneChart = string.Empty;
        string _strLJTwoChart = string.Empty;
        string _strLJThreeChart = string.Empty;

        try
        {
            InternalQualityControl_BL Obj_BL = new InternalQualityControl_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.LoadQCLJComparisonChartDetails_BL(LocationID, InstrumentID, LotID, AnalyteID, Level, FromDate, ToDate, out _strLJOneChart, out _strLJTwoChart, out _strLJThreeChart);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error While Executing Methode  QMS_LJComparisonChartFilter In QMS Webservice", e);
        }
        _lstObject.Add(_strLJOneChart);
        _lstObject.Add(_strLJTwoChart);
        _lstObject.Add(_strLJThreeChart);

        return _lstObject;

    }





    #endregion

[WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetAnalyteMasterDetails(String orgID,int InvID)
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();

        AnalyteMasterBL bl = new AnalyteMasterBL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            int OrgID = Convert.ToInt32(orgID);
            returnCode = bl.pGetAnalyteMasterDetails(OrgID,InvID, out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Analyzer Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }

     [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long pUpdateAnalyteMasrer(long pOrgID, string pAnalyteName, long pDepatmentID, long pContatinerID, string pResultValueType, long pSampleID,
    string pDecimalPlaces, long pMethodID, long pPrincipleID, string pClassfication, int pCutOffTimeValue, string pCutOffTimeType, string pIsActive, string pIsNABL, long InvestigationID)
    {
        long returnCode = -1;

        AnalyteMasterBL objAnalyteMasterBL = new AnalyteMasterBL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        returnCode = objAnalyteMasterBL.pUpdateAnalyteMasterDetails(pOrgID, pAnalyteName, pDepatmentID, pContatinerID, pResultValueType, pSampleID, pDecimalPlaces,
                   pMethodID, pPrincipleID, pClassfication, pCutOffTimeValue, pCutOffTimeType, pIsActive, pIsNABL, InvestigationID);
        return returnCode;
    }
   
    #region Rule Master By Rajkumar
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetLotDetails(int orgId)
    {
        long returncode = -1;
        
        List<LotDeatail> levelItems = new List<LotDeatail>();
        List<LotDeatail> lotDetail = new List<LotDeatail>();
        ArrayList aList = new ArrayList();
        try
        {
            QCRuleMaster_BL obj = new QCRuleMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            
            returncode = obj.GetLotDetails(orgId, out lotDetail);
            levelItems = (from litems in lotDetail select litems).Distinct().ToList();
            aList.Add(lotDetail);
            aList.Add(levelItems);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in GetLotDetails", e);
        }
        return aList;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<QCRuleMaster> GetRuleMasters(int orgId, long LotId, long InvId,long QCLevelID)
    {
        List<QCRuleMaster> LotMasterList = new List<QCRuleMaster>();
        long returncode = -1;
        try
        {
            QCRuleMaster_BL obj = new QCRuleMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.GetRuleMasters(orgId, LotId, InvId, QCLevelID,out LotMasterList);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in GetRuleMasters", e);
        }
        return LotMasterList;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveQcRuleMaster(long LotId, long Analyte, string ManufacturerRefRange, string ManufacturerMean, int Run, string LabRefRange, decimal LabMean, decimal LabSD, string LJChartCalc, long OrgId, long CreatedBy, string CreatedAt, long ModifiedBy, string ModifiedAt,long QCLevelID,string QCLevel)
    {
        
        List<QCRuleMaster> LotMasterList = new List<QCRuleMaster>();

        DateTime CreatedOn = DateTime.Now;
        DateTime ModifiedOn = DateTime.Now;
        long returncode = -1;
        try
        {
            QCRuleMaster_BL obj = new QCRuleMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.SaveQcRuleMaster(LotId, Analyte, ManufacturerRefRange, ManufacturerMean, Run, LabRefRange, LabMean, LabSD, LJChartCalc, OrgId, CreatedBy, CreatedOn, ModifiedBy, ModifiedOn,QCLevelID ,QCLevel );
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing  GetRuleMasters(QMS.asmx)", e);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long UpdateQcRuleMaster(long QCRID, long LotId, long Analyte, string ManufacturerRefRange, string ManufacturerMean, int Run, string LabRefRange, decimal LabMean, decimal LabSD, string LJChartCalc, long OrgId)
    {
        long returncode = -1;
        QCRuleMaster_BL obj = new QCRuleMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        try
        {
            returncode = obj.UpdateQcRuleMaster(QCRID, LotId, Analyte, ManufacturerRefRange, ManufacturerMean, Run, LabRefRange, LabMean, LabSD, LJChartCalc, OrgId);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While UpdateQcRuleMaster (QMS.asmx)", ex);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long DeleteRuleMaster(long QCRID)
    {
        long returncode = -1;
        QCRuleMaster_BL Obj_BL;
        try
        {
            Obj_BL = new QCRuleMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            Obj_BL.DeleteRuleMaster(QCRID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing  DeleteRuleMaster(QMS.asmx)", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string CheckDeviceID(string DeviceID)
    {


        string status = "";
        long returncode = -1;
        try
        {
            AnalyzerMaster_BL ObjBAL = new AnalyzerMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = ObjBAL.CheckDeviceID(DeviceID, out status);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in CheckDeviceID", e);
        }

        return status;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string CheckTextCode(string DeviceID, string Testcode)
    {


        string status = "";
        long returncode = -1;
        try
        {
            AnalyzerMapping_BL ObjBAL = new AnalyzerMapping_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = ObjBAL.CheckTestcode(DeviceID, Testcode, out status);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in CheckTextCode", e);
        }

        return status;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] LoadDepartmentInvestigation(int DeptID, string Type, int VendorID, string PDate)
    {
        long returnCode = -1;
        object[] arr = new object[2];
        DataSet dtDeviceValueReport = new DataSet();
        DateTime ProcessingDateTime = DateTime.Parse(PDate);
        EQAMaster_BL bl = new EQAMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        List<Dictionary<string, object>> rows1 = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            returnCode = bl.LoadDeptInvestigation(DeptID, Type, VendorID, ProcessingDateTime, out dtDeviceValueReport);

            
            foreach (DataRow dr in dtDeviceValueReport.Tables[0].Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Tables[0].Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            arr[0] = serializer.Serialize(rows);
            arr[1] = "";
            if (dtDeviceValueReport.Tables.Count > 1)
            {
                arr[1] = Convert.ToString(dtDeviceValueReport.Tables[1].Rows[0][0]);
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Analyzer Data", ex);
        }
        return arr;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] QMS_SaveInternalExternalQualityValues(List<InternalExternalQuality> InternalExternalQuality, List<EQAMaster> SaveEQAMaster)
    {
        long returncode = -1;
        long QAID = -1;
        object[] arr = new object[2];       
        try
        {
            EQAMaster_BL obj = new EQAMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.SaveInternalExternalQualityValues(InternalExternalQuality, SaveEQAMaster, out QAID);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveInternalExternalQualityValues", e);
        }
        arr[0] = returncode;
        arr[1] = QAID;
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long DeleteInternalExternalQualityValue(long ValId)
    {
        long returncode = -1;
        EQAMaster_BL Obj_BL;
        try
        {
            Obj_BL = new EQAMaster_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            Obj_BL.DeleteInternalExternalQualityValue(ValId);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing  DeleteInternalExternalQualityValue(QMS.asmx)", e);
        }
        return returncode;
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long PNCSave(int orgID, PNCDetails PNC)
    {
        long returncode = -1;

        try
        {
            PNC_BL Obj_BL = new PNC_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.ProcessNonConformance_BL(orgID, PNC);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing  PNCSave(QMS.asmx)", e);
        }
        return returncode;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> GetPNCList(int orgID)
    {
        long returncode = -1;
        long PNCNO = -1;
        List<object> _lstObject = new List<object>();
        List<PNCDetails> PNCList = new List<PNCDetails>();
        try
        {
            PNC_BL Obj_BL = new PNC_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = Obj_BL.GetPNCDetails(orgID, out PNCList, out  PNCNO);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing  PNCSave(QMS.asmx)", e);
        }

        _lstObject.Add(PNCList);
        _lstObject.Add(PNCNO);
        return _lstObject;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_UpdateLJchartValues(List<LJChartValue> LJChartValue)
    {
        long returncode = -1;

        try
        {
            InternalQualityControl_BL obj = new InternalQualityControl_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.QMS_UpdateLJchartValues_BL(LJChartValue);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_Filemanager_Delete(string [] Filedata )
    {
        long returncode = -1;

        try
        {
            List<QMS_TRFfilemanager> lstFM = new List<QMS_TRFfilemanager>();
            foreach (string file in Filedata)
            {

                QMS_TRFfilemanager objFm = new QMS_TRFfilemanager();

                string[] data = file.Split('~');
                objFm.FileID = Convert.ToInt64(data[6]);
                objFm.FilePath = data[5];
                objFm.FileType = data[2];
                objFm.IdentifyingType = data[1];
                objFm.IdentifyingID = data[3];
                objFm.FileName = data[7];
                objFm.IsDelete = data[4];

                if (!File.Exists(data[0] + data[5]))
                {
                    File.Delete(data[0] + data[5]);
                }
                lstFM.Add(objFm); 
                
            }
            Filemanager_BL objFIleManager = new Filemanager_BL(new Attune.Solution.QMSBasecClassConvert.QMS_Integration(new BaseClass().ContextInfo).returnContext);
            if (lstFM.Count > 0)
            {
                objFIleManager.SaveFile_BL(lstFM);
            }

        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DropDownKeyValue> pgetGeneralStatistics(string year, int month)
    {


        long returncode = -1;
        List<DropDownKeyValue> _lstKeyVAlue = new List<DropDownKeyValue>();
        try
        {
          QMS_Dashboard_BL   Obj_BL = new QMS_Dashboard_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
          returncode = Obj_BL.pgetGeneralStatistics(year, month, out _lstKeyVAlue);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error While Executing Method  pgetGeneralStatisticss In QMS Webservice", e);
        }

        return _lstKeyVAlue;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long QMS_SetSession(string[][] SessionVal)
    {
        long returncode = -1;

        try
        {
            foreach (string[] arr in SessionVal)
            {
                string sessionName = arr[0];
                string sessionVal = arr[1];

                Session.Add(sessionName, sessionVal);
            
            }

        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return returncode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] SaveQcPlanAndSchedule(string ActionType, List<PlanScheduleDetails_QMS> plans)
    {
        List<PlanScheduleDetails_QMS> objLst = new List<PlanScheduleDetails_QMS>();
        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[2]; 
        try
        {
           
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                objLst = objBl.SavePlanAndSchedule_BL(ActionType, plans);
                arr[0] = objLst;
           

        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] LoadQcPlanAndSchedule(string ActionType, List<PlanScheduleDetails_QMS> plans)
    {
        List<PlanScheduleDetails_QMS> objLst = new List<PlanScheduleDetails_QMS>();
        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[2];
        try
        {
          //  if (ActionType == "S")
          //  {
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                ds = objBl.GetPlanAndSchedule_BL(ActionType, plans);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                arr[0] = rows;
          //  }
         

        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] InternalAuditObservation(string ActionType, InternalAuditObersation_QMS observations)
    {
        
        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[1];
        long returnCode = -1;
        try
        {

            if (ActionType == "S")
            {
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                ds = objBl.GetInternalAuditObervation(observations.InternalAuditID, observations.PlanScheduleID, observations.AuditType, observations.Observation, observations.Category, ActionType);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                arr[0] = rows;
            }
            else {
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                returnCode = objBl.SaveInternalAuditObervation(observations.InternalAuditID, observations.PlanScheduleID, observations.AuditType, observations.Observation, observations.Category, ActionType);
                arr[0] = returnCode;
            }


        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] InternalAuditNCs(string ActionType, InternalAuditNC_QMS ncs)
    {

        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[1];
        long returnCode = -1;
        try
        {

            if (ActionType == "S" || ActionType == "P")
            {
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                ds = objBl.GetInternalAuditNCs(ncs.InternalAuditNCID, ncs.OrgID, ncs.PlanScheduleID, ncs.NABLClause,ncs. ISOClause,
                    ncs.NCNO, ncs.Description,ncs. Classification,ncs. ActivityAssesed
                     , ncs.ProposedAction, ncs.ActionTaken, ncs.CompletionDate, ncs.ActionVerified, ncs.Comments, ncs.Status,
                     ActionType);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                arr[0] = rows;
            }
            else
            {
                PlanAndScheduleQMS_BL objBl = new PlanAndScheduleQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
                returnCode =objBl.SaveInternalAuditNCs(ncs.InternalAuditNCID, ncs.OrgID, ncs.PlanScheduleID, ncs.NABLClause, ncs.ISOClause,
                    ncs.NCNO, ncs.Description, ncs.Classification, ncs.ActivityAssesed
                     , ncs.ProposedAction, ncs.ActionTaken, ncs.CompletionDate, ncs.ActionVerified, ncs.Comments, ncs.Status,
                     ActionType);
                arr[0] = returnCode;
            }


        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveExternalAuditDetails(ExternalAudit_QMS lstExAudit , string ActionType)
    {

        List<ExternalAudit_QMS> objPs = new List<ExternalAudit_QMS>();
        long returncode = -1;
        long ANo = -1;
        try
        {
            ExternalAudit_BL objDal = new ExternalAudit_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            objPs = objDal.SaveExternalAuditDetails(lstExAudit.OrgID, lstExAudit.AddressID, lstExAudit.FromDate, lstExAudit.ToDate, lstExAudit.EnternalAuditID, lstExAudit.AuditAgency, lstExAudit.MajorNC, lstExAudit.MinorNC, lstExAudit.AuditorsList, lstExAudit.DeptID, lstExAudit.Status, ActionType, out ANo);

        }
        catch (Exception e)
        {
            CLogger.LogError("Error while loading in pgetGeneralStatistics_DAL", e);
        }
        return ANo;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] LoadExternalAuditDetails(ExternalAudit_QMS lstExAudit, string ActionType)
    {

        
        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[2];
        long returncode = -1;

        try
        {
            ExternalAudit_BL objDal = new ExternalAudit_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            ds = objDal.LoadExternalAuditDetails(lstExAudit.OrgID, lstExAudit.AddressID, lstExAudit.FromDate, lstExAudit.ToDate, lstExAudit.EnternalAuditID, lstExAudit.AuditAgency, lstExAudit.MajorNC, lstExAudit.MinorNC, lstExAudit.AuditorsList, lstExAudit.DeptID,lstExAudit.Status, ActionType);
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in ds.Tables[0].Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            arr[0] = rows;
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while loading in pgetGeneralStatistics_DAL", e);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> QMS_GetTrainingProgramDetails(long ScheduledID)
    {
        long returncode = -1;
        List<PlanScheduleDetails_QMS> ResultPlanDetails = new List<PlanScheduleDetails_QMS>();
        List<Trainingprogramscustoms> Details = new List<Trainingprogramscustoms>();
        List<object> ResultList = new List<object>();
        try
        {
            TrainingProgram_BL ObjBL = new TrainingProgram_BL(new Attune.Solution.QMSBasecClassConvert.QMS_Integration(new BaseClass().ContextInfo).returnContext);
            ObjBL.GetTrainingProgramDetails_BL(ScheduledID, out ResultPlanDetails, out Details);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_GetTrainingProgramFields", e);
        }
        ResultList.Add(ResultPlanDetails);
        ResultList.Add(Details);
        return ResultList;
    }


    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<object> QMS_GetTrainingProgramFilter(PlanScheduleDetails_QMS PlanAndSchedule)
    //{
    //    long returncode = -1;
    //    List<PlanScheduleDetails_QMS> ResultPlanDetails = new List<PlanScheduleDetails_QMS>();
    //    List<object> ResultList = new List<object>();
    //    try
    //    {
    //        TrainingProgram_BL ObjBL = new TrainingProgram_BL(new Attune.Solution.QMSBasecClassConvert.QMS_Integration(new BaseClass().ContextInfo).returnContext);

    //        returncode = ObjBL.GetTrainingProgramFilters_BL(PlanAndSchedule, out ResultPlanDetails);

    //    }
    //    catch (Exception e)
    //    {
    //        CLogger.LogError("Error while executing in QMS_GetTrainingProgramFields", e);
    //    }
    //    ResultList.Add(ResultPlanDetails);
    //    return ResultList;
    //}


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> SaveTrainingProgramDetails(List<TrainingProgram_QMS> QCAnalyzerMapping, long ScheduleID, string Type)
    {
        long returncode = -1;

        List<object> ResultList = new List<object>();
        List<Trainingprogramscustoms> Details = new List<Trainingprogramscustoms>();

        try
        {
            TrainingProgram_BL obj = new TrainingProgram_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.SaveTrainingProgramDetails(QCAnalyzerMapping, ScheduleID, Type, out Details);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        ResultList.Add(Details);
        return ResultList;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long DeleteTrainingProgramDetails(long TrainingProgramID, long PlanScheduleID, int Orgid, string Type)
    {
        long returncode = -1;


        try
        {
            TrainingProgram_BL obj = new TrainingProgram_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.DeleteTrainingProgramDetails(TrainingProgramID, PlanScheduleID, Orgid, Type);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }

        return returncode;
    }

        [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object GetEntity(object t )
    {
        object entity = new object();

        //object ob = System.Reflection.Assembly.GetExecutingAssembly().CreateInstance("Attune.Solution.QMSBusinessEntities.PlanAndSchedule_QMS");
        if (Convert.ToString(t) == "PlanScheduleDetails_QMS")
        {
            PlanScheduleDetails_QMS obj = new PlanScheduleDetails_QMS();
            entity = obj;
        }
        else if (Convert.ToString(t) == "ExternalAudit_QMS")
        {
            ExternalAudit_QMS obj = new ExternalAudit_QMS();
            entity = obj;
        }

        return entity;
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> LoadMRMDetails(List<ScheduledMOM> list,string Type)
    {
        long returncode = -1;

        List<object> ResultList = new List<object>();
        List<ScheduledMOMCustom> Details = new List<ScheduledMOMCustom>();

        try
        {
            TrainingProgram_BL obj = new TrainingProgram_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
            returncode = obj.LoadMRMDetails(list, Type, out Details);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in QMS_SaveAnalyzermappingDetails", e);
        }
        ResultList.Add(Details);
        return ResultList;
    }
    #endregion

    #region QC Result
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQCResultSearchValues(string prefixText, int count, string contextKey)
    {
        long returncode = -1;
        List<CodingScheme> lstCodeMapper = new List<CodingScheme>();
        List<string> items = new List<string>();
        DeviceQMS_BL objbl = new DeviceQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        try
        {
            string[] param = contextKey.Split('~');
            Int32 orgID = param[0] != null ? Convert.ToInt32(param[0]) : 0;
            String pType = param[1] != null ? param[1] : string.Empty;
            returncode = objbl.GetQCResultSearchValues(orgID, pType, prefixText, out lstCodeMapper);
            if (lstCodeMapper.Count > 0)
            {
                foreach (CodingScheme item in lstCodeMapper)
                {
                    if (pType == "")
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.CodeName, item.IdentifyingID.ToString() + ":" + item.IsPrimary.ToString() + ":" + item.IdentifyingType.ToString()));
                    }
                    else
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.CodeName, item.IdentifyingID.ToString() + ":" + item.IsPrimary.ToString()));
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetTestCodingScheme: ", ex);
        }
        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetQCResultDetails(string pOrgID, string pInstrumentID, string pInvestigationID, string pLotID, string pFromDate, string pToDate)
    {
        long returnCode = -1;
        DataTable dtDeviceValueReport = new DataTable();

        DeviceQMS_BL bl = new DeviceQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            int OrgID = Convert.ToInt32(pOrgID);
            Int64 InstrumentID = !string.IsNullOrEmpty(pInstrumentID) ? Convert.ToInt64(pInstrumentID) : 0;
            Int64 InvestigationID = !string.IsNullOrEmpty(pInvestigationID) ? Convert.ToInt64(pInvestigationID) : 0;
            Int64 LotID = !string.IsNullOrEmpty(pLotID) ? Convert.ToInt64(pLotID) : 0;
            returnCode = bl.GetQCResultDetails(OrgID, InstrumentID, InvestigationID, LotID, Convert.ToDateTime(pFromDate), Convert.ToDateTime(pToDate), out dtDeviceValueReport);

            foreach (DataRow dr in dtDeviceValueReport.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtDeviceValueReport.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading QCResultDetails Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetQCLabMeanDetails(string pOrgID, string pInstrumentID, string pInvestigationID, string pLotID)
    {
        long returnCode = -1;
        DataTable dtQCLabMean = new DataTable();

        DeviceQMS_BL bl = new DeviceQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            int OrgID = Convert.ToInt32(pOrgID);
            Int64 InstrumentID = !string.IsNullOrEmpty(pInstrumentID) ? Convert.ToInt64(pInstrumentID) : 0;
            Int64 InvestigationID = !string.IsNullOrEmpty(pInvestigationID) ? Convert.ToInt64(pInvestigationID) : 0;
            Int64 LotID = !string.IsNullOrEmpty(pLotID) ? Convert.ToInt64(pLotID) : 0;
            returnCode = bl.GetQCLabMeanDetails(OrgID, InstrumentID, InvestigationID, LotID, out dtQCLabMean);

            foreach (DataRow dr in dtQCLabMean.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtQCLabMean.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading QCResultDetails Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetFloatingMeanDetails(string pOrgID, string pInstrumentID, string pInvestigationID, string pLotID, string pFromDate, string pToDate, string pfmOption)
    {
        long returnCode = -1;
        DataTable dtQCLabMean = new DataTable();

        DeviceQMS_BL bl = new DeviceQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            int OrgID = Convert.ToInt32(pOrgID);
            Int64 InstrumentID = !string.IsNullOrEmpty(pInstrumentID) ? Convert.ToInt64(pInstrumentID) : 0;
            Int64 InvestigationID = !string.IsNullOrEmpty(pInvestigationID) ? Convert.ToInt64(pInvestigationID) : 0;
            Int64 LotID = !string.IsNullOrEmpty(pLotID) ? Convert.ToInt64(pLotID) : 0;
            Int32 fmOption = !string.IsNullOrEmpty(pfmOption) ? Convert.ToInt32(pfmOption) : 0;
            returnCode = bl.GetFloatingMeanDetails(OrgID, InstrumentID, InvestigationID, LotID, Convert.ToDateTime(pFromDate), Convert.ToDateTime(pToDate), fmOption, out dtQCLabMean);

            foreach (DataRow dr in dtQCLabMean.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtQCLabMean.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading QCResultDetails Data", ex);
        }
        serializer.MaxJsonLength = int.MaxValue; return serializer.Serialize(rows);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveQCEvaluvationsDetails(List<QCEvaluvationsDetails> lstEvaluvations)
    {
        long returnCode = -1;
        DeviceQMS_BL bl = new DeviceQMS_BL(new QMS_Integration(new BaseClass().ContextInfo).returnContext);
        try
        {
            returnCode = bl.SaveQCEvaluvationsDetails(lstEvaluvations);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save in SaveQCEvaluvationsDetails", ex);
        }
        return returnCode;
    }
    #endregion
    
}

