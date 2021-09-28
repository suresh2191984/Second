using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Data;
/// <summary>
/// Summary description for MemberService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class MemberService : System.Web.Services.WebService
{

    public MemberService()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public string[] GetPatientList(string prefixText, int searchID, string contextKey)
    {
        List<Patient> templstPatient = new List<Patient>();
        List<Patient> lstPatient = new List<Patient>();
        string[] PatientList = null;
        //try
        //{
        //    Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
        //    long retCode = -1;
        //    int orgID = 0;

        //    string[] searchcategory = contextKey.Split('-');
        //   // Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        //    retCode = ofamilyBL.GetPatientName(orgID, prefixText, int.Parse(searchcategory[0]), 0, "StartWith", out templstPatient);
        //    if (searchcategory[1] == "popup")
        //    {
        //        lstPatient = (from l in templstPatient
        //                      where l.Comments != "0"
        //                      select l).ToList();

        //    }
        //    else

        //    { lstPatient = templstPatient; }
        //    if (lstPatient.Count > 0)
        //    {
        //        PatientList = new string[lstPatient.Count];
        //        for (int i = 0; i < lstPatient.Count; i++)
        //        {
        //            if (searchID == 1)
        //            {
        //                PatientList[i] = lstPatient[i].Name;
        //            }
        //            if (searchID == 7)
        //            {
        //                PatientList[i] = lstPatient[i].MobileNumber;
        //            }
        //            //}
        //            //if (searchcategory[1] == "7")
        //            //{
        //            //    PatientList[i] = lstPatient[i].LandLineNumber;
        //            //}
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in GetPatientName: ", ex);
        //}
        return PatientList.ToArray();
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<AreaMaster> GetVillageList(int AreaTypeID, int scID, long userID, long LID, int AreaID)
    //{
    //    long retCode = -1;
    //    List<AreaMaster> lstVillage = new List<AreaMaster>();
    //    Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
    //    try
    //    {
    //        retCode = ofamilyBL.GetVillageList(AreaTypeID, scID, userID, LID, AreaID, out lstVillage);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in GetVillageList: ", ex);
    //    }
    //    return lstVillage;
    //}

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Data> GetCHC(string strOrgID, string type)
    {
        List<Data> lstData = new List<Data>();
        try
        {
            int OrgID = Int32.Parse(strOrgID);
            int Type = Int32.Parse(type);
            long returnCode = -1;
            Referrals_BL objReferrals_BL = new Referrals_BL();
          //  returnCode = objReferrals_BL.GetInBoundChart(OrgID, Type, "CHC", out lstData);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInBoundChart: ", ex);
        }
        return lstData;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Data> GetPHC(string strOrgID, string type)
    {
        List<Data> lstData = new List<Data>();
        try
        {
            int OrgID = Int32.Parse(strOrgID);
            int Type = Int32.Parse(type);
            long returnCode = -1;
            Referrals_BL objReferrals_BL = new Referrals_BL();
            //returnCode = objReferrals_BL.GetInBoundChart(OrgID, Type, "PHC", out lstData);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInBoundChart: ", ex);
        }
        return lstData;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Data> GetSC(string strOrgID, string type)
    {
        List<Data> lstData = new List<Data>();
        try
        {
            int OrgID = Int32.Parse(strOrgID);
            int Type = Int32.Parse(type);
            long returnCode = -1;
            Referrals_BL objReferrals_BL = new Referrals_BL();
            //returnCode = objReferrals_BL.GetInBoundChart(OrgID, Type, "SC", out lstData);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInBoundChart: ", ex);
        }
        return lstData;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public long RemoveMember(int pOrgID, long pMemID, long pFamID, long pUID, long pReasonID, string pReason, long pLID, string pUHNO, string pOther,DateTime RemovalDate)
    {
        long retCode = -1;
        long pRemoveID = -1;
        ContextDetails globalContextDetails = new ContextDetails();
        //Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
        //try
        //{

        //    retCode = ofamilyBL.RemoveMember(pOrgID, pMemID, pFamID, pUID, pReasonID, pReason, pLID, pUHNO, pOther,RemovalDate, out pRemoveID, globalContextDetails);

        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in RemoveMember: ", ex);
        //}
        return pRemoveID;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Users> GetUserList(int OrgID, int AreaID, long LoginID, long UserID, string Type)
    {
        long retCode = -1;
        List<List<Users>> mainlist=new List<List<Users>>();
        List<Users> lstUser = new List<Users>();
        
        //Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
        //try
        //{
        //    retCode = ofamilyBL.GetUserList(OrgID, AreaID, LoginID, UserID, Type,out lstUser);
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in GetUserList: ", ex);
        //}
        return lstUser;
    }
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public long IsExistValue(int OrgID, int pSearchTypeID, string pSearchType, string pSearchValue, int pAreaID, string FamilyID)
    {
        long pOut = 0;
        int pOrgID = OrgID;
        int pFamilyID = int.Parse(FamilyID);
        long returnCode = -1;
        //Family_BL objBL = new Family_BL();
        //try
        //{
        //    if (pSearchTypeID != 11)
        //    {
        //        returnCode = objBL.IsExistValue(pOrgID, pSearchTypeID, pSearchType, pSearchValue, pAreaID, pFamilyID, out pOut);
        //    }
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in IsExistValue: ", ex);
        //}
        return pOut;// public long 
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public string[] SearchVillage(int OrgID, string VillageName, string MatchType, string Limit)
    {
        List<string> villages = new List<string>();
        //List<AreaMaster> Village = new List<AreaMaster>();
        //List<AreaMaster> lstVillage = new List<AreaMaster>();
        //long returncode = -1;
        //Family_BL objBL = new Family_BL();
        //int LSize = 0;
        //try
        //{
        //    if (string.IsNullOrEmpty(VillageName))
        //    {
        //        VillageName = "0";
        //    }
        //    if (string.IsNullOrEmpty(Limit))
        //    {
        //        LSize = 10;
        //    }
        //    else
        //    {
        //        LSize = Convert.ToInt32(Limit);
        //    }
        //    if (string.IsNullOrEmpty(MatchType))
        //    {
        //        MatchType = "StartWith";
        //    }
        //    returncode = objBL.SearchVillageList(OrgID, VillageName, MatchType, LSize, out lstVillage);
        //    Village = (from l in lstVillage
        //               select new AreaMaster
        //               {
        //                   AreaName = l.AreaName,
        //                   AreaID = l.AreaID,
        //                   AreaCode = l.AreaCode,
        //                   Pincode = l.Pincode
        //               }).ToList();
        //    foreach (var i in Village)
        //    {
        //        villages.Add(string.Format("{0}-{1}", i.AreaName, i.AreaID));
        //    }

        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error While GetVillageList in Service", ex);
        //}

        return villages.ToArray();
    }
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Organization> GetOrgCategoriesList(int pOrgID, int pOCategoryID, int pSeqID, string pOrgCategory, long pUserID)
    {
        long retCode = -1;
        List<Organization> lstOrgCategory = new List<Organization>();
        //Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
        //try
        //{
        //    retCode = ofamilyBL.GetOrgCategoriesList(pOrgID, pOCategoryID, pSeqID, pOrgCategory, pUserID, out lstOrgCategory);
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in GetOrgCategoriesList: ", ex);
        //}
        return lstOrgCategory;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<Organization> GetOrgByCategory(int pOrgID, int pOCategoryID, int pSeqID, string pOrgCategory, long pUserID)
    {
        long retCode = -1;
        List<Organization> lstOrgCategory = new List<Organization>();
        //Family_BL ofamilyBL = new Family_BL(new BaseClass().ContextInfo);
        //try
        //{
        //    retCode = ofamilyBL.GetOrgbyCategory(pOrgID, pOCategoryID, pSeqID, pOrgCategory, pUserID, out lstOrgCategory);
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in GetOrgByCategory: ", ex);
        //}
        return lstOrgCategory;
    }

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public long IsRoleAccessPageDetails(int RoleID, int OrgID, long LID, string Actioncode, int pageID, string Type, long PatientID, long VisitID, long TaskID)
    {
        long pOut = 0;
        int pOrgID = OrgID;
        string IsAuthorize = string.Empty;
        long ReturnCode = -1;
        try
        {

       //     ReturnCode = new GateWay(new BaseClass().ContextInfo).GetRoleAccessPageDetails(RoleID, OrgID, LID, Actioncode, pageID, Type, PatientID, VisitID, TaskID, out IsAuthorize);

            if (IsAuthorize == "" || IsAuthorize == "Y")
            {
                pOut = 1;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in IsRoleAccessPageDetails: Type " + Type, ex);
        }
        return pOut;// public long 
    }
//[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public List<PasswordPolicy> GetPasswordPolicyService(int OrgID)
    {
        long retCode = -1;
        List<PasswordPolicy> lstpwdplcy = new List<PasswordPolicy>();
        Users_BL User_Bl = new Users_BL(new BaseClass().ContextInfo);
        try
        {
            retCode = User_Bl.GetPasswordpolicy(OrgID, out lstpwdplcy);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPasswordPolicyService: ", ex);
        }
        return lstpwdplcy;
    }

// SearchVillageList For Autocomplete in Patient Registration

//[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
public string[] SearchParentVillage(int OrgID, int ParentOrgID, string VillageName, long LoginID, string MatchType, string Limit)
{
    List<string> villages = new List<string>();
    //List<AreaMaster> Village = new List<AreaMaster>();
    //List<AreaMaster> lstVillage = new List<AreaMaster>();
    //long returncode = -1;
    //Family_BL objBL = new Family_BL();
    //int LSize = 0;
    //try
    //{
    //    if (string.IsNullOrEmpty(VillageName))
    //    {
    //        VillageName = "0";
    //    }
    //    if (string.IsNullOrEmpty(Limit))
    //    {
    //        LSize = 10;
    //    }
    //    else
    //    {
    //        LSize = Convert.ToInt32(Limit);
    //    }
    //    if (string.IsNullOrEmpty(MatchType))
    //    {
    //        MatchType = "StartWith";
    //    }
    //    returncode = objBL.GetParentVillageList(OrgID, ParentOrgID, VillageName, LoginID, MatchType, LSize, out lstVillage);
    //    Village = (from l in lstVillage
    //               select new AreaMaster
    //               {
    //                   AreaName = l.AreaName,
    //                   AreaID = l.AreaID,
    //                   AreaCode = l.AreaCode,
    //                   Pincode = l.Pincode,
    //                   ParentAreaID = l.ParentAreaID
    //               }).ToList();
    //    foreach (var i in Village)
    //    {
    //        villages.Add(string.Format("{0}-{1}-{2}", i.AreaName, i.AreaID, i.ParentAreaID));
    //    }

    //}
    //catch (Exception ex)
    //{
    //    CLogger.LogError("Error While SearchParentVillage in Service", ex);
    //}

    return villages.ToArray();
}

}



